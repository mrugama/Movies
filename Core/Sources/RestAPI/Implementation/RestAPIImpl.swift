import Foundation
import DataLoader

enum RestAPIError: LocalizedError, Equatable {
    case networkError, invalidModel
    
    var errorDescription: String? {
        switch self {
        case .networkError: return "Network layer error"
        case .invalidModel: return "Parsing data error"
        }
    }
}

struct RestAPIImpl: RestAPI {
    let dataLoader: DataLoader
    
    func allMovies() async throws -> [any Movie] {
        let movies: [MovieModel] = try await loadData(
            urlStr: EndpointManager.allMovies.urlStr
        )
        return movies
    }
    
    func movieDetails(_ id: Int) async throws -> MovieDetail {
        let movies: [MovieDetailModel] = try await loadData(
            urlStr: EndpointManager.movieDetails(id: id).urlStr
        )
        return movies.first!
    }
    
    func moviesByRank(_ startRankIndex: Int, pageSize: Int) async throws -> [any MovieRank] {
        let moviesByRank: [MovieRankModel] = try await loadData(
            urlStr: EndpointManager.moviesByRank(
                startRankIdx: startRankIndex,
                pageSize: pageSize
            ).urlStr
        )
        return moviesByRank
    }
    
    
    // MARK: - Helper function
    private func loadData<Model: Decodable>(urlStr: String) async throws -> [Model] {
        var data: Data
        var models: [Model] = []
        do {
            data = try await dataLoader.loadData(urlStr)
        } catch {
            throw RestAPIError.networkError
        }
        do {
            models = try JSONDecoder().decode([Model].self, from: data)
        } catch {
            throw RestAPIError.invalidModel
        }
        return models
    }
}
