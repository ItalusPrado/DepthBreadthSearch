//
//  GameViewController.swift
//  DepthBreadthSearch
//
//  Created by Italus Rodrigues do Prado on 21/09/17.
//  Copyright © 2017 Italus Rodrigues do Prado. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var frontView: UIView!
    
    let searchs : [Searchs] = [.Breadth,.Depth,/*.UniformCost*/]
    let problems : [Problems] = [.Romenia,.VacuumCleaner]
    let cities : [Romenia] = [.Oradea,.Zerind,.Arad,.Timisoara,.Lugoj,.Mehadia,.Dobreta,.Craiova,.Rimnicu_Vilcea,.Sibiu,.Fagaras,.Pitesti,.Bucharest,.Giurgiu,.Urziceni,.Hirsova,.Eforie,.Vaslui,.Iasi,.Neamt]
    let vacuum: [Vacuum] = [.RDD,.RDC,.RCD,.RCC,.LDD,.LDC,.LCD,.LCC]
    
    var scene = GameScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                self.scene = sceneNode
                // Copy gameplay related content over to the scene
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        
        // Picker View
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    
    // Uibutton
    @IBAction func returnToMenu(_ sender: Any) {
        self.frontView.isHidden = false
        self.scene.hiddenAll()
    }
    
    @IBAction func startProblem(_ sender: UIButton) {
        self.frontView.isHidden = true
        if self.pickerView.selectedRow(inComponent: 0) == 0{
            startCityProblem()
            self.scene.showPathForCity()
        } else {
            startVacuumProblem()
            self.scene.showPathForVacuum()
        }
        
    }
    
    func startVacuumProblem(){
        let problem = BlindSearch(searchType: self.searchs[self.pickerView.selectedRow(inComponent: 3)].rawValue, start: self.vacuum[self.pickerView.selectedRow(inComponent: 1)].rawValue, end: self.vacuum[self.pickerView.selectedRow(inComponent: 2)].rawValue, problem: self.problems[self.pickerView.selectedRow(inComponent: 0)].rawValue)
        
        problem.searchPath()
        self.scene.camera?.position.y = (self.scene.childNode(withName: "backVacuum")?.position.y)!
        self.scene.path = problem.path.reversed()
    }
    
    func startCityProblem(){
        let problem = BlindSearch(searchType: self.searchs[self.pickerView.selectedRow(inComponent: 3)].rawValue, start: self.cities[self.pickerView.selectedRow(inComponent: 1)].rawValue, end: self.cities[self.pickerView.selectedRow(inComponent: 2)].rawValue, problem: self.problems[self.pickerView.selectedRow(inComponent: 0)].rawValue)
        
        problem.searchPath()
        self.scene.camera?.position.y = (self.scene.childNode(withName: "backCity")?.position.y)!
        self.scene.path = problem.path.reversed()
    }
    
    // Picker View Functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return problems.count
        }
        
        if component == 3 {
            return searchs.count
        }
        if self.pickerView.selectedRow(inComponent: 0) == 0 {
            return cities.count
        } else {
            return vacuum.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0{
            return problems[row].rawValue
        } else if component == 3{
            return self.searchs[row].rawValue
        } else if pickerView.selectedRow(inComponent: 0) == 0 && (component == 1 || component == 2){
            return cities[row].rawValue
        } else {
            return vacuum[row].rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0{
            print("mudando")
            self.pickerView.reloadAllComponents()
        }
        
    }
    
    // SpriteKit functions

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
