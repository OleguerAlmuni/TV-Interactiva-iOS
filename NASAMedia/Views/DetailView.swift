import SwiftUI
import AVKit

struct DetailView: View {
    let item: NASAItem
    @State private var videoURL: URL?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let previewURL = item.previewImage {
                    AsyncImage(url: previewURL) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text(item.title).font(.title)
                Text("Location: \(item.location ?? "Unknown")")
                Text("Photographer: \(item.photographer ?? "Unknown")")
                Text(item.description ?? "No description available.")
                
                if let videoURL = videoURL {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(height: 300) // Adjust size as needed
                } else {
                    Text("Loading video...")
                        .onAppear {
                            fetchVideo(for: item)
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Detail")
    }

    private func fetchVideo(for item: NASAItem) {
        NASAAPIService().fetchVideoURL(for: item.nasa_id) { result in
            switch result {
            case .success(let url):
                DispatchQueue.main.async {
                    self.videoURL = url
                }
            case .failure(let error):
                print("Error fetching video: \(error)")
            }
        }
    }
}
