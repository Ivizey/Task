//
//  BreweryDB.swift
//  Breweries
//
//  Created by Pavel Bondar on 18.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//
import Foundation

//@objcMembers
//class BreweryObject: Object {
//    dynamic var id = Int()
//    dynamic var name = String()
//    dynamic var breweryType = String()
//    dynamic var street = String()
//    dynamic var city = String()
//    dynamic var state = String()
//    dynamic var postalCode = String()
//    dynamic var country = String()
//    dynamic var longitude = Double()
//    dynamic var latitude = Double()
//    dynamic var phone = String()
//    dynamic var websiteUrl = String()
//    dynamic var updatedAt = String()
//    var tagList = List<String>()
//}
//
//protocol BreweriesStorage: class {
//    func save(brewery: BreweryObject)
//    func obtainBrewery() -> [Brewery]
//    func saveBrewerys(brewery: [Brewery]) -> [Brewery]
//    func clearAll()
//}
//
//class BreweriesStorageImpl: BreweriesStorage {
//    lazy var mainRealm: RealmDescribing =  {
//        let config = Realm.Configuration(schemaVersion: 2)
//        Realm.Configuration.defaultConfiguration = config
//        return try! Realm(configuration: .defaultConfiguration)
//    }()
//    // MARK: - save
//    func save(brewery: BreweryObject) {
//        do {
//            try mainRealm.write {
//                mainRealm.add(brewery)
//            }
//        } catch {
//            print("Error: \(error.localizedDescription)")
//        }
//    }
//    // MARK: - clearAll
//    func clearAll() {
//        if obtainBrewery().isEmpty {
//            print("Error: DB is empty!")
//        } else {
//            do {
//                try mainRealm.write {
//                    mainRealm.deleteAll()
//                }
//            } catch {
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }
//    // MARK: - saveBrewerys
//    func saveBrewerys(brewery: [Brewery]) -> [Brewery] {
//        brewery.forEach {
//            let brewer = BreweryObject(
//                value: [
//                    $0.id,
//                    $0.name,
//                    $0.breweryType,
//                    $0.street,
//                    $0.city,
//                    $0.state,
//                    $0.postalCode,
//                    $0.country,
//                    $0.longitude,
//                    $0.latitude,
//                    $0.phone,
//                    $0.websiteUrl,
//                    $0.updatedAt,
//                    $0.tagList
//                ]
//            )
//            self.save(brewery: brewer)
//        }
//        return obtainBrewery()
//    }
//    // MARK: - obtainBrewery
//    func obtainBrewery() -> [Brewery] {
//        let models = mainRealm.objects(BreweryObject.self)
//        var breweries = [Brewery]()
//        models.forEach {
//            let brewery = Brewery(
//                id: $0.id,
//                name: $0.name,
//                breweryType: $0.breweryType,
//                street: $0.street,
//                city: $0.city,
//                state: $0.state,
//                postalCode: $0.postalCode,
//                country: $0.country,
//                longitude: $0.longitude,
//                latitude: $0.latitude,
//                phone: $0.phone,
//                websiteUrl: $0.websiteUrl,
//                updatedAt: $0.updatedAt,
//                tagList: Array($0.tagList))
//            breweries.append(brewery)
//        }
//        return Array(breweries)
//    }
//}
