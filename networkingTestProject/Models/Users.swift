//
//  Users.swift
//  networkingTestProject
//
//  Created by Ilya Sokolov on 18.09.2022.
//

struct MyСharacter: Decodable {
    let name: String?
    let status: String?
    let species: String?
    let gender: String?
    let image: String?
    
    init(name: String, status: String, species: String, gender: String, image: String) {
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
    }
    
    init(charecther: [String: Any]) {
        
        name = charecther["name"] as? String
        status = charecther["status"] as? String
        species = charecther["species"] as? String
        gender = charecther["gender"] as? String
        image = charecther["image"] as? String
        
    }
}
