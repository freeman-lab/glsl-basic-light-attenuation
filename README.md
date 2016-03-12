# glsl-light-attenuation

GLSL function for computing light attenuation. Designed for use as a shader component with [`glslify`](https://github.com/stackgl/glslify) and [`glsl-light`](https://github.com/freeman-lab/glsl-light).

## install

To make avaialble in your project

```javascript
npm install glsl-light-attenuation --save
```

## example

Define a light in your shader

```glsl
pragma glslify: Light = require('glsl-light')
uniform Light light;
```

Then use this function alongside `glsl-light-direction` to compute attenuation

```glsl
pragma glslify: attenuation = require('glsl-light-attenuation')
pragma glslify: direction = require('glsl-light-direction')

vec3 dir = direction(light, position);
float attn = attenuation(light, dir);
```

# algorithm

Attenuation is computed treating the light as either point or directional depending on its properties. For a good overview, see this [tutorial](http://www.tomdalling.com/blog/modern-opengl/07-more-lighting-ambient-specular-attenuation-gamma/).

The primary parameter of the light is the `position`, a `vec4` in homogenous coordinates. The fourth element determines whether the light is directional or not. 

- If the fourth element is `0.0`, it will produce directional light, and attenuation is 1.0.
- If the fourth element is `1.0`, it will be treated as a point light source, and attenuation will falloff as governed by the `radius` parameter, with the function `pow(clamp(1.0 - distance / radius, 0.0, 1.0), 2.0)`.

# API

#### `attenuation(light, direction)`

Parameters
- `light` : `struct` instance of [`glsl-scene-light`](https://github.com/freeman-lab/glsl-scene-light)
- `direction` : `vec3` direction of the light

Returns
- `float` the computed color intensity for the material
