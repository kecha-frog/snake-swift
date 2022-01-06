//
//  GameScene.swift
//  snake-swift
//
//  Created by Ke4a on 06.01.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // переменная под экземпляр змеи
    var snake:Snake?
    
    override func didMove(to view: SKView) {
        // создаем фон
        backgroundColor = SKColor.purple
        // создаем физику
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        // показ физики
        view.showsPhysics = true
        
        //создаем кнопку
        let counterClockwiseButton = SKShapeNode()
        // размер кнопки
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45 )).cgPath
        // позиция кнопки
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        // настройка кнопки и рамки
        counterClockwiseButton.fillColor = UIColor.gray
        counterClockwiseButton.strokeColor = UIColor.gray
        counterClockwiseButton.lineWidth = 10
        // задаем название кнопки для обращения
        counterClockwiseButton.name = "counterClockwiseButton"
        // добавление кнопки на сцену
        self.addChild(counterClockwiseButton)
        
        //создаем кнопку2
        let сlockwiseButton = SKShapeNode()
        сlockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45 )).cgPath
        сlockwiseButton.position = CGPoint(x: view.scene!.frame.maxX - 75, y: view.scene!.frame.minY + 30)
        сlockwiseButton.fillColor = .gray
        сlockwiseButton.strokeColor = .gray
        сlockwiseButton.lineWidth = 10
        сlockwiseButton.name = "сlockwiseButton"
        self.addChild(сlockwiseButton)
        
        // создаем яблоко
        createApple()
        // создаем экземпляр змеи по середине сцены
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        // добавляем змею
        self.addChild(snake!)
        
        // Включаем столкновения
        self.physicsWorld.contactDelegate = self
        
        
    }
    
    // нажали
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // Получаем данные координату тача
            let touchLocation = touch.location(in: self)
            // проверяем есть ли созданный нами элемент на координате
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockwiseButton" || touchNode.name == "сlockwiseButton" else{
                return
            }
            
            touchNode.fillColor = .red
            
            // Подключаем функции поворота
            if touchNode.name == "counterClockwiseButton"{
                snake!.moveCounterClockwise()
            }else if touchNode.name == "сlockwiseButton"{
                snake!.moveClockwise()
            }
        }
    }
    
    // отпустили
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockwiseButton" || touchNode.name == "сlockwiseButton" else{
                return
            }
            
            touchNode.fillColor = .gray
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // запускам змейку
        snake!.move()
    }
    
    func createApple(){
        //рандомное число ограниченое размером сцены - 10
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 10)))
        let randy = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 10)))
        
        let apple = Apple(position: CGPoint(x: randX, y: randy))
        
        // добавляем на сцену
        self.addChild(apple)
    }
}


extension GameScene:SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
