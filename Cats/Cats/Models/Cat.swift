//
//  Cat.swift
//  Cats
//
//  Created by Leo van der Zee on 09/07/2023.
//

import Foundation

typealias Cats = [Cat]

struct Cat: Codable, Hashable {
    
    let name: String
    let description: String
    let adaptability, affectionLevel, childFriendly, dogFriendly: Int?

    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case description
        case adaptability
        case affectionLevel
        case childFriendly
        case dogFriendly
    }
    
    init(
        name: String,
        description: String,
        adaptability: Int?,
        affectionLevel: Int?,
        childFriendly: Int?,
        dogFriendly: Int?
    ) {
        self.name = name
        self.description = description
        self.adaptability = adaptability
        self.affectionLevel = affectionLevel
        self.childFriendly = childFriendly
        self.dogFriendly = dogFriendly
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        adaptability = try container.decodeIfPresent(Int.self, forKey: .adaptability)
        affectionLevel = try container.decodeIfPresent(Int.self, forKey: .affectionLevel)
        childFriendly = try container.decodeIfPresent(Int.self, forKey: .childFriendly)
        dogFriendly = try container.decodeIfPresent(Int.self, forKey: .dogFriendly)
    }
}
