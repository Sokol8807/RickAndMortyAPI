//
//  ViewController.swift
//  networkingTestProject
//
//  Created by Ilya Sokolov on 18.09.2022.
//

import UIKit

final class MainViewController: UIViewController {
    private let userURL = "https://rickandmortyapi.com/api/character/84"

    @IBOutlet var nameLable: UILabel!
    
    @IBOutlet var avatarActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var avatarUIImageView: UIImageView!
    @IBOutlet var descriptionLable: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchСharacter()
        fetchImage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatarActivityIndicator.stopAnimating()
        self.avatarActivityIndicator.hidesWhenStopped = true
        avatarActivityIndicator.startAnimating()
    }
    
    
}

extension MainViewController {
    private func fetchСharacter() {
        guard let url = URL(string: userURL) else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let  jsonDecoder  = JSONDecoder()
            do {
                let character = try jsonDecoder.decode(MyСharacter.self , from: data)
                DispatchQueue.main.async {
                    self.nameLable.text = character.name
                    self.descriptionLable.text = character.gender ?? ""
                }
            } catch {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    private func fetchImage () {
        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue) { [weak self] imageData in
            self?.avatarUIImageView.image = UIImage(data: imageData)
            self?.avatarActivityIndicator.stopAnimating()
        }
    }
}

