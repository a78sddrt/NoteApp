//
//  HolderView.swift
//  DemoFireBase
//
//  Created by 王崇亘 on 2024/8/8.
//

import SwiftUI

struct HolderView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var isActive = false
    
    var body: some View {
        if isActive == true{
            Group {
                if authModel.user == nil {
                    SignUpView()
                } else {
                       HomeView()
                }
            }
            .onAppear {
                authModel.listenToAuthState()
            }
        }
        else{
            SplashScreenView(isActive: $isActive)
        }
    }
}

#Preview {
    HolderView()
}
