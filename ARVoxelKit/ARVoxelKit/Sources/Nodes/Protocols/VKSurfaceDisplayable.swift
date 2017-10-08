//
//  VKSurfaceDisplayable.swift
//  ARVoxelKit
//
//  Created by Vadym Sidorov on 10/7/17.
//  Copyright © 2017 Gleb Radchenko. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

public protocol VKSurfaceDisplayable: VKDisplayable {
    var position: SCNVector3 { get }
    var surfaceGeometry: SCNPlane {get }
}

extension VKSurfaceDisplayable where Self: VKPlatformNode {
    public var surfaceGeometry: SCNPlane {
        guard let surfaceGeometry = geometry as? SCNPlane else {
            fatalError("Geometry must be of SCNPlane type.")
        }
        
        return surfaceGeometry
    }
    
    func setupTransform() {
        self.eulerAngles = SCNVector3(Float.pi / 2.0, 0.0, 0.0)
    }
}

extension VKSurfaceDisplayable {
    
    func setupGeometry() {
        surfaceGeometry.firstMaterial = createSurfaceMaterial()
        surfaceGeometry.firstMaterial?.isDoubleSided = true
    }
    
    func createSurfaceMaterial() -> SCNMaterial {
        return SCNMaterial()
    }
    
    //TODO - should be computed property?
    public func surfaceMaterial() -> SCNMaterial {
        guard let material = surfaceGeometry.firstMaterial else {
            fatalError("Surface material is not set.")
        }
        
        return material
    }
    
    func updateSurfaceMaterial(with contents: AnyObject) {
        surfaceMaterial().diffuse.contents = contents
    }
    
    func updateSurfaceTransparency(with value: CGFloat) {
        surfaceMaterial().transparency = value
    }
}
