import Booking
import SwiftUI

struct Discovery: View {
    var viewModel: DiscoveryViewModel
    
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
                                    .font(.subheadline.bold())
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
            .alert(
                viewModel.output,
                isPresented: viewModel.$shouldShowMessage
            ) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle("Top ten films")
            .navigationDestination(for: Int.self) { movieId in
                BookingFeature.page(movieId)
            }
        }
    }
}

#if DEBUG
import DataLoader
import RestAPI

#Preview(traits: .sizeThatFitsLayout) {
    Discovery(
        viewModel: .init(
            RestAPIService.provideRestAPIFake(
                DataLoaderService.provideDataLoader()
            )
        )
    )
}
#endif
