//
//  Misc.swift
//  DemoFireBase
//
//  Created by 王崇亘 on 2024/8/8.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .bold()
            .font(.title2)
            .foregroundColor(.white)
            .frame(width: 150, height: 50)
            .background(
                Color.mint.opacity(0.8),
                in: Capsule(style: .circular)
            )
        
            
    }
}

#Preview {
    ButtonView(text: "Button")
}
