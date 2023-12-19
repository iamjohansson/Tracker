import UIKit

final class StatisticViewController: UIViewController {
    
    // MARK: - Elements
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "statisticVC_title".localized
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .yaBlack
        return titleLabel
    }()
    
    private let statisticStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let statisticPlaceholder = UIStackView()
    
    // MARK: - Properties
    private let trackersCompleted = StatisticViewSetting(name: "statisticVC_trackersCompleted".localized)
    private let trackerStore = TrackerStore()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yaWhite
        addSubView()
        applyConstraint()
        statisticPlaceholder.configure(name: "cryPlaceholder", text: "statisticVC_placeholderText".localized)
        placeholderAndStackViewHiddenCheck()
    }
    
    // MARK: - Methods
    
    private func placeholderAndStackViewHiddenCheck() {
        let isHidden = trackerStore.trackersCount == 0
        statisticPlaceholder.isHidden = !isHidden
        statisticStackView.isHidden = isHidden
    }
    
    // MARK: - Layout & Setting
    private func addSubView() {
        view.addSubview(titleLabel)
        view.addSubview(statisticPlaceholder)
        view.addSubview(statisticStackView)
        statisticStackView.addArrangedSubview(trackersCompleted)
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            statisticPlaceholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statisticPlaceholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statisticStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            statisticStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statisticStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 77)
        ])
    }
}
