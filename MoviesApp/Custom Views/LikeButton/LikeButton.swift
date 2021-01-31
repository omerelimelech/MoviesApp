//
//  LikeButton.swift
//
//  Created by Omer Elimelech on 03/09/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

class LikeButton: BaseButton {

    @IBOutlet weak var button: UIButton!

    var presenter: LikeButtonPresenter!

    var movieId: String?
    override var isSelected: Bool {
        willSet {
            self.button.setImage(UIImage(named: newValue ? "black-heart-filled" : "black-heart-not-filled"), for: .normal)
        }
    }

    var onChangeState: (() -> Void)?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()

    }

    override func initialConfig() {
        super.initialConfig()
        self.presenter = LikeButtonPresenter(delegate: self)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
    }

    @objc func tapped() {
        guard let id = movieId else { return }
        presenter?.likeButtonTapped(isSelected: button.image(for: .normal) == UIImage(named: "black-heart-filled") , movieId: id)
    }
}

extension LikeButton: LikeButtonDelegate {
    func likeButtonPresenter(_ presenter: LikeButtonPresenter, didAddToFavorites success: Bool) {
        isSelected = success
        
    }
    
    func likeButtonPresenter(_ presenter: LikeButtonPresenter, didRemoveFromFavorites success: Bool) {
        isSelected = !success
    }
    
}
