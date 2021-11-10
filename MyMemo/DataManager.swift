//
//  DataManager.swift
//  MyMemo
//
//  Created by Donggeun Lee on 2021/11/10.
//

import Foundation
import RealmSwift

class MemoData: Object {
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var date = Date()
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String, content: String) {
        self.init()
        self.title = title
        self.content = content
        self.date = Date()
    }
}
