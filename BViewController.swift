//
//  BViewController.swift
//  WaterFlowCollectionView-Swift
//
//  Created by Zhangziyi on 2016/12/12.
//  Copyright © 2016年 GLaDOS. All rights reserved.
//

import UIKit


class BViewController: UIViewController {

    var callbackBLOCK:((Int,Int)->())?
    var zyngaBlock:((Int,Int) -> (Int))?
    open var d : Int?
    open var c : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red

        let a = 1
        let b = 2
        
        
        if (self.callbackBLOCK != nil) {
            callbackBLOCK!(a,b)
        }
        
        if (self.zyngaBlock != nil) {
            c = zyngaBlock!(a,b)
            print(c!)
        }
        
        
    }

    func aaa(bb:(Int) -> ()) {
        bb(1)
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
