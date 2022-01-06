//
//  snakeHead.swift
//  snake-swift
//
//  Created by Ke4a on 06.01.2022.
//

import UIKit

// создаем голову из класса тела
class SnakeHead:SnakeBodyPart{
    override init(atPoint point:CGPoint){
        super.init(atPoint: point)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
