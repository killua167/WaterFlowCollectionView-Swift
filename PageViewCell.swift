//
//  PageViewCell.swift
//  WaterFlowCollectionView-Swift
//
//  Created by Zhangziyi on 2017/2/15.
//  Copyright © 2017年 GLaDOS. All rights reserved.
//

import UIKit
import Kingfisher
class PageViewCell: UICollectionViewCell {
    
    var buttonBlock : ((Int) -> Void)?
    
    var tableView : UITableView?
    
    open var image : MyImage{
        get{
            return self.image
        }
        set(newValue){
            let header = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 20, height: (newValue.imageH)! * (SCREEN_WIDTH - 20)/(newValue.imageW)! + 64))
            let headerView = UIImageView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH - 20, height: (newValue.imageH)! * (SCREEN_WIDTH - 20)/(newValue.imageW)!))
            headerView.isUserInteractionEnabled = true
            header.addSubview(headerView)
            tableView?.tableHeaderView = header
            headerView.kf.setImage(with: newValue.imageURL)
        }
    }
    
//    lazy var headerView : UIImageView = {
//        let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (self.image.imageH)!*SCREEN_WIDTH/(self.image.imageW)!))
//        headerView.isUserInteractionEnabled = true
//        return headerView
//    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        tableView = UITableView(frame: CGRect(x: 10, y: 0, width: SCREEN_WIDTH - 20, height: SCREEN_HEIGHT), style: .plain)
        tableView?.backgroundColor = .white
        tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView?.delegate = self
        tableView?.dataSource = self
        self .addSubview(tableView!)
        
        let blurEffect : UIBlurEffect = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64)
        self.addSubview(blurView)
        let backButton = UIButton(frame: CGRect(x: 10, y: 32-12, width: 16, height: 24))
        backButton.setImage(UIImage(named: "back-arrow_16x24_"), for: .normal)
        backButton.addTarget(self, action: #selector(backNavi(_:)), for: .touchUpInside)
        backButton.tag = 100 + 1
        blurView.addSubview(backButton)
        
        let saveButton = UIButton(frame: CGRect(x: SCREEN_WIDTH - 10 - 70, y: 32 - 15, width: 70, height: 30))
        saveButton.backgroundColor = .red
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        saveButton.setImage(UIImage(named:"pin_10x22_"), for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        saveButton.addTarget(self, action: #selector(saveAction(_:)), for: .touchUpInside)
        saveButton.tag = 100 + 2
        saveButton.layer.cornerRadius = 5.0
        blurView.addSubview(saveButton)
    }
    
    func backNavi(_ button:UIButton) -> () {
        guard (buttonBlock != nil) else {
            return
        }
        buttonBlock!(button.tag)
    }
    
    func saveAction(_ button:UIButton) -> () {
        guard buttonBlock != nil else {
            return
        }
        buttonBlock!(button.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension PageViewCell:UITableViewDelegate{
    
}

extension PageViewCell:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "1111111"
        return cell
    }
}
