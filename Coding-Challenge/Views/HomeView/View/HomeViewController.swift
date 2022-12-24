//
//  HomeViewController.swift
//  Coding-Challenge
//
//  Created by Javier  on 24/12/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var filterTVShowsView: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    
    private let viewModel: HomeViewModelRepresentable
    
    init(viewModel: HomeViewModelRepresentable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
