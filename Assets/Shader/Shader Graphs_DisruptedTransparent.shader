Shader "Shader Graphs/DisruptedTransparent"
{
	Properties
	{
		_Dissolve ("Dissolve", Range(0, 1)) = 0
		[HDR] _DissolveColor ("DissolveColor", Color) = (0,0.6754479,1,1)
		[NoScaleOffset] _BaseColorMap ("BaseColorMap", 2D) = "white" {}
		[NoScaleOffset] _NormalMap ("NormalMap", 2D) = "white" {}
		[NoScaleOffset] _EmissionMap ("EmissionMap", 2D) = "white" {}
		[HDR] _Emission ("Emission", Color) = (0,0,0,0)
		[ToggleUI] _UseMaskMap ("UseMaskMap", Float) = 1
		[NoScaleOffset] _MaskMap ("MaskMap", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_9ccede5c759f47328be7a7de0be3904b_DetailMap_913208011_Texture2D ("Texture2D", 2D) = "white" {}
		[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
		[HideInInspector] _RenderQueueType ("Float", Float) = 1
		[ToggleUI] [HideInInspector] _AddPrecomputedVelocity ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _DepthOffsetEnable ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _ConservativeDepthOffsetEnable ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _TransparentWritingMotionVec ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _AlphaCutoffEnable ("Boolean", Float) = 1
		[HideInInspector] _TransparentSortPriority ("_TransparentSortPriority", Float) = 0
		[ToggleUI] [HideInInspector] _UseShadowThreshold ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _DoubleSidedEnable ("Boolean", Float) = 1
		[Enum(Flip, 0, Mirror, 1, None, 2)] [HideInInspector] _DoubleSidedNormalMode ("Float", Float) = 0
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
		[ToggleUI] [HideInInspector] _RequireSplitLighting ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _ReceivesSSR ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _ReceivesSSRTransparent ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _EnableBlendModePreserveSpecularLighting ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _SupportDecals ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _ExcludeFromTUAndAA ("Boolean", Float) = 0
		[HideInInspector] _StencilRef ("Float", Float) = 0
		[HideInInspector] _StencilWriteMask ("Float", Float) = 6
		[HideInInspector] _StencilRefDepth ("Float", Float) = 8
		[HideInInspector] _StencilWriteMaskDepth ("Float", Float) = 9
		[HideInInspector] _StencilRefMV ("Float", Float) = 40
		[HideInInspector] _StencilWriteMaskMV ("Float", Float) = 41
		[HideInInspector] _StencilRefDistortionVec ("Float", Float) = 4
		[HideInInspector] _StencilWriteMaskDistortionVec ("Float", Float) = 4
		[HideInInspector] _StencilWriteMaskGBuffer ("Float", Float) = 15
		[HideInInspector] _StencilRefGBuffer ("Float", Float) = 10
		[HideInInspector] _ZTestGBuffer ("Float", Float) = 4
		[ToggleUI] [HideInInspector] _RayTracing ("Boolean", Float) = 0
		[Enum(None, 0, Planar, 1, Sphere, 2, Thin, 3)] [HideInInspector] _RefractionModel ("Float", Float) = 0
		[Enum(Standard, 1)] [HideInInspector] _MaterialID ("_MaterialID", Float) = 1
		[HideInInspector] _MaterialTypeMask ("_MaterialTypeMask", Float) = 2
		[ToggleUI] [HideInInspector] _TransmissionEnable ("Boolean", Float) = 1
		[HideInInspector] [NoScaleOffset] unity_Lightmaps ("unity_Lightmaps", 2DArray) = "" {}
		[HideInInspector] [NoScaleOffset] unity_LightmapsInd ("unity_LightmapsInd", 2DArray) = "" {}
		[HideInInspector] [NoScaleOffset] unity_ShadowMasks ("unity_ShadowMasks", 2DArray) = "" {}
	}
	SubShader
	{
		Tags { "DisableBatching" = "False" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
		Pass
		{
			Name "ShadowCaster"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			ColorMask 0
			ZClip [_ZClip]
			Cull [_CullMode]
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 24485

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_instancing
			#pragma multi_compile _ _ALPHATEST_ON


			#if (!defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

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
			#endif
			#if (!defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
			}

			#endif
			#if (defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

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
			#endif
			#if (defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float _GlobalMipBias;
			float _Dissolve;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[2];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_393)
			{
				if (fragment_unnamed_393)
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
				float fragment_unnamed_42 = fragment_input_1.x * 15.0f;
				float fragment_unnamed_44 = fragment_input_1.y * 15.0f;
				float fragment_unnamed_46 = floor(fragment_unnamed_42);
				float fragment_unnamed_47 = floor(fragment_unnamed_44);
				float fragment_unnamed_48 = frac(fragment_unnamed_42);
				float fragment_unnamed_49 = frac(fragment_unnamed_44);
				float fragment_unnamed_50 = fragment_unnamed_46 + 1.0f;
				float fragment_unnamed_52 = fragment_unnamed_47 + 1.0f;
				float fragment_unnamed_56 = fragment_unnamed_50 * 289.0f;
				float fragment_unnamed_57 = fragment_unnamed_52 * 289.0f;
				float fragment_unnamed_58 = (-0.0f) - fragment_unnamed_56;
				float fragment_unnamed_60 = (-0.0f) - fragment_unnamed_57;
				float fragment_unnamed_82 = frac(fragment_unnamed_50 * asfloat((fragment_unnamed_56 >= fragment_unnamed_58) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_50 * 289.0f) >= fragment_unnamed_58) ? 1133543424u : 3281027072u);
				float fragment_unnamed_86 = fragment_unnamed_82 * mad(fragment_unnamed_82, 34.0f, 1.0f);
				float fragment_unnamed_87 = fragment_unnamed_86 * 289.0f;
				bool fragment_unnamed_89 = fragment_unnamed_87 >= ((-0.0f) - fragment_unnamed_87);
				float fragment_unnamed_96 = mad(asfloat(fragment_unnamed_89 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_89 ? 996328615u : 3143812263u) * fragment_unnamed_86), frac(fragment_unnamed_52 * asfloat((fragment_unnamed_57 >= fragment_unnamed_60) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_52 * 289.0f) >= fragment_unnamed_60) ? 1133543424u : 3281027072u));
				float fragment_unnamed_98 = fragment_unnamed_96 * mad(fragment_unnamed_96, 34.0f, 1.0f);
				float fragment_unnamed_99 = fragment_unnamed_98 * 289.0f;
				bool fragment_unnamed_101 = fragment_unnamed_99 >= ((-0.0f) - fragment_unnamed_99);
				float fragment_unnamed_111 = frac((frac(asfloat(fragment_unnamed_101 ? 996328615u : 3143812263u) * fragment_unnamed_98) * asfloat(fragment_unnamed_101 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_112 = mad(fragment_unnamed_111, 2.0f, -1.0f);
				float fragment_unnamed_119 = ((-0.0f) - floor(mad(fragment_unnamed_111, 2.0f, -0.5f))) + fragment_unnamed_112;
				float fragment_unnamed_121 = abs(fragment_unnamed_112) + (-0.5f);
				float fragment_unnamed_126 = rsqrt(dot(float2(fragment_unnamed_119, fragment_unnamed_121), float2(fragment_unnamed_119, fragment_unnamed_121)));
				float fragment_unnamed_134 = fragment_unnamed_46 + 0.0f;
				float fragment_unnamed_136 = fragment_unnamed_47 + 1.0f;
				float fragment_unnamed_137 = fragment_unnamed_46 + 1.0f;
				float fragment_unnamed_138 = fragment_unnamed_47 + 0.0f;
				float fragment_unnamed_139 = fragment_unnamed_134 * 289.0f;
				float fragment_unnamed_140 = fragment_unnamed_136 * 289.0f;
				float fragment_unnamed_141 = fragment_unnamed_137 * 289.0f;
				float fragment_unnamed_142 = fragment_unnamed_138 * 289.0f;
				bool fragment_unnamed_147 = fragment_unnamed_139 >= ((-0.0f) - fragment_unnamed_139);
				bool fragment_unnamed_148 = fragment_unnamed_140 >= ((-0.0f) - fragment_unnamed_140);
				bool fragment_unnamed_149 = fragment_unnamed_141 >= ((-0.0f) - fragment_unnamed_141);
				bool fragment_unnamed_150 = fragment_unnamed_142 >= ((-0.0f) - fragment_unnamed_142);
				float fragment_unnamed_173 = frac(fragment_unnamed_134 * asfloat(fragment_unnamed_147 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_147 ? 1133543424u : 3281027072u);
				float fragment_unnamed_177 = frac(fragment_unnamed_137 * asfloat(fragment_unnamed_149 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_149 ? 1133543424u : 3281027072u);
				float fragment_unnamed_180 = fragment_unnamed_177 * mad(fragment_unnamed_177, 34.0f, 1.0f);
				float fragment_unnamed_181 = fragment_unnamed_180 * 289.0f;
				bool fragment_unnamed_183 = fragment_unnamed_181 >= ((-0.0f) - fragment_unnamed_181);
				float fragment_unnamed_190 = mad(asfloat(fragment_unnamed_183 ? 1133543424u : 3281027072u), frac(fragment_unnamed_180 * asfloat(fragment_unnamed_183 ? 996328615u : 3143812263u)), frac(fragment_unnamed_138 * asfloat(fragment_unnamed_150 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_150 ? 1133543424u : 3281027072u));
				float fragment_unnamed_192 = fragment_unnamed_190 * mad(fragment_unnamed_190, 34.0f, 1.0f);
				float fragment_unnamed_193 = fragment_unnamed_192 * 289.0f;
				bool fragment_unnamed_195 = fragment_unnamed_193 >= ((-0.0f) - fragment_unnamed_193);
				float fragment_unnamed_204 = frac((frac(asfloat(fragment_unnamed_195 ? 996328615u : 3143812263u) * fragment_unnamed_192) * asfloat(fragment_unnamed_195 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_205 = mad(fragment_unnamed_204, 2.0f, -1.0f);
				float fragment_unnamed_209 = ((-0.0f) - floor(mad(fragment_unnamed_204, 2.0f, -0.5f))) + fragment_unnamed_205;
				float fragment_unnamed_211 = abs(fragment_unnamed_205) + (-0.5f);
				float fragment_unnamed_215 = rsqrt(dot(float2(fragment_unnamed_209, fragment_unnamed_211), float2(fragment_unnamed_209, fragment_unnamed_211)));
				float fragment_unnamed_222 = dot(float2(fragment_unnamed_215 * fragment_unnamed_209, fragment_unnamed_215 * fragment_unnamed_211), float2(fragment_unnamed_48 + (-1.0f), fragment_unnamed_49 + (-0.0f)));
				float fragment_unnamed_239 = (fragment_unnamed_49 * (fragment_unnamed_49 * fragment_unnamed_49)) * mad(fragment_unnamed_49, mad(fragment_unnamed_49, 6.0f, -15.0f), 10.0f);
				float fragment_unnamed_243 = fragment_unnamed_46 * 289.0f;
				float fragment_unnamed_244 = fragment_unnamed_47 * 289.0f;
				float fragment_unnamed_245 = (-0.0f) - fragment_unnamed_243;
				float fragment_unnamed_246 = (-0.0f) - fragment_unnamed_244;
				float fragment_unnamed_263 = frac(fragment_unnamed_46 * asfloat((fragment_unnamed_243 >= fragment_unnamed_245) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_46 * 289.0f) >= fragment_unnamed_245) ? 1133543424u : 3281027072u);
				float fragment_unnamed_266 = fragment_unnamed_263 * mad(fragment_unnamed_263, 34.0f, 1.0f);
				float fragment_unnamed_267 = fragment_unnamed_266 * 289.0f;
				bool fragment_unnamed_269 = fragment_unnamed_267 >= ((-0.0f) - fragment_unnamed_267);
				float fragment_unnamed_276 = mad(asfloat(fragment_unnamed_269 ? 1133543424u : 3281027072u), frac(fragment_unnamed_266 * asfloat(fragment_unnamed_269 ? 996328615u : 3143812263u)), frac(fragment_unnamed_47 * asfloat((fragment_unnamed_244 >= fragment_unnamed_246) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_47 * 289.0f) >= fragment_unnamed_246) ? 1133543424u : 3281027072u));
				float fragment_unnamed_278 = fragment_unnamed_276 * mad(fragment_unnamed_276, 34.0f, 1.0f);
				float fragment_unnamed_279 = fragment_unnamed_278 * 289.0f;
				bool fragment_unnamed_281 = fragment_unnamed_279 >= ((-0.0f) - fragment_unnamed_279);
				float fragment_unnamed_290 = frac((frac(fragment_unnamed_278 * asfloat(fragment_unnamed_281 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_281 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_291 = mad(fragment_unnamed_290, 2.0f, -1.0f);
				float fragment_unnamed_295 = ((-0.0f) - floor(mad(fragment_unnamed_290, 2.0f, -0.5f))) + fragment_unnamed_291;
				float fragment_unnamed_297 = abs(fragment_unnamed_291) + (-0.5f);
				float fragment_unnamed_301 = rsqrt(dot(float2(fragment_unnamed_295, fragment_unnamed_297), float2(fragment_unnamed_295, fragment_unnamed_297)));
				float fragment_unnamed_304 = dot(float2(fragment_unnamed_301 * fragment_unnamed_295, fragment_unnamed_301 * fragment_unnamed_297), float2(fragment_unnamed_48, fragment_unnamed_49));
				float fragment_unnamed_308 = fragment_unnamed_173 * mad(fragment_unnamed_173, 34.0f, 1.0f);
				float fragment_unnamed_309 = fragment_unnamed_308 * 289.0f;
				bool fragment_unnamed_311 = fragment_unnamed_309 >= ((-0.0f) - fragment_unnamed_309);
				float fragment_unnamed_318 = mad(asfloat(fragment_unnamed_311 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_311 ? 996328615u : 3143812263u) * fragment_unnamed_308), frac(fragment_unnamed_136 * asfloat(fragment_unnamed_148 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_148 ? 1133543424u : 3281027072u));
				float fragment_unnamed_320 = fragment_unnamed_318 * mad(fragment_unnamed_318, 34.0f, 1.0f);
				float fragment_unnamed_321 = fragment_unnamed_320 * 289.0f;
				bool fragment_unnamed_323 = fragment_unnamed_321 >= ((-0.0f) - fragment_unnamed_321);
				float fragment_unnamed_332 = frac((frac(asfloat(fragment_unnamed_323 ? 996328615u : 3143812263u) * fragment_unnamed_320) * asfloat(fragment_unnamed_323 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_333 = mad(fragment_unnamed_332, 2.0f, -1.0f);
				float fragment_unnamed_337 = ((-0.0f) - floor(mad(fragment_unnamed_332, 2.0f, -0.5f))) + fragment_unnamed_333;
				float fragment_unnamed_339 = abs(fragment_unnamed_333) + (-0.5f);
				float fragment_unnamed_343 = rsqrt(dot(float2(fragment_unnamed_337, fragment_unnamed_339), float2(fragment_unnamed_337, fragment_unnamed_339)));
				float fragment_unnamed_351 = mad(fragment_unnamed_239, ((-0.0f) - fragment_unnamed_304) + dot(float2(fragment_unnamed_343 * fragment_unnamed_337, fragment_unnamed_343 * fragment_unnamed_339), float2(fragment_unnamed_48 + (-0.0f), fragment_unnamed_49 + (-1.0f))), fragment_unnamed_304);
				float4 fragment_unnamed_377 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_379 = fragment_unnamed_377.w;
				discard_cond((((-0.0f) - max(((-0.0f) - (((-0.0f) - fragment_unnamed_379) + 1.0f)) + ((((-0.0f) - (mad((fragment_unnamed_48 * (fragment_unnamed_48 * fragment_unnamed_48)) * mad(fragment_unnamed_48, mad(fragment_unnamed_48, 6.0f, -15.0f), 10.0f), ((-0.0f) - fragment_unnamed_351) + mad(fragment_unnamed_239, ((-0.0f) - fragment_unnamed_222) + dot(float2(fragment_unnamed_126 * fragment_unnamed_119, fragment_unnamed_126 * fragment_unnamed_121), float2(fragment_unnamed_48 + (-1.0f), fragment_unnamed_49 + (-1.0f))), fragment_unnamed_222), fragment_unnamed_351) + 0.5f)) + mad(fragment_uniform_buffer_1[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f)) + 1.0f), 0.5f)) + fragment_unnamed_379) < 0.0f);
				discard_exit();
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
			}

			#endif
			#if (defined(INSTANCING_ON) && !defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
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
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
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
				uint vertex_unnamed_67 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
				uint vertex_unnamed_79 = vertex_unnamed_67 + 3u;
				float vertex_unnamed_106 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_79].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				float vertex_unnamed_137 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_79].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				float vertex_unnamed_169 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_79].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				vertex_output_5.x = vertex_unnamed_137;
				vertex_output_5.y = vertex_unnamed_106;
				vertex_output_5.z = vertex_unnamed_169;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_169, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_137, vertex_unnamed_106 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_169, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_137, vertex_unnamed_106 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_169, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_137, vertex_unnamed_106 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_169, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_137, vertex_unnamed_106 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
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
			#endif
			#if (defined(INSTANCING_ON) && !defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static uint fragment_input_6;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
				uint fragment_input_6 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
			}

			#endif
			#if (defined(INSTANCING_ON) && defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
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
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
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
				uint vertex_unnamed_67 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
				uint vertex_unnamed_79 = vertex_unnamed_67 + 3u;
				float vertex_unnamed_106 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_79].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				float vertex_unnamed_137 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_79].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				float vertex_unnamed_169 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_67 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_79].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_54));
				vertex_output_5.x = vertex_unnamed_137;
				vertex_output_5.y = vertex_unnamed_106;
				vertex_output_5.z = vertex_unnamed_169;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_169, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_137, vertex_unnamed_106 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_169, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_137, vertex_unnamed_106 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_169, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_137, vertex_unnamed_106 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_169, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_137, vertex_unnamed_106 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
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
			#endif
			#if (defined(INSTANCING_ON) && defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float _GlobalMipBias;
			float _Dissolve;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[2];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static uint fragment_input_6;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
				uint fragment_input_6 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_395)
			{
				if (fragment_unnamed_395)
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
				float fragment_unnamed_44 = fragment_input_1.x * 15.0f;
				float fragment_unnamed_46 = fragment_input_1.y * 15.0f;
				float fragment_unnamed_48 = floor(fragment_unnamed_44);
				float fragment_unnamed_49 = floor(fragment_unnamed_46);
				float fragment_unnamed_50 = frac(fragment_unnamed_44);
				float fragment_unnamed_51 = frac(fragment_unnamed_46);
				float fragment_unnamed_52 = fragment_unnamed_48 + 1.0f;
				float fragment_unnamed_54 = fragment_unnamed_49 + 1.0f;
				float fragment_unnamed_58 = fragment_unnamed_52 * 289.0f;
				float fragment_unnamed_59 = fragment_unnamed_54 * 289.0f;
				float fragment_unnamed_60 = (-0.0f) - fragment_unnamed_58;
				float fragment_unnamed_62 = (-0.0f) - fragment_unnamed_59;
				float fragment_unnamed_84 = frac(fragment_unnamed_52 * asfloat((fragment_unnamed_58 >= fragment_unnamed_60) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_52 * 289.0f) >= fragment_unnamed_60) ? 1133543424u : 3281027072u);
				float fragment_unnamed_88 = fragment_unnamed_84 * mad(fragment_unnamed_84, 34.0f, 1.0f);
				float fragment_unnamed_89 = fragment_unnamed_88 * 289.0f;
				bool fragment_unnamed_91 = fragment_unnamed_89 >= ((-0.0f) - fragment_unnamed_89);
				float fragment_unnamed_98 = mad(asfloat(fragment_unnamed_91 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_91 ? 996328615u : 3143812263u) * fragment_unnamed_88), frac(fragment_unnamed_54 * asfloat((fragment_unnamed_59 >= fragment_unnamed_62) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_54 * 289.0f) >= fragment_unnamed_62) ? 1133543424u : 3281027072u));
				float fragment_unnamed_100 = fragment_unnamed_98 * mad(fragment_unnamed_98, 34.0f, 1.0f);
				float fragment_unnamed_101 = fragment_unnamed_100 * 289.0f;
				bool fragment_unnamed_103 = fragment_unnamed_101 >= ((-0.0f) - fragment_unnamed_101);
				float fragment_unnamed_113 = frac((frac(asfloat(fragment_unnamed_103 ? 996328615u : 3143812263u) * fragment_unnamed_100) * asfloat(fragment_unnamed_103 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_114 = mad(fragment_unnamed_113, 2.0f, -1.0f);
				float fragment_unnamed_121 = ((-0.0f) - floor(mad(fragment_unnamed_113, 2.0f, -0.5f))) + fragment_unnamed_114;
				float fragment_unnamed_123 = abs(fragment_unnamed_114) + (-0.5f);
				float fragment_unnamed_128 = rsqrt(dot(float2(fragment_unnamed_121, fragment_unnamed_123), float2(fragment_unnamed_121, fragment_unnamed_123)));
				float fragment_unnamed_136 = fragment_unnamed_48 + 0.0f;
				float fragment_unnamed_138 = fragment_unnamed_49 + 1.0f;
				float fragment_unnamed_139 = fragment_unnamed_48 + 1.0f;
				float fragment_unnamed_140 = fragment_unnamed_49 + 0.0f;
				float fragment_unnamed_141 = fragment_unnamed_136 * 289.0f;
				float fragment_unnamed_142 = fragment_unnamed_138 * 289.0f;
				float fragment_unnamed_143 = fragment_unnamed_139 * 289.0f;
				float fragment_unnamed_144 = fragment_unnamed_140 * 289.0f;
				bool fragment_unnamed_149 = fragment_unnamed_141 >= ((-0.0f) - fragment_unnamed_141);
				bool fragment_unnamed_150 = fragment_unnamed_142 >= ((-0.0f) - fragment_unnamed_142);
				bool fragment_unnamed_151 = fragment_unnamed_143 >= ((-0.0f) - fragment_unnamed_143);
				bool fragment_unnamed_152 = fragment_unnamed_144 >= ((-0.0f) - fragment_unnamed_144);
				float fragment_unnamed_175 = frac(fragment_unnamed_136 * asfloat(fragment_unnamed_149 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_149 ? 1133543424u : 3281027072u);
				float fragment_unnamed_179 = frac(fragment_unnamed_139 * asfloat(fragment_unnamed_151 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_151 ? 1133543424u : 3281027072u);
				float fragment_unnamed_182 = fragment_unnamed_179 * mad(fragment_unnamed_179, 34.0f, 1.0f);
				float fragment_unnamed_183 = fragment_unnamed_182 * 289.0f;
				bool fragment_unnamed_185 = fragment_unnamed_183 >= ((-0.0f) - fragment_unnamed_183);
				float fragment_unnamed_192 = mad(asfloat(fragment_unnamed_185 ? 1133543424u : 3281027072u), frac(fragment_unnamed_182 * asfloat(fragment_unnamed_185 ? 996328615u : 3143812263u)), frac(fragment_unnamed_140 * asfloat(fragment_unnamed_152 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_152 ? 1133543424u : 3281027072u));
				float fragment_unnamed_194 = fragment_unnamed_192 * mad(fragment_unnamed_192, 34.0f, 1.0f);
				float fragment_unnamed_195 = fragment_unnamed_194 * 289.0f;
				bool fragment_unnamed_197 = fragment_unnamed_195 >= ((-0.0f) - fragment_unnamed_195);
				float fragment_unnamed_206 = frac((frac(asfloat(fragment_unnamed_197 ? 996328615u : 3143812263u) * fragment_unnamed_194) * asfloat(fragment_unnamed_197 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_207 = mad(fragment_unnamed_206, 2.0f, -1.0f);
				float fragment_unnamed_211 = ((-0.0f) - floor(mad(fragment_unnamed_206, 2.0f, -0.5f))) + fragment_unnamed_207;
				float fragment_unnamed_213 = abs(fragment_unnamed_207) + (-0.5f);
				float fragment_unnamed_217 = rsqrt(dot(float2(fragment_unnamed_211, fragment_unnamed_213), float2(fragment_unnamed_211, fragment_unnamed_213)));
				float fragment_unnamed_224 = dot(float2(fragment_unnamed_217 * fragment_unnamed_211, fragment_unnamed_217 * fragment_unnamed_213), float2(fragment_unnamed_50 + (-1.0f), fragment_unnamed_51 + (-0.0f)));
				float fragment_unnamed_241 = (fragment_unnamed_51 * (fragment_unnamed_51 * fragment_unnamed_51)) * mad(fragment_unnamed_51, mad(fragment_unnamed_51, 6.0f, -15.0f), 10.0f);
				float fragment_unnamed_245 = fragment_unnamed_48 * 289.0f;
				float fragment_unnamed_246 = fragment_unnamed_49 * 289.0f;
				float fragment_unnamed_247 = (-0.0f) - fragment_unnamed_245;
				float fragment_unnamed_248 = (-0.0f) - fragment_unnamed_246;
				float fragment_unnamed_265 = frac(fragment_unnamed_48 * asfloat((fragment_unnamed_245 >= fragment_unnamed_247) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_48 * 289.0f) >= fragment_unnamed_247) ? 1133543424u : 3281027072u);
				float fragment_unnamed_268 = fragment_unnamed_265 * mad(fragment_unnamed_265, 34.0f, 1.0f);
				float fragment_unnamed_269 = fragment_unnamed_268 * 289.0f;
				bool fragment_unnamed_271 = fragment_unnamed_269 >= ((-0.0f) - fragment_unnamed_269);
				float fragment_unnamed_278 = mad(asfloat(fragment_unnamed_271 ? 1133543424u : 3281027072u), frac(fragment_unnamed_268 * asfloat(fragment_unnamed_271 ? 996328615u : 3143812263u)), frac(fragment_unnamed_49 * asfloat((fragment_unnamed_246 >= fragment_unnamed_248) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_49 * 289.0f) >= fragment_unnamed_248) ? 1133543424u : 3281027072u));
				float fragment_unnamed_280 = fragment_unnamed_278 * mad(fragment_unnamed_278, 34.0f, 1.0f);
				float fragment_unnamed_281 = fragment_unnamed_280 * 289.0f;
				bool fragment_unnamed_283 = fragment_unnamed_281 >= ((-0.0f) - fragment_unnamed_281);
				float fragment_unnamed_292 = frac((frac(fragment_unnamed_280 * asfloat(fragment_unnamed_283 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_283 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_293 = mad(fragment_unnamed_292, 2.0f, -1.0f);
				float fragment_unnamed_297 = ((-0.0f) - floor(mad(fragment_unnamed_292, 2.0f, -0.5f))) + fragment_unnamed_293;
				float fragment_unnamed_299 = abs(fragment_unnamed_293) + (-0.5f);
				float fragment_unnamed_303 = rsqrt(dot(float2(fragment_unnamed_297, fragment_unnamed_299), float2(fragment_unnamed_297, fragment_unnamed_299)));
				float fragment_unnamed_306 = dot(float2(fragment_unnamed_303 * fragment_unnamed_297, fragment_unnamed_303 * fragment_unnamed_299), float2(fragment_unnamed_50, fragment_unnamed_51));
				float fragment_unnamed_310 = fragment_unnamed_175 * mad(fragment_unnamed_175, 34.0f, 1.0f);
				float fragment_unnamed_311 = fragment_unnamed_310 * 289.0f;
				bool fragment_unnamed_313 = fragment_unnamed_311 >= ((-0.0f) - fragment_unnamed_311);
				float fragment_unnamed_320 = mad(asfloat(fragment_unnamed_313 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_313 ? 996328615u : 3143812263u) * fragment_unnamed_310), frac(fragment_unnamed_138 * asfloat(fragment_unnamed_150 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_150 ? 1133543424u : 3281027072u));
				float fragment_unnamed_322 = fragment_unnamed_320 * mad(fragment_unnamed_320, 34.0f, 1.0f);
				float fragment_unnamed_323 = fragment_unnamed_322 * 289.0f;
				bool fragment_unnamed_325 = fragment_unnamed_323 >= ((-0.0f) - fragment_unnamed_323);
				float fragment_unnamed_334 = frac((frac(asfloat(fragment_unnamed_325 ? 996328615u : 3143812263u) * fragment_unnamed_322) * asfloat(fragment_unnamed_325 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_335 = mad(fragment_unnamed_334, 2.0f, -1.0f);
				float fragment_unnamed_339 = ((-0.0f) - floor(mad(fragment_unnamed_334, 2.0f, -0.5f))) + fragment_unnamed_335;
				float fragment_unnamed_341 = abs(fragment_unnamed_335) + (-0.5f);
				float fragment_unnamed_345 = rsqrt(dot(float2(fragment_unnamed_339, fragment_unnamed_341), float2(fragment_unnamed_339, fragment_unnamed_341)));
				float fragment_unnamed_353 = mad(fragment_unnamed_241, ((-0.0f) - fragment_unnamed_306) + dot(float2(fragment_unnamed_345 * fragment_unnamed_339, fragment_unnamed_345 * fragment_unnamed_341), float2(fragment_unnamed_50 + (-0.0f), fragment_unnamed_51 + (-1.0f))), fragment_unnamed_306);
				float4 fragment_unnamed_379 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_381 = fragment_unnamed_379.w;
				discard_cond((((-0.0f) - max(((-0.0f) - (((-0.0f) - fragment_unnamed_381) + 1.0f)) + ((((-0.0f) - (mad((fragment_unnamed_50 * (fragment_unnamed_50 * fragment_unnamed_50)) * mad(fragment_unnamed_50, mad(fragment_unnamed_50, 6.0f, -15.0f), 10.0f), ((-0.0f) - fragment_unnamed_353) + mad(fragment_unnamed_241, ((-0.0f) - fragment_unnamed_224) + dot(float2(fragment_unnamed_128 * fragment_unnamed_121, fragment_unnamed_128 * fragment_unnamed_123), float2(fragment_unnamed_50 + (-1.0f), fragment_unnamed_51 + (-1.0f))), fragment_unnamed_224), fragment_unnamed_353) + 0.5f)) + mad(fragment_uniform_buffer_1[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f)) + 1.0f), 0.5f)) + fragment_unnamed_381) < 0.0f);
				discard_exit();
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				frag_main();
			}

			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT

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
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
			}

			#endif

			// Per-stage fallbacks for variants missing from the ripped data
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			float4 vert(float3 pos : POSITION) : SV_POSITION { return float4(0, 0, 0, 1); }
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			float4 frag() : SV_TARGET { return 0; }
			#endif
			ENDHLSL
		}
		Pass
		{
			Name "MotionVectors"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Cull [_CullMode]
			Stencil
			{
				Ref [_StencilRefMV]
				WriteMask [_StencilWriteMaskMV]
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
			GpuProgramID 268949

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_instancing
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma multi_compile _ _ALPHATEST_ON


			#if (!defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float3 vertex_input_7;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float3 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_input_7 : TEXCOORD4; // TEXCOORD_4
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float4 vertex_output_4 : INTERP1; // INTERP_1
				float4 vertex_output_5 : INTERP2; // INTERP_2
				float4 vertex_output_6 : INTERP3; // INTERP_3
				float4 vertex_output_7 : INTERP4; // INTERP_4
				float3 vertex_output_8 : INTERP5; // INTERP_5
				float3 vertex_output_9 : INTERP6; // INTERP_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_87 = asfloat(1065353216u);
				float vertex_unnamed_89 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_107 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_125 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_140 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_155 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_170 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_179 = rsqrt(max(dot(float3(vertex_unnamed_140, vertex_unnamed_155, vertex_unnamed_170), float3(vertex_unnamed_140, vertex_unnamed_155, vertex_unnamed_170)), 1.1754943508222875079687365372222e-38f));
				vertex_output_9.x = vertex_unnamed_179 * vertex_unnamed_140;
				vertex_output_9.y = vertex_unnamed_179 * vertex_unnamed_155;
				vertex_output_9.z = vertex_unnamed_179 * vertex_unnamed_170;
				float vertex_unnamed_214 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_215 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_216 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_221 = rsqrt(max(dot(float3(vertex_unnamed_214, vertex_unnamed_215, vertex_unnamed_216), float3(vertex_unnamed_214, vertex_unnamed_215, vertex_unnamed_216)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_221 * vertex_unnamed_214;
				vertex_output_3.y = vertex_unnamed_221 * vertex_unnamed_215;
				vertex_output_3.z = vertex_unnamed_221 * vertex_unnamed_216;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_125, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_125, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_125, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_329 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_342 = vertex_unnamed_329 ? vertex_input_7.x : vertex_input_0.x;
					float vertex_unnamed_343 = vertex_unnamed_329 ? vertex_input_7.y : vertex_input_0.y;
					float vertex_unnamed_344 = vertex_unnamed_329 ? vertex_input_7.z : vertex_input_0.z;
					float vertex_unnamed_378 = asfloat(1065353216u);
					float vertex_unnamed_379 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_342, vertex_unnamed_343, vertex_unnamed_344, vertex_unnamed_378));
					float vertex_unnamed_397 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_342, vertex_unnamed_343, vertex_unnamed_344, vertex_unnamed_378));
					float vertex_unnamed_415 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_342, vertex_unnamed_343, vertex_unnamed_344, vertex_unnamed_378));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_415, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_379, vertex_unnamed_397 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_415, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_379, vertex_unnamed_397 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_415, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_379, vertex_unnamed_397 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_input_3.x;
				vertex_output_4.y = vertex_input_3.y;
				vertex_output_4.z = vertex_input_3.z;
				vertex_output_4.w = vertex_input_3.w;
				vertex_output_5.x = vertex_input_4.x;
				vertex_output_5.y = vertex_input_4.y;
				vertex_output_5.z = vertex_input_4.z;
				vertex_output_5.w = vertex_input_4.w;
				vertex_output_6.x = vertex_input_5.x;
				vertex_output_6.y = vertex_input_5.y;
				vertex_output_6.z = vertex_input_5.z;
				vertex_output_6.w = vertex_input_5.w;
				vertex_output_7.x = vertex_input_6.x;
				vertex_output_7.y = vertex_input_6.y;
				vertex_output_7.z = vertex_input_6.z;
				vertex_output_7.w = vertex_input_6.w;
				vertex_output_8.x = vertex_unnamed_89;
				vertex_output_8.y = vertex_unnamed_107;
				vertex_output_8.z = vertex_unnamed_125;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[32] = float4(_NonJitteredViewProjMatrix[0][0], _NonJitteredViewProjMatrix[1][0], _NonJitteredViewProjMatrix[2][0], _NonJitteredViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[33] = float4(_NonJitteredViewProjMatrix[0][1], _NonJitteredViewProjMatrix[1][1], _NonJitteredViewProjMatrix[2][1], _NonJitteredViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[34] = float4(_NonJitteredViewProjMatrix[0][2], _NonJitteredViewProjMatrix[1][2], _NonJitteredViewProjMatrix[2][2], _NonJitteredViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[35] = float4(_NonJitteredViewProjMatrix[0][3], _NonJitteredViewProjMatrix[1][3], _NonJitteredViewProjMatrix[2][3], _NonJitteredViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[40] = float4(_PrevViewProjMatrix[0][0], _PrevViewProjMatrix[1][0], _PrevViewProjMatrix[2][0], _PrevViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[41] = float4(_PrevViewProjMatrix[0][1], _PrevViewProjMatrix[1][1], _PrevViewProjMatrix[2][1], _PrevViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[42] = float4(_PrevViewProjMatrix[0][2], _PrevViewProjMatrix[1][2], _PrevViewProjMatrix[2][2], _PrevViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[43] = float4(_PrevViewProjMatrix[0][3], _PrevViewProjMatrix[1][3], _PrevViewProjMatrix[2][3], _PrevViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_1[30] = float4(unity_MatrixPreviousM[0][0], unity_MatrixPreviousM[1][0], unity_MatrixPreviousM[2][0], unity_MatrixPreviousM[3][0]);
				vertex_uniform_buffer_1[31] = float4(unity_MatrixPreviousM[0][1], unity_MatrixPreviousM[1][1], unity_MatrixPreviousM[2][1], unity_MatrixPreviousM[3][1]);
				vertex_uniform_buffer_1[32] = float4(unity_MatrixPreviousM[0][2], unity_MatrixPreviousM[1][2], unity_MatrixPreviousM[2][2], unity_MatrixPreviousM[3][2]);
				vertex_uniform_buffer_1[33] = float4(unity_MatrixPreviousM[0][3], unity_MatrixPreviousM[1][3], unity_MatrixPreviousM[2][3], unity_MatrixPreviousM[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}
			#endif
			#if (!defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ScreenSize;
			float4 unity_MotionVectorsParams;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float4 fragment_input_6 : INTERP3; // INTERP_3
				float4 fragment_input_7 : INTERP4; // INTERP_4
				float3 fragment_input_8 : INTERP5; // INTERP_5
				float3 fragment_input_9 : INTERP6; // INTERP_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_56 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_57 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_107 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_107 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_56) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_56)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_107 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_57) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_57)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float3 vertex_input_7;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float3 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_input_7 : TEXCOORD4; // TEXCOORD_4
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float4 vertex_output_4 : INTERP1; // INTERP_1
				float4 vertex_output_5 : INTERP2; // INTERP_2
				float4 vertex_output_6 : INTERP3; // INTERP_3
				float4 vertex_output_7 : INTERP4; // INTERP_4
				float3 vertex_output_8 : INTERP5; // INTERP_5
				float3 vertex_output_9 : INTERP6; // INTERP_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_87 = asfloat(1065353216u);
				float vertex_unnamed_89 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_107 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_125 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_140 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_155 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_170 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_179 = rsqrt(max(dot(float3(vertex_unnamed_140, vertex_unnamed_155, vertex_unnamed_170), float3(vertex_unnamed_140, vertex_unnamed_155, vertex_unnamed_170)), 1.1754943508222875079687365372222e-38f));
				vertex_output_9.x = vertex_unnamed_179 * vertex_unnamed_140;
				vertex_output_9.y = vertex_unnamed_179 * vertex_unnamed_155;
				vertex_output_9.z = vertex_unnamed_179 * vertex_unnamed_170;
				float vertex_unnamed_214 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_215 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_216 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_221 = rsqrt(max(dot(float3(vertex_unnamed_214, vertex_unnamed_215, vertex_unnamed_216), float3(vertex_unnamed_214, vertex_unnamed_215, vertex_unnamed_216)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_221 * vertex_unnamed_214;
				vertex_output_3.y = vertex_unnamed_221 * vertex_unnamed_215;
				vertex_output_3.z = vertex_unnamed_221 * vertex_unnamed_216;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_125, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_125, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_125, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_329 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_342 = vertex_unnamed_329 ? vertex_input_7.x : vertex_input_0.x;
					float vertex_unnamed_343 = vertex_unnamed_329 ? vertex_input_7.y : vertex_input_0.y;
					float vertex_unnamed_344 = vertex_unnamed_329 ? vertex_input_7.z : vertex_input_0.z;
					float vertex_unnamed_378 = asfloat(1065353216u);
					float vertex_unnamed_379 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_342, vertex_unnamed_343, vertex_unnamed_344, vertex_unnamed_378));
					float vertex_unnamed_397 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_342, vertex_unnamed_343, vertex_unnamed_344, vertex_unnamed_378));
					float vertex_unnamed_415 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_342, vertex_unnamed_343, vertex_unnamed_344, vertex_unnamed_378));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_415, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_379, vertex_unnamed_397 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_415, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_379, vertex_unnamed_397 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_415, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_379, vertex_unnamed_397 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_input_3.x;
				vertex_output_4.y = vertex_input_3.y;
				vertex_output_4.z = vertex_input_3.z;
				vertex_output_4.w = vertex_input_3.w;
				vertex_output_5.x = vertex_input_4.x;
				vertex_output_5.y = vertex_input_4.y;
				vertex_output_5.z = vertex_input_4.z;
				vertex_output_5.w = vertex_input_4.w;
				vertex_output_6.x = vertex_input_5.x;
				vertex_output_6.y = vertex_input_5.y;
				vertex_output_6.z = vertex_input_5.z;
				vertex_output_6.w = vertex_input_5.w;
				vertex_output_7.x = vertex_input_6.x;
				vertex_output_7.y = vertex_input_6.y;
				vertex_output_7.z = vertex_input_6.z;
				vertex_output_7.w = vertex_input_6.w;
				vertex_output_8.x = vertex_unnamed_89;
				vertex_output_8.y = vertex_unnamed_107;
				vertex_output_8.z = vertex_unnamed_125;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[32] = float4(_NonJitteredViewProjMatrix[0][0], _NonJitteredViewProjMatrix[1][0], _NonJitteredViewProjMatrix[2][0], _NonJitteredViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[33] = float4(_NonJitteredViewProjMatrix[0][1], _NonJitteredViewProjMatrix[1][1], _NonJitteredViewProjMatrix[2][1], _NonJitteredViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[34] = float4(_NonJitteredViewProjMatrix[0][2], _NonJitteredViewProjMatrix[1][2], _NonJitteredViewProjMatrix[2][2], _NonJitteredViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[35] = float4(_NonJitteredViewProjMatrix[0][3], _NonJitteredViewProjMatrix[1][3], _NonJitteredViewProjMatrix[2][3], _NonJitteredViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[40] = float4(_PrevViewProjMatrix[0][0], _PrevViewProjMatrix[1][0], _PrevViewProjMatrix[2][0], _PrevViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[41] = float4(_PrevViewProjMatrix[0][1], _PrevViewProjMatrix[1][1], _PrevViewProjMatrix[2][1], _PrevViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[42] = float4(_PrevViewProjMatrix[0][2], _PrevViewProjMatrix[1][2], _PrevViewProjMatrix[2][2], _PrevViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[43] = float4(_PrevViewProjMatrix[0][3], _PrevViewProjMatrix[1][3], _PrevViewProjMatrix[2][3], _PrevViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_1[30] = float4(unity_MatrixPreviousM[0][0], unity_MatrixPreviousM[1][0], unity_MatrixPreviousM[2][0], unity_MatrixPreviousM[3][0]);
				vertex_uniform_buffer_1[31] = float4(unity_MatrixPreviousM[0][1], unity_MatrixPreviousM[1][1], unity_MatrixPreviousM[2][1], unity_MatrixPreviousM[3][1]);
				vertex_uniform_buffer_1[32] = float4(unity_MatrixPreviousM[0][2], unity_MatrixPreviousM[1][2], unity_MatrixPreviousM[2][2], unity_MatrixPreviousM[3][2]);
				vertex_uniform_buffer_1[33] = float4(unity_MatrixPreviousM[0][3], unity_MatrixPreviousM[1][3], unity_MatrixPreviousM[2][3], unity_MatrixPreviousM[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}
			#endif
			#if (defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			float _Dissolve;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[2];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float4 fragment_input_6 : INTERP3; // INTERP_3
				float4 fragment_input_7 : INTERP4; // INTERP_4
				float3 fragment_input_8 : INTERP5; // INTERP_5
				float3 fragment_input_9 : INTERP6; // INTERP_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_476)
			{
				if (fragment_unnamed_476)
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
				float fragment_unnamed_53 = fragment_input_4.x * 15.0f;
				float fragment_unnamed_55 = fragment_input_4.y * 15.0f;
				float fragment_unnamed_57 = floor(fragment_unnamed_53);
				float fragment_unnamed_58 = floor(fragment_unnamed_55);
				float fragment_unnamed_59 = frac(fragment_unnamed_53);
				float fragment_unnamed_60 = frac(fragment_unnamed_55);
				float fragment_unnamed_61 = fragment_unnamed_57 + 1.0f;
				float fragment_unnamed_63 = fragment_unnamed_58 + 1.0f;
				float fragment_unnamed_67 = fragment_unnamed_61 * 289.0f;
				float fragment_unnamed_68 = fragment_unnamed_63 * 289.0f;
				float fragment_unnamed_69 = (-0.0f) - fragment_unnamed_67;
				float fragment_unnamed_71 = (-0.0f) - fragment_unnamed_68;
				float fragment_unnamed_93 = frac(fragment_unnamed_61 * asfloat((fragment_unnamed_67 >= fragment_unnamed_69) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_61 * 289.0f) >= fragment_unnamed_69) ? 1133543424u : 3281027072u);
				float fragment_unnamed_97 = fragment_unnamed_93 * mad(fragment_unnamed_93, 34.0f, 1.0f);
				float fragment_unnamed_98 = fragment_unnamed_97 * 289.0f;
				bool fragment_unnamed_100 = fragment_unnamed_98 >= ((-0.0f) - fragment_unnamed_98);
				float fragment_unnamed_107 = mad(asfloat(fragment_unnamed_100 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_100 ? 996328615u : 3143812263u) * fragment_unnamed_97), frac(fragment_unnamed_63 * asfloat((fragment_unnamed_68 >= fragment_unnamed_71) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_63 * 289.0f) >= fragment_unnamed_71) ? 1133543424u : 3281027072u));
				float fragment_unnamed_109 = fragment_unnamed_107 * mad(fragment_unnamed_107, 34.0f, 1.0f);
				float fragment_unnamed_110 = fragment_unnamed_109 * 289.0f;
				bool fragment_unnamed_112 = fragment_unnamed_110 >= ((-0.0f) - fragment_unnamed_110);
				float fragment_unnamed_122 = frac((frac(asfloat(fragment_unnamed_112 ? 996328615u : 3143812263u) * fragment_unnamed_109) * asfloat(fragment_unnamed_112 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_123 = mad(fragment_unnamed_122, 2.0f, -1.0f);
				float fragment_unnamed_130 = ((-0.0f) - floor(mad(fragment_unnamed_122, 2.0f, -0.5f))) + fragment_unnamed_123;
				float fragment_unnamed_132 = abs(fragment_unnamed_123) + (-0.5f);
				float fragment_unnamed_137 = rsqrt(dot(float2(fragment_unnamed_130, fragment_unnamed_132), float2(fragment_unnamed_130, fragment_unnamed_132)));
				float fragment_unnamed_145 = fragment_unnamed_57 + 0.0f;
				float fragment_unnamed_147 = fragment_unnamed_58 + 1.0f;
				float fragment_unnamed_148 = fragment_unnamed_57 + 1.0f;
				float fragment_unnamed_149 = fragment_unnamed_58 + 0.0f;
				float fragment_unnamed_150 = fragment_unnamed_145 * 289.0f;
				float fragment_unnamed_151 = fragment_unnamed_147 * 289.0f;
				float fragment_unnamed_152 = fragment_unnamed_148 * 289.0f;
				float fragment_unnamed_153 = fragment_unnamed_149 * 289.0f;
				bool fragment_unnamed_158 = fragment_unnamed_150 >= ((-0.0f) - fragment_unnamed_150);
				bool fragment_unnamed_159 = fragment_unnamed_151 >= ((-0.0f) - fragment_unnamed_151);
				bool fragment_unnamed_160 = fragment_unnamed_152 >= ((-0.0f) - fragment_unnamed_152);
				bool fragment_unnamed_161 = fragment_unnamed_153 >= ((-0.0f) - fragment_unnamed_153);
				float fragment_unnamed_184 = frac(fragment_unnamed_145 * asfloat(fragment_unnamed_158 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_158 ? 1133543424u : 3281027072u);
				float fragment_unnamed_188 = frac(fragment_unnamed_148 * asfloat(fragment_unnamed_160 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_160 ? 1133543424u : 3281027072u);
				float fragment_unnamed_191 = fragment_unnamed_188 * mad(fragment_unnamed_188, 34.0f, 1.0f);
				float fragment_unnamed_192 = fragment_unnamed_191 * 289.0f;
				bool fragment_unnamed_194 = fragment_unnamed_192 >= ((-0.0f) - fragment_unnamed_192);
				float fragment_unnamed_201 = mad(asfloat(fragment_unnamed_194 ? 1133543424u : 3281027072u), frac(fragment_unnamed_191 * asfloat(fragment_unnamed_194 ? 996328615u : 3143812263u)), frac(fragment_unnamed_149 * asfloat(fragment_unnamed_161 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_161 ? 1133543424u : 3281027072u));
				float fragment_unnamed_203 = fragment_unnamed_201 * mad(fragment_unnamed_201, 34.0f, 1.0f);
				float fragment_unnamed_204 = fragment_unnamed_203 * 289.0f;
				bool fragment_unnamed_206 = fragment_unnamed_204 >= ((-0.0f) - fragment_unnamed_204);
				float fragment_unnamed_215 = frac((frac(asfloat(fragment_unnamed_206 ? 996328615u : 3143812263u) * fragment_unnamed_203) * asfloat(fragment_unnamed_206 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_216 = mad(fragment_unnamed_215, 2.0f, -1.0f);
				float fragment_unnamed_220 = ((-0.0f) - floor(mad(fragment_unnamed_215, 2.0f, -0.5f))) + fragment_unnamed_216;
				float fragment_unnamed_222 = abs(fragment_unnamed_216) + (-0.5f);
				float fragment_unnamed_226 = rsqrt(dot(float2(fragment_unnamed_220, fragment_unnamed_222), float2(fragment_unnamed_220, fragment_unnamed_222)));
				float fragment_unnamed_233 = dot(float2(fragment_unnamed_226 * fragment_unnamed_220, fragment_unnamed_226 * fragment_unnamed_222), float2(fragment_unnamed_59 + (-1.0f), fragment_unnamed_60 + (-0.0f)));
				float fragment_unnamed_250 = (fragment_unnamed_60 * (fragment_unnamed_60 * fragment_unnamed_60)) * mad(fragment_unnamed_60, mad(fragment_unnamed_60, 6.0f, -15.0f), 10.0f);
				float fragment_unnamed_254 = fragment_unnamed_57 * 289.0f;
				float fragment_unnamed_255 = fragment_unnamed_58 * 289.0f;
				float fragment_unnamed_256 = (-0.0f) - fragment_unnamed_254;
				float fragment_unnamed_257 = (-0.0f) - fragment_unnamed_255;
				float fragment_unnamed_274 = frac(fragment_unnamed_57 * asfloat((fragment_unnamed_254 >= fragment_unnamed_256) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_57 * 289.0f) >= fragment_unnamed_256) ? 1133543424u : 3281027072u);
				float fragment_unnamed_277 = fragment_unnamed_274 * mad(fragment_unnamed_274, 34.0f, 1.0f);
				float fragment_unnamed_278 = fragment_unnamed_277 * 289.0f;
				bool fragment_unnamed_280 = fragment_unnamed_278 >= ((-0.0f) - fragment_unnamed_278);
				float fragment_unnamed_287 = mad(asfloat(fragment_unnamed_280 ? 1133543424u : 3281027072u), frac(fragment_unnamed_277 * asfloat(fragment_unnamed_280 ? 996328615u : 3143812263u)), frac(fragment_unnamed_58 * asfloat((fragment_unnamed_255 >= fragment_unnamed_257) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_58 * 289.0f) >= fragment_unnamed_257) ? 1133543424u : 3281027072u));
				float fragment_unnamed_289 = fragment_unnamed_287 * mad(fragment_unnamed_287, 34.0f, 1.0f);
				float fragment_unnamed_290 = fragment_unnamed_289 * 289.0f;
				bool fragment_unnamed_292 = fragment_unnamed_290 >= ((-0.0f) - fragment_unnamed_290);
				float fragment_unnamed_301 = frac((frac(fragment_unnamed_289 * asfloat(fragment_unnamed_292 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_292 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_302 = mad(fragment_unnamed_301, 2.0f, -1.0f);
				float fragment_unnamed_306 = ((-0.0f) - floor(mad(fragment_unnamed_301, 2.0f, -0.5f))) + fragment_unnamed_302;
				float fragment_unnamed_308 = abs(fragment_unnamed_302) + (-0.5f);
				float fragment_unnamed_312 = rsqrt(dot(float2(fragment_unnamed_306, fragment_unnamed_308), float2(fragment_unnamed_306, fragment_unnamed_308)));
				float fragment_unnamed_315 = dot(float2(fragment_unnamed_312 * fragment_unnamed_306, fragment_unnamed_312 * fragment_unnamed_308), float2(fragment_unnamed_59, fragment_unnamed_60));
				float fragment_unnamed_319 = fragment_unnamed_184 * mad(fragment_unnamed_184, 34.0f, 1.0f);
				float fragment_unnamed_320 = fragment_unnamed_319 * 289.0f;
				bool fragment_unnamed_322 = fragment_unnamed_320 >= ((-0.0f) - fragment_unnamed_320);
				float fragment_unnamed_329 = mad(asfloat(fragment_unnamed_322 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_322 ? 996328615u : 3143812263u) * fragment_unnamed_319), frac(fragment_unnamed_147 * asfloat(fragment_unnamed_159 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_159 ? 1133543424u : 3281027072u));
				float fragment_unnamed_331 = fragment_unnamed_329 * mad(fragment_unnamed_329, 34.0f, 1.0f);
				float fragment_unnamed_332 = fragment_unnamed_331 * 289.0f;
				bool fragment_unnamed_334 = fragment_unnamed_332 >= ((-0.0f) - fragment_unnamed_332);
				float fragment_unnamed_343 = frac((frac(asfloat(fragment_unnamed_334 ? 996328615u : 3143812263u) * fragment_unnamed_331) * asfloat(fragment_unnamed_334 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_344 = mad(fragment_unnamed_343, 2.0f, -1.0f);
				float fragment_unnamed_348 = ((-0.0f) - floor(mad(fragment_unnamed_343, 2.0f, -0.5f))) + fragment_unnamed_344;
				float fragment_unnamed_350 = abs(fragment_unnamed_344) + (-0.5f);
				float fragment_unnamed_354 = rsqrt(dot(float2(fragment_unnamed_348, fragment_unnamed_350), float2(fragment_unnamed_348, fragment_unnamed_350)));
				float fragment_unnamed_362 = mad(fragment_unnamed_250, ((-0.0f) - fragment_unnamed_315) + dot(float2(fragment_unnamed_354 * fragment_unnamed_348, fragment_unnamed_354 * fragment_unnamed_350), float2(fragment_unnamed_59 + (-0.0f), fragment_unnamed_60 + (-1.0f))), fragment_unnamed_315);
				float4 fragment_unnamed_388 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_390 = fragment_unnamed_388.w;
				discard_cond((((-0.0f) - max(((-0.0f) - (((-0.0f) - fragment_unnamed_390) + 1.0f)) + ((((-0.0f) - (mad((fragment_unnamed_59 * (fragment_unnamed_59 * fragment_unnamed_59)) * mad(fragment_unnamed_59, mad(fragment_unnamed_59, 6.0f, -15.0f), 10.0f), ((-0.0f) - fragment_unnamed_362) + mad(fragment_unnamed_250, ((-0.0f) - fragment_unnamed_233) + dot(float2(fragment_unnamed_137 * fragment_unnamed_130, fragment_unnamed_137 * fragment_unnamed_132), float2(fragment_unnamed_59 + (-1.0f), fragment_unnamed_60 + (-1.0f))), fragment_unnamed_233), fragment_unnamed_362) + 0.5f)) + mad(fragment_uniform_buffer_2[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f)) + 1.0f), 0.5f)) + fragment_unnamed_390) < 0.0f);
				float fragment_unnamed_420 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_421 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_465 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_465 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_420) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_420)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_465 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_421) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_421)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[1] = float4(_Dissolve, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 unity_MotionVectorsParams;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { float4x4 unity_PrevObjectToWorldArray; float4x4 unity_PrevWorldToObjectArray; } unity_Builtins3Array[2];

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[1];
			static float4 vertex_uniform_buffer_3[18];
			static float4 vertex_uniform_buffer_4[16];
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
			static float3 vertex_input_8;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float3 vertex_output_9;
			static uint vertex_output_10;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_input_8 : TEXCOORD4; // TEXCOORD_4
				uint gl_InstanceIndex : SV_InstanceID;
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float4 vertex_output_4 : INTERP1; // INTERP_1
				float4 vertex_output_5 : INTERP2; // INTERP_2
				float4 vertex_output_6 : INTERP3; // INTERP_3
				float4 vertex_output_7 : INTERP4; // INTERP_4
				float3 vertex_output_8 : INTERP5; // INTERP_5
				float3 vertex_output_9 : INTERP6; // INTERP_6
				uint vertex_output_10 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_71 = (uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_2[0u]).x;
				uint vertex_unnamed_72 = vertex_unnamed_71 * 9u;
				uint vertex_unnamed_84 = vertex_unnamed_72 + 3u;
				float vertex_unnamed_119 = asfloat(1065353216u);
				float vertex_unnamed_121 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72]).x), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_3[vertex_unnamed_84].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119));
				float vertex_unnamed_141 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72]).y), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_3[vertex_unnamed_84].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119));
				float vertex_unnamed_161 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72]).z), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_3[vertex_unnamed_84].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119));
				float vertex_unnamed_177 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_72 + 4u].xyz));
				float vertex_unnamed_193 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_72 + 5u].xyz));
				float vertex_unnamed_209 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_72 + 6u].xyz));
				float vertex_unnamed_218 = rsqrt(max(dot(float3(vertex_unnamed_177, vertex_unnamed_193, vertex_unnamed_209), float3(vertex_unnamed_177, vertex_unnamed_193, vertex_unnamed_209)), 1.1754943508222875079687365372222e-38f));
				vertex_output_9.x = vertex_unnamed_218 * vertex_unnamed_177;
				vertex_output_9.y = vertex_unnamed_218 * vertex_unnamed_193;
				vertex_output_9.z = vertex_unnamed_218 * vertex_unnamed_209;
				uint vertex_unnamed_228 = vertex_unnamed_72 + 1u;
				uint vertex_unnamed_247 = vertex_unnamed_72 + 2u;
				float vertex_unnamed_255 = mad(vertex_uniform_buffer_3[vertex_unnamed_247].x, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_72].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_228].x));
				float vertex_unnamed_256 = mad(vertex_uniform_buffer_3[vertex_unnamed_247].y, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_72].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_228].y));
				float vertex_unnamed_257 = mad(vertex_uniform_buffer_3[vertex_unnamed_247].z, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_72].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_228].z));
				float vertex_unnamed_262 = rsqrt(max(dot(float3(vertex_unnamed_255, vertex_unnamed_256, vertex_unnamed_257), float3(vertex_unnamed_255, vertex_unnamed_256, vertex_unnamed_257)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_255 * vertex_unnamed_262;
				vertex_output_3.y = vertex_unnamed_256 * vertex_unnamed_262;
				vertex_output_3.z = vertex_unnamed_257 * vertex_unnamed_262;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_161, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_161, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_161, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_370 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_383 = vertex_unnamed_370 ? vertex_input_8.x : vertex_input_0.x;
					float vertex_unnamed_384 = vertex_unnamed_370 ? vertex_input_8.y : vertex_input_0.y;
					float vertex_unnamed_385 = vertex_unnamed_370 ? vertex_input_8.z : vertex_input_0.z;
					uint vertex_unnamed_386 = vertex_unnamed_71 << 3u;
					uint vertex_unnamed_395 = vertex_unnamed_386 + 3u;
					float vertex_unnamed_421 = asfloat(1065353216u);
					float vertex_unnamed_422 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386]).x), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_4[vertex_unnamed_395].x), float4(vertex_unnamed_383, vertex_unnamed_384, vertex_unnamed_385, vertex_unnamed_421));
					float vertex_unnamed_442 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386]).y), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_4[vertex_unnamed_395].y), float4(vertex_unnamed_383, vertex_unnamed_384, vertex_unnamed_385, vertex_unnamed_421));
					float vertex_unnamed_462 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386]).z), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_4[vertex_unnamed_395].z), float4(vertex_unnamed_383, vertex_unnamed_384, vertex_unnamed_385, vertex_unnamed_421));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_462, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_422, vertex_unnamed_442 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_462, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_422, vertex_unnamed_442 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_462, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_422, vertex_unnamed_442 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_input_3.x;
				vertex_output_4.y = vertex_input_3.y;
				vertex_output_4.z = vertex_input_3.z;
				vertex_output_4.w = vertex_input_3.w;
				vertex_output_5.x = vertex_input_4.x;
				vertex_output_5.y = vertex_input_4.y;
				vertex_output_5.z = vertex_input_4.z;
				vertex_output_5.w = vertex_input_4.w;
				vertex_output_6.x = vertex_input_5.x;
				vertex_output_6.y = vertex_input_5.y;
				vertex_output_6.z = vertex_input_5.z;
				vertex_output_6.w = vertex_input_5.w;
				vertex_output_7.x = vertex_input_6.x;
				vertex_output_7.y = vertex_input_6.y;
				vertex_output_7.z = vertex_input_6.z;
				vertex_output_7.w = vertex_input_6.w;
				vertex_output_8.x = vertex_unnamed_121;
				vertex_output_8.y = vertex_unnamed_141;
				vertex_output_8.z = vertex_unnamed_161;
				vertex_output_10 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[32] = float4(_NonJitteredViewProjMatrix[0][0], _NonJitteredViewProjMatrix[1][0], _NonJitteredViewProjMatrix[2][0], _NonJitteredViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[33] = float4(_NonJitteredViewProjMatrix[0][1], _NonJitteredViewProjMatrix[1][1], _NonJitteredViewProjMatrix[2][1], _NonJitteredViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[34] = float4(_NonJitteredViewProjMatrix[0][2], _NonJitteredViewProjMatrix[1][2], _NonJitteredViewProjMatrix[2][2], _NonJitteredViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[35] = float4(_NonJitteredViewProjMatrix[0][3], _NonJitteredViewProjMatrix[1][3], _NonJitteredViewProjMatrix[2][3], _NonJitteredViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[40] = float4(_PrevViewProjMatrix[0][0], _PrevViewProjMatrix[1][0], _PrevViewProjMatrix[2][0], _PrevViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[41] = float4(_PrevViewProjMatrix[0][1], _PrevViewProjMatrix[1][1], _PrevViewProjMatrix[2][1], _PrevViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[42] = float4(_PrevViewProjMatrix[0][2], _PrevViewProjMatrix[1][2], _PrevViewProjMatrix[2][2], _PrevViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[43] = float4(_PrevViewProjMatrix[0][3], _PrevViewProjMatrix[1][3], _PrevViewProjMatrix[2][3], _PrevViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				vertex_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_2[0][1], vertex_uniform_buffer_2[0][2], vertex_uniform_buffer_2[0][3]);

				vertex_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_3[8][1], vertex_uniform_buffer_3[8][2], vertex_uniform_buffer_3[8][3]);
				vertex_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_3[17][1], vertex_uniform_buffer_3[17][2], vertex_uniform_buffer_3[17][3]);
				vertex_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_4[0] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][0]);
				vertex_uniform_buffer_4[1] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][1]);
				vertex_uniform_buffer_4[2] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][2]);
				vertex_uniform_buffer_4[3] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][3]);
				vertex_uniform_buffer_4[4] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][0]);
				vertex_uniform_buffer_4[5] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][1]);
				vertex_uniform_buffer_4[6] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][2]);
				vertex_uniform_buffer_4[7] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][3]);
				vertex_uniform_buffer_4[8] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][0]);
				vertex_uniform_buffer_4[9] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][1]);
				vertex_uniform_buffer_4[10] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][2]);
				vertex_uniform_buffer_4[11] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][3]);
				vertex_uniform_buffer_4[12] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][0]);
				vertex_uniform_buffer_4[13] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][1]);
				vertex_uniform_buffer_4[14] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][2]);
				vertex_uniform_buffer_4[15] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_8 = stage_input.vertex_input_8;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				stage_output.vertex_output_10 = vertex_output_10;
				return stage_output;
			}
			#endif
			#if (defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ScreenSize;
			float4 unity_MotionVectorsParams;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static uint fragment_input_10;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float4 fragment_input_6 : INTERP3; // INTERP_3
				float4 fragment_input_7 : INTERP4; // INTERP_4
				float3 fragment_input_8 : INTERP5; // INTERP_5
				float3 fragment_input_9 : INTERP6; // INTERP_6
				uint fragment_input_10 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_58 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_59 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_109 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_109 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_58) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_58)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_109 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_59) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_59)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				fragment_input_10 = stage_input.fragment_input_10;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 unity_MotionVectorsParams;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { float4x4 unity_PrevObjectToWorldArray; float4x4 unity_PrevWorldToObjectArray; } unity_Builtins3Array[2];

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[1];
			static float4 vertex_uniform_buffer_3[18];
			static float4 vertex_uniform_buffer_4[16];
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
			static float3 vertex_input_8;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float3 vertex_output_9;
			static uint vertex_output_10;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_input_8 : TEXCOORD4; // TEXCOORD_4
				uint gl_InstanceIndex : SV_InstanceID;
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float4 vertex_output_4 : INTERP1; // INTERP_1
				float4 vertex_output_5 : INTERP2; // INTERP_2
				float4 vertex_output_6 : INTERP3; // INTERP_3
				float4 vertex_output_7 : INTERP4; // INTERP_4
				float3 vertex_output_8 : INTERP5; // INTERP_5
				float3 vertex_output_9 : INTERP6; // INTERP_6
				uint vertex_output_10 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_71 = (uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_2[0u]).x;
				uint vertex_unnamed_72 = vertex_unnamed_71 * 9u;
				uint vertex_unnamed_84 = vertex_unnamed_72 + 3u;
				float vertex_unnamed_119 = asfloat(1065353216u);
				float vertex_unnamed_121 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72]).x), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_3[vertex_unnamed_84].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119));
				float vertex_unnamed_141 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72]).y), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_3[vertex_unnamed_84].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119));
				float vertex_unnamed_161 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72]).z), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_72 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_3[vertex_unnamed_84].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_119));
				float vertex_unnamed_177 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_72 + 4u].xyz));
				float vertex_unnamed_193 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_72 + 5u].xyz));
				float vertex_unnamed_209 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_72 + 6u].xyz));
				float vertex_unnamed_218 = rsqrt(max(dot(float3(vertex_unnamed_177, vertex_unnamed_193, vertex_unnamed_209), float3(vertex_unnamed_177, vertex_unnamed_193, vertex_unnamed_209)), 1.1754943508222875079687365372222e-38f));
				vertex_output_9.x = vertex_unnamed_218 * vertex_unnamed_177;
				vertex_output_9.y = vertex_unnamed_218 * vertex_unnamed_193;
				vertex_output_9.z = vertex_unnamed_218 * vertex_unnamed_209;
				uint vertex_unnamed_228 = vertex_unnamed_72 + 1u;
				uint vertex_unnamed_247 = vertex_unnamed_72 + 2u;
				float vertex_unnamed_255 = mad(vertex_uniform_buffer_3[vertex_unnamed_247].x, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_72].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_228].x));
				float vertex_unnamed_256 = mad(vertex_uniform_buffer_3[vertex_unnamed_247].y, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_72].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_228].y));
				float vertex_unnamed_257 = mad(vertex_uniform_buffer_3[vertex_unnamed_247].z, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_72].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_228].z));
				float vertex_unnamed_262 = rsqrt(max(dot(float3(vertex_unnamed_255, vertex_unnamed_256, vertex_unnamed_257), float3(vertex_unnamed_255, vertex_unnamed_256, vertex_unnamed_257)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_255 * vertex_unnamed_262;
				vertex_output_3.y = vertex_unnamed_256 * vertex_unnamed_262;
				vertex_output_3.z = vertex_unnamed_257 * vertex_unnamed_262;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_161, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_161, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_161, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_121, vertex_unnamed_141 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_370 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_383 = vertex_unnamed_370 ? vertex_input_8.x : vertex_input_0.x;
					float vertex_unnamed_384 = vertex_unnamed_370 ? vertex_input_8.y : vertex_input_0.y;
					float vertex_unnamed_385 = vertex_unnamed_370 ? vertex_input_8.z : vertex_input_0.z;
					uint vertex_unnamed_386 = vertex_unnamed_71 << 3u;
					uint vertex_unnamed_395 = vertex_unnamed_386 + 3u;
					float vertex_unnamed_421 = asfloat(1065353216u);
					float vertex_unnamed_422 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386]).x), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_4[vertex_unnamed_395].x), float4(vertex_unnamed_383, vertex_unnamed_384, vertex_unnamed_385, vertex_unnamed_421));
					float vertex_unnamed_442 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386]).y), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_4[vertex_unnamed_395].y), float4(vertex_unnamed_383, vertex_unnamed_384, vertex_unnamed_385, vertex_unnamed_421));
					float vertex_unnamed_462 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386]).z), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_386 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_4[vertex_unnamed_395].z), float4(vertex_unnamed_383, vertex_unnamed_384, vertex_unnamed_385, vertex_unnamed_421));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_462, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_422, vertex_unnamed_442 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_462, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_422, vertex_unnamed_442 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_462, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_422, vertex_unnamed_442 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_input_3.x;
				vertex_output_4.y = vertex_input_3.y;
				vertex_output_4.z = vertex_input_3.z;
				vertex_output_4.w = vertex_input_3.w;
				vertex_output_5.x = vertex_input_4.x;
				vertex_output_5.y = vertex_input_4.y;
				vertex_output_5.z = vertex_input_4.z;
				vertex_output_5.w = vertex_input_4.w;
				vertex_output_6.x = vertex_input_5.x;
				vertex_output_6.y = vertex_input_5.y;
				vertex_output_6.z = vertex_input_5.z;
				vertex_output_6.w = vertex_input_5.w;
				vertex_output_7.x = vertex_input_6.x;
				vertex_output_7.y = vertex_input_6.y;
				vertex_output_7.z = vertex_input_6.z;
				vertex_output_7.w = vertex_input_6.w;
				vertex_output_8.x = vertex_unnamed_121;
				vertex_output_8.y = vertex_unnamed_141;
				vertex_output_8.z = vertex_unnamed_161;
				vertex_output_10 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[32] = float4(_NonJitteredViewProjMatrix[0][0], _NonJitteredViewProjMatrix[1][0], _NonJitteredViewProjMatrix[2][0], _NonJitteredViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[33] = float4(_NonJitteredViewProjMatrix[0][1], _NonJitteredViewProjMatrix[1][1], _NonJitteredViewProjMatrix[2][1], _NonJitteredViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[34] = float4(_NonJitteredViewProjMatrix[0][2], _NonJitteredViewProjMatrix[1][2], _NonJitteredViewProjMatrix[2][2], _NonJitteredViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[35] = float4(_NonJitteredViewProjMatrix[0][3], _NonJitteredViewProjMatrix[1][3], _NonJitteredViewProjMatrix[2][3], _NonJitteredViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[40] = float4(_PrevViewProjMatrix[0][0], _PrevViewProjMatrix[1][0], _PrevViewProjMatrix[2][0], _PrevViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[41] = float4(_PrevViewProjMatrix[0][1], _PrevViewProjMatrix[1][1], _PrevViewProjMatrix[2][1], _PrevViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[42] = float4(_PrevViewProjMatrix[0][2], _PrevViewProjMatrix[1][2], _PrevViewProjMatrix[2][2], _PrevViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[43] = float4(_PrevViewProjMatrix[0][3], _PrevViewProjMatrix[1][3], _PrevViewProjMatrix[2][3], _PrevViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				vertex_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_2[0][1], vertex_uniform_buffer_2[0][2], vertex_uniform_buffer_2[0][3]);

				vertex_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_3[8][1], vertex_uniform_buffer_3[8][2], vertex_uniform_buffer_3[8][3]);
				vertex_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_3[17][1], vertex_uniform_buffer_3[17][2], vertex_uniform_buffer_3[17][3]);
				vertex_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_4[0] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][0]);
				vertex_uniform_buffer_4[1] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][1]);
				vertex_uniform_buffer_4[2] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][2]);
				vertex_uniform_buffer_4[3] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][3]);
				vertex_uniform_buffer_4[4] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][0]);
				vertex_uniform_buffer_4[5] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][1]);
				vertex_uniform_buffer_4[6] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][2]);
				vertex_uniform_buffer_4[7] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][3]);
				vertex_uniform_buffer_4[8] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][0]);
				vertex_uniform_buffer_4[9] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][1]);
				vertex_uniform_buffer_4[10] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][2]);
				vertex_uniform_buffer_4[11] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][3]);
				vertex_uniform_buffer_4[12] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][0]);
				vertex_uniform_buffer_4[13] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][1]);
				vertex_uniform_buffer_4[14] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][2]);
				vertex_uniform_buffer_4[15] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_8 = stage_input.vertex_input_8;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				stage_output.vertex_output_10 = vertex_output_10;
				return stage_output;
			}
			#endif
			#if (defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			float _Dissolve;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[2];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static uint fragment_input_10;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float4 fragment_input_6 : INTERP3; // INTERP_3
				float4 fragment_input_7 : INTERP4; // INTERP_4
				float3 fragment_input_8 : INTERP5; // INTERP_5
				float3 fragment_input_9 : INTERP6; // INTERP_6
				uint fragment_input_10 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_478)
			{
				if (fragment_unnamed_478)
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
				float fragment_unnamed_55 = fragment_input_4.x * 15.0f;
				float fragment_unnamed_57 = fragment_input_4.y * 15.0f;
				float fragment_unnamed_59 = floor(fragment_unnamed_55);
				float fragment_unnamed_60 = floor(fragment_unnamed_57);
				float fragment_unnamed_61 = frac(fragment_unnamed_55);
				float fragment_unnamed_62 = frac(fragment_unnamed_57);
				float fragment_unnamed_63 = fragment_unnamed_59 + 1.0f;
				float fragment_unnamed_65 = fragment_unnamed_60 + 1.0f;
				float fragment_unnamed_69 = fragment_unnamed_63 * 289.0f;
				float fragment_unnamed_70 = fragment_unnamed_65 * 289.0f;
				float fragment_unnamed_71 = (-0.0f) - fragment_unnamed_69;
				float fragment_unnamed_73 = (-0.0f) - fragment_unnamed_70;
				float fragment_unnamed_95 = frac(fragment_unnamed_63 * asfloat((fragment_unnamed_69 >= fragment_unnamed_71) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_63 * 289.0f) >= fragment_unnamed_71) ? 1133543424u : 3281027072u);
				float fragment_unnamed_99 = fragment_unnamed_95 * mad(fragment_unnamed_95, 34.0f, 1.0f);
				float fragment_unnamed_100 = fragment_unnamed_99 * 289.0f;
				bool fragment_unnamed_102 = fragment_unnamed_100 >= ((-0.0f) - fragment_unnamed_100);
				float fragment_unnamed_109 = mad(asfloat(fragment_unnamed_102 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_102 ? 996328615u : 3143812263u) * fragment_unnamed_99), frac(fragment_unnamed_65 * asfloat((fragment_unnamed_70 >= fragment_unnamed_73) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_65 * 289.0f) >= fragment_unnamed_73) ? 1133543424u : 3281027072u));
				float fragment_unnamed_111 = fragment_unnamed_109 * mad(fragment_unnamed_109, 34.0f, 1.0f);
				float fragment_unnamed_112 = fragment_unnamed_111 * 289.0f;
				bool fragment_unnamed_114 = fragment_unnamed_112 >= ((-0.0f) - fragment_unnamed_112);
				float fragment_unnamed_124 = frac((frac(asfloat(fragment_unnamed_114 ? 996328615u : 3143812263u) * fragment_unnamed_111) * asfloat(fragment_unnamed_114 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_125 = mad(fragment_unnamed_124, 2.0f, -1.0f);
				float fragment_unnamed_132 = ((-0.0f) - floor(mad(fragment_unnamed_124, 2.0f, -0.5f))) + fragment_unnamed_125;
				float fragment_unnamed_134 = abs(fragment_unnamed_125) + (-0.5f);
				float fragment_unnamed_139 = rsqrt(dot(float2(fragment_unnamed_132, fragment_unnamed_134), float2(fragment_unnamed_132, fragment_unnamed_134)));
				float fragment_unnamed_147 = fragment_unnamed_59 + 0.0f;
				float fragment_unnamed_149 = fragment_unnamed_60 + 1.0f;
				float fragment_unnamed_150 = fragment_unnamed_59 + 1.0f;
				float fragment_unnamed_151 = fragment_unnamed_60 + 0.0f;
				float fragment_unnamed_152 = fragment_unnamed_147 * 289.0f;
				float fragment_unnamed_153 = fragment_unnamed_149 * 289.0f;
				float fragment_unnamed_154 = fragment_unnamed_150 * 289.0f;
				float fragment_unnamed_155 = fragment_unnamed_151 * 289.0f;
				bool fragment_unnamed_160 = fragment_unnamed_152 >= ((-0.0f) - fragment_unnamed_152);
				bool fragment_unnamed_161 = fragment_unnamed_153 >= ((-0.0f) - fragment_unnamed_153);
				bool fragment_unnamed_162 = fragment_unnamed_154 >= ((-0.0f) - fragment_unnamed_154);
				bool fragment_unnamed_163 = fragment_unnamed_155 >= ((-0.0f) - fragment_unnamed_155);
				float fragment_unnamed_186 = frac(fragment_unnamed_147 * asfloat(fragment_unnamed_160 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_160 ? 1133543424u : 3281027072u);
				float fragment_unnamed_190 = frac(fragment_unnamed_150 * asfloat(fragment_unnamed_162 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_162 ? 1133543424u : 3281027072u);
				float fragment_unnamed_193 = fragment_unnamed_190 * mad(fragment_unnamed_190, 34.0f, 1.0f);
				float fragment_unnamed_194 = fragment_unnamed_193 * 289.0f;
				bool fragment_unnamed_196 = fragment_unnamed_194 >= ((-0.0f) - fragment_unnamed_194);
				float fragment_unnamed_203 = mad(asfloat(fragment_unnamed_196 ? 1133543424u : 3281027072u), frac(fragment_unnamed_193 * asfloat(fragment_unnamed_196 ? 996328615u : 3143812263u)), frac(fragment_unnamed_151 * asfloat(fragment_unnamed_163 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_163 ? 1133543424u : 3281027072u));
				float fragment_unnamed_205 = fragment_unnamed_203 * mad(fragment_unnamed_203, 34.0f, 1.0f);
				float fragment_unnamed_206 = fragment_unnamed_205 * 289.0f;
				bool fragment_unnamed_208 = fragment_unnamed_206 >= ((-0.0f) - fragment_unnamed_206);
				float fragment_unnamed_217 = frac((frac(asfloat(fragment_unnamed_208 ? 996328615u : 3143812263u) * fragment_unnamed_205) * asfloat(fragment_unnamed_208 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_218 = mad(fragment_unnamed_217, 2.0f, -1.0f);
				float fragment_unnamed_222 = ((-0.0f) - floor(mad(fragment_unnamed_217, 2.0f, -0.5f))) + fragment_unnamed_218;
				float fragment_unnamed_224 = abs(fragment_unnamed_218) + (-0.5f);
				float fragment_unnamed_228 = rsqrt(dot(float2(fragment_unnamed_222, fragment_unnamed_224), float2(fragment_unnamed_222, fragment_unnamed_224)));
				float fragment_unnamed_235 = dot(float2(fragment_unnamed_228 * fragment_unnamed_222, fragment_unnamed_228 * fragment_unnamed_224), float2(fragment_unnamed_61 + (-1.0f), fragment_unnamed_62 + (-0.0f)));
				float fragment_unnamed_252 = (fragment_unnamed_62 * (fragment_unnamed_62 * fragment_unnamed_62)) * mad(fragment_unnamed_62, mad(fragment_unnamed_62, 6.0f, -15.0f), 10.0f);
				float fragment_unnamed_256 = fragment_unnamed_59 * 289.0f;
				float fragment_unnamed_257 = fragment_unnamed_60 * 289.0f;
				float fragment_unnamed_258 = (-0.0f) - fragment_unnamed_256;
				float fragment_unnamed_259 = (-0.0f) - fragment_unnamed_257;
				float fragment_unnamed_276 = frac(fragment_unnamed_59 * asfloat((fragment_unnamed_256 >= fragment_unnamed_258) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_59 * 289.0f) >= fragment_unnamed_258) ? 1133543424u : 3281027072u);
				float fragment_unnamed_279 = fragment_unnamed_276 * mad(fragment_unnamed_276, 34.0f, 1.0f);
				float fragment_unnamed_280 = fragment_unnamed_279 * 289.0f;
				bool fragment_unnamed_282 = fragment_unnamed_280 >= ((-0.0f) - fragment_unnamed_280);
				float fragment_unnamed_289 = mad(asfloat(fragment_unnamed_282 ? 1133543424u : 3281027072u), frac(fragment_unnamed_279 * asfloat(fragment_unnamed_282 ? 996328615u : 3143812263u)), frac(fragment_unnamed_60 * asfloat((fragment_unnamed_257 >= fragment_unnamed_259) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_60 * 289.0f) >= fragment_unnamed_259) ? 1133543424u : 3281027072u));
				float fragment_unnamed_291 = fragment_unnamed_289 * mad(fragment_unnamed_289, 34.0f, 1.0f);
				float fragment_unnamed_292 = fragment_unnamed_291 * 289.0f;
				bool fragment_unnamed_294 = fragment_unnamed_292 >= ((-0.0f) - fragment_unnamed_292);
				float fragment_unnamed_303 = frac((frac(fragment_unnamed_291 * asfloat(fragment_unnamed_294 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_294 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_304 = mad(fragment_unnamed_303, 2.0f, -1.0f);
				float fragment_unnamed_308 = ((-0.0f) - floor(mad(fragment_unnamed_303, 2.0f, -0.5f))) + fragment_unnamed_304;
				float fragment_unnamed_310 = abs(fragment_unnamed_304) + (-0.5f);
				float fragment_unnamed_314 = rsqrt(dot(float2(fragment_unnamed_308, fragment_unnamed_310), float2(fragment_unnamed_308, fragment_unnamed_310)));
				float fragment_unnamed_317 = dot(float2(fragment_unnamed_314 * fragment_unnamed_308, fragment_unnamed_314 * fragment_unnamed_310), float2(fragment_unnamed_61, fragment_unnamed_62));
				float fragment_unnamed_321 = fragment_unnamed_186 * mad(fragment_unnamed_186, 34.0f, 1.0f);
				float fragment_unnamed_322 = fragment_unnamed_321 * 289.0f;
				bool fragment_unnamed_324 = fragment_unnamed_322 >= ((-0.0f) - fragment_unnamed_322);
				float fragment_unnamed_331 = mad(asfloat(fragment_unnamed_324 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_324 ? 996328615u : 3143812263u) * fragment_unnamed_321), frac(fragment_unnamed_149 * asfloat(fragment_unnamed_161 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_161 ? 1133543424u : 3281027072u));
				float fragment_unnamed_333 = fragment_unnamed_331 * mad(fragment_unnamed_331, 34.0f, 1.0f);
				float fragment_unnamed_334 = fragment_unnamed_333 * 289.0f;
				bool fragment_unnamed_336 = fragment_unnamed_334 >= ((-0.0f) - fragment_unnamed_334);
				float fragment_unnamed_345 = frac((frac(asfloat(fragment_unnamed_336 ? 996328615u : 3143812263u) * fragment_unnamed_333) * asfloat(fragment_unnamed_336 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_346 = mad(fragment_unnamed_345, 2.0f, -1.0f);
				float fragment_unnamed_350 = ((-0.0f) - floor(mad(fragment_unnamed_345, 2.0f, -0.5f))) + fragment_unnamed_346;
				float fragment_unnamed_352 = abs(fragment_unnamed_346) + (-0.5f);
				float fragment_unnamed_356 = rsqrt(dot(float2(fragment_unnamed_350, fragment_unnamed_352), float2(fragment_unnamed_350, fragment_unnamed_352)));
				float fragment_unnamed_364 = mad(fragment_unnamed_252, ((-0.0f) - fragment_unnamed_317) + dot(float2(fragment_unnamed_356 * fragment_unnamed_350, fragment_unnamed_356 * fragment_unnamed_352), float2(fragment_unnamed_61 + (-0.0f), fragment_unnamed_62 + (-1.0f))), fragment_unnamed_317);
				float4 fragment_unnamed_390 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_392 = fragment_unnamed_390.w;
				discard_cond((((-0.0f) - max(((-0.0f) - (((-0.0f) - fragment_unnamed_392) + 1.0f)) + ((((-0.0f) - (mad((fragment_unnamed_61 * (fragment_unnamed_61 * fragment_unnamed_61)) * mad(fragment_unnamed_61, mad(fragment_unnamed_61, 6.0f, -15.0f), 10.0f), ((-0.0f) - fragment_unnamed_364) + mad(fragment_unnamed_252, ((-0.0f) - fragment_unnamed_235) + dot(float2(fragment_unnamed_139 * fragment_unnamed_132, fragment_unnamed_139 * fragment_unnamed_134), float2(fragment_unnamed_61 + (-1.0f), fragment_unnamed_62 + (-1.0f))), fragment_unnamed_235), fragment_unnamed_364) + 0.5f)) + mad(fragment_uniform_buffer_2[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f)) + 1.0f), 0.5f)) + fragment_unnamed_392) < 0.0f);
				float fragment_unnamed_422 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_423 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_467 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_467 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_422) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_422)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_467 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_423) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_423)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[1] = float4(_Dissolve, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				fragment_input_10 = stage_input.fragment_input_10;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _Dissolve;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[1];
			static float4 fragment_uniform_buffer_3[18];
			static float4 fragment_uniform_buffer_4[2];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static uint fragment_input_10;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float4 fragment_input_6 : INTERP3; // INTERP_3
				float4 fragment_input_7 : INTERP4; // INTERP_4
				float3 fragment_input_8 : INTERP5; // INTERP_5
				float3 fragment_input_9 : INTERP6; // INTERP_6
				nointerpolation uint fragment_input_10 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
			};

			static bool discard_state;

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

			void discard_cond(bool fragment_unnamed_579)
			{
				if (fragment_unnamed_579)
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
				float fragment_unnamed_65 = fragment_input_4.x * 15.0f;
				float fragment_unnamed_67 = fragment_input_4.y * 15.0f;
				float fragment_unnamed_69 = floor(fragment_unnamed_65);
				float fragment_unnamed_70 = floor(fragment_unnamed_67);
				float fragment_unnamed_71 = frac(fragment_unnamed_65);
				float fragment_unnamed_72 = frac(fragment_unnamed_67);
				float fragment_unnamed_73 = fragment_unnamed_69 + 1.0f;
				float fragment_unnamed_75 = fragment_unnamed_70 + 1.0f;
				float fragment_unnamed_79 = fragment_unnamed_73 * 289.0f;
				float fragment_unnamed_80 = fragment_unnamed_75 * 289.0f;
				float fragment_unnamed_81 = (-0.0f) - fragment_unnamed_79;
				float fragment_unnamed_83 = (-0.0f) - fragment_unnamed_80;
				float fragment_unnamed_105 = frac(fragment_unnamed_73 * asfloat((fragment_unnamed_79 >= fragment_unnamed_81) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_73 * 289.0f) >= fragment_unnamed_81) ? 1133543424u : 3281027072u);
				float fragment_unnamed_109 = fragment_unnamed_105 * mad(fragment_unnamed_105, 34.0f, 1.0f);
				float fragment_unnamed_110 = fragment_unnamed_109 * 289.0f;
				bool fragment_unnamed_112 = fragment_unnamed_110 >= ((-0.0f) - fragment_unnamed_110);
				float fragment_unnamed_119 = mad(asfloat(fragment_unnamed_112 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_112 ? 996328615u : 3143812263u) * fragment_unnamed_109), frac(fragment_unnamed_75 * asfloat((fragment_unnamed_80 >= fragment_unnamed_83) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_75 * 289.0f) >= fragment_unnamed_83) ? 1133543424u : 3281027072u));
				float fragment_unnamed_121 = fragment_unnamed_119 * mad(fragment_unnamed_119, 34.0f, 1.0f);
				float fragment_unnamed_122 = fragment_unnamed_121 * 289.0f;
				bool fragment_unnamed_124 = fragment_unnamed_122 >= ((-0.0f) - fragment_unnamed_122);
				float fragment_unnamed_134 = frac((frac(asfloat(fragment_unnamed_124 ? 996328615u : 3143812263u) * fragment_unnamed_121) * asfloat(fragment_unnamed_124 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_135 = mad(fragment_unnamed_134, 2.0f, -1.0f);
				float fragment_unnamed_142 = ((-0.0f) - floor(mad(fragment_unnamed_134, 2.0f, -0.5f))) + fragment_unnamed_135;
				float fragment_unnamed_144 = abs(fragment_unnamed_135) + (-0.5f);
				float fragment_unnamed_149 = rsqrt(dot(float2(fragment_unnamed_142, fragment_unnamed_144), float2(fragment_unnamed_142, fragment_unnamed_144)));
				float fragment_unnamed_157 = fragment_unnamed_69 + 0.0f;
				float fragment_unnamed_159 = fragment_unnamed_70 + 1.0f;
				float fragment_unnamed_160 = fragment_unnamed_69 + 1.0f;
				float fragment_unnamed_161 = fragment_unnamed_70 + 0.0f;
				float fragment_unnamed_162 = fragment_unnamed_157 * 289.0f;
				float fragment_unnamed_163 = fragment_unnamed_159 * 289.0f;
				float fragment_unnamed_164 = fragment_unnamed_160 * 289.0f;
				float fragment_unnamed_165 = fragment_unnamed_161 * 289.0f;
				bool fragment_unnamed_170 = fragment_unnamed_162 >= ((-0.0f) - fragment_unnamed_162);
				bool fragment_unnamed_171 = fragment_unnamed_163 >= ((-0.0f) - fragment_unnamed_163);
				bool fragment_unnamed_172 = fragment_unnamed_164 >= ((-0.0f) - fragment_unnamed_164);
				bool fragment_unnamed_173 = fragment_unnamed_165 >= ((-0.0f) - fragment_unnamed_165);
				float fragment_unnamed_196 = frac(fragment_unnamed_157 * asfloat(fragment_unnamed_170 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_170 ? 1133543424u : 3281027072u);
				float fragment_unnamed_200 = frac(fragment_unnamed_160 * asfloat(fragment_unnamed_172 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_172 ? 1133543424u : 3281027072u);
				float fragment_unnamed_203 = fragment_unnamed_200 * mad(fragment_unnamed_200, 34.0f, 1.0f);
				float fragment_unnamed_204 = fragment_unnamed_203 * 289.0f;
				bool fragment_unnamed_206 = fragment_unnamed_204 >= ((-0.0f) - fragment_unnamed_204);
				float fragment_unnamed_213 = mad(asfloat(fragment_unnamed_206 ? 1133543424u : 3281027072u), frac(fragment_unnamed_203 * asfloat(fragment_unnamed_206 ? 996328615u : 3143812263u)), frac(fragment_unnamed_161 * asfloat(fragment_unnamed_173 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_173 ? 1133543424u : 3281027072u));
				float fragment_unnamed_215 = fragment_unnamed_213 * mad(fragment_unnamed_213, 34.0f, 1.0f);
				float fragment_unnamed_216 = fragment_unnamed_215 * 289.0f;
				bool fragment_unnamed_218 = fragment_unnamed_216 >= ((-0.0f) - fragment_unnamed_216);
				float fragment_unnamed_227 = frac((frac(asfloat(fragment_unnamed_218 ? 996328615u : 3143812263u) * fragment_unnamed_215) * asfloat(fragment_unnamed_218 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_228 = mad(fragment_unnamed_227, 2.0f, -1.0f);
				float fragment_unnamed_232 = ((-0.0f) - floor(mad(fragment_unnamed_227, 2.0f, -0.5f))) + fragment_unnamed_228;
				float fragment_unnamed_234 = abs(fragment_unnamed_228) + (-0.5f);
				float fragment_unnamed_238 = rsqrt(dot(float2(fragment_unnamed_232, fragment_unnamed_234), float2(fragment_unnamed_232, fragment_unnamed_234)));
				float fragment_unnamed_245 = dot(float2(fragment_unnamed_238 * fragment_unnamed_232, fragment_unnamed_238 * fragment_unnamed_234), float2(fragment_unnamed_71 + (-1.0f), fragment_unnamed_72 + (-0.0f)));
				float fragment_unnamed_262 = (fragment_unnamed_72 * (fragment_unnamed_72 * fragment_unnamed_72)) * mad(fragment_unnamed_72, mad(fragment_unnamed_72, 6.0f, -15.0f), 10.0f);
				float fragment_unnamed_266 = fragment_unnamed_69 * 289.0f;
				float fragment_unnamed_267 = fragment_unnamed_70 * 289.0f;
				float fragment_unnamed_268 = (-0.0f) - fragment_unnamed_266;
				float fragment_unnamed_269 = (-0.0f) - fragment_unnamed_267;
				float fragment_unnamed_286 = frac(fragment_unnamed_69 * asfloat((fragment_unnamed_266 >= fragment_unnamed_268) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_69 * 289.0f) >= fragment_unnamed_268) ? 1133543424u : 3281027072u);
				float fragment_unnamed_289 = fragment_unnamed_286 * mad(fragment_unnamed_286, 34.0f, 1.0f);
				float fragment_unnamed_290 = fragment_unnamed_289 * 289.0f;
				bool fragment_unnamed_292 = fragment_unnamed_290 >= ((-0.0f) - fragment_unnamed_290);
				float fragment_unnamed_299 = mad(asfloat(fragment_unnamed_292 ? 1133543424u : 3281027072u), frac(fragment_unnamed_289 * asfloat(fragment_unnamed_292 ? 996328615u : 3143812263u)), frac(fragment_unnamed_70 * asfloat((fragment_unnamed_267 >= fragment_unnamed_269) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_70 * 289.0f) >= fragment_unnamed_269) ? 1133543424u : 3281027072u));
				float fragment_unnamed_301 = fragment_unnamed_299 * mad(fragment_unnamed_299, 34.0f, 1.0f);
				float fragment_unnamed_302 = fragment_unnamed_301 * 289.0f;
				bool fragment_unnamed_304 = fragment_unnamed_302 >= ((-0.0f) - fragment_unnamed_302);
				float fragment_unnamed_313 = frac((frac(fragment_unnamed_301 * asfloat(fragment_unnamed_304 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_304 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_314 = mad(fragment_unnamed_313, 2.0f, -1.0f);
				float fragment_unnamed_318 = ((-0.0f) - floor(mad(fragment_unnamed_313, 2.0f, -0.5f))) + fragment_unnamed_314;
				float fragment_unnamed_320 = abs(fragment_unnamed_314) + (-0.5f);
				float fragment_unnamed_324 = rsqrt(dot(float2(fragment_unnamed_318, fragment_unnamed_320), float2(fragment_unnamed_318, fragment_unnamed_320)));
				float fragment_unnamed_327 = dot(float2(fragment_unnamed_324 * fragment_unnamed_318, fragment_unnamed_324 * fragment_unnamed_320), float2(fragment_unnamed_71, fragment_unnamed_72));
				float fragment_unnamed_331 = fragment_unnamed_196 * mad(fragment_unnamed_196, 34.0f, 1.0f);
				float fragment_unnamed_332 = fragment_unnamed_331 * 289.0f;
				bool fragment_unnamed_334 = fragment_unnamed_332 >= ((-0.0f) - fragment_unnamed_332);
				float fragment_unnamed_341 = mad(asfloat(fragment_unnamed_334 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_334 ? 996328615u : 3143812263u) * fragment_unnamed_331), frac(fragment_unnamed_159 * asfloat(fragment_unnamed_171 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_171 ? 1133543424u : 3281027072u));
				float fragment_unnamed_343 = fragment_unnamed_341 * mad(fragment_unnamed_341, 34.0f, 1.0f);
				float fragment_unnamed_344 = fragment_unnamed_343 * 289.0f;
				bool fragment_unnamed_346 = fragment_unnamed_344 >= ((-0.0f) - fragment_unnamed_344);
				float fragment_unnamed_355 = frac((frac(asfloat(fragment_unnamed_346 ? 996328615u : 3143812263u) * fragment_unnamed_343) * asfloat(fragment_unnamed_346 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_356 = mad(fragment_unnamed_355, 2.0f, -1.0f);
				float fragment_unnamed_360 = ((-0.0f) - floor(mad(fragment_unnamed_355, 2.0f, -0.5f))) + fragment_unnamed_356;
				float fragment_unnamed_362 = abs(fragment_unnamed_356) + (-0.5f);
				float fragment_unnamed_366 = rsqrt(dot(float2(fragment_unnamed_360, fragment_unnamed_362), float2(fragment_unnamed_360, fragment_unnamed_362)));
				float fragment_unnamed_374 = mad(fragment_unnamed_262, ((-0.0f) - fragment_unnamed_327) + dot(float2(fragment_unnamed_366 * fragment_unnamed_360, fragment_unnamed_366 * fragment_unnamed_362), float2(fragment_unnamed_71 + (-0.0f), fragment_unnamed_72 + (-1.0f))), fragment_unnamed_327);
				float4 fragment_unnamed_400 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_402 = fragment_unnamed_400.w;
				discard_cond((((-0.0f) - max(((-0.0f) - (((-0.0f) - fragment_unnamed_402) + 1.0f)) + ((((-0.0f) - (mad((fragment_unnamed_71 * (fragment_unnamed_71 * fragment_unnamed_71)) * mad(fragment_unnamed_71, mad(fragment_unnamed_71, 6.0f, -15.0f), 10.0f), ((-0.0f) - fragment_unnamed_374) + mad(fragment_unnamed_262, ((-0.0f) - fragment_unnamed_245) + dot(float2(fragment_unnamed_149 * fragment_unnamed_142, fragment_unnamed_149 * fragment_unnamed_144), float2(fragment_unnamed_71 + (-1.0f), fragment_unnamed_72 + (-1.0f))), fragment_unnamed_245), fragment_unnamed_374) + 0.5f)) + mad(fragment_uniform_buffer_4[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f)) + 1.0f), 0.5f)) + fragment_unnamed_402) < 0.0f);
				float fragment_unnamed_432 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_433 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_477 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_477 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_432) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_432)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_477 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_433) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_433)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_504 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_511 = fragment_unnamed_504 * fragment_input_9.x;
				float fragment_unnamed_512 = fragment_unnamed_504 * fragment_input_9.y;
				float fragment_unnamed_513 = fragment_unnamed_504 * fragment_input_9.z;
				float fragment_unnamed_522 = 1.0f / max(dot(float3(abs(fragment_unnamed_511), abs(fragment_unnamed_512), abs(fragment_unnamed_513)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_527 = clamp((-0.0f) - (fragment_unnamed_522 * fragment_unnamed_513), 0.0f, 1.0f);
				float fragment_unnamed_530 = (-0.0f) - fragment_unnamed_527;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_511, fragment_unnamed_522, ((fragment_unnamed_522 * fragment_unnamed_511) >= 0.0f) ? fragment_unnamed_527 : fragment_unnamed_530), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_512, fragment_unnamed_522, ((fragment_unnamed_522 * fragment_unnamed_512) >= 0.0f) ? fragment_unnamed_527 : fragment_unnamed_530), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_548 = (fragment_input_10 + asuint(fragment_uniform_buffer_2[0u]).x) * 9u;
				uint fragment_unnamed_558 = 8u & 31u;
				fragment_output_1.y = float(255u & asuint(fragment_uniform_buffer_3[fragment_unnamed_548 + 8u]).x) * 0.0039215688593685626983642578125f;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_3[fragment_unnamed_548 + 8u]).x, fragment_unnamed_558, min((8u & 31u), (32u - fragment_unnamed_558)))) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_3[8][1], fragment_uniform_buffer_3[8][2], fragment_uniform_buffer_3[8][3]);
				fragment_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_3[17][1], fragment_uniform_buffer_3[17][2], fragment_uniform_buffer_3[17][3]);
				fragment_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_uniform_buffer_4[1] = float4(_Dissolve, fragment_uniform_buffer_4[1][1], fragment_uniform_buffer_4[1][2], fragment_uniform_buffer_4[1][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				fragment_input_10 = stage_input.fragment_input_10;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}

			#endif
			#if (defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 _ScreenSize;
			float4 unity_MotionVectorsParams;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[1];
			static float4 fragment_uniform_buffer_3[18];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static uint fragment_input_10;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float4 fragment_input_6 : INTERP3; // INTERP_3
				float4 fragment_input_7 : INTERP4; // INTERP_4
				float3 fragment_input_8 : INTERP5; // INTERP_5
				float3 fragment_input_9 : INTERP6; // INTERP_6
				nointerpolation uint fragment_input_10 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
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

			void frag_main()
			{
				float fragment_unnamed_68 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_69 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_119 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_119 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_68) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_68)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_119 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_69) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_69)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_147 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_155 = fragment_unnamed_147 * fragment_input_9.x;
				float fragment_unnamed_156 = fragment_unnamed_147 * fragment_input_9.y;
				float fragment_unnamed_157 = fragment_unnamed_147 * fragment_input_9.z;
				float fragment_unnamed_166 = 1.0f / max(dot(float3(abs(fragment_unnamed_155), abs(fragment_unnamed_156), abs(fragment_unnamed_157)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_171 = clamp((-0.0f) - (fragment_unnamed_166 * fragment_unnamed_157), 0.0f, 1.0f);
				float fragment_unnamed_174 = (-0.0f) - fragment_unnamed_171;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_155, fragment_unnamed_166, ((fragment_unnamed_166 * fragment_unnamed_155) >= 0.0f) ? fragment_unnamed_171 : fragment_unnamed_174), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_156, fragment_unnamed_166, ((fragment_unnamed_166 * fragment_unnamed_156) >= 0.0f) ? fragment_unnamed_171 : fragment_unnamed_174), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_192 = (fragment_input_10 + asuint(fragment_uniform_buffer_2[0u]).x) * 9u;
				uint fragment_unnamed_202 = 8u & 31u;
				fragment_output_1.y = float(255u & asuint(fragment_uniform_buffer_3[fragment_unnamed_192 + 8u]).x) * 0.0039215688593685626983642578125f;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_3[fragment_unnamed_192 + 8u]).x, fragment_unnamed_202, min((8u & 31u), (32u - fragment_unnamed_202)))) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_3[8][1], fragment_uniform_buffer_3[8][2], fragment_uniform_buffer_3[8][3]);
				fragment_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_3[17][1], fragment_uniform_buffer_3[17][2], fragment_uniform_buffer_3[17][3]);
				fragment_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				fragment_input_10 = stage_input.fragment_input_10;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 _ScreenSize;
			float4 unity_RenderingLayer;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float4 fragment_input_6 : INTERP3; // INTERP_3
				float4 fragment_input_7 : INTERP4; // INTERP_4
				float3 fragment_input_8 : INTERP5; // INTERP_5
				float3 fragment_input_9 : INTERP6; // INTERP_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
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

			void frag_main()
			{
				float fragment_unnamed_57 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_58 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_108 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_108 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_57) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_57)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_108 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_58) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_58)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_136 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_144 = fragment_unnamed_136 * fragment_input_9.x;
				float fragment_unnamed_145 = fragment_unnamed_136 * fragment_input_9.y;
				float fragment_unnamed_146 = fragment_unnamed_136 * fragment_input_9.z;
				float fragment_unnamed_155 = 1.0f / max(dot(float3(abs(fragment_unnamed_144), abs(fragment_unnamed_145), abs(fragment_unnamed_146)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_160 = clamp((-0.0f) - (fragment_unnamed_155 * fragment_unnamed_146), 0.0f, 1.0f);
				float fragment_unnamed_163 = (-0.0f) - fragment_unnamed_160;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_144, fragment_unnamed_155, ((fragment_unnamed_155 * fragment_unnamed_144) >= 0.0f) ? fragment_unnamed_160 : fragment_unnamed_163), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_145, fragment_unnamed_155, ((fragment_unnamed_155 * fragment_unnamed_145) >= 0.0f) ? fragment_unnamed_160 : fragment_unnamed_163), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_183 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_183, min((8u & 31u), (32u - fragment_unnamed_183)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Dissolve;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[2];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float4 fragment_input_6 : INTERP3; // INTERP_3
				float4 fragment_input_7 : INTERP4; // INTERP_4
				float3 fragment_input_8 : INTERP5; // INTERP_5
				float3 fragment_input_9 : INTERP6; // INTERP_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
			};

			static bool discard_state;

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

			void discard_cond(bool fragment_unnamed_559)
			{
				if (fragment_unnamed_559)
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
				float fragment_unnamed_54 = fragment_input_4.x * 15.0f;
				float fragment_unnamed_56 = fragment_input_4.y * 15.0f;
				float fragment_unnamed_58 = floor(fragment_unnamed_54);
				float fragment_unnamed_59 = floor(fragment_unnamed_56);
				float fragment_unnamed_60 = frac(fragment_unnamed_54);
				float fragment_unnamed_61 = frac(fragment_unnamed_56);
				float fragment_unnamed_62 = fragment_unnamed_58 + 1.0f;
				float fragment_unnamed_64 = fragment_unnamed_59 + 1.0f;
				float fragment_unnamed_68 = fragment_unnamed_62 * 289.0f;
				float fragment_unnamed_69 = fragment_unnamed_64 * 289.0f;
				float fragment_unnamed_70 = (-0.0f) - fragment_unnamed_68;
				float fragment_unnamed_72 = (-0.0f) - fragment_unnamed_69;
				float fragment_unnamed_94 = frac(fragment_unnamed_62 * asfloat((fragment_unnamed_68 >= fragment_unnamed_70) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_62 * 289.0f) >= fragment_unnamed_70) ? 1133543424u : 3281027072u);
				float fragment_unnamed_98 = fragment_unnamed_94 * mad(fragment_unnamed_94, 34.0f, 1.0f);
				float fragment_unnamed_99 = fragment_unnamed_98 * 289.0f;
				bool fragment_unnamed_101 = fragment_unnamed_99 >= ((-0.0f) - fragment_unnamed_99);
				float fragment_unnamed_108 = mad(asfloat(fragment_unnamed_101 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_101 ? 996328615u : 3143812263u) * fragment_unnamed_98), frac(fragment_unnamed_64 * asfloat((fragment_unnamed_69 >= fragment_unnamed_72) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_64 * 289.0f) >= fragment_unnamed_72) ? 1133543424u : 3281027072u));
				float fragment_unnamed_110 = fragment_unnamed_108 * mad(fragment_unnamed_108, 34.0f, 1.0f);
				float fragment_unnamed_111 = fragment_unnamed_110 * 289.0f;
				bool fragment_unnamed_113 = fragment_unnamed_111 >= ((-0.0f) - fragment_unnamed_111);
				float fragment_unnamed_123 = frac((frac(asfloat(fragment_unnamed_113 ? 996328615u : 3143812263u) * fragment_unnamed_110) * asfloat(fragment_unnamed_113 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_124 = mad(fragment_unnamed_123, 2.0f, -1.0f);
				float fragment_unnamed_131 = ((-0.0f) - floor(mad(fragment_unnamed_123, 2.0f, -0.5f))) + fragment_unnamed_124;
				float fragment_unnamed_133 = abs(fragment_unnamed_124) + (-0.5f);
				float fragment_unnamed_138 = rsqrt(dot(float2(fragment_unnamed_131, fragment_unnamed_133), float2(fragment_unnamed_131, fragment_unnamed_133)));
				float fragment_unnamed_146 = fragment_unnamed_58 + 0.0f;
				float fragment_unnamed_148 = fragment_unnamed_59 + 1.0f;
				float fragment_unnamed_149 = fragment_unnamed_58 + 1.0f;
				float fragment_unnamed_150 = fragment_unnamed_59 + 0.0f;
				float fragment_unnamed_151 = fragment_unnamed_146 * 289.0f;
				float fragment_unnamed_152 = fragment_unnamed_148 * 289.0f;
				float fragment_unnamed_153 = fragment_unnamed_149 * 289.0f;
				float fragment_unnamed_154 = fragment_unnamed_150 * 289.0f;
				bool fragment_unnamed_159 = fragment_unnamed_151 >= ((-0.0f) - fragment_unnamed_151);
				bool fragment_unnamed_160 = fragment_unnamed_152 >= ((-0.0f) - fragment_unnamed_152);
				bool fragment_unnamed_161 = fragment_unnamed_153 >= ((-0.0f) - fragment_unnamed_153);
				bool fragment_unnamed_162 = fragment_unnamed_154 >= ((-0.0f) - fragment_unnamed_154);
				float fragment_unnamed_185 = frac(fragment_unnamed_146 * asfloat(fragment_unnamed_159 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_159 ? 1133543424u : 3281027072u);
				float fragment_unnamed_189 = frac(fragment_unnamed_149 * asfloat(fragment_unnamed_161 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_161 ? 1133543424u : 3281027072u);
				float fragment_unnamed_192 = fragment_unnamed_189 * mad(fragment_unnamed_189, 34.0f, 1.0f);
				float fragment_unnamed_193 = fragment_unnamed_192 * 289.0f;
				bool fragment_unnamed_195 = fragment_unnamed_193 >= ((-0.0f) - fragment_unnamed_193);
				float fragment_unnamed_202 = mad(asfloat(fragment_unnamed_195 ? 1133543424u : 3281027072u), frac(fragment_unnamed_192 * asfloat(fragment_unnamed_195 ? 996328615u : 3143812263u)), frac(fragment_unnamed_150 * asfloat(fragment_unnamed_162 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_162 ? 1133543424u : 3281027072u));
				float fragment_unnamed_204 = fragment_unnamed_202 * mad(fragment_unnamed_202, 34.0f, 1.0f);
				float fragment_unnamed_205 = fragment_unnamed_204 * 289.0f;
				bool fragment_unnamed_207 = fragment_unnamed_205 >= ((-0.0f) - fragment_unnamed_205);
				float fragment_unnamed_216 = frac((frac(asfloat(fragment_unnamed_207 ? 996328615u : 3143812263u) * fragment_unnamed_204) * asfloat(fragment_unnamed_207 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_217 = mad(fragment_unnamed_216, 2.0f, -1.0f);
				float fragment_unnamed_221 = ((-0.0f) - floor(mad(fragment_unnamed_216, 2.0f, -0.5f))) + fragment_unnamed_217;
				float fragment_unnamed_223 = abs(fragment_unnamed_217) + (-0.5f);
				float fragment_unnamed_227 = rsqrt(dot(float2(fragment_unnamed_221, fragment_unnamed_223), float2(fragment_unnamed_221, fragment_unnamed_223)));
				float fragment_unnamed_234 = dot(float2(fragment_unnamed_227 * fragment_unnamed_221, fragment_unnamed_227 * fragment_unnamed_223), float2(fragment_unnamed_60 + (-1.0f), fragment_unnamed_61 + (-0.0f)));
				float fragment_unnamed_251 = (fragment_unnamed_61 * (fragment_unnamed_61 * fragment_unnamed_61)) * mad(fragment_unnamed_61, mad(fragment_unnamed_61, 6.0f, -15.0f), 10.0f);
				float fragment_unnamed_255 = fragment_unnamed_58 * 289.0f;
				float fragment_unnamed_256 = fragment_unnamed_59 * 289.0f;
				float fragment_unnamed_257 = (-0.0f) - fragment_unnamed_255;
				float fragment_unnamed_258 = (-0.0f) - fragment_unnamed_256;
				float fragment_unnamed_275 = frac(fragment_unnamed_58 * asfloat((fragment_unnamed_255 >= fragment_unnamed_257) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_58 * 289.0f) >= fragment_unnamed_257) ? 1133543424u : 3281027072u);
				float fragment_unnamed_278 = fragment_unnamed_275 * mad(fragment_unnamed_275, 34.0f, 1.0f);
				float fragment_unnamed_279 = fragment_unnamed_278 * 289.0f;
				bool fragment_unnamed_281 = fragment_unnamed_279 >= ((-0.0f) - fragment_unnamed_279);
				float fragment_unnamed_288 = mad(asfloat(fragment_unnamed_281 ? 1133543424u : 3281027072u), frac(fragment_unnamed_278 * asfloat(fragment_unnamed_281 ? 996328615u : 3143812263u)), frac(fragment_unnamed_59 * asfloat((fragment_unnamed_256 >= fragment_unnamed_258) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_59 * 289.0f) >= fragment_unnamed_258) ? 1133543424u : 3281027072u));
				float fragment_unnamed_290 = fragment_unnamed_288 * mad(fragment_unnamed_288, 34.0f, 1.0f);
				float fragment_unnamed_291 = fragment_unnamed_290 * 289.0f;
				bool fragment_unnamed_293 = fragment_unnamed_291 >= ((-0.0f) - fragment_unnamed_291);
				float fragment_unnamed_302 = frac((frac(fragment_unnamed_290 * asfloat(fragment_unnamed_293 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_293 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_303 = mad(fragment_unnamed_302, 2.0f, -1.0f);
				float fragment_unnamed_307 = ((-0.0f) - floor(mad(fragment_unnamed_302, 2.0f, -0.5f))) + fragment_unnamed_303;
				float fragment_unnamed_309 = abs(fragment_unnamed_303) + (-0.5f);
				float fragment_unnamed_313 = rsqrt(dot(float2(fragment_unnamed_307, fragment_unnamed_309), float2(fragment_unnamed_307, fragment_unnamed_309)));
				float fragment_unnamed_316 = dot(float2(fragment_unnamed_313 * fragment_unnamed_307, fragment_unnamed_313 * fragment_unnamed_309), float2(fragment_unnamed_60, fragment_unnamed_61));
				float fragment_unnamed_320 = fragment_unnamed_185 * mad(fragment_unnamed_185, 34.0f, 1.0f);
				float fragment_unnamed_321 = fragment_unnamed_320 * 289.0f;
				bool fragment_unnamed_323 = fragment_unnamed_321 >= ((-0.0f) - fragment_unnamed_321);
				float fragment_unnamed_330 = mad(asfloat(fragment_unnamed_323 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_323 ? 996328615u : 3143812263u) * fragment_unnamed_320), frac(fragment_unnamed_148 * asfloat(fragment_unnamed_160 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_160 ? 1133543424u : 3281027072u));
				float fragment_unnamed_332 = fragment_unnamed_330 * mad(fragment_unnamed_330, 34.0f, 1.0f);
				float fragment_unnamed_333 = fragment_unnamed_332 * 289.0f;
				bool fragment_unnamed_335 = fragment_unnamed_333 >= ((-0.0f) - fragment_unnamed_333);
				float fragment_unnamed_344 = frac((frac(asfloat(fragment_unnamed_335 ? 996328615u : 3143812263u) * fragment_unnamed_332) * asfloat(fragment_unnamed_335 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_345 = mad(fragment_unnamed_344, 2.0f, -1.0f);
				float fragment_unnamed_349 = ((-0.0f) - floor(mad(fragment_unnamed_344, 2.0f, -0.5f))) + fragment_unnamed_345;
				float fragment_unnamed_351 = abs(fragment_unnamed_345) + (-0.5f);
				float fragment_unnamed_355 = rsqrt(dot(float2(fragment_unnamed_349, fragment_unnamed_351), float2(fragment_unnamed_349, fragment_unnamed_351)));
				float fragment_unnamed_363 = mad(fragment_unnamed_251, ((-0.0f) - fragment_unnamed_316) + dot(float2(fragment_unnamed_355 * fragment_unnamed_349, fragment_unnamed_355 * fragment_unnamed_351), float2(fragment_unnamed_60 + (-0.0f), fragment_unnamed_61 + (-1.0f))), fragment_unnamed_316);
				float4 fragment_unnamed_389 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_391 = fragment_unnamed_389.w;
				discard_cond((((-0.0f) - max(((-0.0f) - (((-0.0f) - fragment_unnamed_391) + 1.0f)) + ((((-0.0f) - (mad((fragment_unnamed_60 * (fragment_unnamed_60 * fragment_unnamed_60)) * mad(fragment_unnamed_60, mad(fragment_unnamed_60, 6.0f, -15.0f), 10.0f), ((-0.0f) - fragment_unnamed_363) + mad(fragment_unnamed_251, ((-0.0f) - fragment_unnamed_234) + dot(float2(fragment_unnamed_138 * fragment_unnamed_131, fragment_unnamed_138 * fragment_unnamed_133), float2(fragment_unnamed_60 + (-1.0f), fragment_unnamed_61 + (-1.0f))), fragment_unnamed_234), fragment_unnamed_363) + 0.5f)) + mad(fragment_uniform_buffer_2[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f)) + 1.0f), 0.5f)) + fragment_unnamed_391) < 0.0f);
				float fragment_unnamed_421 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_422 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_466 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_466 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_421) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_421)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_466 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_422) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_422)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_493 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_500 = fragment_unnamed_493 * fragment_input_9.x;
				float fragment_unnamed_501 = fragment_unnamed_493 * fragment_input_9.y;
				float fragment_unnamed_502 = fragment_unnamed_493 * fragment_input_9.z;
				float fragment_unnamed_511 = 1.0f / max(dot(float3(abs(fragment_unnamed_500), abs(fragment_unnamed_501), abs(fragment_unnamed_502)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_516 = clamp((-0.0f) - (fragment_unnamed_511 * fragment_unnamed_502), 0.0f, 1.0f);
				float fragment_unnamed_519 = (-0.0f) - fragment_unnamed_516;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_500, fragment_unnamed_511, ((fragment_unnamed_511 * fragment_unnamed_500) >= 0.0f) ? fragment_unnamed_516 : fragment_unnamed_519), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_501, fragment_unnamed_511, ((fragment_unnamed_511 * fragment_unnamed_501) >= 0.0f) ? fragment_unnamed_516 : fragment_unnamed_519), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_539 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_539, min((8u & 31u), (32u - fragment_unnamed_539)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[1] = float4(_Dissolve, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}

			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_input_6;
			static float3 vertex_input_7;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float4 vertex_output_6;
			static float4 vertex_output_7;
			static float3 vertex_output_8;
			static float3 vertex_output_9;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD3; // TEXCOORD_3
				float3 vertex_input_7 : TEXCOORD4; // TEXCOORD_4
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float4 vertex_output_4 : INTERP1; // INTERP_1
				float4 vertex_output_5 : INTERP2; // INTERP_2
				float4 vertex_output_6 : INTERP3; // INTERP_3
				float4 vertex_output_7 : INTERP4; // INTERP_4
				float3 vertex_output_8 : INTERP5; // INTERP_5
				float3 vertex_output_9 : INTERP6; // INTERP_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_87 = asfloat(1065353216u);
				float vertex_unnamed_89 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_107 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_125 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_87));
				float vertex_unnamed_140 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_155 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_170 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_179 = rsqrt(max(dot(float3(vertex_unnamed_140, vertex_unnamed_155, vertex_unnamed_170), float3(vertex_unnamed_140, vertex_unnamed_155, vertex_unnamed_170)), 1.1754943508222875079687365372222e-38f));
				vertex_output_9.x = vertex_unnamed_179 * vertex_unnamed_140;
				vertex_output_9.y = vertex_unnamed_179 * vertex_unnamed_155;
				vertex_output_9.z = vertex_unnamed_179 * vertex_unnamed_170;
				float vertex_unnamed_214 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_215 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_216 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_221 = rsqrt(max(dot(float3(vertex_unnamed_214, vertex_unnamed_215, vertex_unnamed_216), float3(vertex_unnamed_214, vertex_unnamed_215, vertex_unnamed_216)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_221 * vertex_unnamed_214;
				vertex_output_3.y = vertex_unnamed_221 * vertex_unnamed_215;
				vertex_output_3.z = vertex_unnamed_221 * vertex_unnamed_216;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_125, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_125, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_125, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_125, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_89, vertex_unnamed_107 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_329 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_342 = vertex_unnamed_329 ? vertex_input_7.x : vertex_input_0.x;
					float vertex_unnamed_343 = vertex_unnamed_329 ? vertex_input_7.y : vertex_input_0.y;
					float vertex_unnamed_344 = vertex_unnamed_329 ? vertex_input_7.z : vertex_input_0.z;
					float vertex_unnamed_378 = asfloat(1065353216u);
					float vertex_unnamed_379 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_342, vertex_unnamed_343, vertex_unnamed_344, vertex_unnamed_378));
					float vertex_unnamed_397 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_342, vertex_unnamed_343, vertex_unnamed_344, vertex_unnamed_378));
					float vertex_unnamed_415 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_342, vertex_unnamed_343, vertex_unnamed_344, vertex_unnamed_378));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_415, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_379, vertex_unnamed_397 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_415, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_379, vertex_unnamed_397 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_415, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_379, vertex_unnamed_397 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_input_3.x;
				vertex_output_4.y = vertex_input_3.y;
				vertex_output_4.z = vertex_input_3.z;
				vertex_output_4.w = vertex_input_3.w;
				vertex_output_5.x = vertex_input_4.x;
				vertex_output_5.y = vertex_input_4.y;
				vertex_output_5.z = vertex_input_4.z;
				vertex_output_5.w = vertex_input_4.w;
				vertex_output_6.x = vertex_input_5.x;
				vertex_output_6.y = vertex_input_5.y;
				vertex_output_6.z = vertex_input_5.z;
				vertex_output_6.w = vertex_input_5.w;
				vertex_output_7.x = vertex_input_6.x;
				vertex_output_7.y = vertex_input_6.y;
				vertex_output_7.z = vertex_input_6.z;
				vertex_output_7.w = vertex_input_6.w;
				vertex_output_8.x = vertex_unnamed_89;
				vertex_output_8.y = vertex_unnamed_107;
				vertex_output_8.z = vertex_unnamed_125;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[32] = float4(_NonJitteredViewProjMatrix[0][0], _NonJitteredViewProjMatrix[1][0], _NonJitteredViewProjMatrix[2][0], _NonJitteredViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[33] = float4(_NonJitteredViewProjMatrix[0][1], _NonJitteredViewProjMatrix[1][1], _NonJitteredViewProjMatrix[2][1], _NonJitteredViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[34] = float4(_NonJitteredViewProjMatrix[0][2], _NonJitteredViewProjMatrix[1][2], _NonJitteredViewProjMatrix[2][2], _NonJitteredViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[35] = float4(_NonJitteredViewProjMatrix[0][3], _NonJitteredViewProjMatrix[1][3], _NonJitteredViewProjMatrix[2][3], _NonJitteredViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[40] = float4(_PrevViewProjMatrix[0][0], _PrevViewProjMatrix[1][0], _PrevViewProjMatrix[2][0], _PrevViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[41] = float4(_PrevViewProjMatrix[0][1], _PrevViewProjMatrix[1][1], _PrevViewProjMatrix[2][1], _PrevViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[42] = float4(_PrevViewProjMatrix[0][2], _PrevViewProjMatrix[1][2], _PrevViewProjMatrix[2][2], _PrevViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[43] = float4(_PrevViewProjMatrix[0][3], _PrevViewProjMatrix[1][3], _PrevViewProjMatrix[2][3], _PrevViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_1[30] = float4(unity_MatrixPreviousM[0][0], unity_MatrixPreviousM[1][0], unity_MatrixPreviousM[2][0], unity_MatrixPreviousM[3][0]);
				vertex_uniform_buffer_1[31] = float4(unity_MatrixPreviousM[0][1], unity_MatrixPreviousM[1][1], unity_MatrixPreviousM[2][1], unity_MatrixPreviousM[3][1]);
				vertex_uniform_buffer_1[32] = float4(unity_MatrixPreviousM[0][2], unity_MatrixPreviousM[1][2], unity_MatrixPreviousM[2][2], unity_MatrixPreviousM[3][2]);
				vertex_uniform_buffer_1[33] = float4(unity_MatrixPreviousM[0][3], unity_MatrixPreviousM[1][3], unity_MatrixPreviousM[2][3], unity_MatrixPreviousM[3][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
				vertex_input_6 = stage_input.vertex_input_6;
				vertex_input_7 = stage_input.vertex_input_7;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				stage_output.vertex_output_7 = vertex_output_7;
				stage_output.vertex_output_8 = vertex_output_8;
				stage_output.vertex_output_9 = vertex_output_9;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			float4 _ScreenSize;
			float4 unity_MotionVectorsParams;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float4 fragment_input_6;
			static float4 fragment_input_7;
			static float3 fragment_input_8;
			static float3 fragment_input_9;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float4 fragment_input_6 : INTERP3; // INTERP_3
				float4 fragment_input_7 : INTERP4; // INTERP_4
				float3 fragment_input_8 : INTERP5; // INTERP_5
				float3 fragment_input_9 : INTERP6; // INTERP_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_56 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_57 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_107 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_107 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_56) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_56)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_107 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_57) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_57)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				fragment_input_9 = stage_input.fragment_input_9;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif

			// Per-stage fallbacks for variants missing from the ripped data
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			float4 vert(float3 pos : POSITION) : SV_POSITION { return float4(0, 0, 0, 1); }
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			float4 frag() : SV_TARGET { return 0; }
			#endif
			ENDHLSL
		}
		Pass
		{
			Name "DepthOnly"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DepthOnly" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Cull [_CullMode]
			Stencil
			{
				Ref [_StencilRefDepth]
				WriteMask [_StencilWriteMaskDepth]
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
			GpuProgramID 478274

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_instancing
			#pragma multi_compile _ WRITE_DECAL_BUFFER
			#pragma multi_compile _ _ALPHATEST_ON


			#if (!defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[17];
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
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
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
				float4 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
				float3 vertex_output_7 : INTERP6; // INTERP_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				if ((((0.0f < vertex_uniform_buffer_2[16u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
				{
					gl_Position.x = 0.0f;
					gl_Position.y = 0.0f;
					gl_Position.z = 0.0f;
					gl_Position.w = 0.0f;
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 0.0f;
					vertex_output_1.w = 0.0f;
					vertex_output_2.x = 0.0f;
					vertex_output_2.y = 0.0f;
					vertex_output_2.z = 0.0f;
					vertex_output_2.w = 0.0f;
					vertex_output_3.x = 0.0f;
					vertex_output_3.y = 0.0f;
					vertex_output_3.z = 0.0f;
					vertex_output_3.w = 0.0f;
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
					vertex_output_4.w = 0.0f;
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
					vertex_output_5.w = 0.0f;
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
					vertex_output_7.x = 0.0f;
					vertex_output_7.y = 0.0f;
					vertex_output_7.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_138 = asfloat(1065353216u);
					float vertex_unnamed_140 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_158 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_176 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_191 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_206 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_221 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_230 = rsqrt(max(dot(float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221), float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_230 * vertex_unnamed_191;
					vertex_output_7.y = vertex_unnamed_230 * vertex_unnamed_206;
					vertex_output_7.z = vertex_unnamed_230 * vertex_unnamed_221;
					float vertex_unnamed_264 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_265 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_266 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_271 = rsqrt(max(dot(float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266), float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_271 * vertex_unnamed_264;
					vertex_output_1.y = vertex_unnamed_271 * vertex_unnamed_265;
					vertex_output_1.z = vertex_unnamed_271 * vertex_unnamed_266;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_140;
					vertex_output_6.y = vertex_unnamed_158;
					vertex_output_6.z = vertex_unnamed_176;
				}
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[16] = float4(vertex_uniform_buffer_2[16][0], vertex_uniform_buffer_2[16][1], _RayTracing, vertex_uniform_buffer_2[16][3]);

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
				return stage_output;
			}
			#endif
			#if (!defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
			}

			#endif
			#if (defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[17];
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
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
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
				float4 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
				float3 vertex_output_7 : INTERP6; // INTERP_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				if ((((0.0f < vertex_uniform_buffer_2[16u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
				{
					gl_Position.x = 0.0f;
					gl_Position.y = 0.0f;
					gl_Position.z = 0.0f;
					gl_Position.w = 0.0f;
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 0.0f;
					vertex_output_1.w = 0.0f;
					vertex_output_2.x = 0.0f;
					vertex_output_2.y = 0.0f;
					vertex_output_2.z = 0.0f;
					vertex_output_2.w = 0.0f;
					vertex_output_3.x = 0.0f;
					vertex_output_3.y = 0.0f;
					vertex_output_3.z = 0.0f;
					vertex_output_3.w = 0.0f;
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
					vertex_output_4.w = 0.0f;
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
					vertex_output_5.w = 0.0f;
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
					vertex_output_7.x = 0.0f;
					vertex_output_7.y = 0.0f;
					vertex_output_7.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_138 = asfloat(1065353216u);
					float vertex_unnamed_140 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_158 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_176 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_191 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_206 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_221 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_230 = rsqrt(max(dot(float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221), float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_230 * vertex_unnamed_191;
					vertex_output_7.y = vertex_unnamed_230 * vertex_unnamed_206;
					vertex_output_7.z = vertex_unnamed_230 * vertex_unnamed_221;
					float vertex_unnamed_264 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_265 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_266 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_271 = rsqrt(max(dot(float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266), float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_271 * vertex_unnamed_264;
					vertex_output_1.y = vertex_unnamed_271 * vertex_unnamed_265;
					vertex_output_1.z = vertex_unnamed_271 * vertex_unnamed_266;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_140;
					vertex_output_6.y = vertex_unnamed_158;
					vertex_output_6.z = vertex_unnamed_176;
				}
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[16] = float4(vertex_uniform_buffer_2[16][0], vertex_uniform_buffer_2[16][1], _RayTracing, vertex_uniform_buffer_2[16][3]);

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
				return stage_output;
			}
			#endif
			#if (defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float _GlobalMipBias;
			float _Dissolve;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[2];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_395)
			{
				if (fragment_unnamed_395)
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
				float fragment_unnamed_44 = fragment_input_2.x * 15.0f;
				float fragment_unnamed_46 = fragment_input_2.y * 15.0f;
				float fragment_unnamed_48 = floor(fragment_unnamed_44);
				float fragment_unnamed_49 = floor(fragment_unnamed_46);
				float fragment_unnamed_50 = frac(fragment_unnamed_44);
				float fragment_unnamed_51 = frac(fragment_unnamed_46);
				float fragment_unnamed_52 = fragment_unnamed_48 + 1.0f;
				float fragment_unnamed_54 = fragment_unnamed_49 + 1.0f;
				float fragment_unnamed_58 = fragment_unnamed_52 * 289.0f;
				float fragment_unnamed_59 = fragment_unnamed_54 * 289.0f;
				float fragment_unnamed_60 = (-0.0f) - fragment_unnamed_58;
				float fragment_unnamed_62 = (-0.0f) - fragment_unnamed_59;
				float fragment_unnamed_84 = frac(fragment_unnamed_52 * asfloat((fragment_unnamed_58 >= fragment_unnamed_60) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_52 * 289.0f) >= fragment_unnamed_60) ? 1133543424u : 3281027072u);
				float fragment_unnamed_88 = fragment_unnamed_84 * mad(fragment_unnamed_84, 34.0f, 1.0f);
				float fragment_unnamed_89 = fragment_unnamed_88 * 289.0f;
				bool fragment_unnamed_91 = fragment_unnamed_89 >= ((-0.0f) - fragment_unnamed_89);
				float fragment_unnamed_98 = mad(asfloat(fragment_unnamed_91 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_91 ? 996328615u : 3143812263u) * fragment_unnamed_88), frac(fragment_unnamed_54 * asfloat((fragment_unnamed_59 >= fragment_unnamed_62) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_54 * 289.0f) >= fragment_unnamed_62) ? 1133543424u : 3281027072u));
				float fragment_unnamed_100 = fragment_unnamed_98 * mad(fragment_unnamed_98, 34.0f, 1.0f);
				float fragment_unnamed_101 = fragment_unnamed_100 * 289.0f;
				bool fragment_unnamed_103 = fragment_unnamed_101 >= ((-0.0f) - fragment_unnamed_101);
				float fragment_unnamed_113 = frac((frac(asfloat(fragment_unnamed_103 ? 996328615u : 3143812263u) * fragment_unnamed_100) * asfloat(fragment_unnamed_103 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_114 = mad(fragment_unnamed_113, 2.0f, -1.0f);
				float fragment_unnamed_121 = ((-0.0f) - floor(mad(fragment_unnamed_113, 2.0f, -0.5f))) + fragment_unnamed_114;
				float fragment_unnamed_123 = abs(fragment_unnamed_114) + (-0.5f);
				float fragment_unnamed_128 = rsqrt(dot(float2(fragment_unnamed_121, fragment_unnamed_123), float2(fragment_unnamed_121, fragment_unnamed_123)));
				float fragment_unnamed_136 = fragment_unnamed_48 + 0.0f;
				float fragment_unnamed_138 = fragment_unnamed_49 + 1.0f;
				float fragment_unnamed_139 = fragment_unnamed_48 + 1.0f;
				float fragment_unnamed_140 = fragment_unnamed_49 + 0.0f;
				float fragment_unnamed_141 = fragment_unnamed_136 * 289.0f;
				float fragment_unnamed_142 = fragment_unnamed_138 * 289.0f;
				float fragment_unnamed_143 = fragment_unnamed_139 * 289.0f;
				float fragment_unnamed_144 = fragment_unnamed_140 * 289.0f;
				bool fragment_unnamed_149 = fragment_unnamed_141 >= ((-0.0f) - fragment_unnamed_141);
				bool fragment_unnamed_150 = fragment_unnamed_142 >= ((-0.0f) - fragment_unnamed_142);
				bool fragment_unnamed_151 = fragment_unnamed_143 >= ((-0.0f) - fragment_unnamed_143);
				bool fragment_unnamed_152 = fragment_unnamed_144 >= ((-0.0f) - fragment_unnamed_144);
				float fragment_unnamed_175 = frac(fragment_unnamed_136 * asfloat(fragment_unnamed_149 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_149 ? 1133543424u : 3281027072u);
				float fragment_unnamed_179 = frac(fragment_unnamed_139 * asfloat(fragment_unnamed_151 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_151 ? 1133543424u : 3281027072u);
				float fragment_unnamed_182 = fragment_unnamed_179 * mad(fragment_unnamed_179, 34.0f, 1.0f);
				float fragment_unnamed_183 = fragment_unnamed_182 * 289.0f;
				bool fragment_unnamed_185 = fragment_unnamed_183 >= ((-0.0f) - fragment_unnamed_183);
				float fragment_unnamed_192 = mad(asfloat(fragment_unnamed_185 ? 1133543424u : 3281027072u), frac(fragment_unnamed_182 * asfloat(fragment_unnamed_185 ? 996328615u : 3143812263u)), frac(fragment_unnamed_140 * asfloat(fragment_unnamed_152 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_152 ? 1133543424u : 3281027072u));
				float fragment_unnamed_194 = fragment_unnamed_192 * mad(fragment_unnamed_192, 34.0f, 1.0f);
				float fragment_unnamed_195 = fragment_unnamed_194 * 289.0f;
				bool fragment_unnamed_197 = fragment_unnamed_195 >= ((-0.0f) - fragment_unnamed_195);
				float fragment_unnamed_206 = frac((frac(asfloat(fragment_unnamed_197 ? 996328615u : 3143812263u) * fragment_unnamed_194) * asfloat(fragment_unnamed_197 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_207 = mad(fragment_unnamed_206, 2.0f, -1.0f);
				float fragment_unnamed_211 = ((-0.0f) - floor(mad(fragment_unnamed_206, 2.0f, -0.5f))) + fragment_unnamed_207;
				float fragment_unnamed_213 = abs(fragment_unnamed_207) + (-0.5f);
				float fragment_unnamed_217 = rsqrt(dot(float2(fragment_unnamed_211, fragment_unnamed_213), float2(fragment_unnamed_211, fragment_unnamed_213)));
				float fragment_unnamed_224 = dot(float2(fragment_unnamed_217 * fragment_unnamed_211, fragment_unnamed_217 * fragment_unnamed_213), float2(fragment_unnamed_50 + (-1.0f), fragment_unnamed_51 + (-0.0f)));
				float fragment_unnamed_241 = (fragment_unnamed_51 * (fragment_unnamed_51 * fragment_unnamed_51)) * mad(fragment_unnamed_51, mad(fragment_unnamed_51, 6.0f, -15.0f), 10.0f);
				float fragment_unnamed_245 = fragment_unnamed_48 * 289.0f;
				float fragment_unnamed_246 = fragment_unnamed_49 * 289.0f;
				float fragment_unnamed_247 = (-0.0f) - fragment_unnamed_245;
				float fragment_unnamed_248 = (-0.0f) - fragment_unnamed_246;
				float fragment_unnamed_265 = frac(fragment_unnamed_48 * asfloat((fragment_unnamed_245 >= fragment_unnamed_247) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_48 * 289.0f) >= fragment_unnamed_247) ? 1133543424u : 3281027072u);
				float fragment_unnamed_268 = fragment_unnamed_265 * mad(fragment_unnamed_265, 34.0f, 1.0f);
				float fragment_unnamed_269 = fragment_unnamed_268 * 289.0f;
				bool fragment_unnamed_271 = fragment_unnamed_269 >= ((-0.0f) - fragment_unnamed_269);
				float fragment_unnamed_278 = mad(asfloat(fragment_unnamed_271 ? 1133543424u : 3281027072u), frac(fragment_unnamed_268 * asfloat(fragment_unnamed_271 ? 996328615u : 3143812263u)), frac(fragment_unnamed_49 * asfloat((fragment_unnamed_246 >= fragment_unnamed_248) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_49 * 289.0f) >= fragment_unnamed_248) ? 1133543424u : 3281027072u));
				float fragment_unnamed_280 = fragment_unnamed_278 * mad(fragment_unnamed_278, 34.0f, 1.0f);
				float fragment_unnamed_281 = fragment_unnamed_280 * 289.0f;
				bool fragment_unnamed_283 = fragment_unnamed_281 >= ((-0.0f) - fragment_unnamed_281);
				float fragment_unnamed_292 = frac((frac(fragment_unnamed_280 * asfloat(fragment_unnamed_283 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_283 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_293 = mad(fragment_unnamed_292, 2.0f, -1.0f);
				float fragment_unnamed_297 = ((-0.0f) - floor(mad(fragment_unnamed_292, 2.0f, -0.5f))) + fragment_unnamed_293;
				float fragment_unnamed_299 = abs(fragment_unnamed_293) + (-0.5f);
				float fragment_unnamed_303 = rsqrt(dot(float2(fragment_unnamed_297, fragment_unnamed_299), float2(fragment_unnamed_297, fragment_unnamed_299)));
				float fragment_unnamed_306 = dot(float2(fragment_unnamed_303 * fragment_unnamed_297, fragment_unnamed_303 * fragment_unnamed_299), float2(fragment_unnamed_50, fragment_unnamed_51));
				float fragment_unnamed_310 = fragment_unnamed_175 * mad(fragment_unnamed_175, 34.0f, 1.0f);
				float fragment_unnamed_311 = fragment_unnamed_310 * 289.0f;
				bool fragment_unnamed_313 = fragment_unnamed_311 >= ((-0.0f) - fragment_unnamed_311);
				float fragment_unnamed_320 = mad(asfloat(fragment_unnamed_313 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_313 ? 996328615u : 3143812263u) * fragment_unnamed_310), frac(fragment_unnamed_138 * asfloat(fragment_unnamed_150 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_150 ? 1133543424u : 3281027072u));
				float fragment_unnamed_322 = fragment_unnamed_320 * mad(fragment_unnamed_320, 34.0f, 1.0f);
				float fragment_unnamed_323 = fragment_unnamed_322 * 289.0f;
				bool fragment_unnamed_325 = fragment_unnamed_323 >= ((-0.0f) - fragment_unnamed_323);
				float fragment_unnamed_334 = frac((frac(asfloat(fragment_unnamed_325 ? 996328615u : 3143812263u) * fragment_unnamed_322) * asfloat(fragment_unnamed_325 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_335 = mad(fragment_unnamed_334, 2.0f, -1.0f);
				float fragment_unnamed_339 = ((-0.0f) - floor(mad(fragment_unnamed_334, 2.0f, -0.5f))) + fragment_unnamed_335;
				float fragment_unnamed_341 = abs(fragment_unnamed_335) + (-0.5f);
				float fragment_unnamed_345 = rsqrt(dot(float2(fragment_unnamed_339, fragment_unnamed_341), float2(fragment_unnamed_339, fragment_unnamed_341)));
				float fragment_unnamed_353 = mad(fragment_unnamed_241, ((-0.0f) - fragment_unnamed_306) + dot(float2(fragment_unnamed_345 * fragment_unnamed_339, fragment_unnamed_345 * fragment_unnamed_341), float2(fragment_unnamed_50 + (-0.0f), fragment_unnamed_51 + (-1.0f))), fragment_unnamed_306);
				float4 fragment_unnamed_379 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_381 = fragment_unnamed_379.w;
				discard_cond((((-0.0f) - max(((-0.0f) - (((-0.0f) - fragment_unnamed_381) + 1.0f)) + ((((-0.0f) - (mad((fragment_unnamed_50 * (fragment_unnamed_50 * fragment_unnamed_50)) * mad(fragment_unnamed_50, mad(fragment_unnamed_50, 6.0f, -15.0f), 10.0f), ((-0.0f) - fragment_unnamed_353) + mad(fragment_unnamed_241, ((-0.0f) - fragment_unnamed_224) + dot(float2(fragment_unnamed_128 * fragment_unnamed_121, fragment_unnamed_128 * fragment_unnamed_123), float2(fragment_unnamed_50 + (-1.0f), fragment_unnamed_51 + (-1.0f))), fragment_unnamed_224), fragment_unnamed_353) + 0.5f)) + mad(fragment_uniform_buffer_1[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f)) + 1.0f), 0.5f)) + fragment_unnamed_381) < 0.0f);
				discard_exit();
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
			}

			#endif
			#if (defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
			static float4 vertex_uniform_buffer_3[17];
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
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
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
				uint vertex_unnamed_411;
				float vertex_unnamed_412;
				uint vertex_unnamed_413;
				uint vertex_unnamed_414;
				if ((((0.0f < vertex_uniform_buffer_3[16u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
				{
					gl_Position.x = 0.0f;
					gl_Position.y = 0.0f;
					gl_Position.z = 0.0f;
					gl_Position.w = 0.0f;
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 0.0f;
					vertex_output_1.w = 0.0f;
					vertex_output_2.x = 0.0f;
					vertex_output_2.y = 0.0f;
					vertex_output_2.z = 0.0f;
					vertex_output_2.w = 0.0f;
					vertex_output_3.x = 0.0f;
					vertex_output_3.y = 0.0f;
					vertex_output_3.z = 0.0f;
					vertex_output_3.w = 0.0f;
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
					vertex_output_4.w = 0.0f;
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
					vertex_output_5.w = 0.0f;
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
					vertex_unnamed_411 = 0u;
					vertex_unnamed_412 = asfloat(0u);
					vertex_unnamed_413 = 0u;
					vertex_unnamed_414 = 0u;
				}
				else
				{
					uint vertex_unnamed_113 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
					uint vertex_unnamed_125 = vertex_unnamed_113 + 3u;
					float vertex_unnamed_158 = asfloat(1065353216u);
					float vertex_unnamed_160 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_125].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_180 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_125].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_200 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_125].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_216 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 4u].xyz));
					float vertex_unnamed_232 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 5u].xyz));
					float vertex_unnamed_248 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 6u].xyz));
					float vertex_unnamed_257 = rsqrt(max(dot(float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248), float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248)), 1.1754943508222875079687365372222e-38f));
					uint vertex_unnamed_265 = vertex_unnamed_113 + 1u;
					uint vertex_unnamed_284 = vertex_unnamed_113 + 2u;
					float vertex_unnamed_292 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].x));
					float vertex_unnamed_293 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].y));
					float vertex_unnamed_294 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].z));
					float vertex_unnamed_299 = rsqrt(max(dot(float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294), float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_299 * vertex_unnamed_292;
					vertex_output_1.y = vertex_unnamed_299 * vertex_unnamed_293;
					vertex_output_1.z = vertex_unnamed_299 * vertex_unnamed_294;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_160;
					vertex_output_6.y = vertex_unnamed_180;
					vertex_output_6.z = vertex_unnamed_200;
					vertex_unnamed_411 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
					vertex_unnamed_412 = vertex_unnamed_257 * vertex_unnamed_248;
					vertex_unnamed_413 = asuint(vertex_unnamed_257 * vertex_unnamed_232);
					vertex_unnamed_414 = asuint(vertex_unnamed_257 * vertex_unnamed_216);
				}
				vertex_output_7.x = asfloat(vertex_unnamed_414);
				vertex_output_7.y = asfloat(vertex_unnamed_413);
				vertex_output_7.z = vertex_unnamed_412;
				vertex_output_8 = vertex_unnamed_411;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_3[16] = float4(vertex_uniform_buffer_3[16][0], vertex_uniform_buffer_3[16][1], _RayTracing, vertex_uniform_buffer_3[16][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
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
			#endif
			#if (defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;

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

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
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
			}

			#endif
			#if (defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
			static float4 vertex_uniform_buffer_3[17];
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
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
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
				uint vertex_unnamed_411;
				float vertex_unnamed_412;
				uint vertex_unnamed_413;
				uint vertex_unnamed_414;
				if ((((0.0f < vertex_uniform_buffer_3[16u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
				{
					gl_Position.x = 0.0f;
					gl_Position.y = 0.0f;
					gl_Position.z = 0.0f;
					gl_Position.w = 0.0f;
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 0.0f;
					vertex_output_1.w = 0.0f;
					vertex_output_2.x = 0.0f;
					vertex_output_2.y = 0.0f;
					vertex_output_2.z = 0.0f;
					vertex_output_2.w = 0.0f;
					vertex_output_3.x = 0.0f;
					vertex_output_3.y = 0.0f;
					vertex_output_3.z = 0.0f;
					vertex_output_3.w = 0.0f;
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
					vertex_output_4.w = 0.0f;
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
					vertex_output_5.w = 0.0f;
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
					vertex_unnamed_411 = 0u;
					vertex_unnamed_412 = asfloat(0u);
					vertex_unnamed_413 = 0u;
					vertex_unnamed_414 = 0u;
				}
				else
				{
					uint vertex_unnamed_113 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
					uint vertex_unnamed_125 = vertex_unnamed_113 + 3u;
					float vertex_unnamed_158 = asfloat(1065353216u);
					float vertex_unnamed_160 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_125].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_180 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_125].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_200 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_125].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_216 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 4u].xyz));
					float vertex_unnamed_232 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 5u].xyz));
					float vertex_unnamed_248 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 6u].xyz));
					float vertex_unnamed_257 = rsqrt(max(dot(float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248), float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248)), 1.1754943508222875079687365372222e-38f));
					uint vertex_unnamed_265 = vertex_unnamed_113 + 1u;
					uint vertex_unnamed_284 = vertex_unnamed_113 + 2u;
					float vertex_unnamed_292 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].x));
					float vertex_unnamed_293 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].y));
					float vertex_unnamed_294 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].z));
					float vertex_unnamed_299 = rsqrt(max(dot(float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294), float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_299 * vertex_unnamed_292;
					vertex_output_1.y = vertex_unnamed_299 * vertex_unnamed_293;
					vertex_output_1.z = vertex_unnamed_299 * vertex_unnamed_294;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_160;
					vertex_output_6.y = vertex_unnamed_180;
					vertex_output_6.z = vertex_unnamed_200;
					vertex_unnamed_411 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
					vertex_unnamed_412 = vertex_unnamed_257 * vertex_unnamed_248;
					vertex_unnamed_413 = asuint(vertex_unnamed_257 * vertex_unnamed_232);
					vertex_unnamed_414 = asuint(vertex_unnamed_257 * vertex_unnamed_216);
				}
				vertex_output_7.x = asfloat(vertex_unnamed_414);
				vertex_output_7.y = asfloat(vertex_unnamed_413);
				vertex_output_7.z = vertex_unnamed_412;
				vertex_output_8 = vertex_unnamed_411;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_3[16] = float4(vertex_uniform_buffer_3[16][0], vertex_uniform_buffer_3[16][1], _RayTracing, vertex_uniform_buffer_3[16][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
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
			#endif
			#if (defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float _GlobalMipBias;
			float _Dissolve;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[2];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;

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

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_397)
			{
				if (fragment_unnamed_397)
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
				float fragment_unnamed_46 = fragment_input_2.x * 15.0f;
				float fragment_unnamed_48 = fragment_input_2.y * 15.0f;
				float fragment_unnamed_50 = floor(fragment_unnamed_46);
				float fragment_unnamed_51 = floor(fragment_unnamed_48);
				float fragment_unnamed_52 = frac(fragment_unnamed_46);
				float fragment_unnamed_53 = frac(fragment_unnamed_48);
				float fragment_unnamed_54 = fragment_unnamed_50 + 1.0f;
				float fragment_unnamed_56 = fragment_unnamed_51 + 1.0f;
				float fragment_unnamed_60 = fragment_unnamed_54 * 289.0f;
				float fragment_unnamed_61 = fragment_unnamed_56 * 289.0f;
				float fragment_unnamed_62 = (-0.0f) - fragment_unnamed_60;
				float fragment_unnamed_64 = (-0.0f) - fragment_unnamed_61;
				float fragment_unnamed_86 = frac(fragment_unnamed_54 * asfloat((fragment_unnamed_60 >= fragment_unnamed_62) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_54 * 289.0f) >= fragment_unnamed_62) ? 1133543424u : 3281027072u);
				float fragment_unnamed_90 = fragment_unnamed_86 * mad(fragment_unnamed_86, 34.0f, 1.0f);
				float fragment_unnamed_91 = fragment_unnamed_90 * 289.0f;
				bool fragment_unnamed_93 = fragment_unnamed_91 >= ((-0.0f) - fragment_unnamed_91);
				float fragment_unnamed_100 = mad(asfloat(fragment_unnamed_93 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_93 ? 996328615u : 3143812263u) * fragment_unnamed_90), frac(fragment_unnamed_56 * asfloat((fragment_unnamed_61 >= fragment_unnamed_64) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_56 * 289.0f) >= fragment_unnamed_64) ? 1133543424u : 3281027072u));
				float fragment_unnamed_102 = fragment_unnamed_100 * mad(fragment_unnamed_100, 34.0f, 1.0f);
				float fragment_unnamed_103 = fragment_unnamed_102 * 289.0f;
				bool fragment_unnamed_105 = fragment_unnamed_103 >= ((-0.0f) - fragment_unnamed_103);
				float fragment_unnamed_115 = frac((frac(asfloat(fragment_unnamed_105 ? 996328615u : 3143812263u) * fragment_unnamed_102) * asfloat(fragment_unnamed_105 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_116 = mad(fragment_unnamed_115, 2.0f, -1.0f);
				float fragment_unnamed_123 = ((-0.0f) - floor(mad(fragment_unnamed_115, 2.0f, -0.5f))) + fragment_unnamed_116;
				float fragment_unnamed_125 = abs(fragment_unnamed_116) + (-0.5f);
				float fragment_unnamed_130 = rsqrt(dot(float2(fragment_unnamed_123, fragment_unnamed_125), float2(fragment_unnamed_123, fragment_unnamed_125)));
				float fragment_unnamed_138 = fragment_unnamed_50 + 0.0f;
				float fragment_unnamed_140 = fragment_unnamed_51 + 1.0f;
				float fragment_unnamed_141 = fragment_unnamed_50 + 1.0f;
				float fragment_unnamed_142 = fragment_unnamed_51 + 0.0f;
				float fragment_unnamed_143 = fragment_unnamed_138 * 289.0f;
				float fragment_unnamed_144 = fragment_unnamed_140 * 289.0f;
				float fragment_unnamed_145 = fragment_unnamed_141 * 289.0f;
				float fragment_unnamed_146 = fragment_unnamed_142 * 289.0f;
				bool fragment_unnamed_151 = fragment_unnamed_143 >= ((-0.0f) - fragment_unnamed_143);
				bool fragment_unnamed_152 = fragment_unnamed_144 >= ((-0.0f) - fragment_unnamed_144);
				bool fragment_unnamed_153 = fragment_unnamed_145 >= ((-0.0f) - fragment_unnamed_145);
				bool fragment_unnamed_154 = fragment_unnamed_146 >= ((-0.0f) - fragment_unnamed_146);
				float fragment_unnamed_177 = frac(fragment_unnamed_138 * asfloat(fragment_unnamed_151 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_151 ? 1133543424u : 3281027072u);
				float fragment_unnamed_181 = frac(fragment_unnamed_141 * asfloat(fragment_unnamed_153 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_153 ? 1133543424u : 3281027072u);
				float fragment_unnamed_184 = fragment_unnamed_181 * mad(fragment_unnamed_181, 34.0f, 1.0f);
				float fragment_unnamed_185 = fragment_unnamed_184 * 289.0f;
				bool fragment_unnamed_187 = fragment_unnamed_185 >= ((-0.0f) - fragment_unnamed_185);
				float fragment_unnamed_194 = mad(asfloat(fragment_unnamed_187 ? 1133543424u : 3281027072u), frac(fragment_unnamed_184 * asfloat(fragment_unnamed_187 ? 996328615u : 3143812263u)), frac(fragment_unnamed_142 * asfloat(fragment_unnamed_154 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_154 ? 1133543424u : 3281027072u));
				float fragment_unnamed_196 = fragment_unnamed_194 * mad(fragment_unnamed_194, 34.0f, 1.0f);
				float fragment_unnamed_197 = fragment_unnamed_196 * 289.0f;
				bool fragment_unnamed_199 = fragment_unnamed_197 >= ((-0.0f) - fragment_unnamed_197);
				float fragment_unnamed_208 = frac((frac(asfloat(fragment_unnamed_199 ? 996328615u : 3143812263u) * fragment_unnamed_196) * asfloat(fragment_unnamed_199 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_209 = mad(fragment_unnamed_208, 2.0f, -1.0f);
				float fragment_unnamed_213 = ((-0.0f) - floor(mad(fragment_unnamed_208, 2.0f, -0.5f))) + fragment_unnamed_209;
				float fragment_unnamed_215 = abs(fragment_unnamed_209) + (-0.5f);
				float fragment_unnamed_219 = rsqrt(dot(float2(fragment_unnamed_213, fragment_unnamed_215), float2(fragment_unnamed_213, fragment_unnamed_215)));
				float fragment_unnamed_226 = dot(float2(fragment_unnamed_219 * fragment_unnamed_213, fragment_unnamed_219 * fragment_unnamed_215), float2(fragment_unnamed_52 + (-1.0f), fragment_unnamed_53 + (-0.0f)));
				float fragment_unnamed_243 = (fragment_unnamed_53 * (fragment_unnamed_53 * fragment_unnamed_53)) * mad(fragment_unnamed_53, mad(fragment_unnamed_53, 6.0f, -15.0f), 10.0f);
				float fragment_unnamed_247 = fragment_unnamed_50 * 289.0f;
				float fragment_unnamed_248 = fragment_unnamed_51 * 289.0f;
				float fragment_unnamed_249 = (-0.0f) - fragment_unnamed_247;
				float fragment_unnamed_250 = (-0.0f) - fragment_unnamed_248;
				float fragment_unnamed_267 = frac(fragment_unnamed_50 * asfloat((fragment_unnamed_247 >= fragment_unnamed_249) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_50 * 289.0f) >= fragment_unnamed_249) ? 1133543424u : 3281027072u);
				float fragment_unnamed_270 = fragment_unnamed_267 * mad(fragment_unnamed_267, 34.0f, 1.0f);
				float fragment_unnamed_271 = fragment_unnamed_270 * 289.0f;
				bool fragment_unnamed_273 = fragment_unnamed_271 >= ((-0.0f) - fragment_unnamed_271);
				float fragment_unnamed_280 = mad(asfloat(fragment_unnamed_273 ? 1133543424u : 3281027072u), frac(fragment_unnamed_270 * asfloat(fragment_unnamed_273 ? 996328615u : 3143812263u)), frac(fragment_unnamed_51 * asfloat((fragment_unnamed_248 >= fragment_unnamed_250) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_51 * 289.0f) >= fragment_unnamed_250) ? 1133543424u : 3281027072u));
				float fragment_unnamed_282 = fragment_unnamed_280 * mad(fragment_unnamed_280, 34.0f, 1.0f);
				float fragment_unnamed_283 = fragment_unnamed_282 * 289.0f;
				bool fragment_unnamed_285 = fragment_unnamed_283 >= ((-0.0f) - fragment_unnamed_283);
				float fragment_unnamed_294 = frac((frac(fragment_unnamed_282 * asfloat(fragment_unnamed_285 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_285 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_295 = mad(fragment_unnamed_294, 2.0f, -1.0f);
				float fragment_unnamed_299 = ((-0.0f) - floor(mad(fragment_unnamed_294, 2.0f, -0.5f))) + fragment_unnamed_295;
				float fragment_unnamed_301 = abs(fragment_unnamed_295) + (-0.5f);
				float fragment_unnamed_305 = rsqrt(dot(float2(fragment_unnamed_299, fragment_unnamed_301), float2(fragment_unnamed_299, fragment_unnamed_301)));
				float fragment_unnamed_308 = dot(float2(fragment_unnamed_305 * fragment_unnamed_299, fragment_unnamed_305 * fragment_unnamed_301), float2(fragment_unnamed_52, fragment_unnamed_53));
				float fragment_unnamed_312 = fragment_unnamed_177 * mad(fragment_unnamed_177, 34.0f, 1.0f);
				float fragment_unnamed_313 = fragment_unnamed_312 * 289.0f;
				bool fragment_unnamed_315 = fragment_unnamed_313 >= ((-0.0f) - fragment_unnamed_313);
				float fragment_unnamed_322 = mad(asfloat(fragment_unnamed_315 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_315 ? 996328615u : 3143812263u) * fragment_unnamed_312), frac(fragment_unnamed_140 * asfloat(fragment_unnamed_152 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_152 ? 1133543424u : 3281027072u));
				float fragment_unnamed_324 = fragment_unnamed_322 * mad(fragment_unnamed_322, 34.0f, 1.0f);
				float fragment_unnamed_325 = fragment_unnamed_324 * 289.0f;
				bool fragment_unnamed_327 = fragment_unnamed_325 >= ((-0.0f) - fragment_unnamed_325);
				float fragment_unnamed_336 = frac((frac(asfloat(fragment_unnamed_327 ? 996328615u : 3143812263u) * fragment_unnamed_324) * asfloat(fragment_unnamed_327 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_337 = mad(fragment_unnamed_336, 2.0f, -1.0f);
				float fragment_unnamed_341 = ((-0.0f) - floor(mad(fragment_unnamed_336, 2.0f, -0.5f))) + fragment_unnamed_337;
				float fragment_unnamed_343 = abs(fragment_unnamed_337) + (-0.5f);
				float fragment_unnamed_347 = rsqrt(dot(float2(fragment_unnamed_341, fragment_unnamed_343), float2(fragment_unnamed_341, fragment_unnamed_343)));
				float fragment_unnamed_355 = mad(fragment_unnamed_243, ((-0.0f) - fragment_unnamed_308) + dot(float2(fragment_unnamed_347 * fragment_unnamed_341, fragment_unnamed_347 * fragment_unnamed_343), float2(fragment_unnamed_52 + (-0.0f), fragment_unnamed_53 + (-1.0f))), fragment_unnamed_308);
				float4 fragment_unnamed_381 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_383 = fragment_unnamed_381.w;
				discard_cond((((-0.0f) - max(((-0.0f) - (((-0.0f) - fragment_unnamed_383) + 1.0f)) + ((((-0.0f) - (mad((fragment_unnamed_52 * (fragment_unnamed_52 * fragment_unnamed_52)) * mad(fragment_unnamed_52, mad(fragment_unnamed_52, 6.0f, -15.0f), 10.0f), ((-0.0f) - fragment_unnamed_355) + mad(fragment_unnamed_243, ((-0.0f) - fragment_unnamed_226) + dot(float2(fragment_unnamed_130 * fragment_unnamed_123, fragment_unnamed_130 * fragment_unnamed_125), float2(fragment_unnamed_52 + (-1.0f), fragment_unnamed_53 + (-1.0f))), fragment_unnamed_226), fragment_unnamed_355) + 0.5f)) + mad(fragment_uniform_buffer_1[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f)) + 1.0f), 0.5f)) + fragment_unnamed_383) < 0.0f);
				discard_exit();
			}

			void frag(Fragment_Stage_Input stage_input)
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
			}

			#endif
			#if (defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float _GlobalMipBias;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _Dissolve;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[1];
			static float4 fragment_uniform_buffer_2[18];
			static float4 fragment_uniform_buffer_3[2];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
				nointerpolation uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

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

			void discard_cond(bool fragment_unnamed_501)
			{
				if (fragment_unnamed_501)
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
				float fragment_unnamed_57 = fragment_input_2.x * 15.0f;
				float fragment_unnamed_59 = fragment_input_2.y * 15.0f;
				float fragment_unnamed_61 = floor(fragment_unnamed_57);
				float fragment_unnamed_62 = floor(fragment_unnamed_59);
				float fragment_unnamed_63 = frac(fragment_unnamed_57);
				float fragment_unnamed_64 = frac(fragment_unnamed_59);
				float fragment_unnamed_65 = fragment_unnamed_61 + 1.0f;
				float fragment_unnamed_67 = fragment_unnamed_62 + 1.0f;
				float fragment_unnamed_71 = fragment_unnamed_65 * 289.0f;
				float fragment_unnamed_72 = fragment_unnamed_67 * 289.0f;
				float fragment_unnamed_73 = (-0.0f) - fragment_unnamed_71;
				float fragment_unnamed_75 = (-0.0f) - fragment_unnamed_72;
				float fragment_unnamed_97 = frac(fragment_unnamed_65 * asfloat((fragment_unnamed_71 >= fragment_unnamed_73) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_65 * 289.0f) >= fragment_unnamed_73) ? 1133543424u : 3281027072u);
				float fragment_unnamed_101 = fragment_unnamed_97 * mad(fragment_unnamed_97, 34.0f, 1.0f);
				float fragment_unnamed_102 = fragment_unnamed_101 * 289.0f;
				bool fragment_unnamed_104 = fragment_unnamed_102 >= ((-0.0f) - fragment_unnamed_102);
				float fragment_unnamed_111 = mad(asfloat(fragment_unnamed_104 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_104 ? 996328615u : 3143812263u) * fragment_unnamed_101), frac(fragment_unnamed_67 * asfloat((fragment_unnamed_72 >= fragment_unnamed_75) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_67 * 289.0f) >= fragment_unnamed_75) ? 1133543424u : 3281027072u));
				float fragment_unnamed_113 = fragment_unnamed_111 * mad(fragment_unnamed_111, 34.0f, 1.0f);
				float fragment_unnamed_114 = fragment_unnamed_113 * 289.0f;
				bool fragment_unnamed_116 = fragment_unnamed_114 >= ((-0.0f) - fragment_unnamed_114);
				float fragment_unnamed_126 = frac((frac(asfloat(fragment_unnamed_116 ? 996328615u : 3143812263u) * fragment_unnamed_113) * asfloat(fragment_unnamed_116 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_127 = mad(fragment_unnamed_126, 2.0f, -1.0f);
				float fragment_unnamed_134 = ((-0.0f) - floor(mad(fragment_unnamed_126, 2.0f, -0.5f))) + fragment_unnamed_127;
				float fragment_unnamed_136 = abs(fragment_unnamed_127) + (-0.5f);
				float fragment_unnamed_141 = rsqrt(dot(float2(fragment_unnamed_134, fragment_unnamed_136), float2(fragment_unnamed_134, fragment_unnamed_136)));
				float fragment_unnamed_149 = fragment_unnamed_61 + 0.0f;
				float fragment_unnamed_151 = fragment_unnamed_62 + 1.0f;
				float fragment_unnamed_152 = fragment_unnamed_61 + 1.0f;
				float fragment_unnamed_153 = fragment_unnamed_62 + 0.0f;
				float fragment_unnamed_154 = fragment_unnamed_149 * 289.0f;
				float fragment_unnamed_155 = fragment_unnamed_151 * 289.0f;
				float fragment_unnamed_156 = fragment_unnamed_152 * 289.0f;
				float fragment_unnamed_157 = fragment_unnamed_153 * 289.0f;
				bool fragment_unnamed_162 = fragment_unnamed_154 >= ((-0.0f) - fragment_unnamed_154);
				bool fragment_unnamed_163 = fragment_unnamed_155 >= ((-0.0f) - fragment_unnamed_155);
				bool fragment_unnamed_164 = fragment_unnamed_156 >= ((-0.0f) - fragment_unnamed_156);
				bool fragment_unnamed_165 = fragment_unnamed_157 >= ((-0.0f) - fragment_unnamed_157);
				float fragment_unnamed_188 = frac(fragment_unnamed_149 * asfloat(fragment_unnamed_162 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_162 ? 1133543424u : 3281027072u);
				float fragment_unnamed_192 = frac(fragment_unnamed_152 * asfloat(fragment_unnamed_164 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_164 ? 1133543424u : 3281027072u);
				float fragment_unnamed_195 = fragment_unnamed_192 * mad(fragment_unnamed_192, 34.0f, 1.0f);
				float fragment_unnamed_196 = fragment_unnamed_195 * 289.0f;
				bool fragment_unnamed_198 = fragment_unnamed_196 >= ((-0.0f) - fragment_unnamed_196);
				float fragment_unnamed_205 = mad(asfloat(fragment_unnamed_198 ? 1133543424u : 3281027072u), frac(fragment_unnamed_195 * asfloat(fragment_unnamed_198 ? 996328615u : 3143812263u)), frac(fragment_unnamed_153 * asfloat(fragment_unnamed_165 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_165 ? 1133543424u : 3281027072u));
				float fragment_unnamed_207 = fragment_unnamed_205 * mad(fragment_unnamed_205, 34.0f, 1.0f);
				float fragment_unnamed_208 = fragment_unnamed_207 * 289.0f;
				bool fragment_unnamed_210 = fragment_unnamed_208 >= ((-0.0f) - fragment_unnamed_208);
				float fragment_unnamed_219 = frac((frac(asfloat(fragment_unnamed_210 ? 996328615u : 3143812263u) * fragment_unnamed_207) * asfloat(fragment_unnamed_210 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_220 = mad(fragment_unnamed_219, 2.0f, -1.0f);
				float fragment_unnamed_224 = ((-0.0f) - floor(mad(fragment_unnamed_219, 2.0f, -0.5f))) + fragment_unnamed_220;
				float fragment_unnamed_226 = abs(fragment_unnamed_220) + (-0.5f);
				float fragment_unnamed_230 = rsqrt(dot(float2(fragment_unnamed_224, fragment_unnamed_226), float2(fragment_unnamed_224, fragment_unnamed_226)));
				float fragment_unnamed_237 = dot(float2(fragment_unnamed_230 * fragment_unnamed_224, fragment_unnamed_230 * fragment_unnamed_226), float2(fragment_unnamed_63 + (-1.0f), fragment_unnamed_64 + (-0.0f)));
				float fragment_unnamed_254 = (fragment_unnamed_64 * (fragment_unnamed_64 * fragment_unnamed_64)) * mad(fragment_unnamed_64, mad(fragment_unnamed_64, 6.0f, -15.0f), 10.0f);
				float fragment_unnamed_258 = fragment_unnamed_61 * 289.0f;
				float fragment_unnamed_259 = fragment_unnamed_62 * 289.0f;
				float fragment_unnamed_260 = (-0.0f) - fragment_unnamed_258;
				float fragment_unnamed_261 = (-0.0f) - fragment_unnamed_259;
				float fragment_unnamed_278 = frac(fragment_unnamed_61 * asfloat((fragment_unnamed_258 >= fragment_unnamed_260) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_61 * 289.0f) >= fragment_unnamed_260) ? 1133543424u : 3281027072u);
				float fragment_unnamed_281 = fragment_unnamed_278 * mad(fragment_unnamed_278, 34.0f, 1.0f);
				float fragment_unnamed_282 = fragment_unnamed_281 * 289.0f;
				bool fragment_unnamed_284 = fragment_unnamed_282 >= ((-0.0f) - fragment_unnamed_282);
				float fragment_unnamed_291 = mad(asfloat(fragment_unnamed_284 ? 1133543424u : 3281027072u), frac(fragment_unnamed_281 * asfloat(fragment_unnamed_284 ? 996328615u : 3143812263u)), frac(fragment_unnamed_62 * asfloat((fragment_unnamed_259 >= fragment_unnamed_261) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_62 * 289.0f) >= fragment_unnamed_261) ? 1133543424u : 3281027072u));
				float fragment_unnamed_293 = fragment_unnamed_291 * mad(fragment_unnamed_291, 34.0f, 1.0f);
				float fragment_unnamed_294 = fragment_unnamed_293 * 289.0f;
				bool fragment_unnamed_296 = fragment_unnamed_294 >= ((-0.0f) - fragment_unnamed_294);
				float fragment_unnamed_305 = frac((frac(fragment_unnamed_293 * asfloat(fragment_unnamed_296 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_296 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_306 = mad(fragment_unnamed_305, 2.0f, -1.0f);
				float fragment_unnamed_310 = ((-0.0f) - floor(mad(fragment_unnamed_305, 2.0f, -0.5f))) + fragment_unnamed_306;
				float fragment_unnamed_312 = abs(fragment_unnamed_306) + (-0.5f);
				float fragment_unnamed_316 = rsqrt(dot(float2(fragment_unnamed_310, fragment_unnamed_312), float2(fragment_unnamed_310, fragment_unnamed_312)));
				float fragment_unnamed_319 = dot(float2(fragment_unnamed_316 * fragment_unnamed_310, fragment_unnamed_316 * fragment_unnamed_312), float2(fragment_unnamed_63, fragment_unnamed_64));
				float fragment_unnamed_323 = fragment_unnamed_188 * mad(fragment_unnamed_188, 34.0f, 1.0f);
				float fragment_unnamed_324 = fragment_unnamed_323 * 289.0f;
				bool fragment_unnamed_326 = fragment_unnamed_324 >= ((-0.0f) - fragment_unnamed_324);
				float fragment_unnamed_333 = mad(asfloat(fragment_unnamed_326 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_326 ? 996328615u : 3143812263u) * fragment_unnamed_323), frac(fragment_unnamed_151 * asfloat(fragment_unnamed_163 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_163 ? 1133543424u : 3281027072u));
				float fragment_unnamed_335 = fragment_unnamed_333 * mad(fragment_unnamed_333, 34.0f, 1.0f);
				float fragment_unnamed_336 = fragment_unnamed_335 * 289.0f;
				bool fragment_unnamed_338 = fragment_unnamed_336 >= ((-0.0f) - fragment_unnamed_336);
				float fragment_unnamed_347 = frac((frac(asfloat(fragment_unnamed_338 ? 996328615u : 3143812263u) * fragment_unnamed_335) * asfloat(fragment_unnamed_338 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_348 = mad(fragment_unnamed_347, 2.0f, -1.0f);
				float fragment_unnamed_352 = ((-0.0f) - floor(mad(fragment_unnamed_347, 2.0f, -0.5f))) + fragment_unnamed_348;
				float fragment_unnamed_354 = abs(fragment_unnamed_348) + (-0.5f);
				float fragment_unnamed_358 = rsqrt(dot(float2(fragment_unnamed_352, fragment_unnamed_354), float2(fragment_unnamed_352, fragment_unnamed_354)));
				float fragment_unnamed_366 = mad(fragment_unnamed_254, ((-0.0f) - fragment_unnamed_319) + dot(float2(fragment_unnamed_358 * fragment_unnamed_352, fragment_unnamed_358 * fragment_unnamed_354), float2(fragment_unnamed_63 + (-0.0f), fragment_unnamed_64 + (-1.0f))), fragment_unnamed_319);
				float4 fragment_unnamed_392 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_394 = fragment_unnamed_392.w;
				discard_cond((((-0.0f) - max(((-0.0f) - (((-0.0f) - fragment_unnamed_394) + 1.0f)) + ((((-0.0f) - (mad((fragment_unnamed_63 * (fragment_unnamed_63 * fragment_unnamed_63)) * mad(fragment_unnamed_63, mad(fragment_unnamed_63, 6.0f, -15.0f), 10.0f), ((-0.0f) - fragment_unnamed_366) + mad(fragment_unnamed_254, ((-0.0f) - fragment_unnamed_237) + dot(float2(fragment_unnamed_141 * fragment_unnamed_134, fragment_unnamed_141 * fragment_unnamed_136), float2(fragment_unnamed_63 + (-1.0f), fragment_unnamed_64 + (-1.0f))), fragment_unnamed_237), fragment_unnamed_366) + 0.5f)) + mad(fragment_uniform_buffer_3[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f)) + 1.0f), 0.5f)) + fragment_unnamed_394) < 0.0f);
				float fragment_unnamed_424 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_431 = fragment_unnamed_424 * fragment_input_7.x;
				float fragment_unnamed_432 = fragment_unnamed_424 * fragment_input_7.y;
				float fragment_unnamed_433 = fragment_unnamed_424 * fragment_input_7.z;
				float fragment_unnamed_442 = 1.0f / max(dot(float3(abs(fragment_unnamed_431), abs(fragment_unnamed_432), abs(fragment_unnamed_433)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_447 = clamp((-0.0f) - (fragment_unnamed_442 * fragment_unnamed_433), 0.0f, 1.0f);
				float fragment_unnamed_450 = (-0.0f) - fragment_unnamed_447;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_431, fragment_unnamed_442, ((fragment_unnamed_442 * fragment_unnamed_431) >= 0.0f) ? fragment_unnamed_447 : fragment_unnamed_450), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_432, fragment_unnamed_442, ((fragment_unnamed_442 * fragment_unnamed_432) >= 0.0f) ? fragment_unnamed_447 : fragment_unnamed_450), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_470 = (fragment_input_8 + asuint(fragment_uniform_buffer_1[0u]).x) * 9u;
				uint fragment_unnamed_480 = 8u & 31u;
				fragment_output_0.y = float(255u & asuint(fragment_uniform_buffer_2[fragment_unnamed_470 + 8u]).x) * 0.0039215688593685626983642578125f;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_2[fragment_unnamed_470 + 8u]).x, fragment_unnamed_480, min((8u & 31u), (32u - fragment_unnamed_480)))) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_1[0][1], fragment_uniform_buffer_1[0][2], fragment_uniform_buffer_1[0][3]);

				fragment_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);
				fragment_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_2[17][1], fragment_uniform_buffer_2[17][2], fragment_uniform_buffer_2[17][3]);
				fragment_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_uniform_buffer_3[1] = float4(_Dissolve, fragment_uniform_buffer_3[1][1], fragment_uniform_buffer_3[1][2], fragment_uniform_buffer_3[1][3]);

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
				return stage_output;
			}

			#endif
			#if (defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[18];
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
				nointerpolation uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
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

			void frag_main()
			{
				float fragment_unnamed_55 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_63 = fragment_unnamed_55 * fragment_input_7.x;
				float fragment_unnamed_64 = fragment_unnamed_55 * fragment_input_7.y;
				float fragment_unnamed_65 = fragment_unnamed_55 * fragment_input_7.z;
				float fragment_unnamed_74 = 1.0f / max(dot(float3(abs(fragment_unnamed_63), abs(fragment_unnamed_64), abs(fragment_unnamed_65)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_81 = clamp((-0.0f) - (fragment_unnamed_74 * fragment_unnamed_65), 0.0f, 1.0f);
				float fragment_unnamed_85 = (-0.0f) - fragment_unnamed_81;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_63, fragment_unnamed_74, ((fragment_unnamed_74 * fragment_unnamed_63) >= 0.0f) ? fragment_unnamed_81 : fragment_unnamed_85), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_64, fragment_unnamed_74, ((fragment_unnamed_74 * fragment_unnamed_64) >= 0.0f) ? fragment_unnamed_81 : fragment_unnamed_85), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_107 = (fragment_input_8 + asuint(fragment_uniform_buffer_0[0u]).x) * 9u;
				uint fragment_unnamed_117 = 8u & 31u;
				fragment_output_0.y = float(255u & asuint(fragment_uniform_buffer_1[fragment_unnamed_107 + 8u]).x) * 0.0039215688593685626983642578125f;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[fragment_unnamed_107 + 8u]).x, fragment_unnamed_117, min((8u & 31u), (32u - fragment_unnamed_117)))) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_1[8][1], fragment_uniform_buffer_1[8][2], fragment_uniform_buffer_1[8][3]);
				fragment_uniform_buffer_1[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_1[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_1[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_1[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_1[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_1[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_1[17][1], fragment_uniform_buffer_1[17][2], fragment_uniform_buffer_1[17][3]);
				fragment_uniform_buffer_1[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_1[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_1[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_1[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_1[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_1[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_1[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_1[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

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
				return stage_output;
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 unity_RenderingLayer;

			static float4 fragment_uniform_buffer_0[11];
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
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

			void frag_main()
			{
				float fragment_unnamed_49 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_57 = fragment_unnamed_49 * fragment_input_7.x;
				float fragment_unnamed_58 = fragment_unnamed_49 * fragment_input_7.y;
				float fragment_unnamed_59 = fragment_unnamed_49 * fragment_input_7.z;
				float fragment_unnamed_68 = 1.0f / max(dot(float3(abs(fragment_unnamed_57), abs(fragment_unnamed_58), abs(fragment_unnamed_59)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_75 = clamp((-0.0f) - (fragment_unnamed_68 * fragment_unnamed_59), 0.0f, 1.0f);
				float fragment_unnamed_79 = (-0.0f) - fragment_unnamed_75;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_57, fragment_unnamed_68, ((fragment_unnamed_68 * fragment_unnamed_57) >= 0.0f) ? fragment_unnamed_75 : fragment_unnamed_79), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_58, fragment_unnamed_68, ((fragment_unnamed_68 * fragment_unnamed_58) >= 0.0f) ? fragment_unnamed_75 : fragment_unnamed_79), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_103 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_0[10u]).x, fragment_unnamed_103, min((8u & 31u), (32u - fragment_unnamed_103)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_0[10u]).x & 255u) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Dissolve;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			static float4 fragment_uniform_buffer_2[2];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

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

			void discard_cond(bool fragment_unnamed_486)
			{
				if (fragment_unnamed_486)
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
				float fragment_unnamed_51 = fragment_input_2.x * 15.0f;
				float fragment_unnamed_53 = fragment_input_2.y * 15.0f;
				float fragment_unnamed_55 = floor(fragment_unnamed_51);
				float fragment_unnamed_56 = floor(fragment_unnamed_53);
				float fragment_unnamed_57 = frac(fragment_unnamed_51);
				float fragment_unnamed_58 = frac(fragment_unnamed_53);
				float fragment_unnamed_59 = fragment_unnamed_55 + 1.0f;
				float fragment_unnamed_61 = fragment_unnamed_56 + 1.0f;
				float fragment_unnamed_65 = fragment_unnamed_59 * 289.0f;
				float fragment_unnamed_66 = fragment_unnamed_61 * 289.0f;
				float fragment_unnamed_67 = (-0.0f) - fragment_unnamed_65;
				float fragment_unnamed_69 = (-0.0f) - fragment_unnamed_66;
				float fragment_unnamed_91 = frac(fragment_unnamed_59 * asfloat((fragment_unnamed_65 >= fragment_unnamed_67) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_59 * 289.0f) >= fragment_unnamed_67) ? 1133543424u : 3281027072u);
				float fragment_unnamed_95 = fragment_unnamed_91 * mad(fragment_unnamed_91, 34.0f, 1.0f);
				float fragment_unnamed_96 = fragment_unnamed_95 * 289.0f;
				bool fragment_unnamed_98 = fragment_unnamed_96 >= ((-0.0f) - fragment_unnamed_96);
				float fragment_unnamed_105 = mad(asfloat(fragment_unnamed_98 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_98 ? 996328615u : 3143812263u) * fragment_unnamed_95), frac(fragment_unnamed_61 * asfloat((fragment_unnamed_66 >= fragment_unnamed_69) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_61 * 289.0f) >= fragment_unnamed_69) ? 1133543424u : 3281027072u));
				float fragment_unnamed_107 = fragment_unnamed_105 * mad(fragment_unnamed_105, 34.0f, 1.0f);
				float fragment_unnamed_108 = fragment_unnamed_107 * 289.0f;
				bool fragment_unnamed_110 = fragment_unnamed_108 >= ((-0.0f) - fragment_unnamed_108);
				float fragment_unnamed_120 = frac((frac(asfloat(fragment_unnamed_110 ? 996328615u : 3143812263u) * fragment_unnamed_107) * asfloat(fragment_unnamed_110 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_121 = mad(fragment_unnamed_120, 2.0f, -1.0f);
				float fragment_unnamed_128 = ((-0.0f) - floor(mad(fragment_unnamed_120, 2.0f, -0.5f))) + fragment_unnamed_121;
				float fragment_unnamed_130 = abs(fragment_unnamed_121) + (-0.5f);
				float fragment_unnamed_135 = rsqrt(dot(float2(fragment_unnamed_128, fragment_unnamed_130), float2(fragment_unnamed_128, fragment_unnamed_130)));
				float fragment_unnamed_143 = fragment_unnamed_55 + 0.0f;
				float fragment_unnamed_145 = fragment_unnamed_56 + 1.0f;
				float fragment_unnamed_146 = fragment_unnamed_55 + 1.0f;
				float fragment_unnamed_147 = fragment_unnamed_56 + 0.0f;
				float fragment_unnamed_148 = fragment_unnamed_143 * 289.0f;
				float fragment_unnamed_149 = fragment_unnamed_145 * 289.0f;
				float fragment_unnamed_150 = fragment_unnamed_146 * 289.0f;
				float fragment_unnamed_151 = fragment_unnamed_147 * 289.0f;
				bool fragment_unnamed_156 = fragment_unnamed_148 >= ((-0.0f) - fragment_unnamed_148);
				bool fragment_unnamed_157 = fragment_unnamed_149 >= ((-0.0f) - fragment_unnamed_149);
				bool fragment_unnamed_158 = fragment_unnamed_150 >= ((-0.0f) - fragment_unnamed_150);
				bool fragment_unnamed_159 = fragment_unnamed_151 >= ((-0.0f) - fragment_unnamed_151);
				float fragment_unnamed_182 = frac(fragment_unnamed_143 * asfloat(fragment_unnamed_156 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_156 ? 1133543424u : 3281027072u);
				float fragment_unnamed_186 = frac(fragment_unnamed_146 * asfloat(fragment_unnamed_158 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_158 ? 1133543424u : 3281027072u);
				float fragment_unnamed_189 = fragment_unnamed_186 * mad(fragment_unnamed_186, 34.0f, 1.0f);
				float fragment_unnamed_190 = fragment_unnamed_189 * 289.0f;
				bool fragment_unnamed_192 = fragment_unnamed_190 >= ((-0.0f) - fragment_unnamed_190);
				float fragment_unnamed_199 = mad(asfloat(fragment_unnamed_192 ? 1133543424u : 3281027072u), frac(fragment_unnamed_189 * asfloat(fragment_unnamed_192 ? 996328615u : 3143812263u)), frac(fragment_unnamed_147 * asfloat(fragment_unnamed_159 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_159 ? 1133543424u : 3281027072u));
				float fragment_unnamed_201 = fragment_unnamed_199 * mad(fragment_unnamed_199, 34.0f, 1.0f);
				float fragment_unnamed_202 = fragment_unnamed_201 * 289.0f;
				bool fragment_unnamed_204 = fragment_unnamed_202 >= ((-0.0f) - fragment_unnamed_202);
				float fragment_unnamed_213 = frac((frac(asfloat(fragment_unnamed_204 ? 996328615u : 3143812263u) * fragment_unnamed_201) * asfloat(fragment_unnamed_204 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_214 = mad(fragment_unnamed_213, 2.0f, -1.0f);
				float fragment_unnamed_218 = ((-0.0f) - floor(mad(fragment_unnamed_213, 2.0f, -0.5f))) + fragment_unnamed_214;
				float fragment_unnamed_220 = abs(fragment_unnamed_214) + (-0.5f);
				float fragment_unnamed_224 = rsqrt(dot(float2(fragment_unnamed_218, fragment_unnamed_220), float2(fragment_unnamed_218, fragment_unnamed_220)));
				float fragment_unnamed_231 = dot(float2(fragment_unnamed_224 * fragment_unnamed_218, fragment_unnamed_224 * fragment_unnamed_220), float2(fragment_unnamed_57 + (-1.0f), fragment_unnamed_58 + (-0.0f)));
				float fragment_unnamed_248 = (fragment_unnamed_58 * (fragment_unnamed_58 * fragment_unnamed_58)) * mad(fragment_unnamed_58, mad(fragment_unnamed_58, 6.0f, -15.0f), 10.0f);
				float fragment_unnamed_252 = fragment_unnamed_55 * 289.0f;
				float fragment_unnamed_253 = fragment_unnamed_56 * 289.0f;
				float fragment_unnamed_254 = (-0.0f) - fragment_unnamed_252;
				float fragment_unnamed_255 = (-0.0f) - fragment_unnamed_253;
				float fragment_unnamed_272 = frac(fragment_unnamed_55 * asfloat((fragment_unnamed_252 >= fragment_unnamed_254) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_55 * 289.0f) >= fragment_unnamed_254) ? 1133543424u : 3281027072u);
				float fragment_unnamed_275 = fragment_unnamed_272 * mad(fragment_unnamed_272, 34.0f, 1.0f);
				float fragment_unnamed_276 = fragment_unnamed_275 * 289.0f;
				bool fragment_unnamed_278 = fragment_unnamed_276 >= ((-0.0f) - fragment_unnamed_276);
				float fragment_unnamed_285 = mad(asfloat(fragment_unnamed_278 ? 1133543424u : 3281027072u), frac(fragment_unnamed_275 * asfloat(fragment_unnamed_278 ? 996328615u : 3143812263u)), frac(fragment_unnamed_56 * asfloat((fragment_unnamed_253 >= fragment_unnamed_255) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_56 * 289.0f) >= fragment_unnamed_255) ? 1133543424u : 3281027072u));
				float fragment_unnamed_287 = fragment_unnamed_285 * mad(fragment_unnamed_285, 34.0f, 1.0f);
				float fragment_unnamed_288 = fragment_unnamed_287 * 289.0f;
				bool fragment_unnamed_290 = fragment_unnamed_288 >= ((-0.0f) - fragment_unnamed_288);
				float fragment_unnamed_299 = frac((frac(fragment_unnamed_287 * asfloat(fragment_unnamed_290 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_290 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_300 = mad(fragment_unnamed_299, 2.0f, -1.0f);
				float fragment_unnamed_304 = ((-0.0f) - floor(mad(fragment_unnamed_299, 2.0f, -0.5f))) + fragment_unnamed_300;
				float fragment_unnamed_306 = abs(fragment_unnamed_300) + (-0.5f);
				float fragment_unnamed_310 = rsqrt(dot(float2(fragment_unnamed_304, fragment_unnamed_306), float2(fragment_unnamed_304, fragment_unnamed_306)));
				float fragment_unnamed_313 = dot(float2(fragment_unnamed_310 * fragment_unnamed_304, fragment_unnamed_310 * fragment_unnamed_306), float2(fragment_unnamed_57, fragment_unnamed_58));
				float fragment_unnamed_317 = fragment_unnamed_182 * mad(fragment_unnamed_182, 34.0f, 1.0f);
				float fragment_unnamed_318 = fragment_unnamed_317 * 289.0f;
				bool fragment_unnamed_320 = fragment_unnamed_318 >= ((-0.0f) - fragment_unnamed_318);
				float fragment_unnamed_327 = mad(asfloat(fragment_unnamed_320 ? 1133543424u : 3281027072u), frac(asfloat(fragment_unnamed_320 ? 996328615u : 3143812263u) * fragment_unnamed_317), frac(fragment_unnamed_145 * asfloat(fragment_unnamed_157 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_157 ? 1133543424u : 3281027072u));
				float fragment_unnamed_329 = fragment_unnamed_327 * mad(fragment_unnamed_327, 34.0f, 1.0f);
				float fragment_unnamed_330 = fragment_unnamed_329 * 289.0f;
				bool fragment_unnamed_332 = fragment_unnamed_330 >= ((-0.0f) - fragment_unnamed_330);
				float fragment_unnamed_341 = frac((frac(asfloat(fragment_unnamed_332 ? 996328615u : 3143812263u) * fragment_unnamed_329) * asfloat(fragment_unnamed_332 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_342 = mad(fragment_unnamed_341, 2.0f, -1.0f);
				float fragment_unnamed_346 = ((-0.0f) - floor(mad(fragment_unnamed_341, 2.0f, -0.5f))) + fragment_unnamed_342;
				float fragment_unnamed_348 = abs(fragment_unnamed_342) + (-0.5f);
				float fragment_unnamed_352 = rsqrt(dot(float2(fragment_unnamed_346, fragment_unnamed_348), float2(fragment_unnamed_346, fragment_unnamed_348)));
				float fragment_unnamed_360 = mad(fragment_unnamed_248, ((-0.0f) - fragment_unnamed_313) + dot(float2(fragment_unnamed_352 * fragment_unnamed_346, fragment_unnamed_352 * fragment_unnamed_348), float2(fragment_unnamed_57 + (-0.0f), fragment_unnamed_58 + (-1.0f))), fragment_unnamed_313);
				float4 fragment_unnamed_386 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_388 = fragment_unnamed_386.w;
				discard_cond((((-0.0f) - max(((-0.0f) - (((-0.0f) - fragment_unnamed_388) + 1.0f)) + ((((-0.0f) - (mad((fragment_unnamed_57 * (fragment_unnamed_57 * fragment_unnamed_57)) * mad(fragment_unnamed_57, mad(fragment_unnamed_57, 6.0f, -15.0f), 10.0f), ((-0.0f) - fragment_unnamed_360) + mad(fragment_unnamed_248, ((-0.0f) - fragment_unnamed_231) + dot(float2(fragment_unnamed_135 * fragment_unnamed_128, fragment_unnamed_135 * fragment_unnamed_130), float2(fragment_unnamed_57 + (-1.0f), fragment_unnamed_58 + (-1.0f))), fragment_unnamed_231), fragment_unnamed_360) + 0.5f)) + mad(fragment_uniform_buffer_2[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f)) + 1.0f), 0.5f)) + fragment_unnamed_388) < 0.0f);
				float fragment_unnamed_418 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_425 = fragment_unnamed_418 * fragment_input_7.x;
				float fragment_unnamed_426 = fragment_unnamed_418 * fragment_input_7.y;
				float fragment_unnamed_427 = fragment_unnamed_418 * fragment_input_7.z;
				float fragment_unnamed_436 = 1.0f / max(dot(float3(abs(fragment_unnamed_425), abs(fragment_unnamed_426), abs(fragment_unnamed_427)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_441 = clamp((-0.0f) - (fragment_unnamed_436 * fragment_unnamed_427), 0.0f, 1.0f);
				float fragment_unnamed_444 = (-0.0f) - fragment_unnamed_441;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_425, fragment_unnamed_436, ((fragment_unnamed_436 * fragment_unnamed_425) >= 0.0f) ? fragment_unnamed_441 : fragment_unnamed_444), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_426, fragment_unnamed_436, ((fragment_unnamed_436 * fragment_unnamed_426) >= 0.0f) ? fragment_unnamed_441 : fragment_unnamed_444), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_466 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_466, min((8u & 31u), (32u - fragment_unnamed_466)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[1] = float4(_Dissolve, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[17];
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
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
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
				float4 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
				float3 vertex_output_7 : INTERP6; // INTERP_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				if ((((0.0f < vertex_uniform_buffer_2[16u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
				{
					gl_Position.x = 0.0f;
					gl_Position.y = 0.0f;
					gl_Position.z = 0.0f;
					gl_Position.w = 0.0f;
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 0.0f;
					vertex_output_1.w = 0.0f;
					vertex_output_2.x = 0.0f;
					vertex_output_2.y = 0.0f;
					vertex_output_2.z = 0.0f;
					vertex_output_2.w = 0.0f;
					vertex_output_3.x = 0.0f;
					vertex_output_3.y = 0.0f;
					vertex_output_3.z = 0.0f;
					vertex_output_3.w = 0.0f;
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
					vertex_output_4.w = 0.0f;
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
					vertex_output_5.w = 0.0f;
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
					vertex_output_7.x = 0.0f;
					vertex_output_7.y = 0.0f;
					vertex_output_7.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_138 = asfloat(1065353216u);
					float vertex_unnamed_140 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_158 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_176 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_191 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_206 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_221 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_230 = rsqrt(max(dot(float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221), float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_230 * vertex_unnamed_191;
					vertex_output_7.y = vertex_unnamed_230 * vertex_unnamed_206;
					vertex_output_7.z = vertex_unnamed_230 * vertex_unnamed_221;
					float vertex_unnamed_264 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_265 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_266 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_271 = rsqrt(max(dot(float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266), float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_271 * vertex_unnamed_264;
					vertex_output_1.y = vertex_unnamed_271 * vertex_unnamed_265;
					vertex_output_1.z = vertex_unnamed_271 * vertex_unnamed_266;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_140;
					vertex_output_6.y = vertex_unnamed_158;
					vertex_output_6.z = vertex_unnamed_176;
				}
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[16] = float4(vertex_uniform_buffer_2[16][0], vertex_uniform_buffer_2[16][1], _RayTracing, vertex_uniform_buffer_2[16][3]);

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
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
			}

			#endif

			// Per-stage fallbacks for variants missing from the ripped data
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			float4 vert(float3 pos : POSITION) : SV_POSITION { return float4(0, 0, 0, 1); }
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			float4 frag() : SV_TARGET { return 0; }
			#endif
			ENDHLSL
		}
		Pass
		{
			Name "GBuffer"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "GBuffer" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			ZTest [_ZTestGBuffer]
			Cull [_CullMode]
			Stencil
			{
				Ref [_StencilRefGBuffer]
				WriteMask [_StencilWriteMaskGBuffer]
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
			GpuProgramID 580963

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ DECALS_3RT
			#pragma multi_compile_instancing
			#pragma multi_compile _ _ALPHATEST_ON


			#if (!defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(DECALS_3RT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[17];
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
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
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
				float4 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
				float3 vertex_output_7 : INTERP6; // INTERP_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				if ((((0.0f < vertex_uniform_buffer_2[16u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
				{
					gl_Position.x = 0.0f;
					gl_Position.y = 0.0f;
					gl_Position.z = 0.0f;
					gl_Position.w = 0.0f;
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 0.0f;
					vertex_output_1.w = 0.0f;
					vertex_output_2.x = 0.0f;
					vertex_output_2.y = 0.0f;
					vertex_output_2.z = 0.0f;
					vertex_output_2.w = 0.0f;
					vertex_output_3.x = 0.0f;
					vertex_output_3.y = 0.0f;
					vertex_output_3.z = 0.0f;
					vertex_output_3.w = 0.0f;
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
					vertex_output_4.w = 0.0f;
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
					vertex_output_5.w = 0.0f;
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
					vertex_output_7.x = 0.0f;
					vertex_output_7.y = 0.0f;
					vertex_output_7.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_138 = asfloat(1065353216u);
					float vertex_unnamed_140 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_158 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_176 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_191 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_206 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_221 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_230 = rsqrt(max(dot(float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221), float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_230 * vertex_unnamed_191;
					vertex_output_7.y = vertex_unnamed_230 * vertex_unnamed_206;
					vertex_output_7.z = vertex_unnamed_230 * vertex_unnamed_221;
					float vertex_unnamed_264 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_265 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_266 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_271 = rsqrt(max(dot(float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266), float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_271 * vertex_unnamed_264;
					vertex_output_1.y = vertex_unnamed_271 * vertex_unnamed_265;
					vertex_output_1.z = vertex_unnamed_271 * vertex_unnamed_266;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_140;
					vertex_output_6.y = vertex_unnamed_158;
					vertex_output_6.z = vertex_unnamed_176;
				}
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[16] = float4(vertex_uniform_buffer_2[16][0], vertex_uniform_buffer_2[16][1], _RayTracing, vertex_uniform_buffer_2[16][3]);

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
				return stage_output;
			}
			#endif
			#if (defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(DECALS_3RT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[17];
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
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
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
				float4 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
				float3 vertex_output_7 : INTERP6; // INTERP_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				if ((((0.0f < vertex_uniform_buffer_2[16u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
				{
					gl_Position.x = 0.0f;
					gl_Position.y = 0.0f;
					gl_Position.z = 0.0f;
					gl_Position.w = 0.0f;
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 0.0f;
					vertex_output_1.w = 0.0f;
					vertex_output_2.x = 0.0f;
					vertex_output_2.y = 0.0f;
					vertex_output_2.z = 0.0f;
					vertex_output_2.w = 0.0f;
					vertex_output_3.x = 0.0f;
					vertex_output_3.y = 0.0f;
					vertex_output_3.z = 0.0f;
					vertex_output_3.w = 0.0f;
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
					vertex_output_4.w = 0.0f;
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
					vertex_output_5.w = 0.0f;
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
					vertex_output_7.x = 0.0f;
					vertex_output_7.y = 0.0f;
					vertex_output_7.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_138 = asfloat(1065353216u);
					float vertex_unnamed_140 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_158 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_176 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_191 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_206 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_221 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_230 = rsqrt(max(dot(float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221), float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_230 * vertex_unnamed_191;
					vertex_output_7.y = vertex_unnamed_230 * vertex_unnamed_206;
					vertex_output_7.z = vertex_unnamed_230 * vertex_unnamed_221;
					float vertex_unnamed_264 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_265 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_266 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_271 = rsqrt(max(dot(float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266), float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_271 * vertex_unnamed_264;
					vertex_output_1.y = vertex_unnamed_271 * vertex_unnamed_265;
					vertex_output_1.z = vertex_unnamed_271 * vertex_unnamed_266;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_140;
					vertex_output_6.y = vertex_unnamed_158;
					vertex_output_6.z = vertex_unnamed_176;
				}
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[16] = float4(vertex_uniform_buffer_2[16][0], vertex_uniform_buffer_2[16][1], _RayTracing, vertex_uniform_buffer_2[16][3]);

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
				return stage_output;
			}
			#endif
			#if (defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(DECALS_3RT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
			static float4 vertex_uniform_buffer_3[17];
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
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
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
				uint vertex_unnamed_411;
				float vertex_unnamed_412;
				uint vertex_unnamed_413;
				uint vertex_unnamed_414;
				if ((((0.0f < vertex_uniform_buffer_3[16u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
				{
					gl_Position.x = 0.0f;
					gl_Position.y = 0.0f;
					gl_Position.z = 0.0f;
					gl_Position.w = 0.0f;
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 0.0f;
					vertex_output_1.w = 0.0f;
					vertex_output_2.x = 0.0f;
					vertex_output_2.y = 0.0f;
					vertex_output_2.z = 0.0f;
					vertex_output_2.w = 0.0f;
					vertex_output_3.x = 0.0f;
					vertex_output_3.y = 0.0f;
					vertex_output_3.z = 0.0f;
					vertex_output_3.w = 0.0f;
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
					vertex_output_4.w = 0.0f;
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
					vertex_output_5.w = 0.0f;
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
					vertex_unnamed_411 = 0u;
					vertex_unnamed_412 = asfloat(0u);
					vertex_unnamed_413 = 0u;
					vertex_unnamed_414 = 0u;
				}
				else
				{
					uint vertex_unnamed_113 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
					uint vertex_unnamed_125 = vertex_unnamed_113 + 3u;
					float vertex_unnamed_158 = asfloat(1065353216u);
					float vertex_unnamed_160 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_125].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_180 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_125].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_200 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_125].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_216 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 4u].xyz));
					float vertex_unnamed_232 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 5u].xyz));
					float vertex_unnamed_248 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 6u].xyz));
					float vertex_unnamed_257 = rsqrt(max(dot(float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248), float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248)), 1.1754943508222875079687365372222e-38f));
					uint vertex_unnamed_265 = vertex_unnamed_113 + 1u;
					uint vertex_unnamed_284 = vertex_unnamed_113 + 2u;
					float vertex_unnamed_292 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].x));
					float vertex_unnamed_293 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].y));
					float vertex_unnamed_294 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].z));
					float vertex_unnamed_299 = rsqrt(max(dot(float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294), float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_299 * vertex_unnamed_292;
					vertex_output_1.y = vertex_unnamed_299 * vertex_unnamed_293;
					vertex_output_1.z = vertex_unnamed_299 * vertex_unnamed_294;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_160;
					vertex_output_6.y = vertex_unnamed_180;
					vertex_output_6.z = vertex_unnamed_200;
					vertex_unnamed_411 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
					vertex_unnamed_412 = vertex_unnamed_257 * vertex_unnamed_248;
					vertex_unnamed_413 = asuint(vertex_unnamed_257 * vertex_unnamed_232);
					vertex_unnamed_414 = asuint(vertex_unnamed_257 * vertex_unnamed_216);
				}
				vertex_output_7.x = asfloat(vertex_unnamed_414);
				vertex_output_7.y = asfloat(vertex_unnamed_413);
				vertex_output_7.z = vertex_unnamed_412;
				vertex_output_8 = vertex_unnamed_411;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_3[16] = float4(vertex_uniform_buffer_3[16][0], vertex_uniform_buffer_3[16][1], _RayTracing, vertex_uniform_buffer_3[16][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
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
			#endif
			#if (defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(DECALS_3RT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
			static float4 vertex_uniform_buffer_3[17];
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
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
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
				uint vertex_unnamed_411;
				float vertex_unnamed_412;
				uint vertex_unnamed_413;
				uint vertex_unnamed_414;
				if ((((0.0f < vertex_uniform_buffer_3[16u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
				{
					gl_Position.x = 0.0f;
					gl_Position.y = 0.0f;
					gl_Position.z = 0.0f;
					gl_Position.w = 0.0f;
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 0.0f;
					vertex_output_1.w = 0.0f;
					vertex_output_2.x = 0.0f;
					vertex_output_2.y = 0.0f;
					vertex_output_2.z = 0.0f;
					vertex_output_2.w = 0.0f;
					vertex_output_3.x = 0.0f;
					vertex_output_3.y = 0.0f;
					vertex_output_3.z = 0.0f;
					vertex_output_3.w = 0.0f;
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
					vertex_output_4.w = 0.0f;
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
					vertex_output_5.w = 0.0f;
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
					vertex_unnamed_411 = 0u;
					vertex_unnamed_412 = asfloat(0u);
					vertex_unnamed_413 = 0u;
					vertex_unnamed_414 = 0u;
				}
				else
				{
					uint vertex_unnamed_113 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
					uint vertex_unnamed_125 = vertex_unnamed_113 + 3u;
					float vertex_unnamed_158 = asfloat(1065353216u);
					float vertex_unnamed_160 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_125].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_180 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_125].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_200 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_125].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_216 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 4u].xyz));
					float vertex_unnamed_232 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 5u].xyz));
					float vertex_unnamed_248 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 6u].xyz));
					float vertex_unnamed_257 = rsqrt(max(dot(float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248), float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248)), 1.1754943508222875079687365372222e-38f));
					uint vertex_unnamed_265 = vertex_unnamed_113 + 1u;
					uint vertex_unnamed_284 = vertex_unnamed_113 + 2u;
					float vertex_unnamed_292 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].x));
					float vertex_unnamed_293 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].y));
					float vertex_unnamed_294 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].z));
					float vertex_unnamed_299 = rsqrt(max(dot(float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294), float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_299 * vertex_unnamed_292;
					vertex_output_1.y = vertex_unnamed_299 * vertex_unnamed_293;
					vertex_output_1.z = vertex_unnamed_299 * vertex_unnamed_294;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_160;
					vertex_output_6.y = vertex_unnamed_180;
					vertex_output_6.z = vertex_unnamed_200;
					vertex_unnamed_411 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
					vertex_unnamed_412 = vertex_unnamed_257 * vertex_unnamed_248;
					vertex_unnamed_413 = asuint(vertex_unnamed_257 * vertex_unnamed_232);
					vertex_unnamed_414 = asuint(vertex_unnamed_257 * vertex_unnamed_216);
				}
				vertex_output_7.x = asfloat(vertex_unnamed_414);
				vertex_output_7.y = asfloat(vertex_unnamed_413);
				vertex_output_7.z = vertex_unnamed_412;
				vertex_output_8 = vertex_unnamed_411;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_3[16] = float4(vertex_uniform_buffer_3[16][0], vertex_uniform_buffer_3[16][1], _RayTracing, vertex_uniform_buffer_3[16][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
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
			#endif
			#if (defined(DECALS_3RT) && defined(INSTANCING_ON) && defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float _GlobalMipBias;
			int _ReflectionsMode;
			float _ProbeExposureScale;
			float _ReplaceDiffuseForIndirect;
			float _IndirectDiffuseLightingMultiplier;
			int _IndirectDiffuseLightingLayers;
			int _EnableDecals;
			int _IndirectDiffuseMode;
			float4 unity_WorldTransformParams;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float4 unity_ProbeVolumeSizeInv;
			float4 unity_ProbeVolumeMin;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { float4 unity_SHArArray; float4 unity_SHAgArray; float4 unity_SHAbArray; float4 unity_SHBrArray; float4 unity_SHBgArray; float4 unity_SHBbArray; float4 unity_SHCArray; } unity_Builtins2Array[2];
			float _Dissolve;
			float4 _Emission;
			float _UseMaskMap;
			float4 _DissolveColor;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[1];
			static float4 fragment_uniform_buffer_3[18];
			static float4 fragment_uniform_buffer_4[14];
			static float4 fragment_uniform_buffer_5[9];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _EmissionMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_EmissionMap;

			static float4 gl_FragCoord;
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
			static float4 fragment_output_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
				nointerpolation uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
				float4 fragment_output_3 : SV_Target3;
			};

			void frag_main()
			{
				uint fragment_unnamed_104 = fragment_input_8 + asuint(fragment_uniform_buffer_2[0u]).x;
				float fragment_unnamed_126 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_144 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_207 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_232 = asfloat(fragment_unnamed_207 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_239 = asfloat(fragment_unnamed_207 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_246 = asfloat(fragment_unnamed_207 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_250 = rsqrt(dot(float3(fragment_unnamed_232, fragment_unnamed_239, fragment_unnamed_246), float3(fragment_unnamed_232, fragment_unnamed_239, fragment_unnamed_246)));
				bool fragment_unnamed_258 = 0.0f != fragment_uniform_buffer_5[7u].x;
				float fragment_unnamed_262 = asfloat((fragment_unnamed_258 ? 4294967295u : 0u) & 1065353216u);
				float4 fragment_unnamed_276 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_279 = fragment_unnamed_276.x;
				float fragment_unnamed_280 = fragment_unnamed_276.y;
				float fragment_unnamed_281 = fragment_unnamed_276.z;
				float4 fragment_unnamed_290 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_292 = fragment_unnamed_290.x;
				float fragment_unnamed_293 = fragment_unnamed_290.y;
				float4 fragment_unnamed_303 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_309 = mad(fragment_unnamed_303.x * fragment_unnamed_303.w, 2.0f, -1.0f);
				float fragment_unnamed_312 = mad(fragment_unnamed_303.y, 2.0f, -1.0f);
				float fragment_unnamed_320 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_309, fragment_unnamed_312), float2(fragment_unnamed_309, fragment_unnamed_312)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_322 = fragment_unnamed_262 * fragment_unnamed_292;
				float4 fragment_unnamed_331 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_336 = asfloat(fragment_unnamed_258 ? 1065353216u : 1036831949u) * fragment_unnamed_290.w;
				float fragment_unnamed_347 = fragment_input_2.x * 15.0f;
				float fragment_unnamed_349 = fragment_input_2.y * 15.0f;
				float fragment_unnamed_350 = floor(fragment_unnamed_347);
				float fragment_unnamed_351 = floor(fragment_unnamed_349);
				float fragment_unnamed_352 = frac(fragment_unnamed_347);
				float fragment_unnamed_353 = frac(fragment_unnamed_349);
				float fragment_unnamed_357 = fragment_unnamed_350 * 289.0f;
				float fragment_unnamed_358 = fragment_unnamed_351 * 289.0f;
				float fragment_unnamed_359 = (-0.0f) - fragment_unnamed_357;
				float fragment_unnamed_360 = (-0.0f) - fragment_unnamed_358;
				float fragment_unnamed_381 = frac(fragment_unnamed_350 * asfloat((fragment_unnamed_357 >= fragment_unnamed_359) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_350 * 289.0f) >= fragment_unnamed_359) ? 1133543424u : 3281027072u);
				float fragment_unnamed_385 = fragment_unnamed_381 * mad(fragment_unnamed_381, 34.0f, 1.0f);
				float fragment_unnamed_386 = fragment_unnamed_385 * 289.0f;
				bool fragment_unnamed_388 = fragment_unnamed_386 >= ((-0.0f) - fragment_unnamed_386);
				float fragment_unnamed_395 = mad(asfloat(fragment_unnamed_388 ? 1133543424u : 3281027072u), frac(fragment_unnamed_385 * asfloat(fragment_unnamed_388 ? 996328615u : 3143812263u)), frac(fragment_unnamed_351 * asfloat((fragment_unnamed_358 >= fragment_unnamed_360) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_351 * 289.0f) >= fragment_unnamed_360) ? 1133543424u : 3281027072u));
				float fragment_unnamed_397 = fragment_unnamed_395 * mad(fragment_unnamed_395, 34.0f, 1.0f);
				float fragment_unnamed_398 = fragment_unnamed_397 * 289.0f;
				bool fragment_unnamed_400 = fragment_unnamed_398 >= ((-0.0f) - fragment_unnamed_398);
				float fragment_unnamed_410 = frac((frac(fragment_unnamed_397 * asfloat(fragment_unnamed_400 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_400 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_411 = mad(fragment_unnamed_410, 2.0f, -1.0f);
				float fragment_unnamed_416 = ((-0.0f) - floor(mad(fragment_unnamed_410, 2.0f, -0.5f))) + fragment_unnamed_411;
				float fragment_unnamed_418 = abs(fragment_unnamed_411) + (-0.5f);
				float fragment_unnamed_422 = rsqrt(dot(float2(fragment_unnamed_416, fragment_unnamed_418), float2(fragment_unnamed_416, fragment_unnamed_418)));
				float fragment_unnamed_425 = dot(float2(fragment_unnamed_422 * fragment_unnamed_416, fragment_unnamed_422 * fragment_unnamed_418), float2(fragment_unnamed_352, fragment_unnamed_353));
				float fragment_unnamed_428 = fragment_unnamed_350 + 0.0f;
				float fragment_unnamed_429 = fragment_unnamed_351 + 1.0f;
				float fragment_unnamed_430 = fragment_unnamed_350 + 1.0f;
				float fragment_unnamed_431 = fragment_unnamed_351 + 0.0f;
				float fragment_unnamed_432 = fragment_unnamed_428 * 289.0f;
				float fragment_unnamed_433 = fragment_unnamed_429 * 289.0f;
				float fragment_unnamed_434 = fragment_unnamed_430 * 289.0f;
				float fragment_unnamed_435 = fragment_unnamed_431 * 289.0f;
				bool fragment_unnamed_440 = fragment_unnamed_432 >= ((-0.0f) - fragment_unnamed_432);
				bool fragment_unnamed_441 = fragment_unnamed_433 >= ((-0.0f) - fragment_unnamed_433);
				bool fragment_unnamed_442 = fragment_unnamed_434 >= ((-0.0f) - fragment_unnamed_434);
				bool fragment_unnamed_443 = fragment_unnamed_435 >= ((-0.0f) - fragment_unnamed_435);
				float fragment_unnamed_456 = frac(fragment_unnamed_428 * asfloat(fragment_unnamed_440 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_440 ? 1133543424u : 3281027072u);
				float fragment_unnamed_459 = fragment_unnamed_456 * mad(fragment_unnamed_456, 34.0f, 1.0f);
				float fragment_unnamed_460 = fragment_unnamed_459 * 289.0f;
				bool fragment_unnamed_462 = fragment_unnamed_460 >= ((-0.0f) - fragment_unnamed_460);
				float fragment_unnamed_469 = mad(asfloat(fragment_unnamed_462 ? 1133543424u : 3281027072u), frac(fragment_unnamed_459 * asfloat(fragment_unnamed_462 ? 996328615u : 3143812263u)), frac(fragment_unnamed_429 * asfloat(fragment_unnamed_441 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_441 ? 1133543424u : 3281027072u));
				float fragment_unnamed_471 = fragment_unnamed_469 * mad(fragment_unnamed_469, 34.0f, 1.0f);
				float fragment_unnamed_472 = fragment_unnamed_471 * 289.0f;
				bool fragment_unnamed_474 = fragment_unnamed_472 >= ((-0.0f) - fragment_unnamed_472);
				float fragment_unnamed_483 = frac((frac(fragment_unnamed_471 * asfloat(fragment_unnamed_474 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_474 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_484 = mad(fragment_unnamed_483, 2.0f, -1.0f);
				float fragment_unnamed_488 = ((-0.0f) - floor(mad(fragment_unnamed_483, 2.0f, -0.5f))) + fragment_unnamed_484;
				float fragment_unnamed_490 = abs(fragment_unnamed_484) + (-0.5f);
				float fragment_unnamed_494 = rsqrt(dot(float2(fragment_unnamed_488, fragment_unnamed_490), float2(fragment_unnamed_488, fragment_unnamed_490)));
				float fragment_unnamed_516 = frac(fragment_unnamed_430 * asfloat(fragment_unnamed_442 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_442 ? 1133543424u : 3281027072u);
				float fragment_unnamed_519 = fragment_unnamed_516 * mad(fragment_unnamed_516, 34.0f, 1.0f);
				float fragment_unnamed_520 = fragment_unnamed_519 * 289.0f;
				bool fragment_unnamed_522 = fragment_unnamed_520 >= ((-0.0f) - fragment_unnamed_520);
				float fragment_unnamed_529 = mad(asfloat(fragment_unnamed_522 ? 1133543424u : 3281027072u), frac(fragment_unnamed_519 * asfloat(fragment_unnamed_522 ? 996328615u : 3143812263u)), frac(fragment_unnamed_431 * asfloat(fragment_unnamed_443 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_443 ? 1133543424u : 3281027072u));
				float fragment_unnamed_531 = fragment_unnamed_529 * mad(fragment_unnamed_529, 34.0f, 1.0f);
				float fragment_unnamed_532 = fragment_unnamed_531 * 289.0f;
				bool fragment_unnamed_534 = fragment_unnamed_532 >= ((-0.0f) - fragment_unnamed_532);
				float fragment_unnamed_543 = frac((frac(fragment_unnamed_531 * asfloat(fragment_unnamed_534 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_534 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_544 = mad(fragment_unnamed_543, 2.0f, -1.0f);
				float fragment_unnamed_548 = ((-0.0f) - floor(mad(fragment_unnamed_543, 2.0f, -0.5f))) + fragment_unnamed_544;
				float fragment_unnamed_550 = abs(fragment_unnamed_544) + (-0.5f);
				float fragment_unnamed_554 = rsqrt(dot(float2(fragment_unnamed_548, fragment_unnamed_550), float2(fragment_unnamed_548, fragment_unnamed_550)));
				float fragment_unnamed_557 = dot(float2(fragment_unnamed_554 * fragment_unnamed_548, fragment_unnamed_554 * fragment_unnamed_550), float2(fragment_unnamed_352 + (-1.0f), fragment_unnamed_353 + (-0.0f)));
				float fragment_unnamed_560 = fragment_unnamed_350 + 1.0f;
				float fragment_unnamed_561 = fragment_unnamed_351 + 1.0f;
				float fragment_unnamed_564 = fragment_unnamed_560 * 289.0f;
				float fragment_unnamed_565 = fragment_unnamed_561 * 289.0f;
				float fragment_unnamed_566 = (-0.0f) - fragment_unnamed_564;
				float fragment_unnamed_567 = (-0.0f) - fragment_unnamed_565;
				float fragment_unnamed_584 = frac(fragment_unnamed_560 * asfloat((fragment_unnamed_564 >= fragment_unnamed_566) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_560 * 289.0f) >= fragment_unnamed_566) ? 1133543424u : 3281027072u);
				float fragment_unnamed_587 = fragment_unnamed_584 * mad(fragment_unnamed_584, 34.0f, 1.0f);
				float fragment_unnamed_588 = fragment_unnamed_587 * 289.0f;
				bool fragment_unnamed_590 = fragment_unnamed_588 >= ((-0.0f) - fragment_unnamed_588);
				float fragment_unnamed_597 = mad(asfloat(fragment_unnamed_590 ? 1133543424u : 3281027072u), frac(fragment_unnamed_587 * asfloat(fragment_unnamed_590 ? 996328615u : 3143812263u)), frac(fragment_unnamed_561 * asfloat((fragment_unnamed_565 >= fragment_unnamed_567) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_561 * 289.0f) >= fragment_unnamed_567) ? 1133543424u : 3281027072u));
				float fragment_unnamed_599 = fragment_unnamed_597 * mad(fragment_unnamed_597, 34.0f, 1.0f);
				float fragment_unnamed_600 = fragment_unnamed_599 * 289.0f;
				bool fragment_unnamed_602 = fragment_unnamed_600 >= ((-0.0f) - fragment_unnamed_600);
				float fragment_unnamed_611 = frac((frac(fragment_unnamed_599 * asfloat(fragment_unnamed_602 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_602 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_612 = mad(fragment_unnamed_611, 2.0f, -1.0f);
				float fragment_unnamed_616 = ((-0.0f) - floor(mad(fragment_unnamed_611, 2.0f, -0.5f))) + fragment_unnamed_612;
				float fragment_unnamed_618 = abs(fragment_unnamed_612) + (-0.5f);
				float fragment_unnamed_622 = rsqrt(dot(float2(fragment_unnamed_616, fragment_unnamed_618), float2(fragment_unnamed_616, fragment_unnamed_618)));
				float fragment_unnamed_642 = mad(fragment_unnamed_353, mad(fragment_unnamed_353, 6.0f, -15.0f), 10.0f) * (fragment_unnamed_353 * (fragment_unnamed_353 * fragment_unnamed_353));
				float fragment_unnamed_645 = mad(fragment_unnamed_642, ((-0.0f) - fragment_unnamed_425) + dot(float2(fragment_unnamed_494 * fragment_unnamed_488, fragment_unnamed_494 * fragment_unnamed_490), float2(fragment_unnamed_352 + (-0.0f), fragment_unnamed_353 + (-1.0f))), fragment_unnamed_425);
				float fragment_unnamed_664 = exp2(log2(max(((mad(fragment_uniform_buffer_5[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f) + ((-0.0f) - (mad(mad(fragment_unnamed_352, mad(fragment_unnamed_352, 6.0f, -15.0f), 10.0f) * (fragment_unnamed_352 * (fragment_unnamed_352 * fragment_unnamed_352)), ((-0.0f) - fragment_unnamed_645) + mad(fragment_unnamed_642, ((-0.0f) - fragment_unnamed_557) + dot(float2(fragment_unnamed_622 * fragment_unnamed_616, fragment_unnamed_622 * fragment_unnamed_618), float2(fragment_unnamed_352 + (-1.0f), fragment_unnamed_353 + (-1.0f))), fragment_unnamed_557), fragment_unnamed_645) + 0.5f))) + 0.430000007152557373046875f) * 2.3255813121795654296875f, 0.0f)) * 20.0f);
				float fragment_unnamed_689 = mad(fragment_unnamed_320, fragment_unnamed_126 * fragment_input_7.x, mad(fragment_unnamed_309, fragment_unnamed_126 * fragment_input_1.x, (fragment_unnamed_126 * (fragment_unnamed_144 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_312));
				float fragment_unnamed_690 = mad(fragment_unnamed_320, fragment_unnamed_126 * fragment_input_7.y, mad(fragment_unnamed_309, fragment_unnamed_126 * fragment_input_1.y, (fragment_unnamed_126 * (fragment_unnamed_144 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_312));
				float fragment_unnamed_691 = mad(fragment_unnamed_320, fragment_unnamed_126 * fragment_input_7.z, mad(fragment_unnamed_309, fragment_unnamed_126 * fragment_input_1.z, (fragment_unnamed_126 * (fragment_unnamed_144 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_312));
				float fragment_unnamed_696 = rsqrt(max(dot(float3(fragment_unnamed_689, fragment_unnamed_690, fragment_unnamed_691), float3(fragment_unnamed_689, fragment_unnamed_690, fragment_unnamed_691)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_697 = fragment_unnamed_689 * fragment_unnamed_696;
				float fragment_unnamed_698 = fragment_unnamed_690 * fragment_unnamed_696;
				float fragment_unnamed_699 = fragment_unnamed_691 * fragment_unnamed_696;
				float fragment_unnamed_761;
				float fragment_unnamed_762;
				float fragment_unnamed_763;
				float fragment_unnamed_764;
				float fragment_unnamed_765;
				float fragment_unnamed_766;
				float fragment_unnamed_767;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_710 = uint(gl_FragCoord.x);
					uint fragment_unnamed_711 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_712 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_710, fragment_unnamed_711, 0u), 0u));
					float fragment_unnamed_718 = fragment_unnamed_712.w;
					float4 fragment_unnamed_719 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_710, fragment_unnamed_711, 0u), 0u));
					float fragment_unnamed_724 = fragment_unnamed_719.w;
					float4 fragment_unnamed_725 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_710, fragment_unnamed_711, 0u), 0u));
					bool fragment_unnamed_733 = fragment_unnamed_724 < 1.0f;
					float fragment_unnamed_734 = mad(fragment_unnamed_697, fragment_unnamed_724, mad(fragment_unnamed_719.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_735 = mad(fragment_unnamed_698, fragment_unnamed_724, mad(fragment_unnamed_719.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_736 = mad(fragment_unnamed_699, fragment_unnamed_724, mad(fragment_unnamed_719.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_741 = rsqrt(max(dot(float3(fragment_unnamed_734, fragment_unnamed_735, fragment_unnamed_736), float3(fragment_unnamed_734, fragment_unnamed_735, fragment_unnamed_736)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_761 = mad(fragment_unnamed_336, fragment_unnamed_725.w, fragment_unnamed_725.z);
					fragment_unnamed_762 = mad(fragment_unnamed_279, fragment_unnamed_718, fragment_unnamed_712.x);
					fragment_unnamed_763 = mad(fragment_unnamed_280, fragment_unnamed_718, fragment_unnamed_712.y);
					fragment_unnamed_764 = mad(fragment_unnamed_281, fragment_unnamed_718, fragment_unnamed_712.z);
					fragment_unnamed_765 = asfloat(fragment_unnamed_733 ? asuint(fragment_unnamed_734 * fragment_unnamed_741) : asuint(fragment_unnamed_697));
					fragment_unnamed_766 = asfloat(fragment_unnamed_733 ? asuint(fragment_unnamed_735 * fragment_unnamed_741) : asuint(fragment_unnamed_698));
					fragment_unnamed_767 = asfloat(fragment_unnamed_733 ? asuint(fragment_unnamed_736 * fragment_unnamed_741) : asuint(fragment_unnamed_699));
				}
				else
				{
					fragment_unnamed_761 = fragment_unnamed_336;
					fragment_unnamed_762 = fragment_unnamed_279;
					fragment_unnamed_763 = fragment_unnamed_280;
					fragment_unnamed_764 = fragment_unnamed_281;
					fragment_unnamed_765 = fragment_unnamed_697;
					fragment_unnamed_766 = fragment_unnamed_698;
					fragment_unnamed_767 = fragment_unnamed_699;
				}
				float fragment_unnamed_771 = max(dot(float3(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767), float3(fragment_unnamed_250 * fragment_unnamed_232, fragment_unnamed_250 * fragment_unnamed_239, fragment_unnamed_250 * fragment_unnamed_246)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_774 = ((-0.0f) - fragment_unnamed_761) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_293 + exp2(log2(abs(fragment_unnamed_293 + fragment_unnamed_771)) * exp2(mad(fragment_unnamed_774 * fragment_unnamed_774, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_804 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_805 = fragment_unnamed_804.x;
				float fragment_unnamed_1093;
				float fragment_unnamed_1095;
				float fragment_unnamed_1097;
				if (((((fragment_unnamed_805 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_805 != 0u) ? 4294967295u : 0u)) & ((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u)) == 0u)
				{
					float fragment_unnamed_1094;
					float fragment_unnamed_1096;
					float fragment_unnamed_1098;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						uint fragment_unnamed_828 = fragment_unnamed_104 * 7u;
						float fragment_unnamed_829 = asfloat(1065353216u);
						float fragment_unnamed_859 = fragment_unnamed_766 * fragment_unnamed_765;
						float fragment_unnamed_860 = fragment_unnamed_767 * fragment_unnamed_766;
						float fragment_unnamed_861 = fragment_unnamed_767 * fragment_unnamed_767;
						float fragment_unnamed_862 = fragment_unnamed_765 * fragment_unnamed_767;
						float fragment_unnamed_897 = mad(fragment_unnamed_765, fragment_unnamed_765, (-0.0f) - (fragment_unnamed_766 * fragment_unnamed_766));
						uint fragment_unnamed_898 = fragment_unnamed_828 + 6u;
						fragment_unnamed_1094 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828 + 2u]), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_829)) + mad(fragment_uniform_buffer_4[fragment_unnamed_898].z, fragment_unnamed_897, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828 + 5u]), float4(fragment_unnamed_859, fragment_unnamed_860, fragment_unnamed_861, fragment_unnamed_862)));
						fragment_unnamed_1096 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828 + 1u]), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_829)) + mad(fragment_uniform_buffer_4[fragment_unnamed_898].y, fragment_unnamed_897, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828 + 4u]), float4(fragment_unnamed_859, fragment_unnamed_860, fragment_unnamed_861, fragment_unnamed_862)));
						fragment_unnamed_1098 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828]), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_829)) + mad(fragment_uniform_buffer_4[fragment_unnamed_898].x, fragment_unnamed_897, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828 + 3u]), float4(fragment_unnamed_859, fragment_unnamed_860, fragment_unnamed_861, fragment_unnamed_862)));
					}
					else
					{
						bool fragment_unnamed_913 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_914 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_936 = fragment_unnamed_913 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_937 = fragment_unnamed_913 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_938 = fragment_unnamed_913 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_1042 = (asfloat(fragment_unnamed_914 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_938, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_936, fragment_unnamed_937 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_937)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_1043 = (asfloat(fragment_unnamed_914 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_938, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_936, fragment_unnamed_937 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_938)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_1056 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_914 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_938, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_936, fragment_unnamed_937 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_936)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_1083 = asfloat(1065353216u);
						fragment_unnamed_1094 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1056 + 0.5f, fragment_unnamed_1042 + 0.0f, fragment_unnamed_1043 + 0.0f), 0.0f)), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_1083));
						fragment_unnamed_1096 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1056 + 0.25f, fragment_unnamed_1042 + 0.0f, fragment_unnamed_1043 + 0.0f), 0.0f)), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_1083));
						fragment_unnamed_1098 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1056, fragment_unnamed_1042, fragment_unnamed_1043), 0.0f)), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_1083));
					}
					fragment_unnamed_1093 = fragment_unnamed_1094;
					fragment_unnamed_1095 = fragment_unnamed_1096;
					fragment_unnamed_1097 = fragment_unnamed_1098;
				}
				else
				{
					fragment_unnamed_1093 = asfloat(0u);
					fragment_unnamed_1095 = asfloat(0u);
					fragment_unnamed_1097 = asfloat(0u);
				}
				float fragment_unnamed_1100 = mad((-0.0f) - fragment_unnamed_262, fragment_unnamed_292, 1.0f);
				float fragment_unnamed_1101 = fragment_unnamed_1100 * fragment_unnamed_762;
				float fragment_unnamed_1102 = fragment_unnamed_1100 * fragment_unnamed_763;
				float fragment_unnamed_1103 = fragment_unnamed_1100 * fragment_unnamed_764;
				float fragment_unnamed_1108 = mad(fragment_unnamed_322, fragment_unnamed_762 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1110 = mad(fragment_unnamed_322, fragment_unnamed_763 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1111 = mad(fragment_unnamed_322, fragment_unnamed_764 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1123 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_771), 0.984375f, 0.0078125f), mad(fragment_unnamed_774, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_1133 = clamp((max(fragment_unnamed_1111, max(fragment_unnamed_1110, fragment_unnamed_1108)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_1157 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_3[(fragment_unnamed_104 * 9u) + 8u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1162 = max(abs(fragment_unnamed_767), 0.0009765625f);
				float fragment_unnamed_1166 = (fragment_unnamed_767 >= 0.0f) ? fragment_unnamed_1162 : ((-0.0f) - fragment_unnamed_1162);
				float fragment_unnamed_1175 = 1.0f / max(dot(float3(abs(fragment_unnamed_765), abs(fragment_unnamed_766), abs(fragment_unnamed_1166)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1180 = clamp((-0.0f) - (fragment_unnamed_1175 * fragment_unnamed_1166), 0.0f, 1.0f);
				float fragment_unnamed_1183 = (-0.0f) - fragment_unnamed_1180;
				uint fragment_unnamed_1195 = uint(clamp(mad(mad(fragment_unnamed_765, fragment_unnamed_1175, ((fragment_unnamed_1175 * fragment_unnamed_765) >= 0.0f) ? fragment_unnamed_1180 : fragment_unnamed_1183), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1196 = uint(clamp(mad(mad(fragment_unnamed_766, fragment_unnamed_1175, ((fragment_unnamed_1175 * fragment_unnamed_766) >= 0.0f) ? fragment_unnamed_1180 : fragment_unnamed_1183), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1195 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1196 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1196 >> 8u) * 16u) + (fragment_unnamed_1195 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_1108)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_1110)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_1111)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_1249 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1250 = fragment_unnamed_1249 * mad(fragment_unnamed_1157 * ((fragment_unnamed_1123 * mad(fragment_unnamed_1133, mad((-0.0f) - fragment_unnamed_762, fragment_unnamed_1100, fragment_unnamed_1108), fragment_unnamed_1101)) * fragment_unnamed_1097), fragment_unnamed_293, mad(fragment_uniform_buffer_5[6u].x, fragment_unnamed_331.x, fragment_unnamed_664 * fragment_uniform_buffer_5[8u].x));
				float fragment_unnamed_1251 = fragment_unnamed_1249 * mad(fragment_unnamed_1157 * ((fragment_unnamed_1123 * mad(fragment_unnamed_1133, mad((-0.0f) - fragment_unnamed_763, fragment_unnamed_1100, fragment_unnamed_1110), fragment_unnamed_1102)) * fragment_unnamed_1095), fragment_unnamed_293, mad(fragment_uniform_buffer_5[6u].y, fragment_unnamed_331.y, fragment_unnamed_664 * fragment_uniform_buffer_5[8u].y));
				float fragment_unnamed_1252 = fragment_unnamed_1249 * mad(fragment_unnamed_1157 * ((fragment_unnamed_1123 * mad(fragment_unnamed_1133, mad((-0.0f) - fragment_unnamed_764, fragment_unnamed_1100, fragment_unnamed_1111), fragment_unnamed_1103)) * fragment_unnamed_1093), fragment_unnamed_293, mad(fragment_uniform_buffer_5[6u].z, fragment_unnamed_331.z, fragment_unnamed_664 * fragment_uniform_buffer_5[8u].z));
				bool fragment_unnamed_1265 = (((fragment_unnamed_1252 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1251 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1250 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1265 ? asfloat(1157627904u) : fragment_unnamed_1250;
				fragment_output_3.y = fragment_unnamed_1265 ? fragment_unnamed_293 : fragment_unnamed_1251;
				fragment_output_3.z = fragment_unnamed_1265 ? asfloat(1149239296u) : fragment_unnamed_1252;
				fragment_output_0.x = fragment_unnamed_1101;
				fragment_output_0.y = fragment_unnamed_1102;
				fragment_output_0.z = fragment_unnamed_1103;
				fragment_output_1.w = fragment_unnamed_774;
				fragment_output_2.w = 0.0f;
				fragment_output_3.w = 0.0f;
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

				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_0[113] = float4(fragment_uniform_buffer_0[113][0], fragment_uniform_buffer_0[113][1], fragment_uniform_buffer_0[113][2], asfloat(_ReflectionsMode));

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], _ProbeExposureScale, fragment_uniform_buffer_0[118][2], fragment_uniform_buffer_0[118][3]);

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], fragment_uniform_buffer_0[118][1], fragment_uniform_buffer_0[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_0[120] = float4(_IndirectDiffuseLightingMultiplier, fragment_uniform_buffer_0[120][1], fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[120] = float4(fragment_uniform_buffer_0[120][0], asfloat(_IndirectDiffuseLightingLayers), fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[210] = float4(fragment_uniform_buffer_0[210][0], fragment_uniform_buffer_0[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_0[210][3]);

				fragment_uniform_buffer_0[213] = float4(asfloat(_IndirectDiffuseMode), fragment_uniform_buffer_0[213][1], fragment_uniform_buffer_0[213][2], fragment_uniform_buffer_0[213][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_1[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_1[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_1[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_1[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_1[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_1[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_1[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_3[8][1], fragment_uniform_buffer_3[8][2], fragment_uniform_buffer_3[8][3]);
				fragment_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_3[17][1], fragment_uniform_buffer_3[17][2], fragment_uniform_buffer_3[17][3]);
				fragment_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_uniform_buffer_4[0] = float4(unity_Builtins2Array[0].unity_SHArArray[0], unity_Builtins2Array[0].unity_SHArArray[1], unity_Builtins2Array[0].unity_SHArArray[2], unity_Builtins2Array[0].unity_SHArArray[3]);
				fragment_uniform_buffer_4[1] = float4(unity_Builtins2Array[0].unity_SHAgArray[0], unity_Builtins2Array[0].unity_SHAgArray[1], unity_Builtins2Array[0].unity_SHAgArray[2], unity_Builtins2Array[0].unity_SHAgArray[3]);
				fragment_uniform_buffer_4[2] = float4(unity_Builtins2Array[0].unity_SHAbArray[0], unity_Builtins2Array[0].unity_SHAbArray[1], unity_Builtins2Array[0].unity_SHAbArray[2], unity_Builtins2Array[0].unity_SHAbArray[3]);
				fragment_uniform_buffer_4[3] = float4(unity_Builtins2Array[0].unity_SHBrArray[0], unity_Builtins2Array[0].unity_SHBrArray[1], unity_Builtins2Array[0].unity_SHBrArray[2], unity_Builtins2Array[0].unity_SHBrArray[3]);
				fragment_uniform_buffer_4[4] = float4(unity_Builtins2Array[0].unity_SHBgArray[0], unity_Builtins2Array[0].unity_SHBgArray[1], unity_Builtins2Array[0].unity_SHBgArray[2], unity_Builtins2Array[0].unity_SHBgArray[3]);
				fragment_uniform_buffer_4[5] = float4(unity_Builtins2Array[0].unity_SHBbArray[0], unity_Builtins2Array[0].unity_SHBbArray[1], unity_Builtins2Array[0].unity_SHBbArray[2], unity_Builtins2Array[0].unity_SHBbArray[3]);
				fragment_uniform_buffer_4[6] = float4(unity_Builtins2Array[0].unity_SHCArray[0], unity_Builtins2Array[0].unity_SHCArray[1], unity_Builtins2Array[0].unity_SHCArray[2], unity_Builtins2Array[0].unity_SHCArray[3]);
				fragment_uniform_buffer_4[7] = float4(unity_Builtins2Array[1].unity_SHArArray[0], unity_Builtins2Array[1].unity_SHArArray[1], unity_Builtins2Array[1].unity_SHArArray[2], unity_Builtins2Array[1].unity_SHArArray[3]);
				fragment_uniform_buffer_4[8] = float4(unity_Builtins2Array[1].unity_SHAgArray[0], unity_Builtins2Array[1].unity_SHAgArray[1], unity_Builtins2Array[1].unity_SHAgArray[2], unity_Builtins2Array[1].unity_SHAgArray[3]);
				fragment_uniform_buffer_4[9] = float4(unity_Builtins2Array[1].unity_SHAbArray[0], unity_Builtins2Array[1].unity_SHAbArray[1], unity_Builtins2Array[1].unity_SHAbArray[2], unity_Builtins2Array[1].unity_SHAbArray[3]);
				fragment_uniform_buffer_4[10] = float4(unity_Builtins2Array[1].unity_SHBrArray[0], unity_Builtins2Array[1].unity_SHBrArray[1], unity_Builtins2Array[1].unity_SHBrArray[2], unity_Builtins2Array[1].unity_SHBrArray[3]);
				fragment_uniform_buffer_4[11] = float4(unity_Builtins2Array[1].unity_SHBgArray[0], unity_Builtins2Array[1].unity_SHBgArray[1], unity_Builtins2Array[1].unity_SHBgArray[2], unity_Builtins2Array[1].unity_SHBgArray[3]);
				fragment_uniform_buffer_4[12] = float4(unity_Builtins2Array[1].unity_SHBbArray[0], unity_Builtins2Array[1].unity_SHBbArray[1], unity_Builtins2Array[1].unity_SHBbArray[2], unity_Builtins2Array[1].unity_SHBbArray[3]);
				fragment_uniform_buffer_4[13] = float4(unity_Builtins2Array[1].unity_SHCArray[0], unity_Builtins2Array[1].unity_SHCArray[1], unity_Builtins2Array[1].unity_SHCArray[2], unity_Builtins2Array[1].unity_SHCArray[3]);

				fragment_uniform_buffer_5[1] = float4(_Dissolve, fragment_uniform_buffer_5[1][1], fragment_uniform_buffer_5[1][2], fragment_uniform_buffer_5[1][3]);

				fragment_uniform_buffer_5[6] = float4(_Emission[0], _Emission[1], _Emission[2], _Emission[3]);

				fragment_uniform_buffer_5[7] = float4(_UseMaskMap, fragment_uniform_buffer_5[7][1], fragment_uniform_buffer_5[7][2], fragment_uniform_buffer_5[7][3]);

				fragment_uniform_buffer_5[8] = float4(_DissolveColor[0], _DissolveColor[1], _DissolveColor[2], _DissolveColor[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif
			#if (defined(DECALS_3RT) && defined(INSTANCING_ON) && !defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float _GlobalMipBias;
			int _ReflectionsMode;
			float _ProbeExposureScale;
			float _ReplaceDiffuseForIndirect;
			float _IndirectDiffuseLightingMultiplier;
			int _IndirectDiffuseLightingLayers;
			int _EnableDecals;
			int _IndirectDiffuseMode;
			float4 unity_WorldTransformParams;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float4 unity_ProbeVolumeSizeInv;
			float4 unity_ProbeVolumeMin;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { float4 unity_SHArArray; float4 unity_SHAgArray; float4 unity_SHAbArray; float4 unity_SHBrArray; float4 unity_SHBgArray; float4 unity_SHBbArray; float4 unity_SHCArray; } unity_Builtins2Array[2];
			float _Dissolve;
			float4 _Emission;
			float _UseMaskMap;
			float4 _DissolveColor;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[1];
			static float4 fragment_uniform_buffer_3[18];
			static float4 fragment_uniform_buffer_4[14];
			static float4 fragment_uniform_buffer_5[9];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _EmissionMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_EmissionMap;

			static float4 gl_FragCoord;
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
			static float4 fragment_output_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
				nointerpolation uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
				float4 fragment_output_3 : SV_Target3;
			};

			void frag_main()
			{
				uint fragment_unnamed_104 = fragment_input_8 + asuint(fragment_uniform_buffer_2[0u]).x;
				float fragment_unnamed_126 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_144 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_207 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_232 = asfloat(fragment_unnamed_207 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_239 = asfloat(fragment_unnamed_207 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_246 = asfloat(fragment_unnamed_207 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_250 = rsqrt(dot(float3(fragment_unnamed_232, fragment_unnamed_239, fragment_unnamed_246), float3(fragment_unnamed_232, fragment_unnamed_239, fragment_unnamed_246)));
				bool fragment_unnamed_258 = 0.0f != fragment_uniform_buffer_5[7u].x;
				float fragment_unnamed_262 = asfloat((fragment_unnamed_258 ? 4294967295u : 0u) & 1065353216u);
				float4 fragment_unnamed_276 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_279 = fragment_unnamed_276.x;
				float fragment_unnamed_280 = fragment_unnamed_276.y;
				float fragment_unnamed_281 = fragment_unnamed_276.z;
				float4 fragment_unnamed_290 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_292 = fragment_unnamed_290.x;
				float fragment_unnamed_293 = fragment_unnamed_290.y;
				float4 fragment_unnamed_303 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_309 = mad(fragment_unnamed_303.x * fragment_unnamed_303.w, 2.0f, -1.0f);
				float fragment_unnamed_312 = mad(fragment_unnamed_303.y, 2.0f, -1.0f);
				float fragment_unnamed_320 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_309, fragment_unnamed_312), float2(fragment_unnamed_309, fragment_unnamed_312)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_322 = fragment_unnamed_262 * fragment_unnamed_292;
				float4 fragment_unnamed_331 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_336 = asfloat(fragment_unnamed_258 ? 1065353216u : 1036831949u) * fragment_unnamed_290.w;
				float fragment_unnamed_347 = fragment_input_2.x * 15.0f;
				float fragment_unnamed_349 = fragment_input_2.y * 15.0f;
				float fragment_unnamed_350 = floor(fragment_unnamed_347);
				float fragment_unnamed_351 = floor(fragment_unnamed_349);
				float fragment_unnamed_352 = frac(fragment_unnamed_347);
				float fragment_unnamed_353 = frac(fragment_unnamed_349);
				float fragment_unnamed_357 = fragment_unnamed_350 * 289.0f;
				float fragment_unnamed_358 = fragment_unnamed_351 * 289.0f;
				float fragment_unnamed_359 = (-0.0f) - fragment_unnamed_357;
				float fragment_unnamed_360 = (-0.0f) - fragment_unnamed_358;
				float fragment_unnamed_381 = frac(fragment_unnamed_350 * asfloat((fragment_unnamed_357 >= fragment_unnamed_359) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_350 * 289.0f) >= fragment_unnamed_359) ? 1133543424u : 3281027072u);
				float fragment_unnamed_385 = fragment_unnamed_381 * mad(fragment_unnamed_381, 34.0f, 1.0f);
				float fragment_unnamed_386 = fragment_unnamed_385 * 289.0f;
				bool fragment_unnamed_388 = fragment_unnamed_386 >= ((-0.0f) - fragment_unnamed_386);
				float fragment_unnamed_395 = mad(asfloat(fragment_unnamed_388 ? 1133543424u : 3281027072u), frac(fragment_unnamed_385 * asfloat(fragment_unnamed_388 ? 996328615u : 3143812263u)), frac(fragment_unnamed_351 * asfloat((fragment_unnamed_358 >= fragment_unnamed_360) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_351 * 289.0f) >= fragment_unnamed_360) ? 1133543424u : 3281027072u));
				float fragment_unnamed_397 = fragment_unnamed_395 * mad(fragment_unnamed_395, 34.0f, 1.0f);
				float fragment_unnamed_398 = fragment_unnamed_397 * 289.0f;
				bool fragment_unnamed_400 = fragment_unnamed_398 >= ((-0.0f) - fragment_unnamed_398);
				float fragment_unnamed_410 = frac((frac(fragment_unnamed_397 * asfloat(fragment_unnamed_400 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_400 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_411 = mad(fragment_unnamed_410, 2.0f, -1.0f);
				float fragment_unnamed_416 = ((-0.0f) - floor(mad(fragment_unnamed_410, 2.0f, -0.5f))) + fragment_unnamed_411;
				float fragment_unnamed_418 = abs(fragment_unnamed_411) + (-0.5f);
				float fragment_unnamed_422 = rsqrt(dot(float2(fragment_unnamed_416, fragment_unnamed_418), float2(fragment_unnamed_416, fragment_unnamed_418)));
				float fragment_unnamed_425 = dot(float2(fragment_unnamed_422 * fragment_unnamed_416, fragment_unnamed_422 * fragment_unnamed_418), float2(fragment_unnamed_352, fragment_unnamed_353));
				float fragment_unnamed_428 = fragment_unnamed_350 + 0.0f;
				float fragment_unnamed_429 = fragment_unnamed_351 + 1.0f;
				float fragment_unnamed_430 = fragment_unnamed_350 + 1.0f;
				float fragment_unnamed_431 = fragment_unnamed_351 + 0.0f;
				float fragment_unnamed_432 = fragment_unnamed_428 * 289.0f;
				float fragment_unnamed_433 = fragment_unnamed_429 * 289.0f;
				float fragment_unnamed_434 = fragment_unnamed_430 * 289.0f;
				float fragment_unnamed_435 = fragment_unnamed_431 * 289.0f;
				bool fragment_unnamed_440 = fragment_unnamed_432 >= ((-0.0f) - fragment_unnamed_432);
				bool fragment_unnamed_441 = fragment_unnamed_433 >= ((-0.0f) - fragment_unnamed_433);
				bool fragment_unnamed_442 = fragment_unnamed_434 >= ((-0.0f) - fragment_unnamed_434);
				bool fragment_unnamed_443 = fragment_unnamed_435 >= ((-0.0f) - fragment_unnamed_435);
				float fragment_unnamed_456 = frac(fragment_unnamed_428 * asfloat(fragment_unnamed_440 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_440 ? 1133543424u : 3281027072u);
				float fragment_unnamed_459 = fragment_unnamed_456 * mad(fragment_unnamed_456, 34.0f, 1.0f);
				float fragment_unnamed_460 = fragment_unnamed_459 * 289.0f;
				bool fragment_unnamed_462 = fragment_unnamed_460 >= ((-0.0f) - fragment_unnamed_460);
				float fragment_unnamed_469 = mad(asfloat(fragment_unnamed_462 ? 1133543424u : 3281027072u), frac(fragment_unnamed_459 * asfloat(fragment_unnamed_462 ? 996328615u : 3143812263u)), frac(fragment_unnamed_429 * asfloat(fragment_unnamed_441 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_441 ? 1133543424u : 3281027072u));
				float fragment_unnamed_471 = fragment_unnamed_469 * mad(fragment_unnamed_469, 34.0f, 1.0f);
				float fragment_unnamed_472 = fragment_unnamed_471 * 289.0f;
				bool fragment_unnamed_474 = fragment_unnamed_472 >= ((-0.0f) - fragment_unnamed_472);
				float fragment_unnamed_483 = frac((frac(fragment_unnamed_471 * asfloat(fragment_unnamed_474 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_474 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_484 = mad(fragment_unnamed_483, 2.0f, -1.0f);
				float fragment_unnamed_488 = ((-0.0f) - floor(mad(fragment_unnamed_483, 2.0f, -0.5f))) + fragment_unnamed_484;
				float fragment_unnamed_490 = abs(fragment_unnamed_484) + (-0.5f);
				float fragment_unnamed_494 = rsqrt(dot(float2(fragment_unnamed_488, fragment_unnamed_490), float2(fragment_unnamed_488, fragment_unnamed_490)));
				float fragment_unnamed_516 = frac(fragment_unnamed_430 * asfloat(fragment_unnamed_442 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_442 ? 1133543424u : 3281027072u);
				float fragment_unnamed_519 = fragment_unnamed_516 * mad(fragment_unnamed_516, 34.0f, 1.0f);
				float fragment_unnamed_520 = fragment_unnamed_519 * 289.0f;
				bool fragment_unnamed_522 = fragment_unnamed_520 >= ((-0.0f) - fragment_unnamed_520);
				float fragment_unnamed_529 = mad(asfloat(fragment_unnamed_522 ? 1133543424u : 3281027072u), frac(fragment_unnamed_519 * asfloat(fragment_unnamed_522 ? 996328615u : 3143812263u)), frac(fragment_unnamed_431 * asfloat(fragment_unnamed_443 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_443 ? 1133543424u : 3281027072u));
				float fragment_unnamed_531 = fragment_unnamed_529 * mad(fragment_unnamed_529, 34.0f, 1.0f);
				float fragment_unnamed_532 = fragment_unnamed_531 * 289.0f;
				bool fragment_unnamed_534 = fragment_unnamed_532 >= ((-0.0f) - fragment_unnamed_532);
				float fragment_unnamed_543 = frac((frac(fragment_unnamed_531 * asfloat(fragment_unnamed_534 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_534 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_544 = mad(fragment_unnamed_543, 2.0f, -1.0f);
				float fragment_unnamed_548 = ((-0.0f) - floor(mad(fragment_unnamed_543, 2.0f, -0.5f))) + fragment_unnamed_544;
				float fragment_unnamed_550 = abs(fragment_unnamed_544) + (-0.5f);
				float fragment_unnamed_554 = rsqrt(dot(float2(fragment_unnamed_548, fragment_unnamed_550), float2(fragment_unnamed_548, fragment_unnamed_550)));
				float fragment_unnamed_557 = dot(float2(fragment_unnamed_554 * fragment_unnamed_548, fragment_unnamed_554 * fragment_unnamed_550), float2(fragment_unnamed_352 + (-1.0f), fragment_unnamed_353 + (-0.0f)));
				float fragment_unnamed_560 = fragment_unnamed_350 + 1.0f;
				float fragment_unnamed_561 = fragment_unnamed_351 + 1.0f;
				float fragment_unnamed_564 = fragment_unnamed_560 * 289.0f;
				float fragment_unnamed_565 = fragment_unnamed_561 * 289.0f;
				float fragment_unnamed_566 = (-0.0f) - fragment_unnamed_564;
				float fragment_unnamed_567 = (-0.0f) - fragment_unnamed_565;
				float fragment_unnamed_584 = frac(fragment_unnamed_560 * asfloat((fragment_unnamed_564 >= fragment_unnamed_566) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_560 * 289.0f) >= fragment_unnamed_566) ? 1133543424u : 3281027072u);
				float fragment_unnamed_587 = fragment_unnamed_584 * mad(fragment_unnamed_584, 34.0f, 1.0f);
				float fragment_unnamed_588 = fragment_unnamed_587 * 289.0f;
				bool fragment_unnamed_590 = fragment_unnamed_588 >= ((-0.0f) - fragment_unnamed_588);
				float fragment_unnamed_597 = mad(asfloat(fragment_unnamed_590 ? 1133543424u : 3281027072u), frac(fragment_unnamed_587 * asfloat(fragment_unnamed_590 ? 996328615u : 3143812263u)), frac(fragment_unnamed_561 * asfloat((fragment_unnamed_565 >= fragment_unnamed_567) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_561 * 289.0f) >= fragment_unnamed_567) ? 1133543424u : 3281027072u));
				float fragment_unnamed_599 = fragment_unnamed_597 * mad(fragment_unnamed_597, 34.0f, 1.0f);
				float fragment_unnamed_600 = fragment_unnamed_599 * 289.0f;
				bool fragment_unnamed_602 = fragment_unnamed_600 >= ((-0.0f) - fragment_unnamed_600);
				float fragment_unnamed_611 = frac((frac(fragment_unnamed_599 * asfloat(fragment_unnamed_602 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_602 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_612 = mad(fragment_unnamed_611, 2.0f, -1.0f);
				float fragment_unnamed_616 = ((-0.0f) - floor(mad(fragment_unnamed_611, 2.0f, -0.5f))) + fragment_unnamed_612;
				float fragment_unnamed_618 = abs(fragment_unnamed_612) + (-0.5f);
				float fragment_unnamed_622 = rsqrt(dot(float2(fragment_unnamed_616, fragment_unnamed_618), float2(fragment_unnamed_616, fragment_unnamed_618)));
				float fragment_unnamed_642 = mad(fragment_unnamed_353, mad(fragment_unnamed_353, 6.0f, -15.0f), 10.0f) * (fragment_unnamed_353 * (fragment_unnamed_353 * fragment_unnamed_353));
				float fragment_unnamed_645 = mad(fragment_unnamed_642, ((-0.0f) - fragment_unnamed_425) + dot(float2(fragment_unnamed_494 * fragment_unnamed_488, fragment_unnamed_494 * fragment_unnamed_490), float2(fragment_unnamed_352 + (-0.0f), fragment_unnamed_353 + (-1.0f))), fragment_unnamed_425);
				float fragment_unnamed_664 = exp2(log2(max(((mad(fragment_uniform_buffer_5[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f) + ((-0.0f) - (mad(mad(fragment_unnamed_352, mad(fragment_unnamed_352, 6.0f, -15.0f), 10.0f) * (fragment_unnamed_352 * (fragment_unnamed_352 * fragment_unnamed_352)), ((-0.0f) - fragment_unnamed_645) + mad(fragment_unnamed_642, ((-0.0f) - fragment_unnamed_557) + dot(float2(fragment_unnamed_622 * fragment_unnamed_616, fragment_unnamed_622 * fragment_unnamed_618), float2(fragment_unnamed_352 + (-1.0f), fragment_unnamed_353 + (-1.0f))), fragment_unnamed_557), fragment_unnamed_645) + 0.5f))) + 0.430000007152557373046875f) * 2.3255813121795654296875f, 0.0f)) * 20.0f);
				float fragment_unnamed_689 = mad(fragment_unnamed_320, fragment_unnamed_126 * fragment_input_7.x, mad(fragment_unnamed_309, fragment_unnamed_126 * fragment_input_1.x, (fragment_unnamed_126 * (fragment_unnamed_144 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_312));
				float fragment_unnamed_690 = mad(fragment_unnamed_320, fragment_unnamed_126 * fragment_input_7.y, mad(fragment_unnamed_309, fragment_unnamed_126 * fragment_input_1.y, (fragment_unnamed_126 * (fragment_unnamed_144 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_312));
				float fragment_unnamed_691 = mad(fragment_unnamed_320, fragment_unnamed_126 * fragment_input_7.z, mad(fragment_unnamed_309, fragment_unnamed_126 * fragment_input_1.z, (fragment_unnamed_126 * (fragment_unnamed_144 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_312));
				float fragment_unnamed_696 = rsqrt(max(dot(float3(fragment_unnamed_689, fragment_unnamed_690, fragment_unnamed_691), float3(fragment_unnamed_689, fragment_unnamed_690, fragment_unnamed_691)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_697 = fragment_unnamed_689 * fragment_unnamed_696;
				float fragment_unnamed_698 = fragment_unnamed_690 * fragment_unnamed_696;
				float fragment_unnamed_699 = fragment_unnamed_691 * fragment_unnamed_696;
				float fragment_unnamed_761;
				float fragment_unnamed_762;
				float fragment_unnamed_763;
				float fragment_unnamed_764;
				float fragment_unnamed_765;
				float fragment_unnamed_766;
				float fragment_unnamed_767;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_710 = uint(gl_FragCoord.x);
					uint fragment_unnamed_711 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_712 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_710, fragment_unnamed_711, 0u), 0u));
					float fragment_unnamed_718 = fragment_unnamed_712.w;
					float4 fragment_unnamed_719 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_710, fragment_unnamed_711, 0u), 0u));
					float fragment_unnamed_724 = fragment_unnamed_719.w;
					float4 fragment_unnamed_725 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_710, fragment_unnamed_711, 0u), 0u));
					bool fragment_unnamed_733 = fragment_unnamed_724 < 1.0f;
					float fragment_unnamed_734 = mad(fragment_unnamed_697, fragment_unnamed_724, mad(fragment_unnamed_719.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_735 = mad(fragment_unnamed_698, fragment_unnamed_724, mad(fragment_unnamed_719.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_736 = mad(fragment_unnamed_699, fragment_unnamed_724, mad(fragment_unnamed_719.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_741 = rsqrt(max(dot(float3(fragment_unnamed_734, fragment_unnamed_735, fragment_unnamed_736), float3(fragment_unnamed_734, fragment_unnamed_735, fragment_unnamed_736)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_761 = mad(fragment_unnamed_336, fragment_unnamed_725.w, fragment_unnamed_725.z);
					fragment_unnamed_762 = mad(fragment_unnamed_279, fragment_unnamed_718, fragment_unnamed_712.x);
					fragment_unnamed_763 = mad(fragment_unnamed_280, fragment_unnamed_718, fragment_unnamed_712.y);
					fragment_unnamed_764 = mad(fragment_unnamed_281, fragment_unnamed_718, fragment_unnamed_712.z);
					fragment_unnamed_765 = asfloat(fragment_unnamed_733 ? asuint(fragment_unnamed_734 * fragment_unnamed_741) : asuint(fragment_unnamed_697));
					fragment_unnamed_766 = asfloat(fragment_unnamed_733 ? asuint(fragment_unnamed_735 * fragment_unnamed_741) : asuint(fragment_unnamed_698));
					fragment_unnamed_767 = asfloat(fragment_unnamed_733 ? asuint(fragment_unnamed_736 * fragment_unnamed_741) : asuint(fragment_unnamed_699));
				}
				else
				{
					fragment_unnamed_761 = fragment_unnamed_336;
					fragment_unnamed_762 = fragment_unnamed_279;
					fragment_unnamed_763 = fragment_unnamed_280;
					fragment_unnamed_764 = fragment_unnamed_281;
					fragment_unnamed_765 = fragment_unnamed_697;
					fragment_unnamed_766 = fragment_unnamed_698;
					fragment_unnamed_767 = fragment_unnamed_699;
				}
				float fragment_unnamed_771 = max(dot(float3(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767), float3(fragment_unnamed_250 * fragment_unnamed_232, fragment_unnamed_250 * fragment_unnamed_239, fragment_unnamed_250 * fragment_unnamed_246)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_774 = ((-0.0f) - fragment_unnamed_761) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_293 + exp2(log2(abs(fragment_unnamed_293 + fragment_unnamed_771)) * exp2(mad(fragment_unnamed_774 * fragment_unnamed_774, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_804 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_805 = fragment_unnamed_804.x;
				float fragment_unnamed_1093;
				float fragment_unnamed_1095;
				float fragment_unnamed_1097;
				if (((((fragment_unnamed_805 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_805 != 0u) ? 4294967295u : 0u)) & ((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u)) == 0u)
				{
					float fragment_unnamed_1094;
					float fragment_unnamed_1096;
					float fragment_unnamed_1098;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						uint fragment_unnamed_828 = fragment_unnamed_104 * 7u;
						float fragment_unnamed_829 = asfloat(1065353216u);
						float fragment_unnamed_859 = fragment_unnamed_766 * fragment_unnamed_765;
						float fragment_unnamed_860 = fragment_unnamed_767 * fragment_unnamed_766;
						float fragment_unnamed_861 = fragment_unnamed_767 * fragment_unnamed_767;
						float fragment_unnamed_862 = fragment_unnamed_765 * fragment_unnamed_767;
						float fragment_unnamed_897 = mad(fragment_unnamed_765, fragment_unnamed_765, (-0.0f) - (fragment_unnamed_766 * fragment_unnamed_766));
						uint fragment_unnamed_898 = fragment_unnamed_828 + 6u;
						fragment_unnamed_1094 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828 + 2u]), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_829)) + mad(fragment_uniform_buffer_4[fragment_unnamed_898].z, fragment_unnamed_897, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828 + 5u]), float4(fragment_unnamed_859, fragment_unnamed_860, fragment_unnamed_861, fragment_unnamed_862)));
						fragment_unnamed_1096 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828 + 1u]), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_829)) + mad(fragment_uniform_buffer_4[fragment_unnamed_898].y, fragment_unnamed_897, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828 + 4u]), float4(fragment_unnamed_859, fragment_unnamed_860, fragment_unnamed_861, fragment_unnamed_862)));
						fragment_unnamed_1098 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828]), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_829)) + mad(fragment_uniform_buffer_4[fragment_unnamed_898].x, fragment_unnamed_897, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_828 + 3u]), float4(fragment_unnamed_859, fragment_unnamed_860, fragment_unnamed_861, fragment_unnamed_862)));
					}
					else
					{
						bool fragment_unnamed_913 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_914 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_936 = fragment_unnamed_913 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_937 = fragment_unnamed_913 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_938 = fragment_unnamed_913 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_1042 = (asfloat(fragment_unnamed_914 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_938, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_936, fragment_unnamed_937 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_937)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_1043 = (asfloat(fragment_unnamed_914 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_938, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_936, fragment_unnamed_937 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_938)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_1056 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_914 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_938, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_936, fragment_unnamed_937 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_936)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_1083 = asfloat(1065353216u);
						fragment_unnamed_1094 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1056 + 0.5f, fragment_unnamed_1042 + 0.0f, fragment_unnamed_1043 + 0.0f), 0.0f)), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_1083));
						fragment_unnamed_1096 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1056 + 0.25f, fragment_unnamed_1042 + 0.0f, fragment_unnamed_1043 + 0.0f), 0.0f)), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_1083));
						fragment_unnamed_1098 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1056, fragment_unnamed_1042, fragment_unnamed_1043), 0.0f)), float4(fragment_unnamed_765, fragment_unnamed_766, fragment_unnamed_767, fragment_unnamed_1083));
					}
					fragment_unnamed_1093 = fragment_unnamed_1094;
					fragment_unnamed_1095 = fragment_unnamed_1096;
					fragment_unnamed_1097 = fragment_unnamed_1098;
				}
				else
				{
					fragment_unnamed_1093 = asfloat(0u);
					fragment_unnamed_1095 = asfloat(0u);
					fragment_unnamed_1097 = asfloat(0u);
				}
				float fragment_unnamed_1100 = mad((-0.0f) - fragment_unnamed_262, fragment_unnamed_292, 1.0f);
				float fragment_unnamed_1101 = fragment_unnamed_1100 * fragment_unnamed_762;
				float fragment_unnamed_1102 = fragment_unnamed_1100 * fragment_unnamed_763;
				float fragment_unnamed_1103 = fragment_unnamed_1100 * fragment_unnamed_764;
				float fragment_unnamed_1108 = mad(fragment_unnamed_322, fragment_unnamed_762 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1110 = mad(fragment_unnamed_322, fragment_unnamed_763 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1111 = mad(fragment_unnamed_322, fragment_unnamed_764 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1123 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_771), 0.984375f, 0.0078125f), mad(fragment_unnamed_774, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_1133 = clamp((max(fragment_unnamed_1111, max(fragment_unnamed_1110, fragment_unnamed_1108)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_1157 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_3[(fragment_unnamed_104 * 9u) + 8u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1162 = max(abs(fragment_unnamed_767), 0.0009765625f);
				float fragment_unnamed_1166 = (fragment_unnamed_767 >= 0.0f) ? fragment_unnamed_1162 : ((-0.0f) - fragment_unnamed_1162);
				float fragment_unnamed_1175 = 1.0f / max(dot(float3(abs(fragment_unnamed_765), abs(fragment_unnamed_766), abs(fragment_unnamed_1166)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1180 = clamp((-0.0f) - (fragment_unnamed_1175 * fragment_unnamed_1166), 0.0f, 1.0f);
				float fragment_unnamed_1183 = (-0.0f) - fragment_unnamed_1180;
				uint fragment_unnamed_1195 = uint(clamp(mad(mad(fragment_unnamed_765, fragment_unnamed_1175, ((fragment_unnamed_1175 * fragment_unnamed_765) >= 0.0f) ? fragment_unnamed_1180 : fragment_unnamed_1183), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1196 = uint(clamp(mad(mad(fragment_unnamed_766, fragment_unnamed_1175, ((fragment_unnamed_1175 * fragment_unnamed_766) >= 0.0f) ? fragment_unnamed_1180 : fragment_unnamed_1183), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1195 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1196 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1196 >> 8u) * 16u) + (fragment_unnamed_1195 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_1108)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_1110)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_1111)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_1249 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1250 = fragment_unnamed_1249 * mad(fragment_unnamed_1157 * ((fragment_unnamed_1123 * mad(fragment_unnamed_1133, mad((-0.0f) - fragment_unnamed_762, fragment_unnamed_1100, fragment_unnamed_1108), fragment_unnamed_1101)) * fragment_unnamed_1097), fragment_unnamed_293, mad(fragment_uniform_buffer_5[6u].x, fragment_unnamed_331.x, fragment_unnamed_664 * fragment_uniform_buffer_5[8u].x));
				float fragment_unnamed_1251 = fragment_unnamed_1249 * mad(fragment_unnamed_1157 * ((fragment_unnamed_1123 * mad(fragment_unnamed_1133, mad((-0.0f) - fragment_unnamed_763, fragment_unnamed_1100, fragment_unnamed_1110), fragment_unnamed_1102)) * fragment_unnamed_1095), fragment_unnamed_293, mad(fragment_uniform_buffer_5[6u].y, fragment_unnamed_331.y, fragment_unnamed_664 * fragment_uniform_buffer_5[8u].y));
				float fragment_unnamed_1252 = fragment_unnamed_1249 * mad(fragment_unnamed_1157 * ((fragment_unnamed_1123 * mad(fragment_unnamed_1133, mad((-0.0f) - fragment_unnamed_764, fragment_unnamed_1100, fragment_unnamed_1111), fragment_unnamed_1103)) * fragment_unnamed_1093), fragment_unnamed_293, mad(fragment_uniform_buffer_5[6u].z, fragment_unnamed_331.z, fragment_unnamed_664 * fragment_uniform_buffer_5[8u].z));
				bool fragment_unnamed_1265 = (((fragment_unnamed_1252 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1251 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1250 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1265 ? asfloat(1157627904u) : fragment_unnamed_1250;
				fragment_output_3.y = fragment_unnamed_1265 ? fragment_unnamed_293 : fragment_unnamed_1251;
				fragment_output_3.z = fragment_unnamed_1265 ? asfloat(1149239296u) : fragment_unnamed_1252;
				fragment_output_0.x = fragment_unnamed_1101;
				fragment_output_0.y = fragment_unnamed_1102;
				fragment_output_0.z = fragment_unnamed_1103;
				fragment_output_1.w = fragment_unnamed_774;
				fragment_output_2.w = 0.0f;
				fragment_output_3.w = 0.0f;
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

				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_0[113] = float4(fragment_uniform_buffer_0[113][0], fragment_uniform_buffer_0[113][1], fragment_uniform_buffer_0[113][2], asfloat(_ReflectionsMode));

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], _ProbeExposureScale, fragment_uniform_buffer_0[118][2], fragment_uniform_buffer_0[118][3]);

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], fragment_uniform_buffer_0[118][1], fragment_uniform_buffer_0[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_0[120] = float4(_IndirectDiffuseLightingMultiplier, fragment_uniform_buffer_0[120][1], fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[120] = float4(fragment_uniform_buffer_0[120][0], asfloat(_IndirectDiffuseLightingLayers), fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[210] = float4(fragment_uniform_buffer_0[210][0], fragment_uniform_buffer_0[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_0[210][3]);

				fragment_uniform_buffer_0[213] = float4(asfloat(_IndirectDiffuseMode), fragment_uniform_buffer_0[213][1], fragment_uniform_buffer_0[213][2], fragment_uniform_buffer_0[213][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_1[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_1[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_1[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_1[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_1[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_1[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_1[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_3[8][1], fragment_uniform_buffer_3[8][2], fragment_uniform_buffer_3[8][3]);
				fragment_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_3[17][1], fragment_uniform_buffer_3[17][2], fragment_uniform_buffer_3[17][3]);
				fragment_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_uniform_buffer_4[0] = float4(unity_Builtins2Array[0].unity_SHArArray[0], unity_Builtins2Array[0].unity_SHArArray[1], unity_Builtins2Array[0].unity_SHArArray[2], unity_Builtins2Array[0].unity_SHArArray[3]);
				fragment_uniform_buffer_4[1] = float4(unity_Builtins2Array[0].unity_SHAgArray[0], unity_Builtins2Array[0].unity_SHAgArray[1], unity_Builtins2Array[0].unity_SHAgArray[2], unity_Builtins2Array[0].unity_SHAgArray[3]);
				fragment_uniform_buffer_4[2] = float4(unity_Builtins2Array[0].unity_SHAbArray[0], unity_Builtins2Array[0].unity_SHAbArray[1], unity_Builtins2Array[0].unity_SHAbArray[2], unity_Builtins2Array[0].unity_SHAbArray[3]);
				fragment_uniform_buffer_4[3] = float4(unity_Builtins2Array[0].unity_SHBrArray[0], unity_Builtins2Array[0].unity_SHBrArray[1], unity_Builtins2Array[0].unity_SHBrArray[2], unity_Builtins2Array[0].unity_SHBrArray[3]);
				fragment_uniform_buffer_4[4] = float4(unity_Builtins2Array[0].unity_SHBgArray[0], unity_Builtins2Array[0].unity_SHBgArray[1], unity_Builtins2Array[0].unity_SHBgArray[2], unity_Builtins2Array[0].unity_SHBgArray[3]);
				fragment_uniform_buffer_4[5] = float4(unity_Builtins2Array[0].unity_SHBbArray[0], unity_Builtins2Array[0].unity_SHBbArray[1], unity_Builtins2Array[0].unity_SHBbArray[2], unity_Builtins2Array[0].unity_SHBbArray[3]);
				fragment_uniform_buffer_4[6] = float4(unity_Builtins2Array[0].unity_SHCArray[0], unity_Builtins2Array[0].unity_SHCArray[1], unity_Builtins2Array[0].unity_SHCArray[2], unity_Builtins2Array[0].unity_SHCArray[3]);
				fragment_uniform_buffer_4[7] = float4(unity_Builtins2Array[1].unity_SHArArray[0], unity_Builtins2Array[1].unity_SHArArray[1], unity_Builtins2Array[1].unity_SHArArray[2], unity_Builtins2Array[1].unity_SHArArray[3]);
				fragment_uniform_buffer_4[8] = float4(unity_Builtins2Array[1].unity_SHAgArray[0], unity_Builtins2Array[1].unity_SHAgArray[1], unity_Builtins2Array[1].unity_SHAgArray[2], unity_Builtins2Array[1].unity_SHAgArray[3]);
				fragment_uniform_buffer_4[9] = float4(unity_Builtins2Array[1].unity_SHAbArray[0], unity_Builtins2Array[1].unity_SHAbArray[1], unity_Builtins2Array[1].unity_SHAbArray[2], unity_Builtins2Array[1].unity_SHAbArray[3]);
				fragment_uniform_buffer_4[10] = float4(unity_Builtins2Array[1].unity_SHBrArray[0], unity_Builtins2Array[1].unity_SHBrArray[1], unity_Builtins2Array[1].unity_SHBrArray[2], unity_Builtins2Array[1].unity_SHBrArray[3]);
				fragment_uniform_buffer_4[11] = float4(unity_Builtins2Array[1].unity_SHBgArray[0], unity_Builtins2Array[1].unity_SHBgArray[1], unity_Builtins2Array[1].unity_SHBgArray[2], unity_Builtins2Array[1].unity_SHBgArray[3]);
				fragment_uniform_buffer_4[12] = float4(unity_Builtins2Array[1].unity_SHBbArray[0], unity_Builtins2Array[1].unity_SHBbArray[1], unity_Builtins2Array[1].unity_SHBbArray[2], unity_Builtins2Array[1].unity_SHBbArray[3]);
				fragment_uniform_buffer_4[13] = float4(unity_Builtins2Array[1].unity_SHCArray[0], unity_Builtins2Array[1].unity_SHCArray[1], unity_Builtins2Array[1].unity_SHCArray[2], unity_Builtins2Array[1].unity_SHCArray[3]);

				fragment_uniform_buffer_5[1] = float4(_Dissolve, fragment_uniform_buffer_5[1][1], fragment_uniform_buffer_5[1][2], fragment_uniform_buffer_5[1][3]);

				fragment_uniform_buffer_5[6] = float4(_Emission[0], _Emission[1], _Emission[2], _Emission[3]);

				fragment_uniform_buffer_5[7] = float4(_UseMaskMap, fragment_uniform_buffer_5[7][1], fragment_uniform_buffer_5[7][2], fragment_uniform_buffer_5[7][3]);

				fragment_uniform_buffer_5[8] = float4(_DissolveColor[0], _DissolveColor[1], _DissolveColor[2], _DissolveColor[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif
			#if (defined(DECALS_3RT) && defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float _GlobalMipBias;
			int _ReflectionsMode;
			float _ProbeExposureScale;
			float _ReplaceDiffuseForIndirect;
			float _IndirectDiffuseLightingMultiplier;
			int _IndirectDiffuseLightingLayers;
			int _EnableDecals;
			int _IndirectDiffuseMode;
			float4 unity_RenderingLayer;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float _Dissolve;
			float4 _Emission;
			float _UseMaskMap;
			float4 _DissolveColor;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[9];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _EmissionMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_EmissionMap;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;
			static float4 fragment_output_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
				float4 fragment_output_3 : SV_Target3;
			};

			void frag_main()
			{
				float fragment_unnamed_102 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_121 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_184 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_210 = asfloat(fragment_unnamed_184 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_217 = asfloat(fragment_unnamed_184 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_224 = asfloat(fragment_unnamed_184 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_228 = rsqrt(dot(float3(fragment_unnamed_210, fragment_unnamed_217, fragment_unnamed_224), float3(fragment_unnamed_210, fragment_unnamed_217, fragment_unnamed_224)));
				bool fragment_unnamed_236 = 0.0f != fragment_uniform_buffer_2[7u].x;
				float fragment_unnamed_240 = asfloat((fragment_unnamed_236 ? 4294967295u : 0u) & 1065353216u);
				float4 fragment_unnamed_254 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_257 = fragment_unnamed_254.x;
				float fragment_unnamed_258 = fragment_unnamed_254.y;
				float fragment_unnamed_259 = fragment_unnamed_254.z;
				float4 fragment_unnamed_268 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_270 = fragment_unnamed_268.x;
				float fragment_unnamed_271 = fragment_unnamed_268.y;
				float4 fragment_unnamed_281 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_287 = mad(fragment_unnamed_281.x * fragment_unnamed_281.w, 2.0f, -1.0f);
				float fragment_unnamed_290 = mad(fragment_unnamed_281.y, 2.0f, -1.0f);
				float fragment_unnamed_298 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_287, fragment_unnamed_290), float2(fragment_unnamed_287, fragment_unnamed_290)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_300 = fragment_unnamed_240 * fragment_unnamed_270;
				float4 fragment_unnamed_309 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_314 = asfloat(fragment_unnamed_236 ? 1065353216u : 1036831949u) * fragment_unnamed_268.w;
				float fragment_unnamed_325 = fragment_input_2.x * 15.0f;
				float fragment_unnamed_327 = fragment_input_2.y * 15.0f;
				float fragment_unnamed_328 = floor(fragment_unnamed_325);
				float fragment_unnamed_329 = floor(fragment_unnamed_327);
				float fragment_unnamed_330 = frac(fragment_unnamed_325);
				float fragment_unnamed_331 = frac(fragment_unnamed_327);
				float fragment_unnamed_335 = fragment_unnamed_328 * 289.0f;
				float fragment_unnamed_336 = fragment_unnamed_329 * 289.0f;
				float fragment_unnamed_337 = (-0.0f) - fragment_unnamed_335;
				float fragment_unnamed_338 = (-0.0f) - fragment_unnamed_336;
				float fragment_unnamed_359 = frac(fragment_unnamed_328 * asfloat((fragment_unnamed_335 >= fragment_unnamed_337) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_328 * 289.0f) >= fragment_unnamed_337) ? 1133543424u : 3281027072u);
				float fragment_unnamed_363 = fragment_unnamed_359 * mad(fragment_unnamed_359, 34.0f, 1.0f);
				float fragment_unnamed_364 = fragment_unnamed_363 * 289.0f;
				bool fragment_unnamed_366 = fragment_unnamed_364 >= ((-0.0f) - fragment_unnamed_364);
				float fragment_unnamed_373 = mad(asfloat(fragment_unnamed_366 ? 1133543424u : 3281027072u), frac(fragment_unnamed_363 * asfloat(fragment_unnamed_366 ? 996328615u : 3143812263u)), frac(fragment_unnamed_329 * asfloat((fragment_unnamed_336 >= fragment_unnamed_338) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_329 * 289.0f) >= fragment_unnamed_338) ? 1133543424u : 3281027072u));
				float fragment_unnamed_375 = fragment_unnamed_373 * mad(fragment_unnamed_373, 34.0f, 1.0f);
				float fragment_unnamed_376 = fragment_unnamed_375 * 289.0f;
				bool fragment_unnamed_378 = fragment_unnamed_376 >= ((-0.0f) - fragment_unnamed_376);
				float fragment_unnamed_388 = frac((frac(fragment_unnamed_375 * asfloat(fragment_unnamed_378 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_378 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_389 = mad(fragment_unnamed_388, 2.0f, -1.0f);
				float fragment_unnamed_394 = ((-0.0f) - floor(mad(fragment_unnamed_388, 2.0f, -0.5f))) + fragment_unnamed_389;
				float fragment_unnamed_396 = abs(fragment_unnamed_389) + (-0.5f);
				float fragment_unnamed_400 = rsqrt(dot(float2(fragment_unnamed_394, fragment_unnamed_396), float2(fragment_unnamed_394, fragment_unnamed_396)));
				float fragment_unnamed_403 = dot(float2(fragment_unnamed_400 * fragment_unnamed_394, fragment_unnamed_400 * fragment_unnamed_396), float2(fragment_unnamed_330, fragment_unnamed_331));
				float fragment_unnamed_406 = fragment_unnamed_328 + 0.0f;
				float fragment_unnamed_407 = fragment_unnamed_329 + 1.0f;
				float fragment_unnamed_408 = fragment_unnamed_328 + 1.0f;
				float fragment_unnamed_409 = fragment_unnamed_329 + 0.0f;
				float fragment_unnamed_410 = fragment_unnamed_406 * 289.0f;
				float fragment_unnamed_411 = fragment_unnamed_407 * 289.0f;
				float fragment_unnamed_412 = fragment_unnamed_408 * 289.0f;
				float fragment_unnamed_413 = fragment_unnamed_409 * 289.0f;
				bool fragment_unnamed_418 = fragment_unnamed_410 >= ((-0.0f) - fragment_unnamed_410);
				bool fragment_unnamed_419 = fragment_unnamed_411 >= ((-0.0f) - fragment_unnamed_411);
				bool fragment_unnamed_420 = fragment_unnamed_412 >= ((-0.0f) - fragment_unnamed_412);
				bool fragment_unnamed_421 = fragment_unnamed_413 >= ((-0.0f) - fragment_unnamed_413);
				float fragment_unnamed_434 = frac(fragment_unnamed_406 * asfloat(fragment_unnamed_418 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_418 ? 1133543424u : 3281027072u);
				float fragment_unnamed_437 = fragment_unnamed_434 * mad(fragment_unnamed_434, 34.0f, 1.0f);
				float fragment_unnamed_438 = fragment_unnamed_437 * 289.0f;
				bool fragment_unnamed_440 = fragment_unnamed_438 >= ((-0.0f) - fragment_unnamed_438);
				float fragment_unnamed_447 = mad(asfloat(fragment_unnamed_440 ? 1133543424u : 3281027072u), frac(fragment_unnamed_437 * asfloat(fragment_unnamed_440 ? 996328615u : 3143812263u)), frac(fragment_unnamed_407 * asfloat(fragment_unnamed_419 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_419 ? 1133543424u : 3281027072u));
				float fragment_unnamed_449 = fragment_unnamed_447 * mad(fragment_unnamed_447, 34.0f, 1.0f);
				float fragment_unnamed_450 = fragment_unnamed_449 * 289.0f;
				bool fragment_unnamed_452 = fragment_unnamed_450 >= ((-0.0f) - fragment_unnamed_450);
				float fragment_unnamed_461 = frac((frac(fragment_unnamed_449 * asfloat(fragment_unnamed_452 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_452 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_462 = mad(fragment_unnamed_461, 2.0f, -1.0f);
				float fragment_unnamed_466 = ((-0.0f) - floor(mad(fragment_unnamed_461, 2.0f, -0.5f))) + fragment_unnamed_462;
				float fragment_unnamed_468 = abs(fragment_unnamed_462) + (-0.5f);
				float fragment_unnamed_472 = rsqrt(dot(float2(fragment_unnamed_466, fragment_unnamed_468), float2(fragment_unnamed_466, fragment_unnamed_468)));
				float fragment_unnamed_494 = frac(fragment_unnamed_408 * asfloat(fragment_unnamed_420 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_420 ? 1133543424u : 3281027072u);
				float fragment_unnamed_497 = fragment_unnamed_494 * mad(fragment_unnamed_494, 34.0f, 1.0f);
				float fragment_unnamed_498 = fragment_unnamed_497 * 289.0f;
				bool fragment_unnamed_500 = fragment_unnamed_498 >= ((-0.0f) - fragment_unnamed_498);
				float fragment_unnamed_507 = mad(asfloat(fragment_unnamed_500 ? 1133543424u : 3281027072u), frac(fragment_unnamed_497 * asfloat(fragment_unnamed_500 ? 996328615u : 3143812263u)), frac(fragment_unnamed_409 * asfloat(fragment_unnamed_421 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_421 ? 1133543424u : 3281027072u));
				float fragment_unnamed_509 = fragment_unnamed_507 * mad(fragment_unnamed_507, 34.0f, 1.0f);
				float fragment_unnamed_510 = fragment_unnamed_509 * 289.0f;
				bool fragment_unnamed_512 = fragment_unnamed_510 >= ((-0.0f) - fragment_unnamed_510);
				float fragment_unnamed_521 = frac((frac(fragment_unnamed_509 * asfloat(fragment_unnamed_512 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_512 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_522 = mad(fragment_unnamed_521, 2.0f, -1.0f);
				float fragment_unnamed_526 = ((-0.0f) - floor(mad(fragment_unnamed_521, 2.0f, -0.5f))) + fragment_unnamed_522;
				float fragment_unnamed_528 = abs(fragment_unnamed_522) + (-0.5f);
				float fragment_unnamed_532 = rsqrt(dot(float2(fragment_unnamed_526, fragment_unnamed_528), float2(fragment_unnamed_526, fragment_unnamed_528)));
				float fragment_unnamed_535 = dot(float2(fragment_unnamed_532 * fragment_unnamed_526, fragment_unnamed_532 * fragment_unnamed_528), float2(fragment_unnamed_330 + (-1.0f), fragment_unnamed_331 + (-0.0f)));
				float fragment_unnamed_538 = fragment_unnamed_328 + 1.0f;
				float fragment_unnamed_539 = fragment_unnamed_329 + 1.0f;
				float fragment_unnamed_542 = fragment_unnamed_538 * 289.0f;
				float fragment_unnamed_543 = fragment_unnamed_539 * 289.0f;
				float fragment_unnamed_544 = (-0.0f) - fragment_unnamed_542;
				float fragment_unnamed_545 = (-0.0f) - fragment_unnamed_543;
				float fragment_unnamed_562 = frac(fragment_unnamed_538 * asfloat((fragment_unnamed_542 >= fragment_unnamed_544) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_538 * 289.0f) >= fragment_unnamed_544) ? 1133543424u : 3281027072u);
				float fragment_unnamed_565 = fragment_unnamed_562 * mad(fragment_unnamed_562, 34.0f, 1.0f);
				float fragment_unnamed_566 = fragment_unnamed_565 * 289.0f;
				bool fragment_unnamed_568 = fragment_unnamed_566 >= ((-0.0f) - fragment_unnamed_566);
				float fragment_unnamed_575 = mad(asfloat(fragment_unnamed_568 ? 1133543424u : 3281027072u), frac(fragment_unnamed_565 * asfloat(fragment_unnamed_568 ? 996328615u : 3143812263u)), frac(fragment_unnamed_539 * asfloat((fragment_unnamed_543 >= fragment_unnamed_545) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_539 * 289.0f) >= fragment_unnamed_545) ? 1133543424u : 3281027072u));
				float fragment_unnamed_577 = fragment_unnamed_575 * mad(fragment_unnamed_575, 34.0f, 1.0f);
				float fragment_unnamed_578 = fragment_unnamed_577 * 289.0f;
				bool fragment_unnamed_580 = fragment_unnamed_578 >= ((-0.0f) - fragment_unnamed_578);
				float fragment_unnamed_589 = frac((frac(asfloat(fragment_unnamed_580 ? 996328615u : 3143812263u) * fragment_unnamed_577) * asfloat(fragment_unnamed_580 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_590 = mad(fragment_unnamed_589, 2.0f, -1.0f);
				float fragment_unnamed_594 = ((-0.0f) - floor(mad(fragment_unnamed_589, 2.0f, -0.5f))) + fragment_unnamed_590;
				float fragment_unnamed_596 = abs(fragment_unnamed_590) + (-0.5f);
				float fragment_unnamed_600 = rsqrt(dot(float2(fragment_unnamed_594, fragment_unnamed_596), float2(fragment_unnamed_594, fragment_unnamed_596)));
				float fragment_unnamed_620 = mad(fragment_unnamed_331, mad(fragment_unnamed_331, 6.0f, -15.0f), 10.0f) * (fragment_unnamed_331 * (fragment_unnamed_331 * fragment_unnamed_331));
				float fragment_unnamed_623 = mad(fragment_unnamed_620, ((-0.0f) - fragment_unnamed_403) + dot(float2(fragment_unnamed_472 * fragment_unnamed_466, fragment_unnamed_472 * fragment_unnamed_468), float2(fragment_unnamed_330 + (-0.0f), fragment_unnamed_331 + (-1.0f))), fragment_unnamed_403);
				float fragment_unnamed_642 = exp2(log2(max(((mad(fragment_uniform_buffer_2[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f) + ((-0.0f) - (mad(mad(fragment_unnamed_330, mad(fragment_unnamed_330, 6.0f, -15.0f), 10.0f) * (fragment_unnamed_330 * (fragment_unnamed_330 * fragment_unnamed_330)), ((-0.0f) - fragment_unnamed_623) + mad(fragment_unnamed_620, ((-0.0f) - fragment_unnamed_535) + dot(float2(fragment_unnamed_600 * fragment_unnamed_594, fragment_unnamed_600 * fragment_unnamed_596), float2(fragment_unnamed_330 + (-1.0f), fragment_unnamed_331 + (-1.0f))), fragment_unnamed_535), fragment_unnamed_623) + 0.5f))) + 0.430000007152557373046875f) * 2.3255813121795654296875f, 0.0f)) * 20.0f);
				float fragment_unnamed_667 = mad(fragment_unnamed_298, fragment_unnamed_102 * fragment_input_7.x, mad(fragment_unnamed_287, fragment_unnamed_102 * fragment_input_1.x, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_290));
				float fragment_unnamed_668 = mad(fragment_unnamed_298, fragment_unnamed_102 * fragment_input_7.y, mad(fragment_unnamed_287, fragment_unnamed_102 * fragment_input_1.y, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_290));
				float fragment_unnamed_669 = mad(fragment_unnamed_298, fragment_unnamed_102 * fragment_input_7.z, mad(fragment_unnamed_287, fragment_unnamed_102 * fragment_input_1.z, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_290));
				float fragment_unnamed_674 = rsqrt(max(dot(float3(fragment_unnamed_667, fragment_unnamed_668, fragment_unnamed_669), float3(fragment_unnamed_667, fragment_unnamed_668, fragment_unnamed_669)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_675 = fragment_unnamed_667 * fragment_unnamed_674;
				float fragment_unnamed_676 = fragment_unnamed_668 * fragment_unnamed_674;
				float fragment_unnamed_677 = fragment_unnamed_669 * fragment_unnamed_674;
				float fragment_unnamed_739;
				float fragment_unnamed_740;
				float fragment_unnamed_741;
				float fragment_unnamed_742;
				float fragment_unnamed_743;
				float fragment_unnamed_744;
				float fragment_unnamed_745;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_688 = uint(gl_FragCoord.x);
					uint fragment_unnamed_689 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_690 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_688, fragment_unnamed_689, 0u), 0u));
					float fragment_unnamed_696 = fragment_unnamed_690.w;
					float4 fragment_unnamed_697 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_688, fragment_unnamed_689, 0u), 0u));
					float fragment_unnamed_702 = fragment_unnamed_697.w;
					float4 fragment_unnamed_703 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_688, fragment_unnamed_689, 0u), 0u));
					bool fragment_unnamed_711 = fragment_unnamed_702 < 1.0f;
					float fragment_unnamed_712 = mad(fragment_unnamed_675, fragment_unnamed_702, mad(fragment_unnamed_697.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_713 = mad(fragment_unnamed_676, fragment_unnamed_702, mad(fragment_unnamed_697.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_714 = mad(fragment_unnamed_677, fragment_unnamed_702, mad(fragment_unnamed_697.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_719 = rsqrt(max(dot(float3(fragment_unnamed_712, fragment_unnamed_713, fragment_unnamed_714), float3(fragment_unnamed_712, fragment_unnamed_713, fragment_unnamed_714)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_739 = mad(fragment_unnamed_257, fragment_unnamed_696, fragment_unnamed_690.x);
					fragment_unnamed_740 = mad(fragment_unnamed_258, fragment_unnamed_696, fragment_unnamed_690.y);
					fragment_unnamed_741 = mad(fragment_unnamed_259, fragment_unnamed_696, fragment_unnamed_690.z);
					fragment_unnamed_742 = asfloat(fragment_unnamed_711 ? asuint(fragment_unnamed_714 * fragment_unnamed_719) : asuint(fragment_unnamed_677));
					fragment_unnamed_743 = asfloat(fragment_unnamed_711 ? asuint(fragment_unnamed_713 * fragment_unnamed_719) : asuint(fragment_unnamed_676));
					fragment_unnamed_744 = asfloat(fragment_unnamed_711 ? asuint(fragment_unnamed_712 * fragment_unnamed_719) : asuint(fragment_unnamed_675));
					fragment_unnamed_745 = mad(fragment_unnamed_314, fragment_unnamed_703.w, fragment_unnamed_703.z);
				}
				else
				{
					fragment_unnamed_739 = fragment_unnamed_257;
					fragment_unnamed_740 = fragment_unnamed_258;
					fragment_unnamed_741 = fragment_unnamed_259;
					fragment_unnamed_742 = fragment_unnamed_677;
					fragment_unnamed_743 = fragment_unnamed_676;
					fragment_unnamed_744 = fragment_unnamed_675;
					fragment_unnamed_745 = fragment_unnamed_314;
				}
				float fragment_unnamed_749 = max(dot(float3(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742), float3(fragment_unnamed_228 * fragment_unnamed_210, fragment_unnamed_228 * fragment_unnamed_217, fragment_unnamed_228 * fragment_unnamed_224)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_752 = ((-0.0f) - fragment_unnamed_745) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_271 + exp2(log2(abs(fragment_unnamed_271 + fragment_unnamed_749)) * exp2(mad(fragment_unnamed_752 * fragment_unnamed_752, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_781 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_782 = fragment_unnamed_781.x;
				float fragment_unnamed_1067;
				float fragment_unnamed_1069;
				float fragment_unnamed_1071;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_782 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_782 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_1068;
					float fragment_unnamed_1070;
					float fragment_unnamed_1072;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_805 = asfloat(1065353216u);
						float fragment_unnamed_835 = fragment_unnamed_743 * fragment_unnamed_744;
						float fragment_unnamed_836 = fragment_unnamed_742 * fragment_unnamed_743;
						float fragment_unnamed_837 = fragment_unnamed_742 * fragment_unnamed_742;
						float fragment_unnamed_838 = fragment_unnamed_744 * fragment_unnamed_742;
						float fragment_unnamed_871 = mad(fragment_unnamed_744, fragment_unnamed_744, (-0.0f) - (fragment_unnamed_743 * fragment_unnamed_743));
						fragment_unnamed_1068 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_805)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_871, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_835, fragment_unnamed_836, fragment_unnamed_837, fragment_unnamed_838)));
						fragment_unnamed_1070 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_805)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_871, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_835, fragment_unnamed_836, fragment_unnamed_837, fragment_unnamed_838)));
						fragment_unnamed_1072 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_805)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_871, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_835, fragment_unnamed_836, fragment_unnamed_837, fragment_unnamed_838)));
					}
					else
					{
						bool fragment_unnamed_887 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_888 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_910 = fragment_unnamed_887 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_911 = fragment_unnamed_887 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_912 = fragment_unnamed_887 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_1016 = (asfloat(fragment_unnamed_888 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_912, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_910, fragment_unnamed_911 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_911)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_1017 = (asfloat(fragment_unnamed_888 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_912, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_910, fragment_unnamed_911 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_912)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_1030 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_888 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_912, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_910, fragment_unnamed_911 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_910)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_1057 = asfloat(1065353216u);
						fragment_unnamed_1068 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1030 + 0.5f, fragment_unnamed_1016 + 0.0f, fragment_unnamed_1017 + 0.0f), 0.0f)), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_1057));
						fragment_unnamed_1070 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1030 + 0.25f, fragment_unnamed_1016 + 0.0f, fragment_unnamed_1017 + 0.0f), 0.0f)), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_1057));
						fragment_unnamed_1072 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1030, fragment_unnamed_1016, fragment_unnamed_1017), 0.0f)), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_1057));
					}
					fragment_unnamed_1067 = fragment_unnamed_1068;
					fragment_unnamed_1069 = fragment_unnamed_1070;
					fragment_unnamed_1071 = fragment_unnamed_1072;
				}
				else
				{
					fragment_unnamed_1067 = asfloat(0u);
					fragment_unnamed_1069 = asfloat(0u);
					fragment_unnamed_1071 = asfloat(0u);
				}
				float fragment_unnamed_1074 = mad((-0.0f) - fragment_unnamed_240, fragment_unnamed_270, 1.0f);
				float fragment_unnamed_1075 = fragment_unnamed_1074 * fragment_unnamed_739;
				float fragment_unnamed_1076 = fragment_unnamed_1074 * fragment_unnamed_740;
				float fragment_unnamed_1077 = fragment_unnamed_1074 * fragment_unnamed_741;
				float fragment_unnamed_1082 = mad(fragment_unnamed_300, fragment_unnamed_739 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1084 = mad(fragment_unnamed_300, fragment_unnamed_740 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1085 = mad(fragment_unnamed_300, fragment_unnamed_741 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1097 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_749), 0.984375f, 0.0078125f), mad(fragment_unnamed_752, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_1107 = clamp((max(fragment_unnamed_1085, max(fragment_unnamed_1084, fragment_unnamed_1082)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_1131 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1136 = max(abs(fragment_unnamed_742), 0.0009765625f);
				float fragment_unnamed_1140 = (fragment_unnamed_742 >= 0.0f) ? fragment_unnamed_1136 : ((-0.0f) - fragment_unnamed_1136);
				float fragment_unnamed_1149 = 1.0f / max(dot(float3(abs(fragment_unnamed_744), abs(fragment_unnamed_743), abs(fragment_unnamed_1140)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1154 = clamp((-0.0f) - (fragment_unnamed_1149 * fragment_unnamed_1140), 0.0f, 1.0f);
				float fragment_unnamed_1157 = (-0.0f) - fragment_unnamed_1154;
				uint fragment_unnamed_1169 = uint(clamp(mad(mad(fragment_unnamed_744, fragment_unnamed_1149, ((fragment_unnamed_1149 * fragment_unnamed_744) >= 0.0f) ? fragment_unnamed_1154 : fragment_unnamed_1157), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1170 = uint(clamp(mad(mad(fragment_unnamed_743, fragment_unnamed_1149, ((fragment_unnamed_1149 * fragment_unnamed_743) >= 0.0f) ? fragment_unnamed_1154 : fragment_unnamed_1157), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1169 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1170 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1170 >> 8u) * 16u) + (fragment_unnamed_1169 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_1082)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_1084)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_1085)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_1222 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1223 = fragment_unnamed_1222 * mad(fragment_unnamed_1131 * ((fragment_unnamed_1097 * mad(fragment_unnamed_1107, mad((-0.0f) - fragment_unnamed_739, fragment_unnamed_1074, fragment_unnamed_1082), fragment_unnamed_1075)) * fragment_unnamed_1071), fragment_unnamed_271, mad(fragment_uniform_buffer_2[6u].x, fragment_unnamed_309.x, fragment_unnamed_642 * fragment_uniform_buffer_2[8u].x));
				float fragment_unnamed_1224 = fragment_unnamed_1222 * mad(fragment_unnamed_1131 * ((fragment_unnamed_1097 * mad(fragment_unnamed_1107, mad((-0.0f) - fragment_unnamed_740, fragment_unnamed_1074, fragment_unnamed_1084), fragment_unnamed_1076)) * fragment_unnamed_1069), fragment_unnamed_271, mad(fragment_uniform_buffer_2[6u].y, fragment_unnamed_309.y, fragment_unnamed_642 * fragment_uniform_buffer_2[8u].y));
				float fragment_unnamed_1225 = fragment_unnamed_1222 * mad(fragment_unnamed_1131 * ((fragment_unnamed_1097 * mad(fragment_unnamed_1107, mad((-0.0f) - fragment_unnamed_741, fragment_unnamed_1074, fragment_unnamed_1085), fragment_unnamed_1077)) * fragment_unnamed_1067), fragment_unnamed_271, mad(fragment_uniform_buffer_2[6u].z, fragment_unnamed_309.z, fragment_unnamed_642 * fragment_uniform_buffer_2[8u].z));
				bool fragment_unnamed_1238 = (((fragment_unnamed_1225 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1224 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1223 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1238 ? asfloat(1157627904u) : fragment_unnamed_1223;
				fragment_output_3.y = fragment_unnamed_1238 ? fragment_unnamed_271 : fragment_unnamed_1224;
				fragment_output_3.z = fragment_unnamed_1238 ? asfloat(1149239296u) : fragment_unnamed_1225;
				fragment_output_0.x = fragment_unnamed_1075;
				fragment_output_0.y = fragment_unnamed_1076;
				fragment_output_0.z = fragment_unnamed_1077;
				fragment_output_1.w = fragment_unnamed_752;
				fragment_output_2.w = 0.0f;
				fragment_output_3.w = 0.0f;
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

				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_0[113] = float4(fragment_uniform_buffer_0[113][0], fragment_uniform_buffer_0[113][1], fragment_uniform_buffer_0[113][2], asfloat(_ReflectionsMode));

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], _ProbeExposureScale, fragment_uniform_buffer_0[118][2], fragment_uniform_buffer_0[118][3]);

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], fragment_uniform_buffer_0[118][1], fragment_uniform_buffer_0[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_0[120] = float4(_IndirectDiffuseLightingMultiplier, fragment_uniform_buffer_0[120][1], fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[120] = float4(fragment_uniform_buffer_0[120][0], asfloat(_IndirectDiffuseLightingLayers), fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[210] = float4(fragment_uniform_buffer_0[210][0], fragment_uniform_buffer_0[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_0[210][3]);

				fragment_uniform_buffer_0[213] = float4(asfloat(_IndirectDiffuseMode), fragment_uniform_buffer_0[213][1], fragment_uniform_buffer_0[213][2], fragment_uniform_buffer_0[213][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_1[13] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_1[14] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_1[15] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_1[16] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				fragment_uniform_buffer_1[17] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				fragment_uniform_buffer_1[18] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				fragment_uniform_buffer_1[19] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				fragment_uniform_buffer_2[1] = float4(_Dissolve, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[6] = float4(_Emission[0], _Emission[1], _Emission[2], _Emission[3]);

				fragment_uniform_buffer_2[7] = float4(_UseMaskMap, fragment_uniform_buffer_2[7][1], fragment_uniform_buffer_2[7][2], fragment_uniform_buffer_2[7][3]);

				fragment_uniform_buffer_2[8] = float4(_DissolveColor[0], _DissolveColor[1], _DissolveColor[2], _DissolveColor[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif
			#if (defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float _GlobalMipBias;
			int _ReflectionsMode;
			float _ProbeExposureScale;
			float _ReplaceDiffuseForIndirect;
			float _IndirectDiffuseLightingMultiplier;
			int _IndirectDiffuseLightingLayers;
			int _EnableDecals;
			int _IndirectDiffuseMode;
			float4 unity_RenderingLayer;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float _Dissolve;
			float4 _Emission;
			float _UseMaskMap;
			float4 _DissolveColor;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[9];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _EmissionMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_EmissionMap;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;
			static float4 fragment_output_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float4 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float3 fragment_input_7 : INTERP6; // INTERP_6
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
				float4 fragment_output_3 : SV_Target3;
			};

			void frag_main()
			{
				float fragment_unnamed_102 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_121 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_184 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_210 = asfloat(fragment_unnamed_184 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_217 = asfloat(fragment_unnamed_184 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_224 = asfloat(fragment_unnamed_184 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_228 = rsqrt(dot(float3(fragment_unnamed_210, fragment_unnamed_217, fragment_unnamed_224), float3(fragment_unnamed_210, fragment_unnamed_217, fragment_unnamed_224)));
				bool fragment_unnamed_236 = 0.0f != fragment_uniform_buffer_2[7u].x;
				float fragment_unnamed_240 = asfloat((fragment_unnamed_236 ? 4294967295u : 0u) & 1065353216u);
				float4 fragment_unnamed_254 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_257 = fragment_unnamed_254.x;
				float fragment_unnamed_258 = fragment_unnamed_254.y;
				float fragment_unnamed_259 = fragment_unnamed_254.z;
				float4 fragment_unnamed_268 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_270 = fragment_unnamed_268.x;
				float fragment_unnamed_271 = fragment_unnamed_268.y;
				float4 fragment_unnamed_281 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_287 = mad(fragment_unnamed_281.x * fragment_unnamed_281.w, 2.0f, -1.0f);
				float fragment_unnamed_290 = mad(fragment_unnamed_281.y, 2.0f, -1.0f);
				float fragment_unnamed_298 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_287, fragment_unnamed_290), float2(fragment_unnamed_287, fragment_unnamed_290)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_300 = fragment_unnamed_240 * fragment_unnamed_270;
				float4 fragment_unnamed_309 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_314 = asfloat(fragment_unnamed_236 ? 1065353216u : 1036831949u) * fragment_unnamed_268.w;
				float fragment_unnamed_325 = fragment_input_2.x * 15.0f;
				float fragment_unnamed_327 = fragment_input_2.y * 15.0f;
				float fragment_unnamed_328 = floor(fragment_unnamed_325);
				float fragment_unnamed_329 = floor(fragment_unnamed_327);
				float fragment_unnamed_330 = frac(fragment_unnamed_325);
				float fragment_unnamed_331 = frac(fragment_unnamed_327);
				float fragment_unnamed_335 = fragment_unnamed_328 * 289.0f;
				float fragment_unnamed_336 = fragment_unnamed_329 * 289.0f;
				float fragment_unnamed_337 = (-0.0f) - fragment_unnamed_335;
				float fragment_unnamed_338 = (-0.0f) - fragment_unnamed_336;
				float fragment_unnamed_359 = frac(fragment_unnamed_328 * asfloat((fragment_unnamed_335 >= fragment_unnamed_337) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_328 * 289.0f) >= fragment_unnamed_337) ? 1133543424u : 3281027072u);
				float fragment_unnamed_363 = fragment_unnamed_359 * mad(fragment_unnamed_359, 34.0f, 1.0f);
				float fragment_unnamed_364 = fragment_unnamed_363 * 289.0f;
				bool fragment_unnamed_366 = fragment_unnamed_364 >= ((-0.0f) - fragment_unnamed_364);
				float fragment_unnamed_373 = mad(asfloat(fragment_unnamed_366 ? 1133543424u : 3281027072u), frac(fragment_unnamed_363 * asfloat(fragment_unnamed_366 ? 996328615u : 3143812263u)), frac(fragment_unnamed_329 * asfloat((fragment_unnamed_336 >= fragment_unnamed_338) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_329 * 289.0f) >= fragment_unnamed_338) ? 1133543424u : 3281027072u));
				float fragment_unnamed_375 = fragment_unnamed_373 * mad(fragment_unnamed_373, 34.0f, 1.0f);
				float fragment_unnamed_376 = fragment_unnamed_375 * 289.0f;
				bool fragment_unnamed_378 = fragment_unnamed_376 >= ((-0.0f) - fragment_unnamed_376);
				float fragment_unnamed_388 = frac((frac(fragment_unnamed_375 * asfloat(fragment_unnamed_378 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_378 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_389 = mad(fragment_unnamed_388, 2.0f, -1.0f);
				float fragment_unnamed_394 = ((-0.0f) - floor(mad(fragment_unnamed_388, 2.0f, -0.5f))) + fragment_unnamed_389;
				float fragment_unnamed_396 = abs(fragment_unnamed_389) + (-0.5f);
				float fragment_unnamed_400 = rsqrt(dot(float2(fragment_unnamed_394, fragment_unnamed_396), float2(fragment_unnamed_394, fragment_unnamed_396)));
				float fragment_unnamed_403 = dot(float2(fragment_unnamed_400 * fragment_unnamed_394, fragment_unnamed_400 * fragment_unnamed_396), float2(fragment_unnamed_330, fragment_unnamed_331));
				float fragment_unnamed_406 = fragment_unnamed_328 + 0.0f;
				float fragment_unnamed_407 = fragment_unnamed_329 + 1.0f;
				float fragment_unnamed_408 = fragment_unnamed_328 + 1.0f;
				float fragment_unnamed_409 = fragment_unnamed_329 + 0.0f;
				float fragment_unnamed_410 = fragment_unnamed_406 * 289.0f;
				float fragment_unnamed_411 = fragment_unnamed_407 * 289.0f;
				float fragment_unnamed_412 = fragment_unnamed_408 * 289.0f;
				float fragment_unnamed_413 = fragment_unnamed_409 * 289.0f;
				bool fragment_unnamed_418 = fragment_unnamed_410 >= ((-0.0f) - fragment_unnamed_410);
				bool fragment_unnamed_419 = fragment_unnamed_411 >= ((-0.0f) - fragment_unnamed_411);
				bool fragment_unnamed_420 = fragment_unnamed_412 >= ((-0.0f) - fragment_unnamed_412);
				bool fragment_unnamed_421 = fragment_unnamed_413 >= ((-0.0f) - fragment_unnamed_413);
				float fragment_unnamed_434 = frac(fragment_unnamed_406 * asfloat(fragment_unnamed_418 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_418 ? 1133543424u : 3281027072u);
				float fragment_unnamed_437 = fragment_unnamed_434 * mad(fragment_unnamed_434, 34.0f, 1.0f);
				float fragment_unnamed_438 = fragment_unnamed_437 * 289.0f;
				bool fragment_unnamed_440 = fragment_unnamed_438 >= ((-0.0f) - fragment_unnamed_438);
				float fragment_unnamed_447 = mad(asfloat(fragment_unnamed_440 ? 1133543424u : 3281027072u), frac(fragment_unnamed_437 * asfloat(fragment_unnamed_440 ? 996328615u : 3143812263u)), frac(fragment_unnamed_407 * asfloat(fragment_unnamed_419 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_419 ? 1133543424u : 3281027072u));
				float fragment_unnamed_449 = fragment_unnamed_447 * mad(fragment_unnamed_447, 34.0f, 1.0f);
				float fragment_unnamed_450 = fragment_unnamed_449 * 289.0f;
				bool fragment_unnamed_452 = fragment_unnamed_450 >= ((-0.0f) - fragment_unnamed_450);
				float fragment_unnamed_461 = frac((frac(fragment_unnamed_449 * asfloat(fragment_unnamed_452 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_452 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_462 = mad(fragment_unnamed_461, 2.0f, -1.0f);
				float fragment_unnamed_466 = ((-0.0f) - floor(mad(fragment_unnamed_461, 2.0f, -0.5f))) + fragment_unnamed_462;
				float fragment_unnamed_468 = abs(fragment_unnamed_462) + (-0.5f);
				float fragment_unnamed_472 = rsqrt(dot(float2(fragment_unnamed_466, fragment_unnamed_468), float2(fragment_unnamed_466, fragment_unnamed_468)));
				float fragment_unnamed_494 = frac(fragment_unnamed_408 * asfloat(fragment_unnamed_420 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_420 ? 1133543424u : 3281027072u);
				float fragment_unnamed_497 = fragment_unnamed_494 * mad(fragment_unnamed_494, 34.0f, 1.0f);
				float fragment_unnamed_498 = fragment_unnamed_497 * 289.0f;
				bool fragment_unnamed_500 = fragment_unnamed_498 >= ((-0.0f) - fragment_unnamed_498);
				float fragment_unnamed_507 = mad(asfloat(fragment_unnamed_500 ? 1133543424u : 3281027072u), frac(fragment_unnamed_497 * asfloat(fragment_unnamed_500 ? 996328615u : 3143812263u)), frac(fragment_unnamed_409 * asfloat(fragment_unnamed_421 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_421 ? 1133543424u : 3281027072u));
				float fragment_unnamed_509 = fragment_unnamed_507 * mad(fragment_unnamed_507, 34.0f, 1.0f);
				float fragment_unnamed_510 = fragment_unnamed_509 * 289.0f;
				bool fragment_unnamed_512 = fragment_unnamed_510 >= ((-0.0f) - fragment_unnamed_510);
				float fragment_unnamed_521 = frac((frac(fragment_unnamed_509 * asfloat(fragment_unnamed_512 ? 996328615u : 3143812263u)) * asfloat(fragment_unnamed_512 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_522 = mad(fragment_unnamed_521, 2.0f, -1.0f);
				float fragment_unnamed_526 = ((-0.0f) - floor(mad(fragment_unnamed_521, 2.0f, -0.5f))) + fragment_unnamed_522;
				float fragment_unnamed_528 = abs(fragment_unnamed_522) + (-0.5f);
				float fragment_unnamed_532 = rsqrt(dot(float2(fragment_unnamed_526, fragment_unnamed_528), float2(fragment_unnamed_526, fragment_unnamed_528)));
				float fragment_unnamed_535 = dot(float2(fragment_unnamed_532 * fragment_unnamed_526, fragment_unnamed_532 * fragment_unnamed_528), float2(fragment_unnamed_330 + (-1.0f), fragment_unnamed_331 + (-0.0f)));
				float fragment_unnamed_538 = fragment_unnamed_328 + 1.0f;
				float fragment_unnamed_539 = fragment_unnamed_329 + 1.0f;
				float fragment_unnamed_542 = fragment_unnamed_538 * 289.0f;
				float fragment_unnamed_543 = fragment_unnamed_539 * 289.0f;
				float fragment_unnamed_544 = (-0.0f) - fragment_unnamed_542;
				float fragment_unnamed_545 = (-0.0f) - fragment_unnamed_543;
				float fragment_unnamed_562 = frac(fragment_unnamed_538 * asfloat((fragment_unnamed_542 >= fragment_unnamed_544) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_538 * 289.0f) >= fragment_unnamed_544) ? 1133543424u : 3281027072u);
				float fragment_unnamed_565 = fragment_unnamed_562 * mad(fragment_unnamed_562, 34.0f, 1.0f);
				float fragment_unnamed_566 = fragment_unnamed_565 * 289.0f;
				bool fragment_unnamed_568 = fragment_unnamed_566 >= ((-0.0f) - fragment_unnamed_566);
				float fragment_unnamed_575 = mad(asfloat(fragment_unnamed_568 ? 1133543424u : 3281027072u), frac(fragment_unnamed_565 * asfloat(fragment_unnamed_568 ? 996328615u : 3143812263u)), frac(fragment_unnamed_539 * asfloat((fragment_unnamed_543 >= fragment_unnamed_545) ? 996328615u : 3143812263u)) * asfloat(((fragment_unnamed_539 * 289.0f) >= fragment_unnamed_545) ? 1133543424u : 3281027072u));
				float fragment_unnamed_577 = fragment_unnamed_575 * mad(fragment_unnamed_575, 34.0f, 1.0f);
				float fragment_unnamed_578 = fragment_unnamed_577 * 289.0f;
				bool fragment_unnamed_580 = fragment_unnamed_578 >= ((-0.0f) - fragment_unnamed_578);
				float fragment_unnamed_589 = frac((frac(asfloat(fragment_unnamed_580 ? 996328615u : 3143812263u) * fragment_unnamed_577) * asfloat(fragment_unnamed_580 ? 1133543424u : 3281027072u)) * 0.024390242993831634521484375f);
				float fragment_unnamed_590 = mad(fragment_unnamed_589, 2.0f, -1.0f);
				float fragment_unnamed_594 = ((-0.0f) - floor(mad(fragment_unnamed_589, 2.0f, -0.5f))) + fragment_unnamed_590;
				float fragment_unnamed_596 = abs(fragment_unnamed_590) + (-0.5f);
				float fragment_unnamed_600 = rsqrt(dot(float2(fragment_unnamed_594, fragment_unnamed_596), float2(fragment_unnamed_594, fragment_unnamed_596)));
				float fragment_unnamed_620 = mad(fragment_unnamed_331, mad(fragment_unnamed_331, 6.0f, -15.0f), 10.0f) * (fragment_unnamed_331 * (fragment_unnamed_331 * fragment_unnamed_331));
				float fragment_unnamed_623 = mad(fragment_unnamed_620, ((-0.0f) - fragment_unnamed_403) + dot(float2(fragment_unnamed_472 * fragment_unnamed_466, fragment_unnamed_472 * fragment_unnamed_468), float2(fragment_unnamed_330 + (-0.0f), fragment_unnamed_331 + (-1.0f))), fragment_unnamed_403);
				float fragment_unnamed_642 = exp2(log2(max(((mad(fragment_uniform_buffer_2[1u].x, 1.519999980926513671875f, -0.4000000059604644775390625f) + ((-0.0f) - (mad(mad(fragment_unnamed_330, mad(fragment_unnamed_330, 6.0f, -15.0f), 10.0f) * (fragment_unnamed_330 * (fragment_unnamed_330 * fragment_unnamed_330)), ((-0.0f) - fragment_unnamed_623) + mad(fragment_unnamed_620, ((-0.0f) - fragment_unnamed_535) + dot(float2(fragment_unnamed_600 * fragment_unnamed_594, fragment_unnamed_600 * fragment_unnamed_596), float2(fragment_unnamed_330 + (-1.0f), fragment_unnamed_331 + (-1.0f))), fragment_unnamed_535), fragment_unnamed_623) + 0.5f))) + 0.430000007152557373046875f) * 2.3255813121795654296875f, 0.0f)) * 20.0f);
				float fragment_unnamed_667 = mad(fragment_unnamed_298, fragment_unnamed_102 * fragment_input_7.x, mad(fragment_unnamed_287, fragment_unnamed_102 * fragment_input_1.x, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_290));
				float fragment_unnamed_668 = mad(fragment_unnamed_298, fragment_unnamed_102 * fragment_input_7.y, mad(fragment_unnamed_287, fragment_unnamed_102 * fragment_input_1.y, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_290));
				float fragment_unnamed_669 = mad(fragment_unnamed_298, fragment_unnamed_102 * fragment_input_7.z, mad(fragment_unnamed_287, fragment_unnamed_102 * fragment_input_1.z, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_290));
				float fragment_unnamed_674 = rsqrt(max(dot(float3(fragment_unnamed_667, fragment_unnamed_668, fragment_unnamed_669), float3(fragment_unnamed_667, fragment_unnamed_668, fragment_unnamed_669)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_675 = fragment_unnamed_667 * fragment_unnamed_674;
				float fragment_unnamed_676 = fragment_unnamed_668 * fragment_unnamed_674;
				float fragment_unnamed_677 = fragment_unnamed_669 * fragment_unnamed_674;
				float fragment_unnamed_739;
				float fragment_unnamed_740;
				float fragment_unnamed_741;
				float fragment_unnamed_742;
				float fragment_unnamed_743;
				float fragment_unnamed_744;
				float fragment_unnamed_745;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_688 = uint(gl_FragCoord.x);
					uint fragment_unnamed_689 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_690 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_688, fragment_unnamed_689, 0u), 0u));
					float fragment_unnamed_696 = fragment_unnamed_690.w;
					float4 fragment_unnamed_697 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_688, fragment_unnamed_689, 0u), 0u));
					float fragment_unnamed_702 = fragment_unnamed_697.w;
					float4 fragment_unnamed_703 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_688, fragment_unnamed_689, 0u), 0u));
					bool fragment_unnamed_711 = fragment_unnamed_702 < 1.0f;
					float fragment_unnamed_712 = mad(fragment_unnamed_675, fragment_unnamed_702, mad(fragment_unnamed_697.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_713 = mad(fragment_unnamed_676, fragment_unnamed_702, mad(fragment_unnamed_697.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_714 = mad(fragment_unnamed_677, fragment_unnamed_702, mad(fragment_unnamed_697.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_719 = rsqrt(max(dot(float3(fragment_unnamed_712, fragment_unnamed_713, fragment_unnamed_714), float3(fragment_unnamed_712, fragment_unnamed_713, fragment_unnamed_714)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_739 = mad(fragment_unnamed_257, fragment_unnamed_696, fragment_unnamed_690.x);
					fragment_unnamed_740 = mad(fragment_unnamed_258, fragment_unnamed_696, fragment_unnamed_690.y);
					fragment_unnamed_741 = mad(fragment_unnamed_259, fragment_unnamed_696, fragment_unnamed_690.z);
					fragment_unnamed_742 = asfloat(fragment_unnamed_711 ? asuint(fragment_unnamed_714 * fragment_unnamed_719) : asuint(fragment_unnamed_677));
					fragment_unnamed_743 = asfloat(fragment_unnamed_711 ? asuint(fragment_unnamed_713 * fragment_unnamed_719) : asuint(fragment_unnamed_676));
					fragment_unnamed_744 = asfloat(fragment_unnamed_711 ? asuint(fragment_unnamed_712 * fragment_unnamed_719) : asuint(fragment_unnamed_675));
					fragment_unnamed_745 = mad(fragment_unnamed_314, fragment_unnamed_703.w, fragment_unnamed_703.z);
				}
				else
				{
					fragment_unnamed_739 = fragment_unnamed_257;
					fragment_unnamed_740 = fragment_unnamed_258;
					fragment_unnamed_741 = fragment_unnamed_259;
					fragment_unnamed_742 = fragment_unnamed_677;
					fragment_unnamed_743 = fragment_unnamed_676;
					fragment_unnamed_744 = fragment_unnamed_675;
					fragment_unnamed_745 = fragment_unnamed_314;
				}
				float fragment_unnamed_749 = max(dot(float3(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742), float3(fragment_unnamed_228 * fragment_unnamed_210, fragment_unnamed_228 * fragment_unnamed_217, fragment_unnamed_228 * fragment_unnamed_224)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_752 = ((-0.0f) - fragment_unnamed_745) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_271 + exp2(log2(abs(fragment_unnamed_271 + fragment_unnamed_749)) * exp2(mad(fragment_unnamed_752 * fragment_unnamed_752, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_781 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_782 = fragment_unnamed_781.x;
				float fragment_unnamed_1067;
				float fragment_unnamed_1069;
				float fragment_unnamed_1071;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_782 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_782 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_1068;
					float fragment_unnamed_1070;
					float fragment_unnamed_1072;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_805 = asfloat(1065353216u);
						float fragment_unnamed_835 = fragment_unnamed_743 * fragment_unnamed_744;
						float fragment_unnamed_836 = fragment_unnamed_742 * fragment_unnamed_743;
						float fragment_unnamed_837 = fragment_unnamed_742 * fragment_unnamed_742;
						float fragment_unnamed_838 = fragment_unnamed_744 * fragment_unnamed_742;
						float fragment_unnamed_871 = mad(fragment_unnamed_744, fragment_unnamed_744, (-0.0f) - (fragment_unnamed_743 * fragment_unnamed_743));
						fragment_unnamed_1068 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_805)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_871, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_835, fragment_unnamed_836, fragment_unnamed_837, fragment_unnamed_838)));
						fragment_unnamed_1070 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_805)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_871, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_835, fragment_unnamed_836, fragment_unnamed_837, fragment_unnamed_838)));
						fragment_unnamed_1072 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_805)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_871, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_835, fragment_unnamed_836, fragment_unnamed_837, fragment_unnamed_838)));
					}
					else
					{
						bool fragment_unnamed_887 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_888 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_910 = fragment_unnamed_887 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_911 = fragment_unnamed_887 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_912 = fragment_unnamed_887 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_1016 = (asfloat(fragment_unnamed_888 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_912, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_910, fragment_unnamed_911 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_911)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_1017 = (asfloat(fragment_unnamed_888 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_912, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_910, fragment_unnamed_911 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_912)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_1030 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_888 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_912, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_910, fragment_unnamed_911 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_910)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_1057 = asfloat(1065353216u);
						fragment_unnamed_1068 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1030 + 0.5f, fragment_unnamed_1016 + 0.0f, fragment_unnamed_1017 + 0.0f), 0.0f)), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_1057));
						fragment_unnamed_1070 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1030 + 0.25f, fragment_unnamed_1016 + 0.0f, fragment_unnamed_1017 + 0.0f), 0.0f)), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_1057));
						fragment_unnamed_1072 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1030, fragment_unnamed_1016, fragment_unnamed_1017), 0.0f)), float4(fragment_unnamed_744, fragment_unnamed_743, fragment_unnamed_742, fragment_unnamed_1057));
					}
					fragment_unnamed_1067 = fragment_unnamed_1068;
					fragment_unnamed_1069 = fragment_unnamed_1070;
					fragment_unnamed_1071 = fragment_unnamed_1072;
				}
				else
				{
					fragment_unnamed_1067 = asfloat(0u);
					fragment_unnamed_1069 = asfloat(0u);
					fragment_unnamed_1071 = asfloat(0u);
				}
				float fragment_unnamed_1074 = mad((-0.0f) - fragment_unnamed_240, fragment_unnamed_270, 1.0f);
				float fragment_unnamed_1075 = fragment_unnamed_1074 * fragment_unnamed_739;
				float fragment_unnamed_1076 = fragment_unnamed_1074 * fragment_unnamed_740;
				float fragment_unnamed_1077 = fragment_unnamed_1074 * fragment_unnamed_741;
				float fragment_unnamed_1082 = mad(fragment_unnamed_300, fragment_unnamed_739 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1084 = mad(fragment_unnamed_300, fragment_unnamed_740 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1085 = mad(fragment_unnamed_300, fragment_unnamed_741 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1097 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_749), 0.984375f, 0.0078125f), mad(fragment_unnamed_752, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_1107 = clamp((max(fragment_unnamed_1085, max(fragment_unnamed_1084, fragment_unnamed_1082)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_1131 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1136 = max(abs(fragment_unnamed_742), 0.0009765625f);
				float fragment_unnamed_1140 = (fragment_unnamed_742 >= 0.0f) ? fragment_unnamed_1136 : ((-0.0f) - fragment_unnamed_1136);
				float fragment_unnamed_1149 = 1.0f / max(dot(float3(abs(fragment_unnamed_744), abs(fragment_unnamed_743), abs(fragment_unnamed_1140)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1154 = clamp((-0.0f) - (fragment_unnamed_1149 * fragment_unnamed_1140), 0.0f, 1.0f);
				float fragment_unnamed_1157 = (-0.0f) - fragment_unnamed_1154;
				uint fragment_unnamed_1169 = uint(clamp(mad(mad(fragment_unnamed_744, fragment_unnamed_1149, ((fragment_unnamed_1149 * fragment_unnamed_744) >= 0.0f) ? fragment_unnamed_1154 : fragment_unnamed_1157), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1170 = uint(clamp(mad(mad(fragment_unnamed_743, fragment_unnamed_1149, ((fragment_unnamed_1149 * fragment_unnamed_743) >= 0.0f) ? fragment_unnamed_1154 : fragment_unnamed_1157), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1169 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1170 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1170 >> 8u) * 16u) + (fragment_unnamed_1169 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_1082)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_1084)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_1085)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_1222 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1223 = fragment_unnamed_1222 * mad(fragment_unnamed_1131 * ((fragment_unnamed_1097 * mad(fragment_unnamed_1107, mad((-0.0f) - fragment_unnamed_739, fragment_unnamed_1074, fragment_unnamed_1082), fragment_unnamed_1075)) * fragment_unnamed_1071), fragment_unnamed_271, mad(fragment_uniform_buffer_2[6u].x, fragment_unnamed_309.x, fragment_unnamed_642 * fragment_uniform_buffer_2[8u].x));
				float fragment_unnamed_1224 = fragment_unnamed_1222 * mad(fragment_unnamed_1131 * ((fragment_unnamed_1097 * mad(fragment_unnamed_1107, mad((-0.0f) - fragment_unnamed_740, fragment_unnamed_1074, fragment_unnamed_1084), fragment_unnamed_1076)) * fragment_unnamed_1069), fragment_unnamed_271, mad(fragment_uniform_buffer_2[6u].y, fragment_unnamed_309.y, fragment_unnamed_642 * fragment_uniform_buffer_2[8u].y));
				float fragment_unnamed_1225 = fragment_unnamed_1222 * mad(fragment_unnamed_1131 * ((fragment_unnamed_1097 * mad(fragment_unnamed_1107, mad((-0.0f) - fragment_unnamed_741, fragment_unnamed_1074, fragment_unnamed_1085), fragment_unnamed_1077)) * fragment_unnamed_1067), fragment_unnamed_271, mad(fragment_uniform_buffer_2[6u].z, fragment_unnamed_309.z, fragment_unnamed_642 * fragment_uniform_buffer_2[8u].z));
				bool fragment_unnamed_1238 = (((fragment_unnamed_1225 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1224 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1223 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1238 ? asfloat(1157627904u) : fragment_unnamed_1223;
				fragment_output_3.y = fragment_unnamed_1238 ? fragment_unnamed_271 : fragment_unnamed_1224;
				fragment_output_3.z = fragment_unnamed_1238 ? asfloat(1149239296u) : fragment_unnamed_1225;
				fragment_output_0.x = fragment_unnamed_1075;
				fragment_output_0.y = fragment_unnamed_1076;
				fragment_output_0.z = fragment_unnamed_1077;
				fragment_output_1.w = fragment_unnamed_752;
				fragment_output_2.w = 0.0f;
				fragment_output_3.w = 0.0f;
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

				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_0[113] = float4(fragment_uniform_buffer_0[113][0], fragment_uniform_buffer_0[113][1], fragment_uniform_buffer_0[113][2], asfloat(_ReflectionsMode));

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], _ProbeExposureScale, fragment_uniform_buffer_0[118][2], fragment_uniform_buffer_0[118][3]);

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], fragment_uniform_buffer_0[118][1], fragment_uniform_buffer_0[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_0[120] = float4(_IndirectDiffuseLightingMultiplier, fragment_uniform_buffer_0[120][1], fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[120] = float4(fragment_uniform_buffer_0[120][0], asfloat(_IndirectDiffuseLightingLayers), fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[210] = float4(fragment_uniform_buffer_0[210][0], fragment_uniform_buffer_0[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_0[210][3]);

				fragment_uniform_buffer_0[213] = float4(asfloat(_IndirectDiffuseMode), fragment_uniform_buffer_0[213][1], fragment_uniform_buffer_0[213][2], fragment_uniform_buffer_0[213][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_1[13] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_1[14] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_1[15] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_1[16] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				fragment_uniform_buffer_1[17] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				fragment_uniform_buffer_1[18] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				fragment_uniform_buffer_1[19] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				fragment_uniform_buffer_2[1] = float4(_Dissolve, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[6] = float4(_Emission[0], _Emission[1], _Emission[2], _Emission[3]);

				fragment_uniform_buffer_2[7] = float4(_UseMaskMap, fragment_uniform_buffer_2[7][1], fragment_uniform_buffer_2[7][2], fragment_uniform_buffer_2[7][3]);

				fragment_uniform_buffer_2[8] = float4(_DissolveColor[0], _DissolveColor[1], _DissolveColor[2], _DissolveColor[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[17];
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
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
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
				float4 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
				float3 vertex_output_7 : INTERP6; // INTERP_6
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				if ((((0.0f < vertex_uniform_buffer_2[16u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
				{
					gl_Position.x = 0.0f;
					gl_Position.y = 0.0f;
					gl_Position.z = 0.0f;
					gl_Position.w = 0.0f;
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 0.0f;
					vertex_output_1.w = 0.0f;
					vertex_output_2.x = 0.0f;
					vertex_output_2.y = 0.0f;
					vertex_output_2.z = 0.0f;
					vertex_output_2.w = 0.0f;
					vertex_output_3.x = 0.0f;
					vertex_output_3.y = 0.0f;
					vertex_output_3.z = 0.0f;
					vertex_output_3.w = 0.0f;
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
					vertex_output_4.w = 0.0f;
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
					vertex_output_5.w = 0.0f;
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
					vertex_output_7.x = 0.0f;
					vertex_output_7.y = 0.0f;
					vertex_output_7.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_138 = asfloat(1065353216u);
					float vertex_unnamed_140 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_158 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_176 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_138));
					float vertex_unnamed_191 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_206 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_221 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_230 = rsqrt(max(dot(float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221), float3(vertex_unnamed_191, vertex_unnamed_206, vertex_unnamed_221)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_230 * vertex_unnamed_191;
					vertex_output_7.y = vertex_unnamed_230 * vertex_unnamed_206;
					vertex_output_7.z = vertex_unnamed_230 * vertex_unnamed_221;
					float vertex_unnamed_264 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_265 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_266 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_271 = rsqrt(max(dot(float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266), float3(vertex_unnamed_264, vertex_unnamed_265, vertex_unnamed_266)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_271 * vertex_unnamed_264;
					vertex_output_1.y = vertex_unnamed_271 * vertex_unnamed_265;
					vertex_output_1.z = vertex_unnamed_271 * vertex_unnamed_266;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_176, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_140, vertex_unnamed_158 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_140;
					vertex_output_6.y = vertex_unnamed_158;
					vertex_output_6.z = vertex_unnamed_176;
				}
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[16] = float4(vertex_uniform_buffer_2[16][0], vertex_uniform_buffer_2[16][1], _RayTracing, vertex_uniform_buffer_2[16][3]);

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
				return stage_output;
			}
			#endif

			// Per-stage fallbacks for variants missing from the ripped data
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			float4 vert(float3 pos : POSITION) : SV_POSITION { return float4(0, 0, 0, 1); }
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			float4 frag() : SV_TARGET { return 0; }
			#endif
			ENDHLSL
		}
	}
	SubShader
	{
		Tags { "DisableBatching" = "False" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
		Pass
		{
			Name "IndirectDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "IndirectDXR" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 740175

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "VisibilityDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "VisibilityDXR" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 838256

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "ForwardDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "ForwardDXR" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 910403

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "GBufferDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "GBufferDXR" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 931343

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "DebugDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DebugDXR" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 994611

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "PathTracingDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "PathTracingDXR" "QUEUE" = "AlphaTest+25" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 1064890

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
