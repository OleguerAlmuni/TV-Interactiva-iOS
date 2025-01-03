import Foundation

class NASAAPIService {
    func fetchResults(query: String, yearStart: String, yearEnd: String, mediaType: String, completion: @escaping (Result<[NASAItem], Error>) -> Void) {
            let baseUrl = "https://images-api.nasa.gov/search"
            guard var urlComponents = URLComponents(string: baseUrl) else {
                return completion(.failure(URLError(.badURL)))
            }

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

                do {
                    let decodedResponse = try JSONDecoder().decode(NASAResponse.self, from: data)
                    completion(.success(decodedResponse.items))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
}
