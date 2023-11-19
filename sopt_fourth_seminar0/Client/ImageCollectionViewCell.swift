import UIKit
import SnapKit
import Then

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ImageCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [image, temp, time].forEach() {
            // collection view 안에는 기본적으로 콘텐츠 뷰가 들어있나?
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // problem...**
        NSLayoutConstraint.activate([image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            time.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            time.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            temp.topAnchor.constraint(equalTo: centerYAnchor, constant: 40),
            temp.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
    }
    
    func bindData(data: ImageCollectionData) {
        self.image.image = UIImage(named: data.weather)
        self.temp.text = "\(data.temperature)°C"
        self.time.text = "\(data.time)"
    }
    let image: UIImageView = {
        let weatherimg = UIImageView()
        weatherimg.contentMode = .scaleAspectFit
        return weatherimg
    }()
    let temp: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont(name: "SFProDisplay-Medium", size: 19)
        return view
    }()
    let time: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont(name: "SFProDisplay-Medium", size: 19)
        return view
    }()
}
