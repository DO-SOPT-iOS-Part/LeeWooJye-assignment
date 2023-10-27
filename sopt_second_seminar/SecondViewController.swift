//
//  SecondViewController.swift
//  sopt_second_seminar
//
//  Created by Woo Jye Lee on 10/14/23.
//
// 날씨 상세페이지

import UIKit

class SecondViewController: UIViewController {
    var Location: String
    var Temperature: String
    var Maxtemp: String
    var Mintemp: String
    var Weather: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SecondViewController"
        self.setBackgroundImage()
        self.setLayout()
    }
        
    init(location: String, temperature: String, weather: String, maxtemp: String, mintemp: String) {
        // topview에 정보를 입력하기 위해 변수값 할당
        self.Location = location
        self.Temperature = temperature
        self.Maxtemp = maxtemp
        self.Mintemp = mintemp
        self.Weather = weather
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [topview, scrollview, bottomview].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        let timeline1 = timeline(time: "Now", weather: "cloudy", temperature: "18C")
        // let timeline1 = timeline(time: "0", weather: self.Weather, temperature: self.Temperature)

        [timeline1].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            ($0.widthAnchor.constraint(equalToConstant: 65)).isActive = true
            ($0.heightAnchor.constraint(equalToConstant: 105)).isActive = true
            detailview.addArrangedSubview($0)
        }
        
        contentview.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        scrollview2.translatesAutoresizingMaskIntoConstraints = false
        detailview.translatesAutoresizingMaskIntoConstraints = false
        box.translatesAutoresizingMaskIntoConstraints = false
        
        // scrollview 하위뷰에 꼭 contentview가 와야하나? -> 노
        scrollview.addSubview(contentview)
        box.addSubview(scrollview2)
        scrollview2.addSubview(detailview)
        box.addSubview(lineView)
        box.addSubview(descriptionView)
        contentview.addSubview(box)
                
        NSLayoutConstraint.activate([topview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
                                     topview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     topview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     topview.heightAnchor.constraint(equalToConstant: 212)
                                    ])
        NSLayoutConstraint.activate([scrollview.topAnchor.constraint(equalTo: topview.bottomAnchor, constant: 0),
                                     scrollview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     scrollview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     scrollview.bottomAnchor.constraint(equalTo: bottomview.topAnchor)
                                    ])
        NSLayoutConstraint.activate([bottomview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
                                     bottomview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     bottomview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     bottomview.heightAnchor.constraint(equalToConstant: 82)
                                    ])
        NSLayoutConstraint.activate([contentview.topAnchor.constraint(equalTo: scrollview.contentLayoutGuide.topAnchor),
                                     contentview.bottomAnchor.constraint(equalTo: scrollview.contentLayoutGuide.bottomAnchor),
                                     contentview.heightAnchor.constraint(equalTo: scrollview.contentLayoutGuide.heightAnchor),
                                     contentview.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
                                     contentview.leadingAnchor.constraint(equalTo: scrollview.contentLayoutGuide.leadingAnchor),
                                     contentview.trailingAnchor.constraint(equalTo: scrollview.contentLayoutGuide.trailingAnchor)
                                    ])
        NSLayoutConstraint.activate([descriptionView.topAnchor.constraint(equalTo: box.topAnchor, constant: 8),
                                     descriptionView.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: 13),
                                     descriptionView.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -13)
                                    ])
        NSLayoutConstraint.activate([lineView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 10),
                                     lineView.heightAnchor.constraint(equalToConstant: 0.3),
                                     lineView.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: 10),
                                     lineView.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -10)
                                    ])
        NSLayoutConstraint.activate([scrollview2.topAnchor.constraint(equalTo: lineView.bottomAnchor),
                                     scrollview2.trailingAnchor.constraint(equalTo: box.trailingAnchor),
                                     scrollview2.leadingAnchor.constraint(equalTo: box.leadingAnchor),
                                     scrollview2.bottomAnchor.constraint(equalTo: box.bottomAnchor)
                                    ])
        NSLayoutConstraint.activate([detailview.topAnchor.constraint(equalTo: scrollview2.contentLayoutGuide.topAnchor),
                                     detailview.trailingAnchor.constraint(equalTo: scrollview2.contentLayoutGuide.trailingAnchor),
                                     detailview.leadingAnchor.constraint(equalTo: scrollview2.contentLayoutGuide.leadingAnchor),
                                     detailview.bottomAnchor.constraint(equalTo: scrollview2.contentLayoutGuide.bottomAnchor)
                                    ])
        NSLayoutConstraint.activate([
                                    box.topAnchor.constraint(equalTo: contentview.topAnchor, constant: 50),
                                    box.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 17),
                                    box.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: -17),
                                    box.heightAnchor.constraint(equalToConstant: 212)
                                    ])
        bottomview.addSubview(listbar)
        listbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([listbar.centerYAnchor.constraint(equalTo: bottomview.centerYAnchor),
                                     listbar.trailingAnchor.constraint(equalTo: bottomview.trailingAnchor, constant: -30)
        ])
        listbar.addTarget(self, action: #selector(popDetailVC(_:)), for: .touchUpInside)
    }
    
    // 위치, 온도, 날씨, 최고최저기온으로 구성
    // 키워드 lazy -> lazy 키워드를 붙여서 프로퍼티를 선언하면 단어 뜻 그대로 다른 프로퍼티보다 지연된다. 즉, 해당 프로퍼티가 처음 사용되기 전까지는 메모리에 올라가지 않는다.
    lazy var topview: UIView = {
        let view = UIView()
        
        let location = UILabel()
        location.textColor = .white
        location.text = self.Location
        location.font = UIFont(name: "SFProDisplay-Regular", size: 45)
        
        let max = UILabel()
        max.textColor = .white
        max.text = self.Maxtemp
        max.font = UIFont(name: "SFProDisplay-Regular", size: 23)

        let min = UILabel()
        min.textColor = .white
        min.text = self.Mintemp
        min.font = UIFont(name: "SFProDisplay-Regular", size: 23)

        let weather = UILabel()
        weather.textColor = .white
        weather.text = self.Weather
        weather.font = UIFont(name: "SFProDisplay-Regular", size: 25)

        let temperature = UILabel()
        temperature.textColor = .white
        temperature.text = self.Temperature
        temperature.font = UIFont(name: "SFProDisplay-Light", size: 75)
        
        [location, temperature, weather, max, min].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([location.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                                     location.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([temperature.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 10),
                                     temperature.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([weather.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: 10),
                                     weather.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([max.topAnchor.constraint(equalTo: weather.bottomAnchor, constant: 10),
                                     max.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -3)
        ])
        NSLayoutConstraint.activate([min.topAnchor.constraint(equalTo: weather.bottomAnchor, constant: 10),
                                     min.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 3)
                                    ])
        return view
    }()
    
    // 구조 : 수직스크롤뷰 > 수평스크롤뷰 > 콘텐츠뷰 > 수평스크롤가능한 스택뷰 > UI뷰
    // AND 콘텐츠뷰 > 텍스트뷰 + 선 UI뷰 + 스택뷰
    var scrollview: UIScrollView = { // 수직 스크롤
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // 상세보기 박스에서 상단은 text뷰, 하단은 수평스크롤뷰 > 콘텐츠뷰 > 수평스택뷰 > 개별 UI뷰
    var contentview: UIView = {
        let view = UIView()
//        view.layer.cornerRadius = 10
//        view.layer.borderColor = UIColor.white.cgColor
//        view.layer.borderWidth = 1
        return view
    }()
    
    var box: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let descriptionView: UILabel = {
        let label = UILabel()
        label.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)

        return label
    }()

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return view
    }()
    
    var scrollview2: UIScrollView = { // 수평스크롤뷰
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    var detailview: UIStackView = { // 수평스택뷰
        let view = UIStackView()
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
    lazy var bottomview: UIView = {
        let view = UIView()
        let line = UIView()
        line.backgroundColor = .white
        // 설정 버튼
//        let button = UIButton()
//        button.setImage(UIImage(named: "listbar"), for: .normal)
//        // 설정 버튼 눌리면 상세페이지 pop
//        button.addTarget(button, action: #selector(popDetailVC()), for: .touchUpInside)
//        view.addGestureRecognizer(tap)
//        view.isUserInteractionEnabled = true
        // 지도 버튼
        let mapbutton = UIButton()
        mapbutton.setImage(UIImage(named: "map"), for: .normal)
        // 화살표 버튼
        let arrow = UIButton()
        arrow.setImage(UIImage(named: "arrow"), for: .normal)
        // 점 하나 버튼
        let dot = UIButton()
        dot.setImage(UIImage(named: "dot"), for: .normal)
        
        [mapbutton, arrow, dot, line].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([line.topAnchor.constraint(equalTo: view.topAnchor),
                                     line.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     line.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     line.heightAnchor.constraint(equalToConstant: 0.3)
        ])
//        NSLayoutConstraint.activate([button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                                     button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
//                                    ])
        NSLayoutConstraint.activate([mapbutton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     mapbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
                                    ])
        NSLayoutConstraint.activate([arrow.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     arrow.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10)
                                    ])
        NSLayoutConstraint.activate([dot.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     dot.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10)
                                    ])
        return view
    }()
    
    var listbar: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "listbar"), for: .normal)
        return button
    }()
    
    // 디폴트 배경화면 지정
    private func setBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "backgroundimg"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        self.view.insertSubview(backgroundImageView, at: 0)
    }
    
    // 홈 화면으로 화면 전환
//    @objc
//    func popDetailVC(_ gesture: UITapGestureRecognizer) {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @objc
    func popDetailVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
