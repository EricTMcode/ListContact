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
    @Published var showPicker = false
    @Published var name = ""
    @Published var location = ""
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var image: Image?
    @Published var inputImage: UIImage?
    @Published var showFileAlert = false
    @Published var appError: ContactError.ErrorType?
    @Published var selectedContact: Contact?
    
    var buttonDisabled: Bool {
        name.count < 3
    }

    
    func addContact(name: String, location: String, image: UIImage) {
        let newContact = Contact(name: name, location: location)
        do {
            try FileManager().saveImage("\(newContact.id)", image: image)
            contacts.append(newContact)
            saveContacts()
        } catch {
            showFileAlert = true
            appError = ContactError.ErrorType(error: error as! ContactError)
        }
    }
    
    func updateSelected() {
        if let index = contacts.firstIndex(where: {$0.id == selectedContact?.id}) {
            contacts[index].name = name
            contacts[index].location = location
            saveContacts()
            reset()
        }
    }
    
    func reset() {
        image = nil
        name = ""
        location = ""
    }
    
    func delete(indexSet: IndexSet) {
        contacts.remove(atOffsets: indexSet)
        saveContacts()
    }
    
    //MARK: - DOCUMENTS DIRECTORY
    
    func saveContacts() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(contacts)
            let jsonString = String(decoding: data, as: UTF8.self)
            reset()
            do {
                try FileManager().saveDocument(contents: jsonString)
            } catch {
                showFileAlert = true
                appError = ContactError.ErrorType(error: error as! ContactError)
            }
        } catch {
            showFileAlert = true
            appError = ContactError.ErrorType(error: .encodingError)
        }
    }
    
    func loadContacts() {
        do {
            let data = try FileManager().readDocuments()
            let decoder = JSONDecoder()
            do {
                contacts = try decoder.decode([Contact].self, from: data)
            } catch {
                showFileAlert = true
                appError = ContactError.ErrorType(error: .decodingError)
            }
        } catch {
            showFileAlert = true
            appError = ContactError.ErrorType(error: error as! ContactError)
        }
    }
}

