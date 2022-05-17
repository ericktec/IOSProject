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
    var fullWidth: Bool = false
    var body: some View {
        if(fullWidth) {
            NavigationLink(destination: destination) {
                Text(label).bold()
            }
            .padding()
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .background(Color("PrimaryOrange"))
        } else {
            NavigationLink(destination: destination) {
                Text(label).bold()
            }
            .padding()
            .foregroundColor(.primary)
            .background(Color("PrimaryOrange"))
        }
        
    }
}

struct PrimaryNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryNavigationLink(destination: EmptyView(), label: "Test", fullWidth: true)
    }
}
