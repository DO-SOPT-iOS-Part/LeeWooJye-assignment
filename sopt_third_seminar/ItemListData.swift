//
//  ItemListData.swift
//  sopt_third_seminar
//
//  Created by Woo Jye Lee on 11/9/23.
//

import Foundation

struct ItemListData {
    let locationLabel: String
    let maxtemp: String
    let mintemp: String
    let weatherLabel: String
    let tempLabel: String
    
    init(locationLabel: String, maxtemp: String, mintemp: String, weatherLabel: String, tempLabel: String) {
        self.locationLabel = locationLabel
        self.maxtemp = maxtemp
        self.mintemp = mintemp
        self.weatherLabel = weatherLabel
        self.tempLabel = tempLabel
    }
}

var itemListData: [ItemListData] = [.init(locationLabel: "의정부시",
                                          maxtemp: "20",
                                          mintemp: "10",
                                          weatherLabel: "흐림",
                                          tempLabel: "15"),
                                    .init(locationLabel: "강남구",
                                          maxtemp: "20",
                                          mintemp: "10",
                                          weatherLabel: "흐림",
                                          tempLabel: "15")
]
