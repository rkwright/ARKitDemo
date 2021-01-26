//
//  ViewController.swift
//  ARKitDemo
//
//  Created by rkwright on 1/26/21.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // just go with the defaults
        sceneView.autoenablesDefaultLighting = true

        // a la Star Trek and the cosmic flypaper
        addBox()
    }

    /**
     * Simple cube
     */
    func addBox() {
        let box = SCNBox(width: 0.025, height: 0.025, length: 0.025, chamferRadius: 0)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(0, 0, -0.0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        box.materials = [material]
        
        rotateObject(rotation: 0.5, planet: boxNode, duration: 0.25)
            
        let scene = SCNScene()
        scene.rootNode.addChildNode(boxNode)
        sceneView.scene = scene
    }
    
    /**
     * Spin it in three axes, just for fun
     */
    func rotateObject(rotation: Float, planet: SCNNode, duration: Float){
        let rotation = SCNAction.rotateBy(x:CGFloat(rotation),y:CGFloat(rotation),z:CGFloat(rotation), duration: TimeInterval(duration))
        planet.runAction(SCNAction.repeatForever(rotation))
    }
    
    /**
     * Session management
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}

