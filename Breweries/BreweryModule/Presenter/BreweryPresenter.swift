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
    init(view: BreweriesViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getBreweries()
    var breweries: [Brewery]? { get set }
    func tapOnTheItem(location: Location?)
}

class BreweriesPresenter: BreweriesViewPresenterProtocol{
    weak var view: BreweriesViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var breweries: [Brewery]?
    
    required init(view: BreweriesViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
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
    
    func tapOnTheItem(location: Location?) {
        router?.showMap(location: location)
    }
}
