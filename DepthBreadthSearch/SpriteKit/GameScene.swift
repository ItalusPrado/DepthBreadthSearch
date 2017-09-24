//
//  GameScene.swift
//  DepthBreadthSearch
//
//  Created by Italus Rodrigues do Prado on 21/09/17.
//  Copyright © 2017 Italus Rodrigues do Prado. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var path = [String]()
    
    override func sceneDidLoad() {
        self.hiddenAll()
    }
    
    func hiddenAll(){
        for node in self.children{
            if node.name != "backCity" && node.name != "backVacuum"{
                node.isHidden = true
            }
        }
    }
    
    func showPathForVacuum(){
        for point in 0..<path.count-1{
            let string = path[point]+path[point+1]
            let node = self.childNode(withName: string)
            node?.isHidden = false
        }
    }
    
    func showPathForCity(){
        for point in 0..<path.count-1{
            let string = path[point]+path[point+1]
            let node = self.childNode(withName: string)
            node?.isHidden = false
        }
        
        for point in stride(from: path.count-1, to: 0, by: -1){
            let string = path[point]+path[point-1]
            let node = self.childNode(withName: string)
            if node != nil {
                node!.isHidden = false
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
