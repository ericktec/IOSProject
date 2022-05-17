//
//  AuthenticationFirebaseDatasource.swift
//  FirebaseExample
//
//  Created by César on 26/04/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct User {
    let email: String
    let firstName: String
    let lastName: String
    let genre: String
}

final class AuthenticationFirebaseDatasource {
    private var db = Firestore.firestore()
    
    func createNewUser(email: String, password: String, firstName: String, lastName: String, genre: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Error creating a new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No email"
            print("New user created with info \(email)")
            if((authDataResult?.user.uid) == nil) {
                completionBlock(.failure("User id is not available" as! Error))
                return
            }
            self.db.collection("users").document().setData([
                "firstName": firstName,
                "lastName":lastName,
                "genre": genre
            ]) { err in
                if let err = err {
                    print("Something went wrong while saving the users data")
                    completionBlock(.failure(err))
                    return
                }
                else {
                    print("Document created successfully")
                }
            }
            completionBlock(.success(.init(email: email, firstName: firstName, lastName: lastName, genre: genre)))
        }
    }
    
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        guard let userUID = Auth.auth().currentUser?.uid else {
            return nil
        }
        var firstName: String = ""
        var lastName: String = ""
        var genre: String = ""
        db.collection("users").document(userUID).getDocument {(document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                firstName =  dataDescription?["firstName"] as? String ?? ""
                lastName = dataDescription?["lastName"] as? String ?? ""
                genre = dataDescription?["genre"] as? String ?? ""
                
            }
            return
        }
        return .init(email: email, firstName: firstName, lastName: lastName, genre: genre)
    }
    
    func logout() throws {
            try Auth.auth().signOut()
        }
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
                if let error = error {
                    print("Error creating a new user \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                let email = authDataResult?.user.email ?? "No email"
                print("New user created with info \(email)")
                guard let userUID = authDataResult?.user.uid else {
                    return
                }
                var firstName: String = ""
                var lastName: String = ""
                var genre: String = ""
                self.db.collection("users").document(userUID).getDocument {(document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data()
                        firstName =  dataDescription?["firstName"] as? String ?? ""
                        lastName = dataDescription?["lastName"] as? String ?? ""
                        genre = dataDescription?["genre"] as? String ?? ""
                        
                    }
                }
                completionBlock(.success(.init(email: email, firstName: firstName, lastName: lastName, genre: genre)))
            }
        }
    
    
}
