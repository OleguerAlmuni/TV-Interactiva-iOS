import Foundation

struct NASAItem: Identifiable, Decodable {
    let id: String
    let title: String
    let location: String?
    let photographer: String?
    let description: String?
    let previewImage: URL?

    enum CodingKeys: String, CodingKey {
        case id = "nasa_id"
        case title
        case location
        case photographer
        case description
        case previewImage = "href"
    }
}
