//
//  NoteApp.swift
//  Note
//
//  Created by 王崇亘 on 2024/8/9.
//

import SwiftUI
import Firebase

@main
struct NoteApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            HolderView().environmentObject(AuthViewModel())
        }
    }
}
