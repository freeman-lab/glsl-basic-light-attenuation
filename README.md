# glsl-scene-light-attenuation

GLSL function for computing light attenuation in scenes. Designed for use as a shader component with [`glslify`](https://github.com/stackgl/glslify) and [`glsl-scene-light`](https://github.com/freeman-lab/glsl-scene-light).

## install

To make avaialble in your project

```javascript
npm install glsl-scene-light-attenuation --save
```

## example

Define a light in your shader

```glsl
pragma glslify: SceneLight = require('glsl-scene-light')
uniform SceneLight light;
```

Then use this function alongside `glsl-scene-light-direction` to compute attenuation

```glsl
pragma glslify: attenuation = require('glsl-scene-light-attenuation')
pragma glslify: direction = require('glsl-scene-light-direction')

vec3 dir = direction(light, position);
float attn = attenuation(light, dir);
```

# algorithm

Standard methods are used to compute attenuation treating the light as either point, directional, or spot, depending on its properties. For a good overview, see this [tutorial](http://www.tomdalling.com/blog/modern-opengl/07-more-lighting-ambient-specular-attenuation-gamma/).

The primary parameter of the light is the `position`, a `vec4` in homogenous coordinates. The fourth element determines whether the light is directional or not. 

- If the fourth element is `0.0`, it will produce directional light, and attenuation is 1.0.
- If the fourth element is `1.0`, it will be treated as a point light source, and attenuation will falloff as governed by the `attenuation` parameter. 

For point light sources, the parameters `target` and `cutoff` can additionally be used to create a spot light, i.e. light restricted to a cone, where `target` is where cone is pointing and `cutoff` is the angular direction. If `cutoff` is `180` there will be no restriction.

# API

#### `attenuation(light, direction)`

Parameters
- `light` : `struct` instance of [`glsl-scene-light`](https://github.com/freeman-lab/glsl-scene-light)
- `direction` : `vec3` direction of the light

Returns
- `float` the computed color intensity for the material
