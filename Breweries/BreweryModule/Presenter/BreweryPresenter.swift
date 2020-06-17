//
//  BreweryPresenter.swift
//  Breweries
//
//  Created by Pavel Bondar on 17.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol BreweriesViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol BreweriesViewPresenterProtocol: class {
    init(view: BreweriesViewProtocol, networkService: NetworkServiceProtocol)
    func getBreweries()
    var breweries: [Brewery]? { get set }
}

class BreweriesPresenter: BreweriesViewPresenterProtocol{
    weak var view: BreweriesViewProtocol?
    let networkService: NetworkServiceProtocol!
    var breweries: [Brewery]?
    
    required init(view: BreweriesViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getBreweries()
    }
    
    func getBreweries() {
        networkService.fetchNewsFeed { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let brewery):
                    self.breweries = brewery
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
