import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(NASASearch())
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
