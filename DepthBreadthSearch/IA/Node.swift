//
//  Node.swift
//  DepthBreadthSearch
//
//  Created by Italus Rodrigues do Prado on 21/09/17.
//  Copyright © 2017 Italus Rodrigues do Prado. All rights reserved.
//

import UIKit

class Node: NSObject {

    private var state: String
    private var successors = [Node]()
    private var parent: Node?
    
    init(withState state: String) {
        self.state = state
    }
    
    func setSuccessors(withStates states: [String]) {
        for name in states{
            let node = Node(withState: name)
            self.successors.append(node)
        }
    }
    
    func getState() -> String{
        return self.state
    }
    
    func getSucessors() -> [Node]{
        return successors
    }
    
    func setParent(withParent parent: Node){
        self.parent = parent
    }
    
    func getParent() -> Node?{
        if let parent = self.parent{
            return parent
        } else {
            return nil
        }
    }
}
