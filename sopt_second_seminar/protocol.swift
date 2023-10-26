//
//  protocol.swift
//  sopt_second_seminar
//
//  Created by Woo Jye Lee on 10/25/23.
//

import Foundation

protocol WeatherInfoViewDelegate: AnyObject {
    func weatherInfoViewTapped(_ weatherinfo: weatherinfo)
}

protocol labelset: AnyObject {
    var location: String {get set}
    var temperature: String {get set}
    var maxtemp: String {get set}
    var mintemp: String {get set}
    var weather: String {get set}
}
