//
//  OnboardingViewController.swift
//  MyMemo
//
//  Created by Donggeun Lee on 2021/11/09.
//

/*
 What to fix :
 - UI 조금 더 이쁘게 만들기...
 - get started 버튼이 활성화 됐다가 다시 전 페이지로 돌아가면 버튼색이 주황색으로 남아있음 -> make it back to grey
 - 이미지 스샷찍어서 업뎃해주기
 - get started 에서 페이지 넘어가는 애니메이션 더 나은거 찾아보기
 */

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
                nextButton.backgroundColor = .orange
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
        
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
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "homeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
