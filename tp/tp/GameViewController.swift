//
//  GameViewController.swift
//  tp
//
//  Created by tester on 13/04/15.
//  Copyright (c) 2015 tester. All rights reserved.
//

import UIKit
import SpriteKit

var scene: GameScene!
var timer = NSTimer()


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("doTick:"), userInfo: nil, repeats: true)
        
        // Configure the view.
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        // Present the scene.
        skView.presentScene(scene)
        
    }
    
    @IBOutlet weak var TimerLabel: UILabel!
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func doTick(timer: NSTimer){
        
        if(scene.restarted){
            TimerLabel.hidden = false
        }
        
        
        println(String(scene.counter))
        TimerLabel.text = String(scene.counter--)
        if (scene.counter <= 0){
            scene.counter = 10
            //timer.invalidate()
            TimerLabel.hidden = true
            scene.GameOver()
        }
        
        
//        else{
//            counter = 10
//            timer.invalidate()
//            scene.GameOver()            
//        }
        
    }
    
}
