//
//  weatherinfo.swift
//  sopt_second_seminar
//
//  Created by Woo Jye Lee on 10/25/23.
//
// 홈 화면에서 보이는 날씨 정보 박스

import UIKit

class weatherinfo: UIView {
    weak var delegate: WeatherInfoViewDelegate?
    var Location: String
    var Temperature: String
    var Maxtemp: String
    var Mintemp: String
    var Weather: String
    
// weatherinfo.swift파일에서는 push/pop을 할 수 없으니 weatherinfo는 클릭이라는 이벤트만 받고 push/pop처리는 viewcontroller.swift에서 해야한다..(?)
    
    init(location: String, weather: String, temperature: String, max: String, min:String) {
        Location = location
        Temperature = temperature
        Maxtemp = "최고: \(max)"
        Mintemp = "최저: \(min)"
        Weather = weather
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 10
        self.setLayout()
        self.setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let backgroundimage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "elementviewimg"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var locationlabel: UILabel = {
        let location = UILabel()
        location.textColor = .white
        location.text = self.Location
        location.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return location
    }()
    
    lazy var mylocation: UILabel = {
        let mylocation = UILabel()
        mylocation.text = "나의 위치"
        mylocation.textColor = .white
        mylocation.font = UIFont(name: "SFProDisplay-Medium", size: 25)
        return mylocation
    }()
    
    lazy var temperaturelabel: UILabel = {
        let temperature = UILabel()
        temperature.textColor = .white
        temperature.text = self.Temperature
        temperature.font = UIFont(name: "SFProDisplay-Medium", size: 52)
        return temperature
    }()
    
    lazy var maxtemp: UILabel = {
        let maxtemp = UILabel()
        maxtemp.textColor = .white
        maxtemp.text = self.Maxtemp
        maxtemp.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        return maxtemp
    }()
    
    lazy var mintemp: UILabel = {
        let mintemp = UILabel()
        mintemp.textColor = .white
        mintemp.text = self.Mintemp
        mintemp.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        return mintemp
    }()
    
    lazy var weatherlabel: UILabel = {
        let weather = UILabel()
        weather.textColor = .white
        weather.text = self.Weather
        weather.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return weather
    }()
    
    private func setLayout() {
        [backgroundimage, mylocation, locationlabel, weatherlabel, temperaturelabel, maxtemp, mintemp].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0) // 라벨들이 들어갈 전체뷰(?)는 따로 선언하지 않아도 되는지?
        }
        
        NSLayoutConstraint.activate([
            backgroundimage.topAnchor.constraint(equalTo: topAnchor),
            backgroundimage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundimage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundimage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mylocation.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            mylocation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            locationlabel.topAnchor.constraint(equalTo: mylocation.bottomAnchor),
            locationlabel.leadingAnchor.constraint(equalTo: mylocation.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherlabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7), // 음수??
            weatherlabel.leadingAnchor.constraint(equalTo: mylocation
                .leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperaturelabel.topAnchor.constraint(equalTo: mylocation.topAnchor),
            temperaturelabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            mintemp.bottomAnchor.constraint(equalTo: weatherlabel.bottomAnchor),
            mintemp.trailingAnchor.constraint(equalTo: temperaturelabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            maxtemp.bottomAnchor.constraint(equalTo: weatherlabel.bottomAnchor),
            maxtemp.trailingAnchor.constraint(equalTo: mintemp.leadingAnchor, constant: -5)
        ])
    }
    
    // tap 감지는 weatherinfo 객체가 하고, 감지에 대한 이벤트 처리는 delegate로
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    // 박스클릭에 대한 화면전환은 viewcontroller가 수행
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.weatherInfoViewTapped(self)
    }
}
