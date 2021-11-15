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
    @Persisted var date: Date
    @Persisted var isPinned: Bool
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String, content: String, date: Date) {
        self.init()
        
        self.title = title
        self.content = content
        self.date = date
        //self.isPinned = false
    }
}
