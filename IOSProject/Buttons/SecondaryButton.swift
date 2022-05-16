//
//  SecondaryButton.swift
//  IOSProject
//
//  Created by Erick Mendoza on 15/05/22.
//

import SwiftUI

struct SecondaryButton: View {
    var label: String
    var onClick: (()->Void)
    var body: some View {
        Button(label) {
            onClick()
        }
        .padding()
        .border(Color("PrimaryOrange"))
        .foregroundColor(.primary)
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(label: "test", onClick: {})
    }
}
