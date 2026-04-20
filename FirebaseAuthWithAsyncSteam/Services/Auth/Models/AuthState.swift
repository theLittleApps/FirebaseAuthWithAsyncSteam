//
//  UserAuthInfo.swift
//  FirebaseAuthWithAsyncSteam
//
//  Created by YEN-JU HUANG on 2026/4/14.
//

import Foundation
import FirebaseAuth

enum AuthState: Equatable {
    case unknown
    case signedIn(uid: String, email: String?)
    case signedOut
}
