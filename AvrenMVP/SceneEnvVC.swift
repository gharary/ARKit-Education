//
//  SceneEnvVC.swift
//  AvrenDemo
//
//  Created by Mohammad Gharari on 7/20/20.
//  Copyright © 2020 Mohammad Gharari. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import SceneKit.ModelIO

class SceneEnvVC: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let modelScene = SCNScene(named:
                  "art.scnassets/ship.scn")!
        
        sceneView.scene = modelScene
        //addCar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
        
        
    }
    
    func addCar(x: Float = 0, y: Float = 0, z: Float = -0.5) {
        let name = "ship"//DNA_Smoother_Mesh"
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "scn") else { fatalError() }
        let mdlAsset = MDLAsset(url: url)
        let scene = SCNScene(mdlAsset: mdlAsset)
        //guard let carScene = SCNScene(named: "DNA_Smoother_Mesh.usdz") else { return }
        let carNode = SCNNode()
        let carSceneChildNodes = scene.rootNode.childNodes
            
        for childNode in carSceneChildNodes {
            carNode.addChildNode(childNode)
        }
            
        carNode.position = SCNVector3(x, y, z)
        carNode.scale = SCNVector3(0.5, 0.5, 0.5)
        sceneView.scene.rootNode.addChildNode(carNode)
    }
    
}
