//
//  SwipingController.swift
//  auto-layout-programmatically
//
//  Created by Ray Lin on 2022/3/4.
//

import Foundation
import UIKit


class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages  = [
        Page(imageName: "app_logo", headerText: "Join us today in our fun and games 01", contentText: "Are you ready for loads and loads of fun?\nDon't wait any longer! We hope to see you in our stores soon! 01"),
        Page(imageName: "app_music", headerText: "Join us today in our fun and games 02", contentText: "Are you ready for loads and loads of fun?\nDon't wait any longer! We hope to see you in our stores soon! 02"),
        Page(imageName: "app_remind", headerText: "Join us today in our fun and games 03", contentText: "Are you ready for loads and loads of fun?\nDon't wait any longer! We hope to see you in our stores soon! 03"),
        Page(imageName: "app_cloud", headerText: "Join us today in our fun and games 04", contentText: "")
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrevious() {
        let isFirstPage = pageControl.currentPage > 0
        guard isFirstPage else { return }
        
        let prevIndex = pageControl.currentPage - 1
        let indexPath = IndexPath(item: prevIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = prevIndex
    }
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext() {
        let isLastPage = pageControl.currentPage < pageControl.numberOfPages - 1
        guard isLastPage else { return }
        
        let nextIndex = pageControl.currentPage + 1
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = nextIndex
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = .mainPink
        pageControl.pageIndicatorTintColor = .lightPink
        return pageControl
    }()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        setupBottomControls()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for:   indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
   
    fileprivate func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [
            previousButton,
            pageControl,
            nextButton
        ])
        
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        
        previousButton.backgroundColor = .white
        nextButton.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

