Shader "Shader Graphs/Decals_HCZConcrete"
{
	Properties
	{
		[NoScaleOffset] _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] [Normal] _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D ("Texture2D", 2D) = "bump" {}
		[NoScaleOffset] _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
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
			GpuProgramID 28434

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
			static float4 vertex_output_1;

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
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_74 = asfloat(1065353216u);
				float vertex_unnamed_76 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				float vertex_unnamed_105 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				float vertex_unnamed_135 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_277)
			{
				if (fragment_unnamed_277)
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
				uint fragment_unnamed_43 = uint(gl_FragCoord.x);
				uint fragment_unnamed_44 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_45 = _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_43, fragment_unnamed_44, 0u), 0u));
				float fragment_unnamed_48 = fragment_unnamed_45.x;
				float fragment_unnamed_62 = mad(gl_FragCoord.x * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_66 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
				float fragment_unnamed_111 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_48, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_62, fragment_unnamed_66 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
				float fragment_unnamed_112 = (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_48, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_62, fragment_unnamed_66 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_111;
				float fragment_unnamed_113 = (mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_48, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_62, fragment_unnamed_66 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_111;
				float fragment_unnamed_114 = (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_48, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_62, fragment_unnamed_66 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_111;
				uint fragment_unnamed_144;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					float4 fragment_unnamed_123 = _DecalPrepassTexture.Load(int4(uint3(fragment_unnamed_43, fragment_unnamed_44, 0u), 0u));
					fragment_unnamed_144 = (((uint(fragment_unnamed_123.y * 255.5f) | (uint(fragment_unnamed_123.x * 255.5f) << 8u)) & asuint(fragment_uniform_buffer_2[4u]).x) != 0u) ? 1065353216u : 3212836864u;
				}
				else
				{
					fragment_unnamed_144 = 1065353216u;
				}
				float fragment_unnamed_216 = mad((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_unnamed_114, mad(fragment_uniform_buffer_1[4u].x, fragment_unnamed_112, fragment_unnamed_113 * fragment_uniform_buffer_1[5u].x)), 1.0f, 0.5f);
				float fragment_unnamed_219 = mad((mad(fragment_uniform_buffer_1[6u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].y)) + fragment_uniform_buffer_1[7u].y) + mad(fragment_uniform_buffer_1[6u].y, fragment_unnamed_114, mad(fragment_uniform_buffer_1[4u].y, fragment_unnamed_112, fragment_unnamed_113 * fragment_uniform_buffer_1[5u].y)), -1.0f, 0.5f);
				float fragment_unnamed_220 = mad((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_unnamed_114, mad(fragment_uniform_buffer_1[4u].z, fragment_unnamed_112, fragment_unnamed_113 * fragment_uniform_buffer_1[5u].z)), 1.0f, 0.5f);
				discard_cond(asfloat((((((0.0f < (((-0.0f) - fragment_unnamed_220) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_219) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_216) + 1.0f)) ? 4294967295u : 0u))) & (((0.0f < fragment_unnamed_220) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_219) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_216) ? 4294967295u : 0u)))) != 0u) ? fragment_unnamed_144 : asuint(asfloat(fragment_unnamed_144) + (-2.0f))) < 0.0f);
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
			static float4 vertex_output_1;

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
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_74 = asfloat(1065353216u);
				float vertex_unnamed_76 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				float vertex_unnamed_105 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				float vertex_unnamed_135 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
				return stage_output;
			}


			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4x4 _NormalToWorld;
			int _DecalLayerMaskFromDecal;

			static float4 fragment_uniform_buffer_0[129];
			static float4 fragment_uniform_buffer_1[8];
			static float4 fragment_uniform_buffer_2[5];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2D<float4> _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;
			Texture2DArray<float4> _DecalPrepassTexture;
			SamplerState sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_450)
			{
				if (fragment_unnamed_450)
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
				uint fragment_unnamed_59 = uint(gl_FragCoord.x);
				uint fragment_unnamed_60 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_61 = _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_59, fragment_unnamed_60, 0u), 0u));
				float fragment_unnamed_64 = fragment_unnamed_61.x;
				float fragment_unnamed_78 = mad(gl_FragCoord.x * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_82 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
				float fragment_unnamed_127 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_64, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_78, fragment_unnamed_82 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
				float fragment_unnamed_128 = (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_64, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_78, fragment_unnamed_82 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_127;
				float fragment_unnamed_129 = (mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_64, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_78, fragment_unnamed_82 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_127;
				float fragment_unnamed_130 = (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_64, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_78, fragment_unnamed_82 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_127;
				float fragment_unnamed_196;
				float fragment_unnamed_197;
				float fragment_unnamed_198;
				uint fragment_unnamed_199;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					float4 fragment_unnamed_139 = _DecalPrepassTexture.Load(int4(uint3(fragment_unnamed_59, fragment_unnamed_60, 0u), 0u));
					float fragment_unnamed_145 = mad(fragment_unnamed_139.z, 2.0f, -1.0f);
					float fragment_unnamed_146 = mad(fragment_unnamed_139.w, 2.0f, -1.0f);
					float fragment_unnamed_158 = ((-0.0f) - ((fragment_unnamed_146 < 0.0f) ? ((-0.0f) - fragment_unnamed_146) : fragment_unnamed_146)) + (((-0.0f) - ((fragment_unnamed_145 < 0.0f) ? ((-0.0f) - fragment_unnamed_145) : fragment_unnamed_145)) + 1.0f);
					float fragment_unnamed_160 = max((-0.0f) - fragment_unnamed_158, 0.0f);
					float fragment_unnamed_163 = (-0.0f) - fragment_unnamed_160;
					float fragment_unnamed_166 = fragment_unnamed_145 + ((fragment_unnamed_145 >= 0.0f) ? fragment_unnamed_163 : fragment_unnamed_160);
					float fragment_unnamed_167 = fragment_unnamed_146 + ((fragment_unnamed_146 >= 0.0f) ? fragment_unnamed_163 : fragment_unnamed_160);
					float fragment_unnamed_172 = rsqrt(dot(float3(fragment_unnamed_166, fragment_unnamed_167, fragment_unnamed_158), float3(fragment_unnamed_166, fragment_unnamed_167, fragment_unnamed_158)));
					fragment_unnamed_196 = fragment_unnamed_172 * fragment_unnamed_166;
					fragment_unnamed_197 = fragment_unnamed_172 * fragment_unnamed_167;
					fragment_unnamed_198 = fragment_unnamed_172 * fragment_unnamed_158;
					fragment_unnamed_199 = (((uint(fragment_unnamed_139.y * 255.5f) | (uint(fragment_unnamed_139.x * 255.5f) << 8u)) & asuint(fragment_uniform_buffer_2[4u]).x) != 0u) ? 1065353216u : 3212836864u;
				}
				else
				{
					fragment_unnamed_196 = asfloat(0u);
					fragment_unnamed_197 = asfloat(0u);
					fragment_unnamed_198 = asfloat(0u);
					fragment_unnamed_199 = 1065353216u;
				}
				float fragment_unnamed_271 = mad((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_unnamed_130, mad(fragment_uniform_buffer_1[4u].x, fragment_unnamed_128, fragment_unnamed_129 * fragment_uniform_buffer_1[5u].x)), 1.0f, 0.5f);
				float fragment_unnamed_273 = mad((mad(fragment_uniform_buffer_1[6u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].y)) + fragment_uniform_buffer_1[7u].y) + mad(fragment_uniform_buffer_1[6u].y, fragment_unnamed_130, mad(fragment_uniform_buffer_1[4u].y, fragment_unnamed_128, fragment_unnamed_129 * fragment_uniform_buffer_1[5u].y)), -1.0f, 0.5f);
				float fragment_unnamed_274 = mad((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_unnamed_130, mad(fragment_uniform_buffer_1[4u].z, fragment_unnamed_128, fragment_unnamed_129 * fragment_uniform_buffer_1[5u].z)), 1.0f, 0.5f);
				discard_cond(asfloat((((((0.0f < (((-0.0f) - fragment_unnamed_274) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_273) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_271) + 1.0f)) ? 4294967295u : 0u))) & (((0.0f < fragment_unnamed_274) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_273) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_271) ? 4294967295u : 0u)))) != 0u) ? fragment_unnamed_199 : asuint(asfloat(fragment_unnamed_199) + (-2.0f))) < 0.0f);
				float fragment_unnamed_321 = dot(float3(fragment_unnamed_196, fragment_unnamed_197, fragment_unnamed_198), float3(fragment_uniform_buffer_2[2u].xyz));
				float fragment_unnamed_355 = mad(fragment_unnamed_271, fragment_uniform_buffer_2[0u].w, fragment_uniform_buffer_2[2u].w);
				float fragment_unnamed_362 = mad(fragment_unnamed_274, fragment_uniform_buffer_2[1u].w, fragment_uniform_buffer_2[3u].w);
				float4 fragment_unnamed_369 = _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D, float2(fragment_unnamed_355, fragment_unnamed_362), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_380 = _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D, float2(fragment_unnamed_355, fragment_unnamed_362), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_386 = mad(fragment_unnamed_380.x * fragment_unnamed_380.w, 2.0f, -1.0f);
				float fragment_unnamed_387 = mad(fragment_unnamed_380.y, 2.0f, -1.0f);
				float fragment_unnamed_395 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_386, fragment_unnamed_387), float2(fragment_unnamed_386, fragment_unnamed_387)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_404 = (asfloat((asuint(fragment_uniform_buffer_0[128u]).w != 0u) ? ((0.0f < fragment_uniform_buffer_2[3u].y) ? asuint(clamp(mad(fragment_unnamed_321 * mad(fragment_unnamed_321, fragment_unnamed_321, 1.25f), fragment_uniform_buffer_2[3u].y, fragment_uniform_buffer_2[3u].z), 0.0f, 1.0f)) : 1065353216u) : 1065353216u) * clamp(fragment_uniform_buffer_2[3u].x, 0.0f, 1.0f)) * fragment_unnamed_369.w;
				fragment_output_1.x = mad(mad(fragment_uniform_buffer_2[2u].x, fragment_unnamed_395, mad(fragment_uniform_buffer_2[0u].x, fragment_unnamed_386, fragment_unnamed_387 * fragment_uniform_buffer_2[1u].x)), 0.5f, 0.5f);
				fragment_output_1.y = mad(mad(fragment_uniform_buffer_2[2u].y, fragment_unnamed_395, mad(fragment_uniform_buffer_2[0u].y, fragment_unnamed_386, fragment_unnamed_387 * fragment_uniform_buffer_2[1u].y)), 0.5f, 0.5f);
				fragment_output_1.z = mad(mad(fragment_uniform_buffer_2[2u].z, fragment_unnamed_395, mad(fragment_uniform_buffer_2[0u].z, fragment_unnamed_386, fragment_unnamed_387 * fragment_uniform_buffer_2[1u].z)), 0.5f, 0.5f);
				fragment_output_0.x = fragment_unnamed_369.x;
				fragment_output_0.y = fragment_unnamed_369.y;
				fragment_output_0.z = fragment_unnamed_369.z;
				fragment_output_0.w = fragment_unnamed_404;
				fragment_output_1.w = fragment_unnamed_404;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D, float2(fragment_unnamed_355, fragment_unnamed_362), fragment_uniform_buffer_0[86u].y).w;
				fragment_output_2.w = fragment_unnamed_404;
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

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
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
			static float4 vertex_output_1;
			static uint vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				uint vertex_output_2 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_46 = asfloat(1065353216u);
				uint vertex_unnamed_59 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) << 3u;
				uint vertex_unnamed_71 = vertex_unnamed_59 + 3u;
				float vertex_unnamed_97 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_71].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				float vertex_unnamed_128 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_71].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				float vertex_unnamed_160 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_71].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_128, vertex_unnamed_97 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_128, vertex_unnamed_97 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_128, vertex_unnamed_97 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_128, vertex_unnamed_97 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
				vertex_output_2 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
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
			static uint fragment_input_2;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				nointerpolation uint fragment_input_2 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_301)
			{
				if (fragment_unnamed_301)
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
				uint fragment_unnamed_51 = fragment_input_2 + asuint(fragment_uniform_buffer_1[0u]).x;
				uint fragment_unnamed_57 = uint(gl_FragCoord.x);
				uint fragment_unnamed_58 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_59 = _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_57, fragment_unnamed_58, 0u), 0u));
				float fragment_unnamed_62 = fragment_unnamed_59.x;
				float fragment_unnamed_75 = mad(gl_FragCoord.x * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_79 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
				float fragment_unnamed_124 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_62, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_75, fragment_unnamed_79 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
				float fragment_unnamed_125 = (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_62, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_75, fragment_unnamed_79 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_124;
				float fragment_unnamed_126 = (mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_62, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_75, fragment_unnamed_79 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_124;
				float fragment_unnamed_127 = (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_62, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_75, fragment_unnamed_79 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_124;
				uint fragment_unnamed_160;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					float4 fragment_unnamed_137 = _DecalPrepassTexture.Load(int4(uint3(fragment_unnamed_57, fragment_unnamed_58, 0u), 0u));
					fragment_unnamed_160 = (((uint(fragment_unnamed_137.y * 255.5f) | (uint(fragment_unnamed_137.x * 255.5f) << 8u)) & asuint(fragment_uniform_buffer_3[(fragment_unnamed_51 * 5u) + 4u]).x) != 0u) ? 1065353216u : 3212836864u;
				}
				else
				{
					fragment_unnamed_160 = 1065353216u;
				}
				uint fragment_unnamed_161 = fragment_unnamed_51 << 3u;
				uint fragment_unnamed_167 = fragment_unnamed_161 + 5u;
				uint fragment_unnamed_176 = fragment_unnamed_161 + 4u;
				uint fragment_unnamed_188 = fragment_unnamed_161 + 6u;
				uint fragment_unnamed_201 = fragment_unnamed_161 + 7u;
				uint fragment_unnamed_211 = fragment_unnamed_161 + 5u;
				uint fragment_unnamed_220 = fragment_unnamed_161 + 4u;
				uint fragment_unnamed_229 = fragment_unnamed_161 + 6u;
				float fragment_unnamed_241 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_188].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_176].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_167].x)) + fragment_uniform_buffer_2[fragment_unnamed_201].x) + mad(fragment_uniform_buffer_2[fragment_unnamed_229].x, fragment_unnamed_127, mad(fragment_uniform_buffer_2[fragment_unnamed_220].x, fragment_unnamed_125, fragment_unnamed_126 * fragment_uniform_buffer_2[fragment_unnamed_211].x)), 1.0f, 0.5f);
				float fragment_unnamed_244 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_188].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_176].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_167].y)) + fragment_uniform_buffer_2[fragment_unnamed_201].y) + mad(fragment_uniform_buffer_2[fragment_unnamed_229].y, fragment_unnamed_127, mad(fragment_uniform_buffer_2[fragment_unnamed_220].y, fragment_unnamed_125, fragment_unnamed_126 * fragment_uniform_buffer_2[fragment_unnamed_211].y)), -1.0f, 0.5f);
				float fragment_unnamed_245 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_188].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_176].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_167].z)) + fragment_uniform_buffer_2[fragment_unnamed_201].z) + mad(fragment_uniform_buffer_2[fragment_unnamed_229].z, fragment_unnamed_127, mad(fragment_uniform_buffer_2[fragment_unnamed_220].z, fragment_unnamed_125, fragment_unnamed_126 * fragment_uniform_buffer_2[fragment_unnamed_211].z)), 1.0f, 0.5f);
				discard_cond(asfloat((((((0.0f < (((-0.0f) - fragment_unnamed_245) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_244) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_241) + 1.0f)) ? 4294967295u : 0u))) & (((0.0f < fragment_unnamed_245) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_244) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_241) ? 4294967295u : 0u)))) != 0u) ? fragment_unnamed_160 : asuint(asfloat(fragment_unnamed_160) + (-2.0f))) < 0.0f);
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
			static float4 vertex_output_1;
			static uint vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				uint vertex_output_2 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_46 = asfloat(1065353216u);
				uint vertex_unnamed_59 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) << 3u;
				uint vertex_unnamed_71 = vertex_unnamed_59 + 3u;
				float vertex_unnamed_97 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_71].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				float vertex_unnamed_128 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_71].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				float vertex_unnamed_160 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_71].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_128, vertex_unnamed_97 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_128, vertex_unnamed_97 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_128, vertex_unnamed_97 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_128, vertex_unnamed_97 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
				vertex_output_2 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			float _GlobalMipBias;
			int unity_BaseInstanceID;
			struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { int _DecalLayerMaskFromDecal; float4x4 _NormalToWorld; } DecalArray[2];

			static float4 fragment_uniform_buffer_0[129];
			static float4 fragment_uniform_buffer_1[1];
			static float4 fragment_uniform_buffer_2[16];
			static float4 fragment_uniform_buffer_3[10];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2D<float4> _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;
			Texture2DArray<float4> _DecalPrepassTexture;
			SamplerState sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static uint fragment_input_2;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				nointerpolation uint fragment_input_2 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_494)
			{
				if (fragment_unnamed_494)
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
				uint fragment_unnamed_67 = fragment_input_2 + asuint(fragment_uniform_buffer_1[0u]).x;
				uint fragment_unnamed_73 = uint(gl_FragCoord.x);
				uint fragment_unnamed_74 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_75 = _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_73, fragment_unnamed_74, 0u), 0u));
				float fragment_unnamed_78 = fragment_unnamed_75.x;
				float fragment_unnamed_91 = mad(gl_FragCoord.x * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_95 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
				float fragment_unnamed_140 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_78, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_91, fragment_unnamed_95 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
				float fragment_unnamed_141 = (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_78, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_91, fragment_unnamed_95 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_140;
				float fragment_unnamed_142 = (mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_78, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_91, fragment_unnamed_95 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_140;
				float fragment_unnamed_143 = (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_78, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_91, fragment_unnamed_95 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_140;
				float fragment_unnamed_214;
				float fragment_unnamed_215;
				float fragment_unnamed_216;
				float fragment_unnamed_217;
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
					float fragment_unnamed_186 = rsqrt(dot(float3(fragment_unnamed_180, fragment_unnamed_181, fragment_unnamed_172), float3(fragment_unnamed_180, fragment_unnamed_181, fragment_unnamed_172)));
					fragment_unnamed_214 = fragment_unnamed_186 * fragment_unnamed_180;
					fragment_unnamed_215 = fragment_unnamed_186 * fragment_unnamed_181;
					fragment_unnamed_216 = fragment_unnamed_186 * fragment_unnamed_172;
					fragment_unnamed_217 = asfloat((((uint(fragment_unnamed_153.y * 255.5f) | (uint(fragment_unnamed_153.x * 255.5f) << 8u)) & asuint(fragment_uniform_buffer_3[(fragment_unnamed_67 * 5u) + 4u]).x) != 0u) ? 1065353216u : 3212836864u);
				}
				else
				{
					fragment_unnamed_214 = asfloat(0u);
					fragment_unnamed_215 = asfloat(0u);
					fragment_unnamed_216 = asfloat(0u);
					fragment_unnamed_217 = asfloat(1065353216u);
				}
				uint fragment_unnamed_218 = fragment_unnamed_67 << 3u;
				uint fragment_unnamed_224 = fragment_unnamed_218 + 5u;
				uint fragment_unnamed_233 = fragment_unnamed_218 + 4u;
				uint fragment_unnamed_245 = fragment_unnamed_218 + 6u;
				uint fragment_unnamed_258 = fragment_unnamed_218 + 7u;
				uint fragment_unnamed_268 = fragment_unnamed_218 + 5u;
				uint fragment_unnamed_277 = fragment_unnamed_218 + 4u;
				uint fragment_unnamed_286 = fragment_unnamed_218 + 6u;
				float fragment_unnamed_298 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_245].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_233].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_224].x)) + fragment_uniform_buffer_2[fragment_unnamed_258].x) + mad(fragment_uniform_buffer_2[fragment_unnamed_286].x, fragment_unnamed_143, mad(fragment_uniform_buffer_2[fragment_unnamed_277].x, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_2[fragment_unnamed_268].x)), 1.0f, 0.5f);
				float fragment_unnamed_300 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_245].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_233].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_224].y)) + fragment_uniform_buffer_2[fragment_unnamed_258].y) + mad(fragment_uniform_buffer_2[fragment_unnamed_286].y, fragment_unnamed_143, mad(fragment_uniform_buffer_2[fragment_unnamed_277].y, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_2[fragment_unnamed_268].y)), -1.0f, 0.5f);
				float fragment_unnamed_301 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_245].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_233].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_224].z)) + fragment_uniform_buffer_2[fragment_unnamed_258].z) + mad(fragment_uniform_buffer_2[fragment_unnamed_286].z, fragment_unnamed_143, mad(fragment_uniform_buffer_2[fragment_unnamed_277].z, fragment_unnamed_141, fragment_unnamed_142 * fragment_uniform_buffer_2[fragment_unnamed_268].z)), 1.0f, 0.5f);
				discard_cond(asfloat((((((0.0f < (((-0.0f) - fragment_unnamed_301) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_300) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_298) + 1.0f)) ? 4294967295u : 0u))) & (((0.0f < fragment_unnamed_301) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_300) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_298) ? 4294967295u : 0u)))) != 0u) ? asuint(fragment_unnamed_217) : asuint(fragment_unnamed_217 + (-2.0f))) < 0.0f);
				float fragment_unnamed_373;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					uint fragment_unnamed_342 = fragment_unnamed_67 * 5u;
					float fragment_unnamed_374;
					if (0.0f < fragment_uniform_buffer_3[fragment_unnamed_342 + 3u].y)
					{
						float fragment_unnamed_356 = dot(float3(fragment_unnamed_214, fragment_unnamed_215, fragment_unnamed_216), float3(fragment_uniform_buffer_3[fragment_unnamed_342 + 2u].xyz));
						fragment_unnamed_374 = clamp(mad(fragment_unnamed_356 * mad(fragment_unnamed_356, fragment_unnamed_356, 1.25f), fragment_uniform_buffer_3[fragment_unnamed_342 + 3u].y, fragment_uniform_buffer_3[fragment_unnamed_342 + 3u].z), 0.0f, 1.0f);
					}
					else
					{
						fragment_unnamed_374 = asfloat(1065353216u);
					}
					fragment_unnamed_373 = fragment_unnamed_374;
				}
				else
				{
					fragment_unnamed_373 = asfloat(1065353216u);
				}
				uint fragment_unnamed_375 = fragment_unnamed_67 * 5u;
				float fragment_unnamed_389 = mad(fragment_unnamed_298, fragment_uniform_buffer_3[fragment_unnamed_375].w, fragment_uniform_buffer_3[fragment_unnamed_375 + 2u].w);
				float fragment_unnamed_398 = mad(fragment_unnamed_301, fragment_uniform_buffer_3[fragment_unnamed_375 + 1u].w, fragment_uniform_buffer_3[fragment_unnamed_375 + 3u].w);
				float4 fragment_unnamed_405 = _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D, float2(fragment_unnamed_389, fragment_unnamed_398), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_416 = _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D, float2(fragment_unnamed_389, fragment_unnamed_398), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_422 = mad(fragment_unnamed_416.x * fragment_unnamed_416.w, 2.0f, -1.0f);
				float fragment_unnamed_423 = mad(fragment_unnamed_416.y, 2.0f, -1.0f);
				float fragment_unnamed_431 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_422, fragment_unnamed_423), float2(fragment_unnamed_422, fragment_unnamed_423)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_440 = (fragment_unnamed_373 * clamp(fragment_uniform_buffer_3[fragment_unnamed_375 + 3u].x, 0.0f, 1.0f)) * fragment_unnamed_405.w;
				uint fragment_unnamed_441 = fragment_unnamed_375 + 1u;
				uint fragment_unnamed_458 = fragment_unnamed_375 + 2u;
				fragment_output_1.x = mad(mad(fragment_uniform_buffer_3[fragment_unnamed_458].x, fragment_unnamed_431, mad(fragment_uniform_buffer_3[fragment_unnamed_375].x, fragment_unnamed_422, fragment_unnamed_423 * fragment_uniform_buffer_3[fragment_unnamed_441].x)), 0.5f, 0.5f);
				fragment_output_1.y = mad(mad(fragment_uniform_buffer_3[fragment_unnamed_458].y, fragment_unnamed_431, mad(fragment_uniform_buffer_3[fragment_unnamed_375].y, fragment_unnamed_422, fragment_unnamed_423 * fragment_uniform_buffer_3[fragment_unnamed_441].y)), 0.5f, 0.5f);
				fragment_output_1.z = mad(mad(fragment_uniform_buffer_3[fragment_unnamed_458].z, fragment_unnamed_431, mad(fragment_uniform_buffer_3[fragment_unnamed_375].z, fragment_unnamed_422, fragment_unnamed_423 * fragment_uniform_buffer_3[fragment_unnamed_441].z)), 0.5f, 0.5f);
				fragment_output_0.x = fragment_unnamed_405.x;
				fragment_output_0.y = fragment_unnamed_405.y;
				fragment_output_0.z = fragment_unnamed_405.z;
				fragment_output_0.w = fragment_unnamed_440;
				fragment_output_1.w = fragment_unnamed_440;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D, float2(fragment_unnamed_389, fragment_unnamed_398), fragment_uniform_buffer_0[86u].y).w;
				fragment_output_2.w = fragment_unnamed_440;
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

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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
			GpuProgramID 69004

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
			static float4 vertex_uniform_buffer_2[4];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static uint vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float3 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				uint vertex_output_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_87 = asfloat(1065353216u);
				float vertex_unnamed_89 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				bool vertex_unnamed_97 = vertex_uniform_buffer_0[60u].w == 0.0f;
				float vertex_unnamed_103 = vertex_unnamed_97 ? ((-0.0f) - vertex_unnamed_89) : vertex_uniform_buffer_0[0u].z;
				float vertex_unnamed_119 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_126 = vertex_unnamed_97 ? ((-0.0f) - vertex_unnamed_119) : vertex_uniform_buffer_0[1u].z;
				float vertex_unnamed_142 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_149 = vertex_unnamed_97 ? ((-0.0f) - vertex_unnamed_142) : vertex_uniform_buffer_0[2u].z;
				float vertex_unnamed_154 = rsqrt(dot(float3(vertex_unnamed_103, vertex_unnamed_126, vertex_unnamed_149), float3(vertex_unnamed_103, vertex_unnamed_126, vertex_unnamed_149)));
				uint vertex_unnamed_171 = (vertex_uniform_buffer_2[3u].y == 1.0f) ? 4294967295u : 0u;
				float vertex_unnamed_181 = vertex_unnamed_89 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_103) * vertex_uniform_buffer_2[3u].w) & vertex_unnamed_171);
				float vertex_unnamed_182 = vertex_unnamed_119 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_126) * vertex_uniform_buffer_2[3u].w) & vertex_unnamed_171);
				float vertex_unnamed_183 = vertex_unnamed_142 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_149) * vertex_uniform_buffer_2[3u].w) & vertex_unnamed_171);
				vertex_output_3.x = vertex_unnamed_181;
				vertex_output_3.y = vertex_unnamed_182;
				vertex_output_3.z = vertex_unnamed_183;
				float vertex_unnamed_230 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_183, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_181, vertex_unnamed_182 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_2[3u].y == 0.0f) ? (vertex_unnamed_230 + ((-0.0f) - vertex_uniform_buffer_2[3u].z)) : vertex_unnamed_230;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_183, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_181, vertex_unnamed_182 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_183, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_181, vertex_unnamed_182 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_183, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_181, vertex_unnamed_182 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_269 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_270 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_271 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_277 = rsqrt(max(dot(float3(vertex_unnamed_269, vertex_unnamed_270, vertex_unnamed_271), float3(vertex_unnamed_269, vertex_unnamed_270, vertex_unnamed_271)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_277 * vertex_unnamed_269;
				vertex_output_1.y = vertex_unnamed_277 * vertex_unnamed_270;
				vertex_output_1.z = vertex_unnamed_277 * vertex_unnamed_271;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				float vertex_unnamed_310 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_325 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_340 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_347 = rsqrt(max(dot(float3(vertex_unnamed_310, vertex_unnamed_325, vertex_unnamed_340), float3(vertex_unnamed_310, vertex_unnamed_325, vertex_unnamed_340)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_347 * vertex_unnamed_310;
				vertex_output_4.y = vertex_unnamed_347 * vertex_unnamed_325;
				vertex_output_4.z = vertex_unnamed_347 * vertex_unnamed_340;
				vertex_output_5 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
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

				vertex_uniform_buffer_2[3] = float4(vertex_uniform_buffer_2[3][0], _DecalMeshBiasType, vertex_uniform_buffer_2[3][2], vertex_uniform_buffer_2[3][3]);

				vertex_uniform_buffer_2[3] = float4(vertex_uniform_buffer_2[3][0], vertex_uniform_buffer_2[3][1], _DecalMeshDepthBias, vertex_uniform_buffer_2[3][3]);

				vertex_uniform_buffer_2[3] = float4(vertex_uniform_buffer_2[3][0], vertex_uniform_buffer_2[3][1], vertex_uniform_buffer_2[3][2], _DecalMeshViewBias);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + 0u);
				gl_BaseInstanceARB = 0u;
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
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static uint fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				uint fragment_input_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
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
			static float4 vertex_uniform_buffer_2[4];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static uint vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float3 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				uint vertex_output_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_87 = asfloat(1065353216u);
				float vertex_unnamed_89 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				bool vertex_unnamed_97 = vertex_uniform_buffer_0[60u].w == 0.0f;
				float vertex_unnamed_103 = vertex_unnamed_97 ? ((-0.0f) - vertex_unnamed_89) : vertex_uniform_buffer_0[0u].z;
				float vertex_unnamed_119 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_126 = vertex_unnamed_97 ? ((-0.0f) - vertex_unnamed_119) : vertex_uniform_buffer_0[1u].z;
				float vertex_unnamed_142 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_149 = vertex_unnamed_97 ? ((-0.0f) - vertex_unnamed_142) : vertex_uniform_buffer_0[2u].z;
				float vertex_unnamed_154 = rsqrt(dot(float3(vertex_unnamed_103, vertex_unnamed_126, vertex_unnamed_149), float3(vertex_unnamed_103, vertex_unnamed_126, vertex_unnamed_149)));
				uint vertex_unnamed_171 = (vertex_uniform_buffer_2[3u].y == 1.0f) ? 4294967295u : 0u;
				float vertex_unnamed_181 = vertex_unnamed_89 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_103) * vertex_uniform_buffer_2[3u].w) & vertex_unnamed_171);
				float vertex_unnamed_182 = vertex_unnamed_119 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_126) * vertex_uniform_buffer_2[3u].w) & vertex_unnamed_171);
				float vertex_unnamed_183 = vertex_unnamed_142 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_149) * vertex_uniform_buffer_2[3u].w) & vertex_unnamed_171);
				vertex_output_3.x = vertex_unnamed_181;
				vertex_output_3.y = vertex_unnamed_182;
				vertex_output_3.z = vertex_unnamed_183;
				float vertex_unnamed_230 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_183, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_181, vertex_unnamed_182 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_2[3u].y == 0.0f) ? (vertex_unnamed_230 + ((-0.0f) - vertex_uniform_buffer_2[3u].z)) : vertex_unnamed_230;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_183, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_181, vertex_unnamed_182 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_183, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_181, vertex_unnamed_182 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_183, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_181, vertex_unnamed_182 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_269 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_270 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_271 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_277 = rsqrt(max(dot(float3(vertex_unnamed_269, vertex_unnamed_270, vertex_unnamed_271), float3(vertex_unnamed_269, vertex_unnamed_270, vertex_unnamed_271)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_277 * vertex_unnamed_269;
				vertex_output_1.y = vertex_unnamed_277 * vertex_unnamed_270;
				vertex_output_1.z = vertex_unnamed_277 * vertex_unnamed_271;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				float vertex_unnamed_310 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_325 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_340 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_347 = rsqrt(max(dot(float3(vertex_unnamed_310, vertex_unnamed_325, vertex_unnamed_340), float3(vertex_unnamed_310, vertex_unnamed_325, vertex_unnamed_340)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_347 * vertex_unnamed_310;
				vertex_output_4.y = vertex_unnamed_347 * vertex_unnamed_325;
				vertex_output_4.z = vertex_unnamed_347 * vertex_unnamed_340;
				vertex_output_5 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
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

				vertex_uniform_buffer_2[3] = float4(vertex_uniform_buffer_2[3][0], _DecalMeshBiasType, vertex_uniform_buffer_2[3][2], vertex_uniform_buffer_2[3][3]);

				vertex_uniform_buffer_2[3] = float4(vertex_uniform_buffer_2[3][0], vertex_uniform_buffer_2[3][1], _DecalMeshDepthBias, vertex_uniform_buffer_2[3][3]);

				vertex_uniform_buffer_2[3] = float4(vertex_uniform_buffer_2[3][0], vertex_uniform_buffer_2[3][1], vertex_uniform_buffer_2[3][2], _DecalMeshViewBias);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + 0u);
				gl_BaseInstanceARB = 0u;
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
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			float _GlobalMipBias;
			float4 unity_WorldTransformParams;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			Texture2D<float4> _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static uint fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				uint fragment_input_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			void frag_main()
			{
				float4 fragment_unnamed_62 = _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_68 = fragment_unnamed_62.w;
				fragment_output_0.x = fragment_unnamed_62.x;
				fragment_output_0.y = fragment_unnamed_62.y;
				fragment_output_0.z = fragment_unnamed_62.z;
				fragment_output_0.w = fragment_unnamed_68;
				float fragment_unnamed_92 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_149 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float4 fragment_unnamed_162 = _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_168 = mad(fragment_unnamed_162.x * fragment_unnamed_162.w, 2.0f, -1.0f);
				float fragment_unnamed_171 = mad(fragment_unnamed_162.y, 2.0f, -1.0f);
				float fragment_unnamed_203 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_168, fragment_unnamed_171), float2(fragment_unnamed_168, fragment_unnamed_171)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_205 = mad(fragment_unnamed_203, fragment_unnamed_149 * fragment_input_4.x, mad(fragment_unnamed_168, fragment_unnamed_149 * fragment_input_1.x, ((fragment_unnamed_92 * mad(fragment_input_4.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_4.z))) * fragment_unnamed_149) * fragment_unnamed_171));
				float fragment_unnamed_206 = mad(fragment_unnamed_203, fragment_unnamed_149 * fragment_input_4.y, mad(fragment_unnamed_168, fragment_unnamed_149 * fragment_input_1.y, ((fragment_unnamed_92 * mad(fragment_input_4.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_4.x))) * fragment_unnamed_149) * fragment_unnamed_171));
				float fragment_unnamed_207 = mad(fragment_unnamed_203, fragment_unnamed_149 * fragment_input_4.z, mad(fragment_unnamed_168, fragment_unnamed_149 * fragment_input_1.z, ((fragment_unnamed_92 * mad(fragment_input_4.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_4.y))) * fragment_unnamed_149) * fragment_unnamed_171));
				float fragment_unnamed_211 = rsqrt(dot(float3(fragment_unnamed_205, fragment_unnamed_206, fragment_unnamed_207), float3(fragment_unnamed_205, fragment_unnamed_206, fragment_unnamed_207)));
				fragment_output_1.x = mad(fragment_unnamed_205 * fragment_unnamed_211, 0.5f, 0.5f);
				fragment_output_1.y = mad(fragment_unnamed_206 * fragment_unnamed_211, 0.5f, 0.5f);
				fragment_output_1.z = mad(fragment_unnamed_207 * fragment_unnamed_211, 0.5f, 0.5f);
				fragment_output_1.w = fragment_unnamed_68;
				fragment_output_2.w = fragment_unnamed_68;
				fragment_output_2.z = _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).w;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
			static float4 vertex_uniform_buffer_3[4];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static uint vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float3 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				uint vertex_output_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_57 = (uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x;
				float vertex_unnamed_194;
				float vertex_unnamed_195;
				float vertex_unnamed_196;
				if (vertex_uniform_buffer_3[3u].y == 1.0f)
				{
					uint vertex_unnamed_67 = vertex_unnamed_57 << 3u;
					uint vertex_unnamed_78 = vertex_unnamed_67 + 3u;
					float vertex_unnamed_112 = asfloat(1065353216u);
					bool vertex_unnamed_161 = vertex_uniform_buffer_0[60u].w == 0.0f;
					float vertex_unnamed_166 = vertex_unnamed_161 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_78].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_112))) : vertex_uniform_buffer_0[0u].z;
					float vertex_unnamed_171 = vertex_unnamed_161 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_78].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_112))) : vertex_uniform_buffer_0[1u].z;
					float vertex_unnamed_176 = vertex_unnamed_161 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_78].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_112))) : vertex_uniform_buffer_0[2u].z;
					float vertex_unnamed_181 = rsqrt(dot(float3(vertex_unnamed_166, vertex_unnamed_171, vertex_unnamed_176), float3(vertex_unnamed_166, vertex_unnamed_171, vertex_unnamed_176)));
					vertex_unnamed_194 = (vertex_unnamed_181 * vertex_unnamed_176) * vertex_uniform_buffer_3[3u].w;
					vertex_unnamed_195 = (vertex_unnamed_181 * vertex_unnamed_171) * vertex_uniform_buffer_3[3u].w;
					vertex_unnamed_196 = (vertex_unnamed_181 * vertex_unnamed_166) * vertex_uniform_buffer_3[3u].w;
				}
				else
				{
					vertex_unnamed_194 = asfloat(0u);
					vertex_unnamed_195 = asfloat(0u);
					vertex_unnamed_196 = asfloat(0u);
				}
				uint vertex_unnamed_197 = vertex_unnamed_57 << 3u;
				uint vertex_unnamed_206 = vertex_unnamed_197 + 3u;
				float vertex_unnamed_238 = asfloat(1065353216u);
				float vertex_unnamed_282 = vertex_unnamed_196 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_206].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_238));
				float vertex_unnamed_283 = vertex_unnamed_195 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_206].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_238));
				float vertex_unnamed_284 = vertex_unnamed_194 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_206].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_238));
				float vertex_unnamed_297 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_197 + 4u].xyz));
				float vertex_unnamed_313 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_197 + 5u].xyz));
				float vertex_unnamed_329 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_197 + 6u].xyz));
				float vertex_unnamed_337 = rsqrt(max(dot(float3(vertex_unnamed_297, vertex_unnamed_313, vertex_unnamed_329), float3(vertex_unnamed_297, vertex_unnamed_313, vertex_unnamed_329)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_337 * vertex_unnamed_297;
				vertex_output_4.y = vertex_unnamed_337 * vertex_unnamed_313;
				vertex_output_4.z = vertex_unnamed_337 * vertex_unnamed_329;
				uint vertex_unnamed_347 = vertex_unnamed_197 + 1u;
				uint vertex_unnamed_366 = vertex_unnamed_197 + 2u;
				float vertex_unnamed_374 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_197].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].x));
				float vertex_unnamed_375 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_197].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].y));
				float vertex_unnamed_376 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_197].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].z));
				float vertex_unnamed_381 = rsqrt(max(dot(float3(vertex_unnamed_374, vertex_unnamed_375, vertex_unnamed_376), float3(vertex_unnamed_374, vertex_unnamed_375, vertex_unnamed_376)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_374 * vertex_unnamed_381;
				vertex_output_1.y = vertex_unnamed_375 * vertex_unnamed_381;
				vertex_output_1.z = vertex_unnamed_376 * vertex_unnamed_381;
				float vertex_unnamed_430 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_284, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_282, vertex_unnamed_283 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_3[3u].y == 0.0f) ? (vertex_unnamed_430 + ((-0.0f) - vertex_uniform_buffer_3[3u].z)) : vertex_unnamed_430;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_284, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_282, vertex_unnamed_283 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_284, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_282, vertex_unnamed_283 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_284, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_282, vertex_unnamed_283 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				vertex_output_3.x = vertex_unnamed_282;
				vertex_output_3.y = vertex_unnamed_283;
				vertex_output_3.z = vertex_unnamed_284;
				vertex_output_5 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
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

				vertex_uniform_buffer_3[3] = float4(vertex_uniform_buffer_3[3][0], _DecalMeshBiasType, vertex_uniform_buffer_3[3][2], vertex_uniform_buffer_3[3][3]);

				vertex_uniform_buffer_3[3] = float4(vertex_uniform_buffer_3[3][0], vertex_uniform_buffer_3[3][1], _DecalMeshDepthBias, vertex_uniform_buffer_3[3][3]);

				vertex_uniform_buffer_3[3] = float4(vertex_uniform_buffer_3[3][0], vertex_uniform_buffer_3[3][1], vertex_uniform_buffer_3[3][2], _DecalMeshViewBias);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + 0u);
				gl_BaseInstanceARB = 0u;
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
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static uint fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				uint fragment_input_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
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
			static float4 vertex_uniform_buffer_3[4];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;
			static uint vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				uint gl_InstanceIndex : SV_InstanceID;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float3 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				uint vertex_output_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_57 = (uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x;
				float vertex_unnamed_194;
				float vertex_unnamed_195;
				float vertex_unnamed_196;
				if (vertex_uniform_buffer_3[3u].y == 1.0f)
				{
					uint vertex_unnamed_67 = vertex_unnamed_57 << 3u;
					uint vertex_unnamed_78 = vertex_unnamed_67 + 3u;
					float vertex_unnamed_112 = asfloat(1065353216u);
					bool vertex_unnamed_161 = vertex_uniform_buffer_0[60u].w == 0.0f;
					float vertex_unnamed_166 = vertex_unnamed_161 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_78].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_112))) : vertex_uniform_buffer_0[0u].z;
					float vertex_unnamed_171 = vertex_unnamed_161 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_78].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_112))) : vertex_uniform_buffer_0[1u].z;
					float vertex_unnamed_176 = vertex_unnamed_161 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_78].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_112))) : vertex_uniform_buffer_0[2u].z;
					float vertex_unnamed_181 = rsqrt(dot(float3(vertex_unnamed_166, vertex_unnamed_171, vertex_unnamed_176), float3(vertex_unnamed_166, vertex_unnamed_171, vertex_unnamed_176)));
					vertex_unnamed_194 = (vertex_unnamed_181 * vertex_unnamed_176) * vertex_uniform_buffer_3[3u].w;
					vertex_unnamed_195 = (vertex_unnamed_181 * vertex_unnamed_171) * vertex_uniform_buffer_3[3u].w;
					vertex_unnamed_196 = (vertex_unnamed_181 * vertex_unnamed_166) * vertex_uniform_buffer_3[3u].w;
				}
				else
				{
					vertex_unnamed_194 = asfloat(0u);
					vertex_unnamed_195 = asfloat(0u);
					vertex_unnamed_196 = asfloat(0u);
				}
				uint vertex_unnamed_197 = vertex_unnamed_57 << 3u;
				uint vertex_unnamed_206 = vertex_unnamed_197 + 3u;
				float vertex_unnamed_238 = asfloat(1065353216u);
				float vertex_unnamed_282 = vertex_unnamed_196 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_206].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_238));
				float vertex_unnamed_283 = vertex_unnamed_195 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_206].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_238));
				float vertex_unnamed_284 = vertex_unnamed_194 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_197 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_206].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_238));
				float vertex_unnamed_297 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_197 + 4u].xyz));
				float vertex_unnamed_313 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_197 + 5u].xyz));
				float vertex_unnamed_329 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_197 + 6u].xyz));
				float vertex_unnamed_337 = rsqrt(max(dot(float3(vertex_unnamed_297, vertex_unnamed_313, vertex_unnamed_329), float3(vertex_unnamed_297, vertex_unnamed_313, vertex_unnamed_329)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_337 * vertex_unnamed_297;
				vertex_output_4.y = vertex_unnamed_337 * vertex_unnamed_313;
				vertex_output_4.z = vertex_unnamed_337 * vertex_unnamed_329;
				uint vertex_unnamed_347 = vertex_unnamed_197 + 1u;
				uint vertex_unnamed_366 = vertex_unnamed_197 + 2u;
				float vertex_unnamed_374 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_197].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].x));
				float vertex_unnamed_375 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_197].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].y));
				float vertex_unnamed_376 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_197].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].z));
				float vertex_unnamed_381 = rsqrt(max(dot(float3(vertex_unnamed_374, vertex_unnamed_375, vertex_unnamed_376), float3(vertex_unnamed_374, vertex_unnamed_375, vertex_unnamed_376)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_374 * vertex_unnamed_381;
				vertex_output_1.y = vertex_unnamed_375 * vertex_unnamed_381;
				vertex_output_1.z = vertex_unnamed_376 * vertex_unnamed_381;
				float vertex_unnamed_430 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_284, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_282, vertex_unnamed_283 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_3[3u].y == 0.0f) ? (vertex_unnamed_430 + ((-0.0f) - vertex_uniform_buffer_3[3u].z)) : vertex_unnamed_430;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_284, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_282, vertex_unnamed_283 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_284, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_282, vertex_unnamed_283 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_284, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_282, vertex_unnamed_283 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				vertex_output_3.x = vertex_unnamed_282;
				vertex_output_3.y = vertex_unnamed_283;
				vertex_output_3.z = vertex_unnamed_284;
				vertex_output_5 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
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

				vertex_uniform_buffer_3[3] = float4(vertex_uniform_buffer_3[3][0], _DecalMeshBiasType, vertex_uniform_buffer_3[3][2], vertex_uniform_buffer_3[3][3]);

				vertex_uniform_buffer_3[3] = float4(vertex_uniform_buffer_3[3][0], vertex_uniform_buffer_3[3][1], _DecalMeshDepthBias, vertex_uniform_buffer_3[3][3]);

				vertex_uniform_buffer_3[3] = float4(vertex_uniform_buffer_3[3][0], vertex_uniform_buffer_3[3][1], vertex_uniform_buffer_3[3][2], _DecalMeshViewBias);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + 0u);
				gl_BaseInstanceARB = 0u;
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
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}


			float _GlobalMipBias;
			float4 unity_WorldTransformParams;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			Texture2D<float4> _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static uint fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				uint fragment_input_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
			};

			void frag_main()
			{
				float4 fragment_unnamed_62 = _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_68 = fragment_unnamed_62.w;
				fragment_output_0.x = fragment_unnamed_62.x;
				fragment_output_0.y = fragment_unnamed_62.y;
				fragment_output_0.z = fragment_unnamed_62.z;
				fragment_output_0.w = fragment_unnamed_68;
				float fragment_unnamed_92 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_149 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float4 fragment_unnamed_162 = _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_168 = mad(fragment_unnamed_162.x * fragment_unnamed_162.w, 2.0f, -1.0f);
				float fragment_unnamed_171 = mad(fragment_unnamed_162.y, 2.0f, -1.0f);
				float fragment_unnamed_203 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_168, fragment_unnamed_171), float2(fragment_unnamed_168, fragment_unnamed_171)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_205 = mad(fragment_unnamed_203, fragment_unnamed_149 * fragment_input_4.x, mad(fragment_unnamed_168, fragment_unnamed_149 * fragment_input_1.x, ((fragment_unnamed_92 * mad(fragment_input_4.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_4.z))) * fragment_unnamed_149) * fragment_unnamed_171));
				float fragment_unnamed_206 = mad(fragment_unnamed_203, fragment_unnamed_149 * fragment_input_4.y, mad(fragment_unnamed_168, fragment_unnamed_149 * fragment_input_1.y, ((fragment_unnamed_92 * mad(fragment_input_4.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_4.x))) * fragment_unnamed_149) * fragment_unnamed_171));
				float fragment_unnamed_207 = mad(fragment_unnamed_203, fragment_unnamed_149 * fragment_input_4.z, mad(fragment_unnamed_168, fragment_unnamed_149 * fragment_input_1.z, ((fragment_unnamed_92 * mad(fragment_input_4.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_4.y))) * fragment_unnamed_149) * fragment_unnamed_171));
				float fragment_unnamed_211 = rsqrt(dot(float3(fragment_unnamed_205, fragment_unnamed_206, fragment_unnamed_207), float3(fragment_unnamed_205, fragment_unnamed_206, fragment_unnamed_207)));
				fragment_output_1.x = mad(fragment_unnamed_205 * fragment_unnamed_211, 0.5f, 0.5f);
				fragment_output_1.y = mad(fragment_unnamed_206 * fragment_unnamed_211, 0.5f, 0.5f);
				fragment_output_1.z = mad(fragment_unnamed_207 * fragment_unnamed_211, 0.5f, 0.5f);
				fragment_output_1.w = fragment_unnamed_68;
				fragment_output_2.w = fragment_unnamed_68;
				fragment_output_2.z = _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).w;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

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
			GpuProgramID 172787

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

			static float4 fragment_uniform_buffer_0[87];
			Texture2D<float4> _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;

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
				float4 fragment_unnamed_52 = _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_56 = fragment_unnamed_52.w;
				uint fragment_unnamed_57 = asuint(fragment_unnamed_56);
				float fragment_unnamed_93;
				float fragment_unnamed_94;
				uint fragment_unnamed_95;
				float fragment_unnamed_96;
				switch (fragment_input_2)
				{
					case 0u:
					{
						fragment_unnamed_93 = fragment_unnamed_52.x;
						fragment_unnamed_94 = fragment_unnamed_52.y;
						fragment_unnamed_95 = asuint(fragment_unnamed_52.z);
						fragment_unnamed_96 = fragment_unnamed_56;
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_72 = _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_93 = asfloat(1065353216u);
						fragment_unnamed_94 = fragment_unnamed_72.y;
						fragment_unnamed_95 = fragment_unnamed_57;
						fragment_unnamed_96 = fragment_unnamed_72.x * fragment_unnamed_72.w;
						break;
					}
					case 2u:
					{
						float4 fragment_unnamed_88 = _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_93 = fragment_unnamed_88.x;
						fragment_unnamed_94 = fragment_unnamed_88.y;
						fragment_unnamed_95 = fragment_unnamed_57;
						fragment_unnamed_96 = fragment_unnamed_88.w;
						break;
					}
					default:
					{
						fragment_unnamed_93 = asfloat(0u);
						fragment_unnamed_94 = asfloat(0u);
						fragment_unnamed_95 = 0u;
						fragment_unnamed_96 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_93;
				fragment_output_0.y = fragment_unnamed_94;
				fragment_output_0.z = asfloat(fragment_unnamed_95);
				fragment_output_0.w = fragment_unnamed_96;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

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

			static float4 fragment_uniform_buffer_0[87];
			Texture2D<float4> _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;

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
				float4 fragment_unnamed_52 = _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_56 = fragment_unnamed_52.w;
				uint fragment_unnamed_57 = asuint(fragment_unnamed_56);
				float fragment_unnamed_93;
				float fragment_unnamed_94;
				uint fragment_unnamed_95;
				float fragment_unnamed_96;
				switch (fragment_input_2)
				{
					case 0u:
					{
						fragment_unnamed_93 = fragment_unnamed_52.x;
						fragment_unnamed_94 = fragment_unnamed_52.y;
						fragment_unnamed_95 = asuint(fragment_unnamed_52.z);
						fragment_unnamed_96 = fragment_unnamed_56;
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_72 = _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_93 = asfloat(1065353216u);
						fragment_unnamed_94 = fragment_unnamed_72.y;
						fragment_unnamed_95 = fragment_unnamed_57;
						fragment_unnamed_96 = fragment_unnamed_72.x * fragment_unnamed_72.w;
						break;
					}
					case 2u:
					{
						float4 fragment_unnamed_88 = _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_93 = fragment_unnamed_88.x;
						fragment_unnamed_94 = fragment_unnamed_88.y;
						fragment_unnamed_95 = fragment_unnamed_57;
						fragment_unnamed_96 = fragment_unnamed_88.w;
						break;
					}
					default:
					{
						fragment_unnamed_93 = asfloat(0u);
						fragment_unnamed_94 = asfloat(0u);
						fragment_unnamed_95 = 0u;
						fragment_unnamed_96 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_93;
				fragment_output_0.y = fragment_unnamed_94;
				fragment_output_0.z = asfloat(fragment_unnamed_95);
				fragment_output_0.w = fragment_unnamed_96;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

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

			static float4 fragment_uniform_buffer_0[87];
			Texture2D<float4> _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;

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
				float4 fragment_unnamed_52 = _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_56 = fragment_unnamed_52.w;
				uint fragment_unnamed_57 = asuint(fragment_unnamed_56);
				float fragment_unnamed_93;
				float fragment_unnamed_94;
				uint fragment_unnamed_95;
				float fragment_unnamed_96;
				switch (fragment_input_2)
				{
					case 0u:
					{
						fragment_unnamed_93 = fragment_unnamed_52.x;
						fragment_unnamed_94 = fragment_unnamed_52.y;
						fragment_unnamed_95 = asuint(fragment_unnamed_52.z);
						fragment_unnamed_96 = fragment_unnamed_56;
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_72 = _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_93 = asfloat(1065353216u);
						fragment_unnamed_94 = fragment_unnamed_72.y;
						fragment_unnamed_95 = fragment_unnamed_57;
						fragment_unnamed_96 = fragment_unnamed_72.x * fragment_unnamed_72.w;
						break;
					}
					case 2u:
					{
						float4 fragment_unnamed_88 = _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_93 = fragment_unnamed_88.x;
						fragment_unnamed_94 = fragment_unnamed_88.y;
						fragment_unnamed_95 = fragment_unnamed_57;
						fragment_unnamed_96 = fragment_unnamed_88.w;
						break;
					}
					default:
					{
						fragment_unnamed_93 = asfloat(0u);
						fragment_unnamed_94 = asfloat(0u);
						fragment_unnamed_95 = 0u;
						fragment_unnamed_96 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_93;
				fragment_output_0.y = fragment_unnamed_94;
				fragment_output_0.z = asfloat(fragment_unnamed_95);
				fragment_output_0.w = fragment_unnamed_96;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

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

			static float4 fragment_uniform_buffer_0[87];
			Texture2D<float4> _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D;

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
				float4 fragment_unnamed_52 = _SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_3f3bd7104bb74376a084d5654aba3711_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_56 = fragment_unnamed_52.w;
				uint fragment_unnamed_57 = asuint(fragment_unnamed_56);
				float fragment_unnamed_93;
				float fragment_unnamed_94;
				uint fragment_unnamed_95;
				float fragment_unnamed_96;
				switch (fragment_input_2)
				{
					case 0u:
					{
						fragment_unnamed_93 = fragment_unnamed_52.x;
						fragment_unnamed_94 = fragment_unnamed_52.y;
						fragment_unnamed_95 = asuint(fragment_unnamed_52.z);
						fragment_unnamed_96 = fragment_unnamed_56;
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_72 = _SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4e4bafbbd6f45ddb3552424313a2368_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_93 = asfloat(1065353216u);
						fragment_unnamed_94 = fragment_unnamed_72.y;
						fragment_unnamed_95 = fragment_unnamed_57;
						fragment_unnamed_96 = fragment_unnamed_72.x * fragment_unnamed_72.w;
						break;
					}
					case 2u:
					{
						float4 fragment_unnamed_88 = _SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e64bea07e5d1430ead90dac5d3a9b2b7_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_93 = fragment_unnamed_88.x;
						fragment_unnamed_94 = fragment_unnamed_88.y;
						fragment_unnamed_95 = fragment_unnamed_57;
						fragment_unnamed_96 = fragment_unnamed_88.w;
						break;
					}
					default:
					{
						fragment_unnamed_93 = asfloat(0u);
						fragment_unnamed_94 = asfloat(0u);
						fragment_unnamed_95 = 0u;
						fragment_unnamed_96 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_93;
				fragment_output_0.y = fragment_unnamed_94;
				fragment_output_0.z = asfloat(fragment_unnamed_95);
				fragment_output_0.w = fragment_unnamed_96;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

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
