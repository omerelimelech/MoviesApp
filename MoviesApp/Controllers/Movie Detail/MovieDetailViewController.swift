//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation
import UIKit
import Cosmos
import ReadMoreTextView

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var accessibilityDetailLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var plotTextView: ReadMoreTextView!
    @IBOutlet weak var likeButton: LikeButton!
    
    var movieDetail: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(movieDetail: movieDetail)
    }
    
    func configure(movieDetail: MovieDetail?) {
        guard let movieDetail = movieDetail else { return }
        movieImageView.kf.setImage(with: URL(string: movieDetail.poster ?? ""))
        movieTitleLabel.text = movieDetail.title
        directorLabel.text = movieDetail.director
        yearLabel.text = movieDetail.year
        genreLabel.text = movieDetail.genre
        if let rating = movieDetail.imdbRating, let doubleRating = Double(rating) {
            ratingLabel.text = String(format: "%.1f/%d", doubleRating, 10)
            ratingView.rating = doubleRating / 2
        }
        castLabel.text = movieDetail.actors
        timeLabel.text = movieDetail.runtime
        accessibilityDetailLabel.text = movieDetail.rated
        typeLabel.text = movieDetail.type?.rawValue.capitalized
        plotTextView.text = movieDetail.plot
        likeButton.movieId = movieDetail.imdbID
        likeButton.isSelected = movieDetail.isSaved
    }
    
    func setupTextView() {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]
        plotTextView.attributedReadMoreText = NSAttributedString(string: plotTextView.readMoreText ?? "", attributes: attributes)
        plotTextView.attributedReadLessText = NSAttributedString(string: plotTextView.readLessText ?? "", attributes: attributes)
        plotTextView.onSizeChange = { [weak self] (textView) in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
