//
//  NetworkManager.swift
//  networkingTestProject
//
//  Created by Ilya Sokolov on 22.09.2022.
//

import Foundation


enum Link: String {
 case userURL = "https://rickandmortyapi.com/api/character/84"
 case imageURL = "https://rickandmortyapi.com/api/character/avatar/84.jpeg"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}

