//
//  WeatherTableViewCell.swift
//  sopt_third_seminar
//
//  Created by Woo Jye Lee on 11/9/23.
//

import UIKit
import SnapKit
import Then

class WeatherTableViewCell: UITableViewCell {
    
    static let identifier: String = "WeatherTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(data: WeatherListData) {
        self.dayLabel.text = data.dayLabel
        self.max.text = "\(data.maxtemp)°C"
        self.min.text = "\(data.mintemp)°C"
        self.barImage.image = UIImage(named: data.barLabel)
        self.image.image = UIImage(named: data.weatherLabel)
    }
    
    private func setLayout() {
        // cell높이 정해줌..**
//        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: 60)
//        ])
        
        [dayLabel, image, min, max, barImage].forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        NSLayoutConstraint.activate([max.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                                     max.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        NSLayoutConstraint.activate([barImage.trailingAnchor.constraint(equalTo: max.leadingAnchor, constant: -10),
                                     barImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        NSLayoutConstraint.activate([min.trailingAnchor.constraint(equalTo: barImage.leadingAnchor, constant: -10),
                                     min.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        NSLayoutConstraint.activate([dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                                     dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        NSLayoutConstraint.activate([image.trailingAnchor.constraint(equalTo: min.leadingAnchor, constant: -30),
                                     image.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        return label
    }()
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let min: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "SFProDisplay-Medium", size: 19)
        return label
    }()
    let max: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 19)
        return label
    }()
    let barImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

}
