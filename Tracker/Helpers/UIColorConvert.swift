import UIKit

final class UIColorConvert {
    static func convertColorToString(color: UIColor) -> String {
        let components = color.cgColor.components ?? []
        let hex = components.reduce("#") {
            let value = Int($1 * 255)
            return $0 + String(format: "%02X", value)
        }
        return hex
    }
    
    static func convertStringToColor(hex: String) -> UIColor? {
        let startIndex = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[startIndex...])
        if let hexNumber = UInt64(hexColor, radix: 16) {
            let r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
            let g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
            let b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
            let a = CGFloat(hexNumber & 0x000000FF) / 255
            return UIColor(red: r, green: g, blue: b, alpha: a)
        }
        return nil
    }
    
//        static func convertColorToData(_ color: UIColor) -> NSData? {
//            do {
//                return try NSKeyedArchiver.archivedData(
//                    withRootObject: color,
//                    requiringSecureCoding: false
//                ) as NSData
//            } catch {
//                print("Ошибка при конвертировании цвета в Data: \(TrackerError.decodeError)")
//                return nil
//            }
//        }
//
//        static func convertDataToColor(_ data: NSData) -> UIColor? {
//            do {
//                if let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data as Data) {
//                    return color
//                }
//            } catch {
//                print("Ошибка при конвертировании Data в цвет: \(TrackerError.decodeError)")
//                return nil
//            }
//        }
}
