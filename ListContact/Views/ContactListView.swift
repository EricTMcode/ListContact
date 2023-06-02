//
//  ContactListView.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import SwiftUI

struct ContactListView: View {
    @EnvironmentObject var vm: ContactListViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.contacts) { contact in
                    NavigationLink(value: contact) {
                        ContactRow(contact: contact)
                    }
                }
                .onDelete(perform: vm.delete)
            }
            .task {
                if FileManager().docExist(named: fileName) {
                    vm.loadContacts()
                }
            }
            .listStyle(.plain)
            .navigationTitle("Contacts")
            .navigationDestination(for: Contact.self) { contact in
                DetailView(person: contact)
            }
            .alert("Error", isPresented: $vm.showFileAlert, presenting: vm.appError) { contactError in
                contactError.button
            } message: { contactError in
                Text(contactError.message)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.showPicker.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $vm.showPicker) {
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
            .environmentObject(ContactListViewModel())
    }
}


