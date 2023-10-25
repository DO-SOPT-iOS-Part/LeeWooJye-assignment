//
//  SecondViewController.swift
//  sopt_second_seminar
//
//  Created by Woo Jye Lee on 10/14/23.
//
// 날씨 상세 페이지

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SecondViewController"
        self.setLayout()
    }
    
    init(location: String, temperature: String, weather: String, maxtemp: String, mintemp: String) {
        topview.location.text = location
        temperaturelabel.text = temperature
        weather.text = weather
        maxtemp.text = maxtemp
        mintemp.text = mintemp
        super.init(nibName: nil, bundle: nil)
    }
    
//    var location: String = ""
//    var temperature: String = ""
//    var
//    private func bindText() {
//        self.emailLabel.text = "email : \(email)"
//        self.passwordLabel.text = "password : \(password)"
//    }
    
    private func setLayout() {
        [topview, scrollview, bottomview].forEach{ [weak self] view in
            guard let self else {return}
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        contentview.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        scrollview2.translatesAutoresizingMaskIntoConstraints = false
        detailview.translatesAutoresizingMaskIntoConstraints = false
        
        // scrollview 하위뷰에 꼭 contentview가 와야하나?
        scrollview.addSubview(contentview)
        contentview.addSubview(scrollview2)
        scrollview2.addSubview(detailview)
        contentview.addSubview(lineView)
        contentview.addSubview(descriptionView)
        
        NSLayoutConstraint.activate([topview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
                                     topview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     topview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     topview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 80)
        ])
        NSLayoutConstraint.activate([lineView.topAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: 0),
                                     lineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     lineView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     lineView.heightAnchor.constraint(equalToConstant: 5)
        ])
        NSLayoutConstraint.activate([bottomview.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 0),
                                     bottomview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
                                     bottomview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     bottomview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([contentview.topAnchor.constraint(equalTo: scrollview.topAnchor, constant: 10),
                                     contentview.heightAnchor.constraint(equalToConstant: 200),
                                     contentview.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 20),
                                     contentview.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([descriptionView.topAnchor.constraint(equalTo: contentview.topAnchor, constant: 0),
                                     descriptionView.heightAnchor.constraint(equalToConstant: 45),
                                     descriptionView.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 0),
                                     descriptionView.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([lineView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 0),
                                     lineView.heightAnchor.constraint(equalToConstant: 5),
                                     lineView.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 0),
                                     lineView.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([scrollview2.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 0),
                                     scrollview2.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: 0),
                                     scrollview2.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 0),
                                     scrollview2.bottomAnchor.constraint(equalTo: contentview.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([detailview.topAnchor.constraint(equalTo: scrollview2.bottomAnchor, constant: 0),
                                     detailview.trailingAnchor.constraint(equalTo: scrollview2.trailingAnchor, constant: 0),
                                     detailview.leadingAnchor.constraint(equalTo: scrollview2.leadingAnchor, constant: 0),
                                     detailview.bottomAnchor.constraint(equalTo: scrollview2.bottomAnchor, constant: 0)
        ])
    }
    
    // 위치, 온도, 날씨, 최고최저기온으로 구성 + 수직으로 스크롤하면 날씨, 온도가 한 줄로 합쳐짐.
    var topview: UIView = {
        let view = UIView(frame: .init(origin: .zero, size: .init()))
        
        let location = UILabel()
        location.textColor = .white
        location.font = UIFont(name: "SFProDisplay-Regular", size: 45)
        
        let max = UILabel()
        max.textColor = .white
        max.font = UIFont(name: "SFProDisplay-Regular", size: 23)

        let min = UILabel()
        min.textColor = .white
        min.font = UIFont(name: "SFProDisplay-Regular", size: 23)

        let weather = UILabel()
        weather.textColor = .white
        weather.font = UIFont(name: "SFProDisplay-Regular", size: 25)

        let temperature = UILabel()
        temperature.textColor = .white
        temperature.font = UIFont(name: "SFProDisplay-Light", size: 75)
        
        [location, temperature, weather, max, min].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([location.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     location.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([temperature.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 10),
                                     temperature.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([weather.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: 10),
                                     weather.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([max.topAnchor.constraint(equalTo: weather.bottomAnchor, constant: 10),
                                     max.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
        NSLayoutConstraint.activate([min.topAnchor.constraint(equalTo: weather.bottomAnchor, constant: 10),
                                     min.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50)
                                    ])
        
        view.clipsToBounds = false
        return view
    }()
    
    // 구조 : 수직스크롤뷰 > 수평스크롤뷰 > 콘텐츠뷰 > 수평스크롤가능한 스택뷰 > UI뷰
    // AND 콘텐츠뷰 > 텍스트뷰 + 선 UI뷰 + 스택뷰
    var scrollview: UIScrollView = { // 수직 스크롤
        let view = UIScrollView(frame: .init(origin: .zero, size: .init(width: 6, height: 6)))
        view.backgroundColor = .black
        view.clipsToBounds = false
        return view
    }()
    
    // 상세보기 박스에서 상단은 text뷰, 하단은 수평스크롤뷰 > 콘텐츠뷰 > 수평스택뷰 > 개별 UI뷰
    var contentview: UIView = {
        let view = UIView(frame: .init(origin: .zero, size: .init()))
        view.backgroundColor = .black
        view.clipsToBounds = false
        return view
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 20
        
        let label = UILabel()
        label.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        view.addSubview(label)
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
//    private let descriptionLabel: UILabel = {
//        let label = UILabel()
//        label.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
//        label.numberOfLines = 0
//        label.textColor = .white
//        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
//        return label
//    }()
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return view
    }()
    
    var scrollview2: UIScrollView = { // 수평스크롤뷰
        let view = UIScrollView(frame: .init(origin: .zero, size: .init(width: 6, height: 6)))
        view.backgroundColor = .blue
        view.clipsToBounds = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    var detailview: UIStackView = { // 수평스택뷰
        let view = UIStackView(frame: .init(origin: .zero, size: .init()))
        view.backgroundColor = .green
        view.layer.cornerRadius = 3
        view.clipsToBounds = false
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 10
        return view
    }()
    
    // 기상 상태 아이콘으로 표시되는 곳 - 시간/기상아이콘/온도
//    var weatherview: UIImageView = {
//        let view = UIImageView(frame: .init(origin: .zero, size: .init()))
//        view.layer.cornerRadius = 3
//        view.clipsToBounds = false
//        return view
//    }()
    
    // 하단바
    // 아래 클로저는 UIView 객체인 buttomview의 기능을 확장하는 것인가..?
    var bottomview: UIView = {
        let view = UIView(frame: .init(origin: .zero, size: .init()))
        
        // 설정 버튼
        let button = UIButton()
        button.setImage(UIImage(named: "dots"), for: .normal)
        // 설정 버튼 눌리면 상세페이지 pop
        let tap = UITapGestureRecognizer(target: button, action: #selector(popDetailVC(_:)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        // 지도 버튼
        let mapbutton = UIButton()
        button.setImage(UIImage(named: "map"), for: .normal)
        // 화살표 버튼
        let arrow = UIButton()
        arrow.setImage(UIImage(named: "arrow"), for: .normal)
        // 점 하나 버튼
        let dot = UIButton()
        dot.setImage(UIImage(named: "dot"), for: .normal)
        
        [button, mapbutton, arrow, dot].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10)
                                    ])
        NSLayoutConstraint.activate([mapbutton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     mapbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
                                    ])
        NSLayoutConstraint.activate([arrow.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     arrow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 160)
                                    ])
        NSLayoutConstraint.activate([dot.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     dot.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 190)
                                    ])
        
        view.clipsToBounds = false
        return view
    }()
    
    // 홈 화면으로 화면 전환
    @objc
    func popDetailVC(_ gesture: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
