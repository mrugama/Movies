import SwiftUI
import Discovery
import Research

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Discovery", systemImage: "house") {
                DiscoveryFeature.page
            }
            
            Tab("Research", systemImage: "magnifyingglass") {
                ResearchFeature.page
            }
        }
    }
}

#Preview {
    MainTabView()
}
