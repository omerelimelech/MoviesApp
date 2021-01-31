//
//  JsonCodable.swift
//
//  Created by Omer Elimelech on 12/08/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

protocol JsonCodable: Codable {
    var method: HTTPMethod { get }
    func encode() -> [String: Any]
}

extension JsonCodable {
    var method: HTTPMethod {
        return .get
    }
    
    func encode() -> [String: Any] {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let jsonObj = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any]
            return jsonObj!
        } catch {
            print ("decode error")
        }
        return [:]
    }
}
