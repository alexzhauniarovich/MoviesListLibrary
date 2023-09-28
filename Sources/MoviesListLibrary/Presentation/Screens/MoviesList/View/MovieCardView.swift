import SwiftUI

private enum Constants {
    static let cornerRadiusActive: CGFloat = 16
    static let cornerRadiusRegular: CGFloat = 6
}

public struct MovieCardView: View {
    
    // MARK: - Public fields
    
    var position: Int = 0
    
    @Binding var currentPosition: Int
    
    @State var rating: String
    @State var imageUrl: URL?
    
    // MARK: - Layout
    
    public var body: some View {
        ZStack {
            // Movie poster view
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } placeholder: {
                Color.gray
            }
            .clipShape(
                RoundedRectangle(cornerSize: CGSize(
                    width: position == currentPosition ? Constants.cornerRadiusActive : Constants.cornerRadiusRegular,
                    height: position == currentPosition ? Constants.cornerRadiusActive : Constants.cornerRadiusRegular
                ))
            )
            .shadow(
                color: position == currentPosition ? .gray : .clear,
                radius: position == currentPosition ? Constants.cornerRadiusActive : Constants.cornerRadiusRegular,
                x: 0,
                y: 10
            )
            .padding(.top, 24)
            
            // Movie rating view
            if position == currentPosition {
                VStack {
                    HStack {
                        Spacer()
                        
                        MovieRatingView(rating: rating)
                            .padding(.trailing, -16)
                    }
                    Spacer()
                }
            }
        }
    }
}
