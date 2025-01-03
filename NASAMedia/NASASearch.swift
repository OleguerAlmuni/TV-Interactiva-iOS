import Foundation
import Combine

class NASASearch: ObservableObject {
    @Published var results: [NASAItem] = []
        @Published var errorMessage: String? = nil

        private let service = NASAAPIService()

        func search(query: String, yearStart: String, yearEnd: String, mediaType: String) {
            service.fetchResults(query: query, yearStart: yearStart, yearEnd: yearEnd, mediaType: mediaType) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let items):
                        self?.results = items
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }
        }
}
