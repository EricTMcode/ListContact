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
    
    func saveContact(name: String, location: String) {
        let newContact = Contact(name: name, location: location)
        contacts.append(newContact)
    }
    
    func updateContact(contact: Contact, name: String, location: String) {
        if let index = contacts.firstIndex(where: {$0.id == contact.id}) {
            contacts[index].name = name
            contacts[index].location = location
        }
            
    }
    
    func removeContact(indexSet: IndexSet) {
        contacts.remove(atOffsets: indexSet)
    }
}
