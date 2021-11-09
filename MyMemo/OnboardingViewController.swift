//
//  OnboardingViewController.swift
//  MyMemo
//
//  Created by Donggeun Lee on 2021/11/09.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        slides = [
            OnboardingSlide(title: "처음 오셨군요! 환영합니다 :)", description: "당신만의 메모를 작성하고 관리해보세요!", image: UIImage(named: "exampleImage")!),
            OnboardingSlide(title: "메모를 작성해보세요!", description: "위 버튼을 눌러 원하는 내용을 작성하세요.", image: UIImage(named: "exampleImage")!),
            OnboardingSlide(title: "홈 화면에서 메모를 관리해보세요!", description: "삭제와 수정을 할 수 있어요.", image: UIImage(named: "exampleImage")!)
        ]
        
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
    }
    

}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
}
