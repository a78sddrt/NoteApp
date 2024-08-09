//
//  DetailView.swift
//  DemoFireBase
//
//  Created by 王崇亘 on 2024/8/8.
//

import SwiftUI



struct DetailsView: View {
    @State private var showingEdit = false
    @State private var showingEdit2 = false
    @State private var titleText: String = ""
    @ObservedObject private var viewModel = NoteViewModel()
    @Environment(\.dismiss) var dismiss
    
    var note: Note
    
    var body: some View {
            NavigationStack{
                ScrollView {
                    VStack{
                        Text("\(note.title ?? "")")
                            .bold()
                            .font(.title)
                            .padding()
                       
                    }
                    .toolbar{
                        ToolbarItemGroup(placement: .confirmationAction) {
                            Button {
                                showingEdit2.toggle()
                            } label: {
                                Text("Edit")
                                    .bold()
                                    .foregroundColor(.mint)
                                    .padding()
                            }
                            .sheet(isPresented: $showingEdit2){
                                EditView(titleText: note.title ?? "", viewModel: viewModel, note: note).presentationDetents([.large, .medium])
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(
                    Image("bg")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.6)
                        .ignoresSafeArea()
                )
            }
            .tint(.white)
            .navigationTitle("Details")
            
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(note: Note(id: "bKrivNkYirmMvHyAUBWv", title:"Issues are never simple. One thing I'm proud of is that very rarely will you hear me simplify the issues. \n Barack Obama"))
    }
}
