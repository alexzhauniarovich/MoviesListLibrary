import SwiftUI

private enum Constants {
    static let avatarSize: CGFloat = 100
}

struct MovieActorViewData: Hashable {
    let actorId: Int
    let actorName: String
    let actorAvatar: URL?
}

public struct MovieActorView: View {
    
    @State var actorData: MovieActorViewData
    
    @State private var isShowingActorDetailsView = false
    
    public var body: some View {
        NavigationLink(
            destination: ActorDetailsView(
                personId: actorData.actorId,
                actorsUseCase: ActorsUseCase(
                    actorsRepository: ActorsRepository(
                        networkRequestManager: NetworkRequestManager(
                            networkRequestBuilder: NetworkRequestBuilder()
                        )
                    )
                )
            ),
            isActive: $isShowingActorDetailsView
        ) {
            VStack {
                AsyncImage(url: actorData.actorAvatar) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: Constants.avatarSize, height: Constants.avatarSize)
                }
                .overlay(
                    Circle()
                        .stroke(.gray, lineWidth: 6)
                        .frame(width: Constants.avatarSize, height: Constants.avatarSize)
                )
                .frame(width: Constants.avatarSize, height: Constants.avatarSize)
                .clipped()
                .clipShape(Circle())
                
                Text(actorData.actorName)
                    .foregroundColor(.black)
                    .font(.system(size: 12).weight(.heavy))
                    .padding(.bottom, 2)
            }
            .padding(.horizontal, 16)
            .onTapGesture { isShowingActorDetailsView = true }
        }
    }
}
