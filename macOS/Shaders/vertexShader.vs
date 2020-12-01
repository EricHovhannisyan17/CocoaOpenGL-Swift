#version 150

uniform mat4 projectionMatrix;
uniform mat4 modelviewMatrix;

in vec3 vertexPosition;
in vec4 colorIn;

out vec4 color;

void main() {
    color = colorIn;
    gl_Position = (projectionMatrix * modelviewMatrix) * vec4(vertexPosition, 1.0);
}
