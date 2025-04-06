import RestAPI
import SwiftUI

struct DiscoveryViewModel: DynamicProperty {
    @State var movies: [any MovieRank] = []
    let restAPI: RestAPI
    @State var output: String = ""
    @State var shouldShowMessage: Bool = false
    
    init(_ restAPI: RestAPI) {
        self.restAPI = restAPI
    }
    
    func loadTop10Movies() async {
        do {
            movies = try await restAPI.moviesByRank(1, pageSize: 10)
        } catch {
            output = error.localizedDescription
            shouldShowMessage = true
        }
    }
}
