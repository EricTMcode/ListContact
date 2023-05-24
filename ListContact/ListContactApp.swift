//
//  ListContactApp.swift
//  ListContact
//
//  Created by Eric on 23/05/2023.
//

import SwiftUI

@main
struct ListContactApp: App {
    @StateObject var listContactVM = ListContactVieModel()
    var body: some Scene {
        WindowGroup {
            ContactListView()
                .environmentObject(listContactVM)
                .onAppear {
                    print(URL.documentsDirectory.path)
                }
        }
    }
}
