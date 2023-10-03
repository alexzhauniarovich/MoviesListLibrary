import Foundation

public class ActorsUseCase {
    
    // MARK: - Private fields
    
    private let actorsRepository: ActorsRepositoryType
    
    // MARK: - Initialisation
    
    required init(actorsRepository: ActorsRepositoryType) {
        self.actorsRepository = actorsRepository
    }
}

// MARK: - Implementation of Actors UseCase protocol

extension ActorsUseCase: ActorsUseCaseType {
    
    func getActorDetails(personId: Int) async throws -> MovieActorDetails {
        let actorDetails = try await actorsRepository.getActorDetails(personId: personId)
        
        return MovieActorDetails(
            name: actorDetails.name,
            biography: actorDetails.biography,
            actorImageUrl: URL(string: "\(NetworkConstants.imagesHostUrl)\(RemoteProfileImageSize.original.rawValue)\(actorDetails.actorImage ?? "")")
        )
    }
}
