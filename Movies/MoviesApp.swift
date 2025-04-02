import SwiftUI
import MainTabView

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabViewFeature.page
        }
    }
}
