Shader "Shader Graphs/DissolveDecal"
{
	Properties
	{
		_BaseColor ("BaseColor", Color) = (0,0,0,0)
		[NoScaleOffset] _BaseColorMap ("BaseColorMap", 2D) = "white" {}
		[NoScaleOffset] _MaskMap ("MaskMap", 2D) = "white" {}
		[NoScaleOffset] _NormalMap ("NormalMap", 2D) = "white" {}
		_Dissolve ("Dissolve", Range(0, 1)) = 0
		_NoiseScale ("NoiseScale", Float) = 14.63
		_DissolvePower ("DissolvePower", Float) = 2.26
		_Cutoff ("Cutoff", Float) = 0
		[NoScaleOffset] _HDRPLit_38ee15cdfb4b4f5fbb78428d4de55ad6_DetailMap_913208011_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_38ee15cdfb4b4f5fbb78428d4de55ad6_EmissiveColorMap_243130236_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[HideInInspector] _DrawOrder ("Draw Order", Float) = 0
		[Enum(Depth Bias, 0, View Bias, 1)] [HideInInspector] _DecalMeshBiasType ("Float", Float) = 0
		[HideInInspector] _DecalMeshDepthBias ("DecalMesh DepthBias", Float) = 0
		[HideInInspector] _DecalMeshViewBias ("DecalMesh ViewBias", Float) = 0
		[HideInInspector] _DecalStencilWriteMask ("Float", Float) = 0
		[HideInInspector] _DecalStencilRef ("Float", Float) = 0
		[ToggleUI] [HideInInspector] _AffectAlbedo ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _AffectNormal ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _AffectMetal ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _AffectSmoothness ("Boolean", Float) = 1
		[HideInInspector] _DecalColorMask0 ("Float", Float) = 0
		[HideInInspector] _DecalColorMask1 ("Float", Float) = 0
		[HideInInspector] _DecalColorMask2 ("Float", Float) = 0
		[HideInInspector] _DecalColorMask3 ("Float", Float) = 0
		[HideInInspector] [NoScaleOffset] unity_Lightmaps ("unity_Lightmaps", 2DArray) = "" {}
		[HideInInspector] [NoScaleOffset] unity_LightmapsInd ("unity_LightmapsInd", 2DArray) = "" {}
		[HideInInspector] [NoScaleOffset] unity_ShadowMasks ("unity_ShadowMasks", 2DArray) = "" {}
	}
	SubShader
	{
		Tags { "DisableBatching" = "False" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Opaque" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "DecalSubTarget" }
		Pass
		{
			Name "DBufferProjector"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DBufferProjector" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Opaque" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "DecalSubTarget" }
			Blend 0 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			ColorMask [_DecalColorMask0]
			Blend 1 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			ColorMask [_DecalColorMask1] 1
			Blend 2 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			ColorMask [_DecalColorMask2] 2
			Blend 3 Zero OneMinusSrcColor
			ColorMask [_DecalColorMask3] 3
			ZTest Greater
			ZWrite Off
			Cull Front
			Stencil
			{
				Ref [_DecalStencilRef]
				WriteMask [_DecalStencilWriteMask]
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
			GpuProgramID 27741

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature DECALS_3RT
			#pragma multi_compile_instancing
			#pragma shader_feature _MATERIAL_AFFECTS_ALBEDO
			#pragma shader_feature _MATERIAL_AFFECTS_MASKMAP
			#pragma shader_feature _MATERIAL_AFFECTS_NORMAL


			#if defined(DECALS_3RT) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[4];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float3 vertex_output_5 : INTERP4; // INTERP_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_82 = asfloat(1065353216u);
				float vertex_unnamed_84 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				float vertex_unnamed_113 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				float vertex_unnamed_143 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				vertex_output_5.x = vertex_unnamed_113;
				vertex_output_5.y = vertex_unnamed_84;
				vertex_output_5.z = vertex_unnamed_143;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
				vertex_output_2.x = vertex_input_4.x;
				vertex_output_2.y = vertex_input_4.y;
				vertex_output_2.z = vertex_input_4.z;
				vertex_output_2.w = vertex_input_4.w;
				vertex_output_3.x = vertex_input_5.x;
				vertex_output_3.y = vertex_input_5.y;
				vertex_output_3.z = vertex_input_5.z;
				vertex_output_3.w = vertex_input_5.w;
				vertex_output_4.x = vertex_input_6.x;
				vertex_output_4.y = vertex_input_6.y;
				vertex_output_4.z = vertex_input_6.z;
				vertex_output_4.w = vertex_input_6.w;
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
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			float4x4 _InvViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _ScreenSize;
			int _EnableDecalLayers;
			float4x4 unity_WorldToObject;
			int _DecalLayerMaskFromDecal;

			static float4 fragment_uniform_buffer_0[129];
			static float4 fragment_uniform_buffer_1[8];
			static float4 fragment_uniform_buffer_2[5];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2DArray<float4> _DecalPrepassTexture;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_283)
			{
				if (fragment_unnamed_283)
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
				uint fragment_unnamed_49 = uint(gl_FragCoord.x);
				uint fragment_unnamed_50 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_51 = _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_49, fragment_unnamed_50, 0u), 0u));
				float fragment_unnamed_54 = fragment_unnamed_51.x;
				float fragment_unnamed_68 = mad(gl_FragCoord.x * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_72 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
				float fragment_unnamed_117 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_54, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_68, fragment_unnamed_72 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
				float fragment_unnamed_118 = (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_54, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_68, fragment_unnamed_72 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_117;
				float fragment_unnamed_119 = (mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_54, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_68, fragment_unnamed_72 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_117;
				float fragment_unnamed_120 = (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_54, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_68, fragment_unnamed_72 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_117;
				uint fragment_unnamed_150;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					float4 fragment_unnamed_129 = _DecalPrepassTexture.Load(int4(uint3(fragment_unnamed_49, fragment_unnamed_50, 0u), 0u));
					fragment_unnamed_150 = (((uint(fragment_unnamed_129.y * 255.5f) | (uint(fragment_unnamed_129.x * 255.5f) << 8u)) & asuint(fragment_uniform_buffer_2[4u]).x) != 0u) ? 1065353216u : 3212836864u;
				}
				else
				{
					fragment_unnamed_150 = 1065353216u;
				}
				float fragment_unnamed_222 = mad((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_unnamed_120, mad(fragment_uniform_buffer_1[4u].x, fragment_unnamed_118, fragment_unnamed_119 * fragment_uniform_buffer_1[5u].x)), 1.0f, 0.5f);
				float fragment_unnamed_225 = mad((mad(fragment_uniform_buffer_1[6u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].y)) + fragment_uniform_buffer_1[7u].y) + mad(fragment_uniform_buffer_1[6u].y, fragment_unnamed_120, mad(fragment_uniform_buffer_1[4u].y, fragment_unnamed_118, fragment_unnamed_119 * fragment_uniform_buffer_1[5u].y)), -1.0f, 0.5f);
				float fragment_unnamed_226 = mad((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_unnamed_120, mad(fragment_uniform_buffer_1[4u].z, fragment_unnamed_118, fragment_unnamed_119 * fragment_uniform_buffer_1[5u].z)), 1.0f, 0.5f);
				discard_cond(asfloat((((((0.0f < (((-0.0f) - fragment_unnamed_226) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_225) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_222) + 1.0f)) ? 4294967295u : 0u))) & (((0.0f < fragment_unnamed_226) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_225) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_222) ? 4294967295u : 0u)))) != 0u) ? fragment_unnamed_150 : asuint(asfloat(fragment_unnamed_150) + (-2.0f))) < 0.0f);
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				fragment_output_1.x = 0.5f;
				fragment_output_1.y = 0.5f;
				fragment_output_1.z = 0.5f;
				fragment_output_1.w = 0.0f;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = 0.0f;
				fragment_output_2.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_InvViewProjMatrix[0][0], _InvViewProjMatrix[1][0], _InvViewProjMatrix[2][0], _InvViewProjMatrix[3][0]);
				fragment_uniform_buffer_0[29] = float4(_InvViewProjMatrix[0][1], _InvViewProjMatrix[1][1], _InvViewProjMatrix[2][1], _InvViewProjMatrix[3][1]);
				fragment_uniform_buffer_0[30] = float4(_InvViewProjMatrix[0][2], _InvViewProjMatrix[1][2], _InvViewProjMatrix[2][2], _InvViewProjMatrix[3][2]);
				fragment_uniform_buffer_0[31] = float4(_InvViewProjMatrix[0][3], _InvViewProjMatrix[1][3], _InvViewProjMatrix[2][3], _InvViewProjMatrix[3][3]);

				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_0[128] = float4(fragment_uniform_buffer_0[128][0], fragment_uniform_buffer_0[128][1], fragment_uniform_buffer_0[128][2], asfloat(_EnableDecalLayers));

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				fragment_uniform_buffer_2[4] = float4(asfloat(_DecalLayerMaskFromDecal), fragment_uniform_buffer_2[4][1], fragment_uniform_buffer_2[4][2], fragment_uniform_buffer_2[4][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)


			#if defined(DECALS_3RT) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[4];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float3 vertex_output_5 : INTERP4; // INTERP_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_82 = asfloat(1065353216u);
				float vertex_unnamed_84 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				float vertex_unnamed_113 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				float vertex_unnamed_143 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				vertex_output_5.x = vertex_unnamed_113;
				vertex_output_5.y = vertex_unnamed_84;
				vertex_output_5.z = vertex_unnamed_143;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
				vertex_output_2.x = vertex_input_4.x;
				vertex_output_2.y = vertex_input_4.y;
				vertex_output_2.z = vertex_input_4.z;
				vertex_output_2.w = vertex_input_4.w;
				vertex_output_3.x = vertex_input_5.x;
				vertex_output_3.y = vertex_input_5.y;
				vertex_output_3.z = vertex_input_5.z;
				vertex_output_3.w = vertex_input_5.w;
				vertex_output_4.x = vertex_input_6.x;
				vertex_output_4.y = vertex_input_6.y;
				vertex_output_4.z = vertex_input_6.z;
				vertex_output_4.w = vertex_input_6.w;
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
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4x4 _NormalToWorld;
			int _DecalLayerMaskFromDecal;
			float4 _BaseColor;
			float _Dissolve;
			float _Cutoff;

			static float4 fragment_uniform_buffer_0[129];
			static float4 fragment_uniform_buffer_1[8];
			static float4 fragment_uniform_buffer_2[5];
			static float4 fragment_uniform_buffer_3[8];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2D<float4> _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			Texture2DArray<float4> _DecalPrepassTexture;
			SamplerState sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_499)
			{
				if (fragment_unnamed_499)
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
				uint fragment_unnamed_73 = uint(gl_FragCoord.x);
				uint fragment_unnamed_74 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_75 = _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_73, fragment_unnamed_74, 0u), 0u));
				float fragment_unnamed_78 = fragment_unnamed_75.x;
				float fragment_unnamed_92 = mad(gl_FragCoord.x * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_96 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
				float fragment_unnamed_141 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_78, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_92, fragment_unnamed_96 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
				float fragment_unnamed_142 = (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_78, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_92, fragment_unnamed_96 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_141;
				float fragment_unnamed_143 = (mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_78, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_92, fragment_unnamed_96 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_141;
				float fragment_unnamed_144 = (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_78, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_92, fragment_unnamed_96 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_141;
				float fragment_unnamed_209;
				float fragment_unnamed_210;
				float fragment_unnamed_211;
				uint fragment_unnamed_212;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					float4 fragment_unnamed_153 = _DecalPrepassTexture.Load(int4(uint3(fragment_unnamed_73, fragment_unnamed_74, 0u), 0u));
					float fragment_unnamed_159 = mad(fragment_unnamed_153.z, 2.0f, -1.0f);
					float fragment_unnamed_160 = mad(fragment_unnamed_153.w, 2.0f, -1.0f);
					float fragment_unnamed_172 = ((-0.0f) - ((fragment_unnamed_160 < 0.0f) ? ((-0.0f) - fragment_unnamed_160) : fragment_unnamed_160)) + (((-0.0f) - ((fragment_unnamed_159 < 0.0f) ? ((-0.0f) - fragment_unnamed_159) : fragment_unnamed_159)) + 1.0f);
					float fragment_unnamed_174 = max((-0.0f) - fragment_unnamed_172, 0.0f);
					float fragment_unnamed_177 = (-0.0f) - fragment_unnamed_174;
					float fragment_unnamed_180 = fragment_unnamed_159 + ((fragment_unnamed_159 >= 0.0f) ? fragment_unnamed_177 : fragment_unnamed_174);
					float fragment_unnamed_181 = fragment_unnamed_160 + ((fragment_unnamed_160 >= 0.0f) ? fragment_unnamed_177 : fragment_unnamed_174);
					float fragment_unnamed_185 = rsqrt(dot(float3(fragment_unnamed_180, fragment_unnamed_181, fragment_unnamed_172), float3(fragment_unnamed_180, fragment_unnamed_181, fragment_unnamed_172)));
					fragment_unnamed_209 = fragment_unnamed_185 * fragment_unnamed_180;
					fragment_unnamed_210 = fragment_unnamed_185 * fragment_unnamed_181;
					fragment_unnamed_211 = fragment_unnamed_185 * fragment_unnamed_172;
					fragment_unnamed_212 = (((uint(fragment_unnamed_153.y * 255.5f) | (uint(fragment_unnamed_153.x * 255.5f) << 8u)) & asuint(fragment_uniform_buffer_2[4u]).x) != 0u) ? 1065353216u : 3212836864u;
				}
				else
				{
					fragment_unnamed_209 = asfloat(0u);
					fragment_unnamed_210 = asfloat(0u);
					fragment_unnamed_211 = asfloat(0u);
					fragment_unnamed_212 = 1065353216u;
				}
				float fragment_unnamed_284 = mad((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_unnamed_144, mad(fragment_uniform_buffer_1[4u].x, fragment_unnamed_142, fragment_unnamed_143 * fragment_uniform_buffer_1[5u].x)), 1.0f, 0.5f);
				float fragment_unnamed_286 = mad((mad(fragment_uniform_buffer_1[6u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].y)) + fragment_uniform_buffer_1[7u].y) + mad(fragment_uniform_buffer_1[6u].y, fragment_unnamed_144, mad(fragment_uniform_buffer_1[4u].y, fragment_unnamed_142, fragment_unnamed_143 * fragment_uniform_buffer_1[5u].y)), -1.0f, 0.5f);
				float fragment_unnamed_287 = mad((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_unnamed_144, mad(fragment_uniform_buffer_1[4u].z, fragment_unnamed_142, fragment_unnamed_143 * fragment_uniform_buffer_1[5u].z)), 1.0f, 0.5f);
				discard_cond(asfloat((((((0.0f < (((-0.0f) - fragment_unnamed_287) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_286) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_284) + 1.0f)) ? 4294967295u : 0u))) & (((0.0f < fragment_unnamed_287) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_286) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_284) ? 4294967295u : 0u)))) != 0u) ? fragment_unnamed_212 : asuint(asfloat(fragment_unnamed_212) + (-2.0f))) < 0.0f);
				float fragment_unnamed_334 = dot(float3(fragment_unnamed_209, fragment_unnamed_210, fragment_unnamed_211), float3(fragment_uniform_buffer_2[2u].xyz));
				float fragment_unnamed_368 = mad(fragment_unnamed_284, fragment_uniform_buffer_2[0u].w, fragment_uniform_buffer_2[2u].w);
				float fragment_unnamed_375 = mad(fragment_unnamed_287, fragment_uniform_buffer_2[1u].w, fragment_uniform_buffer_2[3u].w);
				float4 fragment_unnamed_382 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_368, fragment_unnamed_375), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_410 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_unnamed_368, fragment_unnamed_375), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_416 = mad(fragment_unnamed_410.x * fragment_unnamed_410.w, 2.0f, -1.0f);
				float fragment_unnamed_417 = mad(fragment_unnamed_410.y, 2.0f, -1.0f);
				float fragment_unnamed_425 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_416, fragment_unnamed_417), float2(fragment_unnamed_416, fragment_unnamed_417)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_453 = (asfloat((asuint(fragment_uniform_buffer_0[128u]).w != 0u) ? ((0.0f < fragment_uniform_buffer_2[3u].y) ? asuint(clamp(mad(fragment_unnamed_334 * mad(fragment_unnamed_334, fragment_unnamed_334, 1.25f), fragment_uniform_buffer_2[3u].y, fragment_uniform_buffer_2[3u].z), 0.0f, 1.0f)) : 1065353216u) : 1065353216u) * clamp(fragment_uniform_buffer_2[3u].x, 0.0f, 1.0f)) * (clamp(((_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D, float2(fragment_unnamed_368, fragment_unnamed_375), fragment_uniform_buffer_0[86u].y).x + mad((-0.0f) - fragment_uniform_buffer_3[7u].x, 2.0f, 1.0f)) + ((-0.0f) - fragment_uniform_buffer_3[7u].w)) / (((-0.0f) - fragment_uniform_buffer_3[7u].w) + 1.0f), 0.0f, 1.0f) * (fragment_unnamed_382.w * fragment_uniform_buffer_3[3u].w));
				fragment_output_1.x = mad(mad(fragment_uniform_buffer_2[2u].x, fragment_unnamed_425, mad(fragment_uniform_buffer_2[0u].x, fragment_unnamed_416, fragment_unnamed_417 * fragment_uniform_buffer_2[1u].x)), 0.5f, 0.5f);
				fragment_output_1.y = mad(mad(fragment_uniform_buffer_2[2u].y, fragment_unnamed_425, mad(fragment_uniform_buffer_2[0u].y, fragment_unnamed_416, fragment_unnamed_417 * fragment_uniform_buffer_2[1u].y)), 0.5f, 0.5f);
				fragment_output_1.z = mad(mad(fragment_uniform_buffer_2[2u].z, fragment_unnamed_425, mad(fragment_uniform_buffer_2[0u].z, fragment_unnamed_416, fragment_unnamed_417 * fragment_uniform_buffer_2[1u].z)), 0.5f, 0.5f);
				fragment_output_0.x = fragment_unnamed_382.x * fragment_uniform_buffer_3[3u].x;
				fragment_output_0.y = fragment_unnamed_382.y * fragment_uniform_buffer_3[3u].y;
				fragment_output_0.z = fragment_unnamed_382.z * fragment_uniform_buffer_3[3u].z;
				fragment_output_0.w = fragment_unnamed_453;
				fragment_output_1.w = fragment_unnamed_453;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_unnamed_368, fragment_unnamed_375), fragment_uniform_buffer_0[86u].y).w;
				fragment_output_2.w = fragment_unnamed_453;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				fragment_uniform_buffer_2[0] = float4(_NormalToWorld[0][0], _NormalToWorld[1][0], _NormalToWorld[2][0], _NormalToWorld[3][0]);
				fragment_uniform_buffer_2[1] = float4(_NormalToWorld[0][1], _NormalToWorld[1][1], _NormalToWorld[2][1], _NormalToWorld[3][1]);
				fragment_uniform_buffer_2[2] = float4(_NormalToWorld[0][2], _NormalToWorld[1][2], _NormalToWorld[2][2], _NormalToWorld[3][2]);
				fragment_uniform_buffer_2[3] = float4(_NormalToWorld[0][3], _NormalToWorld[1][3], _NormalToWorld[2][3], _NormalToWorld[3][3]);

				fragment_uniform_buffer_2[4] = float4(asfloat(_DecalLayerMaskFromDecal), fragment_uniform_buffer_2[4][1], fragment_uniform_buffer_2[4][2], fragment_uniform_buffer_2[4][3]);

				fragment_uniform_buffer_3[3] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_3[7] = float4(_Dissolve, fragment_uniform_buffer_3[7][1], fragment_uniform_buffer_3[7][2], fragment_uniform_buffer_3[7][3]);

				fragment_uniform_buffer_3[7] = float4(fragment_uniform_buffer_3[7][0], fragment_uniform_buffer_3[7][1], fragment_uniform_buffer_3[7][2], _Cutoff);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)


			#if defined(DECALS_3RT) && defined(INSTANCING_ON) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int unity_BaseInstanceID;
			struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[16];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static uint vertex_output_6;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float3 vertex_output_5 : INTERP4; // INTERP_4
				uint vertex_output_6 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_54 = asfloat(1065353216u);
				uint vertex_unnamed_67 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) << 3u;
				uint vertex_unnamed_79 = vertex_unnamed_67 + 3u;
				float vertex_unnamed_105 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_79].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				float vertex_unnamed_136 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_79].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				float vertex_unnamed_168 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_79].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				vertex_output_5.x = vertex_unnamed_136;
				vertex_output_5.y = vertex_unnamed_105;
				vertex_output_5.z = vertex_unnamed_168;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_168, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_136, vertex_unnamed_105 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_168, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_136, vertex_unnamed_105 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_168, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_136, vertex_unnamed_105 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_168, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_136, vertex_unnamed_105 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
				vertex_output_2.x = vertex_input_4.x;
				vertex_output_2.y = vertex_input_4.y;
				vertex_output_2.z = vertex_input_4.z;
				vertex_output_2.w = vertex_input_4.w;
				vertex_output_3.x = vertex_input_5.x;
				vertex_output_3.y = vertex_input_5.y;
				vertex_output_3.z = vertex_input_5.z;
				vertex_output_3.w = vertex_input_5.w;
				vertex_output_4.x = vertex_input_6.x;
				vertex_output_4.y = vertex_input_6.y;
				vertex_output_4.z = vertex_input_6.z;
				vertex_output_4.w = vertex_input_6.w;
				vertex_output_6 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + 0u);
				gl_BaseInstanceARB = 0u;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float4x4 _InvViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _ScreenSize;
			int _EnableDecalLayers;
			int unity_BaseInstanceID;
			struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { int _DecalLayerMaskFromDecal; float4x4 _NormalToWorld; } DecalArray[2];

			static float4 fragment_uniform_buffer_0[129];
			static float4 fragment_uniform_buffer_1[1];
			static float4 fragment_uniform_buffer_2[16];
			static float4 fragment_uniform_buffer_3[10];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2DArray<float4> _DecalPrepassTexture;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static uint fragment_input_6;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
				nointerpolation uint fragment_input_6 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_307)
			{
				if (fragment_unnamed_307)
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
				uint fragment_unnamed_57 = fragment_input_6 + asuint(fragment_uniform_buffer_1[0u]).x;
				uint fragment_unnamed_63 = uint(gl_FragCoord.x);
				uint fragment_unnamed_64 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_65 = _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_63, fragment_unnamed_64, 0u), 0u));
				float fragment_unnamed_68 = fragment_unnamed_65.x;
				float fragment_unnamed_81 = mad(gl_FragCoord.x * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_85 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
				float fragment_unnamed_130 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_68, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_81, fragment_unnamed_85 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
				float fragment_unnamed_131 = (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_68, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_81, fragment_unnamed_85 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_130;
				float fragment_unnamed_132 = (mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_68, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_81, fragment_unnamed_85 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_130;
				float fragment_unnamed_133 = (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_68, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_81, fragment_unnamed_85 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_130;
				uint fragment_unnamed_166;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					float4 fragment_unnamed_143 = _DecalPrepassTexture.Load(int4(uint3(fragment_unnamed_63, fragment_unnamed_64, 0u), 0u));
					fragment_unnamed_166 = (((uint(fragment_unnamed_143.y * 255.5f) | (uint(fragment_unnamed_143.x * 255.5f) << 8u)) & asuint(fragment_uniform_buffer_3[(fragment_unnamed_57 * 5u) + 4u]).x) != 0u) ? 1065353216u : 3212836864u;
				}
				else
				{
					fragment_unnamed_166 = 1065353216u;
				}
				uint fragment_unnamed_167 = fragment_unnamed_57 << 3u;
				uint fragment_unnamed_173 = fragment_unnamed_167 + 5u;
				uint fragment_unnamed_182 = fragment_unnamed_167 + 4u;
				uint fragment_unnamed_194 = fragment_unnamed_167 + 6u;
				uint fragment_unnamed_207 = fragment_unnamed_167 + 7u;
				uint fragment_unnamed_217 = fragment_unnamed_167 + 5u;
				uint fragment_unnamed_226 = fragment_unnamed_167 + 4u;
				uint fragment_unnamed_235 = fragment_unnamed_167 + 6u;
				float fragment_unnamed_247 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_194].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_182].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_173].x)) + fragment_uniform_buffer_2[fragment_unnamed_207].x) + mad(fragment_uniform_buffer_2[fragment_unnamed_235].x, fragment_unnamed_133, mad(fragment_uniform_buffer_2[fragment_unnamed_226].x, fragment_unnamed_131, fragment_unnamed_132 * fragment_uniform_buffer_2[fragment_unnamed_217].x)), 1.0f, 0.5f);
				float fragment_unnamed_250 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_194].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_182].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_173].y)) + fragment_uniform_buffer_2[fragment_unnamed_207].y) + mad(fragment_uniform_buffer_2[fragment_unnamed_235].y, fragment_unnamed_133, mad(fragment_uniform_buffer_2[fragment_unnamed_226].y, fragment_unnamed_131, fragment_unnamed_132 * fragment_uniform_buffer_2[fragment_unnamed_217].y)), -1.0f, 0.5f);
				float fragment_unnamed_251 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_194].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_182].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_173].z)) + fragment_uniform_buffer_2[fragment_unnamed_207].z) + mad(fragment_uniform_buffer_2[fragment_unnamed_235].z, fragment_unnamed_133, mad(fragment_uniform_buffer_2[fragment_unnamed_226].z, fragment_unnamed_131, fragment_unnamed_132 * fragment_uniform_buffer_2[fragment_unnamed_217].z)), 1.0f, 0.5f);
				discard_cond(asfloat((((((0.0f < (((-0.0f) - fragment_unnamed_251) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_250) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_247) + 1.0f)) ? 4294967295u : 0u))) & (((0.0f < fragment_unnamed_251) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_250) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_247) ? 4294967295u : 0u)))) != 0u) ? fragment_unnamed_166 : asuint(asfloat(fragment_unnamed_166) + (-2.0f))) < 0.0f);
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				fragment_output_1.x = 0.5f;
				fragment_output_1.y = 0.5f;
				fragment_output_1.z = 0.5f;
				fragment_output_1.w = 0.0f;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = 0.0f;
				fragment_output_2.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[28] = float4(_InvViewProjMatrix[0][0], _InvViewProjMatrix[1][0], _InvViewProjMatrix[2][0], _InvViewProjMatrix[3][0]);
				fragment_uniform_buffer_0[29] = float4(_InvViewProjMatrix[0][1], _InvViewProjMatrix[1][1], _InvViewProjMatrix[2][1], _InvViewProjMatrix[3][1]);
				fragment_uniform_buffer_0[30] = float4(_InvViewProjMatrix[0][2], _InvViewProjMatrix[1][2], _InvViewProjMatrix[2][2], _InvViewProjMatrix[3][2]);
				fragment_uniform_buffer_0[31] = float4(_InvViewProjMatrix[0][3], _InvViewProjMatrix[1][3], _InvViewProjMatrix[2][3], _InvViewProjMatrix[3][3]);

				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_0[128] = float4(fragment_uniform_buffer_0[128][0], fragment_uniform_buffer_0[128][1], fragment_uniform_buffer_0[128][2], asfloat(_EnableDecalLayers));

				fragment_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_1[0][1], fragment_uniform_buffer_1[0][2], fragment_uniform_buffer_1[0][3]);

				fragment_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_2[8] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_uniform_buffer_3[4] = float4(asfloat(DecalArray[0]._DecalLayerMaskFromDecal), fragment_uniform_buffer_3[4][1], fragment_uniform_buffer_3[4][2], fragment_uniform_buffer_3[4][3]);
				fragment_uniform_buffer_3[0] = float4(DecalArray[0]._NormalToWorld[0][0], DecalArray[0]._NormalToWorld[1][0], DecalArray[0]._NormalToWorld[2][0], DecalArray[0]._NormalToWorld[3][0]);
				fragment_uniform_buffer_3[1] = float4(DecalArray[0]._NormalToWorld[0][1], DecalArray[0]._NormalToWorld[1][1], DecalArray[0]._NormalToWorld[2][1], DecalArray[0]._NormalToWorld[3][1]);
				fragment_uniform_buffer_3[2] = float4(DecalArray[0]._NormalToWorld[0][2], DecalArray[0]._NormalToWorld[1][2], DecalArray[0]._NormalToWorld[2][2], DecalArray[0]._NormalToWorld[3][2]);
				fragment_uniform_buffer_3[3] = float4(DecalArray[0]._NormalToWorld[0][3], DecalArray[0]._NormalToWorld[1][3], DecalArray[0]._NormalToWorld[2][3], DecalArray[0]._NormalToWorld[3][3]);
				fragment_uniform_buffer_3[9] = float4(asfloat(DecalArray[1]._DecalLayerMaskFromDecal), fragment_uniform_buffer_3[9][1], fragment_uniform_buffer_3[9][2], fragment_uniform_buffer_3[9][3]);
				fragment_uniform_buffer_3[5] = float4(DecalArray[1]._NormalToWorld[0][0], DecalArray[1]._NormalToWorld[1][0], DecalArray[1]._NormalToWorld[2][0], DecalArray[1]._NormalToWorld[3][0]);
				fragment_uniform_buffer_3[6] = float4(DecalArray[1]._NormalToWorld[0][1], DecalArray[1]._NormalToWorld[1][1], DecalArray[1]._NormalToWorld[2][1], DecalArray[1]._NormalToWorld[3][1]);
				fragment_uniform_buffer_3[7] = float4(DecalArray[1]._NormalToWorld[0][2], DecalArray[1]._NormalToWorld[1][2], DecalArray[1]._NormalToWorld[2][2], DecalArray[1]._NormalToWorld[3][2]);
				fragment_uniform_buffer_3[8] = float4(DecalArray[1]._NormalToWorld[0][3], DecalArray[1]._NormalToWorld[1][3], DecalArray[1]._NormalToWorld[2][3], DecalArray[1]._NormalToWorld[3][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(INSTANCING_ON) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL)


			#if defined(DECALS_3RT) && defined(INSTANCING_ON) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int unity_BaseInstanceID;
			struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[16];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static uint vertex_output_6;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float3 vertex_output_5 : INTERP4; // INTERP_4
				uint vertex_output_6 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_54 = asfloat(1065353216u);
				uint vertex_unnamed_67 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) << 3u;
				uint vertex_unnamed_79 = vertex_unnamed_67 + 3u;
				float vertex_unnamed_105 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_79].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				float vertex_unnamed_136 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_79].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				float vertex_unnamed_168 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_79].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				vertex_output_5.x = vertex_unnamed_136;
				vertex_output_5.y = vertex_unnamed_105;
				vertex_output_5.z = vertex_unnamed_168;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_168, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_136, vertex_unnamed_105 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_168, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_136, vertex_unnamed_105 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_168, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_136, vertex_unnamed_105 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_168, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_136, vertex_unnamed_105 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
				vertex_output_2.x = vertex_input_4.x;
				vertex_output_2.y = vertex_input_4.y;
				vertex_output_2.z = vertex_input_4.z;
				vertex_output_2.w = vertex_input_4.w;
				vertex_output_3.x = vertex_input_5.x;
				vertex_output_3.y = vertex_input_5.y;
				vertex_output_3.z = vertex_input_5.z;
				vertex_output_3.w = vertex_input_5.w;
				vertex_output_4.x = vertex_input_6.x;
				vertex_output_4.y = vertex_input_6.y;
				vertex_output_4.z = vertex_input_6.z;
				vertex_output_4.w = vertex_input_6.w;
				vertex_output_6 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + 0u);
				gl_BaseInstanceARB = 0u;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}


			float _GlobalMipBias;
			int unity_BaseInstanceID;
			struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { int _DecalLayerMaskFromDecal; float4x4 _NormalToWorld; } DecalArray[2];
			float4 _BaseColor;
			float _Dissolve;
			float _Cutoff;

			static float4 fragment_uniform_buffer_0[129];
			static float4 fragment_uniform_buffer_1[1];
			static float4 fragment_uniform_buffer_2[16];
			static float4 fragment_uniform_buffer_3[10];
			static float4 fragment_uniform_buffer_4[8];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2D<float4> _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			Texture2DArray<float4> _DecalPrepassTexture;
			SamplerState sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static uint fragment_input_6;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
				nointerpolation uint fragment_input_6 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_543)
			{
				if (fragment_unnamed_543)
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
				uint fragment_unnamed_82 = fragment_input_6 + asuint(fragment_uniform_buffer_1[0u]).x;
				uint fragment_unnamed_88 = uint(gl_FragCoord.x);
				uint fragment_unnamed_89 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_90 = _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_88, fragment_unnamed_89, 0u), 0u));
				float fragment_unnamed_93 = fragment_unnamed_90.x;
				float fragment_unnamed_106 = mad(gl_FragCoord.x * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_110 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
				float fragment_unnamed_155 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_93, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_106, fragment_unnamed_110 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
				float fragment_unnamed_156 = (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_93, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_106, fragment_unnamed_110 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_155;
				float fragment_unnamed_157 = (mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_93, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_106, fragment_unnamed_110 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_155;
				float fragment_unnamed_158 = (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_93, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_106, fragment_unnamed_110 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_155;
				float fragment_unnamed_227;
				float fragment_unnamed_228;
				float fragment_unnamed_229;
				float fragment_unnamed_230;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					float4 fragment_unnamed_168 = _DecalPrepassTexture.Load(int4(uint3(fragment_unnamed_88, fragment_unnamed_89, 0u), 0u));
					float fragment_unnamed_174 = mad(fragment_unnamed_168.z, 2.0f, -1.0f);
					float fragment_unnamed_175 = mad(fragment_unnamed_168.w, 2.0f, -1.0f);
					float fragment_unnamed_187 = ((-0.0f) - ((fragment_unnamed_175 < 0.0f) ? ((-0.0f) - fragment_unnamed_175) : fragment_unnamed_175)) + (((-0.0f) - ((fragment_unnamed_174 < 0.0f) ? ((-0.0f) - fragment_unnamed_174) : fragment_unnamed_174)) + 1.0f);
					float fragment_unnamed_189 = max((-0.0f) - fragment_unnamed_187, 0.0f);
					float fragment_unnamed_192 = (-0.0f) - fragment_unnamed_189;
					float fragment_unnamed_195 = fragment_unnamed_174 + ((fragment_unnamed_174 >= 0.0f) ? fragment_unnamed_192 : fragment_unnamed_189);
					float fragment_unnamed_196 = fragment_unnamed_175 + ((fragment_unnamed_175 >= 0.0f) ? fragment_unnamed_192 : fragment_unnamed_189);
					float fragment_unnamed_200 = rsqrt(dot(float3(fragment_unnamed_195, fragment_unnamed_196, fragment_unnamed_187), float3(fragment_unnamed_195, fragment_unnamed_196, fragment_unnamed_187)));
					fragment_unnamed_227 = fragment_unnamed_200 * fragment_unnamed_195;
					fragment_unnamed_228 = fragment_unnamed_200 * fragment_unnamed_196;
					fragment_unnamed_229 = fragment_unnamed_200 * fragment_unnamed_187;
					fragment_unnamed_230 = asfloat((((uint(fragment_unnamed_168.y * 255.5f) | (uint(fragment_unnamed_168.x * 255.5f) << 8u)) & asuint(fragment_uniform_buffer_3[(fragment_unnamed_82 * 5u) + 4u]).x) != 0u) ? 1065353216u : 3212836864u);
				}
				else
				{
					fragment_unnamed_227 = asfloat(0u);
					fragment_unnamed_228 = asfloat(0u);
					fragment_unnamed_229 = asfloat(0u);
					fragment_unnamed_230 = asfloat(1065353216u);
				}
				uint fragment_unnamed_231 = fragment_unnamed_82 << 3u;
				uint fragment_unnamed_237 = fragment_unnamed_231 + 5u;
				uint fragment_unnamed_246 = fragment_unnamed_231 + 4u;
				uint fragment_unnamed_258 = fragment_unnamed_231 + 6u;
				uint fragment_unnamed_271 = fragment_unnamed_231 + 7u;
				uint fragment_unnamed_281 = fragment_unnamed_231 + 5u;
				uint fragment_unnamed_290 = fragment_unnamed_231 + 4u;
				uint fragment_unnamed_299 = fragment_unnamed_231 + 6u;
				float fragment_unnamed_311 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_258].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_246].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_237].x)) + fragment_uniform_buffer_2[fragment_unnamed_271].x) + mad(fragment_uniform_buffer_2[fragment_unnamed_299].x, fragment_unnamed_158, mad(fragment_uniform_buffer_2[fragment_unnamed_290].x, fragment_unnamed_156, fragment_unnamed_157 * fragment_uniform_buffer_2[fragment_unnamed_281].x)), 1.0f, 0.5f);
				float fragment_unnamed_313 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_258].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_246].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_237].y)) + fragment_uniform_buffer_2[fragment_unnamed_271].y) + mad(fragment_uniform_buffer_2[fragment_unnamed_299].y, fragment_unnamed_158, mad(fragment_uniform_buffer_2[fragment_unnamed_290].y, fragment_unnamed_156, fragment_unnamed_157 * fragment_uniform_buffer_2[fragment_unnamed_281].y)), -1.0f, 0.5f);
				float fragment_unnamed_314 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_258].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_246].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_237].z)) + fragment_uniform_buffer_2[fragment_unnamed_271].z) + mad(fragment_uniform_buffer_2[fragment_unnamed_299].z, fragment_unnamed_158, mad(fragment_uniform_buffer_2[fragment_unnamed_290].z, fragment_unnamed_156, fragment_unnamed_157 * fragment_uniform_buffer_2[fragment_unnamed_281].z)), 1.0f, 0.5f);
				discard_cond(asfloat((((((0.0f < (((-0.0f) - fragment_unnamed_314) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_313) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_311) + 1.0f)) ? 4294967295u : 0u))) & (((0.0f < fragment_unnamed_314) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_313) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_311) ? 4294967295u : 0u)))) != 0u) ? asuint(fragment_unnamed_230) : asuint(fragment_unnamed_230 + (-2.0f))) < 0.0f);
				float fragment_unnamed_386;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					uint fragment_unnamed_355 = fragment_unnamed_82 * 5u;
					float fragment_unnamed_387;
					if (0.0f < fragment_uniform_buffer_3[fragment_unnamed_355 + 3u].y)
					{
						float fragment_unnamed_369 = dot(float3(fragment_unnamed_227, fragment_unnamed_228, fragment_unnamed_229), float3(fragment_uniform_buffer_3[fragment_unnamed_355 + 2u].xyz));
						fragment_unnamed_387 = clamp(mad(fragment_unnamed_369 * mad(fragment_unnamed_369, fragment_unnamed_369, 1.25f), fragment_uniform_buffer_3[fragment_unnamed_355 + 3u].y, fragment_uniform_buffer_3[fragment_unnamed_355 + 3u].z), 0.0f, 1.0f);
					}
					else
					{
						fragment_unnamed_387 = asfloat(1065353216u);
					}
					fragment_unnamed_386 = fragment_unnamed_387;
				}
				else
				{
					fragment_unnamed_386 = asfloat(1065353216u);
				}
				uint fragment_unnamed_388 = fragment_unnamed_82 * 5u;
				float fragment_unnamed_402 = mad(fragment_unnamed_311, fragment_uniform_buffer_3[fragment_unnamed_388].w, fragment_uniform_buffer_3[fragment_unnamed_388 + 2u].w);
				float fragment_unnamed_411 = mad(fragment_unnamed_314, fragment_uniform_buffer_3[fragment_unnamed_388 + 1u].w, fragment_uniform_buffer_3[fragment_unnamed_388 + 3u].w);
				float4 fragment_unnamed_418 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_402, fragment_unnamed_411), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_446 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_unnamed_402, fragment_unnamed_411), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_452 = mad(fragment_unnamed_446.x * fragment_unnamed_446.w, 2.0f, -1.0f);
				float fragment_unnamed_453 = mad(fragment_unnamed_446.y, 2.0f, -1.0f);
				float fragment_unnamed_461 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_452, fragment_unnamed_453), float2(fragment_unnamed_452, fragment_unnamed_453)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_489 = (fragment_unnamed_386 * clamp(fragment_uniform_buffer_3[fragment_unnamed_388 + 3u].x, 0.0f, 1.0f)) * (clamp(((_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D, float2(fragment_unnamed_402, fragment_unnamed_411), fragment_uniform_buffer_0[86u].y).x + mad((-0.0f) - fragment_uniform_buffer_4[7u].x, 2.0f, 1.0f)) + ((-0.0f) - fragment_uniform_buffer_4[7u].w)) / (((-0.0f) - fragment_uniform_buffer_4[7u].w) + 1.0f), 0.0f, 1.0f) * (fragment_unnamed_418.w * fragment_uniform_buffer_4[3u].w));
				uint fragment_unnamed_490 = fragment_unnamed_388 + 1u;
				uint fragment_unnamed_507 = fragment_unnamed_388 + 2u;
				fragment_output_1.x = mad(mad(fragment_uniform_buffer_3[fragment_unnamed_507].x, fragment_unnamed_461, mad(fragment_uniform_buffer_3[fragment_unnamed_388].x, fragment_unnamed_452, fragment_unnamed_453 * fragment_uniform_buffer_3[fragment_unnamed_490].x)), 0.5f, 0.5f);
				fragment_output_1.y = mad(mad(fragment_uniform_buffer_3[fragment_unnamed_507].y, fragment_unnamed_461, mad(fragment_uniform_buffer_3[fragment_unnamed_388].y, fragment_unnamed_452, fragment_unnamed_453 * fragment_uniform_buffer_3[fragment_unnamed_490].y)), 0.5f, 0.5f);
				fragment_output_1.z = mad(mad(fragment_uniform_buffer_3[fragment_unnamed_507].z, fragment_unnamed_461, mad(fragment_uniform_buffer_3[fragment_unnamed_388].z, fragment_unnamed_452, fragment_unnamed_453 * fragment_uniform_buffer_3[fragment_unnamed_490].z)), 0.5f, 0.5f);
				fragment_output_0.x = fragment_unnamed_418.x * fragment_uniform_buffer_4[3u].x;
				fragment_output_0.y = fragment_unnamed_418.y * fragment_uniform_buffer_4[3u].y;
				fragment_output_0.z = fragment_unnamed_418.z * fragment_uniform_buffer_4[3u].z;
				fragment_output_0.w = fragment_unnamed_489;
				fragment_output_1.w = fragment_unnamed_489;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_unnamed_402, fragment_unnamed_411), fragment_uniform_buffer_0[86u].y).w;
				fragment_output_2.w = fragment_unnamed_489;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_1[0][1], fragment_uniform_buffer_1[0][2], fragment_uniform_buffer_1[0][3]);

				fragment_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_2[8] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_uniform_buffer_3[4] = float4(asfloat(DecalArray[0]._DecalLayerMaskFromDecal), fragment_uniform_buffer_3[4][1], fragment_uniform_buffer_3[4][2], fragment_uniform_buffer_3[4][3]);
				fragment_uniform_buffer_3[0] = float4(DecalArray[0]._NormalToWorld[0][0], DecalArray[0]._NormalToWorld[1][0], DecalArray[0]._NormalToWorld[2][0], DecalArray[0]._NormalToWorld[3][0]);
				fragment_uniform_buffer_3[1] = float4(DecalArray[0]._NormalToWorld[0][1], DecalArray[0]._NormalToWorld[1][1], DecalArray[0]._NormalToWorld[2][1], DecalArray[0]._NormalToWorld[3][1]);
				fragment_uniform_buffer_3[2] = float4(DecalArray[0]._NormalToWorld[0][2], DecalArray[0]._NormalToWorld[1][2], DecalArray[0]._NormalToWorld[2][2], DecalArray[0]._NormalToWorld[3][2]);
				fragment_uniform_buffer_3[3] = float4(DecalArray[0]._NormalToWorld[0][3], DecalArray[0]._NormalToWorld[1][3], DecalArray[0]._NormalToWorld[2][3], DecalArray[0]._NormalToWorld[3][3]);
				fragment_uniform_buffer_3[9] = float4(asfloat(DecalArray[1]._DecalLayerMaskFromDecal), fragment_uniform_buffer_3[9][1], fragment_uniform_buffer_3[9][2], fragment_uniform_buffer_3[9][3]);
				fragment_uniform_buffer_3[5] = float4(DecalArray[1]._NormalToWorld[0][0], DecalArray[1]._NormalToWorld[1][0], DecalArray[1]._NormalToWorld[2][0], DecalArray[1]._NormalToWorld[3][0]);
				fragment_uniform_buffer_3[6] = float4(DecalArray[1]._NormalToWorld[0][1], DecalArray[1]._NormalToWorld[1][1], DecalArray[1]._NormalToWorld[2][1], DecalArray[1]._NormalToWorld[3][1]);
				fragment_uniform_buffer_3[7] = float4(DecalArray[1]._NormalToWorld[0][2], DecalArray[1]._NormalToWorld[1][2], DecalArray[1]._NormalToWorld[2][2], DecalArray[1]._NormalToWorld[3][2]);
				fragment_uniform_buffer_3[8] = float4(DecalArray[1]._NormalToWorld[0][3], DecalArray[1]._NormalToWorld[1][3], DecalArray[1]._NormalToWorld[2][3], DecalArray[1]._NormalToWorld[3][3]);

				fragment_uniform_buffer_4[3] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_4[7] = float4(_Dissolve, fragment_uniform_buffer_4[7][1], fragment_uniform_buffer_4[7][2], fragment_uniform_buffer_4[7][3]);

				fragment_uniform_buffer_4[7] = float4(fragment_uniform_buffer_4[7][0], fragment_uniform_buffer_4[7][1], fragment_uniform_buffer_4[7][2], _Cutoff);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(INSTANCING_ON) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL)


			// Fallback Shader Code
			#ifndef ANY_SHADER_VARIANT_ACTIVE

			// https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
			float4x4 unity_MatrixMVP;

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
		Pass
		{
			Name "DBufferMesh"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DBufferMesh" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Opaque" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "DecalSubTarget" }
			Blend 0 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			ColorMask [_DecalColorMask0]
			Blend 1 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			ColorMask [_DecalColorMask1] 1
			Blend 2 SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
			ColorMask [_DecalColorMask2] 2
			Blend 3 Zero OneMinusSrcColor
			ColorMask [_DecalColorMask3] 3
			ZWrite Off
			Stencil
			{
				Ref [_DecalStencilRef]
				WriteMask [_DecalStencilWriteMask]
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
			GpuProgramID 113216

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature DECALS_3RT
			#pragma multi_compile_instancing
			#pragma shader_feature _MATERIAL_AFFECTS_ALBEDO
			#pragma shader_feature _MATERIAL_AFFECTS_MASKMAP
			#pragma shader_feature _MATERIAL_AFFECTS_NORMAL


			#if defined(DECALS_3RT) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewMatrix;
			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 unity_OrthoParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;

			static float4 vertex_uniform_buffer_0[61];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[9];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;
			static uint vertex_output_8;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float4 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
				float3 vertex_output_7 : INTERP6; // INTERP_6
				uint vertex_output_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_93 = asfloat(1065353216u);
				float vertex_unnamed_95 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_93));
				bool vertex_unnamed_103 = vertex_uniform_buffer_0[60u].w == 0.0f;
				float vertex_unnamed_109 = vertex_unnamed_103 ? ((-0.0f) - vertex_unnamed_95) : vertex_uniform_buffer_0[0u].z;
				float vertex_unnamed_125 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_93));
				float vertex_unnamed_132 = vertex_unnamed_103 ? ((-0.0f) - vertex_unnamed_125) : vertex_uniform_buffer_0[1u].z;
				float vertex_unnamed_148 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_93));
				float vertex_unnamed_155 = vertex_unnamed_103 ? ((-0.0f) - vertex_unnamed_148) : vertex_uniform_buffer_0[2u].z;
				float vertex_unnamed_160 = rsqrt(dot(float3(vertex_unnamed_109, vertex_unnamed_132, vertex_unnamed_155), float3(vertex_unnamed_109, vertex_unnamed_132, vertex_unnamed_155)));
				uint vertex_unnamed_178 = (vertex_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u;
				float vertex_unnamed_188 = vertex_unnamed_95 + asfloat(asuint((vertex_unnamed_160 * vertex_unnamed_109) * vertex_uniform_buffer_2[8u].w) & vertex_unnamed_178);
				float vertex_unnamed_189 = vertex_unnamed_125 + asfloat(asuint((vertex_unnamed_160 * vertex_unnamed_132) * vertex_uniform_buffer_2[8u].w) & vertex_unnamed_178);
				float vertex_unnamed_190 = vertex_unnamed_148 + asfloat(asuint((vertex_unnamed_160 * vertex_unnamed_155) * vertex_uniform_buffer_2[8u].w) & vertex_unnamed_178);
				vertex_output_6.x = vertex_unnamed_188;
				vertex_output_6.y = vertex_unnamed_189;
				vertex_output_6.z = vertex_unnamed_190;
				float vertex_unnamed_237 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_190, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_188, vertex_unnamed_189 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_2[8u].y == 0.0f) ? (vertex_unnamed_237 + ((-0.0f) - vertex_uniform_buffer_2[8u].z)) : vertex_unnamed_237;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_190, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_188, vertex_unnamed_189 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_190, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_188, vertex_unnamed_189 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_190, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_188, vertex_unnamed_189 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_276 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_277 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_278 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_284 = rsqrt(max(dot(float3(vertex_unnamed_276, vertex_unnamed_277, vertex_unnamed_278), float3(vertex_unnamed_276, vertex_unnamed_277, vertex_unnamed_278)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_284 * vertex_unnamed_276;
				vertex_output_1.y = vertex_unnamed_284 * vertex_unnamed_277;
				vertex_output_1.z = vertex_unnamed_284 * vertex_unnamed_278;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				vertex_output_3.x = vertex_input_4.x;
				vertex_output_3.y = vertex_input_4.y;
				vertex_output_3.z = vertex_input_4.z;
				vertex_output_3.w = vertex_input_4.w;
				vertex_output_4.x = vertex_input_5.x;
				vertex_output_4.y = vertex_input_5.y;
				vertex_output_4.z = vertex_input_5.z;
				vertex_output_4.w = vertex_input_5.w;
				vertex_output_5.x = vertex_input_6.x;
				vertex_output_5.y = vertex_input_6.y;
				vertex_output_5.z = vertex_input_6.z;
				vertex_output_5.w = vertex_input_6.w;
				float vertex_unnamed_354 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_369 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_384 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_391 = rsqrt(max(dot(float3(vertex_unnamed_354, vertex_unnamed_369, vertex_unnamed_384), float3(vertex_unnamed_354, vertex_unnamed_369, vertex_unnamed_384)), 1.1754943508222875079687365372222e-38f));
				vertex_output_7.x = vertex_unnamed_391 * vertex_unnamed_354;
				vertex_output_7.y = vertex_unnamed_391 * vertex_unnamed_369;
				vertex_output_7.z = vertex_unnamed_391 * vertex_unnamed_384;
				vertex_output_8 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				vertex_uniform_buffer_0[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				vertex_uniform_buffer_0[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				vertex_uniform_buffer_0[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[60] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[8] = float4(vertex_uniform_buffer_2[8][0], _DecalMeshBiasType, vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);

				vertex_uniform_buffer_2[8] = float4(vertex_uniform_buffer_2[8][0], vertex_uniform_buffer_2[8][1], _DecalMeshDepthBias, vertex_uniform_buffer_2[8][3]);

				vertex_uniform_buffer_2[8] = float4(vertex_uniform_buffer_2[8][0], vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], _DecalMeshViewBias);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + 0u);
				gl_BaseInstanceARB = 0u;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
				uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			void frag_main()
			{
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				fragment_output_1.x = 0.5f;
				fragment_output_1.y = 0.5f;
				fragment_output_1.z = 0.5f;
				fragment_output_1.w = 0.0f;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = 0.0f;
				fragment_output_2.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)


			#if defined(DECALS_3RT) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewMatrix;
			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 unity_OrthoParams;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;

			static float4 vertex_uniform_buffer_0[61];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[9];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;
			static uint vertex_output_8;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float4 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
				float3 vertex_output_7 : INTERP6; // INTERP_6
				uint vertex_output_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_93 = asfloat(1065353216u);
				float vertex_unnamed_95 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_93));
				bool vertex_unnamed_103 = vertex_uniform_buffer_0[60u].w == 0.0f;
				float vertex_unnamed_109 = vertex_unnamed_103 ? ((-0.0f) - vertex_unnamed_95) : vertex_uniform_buffer_0[0u].z;
				float vertex_unnamed_125 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_93));
				float vertex_unnamed_132 = vertex_unnamed_103 ? ((-0.0f) - vertex_unnamed_125) : vertex_uniform_buffer_0[1u].z;
				float vertex_unnamed_148 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_93));
				float vertex_unnamed_155 = vertex_unnamed_103 ? ((-0.0f) - vertex_unnamed_148) : vertex_uniform_buffer_0[2u].z;
				float vertex_unnamed_160 = rsqrt(dot(float3(vertex_unnamed_109, vertex_unnamed_132, vertex_unnamed_155), float3(vertex_unnamed_109, vertex_unnamed_132, vertex_unnamed_155)));
				uint vertex_unnamed_178 = (vertex_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u;
				float vertex_unnamed_188 = vertex_unnamed_95 + asfloat(asuint((vertex_unnamed_160 * vertex_unnamed_109) * vertex_uniform_buffer_2[8u].w) & vertex_unnamed_178);
				float vertex_unnamed_189 = vertex_unnamed_125 + asfloat(asuint((vertex_unnamed_160 * vertex_unnamed_132) * vertex_uniform_buffer_2[8u].w) & vertex_unnamed_178);
				float vertex_unnamed_190 = vertex_unnamed_148 + asfloat(asuint((vertex_unnamed_160 * vertex_unnamed_155) * vertex_uniform_buffer_2[8u].w) & vertex_unnamed_178);
				vertex_output_6.x = vertex_unnamed_188;
				vertex_output_6.y = vertex_unnamed_189;
				vertex_output_6.z = vertex_unnamed_190;
				float vertex_unnamed_237 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_190, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_188, vertex_unnamed_189 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_2[8u].y == 0.0f) ? (vertex_unnamed_237 + ((-0.0f) - vertex_uniform_buffer_2[8u].z)) : vertex_unnamed_237;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_190, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_188, vertex_unnamed_189 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_190, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_188, vertex_unnamed_189 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_190, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_188, vertex_unnamed_189 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_276 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_277 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_278 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_284 = rsqrt(max(dot(float3(vertex_unnamed_276, vertex_unnamed_277, vertex_unnamed_278), float3(vertex_unnamed_276, vertex_unnamed_277, vertex_unnamed_278)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_284 * vertex_unnamed_276;
				vertex_output_1.y = vertex_unnamed_284 * vertex_unnamed_277;
				vertex_output_1.z = vertex_unnamed_284 * vertex_unnamed_278;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				vertex_output_3.x = vertex_input_4.x;
				vertex_output_3.y = vertex_input_4.y;
				vertex_output_3.z = vertex_input_4.z;
				vertex_output_3.w = vertex_input_4.w;
				vertex_output_4.x = vertex_input_5.x;
				vertex_output_4.y = vertex_input_5.y;
				vertex_output_4.z = vertex_input_5.z;
				vertex_output_4.w = vertex_input_5.w;
				vertex_output_5.x = vertex_input_6.x;
				vertex_output_5.y = vertex_input_6.y;
				vertex_output_5.z = vertex_input_6.z;
				vertex_output_5.w = vertex_input_6.w;
				float vertex_unnamed_354 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_369 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_384 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_391 = rsqrt(max(dot(float3(vertex_unnamed_354, vertex_unnamed_369, vertex_unnamed_384), float3(vertex_unnamed_354, vertex_unnamed_369, vertex_unnamed_384)), 1.1754943508222875079687365372222e-38f));
				vertex_output_7.x = vertex_unnamed_391 * vertex_unnamed_354;
				vertex_output_7.y = vertex_unnamed_391 * vertex_unnamed_369;
				vertex_output_7.z = vertex_unnamed_391 * vertex_unnamed_384;
				vertex_output_8 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				vertex_uniform_buffer_0[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				vertex_uniform_buffer_0[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				vertex_uniform_buffer_0[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[60] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[8] = float4(vertex_uniform_buffer_2[8][0], _DecalMeshBiasType, vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);

				vertex_uniform_buffer_2[8] = float4(vertex_uniform_buffer_2[8][0], vertex_uniform_buffer_2[8][1], _DecalMeshDepthBias, vertex_uniform_buffer_2[8][3]);

				vertex_uniform_buffer_2[8] = float4(vertex_uniform_buffer_2[8][0], vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], _DecalMeshViewBias);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + 0u);
				gl_BaseInstanceARB = 0u;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}


			float _GlobalMipBias;
			float4 unity_WorldTransformParams;
			float4 _BaseColor;
			float _Dissolve;
			float _Cutoff;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			static float4 fragment_uniform_buffer_2[8];
			Texture2D<float4> _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			SamplerState sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
				uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			void frag_main()
			{
				float4 fragment_unnamed_110 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_127 = clamp(((_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x + mad((-0.0f) - fragment_uniform_buffer_2[7u].x, 2.0f, 1.0f)) + ((-0.0f) - fragment_uniform_buffer_2[7u].w)) / (((-0.0f) - fragment_uniform_buffer_2[7u].w) + 1.0f), 0.0f, 1.0f) * (fragment_unnamed_110.w * fragment_uniform_buffer_2[3u].w);
				fragment_output_0.x = fragment_unnamed_110.x * fragment_uniform_buffer_2[3u].x;
				fragment_output_0.y = fragment_unnamed_110.y * fragment_uniform_buffer_2[3u].y;
				fragment_output_0.z = fragment_unnamed_110.z * fragment_uniform_buffer_2[3u].z;
				fragment_output_0.w = fragment_unnamed_127;
				float fragment_unnamed_149 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_204 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float4 fragment_unnamed_216 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_222 = mad(fragment_unnamed_216.x * fragment_unnamed_216.w, 2.0f, -1.0f);
				float fragment_unnamed_224 = mad(fragment_unnamed_216.y, 2.0f, -1.0f);
				float fragment_unnamed_256 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_222, fragment_unnamed_224), float2(fragment_unnamed_222, fragment_unnamed_224)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_258 = mad(fragment_unnamed_256, fragment_unnamed_204 * fragment_input_7.x, mad(fragment_unnamed_222, fragment_unnamed_204 * fragment_input_1.x, ((fragment_unnamed_149 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z))) * fragment_unnamed_204) * fragment_unnamed_224));
				float fragment_unnamed_259 = mad(fragment_unnamed_256, fragment_unnamed_204 * fragment_input_7.y, mad(fragment_unnamed_222, fragment_unnamed_204 * fragment_input_1.y, ((fragment_unnamed_149 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x))) * fragment_unnamed_204) * fragment_unnamed_224));
				float fragment_unnamed_260 = mad(fragment_unnamed_256, fragment_unnamed_204 * fragment_input_7.z, mad(fragment_unnamed_222, fragment_unnamed_204 * fragment_input_1.z, ((fragment_unnamed_149 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y))) * fragment_unnamed_204) * fragment_unnamed_224));
				float fragment_unnamed_264 = rsqrt(dot(float3(fragment_unnamed_258, fragment_unnamed_259, fragment_unnamed_260), float3(fragment_unnamed_258, fragment_unnamed_259, fragment_unnamed_260)));
				fragment_output_1.x = mad(fragment_unnamed_258 * fragment_unnamed_264, 0.5f, 0.5f);
				fragment_output_1.y = mad(fragment_unnamed_259 * fragment_unnamed_264, 0.5f, 0.5f);
				fragment_output_1.z = mad(fragment_unnamed_260 * fragment_unnamed_264, 0.5f, 0.5f);
				fragment_output_1.w = fragment_unnamed_127;
				fragment_output_2.w = fragment_unnamed_127;
				fragment_output_2.z = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).w;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[3] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_2[7] = float4(_Dissolve, fragment_uniform_buffer_2[7][1], fragment_uniform_buffer_2[7][2], fragment_uniform_buffer_2[7][3]);

				fragment_uniform_buffer_2[7] = float4(fragment_uniform_buffer_2[7][0], fragment_uniform_buffer_2[7][1], fragment_uniform_buffer_2[7][2], _Cutoff);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)


			#if defined(DECALS_3RT) && defined(INSTANCING_ON) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewMatrix;
			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 unity_OrthoParams;
			int unity_BaseInstanceID;
			struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;

			static float4 vertex_uniform_buffer_0[61];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[16];
			static float4 vertex_uniform_buffer_3[9];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;
			static uint vertex_output_8;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float4 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
				float3 vertex_output_7 : INTERP6; // INTERP_6
				uint vertex_output_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_63 = (uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x;
				float vertex_unnamed_201;
				float vertex_unnamed_202;
				float vertex_unnamed_203;
				if (vertex_uniform_buffer_3[8u].y == 1.0f)
				{
					uint vertex_unnamed_73 = vertex_unnamed_63 << 3u;
					uint vertex_unnamed_85 = vertex_unnamed_73 + 3u;
					float vertex_unnamed_119 = asfloat(1065353216u);
					bool vertex_unnamed_168 = vertex_uniform_buffer_0[60u].w == 0.0f;
					float vertex_unnamed_173 = vertex_unnamed_168 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_85].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119))) : vertex_uniform_buffer_0[0u].z;
					float vertex_unnamed_178 = vertex_unnamed_168 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_85].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119))) : vertex_uniform_buffer_0[1u].z;
					float vertex_unnamed_183 = vertex_unnamed_168 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_85].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119))) : vertex_uniform_buffer_0[2u].z;
					float vertex_unnamed_188 = rsqrt(dot(float3(vertex_unnamed_173, vertex_unnamed_178, vertex_unnamed_183), float3(vertex_unnamed_173, vertex_unnamed_178, vertex_unnamed_183)));
					vertex_unnamed_201 = (vertex_unnamed_188 * vertex_unnamed_183) * vertex_uniform_buffer_3[8u].w;
					vertex_unnamed_202 = (vertex_unnamed_188 * vertex_unnamed_178) * vertex_uniform_buffer_3[8u].w;
					vertex_unnamed_203 = (vertex_unnamed_188 * vertex_unnamed_173) * vertex_uniform_buffer_3[8u].w;
				}
				else
				{
					vertex_unnamed_201 = asfloat(0u);
					vertex_unnamed_202 = asfloat(0u);
					vertex_unnamed_203 = asfloat(0u);
				}
				uint vertex_unnamed_204 = vertex_unnamed_63 << 3u;
				uint vertex_unnamed_213 = vertex_unnamed_204 + 3u;
				float vertex_unnamed_245 = asfloat(1065353216u);
				float vertex_unnamed_289 = vertex_unnamed_203 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_213].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_245));
				float vertex_unnamed_290 = vertex_unnamed_202 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_213].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_245));
				float vertex_unnamed_291 = vertex_unnamed_201 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_213].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_245));
				float vertex_unnamed_305 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_204 + 4u].xyz));
				float vertex_unnamed_321 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_204 + 5u].xyz));
				float vertex_unnamed_337 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_204 + 6u].xyz));
				float vertex_unnamed_345 = rsqrt(max(dot(float3(vertex_unnamed_305, vertex_unnamed_321, vertex_unnamed_337), float3(vertex_unnamed_305, vertex_unnamed_321, vertex_unnamed_337)), 1.1754943508222875079687365372222e-38f));
				vertex_output_7.x = vertex_unnamed_345 * vertex_unnamed_305;
				vertex_output_7.y = vertex_unnamed_345 * vertex_unnamed_321;
				vertex_output_7.z = vertex_unnamed_345 * vertex_unnamed_337;
				uint vertex_unnamed_355 = vertex_unnamed_204 + 1u;
				uint vertex_unnamed_374 = vertex_unnamed_204 + 2u;
				float vertex_unnamed_382 = mad(vertex_uniform_buffer_2[vertex_unnamed_374].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_204].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_355].x));
				float vertex_unnamed_383 = mad(vertex_uniform_buffer_2[vertex_unnamed_374].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_204].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_355].y));
				float vertex_unnamed_384 = mad(vertex_uniform_buffer_2[vertex_unnamed_374].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_204].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_355].z));
				float vertex_unnamed_389 = rsqrt(max(dot(float3(vertex_unnamed_382, vertex_unnamed_383, vertex_unnamed_384), float3(vertex_unnamed_382, vertex_unnamed_383, vertex_unnamed_384)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_382 * vertex_unnamed_389;
				vertex_output_1.y = vertex_unnamed_383 * vertex_unnamed_389;
				vertex_output_1.z = vertex_unnamed_384 * vertex_unnamed_389;
				float vertex_unnamed_438 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_291, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_289, vertex_unnamed_290 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_3[8u].y == 0.0f) ? (vertex_unnamed_438 + ((-0.0f) - vertex_uniform_buffer_3[8u].z)) : vertex_unnamed_438;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_291, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_289, vertex_unnamed_290 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_291, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_289, vertex_unnamed_290 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_291, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_289, vertex_unnamed_290 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				vertex_output_3.x = vertex_input_4.x;
				vertex_output_3.y = vertex_input_4.y;
				vertex_output_3.z = vertex_input_4.z;
				vertex_output_3.w = vertex_input_4.w;
				vertex_output_4.x = vertex_input_5.x;
				vertex_output_4.y = vertex_input_5.y;
				vertex_output_4.z = vertex_input_5.z;
				vertex_output_4.w = vertex_input_5.w;
				vertex_output_5.x = vertex_input_6.x;
				vertex_output_5.y = vertex_input_6.y;
				vertex_output_5.z = vertex_input_6.z;
				vertex_output_5.w = vertex_input_6.w;
				vertex_output_6.x = vertex_unnamed_289;
				vertex_output_6.y = vertex_unnamed_290;
				vertex_output_6.z = vertex_unnamed_291;
				vertex_output_8 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				vertex_uniform_buffer_0[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				vertex_uniform_buffer_0[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				vertex_uniform_buffer_0[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[60] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_3[8] = float4(vertex_uniform_buffer_3[8][0], _DecalMeshBiasType, vertex_uniform_buffer_3[8][2], vertex_uniform_buffer_3[8][3]);

				vertex_uniform_buffer_3[8] = float4(vertex_uniform_buffer_3[8][0], vertex_uniform_buffer_3[8][1], _DecalMeshDepthBias, vertex_uniform_buffer_3[8][3]);

				vertex_uniform_buffer_3[8] = float4(vertex_uniform_buffer_3[8][0], vertex_uniform_buffer_3[8][1], vertex_uniform_buffer_3[8][2], _DecalMeshViewBias);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + 0u);
				gl_BaseInstanceARB = 0u;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
				uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			void frag_main()
			{
				fragment_output_0.x = 0.0f;
				fragment_output_0.y = 0.0f;
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				fragment_output_1.x = 0.5f;
				fragment_output_1.y = 0.5f;
				fragment_output_1.z = 0.5f;
				fragment_output_1.w = 0.0f;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = 0.0f;
				fragment_output_2.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(INSTANCING_ON) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL)


			#if defined(DECALS_3RT) && defined(INSTANCING_ON) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewMatrix;
			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 unity_OrthoParams;
			int unity_BaseInstanceID;
			struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;

			static float4 vertex_uniform_buffer_0[61];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[16];
			static float4 vertex_uniform_buffer_3[9];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;
			static uint vertex_output_8;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float4 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
				float3 vertex_output_7 : INTERP6; // INTERP_6
				uint vertex_output_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_63 = (uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x;
				float vertex_unnamed_201;
				float vertex_unnamed_202;
				float vertex_unnamed_203;
				if (vertex_uniform_buffer_3[8u].y == 1.0f)
				{
					uint vertex_unnamed_73 = vertex_unnamed_63 << 3u;
					uint vertex_unnamed_85 = vertex_unnamed_73 + 3u;
					float vertex_unnamed_119 = asfloat(1065353216u);
					bool vertex_unnamed_168 = vertex_uniform_buffer_0[60u].w == 0.0f;
					float vertex_unnamed_173 = vertex_unnamed_168 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_85].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119))) : vertex_uniform_buffer_0[0u].z;
					float vertex_unnamed_178 = vertex_unnamed_168 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_85].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119))) : vertex_uniform_buffer_0[1u].z;
					float vertex_unnamed_183 = vertex_unnamed_168 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_73 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_85].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119))) : vertex_uniform_buffer_0[2u].z;
					float vertex_unnamed_188 = rsqrt(dot(float3(vertex_unnamed_173, vertex_unnamed_178, vertex_unnamed_183), float3(vertex_unnamed_173, vertex_unnamed_178, vertex_unnamed_183)));
					vertex_unnamed_201 = (vertex_unnamed_188 * vertex_unnamed_183) * vertex_uniform_buffer_3[8u].w;
					vertex_unnamed_202 = (vertex_unnamed_188 * vertex_unnamed_178) * vertex_uniform_buffer_3[8u].w;
					vertex_unnamed_203 = (vertex_unnamed_188 * vertex_unnamed_173) * vertex_uniform_buffer_3[8u].w;
				}
				else
				{
					vertex_unnamed_201 = asfloat(0u);
					vertex_unnamed_202 = asfloat(0u);
					vertex_unnamed_203 = asfloat(0u);
				}
				uint vertex_unnamed_204 = vertex_unnamed_63 << 3u;
				uint vertex_unnamed_213 = vertex_unnamed_204 + 3u;
				float vertex_unnamed_245 = asfloat(1065353216u);
				float vertex_unnamed_289 = vertex_unnamed_203 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_213].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_245));
				float vertex_unnamed_290 = vertex_unnamed_202 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_213].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_245));
				float vertex_unnamed_291 = vertex_unnamed_201 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_204 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_213].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_245));
				float vertex_unnamed_305 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_204 + 4u].xyz));
				float vertex_unnamed_321 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_204 + 5u].xyz));
				float vertex_unnamed_337 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_204 + 6u].xyz));
				float vertex_unnamed_345 = rsqrt(max(dot(float3(vertex_unnamed_305, vertex_unnamed_321, vertex_unnamed_337), float3(vertex_unnamed_305, vertex_unnamed_321, vertex_unnamed_337)), 1.1754943508222875079687365372222e-38f));
				vertex_output_7.x = vertex_unnamed_345 * vertex_unnamed_305;
				vertex_output_7.y = vertex_unnamed_345 * vertex_unnamed_321;
				vertex_output_7.z = vertex_unnamed_345 * vertex_unnamed_337;
				uint vertex_unnamed_355 = vertex_unnamed_204 + 1u;
				uint vertex_unnamed_374 = vertex_unnamed_204 + 2u;
				float vertex_unnamed_382 = mad(vertex_uniform_buffer_2[vertex_unnamed_374].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_204].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_355].x));
				float vertex_unnamed_383 = mad(vertex_uniform_buffer_2[vertex_unnamed_374].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_204].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_355].y));
				float vertex_unnamed_384 = mad(vertex_uniform_buffer_2[vertex_unnamed_374].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_204].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_355].z));
				float vertex_unnamed_389 = rsqrt(max(dot(float3(vertex_unnamed_382, vertex_unnamed_383, vertex_unnamed_384), float3(vertex_unnamed_382, vertex_unnamed_383, vertex_unnamed_384)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_382 * vertex_unnamed_389;
				vertex_output_1.y = vertex_unnamed_383 * vertex_unnamed_389;
				vertex_output_1.z = vertex_unnamed_384 * vertex_unnamed_389;
				float vertex_unnamed_438 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_291, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_289, vertex_unnamed_290 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_3[8u].y == 0.0f) ? (vertex_unnamed_438 + ((-0.0f) - vertex_uniform_buffer_3[8u].z)) : vertex_unnamed_438;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_291, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_289, vertex_unnamed_290 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_291, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_289, vertex_unnamed_290 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_291, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_289, vertex_unnamed_290 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				vertex_output_3.x = vertex_input_4.x;
				vertex_output_3.y = vertex_input_4.y;
				vertex_output_3.z = vertex_input_4.z;
				vertex_output_3.w = vertex_input_4.w;
				vertex_output_4.x = vertex_input_5.x;
				vertex_output_4.y = vertex_input_5.y;
				vertex_output_4.z = vertex_input_5.z;
				vertex_output_4.w = vertex_input_5.w;
				vertex_output_5.x = vertex_input_6.x;
				vertex_output_5.y = vertex_input_6.y;
				vertex_output_5.z = vertex_input_6.z;
				vertex_output_5.w = vertex_input_6.w;
				vertex_output_6.x = vertex_unnamed_289;
				vertex_output_6.y = vertex_unnamed_290;
				vertex_output_6.z = vertex_unnamed_291;
				vertex_output_8 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				vertex_uniform_buffer_0[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				vertex_uniform_buffer_0[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				vertex_uniform_buffer_0[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[60] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_3[8] = float4(vertex_uniform_buffer_3[8][0], _DecalMeshBiasType, vertex_uniform_buffer_3[8][2], vertex_uniform_buffer_3[8][3]);

				vertex_uniform_buffer_3[8] = float4(vertex_uniform_buffer_3[8][0], vertex_uniform_buffer_3[8][1], _DecalMeshDepthBias, vertex_uniform_buffer_3[8][3]);

				vertex_uniform_buffer_3[8] = float4(vertex_uniform_buffer_3[8][0], vertex_uniform_buffer_3[8][1], vertex_uniform_buffer_3[8][2], _DecalMeshViewBias);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + 0u);
				gl_BaseInstanceARB = 0u;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}


			float _GlobalMipBias;
			float4 unity_WorldTransformParams;
			float4 _BaseColor;
			float _Dissolve;
			float _Cutoff;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			static float4 fragment_uniform_buffer_2[8];
			Texture2D<float4> _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			SamplerState sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
				uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			void frag_main()
			{
				float4 fragment_unnamed_110 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_127 = clamp(((_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x + mad((-0.0f) - fragment_uniform_buffer_2[7u].x, 2.0f, 1.0f)) + ((-0.0f) - fragment_uniform_buffer_2[7u].w)) / (((-0.0f) - fragment_uniform_buffer_2[7u].w) + 1.0f), 0.0f, 1.0f) * (fragment_unnamed_110.w * fragment_uniform_buffer_2[3u].w);
				fragment_output_0.x = fragment_unnamed_110.x * fragment_uniform_buffer_2[3u].x;
				fragment_output_0.y = fragment_unnamed_110.y * fragment_uniform_buffer_2[3u].y;
				fragment_output_0.z = fragment_unnamed_110.z * fragment_uniform_buffer_2[3u].z;
				fragment_output_0.w = fragment_unnamed_127;
				float fragment_unnamed_149 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_204 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float4 fragment_unnamed_216 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_222 = mad(fragment_unnamed_216.x * fragment_unnamed_216.w, 2.0f, -1.0f);
				float fragment_unnamed_224 = mad(fragment_unnamed_216.y, 2.0f, -1.0f);
				float fragment_unnamed_256 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_222, fragment_unnamed_224), float2(fragment_unnamed_222, fragment_unnamed_224)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_258 = mad(fragment_unnamed_256, fragment_unnamed_204 * fragment_input_7.x, mad(fragment_unnamed_222, fragment_unnamed_204 * fragment_input_1.x, ((fragment_unnamed_149 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z))) * fragment_unnamed_204) * fragment_unnamed_224));
				float fragment_unnamed_259 = mad(fragment_unnamed_256, fragment_unnamed_204 * fragment_input_7.y, mad(fragment_unnamed_222, fragment_unnamed_204 * fragment_input_1.y, ((fragment_unnamed_149 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x))) * fragment_unnamed_204) * fragment_unnamed_224));
				float fragment_unnamed_260 = mad(fragment_unnamed_256, fragment_unnamed_204 * fragment_input_7.z, mad(fragment_unnamed_222, fragment_unnamed_204 * fragment_input_1.z, ((fragment_unnamed_149 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y))) * fragment_unnamed_204) * fragment_unnamed_224));
				float fragment_unnamed_264 = rsqrt(dot(float3(fragment_unnamed_258, fragment_unnamed_259, fragment_unnamed_260), float3(fragment_unnamed_258, fragment_unnamed_259, fragment_unnamed_260)));
				fragment_output_1.x = mad(fragment_unnamed_258 * fragment_unnamed_264, 0.5f, 0.5f);
				fragment_output_1.y = mad(fragment_unnamed_259 * fragment_unnamed_264, 0.5f, 0.5f);
				fragment_output_1.z = mad(fragment_unnamed_260 * fragment_unnamed_264, 0.5f, 0.5f);
				fragment_output_1.w = fragment_unnamed_127;
				fragment_output_2.w = fragment_unnamed_127;
				fragment_output_2.z = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).w;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[3] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_2[7] = float4(_Dissolve, fragment_uniform_buffer_2[7][1], fragment_uniform_buffer_2[7][2], fragment_uniform_buffer_2[7][3]);

				fragment_uniform_buffer_2[7] = float4(fragment_uniform_buffer_2[7][0], fragment_uniform_buffer_2[7][1], fragment_uniform_buffer_2[7][2], _Cutoff);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(INSTANCING_ON) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL)


			// Fallback Shader Code
			#ifndef ANY_SHADER_VARIANT_ACTIVE

			// https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
			float4x4 unity_MatrixMVP;

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
		Pass
		{
			Name "AtlasProjector"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "AtlasProjector" "QUEUE" = "Geometry+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "Opaque" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "DecalSubTarget" }
			ZTest Always
			ZWrite Off
			Cull Off
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 149602

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature DECALS_3RT
			#pragma multi_compile_instancing
			#pragma shader_feature _MATERIAL_AFFECTS_ALBEDO
			#pragma shader_feature _MATERIAL_AFFECTS_MASKMAP
			#pragma shader_feature _MATERIAL_AFFECTS_NORMAL


			#if defined(DECALS_3RT) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _DiffuseScaleBias;
			float4 _NormalScaleBias;
			float4 _MaskScaleBias;
			float4 _TextureTypes;

			static float4 vertex_uniform_buffer_0[4];
			static const float vertex_unnamed_26[16] = { 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };

			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			static float2 vertex_output_1;
			static uint vertex_output_2;

			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				uint vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			uint spvBitfieldUExtract(uint Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint2 spvBitfieldUExtract(uint2 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint3 spvBitfieldUExtract(uint3 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint4 spvBitfieldUExtract(uint4 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			int spvBitfieldSExtract(int Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int2 spvBitfieldSExtract(int2 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int2 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int3 spvBitfieldSExtract(int3 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int3 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int4 spvBitfieldSExtract(int4 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int4 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			void vert_main()
			{
				uint vertex_unnamed_36 = 1u & 31u;
				uint vertex_unnamed_41 = spvBitfieldUExtract(uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_36, min((1u & 31u), (32u - vertex_unnamed_36)));
				uint vertex_unnamed_45 = (uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 1u;
				float vertex_unnamed_51 = float(vertex_unnamed_41);
				uint vertex_unnamed_56 = (uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) >> 2u;
				uint vertex_unnamed_87 = uint(dot(float4(vertex_uniform_buffer_0[3u]), float4(vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 0u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 1u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 2u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 3u])));
				uint vertex_unnamed_110;
				uint vertex_unnamed_111;
				uint vertex_unnamed_112;
				uint vertex_unnamed_113;
				switch (vertex_unnamed_87)
				{
					case 0u:
					{
						uint4 vertex_unnamed_91 = asuint(vertex_uniform_buffer_0[0u]);
						vertex_unnamed_110 = vertex_unnamed_91.x;
						vertex_unnamed_111 = vertex_unnamed_91.y;
						vertex_unnamed_112 = vertex_unnamed_91.z;
						vertex_unnamed_113 = vertex_unnamed_91.w;
						break;
					}
					case 1u:
					{
						uint4 vertex_unnamed_98 = asuint(vertex_uniform_buffer_0[1u]);
						vertex_unnamed_110 = vertex_unnamed_98.x;
						vertex_unnamed_111 = vertex_unnamed_98.y;
						vertex_unnamed_112 = vertex_unnamed_98.z;
						vertex_unnamed_113 = vertex_unnamed_98.w;
						break;
					}
					case 2u:
					{
						uint4 vertex_unnamed_105 = asuint(vertex_uniform_buffer_0[2u]);
						vertex_unnamed_110 = vertex_unnamed_105.x;
						vertex_unnamed_111 = vertex_unnamed_105.y;
						vertex_unnamed_112 = vertex_unnamed_105.z;
						vertex_unnamed_113 = vertex_unnamed_105.w;
						break;
					}
					default:
					{
						vertex_unnamed_110 = 0u;
						vertex_unnamed_111 = 0u;
						vertex_unnamed_112 = 0u;
						vertex_unnamed_113 = 0u;
						break;
					}
				}
				gl_Position.x = mad(mad(vertex_unnamed_51, asfloat(vertex_unnamed_110), asfloat(vertex_unnamed_112)), 2.0f, -1.0f);
				gl_Position.y = mad(mad(float((((-vertex_unnamed_45) + (-vertex_unnamed_41)) + 1u) & 1u), asfloat(vertex_unnamed_111), asfloat(vertex_unnamed_113)), -2.0f, 1.0f);
				gl_Position.z = mad(asfloat(1065353216u), 1.0f, 0.0f);
				gl_Position.w = mad(asfloat(1065353216u), 1.0f, 0.0f);
				vertex_output_1.x = vertex_unnamed_51;
				vertex_output_1.y = ((-0.0f) - float((vertex_unnamed_45 + vertex_unnamed_41) & 1u)) + 1.0f;
				vertex_output_2 = vertex_unnamed_87;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_DiffuseScaleBias[0], _DiffuseScaleBias[1], _DiffuseScaleBias[2], _DiffuseScaleBias[3]);

				vertex_uniform_buffer_0[1] = float4(_NormalScaleBias[0], _NormalScaleBias[1], _NormalScaleBias[2], _NormalScaleBias[3]);

				vertex_uniform_buffer_0[2] = float4(_MaskScaleBias[0], _MaskScaleBias[1], _MaskScaleBias[2], _MaskScaleBias[3]);

				vertex_uniform_buffer_0[3] = float4(_TextureTypes[0], _TextureTypes[1], _TextureTypes[2], _TextureTypes[3]);

				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			float _GlobalMipBias;
			float4 _BaseColor;
			float _Dissolve;
			float _Cutoff;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[8];
			Texture2D<float4> _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			SamplerState sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;

			static float2 fragment_input_1;
			static uint fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				nointerpolation uint fragment_input_2 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_61 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_96 = _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_113 = (fragment_unnamed_61.w * fragment_uniform_buffer_1[3u].w) * clamp(((fragment_unnamed_96.x + mad((-0.0f) - fragment_uniform_buffer_1[7u].x, 2.0f, 1.0f)) + ((-0.0f) - fragment_uniform_buffer_1[7u].w)) / (((-0.0f) - fragment_uniform_buffer_1[7u].w) + 1.0f), 0.0f, 1.0f);
				float fragment_unnamed_148;
				float fragment_unnamed_149;
				float fragment_unnamed_150;
				float fragment_unnamed_151;
				switch (fragment_input_2)
				{
					case 0u:
					{
						fragment_unnamed_148 = fragment_unnamed_61.z * fragment_uniform_buffer_1[3u].z;
						fragment_unnamed_149 = fragment_unnamed_113;
						fragment_unnamed_150 = fragment_unnamed_61.y * fragment_uniform_buffer_1[3u].y;
						fragment_unnamed_151 = fragment_unnamed_61.x * fragment_uniform_buffer_1[3u].x;
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_127 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_148 = fragment_unnamed_113;
						fragment_unnamed_149 = fragment_unnamed_127.x * fragment_unnamed_127.w;
						fragment_unnamed_150 = fragment_unnamed_127.y;
						fragment_unnamed_151 = asfloat(1065353216u);
						break;
					}
					case 2u:
					{
						float4 fragment_unnamed_143 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_148 = fragment_unnamed_113;
						fragment_unnamed_149 = fragment_unnamed_143.w;
						fragment_unnamed_150 = fragment_unnamed_143.y;
						fragment_unnamed_151 = asfloat(0u);
						break;
					}
					default:
					{
						fragment_unnamed_148 = asfloat(0u);
						fragment_unnamed_149 = asfloat(0u);
						fragment_unnamed_150 = asfloat(0u);
						fragment_unnamed_151 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_151;
				fragment_output_0.y = fragment_unnamed_150;
				fragment_output_0.z = fragment_unnamed_148;
				fragment_output_0.w = fragment_unnamed_149;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[3] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_1[7] = float4(_Dissolve, fragment_uniform_buffer_1[7][1], fragment_uniform_buffer_1[7][2], fragment_uniform_buffer_1[7][3]);

				fragment_uniform_buffer_1[7] = float4(fragment_uniform_buffer_1[7][0], fragment_uniform_buffer_1[7][1], fragment_uniform_buffer_1[7][2], _Cutoff);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)


			#if defined(DECALS_3RT) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _DiffuseScaleBias;
			float4 _NormalScaleBias;
			float4 _MaskScaleBias;
			float4 _TextureTypes;

			static float4 vertex_uniform_buffer_0[4];
			static const float vertex_unnamed_26[16] = { 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };

			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			static float2 vertex_output_1;
			static uint vertex_output_2;

			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				uint vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			uint spvBitfieldUExtract(uint Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint2 spvBitfieldUExtract(uint2 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint3 spvBitfieldUExtract(uint3 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint4 spvBitfieldUExtract(uint4 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			int spvBitfieldSExtract(int Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int2 spvBitfieldSExtract(int2 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int2 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int3 spvBitfieldSExtract(int3 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int3 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int4 spvBitfieldSExtract(int4 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int4 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			void vert_main()
			{
				uint vertex_unnamed_36 = 1u & 31u;
				uint vertex_unnamed_41 = spvBitfieldUExtract(uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_36, min((1u & 31u), (32u - vertex_unnamed_36)));
				uint vertex_unnamed_45 = (uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 1u;
				float vertex_unnamed_51 = float(vertex_unnamed_41);
				uint vertex_unnamed_56 = (uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) >> 2u;
				uint vertex_unnamed_87 = uint(dot(float4(vertex_uniform_buffer_0[3u]), float4(vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 0u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 1u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 2u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 3u])));
				uint vertex_unnamed_110;
				uint vertex_unnamed_111;
				uint vertex_unnamed_112;
				uint vertex_unnamed_113;
				switch (vertex_unnamed_87)
				{
					case 0u:
					{
						uint4 vertex_unnamed_91 = asuint(vertex_uniform_buffer_0[0u]);
						vertex_unnamed_110 = vertex_unnamed_91.x;
						vertex_unnamed_111 = vertex_unnamed_91.y;
						vertex_unnamed_112 = vertex_unnamed_91.z;
						vertex_unnamed_113 = vertex_unnamed_91.w;
						break;
					}
					case 1u:
					{
						uint4 vertex_unnamed_98 = asuint(vertex_uniform_buffer_0[1u]);
						vertex_unnamed_110 = vertex_unnamed_98.x;
						vertex_unnamed_111 = vertex_unnamed_98.y;
						vertex_unnamed_112 = vertex_unnamed_98.z;
						vertex_unnamed_113 = vertex_unnamed_98.w;
						break;
					}
					case 2u:
					{
						uint4 vertex_unnamed_105 = asuint(vertex_uniform_buffer_0[2u]);
						vertex_unnamed_110 = vertex_unnamed_105.x;
						vertex_unnamed_111 = vertex_unnamed_105.y;
						vertex_unnamed_112 = vertex_unnamed_105.z;
						vertex_unnamed_113 = vertex_unnamed_105.w;
						break;
					}
					default:
					{
						vertex_unnamed_110 = 0u;
						vertex_unnamed_111 = 0u;
						vertex_unnamed_112 = 0u;
						vertex_unnamed_113 = 0u;
						break;
					}
				}
				gl_Position.x = mad(mad(vertex_unnamed_51, asfloat(vertex_unnamed_110), asfloat(vertex_unnamed_112)), 2.0f, -1.0f);
				gl_Position.y = mad(mad(float((((-vertex_unnamed_45) + (-vertex_unnamed_41)) + 1u) & 1u), asfloat(vertex_unnamed_111), asfloat(vertex_unnamed_113)), -2.0f, 1.0f);
				gl_Position.z = mad(asfloat(1065353216u), 1.0f, 0.0f);
				gl_Position.w = mad(asfloat(1065353216u), 1.0f, 0.0f);
				vertex_output_1.x = vertex_unnamed_51;
				vertex_output_1.y = ((-0.0f) - float((vertex_unnamed_45 + vertex_unnamed_41) & 1u)) + 1.0f;
				vertex_output_2 = vertex_unnamed_87;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_DiffuseScaleBias[0], _DiffuseScaleBias[1], _DiffuseScaleBias[2], _DiffuseScaleBias[3]);

				vertex_uniform_buffer_0[1] = float4(_NormalScaleBias[0], _NormalScaleBias[1], _NormalScaleBias[2], _NormalScaleBias[3]);

				vertex_uniform_buffer_0[2] = float4(_MaskScaleBias[0], _MaskScaleBias[1], _MaskScaleBias[2], _MaskScaleBias[3]);

				vertex_uniform_buffer_0[3] = float4(_TextureTypes[0], _TextureTypes[1], _TextureTypes[2], _TextureTypes[3]);

				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			float _GlobalMipBias;
			float4 _BaseColor;
			float _Dissolve;
			float _Cutoff;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[8];
			Texture2D<float4> _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			SamplerState sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;

			static float2 fragment_input_1;
			static uint fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				nointerpolation uint fragment_input_2 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_61 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_96 = _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_113 = (fragment_unnamed_61.w * fragment_uniform_buffer_1[3u].w) * clamp(((fragment_unnamed_96.x + mad((-0.0f) - fragment_uniform_buffer_1[7u].x, 2.0f, 1.0f)) + ((-0.0f) - fragment_uniform_buffer_1[7u].w)) / (((-0.0f) - fragment_uniform_buffer_1[7u].w) + 1.0f), 0.0f, 1.0f);
				float fragment_unnamed_148;
				float fragment_unnamed_149;
				float fragment_unnamed_150;
				float fragment_unnamed_151;
				switch (fragment_input_2)
				{
					case 0u:
					{
						fragment_unnamed_148 = fragment_unnamed_61.z * fragment_uniform_buffer_1[3u].z;
						fragment_unnamed_149 = fragment_unnamed_113;
						fragment_unnamed_150 = fragment_unnamed_61.y * fragment_uniform_buffer_1[3u].y;
						fragment_unnamed_151 = fragment_unnamed_61.x * fragment_uniform_buffer_1[3u].x;
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_127 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_148 = fragment_unnamed_113;
						fragment_unnamed_149 = fragment_unnamed_127.x * fragment_unnamed_127.w;
						fragment_unnamed_150 = fragment_unnamed_127.y;
						fragment_unnamed_151 = asfloat(1065353216u);
						break;
					}
					case 2u:
					{
						float4 fragment_unnamed_143 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_148 = fragment_unnamed_113;
						fragment_unnamed_149 = fragment_unnamed_143.w;
						fragment_unnamed_150 = fragment_unnamed_143.y;
						fragment_unnamed_151 = asfloat(0u);
						break;
					}
					default:
					{
						fragment_unnamed_148 = asfloat(0u);
						fragment_unnamed_149 = asfloat(0u);
						fragment_unnamed_150 = asfloat(0u);
						fragment_unnamed_151 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_151;
				fragment_output_0.y = fragment_unnamed_150;
				fragment_output_0.z = fragment_unnamed_148;
				fragment_output_0.w = fragment_unnamed_149;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[3] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_1[7] = float4(_Dissolve, fragment_uniform_buffer_1[7][1], fragment_uniform_buffer_1[7][2], fragment_uniform_buffer_1[7][3]);

				fragment_uniform_buffer_1[7] = float4(fragment_uniform_buffer_1[7][0], fragment_uniform_buffer_1[7][1], fragment_uniform_buffer_1[7][2], _Cutoff);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL) && !defined(INSTANCING_ON)


			#if defined(DECALS_3RT) && defined(INSTANCING_ON) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _DiffuseScaleBias;
			float4 _NormalScaleBias;
			float4 _MaskScaleBias;
			float4 _TextureTypes;

			static float4 vertex_uniform_buffer_0[4];
			static const float vertex_unnamed_26[16] = { 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };

			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			static float2 vertex_output_1;
			static uint vertex_output_2;

			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				uint vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			uint spvBitfieldUExtract(uint Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint2 spvBitfieldUExtract(uint2 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint3 spvBitfieldUExtract(uint3 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint4 spvBitfieldUExtract(uint4 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			int spvBitfieldSExtract(int Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int2 spvBitfieldSExtract(int2 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int2 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int3 spvBitfieldSExtract(int3 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int3 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int4 spvBitfieldSExtract(int4 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int4 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			void vert_main()
			{
				uint vertex_unnamed_36 = 1u & 31u;
				uint vertex_unnamed_41 = spvBitfieldUExtract(uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_36, min((1u & 31u), (32u - vertex_unnamed_36)));
				uint vertex_unnamed_45 = (uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 1u;
				float vertex_unnamed_51 = float(vertex_unnamed_41);
				uint vertex_unnamed_56 = (uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) >> 2u;
				uint vertex_unnamed_87 = uint(dot(float4(vertex_uniform_buffer_0[3u]), float4(vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 0u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 1u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 2u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 3u])));
				uint vertex_unnamed_110;
				uint vertex_unnamed_111;
				uint vertex_unnamed_112;
				uint vertex_unnamed_113;
				switch (vertex_unnamed_87)
				{
					case 0u:
					{
						uint4 vertex_unnamed_91 = asuint(vertex_uniform_buffer_0[0u]);
						vertex_unnamed_110 = vertex_unnamed_91.x;
						vertex_unnamed_111 = vertex_unnamed_91.y;
						vertex_unnamed_112 = vertex_unnamed_91.z;
						vertex_unnamed_113 = vertex_unnamed_91.w;
						break;
					}
					case 1u:
					{
						uint4 vertex_unnamed_98 = asuint(vertex_uniform_buffer_0[1u]);
						vertex_unnamed_110 = vertex_unnamed_98.x;
						vertex_unnamed_111 = vertex_unnamed_98.y;
						vertex_unnamed_112 = vertex_unnamed_98.z;
						vertex_unnamed_113 = vertex_unnamed_98.w;
						break;
					}
					case 2u:
					{
						uint4 vertex_unnamed_105 = asuint(vertex_uniform_buffer_0[2u]);
						vertex_unnamed_110 = vertex_unnamed_105.x;
						vertex_unnamed_111 = vertex_unnamed_105.y;
						vertex_unnamed_112 = vertex_unnamed_105.z;
						vertex_unnamed_113 = vertex_unnamed_105.w;
						break;
					}
					default:
					{
						vertex_unnamed_110 = 0u;
						vertex_unnamed_111 = 0u;
						vertex_unnamed_112 = 0u;
						vertex_unnamed_113 = 0u;
						break;
					}
				}
				gl_Position.x = mad(mad(vertex_unnamed_51, asfloat(vertex_unnamed_110), asfloat(vertex_unnamed_112)), 2.0f, -1.0f);
				gl_Position.y = mad(mad(float((((-vertex_unnamed_45) + (-vertex_unnamed_41)) + 1u) & 1u), asfloat(vertex_unnamed_111), asfloat(vertex_unnamed_113)), -2.0f, 1.0f);
				gl_Position.z = mad(asfloat(1065353216u), 1.0f, 0.0f);
				gl_Position.w = mad(asfloat(1065353216u), 1.0f, 0.0f);
				vertex_output_1.x = vertex_unnamed_51;
				vertex_output_1.y = ((-0.0f) - float((vertex_unnamed_45 + vertex_unnamed_41) & 1u)) + 1.0f;
				vertex_output_2 = vertex_unnamed_87;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_DiffuseScaleBias[0], _DiffuseScaleBias[1], _DiffuseScaleBias[2], _DiffuseScaleBias[3]);

				vertex_uniform_buffer_0[1] = float4(_NormalScaleBias[0], _NormalScaleBias[1], _NormalScaleBias[2], _NormalScaleBias[3]);

				vertex_uniform_buffer_0[2] = float4(_MaskScaleBias[0], _MaskScaleBias[1], _MaskScaleBias[2], _MaskScaleBias[3]);

				vertex_uniform_buffer_0[3] = float4(_TextureTypes[0], _TextureTypes[1], _TextureTypes[2], _TextureTypes[3]);

				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			float _GlobalMipBias;
			float4 _BaseColor;
			float _Dissolve;
			float _Cutoff;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[8];
			Texture2D<float4> _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			SamplerState sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;

			static float2 fragment_input_1;
			static uint fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				nointerpolation uint fragment_input_2 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_61 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_96 = _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_113 = (fragment_unnamed_61.w * fragment_uniform_buffer_1[3u].w) * clamp(((fragment_unnamed_96.x + mad((-0.0f) - fragment_uniform_buffer_1[7u].x, 2.0f, 1.0f)) + ((-0.0f) - fragment_uniform_buffer_1[7u].w)) / (((-0.0f) - fragment_uniform_buffer_1[7u].w) + 1.0f), 0.0f, 1.0f);
				float fragment_unnamed_148;
				float fragment_unnamed_149;
				float fragment_unnamed_150;
				float fragment_unnamed_151;
				switch (fragment_input_2)
				{
					case 0u:
					{
						fragment_unnamed_148 = fragment_unnamed_61.z * fragment_uniform_buffer_1[3u].z;
						fragment_unnamed_149 = fragment_unnamed_113;
						fragment_unnamed_150 = fragment_unnamed_61.y * fragment_uniform_buffer_1[3u].y;
						fragment_unnamed_151 = fragment_unnamed_61.x * fragment_uniform_buffer_1[3u].x;
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_127 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_148 = fragment_unnamed_113;
						fragment_unnamed_149 = fragment_unnamed_127.x * fragment_unnamed_127.w;
						fragment_unnamed_150 = fragment_unnamed_127.y;
						fragment_unnamed_151 = asfloat(1065353216u);
						break;
					}
					case 2u:
					{
						float4 fragment_unnamed_143 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_148 = fragment_unnamed_113;
						fragment_unnamed_149 = fragment_unnamed_143.w;
						fragment_unnamed_150 = fragment_unnamed_143.y;
						fragment_unnamed_151 = asfloat(0u);
						break;
					}
					default:
					{
						fragment_unnamed_148 = asfloat(0u);
						fragment_unnamed_149 = asfloat(0u);
						fragment_unnamed_150 = asfloat(0u);
						fragment_unnamed_151 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_151;
				fragment_output_0.y = fragment_unnamed_150;
				fragment_output_0.z = fragment_unnamed_148;
				fragment_output_0.w = fragment_unnamed_149;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[3] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_1[7] = float4(_Dissolve, fragment_uniform_buffer_1[7][1], fragment_uniform_buffer_1[7][2], fragment_uniform_buffer_1[7][3]);

				fragment_uniform_buffer_1[7] = float4(fragment_uniform_buffer_1[7][0], fragment_uniform_buffer_1[7][1], fragment_uniform_buffer_1[7][2], _Cutoff);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(INSTANCING_ON) && !defined(_MATERIAL_AFFECTS_ALBEDO) && !defined(_MATERIAL_AFFECTS_MASKMAP) && !defined(_MATERIAL_AFFECTS_NORMAL)


			#if defined(DECALS_3RT) && defined(INSTANCING_ON) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _DiffuseScaleBias;
			float4 _NormalScaleBias;
			float4 _MaskScaleBias;
			float4 _TextureTypes;

			static float4 vertex_uniform_buffer_0[4];
			static const float vertex_unnamed_26[16] = { 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };

			static float4 gl_Position;
			static int gl_VertexIndex;
			static int gl_BaseVertexARB;
			static float2 vertex_output_1;
			static uint vertex_output_2;

			struct Vertex_Stage_Input
			{
				uint gl_VertexIndex : SV_VertexID;
			};

			struct Vertex_Stage_Output
			{
				float2 vertex_output_1 : TEXCOORD; // TEXCOORD
				uint vertex_output_2 : TEXCOORD1; // TEXCOORD_1
				float4 gl_Position : SV_Position;
			};

			uint spvBitfieldUExtract(uint Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint2 spvBitfieldUExtract(uint2 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint3 spvBitfieldUExtract(uint3 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			uint4 spvBitfieldUExtract(uint4 Base, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : ((1 << Count) - 1);
				return (Base >> Offset) & Mask;
			}

			int spvBitfieldSExtract(int Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int2 spvBitfieldSExtract(int2 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int2 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int3 spvBitfieldSExtract(int3 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int3 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			int4 spvBitfieldSExtract(int4 Base, int Offset, int Count)
			{
				int Mask = Count == 32 ? -1 : ((1 << Count) - 1);
				int4 Masked = (Base >> Offset) & Mask;
				int ExtendShift = (32 - Count) & 31;
				return (Masked << ExtendShift) >> ExtendShift;
			}

			void vert_main()
			{
				uint vertex_unnamed_36 = 1u & 31u;
				uint vertex_unnamed_41 = spvBitfieldUExtract(uint(gl_VertexIndex) - uint(gl_BaseVertexARB), vertex_unnamed_36, min((1u & 31u), (32u - vertex_unnamed_36)));
				uint vertex_unnamed_45 = (uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) & 1u;
				float vertex_unnamed_51 = float(vertex_unnamed_41);
				uint vertex_unnamed_56 = (uint(gl_VertexIndex) - uint(gl_BaseVertexARB)) >> 2u;
				uint vertex_unnamed_87 = uint(dot(float4(vertex_uniform_buffer_0[3u]), float4(vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 0u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 1u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 2u], vertex_unnamed_26[(vertex_unnamed_56 * 4u) + 3u])));
				uint vertex_unnamed_110;
				uint vertex_unnamed_111;
				uint vertex_unnamed_112;
				uint vertex_unnamed_113;
				switch (vertex_unnamed_87)
				{
					case 0u:
					{
						uint4 vertex_unnamed_91 = asuint(vertex_uniform_buffer_0[0u]);
						vertex_unnamed_110 = vertex_unnamed_91.x;
						vertex_unnamed_111 = vertex_unnamed_91.y;
						vertex_unnamed_112 = vertex_unnamed_91.z;
						vertex_unnamed_113 = vertex_unnamed_91.w;
						break;
					}
					case 1u:
					{
						uint4 vertex_unnamed_98 = asuint(vertex_uniform_buffer_0[1u]);
						vertex_unnamed_110 = vertex_unnamed_98.x;
						vertex_unnamed_111 = vertex_unnamed_98.y;
						vertex_unnamed_112 = vertex_unnamed_98.z;
						vertex_unnamed_113 = vertex_unnamed_98.w;
						break;
					}
					case 2u:
					{
						uint4 vertex_unnamed_105 = asuint(vertex_uniform_buffer_0[2u]);
						vertex_unnamed_110 = vertex_unnamed_105.x;
						vertex_unnamed_111 = vertex_unnamed_105.y;
						vertex_unnamed_112 = vertex_unnamed_105.z;
						vertex_unnamed_113 = vertex_unnamed_105.w;
						break;
					}
					default:
					{
						vertex_unnamed_110 = 0u;
						vertex_unnamed_111 = 0u;
						vertex_unnamed_112 = 0u;
						vertex_unnamed_113 = 0u;
						break;
					}
				}
				gl_Position.x = mad(mad(vertex_unnamed_51, asfloat(vertex_unnamed_110), asfloat(vertex_unnamed_112)), 2.0f, -1.0f);
				gl_Position.y = mad(mad(float((((-vertex_unnamed_45) + (-vertex_unnamed_41)) + 1u) & 1u), asfloat(vertex_unnamed_111), asfloat(vertex_unnamed_113)), -2.0f, 1.0f);
				gl_Position.z = mad(asfloat(1065353216u), 1.0f, 0.0f);
				gl_Position.w = mad(asfloat(1065353216u), 1.0f, 0.0f);
				vertex_output_1.x = vertex_unnamed_51;
				vertex_output_1.y = ((-0.0f) - float((vertex_unnamed_45 + vertex_unnamed_41) & 1u)) + 1.0f;
				vertex_output_2 = vertex_unnamed_87;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[0] = float4(_DiffuseScaleBias[0], _DiffuseScaleBias[1], _DiffuseScaleBias[2], _DiffuseScaleBias[3]);

				vertex_uniform_buffer_0[1] = float4(_NormalScaleBias[0], _NormalScaleBias[1], _NormalScaleBias[2], _NormalScaleBias[3]);

				vertex_uniform_buffer_0[2] = float4(_MaskScaleBias[0], _MaskScaleBias[1], _MaskScaleBias[2], _MaskScaleBias[3]);

				vertex_uniform_buffer_0[3] = float4(_TextureTypes[0], _TextureTypes[1], _TextureTypes[2], _TextureTypes[3]);

				gl_VertexIndex = int(stage_input.gl_VertexIndex + 0u);
				gl_BaseVertexARB = 0u;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			float _GlobalMipBias;
			float4 _BaseColor;
			float _Dissolve;
			float _Cutoff;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[8];
			Texture2D<float4> _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			SamplerState sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;

			static float2 fragment_input_1;
			static uint fragment_input_2;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float2 fragment_input_1 : TEXCOORD; // TEXCOORD
				nointerpolation uint fragment_input_2 : TEXCOORD1; // TEXCOORD_1
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float4 fragment_unnamed_61 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_96 = _SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a820a06de00344b183b8d7270273b27f_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_113 = (fragment_unnamed_61.w * fragment_uniform_buffer_1[3u].w) * clamp(((fragment_unnamed_96.x + mad((-0.0f) - fragment_uniform_buffer_1[7u].x, 2.0f, 1.0f)) + ((-0.0f) - fragment_uniform_buffer_1[7u].w)) / (((-0.0f) - fragment_uniform_buffer_1[7u].w) + 1.0f), 0.0f, 1.0f);
				float fragment_unnamed_148;
				float fragment_unnamed_149;
				float fragment_unnamed_150;
				float fragment_unnamed_151;
				switch (fragment_input_2)
				{
					case 0u:
					{
						fragment_unnamed_148 = fragment_unnamed_61.z * fragment_uniform_buffer_1[3u].z;
						fragment_unnamed_149 = fragment_unnamed_113;
						fragment_unnamed_150 = fragment_unnamed_61.y * fragment_uniform_buffer_1[3u].y;
						fragment_unnamed_151 = fragment_unnamed_61.x * fragment_uniform_buffer_1[3u].x;
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_127 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_148 = fragment_unnamed_113;
						fragment_unnamed_149 = fragment_unnamed_127.x * fragment_unnamed_127.w;
						fragment_unnamed_150 = fragment_unnamed_127.y;
						fragment_unnamed_151 = asfloat(1065353216u);
						break;
					}
					case 2u:
					{
						float4 fragment_unnamed_143 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_148 = fragment_unnamed_113;
						fragment_unnamed_149 = fragment_unnamed_143.w;
						fragment_unnamed_150 = fragment_unnamed_143.y;
						fragment_unnamed_151 = asfloat(0u);
						break;
					}
					default:
					{
						fragment_unnamed_148 = asfloat(0u);
						fragment_unnamed_149 = asfloat(0u);
						fragment_unnamed_150 = asfloat(0u);
						fragment_unnamed_151 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_151;
				fragment_output_0.y = fragment_unnamed_150;
				fragment_output_0.z = fragment_unnamed_148;
				fragment_output_0.w = fragment_unnamed_149;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[3] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_1[7] = float4(_Dissolve, fragment_uniform_buffer_1[7][1], fragment_uniform_buffer_1[7][2], fragment_uniform_buffer_1[7][3]);

				fragment_uniform_buffer_1[7] = float4(fragment_uniform_buffer_1[7][0], fragment_uniform_buffer_1[7][1], fragment_uniform_buffer_1[7][2], _Cutoff);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(INSTANCING_ON) && defined(_MATERIAL_AFFECTS_ALBEDO) && defined(_MATERIAL_AFFECTS_MASKMAP) && defined(_MATERIAL_AFFECTS_NORMAL)


			// Fallback Shader Code
			#ifndef ANY_SHADER_VARIANT_ACTIVE

			// https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
			float4x4 unity_MatrixMVP;

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
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
