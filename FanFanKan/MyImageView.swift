//
//  MyImageView.swift
//  FanFanKan
//
//  Created by 杨富彬 on 15/10/18.
//  Copyright © 2015年 bin. All rights reserved.
//

import UIKit

class MyImageView: UIImageView {
    var fontImage = UIImage()
    var flag = 0
    
    func turnLeft(){
        UIView.transitionWithView(self, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { () -> Void in
                self.image = self.fontImage
            }) { (Bool) -> Void in
                self.userInteractionEnabled = false
        }
        
    }
    
    func turnRight(){
        UIView.transitionWithView(self, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
            self.image = UIImage(named: "contrary.png")
            }) { (Bool) -> Void in
                self.userInteractionEnabled = true
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
