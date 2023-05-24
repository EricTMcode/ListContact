//
//  Contact.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import Foundation

struct Contact: Codable, Identifiable {
    var id = UUID()
    var name: String
    var location: String
    
    static var example: [Contact] {
        [
            Contact(name: "Eric Dubourbon", location: "France"),
            Contact(name: "Stefan Alifax", location: "New-York"),
            Contact(name: "Krissie Descounter", location: "London")
        ]
    }
}
