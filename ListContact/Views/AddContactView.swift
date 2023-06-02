//
//  AddContactView.swift
//  ListContact
//
//  Created by Eric on 24/05/2023.
//

import SwiftUI
import PhotosUI

struct AddContactView: View {
    @EnvironmentObject var vm: ContactListViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                VStack {
                    if vm.image == nil {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 120))
                            .foregroundColor(.blue)
                    } else {
                        vm.image!
                            .resizable()
                            .scaledToFill()
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())
                            .clipped()
                    }
                    PhotosPicker((vm.image != nil) ? "Change Picture" : "Add Picture", selection: $vm.selectedPhoto, matching: .images, preferredItemEncoding: .automatic)
                }
                .onChange(of: vm.selectedPhoto) { newValue in
                    Task {
                        do {
                            if let data = try await newValue?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    vm.inputImage = uiImage
                                    vm.image = Image(uiImage: uiImage)
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
                TextField("Name*", text: $vm.name)
                TextField("Location", text: $vm.location)
            }
        }
        .navigationTitle("Add Contact")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.addContact(name: vm.name, location: vm.location, image: vm.inputImage ?? UIImage(systemName: "person.fill")!)
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(vm.buttonDisabled)
            }
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddContactView()
                .environmentObject(ContactListViewModel())
        }
    }
}
