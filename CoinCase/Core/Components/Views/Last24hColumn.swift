import UIKit

class CustomColumLabels: UIView {
    
    let titleLabelHight = CCTitleLabel(textAlignment: .right, fontSize: 14)
    let titleLabelLow = CCTitleLabel(textAlignment: .right, fontSize: 14)
    
    let subtitleLabelHigh = CCBodyLabel(textAlignment: .right, fontSize: 10)
    let subtitleLabelLow =  CCBodyLabel(textAlignment: .right, fontSize: 10)

    init() {
        super.init(frame: .zero)
        
        titleLabelHight.text = "24s Yüksek"
        titleLabelLow.text = "24s Düşük"
        
        subtitleLabelHigh.text = "00.000000"
        subtitleLabelLow.text = "00.000000"
        
        addSubview(titleLabelHight)
        addSubview(titleLabelLow)

        addSubview(subtitleLabelHigh)
        addSubview(subtitleLabelLow)
        
        NSLayoutConstraint.activate([
            
            titleLabelLow.topAnchor.constraint(equalTo: topAnchor),
            titleLabelLow.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabelLow.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabelHight.topAnchor.constraint(equalTo: topAnchor),
            titleLabelHight.trailingAnchor.constraint(equalTo: titleLabelLow.leadingAnchor, constant: -20),
            titleLabelHight.widthAnchor.constraint(equalToConstant: 80),
            
            subtitleLabelLow.topAnchor.constraint(equalTo: titleLabelLow.bottomAnchor, constant: 4),
            subtitleLabelLow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            subtitleLabelLow.widthAnchor.constraint(equalToConstant: 95),

            subtitleLabelHigh.topAnchor.constraint(equalTo: titleLabelHight.bottomAnchor, constant: 4),
            subtitleLabelHigh.trailingAnchor.constraint(equalTo: subtitleLabelLow.leadingAnchor,constant: -20),
            subtitleLabelHigh.widthAnchor.constraint(equalToConstant: 95),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(coin: CoinsResult) {
        subtitleLabelLow.text = coin.lowPrice
        subtitleLabelHigh.text = coin.highPrice
    }
}
