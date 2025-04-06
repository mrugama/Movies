import Booking
import SwiftUI

struct Research: View {
    var viewModel: ResearchViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies, id: \.Id) { movie in
                NavigationLink(value: movie.Id) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.Name)
                            .font(.headline)
                        Text("Duration: \(movie.Duration)")
                            .font(.callout)
                        Text("Director: \(movie.Director)")
                            .font(.subheadline)
                        VStack(alignment: .leading) {
                            Text("Genres: ")
                                .fontWeight(.bold)
                            Text(movie.Genres, format: .list(type: .and))
                        }
                        VStack(alignment: .leading) {
                            Text("Actors: ")
                                .fontWeight(.bold)
                            Text(movie.Actors, format: .list(type: .and))
                        }
                    }
                    .padding()
                }
            }
            .listStyle(.plain)
            .task {
                await viewModel.loadTop10Movies()
            }
            .refreshable {
                await viewModel.loadTop10Movies()
            }
            .alert(viewModel.output, isPresented: viewModel.$shouldShowMessage) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle("Research films")
            .navigationDestination(for: Int.self) { movieId in
                BookingFeature.page(movieId)
            }
        }
    }
}

#if DEBUG
import RestAPI
import DataLoader
#Preview(traits: .sizeThatFitsLayout) {
    Research(
        viewModel: ResearchViewModel(
            RestAPIService.provideRestAPIFake(
                DataLoaderService.provideDataLoader()
            )
        )
    )
}
#endif
