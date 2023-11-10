//
//  WeatherListData.swift
//  sopt_third_seminar
//
//  Created by Woo Jye Lee on 11/9/23.
//

import Foundation

struct WeatherListData {
    let dayLabel: String
    let maxtemp: String
    let mintemp: String
    let weatherLabel: String
    let barLabel: String
    
    init(dayLabel: String, maxtemp: String, mintemp: String, weatherLabel: String, barLabel: String) {
        self.dayLabel = dayLabel
        self.maxtemp = maxtemp
        self.mintemp = mintemp
        self.weatherLabel = weatherLabel
        self.barLabel = barLabel
    }
}

var weatherListData: [WeatherListData] = [.init(dayLabel: "오늘",
                                                maxtemp: "20",
                                                mintemp: "10",
                                                weatherLabel: "rain",
                                                barLabel: "bar1"),
                                          .init(dayLabel: "월",
                                                maxtemp: "20",
                                                mintemp: "10",
                                                weatherLabel: "rain",
                                                barLabel: "bar2"),
                                          .init(dayLabel: "화",
                                                maxtemp: "20",
                                                mintemp: "10",
                                                weatherLabel: "rain",
                                                barLabel: "bar3"),
                                          .init(dayLabel: "수",
                                                maxtemp: "20",
                                                mintemp: "10",
                                                weatherLabel: "rain",
                                                barLabel: "bar4"),
                                          .init(dayLabel: "목",
                                                maxtemp: "20",
                                                mintemp: "10",
                                                weatherLabel: "rain",
                                                barLabel: "bar5"),
                                          .init(dayLabel: "금",
                                                maxtemp: "20",
                                                mintemp: "10",
                                                weatherLabel: "rain",
                                                barLabel: "bar6"),
                                          .init(dayLabel: "토",
                                                maxtemp: "20",
                                                mintemp: "10",
                                                weatherLabel: "rain",
                                                barLabel: "bar7"),
                                          .init(dayLabel: "일",
                                                maxtemp: "20",
                                                mintemp: "10",
                                                weatherLabel: "rain",
                                                barLabel: "bar8"),
                                          .init(dayLabel: "월",
                                                maxtemp: "20",
                                                mintemp: "10",
                                                weatherLabel: "rain",
                                                barLabel: "bar9"),
                                          .init(dayLabel: "화",
                                                maxtemp: "20",
                                                mintemp: "10",
                                                weatherLabel: "rain",
                                                barLabel: "bar10")
]
