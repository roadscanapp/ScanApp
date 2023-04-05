import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: HomeViewController(),
                       title: RSConstants.maps,
                       image: UIImage(named: RSAssets.tabBarMap)),
            
            generateVC(viewController: SettingsViewController(),
                       title: RSConstants.settings,
                       image: UIImage(named: RSAssets.tabBarSettings))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let navController = UINavigationController(rootViewController: viewController)
        return navController
    }
    
    private func setTabBarAppearance() {
        tabBar.tintColor = .mainBlue
        tabBar.backgroundColor = .white
    }
}

