//
//  timeline.swift
//  sopt_second_seminar
//
//  Created by Woo Jye Lee on 10/25/23.
//
// 날씨상세보기 박스

import UIKit

class timeline: UIView {
    
    var weatherstatus: String
    
    init(time: String, weather: String, temperature: String) {
        self.weatherstatus = weather
        super.init(frame: .zero)
        timelabel.text = "\(time)"
        weatherimgmatch(weather: weather)
        temperaturelabel.text = "\(temperature)"
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let timelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 19)
        return label
    }()
    
    // UIImageView vs. UIImgage ?
    private let weatherimg: UIImageView = {
        let weatherimg = UIImageView()
        weatherimg.contentMode = .scaleAspectFit
        return weatherimg
    }()
    
    private let temperaturelabel: UILabel = {
        let temperaturelabel = UILabel()
        temperaturelabel.textColor = .white
        temperaturelabel.font = UIFont(name: "SFProDisplay-Medium", size: 19)
        return temperaturelabel
    }()
    
    private func setLayout() {
        [timelabel, weatherimg, temperaturelabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            timelabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            timelabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherimg.topAnchor.constraint(equalTo: centerYAnchor),
            weatherimg.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperaturelabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 60),
            temperaturelabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func weatherimgmatch(weather: String) {
        switch weather {
        case "cloudy":
            weatherimg.image = UIImage(named: "cloudy")
        case "heavyrain":
            weatherimg.image = UIImage(named: "heavyrain")
        case "rainysunny":
            weatherimg.image = UIImage(named: "rainysunny")
        case "rain":
            weatherimg.image = UIImage(named: "rain")
        case "thunder":
            weatherimg.image = UIImage(named: "thunder")
        default:
            weatherimg.image = UIImage(named: "cloudy")
        }
    }
}
