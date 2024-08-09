//
//  HomeView.swift
//  DemoFireBase
//
//  Created by 王崇亘 on 2024/8/7.
//

import SwiftUI

struct FormView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var titleText = ""
    @ObservedObject private var viewModel = NoteViewModel()
    
    var body: some View {
        NavigationStack{
                VStack{
                        TextEditor(text: $titleText)
                        .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.mint.opacity(0.4), lineWidth: 2)
                            )
                            .padding()

                        Button(action:{
                            self.viewModel.addData(title:
                                                    titleText)
                            titleText = ""
                            dismiss()
                        }){
                            ButtonView(text:"Save")
                        }
                        .scaleEffect(0.8)
                        .disabled(self.titleText.isEmpty)
                        .foregroundColor(.black)
                }
                .background(
                    Image("bg")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.3)
                        .ignoresSafeArea()
                )
                .navigationTitle("Publish")
                .toolbar{
                    ToolbarItemGroup(placement: .destructiveAction){
                        Button{
                            dismiss()
                        }label: {
                            Text("Cancel")
                                .foregroundColor(.mint)
                        }
                    }
                }
        }
    }
}




#Preview {
    FormView()
}
