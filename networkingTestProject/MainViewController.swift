//
//  ViewController.swift
//  networkingTestProject
//
//  Created by Ilya Sokolov on 18.09.2022.
//

import UIKit
import Alamofire

final class MainViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet var nameLable: UILabel!
    
    @IBOutlet var avatarActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var avatarUIImageView: UIImageView!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarActivityIndicator.startAnimating()
        fethcCharacterManual()
        //        fetchImage()
    }
    
    
}
// MARK: - Networking
extension MainViewController {
    
    //    ОСТАВЛЯЮ КАК ПРИМЕР на будущие!
    //    private func fetchСharacter() {
    //        NetworkManager.shared.fetchCharacter(from: Link.charecterURL.rawValue) { [weak self] character in
    //            self?.nameLable.text = character.name
    //            self?.descriptionLable.text = character.gender
    //        }
    //    }
    
    //    private func fetchImage () {
    //        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue) { [weak self] imageData in
    //            self?.avatarUIImageView.image = UIImage(data: imageData)
    //            self?.avatarActivityIndicator.hidesWhenStopped = true
    //            self?.avatarActivityIndicator.stopAnimating()
    //        }
    //    }
    
    private func fethcCharacterManual() {
        AF.request(Link.charecterURL.rawValue, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let characters = value as? [String: Any] else { return }
                    
                    for _ in characters {
                        let character = MyСharacter(charecther: characters)
                        self.nameLable.text = character.name
                        self.genderLabel.text = character.gender
                        self.speciesLabel.text = character.species
                        self.statusLabel.text = character.status
                        
                        guard let url = URL(string: character.image ?? "") else { return }
                        
                        DispatchQueue.global().async {
                            guard let imageData = try? Data(contentsOf: url) else { return }
                            DispatchQueue.main.async {
                                self.avatarUIImageView.image = UIImage(data: imageData)
                                self.avatarActivityIndicator.hidesWhenStopped = true
                                self.avatarActivityIndicator.stopAnimating()
                            }
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        
    }
}

