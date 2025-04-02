import SwiftUI
import RestAPI
import DataLoader
import WebKit

struct Booking: View {
    var id: Int
    let restAPI = RestAPIService.provideRestAPI(DataLoaderService.provideDataLoader())
    @State private var viewModel: ViewModel = ViewModelImpl()
    @State private var model: MovieDetail?
    @State private var showWebView = false
    
    var body: some View {
        VStack {
            if let id = model?.Id {
                AsyncImage(
                    url: URL(string: "https://place-hold.it/\(id)"),
                    scale: 100) { image in
                        ScrollView {
                            VStack(alignment: .leading, spacing: 8) {
                                image
                                    .resizable()
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .aspectRatio(contentMode: .fill)
                                Text(model?.Name ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text(model?.Description ?? "")
                                    .font(.body)
                                    .foregroundColor(.gray)
                                
                                HStack {
                                    Text("Duration: ")
                                        .fontWeight(.bold)
                                    + Text(model?.Duration ?? "")
                                }
                                
                                HStack {
                                    Text("Director: ")
                                        .fontWeight(.bold)
                                    + Text(model?.Director ?? "")
                                }
                                
                                
                                VStack(alignment: .leading) {
                                    Text("Genres: ")
                                        .fontWeight(.bold)
                                    Text(model?.Genres.joined(separator: ", ") ?? "")
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Actors: ")
                                        .fontWeight(.bold)
                                    Text(model?.Actors.joined(separator: ", ") ?? "")
                                }
                                
                                Button(action: {
                                    showWebView = true
                                }) {
                                    Text("Book Now")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                                .sheet(isPresented: $showWebView) {
                                    WebView(url: URL(string: "https://book.zocdoc.com/")!)
                                }
                                .padding(.top, 20)
                            }
                            .frame(maxWidth: .infinity)
                            .compositingGroup()
                            .padding()
                        }
                    } placeholder: {
                        Image(systemName: "movieclapper")
                            .font(.title)
                            .imageScale(.large)
                    }
            } else {
                EmptyView()
            }
        }
        .task {
            await viewModel.loadMovieDetails(id: id)
            withAnimation {
                model = viewModel.movie
            }
        }
    }
}

