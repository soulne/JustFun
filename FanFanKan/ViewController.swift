//
//  ViewController.swift
//  FanFanKan
//
//  Created by 杨富彬 on 15/10/18.
//  Copyright © 2015年 bin. All rights reserved.
//

import UIKit
import AVFoundation
//import MyImageView



class ViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tuoNiaoImageView: UIImageView!
    var _player = AVAudioPlayer()
    var _remeberView : MyImageView!
    var _timer = NSTimer()
    var _record = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadBirdAnimation()
         _timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:"changeLabel", userInfo: nil, repeats: true)
//        _timer.fireDate = NSDate.distantPast()
        _timer.fire()
        loadMusic()
        loadVegetables()
        self.performSelector("turnVegetableBack", withObject: nil, afterDelay: 3.0)
        _record = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    MARK:touch事件捕捉
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        super.touchesBegan(touches: Set<UITouch>, withEvent: UIEvent?)
        let touch = touches.first
        
        if  (touch!.view!.tag > 99 && touch!.view!.tag < 120 ){
            
            let myImageView = touch!.view as! MyImageView
            myImageView.turnLeft()
            if (_remeberView == nil){
                _remeberView = myImageView;
            }else{
                if (myImageView.flag % 10 == _remeberView!.flag % 10){
                    _record = _record + 1
                    if(_record == 10){
                        self.performSelector("showMassage:", withObject: "你赢了！", afterDelay: 3)
                    }
                    _remeberView = nil
                }else {
//                    self.turnCompareVegetable(myImageView)
                    self.performSelector("turnCompareVegetable:", withObject: myImageView, afterDelay: 0.5)
                    
//                    myImageView.performSelector("turnRight", withObject: nil, afterDelay: 0.5)
//                    
//                     _remeberView.performSelector("turnRight", withObject: nil, afterDelay: 0.5)
                }
            }
        }
        
        

    }
    
    
//    MARK:刷新按钮
    @IBAction func refreshButtonPressde(sender: UIButton) {
        self.turnVegetableFont()
        self.loadVegetables()
        self.performSelector("turnVegetableBack", withObject: nil, afterDelay: 1)
        _remeberView = nil
        _record = 0
        timeLabel.text = "90"
        _timer.fireDate = NSDate.distantPast()
    }
    
    
    
    @IBAction func musicButoonPressed(sender: UIButton) {
        //切换图片
        if (_player.playing == true){
            sender.setBackgroundImage(UIImage(named: "closeSound"), forState: UIControlState.Normal)
            _player.pause()
        }else{
            sender.setBackgroundImage(UIImage(named: "openSound"), forState: UIControlState.Normal)
            _player.play()
        }
    }
    
    func loadVegetables(){
        var numbers = [Int]()
        for i in 1...20{
            
            numbers.append(i)
        }
        
        for i in 0..<20 {
            var j = 0
            let randomIndex = Int( arc4random() % 20)
            j = numbers[i]
            numbers[i] = numbers[randomIndex]
            numbers[randomIndex] = j
            //找不到exchangedatawithindex方法。。。。只能这样了
        }
        for i in 0..<20 {
            let name = "fruit" + String(numbers[i])
            let image = UIImage(named: name)
            let myImageView = self.view.viewWithTag(100+i) as! MyImageView
            myImageView.image = image
            
            myImageView.fontImage = image!;
            myImageView.flag = numbers[i]
        }
    }
    
    
    
    func loadMusic(){
        self._player = {
        let path = NSBundle.mainBundle().pathForResource("sound_bg", ofType: "mp3")
        let url : NSURL = NSURL(string: path!)!
        
        _player = try! AVAudioPlayer(contentsOfURL: url)
        _player.numberOfLoops = -1
        _player.prepareToPlay()
//        player.play()
        return _player
        }()
        self._player.play()
    }
    
    func loadBirdAnimation() {
        var images = [UIImage]()
        
        for index in 1...7{
//            let indexString = index as String
            
            let name = "rec_app_tuo_niao_" + String(index) + ".png"
            let image = UIImage(named: name)
            
            images.append(image!)
            
        }
        self.tuoNiaoImageView.animationDuration = 1
        self.tuoNiaoImageView.animationImages = images
        self.tuoNiaoImageView.animationRepeatCount = -1
        self.tuoNiaoImageView.startAnimating()
        
    }
    
    func changeLabel(){
       let i = Int( timeLabel.text!)! - 1
        if i == 0 {
            _timer.fireDate = NSDate.distantFuture()
            timeLabel.text = "90"
            self._player.pause()
            self.showMassage("你输了")
        }
        timeLabel.text = String(i)
    }
    
    func showMassage(sender:String){
        let alertController = UIAlertController(title: "温馨提示", message: sender, preferredStyle: UIAlertControllerStyle.Alert)
        let sureAlertAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
        }
        let againAlertAction = UIAlertAction(title: "再来一次", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self._timer.fireDate = NSDate.distantPast()
            self.turnVegetableFont()
            self.loadVegetables()
            self.performSelector("turnVegetableBack", withObject: nil, afterDelay: 3)
            self._remeberView = nil
            self.timeLabel.text = "90"
        }
        alertController.addAction(againAlertAction)
        alertController.addAction(sureAlertAction)
        self.presentViewController(alertController, animated: true) { () -> Void in
            
        }
    }
    
    func turnVegetableBack(){
        for i in 0..<20 {
            let myImageView = self.view.viewWithTag(100+i) as! MyImageView
            myImageView.turnRight()
        }
    }
    
    func turnVegetableFont() {
        for i in 0..<20 {
            let myImageView = self.view.viewWithTag(100+i) as! MyImageView
            myImageView.turnLeft()
        }
    }
    
    func turnCompareVegetable(sender:MyImageView){
        sender.turnRight()
        _remeberView.turnRight()
        _remeberView = nil
    }

    func somechange() {
        print("abc")
    }
    
    func antherfuc() {
        print("123")
    }

}

