//
//  TopMoviesDetailCollectionViewCell.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import UIKit
import Cosmos

class ResultsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var likeButton: LikeButton!
    static let reuseId = "ResultsCollectionViewCell"
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    var movieDetail: MovieDetail?
    var onSeeAllDetaillsTapped: ((_ movie: MovieDetail) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(item: MovieDetail?) {
        movieDetail = item
        movieImageView.kf.setImage(with: URL(string: item?.poster ?? ""), placeholder: UIImageView.placeHolderImage)
        movieTitleLabel.text = item?.title
        likeButton.isSelected = item?.isSaved ?? false
        likeButton.movieId = item?.imdbID
        if let rating = item?.imdbRating, let doubleRating = Double(rating) {
            ratingView.rating = doubleRating / 2
        }
        typeLabel.text = item?.type?.rawValue.capitalized
        timeLabel.text = item?.runtime
        yearLabel.text = item?.year
    }
    
    @IBAction func fullDetailsTapped(_ sender: UIButton) {
        guard let movieDetail = movieDetail else { return }
        onSeeAllDetaillsTapped?(movieDetail)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movieImageView.image = nil
    }

}
