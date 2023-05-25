//
//  AddContactView.swift
//  ListContact
//
//  Created by Eric on 24/05/2023.
//

import SwiftUI
import PhotosUI

struct AddContactView: View {
    @EnvironmentObject var listContactVM: ListContactVieModel
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var location = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var inputImage: Image?
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                VStack {
                    if inputImage == nil {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 120))
                            .foregroundColor(.blue)
                    } else {
                        inputImage!
                            .resizable()
                            .scaledToFill()
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())
                            .clipped()
                    }
                    
                    PhotosPicker((inputImage != nil) ? "Change Picture" : "Add Picture", selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic)
                }
                .onChange(of: selectedPhoto) { newValue in
                    Task {
                        do {
                            if let data = try await newValue?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    inputImage = Image(uiImage: uiImage)
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

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddContactView()
                .environmentObject(ListContactVieModel())
        }
    }
}
