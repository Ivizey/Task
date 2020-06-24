//
//  Builder.swift
//  Breweries
//
//  Created by Pavel Bondar on 17.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

protocol AsselderBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createMapModule(location: Location?, router: RouterProtocol) -> UIViewController
}

class AsselderModuleBuilder: AsselderBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = BreweryView()
        view.title = "Breweries"
        let networkService = BreweriesRepositoryImpl.makeDefault()
        let presenter = BreweriesPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createMapModule(location: Location?, router: RouterProtocol) -> UIViewController {
        let view = MapView()
        let networkService = BreweriesRepositoryImpl.makeDefault()
        let presenter = MapPresenter(view: view, networkService: networkService, location: location)
        view.presenter = presenter
        return view
    }
}
