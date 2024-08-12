//
//  SplashScreenView.swift
//  Note
//
//  Created by 王崇亘 on 2024/8/9.
//

import SwiftUI

struct SplashScreenView: View {
    @Binding var isActive: Bool
    @State private var size = 0.8
    @State private var opacity = 0.2
    
    var body: some View {
        VStack{
            VStack{
                Image(systemName: "hare.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color.mint)
                      
                Text("Note App")
                    .font(.system(size: 32))
                
            }
            .scaleEffect(0.8)
            .opacity(opacity)
            .onAppear{
                withAnimation(.easeIn(duration: 1.5)){
                    self.size = 0.9
                    self.opacity = 1.0
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                self.isActive = true
            }
        }
    }
}


