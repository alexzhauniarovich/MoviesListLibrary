
public class ActorsRepository {
    
    // MARK: - Private fields
    
    private let networkRequestManager: NetworkRequestManager
    
    // MARK: - Initialisation
    
    public required init(networkRequestManager: NetworkRequestManager) {
        self.networkRequestManager = networkRequestManager
    }
}

// MARK: - Implementation of Movies Repository Protocol

extension ActorsRepository: ActorsRepositoryType {
    
    func getActorDetails(personId: Int) async throws -> ActorDetails {
        try await networkRequestManager.dispatch(
            request: ActorsRequest.requestActorDetails(personId: personId),
            responseType: ActorDetails.self
        )
    }
}
