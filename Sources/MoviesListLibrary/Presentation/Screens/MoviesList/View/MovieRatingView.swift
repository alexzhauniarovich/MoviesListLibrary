import SwiftUI

public struct MovieRatingView: View {
    
    // MARK: - Public fields
    
    @State var rating: String
    
    // MARK: - Layout
    
    public var body: some View {
        ZStack {
            // Background view
            Circle()
                .strokeBorder(.white, lineWidth: 3)
                .background(Circle().foregroundColor(.black))
                .frame(width: 50, height: 50)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
            
            // Rating text view
            Text(rating)
                .foregroundColor(.white)
                .font(.system(size: 18).weight(.heavy))
        }
    }
}
