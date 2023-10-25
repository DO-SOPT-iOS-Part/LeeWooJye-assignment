//
//  ViewController.swift
//  sopt_second_seminar
//
//  Created by Woo Jye Lee on 10/14/23.
//
// 날씨앱 홈 화면

import UIKit

class ViewController: UIViewController, WeatherInfoViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "ViewController" // 네비게이션 컨트롤러 입장에서 구분할 수 있게 이름 부여
        self.setLayout()
    }
    
    private func setLayout() {
        [topview, scrollview].forEach{ [weak self] view in
            guard let self else {return}
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        scrollview.addSubview(contentview)
        contentview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([topview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
                                     topview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     topview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     topview.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 150)
                                    ])
        
        topview.addSubview(searchbar)
        searchbar.translatesAutoresizingMaskIntoConstraints = false

        // 검색바
        NSLayoutConstraint.activate([searchbar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
                                     searchbar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     searchbar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     searchbar.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 150)
                                    ])
        // 설정 버튼
        NSLayoutConstraint.activate([topview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
                                     topview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     topview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     topview.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 150)
                                    ])
        // 날짜 텍스트 필드
        NSLayoutConstraint.activate([topview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
                                     topview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     topview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     topview.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 150)
                                    ])

        NSLayoutConstraint.activate([scrollview.topAnchor.constraint(equalTo: self.topview.bottomAnchor, constant: 0),
                                     scrollview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     scrollview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     scrollview.heightAnchor.constraint(equalTo: self.contentview.widthAnchor)
                                    ])
        
        // contentview 높이를 scrollview 높이에 맞춰줌
        NSLayoutConstraint.activate([contentview.leadingAnchor.constraint(equalTo: scrollview.contentLayoutGuide.leadingAnchor),
                                     contentview.trailingAnchor.constraint(equalTo: scrollview.contentLayoutGuide.trailingAnchor),
                                     contentview.topAnchor.constraint(equalTo: scrollview.contentLayoutGuide.topAnchor),
                                     contentview.bottomAnchor.constraint(equalTo: scrollview.contentLayoutGuide.bottomAnchor)
                                    ])
        
        contentview.widthAnchor.constraint(equalTo: scrollview.widthAnchor).isActive = true
        let contentViewHeight = contentview.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        contentview.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        // self를 사용할 때와 사용하지 않을때?, contentLayoutGuide란?
        NSLayoutConstraint.activate([stackview.topAnchor.constraint(equalTo: self.contentview.bottomAnchor, constant: 0),
                                     stackview.trailingAnchor.constraint(equalTo: self.contentview.trailingAnchor, constant: 0),
                                     stackview.leadingAnchor.constraint(equalTo: self.contentview.leadingAnchor, constant: 0),
                                     stackview.heightAnchor.constraint(equalTo: self.contentview.heightAnchor)
                                    ])
        
        stackview.addArrangedSubview(elementview) // 엘리먼트 뷰를 스택뷰 안에 넣어준다. 스택 뷰 안에 요소를 삽입할 땐 addArrangedSubview()를 이용한다.
        
        NSLayoutConstraint.activate([elementview.topAnchor.constraint(equalTo: self.stackview.bottomAnchor, constant: 10),
                                     elementview.trailingAnchor.constraint(equalTo: self.stackview.trailingAnchor, constant: 10),
                                     elementview.leadingAnchor.constraint(equalTo: self.stackview.leadingAnchor, constant: 10),
                                     elementview.heightAnchor.constraint(equalToConstant: 40)
                                    ])
        
        // 방콕, 뉴욕, 한국 날씨를 차례대로 스택뷰에 넣어줌.
        [elementview].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([$0.trailingAnchor.constraint(equalToConstant: 20),
                                         $0.leadingAnchor.constraint(equalToConstant: 20),
                                         $0.heightAnchor.constraint(equalToConstant: 117)
                                        ])
            stackview.addArrangedSubview($0)
        }
        
    }
    
    // 구조 : rootview > scrollview > contentview > stackview > elementview
    var contentview: UIView { // contentview만 uiview인 이유?
        let view = UIView(frame: .init(origin: .zero, size: .init()))
        view.backgroundColor = .black
        // view.layer.cornerRadius = 0
        // view.clipsToBounds = true
        return view
    }
    
    var scrollview: UIScrollView = {
        let view = UIScrollView(frame: .init(origin: .zero, size: .init()))
        view.backgroundColor = .black
        return view
    }()
    
    var topview: UIView = { // 홈화면 상단바 생성자에 검색바 + 텍스트 '날씨' + 설정버튼 다 넣는법 OR setlayout()에서 세 요소 다 합치는 방법
        let view = UIView(frame: .init(origin: .zero, size: .init()))
        view.backgroundColor = .black
        return view
    }()
    
    var stackview: UIStackView = {
        let view = UIStackView(frame: .init(origin: .zero, size: .init()))
        view.backgroundColor = .black
        return view
    }()
    
    // 날씨 '나의 위치' 박스 ImageView -> 'weatherinfo.swift' 파일로 이동할 예정임.
    var elementview: UIImageView = { // 이 클로저가 정확히 수행하는 일 : uiview를 상속받는 객체를 호출될 때마다 생성?
        let view = UIImageView(frame: .init(origin: .zero, size: .init())) // 생성자 전달 인자 없이
        view.image = UIImage(named: "elementviewimg")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .black
        view.layer.cornerRadius = 3
        
        // element 뷰를 클릭하면 상세보기 화면으로 변환된다.
//        let tap = UITapGestureRecognizer(target: view, action: #selector(pushToDetailVC(_:))) // UIImageView 클릭 제스쳐
//        view.addGestureRecognizer(tap)
//        view.isUserInteractionEnabled = true
        
        // element 뷰 속에 텍스트들 추가
        let text = UILabel(frame: .init(origin: .zero, size: .init()))
        text.text = "나의 위치"
        text.textColor = .white
        NSLayoutConstraint.activate([text.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
                                     // text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
                                     text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     text.heightAnchor.constraint(equalToConstant: 10)
                                    ])
        
        return view
    }()
    
    // 검색창을 topview 클로저 안에 선언하는 방법은 없을까?
    var searchbar: UISearchBar = { // 이 클로저의 정체는 property initializer
        let view = UISearchBar()
        view.placeholder = "도시 또는 공항 검색"
        view.layer.cornerRadius = 3
        view.setImage(UIImage(named: "icSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
        view.setImage(UIImage(named: "icCancel"), for: .clear, state: .normal)
        // self.navigationController?.navigationBar.topItem?.titleView = view
        
        if let textfield = view.value(forKey: "searchField") as? UITextField {
            //서치바 백그라운드 컬러
            textfield.backgroundColor = UIColor.gray
            //플레이스홀더 글씨 색 정하기
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            //서치바 텍스트입력시 색 정하기
            textfield.textColor = UIColor.white
            
            //왼쪽 아이콘 이미지넣기
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트컬러 정하기
                leftView.tintColor = UIColor.white
            }
            //오른쪽 x버튼 이미지넣기
            if let rightView = textfield.rightView as? UIImageView {
                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트 정하기
                rightView.tintColor = UIColor.white
            }
        }
        return view
    }()
    
    // 네비게이션컨트롤러로 푸시
//    @objc
//    func pushToDetailVC(_ gesture: UITapGestureRecognizer) {
//        let resultVC = SecondViewController()
//        self.navigationController?.pushViewController(resultVC, animated: true)
//    }
    
    func weatherInfoViewTapped(_ weatherinfo: weatherinfo) {
        guard let location = weatherinfo.locationlabel.text,
              let weather = weatherinfo.weatherlabel.text,
              let temperature = weatherinfo.temperaturelabel.text,
              let maxtemp = weatherinfo.maxtemp.text,
              let mintemp = weatherinfo.mintemp.text else {
            return
        }
        
        let weatherDetailedInfoVC = SecondViewController(location: location, temperature: temperature, weather: weather, maxtemp: maxtemp, mintemp: mintemp)
        
        self.navigationController?.pushViewController(weatherDetailedInfoVC, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
}
