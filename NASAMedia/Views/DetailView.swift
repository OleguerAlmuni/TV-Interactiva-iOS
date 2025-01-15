import SwiftUI

struct DetailView: View {
    let item: NASAItem

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
                Text(item.description ?? "No description available.")
                Text("Date Created: \(item.dateCreated)")

                // Aquí puedes añadir la lógica para reproducir el video cuando implementes el fetch de detalles adicionales
            }
            .padding()
        }
        .navigationTitle("Detail")
    }
}
