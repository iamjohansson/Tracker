import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItems()
    }
    
    private func setupBarItems() {
        tabBar.backgroundColor = .White
        tabBar.tintColor = .Blue
        tabBar.barTintColor = .Gray
        
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

