//
//  SnakeBodyPart.swift
//  snake-swift
//
//  Created by Ke4a on 06.01.2022.
//

import UIKit
import SpriteKit

// создаем класс тела змеи
class SnakeBodyPart: SKShapeNode{
    static var count = 0
    
    // размер змеи
    let diametr = 10.0
    
    init(atPoint point:CGPoint){
        SnakeBodyPart.count += 1
        super.init()
        
        // настройка змеи
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        fillColor = .random
        strokeColor = fillColor
        lineWidth = 5
        
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr - 4), center:  CGPoint(x: 5, y: 5))
        // физика передвигается
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        // C чем может контактировать
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple
        // Даем название части тела чтоб потом найти по чилдренам для перекраски
        self.name = "snakePart" + String(SnakeBodyPart.count)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
