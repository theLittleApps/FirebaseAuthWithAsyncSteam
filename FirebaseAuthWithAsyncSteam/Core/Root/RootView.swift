//
//  RootView.swift
//  FirebaseAuthWithAsyncSteam
//
//  Created by YEN-JU HUANG on 2026/4/17.
//

import SwiftUI

struct RootView: View {
    
    @Environment(AuthViewModel.self) private var vm
    
    var body: some View {
        Group {
            switch vm.state {
            case .unknown:
               ProgressView("Signing in...")
            case .signedIn(let uid, let email):
                HomeView(uid: uid, email: email)
            case .signedOut:
                LoginView()
            }
        }
        .task {
            vm.addAuthListener()
        }
    }
}

#Preview {
    RootView()
}
