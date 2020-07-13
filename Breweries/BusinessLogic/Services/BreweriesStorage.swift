//
//  BreweriesStorage.swift
//  Breweries
//
//  Created by Pavel Bondar on 18.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//
import Foundation
import RealmSwift

protocol BreweriesStorage: class {
    func cache(_ objects: [Object])
    func retrieveObjects<T: Object>(by type: T.Type) -> [T]
}

class BreweriesStorageImpl: BreweriesStorage {
    // Store objects to Realm data base
    func cache(_ objects: [Object]) {
        let realm = try! Realm()
        try? realm.write {
            realm.add(objects, update: .modified)
        }
    }
    
    // Fetch data from Realm data base
    func retrieveObjects<T: Object>(by type: T.Type) -> [T] {
        let realm = try! Realm()
        return Array(realm.objects(type))
    }
}
