//
//  ContentView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 01/05/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            TodayWorkoutView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
