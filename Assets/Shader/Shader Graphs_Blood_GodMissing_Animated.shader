Shader "Shader Graphs/Blood_GodMissing_Animated"
{
	Properties
	{
		_Background_Alpha ("Background Alpha", Float) = 1
		[NoScaleOffset] _BloodTex ("BloodTex", 2D) = "white" {}
		[NoScaleOffset] _BloodNrm ("BloodNrm", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
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
			GpuProgramID 35106

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


			float4 _TimeParameters;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4x4 _NormalToWorld;
			int _DecalLayerMaskFromDecal;
			float _Background_Alpha;

			static float4 fragment_uniform_buffer_0[129];
			static float4 fragment_uniform_buffer_1[8];
			static float4 fragment_uniform_buffer_2[5];
			static float4 fragment_uniform_buffer_3[3];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2D<float4> _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			Texture2D<float4> _BloodTex;
			Texture2D<float4> _BloodNrm;
			Texture2DArray<float4> _DecalPrepassTexture;
			SamplerState sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			SamplerState sampler_BloodTex;
			SamplerState sampler_BloodNrm;

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

			void discard_cond(bool fragment_unnamed_553)
			{
				if (fragment_unnamed_553)
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
				uint fragment_unnamed_68 = uint(gl_FragCoord.x);
				uint fragment_unnamed_69 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_70 = _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_68, fragment_unnamed_69, 0u), 0u));
				float fragment_unnamed_73 = fragment_unnamed_70.x;
				float fragment_unnamed_87 = mad(gl_FragCoord.x * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_91 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
				float fragment_unnamed_136 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_73, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_87, fragment_unnamed_91 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
				float fragment_unnamed_137 = (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_73, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_87, fragment_unnamed_91 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_136;
				float fragment_unnamed_138 = (mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_73, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_87, fragment_unnamed_91 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_136;
				float fragment_unnamed_139 = (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_73, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_87, fragment_unnamed_91 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_136;
				float fragment_unnamed_205;
				float fragment_unnamed_206;
				float fragment_unnamed_207;
				uint fragment_unnamed_208;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					float4 fragment_unnamed_148 = _DecalPrepassTexture.Load(int4(uint3(fragment_unnamed_68, fragment_unnamed_69, 0u), 0u));
					float fragment_unnamed_154 = mad(fragment_unnamed_148.z, 2.0f, -1.0f);
					float fragment_unnamed_155 = mad(fragment_unnamed_148.w, 2.0f, -1.0f);
					float fragment_unnamed_167 = ((-0.0f) - ((fragment_unnamed_155 < 0.0f) ? ((-0.0f) - fragment_unnamed_155) : fragment_unnamed_155)) + (((-0.0f) - ((fragment_unnamed_154 < 0.0f) ? ((-0.0f) - fragment_unnamed_154) : fragment_unnamed_154)) + 1.0f);
					float fragment_unnamed_169 = max((-0.0f) - fragment_unnamed_167, 0.0f);
					float fragment_unnamed_172 = (-0.0f) - fragment_unnamed_169;
					float fragment_unnamed_175 = fragment_unnamed_154 + ((fragment_unnamed_154 >= 0.0f) ? fragment_unnamed_172 : fragment_unnamed_169);
					float fragment_unnamed_176 = fragment_unnamed_155 + ((fragment_unnamed_155 >= 0.0f) ? fragment_unnamed_172 : fragment_unnamed_169);
					float fragment_unnamed_181 = rsqrt(dot(float3(fragment_unnamed_175, fragment_unnamed_176, fragment_unnamed_167), float3(fragment_unnamed_175, fragment_unnamed_176, fragment_unnamed_167)));
					fragment_unnamed_205 = fragment_unnamed_181 * fragment_unnamed_175;
					fragment_unnamed_206 = fragment_unnamed_181 * fragment_unnamed_176;
					fragment_unnamed_207 = fragment_unnamed_181 * fragment_unnamed_167;
					fragment_unnamed_208 = (((uint(fragment_unnamed_148.y * 255.5f) | (uint(fragment_unnamed_148.x * 255.5f) << 8u)) & asuint(fragment_uniform_buffer_2[4u]).x) != 0u) ? 1065353216u : 3212836864u;
				}
				else
				{
					fragment_unnamed_205 = asfloat(0u);
					fragment_unnamed_206 = asfloat(0u);
					fragment_unnamed_207 = asfloat(0u);
					fragment_unnamed_208 = 1065353216u;
				}
				float fragment_unnamed_280 = mad((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_unnamed_139, mad(fragment_uniform_buffer_1[4u].x, fragment_unnamed_137, fragment_unnamed_138 * fragment_uniform_buffer_1[5u].x)), 1.0f, 0.5f);
				float fragment_unnamed_282 = mad((mad(fragment_uniform_buffer_1[6u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].y)) + fragment_uniform_buffer_1[7u].y) + mad(fragment_uniform_buffer_1[6u].y, fragment_unnamed_139, mad(fragment_uniform_buffer_1[4u].y, fragment_unnamed_137, fragment_unnamed_138 * fragment_uniform_buffer_1[5u].y)), -1.0f, 0.5f);
				float fragment_unnamed_283 = mad((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_unnamed_139, mad(fragment_uniform_buffer_1[4u].z, fragment_unnamed_137, fragment_unnamed_138 * fragment_uniform_buffer_1[5u].z)), 1.0f, 0.5f);
				discard_cond(asfloat((((((0.0f < (((-0.0f) - fragment_unnamed_283) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_282) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_280) + 1.0f)) ? 4294967295u : 0u))) & (((0.0f < fragment_unnamed_283) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_282) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_280) ? 4294967295u : 0u)))) != 0u) ? fragment_unnamed_208 : asuint(asfloat(fragment_unnamed_208) + (-2.0f))) < 0.0f);
				float fragment_unnamed_329 = dot(float3(fragment_unnamed_205, fragment_unnamed_206, fragment_unnamed_207), float3(fragment_uniform_buffer_2[2u].xyz));
				float fragment_unnamed_356 = asfloat((asuint(fragment_uniform_buffer_0[128u]).w != 0u) ? ((0.0f < fragment_uniform_buffer_2[3u].y) ? asuint(clamp(mad(fragment_unnamed_329 * mad(fragment_unnamed_329, fragment_unnamed_329, 1.25f), fragment_uniform_buffer_2[3u].y, fragment_uniform_buffer_2[3u].z), 0.0f, 1.0f)) : 1065353216u) : 1065353216u) * clamp(fragment_uniform_buffer_2[3u].x, 0.0f, 1.0f);
				float fragment_unnamed_363 = mad(fragment_unnamed_280, fragment_uniform_buffer_2[0u].w, fragment_uniform_buffer_2[2u].w);
				float fragment_unnamed_370 = mad(fragment_unnamed_283, fragment_uniform_buffer_2[1u].w, fragment_uniform_buffer_2[3u].w);
				float fragment_unnamed_375 = fragment_uniform_buffer_0[80u].x * 0.100000001490116119384765625f;
				float4 fragment_unnamed_386 = _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D, float2(mad(fragment_unnamed_363, 0.300000011920928955078125f, fragment_unnamed_375), mad(fragment_unnamed_370, 0.300000011920928955078125f, fragment_unnamed_375)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_389 = fragment_unnamed_386.x;
				float fragment_unnamed_390 = fragment_unnamed_386.y;
				float4 fragment_unnamed_401 = _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D, float2(mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_unnamed_363), mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_unnamed_370)), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_436 = _BloodTex.SampleBias(sampler_BloodTex, float2(mad(fragment_uniform_buffer_3[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_389) + fragment_unnamed_401.x, 0.5f, fragment_unnamed_389)) + 1.0f), ((-0.0f) - fragment_unnamed_363) + 1.0f, (-0.0f) - fragment_unnamed_363) + 1.0f, fragment_unnamed_363), mad(fragment_uniform_buffer_3[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_390) + fragment_unnamed_401.y, 0.5f, fragment_unnamed_390)) + 1.0f), ((-0.0f) - fragment_unnamed_370) + 1.0f, (-0.0f) - fragment_unnamed_370) + 1.0f, fragment_unnamed_370)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_438 = fragment_unnamed_436.x;
				float fragment_unnamed_439 = fragment_unnamed_436.y;
				float fragment_unnamed_440 = fragment_unnamed_436.z;
				float fragment_unnamed_441 = fragment_unnamed_436.w;
				float4 fragment_unnamed_445 = _BloodTex.SampleBias(sampler_BloodTex, float2(fragment_unnamed_363, fragment_unnamed_370), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_447 = fragment_unnamed_445.x;
				float fragment_unnamed_448 = fragment_unnamed_445.y;
				float fragment_unnamed_449 = fragment_unnamed_445.z;
				float fragment_unnamed_450 = fragment_unnamed_445.w;
				float fragment_unnamed_459 = mad(((-0.0f) - fragment_unnamed_438) + fragment_unnamed_447, 0.00999999977648258209228515625f, fragment_unnamed_438);
				float fragment_unnamed_461 = mad(((-0.0f) - fragment_unnamed_439) + fragment_unnamed_448, 0.00999999977648258209228515625f, fragment_unnamed_439);
				float fragment_unnamed_462 = mad(((-0.0f) - fragment_unnamed_440) + fragment_unnamed_449, 0.00999999977648258209228515625f, fragment_unnamed_440);
				float fragment_unnamed_470 = mad(fragment_unnamed_450, ((-0.0f) - fragment_unnamed_459) + fragment_unnamed_447, fragment_unnamed_459);
				float fragment_unnamed_471 = mad(fragment_unnamed_450, ((-0.0f) - fragment_unnamed_461) + fragment_unnamed_448, fragment_unnamed_461);
				float fragment_unnamed_472 = mad(fragment_unnamed_450, ((-0.0f) - fragment_unnamed_462) + fragment_unnamed_449, fragment_unnamed_462);
				fragment_output_0.x = mad(fragment_unnamed_450, ((-0.0f) - fragment_unnamed_470) + fragment_unnamed_447, fragment_unnamed_470);
				fragment_output_0.y = mad(fragment_unnamed_450, ((-0.0f) - fragment_unnamed_471) + fragment_unnamed_448, fragment_unnamed_471);
				fragment_output_0.z = mad(fragment_unnamed_450, ((-0.0f) - fragment_unnamed_472) + fragment_unnamed_449, fragment_unnamed_472);
				float4 fragment_unnamed_494 = _BloodNrm.SampleBias(sampler_BloodNrm, float2(fragment_unnamed_363, fragment_unnamed_370), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_500 = mad(fragment_unnamed_494.x * fragment_unnamed_494.w, 2.0f, -1.0f);
				float fragment_unnamed_501 = mad(fragment_unnamed_494.y, 2.0f, -1.0f);
				float fragment_unnamed_509 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_500, fragment_unnamed_501), float2(fragment_unnamed_500, fragment_unnamed_501)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				fragment_output_0.w = fragment_unnamed_356 * mad(((-0.0f) - fragment_unnamed_450) + mad(((-0.0f) - fragment_unnamed_441) + fragment_unnamed_450, 0.00999999977648258209228515625f, fragment_unnamed_441), 0.2599999904632568359375f, fragment_unnamed_450);
				fragment_output_1.x = mad(mad(fragment_uniform_buffer_2[2u].x, fragment_unnamed_509, mad(fragment_uniform_buffer_2[0u].x, fragment_unnamed_500, fragment_unnamed_501 * fragment_uniform_buffer_2[1u].x)), 0.5f, 0.5f);
				fragment_output_1.y = mad(mad(fragment_uniform_buffer_2[2u].y, fragment_unnamed_509, mad(fragment_uniform_buffer_2[0u].y, fragment_unnamed_500, fragment_unnamed_501 * fragment_uniform_buffer_2[1u].y)), 0.5f, 0.5f);
				fragment_output_1.z = mad(mad(fragment_uniform_buffer_2[2u].z, fragment_unnamed_509, mad(fragment_uniform_buffer_2[0u].z, fragment_unnamed_500, fragment_unnamed_501 * fragment_uniform_buffer_2[1u].z)), 0.5f, 0.5f);
				fragment_output_1.w = 0.0f;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = 0.100000001490116119384765625f;
				fragment_output_2.w = fragment_unnamed_356;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

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

				fragment_uniform_buffer_3[2] = float4(_Background_Alpha, fragment_uniform_buffer_3[2][1], fragment_uniform_buffer_3[2][2], fragment_uniform_buffer_3[2][3]);

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
			#ifndef DECOMP_DECL_unity_BaseInstanceID
			#define DECOMP_DECL_unity_BaseInstanceID
			int unity_BaseInstanceID;
			#endif
			#ifndef DECOMP_DECL_unity_Builtins0Array
			#define DECOMP_DECL_unity_Builtins0Array
			cbuffer UnityInstancing_PerDraw0 { struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2]; };
			#endif

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
			#ifndef DECOMP_DECL_unity_BaseInstanceID
			#define DECOMP_DECL_unity_BaseInstanceID
			int unity_BaseInstanceID;
			#endif
			#ifndef DECOMP_DECL_unity_Builtins0Array
			#define DECOMP_DECL_unity_Builtins0Array
			cbuffer UnityInstancing_PerDraw0 { struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2]; };
			#endif
			#ifndef DECOMP_DECL_DecalArray
			#define DECOMP_DECL_DecalArray
			cbuffer UnityInstancing_Decal { struct { int _DecalLayerMaskFromDecal; float4x4 _NormalToWorld; } DecalArray[2]; };
			#endif

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
			#ifndef DECOMP_DECL_unity_BaseInstanceID
			#define DECOMP_DECL_unity_BaseInstanceID
			int unity_BaseInstanceID;
			#endif
			#ifndef DECOMP_DECL_unity_Builtins0Array
			#define DECOMP_DECL_unity_Builtins0Array
			cbuffer UnityInstancing_PerDraw0 { struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2]; };
			#endif

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


			float4 _TimeParameters;
			float _GlobalMipBias;
			#ifndef DECOMP_DECL_unity_BaseInstanceID
			#define DECOMP_DECL_unity_BaseInstanceID
			int unity_BaseInstanceID;
			#endif
			#ifndef DECOMP_DECL_unity_Builtins0Array
			#define DECOMP_DECL_unity_Builtins0Array
			cbuffer UnityInstancing_PerDraw0 { struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2]; };
			#endif
			#ifndef DECOMP_DECL_DecalArray
			#define DECOMP_DECL_DecalArray
			cbuffer UnityInstancing_Decal { struct { int _DecalLayerMaskFromDecal; float4x4 _NormalToWorld; } DecalArray[2]; };
			#endif
			float _Background_Alpha;

			static float4 fragment_uniform_buffer_0[129];
			static float4 fragment_uniform_buffer_1[1];
			static float4 fragment_uniform_buffer_2[16];
			static float4 fragment_uniform_buffer_3[10];
			static float4 fragment_uniform_buffer_4[3];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2D<float4> _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			Texture2D<float4> _BloodTex;
			Texture2D<float4> _BloodNrm;
			Texture2DArray<float4> _DecalPrepassTexture;
			SamplerState sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			SamplerState sampler_BloodTex;
			SamplerState sampler_BloodNrm;

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

			void discard_cond(bool fragment_unnamed_597)
			{
				if (fragment_unnamed_597)
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
				uint fragment_unnamed_76 = fragment_input_2 + asuint(fragment_uniform_buffer_1[0u]).x;
				uint fragment_unnamed_82 = uint(gl_FragCoord.x);
				uint fragment_unnamed_83 = uint(gl_FragCoord.y);
				float4 fragment_unnamed_84 = _CameraDepthTexture.Load(int4(uint3(fragment_unnamed_82, fragment_unnamed_83, 0u), 0u));
				float fragment_unnamed_87 = fragment_unnamed_84.x;
				float fragment_unnamed_100 = mad(gl_FragCoord.x * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
				float fragment_unnamed_104 = (-0.0f) - mad(gl_FragCoord.y * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
				float fragment_unnamed_149 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_87, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_100, fragment_unnamed_104 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
				float fragment_unnamed_150 = (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_87, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_100, fragment_unnamed_104 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_149;
				float fragment_unnamed_151 = (mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_87, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_100, fragment_unnamed_104 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_149;
				float fragment_unnamed_152 = (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_87, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_100, fragment_unnamed_104 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_149;
				float fragment_unnamed_223;
				float fragment_unnamed_224;
				float fragment_unnamed_225;
				float fragment_unnamed_226;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					float4 fragment_unnamed_162 = _DecalPrepassTexture.Load(int4(uint3(fragment_unnamed_82, fragment_unnamed_83, 0u), 0u));
					float fragment_unnamed_168 = mad(fragment_unnamed_162.z, 2.0f, -1.0f);
					float fragment_unnamed_169 = mad(fragment_unnamed_162.w, 2.0f, -1.0f);
					float fragment_unnamed_181 = ((-0.0f) - ((fragment_unnamed_169 < 0.0f) ? ((-0.0f) - fragment_unnamed_169) : fragment_unnamed_169)) + (((-0.0f) - ((fragment_unnamed_168 < 0.0f) ? ((-0.0f) - fragment_unnamed_168) : fragment_unnamed_168)) + 1.0f);
					float fragment_unnamed_183 = max((-0.0f) - fragment_unnamed_181, 0.0f);
					float fragment_unnamed_186 = (-0.0f) - fragment_unnamed_183;
					float fragment_unnamed_189 = fragment_unnamed_168 + ((fragment_unnamed_168 >= 0.0f) ? fragment_unnamed_186 : fragment_unnamed_183);
					float fragment_unnamed_190 = fragment_unnamed_169 + ((fragment_unnamed_169 >= 0.0f) ? fragment_unnamed_186 : fragment_unnamed_183);
					float fragment_unnamed_195 = rsqrt(dot(float3(fragment_unnamed_189, fragment_unnamed_190, fragment_unnamed_181), float3(fragment_unnamed_189, fragment_unnamed_190, fragment_unnamed_181)));
					fragment_unnamed_223 = fragment_unnamed_195 * fragment_unnamed_189;
					fragment_unnamed_224 = fragment_unnamed_195 * fragment_unnamed_190;
					fragment_unnamed_225 = fragment_unnamed_195 * fragment_unnamed_181;
					fragment_unnamed_226 = asfloat((((uint(fragment_unnamed_162.y * 255.5f) | (uint(fragment_unnamed_162.x * 255.5f) << 8u)) & asuint(fragment_uniform_buffer_3[(fragment_unnamed_76 * 5u) + 4u]).x) != 0u) ? 1065353216u : 3212836864u);
				}
				else
				{
					fragment_unnamed_223 = asfloat(0u);
					fragment_unnamed_224 = asfloat(0u);
					fragment_unnamed_225 = asfloat(0u);
					fragment_unnamed_226 = asfloat(1065353216u);
				}
				uint fragment_unnamed_227 = fragment_unnamed_76 << 3u;
				uint fragment_unnamed_232 = fragment_unnamed_227 + 5u;
				uint fragment_unnamed_241 = fragment_unnamed_227 + 4u;
				uint fragment_unnamed_253 = fragment_unnamed_227 + 6u;
				uint fragment_unnamed_266 = fragment_unnamed_227 + 7u;
				uint fragment_unnamed_276 = fragment_unnamed_227 + 5u;
				uint fragment_unnamed_285 = fragment_unnamed_227 + 4u;
				uint fragment_unnamed_294 = fragment_unnamed_227 + 6u;
				float fragment_unnamed_306 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_253].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_241].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_232].x)) + fragment_uniform_buffer_2[fragment_unnamed_266].x) + mad(fragment_uniform_buffer_2[fragment_unnamed_294].x, fragment_unnamed_152, mad(fragment_uniform_buffer_2[fragment_unnamed_285].x, fragment_unnamed_150, fragment_unnamed_151 * fragment_uniform_buffer_2[fragment_unnamed_276].x)), 1.0f, 0.5f);
				float fragment_unnamed_308 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_253].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_241].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_232].y)) + fragment_uniform_buffer_2[fragment_unnamed_266].y) + mad(fragment_uniform_buffer_2[fragment_unnamed_294].y, fragment_unnamed_152, mad(fragment_uniform_buffer_2[fragment_unnamed_285].y, fragment_unnamed_150, fragment_unnamed_151 * fragment_uniform_buffer_2[fragment_unnamed_276].y)), -1.0f, 0.5f);
				float fragment_unnamed_309 = mad((mad(fragment_uniform_buffer_2[fragment_unnamed_253].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_2[fragment_unnamed_241].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_2[fragment_unnamed_232].z)) + fragment_uniform_buffer_2[fragment_unnamed_266].z) + mad(fragment_uniform_buffer_2[fragment_unnamed_294].z, fragment_unnamed_152, mad(fragment_uniform_buffer_2[fragment_unnamed_285].z, fragment_unnamed_150, fragment_unnamed_151 * fragment_uniform_buffer_2[fragment_unnamed_276].z)), 1.0f, 0.5f);
				discard_cond(asfloat((((((0.0f < (((-0.0f) - fragment_unnamed_309) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_308) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_306) + 1.0f)) ? 4294967295u : 0u))) & (((0.0f < fragment_unnamed_309) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_308) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_306) ? 4294967295u : 0u)))) != 0u) ? asuint(fragment_unnamed_226) : asuint(fragment_unnamed_226 + (-2.0f))) < 0.0f);
				float fragment_unnamed_381;
				if (asuint(fragment_uniform_buffer_0[128u]).w != 0u)
				{
					uint fragment_unnamed_350 = fragment_unnamed_76 * 5u;
					float fragment_unnamed_382;
					if (0.0f < fragment_uniform_buffer_3[fragment_unnamed_350 + 3u].y)
					{
						float fragment_unnamed_364 = dot(float3(fragment_unnamed_223, fragment_unnamed_224, fragment_unnamed_225), float3(fragment_uniform_buffer_3[fragment_unnamed_350 + 2u].xyz));
						fragment_unnamed_382 = clamp(mad(fragment_unnamed_364 * mad(fragment_unnamed_364, fragment_unnamed_364, 1.25f), fragment_uniform_buffer_3[fragment_unnamed_350 + 3u].y, fragment_uniform_buffer_3[fragment_unnamed_350 + 3u].z), 0.0f, 1.0f);
					}
					else
					{
						fragment_unnamed_382 = asfloat(1065353216u);
					}
					fragment_unnamed_381 = fragment_unnamed_382;
				}
				else
				{
					fragment_unnamed_381 = asfloat(1065353216u);
				}
				uint fragment_unnamed_383 = fragment_unnamed_76 * 5u;
				float fragment_unnamed_389 = fragment_unnamed_381 * clamp(fragment_uniform_buffer_3[fragment_unnamed_383 + 3u].x, 0.0f, 1.0f);
				float fragment_unnamed_397 = mad(fragment_unnamed_306, fragment_uniform_buffer_3[fragment_unnamed_383].w, fragment_uniform_buffer_3[fragment_unnamed_383 + 2u].w);
				float fragment_unnamed_406 = mad(fragment_unnamed_309, fragment_uniform_buffer_3[fragment_unnamed_383 + 1u].w, fragment_uniform_buffer_3[fragment_unnamed_383 + 3u].w);
				float fragment_unnamed_411 = fragment_uniform_buffer_0[80u].x * 0.100000001490116119384765625f;
				float4 fragment_unnamed_422 = _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D, float2(mad(fragment_unnamed_397, 0.300000011920928955078125f, fragment_unnamed_411), mad(fragment_unnamed_406, 0.300000011920928955078125f, fragment_unnamed_411)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_425 = fragment_unnamed_422.x;
				float fragment_unnamed_426 = fragment_unnamed_422.y;
				float4 fragment_unnamed_437 = _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D, float2(mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_unnamed_397), mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_unnamed_406)), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_472 = _BloodTex.SampleBias(sampler_BloodTex, float2(mad(fragment_uniform_buffer_4[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_425) + fragment_unnamed_437.x, 0.5f, fragment_unnamed_425)) + 1.0f), ((-0.0f) - fragment_unnamed_397) + 1.0f, (-0.0f) - fragment_unnamed_397) + 1.0f, fragment_unnamed_397), mad(fragment_uniform_buffer_4[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_426) + fragment_unnamed_437.y, 0.5f, fragment_unnamed_426)) + 1.0f), ((-0.0f) - fragment_unnamed_406) + 1.0f, (-0.0f) - fragment_unnamed_406) + 1.0f, fragment_unnamed_406)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_474 = fragment_unnamed_472.x;
				float fragment_unnamed_475 = fragment_unnamed_472.y;
				float fragment_unnamed_476 = fragment_unnamed_472.z;
				float fragment_unnamed_477 = fragment_unnamed_472.w;
				float4 fragment_unnamed_481 = _BloodTex.SampleBias(sampler_BloodTex, float2(fragment_unnamed_397, fragment_unnamed_406), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_483 = fragment_unnamed_481.x;
				float fragment_unnamed_484 = fragment_unnamed_481.y;
				float fragment_unnamed_485 = fragment_unnamed_481.z;
				float fragment_unnamed_486 = fragment_unnamed_481.w;
				float fragment_unnamed_495 = mad(((-0.0f) - fragment_unnamed_474) + fragment_unnamed_483, 0.00999999977648258209228515625f, fragment_unnamed_474);
				float fragment_unnamed_497 = mad(((-0.0f) - fragment_unnamed_475) + fragment_unnamed_484, 0.00999999977648258209228515625f, fragment_unnamed_475);
				float fragment_unnamed_498 = mad(((-0.0f) - fragment_unnamed_476) + fragment_unnamed_485, 0.00999999977648258209228515625f, fragment_unnamed_476);
				float fragment_unnamed_506 = mad(fragment_unnamed_486, ((-0.0f) - fragment_unnamed_495) + fragment_unnamed_483, fragment_unnamed_495);
				float fragment_unnamed_507 = mad(fragment_unnamed_486, ((-0.0f) - fragment_unnamed_497) + fragment_unnamed_484, fragment_unnamed_497);
				float fragment_unnamed_508 = mad(fragment_unnamed_486, ((-0.0f) - fragment_unnamed_498) + fragment_unnamed_485, fragment_unnamed_498);
				fragment_output_0.x = mad(fragment_unnamed_486, ((-0.0f) - fragment_unnamed_506) + fragment_unnamed_483, fragment_unnamed_506);
				fragment_output_0.y = mad(fragment_unnamed_486, ((-0.0f) - fragment_unnamed_507) + fragment_unnamed_484, fragment_unnamed_507);
				fragment_output_0.z = mad(fragment_unnamed_486, ((-0.0f) - fragment_unnamed_508) + fragment_unnamed_485, fragment_unnamed_508);
				float4 fragment_unnamed_530 = _BloodNrm.SampleBias(sampler_BloodNrm, float2(fragment_unnamed_397, fragment_unnamed_406), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_536 = mad(fragment_unnamed_530.x * fragment_unnamed_530.w, 2.0f, -1.0f);
				float fragment_unnamed_537 = mad(fragment_unnamed_530.y, 2.0f, -1.0f);
				float fragment_unnamed_545 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_536, fragment_unnamed_537), float2(fragment_unnamed_536, fragment_unnamed_537)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				fragment_output_0.w = fragment_unnamed_389 * mad(((-0.0f) - fragment_unnamed_486) + mad(((-0.0f) - fragment_unnamed_477) + fragment_unnamed_486, 0.00999999977648258209228515625f, fragment_unnamed_477), 0.2599999904632568359375f, fragment_unnamed_486);
				uint fragment_unnamed_549 = fragment_unnamed_383 + 1u;
				uint fragment_unnamed_566 = fragment_unnamed_383 + 2u;
				fragment_output_1.x = mad(mad(fragment_uniform_buffer_3[fragment_unnamed_566].x, fragment_unnamed_545, mad(fragment_uniform_buffer_3[fragment_unnamed_383].x, fragment_unnamed_536, fragment_unnamed_537 * fragment_uniform_buffer_3[fragment_unnamed_549].x)), 0.5f, 0.5f);
				fragment_output_1.y = mad(mad(fragment_uniform_buffer_3[fragment_unnamed_566].y, fragment_unnamed_545, mad(fragment_uniform_buffer_3[fragment_unnamed_383].y, fragment_unnamed_536, fragment_unnamed_537 * fragment_uniform_buffer_3[fragment_unnamed_549].y)), 0.5f, 0.5f);
				fragment_output_1.z = mad(mad(fragment_uniform_buffer_3[fragment_unnamed_566].z, fragment_unnamed_545, mad(fragment_uniform_buffer_3[fragment_unnamed_383].z, fragment_unnamed_536, fragment_unnamed_537 * fragment_uniform_buffer_3[fragment_unnamed_549].z)), 0.5f, 0.5f);
				fragment_output_1.w = 0.0f;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = 0.100000001490116119384765625f;
				fragment_output_2.w = fragment_unnamed_389;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

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

				fragment_uniform_buffer_4[2] = float4(_Background_Alpha, fragment_uniform_buffer_4[2][1], fragment_uniform_buffer_4[2][2], fragment_uniform_buffer_4[2][3]);

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
			GpuProgramID 112375

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
			static float4 vertex_uniform_buffer_2[6];
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
				uint vertex_unnamed_172 = (vertex_uniform_buffer_2[5u].y == 1.0f) ? 4294967295u : 0u;
				float vertex_unnamed_182 = vertex_unnamed_89 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_103) * vertex_uniform_buffer_2[5u].w) & vertex_unnamed_172);
				float vertex_unnamed_183 = vertex_unnamed_119 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_126) * vertex_uniform_buffer_2[5u].w) & vertex_unnamed_172);
				float vertex_unnamed_184 = vertex_unnamed_142 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_149) * vertex_uniform_buffer_2[5u].w) & vertex_unnamed_172);
				vertex_output_3.x = vertex_unnamed_182;
				vertex_output_3.y = vertex_unnamed_183;
				vertex_output_3.z = vertex_unnamed_184;
				float vertex_unnamed_231 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_182, vertex_unnamed_183 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_2[5u].y == 0.0f) ? (vertex_unnamed_231 + ((-0.0f) - vertex_uniform_buffer_2[5u].z)) : vertex_unnamed_231;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_182, vertex_unnamed_183 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_182, vertex_unnamed_183 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_182, vertex_unnamed_183 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_270 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_271 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_272 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_278 = rsqrt(max(dot(float3(vertex_unnamed_270, vertex_unnamed_271, vertex_unnamed_272), float3(vertex_unnamed_270, vertex_unnamed_271, vertex_unnamed_272)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_278 * vertex_unnamed_270;
				vertex_output_1.y = vertex_unnamed_278 * vertex_unnamed_271;
				vertex_output_1.z = vertex_unnamed_278 * vertex_unnamed_272;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				float vertex_unnamed_312 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_326 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_340 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_347 = rsqrt(max(dot(float3(vertex_unnamed_312, vertex_unnamed_326, vertex_unnamed_340), float3(vertex_unnamed_312, vertex_unnamed_326, vertex_unnamed_340)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_347 * vertex_unnamed_312;
				vertex_output_4.y = vertex_unnamed_347 * vertex_unnamed_326;
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

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], _DecalMeshBiasType, vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], vertex_uniform_buffer_2[5][1], _DecalMeshDepthBias, vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], vertex_uniform_buffer_2[5][1], vertex_uniform_buffer_2[5][2], _DecalMeshViewBias);

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
			static float4 vertex_uniform_buffer_2[6];
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
				uint vertex_unnamed_172 = (vertex_uniform_buffer_2[5u].y == 1.0f) ? 4294967295u : 0u;
				float vertex_unnamed_182 = vertex_unnamed_89 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_103) * vertex_uniform_buffer_2[5u].w) & vertex_unnamed_172);
				float vertex_unnamed_183 = vertex_unnamed_119 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_126) * vertex_uniform_buffer_2[5u].w) & vertex_unnamed_172);
				float vertex_unnamed_184 = vertex_unnamed_142 + asfloat(asuint((vertex_unnamed_154 * vertex_unnamed_149) * vertex_uniform_buffer_2[5u].w) & vertex_unnamed_172);
				vertex_output_3.x = vertex_unnamed_182;
				vertex_output_3.y = vertex_unnamed_183;
				vertex_output_3.z = vertex_unnamed_184;
				float vertex_unnamed_231 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_182, vertex_unnamed_183 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_2[5u].y == 0.0f) ? (vertex_unnamed_231 + ((-0.0f) - vertex_uniform_buffer_2[5u].z)) : vertex_unnamed_231;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_182, vertex_unnamed_183 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_182, vertex_unnamed_183 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_182, vertex_unnamed_183 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_270 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_271 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_272 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_278 = rsqrt(max(dot(float3(vertex_unnamed_270, vertex_unnamed_271, vertex_unnamed_272), float3(vertex_unnamed_270, vertex_unnamed_271, vertex_unnamed_272)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_278 * vertex_unnamed_270;
				vertex_output_1.y = vertex_unnamed_278 * vertex_unnamed_271;
				vertex_output_1.z = vertex_unnamed_278 * vertex_unnamed_272;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				float vertex_unnamed_312 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_326 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_340 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_347 = rsqrt(max(dot(float3(vertex_unnamed_312, vertex_unnamed_326, vertex_unnamed_340), float3(vertex_unnamed_312, vertex_unnamed_326, vertex_unnamed_340)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_347 * vertex_unnamed_312;
				vertex_output_4.y = vertex_unnamed_347 * vertex_unnamed_326;
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

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], _DecalMeshBiasType, vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], vertex_uniform_buffer_2[5][1], _DecalMeshDepthBias, vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], vertex_uniform_buffer_2[5][1], vertex_uniform_buffer_2[5][2], _DecalMeshViewBias);

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


			float4 _TimeParameters;
			float _GlobalMipBias;
			float4 unity_WorldTransformParams;
			float _Background_Alpha;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			static float4 fragment_uniform_buffer_2[3];
			Texture2D<float4> _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			Texture2D<float4> _BloodTex;
			Texture2D<float4> _BloodNrm;
			SamplerState sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			SamplerState sampler_BloodTex;
			SamplerState sampler_BloodNrm;

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
				float4 fragment_unnamed_79 = _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D, float2(mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_2.x), mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_2.y)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_87 = fragment_uniform_buffer_0[80u].x * 0.100000001490116119384765625f;
				float4 fragment_unnamed_100 = _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D, float2(mad(fragment_input_2.x, 0.300000011920928955078125f, fragment_unnamed_87), mad(fragment_input_2.y, 0.300000011920928955078125f, fragment_unnamed_87)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_102 = fragment_unnamed_100.x;
				float fragment_unnamed_103 = fragment_unnamed_100.y;
				float4 fragment_unnamed_151 = _BloodTex.SampleBias(sampler_BloodTex, float2(mad(fragment_uniform_buffer_2[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_102) + fragment_unnamed_79.x, 0.5f, fragment_unnamed_102)) + 1.0f), ((-0.0f) - fragment_input_2.x) + 1.0f, (-0.0f) - fragment_input_2.x) + 1.0f, fragment_input_2.x), mad(fragment_uniform_buffer_2[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_103) + fragment_unnamed_79.y, 0.5f, fragment_unnamed_103)) + 1.0f), ((-0.0f) - fragment_input_2.y) + 1.0f, (-0.0f) - fragment_input_2.y) + 1.0f, fragment_input_2.y)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_153 = fragment_unnamed_151.x;
				float fragment_unnamed_154 = fragment_unnamed_151.y;
				float fragment_unnamed_155 = fragment_unnamed_151.z;
				float fragment_unnamed_156 = fragment_unnamed_151.w;
				float4 fragment_unnamed_164 = _BloodTex.SampleBias(sampler_BloodTex, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_166 = fragment_unnamed_164.x;
				float fragment_unnamed_167 = fragment_unnamed_164.y;
				float fragment_unnamed_168 = fragment_unnamed_164.z;
				float fragment_unnamed_169 = fragment_unnamed_164.w;
				float fragment_unnamed_178 = mad(((-0.0f) - fragment_unnamed_153) + fragment_unnamed_166, 0.00999999977648258209228515625f, fragment_unnamed_153);
				float fragment_unnamed_180 = mad(((-0.0f) - fragment_unnamed_154) + fragment_unnamed_167, 0.00999999977648258209228515625f, fragment_unnamed_154);
				float fragment_unnamed_181 = mad(((-0.0f) - fragment_unnamed_155) + fragment_unnamed_168, 0.00999999977648258209228515625f, fragment_unnamed_155);
				float fragment_unnamed_189 = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_178) + fragment_unnamed_166, fragment_unnamed_178);
				float fragment_unnamed_190 = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_180) + fragment_unnamed_167, fragment_unnamed_180);
				float fragment_unnamed_191 = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_181) + fragment_unnamed_168, fragment_unnamed_181);
				fragment_output_0.w = mad(((-0.0f) - fragment_unnamed_169) + mad(((-0.0f) - fragment_unnamed_156) + fragment_unnamed_169, 0.00999999977648258209228515625f, fragment_unnamed_156), 0.2599999904632568359375f, fragment_unnamed_169);
				fragment_output_0.x = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_189) + fragment_unnamed_166, fragment_unnamed_189);
				fragment_output_0.y = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_190) + fragment_unnamed_167, fragment_unnamed_190);
				fragment_output_0.z = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_191) + fragment_unnamed_168, fragment_unnamed_191);
				float fragment_unnamed_226 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_281 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float4 fragment_unnamed_293 = _BloodNrm.SampleBias(sampler_BloodNrm, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_299 = mad(fragment_unnamed_293.x * fragment_unnamed_293.w, 2.0f, -1.0f);
				float fragment_unnamed_302 = mad(fragment_unnamed_293.y, 2.0f, -1.0f);
				float fragment_unnamed_334 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_299, fragment_unnamed_302), float2(fragment_unnamed_299, fragment_unnamed_302)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_336 = mad(fragment_unnamed_334, fragment_unnamed_281 * fragment_input_4.x, mad(fragment_unnamed_299, fragment_unnamed_281 * fragment_input_1.x, (fragment_unnamed_281 * (fragment_unnamed_226 * mad(fragment_input_4.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_4.z)))) * fragment_unnamed_302));
				float fragment_unnamed_337 = mad(fragment_unnamed_334, fragment_unnamed_281 * fragment_input_4.y, mad(fragment_unnamed_299, fragment_unnamed_281 * fragment_input_1.y, (fragment_unnamed_281 * (fragment_unnamed_226 * mad(fragment_input_4.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_4.x)))) * fragment_unnamed_302));
				float fragment_unnamed_338 = mad(fragment_unnamed_334, fragment_unnamed_281 * fragment_input_4.z, mad(fragment_unnamed_299, fragment_unnamed_281 * fragment_input_1.z, (fragment_unnamed_281 * (fragment_unnamed_226 * mad(fragment_input_4.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_4.y)))) * fragment_unnamed_302));
				float fragment_unnamed_342 = rsqrt(dot(float3(fragment_unnamed_336, fragment_unnamed_337, fragment_unnamed_338), float3(fragment_unnamed_336, fragment_unnamed_337, fragment_unnamed_338)));
				fragment_output_1.x = mad(fragment_unnamed_342 * fragment_unnamed_336, 0.5f, 0.5f);
				fragment_output_1.y = mad(fragment_unnamed_342 * fragment_unnamed_337, 0.5f, 0.5f);
				fragment_output_1.z = mad(fragment_unnamed_342 * fragment_unnamed_338, 0.5f, 0.5f);
				fragment_output_1.w = 0.0f;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = 0.100000001490116119384765625f;
				fragment_output_2.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[2] = float4(_Background_Alpha, fragment_uniform_buffer_2[2][1], fragment_uniform_buffer_2[2][2], fragment_uniform_buffer_2[2][3]);

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
			#ifndef DECOMP_DECL_unity_BaseInstanceID
			#define DECOMP_DECL_unity_BaseInstanceID
			int unity_BaseInstanceID;
			#endif
			#ifndef DECOMP_DECL_unity_Builtins0Array
			#define DECOMP_DECL_unity_Builtins0Array
			cbuffer UnityInstancing_PerDraw0 { struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2]; };
			#endif
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;

			static float4 vertex_uniform_buffer_0[61];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[16];
			static float4 vertex_uniform_buffer_3[6];
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
				float vertex_unnamed_195;
				float vertex_unnamed_196;
				float vertex_unnamed_197;
				if (vertex_uniform_buffer_3[5u].y == 1.0f)
				{
					uint vertex_unnamed_67 = vertex_unnamed_57 << 3u;
					uint vertex_unnamed_79 = vertex_unnamed_67 + 3u;
					float vertex_unnamed_113 = asfloat(1065353216u);
					bool vertex_unnamed_162 = vertex_uniform_buffer_0[60u].w == 0.0f;
					float vertex_unnamed_167 = vertex_unnamed_162 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_79].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_113))) : vertex_uniform_buffer_0[0u].z;
					float vertex_unnamed_172 = vertex_unnamed_162 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_79].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_113))) : vertex_uniform_buffer_0[1u].z;
					float vertex_unnamed_177 = vertex_unnamed_162 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_79].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_113))) : vertex_uniform_buffer_0[2u].z;
					float vertex_unnamed_182 = rsqrt(dot(float3(vertex_unnamed_167, vertex_unnamed_172, vertex_unnamed_177), float3(vertex_unnamed_167, vertex_unnamed_172, vertex_unnamed_177)));
					vertex_unnamed_195 = (vertex_unnamed_182 * vertex_unnamed_177) * vertex_uniform_buffer_3[5u].w;
					vertex_unnamed_196 = (vertex_unnamed_182 * vertex_unnamed_172) * vertex_uniform_buffer_3[5u].w;
					vertex_unnamed_197 = (vertex_unnamed_182 * vertex_unnamed_167) * vertex_uniform_buffer_3[5u].w;
				}
				else
				{
					vertex_unnamed_195 = asfloat(0u);
					vertex_unnamed_196 = asfloat(0u);
					vertex_unnamed_197 = asfloat(0u);
				}
				uint vertex_unnamed_198 = vertex_unnamed_57 << 3u;
				uint vertex_unnamed_207 = vertex_unnamed_198 + 3u;
				float vertex_unnamed_239 = asfloat(1065353216u);
				float vertex_unnamed_283 = vertex_unnamed_197 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_207].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_239));
				float vertex_unnamed_284 = vertex_unnamed_196 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_207].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_239));
				float vertex_unnamed_285 = vertex_unnamed_195 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_207].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_239));
				float vertex_unnamed_299 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_198 + 4u].xyz));
				float vertex_unnamed_314 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_198 + 5u].xyz));
				float vertex_unnamed_329 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_198 + 6u].xyz));
				float vertex_unnamed_337 = rsqrt(max(dot(float3(vertex_unnamed_299, vertex_unnamed_314, vertex_unnamed_329), float3(vertex_unnamed_299, vertex_unnamed_314, vertex_unnamed_329)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_337 * vertex_unnamed_299;
				vertex_output_4.y = vertex_unnamed_337 * vertex_unnamed_314;
				vertex_output_4.z = vertex_unnamed_337 * vertex_unnamed_329;
				uint vertex_unnamed_347 = vertex_unnamed_198 + 1u;
				uint vertex_unnamed_366 = vertex_unnamed_198 + 2u;
				float vertex_unnamed_374 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_198].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].x));
				float vertex_unnamed_375 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_198].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].y));
				float vertex_unnamed_376 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_198].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].z));
				float vertex_unnamed_381 = rsqrt(max(dot(float3(vertex_unnamed_374, vertex_unnamed_375, vertex_unnamed_376), float3(vertex_unnamed_374, vertex_unnamed_375, vertex_unnamed_376)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_374 * vertex_unnamed_381;
				vertex_output_1.y = vertex_unnamed_375 * vertex_unnamed_381;
				vertex_output_1.z = vertex_unnamed_376 * vertex_unnamed_381;
				float vertex_unnamed_430 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_285, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_283, vertex_unnamed_284 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_3[5u].y == 0.0f) ? (vertex_unnamed_430 + ((-0.0f) - vertex_uniform_buffer_3[5u].z)) : vertex_unnamed_430;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_285, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_283, vertex_unnamed_284 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_285, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_283, vertex_unnamed_284 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_285, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_283, vertex_unnamed_284 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				vertex_output_3.x = vertex_unnamed_283;
				vertex_output_3.y = vertex_unnamed_284;
				vertex_output_3.z = vertex_unnamed_285;
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

				vertex_uniform_buffer_3[5] = float4(vertex_uniform_buffer_3[5][0], _DecalMeshBiasType, vertex_uniform_buffer_3[5][2], vertex_uniform_buffer_3[5][3]);

				vertex_uniform_buffer_3[5] = float4(vertex_uniform_buffer_3[5][0], vertex_uniform_buffer_3[5][1], _DecalMeshDepthBias, vertex_uniform_buffer_3[5][3]);

				vertex_uniform_buffer_3[5] = float4(vertex_uniform_buffer_3[5][0], vertex_uniform_buffer_3[5][1], vertex_uniform_buffer_3[5][2], _DecalMeshViewBias);

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
			#ifndef DECOMP_DECL_unity_BaseInstanceID
			#define DECOMP_DECL_unity_BaseInstanceID
			int unity_BaseInstanceID;
			#endif
			#ifndef DECOMP_DECL_unity_Builtins0Array
			#define DECOMP_DECL_unity_Builtins0Array
			cbuffer UnityInstancing_PerDraw0 { struct { float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2]; };
			#endif
			float _DecalMeshBiasType;
			float _DecalMeshDepthBias;
			float _DecalMeshViewBias;

			static float4 vertex_uniform_buffer_0[61];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[16];
			static float4 vertex_uniform_buffer_3[6];
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
				float vertex_unnamed_195;
				float vertex_unnamed_196;
				float vertex_unnamed_197;
				if (vertex_uniform_buffer_3[5u].y == 1.0f)
				{
					uint vertex_unnamed_67 = vertex_unnamed_57 << 3u;
					uint vertex_unnamed_79 = vertex_unnamed_67 + 3u;
					float vertex_unnamed_113 = asfloat(1065353216u);
					bool vertex_unnamed_162 = vertex_uniform_buffer_0[60u].w == 0.0f;
					float vertex_unnamed_167 = vertex_unnamed_162 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_79].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_113))) : vertex_uniform_buffer_0[0u].z;
					float vertex_unnamed_172 = vertex_unnamed_162 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_79].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_113))) : vertex_uniform_buffer_0[1u].z;
					float vertex_unnamed_177 = vertex_unnamed_162 ? ((-0.0f) - dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_79].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_113))) : vertex_uniform_buffer_0[2u].z;
					float vertex_unnamed_182 = rsqrt(dot(float3(vertex_unnamed_167, vertex_unnamed_172, vertex_unnamed_177), float3(vertex_unnamed_167, vertex_unnamed_172, vertex_unnamed_177)));
					vertex_unnamed_195 = (vertex_unnamed_182 * vertex_unnamed_177) * vertex_uniform_buffer_3[5u].w;
					vertex_unnamed_196 = (vertex_unnamed_182 * vertex_unnamed_172) * vertex_uniform_buffer_3[5u].w;
					vertex_unnamed_197 = (vertex_unnamed_182 * vertex_unnamed_167) * vertex_uniform_buffer_3[5u].w;
				}
				else
				{
					vertex_unnamed_195 = asfloat(0u);
					vertex_unnamed_196 = asfloat(0u);
					vertex_unnamed_197 = asfloat(0u);
				}
				uint vertex_unnamed_198 = vertex_unnamed_57 << 3u;
				uint vertex_unnamed_207 = vertex_unnamed_198 + 3u;
				float vertex_unnamed_239 = asfloat(1065353216u);
				float vertex_unnamed_283 = vertex_unnamed_197 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_207].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_239));
				float vertex_unnamed_284 = vertex_unnamed_196 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_207].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_239));
				float vertex_unnamed_285 = vertex_unnamed_195 + dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_198 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_207].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_239));
				float vertex_unnamed_299 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_198 + 4u].xyz));
				float vertex_unnamed_314 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_198 + 5u].xyz));
				float vertex_unnamed_329 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_198 + 6u].xyz));
				float vertex_unnamed_337 = rsqrt(max(dot(float3(vertex_unnamed_299, vertex_unnamed_314, vertex_unnamed_329), float3(vertex_unnamed_299, vertex_unnamed_314, vertex_unnamed_329)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_337 * vertex_unnamed_299;
				vertex_output_4.y = vertex_unnamed_337 * vertex_unnamed_314;
				vertex_output_4.z = vertex_unnamed_337 * vertex_unnamed_329;
				uint vertex_unnamed_347 = vertex_unnamed_198 + 1u;
				uint vertex_unnamed_366 = vertex_unnamed_198 + 2u;
				float vertex_unnamed_374 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_198].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].x));
				float vertex_unnamed_375 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_198].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].y));
				float vertex_unnamed_376 = mad(vertex_uniform_buffer_2[vertex_unnamed_366].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_198].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_347].z));
				float vertex_unnamed_381 = rsqrt(max(dot(float3(vertex_unnamed_374, vertex_unnamed_375, vertex_unnamed_376), float3(vertex_unnamed_374, vertex_unnamed_375, vertex_unnamed_376)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_374 * vertex_unnamed_381;
				vertex_output_1.y = vertex_unnamed_375 * vertex_unnamed_381;
				vertex_output_1.z = vertex_unnamed_376 * vertex_unnamed_381;
				float vertex_unnamed_430 = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_285, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_283, vertex_unnamed_284 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.z = (vertex_uniform_buffer_3[5u].y == 0.0f) ? (vertex_unnamed_430 + ((-0.0f) - vertex_uniform_buffer_3[5u].z)) : vertex_unnamed_430;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_285, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_283, vertex_unnamed_284 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_285, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_283, vertex_unnamed_284 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_285, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_283, vertex_unnamed_284 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				vertex_output_3.x = vertex_unnamed_283;
				vertex_output_3.y = vertex_unnamed_284;
				vertex_output_3.z = vertex_unnamed_285;
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

				vertex_uniform_buffer_3[5] = float4(vertex_uniform_buffer_3[5][0], _DecalMeshBiasType, vertex_uniform_buffer_3[5][2], vertex_uniform_buffer_3[5][3]);

				vertex_uniform_buffer_3[5] = float4(vertex_uniform_buffer_3[5][0], vertex_uniform_buffer_3[5][1], _DecalMeshDepthBias, vertex_uniform_buffer_3[5][3]);

				vertex_uniform_buffer_3[5] = float4(vertex_uniform_buffer_3[5][0], vertex_uniform_buffer_3[5][1], vertex_uniform_buffer_3[5][2], _DecalMeshViewBias);

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


			float4 _TimeParameters;
			float _GlobalMipBias;
			float4 unity_WorldTransformParams;
			float _Background_Alpha;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			static float4 fragment_uniform_buffer_2[3];
			Texture2D<float4> _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			Texture2D<float4> _BloodTex;
			Texture2D<float4> _BloodNrm;
			SamplerState sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			SamplerState sampler_BloodTex;
			SamplerState sampler_BloodNrm;

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
				float4 fragment_unnamed_79 = _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D, float2(mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_2.x), mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_2.y)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_87 = fragment_uniform_buffer_0[80u].x * 0.100000001490116119384765625f;
				float4 fragment_unnamed_100 = _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D, float2(mad(fragment_input_2.x, 0.300000011920928955078125f, fragment_unnamed_87), mad(fragment_input_2.y, 0.300000011920928955078125f, fragment_unnamed_87)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_102 = fragment_unnamed_100.x;
				float fragment_unnamed_103 = fragment_unnamed_100.y;
				float4 fragment_unnamed_151 = _BloodTex.SampleBias(sampler_BloodTex, float2(mad(fragment_uniform_buffer_2[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_102) + fragment_unnamed_79.x, 0.5f, fragment_unnamed_102)) + 1.0f), ((-0.0f) - fragment_input_2.x) + 1.0f, (-0.0f) - fragment_input_2.x) + 1.0f, fragment_input_2.x), mad(fragment_uniform_buffer_2[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_103) + fragment_unnamed_79.y, 0.5f, fragment_unnamed_103)) + 1.0f), ((-0.0f) - fragment_input_2.y) + 1.0f, (-0.0f) - fragment_input_2.y) + 1.0f, fragment_input_2.y)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_153 = fragment_unnamed_151.x;
				float fragment_unnamed_154 = fragment_unnamed_151.y;
				float fragment_unnamed_155 = fragment_unnamed_151.z;
				float fragment_unnamed_156 = fragment_unnamed_151.w;
				float4 fragment_unnamed_164 = _BloodTex.SampleBias(sampler_BloodTex, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_166 = fragment_unnamed_164.x;
				float fragment_unnamed_167 = fragment_unnamed_164.y;
				float fragment_unnamed_168 = fragment_unnamed_164.z;
				float fragment_unnamed_169 = fragment_unnamed_164.w;
				float fragment_unnamed_178 = mad(((-0.0f) - fragment_unnamed_153) + fragment_unnamed_166, 0.00999999977648258209228515625f, fragment_unnamed_153);
				float fragment_unnamed_180 = mad(((-0.0f) - fragment_unnamed_154) + fragment_unnamed_167, 0.00999999977648258209228515625f, fragment_unnamed_154);
				float fragment_unnamed_181 = mad(((-0.0f) - fragment_unnamed_155) + fragment_unnamed_168, 0.00999999977648258209228515625f, fragment_unnamed_155);
				float fragment_unnamed_189 = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_178) + fragment_unnamed_166, fragment_unnamed_178);
				float fragment_unnamed_190 = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_180) + fragment_unnamed_167, fragment_unnamed_180);
				float fragment_unnamed_191 = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_181) + fragment_unnamed_168, fragment_unnamed_181);
				fragment_output_0.w = mad(((-0.0f) - fragment_unnamed_169) + mad(((-0.0f) - fragment_unnamed_156) + fragment_unnamed_169, 0.00999999977648258209228515625f, fragment_unnamed_156), 0.2599999904632568359375f, fragment_unnamed_169);
				fragment_output_0.x = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_189) + fragment_unnamed_166, fragment_unnamed_189);
				fragment_output_0.y = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_190) + fragment_unnamed_167, fragment_unnamed_190);
				fragment_output_0.z = mad(fragment_unnamed_169, ((-0.0f) - fragment_unnamed_191) + fragment_unnamed_168, fragment_unnamed_191);
				float fragment_unnamed_226 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_281 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float4 fragment_unnamed_293 = _BloodNrm.SampleBias(sampler_BloodNrm, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_299 = mad(fragment_unnamed_293.x * fragment_unnamed_293.w, 2.0f, -1.0f);
				float fragment_unnamed_302 = mad(fragment_unnamed_293.y, 2.0f, -1.0f);
				float fragment_unnamed_334 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_299, fragment_unnamed_302), float2(fragment_unnamed_299, fragment_unnamed_302)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_336 = mad(fragment_unnamed_334, fragment_unnamed_281 * fragment_input_4.x, mad(fragment_unnamed_299, fragment_unnamed_281 * fragment_input_1.x, (fragment_unnamed_281 * (fragment_unnamed_226 * mad(fragment_input_4.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_4.z)))) * fragment_unnamed_302));
				float fragment_unnamed_337 = mad(fragment_unnamed_334, fragment_unnamed_281 * fragment_input_4.y, mad(fragment_unnamed_299, fragment_unnamed_281 * fragment_input_1.y, (fragment_unnamed_281 * (fragment_unnamed_226 * mad(fragment_input_4.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_4.x)))) * fragment_unnamed_302));
				float fragment_unnamed_338 = mad(fragment_unnamed_334, fragment_unnamed_281 * fragment_input_4.z, mad(fragment_unnamed_299, fragment_unnamed_281 * fragment_input_1.z, (fragment_unnamed_281 * (fragment_unnamed_226 * mad(fragment_input_4.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_4.y)))) * fragment_unnamed_302));
				float fragment_unnamed_342 = rsqrt(dot(float3(fragment_unnamed_336, fragment_unnamed_337, fragment_unnamed_338), float3(fragment_unnamed_336, fragment_unnamed_337, fragment_unnamed_338)));
				fragment_output_1.x = mad(fragment_unnamed_342 * fragment_unnamed_336, 0.5f, 0.5f);
				fragment_output_1.y = mad(fragment_unnamed_342 * fragment_unnamed_337, 0.5f, 0.5f);
				fragment_output_1.z = mad(fragment_unnamed_342 * fragment_unnamed_338, 0.5f, 0.5f);
				fragment_output_1.w = 0.0f;
				fragment_output_2.x = 0.0f;
				fragment_output_2.y = 0.0f;
				fragment_output_2.z = 0.100000001490116119384765625f;
				fragment_output_2.w = 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[2] = float4(_Background_Alpha, fragment_uniform_buffer_2[2][1], fragment_uniform_buffer_2[2][2], fragment_uniform_buffer_2[2][3]);

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
			GpuProgramID 187229

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


			float4 _TimeParameters;
			float _GlobalMipBias;
			float _Background_Alpha;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[3];
			Texture2D<float4> _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			Texture2D<float4> _BloodTex;
			Texture2D<float4> _BloodNrm;
			SamplerState sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			SamplerState sampler_BloodTex;
			SamplerState sampler_BloodNrm;

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
				float fragment_unnamed_219;
				float fragment_unnamed_220;
				uint fragment_unnamed_221;
				float fragment_unnamed_222;
				switch (fragment_input_2)
				{
					case 0u:
					{
						float fragment_unnamed_57 = fragment_uniform_buffer_0[80u].x * 0.100000001490116119384765625f;
						float4 fragment_unnamed_75 = _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D, float2(mad(fragment_input_1.x, 0.300000011920928955078125f, fragment_unnamed_57), mad(fragment_input_1.y, 0.300000011920928955078125f, fragment_unnamed_57)), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_77 = fragment_unnamed_75.x;
						float fragment_unnamed_78 = fragment_unnamed_75.y;
						float4 fragment_unnamed_93 = _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D, float2(mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_1.x), mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_1.y)), fragment_uniform_buffer_0[86u].y);
						float4 fragment_unnamed_144 = _BloodTex.SampleBias(sampler_BloodTex, float2(mad(fragment_uniform_buffer_1[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_77) + fragment_unnamed_93.x, 0.5f, fragment_unnamed_77)) + 1.0f), ((-0.0f) - fragment_input_1.x) + 1.0f, (-0.0f) - fragment_input_1.x) + 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_1[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_78) + fragment_unnamed_93.y, 0.5f, fragment_unnamed_78)) + 1.0f), ((-0.0f) - fragment_input_1.y) + 1.0f, (-0.0f) - fragment_input_1.y) + 1.0f, fragment_input_1.y)), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_146 = fragment_unnamed_144.x;
						float fragment_unnamed_147 = fragment_unnamed_144.y;
						float fragment_unnamed_148 = fragment_unnamed_144.z;
						float fragment_unnamed_149 = fragment_unnamed_144.w;
						float4 fragment_unnamed_157 = _BloodTex.SampleBias(sampler_BloodTex, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_159 = fragment_unnamed_157.x;
						float fragment_unnamed_160 = fragment_unnamed_157.y;
						float fragment_unnamed_161 = fragment_unnamed_157.z;
						float fragment_unnamed_162 = fragment_unnamed_157.w;
						float fragment_unnamed_171 = mad(((-0.0f) - fragment_unnamed_146) + fragment_unnamed_159, 0.00999999977648258209228515625f, fragment_unnamed_146);
						float fragment_unnamed_173 = mad(((-0.0f) - fragment_unnamed_147) + fragment_unnamed_160, 0.00999999977648258209228515625f, fragment_unnamed_147);
						float fragment_unnamed_174 = mad(((-0.0f) - fragment_unnamed_148) + fragment_unnamed_161, 0.00999999977648258209228515625f, fragment_unnamed_148);
						float fragment_unnamed_182 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_171) + fragment_unnamed_159, fragment_unnamed_171);
						float fragment_unnamed_183 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_173) + fragment_unnamed_160, fragment_unnamed_173);
						float fragment_unnamed_184 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_174) + fragment_unnamed_161, fragment_unnamed_174);
						fragment_unnamed_219 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_182) + fragment_unnamed_159, fragment_unnamed_182);
						fragment_unnamed_220 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_183) + fragment_unnamed_160, fragment_unnamed_183);
						fragment_unnamed_221 = asuint(mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_184) + fragment_unnamed_161, fragment_unnamed_184));
						fragment_unnamed_222 = mad(((-0.0f) - fragment_unnamed_162) + mad(((-0.0f) - fragment_unnamed_149) + fragment_unnamed_162, 0.00999999977648258209228515625f, fragment_unnamed_149), 0.2599999904632568359375f, fragment_unnamed_162);
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_207 = _BloodNrm.SampleBias(sampler_BloodNrm, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_219 = asfloat(1065353216u);
						fragment_unnamed_220 = fragment_unnamed_207.y;
						fragment_unnamed_221 = 0u;
						fragment_unnamed_222 = fragment_unnamed_207.x * fragment_unnamed_207.w;
						break;
					}
					case 2u:
					{
						fragment_unnamed_219 = asfloat(0u);
						fragment_unnamed_220 = asfloat(0u);
						fragment_unnamed_221 = 1065353216u;
						fragment_unnamed_222 = asfloat(1036831949u);
						break;
					}
					default:
					{
						fragment_unnamed_219 = asfloat(0u);
						fragment_unnamed_220 = asfloat(0u);
						fragment_unnamed_221 = 0u;
						fragment_unnamed_222 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_219;
				fragment_output_0.y = fragment_unnamed_220;
				fragment_output_0.z = asfloat(fragment_unnamed_221);
				fragment_output_0.w = fragment_unnamed_222;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[2] = float4(_Background_Alpha, fragment_uniform_buffer_1[2][1], fragment_uniform_buffer_1[2][2], fragment_uniform_buffer_1[2][3]);

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


			float4 _TimeParameters;
			float _GlobalMipBias;
			float _Background_Alpha;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[3];
			Texture2D<float4> _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			Texture2D<float4> _BloodTex;
			Texture2D<float4> _BloodNrm;
			SamplerState sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			SamplerState sampler_BloodTex;
			SamplerState sampler_BloodNrm;

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
				float fragment_unnamed_219;
				float fragment_unnamed_220;
				uint fragment_unnamed_221;
				float fragment_unnamed_222;
				switch (fragment_input_2)
				{
					case 0u:
					{
						float fragment_unnamed_57 = fragment_uniform_buffer_0[80u].x * 0.100000001490116119384765625f;
						float4 fragment_unnamed_75 = _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D, float2(mad(fragment_input_1.x, 0.300000011920928955078125f, fragment_unnamed_57), mad(fragment_input_1.y, 0.300000011920928955078125f, fragment_unnamed_57)), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_77 = fragment_unnamed_75.x;
						float fragment_unnamed_78 = fragment_unnamed_75.y;
						float4 fragment_unnamed_93 = _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D, float2(mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_1.x), mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_1.y)), fragment_uniform_buffer_0[86u].y);
						float4 fragment_unnamed_144 = _BloodTex.SampleBias(sampler_BloodTex, float2(mad(fragment_uniform_buffer_1[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_77) + fragment_unnamed_93.x, 0.5f, fragment_unnamed_77)) + 1.0f), ((-0.0f) - fragment_input_1.x) + 1.0f, (-0.0f) - fragment_input_1.x) + 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_1[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_78) + fragment_unnamed_93.y, 0.5f, fragment_unnamed_78)) + 1.0f), ((-0.0f) - fragment_input_1.y) + 1.0f, (-0.0f) - fragment_input_1.y) + 1.0f, fragment_input_1.y)), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_146 = fragment_unnamed_144.x;
						float fragment_unnamed_147 = fragment_unnamed_144.y;
						float fragment_unnamed_148 = fragment_unnamed_144.z;
						float fragment_unnamed_149 = fragment_unnamed_144.w;
						float4 fragment_unnamed_157 = _BloodTex.SampleBias(sampler_BloodTex, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_159 = fragment_unnamed_157.x;
						float fragment_unnamed_160 = fragment_unnamed_157.y;
						float fragment_unnamed_161 = fragment_unnamed_157.z;
						float fragment_unnamed_162 = fragment_unnamed_157.w;
						float fragment_unnamed_171 = mad(((-0.0f) - fragment_unnamed_146) + fragment_unnamed_159, 0.00999999977648258209228515625f, fragment_unnamed_146);
						float fragment_unnamed_173 = mad(((-0.0f) - fragment_unnamed_147) + fragment_unnamed_160, 0.00999999977648258209228515625f, fragment_unnamed_147);
						float fragment_unnamed_174 = mad(((-0.0f) - fragment_unnamed_148) + fragment_unnamed_161, 0.00999999977648258209228515625f, fragment_unnamed_148);
						float fragment_unnamed_182 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_171) + fragment_unnamed_159, fragment_unnamed_171);
						float fragment_unnamed_183 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_173) + fragment_unnamed_160, fragment_unnamed_173);
						float fragment_unnamed_184 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_174) + fragment_unnamed_161, fragment_unnamed_174);
						fragment_unnamed_219 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_182) + fragment_unnamed_159, fragment_unnamed_182);
						fragment_unnamed_220 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_183) + fragment_unnamed_160, fragment_unnamed_183);
						fragment_unnamed_221 = asuint(mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_184) + fragment_unnamed_161, fragment_unnamed_184));
						fragment_unnamed_222 = mad(((-0.0f) - fragment_unnamed_162) + mad(((-0.0f) - fragment_unnamed_149) + fragment_unnamed_162, 0.00999999977648258209228515625f, fragment_unnamed_149), 0.2599999904632568359375f, fragment_unnamed_162);
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_207 = _BloodNrm.SampleBias(sampler_BloodNrm, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_219 = asfloat(1065353216u);
						fragment_unnamed_220 = fragment_unnamed_207.y;
						fragment_unnamed_221 = 0u;
						fragment_unnamed_222 = fragment_unnamed_207.x * fragment_unnamed_207.w;
						break;
					}
					case 2u:
					{
						fragment_unnamed_219 = asfloat(0u);
						fragment_unnamed_220 = asfloat(0u);
						fragment_unnamed_221 = 1065353216u;
						fragment_unnamed_222 = asfloat(1036831949u);
						break;
					}
					default:
					{
						fragment_unnamed_219 = asfloat(0u);
						fragment_unnamed_220 = asfloat(0u);
						fragment_unnamed_221 = 0u;
						fragment_unnamed_222 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_219;
				fragment_output_0.y = fragment_unnamed_220;
				fragment_output_0.z = asfloat(fragment_unnamed_221);
				fragment_output_0.w = fragment_unnamed_222;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[2] = float4(_Background_Alpha, fragment_uniform_buffer_1[2][1], fragment_uniform_buffer_1[2][2], fragment_uniform_buffer_1[2][3]);

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


			float4 _TimeParameters;
			float _GlobalMipBias;
			float _Background_Alpha;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[3];
			Texture2D<float4> _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			Texture2D<float4> _BloodTex;
			Texture2D<float4> _BloodNrm;
			SamplerState sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			SamplerState sampler_BloodTex;
			SamplerState sampler_BloodNrm;

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
				float fragment_unnamed_219;
				float fragment_unnamed_220;
				uint fragment_unnamed_221;
				float fragment_unnamed_222;
				switch (fragment_input_2)
				{
					case 0u:
					{
						float fragment_unnamed_57 = fragment_uniform_buffer_0[80u].x * 0.100000001490116119384765625f;
						float4 fragment_unnamed_75 = _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D, float2(mad(fragment_input_1.x, 0.300000011920928955078125f, fragment_unnamed_57), mad(fragment_input_1.y, 0.300000011920928955078125f, fragment_unnamed_57)), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_77 = fragment_unnamed_75.x;
						float fragment_unnamed_78 = fragment_unnamed_75.y;
						float4 fragment_unnamed_93 = _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D, float2(mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_1.x), mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_1.y)), fragment_uniform_buffer_0[86u].y);
						float4 fragment_unnamed_144 = _BloodTex.SampleBias(sampler_BloodTex, float2(mad(fragment_uniform_buffer_1[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_77) + fragment_unnamed_93.x, 0.5f, fragment_unnamed_77)) + 1.0f), ((-0.0f) - fragment_input_1.x) + 1.0f, (-0.0f) - fragment_input_1.x) + 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_1[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_78) + fragment_unnamed_93.y, 0.5f, fragment_unnamed_78)) + 1.0f), ((-0.0f) - fragment_input_1.y) + 1.0f, (-0.0f) - fragment_input_1.y) + 1.0f, fragment_input_1.y)), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_146 = fragment_unnamed_144.x;
						float fragment_unnamed_147 = fragment_unnamed_144.y;
						float fragment_unnamed_148 = fragment_unnamed_144.z;
						float fragment_unnamed_149 = fragment_unnamed_144.w;
						float4 fragment_unnamed_157 = _BloodTex.SampleBias(sampler_BloodTex, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_159 = fragment_unnamed_157.x;
						float fragment_unnamed_160 = fragment_unnamed_157.y;
						float fragment_unnamed_161 = fragment_unnamed_157.z;
						float fragment_unnamed_162 = fragment_unnamed_157.w;
						float fragment_unnamed_171 = mad(((-0.0f) - fragment_unnamed_146) + fragment_unnamed_159, 0.00999999977648258209228515625f, fragment_unnamed_146);
						float fragment_unnamed_173 = mad(((-0.0f) - fragment_unnamed_147) + fragment_unnamed_160, 0.00999999977648258209228515625f, fragment_unnamed_147);
						float fragment_unnamed_174 = mad(((-0.0f) - fragment_unnamed_148) + fragment_unnamed_161, 0.00999999977648258209228515625f, fragment_unnamed_148);
						float fragment_unnamed_182 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_171) + fragment_unnamed_159, fragment_unnamed_171);
						float fragment_unnamed_183 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_173) + fragment_unnamed_160, fragment_unnamed_173);
						float fragment_unnamed_184 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_174) + fragment_unnamed_161, fragment_unnamed_174);
						fragment_unnamed_219 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_182) + fragment_unnamed_159, fragment_unnamed_182);
						fragment_unnamed_220 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_183) + fragment_unnamed_160, fragment_unnamed_183);
						fragment_unnamed_221 = asuint(mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_184) + fragment_unnamed_161, fragment_unnamed_184));
						fragment_unnamed_222 = mad(((-0.0f) - fragment_unnamed_162) + mad(((-0.0f) - fragment_unnamed_149) + fragment_unnamed_162, 0.00999999977648258209228515625f, fragment_unnamed_149), 0.2599999904632568359375f, fragment_unnamed_162);
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_207 = _BloodNrm.SampleBias(sampler_BloodNrm, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_219 = asfloat(1065353216u);
						fragment_unnamed_220 = fragment_unnamed_207.y;
						fragment_unnamed_221 = 0u;
						fragment_unnamed_222 = fragment_unnamed_207.x * fragment_unnamed_207.w;
						break;
					}
					case 2u:
					{
						fragment_unnamed_219 = asfloat(0u);
						fragment_unnamed_220 = asfloat(0u);
						fragment_unnamed_221 = 1065353216u;
						fragment_unnamed_222 = asfloat(1036831949u);
						break;
					}
					default:
					{
						fragment_unnamed_219 = asfloat(0u);
						fragment_unnamed_220 = asfloat(0u);
						fragment_unnamed_221 = 0u;
						fragment_unnamed_222 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_219;
				fragment_output_0.y = fragment_unnamed_220;
				fragment_output_0.z = asfloat(fragment_unnamed_221);
				fragment_output_0.w = fragment_unnamed_222;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[2] = float4(_Background_Alpha, fragment_uniform_buffer_1[2][1], fragment_uniform_buffer_1[2][2], fragment_uniform_buffer_1[2][3]);

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


			float4 _TimeParameters;
			float _GlobalMipBias;
			float _Background_Alpha;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[3];
			Texture2D<float4> _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			Texture2D<float4> _BloodTex;
			Texture2D<float4> _BloodNrm;
			SamplerState sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D;
			SamplerState sampler_BloodTex;
			SamplerState sampler_BloodNrm;

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
				float fragment_unnamed_219;
				float fragment_unnamed_220;
				uint fragment_unnamed_221;
				float fragment_unnamed_222;
				switch (fragment_input_2)
				{
					case 0u:
					{
						float fragment_unnamed_57 = fragment_uniform_buffer_0[80u].x * 0.100000001490116119384765625f;
						float4 fragment_unnamed_75 = _SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_841a4bfe261c414d805ceedced480753_Texture_1_Texture2D, float2(mad(fragment_input_1.x, 0.300000011920928955078125f, fragment_unnamed_57), mad(fragment_input_1.y, 0.300000011920928955078125f, fragment_unnamed_57)), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_77 = fragment_unnamed_75.x;
						float fragment_unnamed_78 = fragment_unnamed_75.y;
						float4 fragment_unnamed_93 = _SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_a4883638adf447eb823c19877822d8ef_Texture_1_Texture2D, float2(mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_1.x), mad(fragment_uniform_buffer_0[80u].x, -0.1500000059604644775390625f, fragment_input_1.y)), fragment_uniform_buffer_0[86u].y);
						float4 fragment_unnamed_144 = _BloodTex.SampleBias(sampler_BloodTex, float2(mad(fragment_uniform_buffer_1[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_77) + fragment_unnamed_93.x, 0.5f, fragment_unnamed_77)) + 1.0f), ((-0.0f) - fragment_input_1.x) + 1.0f, (-0.0f) - fragment_input_1.x) + 1.0f, fragment_input_1.x), mad(fragment_uniform_buffer_1[2u].x, mad((-0.0f) - (((-0.0f) - mad(((-0.0f) - fragment_unnamed_78) + fragment_unnamed_93.y, 0.5f, fragment_unnamed_78)) + 1.0f), ((-0.0f) - fragment_input_1.y) + 1.0f, (-0.0f) - fragment_input_1.y) + 1.0f, fragment_input_1.y)), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_146 = fragment_unnamed_144.x;
						float fragment_unnamed_147 = fragment_unnamed_144.y;
						float fragment_unnamed_148 = fragment_unnamed_144.z;
						float fragment_unnamed_149 = fragment_unnamed_144.w;
						float4 fragment_unnamed_157 = _BloodTex.SampleBias(sampler_BloodTex, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						float fragment_unnamed_159 = fragment_unnamed_157.x;
						float fragment_unnamed_160 = fragment_unnamed_157.y;
						float fragment_unnamed_161 = fragment_unnamed_157.z;
						float fragment_unnamed_162 = fragment_unnamed_157.w;
						float fragment_unnamed_171 = mad(((-0.0f) - fragment_unnamed_146) + fragment_unnamed_159, 0.00999999977648258209228515625f, fragment_unnamed_146);
						float fragment_unnamed_173 = mad(((-0.0f) - fragment_unnamed_147) + fragment_unnamed_160, 0.00999999977648258209228515625f, fragment_unnamed_147);
						float fragment_unnamed_174 = mad(((-0.0f) - fragment_unnamed_148) + fragment_unnamed_161, 0.00999999977648258209228515625f, fragment_unnamed_148);
						float fragment_unnamed_182 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_171) + fragment_unnamed_159, fragment_unnamed_171);
						float fragment_unnamed_183 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_173) + fragment_unnamed_160, fragment_unnamed_173);
						float fragment_unnamed_184 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_174) + fragment_unnamed_161, fragment_unnamed_174);
						fragment_unnamed_219 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_182) + fragment_unnamed_159, fragment_unnamed_182);
						fragment_unnamed_220 = mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_183) + fragment_unnamed_160, fragment_unnamed_183);
						fragment_unnamed_221 = asuint(mad(fragment_unnamed_162, ((-0.0f) - fragment_unnamed_184) + fragment_unnamed_161, fragment_unnamed_184));
						fragment_unnamed_222 = mad(((-0.0f) - fragment_unnamed_162) + mad(((-0.0f) - fragment_unnamed_149) + fragment_unnamed_162, 0.00999999977648258209228515625f, fragment_unnamed_149), 0.2599999904632568359375f, fragment_unnamed_162);
						break;
					}
					case 1u:
					{
						float4 fragment_unnamed_207 = _BloodNrm.SampleBias(sampler_BloodNrm, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
						fragment_unnamed_219 = asfloat(1065353216u);
						fragment_unnamed_220 = fragment_unnamed_207.y;
						fragment_unnamed_221 = 0u;
						fragment_unnamed_222 = fragment_unnamed_207.x * fragment_unnamed_207.w;
						break;
					}
					case 2u:
					{
						fragment_unnamed_219 = asfloat(0u);
						fragment_unnamed_220 = asfloat(0u);
						fragment_unnamed_221 = 1065353216u;
						fragment_unnamed_222 = asfloat(1036831949u);
						break;
					}
					default:
					{
						fragment_unnamed_219 = asfloat(0u);
						fragment_unnamed_220 = asfloat(0u);
						fragment_unnamed_221 = 0u;
						fragment_unnamed_222 = asfloat(0u);
						break;
					}
				}
				fragment_output_0.x = fragment_unnamed_219;
				fragment_output_0.y = fragment_unnamed_220;
				fragment_output_0.z = asfloat(fragment_unnamed_221);
				fragment_output_0.w = fragment_unnamed_222;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[2] = float4(_Background_Alpha, fragment_uniform_buffer_1[2][1], fragment_uniform_buffer_1[2][2], fragment_uniform_buffer_1[2][3]);

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
