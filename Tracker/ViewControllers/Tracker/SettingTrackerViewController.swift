import UIKit

protocol SettingTrackerViewControllerDelegate: AnyObject {
    
}

final class SettingTrackerViewController: UIViewController {
    
    private lazy var nameTracker: UITextField = {
        let nameTracker = UITextField()
        nameTracker.translatesAutoresizingMaskIntoConstraints = false
        nameTracker.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        nameTracker.placeholder = "Введите название трекера"
        nameTracker.addTarget(self, action: #selector(didChangeTextOnNameTracker), for: .editingChanged)
        return nameTracker
    }()
    
    private lazy var limitMessage: UILabel = {
        let limit = UILabel()
        limit.translatesAutoresizingMaskIntoConstraints = false
        limit.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        limit.textColor = .Red
        limit.text = "Ограничение 38 символов"
        return limit
    }()
    
    private lazy var optionsTableView: UITableView = {
        let optionsTable = UITableView()
        optionsTable.translatesAutoresizingMaskIntoConstraints = false
        optionsTable.separatorStyle = .none
        return optionsTable
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(.Red, for: .normal)
        button.backgroundColor = .White
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Red.cgColor
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .Gray
        button.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private let buttonStack: UIStackView = {
       let buttonStack = UIStackView()
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.spacing = 8
        buttonStack.axis = .horizontal
        return buttonStack
    }()
    
    weak var delegate: SettingTrackerViewControllerDelegate?
    private let version: CreatingTrackerViewController.TrackerVersion
    
    init(version: CreatingTrackerViewController.TrackerVersion) {
        self.version = version
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .White
        optionsTableView.dataSource = self
        applyConstraint()
        setTitle()
        applyConstraint()
    }
    
    private func addSubViews() {
        view.addSubview(nameTracker)
        view.addSubview(limitMessage)
        view.addSubview(optionsTableView)
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(cancelButton)
        buttonStack.addArrangedSubview(createButton)
    }
    
    private func applyConstraint() {
        
        NSLayoutConstraint.activate([
            nameTracker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            nameTracker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameTracker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameTracker.heightAnchor.constraint(equalToConstant: 75),
            limitMessage.centerXAnchor.constraint(equalTo: nameTracker.centerXAnchor),
            limitMessage.topAnchor.constraint(equalTo: nameTracker.bottomAnchor, constant: 8),
            optionsTableView.topAnchor.constraint(equalTo: limitMessage.bottomAnchor, constant: 24),
            optionsTableView.heightAnchor.constraint(equalToConstant: title == "Новая привычка" ? 75 : 150),
            optionsTableView.leadingAnchor.constraint(equalTo: nameTracker.leadingAnchor),
            optionsTableView.trailingAnchor.constraint(equalTo: nameTracker.trailingAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStack.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setTitle() {
        switch version {
        case .habit:
            title = "Новая привычка"
        case .event:
            title = "Новое нерегулярное событие"
        }
    }
    
}

extension SettingTrackerViewController {
    @objc private func didChangeTextOnNameTracker() {
        
    }
    
    @objc private func didTapCancelButton() {
        
    }
    
    @objc private func didTapCreateButton() {
        
    }
}

extension SettingTrackerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
