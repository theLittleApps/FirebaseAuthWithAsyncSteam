//
//  MainView.swift
//  FirebaseAuthWithAsyncSteam
//
//  Created by YEN-JU HUANG on 2026/4/14.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let user = authManager.user {
                    Text("Current State: has signed in")
                        .font(.title3)
                    
                    Text("UID: \(user.uid)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    
                    Button("Sign Out") {
                        authManager.signOut()
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Text("Current State: not sign in")
                        .font(.title3)
                    
                    Button {
                        authManager.signInAnonymously()
                    } label: {
                        if authManager.isLoading {
                            ProgressView()
                        } else {
                            Text("Signed in with Anonymous")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(authManager.isLoading)                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    MainView()
}
