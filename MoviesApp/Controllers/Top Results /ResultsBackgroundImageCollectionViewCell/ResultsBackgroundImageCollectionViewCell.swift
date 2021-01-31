//
//  MovieImageCollectionViewCell.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import UIKit

class ResultsBackgroundImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    static let reuseId = "ResultsBackgroundImageCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
