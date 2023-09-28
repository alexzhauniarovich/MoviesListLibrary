import SwiftUI

struct ActorDetailsViewData {
    let name: String?
    let biography: String?
    let actorImageUrl: URL?
}

public struct ActorDetailsView: View {
    
    // MARK: - Private fields
    
    @StateObject private var viewModel: ActorDetailsViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    // MARK: - Initialisation
    
    init(personId: Int, actorsUseCase: ActorsUseCaseType) {
        _viewModel = StateObject(wrappedValue: ActorDetailsViewModel(
            personId: personId,
            actorsUseCase: actorsUseCase
        ))
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    // MARK: - Layout
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack {
                // Actor image view
                AsyncImage(url: viewModel.actorDetails?.actorImageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 250, height: 250)
                        .padding(.top, 50)
                }
                .padding(.bottom, 18)
                
                // Actor name text view
                HStack {
                    Text(viewModel.actorDetails?.name ?? "")
                        .foregroundColor(.gray)
                        .font(.system(size: 24).weight(.bold))
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .padding(.bottom, 8)
                
                // Actor biography text view
                Text(viewModel.actorDetails?.biography ?? "")
                    .foregroundColor(.gray)
                    .font(.system(size: 15).weight(.semibold))
                    .padding(.horizontal, 16)
                    .padding(.bottom, 50)
                
                Spacer()
            }
        }
        .onAppear { viewModel.viewWillAppear() }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Back button view
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    ZStack {
                        Circle()
                            .background(Circle().foregroundColor(.black))
                            .frame(width: 32, height: 32)
                        
                        Image(systemName: "arrow.backward.circle.fill")
                            .resizable()
                            .frame(width: 34, height: 34)
                            .accentColor(.white)
                    }
                }
            }
        }
    }
}

struct ActorDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ActorDetailsView(
            personId: 1622590,
            actorsUseCase: ActorsUseCase(
                actorsRepository: ActorsRepository(
                    networkRequestManager: NetworkRequestManager(
                        networkRequestBuilder: NetworkRequestBuilder()
                    )
                )
            )
        )
    }
}
