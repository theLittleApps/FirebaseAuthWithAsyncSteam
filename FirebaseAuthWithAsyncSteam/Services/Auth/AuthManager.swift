//
//  AuthManager.swift
//  FirebaseAuthWithAsyncSteam
//
//  Created by YEN-JU HUANG on 2026/4/14.
//

import SwiftUI
import FirebaseAuth

@MainActor
@Observable
class AuthManager {
    
    var user: UserAuthInfo?
    var isLoading = false
    
    private let authService: FirebaseAuthService
    private var authTask: Task<Void, Never>?
    
    init(service: FirebaseAuthService? = nil) {
        self.authService = service ?? FirebaseAuthService()
        self.addAuthListener()
    }
    
    private func addAuthListener() {
        authTask?.cancel()
        
        authTask = Task {
            for await user in authService.addAuthUserListener() {
                self.user = user
            }
        }
    }
    
    // MARK: - Public APIs
    func signInAnonymously() {
        Task {
            isLoading = true
            
            defer {
                isLoading = false
            }
            
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
            user = nil
        } catch {
            print("Fail to logout: \(error)")
        }
    }
}
