import DataLoader
import RestAPI
import SwiftUI

struct BookingViewModel: DynamicProperty {
    @State var movie: MovieDetail?
    let restAPI: RestAPI
    @State var output: String = ""
    @State var shouldShowMessage: Bool = false
    @State var showWebView = false
    
    init(_ restAPI: RestAPI) {
        self.restAPI = restAPI
    }
    
    func loadMovieDetails(id: Int) async {
        do {
            let movie = try await restAPI.movieDetails(id)
            withAnimation {
                self.movie = movie
            }
        } catch {
            output = error.localizedDescription
            shouldShowMessage = true
        }
    }
}
