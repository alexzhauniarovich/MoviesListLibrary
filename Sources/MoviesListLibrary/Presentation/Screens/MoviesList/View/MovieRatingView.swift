import SwiftUI

public struct MovieRatingView: View {
    
    @State var rating: String
    
    public var body: some View {
        ZStack {
            Circle()
                .strokeBorder(.white, lineWidth: 3)
                .background(Circle().foregroundColor(.black))
                .frame(width: 50, height: 50)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
            
            Text(rating)
                .foregroundColor(.white)
                .font(
                    .system(size: 18)
                    .weight(.heavy)
                )
        }
    }
}

struct MovieRatingView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRatingView(rating: "8,1")
    }
}
