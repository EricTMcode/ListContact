//
//  ContactListView.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import SwiftUI

struct ContactListView: View {
    @EnvironmentObject var listContactVM: ListContactViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(listContactVM.contacts) { contact in
                    NavigationLink(value: contact) {
                        ContactRow(contact: contact)
                    }
                }
                .onDelete(perform: listContactVM.delete)
            }
            .task {
                if FileManager().docExist(named: fileName) {
                    listContactVM.loadContacts()
                }
            }
            .listStyle(.plain)
            .navigationTitle("Contacts")
            .navigationDestination(for: Contact.self) { contact in
                DetailView(person: contact)
            }
            .alert("Error", isPresented: $listContactVM.showFileAlert, presenting: listContactVM.appError) { contactError in
                contactError.button
            } message: { contactError in
                Text(contactError.message)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        listContactVM.showPicker.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $listContactVM.showPicker) {
                NavigationStack {
                    AddContactView()
                }
            }
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
            .environmentObject(ListContactViewModel())
    }
}


