import Foundation

enum NetworkConstants {
    static let baseHostUrl = "https://api.themoviedb.org/3"
    static let imagesHostUrl = "https://image.tmdb.org/t/p/"
    static let TMDBApiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZDNkMDQ2Mzc2YzQ4Y2M3NjM4ZmViYzRhYTIxN2VjNCIsInN1YiI6IjYxMDJhNGJmZjcwNmRlMDA0NmVlNzFjOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dI24lXsXubHOkkPGfjYrhvqrlUnTb5Nlg9urOfz2jJ4"
}

enum RemotePosterSize: String {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

enum RemoteProfileImageSize: String {
    case w45
    case w185
    case h632
    case original
}
