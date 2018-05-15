//
//  Property.swift
//  SentiaCodeTest
//
//  Created by Simeng Liu on 14/5/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import Foundation
import ObjectMapper

class Property: Mappable {
    
    var id: Int?
    var title: String?
    var bedrooms: Int?
    var bathrooms: Int?
    var carspots: Int?
    var description: String?
    var price: Double?
    var first_name: String?
    var last_name: String?
    var avatar_medium: String?
    var location_address_1: String?
    var location_address_2: String?
    var location_suburb: String?
    var location_postcode: String?
    var is_premium: Bool?
    var photo: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        bedrooms <- map["bedrooms"]
        bathrooms <- map["bathrooms"]
        carspots <- map["carspots"]
        description <- map["description"]
        price <- map["price"]
        first_name <- map["owner.first_name"]
        last_name <- map["owner.last_name"]
        avatar_medium <- map["owner.avatar.medium.url"]
        location_address_1 <- map["location.address_1"]
        location_address_2 <- map["location.address_2"]
        location_suburb <- map["location.suburb"]
        location_postcode <- map["location.postcode"]
        is_premium <- map["is_premium"]
        photo <- map["photo.image.small.url"]
    }
    
}
