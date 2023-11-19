//
//  protocol.swift
//  sopt_fourth_seminar0
//
//  Created by Woo Jye Lee on 11/15/23.
//

import Foundation

protocol WeatherInfoViewDelegate: AnyObject {
    func weatherInfoViewTapped(_ weatherinfo: ItemListTableViewCell)
}
