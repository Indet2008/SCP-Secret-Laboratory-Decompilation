Shader "Shader Graphs/VFX_HeatWave_Fresnel"
{
	Properties
	{
		_Scroll_Speed ("Scroll Speed", Vector) = (0,0,0,0)
		_Intensity ("Intensity", Float) = 0
		_Secondary_Scroll_Speed ("Secondary Scroll Speed", Vector) = (0,0,0,0)
		_Distortion_Speed ("Distortion Speed", Vector) = (0,0,0,0)
		_Distortion_Intensity ("Distortion Intensity", Float) = 1
		_Color ("Color", Color) = (0,0,0,0)
		_Noise_scale ("Noise scale", Float) = 10
		[NoScaleOffset] _Base_text ("Base text", 2D) = "white" {}
		[NoScaleOffset] _Distortion_text ("Distortion text", 2D) = "white" {}
		_Base_text_tiling ("Base text tiling", Vector) = (4,4,0,0)
		_Distortion_text_tiling ("Distortion text tiling", Vector) = (5,5,0,0)
		[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
		[HideInInspector] _RenderQueueType ("Float", Float) = 1
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
		[HideInInspector] _SurfaceType ("Float", Float) = 0
		[HideInInspector] _BlendMode ("Float", Float) = 0
		[HideInInspector] _SrcBlend ("Float", Float) = 1
		[HideInInspector] _DstBlend ("Float", Float) = 0
		[HideInInspector] _DstBlend2 ("Float", Float) = 0
		[HideInInspector] _AlphaSrcBlend ("Float", Float) = 1
		[HideInInspector] _AlphaDstBlend ("Float", Float) = 0
		[ToggleUI] [HideInInspector] _ZWrite ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _TransparentZWrite ("Boolean", Float) = 0
		[HideInInspector] _CullMode ("Float", Float) = 2
		[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Boolean", Float) = 1
		[HideInInspector] _CullModeForward ("Float", Float) = 2
		[Enum(Front, 1, Back, 2)] [HideInInspector] _TransparentCullMode ("Float", Float) = 2
		[Enum(UnityEngine.Rendering.HighDefinition.OpaqueCullMode)] [HideInInspector] _OpaqueCullMode ("Float", Float) = 2
		[HideInInspector] _ZTestDepthEqualForOpaque ("Float", Float) = 3
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
		Tags { "DisableBatching" = "False" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
		Pass
		{
			Name "ForwardOnly"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "ForwardOnly" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
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
			GpuProgramID 402028

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
			#ifndef DECOMP_DECL_unity_WorldToObject
			#define DECOMP_DECL_unity_WorldToObject
			float4x4 unity_WorldToObject;
			#endif

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[8];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float3 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_78 = asfloat(1065353216u);
				float vertex_unnamed_80 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_78));
				float vertex_unnamed_109 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_78));
				float vertex_unnamed_139 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_78));
				vertex_output_3.x = vertex_unnamed_109;
				vertex_output_3.y = vertex_unnamed_80;
				vertex_output_3.z = vertex_unnamed_139;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_199 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_200 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_201 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_207 = rsqrt(max(dot(float3(vertex_unnamed_199, vertex_unnamed_200, vertex_unnamed_201), float3(vertex_unnamed_199, vertex_unnamed_200, vertex_unnamed_201)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_207 * vertex_unnamed_199;
				vertex_output_1.y = vertex_unnamed_207 * vertex_unnamed_200;
				vertex_output_1.z = vertex_unnamed_207 * vertex_unnamed_201;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				float vertex_unnamed_241 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_256 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_271 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_278 = rsqrt(max(dot(float3(vertex_unnamed_241, vertex_unnamed_256, vertex_unnamed_271), float3(vertex_unnamed_241, vertex_unnamed_256, vertex_unnamed_271)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_278 * vertex_unnamed_241;
				vertex_output_4.y = vertex_unnamed_278 * vertex_unnamed_256;
				vertex_output_4.z = vertex_unnamed_278 * vertex_unnamed_271;
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


			#ifndef DECOMP_DECL__OffScreenRendering
			#define DECOMP_DECL__OffScreenRendering
			#endif

			static float4 fragment_uniform_buffer_0[212];
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				fragment_output_0.w = (asuint(fragment_uniform_buffer_0[211u]).y != 0u) ? 0.0f : 1.0f;
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[211] = float4(fragment_uniform_buffer_0[211][0], asfloat(_OffScreenRendering), fragment_uniform_buffer_0[211][2], fragment_uniform_buffer_0[211][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			#ifndef DECOMP_DECL_unity_WorldToObject
			#define DECOMP_DECL_unity_WorldToObject
			float4x4 unity_WorldToObject;
			#endif

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[8];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float3 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_78 = asfloat(1065353216u);
				float vertex_unnamed_80 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_78));
				float vertex_unnamed_109 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_78));
				float vertex_unnamed_139 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_78));
				vertex_output_3.x = vertex_unnamed_109;
				vertex_output_3.y = vertex_unnamed_80;
				vertex_output_3.z = vertex_unnamed_139;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_199 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_200 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_201 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_207 = rsqrt(max(dot(float3(vertex_unnamed_199, vertex_unnamed_200, vertex_unnamed_201), float3(vertex_unnamed_199, vertex_unnamed_200, vertex_unnamed_201)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_207 * vertex_unnamed_199;
				vertex_output_1.y = vertex_unnamed_207 * vertex_unnamed_200;
				vertex_output_1.z = vertex_unnamed_207 * vertex_unnamed_201;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				float vertex_unnamed_241 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_256 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_271 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_278 = rsqrt(max(dot(float3(vertex_unnamed_241, vertex_unnamed_256, vertex_unnamed_271), float3(vertex_unnamed_241, vertex_unnamed_256, vertex_unnamed_271)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_278 * vertex_unnamed_241;
				vertex_output_4.y = vertex_unnamed_278 * vertex_unnamed_256;
				vertex_output_4.z = vertex_unnamed_278 * vertex_unnamed_271;
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

			#endif // defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_ENABLE_FOG_ON_TRANSPARENT)


			#if defined(_SURFACE_TYPE_TRANSPARENT)
			#define ANY_SHADER_VARIANT_ACTIVE

			#ifndef DECOMP_DECL__ViewMatrix
			#define DECOMP_DECL__ViewMatrix
			#endif
			#ifndef DECOMP_DECL__InvViewMatrix
			#define DECOMP_DECL__InvViewMatrix
			#endif
			#ifndef DECOMP_DECL__ProjMatrix
			#define DECOMP_DECL__ProjMatrix
			#endif
			#ifndef DECOMP_DECL__InvViewProjMatrix
			#define DECOMP_DECL__InvViewProjMatrix
			#endif
			#ifndef DECOMP_DECL__ScreenSize
			#define DECOMP_DECL__ScreenSize
			#endif
			#ifndef DECOMP_DECL__ProjectionParams
			#define DECOMP_DECL__ProjectionParams
			#endif
			#ifndef DECOMP_DECL__ScreenParams
			#define DECOMP_DECL__ScreenParams
			#endif
			#ifndef DECOMP_DECL__TimeParameters
			#define DECOMP_DECL__TimeParameters
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
			#ifndef DECOMP_DECL__GlobalMipBias
			#define DECOMP_DECL__GlobalMipBias
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
			#ifndef DECOMP_DECL__DeExposureMultiplier
			#define DECOMP_DECL__DeExposureMultiplier
			#endif
			#ifndef DECOMP_DECL__ColorPyramidUvScaleAndLimitCurrentFrame
			#define DECOMP_DECL__ColorPyramidUvScaleAndLimitCurrentFrame
			#endif
			#ifndef DECOMP_DECL__Scroll_Speed
			#define DECOMP_DECL__Scroll_Speed
			float2 _Scroll_Speed;
			#endif
			#ifndef DECOMP_DECL__Intensity
			#define DECOMP_DECL__Intensity
			float _Intensity;
			#endif
			#ifndef DECOMP_DECL__Secondary_Scroll_Speed
			#define DECOMP_DECL__Secondary_Scroll_Speed
			float2 _Secondary_Scroll_Speed;
			#endif
			#ifndef DECOMP_DECL__Color
			#define DECOMP_DECL__Color
			float4 _Color;
			#endif
			#ifndef DECOMP_DECL__Base_text_tiling
			#define DECOMP_DECL__Base_text_tiling
			float2 _Base_text_tiling;
			#endif
			#ifndef DECOMP_DECL__Distortion_text_tiling
			#define DECOMP_DECL__Distortion_text_tiling
			float2 _Distortion_text_tiling;
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

			static float4 fragment_uniform_buffer_0[220];
			static float4 fragment_uniform_buffer_1[16];
			static float4 fragment_uniform_buffer_2[12];
			Texture2DArray<float4> _ColorPyramidTexture;
			Texture2D<float4> _ExposureTexture;
			TextureCubeArray<float4> _SkyTexture;
			Texture2D<float4> _Base_text;
			Texture2D<float4> _Distortion_text;
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
			SamplerState sampler_Base_text;
			SamplerState sampler_Distortion_text;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_104 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_112 = fragment_unnamed_104 * fragment_input_4.x;
				float fragment_unnamed_113 = fragment_unnamed_104 * fragment_input_4.y;
				float fragment_unnamed_114 = fragment_unnamed_104 * fragment_input_4.z;
				bool fragment_unnamed_123 = 0u < asuint(fragment_uniform_buffer_0[211u]).y;
				float fragment_unnamed_143 = fragment_unnamed_123 ? float(uint(round(gl_FragCoord.x * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.x;
				float fragment_unnamed_144 = fragment_unnamed_123 ? float(uint(round(gl_FragCoord.y * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.y;
				bool fragment_unnamed_149 = fragment_uniform_buffer_0[15u].w == 0.0f;
				uint4 fragment_unnamed_172 = asuint(fragment_uniform_buffer_0[0u]);
				uint fragment_unnamed_173 = fragment_unnamed_172.z;
				uint4 fragment_unnamed_177 = asuint(fragment_uniform_buffer_0[1u]);
				uint fragment_unnamed_178 = fragment_unnamed_177.z;
				uint4 fragment_unnamed_182 = asuint(fragment_uniform_buffer_0[2u]);
				uint fragment_unnamed_183 = fragment_unnamed_182.z;
				float fragment_unnamed_189 = asfloat(fragment_unnamed_149 ? asuint(((-0.0f) - fragment_input_3.x) + fragment_uniform_buffer_0[11u].x) : fragment_unnamed_173);
				float fragment_unnamed_191 = asfloat(fragment_unnamed_149 ? asuint(((-0.0f) - fragment_input_3.y) + fragment_uniform_buffer_0[11u].y) : fragment_unnamed_178);
				float fragment_unnamed_193 = asfloat(fragment_unnamed_149 ? asuint(((-0.0f) - fragment_input_3.z) + fragment_uniform_buffer_0[11u].z) : fragment_unnamed_183);
				float fragment_unnamed_197 = rsqrt(dot(float3(fragment_unnamed_189, fragment_unnamed_191, fragment_unnamed_193), float3(fragment_unnamed_189, fragment_unnamed_191, fragment_unnamed_193)));
				float fragment_unnamed_198 = fragment_unnamed_197 * fragment_unnamed_189;
				float fragment_unnamed_199 = fragment_unnamed_197 * fragment_unnamed_191;
				float fragment_unnamed_200 = fragment_unnamed_197 * fragment_unnamed_193;
				float fragment_unnamed_204 = rsqrt(dot(float3(fragment_unnamed_112, fragment_unnamed_113, fragment_unnamed_114), float3(fragment_unnamed_112, fragment_unnamed_113, fragment_unnamed_114)));
				float4 fragment_unnamed_260 = _Base_text.SampleBias(sampler_Base_text, float2(mad(fragment_uniform_buffer_0[80u].x, fragment_uniform_buffer_1[0u].x, fragment_input_2.x * fragment_uniform_buffer_1[7u].x), mad(fragment_uniform_buffer_0[80u].x, fragment_uniform_buffer_1[0u].y, fragment_input_2.y * fragment_uniform_buffer_1[7u].y)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_263 = fragment_unnamed_260.x;
				float fragment_unnamed_273 = mad(fragment_uniform_buffer_1[1u].x, fragment_uniform_buffer_0[80u].x, fragment_input_2.x * fragment_uniform_buffer_1[7u].z) + (-0.5f);
				float fragment_unnamed_275 = mad(fragment_uniform_buffer_1[1u].y, fragment_uniform_buffer_0[80u].x, fragment_input_2.y * fragment_uniform_buffer_1[7u].w) + (-0.5f);
				float fragment_unnamed_297 = mad(((-0.0f) - fragment_unnamed_263) + _Distortion_text.SampleBias(sampler_Distortion_text, float2(dot(float2(fragment_unnamed_273, fragment_unnamed_275), float2(-0.6549880504608154296875f, 0.7556393146514892578125f)) + 0.5f, dot(float2(fragment_unnamed_273, fragment_unnamed_275), float2(-0.755639255046844482421875f, -0.6549880504608154296875f)) + 0.5f), fragment_uniform_buffer_0[86u].y).x, 0.300000011920928955078125f, fragment_unnamed_263);
				float4 fragment_unnamed_316 = _ColorPyramidTexture.SampleLevel(s1_linear_clamp, float3(mad(fragment_unnamed_297, fragment_uniform_buffer_1[0u].z, fragment_unnamed_143 / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[219u].x, mad(fragment_unnamed_297, fragment_uniform_buffer_1[0u].z, ((-0.0f) - (asfloat((fragment_uniform_buffer_0[58u].x < 0.0f) ? asuint(((-0.0f) - fragment_unnamed_144) + fragment_uniform_buffer_0[61u].y) : asuint(fragment_unnamed_144)) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[219u].y, asfloat(0u)), 0.0f);
				float4 fragment_unnamed_321 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u));
				float fragment_unnamed_324 = fragment_unnamed_321.x;
				float fragment_unnamed_329 = fragment_unnamed_324 * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_340 = 1.0f / mad(fragment_unnamed_324, fragment_uniform_buffer_0[118u].y, asfloat(((fragment_unnamed_329 == 0.0f) ? 4294967295u : 0u) & 1065353216u));
				float fragment_unnamed_341 = fragment_unnamed_340 * fragment_unnamed_316.x;
				float fragment_unnamed_342 = fragment_unnamed_340 * fragment_unnamed_316.y;
				float fragment_unnamed_343 = fragment_unnamed_340 * fragment_unnamed_316.z;
				float fragment_unnamed_350 = fragment_unnamed_341 * fragment_uniform_buffer_1[3u].x;
				float fragment_unnamed_351 = fragment_unnamed_342 * fragment_uniform_buffer_1[3u].y;
				float fragment_unnamed_352 = fragment_unnamed_343 * fragment_uniform_buffer_1[3u].z;
				float fragment_unnamed_357 = clamp((fragment_unnamed_297 + (-0.226047098636627197265625f)) * 3.803761005401611328125f, 0.0f, 1.0f);
				float fragment_unnamed_358 = mad(fragment_unnamed_357, 0.61236202716827392578125f, 0.01027945987880229949951171875f);
				float fragment_unnamed_361 = mad(fragment_unnamed_357, 0.5992424488067626953125f, 0.02339903078973293304443359375f);
				float fragment_unnamed_364 = mad(fragment_unnamed_357, 0.55660378932952880859375f, 0.066037707030773162841796875f);
				float fragment_unnamed_375 = mad((-0.0f) - fragment_uniform_buffer_1[3u].x, fragment_unnamed_341, 1.0f);
				float fragment_unnamed_376 = mad((-0.0f) - fragment_uniform_buffer_1[3u].y, fragment_unnamed_342, 1.0f);
				float fragment_unnamed_377 = mad((-0.0f) - fragment_uniform_buffer_1[3u].z, fragment_unnamed_343, 1.0f);
				float fragment_unnamed_393 = fragment_unnamed_350 * fragment_unnamed_358;
				float fragment_unnamed_394 = fragment_unnamed_351 * fragment_unnamed_361;
				float fragment_unnamed_395 = fragment_unnamed_352 * fragment_unnamed_364;
				bool fragment_unnamed_399 = 0.5f >= fragment_unnamed_350;
				bool fragment_unnamed_400 = 0.5f >= fragment_unnamed_351;
				bool fragment_unnamed_401 = 0.5f >= fragment_unnamed_352;
				float fragment_unnamed_449 = ((-0.0f) - exp2(log2(((-0.0f) - clamp(dot(float3(fragment_unnamed_204 * fragment_unnamed_112, fragment_unnamed_204 * fragment_unnamed_113, fragment_unnamed_204 * fragment_unnamed_114), float3(fragment_unnamed_198, fragment_unnamed_199, fragment_unnamed_200)), 0.0f, 1.0f)) + 1.0f) * 5.070000171661376953125f)) + 1.0f;
				float fragment_unnamed_454 = mad(mad((-0.0f) - fragment_uniform_buffer_1[3u].x, fragment_unnamed_341, mad(fragment_unnamed_393 + fragment_unnamed_393, asfloat((fragment_unnamed_399 ? 4294967295u : 0u) & 1065353216u), mad((-0.0f) - (fragment_unnamed_375 + fragment_unnamed_375), ((-0.0f) - fragment_unnamed_358) + 1.0f, 1.0f) * asfloat(fragment_unnamed_399 ? 0u : 1065353216u))), 0.100000001490116119384765625f, fragment_unnamed_350) * fragment_uniform_buffer_0[214u].w;
				float fragment_unnamed_455 = mad(mad((-0.0f) - fragment_uniform_buffer_1[3u].y, fragment_unnamed_342, mad(fragment_unnamed_394 + fragment_unnamed_394, asfloat((fragment_unnamed_400 ? 4294967295u : 0u) & 1065353216u), mad((-0.0f) - (fragment_unnamed_376 + fragment_unnamed_376), ((-0.0f) - fragment_unnamed_361) + 1.0f, 1.0f) * asfloat(fragment_unnamed_400 ? 0u : 1065353216u))), 0.100000001490116119384765625f, fragment_unnamed_351) * fragment_uniform_buffer_0[214u].w;
				float fragment_unnamed_456 = mad(mad((-0.0f) - fragment_uniform_buffer_1[3u].z, fragment_unnamed_343, mad(fragment_unnamed_395 + fragment_unnamed_395, asfloat((fragment_unnamed_401 ? 4294967295u : 0u) & 1065353216u), mad((-0.0f) - (fragment_unnamed_377 + fragment_unnamed_377), ((-0.0f) - fragment_unnamed_364) + 1.0f, 1.0f) * asfloat(fragment_unnamed_401 ? 0u : 1065353216u))), 0.100000001490116119384765625f, fragment_unnamed_352) * fragment_uniform_buffer_0[214u].w;
				bool fragment_unnamed_460 = fragment_uniform_buffer_1[15u].x == 0.0f;
				bool fragment_unnamed_461 = fragment_uniform_buffer_1[15u].x == 1.0f;
				bool fragment_unnamed_462 = fragment_uniform_buffer_1[15u].x == 4.0f;
				bool fragment_unnamed_470 = ((fragment_unnamed_461 ? 4294967295u : 0u) | (fragment_unnamed_460 ? 4294967295u : 0u)) != 0u;
				uint fragment_unnamed_477 = fragment_unnamed_470 ? asuint(fragment_unnamed_449 * fragment_unnamed_454) : asuint(fragment_unnamed_454);
				uint fragment_unnamed_479 = fragment_unnamed_470 ? asuint(fragment_unnamed_449 * fragment_unnamed_455) : asuint(fragment_unnamed_455);
				uint fragment_unnamed_481 = fragment_unnamed_470 ? asuint(fragment_unnamed_449 * fragment_unnamed_456) : asuint(fragment_unnamed_456);
				float fragment_unnamed_616;
				float fragment_unnamed_618;
				float fragment_unnamed_620;
				float fragment_unnamed_622;
				float fragment_unnamed_624;
				if (asuint(fragment_uniform_buffer_0[211u]).y != 1u)
				{
					uint fragment_unnamed_488 = uint(fragment_unnamed_143);
					uint fragment_unnamed_489 = uint(fragment_unnamed_144);
					float fragment_unnamed_496 = float(fragment_unnamed_488);
					float fragment_unnamed_497 = float(fragment_unnamed_489);
					uint fragment_unnamed_518 = min(T9.Load(1u).x, max(((-T9.Load(0u).x) + 4294967295u), uint(round(dot(float2(fragment_unnamed_496, fragment_unnamed_497), float2(fragment_uniform_buffer_0[103u].y * 1.0f, fragment_uniform_buffer_0[103u].x * (-1.0f))) + ((-0.0f) - fragment_uniform_buffer_0[102u].x)))));
					bool fragment_unnamed_551 = ((((-0.0f) - float((T9.Load(fragment_unnamed_518 + 2u).x & 65535u) + 4294967295u)) + floor(dot(float2(fragment_unnamed_496, fragment_unnamed_497), float2(fragment_uniform_buffer_0[103u].xy)) + ((-0.0f) - fragment_uniform_buffer_0[102u].z))) / (((-0.0f) - fragment_uniform_buffer_0[102u].z) + fragment_uniform_buffer_0[102u].w)) < 0.0f;
					uint fragment_unnamed_552 = fragment_unnamed_551 ? 4294967295u : 0u;
					float fragment_unnamed_553 = asfloat(fragment_unnamed_552);
					float fragment_unnamed_617;
					float fragment_unnamed_619;
					float fragment_unnamed_621;
					float fragment_unnamed_623;
					float fragment_unnamed_625;
					if (asuint(fragment_uniform_buffer_0[113u]).x != 0u)
					{
						float4 fragment_unnamed_565 = _RefractiveDepthBuffer.Load(int4(uint3(fragment_unnamed_488, fragment_unnamed_489, 0u), 0u));
						float fragment_unnamed_568 = fragment_unnamed_565.x;
						uint4 fragment_unnamed_569 = _StencilTexture.Load(int4(uint3(fragment_unnamed_488, fragment_unnamed_489, 0u), 0u));
						uint fragment_unnamed_571 = fragment_unnamed_569.y;
						uint fragment_unnamed_573 = fragment_unnamed_571 & 32u;
						uint fragment_unnamed_610 = ((fragment_unnamed_571 & 1u) != 0u) ? 4294967295u : ((((((fragment_unnamed_552 & ((fragment_unnamed_573 != 0u) ? 4294967295u : 0u)) & ((fragment_unnamed_568 >= gl_FragCoord.z) ? 4294967295u : 0u)) != 0u) ? 3.4028234663852885981170418348452e+38f : gl_FragCoord.z) < asfloat(fragment_unnamed_551 ? 2139095039u : ((fragment_unnamed_573 != 0u) ? asuint(fragment_unnamed_568) : 0u))) ? (fragment_unnamed_551 ? asuint(fragment_uniform_buffer_0[107u]).x : (uint(_WaterGBufferTexture3.Load(int4(uint3(fragment_unnamed_488, fragment_unnamed_489, 0u), 0u)).w * 255.0f) & 15u)) : 4294967295u);
						float fragment_unnamed_636;
						float fragment_unnamed_637;
						float fragment_unnamed_638;
						float fragment_unnamed_639;
						float fragment_unnamed_640;
						if (fragment_unnamed_610 == 4294967295u)
						{
							fragment_unnamed_636 = asfloat(0u);
							fragment_unnamed_637 = asfloat(0u);
							fragment_unnamed_638 = asfloat(0u);
							fragment_unnamed_639 = asfloat(0u);
							fragment_unnamed_640 = asfloat(0u);
						}
						else
						{
							float fragment_unnamed_671;
							float fragment_unnamed_672;
							float fragment_unnamed_673;
							if (fragment_unnamed_552 == 0u)
							{
								uint fragment_unnamed_677 = (fragment_unnamed_610 * 28u) + 4u;
								uint3 fragment_unnamed_686 = uint3(T11.Load(fragment_unnamed_677).x, T11.Load(fragment_unnamed_677 + 1u).x, T11.Load(fragment_unnamed_677 + 2u).x);
								float fragment_unnamed_699 = mad(fragment_unnamed_496 * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
								float fragment_unnamed_702 = (-0.0f) - mad(fragment_unnamed_497 * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
								float fragment_unnamed_745 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_568, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_699, fragment_unnamed_702 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
								float fragment_unnamed_758 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_568, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_699, fragment_unnamed_702 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_745)) + fragment_input_3.x;
								float fragment_unnamed_759 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_568, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_699, fragment_unnamed_702 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_745)) + fragment_input_3.y;
								float fragment_unnamed_760 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_568, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_699, fragment_unnamed_702 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_745)) + fragment_input_3.z;
								float fragment_unnamed_764 = sqrt(dot(float3(fragment_unnamed_758, fragment_unnamed_759, fragment_unnamed_760), float3(fragment_unnamed_758, fragment_unnamed_759, fragment_unnamed_760)));
								float fragment_unnamed_765 = fragment_unnamed_764 + fragment_unnamed_764;
								fragment_unnamed_671 = ((-0.0f) - exp2((asfloat(fragment_unnamed_686.x) * fragment_unnamed_765) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_672 = ((-0.0f) - exp2((asfloat(fragment_unnamed_686.y) * fragment_unnamed_765) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_673 = ((-0.0f) - exp2((asfloat(fragment_unnamed_686.z) * fragment_unnamed_765) * (-1.44269502162933349609375f))) + 1.0f;
							}
							else
							{
								fragment_unnamed_671 = asfloat(0u);
								fragment_unnamed_672 = asfloat(0u);
								fragment_unnamed_673 = asfloat(0u);
							}
							fragment_unnamed_636 = fragment_unnamed_553;
							fragment_unnamed_637 = fragment_unnamed_671;
							fragment_unnamed_638 = fragment_unnamed_672;
							fragment_unnamed_639 = fragment_unnamed_673;
							fragment_unnamed_640 = asfloat(~fragment_unnamed_552);
						}
						fragment_unnamed_617 = fragment_unnamed_636;
						fragment_unnamed_619 = fragment_unnamed_637;
						fragment_unnamed_621 = fragment_unnamed_638;
						fragment_unnamed_623 = fragment_unnamed_639;
						fragment_unnamed_625 = fragment_unnamed_640;
					}
					else
					{
						fragment_unnamed_617 = fragment_unnamed_553;
						fragment_unnamed_619 = asfloat(0u);
						fragment_unnamed_621 = asfloat(0u);
						fragment_unnamed_623 = asfloat(0u);
						fragment_unnamed_625 = asfloat(0u);
					}
					fragment_unnamed_616 = fragment_unnamed_617;
					fragment_unnamed_618 = fragment_unnamed_619;
					fragment_unnamed_620 = fragment_unnamed_621;
					fragment_unnamed_622 = fragment_unnamed_623;
					fragment_unnamed_624 = fragment_unnamed_625;
				}
				else
				{
					fragment_unnamed_616 = asfloat(0u);
					fragment_unnamed_618 = asfloat(0u);
					fragment_unnamed_620 = asfloat(0u);
					fragment_unnamed_622 = asfloat(0u);
					fragment_unnamed_624 = asfloat(0u);
				}
				float fragment_unnamed_794;
				float fragment_unnamed_796;
				float fragment_unnamed_798;
				float fragment_unnamed_800;
				float fragment_unnamed_802;
				float fragment_unnamed_804;
				if (asuint(fragment_unnamed_624) == 0u)
				{
					float fragment_unnamed_646 = fragment_unnamed_143 * fragment_uniform_buffer_0[50u].z;
					float fragment_unnamed_647 = fragment_unnamed_144 * fragment_uniform_buffer_0[50u].w;
					float fragment_unnamed_648 = (-0.0f) - fragment_unnamed_198;
					float fragment_unnamed_649 = (-0.0f) - fragment_unnamed_199;
					float fragment_unnamed_650 = (-0.0f) - fragment_unnamed_200;
					float fragment_unnamed_657 = 1.0f / dot(float3(fragment_unnamed_648, fragment_unnamed_649, fragment_unnamed_650), float3((-0.0f) - asfloat(fragment_unnamed_173), (-0.0f) - asfloat(fragment_unnamed_178), (-0.0f) - asfloat(fragment_unnamed_183)));
					float fragment_unnamed_661 = fragment_unnamed_657 * (1.0f / gl_FragCoord.w);
					float fragment_unnamed_877;
					float fragment_unnamed_879;
					float fragment_unnamed_881;
					float fragment_unnamed_883;
					float fragment_unnamed_885;
					float fragment_unnamed_886;
					float fragment_unnamed_887;
					if (asuint(fragment_uniform_buffer_0[84u]).x != 0u)
					{
						float fragment_unnamed_888;
						float fragment_unnamed_1069;
						float fragment_unnamed_1071;
						float fragment_unnamed_1073;
						float fragment_unnamed_1075;
						if (asuint(fragment_uniform_buffer_0[84u]).z != 0u)
						{
							float fragment_unnamed_864 = mad((-0.0f) - fragment_uniform_buffer_0[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_0[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_657, (-0.0f) - fragment_uniform_buffer_0[94u].z), 0.0f)), fragment_uniform_buffer_0[94u].x));
							float fragment_unnamed_1160;
							float fragment_unnamed_1161;
							float fragment_unnamed_1162;
							float fragment_unnamed_1163;
							if (asuint(fragment_uniform_buffer_0[89u]).w == 0u)
							{
								float fragment_unnamed_896 = fragment_unnamed_646 * fragment_uniform_buffer_0[91u].x;
								float fragment_unnamed_897 = fragment_unnamed_647 * fragment_uniform_buffer_0[91u].y;
								float fragment_unnamed_898 = floor(fragment_unnamed_896);
								float fragment_unnamed_899 = floor(fragment_unnamed_897);
								float fragment_unnamed_904 = ((-0.0f) - frac(fragment_unnamed_896)) + 1.0f;
								float fragment_unnamed_905 = ((-0.0f) - frac(fragment_unnamed_897)) + 1.0f;
								float fragment_unnamed_906 = fragment_unnamed_905 * fragment_unnamed_905;
								float fragment_unnamed_907 = fragment_unnamed_904 * fragment_unnamed_904;
								float fragment_unnamed_912 = mad(((-0.0f) - fragment_unnamed_904) + 1.0f, fragment_unnamed_904, 0.5f);
								float fragment_unnamed_913 = mad(((-0.0f) - fragment_unnamed_905) + 1.0f, fragment_unnamed_905, 0.5f);
								float fragment_unnamed_920 = ((-0.0f) - fragment_unnamed_912) + mad((-0.0f) - fragment_unnamed_907, 0.5f, 1.0f);
								float fragment_unnamed_921 = ((-0.0f) - fragment_unnamed_913) + mad((-0.0f) - fragment_unnamed_906, 0.5f, 1.0f);
								float fragment_unnamed_922 = fragment_unnamed_912 * 0.5f;
								float fragment_unnamed_923 = fragment_unnamed_913 * 0.5f;
								float fragment_unnamed_924 = mad(fragment_unnamed_906, 0.5f, fragment_unnamed_923);
								float fragment_unnamed_925 = mad(fragment_unnamed_907, 0.5f, fragment_unnamed_922);
								float fragment_unnamed_926 = mad(fragment_unnamed_912, 0.5f, fragment_unnamed_920);
								float fragment_unnamed_927 = mad(fragment_unnamed_913, 0.5f, fragment_unnamed_921);
								float fragment_unnamed_930 = mad(fragment_unnamed_922, 1.0f / fragment_unnamed_925, -0.5f);
								float fragment_unnamed_931 = mad(fragment_unnamed_923, 1.0f / fragment_unnamed_924, -0.5f);
								float fragment_unnamed_934 = mad(fragment_unnamed_920, 1.0f / fragment_unnamed_926, 0.5f);
								float fragment_unnamed_935 = mad(fragment_unnamed_921, 1.0f / fragment_unnamed_927, 0.5f);
								float fragment_unnamed_945 = fragment_uniform_buffer_0[91u].z * fragment_uniform_buffer_0[92u].x;
								float fragment_unnamed_946 = fragment_uniform_buffer_0[91u].w * fragment_uniform_buffer_0[92u].y;
								float fragment_unnamed_966 = fragment_unnamed_864 * fragment_uniform_buffer_0[92u].z;
								float fragment_unnamed_967 = fragment_unnamed_924 * fragment_unnamed_925;
								float4 fragment_unnamed_979 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_945 * (fragment_unnamed_898 + fragment_unnamed_930), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_946 * (fragment_unnamed_899 + fragment_unnamed_931), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_966, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_985 = fragment_unnamed_924 * fragment_unnamed_926;
								float fragment_unnamed_986 = fragment_unnamed_925 * fragment_unnamed_927;
								float4 fragment_unnamed_995 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_945 * (fragment_unnamed_898 + fragment_unnamed_934), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_946 * (fragment_unnamed_899 + fragment_unnamed_931), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_966, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float4 fragment_unnamed_1017 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_945 * (fragment_unnamed_898 + fragment_unnamed_930), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_946 * (fragment_unnamed_899 + fragment_unnamed_935), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_966, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_1027 = fragment_unnamed_927 * fragment_unnamed_926;
								float4 fragment_unnamed_1036 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_945 * (fragment_unnamed_898 + fragment_unnamed_934), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_946 * (fragment_unnamed_899 + fragment_unnamed_935), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_966, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_1160 = mad(fragment_unnamed_1027, fragment_unnamed_1036.x, mad(fragment_unnamed_986, fragment_unnamed_1017.x, mad(fragment_unnamed_967, fragment_unnamed_979.x, fragment_unnamed_985 * fragment_unnamed_995.x)));
								fragment_unnamed_1161 = mad(fragment_unnamed_1027, fragment_unnamed_1036.y, mad(fragment_unnamed_986, fragment_unnamed_1017.y, mad(fragment_unnamed_967, fragment_unnamed_979.y, fragment_unnamed_985 * fragment_unnamed_995.y)));
								fragment_unnamed_1162 = mad(fragment_unnamed_1027, fragment_unnamed_1036.z, mad(fragment_unnamed_986, fragment_unnamed_1017.z, mad(fragment_unnamed_967, fragment_unnamed_979.z, fragment_unnamed_985 * fragment_unnamed_995.z)));
								fragment_unnamed_1163 = mad(fragment_unnamed_1027, fragment_unnamed_1036.w, mad(fragment_unnamed_986, fragment_unnamed_1017.w, mad(fragment_unnamed_967, fragment_unnamed_979.w, fragment_unnamed_985 * fragment_unnamed_995.w)));
							}
							else
							{
								float4 fragment_unnamed_1063 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_646 * fragment_uniform_buffer_0[92u].x, fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_647 * fragment_uniform_buffer_0[92u].y, fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_864 * fragment_uniform_buffer_0[92u].z, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_1160 = fragment_unnamed_1063.x;
								fragment_unnamed_1161 = fragment_unnamed_1063.y;
								fragment_unnamed_1162 = fragment_unnamed_1063.z;
								fragment_unnamed_1163 = fragment_unnamed_1063.w;
							}
							float fragment_unnamed_1076 = ((-0.0f) - exp2(fragment_unnamed_1163 * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1173 = asfloat((fragment_unnamed_1076 >= 5.9604644775390625e-08f) ? asuint(fragment_unnamed_1076 * (1.0f / fragment_unnamed_1163)) : 1065353216u);
							fragment_unnamed_1069 = fragment_unnamed_1160 * fragment_unnamed_1173;
							fragment_unnamed_1071 = fragment_unnamed_1161 * fragment_unnamed_1173;
							fragment_unnamed_1073 = fragment_unnamed_1162 * fragment_unnamed_1173;
							fragment_unnamed_1075 = fragment_unnamed_1076;
							fragment_unnamed_888 = asfloat(asuint(fragment_uniform_buffer_0[96u]).w);
						}
						else
						{
							fragment_unnamed_1069 = asfloat(0u);
							fragment_unnamed_1071 = asfloat(0u);
							fragment_unnamed_1073 = asfloat(0u);
							fragment_unnamed_1075 = asfloat(0u);
							fragment_unnamed_888 = asfloat(0u);
						}
						float fragment_unnamed_1082 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_657, (-0.0f) - fragment_unnamed_888);
						float fragment_unnamed_878;
						float fragment_unnamed_880;
						float fragment_unnamed_882;
						float fragment_unnamed_884;
						if (((~asuint(fragment_unnamed_616)) & ((0.0f < fragment_unnamed_1082) ? 4294967295u : 0u)) != 0u)
						{
							float fragment_unnamed_1184 = dot(float3(fragment_unnamed_198, fragment_unnamed_199, fragment_unnamed_200), float3(fragment_uniform_buffer_0[83u].xyz));
							float fragment_unnamed_1188 = fragment_unnamed_888 * ((-0.0f) - fragment_unnamed_1184);
							float fragment_unnamed_1202 = max(abs(fragment_unnamed_1184), 0.001000000047497451305389404296875f);
							float fragment_unnamed_1204 = 1.0f / fragment_unnamed_1202;
							float fragment_unnamed_1207 = min(mad(fragment_unnamed_1082, (-0.0f) - fragment_unnamed_1184, fragment_unnamed_1188), fragment_unnamed_1188);
							float fragment_unnamed_1221 = min(fragment_unnamed_1082, max(fragment_unnamed_1204 * (((-0.0f) - fragment_unnamed_1207) + fragment_uniform_buffer_0[89u].y), 0.0f));
							float fragment_unnamed_1254 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_1202 * ((-0.0f) - (fragment_unnamed_1082 + ((-0.0f) - fragment_unnamed_1221)))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_1207 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_1204 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_1221) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_1256 = ((-0.0f) - fragment_unnamed_1075) + 1.0f;
							float fragment_unnamed_2068;
							float fragment_unnamed_2069;
							float fragment_unnamed_2070;
							if (fragment_uniform_buffer_0[86u].x == 1.0f)
							{
								float4 fragment_unnamed_1388 = _SkyTexture.SampleLevel(s1_linear_clamp, float4(fragment_unnamed_648, fragment_unnamed_649, fragment_unnamed_650, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_0[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_657, (-0.0f) - fragment_uniform_buffer_0[87u].x) / (((-0.0f) - fragment_uniform_buffer_0[87u].x) + fragment_uniform_buffer_0[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_2068 = fragment_unnamed_1388.x * fragment_uniform_buffer_0[85u].x;
								fragment_unnamed_2069 = fragment_unnamed_1388.y * fragment_uniform_buffer_0[85u].y;
								fragment_unnamed_2070 = fragment_unnamed_1388.z * fragment_uniform_buffer_0[85u].z;
							}
							else
							{
								uint4 fragment_unnamed_1404 = asuint(fragment_uniform_buffer_0[85u]);
								fragment_unnamed_2068 = asfloat(fragment_unnamed_1404.x);
								fragment_unnamed_2069 = asfloat(fragment_unnamed_1404.y);
								fragment_unnamed_2070 = asfloat(fragment_unnamed_1404.z);
							}
							float fragment_unnamed_2081 = ((-0.0f) - fragment_unnamed_1254) + 1.0f;
							fragment_unnamed_878 = mad((fragment_uniform_buffer_0[88u].x / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_329 * (fragment_unnamed_1256 * fragment_unnamed_2068)), fragment_unnamed_2081, fragment_unnamed_1069);
							fragment_unnamed_880 = mad((fragment_uniform_buffer_0[88u].y / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_329 * (fragment_unnamed_1256 * fragment_unnamed_2069)), fragment_unnamed_2081, fragment_unnamed_1071);
							fragment_unnamed_882 = mad((fragment_uniform_buffer_0[88u].z / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_329 * (fragment_unnamed_1256 * fragment_unnamed_2070)), fragment_unnamed_2081, fragment_unnamed_1073);
							fragment_unnamed_884 = mad((-0.0f) - fragment_unnamed_1256, fragment_unnamed_1254, 1.0f);
						}
						else
						{
							fragment_unnamed_878 = fragment_unnamed_1069;
							fragment_unnamed_880 = fragment_unnamed_1071;
							fragment_unnamed_882 = fragment_unnamed_1073;
							fragment_unnamed_884 = fragment_unnamed_1075;
						}
						fragment_unnamed_877 = fragment_unnamed_878;
						fragment_unnamed_879 = fragment_unnamed_880;
						fragment_unnamed_881 = fragment_unnamed_882;
						fragment_unnamed_883 = fragment_unnamed_884;
						fragment_unnamed_885 = fragment_unnamed_884;
						fragment_unnamed_886 = fragment_unnamed_884;
						fragment_unnamed_887 = fragment_unnamed_888;
					}
					else
					{
						fragment_unnamed_877 = asfloat(0u);
						fragment_unnamed_879 = asfloat(0u);
						fragment_unnamed_881 = asfloat(0u);
						fragment_unnamed_883 = fragment_unnamed_618;
						fragment_unnamed_885 = fragment_unnamed_620;
						fragment_unnamed_886 = fragment_unnamed_622;
						fragment_unnamed_887 = asfloat(0u);
					}
					float fragment_unnamed_1146;
					float fragment_unnamed_1148;
					float fragment_unnamed_1150;
					float fragment_unnamed_1152;
					float fragment_unnamed_1154;
					float fragment_unnamed_1156;
					if (asuint(fragment_unnamed_616) != 0u)
					{
						uint fragment_unnamed_1094 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 4u;
						uint4 fragment_unnamed_1106 = uint4(T11.Load(fragment_unnamed_1094).x, T11.Load(fragment_unnamed_1094 + 1u).x, T11.Load(fragment_unnamed_1094 + 2u).x, T11.Load(fragment_unnamed_1094 + 3u).x);
						float fragment_unnamed_1114 = asfloat(fragment_unnamed_1106.w);
						uint fragment_unnamed_1121 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 20u;
						uint3 fragment_unnamed_1130 = uint3(T11.Load(fragment_unnamed_1121).x, T11.Load(fragment_unnamed_1121 + 1u).x, T11.Load(fragment_unnamed_1121 + 2u).x);
						float fragment_unnamed_1132 = asfloat(fragment_unnamed_1130.x);
						float fragment_unnamed_1134 = asfloat(fragment_unnamed_1130.y);
						float fragment_unnamed_1136 = asfloat(fragment_unnamed_1130.z);
						float fragment_unnamed_1137 = fragment_unnamed_1114 * asfloat(fragment_unnamed_1106.x);
						float fragment_unnamed_1138 = fragment_unnamed_1114 * asfloat(fragment_unnamed_1106.y);
						float fragment_unnamed_1139 = fragment_unnamed_1114 * asfloat(fragment_unnamed_1106.z);
						float fragment_unnamed_1144 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_657, (-0.0f) - fragment_unnamed_887);
						float fragment_unnamed_1147;
						float fragment_unnamed_1149;
						float fragment_unnamed_1151;
						float fragment_unnamed_1411;
						float fragment_unnamed_1412;
						float fragment_unnamed_1413;
						if (0.0f < fragment_unnamed_1144)
						{
							uint fragment_unnamed_1270 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 16u;
							uint3 fragment_unnamed_1279 = uint3(T11.Load(fragment_unnamed_1270).x, T11.Load(fragment_unnamed_1270 + 1u).x, T11.Load(fragment_unnamed_1270 + 2u).x);
							float fragment_unnamed_1286 = dot(float3(fragment_unnamed_198, fragment_unnamed_199, fragment_unnamed_200), float3(fragment_unnamed_1132, fragment_unnamed_1134, fragment_unnamed_1136));
							float fragment_unnamed_1289 = fragment_unnamed_1144 * fragment_unnamed_1137;
							float fragment_unnamed_1290 = fragment_unnamed_1144 * fragment_unnamed_1138;
							float fragment_unnamed_1291 = fragment_unnamed_1144 * fragment_unnamed_1139;
							float fragment_unnamed_1298 = fragment_unnamed_329 * (((-0.0f) - fragment_unnamed_883) + 1.0f);
							float fragment_unnamed_1299 = fragment_unnamed_329 * (((-0.0f) - fragment_unnamed_885) + 1.0f);
							float fragment_unnamed_1300 = fragment_unnamed_329 * (((-0.0f) - fragment_unnamed_886) + 1.0f);
							bool fragment_unnamed_1302 = ((-0.0f) - fragment_unnamed_1286) != 1.0f;
							float fragment_unnamed_1304 = 1.0f / (fragment_unnamed_1286 + 1.0f);
							float fragment_unnamed_1308 = (-0.0f) - fragment_unnamed_1286;
							fragment_unnamed_1147 = mad(asfloat(fragment_unnamed_1302 ? asuint(fragment_unnamed_1298 * (fragment_unnamed_1304 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1289, fragment_unnamed_1308, fragment_unnamed_1289) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1298)), asfloat(fragment_unnamed_1279.x), fragment_unnamed_877);
							fragment_unnamed_1149 = mad(asfloat(fragment_unnamed_1302 ? asuint(fragment_unnamed_1299 * (fragment_unnamed_1304 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1290, fragment_unnamed_1308, fragment_unnamed_1290) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1299)), asfloat(fragment_unnamed_1279.y), fragment_unnamed_879);
							fragment_unnamed_1151 = mad(asfloat(fragment_unnamed_1302 ? asuint(fragment_unnamed_1300 * (fragment_unnamed_1304 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1291, fragment_unnamed_1308, fragment_unnamed_1291) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1300)), asfloat(fragment_unnamed_1279.z), fragment_unnamed_881);
							fragment_unnamed_1411 = fragment_unnamed_1289;
							fragment_unnamed_1412 = fragment_unnamed_1290;
							fragment_unnamed_1413 = fragment_unnamed_1291;
						}
						else
						{
							fragment_unnamed_1147 = fragment_unnamed_877;
							fragment_unnamed_1149 = fragment_unnamed_879;
							fragment_unnamed_1151 = fragment_unnamed_881;
							fragment_unnamed_1411 = asfloat(0u);
							fragment_unnamed_1412 = asfloat(0u);
							fragment_unnamed_1413 = asfloat(0u);
						}
						float fragment_unnamed_1429 = max(((-0.0f) - dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_unnamed_1132, fragment_unnamed_1134, fragment_unnamed_1136))) + ((-0.0f) - asfloat(T8.Load(0u).x)), 0.0f);
						fragment_unnamed_1146 = fragment_unnamed_1147;
						fragment_unnamed_1148 = fragment_unnamed_1149;
						fragment_unnamed_1150 = fragment_unnamed_1151;
						fragment_unnamed_1152 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_883) + 1.0f), exp2(mad(fragment_unnamed_1429, fragment_unnamed_1137, fragment_unnamed_1411) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1154 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_885) + 1.0f), exp2(mad(fragment_unnamed_1429, fragment_unnamed_1138, fragment_unnamed_1412) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1156 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_886) + 1.0f), exp2(mad(fragment_unnamed_1429, fragment_unnamed_1139, fragment_unnamed_1413) * (-1.44269502162933349609375f)), 1.0f);
					}
					else
					{
						fragment_unnamed_1146 = fragment_unnamed_877;
						fragment_unnamed_1148 = fragment_unnamed_879;
						fragment_unnamed_1150 = fragment_unnamed_881;
						fragment_unnamed_1152 = fragment_unnamed_883;
						fragment_unnamed_1154 = fragment_unnamed_885;
						fragment_unnamed_1156 = fragment_unnamed_886;
					}
					float fragment_unnamed_795;
					float fragment_unnamed_797;
					float fragment_unnamed_799;
					float fragment_unnamed_801;
					float fragment_unnamed_803;
					float fragment_unnamed_805;
					if (asuint(fragment_unnamed_616) == 0u)
					{
						float fragment_unnamed_1353;
						float fragment_unnamed_1354;
						float fragment_unnamed_1355;
						float fragment_unnamed_1356;
						float fragment_unnamed_1357;
						float fragment_unnamed_1358;
						if (asuint(fragment_uniform_buffer_0[84u]).y != 0u)
						{
							float fragment_unnamed_1455 = fragment_uniform_buffer_0[82u].w + fragment_uniform_buffer_0[83u].w;
							float fragment_unnamed_1461 = dot(float3(fragment_uniform_buffer_0[83u].xyz), float3(fragment_unnamed_648, fragment_unnamed_649, fragment_unnamed_650));
							float fragment_unnamed_1464 = 1.0f / fragment_unnamed_1455;
							float fragment_unnamed_1468 = fragment_unnamed_1464 * fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_1472 = sqrt(max(mad((-0.0f) - fragment_unnamed_1468, fragment_unnamed_1468, 1.0f), 0.0f));
							float fragment_unnamed_1476 = fragment_unnamed_1464 * fragment_uniform_buffer_2[0u].x;
							float fragment_unnamed_1479 = max(mad((-0.0f) - fragment_unnamed_1461, fragment_unnamed_1461, 1.0f), 0.0f);
							float fragment_unnamed_1481 = mad(fragment_unnamed_1476, fragment_unnamed_1476, (-0.0f) - fragment_unnamed_1479);
							float4 fragment_unnamed_1506 = _AtmosphericScatteringLUT.SampleLevel(s0_linear_clamp, float3(fragment_unnamed_646, fragment_unnamed_647, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_657, (-0.0f) - max(asfloat((fragment_unnamed_1481 < 0.0f) ? asuint(fragment_unnamed_1481) : asuint(fragment_unnamed_1455 * (((-0.0f) - fragment_unnamed_1461) + ((-0.0f) - sqrt(fragment_unnamed_1481))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
							float fragment_unnamed_1515 = (1.0f / fragment_unnamed_661) * fragment_uniform_buffer_2[0u].x;
							float fragment_unnamed_1517 = mad(fragment_unnamed_1515, fragment_unnamed_1515, (-0.0f) - fragment_unnamed_1479);
							float fragment_unnamed_1531 = min(max(asfloat((fragment_unnamed_1517 < 0.0f) ? asuint(fragment_unnamed_1517) : asuint(fragment_unnamed_661 * (((-0.0f) - fragment_unnamed_1461) + ((-0.0f) - sqrt(fragment_unnamed_1517))))), 0.0f) + 128000.0f, fragment_unnamed_661);
							float fragment_unnamed_1548 = dot(float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z), float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z));
							float fragment_unnamed_1551 = rsqrt(fragment_unnamed_1548);
							float fragment_unnamed_1563 = sqrt(fragment_unnamed_1548);
							float fragment_unnamed_1564 = dot(float3(fragment_unnamed_1551 * ((-0.0f) - fragment_uniform_buffer_0[82u].x), fragment_unnamed_1551 * ((-0.0f) - fragment_uniform_buffer_0[82u].y), fragment_unnamed_1551 * ((-0.0f) - fragment_uniform_buffer_0[82u].z)), float3(fragment_unnamed_198, fragment_unnamed_199, fragment_unnamed_200));
							float fragment_unnamed_1575 = mad(fragment_unnamed_1531, fragment_unnamed_648, (-0.0f) - fragment_uniform_buffer_0[82u].x);
							float fragment_unnamed_1576 = mad(fragment_unnamed_1531, fragment_unnamed_649, (-0.0f) - fragment_uniform_buffer_0[82u].y);
							float fragment_unnamed_1577 = mad(fragment_unnamed_1531, fragment_unnamed_650, (-0.0f) - fragment_uniform_buffer_0[82u].z);
							float fragment_unnamed_1581 = sqrt(dot(float3(fragment_unnamed_1575, fragment_unnamed_1576, fragment_unnamed_1577), float3(fragment_unnamed_1575, fragment_unnamed_1576, fragment_unnamed_1577)));
							float fragment_unnamed_1586 = (1.0f / fragment_unnamed_1581) * dot(float3(fragment_unnamed_1575, fragment_unnamed_1576, fragment_unnamed_1577), float3(fragment_unnamed_648, fragment_unnamed_649, fragment_unnamed_650));
							float fragment_unnamed_1589 = (fragment_unnamed_1586 >= 0.0f) ? ((-0.0f) - fragment_unnamed_1564) : fragment_unnamed_1564;
							float fragment_unnamed_1594 = fragment_unnamed_1563 * fragment_uniform_buffer_2[1u].x;
							float fragment_unnamed_1595 = fragment_unnamed_1563 * fragment_uniform_buffer_2[1u].z;
							float fragment_unnamed_1599 = sqrt(max(mad((-0.0f) - fragment_unnamed_1589, fragment_unnamed_1589, 1.0f), 0.0f));
							float fragment_unnamed_1604 = abs(fragment_unnamed_1589) * abs(fragment_unnamed_1589);
							float fragment_unnamed_1607 = (-0.0f) - fragment_unnamed_1604;
							float fragment_unnamed_1621 = abs(fragment_unnamed_1589);
							float fragment_unnamed_1628 = abs(fragment_unnamed_1589);
							float fragment_unnamed_1646 = mad(fragment_unnamed_1628, 0.5f, (mad(fragment_unnamed_1607, fragment_unnamed_1594, mad(fragment_unnamed_1594, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_1621, fragment_unnamed_1594, sqrt(fragment_unnamed_1594 * mad(fragment_unnamed_1594 * fragment_unnamed_1604, 0.2738279998302459716796875f, 1.47721004486083984375f))))) * exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1594) * 1.44269502162933349609375f);
							float fragment_unnamed_1647 = mad(fragment_unnamed_1628, 0.5f, (mad(fragment_unnamed_1607, fragment_unnamed_1595, mad(fragment_unnamed_1595, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_1621, fragment_unnamed_1595, sqrt(fragment_unnamed_1595 * mad(fragment_unnamed_1595 * fragment_unnamed_1604, 0.2738279998302459716796875f, 1.47721004486083984375f))))) * exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1595) * 1.44269502162933349609375f);
							bool fragment_unnamed_1648 = fragment_unnamed_1589 < 0.0f;
							float fragment_unnamed_1649 = fragment_unnamed_1599 * fragment_unnamed_1594;
							float fragment_unnamed_1650 = fragment_unnamed_1599 * fragment_unnamed_1595;
							float fragment_unnamed_1651 = rsqrt(fragment_unnamed_1649);
							float fragment_unnamed_1652 = rsqrt(fragment_unnamed_1650);
							float fragment_unnamed_1695 = fragment_unnamed_1581 * fragment_uniform_buffer_2[1u].x;
							float fragment_unnamed_1696 = fragment_unnamed_1581 * fragment_uniform_buffer_2[1u].z;
							float fragment_unnamed_1701 = abs(fragment_unnamed_1586) * abs(fragment_unnamed_1586);
							float fragment_unnamed_1704 = (-0.0f) - fragment_unnamed_1701;
							float fragment_unnamed_1715 = abs(fragment_unnamed_1586);
							float fragment_unnamed_1722 = abs(fragment_unnamed_1586);
							float fragment_unnamed_1750 = abs(mad((-0.0f) - mad(fragment_unnamed_1722, 0.5f, (1.0f / mad(fragment_unnamed_1715, fragment_unnamed_1695, sqrt(fragment_unnamed_1695 * mad(fragment_unnamed_1695 * fragment_unnamed_1701, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1704, fragment_unnamed_1695, mad(fragment_unnamed_1695, 2.0f, 1.0f)) * 0.761642992496490478515625f)), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1695) * 1.44269502162933349609375f), asfloat(fragment_unnamed_1648 ? asuint(mad((dot(fragment_unnamed_1649.xx, fragment_unnamed_1651.xx) + fragment_unnamed_1651) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1649) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_1646)) : asuint(fragment_unnamed_1646)))) * fragment_uniform_buffer_2[1u].y;
							float fragment_unnamed_1752 = 1.0f / fragment_unnamed_1563;
							float fragment_unnamed_1757 = fragment_unnamed_1752 * fragment_uniform_buffer_2[2u].z;
							float fragment_unnamed_1758 = fragment_unnamed_1752 * fragment_uniform_buffer_2[2u].w;
							float fragment_unnamed_1762 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_1564, fragment_unnamed_1564, 1.0f), 0.0f);
							float fragment_unnamed_1763 = mad(fragment_unnamed_1757, fragment_unnamed_1757, fragment_unnamed_1762);
							float fragment_unnamed_1764 = mad(fragment_unnamed_1758, fragment_unnamed_1758, fragment_unnamed_1762);
							bool fragment_unnamed_1765 = fragment_unnamed_1763 < 0.0f;
							bool fragment_unnamed_1766 = fragment_unnamed_1764 < 0.0f;
							float fragment_unnamed_1767 = sqrt(fragment_unnamed_1763);
							float fragment_unnamed_1768 = sqrt(fragment_unnamed_1764);
							uint fragment_unnamed_1779 = asuint(fragment_unnamed_1763);
							uint fragment_unnamed_1782 = fragment_unnamed_1765 ? fragment_unnamed_1779 : asuint(fragment_unnamed_1563 * (fragment_unnamed_1564 + ((-0.0f) - fragment_unnamed_1767)));
							float fragment_unnamed_1783 = asfloat(fragment_unnamed_1782);
							uint fragment_unnamed_1784 = fragment_unnamed_1765 ? fragment_unnamed_1779 : asuint(fragment_unnamed_1563 * (fragment_unnamed_1564 + fragment_unnamed_1767));
							float fragment_unnamed_1785 = asfloat(fragment_unnamed_1784);
							uint fragment_unnamed_1786 = asuint(fragment_unnamed_1764);
							uint fragment_unnamed_1791 = fragment_unnamed_1766 ? fragment_unnamed_1786 : asuint(fragment_unnamed_1563 * (fragment_unnamed_1564 + fragment_unnamed_1768));
							bool fragment_unnamed_1796 = fragment_unnamed_1783 >= 0.0f;
							float fragment_unnamed_1801 = ((-0.0f) - fragment_unnamed_1785) + asfloat(fragment_unnamed_1791);
							float fragment_unnamed_1804 = max(asfloat(fragment_unnamed_1766 ? fragment_unnamed_1786 : asuint(fragment_unnamed_1563 * (fragment_unnamed_1564 + ((-0.0f) - fragment_unnamed_1768)))), 0.0f);
							uint fragment_unnamed_1805 = fragment_unnamed_1796 ? fragment_unnamed_1782 : fragment_unnamed_1791;
							float fragment_unnamed_1811 = ((-0.0f) - fragment_unnamed_1804) + asfloat(fragment_unnamed_1805);
							bool fragment_unnamed_1814 = (((fragment_unnamed_1785 < fragment_unnamed_1531) ? 4294967295u : 0u) & (fragment_unnamed_1796 ? 4294967295u : 0u)) != 0u;
							bool fragment_unnamed_1820 = (((fragment_unnamed_1783 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1785 >= 0.0f) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_1825 = asfloat(fragment_unnamed_1820 ? fragment_unnamed_1784 : asuint(fragment_unnamed_1804));
							float fragment_unnamed_1827 = asfloat(fragment_unnamed_1820 ? asuint(fragment_unnamed_1801 * 0.5f) : (fragment_unnamed_1814 ? fragment_unnamed_1784 : asuint(fragment_unnamed_1811 * 0.5f)));
							float fragment_unnamed_1829 = asfloat(fragment_unnamed_1820 ? asuint(fragment_unnamed_1801 * 0.5f) : (fragment_unnamed_1814 ? fragment_unnamed_1805 : asuint(fragment_unnamed_1811 * 0.5f)));
							float fragment_unnamed_1831 = asfloat(fragment_unnamed_1820 ? fragment_unnamed_1791 : (fragment_unnamed_1814 ? fragment_unnamed_1791 : fragment_unnamed_1805));
							float fragment_unnamed_1836 = (-0.0f) - fragment_unnamed_1825;
							float fragment_unnamed_1837 = (-0.0f) - fragment_unnamed_1827;
							float fragment_unnamed_1840 = fragment_unnamed_1836 + min(fragment_unnamed_1531, fragment_unnamed_1829);
							float fragment_unnamed_1841 = fragment_unnamed_1837 + min(fragment_unnamed_1531, fragment_unnamed_1831);
							float fragment_unnamed_1850 = mad(fragment_unnamed_1836 + min(fragment_unnamed_1531, fragment_unnamed_1829), 0.25f, fragment_unnamed_1825);
							float fragment_unnamed_1852 = mad(fragment_unnamed_1837 + min(fragment_unnamed_1531, fragment_unnamed_1831), 0.25f, fragment_unnamed_1827);
							float fragment_unnamed_1853 = mad(fragment_unnamed_1840, 0.75f, fragment_unnamed_1825);
							float fragment_unnamed_1855 = mad(fragment_unnamed_1841, 0.75f, fragment_unnamed_1827);
							float fragment_unnamed_1857 = dot(((-0.0f) - fragment_unnamed_1564).xx, fragment_unnamed_1563.xx);
							float fragment_unnamed_1875 = (-0.0f) - fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_1911 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1855, fragment_unnamed_1855 + fragment_unnamed_1857, fragment_unnamed_1548)) + fragment_unnamed_1875, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_1841, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1853, fragment_unnamed_1853 + fragment_unnamed_1857, fragment_unnamed_1548)) + fragment_unnamed_1875, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_1840, 0.0f) * 0.5f, ((max(fragment_unnamed_1841, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1852, fragment_unnamed_1852 + fragment_unnamed_1857, fragment_unnamed_1548)) + fragment_unnamed_1875, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_1840, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1850, fragment_unnamed_1850 + fragment_unnamed_1857, fragment_unnamed_1548)) + fragment_unnamed_1875, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
							float fragment_unnamed_1916 = (abs(mad((-0.0f) - mad(fragment_unnamed_1722, 0.5f, (1.0f / mad(fragment_unnamed_1715, fragment_unnamed_1696, sqrt(fragment_unnamed_1696 * mad(fragment_unnamed_1696 * fragment_unnamed_1701, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1704, fragment_unnamed_1696, mad(fragment_unnamed_1696, 2.0f, 1.0f)) * 0.761642992496490478515625f)), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1696) * 1.44269502162933349609375f), asfloat(fragment_unnamed_1648 ? asuint(mad((dot(fragment_unnamed_1650.xx, fragment_unnamed_1652.xx) + fragment_unnamed_1652) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1650) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_1647)) : asuint(fragment_unnamed_1647)))) * fragment_uniform_buffer_2[1u].w) * fragment_uniform_buffer_2[0u].w;
							float fragment_unnamed_1943 = ((-0.0f) - exp2(mad(fragment_unnamed_1911, fragment_uniform_buffer_2[6u].x, mad(fragment_unnamed_1750, fragment_uniform_buffer_2[3u].x, fragment_unnamed_1916)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1944 = ((-0.0f) - exp2(mad(fragment_unnamed_1911, fragment_uniform_buffer_2[6u].y, mad(fragment_unnamed_1750, fragment_uniform_buffer_2[3u].y, fragment_unnamed_1916)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1945 = ((-0.0f) - exp2(mad(fragment_unnamed_1911, fragment_uniform_buffer_2[6u].z, mad(fragment_unnamed_1750, fragment_uniform_buffer_2[3u].z, fragment_unnamed_1916)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1947 = fragment_unnamed_1945 + (fragment_unnamed_1944 + fragment_unnamed_1943);
							float fragment_unnamed_1948 = fragment_unnamed_1947 * 0.3333333432674407958984375f;
							float fragment_unnamed_1950 = (-0.0f) - fragment_unnamed_1947;
							float fragment_unnamed_1969 = sqrt(((-0.0f) - fragment_unnamed_1472) + 1.0f);
							float fragment_unnamed_1975 = mad(mad(mad(fragment_unnamed_1472, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_1472, -0.212114393711090087890625f), fragment_unnamed_1472, 1.570728778839111328125f);
							float fragment_unnamed_1987 = mad(fragment_unnamed_1975, fragment_unnamed_1969, asfloat(((((-0.0f) - fragment_unnamed_1472) < fragment_unnamed_1472) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_1969 * fragment_unnamed_1975, -2.0f, 3.1415927410125732421875f))));
							float fragment_unnamed_1991 = sqrt(((-0.0f) - abs(fragment_unnamed_1461)) + 1.0f);
							float fragment_unnamed_1997 = mad(mad(mad(abs(fragment_unnamed_1461), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_1461), -0.212114393711090087890625f), abs(fragment_unnamed_1461), 1.570728778839111328125f);
							float fragment_unnamed_2008 = 1.0f / ((-0.0f) - fragment_unnamed_1987);
							float fragment_unnamed_2026 = mad(exp2((clamp(mad(mad(fragment_unnamed_1997, fragment_unnamed_1991, asfloat(((fragment_unnamed_1461 < ((-0.0f) - fragment_unnamed_1461)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_1991 * fragment_unnamed_1997, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_2008, (-0.0f) - (fragment_unnamed_2008 * fragment_unnamed_1987)), 0.0f, 1.0f) * fragment_uniform_buffer_2[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_2[11u].y, (-0.0f) - fragment_uniform_buffer_2[11u].y);
							float fragment_unnamed_2059 = ((-0.0f) - fragment_unnamed_1152) + 1.0f;
							float fragment_unnamed_2060 = ((-0.0f) - fragment_unnamed_1154) + 1.0f;
							float fragment_unnamed_2061 = ((-0.0f) - fragment_unnamed_1156) + 1.0f;
							fragment_unnamed_1353 = mad(fragment_unnamed_2059, mad(fragment_unnamed_2026, ((-0.0f) - fragment_uniform_buffer_2[8u].x) + fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[8u].x) * fragment_unnamed_1506.x, fragment_unnamed_1146);
							fragment_unnamed_1354 = mad(fragment_unnamed_2060, mad(fragment_unnamed_2026, ((-0.0f) - fragment_uniform_buffer_2[8u].y) + fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[8u].y) * fragment_unnamed_1506.y, fragment_unnamed_1148);
							fragment_unnamed_1355 = mad(fragment_unnamed_2061, mad(fragment_unnamed_2026, ((-0.0f) - fragment_uniform_buffer_2[8u].z) + fragment_uniform_buffer_2[9u].z, fragment_uniform_buffer_2[8u].z) * fragment_unnamed_1506.z, fragment_unnamed_1150);
							fragment_unnamed_1356 = mad(fragment_unnamed_2059, mad(mad(fragment_unnamed_1950, 0.3333333432674407958984375f, fragment_unnamed_1943), fragment_uniform_buffer_2[10u].z, fragment_unnamed_1948) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1152);
							fragment_unnamed_1357 = mad(fragment_unnamed_2060, mad(mad(fragment_unnamed_1950, 0.3333333432674407958984375f, fragment_unnamed_1944), fragment_uniform_buffer_2[10u].z, fragment_unnamed_1948) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1154);
							fragment_unnamed_1358 = mad(fragment_unnamed_2061, mad(mad(fragment_unnamed_1950, 0.3333333432674407958984375f, fragment_unnamed_1945), fragment_uniform_buffer_2[10u].z, fragment_unnamed_1948) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1156);
						}
						else
						{
							fragment_unnamed_1353 = fragment_unnamed_1146;
							fragment_unnamed_1354 = fragment_unnamed_1148;
							fragment_unnamed_1355 = fragment_unnamed_1150;
							fragment_unnamed_1356 = fragment_unnamed_1152;
							fragment_unnamed_1357 = fragment_unnamed_1154;
							fragment_unnamed_1358 = fragment_unnamed_1156;
						}
						fragment_unnamed_795 = fragment_unnamed_1353;
						fragment_unnamed_797 = fragment_unnamed_1354;
						fragment_unnamed_799 = fragment_unnamed_1355;
						fragment_unnamed_801 = fragment_unnamed_1356;
						fragment_unnamed_803 = fragment_unnamed_1357;
						fragment_unnamed_805 = fragment_unnamed_1358;
					}
					else
					{
						fragment_unnamed_795 = fragment_unnamed_1146;
						fragment_unnamed_797 = fragment_unnamed_1148;
						fragment_unnamed_799 = fragment_unnamed_1150;
						fragment_unnamed_801 = fragment_unnamed_1152;
						fragment_unnamed_803 = fragment_unnamed_1154;
						fragment_unnamed_805 = fragment_unnamed_1156;
					}
					fragment_unnamed_794 = fragment_unnamed_795;
					fragment_unnamed_796 = fragment_unnamed_797;
					fragment_unnamed_798 = fragment_unnamed_799;
					fragment_unnamed_800 = fragment_unnamed_801;
					fragment_unnamed_802 = fragment_unnamed_803;
					fragment_unnamed_804 = fragment_unnamed_805;
				}
				else
				{
					fragment_unnamed_794 = asfloat(0u);
					fragment_unnamed_796 = asfloat(0u);
					fragment_unnamed_798 = asfloat(0u);
					fragment_unnamed_800 = fragment_unnamed_618;
					fragment_unnamed_802 = fragment_unnamed_620;
					fragment_unnamed_804 = fragment_unnamed_622;
				}
				float fragment_unnamed_812 = asfloat(fragment_unnamed_477) * (((-0.0f) - fragment_unnamed_800) + 1.0f);
				float fragment_unnamed_813 = asfloat(fragment_unnamed_479) * (((-0.0f) - fragment_unnamed_802) + 1.0f);
				float fragment_unnamed_814 = asfloat(fragment_unnamed_481) * (((-0.0f) - fragment_unnamed_804) + 1.0f);
				float fragment_unnamed_815 = mad(fragment_unnamed_794, fragment_unnamed_449, fragment_unnamed_812);
				float fragment_unnamed_816 = mad(fragment_unnamed_796, fragment_unnamed_449, fragment_unnamed_813);
				float fragment_unnamed_817 = mad(fragment_unnamed_798, fragment_unnamed_449, fragment_unnamed_814);
				fragment_output_0.x = fragment_unnamed_460 ? fragment_unnamed_815 : asfloat(fragment_unnamed_461 ? asuint(fragment_unnamed_812) : (fragment_unnamed_462 ? asuint(fragment_unnamed_815) : fragment_unnamed_477));
				fragment_output_0.y = fragment_unnamed_460 ? fragment_unnamed_816 : asfloat(fragment_unnamed_461 ? asuint(fragment_unnamed_813) : (fragment_unnamed_462 ? asuint(fragment_unnamed_816) : fragment_unnamed_479));
				fragment_output_0.z = fragment_unnamed_460 ? fragment_unnamed_817 : asfloat(fragment_unnamed_461 ? asuint(fragment_unnamed_814) : (fragment_unnamed_462 ? asuint(fragment_unnamed_817) : fragment_unnamed_481));
				fragment_output_0.w = fragment_unnamed_449;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				fragment_uniform_buffer_0[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				fragment_uniform_buffer_0[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				fragment_uniform_buffer_0[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				fragment_uniform_buffer_0[8] = float4(_InvViewMatrix[0][0], _InvViewMatrix[1][0], _InvViewMatrix[2][0], _InvViewMatrix[3][0]);
				fragment_uniform_buffer_0[9] = float4(_InvViewMatrix[0][1], _InvViewMatrix[1][1], _InvViewMatrix[2][1], _InvViewMatrix[3][1]);
				fragment_uniform_buffer_0[10] = float4(_InvViewMatrix[0][2], _InvViewMatrix[1][2], _InvViewMatrix[2][2], _InvViewMatrix[3][2]);
				fragment_uniform_buffer_0[11] = float4(_InvViewMatrix[0][3], _InvViewMatrix[1][3], _InvViewMatrix[2][3], _InvViewMatrix[3][3]);

				fragment_uniform_buffer_0[12] = float4(_ProjMatrix[0][0], _ProjMatrix[1][0], _ProjMatrix[2][0], _ProjMatrix[3][0]);
				fragment_uniform_buffer_0[13] = float4(_ProjMatrix[0][1], _ProjMatrix[1][1], _ProjMatrix[2][1], _ProjMatrix[3][1]);
				fragment_uniform_buffer_0[14] = float4(_ProjMatrix[0][2], _ProjMatrix[1][2], _ProjMatrix[2][2], _ProjMatrix[3][2]);
				fragment_uniform_buffer_0[15] = float4(_ProjMatrix[0][3], _ProjMatrix[1][3], _ProjMatrix[2][3], _ProjMatrix[3][3]);

				fragment_uniform_buffer_0[28] = float4(_InvViewProjMatrix[0][0], _InvViewProjMatrix[1][0], _InvViewProjMatrix[2][0], _InvViewProjMatrix[3][0]);
				fragment_uniform_buffer_0[29] = float4(_InvViewProjMatrix[0][1], _InvViewProjMatrix[1][1], _InvViewProjMatrix[2][1], _InvViewProjMatrix[3][1]);
				fragment_uniform_buffer_0[30] = float4(_InvViewProjMatrix[0][2], _InvViewProjMatrix[1][2], _InvViewProjMatrix[2][2], _InvViewProjMatrix[3][2]);
				fragment_uniform_buffer_0[31] = float4(_InvViewProjMatrix[0][3], _InvViewProjMatrix[1][3], _InvViewProjMatrix[2][3], _InvViewProjMatrix[3][3]);

				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				fragment_uniform_buffer_0[82] = float4(_PlanetCenterRadius[0], _PlanetCenterRadius[1], _PlanetCenterRadius[2], _PlanetCenterRadius[3]);

				fragment_uniform_buffer_0[83] = float4(_PlanetUpAltitude[0], _PlanetUpAltitude[1], _PlanetUpAltitude[2], _PlanetUpAltitude[3]);

				fragment_uniform_buffer_0[84] = float4(asfloat(_FogEnabled), fragment_uniform_buffer_0[84][1], fragment_uniform_buffer_0[84][2], fragment_uniform_buffer_0[84][3]);

				fragment_uniform_buffer_0[84] = float4(fragment_uniform_buffer_0[84][0], asfloat(_PBRFogEnabled), fragment_uniform_buffer_0[84][2], fragment_uniform_buffer_0[84][3]);

				fragment_uniform_buffer_0[84] = float4(fragment_uniform_buffer_0[84][0], fragment_uniform_buffer_0[84][1], asfloat(_EnableVolumetricFog), fragment_uniform_buffer_0[84][3]);

				fragment_uniform_buffer_0[85] = float4(_FogColor[0], _FogColor[1], _FogColor[2], _FogColor[3]);

				fragment_uniform_buffer_0[86] = float4(_FogColorMode, fragment_uniform_buffer_0[86][1], fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_0[87] = float4(_MipFogParameters[0], _MipFogParameters[1], _MipFogParameters[2], _MipFogParameters[3]);

				fragment_uniform_buffer_0[88] = float4(_HeightFogBaseScattering[0], _HeightFogBaseScattering[1], _HeightFogBaseScattering[2], _HeightFogBaseScattering[3]);

				fragment_uniform_buffer_0[89] = float4(_HeightFogBaseExtinction, fragment_uniform_buffer_0[89][1], fragment_uniform_buffer_0[89][2], fragment_uniform_buffer_0[89][3]);

				fragment_uniform_buffer_0[89] = float4(fragment_uniform_buffer_0[89][0], _HeightFogBaseHeight, fragment_uniform_buffer_0[89][2], fragment_uniform_buffer_0[89][3]);

				fragment_uniform_buffer_0[89] = float4(fragment_uniform_buffer_0[89][0], fragment_uniform_buffer_0[89][1], fragment_uniform_buffer_0[89][2], asfloat(_VolumetricFilteringEnabled));

				fragment_uniform_buffer_0[90] = float4(_HeightFogExponents[0], _HeightFogExponents[1], fragment_uniform_buffer_0[90][2], fragment_uniform_buffer_0[90][3]);

				fragment_uniform_buffer_0[91] = float4(_VBufferViewportSize[0], _VBufferViewportSize[1], _VBufferViewportSize[2], _VBufferViewportSize[3]);

				fragment_uniform_buffer_0[92] = float4(_VBufferLightingViewportScale[0], _VBufferLightingViewportScale[1], _VBufferLightingViewportScale[2], _VBufferLightingViewportScale[3]);

				fragment_uniform_buffer_0[93] = float4(_VBufferLightingViewportLimit[0], _VBufferLightingViewportLimit[1], _VBufferLightingViewportLimit[2], _VBufferLightingViewportLimit[3]);

				fragment_uniform_buffer_0[94] = float4(_VBufferDistanceEncodingParams[0], _VBufferDistanceEncodingParams[1], _VBufferDistanceEncodingParams[2], _VBufferDistanceEncodingParams[3]);

				fragment_uniform_buffer_0[96] = float4(fragment_uniform_buffer_0[96][0], _VBufferRcpSliceCount, fragment_uniform_buffer_0[96][2], fragment_uniform_buffer_0[96][3]);

				fragment_uniform_buffer_0[96] = float4(fragment_uniform_buffer_0[96][0], fragment_uniform_buffer_0[96][1], fragment_uniform_buffer_0[96][2], _VBufferLastSliceDist);

				fragment_uniform_buffer_0[102] = float4(_BoundsSS[0], _BoundsSS[1], _BoundsSS[2], _BoundsSS[3]);

				fragment_uniform_buffer_0[103] = float4(_UpDirectionX, fragment_uniform_buffer_0[103][1], fragment_uniform_buffer_0[103][2], fragment_uniform_buffer_0[103][3]);

				fragment_uniform_buffer_0[103] = float4(fragment_uniform_buffer_0[103][0], _UpDirectionY, fragment_uniform_buffer_0[103][2], fragment_uniform_buffer_0[103][3]);

				fragment_uniform_buffer_0[107] = float4(asfloat(_UnderWaterSurfaceIndex), fragment_uniform_buffer_0[107][1], fragment_uniform_buffer_0[107][2], fragment_uniform_buffer_0[107][3]);

				fragment_uniform_buffer_0[113] = float4(asfloat(_PreRefractionPass), fragment_uniform_buffer_0[113][1], fragment_uniform_buffer_0[113][2], fragment_uniform_buffer_0[113][3]);

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], _ProbeExposureScale, fragment_uniform_buffer_0[118][2], fragment_uniform_buffer_0[118][3]);

				fragment_uniform_buffer_0[211] = float4(_OffScreenDownsampleFactor, fragment_uniform_buffer_0[211][1], fragment_uniform_buffer_0[211][2], fragment_uniform_buffer_0[211][3]);

				fragment_uniform_buffer_0[214] = float4(fragment_uniform_buffer_0[214][0], fragment_uniform_buffer_0[214][1], fragment_uniform_buffer_0[214][2], _DeExposureMultiplier);

				fragment_uniform_buffer_0[219] = float4(_ColorPyramidUvScaleAndLimitCurrentFrame[0], _ColorPyramidUvScaleAndLimitCurrentFrame[1], _ColorPyramidUvScaleAndLimitCurrentFrame[2], _ColorPyramidUvScaleAndLimitCurrentFrame[3]);

				fragment_uniform_buffer_1[0] = float4(_Scroll_Speed[0], _Scroll_Speed[1], fragment_uniform_buffer_1[0][2], fragment_uniform_buffer_1[0][3]);

				fragment_uniform_buffer_1[0] = float4(fragment_uniform_buffer_1[0][0], fragment_uniform_buffer_1[0][1], _Intensity, fragment_uniform_buffer_1[0][3]);

				fragment_uniform_buffer_1[1] = float4(_Secondary_Scroll_Speed[0], _Secondary_Scroll_Speed[1], fragment_uniform_buffer_1[1][2], fragment_uniform_buffer_1[1][3]);

				fragment_uniform_buffer_1[3] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[7] = float4(_Base_text_tiling[0], _Base_text_tiling[1], fragment_uniform_buffer_1[7][2], fragment_uniform_buffer_1[7][3]);

				fragment_uniform_buffer_1[7] = float4(fragment_uniform_buffer_1[7][0], fragment_uniform_buffer_1[7][1], _Distortion_text_tiling[0], _Distortion_text_tiling[1]);

				fragment_uniform_buffer_1[15] = float4(_BlendMode, fragment_uniform_buffer_1[15][1], fragment_uniform_buffer_1[15][2], fragment_uniform_buffer_1[15][3]);

				fragment_uniform_buffer_2[0] = float4(_AtmosphericRadius, fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_2[0] = float4(fragment_uniform_buffer_2[0][0], fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], _AerosolSeaLevelExtinction);

				fragment_uniform_buffer_2[1] = float4(_AirDensityFalloff, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[1] = float4(fragment_uniform_buffer_2[1][0], _AirScaleHeight, fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[1] = float4(fragment_uniform_buffer_2[1][0], fragment_uniform_buffer_2[1][1], _AerosolDensityFalloff, fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[1] = float4(fragment_uniform_buffer_2[1][0], fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], _AerosolScaleHeight);

				fragment_uniform_buffer_2[2] = float4(_OzoneScaleOffset[0], _OzoneScaleOffset[1], fragment_uniform_buffer_2[2][2], fragment_uniform_buffer_2[2][3]);

				fragment_uniform_buffer_2[2] = float4(fragment_uniform_buffer_2[2][0], fragment_uniform_buffer_2[2][1], _OzoneLayerStart, fragment_uniform_buffer_2[2][3]);

				fragment_uniform_buffer_2[2] = float4(fragment_uniform_buffer_2[2][0], fragment_uniform_buffer_2[2][1], fragment_uniform_buffer_2[2][2], _OzoneLayerEnd);

				fragment_uniform_buffer_2[3] = float4(_AirSeaLevelExtinction[0], _AirSeaLevelExtinction[1], _AirSeaLevelExtinction[2], _AirSeaLevelExtinction[3]);

				fragment_uniform_buffer_2[6] = float4(_OzoneSeaLevelExtinction[0], _OzoneSeaLevelExtinction[1], _OzoneSeaLevelExtinction[2], _OzoneSeaLevelExtinction[3]);

				fragment_uniform_buffer_2[8] = float4(_HorizonTint[0], _HorizonTint[1], _HorizonTint[2], _HorizonTint[3]);

				fragment_uniform_buffer_2[9] = float4(_ZenithTint[0], _ZenithTint[1], _ZenithTint[2], _ZenithTint[3]);

				fragment_uniform_buffer_2[10] = float4(fragment_uniform_buffer_2[10][0], fragment_uniform_buffer_2[10][1], _AlphaSaturation, fragment_uniform_buffer_2[10][3]);

				fragment_uniform_buffer_2[10] = float4(fragment_uniform_buffer_2[10][0], fragment_uniform_buffer_2[10][1], fragment_uniform_buffer_2[10][2], _AlphaMultiplier);

				fragment_uniform_buffer_2[11] = float4(_HorizonZenithShiftPower, fragment_uniform_buffer_2[11][1], fragment_uniform_buffer_2[11][2], fragment_uniform_buffer_2[11][3]);

				fragment_uniform_buffer_2[11] = float4(fragment_uniform_buffer_2[11][0], _HorizonZenithShiftScale, fragment_uniform_buffer_2[11][2], fragment_uniform_buffer_2[11][3]);

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
		Tags { "DisableBatching" = "False" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
		Pass
		{
			Name "IndirectDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "IndirectDXR" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 564553

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "VisibilityDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "VisibilityDXR" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 635585

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "ForwardDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "ForwardDXR" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 674802

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "GBufferDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "GBufferDXR" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 742457

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "DebugDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DebugDXR" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 794795

			HLSLPROGRAM
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariablesGlobal.cs.hlsl"

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "PathTracingDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "PathTracingDXR" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 882542

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
