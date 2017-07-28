//
//  WFCollectionViewCell.swift
//  WaterFlowCollectionView-Swift
//
//  Created by Zhangziyi on 2016/12/13.
//  Copyright © 2016年 GLaDOS. All rights reserved.
//

import UIKit
import Kingfisher
class WFCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    open var imageURL : URL{
        get{
            return self.imageURL
        }
        set (newValue){
            self.imageView.kf.setImage(with: newValue)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }


}

extension WFCollectionViewCell : TansitionWaterfallGridViewProtocol{
    func snapShotForTransition() -> UIView {
        let image = self.contentView.snapshot()
        let tempView = UIImageView(image: image)
        tempView.frame = self.contentView.frame
        return tempView
    }
}
