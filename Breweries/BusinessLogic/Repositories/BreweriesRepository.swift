//
//  BreweriesRepository.swift
//  Breweries
//
//  Created by Pavel Bondar on 20.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

typealias BrewerysRepositoryFetchHandler = ([Brewery]) -> ()

protocol BreweriesRepository {
    func fetchBrewery(search: String?, completionHandler: @escaping BrewerysRepositoryFetchHandler)
}

class BreweriesRepositoryImpl: BreweriesRepository {
    private let storage: BreweriesStorage
    private let dataLoader: DataLoader
    private let decoder: JSONDecoder
    
    init(storage: BreweriesStorage,
         dataLoader: DataLoader,
         decoder: JSONDecoder) {
        self.storage = storage
        self.dataLoader = dataLoader
        self.decoder = decoder
    }
    
    func fetchBrewery(search: String?, completionHandler: @escaping BrewerysRepositoryFetchHandler) {
        let endpoint = Endpoint.breweries(matching: search)
        dataLoader.request(endpoint) { [weak storage, weak decoder] result in
            guard let storage = storage, let decoder = decoder else {
                completionHandler([])
                return
            }
            
            switch result {
            case .failure:
                completionHandler(storage.obtainBrewery())
            case .success(let data):
                guard let breweries = try? decoder.decode([Brewery].self, from: data) else {
                    completionHandler([])
                    return
                }
                storage.clearAll()
                completionHandler(storage.saveBrewerys(brewery: breweries))
            }
        }
    }
}

extension BreweriesRepositoryImpl {
    static func makeDefault() -> BreweriesRepositoryImpl {
        let storage = BreweriesStorageImpl()
        let loader = DataLoaderImpl(
            session: URLSession.shared,
            validator: StatusCodeValidator()
        )
        let decoder = JSONDecoder()
        return BreweriesRepositoryImpl(storage: storage, dataLoader: loader, decoder: decoder)
    }
}
