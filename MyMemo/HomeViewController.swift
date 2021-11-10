//
//  HomeViewController.swift
//  MyMemo
//
//  Created by Donggeun Lee on 2021/11/09.
//

/*
 What to do:
 - 핀 스와이프 고정 기능 만들기
 - 폰트 이쁘게 정리하기
 - 레이블 스페이싱 다시 정렬해보기
 - 서치바 설정하기
 - tableview 섹션 나누기
 - tableviewcell 명암, 프레임 이쁘게 하기
 - 스토리보드 각각 분리시키기
 */

import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var count2Label: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var items: Results<MemoData>!
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        items = localRealm.objects(MemoData.self)
        
        countLabel.text = String(items.count)
        countLabel.textAlignment = .center
        
        count2Label.text = "개의 메모"
        count2Label.textAlignment = .left
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
        else {
            return UITableViewCell()
        }
        
        let row = items[indexPath.row]
        
        cell.contentLabel.text = row.title
        cell.detailLabel.text = row.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        try! localRealm.write {
            localRealm.delete(items[indexPath.row])
            tableView.reloadData()
        }
    }
    
    
}
