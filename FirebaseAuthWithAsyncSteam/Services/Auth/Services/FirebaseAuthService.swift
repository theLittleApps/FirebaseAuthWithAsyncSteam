//
//  FirebaseAuthService.swift
//  FirebaseAuthWithAsyncSteam
//
//  Created by YEN-JU HUANG on 2026/4/14.
//

import SwiftUI
import FirebaseAuth

struct FirebaseAuthService {
    
    func addAuthUserListener() -> AsyncStream<UserAuthInfo?> {
        AsyncStream { continuation in
            let handle = Auth.auth().addStateDidChangeListener { _, fbUser in
                if let fbUser {
                    let user = UserAuthInfo(user: fbUser)
                    continuation.yield(user)
                }
            }
            
            continuation.onTermination = { _ in
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }
    
    func signInAnonymously() async throws {
        _ = try await Auth.auth().signInAnonymously()
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
