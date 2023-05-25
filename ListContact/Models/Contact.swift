//
//  Contact.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import SwiftUI

struct Contact: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var location: String
    let jpegData: Data?
    
    var image: Image? {
        let uiImage = UIImage(data: jpegData ?? Data())
        guard let uiImage = uiImage else { return nil }
        return Image(uiImage: uiImage)
    }
    
    static var example: [Contact] {
        [
            Contact(name: "Eric Dubourbon", location: "France", jpegData: nil),
            Contact(name: "Stefan Alifax", location: "New-York", jpegData: nil),
            Contact(name: "Krissie Descounter", location: "London", jpegData: nil)
        ]
    }
}
