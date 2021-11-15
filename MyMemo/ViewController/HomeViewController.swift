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
    
    let localRealm = try! Realm()
    
    var items: Results<MemoData>!
    var memoCount = 0
    
    var pinnedItems: Results<MemoData>!
    var unpinnedItems: Results<MemoData>!
//    var searchedItems: Results<MemoData>!
    
    
    
    // var searchC: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self

        
        items = localRealm.objects(MemoData.self)
        print("Realm is located at:", localRealm.configuration.fileURL!)
    
//        pinnedItems = localRealm.objects(MemoData.self).filter("isPinned == true")
//        unpinnedItems = localRealm.objects(MemoData.self).filter("isPinned == false")
        
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
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    /* original
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    */
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !(pinnedItems.isEmpty) {
            return section == 0 ? "Pinned Memos" : "Memos"
        } else {
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pinnedItems.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pinnedItems.isEmpty {
            return unpinnedItems.count
        } else {
            return section == 0 ? pinnedItems.count : unpinnedItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        var row = items[indexPath.row]
        if pinnedItems.isEmpty {
            row = unpinnedItems[indexPath.row]
        } else {
            indexPath.section == 0 ? (row = pinnedItems[indexPath.row]) : (row = unpinnedItems[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var row = items[indexPath.row]
        if self.pinnedItems.isEmpty {
            row = self.unpinnedItems[indexPath.row]
        } else {
            indexPath.section == 0 ? (row = self.pinnedItems[indexPath.row]) : (row = self.unpinnedItems[indexPath.row])
        }
                
        let pin = UIContextualAction(style: .normal, title: nil, handler: {action, view, completion in
            try! self.localRealm.write {
                row.isPinned = !row.isPinned
            }
            completion(true)
        })
        
        row.isPinned ? (pin.image = UIImage(systemName: "pin.slash.fill")) : (pin.image = UIImage(systemName: "pin.fill"))
        pin.image?.withTintColor(.white)
        pin.backgroundColor = .systemOrange
        
        return UISwipeActionsConfiguration(actions: [pin])
    }
    
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? pinnedItems.count : unpinnedItems.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pinned Memos"
        } else {
            return "Memos"
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.font = .boldSystemFont(ofSize: 22)
        }
    }
     
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if pinnedItems.count == 0 && section == 0 {
            return 0
        }
        return 45
    }
    */
    
    /* original
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
        else {
            return UITableViewCell()
        }
        
        let row = items[indexPath.row]
        //let currentDate = Calendar.current.dateComponents([.weekOfYear, .day], from: Date())
        /*
        if indexPath.section == 0 {
            let row = pinnedItems[indexPath.row]
            
            cell.contentLabel.text = row.title
            cell.detailLabel.text = row.content
            
        } else {
            let row = unpinnedItems[indexPath.row]
            cell.contentLabel.text = row.title
            cell.detailLabel.text = row.content
        }
        */
        
        cell.contentLabel.text = row.title
        cell.detailLabel.text = row.content
        
        return cell
    }
     */
    
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
