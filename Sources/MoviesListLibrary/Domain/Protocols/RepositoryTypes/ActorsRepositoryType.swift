
protocol ActorsRepositoryType {
    
    func getActorDetails(personId: Int) async throws -> ActorDetails
    
}
