//
//  Brewery.swift
//  Breweries
//
//  Created by Pavel Bondar on 29.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import RealmSwift

@objcMembers
public class Brewery: Object, Codable {
    dynamic var id: Int = 0
    dynamic var name: String? = nil
    dynamic var breweryType: String? = nil
    dynamic var street: String? = nil
    dynamic var city: String? = nil
    dynamic var state: String? = nil
    dynamic var postalCode: String? = nil
    dynamic var country: String? = nil
    dynamic var longitude: String? = nil
    dynamic var latitude: String? = nil
    dynamic var phone: String? = nil
    dynamic var websiteUrl: String? = nil
    dynamic var updatedAt: String? = nil
    var tagList: List<String> = List()
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case breweryType = "brewery_type"
        case street
        case city
        case state
        case postalCode = "postal_code"
        case country
        case longitude
        case latitude
        case phone
        case websiteUrl = "website_url"
        case updatedAt = "updated_at"
        case tagList = "tag_list"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        self.breweryType = try? container.decode(String.self, forKey: .breweryType)
        self.street = try? container.decode(String.self, forKey: .street)
        self.city = try? container.decode(String.self, forKey: .city)
        self.state = try? container.decode(String.self, forKey: .state)
        self.postalCode = try? container.decode(String.self, forKey: .postalCode)
        self.country = try? container.decode(String.self, forKey: .country)
        self.longitude = try? container.decode(String.self, forKey: .longitude)
        self.latitude = try? container.decode(String.self, forKey: .latitude)
        self.phone = try? container.decode(String.self, forKey: .phone)
        self.websiteUrl = try? container.decode(String.self, forKey: .websiteUrl)
        self.updatedAt = try? container.decode(String.self, forKey: .updatedAt)
        self.tagList = try container.decode(List<String>.self, forKey: .tagList)
    }
}
