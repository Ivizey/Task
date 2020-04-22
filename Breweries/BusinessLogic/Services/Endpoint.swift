//
//  Endpoint.swift
//  Breweries
//
//  Created by Pavel Bondar on 20.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

enum EndpointError: Error {
    case invalidURL
    case network(Error?)
    case invalidResponse(URLResponse?)
    case validation(Error)
}

extension Endpoint {
    static func breweries(matching query: String?) -> Endpoint {
        var queries: [URLQueryItem] = []
        if let query = query,
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            queries.append(.init(name: "by_name", value: encodedQuery))
        }
        
        return Endpoint(
            path: "/breweries",
            queryItems: queries
        )
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openbrewerydb.org"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
