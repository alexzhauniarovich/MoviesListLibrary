import SwiftUI

private enum Constants {
    static let leadingSpacing: CGFloat = 16
}

struct TrendingMovieViewData: Identifiable {
    let id: Int
    let posterImage: URL?
    let rating: String
}

public struct MoviesListView: View {
    
    @StateObject private var viewModel: MoviesListViewModel
    
    init(moviesUseCase: MoviesUseCaseType) {
        _viewModel = StateObject(wrappedValue: MoviesListViewModel(moviesUseCase: moviesUseCase))
    }
    
    @State var currentIndex: Int = 0
    
    public var body: some View {
        NavigationView {
            if !viewModel.movies.isEmpty {
                VStack {
                    VStack {
                        ViewPager(
                            index: $currentIndex,
                            items: viewModel.movies,
                            onScrollEnded: { viewModel.didRequestMovieDetails(at: currentIndex) }
                        ) { content in
                            GeometryReader{ geometry in
                                MovieCardView(
                                    position: viewModel.movies.firstIndex(where: { $0.id == content.id }) ?? 0,
                                    currentPosition: $currentIndex,
                                    rating: content.rating,
                                    imageUrl: content.posterImage
                                )
                                .frame(width: geometry.size.width)
                            }
                        }
                    }
                    
                    MovieDetailsView(movieDetails: $viewModel.movieDetails).padding(.top, 8)
                }
                
            } else {
                VStack {
                    Spacer()
                    
                    ProgressView("Loading").progressViewStyle(CircularProgressViewStyle())
                    
                    Spacer()
                }
            }
        }
        .onAppear { viewModel.viewWillAppear() }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(moviesUseCase: MoviesUseCase(
            moviesRepository: MoviesRepository(
                networkRequestManager: NetworkRequestManager(
                    networkRequestBuilder: NetworkRequestBuilder()
                )
            )
        ))
    }
}
