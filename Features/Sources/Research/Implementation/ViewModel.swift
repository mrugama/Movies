import SwiftUI
import RestAPI

@MainActor
protocol ViewModel
where Self: Observable {
    var movies: [any Movie] { get }
    var restAPI: RestAPI { get }
    var output: String { get }
    var shouldShowMessage: Bool { get set }
    
    func loadTop10Movies() async
}

@Observable
final class ViewModelImpl: ViewModel {
    var movies: [any Movie] = []
    let restAPI: RestAPI
    var output: String = ""
    var shouldShowMessage: Bool = false
    
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
