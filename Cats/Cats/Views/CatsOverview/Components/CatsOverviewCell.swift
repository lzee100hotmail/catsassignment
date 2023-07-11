//
//  CatsOverviewCell.swift
//  Cats
//
//  Created by Leo van der Zee on 09/07/2023.
//

import Foundation
import SnapKit
import UIKit

class CatsOverviewCell: UICollectionViewCell {
    
    static let identifier = "CatsOverviewCell"
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let stackView = UIStackView()

    private let titleLabelFontSize: CGFloat = 18
    private let infinityNumberOfLines: Int = 0
    private let shadowOpacity: Float = 0.2
    private let shadowRadius: CGFloat = 3
    private let cornerRadius: CGFloat = 10
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }
        stackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(_ viewModel: CatsOverviewCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        viewModel.rangeAttributes.map {
            CatRangeRowView(viewModel: CatRangeRowViewModel(
                descriptionText: $0.description,
                scaleValue: $0.range)
            )
        }.forEach { stackView.addArrangedSubview($0) }
    }
    
    private func applyStyle() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabelFontSize)
        descriptionLabel.numberOfLines = infinityNumberOfLines
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = Style.Padding.small.rawValue
    }
    
    private func layoutViews() {
        [titleLabel, descriptionLabel, stackView].forEach { contentView.addSubview($0) }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(titleLabel.font.lineHeight)
            make.leading.top.equalTo(contentView).offset(Style.Padding.normal.rawValue)
            make.trailing.equalTo(contentView).offset(-Style.Padding.normal.rawValue)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-Style.Padding.normal.rawValue)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Style.Padding.normal.rawValue)
            make.trailing.equalTo(contentView).offset(-Style.Padding.normal.rawValue)
            make.bottom.equalTo(stackView.snp.top).offset(-Style.Padding.normal.rawValue)
        }
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Style.Padding.normal.rawValue)
            make.trailing.equalTo(contentView).offset(-Style.Padding.normal.rawValue)
            make.bottom.equalTo(contentView).offset(-Style.Padding.normal.rawValue)
        }
    }
}
