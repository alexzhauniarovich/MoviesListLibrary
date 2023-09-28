import Foundation

class ActorDetailsViewModel: ObservableObject {
    
    // MARK: - Publishers
    
    @Published var actorDetails: ActorDetailsViewData? = nil
    
    // MARK: - Private fields
    
    private let actorsUseCase: ActorsUseCaseType
    private let personId: Int
    
    // MARK: - Initialisation
    
    required init(personId: Int, actorsUseCase: ActorsUseCaseType) {
        self.personId = personId
        self.actorsUseCase = actorsUseCase
    }
    
    // MARK: - Public functions
    
    func viewWillAppear() {
        Task.detached(priority: .userInitiated) {
            do {
                let actorDetails = try await self.actorsUseCase.getActorDetails(personId: self.personId)
                await MainActor.run {
                    self.actorDetails = ActorDetailsViewData(
                        name: actorDetails.name,
                        biography: actorDetails.biography,
                        actorImageUrl: actorDetails.actorImageUrl
                    )
                    print(self.actorDetails.debugDescription)
                }
                
            } catch let error {
                await MainActor.run {
                    //TODO: Error handling
                }
            }
        }
    }
}
