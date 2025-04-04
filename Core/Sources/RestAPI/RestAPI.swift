import Foundation
import DataLoader

public protocol Movie
where Self: Sendable, Self: Decodable {
    var Id: Int { get }
    var Rank: Int { get }
    var Name: String { get }
    var Duration: String { get }
    var Description: String { get }
    var Director: String { get }
    var Genres: [String] { get }
    var Actors: [String] { get }
}

public protocol MovieDetail
where Self: Sendable, Self: Decodable {
    var Id: Int { get }
    var Name: String { get }
    var Duration: String { get }
    var Description: String { get }
    var Director: String { get }
    var Genres: [String] { get }
    var Actors: [String] { get }
}

public protocol MovieRank
where Self: Sendable, Self: Decodable {
    var Id: Int { get }
    var Rank: Int { get }
    var Name: String { get }
}

public protocol RestAPI
where Self: Sendable {
    func allMovies() async throws -> [any Movie]
    func movieDetails(_ id: Int) async throws -> MovieDetail?
    func moviesByRank(
        _ startRankIndex: Int,
        pageSize: Int
    ) async throws -> [any MovieRank]
}

public struct RestAPIService: Sendable {
    static public func provideRestAPI(
        _ dataLoader: DataLoader
    ) -> RestAPI {
        RestAPIImpl(dataLoader: dataLoader)
    }
    
#if DEBUG
    static public func provideRestAPIFake(
        _ dataLoader: DataLoader
    ) -> RestAPI {
        RestAPIFake(dataLoader: dataLoader)
    }
#endif
}
