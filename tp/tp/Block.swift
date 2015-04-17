//
//  Block.swift
//  tp
//
//  Created by tester on 13/04/15.
//  Copyright (c) 2015 tester. All rights reserved.
//

import SpriteKit

enum BlockColor: Int {
    case White = 0, Black
}

class Block {
    
    // #3
    // Properties
    var column: Int
    var row: Int
    let blockColor: BlockColor
    var sprite: SKSpriteNode?
    
    init(column:Int, row:Int, blockColor:BlockColor) {
        self.column = column
        self.row = row
        self.blockColor = blockColor
    }
}
