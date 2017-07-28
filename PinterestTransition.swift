//
//  PinterestTransition.swift
//  WaterFlowCollectionView-Swift
//
//  Created by Zhangziyi on 2017/2/21.
//  Copyright © 2017年 GLaDOS. All rights reserved.
//

import UIKit

protocol TransitionProtocol {
    func transitionCollectionView() -> UICollectionView
}

protocol TansitionWaterfallGridViewProtocol {
    func snapShotForTransition () -> UIView
}

protocol HorizontalPageViewControllerProtocol {
    func pageViewCellScrollViewContentOffset () -> CGPoint
}

protocol WaterFallViewControllerProtocol {
    func viewWillAppearWithPageIndex (_ pageIndex:Int) -> ()
}

enum TransitionType {
    case Present
    case Dismiss
}

class PinterestTransition: NSObject {
    
    var type : TransitionType = .Present
    var animationDuration : TimeInterval?
    
    init(_ type:TransitionType) {
        self.type = type
        animationDuration = 1.0
    }
    
    func presentAnimation(transitionContext: UIViewControllerContextTransitioning) -> () {
        let toViewController = transitionContext.viewController(forKey: .to)
        let fromViewController = transitionContext.viewController(forKey: .from)
        
        let toView = toViewController?.view
        let fromView = fromViewController?.view
        
        let waterFallView = (fromViewController as! TransitionProtocol).transitionCollectionView()
        let pageView = (toViewController as! TransitionProtocol).transitionCollectionView()
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView!)
        containerView.addSubview(toView!)
        
        let indexPath = waterFallView.toIndexPath()
        let gridView = waterFallView.cellForItem(at: indexPath as IndexPath)
        let leftUperPoint = gridView!.convert(CGPoint.zero, to: nil)
        pageView.isHidden = true
        pageView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        
        let snapShotView = (gridView as! TansitionWaterfallGridViewProtocol).snapShotForTransition()
        containerView.addSubview(snapShotView)
        snapShotView.origin = leftUperPoint
        
        let animationScale : CGFloat = (SCREEN_WIDTH - 20) / (gridView?.width)!
        
        let whiteView : UIView = UIView(frame: screenBounds)
        whiteView.backgroundColor = .white
        whiteView.alpha = 0
        fromView?.addSubview(whiteView)
        
        UIView.animate(withDuration: animationDuration!, animations: { 
            snapShotView.transform = CGAffineTransform(scaleX: animationScale, y: animationScale)
            snapShotView.frame = CGRect(x: 10, y: 64, width: snapShotView.width , height: snapShotView.height)
            whiteView.alpha = 1
            fromView?.transform = CGAffineTransform(scaleX: animationScale, y: animationScale)
            fromView?.frame = CGRect(x: -leftUperPoint.x * animationScale + 10, y: (-leftUperPoint.y + 20) * animationScale , width: (fromView?.width)! , height: (fromView?.height)!)
        }) { (finished) in
            snapShotView .removeFromSuperview()
            whiteView.removeFromSuperview()
            pageView.isHidden = false
            fromView?.transform = CGAffineTransform.identity
            print("finish!!!!!!!!!")
            transitionContext.completeTransition(true)
        }
        
        
    }
    
    
    
}

extension PinterestTransition : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration!
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .Present:
            presentAnimation(transitionContext: transitionContext)
            break
        case .Dismiss:
            
            break

        }
    }
    
}

