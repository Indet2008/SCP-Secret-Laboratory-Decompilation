// Vertex animation of the original "Shader Graphs/PDRot_VTX" graph (pocket dimension walls and floor), plugged into
// HDRP Lit through its HAVE_MESH_MODIFICATION hook. Formula read from the decompiled graph's vertex program:
//   noise  = NoiseTex.SampleLevel(uv0 + time * 0.03)
//   amount = lerp(1, _GreenChannelPower, vertexColor.g) * _VTXAnimP
//   positionOS.xy += positionOS.xy * amount * noise.xy
#ifndef PDROT_VTX_INCLUDED
#define PDROT_VTX_INCLUDED

#if (SHADERPASS < SHADERPASS_RAYTRACING) || (SHADERPASS > SHADERPASS_RAY_TRACING_DEBUG)

#define HAVE_MESH_MODIFICATION

TEXTURE2D(_SampleTexture2DLOD_a322975d8cc248aca32558c303dede80_Texture_1_Texture2D);
SAMPLER(sampler_SampleTexture2DLOD_a322975d8cc248aca32558c303dede80_Texture_1_Texture2D);
float _VTXAnimP;
float _GreenChannelPower;

AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
{
	float2 noiseUv = input.uv0 + timeParameters.x * 0.03;
	float4 noise = SAMPLE_TEXTURE2D_LOD(_SampleTexture2DLOD_a322975d8cc248aca32558c303dede80_Texture_1_Texture2D,
		sampler_SampleTexture2DLOD_a322975d8cc248aca32558c303dede80_Texture_1_Texture2D, noiseUv, 0);
	float amount = (input.color.g * (_GreenChannelPower - 1.0) + 1.0) * _VTXAnimP;
	input.positionOS.xy += amount * input.positionOS.xy * noise.xy;
	return input;
}

#endif
#endif
