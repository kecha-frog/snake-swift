//
//  GameScene.swift
//  snake-swift
//
//  Created by Ke4a on 06.01.2022.
//

import SpriteKit
import GameplayKit

//сдвиг числа
struct CollisionCategories{
    static let Snake:UInt32 = 0x1 << 0 //001 2
    static let SnakeHead:UInt32 = 0x1 << 1 //0010 4
    static let Apple:UInt32 = 0x1 << 2 // 0100 8
    static let EdgeBody:UInt32 = 0x1 << 3 // 1000 16
}

class GameScene: SKScene {
    
    // переменная под экземпляр змеи
    var snake:Snake?
    
    // Счётчик
    var scoreLabel: SKLabelNode?
    var score: Int {
        get {
        return Apple.countInit - 1
    }}
    
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
        
        // Добавляю счет
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel!.text = "Score: \(score)"
        scoreLabel!.position = CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.minY + 40)
        addChild(scoreLabel!)
        
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
        
        // с чем может контактировать
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
        
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
            
            //В нажатом состоянии
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
        
        // Обновляю счет игры
        scoreLabel!.text = "Score: \(score)"
    }
    
    // Рестарт игры
    func restart(){
        Apple.countInit = 0
        createApple()
        snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
        self.addChild(snake!)
    }
}


extension GameScene:SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Логическая суммуа на примере головы и яблока
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask // 12
        
        let collisionObject = bodyes - CollisionCategories.SnakeHead //12-4 = 8
        
        switch collisionObject{
        case CollisionCategories.Apple:// 8
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake!.addBody()
            apple?.removeFromParent()
            createApple()
            // TODO:  ДЗ
        case CollisionCategories.EdgeBody:
            // удаляем змею
            snake?.removeFromParent()
            // удаляем яблоко
            let apple = self.childNode(withName: "apple")
            apple?.removeFromParent()
            
            // Алерт
            let alert = UIAlertController(title: "SCORE: \(score)", message: "restart ?", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Ok", style: .default) { action in
                self.restart()
            }
            alert.addAction(action)
            
            if let vc = self.scene?.view?.window?.rootViewController {
                vc.present(alert, animated: true, completion: nil)
            }
        default:
            break
        }
    }
}
