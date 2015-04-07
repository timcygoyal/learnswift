//
//  ViewController.swift
//  pp
//
//  Created by tester on 06/04/15.
//  Copyright (c) 2015 tester. All rights reserved.
//

import UIKit

var btn : UIButton = UIButton(frame: CGRectMake(0, 0, 150, 40))
var lbl : UILabel = UILabel(frame: CGRectMake(0, 0, 500, 80))
var myColor = ColorSwitcher()
var screenPoints : CGRect = UIScreen.mainScreen().bounds
var score = 0
var lblscore : UILabel = UILabel(frame: CGRectMake(0, 0, 100, 40))

class ViewController: UIViewController,UIAlertViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btn.setTitle("Let's Start!", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.greenColor()
        btn.center = CGPointMake(screenPoints.width / 2, 300)
        btn.addTarget(self, action: "Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        lbl.text = "Which color of text is it?"
        lbl.textColor = UIColor.grayColor()
        lbl.center = CGPointMake(screenPoints.width / 2, 100)
        lbl.textAlignment = NSTextAlignment.Center
        lbl.font = UIFont(name: "Arial", size: 20)
        
        score = 0
        
        lblscore.text = "score: " + String(score)
        lblscore.center = CGPointMake(screenPoints.width / 2, 30)
        lblscore.textAlignment = NSTextAlignment.Center
        
        view.addSubview(btn)
        view.addSubview(lbl)
        view.addSubview(lblscore)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Clicked()
    {
        btn.hidden = true
        
        lbl.textColor = myColor.selectedColor
        lbl.text = myColor.selectedName.uppercaseString
        lbl.font = UIFont(name: "Arial", size: 40)
        //view.backgroundColor = myColor.selectedColor
        
        var btnWidth : CGFloat = screenPoints.width / CGFloat(myColor.colorsArray.count)
        var left : CGFloat = btnWidth / 2
        

        
        
        for var index=0; index < 9; ++index{
            var btn1 : UIButton = UIButton(frame: CGRectMake(0, 0, btnWidth, 30))
            btn1.backgroundColor = myColor.colorsArray[index]
            btn1.center = CGPointMake(left, screenPoints.height - 30)
            btn1.tag = index
            btn1.addTarget(self, action: "SubClick:", forControlEvents: UIControlEvents.TouchUpInside)
            left = left + btnWidth
            view.addSubview(btn1)
        }
        

        
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
    
    }
    func SubClick(sender: UIButton)
    {
        
        
        var iName : Int? = 0
        iName = find(myColor.colorsName, (lbl.text ?? "")) ?? 0
        
        //var iColor = find(myColor.colorsArray, sender.tag)
        
        if iName == sender.tag{
            
            lbl.textColor = myColor.selectedColor
            lbl.text = myColor.selectedName.uppercaseString
            
            
            score++
            
            //lblscore.text = "one"
        }
        else {
            
            
            let alertController = UIAlertController(title: "Oops! You missed it!", message:
                "You scored : " + String(score), preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "try again", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)

            
            
           
            score = 0
            
            
            /*
            var alert :UIAlertView = UIAlertView(title:nil , message: nil , delegate: self, cancelButtonTitle: "try again", otherButtonTitles: nil) as UIAlertView
            alert.show()
            score = 0
*/
            
        }
        lblscore.text = "score: " + String(score)
        
    }


}

class ColorSwitcher {
    var colorsArray = [UIColor.redColor(), UIColor.greenColor(), UIColor.yellowColor(), UIColor.grayColor(), UIColor.cyanColor(), UIColor.magentaColor(), UIColor.orangeColor(), UIColor.purpleColor(), UIColor.brownColor()]
    var colorsName = ["RED", "GREEN", "YELLOW", "GRAY", "CYAN", "MAGENTA", "ORANGE", "PURPLE", "BROWN"]
    var currIndex:Int = 0
    var currName:Int = 0
    
    var selectedColor: UIColor {
        changeColor()
        return self.colorsArray[currIndex]
    }
    
    var selectedName: String {
        changeName()
        return self.colorsName[currName]
    }
    
    func changeName(){
        do {
            currName = Int.random(0...8)
        } while (currName == currIndex)
    }
    
    func changeColor() {
//        if(currIndex == colorsArray.count - 1)
//        {
//            currIndex = 0
//        }
//        else{
//            currIndex++
//        }
          currIndex = Int.random(0...8)
    }
}

extension Range
    {
    var randomInt: Int
        {
        get
        {
            var offset = 0
            
            if (startIndex as Int) < 0   // allow negative ranges
            {
                offset = abs(startIndex as Int)
            }
            
            let mini = UInt32(startIndex as Int + offset)
            let maxi = UInt32(endIndex   as Int + offset)
            
            return Int(mini + arc4random_uniform(maxi - mini)) - offset
        }
    }
}
extension Int
    {
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}


