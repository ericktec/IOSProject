//
//  SignUpView.swift
//  IOSProject
//
//  Created by Erick Mendoza on 15/05/22.
//

import SwiftUI

enum Genre: String {
case Male = "Male"
case Female = "Female"
}

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var comfirmPassword = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var genre: String = Genre.Male.rawValue
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        ScrollView {
            VStack {
                Image("SignUpImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading) {
                    Group {
                        Text("Email")
                        TextField("", text: $email)
                        Divider()
                        
                        Text("Password")
                        SecureField("", text: $password)
                        Divider()
                        
                        Text("Repeat Password")
                        SecureField("", text: $comfirmPassword)
                        Divider()
                            .background(password != "" && (password != comfirmPassword) ? Color.red : .primary)
                    }

                    Group {
                        
                        Text("First name")
                        TextField("", text: $firstName)
                        Divider()
                        
                        Text("Last Name")
                        TextField("", text: $lastName)
                        Divider()
                    }
                    
                    Group {
                        //Radio buttons Genre
                        HStack(spacing: 10) {
                            RadioButtons(value: $genre, id: Genre.Male.rawValue, label: "Male")
                            
                            RadioButtons(value: $genre, id: Genre.Female.rawValue, label: "Female")
                        }
                    }
                    
                    Group {
                        PrimaryButton(label: "Sign up", fullWidth: true) {
                            guard email != "" && password == password && password != "" else {
                                return
                            }
                            authenticationViewModel.createNewUser(email: email, password: password, firstName: firstName, lastName: lastName, genre: genre)
                        }
                        HStack {
                            Text("I already have an account.")
                            NavigationLink(destination: LogInView(authenticationViewModel:authenticationViewModel)){
                                Text("Log in")
                                    .foregroundColor(Color("PrimaryOrange"))
                                    .underline()
                            }
                            
                        }
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 10)
        .background(Color("PrimaryColorBackground"))
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView(authenticationViewModel: AuthenticationViewModel())
                .preferredColorScheme(.dark)
            
            SignUpView(authenticationViewModel: AuthenticationViewModel())
                .preferredColorScheme(.light)
        }
        
    }
}
