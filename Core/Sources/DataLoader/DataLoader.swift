import Foundation

public protocol DataLoader
where Self: Sendable {
    func loadData(_ urlStr: String) async throws -> Data
}

public struct DataLoaderService: Sendable {
    static public func provideDataLoader() -> DataLoader {
        DataLoaderImpl()
    }
}
