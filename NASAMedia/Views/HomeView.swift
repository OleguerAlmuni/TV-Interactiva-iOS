import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = NASASearch()
    @State private var query: String = ""
    @State private var yearStart: String = "2020"
    @State private var yearEnd: String = "2024"
    let mediaType: String // Passed from MainTabView

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // Search bar
                    Section(header: Text("Search Parameters")) {
                        TextField("Keywords", text: $query)
                        TextField("Start Year", text: $yearStart)
                        TextField("End Year", text: $yearEnd)
                    }

                    Button(action: {
                        viewModel.search(query: query, yearStart: yearStart, yearEnd: yearEnd, mediaType: mediaType)
                    }) {
                        Text("Search")
                    }
                }

                // Display errors or no results message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.noResultsFound {
                    Text("No results found for \"\(query)\".")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // Display results
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
            }
            .navigationTitle("NASA " + mediaType.capitalized + " Explorer")
        }
    }
}
