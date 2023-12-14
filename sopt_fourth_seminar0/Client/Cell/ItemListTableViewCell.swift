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
        self.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(data: ItemListData) {
        self.locationLabel.text = data.location
        self.maxtemp.text = "최고: \(data.maxtemp)°C"
        self.mintemp.text = "최저: \(data.mintemp)°C"
        self.tempLabel.text = "\(data.temperature)°C"
        self.weatherLabel.text = data.weather
    }
    
    // tableviewcell 내에 UItableviewcell contentview가 있음
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    private func setLayout() {
        self.backgroundColor = .black
        [backgroundimage, locationLabel, weatherLabel, tempLabel, maxtemp, mintemp].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        backgroundimage.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }

        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: backgroundimage.topAnchor, constant: 7),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            weatherLabel.bottomAnchor.constraint(equalTo: backgroundimage.bottomAnchor, constant: -7),
            weatherLabel.leadingAnchor.constraint(equalTo: locationLabel
                .leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: locationLabel.topAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
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
        $0.font = UIFont(name: "SFProDisplay-Medium", size: 24)
        $0.textColor = .white
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

}

