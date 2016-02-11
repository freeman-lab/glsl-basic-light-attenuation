# glsl-basic-light-attenuation

GLSL function for computing light attenuation. Designed for use as a shader component with [`glslify`](https://github.com/stackgl/glslify) and [`glsl-basic-light`](https://github.com/stackgl/glslify).

## install

To make avaialble in your project

```javascript
npm install glsl-basic-light --save
```

## example

Define a light in your shader

```glsl
pragma glslify: BasicLight = require('glsl-basic-light')
uniform BasicLight light;
```

Then use this function alongside `glsl-basic-light-direction` to compute attenuation

```glsl
pragma glslify: BasicLightAttenuation = require('glsl-basic-light-attenuation')
pragma glslify: BasicLightDirection = require('glsl-basic-light-direction')

vec3 direction = BasicLightDirection(light, position);
float attenuation = BasicLightAttenuation(light, direction);
```

# algorithm

Standard methods are used to compute the contribution of each light souce as either point, directional, or spot, depending on the parameters. For a good overview, see this [tutorial](http://www.tomdalling.com/blog/modern-opengl/07-more-lighting-ambient-specular-attenuation-gamma/).

The primary parameter of the light is the `position`, a `vec4` in homogenous coordinates. The fourth element determines whether the light is directional or not. 

- If the fourth element is `0.0`, it will produce directional light, and the position vector will be treated as a direction. 
- If the fourth element is `1.0`, it will be treated as a point light source. 

For point light sources, the parameters `target` and `cutoff` can additionally be used to create a spot light, i.e. light restricted to a cone, where `target` is where cone is pointing and `cutoff` is the angular direction. If `cutoff` is `180` there will be no restriction.

# API

#### `BasicLightAttenuation(BasicLight light, vec3 direction)`

Parameters
- `light` : `struct` instance of [`glsl-basic-light`](https://github.com/freeman-lab/glsl-basic-light)
- `direction` : `vec3` direction of the light

Returns
- `vec3` the computed color intensity for the material
