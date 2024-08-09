//
//  Note.swift
//  DemoFireBase
//
//  Created by 王崇亘 on 2024/8/7.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Note: Codable{
    @DocumentID var id: String?
    var title: String?
}
