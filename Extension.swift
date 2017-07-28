//
//  Extension.swift
//  WaterFlowCollectionView-Swift
//
//  Created by Zhangziyi on 2017/2/21.
//  Copyright © 2017年 GLaDOS. All rights reserved.
//

import Foundation
import UIKit

var kIndexPathPointer = "kIndexPathPointer"

extension UIImage{
    
}

//UIGraphicsBeginImageContextWithOptions(view.bounds.size,YES,0);
//
//[view drawHierarchyInRect:view.bounds afterScreenUpdates:YES];
//
//UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//
//UIGraphicsEndImageContext();
//
//return image;

extension UIView{
    var origin : CGPoint{
        get{
            return frame.origin
        }
        set(origin){
            var frame : CGRect = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
    var width : CGFloat{
        return frame.size.width
    }
    
    var height : CGFloat{
        return frame.size.height
    }
    
    var x : CGFloat{
        get{
            return frame.origin.x
        }
        set(x){
            var frame : CGRect = self.frame
            frame.origin.x = x
            self.frame = frame
        }
    }
    
    var y : CGFloat{
        get{
            return frame.origin.y
        }
        set(y){
            var frame : CGRect = self.frame
            frame.origin.x = y
            self.frame = frame
        }
    }
    
    func snapshot () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}

extension UICollectionView{
    
    func setToIndexPath (_ indexPath : IndexPath){
        objc_setAssociatedObject(self, &kIndexPathPointer, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func toIndexPath () -> IndexPath {
        let index = self.contentOffset.x/self.frame.size.width
        if index > 0{
            return IndexPath(row: Int(index), section: 0)
        }else if let indexPath = objc_getAssociatedObject(self,&kIndexPathPointer) as? IndexPath {
            return indexPath
        }else{
            return IndexPath(row: 0, section: 0)
        }
    }
    
    func fromPageIndexPath () -> IndexPath{
        let index : Int = Int(self.contentOffset.x/self.frame.size.width)
        return IndexPath(row: index, section: 0)
    }
    
}

