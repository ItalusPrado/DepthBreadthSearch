//
//  ArchiveManager.swift
//  DepthBreadthSearch
//
//  Created by Italus Rodrigues do Prado on 21/09/17.
//  Copyright © 2017 Italus Rodrigues do Prado. All rights reserved.
//

import UIKit

class ArchiveManager: NSObject {
    
    var states = [String]()
    var successors = [[String]]()

    
    func returnStates(nodeState: String) -> [String]{
        var array = [String]()
        for (index,state) in self.states.enumerated(){
            if state == nodeState{
                array =  self.successors[index]
            }
        }
        return array
    }
    func readText(fileName: String) -> String?{
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                return data
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    func splitText(text: String){
        let myStrings = text.components(separatedBy: .newlines)
        for i in 0..<myStrings.count{
            let words = myStrings[i].components(separatedBy: ",")
            if words[0] != ""{
                var successorWords = [String]()
                self.states.append(words[0])
                for j in 1..<words.count{
                    successorWords.append(words[j])
                }
                self.successors.append(successorWords)
            }
        }
    }
}
