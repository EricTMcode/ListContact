//
//  Contact.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import Foundation

struct Contact: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var location: String
    let jpedData: Data?
    
    static var example: [Contact] {
        [
            Contact(name: "Eric Dubourbon", location: "France", jpedData: nil),
            Contact(name: "Stefan Alifax", location: "New-York", jpedData: nil),
            Contact(name: "Krissie Descounter", location: "London", jpedData: nil)
        ]
    }
}
