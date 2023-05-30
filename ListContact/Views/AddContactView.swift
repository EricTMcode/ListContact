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
    @State private var name = ""
    @State private var location = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                VStack {
                    if image == nil {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 120))
                            .foregroundColor(.blue)
                    } else {
                        image!
                            .resizable()
                            .scaledToFill()
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())
                            .clipped()
                    }
                    PhotosPicker((image != nil) ? "Change Picture" : "Add Picture", selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic)
                }
                .onChange(of: selectedPhoto) { newValue in
                    Task {
                        do {
                            if let data = try await newValue?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    inputImage = uiImage
                                    image = Image(uiImage: uiImage)
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
                Button {
                    ContactListVM.addContact(name, location: location, image: inputImage ?? UIImage(systemName: "person.fill")!)
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
