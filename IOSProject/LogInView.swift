//
//  LogInView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 15/05/22.
//

import SwiftUI

struct LogInView: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Image("SignUpImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text("Email")
                TextField("", text: $email)
                    Divider()
                Text("Password")
                TextField("", text: $password)
                Divider()
            }
            .padding()
            
            PrimaryButton(label: "Log in", onClick: {})
            HStack {
                Text("Don't have an account?")
                NavigationLink(destination: SignUpView()){
                    Text("Sign up")
                        .foregroundColor(Color("PrimaryOrange"))
                        .underline()
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 10)
        .background(Color("PrimaryColorBackground"))
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LogInView().preferredColorScheme(.dark)
            LogInView().preferredColorScheme(.light)
        }
        
    }
}
