//
//  ContactListView.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import SwiftUI

struct ContactListView: View {
    @EnvironmentObject var listContactVM: ListContactVieModel
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(listContactVM.contacts) { contact in
                    NavigationLink(value: contact) {
                        HStack {
                            Image(systemName: "person.circle")
                                .font(.system(size: 40))
                                .foregroundColor(.pink)
                            VStack(alignment: .leading) {
                                Text(contact.name)
                                    .font(.title2)
                                    .bold()
                                Text(contact.location)
                            }
                        }
                    }
                }
                .onDelete(perform: listContactVM.removeContact)
            }
            .listStyle(.plain)
            .navigationTitle("Contacts")
            .navigationDestination(for: Contact.self) { contact in
                DetailView(person: contact)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isSheetPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
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
            .environmentObject(ListContactVieModel())
    }
}
