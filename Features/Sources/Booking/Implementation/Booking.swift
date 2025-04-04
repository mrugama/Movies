import SwiftUI

struct Booking: View {
    var id: Int
    var viewModel: BookingViewModel
    
    var body: some View {
        VStack {
            if let model = viewModel.movie {
                AsyncImage(
                    url: URL(
                        string: "https://place-hold.it/300x300/\(model.Id).jpg/fff/000?text=\(model.Name)"
                    )
                ) { image in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            headerView(
                                image,
                                name: model.Name,
                                description: model.Description
                            )
                            
                            bodyView(
                                duration: model.Duration,
                                director: model.Director,
                                genres: model.Genres,
                                actors: model.Actors
                            )
                        }
                        .frame(maxWidth: .infinity)
                        .compositingGroup()
                        .padding()
                    }
                    
                    bookingBtn
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        .gray.opacity(0.01),
                                        .gray.opacity(0.2),
                                        .gray.opacity(0.5),
                                    ]
                                ),
                                startPoint: .top, endPoint: .bottom
                            )
                        )
                } placeholder: {
                    Image(systemName: "movieclapper")
                        .font(.largeTitle)
                        .imageScale(.large)
                }
            } else {
                EmptyView()
            }
        }
        .task {
            await viewModel.loadMovieDetails(id: id)
        }
    }
    
    // MARK: - Helper methods
    
    private func headerView(
        _ image: Image,
        name: String,
        description: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            image
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .aspectRatio(contentMode: .fill)
            Text(name)
                .font(.title)
                .fontWeight(.bold)
            
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
        }
    }
    
    private func bodyView(
        duration: String,
        director: String,
        genres: [String],
        actors: [String]
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Duration: ")
                    .fontWeight(.bold)
                + Text(duration)
            }
            HStack {
                Text("Director: ")
                    .fontWeight(.bold)
                + Text(director)
            }
            VStack(alignment: .leading) {
                Text("Genres: ")
                    .fontWeight(.bold)
                Text(genres.joined(separator: ", "))
            }
            VStack(alignment: .leading) {
                Text("Actors: ")
                    .fontWeight(.bold)
                Text(actors.joined(separator: ", "))
            }
        }
    }
    
    private var bookingBtn: some View {
        Button(action: {
            viewModel.showWebView = true
        }) {
            Text("Book Now")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .sheet(isPresented: viewModel.$showWebView) {
            WebView(url: URL(string: "https://book.zocdoc.com/")!)
        }
    }
}

