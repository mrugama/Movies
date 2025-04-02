import SwiftUI
import RestAPI

@MainActor
public struct BookingFeature: Sendable {
    static public func page(_ id: Int) -> some View {
        Booking(id: id)
    }
}
