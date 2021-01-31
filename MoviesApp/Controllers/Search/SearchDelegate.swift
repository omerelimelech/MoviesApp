//
//  SearchDelegate.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation

protocol SearchDelegate: class {
    func serachPresenter(_ presenter: SearchPresenter, didFetchViewModel viewModel: SearchMoviesDTO.ViewModel, request: SearchMoviesDTO.Request)
    func searchPresenter(_ presenter: SearchPresenter)
}
