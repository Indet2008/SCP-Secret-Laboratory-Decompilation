// Surface function for "Shader Graphs/AmnesticCloudDecal" (projector passes only).
// Reproduces the original shader graph: ring of radius R (thickness T) and a dithered radial gradient.

static const float AmnesticBayer[16] =
{
	1.0 / 17.0,  9.0 / 17.0,  3.0 / 17.0, 11.0 / 17.0,
	13.0 / 17.0, 5.0 / 17.0, 15.0 / 17.0,  7.0 / 17.0,
	4.0 / 17.0, 12.0 / 17.0,  2.0 / 17.0, 10.0 / 17.0,
	16.0 / 17.0, 8.0 / 17.0, 14.0 / 17.0,  6.0 / 17.0
};

float AmnesticCloudAlpha(float2 uv, float2 positionSS)
{
	float radius = _RadiusPercent;
	if (radius <= 1e-4)
	{
		return 0.0; // the original fades to zero here as well (pow(radius / min, 2.5))
	}
	float2 centered = uv * 2.0 - 1.0;

	float outerDist = length(centered / radius);
	float outer = saturate((1.0 - outerDist) / fwidth(outerDist));
	float innerDist = length(centered / (radius - _Thickness));
	float inner = saturate((1.0 - innerDist) / fwidth(innerDist));

	uint2 pix = uint2(positionSS) & 3u;
	float noise = 1.0 - 2.0 * AmnesticBayer[pix.x * 4u + pix.y];

	float invRadius = 1.0 / radius;
	float2 p = uv * invRadius + (0.5 - 0.5 * invRadius) + noise * 0.05 - 0.5;
	float gradient = saturate((sqrt(dot(p, p) + 0.5) - 0.76) * 1.0989011);

	float shape = inner * gradient + (outer - inner);
	float tex = SAMPLE_TEXTURE2D(_SampleTexture2D_191dc57fa34f4cb9857e460eee6a3d59_Texture_1_Texture2D,
		sampler_SampleTexture2D_191dc57fa34f4cb9857e460eee6a3d59_Texture_1_Texture2D, uv).r;

	float alpha = min(outer, max(max(_StatusPercent * tex - shape * 10.0, PositivePow(shape, _GradientPower)), 0.0));
	return alpha * min(PositivePow(radius / _MinPercent, 2.5), 1.0);
}

void GetSurfaceData(FragInputs input, float3 V, PositionInputs posInput, float angleFadeFactor, out DecalSurfaceData surfaceData)
{
	float4x4 normalToWorld = UNITY_ACCESS_INSTANCED_PROP(Decal, _NormalToWorld);
	float fadeFactor = clamp(normalToWorld[0][3], 0.0f, 1.0f) * angleFadeFactor;
	float2 scale = float2(normalToWorld[3][0], normalToWorld[3][1]);
	float2 offset = float2(normalToWorld[3][2], normalToWorld[3][3]);
	float2 uv = input.texCoord0.xy * scale + offset;

	float alpha = fadeFactor * AmnesticCloudAlpha(uv, posInput.positionSS);

	ZERO_INITIALIZE(DecalSurfaceData, surfaceData);
	surfaceData.baseColor = float4(1.0, 1.0, 1.0, alpha);
#ifndef _MATERIAL_AFFECTS_ALBEDO
	surfaceData.baseColor.w = 0.0;
#endif
	surfaceData.normalWS = float4(0.0, 0.0, 0.0, 0.0);
	surfaceData.mask = float4(0.0, 0.0, 0.0, 0.0);

#ifdef _MATERIAL_AFFECTS_EMISSION
	// Original: emissive = alpha, written pre-exposed (multiplied by the current exposure).
	surfaceData.emissive = alpha.xxx;
#endif
}
