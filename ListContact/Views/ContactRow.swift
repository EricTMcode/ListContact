//
//  ContactRow.swift
//  ListContact
//
//  Created by Eric on 01/06/2023.
//

import SwiftUI

struct ContactRow: View {
    let contact: Contact
    var body: some View {
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

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(contact: Contact.example[0])
    }
}
