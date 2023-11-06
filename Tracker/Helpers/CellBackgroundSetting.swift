import UIKit

final class CellBackgroundSetting: UIView {
    
    private let cellView: UIView = {
        let cellView = UIView()
        cellView.backgroundColor = .Background
        return cellView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        layer.masksToBounds = true
        backgroundColor = .Background
        
        addSubview(cellView)
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func configure(position: Position) {
        layer.cornerRadius = 16
        
        switch position {
        case .top:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .middle:
            layer.cornerRadius = 0
        case .bottom:
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .common:
            break
        }
    }
}

extension CellBackgroundSetting {
    enum Position {
        case top, middle, bottom, common
    }
}
