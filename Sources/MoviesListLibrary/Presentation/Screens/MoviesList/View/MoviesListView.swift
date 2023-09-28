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
    
    // MARK: - Private fields
    
    @StateObject private var viewModel: MoviesListViewModel
    @State private var currentIndex: Int = 0
    
    // MARK: - Initialisation
    
    init(moviesUseCase: MoviesUseCaseType) {
        _viewModel = StateObject(wrappedValue: MoviesListViewModel(moviesUseCase: moviesUseCase))
    }
    
    // MARK: - Layout
    
    public var body: some View {
        NavigationView {
            if !viewModel.movies.isEmpty {
                VStack {
                    // Movies posters pager view
                    ViewPager(
                        index: $currentIndex,
                        items: viewModel.movies,
                        onScrollEnded: { viewModel.didRequestMovieDetails(at: currentIndex) }
                    ) { content in
                        GeometryReader { geometry in
                            MovieCardView(
                                position: viewModel.movies.firstIndex(where: { $0.id == content.id }) ?? 0,
                                currentPosition: $currentIndex,
                                rating: content.rating,
                                imageUrl: content.posterImage
                            )
                            .frame(width: geometry.size.width)
                        }
                    }
                    // Movie details view
                    MovieDetailsView(movieDetails: $viewModel.movieDetails).padding(.top, 8)
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
        .onAppear { viewModel.viewWillAppear() }
        .accentColor(.black)
        .alert(viewModel.errorMessage ?? "", isPresented: $viewModel.showingErrorAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

// MARK: - Debugging

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
