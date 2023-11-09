import UIKit

extension UIStackView {
    
    // MARK: - Configure Method for Placeholders
    func configure(name: String, text: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImageView()
        image.image = UIImage(named: name)
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = text
        label.textColor = .Black
        self.spacing = 8
        self.axis = .vertical
        self.alignment = .center
        self.addArrangedSubview(image)
        self.addArrangedSubview(label)
    }
}

