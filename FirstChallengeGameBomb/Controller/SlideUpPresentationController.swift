//
//  Untitled.swift
//  FirstChallengeGameBomb
//
//  Created by Надежда Капацина on 10.02.2025.
//
import UIKit
class SlideUpPresentationController: UIPresentationController {
    private let dimmingView = UIView()
    private var heightRatio: CGFloat = 0.85
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let height = containerView.bounds.height * heightRatio
        return CGRect(x: 0,
                     y: containerView.bounds.height - height,
                     width: containerView.bounds.width,
                     height: height)
    }
    
    override func presentationTransitionWillBegin() {
        
        // Анимация появления фона
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        }, completion: { _ in
            self.dimmingView.removeFromSuperview()
        })
    }
}

//Аниматор для перехода
class SlideUpAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            animatePresentation(using: transitionContext)
        } else {
            animateDismissal(using: transitionContext)
        }
    }
    
    private func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        let finalHeight = containerView.bounds.height * 0.85
        
        presentedViewController.view.frame = CGRect(
            x: 0,
            y: containerView.bounds.height,
            width: containerView.bounds.width,
            height: finalHeight
        )
        
        containerView.addSubview(presentedViewController.view)
        
        // Анимация появления
        UIView.animate(withDuration: 0.3, animations: {
            presentedViewController.view.frame.origin.y = containerView.bounds.height - finalHeight
        }) { completed in
            transitionContext.completeTransition(completed)
        }
    }

    private func animateDismissal(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedViewController = transitionContext.viewController(forKey: .from) else { return }
        
        // Анимация исчезновения
        UIView.animate(withDuration: 0.3, animations: {
            presentedViewController.view.frame.origin.y = presentedViewController.view.bounds.height
        }) { completed in
            transitionContext.completeTransition(completed)
        }
    }
}

//Transitioning Delegate
class SlideUpTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideUpAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideUpAnimator(isPresenting: false)
    }
}


