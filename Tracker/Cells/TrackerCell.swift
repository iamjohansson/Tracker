import UIKit

final class TrackerCell: UICollectionViewCell {
    
    private let cardView: UIView = {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = cardView.frame.size.height / 2
        return cardView
    }()
    
    private let emojiView: UIView = {
        let emojiView = UIView()
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.layer.cornerRadius = emojiView.frame.size.height / 2
        emojiView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        return emojiView
    }()
    
    private let emojiLabel: UILabel = {
        let emojiLabel = UILabel()
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        return emojiLabel
    }()
    
    private let trackerLabel: UILabel = {
        let trackerLabel = UILabel()
        trackerLabel.translatesAutoresizingMaskIntoConstraints = false
        trackerLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        trackerLabel.textColor = UIColor.white
        trackerLabel.numberOfLines = 0
        return trackerLabel
    }()
    
    private let daysLabel: UILabel = {
        let daysLabel = UILabel()
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        daysLabel.textColor = .Black
        return daysLabel
    }()
    
    private lazy var execButton: UIButton = {
        let execButton = UIButton()
        execButton.translatesAutoresizingMaskIntoConstraints = false
        execButton.setImage(UIImage(systemName: "plus"), for: .normal)
        execButton.tintColor = .White
        execButton.layer.cornerRadius = execButton.frame.size.height / 2
        execButton.addTarget(self, action: #selector(didTapExecButton), for: .touchUpInside)
        return execButton
    }()
    
    static let identifier = "TrackerCell"
    private var tracker: Tracker?
    private var daysCount = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TrackerCell {
    
    @objc func didTapExecButton() {
    }
    
    func addSubViews() {
        contentView.addSubview(cardView)
        contentView.addSubview(emojiView)
        contentView.addSubview(emojiLabel)
        contentView.addSubview(trackerLabel)
        contentView.addSubview(daysLabel)
        contentView.addSubview(execButton)
    }
    
    func applyConstraint() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 90),
            emojiView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            emojiView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            emojiView.widthAnchor.constraint(equalToConstant: 24),
            emojiView.heightAnchor.constraint(equalToConstant: 24),
            emojiLabel.centerXAnchor.constraint(equalTo: emojiView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: emojiView.centerYAnchor),
            trackerLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
            trackerLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            trackerLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 12),
            daysLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16),
            daysLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            execButton.centerYAnchor.constraint(equalTo: daysLabel.centerYAnchor),
            execButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            execButton.widthAnchor.constraint(equalToConstant: 34),
            execButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}
