//
//  EditView.swift
//  ListContact
//
//  Created by Eric on 01/06/2023.
//

import SwiftUI
import PhotosUI

struct EditView: View {
    @EnvironmentObject var contactListVM: ListContactViewModel
    @State var contact: Contact
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {

            Section("Contact informations") {
                TextField("Name*", text: $contact.name)
                TextField("Location", text: $contact.location)
                Text(contact.id.uuidString)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    contactListVM.updateSelected()
                    dismiss()
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(contact: Contact.example[0])
            .environmentObject(ListContactViewModel())
    }
}
