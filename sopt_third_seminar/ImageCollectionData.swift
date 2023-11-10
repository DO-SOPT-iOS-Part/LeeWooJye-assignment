//
//  ImageCollectionData.swift
//  sopt_third_seminar
//
//  Created by Woo Jye Lee on 11/9/23.
//

import Foundation

struct ImageCollectionData {
    let time: String
    let image: String // weather icon
    let temp: String
    
    init(time: String, image: String, temp: String) {
        self.time = time
        self.image = image
        self.temp = temp
    }
}

// dummy data 생성
var imageCollectionList: [ImageCollectionData] = [.init(time: "Now", image: "rain", temp: "20"),
                                                  .init(time: "11시", image: "rain", temp: "20"),
                                                  .init(time: "12시", image: "rain", temp: "20"),
                                                  .init(time: "13시", image: "rain", temp: "20"),
                                                  .init(time: "14시", image: "rain", temp: "20"),
                                                  .init(time: "15시", image: "rain", temp: "20"),
                                                  .init(time: "16시", image: "rain", temp: "20"),
                                                  .init(time: "17시", image: "rain", temp: "20"),
                                                  .init(time: "18시", image: "rain", temp: "20"),
                                                  .init(time: "19시", image: "rain", temp: "20")
                                                  ]
