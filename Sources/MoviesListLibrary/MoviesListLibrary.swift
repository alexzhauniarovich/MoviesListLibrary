
public struct MoviesListLibrary {
    
    public init() { }
    
    public func getMoviesListView() -> MoviesListView {
        // TODO: Implemented DI
        MoviesListView(
            moviesUseCase: MoviesUseCase(
                moviesRepository: MoviesRepository(
                    networkRequestManager: NetworkRequestManager(
                        networkRequestBuilder: NetworkRequestBuilder()
                    )
                )
            )
        )
    }
}
