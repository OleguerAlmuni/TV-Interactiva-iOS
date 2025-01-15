import Foundation

struct NASAItemWrapper: Decodable {
    let data: [NASAItemData]
    let links: [NASAItemLink]?

    struct NASAItemData: Decodable {
        let nasa_id: String
        let title: String
        let location: String?
        let description: String?
        let photographer: String?
        let date_created: String

        // Map JSON keys to Swift properties.
        enum CodingKeys: String, CodingKey {
            case nasa_id
            case title
            case location
            case description
            case photographer // Add photographer here
            case date_created
        }
    }

    struct NASAItemLink: Decodable {
        let href: String? // Raw URL string from API.

        // Computed property to validate URL.
        var url: URL? {
            guard let href = href else { return nil }
            return URL(string: href)
        }
    }
}
