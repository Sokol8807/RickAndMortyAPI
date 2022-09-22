//
//  ViewController.swift
//  networkingTestProject
//
//  Created by Ilya Sokolov on 18.09.2022.
//

import UIKit

final class MainViewController: UIViewController {

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
        avatarActivityIndicator.startAnimating()
    }
    
    
}
// MARK: - Networking
extension MainViewController {
    private func fetchСharacter() {
        NetworkManager.shared.fetchCharacter(from: Link.charecterURL.rawValue) { [weak self] character in
            self?.nameLable.text = character.name
            self?.descriptionLable.text = character.gender
        }
    }
    
    private func fetchImage () {
        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue) { [weak self] imageData in
            self?.avatarUIImageView.image = UIImage(data: imageData)
            self?.avatarActivityIndicator.hidesWhenStopped = true
            self?.avatarActivityIndicator.stopAnimating()
        }
    }
}

