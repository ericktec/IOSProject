//
//  SecondaryNavigationLink.swift
//  IOSProject
//
//  Created by Erick Mendoza on 15/05/22.
//

import SwiftUI

struct SecondaryNavigationLink<Content:View>: View {
    var destination: Content
    var label: String
    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
        }
        .padding()
        .border(Color("PrimaryOrange"))
        .foregroundColor(.primary)
    }
}

struct SecondaryNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryNavigationLink(destination: EmptyView(), label: "Test")
    }
}
