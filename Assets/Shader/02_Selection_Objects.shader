Shader "02_Selection/Objects"
{
	Properties
	{
		_SelectionColor ("Selection Color", Color) = (0,0,0,0)
		_MaxDistance ("Max Distance", Float) = 15
		_AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
	}
	SubShader
	{
		Pass
		{
			Name "FirstPass"
			Tags { "LIGHTMODE" = "FirstPass" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 58459

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[8];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float2 vertex_input_3;
			static float3 vertex_output_1;
			static float3 vertex_output_2;
			static float4 vertex_output_3;
			static float2 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float2 vertex_input_3 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_1 : TEXCOORD; // TEXCOORD
				float3 vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_output_3 : TEXCOORD2; // TEXCOORD_2
				float2 vertex_output_4 : TEXCOORD3; // TEXCOORD_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_81 = asfloat(1065353216u);
				float vertex_unnamed_83 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_81));
				float vertex_unnamed_112 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_81));
				float vertex_unnamed_142 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_81));
				vertex_output_1.x = vertex_unnamed_112;
				vertex_output_1.y = vertex_unnamed_83;
				vertex_output_1.z = vertex_unnamed_142;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_142, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_112, vertex_unnamed_83 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_142, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_112, vertex_unnamed_83 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_142, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_112, vertex_unnamed_83 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_142, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_112, vertex_unnamed_83 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_187 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_202 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_217 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_225 = rsqrt(max(dot(float3(vertex_unnamed_187, vertex_unnamed_202, vertex_unnamed_217), float3(vertex_unnamed_187, vertex_unnamed_202, vertex_unnamed_217)), 1.1754943508222875079687365372222e-38f));
				vertex_output_2.x = vertex_unnamed_225 * vertex_unnamed_187;
				vertex_output_2.y = vertex_unnamed_225 * vertex_unnamed_202;
				vertex_output_2.z = vertex_unnamed_225 * vertex_unnamed_217;
				float vertex_unnamed_259 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_260 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_261 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_266 = rsqrt(max(dot(float3(vertex_unnamed_259, vertex_unnamed_260, vertex_unnamed_261), float3(vertex_unnamed_259, vertex_unnamed_260, vertex_unnamed_261)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_266 * vertex_unnamed_259;
				vertex_output_3.y = vertex_unnamed_266 * vertex_unnamed_260;
				vertex_output_3.z = vertex_unnamed_266 * vertex_unnamed_261;
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_input_3.x;
				vertex_output_4.y = vertex_input_3.y;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			float _MaxDistance;
			float4 _SelectionColor;
			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4 _ScreenSize;
			float4 _PlanetCenterRadius;
			float4 _PlanetUpAltitude;
			int _FogEnabled;
			int _PBRFogEnabled;
			int _EnableVolumetricFog;
			float4 _FogColor;
			float _FogColorMode;
			float4 _MipFogParameters;
			float4 _HeightFogBaseScattering;
			float _HeightFogBaseExtinction;
			float _HeightFogBaseHeight;
			int _VolumetricFilteringEnabled;
			float2 _HeightFogExponents;
			float4 _VBufferViewportSize;
			float4 _VBufferLightingViewportScale;
			float4 _VBufferLightingViewportLimit;
			float4 _VBufferDistanceEncodingParams;
			float _VBufferRcpSliceCount;
			float _VBufferLastSliceDist;
			float _ProbeExposureScale;
			float _OffScreenDownsampleFactor;
			int _OffScreenRendering;
			float _DeExposureMultiplier;
			float _BlendMode;
			float _AtmosphericRadius;
			float _AerosolSeaLevelExtinction;
			float _AirDensityFalloff;
			float _AirScaleHeight;
			float _AerosolDensityFalloff;
			float _AerosolScaleHeight;
			float2 _OzoneScaleOffset;
			float _OzoneLayerStart;
			float _OzoneLayerEnd;
			float4 _AirSeaLevelExtinction;
			float4 _OzoneSeaLevelExtinction;
			float4 _HorizonTint;
			float4 _ZenithTint;
			float _AlphaSaturation;
			float _AlphaMultiplier;
			float _HorizonZenithShiftPower;
			float _HorizonZenithShiftScale;

			static float4 fragment_uniform_buffer_0[3];
			static float4 fragment_uniform_buffer_1[215];
			static float4 fragment_uniform_buffer_2[9];
			static float4 fragment_uniform_buffer_3[12];
			Texture2D<float4> _ExposureTexture;
			TextureCubeArray<float4> _SkyTexture;
			Texture3D<float4> _AtmosphericScatteringLUT;
			Texture3D<float4> _VBufferLighting;
			SamplerState sampler_linear_clamp_S0;
			SamplerState sampler_linear_clamp_S1;

			static float4 gl_FragCoord;
			static float3 fragment_input_1;
			static float3 fragment_input_2;
			static float4 fragment_input_3;
			static float2 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_1 : TEXCOORD; // TEXCOORD
				float3 fragment_input_2 : TEXCOORD1; // TEXCOORD_1
				float4 fragment_input_3 : TEXCOORD2; // TEXCOORD_2
				float2 fragment_input_4 : TEXCOORD3; // TEXCOORD_3
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_1357)
			{
				if (fragment_unnamed_1357)
				{
					discard_state = true;
				}
			}

			void discard_exit()
			{
				if (discard_state)
				{
					discard;
				}
			}

			void frag_main()
			{
				discard_state = false;
				discard_cond(fragment_uniform_buffer_0[1u].x < sqrt(dot(float3(fragment_input_1.x, fragment_input_1.y, fragment_input_1.z), float3(fragment_input_1.x, fragment_input_1.y, fragment_input_1.z))));
				bool fragment_unnamed_96 = 0u < asuint(fragment_uniform_buffer_1[211u]).y;
				float fragment_unnamed_123 = (fragment_unnamed_96 ? float(uint(round(gl_FragCoord.x * fragment_uniform_buffer_1[211u].x))) : gl_FragCoord.x) * fragment_uniform_buffer_1[50u].z;
				float fragment_unnamed_124 = (fragment_unnamed_96 ? float(uint(round(gl_FragCoord.y * fragment_uniform_buffer_1[211u].x))) : gl_FragCoord.y) * fragment_uniform_buffer_1[50u].w;
				bool fragment_unnamed_129 = fragment_uniform_buffer_1[15u].w == 0.0f;
				uint4 fragment_unnamed_152 = asuint(fragment_uniform_buffer_1[0u]);
				uint fragment_unnamed_153 = fragment_unnamed_152.z;
				uint4 fragment_unnamed_157 = asuint(fragment_uniform_buffer_1[1u]);
				uint fragment_unnamed_158 = fragment_unnamed_157.z;
				uint4 fragment_unnamed_162 = asuint(fragment_uniform_buffer_1[2u]);
				uint fragment_unnamed_163 = fragment_unnamed_162.z;
				float fragment_unnamed_169 = asfloat(fragment_unnamed_129 ? asuint(((-0.0f) - fragment_input_1.x) + fragment_uniform_buffer_1[11u].x) : fragment_unnamed_153);
				float fragment_unnamed_171 = asfloat(fragment_unnamed_129 ? asuint(((-0.0f) - fragment_input_1.y) + fragment_uniform_buffer_1[11u].y) : fragment_unnamed_158);
				float fragment_unnamed_173 = asfloat(fragment_unnamed_129 ? asuint(((-0.0f) - fragment_input_1.z) + fragment_uniform_buffer_1[11u].z) : fragment_unnamed_163);
				float fragment_unnamed_177 = rsqrt(dot(float3(fragment_unnamed_169, fragment_unnamed_171, fragment_unnamed_173), float3(fragment_unnamed_169, fragment_unnamed_171, fragment_unnamed_173)));
				float fragment_unnamed_178 = fragment_unnamed_177 * fragment_unnamed_169;
				float fragment_unnamed_179 = fragment_unnamed_177 * fragment_unnamed_171;
				float fragment_unnamed_180 = fragment_unnamed_177 * fragment_unnamed_173;
				float fragment_unnamed_190 = fragment_uniform_buffer_0[2u].x * fragment_uniform_buffer_1[214u].w;
				float fragment_unnamed_192 = fragment_uniform_buffer_0[2u].y * fragment_uniform_buffer_1[214u].w;
				float fragment_unnamed_194 = fragment_uniform_buffer_0[2u].z * fragment_uniform_buffer_1[214u].w;
				float fragment_unnamed_206 = asfloat((asuint(fragment_uniform_buffer_1[211u]).y != 0u) ? 0u : asuint(fragment_uniform_buffer_0[2u]).w);
				float fragment_unnamed_207 = (-0.0f) - fragment_unnamed_178;
				float fragment_unnamed_208 = (-0.0f) - fragment_unnamed_179;
				float fragment_unnamed_209 = (-0.0f) - fragment_unnamed_180;
				float fragment_unnamed_216 = 1.0f / dot(float3(fragment_unnamed_207, fragment_unnamed_208, fragment_unnamed_209), float3((-0.0f) - asfloat(fragment_unnamed_153), (-0.0f) - asfloat(fragment_unnamed_158), (-0.0f) - asfloat(fragment_unnamed_163)));
				float fragment_unnamed_221 = fragment_unnamed_216 * (1.0f / gl_FragCoord.w);
				float fragment_unnamed_275;
				float fragment_unnamed_277;
				float fragment_unnamed_279;
				float fragment_unnamed_281;
				float fragment_unnamed_283;
				float fragment_unnamed_284;
				if (asuint(fragment_uniform_buffer_1[84u]).x != 0u)
				{
					float fragment_unnamed_470;
					float fragment_unnamed_472;
					float fragment_unnamed_474;
					float fragment_unnamed_476;
					float fragment_unnamed_478;
					if (asuint(fragment_uniform_buffer_1[84u]).z != 0u)
					{
						float fragment_unnamed_262 = mad((-0.0f) - fragment_uniform_buffer_1[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_1[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_216, (-0.0f) - fragment_uniform_buffer_1[94u].z), 0.0f)), fragment_uniform_buffer_1[94u].x));
						float fragment_unnamed_1158;
						float fragment_unnamed_1159;
						float fragment_unnamed_1160;
						float fragment_unnamed_1161;
						if (asuint(fragment_uniform_buffer_1[89u]).w == 0u)
						{
							float fragment_unnamed_295 = fragment_unnamed_123 * fragment_uniform_buffer_1[91u].x;
							float fragment_unnamed_296 = fragment_unnamed_124 * fragment_uniform_buffer_1[91u].y;
							float fragment_unnamed_297 = floor(fragment_unnamed_295);
							float fragment_unnamed_298 = floor(fragment_unnamed_296);
							float fragment_unnamed_303 = ((-0.0f) - frac(fragment_unnamed_295)) + 1.0f;
							float fragment_unnamed_304 = ((-0.0f) - frac(fragment_unnamed_296)) + 1.0f;
							float fragment_unnamed_305 = fragment_unnamed_304 * fragment_unnamed_304;
							float fragment_unnamed_306 = fragment_unnamed_303 * fragment_unnamed_303;
							float fragment_unnamed_311 = mad(((-0.0f) - fragment_unnamed_303) + 1.0f, fragment_unnamed_303, 0.5f);
							float fragment_unnamed_313 = mad(((-0.0f) - fragment_unnamed_304) + 1.0f, fragment_unnamed_304, 0.5f);
							float fragment_unnamed_320 = ((-0.0f) - fragment_unnamed_311) + mad((-0.0f) - fragment_unnamed_306, 0.5f, 1.0f);
							float fragment_unnamed_321 = ((-0.0f) - fragment_unnamed_313) + mad((-0.0f) - fragment_unnamed_305, 0.5f, 1.0f);
							float fragment_unnamed_322 = fragment_unnamed_311 * 0.5f;
							float fragment_unnamed_323 = fragment_unnamed_313 * 0.5f;
							float fragment_unnamed_324 = mad(fragment_unnamed_305, 0.5f, fragment_unnamed_323);
							float fragment_unnamed_325 = mad(fragment_unnamed_306, 0.5f, fragment_unnamed_322);
							float fragment_unnamed_326 = mad(fragment_unnamed_311, 0.5f, fragment_unnamed_320);
							float fragment_unnamed_327 = mad(fragment_unnamed_313, 0.5f, fragment_unnamed_321);
							float fragment_unnamed_330 = mad(fragment_unnamed_322, 1.0f / fragment_unnamed_325, -0.5f);
							float fragment_unnamed_332 = mad(fragment_unnamed_323, 1.0f / fragment_unnamed_324, -0.5f);
							float fragment_unnamed_335 = mad(fragment_unnamed_320, 1.0f / fragment_unnamed_326, 0.5f);
							float fragment_unnamed_336 = mad(fragment_unnamed_321, 1.0f / fragment_unnamed_327, 0.5f);
							float fragment_unnamed_346 = fragment_uniform_buffer_1[91u].z * fragment_uniform_buffer_1[92u].x;
							float fragment_unnamed_347 = fragment_uniform_buffer_1[91u].w * fragment_uniform_buffer_1[92u].y;
							float fragment_unnamed_367 = fragment_unnamed_262 * fragment_uniform_buffer_1[92u].z;
							float fragment_unnamed_368 = fragment_unnamed_324 * fragment_unnamed_325;
							float4 fragment_unnamed_380 = _VBufferLighting.SampleLevel(sampler_linear_clamp_S0, float3(min(fragment_unnamed_346 * (fragment_unnamed_297 + fragment_unnamed_330), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_347 * (fragment_unnamed_298 + fragment_unnamed_332), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_367, fragment_uniform_buffer_1[93u].z)), 0.0f);
							float fragment_unnamed_386 = fragment_unnamed_324 * fragment_unnamed_326;
							float fragment_unnamed_387 = fragment_unnamed_325 * fragment_unnamed_327;
							float4 fragment_unnamed_396 = _VBufferLighting.SampleLevel(sampler_linear_clamp_S0, float3(min(fragment_unnamed_346 * (fragment_unnamed_297 + fragment_unnamed_335), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_347 * (fragment_unnamed_298 + fragment_unnamed_332), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_367, fragment_uniform_buffer_1[93u].z)), 0.0f);
							float4 fragment_unnamed_418 = _VBufferLighting.SampleLevel(sampler_linear_clamp_S0, float3(min(fragment_unnamed_346 * (fragment_unnamed_297 + fragment_unnamed_330), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_347 * (fragment_unnamed_298 + fragment_unnamed_336), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_367, fragment_uniform_buffer_1[93u].z)), 0.0f);
							float fragment_unnamed_428 = fragment_unnamed_327 * fragment_unnamed_326;
							float4 fragment_unnamed_437 = _VBufferLighting.SampleLevel(sampler_linear_clamp_S0, float3(min(fragment_unnamed_346 * (fragment_unnamed_297 + fragment_unnamed_335), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_347 * (fragment_unnamed_298 + fragment_unnamed_336), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_367, fragment_uniform_buffer_1[93u].z)), 0.0f);
							fragment_unnamed_1158 = mad(fragment_unnamed_428, fragment_unnamed_437.x, mad(fragment_unnamed_387, fragment_unnamed_418.x, mad(fragment_unnamed_368, fragment_unnamed_380.x, fragment_unnamed_386 * fragment_unnamed_396.x)));
							fragment_unnamed_1159 = mad(fragment_unnamed_428, fragment_unnamed_437.y, mad(fragment_unnamed_387, fragment_unnamed_418.y, mad(fragment_unnamed_368, fragment_unnamed_380.y, fragment_unnamed_386 * fragment_unnamed_396.y)));
							fragment_unnamed_1160 = mad(fragment_unnamed_428, fragment_unnamed_437.z, mad(fragment_unnamed_387, fragment_unnamed_418.z, mad(fragment_unnamed_368, fragment_unnamed_380.z, fragment_unnamed_386 * fragment_unnamed_396.z)));
							fragment_unnamed_1161 = mad(fragment_unnamed_428, fragment_unnamed_437.w, mad(fragment_unnamed_387, fragment_unnamed_418.w, mad(fragment_unnamed_368, fragment_unnamed_380.w, fragment_unnamed_386 * fragment_unnamed_396.w)));
						}
						else
						{
							float4 fragment_unnamed_464 = _VBufferLighting.SampleLevel(sampler_linear_clamp_S0, float3(min(fragment_unnamed_123 * fragment_uniform_buffer_1[92u].x, fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_124 * fragment_uniform_buffer_1[92u].y, fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_262 * fragment_uniform_buffer_1[92u].z, fragment_uniform_buffer_1[93u].z)), 0.0f);
							fragment_unnamed_1158 = fragment_unnamed_464.x;
							fragment_unnamed_1159 = fragment_unnamed_464.y;
							fragment_unnamed_1160 = fragment_unnamed_464.z;
							fragment_unnamed_1161 = fragment_unnamed_464.w;
						}
						float fragment_unnamed_479 = ((-0.0f) - exp2(fragment_unnamed_1161 * (-1.44269502162933349609375f))) + 1.0f;
						float fragment_unnamed_1172 = asfloat((fragment_unnamed_479 >= 5.9604644775390625e-08f) ? asuint(fragment_unnamed_479 * (1.0f / fragment_unnamed_1161)) : 1065353216u);
						fragment_unnamed_470 = asfloat(asuint(fragment_uniform_buffer_1[96u]).w);
						fragment_unnamed_472 = fragment_unnamed_1158 * fragment_unnamed_1172;
						fragment_unnamed_474 = fragment_unnamed_1159 * fragment_unnamed_1172;
						fragment_unnamed_476 = fragment_unnamed_1160 * fragment_unnamed_1172;
						fragment_unnamed_478 = fragment_unnamed_479;
					}
					else
					{
						fragment_unnamed_470 = asfloat(0u);
						fragment_unnamed_472 = asfloat(0u);
						fragment_unnamed_474 = asfloat(0u);
						fragment_unnamed_476 = asfloat(0u);
						fragment_unnamed_478 = asfloat(0u);
					}
					float fragment_unnamed_484 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_216, (-0.0f) - fragment_unnamed_470);
					float fragment_unnamed_276;
					float fragment_unnamed_278;
					float fragment_unnamed_280;
					float fragment_unnamed_282;
					if (0.0f < fragment_unnamed_484)
					{
						float fragment_unnamed_1182 = dot(float3(fragment_unnamed_178, fragment_unnamed_179, fragment_unnamed_180), float3(fragment_uniform_buffer_1[83u].xyz));
						float fragment_unnamed_1186 = fragment_unnamed_470 * ((-0.0f) - fragment_unnamed_1182);
						float fragment_unnamed_1200 = max(abs(fragment_unnamed_1182), 0.001000000047497451305389404296875f);
						float fragment_unnamed_1202 = 1.0f / fragment_unnamed_1200;
						float fragment_unnamed_1205 = min(fragment_unnamed_1186, mad(fragment_unnamed_484, (-0.0f) - fragment_unnamed_1182, fragment_unnamed_1186));
						float fragment_unnamed_1219 = min(fragment_unnamed_484, max(fragment_unnamed_1202 * (((-0.0f) - fragment_unnamed_1205) + fragment_uniform_buffer_1[89u].y), 0.0f));
						float fragment_unnamed_1251 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_1200 * ((-0.0f) - (((-0.0f) - fragment_unnamed_1219) + fragment_unnamed_484))) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_1205 + ((-0.0f) - fragment_uniform_buffer_1[89u].y), 0.0f)) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f), fragment_unnamed_1202 * fragment_uniform_buffer_1[90u].y, fragment_unnamed_1219) * fragment_uniform_buffer_1[89u].x) * (-1.44269502162933349609375f));
						float fragment_unnamed_1253 = ((-0.0f) - fragment_unnamed_478) + 1.0f;
						float fragment_unnamed_1315;
						float fragment_unnamed_1316;
						float fragment_unnamed_1317;
						if (fragment_uniform_buffer_1[86u].x == 1.0f)
						{
							float4 fragment_unnamed_1292 = _SkyTexture.SampleLevel(sampler_linear_clamp_S1, float4(fragment_unnamed_207, fragment_unnamed_208, fragment_unnamed_209, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_1[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_216, (-0.0f) - fragment_uniform_buffer_1[87u].x) / (((-0.0f) - fragment_uniform_buffer_1[87u].x) + fragment_uniform_buffer_1[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
							fragment_unnamed_1315 = fragment_unnamed_1292.x * fragment_uniform_buffer_1[85u].x;
							fragment_unnamed_1316 = fragment_unnamed_1292.y * fragment_uniform_buffer_1[85u].y;
							fragment_unnamed_1317 = fragment_unnamed_1292.z * fragment_uniform_buffer_1[85u].z;
						}
						else
						{
							uint4 fragment_unnamed_1308 = asuint(fragment_uniform_buffer_1[85u]);
							fragment_unnamed_1315 = asfloat(fragment_unnamed_1308.x);
							fragment_unnamed_1316 = asfloat(fragment_unnamed_1308.y);
							fragment_unnamed_1317 = asfloat(fragment_unnamed_1308.z);
						}
						float fragment_unnamed_1329 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_1[118u].y;
						float fragment_unnamed_1337 = ((-0.0f) - fragment_unnamed_1251) + 1.0f;
						fragment_unnamed_276 = mad((fragment_uniform_buffer_1[88u].x / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_1329 * (fragment_unnamed_1253 * fragment_unnamed_1315)), fragment_unnamed_1337, fragment_unnamed_472);
						fragment_unnamed_278 = mad((fragment_uniform_buffer_1[88u].y / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_1329 * (fragment_unnamed_1253 * fragment_unnamed_1316)), fragment_unnamed_1337, fragment_unnamed_474);
						fragment_unnamed_280 = mad((fragment_uniform_buffer_1[88u].z / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_1329 * (fragment_unnamed_1253 * fragment_unnamed_1317)), fragment_unnamed_1337, fragment_unnamed_476);
						fragment_unnamed_282 = mad((-0.0f) - fragment_unnamed_1253, fragment_unnamed_1251, 1.0f);
					}
					else
					{
						fragment_unnamed_276 = fragment_unnamed_472;
						fragment_unnamed_278 = fragment_unnamed_474;
						fragment_unnamed_280 = fragment_unnamed_476;
						fragment_unnamed_282 = fragment_unnamed_478;
					}
					fragment_unnamed_275 = fragment_unnamed_276;
					fragment_unnamed_277 = fragment_unnamed_278;
					fragment_unnamed_279 = fragment_unnamed_280;
					fragment_unnamed_281 = fragment_unnamed_282;
					fragment_unnamed_283 = fragment_unnamed_282;
					fragment_unnamed_284 = fragment_unnamed_282;
				}
				else
				{
					fragment_unnamed_275 = asfloat(0u);
					fragment_unnamed_277 = asfloat(0u);
					fragment_unnamed_279 = asfloat(0u);
					fragment_unnamed_281 = asfloat(0u);
					fragment_unnamed_283 = asfloat(0u);
					fragment_unnamed_284 = asfloat(0u);
				}
				float fragment_unnamed_1110;
				float fragment_unnamed_1111;
				float fragment_unnamed_1112;
				float fragment_unnamed_1113;
				float fragment_unnamed_1114;
				float fragment_unnamed_1115;
				if (asuint(fragment_uniform_buffer_1[84u]).y != 0u)
				{
					float fragment_unnamed_494 = fragment_uniform_buffer_1[82u].w + fragment_uniform_buffer_1[83u].w;
					float fragment_unnamed_500 = dot(float3(fragment_uniform_buffer_1[83u].xyz), float3(fragment_unnamed_207, fragment_unnamed_208, fragment_unnamed_209));
					float fragment_unnamed_503 = 1.0f / fragment_unnamed_494;
					float fragment_unnamed_507 = fragment_unnamed_503 * fragment_uniform_buffer_1[82u].w;
					float fragment_unnamed_511 = sqrt(max(mad((-0.0f) - fragment_unnamed_507, fragment_unnamed_507, 1.0f), 0.0f));
					float fragment_unnamed_515 = fragment_unnamed_503 * fragment_uniform_buffer_3[0u].x;
					float fragment_unnamed_518 = max(mad((-0.0f) - fragment_unnamed_500, fragment_unnamed_500, 1.0f), 0.0f);
					float fragment_unnamed_520 = mad(fragment_unnamed_515, fragment_unnamed_515, (-0.0f) - fragment_unnamed_518);
					float4 fragment_unnamed_545 = _AtmosphericScatteringLUT.SampleLevel(sampler_linear_clamp_S0, float3(fragment_unnamed_123, fragment_unnamed_124, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_216, (-0.0f) - max(asfloat((fragment_unnamed_520 < 0.0f) ? asuint(fragment_unnamed_520) : asuint(fragment_unnamed_494 * (((-0.0f) - fragment_unnamed_500) + ((-0.0f) - sqrt(fragment_unnamed_520))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
					float fragment_unnamed_554 = (1.0f / fragment_unnamed_221) * fragment_uniform_buffer_3[0u].x;
					float fragment_unnamed_556 = mad(fragment_unnamed_554, fragment_unnamed_554, (-0.0f) - fragment_unnamed_518);
					float fragment_unnamed_570 = min(max(asfloat((fragment_unnamed_556 < 0.0f) ? asuint(fragment_unnamed_556) : asuint((((-0.0f) - sqrt(fragment_unnamed_556)) + ((-0.0f) - fragment_unnamed_500)) * fragment_unnamed_221)), 0.0f) + 128000.0f, fragment_unnamed_221);
					float fragment_unnamed_587 = dot(float3((-0.0f) - fragment_uniform_buffer_1[82u].x, (-0.0f) - fragment_uniform_buffer_1[82u].y, (-0.0f) - fragment_uniform_buffer_1[82u].z), float3((-0.0f) - fragment_uniform_buffer_1[82u].x, (-0.0f) - fragment_uniform_buffer_1[82u].y, (-0.0f) - fragment_uniform_buffer_1[82u].z));
					float fragment_unnamed_590 = rsqrt(fragment_unnamed_587);
					float fragment_unnamed_602 = sqrt(fragment_unnamed_587);
					float fragment_unnamed_603 = dot(float3(fragment_unnamed_590 * ((-0.0f) - fragment_uniform_buffer_1[82u].x), fragment_unnamed_590 * ((-0.0f) - fragment_uniform_buffer_1[82u].y), fragment_unnamed_590 * ((-0.0f) - fragment_uniform_buffer_1[82u].z)), float3(fragment_unnamed_178, fragment_unnamed_179, fragment_unnamed_180));
					float fragment_unnamed_614 = mad(fragment_unnamed_570, fragment_unnamed_207, (-0.0f) - fragment_uniform_buffer_1[82u].x);
					float fragment_unnamed_615 = mad(fragment_unnamed_570, fragment_unnamed_208, (-0.0f) - fragment_uniform_buffer_1[82u].y);
					float fragment_unnamed_616 = mad(fragment_unnamed_570, fragment_unnamed_209, (-0.0f) - fragment_uniform_buffer_1[82u].z);
					float fragment_unnamed_620 = sqrt(dot(float3(fragment_unnamed_614, fragment_unnamed_615, fragment_unnamed_616), float3(fragment_unnamed_614, fragment_unnamed_615, fragment_unnamed_616)));
					float fragment_unnamed_625 = dot(float3(fragment_unnamed_614, fragment_unnamed_615, fragment_unnamed_616), float3(fragment_unnamed_207, fragment_unnamed_208, fragment_unnamed_209)) * (1.0f / fragment_unnamed_620);
					float fragment_unnamed_628 = (fragment_unnamed_625 >= 0.0f) ? ((-0.0f) - fragment_unnamed_603) : fragment_unnamed_603;
					float fragment_unnamed_633 = fragment_unnamed_602 * fragment_uniform_buffer_3[1u].x;
					float fragment_unnamed_634 = fragment_unnamed_602 * fragment_uniform_buffer_3[1u].z;
					float fragment_unnamed_638 = sqrt(max(mad((-0.0f) - fragment_unnamed_628, fragment_unnamed_628, 1.0f), 0.0f));
					float fragment_unnamed_644 = abs(fragment_unnamed_628) * abs(fragment_unnamed_628);
					float fragment_unnamed_647 = (-0.0f) - fragment_unnamed_644;
					float fragment_unnamed_661 = abs(fragment_unnamed_628);
					float fragment_unnamed_668 = abs(fragment_unnamed_628);
					float fragment_unnamed_687 = exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].x, (-0.0f) - fragment_unnamed_633) * 1.44269502162933349609375f) * mad(fragment_unnamed_668, 0.5f, (1.0f / mad(fragment_unnamed_661, fragment_unnamed_633, sqrt(fragment_unnamed_633 * mad(fragment_unnamed_633 * fragment_unnamed_644, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_647, fragment_unnamed_633, mad(fragment_unnamed_633, 2.0f, 1.0f)) * 0.761642992496490478515625f));
					float fragment_unnamed_688 = exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].z, (-0.0f) - fragment_unnamed_634) * 1.44269502162933349609375f) * mad(fragment_unnamed_668, 0.5f, (1.0f / mad(fragment_unnamed_661, fragment_unnamed_634, sqrt(fragment_unnamed_634 * mad(fragment_unnamed_634 * fragment_unnamed_644, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_647, fragment_unnamed_634, mad(fragment_unnamed_634, 2.0f, 1.0f)) * 0.761642992496490478515625f));
					bool fragment_unnamed_689 = fragment_unnamed_628 < 0.0f;
					float fragment_unnamed_690 = fragment_unnamed_638 * fragment_unnamed_633;
					float fragment_unnamed_691 = fragment_unnamed_638 * fragment_unnamed_634;
					float fragment_unnamed_692 = rsqrt(fragment_unnamed_690);
					float fragment_unnamed_693 = rsqrt(fragment_unnamed_691);
					float fragment_unnamed_736 = fragment_unnamed_620 * fragment_uniform_buffer_3[1u].x;
					float fragment_unnamed_737 = fragment_unnamed_620 * fragment_uniform_buffer_3[1u].z;
					float fragment_unnamed_742 = abs(fragment_unnamed_625) * abs(fragment_unnamed_625);
					float fragment_unnamed_745 = (-0.0f) - fragment_unnamed_742;
					float fragment_unnamed_756 = abs(fragment_unnamed_625);
					float fragment_unnamed_763 = abs(fragment_unnamed_625);
					float fragment_unnamed_791 = abs(mad((-0.0f) - mad(fragment_unnamed_763, 0.5f, (mad(fragment_unnamed_745, fragment_unnamed_736, mad(fragment_unnamed_736, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_756, fragment_unnamed_736, sqrt(fragment_unnamed_736 * mad(fragment_unnamed_736 * fragment_unnamed_742, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].x, (-0.0f) - fragment_unnamed_736) * 1.44269502162933349609375f), asfloat(fragment_unnamed_689 ? asuint(mad((fragment_unnamed_692 + dot(fragment_unnamed_690.xx, fragment_unnamed_692.xx)) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].x, (-0.0f) - fragment_unnamed_690) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_687)) : asuint(fragment_unnamed_687)))) * fragment_uniform_buffer_3[1u].y;
					float fragment_unnamed_793 = 1.0f / fragment_unnamed_602;
					float fragment_unnamed_798 = fragment_unnamed_793 * fragment_uniform_buffer_3[2u].z;
					float fragment_unnamed_799 = fragment_unnamed_793 * fragment_uniform_buffer_3[2u].w;
					float fragment_unnamed_803 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_603, fragment_unnamed_603, 1.0f), 0.0f);
					float fragment_unnamed_804 = mad(fragment_unnamed_798, fragment_unnamed_798, fragment_unnamed_803);
					float fragment_unnamed_805 = mad(fragment_unnamed_799, fragment_unnamed_799, fragment_unnamed_803);
					bool fragment_unnamed_806 = fragment_unnamed_804 < 0.0f;
					bool fragment_unnamed_807 = fragment_unnamed_805 < 0.0f;
					float fragment_unnamed_808 = sqrt(fragment_unnamed_804);
					float fragment_unnamed_809 = sqrt(fragment_unnamed_805);
					uint fragment_unnamed_820 = asuint(fragment_unnamed_804);
					uint fragment_unnamed_823 = fragment_unnamed_806 ? fragment_unnamed_820 : asuint(fragment_unnamed_602 * (fragment_unnamed_603 + ((-0.0f) - fragment_unnamed_808)));
					float fragment_unnamed_824 = asfloat(fragment_unnamed_823);
					uint fragment_unnamed_825 = fragment_unnamed_806 ? fragment_unnamed_820 : asuint(fragment_unnamed_602 * (fragment_unnamed_603 + fragment_unnamed_808));
					float fragment_unnamed_826 = asfloat(fragment_unnamed_825);
					uint fragment_unnamed_827 = asuint(fragment_unnamed_805);
					uint fragment_unnamed_832 = fragment_unnamed_807 ? fragment_unnamed_827 : asuint(fragment_unnamed_602 * (fragment_unnamed_603 + fragment_unnamed_809));
					bool fragment_unnamed_838 = fragment_unnamed_824 >= 0.0f;
					float fragment_unnamed_843 = ((-0.0f) - fragment_unnamed_826) + asfloat(fragment_unnamed_832);
					float fragment_unnamed_846 = max(asfloat(fragment_unnamed_807 ? fragment_unnamed_827 : asuint(fragment_unnamed_602 * (fragment_unnamed_603 + ((-0.0f) - fragment_unnamed_809)))), 0.0f);
					uint fragment_unnamed_847 = fragment_unnamed_838 ? fragment_unnamed_823 : fragment_unnamed_832;
					float fragment_unnamed_853 = ((-0.0f) - fragment_unnamed_846) + asfloat(fragment_unnamed_847);
					bool fragment_unnamed_857 = (((fragment_unnamed_826 < fragment_unnamed_570) ? 4294967295u : 0u) & (fragment_unnamed_838 ? 4294967295u : 0u)) != 0u;
					bool fragment_unnamed_862 = (((fragment_unnamed_824 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_826 >= 0.0f) ? 4294967295u : 0u)) != 0u;
					float fragment_unnamed_867 = asfloat(fragment_unnamed_862 ? fragment_unnamed_825 : asuint(fragment_unnamed_846));
					float fragment_unnamed_869 = asfloat(fragment_unnamed_862 ? asuint(fragment_unnamed_843 * 0.5f) : (fragment_unnamed_857 ? fragment_unnamed_825 : asuint(fragment_unnamed_853 * 0.5f)));
					float fragment_unnamed_871 = asfloat(fragment_unnamed_862 ? asuint(fragment_unnamed_843 * 0.5f) : (fragment_unnamed_857 ? fragment_unnamed_847 : asuint(fragment_unnamed_853 * 0.5f)));
					float fragment_unnamed_873 = asfloat(fragment_unnamed_862 ? fragment_unnamed_832 : (fragment_unnamed_857 ? fragment_unnamed_832 : fragment_unnamed_847));
					float fragment_unnamed_878 = (-0.0f) - fragment_unnamed_867;
					float fragment_unnamed_879 = (-0.0f) - fragment_unnamed_869;
					float fragment_unnamed_882 = fragment_unnamed_878 + min(fragment_unnamed_570, fragment_unnamed_871);
					float fragment_unnamed_883 = fragment_unnamed_879 + min(fragment_unnamed_570, fragment_unnamed_873);
					float fragment_unnamed_892 = mad(fragment_unnamed_878 + min(fragment_unnamed_570, fragment_unnamed_871), 0.25f, fragment_unnamed_867);
					float fragment_unnamed_894 = mad(fragment_unnamed_879 + min(fragment_unnamed_570, fragment_unnamed_873), 0.25f, fragment_unnamed_869);
					float fragment_unnamed_895 = mad(fragment_unnamed_882, 0.75f, fragment_unnamed_867);
					float fragment_unnamed_897 = mad(fragment_unnamed_883, 0.75f, fragment_unnamed_869);
					float fragment_unnamed_899 = dot(((-0.0f) - fragment_unnamed_603).xx, fragment_unnamed_602.xx);
					float fragment_unnamed_917 = (-0.0f) - fragment_uniform_buffer_1[82u].w;
					float fragment_unnamed_953 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_897, fragment_unnamed_897 + fragment_unnamed_899, fragment_unnamed_587)) + fragment_unnamed_917, fragment_uniform_buffer_3[2u].x, fragment_uniform_buffer_3[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_883, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_895, fragment_unnamed_895 + fragment_unnamed_899, fragment_unnamed_587)) + fragment_unnamed_917, fragment_uniform_buffer_3[2u].x, fragment_uniform_buffer_3[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_882, 0.0f) * 0.5f, ((max(fragment_unnamed_883, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_894, fragment_unnamed_894 + fragment_unnamed_899, fragment_unnamed_587)) + fragment_unnamed_917, fragment_uniform_buffer_3[2u].x, fragment_uniform_buffer_3[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_882, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_892, fragment_unnamed_892 + fragment_unnamed_899, fragment_unnamed_587)) + fragment_unnamed_917, fragment_uniform_buffer_3[2u].x, fragment_uniform_buffer_3[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
					float fragment_unnamed_958 = (abs(mad((-0.0f) - mad(fragment_unnamed_763, 0.5f, (mad(fragment_unnamed_745, fragment_unnamed_737, mad(fragment_unnamed_737, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_756, fragment_unnamed_737, sqrt(fragment_unnamed_737 * mad(fragment_unnamed_737 * fragment_unnamed_742, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].z, (-0.0f) - fragment_unnamed_737) * 1.44269502162933349609375f), asfloat(fragment_unnamed_689 ? asuint(mad((dot(fragment_unnamed_691.xx, fragment_unnamed_693.xx) + fragment_unnamed_693) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].z, (-0.0f) - fragment_unnamed_691) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_688)) : asuint(fragment_unnamed_688)))) * fragment_uniform_buffer_3[1u].w) * fragment_uniform_buffer_3[0u].w;
					float fragment_unnamed_986 = ((-0.0f) - exp2(mad(fragment_unnamed_953, fragment_uniform_buffer_3[6u].x, mad(fragment_unnamed_791, fragment_uniform_buffer_3[3u].x, fragment_unnamed_958)) * (-1.44269502162933349609375f))) + 1.0f;
					float fragment_unnamed_987 = ((-0.0f) - exp2(mad(fragment_unnamed_953, fragment_uniform_buffer_3[6u].y, mad(fragment_unnamed_791, fragment_uniform_buffer_3[3u].y, fragment_unnamed_958)) * (-1.44269502162933349609375f))) + 1.0f;
					float fragment_unnamed_988 = ((-0.0f) - exp2(mad(fragment_unnamed_953, fragment_uniform_buffer_3[6u].z, mad(fragment_unnamed_791, fragment_uniform_buffer_3[3u].z, fragment_unnamed_958)) * (-1.44269502162933349609375f))) + 1.0f;
					float fragment_unnamed_990 = fragment_unnamed_988 + (fragment_unnamed_987 + fragment_unnamed_986);
					float fragment_unnamed_991 = fragment_unnamed_990 * 0.3333333432674407958984375f;
					float fragment_unnamed_993 = (-0.0f) - fragment_unnamed_990;
					float fragment_unnamed_1012 = sqrt(((-0.0f) - fragment_unnamed_511) + 1.0f);
					float fragment_unnamed_1018 = mad(mad(mad(fragment_unnamed_511, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_511, -0.212114393711090087890625f), fragment_unnamed_511, 1.570728778839111328125f);
					float fragment_unnamed_1030 = mad(fragment_unnamed_1018, fragment_unnamed_1012, asfloat(((((-0.0f) - fragment_unnamed_511) < fragment_unnamed_511) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_1012 * fragment_unnamed_1018, -2.0f, 3.1415927410125732421875f))));
					float fragment_unnamed_1034 = sqrt(((-0.0f) - abs(fragment_unnamed_500)) + 1.0f);
					float fragment_unnamed_1040 = mad(mad(mad(abs(fragment_unnamed_500), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_500), -0.212114393711090087890625f), abs(fragment_unnamed_500), 1.570728778839111328125f);
					float fragment_unnamed_1051 = 1.0f / ((-0.0f) - fragment_unnamed_1030);
					float fragment_unnamed_1069 = mad(exp2((clamp(mad(mad(fragment_unnamed_1040, fragment_unnamed_1034, asfloat(((fragment_unnamed_500 < ((-0.0f) - fragment_unnamed_500)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_1034 * fragment_unnamed_1040, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_1051, (-0.0f) - (fragment_unnamed_1030 * fragment_unnamed_1051)), 0.0f, 1.0f) * fragment_uniform_buffer_3[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_3[11u].y, (-0.0f) - fragment_uniform_buffer_3[11u].y);
					float fragment_unnamed_1101 = ((-0.0f) - fragment_unnamed_281) + 1.0f;
					float fragment_unnamed_1102 = ((-0.0f) - fragment_unnamed_283) + 1.0f;
					float fragment_unnamed_1103 = ((-0.0f) - fragment_unnamed_284) + 1.0f;
					fragment_unnamed_1110 = mad(fragment_unnamed_1101, fragment_unnamed_545.x * mad(fragment_unnamed_1069, ((-0.0f) - fragment_uniform_buffer_3[8u].x) + fragment_uniform_buffer_3[9u].x, fragment_uniform_buffer_3[8u].x), fragment_unnamed_275);
					fragment_unnamed_1111 = mad(fragment_unnamed_1102, fragment_unnamed_545.y * mad(fragment_unnamed_1069, ((-0.0f) - fragment_uniform_buffer_3[8u].y) + fragment_uniform_buffer_3[9u].y, fragment_uniform_buffer_3[8u].y), fragment_unnamed_277);
					fragment_unnamed_1112 = mad(fragment_unnamed_1103, fragment_unnamed_545.z * mad(fragment_unnamed_1069, ((-0.0f) - fragment_uniform_buffer_3[8u].z) + fragment_uniform_buffer_3[9u].z, fragment_uniform_buffer_3[8u].z), fragment_unnamed_279);
					fragment_unnamed_1113 = mad(fragment_unnamed_1101, mad(mad(fragment_unnamed_993, 0.3333333432674407958984375f, fragment_unnamed_986), fragment_uniform_buffer_3[10u].z, fragment_unnamed_991) * fragment_uniform_buffer_3[10u].w, fragment_unnamed_281);
					fragment_unnamed_1114 = mad(fragment_unnamed_1102, mad(mad(fragment_unnamed_993, 0.3333333432674407958984375f, fragment_unnamed_987), fragment_uniform_buffer_3[10u].z, fragment_unnamed_991) * fragment_uniform_buffer_3[10u].w, fragment_unnamed_283);
					fragment_unnamed_1115 = mad(fragment_unnamed_1103, mad(mad(fragment_unnamed_993, 0.3333333432674407958984375f, fragment_unnamed_988), fragment_uniform_buffer_3[10u].z, fragment_unnamed_991) * fragment_uniform_buffer_3[10u].w, fragment_unnamed_284);
				}
				else
				{
					fragment_unnamed_1110 = fragment_unnamed_275;
					fragment_unnamed_1111 = fragment_unnamed_277;
					fragment_unnamed_1112 = fragment_unnamed_279;
					fragment_unnamed_1113 = fragment_unnamed_281;
					fragment_unnamed_1114 = fragment_unnamed_283;
					fragment_unnamed_1115 = fragment_unnamed_284;
				}
				float fragment_unnamed_1122 = (((-0.0f) - fragment_unnamed_1113) + 1.0f) * fragment_unnamed_190;
				float fragment_unnamed_1123 = (((-0.0f) - fragment_unnamed_1114) + 1.0f) * fragment_unnamed_192;
				float fragment_unnamed_1124 = (((-0.0f) - fragment_unnamed_1115) + 1.0f) * fragment_unnamed_194;
				float fragment_unnamed_1125 = mad(fragment_unnamed_1110, fragment_unnamed_206, fragment_unnamed_1122);
				float fragment_unnamed_1126 = mad(fragment_unnamed_1111, fragment_unnamed_206, fragment_unnamed_1123);
				float fragment_unnamed_1127 = mad(fragment_unnamed_1112, fragment_unnamed_206, fragment_unnamed_1124);
				bool fragment_unnamed_1131 = fragment_uniform_buffer_2[8u].z == 0.0f;
				bool fragment_unnamed_1132 = fragment_uniform_buffer_2[8u].z == 1.0f;
				bool fragment_unnamed_1133 = fragment_uniform_buffer_2[8u].z == 4.0f;
				fragment_output_0.x = fragment_unnamed_1131 ? fragment_unnamed_1125 : asfloat(fragment_unnamed_1132 ? asuint(fragment_unnamed_1122) : (fragment_unnamed_1133 ? asuint(fragment_unnamed_1125) : asuint(fragment_unnamed_190)));
				fragment_output_0.y = fragment_unnamed_1131 ? fragment_unnamed_1126 : asfloat(fragment_unnamed_1132 ? asuint(fragment_unnamed_1123) : (fragment_unnamed_1133 ? asuint(fragment_unnamed_1126) : asuint(fragment_unnamed_192)));
				fragment_output_0.z = fragment_unnamed_1131 ? fragment_unnamed_1127 : asfloat(fragment_unnamed_1132 ? asuint(fragment_unnamed_1124) : (fragment_unnamed_1133 ? asuint(fragment_unnamed_1127) : asuint(fragment_unnamed_194)));
				fragment_output_0.w = fragment_unnamed_206;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[1] = float4(_MaxDistance, fragment_uniform_buffer_0[1][1], fragment_uniform_buffer_0[1][2], fragment_uniform_buffer_0[1][3]);

				fragment_uniform_buffer_0[2] = float4(_SelectionColor[0], _SelectionColor[1], _SelectionColor[2], _SelectionColor[3]);

				fragment_uniform_buffer_1[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				fragment_uniform_buffer_1[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				fragment_uniform_buffer_1[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				fragment_uniform_buffer_1[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				fragment_uniform_buffer_1[8] = float4(_InvViewMatrix[0][0], _InvViewMatrix[1][0], _InvViewMatrix[2][0], _InvViewMatrix[3][0]);
				fragment_uniform_buffer_1[9] = float4(_InvViewMatrix[0][1], _InvViewMatrix[1][1], _InvViewMatrix[2][1], _InvViewMatrix[3][1]);
				fragment_uniform_buffer_1[10] = float4(_InvViewMatrix[0][2], _InvViewMatrix[1][2], _InvViewMatrix[2][2], _InvViewMatrix[3][2]);
				fragment_uniform_buffer_1[11] = float4(_InvViewMatrix[0][3], _InvViewMatrix[1][3], _InvViewMatrix[2][3], _InvViewMatrix[3][3]);

				fragment_uniform_buffer_1[12] = float4(_ProjMatrix[0][0], _ProjMatrix[1][0], _ProjMatrix[2][0], _ProjMatrix[3][0]);
				fragment_uniform_buffer_1[13] = float4(_ProjMatrix[0][1], _ProjMatrix[1][1], _ProjMatrix[2][1], _ProjMatrix[3][1]);
				fragment_uniform_buffer_1[14] = float4(_ProjMatrix[0][2], _ProjMatrix[1][2], _ProjMatrix[2][2], _ProjMatrix[3][2]);
				fragment_uniform_buffer_1[15] = float4(_ProjMatrix[0][3], _ProjMatrix[1][3], _ProjMatrix[2][3], _ProjMatrix[3][3]);

				fragment_uniform_buffer_1[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[82] = float4(_PlanetCenterRadius[0], _PlanetCenterRadius[1], _PlanetCenterRadius[2], _PlanetCenterRadius[3]);

				fragment_uniform_buffer_1[83] = float4(_PlanetUpAltitude[0], _PlanetUpAltitude[1], _PlanetUpAltitude[2], _PlanetUpAltitude[3]);

				fragment_uniform_buffer_1[84] = float4(asfloat(_FogEnabled), fragment_uniform_buffer_1[84][1], fragment_uniform_buffer_1[84][2], fragment_uniform_buffer_1[84][3]);

				fragment_uniform_buffer_1[84] = float4(fragment_uniform_buffer_1[84][0], asfloat(_PBRFogEnabled), fragment_uniform_buffer_1[84][2], fragment_uniform_buffer_1[84][3]);

				fragment_uniform_buffer_1[84] = float4(fragment_uniform_buffer_1[84][0], fragment_uniform_buffer_1[84][1], asfloat(_EnableVolumetricFog), fragment_uniform_buffer_1[84][3]);

				fragment_uniform_buffer_1[85] = float4(_FogColor[0], _FogColor[1], _FogColor[2], _FogColor[3]);

				fragment_uniform_buffer_1[86] = float4(_FogColorMode, fragment_uniform_buffer_1[86][1], fragment_uniform_buffer_1[86][2], fragment_uniform_buffer_1[86][3]);

				fragment_uniform_buffer_1[87] = float4(_MipFogParameters[0], _MipFogParameters[1], _MipFogParameters[2], _MipFogParameters[3]);

				fragment_uniform_buffer_1[88] = float4(_HeightFogBaseScattering[0], _HeightFogBaseScattering[1], _HeightFogBaseScattering[2], _HeightFogBaseScattering[3]);

				fragment_uniform_buffer_1[89] = float4(_HeightFogBaseExtinction, fragment_uniform_buffer_1[89][1], fragment_uniform_buffer_1[89][2], fragment_uniform_buffer_1[89][3]);

				fragment_uniform_buffer_1[89] = float4(fragment_uniform_buffer_1[89][0], _HeightFogBaseHeight, fragment_uniform_buffer_1[89][2], fragment_uniform_buffer_1[89][3]);

				fragment_uniform_buffer_1[89] = float4(fragment_uniform_buffer_1[89][0], fragment_uniform_buffer_1[89][1], fragment_uniform_buffer_1[89][2], asfloat(_VolumetricFilteringEnabled));

				fragment_uniform_buffer_1[90] = float4(_HeightFogExponents[0], _HeightFogExponents[1], fragment_uniform_buffer_1[90][2], fragment_uniform_buffer_1[90][3]);

				fragment_uniform_buffer_1[91] = float4(_VBufferViewportSize[0], _VBufferViewportSize[1], _VBufferViewportSize[2], _VBufferViewportSize[3]);

				fragment_uniform_buffer_1[92] = float4(_VBufferLightingViewportScale[0], _VBufferLightingViewportScale[1], _VBufferLightingViewportScale[2], _VBufferLightingViewportScale[3]);

				fragment_uniform_buffer_1[93] = float4(_VBufferLightingViewportLimit[0], _VBufferLightingViewportLimit[1], _VBufferLightingViewportLimit[2], _VBufferLightingViewportLimit[3]);

				fragment_uniform_buffer_1[94] = float4(_VBufferDistanceEncodingParams[0], _VBufferDistanceEncodingParams[1], _VBufferDistanceEncodingParams[2], _VBufferDistanceEncodingParams[3]);

				fragment_uniform_buffer_1[96] = float4(fragment_uniform_buffer_1[96][0], _VBufferRcpSliceCount, fragment_uniform_buffer_1[96][2], fragment_uniform_buffer_1[96][3]);

				fragment_uniform_buffer_1[96] = float4(fragment_uniform_buffer_1[96][0], fragment_uniform_buffer_1[96][1], fragment_uniform_buffer_1[96][2], _VBufferLastSliceDist);

				fragment_uniform_buffer_1[118] = float4(fragment_uniform_buffer_1[118][0], _ProbeExposureScale, fragment_uniform_buffer_1[118][2], fragment_uniform_buffer_1[118][3]);

				fragment_uniform_buffer_1[211] = float4(_OffScreenDownsampleFactor, fragment_uniform_buffer_1[211][1], fragment_uniform_buffer_1[211][2], fragment_uniform_buffer_1[211][3]);

				fragment_uniform_buffer_1[211] = float4(fragment_uniform_buffer_1[211][0], asfloat(_OffScreenRendering), fragment_uniform_buffer_1[211][2], fragment_uniform_buffer_1[211][3]);

				fragment_uniform_buffer_1[214] = float4(fragment_uniform_buffer_1[214][0], fragment_uniform_buffer_1[214][1], fragment_uniform_buffer_1[214][2], _DeExposureMultiplier);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], _BlendMode, fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_3[0] = float4(_AtmosphericRadius, fragment_uniform_buffer_3[0][1], fragment_uniform_buffer_3[0][2], fragment_uniform_buffer_3[0][3]);

				fragment_uniform_buffer_3[0] = float4(fragment_uniform_buffer_3[0][0], fragment_uniform_buffer_3[0][1], fragment_uniform_buffer_3[0][2], _AerosolSeaLevelExtinction);

				fragment_uniform_buffer_3[1] = float4(_AirDensityFalloff, fragment_uniform_buffer_3[1][1], fragment_uniform_buffer_3[1][2], fragment_uniform_buffer_3[1][3]);

				fragment_uniform_buffer_3[1] = float4(fragment_uniform_buffer_3[1][0], _AirScaleHeight, fragment_uniform_buffer_3[1][2], fragment_uniform_buffer_3[1][3]);

				fragment_uniform_buffer_3[1] = float4(fragment_uniform_buffer_3[1][0], fragment_uniform_buffer_3[1][1], _AerosolDensityFalloff, fragment_uniform_buffer_3[1][3]);

				fragment_uniform_buffer_3[1] = float4(fragment_uniform_buffer_3[1][0], fragment_uniform_buffer_3[1][1], fragment_uniform_buffer_3[1][2], _AerosolScaleHeight);

				fragment_uniform_buffer_3[2] = float4(_OzoneScaleOffset[0], _OzoneScaleOffset[1], fragment_uniform_buffer_3[2][2], fragment_uniform_buffer_3[2][3]);

				fragment_uniform_buffer_3[2] = float4(fragment_uniform_buffer_3[2][0], fragment_uniform_buffer_3[2][1], _OzoneLayerStart, fragment_uniform_buffer_3[2][3]);

				fragment_uniform_buffer_3[2] = float4(fragment_uniform_buffer_3[2][0], fragment_uniform_buffer_3[2][1], fragment_uniform_buffer_3[2][2], _OzoneLayerEnd);

				fragment_uniform_buffer_3[3] = float4(_AirSeaLevelExtinction[0], _AirSeaLevelExtinction[1], _AirSeaLevelExtinction[2], _AirSeaLevelExtinction[3]);

				fragment_uniform_buffer_3[6] = float4(_OzoneSeaLevelExtinction[0], _OzoneSeaLevelExtinction[1], _OzoneSeaLevelExtinction[2], _OzoneSeaLevelExtinction[3]);

				fragment_uniform_buffer_3[8] = float4(_HorizonTint[0], _HorizonTint[1], _HorizonTint[2], _HorizonTint[3]);

				fragment_uniform_buffer_3[9] = float4(_ZenithTint[0], _ZenithTint[1], _ZenithTint[2], _ZenithTint[3]);

				fragment_uniform_buffer_3[10] = float4(fragment_uniform_buffer_3[10][0], fragment_uniform_buffer_3[10][1], _AlphaSaturation, fragment_uniform_buffer_3[10][3]);

				fragment_uniform_buffer_3[10] = float4(fragment_uniform_buffer_3[10][0], fragment_uniform_buffer_3[10][1], fragment_uniform_buffer_3[10][2], _AlphaMultiplier);

				fragment_uniform_buffer_3[11] = float4(_HorizonZenithShiftPower, fragment_uniform_buffer_3[11][1], fragment_uniform_buffer_3[11][2], fragment_uniform_buffer_3[11][3]);

				fragment_uniform_buffer_3[11] = float4(fragment_uniform_buffer_3[11][0], _HorizonZenithShiftScale, fragment_uniform_buffer_3[11][2], fragment_uniform_buffer_3[11][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}


			ENDHLSL
		}
	}
}
