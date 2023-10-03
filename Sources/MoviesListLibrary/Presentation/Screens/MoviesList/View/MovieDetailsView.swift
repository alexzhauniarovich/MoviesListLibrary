import SwiftUI

struct MovieDetailsViewData {
    let movieParams: String
    let isPlayButtonVisible: Bool
    let isActorDetailsAvailable: Bool
    let trailerUrl: URL?
    let movieDescription: String
    let actors: [MovieActorViewData]?
}

public struct MovieDetailsView: View {
    
    // MARK: - Public fields
    
    @Binding var movieDetails: MovieDetailsViewData?
    
    // MARK: - Private fields
    
    @State private var isShowingVideoPlayerView = false
    
    // MARK: - Layout
    
    public var body: some View {
        if let movieDetails = movieDetails {
            VStack {
                // Movie description view
                Text(movieDetails.movieParams)
                    .foregroundColor(.gray)
                    .font(.system(size: 12).weight(.heavy))
                    .padding(.bottom, 16)
                
                Spacer()
                
                // Play trailer button view
                if movieDetails.isPlayButtonVisible {
                    NavigationLink(
                        destination: YouTubeView(videoUrl: movieDetails.trailerUrl),
                        isActive: $isShowingVideoPlayerView
                    ) {
                        Button(action: { isShowingVideoPlayerView = true }) {
                            HStack {
                                Image(systemName: "play.rectangle.fill")
                                    .resizable()
                                    .frame(width: 26, height: 22)
                                
                                Text("Watch trailer")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14).weight(.medium))
                            }
                        }
                        .padding(.horizontal, 26)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 6, x: 0, y: 3)
                    }
                }
                
                VStack {
                    // Overview title view
                    HStack {
                        Text("Overview")
                            .foregroundColor(.gray)
                            .font(.system(size: 24).weight(.medium))
                            .padding(.bottom, 2)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    // Overview description view
                    Text(movieDetails.movieDescription)
                        .foregroundColor(.gray)
                        .font(.system(size: 14).weight(.semibold))
                        .padding(.horizontal, 16)
                    
                    Spacer()
                    
                }
                .padding(.top, 10)
                
                // Actors list view
                if let actors = movieDetails.actors {
                    Spacer()
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(actors, id: \.self) { value in
                                MovieActorView(actorData: value)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        } else {
            // Loading view
            VStack {
                Spacer()
                
                ProgressView("Loading")
                
                Spacer()
            }
        }
    }
}
