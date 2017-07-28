//
//  MyImage.swift
//  WaterFlowCollectionView-Swift
//
//  Created by Zhangziyi on 2016/12/13.
//  Copyright © 2016年 GLaDOS. All rights reserved.
//

import UIKit

class MyImage: NSObject {
    open var imageURL:URL?
    open var imageW:CGFloat?
    open var imageH:CGFloat?
    
    init(imageDic:Dictionary<String,Any>) {
        self.imageURL = URL.init(string: imageDic["img"] as! String)
        self.imageW = imageDic["w"] as? CGFloat
        self.imageH = imageDic["h"] as? CGFloat
    }

}
