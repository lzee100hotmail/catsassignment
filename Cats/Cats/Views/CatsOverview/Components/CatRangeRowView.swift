//
//  CatRangeRowView.swift
//  Cats
//
//  Created by Leo van der Zee on 09/07/2023.
//

import Foundation
import UIKit
import SnapKit

class CatRangeRowView: UIView {
    private let labelWidth: CGFloat = 150
    private let viewmodel: CatRangeRowViewModel
    
    private let descriptionLabel = UILabel()
    private let progressView = RoundedProgressView()
    
    init(viewModel: CatRangeRowViewModel) {
        self.viewmodel = viewModel
        super.init(frame: .zero)
        layoutViews()
        applyValuesToView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutViews() {
        [descriptionLabel, progressView].forEach { addSubview($0) }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(self)
            make.trailing.equalTo(progressView.snp.leading).inset(-Style.Padding.normal.rawValue)
            make.width.equalTo(labelWidth)
            make.height.equalTo(descriptionLabel.font.lineHeight)
        }
        progressView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).inset(Style.Padding.normal.rawValue)
            make.height.equalTo(Style.Padding.normal.rawValue)
        }
    }
    
    private func applyValuesToView() {
        descriptionLabel.text = viewmodel.descriptionText
        progressView.progress = viewmodel.scaleValue
    }
}
