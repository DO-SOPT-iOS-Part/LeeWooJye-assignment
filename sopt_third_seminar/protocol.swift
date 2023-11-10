//
//  protocol.swift
//  sopt_third_seminar
//
//  Created by Woo Jye Lee on 11/9/23.
//

import Foundation

protocol WeatherInfoViewDelegate: AnyObject {
    func weatherInfoViewTapped(_ weatherinfo: ItemListTableViewCell)
}
