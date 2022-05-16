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
                        TextField("", text: $password)
                        Divider()
                        
                        Text("Repeat Password")
                        TextField("", text: $comfirmPassword)
                        Divider()
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
                }
                .padding()
                
                PrimaryButton(label: "Sign up", onClick: {})
                HStack {
                    Text("I already have an account.")
                    NavigationLink(destination: SignUpView()){
                        Text("Sign up")
                            .foregroundColor(Color("PrimaryOrange"))
                            .underline()
                    }
                    
                }
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
            SignUpView()
                .preferredColorScheme(.dark)
            
            SignUpView()
                .preferredColorScheme(.light)
        }
        
    }
}
