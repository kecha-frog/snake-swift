//
//  snake.swift
//  snake-swift
//
//  Created by Ke4a on 06.01.2022.
//

import UIKit
import SpriteKit



// общий класс змеи
class Snake:SKShapeNode{
    // тело змеи
    var body = [SnakeBodyPart]()
    let moveSpeed:CGFloat = 100.0
    var angle:CGFloat = 0.0
    
    init(atPoint point:CGPoint){
        super.init()
        // экземпляр головы
        let head = SnakeHead(atPoint: point)
        body.append(head)
        // добавляем
        addChild(head)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBody(){
        // экземпляр тела
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body[body.count - 1].position.x, y: body[body.count - 1].position.y))
        body.append(newBodyPart)
        addChild(newBodyPart)
        
        // Меняет цвет на цвет скушанного яблока для каждой части тела
        let color = Apple.color
        for snakeBody in body {
            let snakeBodyPart = childNode(withName: snakeBody.name!) as! SKShapeNode
            snakeBodyPart.fillColor = color
            snakeBody.strokeColor = color
        }
    }
    
    // Передвижение тела
    func move() {
        guard !body.isEmpty else {return}
        let head = body[0]
        //  передвигаем голову
        moveHead(head)
        
        // Проходим по всему тему
        for index in (1..<body.count) {
            //  получаем текущую или предыдущую
            let previousBodypart = body[index - 1]
            let currentBodyPart = body[index]
            //  передвигаем тело
            moveBodyPart(previousBodypart, c: currentBodyPart)
        }
    }
    
    // расчитываем куда должна переместиться змея
    func moveHead(_ head:SnakeBodyPart) {
        // вычисляем новое положение
        let dX = moveSpeed * sin(angle)
        let dY = moveSpeed * cos(angle)
    
        // вычисляем след.позицию от того положения где она уже находится
        let nextPosition = CGPoint(x: head.position.x + dX, y: head.position.y + dY)
        // движение
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        head.run(moveAction)
    }
    
    // передача координат предыдущему участку тела
    func moveBodyPart(_ p: SnakeBodyPart, c: SnakeBodyPart){
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: 0.1)
        c.run(moveAction)
    }
    
    // повороты змейки
    func moveClockwise(){
        angle += CGFloat(Double.pi / 2)
    }
    func moveCounterClockwise(){
        angle -= CGFloat(Double.pi / 2)
    }
}
