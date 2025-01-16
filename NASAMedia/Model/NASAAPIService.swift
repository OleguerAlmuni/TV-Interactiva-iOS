import Foundation

class NASAAPIService {
    // Fetch response from NASA's API
    func fetchResults(query: String, yearStart: String, yearEnd: String, mediaType: String, completion: @escaping (Result<[NASAItem], Error>) -> Void) {
        let baseUrl = "https://images-api.nasa.gov/search"
        guard var urlComponents = URLComponents(string: baseUrl) else {
            return completion(.failure(URLError(.badURL)))
        }

        // Queries for the API
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "year_start", value: yearStart),
            URLQueryItem(name: "year_end", value: yearEnd),
            URLQueryItem(name: "media_type", value: mediaType)
        ]

        guard let url = urlComponents.url else {
            return completion(.failure(URLError(.badURL)))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            // Decode the API's response
            do {
                let decodedResponse = try JSONDecoder().decode(NASAResponse.self, from: data)
                let items = decodedResponse.collection.items.compactMap { wrapper -> NASAItem? in
                    guard let data = wrapper.data.first else { return nil }
                    return NASAItem(
                        nasa_id: data.nasa_id,
                        title: data.title,
                        location: data.location,
                        description: data.description,
                        photographer: data.photographer,
                        dateCreated: data.date_created,
                        previewImageString: wrapper.links?.first?.href // Pass the raw href
                    )

                }
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Fetch the video of the article
    func fetchVideoURL(for eventID: String, completion: @escaping (Result<URL?, Error>) -> Void) {
            let urlString = "https://images-api.nasa.gov/asset/\(eventID)"
            guard let url = URL(string: urlString) else {
                return completion(.failure(URLError(.badURL)))
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(NASAItemVideoResponse.self, from: data)
                    if let videoURLString = decodedResponse.collection.items.first?.href {
                        completion(.success(URL(string: videoURLString)))
                    } else {
                        completion(.success(nil))
                    }
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }

    
    // Structs to save the information of the video fetched
    struct NASAItemVideoResponse: Decodable {
        let collection: NASACollection
        
        struct NASACollection: Decodable {
            let items: [NASAItemVideo]
        }
        
        struct NASAItemVideo: Decodable {
            let href: String
        }
    }
}
