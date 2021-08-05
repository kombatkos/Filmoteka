//
//  DetailCollectionViewController.swift
//  Filmoteka
//
//  Created by Konstantin Porokhov on 04.08.2021.
//

import UIKit

protocol DetailCollectionViewControllerViewModelType {
    func createViewModelForSectionHeader(_ indexPath: IndexPath) -> DetailSectionHeaderViewModelType
}

class DetailCollectionViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<DetailSection, InfoModel>?
    var viewModel: DetailCollectionViewControllerViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        reloadData()
    }
}

// MARK: - Create DataSource
extension DetailCollectionViewController {
    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<DetailSection, InfoModel>(collectionView: collectionView ?? UICollectionView(), cellProvider: { collectionView, indexPath, info in
            guard let sections = DetailSection(rawValue: indexPath.section) else {
                fatalError("Section is not kind")
            }
            switch sections {
            case .posters:
                return UICollectionViewCell()
            case .trailers:
                return UICollectionViewCell()
            case .info:
                return UICollectionViewCell()
            }
        })
        
        dataSource?.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath in
            guard let detailSectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailSectionHeader.reuseId, for: indexPath) as? DetailSectionHeader else {
                fatalError("Unknown section kind")
            }
            let vm = self?.viewModel?.createViewModelForSectionHeader(indexPath)
            detailSectionHeader.viewModel = vm
            return detailSectionHeader
        }
    }
    
    func reloadData() {
        let snapshot = NSDiffableDataSourceSnapshot<DetailSection, InfoModel>()
        
        
        dataSource?.apply(snapshot)
    }
}

// MARK: - Setup CollectionView
extension DetailCollectionViewController {
    
    func setupCollectionView() {
        collectionView = DetailCollectionView(frame: view.bounds)
        view.addSubview(collectionView ?? UICollectionView())
        
        
    }
}
