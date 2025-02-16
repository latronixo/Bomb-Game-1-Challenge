import UIKit

open class BaseViewController: UIViewController {
    private lazy var backgroundLayer: CALayer = {
        let image = ModuleAsset.backgroundImage
        let layer = CALayer()
        layer.frame = view.bounds
        layer.contents = image.cgImage
        layer.contentsGravity = .resizeAspectFill
        return layer
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard backgroundLayer.superlayer == nil else { return }
        view.layer.insertSublayer(backgroundLayer, at: .zero)
    }
}

private extension BaseViewController {
    func setupView() {
        view.backgroundColor = ModuleAsset.backgroundColor
    }
}
