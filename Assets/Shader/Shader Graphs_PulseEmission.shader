Shader "Shader Graphs/PulseEmission"
{
	Properties
	{
		[NoScaleOffset] _BaseColorMap ("BaseColorMap", 2D) = "white" {}
		[NoScaleOffset] _NormalMap ("NormalMap", 2D) = "white" {}
		[NoScaleOffset] _EmissionMap ("EmissionMap", 2D) = "white" {}
		[NoScaleOffset] _MaskMap ("MaskMap", 2D) = "white" {}
		[HDR] _FirstColor ("FirstColor", Color) = (0,0,0,1)
		[HDR] _SecondColor ("SecondColor", Color) = (1,0,0,1)
		_Frequency ("Frequency", Float) = 1
		_TillingOffset ("TillingOffset", Vector) = (1,1,0,0)
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
			GpuProgramID 14013

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ _ALPHATEST_ON


			#if !defined(_ALPHATEST_ON)

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

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
			}

			#endif // !defined(_ALPHATEST_ON)


			#if defined(_ALPHATEST_ON)

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
			float4 _TillingOffset;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[9];
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

			void discard_cond(bool fragment_unnamed_75)
			{
				if (fragment_unnamed_75)
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
				discard_cond((_BaseColorMap.SampleBias(sampler_BaseColorMap, float2(mad(fragment_input_1.x, fragment_uniform_buffer_1[8u].x, fragment_uniform_buffer_1[8u].z), mad(fragment_input_1.y, fragment_uniform_buffer_1[8u].y, fragment_uniform_buffer_1[8u].w)), fragment_uniform_buffer_0[86u].y).w + (-0.5f)) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
			}

			#endif // defined(_ALPHATEST_ON)


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
			GpuProgramID 275848

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma multi_compile _ _ALPHATEST_ON


			#if !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;
			float4 unity_MotionVectorsParams;

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

				vertex_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

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

			#endif // !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


			#if defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;
			float4 unity_MotionVectorsParams;

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

				vertex_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

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


			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			float4 _TillingOffset;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[9];
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

			void discard_cond(bool fragment_unnamed_162)
			{
				if (fragment_unnamed_162)
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
				discard_cond((_BaseColorMap.SampleBias(sampler_BaseColorMap, float2(mad(fragment_input_4.x, fragment_uniform_buffer_2[8u].x, fragment_uniform_buffer_2[8u].z), mad(fragment_input_4.y, fragment_uniform_buffer_2[8u].y, fragment_uniform_buffer_2[8u].w)), fragment_uniform_buffer_0[86u].y).w + (-0.5f)) < 0.0f);
				float fragment_unnamed_104 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_105 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_151 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_151 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_104) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_104)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_151 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_105) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_105)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[8] = float4(_TillingOffset[0], _TillingOffset[1], _TillingOffset[2], _TillingOffset[3]);

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

			#endif // defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON)

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float4 _TillingOffset;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[9];
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

			void discard_cond(bool fragment_unnamed_245)
			{
				if (fragment_unnamed_245)
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
				discard_cond((_BaseColorMap.SampleBias(sampler_BaseColorMap, float2(mad(fragment_input_4.x, fragment_uniform_buffer_2[8u].x, fragment_uniform_buffer_2[8u].z), mad(fragment_input_4.y, fragment_uniform_buffer_2[8u].y, fragment_uniform_buffer_2[8u].w)), fragment_uniform_buffer_0[86u].y).w + (-0.5f)) < 0.0f);
				float fragment_unnamed_105 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_106 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_152 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_152 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_105) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_105)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_152 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_106) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_106)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_179 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_187 = fragment_unnamed_179 * fragment_input_9.x;
				float fragment_unnamed_188 = fragment_unnamed_179 * fragment_input_9.y;
				float fragment_unnamed_189 = fragment_unnamed_179 * fragment_input_9.z;
				float fragment_unnamed_198 = 1.0f / max(dot(float3(abs(fragment_unnamed_187), abs(fragment_unnamed_188), abs(fragment_unnamed_189)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_203 = clamp((-0.0f) - (fragment_unnamed_198 * fragment_unnamed_189), 0.0f, 1.0f);
				float fragment_unnamed_206 = (-0.0f) - fragment_unnamed_203;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_187, fragment_unnamed_198, ((fragment_unnamed_198 * fragment_unnamed_187) >= 0.0f) ? fragment_unnamed_203 : fragment_unnamed_206), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_188, fragment_unnamed_198, ((fragment_unnamed_198 * fragment_unnamed_188) >= 0.0f) ? fragment_unnamed_203 : fragment_unnamed_206), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_225 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_225, min((8u & 31u), (32u - fragment_unnamed_225)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[8] = float4(_TillingOffset[0], _TillingOffset[1], _TillingOffset[2], _TillingOffset[3]);

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON)

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON)


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
			GpuProgramID 492262

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER
			#pragma multi_compile _ _ALPHATEST_ON


			#if !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)

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

			void main(Fragment_Stage_Input stage_input)
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

			#endif // !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)

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


			float _GlobalMipBias;
			float4 _TillingOffset;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[9];
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

			void discard_cond(bool fragment_unnamed_77)
			{
				if (fragment_unnamed_77)
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
				discard_cond((_BaseColorMap.SampleBias(sampler_BaseColorMap, float2(mad(fragment_input_2.x, fragment_uniform_buffer_1[8u].x, fragment_uniform_buffer_1[8u].z), mad(fragment_input_2.y, fragment_uniform_buffer_1[8u].y, fragment_uniform_buffer_1[8u].w)), fragment_uniform_buffer_0[86u].y).w + (-0.5f)) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
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

			#endif // defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON)

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float4 _TillingOffset;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			static float4 fragment_uniform_buffer_2[9];
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

			void discard_cond(bool fragment_unnamed_171)
			{
				if (fragment_unnamed_171)
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
				discard_cond((_BaseColorMap.SampleBias(sampler_BaseColorMap, float2(mad(fragment_input_2.x, fragment_uniform_buffer_2[8u].x, fragment_uniform_buffer_2[8u].z), mad(fragment_input_2.y, fragment_uniform_buffer_2[8u].y, fragment_uniform_buffer_2[8u].w)), fragment_uniform_buffer_0[86u].y).w + (-0.5f)) < 0.0f);
				float fragment_unnamed_101 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_109 = fragment_unnamed_101 * fragment_input_7.x;
				float fragment_unnamed_110 = fragment_unnamed_101 * fragment_input_7.y;
				float fragment_unnamed_111 = fragment_unnamed_101 * fragment_input_7.z;
				float fragment_unnamed_120 = 1.0f / max(dot(float3(abs(fragment_unnamed_109), abs(fragment_unnamed_110), abs(fragment_unnamed_111)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_126 = clamp((-0.0f) - (fragment_unnamed_120 * fragment_unnamed_111), 0.0f, 1.0f);
				float fragment_unnamed_129 = (-0.0f) - fragment_unnamed_126;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_109, fragment_unnamed_120, ((fragment_unnamed_120 * fragment_unnamed_109) >= 0.0f) ? fragment_unnamed_126 : fragment_unnamed_129), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_110, fragment_unnamed_120, ((fragment_unnamed_120 * fragment_unnamed_110) >= 0.0f) ? fragment_unnamed_126 : fragment_unnamed_129), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_151 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_151, min((8u & 31u), (32u - fragment_unnamed_151)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[8] = float4(_TillingOffset[0], _TillingOffset[1], _TillingOffset[2], _TillingOffset[3]);

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

			#endif // defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON)


			#if defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON)

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

			#endif // defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON)


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
			GpuProgramID 540633

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ DECALS_3RT
			#pragma multi_compile _ _ALPHATEST_ON


			#if !defined(_ALPHATEST_ON) && !defined(DECALS_3RT)

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

			#endif // !defined(_ALPHATEST_ON) && !defined(DECALS_3RT)


			#if defined(_ALPHATEST_ON) && !defined(DECALS_3RT)

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

			#endif // defined(_ALPHATEST_ON) && !defined(DECALS_3RT)


			#if defined(DECALS_3RT) && defined(_ALPHATEST_ON)

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _TimeParameters;
			float _GlobalMipBias;
			int _ReflectionsMode;
			float _ProbeExposureScale;
			float _ReplaceDiffuseForIndirect;
			float _IndirectDiffuseLightingMultiplier;
			int _IndirectDiffuseLightingLayers;
			int _EnableDecals;
			int _IndirectDiffuseMode;
			float4 unity_WorldTransformParams;
			float4 unity_RenderingLayer;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float4 unity_ProbeVolumeSizeInv;
			float4 unity_ProbeVolumeMin;
			float4 _FirstColor;
			float4 _SecondColor;
			float _Frequency;
			float4 _TillingOffset;

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
				float fragment_unnamed_245 = (sin((fragment_uniform_buffer_0[80u].x * fragment_uniform_buffer_2[7u].x) * 6.28318500518798828125f) + 1.0f) * 0.5f;
				float fragment_unnamed_286 = mad(fragment_input_2.x, fragment_uniform_buffer_2[8u].x, fragment_uniform_buffer_2[8u].z);
				float fragment_unnamed_287 = mad(fragment_input_2.y, fragment_uniform_buffer_2[8u].y, fragment_uniform_buffer_2[8u].w);
				float4 fragment_unnamed_294 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_286, fragment_unnamed_287), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_297 = fragment_unnamed_294.x;
				float fragment_unnamed_298 = fragment_unnamed_294.y;
				float fragment_unnamed_299 = fragment_unnamed_294.z;
				float4 fragment_unnamed_304 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_unnamed_286, fragment_unnamed_287), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_306 = fragment_unnamed_304.w;
				float fragment_unnamed_307 = fragment_unnamed_304.x;
				float fragment_unnamed_308 = fragment_unnamed_304.y;
				float4 fragment_unnamed_313 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_unnamed_286, fragment_unnamed_287), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_319 = mad(fragment_unnamed_313.x * fragment_unnamed_313.w, 2.0f, -1.0f);
				float fragment_unnamed_322 = mad(fragment_unnamed_313.y, 2.0f, -1.0f);
				float fragment_unnamed_330 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_319, fragment_unnamed_322), float2(fragment_unnamed_319, fragment_unnamed_322)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float4 fragment_unnamed_336 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_unnamed_286, fragment_unnamed_287), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_350 = mad(fragment_unnamed_330, fragment_unnamed_102 * fragment_input_7.x, mad(fragment_unnamed_319, fragment_unnamed_102 * fragment_input_1.x, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_322));
				float fragment_unnamed_351 = mad(fragment_unnamed_330, fragment_unnamed_102 * fragment_input_7.y, mad(fragment_unnamed_319, fragment_unnamed_102 * fragment_input_1.y, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_322));
				float fragment_unnamed_352 = mad(fragment_unnamed_330, fragment_unnamed_102 * fragment_input_7.z, mad(fragment_unnamed_319, fragment_unnamed_102 * fragment_input_1.z, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_322));
				float fragment_unnamed_357 = rsqrt(max(dot(float3(fragment_unnamed_350, fragment_unnamed_351, fragment_unnamed_352), float3(fragment_unnamed_350, fragment_unnamed_351, fragment_unnamed_352)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_358 = fragment_unnamed_357 * fragment_unnamed_350;
				float fragment_unnamed_359 = fragment_unnamed_357 * fragment_unnamed_351;
				float fragment_unnamed_360 = fragment_unnamed_357 * fragment_unnamed_352;
				float fragment_unnamed_422;
				float fragment_unnamed_423;
				float fragment_unnamed_424;
				float fragment_unnamed_425;
				float fragment_unnamed_426;
				float fragment_unnamed_427;
				float fragment_unnamed_428;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_371 = uint(gl_FragCoord.x);
					uint fragment_unnamed_372 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_373 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_371, fragment_unnamed_372, 0u), 0u));
					float fragment_unnamed_379 = fragment_unnamed_373.w;
					float4 fragment_unnamed_380 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_371, fragment_unnamed_372, 0u), 0u));
					float fragment_unnamed_385 = fragment_unnamed_380.w;
					float4 fragment_unnamed_386 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_371, fragment_unnamed_372, 0u), 0u));
					bool fragment_unnamed_394 = fragment_unnamed_385 < 1.0f;
					float fragment_unnamed_395 = mad(fragment_unnamed_358, fragment_unnamed_385, mad(fragment_unnamed_380.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_396 = mad(fragment_unnamed_359, fragment_unnamed_385, mad(fragment_unnamed_380.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_397 = mad(fragment_unnamed_360, fragment_unnamed_385, mad(fragment_unnamed_380.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_402 = rsqrt(max(dot(float3(fragment_unnamed_395, fragment_unnamed_396, fragment_unnamed_397), float3(fragment_unnamed_395, fragment_unnamed_396, fragment_unnamed_397)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_422 = mad(fragment_unnamed_297, fragment_unnamed_379, fragment_unnamed_373.x);
					fragment_unnamed_423 = mad(fragment_unnamed_298, fragment_unnamed_379, fragment_unnamed_373.y);
					fragment_unnamed_424 = mad(fragment_unnamed_299, fragment_unnamed_379, fragment_unnamed_373.z);
					fragment_unnamed_425 = mad(fragment_unnamed_306, fragment_unnamed_386.w, fragment_unnamed_386.z);
					fragment_unnamed_426 = asfloat(fragment_unnamed_394 ? asuint(fragment_unnamed_402 * fragment_unnamed_397) : asuint(fragment_unnamed_360));
					fragment_unnamed_427 = asfloat(fragment_unnamed_394 ? asuint(fragment_unnamed_402 * fragment_unnamed_396) : asuint(fragment_unnamed_359));
					fragment_unnamed_428 = asfloat(fragment_unnamed_394 ? asuint(fragment_unnamed_402 * fragment_unnamed_395) : asuint(fragment_unnamed_358));
				}
				else
				{
					fragment_unnamed_422 = fragment_unnamed_297;
					fragment_unnamed_423 = fragment_unnamed_298;
					fragment_unnamed_424 = fragment_unnamed_299;
					fragment_unnamed_425 = fragment_unnamed_306;
					fragment_unnamed_426 = fragment_unnamed_360;
					fragment_unnamed_427 = fragment_unnamed_359;
					fragment_unnamed_428 = fragment_unnamed_358;
				}
				float fragment_unnamed_432 = max(dot(float3(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426), float3(fragment_unnamed_228 * fragment_unnamed_210, fragment_unnamed_228 * fragment_unnamed_217, fragment_unnamed_228 * fragment_unnamed_224)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_435 = ((-0.0f) - fragment_unnamed_425) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_308 + exp2(log2(abs(fragment_unnamed_308 + fragment_unnamed_432)) * exp2(mad(fragment_unnamed_435 * fragment_unnamed_435, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_464 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_465 = fragment_unnamed_464.x;
				float fragment_unnamed_751;
				float fragment_unnamed_753;
				float fragment_unnamed_755;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_465 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_465 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_752;
					float fragment_unnamed_754;
					float fragment_unnamed_756;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_489 = asfloat(1065353216u);
						float fragment_unnamed_519 = fragment_unnamed_427 * fragment_unnamed_428;
						float fragment_unnamed_520 = fragment_unnamed_426 * fragment_unnamed_427;
						float fragment_unnamed_521 = fragment_unnamed_426 * fragment_unnamed_426;
						float fragment_unnamed_522 = fragment_unnamed_428 * fragment_unnamed_426;
						float fragment_unnamed_555 = mad(fragment_unnamed_428, fragment_unnamed_428, (-0.0f) - (fragment_unnamed_427 * fragment_unnamed_427));
						fragment_unnamed_752 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_489)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_555, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_519, fragment_unnamed_520, fragment_unnamed_521, fragment_unnamed_522)));
						fragment_unnamed_754 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_489)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_555, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_519, fragment_unnamed_520, fragment_unnamed_521, fragment_unnamed_522)));
						fragment_unnamed_756 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_489)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_555, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_519, fragment_unnamed_520, fragment_unnamed_521, fragment_unnamed_522)));
					}
					else
					{
						bool fragment_unnamed_571 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_572 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_594 = fragment_unnamed_571 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_595 = fragment_unnamed_571 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_596 = fragment_unnamed_571 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_700 = (asfloat(fragment_unnamed_572 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_596, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_594, fragment_unnamed_595 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_595)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_701 = (asfloat(fragment_unnamed_572 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_596, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_594, fragment_unnamed_595 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_596)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_714 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_572 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_596, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_594, fragment_unnamed_595 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_594)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_741 = asfloat(1065353216u);
						fragment_unnamed_752 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_714, fragment_unnamed_700, fragment_unnamed_701), 0.0f)), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_741));
						fragment_unnamed_754 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_714 + 0.25f, fragment_unnamed_700 + 0.0f, fragment_unnamed_701 + 0.0f), 0.0f)), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_741));
						fragment_unnamed_756 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_714 + 0.5f, fragment_unnamed_700 + 0.0f, fragment_unnamed_701 + 0.0f), 0.0f)), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_741));
					}
					fragment_unnamed_751 = fragment_unnamed_752;
					fragment_unnamed_753 = fragment_unnamed_754;
					fragment_unnamed_755 = fragment_unnamed_756;
				}
				else
				{
					fragment_unnamed_751 = asfloat(0u);
					fragment_unnamed_753 = asfloat(0u);
					fragment_unnamed_755 = asfloat(0u);
				}
				float fragment_unnamed_758 = ((-0.0f) - fragment_unnamed_307) + 1.0f;
				float fragment_unnamed_759 = fragment_unnamed_758 * fragment_unnamed_422;
				float fragment_unnamed_760 = fragment_unnamed_758 * fragment_unnamed_423;
				float fragment_unnamed_761 = fragment_unnamed_758 * fragment_unnamed_424;
				float fragment_unnamed_766 = mad(fragment_unnamed_307, fragment_unnamed_422 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_768 = mad(fragment_unnamed_307, fragment_unnamed_423 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_769 = mad(fragment_unnamed_307, fragment_unnamed_424 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_781 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_432), 0.984375f, 0.0078125f), mad(fragment_unnamed_435, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_791 = clamp((max(fragment_unnamed_769, max(fragment_unnamed_768, fragment_unnamed_766)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_815 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_820 = max(abs(fragment_unnamed_426), 0.0009765625f);
				float fragment_unnamed_824 = (fragment_unnamed_426 >= 0.0f) ? fragment_unnamed_820 : ((-0.0f) - fragment_unnamed_820);
				float fragment_unnamed_833 = 1.0f / max(dot(float3(abs(fragment_unnamed_428), abs(fragment_unnamed_427), abs(fragment_unnamed_824)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_838 = clamp((-0.0f) - (fragment_unnamed_833 * fragment_unnamed_824), 0.0f, 1.0f);
				float fragment_unnamed_841 = (-0.0f) - fragment_unnamed_838;
				uint fragment_unnamed_853 = uint(clamp(mad(mad(fragment_unnamed_428, fragment_unnamed_833, ((fragment_unnamed_833 * fragment_unnamed_428) >= 0.0f) ? fragment_unnamed_838 : fragment_unnamed_841), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_854 = uint(clamp(mad(mad(fragment_unnamed_427, fragment_unnamed_833, ((fragment_unnamed_833 * fragment_unnamed_427) >= 0.0f) ? fragment_unnamed_838 : fragment_unnamed_841), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_853 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_854 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_854 >> 8u) * 16u) + (fragment_unnamed_853 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_766)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_768)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_769)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_906 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_907 = fragment_unnamed_906 * mad(fragment_unnamed_815 * ((fragment_unnamed_781 * mad(fragment_unnamed_791, mad((-0.0f) - fragment_unnamed_422, fragment_unnamed_758, fragment_unnamed_766), fragment_unnamed_759)) * fragment_unnamed_751), fragment_unnamed_308, mad(fragment_unnamed_245, ((-0.0f) - fragment_uniform_buffer_2[5u].x) + fragment_uniform_buffer_2[6u].x, fragment_uniform_buffer_2[5u].x) * fragment_unnamed_336.x);
				float fragment_unnamed_908 = fragment_unnamed_906 * mad(fragment_unnamed_815 * ((fragment_unnamed_781 * mad(fragment_unnamed_791, mad((-0.0f) - fragment_unnamed_423, fragment_unnamed_758, fragment_unnamed_768), fragment_unnamed_760)) * fragment_unnamed_753), fragment_unnamed_308, mad(fragment_unnamed_245, ((-0.0f) - fragment_uniform_buffer_2[5u].y) + fragment_uniform_buffer_2[6u].y, fragment_uniform_buffer_2[5u].y) * fragment_unnamed_336.y);
				float fragment_unnamed_909 = fragment_unnamed_906 * mad(fragment_unnamed_815 * ((fragment_unnamed_781 * mad(fragment_unnamed_791, mad((-0.0f) - fragment_unnamed_424, fragment_unnamed_758, fragment_unnamed_769), fragment_unnamed_761)) * fragment_unnamed_755), fragment_unnamed_308, mad(fragment_unnamed_245, ((-0.0f) - fragment_uniform_buffer_2[5u].z) + fragment_uniform_buffer_2[6u].z, fragment_uniform_buffer_2[5u].z) * fragment_unnamed_336.z);
				bool fragment_unnamed_922 = (((fragment_unnamed_909 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_908 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_907 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_922 ? asfloat(1157627904u) : fragment_unnamed_907;
				fragment_output_3.y = fragment_unnamed_922 ? fragment_unnamed_308 : fragment_unnamed_908;
				fragment_output_3.z = fragment_unnamed_922 ? asfloat(1149239296u) : fragment_unnamed_909;
				fragment_output_0.x = fragment_unnamed_759;
				fragment_output_0.y = fragment_unnamed_760;
				fragment_output_0.z = fragment_unnamed_761;
				fragment_output_1.w = fragment_unnamed_435;
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

				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_0[113] = float4(fragment_uniform_buffer_0[113][0], fragment_uniform_buffer_0[113][1], fragment_uniform_buffer_0[113][2], asfloat(_ReflectionsMode));

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], _ProbeExposureScale, fragment_uniform_buffer_0[118][2], fragment_uniform_buffer_0[118][3]);

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], fragment_uniform_buffer_0[118][1], fragment_uniform_buffer_0[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_0[120] = float4(_IndirectDiffuseLightingMultiplier, fragment_uniform_buffer_0[120][1], fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[120] = float4(fragment_uniform_buffer_0[120][0], asfloat(_IndirectDiffuseLightingLayers), fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[210] = float4(fragment_uniform_buffer_0[210][0], fragment_uniform_buffer_0[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_0[210][3]);

				fragment_uniform_buffer_0[213] = float4(asfloat(_IndirectDiffuseMode), fragment_uniform_buffer_0[213][1], fragment_uniform_buffer_0[213][2], fragment_uniform_buffer_0[213][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_1[13] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_1[14] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_1[15] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_1[16] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				fragment_uniform_buffer_1[17] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				fragment_uniform_buffer_1[18] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				fragment_uniform_buffer_1[19] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				fragment_uniform_buffer_1[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_1[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_1[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_1[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_1[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_1[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_1[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_2[5] = float4(_FirstColor[0], _FirstColor[1], _FirstColor[2], _FirstColor[3]);

				fragment_uniform_buffer_2[6] = float4(_SecondColor[0], _SecondColor[1], _SecondColor[2], _SecondColor[3]);

				fragment_uniform_buffer_2[7] = float4(_Frequency, fragment_uniform_buffer_2[7][1], fragment_uniform_buffer_2[7][2], fragment_uniform_buffer_2[7][3]);

				fragment_uniform_buffer_2[8] = float4(_TillingOffset[0], _TillingOffset[1], _TillingOffset[2], _TillingOffset[3]);

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

			#endif // defined(DECALS_3RT) && defined(_ALPHATEST_ON)


			#if defined(DECALS_3RT) && !defined(_ALPHATEST_ON)

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _TimeParameters;
			float _GlobalMipBias;
			int _ReflectionsMode;
			float _ProbeExposureScale;
			float _ReplaceDiffuseForIndirect;
			float _IndirectDiffuseLightingMultiplier;
			int _IndirectDiffuseLightingLayers;
			int _EnableDecals;
			int _IndirectDiffuseMode;
			float4 unity_WorldTransformParams;
			float4 unity_RenderingLayer;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float4 unity_ProbeVolumeSizeInv;
			float4 unity_ProbeVolumeMin;
			float4 _FirstColor;
			float4 _SecondColor;
			float _Frequency;
			float4 _TillingOffset;

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
				float fragment_unnamed_245 = (sin((fragment_uniform_buffer_0[80u].x * fragment_uniform_buffer_2[7u].x) * 6.28318500518798828125f) + 1.0f) * 0.5f;
				float fragment_unnamed_286 = mad(fragment_input_2.x, fragment_uniform_buffer_2[8u].x, fragment_uniform_buffer_2[8u].z);
				float fragment_unnamed_287 = mad(fragment_input_2.y, fragment_uniform_buffer_2[8u].y, fragment_uniform_buffer_2[8u].w);
				float4 fragment_unnamed_294 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_286, fragment_unnamed_287), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_297 = fragment_unnamed_294.x;
				float fragment_unnamed_298 = fragment_unnamed_294.y;
				float fragment_unnamed_299 = fragment_unnamed_294.z;
				float4 fragment_unnamed_304 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_unnamed_286, fragment_unnamed_287), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_306 = fragment_unnamed_304.w;
				float fragment_unnamed_307 = fragment_unnamed_304.x;
				float fragment_unnamed_308 = fragment_unnamed_304.y;
				float4 fragment_unnamed_313 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_unnamed_286, fragment_unnamed_287), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_319 = mad(fragment_unnamed_313.x * fragment_unnamed_313.w, 2.0f, -1.0f);
				float fragment_unnamed_322 = mad(fragment_unnamed_313.y, 2.0f, -1.0f);
				float fragment_unnamed_330 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_319, fragment_unnamed_322), float2(fragment_unnamed_319, fragment_unnamed_322)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float4 fragment_unnamed_336 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_unnamed_286, fragment_unnamed_287), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_350 = mad(fragment_unnamed_330, fragment_unnamed_102 * fragment_input_7.x, mad(fragment_unnamed_319, fragment_unnamed_102 * fragment_input_1.x, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_322));
				float fragment_unnamed_351 = mad(fragment_unnamed_330, fragment_unnamed_102 * fragment_input_7.y, mad(fragment_unnamed_319, fragment_unnamed_102 * fragment_input_1.y, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_322));
				float fragment_unnamed_352 = mad(fragment_unnamed_330, fragment_unnamed_102 * fragment_input_7.z, mad(fragment_unnamed_319, fragment_unnamed_102 * fragment_input_1.z, (fragment_unnamed_102 * (fragment_unnamed_121 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_322));
				float fragment_unnamed_357 = rsqrt(max(dot(float3(fragment_unnamed_350, fragment_unnamed_351, fragment_unnamed_352), float3(fragment_unnamed_350, fragment_unnamed_351, fragment_unnamed_352)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_358 = fragment_unnamed_357 * fragment_unnamed_350;
				float fragment_unnamed_359 = fragment_unnamed_357 * fragment_unnamed_351;
				float fragment_unnamed_360 = fragment_unnamed_357 * fragment_unnamed_352;
				float fragment_unnamed_422;
				float fragment_unnamed_423;
				float fragment_unnamed_424;
				float fragment_unnamed_425;
				float fragment_unnamed_426;
				float fragment_unnamed_427;
				float fragment_unnamed_428;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_371 = uint(gl_FragCoord.x);
					uint fragment_unnamed_372 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_373 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_371, fragment_unnamed_372, 0u), 0u));
					float fragment_unnamed_379 = fragment_unnamed_373.w;
					float4 fragment_unnamed_380 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_371, fragment_unnamed_372, 0u), 0u));
					float fragment_unnamed_385 = fragment_unnamed_380.w;
					float4 fragment_unnamed_386 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_371, fragment_unnamed_372, 0u), 0u));
					bool fragment_unnamed_394 = fragment_unnamed_385 < 1.0f;
					float fragment_unnamed_395 = mad(fragment_unnamed_358, fragment_unnamed_385, mad(fragment_unnamed_380.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_396 = mad(fragment_unnamed_359, fragment_unnamed_385, mad(fragment_unnamed_380.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_397 = mad(fragment_unnamed_360, fragment_unnamed_385, mad(fragment_unnamed_380.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_402 = rsqrt(max(dot(float3(fragment_unnamed_395, fragment_unnamed_396, fragment_unnamed_397), float3(fragment_unnamed_395, fragment_unnamed_396, fragment_unnamed_397)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_422 = mad(fragment_unnamed_297, fragment_unnamed_379, fragment_unnamed_373.x);
					fragment_unnamed_423 = mad(fragment_unnamed_298, fragment_unnamed_379, fragment_unnamed_373.y);
					fragment_unnamed_424 = mad(fragment_unnamed_299, fragment_unnamed_379, fragment_unnamed_373.z);
					fragment_unnamed_425 = mad(fragment_unnamed_306, fragment_unnamed_386.w, fragment_unnamed_386.z);
					fragment_unnamed_426 = asfloat(fragment_unnamed_394 ? asuint(fragment_unnamed_402 * fragment_unnamed_397) : asuint(fragment_unnamed_360));
					fragment_unnamed_427 = asfloat(fragment_unnamed_394 ? asuint(fragment_unnamed_402 * fragment_unnamed_396) : asuint(fragment_unnamed_359));
					fragment_unnamed_428 = asfloat(fragment_unnamed_394 ? asuint(fragment_unnamed_402 * fragment_unnamed_395) : asuint(fragment_unnamed_358));
				}
				else
				{
					fragment_unnamed_422 = fragment_unnamed_297;
					fragment_unnamed_423 = fragment_unnamed_298;
					fragment_unnamed_424 = fragment_unnamed_299;
					fragment_unnamed_425 = fragment_unnamed_306;
					fragment_unnamed_426 = fragment_unnamed_360;
					fragment_unnamed_427 = fragment_unnamed_359;
					fragment_unnamed_428 = fragment_unnamed_358;
				}
				float fragment_unnamed_432 = max(dot(float3(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426), float3(fragment_unnamed_228 * fragment_unnamed_210, fragment_unnamed_228 * fragment_unnamed_217, fragment_unnamed_228 * fragment_unnamed_224)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_435 = ((-0.0f) - fragment_unnamed_425) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_308 + exp2(log2(abs(fragment_unnamed_308 + fragment_unnamed_432)) * exp2(mad(fragment_unnamed_435 * fragment_unnamed_435, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_464 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_465 = fragment_unnamed_464.x;
				float fragment_unnamed_751;
				float fragment_unnamed_753;
				float fragment_unnamed_755;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_465 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_465 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_752;
					float fragment_unnamed_754;
					float fragment_unnamed_756;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_489 = asfloat(1065353216u);
						float fragment_unnamed_519 = fragment_unnamed_427 * fragment_unnamed_428;
						float fragment_unnamed_520 = fragment_unnamed_426 * fragment_unnamed_427;
						float fragment_unnamed_521 = fragment_unnamed_426 * fragment_unnamed_426;
						float fragment_unnamed_522 = fragment_unnamed_428 * fragment_unnamed_426;
						float fragment_unnamed_555 = mad(fragment_unnamed_428, fragment_unnamed_428, (-0.0f) - (fragment_unnamed_427 * fragment_unnamed_427));
						fragment_unnamed_752 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_489)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_555, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_519, fragment_unnamed_520, fragment_unnamed_521, fragment_unnamed_522)));
						fragment_unnamed_754 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_489)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_555, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_519, fragment_unnamed_520, fragment_unnamed_521, fragment_unnamed_522)));
						fragment_unnamed_756 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_489)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_555, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_519, fragment_unnamed_520, fragment_unnamed_521, fragment_unnamed_522)));
					}
					else
					{
						bool fragment_unnamed_571 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_572 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_594 = fragment_unnamed_571 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_595 = fragment_unnamed_571 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_596 = fragment_unnamed_571 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_700 = (asfloat(fragment_unnamed_572 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_596, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_594, fragment_unnamed_595 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_595)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_701 = (asfloat(fragment_unnamed_572 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_596, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_594, fragment_unnamed_595 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_596)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_714 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_572 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_596, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_594, fragment_unnamed_595 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_594)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_741 = asfloat(1065353216u);
						fragment_unnamed_752 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_714, fragment_unnamed_700, fragment_unnamed_701), 0.0f)), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_741));
						fragment_unnamed_754 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_714 + 0.25f, fragment_unnamed_700 + 0.0f, fragment_unnamed_701 + 0.0f), 0.0f)), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_741));
						fragment_unnamed_756 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_714 + 0.5f, fragment_unnamed_700 + 0.0f, fragment_unnamed_701 + 0.0f), 0.0f)), float4(fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_426, fragment_unnamed_741));
					}
					fragment_unnamed_751 = fragment_unnamed_752;
					fragment_unnamed_753 = fragment_unnamed_754;
					fragment_unnamed_755 = fragment_unnamed_756;
				}
				else
				{
					fragment_unnamed_751 = asfloat(0u);
					fragment_unnamed_753 = asfloat(0u);
					fragment_unnamed_755 = asfloat(0u);
				}
				float fragment_unnamed_758 = ((-0.0f) - fragment_unnamed_307) + 1.0f;
				float fragment_unnamed_759 = fragment_unnamed_758 * fragment_unnamed_422;
				float fragment_unnamed_760 = fragment_unnamed_758 * fragment_unnamed_423;
				float fragment_unnamed_761 = fragment_unnamed_758 * fragment_unnamed_424;
				float fragment_unnamed_766 = mad(fragment_unnamed_307, fragment_unnamed_422 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_768 = mad(fragment_unnamed_307, fragment_unnamed_423 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_769 = mad(fragment_unnamed_307, fragment_unnamed_424 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_781 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_432), 0.984375f, 0.0078125f), mad(fragment_unnamed_435, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_791 = clamp((max(fragment_unnamed_769, max(fragment_unnamed_768, fragment_unnamed_766)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_815 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_820 = max(abs(fragment_unnamed_426), 0.0009765625f);
				float fragment_unnamed_824 = (fragment_unnamed_426 >= 0.0f) ? fragment_unnamed_820 : ((-0.0f) - fragment_unnamed_820);
				float fragment_unnamed_833 = 1.0f / max(dot(float3(abs(fragment_unnamed_428), abs(fragment_unnamed_427), abs(fragment_unnamed_824)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_838 = clamp((-0.0f) - (fragment_unnamed_833 * fragment_unnamed_824), 0.0f, 1.0f);
				float fragment_unnamed_841 = (-0.0f) - fragment_unnamed_838;
				uint fragment_unnamed_853 = uint(clamp(mad(mad(fragment_unnamed_428, fragment_unnamed_833, ((fragment_unnamed_833 * fragment_unnamed_428) >= 0.0f) ? fragment_unnamed_838 : fragment_unnamed_841), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_854 = uint(clamp(mad(mad(fragment_unnamed_427, fragment_unnamed_833, ((fragment_unnamed_833 * fragment_unnamed_427) >= 0.0f) ? fragment_unnamed_838 : fragment_unnamed_841), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_853 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_854 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_854 >> 8u) * 16u) + (fragment_unnamed_853 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_766)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_768)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_769)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_906 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_907 = fragment_unnamed_906 * mad(fragment_unnamed_815 * ((fragment_unnamed_781 * mad(fragment_unnamed_791, mad((-0.0f) - fragment_unnamed_422, fragment_unnamed_758, fragment_unnamed_766), fragment_unnamed_759)) * fragment_unnamed_751), fragment_unnamed_308, mad(fragment_unnamed_245, ((-0.0f) - fragment_uniform_buffer_2[5u].x) + fragment_uniform_buffer_2[6u].x, fragment_uniform_buffer_2[5u].x) * fragment_unnamed_336.x);
				float fragment_unnamed_908 = fragment_unnamed_906 * mad(fragment_unnamed_815 * ((fragment_unnamed_781 * mad(fragment_unnamed_791, mad((-0.0f) - fragment_unnamed_423, fragment_unnamed_758, fragment_unnamed_768), fragment_unnamed_760)) * fragment_unnamed_753), fragment_unnamed_308, mad(fragment_unnamed_245, ((-0.0f) - fragment_uniform_buffer_2[5u].y) + fragment_uniform_buffer_2[6u].y, fragment_uniform_buffer_2[5u].y) * fragment_unnamed_336.y);
				float fragment_unnamed_909 = fragment_unnamed_906 * mad(fragment_unnamed_815 * ((fragment_unnamed_781 * mad(fragment_unnamed_791, mad((-0.0f) - fragment_unnamed_424, fragment_unnamed_758, fragment_unnamed_769), fragment_unnamed_761)) * fragment_unnamed_755), fragment_unnamed_308, mad(fragment_unnamed_245, ((-0.0f) - fragment_uniform_buffer_2[5u].z) + fragment_uniform_buffer_2[6u].z, fragment_uniform_buffer_2[5u].z) * fragment_unnamed_336.z);
				bool fragment_unnamed_922 = (((fragment_unnamed_909 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_908 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_907 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_922 ? asfloat(1157627904u) : fragment_unnamed_907;
				fragment_output_3.y = fragment_unnamed_922 ? fragment_unnamed_308 : fragment_unnamed_908;
				fragment_output_3.z = fragment_unnamed_922 ? asfloat(1149239296u) : fragment_unnamed_909;
				fragment_output_0.x = fragment_unnamed_759;
				fragment_output_0.y = fragment_unnamed_760;
				fragment_output_0.z = fragment_unnamed_761;
				fragment_output_1.w = fragment_unnamed_435;
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

				fragment_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_0[113] = float4(fragment_uniform_buffer_0[113][0], fragment_uniform_buffer_0[113][1], fragment_uniform_buffer_0[113][2], asfloat(_ReflectionsMode));

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], _ProbeExposureScale, fragment_uniform_buffer_0[118][2], fragment_uniform_buffer_0[118][3]);

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], fragment_uniform_buffer_0[118][1], fragment_uniform_buffer_0[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_0[120] = float4(_IndirectDiffuseLightingMultiplier, fragment_uniform_buffer_0[120][1], fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[120] = float4(fragment_uniform_buffer_0[120][0], asfloat(_IndirectDiffuseLightingLayers), fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[210] = float4(fragment_uniform_buffer_0[210][0], fragment_uniform_buffer_0[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_0[210][3]);

				fragment_uniform_buffer_0[213] = float4(asfloat(_IndirectDiffuseMode), fragment_uniform_buffer_0[213][1], fragment_uniform_buffer_0[213][2], fragment_uniform_buffer_0[213][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_1[13] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_1[14] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_1[15] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_1[16] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				fragment_uniform_buffer_1[17] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				fragment_uniform_buffer_1[18] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				fragment_uniform_buffer_1[19] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				fragment_uniform_buffer_1[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_1[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_1[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_1[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_1[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_1[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_1[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_2[5] = float4(_FirstColor[0], _FirstColor[1], _FirstColor[2], _FirstColor[3]);

				fragment_uniform_buffer_2[6] = float4(_SecondColor[0], _SecondColor[1], _SecondColor[2], _SecondColor[3]);

				fragment_uniform_buffer_2[7] = float4(_Frequency, fragment_uniform_buffer_2[7][1], fragment_uniform_buffer_2[7][2], fragment_uniform_buffer_2[7][3]);

				fragment_uniform_buffer_2[8] = float4(_TillingOffset[0], _TillingOffset[1], _TillingOffset[2], _TillingOffset[3]);

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

			#endif // defined(DECALS_3RT) && !defined(_ALPHATEST_ON)


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
			GpuProgramID 750375

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
			GpuProgramID 787454

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
			GpuProgramID 901676

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
			GpuProgramID 972262

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
			GpuProgramID 1007779

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
			GpuProgramID 1089809

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
