//
//  ContentView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 01/05/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authenticationViewModel: AuthenticationViewModel())
    }
}
