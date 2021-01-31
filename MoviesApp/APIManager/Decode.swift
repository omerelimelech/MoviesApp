//
//  Decode.swift
//  MoviesApp
//
//  Created by Omer Elimelech on 31/01/2021.
//

import Foundation

func decode<T : Codable>(withObj obje: T.Type, json: [String: Any]) throws -> T?{
    let decoder = JSONDecoder()
    do {
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let obj = try decoder.decode(obje.self, from: data)
        return obj
    } catch {
        print(error.localizedDescription)
        throw error
    }
}
