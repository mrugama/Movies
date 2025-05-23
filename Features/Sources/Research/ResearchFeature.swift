import DataLoader
import RestAPI
import SwiftUI

@MainActor
public struct ResearchFeature: Sendable {
    static public var page: some View {
        Research(
            viewModel: .init(
                RestAPIService.provideRestAPI(
                    DataLoaderService.provideDataLoader()
                )
            )
        )
    }
}
