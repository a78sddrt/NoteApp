//
//  HomeView.swift
//  Note
//
//  Created by 王崇亘 on 2024/8/11.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView{
            PostOnlineView().tabItem {
                Image(systemName: "house")
            }
            
            NoteListView().tabItem {
                Image(systemName: "doc.text.below.ecg.fill.rtl")
            }
        }
        .accentColor(.mint)
        .background(
            Image("bg")
                .resizable()
                .scaledToFill()
                .opacity(0.3)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    HomeView()
}
