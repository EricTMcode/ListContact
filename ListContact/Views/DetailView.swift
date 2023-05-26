//
//  DetailView.swift
//  ListContact
//
//  Created by Eric on 24/05/2023.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var listContactVM: ListContactVieModel
    @Environment(\.dismiss) private var dismiss
    let person: Contact
    @State private var name = ""
    @State private var location = ""
    
    var body: some View {
        VStack {
            if person.image != nil {
                person.image!
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipped()
                    .clipShape(Circle())
                    .shadow(radius: 3)
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
            }
            Text(person.name)
                .font(.title)
                .fontWeight(.medium)
            
            Form {
                Section {
                    HStack {
                        Text("Phone")
                        Spacer()
                        Text("+1(268)-8110134")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Email")
                        Spacer()
                        Text("blaw@yeilmail.com")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Address")
                        Spacer()
                        Text("242 Wildrose River 16040 Wisconsin")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                }
                Section {
                    Button("Send a message") {
                        print("Send a message")
                    }
                    
                    Button("Call") {
                        print("Call")
                    }
                }
                .multilineTextAlignment(.trailing)
            }
            .onAppear {
                name = person.name
                location = person.location
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        listContactVM.updateContact(contact: person, name: name, location: location)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(person: Contact.example[0])
                .environmentObject(ListContactVieModel())
        }
    }
}
