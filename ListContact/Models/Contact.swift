//
//  Contact.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import UIKit

struct Contact: Codable, Identifiable {
    var id = UUID()
    var name: String
    var location: String
    
    var image: UIImage {
        do {
            return try FileManager().readImage(with: id)
        } catch {
            return UIImage(systemName: "photo.fill")!
        }
    }
    
    static var example: [Contact] {
        [
        Contact(name: "Eric Dubourbon", location: "Lyon"),
        Contact(name: "Stefan Alifax", location: "New-York"),
        Contact(name: "Krissie Descounter", location: "London")
        ]
    }
}
