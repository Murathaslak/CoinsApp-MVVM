import UIKit

class IconLabelView: UIView {
    
    let iconImageView = IconImageView(frame: .zero, imageName: "wallet")
    let textLabel = CCBodyLabel(textAlignment: .left, fontSize: 10)
    let coinCountLabel = CCBodyLabel(textAlignment: .left, fontSize: 10)
    let totalBalanceLabel = CCBodyLabel(textAlignment: .right, fontSize: 10)
    
    var balance: Double = 10000 {
        didSet {
            totalBalanceLabel.text = Utils.formatCurrency(price: "\(balance)")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    var setCount: Double = 0 {
        didSet {
            coinCountLabel.text = "\(String(format: "%.5f",setCount))"
        }
    }
    
    private func configureView() {
        textLabel.text = "Bakiye: "
        totalBalanceLabel.text = Utils.formatCurrency(price: "\(balance)")
        coinCountLabel.text = "\(setCount)"
        //yukarı bak bişey var
        
        addSubview(iconImageView)
        addSubview(textLabel)
        addSubview(coinCountLabel)
        addSubview(totalBalanceLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            textLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            textLabel.widthAnchor.constraint(equalToConstant: 60),

            coinCountLabel.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 8),
            
            totalBalanceLabel.leadingAnchor.constraint(equalTo: coinCountLabel.trailingAnchor, constant: 8),
            totalBalanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}



