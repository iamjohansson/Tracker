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
        optionsTable.register(SettingTableCell.self, forCellReuseIdentifier: SettingTableCell.identifier)
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
    private var data: Tracker.Track {
        didSet {
            checkButtonValidation()
        }
    }
    
    private var buttonIsEnable = false {
        willSet {
            if newValue {
                createButton.backgroundColor = .Black
                createButton.isEnabled = true
            } else {
                createButton.backgroundColor = .Gray
                createButton.isEnabled = false
            }
        }
    }
    
    private var limitMessageVisible = false {
        didSet {
            checkButtonValidation()
            if limitMessageVisible {
                limitMessage.isHidden = true
            } else {
                limitMessage.isHidden = false
            }
        }
    }
    
    private var skedString: String? {
        guard let sked = data.sked else { return nil }
        if sked.count == 7 { return "Каждый день" }
        let short: [String] = sked.map { $0.shortcut }
        return short.joined(separator: ", ")
    }
    
    private var category: String? = TrackerCategory.defaultValue[0].name {
        didSet {
            checkButtonValidation()
        }
    }
    
    private let parametres = ["Категория", "Расписание"]
    
    
    init(version: CreatingTrackerViewController.TrackerVersion, data: Tracker.Track = Tracker.Track()) {
        self.version = version
        self.data = data
        super.init(nibName: nil, bundle: nil)
        
        switch version {
        case .habit:
            self.data.sked = []
        case .event:
            self.data.sked = nil
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .White
        optionsTableView.dataSource = self
        addSubViews()
        setTitle()
        applyConstraint()
        
        checkButtonValidation()
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
    
    private func checkButtonValidation() {
        if data.name.count == 0 {
            buttonIsEnable = false
        }
        if limitMessageVisible {
            buttonIsEnable = false
        }
        if category == nil {
            buttonIsEnable = false
        }
        if let sked = data.sked,
            sked.isEmpty {
            buttonIsEnable = false
        }
        buttonIsEnable = true
    }
}

extension SettingTrackerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.sked == nil ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableCell.identifier) as? SettingTableCell else { return UITableViewCell() }
        
        var description: String? = nil
        
        if data.sked == nil {
            description = category
        } else {
            description = indexPath.row == 0 ? category : skedString
        }
        cell.configure(name: parametres[indexPath.row], description: description)
        return cell
    }
    
}
