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
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let genre: String
    var workout: DocumentReference?
    var currentDay: Int
    
    init(id: String, email: String, firstName: String, lastName: String, genre: String, workout: DocumentReference? = nil, currentDay: Int = 0) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.genre = genre
        self.workout = workout
        self.currentDay = currentDay
    }
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
            let uid = authDataResult!.user.uid
            self.db.collection("users").document(uid).setData([
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
            completionBlock(.success(.init(id: uid,email: email, firstName: firstName, lastName: lastName, genre: genre)))
        }
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
                    return completionBlock(.failure("User dont have an id" as! Error))
                }
                
                let docRef = self.db.collection("users").document(userUID)

                docRef.addSnapshotListener { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        let data = document.data()
                        print("Document data: \(dataDescription)")
                        let firstName = data?["firstName"] as? String ?? ""
                        let lastName = data?["lastName"] as? String ?? ""
                        let genre = data?["genre"] as? String ?? ""
                        let documentReference = data?["workout"] as? DocumentReference ?? nil
                        let currentDay = data?["currentDay"] as? Int ?? 0
                        
                        completionBlock(.success(.init(id: userUID,email: email, firstName: firstName, lastName: lastName, genre: genre, workout: documentReference, currentDay: currentDay)))
                    } else {
                        completionBlock(.failure("Document not exists" as! Error))
                    }
                }
            }
        }
    
    
}
