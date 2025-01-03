import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Videos", systemImage: "video")
                }

            HomeView()
                .tabItem {
                    Label("Images", systemImage: "photo")
                }
        }
    }
}

