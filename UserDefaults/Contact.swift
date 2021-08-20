//
//  Contact.swift
//  UserDefaults
//
//  Created by Sergey on 20.08.2021.
//

// делаем рефактаринг вьюконтроллеров в соотведствии нашей моделью
struct Contact: Codable {
    let firstName: String
    let lastName: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    
}











