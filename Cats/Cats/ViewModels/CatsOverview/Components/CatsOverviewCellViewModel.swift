//
//  CatsOverviewCellViewModel.swift
//  Cats
//
//  Created by Leo van der Zee on 09/07/2023.
//

import Foundation
import UIKit

class CatsOverviewCellViewModel {
    
    struct Labels {
        static let affectionLevel = "Affection level"
        static let adaptability = "Adaptability"
        static let childFriendly = "Child friendly"
        static let dogFriendly = "Dog friendly"
    }
    
    private let cat: Cat
    var title: String {
        cat.name
    }
    var description: String {
        cat.description
    }
    
    private(set) var rangeAttributes: [(description: String, range: Int)] = []
    
    init(cat: Cat) {
        self.cat = cat
        if let adaptability = cat.adaptability {
            rangeAttributes.append((Labels.adaptability, adaptability))
        }
        if let affectionLevel = cat.affectionLevel {
            rangeAttributes.append((Labels.affectionLevel, affectionLevel))
        }
        if let childFriendly = cat.childFriendly {
            rangeAttributes.append((Labels.childFriendly, childFriendly))
        }
        if let dogFriendly = cat.dogFriendly {
            rangeAttributes.append((Labels.dogFriendly, dogFriendly))
        }
    }
}
