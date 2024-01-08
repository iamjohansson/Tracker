import UIKit

protocol CreatingTrackerViewControllerDelegate: AnyObject {
    func didCreateTracker(with: CreatingTrackerViewController.TrackerVersion)
}

final class CreatingTrackerViewController: UIViewController {
    
    // MARK: - Elements
    private lazy var habitButton: UIButton = {
        let habitButton = UIButton()
        habitButton.translatesAutoresizingMaskIntoConstraints = false
        habitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        habitButton.setTitle("creatingVC_habitButton".localized, for: .normal)
        habitButton.setTitleColor(.yaWhite, for: .normal)
        habitButton.backgroundColor = .yaBlack
        habitButton.layer.cornerRadius = 16
        habitButton.addTarget(self, action: #selector(didTapHabitButton), for: .touchUpInside)
        return habitButton
    }()
    
    private lazy var irregularEventButton: UIButton = {
        let eventButton = UIButton()
        eventButton.translatesAutoresizingMaskIntoConstraints = false
        eventButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        eventButton.setTitle("creatingVC_irregularButton".localized, for: .normal)
        eventButton.setTitleColor(.yaWhite, for: .normal)
        eventButton.backgroundColor = .yaBlack
        eventButton.layer.cornerRadius = 16
        eventButton.addTarget(self, action: #selector(didTapEventButton), for: .touchUpInside)
        return eventButton
    }()
    
    private let buttonStack: UIStackView = {
        let buttonStack = UIStackView()
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.spacing = 16
        buttonStack.axis = .vertical
        return buttonStack
    }()
    
    // MARK: - Properties
    weak var delegate: CreatingTrackerViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "creatingVC_title".localized
        view.backgroundColor = .yaWhite
        
        addSubViews()
        applyConstraint()
    }
    
    // MARK: - Layout & Setting
    private func addSubViews() {
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(habitButton)
        buttonStack.addArrangedSubview(irregularEventButton)
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            habitButton.heightAnchor.constraint(equalToConstant: 60),
            irregularEventButton.heightAnchor.constraint(equalToConstant: 60),
            buttonStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Tracker type
    enum TrackerVersion {
        case habit, event
    }
}

// MARK: - Extension - Actions
private extension CreatingTrackerViewController {
    @objc func didTapHabitButton() {
        title = "creatingVC_HabitTitle".localized
        delegate?.didCreateTracker(with: .habit)
    }
    
    @objc func didTapEventButton() {
        title = "creatingVC_IrregularTitle".localized
        delegate?.didCreateTracker(with: .event)
    }
}
