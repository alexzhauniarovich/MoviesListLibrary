import Foundation

public class NetworkRequestManager {
    
    // MARK: - Private fields
    
    private let networkRequestBuilder: NetworkRequestBuilder
    private var session = URLSession.shared
    
    // MARK: - Initialisation
    
    public required init(networkRequestBuilder: NetworkRequestBuilder) {
        self.networkRequestBuilder = networkRequestBuilder
    }
    
    // MARK: - Public functions
    
    func dispatch<T: Decodable>(request: Requestable, responseType: T.Type) async throws -> T {
        guard let urlRequest = networkRequestBuilder.build(request) else { throw NetworkError.invalidURL }
        printCurledRequest(urlRequest: urlRequest)
        let (data, response) = try await session.data(for: urlRequest)
        return try processResponse(data: data, responseType: responseType, response: response)
    }
    
    // MARK: - Private functions
    
    private func processResponse<T: Decodable>(
        data: Data?,
        responseType: T.Type,
        response: URLResponse?
    ) throws -> T {
        guard let httpURLResponse = response as? HTTPURLResponse,
              let data = data
        else { throw NetworkError.unknown }
        
        if httpURLResponse.statusCode >= 200, httpURLResponse.statusCode < 300 {
            return try JSONDecoder().decode(T.self, from: data)
            
        } else if httpURLResponse.statusCode == 401 {
            throw NetworkError.unauthorized
            
        } else {
            let parsedData = String(data: data, encoding: .utf8)?.replacingOccurrences(of: "\"", with: "") ?? ""
            let urlHeader = "The API request:\n\(httpURLResponse.url?.absoluteString ?? "")"
            let message = "\(urlHeader)\nDid respond with error code \(String(httpURLResponse.statusCode))\n\n\(parsedData)"
            throw NetworkError.invalidResponse(statusCode: httpURLResponse.statusCode, message: message)
        }
    }
    
    private func printCurledRequest(urlRequest: URLRequest) {
        #if DEBUG
        print("\n----------API----------")
        print("\(urlRequest.cURLDescription)")
        #endif
    }
}
