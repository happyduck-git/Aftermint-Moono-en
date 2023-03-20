//
//  MoonoGameScene.swift
//  Aftermint
//
//  Created by Platfarm on 2023/03/17.
//

import SpriteKit

final class MoonoGameScene: SKScene {
    
    let vm: MoonoGameSceneViewModel = MoonoGameSceneViewModel()
    
    // MARK: - Nodes
    private var particles: SKEmitterNode?
    private var moonoImage: SKSpriteNode?
    
    //Actions
    private let touchFadeOut: SKAction = SKAction.fadeOut(withDuration: 0.1)
    private let touchFadeIn: SKAction = SKAction.fadeIn(withDuration: 0.1)
    
    // MARK: - Life cycle
    override func didMove(to view: SKView) { // Tells you when the scene is presented by a view.
        setUpScenery()
    }
    
    // MARK: - Set up
    private func showMoveParticles(touchPosition: CGPoint) {
        
        if particles == nil {
            particles = SKEmitterNode(fileNamed: GameSceneAsset.particles.rawValue)
            guard let particles = particles else { return }
            particles.zPosition = 1
            particles.targetNode = self
            addChild(particles)
        }
        
        particles?.position = touchPosition
        particles?.particleAction?.duration = 3.0 //TODO: Need to check
        moonoImage?.run(touchFadeOut, completion: {
            self.moonoImage?.run(self.touchFadeIn)
        })
        
    }
    
    private func setUpScenery() {
        moonoImage = SKSpriteNode(imageNamed: GameSceneAsset.moonoImage.rawValue)
        guard let moonoNode = moonoImage else { return }
        moonoNode.anchorPoint = CGPoint(x: 0, y: 0)
        moonoNode.position = CGPoint(x: 80, y: 370)
        moonoNode.zPosition = 0
        moonoNode.size = CGSize(width: 250, height: 250)
        addChild(moonoNode)
    }
    
    //MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        vm.increaseTouchCountByOne()
        particles?.removeFromParent()
        particles = nil
        
        for touch in touches {
            let startPoint = touch.location(in: self)
            showMoveParticles(touchPosition: startPoint)
        }
        
    }
    
}
