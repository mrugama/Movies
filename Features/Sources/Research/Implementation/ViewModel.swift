import SwiftUI
import RestAPI

struct ResearchViewModel: DynamicProperty {
    @State var movies: [any Movie] = []
    let restAPI: RestAPI
    @State var output: String = ""
    @State var shouldShowMessage: Bool = false
    
    init(_ restAPI: RestAPI) {
        self.restAPI = restAPI
    }
    
    func loadTop10Movies() async {
        do {
            movies = try await restAPI.allMovies()
        } catch {
            output = error.localizedDescription
            shouldShowMessage = true
        }
    }
}
