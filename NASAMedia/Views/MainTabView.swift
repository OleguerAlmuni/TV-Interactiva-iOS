import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(NASASearch()) // Optional if you want to share the search view model
                .tabItem {
                    Label("Videos", systemImage: "video")
                }

            HomeView()
                .environmentObject(NASASearch())
                .tabItem {
                    Label("Images", systemImage: "photo")
                }
        }
    }
}
