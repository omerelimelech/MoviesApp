//
//  ResultsPresenter.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation
import UIKit

class ResultsPresenter {
    
    weak var delegate: ResultsDelegate?
    let movieDetailModel = MovieDetailModel()
    let searchModel = SearchModel()
    var resultsCollectionViewDatasource: ResultsCollectionViewDataSource!
    var backgroundImageCollectionViewDataSource: ResultsBackgroundImageDataSource!
    
    init(delegate: ResultsDelegate?) {
        self.delegate = delegate
    }
    
    func setupResultsCollectionView(collectionView: UICollectionView, viewModel: SearchMoviesDTO.ViewModel?) {
        self.resultsCollectionViewDatasource = ResultsCollectionViewDataSource(collectionView: collectionView, dataSource: viewModel?.searchResults)
        self.resultsCollectionViewDatasource?.onScroll = { [weak self] (point) in
            guard let self = self else { return }
            self.delegate?.resultsPresenter(self, didScrollTo: point)
        }
        self.resultsCollectionViewDatasource?.onMovieSelected = { [weak self] (movie) in
            guard let self = self else { return }
            self.delegate?.resultsPresnter(self, didSelectMovie: movie)
        }
        
        self.resultsCollectionViewDatasource?.onShouldFetchMovieDetail = { [weak self] (id, cell) in
            guard let self = self else { return }
            self.getMovieDetail(id: id, cell: cell)
        }
        
        self.resultsCollectionViewDatasource.onShouldLoadMore = { [weak self] in
            guard let self = self else { return }
            self.delegate?.resultsPresenterShouldLoadMore(self)
        }
    }
    
    func setupBackgroundCollectionView(collectionView: UICollectionView, viewModel: SearchMoviesDTO.ViewModel?) {
        self.backgroundImageCollectionViewDataSource = ResultsBackgroundImageDataSource(collectionView: collectionView, dataSource: viewModel?.searchResults)
    }
    
    func reloadData(viewModel: SearchMoviesDTO.ViewModel?) {
        self.resultsCollectionViewDatasource?.dataSource = viewModel?.searchResults
        self.backgroundImageCollectionViewDataSource?.dataSource = viewModel?.searchResults
        self.delegate?.resultsPresenterDidReloadData(self)
    }
    
    func appendData(viewModel: SearchMoviesDTO.ViewModel?) {
        self.resultsCollectionViewDatasource?.dataSource?.append(contentsOf: viewModel?.searchResults ?? [SearchElement()])
        self.backgroundImageCollectionViewDataSource?.dataSource?.append(contentsOf: viewModel?.searchResults ?? [SearchElement]())
    }
    
    private func getMovieDetail(id: String, cell: ResultsCollectionViewCell) {
        let request = MovieDetailDTO.Request(id: id)
        movieDetailModel.getMovieDetail(request: request) { [weak self] (response, error) in
            guard let _ = self else { return }
            if let response = response, error == nil {
                cell.configure(item: response.movieDeatil)
            }
        }
    }
    
    func search(request: SearchMoviesDTO.Request) {
        let req = SearchMoviesDTO.Request(title: request.title, type: request.type, year: request.year, page: (request.page ?? 1) + 1)
        searchModel.search(request: req) { [weak self] (response, error) in
            guard let self = self else { return }
            if let response = response, error == nil {
                let viewModel = SearchMoviesDTO.ViewModel(response: response)
                self.delegate?.resultsPresenter(self, didFetchSearch: viewModel, request: req)
            } else {
                self.delegate?.resultsPresetner(self, didFailFetchSearchWith: error)
            }
        }
    }
}
