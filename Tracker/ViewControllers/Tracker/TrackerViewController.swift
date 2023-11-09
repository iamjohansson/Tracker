import UIKit

final class TrackerViewController: UIViewController {
    
    // MARK: - Elements
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Трекеры"
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .Black
        return titleLabel
    }()
    
    private lazy var plusButton: UIButton = {
        let plusButton = UIButton()
        plusButton.setImage(UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        ), for: .normal)
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.tintColor = .Black
        return plusButton
    }()
    
    private lazy var searchField: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск"
        return searchBar
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.tintColor = .Blue
        datePicker.backgroundColor = .White
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.calendar = Calendar(identifier: .iso8601)
        datePicker.locale = Locale(identifier: "ru_RU")
        
        datePicker.addTarget(self, action: #selector(didChangeDate), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .White
        collectionView.register(TrackerCell.self, forCellWithReuseIdentifier: TrackerCell.identifier)
        collectionView.register(TrackerCategoryHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .Blue
        button.setTitle("Фильтры", for: .normal)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return button
    }()
    
    // MARK: - Properties
    private let defaultPlaceholder = UIStackView()
    private let searchPlaceholder = UIStackView()
    private var categories: [TrackerCategory] = TrackerCategory.defaultValue
    private var completedTrackers: Set<TrackerRecord> = []
    private var currentDate = Date()
    private var searchText = ""
    private let geomentricParams = UICollectionView.GeometricParams(
        cellCount: 2,
        leftInset: 16,
        rightInset: 16,
        cellSpacing: 9)
    private var currentlyTrackers: [TrackerCategory] {
        let day = Calendar.current.component(.weekday, from: currentDate)
        var tracker = [TrackerCategory]()
        for category in categories {
            let trackersFilter = category.trackersArray.filter { tracker in
                guard let sked = tracker.sked else { return true }
                return sked.contains(WeekDays.allCases[day > 1 ? day - 2 : day + 5])
            }
            if searchText.isEmpty && !trackersFilter.isEmpty {
                tracker.append(TrackerCategory(name: category.name, trackersArray: trackersFilter))
            } else {
                let filter = trackersFilter.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                if !filter.isEmpty {
                    tracker.append(TrackerCategory(name: category.name, trackersArray: filter))
                }
            }
        }
        
        if tracker.isEmpty {
            filterButton.isHidden = true
        } else {
            filterButton.isHidden = false
        }
        return tracker
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .White
        hideKeyboard()
        addSubViews()
        applyConstraint()
        defaultPlaceholder.configure(name: "starPlaceholder", text: "Что будем отслеживать?")
        searchPlaceholder.configure(name: "monoclePlaceholder", text: "Ничего не найдено")
        placeholderCheckForEmpty()
        placeholderCheckForSearch()
        setupDelegates()
    }
    
    // MARK: - Layout & Setting
    private func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(plusButton)
        view.addSubview(searchField)
        view.addSubview(datePicker)
        view.addSubview(collectionView)
        view.addSubview(defaultPlaceholder)
        view.addSubview(searchPlaceholder)
        view.addSubview(filterButton)
    }
    
    private func applyConstraint() {
        NSLayoutConstraint.activate([
            plusButton.heightAnchor.constraint(equalToConstant: 44),
            plusButton.widthAnchor.constraint(equalToConstant: 44),
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            plusButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            searchField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            datePicker.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            datePicker.widthAnchor.constraint(equalToConstant: 120),
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            defaultPlaceholder.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            defaultPlaceholder.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            searchPlaceholder.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            searchPlaceholder.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            filterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            filterButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            filterButton.heightAnchor.constraint(equalToConstant: 50),
            filterButton.widthAnchor.constraint(equalToConstant: 114)
        ])
    }
    
    private func setupDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
        searchField.delegate = self
    }
    
}

// MARK: - Actions & Methods
extension TrackerViewController {
    @objc private func didTapPlusButton() {
        let createTrack = CreatingTrackerViewController()
        createTrack.delegate = self
        let navigationController = UINavigationController(rootViewController: createTrack)
        present(navigationController, animated: true)
    }
    
    @objc private func didChangeDate(_ sender: UIDatePicker) {
        currentDate = sender.date
        collectionView.reloadData()
    }
    
    private func placeholderCheckForEmpty() {
        let isHidden = currentlyTrackers.isEmpty && searchPlaceholder.isHidden
        defaultPlaceholder.isHidden = !isHidden
    }
    
    private func placeholderCheckForSearch() {
        let isHidden = currentlyTrackers.isEmpty && searchField.text != ""
        searchPlaceholder.isHidden = !isHidden
    }
}

// MARK: - Extension CellDelegate
extension TrackerViewController: TrackerCellDelegate {
    func didTapExecButton(cell: TrackerCell, with tracker: Tracker) {
        let recordingTracker = TrackerRecord(id: tracker.id, date: currentDate)
        if let index = completedTrackers.firstIndex(where: { $0.date == currentDate && $0.id == tracker.id }) {
            completedTrackers.remove(at: index)
            cell.changeImageButton(active: false)
            cell.addOrSubtrack(value: false)
        } else {
            completedTrackers.insert(recordingTracker)
            cell.changeImageButton(active: true)
            cell.addOrSubtrack(value: true)
        }
    }
}

// MARK: - Extension DataSource
extension TrackerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        placeholderCheckForEmpty()
        return currentlyTrackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentlyTrackers[section].trackersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCell.identifier, for: indexPath) as? TrackerCell else {
            return UICollectionViewCell()
        }
        let tracker = currentlyTrackers[indexPath.section].trackersArray[indexPath.row]
        let daysCount = completedTrackers.filter { $0.id == tracker.id }.count
        let active = completedTrackers.contains { $0.date == currentDate && $0.id == tracker.id }
        cell.configure(with: tracker, days: daysCount, active: active)
        cell.delegate = self
        return cell
    }
    
}

// MARK: - Extension DelegateFlowLayout
extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: geomentricParams.leftInset, bottom: 16, right: geomentricParams.rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableSpace = collectionView.frame.width - geomentricParams.paddingWidth
        let cellWidth = availableSpace / CGFloat(geomentricParams.cellCount)
        return CGSize(width: cellWidth, height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        geomentricParams.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? TrackerCategoryHeader else { return UICollectionReusableView() }
        let label =  currentlyTrackers[indexPath.section].name
        view.configure(title: label)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}

// MARK: - Extension Controller Delegate
extension TrackerViewController: CreatingTrackerViewControllerDelegate, SettingTrackerViewControllerDelegate {
    func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    func didTapCreateButton(category: String, tracker: Tracker) {
        dismiss(animated: true)
        guard let categoryIndex = categories.firstIndex(where: { $0.name == category }) else { return }
        let newCardForCategory = TrackerCategory(
            name: category,
            trackersArray: categories[categoryIndex].trackersArray + [tracker]
        )
        categories[categoryIndex] = newCardForCategory
        collectionView.reloadData()
    }
    
    func didCreateTracker(with version: CreatingTrackerViewController.TrackerVersion) {
        dismiss(animated: true)
        let settingTracker = SettingTrackerViewController(version: version)
        settingTracker.delegate = self
        let navigationController = UINavigationController(rootViewController: settingTracker)
        present(navigationController, animated: true)
    }
}

// MARK: - Extension SearchBar Delegate
extension TrackerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        collectionView.reloadData()
        placeholderCheckForSearch()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        placeholderCheckForSearch()
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
        self.searchText = ""
        collectionView.reloadData()
        placeholderCheckForSearch()
    }
}

// MARK: - Extension Recognizer
extension TrackerViewController {
    
    private func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
