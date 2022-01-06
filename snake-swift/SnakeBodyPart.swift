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
    
    // размер змеи
    let diametr = 10.0
    
    init(atPoint point:CGPoint){
        super.init()
        
        // настройка змеи
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        fillColor = .red
        strokeColor = .red
        lineWidth = 5
        
        self.position = point
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
