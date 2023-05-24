//
//  DetailView.swift
//  ListContact
//
//  Created by Eric on 24/05/2023.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    let person: Contact
    @State private var name = ""
    @State private var location = ""
    
    var body: some View {
        Form {
            TextField("Enter a name", text: $name)
            TextField("Enter a location", text: $location)
        }
        .onAppear {
            name = person.name
            location = person.location
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(person: Contact.example[0])
        }
    }
}
