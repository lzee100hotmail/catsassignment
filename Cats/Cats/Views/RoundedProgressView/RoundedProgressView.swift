//
//  RoundedProgressView.swift
//  Cats
//
//  Created by Leo van der Zee on 10/07/2023.
//

import Foundation
import UIKit

class RoundedProgressView: UIProgressView {
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach { subview in
            subview.layer.masksToBounds = true
            subview.layer.cornerRadius = bounds.height / 2.0
        }
    }
}
