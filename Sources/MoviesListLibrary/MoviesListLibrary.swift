
public struct MoviesListLibrary {
    
    // MARK: - Public views
    
    public static var MoviesListView: MoviesListView { DependenciesGraph.sharedInstance.prepareMoviesListView() }
    
}
