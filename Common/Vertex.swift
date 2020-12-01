//
//  Vertex.swift
//  CocoaOpenGL-Swift-macOS
//
//  Created by Eric Hovhannisyan on 12/1/20.
//

import Foundation
import GLKit

extension Collection {
    var size: Int {
        MemoryLayout<Element>.stride * count
    }
}

struct Vertex {
    var x: GLfloat
    var y: GLfloat
    var z: GLfloat
    
    init(x: GLfloat, y: GLfloat, z: GLfloat) {
        (self.x, self.y, self.z) = (x, y, z)
    }
}
