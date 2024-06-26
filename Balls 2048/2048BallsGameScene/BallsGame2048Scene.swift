import SwiftUI
import SpriteKit
import Foundation

class BallsGame2048Scene: SKScene, SKPhysicsContactDelegate {
    
    private var headerNode: HeaderSKNode!
    private var backgroundNode: SKSpriteNode!
    
    private var gameField: SKSpriteNode!
    
    private var dottedLineBallFallStart: SKSpriteNode!
    private var ballNode: SKSpriteNode!
    private var invisibleRect3: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 750, height: 1335)
        physicsWorld.contactDelegate = self
        initAllNodes()
        initObservers()
    }
    
    private func initObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleRestartGame), name: Notification.Name("RESTART_GAME_BALLS"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePauseGame), name: Notification.Name("PAUSE_GAME_BALLS"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleContinueGame), name: Notification.Name("CONTINUE_GAME_BALLS"), object: nil)
    }
    
    @objc private func handleRestartGame() {
        let newScene = BallsGame2048Scene()
        view?.presentScene(newScene)
    }
    
    @objc private func handlePauseGame() {
        isPaused = true
        NotificationCenter.default.post(name: Notification.Name("SHOW_PAUSE_VIEW"), object: nil)
    }
    
    @objc private func handleContinueGame() {
        isPaused = false
    }
    
    private func initAllNodes() {
        initBackgroundNode()
        initHeaderNode()
        initGameNodes()
        initGameBallsNodes()
    }
    
    private func initBackgroundNode() {
        backgroundNode = .init(imageNamed: "game_background_image")
        backgroundNode.size = size
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(backgroundNode)
    }
    
    private func initHeaderNode() {
        headerNode = HeaderSKNode(size: CGSize(width: size.width, height: 150))
        headerNode.position = CGPoint(x: 0, y: size.height - 270)
        addChild(headerNode)
    }
    
    private func initGameNodes() {
        gameField = .init(imageNamed: "game_field")
        gameField.position = CGPoint(x: size.width / 2, y: 520)
        gameField.size = CGSize(width: 700, height: 970)
        gameField.zPosition = 2
        addChild(gameField)
        
        let invisibleRect: SKSpriteNode = .init(color: .clear, size: CGSize(width: 45, height: 970))
        invisibleRect.position = CGPoint(x: 70, y: 520)
        invisibleRect.physicsBody = SKPhysicsBody(rectangleOf: invisibleRect.size)
        invisibleRect.physicsBody?.isDynamic = false
        invisibleRect.physicsBody?.affectedByGravity = false
        addChild(invisibleRect)
        
        let invisibleRect2: SKSpriteNode = .init(color: .clear, size: CGSize(width: 45, height: 970))
        invisibleRect2.position = CGPoint(x: size.width - 70, y: 520)
        invisibleRect2.physicsBody = SKPhysicsBody(rectangleOf: invisibleRect2.size)
        invisibleRect2.physicsBody?.isDynamic = false
        invisibleRect2.physicsBody?.affectedByGravity = false
        addChild(invisibleRect2)
        
        invisibleRect3 = .init(color: .clear, size: CGSize(width: 620, height: 45))
        invisibleRect3.position = CGPoint(x: size.width / 2, y: 70)
        invisibleRect3.physicsBody = SKPhysicsBody(rectangleOf: invisibleRect3.size)
        invisibleRect3.physicsBody?.isDynamic = false
        invisibleRect3.zPosition = 3
        invisibleRect3.physicsBody?.affectedByGravity = false
        addChild(invisibleRect3)
        
        let invisibleRect4: SKSpriteNode = .init(color: .clear, size: CGSize(width: 620, height: 5))
        invisibleRect4.position = CGPoint(x: size.width / 2, y: 975)
        invisibleRect4.physicsBody = SKPhysicsBody(rectangleOf: invisibleRect3.size)
        invisibleRect4.physicsBody?.isDynamic = false
        invisibleRect4.physicsBody?.categoryBitMask = 2
        invisibleRect4.physicsBody?.collisionBitMask = 1
        invisibleRect4.physicsBody?.contactTestBitMask = 1
        invisibleRect4.zPosition = 3
        invisibleRect4.physicsBody?.affectedByGravity = false
        addChild(invisibleRect4)
    }
    
    private func initGameBallsNodes() {
        dottedLineBallFallStart = .init(imageNamed: "dotted_line")
        dottedLineBallFallStart.position = CGPoint(x: size.width / 2, y: size.height / 2 + 250)
        dottedLineBallFallStart.zPosition = 1
        dottedLineBallFallStart.size = CGSize(width: 600, height: 20)
        dottedLineBallFallStart.name = "dotted_line"
        addChild(dottedLineBallFallStart)
        
        createBallInLine()
    }
    
    private func createBallInLine() {
        let ball = ballsToSpawnInLine.randomElement() ?? ballsToSpawnInLine[0]
        ballNode = .init(imageNamed: ball)
        ballNode.position = CGPoint(x: size.width / 2, y: size.height / 2 + 260)
        ballNode.size = CGSize(width: ballNode.size.width / 2, height: ballNode.size.height / 2)
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: min(ballNode.size.height, ballNode.size.width) / 2)
        ballNode.physicsBody?.isDynamic = true
        ballNode.physicsBody?.affectedByGravity = false
        ballNode.name = ball
        ballNode.physicsBody?.categoryBitMask = 1
        ballNode.physicsBody?.collisionBitMask = 1
        ballNode.physicsBody?.contactTestBitMask = 1
        ballNode.zPosition = 2
        addChild(ballNode)
        
        let actionMove = SKAction.move(to: CGPoint(x: 120, y: ballNode.position.y), duration: 3)
        let actionMove2 = SKAction.move(to: CGPoint(x: size.width - 120, y: ballNode.position.y), duration: 3)
        let sequence = SKAction.sequence([actionMove, actionMove2])
        let repeate = SKAction.repeatForever(sequence)
        ballNode.run(repeate)
        
        touchedTheScreen = false
    }
    
    private func createBallInPosition(ball: String, pos: CGPoint) {
        ballNode = .init(imageNamed: ball)
        ballNode.position = pos
        ballNode.size = CGSize(width: ballNode.size.width / 2, height: ballNode.size.height / 2)
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: min(ballNode.size.height, ballNode.size.width) / 2)
        ballNode.physicsBody?.isDynamic = true
        ballNode.physicsBody?.affectedByGravity = true
        ballNode.name = ball
        ballNode.physicsBody?.categoryBitMask = 1
        ballNode.physicsBody?.collisionBitMask = 1
        ballNode.physicsBody?.contactTestBitMask = 1
        ballNode.zPosition = 2
        addChild(ballNode)
    }
    
    private var touchedTheScreen = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !touchedTheScreen {
            ballNode.removeAllActions()
            ballNode.physicsBody?.affectedByGravity = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.createBallInLine()
            }
            touchedTheScreen = true
            print("ball \(ballNode.name)")
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 1 {
            let nameA = bodyA.node?.name
            let nameB = bodyB.node?.name
            if nameA != nil && nameB != nil {
                if nameA == nameB {
                   let nextBall = getNextBallLevel(currentBall: nameA!)
                   if let nextBall = nextBall {
                       let addScore = ballValues[nextBall]!
                       headerNode.score += addScore
                       createBallInPosition(ball: nextBall, pos: bodyA.node!.position)
                       bodyA.node!.removeFromParent()
                       bodyB.node!.removeFromParent()
                   }
               }
            }
        }
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 {
            // game over
            invisibleRect3.physicsBody = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                NotificationCenter.default.post(name: Notification.Name("GAME_OVER_BALLS"), object: nil)
            }
            let bestScore = UserDefaults.standard.integer(forKey: "best_score")
            if headerNode.score > bestScore {
                UserDefaults.standard.set(headerNode.score, forKey: "best_score")
            }
        }
    }
    
    private func getNextBallLevel(currentBall: String) -> String? {
        let comps = currentBall.components(separatedBy: "_")
        let currentNum = Int(comps[1])!
        if currentNum < 12 {
            return "ball_\(currentNum + 1)"
        }
        return nil
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: BallsGame2048Scene())
            .ignoresSafeArea()
    }
}
