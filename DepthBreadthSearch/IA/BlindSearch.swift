//
//  BlindSearch.swift
//  DepthBreadthSearch
//
//  Created by Italus Rodrigues do Prado on 21/09/17.
//  Copyright © 2017 Italus Rodrigues do Prado. All rights reserved.
//

import UIKit

class BlindSearch: NSObject {

    var search: String
    var problem: String
    var start: String
    var end: String
    
    var board = [Node]()
    var path = [String]()
    var archiveManager = ArchiveManager()
    
    init(searchType search: String, start: String, end: String, problem: String) {
        self.search = search
        self.problem = problem
        self.start = start
        self.end = end
        
        if self.problem == Problems.Romenia.rawValue{
            self.archiveManager.splitText(text:self.archiveManager.readText(fileName: "cidades")!)
        } else {
            self.archiveManager.splitText(text:self.archiveManager.readText(fileName: "asppo")!)
        }
        
    }
    
    func searchPath(){
        var currentNode: Node
        
        if self.board.isEmpty{
            currentNode = Node(withState: start)
            addToBorder(withNodes: [currentNode])
        } else {
            currentNode = removeFromBoard()
        }
        
        if currentNode.getState() == self.end{
            createPath(withNode: currentNode)
        } else {
            createSuccessor(withNode: currentNode)
            searchPath()
        }
    }
    
    private func createPath(withNode node: Node){
        var currentNode = node
        
        self.path.append(node.getState())
        
        while currentNode.getParent() != nil {
            currentNode = currentNode.getParent()!
            self.path.append(currentNode.getState())
        }
        print(path)
    }
    
    private func addToBorder(withNodes nodes: [Node]){
        for node in nodes{
            self.board.append(node)
        }
    }
    
    private func removeFromBoard() -> Node{
        if self.search == Searchs.Breadth.rawValue {
            return self.board.removeFirst()
        } else {
            return self.board.removeLast()
        }
    }
    
    private func createSuccessor(withNode node: Node){
        print(node.getState())
        let states = archiveManager.returnStates(nodeState: node.getState())
        var array = [Node]()
        for state in states{
            if !wasVisited(currentNode: node, nextState: state){
                let nodeToAdd = Node(withState: state)
                nodeToAdd.setParent(withParent: node)
                array.append(nodeToAdd)
            }
            
        }
        addToBorder(withNodes: array)
    }
    
    private func wasVisited(currentNode: Node, nextState: String) -> Bool{
        var node = currentNode
        while node.getParent() != nil {
            if node.getState() == nextState{
                return true
            }
            node = node.getParent()!
        }
        return false
    }
    
}
