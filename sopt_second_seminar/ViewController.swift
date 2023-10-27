//
//  ViewController.swift
//  sopt_second_seminar
//
//  Created by Woo Jye Lee on 10/14/23.
//
// 날씨앱 홈 화면

import UIKit

class ViewController: UIViewController, WeatherInfoViewDelegate {
    let newyork = weatherinfo(location: "Newyork", weather: "cloudy", temperature: "20°C", max: "25°C", min: "15°C")
    let seoul = weatherinfo(location: "Seoul", weather: "sunny", temperature: "20°C", max: "25°C", min: "15°C")
    let england = weatherinfo(location: "England", weather: "cloudy", temperature: "20°C", max: "25°C", min: "15°C")
    // viewcontroller -> secondviewcontroller로 weather, temperature 전달해야함.

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navigationItem.title = "ViewController" // 네비게이션 컨트롤러 입장에서 구분할 수 있게 이름 부여
        self.setLayout()
    }
    
    private func setLayout() {
        [topview, scrollview].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        // safearea 고려해서 topAnchor 조정
        NSLayoutConstraint.activate([topview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
                                     topview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     topview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     topview.heightAnchor.constraint(equalToConstant: 190)
                                    ])
        
        // topview 안에 날씨라벨 + 검색바 + 설정버튼
        [searchbar, textlabelview, buttonview].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            topview.addSubview($0)
        }

        // 검색바
        NSLayoutConstraint.activate([searchbar.leadingAnchor.constraint(equalTo: topview.leadingAnchor, constant: 0),
                                     searchbar.trailingAnchor.constraint(equalTo: topview.trailingAnchor, constant: 0),
                                     searchbar.bottomAnchor.constraint(equalTo: topview.bottomAnchor, constant: 0),
                                     searchbar.heightAnchor.constraint(equalToConstant: 40)
                                    ])
        // 설정 버튼
        NSLayoutConstraint.activate([buttonview.topAnchor.constraint(equalTo: topview.safeAreaLayoutGuide.topAnchor, constant: 0),
                                     buttonview.trailingAnchor.constraint(equalTo: topview.trailingAnchor, constant: -10)
                                    ])
        // 날짜 라벨
        NSLayoutConstraint.activate([textlabelview.leadingAnchor.constraint(equalTo: topview.leadingAnchor, constant: 20),
                                     textlabelview.bottomAnchor.constraint(equalTo: searchbar.topAnchor, constant: -10)
                                    ])

        NSLayoutConstraint.activate([scrollview.topAnchor.constraint(equalTo: topview.bottomAnchor, constant: 20),
                                     scrollview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
                                     scrollview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
                                     scrollview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                                    ])
        
        scrollview.addSubview(contentview)
        contentview.translatesAutoresizingMaskIntoConstraints = false
        // contentview 높이를 scrollview 높이에 맞춰줌 (중요)
        NSLayoutConstraint.activate([contentview.leadingAnchor.constraint(equalTo: scrollview.contentLayoutGuide.leadingAnchor),
                                     contentview.trailingAnchor.constraint(equalTo: scrollview.contentLayoutGuide.trailingAnchor),
                                     contentview.topAnchor.constraint(equalTo: scrollview.contentLayoutGuide.topAnchor),
                                     contentview.bottomAnchor.constraint(equalTo: scrollview.contentLayoutGuide.bottomAnchor)
                                    ])
         contentview.widthAnchor.constraint(equalTo: scrollview.widthAnchor).isActive = true
//         let contentViewHeight = contentview.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
//         contentViewHeight.priority = .defaultLow
//         contentViewHeight.isActive = true
        
        contentview.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        // self를 사용할 때와 사용하지 않을때?, contentLayoutGuide란?
        NSLayoutConstraint.activate([stackview.topAnchor.constraint(equalTo: contentview.topAnchor, constant: 0),
                                     stackview.trailingAnchor.constraint(equalTo: contentview.trailingAnchor, constant: 0),
                                     stackview.leadingAnchor.constraint(equalTo: contentview.leadingAnchor, constant: 0),
                                     stackview.bottomAnchor.constraint(equalTo: contentview.bottomAnchor)
                                    ])
        
        // 세계별 날씨를 스택뷰에 차레대로 삽입
        [newyork, seoul, england].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            ($0.heightAnchor.constraint(equalToConstant: 120)).isActive = true
            $0.delegate = self
            stackview.addArrangedSubview($0)
        }
        
        // 방콕, 뉴욕, 한국 날씨를 차례대로 스택뷰에 넣어줌. -> 에러 발생
