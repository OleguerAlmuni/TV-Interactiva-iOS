import Foundation
struct NASAItem: Identifiable {
    var id: String { nasa_id }
    let nasa_id: String
    let title: String
    let location: String?
    let description: String?
    let photographer: String?
    let dateCreated: String
    let previewImageString: String? // Store the raw string first.

    var previewImage: URL? { // Compute the URL only when valid.
        guard let urlString = previewImageString else { return nil }
        return URL(string: urlString)
    }
}
