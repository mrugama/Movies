import DataLoader
import RestAPI
import SwiftUI

@MainActor
public struct DiscoveryFeature: Sendable {
    static public var page: some View {
        Discovery(
            viewModel: .init(
                RestAPIService.provideRestAPI(
                    DataLoaderService.provideDataLoader()
                )
            )
        )
    }
}
