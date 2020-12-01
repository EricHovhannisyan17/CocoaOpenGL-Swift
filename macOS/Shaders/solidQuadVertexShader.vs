#version 150

uniform mat4 projectionMatrix;
uniform mat4 modelviewMatrix;

in vec3 vertexPosition;

void main() {
    gl_Position = (projectionMatrix * modelviewMatrix) * vec4(vertexPosition, 1.0);
}

