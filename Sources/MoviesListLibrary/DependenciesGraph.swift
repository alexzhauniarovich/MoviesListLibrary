import Foundation

class DependenciesGraph {
    
    // MARK: - Public fields
    
    static var sharedInstance: DependenciesGraph {
        if let instance = instance {
            return instance
            
        } else {
            let dependenciesGraph = DependenciesGraph()
            instance = dependenciesGraph
            return dependenciesGraph
        }
    }
    
    // MARK: - Private fields
    
    private static var instance: DependenciesGraph?
    
    // MARK: - Initialisation
    
    private init() { }
    
    // MARK: - Public functions
    
    func prepareMoviesListView() -> MoviesListView {
        MoviesListView(moviesUseCase: getMoviesUseCaseType())
    }
    
    func prepareActorDetailsView(personId: Int) -> ActorDetailsView {
        ActorDetailsView(personId: personId, actorsUseCase: getActorsUseCaseType())
    }
}

// MARK: - Domain

private extension DependenciesGraph {
    
    func getMoviesUseCaseType() -> MoviesUseCaseType {
        MoviesUseCase(moviesRepository: getMoviesRepositoryType())
    }
    
    func getActorsUseCaseType() -> ActorsUseCaseType {
        ActorsUseCase(actorsRepository: getActorsRepositoryType())
    }
}

// MARK: - Data

private extension DependenciesGraph {
    
    func getMoviesRepositoryType() -> MoviesRepositoryType {
        MoviesRepository(networkRequestManager: getNetworkRequestManager())
    }
    
    func getActorsRepositoryType() -> ActorsRepositoryType {
        ActorsRepository(networkRequestManager: getNetworkRequestManager())
    }
    
    func getNetworkRequestManager() -> NetworkRequestManager {
        NetworkRequestManager(networkRequestBuilder: getNetworkRequestBuilder())
    }
    
    func getNetworkRequestBuilder() -> NetworkRequestBuilder {
        NetworkRequestBuilder()
    }
}
