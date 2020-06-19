//
//  Network.swift
//  Breweries
//
//  Created by Pavel Bondar on 17.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchNewsFeed(completionHandler: @escaping (Result<[Brewery]?, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    func fetchNewsFeed(completionHandler: @escaping (Result<[Brewery]?, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openbrewerydb.org"
        components.path = "/breweries"
        guard let url = components.url else { return }
        URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else { return }
                if let data = data, (200...299).contains(response.statusCode) {
                    do {
                        let brewery = try JSONDecoder().decode([Brewery].self, from: data)
                        completionHandler(.success(brewery))
                    } catch {
                        print(error.localizedDescription)
                        completionHandler(.failure(error))
                    }
                }
        }.resume()
    }
}
