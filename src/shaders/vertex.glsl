uniform float uSize;
uniform float uTime;

attribute float aScales;
attribute vec3 aRandomness;

varying vec3 vColor;

void main(){
    vec4 modelPosition= modelMatrix * vec4(position ,1.0);
    // modelPosition.y+=uTime;
    float angle=atan(modelPosition.x,modelPosition.z);
    float distanceToCenter=length(modelPosition.xz);
    float angleOffset=(1.0/distanceToCenter)*uTime*0.2;
    angle+=angleOffset;
    modelPosition.x=distanceToCenter*cos(angle);
    modelPosition.z=distanceToCenter*sin(angle);

    modelPosition.xyz+=aRandomness.xyz;

    vec4 viewPosition=viewMatrix * modelPosition;

    vec4 projectedPosition= projectionMatrix * viewPosition;

    gl_Position=projectedPosition;

    gl_PointSize=uSize * aScales;
    gl_PointSize *= ( 1.0 / - viewPosition.z );

    vColor=color;
}