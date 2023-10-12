import UIKit

class CCTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    init(isEditing: Bool, placeHolderText: String) {
        super.init(frame: .zero)
        configure(isEditing: isEditing, placeHolderText: placeHolderText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configure(isEditing: Bool, placeHolderText: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 15
        
        backgroundColor = .systemGray5
        
        placeholder = placeHolderText
        
        isUserInteractionEnabled = isEditing
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


