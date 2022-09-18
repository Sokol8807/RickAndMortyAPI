//
//  ViewController.swift
//  networkingTestProject
//
//  Created by Ilya Sokolov on 18.09.2022.
//

import UIKit

final class MainViewController: UIViewController {
    private let userURL = "https://rickandmortyapi.com/api/character/84"
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchСharacter()
    }
}

extension MainViewController {
    private func fetchСharacter() {
        guard let url = URL(string: userURL) else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let  jsonDecoder  = JSONDecoder()
            do {
                let character = try jsonDecoder.decode(Сharacter.self , from: data)
                DispatchQueue.main.async {
                    print(character)
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

