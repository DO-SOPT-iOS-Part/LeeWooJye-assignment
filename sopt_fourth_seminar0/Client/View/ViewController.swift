import UIKit
import SnapKit
import Then

class ViewController: UIViewController, WeatherInfoViewDelegate {
    
    var searchWeatherInfoListData = itemListData

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ViewController"
        self.setLayout()
        self.setTableViewConfig()
        Task {
            await fetchWeatherInfo()
        }
    }
    
    private func setTableViewConfig() {
        self.tableView.register(ItemListTableViewCell.self,
                                forCellReuseIdentifier: ItemListTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 135 // 세로길이 늘리니까 셀 간격 생김.. 이게 왜?
        self.tableView.separatorStyle = .none
    }
    
    private func fetchWeatherInfo() async {
        let cities = ["seoul", "daegu", "mokpo", "chuncheon", "jeju"]
        
        for city in cities {
            do {
                guard let currentWeather = try await GetInfoService.shared.PostRegisterData(cityname: city) else {return}
                let weatherInfo = ItemListData(cityName: city, location: currentWeather.name, time: currentWeather.timezone, weather: currentWeather.weather[0].main, temperature: currentWeather.main.temp, maxtemp: currentWeather.main.tempMax, mintemp: currentWeather.main.tempMin)
                
                itemListData.append(weatherInfo)
                searchWeatherInfoListData = itemListData
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
    }
    
    private func setLayout() {
        [topview, tableView].forEach() {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([topview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                                     topview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     topview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     topview.heightAnchor.constraint(equalToConstant: 190)
        ])
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: topview.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
                                     tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
                                     tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    // tableView 이니셜라이저 인자에 값이 있어도 setLayout()에서 다시 설정해주니 괜찮은건가?..**
    private let tableView = UITableView(frame: .init(), style: .grouped).then {
        $0.backgroundColor = .black
        $0.separatorColor = .black
        $0.separatorStyle = .none
    }
    
    lazy var topview: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        let label = UILabel()
        label.text = "날씨"
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Bold", size: 36)
        let button = UIButton()
        button.setImage(UIImage(named: "dots"), for: .normal)
        
        // 검색창
        let view1 = UISearchBar()
        view1.barTintColor = UIColor.black

        view1.placeholder = "도시 또는 공항 검색"
        view1.layer.cornerRadius = 3
        view1.setImage(UIImage(named: "icSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
        view1.setImage(UIImage(named: "icCancel"), for: .clear, state: .normal)
        
        if let textfield = view1.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.gray
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            textfield.textColor = UIColor.white
            
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.white
            }
            if let rightView = textfield.rightView as? UIImageView {
                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
                rightView.tintColor = UIColor.white
            }
        }
        
        [label, button, view1].forEach() {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([view1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                                     view1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     view1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     view1.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     label.bottomAnchor.constraint(equalTo: view1.topAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        return view
    }()
    
    func weatherInfoViewTapped(_ weatherinfo: ItemListTableViewCell) {
        guard let location = weatherinfo.locationLabel.text,
              let weather = weatherinfo.weatherLabel.text,
              let temperature = weatherinfo.tempLabel.text,
              let maxtemp = weatherinfo.maxtemp.text,
              let mintemp = weatherinfo.mintemp.text else {
            return
        }
        
        let weatherDetailedInfoVC = SecondViewController(location: location, temperature: temperature, weather: weather, maxtemp: maxtemp, mintemp: mintemp)
        
        self.navigationController?.pushViewController(weatherDetailedInfoVC, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }

}

// 첫 함수가 cell의 개수를 반환하고 그 cell 개수를 바탕으로 두 번째 함수를 반복..?
extension ViewController: UITableViewDelegate {}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier,
                                                       for: indexPath) as? ItemListTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        cell.bindData(data: itemListData[indexPath.row])
        
        return cell
    }
}

