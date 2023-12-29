//
//  VCViewModel.swift
//  sopt_fourth_seminar0
//
//  Created by Woo Jye Lee on 12/14/23.
//

import Foundation
import UIKit

import SnapKit
import Then

final class VCViewModel: NSObject {
    
}

extension VCViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier,
                                                       for: indexPath) as? ItemListTableViewCell else {return UITableViewCell()}
        cell.delegate = ViewController()
        cell.bindData(data: itemListData[indexPath.row])
        
        return cell
    }
}
