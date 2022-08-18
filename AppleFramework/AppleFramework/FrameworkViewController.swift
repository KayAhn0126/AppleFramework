//
//  FrameworkViewController.swift
//  AppleFramework
//
//  Created by Kay on 2022/08/18.
//

import UIKit

class FrameworkViewController: UIViewController {

    var frameworkList: [AppleFramework] = AppleFramework.list
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

    }
}

// Data, Presentation, Layout 설정하기!
extension FrameworkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameworkList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCollectionViewCell", for: indexPath) as? FrameworkCollectionViewCell else {
            return UICollectionViewCell()
        }
        let framework = frameworkList[indexPath.item]
        cell.configure(framework)
        return cell
    }
}

extension FrameworkViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        
        let width = (collectionView.bounds.width - itemSpacing * 2) / 3
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    // MARK: - 열과 열 사이의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - 행과 행 사이의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
