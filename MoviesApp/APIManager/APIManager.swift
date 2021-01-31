//
//  APIManager.swift
//  QuestionSomething
//
//  Created by Omer Elimelech on 21/12/2019.
//  Copyright © 2019 Omer Elimelech. All rights reserved.
//

import Foundation
import Alamofire

typealias completion = (_ result: Result<Any?, Error>) -> Void
typealias responseCompletion<T: Codable> = (_ result: T?, _ error: APIError?) -> Void
typealias parameters = [String: Any]
typealias HTTPMethod = Alamofire.HTTPMethod

class APIManager: NSObject {
    
    static let shared = APIManager()
    private let Alamofire = AF
    
    func request<T: Codable>(request: JsonCodable, responseDTO: T.Type, completion: @escaping responseCompletion<T>) {
        baseRequest(withRequest: request) { [weak self] (result) in
            guard let self = self else { return }
            self.handleResult(result: result, type: responseDTO, completion: completion)
        }
    }

}

// MARK: Base requests
extension APIManager {

    func baseRequest(withRequest req: JsonCodable, completion: @escaping completion) {
        var url = UrlManager.shared.url()
        let params = req.encode()
        let method = req.method
        print("PARAMS: \(params)")
        url.queryItems = params.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        guard let requestUrl = try? url.asURL() else { return }
        var request = URLRequest(url: requestUrl)
        request.url = requestUrl
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(request).responseJSON { [weak self] (response) in
            guard let _ = self else { return }
            switch response.result {
            case .success(let json):
                completion(.success(json))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func handleResult<T: Codable>(result: Result<Any?, Error>, type: T.Type, completion: @escaping responseCompletion<T>) {
        switch result {
        case .success(let jsonResponse):
            guard let json = jsonResponse as? [String: Any] else {
                completion(nil, .serverError)
                return
            }
            do {
                let obj = try decode(withObj: type, json: json)
                completion(obj, nil)
            } catch {
                guard let obj = try? decode(withObj: ServerError.self, json: json) else { return }
                completion(nil, .decodeError(obj))
            }
        case .failure:
            completion(nil, .serverError)
        }
    }
}
