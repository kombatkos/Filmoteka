//
//  CollectionViewController.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 22.07.2021.
//

import UIKit

protocol CollectionViewControllerViewModelType {
    var delegate: INotViewedViewController? { get set }
    func loadData()
    func generatedViewModelForDetailVC(indexPath: IndexPath) -> DetailViewControllerViewModelType?
    func generatedViewModelForVerticalCell(_ film: FilmModel) -> VerticalCellViewModelType?
    func generatedViewModelForHorizontalCell(_ film: FilmModel) -> HorizontalCellViewModelType?
}

protocol INotViewedViewController: AnyObject {
    func reloadData(topFilm: [FilmModel], popularFilm: [FilmModel])
}

class CollectionViewController: UIViewController {
    
    var collectionView: UICollectionView?
    
    var viewModel: CollectionViewControllerViewModelType?
    var dataSource: UICollectionViewDiffableDataSource<CategoryFilms, FilmModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Media"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel = CollectionViewControllerViewModel()
        viewModel?.loadData()
        setupCollectionView()
        createDataSource()
        viewModel?.delegate = self
    }
}
// MARK: - Data Source
extension CollectionViewController {
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CategoryFilms, FilmModel>(collectionView: collectionView ?? UICollectionView(), cellProvider: { (collectionView, indexPath, film) -> UICollectionViewCell? in
            guard let section = CategoryFilms(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .topFilms:
                let horizonVM = self.viewModel?.generatedViewModelForHorizontalCell(film)
                return self.configure(collectionView: collectionView, cellType: HorizontalCell.self, with: horizonVM, for: indexPath)
            case .popularFilms:
                let verticalVM = self.viewModel?.generatedViewModelForVerticalCell(film)
                return self.configure(collectionView: collectionView, cellType: VerticalCell.self, with: verticalVM, for: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header") }
            guard let section = CategoryFilms(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            sectionHeader.configure(text: section.description(),
                                    font: .systemFont(ofSize: 20),
                                    textColor: #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1))
            
            return sectionHeader
        }
    }
}

// MARK: - Setup CollectionView
extension CollectionViewController: INotViewedViewController {
    
    private func setupCollectionView() {
        collectionView = CollectionView(frame: view.bounds)
        view.addSubview(collectionView ?? UICollectionView())
        
        let popularFilmsNib = UINib(nibName: String(describing: VerticalCell.self), bundle: nil)
        collectionView?.register(popularFilmsNib, forCellWithReuseIdentifier: VerticalCell.reuseId)
        
        let topfilmsNib = UINib(nibName: String(describing: HorizontalCell.self), bundle: nil)
        collectionView?.register(topfilmsNib, forCellWithReuseIdentifier: HorizontalCell.reuseId)
        
        collectionView?.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        
        collectionView?.delegate = self
    }
    
    func reloadData(topFilm: [FilmModel], popularFilm: [FilmModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<CategoryFilms, FilmModel>()
        snapshot.appendSections([.topFilms, .popularFilms])
        snapshot.appendItems(topFilm, toSection: .topFilms)
        snapshot.appendItems(popularFilm, toSection: .popularFilms)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegate
extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "DetailNotViewed", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailNotViewed") as? DetailViewController else { return }
        
        let vm = viewModel?.generatedViewModelForDetailVC(indexPath: indexPath)
        vc.viewModel = vm
        
        navigationController?.pushViewController(vc, animated: true)
    }

}
