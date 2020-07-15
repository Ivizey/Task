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
}

protocol BreweriesViewPresenterProtocol: class {
    init(view: BreweriesViewProtocol, networkService: BreweriesRepositoryImpl, router: RouterProtocol)
    func getBreweries(search: String?)
    func openMapView(location: Location?)
    func openBrowser(url: URL)
    var breweries: [Brewery]? { get set }
}

class BreweriesPresenter: BreweriesViewPresenterProtocol {
    weak var view: BreweriesViewProtocol?
    let networkService: BreweriesRepositoryImpl!
    var router: RouterProtocol?
    var breweries: [Brewery]?
    
    required init(view: BreweriesViewProtocol, networkService: BreweriesRepositoryImpl, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getBreweries(search: nil)
    }
    
    func getBreweries(search: String?) {
        networkService.fetchBrewery(search: search) { [weak self] breweries in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.breweries = breweries
                self.networkService.cacheData(breweries)
                self.view?.succes()
            }
        }   
    }
    
    func openMapView(location: Location?) {
        router?.showMap(location: location)
    }
    
    func openBrowser(url: URL) {
        router?.openBrowser(url: url)
    }
}
