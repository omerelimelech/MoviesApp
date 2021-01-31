//
//  SearchPresenter.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 30/01/2021.
//

import Foundation

class SearchPresenter {
    
    weak var delegate: SearchDelegate?
    
    let model = SearchModel()
    
    init(delegate: SearchDelegate?) {
        self.delegate = delegate
    }
    
    func search(title: String, year: String?, page: Int) {
        let request = SearchMoviesDTO.Request(title: title, year: year, page: page)
        model.search(request: request) { [weak self] (response, error) in
            guard let self = self else { return }
            guard let response = response, response.response != "False" else {
                self.delegate?.searchPresenter(self)
                return
            }
            let viewModel = SearchMoviesDTO.ViewModel(response: response)
            self.delegate?.serachPresenter(self, didFetchViewModel: viewModel, request: request)
        }
    }
    
}
