//
//  ContactListView.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import SwiftUI

struct ContactListView: View {
    @EnvironmentObject var listContactVM: ListContactViewModel
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(listContactVM.contacts) { contact in
                    HStack {
                        Image(uiImage: contact.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.6), radius: 2, x: 2, y: 2)
                        VStack(alignment: .leading) {
                            Text(contact.name)
                                .font(.system(size: 21, weight: .medium, design: .default))
                            Text(contact.location)
                        }
                    }
                }
            }
            .task {
                if FileManager().docExist(named: fileName) {
                    listContactVM.loadContacts()
                }
            }
            .listStyle(.plain)
            .navigationTitle("Contacts")
            
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
            .environmentObject(ListContactViewModel())
    }
}
