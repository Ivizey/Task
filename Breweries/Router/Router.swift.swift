//
//  Router.swift
//  Breweries
//
//  Created by Pavel Bondar on 17.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var asseblyBuilder: AsselderBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showMap(location: Location?)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var asseblyBuilder: AsselderBuilderProtocol?
    
    init(navigationController: UINavigationController, asseblyBuilder: AsselderBuilderProtocol) {
        self.navigationController = navigationController
        self.asseblyBuilder = asseblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let breweryViewController = asseblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [breweryViewController]
        }
    }
    
    func showMap(location: Location?) {
        if let navigationController = navigationController {
            guard let mapViewController = asseblyBuilder?.createMapModule(location: location, router: self) else { return }
            navigationController.pushViewController(mapViewController, animated: true)
        }
    }
    
    
}
