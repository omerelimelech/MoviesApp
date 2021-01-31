//
//  ResultsBackgroundImageDataSource.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation
import UIKit


class ResultsBackgroundImageDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var collectionView: UICollectionView!
    var dataSource: [SearchElement]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(collectionView: UICollectionView, dataSource: [SearchElement]?) {
        super.init()
        self.collectionView = collectionView
        self.dataSource = dataSource
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(nibName: ResultsBackgroundImageCollectionViewCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsBackgroundImageCollectionViewCell.reuseId, for: indexPath) as? ResultsBackgroundImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.kf.setImage(with: URL(string: dataSource?[indexPath.row].poster ?? ""), placeholder: UIImageView.placeHolderImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
