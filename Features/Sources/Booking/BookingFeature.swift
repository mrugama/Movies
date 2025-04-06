import DataLoader
import RestAPI
import SwiftUI

@MainActor
public struct BookingFeature: Sendable {
    static public func page(_ id: Int) -> some View {
        Booking(
            id: id,
            viewModel: .init(
                RestAPIService.provideRestAPI(
                    DataLoaderService.provideDataLoader()
                )
            )
        )
    }
}
