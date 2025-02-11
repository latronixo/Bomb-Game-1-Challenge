import UIKit

enum ModuleAsset {
    static var backgroundColor: UIColor { UIColor(named: "backgroundColor", in: .module, compatibleWith: nil)! }
    static var backgroundImage: UIImage { return UIImage(named: "backgroundImage", in: .module, with: nil)! }
}
