import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Video Tab
            HomeView(mediaType: "video")
                .environmentObject(NASASearch())
                .tabItem {
                    Label("Videos", systemImage: "video")
                }

            // Image Tab
            HomeView(mediaType: "image")
                .environmentObject(NASASearch())
                .tabItem {
                    Label("Images", systemImage: "photo")
                }
        }
    }
}
