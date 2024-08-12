//
//  PostOnlineView.swift
//  Note
//
//  Created by 王崇亘 on 2024/8/11.
//

import SwiftUI
import FirebaseFirestore

struct PostOnlineView: View {
    @FirestoreQuery(collectionPath: "Post") var posts: [Post]
    @ObservedObject private var postViewModel = PostViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack{
            List(posts) { posts in
                VStack(alignment: .leading) {
                    VStack {
                        AsyncImage(url: URL(string: posts.imageURL ?? "")) { phase in
                            switch phase {
                            case .empty:
                                EmptyView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 300, height: 200)
                            case .failure:
                                Image(systemName:"photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        Text(posts.description ?? "")
                            .font(.headline)
                            .padding(12)
                        Text("Published on the \(posts.datePublished?.formatted() ?? "")")
                            .font(.caption)
                    }
                }
                .frame(minHeight: 100, maxHeight: 350)
            }
            .scrollContentBackground(.hidden)
            .background(
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.3)
                    .ignoresSafeArea()
            )
            .toolbar{
                ToolbarItemGroup(placement: .cancellationAction) {
                    Button {
                        authModel.signOut()
                    } label: {
                        Text("Logout")
                            .bold()
                            .foregroundColor(.mint)
                    }
                }
                
                
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button{
                        //Write new note
                        showingSheet.toggle()
                    }label: {
                        Image(systemName: "plus")
                            .foregroundColor(.mint)
                    }
                    .imageScale(.large)
                    .sheet(isPresented: $showingSheet){
                        PostView().presentationDetents([.large, .medium])
                    }
                }
                
               
            }
        }
        .refreshable {}
    }
    
}

#Preview {
    PostOnlineView()
}
