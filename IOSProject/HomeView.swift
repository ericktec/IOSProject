//
//  LogInView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 15/05/22.
//

import SwiftUI

struct Home: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcomel to")
                    .foregroundColor(.primary)
                    .font(.body)
                Text("SabrosApp")
                    .foregroundColor(.primary)
                    .font(.title)
                    .bold()
                ZStack {
                    Rectangle()
                        .fill(Color("SecondaryBlue"))
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 170, height: 170)
                        .rotationEffect(Angle(degrees: 35))
                    Rectangle()
                        .fill(Color(red: 52/255, green: 49/255, blue: 69/255))
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 170, height: 170)
                        .rotationEffect(Angle(degrees: 25))
                    Image("LogInImage")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 200, height: 200)
                }.padding(.top, 30)
                Spacer()
                VStack(spacing: 40) {
                   PrimaryNavigationLink(destination: LogInView(), label: "Log in")
                    SecondaryNavigationLink(destination: SignUpView(), label: "Sign up")
                    
                }.padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("PrimaryColorBackground"))
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
                .preferredColorScheme(.dark)
            
            Home()
                .preferredColorScheme(.light)
        }
        
    }
}
