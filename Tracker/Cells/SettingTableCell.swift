import UIKit

final class SettingTableCell: UITableViewCell {
    
    private lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .LightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Black
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Gray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrowRight"), for: .normal)
        return button
    }()
    
    private let labelStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 2
        stack.axis = .vertical
        return stack
    }()
    
    static let identifier = "TableCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubViews()
        applyConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, description: String?) {
        nameLabel.text = name
        
        if let description {
            descriptionLabel.text = description
        }
    }

}

private extension SettingTableCell {
    
    func addSubViews() {
        contentView.addSubview(cellView)
        contentView.addSubview(labelStack)
        labelStack.addArrangedSubview(nameLabel)
        labelStack.addArrangedSubview(descriptionLabel)
        contentView.addSubview(button)
    }
    
    func applyConstraint() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelStack.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            labelStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            labelStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -56),
            button.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16)
        ])
    }
}
