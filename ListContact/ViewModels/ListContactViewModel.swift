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
        saveData()
    }
    
    func updateContact(contact: Contact, name: String, location: String) {
        if let index = contacts.firstIndex(where: {$0.id == contact.id}) {
            contacts[index].name = name
            contacts[index].location = location
            saveData()
        }
    }
    
    func removeContact(indexSet: IndexSet) {
        contacts.remove(atOffsets: indexSet)
        saveData()
    }
    
    //MARK: - DOCUMENTS DIRECTORY
    
    let path = URL.documentsDirectory.appending(component: "contacts.json")
    
    func saveData() {
        do {
            let contactsListData = try JSONEncoder().encode(contacts)
            let contactsListString = String(decoding: contactsListData, as: UTF8.self)
            try contactsListString.write(to: path, atomically: true, encoding: .utf8)
        } catch {
            fatalError("😡 ERROR: Could not save data \(error.localizedDescription)")
        }
    }
}
