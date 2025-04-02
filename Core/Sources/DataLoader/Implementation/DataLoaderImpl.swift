import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidURL,invalidResponse,
         requestFailed(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response"
        case .requestFailed(statusCode: let statusCode):
            return "Request failed with status code \(statusCode)"
        }
    }
}

struct DataLoaderImpl: DataLoader {
    func loadData(_ urlStr: String) async throws -> Data {
        guard let url: URL = URL(string: urlStr) else {
            throw NetworkError.invalidURL
        }
        
        let urlRequest = URLRequest(url: url)
        return try await fetchDataFromOnline(urlRequest)
    }
    
    // MARK: - Private method helpers
    private func fetchDataFromOnline(_ urlRequest: URLRequest) async throws -> Data {
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw NetworkError.requestFailed(statusCode: 0)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
        
        return data
    }
}
