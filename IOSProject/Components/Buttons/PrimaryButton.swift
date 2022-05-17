//
//  PrimaryButton.swift
//  IOSProject
//
//  Created by Erick Mendoza on 15/05/22.
//

import SwiftUI

struct PrimaryButton: View {
    var label: String
    var fullWidth: Bool = false
    var onClick: (()->Void)
    var body: some View {
        if(fullWidth) {
            Button(label) {
                onClick()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("PrimaryOrange"))
            .foregroundColor(.primary)
            
        } else {
            Button(label) {
                onClick()
            }
            .padding()
            .background(Color("PrimaryOrange"))
            .foregroundColor(.primary)
            
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(label: "Test", fullWidth: true, onClick: {})
    }
}
