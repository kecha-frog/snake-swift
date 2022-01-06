//
//  Apple.swift
//  snake-swift
//
//  Created by Ke4a on 06.01.2022.
//

import UIKit
import SpriteKit


class Apple: SKShapeNode{
    
    init(position: CGPoint) {
        super.init()
        
        // создаем яблоко(размер, цвет, позицию и тд)
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = .green
        strokeColor = .green
        lineWidth = 5
        
        self.position = position
        
        // включаем физику
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center: CGPoint(x: 5, y: 5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
