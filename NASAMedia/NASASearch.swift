import Foundation
import Combine

class NASASearch: ObservableObject {
    @Published var results: [NASAItem] = []
    @Published var errorMessage: String?
    @Published var noResultsFound: Bool = false

    private var cancellables = Set<AnyCancellable>()

    func search(query: String, yearStart: String, yearEnd: String, mediaType: String) {
        errorMessage = nil
        noResultsFound = false

        let apiService = NASAAPIService()
        apiService.fetchResults(query: query, yearStart: yearStart, yearEnd: yearEnd, mediaType: mediaType) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    if items.isEmpty {
                        self?.noResultsFound = true
                    }
                    self?.results = items
                case .failure(let error):
                    self?.errorMessage = "An error occurred: \(error.localizedDescription)"
                }
            }
        }
    }
}
