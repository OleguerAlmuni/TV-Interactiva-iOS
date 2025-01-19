import Foundation
class NASASearch: ObservableObject {
    @Published var results: [NASAItem] = []
    @Published var noResultsFound = false
    @Published var errorMessage: String? = nil

    func search(query: String, yearStart: String, yearEnd: String, mediaType: String, completion: @escaping (Bool) -> Void) {
        let apiService = NASAAPIService()
        apiService.fetchResults(query: query, yearStart: yearStart, yearEnd: yearEnd, mediaType: mediaType) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self.results = items
                    self.noResultsFound = items.isEmpty
                    completion(!items.isEmpty) // Notify if results are found
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.noResultsFound = true
                    completion(false) // Notify failure
                }
            }
        }
    }
}
