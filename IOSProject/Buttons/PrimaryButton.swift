//
//  PrimaryButton.swift
//  IOSProject
//
//  Created by Erick Mendoza on 15/05/22.
//

import SwiftUI

struct PrimaryButton: View {
    var label: String
    var onClick: (()->Void)
    var body: some View {
        Button(label) {
            onClick()
        }
        .padding()
        .background(Color("PrimaryOrange"))
        .foregroundColor(.primary)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(label: "Test", onClick: {})
    }
}
