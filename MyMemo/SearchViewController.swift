//
//  SearchViewController.swift
//  MyMemo
//
//  Created by Donggeun Lee on 2021/11/14.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items: Results<MemoData>!
    var searchedMemo: Results<MemoData>!
    
    var localRealm = try! Realm()
    
    var searchText = ""
    var searchC: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        
        items = localRealm.objects(MemoData.self)
        
        tableView.reloadData()

    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.contentLabel.text = "title"
        cell.detailLabel.text = "content"
        
        return cell
    }

    
    
}
