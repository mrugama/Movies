import Foundation

enum EndpointManager {
    case allMovies
    case movieDetails(id: Int)
    case moviesByRank(startRankIdx: Int, pageSize: Int)
    
    var urlStr: String {
        let token = "3b502b3f-b1ff-4128-bd99-626e74836d9c"
        var components = URLComponents()
        components.scheme = "https"
        components.host = "interview.zocdoc.com"
        
        var queryItems = [URLQueryItem(name: "authToken", value: token)]
        
        switch self {
        case .allMovies:
            components.path = "/api/1/FEE/AllMovies"

        case .movieDetails(let id):
            components.path = "/api/1/FEE/MovieDetails"
            queryItems.append(URLQueryItem(name: "movieIds", value: "\(id)"))

        case .moviesByRank(let rankIdx, let pageSize):
            components.path = "/api/1/FEE/MoviesByRank"
            queryItems.append(URLQueryItem(name: "startRankIndex", value: "\(rankIdx)"))
            queryItems.append(URLQueryItem(name: "numMovies", value: "\(pageSize)"))
        }
        
        components.queryItems = queryItems
        return components.url?.absoluteString ?? "Invalid URL"
    }
}

