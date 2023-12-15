//
//  sopt_fourth_seminar0
//
//  Created by Woo Jye Lee on 11/15/23.
//

import UIKit
import SnapKit
import Then

class SecondViewController: UIViewController {
    
    var Location: String
    var Temperature: String
    var Maxtemp: String
    var Mintemp: String
    var Weather: String
    
    var viewmodel = SecondVCViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SecondViewController"
        self.setCollectionViewConfig()
        self.setCollectionViewLayout()
        self.setTableViewConfig()
        self.setLayout()
        self.setBackgroundImage()
        self.tableView.backgroundColor = .clear
        Task {
            await fetchWeatherInfo()
        }
    }
    
    init(location: String, temperature: String, weather: String, maxtemp: String, mintemp: String) {
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
    
    private func fetchWeatherInfo() async {
        let city = self.Location
        imageCollectionList = [] // append를 쓰기 때문에 배열 초기화해줘야함
        
        for i in 0...11 {
            do {
                guard let currentWeather = try await GetTimeline.shared.GetTimelineData(cityname: city) else {return}
                let weatherInfo = ImageCollectionData(time: currentWeather.list[i].dtTxt, weather: currentWeather.list[i].weather[0].main.rawValue, temperature: currentWeather.list[i].main.temp)
                
                imageCollectionList.append(weatherInfo)
                // searchWeatherInfoListData = itemListData
            } catch {
                print(error)
            }
        }
        
        do {
            guard let currentWeather = try await GetTimeline.shared.GetTimelineData(cityname: city) else {return}
            guard let time = extractHour(from: currentWeather.list[0].dtTxt) else {return}
            self.descriptionView.text = "\(String(describing: time))에 \(self.Weather) 상태가 예상됩니다."
        } catch {
            print(error)
        }
        collectionview.reloadData()
    }
    
    func extractHour(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            return String(format: "%02d:00~%02d:00", hour, hour+3)
        }
        
        return nil
    }
    
    private func setLayout() {
        [bottomview, scrollview].forEach() {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        scrollview.addSubview(contentview2)
        contentview2.translatesAutoresizingMaskIntoConstraints = false
        scrollview.addSubview(topview)
        
        scrollview.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80)
        }
        // problem..**
        NSLayoutConstraint.activate([contentview2.topAnchor.constraint(equalTo: scrollview.contentLayoutGuide.topAnchor),
                                     contentview2.bottomAnchor.constraint(equalTo: scrollview.contentLayoutGuide.bottomAnchor),
                                     contentview2.heightAnchor.constraint(equalToConstant: 1070),
                                     contentview2.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
                                     contentview2.leadingAnchor.constraint(equalTo: scrollview.contentLayoutGuide.leadingAnchor),
                                     contentview2.trailingAnchor.constraint(equalTo: scrollview.contentLayoutGuide.trailingAnchor)
                                    ])

        [box, box2, topview].forEach() {
            contentview2.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [contentview, lineView, descriptionView].forEach() {
            box.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        contentview.addSubview(collectionview)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([topview.topAnchor.constraint(equalTo: contentview2.topAnchor, constant: 0),
                                     topview.leadingAnchor.constraint(equalTo: contentview2.leadingAnchor, constant: 0),
                                     topview.trailingAnchor.constraint(equalTo: contentview2.trailingAnchor, constant: 0),
                                     topview.heightAnchor.constraint(equalToConstant: 300)
                                    ])
        NSLayoutConstraint.activate([bottomview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
                                     bottomview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                                     bottomview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     bottomview.heightAnchor.constraint(equalToConstant: 82)
                                    ])
        NSLayoutConstraint.activate([
                                    box.topAnchor.constraint(equalTo: topview.bottomAnchor, constant: 20),
                                    box.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 17),
                                    box.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17),
                                    box.heightAnchor.constraint(equalToConstant: 212)
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
        NSLayoutConstraint.activate([contentview.topAnchor.constraint(equalTo: lineView.bottomAnchor),
                                     contentview.leadingAnchor.constraint(equalTo: box.leadingAnchor),
                                     contentview.trailingAnchor.constraint(equalTo: box.trailingAnchor),
                                     contentview.bottomAnchor.constraint(equalTo: box.bottomAnchor)
        ])
        NSLayoutConstraint.activate([collectionview.topAnchor.constraint(equalTo: contentview.topAnchor),
                                     collectionview.leadingAnchor.constraint(equalTo: contentview.leadingAnchor),
                                     collectionview.trailingAnchor.constraint(equalTo: contentview.trailingAnchor),
                                     collectionview.bottomAnchor.constraint(equalTo: contentview.bottomAnchor)
        ])
        
        bottomview.addSubview(listbar)
        listbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([listbar.centerYAnchor.constraint(equalTo: bottomview.centerYAnchor),
                                     listbar.trailingAnchor.constraint(equalTo: bottomview.trailingAnchor, constant: -30)
        ])
        listbar.addTarget(self, action: #selector(popDetailVC(_:)), for: .touchUpInside)
        
        let line2 = UIView()
        line2.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        let label2 = UILabel()
        label2.textColor = .lightGray
        label2.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        label2.text = "10일간의 일기예보"
        let icon = UIImageView()
        icon.image = UIImage(systemName: "calendar")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .lightGray
        
        [label2, icon, line2, tableView].forEach() {
            box2.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([box2.topAnchor.constraint(equalTo: box.bottomAnchor, constant: 20),
                                     box2.leadingAnchor.constraint(equalTo: box.leadingAnchor),
                                     box2.trailingAnchor.constraint(equalTo: box.trailingAnchor),
                                     box2.heightAnchor.constraint(equalToConstant: 650)
        ])
        NSLayoutConstraint.activate([icon.leadingAnchor.constraint(equalTo: box2.leadingAnchor, constant: 10),
                                     icon.centerYAnchor.constraint(equalTo: label2.centerYAnchor)
        ])
        NSLayoutConstraint.activate([label2.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
                                     label2.topAnchor.constraint(equalTo: box2.topAnchor, constant: 5)
        ])
        NSLayoutConstraint.activate([line2.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 5),
                                     line2.leadingAnchor.constraint(equalTo: box2.leadingAnchor, constant: 10),
                                     line2.trailingAnchor.constraint(equalTo: box2.trailingAnchor, constant: -10),
                                     line2.heightAnchor.constraint(equalToConstant: 0.3)
        ])
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: line2.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: box2.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: box2.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: box2.bottomAnchor),
                                     tableView.heightAnchor.constraint(equalToConstant: 590)
        ])
        
        // 하단바 앞으로 가져오기
        self.view.bringSubviewToFront(bottomview)
    }
    
    // collection view 설정
    private func setCollectionViewConfig() {
        self.collectionview.register(ImageCollectionViewCell.self,
                                        forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        self.collectionview.delegate = self
        self.collectionview.dataSource = viewmodel as! any UICollectionViewDataSource
    }
    private func setCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: (self.box.bounds.width) / 5 , height: self.contentview.bounds.height) // cell 크기 설정
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        self.collectionview.setCollectionViewLayout(flowLayout, animated: false)
        self.collectionview.isOpaque = false // 배경 불투명하게 처리
        self.collectionview.backgroundColor = UIColor.clear // 해당뷰 배경제거
    }
    
    // 수직스크롤뷰
    var scrollview: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // topview 설정
    lazy var topview: UIView = {
        let view = UIView()
        
        let location = UILabel()
        location.textColor = .white
        location.text = self.Location
        location.font = UIFont(name: "SFProDisplay-Regular", size: 36)
        
        let max = UILabel()
        max.textColor = .white
        max.text = self.Maxtemp
        max.font = UIFont(name: "SFProDisplay-Regular", size: 20)

        let min = UILabel()
        min.textColor = .white
        min.text = self.Mintemp
        min.font = UIFont(name: "SFProDisplay-Regular", size: 20)

        let weather = UILabel()
        weather.textColor = .white
        weather.text = self.Weather
        weather.font = UIFont(name: "SFProDisplay-Regular", size: 24)

        let temperature = UILabel()
        temperature.textColor = .white
        temperature.text = self.Temperature
        temperature.font = UIFont(name: "SFProDisplay-Light", size: 102)
        
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
    
    let contentview = UIView()
    let contentview2 = UIView()
    
    var box: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    lazy var descriptionView: UILabel = {
        let label = UILabel()
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
    
    // 하단바 설정
    lazy var bottomview: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "background_color")
        let line = UIView()
        line.backgroundColor = .white
        let mapbutton = UIButton()
        mapbutton.setImage(UIImage(named: "map"), for: .normal)
        let arrow = UIButton()
        arrow.setImage(UIImage(named: "arrow"), for: .normal)
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
    
    // backbutton
    var listbar: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "listbar"), for: .normal)
        return button
    }()
    
    private let collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let collectionview2 = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var box2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private func setBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "large_background"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        self.view.insertSubview(backgroundImageView, at: 0)
    }
    
    @objc
    func popDetailVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setTableViewConfig() {
        self.tableView.register(WeatherTableViewCell.self,
                                forCellReuseIdentifier: WeatherTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .singleLine
    }
    // problem..**
    private let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.separatorColor = .lightGray
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
    }

}
// 수평스크롤 컬렉션뷰
extension SecondViewController: UICollectionViewDelegate {}
extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.box.bounds.width)/5, height: self.contentview.bounds.height)
    }
}
// 일주일 날씨보여주는 테이블뷰
extension SecondViewController: UITableViewDelegate {}
extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier,
                                                       for: indexPath) as? WeatherTableViewCell else {return UITableViewCell()}
        cell.bindData(data: weatherListData[indexPath.row])
        return cell
    }
}

