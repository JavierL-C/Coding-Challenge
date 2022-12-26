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
    private var subscription: AnyCancellable?
    private var dataSource: DataSource?
    private var filterTVShow: FilterTVShows = .popular {
        didSet {
            self.viewModel.fetchTVShows(filter: filterTVShow)
        }
    }
    
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
                                                  heightDimension: .fractionalHeight(1.0))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(350))

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
        filterTVShowsView.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        view.backgroundColor = UIColor(named: "Almost Black")
        viewModel.fetchTVShows(filter: filterTVShow)
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(named: "Almost Black")
        collectionView.collectionViewLayout = generateLayout()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setUpDiffableDataSource()
    }
    
    private func bindUI() {
        subscription = viewModel.tvShowsSubject.sink { _ in}
        receiveValue: { [unowned self] tvShows in
            applySnapshot(tvShows: tvShows)
        }
    }
    
    private func setUpDiffableDataSource() {
        let tvShowCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, TVShow> { [weak self]  cell, _, tvShow in
            self?.setSwiftUIView(cell: cell, tvShow: tvShow)
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
    
    private func setSwiftUIView(cell: UICollectionViewCell, tvShow: TVShow) {
        let hostingController = UIHostingController(rootView: TVShowCellView(tvShow: tvShow))
        cell.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        [
            hostingController.view.topAnchor.constraint(equalTo: cell.topAnchor),
            hostingController.view.rightAnchor.constraint(equalTo: cell.rightAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: cell.leftAnchor)
        ].forEach { $0.isActive = true }
    }
    
    @IBAction func filterTVShowValueChanged(_ sender: UISegmentedControl) {
        filterTVShow = FilterTVShows(rawValue: sender.selectedSegmentIndex) ?? .popular
    }
    
    @IBAction func onClickOptionButton(_ sender: UIButton) {
        let alert =  UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log Out", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            self.dismiss(animated: true)
        }))

        self.present(alert, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let numberOfItems = dataSource?.snapshot().numberOfItems,
           indexPath.row == numberOfItems - 5 {
            viewModel.fetchTVShows(filter: filterTVShow)
        }
    }
}
