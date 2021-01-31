//
//  ViewController.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 29/01/2021.
//

import UIKit
import Kingfisher

class ResultsViewController: UIViewController {

    @IBOutlet weak var topResultTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var presenter: ResultsPresenter!
    var prevRequest: SearchMoviesDTO.Request!
    var viewModel: SearchMoviesDTO.ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topResultTopConstraint.constant = view.frame.height
        self.presenter = ResultsPresenter(delegate: self)
        self.presenter?.setupResultsCollectionView(collectionView: moviesCollectionView, viewModel: viewModel)
        self.presenter?.setupBackgroundCollectionView(collectionView: collectionView, viewModel: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.reloadData(viewModel: viewModel)
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ResultsViewController: ResultsDelegate {
    func resultsPresenterShouldLoadMore(_ presenter: ResultsPresenter) {
        guard let request = self.prevRequest else { return }
        presenter.search(request: request)
        
    }
    
    func resultsPresenter(_ presenter: ResultsPresenter, didFetchSearch result: SearchMoviesDTO.ViewModel, request: SearchMoviesDTO.Request) {
        self.prevRequest = request
        presenter.appendData(viewModel: result)
    }
    
    func resultsPresetner(_ presenter: ResultsPresenter, didFailFetchSearchWith error: APIError?) {
        self.present(UIAlertController.serverError(), animated: true, completion: nil)
    }
    
    func resultsPresnter(_ presenter: ResultsPresenter, didSelectMovie movie: MovieDetail) {
        let vc = UIStoryboard.instantiateViewController(type: MovieDetailViewController.self, storyBoard: .main)
        vc.movieDetail = movie
        self.present(vc, animated: true, completion: nil)
    }
    
    func resultsPresenterDidReloadData(_ presenter: ResultsPresenter) {
        collectionView.reloadData()
        self.topResultTopConstraint?.constant = 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4 , options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }){ _ in }
    }
    
    func resultsPresenter(_ presenter: ResultsPresenter, didScrollTo point: CGPoint) {
        self.collectionView.contentOffset = point
    }
    
    
}
