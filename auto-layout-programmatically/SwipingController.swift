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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
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
}

