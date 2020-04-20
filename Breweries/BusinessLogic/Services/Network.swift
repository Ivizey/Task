//
//  Network.swift
//  Breweries
//
//  Created by Pavel Bondar on 15.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

class Network {
    let dbManager: DBManager = DBManagerImpl()
    // MARK: - fetchBrewery
    func fetchBrewery(search: String? = nil, completionHandler: @escaping ([Brewery]) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openbrewerydb.org"
        components.path = "/breweries"
        if let search = search {
            components.queryItems = [URLQueryItem(name: "by_name", value: search)]
        }
        guard let url = components.url else { return }
        URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else { return }
                if let data = data, (200...299).contains(response.statusCode) {
                    do {
                        let brewery = try JSONDecoder().decode([Brewery].self, from: data)
                        self.dbManager.clearAll()
                        completionHandler(self.dbManager.saveBrewerys(brewery: brewery))
                    } catch {
                        completionHandler(self.dbManager.obtainBrewery())
                    }
                }
        }.resume()
    }
}
