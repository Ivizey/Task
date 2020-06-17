//
//  Presenter.swift
//  Breweries
//
//  Created by Pavel Bondar on 17.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol MapViewProtocol {
    func setLocation(location: Location?)
}

protocol MapViewPresenterProtocol {
    init(view: MapViewProtocol, networkService: NetworkServiceProtocol, location: Location?)
    func setLocation()
}

class MapPresenter: MapViewPresenterProtocol {
    required init(view: MapViewProtocol, networkService: NetworkServiceProtocol, location: Location?) {
        <#code#>
    }
    
    func setLocation() {
        <#code#>
    }
}
