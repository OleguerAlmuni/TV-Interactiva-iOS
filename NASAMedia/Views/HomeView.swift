import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = NASASearch()
    @State private var query: String = ""
    @State private var yearStart: String = "2020"
    @State private var yearEnd: String = "2024"
    @State private var selectedMediaType: String = "video"

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Search Parameters")) {
                        TextField("Keywords", text: $query)
                        TextField("Start Year", text: $yearStart)
                        TextField("End Year", text: $yearEnd)

                        Picker("Media Type", selection: $selectedMediaType) {
                            Text("Videos").tag("video")
                            Text("Images").tag("image")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    Button(action: {
                        viewModel.search(query: query, yearStart: yearStart, yearEnd: yearEnd, mediaType: selectedMediaType)
                    }) {
                        Text("Search")
                    }
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                }

                List(viewModel.results) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            if let previewURL = item.previewImage {
                                AsyncImage(url: previewURL) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text(item.title).font(.headline)
                                Text(item.location ?? "Unknown Location").font(.subheadline)
                            }
                        }
                    }
                }

            }
            .navigationTitle("NASA Explorer")
        }
    }
}
