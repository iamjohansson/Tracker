import UIKit

final class TextFieldSetting: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 41)
    
    init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func setupTextField(placeholder: String) {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 17, weight: .regular)
        backgroundColor = .LightGray
        layer.cornerRadius = 16
        autocorrectionType = .yes
        self.placeholder = placeholder
    }
}
