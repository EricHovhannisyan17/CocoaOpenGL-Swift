//
//  Triangle.swift
//  CocoaOpenGL-Swift-macOS
//
//  Created by Eric Hovhannisyan on 11/30/20.
//

import Foundation
import GLKit

class Triangle: Renderable {
    private var vertexArrayId: GLuint = 0
    private var bufferIds: [GLuint]
    
    private let vertices: [Vertex] = {
        return [
            Vertex(x: 1, y: -1, z: 0),
            Vertex(x: -1, y: 1, z: 0),
            Vertex(x: -1, y: -1, z: 0),
        ]
    }()
    
    private let colors: [Color] = {
        return [
            Color(r: 1, g: 0, b: 0, a: 1),
            Color(r: 0, g: 1, b: 0, a: 1),
            Color(r: 0, g: 0, b: 1, a: 1),
        ]
    }()

    init(program: ShaderProgram) {

        // Get the program's vertex data locations.
        let vertexPositionLocation = program.getAttributeLocation("vertexPosition")!
        let colorLocation = program.getAttributeLocation("colorIn")!

        // Create vertex array.
        glGenVertexArrays(1, &vertexArrayId)
        glBindVertexArray(vertexArrayId)

        // Create buffers.
        bufferIds = [GLuint](repeating: 0, count: 2)
        glGenBuffers(GLsizei(bufferIds.count), &bufferIds)

        // Create position buffer.
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), bufferIds[0])
        glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.size, vertices, GLenum(GL_STATIC_DRAW))

        // Create color buffer.
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), bufferIds[1])
        glBufferData(GLenum(GL_ARRAY_BUFFER), colors.size, colors, GLenum(GL_STATIC_DRAW))
        
        // Create position attribute array.
        glEnableVertexAttribArray(vertexPositionLocation)
        glVertexAttribPointer(vertexPositionLocation, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, nil)
        
        // Create colorIn attribute array.
        glEnableVertexAttribArray(colorLocation)
        glVertexAttribPointer(colorLocation, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, nil)
    }

    deinit {
        glDeleteBuffers(GLsizei(bufferIds.count), &bufferIds)
        glDeleteVertexArrays(1, &vertexArrayId)
    }

    func render() {
        glBindVertexArray(vertexArrayId)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, GLint(vertices.count))
    }
}
