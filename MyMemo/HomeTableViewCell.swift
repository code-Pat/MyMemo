//
//  HomeTableViewCell.swift
//  MyMemo
//
//  Created by Donggeun Lee on 2021/11/10.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "homeTableViewCell"

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
}
