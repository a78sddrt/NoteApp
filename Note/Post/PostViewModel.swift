//
//  PostViewModel.swift
//  Note
//
//  Created by 王崇亘 on 2024/8/11.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage


class PostViewModel: ObservableObject {
    @Published var posts = [Post]()
    let storageReference = Storage.storage().reference().child("\(UUID().uuidString)")
    private var databaseReference = Firestore.firestore().collection("Post")
    
// Function to post data
    func addData(description: String, datePublished: Date, data: Data) async{
        do {
            _ = try await
            storageReference.putData(data, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    return
                }
                self.storageReference.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        return
                    }
                    self.databaseReference.addDocument(data: ["description": description, "datePublished": datePublished, "imageURL": downloadURL.absoluteString])
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

