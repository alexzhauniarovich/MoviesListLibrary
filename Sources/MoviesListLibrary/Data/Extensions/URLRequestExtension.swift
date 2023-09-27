import Foundation

extension URLRequest {
    
    var cURLDescription: String {
        guard let url = url, let httpMethod = httpMethod else {
            return "curl could not be created"
        }
        var components = [String]()
        
        components.append("curl -i --request \(httpMethod)")
        components.append("--url \"\(url.absoluteString)\"")
        
        if let allHTTPHeaderFields = allHTTPHeaderFields {
            for (name, value) in allHTTPHeaderFields {
                components.append("--header \"\(name): \(value)\"")
            }
        }
        if let bodyData = httpBody,
           let bodyString = String(data: bodyData, encoding: .utf8),
           bodyString.lengthOfBytes(using: .utf8) < 2048 {
            let escapedBody = bodyString.replacingOccurrences(of: "\"", with: "\\\"")
            components.append("--data \"\(escapedBody)\"")
        }
        return components.joined(separator: " \\\n\t")
    }
}
