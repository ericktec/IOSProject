//
//  RadioButtons.swift
//  IOSProject
//
//  Created by Erick Mendoza on 16/05/22.
//

import SwiftUI

struct RadioButtons: View {
    @Binding var value: String
    let id:String
    let label: String
    
    var body: some View {
        Button(action: {
            value = id
        }) {
            HStack{
                Image(systemName: value == id ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Text(label)
            }
            .foregroundColor(.primary)
            
        }.foregroundColor(.primary)
        
    }
}

struct RadioButtons_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtons(value: .constant("test"), id: "Test", label: "test")
    }
}
