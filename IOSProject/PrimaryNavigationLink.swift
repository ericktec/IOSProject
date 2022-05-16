//
//  PrimaryNavigationLink.swift
//  IOSProject
//
//  Created by Erick Mendoza on 15/05/22.
//

import SwiftUI

struct PrimaryNavigationLink<Content:View>: View {
    var destination: Content
    var label:String
    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
        }
        .padding()
        .background(Color("PrimaryOrange"))
        .foregroundColor(.primary)
    }
}

struct PrimaryNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryNavigationLink(destination: EmptyView(), label: "Test")
    }
}
