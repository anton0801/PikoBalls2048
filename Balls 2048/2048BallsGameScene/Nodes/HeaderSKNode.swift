import Foundation
import SpriteKit

class HeaderSKNode: SKSpriteNode {
    
    private var pauseNode: SKSpriteNode!
    private var restartNode: SKSpriteNode!
    private var scoreLabel: SKLabelNode!
    private var scoreLabelShadow: SKLabelNode!
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
            scoreLabelShadow.text = "\(score)"
        }
    }
    
    init(size: CGSize) {
        pauseNode = .init(imageNamed: "pause_game")
        pauseNode.position = CGPoint(x: 120, y: 120)
        pauseNode.size = CGSize(width: 160, height: 135)
        
        restartNode = .init(imageNamed: "restart_game")
        restartNode.position = CGPoint(x: 320, y: 120)
        restartNode.size = CGSize(width: 160, height: 135)
        
        let scoreBack: SKSpriteNode = .init(imageNamed: "score_back")
        scoreBack.position = CGPoint(x: 580, y: 120)
        scoreBack.size = CGSize(width: 300, height: 135)
        
        scoreLabel = .init(text: "0")
        scoreLabel.fontName = "PalanquinDark-SemiBold"
        scoreLabel.fontSize = 62
        scoreLabel.zPosition = 2
        scoreLabel.fontColor = UIColor.init(red: 202/255, green: 53/255, blue: 1, alpha: 1)
        scoreLabel.position = CGPoint(x: 580, y: 80)
        
        scoreLabelShadow = .init(text: "0")
        scoreLabelShadow.fontName = "PalanquinDark-SemiBold"
        scoreLabelShadow.fontSize = 70
        scoreLabelShadow.zPosition = 1
        scoreLabelShadow.fontColor = .white
        scoreLabelShadow.position = CGPoint(x: 580, y: 78)
        
        super.init(texture: nil, color: .clear, size: size)
        addChild(pauseNode)
        addChild(restartNode)
        addChild(scoreBack)
        addChild(scoreLabel)
        addChild(scoreLabelShadow)
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let nodes = nodes(at: touch.location(in: self))
            guard !nodes.contains(restartNode) else {
                NotificationCenter.default.post(name: Notification.Name("RESTART_GAME_BALLS"), object: nil)
                return
            }
            guard !nodes.contains(pauseNode) else {
                NotificationCenter.default.post(name: Notification.Name("PAUSE_GAME_BALLS"), object: nil)
                return
            }
        }
    }
    
}
