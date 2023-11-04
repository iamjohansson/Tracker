import UIKit

final class CreatingTrackerViewController: UIViewController {
    
    private lazy var habitButton: UIButton = {
        let habitButton = UIButton()
        habitButton.translatesAutoresizingMaskIntoConstraints = false
        habitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        habitButton.setTitle("Привычка", for: .normal)
        habitButton.setTitleColor(.White, for: .normal)
        habitButton.backgroundColor = .Black
        habitButton.layer.cornerRadius = habitButton.frame.size.height / 2
        habitButton.addTarget(self, action: #selector(didTapHabitButton), for: .touchUpInside)
        return habitButton
    }()
    
    private lazy var irregularEventButton: UIButton = {
        let eventButton = UIButton()
        eventButton.translatesAutoresizingMaskIntoConstraints = false
        eventButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        eventButton.setTitle("Нерегулярное событие", for: .normal) //в фигме не по русски написано как-то)
        eventButton.setTitleColor(.White, for: .normal)
        eventButton.backgroundColor = .Black
        eventButton.layer.cornerRadius = eventButton.frame.size.height / 2
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Создание трекера"
        view.backgroundColor = .White
        
        addSubViews()
        applyConstraint()
    }
    
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
}

private extension CreatingTrackerViewController {
    @objc func didTapHabitButton() {
        
    }
    
    @objc func didTapEventButton() {
        
    }
}
