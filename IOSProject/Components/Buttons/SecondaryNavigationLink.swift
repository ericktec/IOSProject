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
    var fullWidth: Bool = false
    var body: some View {
        if(fullWidth) {
            NavigationLink(destination: destination) {
                Text(label).bold()
            }
            .padding()
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .border(Color("PrimaryOrange"))
                    
        }
        else {
            NavigationLink(destination: destination) {
                Text(label).bold()
            }
            .padding()
            .border(Color("PrimaryOrange"))
            .foregroundColor(.primary)
        }
    }
}

struct SecondaryNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryNavigationLink(destination: EmptyView(), label: "Test", fullWidth: true)
    }
}
