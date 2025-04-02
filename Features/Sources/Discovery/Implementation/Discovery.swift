import SwiftUI
import RestAPI
import DataLoader
import Booking

struct Discovery: View {
    @State private var viewModel: ViewModel = ViewModelImpl(
        RestAPIService.provideRestAPI(
            DataLoaderService.provideDataLoader()
        )
    )
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies, id: \.Id) { movie in
                NavigationLink(value: movie.Id) {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 40)
                            .overlay {
                                Text("\(movie.Rank)")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.white)
                            }
                        Text(movie.Name)
                            .font(.headline)
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
            .alert(viewModel.output, isPresented: $viewModel.shouldShowMessage) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle("Top ten films")
            .navigationDestination(for: Int.self) { movieId in
                BookingFeature.page(movieId)
            }
        }
    }
}
