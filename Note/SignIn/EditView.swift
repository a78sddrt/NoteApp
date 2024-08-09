//
//  EditView.swift
//  DemoFireBase
//
//  Created by 王崇亘 on 2024/8/8.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @State var titleText: String
    var viewModel: NoteViewModel
    var note: Note
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    TextEditor(text: $titleText)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.mint.opacity(0.4), lineWidth: 2)
                        )
                        .padding()
                    
                    Button(action:{
                        self.viewModel.updateData(title: titleText, id: note.id ?? "")
                        titleText = ""
                        dismiss()
                    }){
                        ButtonView(text:"Replace")
                    }
                    .scaleEffect(0.8)
                    .disabled(self.titleText.isEmpty)
                    .foregroundColor(.black)
                }
            }
            .background(
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.3)
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit")
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
    EditView(titleText: "Hello World!", viewModel: NoteViewModel(), note: Note(id: "123", title: "Everthing is Good"))
}
