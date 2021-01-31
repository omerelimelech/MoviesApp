//
//  UrlManager.swift
//  QuestionSomething
//
//  Created by Omer Elimelech on 21/12/2019.
//  Copyright © 2019 Omer Elimelech. All rights reserved.
//

import Foundation

enum MediaType {
    case profilePicture
    case postImage(String)
}
struct UrlManager {

    static let shared = UrlManager()
    
    let baseUrl: String = "http://www.omdbapi.com/"
        private func fotmattedString(string: String, withParam param: String) -> String {
            return String(format: string, param)
        }
    
    func url() -> URLComponents {
        guard let url = URLComponents(string: baseUrl) else {
            return URLComponents(string: "")!
        }
        return url
    }

   }
