//
//  ViewController.swift
//  AvrenMVP
//
//  Created by Mohammad Gharari on 7/19/20.
//  Copyright © 2020 Mohammad Gharari. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation



class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        print(AVCapturePhotoOutput.init().isCameraCalibrationDataDeliverySupported)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()

        if let trackImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            
            configuration.trackingImages = trackImages
            configuration.maximumNumberOfTrackedImages = 1
            
        }
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        /*
         
         
         let videoItem = AVPlayerItem(url: URL(fileURLWithPath: fileUrlString))
         let player = AVPlayer(playerItem: videoItem)
         
         
         let  videoNode = SKVideoNode(avPlayer: player)
         player.play()
         
         
         NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (notification) in
             player.seek(to: CMTime.zero)
             player.play()
             print("Looping video")
         }
         
         
         let videoScene = SKScene(size: CGSize(width: 1280, height: 720))
         
         videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
         
         videoNode.yScale = -1.0
         
         videoScene.addChild(videoNode)
         
         
         */
        
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        
        plane.firstMaterial?.diffuse.contents = setVideo()
        
        let planeNode = SCNNode(geometry: plane)
        
        planeNode.eulerAngles.x = -Float.pi / 2
        node.addChildNode(planeNode)
        
        
    }
    
    var videoPlayerNode: SKVideoNode?
    var videoPlayer: AVPlayer?
    
    func setVideo() -> SKScene{
        let size = CGSize(width: 1280, height: 720)
        let skScene = SKScene(size: size)

        let fileUrlString = Bundle.main.path(forResource: "dinosaur", ofType: "mp4")
        
        let videoItem = AVPlayerItem(url: URL(fileURLWithPath: fileUrlString!))
        videoPlayer = AVPlayer(playerItem: videoItem)
        

        skScene.scaleMode = .aspectFit

        videoPlayerNode = SKVideoNode(avPlayer: videoPlayer!)
        videoPlayerNode!.position = CGPoint(x: size.width/2, y: size.height/2)
        videoPlayerNode!.size = size
        videoPlayerNode!.yScale = -1
        skScene.addChild(videoPlayerNode!)

        videoPlayer!.play()

        return skScene
    }
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        sceneView.session.pause()

    }
 
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
