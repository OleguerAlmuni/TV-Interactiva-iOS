import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = NASASearch()
    @State private var query: String = ""
    @State private var yearStart: String = "2020"
    @State private var yearEnd: String = "2024"
    let mediaType: String // Passed from MainTabView
    @State private var showAlert = false // State to show/hide the alert

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
                        viewModel.search(query: query, yearStart: yearStart, yearEnd: yearEnd, mediaType: mediaType) { success in
                            if !success {
                                showAlert = true // Show the alert if no results found
                            }
                        }
                    }) {
                        Text("Search")
                    }
                }

                // Display results
                if !viewModel.noResultsFound {
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("No Results Found"),
                    message: Text("The keyword \"\(query)\" did not return any results. Please try a different keyword."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .background(Color(.systemBackground))
        }
    }
}
