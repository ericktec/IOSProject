//
//  LogInView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 15/05/22.
//

import SwiftUI

struct LogInView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Image("LogInImage")
                .resizable()
                .aspectRatio(1,contentMode: .fit)
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Email")
                    TextField("", text: $email)
                        Divider()
                    Text("Password")
                    SecureField("", text: $password)

                    Divider()
                }
                
                PrimaryButton(label: "Log in", fullWidth: true) {
                    guard email != "" && password != "" else {
                        return
                    }
                    authenticationViewModel.login(email: email, password: password)
                }
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: SignUpView( authenticationViewModel: authenticationViewModel)){
                        Text("Sign up")
                            .foregroundColor(Color("PrimaryOrange"))
                            .underline()
                    }
                    
                }
            }.padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("PrimaryColorBackground"))
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LogInView(authenticationViewModel: AuthenticationViewModel()).preferredColorScheme(.dark)
            
            LogInView(authenticationViewModel: AuthenticationViewModel()).preferredColorScheme(.light)
        }
        
    }
}
