//
//  University.swift
//  UniversityListing
//
//  Created by Mohammad Aftab Sabir on 04/06/24.
//

import Foundation
import RealmSwift

// Class to handle array elements as Realm doesn't support arrays of primitive types directly
class RealmString: Object, Codable {
    @objc dynamic var value: String = ""
    
    convenience init(value: String) {
        self.init()
        self.value = value
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.singleValueContainer()
        self.value = try container.decode(String.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}

// Main University class
class University: Object, Codable {
    @objc dynamic var countryCode: String = ""
    let domains = List<RealmString>()
    @objc dynamic var name: String = ""
    let webPages = List<RealmString>()
    @objc dynamic var country: String = ""
    @objc dynamic var state: String? = nil
    
    // Convenience initializer for easier object creation
    convenience init(countryCode: String, domains: [String], name: String, webPages: [String], country: String, state: String?) {
        self.init()
        self.countryCode = countryCode
        self.domains.append(objectsIn: domains.map { RealmString(value: $0) })
        self.name = name
        self.webPages.append(objectsIn: webPages.map { RealmString(value: $0) })
        self.country = country
        self.state = state
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        let domainValues = try container.decode([String].self, forKey: .domains)
        self.domains.append(objectsIn: domainValues.map { RealmString(value: $0) })
        self.name = try container.decode(String.self, forKey: .name)
        let webPageValues = try container.decode([String].self, forKey: .webPages)
        self.webPages.append(objectsIn: webPageValues.map { RealmString(value: $0) })
        self.country = try container.decode(String.self, forKey: .country)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(domains.map { $0.value }, forKey: .domains)
        try container.encode(name, forKey: .name)
        try container.encode(webPages.map { $0.value }, forKey: .webPages)
        try container.encode(country, forKey: .country)
        try container.encode(state, forKey: .state)
    }
    
    private enum CodingKeys: String, CodingKey {
        case countryCode = "alpha_two_code"
        case domains
        case name
        case webPages = "web_pages"
        case country
        case state = "state-province"
    }
    
        override static func primaryKey() -> String? {
            return "name"
        }
}
