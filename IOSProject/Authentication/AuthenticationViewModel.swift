//
//  AuthenticationViewModel.swift
//  FirebaseExample
//
//  Created by César on 26/04/22.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    @Published var user: User?
    @Published var messageError: String?
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
    }
    
    func createNewUser(email: String, password: String, firstName: String, lastName: String, genre: String) {
        authenticationRepository.createNewUser(email: email, password: password, firstName: firstName, lastName: lastName, genre: genre) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newUser):
                self.user = newUser
            case .failure(let error):
                self.messageError = error.localizedDescription
            }
        }
    }
    
    
    func logout() {
            do {
                try authenticationRepository.logout()
                self.user = nil
            } catch {
                print("Error logout")
            }
        }
    
    func login(email: String, password: String) {
            authenticationRepository.login(email: email, password: password) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let newUser):
                    self.user = newUser
                case .failure(let error):
                    self.messageError = error.localizedDescription
                }
            }
        }
}
