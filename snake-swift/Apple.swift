//
//  Apple.swift
//  snake-swift
//
//  Created by Ke4a on 06.01.2022.
//

import UIKit
import SpriteKit

// Расширение для рандомного цвета
extension UIColor {
    class var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}

class Apple: SKShapeNode{
    // Cчетчик
    static var countInit: Int = 0
    // Цвет яблока
    static var color: UIColor = .random
    
    init(position: CGPoint) {
        Apple.countInit += 1
        Apple.color = .random
        super.init()
        // создаем яблоко(размер, цвет, позицию и тд)
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 14, height: 14)).cgPath
        fillColor = Apple.color
        strokeColor = .white
        lineWidth = 1
        
        self.position = position
        
        // включаем физику
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center: CGPoint(x: 5, y: 5))
        self.physicsBody?.categoryBitMask = CollisionCategories.Apple
        // даем название яблоку
        self.name = "apple"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
