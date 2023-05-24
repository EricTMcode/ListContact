//
//  ListContactViewModel.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import Foundation

class ListContactVieModel: ObservableObject {
    @Published var contacts: [Contact] = []
    
    init() {
        contacts = Contact.example
    }
    
    func savePerson(name: String, location: String) {
        let newContact = Contact(name: name, location: location)
        contacts.append(newContact)
    }
    
    func removeContact(indexSet: IndexSet) {
        contacts.remove(atOffsets: indexSet)
    }
}
