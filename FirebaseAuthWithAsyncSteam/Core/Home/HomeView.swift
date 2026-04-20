//
//  HomeView.swift
//  FirebaseAuthWithAsyncSteam
//
//  Created by YEN-JU HUANG on 2026/4/14.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    let uid: String
    let email: String?
    
    @Environment(AuthViewModel.self) private var vm
            
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome Back!")
                .font(.title)
            
            Text("UID: \(uid)")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            if let email {
                Text(email)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            Button("Sign Out") {
                vm.signOut()
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    HomeView(uid: "test-xxxxxxxx", email: "test@gmail.com")
}
