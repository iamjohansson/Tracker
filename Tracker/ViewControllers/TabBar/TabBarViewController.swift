import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItems()
    }
    
    // MARK: - Constructor Method
    private func setupBarItems() {
        tabBar.backgroundColor = .White
        tabBar.tintColor = .Blue
        tabBar.barTintColor = .Gray
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        tabBar.layer.shadowRadius = 0
        
        let trackerViewController = TrackerViewController()
        trackerViewController.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "trackerImage"),
            selectedImage: nil
        )
        
        let statisticViewController = StatisticViewController()
        statisticViewController.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "statisticImage"),
            selectedImage: nil
        )
        self.viewControllers = [trackerViewController, statisticViewController]
    }
}

