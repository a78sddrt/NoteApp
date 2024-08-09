//
//  ContentView.swift
//  DemoFireBase
//
//  Created by 王崇亘 on 2024/8/5.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View {
    @State private var showingSheet = false
    @State private var postDetent = PresentationDetent.medium
    @ObservedObject private var viewModel = NoteViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                
                List{
                    ForEach(viewModel.notes, id:\.id){ Note in
                        NavigationLink(destination: DetailsView(note: Note)){
                            VStack(alignment: .leading){
                                Text(Note.title ?? "")
                                    .foregroundColor(.black)
                                    .font(.system(size:22, weight: .regular))
                                    .frame(maxHeight: 200)
                            }
                        }
                    }
                    .onDelete(perform: self.viewModel.deleteData(at:))
                }
                .background(
                    Image("bg")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.3)
                        .ignoresSafeArea()
                )
                .onAppear(perform: self.viewModel.fetchData)
                .toolbar{
                    ToolbarItemGroup(placement: .bottomBar){
                        Text("\(viewModel.notes.count) notes")
                            .foregroundColor(.mint)
                        
                        Spacer()
                        
                        Button{
                            //Write new note
                            showingSheet.toggle()
                        }label: {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.mint)
                        }
                        .imageScale(.large)
                        .sheet(isPresented: $showingSheet){
                            FormView().presentationDetents([.large, .medium])
                        }
                    }
                    
                    ToolbarItemGroup(placement: .cancellationAction) {
                        Button {
                            authModel.signOut()
                        } label: {
                            Text("Logout")
                                .bold()
                                .foregroundColor(.mint)
                        }
                    }
                }
                .navigationTitle("Notes")
            }
        }
        .tint(.mint)
        .scrollContentBackground(.hidden)
    }
    
}


#Preview {
    ContentView()
}
