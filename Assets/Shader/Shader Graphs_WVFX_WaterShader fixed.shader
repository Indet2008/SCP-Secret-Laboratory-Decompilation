Shader "Shader Graphs/WVFX_WaterShader fixed"
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
			GpuProgramID 431217

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


			#ifndef DECOMP_DECL__OffScreenRendering
			#define DECOMP_DECL__OffScreenRendering
			#endif

			static float4 fragment_uniform_buffer_0[212];
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
				bool fragment_unnamed_88 = 0u < asuint(fragment_uniform_buffer_0[211u]).y;
				float fragment_unnamed_111 = fragment_unnamed_88 ? float(uint(round(gl_FragCoord.x * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.x;
				float fragment_unnamed_112 = fragment_unnamed_88 ? float(uint(round(gl_FragCoord.y * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.y;
				float4 fragment_unnamed_167 = _Base_text.SampleBias(sampler_Base_text, float2(mad(fragment_uniform_buffer_0[80u].x, fragment_uniform_buffer_1[0u].x, fragment_input_1.x * fragment_uniform_buffer_1[7u].x), mad(fragment_uniform_buffer_0[80u].x, fragment_uniform_buffer_1[0u].y, fragment_input_1.y * fragment_uniform_buffer_1[7u].y)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_170 = fragment_unnamed_167.x;
				float fragment_unnamed_180 = mad(fragment_uniform_buffer_1[1u].x, fragment_uniform_buffer_0[80u].x, fragment_input_1.x * fragment_uniform_buffer_1[7u].z) + (-0.5f);
				float fragment_unnamed_182 = mad(fragment_uniform_buffer_1[1u].y, fragment_uniform_buffer_0[80u].x, fragment_input_1.y * fragment_uniform_buffer_1[7u].w) + (-0.5f);
				float fragment_unnamed_204 = mad(((-0.0f) - fragment_unnamed_170) + _Distortion_text.SampleBias(sampler_Distortion_text, float2(dot(float2(fragment_unnamed_180, fragment_unnamed_182), float2(-0.6549880504608154296875f, 0.7556393146514892578125f)) + 0.5f, dot(float2(fragment_unnamed_180, fragment_unnamed_182), float2(-0.755639255046844482421875f, -0.6549880504608154296875f)) + 0.5f), fragment_uniform_buffer_0[86u].y).x, 0.300000011920928955078125f, fragment_unnamed_170);
				float4 fragment_unnamed_224 = _ColorPyramidTexture.SampleLevel(s1_linear_clamp, float3(mad(fragment_unnamed_204, fragment_uniform_buffer_1[0u].z, fragment_unnamed_111 / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[219u].x, mad(fragment_unnamed_204, fragment_uniform_buffer_1[0u].z, ((-0.0f) - (asfloat((fragment_uniform_buffer_0[58u].x < 0.0f) ? asuint(((-0.0f) - fragment_unnamed_112) + fragment_uniform_buffer_0[61u].y) : asuint(fragment_unnamed_112)) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[219u].y, asfloat(0u)), 0.0f);
				float4 fragment_unnamed_229 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u));
				float fragment_unnamed_232 = fragment_unnamed_229.x;
				float fragment_unnamed_237 = fragment_unnamed_232 * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_248 = 1.0f / mad(fragment_unnamed_232, fragment_uniform_buffer_0[118u].y, asfloat(((fragment_unnamed_237 == 0.0f) ? 4294967295u : 0u) & 1065353216u));
				float fragment_unnamed_249 = fragment_unnamed_248 * fragment_unnamed_224.x;
				float fragment_unnamed_250 = fragment_unnamed_248 * fragment_unnamed_224.y;
				float fragment_unnamed_251 = fragment_unnamed_248 * fragment_unnamed_224.z;
				float fragment_unnamed_258 = fragment_unnamed_249 * fragment_uniform_buffer_1[3u].x;
				float fragment_unnamed_259 = fragment_unnamed_250 * fragment_uniform_buffer_1[3u].y;
				float fragment_unnamed_260 = fragment_unnamed_251 * fragment_uniform_buffer_1[3u].z;
				float fragment_unnamed_265 = clamp((fragment_unnamed_204 + (-0.226047098636627197265625f)) * 3.803761005401611328125f, 0.0f, 1.0f);
				float fragment_unnamed_266 = mad(fragment_unnamed_265, 0.61236202716827392578125f, 0.01027945987880229949951171875f);
				float fragment_unnamed_269 = mad(fragment_unnamed_265, 0.5992424488067626953125f, 0.02339903078973293304443359375f);
				float fragment_unnamed_272 = mad(fragment_unnamed_265, 0.55660378932952880859375f, 0.066037707030773162841796875f);
				float fragment_unnamed_283 = mad((-0.0f) - fragment_uniform_buffer_1[3u].x, fragment_unnamed_249, 1.0f);
				float fragment_unnamed_284 = mad((-0.0f) - fragment_uniform_buffer_1[3u].y, fragment_unnamed_250, 1.0f);
				float fragment_unnamed_285 = mad((-0.0f) - fragment_uniform_buffer_1[3u].z, fragment_unnamed_251, 1.0f);
				float fragment_unnamed_301 = fragment_unnamed_258 * fragment_unnamed_266;
				float fragment_unnamed_302 = fragment_unnamed_259 * fragment_unnamed_269;
				float fragment_unnamed_303 = fragment_unnamed_260 * fragment_unnamed_272;
				bool fragment_unnamed_307 = 0.5f >= fragment_unnamed_258;
				bool fragment_unnamed_308 = 0.5f >= fragment_unnamed_259;
				bool fragment_unnamed_309 = 0.5f >= fragment_unnamed_260;
				float fragment_unnamed_350 = mad(mad((-0.0f) - fragment_uniform_buffer_1[3u].x, fragment_unnamed_249, mad(fragment_unnamed_301 + fragment_unnamed_301, asfloat((fragment_unnamed_307 ? 4294967295u : 0u) & 1065353216u), mad((-0.0f) - (fragment_unnamed_283 + fragment_unnamed_283), ((-0.0f) - fragment_unnamed_266) + 1.0f, 1.0f) * asfloat(fragment_unnamed_307 ? 0u : 1065353216u))), 0.100000001490116119384765625f, fragment_unnamed_258) * fragment_uniform_buffer_0[214u].w;
				float fragment_unnamed_351 = mad(mad((-0.0f) - fragment_uniform_buffer_1[3u].y, fragment_unnamed_250, mad(fragment_unnamed_302 + fragment_unnamed_302, asfloat((fragment_unnamed_308 ? 4294967295u : 0u) & 1065353216u), mad((-0.0f) - (fragment_unnamed_284 + fragment_unnamed_284), ((-0.0f) - fragment_unnamed_269) + 1.0f, 1.0f) * asfloat(fragment_unnamed_308 ? 0u : 1065353216u))), 0.100000001490116119384765625f, fragment_unnamed_259) * fragment_uniform_buffer_0[214u].w;
				float fragment_unnamed_352 = mad(mad((-0.0f) - fragment_uniform_buffer_1[3u].z, fragment_unnamed_251, mad(fragment_unnamed_303 + fragment_unnamed_303, asfloat((fragment_unnamed_309 ? 4294967295u : 0u) & 1065353216u), mad((-0.0f) - (fragment_unnamed_285 + fragment_unnamed_285), ((-0.0f) - fragment_unnamed_272) + 1.0f, 1.0f) * asfloat(fragment_unnamed_309 ? 0u : 1065353216u))), 0.100000001490116119384765625f, fragment_unnamed_260) * fragment_uniform_buffer_0[214u].w;
				float fragment_unnamed_488;
				float fragment_unnamed_490;
				float fragment_unnamed_492;
				float fragment_unnamed_494;
				float fragment_unnamed_496;
				if (asuint(fragment_uniform_buffer_0[211u]).y != 1u)
				{
					uint fragment_unnamed_358 = uint(fragment_unnamed_111);
					uint fragment_unnamed_359 = uint(fragment_unnamed_112);
					float fragment_unnamed_366 = float(fragment_unnamed_358);
					float fragment_unnamed_367 = float(fragment_unnamed_359);
					uint fragment_unnamed_388 = min(T9.Load(1u).x, max(((-T9.Load(0u).x) + 4294967295u), uint(round(dot(float2(fragment_unnamed_366, fragment_unnamed_367), float2(fragment_uniform_buffer_0[103u].y * 1.0f, fragment_uniform_buffer_0[103u].x * (-1.0f))) + ((-0.0f) - fragment_uniform_buffer_0[102u].x)))));
					bool fragment_unnamed_422 = ((((-0.0f) - float((T9.Load(fragment_unnamed_388 + 2u).x & 65535u) + 4294967295u)) + floor(dot(float2(fragment_unnamed_366, fragment_unnamed_367), float2(fragment_uniform_buffer_0[103u].xy)) + ((-0.0f) - fragment_uniform_buffer_0[102u].z))) / (((-0.0f) - fragment_uniform_buffer_0[102u].z) + fragment_uniform_buffer_0[102u].w)) < 0.0f;
					uint fragment_unnamed_423 = fragment_unnamed_422 ? 4294967295u : 0u;
					float fragment_unnamed_424 = asfloat(fragment_unnamed_423);
					float fragment_unnamed_489;
					float fragment_unnamed_491;
					float fragment_unnamed_493;
					float fragment_unnamed_495;
					float fragment_unnamed_497;
					if (asuint(fragment_uniform_buffer_0[113u]).x != 0u)
					{
						float4 fragment_unnamed_436 = _RefractiveDepthBuffer.Load(int4(uint3(fragment_unnamed_358, fragment_unnamed_359, 0u), 0u));
						float fragment_unnamed_439 = fragment_unnamed_436.x;
						uint4 fragment_unnamed_440 = _StencilTexture.Load(int4(uint3(fragment_unnamed_358, fragment_unnamed_359, 0u), 0u));
						uint fragment_unnamed_442 = fragment_unnamed_440.y;
						uint fragment_unnamed_444 = fragment_unnamed_442 & 32u;
						uint fragment_unnamed_482 = ((fragment_unnamed_442 & 1u) != 0u) ? 4294967295u : (((((((fragment_unnamed_439 >= gl_FragCoord.z) ? 4294967295u : 0u) & (fragment_unnamed_423 & ((fragment_unnamed_444 != 0u) ? 4294967295u : 0u))) != 0u) ? 3.4028234663852885981170418348452e+38f : gl_FragCoord.z) < asfloat(fragment_unnamed_422 ? 2139095039u : ((fragment_unnamed_444 != 0u) ? asuint(fragment_unnamed_439) : 0u))) ? (fragment_unnamed_422 ? asuint(fragment_uniform_buffer_0[107u]).x : (uint(_WaterGBufferTexture3.Load(int4(uint3(fragment_unnamed_358, fragment_unnamed_359, 0u), 0u)).w * 255.0f) & 15u)) : 4294967295u);
						float fragment_unnamed_508;
						float fragment_unnamed_509;
						float fragment_unnamed_510;
						float fragment_unnamed_511;
						float fragment_unnamed_512;
						if (fragment_unnamed_482 == 4294967295u)
						{
							fragment_unnamed_508 = asfloat(0u);
							fragment_unnamed_509 = asfloat(0u);
							fragment_unnamed_510 = asfloat(0u);
							fragment_unnamed_511 = asfloat(0u);
							fragment_unnamed_512 = asfloat(0u);
						}
						else
						{
							float fragment_unnamed_596;
							float fragment_unnamed_597;
							float fragment_unnamed_598;
							if (fragment_unnamed_423 == 0u)
							{
								uint fragment_unnamed_602 = (fragment_unnamed_482 * 28u) + 4u;
								uint3 fragment_unnamed_611 = uint3(T11.Load(fragment_unnamed_602).x, T11.Load(fragment_unnamed_602 + 1u).x, T11.Load(fragment_unnamed_602 + 2u).x);
								float fragment_unnamed_624 = mad(fragment_unnamed_366 * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
								float fragment_unnamed_627 = (-0.0f) - mad(fragment_unnamed_367 * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
								float fragment_unnamed_670 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_439, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_624, fragment_unnamed_627 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
								float fragment_unnamed_683 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_439, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_624, fragment_unnamed_627 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_670)) + fragment_input_2.x;
								float fragment_unnamed_684 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_439, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_624, fragment_unnamed_627 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_670)) + fragment_input_2.y;
								float fragment_unnamed_685 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_439, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_624, fragment_unnamed_627 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_670)) + fragment_input_2.z;
								float fragment_unnamed_689 = sqrt(dot(float3(fragment_unnamed_683, fragment_unnamed_684, fragment_unnamed_685), float3(fragment_unnamed_683, fragment_unnamed_684, fragment_unnamed_685)));
								float fragment_unnamed_690 = fragment_unnamed_689 + fragment_unnamed_689;
								fragment_unnamed_596 = ((-0.0f) - exp2((asfloat(fragment_unnamed_611.x) * fragment_unnamed_690) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_597 = ((-0.0f) - exp2((asfloat(fragment_unnamed_611.y) * fragment_unnamed_690) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_598 = ((-0.0f) - exp2((asfloat(fragment_unnamed_611.z) * fragment_unnamed_690) * (-1.44269502162933349609375f))) + 1.0f;
							}
							else
							{
								fragment_unnamed_596 = asfloat(0u);
								fragment_unnamed_597 = asfloat(0u);
								fragment_unnamed_598 = asfloat(0u);
							}
							fragment_unnamed_508 = fragment_unnamed_424;
							fragment_unnamed_509 = fragment_unnamed_596;
							fragment_unnamed_510 = fragment_unnamed_597;
							fragment_unnamed_511 = fragment_unnamed_598;
							fragment_unnamed_512 = asfloat(~fragment_unnamed_423);
						}
						fragment_unnamed_489 = fragment_unnamed_508;
						fragment_unnamed_491 = fragment_unnamed_509;
						fragment_unnamed_493 = fragment_unnamed_510;
						fragment_unnamed_495 = fragment_unnamed_511;
						fragment_unnamed_497 = fragment_unnamed_512;
					}
					else
					{
						fragment_unnamed_489 = fragment_unnamed_424;
						fragment_unnamed_491 = asfloat(0u);
						fragment_unnamed_493 = asfloat(0u);
						fragment_unnamed_495 = asfloat(0u);
						fragment_unnamed_497 = asfloat(0u);
					}
					fragment_unnamed_488 = fragment_unnamed_489;
					fragment_unnamed_490 = fragment_unnamed_491;
					fragment_unnamed_492 = fragment_unnamed_493;
					fragment_unnamed_494 = fragment_unnamed_495;
					fragment_unnamed_496 = fragment_unnamed_497;
				}
				else
				{
					fragment_unnamed_488 = asfloat(0u);
					fragment_unnamed_490 = asfloat(0u);
					fragment_unnamed_492 = asfloat(0u);
					fragment_unnamed_494 = asfloat(0u);
					fragment_unnamed_496 = asfloat(0u);
				}
				float fragment_unnamed_719;
				float fragment_unnamed_721;
				float fragment_unnamed_723;
				float fragment_unnamed_725;
				float fragment_unnamed_727;
				float fragment_unnamed_729;
				if (asuint(fragment_unnamed_496) == 0u)
				{
					float fragment_unnamed_518 = fragment_unnamed_111 * fragment_uniform_buffer_0[50u].z;
					float fragment_unnamed_519 = fragment_unnamed_112 * fragment_uniform_buffer_0[50u].w;
					bool fragment_unnamed_523 = fragment_uniform_buffer_0[15u].w == 0.0f;
					uint4 fragment_unnamed_544 = asuint(fragment_uniform_buffer_0[0u]);
					uint fragment_unnamed_545 = fragment_unnamed_544.z;
					uint4 fragment_unnamed_549 = asuint(fragment_uniform_buffer_0[1u]);
					uint fragment_unnamed_550 = fragment_unnamed_549.z;
					uint4 fragment_unnamed_554 = asuint(fragment_uniform_buffer_0[2u]);
					uint fragment_unnamed_555 = fragment_unnamed_554.z;
					float fragment_unnamed_561 = asfloat(fragment_unnamed_523 ? asuint(((-0.0f) - fragment_input_2.x) + fragment_uniform_buffer_0[11u].x) : fragment_unnamed_545);
					float fragment_unnamed_563 = asfloat(fragment_unnamed_523 ? asuint(((-0.0f) - fragment_input_2.y) + fragment_uniform_buffer_0[11u].y) : fragment_unnamed_550);
					float fragment_unnamed_565 = asfloat(fragment_unnamed_523 ? asuint(((-0.0f) - fragment_input_2.z) + fragment_uniform_buffer_0[11u].z) : fragment_unnamed_555);
					float fragment_unnamed_569 = rsqrt(dot(float3(fragment_unnamed_561, fragment_unnamed_563, fragment_unnamed_565), float3(fragment_unnamed_561, fragment_unnamed_563, fragment_unnamed_565)));
					float fragment_unnamed_570 = fragment_unnamed_561 * fragment_unnamed_569;
					float fragment_unnamed_571 = fragment_unnamed_563 * fragment_unnamed_569;
					float fragment_unnamed_572 = fragment_unnamed_565 * fragment_unnamed_569;
					float fragment_unnamed_573 = (-0.0f) - fragment_unnamed_570;
					float fragment_unnamed_574 = (-0.0f) - fragment_unnamed_571;
					float fragment_unnamed_575 = (-0.0f) - fragment_unnamed_572;
					float fragment_unnamed_582 = 1.0f / dot(float3(fragment_unnamed_573, fragment_unnamed_574, fragment_unnamed_575), float3((-0.0f) - asfloat(fragment_unnamed_545), (-0.0f) - asfloat(fragment_unnamed_550), (-0.0f) - asfloat(fragment_unnamed_555)));
					float fragment_unnamed_586 = fragment_unnamed_582 * (1.0f / gl_FragCoord.w);
					float fragment_unnamed_812;
					float fragment_unnamed_814;
					float fragment_unnamed_815;
					float fragment_unnamed_816;
					float fragment_unnamed_818;
					float fragment_unnamed_820;
					float fragment_unnamed_822;
					if (asuint(fragment_uniform_buffer_0[84u]).x != 0u)
					{
						float fragment_unnamed_821;
						float fragment_unnamed_1004;
						float fragment_unnamed_1006;
						float fragment_unnamed_1008;
						float fragment_unnamed_1011;
						if (asuint(fragment_uniform_buffer_0[84u]).z != 0u)
						{
							float fragment_unnamed_799 = mad((-0.0f) - fragment_uniform_buffer_0[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_0[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_582, (-0.0f) - fragment_uniform_buffer_0[94u].z), 0.0f)), fragment_uniform_buffer_0[94u].x));
							float fragment_unnamed_1095;
							float fragment_unnamed_1096;
							float fragment_unnamed_1097;
							float fragment_unnamed_1098;
							if (asuint(fragment_uniform_buffer_0[89u]).w == 0u)
							{
								float fragment_unnamed_831 = fragment_unnamed_518 * fragment_uniform_buffer_0[91u].x;
								float fragment_unnamed_832 = fragment_unnamed_519 * fragment_uniform_buffer_0[91u].y;
								float fragment_unnamed_833 = floor(fragment_unnamed_831);
								float fragment_unnamed_834 = floor(fragment_unnamed_832);
								float fragment_unnamed_839 = ((-0.0f) - frac(fragment_unnamed_831)) + 1.0f;
								float fragment_unnamed_840 = ((-0.0f) - frac(fragment_unnamed_832)) + 1.0f;
								float fragment_unnamed_841 = fragment_unnamed_840 * fragment_unnamed_840;
								float fragment_unnamed_842 = fragment_unnamed_839 * fragment_unnamed_839;
								float fragment_unnamed_847 = mad(((-0.0f) - fragment_unnamed_839) + 1.0f, fragment_unnamed_839, 0.5f);
								float fragment_unnamed_848 = mad(((-0.0f) - fragment_unnamed_840) + 1.0f, fragment_unnamed_840, 0.5f);
								float fragment_unnamed_855 = ((-0.0f) - fragment_unnamed_847) + mad((-0.0f) - fragment_unnamed_842, 0.5f, 1.0f);
								float fragment_unnamed_856 = ((-0.0f) - fragment_unnamed_848) + mad((-0.0f) - fragment_unnamed_841, 0.5f, 1.0f);
								float fragment_unnamed_857 = fragment_unnamed_847 * 0.5f;
								float fragment_unnamed_858 = fragment_unnamed_848 * 0.5f;
								float fragment_unnamed_859 = mad(fragment_unnamed_841, 0.5f, fragment_unnamed_858);
								float fragment_unnamed_860 = mad(fragment_unnamed_842, 0.5f, fragment_unnamed_857);
								float fragment_unnamed_861 = mad(fragment_unnamed_847, 0.5f, fragment_unnamed_855);
								float fragment_unnamed_862 = mad(fragment_unnamed_848, 0.5f, fragment_unnamed_856);
								float fragment_unnamed_865 = mad(fragment_unnamed_857, 1.0f / fragment_unnamed_860, -0.5f);
								float fragment_unnamed_866 = mad(fragment_unnamed_858, 1.0f / fragment_unnamed_859, -0.5f);
								float fragment_unnamed_869 = mad(fragment_unnamed_855, 1.0f / fragment_unnamed_861, 0.5f);
								float fragment_unnamed_870 = mad(fragment_unnamed_856, 1.0f / fragment_unnamed_862, 0.5f);
								float fragment_unnamed_880 = fragment_uniform_buffer_0[91u].z * fragment_uniform_buffer_0[92u].x;
								float fragment_unnamed_881 = fragment_uniform_buffer_0[91u].w * fragment_uniform_buffer_0[92u].y;
								float fragment_unnamed_901 = fragment_unnamed_799 * fragment_uniform_buffer_0[92u].z;
								float fragment_unnamed_902 = fragment_unnamed_859 * fragment_unnamed_860;
								float4 fragment_unnamed_914 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_880 * (fragment_unnamed_833 + fragment_unnamed_865), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_881 * (fragment_unnamed_834 + fragment_unnamed_866), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_901, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_920 = fragment_unnamed_859 * fragment_unnamed_861;
								float fragment_unnamed_921 = fragment_unnamed_860 * fragment_unnamed_862;
								float4 fragment_unnamed_930 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_880 * (fragment_unnamed_833 + fragment_unnamed_869), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_881 * (fragment_unnamed_834 + fragment_unnamed_866), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_901, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float4 fragment_unnamed_952 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_880 * (fragment_unnamed_833 + fragment_unnamed_865), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_881 * (fragment_unnamed_834 + fragment_unnamed_870), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_901, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_962 = fragment_unnamed_862 * fragment_unnamed_861;
								float4 fragment_unnamed_971 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_880 * (fragment_unnamed_833 + fragment_unnamed_869), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_881 * (fragment_unnamed_834 + fragment_unnamed_870), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_901, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_1095 = mad(fragment_unnamed_962, fragment_unnamed_971.x, mad(fragment_unnamed_921, fragment_unnamed_952.x, mad(fragment_unnamed_902, fragment_unnamed_914.x, fragment_unnamed_920 * fragment_unnamed_930.x)));
								fragment_unnamed_1096 = mad(fragment_unnamed_962, fragment_unnamed_971.y, mad(fragment_unnamed_921, fragment_unnamed_952.y, mad(fragment_unnamed_902, fragment_unnamed_914.y, fragment_unnamed_920 * fragment_unnamed_930.y)));
								fragment_unnamed_1097 = mad(fragment_unnamed_962, fragment_unnamed_971.z, mad(fragment_unnamed_921, fragment_unnamed_952.z, mad(fragment_unnamed_902, fragment_unnamed_914.z, fragment_unnamed_920 * fragment_unnamed_930.z)));
								fragment_unnamed_1098 = mad(fragment_unnamed_962, fragment_unnamed_971.w, mad(fragment_unnamed_921, fragment_unnamed_952.w, mad(fragment_unnamed_902, fragment_unnamed_914.w, fragment_unnamed_920 * fragment_unnamed_930.w)));
							}
							else
							{
								float4 fragment_unnamed_998 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_518 * fragment_uniform_buffer_0[92u].x, fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_519 * fragment_uniform_buffer_0[92u].y, fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_799 * fragment_uniform_buffer_0[92u].z, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_1095 = fragment_unnamed_998.x;
								fragment_unnamed_1096 = fragment_unnamed_998.y;
								fragment_unnamed_1097 = fragment_unnamed_998.z;
								fragment_unnamed_1098 = fragment_unnamed_998.w;
							}
							float fragment_unnamed_1005 = ((-0.0f) - exp2(fragment_unnamed_1098 * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1108 = asfloat((fragment_unnamed_1005 >= 5.9604644775390625e-08f) ? asuint(fragment_unnamed_1005 * (1.0f / fragment_unnamed_1098)) : 1065353216u);
							fragment_unnamed_1004 = fragment_unnamed_1005;
							fragment_unnamed_1006 = fragment_unnamed_1095 * fragment_unnamed_1108;
							fragment_unnamed_1008 = fragment_unnamed_1096 * fragment_unnamed_1108;
							fragment_unnamed_821 = asfloat(asuint(fragment_uniform_buffer_0[96u]).w);
							fragment_unnamed_1011 = fragment_unnamed_1097 * fragment_unnamed_1108;
						}
						else
						{
							fragment_unnamed_1004 = asfloat(0u);
							fragment_unnamed_1006 = asfloat(0u);
							fragment_unnamed_1008 = asfloat(0u);
							fragment_unnamed_821 = asfloat(0u);
							fragment_unnamed_1011 = asfloat(0u);
						}
						float fragment_unnamed_1017 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_582, (-0.0f) - fragment_unnamed_821);
						float fragment_unnamed_813;
						float fragment_unnamed_817;
						float fragment_unnamed_819;
						float fragment_unnamed_823;
						if ((((0.0f < fragment_unnamed_1017) ? 4294967295u : 0u) & (~asuint(fragment_unnamed_488))) != 0u)
						{
							float fragment_unnamed_1119 = dot(float3(fragment_unnamed_570, fragment_unnamed_571, fragment_unnamed_572), float3(fragment_uniform_buffer_0[83u].xyz));
							float fragment_unnamed_1123 = ((-0.0f) - fragment_unnamed_1119) * fragment_unnamed_821;
							float fragment_unnamed_1137 = max(abs(fragment_unnamed_1119), 0.001000000047497451305389404296875f);
							float fragment_unnamed_1139 = 1.0f / fragment_unnamed_1137;
							float fragment_unnamed_1142 = min(mad(fragment_unnamed_1017, (-0.0f) - fragment_unnamed_1119, fragment_unnamed_1123), fragment_unnamed_1123);
							float fragment_unnamed_1156 = min(fragment_unnamed_1017, max(fragment_unnamed_1139 * (((-0.0f) - fragment_unnamed_1142) + fragment_uniform_buffer_0[89u].y), 0.0f));
							float fragment_unnamed_1189 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_1137 * ((-0.0f) - (((-0.0f) - fragment_unnamed_1156) + fragment_unnamed_1017))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_1142 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_1139 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_1156) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_1191 = ((-0.0f) - fragment_unnamed_1004) + 1.0f;
							float fragment_unnamed_2003;
							float fragment_unnamed_2004;
							float fragment_unnamed_2005;
							if (fragment_uniform_buffer_0[86u].x == 1.0f)
							{
								float4 fragment_unnamed_1323 = _SkyTexture.SampleLevel(s1_linear_clamp, float4(fragment_unnamed_573, fragment_unnamed_574, fragment_unnamed_575, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_0[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_582, (-0.0f) - fragment_uniform_buffer_0[87u].x) / (((-0.0f) - fragment_uniform_buffer_0[87u].x) + fragment_uniform_buffer_0[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_2003 = fragment_unnamed_1323.x * fragment_uniform_buffer_0[85u].x;
								fragment_unnamed_2004 = fragment_unnamed_1323.y * fragment_uniform_buffer_0[85u].y;
								fragment_unnamed_2005 = fragment_unnamed_1323.z * fragment_uniform_buffer_0[85u].z;
							}
							else
							{
								uint4 fragment_unnamed_1339 = asuint(fragment_uniform_buffer_0[85u]);
								fragment_unnamed_2003 = asfloat(fragment_unnamed_1339.x);
								fragment_unnamed_2004 = asfloat(fragment_unnamed_1339.y);
								fragment_unnamed_2005 = asfloat(fragment_unnamed_1339.z);
							}
							float fragment_unnamed_2016 = ((-0.0f) - fragment_unnamed_1189) + 1.0f;
							fragment_unnamed_813 = mad((-0.0f) - fragment_unnamed_1191, fragment_unnamed_1189, 1.0f);
							fragment_unnamed_817 = mad((fragment_uniform_buffer_0[88u].x / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_237 * (fragment_unnamed_1191 * fragment_unnamed_2003)), fragment_unnamed_2016, fragment_unnamed_1006);
							fragment_unnamed_819 = mad((fragment_uniform_buffer_0[88u].y / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_237 * (fragment_unnamed_1191 * fragment_unnamed_2004)), fragment_unnamed_2016, fragment_unnamed_1008);
							fragment_unnamed_823 = mad((fragment_uniform_buffer_0[88u].z / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_237 * (fragment_unnamed_1191 * fragment_unnamed_2005)), fragment_unnamed_2016, fragment_unnamed_1011);
						}
						else
						{
							fragment_unnamed_813 = fragment_unnamed_1004;
							fragment_unnamed_817 = fragment_unnamed_1006;
							fragment_unnamed_819 = fragment_unnamed_1008;
							fragment_unnamed_823 = fragment_unnamed_1011;
						}
						fragment_unnamed_812 = fragment_unnamed_813;
						fragment_unnamed_814 = fragment_unnamed_813;
						fragment_unnamed_815 = fragment_unnamed_813;
						fragment_unnamed_816 = fragment_unnamed_817;
						fragment_unnamed_818 = fragment_unnamed_819;
						fragment_unnamed_820 = fragment_unnamed_821;
						fragment_unnamed_822 = fragment_unnamed_823;
					}
					else
					{
						fragment_unnamed_812 = fragment_unnamed_490;
						fragment_unnamed_814 = fragment_unnamed_492;
						fragment_unnamed_815 = fragment_unnamed_494;
						fragment_unnamed_816 = asfloat(0u);
						fragment_unnamed_818 = asfloat(0u);
						fragment_unnamed_820 = asfloat(0u);
						fragment_unnamed_822 = asfloat(0u);
					}
					float fragment_unnamed_1081;
					float fragment_unnamed_1083;
					float fragment_unnamed_1085;
					float fragment_unnamed_1087;
					float fragment_unnamed_1089;
					float fragment_unnamed_1091;
					if (asuint(fragment_unnamed_488) != 0u)
					{
						uint fragment_unnamed_1029 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 4u;
						uint4 fragment_unnamed_1041 = uint4(T11.Load(fragment_unnamed_1029).x, T11.Load(fragment_unnamed_1029 + 1u).x, T11.Load(fragment_unnamed_1029 + 2u).x, T11.Load(fragment_unnamed_1029 + 3u).x);
						float fragment_unnamed_1049 = asfloat(fragment_unnamed_1041.w);
						uint fragment_unnamed_1056 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 20u;
						uint3 fragment_unnamed_1065 = uint3(T11.Load(fragment_unnamed_1056).x, T11.Load(fragment_unnamed_1056 + 1u).x, T11.Load(fragment_unnamed_1056 + 2u).x);
						float fragment_unnamed_1067 = asfloat(fragment_unnamed_1065.x);
						float fragment_unnamed_1069 = asfloat(fragment_unnamed_1065.y);
						float fragment_unnamed_1071 = asfloat(fragment_unnamed_1065.z);
						float fragment_unnamed_1072 = fragment_unnamed_1049 * asfloat(fragment_unnamed_1041.x);
						float fragment_unnamed_1073 = fragment_unnamed_1049 * asfloat(fragment_unnamed_1041.y);
						float fragment_unnamed_1074 = fragment_unnamed_1049 * asfloat(fragment_unnamed_1041.z);
						float fragment_unnamed_1079 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_582, (-0.0f) - fragment_unnamed_820);
						float fragment_unnamed_1088;
						float fragment_unnamed_1090;
						float fragment_unnamed_1092;
						float fragment_unnamed_1346;
						float fragment_unnamed_1347;
						float fragment_unnamed_1348;
						if (0.0f < fragment_unnamed_1079)
						{
							uint fragment_unnamed_1205 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 16u;
							uint3 fragment_unnamed_1214 = uint3(T11.Load(fragment_unnamed_1205).x, T11.Load(fragment_unnamed_1205 + 1u).x, T11.Load(fragment_unnamed_1205 + 2u).x);
							float fragment_unnamed_1221 = dot(float3(fragment_unnamed_570, fragment_unnamed_571, fragment_unnamed_572), float3(fragment_unnamed_1067, fragment_unnamed_1069, fragment_unnamed_1071));
							float fragment_unnamed_1224 = fragment_unnamed_1079 * fragment_unnamed_1072;
							float fragment_unnamed_1225 = fragment_unnamed_1079 * fragment_unnamed_1073;
							float fragment_unnamed_1226 = fragment_unnamed_1079 * fragment_unnamed_1074;
							float fragment_unnamed_1233 = fragment_unnamed_237 * (((-0.0f) - fragment_unnamed_812) + 1.0f);
							float fragment_unnamed_1234 = fragment_unnamed_237 * (((-0.0f) - fragment_unnamed_814) + 1.0f);
							float fragment_unnamed_1235 = fragment_unnamed_237 * (((-0.0f) - fragment_unnamed_815) + 1.0f);
							bool fragment_unnamed_1237 = ((-0.0f) - fragment_unnamed_1221) != 1.0f;
							float fragment_unnamed_1239 = 1.0f / (fragment_unnamed_1221 + 1.0f);
							float fragment_unnamed_1243 = (-0.0f) - fragment_unnamed_1221;
							fragment_unnamed_1088 = mad(asfloat(fragment_unnamed_1237 ? asuint(fragment_unnamed_1233 * (fragment_unnamed_1239 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1224, fragment_unnamed_1243, fragment_unnamed_1224) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1233)), asfloat(fragment_unnamed_1214.x), fragment_unnamed_816);
							fragment_unnamed_1090 = mad(asfloat(fragment_unnamed_1237 ? asuint(fragment_unnamed_1234 * (fragment_unnamed_1239 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1225, fragment_unnamed_1243, fragment_unnamed_1225) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1234)), asfloat(fragment_unnamed_1214.y), fragment_unnamed_818);
							fragment_unnamed_1092 = mad(asfloat(fragment_unnamed_1237 ? asuint(fragment_unnamed_1235 * (fragment_unnamed_1239 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1226, fragment_unnamed_1243, fragment_unnamed_1226) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1235)), asfloat(fragment_unnamed_1214.z), fragment_unnamed_822);
							fragment_unnamed_1346 = fragment_unnamed_1224;
							fragment_unnamed_1347 = fragment_unnamed_1225;
							fragment_unnamed_1348 = fragment_unnamed_1226;
						}
						else
						{
							fragment_unnamed_1088 = fragment_unnamed_816;
							fragment_unnamed_1090 = fragment_unnamed_818;
							fragment_unnamed_1092 = fragment_unnamed_822;
							fragment_unnamed_1346 = asfloat(0u);
							fragment_unnamed_1347 = asfloat(0u);
							fragment_unnamed_1348 = asfloat(0u);
						}
						float fragment_unnamed_1364 = max(((-0.0f) - dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_unnamed_1067, fragment_unnamed_1069, fragment_unnamed_1071))) + ((-0.0f) - asfloat(T8.Load(0u).x)), 0.0f);
						fragment_unnamed_1081 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_812) + 1.0f), exp2(mad(fragment_unnamed_1364, fragment_unnamed_1072, fragment_unnamed_1346) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1083 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_814) + 1.0f), exp2(mad(fragment_unnamed_1364, fragment_unnamed_1073, fragment_unnamed_1347) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1085 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_815) + 1.0f), exp2(mad(fragment_unnamed_1364, fragment_unnamed_1074, fragment_unnamed_1348) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1087 = fragment_unnamed_1088;
						fragment_unnamed_1089 = fragment_unnamed_1090;
						fragment_unnamed_1091 = fragment_unnamed_1092;
					}
					else
					{
						fragment_unnamed_1081 = fragment_unnamed_812;
						fragment_unnamed_1083 = fragment_unnamed_814;
						fragment_unnamed_1085 = fragment_unnamed_815;
						fragment_unnamed_1087 = fragment_unnamed_816;
						fragment_unnamed_1089 = fragment_unnamed_818;
						fragment_unnamed_1091 = fragment_unnamed_822;
					}
					float fragment_unnamed_720;
					float fragment_unnamed_722;
					float fragment_unnamed_724;
					float fragment_unnamed_726;
					float fragment_unnamed_728;
					float fragment_unnamed_730;
					if (asuint(fragment_unnamed_488) == 0u)
					{
						float fragment_unnamed_1288;
						float fragment_unnamed_1289;
						float fragment_unnamed_1290;
						float fragment_unnamed_1291;
						float fragment_unnamed_1292;
						float fragment_unnamed_1293;
						if (asuint(fragment_uniform_buffer_0[84u]).y != 0u)
						{
							float fragment_unnamed_1390 = fragment_uniform_buffer_0[82u].w + fragment_uniform_buffer_0[83u].w;
							float fragment_unnamed_1396 = dot(float3(fragment_uniform_buffer_0[83u].xyz), float3(fragment_unnamed_573, fragment_unnamed_574, fragment_unnamed_575));
							float fragment_unnamed_1399 = 1.0f / fragment_unnamed_1390;
							float fragment_unnamed_1403 = fragment_unnamed_1399 * fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_1407 = sqrt(max(mad((-0.0f) - fragment_unnamed_1403, fragment_unnamed_1403, 1.0f), 0.0f));
							float fragment_unnamed_1411 = fragment_unnamed_1399 * fragment_uniform_buffer_2[0u].x;
							float fragment_unnamed_1414 = max(mad((-0.0f) - fragment_unnamed_1396, fragment_unnamed_1396, 1.0f), 0.0f);
							float fragment_unnamed_1416 = mad(fragment_unnamed_1411, fragment_unnamed_1411, (-0.0f) - fragment_unnamed_1414);
							float4 fragment_unnamed_1441 = _AtmosphericScatteringLUT.SampleLevel(s0_linear_clamp, float3(fragment_unnamed_518, fragment_unnamed_519, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_582, (-0.0f) - max(asfloat((fragment_unnamed_1416 < 0.0f) ? asuint(fragment_unnamed_1416) : asuint(fragment_unnamed_1390 * (((-0.0f) - fragment_unnamed_1396) + ((-0.0f) - sqrt(fragment_unnamed_1416))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
							float fragment_unnamed_1450 = (1.0f / fragment_unnamed_586) * fragment_uniform_buffer_2[0u].x;
							float fragment_unnamed_1452 = mad(fragment_unnamed_1450, fragment_unnamed_1450, (-0.0f) - fragment_unnamed_1414);
							float fragment_unnamed_1466 = min(max(asfloat((fragment_unnamed_1452 < 0.0f) ? asuint(fragment_unnamed_1452) : asuint((((-0.0f) - fragment_unnamed_1396) + ((-0.0f) - sqrt(fragment_unnamed_1452))) * fragment_unnamed_586)), 0.0f) + 128000.0f, fragment_unnamed_586);
							float fragment_unnamed_1483 = dot(float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z), float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z));
							float fragment_unnamed_1486 = rsqrt(fragment_unnamed_1483);
							float fragment_unnamed_1498 = sqrt(fragment_unnamed_1483);
							float fragment_unnamed_1499 = dot(float3(fragment_unnamed_1486 * ((-0.0f) - fragment_uniform_buffer_0[82u].x), fragment_unnamed_1486 * ((-0.0f) - fragment_uniform_buffer_0[82u].y), fragment_unnamed_1486 * ((-0.0f) - fragment_uniform_buffer_0[82u].z)), float3(fragment_unnamed_570, fragment_unnamed_571, fragment_unnamed_572));
							float fragment_unnamed_1510 = mad(fragment_unnamed_1466, fragment_unnamed_573, (-0.0f) - fragment_uniform_buffer_0[82u].x);
							float fragment_unnamed_1511 = mad(fragment_unnamed_1466, fragment_unnamed_574, (-0.0f) - fragment_uniform_buffer_0[82u].y);
							float fragment_unnamed_1512 = mad(fragment_unnamed_1466, fragment_unnamed_575, (-0.0f) - fragment_uniform_buffer_0[82u].z);
							float fragment_unnamed_1516 = sqrt(dot(float3(fragment_unnamed_1510, fragment_unnamed_1511, fragment_unnamed_1512), float3(fragment_unnamed_1510, fragment_unnamed_1511, fragment_unnamed_1512)));
							float fragment_unnamed_1521 = dot(float3(fragment_unnamed_1510, fragment_unnamed_1511, fragment_unnamed_1512), float3(fragment_unnamed_573, fragment_unnamed_574, fragment_unnamed_575)) * (1.0f / fragment_unnamed_1516);
							float fragment_unnamed_1524 = (fragment_unnamed_1521 >= 0.0f) ? ((-0.0f) - fragment_unnamed_1499) : fragment_unnamed_1499;
							float fragment_unnamed_1529 = fragment_unnamed_1498 * fragment_uniform_buffer_2[1u].x;
							float fragment_unnamed_1530 = fragment_unnamed_1498 * fragment_uniform_buffer_2[1u].z;
							float fragment_unnamed_1534 = sqrt(max(mad((-0.0f) - fragment_unnamed_1524, fragment_unnamed_1524, 1.0f), 0.0f));
							float fragment_unnamed_1539 = abs(fragment_unnamed_1524) * abs(fragment_unnamed_1524);
							float fragment_unnamed_1542 = (-0.0f) - fragment_unnamed_1539;
							float fragment_unnamed_1556 = abs(fragment_unnamed_1524);
							float fragment_unnamed_1563 = abs(fragment_unnamed_1524);
							float fragment_unnamed_1581 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1529) * 1.44269502162933349609375f) * mad(fragment_unnamed_1563, 0.5f, (1.0f / mad(fragment_unnamed_1556, fragment_unnamed_1529, sqrt(fragment_unnamed_1529 * mad(fragment_unnamed_1529 * fragment_unnamed_1539, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1542, fragment_unnamed_1529, mad(fragment_unnamed_1529, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							float fragment_unnamed_1582 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1530) * 1.44269502162933349609375f) * mad(fragment_unnamed_1563, 0.5f, (1.0f / mad(fragment_unnamed_1556, fragment_unnamed_1530, sqrt(fragment_unnamed_1530 * mad(fragment_unnamed_1530 * fragment_unnamed_1539, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1542, fragment_unnamed_1530, mad(fragment_unnamed_1530, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							bool fragment_unnamed_1583 = fragment_unnamed_1524 < 0.0f;
							float fragment_unnamed_1584 = fragment_unnamed_1529 * fragment_unnamed_1534;
							float fragment_unnamed_1585 = fragment_unnamed_1530 * fragment_unnamed_1534;
							float fragment_unnamed_1586 = rsqrt(fragment_unnamed_1584);
							float fragment_unnamed_1587 = rsqrt(fragment_unnamed_1585);
							float fragment_unnamed_1630 = fragment_unnamed_1516 * fragment_uniform_buffer_2[1u].x;
							float fragment_unnamed_1631 = fragment_unnamed_1516 * fragment_uniform_buffer_2[1u].z;
							float fragment_unnamed_1636 = abs(fragment_unnamed_1521) * abs(fragment_unnamed_1521);
							float fragment_unnamed_1639 = (-0.0f) - fragment_unnamed_1636;
							float fragment_unnamed_1650 = abs(fragment_unnamed_1521);
							float fragment_unnamed_1657 = abs(fragment_unnamed_1521);
							float fragment_unnamed_1685 = abs(mad((-0.0f) - mad(fragment_unnamed_1657, 0.5f, (1.0f / mad(fragment_unnamed_1650, fragment_unnamed_1630, sqrt(fragment_unnamed_1630 * mad(fragment_unnamed_1630 * fragment_unnamed_1636, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1639, fragment_unnamed_1630, mad(fragment_unnamed_1630, 2.0f, 1.0f)) * 0.761642992496490478515625f)), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1630) * 1.44269502162933349609375f), asfloat(fragment_unnamed_1583 ? asuint(mad((dot(fragment_unnamed_1584.xx, fragment_unnamed_1586.xx) + fragment_unnamed_1586) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1584) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_1581)) : asuint(fragment_unnamed_1581)))) * fragment_uniform_buffer_2[1u].y;
							float fragment_unnamed_1687 = 1.0f / fragment_unnamed_1498;
							float fragment_unnamed_1692 = fragment_unnamed_1687 * fragment_uniform_buffer_2[2u].z;
							float fragment_unnamed_1693 = fragment_unnamed_1687 * fragment_uniform_buffer_2[2u].w;
							float fragment_unnamed_1697 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_1499, fragment_unnamed_1499, 1.0f), 0.0f);
							float fragment_unnamed_1698 = mad(fragment_unnamed_1692, fragment_unnamed_1692, fragment_unnamed_1697);
							float fragment_unnamed_1699 = mad(fragment_unnamed_1693, fragment_unnamed_1693, fragment_unnamed_1697);
							bool fragment_unnamed_1700 = fragment_unnamed_1698 < 0.0f;
							bool fragment_unnamed_1701 = fragment_unnamed_1699 < 0.0f;
							float fragment_unnamed_1702 = sqrt(fragment_unnamed_1698);
							float fragment_unnamed_1703 = sqrt(fragment_unnamed_1699);
							uint fragment_unnamed_1714 = asuint(fragment_unnamed_1698);
							uint fragment_unnamed_1717 = fragment_unnamed_1700 ? fragment_unnamed_1714 : asuint(fragment_unnamed_1498 * (fragment_unnamed_1499 + ((-0.0f) - fragment_unnamed_1702)));
							float fragment_unnamed_1718 = asfloat(fragment_unnamed_1717);
							uint fragment_unnamed_1719 = fragment_unnamed_1700 ? fragment_unnamed_1714 : asuint(fragment_unnamed_1498 * (fragment_unnamed_1499 + fragment_unnamed_1702));
							float fragment_unnamed_1720 = asfloat(fragment_unnamed_1719);
							uint fragment_unnamed_1721 = asuint(fragment_unnamed_1699);
							uint fragment_unnamed_1726 = fragment_unnamed_1701 ? fragment_unnamed_1721 : asuint(fragment_unnamed_1498 * (fragment_unnamed_1499 + fragment_unnamed_1703));
							bool fragment_unnamed_1731 = fragment_unnamed_1718 >= 0.0f;
							float fragment_unnamed_1736 = ((-0.0f) - fragment_unnamed_1720) + asfloat(fragment_unnamed_1726);
							float fragment_unnamed_1739 = max(asfloat(fragment_unnamed_1701 ? fragment_unnamed_1721 : asuint(fragment_unnamed_1498 * (fragment_unnamed_1499 + ((-0.0f) - fragment_unnamed_1703)))), 0.0f);
							uint fragment_unnamed_1740 = fragment_unnamed_1731 ? fragment_unnamed_1717 : fragment_unnamed_1726;
							float fragment_unnamed_1746 = ((-0.0f) - fragment_unnamed_1739) + asfloat(fragment_unnamed_1740);
							bool fragment_unnamed_1749 = (((fragment_unnamed_1720 < fragment_unnamed_1466) ? 4294967295u : 0u) & (fragment_unnamed_1731 ? 4294967295u : 0u)) != 0u;
							bool fragment_unnamed_1755 = (((fragment_unnamed_1718 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1720 >= 0.0f) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_1760 = asfloat(fragment_unnamed_1755 ? fragment_unnamed_1719 : asuint(fragment_unnamed_1739));
							float fragment_unnamed_1762 = asfloat(fragment_unnamed_1755 ? asuint(fragment_unnamed_1736 * 0.5f) : (fragment_unnamed_1749 ? fragment_unnamed_1719 : asuint(fragment_unnamed_1746 * 0.5f)));
							float fragment_unnamed_1764 = asfloat(fragment_unnamed_1755 ? asuint(fragment_unnamed_1736 * 0.5f) : (fragment_unnamed_1749 ? fragment_unnamed_1740 : asuint(fragment_unnamed_1746 * 0.5f)));
							float fragment_unnamed_1766 = asfloat(fragment_unnamed_1755 ? fragment_unnamed_1726 : (fragment_unnamed_1749 ? fragment_unnamed_1726 : fragment_unnamed_1740));
							float fragment_unnamed_1771 = (-0.0f) - fragment_unnamed_1760;
							float fragment_unnamed_1772 = (-0.0f) - fragment_unnamed_1762;
							float fragment_unnamed_1775 = fragment_unnamed_1771 + min(fragment_unnamed_1466, fragment_unnamed_1764);
							float fragment_unnamed_1776 = fragment_unnamed_1772 + min(fragment_unnamed_1466, fragment_unnamed_1766);
							float fragment_unnamed_1785 = mad(fragment_unnamed_1771 + min(fragment_unnamed_1466, fragment_unnamed_1764), 0.25f, fragment_unnamed_1760);
							float fragment_unnamed_1787 = mad(fragment_unnamed_1772 + min(fragment_unnamed_1466, fragment_unnamed_1766), 0.25f, fragment_unnamed_1762);
							float fragment_unnamed_1788 = mad(fragment_unnamed_1775, 0.75f, fragment_unnamed_1760);
							float fragment_unnamed_1790 = mad(fragment_unnamed_1776, 0.75f, fragment_unnamed_1762);
							float fragment_unnamed_1792 = dot(((-0.0f) - fragment_unnamed_1499).xx, fragment_unnamed_1498.xx);
							float fragment_unnamed_1810 = (-0.0f) - fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_1846 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1790, fragment_unnamed_1790 + fragment_unnamed_1792, fragment_unnamed_1483)) + fragment_unnamed_1810, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_1776, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1788, fragment_unnamed_1788 + fragment_unnamed_1792, fragment_unnamed_1483)) + fragment_unnamed_1810, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_1775, 0.0f) * 0.5f, ((max(fragment_unnamed_1776, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1787, fragment_unnamed_1787 + fragment_unnamed_1792, fragment_unnamed_1483)) + fragment_unnamed_1810, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_1775, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1785, fragment_unnamed_1785 + fragment_unnamed_1792, fragment_unnamed_1483)) + fragment_unnamed_1810, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
							float fragment_unnamed_1851 = (abs(mad((-0.0f) - mad(fragment_unnamed_1657, 0.5f, (1.0f / mad(fragment_unnamed_1650, fragment_unnamed_1631, sqrt(fragment_unnamed_1631 * mad(fragment_unnamed_1631 * fragment_unnamed_1636, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1639, fragment_unnamed_1631, mad(fragment_unnamed_1631, 2.0f, 1.0f)) * 0.761642992496490478515625f)), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1631) * 1.44269502162933349609375f), asfloat(fragment_unnamed_1583 ? asuint(mad((dot(fragment_unnamed_1585.xx, fragment_unnamed_1587.xx) + fragment_unnamed_1587) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1585) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_1582)) : asuint(fragment_unnamed_1582)))) * fragment_uniform_buffer_2[1u].w) * fragment_uniform_buffer_2[0u].w;
							float fragment_unnamed_1878 = ((-0.0f) - exp2(mad(fragment_unnamed_1846, fragment_uniform_buffer_2[6u].x, mad(fragment_unnamed_1685, fragment_uniform_buffer_2[3u].x, fragment_unnamed_1851)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1879 = ((-0.0f) - exp2(mad(fragment_unnamed_1846, fragment_uniform_buffer_2[6u].y, mad(fragment_unnamed_1685, fragment_uniform_buffer_2[3u].y, fragment_unnamed_1851)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1880 = ((-0.0f) - exp2(mad(fragment_unnamed_1846, fragment_uniform_buffer_2[6u].z, mad(fragment_unnamed_1685, fragment_uniform_buffer_2[3u].z, fragment_unnamed_1851)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1882 = fragment_unnamed_1880 + (fragment_unnamed_1879 + fragment_unnamed_1878);
							float fragment_unnamed_1883 = fragment_unnamed_1882 * 0.3333333432674407958984375f;
							float fragment_unnamed_1885 = (-0.0f) - fragment_unnamed_1882;
							float fragment_unnamed_1904 = sqrt(((-0.0f) - fragment_unnamed_1407) + 1.0f);
							float fragment_unnamed_1910 = mad(mad(mad(fragment_unnamed_1407, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_1407, -0.212114393711090087890625f), fragment_unnamed_1407, 1.570728778839111328125f);
							float fragment_unnamed_1922 = mad(fragment_unnamed_1910, fragment_unnamed_1904, asfloat(asuint(mad(fragment_unnamed_1904 * fragment_unnamed_1910, -2.0f, 3.1415927410125732421875f)) & ((((-0.0f) - fragment_unnamed_1407) < fragment_unnamed_1407) ? 4294967295u : 0u)));
							float fragment_unnamed_1926 = sqrt(((-0.0f) - abs(fragment_unnamed_1396)) + 1.0f);
							float fragment_unnamed_1932 = mad(mad(mad(abs(fragment_unnamed_1396), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_1396), -0.212114393711090087890625f), abs(fragment_unnamed_1396), 1.570728778839111328125f);
							float fragment_unnamed_1943 = 1.0f / ((-0.0f) - fragment_unnamed_1922);
							float fragment_unnamed_1961 = mad(exp2((clamp(mad(mad(fragment_unnamed_1932, fragment_unnamed_1926, asfloat(((fragment_unnamed_1396 < ((-0.0f) - fragment_unnamed_1396)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_1926 * fragment_unnamed_1932, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_1943, (-0.0f) - (fragment_unnamed_1922 * fragment_unnamed_1943)), 0.0f, 1.0f) * fragment_uniform_buffer_2[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_2[11u].y, (-0.0f) - fragment_uniform_buffer_2[11u].y);
							float fragment_unnamed_1994 = ((-0.0f) - fragment_unnamed_1081) + 1.0f;
							float fragment_unnamed_1995 = ((-0.0f) - fragment_unnamed_1083) + 1.0f;
							float fragment_unnamed_1996 = ((-0.0f) - fragment_unnamed_1085) + 1.0f;
							fragment_unnamed_1288 = mad(fragment_unnamed_1994, mad(mad(fragment_unnamed_1885, 0.3333333432674407958984375f, fragment_unnamed_1878), fragment_uniform_buffer_2[10u].z, fragment_unnamed_1883) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1081);
							fragment_unnamed_1289 = mad(fragment_unnamed_1995, mad(mad(fragment_unnamed_1885, 0.3333333432674407958984375f, fragment_unnamed_1879), fragment_uniform_buffer_2[10u].z, fragment_unnamed_1883) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1083);
							fragment_unnamed_1290 = mad(fragment_unnamed_1996, mad(mad(fragment_unnamed_1885, 0.3333333432674407958984375f, fragment_unnamed_1880), fragment_uniform_buffer_2[10u].z, fragment_unnamed_1883) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1085);
							fragment_unnamed_1291 = mad(fragment_unnamed_1994, fragment_unnamed_1441.x * mad(fragment_unnamed_1961, ((-0.0f) - fragment_uniform_buffer_2[8u].x) + fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[8u].x), fragment_unnamed_1087);
							fragment_unnamed_1292 = mad(fragment_unnamed_1995, fragment_unnamed_1441.y * mad(fragment_unnamed_1961, ((-0.0f) - fragment_uniform_buffer_2[8u].y) + fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[8u].y), fragment_unnamed_1089);
							fragment_unnamed_1293 = mad(fragment_unnamed_1996, fragment_unnamed_1441.z * mad(fragment_unnamed_1961, ((-0.0f) - fragment_uniform_buffer_2[8u].z) + fragment_uniform_buffer_2[9u].z, fragment_uniform_buffer_2[8u].z), fragment_unnamed_1091);
						}
						else
						{
							fragment_unnamed_1288 = fragment_unnamed_1081;
							fragment_unnamed_1289 = fragment_unnamed_1083;
							fragment_unnamed_1290 = fragment_unnamed_1085;
							fragment_unnamed_1291 = fragment_unnamed_1087;
							fragment_unnamed_1292 = fragment_unnamed_1089;
							fragment_unnamed_1293 = fragment_unnamed_1091;
						}
						fragment_unnamed_720 = fragment_unnamed_1288;
						fragment_unnamed_722 = fragment_unnamed_1289;
						fragment_unnamed_724 = fragment_unnamed_1290;
						fragment_unnamed_726 = fragment_unnamed_1291;
						fragment_unnamed_728 = fragment_unnamed_1292;
						fragment_unnamed_730 = fragment_unnamed_1293;
					}
					else
					{
						fragment_unnamed_720 = fragment_unnamed_1081;
						fragment_unnamed_722 = fragment_unnamed_1083;
						fragment_unnamed_724 = fragment_unnamed_1085;
						fragment_unnamed_726 = fragment_unnamed_1087;
						fragment_unnamed_728 = fragment_unnamed_1089;
						fragment_unnamed_730 = fragment_unnamed_1091;
					}
					fragment_unnamed_719 = fragment_unnamed_720;
					fragment_unnamed_721 = fragment_unnamed_722;
					fragment_unnamed_723 = fragment_unnamed_724;
					fragment_unnamed_725 = fragment_unnamed_726;
					fragment_unnamed_727 = fragment_unnamed_728;
					fragment_unnamed_729 = fragment_unnamed_730;
				}
				else
				{
					fragment_unnamed_719 = fragment_unnamed_490;
					fragment_unnamed_721 = fragment_unnamed_492;
					fragment_unnamed_723 = fragment_unnamed_494;
					fragment_unnamed_725 = asfloat(0u);
					fragment_unnamed_727 = asfloat(0u);
					fragment_unnamed_729 = asfloat(0u);
				}
				float fragment_unnamed_734 = ((-0.0f) - fragment_unnamed_719) + 1.0f;
				float fragment_unnamed_735 = ((-0.0f) - fragment_unnamed_721) + 1.0f;
				float fragment_unnamed_736 = ((-0.0f) - fragment_unnamed_723) + 1.0f;
				float fragment_unnamed_740 = mad(fragment_unnamed_350, fragment_unnamed_734, fragment_unnamed_725);
				float fragment_unnamed_741 = mad(fragment_unnamed_351, fragment_unnamed_735, fragment_unnamed_727);
				float fragment_unnamed_742 = mad(fragment_unnamed_352, fragment_unnamed_736, fragment_unnamed_729);
				bool fragment_unnamed_746 = fragment_uniform_buffer_1[15u].x == 0.0f;
				bool fragment_unnamed_747 = fragment_uniform_buffer_1[15u].x == 1.0f;
				bool fragment_unnamed_748 = fragment_uniform_buffer_1[15u].x == 4.0f;
				fragment_output_0.x = fragment_unnamed_746 ? fragment_unnamed_740 : asfloat(fragment_unnamed_747 ? asuint(fragment_unnamed_734 * fragment_unnamed_350) : (fragment_unnamed_748 ? asuint(fragment_unnamed_740) : asuint(fragment_unnamed_350)));
				fragment_output_0.y = fragment_unnamed_746 ? fragment_unnamed_741 : asfloat(fragment_unnamed_747 ? asuint(fragment_unnamed_735 * fragment_unnamed_351) : (fragment_unnamed_748 ? asuint(fragment_unnamed_741) : asuint(fragment_unnamed_351)));
				fragment_output_0.z = fragment_unnamed_746 ? fragment_unnamed_742 : asfloat(fragment_unnamed_747 ? asuint(fragment_unnamed_736 * fragment_unnamed_352) : (fragment_unnamed_748 ? asuint(fragment_unnamed_742) : asuint(fragment_unnamed_352)));
				fragment_output_0.w = 1.0f;
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
			GpuProgramID 565636

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
			GpuProgramID 619399

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
			GpuProgramID 685619

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
			GpuProgramID 728150

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
			GpuProgramID 797777

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
			GpuProgramID 866625

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
