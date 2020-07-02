import UIKit

struct Brewery: Decodable {
    let id: Int?
    let name: String?
    let breweryType: String?
    let street: String?
    let city: String?
    let state: String?
    let postalCode: String?
    let country: String?
    let longitude: Double?
    let latitude: Double?
    let phone: String?
    let websiteUrl: String?
    let updatedAt: String?
    let tagList: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breweryType = "brewery_type"
        case street
        case city
        case state
        case postalCode = "postal_code"
        case country
        case longitude
        case latitude
        case phone
        case websiteUrl = "website_url"
        case updatedAt = "updated_at"
        case tagList = "tag_list"
    }
}

extension Brewery {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.breweryType = try container.decode(String.self, forKey: .breweryType)
        self.street = try? container.decode(String.self, forKey: .street)
        self.city = try? container.decode(String.self, forKey: .city)
        self.state = try? container.decode(String.self, forKey: .state)
        self.postalCode = try? container.decode(String.self, forKey: .postalCode)
        self.country = try? container.decode(String.self, forKey: .country)
        self.longitude = try? Double(container.decode(String.self, forKey: .longitude))
        self.latitude = try? Double(container.decode(String.self, forKey: .latitude))
        self.phone = try? container.decode(String.self, forKey: .phone)
        self.websiteUrl = try? container.decode(String.self, forKey: .websiteUrl)
        self.updatedAt = try? container.decode(String.self, forKey: .updatedAt)
        self.tagList = try? container.decode([String].self, forKey: .tagList)
    }
}

func fetchBrewery(search: String? = nil, completionHandler: @escaping (Result<[Brewery]?, Error>) -> ()) {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.openbrewerydb.org"
    components.path = "/breweries"
    if let search = search {
        components.queryItems = [URLQueryItem(name: "by_name", value: search)]
    }
    guard let url = components.url else { return }
    print(url)
    URLSession
        .shared
        .dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { return }
            if let data = data, (200...299).contains(response.statusCode) {
                do {
                    let brewery = try JSONDecoder().decode([Brewery].self, from: data)
                    completionHandler(.success(brewery))
                } catch {
                    completionHandler(.failure(error))
                }
            }
    }.resume()
}


fetchBrewery(search: "dog") { result in
    switch result {
    case .success(let breweries):
        breweries?.enumerated().map({ (index, brewery) in
            print("\(index + 1): \(brewery) \n")
        })
    case .failure(let error):
        print("Error: \(error.localizedDescription)")
    }
}
