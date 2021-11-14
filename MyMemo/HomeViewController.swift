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
    @IBOutlet weak var composeButton: UIButton!
    
    var items: Results<MemoData>!
    var memoCount = 0
    var pinnedItems: Results<MemoData>!
    var unpinnedItems: Results<MemoData>!
    var searchedItems: Results<MemoData>!
    
    let localRealm = try! Realm()
    
    var searchC: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self

        items = localRealm.objects(MemoData.self)
        pinnedItems = localRealm.objects(MemoData.self).filter("isPinned == true")
        unpinnedItems = localRealm.objects(MemoData.self).filter("isPinned == false")
        
        countLabel.text = String(memoCount)
        countLabel.textAlignment = .center
        
        count2Label.text = "개의 메모"
        count2Label.textAlignment = .left
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memoCount = items.count
        tableView.reloadData()
    }

    @IBAction func composeBtnClicked(_ sender: UIButton) {
        guard let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as? EditViewController else { return }
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func isSearching() -> Bool {
        return searchC.isActive
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching() {
            return searchedItems.count
        } else {
            return section == 0 ? pinnedItems.count : unpinnedItems.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching() {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching() {
            return "\(searchedItems.count)개의 메모 검색됨"
        } else {
            if section == 0 {
                return "Pinned Memos"
            } else {
                return "Memos"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.font = .boldSystemFont(ofSize: 22)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isSearching() {
            return 45
        } else {
            if pinnedItems.count == 0 && section == 0 {
                return 0
            }
            return 45
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
        else {
            return UITableViewCell()
        }
        
        //let row = items[indexPath.row]
        //let currentDate = Calendar.current.dateComponents([.weekOfYear, .day], from: Date())
        
        if isSearching() {
            let row = searchedItems[indexPath.row]
            
            cell.contentLabel.text = row.title
            cell.detailLabel.text = row.content
            
        } else {
            if indexPath.section == 0 {
                let row = pinnedItems[indexPath.row]
                
                cell.contentLabel.text = row.title
                cell.detailLabel.text = row.content
                
            } else {
                let row = unpinnedItems[indexPath.row]
                cell.contentLabel.text = row.title
                cell.detailLabel.text = row.content
            }
        }
        
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
