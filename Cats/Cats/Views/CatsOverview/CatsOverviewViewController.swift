//
//  CatsOverviewViewController.swift
//  Cats
//
//  Created by Leo van der Zee on 09/07/2023.
//

import UIKit
import Combine
import SnapKit

class CatsOverviewViewController: UIViewController {
    
    private let activityIndicatorView = UIActivityIndicatorView()
    private lazy var dataSource: UICollectionViewDiffableDataSource<CatsOverviewSection, Cat> = {
        UICollectionViewDiffableDataSource(collectionView: collectionView) { [unowned self] collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatsOverviewCell.identifier, for: indexPath) as? CatsOverviewCell else { fatalError("CatsOverviewCell not available") }
            cell.apply(CatsOverviewCellViewModel(cat: viewModel.cats[indexPath.row]))
            return cell
        }
    }()
    private lazy var collectionView: UICollectionView = {
        let padding = Style.Padding.normal.rawValue
        let leftRightPaddingCollectionView = padding * 2
        let estimatedHeight: CGFloat = 100
        let fractions: CGFloat = 1
        var safeAreaWidth: CGFloat {
            self.view.safeAreaLayoutGuide.layoutFrame.width
        }
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, enviroment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(safeAreaWidth - leftRightPaddingCollectionView),
                heightDimension: .estimated(200)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                leading: nil,
                top: .fixed(padding),
                trailing: nil,
                bottom: nil
            )
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(fractions),
                heightDimension: .estimated(estimatedHeight)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: padding,
                leading: padding,
                bottom: padding,
                trailing: padding
            )
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CatsOverviewCell.self, forCellWithReuseIdentifier: CatsOverviewCell.identifier)
        return collectionView
    }()

    private let viewModel: CatsOverviewViewModel
    private var cancables: [AnyCancellable] = []
    
    init(
        viewModel: CatsOverviewViewModel = CatsOverviewViewModel()
    ) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.systemGray6
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = nil
        bindViewModel()
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
    
    private func setupViewLayout() {
        [collectionView, activityIndicatorView].forEach { view.addSubview($0) }

        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        activityIndicatorView.snp.makeConstraints { make in
            make.top.equalTo(view).inset(Style.Padding.normal.rawValue)
            make.centerX.equalTo(view)
        }
    }
    
    private func bindViewModel() {
        viewModel.bind().sink { [weak self] state in
            self?.update(state)
        }.store(in: &cancables)
    }
    
    private func update(_ state: CatsOverviewViewModel.State) {
        switch state {
        case .loading:
            print("Do something with a loader") // TODO: implement loader
        case .loaded:
            updateCollectionView()
        case .error:
            print("Do something with a error") // TODO: implement error handling
        }
    }
    
    private func updateCollectionView() {
        var snapshot = NSDiffableDataSourceSnapshot<CatsOverviewSection, Cat>()
        let section = CatsOverviewSection.section
        snapshot.appendSections([section])
        snapshot.appendItems(viewModel.cats, toSection: section)
        dataSource.apply(snapshot)
    }
}
