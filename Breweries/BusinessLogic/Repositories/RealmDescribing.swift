//
//  RealmDescribing.swift
//  Breweries
//
//  Created by Pavel Bondar on 20.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmDescribing {
    func write<Result>(withoutNotifying tokens: [NotificationToken],
                       _ block: (() throws -> Result)) throws -> Result
    func add(_ object: Object, update: Realm.UpdatePolicy)
    func deleteAll()
    func objects<Element>(_ type: Element.Type) -> Results<Element> where Element : Object
}

extension RealmDescribing {
    func write<Result>(withoutNotifying tokens: [NotificationToken] = [],
                       _ block: (() throws -> Result)) throws -> Result {
        try write(withoutNotifying: tokens, block)
    }
    
    func add(_ object: Object, update: Realm.UpdatePolicy = .error) {
        add(object, update: update)
    }
}

extension Realm: RealmDescribing {}
