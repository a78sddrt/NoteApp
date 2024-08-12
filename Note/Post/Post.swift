//
//  Psot.swift
//  Note
//
//  Created by 王崇亘 on 2024/8/11.
//

import SwiftUI
import FirebaseFirestore

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    var description: String?
    var imageURL: String?
    @ServerTimestamp var datePublished: Date?
}
