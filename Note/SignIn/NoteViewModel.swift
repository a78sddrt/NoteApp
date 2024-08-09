//
//  NoteViewModel.swift
//  DemoFireBase
//
//  Created by 王崇亘 on 2024/8/7.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class NoteViewModel: ObservableObject{
    @Published var notes = [Note]()
    private lazy var databaseReference: CollectionReference? = {
        guard let user = Auth.auth().currentUser?.uid else {return nil}
        let ref = Firestore.firestore().collection("Users").document(user).collection("Posts")
            return ref
    }()
    
    // function to post data
    func addData(title: String){
        do{
         _ = try databaseReference?.addDocument(data: ["title": title])
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // function to read data
    func fetchData(){
        databaseReference?.addSnapshotListener{ snapshot, error in
            guard let snapshot else{
                print("No documents")
                return
            }
            self.notes = snapshot.documents.compactMap{
                snapshot in
                return try? snapshot.data(as: Note.self)
            }
            
        }
    }
    
    // function to update data
    func updateData(title: String, id: String) {
        databaseReference?.document(id).updateData(["title" :title]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Note updated successfully")
            }
        }
    }
    
    // function to delete data
    func deleteData(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let note = notes[index]
            databaseReference?.document(note.id ?? "").delete { error in
                if let error = error {
                    print("\(error.localizedDescription)")
                } else {
                    print("Note with ID \(note.id ?? "")deleted")
                }
            }
        }
    }
    
}
