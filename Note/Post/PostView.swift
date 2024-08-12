//
//  PostView.swift
//  Note
//
//  Created by 王崇亘 on 2024/8/11.
//

import SwiftUI
import PhotosUI

struct PostView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var description = ""
    @ObservedObject private var postViewModel = PostViewModel()
    
    @State var data: Data?
    @State var selectedItem: [PhotosPickerItem] = []
    
    var body: some View {
        NavigationStack{
                VStack{
                    
                    //照片選擇器
                    PhotosPicker(selection: $selectedItem,
                    maxSelectionCount: 1, selectionBehavior:
                    .default, matching: .images,
                    preferredItemEncoding: .automatic) {
                        if let data = data, let image = UIImage(data: data)
                        {
                            Image(uiImage: image)
                                .resizable()
                                .resizable()
                                .scaledToFit()
                                .frame( maxHeight: 300)
                        } else {
                            Label("Select a picture",systemImage: "photo.on.rectangle.angled")
                                .foregroundColor(.mint)
                        }
                    }.onChange(of: selectedItem) { newValue in
                        guard let item = selectedItem.first
                        else {
                            return
                        }
                        item.loadTransferable(type: Data.self)
                        {result in
                            switch result {
                                case .success(let data):
                                if let data = data {
                                    self.data = data
                                    }
                            
                                case .failure(let failure):
                                print("Error: \(failure.localizedDescription)")
                            }
                        }
                    }
                    
                    
                        //文字選擇器
                        TextEditor(text: $description)
                        .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.mint.opacity(0.4), lineWidth: 2)
                            )
                            .padding()
                        Button(action:{
                            Task{
                                await
                                self.postViewModel.addData(description:description,
                                                           datePublished: Date(), data: data!)
                                description = ""
                                dismiss()
                            }
                        }){
                            ButtonView(text:"Post")
                        }
                        .scaleEffect(0.8)
                        .disabled(self.description.isEmpty)
                        .disabled(data == nil)
                        .foregroundColor(.black)
                }
                .background(
                    Image("bg")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.3)
                        .ignoresSafeArea()
                )
                .navigationTitle("Post")
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
    PostView()
}
