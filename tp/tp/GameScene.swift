//
//  GameScene.swift
//  tp
//
//  Created by tester on 13/04/15.
//  Copyright (c) 2015 tester. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
   
    var blockWidth = CGFloat(0.0)
    var blockHeight = CGFloat(0.0)
    var score = 0
    var timer = NSTimer()
    var counter = 10
    var restarted = false
    override func didMoveToView(view: SKView) {
        self.scaleMode = .ResizeFill
        
        initializeValues()
    
       
        
        // Draw the board
        drawBoard()
    }
    
  
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */       
        
    }
    
    func initializeValues(){
        self.removeAllChildren()
        score = 0
        blockHeight = CGFloat(0.0)
        blockWidth = CGFloat(0.0)
    }
    
      
    required init(coder aDecoder : NSCoder)
    {
        fatalError("NSCoder not supported!")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    func drawBoard() {
        // Board parameters
        let numRows = 4
        let numCols = 4
        
        blockWidth = (CGRectGetWidth(self.frame) / 4)-1
        blockHeight = (CGRectGetHeight(self.frame) / 4)-1
        
        let squareSize = CGSizeMake(blockWidth, blockHeight)
        let xOffset:CGFloat = CGRectGetWidth(self.frame) / 8
        let yOffset:CGFloat = CGRectGetHeight(self.frame) / 8
        // Column characters
        let alphas:String = "abcd"
        
        for row in 0...numRows-1 {
            var cIndex:Int = Int(arc4random_uniform(4))
            let rowChar = Array(alphas)[row]
            for col in 0...numCols-1 {
                
                // Determine the color of square
                let color = (cIndex != col) ? SKColor.whiteColor() : SKColor.blackColor()
                
                let colorName = (cIndex != col) ? "w" : "l"
                
                let square = SKSpriteNode(color: color, size: squareSize)
                
                square.position = CGPointMake(CGFloat(col) * (squareSize.width + 1) + xOffset,
                    CGFloat(row) * (squareSize.height + 1) + yOffset)
                // Set sprite's name (e.g., a1, c3, d1)
                //square.name = "\(colChar)\(4-row)"
                square.name = "\(rowChar)\(col)-\(colorName)"
                
                self.addChild(square)
                
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            var snode = self.nodesAtPoint(location).first as SKSpriteNode
            if(location.y < blockHeight)
            {
                for node in self.nodesAtPoint(location) as [SKNode]{
                    if (node.name)!.rangeOfString("l") != nil{
                        ++score
                        for n in self.children as [SKNode]{
                            if (n.name!.substringToIndex(advance(n.name!.startIndex,1)) == node.name!.substringToIndex(advance(node.name!.startIndex,1))){
                                self.removeChildrenInArray([n])
                            }
                            else
                            {
                                n.position = CGPointMake(n.position.x,n.position.y-blockHeight-1)
                            }
                        }
                        
                        var c : String = node.name!.substringToIndex(advance(node.name!.startIndex,1))
                        AddNewRow(c, numCols:4)
                    }
                    else{
                        snode.color = SKColor.redColor()
                        GameOver()
                    }
                }
            }
            else{
                snode.color = SKColor.redColor()
                GameOver()
            }
            
        }
    }
    
    func GameOver()
    {
        let restartHandler = { (action: UIAlertAction!) -> Void in
            self.Restart()
        }
        
        let alert = UIAlertController(title: "Game Over", message: "You Scored:" + String(score), preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Try Again!", style: UIAlertActionStyle.Default, handler: restartHandler))
        //alert.addAction(UIAlertAction(title: "No Mood!", style: UIAlertActionStyle.Default) { action -> Void in
            
        //    })
        
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    func Restart()
    {
        
        let gameScene = GameScene(size: self.size)
        self.view!.presentScene(gameScene)
        
        restarted = true
        counter = 10
        
    }
    
//    func doTick(timer: NSTimer){
//        println(String(1))
//        
//    }
    
    func AddNewRow(rowChar:String, numCols:Int)
    {
        var cIndex:Int = Int(arc4random_uniform(4))
        let squareSize = CGSizeMake(blockWidth, blockHeight)
        let xOffset:CGFloat = CGRectGetWidth(self.frame) / 8
        let yOffset:CGFloat = CGRectGetHeight(self.frame) / 8
        
        for col in 0...numCols-1 {
            
            // Letter for this column
            
            
            // Determine the color of square
            let color = (cIndex != col) ? SKColor.whiteColor() : SKColor.blackColor()
            
            let colorName = (cIndex != col) ? "w" : "l"
            
            let square = SKSpriteNode(color: color, size: squareSize)
            
            square.position = CGPointMake(CGFloat(col) * (squareSize.width + 1) + xOffset, (yOffset*7))
            // Set sprite's name (e.g., a1, c3, d1)
            //square.name = "\(colChar)\(4-row)"
            square.name = "\(rowChar)\(col)-\(colorName)"
            
            self.addChild(square)
            
        }
    }
}
