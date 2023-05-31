//
//  AddContactView.swift
//  ListContact
//
//  Created by Eric on 24/05/2023.
//

import SwiftUI
import PhotosUI

struct AddContactView: View {
    @EnvironmentObject var ContactListVM: ListContactViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                VStack {
                    if ContactListVM.image == nil {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 120))
                            .foregroundColor(.blue)
                    } else {
                        ContactListVM.image!
                            .resizable()
                            .scaledToFill()
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())
                            .clipped()
                    }
                    PhotosPicker((ContactListVM.image != nil) ? "Change Picture" : "Add Picture", selection: $ContactListVM.selectedPhoto, matching: .images, preferredItemEncoding: .automatic)
                }
                .onChange(of: ContactListVM.selectedPhoto) { newValue in
                    Task {
                        do {
                            if let data = try await newValue?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    ContactListVM.inputImage = uiImage
                                    ContactListVM.image = Image(uiImage: uiImage)
                                }
                            }
                        } catch {
                            print("😡 ERROR: loading failed \(error.localizedDescription)")
                        }
                    }
                }
                Spacer()
            }
            Section("Add contact") {
                TextField("Name*", text: $ContactListVM.name)
                TextField("Location", text: $ContactListVM.location)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    ContactListVM.addContact(name: ContactListVM.name, location: ContactListVM.location, image: ContactListVM.inputImage ?? UIImage(systemName: "person.fill")!)
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddContactView()
                .environmentObject(ListContactViewModel())
        }
    }
}
