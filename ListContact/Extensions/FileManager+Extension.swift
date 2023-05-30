//
//  FileManager+Extension.swift
//  ListContact
//
//  Created by Eric on 30/05/2023.
//

import UIKit

let fileName = "ContactList.json"

extension FileManager {
    static var docDirURL: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func docExist(named docName: String) -> Bool {
        fileExists(atPath: Self.docDirURL.appendingPathComponent(docName).path)
    }
    
    func saveDocument(contents: String) throws {
        let url = Self.docDirURL.appendingPathComponent(fileName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            fatalError("Oups")
        }
    }
    
    func readDocuments() throws -> Data {
        let url = Self.docDirURL.appendingPathComponent(fileName)
        do {
            return try Data(contentsOf: url)
        } catch {
            fatalError("Oups")
        }
    }
    
    
    func saveImage(_ id: String, image: UIImage) throws {
        if let data = image.jpegData(compressionQuality: 0.6) {
            let imageURL = FileManager.docDirURL.appendingPathComponent("\(id).jpg")
            do {
                try data.write(to: imageURL)
            } catch {
                fatalError("Oups")
            }
        } else {
            fatalError("Oups")
        }
    }
    
    func readImage(with id: UUID) throws -> UIImage {
        let imageURL = FileManager.docDirURL.appendingPathComponent("\(id).jpg")
        do {
            let imageData = try Data(contentsOf: imageURL)
            if let image = UIImage(data: imageData) {
                return image
            } else {
                fatalError("Oups")
            }
        } catch {
            fatalError("Oups")
        }
    }
}

