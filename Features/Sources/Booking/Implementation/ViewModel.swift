import SwiftUI
import RestAPI
import DataLoader
import WebKit

@MainActor
protocol ViewModel
where Self: Observable {
    var movie: MovieDetail? { get }
    var output: String { get }
    var shouldShowMessage: Bool { get set }
    
    func loadMovieDetails(id: Int) async
}

@Observable
final class ViewModelImpl: ViewModel {
    var movie: MovieDetail?
    let restAPI: RestAPI
    var output: String = ""
    var shouldShowMessage: Bool = false
    
    init() {
        restAPI = RestAPIService.provideRestAPI(DataLoaderService.provideDataLoader())
    }
    
    func loadMovieDetails(id: Int) async {
        do {
            movie = try await restAPI.movieDetails(id)
        } catch {
            output = error.localizedDescription
            shouldShowMessage = true
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
