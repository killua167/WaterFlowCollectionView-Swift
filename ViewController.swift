//
//  ViewController.swift
//  WaterFlowCollectionView-Swift
//
//  Created by Zhangziyi on 2016/12/9.
//  Copyright © 2016年 GLaDOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var pushToB: UIButton!
    
    @IBAction func pushToB(_ sender: UIButton) {
        let vc : BViewController = BViewController()
        vc.callbackBLOCK = {
            (a,b) -> () in
            self.displayLabel.text = String(a) + String(b)
        }
        
        vc.zyngaBlock = {
            (a,b) -> (Int) in
            return b - a
        }
        

        self.navigationController? .pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(collectionView)
        let nib = UINib(nibName: "WFCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
    }
    
    lazy var collectionView: UICollectionView = {
        let waterFlowLayout : WaterFlowLayout = WaterFlowLayout()
        waterFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        waterFlowLayout.columnCount = 2
        waterFlowLayout.columnSpaceing = 10
        waterFlowLayout.rowSpaceing = 10
        waterFlowLayout.itemHeightBlock = {
            (itemWidth,indexPath) -> CGFloat in
            let image:MyImage = self.images[indexPath.item]
            return image.imageH! / image.imageW! * itemWidth
        }
        let collection : UICollectionView = UICollectionView(frame:screenBounds,collectionViewLayout:waterFlowLayout)
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    lazy var images : Array<MyImage> = {
        var images = Array<MyImage>()
        let path = Bundle.main.path(forResource: "1.plist", ofType: nil)!
        let imageDics = NSMutableArray(contentsOfFile: path);
        for imageDic in imageDics! {
            let image : MyImage = MyImage.init(imageDic: imageDic as! Dictionary<String, Any>)
            images.append(image)
        }
        return images
    }()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

/*
     let winePath = NSBundle.mainBundle().pathForResource("wine.plist", ofType: nil)!
     let winesM = NSMutableArray(contentsOfFile: winePath);
     var tmpArray:Array<XWWine>! = []
     for tmpWineDict in winesM! {
     var wine:XWWine = XWWine.wineWithDict(tmpWineDict as! NSDictionary)
     tmpArray.append(wine)
     }
     print("我就运行一次")
     return tmpArray
 */
    
    
}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView .setToIndexPath(indexPath)
        
//        let pageVC : HorizontalPageViewController = HorizontalPageViewController()
//        pageVC.images = images
        let cell : WFCollectionViewCell = collectionView.cellForItem(at: indexPath) as! WFCollectionViewCell
        let pageVC : HorizontalPageViewController = HorizontalPageViewController.init(cell, cell.imageView.image! ,images)

        self.present(pageVC, animated: true, completion: nil)
    }
}


extension ViewController : UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell : WFCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WFCollectionViewCell
        cell.imageURL = self.images[indexPath.item].imageURL!
        return cell
    }
}

extension ViewController : TransitionProtocol{
    func transitionCollectionView() -> UICollectionView {
        return collectionView
    }
}


