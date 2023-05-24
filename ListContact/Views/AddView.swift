//
//  AddView.swift
//  ListContact
//
//  Created by Eric on 24/05/2023.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var listContactVM: ListContactVieModel
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var location = ""
    
    var body: some View {
        Form {
            Section("Add contact") {
                TextField("Name*", text: $name)
                TextField("Location", text: $location)
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
                    listContactVM.saveContact(name: name, location: location)
                    dismiss()
                }
                .disabled(!(name.count >= 3) || location.isEmpty)
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddView()
                .environmentObject(ListContactVieModel())
        }
    }
}
