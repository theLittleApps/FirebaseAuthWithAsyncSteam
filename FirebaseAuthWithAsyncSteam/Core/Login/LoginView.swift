//
//  LoginView.swift
//  FirebaseAuthWithAsyncSteam
//
//  Created by YEN-JU HUANG on 2026/4/17.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AuthViewModel.self) private var vm
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to AsyncSteam")
                .font(.title)
            
            Button("Signed In with Anonymous") {
                vm.signInAnonymously()
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    LoginView()
}
