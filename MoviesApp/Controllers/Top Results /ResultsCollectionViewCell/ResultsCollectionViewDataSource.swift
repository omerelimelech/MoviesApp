//
//  ResultsCollectionViewDataSource.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation
import UIKit

class ResultsCollectionViewDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    weak var collectionView: UICollectionView!
    var dataSource: [SearchElement]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var itemWidth: CGFloat {
        return UIScreen.main.bounds.width * Constants.itemRatio
    }
    
    var itemHeight: CGFloat {
        return UIScreen.main.bounds.height * Constants.itemRatio
    }
    
    struct Constants {
        static let itemRatio: CGFloat = 0.7
        static let sideItemScale: CGFloat  = 0.8
        static let sideItemAlpha: CGFloat = 1
        static let sideItemShift: CGFloat = 0
        static let fixedSpace: CGFloat = 8
    }
    
    var onScroll: ((_ offset: CGPoint) -> Void)?
    var onMovieSelected: ((_ movieDatil: MovieDetail) -> Void)?
    var onShouldFetchMovieDetail: ((_ id: String, _ on: ResultsCollectionViewCell) -> Void)?
    var onShouldLoadMore: (() -> Void)?
    init(collectionView: UICollectionView, dataSource: [SearchElement]?) {
        super.init()
        self.collectionView = collectionView
        self.dataSource = dataSource
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nibName: ResultsCollectionViewCell.reuseId)
    }
    
    func setupCollectionViewLayout() {
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        layout.sideItemScale = Constants.sideItemScale
        layout.sideItemAlpha = Constants.sideItemAlpha
        layout.sideItemShift = Constants.sideItemShift
        layout.spacingMode = .fixed(spacing: Constants.fixedSpace)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsCollectionViewCell.reuseId, for: indexPath) as? ResultsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.onSeeAllDetaillsTapped = {  [weak self] (movie) in
            guard let self = self else { return }
            self.onMovieSelected?(movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let current = scrollView.contentOffset.x
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout {
            let diff = collectionView.frame.width / (layout.itemSize.width + layout.minimumLineSpacing)
            onScroll?(CGPoint(x: (current * diff).rounded(.up), y: scrollView.contentOffset.y))
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let item = dataSource?[indexPath.item], let id = item.imdbID else { return }
        if let cell = cell as? ResultsCollectionViewCell {
            onShouldFetchMovieDetail?(id, cell)
        }
        if let dataSource = dataSource{
            if dataSource.count - 1 == indexPath.item {
                onShouldLoadMore?()
            }
        }
    }
    
}
