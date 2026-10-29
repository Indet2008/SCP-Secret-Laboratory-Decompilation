Shader "Shader Graphs/ScopeParallax"
{
	Properties
	{
		[NoScaleOffset] _RenderTex ("RenderTex", 2D) = "white" {}
		[NoScaleOffset] _Crosshair ("Crosshair", 2D) = "white" {}
		_DistanceParallax ("DistanceParallax", Float) = 0
		_OffsetParallax ("OffsetParallax", Float) = 0
		_Ads ("Ads", Float) = 0
		[NoScaleOffset] _SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
		[HideInInspector] _RenderQueueType ("Float", Float) = 4
		[ToggleUI] [HideInInspector] _AddPrecomputedVelocity ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _DepthOffsetEnable ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _ConservativeDepthOffsetEnable ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _TransparentWritingMotionVec ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _AlphaCutoffEnable ("Boolean", Float) = 0
		[HideInInspector] _TransparentSortPriority ("_TransparentSortPriority", Float) = 0
		[ToggleUI] [HideInInspector] _UseShadowThreshold ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _DoubleSidedEnable ("Boolean", Float) = 0
		[Enum(Flip, 0, Mirror, 1, None, 2)] [HideInInspector] _DoubleSidedNormalMode ("Float", Float) = 2
		[HideInInspector] _DoubleSidedConstants ("Vector4", Vector) = (1,1,-1,0)
		[Enum(Auto, 0, On, 1, Off, 2)] [HideInInspector] _DoubleSidedGIMode ("Float", Float) = 0
		[ToggleUI] [HideInInspector] _TransparentDepthPrepassEnable ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _TransparentDepthPostpassEnable ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _PerPixelSorting ("Boolean", Float) = 0
		[HideInInspector] _SurfaceType ("Float", Float) = 1
		[HideInInspector] _BlendMode ("Float", Float) = 0
		[HideInInspector] _SrcBlend ("Float", Float) = 1
		[HideInInspector] _DstBlend ("Float", Float) = 0
		[HideInInspector] _DstBlend2 ("Float", Float) = 0
		[HideInInspector] _AlphaSrcBlend ("Float", Float) = 1
		[HideInInspector] _AlphaDstBlend ("Float", Float) = 0
		[ToggleUI] [HideInInspector] _ZWrite ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _TransparentZWrite ("Boolean", Float) = 0
		[HideInInspector] _CullMode ("Float", Float) = 2
		[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Boolean", Float) = 0
		[HideInInspector] _CullModeForward ("Float", Float) = 2
		[Enum(Front, 1, Back, 2)] [HideInInspector] _TransparentCullMode ("Float", Float) = 2
		[Enum(UnityEngine.Rendering.HighDefinition.OpaqueCullMode)] [HideInInspector] _OpaqueCullMode ("Float", Float) = 2
		[HideInInspector] _ZTestDepthEqualForOpaque ("Float", Float) = 4
		[Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _ZTestTransparent ("Float", Float) = 4
		[ToggleUI] [HideInInspector] _TransparentBackfaceEnable ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _EnableBlendModePreserveSpecularLighting ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _ExcludeFromTUAndAA ("Boolean", Float) = 0
		[HideInInspector] _StencilRef ("Float", Float) = 0
		[HideInInspector] _StencilWriteMask ("Float", Float) = 6
		[HideInInspector] _StencilRefDepth ("Float", Float) = 1
		[HideInInspector] _StencilWriteMaskDepth ("Float", Float) = 9
		[HideInInspector] _StencilRefMV ("Float", Float) = 33
		[HideInInspector] _StencilWriteMaskMV ("Float", Float) = 43
		[HideInInspector] _StencilRefDistortionVec ("Float", Float) = 4
		[HideInInspector] _StencilWriteMaskDistortionVec ("Float", Float) = 4
		[HideInInspector] [NoScaleOffset] unity_Lightmaps ("unity_Lightmaps", 2DArray) = "" {}
		[HideInInspector] [NoScaleOffset] unity_LightmapsInd ("unity_LightmapsInd", 2DArray) = "" {}
		[HideInInspector] [NoScaleOffset] unity_ShadowMasks ("unity_ShadowMasks", 2DArray) = "" {}
	}
	SubShader
	{
		Tags { "DisableBatching" = "False" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "ForwardOnly" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Blend 0 [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			Blend 1 One OneMinusSrcAlpha
			ColorMask [_ColorMaskTransparentVelOne] 1
			Blend 2 One [_DstBlend2]
			ColorMask [_ColorMaskTransparentVelTwo] 2
			Blend 3 One [_DstBlend2]
			Blend 4 One OneMinusSrcAlpha
			ZTest [_ZTestDepthEqualForOpaque]
			ZWrite [_ZWrite]
			Cull [_CullModeForward]
			Stencil
			{
				Ref [_StencilRef]
				WriteMask [_StencilWriteMask]
				CompFront Always
				PassFront Replace
				FailFront Keep
				ZFailFront Keep
				CompBack Always
				PassBack Replace
				FailBack Keep
				ZFailBack Keep
			}
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 421278

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT


			#if !defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_ENABLE_FOG_ON_TRANSPARENT)
			#define ANY_SHADER_VARIANT_ACTIVE

			#ifndef DECOMP_DECL__ViewProjMatrix
			#define DECOMP_DECL__ViewProjMatrix
			#endif
			#ifndef DECOMP_DECL__WorldSpaceCameraPos_Internal
			#define DECOMP_DECL__WorldSpaceCameraPos_Internal
			#endif
			#ifndef DECOMP_DECL_unity_ObjectToWorld
			#define DECOMP_DECL_unity_ObjectToWorld
			float4x4 unity_ObjectToWorld;
			#endif

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[4];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float3 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float3 vertex_output_2 : INTERP1; // INTERP_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_76 = asfloat(1065353216u);
				float vertex_unnamed_78 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				float vertex_unnamed_107 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				float vertex_unnamed_137 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				vertex_output_2.x = vertex_unnamed_107;
				vertex_output_2.y = vertex_unnamed_78;
				vertex_output_2.z = vertex_unnamed_137;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
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

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			#ifndef DECOMP_DECL__GlobalFogColor
			#define DECOMP_DECL__GlobalFogColor
			float3 _GlobalFogColor;
			#endif
			#ifndef DECOMP_DECL__ViewMatrix
			#define DECOMP_DECL__ViewMatrix
			#endif
			#ifndef DECOMP_DECL__ProjMatrix
			#define DECOMP_DECL__ProjMatrix
			#endif
			#ifndef DECOMP_DECL__WorldSpaceCameraPos_Internal
			#define DECOMP_DECL__WorldSpaceCameraPos_Internal
			#endif
			#ifndef DECOMP_DECL__GlobalMipBias
			#define DECOMP_DECL__GlobalMipBias
			#endif
			#ifndef DECOMP_DECL__OffScreenRendering
			#define DECOMP_DECL__OffScreenRendering
			#endif
			#ifndef DECOMP_DECL__DeExposureMultiplier
			#define DECOMP_DECL__DeExposureMultiplier
			#endif
			#ifndef DECOMP_DECL__DistanceParallax
			#define DECOMP_DECL__DistanceParallax
			float _DistanceParallax;
			#endif
			#ifndef DECOMP_DECL__OffsetParallax
			#define DECOMP_DECL__OffsetParallax
			float _OffsetParallax;
			#endif
			#ifndef DECOMP_DECL__Ads
			#define DECOMP_DECL__Ads
			float _Ads;
			#endif

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[215];
			static float4 fragment_uniform_buffer_2[4];
			Texture2D<float4> _SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D;
			Texture2D<float4> _RenderTex;
			Texture2D<float4> _Crosshair;
			SamplerState sampler_SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D;
			SamplerState sampler_RenderTex;
			SamplerState sampler_Crosshair;

			static float4 fragment_input_1;
			static float3 fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float3 fragment_input_2 : INTERP1; // INTERP_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				uint fragment_unnamed_94 = (fragment_uniform_buffer_1[15u].w == 0.0f) ? 4294967295u : 0u;
				bool fragment_unnamed_104 = fragment_uniform_buffer_1[15u].w != 0.0f;
				float fragment_unnamed_128 = ((-0.0f) - (fragment_input_2.x + fragment_uniform_buffer_1[48u].x)) + fragment_uniform_buffer_1[48u].x;
				float fragment_unnamed_129 = ((-0.0f) - (fragment_input_2.y + fragment_uniform_buffer_1[48u].y)) + fragment_uniform_buffer_1[48u].y;
				float fragment_unnamed_130 = ((-0.0f) - (fragment_input_2.z + fragment_uniform_buffer_1[48u].z)) + fragment_uniform_buffer_1[48u].z;
				float fragment_unnamed_134 = (-0.0f) - fragment_uniform_buffer_1[0u].z;
				float fragment_unnamed_138 = (-0.0f) - fragment_uniform_buffer_1[1u].z;
				float fragment_unnamed_142 = (-0.0f) - fragment_uniform_buffer_1[2u].z;
				float fragment_unnamed_143 = dot(float3(fragment_unnamed_128, fragment_unnamed_129, fragment_unnamed_130), float3(fragment_unnamed_134, fragment_unnamed_138, fragment_unnamed_142));
				float fragment_unnamed_168 = mad((-0.0f) - fragment_uniform_buffer_2[3u].z, fragment_uniform_buffer_2[3u].z, 1.0f);
				float fragment_unnamed_174 = fragment_unnamed_168 * fragment_uniform_buffer_2[3u].x;
				float fragment_unnamed_175 = fragment_unnamed_168 * fragment_uniform_buffer_2[3u].y;
				float fragment_unnamed_179 = dot(float3(fragment_unnamed_174 * asfloat(fragment_unnamed_104 ? asuint(fragment_unnamed_143 * fragment_unnamed_134) : asuint(fragment_unnamed_128)), fragment_unnamed_174 * asfloat(fragment_unnamed_104 ? asuint(fragment_unnamed_143 * fragment_unnamed_138) : asuint(fragment_unnamed_129)), fragment_unnamed_174 * asfloat(fragment_unnamed_104 ? asuint(fragment_unnamed_143 * fragment_unnamed_142) : asuint(fragment_unnamed_130))), float3(fragment_unnamed_134, fragment_unnamed_138, fragment_unnamed_142));
				float fragment_unnamed_182 = mad(fragment_unnamed_179, -0.5f, 0.5f);
				float4 fragment_unnamed_201 = _SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D, float2(mad(fragment_input_1.x, fragment_unnamed_179, mad((-0.0f) - asfloat(asuint((-0.0f) - (mad(fragment_uniform_buffer_1[2u].x, fragment_input_2.z, mad(fragment_uniform_buffer_1[0u].x, fragment_input_2.x, fragment_input_2.y * fragment_uniform_buffer_1[1u].x)) + fragment_uniform_buffer_1[3u].x)) & fragment_unnamed_94), fragment_unnamed_175, fragment_unnamed_182)), mad(fragment_input_1.y, fragment_unnamed_179, mad((-0.0f) - asfloat(asuint((-0.0f) - (mad(fragment_uniform_buffer_1[2u].y, fragment_input_2.z, mad(fragment_uniform_buffer_1[0u].y, fragment_input_2.x, fragment_input_2.y * fragment_uniform_buffer_1[1u].y)) + fragment_uniform_buffer_1[3u].y)) & fragment_unnamed_94), fragment_unnamed_175, fragment_unnamed_182))), fragment_uniform_buffer_1[86u].y);
				float fragment_unnamed_204 = fragment_unnamed_201.x;
				float4 fragment_unnamed_213 = _RenderTex.SampleBias(sampler_RenderTex, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_1[86u].y);
				float fragment_unnamed_215 = fragment_unnamed_213.x;
				float fragment_unnamed_216 = fragment_unnamed_213.y;
				float fragment_unnamed_217 = fragment_unnamed_213.z;
				float fragment_unnamed_218 = fragment_unnamed_215 * fragment_unnamed_204;
				float fragment_unnamed_219 = fragment_unnamed_216 * fragment_unnamed_204;
				float fragment_unnamed_220 = fragment_unnamed_217 * fragment_unnamed_204;
				float fragment_unnamed_229 = fragment_unnamed_215 + ((-0.0f) - fragment_uniform_buffer_0[0u].x);
				float fragment_unnamed_230 = fragment_unnamed_216 + ((-0.0f) - fragment_uniform_buffer_0[0u].y);
				float fragment_unnamed_231 = fragment_unnamed_217 + ((-0.0f) - fragment_uniform_buffer_0[0u].z);
				float fragment_unnamed_240 = clamp(mad(sqrt(dot(float3(fragment_unnamed_229, fragment_unnamed_230, fragment_unnamed_231), float3(fragment_unnamed_229, fragment_unnamed_230, fragment_unnamed_231))) + (-0.02099999971687793731689453125f), -34.482757568359375f, 1.0f), 0.0f, 1.0f);
				float fragment_unnamed_253 = ((-0.0f) - _Crosshair.SampleBias(sampler_Crosshair, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_1[86u].y).w) + 1.0f;
				float fragment_unnamed_254 = abs(fragment_unnamed_253);
				float fragment_unnamed_261 = abs(fragment_unnamed_253);
				float fragment_unnamed_271 = fragment_unnamed_240 * (fragment_unnamed_240 * fragment_unnamed_240);
				fragment_output_0.x = mad(fragment_unnamed_271, mad((-0.0f) - fragment_unnamed_218, fragment_unnamed_261, fragment_uniform_buffer_0[0u].x), fragment_unnamed_254 * fragment_unnamed_218) * fragment_uniform_buffer_1[214u].w;
				fragment_output_0.y = mad(fragment_unnamed_271, mad((-0.0f) - fragment_unnamed_219, fragment_unnamed_261, fragment_uniform_buffer_0[0u].y), fragment_unnamed_254 * fragment_unnamed_219) * fragment_uniform_buffer_1[214u].w;
				fragment_output_0.z = mad(fragment_unnamed_271, mad((-0.0f) - fragment_unnamed_220, fragment_unnamed_261, fragment_uniform_buffer_0[0u].z), fragment_unnamed_254 * fragment_unnamed_220) * fragment_uniform_buffer_1[214u].w;
				fragment_output_0.w = (asuint(fragment_uniform_buffer_1[211u]).y != 0u) ? 0.0f : 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_GlobalFogColor[0], _GlobalFogColor[1], _GlobalFogColor[2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				fragment_uniform_buffer_1[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				fragment_uniform_buffer_1[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				fragment_uniform_buffer_1[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				fragment_uniform_buffer_1[12] = float4(_ProjMatrix[0][0], _ProjMatrix[1][0], _ProjMatrix[2][0], _ProjMatrix[3][0]);
				fragment_uniform_buffer_1[13] = float4(_ProjMatrix[0][1], _ProjMatrix[1][1], _ProjMatrix[2][1], _ProjMatrix[3][1]);
				fragment_uniform_buffer_1[14] = float4(_ProjMatrix[0][2], _ProjMatrix[1][2], _ProjMatrix[2][2], _ProjMatrix[3][2]);
				fragment_uniform_buffer_1[15] = float4(_ProjMatrix[0][3], _ProjMatrix[1][3], _ProjMatrix[2][3], _ProjMatrix[3][3]);

				fragment_uniform_buffer_1[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_1[86] = float4(fragment_uniform_buffer_1[86][0], _GlobalMipBias, fragment_uniform_buffer_1[86][2], fragment_uniform_buffer_1[86][3]);

				fragment_uniform_buffer_1[211] = float4(fragment_uniform_buffer_1[211][0], asfloat(_OffScreenRendering), fragment_uniform_buffer_1[211][2], fragment_uniform_buffer_1[211][3]);

				fragment_uniform_buffer_1[214] = float4(fragment_uniform_buffer_1[214][0], fragment_uniform_buffer_1[214][1], fragment_uniform_buffer_1[214][2], _DeExposureMultiplier);

				fragment_uniform_buffer_2[3] = float4(_DistanceParallax, fragment_uniform_buffer_2[3][1], fragment_uniform_buffer_2[3][2], fragment_uniform_buffer_2[3][3]);

				fragment_uniform_buffer_2[3] = float4(fragment_uniform_buffer_2[3][0], _OffsetParallax, fragment_uniform_buffer_2[3][2], fragment_uniform_buffer_2[3][3]);

				fragment_uniform_buffer_2[3] = float4(fragment_uniform_buffer_2[3][0], fragment_uniform_buffer_2[3][1], _Ads, fragment_uniform_buffer_2[3][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_ENABLE_FOG_ON_TRANSPARENT)


			#if defined(_SURFACE_TYPE_TRANSPARENT)
			#define ANY_SHADER_VARIANT_ACTIVE

			#ifndef DECOMP_DECL__ViewProjMatrix
			#define DECOMP_DECL__ViewProjMatrix
			#endif
			#ifndef DECOMP_DECL__WorldSpaceCameraPos_Internal
			#define DECOMP_DECL__WorldSpaceCameraPos_Internal
			#endif
			#ifndef DECOMP_DECL_unity_ObjectToWorld
			#define DECOMP_DECL_unity_ObjectToWorld
			float4x4 unity_ObjectToWorld;
			#endif

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[4];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float3 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float3 vertex_output_2 : INTERP1; // INTERP_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_76 = asfloat(1065353216u);
				float vertex_unnamed_78 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				float vertex_unnamed_107 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				float vertex_unnamed_137 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				vertex_output_2.x = vertex_unnamed_107;
				vertex_output_2.y = vertex_unnamed_78;
				vertex_output_2.z = vertex_unnamed_137;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
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

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}

			#endif // defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_ENABLE_FOG_ON_TRANSPARENT)


			#if defined(_SURFACE_TYPE_TRANSPARENT)
			#define ANY_SHADER_VARIANT_ACTIVE

			#ifndef DECOMP_DECL__GlobalFogColor
			#define DECOMP_DECL__GlobalFogColor
			float3 _GlobalFogColor;
			#endif
			#ifndef DECOMP_DECL__InvViewMatrix
			#define DECOMP_DECL__InvViewMatrix
			#endif
			#ifndef DECOMP_DECL__InvViewProjMatrix
			#define DECOMP_DECL__InvViewProjMatrix
			#endif
			#ifndef DECOMP_DECL__ScreenSize
			#define DECOMP_DECL__ScreenSize
			#endif
			#ifndef DECOMP_DECL__PlanetCenterRadius
			#define DECOMP_DECL__PlanetCenterRadius
			#endif
			#ifndef DECOMP_DECL__PlanetUpAltitude
			#define DECOMP_DECL__PlanetUpAltitude
			#endif
			#ifndef DECOMP_DECL__FogEnabled
			#define DECOMP_DECL__FogEnabled
			#endif
			#ifndef DECOMP_DECL__PBRFogEnabled
			#define DECOMP_DECL__PBRFogEnabled
			#endif
			#ifndef DECOMP_DECL__EnableVolumetricFog
			#define DECOMP_DECL__EnableVolumetricFog
			#endif
			#ifndef DECOMP_DECL__FogColor
			#define DECOMP_DECL__FogColor
			#endif
			#ifndef DECOMP_DECL__FogColorMode
			#define DECOMP_DECL__FogColorMode
			#endif
			#ifndef DECOMP_DECL__MipFogParameters
			#define DECOMP_DECL__MipFogParameters
			#endif
			#ifndef DECOMP_DECL__HeightFogBaseScattering
			#define DECOMP_DECL__HeightFogBaseScattering
			#endif
			#ifndef DECOMP_DECL__HeightFogBaseExtinction
			#define DECOMP_DECL__HeightFogBaseExtinction
			#endif
			#ifndef DECOMP_DECL__HeightFogBaseHeight
			#define DECOMP_DECL__HeightFogBaseHeight
			#endif
			#ifndef DECOMP_DECL__VolumetricFilteringEnabled
			#define DECOMP_DECL__VolumetricFilteringEnabled
			#endif
			#ifndef DECOMP_DECL__HeightFogExponents
			#define DECOMP_DECL__HeightFogExponents
			#endif
			#ifndef DECOMP_DECL__VBufferViewportSize
			#define DECOMP_DECL__VBufferViewportSize
			#endif
			#ifndef DECOMP_DECL__VBufferLightingViewportScale
			#define DECOMP_DECL__VBufferLightingViewportScale
			#endif
			#ifndef DECOMP_DECL__VBufferLightingViewportLimit
			#define DECOMP_DECL__VBufferLightingViewportLimit
			#endif
			#ifndef DECOMP_DECL__VBufferDistanceEncodingParams
			#define DECOMP_DECL__VBufferDistanceEncodingParams
			#endif
			#ifndef DECOMP_DECL__VBufferRcpSliceCount
			#define DECOMP_DECL__VBufferRcpSliceCount
			#endif
			#ifndef DECOMP_DECL__VBufferLastSliceDist
			#define DECOMP_DECL__VBufferLastSliceDist
			#endif
			#ifndef DECOMP_DECL__BoundsSS
			#define DECOMP_DECL__BoundsSS
			#endif
			#ifndef DECOMP_DECL__UpDirectionX
			#define DECOMP_DECL__UpDirectionX
			#endif
			#ifndef DECOMP_DECL__UpDirectionY
			#define DECOMP_DECL__UpDirectionY
			#endif
			#ifndef DECOMP_DECL__UnderWaterSurfaceIndex
			#define DECOMP_DECL__UnderWaterSurfaceIndex
			#endif
			#ifndef DECOMP_DECL__PreRefractionPass
			#define DECOMP_DECL__PreRefractionPass
			#endif
			#ifndef DECOMP_DECL__ProbeExposureScale
			#define DECOMP_DECL__ProbeExposureScale
			#endif
			#ifndef DECOMP_DECL__OffScreenDownsampleFactor
			#define DECOMP_DECL__OffScreenDownsampleFactor
			#endif
			#ifndef DECOMP_DECL__BlendMode
			#define DECOMP_DECL__BlendMode
			float _BlendMode;
			#endif
			#ifndef DECOMP_DECL__AtmosphericRadius
			#define DECOMP_DECL__AtmosphericRadius
			float _AtmosphericRadius;
			#endif
			#ifndef DECOMP_DECL__AerosolSeaLevelExtinction
			#define DECOMP_DECL__AerosolSeaLevelExtinction
			float _AerosolSeaLevelExtinction;
			#endif
			#ifndef DECOMP_DECL__AirDensityFalloff
			#define DECOMP_DECL__AirDensityFalloff
			float _AirDensityFalloff;
			#endif
			#ifndef DECOMP_DECL__AirScaleHeight
			#define DECOMP_DECL__AirScaleHeight
			float _AirScaleHeight;
			#endif
			#ifndef DECOMP_DECL__AerosolDensityFalloff
			#define DECOMP_DECL__AerosolDensityFalloff
			float _AerosolDensityFalloff;
			#endif
			#ifndef DECOMP_DECL__AerosolScaleHeight
			#define DECOMP_DECL__AerosolScaleHeight
			float _AerosolScaleHeight;
			#endif
			#ifndef DECOMP_DECL__OzoneScaleOffset
			#define DECOMP_DECL__OzoneScaleOffset
			float2 _OzoneScaleOffset;
			#endif
			#ifndef DECOMP_DECL__OzoneLayerStart
			#define DECOMP_DECL__OzoneLayerStart
			float _OzoneLayerStart;
			#endif
			#ifndef DECOMP_DECL__OzoneLayerEnd
			#define DECOMP_DECL__OzoneLayerEnd
			float _OzoneLayerEnd;
			#endif
			#ifndef DECOMP_DECL__AirSeaLevelExtinction
			#define DECOMP_DECL__AirSeaLevelExtinction
			float4 _AirSeaLevelExtinction;
			#endif
			#ifndef DECOMP_DECL__OzoneSeaLevelExtinction
			#define DECOMP_DECL__OzoneSeaLevelExtinction
			float4 _OzoneSeaLevelExtinction;
			#endif
			#ifndef DECOMP_DECL__HorizonTint
			#define DECOMP_DECL__HorizonTint
			float4 _HorizonTint;
			#endif
			#ifndef DECOMP_DECL__ZenithTint
			#define DECOMP_DECL__ZenithTint
			float4 _ZenithTint;
			#endif
			#ifndef DECOMP_DECL__AlphaSaturation
			#define DECOMP_DECL__AlphaSaturation
			float _AlphaSaturation;
			#endif
			#ifndef DECOMP_DECL__AlphaMultiplier
			#define DECOMP_DECL__AlphaMultiplier
			float _AlphaMultiplier;
			#endif
			#ifndef DECOMP_DECL__HorizonZenithShiftPower
			#define DECOMP_DECL__HorizonZenithShiftPower
			float _HorizonZenithShiftPower;
			#endif
			#ifndef DECOMP_DECL__HorizonZenithShiftScale
			#define DECOMP_DECL__HorizonZenithShiftScale
			float _HorizonZenithShiftScale;
			#endif

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[215];
			static float4 fragment_uniform_buffer_2[12];
			static float4 fragment_uniform_buffer_3[12];
			Texture2D<float4> _ExposureTexture;
			TextureCubeArray<float4> _SkyTexture;
			Texture2D<float4> _SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D;
			Texture2D<float4> _RenderTex;
			Texture2D<float4> _Crosshair;
			Texture3D<float4> _AtmosphericScatteringLUT;
			Texture2DArray<uint4> _StencilTexture;
			Texture2DArray<float4> _RefractiveDepthBuffer;
			Buffer<uint4> T8;
			Buffer<uint4> T9;
			Texture2DArray<float4> _WaterGBufferTexture3;
			Buffer<uint4> T11;
			Texture3D<float4> _VBufferLighting;
			SamplerState s0_linear_clamp;
			SamplerState s1_linear_clamp;
			SamplerState sampler_SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D;
			SamplerState sampler_RenderTex;
			SamplerState sampler_Crosshair;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float3 fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float3 fragment_input_2 : INTERP1; // INTERP_1
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				bool fragment_unnamed_94 = 0u < asuint(fragment_uniform_buffer_1[211u]).y;
				float fragment_unnamed_116 = fragment_unnamed_94 ? float(uint(round(gl_FragCoord.x * fragment_uniform_buffer_1[211u].x))) : gl_FragCoord.x;
				float fragment_unnamed_117 = fragment_unnamed_94 ? float(uint(round(gl_FragCoord.y * fragment_uniform_buffer_1[211u].x))) : gl_FragCoord.y;
				bool fragment_unnamed_122 = fragment_uniform_buffer_1[15u].w == 0.0f;
				uint fragment_unnamed_125 = fragment_unnamed_122 ? 4294967295u : 0u;
				float fragment_unnamed_182 = ((-0.0f) - (fragment_input_2.x + fragment_uniform_buffer_1[48u].x)) + fragment_uniform_buffer_1[48u].x;
				float fragment_unnamed_183 = ((-0.0f) - (fragment_input_2.y + fragment_uniform_buffer_1[48u].y)) + fragment_uniform_buffer_1[48u].y;
				float fragment_unnamed_184 = ((-0.0f) - (fragment_input_2.z + fragment_uniform_buffer_1[48u].z)) + fragment_uniform_buffer_1[48u].z;
				bool fragment_unnamed_188 = fragment_uniform_buffer_1[15u].w != 0.0f;
				uint4 fragment_unnamed_191 = asuint(fragment_uniform_buffer_1[0u]);
				uint fragment_unnamed_192 = fragment_unnamed_191.z;
				float fragment_unnamed_193 = asfloat(fragment_unnamed_192);
				uint4 fragment_unnamed_196 = asuint(fragment_uniform_buffer_1[1u]);
				uint fragment_unnamed_197 = fragment_unnamed_196.z;
				float fragment_unnamed_198 = asfloat(fragment_unnamed_197);
				uint4 fragment_unnamed_201 = asuint(fragment_uniform_buffer_1[2u]);
				uint fragment_unnamed_202 = fragment_unnamed_201.z;
				float fragment_unnamed_203 = asfloat(fragment_unnamed_202);
				float fragment_unnamed_207 = dot(float3(fragment_unnamed_182, fragment_unnamed_183, fragment_unnamed_184), float3((-0.0f) - fragment_unnamed_193, (-0.0f) - fragment_unnamed_198, (-0.0f) - fragment_unnamed_203));
				float fragment_unnamed_235 = mad((-0.0f) - fragment_uniform_buffer_2[3u].z, fragment_uniform_buffer_2[3u].z, 1.0f);
				float fragment_unnamed_241 = fragment_unnamed_235 * fragment_uniform_buffer_2[3u].x;
				float fragment_unnamed_242 = fragment_unnamed_235 * fragment_uniform_buffer_2[3u].y;
				float fragment_unnamed_249 = dot(float3(fragment_unnamed_241 * asfloat(fragment_unnamed_188 ? asuint(fragment_unnamed_207 * ((-0.0f) - fragment_unnamed_193)) : asuint(fragment_unnamed_182)), fragment_unnamed_241 * asfloat(fragment_unnamed_188 ? asuint(fragment_unnamed_207 * ((-0.0f) - fragment_unnamed_198)) : asuint(fragment_unnamed_183)), fragment_unnamed_241 * asfloat(fragment_unnamed_188 ? asuint(fragment_unnamed_207 * ((-0.0f) - fragment_unnamed_203)) : asuint(fragment_unnamed_184))), float3((-0.0f) - fragment_unnamed_193, (-0.0f) - fragment_unnamed_198, (-0.0f) - fragment_unnamed_203));
				float fragment_unnamed_252 = mad(fragment_unnamed_249, -0.5f, 0.5f);
				float4 fragment_unnamed_279 = _SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_ddb5d4c0b06f43db9a156cab155c58c9_Texture_1_Texture2D, float2(mad(fragment_input_1.x, fragment_unnamed_249, mad((-0.0f) - asfloat(fragment_unnamed_125 & asuint((-0.0f) - (mad(fragment_uniform_buffer_1[2u].x, fragment_input_2.z, mad(fragment_uniform_buffer_1[0u].x, fragment_input_2.x, fragment_input_2.y * fragment_uniform_buffer_1[1u].x)) + fragment_uniform_buffer_1[3u].x))), fragment_unnamed_242, fragment_unnamed_252)), mad(fragment_input_1.y, fragment_unnamed_249, mad((-0.0f) - asfloat(fragment_unnamed_125 & asuint((-0.0f) - (mad(fragment_uniform_buffer_1[2u].y, fragment_input_2.z, mad(fragment_uniform_buffer_1[0u].y, fragment_input_2.x, fragment_input_2.y * fragment_uniform_buffer_1[1u].y)) + fragment_uniform_buffer_1[3u].y))), fragment_unnamed_242, fragment_unnamed_252))), fragment_uniform_buffer_1[86u].y);
				float fragment_unnamed_282 = fragment_unnamed_279.x;
				float4 fragment_unnamed_291 = _RenderTex.SampleBias(sampler_RenderTex, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_1[86u].y);
				float fragment_unnamed_293 = fragment_unnamed_291.x;
				float fragment_unnamed_294 = fragment_unnamed_291.y;
				float fragment_unnamed_295 = fragment_unnamed_291.z;
				float fragment_unnamed_296 = fragment_unnamed_282 * fragment_unnamed_293;
				float fragment_unnamed_297 = fragment_unnamed_282 * fragment_unnamed_294;
				float fragment_unnamed_298 = fragment_unnamed_282 * fragment_unnamed_295;
				float fragment_unnamed_311 = ((-0.0f) - _Crosshair.SampleBias(sampler_Crosshair, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_1[86u].y).w) + 1.0f;
				float fragment_unnamed_312 = abs(fragment_unnamed_311);
				float fragment_unnamed_324 = fragment_unnamed_293 + ((-0.0f) - fragment_uniform_buffer_0[0u].x);
				float fragment_unnamed_325 = fragment_unnamed_294 + ((-0.0f) - fragment_uniform_buffer_0[0u].y);
				float fragment_unnamed_326 = fragment_unnamed_295 + ((-0.0f) - fragment_uniform_buffer_0[0u].z);
				float fragment_unnamed_335 = clamp(mad(sqrt(dot(float3(fragment_unnamed_324, fragment_unnamed_325, fragment_unnamed_326), float3(fragment_unnamed_324, fragment_unnamed_325, fragment_unnamed_326))) + (-0.02099999971687793731689453125f), -34.482757568359375f, 1.0f), 0.0f, 1.0f);
				float fragment_unnamed_337 = (fragment_unnamed_335 * fragment_unnamed_335) * fragment_unnamed_335;
				float fragment_unnamed_341 = abs(fragment_unnamed_311);
				float fragment_unnamed_359 = fragment_uniform_buffer_2[3u].z + fragment_uniform_buffer_2[3u].z;
				float fragment_unnamed_361 = min(fragment_unnamed_359 * fragment_unnamed_359, 1.0f);
				float fragment_unnamed_366 = mad(fragment_unnamed_337, mad((-0.0f) - fragment_unnamed_296, fragment_unnamed_341, fragment_uniform_buffer_0[0u].x), fragment_unnamed_312 * fragment_unnamed_296) * fragment_uniform_buffer_1[214u].w;
				float fragment_unnamed_367 = mad(fragment_unnamed_337, mad((-0.0f) - fragment_unnamed_297, fragment_unnamed_341, fragment_uniform_buffer_0[0u].y), fragment_unnamed_312 * fragment_unnamed_297) * fragment_uniform_buffer_1[214u].w;
				float fragment_unnamed_368 = mad(fragment_unnamed_337, mad((-0.0f) - fragment_unnamed_298, fragment_unnamed_341, fragment_uniform_buffer_0[0u].z), fragment_unnamed_312 * fragment_unnamed_298) * fragment_uniform_buffer_1[214u].w;
				bool fragment_unnamed_373 = fragment_uniform_buffer_2[11u].x == 0.0f;
				bool fragment_unnamed_374 = fragment_uniform_buffer_2[11u].x == 1.0f;
				bool fragment_unnamed_375 = fragment_uniform_buffer_2[11u].x == 4.0f;
				bool fragment_unnamed_384 = ((fragment_unnamed_374 ? 4294967295u : 0u) | (fragment_unnamed_373 ? 4294967295u : 0u)) != 0u;
				uint fragment_unnamed_390 = fragment_unnamed_384 ? asuint(fragment_unnamed_361 * fragment_unnamed_366) : asuint(fragment_unnamed_366);
				uint fragment_unnamed_392 = fragment_unnamed_384 ? asuint(fragment_unnamed_361 * fragment_unnamed_367) : asuint(fragment_unnamed_367);
				uint fragment_unnamed_394 = fragment_unnamed_384 ? asuint(fragment_unnamed_361 * fragment_unnamed_368) : asuint(fragment_unnamed_368);
				uint fragment_unnamed_527;
				float fragment_unnamed_529;
				float fragment_unnamed_531;
				float fragment_unnamed_533;
				float fragment_unnamed_535;
				if (asuint(fragment_uniform_buffer_1[211u]).y != 1u)
				{
					uint fragment_unnamed_401 = uint(fragment_unnamed_116);
					uint fragment_unnamed_402 = uint(fragment_unnamed_117);
					float fragment_unnamed_409 = float(fragment_unnamed_401);
					float fragment_unnamed_410 = float(fragment_unnamed_402);
					uint fragment_unnamed_431 = min(T9.Load(1u).x, max(((-T9.Load(0u).x) + 4294967295u), uint(round(dot(float2(fragment_unnamed_409, fragment_unnamed_410), float2(fragment_uniform_buffer_1[103u].y * 1.0f, fragment_uniform_buffer_1[103u].x * (-1.0f))) + ((-0.0f) - fragment_uniform_buffer_1[102u].x)))));
					bool fragment_unnamed_464 = ((((-0.0f) - float((T9.Load(fragment_unnamed_431 + 2u).x & 65535u) + 4294967295u)) + floor(dot(float2(fragment_unnamed_409, fragment_unnamed_410), float2(fragment_uniform_buffer_1[103u].xy)) + ((-0.0f) - fragment_uniform_buffer_1[102u].z))) / (((-0.0f) - fragment_uniform_buffer_1[102u].z) + fragment_uniform_buffer_1[102u].w)) < 0.0f;
					uint fragment_unnamed_465 = fragment_unnamed_464 ? 4294967295u : 0u;
					float fragment_unnamed_466 = asfloat(fragment_unnamed_465);
					uint fragment_unnamed_528;
					float fragment_unnamed_530;
					float fragment_unnamed_532;
					float fragment_unnamed_534;
					float fragment_unnamed_536;
					if (asuint(fragment_uniform_buffer_1[113u]).x != 0u)
					{
						float4 fragment_unnamed_477 = _RefractiveDepthBuffer.Load(int4(uint3(fragment_unnamed_401, fragment_unnamed_402, 0u), 0u));
						float fragment_unnamed_480 = fragment_unnamed_477.x;
						uint4 fragment_unnamed_481 = _StencilTexture.Load(int4(uint3(fragment_unnamed_401, fragment_unnamed_402, 0u), 0u));
						uint fragment_unnamed_483 = fragment_unnamed_481.y;
						uint fragment_unnamed_485 = fragment_unnamed_483 & 32u;
						uint fragment_unnamed_522 = ((fragment_unnamed_483 & 1u) != 0u) ? 4294967295u : ((((((fragment_unnamed_465 & ((fragment_unnamed_485 != 0u) ? 4294967295u : 0u)) & ((fragment_unnamed_480 >= gl_FragCoord.z) ? 4294967295u : 0u)) != 0u) ? 3.4028234663852885981170418348452e+38f : gl_FragCoord.z) < asfloat(fragment_unnamed_464 ? 2139095039u : ((fragment_unnamed_485 != 0u) ? asuint(fragment_unnamed_480) : 0u))) ? (fragment_unnamed_464 ? asuint(fragment_uniform_buffer_1[107u]).x : (uint(_WaterGBufferTexture3.Load(int4(uint3(fragment_unnamed_401, fragment_unnamed_402, 0u), 0u)).w * 255.0f) & 15u)) : 4294967295u);
						uint fragment_unnamed_546;
						float fragment_unnamed_547;
						float fragment_unnamed_548;
						float fragment_unnamed_549;
						float fragment_unnamed_550;
						if (fragment_unnamed_522 == 4294967295u)
						{
							fragment_unnamed_546 = 0u;
							fragment_unnamed_547 = asfloat(0u);
							fragment_unnamed_548 = asfloat(0u);
							fragment_unnamed_549 = asfloat(0u);
							fragment_unnamed_550 = asfloat(0u);
						}
						else
						{
							uint fragment_unnamed_614;
							float fragment_unnamed_615;
							float fragment_unnamed_616;
							if (fragment_unnamed_465 == 0u)
							{
								uint fragment_unnamed_620 = (fragment_unnamed_522 * 28u) + 4u;
								uint3 fragment_unnamed_629 = uint3(T11.Load(fragment_unnamed_620).x, T11.Load(fragment_unnamed_620 + 1u).x, T11.Load(fragment_unnamed_620 + 2u).x);
								float fragment_unnamed_642 = mad(fragment_unnamed_409 * fragment_uniform_buffer_1[50u].z, 2.0f, -1.0f);
								float fragment_unnamed_645 = (-0.0f) - mad(fragment_unnamed_410 * fragment_uniform_buffer_1[50u].w, 2.0f, -1.0f);
								float fragment_unnamed_688 = mad(fragment_uniform_buffer_1[30u].w, fragment_unnamed_480, mad(fragment_uniform_buffer_1[28u].w, fragment_unnamed_642, fragment_unnamed_645 * fragment_uniform_buffer_1[29u].w)) + fragment_uniform_buffer_1[31u].w;
								float fragment_unnamed_701 = ((-0.0f) - ((mad(fragment_uniform_buffer_1[30u].x, fragment_unnamed_480, mad(fragment_uniform_buffer_1[28u].x, fragment_unnamed_642, fragment_unnamed_645 * fragment_uniform_buffer_1[29u].x)) + fragment_uniform_buffer_1[31u].x) / fragment_unnamed_688)) + fragment_input_2.x;
								float fragment_unnamed_702 = ((-0.0f) - ((mad(fragment_uniform_buffer_1[30u].y, fragment_unnamed_480, mad(fragment_uniform_buffer_1[28u].y, fragment_unnamed_642, fragment_unnamed_645 * fragment_uniform_buffer_1[29u].y)) + fragment_uniform_buffer_1[31u].y) / fragment_unnamed_688)) + fragment_input_2.y;
								float fragment_unnamed_703 = ((-0.0f) - ((mad(fragment_uniform_buffer_1[30u].z, fragment_unnamed_480, mad(fragment_uniform_buffer_1[28u].z, fragment_unnamed_642, fragment_unnamed_645 * fragment_uniform_buffer_1[29u].z)) + fragment_uniform_buffer_1[31u].z) / fragment_unnamed_688)) + fragment_input_2.z;
								float fragment_unnamed_707 = sqrt(dot(float3(fragment_unnamed_701, fragment_unnamed_702, fragment_unnamed_703), float3(fragment_unnamed_701, fragment_unnamed_702, fragment_unnamed_703)));
								float fragment_unnamed_708 = fragment_unnamed_707 + fragment_unnamed_707;
								fragment_unnamed_614 = asuint(((-0.0f) - exp2((asfloat(fragment_unnamed_629.x) * fragment_unnamed_708) * (-1.44269502162933349609375f))) + 1.0f);
								fragment_unnamed_615 = ((-0.0f) - exp2((asfloat(fragment_unnamed_629.y) * fragment_unnamed_708) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_616 = ((-0.0f) - exp2((asfloat(fragment_unnamed_629.z) * fragment_unnamed_708) * (-1.44269502162933349609375f))) + 1.0f;
							}
							else
							{
								fragment_unnamed_614 = 0u;
								fragment_unnamed_615 = asfloat(0u);
								fragment_unnamed_616 = asfloat(0u);
							}
							fragment_unnamed_546 = fragment_unnamed_614;
							fragment_unnamed_547 = fragment_unnamed_615;
							fragment_unnamed_548 = fragment_unnamed_616;
							fragment_unnamed_549 = fragment_unnamed_466;
							fragment_unnamed_550 = asfloat(~fragment_unnamed_465);
						}
						fragment_unnamed_528 = fragment_unnamed_546;
						fragment_unnamed_530 = fragment_unnamed_547;
						fragment_unnamed_532 = fragment_unnamed_548;
						fragment_unnamed_534 = fragment_unnamed_549;
						fragment_unnamed_536 = fragment_unnamed_550;
					}
					else
					{
						fragment_unnamed_528 = 0u;
						fragment_unnamed_530 = asfloat(0u);
						fragment_unnamed_532 = asfloat(0u);
						fragment_unnamed_534 = fragment_unnamed_466;
						fragment_unnamed_536 = asfloat(0u);
					}
					fragment_unnamed_527 = fragment_unnamed_528;
					fragment_unnamed_529 = fragment_unnamed_530;
					fragment_unnamed_531 = fragment_unnamed_532;
					fragment_unnamed_533 = fragment_unnamed_534;
					fragment_unnamed_535 = fragment_unnamed_536;
				}
				else
				{
					fragment_unnamed_527 = 0u;
					fragment_unnamed_529 = asfloat(0u);
					fragment_unnamed_531 = asfloat(0u);
					fragment_unnamed_533 = asfloat(0u);
					fragment_unnamed_535 = asfloat(0u);
				}
				uint fragment_unnamed_737;
				float fragment_unnamed_739;
				float fragment_unnamed_741;
				float fragment_unnamed_743;
				float fragment_unnamed_745;
				float fragment_unnamed_747;
				if (asuint(fragment_unnamed_535) == 0u)
				{
					float fragment_unnamed_556 = fragment_unnamed_116 * fragment_uniform_buffer_1[50u].z;
					float fragment_unnamed_557 = fragment_unnamed_117 * fragment_uniform_buffer_1[50u].w;
					float fragment_unnamed_579 = asfloat(fragment_unnamed_122 ? asuint(((-0.0f) - fragment_input_2.x) + fragment_uniform_buffer_1[11u].x) : fragment_unnamed_192);
					float fragment_unnamed_581 = asfloat(fragment_unnamed_122 ? asuint(((-0.0f) - fragment_input_2.y) + fragment_uniform_buffer_1[11u].y) : fragment_unnamed_197);
					float fragment_unnamed_583 = asfloat(fragment_unnamed_122 ? asuint(((-0.0f) - fragment_input_2.z) + fragment_uniform_buffer_1[11u].z) : fragment_unnamed_202);
					float fragment_unnamed_587 = rsqrt(dot(float3(fragment_unnamed_579, fragment_unnamed_581, fragment_unnamed_583), float3(fragment_unnamed_579, fragment_unnamed_581, fragment_unnamed_583)));
					float fragment_unnamed_588 = fragment_unnamed_579 * fragment_unnamed_587;
					float fragment_unnamed_589 = fragment_unnamed_581 * fragment_unnamed_587;
					float fragment_unnamed_590 = fragment_unnamed_583 * fragment_unnamed_587;
					float fragment_unnamed_591 = (-0.0f) - fragment_unnamed_588;
					float fragment_unnamed_592 = (-0.0f) - fragment_unnamed_589;
					float fragment_unnamed_593 = (-0.0f) - fragment_unnamed_590;
					float fragment_unnamed_600 = 1.0f / dot(float3(fragment_unnamed_591, fragment_unnamed_592, fragment_unnamed_593), float3((-0.0f) - fragment_unnamed_193, (-0.0f) - fragment_unnamed_198, (-0.0f) - fragment_unnamed_203));
					float fragment_unnamed_604 = fragment_unnamed_600 * (1.0f / gl_FragCoord.w);
					float fragment_unnamed_821;
					uint fragment_unnamed_823;
					float fragment_unnamed_825;
					float fragment_unnamed_827;
					float fragment_unnamed_828;
					float fragment_unnamed_830;
					float fragment_unnamed_832;
					if (asuint(fragment_uniform_buffer_1[84u]).x != 0u)
					{
						float fragment_unnamed_822;
						float fragment_unnamed_1014;
						float fragment_unnamed_1017;
						float fragment_unnamed_1019;
						float fragment_unnamed_1021;
						if (asuint(fragment_uniform_buffer_1[84u]).z != 0u)
						{
							float fragment_unnamed_808 = mad((-0.0f) - fragment_uniform_buffer_1[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_1[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_600, (-0.0f) - fragment_uniform_buffer_1[94u].z), 0.0f)), fragment_uniform_buffer_1[94u].x));
							float fragment_unnamed_1105;
							float fragment_unnamed_1106;
							float fragment_unnamed_1107;
							float fragment_unnamed_1108;
							if (asuint(fragment_uniform_buffer_1[89u]).w == 0u)
							{
								float fragment_unnamed_841 = fragment_unnamed_556 * fragment_uniform_buffer_1[91u].x;
								float fragment_unnamed_842 = fragment_unnamed_557 * fragment_uniform_buffer_1[91u].y;
								float fragment_unnamed_843 = floor(fragment_unnamed_841);
								float fragment_unnamed_844 = floor(fragment_unnamed_842);
								float fragment_unnamed_849 = ((-0.0f) - frac(fragment_unnamed_841)) + 1.0f;
								float fragment_unnamed_850 = ((-0.0f) - frac(fragment_unnamed_842)) + 1.0f;
								float fragment_unnamed_851 = fragment_unnamed_850 * fragment_unnamed_850;
								float fragment_unnamed_852 = fragment_unnamed_849 * fragment_unnamed_849;
								float fragment_unnamed_857 = mad(((-0.0f) - fragment_unnamed_849) + 1.0f, fragment_unnamed_849, 0.5f);
								float fragment_unnamed_858 = mad(((-0.0f) - fragment_unnamed_850) + 1.0f, fragment_unnamed_850, 0.5f);
								float fragment_unnamed_865 = ((-0.0f) - fragment_unnamed_857) + mad((-0.0f) - fragment_unnamed_852, 0.5f, 1.0f);
								float fragment_unnamed_866 = ((-0.0f) - fragment_unnamed_858) + mad((-0.0f) - fragment_unnamed_851, 0.5f, 1.0f);
								float fragment_unnamed_867 = fragment_unnamed_857 * 0.5f;
								float fragment_unnamed_868 = fragment_unnamed_858 * 0.5f;
								float fragment_unnamed_869 = mad(fragment_unnamed_851, 0.5f, fragment_unnamed_868);
								float fragment_unnamed_870 = mad(fragment_unnamed_852, 0.5f, fragment_unnamed_867);
								float fragment_unnamed_871 = mad(fragment_unnamed_857, 0.5f, fragment_unnamed_865);
								float fragment_unnamed_872 = mad(fragment_unnamed_858, 0.5f, fragment_unnamed_866);
								float fragment_unnamed_875 = mad(fragment_unnamed_867, 1.0f / fragment_unnamed_870, -0.5f);
								float fragment_unnamed_876 = mad(fragment_unnamed_868, 1.0f / fragment_unnamed_869, -0.5f);
								float fragment_unnamed_879 = mad(fragment_unnamed_865, 1.0f / fragment_unnamed_871, 0.5f);
								float fragment_unnamed_880 = mad(fragment_unnamed_866, 1.0f / fragment_unnamed_872, 0.5f);
								float fragment_unnamed_890 = fragment_uniform_buffer_1[91u].z * fragment_uniform_buffer_1[92u].x;
								float fragment_unnamed_891 = fragment_uniform_buffer_1[91u].w * fragment_uniform_buffer_1[92u].y;
								float fragment_unnamed_911 = fragment_unnamed_808 * fragment_uniform_buffer_1[92u].z;
								float fragment_unnamed_912 = fragment_unnamed_869 * fragment_unnamed_870;
								float4 fragment_unnamed_924 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_890 * (fragment_unnamed_843 + fragment_unnamed_875), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_891 * (fragment_unnamed_844 + fragment_unnamed_876), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_911, fragment_uniform_buffer_1[93u].z)), 0.0f);
								float fragment_unnamed_930 = fragment_unnamed_869 * fragment_unnamed_871;
								float fragment_unnamed_931 = fragment_unnamed_870 * fragment_unnamed_872;
								float4 fragment_unnamed_940 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_890 * (fragment_unnamed_843 + fragment_unnamed_879), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_891 * (fragment_unnamed_844 + fragment_unnamed_876), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_911, fragment_uniform_buffer_1[93u].z)), 0.0f);
								float4 fragment_unnamed_962 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_890 * (fragment_unnamed_843 + fragment_unnamed_875), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_891 * (fragment_unnamed_844 + fragment_unnamed_880), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_911, fragment_uniform_buffer_1[93u].z)), 0.0f);
								float fragment_unnamed_972 = fragment_unnamed_872 * fragment_unnamed_871;
								float4 fragment_unnamed_981 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_890 * (fragment_unnamed_843 + fragment_unnamed_879), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_891 * (fragment_unnamed_844 + fragment_unnamed_880), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_911, fragment_uniform_buffer_1[93u].z)), 0.0f);
								fragment_unnamed_1105 = mad(fragment_unnamed_972, fragment_unnamed_981.x, mad(fragment_unnamed_931, fragment_unnamed_962.x, mad(fragment_unnamed_912, fragment_unnamed_924.x, fragment_unnamed_930 * fragment_unnamed_940.x)));
								fragment_unnamed_1106 = mad(fragment_unnamed_972, fragment_unnamed_981.y, mad(fragment_unnamed_931, fragment_unnamed_962.y, mad(fragment_unnamed_912, fragment_unnamed_924.y, fragment_unnamed_930 * fragment_unnamed_940.y)));
								fragment_unnamed_1107 = mad(fragment_unnamed_972, fragment_unnamed_981.z, mad(fragment_unnamed_931, fragment_unnamed_962.z, mad(fragment_unnamed_912, fragment_unnamed_924.z, fragment_unnamed_930 * fragment_unnamed_940.z)));
								fragment_unnamed_1108 = mad(fragment_unnamed_972, fragment_unnamed_981.w, mad(fragment_unnamed_931, fragment_unnamed_962.w, mad(fragment_unnamed_912, fragment_unnamed_924.w, fragment_unnamed_930 * fragment_unnamed_940.w)));
							}
							else
							{
								float4 fragment_unnamed_1008 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_556 * fragment_uniform_buffer_1[92u].x, fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_557 * fragment_uniform_buffer_1[92u].y, fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_808 * fragment_uniform_buffer_1[92u].z, fragment_uniform_buffer_1[93u].z)), 0.0f);
								fragment_unnamed_1105 = fragment_unnamed_1008.x;
								fragment_unnamed_1106 = fragment_unnamed_1008.y;
								fragment_unnamed_1107 = fragment_unnamed_1008.z;
								fragment_unnamed_1108 = fragment_unnamed_1008.w;
							}
							float fragment_unnamed_1015 = ((-0.0f) - exp2(fragment_unnamed_1108 * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1119 = asfloat((fragment_unnamed_1015 >= 5.9604644775390625e-08f) ? asuint((1.0f / fragment_unnamed_1108) * fragment_unnamed_1015) : 1065353216u);
							fragment_unnamed_1014 = fragment_unnamed_1015;
							fragment_unnamed_822 = asfloat(asuint(fragment_uniform_buffer_1[96u]).w);
							fragment_unnamed_1017 = fragment_unnamed_1105 * fragment_unnamed_1119;
							fragment_unnamed_1019 = fragment_unnamed_1106 * fragment_unnamed_1119;
							fragment_unnamed_1021 = fragment_unnamed_1107 * fragment_unnamed_1119;
						}
						else
						{
							fragment_unnamed_1014 = asfloat(0u);
							fragment_unnamed_822 = asfloat(0u);
							fragment_unnamed_1017 = asfloat(0u);
							fragment_unnamed_1019 = asfloat(0u);
							fragment_unnamed_1021 = asfloat(0u);
						}
						float fragment_unnamed_1027 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_600, (-0.0f) - fragment_unnamed_822);
						float fragment_unnamed_826;
						float fragment_unnamed_829;
						float fragment_unnamed_831;
						float fragment_unnamed_833;
						if (((~asuint(fragment_unnamed_533)) & ((0.0f < fragment_unnamed_1027) ? 4294967295u : 0u)) != 0u)
						{
							float fragment_unnamed_1130 = dot(float3(fragment_unnamed_588, fragment_unnamed_589, fragment_unnamed_590), float3(fragment_uniform_buffer_1[83u].xyz));
							float fragment_unnamed_1134 = fragment_unnamed_822 * ((-0.0f) - fragment_unnamed_1130);
							float fragment_unnamed_1148 = max(abs(fragment_unnamed_1130), 0.001000000047497451305389404296875f);
							float fragment_unnamed_1150 = 1.0f / fragment_unnamed_1148;
							float fragment_unnamed_1153 = min(mad(fragment_unnamed_1027, (-0.0f) - fragment_unnamed_1130, fragment_unnamed_1134), fragment_unnamed_1134);
							float fragment_unnamed_1167 = min(fragment_unnamed_1027, max(fragment_unnamed_1150 * (((-0.0f) - fragment_unnamed_1153) + fragment_uniform_buffer_1[89u].y), 0.0f));
							float fragment_unnamed_1200 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_1148 * ((-0.0f) - (fragment_unnamed_1027 + ((-0.0f) - fragment_unnamed_1167)))) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_1153 + ((-0.0f) - fragment_uniform_buffer_1[89u].y), 0.0f)) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f), fragment_unnamed_1150 * fragment_uniform_buffer_1[90u].y, fragment_unnamed_1167) * fragment_uniform_buffer_1[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_1202 = ((-0.0f) - fragment_unnamed_1014) + 1.0f;
							float fragment_unnamed_2030;
							float fragment_unnamed_2031;
							float fragment_unnamed_2032;
							if (fragment_uniform_buffer_1[86u].x == 1.0f)
							{
								float4 fragment_unnamed_1345 = _SkyTexture.SampleLevel(s1_linear_clamp, float4(fragment_unnamed_591, fragment_unnamed_592, fragment_unnamed_593, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_1[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_600, (-0.0f) - fragment_uniform_buffer_1[87u].x) / (((-0.0f) - fragment_uniform_buffer_1[87u].x) + fragment_uniform_buffer_1[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_2030 = fragment_unnamed_1345.x * fragment_uniform_buffer_1[85u].x;
								fragment_unnamed_2031 = fragment_unnamed_1345.y * fragment_uniform_buffer_1[85u].y;
								fragment_unnamed_2032 = fragment_unnamed_1345.z * fragment_uniform_buffer_1[85u].z;
							}
							else
							{
								uint4 fragment_unnamed_1361 = asuint(fragment_uniform_buffer_1[85u]);
								fragment_unnamed_2030 = asfloat(fragment_unnamed_1361.x);
								fragment_unnamed_2031 = asfloat(fragment_unnamed_1361.y);
								fragment_unnamed_2032 = asfloat(fragment_unnamed_1361.z);
							}
							float fragment_unnamed_2042 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_1[118u].y;
							float fragment_unnamed_2050 = ((-0.0f) - fragment_unnamed_1200) + 1.0f;
							fragment_unnamed_826 = mad((-0.0f) - fragment_unnamed_1202, fragment_unnamed_1200, 1.0f);
							fragment_unnamed_829 = mad((fragment_uniform_buffer_1[88u].x / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_2042 * (fragment_unnamed_1202 * fragment_unnamed_2030)), fragment_unnamed_2050, fragment_unnamed_1017);
							fragment_unnamed_831 = mad((fragment_uniform_buffer_1[88u].y / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_2042 * (fragment_unnamed_1202 * fragment_unnamed_2031)), fragment_unnamed_2050, fragment_unnamed_1019);
							fragment_unnamed_833 = mad((fragment_uniform_buffer_1[88u].z / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_2042 * (fragment_unnamed_1202 * fragment_unnamed_2032)), fragment_unnamed_2050, fragment_unnamed_1021);
						}
						else
						{
							fragment_unnamed_826 = fragment_unnamed_1014;
							fragment_unnamed_829 = fragment_unnamed_1017;
							fragment_unnamed_831 = fragment_unnamed_1019;
							fragment_unnamed_833 = fragment_unnamed_1021;
						}
						fragment_unnamed_821 = fragment_unnamed_822;
						fragment_unnamed_823 = asuint(fragment_unnamed_826);
						fragment_unnamed_825 = fragment_unnamed_826;
						fragment_unnamed_827 = fragment_unnamed_826;
						fragment_unnamed_828 = fragment_unnamed_829;
						fragment_unnamed_830 = fragment_unnamed_831;
						fragment_unnamed_832 = fragment_unnamed_833;
					}
					else
					{
						fragment_unnamed_821 = asfloat(0u);
						fragment_unnamed_823 = fragment_unnamed_527;
						fragment_unnamed_825 = fragment_unnamed_529;
						fragment_unnamed_827 = fragment_unnamed_531;
						fragment_unnamed_828 = asfloat(0u);
						fragment_unnamed_830 = asfloat(0u);
						fragment_unnamed_832 = asfloat(0u);
					}
					uint fragment_unnamed_1091;
					float fragment_unnamed_1093;
					float fragment_unnamed_1095;
					float fragment_unnamed_1097;
					float fragment_unnamed_1099;
					float fragment_unnamed_1101;
					if (asuint(fragment_unnamed_533) != 0u)
					{
						uint fragment_unnamed_1039 = (asuint(fragment_uniform_buffer_1[107u]).x * 28u) + 4u;
						uint4 fragment_unnamed_1051 = uint4(T11.Load(fragment_unnamed_1039).x, T11.Load(fragment_unnamed_1039 + 1u).x, T11.Load(fragment_unnamed_1039 + 2u).x, T11.Load(fragment_unnamed_1039 + 3u).x);
						float fragment_unnamed_1059 = asfloat(fragment_unnamed_1051.w);
						uint fragment_unnamed_1066 = (asuint(fragment_uniform_buffer_1[107u]).x * 28u) + 20u;
						uint3 fragment_unnamed_1075 = uint3(T11.Load(fragment_unnamed_1066).x, T11.Load(fragment_unnamed_1066 + 1u).x, T11.Load(fragment_unnamed_1066 + 2u).x);
						float fragment_unnamed_1077 = asfloat(fragment_unnamed_1075.x);
						float fragment_unnamed_1079 = asfloat(fragment_unnamed_1075.y);
						float fragment_unnamed_1081 = asfloat(fragment_unnamed_1075.z);
						float fragment_unnamed_1082 = fragment_unnamed_1059 * asfloat(fragment_unnamed_1051.x);
						float fragment_unnamed_1083 = fragment_unnamed_1059 * asfloat(fragment_unnamed_1051.y);
						float fragment_unnamed_1084 = fragment_unnamed_1059 * asfloat(fragment_unnamed_1051.z);
						float fragment_unnamed_1089 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_600, (-0.0f) - fragment_unnamed_821);
						float fragment_unnamed_1098;
						float fragment_unnamed_1100;
						float fragment_unnamed_1102;
						float fragment_unnamed_1368;
						float fragment_unnamed_1369;
						float fragment_unnamed_1370;
						if (0.0f < fragment_unnamed_1089)
						{
							uint fragment_unnamed_1217 = (asuint(fragment_uniform_buffer_1[107u]).x * 28u) + 16u;
							uint3 fragment_unnamed_1226 = uint3(T11.Load(fragment_unnamed_1217).x, T11.Load(fragment_unnamed_1217 + 1u).x, T11.Load(fragment_unnamed_1217 + 2u).x);
							float fragment_unnamed_1233 = dot(float3(fragment_unnamed_588, fragment_unnamed_589, fragment_unnamed_590), float3(fragment_unnamed_1077, fragment_unnamed_1079, fragment_unnamed_1081));
							float fragment_unnamed_1236 = fragment_unnamed_1089 * fragment_unnamed_1082;
							float fragment_unnamed_1237 = fragment_unnamed_1089 * fragment_unnamed_1083;
							float fragment_unnamed_1238 = fragment_unnamed_1089 * fragment_unnamed_1084;
							float fragment_unnamed_1254 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_1[118u].y;
							float fragment_unnamed_1255 = fragment_unnamed_1254 * (((-0.0f) - asfloat(fragment_unnamed_823)) + 1.0f);
							float fragment_unnamed_1256 = fragment_unnamed_1254 * (((-0.0f) - fragment_unnamed_825) + 1.0f);
							float fragment_unnamed_1257 = fragment_unnamed_1254 * (((-0.0f) - fragment_unnamed_827) + 1.0f);
							bool fragment_unnamed_1259 = ((-0.0f) - fragment_unnamed_1233) != 1.0f;
							float fragment_unnamed_1261 = 1.0f / (fragment_unnamed_1233 + 1.0f);
							float fragment_unnamed_1265 = (-0.0f) - fragment_unnamed_1233;
							fragment_unnamed_1098 = mad(asfloat(fragment_unnamed_1259 ? asuint(fragment_unnamed_1255 * (fragment_unnamed_1261 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1236, fragment_unnamed_1265, fragment_unnamed_1236) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1255)), asfloat(fragment_unnamed_1226.x), fragment_unnamed_828);
							fragment_unnamed_1100 = mad(asfloat(fragment_unnamed_1259 ? asuint(fragment_unnamed_1256 * (fragment_unnamed_1261 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1237, fragment_unnamed_1265, fragment_unnamed_1237) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1256)), asfloat(fragment_unnamed_1226.y), fragment_unnamed_830);
							fragment_unnamed_1102 = mad(asfloat(fragment_unnamed_1259 ? asuint(fragment_unnamed_1257 * (fragment_unnamed_1261 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1238, fragment_unnamed_1265, fragment_unnamed_1238) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1257)), asfloat(fragment_unnamed_1226.z), fragment_unnamed_832);
							fragment_unnamed_1368 = fragment_unnamed_1236;
							fragment_unnamed_1369 = fragment_unnamed_1237;
							fragment_unnamed_1370 = fragment_unnamed_1238;
						}
						else
						{
							fragment_unnamed_1098 = fragment_unnamed_828;
							fragment_unnamed_1100 = fragment_unnamed_830;
							fragment_unnamed_1102 = fragment_unnamed_832;
							fragment_unnamed_1368 = asfloat(0u);
							fragment_unnamed_1369 = asfloat(0u);
							fragment_unnamed_1370 = asfloat(0u);
						}
						float fragment_unnamed_1386 = max(((-0.0f) - asfloat(T8.Load(0u).x)) + ((-0.0f) - dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_unnamed_1077, fragment_unnamed_1079, fragment_unnamed_1081))), 0.0f);
						fragment_unnamed_1091 = asuint(mad((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_823)) + 1.0f), exp2(mad(fragment_unnamed_1386, fragment_unnamed_1082, fragment_unnamed_1368) * (-1.44269502162933349609375f)), 1.0f));
						fragment_unnamed_1093 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_825) + 1.0f), exp2(mad(fragment_unnamed_1386, fragment_unnamed_1083, fragment_unnamed_1369) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1095 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_827) + 1.0f), exp2(mad(fragment_unnamed_1386, fragment_unnamed_1084, fragment_unnamed_1370) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1097 = fragment_unnamed_1098;
						fragment_unnamed_1099 = fragment_unnamed_1100;
						fragment_unnamed_1101 = fragment_unnamed_1102;
					}
					else
					{
						fragment_unnamed_1091 = fragment_unnamed_823;
						fragment_unnamed_1093 = fragment_unnamed_825;
						fragment_unnamed_1095 = fragment_unnamed_827;
						fragment_unnamed_1097 = fragment_unnamed_828;
						fragment_unnamed_1099 = fragment_unnamed_830;
						fragment_unnamed_1101 = fragment_unnamed_832;
					}
					uint fragment_unnamed_738;
					float fragment_unnamed_740;
					float fragment_unnamed_742;
					float fragment_unnamed_744;
					float fragment_unnamed_746;
					float fragment_unnamed_748;
					if (asuint(fragment_unnamed_533) == 0u)
					{
						uint fragment_unnamed_1310;
						float fragment_unnamed_1311;
						float fragment_unnamed_1312;
						float fragment_unnamed_1313;
						float fragment_unnamed_1314;
						float fragment_unnamed_1315;
						if (asuint(fragment_uniform_buffer_1[84u]).y != 0u)
						{
							float fragment_unnamed_1414 = fragment_uniform_buffer_1[82u].w + fragment_uniform_buffer_1[83u].w;
							float fragment_unnamed_1420 = dot(float3(fragment_uniform_buffer_1[83u].xyz), float3(fragment_unnamed_591, fragment_unnamed_592, fragment_unnamed_593));
							float fragment_unnamed_1423 = 1.0f / fragment_unnamed_1414;
							float fragment_unnamed_1427 = fragment_unnamed_1423 * fragment_uniform_buffer_1[82u].w;
							float fragment_unnamed_1431 = sqrt(max(mad((-0.0f) - fragment_unnamed_1427, fragment_unnamed_1427, 1.0f), 0.0f));
							float fragment_unnamed_1435 = fragment_unnamed_1423 * fragment_uniform_buffer_3[0u].x;
							float fragment_unnamed_1438 = max(mad((-0.0f) - fragment_unnamed_1420, fragment_unnamed_1420, 1.0f), 0.0f);
							float fragment_unnamed_1440 = mad(fragment_unnamed_1435, fragment_unnamed_1435, (-0.0f) - fragment_unnamed_1438);
							float4 fragment_unnamed_1465 = _AtmosphericScatteringLUT.SampleLevel(s0_linear_clamp, float3(fragment_unnamed_556, fragment_unnamed_557, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_600, (-0.0f) - max(asfloat((fragment_unnamed_1440 < 0.0f) ? asuint(fragment_unnamed_1440) : asuint(fragment_unnamed_1414 * (((-0.0f) - fragment_unnamed_1420) + ((-0.0f) - sqrt(fragment_unnamed_1440))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
							float fragment_unnamed_1474 = (1.0f / fragment_unnamed_604) * fragment_uniform_buffer_3[0u].x;
							float fragment_unnamed_1476 = mad(fragment_unnamed_1474, fragment_unnamed_1474, (-0.0f) - fragment_unnamed_1438);
							float fragment_unnamed_1490 = min(max(asfloat((fragment_unnamed_1476 < 0.0f) ? asuint(fragment_unnamed_1476) : asuint((((-0.0f) - sqrt(fragment_unnamed_1476)) + ((-0.0f) - fragment_unnamed_1420)) * fragment_unnamed_604)), 0.0f) + 128000.0f, fragment_unnamed_604);
							float fragment_unnamed_1507 = dot(float3((-0.0f) - fragment_uniform_buffer_1[82u].x, (-0.0f) - fragment_uniform_buffer_1[82u].y, (-0.0f) - fragment_uniform_buffer_1[82u].z), float3((-0.0f) - fragment_uniform_buffer_1[82u].x, (-0.0f) - fragment_uniform_buffer_1[82u].y, (-0.0f) - fragment_uniform_buffer_1[82u].z));
							float fragment_unnamed_1510 = rsqrt(fragment_unnamed_1507);
							float fragment_unnamed_1522 = sqrt(fragment_unnamed_1507);
							float fragment_unnamed_1523 = dot(float3(fragment_unnamed_1510 * ((-0.0f) - fragment_uniform_buffer_1[82u].x), fragment_unnamed_1510 * ((-0.0f) - fragment_uniform_buffer_1[82u].y), fragment_unnamed_1510 * ((-0.0f) - fragment_uniform_buffer_1[82u].z)), float3(fragment_unnamed_588, fragment_unnamed_589, fragment_unnamed_590));
							float fragment_unnamed_1534 = mad(fragment_unnamed_1490, fragment_unnamed_591, (-0.0f) - fragment_uniform_buffer_1[82u].x);
							float fragment_unnamed_1535 = mad(fragment_unnamed_1490, fragment_unnamed_592, (-0.0f) - fragment_uniform_buffer_1[82u].y);
							float fragment_unnamed_1536 = mad(fragment_unnamed_1490, fragment_unnamed_593, (-0.0f) - fragment_uniform_buffer_1[82u].z);
							float fragment_unnamed_1540 = sqrt(dot(float3(fragment_unnamed_1534, fragment_unnamed_1535, fragment_unnamed_1536), float3(fragment_unnamed_1534, fragment_unnamed_1535, fragment_unnamed_1536)));
							float fragment_unnamed_1545 = dot(float3(fragment_unnamed_1534, fragment_unnamed_1535, fragment_unnamed_1536), float3(fragment_unnamed_591, fragment_unnamed_592, fragment_unnamed_593)) * (1.0f / fragment_unnamed_1540);
							float fragment_unnamed_1548 = (fragment_unnamed_1545 >= 0.0f) ? ((-0.0f) - fragment_unnamed_1523) : fragment_unnamed_1523;
							float fragment_unnamed_1553 = fragment_unnamed_1522 * fragment_uniform_buffer_3[1u].x;
							float fragment_unnamed_1554 = fragment_unnamed_1522 * fragment_uniform_buffer_3[1u].z;
							float fragment_unnamed_1558 = sqrt(max(mad((-0.0f) - fragment_unnamed_1548, fragment_unnamed_1548, 1.0f), 0.0f));
							float fragment_unnamed_1563 = abs(fragment_unnamed_1548) * abs(fragment_unnamed_1548);
							float fragment_unnamed_1566 = (-0.0f) - fragment_unnamed_1563;
							float fragment_unnamed_1580 = abs(fragment_unnamed_1548);
							float fragment_unnamed_1587 = abs(fragment_unnamed_1548);
							float fragment_unnamed_1605 = mad(fragment_unnamed_1587, 0.5f, (mad(fragment_unnamed_1566, fragment_unnamed_1553, mad(fragment_unnamed_1553, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_1580, fragment_unnamed_1553, sqrt(fragment_unnamed_1553 * mad(fragment_unnamed_1553 * fragment_unnamed_1563, 0.2738279998302459716796875f, 1.47721004486083984375f))))) * exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].x, (-0.0f) - fragment_unnamed_1553) * 1.44269502162933349609375f);
							float fragment_unnamed_1606 = mad(fragment_unnamed_1587, 0.5f, (mad(fragment_unnamed_1566, fragment_unnamed_1554, mad(fragment_unnamed_1554, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_1580, fragment_unnamed_1554, sqrt(fragment_unnamed_1554 * mad(fragment_unnamed_1554 * fragment_unnamed_1563, 0.2738279998302459716796875f, 1.47721004486083984375f))))) * exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].z, (-0.0f) - fragment_unnamed_1554) * 1.44269502162933349609375f);
							bool fragment_unnamed_1607 = fragment_unnamed_1548 < 0.0f;
							float fragment_unnamed_1608 = fragment_unnamed_1558 * fragment_unnamed_1553;
							float fragment_unnamed_1609 = fragment_unnamed_1558 * fragment_unnamed_1554;
							float fragment_unnamed_1610 = rsqrt(fragment_unnamed_1608);
							float fragment_unnamed_1611 = rsqrt(fragment_unnamed_1609);
							float fragment_unnamed_1654 = fragment_unnamed_1540 * fragment_uniform_buffer_3[1u].x;
							float fragment_unnamed_1655 = fragment_unnamed_1540 * fragment_uniform_buffer_3[1u].z;
							float fragment_unnamed_1660 = abs(fragment_unnamed_1545) * abs(fragment_unnamed_1545);
							float fragment_unnamed_1663 = (-0.0f) - fragment_unnamed_1660;
							float fragment_unnamed_1674 = abs(fragment_unnamed_1545);
							float fragment_unnamed_1681 = abs(fragment_unnamed_1545);
							float fragment_unnamed_1709 = abs(mad((-0.0f) - mad(fragment_unnamed_1681, 0.5f, (mad(fragment_unnamed_1663, fragment_unnamed_1654, mad(fragment_unnamed_1654, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_1674, fragment_unnamed_1654, sqrt(fragment_unnamed_1654 * mad(fragment_unnamed_1654 * fragment_unnamed_1660, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].x, (-0.0f) - fragment_unnamed_1654) * 1.44269502162933349609375f), asfloat(fragment_unnamed_1607 ? asuint(mad((dot(fragment_unnamed_1608.xx, fragment_unnamed_1610.xx) + fragment_unnamed_1610) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].x, (-0.0f) - fragment_unnamed_1608) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_1605)) : asuint(fragment_unnamed_1605)))) * fragment_uniform_buffer_3[1u].y;
							float fragment_unnamed_1711 = 1.0f / fragment_unnamed_1522;
							float fragment_unnamed_1716 = fragment_unnamed_1711 * fragment_uniform_buffer_3[2u].z;
							float fragment_unnamed_1717 = fragment_unnamed_1711 * fragment_uniform_buffer_3[2u].w;
							float fragment_unnamed_1721 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_1523, fragment_unnamed_1523, 1.0f), 0.0f);
							float fragment_unnamed_1722 = mad(fragment_unnamed_1716, fragment_unnamed_1716, fragment_unnamed_1721);
							float fragment_unnamed_1723 = mad(fragment_unnamed_1717, fragment_unnamed_1717, fragment_unnamed_1721);
							bool fragment_unnamed_1724 = fragment_unnamed_1722 < 0.0f;
							bool fragment_unnamed_1725 = fragment_unnamed_1723 < 0.0f;
							float fragment_unnamed_1726 = sqrt(fragment_unnamed_1722);
							float fragment_unnamed_1727 = sqrt(fragment_unnamed_1723);
							uint fragment_unnamed_1738 = asuint(fragment_unnamed_1722);
							uint fragment_unnamed_1741 = fragment_unnamed_1724 ? fragment_unnamed_1738 : asuint(fragment_unnamed_1522 * (fragment_unnamed_1523 + ((-0.0f) - fragment_unnamed_1726)));
							float fragment_unnamed_1742 = asfloat(fragment_unnamed_1741);
							uint fragment_unnamed_1743 = fragment_unnamed_1724 ? fragment_unnamed_1738 : asuint(fragment_unnamed_1522 * (fragment_unnamed_1523 + fragment_unnamed_1726));
							float fragment_unnamed_1744 = asfloat(fragment_unnamed_1743);
							uint fragment_unnamed_1745 = asuint(fragment_unnamed_1723);
							uint fragment_unnamed_1750 = fragment_unnamed_1725 ? fragment_unnamed_1745 : asuint(fragment_unnamed_1522 * (fragment_unnamed_1523 + fragment_unnamed_1727));
							bool fragment_unnamed_1755 = fragment_unnamed_1742 >= 0.0f;
							float fragment_unnamed_1760 = ((-0.0f) - fragment_unnamed_1744) + asfloat(fragment_unnamed_1750);
							float fragment_unnamed_1763 = max(asfloat(fragment_unnamed_1725 ? fragment_unnamed_1745 : asuint(fragment_unnamed_1522 * (fragment_unnamed_1523 + ((-0.0f) - fragment_unnamed_1727)))), 0.0f);
							uint fragment_unnamed_1764 = fragment_unnamed_1755 ? fragment_unnamed_1741 : fragment_unnamed_1750;
							float fragment_unnamed_1770 = ((-0.0f) - fragment_unnamed_1763) + asfloat(fragment_unnamed_1764);
							bool fragment_unnamed_1773 = (((fragment_unnamed_1744 < fragment_unnamed_1490) ? 4294967295u : 0u) & (fragment_unnamed_1755 ? 4294967295u : 0u)) != 0u;
							bool fragment_unnamed_1779 = (((fragment_unnamed_1742 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1744 >= 0.0f) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_1784 = asfloat(fragment_unnamed_1779 ? fragment_unnamed_1743 : asuint(fragment_unnamed_1763));
							float fragment_unnamed_1786 = asfloat(fragment_unnamed_1779 ? asuint(fragment_unnamed_1760 * 0.5f) : (fragment_unnamed_1773 ? fragment_unnamed_1743 : asuint(fragment_unnamed_1770 * 0.5f)));
							float fragment_unnamed_1788 = asfloat(fragment_unnamed_1779 ? asuint(fragment_unnamed_1760 * 0.5f) : (fragment_unnamed_1773 ? fragment_unnamed_1764 : asuint(fragment_unnamed_1770 * 0.5f)));
							float fragment_unnamed_1790 = asfloat(fragment_unnamed_1779 ? fragment_unnamed_1750 : (fragment_unnamed_1773 ? fragment_unnamed_1750 : fragment_unnamed_1764));
							float fragment_unnamed_1795 = (-0.0f) - fragment_unnamed_1784;
							float fragment_unnamed_1796 = (-0.0f) - fragment_unnamed_1786;
							float fragment_unnamed_1799 = fragment_unnamed_1795 + min(fragment_unnamed_1490, fragment_unnamed_1788);
							float fragment_unnamed_1800 = fragment_unnamed_1796 + min(fragment_unnamed_1490, fragment_unnamed_1790);
							float fragment_unnamed_1809 = mad(fragment_unnamed_1795 + min(fragment_unnamed_1490, fragment_unnamed_1788), 0.25f, fragment_unnamed_1784);
							float fragment_unnamed_1811 = mad(fragment_unnamed_1796 + min(fragment_unnamed_1490, fragment_unnamed_1790), 0.25f, fragment_unnamed_1786);
							float fragment_unnamed_1812 = mad(fragment_unnamed_1799, 0.75f, fragment_unnamed_1784);
							float fragment_unnamed_1814 = mad(fragment_unnamed_1800, 0.75f, fragment_unnamed_1786);
							float fragment_unnamed_1816 = dot(((-0.0f) - fragment_unnamed_1523).xx, fragment_unnamed_1522.xx);
							float fragment_unnamed_1834 = (-0.0f) - fragment_uniform_buffer_1[82u].w;
							float fragment_unnamed_1870 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1814, fragment_unnamed_1814 + fragment_unnamed_1816, fragment_unnamed_1507)) + fragment_unnamed_1834, fragment_uniform_buffer_3[2u].x, fragment_uniform_buffer_3[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_1800, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1812, fragment_unnamed_1812 + fragment_unnamed_1816, fragment_unnamed_1507)) + fragment_unnamed_1834, fragment_uniform_buffer_3[2u].x, fragment_uniform_buffer_3[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_1799, 0.0f) * 0.5f, ((max(fragment_unnamed_1800, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1811, fragment_unnamed_1811 + fragment_unnamed_1816, fragment_unnamed_1507)) + fragment_unnamed_1834, fragment_uniform_buffer_3[2u].x, fragment_uniform_buffer_3[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_1799, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1809, fragment_unnamed_1809 + fragment_unnamed_1816, fragment_unnamed_1507)) + fragment_unnamed_1834, fragment_uniform_buffer_3[2u].x, fragment_uniform_buffer_3[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
							float fragment_unnamed_1875 = (abs(mad((-0.0f) - mad(fragment_unnamed_1681, 0.5f, (mad(fragment_unnamed_1663, fragment_unnamed_1655, mad(fragment_unnamed_1655, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_1674, fragment_unnamed_1655, sqrt(fragment_unnamed_1655 * mad(fragment_unnamed_1655 * fragment_unnamed_1660, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].z, (-0.0f) - fragment_unnamed_1655) * 1.44269502162933349609375f), asfloat(fragment_unnamed_1607 ? asuint(mad((dot(fragment_unnamed_1609.xx, fragment_unnamed_1611.xx) + fragment_unnamed_1611) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_3[1u].z, (-0.0f) - fragment_unnamed_1609) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_1606)) : asuint(fragment_unnamed_1606)))) * fragment_uniform_buffer_3[1u].w) * fragment_uniform_buffer_3[0u].w;
							float fragment_unnamed_1902 = ((-0.0f) - exp2(mad(fragment_unnamed_1870, fragment_uniform_buffer_3[6u].x, mad(fragment_unnamed_1709, fragment_uniform_buffer_3[3u].x, fragment_unnamed_1875)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1903 = ((-0.0f) - exp2(mad(fragment_unnamed_1870, fragment_uniform_buffer_3[6u].y, mad(fragment_unnamed_1709, fragment_uniform_buffer_3[3u].y, fragment_unnamed_1875)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1904 = ((-0.0f) - exp2(mad(fragment_unnamed_1870, fragment_uniform_buffer_3[6u].z, mad(fragment_unnamed_1709, fragment_uniform_buffer_3[3u].z, fragment_unnamed_1875)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1906 = fragment_unnamed_1904 + (fragment_unnamed_1903 + fragment_unnamed_1902);
							float fragment_unnamed_1907 = fragment_unnamed_1906 * 0.3333333432674407958984375f;
							float fragment_unnamed_1909 = (-0.0f) - fragment_unnamed_1906;
							float fragment_unnamed_1928 = sqrt(((-0.0f) - fragment_unnamed_1431) + 1.0f);
							float fragment_unnamed_1934 = mad(mad(mad(fragment_unnamed_1431, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_1431, -0.212114393711090087890625f), fragment_unnamed_1431, 1.570728778839111328125f);
							float fragment_unnamed_1946 = mad(fragment_unnamed_1934, fragment_unnamed_1928, asfloat(((((-0.0f) - fragment_unnamed_1431) < fragment_unnamed_1431) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_1928 * fragment_unnamed_1934, -2.0f, 3.1415927410125732421875f))));
							float fragment_unnamed_1950 = sqrt(((-0.0f) - abs(fragment_unnamed_1420)) + 1.0f);
							float fragment_unnamed_1956 = mad(mad(mad(abs(fragment_unnamed_1420), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_1420), -0.212114393711090087890625f), abs(fragment_unnamed_1420), 1.570728778839111328125f);
							float fragment_unnamed_1967 = 1.0f / ((-0.0f) - fragment_unnamed_1946);
							float fragment_unnamed_1985 = mad(exp2((clamp(mad(mad(fragment_unnamed_1956, fragment_unnamed_1950, asfloat(((fragment_unnamed_1420 < ((-0.0f) - fragment_unnamed_1420)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_1950 * fragment_unnamed_1956, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_1967, (-0.0f) - (fragment_unnamed_1946 * fragment_unnamed_1967)), 0.0f, 1.0f) * fragment_uniform_buffer_3[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_3[11u].y, (-0.0f) - fragment_uniform_buffer_3[11u].y);
							float fragment_unnamed_2019 = ((-0.0f) - asfloat(fragment_unnamed_1091)) + 1.0f;
							float fragment_unnamed_2020 = ((-0.0f) - fragment_unnamed_1093) + 1.0f;
							float fragment_unnamed_2021 = ((-0.0f) - fragment_unnamed_1095) + 1.0f;
							fragment_unnamed_1310 = asuint(mad(fragment_unnamed_2019, mad(mad(fragment_unnamed_1909, 0.3333333432674407958984375f, fragment_unnamed_1902), fragment_uniform_buffer_3[10u].z, fragment_unnamed_1907) * fragment_uniform_buffer_3[10u].w, asfloat(fragment_unnamed_1091)));
							fragment_unnamed_1311 = mad(fragment_unnamed_2020, mad(mad(fragment_unnamed_1909, 0.3333333432674407958984375f, fragment_unnamed_1903), fragment_uniform_buffer_3[10u].z, fragment_unnamed_1907) * fragment_uniform_buffer_3[10u].w, fragment_unnamed_1093);
							fragment_unnamed_1312 = mad(fragment_unnamed_2021, mad(mad(fragment_unnamed_1909, 0.3333333432674407958984375f, fragment_unnamed_1904), fragment_uniform_buffer_3[10u].z, fragment_unnamed_1907) * fragment_uniform_buffer_3[10u].w, fragment_unnamed_1095);
							fragment_unnamed_1313 = mad(fragment_unnamed_2019, mad(fragment_unnamed_1985, ((-0.0f) - fragment_uniform_buffer_3[8u].x) + fragment_uniform_buffer_3[9u].x, fragment_uniform_buffer_3[8u].x) * fragment_unnamed_1465.x, fragment_unnamed_1097);
							fragment_unnamed_1314 = mad(fragment_unnamed_2020, mad(fragment_unnamed_1985, ((-0.0f) - fragment_uniform_buffer_3[8u].y) + fragment_uniform_buffer_3[9u].y, fragment_uniform_buffer_3[8u].y) * fragment_unnamed_1465.y, fragment_unnamed_1099);
							fragment_unnamed_1315 = mad(fragment_unnamed_2021, mad(fragment_unnamed_1985, ((-0.0f) - fragment_uniform_buffer_3[8u].z) + fragment_uniform_buffer_3[9u].z, fragment_uniform_buffer_3[8u].z) * fragment_unnamed_1465.z, fragment_unnamed_1101);
						}
						else
						{
							fragment_unnamed_1310 = fragment_unnamed_1091;
							fragment_unnamed_1311 = fragment_unnamed_1093;
							fragment_unnamed_1312 = fragment_unnamed_1095;
							fragment_unnamed_1313 = fragment_unnamed_1097;
							fragment_unnamed_1314 = fragment_unnamed_1099;
							fragment_unnamed_1315 = fragment_unnamed_1101;
						}
						fragment_unnamed_738 = fragment_unnamed_1310;
						fragment_unnamed_740 = fragment_unnamed_1311;
						fragment_unnamed_742 = fragment_unnamed_1312;
						fragment_unnamed_744 = fragment_unnamed_1313;
						fragment_unnamed_746 = fragment_unnamed_1314;
						fragment_unnamed_748 = fragment_unnamed_1315;
					}
					else
					{
						fragment_unnamed_738 = fragment_unnamed_1091;
						fragment_unnamed_740 = fragment_unnamed_1093;
						fragment_unnamed_742 = fragment_unnamed_1095;
						fragment_unnamed_744 = fragment_unnamed_1097;
						fragment_unnamed_746 = fragment_unnamed_1099;
						fragment_unnamed_748 = fragment_unnamed_1101;
					}
					fragment_unnamed_737 = fragment_unnamed_738;
					fragment_unnamed_739 = fragment_unnamed_740;
					fragment_unnamed_741 = fragment_unnamed_742;
					fragment_unnamed_743 = fragment_unnamed_744;
					fragment_unnamed_745 = fragment_unnamed_746;
					fragment_unnamed_747 = fragment_unnamed_748;
				}
				else
				{
					fragment_unnamed_737 = fragment_unnamed_527;
					fragment_unnamed_739 = fragment_unnamed_529;
					fragment_unnamed_741 = fragment_unnamed_531;
					fragment_unnamed_743 = asfloat(0u);
					fragment_unnamed_745 = asfloat(0u);
					fragment_unnamed_747 = asfloat(0u);
				}
				float fragment_unnamed_756 = (((-0.0f) - asfloat(fragment_unnamed_737)) + 1.0f) * asfloat(fragment_unnamed_390);
				float fragment_unnamed_757 = (((-0.0f) - fragment_unnamed_739) + 1.0f) * asfloat(fragment_unnamed_392);
				float fragment_unnamed_758 = (((-0.0f) - fragment_unnamed_741) + 1.0f) * asfloat(fragment_unnamed_394);
				float fragment_unnamed_759 = mad(fragment_unnamed_743, fragment_unnamed_361, fragment_unnamed_756);
				float fragment_unnamed_760 = mad(fragment_unnamed_745, fragment_unnamed_361, fragment_unnamed_757);
				float fragment_unnamed_761 = mad(fragment_unnamed_747, fragment_unnamed_361, fragment_unnamed_758);
				fragment_output_0.x = fragment_unnamed_373 ? fragment_unnamed_759 : asfloat(fragment_unnamed_374 ? asuint(fragment_unnamed_756) : (fragment_unnamed_375 ? asuint(fragment_unnamed_759) : fragment_unnamed_390));
				fragment_output_0.y = fragment_unnamed_373 ? fragment_unnamed_760 : asfloat(fragment_unnamed_374 ? asuint(fragment_unnamed_757) : (fragment_unnamed_375 ? asuint(fragment_unnamed_760) : fragment_unnamed_392));
				fragment_output_0.z = fragment_unnamed_373 ? fragment_unnamed_761 : asfloat(fragment_unnamed_374 ? asuint(fragment_unnamed_758) : (fragment_unnamed_375 ? asuint(fragment_unnamed_761) : fragment_unnamed_394));
				fragment_output_0.w = fragment_unnamed_361;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_GlobalFogColor[0], _GlobalFogColor[1], _GlobalFogColor[2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[8] = float4(_InvViewMatrix[0][0], _InvViewMatrix[1][0], _InvViewMatrix[2][0], _InvViewMatrix[3][0]);
				fragment_uniform_buffer_1[9] = float4(_InvViewMatrix[0][1], _InvViewMatrix[1][1], _InvViewMatrix[2][1], _InvViewMatrix[3][1]);
				fragment_uniform_buffer_1[10] = float4(_InvViewMatrix[0][2], _InvViewMatrix[1][2], _InvViewMatrix[2][2], _InvViewMatrix[3][2]);
				fragment_uniform_buffer_1[11] = float4(_InvViewMatrix[0][3], _InvViewMatrix[1][3], _InvViewMatrix[2][3], _InvViewMatrix[3][3]);

				fragment_uniform_buffer_1[28] = float4(_InvViewProjMatrix[0][0], _InvViewProjMatrix[1][0], _InvViewProjMatrix[2][0], _InvViewProjMatrix[3][0]);
				fragment_uniform_buffer_1[29] = float4(_InvViewProjMatrix[0][1], _InvViewProjMatrix[1][1], _InvViewProjMatrix[2][1], _InvViewProjMatrix[3][1]);
				fragment_uniform_buffer_1[30] = float4(_InvViewProjMatrix[0][2], _InvViewProjMatrix[1][2], _InvViewProjMatrix[2][2], _InvViewProjMatrix[3][2]);
				fragment_uniform_buffer_1[31] = float4(_InvViewProjMatrix[0][3], _InvViewProjMatrix[1][3], _InvViewProjMatrix[2][3], _InvViewProjMatrix[3][3]);

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

				fragment_uniform_buffer_1[102] = float4(_BoundsSS[0], _BoundsSS[1], _BoundsSS[2], _BoundsSS[3]);

				fragment_uniform_buffer_1[103] = float4(_UpDirectionX, fragment_uniform_buffer_1[103][1], fragment_uniform_buffer_1[103][2], fragment_uniform_buffer_1[103][3]);

				fragment_uniform_buffer_1[103] = float4(fragment_uniform_buffer_1[103][0], _UpDirectionY, fragment_uniform_buffer_1[103][2], fragment_uniform_buffer_1[103][3]);

				fragment_uniform_buffer_1[107] = float4(asfloat(_UnderWaterSurfaceIndex), fragment_uniform_buffer_1[107][1], fragment_uniform_buffer_1[107][2], fragment_uniform_buffer_1[107][3]);

				fragment_uniform_buffer_1[113] = float4(asfloat(_PreRefractionPass), fragment_uniform_buffer_1[113][1], fragment_uniform_buffer_1[113][2], fragment_uniform_buffer_1[113][3]);

				fragment_uniform_buffer_1[118] = float4(fragment_uniform_buffer_1[118][0], _ProbeExposureScale, fragment_uniform_buffer_1[118][2], fragment_uniform_buffer_1[118][3]);

				fragment_uniform_buffer_1[211] = float4(_OffScreenDownsampleFactor, fragment_uniform_buffer_1[211][1], fragment_uniform_buffer_1[211][2], fragment_uniform_buffer_1[211][3]);

				fragment_uniform_buffer_2[11] = float4(_BlendMode, fragment_uniform_buffer_2[11][1], fragment_uniform_buffer_2[11][2], fragment_uniform_buffer_2[11][3]);

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
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(_ENABLE_FOG_ON_TRANSPARENT) && defined(_SURFACE_TYPE_TRANSPARENT)


			// Fallback Shader Code
			#ifndef ANY_SHADER_VARIANT_ACTIVE

			// https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
			#ifndef DECOMP_DECL_unity_MatrixMVP
			#define DECOMP_DECL_unity_MatrixMVP
			float4x4 unity_MatrixMVP;
			#endif

			struct Vertex_Stage_Input
			{
				float3 pos : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.pos = mul(unity_MatrixMVP, float4(input.pos, 1.0));
				return output;
			}

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				// Output solid grey color (e.g., 50% grey)
				return float4(0.5, 0.5, 0.5, 1.0); // RGBA
			}

			#endif // !ANY_SHADER_VARIANT_ACTIVE


			ENDHLSL
		}
	}
	SubShader
	{
		Tags { "DisableBatching" = "False" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
		Pass
		{
			Name "IndirectDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "IndirectDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 587172

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "VisibilityDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "VisibilityDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 649511

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "ForwardDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "ForwardDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 700216

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "GBufferDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "GBufferDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 755983

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "DebugDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DebugDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 803324

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "PathTracingDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "PathTracingDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 889481

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
