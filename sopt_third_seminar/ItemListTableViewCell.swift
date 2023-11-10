//
//  ItemListTableViewCell.swift
//  sopt_third_seminar
//
//  Created by Woo Jye Lee on 11/9/23.
//

import UIKit
import SnapKit
import Then

class ItemListTableViewCell: UITableViewCell {
    
    static let identifier: String = "ItemListTableViewCell"
    weak var delegate: WeatherInfoViewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
        self.setupGestureRecognizers()
        self.layer.cornerRadius = 20 // 셀의 테두리에 곡선줌
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(data: ItemListData) {
        self.locationLabel.text = data.locationLabel
        self.maxtemp.text = "최고: \(data.maxtemp)°C"
        self.mintemp.text = "최저: \(data.mintemp)°C"
        self.tempLabel.text = "\(data.tempLabel)°C"
        self.weatherLabel.text = data.weatherLabel
    }
    
    private func setLayout() {
        self.backgroundColor = .black
        // tableviewcell 높이 지정 **
//        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: 117)
//        ])
        [backgroundimage, mylocationLabel, locationLabel, weatherLabel, tempLabel, maxtemp, mintemp].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundimage.topAnchor.constraint(equalTo: topAnchor),
            backgroundimage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundimage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundimage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            mylocationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            mylocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: mylocationLabel.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: mylocationLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            weatherLabel.leadingAnchor.constraint(equalTo: mylocationLabel
                .leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: mylocationLabel.topAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            mintemp.bottomAnchor.constraint(equalTo: weatherLabel.bottomAnchor),
            mintemp.trailingAnchor.constraint(equalTo: tempLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            maxtemp.bottomAnchor.constraint(equalTo: weatherLabel.bottomAnchor),
            maxtemp.trailingAnchor.constraint(equalTo: mintemp.leadingAnchor, constant: -5)
        ])
    }
    
    let backgroundimage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "small_background"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let locationLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        $0.textColor = .white
    }
    
    let mylocationLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Bold", size: 25)
        $0.textColor = .white
        $0.text = "나의 위치"
    }
    
    let maxtemp = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        $0.textColor = .white
    }
    
    let mintemp = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        $0.textColor = .white
    }
    
    let weatherLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        $0.textColor = .white
    }
    
    let tempLabel = UILabel().then {
        $0.font = UIFont(name: "SFProDisplay-Light", size: 52)
        $0.textColor = .white
    }
    
    // tap 감지는 weatherinfo 객체가 하고, 감지에 대한 이벤트 처리는 delegate로
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    // cell click에 대한 화면전환은 viewcontroller가 수행
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.weatherInfoViewTapped(self)
    }
    
    // cell 간 간격을 주기 위해 메소드 오버라이딩
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0))
    }

}
