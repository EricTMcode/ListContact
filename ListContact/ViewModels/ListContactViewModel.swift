//
//  ListContactViewModel.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import SwiftUI
import PhotosUI

class ListContactViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var name = ""
    @Published var location = ""
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var image: Image?
    @Published var inputImage: UIImage?
    
    init() {
//        contacts = Contact.example
//        loadContacts()
    }
    
    func addContact(name: String, location: String, image: UIImage) {
        let newContact = Contact(name: name, location: location)
        do {
            try FileManager().saveImage("\(newContact.id)", image: image)
            contacts.append(newContact)
            saveContacts()
        } catch {
            fatalError("Oups")
        }
    }
    
    //MARK: - DOCUMENTS DIRECTORY
    
    func saveContacts() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(contacts)
            let jsonString = String(decoding: data, as: UTF8.self)
            do {
                try FileManager().saveDocument(contents: jsonString)
            } catch {
                fatalError("Oups")
            }
        } catch {
            fatalError("Oups")
        }
    }
    
    func loadContacts() {
        do {
            let data = try FileManager().readDocuments()
            let decoder = JSONDecoder()
            do {
                contacts = try decoder.decode([Contact].self, from: data)
            } catch {
                fatalError("Oups")
            }
        } catch {
            fatalError("Oups")
        }
    }
}

