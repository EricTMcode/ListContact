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
//        contacts = Contact.example
        loadData()
    }
    
    func saveContact(name: String, location: String, jpegData: Data) {
        let newContact = Contact(name: name, location: location, jpegData: jpegData)
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
    
    let filURL = URL.documentsDirectory.appending(component: "contacts.json")
    
    func saveData() {
        do {
            let contactsListData = try JSONEncoder().encode(contacts)
            let contactsListString = String(decoding: contactsListData, as: UTF8.self)
            try contactsListString.write(to: filURL, atomically: true, encoding: .utf8)
        } catch {
            fatalError("😡 ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    
    func loadData() {
        if FileManager().fileExists(atPath: filURL.path) {
            do {
                let data = try Data(contentsOf: filURL)
                contacts = try JSONDecoder().decode([Contact].self, from: data)
            } catch {
                saveData()
            }
        }
    }
}
