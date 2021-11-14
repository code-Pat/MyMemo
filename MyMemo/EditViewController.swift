//
//  EditViewController.swift
//  MyMemo
//
//  Created by Donggeun Lee on 2021/11/09.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {

    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    var items: Results<MemoData>!
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = localRealm.objects(MemoData.self)


    }
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        if textView.text.isEmpty {
            saveButton.isEnabled = false
        } else {
            let title = "title"
            let texts = String(textView.text)
            let object = self.makeMemoData(title, texts)
            try! localRealm.write {
                localRealm.add(object)
            }
        }
    }
    
    @IBAction func shareButtonClicked(_ sender: UIBarButtonItem) {
    }
    
    func makeMemoData(_ title: String, _ content: String) -> MemoData {
        let memodata = MemoData()
        memodata.title = title
        memodata.content = content
        
        return memodata
    }
    
}
