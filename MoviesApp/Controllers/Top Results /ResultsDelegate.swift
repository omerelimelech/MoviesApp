//
//  ResultsDelegate.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation
import UIKit

protocol ResultsDelegate: class {
    func resultsPresenter(_ presenter: ResultsPresenter, didScrollTo point: CGPoint)
    func resultsPresenterDidReloadData(_ presenter: ResultsPresenter)
    func resultsPresnter(_ presenter: ResultsPresenter, didSelectMovie movie: MovieDetail)
    func resultsPresenterShouldLoadMore(_ presenter: ResultsPresenter)
    func resultsPresenter(_ presenter: ResultsPresenter, didFetchSearch result: SearchMoviesDTO.ViewModel, request: SearchMoviesDTO.Request)
    func resultsPresetner(_ presenter: ResultsPresenter, didFailFetchSearchWith error: APIError?)
}
