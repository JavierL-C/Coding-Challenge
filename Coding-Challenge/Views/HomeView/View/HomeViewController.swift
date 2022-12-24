//
//  HomeViewController.swift
//  Coding-Challenge
//
//  Created by Javier  on 24/12/22.
//

import UIKit
import Combine
import SwiftUI

class HomeViewController: UIViewController {

    @IBOutlet var filterTVShowsView: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    
    private enum Section: CaseIterable {
        case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, TVShow>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TVShow>
    
    private let viewModel: HomeViewModelRepresentable
    private let refreshControl = UIRefreshControl()
    private var subscription: AnyCancellable?
    private var dataSource: DataSource?
    
    init(viewModel: HomeViewModelRepresentable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .estimated(200))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(200))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)

            return section
        }
        return layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindUI()
        // Do any additional setup after loading the view.
    }
    
    private func setUI() {
        title = "TV Shows"
        viewModel.fetchTVShows()
        collectionView.collectionViewLayout = generateLayout()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func bindUI() {
        subscription = viewModel.TVSHhowsSubject.sink { _ in}
        receiveValue: { [unowned self] tvShows in
            print(tvShows)
            applySnapshot(tvShows: tvShows)
        }
    }
    
    private func setUpDiffableDataSource() {
        let tvShowCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, TVShow> {  cell, _, tvShow in
            cell.backgroundColor = .red
        }
        
        dataSource = { [unowned self] in
            let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item ->  UICollectionViewCell in
                return collectionView.dequeueConfiguredReusableCell(using: tvShowCellRegistration, for: indexPath, item: item)
            }
            return dataSource
        }()
    }
    
    private func applySnapshot(tvShows: [TVShow]) {
        var snapshot = Snapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(tvShows, toSection: .main)
        dataSource?.apply(snapshot)
    }
}
