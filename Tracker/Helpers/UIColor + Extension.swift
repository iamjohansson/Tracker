import UIKit

extension UIColor {
    // MARK: - System Colors - for light and dark theme
    static var Background: UIColor { UIColor(named: "Background") ?? UIColor.darkGray }
    static var Black: UIColor { UIColor(named: "Black") ?? UIColor.black }
    static var Blue: UIColor { UIColor(named: "Blue") ?? UIColor.blue }
    static var Gray: UIColor { UIColor(named: "Gray") ?? UIColor.gray }
    static var LightGray: UIColor { UIColor(named: "Light Gray") ?? UIColor.lightGray }
    static var Red: UIColor { UIColor(named: "Red") ?? UIColor.red }
    static var White: UIColor { UIColor(named: "White") ?? UIColor.white }
    
    // MARK: - Collection Colors
    static var trackerColors = [
        UIColor(named: "Color 1") ?? UIColor.red,
        UIColor(named: "Color 2") ?? UIColor.orange,
        UIColor(named: "Color 3") ?? UIColor.blue,
        UIColor(named: "Color 4") ?? UIColor.purple,
        UIColor(named: "Color 5") ?? UIColor.green,
        UIColor(named: "Color 6") ?? UIColor.systemPink,
        UIColor(named: "Color 7") ?? UIColor.white,
        UIColor(named: "Color 8") ?? UIColor.systemBlue,
        UIColor(named: "Color 9") ?? UIColor.systemGreen,
        UIColor(named: "Color 10") ?? UIColor.black,
        UIColor(named: "Color 11") ?? UIColor.systemRed,
        UIColor(named: "Color 12") ?? UIColor.systemPink,
        UIColor(named: "Color 13") ?? UIColor.systemBrown,
        UIColor(named: "Color 14") ?? UIColor.blue,
        UIColor(named: "Color 15") ?? UIColor.systemPurple,
        UIColor(named: "Color 16") ?? UIColor.purple,
        UIColor(named: "Color 17") ?? UIColor.cyan,
        UIColor(named: "Color 18") ?? UIColor.green
    ]
}
