import Foundation

enum MoviesRequest: Requestable {
    
    case requestWeekTrendingMovies
    case requestMovieDetails(movieId: Int)
    case requestMovieCredits(movieId: Int)
    case requestMovieTrailers(movieId: Int)
    
    var path: String {
        switch self {
        case .requestWeekTrendingMovies: return "/trending/movie/week"
        case .requestMovieDetails(let movieId): return "/movie/\(movieId)"
        case .requestMovieCredits(let movieId): return "/movie/\(movieId)/credits"
        case .requestMovieTrailers(let movieId): return "/movie/\(movieId)/videos"
        }
    }
    
    var method: HTTPMethod { .get }
    
    var params: RequestParameter { .none }
}
