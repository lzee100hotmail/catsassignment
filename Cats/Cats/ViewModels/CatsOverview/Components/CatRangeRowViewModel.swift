//
//  CatRangeRowViewModel.swift
//  Cats
//
//  Created by Leo van der Zee on 10/07/2023.
//

import Foundation

class CatRangeRowViewModel {
    
    let descriptionText: String
    let scaleValue: Float
    
    init(descriptionText: String, scaleValue: Int) {
        self.descriptionText = descriptionText
        self.scaleValue =  1 / 5 * Float(scaleValue)
    }
}
