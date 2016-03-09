#pragma glslify: Light = require('glsl-light')

float calcLightAttenuation(Light light, vec3 direction) {
	float attenuation;
	float angle;

	if (light.position.w == 0.0) {
		attenuation = 1.0;
	} else {
		attenuation = 1.0 / (1.0 + light.attenuation * pow(length(direction), 2.0));
		angle = degrees(acos(dot(-normalize(direction), normalize(light.target - light.position.xyz))));
		if (angle > light.cutoff) {
       attenuation = 0.0;
    }
	}

	return attenuation;
}

#pragma glslify: export(calcLightAttenuation)