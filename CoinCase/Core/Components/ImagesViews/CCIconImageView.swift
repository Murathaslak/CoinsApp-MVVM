import UIKit

class IconImageView: UIImageView {
    
    init(frame: CGRect, imageName: String) {
        super.init(frame: frame)
        if let image = UIImage(named: imageName) {
            self.image = image
        }
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero, imageName: "")
    }
    
    private func configure() {
        layer.cornerRadius = 0
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
    }
}



