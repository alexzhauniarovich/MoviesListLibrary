
public enum NetworkError: Error {
    case unknown
    case invalidURL
    case unauthorized
    case parsingError(message: String?)
    case invalidResponse(statusCode: Int, message: String?)
}

struct ErrorDescription: Codable {
    let errors: [String]?
}
