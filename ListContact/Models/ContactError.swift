//
//  ContactError.swift
//  ListContact
//
//  Created by Eric on 31/05/2023.
//

import SwiftUI

enum ContactError: Error, LocalizedError {
    case readError, decodingError, encodingError, saveError, saveImageError, readImageError
    
    var errorDescription: String? {
        switch self {
        case .readError:
            return NSLocalizedString("Could not load Contact.json, please reinstall the app", comment: "")
        case .decodingError:
            return NSLocalizedString("There was a problem loading your list of contactm please create a new contact to start over", comment: "")
        case .encodingError:
            return NSLocalizedString("Could not save your contact data, please reinstall the app", comment: "")
        case .saveError:
            return NSLocalizedString("Could not save Contact.json file, please reinstall the app", comment: "")
        case .saveImageError:
            return NSLocalizedString("Could not save image, please reinstall the app", comment: "")
        case .readImageError:
            return NSLocalizedString("Could not load image, please reinstall the app", comment: "")
        }
    }
    
    struct ErrorType: Identifiable {
        let id = UUID()
        let error: ContactError
        var message: String {
            error.localizedDescription
        }
        let button = Button("OK", role: .cancel) {}
    }
}
