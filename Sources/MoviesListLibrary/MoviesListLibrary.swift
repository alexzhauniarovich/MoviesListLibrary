
public struct MoviesListLibrary {
    
    // MARK: - Initialisation
    
    public init() { }
    
    // MARK: - Public functions
    
    public func getMoviesListView() -> MoviesListView {
        DependenciesGraph.sharedInstance.prepareMoviesListView()
    }
}
