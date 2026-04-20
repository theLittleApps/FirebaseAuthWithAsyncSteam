//
//  FirebaseAuthService.swift
//  FirebaseAuthWithAsyncSteam
//
//  Created by YEN-JU HUANG on 2026/4/14.
//

import SwiftUI
import FirebaseAuth

struct FirebaseAuthService {
    
    func addAuthUserListener() -> AsyncStream<AuthState> {
        AsyncStream { continuation in
            // once authentication state updates, it returns call-back values for user
            // then using AsyncStream to yield these changes
            let handle = Auth.auth().addStateDidChangeListener { _, user in
                if let user {
                    continuation.yield(.signedIn(uid: user.uid, email: user.email))
                } else {
                    continuation.yield(.signedOut)
                }
            }
            
            // when task is canceled or stream ends, removing listener
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
