//
//  NetworkManager.swift
//  networkingTestProject
//
//  Created by Ilya Sokolov on 22.09.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case charecterURL = "https://rickandmortyapi.com/api/character/84"
    case imageURL = "https://rickandmortyapi.com/api/character/avatar/84.jpeg"
}

final class NetworkManager {
    
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
    
    func fetchCharacter(from url: String, completion: @escaping(MyСharacter) -> Void) {
        
        guard let url = URL(string: url ) else { return }
        
        let session = URLSession(configuration:  .default)
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let  jsonDecoder  = JSONDecoder()
            do {
                let character = try jsonDecoder.decode(MyСharacter.self , from: data)
                DispatchQueue.main.async {
                    completion(character)
                }
            } catch {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
}
