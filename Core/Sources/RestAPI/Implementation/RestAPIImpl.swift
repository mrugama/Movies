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
    
    func movieDetails(_ id: Int) async throws -> MovieDetail? {
        let movies: [MovieDetailModel] = try await loadData(
            urlStr: EndpointManager.movieDetails(id: id).urlStr
        )
        return movies.first
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

#if DEBUG
struct RestAPIFake: RestAPI {
    let dataLoader: DataLoader
    
    func allMovies() async throws -> [any Movie] {
        let url = Bundle.module.url(
            forResource: "movies",
            withExtension: "json"
        )!
        let data = try! Data(contentsOf: url)
        let movies = try JSONDecoder().decode([MovieModel].self, from: data)
        return movies
    }
    
    func movieDetails(
        _ id: Int
    ) async throws -> MovieDetail? {
        let url = Bundle.module.url(
            forResource: "movieDetails",
            withExtension: "json"
        )!
        let data = try! Data(contentsOf: url)
        let movies = try JSONDecoder().decode([MovieDetailModel].self, from: data)
        return movies.first
    }
    
    func moviesByRank(
        _ startRankIndex: Int,
        pageSize: Int
    ) async throws -> [any MovieRank] {
        let url = Bundle.module.url(
            forResource: "rank",
            withExtension: "json"
        )!
        let data = try! Data(contentsOf: url)
        let moviesByRank = try JSONDecoder().decode([MovieRankModel].self, from: data)
        return moviesByRank
    }

    // MARK: - Helper function
    private func loadData<Model: Decodable>(urlStr: String) async throws -> [Model] {
        var data: Data
        var models: [Model] = []
        do {
            data = try await dataLoader.loadData(urlStr)
        } catch {
            print(error.localizedDescription)
            throw RestAPIError.networkError
        }
        do {
            models = try JSONDecoder().decode([Model].self, from: data)
        } catch {
            print(error.localizedDescription)
            throw RestAPIError.invalidModel
        }
        return models
    }
}
#endif
