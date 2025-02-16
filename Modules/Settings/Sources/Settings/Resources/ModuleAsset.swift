import UIKit

enum ModuleAsset {
    static var backgroundColor: UIColor { UIColor(named: "backgroundColor", in: .module, compatibleWith: nil)! }
    static var backgroundImage: UIImage { return UIImage(named: "backgroundImage", in: .module, with: nil)! }
    static var cellBackgroundColor: UIColor { UIColor(named: "cellBackgroundColor", in: .module, compatibleWith: nil)! }
    static var mainYellowColor: UIColor { UIColor(named: "mainYellowColor", in: .module, compatibleWith: nil)! }
    static var sectionBackgroundColor: UIColor { UIColor(named: "sectionBackgroundColor", in: .module, compatibleWith: nil)! }
    
}
