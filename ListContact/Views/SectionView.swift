//
//  SectionView.swift
//  ListContact
//
//  Created by Eric on 01/06/2023.
//

import SwiftUI

struct SectionView: View {
    let title: String
    let info: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(info)
                .foregroundColor(.gray)
                .font(.callout)
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(title: "Phone", info: "Location")
            .padding()
    }
}
