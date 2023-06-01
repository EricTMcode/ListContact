//
//  DetailView.swift
//  ListContact
//
//  Created by Eric on 24/05/2023.
//

import SwiftUI

struct DetailView: View {
    let person: Contact
    
    var body: some View {
        VStack {
            pageTitle
            pageForm
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                }
            }
        }
    }
}

extension DetailView {
    var pageTitle: some View {
        Group {
            Image(uiImage: person.image)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipped()
                .clipShape(Circle())
                .shadow(radius: 3)
            
            Text(person.name)
                .font(.title)
                .fontWeight(.medium)
            Text(person.location)
        }
    }
    var pageForm: some View {
        Form {
            Section {
                SectionView(title: "Phone", info: "+1(268)-81101134")
                SectionView(title: "Email", info: "blaw@yeilmail.com")
                SectionView(title: "Address", info: "242 Wildrose River 16040 Wisconsin")
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
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(person: Contact.example[0])
        }
    }
}


