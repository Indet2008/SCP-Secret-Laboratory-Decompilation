Shader "Shader Graphs/VFX_WaterSurface"
{
	Properties
	{
		_Speed ("Speed", Vector) = (0.1,0.1,0,0)
		_Intensity ("Intensity", Float) = 0
		_Speed_2 ("Speed 2", Vector) = (-0.1,0.2,0,0)
		_Distort_Speed ("Distort_Speed", Vector) = (1,0,0,0)
		_Distort_Intensity ("Distort_Intensity", Float) = 0
		_Color ("Color", Color) = (0,0,0,0)
		[NoScaleOffset] _SampleTexture2D_58bd10d2cd3f4a81acb1d40f70b73f5c_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_cd0baaeff2bc49b98f6bf404a9f8d89c_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
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
			GpuProgramID 403867

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
			#ifndef DECOMP_DECL__Speed
			#define DECOMP_DECL__Speed
			float2 _Speed;
			#endif
			#ifndef DECOMP_DECL__Intensity
			#define DECOMP_DECL__Intensity
			float _Intensity;
			#endif
			#ifndef DECOMP_DECL__Speed_2
			#define DECOMP_DECL__Speed_2
			float2 _Speed_2;
			#endif
			#ifndef DECOMP_DECL__Distort_Speed
			#define DECOMP_DECL__Distort_Speed
			float2 _Distort_Speed;
			#endif
			#ifndef DECOMP_DECL__Distort_Intensity
			#define DECOMP_DECL__Distort_Intensity
			float _Distort_Intensity;
			#endif
			#ifndef DECOMP_DECL__Color
			#define DECOMP_DECL__Color
			float4 _Color;
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
			static float4 fragment_uniform_buffer_1[14];
			static float4 fragment_uniform_buffer_2[12];
			Texture2DArray<float4> _ColorPyramidTexture;
			Texture2D<float4> _ExposureTexture;
			TextureCubeArray<float4> _SkyTexture;
			Texture2D<float4> _SampleTexture2D_58bd10d2cd3f4a81acb1d40f70b73f5c_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_cd0baaeff2bc49b98f6bf404a9f8d89c_Texture_1_Texture2D;
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
			SamplerState sampler_SampleTexture2D_58bd10d2cd3f4a81acb1d40f70b73f5c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_cd0baaeff2bc49b98f6bf404a9f8d89c_Texture_1_Texture2D;

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
				float fragment_unnamed_185 = mad(fragment_input_1.x, 5.0f, fragment_uniform_buffer_0[80u].x * fragment_uniform_buffer_1[3u].x) + (-0.5f);
				float fragment_unnamed_187 = mad(fragment_input_1.y, 5.0f, fragment_uniform_buffer_0[80u].x * fragment_uniform_buffer_1[3u].y) + (-0.5f);
				float fragment_unnamed_207 = _SampleTexture2D_cd0baaeff2bc49b98f6bf404a9f8d89c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_cd0baaeff2bc49b98f6bf404a9f8d89c_Texture_1_Texture2D, float2(dot(float2(fragment_unnamed_185, fragment_unnamed_187), float2(-0.6549880504608154296875f, 0.7556393146514892578125f)) + 0.5f, dot(float2(fragment_unnamed_185, fragment_unnamed_187), float2(-0.755639255046844482421875f, -0.6549880504608154296875f)) + 0.5f), fragment_uniform_buffer_0[86u].y).x + _SampleTexture2D_58bd10d2cd3f4a81acb1d40f70b73f5c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_58bd10d2cd3f4a81acb1d40f70b73f5c_Texture_1_Texture2D, float2(mad(fragment_uniform_buffer_0[80u].x, fragment_uniform_buffer_1[2u].x, fragment_input_1.x * 4.0f), mad(fragment_uniform_buffer_0[80u].x, fragment_uniform_buffer_1[2u].y, fragment_input_1.y * 4.0f)), fragment_uniform_buffer_0[86u].y).x;
				float fragment_unnamed_223 = mad(fragment_input_1.x, 6.0f, fragment_uniform_buffer_0[80u].x * fragment_uniform_buffer_1[3u].z) + (-0.5f);
				float fragment_unnamed_224 = mad(fragment_input_1.y, 6.0f, fragment_uniform_buffer_0[80u].x * fragment_uniform_buffer_1[3u].w) + (-0.5f);
				float fragment_unnamed_233 = (dot(float2(fragment_unnamed_223, fragment_unnamed_224), float2(-0.6549880504608154296875f, 0.7556393146514892578125f)) + 0.5f) * 3.0f;
				float fragment_unnamed_235 = (dot(float2(fragment_unnamed_223, fragment_unnamed_224), float2(-0.755639255046844482421875f, -0.6549880504608154296875f)) + 0.5f) * 3.0f;
				float fragment_unnamed_236 = floor(fragment_unnamed_233);
				float fragment_unnamed_237 = floor(fragment_unnamed_235);
				float fragment_unnamed_238 = frac(fragment_unnamed_233);
				float fragment_unnamed_239 = frac(fragment_unnamed_235);
				float fragment_unnamed_243 = fragment_unnamed_236 * 289.0f;
				float fragment_unnamed_244 = fragment_unnamed_237 * 289.0f;
				float fragment_unnamed_245 = (-0.0f) - fragment_unnamed_243;
				float fragment_unnamed_246 = (-0.0f) - fragment_unnamed_244;
				float fragment_unnamed_267 = frac(fragment_unnamed_236 * asfloat((fragment_unnamed_243 >= fragment_unnamed_245) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_236 * 289.0f) >= fragment_unnamed_245) ? 1133543424u : 3281027072u);
				float fragment_unnamed_271 = fragment_unnamed_267 * mad(fragment_unnamed_267, 34.0f, 1.0f);
				float fragment_unnamed_272 = fragment_unnamed_271 * 289.0f;
				bool fragment_unnamed_274 = fragment_unnamed_272 >= ((-0.0f) - fragment_unnamed_272);
				float fragment_unnamed_281 = mad(asfloat(fragment_unnamed_274 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_274 ? 996328615u : 3143812263u) * fragment_unnamed_271), frac(fragment_unnamed_237 * asfloat((fragment_unnamed_244 >= fragment_unnamed_246) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_237 * 289.0f) >= fragment_unnamed_246) ? 1133543424u : 3281027072u));
				float fragment_unnamed_283 = fragment_unnamed_281 * mad(fragment_unnamed_281, 34.0f, 1.0f);
				float fragment_unnamed_284 = fragment_unnamed_283 * 289.0f;
				bool fragment_unnamed_286 = fragment_unnamed_284 >= ((-0.0f) - fragment_unnamed_284);
				float fragment_unnamed_296 = frac((frac(asfloat(fragment_unnamed_286 ? 996328615u : 3143812263u) * fragment_unnamed_283) * asfloat(fragment_unnamed_286 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_297 = mad(fragment_unnamed_296, 2.0f, -1.0f);
				float fragment_unnamed_303 = ((-0.0f) - floor(mad(fragment_unnamed_296, 2.0f, -0.5f))) + fragment_unnamed_297;
				float fragment_unnamed_305 = abs(fragment_unnamed_297) + (-0.5f);
				float fragment_unnamed_309 = rsqrt(dot(float2(fragment_unnamed_303, fragment_unnamed_305), float2(fragment_unnamed_303, fragment_unnamed_305)));
				float fragment_unnamed_312 = dot(float2(fragment_unnamed_309 * fragment_unnamed_303, fragment_unnamed_309 * fragment_unnamed_305), float2(fragment_unnamed_238, fragment_unnamed_239));
				float fragment_unnamed_315 = fragment_unnamed_236 + 0.0f;
				float fragment_unnamed_316 = fragment_unnamed_237 + 1.0f;
				float fragment_unnamed_317 = fragment_unnamed_236 + 1.0f;
				float fragment_unnamed_318 = fragment_unnamed_237 + 0.0f;
				float fragment_unnamed_319 = fragment_unnamed_315 * 289.0f;
				float fragment_unnamed_320 = fragment_unnamed_316 * 289.0f;
				float fragment_unnamed_321 = fragment_unnamed_317 * 289.0f;
				float fragment_unnamed_322 = fragment_unnamed_318 * 289.0f;
				bool fragment_unnamed_327 = fragment_unnamed_319 >= ((-0.0f) - fragment_unnamed_319);
				bool fragment_unnamed_328 = fragment_unnamed_320 >= ((-0.0f) - fragment_unnamed_320);
				bool fragment_unnamed_329 = fragment_unnamed_321 >= ((-0.0f) - fragment_unnamed_321);
				bool fragment_unnamed_330 = fragment_unnamed_322 >= ((-0.0f) - fragment_unnamed_322);
				float fragment_unnamed_343 = frac(fragment_unnamed_315 * asfloat(fragment_unnamed_327 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_327 ? 1133543424u : 3281027072u);
				float fragment_unnamed_346 = fragment_unnamed_343 * mad(fragment_unnamed_343, 34.0f, 1.0f);
				float fragment_unnamed_347 = fragment_unnamed_346 * 289.0f;
				bool fragment_unnamed_349 = fragment_unnamed_347 >= ((-0.0f) - fragment_unnamed_347);
				float fragment_unnamed_356 = mad(asfloat(fragment_unnamed_349 ? 1133543424u : 3281027072u), frac(fragment_unnamed_346 * asfloat(fragment_unnamed_349 ? 996328615u : 3143812263u)), frac(fragment_unnamed_316 * asfloat(fragment_unnamed_328 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_328 ? 1133543424u : 3281027072u));
				float fragment_unnamed_358 = fragment_unnamed_356 * mad(fragment_unnamed_356, 34.0f, 1.0f);
				float fragment_unnamed_359 = fragment_unnamed_358 * 289.0f;
				bool fragment_unnamed_361 = fragment_unnamed_359 >= ((-0.0f) - fragment_unnamed_359);
				float fragment_unnamed_370 = frac((frac(asfloat(fragment_unnamed_361 ? 996328615u : 3143812263u) * fragment_unnamed_358) * asfloat(fragment_unnamed_361 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_371 = mad(fragment_unnamed_370, 2.0f, -1.0f);
				float fragment_unnamed_375 = ((-0.0f) - floor(mad(fragment_unnamed_370, 2.0f, -0.5f))) + fragment_unnamed_371;
				float fragment_unnamed_377 = abs(fragment_unnamed_371) + (-0.5f);
				float fragment_unnamed_381 = rsqrt(dot(float2(fragment_unnamed_375, fragment_unnamed_377), float2(fragment_unnamed_375, fragment_unnamed_377)));
				float fragment_unnamed_403 = frac(fragment_unnamed_317 * asfloat(fragment_unnamed_329 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_329 ? 1133543424u : 3281027072u);
				float fragment_unnamed_406 = fragment_unnamed_403 * mad(fragment_unnamed_403, 34.0f, 1.0f);
				float fragment_unnamed_407 = fragment_unnamed_406 * 289.0f;
				bool fragment_unnamed_409 = fragment_unnamed_407 >= ((-0.0f) - fragment_unnamed_407);
				float fragment_unnamed_416 = mad(asfloat(fragment_unnamed_409 ? 1133543424u : 3281027072u), frac(fragment_unnamed_406 * asfloat(fragment_unnamed_409 ? 996328615u : 3143812263u)), frac(fragment_unnamed_318 * asfloat(fragment_unnamed_330 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_330 ? 1133543424u : 3281027072u));
				float fragment_unnamed_418 = fragment_unnamed_416 * mad(fragment_unnamed_416, 34.0f, 1.0f);
				float fragment_unnamed_419 = fragment_unnamed_418 * 289.0f;
				bool fragment_unnamed_421 = fragment_unnamed_419 >= ((-0.0f) - fragment_unnamed_419);
				float fragment_unnamed_430 = frac((frac(fragment_unnamed_418 * asfloat(fragment_unnamed_421 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_421 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_431 = mad(fragment_unnamed_430, 2.0f, -1.0f);
				float fragment_unnamed_435 = ((-0.0f) - floor(mad(fragment_unnamed_430, 2.0f, -0.5f))) + fragment_unnamed_431;
				float fragment_unnamed_437 = abs(fragment_unnamed_431) + (-0.5f);
				float fragment_unnamed_441 = rsqrt(dot(float2(fragment_unnamed_435, fragment_unnamed_437), float2(fragment_unnamed_435, fragment_unnamed_437)));
				float fragment_unnamed_444 = dot(float2(fragment_unnamed_441 * fragment_unnamed_435, fragment_unnamed_441 * fragment_unnamed_437), float2(fragment_unnamed_238 + (-1.0f), fragment_unnamed_239 + (-0.0f)));
				float fragment_unnamed_447 = fragment_unnamed_236 + 1.0f;
				float fragment_unnamed_448 = fragment_unnamed_237 + 1.0f;
				float fragment_unnamed_451 = fragment_unnamed_447 * 289.0f;
				float fragment_unnamed_452 = fragment_unnamed_448 * 289.0f;
				float fragment_unnamed_453 = (-0.0f) - fragment_unnamed_451;
				float fragment_unnamed_454 = (-0.0f) - fragment_unnamed_452;
				float fragment_unnamed_471 = frac(fragment_unnamed_447 * asfloat((fragment_unnamed_451 >= fragment_unnamed_453) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_447 * 289.0f) >= fragment_unnamed_453) ? 1133543424u : 3281027072u);
				float fragment_unnamed_474 = fragment_unnamed_471 * mad(fragment_unnamed_471, 34.0f, 1.0f);
				float fragment_unnamed_475 = fragment_unnamed_474 * 289.0f;
				bool fragment_unnamed_477 = fragment_unnamed_475 >= ((-0.0f) - fragment_unnamed_475);
				float fragment_unnamed_484 = mad(asfloat(fragment_unnamed_477 ? 1133543424u : 3281027072u), frac(fragment_unnamed_474 * asfloat(fragment_unnamed_477 ? 996328615u : 3143812263u)), frac(fragment_unnamed_448 * asfloat((fragment_unnamed_452 >= fragment_unnamed_454) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_448 * 289.0f) >= fragment_unnamed_454) ? 1133543424u : 3281027072u));
				float fragment_unnamed_486 = fragment_unnamed_484 * mad(fragment_unnamed_484, 34.0f, 1.0f);
				float fragment_unnamed_487 = fragment_unnamed_486 * 289.0f;
				bool fragment_unnamed_489 = fragment_unnamed_487 >= ((-0.0f) - fragment_unnamed_487);
				float fragment_unnamed_498 = frac((frac(fragment_unnamed_486 * asfloat(fragment_unnamed_489 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_489 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_499 = mad(fragment_unnamed_498, 2.0f, -1.0f);
				float fragment_unnamed_503 = ((-0.0f) - floor(mad(fragment_unnamed_498, 2.0f, -0.5f))) + fragment_unnamed_499;
				float fragment_unnamed_505 = abs(fragment_unnamed_499) + (-0.5f);
				float fragment_unnamed_509 = rsqrt(dot(float2(fragment_unnamed_503, fragment_unnamed_505), float2(fragment_unnamed_503, fragment_unnamed_505)));
				float fragment_unnamed_528 = mad(fragment_unnamed_239, mad(fragment_unnamed_239, 6.0f, -15.0f), 10.0f) * (fragment_unnamed_239 * (fragment_unnamed_239 * fragment_unnamed_239));
				float fragment_unnamed_531 = mad(fragment_unnamed_528, ((-0.0f) - fragment_unnamed_312) + dot(float2(fragment_unnamed_381 * fragment_unnamed_375, fragment_unnamed_381 * fragment_unnamed_377), float2(fragment_unnamed_238 + (-0.0f), fragment_unnamed_239 + (-1.0f))), fragment_unnamed_312);
				float fragment_unnamed_538 = mad(mad(fragment_unnamed_238, mad(fragment_unnamed_238, 6.0f, -15.0f), 10.0f) * (fragment_unnamed_238 * (fragment_unnamed_238 * fragment_unnamed_238)), ((-0.0f) - fragment_unnamed_531) + mad(fragment_unnamed_528, ((-0.0f) - fragment_unnamed_444) + dot(float2(fragment_unnamed_509 * fragment_unnamed_503, fragment_unnamed_509 * fragment_unnamed_505), float2(fragment_unnamed_238 + (-1.0f), fragment_unnamed_239 + (-1.0f))), fragment_unnamed_444), fragment_unnamed_531) + 0.5f;
				float fragment_unnamed_546 = mad(fragment_uniform_buffer_1[4u].x + 1.0f, ((-0.0f) - fragment_unnamed_538) + 1.0f, fragment_unnamed_538);
				float4 fragment_unnamed_559 = _ColorPyramidTexture.SampleLevel(s1_linear_clamp, float3((mad(fragment_unnamed_207, fragment_uniform_buffer_1[2u].z, fragment_unnamed_111 / fragment_uniform_buffer_0[61u].x) * fragment_unnamed_546) * fragment_uniform_buffer_0[219u].x, (mad(fragment_unnamed_207, fragment_uniform_buffer_1[2u].z, ((-0.0f) - (asfloat((fragment_uniform_buffer_0[58u].x < 0.0f) ? asuint(((-0.0f) - fragment_unnamed_112) + fragment_uniform_buffer_0[61u].y) : asuint(fragment_unnamed_112)) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_unnamed_546) * fragment_uniform_buffer_0[219u].y, asfloat(0u)), 0.0f);
				float4 fragment_unnamed_564 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u));
				float fragment_unnamed_567 = fragment_unnamed_564.x;
				float fragment_unnamed_572 = fragment_unnamed_567 * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_583 = 1.0f / mad(fragment_unnamed_567, fragment_uniform_buffer_0[118u].y, asfloat(((fragment_unnamed_572 == 0.0f) ? 4294967295u : 0u) & 1065353216u));
				float fragment_unnamed_600 = ((fragment_unnamed_583 * fragment_unnamed_559.x) * fragment_uniform_buffer_1[5u].x) * fragment_uniform_buffer_0[214u].w;
				float fragment_unnamed_601 = ((fragment_unnamed_583 * fragment_unnamed_559.y) * fragment_uniform_buffer_1[5u].y) * fragment_uniform_buffer_0[214u].w;
				float fragment_unnamed_602 = ((fragment_unnamed_583 * fragment_unnamed_559.z) * fragment_uniform_buffer_1[5u].z) * fragment_uniform_buffer_0[214u].w;
				float fragment_unnamed_736;
				float fragment_unnamed_738;
				float fragment_unnamed_740;
				float fragment_unnamed_742;
				float fragment_unnamed_744;
				if (asuint(fragment_uniform_buffer_0[211u]).y != 1u)
				{
					uint fragment_unnamed_608 = uint(fragment_unnamed_111);
					uint fragment_unnamed_609 = uint(fragment_unnamed_112);
					float fragment_unnamed_616 = float(fragment_unnamed_608);
					float fragment_unnamed_617 = float(fragment_unnamed_609);
					uint fragment_unnamed_637 = min(T9.Load(1u).x, max(((-T9.Load(0u).x) + 4294967295u), uint(round(dot(float2(fragment_unnamed_616, fragment_unnamed_617), float2(fragment_uniform_buffer_0[103u].y * 1.0f, fragment_uniform_buffer_0[103u].x * (-1.0f))) + ((-0.0f) - fragment_uniform_buffer_0[102u].x)))));
					bool fragment_unnamed_670 = ((((-0.0f) - float((T9.Load(fragment_unnamed_637 + 2u).x & 65535u) + 4294967295u)) + floor(dot(float2(fragment_unnamed_616, fragment_unnamed_617), float2(fragment_uniform_buffer_0[103u].xy)) + ((-0.0f) - fragment_uniform_buffer_0[102u].z))) / (((-0.0f) - fragment_uniform_buffer_0[102u].z) + fragment_uniform_buffer_0[102u].w)) < 0.0f;
					uint fragment_unnamed_671 = fragment_unnamed_670 ? 4294967295u : 0u;
					float fragment_unnamed_672 = asfloat(fragment_unnamed_671);
					float fragment_unnamed_737;
					float fragment_unnamed_739;
					float fragment_unnamed_741;
					float fragment_unnamed_743;
					float fragment_unnamed_745;
					if (asuint(fragment_uniform_buffer_0[113u]).x != 0u)
					{
						float4 fragment_unnamed_684 = _RefractiveDepthBuffer.Load(int4(uint3(fragment_unnamed_608, fragment_unnamed_609, 0u), 0u));
						float fragment_unnamed_687 = fragment_unnamed_684.x;
						uint4 fragment_unnamed_688 = _StencilTexture.Load(int4(uint3(fragment_unnamed_608, fragment_unnamed_609, 0u), 0u));
						uint fragment_unnamed_690 = fragment_unnamed_688.y;
						uint fragment_unnamed_692 = fragment_unnamed_690 & 32u;
						uint fragment_unnamed_730 = ((fragment_unnamed_690 & 1u) != 0u) ? 4294967295u : (((((((fragment_unnamed_687 >= gl_FragCoord.z) ? 4294967295u : 0u) & (fragment_unnamed_671 & ((fragment_unnamed_692 != 0u) ? 4294967295u : 0u))) != 0u) ? 3.4028234663852885981170418348452e+38f : gl_FragCoord.z) < asfloat(fragment_unnamed_670 ? 2139095039u : ((fragment_unnamed_692 != 0u) ? asuint(fragment_unnamed_687) : 0u))) ? (fragment_unnamed_670 ? asuint(fragment_uniform_buffer_0[107u]).x : (uint(_WaterGBufferTexture3.Load(int4(uint3(fragment_unnamed_608, fragment_unnamed_609, 0u), 0u)).w * 255.0f) & 15u)) : 4294967295u);
						float fragment_unnamed_756;
						float fragment_unnamed_757;
						float fragment_unnamed_758;
						float fragment_unnamed_759;
						float fragment_unnamed_760;
						if (fragment_unnamed_730 == 4294967295u)
						{
							fragment_unnamed_756 = asfloat(0u);
							fragment_unnamed_757 = asfloat(0u);
							fragment_unnamed_758 = asfloat(0u);
							fragment_unnamed_759 = asfloat(0u);
							fragment_unnamed_760 = asfloat(0u);
						}
						else
						{
							float fragment_unnamed_844;
							float fragment_unnamed_845;
							float fragment_unnamed_846;
							if (fragment_unnamed_671 == 0u)
							{
								uint fragment_unnamed_849 = (fragment_unnamed_730 * 28u) + 4u;
								uint3 fragment_unnamed_858 = uint3(T11.Load(fragment_unnamed_849).x, T11.Load(fragment_unnamed_849 + 1u).x, T11.Load(fragment_unnamed_849 + 2u).x);
								float fragment_unnamed_871 = mad(fragment_unnamed_616 * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
								float fragment_unnamed_873 = (-0.0f) - mad(fragment_unnamed_617 * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
								float fragment_unnamed_916 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_687, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_871, fragment_unnamed_873 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
								float fragment_unnamed_929 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_687, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_871, fragment_unnamed_873 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_916)) + fragment_input_2.x;
								float fragment_unnamed_930 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_687, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_871, fragment_unnamed_873 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_916)) + fragment_input_2.y;
								float fragment_unnamed_931 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_687, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_871, fragment_unnamed_873 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_916)) + fragment_input_2.z;
								float fragment_unnamed_935 = sqrt(dot(float3(fragment_unnamed_929, fragment_unnamed_930, fragment_unnamed_931), float3(fragment_unnamed_929, fragment_unnamed_930, fragment_unnamed_931)));
								float fragment_unnamed_936 = fragment_unnamed_935 + fragment_unnamed_935;
								fragment_unnamed_844 = ((-0.0f) - exp2((asfloat(fragment_unnamed_858.x) * fragment_unnamed_936) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_845 = ((-0.0f) - exp2((asfloat(fragment_unnamed_858.y) * fragment_unnamed_936) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_846 = ((-0.0f) - exp2((asfloat(fragment_unnamed_858.z) * fragment_unnamed_936) * (-1.44269502162933349609375f))) + 1.0f;
							}
							else
							{
								fragment_unnamed_844 = asfloat(0u);
								fragment_unnamed_845 = asfloat(0u);
								fragment_unnamed_846 = asfloat(0u);
							}
							fragment_unnamed_756 = fragment_unnamed_672;
							fragment_unnamed_757 = fragment_unnamed_844;
							fragment_unnamed_758 = fragment_unnamed_845;
							fragment_unnamed_759 = fragment_unnamed_846;
							fragment_unnamed_760 = asfloat(~fragment_unnamed_671);
						}
						fragment_unnamed_737 = fragment_unnamed_756;
						fragment_unnamed_739 = fragment_unnamed_757;
						fragment_unnamed_741 = fragment_unnamed_758;
						fragment_unnamed_743 = fragment_unnamed_759;
						fragment_unnamed_745 = fragment_unnamed_760;
					}
					else
					{
						fragment_unnamed_737 = fragment_unnamed_672;
						fragment_unnamed_739 = asfloat(0u);
						fragment_unnamed_741 = asfloat(0u);
						fragment_unnamed_743 = asfloat(0u);
						fragment_unnamed_745 = asfloat(0u);
					}
					fragment_unnamed_736 = fragment_unnamed_737;
					fragment_unnamed_738 = fragment_unnamed_739;
					fragment_unnamed_740 = fragment_unnamed_741;
					fragment_unnamed_742 = fragment_unnamed_743;
					fragment_unnamed_744 = fragment_unnamed_745;
				}
				else
				{
					fragment_unnamed_736 = asfloat(0u);
					fragment_unnamed_738 = asfloat(0u);
					fragment_unnamed_740 = asfloat(0u);
					fragment_unnamed_742 = asfloat(0u);
					fragment_unnamed_744 = asfloat(0u);
				}
				float fragment_unnamed_965;
				float fragment_unnamed_967;
				float fragment_unnamed_969;
				float fragment_unnamed_971;
				float fragment_unnamed_973;
				float fragment_unnamed_975;
				if (asuint(fragment_unnamed_744) == 0u)
				{
					float fragment_unnamed_766 = fragment_unnamed_111 * fragment_uniform_buffer_0[50u].z;
					float fragment_unnamed_767 = fragment_unnamed_112 * fragment_uniform_buffer_0[50u].w;
					bool fragment_unnamed_771 = fragment_uniform_buffer_0[15u].w == 0.0f;
					uint4 fragment_unnamed_792 = asuint(fragment_uniform_buffer_0[0u]);
					uint fragment_unnamed_793 = fragment_unnamed_792.z;
					uint4 fragment_unnamed_797 = asuint(fragment_uniform_buffer_0[1u]);
					uint fragment_unnamed_798 = fragment_unnamed_797.z;
					uint4 fragment_unnamed_802 = asuint(fragment_uniform_buffer_0[2u]);
					uint fragment_unnamed_803 = fragment_unnamed_802.z;
					float fragment_unnamed_809 = asfloat(fragment_unnamed_771 ? asuint(((-0.0f) - fragment_input_2.x) + fragment_uniform_buffer_0[11u].x) : fragment_unnamed_793);
					float fragment_unnamed_811 = asfloat(fragment_unnamed_771 ? asuint(((-0.0f) - fragment_input_2.y) + fragment_uniform_buffer_0[11u].y) : fragment_unnamed_798);
					float fragment_unnamed_813 = asfloat(fragment_unnamed_771 ? asuint(((-0.0f) - fragment_input_2.z) + fragment_uniform_buffer_0[11u].z) : fragment_unnamed_803);
					float fragment_unnamed_817 = rsqrt(dot(float3(fragment_unnamed_809, fragment_unnamed_811, fragment_unnamed_813), float3(fragment_unnamed_809, fragment_unnamed_811, fragment_unnamed_813)));
					float fragment_unnamed_818 = fragment_unnamed_817 * fragment_unnamed_809;
					float fragment_unnamed_819 = fragment_unnamed_817 * fragment_unnamed_811;
					float fragment_unnamed_820 = fragment_unnamed_817 * fragment_unnamed_813;
					float fragment_unnamed_821 = (-0.0f) - fragment_unnamed_818;
					float fragment_unnamed_822 = (-0.0f) - fragment_unnamed_819;
					float fragment_unnamed_823 = (-0.0f) - fragment_unnamed_820;
					float fragment_unnamed_830 = 1.0f / dot(float3(fragment_unnamed_821, fragment_unnamed_822, fragment_unnamed_823), float3((-0.0f) - asfloat(fragment_unnamed_793), (-0.0f) - asfloat(fragment_unnamed_798), (-0.0f) - asfloat(fragment_unnamed_803)));
					float fragment_unnamed_834 = fragment_unnamed_830 * (1.0f / gl_FragCoord.w);
					float fragment_unnamed_1058;
					float fragment_unnamed_1060;
					float fragment_unnamed_1062;
					float fragment_unnamed_1063;
					float fragment_unnamed_1064;
					float fragment_unnamed_1066;
					float fragment_unnamed_1068;
					if (asuint(fragment_uniform_buffer_0[84u]).x != 0u)
					{
						float fragment_unnamed_1059;
						float fragment_unnamed_1251;
						float fragment_unnamed_1253;
						float fragment_unnamed_1255;
						float fragment_unnamed_1257;
						if (asuint(fragment_uniform_buffer_0[84u]).z != 0u)
						{
							float fragment_unnamed_1045 = mad((-0.0f) - fragment_uniform_buffer_0[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_0[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_830, (-0.0f) - fragment_uniform_buffer_0[94u].z), 0.0f)), fragment_uniform_buffer_0[94u].x));
							float fragment_unnamed_1341;
							float fragment_unnamed_1342;
							float fragment_unnamed_1343;
							float fragment_unnamed_1344;
							if (asuint(fragment_uniform_buffer_0[89u]).w == 0u)
							{
								float fragment_unnamed_1077 = fragment_unnamed_766 * fragment_uniform_buffer_0[91u].x;
								float fragment_unnamed_1078 = fragment_unnamed_767 * fragment_uniform_buffer_0[91u].y;
								float fragment_unnamed_1079 = floor(fragment_unnamed_1077);
								float fragment_unnamed_1080 = floor(fragment_unnamed_1078);
								float fragment_unnamed_1085 = ((-0.0f) - frac(fragment_unnamed_1077)) + 1.0f;
								float fragment_unnamed_1086 = ((-0.0f) - frac(fragment_unnamed_1078)) + 1.0f;
								float fragment_unnamed_1087 = fragment_unnamed_1086 * fragment_unnamed_1086;
								float fragment_unnamed_1088 = fragment_unnamed_1085 * fragment_unnamed_1085;
								float fragment_unnamed_1093 = mad(((-0.0f) - fragment_unnamed_1085) + 1.0f, fragment_unnamed_1085, 0.5f);
								float fragment_unnamed_1094 = mad(((-0.0f) - fragment_unnamed_1086) + 1.0f, fragment_unnamed_1086, 0.5f);
								float fragment_unnamed_1101 = ((-0.0f) - fragment_unnamed_1093) + mad((-0.0f) - fragment_unnamed_1088, 0.5f, 1.0f);
								float fragment_unnamed_1102 = ((-0.0f) - fragment_unnamed_1094) + mad((-0.0f) - fragment_unnamed_1087, 0.5f, 1.0f);
								float fragment_unnamed_1103 = fragment_unnamed_1093 * 0.5f;
								float fragment_unnamed_1104 = fragment_unnamed_1094 * 0.5f;
								float fragment_unnamed_1105 = mad(fragment_unnamed_1087, 0.5f, fragment_unnamed_1104);
								float fragment_unnamed_1106 = mad(fragment_unnamed_1088, 0.5f, fragment_unnamed_1103);
								float fragment_unnamed_1107 = mad(fragment_unnamed_1093, 0.5f, fragment_unnamed_1101);
								float fragment_unnamed_1108 = mad(fragment_unnamed_1094, 0.5f, fragment_unnamed_1102);
								float fragment_unnamed_1111 = mad(fragment_unnamed_1103, 1.0f / fragment_unnamed_1106, -0.5f);
								float fragment_unnamed_1112 = mad(fragment_unnamed_1104, 1.0f / fragment_unnamed_1105, -0.5f);
								float fragment_unnamed_1115 = mad(fragment_unnamed_1101, 1.0f / fragment_unnamed_1107, 0.5f);
								float fragment_unnamed_1116 = mad(fragment_unnamed_1102, 1.0f / fragment_unnamed_1108, 0.5f);
								float fragment_unnamed_1126 = fragment_uniform_buffer_0[91u].z * fragment_uniform_buffer_0[92u].x;
								float fragment_unnamed_1127 = fragment_uniform_buffer_0[91u].w * fragment_uniform_buffer_0[92u].y;
								float fragment_unnamed_1147 = fragment_unnamed_1045 * fragment_uniform_buffer_0[92u].z;
								float fragment_unnamed_1148 = fragment_unnamed_1105 * fragment_unnamed_1106;
								float4 fragment_unnamed_1160 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_1126 * (fragment_unnamed_1079 + fragment_unnamed_1111), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_1127 * (fragment_unnamed_1080 + fragment_unnamed_1112), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_1147, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_1166 = fragment_unnamed_1105 * fragment_unnamed_1107;
								float fragment_unnamed_1167 = fragment_unnamed_1106 * fragment_unnamed_1108;
								float4 fragment_unnamed_1176 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_1126 * (fragment_unnamed_1079 + fragment_unnamed_1115), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_1127 * (fragment_unnamed_1080 + fragment_unnamed_1112), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_1147, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float4 fragment_unnamed_1198 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_1126 * (fragment_unnamed_1079 + fragment_unnamed_1111), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_1127 * (fragment_unnamed_1080 + fragment_unnamed_1116), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_1147, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_1208 = fragment_unnamed_1108 * fragment_unnamed_1107;
								float4 fragment_unnamed_1217 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_1126 * (fragment_unnamed_1079 + fragment_unnamed_1115), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_1127 * (fragment_unnamed_1080 + fragment_unnamed_1116), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_1147, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_1341 = mad(fragment_unnamed_1208, fragment_unnamed_1217.x, mad(fragment_unnamed_1167, fragment_unnamed_1198.x, mad(fragment_unnamed_1148, fragment_unnamed_1160.x, fragment_unnamed_1166 * fragment_unnamed_1176.x)));
								fragment_unnamed_1342 = mad(fragment_unnamed_1208, fragment_unnamed_1217.y, mad(fragment_unnamed_1167, fragment_unnamed_1198.y, mad(fragment_unnamed_1148, fragment_unnamed_1160.y, fragment_unnamed_1166 * fragment_unnamed_1176.y)));
								fragment_unnamed_1343 = mad(fragment_unnamed_1208, fragment_unnamed_1217.z, mad(fragment_unnamed_1167, fragment_unnamed_1198.z, mad(fragment_unnamed_1148, fragment_unnamed_1160.z, fragment_unnamed_1166 * fragment_unnamed_1176.z)));
								fragment_unnamed_1344 = mad(fragment_unnamed_1208, fragment_unnamed_1217.w, mad(fragment_unnamed_1167, fragment_unnamed_1198.w, mad(fragment_unnamed_1148, fragment_unnamed_1160.w, fragment_unnamed_1166 * fragment_unnamed_1176.w)));
							}
							else
							{
								float4 fragment_unnamed_1244 = _VBufferLighting.SampleLevel(s0_linear_clamp, float3(min(fragment_unnamed_766 * fragment_uniform_buffer_0[92u].x, fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_767 * fragment_uniform_buffer_0[92u].y, fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_1045 * fragment_uniform_buffer_0[92u].z, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_1341 = fragment_unnamed_1244.x;
								fragment_unnamed_1342 = fragment_unnamed_1244.y;
								fragment_unnamed_1343 = fragment_unnamed_1244.z;
								fragment_unnamed_1344 = fragment_unnamed_1244.w;
							}
							float fragment_unnamed_1252 = ((-0.0f) - exp2(fragment_unnamed_1344 * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1354 = asfloat((fragment_unnamed_1252 >= 5.9604644775390625e-08f) ? asuint(fragment_unnamed_1252 * (1.0f / fragment_unnamed_1344)) : 1065353216u);
							fragment_unnamed_1059 = asfloat(asuint(fragment_uniform_buffer_0[96u]).w);
							fragment_unnamed_1251 = fragment_unnamed_1252;
							fragment_unnamed_1253 = fragment_unnamed_1341 * fragment_unnamed_1354;
							fragment_unnamed_1255 = fragment_unnamed_1342 * fragment_unnamed_1354;
							fragment_unnamed_1257 = fragment_unnamed_1343 * fragment_unnamed_1354;
						}
						else
						{
							fragment_unnamed_1059 = asfloat(0u);
							fragment_unnamed_1251 = asfloat(0u);
							fragment_unnamed_1253 = asfloat(0u);
							fragment_unnamed_1255 = asfloat(0u);
							fragment_unnamed_1257 = asfloat(0u);
						}
						float fragment_unnamed_1263 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_830, (-0.0f) - fragment_unnamed_1059);
						float fragment_unnamed_1061;
						float fragment_unnamed_1065;
						float fragment_unnamed_1067;
						float fragment_unnamed_1069;
						if (((~asuint(fragment_unnamed_736)) & ((0.0f < fragment_unnamed_1263) ? 4294967295u : 0u)) != 0u)
						{
							float fragment_unnamed_1365 = dot(float3(fragment_unnamed_818, fragment_unnamed_819, fragment_unnamed_820), float3(fragment_uniform_buffer_0[83u].xyz));
							float fragment_unnamed_1369 = fragment_unnamed_1059 * ((-0.0f) - fragment_unnamed_1365);
							float fragment_unnamed_1383 = max(abs(fragment_unnamed_1365), 0.001000000047497451305389404296875f);
							float fragment_unnamed_1385 = 1.0f / fragment_unnamed_1383;
							float fragment_unnamed_1388 = min(mad(fragment_unnamed_1263, (-0.0f) - fragment_unnamed_1365, fragment_unnamed_1369), fragment_unnamed_1369);
							float fragment_unnamed_1402 = min(fragment_unnamed_1263, max(fragment_unnamed_1385 * (((-0.0f) - fragment_unnamed_1388) + fragment_uniform_buffer_0[89u].y), 0.0f));
							float fragment_unnamed_1435 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_1383 * ((-0.0f) - (fragment_unnamed_1263 + ((-0.0f) - fragment_unnamed_1402)))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_1388 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_1385 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_1402) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_1437 = ((-0.0f) - fragment_unnamed_1251) + 1.0f;
							float fragment_unnamed_2249;
							float fragment_unnamed_2250;
							float fragment_unnamed_2251;
							if (fragment_uniform_buffer_0[86u].x == 1.0f)
							{
								float4 fragment_unnamed_1569 = _SkyTexture.SampleLevel(s1_linear_clamp, float4(fragment_unnamed_821, fragment_unnamed_822, fragment_unnamed_823, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_0[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_830, (-0.0f) - fragment_uniform_buffer_0[87u].x) / (((-0.0f) - fragment_uniform_buffer_0[87u].x) + fragment_uniform_buffer_0[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_2249 = fragment_unnamed_1569.x * fragment_uniform_buffer_0[85u].x;
								fragment_unnamed_2250 = fragment_unnamed_1569.y * fragment_uniform_buffer_0[85u].y;
								fragment_unnamed_2251 = fragment_unnamed_1569.z * fragment_uniform_buffer_0[85u].z;
							}
							else
							{
								uint4 fragment_unnamed_1585 = asuint(fragment_uniform_buffer_0[85u]);
								fragment_unnamed_2249 = asfloat(fragment_unnamed_1585.x);
								fragment_unnamed_2250 = asfloat(fragment_unnamed_1585.y);
								fragment_unnamed_2251 = asfloat(fragment_unnamed_1585.z);
							}
							float fragment_unnamed_2262 = ((-0.0f) - fragment_unnamed_1435) + 1.0f;
							fragment_unnamed_1061 = mad((-0.0f) - fragment_unnamed_1437, fragment_unnamed_1435, 1.0f);
							fragment_unnamed_1065 = mad((fragment_uniform_buffer_0[88u].x / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_572 * (fragment_unnamed_1437 * fragment_unnamed_2249)), fragment_unnamed_2262, fragment_unnamed_1253);
							fragment_unnamed_1067 = mad((fragment_uniform_buffer_0[88u].y / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_572 * (fragment_unnamed_1437 * fragment_unnamed_2250)), fragment_unnamed_2262, fragment_unnamed_1255);
							fragment_unnamed_1069 = mad((fragment_uniform_buffer_0[88u].z / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_572 * (fragment_unnamed_1437 * fragment_unnamed_2251)), fragment_unnamed_2262, fragment_unnamed_1257);
						}
						else
						{
							fragment_unnamed_1061 = fragment_unnamed_1251;
							fragment_unnamed_1065 = fragment_unnamed_1253;
							fragment_unnamed_1067 = fragment_unnamed_1255;
							fragment_unnamed_1069 = fragment_unnamed_1257;
						}
						fragment_unnamed_1058 = fragment_unnamed_1059;
						fragment_unnamed_1060 = fragment_unnamed_1061;
						fragment_unnamed_1062 = fragment_unnamed_1061;
						fragment_unnamed_1063 = fragment_unnamed_1061;
						fragment_unnamed_1064 = fragment_unnamed_1065;
						fragment_unnamed_1066 = fragment_unnamed_1067;
						fragment_unnamed_1068 = fragment_unnamed_1069;
					}
					else
					{
						fragment_unnamed_1058 = asfloat(0u);
						fragment_unnamed_1060 = fragment_unnamed_738;
						fragment_unnamed_1062 = fragment_unnamed_740;
						fragment_unnamed_1063 = fragment_unnamed_742;
						fragment_unnamed_1064 = asfloat(0u);
						fragment_unnamed_1066 = asfloat(0u);
						fragment_unnamed_1068 = asfloat(0u);
					}
					float fragment_unnamed_1327;
					float fragment_unnamed_1329;
					float fragment_unnamed_1331;
					float fragment_unnamed_1333;
					float fragment_unnamed_1335;
					float fragment_unnamed_1337;
					if (asuint(fragment_unnamed_736) != 0u)
					{
						uint fragment_unnamed_1275 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 4u;
						uint4 fragment_unnamed_1287 = uint4(T11.Load(fragment_unnamed_1275).x, T11.Load(fragment_unnamed_1275 + 1u).x, T11.Load(fragment_unnamed_1275 + 2u).x, T11.Load(fragment_unnamed_1275 + 3u).x);
						float fragment_unnamed_1295 = asfloat(fragment_unnamed_1287.w);
						uint fragment_unnamed_1302 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 20u;
						uint3 fragment_unnamed_1311 = uint3(T11.Load(fragment_unnamed_1302).x, T11.Load(fragment_unnamed_1302 + 1u).x, T11.Load(fragment_unnamed_1302 + 2u).x);
						float fragment_unnamed_1313 = asfloat(fragment_unnamed_1311.x);
						float fragment_unnamed_1315 = asfloat(fragment_unnamed_1311.y);
						float fragment_unnamed_1317 = asfloat(fragment_unnamed_1311.z);
						float fragment_unnamed_1318 = fragment_unnamed_1295 * asfloat(fragment_unnamed_1287.x);
						float fragment_unnamed_1319 = fragment_unnamed_1295 * asfloat(fragment_unnamed_1287.y);
						float fragment_unnamed_1320 = fragment_unnamed_1295 * asfloat(fragment_unnamed_1287.z);
						float fragment_unnamed_1325 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_830, (-0.0f) - fragment_unnamed_1058);
						float fragment_unnamed_1334;
						float fragment_unnamed_1336;
						float fragment_unnamed_1338;
						float fragment_unnamed_1592;
						float fragment_unnamed_1593;
						float fragment_unnamed_1594;
						if (0.0f < fragment_unnamed_1325)
						{
							uint fragment_unnamed_1452 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 16u;
							uint3 fragment_unnamed_1461 = uint3(T11.Load(fragment_unnamed_1452).x, T11.Load(fragment_unnamed_1452 + 1u).x, T11.Load(fragment_unnamed_1452 + 2u).x);
							float fragment_unnamed_1468 = dot(float3(fragment_unnamed_818, fragment_unnamed_819, fragment_unnamed_820), float3(fragment_unnamed_1313, fragment_unnamed_1315, fragment_unnamed_1317));
							float fragment_unnamed_1471 = fragment_unnamed_1325 * fragment_unnamed_1318;
							float fragment_unnamed_1472 = fragment_unnamed_1325 * fragment_unnamed_1319;
							float fragment_unnamed_1473 = fragment_unnamed_1325 * fragment_unnamed_1320;
							float fragment_unnamed_1480 = fragment_unnamed_572 * (((-0.0f) - fragment_unnamed_1060) + 1.0f);
							float fragment_unnamed_1481 = fragment_unnamed_572 * (((-0.0f) - fragment_unnamed_1062) + 1.0f);
							float fragment_unnamed_1482 = fragment_unnamed_572 * (((-0.0f) - fragment_unnamed_1063) + 1.0f);
							bool fragment_unnamed_1484 = ((-0.0f) - fragment_unnamed_1468) != 1.0f;
							float fragment_unnamed_1486 = 1.0f / (fragment_unnamed_1468 + 1.0f);
							float fragment_unnamed_1490 = (-0.0f) - fragment_unnamed_1468;
							fragment_unnamed_1334 = mad(asfloat(fragment_unnamed_1484 ? asuint(fragment_unnamed_1480 * (fragment_unnamed_1486 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1471, fragment_unnamed_1490, fragment_unnamed_1471) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1480)), asfloat(fragment_unnamed_1461.x), fragment_unnamed_1064);
							fragment_unnamed_1336 = mad(asfloat(fragment_unnamed_1484 ? asuint(fragment_unnamed_1481 * (fragment_unnamed_1486 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1472, fragment_unnamed_1490, fragment_unnamed_1472) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1481)), asfloat(fragment_unnamed_1461.y), fragment_unnamed_1066);
							fragment_unnamed_1338 = mad(asfloat(fragment_unnamed_1484 ? asuint(fragment_unnamed_1482 * (fragment_unnamed_1486 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1473, fragment_unnamed_1490, fragment_unnamed_1473) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1482)), asfloat(fragment_unnamed_1461.z), fragment_unnamed_1068);
							fragment_unnamed_1592 = fragment_unnamed_1471;
							fragment_unnamed_1593 = fragment_unnamed_1472;
							fragment_unnamed_1594 = fragment_unnamed_1473;
						}
						else
						{
							fragment_unnamed_1334 = fragment_unnamed_1064;
							fragment_unnamed_1336 = fragment_unnamed_1066;
							fragment_unnamed_1338 = fragment_unnamed_1068;
							fragment_unnamed_1592 = asfloat(0u);
							fragment_unnamed_1593 = asfloat(0u);
							fragment_unnamed_1594 = asfloat(0u);
						}
						float fragment_unnamed_1610 = max(((-0.0f) - dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_unnamed_1313, fragment_unnamed_1315, fragment_unnamed_1317))) + ((-0.0f) - asfloat(T8.Load(0u).x)), 0.0f);
						fragment_unnamed_1327 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_1060) + 1.0f), exp2(mad(fragment_unnamed_1610, fragment_unnamed_1318, fragment_unnamed_1592) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1329 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_1062) + 1.0f), exp2(mad(fragment_unnamed_1610, fragment_unnamed_1319, fragment_unnamed_1593) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1331 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_1063) + 1.0f), exp2(mad(fragment_unnamed_1610, fragment_unnamed_1320, fragment_unnamed_1594) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1333 = fragment_unnamed_1334;
						fragment_unnamed_1335 = fragment_unnamed_1336;
						fragment_unnamed_1337 = fragment_unnamed_1338;
					}
					else
					{
						fragment_unnamed_1327 = fragment_unnamed_1060;
						fragment_unnamed_1329 = fragment_unnamed_1062;
						fragment_unnamed_1331 = fragment_unnamed_1063;
						fragment_unnamed_1333 = fragment_unnamed_1064;
						fragment_unnamed_1335 = fragment_unnamed_1066;
						fragment_unnamed_1337 = fragment_unnamed_1068;
					}
					float fragment_unnamed_966;
					float fragment_unnamed_968;
					float fragment_unnamed_970;
					float fragment_unnamed_972;
					float fragment_unnamed_974;
					float fragment_unnamed_976;
					if (asuint(fragment_unnamed_736) == 0u)
					{
						float fragment_unnamed_1535;
						float fragment_unnamed_1536;
						float fragment_unnamed_1537;
						float fragment_unnamed_1538;
						float fragment_unnamed_1539;
						float fragment_unnamed_1540;
						if (asuint(fragment_uniform_buffer_0[84u]).y != 0u)
						{
							float fragment_unnamed_1636 = fragment_uniform_buffer_0[82u].w + fragment_uniform_buffer_0[83u].w;
							float fragment_unnamed_1642 = dot(float3(fragment_uniform_buffer_0[83u].xyz), float3(fragment_unnamed_821, fragment_unnamed_822, fragment_unnamed_823));
							float fragment_unnamed_1645 = 1.0f / fragment_unnamed_1636;
							float fragment_unnamed_1649 = fragment_unnamed_1645 * fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_1653 = sqrt(max(mad((-0.0f) - fragment_unnamed_1649, fragment_unnamed_1649, 1.0f), 0.0f));
							float fragment_unnamed_1657 = fragment_unnamed_1645 * fragment_uniform_buffer_2[0u].x;
							float fragment_unnamed_1660 = max(mad((-0.0f) - fragment_unnamed_1642, fragment_unnamed_1642, 1.0f), 0.0f);
							float fragment_unnamed_1662 = mad(fragment_unnamed_1657, fragment_unnamed_1657, (-0.0f) - fragment_unnamed_1660);
							float4 fragment_unnamed_1687 = _AtmosphericScatteringLUT.SampleLevel(s0_linear_clamp, float3(fragment_unnamed_766, fragment_unnamed_767, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_830, (-0.0f) - max(asfloat((fragment_unnamed_1662 < 0.0f) ? asuint(fragment_unnamed_1662) : asuint(fragment_unnamed_1636 * (((-0.0f) - fragment_unnamed_1642) + ((-0.0f) - sqrt(fragment_unnamed_1662))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
							float fragment_unnamed_1696 = (1.0f / fragment_unnamed_834) * fragment_uniform_buffer_2[0u].x;
							float fragment_unnamed_1698 = mad(fragment_unnamed_1696, fragment_unnamed_1696, (-0.0f) - fragment_unnamed_1660);
							float fragment_unnamed_1712 = min(max(asfloat((fragment_unnamed_1698 < 0.0f) ? asuint(fragment_unnamed_1698) : asuint(fragment_unnamed_834 * (((-0.0f) - fragment_unnamed_1642) + ((-0.0f) - sqrt(fragment_unnamed_1698))))), 0.0f) + 128000.0f, fragment_unnamed_834);
							float fragment_unnamed_1729 = dot(float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z), float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z));
							float fragment_unnamed_1732 = rsqrt(fragment_unnamed_1729);
							float fragment_unnamed_1744 = sqrt(fragment_unnamed_1729);
							float fragment_unnamed_1745 = dot(float3(fragment_unnamed_1732 * ((-0.0f) - fragment_uniform_buffer_0[82u].x), fragment_unnamed_1732 * ((-0.0f) - fragment_uniform_buffer_0[82u].y), fragment_unnamed_1732 * ((-0.0f) - fragment_uniform_buffer_0[82u].z)), float3(fragment_unnamed_818, fragment_unnamed_819, fragment_unnamed_820));
							float fragment_unnamed_1756 = mad(fragment_unnamed_1712, fragment_unnamed_821, (-0.0f) - fragment_uniform_buffer_0[82u].x);
							float fragment_unnamed_1757 = mad(fragment_unnamed_1712, fragment_unnamed_822, (-0.0f) - fragment_uniform_buffer_0[82u].y);
							float fragment_unnamed_1758 = mad(fragment_unnamed_1712, fragment_unnamed_823, (-0.0f) - fragment_uniform_buffer_0[82u].z);
							float fragment_unnamed_1762 = sqrt(dot(float3(fragment_unnamed_1756, fragment_unnamed_1757, fragment_unnamed_1758), float3(fragment_unnamed_1756, fragment_unnamed_1757, fragment_unnamed_1758)));
							float fragment_unnamed_1767 = (1.0f / fragment_unnamed_1762) * dot(float3(fragment_unnamed_1756, fragment_unnamed_1757, fragment_unnamed_1758), float3(fragment_unnamed_821, fragment_unnamed_822, fragment_unnamed_823));
							float fragment_unnamed_1770 = (fragment_unnamed_1767 >= 0.0f) ? ((-0.0f) - fragment_unnamed_1745) : fragment_unnamed_1745;
							float fragment_unnamed_1775 = fragment_unnamed_1744 * fragment_uniform_buffer_2[1u].x;
							float fragment_unnamed_1776 = fragment_unnamed_1744 * fragment_uniform_buffer_2[1u].z;
							float fragment_unnamed_1780 = sqrt(max(mad((-0.0f) - fragment_unnamed_1770, fragment_unnamed_1770, 1.0f), 0.0f));
							float fragment_unnamed_1785 = abs(fragment_unnamed_1770) * abs(fragment_unnamed_1770);
							float fragment_unnamed_1788 = (-0.0f) - fragment_unnamed_1785;
							float fragment_unnamed_1802 = abs(fragment_unnamed_1770);
							float fragment_unnamed_1809 = abs(fragment_unnamed_1770);
							float fragment_unnamed_1827 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1775) * 1.44269502162933349609375f) * mad(fragment_unnamed_1809, 0.5f, (1.0f / mad(fragment_unnamed_1802, fragment_unnamed_1775, sqrt(fragment_unnamed_1775 * mad(fragment_unnamed_1775 * fragment_unnamed_1785, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1788, fragment_unnamed_1775, mad(fragment_unnamed_1775, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							float fragment_unnamed_1828 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1776) * 1.44269502162933349609375f) * mad(fragment_unnamed_1809, 0.5f, (1.0f / mad(fragment_unnamed_1802, fragment_unnamed_1776, sqrt(fragment_unnamed_1776 * mad(fragment_unnamed_1776 * fragment_unnamed_1785, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1788, fragment_unnamed_1776, mad(fragment_unnamed_1776, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							bool fragment_unnamed_1829 = fragment_unnamed_1770 < 0.0f;
							float fragment_unnamed_1830 = fragment_unnamed_1775 * fragment_unnamed_1780;
							float fragment_unnamed_1831 = fragment_unnamed_1776 * fragment_unnamed_1780;
							float fragment_unnamed_1832 = rsqrt(fragment_unnamed_1830);
							float fragment_unnamed_1833 = rsqrt(fragment_unnamed_1831);
							float fragment_unnamed_1876 = fragment_unnamed_1762 * fragment_uniform_buffer_2[1u].x;
							float fragment_unnamed_1877 = fragment_unnamed_1762 * fragment_uniform_buffer_2[1u].z;
							float fragment_unnamed_1882 = abs(fragment_unnamed_1767) * abs(fragment_unnamed_1767);
							float fragment_unnamed_1885 = (-0.0f) - fragment_unnamed_1882;
							float fragment_unnamed_1896 = abs(fragment_unnamed_1767);
							float fragment_unnamed_1903 = abs(fragment_unnamed_1767);
							float fragment_unnamed_1931 = abs(mad((-0.0f) - mad(fragment_unnamed_1903, 0.5f, (1.0f / mad(fragment_unnamed_1896, fragment_unnamed_1876, sqrt(fragment_unnamed_1876 * mad(fragment_unnamed_1876 * fragment_unnamed_1882, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1885, fragment_unnamed_1876, mad(fragment_unnamed_1876, 2.0f, 1.0f)) * 0.761642992496490478515625f)), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1876) * 1.44269502162933349609375f), asfloat(fragment_unnamed_1829 ? asuint(mad((dot(fragment_unnamed_1830.xx, fragment_unnamed_1832.xx) + fragment_unnamed_1832) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1830) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_1827)) : asuint(fragment_unnamed_1827)))) * fragment_uniform_buffer_2[1u].y;
							float fragment_unnamed_1933 = 1.0f / fragment_unnamed_1744;
							float fragment_unnamed_1938 = fragment_unnamed_1933 * fragment_uniform_buffer_2[2u].z;
							float fragment_unnamed_1939 = fragment_unnamed_1933 * fragment_uniform_buffer_2[2u].w;
							float fragment_unnamed_1943 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_1745, fragment_unnamed_1745, 1.0f), 0.0f);
							float fragment_unnamed_1944 = mad(fragment_unnamed_1938, fragment_unnamed_1938, fragment_unnamed_1943);
							float fragment_unnamed_1945 = mad(fragment_unnamed_1939, fragment_unnamed_1939, fragment_unnamed_1943);
							bool fragment_unnamed_1946 = fragment_unnamed_1944 < 0.0f;
							bool fragment_unnamed_1947 = fragment_unnamed_1945 < 0.0f;
							float fragment_unnamed_1948 = sqrt(fragment_unnamed_1944);
							float fragment_unnamed_1949 = sqrt(fragment_unnamed_1945);
							uint fragment_unnamed_1960 = asuint(fragment_unnamed_1944);
							uint fragment_unnamed_1963 = fragment_unnamed_1946 ? fragment_unnamed_1960 : asuint(fragment_unnamed_1744 * (fragment_unnamed_1745 + ((-0.0f) - fragment_unnamed_1948)));
							float fragment_unnamed_1964 = asfloat(fragment_unnamed_1963);
							uint fragment_unnamed_1965 = fragment_unnamed_1946 ? fragment_unnamed_1960 : asuint(fragment_unnamed_1744 * (fragment_unnamed_1745 + fragment_unnamed_1948));
							float fragment_unnamed_1966 = asfloat(fragment_unnamed_1965);
							uint fragment_unnamed_1967 = asuint(fragment_unnamed_1945);
							uint fragment_unnamed_1972 = fragment_unnamed_1947 ? fragment_unnamed_1967 : asuint(fragment_unnamed_1744 * (fragment_unnamed_1745 + fragment_unnamed_1949));
							bool fragment_unnamed_1977 = fragment_unnamed_1964 >= 0.0f;
							float fragment_unnamed_1982 = ((-0.0f) - fragment_unnamed_1966) + asfloat(fragment_unnamed_1972);
							float fragment_unnamed_1985 = max(asfloat(fragment_unnamed_1947 ? fragment_unnamed_1967 : asuint(fragment_unnamed_1744 * (fragment_unnamed_1745 + ((-0.0f) - fragment_unnamed_1949)))), 0.0f);
							uint fragment_unnamed_1986 = fragment_unnamed_1977 ? fragment_unnamed_1963 : fragment_unnamed_1972;
							float fragment_unnamed_1992 = ((-0.0f) - fragment_unnamed_1985) + asfloat(fragment_unnamed_1986);
							bool fragment_unnamed_1995 = (((fragment_unnamed_1966 < fragment_unnamed_1712) ? 4294967295u : 0u) & (fragment_unnamed_1977 ? 4294967295u : 0u)) != 0u;
							bool fragment_unnamed_2001 = (((fragment_unnamed_1964 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1966 >= 0.0f) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_2006 = asfloat(fragment_unnamed_2001 ? fragment_unnamed_1965 : asuint(fragment_unnamed_1985));
							float fragment_unnamed_2008 = asfloat(fragment_unnamed_2001 ? asuint(fragment_unnamed_1982 * 0.5f) : (fragment_unnamed_1995 ? fragment_unnamed_1965 : asuint(fragment_unnamed_1992 * 0.5f)));
							float fragment_unnamed_2010 = asfloat(fragment_unnamed_2001 ? asuint(fragment_unnamed_1982 * 0.5f) : (fragment_unnamed_1995 ? fragment_unnamed_1986 : asuint(fragment_unnamed_1992 * 0.5f)));
							float fragment_unnamed_2012 = asfloat(fragment_unnamed_2001 ? fragment_unnamed_1972 : (fragment_unnamed_1995 ? fragment_unnamed_1972 : fragment_unnamed_1986));
							float fragment_unnamed_2017 = (-0.0f) - fragment_unnamed_2006;
							float fragment_unnamed_2018 = (-0.0f) - fragment_unnamed_2008;
							float fragment_unnamed_2021 = fragment_unnamed_2017 + min(fragment_unnamed_1712, fragment_unnamed_2010);
							float fragment_unnamed_2022 = fragment_unnamed_2018 + min(fragment_unnamed_1712, fragment_unnamed_2012);
							float fragment_unnamed_2031 = mad(fragment_unnamed_2017 + min(fragment_unnamed_1712, fragment_unnamed_2010), 0.25f, fragment_unnamed_2006);
							float fragment_unnamed_2033 = mad(fragment_unnamed_2018 + min(fragment_unnamed_1712, fragment_unnamed_2012), 0.25f, fragment_unnamed_2008);
							float fragment_unnamed_2034 = mad(fragment_unnamed_2021, 0.75f, fragment_unnamed_2006);
							float fragment_unnamed_2036 = mad(fragment_unnamed_2022, 0.75f, fragment_unnamed_2008);
							float fragment_unnamed_2038 = dot(((-0.0f) - fragment_unnamed_1745).xx, fragment_unnamed_1744.xx);
							float fragment_unnamed_2056 = (-0.0f) - fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_2092 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_2036, fragment_unnamed_2036 + fragment_unnamed_2038, fragment_unnamed_1729)) + fragment_unnamed_2056, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_2022, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_2034, fragment_unnamed_2034 + fragment_unnamed_2038, fragment_unnamed_1729)) + fragment_unnamed_2056, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_2021, 0.0f) * 0.5f, ((max(fragment_unnamed_2022, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_2033, fragment_unnamed_2033 + fragment_unnamed_2038, fragment_unnamed_1729)) + fragment_unnamed_2056, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_2021, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_2031, fragment_unnamed_2031 + fragment_unnamed_2038, fragment_unnamed_1729)) + fragment_unnamed_2056, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
							float fragment_unnamed_2097 = (abs(mad((-0.0f) - mad(fragment_unnamed_1903, 0.5f, (1.0f / mad(fragment_unnamed_1896, fragment_unnamed_1877, sqrt(fragment_unnamed_1877 * mad(fragment_unnamed_1877 * fragment_unnamed_1882, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1885, fragment_unnamed_1877, mad(fragment_unnamed_1877, 2.0f, 1.0f)) * 0.761642992496490478515625f)), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1877) * 1.44269502162933349609375f), asfloat(fragment_unnamed_1829 ? asuint(mad((dot(fragment_unnamed_1831.xx, fragment_unnamed_1833.xx) + fragment_unnamed_1833) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1831) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_1828)) : asuint(fragment_unnamed_1828)))) * fragment_uniform_buffer_2[1u].w) * fragment_uniform_buffer_2[0u].w;
							float fragment_unnamed_2124 = ((-0.0f) - exp2(mad(fragment_unnamed_2092, fragment_uniform_buffer_2[6u].x, mad(fragment_unnamed_1931, fragment_uniform_buffer_2[3u].x, fragment_unnamed_2097)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_2125 = ((-0.0f) - exp2(mad(fragment_unnamed_2092, fragment_uniform_buffer_2[6u].y, mad(fragment_unnamed_1931, fragment_uniform_buffer_2[3u].y, fragment_unnamed_2097)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_2126 = ((-0.0f) - exp2(mad(fragment_unnamed_2092, fragment_uniform_buffer_2[6u].z, mad(fragment_unnamed_1931, fragment_uniform_buffer_2[3u].z, fragment_unnamed_2097)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_2128 = fragment_unnamed_2126 + (fragment_unnamed_2125 + fragment_unnamed_2124);
							float fragment_unnamed_2129 = fragment_unnamed_2128 * 0.3333333432674407958984375f;
							float fragment_unnamed_2131 = (-0.0f) - fragment_unnamed_2128;
							float fragment_unnamed_2150 = sqrt(((-0.0f) - fragment_unnamed_1653) + 1.0f);
							float fragment_unnamed_2156 = mad(mad(mad(fragment_unnamed_1653, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_1653, -0.212114393711090087890625f), fragment_unnamed_1653, 1.570728778839111328125f);
							float fragment_unnamed_2168 = mad(fragment_unnamed_2156, fragment_unnamed_2150, asfloat(((((-0.0f) - fragment_unnamed_1653) < fragment_unnamed_1653) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_2150 * fragment_unnamed_2156, -2.0f, 3.1415927410125732421875f))));
							float fragment_unnamed_2172 = sqrt(((-0.0f) - abs(fragment_unnamed_1642)) + 1.0f);
							float fragment_unnamed_2178 = mad(mad(mad(abs(fragment_unnamed_1642), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_1642), -0.212114393711090087890625f), abs(fragment_unnamed_1642), 1.570728778839111328125f);
							float fragment_unnamed_2189 = 1.0f / ((-0.0f) - fragment_unnamed_2168);
							float fragment_unnamed_2207 = mad(exp2((clamp(mad(mad(fragment_unnamed_2178, fragment_unnamed_2172, asfloat(((fragment_unnamed_1642 < ((-0.0f) - fragment_unnamed_1642)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_2172 * fragment_unnamed_2178, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_2189, (-0.0f) - (fragment_unnamed_2168 * fragment_unnamed_2189)), 0.0f, 1.0f) * fragment_uniform_buffer_2[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_2[11u].y, (-0.0f) - fragment_uniform_buffer_2[11u].y);
							float fragment_unnamed_2240 = ((-0.0f) - fragment_unnamed_1327) + 1.0f;
							float fragment_unnamed_2241 = ((-0.0f) - fragment_unnamed_1329) + 1.0f;
							float fragment_unnamed_2242 = ((-0.0f) - fragment_unnamed_1331) + 1.0f;
							fragment_unnamed_1535 = mad(fragment_unnamed_2240, mad(mad(fragment_unnamed_2131, 0.3333333432674407958984375f, fragment_unnamed_2124), fragment_uniform_buffer_2[10u].z, fragment_unnamed_2129) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1327);
							fragment_unnamed_1536 = mad(fragment_unnamed_2241, mad(mad(fragment_unnamed_2131, 0.3333333432674407958984375f, fragment_unnamed_2125), fragment_uniform_buffer_2[10u].z, fragment_unnamed_2129) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1329);
							fragment_unnamed_1537 = mad(fragment_unnamed_2242, mad(mad(fragment_unnamed_2131, 0.3333333432674407958984375f, fragment_unnamed_2126), fragment_uniform_buffer_2[10u].z, fragment_unnamed_2129) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1331);
							fragment_unnamed_1538 = mad(fragment_unnamed_2240, fragment_unnamed_1687.x * mad(fragment_unnamed_2207, ((-0.0f) - fragment_uniform_buffer_2[8u].x) + fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[8u].x), fragment_unnamed_1333);
							fragment_unnamed_1539 = mad(fragment_unnamed_2241, fragment_unnamed_1687.y * mad(fragment_unnamed_2207, ((-0.0f) - fragment_uniform_buffer_2[8u].y) + fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[8u].y), fragment_unnamed_1335);
							fragment_unnamed_1540 = mad(fragment_unnamed_2242, fragment_unnamed_1687.z * mad(fragment_unnamed_2207, ((-0.0f) - fragment_uniform_buffer_2[8u].z) + fragment_uniform_buffer_2[9u].z, fragment_uniform_buffer_2[8u].z), fragment_unnamed_1337);
						}
						else
						{
							fragment_unnamed_1535 = fragment_unnamed_1327;
							fragment_unnamed_1536 = fragment_unnamed_1329;
							fragment_unnamed_1537 = fragment_unnamed_1331;
							fragment_unnamed_1538 = fragment_unnamed_1333;
							fragment_unnamed_1539 = fragment_unnamed_1335;
							fragment_unnamed_1540 = fragment_unnamed_1337;
						}
						fragment_unnamed_966 = fragment_unnamed_1535;
						fragment_unnamed_968 = fragment_unnamed_1536;
						fragment_unnamed_970 = fragment_unnamed_1537;
						fragment_unnamed_972 = fragment_unnamed_1538;
						fragment_unnamed_974 = fragment_unnamed_1539;
						fragment_unnamed_976 = fragment_unnamed_1540;
					}
					else
					{
						fragment_unnamed_966 = fragment_unnamed_1327;
						fragment_unnamed_968 = fragment_unnamed_1329;
						fragment_unnamed_970 = fragment_unnamed_1331;
						fragment_unnamed_972 = fragment_unnamed_1333;
						fragment_unnamed_974 = fragment_unnamed_1335;
						fragment_unnamed_976 = fragment_unnamed_1337;
					}
					fragment_unnamed_965 = fragment_unnamed_966;
					fragment_unnamed_967 = fragment_unnamed_968;
					fragment_unnamed_969 = fragment_unnamed_970;
					fragment_unnamed_971 = fragment_unnamed_972;
					fragment_unnamed_973 = fragment_unnamed_974;
					fragment_unnamed_975 = fragment_unnamed_976;
				}
				else
				{
					fragment_unnamed_965 = fragment_unnamed_738;
					fragment_unnamed_967 = fragment_unnamed_740;
					fragment_unnamed_969 = fragment_unnamed_742;
					fragment_unnamed_971 = asfloat(0u);
					fragment_unnamed_973 = asfloat(0u);
					fragment_unnamed_975 = asfloat(0u);
				}
				float fragment_unnamed_980 = ((-0.0f) - fragment_unnamed_965) + 1.0f;
				float fragment_unnamed_981 = ((-0.0f) - fragment_unnamed_967) + 1.0f;
				float fragment_unnamed_982 = ((-0.0f) - fragment_unnamed_969) + 1.0f;
				float fragment_unnamed_986 = mad(fragment_unnamed_600, fragment_unnamed_980, fragment_unnamed_971);
				float fragment_unnamed_987 = mad(fragment_unnamed_601, fragment_unnamed_981, fragment_unnamed_973);
				float fragment_unnamed_988 = mad(fragment_unnamed_602, fragment_unnamed_982, fragment_unnamed_975);
				bool fragment_unnamed_993 = fragment_uniform_buffer_1[13u].x == 0.0f;
				bool fragment_unnamed_994 = fragment_uniform_buffer_1[13u].x == 1.0f;
				bool fragment_unnamed_995 = fragment_uniform_buffer_1[13u].x == 4.0f;
				fragment_output_0.x = fragment_unnamed_993 ? fragment_unnamed_986 : asfloat(fragment_unnamed_994 ? asuint(fragment_unnamed_980 * fragment_unnamed_600) : (fragment_unnamed_995 ? asuint(fragment_unnamed_986) : asuint(fragment_unnamed_600)));
				fragment_output_0.y = fragment_unnamed_993 ? fragment_unnamed_987 : asfloat(fragment_unnamed_994 ? asuint(fragment_unnamed_981 * fragment_unnamed_601) : (fragment_unnamed_995 ? asuint(fragment_unnamed_987) : asuint(fragment_unnamed_601)));
				fragment_output_0.z = fragment_unnamed_993 ? fragment_unnamed_988 : asfloat(fragment_unnamed_994 ? asuint(fragment_unnamed_982 * fragment_unnamed_602) : (fragment_unnamed_995 ? asuint(fragment_unnamed_988) : asuint(fragment_unnamed_602)));
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

				fragment_uniform_buffer_1[2] = float4(_Speed[0], _Speed[1], fragment_uniform_buffer_1[2][2], fragment_uniform_buffer_1[2][3]);

				fragment_uniform_buffer_1[2] = float4(fragment_uniform_buffer_1[2][0], fragment_uniform_buffer_1[2][1], _Intensity, fragment_uniform_buffer_1[2][3]);

				fragment_uniform_buffer_1[3] = float4(_Speed_2[0], _Speed_2[1], fragment_uniform_buffer_1[3][2], fragment_uniform_buffer_1[3][3]);

				fragment_uniform_buffer_1[3] = float4(fragment_uniform_buffer_1[3][0], fragment_uniform_buffer_1[3][1], _Distort_Speed[0], _Distort_Speed[1]);

				fragment_uniform_buffer_1[4] = float4(_Distort_Intensity, fragment_uniform_buffer_1[4][1], fragment_uniform_buffer_1[4][2], fragment_uniform_buffer_1[4][3]);

				fragment_uniform_buffer_1[5] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_1[13] = float4(_BlendMode, fragment_uniform_buffer_1[13][1], fragment_uniform_buffer_1[13][2], fragment_uniform_buffer_1[13][3]);

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
			GpuProgramID 541272

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
			GpuProgramID 603095

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
			GpuProgramID 689577

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
			GpuProgramID 728288

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
			GpuProgramID 794818

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
			GpuProgramID 866804

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
