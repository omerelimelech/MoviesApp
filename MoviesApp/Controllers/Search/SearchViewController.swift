//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var movieTitleTextfield: UITextField!
    @IBOutlet weak var yearTextfield: UITextField!
    
    var presenter: SearchPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = SearchPresenter(delegate: self)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let movieTitle = movieTitleTextfield.text, movieTitle.count > 0 else {
            self.present(UIAlertController.movieTitleMissing(), animated: true, completion: nil)
            return
        }
        self.presenter?.search(title: movieTitle, year: yearTextfield.text, page: 1)
    }
}

extension SearchViewController: SearchDelegate {
    func serachPresenter(_ presenter: SearchPresenter, didFetchViewModel viewModel: SearchMoviesDTO.ViewModel, request: SearchMoviesDTO.Request) {
        let vc = UIStoryboard.instantiateViewController(type: ResultsViewController.self, storyBoard: .main)
        vc.viewModel = viewModel
        vc.prevRequest = request
        self.present(vc, animated: true, completion: nil)
    }
    
    func searchPresenter(_ presenter: SearchPresenter) {
        self.present(UIAlertController.serverError(), animated: true, completion: nil)
    }
    
    
}