//        [newyork].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([$0.trailingAnchor.constraint(equalToConstant: 20),
//                                         $0.leadingAnchor.constraint(equalToConstant: 20),
//                                         $0.heightAnchor.constraint(equalToConstant: 117)
//                                        ])
//            $0.delegate = self
//            stackview.addArrangedSubview($0)
//        }
    }
    
    // 구조 : rootview > scrollview > contentview > stackview > elementview
    // contentview만 uiview인 이유?
    var contentview: UIView = {
        let view = UIView()
        return view
    }()
    
    var scrollview: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // 홈화면 상단바 생성자에 검색바 + 텍스트 '날씨' + 설정버튼 다 넣는법 OR setlayout()에서 세 요소 다 합치는 방법
    var topview: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    var buttonview: UIImageView = {
        let button = UIImageView()
        button.image = UIImage(named: "dots")
        button.contentMode = .scaleAspectFit
        
        return button
    }()
    
    var textlabelview: UILabel = {
        let textlabel = UILabel()
        textlabel.text = "날씨"
        textlabel.textColor = .white
        textlabel.font = UIFont(name: "SFProDisplay-Bold", size: 36)
        
        return textlabel
    }()
    
    var stackview: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 20
        return view
    }()
    
    // 날씨 '나의 위치' 박스 ImageView -> 'weatherinfo.swift' 파일로 이동할 예정임.
//    var elementview: UIImageView = { // 이 클로저가 정확히 수행하는 일 : uiview를 상속받는 객체를 호출될 때마다 생성?
//        let view = UIImageView(frame: .init(origin: .zero, size: .init())) // 생성자 전달 인자 없이
//        view.image = UIImage(named: "elementviewimg")
//        view.contentMode = .scaleAspectFit
//        view.backgroundColor = .black
//        view.layer.cornerRadius = 3
//        
//        // element 뷰를 클릭하면 상세보기 화면으로 변환된다.
////        let tap = UITapGestureRecognizer(target: view, action: #selector(pushToDetailVC(_:))) // UIImageView 클릭 제스쳐
////        view.addGestureRecognizer(tap)
////        view.isUserInteractionEnabled = true
//        
//        // element 뷰 속에 텍스트들 추가
//        let text = UILabel(frame: .init(origin: .zero, size: .init()))
//        text.text = "나의 위치"
//        text.textColor = .white
//        NSLayoutConstraint.activate([text.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
//                                     // text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
//                                     text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//                                     text.heightAnchor.constraint(equalToConstant: 10)
//                                    ])
//        
//        return view
//    }()
    
    // 검색창을 topview 클로저 안에 선언하는 방법은 없을까?
    var searchbar: UISearchBar = { // 이 클로저의 정체는 property initializer
        let view = UISearchBar()
        view.barTintColor = UIColor.black

        view.placeholder = "도시 또는 공항 검색"
        view.layer.cornerRadius = 3
        view.setImage(UIImage(named: "icSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
        view.setImage(UIImage(named: "icCancel"), for: .clear, state: .normal)
        
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

//    func setupSearchController() {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar = self.searchbar
//        
//        // searchController.searchResultsUpdater = self ✅
//        
//        self.navigationItem.searchController = searchController
//        self.navigationItem.title = "Search"
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//    }
    
//    let data = ["Newyork", "Seoul"]
//    var searchResults: [String] = []
//    func searchbarupdate(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchResults = data.filter { $0.lowercased().contains(searchText.lowercased()) }
//        tableView.reloadData()
//    }
//    
//    // UITableView 데이터 소스 메서드
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchResults.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = searchResults[indexPath.row]
//        return cell
//    }
    
    // 화면 전환
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
