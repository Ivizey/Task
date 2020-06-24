//
//  Presenter.swift
//  Breweries
//
//  Created by Pavel Bondar on 17.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol MapViewProtocol: class {
    func setLocation(location: Location?)
    func setTitle(title: String?)
}

protocol MapViewPresenterProtocol: class {
    init(view: MapViewProtocol, networkService: BreweriesRepositoryImpl, location: Location?)
    func setLocation()
    func setTitle()
}

class MapPresenter: MapViewPresenterProtocol {
    weak var view: MapViewProtocol?
    let networkService: BreweriesRepositoryImpl!
    var location: Location?
    
    required init(view: MapViewProtocol, networkService: BreweriesRepositoryImpl, location: Location?) {
        self.view = view
        self.networkService = networkService
        self.location = location
    }
    
    public func setLocation() {
        self.view?.setLocation(location: location)
    }
    
    func setTitle() {
        self.view?.setTitle(title: location?.title)
    }
}
