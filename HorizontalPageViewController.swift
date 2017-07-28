//
//  HorizontalPageViewController.swift
//  WaterFlowCollectionView-Swift
//
//  Created by Zhangziyi on 2017/2/15.
//  Copyright © 2017年 GLaDOS. All rights reserved.
//

import UIKit

class HorizontalPageViewController: UIViewController {
    
    var images : Array<MyImage> = []
    var collectionView : UICollectionView?
    let applicationWindow : UIWindow = ((UIApplication.shared.delegate?.window)!)!
    var displayImage : UIImage?
    var senderViewForAnimation : UIView?
    override var prefersStatusBarHidden: Bool {
        return true
        
    }
    
    convenience init(_ fromView:UIView, _ image:UIImage , _ images:Array<MyImage>){
        self.init()
        self.images = images
        self.displayImage = image
        self.senderViewForAnimation = fromView
        self.modalPresentationStyle = .custom;
        self.modalTransitionStyle = .crossDissolve;
        self.modalPresentationCapturesStatusBarAppearance = true;
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        
        self.transitioningDelegate = self
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: layout)
        collectionView!.backgroundColor = .white
        collectionView!.isPagingEnabled = true
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.register(PageViewCell.classForCoder(), forCellWithReuseIdentifier: "page")
        view.addSubview(collectionView!)
        
        
        
        super.viewDidLoad()
        performPresentAnimation()
    }

    func performPresentAnimation() -> () {
        self.view.alpha = 0
        collectionView?.alpha = 0
        let senderViewOrignalFrame = senderViewForAnimation?.superview?.convert((senderViewForAnimation?.frame)!, to: nil)
        let rect = applicationWindow.bounds
        let fadeView = UIView(frame: rect)
        fadeView.backgroundColor = .clear
        applicationWindow.addSubview(fadeView)
        
        let resizableImageView = UIImageView(image: displayImage)
        resizableImageView.frame = senderViewOrignalFrame!
        resizableImageView.contentMode = .scaleAspectFill
        resizableImageView.backgroundColor = .clear
        resizableImageView.clipsToBounds = true
        applicationWindow.addSubview(resizableImageView)
        senderViewForAnimation?.isHidden = true
        
        UIView.animate(withDuration: 1.0, animations: {
            fadeView.backgroundColor = .white
        }, completion: nil)
        
        let finalImageViewFrame = animationFrameForImage(displayImage!, view ,true)
        
        UIView.animate(withDuration: 1.0, animations: {
            resizableImageView.layer.frame = finalImageViewFrame
        }) { (finish) in
            self.view.alpha = 1.0
            self.collectionView?.alpha = 1.0
//            resizableImageView.backgroundColor = UIColor.init(white: 1, alpha: 1)
            fadeView.removeFromSuperview()
            resizableImageView.removeFromSuperview()
        }
    }
    
    func animationFrameForImage(_ image:UIImage, _ view:UIView, _ presenting:Bool) -> CGRect {
        let imageSize = image.size
        
        let maxWidth = applicationWindow.bounds.width
        let maxHeight = applicationWindow.bounds.height
        
        var animationFrame : CGRect = .zero
        
        let aspect = imageSize.width / imageSize.height
        if (maxWidth - 20) / aspect <= maxHeight {
            animationFrame.size = CGSize(width: maxWidth - 20, height: (maxWidth - 20) / aspect)
        }else{
            animationFrame.size = CGSize(width: (maxHeight - 20) * aspect, height: maxHeight)
        }
        
//        animationFrame.origin.x = (maxWidth - animationFrame.size.width) / 2.0
//        animationFrame.origin.y = (maxHeight - animationFrame.size.height) / 2.0
        animationFrame.origin = CGPoint(x: 10, y: 64)
        
        if !presenting {
            animationFrame.origin.y += view.frame.origin.y;
            animationFrame.origin.x += view.frame.origin.x;
        }
        
        return animationFrame
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HorizontalPageViewController : TransitionProtocol{
    func transitionCollectionView() -> UICollectionView {
        return collectionView!
    }
}

extension HorizontalPageViewController : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PinterestTransition.init(.Present)
    }
}

extension HorizontalPageViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HorizontalPageViewController:UICollectionViewDelegate{
    
}

extension HorizontalPageViewController:UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (images.count)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "page", for: indexPath) as! PageViewCell
        cell.image = (images[indexPath.item])
        cell.buttonBlock = {
            (tag) -> () in
            switch tag {
            case 101:
                self .dismiss(animated: true, completion: nil)
                break
            case 102:
                print("saveAction")
                break
            default: break
                
            }
        }
        return cell
    }
}
