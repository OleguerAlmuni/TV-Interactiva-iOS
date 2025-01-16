import Foundation
struct NASAItem: Identifiable {
    var id: String { nasa_id }
    let nasa_id: String
    let title: String
    let location: String?
    let description: String?
    let photographer: String?
    let dateCreated: String
    let previewImageString: String?

    // Compute the URL when is valid
    var previewImage: URL? {
        guard let urlString = previewImageString else { return nil }
        return URL(string: urlString)
    }
}
