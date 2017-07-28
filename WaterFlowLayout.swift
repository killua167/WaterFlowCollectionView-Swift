//
//  WaterFlowLayout.swift
//  WaterFlowCollectionView-Swift
//
//  Created by Zhangziyi on 2016/12/9.
//  Copyright © 2016年 GLaDOS. All rights reserved.
//

import UIKit

class WaterFlowLayout: UICollectionViewLayout {

    var columnCount : NSInteger?
    var columnSpaceing : NSInteger?
    var rowSpaceing : NSInteger?
    var sectionInset : UIEdgeInsets?
    var maxYdic :Dictionary = Dictionary<Int,CGFloat>()
    var atrributesArray = Array<UICollectionViewLayoutAttributes>()
    var itemHeightBlock:((CGFloat,IndexPath) -> (CGFloat))?
    
    override func prepare() {
        super.prepare()
        for i in 0 ..< self.columnCount!  {
            self.maxYdic[i] = sectionInset?.top
        }
        let itemCount = (self.collectionView?.numberOfItems(inSection: 0))!
        for i in 0 ..< itemCount {
            let indexPath : IndexPath = IndexPath(item : i,section : 0)
            
            let attributes = self.layoutAttributesForItem(at: indexPath)
            self.atrributesArray .append(attributes!)
        }
    }
    
}


extension WaterFlowLayout{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.atrributesArray
    }
}

extension WaterFlowLayout{
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let atrributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let collectionWidth = collectionView?.frame.size.width

        let spaceings  = (sectionInset?.left)! + (sectionInset?.right)! + CGFloat((columnCount! - 1)*columnSpaceing!)
        let itemWidth = (collectionWidth! - spaceings)/2
        
        var minIndex = 0
        for (key,value) in maxYdic {
            if maxYdic[minIndex]! > value {
                minIndex = key
            }
        }
        let itemX = (sectionInset?.left)! + CGFloat(minIndex)*(itemWidth + CGFloat(columnSpaceing!))
        let itemY = maxYdic[minIndex]! + (sectionInset?.bottom)!
        var itemHeight : CGFloat?
        if (self.itemHeightBlock != nil) {
            itemHeight = self.itemHeightBlock!(itemWidth,indexPath)
        }
        
        atrributes.frame = CGRect(x:itemX,y:itemY,width:itemWidth,height:itemHeight!)
        self.maxYdic[minIndex] = (atrributes.frame).maxY
        return atrributes
        
    }
}

extension WaterFlowLayout{
    override var collectionViewContentSize: CGSize{
        var maxIndex = 0
        for (key, value) in maxYdic{
            if maxYdic[maxIndex]! < value  {
                maxIndex = key
            }
        }

        return CGSize(width:0, height:(sectionInset?.bottom)! + maxYdic[maxIndex]!)
    }
}
