import UIKit

final class CellBackgroundSetting: UIView {
    
    private let cellViewBoard: UIView = {
        let cellViewBoard = UIView()
        cellViewBoard.translatesAutoresizingMaskIntoConstraints = false
        cellViewBoard.backgroundColor = .Gray
        cellViewBoard.isHidden = true
        return cellViewBoard
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
        
        addSubview(cellViewBoard)
        
        NSLayoutConstraint.activate([
            cellViewBoard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellViewBoard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cellViewBoard.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellViewBoard.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func configure(position: Position) {
        layer.cornerRadius = 16
        
        switch position {
        case .top:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cellViewBoard.isHidden = false
        case .middle:
            layer.cornerRadius = 0
            cellViewBoard.isHidden = false
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
