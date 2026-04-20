//
//  AuthViewModel.swift
//  FirebaseAuthWithAsyncSteam
//
//  Created by YEN-JU HUANG on 2026/4/14.
//

import SwiftUI
import FirebaseAuth
import Observation

@Observable
class AuthViewModel {
    
    private let authService: FirebaseAuthService
    private(set) var state: AuthState = .unknown
    private var authTask: Task<Void, Never>?
    
    init(service: FirebaseAuthService? = nil) {
        self.authService = service ?? FirebaseAuthService()
    }
    
    deinit {
        authTask?.cancel()
    }
    
    func addAuthListener() {
        authTask?.cancel()
        
        // receive AsyncStream values one by one through for await
        authTask = Task {
            for await newState in authService.addAuthUserListener() {
                self.state = newState
            }
        }
    }
    
    // MARK: - Public APIs
    func signInAnonymously() {
        Task {
            do {
                try await authService.signInAnonymously()
            } catch {
                print("Fail to login anonymously: \(error)")
            }
        }
    }
    
    func signOut() {
        do {
            try authService.signOut()
        } catch {
            print("Fail to logout: \(error)")
        }
    }
}
