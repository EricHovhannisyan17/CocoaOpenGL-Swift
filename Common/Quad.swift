//
//  Quad.swift
//  CocoaOpenGL-Swift-macOS
//
//  Created by Eric Hovhannisyan on 12/1/20.
//

import Foundation
import GLKit

class Quad: Renderable {
    private var vertexArrayId: GLuint = 0
    private var bufferIds: [GLuint]
    
    private let vertices: [Vertex] = {
        return [
            Vertex(x: 1, y: -1, z: 0),
            Vertex(x: 1, y: 1, z: 0),
            Vertex(x: -1, y: -1, z: 0),
            Vertex(x: -1, y: 1, z: 0),
        ]
    }()

    init(program: ShaderProgram) {

        // Get the program's vertex data locations.
        let vertexPositionLocation = program.getAttributeLocation("vertexPosition")!

        // Create vertex array.
        glGenVertexArrays(1, &vertexArrayId)
        glBindVertexArray(vertexArrayId)

        // Create buffers.
        bufferIds = [GLuint](repeating: 0, count: 1)
        glGenBuffers(GLsizei(bufferIds.count), &bufferIds)

        // Create position buffer.
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), bufferIds[0])
        glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.size, vertices, GLenum(GL_STATIC_DRAW))

        // Create position attribute array.
        glEnableVertexAttribArray(vertexPositionLocation)
        glVertexAttribPointer(vertexPositionLocation, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, nil)
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
