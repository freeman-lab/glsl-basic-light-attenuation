#pragma glslify: Light = require('glsl-light')

float calcLightAttenuation(Light light, vec3 direction) {
	float attenuation;
	float angle;

	if (light.position.w == 0.0) {
		attenuation = 1.0;
	} else {
		attenuation = pow(clamp(1.0 - length(direction) / light.radius, 0.0, 1.0), 2.0);
	}

	return attenuation;
}

#pragma glslify: export(calcLightAttenuation)