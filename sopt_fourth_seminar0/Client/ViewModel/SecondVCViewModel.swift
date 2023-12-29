//
//  SecondVCViewModel.swift
//  sopt_fourth_seminar0
//
//  Created by Woo Jye Lee on 12/14/23.
//

import Foundation
import UIKit

import SnapKit
import Then

final class SecondVCViewModel: NSObject {
    
}

extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier,
                                                            for: indexPath) as? ImageCollectionViewCell else {return UICollectionViewCell()}
        item.bindData(data: imageCollectionList[indexPath.row])
        return item
    }
}
