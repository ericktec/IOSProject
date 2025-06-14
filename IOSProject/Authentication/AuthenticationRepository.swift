//
//  AuthenticationRepository.swift
//  FirebaseExample
//
//  Created by César on 26/04/22.
//

import Foundation

final class AuthenticationRepository {
    private let authenticationFirebaseDatasource: AuthenticationFirebaseDatasource
    
    init(authenticationFirebaseDatasource: AuthenticationFirebaseDatasource = AuthenticationFirebaseDatasource()) {
        self.authenticationFirebaseDatasource = authenticationFirebaseDatasource
    }
    
    func createNewUser(email: String, password: String, firstName: String, lastName: String, genre: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        authenticationFirebaseDatasource.createNewUser(email: email,
                                                       password: password,
                                                       firstName: firstName,
                                                       lastName: lastName,
                                                       genre: genre,
                                                       completionBlock: completionBlock)
    }
    
    
    func logout() throws {
            try authenticationFirebaseDatasource.logout()
        }
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
            authenticationFirebaseDatasource.login(email: email,
                                                   password: password,
                                                   completionBlock: completionBlock)
        }
    
}
