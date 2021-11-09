//
//  OnboardingCollectionViewCell.swift
//  MyMemo
//
//  Created by Donggeun Lee on 2021/11/09.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "onboardingCollectionViewCell"
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var welcomLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        welcomLabel.text = slide.title
        mainLabel.text = slide.description
    }
}
