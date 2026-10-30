Shader "Shader Graphs/SubsurfaceScattering"
{
	Properties
	{
		_AlphaCutoff ("Alpha Cutoff", Float) = 0
		_BaseColor ("Base Color", Color) = (0,0,0,0)
		[NoScaleOffset] _BaseColorMap ("Base Color Map", 2D) = "white" {}
		[NoScaleOffset] _MaskMap ("Mask Map", 2D) = "white" {}
		_Metallic ("Metallic", Range(0, 1)) = 0
		_SmoothnessRemapMin ("Smoothness Remap Min", Range(0, 1)) = 0
		_SmoothnessRemapMax ("Smoothness Remap Max", Range(0, 1)) = 1
		_AORemapMin ("AO Remap Min", Range(0, 1)) = 0
		_AORemapMax ("AO Remap Max", Range(0, 1)) = 1
		[NoScaleOffset] [Normal] _NormalMap ("Normal Map", 2D) = "bump" {}
		_NormalScale ("Normal Scale", Float) = 1
		_UVBase ("UV Channel", Range(0, 5)) = 0
		[ToggleUI] _WorldMapping ("Object/World", Float) = 0
		_TexWorldScale ("Scale", Float) = 1
		_BaseColorMap_TO ("Tiling Offset", Vector) = (1,1,0,0)
		[ToggleUI] _EnableDetail ("Enable Detail", Float) = 0
		[NoScaleOffset] _DetailMap ("Detail Map", 2D) = "grey" {}
		_UVDetail ("Detail UV Channel", Range(0, 3)) = 0
		[ToggleUI] _LinkDetailsWithBase ("LockTiling", Float) = 1
		_DetailAlbedoScale ("Detail Albedo Scale", Range(0, 2)) = 1
		_DetailNormalScale ("Detail Normal Scale", Range(0, 2)) = 1
		_DetailSmoothnessScale ("Detail Smoothness Scale", Range(0, 2)) = 1
		_DetailMap_TO ("Detail Tiling Offset", Vector) = (1,1,0,0)
		_Thickness ("Thickness", Range(0, 1)) = 1
		_Fade ("Fade", Range(0, 1)) = 1
		[HideInInspector] _DiffusionProfileHash ("Float", Float) = 0
		[HideInInspector] _DiffusionProfileAsset ("Vector4", Vector) = (0,0,0,0)
		[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
		[HideInInspector] _RenderQueueType ("Float", Float) = 4
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
		[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Boolean", Float) = 1
		[HideInInspector] _CullModeForward ("Float", Float) = 2
		[Enum(Front, 1, Back, 2)] [HideInInspector] _TransparentCullMode ("Float", Float) = 0
		[Enum(UnityEngine.Rendering.HighDefinition.OpaqueCullMode)] [HideInInspector] _OpaqueCullMode ("Float", Float) = 2
		[HideInInspector] _ZTestDepthEqualForOpaque ("Float", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _ZTestTransparent ("Float", Float) = 0
		[ToggleUI] [HideInInspector] _TransparentBackfaceEnable ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _RequireSplitLighting ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _ReceivesSSR ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _ReceivesSSRTransparent ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _EnableBlendModePreserveSpecularLighting ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _SupportDecals ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _ExcludeFromTUAndAA ("Boolean", Float) = 0
		[HideInInspector] _StencilRef ("Float", Float) = 4
		[HideInInspector] _StencilWriteMask ("Float", Float) = 6
		[HideInInspector] _StencilRefDepth ("Float", Float) = 0
		[HideInInspector] _StencilWriteMaskDepth ("Float", Float) = 9
		[HideInInspector] _StencilRefMV ("Float", Float) = 32
		[HideInInspector] _StencilWriteMaskMV ("Float", Float) = 41
		[HideInInspector] _StencilRefDistortionVec ("Float", Float) = 4
		[HideInInspector] _StencilWriteMaskDistortionVec ("Float", Float) = 4
		[HideInInspector] _StencilWriteMaskGBuffer ("Float", Float) = 15
		[HideInInspector] _StencilRefGBuffer ("Float", Float) = 6
		[HideInInspector] _ZTestGBuffer ("Float", Float) = 4
		[ToggleUI] [HideInInspector] _RayTracing ("Boolean", Float) = 0
		[Enum(None, 0, Planar, 1, Sphere, 2, Thin, 3)] [HideInInspector] _RefractionModel ("Float", Float) = 0
		[Enum(SubsurfaceScattering, 0, Translucent, 5)] [HideInInspector] _MaterialID ("_MaterialID", Float) = 0
		[HideInInspector] _MaterialTypeMask ("_MaterialTypeMask", Float) = 33
		[ToggleUI] [HideInInspector] _TransmissionEnable ("Boolean", Float) = 1
		[HideInInspector] [NoScaleOffset] unity_Lightmaps ("unity_Lightmaps", 2DArray) = "" {}
		[HideInInspector] [NoScaleOffset] unity_LightmapsInd ("unity_LightmapsInd", 2DArray) = "" {}
		[HideInInspector] [NoScaleOffset] unity_ShadowMasks ("unity_ShadowMasks", 2DArray) = "" {}
	}
	SubShader
	{
		Tags { "DisableBatching" = "False" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
		Pass
		{
			Name "ShadowCaster"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			ColorMask 0
			ZClip [_ZClip]
			Cull [_CullMode]
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 19919

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


			float4 _WorldSpaceCameraPos_Internal;
			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4 _BaseColor;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[8];
			static float4 fragment_uniform_buffer_2[16];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 gl_FragCoord;
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
				float4 gl_FragCoord : SV_Position;
			};

			static bool discard_state;

			uint spvBitfieldInsert(uint Base, uint Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint2 spvBitfieldInsert(uint2 Base, uint2 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint3 spvBitfieldInsert(uint3 Base, uint3 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint4 spvBitfieldInsert(uint4 Base, uint4 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			void discard_cond(bool fragment_unnamed_339)
			{
				if (fragment_unnamed_339)
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
				uint fragment_unnamed_41[64];
				fragment_unnamed_41[0u] = 1030811889u;
				fragment_unnamed_41[4u] = 1057458056u;
				fragment_unnamed_41[8u] = 1043641525u;
				fragment_unnamed_41[12u] = 1059431846u;
				fragment_unnamed_41[16u] = 1061405636u;
				fragment_unnamed_41[20u] = 1050056343u;
				fragment_unnamed_41[24u] = 1063379426u;
				fragment_unnamed_41[28u] = 1054003923u;
				fragment_unnamed_41[32u] = 1047589105u;
				fragment_unnamed_41[36u] = 1060418741u;
				fragment_unnamed_41[40u] = 1039200497u;
				fragment_unnamed_41[44u] = 1058444951u;
				fragment_unnamed_41[48u] = 1064366321u;
				fragment_unnamed_41[52u] = 1055977713u;
				fragment_unnamed_41[56u] = 1062392531u;
				fragment_unnamed_41[60u] = 1052030133u;
				uint fragment_unnamed_135 = 2u & 31u;
				uint fragment_unnamed_141 = 0u & 31u;
				bool fragment_unnamed_224 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_256 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_266 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_277 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_284 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_291 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_315 = asfloat(fragment_unnamed_266 ? asuint(mad((fragment_unnamed_224 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_5.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_5.x, fragment_input_5.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_5.x) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)) : asuint(mad(mad(fragment_unnamed_277, fragment_input_3.x, fragment_unnamed_256 * fragment_input_4.x) + mad(fragment_unnamed_291, fragment_input_1.x, fragment_unnamed_284 * fragment_input_2.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_317 = asfloat(fragment_unnamed_266 ? asuint(mad((fragment_unnamed_224 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_5.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_5.x, fragment_input_5.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_5.z) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)) : asuint(mad(mad(fragment_unnamed_277, fragment_input_3.y, fragment_unnamed_256 * fragment_input_4.y) + mad(fragment_unnamed_291, fragment_input_1.y, fragment_unnamed_284 * fragment_input_2.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				discard_cond(mad(fragment_uniform_buffer_2[2u].w, _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_315, fragment_unnamed_317), fragment_uniform_buffer_0[86u].y).w, (-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_41[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_135, min((2u & 31u), (32u - fragment_unnamed_135))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_141, min((2u & 31u), (32u - fragment_unnamed_141))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[15u].y) + 2.0f))) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
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
			GpuProgramID 321687

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DISABLE_DECALS


			#if !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

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

			#endif // !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)


			#if defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

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


			float4 _WorldSpaceCameraPos_Internal;
			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4 _BaseColor;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[16];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 gl_FragCoord;
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
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			uint spvBitfieldInsert(uint Base, uint Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint2 spvBitfieldInsert(uint2 Base, uint2 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint3 spvBitfieldInsert(uint3 Base, uint3 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint4 spvBitfieldInsert(uint4 Base, uint4 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			void discard_cond(bool fragment_unnamed_420)
			{
				if (fragment_unnamed_420)
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
				uint fragment_unnamed_47[64];
				fragment_unnamed_47[0u] = 1030811889u;
				fragment_unnamed_47[4u] = 1057458056u;
				fragment_unnamed_47[8u] = 1043641525u;
				fragment_unnamed_47[12u] = 1059431846u;
				fragment_unnamed_47[16u] = 1061405636u;
				fragment_unnamed_47[20u] = 1050056343u;
				fragment_unnamed_47[24u] = 1063379426u;
				fragment_unnamed_47[28u] = 1054003923u;
				fragment_unnamed_47[32u] = 1047589105u;
				fragment_unnamed_47[36u] = 1060418741u;
				fragment_unnamed_47[40u] = 1039200497u;
				fragment_unnamed_47[44u] = 1058444951u;
				fragment_unnamed_47[48u] = 1064366321u;
				fragment_unnamed_47[52u] = 1055977713u;
				fragment_unnamed_47[56u] = 1062392531u;
				fragment_unnamed_47[60u] = 1052030133u;
				uint fragment_unnamed_142 = 2u & 31u;
				uint fragment_unnamed_148 = 0u & 31u;
				bool fragment_unnamed_231 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_263 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_273 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_284 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_291 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_298 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_322 = asfloat(fragment_unnamed_273 ? asuint(mad((fragment_unnamed_231 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_8.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_8.x, fragment_input_8.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_8.x) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)) : asuint(mad(mad(fragment_unnamed_284, fragment_input_6.x, fragment_unnamed_263 * fragment_input_7.x) + mad(fragment_unnamed_298, fragment_input_4.x, fragment_unnamed_291 * fragment_input_5.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_324 = asfloat(fragment_unnamed_273 ? asuint(mad((fragment_unnamed_231 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_8.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_8.x, fragment_input_8.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_8.z) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)) : asuint(mad(mad(fragment_unnamed_284, fragment_input_6.y, fragment_unnamed_263 * fragment_input_7.y) + mad(fragment_unnamed_298, fragment_input_4.y, fragment_unnamed_291 * fragment_input_5.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				discard_cond(mad(fragment_uniform_buffer_2[2u].w, _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_322, fragment_unnamed_324), fragment_uniform_buffer_0[86u].y).w, (-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_47[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_142, min((2u & 31u), (32u - fragment_unnamed_142))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_148, min((2u & 31u), (32u - fragment_unnamed_148))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[15u].y) + 2.0f))) < 0.0f);
				float fragment_unnamed_362 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_363 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_409 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_409 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_362) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_362)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_409 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_363) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_363)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				fragment_uniform_buffer_2[2] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], _UVBase, fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], _WorldMapping, fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], _TexWorldScale);

				fragment_uniform_buffer_2[9] = float4(_BaseColorMap_TO[0], _BaseColorMap_TO[1], _BaseColorMap_TO[2], _BaseColorMap_TO[3]);

				fragment_uniform_buffer_2[15] = float4(fragment_uniform_buffer_2[15][0], _Fade, fragment_uniform_buffer_2[15][2], fragment_uniform_buffer_2[15][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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

			#endif // defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _WorldSpaceCameraPos_Internal;
			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4 unity_RenderingLayer;
			float4 _BaseColor;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[16];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 gl_FragCoord;
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
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
			};

			static bool discard_state;

			uint spvBitfieldInsert(uint Base, uint Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint2 spvBitfieldInsert(uint2 Base, uint2 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint3 spvBitfieldInsert(uint3 Base, uint3 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint4 spvBitfieldInsert(uint4 Base, uint4 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

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

			void discard_cond(bool fragment_unnamed_447)
			{
				if (fragment_unnamed_447)
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
				uint fragment_unnamed_48[64];
				fragment_unnamed_48[0u] = 1030811889u;
				fragment_unnamed_48[4u] = 1057458056u;
				fragment_unnamed_48[8u] = 1043641525u;
				fragment_unnamed_48[12u] = 1059431846u;
				fragment_unnamed_48[16u] = 1061405636u;
				fragment_unnamed_48[20u] = 1050056343u;
				fragment_unnamed_48[24u] = 1063379426u;
				fragment_unnamed_48[28u] = 1054003923u;
				fragment_unnamed_48[32u] = 1047589105u;
				fragment_unnamed_48[36u] = 1060418741u;
				fragment_unnamed_48[40u] = 1039200497u;
				fragment_unnamed_48[44u] = 1058444951u;
				fragment_unnamed_48[48u] = 1064366321u;
				fragment_unnamed_48[52u] = 1055977713u;
				fragment_unnamed_48[56u] = 1062392531u;
				fragment_unnamed_48[60u] = 1052030133u;
				uint fragment_unnamed_143 = 2u & 31u;
				uint fragment_unnamed_149 = 0u & 31u;
				bool fragment_unnamed_232 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_264 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_274 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_285 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_292 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_299 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_323 = asfloat(fragment_unnamed_274 ? asuint(mad((fragment_unnamed_232 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_8.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_8.x, fragment_input_8.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_8.x) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)) : asuint(mad(mad(fragment_unnamed_285, fragment_input_6.x, fragment_unnamed_264 * fragment_input_7.x) + mad(fragment_unnamed_299, fragment_input_4.x, fragment_unnamed_292 * fragment_input_5.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_325 = asfloat(fragment_unnamed_274 ? asuint(mad((fragment_unnamed_232 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_8.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_8.x, fragment_input_8.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_8.z) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)) : asuint(mad(mad(fragment_unnamed_285, fragment_input_6.y, fragment_unnamed_264 * fragment_input_7.y) + mad(fragment_unnamed_299, fragment_input_4.y, fragment_unnamed_292 * fragment_input_5.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				discard_cond(mad(fragment_uniform_buffer_2[2u].w, _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_323, fragment_unnamed_325), fragment_uniform_buffer_0[86u].y).w, (-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_48[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_143, min((2u & 31u), (32u - fragment_unnamed_143))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_149, min((2u & 31u), (32u - fragment_unnamed_149))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[15u].y) + 2.0f))) < 0.0f);
				float fragment_unnamed_363 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_364 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_410 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_410 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_363) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_363)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_410 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_364) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_364)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				uint fragment_unnamed_426 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_426, min((8u & 31u), (32u - fragment_unnamed_426)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = 0.5f;
				fragment_output_1.w = 0.5f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[2] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], _UVBase, fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], _WorldMapping, fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], _TexWorldScale);

				fragment_uniform_buffer_2[9] = float4(_BaseColorMap_TO[0], _BaseColorMap_TO[1], _BaseColorMap_TO[2], _BaseColorMap_TO[3]);

				fragment_uniform_buffer_2[15] = float4(fragment_uniform_buffer_2[15][0], _Fade, fragment_uniform_buffer_2[15][2], fragment_uniform_buffer_2[15][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _WorldSpaceCameraPos_Internal;
			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4 unity_RenderingLayer;
			float4 _BaseColor;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[16];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 gl_FragCoord;
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
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
			};

			static bool discard_state;

			uint spvBitfieldInsert(uint Base, uint Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint2 spvBitfieldInsert(uint2 Base, uint2 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint3 spvBitfieldInsert(uint3 Base, uint3 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint4 spvBitfieldInsert(uint4 Base, uint4 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

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

			void discard_cond(bool fragment_unnamed_500)
			{
				if (fragment_unnamed_500)
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
				uint fragment_unnamed_48[64];
				fragment_unnamed_48[0u] = 1030811889u;
				fragment_unnamed_48[4u] = 1057458056u;
				fragment_unnamed_48[8u] = 1043641525u;
				fragment_unnamed_48[12u] = 1059431846u;
				fragment_unnamed_48[16u] = 1061405636u;
				fragment_unnamed_48[20u] = 1050056343u;
				fragment_unnamed_48[24u] = 1063379426u;
				fragment_unnamed_48[28u] = 1054003923u;
				fragment_unnamed_48[32u] = 1047589105u;
				fragment_unnamed_48[36u] = 1060418741u;
				fragment_unnamed_48[40u] = 1039200497u;
				fragment_unnamed_48[44u] = 1058444951u;
				fragment_unnamed_48[48u] = 1064366321u;
				fragment_unnamed_48[52u] = 1055977713u;
				fragment_unnamed_48[56u] = 1062392531u;
				fragment_unnamed_48[60u] = 1052030133u;
				uint fragment_unnamed_143 = 2u & 31u;
				uint fragment_unnamed_149 = 0u & 31u;
				bool fragment_unnamed_232 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_264 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_274 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_285 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_292 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_299 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_323 = asfloat(fragment_unnamed_274 ? asuint(mad((fragment_unnamed_232 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_8.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_8.x, fragment_input_8.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_8.x) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)) : asuint(mad(mad(fragment_unnamed_285, fragment_input_6.x, fragment_unnamed_264 * fragment_input_7.x) + mad(fragment_unnamed_299, fragment_input_4.x, fragment_unnamed_292 * fragment_input_5.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_325 = asfloat(fragment_unnamed_274 ? asuint(mad((fragment_unnamed_232 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_8.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_8.x, fragment_input_8.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_8.z) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)) : asuint(mad(mad(fragment_unnamed_285, fragment_input_6.y, fragment_unnamed_264 * fragment_input_7.y) + mad(fragment_unnamed_299, fragment_input_4.y, fragment_unnamed_292 * fragment_input_5.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				discard_cond(mad(fragment_uniform_buffer_2[2u].w, _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_323, fragment_unnamed_325), fragment_uniform_buffer_0[86u].y).w, (-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_48[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_143, min((2u & 31u), (32u - fragment_unnamed_143))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_149, min((2u & 31u), (32u - fragment_unnamed_149))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[15u].y) + 2.0f))) < 0.0f);
				float fragment_unnamed_363 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_364 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_410 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_410 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_363) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_363)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_410 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_364) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_364)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_437 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_444 = fragment_unnamed_437 * fragment_input_9.x;
				float fragment_unnamed_445 = fragment_unnamed_437 * fragment_input_9.y;
				float fragment_unnamed_446 = fragment_unnamed_437 * fragment_input_9.z;
				float fragment_unnamed_455 = 1.0f / max(dot(float3(abs(fragment_unnamed_444), abs(fragment_unnamed_445), abs(fragment_unnamed_446)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_460 = clamp((-0.0f) - (fragment_unnamed_455 * fragment_unnamed_446), 0.0f, 1.0f);
				float fragment_unnamed_463 = (-0.0f) - fragment_unnamed_460;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_444, fragment_unnamed_455, ((fragment_unnamed_455 * fragment_unnamed_444) >= 0.0f) ? fragment_unnamed_460 : fragment_unnamed_463), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_445, fragment_unnamed_455, ((fragment_unnamed_455 * fragment_unnamed_445) >= 0.0f) ? fragment_unnamed_460 : fragment_unnamed_463), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_481 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_481, min((8u & 31u), (32u - fragment_unnamed_481)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[2] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], _UVBase, fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], _WorldMapping, fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], _TexWorldScale);

				fragment_uniform_buffer_2[9] = float4(_BaseColorMap_TO[0], _BaseColorMap_TO[1], _BaseColorMap_TO[2], _BaseColorMap_TO[3]);

				fragment_uniform_buffer_2[15] = float4(fragment_uniform_buffer_2[15][0], _Fade, fragment_uniform_buffer_2[15][2], fragment_uniform_buffer_2[15][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && !defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON) && !defined(_DISABLE_DECALS)


			#if defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _WorldSpaceCameraPos_Internal;
			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4 _BaseColor;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[16];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 gl_FragCoord;
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
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			uint spvBitfieldInsert(uint Base, uint Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint2 spvBitfieldInsert(uint2 Base, uint2 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint3 spvBitfieldInsert(uint3 Base, uint3 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint4 spvBitfieldInsert(uint4 Base, uint4 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			void discard_cond(bool fragment_unnamed_420)
			{
				if (fragment_unnamed_420)
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
				uint fragment_unnamed_47[64];
				fragment_unnamed_47[0u] = 1030811889u;
				fragment_unnamed_47[4u] = 1057458056u;
				fragment_unnamed_47[8u] = 1043641525u;
				fragment_unnamed_47[12u] = 1059431846u;
				fragment_unnamed_47[16u] = 1061405636u;
				fragment_unnamed_47[20u] = 1050056343u;
				fragment_unnamed_47[24u] = 1063379426u;
				fragment_unnamed_47[28u] = 1054003923u;
				fragment_unnamed_47[32u] = 1047589105u;
				fragment_unnamed_47[36u] = 1060418741u;
				fragment_unnamed_47[40u] = 1039200497u;
				fragment_unnamed_47[44u] = 1058444951u;
				fragment_unnamed_47[48u] = 1064366321u;
				fragment_unnamed_47[52u] = 1055977713u;
				fragment_unnamed_47[56u] = 1062392531u;
				fragment_unnamed_47[60u] = 1052030133u;
				uint fragment_unnamed_142 = 2u & 31u;
				uint fragment_unnamed_148 = 0u & 31u;
				bool fragment_unnamed_231 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_263 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_273 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_284 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_291 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_298 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_322 = asfloat(fragment_unnamed_273 ? asuint(mad((fragment_unnamed_231 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_8.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_8.x, fragment_input_8.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_8.x) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)) : asuint(mad(mad(fragment_unnamed_284, fragment_input_6.x, fragment_unnamed_263 * fragment_input_7.x) + mad(fragment_unnamed_298, fragment_input_4.x, fragment_unnamed_291 * fragment_input_5.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_324 = asfloat(fragment_unnamed_273 ? asuint(mad((fragment_unnamed_231 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_8.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_8.x, fragment_input_8.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_8.z) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)) : asuint(mad(mad(fragment_unnamed_284, fragment_input_6.y, fragment_unnamed_263 * fragment_input_7.y) + mad(fragment_unnamed_298, fragment_input_4.y, fragment_unnamed_291 * fragment_input_5.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				discard_cond(mad(fragment_uniform_buffer_2[2u].w, _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_322, fragment_unnamed_324), fragment_uniform_buffer_0[86u].y).w, (-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_47[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_142, min((2u & 31u), (32u - fragment_unnamed_142))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_148, min((2u & 31u), (32u - fragment_unnamed_148))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[15u].y) + 2.0f))) < 0.0f);
				float fragment_unnamed_362 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_363 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_409 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_409 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_362) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_362)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_409 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_363) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_363)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				fragment_uniform_buffer_2[2] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], _UVBase, fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], _WorldMapping, fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], _TexWorldScale);

				fragment_uniform_buffer_2[9] = float4(_BaseColorMap_TO[0], _BaseColorMap_TO[1], _BaseColorMap_TO[2], _BaseColorMap_TO[3]);

				fragment_uniform_buffer_2[15] = float4(fragment_uniform_buffer_2[15][0], _Fade, fragment_uniform_buffer_2[15][2], fragment_uniform_buffer_2[15][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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

			#endif // defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


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
			Name "TransparentDepthPrepass"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "TransparentDepthPrepass" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
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
			GpuProgramID 357720

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ _DISABLE_DECALS
			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT


			#if defined(_DISABLE_DECALS) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _WorldSpaceCameraPos_Internal;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4 unity_WorldTransformParams;
			float _SmoothnessRemapMin;
			float _SmoothnessRemapMax;
			float _NormalScale;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _EnableDetail;
			float _UVDetail;
			float _LinkDetailsWithBase;
			float _DetailNormalScale;
			float _DetailSmoothnessScale;
			float4 _DetailMap_TO;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			static float4 fragment_uniform_buffer_2[15];
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _DetailMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_DetailMap;

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

			void frag_main()
			{
				float fragment_unnamed_74 = asfloat(((fragment_uniform_buffer_2[12u].x == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_76 = asfloat(((fragment_uniform_buffer_2[12u].x == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_78 = asfloat(((fragment_uniform_buffer_2[12u].x == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_80 = asfloat(((fragment_uniform_buffer_2[12u].x == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_135 = 0.0f != fragment_uniform_buffer_2[12u].y;
				uint4 fragment_unnamed_143 = asuint(fragment_uniform_buffer_2[14u]);
				bool fragment_unnamed_227 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_237 = (fragment_unnamed_227 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_6.x) * fragment_uniform_buffer_2[8u].w;
				float fragment_unnamed_238 = (fragment_unnamed_227 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_6.z) * fragment_uniform_buffer_2[8u].w;
				float fragment_unnamed_247 = mad(fragment_unnamed_237, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z);
				float fragment_unnamed_248 = mad(fragment_unnamed_238, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w);
				bool fragment_unnamed_270 = fragment_uniform_buffer_2[8u].y < 4.0f;
				float4 fragment_unnamed_286 = _DetailMap.SampleBias(sampler_DetailMap, float2(asfloat(fragment_unnamed_270 ? asuint(mad(mad(fragment_unnamed_78, fragment_input_4.x, fragment_unnamed_80 * fragment_input_5.x) + mad(fragment_unnamed_74, fragment_input_2.x, fragment_unnamed_76 * fragment_input_3.x), asfloat(fragment_unnamed_135 ? asuint(fragment_uniform_buffer_2[9u].x * fragment_uniform_buffer_2[14u].x) : fragment_unnamed_143.x), asfloat(fragment_unnamed_135 ? asuint(fragment_uniform_buffer_2[9u].z + fragment_uniform_buffer_2[14u].z) : fragment_unnamed_143.z))) : asuint(mad(asfloat(fragment_unnamed_135 ? asuint(fragment_unnamed_247) : asuint(fragment_unnamed_237)), fragment_uniform_buffer_2[14u].x, fragment_uniform_buffer_2[14u].z))), asfloat(fragment_unnamed_270 ? asuint(mad(mad(fragment_unnamed_78, fragment_input_4.y, fragment_unnamed_80 * fragment_input_5.y) + mad(fragment_unnamed_74, fragment_input_2.y, fragment_unnamed_76 * fragment_input_3.y), asfloat(fragment_unnamed_135 ? asuint(fragment_uniform_buffer_2[9u].y * fragment_uniform_buffer_2[14u].y) : fragment_unnamed_143.y), asfloat(fragment_unnamed_135 ? asuint(fragment_uniform_buffer_2[9u].w + fragment_uniform_buffer_2[14u].w) : fragment_unnamed_143.w))) : asuint(mad(asfloat(fragment_unnamed_135 ? asuint(fragment_unnamed_248) : asuint(fragment_unnamed_238)), fragment_uniform_buffer_2[14u].y, fragment_uniform_buffer_2[14u].w)))), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_292 = mad(fragment_unnamed_286.w, 2.0f, -1.0f);
				float fragment_unnamed_294 = mad(fragment_unnamed_286.y, 2.0f, -1.0f);
				float fragment_unnamed_295 = mad(fragment_unnamed_286.z, 2.0f, -1.0f);
				float fragment_unnamed_303 = sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_292, fragment_unnamed_294), float2(fragment_unnamed_292, fragment_unnamed_294)), 1.0f)) + 1.0f);
				float fragment_unnamed_307 = rsqrt(dot(float3(fragment_unnamed_292, fragment_unnamed_294, fragment_unnamed_303), float3(fragment_unnamed_292, fragment_unnamed_294, fragment_unnamed_303)));
				float fragment_unnamed_317 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_327 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_335 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_337 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_339 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_375 = asfloat(fragment_unnamed_327 ? asuint(fragment_unnamed_247) : asuint(mad(mad(fragment_unnamed_339, fragment_input_4.x, fragment_unnamed_317 * fragment_input_5.x) + mad(fragment_unnamed_335, fragment_input_2.x, fragment_unnamed_337 * fragment_input_3.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_377 = asfloat(fragment_unnamed_327 ? asuint(fragment_unnamed_248) : asuint(mad(mad(fragment_unnamed_339, fragment_input_4.y, fragment_unnamed_317 * fragment_input_5.y) + mad(fragment_unnamed_335, fragment_input_2.y, fragment_unnamed_337 * fragment_input_3.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				float4 fragment_unnamed_382 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_unnamed_375, fragment_unnamed_377), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_384 = fragment_unnamed_382.z;
				float4 fragment_unnamed_390 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_unnamed_375, fragment_unnamed_377), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_398 = fragment_unnamed_384 * fragment_uniform_buffer_2[12u].w;
				float fragment_unnamed_403 = ((fragment_unnamed_292 * fragment_unnamed_307) * fragment_unnamed_398) * (-1.0f);
				float fragment_unnamed_404 = ((fragment_unnamed_294 * fragment_unnamed_307) * fragment_unnamed_398) * (-1.0f);
				float fragment_unnamed_405 = mad(clamp(fragment_unnamed_398, 0.0f, 1.0f), mad(fragment_unnamed_303, fragment_unnamed_307, -1.0f), 1.0f) * 1.0f;
				float fragment_unnamed_407 = mad(fragment_unnamed_390.x * fragment_unnamed_390.w, 2.0f, -1.0f);
				float fragment_unnamed_408 = mad(fragment_unnamed_390.y, 2.0f, -1.0f);
				float fragment_unnamed_412 = fragment_unnamed_407 * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_413 = fragment_unnamed_408 * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_423 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_407, fragment_unnamed_408), float2(fragment_unnamed_407, fragment_unnamed_408)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f);
				float fragment_unnamed_427 = clamp(fragment_uniform_buffer_2[8u].x, 0.0f, 1.0f);
				float fragment_unnamed_430 = fragment_unnamed_412 + 0.0f;
				float fragment_unnamed_431 = fragment_unnamed_413 + 0.0f;
				float fragment_unnamed_432 = (fragment_unnamed_423 * fragment_unnamed_427) + 2.0f;
				float fragment_unnamed_433 = dot(float3(fragment_unnamed_430, fragment_unnamed_431, fragment_unnamed_432), float3(fragment_unnamed_403, fragment_unnamed_404, fragment_unnamed_405));
				bool fragment_unnamed_448 = 0.0f != fragment_uniform_buffer_2[10u].x;
				float fragment_unnamed_456 = asfloat(fragment_unnamed_448 ? asuint(mad(fragment_unnamed_430 / fragment_unnamed_432, fragment_unnamed_433, (-0.0f) - fragment_unnamed_403)) : asuint(fragment_unnamed_412));
				float fragment_unnamed_458 = asfloat(fragment_unnamed_448 ? asuint(mad(fragment_unnamed_431 / fragment_unnamed_432, fragment_unnamed_433, (-0.0f) - fragment_unnamed_404)) : asuint(fragment_unnamed_413));
				float fragment_unnamed_460 = asfloat(fragment_unnamed_448 ? asuint(mad(fragment_unnamed_432 / fragment_unnamed_432, fragment_unnamed_433, (-0.0f) - fragment_unnamed_405)) : asuint(mad(fragment_unnamed_427, fragment_unnamed_423, 1.0f)));
				float fragment_unnamed_474 = asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u) * asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u);
				float fragment_unnamed_529 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_557 = mad(fragment_unnamed_460, fragment_unnamed_529 * fragment_input_7.x, mad(fragment_unnamed_456, fragment_unnamed_529 * fragment_input_1.x, fragment_unnamed_458 * (fragment_unnamed_529 * (fragment_unnamed_474 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z))))));
				float fragment_unnamed_558 = mad(fragment_unnamed_460, fragment_unnamed_529 * fragment_input_7.y, mad(fragment_unnamed_456, fragment_unnamed_529 * fragment_input_1.y, fragment_unnamed_458 * (fragment_unnamed_529 * (fragment_unnamed_474 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x))))));
				float fragment_unnamed_559 = mad(fragment_unnamed_460, fragment_unnamed_529 * fragment_input_7.z, mad(fragment_unnamed_456, fragment_unnamed_529 * fragment_input_1.z, fragment_unnamed_458 * (fragment_unnamed_529 * (fragment_unnamed_474 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y))))));
				float fragment_unnamed_564 = rsqrt(max(dot(float3(fragment_unnamed_557, fragment_unnamed_558, fragment_unnamed_559), float3(fragment_unnamed_557, fragment_unnamed_558, fragment_unnamed_559)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_565 = fragment_unnamed_557 * fragment_unnamed_564;
				float fragment_unnamed_566 = fragment_unnamed_558 * fragment_unnamed_564;
				float fragment_unnamed_567 = fragment_unnamed_559 * fragment_unnamed_564;
				float fragment_unnamed_569 = max(abs(fragment_unnamed_567), 0.0009765625f);
				float fragment_unnamed_573 = (fragment_unnamed_567 >= 0.0f) ? fragment_unnamed_569 : ((-0.0f) - fragment_unnamed_569);
				float fragment_unnamed_582 = 1.0f / max(dot(float3(abs(fragment_unnamed_565), abs(fragment_unnamed_566), abs(fragment_unnamed_573)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_587 = clamp((-0.0f) - (fragment_unnamed_582 * fragment_unnamed_573), 0.0f, 1.0f);
				float fragment_unnamed_590 = (-0.0f) - fragment_unnamed_587;
				uint fragment_unnamed_603 = uint(clamp(mad(mad(fragment_unnamed_565, fragment_unnamed_582, ((fragment_unnamed_582 * fragment_unnamed_565) >= 0.0f) ? fragment_unnamed_587 : fragment_unnamed_590), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_604 = uint(clamp(mad(mad(fragment_unnamed_566, fragment_unnamed_582, ((fragment_unnamed_582 * fragment_unnamed_566) >= 0.0f) ? fragment_unnamed_587 : fragment_unnamed_590), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_0.x = float(fragment_unnamed_603 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(fragment_unnamed_604 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_0.z = float(((fragment_unnamed_604 >> 8u) * 16u) + (fragment_unnamed_603 >> 8u)) * 0.0039215688593685626983642578125f;
				float fragment_unnamed_645 = mad(fragment_unnamed_382.w, ((-0.0f) - fragment_uniform_buffer_2[5u].y) + fragment_uniform_buffer_2[5u].z, fragment_uniform_buffer_2[5u].y);
				fragment_output_0.w = ((-0.0f) - asfloat(fragment_unnamed_448 ? asuint(mad(fragment_unnamed_384, ((-0.0f) - fragment_unnamed_645) + clamp(mad(clamp(abs(fragment_unnamed_295) * fragment_uniform_buffer_2[13u].x, 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_645) + asfloat((fragment_unnamed_295 < 0.0f) ? 0u : 1065353216u), fragment_unnamed_645), 0.0f, 1.0f), fragment_unnamed_645)) : asuint(fragment_unnamed_645))) + 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], _SmoothnessRemapMin, fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], fragment_uniform_buffer_2[5][1], _SmoothnessRemapMax, fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[8] = float4(_NormalScale, fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], _UVBase, fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], _WorldMapping, fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], _TexWorldScale);

				fragment_uniform_buffer_2[9] = float4(_BaseColorMap_TO[0], _BaseColorMap_TO[1], _BaseColorMap_TO[2], _BaseColorMap_TO[3]);

				fragment_uniform_buffer_2[10] = float4(_EnableDetail, fragment_uniform_buffer_2[10][1], fragment_uniform_buffer_2[10][2], fragment_uniform_buffer_2[10][3]);

				fragment_uniform_buffer_2[12] = float4(_UVDetail, fragment_uniform_buffer_2[12][1], fragment_uniform_buffer_2[12][2], fragment_uniform_buffer_2[12][3]);

				fragment_uniform_buffer_2[12] = float4(fragment_uniform_buffer_2[12][0], _LinkDetailsWithBase, fragment_uniform_buffer_2[12][2], fragment_uniform_buffer_2[12][3]);

				fragment_uniform_buffer_2[12] = float4(fragment_uniform_buffer_2[12][0], fragment_uniform_buffer_2[12][1], fragment_uniform_buffer_2[12][2], _DetailNormalScale);

				fragment_uniform_buffer_2[13] = float4(_DetailSmoothnessScale, fragment_uniform_buffer_2[13][1], fragment_uniform_buffer_2[13][2], fragment_uniform_buffer_2[13][3]);

				fragment_uniform_buffer_2[14] = float4(_DetailMap_TO[0], _DetailMap_TO[1], _DetailMap_TO[2], _DetailMap_TO[3]);

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

			#endif // defined(_DISABLE_DECALS) && defined(_SURFACE_TYPE_TRANSPARENT)


			#if defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

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
				float vertex_unnamed_84 = asfloat(1065353216u);
				float vertex_unnamed_86 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_84));
				float vertex_unnamed_115 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_84));
				float vertex_unnamed_145 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_84));
				vertex_output_6.x = vertex_unnamed_115;
				vertex_output_6.y = vertex_unnamed_86;
				vertex_output_6.z = vertex_unnamed_145;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_145, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_115, vertex_unnamed_86 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_145, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_115, vertex_unnamed_86 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_145, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_115, vertex_unnamed_86 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_145, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_115, vertex_unnamed_86 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_205 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_206 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_207 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_213 = rsqrt(max(dot(float3(vertex_unnamed_205, vertex_unnamed_206, vertex_unnamed_207), float3(vertex_unnamed_205, vertex_unnamed_206, vertex_unnamed_207)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_213 * vertex_unnamed_205;
				vertex_output_1.y = vertex_unnamed_213 * vertex_unnamed_206;
				vertex_output_1.z = vertex_unnamed_213 * vertex_unnamed_207;
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
				float vertex_unnamed_283 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_298 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_313 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_320 = rsqrt(max(dot(float3(vertex_unnamed_283, vertex_unnamed_298, vertex_unnamed_313), float3(vertex_unnamed_283, vertex_unnamed_298, vertex_unnamed_313)), 1.1754943508222875079687365372222e-38f));
				vertex_output_7.x = vertex_unnamed_320 * vertex_unnamed_283;
				vertex_output_7.y = vertex_unnamed_320 * vertex_unnamed_298;
				vertex_output_7.z = vertex_unnamed_320 * vertex_unnamed_313;
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

			#endif // defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_DISABLE_DECALS)


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
			Name "DepthOnly"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DepthOnly" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
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
			GpuProgramID 463400

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER
			#pragma multi_compile _ _ALPHATEST_ON
			#pragma multi_compile _ _DISABLE_DECALS


			#if !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[24];
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
				if ((((0.0f < vertex_uniform_buffer_2[23u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[23] = float4(vertex_uniform_buffer_2[23][0], vertex_uniform_buffer_2[23][1], _RayTracing, vertex_uniform_buffer_2[23][3]);

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

			#endif // !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)


			#if defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[24];
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
				if ((((0.0f < vertex_uniform_buffer_2[23u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[23] = float4(vertex_uniform_buffer_2[23][0], vertex_uniform_buffer_2[23][1], _RayTracing, vertex_uniform_buffer_2[23][3]);

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


			float4 _WorldSpaceCameraPos_Internal;
			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4 _BaseColor;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[8];
			static float4 fragment_uniform_buffer_2[16];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 gl_FragCoord;
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
				float4 gl_FragCoord : SV_Position;
			};

			static bool discard_state;

			uint spvBitfieldInsert(uint Base, uint Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint2 spvBitfieldInsert(uint2 Base, uint2 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint3 spvBitfieldInsert(uint3 Base, uint3 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint4 spvBitfieldInsert(uint4 Base, uint4 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			void discard_cond(bool fragment_unnamed_341)
			{
				if (fragment_unnamed_341)
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
				uint fragment_unnamed_43[64];
				fragment_unnamed_43[0u] = 1030811889u;
				fragment_unnamed_43[4u] = 1057458056u;
				fragment_unnamed_43[8u] = 1043641525u;
				fragment_unnamed_43[12u] = 1059431846u;
				fragment_unnamed_43[16u] = 1061405636u;
				fragment_unnamed_43[20u] = 1050056343u;
				fragment_unnamed_43[24u] = 1063379426u;
				fragment_unnamed_43[28u] = 1054003923u;
				fragment_unnamed_43[32u] = 1047589105u;
				fragment_unnamed_43[36u] = 1060418741u;
				fragment_unnamed_43[40u] = 1039200497u;
				fragment_unnamed_43[44u] = 1058444951u;
				fragment_unnamed_43[48u] = 1064366321u;
				fragment_unnamed_43[52u] = 1055977713u;
				fragment_unnamed_43[56u] = 1062392531u;
				fragment_unnamed_43[60u] = 1052030133u;
				uint fragment_unnamed_137 = 2u & 31u;
				uint fragment_unnamed_143 = 0u & 31u;
				bool fragment_unnamed_226 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_258 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_268 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_279 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_286 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_293 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_317 = asfloat(fragment_unnamed_268 ? asuint(mad((fragment_unnamed_226 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_6.x) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)) : asuint(mad(mad(fragment_unnamed_279, fragment_input_4.x, fragment_unnamed_258 * fragment_input_5.x) + mad(fragment_unnamed_293, fragment_input_2.x, fragment_unnamed_286 * fragment_input_3.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_319 = asfloat(fragment_unnamed_268 ? asuint(mad((fragment_unnamed_226 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_6.z) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)) : asuint(mad(mad(fragment_unnamed_279, fragment_input_4.y, fragment_unnamed_258 * fragment_input_5.y) + mad(fragment_unnamed_293, fragment_input_2.y, fragment_unnamed_286 * fragment_input_3.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				discard_cond(mad(fragment_uniform_buffer_2[2u].w, _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_317, fragment_unnamed_319), fragment_uniform_buffer_0[86u].y).w, (-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_43[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_137, min((2u & 31u), (32u - fragment_unnamed_137))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_143, min((2u & 31u), (32u - fragment_unnamed_143))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[15u].y) + 2.0f))) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
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
			}

			#endif // defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS)

			float4 _WorldSpaceCameraPos_Internal;
			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4 _BaseColor;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[8];
			static float4 fragment_uniform_buffer_2[16];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 gl_FragCoord;
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
				float4 gl_FragCoord : SV_Position;
			};

			static bool discard_state;

			uint spvBitfieldInsert(uint Base, uint Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint2 spvBitfieldInsert(uint2 Base, uint2 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint3 spvBitfieldInsert(uint3 Base, uint3 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint4 spvBitfieldInsert(uint4 Base, uint4 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			void discard_cond(bool fragment_unnamed_341)
			{
				if (fragment_unnamed_341)
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
				uint fragment_unnamed_43[64];
				fragment_unnamed_43[0u] = 1030811889u;
				fragment_unnamed_43[4u] = 1057458056u;
				fragment_unnamed_43[8u] = 1043641525u;
				fragment_unnamed_43[12u] = 1059431846u;
				fragment_unnamed_43[16u] = 1061405636u;
				fragment_unnamed_43[20u] = 1050056343u;
				fragment_unnamed_43[24u] = 1063379426u;
				fragment_unnamed_43[28u] = 1054003923u;
				fragment_unnamed_43[32u] = 1047589105u;
				fragment_unnamed_43[36u] = 1060418741u;
				fragment_unnamed_43[40u] = 1039200497u;
				fragment_unnamed_43[44u] = 1058444951u;
				fragment_unnamed_43[48u] = 1064366321u;
				fragment_unnamed_43[52u] = 1055977713u;
				fragment_unnamed_43[56u] = 1062392531u;
				fragment_unnamed_43[60u] = 1052030133u;
				uint fragment_unnamed_137 = 2u & 31u;
				uint fragment_unnamed_143 = 0u & 31u;
				bool fragment_unnamed_226 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_258 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_268 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_279 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_286 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_293 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_317 = asfloat(fragment_unnamed_268 ? asuint(mad((fragment_unnamed_226 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_6.x) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)) : asuint(mad(mad(fragment_unnamed_279, fragment_input_4.x, fragment_unnamed_258 * fragment_input_5.x) + mad(fragment_unnamed_293, fragment_input_2.x, fragment_unnamed_286 * fragment_input_3.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_319 = asfloat(fragment_unnamed_268 ? asuint(mad((fragment_unnamed_226 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_6.z) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)) : asuint(mad(mad(fragment_unnamed_279, fragment_input_4.y, fragment_unnamed_258 * fragment_input_5.y) + mad(fragment_unnamed_293, fragment_input_2.y, fragment_unnamed_286 * fragment_input_3.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				discard_cond(mad(fragment_uniform_buffer_2[2u].w, _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_317, fragment_unnamed_319), fragment_uniform_buffer_0[86u].y).w, (-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_43[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_137, min((2u & 31u), (32u - fragment_unnamed_137))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_143, min((2u & 31u), (32u - fragment_unnamed_143))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[15u].y) + 2.0f))) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
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
			}

			#endif // defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER) && defined(_DISABLE_DECALS) && !defined(_ALPHATEST_ON)

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

			#endif // defined(WRITE_DECAL_BUFFER) && defined(_DISABLE_DECALS) && !defined(_ALPHATEST_ON)


			#if defined(_DISABLE_DECALS) && !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)

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

			#endif // defined(_DISABLE_DECALS) && !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER)

			float4 _WorldSpaceCameraPos_Internal;
			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4 _BaseColor;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[8];
			static float4 fragment_uniform_buffer_2[16];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 gl_FragCoord;
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
				float4 gl_FragCoord : SV_Position;
			};

			static bool discard_state;

			uint spvBitfieldInsert(uint Base, uint Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint2 spvBitfieldInsert(uint2 Base, uint2 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint3 spvBitfieldInsert(uint3 Base, uint3 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint4 spvBitfieldInsert(uint4 Base, uint4 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			void discard_cond(bool fragment_unnamed_341)
			{
				if (fragment_unnamed_341)
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
				uint fragment_unnamed_43[64];
				fragment_unnamed_43[0u] = 1030811889u;
				fragment_unnamed_43[4u] = 1057458056u;
				fragment_unnamed_43[8u] = 1043641525u;
				fragment_unnamed_43[12u] = 1059431846u;
				fragment_unnamed_43[16u] = 1061405636u;
				fragment_unnamed_43[20u] = 1050056343u;
				fragment_unnamed_43[24u] = 1063379426u;
				fragment_unnamed_43[28u] = 1054003923u;
				fragment_unnamed_43[32u] = 1047589105u;
				fragment_unnamed_43[36u] = 1060418741u;
				fragment_unnamed_43[40u] = 1039200497u;
				fragment_unnamed_43[44u] = 1058444951u;
				fragment_unnamed_43[48u] = 1064366321u;
				fragment_unnamed_43[52u] = 1055977713u;
				fragment_unnamed_43[56u] = 1062392531u;
				fragment_unnamed_43[60u] = 1052030133u;
				uint fragment_unnamed_137 = 2u & 31u;
				uint fragment_unnamed_143 = 0u & 31u;
				bool fragment_unnamed_226 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_258 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_268 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_279 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_286 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_293 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_317 = asfloat(fragment_unnamed_268 ? asuint(mad((fragment_unnamed_226 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_6.x) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)) : asuint(mad(mad(fragment_unnamed_279, fragment_input_4.x, fragment_unnamed_258 * fragment_input_5.x) + mad(fragment_unnamed_293, fragment_input_2.x, fragment_unnamed_286 * fragment_input_3.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_319 = asfloat(fragment_unnamed_268 ? asuint(mad((fragment_unnamed_226 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_6.z) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)) : asuint(mad(mad(fragment_unnamed_279, fragment_input_4.y, fragment_unnamed_258 * fragment_input_5.y) + mad(fragment_unnamed_293, fragment_input_2.y, fragment_unnamed_286 * fragment_input_3.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				discard_cond(mad(fragment_uniform_buffer_2[2u].w, _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_317, fragment_unnamed_319), fragment_uniform_buffer_0[86u].y).w, (-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_43[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_137, min((2u & 31u), (32u - fragment_unnamed_137))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_143, min((2u & 31u), (32u - fragment_unnamed_143))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[15u].y) + 2.0f))) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
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
			}

			#endif // defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER)


			#if defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON) && !defined(_DISABLE_DECALS)

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

			#endif // defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON) && !defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && !defined(_DISABLE_DECALS)

			float4 _WorldSpaceCameraPos_Internal;
			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4x4 unity_WorldToObject;
			float4 unity_RenderingLayer;
			float4 _BaseColor;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			static float4 fragment_uniform_buffer_2[16];
			Texture2D<float4> _BaseColorMap;
			SamplerState sampler_BaseColorMap;

			static float4 gl_FragCoord;
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
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			uint spvBitfieldInsert(uint Base, uint Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint2 spvBitfieldInsert(uint2 Base, uint2 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint3 spvBitfieldInsert(uint3 Base, uint3 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

			uint4 spvBitfieldInsert(uint4 Base, uint4 Insert, uint Offset, uint Count)
			{
				uint Mask = Count == 32 ? 0xffffffff : (((1u << Count) - 1) << (Offset & 31));
				return (Base & ~Mask) | ((Insert << Offset) & Mask);
			}

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

			void discard_cond(bool fragment_unnamed_426)
			{
				if (fragment_unnamed_426)
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
				uint fragment_unnamed_45[64];
				fragment_unnamed_45[0u] = 1030811889u;
				fragment_unnamed_45[4u] = 1057458056u;
				fragment_unnamed_45[8u] = 1043641525u;
				fragment_unnamed_45[12u] = 1059431846u;
				fragment_unnamed_45[16u] = 1061405636u;
				fragment_unnamed_45[20u] = 1050056343u;
				fragment_unnamed_45[24u] = 1063379426u;
				fragment_unnamed_45[28u] = 1054003923u;
				fragment_unnamed_45[32u] = 1047589105u;
				fragment_unnamed_45[36u] = 1060418741u;
				fragment_unnamed_45[40u] = 1039200497u;
				fragment_unnamed_45[44u] = 1058444951u;
				fragment_unnamed_45[48u] = 1064366321u;
				fragment_unnamed_45[52u] = 1055977713u;
				fragment_unnamed_45[56u] = 1062392531u;
				fragment_unnamed_45[60u] = 1052030133u;
				uint fragment_unnamed_140 = 2u & 31u;
				uint fragment_unnamed_146 = 0u & 31u;
				bool fragment_unnamed_229 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_261 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				bool fragment_unnamed_271 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_282 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_289 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_296 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_320 = asfloat(fragment_unnamed_271 ? asuint(mad((fragment_unnamed_229 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_6.x) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)) : asuint(mad(mad(fragment_unnamed_282, fragment_input_4.x, fragment_unnamed_261 * fragment_input_5.x) + mad(fragment_unnamed_296, fragment_input_2.x, fragment_unnamed_289 * fragment_input_3.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_322 = asfloat(fragment_unnamed_271 ? asuint(mad((fragment_unnamed_229 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_6.z) * fragment_uniform_buffer_2[8u].w, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)) : asuint(mad(mad(fragment_unnamed_282, fragment_input_4.y, fragment_unnamed_261 * fragment_input_5.y) + mad(fragment_unnamed_296, fragment_input_2.y, fragment_unnamed_289 * fragment_input_3.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				discard_cond(mad(fragment_uniform_buffer_2[2u].w, _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_320, fragment_unnamed_322), fragment_uniform_buffer_0[86u].y).w, (-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_45[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_140, min((2u & 31u), (32u - fragment_unnamed_140))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_146, min((2u & 31u), (32u - fragment_unnamed_146))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[15u].y) + 2.0f))) < 0.0f);
				float fragment_unnamed_360 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_367 = fragment_unnamed_360 * fragment_input_7.x;
				float fragment_unnamed_368 = fragment_unnamed_360 * fragment_input_7.y;
				float fragment_unnamed_369 = fragment_unnamed_360 * fragment_input_7.z;
				float fragment_unnamed_378 = 1.0f / max(dot(float3(abs(fragment_unnamed_367), abs(fragment_unnamed_368), abs(fragment_unnamed_369)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_383 = clamp((-0.0f) - (fragment_unnamed_378 * fragment_unnamed_369), 0.0f, 1.0f);
				float fragment_unnamed_386 = (-0.0f) - fragment_unnamed_383;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_367, fragment_unnamed_378, ((fragment_unnamed_378 * fragment_unnamed_367) >= 0.0f) ? fragment_unnamed_383 : fragment_unnamed_386), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_368, fragment_unnamed_378, ((fragment_unnamed_378 * fragment_unnamed_368) >= 0.0f) ? fragment_unnamed_383 : fragment_unnamed_386), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_407 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_407, min((8u & 31u), (32u - fragment_unnamed_407)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[2] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], _UVBase, fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], _WorldMapping, fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], _TexWorldScale);

				fragment_uniform_buffer_2[9] = float4(_BaseColorMap_TO[0], _BaseColorMap_TO[1], _BaseColorMap_TO[2], _BaseColorMap_TO[3]);

				fragment_uniform_buffer_2[15] = float4(fragment_uniform_buffer_2[15][0], _Fade, fragment_uniform_buffer_2[15][2], fragment_uniform_buffer_2[15][3]);

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
				return stage_output;
			}

			#endif // defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && !defined(_DISABLE_DECALS)


			ENDHLSL
		}
		Pass
		{
			Name "GBuffer"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "GBuffer" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
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
			GpuProgramID 575785

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature DECALS_3RT
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DISABLE_DECALS
			#pragma shader_feature _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
			#pragma shader_feature _MATERIAL_FEATURE_TRANSMISSION


			#if !defined(_ALPHATEST_ON) && !defined(DECALS_3RT) && !defined(_DISABLE_DECALS) && !defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_MATERIAL_FEATURE_TRANSMISSION)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[24];
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
				if ((((0.0f < vertex_uniform_buffer_2[23u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[23] = float4(vertex_uniform_buffer_2[23][0], vertex_uniform_buffer_2[23][1], _RayTracing, vertex_uniform_buffer_2[23][3]);

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

			#endif // !defined(_ALPHATEST_ON) && !defined(DECALS_3RT) && !defined(_DISABLE_DECALS) && !defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_MATERIAL_FEATURE_TRANSMISSION)


			#if defined(_ALPHATEST_ON) && !defined(DECALS_3RT) && !defined(_DISABLE_DECALS) && !defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_MATERIAL_FEATURE_TRANSMISSION)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[24];
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
				if ((((0.0f < vertex_uniform_buffer_2[23u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[23] = float4(vertex_uniform_buffer_2[23][0], vertex_uniform_buffer_2[23][1], _RayTracing, vertex_uniform_buffer_2[23][3]);

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

			#endif // defined(_ALPHATEST_ON) && !defined(DECALS_3RT) && !defined(_DISABLE_DECALS) && !defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_MATERIAL_FEATURE_TRANSMISSION)


			#if defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && defined(_MATERIAL_FEATURE_TRANSMISSION)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _ReplaceDiffuseForIndirect;
			float4 _ShapeParamsAndMaxScatterDists[16];
			float4 _TransmissionTintsAndFresnel0[16];
			float4 _WorldScalesAndFilterRadiiAndThicknessRemaps[16];
			float4 _DualLobeAndDiffusePower[16];
			int4 _DiffusionProfileHashTable[16];
			int _EnableSubsurfaceScattering;
			int _TexturingModeFlags;
			int _TransmissionFlags;
			int _DiffusionProfileCount;
			float4x4 unity_WorldToObject;
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
			float _DiffusionProfileHash;
			float _Thickness;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[16];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _DetailMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_DetailMap;

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
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
				float4 fragment_output_1 : SV_Target1;
				float4 fragment_output_2 : SV_Target2;
				float4 fragment_output_3 : SV_Target3;
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
				float fragment_unnamed_94 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_114 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_170 = fragment_unnamed_94 * fragment_input_7.x;
				float fragment_unnamed_171 = fragment_unnamed_94 * fragment_input_7.y;
				float fragment_unnamed_172 = fragment_unnamed_94 * fragment_input_7.z;
				float fragment_unnamed_173 = fragment_unnamed_94 * fragment_input_7.z;
				bool fragment_unnamed_178 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_204 = asfloat(fragment_unnamed_178 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_211 = asfloat(fragment_unnamed_178 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_218 = asfloat(fragment_unnamed_178 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_222 = rsqrt(dot(float3(fragment_unnamed_204, fragment_unnamed_211, fragment_unnamed_218), float3(fragment_unnamed_204, fragment_unnamed_211, fragment_unnamed_218)));
				bool fragment_unnamed_294 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_304 = (fragment_unnamed_294 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_6.x) * fragment_uniform_buffer_2[8u].w;
				float fragment_unnamed_305 = (fragment_unnamed_294 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_6.z) * fragment_uniform_buffer_2[8u].w;
				float fragment_unnamed_314 = mad(fragment_unnamed_304, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z);
				float fragment_unnamed_315 = mad(fragment_unnamed_305, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w);
				bool fragment_unnamed_319 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_330 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_332 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_334 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_354 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_384 = asfloat(fragment_unnamed_319 ? asuint(fragment_unnamed_314) : asuint(mad(mad(fragment_unnamed_330, fragment_input_2.x, fragment_unnamed_332 * fragment_input_3.x) + mad(fragment_unnamed_334, fragment_input_4.x, fragment_unnamed_354 * fragment_input_5.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_386 = asfloat(fragment_unnamed_319 ? asuint(fragment_unnamed_315) : asuint(mad(mad(fragment_unnamed_330, fragment_input_2.y, fragment_unnamed_332 * fragment_input_3.y) + mad(fragment_unnamed_334, fragment_input_4.y, fragment_unnamed_354 * fragment_input_5.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				float4 fragment_unnamed_393 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_384, fragment_unnamed_386), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_396 = fragment_unnamed_393.x;
				float fragment_unnamed_397 = fragment_unnamed_393.y;
				float fragment_unnamed_398 = fragment_unnamed_393.z;
				float fragment_unnamed_404 = fragment_unnamed_396 * fragment_uniform_buffer_2[2u].x;
				float fragment_unnamed_405 = fragment_unnamed_397 * fragment_uniform_buffer_2[2u].y;
				float fragment_unnamed_406 = fragment_unnamed_398 * fragment_uniform_buffer_2[2u].z;
				bool fragment_unnamed_410 = fragment_uniform_buffer_2[8u].y < 4.0f;
				bool fragment_unnamed_436 = 0.0f != fragment_uniform_buffer_2[12u].y;
				uint4 fragment_unnamed_443 = asuint(fragment_uniform_buffer_2[14u]);
				float fragment_unnamed_468 = asfloat(((fragment_uniform_buffer_2[12u].x == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_470 = asfloat(((fragment_uniform_buffer_2[12u].x == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_472 = asfloat(((fragment_uniform_buffer_2[12u].x == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_474 = asfloat(((fragment_uniform_buffer_2[12u].x == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				float4 fragment_unnamed_533 = _DetailMap.SampleBias(sampler_DetailMap, float2(asfloat(fragment_unnamed_410 ? asuint(mad(mad(fragment_unnamed_468, fragment_input_2.x, fragment_unnamed_470 * fragment_input_3.x) + mad(fragment_unnamed_472, fragment_input_4.x, fragment_unnamed_474 * fragment_input_5.x), asfloat(fragment_unnamed_436 ? asuint(fragment_uniform_buffer_2[9u].x * fragment_uniform_buffer_2[14u].x) : fragment_unnamed_443.x), asfloat(fragment_unnamed_436 ? asuint(fragment_uniform_buffer_2[9u].z + fragment_uniform_buffer_2[14u].z) : fragment_unnamed_443.z))) : asuint(mad(asfloat(fragment_unnamed_436 ? asuint(fragment_unnamed_314) : asuint(fragment_unnamed_304)), fragment_uniform_buffer_2[14u].x, fragment_uniform_buffer_2[14u].z))), asfloat(fragment_unnamed_410 ? asuint(mad(mad(fragment_unnamed_468, fragment_input_2.y, fragment_unnamed_470 * fragment_input_3.y) + mad(fragment_unnamed_472, fragment_input_4.y, fragment_unnamed_474 * fragment_input_5.y), asfloat(fragment_unnamed_436 ? asuint(fragment_uniform_buffer_2[9u].y * fragment_uniform_buffer_2[14u].y) : fragment_unnamed_443.y), asfloat(fragment_unnamed_436 ? asuint(fragment_uniform_buffer_2[9u].w + fragment_uniform_buffer_2[14u].w) : fragment_unnamed_443.w))) : asuint(mad(asfloat(fragment_unnamed_436 ? asuint(fragment_unnamed_315) : asuint(fragment_unnamed_305)), fragment_uniform_buffer_2[14u].y, fragment_uniform_buffer_2[14u].w)))), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_539 = mad(fragment_unnamed_533.w, 2.0f, -1.0f);
				float fragment_unnamed_541 = mad(fragment_unnamed_533.y, 2.0f, -1.0f);
				float fragment_unnamed_542 = mad(fragment_unnamed_533.x, 2.0f, -1.0f);
				float fragment_unnamed_543 = mad(fragment_unnamed_533.z, 2.0f, -1.0f);
				float4 fragment_unnamed_548 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_unnamed_384, fragment_unnamed_386), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_551 = fragment_unnamed_548.z;
				float fragment_unnamed_553 = sqrt(fragment_unnamed_404);
				float fragment_unnamed_554 = sqrt(fragment_unnamed_405);
				float fragment_unnamed_555 = sqrt(fragment_unnamed_406);
				float fragment_unnamed_559 = asfloat((fragment_unnamed_542 < 0.0f) ? 0u : 1065353216u);
				float fragment_unnamed_567 = clamp(abs(fragment_unnamed_542) * fragment_uniform_buffer_2[12u].z, 0.0f, 1.0f);
				float fragment_unnamed_568 = fragment_unnamed_567 * fragment_unnamed_567;
				float fragment_unnamed_575 = mad(fragment_unnamed_568, ((-0.0f) - fragment_unnamed_553) + fragment_unnamed_559, fragment_unnamed_553);
				float fragment_unnamed_576 = mad(fragment_unnamed_568, ((-0.0f) - fragment_unnamed_554) + fragment_unnamed_559, fragment_unnamed_554);
				float fragment_unnamed_577 = mad(fragment_unnamed_568, ((-0.0f) - fragment_unnamed_555) + fragment_unnamed_559, fragment_unnamed_555);
				bool fragment_unnamed_602 = 0.0f != fragment_uniform_buffer_2[10u].x;
				uint fragment_unnamed_609 = fragment_unnamed_602 ? asuint(mad(fragment_unnamed_551, mad((-0.0f) - fragment_uniform_buffer_2[2u].x, fragment_unnamed_396, min(fragment_unnamed_575 * fragment_unnamed_575, 1.0f)), fragment_unnamed_404)) : asuint(fragment_unnamed_404);
				float fragment_unnamed_610 = asfloat(fragment_unnamed_609);
				uint fragment_unnamed_611 = fragment_unnamed_602 ? asuint(mad(fragment_unnamed_551, mad((-0.0f) - fragment_uniform_buffer_2[2u].y, fragment_unnamed_397, min(fragment_unnamed_576 * fragment_unnamed_576, 1.0f)), fragment_unnamed_405)) : asuint(fragment_unnamed_405);
				float fragment_unnamed_612 = asfloat(fragment_unnamed_611);
				uint fragment_unnamed_613 = fragment_unnamed_602 ? asuint(mad(fragment_unnamed_551, mad((-0.0f) - fragment_uniform_buffer_2[2u].z, fragment_unnamed_398, min(fragment_unnamed_577 * fragment_unnamed_577, 1.0f)), fragment_unnamed_406)) : asuint(fragment_unnamed_406);
				float fragment_unnamed_614 = asfloat(fragment_unnamed_613);
				float fragment_unnamed_626 = mad(fragment_unnamed_548.w, ((-0.0f) - fragment_uniform_buffer_2[5u].y) + fragment_uniform_buffer_2[5u].z, fragment_uniform_buffer_2[5u].y);
				float fragment_unnamed_656 = mad(fragment_unnamed_548.y, ((-0.0f) - fragment_uniform_buffer_2[5u].w) + fragment_uniform_buffer_2[6u].x, fragment_uniform_buffer_2[5u].w);
				float4 fragment_unnamed_661 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_unnamed_384, fragment_unnamed_386), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_667 = mad(fragment_unnamed_661.x * fragment_unnamed_661.w, 2.0f, -1.0f);
				float fragment_unnamed_668 = mad(fragment_unnamed_661.y, 2.0f, -1.0f);
				float fragment_unnamed_681 = fragment_unnamed_667 * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_682 = fragment_unnamed_668 * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_686 = clamp(fragment_uniform_buffer_2[8u].x, 0.0f, 1.0f);
				float fragment_unnamed_687 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_667, fragment_unnamed_668), float2(fragment_unnamed_667, fragment_unnamed_668)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f);
				float fragment_unnamed_695 = sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_539, fragment_unnamed_541), float2(fragment_unnamed_539, fragment_unnamed_541)), 1.0f)) + 1.0f);
				float fragment_unnamed_699 = rsqrt(dot(float3(fragment_unnamed_539, fragment_unnamed_541, fragment_unnamed_695), float3(fragment_unnamed_539, fragment_unnamed_541, fragment_unnamed_695)));
				float fragment_unnamed_705 = fragment_unnamed_551 * fragment_uniform_buffer_2[12u].w;
				float fragment_unnamed_711 = fragment_unnamed_681 + 0.0f;
				float fragment_unnamed_712 = fragment_unnamed_682 + 0.0f;
				float fragment_unnamed_713 = (fragment_unnamed_687 * fragment_unnamed_686) + 2.0f;
				float fragment_unnamed_714 = ((fragment_unnamed_539 * fragment_unnamed_699) * fragment_unnamed_705) * (-1.0f);
				float fragment_unnamed_715 = ((fragment_unnamed_541 * fragment_unnamed_699) * fragment_unnamed_705) * (-1.0f);
				float fragment_unnamed_716 = mad(clamp(fragment_unnamed_705, 0.0f, 1.0f), mad(fragment_unnamed_695, fragment_unnamed_699, -1.0f), 1.0f) * 1.0f;
				float fragment_unnamed_720 = dot(float3(fragment_unnamed_711, fragment_unnamed_712, fragment_unnamed_713), float3(fragment_unnamed_714, fragment_unnamed_715, fragment_unnamed_716));
				float fragment_unnamed_737 = asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_711 / fragment_unnamed_713, fragment_unnamed_720, (-0.0f) - fragment_unnamed_714)) : asuint(fragment_unnamed_681));
				float fragment_unnamed_739 = asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_712 / fragment_unnamed_713, fragment_unnamed_720, (-0.0f) - fragment_unnamed_715)) : asuint(fragment_unnamed_682));
				float fragment_unnamed_741 = asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_713 / fragment_unnamed_713, fragment_unnamed_720, (-0.0f) - fragment_unnamed_716)) : asuint(mad(fragment_unnamed_686, fragment_unnamed_687, 1.0f)));
				float fragment_unnamed_748 = mad(fragment_unnamed_741, fragment_unnamed_170, mad(fragment_unnamed_737, fragment_unnamed_94 * fragment_input_1.x, (fragment_unnamed_94 * (fragment_unnamed_114 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_739));
				float fragment_unnamed_749 = mad(fragment_unnamed_741, fragment_unnamed_171, mad(fragment_unnamed_737, fragment_unnamed_94 * fragment_input_1.y, (fragment_unnamed_94 * (fragment_unnamed_114 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_739));
				float fragment_unnamed_750 = mad(fragment_unnamed_741, fragment_unnamed_173, mad(fragment_unnamed_737, fragment_unnamed_94 * fragment_input_1.z, (fragment_unnamed_94 * (fragment_unnamed_114 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_739));
				float fragment_unnamed_755 = rsqrt(max(dot(float3(fragment_unnamed_748, fragment_unnamed_749, fragment_unnamed_750), float3(fragment_unnamed_748, fragment_unnamed_749, fragment_unnamed_750)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_756 = fragment_unnamed_755 * fragment_unnamed_748;
				float fragment_unnamed_757 = fragment_unnamed_755 * fragment_unnamed_749;
				float fragment_unnamed_758 = fragment_unnamed_755 * fragment_unnamed_750;
				uint4 fragment_unnamed_772 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_773 = fragment_unnamed_772.x;
				float fragment_unnamed_1144;
				float fragment_unnamed_1146;
				float fragment_unnamed_1148;
				float fragment_unnamed_1150;
				float fragment_unnamed_1152;
				float fragment_unnamed_1154;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_773 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_773 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_788 = (-0.0f) - fragment_unnamed_170;
					float fragment_unnamed_789 = (-0.0f) - fragment_unnamed_171;
					float fragment_unnamed_790 = (-0.0f) - fragment_unnamed_173;
					float fragment_unnamed_1145;
					float fragment_unnamed_1147;
					float fragment_unnamed_1149;
					float fragment_unnamed_1151;
					float fragment_unnamed_1153;
					float fragment_unnamed_1155;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_802 = asfloat(1065353216u);
						float fragment_unnamed_830 = fragment_unnamed_757 * fragment_unnamed_756;
						float fragment_unnamed_831 = fragment_unnamed_758 * fragment_unnamed_757;
						float fragment_unnamed_832 = fragment_unnamed_758 * fragment_unnamed_758;
						float fragment_unnamed_833 = fragment_unnamed_756 * fragment_unnamed_758;
						float fragment_unnamed_865 = mad(fragment_unnamed_756, fragment_unnamed_756, (-0.0f) - (fragment_unnamed_757 * fragment_unnamed_757));
						float fragment_unnamed_878 = asfloat(1065353216u);
						float fragment_unnamed_906 = fragment_unnamed_171 * fragment_unnamed_170;
						float fragment_unnamed_907 = fragment_unnamed_173 * fragment_unnamed_171;
						float fragment_unnamed_908 = fragment_unnamed_172 * fragment_unnamed_172;
						float fragment_unnamed_909 = fragment_unnamed_170 * fragment_unnamed_173;
						float fragment_unnamed_939 = mad(fragment_unnamed_170, fragment_unnamed_170, (-0.0f) - (fragment_unnamed_171 * fragment_unnamed_171));
						fragment_unnamed_1145 = mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_939, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_906, fragment_unnamed_907, fragment_unnamed_908, fragment_unnamed_909))) + dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_878));
						fragment_unnamed_1147 = mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_939, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_906, fragment_unnamed_907, fragment_unnamed_908, fragment_unnamed_909))) + dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_878));
						fragment_unnamed_1149 = mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_939, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_906, fragment_unnamed_907, fragment_unnamed_908, fragment_unnamed_909))) + dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_878));
						fragment_unnamed_1151 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_802)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_865, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_830, fragment_unnamed_831, fragment_unnamed_832, fragment_unnamed_833)));
						fragment_unnamed_1153 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_802)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_865, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_830, fragment_unnamed_831, fragment_unnamed_832, fragment_unnamed_833)));
						fragment_unnamed_1155 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_802)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_865, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_830, fragment_unnamed_831, fragment_unnamed_832, fragment_unnamed_833)));
					}
					else
					{
						bool fragment_unnamed_954 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_955 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_976 = fragment_unnamed_954 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_977 = fragment_unnamed_954 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_978 = fragment_unnamed_954 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_1082 = (asfloat(fragment_unnamed_955 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_978, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_976, fragment_unnamed_977 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_977)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_1083 = (asfloat(fragment_unnamed_955 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_978, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_976, fragment_unnamed_977 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_978)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_1097 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_955 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_978, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_976, fragment_unnamed_977 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_976)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float4 fragment_unnamed_1100 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1097, fragment_unnamed_1082, fragment_unnamed_1083), 0.0f);
						float fragment_unnamed_1102 = fragment_unnamed_1100.x;
						float4 fragment_unnamed_1109 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1097 + 0.25f, fragment_unnamed_1082 + 0.0f, fragment_unnamed_1083 + 0.0f), 0.0f);
						float fragment_unnamed_1111 = fragment_unnamed_1109.x;
						float4 fragment_unnamed_1118 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1097 + 0.5f, fragment_unnamed_1082 + 0.0f, fragment_unnamed_1083 + 0.0f), 0.0f);
						float fragment_unnamed_1120 = fragment_unnamed_1118.x;
						float fragment_unnamed_1124 = asfloat(1065353216u);
						float fragment_unnamed_1134 = asfloat(1065353216u);
						fragment_unnamed_1145 = dot(float4(fragment_unnamed_1102, fragment_unnamed_1100.yzw), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_1134));
						fragment_unnamed_1147 = dot(float4(fragment_unnamed_1111, fragment_unnamed_1109.yzw), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_1134));
						fragment_unnamed_1149 = dot(float4(fragment_unnamed_1120, fragment_unnamed_1118.yzw), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_1134));
						fragment_unnamed_1151 = dot(float4(fragment_unnamed_1102, fragment_unnamed_1100.yzw), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_1124));
						fragment_unnamed_1153 = dot(float4(fragment_unnamed_1111, fragment_unnamed_1109.yzw), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_1124));
						fragment_unnamed_1155 = dot(float4(fragment_unnamed_1120, fragment_unnamed_1118.yzw), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_1124));
					}
					fragment_unnamed_1144 = fragment_unnamed_1145;
					fragment_unnamed_1146 = fragment_unnamed_1147;
					fragment_unnamed_1148 = fragment_unnamed_1149;
					fragment_unnamed_1150 = fragment_unnamed_1151;
					fragment_unnamed_1152 = fragment_unnamed_1153;
					fragment_unnamed_1154 = fragment_unnamed_1155;
				}
				else
				{
					fragment_unnamed_1144 = asfloat(0u);
					fragment_unnamed_1146 = asfloat(0u);
					fragment_unnamed_1148 = asfloat(0u);
					fragment_unnamed_1150 = asfloat(0u);
					fragment_unnamed_1152 = asfloat(0u);
					fragment_unnamed_1154 = asfloat(0u);
				}
				float fragment_unnamed_1157 = ((-0.0f) - asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_551, ((-0.0f) - fragment_unnamed_626) + clamp(mad(clamp(abs(fragment_unnamed_543) * fragment_uniform_buffer_2[13u].x, 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_626) + asfloat((fragment_unnamed_543 < 0.0f) ? 0u : 1065353216u), fragment_unnamed_626), 0.0f, 1.0f), fragment_unnamed_626)) : asuint(fragment_unnamed_626))) + 1.0f;
				float fragment_unnamed_1175;
				if (asuint(fragment_uniform_buffer_2[1u]).x != 0u)
				{
					float fragment_unnamed_1163 = asfloat(0u);
					float fragment_unnamed_1176;
					float fragment_unnamed_1165 = fragment_unnamed_1163;
					uint fragment_unnamed_1167 = 0u;
					for (;;)
					{
						if (fragment_unnamed_1167 >= asuint(fragment_uniform_buffer_0[209u]).w)
						{
							fragment_unnamed_1176 = fragment_unnamed_1165;
							break;
						}
						else
						{
							if (!(asuint(fragment_uniform_buffer_2[1u]).x == asuint(fragment_uniform_buffer_0[fragment_unnamed_1167 + 193u]).x))
							{
								fragment_unnamed_1165 = asfloat(0u);
								fragment_unnamed_1167++;
								continue;
							}
							fragment_unnamed_1176 = asfloat(fragment_unnamed_1167);
							break;
						}
					}
					fragment_unnamed_1175 = fragment_unnamed_1176;
				}
				else
				{
					fragment_unnamed_1175 = asfloat(0u);
				}
				uint4 fragment_unnamed_1179 = asuint(fragment_uniform_buffer_0[209u]);
				uint fragment_unnamed_1182 = asuint(fragment_unnamed_1175);
				uint fragment_unnamed_1200 = (asuint(fragment_uniform_buffer_0[209u]).x != 0u) ? ((((fragment_unnamed_1179.y >> (fragment_unnamed_1182 & 31u)) & 1u) != 0u) ? 1u : 2u) : 0u;
				uint fragment_unnamed_1215 = (0.0f != fragment_uniform_buffer_0[asuint(fragment_unnamed_1175) + 177u].w) ? ((fragment_unnamed_1200 * 131072u) + 2162701u) : ((fragment_unnamed_1200 * 131072u) + 65549u);
				float fragment_unnamed_1246 = mad(fragment_uniform_buffer_0[asuint(fragment_unnamed_1175) + 161u].w, fragment_uniform_buffer_2[15u].x, fragment_uniform_buffer_0[asuint(fragment_unnamed_1175) + 161u].z) * (-0.4808983504772186279296875f);
				uint fragment_unnamed_1249 = asuint(fragment_unnamed_1175) + 129u;
				float fragment_unnamed_1259 = exp2(fragment_unnamed_1246 * fragment_uniform_buffer_0[fragment_unnamed_1249].x);
				float fragment_unnamed_1260 = exp2(fragment_unnamed_1246 * fragment_uniform_buffer_0[fragment_unnamed_1249].y);
				float fragment_unnamed_1261 = exp2(fragment_unnamed_1246 * fragment_uniform_buffer_0[fragment_unnamed_1249].z);
				uint fragment_unnamed_1269 = asuint(fragment_unnamed_1175) + 145u;
				float fragment_unnamed_1293 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758), float3(fragment_unnamed_222 * fragment_unnamed_204, fragment_unnamed_222 * fragment_unnamed_211, fragment_unnamed_222 * fragment_unnamed_218)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_1157, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				uint fragment_unnamed_1298 = 17u & 31u;
				float fragment_unnamed_1324;
				float fragment_unnamed_1325;
				float fragment_unnamed_1326;
				switch (spvBitfieldUExtract(((((fragment_unnamed_1179.z >> (fragment_unnamed_1182 & 31u)) & 1u) != 0u) ? 0u : 524288u) + ((fragment_uniform_buffer_0[asuint(fragment_unnamed_1175) + 177u].y != fragment_uniform_buffer_0[asuint(fragment_unnamed_1175) + 177u].x) ? (fragment_unnamed_1215 | 1114125u) : fragment_unnamed_1215), fragment_unnamed_1298, min((2u & 31u), (32u - fragment_unnamed_1298))))
				{
					case 2u:
					{
						fragment_unnamed_1324 = sqrt(fragment_unnamed_610);
						fragment_unnamed_1325 = sqrt(fragment_unnamed_612);
						fragment_unnamed_1326 = sqrt(fragment_unnamed_614);
						break;
					}
					case 1u:
					{
						fragment_unnamed_1324 = asfloat(1065353216u);
						fragment_unnamed_1325 = asfloat(1065353216u);
						fragment_unnamed_1326 = asfloat(1065353216u);
						break;
					}
					default:
					{
						fragment_unnamed_1324 = asfloat(fragment_unnamed_609);
						fragment_unnamed_1325 = asfloat(fragment_unnamed_611);
						fragment_unnamed_1326 = asfloat(fragment_unnamed_613);
						break;
					}
				}
				float fragment_unnamed_1340 = clamp(((-0.20000000298023223876953125f) + fragment_uniform_buffer_0[asuint(fragment_unnamed_1175) + 145u].w) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				uint fragment_unnamed_1345 = asuint(fragment_unnamed_1175) + 145u;
				float fragment_unnamed_1369 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1374 = max(abs(fragment_unnamed_758), 0.0009765625f);
				float fragment_unnamed_1378 = (fragment_unnamed_758 >= 0.0f) ? fragment_unnamed_1374 : ((-0.0f) - fragment_unnamed_1374);
				float fragment_unnamed_1387 = 1.0f / max(dot(float3(abs(fragment_unnamed_756), abs(fragment_unnamed_757), abs(fragment_unnamed_1378)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1392 = clamp((-0.0f) - (fragment_unnamed_1387 * fragment_unnamed_1378), 0.0f, 1.0f);
				float fragment_unnamed_1395 = (-0.0f) - fragment_unnamed_1392;
				uint fragment_unnamed_1407 = uint(clamp(mad(mad(fragment_unnamed_756, fragment_unnamed_1387, ((fragment_unnamed_1387 * fragment_unnamed_756) >= 0.0f) ? fragment_unnamed_1392 : fragment_unnamed_1395), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1408 = uint(clamp(mad(mad(fragment_unnamed_757, fragment_unnamed_1387, ((fragment_unnamed_1387 * fragment_unnamed_757) >= 0.0f) ? fragment_unnamed_1392 : fragment_unnamed_1395), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1407 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1408 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1408 >> 8u) * 16u) + (fragment_unnamed_1407 >> 8u)) * 0.0039215688593685626983642578125f;
				float fragment_unnamed_1445;
				if (asuint(fragment_uniform_buffer_2[1u]).x != 0u)
				{
					float fragment_unnamed_1432 = asfloat(0u);
					float fragment_unnamed_1433 = asfloat(0u);
					float fragment_unnamed_1446;
					float fragment_unnamed_1435 = fragment_unnamed_1433;
					float fragment_unnamed_1437 = fragment_unnamed_1432;
					for (;;)
					{
						if (asuint(fragment_unnamed_1435) >= asuint(fragment_uniform_buffer_0[209u]).w)
						{
							fragment_unnamed_1446 = fragment_unnamed_1437;
							break;
						}
						else
						{
							if (!(asuint(fragment_uniform_buffer_2[1u]).x == asuint(fragment_uniform_buffer_0[asuint(fragment_unnamed_1435) + 193u]).x))
							{
								fragment_unnamed_1435 = asfloat(asuint(fragment_unnamed_1435) + 1u);
								fragment_unnamed_1437 = asfloat(0u);
								continue;
							}
							fragment_unnamed_1446 = fragment_unnamed_1435;
							break;
						}
					}
					fragment_unnamed_1445 = fragment_unnamed_1446;
				}
				else
				{
					fragment_unnamed_1445 = asfloat(0u);
				}
				float fragment_unnamed_1449 = mad(float(asuint(fragment_unnamed_1445)), 0.062745101749897003173828125f, 0.0588235296308994293212890625f);
				float fragment_unnamed_1462 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1463 = fragment_unnamed_1462 * (fragment_unnamed_656 * (fragment_unnamed_1369 * ((fragment_unnamed_1293 * mad(fragment_unnamed_1340, ((-0.0f) - fragment_unnamed_1324) + fragment_uniform_buffer_0[fragment_unnamed_1345].w, fragment_unnamed_1324)) * mad(fragment_unnamed_1144, (fragment_unnamed_1259 * mad(fragment_unnamed_1259, fragment_unnamed_1259, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_1269].x, fragment_unnamed_1150))));
				float fragment_unnamed_1464 = fragment_unnamed_1462 * (fragment_unnamed_656 * (fragment_unnamed_1369 * ((fragment_unnamed_1293 * mad(fragment_unnamed_1340, ((-0.0f) - fragment_unnamed_1325) + fragment_uniform_buffer_0[fragment_unnamed_1345].w, fragment_unnamed_1325)) * mad(fragment_unnamed_1146, (fragment_unnamed_1260 * mad(fragment_unnamed_1260, fragment_unnamed_1260, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_1269].y, fragment_unnamed_1152))));
				float fragment_unnamed_1465 = fragment_unnamed_1462 * (fragment_unnamed_656 * (fragment_unnamed_1369 * ((fragment_unnamed_1293 * mad(fragment_unnamed_1340, ((-0.0f) - fragment_unnamed_1326) + fragment_uniform_buffer_0[fragment_unnamed_1345].w, fragment_unnamed_1326)) * mad(fragment_unnamed_1148, (fragment_unnamed_1261 * mad(fragment_unnamed_1261, fragment_unnamed_1261, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_1269].z, fragment_unnamed_1154))));
				bool fragment_unnamed_1478 = (((fragment_unnamed_1465 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1464 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1463 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1478 ? asfloat(1157627904u) : fragment_unnamed_1463;
				fragment_output_3.y = fragment_unnamed_1478 ? fragment_unnamed_656 : fragment_unnamed_1464;
				fragment_output_3.z = fragment_unnamed_1478 ? asfloat(1149239296u) : fragment_unnamed_1465;
				fragment_output_0.x = fragment_unnamed_610;
				fragment_output_0.y = fragment_unnamed_612;
				fragment_output_0.z = fragment_unnamed_614;
				fragment_output_0.w = fragment_unnamed_1449;
				fragment_output_1.w = fragment_unnamed_1157;
				fragment_output_2.x = 1.0f;
				fragment_output_2.w = 0.01176470704376697540283203125f;
				fragment_output_2.y = fragment_uniform_buffer_2[15u].x;
				fragment_output_2.z = fragment_unnamed_1449;
				fragment_output_3.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], fragment_uniform_buffer_0[118][1], fragment_uniform_buffer_0[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_0[129] = float4(_ShapeParamsAndMaxScatterDists[0][0], _ShapeParamsAndMaxScatterDists[0][1], _ShapeParamsAndMaxScatterDists[0][2], _ShapeParamsAndMaxScatterDists[0][3]);
				fragment_uniform_buffer_0[130] = float4(_ShapeParamsAndMaxScatterDists[1][0], _ShapeParamsAndMaxScatterDists[1][1], _ShapeParamsAndMaxScatterDists[1][2], _ShapeParamsAndMaxScatterDists[1][3]);
				fragment_uniform_buffer_0[131] = float4(_ShapeParamsAndMaxScatterDists[2][0], _ShapeParamsAndMaxScatterDists[2][1], _ShapeParamsAndMaxScatterDists[2][2], _ShapeParamsAndMaxScatterDists[2][3]);
				fragment_uniform_buffer_0[132] = float4(_ShapeParamsAndMaxScatterDists[3][0], _ShapeParamsAndMaxScatterDists[3][1], _ShapeParamsAndMaxScatterDists[3][2], _ShapeParamsAndMaxScatterDists[3][3]);
				fragment_uniform_buffer_0[133] = float4(_ShapeParamsAndMaxScatterDists[4][0], _ShapeParamsAndMaxScatterDists[4][1], _ShapeParamsAndMaxScatterDists[4][2], _ShapeParamsAndMaxScatterDists[4][3]);
				fragment_uniform_buffer_0[134] = float4(_ShapeParamsAndMaxScatterDists[5][0], _ShapeParamsAndMaxScatterDists[5][1], _ShapeParamsAndMaxScatterDists[5][2], _ShapeParamsAndMaxScatterDists[5][3]);
				fragment_uniform_buffer_0[135] = float4(_ShapeParamsAndMaxScatterDists[6][0], _ShapeParamsAndMaxScatterDists[6][1], _ShapeParamsAndMaxScatterDists[6][2], _ShapeParamsAndMaxScatterDists[6][3]);
				fragment_uniform_buffer_0[136] = float4(_ShapeParamsAndMaxScatterDists[7][0], _ShapeParamsAndMaxScatterDists[7][1], _ShapeParamsAndMaxScatterDists[7][2], _ShapeParamsAndMaxScatterDists[7][3]);
				fragment_uniform_buffer_0[137] = float4(_ShapeParamsAndMaxScatterDists[8][0], _ShapeParamsAndMaxScatterDists[8][1], _ShapeParamsAndMaxScatterDists[8][2], _ShapeParamsAndMaxScatterDists[8][3]);
				fragment_uniform_buffer_0[138] = float4(_ShapeParamsAndMaxScatterDists[9][0], _ShapeParamsAndMaxScatterDists[9][1], _ShapeParamsAndMaxScatterDists[9][2], _ShapeParamsAndMaxScatterDists[9][3]);
				fragment_uniform_buffer_0[139] = float4(_ShapeParamsAndMaxScatterDists[10][0], _ShapeParamsAndMaxScatterDists[10][1], _ShapeParamsAndMaxScatterDists[10][2], _ShapeParamsAndMaxScatterDists[10][3]);
				fragment_uniform_buffer_0[140] = float4(_ShapeParamsAndMaxScatterDists[11][0], _ShapeParamsAndMaxScatterDists[11][1], _ShapeParamsAndMaxScatterDists[11][2], _ShapeParamsAndMaxScatterDists[11][3]);
				fragment_uniform_buffer_0[141] = float4(_ShapeParamsAndMaxScatterDists[12][0], _ShapeParamsAndMaxScatterDists[12][1], _ShapeParamsAndMaxScatterDists[12][2], _ShapeParamsAndMaxScatterDists[12][3]);
				fragment_uniform_buffer_0[142] = float4(_ShapeParamsAndMaxScatterDists[13][0], _ShapeParamsAndMaxScatterDists[13][1], _ShapeParamsAndMaxScatterDists[13][2], _ShapeParamsAndMaxScatterDists[13][3]);
				fragment_uniform_buffer_0[143] = float4(_ShapeParamsAndMaxScatterDists[14][0], _ShapeParamsAndMaxScatterDists[14][1], _ShapeParamsAndMaxScatterDists[14][2], _ShapeParamsAndMaxScatterDists[14][3]);
				fragment_uniform_buffer_0[144] = float4(_ShapeParamsAndMaxScatterDists[15][0], _ShapeParamsAndMaxScatterDists[15][1], _ShapeParamsAndMaxScatterDists[15][2], _ShapeParamsAndMaxScatterDists[15][3]);

				fragment_uniform_buffer_0[145] = float4(_TransmissionTintsAndFresnel0[0][0], _TransmissionTintsAndFresnel0[0][1], _TransmissionTintsAndFresnel0[0][2], _TransmissionTintsAndFresnel0[0][3]);
				fragment_uniform_buffer_0[146] = float4(_TransmissionTintsAndFresnel0[1][0], _TransmissionTintsAndFresnel0[1][1], _TransmissionTintsAndFresnel0[1][2], _TransmissionTintsAndFresnel0[1][3]);
				fragment_uniform_buffer_0[147] = float4(_TransmissionTintsAndFresnel0[2][0], _TransmissionTintsAndFresnel0[2][1], _TransmissionTintsAndFresnel0[2][2], _TransmissionTintsAndFresnel0[2][3]);
				fragment_uniform_buffer_0[148] = float4(_TransmissionTintsAndFresnel0[3][0], _TransmissionTintsAndFresnel0[3][1], _TransmissionTintsAndFresnel0[3][2], _TransmissionTintsAndFresnel0[3][3]);
				fragment_uniform_buffer_0[149] = float4(_TransmissionTintsAndFresnel0[4][0], _TransmissionTintsAndFresnel0[4][1], _TransmissionTintsAndFresnel0[4][2], _TransmissionTintsAndFresnel0[4][3]);
				fragment_uniform_buffer_0[150] = float4(_TransmissionTintsAndFresnel0[5][0], _TransmissionTintsAndFresnel0[5][1], _TransmissionTintsAndFresnel0[5][2], _TransmissionTintsAndFresnel0[5][3]);
				fragment_uniform_buffer_0[151] = float4(_TransmissionTintsAndFresnel0[6][0], _TransmissionTintsAndFresnel0[6][1], _TransmissionTintsAndFresnel0[6][2], _TransmissionTintsAndFresnel0[6][3]);
				fragment_uniform_buffer_0[152] = float4(_TransmissionTintsAndFresnel0[7][0], _TransmissionTintsAndFresnel0[7][1], _TransmissionTintsAndFresnel0[7][2], _TransmissionTintsAndFresnel0[7][3]);
				fragment_uniform_buffer_0[153] = float4(_TransmissionTintsAndFresnel0[8][0], _TransmissionTintsAndFresnel0[8][1], _TransmissionTintsAndFresnel0[8][2], _TransmissionTintsAndFresnel0[8][3]);
				fragment_uniform_buffer_0[154] = float4(_TransmissionTintsAndFresnel0[9][0], _TransmissionTintsAndFresnel0[9][1], _TransmissionTintsAndFresnel0[9][2], _TransmissionTintsAndFresnel0[9][3]);
				fragment_uniform_buffer_0[155] = float4(_TransmissionTintsAndFresnel0[10][0], _TransmissionTintsAndFresnel0[10][1], _TransmissionTintsAndFresnel0[10][2], _TransmissionTintsAndFresnel0[10][3]);
				fragment_uniform_buffer_0[156] = float4(_TransmissionTintsAndFresnel0[11][0], _TransmissionTintsAndFresnel0[11][1], _TransmissionTintsAndFresnel0[11][2], _TransmissionTintsAndFresnel0[11][3]);
				fragment_uniform_buffer_0[157] = float4(_TransmissionTintsAndFresnel0[12][0], _TransmissionTintsAndFresnel0[12][1], _TransmissionTintsAndFresnel0[12][2], _TransmissionTintsAndFresnel0[12][3]);
				fragment_uniform_buffer_0[158] = float4(_TransmissionTintsAndFresnel0[13][0], _TransmissionTintsAndFresnel0[13][1], _TransmissionTintsAndFresnel0[13][2], _TransmissionTintsAndFresnel0[13][3]);
				fragment_uniform_buffer_0[159] = float4(_TransmissionTintsAndFresnel0[14][0], _TransmissionTintsAndFresnel0[14][1], _TransmissionTintsAndFresnel0[14][2], _TransmissionTintsAndFresnel0[14][3]);
				fragment_uniform_buffer_0[160] = float4(_TransmissionTintsAndFresnel0[15][0], _TransmissionTintsAndFresnel0[15][1], _TransmissionTintsAndFresnel0[15][2], _TransmissionTintsAndFresnel0[15][3]);

				fragment_uniform_buffer_0[161] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[0][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[0][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[0][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[0][3]);
				fragment_uniform_buffer_0[162] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[1][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[1][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[1][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[1][3]);
				fragment_uniform_buffer_0[163] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[2][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[2][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[2][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[2][3]);
				fragment_uniform_buffer_0[164] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[3][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[3][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[3][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[3][3]);
				fragment_uniform_buffer_0[165] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[4][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[4][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[4][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[4][3]);
				fragment_uniform_buffer_0[166] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[5][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[5][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[5][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[5][3]);
				fragment_uniform_buffer_0[167] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[6][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[6][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[6][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[6][3]);
				fragment_uniform_buffer_0[168] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[7][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[7][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[7][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[7][3]);
				fragment_uniform_buffer_0[169] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[8][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[8][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[8][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[8][3]);
				fragment_uniform_buffer_0[170] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[9][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[9][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[9][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[9][3]);
				fragment_uniform_buffer_0[171] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[10][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[10][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[10][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[10][3]);
				fragment_uniform_buffer_0[172] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[11][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[11][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[11][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[11][3]);
				fragment_uniform_buffer_0[173] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[12][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[12][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[12][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[12][3]);
				fragment_uniform_buffer_0[174] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[13][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[13][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[13][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[13][3]);
				fragment_uniform_buffer_0[175] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[14][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[14][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[14][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[14][3]);
				fragment_uniform_buffer_0[176] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[15][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[15][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[15][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[15][3]);

				fragment_uniform_buffer_0[177] = float4(_DualLobeAndDiffusePower[0][0], _DualLobeAndDiffusePower[0][1], _DualLobeAndDiffusePower[0][2], _DualLobeAndDiffusePower[0][3]);
				fragment_uniform_buffer_0[178] = float4(_DualLobeAndDiffusePower[1][0], _DualLobeAndDiffusePower[1][1], _DualLobeAndDiffusePower[1][2], _DualLobeAndDiffusePower[1][3]);
				fragment_uniform_buffer_0[179] = float4(_DualLobeAndDiffusePower[2][0], _DualLobeAndDiffusePower[2][1], _DualLobeAndDiffusePower[2][2], _DualLobeAndDiffusePower[2][3]);
				fragment_uniform_buffer_0[180] = float4(_DualLobeAndDiffusePower[3][0], _DualLobeAndDiffusePower[3][1], _DualLobeAndDiffusePower[3][2], _DualLobeAndDiffusePower[3][3]);
				fragment_uniform_buffer_0[181] = float4(_DualLobeAndDiffusePower[4][0], _DualLobeAndDiffusePower[4][1], _DualLobeAndDiffusePower[4][2], _DualLobeAndDiffusePower[4][3]);
				fragment_uniform_buffer_0[182] = float4(_DualLobeAndDiffusePower[5][0], _DualLobeAndDiffusePower[5][1], _DualLobeAndDiffusePower[5][2], _DualLobeAndDiffusePower[5][3]);
				fragment_uniform_buffer_0[183] = float4(_DualLobeAndDiffusePower[6][0], _DualLobeAndDiffusePower[6][1], _DualLobeAndDiffusePower[6][2], _DualLobeAndDiffusePower[6][3]);
				fragment_uniform_buffer_0[184] = float4(_DualLobeAndDiffusePower[7][0], _DualLobeAndDiffusePower[7][1], _DualLobeAndDiffusePower[7][2], _DualLobeAndDiffusePower[7][3]);
				fragment_uniform_buffer_0[185] = float4(_DualLobeAndDiffusePower[8][0], _DualLobeAndDiffusePower[8][1], _DualLobeAndDiffusePower[8][2], _DualLobeAndDiffusePower[8][3]);
				fragment_uniform_buffer_0[186] = float4(_DualLobeAndDiffusePower[9][0], _DualLobeAndDiffusePower[9][1], _DualLobeAndDiffusePower[9][2], _DualLobeAndDiffusePower[9][3]);
				fragment_uniform_buffer_0[187] = float4(_DualLobeAndDiffusePower[10][0], _DualLobeAndDiffusePower[10][1], _DualLobeAndDiffusePower[10][2], _DualLobeAndDiffusePower[10][3]);
				fragment_uniform_buffer_0[188] = float4(_DualLobeAndDiffusePower[11][0], _DualLobeAndDiffusePower[11][1], _DualLobeAndDiffusePower[11][2], _DualLobeAndDiffusePower[11][3]);
				fragment_uniform_buffer_0[189] = float4(_DualLobeAndDiffusePower[12][0], _DualLobeAndDiffusePower[12][1], _DualLobeAndDiffusePower[12][2], _DualLobeAndDiffusePower[12][3]);
				fragment_uniform_buffer_0[190] = float4(_DualLobeAndDiffusePower[13][0], _DualLobeAndDiffusePower[13][1], _DualLobeAndDiffusePower[13][2], _DualLobeAndDiffusePower[13][3]);
				fragment_uniform_buffer_0[191] = float4(_DualLobeAndDiffusePower[14][0], _DualLobeAndDiffusePower[14][1], _DualLobeAndDiffusePower[14][2], _DualLobeAndDiffusePower[14][3]);
				fragment_uniform_buffer_0[192] = float4(_DualLobeAndDiffusePower[15][0], _DualLobeAndDiffusePower[15][1], _DualLobeAndDiffusePower[15][2], _DualLobeAndDiffusePower[15][3]);

				fragment_uniform_buffer_0[193] = float4(asfloat(_DiffusionProfileHashTable[0][0]), asfloat(_DiffusionProfileHashTable[0][1]), asfloat(_DiffusionProfileHashTable[0][2]), asfloat(_DiffusionProfileHashTable[0][3]));
				fragment_uniform_buffer_0[194] = float4(asfloat(_DiffusionProfileHashTable[1][0]), asfloat(_DiffusionProfileHashTable[1][1]), asfloat(_DiffusionProfileHashTable[1][2]), asfloat(_DiffusionProfileHashTable[1][3]));
				fragment_uniform_buffer_0[195] = float4(asfloat(_DiffusionProfileHashTable[2][0]), asfloat(_DiffusionProfileHashTable[2][1]), asfloat(_DiffusionProfileHashTable[2][2]), asfloat(_DiffusionProfileHashTable[2][3]));
				fragment_uniform_buffer_0[196] = float4(asfloat(_DiffusionProfileHashTable[3][0]), asfloat(_DiffusionProfileHashTable[3][1]), asfloat(_DiffusionProfileHashTable[3][2]), asfloat(_DiffusionProfileHashTable[3][3]));
				fragment_uniform_buffer_0[197] = float4(asfloat(_DiffusionProfileHashTable[4][0]), asfloat(_DiffusionProfileHashTable[4][1]), asfloat(_DiffusionProfileHashTable[4][2]), asfloat(_DiffusionProfileHashTable[4][3]));
				fragment_uniform_buffer_0[198] = float4(asfloat(_DiffusionProfileHashTable[5][0]), asfloat(_DiffusionProfileHashTable[5][1]), asfloat(_DiffusionProfileHashTable[5][2]), asfloat(_DiffusionProfileHashTable[5][3]));
				fragment_uniform_buffer_0[199] = float4(asfloat(_DiffusionProfileHashTable[6][0]), asfloat(_DiffusionProfileHashTable[6][1]), asfloat(_DiffusionProfileHashTable[6][2]), asfloat(_DiffusionProfileHashTable[6][3]));
				fragment_uniform_buffer_0[200] = float4(asfloat(_DiffusionProfileHashTable[7][0]), asfloat(_DiffusionProfileHashTable[7][1]), asfloat(_DiffusionProfileHashTable[7][2]), asfloat(_DiffusionProfileHashTable[7][3]));
				fragment_uniform_buffer_0[201] = float4(asfloat(_DiffusionProfileHashTable[8][0]), asfloat(_DiffusionProfileHashTable[8][1]), asfloat(_DiffusionProfileHashTable[8][2]), asfloat(_DiffusionProfileHashTable[8][3]));
				fragment_uniform_buffer_0[202] = float4(asfloat(_DiffusionProfileHashTable[9][0]), asfloat(_DiffusionProfileHashTable[9][1]), asfloat(_DiffusionProfileHashTable[9][2]), asfloat(_DiffusionProfileHashTable[9][3]));
				fragment_uniform_buffer_0[203] = float4(asfloat(_DiffusionProfileHashTable[10][0]), asfloat(_DiffusionProfileHashTable[10][1]), asfloat(_DiffusionProfileHashTable[10][2]), asfloat(_DiffusionProfileHashTable[10][3]));
				fragment_uniform_buffer_0[204] = float4(asfloat(_DiffusionProfileHashTable[11][0]), asfloat(_DiffusionProfileHashTable[11][1]), asfloat(_DiffusionProfileHashTable[11][2]), asfloat(_DiffusionProfileHashTable[11][3]));
				fragment_uniform_buffer_0[205] = float4(asfloat(_DiffusionProfileHashTable[12][0]), asfloat(_DiffusionProfileHashTable[12][1]), asfloat(_DiffusionProfileHashTable[12][2]), asfloat(_DiffusionProfileHashTable[12][3]));
				fragment_uniform_buffer_0[206] = float4(asfloat(_DiffusionProfileHashTable[13][0]), asfloat(_DiffusionProfileHashTable[13][1]), asfloat(_DiffusionProfileHashTable[13][2]), asfloat(_DiffusionProfileHashTable[13][3]));
				fragment_uniform_buffer_0[207] = float4(asfloat(_DiffusionProfileHashTable[14][0]), asfloat(_DiffusionProfileHashTable[14][1]), asfloat(_DiffusionProfileHashTable[14][2]), asfloat(_DiffusionProfileHashTable[14][3]));
				fragment_uniform_buffer_0[208] = float4(asfloat(_DiffusionProfileHashTable[15][0]), asfloat(_DiffusionProfileHashTable[15][1]), asfloat(_DiffusionProfileHashTable[15][2]), asfloat(_DiffusionProfileHashTable[15][3]));

				fragment_uniform_buffer_0[209] = float4(asfloat(_EnableSubsurfaceScattering), fragment_uniform_buffer_0[209][1], fragment_uniform_buffer_0[209][2], fragment_uniform_buffer_0[209][3]);

				fragment_uniform_buffer_0[209] = float4(fragment_uniform_buffer_0[209][0], asfloat(_TexturingModeFlags), fragment_uniform_buffer_0[209][2], fragment_uniform_buffer_0[209][3]);

				fragment_uniform_buffer_0[209] = float4(fragment_uniform_buffer_0[209][0], fragment_uniform_buffer_0[209][1], asfloat(_TransmissionFlags), fragment_uniform_buffer_0[209][3]);

				fragment_uniform_buffer_0[209] = float4(fragment_uniform_buffer_0[209][0], fragment_uniform_buffer_0[209][1], fragment_uniform_buffer_0[209][2], asfloat(_DiffusionProfileCount));

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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

				fragment_uniform_buffer_2[1] = float4(_DiffusionProfileHash, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[15] = float4(_Thickness, fragment_uniform_buffer_2[15][1], fragment_uniform_buffer_2[15][2], fragment_uniform_buffer_2[15][3]);

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

			#endif // defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && defined(_MATERIAL_FEATURE_TRANSMISSION)


			#if defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && defined(_MATERIAL_FEATURE_TRANSMISSION) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _ReplaceDiffuseForIndirect;
			float4 _ShapeParamsAndMaxScatterDists[16];
			float4 _TransmissionTintsAndFresnel0[16];
			float4 _WorldScalesAndFilterRadiiAndThicknessRemaps[16];
			float4 _DualLobeAndDiffusePower[16];
			int4 _DiffusionProfileHashTable[16];
			int _EnableSubsurfaceScattering;
			int _TexturingModeFlags;
			int _TransmissionFlags;
			int _DiffusionProfileCount;
			int _EnableDecals;
			float4x4 unity_WorldToObject;
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
			float _DiffusionProfileHash;
			float _Thickness;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[16];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _DetailMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_DetailMap;

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
				float fragment_unnamed_102 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_122 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_178 = fragment_unnamed_102 * fragment_input_7.x;
				float fragment_unnamed_179 = fragment_unnamed_102 * fragment_input_7.y;
				float fragment_unnamed_180 = fragment_unnamed_102 * fragment_input_7.z;
				float fragment_unnamed_181 = fragment_unnamed_102 * fragment_input_7.z;
				bool fragment_unnamed_186 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_212 = asfloat(fragment_unnamed_186 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_219 = asfloat(fragment_unnamed_186 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_226 = asfloat(fragment_unnamed_186 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_230 = rsqrt(dot(float3(fragment_unnamed_212, fragment_unnamed_219, fragment_unnamed_226), float3(fragment_unnamed_212, fragment_unnamed_219, fragment_unnamed_226)));
				bool fragment_unnamed_302 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_312 = (fragment_unnamed_302 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_6.x) * fragment_uniform_buffer_2[8u].w;
				float fragment_unnamed_313 = (fragment_unnamed_302 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_6.z) * fragment_uniform_buffer_2[8u].w;
				float fragment_unnamed_322 = mad(fragment_unnamed_312, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z);
				float fragment_unnamed_323 = mad(fragment_unnamed_313, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w);
				bool fragment_unnamed_327 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_338 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_340 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_342 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_362 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_392 = asfloat(fragment_unnamed_327 ? asuint(fragment_unnamed_322) : asuint(mad(mad(fragment_unnamed_338, fragment_input_2.x, fragment_unnamed_340 * fragment_input_3.x) + mad(fragment_unnamed_342, fragment_input_4.x, fragment_unnamed_362 * fragment_input_5.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_394 = asfloat(fragment_unnamed_327 ? asuint(fragment_unnamed_323) : asuint(mad(mad(fragment_unnamed_338, fragment_input_2.y, fragment_unnamed_340 * fragment_input_3.y) + mad(fragment_unnamed_342, fragment_input_4.y, fragment_unnamed_362 * fragment_input_5.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				float4 fragment_unnamed_401 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_392, fragment_unnamed_394), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_404 = fragment_unnamed_401.x;
				float fragment_unnamed_405 = fragment_unnamed_401.y;
				float fragment_unnamed_406 = fragment_unnamed_401.z;
				float fragment_unnamed_412 = fragment_unnamed_404 * fragment_uniform_buffer_2[2u].x;
				float fragment_unnamed_413 = fragment_unnamed_405 * fragment_uniform_buffer_2[2u].y;
				float fragment_unnamed_414 = fragment_unnamed_406 * fragment_uniform_buffer_2[2u].z;
				bool fragment_unnamed_418 = fragment_uniform_buffer_2[8u].y < 4.0f;
				bool fragment_unnamed_444 = 0.0f != fragment_uniform_buffer_2[12u].y;
				uint4 fragment_unnamed_451 = asuint(fragment_uniform_buffer_2[14u]);
				float fragment_unnamed_476 = asfloat(((fragment_uniform_buffer_2[12u].x == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_478 = asfloat(((fragment_uniform_buffer_2[12u].x == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_480 = asfloat(((fragment_uniform_buffer_2[12u].x == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_482 = asfloat(((fragment_uniform_buffer_2[12u].x == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				float4 fragment_unnamed_541 = _DetailMap.SampleBias(sampler_DetailMap, float2(asfloat(fragment_unnamed_418 ? asuint(mad(mad(fragment_unnamed_476, fragment_input_2.x, fragment_unnamed_478 * fragment_input_3.x) + mad(fragment_unnamed_480, fragment_input_4.x, fragment_unnamed_482 * fragment_input_5.x), asfloat(fragment_unnamed_444 ? asuint(fragment_uniform_buffer_2[9u].x * fragment_uniform_buffer_2[14u].x) : fragment_unnamed_451.x), asfloat(fragment_unnamed_444 ? asuint(fragment_uniform_buffer_2[9u].z + fragment_uniform_buffer_2[14u].z) : fragment_unnamed_451.z))) : asuint(mad(asfloat(fragment_unnamed_444 ? asuint(fragment_unnamed_322) : asuint(fragment_unnamed_312)), fragment_uniform_buffer_2[14u].x, fragment_uniform_buffer_2[14u].z))), asfloat(fragment_unnamed_418 ? asuint(mad(mad(fragment_unnamed_476, fragment_input_2.y, fragment_unnamed_478 * fragment_input_3.y) + mad(fragment_unnamed_480, fragment_input_4.y, fragment_unnamed_482 * fragment_input_5.y), asfloat(fragment_unnamed_444 ? asuint(fragment_uniform_buffer_2[9u].y * fragment_uniform_buffer_2[14u].y) : fragment_unnamed_451.y), asfloat(fragment_unnamed_444 ? asuint(fragment_uniform_buffer_2[9u].w + fragment_uniform_buffer_2[14u].w) : fragment_unnamed_451.w))) : asuint(mad(asfloat(fragment_unnamed_444 ? asuint(fragment_unnamed_323) : asuint(fragment_unnamed_313)), fragment_uniform_buffer_2[14u].y, fragment_uniform_buffer_2[14u].w)))), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_547 = mad(fragment_unnamed_541.w, 2.0f, -1.0f);
				float fragment_unnamed_549 = mad(fragment_unnamed_541.y, 2.0f, -1.0f);
				float fragment_unnamed_550 = mad(fragment_unnamed_541.x, 2.0f, -1.0f);
				float fragment_unnamed_551 = mad(fragment_unnamed_541.z, 2.0f, -1.0f);
				float4 fragment_unnamed_556 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_unnamed_392, fragment_unnamed_394), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_559 = fragment_unnamed_556.z;
				float fragment_unnamed_561 = sqrt(fragment_unnamed_412);
				float fragment_unnamed_562 = sqrt(fragment_unnamed_413);
				float fragment_unnamed_563 = sqrt(fragment_unnamed_414);
				float fragment_unnamed_567 = asfloat((fragment_unnamed_550 < 0.0f) ? 0u : 1065353216u);
				float fragment_unnamed_575 = clamp(abs(fragment_unnamed_550) * fragment_uniform_buffer_2[12u].z, 0.0f, 1.0f);
				float fragment_unnamed_576 = fragment_unnamed_575 * fragment_unnamed_575;
				float fragment_unnamed_583 = mad(fragment_unnamed_576, ((-0.0f) - fragment_unnamed_561) + fragment_unnamed_567, fragment_unnamed_561);
				float fragment_unnamed_584 = mad(fragment_unnamed_576, ((-0.0f) - fragment_unnamed_562) + fragment_unnamed_567, fragment_unnamed_562);
				float fragment_unnamed_585 = mad(fragment_unnamed_576, ((-0.0f) - fragment_unnamed_563) + fragment_unnamed_567, fragment_unnamed_563);
				bool fragment_unnamed_610 = 0.0f != fragment_uniform_buffer_2[10u].x;
				float fragment_unnamed_618 = asfloat(fragment_unnamed_610 ? asuint(mad(fragment_unnamed_559, mad((-0.0f) - fragment_uniform_buffer_2[2u].x, fragment_unnamed_404, min(fragment_unnamed_583 * fragment_unnamed_583, 1.0f)), fragment_unnamed_412)) : asuint(fragment_unnamed_412));
				float fragment_unnamed_620 = asfloat(fragment_unnamed_610 ? asuint(mad(fragment_unnamed_559, mad((-0.0f) - fragment_uniform_buffer_2[2u].y, fragment_unnamed_405, min(fragment_unnamed_584 * fragment_unnamed_584, 1.0f)), fragment_unnamed_413)) : asuint(fragment_unnamed_413));
				float fragment_unnamed_622 = asfloat(fragment_unnamed_610 ? asuint(mad(fragment_unnamed_559, mad((-0.0f) - fragment_uniform_buffer_2[2u].z, fragment_unnamed_406, min(fragment_unnamed_585 * fragment_unnamed_585, 1.0f)), fragment_unnamed_414)) : asuint(fragment_unnamed_414));
				float fragment_unnamed_634 = mad(fragment_unnamed_556.w, ((-0.0f) - fragment_uniform_buffer_2[5u].y) + fragment_uniform_buffer_2[5u].z, fragment_uniform_buffer_2[5u].y);
				float fragment_unnamed_652 = asfloat(fragment_unnamed_610 ? asuint(mad(fragment_unnamed_559, ((-0.0f) - fragment_unnamed_634) + clamp(mad(clamp(abs(fragment_unnamed_551) * fragment_uniform_buffer_2[13u].x, 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_634) + asfloat((fragment_unnamed_551 < 0.0f) ? 0u : 1065353216u), fragment_unnamed_634), 0.0f, 1.0f), fragment_unnamed_634)) : asuint(fragment_unnamed_634));
				float fragment_unnamed_664 = mad(fragment_unnamed_556.y, ((-0.0f) - fragment_uniform_buffer_2[5u].w) + fragment_uniform_buffer_2[6u].x, fragment_uniform_buffer_2[5u].w);
				float4 fragment_unnamed_669 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_unnamed_392, fragment_unnamed_394), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_675 = mad(fragment_unnamed_669.x * fragment_unnamed_669.w, 2.0f, -1.0f);
				float fragment_unnamed_676 = mad(fragment_unnamed_669.y, 2.0f, -1.0f);
				float fragment_unnamed_689 = fragment_unnamed_675 * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_690 = fragment_unnamed_676 * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_694 = clamp(fragment_uniform_buffer_2[8u].x, 0.0f, 1.0f);
				float fragment_unnamed_695 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_675, fragment_unnamed_676), float2(fragment_unnamed_675, fragment_unnamed_676)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f);
				float fragment_unnamed_703 = sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_547, fragment_unnamed_549), float2(fragment_unnamed_547, fragment_unnamed_549)), 1.0f)) + 1.0f);
				float fragment_unnamed_707 = rsqrt(dot(float3(fragment_unnamed_547, fragment_unnamed_549, fragment_unnamed_703), float3(fragment_unnamed_547, fragment_unnamed_549, fragment_unnamed_703)));
				float fragment_unnamed_713 = fragment_unnamed_559 * fragment_uniform_buffer_2[12u].w;
				float fragment_unnamed_719 = fragment_unnamed_689 + 0.0f;
				float fragment_unnamed_720 = fragment_unnamed_690 + 0.0f;
				float fragment_unnamed_721 = (fragment_unnamed_695 * fragment_unnamed_694) + 2.0f;
				float fragment_unnamed_722 = ((fragment_unnamed_547 * fragment_unnamed_707) * fragment_unnamed_713) * (-1.0f);
				float fragment_unnamed_723 = ((fragment_unnamed_549 * fragment_unnamed_707) * fragment_unnamed_713) * (-1.0f);
				float fragment_unnamed_724 = mad(clamp(fragment_unnamed_713, 0.0f, 1.0f), mad(fragment_unnamed_703, fragment_unnamed_707, -1.0f), 1.0f) * 1.0f;
				float fragment_unnamed_728 = dot(float3(fragment_unnamed_719, fragment_unnamed_720, fragment_unnamed_721), float3(fragment_unnamed_722, fragment_unnamed_723, fragment_unnamed_724));
				float fragment_unnamed_745 = asfloat(fragment_unnamed_610 ? asuint(mad(fragment_unnamed_719 / fragment_unnamed_721, fragment_unnamed_728, (-0.0f) - fragment_unnamed_722)) : asuint(fragment_unnamed_689));
				float fragment_unnamed_747 = asfloat(fragment_unnamed_610 ? asuint(mad(fragment_unnamed_720 / fragment_unnamed_721, fragment_unnamed_728, (-0.0f) - fragment_unnamed_723)) : asuint(fragment_unnamed_690));
				float fragment_unnamed_749 = asfloat(fragment_unnamed_610 ? asuint(mad(fragment_unnamed_721 / fragment_unnamed_721, fragment_unnamed_728, (-0.0f) - fragment_unnamed_724)) : asuint(mad(fragment_unnamed_694, fragment_unnamed_695, 1.0f)));
				float fragment_unnamed_756 = mad(fragment_unnamed_749, fragment_unnamed_178, mad(fragment_unnamed_745, fragment_unnamed_102 * fragment_input_1.x, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_747));
				float fragment_unnamed_757 = mad(fragment_unnamed_749, fragment_unnamed_179, mad(fragment_unnamed_745, fragment_unnamed_102 * fragment_input_1.y, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_747));
				float fragment_unnamed_758 = mad(fragment_unnamed_749, fragment_unnamed_181, mad(fragment_unnamed_745, fragment_unnamed_102 * fragment_input_1.z, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_747));
				float fragment_unnamed_763 = rsqrt(max(dot(float3(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758), float3(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_764 = fragment_unnamed_763 * fragment_unnamed_756;
				float fragment_unnamed_765 = fragment_unnamed_763 * fragment_unnamed_757;
				float fragment_unnamed_766 = fragment_unnamed_763 * fragment_unnamed_758;
				float fragment_unnamed_828;
				float fragment_unnamed_829;
				float fragment_unnamed_830;
				float fragment_unnamed_831;
				float fragment_unnamed_832;
				float fragment_unnamed_833;
				float fragment_unnamed_834;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_777 = uint(gl_FragCoord.x);
					uint fragment_unnamed_778 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_779 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_777, fragment_unnamed_778, 0u), 0u));
					float fragment_unnamed_785 = fragment_unnamed_779.w;
					float4 fragment_unnamed_786 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_777, fragment_unnamed_778, 0u), 0u));
					float fragment_unnamed_791 = fragment_unnamed_786.w;
					float4 fragment_unnamed_792 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_777, fragment_unnamed_778, 0u), 0u));
					bool fragment_unnamed_800 = fragment_unnamed_791 < 1.0f;
					float fragment_unnamed_801 = mad(fragment_unnamed_764, fragment_unnamed_791, mad(fragment_unnamed_786.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_802 = mad(fragment_unnamed_765, fragment_unnamed_791, mad(fragment_unnamed_786.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_803 = mad(fragment_unnamed_766, fragment_unnamed_791, mad(fragment_unnamed_786.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_808 = rsqrt(max(dot(float3(fragment_unnamed_801, fragment_unnamed_802, fragment_unnamed_803), float3(fragment_unnamed_801, fragment_unnamed_802, fragment_unnamed_803)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_828 = mad(fragment_unnamed_618, fragment_unnamed_785, fragment_unnamed_779.x);
					fragment_unnamed_829 = mad(fragment_unnamed_620, fragment_unnamed_785, fragment_unnamed_779.y);
					fragment_unnamed_830 = mad(fragment_unnamed_622, fragment_unnamed_785, fragment_unnamed_779.z);
					fragment_unnamed_831 = mad(fragment_unnamed_652, fragment_unnamed_792.w, fragment_unnamed_792.z);
					fragment_unnamed_832 = asfloat(fragment_unnamed_800 ? asuint(fragment_unnamed_808 * fragment_unnamed_803) : asuint(fragment_unnamed_766));
					fragment_unnamed_833 = asfloat(fragment_unnamed_800 ? asuint(fragment_unnamed_808 * fragment_unnamed_802) : asuint(fragment_unnamed_765));
					fragment_unnamed_834 = asfloat(fragment_unnamed_800 ? asuint(fragment_unnamed_808 * fragment_unnamed_801) : asuint(fragment_unnamed_764));
				}
				else
				{
					fragment_unnamed_828 = fragment_unnamed_618;
					fragment_unnamed_829 = fragment_unnamed_620;
					fragment_unnamed_830 = fragment_unnamed_622;
					fragment_unnamed_831 = fragment_unnamed_652;
					fragment_unnamed_832 = fragment_unnamed_766;
					fragment_unnamed_833 = fragment_unnamed_765;
					fragment_unnamed_834 = fragment_unnamed_764;
				}
				uint4 fragment_unnamed_848 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_849 = fragment_unnamed_848.x;
				float fragment_unnamed_1220;
				float fragment_unnamed_1222;
				float fragment_unnamed_1224;
				float fragment_unnamed_1226;
				float fragment_unnamed_1228;
				float fragment_unnamed_1230;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_849 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_849 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_864 = (-0.0f) - fragment_unnamed_178;
					float fragment_unnamed_865 = (-0.0f) - fragment_unnamed_179;
					float fragment_unnamed_866 = (-0.0f) - fragment_unnamed_181;
					float fragment_unnamed_1221;
					float fragment_unnamed_1223;
					float fragment_unnamed_1225;
					float fragment_unnamed_1227;
					float fragment_unnamed_1229;
					float fragment_unnamed_1231;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_878 = asfloat(1065353216u);
						float fragment_unnamed_906 = fragment_unnamed_833 * fragment_unnamed_834;
						float fragment_unnamed_907 = fragment_unnamed_832 * fragment_unnamed_833;
						float fragment_unnamed_908 = fragment_unnamed_832 * fragment_unnamed_832;
						float fragment_unnamed_909 = fragment_unnamed_834 * fragment_unnamed_832;
						float fragment_unnamed_941 = mad(fragment_unnamed_834, fragment_unnamed_834, (-0.0f) - (fragment_unnamed_833 * fragment_unnamed_833));
						float fragment_unnamed_954 = asfloat(1065353216u);
						float fragment_unnamed_982 = fragment_unnamed_179 * fragment_unnamed_178;
						float fragment_unnamed_983 = fragment_unnamed_181 * fragment_unnamed_179;
						float fragment_unnamed_984 = fragment_unnamed_180 * fragment_unnamed_180;
						float fragment_unnamed_985 = fragment_unnamed_178 * fragment_unnamed_181;
						float fragment_unnamed_1015 = mad(fragment_unnamed_178, fragment_unnamed_178, (-0.0f) - (fragment_unnamed_179 * fragment_unnamed_179));
						fragment_unnamed_1221 = mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_1015, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_982, fragment_unnamed_983, fragment_unnamed_984, fragment_unnamed_985))) + dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_864, fragment_unnamed_865, fragment_unnamed_866, fragment_unnamed_954));
						fragment_unnamed_1223 = mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_1015, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_982, fragment_unnamed_983, fragment_unnamed_984, fragment_unnamed_985))) + dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_864, fragment_unnamed_865, fragment_unnamed_866, fragment_unnamed_954));
						fragment_unnamed_1225 = mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_1015, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_982, fragment_unnamed_983, fragment_unnamed_984, fragment_unnamed_985))) + dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_864, fragment_unnamed_865, fragment_unnamed_866, fragment_unnamed_954));
						fragment_unnamed_1227 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_834, fragment_unnamed_833, fragment_unnamed_832, fragment_unnamed_878)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_941, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_906, fragment_unnamed_907, fragment_unnamed_908, fragment_unnamed_909)));
						fragment_unnamed_1229 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_834, fragment_unnamed_833, fragment_unnamed_832, fragment_unnamed_878)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_941, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_906, fragment_unnamed_907, fragment_unnamed_908, fragment_unnamed_909)));
						fragment_unnamed_1231 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_834, fragment_unnamed_833, fragment_unnamed_832, fragment_unnamed_878)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_941, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_906, fragment_unnamed_907, fragment_unnamed_908, fragment_unnamed_909)));
					}
					else
					{
						bool fragment_unnamed_1030 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_1031 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_1052 = fragment_unnamed_1030 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_1053 = fragment_unnamed_1030 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_1054 = fragment_unnamed_1030 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_1158 = (asfloat(fragment_unnamed_1031 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_1054, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_1052, fragment_unnamed_1053 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_1053)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_1159 = (asfloat(fragment_unnamed_1031 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_1054, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_1052, fragment_unnamed_1053 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_1054)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_1173 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_1031 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_1054, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_1052, fragment_unnamed_1053 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_1052)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float4 fragment_unnamed_1176 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1173, fragment_unnamed_1158, fragment_unnamed_1159), 0.0f);
						float fragment_unnamed_1178 = fragment_unnamed_1176.x;
						float4 fragment_unnamed_1185 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1173 + 0.25f, fragment_unnamed_1158 + 0.0f, fragment_unnamed_1159 + 0.0f), 0.0f);
						float fragment_unnamed_1187 = fragment_unnamed_1185.x;
						float4 fragment_unnamed_1194 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1173 + 0.5f, fragment_unnamed_1158 + 0.0f, fragment_unnamed_1159 + 0.0f), 0.0f);
						float fragment_unnamed_1196 = fragment_unnamed_1194.x;
						float fragment_unnamed_1200 = asfloat(1065353216u);
						float fragment_unnamed_1210 = asfloat(1065353216u);
						fragment_unnamed_1221 = dot(float4(fragment_unnamed_1178, fragment_unnamed_1176.yzw), float4(fragment_unnamed_864, fragment_unnamed_865, fragment_unnamed_866, fragment_unnamed_1210));
						fragment_unnamed_1223 = dot(float4(fragment_unnamed_1187, fragment_unnamed_1185.yzw), float4(fragment_unnamed_864, fragment_unnamed_865, fragment_unnamed_866, fragment_unnamed_1210));
						fragment_unnamed_1225 = dot(float4(fragment_unnamed_1196, fragment_unnamed_1194.yzw), float4(fragment_unnamed_864, fragment_unnamed_865, fragment_unnamed_866, fragment_unnamed_1210));
						fragment_unnamed_1227 = dot(float4(fragment_unnamed_1178, fragment_unnamed_1176.yzw), float4(fragment_unnamed_834, fragment_unnamed_833, fragment_unnamed_832, fragment_unnamed_1200));
						fragment_unnamed_1229 = dot(float4(fragment_unnamed_1187, fragment_unnamed_1185.yzw), float4(fragment_unnamed_834, fragment_unnamed_833, fragment_unnamed_832, fragment_unnamed_1200));
						fragment_unnamed_1231 = dot(float4(fragment_unnamed_1196, fragment_unnamed_1194.yzw), float4(fragment_unnamed_834, fragment_unnamed_833, fragment_unnamed_832, fragment_unnamed_1200));
					}
					fragment_unnamed_1220 = fragment_unnamed_1221;
					fragment_unnamed_1222 = fragment_unnamed_1223;
					fragment_unnamed_1224 = fragment_unnamed_1225;
					fragment_unnamed_1226 = fragment_unnamed_1227;
					fragment_unnamed_1228 = fragment_unnamed_1229;
					fragment_unnamed_1230 = fragment_unnamed_1231;
				}
				else
				{
					fragment_unnamed_1220 = asfloat(0u);
					fragment_unnamed_1222 = asfloat(0u);
					fragment_unnamed_1224 = asfloat(0u);
					fragment_unnamed_1226 = asfloat(0u);
					fragment_unnamed_1228 = asfloat(0u);
					fragment_unnamed_1230 = asfloat(0u);
				}
				float fragment_unnamed_1233 = ((-0.0f) - fragment_unnamed_831) + 1.0f;
				float fragment_unnamed_1251;
				if (asuint(fragment_uniform_buffer_2[1u]).x != 0u)
				{
					float fragment_unnamed_1239 = asfloat(0u);
					float fragment_unnamed_1252;
					uint fragment_unnamed_1241 = 0u;
					float fragment_unnamed_1243 = fragment_unnamed_1239;
					for (;;)
					{
						if (fragment_unnamed_1241 >= asuint(fragment_uniform_buffer_0[209u]).w)
						{
							fragment_unnamed_1252 = fragment_unnamed_1243;
							break;
						}
						else
						{
							if (!(asuint(fragment_uniform_buffer_2[1u]).x == asuint(fragment_uniform_buffer_0[fragment_unnamed_1241 + 193u]).x))
							{
								fragment_unnamed_1241++;
								fragment_unnamed_1243 = asfloat(0u);
								continue;
							}
							fragment_unnamed_1252 = asfloat(fragment_unnamed_1241);
							break;
						}
					}
					fragment_unnamed_1251 = fragment_unnamed_1252;
				}
				else
				{
					fragment_unnamed_1251 = asfloat(0u);
				}
				uint4 fragment_unnamed_1255 = asuint(fragment_uniform_buffer_0[209u]);
				uint fragment_unnamed_1258 = asuint(fragment_unnamed_1251);
				uint fragment_unnamed_1276 = (asuint(fragment_uniform_buffer_0[209u]).x != 0u) ? ((((fragment_unnamed_1255.y >> (fragment_unnamed_1258 & 31u)) & 1u) != 0u) ? 1u : 2u) : 0u;
				uint fragment_unnamed_1291 = (0.0f != fragment_uniform_buffer_0[asuint(fragment_unnamed_1251) + 177u].w) ? ((fragment_unnamed_1276 * 131072u) + 2162701u) : ((fragment_unnamed_1276 * 131072u) + 65549u);
				float fragment_unnamed_1322 = mad(fragment_uniform_buffer_0[asuint(fragment_unnamed_1251) + 161u].w, fragment_uniform_buffer_2[15u].x, fragment_uniform_buffer_0[asuint(fragment_unnamed_1251) + 161u].z) * (-0.4808983504772186279296875f);
				uint fragment_unnamed_1325 = asuint(fragment_unnamed_1251) + 129u;
				float fragment_unnamed_1335 = exp2(fragment_unnamed_1322 * fragment_uniform_buffer_0[fragment_unnamed_1325].x);
				float fragment_unnamed_1336 = exp2(fragment_unnamed_1322 * fragment_uniform_buffer_0[fragment_unnamed_1325].y);
				float fragment_unnamed_1337 = exp2(fragment_unnamed_1322 * fragment_uniform_buffer_0[fragment_unnamed_1325].z);
				uint fragment_unnamed_1345 = asuint(fragment_unnamed_1251) + 145u;
				float fragment_unnamed_1369 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_834, fragment_unnamed_833, fragment_unnamed_832), float3(fragment_unnamed_230 * fragment_unnamed_212, fragment_unnamed_230 * fragment_unnamed_219, fragment_unnamed_230 * fragment_unnamed_226)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_1233, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				uint fragment_unnamed_1374 = 17u & 31u;
				float fragment_unnamed_1397;
				float fragment_unnamed_1398;
				float fragment_unnamed_1399;
				switch (spvBitfieldUExtract(((((fragment_unnamed_1255.z >> (fragment_unnamed_1258 & 31u)) & 1u) != 0u) ? 0u : 524288u) + ((fragment_uniform_buffer_0[asuint(fragment_unnamed_1251) + 177u].y != fragment_uniform_buffer_0[asuint(fragment_unnamed_1251) + 177u].x) ? (fragment_unnamed_1291 | 1114125u) : fragment_unnamed_1291), fragment_unnamed_1374, min((2u & 31u), (32u - fragment_unnamed_1374))))
				{
					case 2u:
					{
						fragment_unnamed_1397 = sqrt(fragment_unnamed_828);
						fragment_unnamed_1398 = sqrt(fragment_unnamed_829);
						fragment_unnamed_1399 = sqrt(fragment_unnamed_830);
						break;
					}
					case 1u:
					{
						fragment_unnamed_1397 = asfloat(1065353216u);
						fragment_unnamed_1398 = asfloat(1065353216u);
						fragment_unnamed_1399 = asfloat(1065353216u);
						break;
					}
					default:
					{
						fragment_unnamed_1397 = fragment_unnamed_828;
						fragment_unnamed_1398 = fragment_unnamed_829;
						fragment_unnamed_1399 = fragment_unnamed_830;
						break;
					}
				}
				float fragment_unnamed_1413 = clamp(((-0.20000000298023223876953125f) + fragment_uniform_buffer_0[asuint(fragment_unnamed_1251) + 145u].w) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				uint fragment_unnamed_1418 = asuint(fragment_unnamed_1251) + 145u;
				float fragment_unnamed_1442 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1447 = max(abs(fragment_unnamed_832), 0.0009765625f);
				float fragment_unnamed_1451 = (fragment_unnamed_832 >= 0.0f) ? fragment_unnamed_1447 : ((-0.0f) - fragment_unnamed_1447);
				float fragment_unnamed_1460 = 1.0f / max(dot(float3(abs(fragment_unnamed_834), abs(fragment_unnamed_833), abs(fragment_unnamed_1451)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1465 = clamp((-0.0f) - (fragment_unnamed_1460 * fragment_unnamed_1451), 0.0f, 1.0f);
				float fragment_unnamed_1468 = (-0.0f) - fragment_unnamed_1465;
				uint fragment_unnamed_1480 = uint(clamp(mad(mad(fragment_unnamed_834, fragment_unnamed_1460, ((fragment_unnamed_1460 * fragment_unnamed_834) >= 0.0f) ? fragment_unnamed_1465 : fragment_unnamed_1468), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1481 = uint(clamp(mad(mad(fragment_unnamed_833, fragment_unnamed_1460, ((fragment_unnamed_1460 * fragment_unnamed_833) >= 0.0f) ? fragment_unnamed_1465 : fragment_unnamed_1468), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1480 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1481 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1481 >> 8u) * 16u) + (fragment_unnamed_1480 >> 8u)) * 0.0039215688593685626983642578125f;
				float fragment_unnamed_1518;
				if (asuint(fragment_uniform_buffer_2[1u]).x != 0u)
				{
					float fragment_unnamed_1505 = asfloat(0u);
					float fragment_unnamed_1506 = asfloat(0u);
					float fragment_unnamed_1519;
					float fragment_unnamed_1508 = fragment_unnamed_1506;
					float fragment_unnamed_1510 = fragment_unnamed_1505;
					for (;;)
					{
						if (asuint(fragment_unnamed_1508) >= asuint(fragment_uniform_buffer_0[209u]).w)
						{
							fragment_unnamed_1519 = fragment_unnamed_1510;
							break;
						}
						else
						{
							if (!(asuint(fragment_uniform_buffer_2[1u]).x == asuint(fragment_uniform_buffer_0[asuint(fragment_unnamed_1508) + 193u]).x))
							{
								fragment_unnamed_1508 = asfloat(asuint(fragment_unnamed_1508) + 1u);
								fragment_unnamed_1510 = asfloat(0u);
								continue;
							}
							fragment_unnamed_1519 = fragment_unnamed_1508;
							break;
						}
					}
					fragment_unnamed_1518 = fragment_unnamed_1519;
				}
				else
				{
					fragment_unnamed_1518 = asfloat(0u);
				}
				float fragment_unnamed_1522 = mad(float(asuint(fragment_unnamed_1518)), 0.062745101749897003173828125f, 0.0588235296308994293212890625f);
				float fragment_unnamed_1535 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1536 = fragment_unnamed_1535 * (fragment_unnamed_664 * (fragment_unnamed_1442 * ((fragment_unnamed_1369 * mad(fragment_unnamed_1413, ((-0.0f) - fragment_unnamed_1397) + fragment_uniform_buffer_0[fragment_unnamed_1418].w, fragment_unnamed_1397)) * mad(fragment_unnamed_1220, (fragment_unnamed_1335 * mad(fragment_unnamed_1335, fragment_unnamed_1335, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_1345].x, fragment_unnamed_1226))));
				float fragment_unnamed_1537 = fragment_unnamed_1535 * (fragment_unnamed_664 * (fragment_unnamed_1442 * ((fragment_unnamed_1369 * mad(fragment_unnamed_1413, ((-0.0f) - fragment_unnamed_1398) + fragment_uniform_buffer_0[fragment_unnamed_1418].w, fragment_unnamed_1398)) * mad(fragment_unnamed_1222, (fragment_unnamed_1336 * mad(fragment_unnamed_1336, fragment_unnamed_1336, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_1345].y, fragment_unnamed_1228))));
				float fragment_unnamed_1538 = fragment_unnamed_1535 * (fragment_unnamed_664 * (fragment_unnamed_1442 * ((fragment_unnamed_1369 * mad(fragment_unnamed_1413, ((-0.0f) - fragment_unnamed_1399) + fragment_uniform_buffer_0[fragment_unnamed_1418].w, fragment_unnamed_1399)) * mad(fragment_unnamed_1224, (fragment_unnamed_1337 * mad(fragment_unnamed_1337, fragment_unnamed_1337, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_1345].z, fragment_unnamed_1230))));
				bool fragment_unnamed_1551 = (((fragment_unnamed_1538 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1537 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1536 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1551 ? asfloat(1157627904u) : fragment_unnamed_1536;
				fragment_output_3.y = fragment_unnamed_1551 ? fragment_unnamed_664 : fragment_unnamed_1537;
				fragment_output_3.z = fragment_unnamed_1551 ? asfloat(1149239296u) : fragment_unnamed_1538;
				fragment_output_0.x = fragment_unnamed_828;
				fragment_output_0.y = fragment_unnamed_829;
				fragment_output_0.z = fragment_unnamed_830;
				fragment_output_0.w = fragment_unnamed_1522;
				fragment_output_1.w = fragment_unnamed_1233;
				fragment_output_2.x = 1.0f;
				fragment_output_2.w = 0.01176470704376697540283203125f;
				fragment_output_2.y = fragment_uniform_buffer_2[15u].x;
				fragment_output_2.z = fragment_unnamed_1522;
				fragment_output_3.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], fragment_uniform_buffer_0[118][1], fragment_uniform_buffer_0[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_0[129] = float4(_ShapeParamsAndMaxScatterDists[0][0], _ShapeParamsAndMaxScatterDists[0][1], _ShapeParamsAndMaxScatterDists[0][2], _ShapeParamsAndMaxScatterDists[0][3]);
				fragment_uniform_buffer_0[130] = float4(_ShapeParamsAndMaxScatterDists[1][0], _ShapeParamsAndMaxScatterDists[1][1], _ShapeParamsAndMaxScatterDists[1][2], _ShapeParamsAndMaxScatterDists[1][3]);
				fragment_uniform_buffer_0[131] = float4(_ShapeParamsAndMaxScatterDists[2][0], _ShapeParamsAndMaxScatterDists[2][1], _ShapeParamsAndMaxScatterDists[2][2], _ShapeParamsAndMaxScatterDists[2][3]);
				fragment_uniform_buffer_0[132] = float4(_ShapeParamsAndMaxScatterDists[3][0], _ShapeParamsAndMaxScatterDists[3][1], _ShapeParamsAndMaxScatterDists[3][2], _ShapeParamsAndMaxScatterDists[3][3]);
				fragment_uniform_buffer_0[133] = float4(_ShapeParamsAndMaxScatterDists[4][0], _ShapeParamsAndMaxScatterDists[4][1], _ShapeParamsAndMaxScatterDists[4][2], _ShapeParamsAndMaxScatterDists[4][3]);
				fragment_uniform_buffer_0[134] = float4(_ShapeParamsAndMaxScatterDists[5][0], _ShapeParamsAndMaxScatterDists[5][1], _ShapeParamsAndMaxScatterDists[5][2], _ShapeParamsAndMaxScatterDists[5][3]);
				fragment_uniform_buffer_0[135] = float4(_ShapeParamsAndMaxScatterDists[6][0], _ShapeParamsAndMaxScatterDists[6][1], _ShapeParamsAndMaxScatterDists[6][2], _ShapeParamsAndMaxScatterDists[6][3]);
				fragment_uniform_buffer_0[136] = float4(_ShapeParamsAndMaxScatterDists[7][0], _ShapeParamsAndMaxScatterDists[7][1], _ShapeParamsAndMaxScatterDists[7][2], _ShapeParamsAndMaxScatterDists[7][3]);
				fragment_uniform_buffer_0[137] = float4(_ShapeParamsAndMaxScatterDists[8][0], _ShapeParamsAndMaxScatterDists[8][1], _ShapeParamsAndMaxScatterDists[8][2], _ShapeParamsAndMaxScatterDists[8][3]);
				fragment_uniform_buffer_0[138] = float4(_ShapeParamsAndMaxScatterDists[9][0], _ShapeParamsAndMaxScatterDists[9][1], _ShapeParamsAndMaxScatterDists[9][2], _ShapeParamsAndMaxScatterDists[9][3]);
				fragment_uniform_buffer_0[139] = float4(_ShapeParamsAndMaxScatterDists[10][0], _ShapeParamsAndMaxScatterDists[10][1], _ShapeParamsAndMaxScatterDists[10][2], _ShapeParamsAndMaxScatterDists[10][3]);
				fragment_uniform_buffer_0[140] = float4(_ShapeParamsAndMaxScatterDists[11][0], _ShapeParamsAndMaxScatterDists[11][1], _ShapeParamsAndMaxScatterDists[11][2], _ShapeParamsAndMaxScatterDists[11][3]);
				fragment_uniform_buffer_0[141] = float4(_ShapeParamsAndMaxScatterDists[12][0], _ShapeParamsAndMaxScatterDists[12][1], _ShapeParamsAndMaxScatterDists[12][2], _ShapeParamsAndMaxScatterDists[12][3]);
				fragment_uniform_buffer_0[142] = float4(_ShapeParamsAndMaxScatterDists[13][0], _ShapeParamsAndMaxScatterDists[13][1], _ShapeParamsAndMaxScatterDists[13][2], _ShapeParamsAndMaxScatterDists[13][3]);
				fragment_uniform_buffer_0[143] = float4(_ShapeParamsAndMaxScatterDists[14][0], _ShapeParamsAndMaxScatterDists[14][1], _ShapeParamsAndMaxScatterDists[14][2], _ShapeParamsAndMaxScatterDists[14][3]);
				fragment_uniform_buffer_0[144] = float4(_ShapeParamsAndMaxScatterDists[15][0], _ShapeParamsAndMaxScatterDists[15][1], _ShapeParamsAndMaxScatterDists[15][2], _ShapeParamsAndMaxScatterDists[15][3]);

				fragment_uniform_buffer_0[145] = float4(_TransmissionTintsAndFresnel0[0][0], _TransmissionTintsAndFresnel0[0][1], _TransmissionTintsAndFresnel0[0][2], _TransmissionTintsAndFresnel0[0][3]);
				fragment_uniform_buffer_0[146] = float4(_TransmissionTintsAndFresnel0[1][0], _TransmissionTintsAndFresnel0[1][1], _TransmissionTintsAndFresnel0[1][2], _TransmissionTintsAndFresnel0[1][3]);
				fragment_uniform_buffer_0[147] = float4(_TransmissionTintsAndFresnel0[2][0], _TransmissionTintsAndFresnel0[2][1], _TransmissionTintsAndFresnel0[2][2], _TransmissionTintsAndFresnel0[2][3]);
				fragment_uniform_buffer_0[148] = float4(_TransmissionTintsAndFresnel0[3][0], _TransmissionTintsAndFresnel0[3][1], _TransmissionTintsAndFresnel0[3][2], _TransmissionTintsAndFresnel0[3][3]);
				fragment_uniform_buffer_0[149] = float4(_TransmissionTintsAndFresnel0[4][0], _TransmissionTintsAndFresnel0[4][1], _TransmissionTintsAndFresnel0[4][2], _TransmissionTintsAndFresnel0[4][3]);
				fragment_uniform_buffer_0[150] = float4(_TransmissionTintsAndFresnel0[5][0], _TransmissionTintsAndFresnel0[5][1], _TransmissionTintsAndFresnel0[5][2], _TransmissionTintsAndFresnel0[5][3]);
				fragment_uniform_buffer_0[151] = float4(_TransmissionTintsAndFresnel0[6][0], _TransmissionTintsAndFresnel0[6][1], _TransmissionTintsAndFresnel0[6][2], _TransmissionTintsAndFresnel0[6][3]);
				fragment_uniform_buffer_0[152] = float4(_TransmissionTintsAndFresnel0[7][0], _TransmissionTintsAndFresnel0[7][1], _TransmissionTintsAndFresnel0[7][2], _TransmissionTintsAndFresnel0[7][3]);
				fragment_uniform_buffer_0[153] = float4(_TransmissionTintsAndFresnel0[8][0], _TransmissionTintsAndFresnel0[8][1], _TransmissionTintsAndFresnel0[8][2], _TransmissionTintsAndFresnel0[8][3]);
				fragment_uniform_buffer_0[154] = float4(_TransmissionTintsAndFresnel0[9][0], _TransmissionTintsAndFresnel0[9][1], _TransmissionTintsAndFresnel0[9][2], _TransmissionTintsAndFresnel0[9][3]);
				fragment_uniform_buffer_0[155] = float4(_TransmissionTintsAndFresnel0[10][0], _TransmissionTintsAndFresnel0[10][1], _TransmissionTintsAndFresnel0[10][2], _TransmissionTintsAndFresnel0[10][3]);
				fragment_uniform_buffer_0[156] = float4(_TransmissionTintsAndFresnel0[11][0], _TransmissionTintsAndFresnel0[11][1], _TransmissionTintsAndFresnel0[11][2], _TransmissionTintsAndFresnel0[11][3]);
				fragment_uniform_buffer_0[157] = float4(_TransmissionTintsAndFresnel0[12][0], _TransmissionTintsAndFresnel0[12][1], _TransmissionTintsAndFresnel0[12][2], _TransmissionTintsAndFresnel0[12][3]);
				fragment_uniform_buffer_0[158] = float4(_TransmissionTintsAndFresnel0[13][0], _TransmissionTintsAndFresnel0[13][1], _TransmissionTintsAndFresnel0[13][2], _TransmissionTintsAndFresnel0[13][3]);
				fragment_uniform_buffer_0[159] = float4(_TransmissionTintsAndFresnel0[14][0], _TransmissionTintsAndFresnel0[14][1], _TransmissionTintsAndFresnel0[14][2], _TransmissionTintsAndFresnel0[14][3]);
				fragment_uniform_buffer_0[160] = float4(_TransmissionTintsAndFresnel0[15][0], _TransmissionTintsAndFresnel0[15][1], _TransmissionTintsAndFresnel0[15][2], _TransmissionTintsAndFresnel0[15][3]);

				fragment_uniform_buffer_0[161] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[0][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[0][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[0][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[0][3]);
				fragment_uniform_buffer_0[162] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[1][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[1][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[1][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[1][3]);
				fragment_uniform_buffer_0[163] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[2][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[2][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[2][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[2][3]);
				fragment_uniform_buffer_0[164] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[3][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[3][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[3][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[3][3]);
				fragment_uniform_buffer_0[165] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[4][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[4][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[4][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[4][3]);
				fragment_uniform_buffer_0[166] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[5][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[5][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[5][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[5][3]);
				fragment_uniform_buffer_0[167] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[6][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[6][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[6][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[6][3]);
				fragment_uniform_buffer_0[168] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[7][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[7][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[7][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[7][3]);
				fragment_uniform_buffer_0[169] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[8][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[8][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[8][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[8][3]);
				fragment_uniform_buffer_0[170] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[9][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[9][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[9][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[9][3]);
				fragment_uniform_buffer_0[171] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[10][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[10][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[10][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[10][3]);
				fragment_uniform_buffer_0[172] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[11][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[11][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[11][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[11][3]);
				fragment_uniform_buffer_0[173] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[12][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[12][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[12][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[12][3]);
				fragment_uniform_buffer_0[174] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[13][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[13][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[13][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[13][3]);
				fragment_uniform_buffer_0[175] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[14][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[14][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[14][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[14][3]);
				fragment_uniform_buffer_0[176] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[15][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[15][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[15][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[15][3]);

				fragment_uniform_buffer_0[177] = float4(_DualLobeAndDiffusePower[0][0], _DualLobeAndDiffusePower[0][1], _DualLobeAndDiffusePower[0][2], _DualLobeAndDiffusePower[0][3]);
				fragment_uniform_buffer_0[178] = float4(_DualLobeAndDiffusePower[1][0], _DualLobeAndDiffusePower[1][1], _DualLobeAndDiffusePower[1][2], _DualLobeAndDiffusePower[1][3]);
				fragment_uniform_buffer_0[179] = float4(_DualLobeAndDiffusePower[2][0], _DualLobeAndDiffusePower[2][1], _DualLobeAndDiffusePower[2][2], _DualLobeAndDiffusePower[2][3]);
				fragment_uniform_buffer_0[180] = float4(_DualLobeAndDiffusePower[3][0], _DualLobeAndDiffusePower[3][1], _DualLobeAndDiffusePower[3][2], _DualLobeAndDiffusePower[3][3]);
				fragment_uniform_buffer_0[181] = float4(_DualLobeAndDiffusePower[4][0], _DualLobeAndDiffusePower[4][1], _DualLobeAndDiffusePower[4][2], _DualLobeAndDiffusePower[4][3]);
				fragment_uniform_buffer_0[182] = float4(_DualLobeAndDiffusePower[5][0], _DualLobeAndDiffusePower[5][1], _DualLobeAndDiffusePower[5][2], _DualLobeAndDiffusePower[5][3]);
				fragment_uniform_buffer_0[183] = float4(_DualLobeAndDiffusePower[6][0], _DualLobeAndDiffusePower[6][1], _DualLobeAndDiffusePower[6][2], _DualLobeAndDiffusePower[6][3]);
				fragment_uniform_buffer_0[184] = float4(_DualLobeAndDiffusePower[7][0], _DualLobeAndDiffusePower[7][1], _DualLobeAndDiffusePower[7][2], _DualLobeAndDiffusePower[7][3]);
				fragment_uniform_buffer_0[185] = float4(_DualLobeAndDiffusePower[8][0], _DualLobeAndDiffusePower[8][1], _DualLobeAndDiffusePower[8][2], _DualLobeAndDiffusePower[8][3]);
				fragment_uniform_buffer_0[186] = float4(_DualLobeAndDiffusePower[9][0], _DualLobeAndDiffusePower[9][1], _DualLobeAndDiffusePower[9][2], _DualLobeAndDiffusePower[9][3]);
				fragment_uniform_buffer_0[187] = float4(_DualLobeAndDiffusePower[10][0], _DualLobeAndDiffusePower[10][1], _DualLobeAndDiffusePower[10][2], _DualLobeAndDiffusePower[10][3]);
				fragment_uniform_buffer_0[188] = float4(_DualLobeAndDiffusePower[11][0], _DualLobeAndDiffusePower[11][1], _DualLobeAndDiffusePower[11][2], _DualLobeAndDiffusePower[11][3]);
				fragment_uniform_buffer_0[189] = float4(_DualLobeAndDiffusePower[12][0], _DualLobeAndDiffusePower[12][1], _DualLobeAndDiffusePower[12][2], _DualLobeAndDiffusePower[12][3]);
				fragment_uniform_buffer_0[190] = float4(_DualLobeAndDiffusePower[13][0], _DualLobeAndDiffusePower[13][1], _DualLobeAndDiffusePower[13][2], _DualLobeAndDiffusePower[13][3]);
				fragment_uniform_buffer_0[191] = float4(_DualLobeAndDiffusePower[14][0], _DualLobeAndDiffusePower[14][1], _DualLobeAndDiffusePower[14][2], _DualLobeAndDiffusePower[14][3]);
				fragment_uniform_buffer_0[192] = float4(_DualLobeAndDiffusePower[15][0], _DualLobeAndDiffusePower[15][1], _DualLobeAndDiffusePower[15][2], _DualLobeAndDiffusePower[15][3]);

				fragment_uniform_buffer_0[193] = float4(asfloat(_DiffusionProfileHashTable[0][0]), asfloat(_DiffusionProfileHashTable[0][1]), asfloat(_DiffusionProfileHashTable[0][2]), asfloat(_DiffusionProfileHashTable[0][3]));
				fragment_uniform_buffer_0[194] = float4(asfloat(_DiffusionProfileHashTable[1][0]), asfloat(_DiffusionProfileHashTable[1][1]), asfloat(_DiffusionProfileHashTable[1][2]), asfloat(_DiffusionProfileHashTable[1][3]));
				fragment_uniform_buffer_0[195] = float4(asfloat(_DiffusionProfileHashTable[2][0]), asfloat(_DiffusionProfileHashTable[2][1]), asfloat(_DiffusionProfileHashTable[2][2]), asfloat(_DiffusionProfileHashTable[2][3]));
				fragment_uniform_buffer_0[196] = float4(asfloat(_DiffusionProfileHashTable[3][0]), asfloat(_DiffusionProfileHashTable[3][1]), asfloat(_DiffusionProfileHashTable[3][2]), asfloat(_DiffusionProfileHashTable[3][3]));
				fragment_uniform_buffer_0[197] = float4(asfloat(_DiffusionProfileHashTable[4][0]), asfloat(_DiffusionProfileHashTable[4][1]), asfloat(_DiffusionProfileHashTable[4][2]), asfloat(_DiffusionProfileHashTable[4][3]));
				fragment_uniform_buffer_0[198] = float4(asfloat(_DiffusionProfileHashTable[5][0]), asfloat(_DiffusionProfileHashTable[5][1]), asfloat(_DiffusionProfileHashTable[5][2]), asfloat(_DiffusionProfileHashTable[5][3]));
				fragment_uniform_buffer_0[199] = float4(asfloat(_DiffusionProfileHashTable[6][0]), asfloat(_DiffusionProfileHashTable[6][1]), asfloat(_DiffusionProfileHashTable[6][2]), asfloat(_DiffusionProfileHashTable[6][3]));
				fragment_uniform_buffer_0[200] = float4(asfloat(_DiffusionProfileHashTable[7][0]), asfloat(_DiffusionProfileHashTable[7][1]), asfloat(_DiffusionProfileHashTable[7][2]), asfloat(_DiffusionProfileHashTable[7][3]));
				fragment_uniform_buffer_0[201] = float4(asfloat(_DiffusionProfileHashTable[8][0]), asfloat(_DiffusionProfileHashTable[8][1]), asfloat(_DiffusionProfileHashTable[8][2]), asfloat(_DiffusionProfileHashTable[8][3]));
				fragment_uniform_buffer_0[202] = float4(asfloat(_DiffusionProfileHashTable[9][0]), asfloat(_DiffusionProfileHashTable[9][1]), asfloat(_DiffusionProfileHashTable[9][2]), asfloat(_DiffusionProfileHashTable[9][3]));
				fragment_uniform_buffer_0[203] = float4(asfloat(_DiffusionProfileHashTable[10][0]), asfloat(_DiffusionProfileHashTable[10][1]), asfloat(_DiffusionProfileHashTable[10][2]), asfloat(_DiffusionProfileHashTable[10][3]));
				fragment_uniform_buffer_0[204] = float4(asfloat(_DiffusionProfileHashTable[11][0]), asfloat(_DiffusionProfileHashTable[11][1]), asfloat(_DiffusionProfileHashTable[11][2]), asfloat(_DiffusionProfileHashTable[11][3]));
				fragment_uniform_buffer_0[205] = float4(asfloat(_DiffusionProfileHashTable[12][0]), asfloat(_DiffusionProfileHashTable[12][1]), asfloat(_DiffusionProfileHashTable[12][2]), asfloat(_DiffusionProfileHashTable[12][3]));
				fragment_uniform_buffer_0[206] = float4(asfloat(_DiffusionProfileHashTable[13][0]), asfloat(_DiffusionProfileHashTable[13][1]), asfloat(_DiffusionProfileHashTable[13][2]), asfloat(_DiffusionProfileHashTable[13][3]));
				fragment_uniform_buffer_0[207] = float4(asfloat(_DiffusionProfileHashTable[14][0]), asfloat(_DiffusionProfileHashTable[14][1]), asfloat(_DiffusionProfileHashTable[14][2]), asfloat(_DiffusionProfileHashTable[14][3]));
				fragment_uniform_buffer_0[208] = float4(asfloat(_DiffusionProfileHashTable[15][0]), asfloat(_DiffusionProfileHashTable[15][1]), asfloat(_DiffusionProfileHashTable[15][2]), asfloat(_DiffusionProfileHashTable[15][3]));

				fragment_uniform_buffer_0[209] = float4(asfloat(_EnableSubsurfaceScattering), fragment_uniform_buffer_0[209][1], fragment_uniform_buffer_0[209][2], fragment_uniform_buffer_0[209][3]);

				fragment_uniform_buffer_0[209] = float4(fragment_uniform_buffer_0[209][0], asfloat(_TexturingModeFlags), fragment_uniform_buffer_0[209][2], fragment_uniform_buffer_0[209][3]);

				fragment_uniform_buffer_0[209] = float4(fragment_uniform_buffer_0[209][0], fragment_uniform_buffer_0[209][1], asfloat(_TransmissionFlags), fragment_uniform_buffer_0[209][3]);

				fragment_uniform_buffer_0[209] = float4(fragment_uniform_buffer_0[209][0], fragment_uniform_buffer_0[209][1], fragment_uniform_buffer_0[209][2], asfloat(_DiffusionProfileCount));

				fragment_uniform_buffer_0[210] = float4(fragment_uniform_buffer_0[210][0], fragment_uniform_buffer_0[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_0[210][3]);

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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

				fragment_uniform_buffer_2[1] = float4(_DiffusionProfileHash, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[15] = float4(_Thickness, fragment_uniform_buffer_2[15][1], fragment_uniform_buffer_2[15][2], fragment_uniform_buffer_2[15][3]);

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

			#endif // defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && defined(_MATERIAL_FEATURE_TRANSMISSION) && !defined(_DISABLE_DECALS)


			#if defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_MATERIAL_FEATURE_TRANSMISSION) && !defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _ReplaceDiffuseForIndirect;
			float4 _ShapeParamsAndMaxScatterDists[16];
			float4 _TransmissionTintsAndFresnel0[16];
			float4 _WorldScalesAndFilterRadiiAndThicknessRemaps[16];
			int4 _DiffusionProfileHashTable[16];
			int _DiffusionProfileCount;
			float4x4 unity_WorldToObject;
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
			float _DiffusionProfileHash;
			float _Thickness;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[16];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _DetailMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_DetailMap;

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
				float fragment_unnamed_94 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_114 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_170 = fragment_unnamed_94 * fragment_input_7.x;
				float fragment_unnamed_171 = fragment_unnamed_94 * fragment_input_7.y;
				float fragment_unnamed_172 = fragment_unnamed_94 * fragment_input_7.z;
				float fragment_unnamed_173 = fragment_unnamed_94 * fragment_input_7.z;
				bool fragment_unnamed_178 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_204 = asfloat(fragment_unnamed_178 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_211 = asfloat(fragment_unnamed_178 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_218 = asfloat(fragment_unnamed_178 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_222 = rsqrt(dot(float3(fragment_unnamed_204, fragment_unnamed_211, fragment_unnamed_218), float3(fragment_unnamed_204, fragment_unnamed_211, fragment_unnamed_218)));
				bool fragment_unnamed_294 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_304 = (fragment_unnamed_294 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_6.x) * fragment_uniform_buffer_2[8u].w;
				float fragment_unnamed_305 = (fragment_unnamed_294 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_6.z) * fragment_uniform_buffer_2[8u].w;
				float fragment_unnamed_314 = mad(fragment_unnamed_304, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z);
				float fragment_unnamed_315 = mad(fragment_unnamed_305, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w);
				bool fragment_unnamed_319 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_330 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_332 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_334 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_354 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_384 = asfloat(fragment_unnamed_319 ? asuint(fragment_unnamed_314) : asuint(mad(mad(fragment_unnamed_330, fragment_input_2.x, fragment_unnamed_332 * fragment_input_3.x) + mad(fragment_unnamed_334, fragment_input_4.x, fragment_unnamed_354 * fragment_input_5.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_386 = asfloat(fragment_unnamed_319 ? asuint(fragment_unnamed_315) : asuint(mad(mad(fragment_unnamed_330, fragment_input_2.y, fragment_unnamed_332 * fragment_input_3.y) + mad(fragment_unnamed_334, fragment_input_4.y, fragment_unnamed_354 * fragment_input_5.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				float4 fragment_unnamed_393 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_384, fragment_unnamed_386), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_396 = fragment_unnamed_393.x;
				float fragment_unnamed_397 = fragment_unnamed_393.y;
				float fragment_unnamed_398 = fragment_unnamed_393.z;
				float fragment_unnamed_404 = fragment_unnamed_396 * fragment_uniform_buffer_2[2u].x;
				float fragment_unnamed_405 = fragment_unnamed_397 * fragment_uniform_buffer_2[2u].y;
				float fragment_unnamed_406 = fragment_unnamed_398 * fragment_uniform_buffer_2[2u].z;
				bool fragment_unnamed_410 = fragment_uniform_buffer_2[8u].y < 4.0f;
				bool fragment_unnamed_436 = 0.0f != fragment_uniform_buffer_2[12u].y;
				uint4 fragment_unnamed_443 = asuint(fragment_uniform_buffer_2[14u]);
				float fragment_unnamed_468 = asfloat(((fragment_uniform_buffer_2[12u].x == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_470 = asfloat(((fragment_uniform_buffer_2[12u].x == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_472 = asfloat(((fragment_uniform_buffer_2[12u].x == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_474 = asfloat(((fragment_uniform_buffer_2[12u].x == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				float4 fragment_unnamed_533 = _DetailMap.SampleBias(sampler_DetailMap, float2(asfloat(fragment_unnamed_410 ? asuint(mad(mad(fragment_unnamed_468, fragment_input_2.x, fragment_unnamed_470 * fragment_input_3.x) + mad(fragment_unnamed_472, fragment_input_4.x, fragment_unnamed_474 * fragment_input_5.x), asfloat(fragment_unnamed_436 ? asuint(fragment_uniform_buffer_2[9u].x * fragment_uniform_buffer_2[14u].x) : fragment_unnamed_443.x), asfloat(fragment_unnamed_436 ? asuint(fragment_uniform_buffer_2[9u].z + fragment_uniform_buffer_2[14u].z) : fragment_unnamed_443.z))) : asuint(mad(asfloat(fragment_unnamed_436 ? asuint(fragment_unnamed_314) : asuint(fragment_unnamed_304)), fragment_uniform_buffer_2[14u].x, fragment_uniform_buffer_2[14u].z))), asfloat(fragment_unnamed_410 ? asuint(mad(mad(fragment_unnamed_468, fragment_input_2.y, fragment_unnamed_470 * fragment_input_3.y) + mad(fragment_unnamed_472, fragment_input_4.y, fragment_unnamed_474 * fragment_input_5.y), asfloat(fragment_unnamed_436 ? asuint(fragment_uniform_buffer_2[9u].y * fragment_uniform_buffer_2[14u].y) : fragment_unnamed_443.y), asfloat(fragment_unnamed_436 ? asuint(fragment_uniform_buffer_2[9u].w + fragment_uniform_buffer_2[14u].w) : fragment_unnamed_443.w))) : asuint(mad(asfloat(fragment_unnamed_436 ? asuint(fragment_unnamed_315) : asuint(fragment_unnamed_305)), fragment_uniform_buffer_2[14u].y, fragment_uniform_buffer_2[14u].w)))), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_539 = mad(fragment_unnamed_533.w, 2.0f, -1.0f);
				float fragment_unnamed_541 = mad(fragment_unnamed_533.y, 2.0f, -1.0f);
				float fragment_unnamed_542 = mad(fragment_unnamed_533.x, 2.0f, -1.0f);
				float fragment_unnamed_543 = mad(fragment_unnamed_533.z, 2.0f, -1.0f);
				float4 fragment_unnamed_548 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_unnamed_384, fragment_unnamed_386), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_551 = fragment_unnamed_548.z;
				float fragment_unnamed_553 = sqrt(fragment_unnamed_404);
				float fragment_unnamed_554 = sqrt(fragment_unnamed_405);
				float fragment_unnamed_555 = sqrt(fragment_unnamed_406);
				float fragment_unnamed_559 = asfloat((fragment_unnamed_542 < 0.0f) ? 0u : 1065353216u);
				float fragment_unnamed_567 = clamp(abs(fragment_unnamed_542) * fragment_uniform_buffer_2[12u].z, 0.0f, 1.0f);
				float fragment_unnamed_568 = fragment_unnamed_567 * fragment_unnamed_567;
				float fragment_unnamed_575 = mad(fragment_unnamed_568, ((-0.0f) - fragment_unnamed_553) + fragment_unnamed_559, fragment_unnamed_553);
				float fragment_unnamed_576 = mad(fragment_unnamed_568, ((-0.0f) - fragment_unnamed_554) + fragment_unnamed_559, fragment_unnamed_554);
				float fragment_unnamed_577 = mad(fragment_unnamed_568, ((-0.0f) - fragment_unnamed_555) + fragment_unnamed_559, fragment_unnamed_555);
				bool fragment_unnamed_602 = 0.0f != fragment_uniform_buffer_2[10u].x;
				float fragment_unnamed_610 = asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_551, mad((-0.0f) - fragment_uniform_buffer_2[2u].x, fragment_unnamed_396, min(fragment_unnamed_575 * fragment_unnamed_575, 1.0f)), fragment_unnamed_404)) : asuint(fragment_unnamed_404));
				float fragment_unnamed_612 = asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_551, mad((-0.0f) - fragment_uniform_buffer_2[2u].y, fragment_unnamed_397, min(fragment_unnamed_576 * fragment_unnamed_576, 1.0f)), fragment_unnamed_405)) : asuint(fragment_unnamed_405));
				float fragment_unnamed_614 = asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_551, mad((-0.0f) - fragment_uniform_buffer_2[2u].z, fragment_unnamed_398, min(fragment_unnamed_577 * fragment_unnamed_577, 1.0f)), fragment_unnamed_406)) : asuint(fragment_unnamed_406));
				float fragment_unnamed_626 = mad(fragment_unnamed_548.w, ((-0.0f) - fragment_uniform_buffer_2[5u].y) + fragment_uniform_buffer_2[5u].z, fragment_uniform_buffer_2[5u].y);
				float fragment_unnamed_656 = mad(fragment_unnamed_548.y, ((-0.0f) - fragment_uniform_buffer_2[5u].w) + fragment_uniform_buffer_2[6u].x, fragment_uniform_buffer_2[5u].w);
				float4 fragment_unnamed_661 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_unnamed_384, fragment_unnamed_386), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_667 = mad(fragment_unnamed_661.x * fragment_unnamed_661.w, 2.0f, -1.0f);
				float fragment_unnamed_668 = mad(fragment_unnamed_661.y, 2.0f, -1.0f);
				float fragment_unnamed_681 = fragment_unnamed_667 * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_682 = fragment_unnamed_668 * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_686 = clamp(fragment_uniform_buffer_2[8u].x, 0.0f, 1.0f);
				float fragment_unnamed_687 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_667, fragment_unnamed_668), float2(fragment_unnamed_667, fragment_unnamed_668)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f);
				float fragment_unnamed_695 = sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_539, fragment_unnamed_541), float2(fragment_unnamed_539, fragment_unnamed_541)), 1.0f)) + 1.0f);
				float fragment_unnamed_699 = rsqrt(dot(float3(fragment_unnamed_539, fragment_unnamed_541, fragment_unnamed_695), float3(fragment_unnamed_539, fragment_unnamed_541, fragment_unnamed_695)));
				float fragment_unnamed_705 = fragment_unnamed_551 * fragment_uniform_buffer_2[12u].w;
				float fragment_unnamed_711 = fragment_unnamed_681 + 0.0f;
				float fragment_unnamed_712 = fragment_unnamed_682 + 0.0f;
				float fragment_unnamed_713 = (fragment_unnamed_687 * fragment_unnamed_686) + 2.0f;
				float fragment_unnamed_714 = ((fragment_unnamed_539 * fragment_unnamed_699) * fragment_unnamed_705) * (-1.0f);
				float fragment_unnamed_715 = ((fragment_unnamed_541 * fragment_unnamed_699) * fragment_unnamed_705) * (-1.0f);
				float fragment_unnamed_716 = mad(clamp(fragment_unnamed_705, 0.0f, 1.0f), mad(fragment_unnamed_695, fragment_unnamed_699, -1.0f), 1.0f) * 1.0f;
				float fragment_unnamed_720 = dot(float3(fragment_unnamed_711, fragment_unnamed_712, fragment_unnamed_713), float3(fragment_unnamed_714, fragment_unnamed_715, fragment_unnamed_716));
				float fragment_unnamed_737 = asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_711 / fragment_unnamed_713, fragment_unnamed_720, (-0.0f) - fragment_unnamed_714)) : asuint(fragment_unnamed_681));
				float fragment_unnamed_739 = asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_712 / fragment_unnamed_713, fragment_unnamed_720, (-0.0f) - fragment_unnamed_715)) : asuint(fragment_unnamed_682));
				float fragment_unnamed_741 = asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_713 / fragment_unnamed_713, fragment_unnamed_720, (-0.0f) - fragment_unnamed_716)) : asuint(mad(fragment_unnamed_686, fragment_unnamed_687, 1.0f)));
				float fragment_unnamed_748 = mad(fragment_unnamed_741, fragment_unnamed_170, mad(fragment_unnamed_737, fragment_unnamed_94 * fragment_input_1.x, (fragment_unnamed_94 * (fragment_unnamed_114 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_739));
				float fragment_unnamed_749 = mad(fragment_unnamed_741, fragment_unnamed_171, mad(fragment_unnamed_737, fragment_unnamed_94 * fragment_input_1.y, (fragment_unnamed_94 * (fragment_unnamed_114 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_739));
				float fragment_unnamed_750 = mad(fragment_unnamed_741, fragment_unnamed_173, mad(fragment_unnamed_737, fragment_unnamed_94 * fragment_input_1.z, (fragment_unnamed_94 * (fragment_unnamed_114 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_739));
				float fragment_unnamed_755 = rsqrt(max(dot(float3(fragment_unnamed_748, fragment_unnamed_749, fragment_unnamed_750), float3(fragment_unnamed_748, fragment_unnamed_749, fragment_unnamed_750)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_756 = fragment_unnamed_755 * fragment_unnamed_748;
				float fragment_unnamed_757 = fragment_unnamed_755 * fragment_unnamed_749;
				float fragment_unnamed_758 = fragment_unnamed_755 * fragment_unnamed_750;
				uint4 fragment_unnamed_772 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_773 = fragment_unnamed_772.x;
				float fragment_unnamed_1144;
				float fragment_unnamed_1146;
				float fragment_unnamed_1148;
				float fragment_unnamed_1150;
				float fragment_unnamed_1152;
				float fragment_unnamed_1154;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_773 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_773 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_788 = (-0.0f) - fragment_unnamed_170;
					float fragment_unnamed_789 = (-0.0f) - fragment_unnamed_171;
					float fragment_unnamed_790 = (-0.0f) - fragment_unnamed_173;
					float fragment_unnamed_1145;
					float fragment_unnamed_1147;
					float fragment_unnamed_1149;
					float fragment_unnamed_1151;
					float fragment_unnamed_1153;
					float fragment_unnamed_1155;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_802 = asfloat(1065353216u);
						float fragment_unnamed_830 = fragment_unnamed_757 * fragment_unnamed_756;
						float fragment_unnamed_831 = fragment_unnamed_758 * fragment_unnamed_757;
						float fragment_unnamed_832 = fragment_unnamed_758 * fragment_unnamed_758;
						float fragment_unnamed_833 = fragment_unnamed_756 * fragment_unnamed_758;
						float fragment_unnamed_865 = mad(fragment_unnamed_756, fragment_unnamed_756, (-0.0f) - (fragment_unnamed_757 * fragment_unnamed_757));
						float fragment_unnamed_878 = asfloat(1065353216u);
						float fragment_unnamed_906 = fragment_unnamed_171 * fragment_unnamed_170;
						float fragment_unnamed_907 = fragment_unnamed_173 * fragment_unnamed_171;
						float fragment_unnamed_908 = fragment_unnamed_172 * fragment_unnamed_172;
						float fragment_unnamed_909 = fragment_unnamed_170 * fragment_unnamed_173;
						float fragment_unnamed_939 = mad(fragment_unnamed_170, fragment_unnamed_170, (-0.0f) - (fragment_unnamed_171 * fragment_unnamed_171));
						fragment_unnamed_1145 = mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_939, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_906, fragment_unnamed_907, fragment_unnamed_908, fragment_unnamed_909))) + dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_878));
						fragment_unnamed_1147 = mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_939, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_906, fragment_unnamed_907, fragment_unnamed_908, fragment_unnamed_909))) + dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_878));
						fragment_unnamed_1149 = mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_939, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_906, fragment_unnamed_907, fragment_unnamed_908, fragment_unnamed_909))) + dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_878));
						fragment_unnamed_1151 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_802)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_865, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_830, fragment_unnamed_831, fragment_unnamed_832, fragment_unnamed_833)));
						fragment_unnamed_1153 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_802)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_865, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_830, fragment_unnamed_831, fragment_unnamed_832, fragment_unnamed_833)));
						fragment_unnamed_1155 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_802)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_865, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_830, fragment_unnamed_831, fragment_unnamed_832, fragment_unnamed_833)));
					}
					else
					{
						bool fragment_unnamed_954 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_955 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_976 = fragment_unnamed_954 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_977 = fragment_unnamed_954 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_978 = fragment_unnamed_954 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_1082 = (asfloat(fragment_unnamed_955 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_978, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_976, fragment_unnamed_977 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_977)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_1083 = (asfloat(fragment_unnamed_955 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_978, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_976, fragment_unnamed_977 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_978)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_1097 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_955 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_978, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_976, fragment_unnamed_977 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_976)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float4 fragment_unnamed_1100 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1097, fragment_unnamed_1082, fragment_unnamed_1083), 0.0f);
						float fragment_unnamed_1102 = fragment_unnamed_1100.x;
						float4 fragment_unnamed_1109 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1097 + 0.25f, fragment_unnamed_1082 + 0.0f, fragment_unnamed_1083 + 0.0f), 0.0f);
						float fragment_unnamed_1111 = fragment_unnamed_1109.x;
						float4 fragment_unnamed_1118 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1097 + 0.5f, fragment_unnamed_1082 + 0.0f, fragment_unnamed_1083 + 0.0f), 0.0f);
						float fragment_unnamed_1120 = fragment_unnamed_1118.x;
						float fragment_unnamed_1124 = asfloat(1065353216u);
						float fragment_unnamed_1134 = asfloat(1065353216u);
						fragment_unnamed_1145 = dot(float4(fragment_unnamed_1102, fragment_unnamed_1100.yzw), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_1134));
						fragment_unnamed_1147 = dot(float4(fragment_unnamed_1111, fragment_unnamed_1109.yzw), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_1134));
						fragment_unnamed_1149 = dot(float4(fragment_unnamed_1120, fragment_unnamed_1118.yzw), float4(fragment_unnamed_788, fragment_unnamed_789, fragment_unnamed_790, fragment_unnamed_1134));
						fragment_unnamed_1151 = dot(float4(fragment_unnamed_1102, fragment_unnamed_1100.yzw), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_1124));
						fragment_unnamed_1153 = dot(float4(fragment_unnamed_1111, fragment_unnamed_1109.yzw), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_1124));
						fragment_unnamed_1155 = dot(float4(fragment_unnamed_1120, fragment_unnamed_1118.yzw), float4(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758, fragment_unnamed_1124));
					}
					fragment_unnamed_1144 = fragment_unnamed_1145;
					fragment_unnamed_1146 = fragment_unnamed_1147;
					fragment_unnamed_1148 = fragment_unnamed_1149;
					fragment_unnamed_1150 = fragment_unnamed_1151;
					fragment_unnamed_1152 = fragment_unnamed_1153;
					fragment_unnamed_1154 = fragment_unnamed_1155;
				}
				else
				{
					fragment_unnamed_1144 = asfloat(0u);
					fragment_unnamed_1146 = asfloat(0u);
					fragment_unnamed_1148 = asfloat(0u);
					fragment_unnamed_1150 = asfloat(0u);
					fragment_unnamed_1152 = asfloat(0u);
					fragment_unnamed_1154 = asfloat(0u);
				}
				float fragment_unnamed_1157 = ((-0.0f) - asfloat(fragment_unnamed_602 ? asuint(mad(fragment_unnamed_551, ((-0.0f) - fragment_unnamed_626) + clamp(mad(clamp(abs(fragment_unnamed_543) * fragment_uniform_buffer_2[13u].x, 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_626) + asfloat((fragment_unnamed_543 < 0.0f) ? 0u : 1065353216u), fragment_unnamed_626), 0.0f, 1.0f), fragment_unnamed_626)) : asuint(fragment_unnamed_626))) + 1.0f;
				float fragment_unnamed_1177;
				if (asuint(fragment_uniform_buffer_2[1u]).x != 0u)
				{
					float fragment_unnamed_1163 = asfloat(0u);
					float fragment_unnamed_1164 = asfloat(0u);
					float fragment_unnamed_1178;
					float fragment_unnamed_1166 = fragment_unnamed_1163;
					float fragment_unnamed_1168 = fragment_unnamed_1164;
					for (;;)
					{
						if (asuint(fragment_unnamed_1168) >= asuint(fragment_uniform_buffer_0[209u]).w)
						{
							fragment_unnamed_1178 = fragment_unnamed_1166;
							break;
						}
						else
						{
							if (!(asuint(fragment_uniform_buffer_2[1u]).x == asuint(fragment_uniform_buffer_0[asuint(fragment_unnamed_1168) + 193u]).x))
							{
								fragment_unnamed_1166 = asfloat(0u);
								fragment_unnamed_1168 = asfloat(asuint(fragment_unnamed_1168) + 1u);
								continue;
							}
							fragment_unnamed_1178 = fragment_unnamed_1168;
							break;
						}
					}
					fragment_unnamed_1177 = fragment_unnamed_1178;
				}
				else
				{
					fragment_unnamed_1177 = asfloat(0u);
				}
				float fragment_unnamed_1194 = mad(fragment_uniform_buffer_0[asuint(fragment_unnamed_1177) + 161u].w, fragment_uniform_buffer_2[15u].x, fragment_uniform_buffer_0[asuint(fragment_unnamed_1177) + 161u].z) * (-0.4808983504772186279296875f);
				uint fragment_unnamed_1197 = asuint(fragment_unnamed_1177) + 129u;
				float fragment_unnamed_1207 = exp2(fragment_unnamed_1194 * fragment_uniform_buffer_0[fragment_unnamed_1197].x);
				float fragment_unnamed_1208 = exp2(fragment_unnamed_1194 * fragment_uniform_buffer_0[fragment_unnamed_1197].y);
				float fragment_unnamed_1209 = exp2(fragment_unnamed_1194 * fragment_uniform_buffer_0[fragment_unnamed_1197].z);
				uint fragment_unnamed_1217 = asuint(fragment_unnamed_1177) + 145u;
				float fragment_unnamed_1241 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_756, fragment_unnamed_757, fragment_unnamed_758), float3(fragment_unnamed_222 * fragment_unnamed_204, fragment_unnamed_222 * fragment_unnamed_211, fragment_unnamed_222 * fragment_unnamed_218)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_1157, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_1258 = clamp(((-0.20000000298023223876953125f) + fragment_uniform_buffer_0[asuint(fragment_unnamed_1177) + 145u].w) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				uint fragment_unnamed_1263 = asuint(fragment_unnamed_1177) + 145u;
				float fragment_unnamed_1287 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1292 = max(abs(fragment_unnamed_758), 0.0009765625f);
				float fragment_unnamed_1296 = (fragment_unnamed_758 >= 0.0f) ? fragment_unnamed_1292 : ((-0.0f) - fragment_unnamed_1292);
				float fragment_unnamed_1305 = 1.0f / max(dot(float3(abs(fragment_unnamed_756), abs(fragment_unnamed_757), abs(fragment_unnamed_1296)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1310 = clamp((-0.0f) - (fragment_unnamed_1305 * fragment_unnamed_1296), 0.0f, 1.0f);
				float fragment_unnamed_1313 = (-0.0f) - fragment_unnamed_1310;
				uint fragment_unnamed_1325 = uint(clamp(mad(mad(fragment_unnamed_756, fragment_unnamed_1305, ((fragment_unnamed_1305 * fragment_unnamed_756) >= 0.0f) ? fragment_unnamed_1310 : fragment_unnamed_1313), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1326 = uint(clamp(mad(mad(fragment_unnamed_757, fragment_unnamed_1305, ((fragment_unnamed_1305 * fragment_unnamed_757) >= 0.0f) ? fragment_unnamed_1310 : fragment_unnamed_1313), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1325 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1326 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1326 >> 8u) * 16u) + (fragment_unnamed_1325 >> 8u)) * 0.0039215688593685626983642578125f;
				float fragment_unnamed_1377;
				if (asuint(fragment_uniform_buffer_2[1u]).x != 0u)
				{
					float fragment_unnamed_1362 = asfloat(0u);
					float fragment_unnamed_1363 = asfloat(0u);
					float fragment_unnamed_1378;
					float fragment_unnamed_1367 = fragment_unnamed_1363;
					float fragment_unnamed_1369 = fragment_unnamed_1362;
					for (;;)
					{
						if (asuint(fragment_unnamed_1367) >= asuint(fragment_uniform_buffer_0[209u]).w)
						{
							fragment_unnamed_1378 = fragment_unnamed_1369;
							break;
						}
						else
						{
							if (!(asuint(fragment_uniform_buffer_2[1u]).x == asuint(fragment_uniform_buffer_0[asuint(fragment_unnamed_1367) + 193u]).x))
							{
								fragment_unnamed_1367 = asfloat(asuint(fragment_unnamed_1367) + 1u);
								fragment_unnamed_1369 = asfloat(0u);
								continue;
							}
							fragment_unnamed_1378 = fragment_unnamed_1367;
							break;
						}
					}
					fragment_unnamed_1377 = fragment_unnamed_1378;
				}
				else
				{
					fragment_unnamed_1377 = asfloat(0u);
				}
				float fragment_unnamed_1381 = mad(float(asuint(fragment_unnamed_1377)), 0.062745101749897003173828125f, 0.0588235296308994293212890625f);
				float fragment_unnamed_1394 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1395 = fragment_unnamed_1394 * (fragment_unnamed_656 * (fragment_unnamed_1287 * (mad(fragment_unnamed_1144, (fragment_unnamed_1207 * mad(fragment_unnamed_1207, fragment_unnamed_1207, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_1217].x, fragment_unnamed_1150) * (mad(fragment_unnamed_1258, ((-0.0f) - fragment_unnamed_610) + fragment_uniform_buffer_0[fragment_unnamed_1263].w, fragment_unnamed_610) * fragment_unnamed_1241))));
				float fragment_unnamed_1396 = fragment_unnamed_1394 * (fragment_unnamed_656 * (fragment_unnamed_1287 * (mad(fragment_unnamed_1146, (fragment_unnamed_1208 * mad(fragment_unnamed_1208, fragment_unnamed_1208, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_1217].y, fragment_unnamed_1152) * (mad(fragment_unnamed_1258, ((-0.0f) - fragment_unnamed_612) + fragment_uniform_buffer_0[fragment_unnamed_1263].w, fragment_unnamed_612) * fragment_unnamed_1241))));
				float fragment_unnamed_1397 = fragment_unnamed_1394 * (fragment_unnamed_656 * (fragment_unnamed_1287 * (mad(fragment_unnamed_1148, (fragment_unnamed_1209 * mad(fragment_unnamed_1209, fragment_unnamed_1209, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_1217].z, fragment_unnamed_1154) * (mad(fragment_unnamed_1258, ((-0.0f) - fragment_unnamed_614) + fragment_uniform_buffer_0[fragment_unnamed_1263].w, fragment_unnamed_614) * fragment_unnamed_1241))));
				bool fragment_unnamed_1410 = (((fragment_unnamed_1397 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1396 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1395 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1410 ? asfloat(1157627904u) : fragment_unnamed_1395;
				fragment_output_3.y = fragment_unnamed_1410 ? fragment_unnamed_656 : fragment_unnamed_1396;
				fragment_output_3.z = fragment_unnamed_1410 ? asfloat(1149239296u) : fragment_unnamed_1397;
				fragment_output_0.x = fragment_unnamed_610;
				fragment_output_0.y = fragment_unnamed_612;
				fragment_output_0.z = fragment_unnamed_614;
				fragment_output_0.w = fragment_unnamed_1381;
				fragment_output_1.w = fragment_unnamed_1157;
				fragment_output_2.x = 1.0f;
				fragment_output_2.w = 0.007843137718737125396728515625f;
				fragment_output_2.y = fragment_uniform_buffer_2[15u].x;
				fragment_output_2.z = fragment_unnamed_1381;
				fragment_output_3.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], fragment_uniform_buffer_0[118][1], fragment_uniform_buffer_0[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_0[129] = float4(_ShapeParamsAndMaxScatterDists[0][0], _ShapeParamsAndMaxScatterDists[0][1], _ShapeParamsAndMaxScatterDists[0][2], _ShapeParamsAndMaxScatterDists[0][3]);
				fragment_uniform_buffer_0[130] = float4(_ShapeParamsAndMaxScatterDists[1][0], _ShapeParamsAndMaxScatterDists[1][1], _ShapeParamsAndMaxScatterDists[1][2], _ShapeParamsAndMaxScatterDists[1][3]);
				fragment_uniform_buffer_0[131] = float4(_ShapeParamsAndMaxScatterDists[2][0], _ShapeParamsAndMaxScatterDists[2][1], _ShapeParamsAndMaxScatterDists[2][2], _ShapeParamsAndMaxScatterDists[2][3]);
				fragment_uniform_buffer_0[132] = float4(_ShapeParamsAndMaxScatterDists[3][0], _ShapeParamsAndMaxScatterDists[3][1], _ShapeParamsAndMaxScatterDists[3][2], _ShapeParamsAndMaxScatterDists[3][3]);
				fragment_uniform_buffer_0[133] = float4(_ShapeParamsAndMaxScatterDists[4][0], _ShapeParamsAndMaxScatterDists[4][1], _ShapeParamsAndMaxScatterDists[4][2], _ShapeParamsAndMaxScatterDists[4][3]);
				fragment_uniform_buffer_0[134] = float4(_ShapeParamsAndMaxScatterDists[5][0], _ShapeParamsAndMaxScatterDists[5][1], _ShapeParamsAndMaxScatterDists[5][2], _ShapeParamsAndMaxScatterDists[5][3]);
				fragment_uniform_buffer_0[135] = float4(_ShapeParamsAndMaxScatterDists[6][0], _ShapeParamsAndMaxScatterDists[6][1], _ShapeParamsAndMaxScatterDists[6][2], _ShapeParamsAndMaxScatterDists[6][3]);
				fragment_uniform_buffer_0[136] = float4(_ShapeParamsAndMaxScatterDists[7][0], _ShapeParamsAndMaxScatterDists[7][1], _ShapeParamsAndMaxScatterDists[7][2], _ShapeParamsAndMaxScatterDists[7][3]);
				fragment_uniform_buffer_0[137] = float4(_ShapeParamsAndMaxScatterDists[8][0], _ShapeParamsAndMaxScatterDists[8][1], _ShapeParamsAndMaxScatterDists[8][2], _ShapeParamsAndMaxScatterDists[8][3]);
				fragment_uniform_buffer_0[138] = float4(_ShapeParamsAndMaxScatterDists[9][0], _ShapeParamsAndMaxScatterDists[9][1], _ShapeParamsAndMaxScatterDists[9][2], _ShapeParamsAndMaxScatterDists[9][3]);
				fragment_uniform_buffer_0[139] = float4(_ShapeParamsAndMaxScatterDists[10][0], _ShapeParamsAndMaxScatterDists[10][1], _ShapeParamsAndMaxScatterDists[10][2], _ShapeParamsAndMaxScatterDists[10][3]);
				fragment_uniform_buffer_0[140] = float4(_ShapeParamsAndMaxScatterDists[11][0], _ShapeParamsAndMaxScatterDists[11][1], _ShapeParamsAndMaxScatterDists[11][2], _ShapeParamsAndMaxScatterDists[11][3]);
				fragment_uniform_buffer_0[141] = float4(_ShapeParamsAndMaxScatterDists[12][0], _ShapeParamsAndMaxScatterDists[12][1], _ShapeParamsAndMaxScatterDists[12][2], _ShapeParamsAndMaxScatterDists[12][3]);
				fragment_uniform_buffer_0[142] = float4(_ShapeParamsAndMaxScatterDists[13][0], _ShapeParamsAndMaxScatterDists[13][1], _ShapeParamsAndMaxScatterDists[13][2], _ShapeParamsAndMaxScatterDists[13][3]);
				fragment_uniform_buffer_0[143] = float4(_ShapeParamsAndMaxScatterDists[14][0], _ShapeParamsAndMaxScatterDists[14][1], _ShapeParamsAndMaxScatterDists[14][2], _ShapeParamsAndMaxScatterDists[14][3]);
				fragment_uniform_buffer_0[144] = float4(_ShapeParamsAndMaxScatterDists[15][0], _ShapeParamsAndMaxScatterDists[15][1], _ShapeParamsAndMaxScatterDists[15][2], _ShapeParamsAndMaxScatterDists[15][3]);

				fragment_uniform_buffer_0[145] = float4(_TransmissionTintsAndFresnel0[0][0], _TransmissionTintsAndFresnel0[0][1], _TransmissionTintsAndFresnel0[0][2], _TransmissionTintsAndFresnel0[0][3]);
				fragment_uniform_buffer_0[146] = float4(_TransmissionTintsAndFresnel0[1][0], _TransmissionTintsAndFresnel0[1][1], _TransmissionTintsAndFresnel0[1][2], _TransmissionTintsAndFresnel0[1][3]);
				fragment_uniform_buffer_0[147] = float4(_TransmissionTintsAndFresnel0[2][0], _TransmissionTintsAndFresnel0[2][1], _TransmissionTintsAndFresnel0[2][2], _TransmissionTintsAndFresnel0[2][3]);
				fragment_uniform_buffer_0[148] = float4(_TransmissionTintsAndFresnel0[3][0], _TransmissionTintsAndFresnel0[3][1], _TransmissionTintsAndFresnel0[3][2], _TransmissionTintsAndFresnel0[3][3]);
				fragment_uniform_buffer_0[149] = float4(_TransmissionTintsAndFresnel0[4][0], _TransmissionTintsAndFresnel0[4][1], _TransmissionTintsAndFresnel0[4][2], _TransmissionTintsAndFresnel0[4][3]);
				fragment_uniform_buffer_0[150] = float4(_TransmissionTintsAndFresnel0[5][0], _TransmissionTintsAndFresnel0[5][1], _TransmissionTintsAndFresnel0[5][2], _TransmissionTintsAndFresnel0[5][3]);
				fragment_uniform_buffer_0[151] = float4(_TransmissionTintsAndFresnel0[6][0], _TransmissionTintsAndFresnel0[6][1], _TransmissionTintsAndFresnel0[6][2], _TransmissionTintsAndFresnel0[6][3]);
				fragment_uniform_buffer_0[152] = float4(_TransmissionTintsAndFresnel0[7][0], _TransmissionTintsAndFresnel0[7][1], _TransmissionTintsAndFresnel0[7][2], _TransmissionTintsAndFresnel0[7][3]);
				fragment_uniform_buffer_0[153] = float4(_TransmissionTintsAndFresnel0[8][0], _TransmissionTintsAndFresnel0[8][1], _TransmissionTintsAndFresnel0[8][2], _TransmissionTintsAndFresnel0[8][3]);
				fragment_uniform_buffer_0[154] = float4(_TransmissionTintsAndFresnel0[9][0], _TransmissionTintsAndFresnel0[9][1], _TransmissionTintsAndFresnel0[9][2], _TransmissionTintsAndFresnel0[9][3]);
				fragment_uniform_buffer_0[155] = float4(_TransmissionTintsAndFresnel0[10][0], _TransmissionTintsAndFresnel0[10][1], _TransmissionTintsAndFresnel0[10][2], _TransmissionTintsAndFresnel0[10][3]);
				fragment_uniform_buffer_0[156] = float4(_TransmissionTintsAndFresnel0[11][0], _TransmissionTintsAndFresnel0[11][1], _TransmissionTintsAndFresnel0[11][2], _TransmissionTintsAndFresnel0[11][3]);
				fragment_uniform_buffer_0[157] = float4(_TransmissionTintsAndFresnel0[12][0], _TransmissionTintsAndFresnel0[12][1], _TransmissionTintsAndFresnel0[12][2], _TransmissionTintsAndFresnel0[12][3]);
				fragment_uniform_buffer_0[158] = float4(_TransmissionTintsAndFresnel0[13][0], _TransmissionTintsAndFresnel0[13][1], _TransmissionTintsAndFresnel0[13][2], _TransmissionTintsAndFresnel0[13][3]);
				fragment_uniform_buffer_0[159] = float4(_TransmissionTintsAndFresnel0[14][0], _TransmissionTintsAndFresnel0[14][1], _TransmissionTintsAndFresnel0[14][2], _TransmissionTintsAndFresnel0[14][3]);
				fragment_uniform_buffer_0[160] = float4(_TransmissionTintsAndFresnel0[15][0], _TransmissionTintsAndFresnel0[15][1], _TransmissionTintsAndFresnel0[15][2], _TransmissionTintsAndFresnel0[15][3]);

				fragment_uniform_buffer_0[161] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[0][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[0][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[0][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[0][3]);
				fragment_uniform_buffer_0[162] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[1][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[1][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[1][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[1][3]);
				fragment_uniform_buffer_0[163] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[2][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[2][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[2][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[2][3]);
				fragment_uniform_buffer_0[164] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[3][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[3][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[3][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[3][3]);
				fragment_uniform_buffer_0[165] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[4][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[4][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[4][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[4][3]);
				fragment_uniform_buffer_0[166] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[5][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[5][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[5][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[5][3]);
				fragment_uniform_buffer_0[167] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[6][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[6][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[6][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[6][3]);
				fragment_uniform_buffer_0[168] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[7][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[7][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[7][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[7][3]);
				fragment_uniform_buffer_0[169] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[8][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[8][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[8][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[8][3]);
				fragment_uniform_buffer_0[170] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[9][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[9][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[9][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[9][3]);
				fragment_uniform_buffer_0[171] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[10][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[10][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[10][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[10][3]);
				fragment_uniform_buffer_0[172] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[11][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[11][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[11][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[11][3]);
				fragment_uniform_buffer_0[173] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[12][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[12][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[12][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[12][3]);
				fragment_uniform_buffer_0[174] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[13][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[13][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[13][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[13][3]);
				fragment_uniform_buffer_0[175] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[14][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[14][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[14][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[14][3]);
				fragment_uniform_buffer_0[176] = float4(_WorldScalesAndFilterRadiiAndThicknessRemaps[15][0], _WorldScalesAndFilterRadiiAndThicknessRemaps[15][1], _WorldScalesAndFilterRadiiAndThicknessRemaps[15][2], _WorldScalesAndFilterRadiiAndThicknessRemaps[15][3]);

				fragment_uniform_buffer_0[193] = float4(asfloat(_DiffusionProfileHashTable[0][0]), asfloat(_DiffusionProfileHashTable[0][1]), asfloat(_DiffusionProfileHashTable[0][2]), asfloat(_DiffusionProfileHashTable[0][3]));
				fragment_uniform_buffer_0[194] = float4(asfloat(_DiffusionProfileHashTable[1][0]), asfloat(_DiffusionProfileHashTable[1][1]), asfloat(_DiffusionProfileHashTable[1][2]), asfloat(_DiffusionProfileHashTable[1][3]));
				fragment_uniform_buffer_0[195] = float4(asfloat(_DiffusionProfileHashTable[2][0]), asfloat(_DiffusionProfileHashTable[2][1]), asfloat(_DiffusionProfileHashTable[2][2]), asfloat(_DiffusionProfileHashTable[2][3]));
				fragment_uniform_buffer_0[196] = float4(asfloat(_DiffusionProfileHashTable[3][0]), asfloat(_DiffusionProfileHashTable[3][1]), asfloat(_DiffusionProfileHashTable[3][2]), asfloat(_DiffusionProfileHashTable[3][3]));
				fragment_uniform_buffer_0[197] = float4(asfloat(_DiffusionProfileHashTable[4][0]), asfloat(_DiffusionProfileHashTable[4][1]), asfloat(_DiffusionProfileHashTable[4][2]), asfloat(_DiffusionProfileHashTable[4][3]));
				fragment_uniform_buffer_0[198] = float4(asfloat(_DiffusionProfileHashTable[5][0]), asfloat(_DiffusionProfileHashTable[5][1]), asfloat(_DiffusionProfileHashTable[5][2]), asfloat(_DiffusionProfileHashTable[5][3]));
				fragment_uniform_buffer_0[199] = float4(asfloat(_DiffusionProfileHashTable[6][0]), asfloat(_DiffusionProfileHashTable[6][1]), asfloat(_DiffusionProfileHashTable[6][2]), asfloat(_DiffusionProfileHashTable[6][3]));
				fragment_uniform_buffer_0[200] = float4(asfloat(_DiffusionProfileHashTable[7][0]), asfloat(_DiffusionProfileHashTable[7][1]), asfloat(_DiffusionProfileHashTable[7][2]), asfloat(_DiffusionProfileHashTable[7][3]));
				fragment_uniform_buffer_0[201] = float4(asfloat(_DiffusionProfileHashTable[8][0]), asfloat(_DiffusionProfileHashTable[8][1]), asfloat(_DiffusionProfileHashTable[8][2]), asfloat(_DiffusionProfileHashTable[8][3]));
				fragment_uniform_buffer_0[202] = float4(asfloat(_DiffusionProfileHashTable[9][0]), asfloat(_DiffusionProfileHashTable[9][1]), asfloat(_DiffusionProfileHashTable[9][2]), asfloat(_DiffusionProfileHashTable[9][3]));
				fragment_uniform_buffer_0[203] = float4(asfloat(_DiffusionProfileHashTable[10][0]), asfloat(_DiffusionProfileHashTable[10][1]), asfloat(_DiffusionProfileHashTable[10][2]), asfloat(_DiffusionProfileHashTable[10][3]));
				fragment_uniform_buffer_0[204] = float4(asfloat(_DiffusionProfileHashTable[11][0]), asfloat(_DiffusionProfileHashTable[11][1]), asfloat(_DiffusionProfileHashTable[11][2]), asfloat(_DiffusionProfileHashTable[11][3]));
				fragment_uniform_buffer_0[205] = float4(asfloat(_DiffusionProfileHashTable[12][0]), asfloat(_DiffusionProfileHashTable[12][1]), asfloat(_DiffusionProfileHashTable[12][2]), asfloat(_DiffusionProfileHashTable[12][3]));
				fragment_uniform_buffer_0[206] = float4(asfloat(_DiffusionProfileHashTable[13][0]), asfloat(_DiffusionProfileHashTable[13][1]), asfloat(_DiffusionProfileHashTable[13][2]), asfloat(_DiffusionProfileHashTable[13][3]));
				fragment_uniform_buffer_0[207] = float4(asfloat(_DiffusionProfileHashTable[14][0]), asfloat(_DiffusionProfileHashTable[14][1]), asfloat(_DiffusionProfileHashTable[14][2]), asfloat(_DiffusionProfileHashTable[14][3]));
				fragment_uniform_buffer_0[208] = float4(asfloat(_DiffusionProfileHashTable[15][0]), asfloat(_DiffusionProfileHashTable[15][1]), asfloat(_DiffusionProfileHashTable[15][2]), asfloat(_DiffusionProfileHashTable[15][3]));

				fragment_uniform_buffer_0[209] = float4(fragment_uniform_buffer_0[209][0], fragment_uniform_buffer_0[209][1], fragment_uniform_buffer_0[209][2], asfloat(_DiffusionProfileCount));

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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

				fragment_uniform_buffer_2[1] = float4(_DiffusionProfileHash, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[15] = float4(_Thickness, fragment_uniform_buffer_2[15][1], fragment_uniform_buffer_2[15][2], fragment_uniform_buffer_2[15][3]);

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

			#endif // defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_MATERIAL_FEATURE_TRANSMISSION) && !defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING)


			#if defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(_DISABLE_DECALS) && !defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_MATERIAL_FEATURE_TRANSMISSION)
			#define ANY_SHADER_VARIANT_ACTIVE

			int _EnableDecals;
			float4x4 unity_WorldToObject;
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
			float4 _BaseColor;
			float _SmoothnessRemapMin;
			float _SmoothnessRemapMax;
			float _AORemapMin;
			float _AORemapMax;
			float _NormalScale;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _EnableDetail;
			float _UVDetail;
			float _LinkDetailsWithBase;
			float _DetailAlbedoScale;
			float _DetailNormalScale;
			float _DetailSmoothnessScale;
			float4 _DetailMap_TO;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[15];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _DetailMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_DetailMap;

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
				float fragment_unnamed_122 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_184 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_210 = asfloat(fragment_unnamed_184 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_217 = asfloat(fragment_unnamed_184 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_224 = asfloat(fragment_unnamed_184 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_228 = rsqrt(dot(float3(fragment_unnamed_210, fragment_unnamed_217, fragment_unnamed_224), float3(fragment_unnamed_210, fragment_unnamed_217, fragment_unnamed_224)));
				bool fragment_unnamed_300 = 0.0f != fragment_uniform_buffer_2[8u].z;
				float fragment_unnamed_310 = (fragment_unnamed_300 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_6.x) * fragment_uniform_buffer_2[8u].w;
				float fragment_unnamed_311 = (fragment_unnamed_300 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_6.z) * fragment_uniform_buffer_2[8u].w;
				float fragment_unnamed_320 = mad(fragment_unnamed_310, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z);
				float fragment_unnamed_321 = mad(fragment_unnamed_311, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w);
				bool fragment_unnamed_325 = fragment_uniform_buffer_2[8u].y == 4.0f;
				float fragment_unnamed_336 = asfloat(((fragment_uniform_buffer_2[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_338 = asfloat(((fragment_uniform_buffer_2[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_340 = asfloat(((fragment_uniform_buffer_2[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_360 = asfloat(((fragment_uniform_buffer_2[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_390 = asfloat(fragment_unnamed_325 ? asuint(fragment_unnamed_320) : asuint(mad(mad(fragment_unnamed_336, fragment_input_2.x, fragment_unnamed_338 * fragment_input_3.x) + mad(fragment_unnamed_340, fragment_input_4.x, fragment_unnamed_360 * fragment_input_5.x), fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[9u].z)));
				float fragment_unnamed_392 = asfloat(fragment_unnamed_325 ? asuint(fragment_unnamed_321) : asuint(mad(mad(fragment_unnamed_336, fragment_input_2.y, fragment_unnamed_338 * fragment_input_3.y) + mad(fragment_unnamed_340, fragment_input_4.y, fragment_unnamed_360 * fragment_input_5.y), fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[9u].w)));
				float4 fragment_unnamed_399 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_390, fragment_unnamed_392), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_402 = fragment_unnamed_399.x;
				float fragment_unnamed_403 = fragment_unnamed_399.y;
				float fragment_unnamed_404 = fragment_unnamed_399.z;
				float fragment_unnamed_410 = fragment_unnamed_402 * fragment_uniform_buffer_2[2u].x;
				float fragment_unnamed_411 = fragment_unnamed_403 * fragment_uniform_buffer_2[2u].y;
				float fragment_unnamed_412 = fragment_unnamed_404 * fragment_uniform_buffer_2[2u].z;
				bool fragment_unnamed_416 = fragment_uniform_buffer_2[8u].y < 4.0f;
				bool fragment_unnamed_442 = 0.0f != fragment_uniform_buffer_2[12u].y;
				uint4 fragment_unnamed_449 = asuint(fragment_uniform_buffer_2[14u]);
				float fragment_unnamed_474 = asfloat(((fragment_uniform_buffer_2[12u].x == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_476 = asfloat(((fragment_uniform_buffer_2[12u].x == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_478 = asfloat(((fragment_uniform_buffer_2[12u].x == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_492 = asfloat(((fragment_uniform_buffer_2[12u].x == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				float4 fragment_unnamed_539 = _DetailMap.SampleBias(sampler_DetailMap, float2(asfloat(fragment_unnamed_416 ? asuint(mad(mad(fragment_unnamed_474, fragment_input_2.x, fragment_unnamed_476 * fragment_input_3.x) + mad(fragment_unnamed_478, fragment_input_4.x, fragment_unnamed_492 * fragment_input_5.x), asfloat(fragment_unnamed_442 ? asuint(fragment_uniform_buffer_2[9u].x * fragment_uniform_buffer_2[14u].x) : fragment_unnamed_449.x), asfloat(fragment_unnamed_442 ? asuint(fragment_uniform_buffer_2[9u].z + fragment_uniform_buffer_2[14u].z) : fragment_unnamed_449.z))) : asuint(mad(asfloat(fragment_unnamed_442 ? asuint(fragment_unnamed_320) : asuint(fragment_unnamed_310)), fragment_uniform_buffer_2[14u].x, fragment_uniform_buffer_2[14u].z))), asfloat(fragment_unnamed_416 ? asuint(mad(mad(fragment_unnamed_474, fragment_input_2.y, fragment_unnamed_476 * fragment_input_3.y) + mad(fragment_unnamed_478, fragment_input_4.y, fragment_unnamed_492 * fragment_input_5.y), asfloat(fragment_unnamed_442 ? asuint(fragment_uniform_buffer_2[9u].y * fragment_uniform_buffer_2[14u].y) : fragment_unnamed_449.y), asfloat(fragment_unnamed_442 ? asuint(fragment_uniform_buffer_2[9u].w + fragment_uniform_buffer_2[14u].w) : fragment_unnamed_449.w))) : asuint(mad(asfloat(fragment_unnamed_442 ? asuint(fragment_unnamed_321) : asuint(fragment_unnamed_311)), fragment_uniform_buffer_2[14u].y, fragment_uniform_buffer_2[14u].w)))), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_545 = mad(fragment_unnamed_539.w, 2.0f, -1.0f);
				float fragment_unnamed_547 = mad(fragment_unnamed_539.y, 2.0f, -1.0f);
				float fragment_unnamed_548 = mad(fragment_unnamed_539.x, 2.0f, -1.0f);
				float fragment_unnamed_549 = mad(fragment_unnamed_539.z, 2.0f, -1.0f);
				float4 fragment_unnamed_554 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_unnamed_390, fragment_unnamed_392), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_557 = fragment_unnamed_554.z;
				float fragment_unnamed_559 = sqrt(fragment_unnamed_410);
				float fragment_unnamed_560 = sqrt(fragment_unnamed_411);
				float fragment_unnamed_561 = sqrt(fragment_unnamed_412);
				float fragment_unnamed_565 = asfloat((fragment_unnamed_548 < 0.0f) ? 0u : 1065353216u);
				float fragment_unnamed_573 = clamp(abs(fragment_unnamed_548) * fragment_uniform_buffer_2[12u].z, 0.0f, 1.0f);
				float fragment_unnamed_574 = fragment_unnamed_573 * fragment_unnamed_573;
				float fragment_unnamed_581 = mad(fragment_unnamed_574, ((-0.0f) - fragment_unnamed_559) + fragment_unnamed_565, fragment_unnamed_559);
				float fragment_unnamed_582 = mad(fragment_unnamed_574, ((-0.0f) - fragment_unnamed_560) + fragment_unnamed_565, fragment_unnamed_560);
				float fragment_unnamed_583 = mad(fragment_unnamed_574, ((-0.0f) - fragment_unnamed_561) + fragment_unnamed_565, fragment_unnamed_561);
				bool fragment_unnamed_608 = 0.0f != fragment_uniform_buffer_2[10u].x;
				float fragment_unnamed_616 = asfloat(fragment_unnamed_608 ? asuint(mad(fragment_unnamed_557, mad((-0.0f) - fragment_uniform_buffer_2[2u].x, fragment_unnamed_402, min(fragment_unnamed_581 * fragment_unnamed_581, 1.0f)), fragment_unnamed_410)) : asuint(fragment_unnamed_410));
				float fragment_unnamed_618 = asfloat(fragment_unnamed_608 ? asuint(mad(fragment_unnamed_557, mad((-0.0f) - fragment_uniform_buffer_2[2u].y, fragment_unnamed_403, min(fragment_unnamed_582 * fragment_unnamed_582, 1.0f)), fragment_unnamed_411)) : asuint(fragment_unnamed_411));
				float fragment_unnamed_620 = asfloat(fragment_unnamed_608 ? asuint(mad(fragment_unnamed_557, mad((-0.0f) - fragment_uniform_buffer_2[2u].z, fragment_unnamed_404, min(fragment_unnamed_583 * fragment_unnamed_583, 1.0f)), fragment_unnamed_412)) : asuint(fragment_unnamed_412));
				float fragment_unnamed_632 = mad(fragment_unnamed_554.w, ((-0.0f) - fragment_uniform_buffer_2[5u].y) + fragment_uniform_buffer_2[5u].z, fragment_uniform_buffer_2[5u].y);
				float fragment_unnamed_650 = asfloat(fragment_unnamed_608 ? asuint(mad(fragment_unnamed_557, ((-0.0f) - fragment_unnamed_632) + clamp(mad(clamp(abs(fragment_unnamed_549) * fragment_uniform_buffer_2[13u].x, 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_632) + asfloat((fragment_unnamed_549 < 0.0f) ? 0u : 1065353216u), fragment_unnamed_632), 0.0f, 1.0f), fragment_unnamed_632)) : asuint(fragment_unnamed_632));
				float fragment_unnamed_662 = mad(fragment_unnamed_554.y, ((-0.0f) - fragment_uniform_buffer_2[5u].w) + fragment_uniform_buffer_2[6u].x, fragment_uniform_buffer_2[5u].w);
				float4 fragment_unnamed_667 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_unnamed_390, fragment_unnamed_392), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_673 = mad(fragment_unnamed_667.x * fragment_unnamed_667.w, 2.0f, -1.0f);
				float fragment_unnamed_674 = mad(fragment_unnamed_667.y, 2.0f, -1.0f);
				float fragment_unnamed_687 = fragment_unnamed_673 * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_688 = fragment_unnamed_674 * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_692 = clamp(fragment_uniform_buffer_2[8u].x, 0.0f, 1.0f);
				float fragment_unnamed_693 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_673, fragment_unnamed_674), float2(fragment_unnamed_673, fragment_unnamed_674)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f);
				float fragment_unnamed_701 = sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_545, fragment_unnamed_547), float2(fragment_unnamed_545, fragment_unnamed_547)), 1.0f)) + 1.0f);
				float fragment_unnamed_705 = rsqrt(dot(float3(fragment_unnamed_545, fragment_unnamed_547, fragment_unnamed_701), float3(fragment_unnamed_545, fragment_unnamed_547, fragment_unnamed_701)));
				float fragment_unnamed_711 = fragment_unnamed_557 * fragment_uniform_buffer_2[12u].w;
				float fragment_unnamed_717 = fragment_unnamed_687 + 0.0f;
				float fragment_unnamed_718 = fragment_unnamed_688 + 0.0f;
				float fragment_unnamed_719 = (fragment_unnamed_693 * fragment_unnamed_692) + 2.0f;
				float fragment_unnamed_720 = ((fragment_unnamed_705 * fragment_unnamed_545) * fragment_unnamed_711) * (-1.0f);
				float fragment_unnamed_721 = ((fragment_unnamed_705 * fragment_unnamed_547) * fragment_unnamed_711) * (-1.0f);
				float fragment_unnamed_722 = mad(clamp(fragment_unnamed_711, 0.0f, 1.0f), mad(fragment_unnamed_701, fragment_unnamed_705, -1.0f), 1.0f) * 1.0f;
				float fragment_unnamed_726 = dot(float3(fragment_unnamed_717, fragment_unnamed_718, fragment_unnamed_719), float3(fragment_unnamed_720, fragment_unnamed_721, fragment_unnamed_722));
				float fragment_unnamed_743 = asfloat(fragment_unnamed_608 ? asuint(mad(fragment_unnamed_717 / fragment_unnamed_719, fragment_unnamed_726, (-0.0f) - fragment_unnamed_720)) : asuint(fragment_unnamed_687));
				float fragment_unnamed_745 = asfloat(fragment_unnamed_608 ? asuint(mad(fragment_unnamed_718 / fragment_unnamed_719, fragment_unnamed_726, (-0.0f) - fragment_unnamed_721)) : asuint(fragment_unnamed_688));
				float fragment_unnamed_747 = asfloat(fragment_unnamed_608 ? asuint(mad(fragment_unnamed_719 / fragment_unnamed_719, fragment_unnamed_726, (-0.0f) - fragment_unnamed_722)) : asuint(mad(fragment_unnamed_692, fragment_unnamed_693, 1.0f)));
				float fragment_unnamed_754 = mad(fragment_unnamed_747, fragment_unnamed_102 * fragment_input_7.x, mad(fragment_unnamed_743, fragment_unnamed_102 * fragment_input_1.x, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_745));
				float fragment_unnamed_755 = mad(fragment_unnamed_747, fragment_unnamed_102 * fragment_input_7.y, mad(fragment_unnamed_743, fragment_unnamed_102 * fragment_input_1.y, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_745));
				float fragment_unnamed_756 = mad(fragment_unnamed_747, fragment_unnamed_102 * fragment_input_7.z, mad(fragment_unnamed_743, fragment_unnamed_102 * fragment_input_1.z, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_745));
				float fragment_unnamed_761 = rsqrt(max(dot(float3(fragment_unnamed_754, fragment_unnamed_755, fragment_unnamed_756), float3(fragment_unnamed_754, fragment_unnamed_755, fragment_unnamed_756)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_762 = fragment_unnamed_761 * fragment_unnamed_754;
				float fragment_unnamed_763 = fragment_unnamed_761 * fragment_unnamed_755;
				float fragment_unnamed_764 = fragment_unnamed_761 * fragment_unnamed_756;
				float fragment_unnamed_826;
				float fragment_unnamed_827;
				float fragment_unnamed_828;
				float fragment_unnamed_829;
				float fragment_unnamed_830;
				float fragment_unnamed_831;
				float fragment_unnamed_832;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_775 = uint(gl_FragCoord.x);
					uint fragment_unnamed_776 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_777 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_775, fragment_unnamed_776, 0u), 0u));
					float fragment_unnamed_783 = fragment_unnamed_777.w;
					float4 fragment_unnamed_784 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_775, fragment_unnamed_776, 0u), 0u));
					float fragment_unnamed_789 = fragment_unnamed_784.w;
					float4 fragment_unnamed_790 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_775, fragment_unnamed_776, 0u), 0u));
					bool fragment_unnamed_798 = fragment_unnamed_789 < 1.0f;
					float fragment_unnamed_799 = mad(fragment_unnamed_762, fragment_unnamed_789, mad(fragment_unnamed_784.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_800 = mad(fragment_unnamed_763, fragment_unnamed_789, mad(fragment_unnamed_784.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_801 = mad(fragment_unnamed_764, fragment_unnamed_789, mad(fragment_unnamed_784.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_806 = rsqrt(max(dot(float3(fragment_unnamed_799, fragment_unnamed_800, fragment_unnamed_801), float3(fragment_unnamed_799, fragment_unnamed_800, fragment_unnamed_801)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_826 = mad(fragment_unnamed_616, fragment_unnamed_783, fragment_unnamed_777.x);
					fragment_unnamed_827 = mad(fragment_unnamed_618, fragment_unnamed_783, fragment_unnamed_777.y);
					fragment_unnamed_828 = mad(fragment_unnamed_620, fragment_unnamed_783, fragment_unnamed_777.z);
					fragment_unnamed_829 = mad(fragment_unnamed_650, fragment_unnamed_790.w, fragment_unnamed_790.z);
					fragment_unnamed_830 = asfloat(fragment_unnamed_798 ? asuint(fragment_unnamed_806 * fragment_unnamed_801) : asuint(fragment_unnamed_764));
					fragment_unnamed_831 = asfloat(fragment_unnamed_798 ? asuint(fragment_unnamed_806 * fragment_unnamed_800) : asuint(fragment_unnamed_763));
					fragment_unnamed_832 = asfloat(fragment_unnamed_798 ? asuint(fragment_unnamed_806 * fragment_unnamed_799) : asuint(fragment_unnamed_762));
				}
				else
				{
					fragment_unnamed_826 = fragment_unnamed_616;
					fragment_unnamed_827 = fragment_unnamed_618;
					fragment_unnamed_828 = fragment_unnamed_620;
					fragment_unnamed_829 = fragment_unnamed_650;
					fragment_unnamed_830 = fragment_unnamed_764;
					fragment_unnamed_831 = fragment_unnamed_763;
					fragment_unnamed_832 = fragment_unnamed_762;
				}
				uint4 fragment_unnamed_846 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_847 = fragment_unnamed_846.x;
				float fragment_unnamed_1130;
				float fragment_unnamed_1132;
				float fragment_unnamed_1134;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_847 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_847 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_1131;
					float fragment_unnamed_1133;
					float fragment_unnamed_1135;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_870 = asfloat(1065353216u);
						float fragment_unnamed_898 = fragment_unnamed_831 * fragment_unnamed_832;
						float fragment_unnamed_899 = fragment_unnamed_830 * fragment_unnamed_831;
						float fragment_unnamed_900 = fragment_unnamed_830 * fragment_unnamed_830;
						float fragment_unnamed_901 = fragment_unnamed_832 * fragment_unnamed_830;
						float fragment_unnamed_934 = mad(fragment_unnamed_832, fragment_unnamed_832, (-0.0f) - (fragment_unnamed_831 * fragment_unnamed_831));
						fragment_unnamed_1131 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_832, fragment_unnamed_831, fragment_unnamed_830, fragment_unnamed_870)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_934, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_898, fragment_unnamed_899, fragment_unnamed_900, fragment_unnamed_901)));
						fragment_unnamed_1133 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_832, fragment_unnamed_831, fragment_unnamed_830, fragment_unnamed_870)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_934, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_898, fragment_unnamed_899, fragment_unnamed_900, fragment_unnamed_901)));
						fragment_unnamed_1135 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_832, fragment_unnamed_831, fragment_unnamed_830, fragment_unnamed_870)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_934, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_898, fragment_unnamed_899, fragment_unnamed_900, fragment_unnamed_901)));
					}
					else
					{
						bool fragment_unnamed_950 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_951 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_972 = fragment_unnamed_950 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_973 = fragment_unnamed_950 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_974 = fragment_unnamed_950 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_1078 = (asfloat(fragment_unnamed_951 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_974, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_972, fragment_unnamed_973 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_973)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_1079 = (asfloat(fragment_unnamed_951 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_974, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_972, fragment_unnamed_973 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_974)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_1093 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_951 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_974, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_972, fragment_unnamed_973 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_972)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_1120 = asfloat(1065353216u);
						fragment_unnamed_1131 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1093 + 0.5f, fragment_unnamed_1078 + 0.0f, fragment_unnamed_1079 + 0.0f), 0.0f)), float4(fragment_unnamed_832, fragment_unnamed_831, fragment_unnamed_830, fragment_unnamed_1120));
						fragment_unnamed_1133 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1093 + 0.25f, fragment_unnamed_1078 + 0.0f, fragment_unnamed_1079 + 0.0f), 0.0f)), float4(fragment_unnamed_832, fragment_unnamed_831, fragment_unnamed_830, fragment_unnamed_1120));
						fragment_unnamed_1135 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1093, fragment_unnamed_1078, fragment_unnamed_1079), 0.0f)), float4(fragment_unnamed_832, fragment_unnamed_831, fragment_unnamed_830, fragment_unnamed_1120));
					}
					fragment_unnamed_1130 = fragment_unnamed_1131;
					fragment_unnamed_1132 = fragment_unnamed_1133;
					fragment_unnamed_1134 = fragment_unnamed_1135;
				}
				else
				{
					fragment_unnamed_1130 = asfloat(0u);
					fragment_unnamed_1132 = asfloat(0u);
					fragment_unnamed_1134 = asfloat(0u);
				}
				float fragment_unnamed_1137 = ((-0.0f) - fragment_unnamed_829) + 1.0f;
				float fragment_unnamed_1152 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_832, fragment_unnamed_831, fragment_unnamed_830), float3(fragment_unnamed_228 * fragment_unnamed_210, fragment_unnamed_228 * fragment_unnamed_217, fragment_unnamed_228 * fragment_unnamed_224)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_1137, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_1167 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1172 = max(abs(fragment_unnamed_830), 0.0009765625f);
				float fragment_unnamed_1176 = (fragment_unnamed_830 >= 0.0f) ? fragment_unnamed_1172 : ((-0.0f) - fragment_unnamed_1172);
				float fragment_unnamed_1185 = 1.0f / max(dot(float3(abs(fragment_unnamed_832), abs(fragment_unnamed_831), abs(fragment_unnamed_1176)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1190 = clamp((-0.0f) - (fragment_unnamed_1185 * fragment_unnamed_1176), 0.0f, 1.0f);
				float fragment_unnamed_1193 = (-0.0f) - fragment_unnamed_1190;
				uint fragment_unnamed_1205 = uint(clamp(mad(mad(fragment_unnamed_832, fragment_unnamed_1185, ((fragment_unnamed_1185 * fragment_unnamed_832) >= 0.0f) ? fragment_unnamed_1190 : fragment_unnamed_1193), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1206 = uint(clamp(mad(mad(fragment_unnamed_831, fragment_unnamed_1185, ((fragment_unnamed_1185 * fragment_unnamed_831) >= 0.0f) ? fragment_unnamed_1190 : fragment_unnamed_1193), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1205 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1206 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1206 >> 8u) * 16u) + (fragment_unnamed_1205 >> 8u)) * 0.0039215688593685626983642578125f;
				float fragment_unnamed_1236 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1237 = fragment_unnamed_1236 * (fragment_unnamed_662 * (fragment_unnamed_1167 * ((fragment_unnamed_826 * fragment_unnamed_1152) * fragment_unnamed_1134)));
				float fragment_unnamed_1238 = fragment_unnamed_1236 * (fragment_unnamed_662 * (fragment_unnamed_1167 * ((fragment_unnamed_827 * fragment_unnamed_1152) * fragment_unnamed_1132)));
				float fragment_unnamed_1239 = fragment_unnamed_1236 * (fragment_unnamed_662 * (fragment_unnamed_1167 * ((fragment_unnamed_828 * fragment_unnamed_1152) * fragment_unnamed_1130)));
				bool fragment_unnamed_1252 = (((fragment_unnamed_1239 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1238 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1237 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1252 ? asfloat(1157627904u) : fragment_unnamed_1237;
				fragment_output_3.y = fragment_unnamed_1252 ? fragment_unnamed_662 : fragment_unnamed_1238;
				fragment_output_3.z = fragment_unnamed_1252 ? asfloat(1149239296u) : fragment_unnamed_1239;
				fragment_output_0.x = fragment_unnamed_826;
				fragment_output_0.y = fragment_unnamed_827;
				fragment_output_0.z = fragment_unnamed_828;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_unnamed_1137;
				fragment_output_2.x = 0.2209163606166839599609375f;
				fragment_output_2.y = 0.2209163606166839599609375f;
				fragment_output_2.z = 0.2209163606166839599609375f;
				fragment_output_2.w = 0.0f;
				fragment_output_3.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[210] = float4(fragment_uniform_buffer_0[210][0], fragment_uniform_buffer_0[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_0[210][3]);

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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

				fragment_uniform_buffer_2[2] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], _SmoothnessRemapMin, fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], fragment_uniform_buffer_2[5][1], _SmoothnessRemapMax, fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], fragment_uniform_buffer_2[5][1], fragment_uniform_buffer_2[5][2], _AORemapMin);

				fragment_uniform_buffer_2[6] = float4(_AORemapMax, fragment_uniform_buffer_2[6][1], fragment_uniform_buffer_2[6][2], fragment_uniform_buffer_2[6][3]);

				fragment_uniform_buffer_2[8] = float4(_NormalScale, fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], _UVBase, fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], _WorldMapping, fragment_uniform_buffer_2[8][3]);

				fragment_uniform_buffer_2[8] = float4(fragment_uniform_buffer_2[8][0], fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], _TexWorldScale);

				fragment_uniform_buffer_2[9] = float4(_BaseColorMap_TO[0], _BaseColorMap_TO[1], _BaseColorMap_TO[2], _BaseColorMap_TO[3]);

				fragment_uniform_buffer_2[10] = float4(_EnableDetail, fragment_uniform_buffer_2[10][1], fragment_uniform_buffer_2[10][2], fragment_uniform_buffer_2[10][3]);

				fragment_uniform_buffer_2[12] = float4(_UVDetail, fragment_uniform_buffer_2[12][1], fragment_uniform_buffer_2[12][2], fragment_uniform_buffer_2[12][3]);

				fragment_uniform_buffer_2[12] = float4(fragment_uniform_buffer_2[12][0], _LinkDetailsWithBase, fragment_uniform_buffer_2[12][2], fragment_uniform_buffer_2[12][3]);

				fragment_uniform_buffer_2[12] = float4(fragment_uniform_buffer_2[12][0], fragment_uniform_buffer_2[12][1], _DetailAlbedoScale, fragment_uniform_buffer_2[12][3]);

				fragment_uniform_buffer_2[12] = float4(fragment_uniform_buffer_2[12][0], fragment_uniform_buffer_2[12][1], fragment_uniform_buffer_2[12][2], _DetailNormalScale);

				fragment_uniform_buffer_2[13] = float4(_DetailSmoothnessScale, fragment_uniform_buffer_2[13][1], fragment_uniform_buffer_2[13][2], fragment_uniform_buffer_2[13][3]);

				fragment_uniform_buffer_2[14] = float4(_DetailMap_TO[0], _DetailMap_TO[1], _DetailMap_TO[2], _DetailMap_TO[3]);

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

			#endif // defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(_DISABLE_DECALS) && !defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_MATERIAL_FEATURE_TRANSMISSION)


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
			Name "Forward"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "Forward" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
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
			GpuProgramID 618372

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature AREA_SHADOW_MEDIUM
			#pragma shader_feature DECALS_3RT
			#pragma shader_feature DIRECTIONAL_SHADOW_MEDIUM
			#pragma shader_feature PUNCTUAL_SHADOW_MEDIUM
			#pragma shader_feature SCREEN_SPACE_SHADOWS_OFF
			#pragma shader_feature USE_CLUSTERED_LIGHTLIST
			#pragma shader_feature _DISABLE_DECALS
			#pragma shader_feature _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT


			#if defined(AREA_SHADOW_MEDIUM) && defined(DECALS_3RT) && defined(DIRECTIONAL_SHADOW_MEDIUM) && defined(PUNCTUAL_SHADOW_MEDIUM) && defined(SCREEN_SPACE_SHADOWS_OFF) && defined(USE_CLUSTERED_LIGHTLIST) && defined(_DISABLE_DECALS) && defined(_ENABLE_FOG_ON_TRANSPARENT) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4x4 _InvViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _ScreenSize;
			float4 _TaaFrameInfo;
			float4 _PlanetCenterRadius;
			float4 _PlanetUpAltitude;
			int _FogEnabled;
			int _PBRFogEnabled;
			int _EnableVolumetricFog;
			float _MaxFogDistance;
			float4 _FogColor;
			float _FogColorMode;
			float _GlobalMipBias;
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
			float4 _ShadowAtlasSize;
			float4 _CascadeShadowAtlasSize;
			float4 _AreaShadowAtlasSize;
			float4 _CachedShadowAtlasSize;
			float4 _CachedAreaShadowAtlasSize;
			float4 _BoundsSS;
			float _UpDirectionX;
			float _UpDirectionY;
			int _UnderWaterSurfaceIndex;
			int _PreRefractionPass;
			int _DirectionalLightCount;
			int _EnvLightSkyEnabled;
			int _CascadeShadowCount;
			int _DirectionalShadowIndex;
			int _EnableSkyReflection;
			float _ProbeExposureScale;
			float _IndirectDiffuseLightingMultiplier;
			int _IndirectDiffuseLightingLayers;
			float _ReflectionLightingMultiplier;
			int _ReflectionLightingLayers;
			float _MicroShadowOpacity;
			float4 _CookieAtlasSize;
			float4 _CookieAtlasData;
			float4 _ReflectionAtlasCubeData;
			float4 _ReflectionAtlasPlanarData;
			float g_fClustBase;
			float g_fNearPlane;
			float g_fFarPlane;
			int g_iLog2NumClusters;
			int g_isLogBaseBufferEnabled;
			int _NumTileClusteredX;
			int _NumTileClusteredY;
			float _OffScreenDownsampleFactor;
			int _OffScreenRendering;
			int _EnableRayTracedReflections;
			float2 _VolumetricCloudsShadowScale;
			float _VolumetricCloudsFallBackValue;
			float4 _VolumetricCloudsShadowOriginToggle;
			float4x4 unity_WorldToObject;
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
			float4x4 _PlanarCaptureVP[16];
			float4 _PlanarScaleOffset[16];
			float4 _CubeScaleOffset[128];
			float4 _BaseColor;
			float _SmoothnessRemapMin;
			float _SmoothnessRemapMax;
			float _AORemapMin;
			float _AORemapMax;
			float _NormalScale;
			float _UVBase;
			float _WorldMapping;
			float _TexWorldScale;
			float4 _BaseColorMap_TO;
			float _EnableDetail;
			float _UVDetail;
			float _LinkDetailsWithBase;
			float _DetailAlbedoScale;
			float _DetailNormalScale;
			float _DetailSmoothnessScale;
			float4 _DetailMap_TO;
			float _BlendMode;
			float _EnableBlendModePreserveSpecularLighting;
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
			float _VolumetricCloudsBottomAltitude;

			static float4 fragment_uniform_buffer_0[219];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[208];
			static float4 fragment_uniform_buffer_3[24];
			static float4 fragment_uniform_buffer_4[13];
			static const float fragment_unnamed_107[16] = { 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };

			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _PrevExposureTexture;
			Buffer<uint4> T3;
			Buffer<uint4> T4;
			Buffer<uint4> T5;
			Buffer<uint4> T6;
			Buffer<uint4> T7;
			Buffer<uint4> T8;
			Texture2D<float4> _CookieAtlas;
			Texture2DArray<float4> _ReflectionAtlas;
			Texture2D<float4> _VolumetricCloudsShadowsTexture;
			TextureCubeArray<float4> _SkyTexture;
			Texture2DArray<float4> _SsrLightingTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _DetailMap;
			Texture3D<float4> _AtmosphericScatteringLUT;
			Texture2DArray<uint4> _StencilTexture;
			Texture2DArray<float4> _RefractiveDepthBuffer;
			Buffer<uint4> T21;
			Buffer<uint4> T22;
			Texture2DArray<float4> _WaterGBufferTexture3;
			Buffer<uint4> T24;
			Texture3D<float4> _VBufferLighting;
			Texture2D<float4> _ShadowmapAtlas;
			Texture2D<float4> _CachedShadowmapAtlas;
			Texture2D<float4> _ShadowmapCascadeAtlas;
			Texture2D<float4> _ShadowmapAreaAtlas;
			Texture2D<float4> _CachedAreaLightShadowmapAtlas;
			Buffer<uint4> T31;
			Buffer<uint4> T32;
			Texture2DArray<float4> _LtcData;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			SamplerState S0;
			SamplerState S1;
			SamplerComparisonState S2;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_DetailMap;

			static float4 gl_FragCoord;
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
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_176 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_194 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_250 = fragment_unnamed_176 * fragment_input_7.x;
				float fragment_unnamed_251 = fragment_unnamed_176 * fragment_input_7.y;
				float fragment_unnamed_252 = fragment_unnamed_176 * fragment_input_7.z;
				bool fragment_unnamed_259 = 0u < asuint(fragment_uniform_buffer_0[211u]).y;
				float fragment_unnamed_279 = fragment_unnamed_259 ? float(uint(round(gl_FragCoord.x * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.x;
				float fragment_unnamed_280 = fragment_unnamed_259 ? float(uint(round(gl_FragCoord.y * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.y;
				uint fragment_unnamed_281 = uint(fragment_unnamed_279);
				uint fragment_unnamed_282 = uint(fragment_unnamed_280);
				uint fragment_unnamed_283 = fragment_unnamed_281 >> 5u;
				uint fragment_unnamed_285 = fragment_unnamed_282 >> 5u;
				float fragment_unnamed_291 = fragment_unnamed_279 * fragment_uniform_buffer_0[50u].z;
				float fragment_unnamed_292 = fragment_unnamed_280 * fragment_uniform_buffer_0[50u].w;
				bool fragment_unnamed_297 = fragment_uniform_buffer_0[15u].w == 0.0f;
				uint4 fragment_unnamed_318 = asuint(fragment_uniform_buffer_0[0u]);
				uint fragment_unnamed_319 = fragment_unnamed_318.z;
				uint4 fragment_unnamed_323 = asuint(fragment_uniform_buffer_0[1u]);
				uint fragment_unnamed_324 = fragment_unnamed_323.z;
				uint4 fragment_unnamed_328 = asuint(fragment_uniform_buffer_0[2u]);
				uint fragment_unnamed_329 = fragment_unnamed_328.z;
				float fragment_unnamed_335 = asfloat(fragment_unnamed_297 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : fragment_unnamed_319);
				float fragment_unnamed_337 = asfloat(fragment_unnamed_297 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : fragment_unnamed_324);
				float fragment_unnamed_339 = asfloat(fragment_unnamed_297 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : fragment_unnamed_329);
				float fragment_unnamed_343 = rsqrt(dot(float3(fragment_unnamed_335, fragment_unnamed_337, fragment_unnamed_339), float3(fragment_unnamed_335, fragment_unnamed_337, fragment_unnamed_339)));
				float fragment_unnamed_344 = fragment_unnamed_343 * fragment_unnamed_335;
				float fragment_unnamed_345 = fragment_unnamed_343 * fragment_unnamed_337;
				float fragment_unnamed_346 = fragment_unnamed_343 * fragment_unnamed_339;
				bool fragment_unnamed_414 = 0.0f != fragment_uniform_buffer_3[8u].z;
				float fragment_unnamed_424 = (fragment_unnamed_414 ? ((mad(fragment_uniform_buffer_1[6u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].x)) + fragment_uniform_buffer_1[7u].x) + mad(fragment_uniform_buffer_1[6u].x, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].x, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].x))) : fragment_input_6.x) * fragment_uniform_buffer_3[8u].w;
				float fragment_unnamed_425 = (fragment_unnamed_414 ? ((mad(fragment_uniform_buffer_1[6u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[4u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[5u].z)) + fragment_uniform_buffer_1[7u].z) + mad(fragment_uniform_buffer_1[6u].z, fragment_input_6.z, mad(fragment_uniform_buffer_1[4u].z, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[5u].z))) : fragment_input_6.z) * fragment_uniform_buffer_3[8u].w;
				float fragment_unnamed_434 = mad(fragment_unnamed_424, fragment_uniform_buffer_3[9u].x, fragment_uniform_buffer_3[9u].z);
				float fragment_unnamed_435 = mad(fragment_unnamed_425, fragment_uniform_buffer_3[9u].y, fragment_uniform_buffer_3[9u].w);
				bool fragment_unnamed_439 = fragment_uniform_buffer_3[8u].y == 4.0f;
				float fragment_unnamed_450 = asfloat(((fragment_uniform_buffer_3[8u].y == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_452 = asfloat(((fragment_uniform_buffer_3[8u].y == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_454 = asfloat(((fragment_uniform_buffer_3[8u].y == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_474 = asfloat(((fragment_uniform_buffer_3[8u].y == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_504 = asfloat(fragment_unnamed_439 ? asuint(fragment_unnamed_434) : asuint(mad(mad(fragment_unnamed_450, fragment_input_2.x, fragment_unnamed_452 * fragment_input_3.x) + mad(fragment_unnamed_454, fragment_input_4.x, fragment_unnamed_474 * fragment_input_5.x), fragment_uniform_buffer_3[9u].x, fragment_uniform_buffer_3[9u].z)));
				float fragment_unnamed_506 = asfloat(fragment_unnamed_439 ? asuint(fragment_unnamed_435) : asuint(mad(mad(fragment_unnamed_450, fragment_input_2.y, fragment_unnamed_452 * fragment_input_3.y) + mad(fragment_unnamed_454, fragment_input_4.y, fragment_unnamed_474 * fragment_input_5.y), fragment_uniform_buffer_3[9u].y, fragment_uniform_buffer_3[9u].w)));
				float4 fragment_unnamed_513 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_unnamed_504, fragment_unnamed_506), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_516 = fragment_unnamed_513.x;
				float fragment_unnamed_517 = fragment_unnamed_513.y;
				float fragment_unnamed_518 = fragment_unnamed_513.z;
				float fragment_unnamed_526 = fragment_unnamed_516 * fragment_uniform_buffer_3[2u].x;
				float fragment_unnamed_527 = fragment_unnamed_517 * fragment_uniform_buffer_3[2u].y;
				float fragment_unnamed_528 = fragment_unnamed_518 * fragment_uniform_buffer_3[2u].z;
				float fragment_unnamed_529 = fragment_unnamed_513.w * fragment_uniform_buffer_3[2u].w;
				bool fragment_unnamed_533 = fragment_uniform_buffer_3[8u].y < 4.0f;
				bool fragment_unnamed_559 = 0.0f != fragment_uniform_buffer_3[12u].y;
				uint4 fragment_unnamed_566 = asuint(fragment_uniform_buffer_3[14u]);
				float fragment_unnamed_591 = asfloat(((fragment_uniform_buffer_3[12u].x == 0.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_593 = asfloat(((fragment_uniform_buffer_3[12u].x == 1.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_595 = asfloat(((fragment_uniform_buffer_3[12u].x == 2.0f) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_597 = asfloat(((fragment_uniform_buffer_3[12u].x == 3.0f) ? 4294967295u : 0u) & 1065353216u);
				float4 fragment_unnamed_656 = _DetailMap.SampleBias(sampler_DetailMap, float2(asfloat(fragment_unnamed_533 ? asuint(mad(mad(fragment_unnamed_591, fragment_input_2.x, fragment_unnamed_593 * fragment_input_3.x) + mad(fragment_unnamed_595, fragment_input_4.x, fragment_unnamed_597 * fragment_input_5.x), asfloat(fragment_unnamed_559 ? asuint(fragment_uniform_buffer_3[9u].x * fragment_uniform_buffer_3[14u].x) : fragment_unnamed_566.x), asfloat(fragment_unnamed_559 ? asuint(fragment_uniform_buffer_3[9u].z + fragment_uniform_buffer_3[14u].z) : fragment_unnamed_566.z))) : asuint(mad(asfloat(fragment_unnamed_559 ? asuint(fragment_unnamed_434) : asuint(fragment_unnamed_424)), fragment_uniform_buffer_3[14u].x, fragment_uniform_buffer_3[14u].z))), asfloat(fragment_unnamed_533 ? asuint(mad(mad(fragment_unnamed_591, fragment_input_2.y, fragment_unnamed_593 * fragment_input_3.y) + mad(fragment_unnamed_595, fragment_input_4.y, fragment_unnamed_597 * fragment_input_5.y), asfloat(fragment_unnamed_559 ? asuint(fragment_uniform_buffer_3[9u].y * fragment_uniform_buffer_3[14u].y) : fragment_unnamed_566.y), asfloat(fragment_unnamed_559 ? asuint(fragment_uniform_buffer_3[9u].w + fragment_uniform_buffer_3[14u].w) : fragment_unnamed_566.w))) : asuint(mad(asfloat(fragment_unnamed_559 ? asuint(fragment_unnamed_435) : asuint(fragment_unnamed_425)), fragment_uniform_buffer_3[14u].y, fragment_uniform_buffer_3[14u].w)))), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_662 = mad(fragment_unnamed_656.w, 2.0f, -1.0f);
				float fragment_unnamed_664 = mad(fragment_unnamed_656.y, 2.0f, -1.0f);
				float fragment_unnamed_665 = mad(fragment_unnamed_656.x, 2.0f, -1.0f);
				float fragment_unnamed_666 = mad(fragment_unnamed_656.z, 2.0f, -1.0f);
				float4 fragment_unnamed_671 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_unnamed_504, fragment_unnamed_506), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_674 = fragment_unnamed_671.z;
				float fragment_unnamed_676 = sqrt(fragment_unnamed_526);
				float fragment_unnamed_677 = sqrt(fragment_unnamed_527);
				float fragment_unnamed_678 = sqrt(fragment_unnamed_528);
				float fragment_unnamed_682 = asfloat((fragment_unnamed_665 < 0.0f) ? 0u : 1065353216u);
				float fragment_unnamed_690 = clamp(abs(fragment_unnamed_665) * fragment_uniform_buffer_3[12u].z, 0.0f, 1.0f);
				float fragment_unnamed_691 = fragment_unnamed_690 * fragment_unnamed_690;
				float fragment_unnamed_698 = mad(fragment_unnamed_691, ((-0.0f) - fragment_unnamed_676) + fragment_unnamed_682, fragment_unnamed_676);
				float fragment_unnamed_699 = mad(fragment_unnamed_691, ((-0.0f) - fragment_unnamed_677) + fragment_unnamed_682, fragment_unnamed_677);
				float fragment_unnamed_700 = mad(fragment_unnamed_691, ((-0.0f) - fragment_unnamed_678) + fragment_unnamed_682, fragment_unnamed_678);
				bool fragment_unnamed_725 = 0.0f != fragment_uniform_buffer_3[10u].x;
				float fragment_unnamed_733 = asfloat(fragment_unnamed_725 ? asuint(mad(fragment_unnamed_674, mad((-0.0f) - fragment_uniform_buffer_3[2u].x, fragment_unnamed_516, min(fragment_unnamed_698 * fragment_unnamed_698, 1.0f)), fragment_unnamed_526)) : asuint(fragment_unnamed_526));
				float fragment_unnamed_735 = asfloat(fragment_unnamed_725 ? asuint(mad(fragment_unnamed_674, mad((-0.0f) - fragment_uniform_buffer_3[2u].y, fragment_unnamed_517, min(fragment_unnamed_699 * fragment_unnamed_699, 1.0f)), fragment_unnamed_527)) : asuint(fragment_unnamed_527));
				float fragment_unnamed_737 = asfloat(fragment_unnamed_725 ? asuint(mad(fragment_unnamed_674, mad((-0.0f) - fragment_uniform_buffer_3[2u].z, fragment_unnamed_518, min(fragment_unnamed_700 * fragment_unnamed_700, 1.0f)), fragment_unnamed_528)) : asuint(fragment_unnamed_528));
				float fragment_unnamed_749 = mad(fragment_unnamed_671.w, ((-0.0f) - fragment_uniform_buffer_3[5u].y) + fragment_uniform_buffer_3[5u].z, fragment_uniform_buffer_3[5u].y);
				float fragment_unnamed_778 = mad(fragment_unnamed_671.y, ((-0.0f) - fragment_uniform_buffer_3[5u].w) + fragment_uniform_buffer_3[6u].x, fragment_uniform_buffer_3[5u].w);
				float4 fragment_unnamed_783 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_unnamed_504, fragment_unnamed_506), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_789 = mad(fragment_unnamed_783.x * fragment_unnamed_783.w, 2.0f, -1.0f);
				float fragment_unnamed_790 = mad(fragment_unnamed_783.y, 2.0f, -1.0f);
				float fragment_unnamed_803 = fragment_unnamed_789 * fragment_uniform_buffer_3[8u].x;
				float fragment_unnamed_804 = fragment_unnamed_790 * fragment_uniform_buffer_3[8u].x;
				float fragment_unnamed_808 = clamp(fragment_uniform_buffer_3[8u].x, 0.0f, 1.0f);
				float fragment_unnamed_809 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_789, fragment_unnamed_790), float2(fragment_unnamed_789, fragment_unnamed_790)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f);
				float fragment_unnamed_817 = sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_662, fragment_unnamed_664), float2(fragment_unnamed_662, fragment_unnamed_664)), 1.0f)) + 1.0f);
				float fragment_unnamed_821 = rsqrt(dot(float3(fragment_unnamed_662, fragment_unnamed_664, fragment_unnamed_817), float3(fragment_unnamed_662, fragment_unnamed_664, fragment_unnamed_817)));
				float fragment_unnamed_827 = fragment_unnamed_674 * fragment_uniform_buffer_3[12u].w;
				float fragment_unnamed_833 = fragment_unnamed_803 + 0.0f;
				float fragment_unnamed_834 = fragment_unnamed_804 + 0.0f;
				float fragment_unnamed_835 = (fragment_unnamed_809 * fragment_unnamed_808) + 2.0f;
				float fragment_unnamed_836 = (fragment_unnamed_827 * (fragment_unnamed_821 * fragment_unnamed_662)) * (-1.0f);
				float fragment_unnamed_837 = (fragment_unnamed_827 * (fragment_unnamed_821 * fragment_unnamed_664)) * (-1.0f);
				float fragment_unnamed_838 = mad(clamp(fragment_unnamed_827, 0.0f, 1.0f), mad(fragment_unnamed_817, fragment_unnamed_821, -1.0f), 1.0f) * 1.0f;
				float fragment_unnamed_842 = dot(float3(fragment_unnamed_833, fragment_unnamed_834, fragment_unnamed_835), float3(fragment_unnamed_836, fragment_unnamed_837, fragment_unnamed_838));
				float fragment_unnamed_859 = asfloat(fragment_unnamed_725 ? asuint(mad(fragment_unnamed_833 / fragment_unnamed_835, fragment_unnamed_842, (-0.0f) - fragment_unnamed_836)) : asuint(fragment_unnamed_803));
				float fragment_unnamed_861 = asfloat(fragment_unnamed_725 ? asuint(mad(fragment_unnamed_834 / fragment_unnamed_835, fragment_unnamed_842, (-0.0f) - fragment_unnamed_837)) : asuint(fragment_unnamed_804));
				float fragment_unnamed_863 = asfloat(fragment_unnamed_725 ? asuint(mad(fragment_unnamed_835 / fragment_unnamed_835, fragment_unnamed_842, (-0.0f) - fragment_unnamed_838)) : asuint(mad(fragment_unnamed_808, fragment_unnamed_809, 1.0f)));
				float fragment_unnamed_870 = mad(fragment_unnamed_863, fragment_unnamed_250, mad(fragment_unnamed_859, fragment_unnamed_176 * fragment_input_1.x, (fragment_unnamed_176 * (fragment_unnamed_194 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_861));
				float fragment_unnamed_871 = mad(fragment_unnamed_863, fragment_unnamed_251, mad(fragment_unnamed_859, fragment_unnamed_176 * fragment_input_1.y, (fragment_unnamed_176 * (fragment_unnamed_194 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_861));
				float fragment_unnamed_872 = mad(fragment_unnamed_863, fragment_unnamed_252, mad(fragment_unnamed_859, fragment_unnamed_176 * fragment_input_1.z, (fragment_unnamed_176 * (fragment_unnamed_194 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_861));
				float fragment_unnamed_877 = rsqrt(max(dot(float3(fragment_unnamed_870, fragment_unnamed_871, fragment_unnamed_872), float3(fragment_unnamed_870, fragment_unnamed_871, fragment_unnamed_872)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_878 = fragment_unnamed_877 * fragment_unnamed_870;
				float fragment_unnamed_879 = fragment_unnamed_877 * fragment_unnamed_871;
				float fragment_unnamed_880 = fragment_unnamed_877 * fragment_unnamed_872;
				uint fragment_unnamed_885 = asuint(fragment_uniform_buffer_1[10u]).x & 65535u;
				float fragment_unnamed_1150;
				float fragment_unnamed_1151;
				float fragment_unnamed_1152;
				if (fragment_uniform_buffer_1[22u].x == 0.0f)
				{
					float fragment_unnamed_892 = asfloat(1065353216u);
					float fragment_unnamed_920 = fragment_unnamed_879 * fragment_unnamed_878;
					float fragment_unnamed_921 = fragment_unnamed_880 * fragment_unnamed_879;
					float fragment_unnamed_922 = fragment_unnamed_880 * fragment_unnamed_880;
					float fragment_unnamed_923 = fragment_unnamed_878 * fragment_unnamed_880;
					float fragment_unnamed_955 = mad(fragment_unnamed_878, fragment_unnamed_878, (-0.0f) - (fragment_unnamed_879 * fragment_unnamed_879));
					fragment_unnamed_1150 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880, fragment_unnamed_892)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_955, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_920, fragment_unnamed_921, fragment_unnamed_922, fragment_unnamed_923)));
					fragment_unnamed_1151 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880, fragment_unnamed_892)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_955, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_920, fragment_unnamed_921, fragment_unnamed_922, fragment_unnamed_923)));
					fragment_unnamed_1152 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880, fragment_unnamed_892)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_955, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_920, fragment_unnamed_921, fragment_unnamed_922, fragment_unnamed_923)));
				}
				else
				{
					bool fragment_unnamed_971 = fragment_uniform_buffer_1[22u].y == 0.0f;
					bool fragment_unnamed_972 = fragment_uniform_buffer_1[22u].y == 1.0f;
					float fragment_unnamed_993 = fragment_unnamed_971 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
					float fragment_unnamed_994 = fragment_unnamed_971 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
					float fragment_unnamed_995 = fragment_unnamed_971 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
					float fragment_unnamed_1098 = (asfloat(fragment_unnamed_972 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_995, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_993, fragment_unnamed_994 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_994)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
					float fragment_unnamed_1099 = (asfloat(fragment_unnamed_972 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_995, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_993, fragment_unnamed_994 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_995)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
					float fragment_unnamed_1113 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_972 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_995, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_993, fragment_unnamed_994 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_993)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
					float fragment_unnamed_1140 = asfloat(1065353216u);
					fragment_unnamed_1150 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1113, fragment_unnamed_1098, fragment_unnamed_1099), 0.0f)), float4(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880, fragment_unnamed_1140));
					fragment_unnamed_1151 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1113 + 0.25f, fragment_unnamed_1098 + 0.0f, fragment_unnamed_1099 + 0.0f), 0.0f)), float4(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880, fragment_unnamed_1140));
					fragment_unnamed_1152 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1113 + 0.5f, fragment_unnamed_1098 + 0.0f, fragment_unnamed_1099 + 0.0f), 0.0f)), float4(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880, fragment_unnamed_1140));
				}
				float fragment_unnamed_1154 = ((-0.0f) - asfloat(fragment_unnamed_725 ? asuint(mad(fragment_unnamed_674, ((-0.0f) - fragment_unnamed_749) + clamp(mad(clamp(abs(fragment_unnamed_666) * fragment_uniform_buffer_3[13u].x, 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_749) + asfloat((fragment_unnamed_666 < 0.0f) ? 0u : 1065353216u), fragment_unnamed_749), 0.0f, 1.0f), fragment_unnamed_749)) : asuint(fragment_unnamed_749))) + 1.0f;
				float fragment_unnamed_1155 = dot(float3(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880), float3(fragment_unnamed_344, fragment_unnamed_345, fragment_unnamed_346));
				float fragment_unnamed_1158 = max(fragment_unnamed_1155, 9.9999997473787516355514526367188e-05f);
				float4 fragment_unnamed_1166 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_1158), 0.984375f, 0.0078125f), mad(fragment_unnamed_1154, 0.984375f, 0.0078125f)), 0.0f);
				float fragment_unnamed_1171 = fragment_unnamed_1166.z + 0.5f;
				uint4 fragment_unnamed_1181 = asuint(fragment_uniform_buffer_0[120u]);
				uint4 fragment_unnamed_1190 = asuint(fragment_uniform_buffer_0[120u]);
				float fragment_unnamed_1194 = asfloat(((fragment_unnamed_885 & fragment_unnamed_1181.y) != 0u) ? fragment_unnamed_1190.x : 1065353216u);
				float fragment_unnamed_1196 = asfloat(((fragment_unnamed_885 & fragment_unnamed_1181.w) != 0u) ? fragment_unnamed_1190.z : 1065353216u);
				float fragment_unnamed_1200 = fragment_unnamed_1154 * fragment_unnamed_1154;
				float fragment_unnamed_1201 = dot(float2(fragment_unnamed_1166.xy), float2(0.959999978542327880859375f, 0.039999999105930328369140625f));
				float fragment_unnamed_1208 = fragment_unnamed_1200 * fragment_unnamed_1200;
				float fragment_unnamed_1212 = sqrt(mad(mad((-0.0f) - fragment_unnamed_1158, fragment_unnamed_1208, fragment_unnamed_1158), fragment_unnamed_1158, fragment_unnamed_1208));
				float fragment_unnamed_1213 = (-0.0f) - fragment_unnamed_344;
				float fragment_unnamed_1214 = (-0.0f) - fragment_unnamed_345;
				float fragment_unnamed_1215 = (-0.0f) - fragment_unnamed_346;
				float fragment_unnamed_1216 = dot(float3(fragment_unnamed_1213, fragment_unnamed_1214, fragment_unnamed_1215), float3(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880));
				float fragment_unnamed_1220 = (-0.0f) - (fragment_unnamed_1216 + fragment_unnamed_1216);
				float fragment_unnamed_1221 = mad(fragment_unnamed_878, fragment_unnamed_1220, fragment_unnamed_1213);
				float fragment_unnamed_1222 = mad(fragment_unnamed_879, fragment_unnamed_1220, fragment_unnamed_1214);
				float fragment_unnamed_1223 = mad(fragment_unnamed_880, fragment_unnamed_1220, fragment_unnamed_1215);
				float fragment_unnamed_1225 = ((-0.0f) - fragment_unnamed_1158) + 1.0f;
				float fragment_unnamed_1227 = mad(fragment_unnamed_1154, 0.984375f, 0.0078125f);
				float fragment_unnamed_1228 = mad(sqrt(fragment_unnamed_1225), 0.984375f, 0.0078125f);
				float4 fragment_unnamed_1233 = _LtcData.SampleLevel(S0, float3(fragment_unnamed_1227, fragment_unnamed_1228, asfloat(1065353216u)), 0.0f);
				float fragment_unnamed_1235 = fragment_unnamed_1233.x;
				float fragment_unnamed_1236 = fragment_unnamed_1233.y;
				float fragment_unnamed_1237 = fragment_unnamed_1233.z;
				float fragment_unnamed_1238 = fragment_unnamed_1233.w;
				float4 fragment_unnamed_1239 = _LtcData.SampleLevel(S0, float3(fragment_unnamed_1227, fragment_unnamed_1228, asfloat(0u)), 0.0f);
				float fragment_unnamed_1241 = fragment_unnamed_1239.x;
				float fragment_unnamed_1242 = fragment_unnamed_1239.y;
				float fragment_unnamed_1243 = fragment_unnamed_1239.z;
				float fragment_unnamed_1244 = fragment_unnamed_1239.w;
				bool fragment_unnamed_1248 = 5.9604644775390625e-08f >= abs(((-0.0f) - fragment_unnamed_1155) + 1.0f);
				bool fragment_unnamed_1250 = fragment_unnamed_880 >= 0.0f;
				float fragment_unnamed_1252 = asfloat(fragment_unnamed_1250 ? 1065353216u : 3212836864u);
				float fragment_unnamed_1256 = 1.0f / mad(fragment_unnamed_872, fragment_unnamed_877, fragment_unnamed_1252);
				float fragment_unnamed_1257 = fragment_unnamed_879 * fragment_unnamed_1256;
				float fragment_unnamed_1258 = fragment_unnamed_878 * fragment_unnamed_1252;
				float fragment_unnamed_1259 = fragment_unnamed_878 * fragment_unnamed_1257;
				float fragment_unnamed_1267 = mad((-0.0f) - fragment_unnamed_878, fragment_unnamed_1155, fragment_unnamed_344);
				float fragment_unnamed_1268 = mad((-0.0f) - fragment_unnamed_879, fragment_unnamed_1155, fragment_unnamed_345);
				float fragment_unnamed_1269 = mad((-0.0f) - fragment_unnamed_880, fragment_unnamed_1155, fragment_unnamed_346);
				float fragment_unnamed_1273 = rsqrt(dot(float3(fragment_unnamed_1267, fragment_unnamed_1268, fragment_unnamed_1269), float3(fragment_unnamed_1267, fragment_unnamed_1268, fragment_unnamed_1269)));
				float fragment_unnamed_1274 = fragment_unnamed_1273 * fragment_unnamed_1267;
				float fragment_unnamed_1275 = fragment_unnamed_1273 * fragment_unnamed_1268;
				float fragment_unnamed_1276 = fragment_unnamed_1273 * fragment_unnamed_1269;
				float fragment_unnamed_1295 = asfloat(fragment_unnamed_1248 ? asuint(fragment_unnamed_1259) : asuint(mad(fragment_unnamed_879, fragment_unnamed_1276, (-0.0f) - (fragment_unnamed_880 * fragment_unnamed_1275))));
				float fragment_unnamed_1297 = asfloat(fragment_unnamed_1248 ? asuint(mad(fragment_unnamed_879, fragment_unnamed_1257, asfloat(fragment_unnamed_1250 ? 3212836864u : 1065353216u))) : asuint(mad(fragment_unnamed_880, fragment_unnamed_1274, (-0.0f) - (fragment_unnamed_878 * fragment_unnamed_1276))));
				float fragment_unnamed_1305 = asfloat(fragment_unnamed_1248 ? asuint(mad(fragment_unnamed_878 * fragment_unnamed_1258, fragment_unnamed_1256, -1.0f)) : asuint(fragment_unnamed_1274));
				float fragment_unnamed_1462;
				float fragment_unnamed_1464;
				float fragment_unnamed_1466;
				if (int(asuint(fragment_uniform_buffer_0[116u]).z) >= int(0u))
				{
					uint fragment_unnamed_1319 = (asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 4u;
					uint3 fragment_unnamed_1329 = uint3(T6.Load(fragment_unnamed_1319).x, T6.Load(fragment_unnamed_1319 + 1u).x, T6.Load(fragment_unnamed_1319 + 2u).x);
					float fragment_unnamed_1331 = asfloat(fragment_unnamed_1329.x);
					float fragment_unnamed_1333 = asfloat(fragment_unnamed_1329.y);
					float fragment_unnamed_1335 = asfloat(fragment_unnamed_1329.z);
					float fragment_unnamed_1463;
					float fragment_unnamed_1465;
					float fragment_unnamed_1467;
					if ((((0.0f < dot(float3(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880), float3((-0.0f) - fragment_unnamed_1331, (-0.0f) - fragment_unnamed_1333, (-0.0f) - fragment_unnamed_1335))) ? 4294967295u : 0u) & (((0.0f < asfloat(T6.Load((asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 27u).x)) ? 4294967295u : 0u) & ((0.0f < asfloat(T6.Load((asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 38u).x)) ? 4294967295u : 0u))) != 0u)
					{
						uint4 fragment_unnamed_1384 = uint4(T32.Load(0u).x, T32.Load(0u + 1u).x, T32.Load(0u + 2u).x, T32.Load(0u + 3u).x);
						float fragment_unnamed_1386 = asfloat(fragment_unnamed_1384.x);
						float fragment_unnamed_1388 = asfloat(fragment_unnamed_1384.y);
						float fragment_unnamed_1390 = asfloat(fragment_unnamed_1384.z);
						float fragment_unnamed_1392 = asfloat(fragment_unnamed_1384.w);
						uint4 fragment_unnamed_1404 = uint4(T32.Load(4u).x, T32.Load(4u + 1u).x, T32.Load(4u + 2u).x, T32.Load(4u + 3u).x);
						float fragment_unnamed_1406 = asfloat(fragment_unnamed_1404.x);
						float fragment_unnamed_1408 = asfloat(fragment_unnamed_1404.y);
						float fragment_unnamed_1410 = asfloat(fragment_unnamed_1404.z);
						float fragment_unnamed_1412 = asfloat(fragment_unnamed_1404.w);
						uint4 fragment_unnamed_1424 = uint4(T32.Load(8u).x, T32.Load(8u + 1u).x, T32.Load(8u + 2u).x, T32.Load(8u + 3u).x);
						float fragment_unnamed_1426 = asfloat(fragment_unnamed_1424.x);
						float fragment_unnamed_1428 = asfloat(fragment_unnamed_1424.y);
						float fragment_unnamed_1430 = asfloat(fragment_unnamed_1424.z);
						float fragment_unnamed_1432 = asfloat(fragment_unnamed_1424.w);
						uint4 fragment_unnamed_1444 = uint4(T32.Load(12u).x, T32.Load(12u + 1u).x, T32.Load(12u + 2u).x, T32.Load(12u + 3u).x);
						float fragment_unnamed_1446 = asfloat(fragment_unnamed_1444.x);
						float fragment_unnamed_1448 = asfloat(fragment_unnamed_1444.y);
						float fragment_unnamed_1450 = asfloat(fragment_unnamed_1444.z);
						float fragment_unnamed_1452 = asfloat(fragment_unnamed_1444.w);
						float fragment_unnamed_1453 = asfloat(0u);
						float fragment_unnamed_1454 = asfloat(0u);
						float fragment_unnamed_1455 = asfloat(0u);
						float fragment_unnamed_1456 = asfloat(4294967295u);
						float fragment_unnamed_1457 = asfloat(0u);
						float fragment_unnamed_1458 = asfloat(0u);
						float fragment_unnamed_1589;
						float fragment_unnamed_1591;
						float fragment_unnamed_1593;
						float fragment_unnamed_1595;
						float fragment_unnamed_1621;
						float fragment_unnamed_1622;
						float fragment_unnamed_1623;
						float fragment_unnamed_1625;
						float fragment_unnamed_1627;
						float fragment_unnamed_1586 = fragment_unnamed_1456;
						float fragment_unnamed_1588 = fragment_unnamed_1457;
						float fragment_unnamed_1590 = fragment_unnamed_1453;
						float fragment_unnamed_1592 = fragment_unnamed_1454;
						float fragment_unnamed_1594 = fragment_unnamed_1455;
						float fragment_unnamed_1596 = fragment_unnamed_1458;
						for (;;)
						{
							if (asuint(fragment_unnamed_1596) >= asuint(fragment_uniform_buffer_0[116u]).y)
							{
								fragment_unnamed_1621 = fragment_unnamed_1586;
								fragment_unnamed_1622 = fragment_unnamed_1588;
								fragment_unnamed_1623 = fragment_unnamed_1590;
								fragment_unnamed_1625 = fragment_unnamed_1592;
								fragment_unnamed_1627 = fragment_unnamed_1594;
								break;
							}
							else
							{
								uint fragment_unnamed_1634 = (asuint(fragment_unnamed_1596) * 4u) + 0u;
								uint fragment_unnamed_1644 = (asuint(fragment_unnamed_1596) * 4u) + 1u;
								uint fragment_unnamed_1653 = (asuint(fragment_unnamed_1596) * 4u) + 2u;
								uint fragment_unnamed_1662 = (asuint(fragment_unnamed_1596) * 4u) + 3u;
								fragment_unnamed_1591 = ((-0.0f) - mad(fragment_unnamed_107[fragment_unnamed_1662], fragment_unnamed_1446, mad(fragment_unnamed_107[fragment_unnamed_1653], fragment_unnamed_1426, mad(fragment_unnamed_107[fragment_unnamed_1644], fragment_unnamed_1406, fragment_unnamed_1386 * fragment_unnamed_107[fragment_unnamed_1634])))) + fragment_input_6.x;
								fragment_unnamed_1593 = ((-0.0f) - mad(fragment_unnamed_107[fragment_unnamed_1662], fragment_unnamed_1448, mad(fragment_unnamed_107[fragment_unnamed_1653], fragment_unnamed_1428, mad(fragment_unnamed_107[fragment_unnamed_1644], fragment_unnamed_1408, fragment_unnamed_1388 * fragment_unnamed_107[fragment_unnamed_1634])))) + fragment_input_6.y;
								fragment_unnamed_1595 = ((-0.0f) - mad(fragment_unnamed_107[fragment_unnamed_1662], fragment_unnamed_1450, mad(fragment_unnamed_107[fragment_unnamed_1653], fragment_unnamed_1430, mad(fragment_unnamed_107[fragment_unnamed_1644], fragment_unnamed_1410, fragment_unnamed_1390 * fragment_unnamed_107[fragment_unnamed_1634])))) + fragment_input_6.z;
								float fragment_unnamed_1678 = dot(float3(fragment_unnamed_1591, fragment_unnamed_1593, fragment_unnamed_1595), float3(fragment_unnamed_1591, fragment_unnamed_1593, fragment_unnamed_1595));
								fragment_unnamed_1589 = fragment_unnamed_1678 / mad(fragment_unnamed_107[fragment_unnamed_1662], fragment_unnamed_1452, mad(fragment_unnamed_107[fragment_unnamed_1653], fragment_unnamed_1432, mad(fragment_unnamed_107[fragment_unnamed_1644], fragment_unnamed_1412, fragment_unnamed_1392 * fragment_unnamed_107[fragment_unnamed_1634])));
								if (!((((1.0f >= fragment_unnamed_1589) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1589) ? 4294967295u : 0u)) != 0u))
								{
									fragment_unnamed_1586 = asfloat(4294967295u);
									fragment_unnamed_1588 = fragment_unnamed_1589;
									fragment_unnamed_1590 = fragment_unnamed_1591;
									fragment_unnamed_1592 = fragment_unnamed_1593;
									fragment_unnamed_1594 = fragment_unnamed_1595;
									fragment_unnamed_1596 = asfloat(asuint(fragment_unnamed_1596) + 1u);
									continue;
								}
								float fragment_unnamed_1937 = sqrt(fragment_unnamed_1678);
								fragment_unnamed_1621 = fragment_unnamed_1596;
								fragment_unnamed_1622 = fragment_unnamed_1589;
								fragment_unnamed_1623 = fragment_unnamed_1591 / fragment_unnamed_1937;
								fragment_unnamed_1625 = fragment_unnamed_1593 / fragment_unnamed_1937;
								fragment_unnamed_1627 = fragment_unnamed_1595 / fragment_unnamed_1937;
								break;
							}
						}
						float fragment_unnamed_1630 = float(int(asuint(fragment_unnamed_1621)));
						float fragment_unnamed_1604;
						if (fragment_unnamed_1630 >= 0.0f)
						{
							uint4 fragment_unnamed_1778 = uint4(T32.Load(19u).x, T32.Load(19u + 1u).x, T32.Load(19u + 2u).x, T32.Load(19u + 3u).x);
							uint4 fragment_unnamed_1793 = T6.Load((asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 15u);
							uint fragment_unnamed_1794 = fragment_unnamed_1793.x;
							float fragment_unnamed_1805 = asfloat((dot(float3(fragment_unnamed_250, fragment_unnamed_251, fragment_unnamed_252), float3((-0.0f) - fragment_unnamed_1331, (-0.0f) - fragment_unnamed_1333, (-0.0f) - fragment_unnamed_1335)) >= 0.0f) ? 1065353216u : 3212836864u);
							uint fragment_unnamed_1813 = asuint(fragment_unnamed_1621);
							float fragment_unnamed_1830 = dot(float4(asfloat(fragment_unnamed_1778.y), asfloat(fragment_unnamed_1778.z), asfloat(fragment_unnamed_1778.w), asfloat(T32.Load(23u).x)), float4(fragment_unnamed_107[(fragment_unnamed_1813 * 4u) + 0u], fragment_unnamed_107[(fragment_unnamed_1813 * 4u) + 1u], fragment_unnamed_107[(fragment_unnamed_1813 * 4u) + 2u], fragment_unnamed_107[(fragment_unnamed_1813 * 4u) + 3u]));
							float fragment_unnamed_1842 = asfloat((0.0f >= fragment_unnamed_1830) ? 0u : asuint(clamp((fragment_unnamed_1622 + ((-0.0f) - (((-0.0f) - fragment_unnamed_1830) + 1.0f))) / fragment_unnamed_1830, 0.0f, 1.0f)));
							float fragment_unnamed_1849 = clamp((fragment_unnamed_1830 + (-1.0f)) * (-3.3333332538604736328125f), 0.0f, 1.0f);
							float fragment_unnamed_1860 = mad(clamp(mad((fragment_unnamed_1849 * fragment_unnamed_1849) * mad(fragment_unnamed_1849, -2.0f, 3.0f), 512.0f, 8.0f) * dot(float3(fragment_unnamed_335, fragment_unnamed_337, fragment_unnamed_339), float3(fragment_unnamed_1623, fragment_unnamed_1625, fragment_unnamed_1627)), 0.0f, 1.0f), (-0.0f) - fragment_unnamed_1842, fragment_unnamed_1842);
							float fragment_unnamed_1866 = asfloat(T31.Load((fragment_unnamed_1794 * 60u) + 19u).x);
							uint fragment_unnamed_1868 = (fragment_unnamed_1794 * 60u) + 24u;
							uint2 fragment_unnamed_1874 = uint2(T31.Load(fragment_unnamed_1868).x, T31.Load(fragment_unnamed_1868 + 1u).x);
							uint fragment_unnamed_1880 = asuint(fragment_unnamed_1621) + fragment_unnamed_1794;
							uint fragment_unnamed_1882 = (fragment_unnamed_1880 * 60u) + 16u;
							uint3 fragment_unnamed_1891 = uint3(T31.Load(fragment_unnamed_1882).x, T31.Load(fragment_unnamed_1882 + 1u).x, T31.Load(fragment_unnamed_1882 + 2u).x);
							float fragment_unnamed_1897 = asfloat(fragment_unnamed_1891.z);
							float fragment_unnamed_1901 = fragment_unnamed_1897 * (fragment_unnamed_1866 * (fragment_unnamed_250 * fragment_unnamed_1805));
							float fragment_unnamed_1902 = fragment_unnamed_1897 * (fragment_unnamed_1866 * (fragment_unnamed_251 * fragment_unnamed_1805));
							float fragment_unnamed_1903 = fragment_unnamed_1897 * (fragment_unnamed_1866 * (fragment_unnamed_252 * fragment_unnamed_1805));
							uint fragment_unnamed_1906 = uint(int(asfloat(fragment_unnamed_1778.x))) + 4294967295u;
							float fragment_unnamed_1908 = float(int(uint(min(int(asuint(fragment_unnamed_1621) + 1u), int(fragment_unnamed_1906)))));
							float fragment_unnamed_1918 = trunc(fragment_uniform_buffer_0[74u].z);
							float fragment_unnamed_2336;
							float fragment_unnamed_2337;
							float fragment_unnamed_2338;
							float fragment_unnamed_2339;
							float fragment_unnamed_2340;
							float fragment_unnamed_2341;
							float fragment_unnamed_2342;
							float fragment_unnamed_2343;
							float fragment_unnamed_2344;
							float fragment_unnamed_2345;
							float fragment_unnamed_2346;
							float fragment_unnamed_2347;
							float fragment_unnamed_2348;
							float fragment_unnamed_2349;
							float fragment_unnamed_2350;
							float fragment_unnamed_2351;
							float fragment_unnamed_2352;
							float fragment_unnamed_2353;
							float fragment_unnamed_2354;
							float fragment_unnamed_2355;
							float fragment_unnamed_2356;
							float fragment_unnamed_2357;
							float fragment_unnamed_2358;
							float fragment_unnamed_2359;
							if (((((fragment_unnamed_1630 != fragment_unnamed_1908) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1860) ? 4294967295u : 0u)) & ((fragment_unnamed_1860 >= frac(frac(dot(float2(mad(fragment_unnamed_1918, 2.0829999446868896484375f, float(fragment_unnamed_281)), mad(fragment_unnamed_1918, 4.867000102996826171875f, float(fragment_unnamed_282))), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f))) * 52.98291778564453125f)) ? 4294967295u : 0u)) != 0u)
							{
								uint fragment_unnamed_1979 = uint(int(fragment_unnamed_1908 + float(int(fragment_unnamed_1794))));
								uint fragment_unnamed_1980 = fragment_unnamed_1979 * 60u;
								uint4 fragment_unnamed_1992 = uint4(T31.Load(fragment_unnamed_1980).x, T31.Load(fragment_unnamed_1980 + 1u).x, T31.Load(fragment_unnamed_1980 + 2u).x, T31.Load(fragment_unnamed_1980 + 3u).x);
								uint fragment_unnamed_1999 = (fragment_unnamed_1979 * 60u) + 4u;
								uint4 fragment_unnamed_2011 = uint4(T31.Load(fragment_unnamed_1999).x, T31.Load(fragment_unnamed_1999 + 1u).x, T31.Load(fragment_unnamed_1999 + 2u).x, T31.Load(fragment_unnamed_1999 + 3u).x);
								uint fragment_unnamed_2017 = (fragment_unnamed_1979 * 60u) + 12u;
								uint4 fragment_unnamed_2029 = uint4(T31.Load(fragment_unnamed_2017).x, T31.Load(fragment_unnamed_2017 + 1u).x, T31.Load(fragment_unnamed_2017 + 2u).x, T31.Load(fragment_unnamed_2017 + 3u).x);
								uint fragment_unnamed_2039 = (fragment_unnamed_1979 * 60u) + 8u;
								uint4 fragment_unnamed_2051 = uint4(T31.Load(fragment_unnamed_2039).x, T31.Load(fragment_unnamed_2039 + 1u).x, T31.Load(fragment_unnamed_2039 + 2u).x, T31.Load(fragment_unnamed_2039 + 3u).x);
								uint fragment_unnamed_2059 = (fragment_unnamed_1979 * 60u) + 16u;
								uint3 fragment_unnamed_2068 = uint3(T31.Load(fragment_unnamed_2059).x, T31.Load(fragment_unnamed_2059 + 1u).x, T31.Load(fragment_unnamed_2059 + 2u).x);
								uint fragment_unnamed_2075 = (fragment_unnamed_1979 * 60u) + 40u;
								uint3 fragment_unnamed_2084 = uint3(T31.Load(fragment_unnamed_2075).x, T31.Load(fragment_unnamed_2075 + 1u).x, T31.Load(fragment_unnamed_2075 + 2u).x);
								float fragment_unnamed_2100 = asfloat(fragment_unnamed_2068.z) / fragment_unnamed_1897;
								fragment_unnamed_2336 = fragment_unnamed_2100 * fragment_unnamed_1901;
								fragment_unnamed_2337 = asfloat(fragment_unnamed_2068.x);
								fragment_unnamed_2338 = asfloat(fragment_unnamed_2068.y);
								fragment_unnamed_2339 = fragment_unnamed_2100 * fragment_unnamed_1902;
								fragment_unnamed_2340 = fragment_unnamed_2100 * fragment_unnamed_1903;
								fragment_unnamed_2341 = asfloat(fragment_unnamed_1992.w);
								fragment_unnamed_2342 = asfloat(fragment_unnamed_2011.x);
								fragment_unnamed_2343 = asfloat(fragment_unnamed_2011.y);
								fragment_unnamed_2344 = asfloat(fragment_unnamed_2051.z);
								fragment_unnamed_2345 = asfloat(fragment_unnamed_2029.z);
								fragment_unnamed_2346 = asfloat(fragment_unnamed_2029.w);
								fragment_unnamed_2347 = asfloat(fragment_unnamed_2029.x);
								fragment_unnamed_2348 = asfloat(fragment_unnamed_2029.y);
								fragment_unnamed_2349 = asfloat(fragment_unnamed_2011.z);
								fragment_unnamed_2350 = asfloat(fragment_unnamed_2011.w);
								fragment_unnamed_2351 = asfloat(fragment_unnamed_2051.x);
								fragment_unnamed_2352 = asfloat(fragment_unnamed_2051.w);
								fragment_unnamed_2353 = asfloat(fragment_unnamed_2084.x) + fragment_input_6.x;
								fragment_unnamed_2354 = asfloat(fragment_unnamed_2084.y) + fragment_input_6.y;
								fragment_unnamed_2355 = asfloat(fragment_unnamed_2084.z) + fragment_input_6.z;
								fragment_unnamed_2356 = asfloat(fragment_unnamed_1992.x);
								fragment_unnamed_2357 = asfloat(fragment_unnamed_1992.y);
								fragment_unnamed_2358 = asfloat(fragment_unnamed_1992.z);
								fragment_unnamed_2359 = asfloat(fragment_unnamed_2051.y);
							}
							else
							{
								uint fragment_unnamed_2115 = fragment_unnamed_1880 * 60u;
								uint4 fragment_unnamed_2127 = uint4(T31.Load(fragment_unnamed_2115).x, T31.Load(fragment_unnamed_2115 + 1u).x, T31.Load(fragment_unnamed_2115 + 2u).x, T31.Load(fragment_unnamed_2115 + 3u).x);
								uint fragment_unnamed_2134 = (fragment_unnamed_1880 * 60u) + 4u;
								uint4 fragment_unnamed_2146 = uint4(T31.Load(fragment_unnamed_2134).x, T31.Load(fragment_unnamed_2134 + 1u).x, T31.Load(fragment_unnamed_2134 + 2u).x, T31.Load(fragment_unnamed_2134 + 3u).x);
								uint fragment_unnamed_2152 = (fragment_unnamed_1880 * 60u) + 12u;
								uint4 fragment_unnamed_2164 = uint4(T31.Load(fragment_unnamed_2152).x, T31.Load(fragment_unnamed_2152 + 1u).x, T31.Load(fragment_unnamed_2152 + 2u).x, T31.Load(fragment_unnamed_2152 + 3u).x);
								uint fragment_unnamed_2174 = (fragment_unnamed_1880 * 60u) + 8u;
								uint4 fragment_unnamed_2186 = uint4(T31.Load(fragment_unnamed_2174).x, T31.Load(fragment_unnamed_2174 + 1u).x, T31.Load(fragment_unnamed_2174 + 2u).x, T31.Load(fragment_unnamed_2174 + 3u).x);
								uint fragment_unnamed_2194 = (fragment_unnamed_1880 * 60u) + 40u;
								uint3 fragment_unnamed_2203 = uint3(T31.Load(fragment_unnamed_2194).x, T31.Load(fragment_unnamed_2194 + 1u).x, T31.Load(fragment_unnamed_2194 + 2u).x);
								fragment_unnamed_2336 = fragment_unnamed_1901;
								fragment_unnamed_2337 = asfloat(fragment_unnamed_1891.x);
								fragment_unnamed_2338 = asfloat(fragment_unnamed_1891.y);
								fragment_unnamed_2339 = fragment_unnamed_1902;
								fragment_unnamed_2340 = fragment_unnamed_1903;
								fragment_unnamed_2341 = asfloat(fragment_unnamed_2127.w);
								fragment_unnamed_2342 = asfloat(fragment_unnamed_2146.x);
								fragment_unnamed_2343 = asfloat(fragment_unnamed_2146.y);
								fragment_unnamed_2344 = asfloat(fragment_unnamed_2186.z);
								fragment_unnamed_2345 = asfloat(fragment_unnamed_2164.z);
								fragment_unnamed_2346 = asfloat(fragment_unnamed_2164.w);
								fragment_unnamed_2347 = asfloat(fragment_unnamed_2164.x);
								fragment_unnamed_2348 = asfloat(fragment_unnamed_2164.y);
								fragment_unnamed_2349 = asfloat(fragment_unnamed_2146.z);
								fragment_unnamed_2350 = asfloat(fragment_unnamed_2146.w);
								fragment_unnamed_2351 = asfloat(fragment_unnamed_2186.x);
								fragment_unnamed_2352 = asfloat(fragment_unnamed_2186.w);
								fragment_unnamed_2353 = asfloat(fragment_unnamed_2203.x) + fragment_input_6.x;
								fragment_unnamed_2354 = asfloat(fragment_unnamed_2203.y) + fragment_input_6.y;
								fragment_unnamed_2355 = asfloat(fragment_unnamed_2203.z) + fragment_input_6.z;
								fragment_unnamed_2356 = asfloat(fragment_unnamed_2127.x);
								fragment_unnamed_2357 = asfloat(fragment_unnamed_2127.y);
								fragment_unnamed_2358 = asfloat(fragment_unnamed_2127.z);
								fragment_unnamed_2359 = asfloat(fragment_unnamed_2186.y);
							}
							float fragment_unnamed_2360 = fragment_unnamed_2336 + fragment_unnamed_2353;
							float fragment_unnamed_2361 = fragment_unnamed_2339 + fragment_unnamed_2354;
							float fragment_unnamed_2362 = fragment_unnamed_2340 + fragment_unnamed_2355;
							float fragment_unnamed_2363 = asfloat(1065353216u);
							float fragment_unnamed_2390 = mad(asfloat(fragment_unnamed_1874.x) * clamp(mad(dot(float4(fragment_unnamed_2356, fragment_unnamed_2357, fragment_unnamed_2358, fragment_unnamed_2359), float4(fragment_unnamed_2360, fragment_unnamed_2361, fragment_unnamed_2362, fragment_unnamed_2363)) * fragment_unnamed_2347, 0.5f, 0.5f), 0.0f, 1.0f), fragment_uniform_buffer_0[98u].z, fragment_unnamed_2337);
							float fragment_unnamed_2391 = mad(asfloat(fragment_unnamed_1874.y) * clamp(mad(dot(float4(fragment_unnamed_2341, fragment_unnamed_2342, fragment_unnamed_2343, fragment_unnamed_2344), float4(fragment_unnamed_2360, fragment_unnamed_2361, fragment_unnamed_2362, fragment_unnamed_2363)) * fragment_unnamed_2348, 0.5f, 0.5f), 0.0f, 1.0f), fragment_uniform_buffer_0[98u].w, fragment_unnamed_2338);
							float fragment_unnamed_2392 = dot(float2(fragment_unnamed_2345, fragment_unnamed_2346), float2(dot(float4(fragment_unnamed_2349, fragment_unnamed_2350, fragment_unnamed_2351, fragment_unnamed_2352), float4(fragment_unnamed_2360, fragment_unnamed_2361, fragment_unnamed_2362, fragment_unnamed_2363)), asfloat(1065353216u))) + 1.52587890625e-05f;
							float fragment_unnamed_2400 = floor(mad(fragment_unnamed_2390, fragment_uniform_buffer_0[98u].x, 0.5f));
							float fragment_unnamed_2401 = floor(mad(fragment_unnamed_2391, fragment_uniform_buffer_0[98u].y, 0.5f));
							float fragment_unnamed_2408 = mad(fragment_unnamed_2390, fragment_uniform_buffer_0[98u].x, (-0.0f) - fragment_unnamed_2400);
							float fragment_unnamed_2409 = mad(fragment_unnamed_2391, fragment_uniform_buffer_0[98u].y, (-0.0f) - fragment_unnamed_2401);
							float fragment_unnamed_2410 = fragment_unnamed_2408 + 0.5f;
							float fragment_unnamed_2412 = fragment_unnamed_2409 + 0.5f;
							float fragment_unnamed_2418 = (fragment_unnamed_2410 * fragment_unnamed_2410) * 0.040816001594066619873046875f;
							float fragment_unnamed_2420 = (fragment_unnamed_2412 * fragment_unnamed_2412) * 0.040816001594066619873046875f;
							float fragment_unnamed_2429 = min(fragment_unnamed_2408, 0.0f);
							float fragment_unnamed_2430 = min(fragment_unnamed_2409, 0.0f);
							float fragment_unnamed_2435 = max(fragment_unnamed_2408, 0.0f);
							float fragment_unnamed_2436 = max(fragment_unnamed_2409, 0.0f);
							float fragment_unnamed_2450 = (mad((-0.0f) - fragment_unnamed_2429, fragment_unnamed_2429, ((-0.0f) - fragment_unnamed_2408) + 1.0f) + 2.0f) * 0.08163200318813323974609375f;
							float fragment_unnamed_2451 = (mad((-0.0f) - fragment_unnamed_2430, fragment_unnamed_2430, ((-0.0f) - fragment_unnamed_2409) + 1.0f) + 2.0f) * 0.08163200318813323974609375f;
							float fragment_unnamed_2456 = mad(fragment_unnamed_2408, -0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2457 = mad(fragment_unnamed_2408, 0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2458 = fragment_unnamed_2456 + (mad(fragment_unnamed_2410 * fragment_unnamed_2410, 0.5f, (-0.0f) - fragment_unnamed_2408) * 0.08163200318813323974609375f);
							float fragment_unnamed_2459 = fragment_unnamed_2450 + mad(fragment_unnamed_2408, -0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2460 = fragment_unnamed_2457 + ((mad((-0.0f) - fragment_unnamed_2435, fragment_unnamed_2435, fragment_unnamed_2408 + 1.0f) + 2.0f) * 0.08163200318813323974609375f);
							float fragment_unnamed_2461 = fragment_unnamed_2418 + mad(fragment_unnamed_2408, 0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2464 = mad(fragment_unnamed_2409, -0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2465 = mad(fragment_unnamed_2409, 0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2466 = fragment_unnamed_2464 + (mad(fragment_unnamed_2412 * fragment_unnamed_2412, 0.5f, (-0.0f) - fragment_unnamed_2409) * 0.08163200318813323974609375f);
							float fragment_unnamed_2467 = fragment_unnamed_2451 + mad(fragment_unnamed_2409, -0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2468 = fragment_unnamed_2465 + ((mad((-0.0f) - fragment_unnamed_2436, fragment_unnamed_2436, fragment_unnamed_2409 + 1.0f) + 2.0f) * 0.08163200318813323974609375f);
							float fragment_unnamed_2469 = fragment_unnamed_2420 + mad(fragment_unnamed_2409, 0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2492 = ((fragment_unnamed_2418 / fragment_unnamed_2461) + 2.5f) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2493 = ((fragment_unnamed_2456 / fragment_unnamed_2458) + (-3.5f)) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2494 = ((fragment_unnamed_2450 / fragment_unnamed_2459) + (-1.5f)) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2495 = ((fragment_unnamed_2457 / fragment_unnamed_2460) + 0.5f) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2499 = ((fragment_unnamed_2464 / fragment_unnamed_2466) + (-3.5f)) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2500 = ((fragment_unnamed_2420 / fragment_unnamed_2469) + 2.5f) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2501 = ((fragment_unnamed_2451 / fragment_unnamed_2467) + (-1.5f)) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2502 = ((fragment_unnamed_2465 / fragment_unnamed_2468) + 0.5f) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2579 = fragment_unnamed_2466 * fragment_unnamed_2458;
							float fragment_unnamed_2580 = fragment_unnamed_2466 * fragment_unnamed_2459;
							float fragment_unnamed_2581 = fragment_unnamed_2466 * fragment_unnamed_2460;
							float fragment_unnamed_2582 = fragment_unnamed_2466 * fragment_unnamed_2461;
							float fragment_unnamed_2583 = fragment_unnamed_2467 * fragment_unnamed_2458;
							float fragment_unnamed_2584 = fragment_unnamed_2467 * fragment_unnamed_2459;
							float fragment_unnamed_2585 = fragment_unnamed_2467 * fragment_unnamed_2460;
							float fragment_unnamed_2586 = fragment_unnamed_2467 * fragment_unnamed_2461;
							float fragment_unnamed_2587 = fragment_unnamed_2468 * fragment_unnamed_2458;
							float fragment_unnamed_2588 = fragment_unnamed_2468 * fragment_unnamed_2459;
							float fragment_unnamed_2589 = fragment_unnamed_2468 * fragment_unnamed_2460;
							float fragment_unnamed_2590 = fragment_unnamed_2468 * fragment_unnamed_2461;
							float fragment_unnamed_2591 = fragment_unnamed_2469 * fragment_unnamed_2458;
							float fragment_unnamed_2592 = fragment_unnamed_2469 * fragment_unnamed_2459;
							float fragment_unnamed_2593 = fragment_unnamed_2469 * fragment_unnamed_2460;
							float fragment_unnamed_2594 = fragment_unnamed_2469 * fragment_unnamed_2461;
							float4 fragment_unnamed_2600 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2493), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2499)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_2601 = fragment_unnamed_2600.x;
							float4 fragment_unnamed_2604 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2494), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2499)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_2605 = fragment_unnamed_2604.x;
							float4 fragment_unnamed_2608 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2495), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2499)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_2609 = fragment_unnamed_2608.x;
							float4 fragment_unnamed_2612 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2492), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2499)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_2613 = fragment_unnamed_2612.x;
							float fragment_unnamed_2615 = asfloat(0u);
							float fragment_unnamed_2925;
							fragment_unnamed_2925 = asfloat(0u);
							float fragment_unnamed_2926;
							float fragment_unnamed_3090;
							float fragment_unnamed_3091;
							float fragment_unnamed_3092;
							for (float fragment_unnamed_2927 = fragment_unnamed_2615; !(int(asuint(fragment_unnamed_2927)) >= int(1u)); fragment_unnamed_3090 = mad(fragment_unnamed_2579, fragment_unnamed_2601, fragment_unnamed_2925), fragment_unnamed_3091 = mad(fragment_unnamed_2580, fragment_unnamed_2605, fragment_unnamed_3090), fragment_unnamed_3092 = mad(fragment_unnamed_2581, fragment_unnamed_2609, fragment_unnamed_3091), fragment_unnamed_2926 = mad(fragment_unnamed_2582, fragment_unnamed_2613, fragment_unnamed_3092), fragment_unnamed_2925 = fragment_unnamed_2926, fragment_unnamed_2927 = asfloat(asuint(fragment_unnamed_2927) + 1u))
							{
							}
							float4 fragment_unnamed_3075 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2493), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2501)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_3076 = fragment_unnamed_3075.x;
							float4 fragment_unnamed_3079 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2494), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2501)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_3080 = fragment_unnamed_3079.x;
							float4 fragment_unnamed_3083 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2495), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2501)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_3084 = fragment_unnamed_3083.x;
							float4 fragment_unnamed_3087 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2492), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2501)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_3088 = fragment_unnamed_3087.x;
							float fragment_unnamed_3089 = asfloat(0u);
							float fragment_unnamed_3761;
							fragment_unnamed_3761 = fragment_unnamed_2925;
							float fragment_unnamed_3762;
							float fragment_unnamed_4115;
							float fragment_unnamed_4116;
							float fragment_unnamed_4117;
							for (float fragment_unnamed_3763 = fragment_unnamed_3089; !(int(asuint(fragment_unnamed_3763)) >= int(1u)); fragment_unnamed_4115 = mad(fragment_unnamed_2583, fragment_unnamed_3076, fragment_unnamed_3761), fragment_unnamed_4116 = mad(fragment_unnamed_2584, fragment_unnamed_3080, fragment_unnamed_4115), fragment_unnamed_4117 = mad(fragment_unnamed_2585, fragment_unnamed_3084, fragment_unnamed_4116), fragment_unnamed_3762 = mad(fragment_unnamed_2586, fragment_unnamed_3088, fragment_unnamed_4117), fragment_unnamed_3761 = fragment_unnamed_3762, fragment_unnamed_3763 = asfloat(asuint(fragment_unnamed_3763) + 1u))
							{
							}
							float4 fragment_unnamed_4100 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2493), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2502)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_4101 = fragment_unnamed_4100.x;
							float4 fragment_unnamed_4104 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2494), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2502)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_4105 = fragment_unnamed_4104.x;
							float4 fragment_unnamed_4108 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2495), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2502)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_4109 = fragment_unnamed_4108.x;
							float4 fragment_unnamed_4112 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2492), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2502)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_4113 = fragment_unnamed_4112.x;
							float fragment_unnamed_4114 = asfloat(0u);
							float fragment_unnamed_4805;
							fragment_unnamed_4805 = fragment_unnamed_3761;
							float fragment_unnamed_4806;
							float fragment_unnamed_5294;
							float fragment_unnamed_5295;
							float fragment_unnamed_5296;
							for (float fragment_unnamed_4807 = fragment_unnamed_4114; !(int(asuint(fragment_unnamed_4807)) >= int(1u)); fragment_unnamed_5294 = mad(fragment_unnamed_2587, fragment_unnamed_4101, fragment_unnamed_4805), fragment_unnamed_5295 = mad(fragment_unnamed_2588, fragment_unnamed_4105, fragment_unnamed_5294), fragment_unnamed_5296 = mad(fragment_unnamed_2589, fragment_unnamed_4109, fragment_unnamed_5295), fragment_unnamed_4806 = mad(fragment_unnamed_2590, fragment_unnamed_4113, fragment_unnamed_5296), fragment_unnamed_4805 = fragment_unnamed_4806, fragment_unnamed_4807 = asfloat(asuint(fragment_unnamed_4807) + 1u))
							{
							}
							float4 fragment_unnamed_5279 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2493), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2500)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_5280 = fragment_unnamed_5279.x;
							float4 fragment_unnamed_5283 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2494), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2500)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_5284 = fragment_unnamed_5283.x;
							float4 fragment_unnamed_5287 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2495), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2500)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_5288 = fragment_unnamed_5287.x;
							float4 fragment_unnamed_5291 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2400, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2492), mad(fragment_unnamed_2401, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2500)), fragment_unnamed_2392).xxxx;
							float fragment_unnamed_5292 = fragment_unnamed_5291.x;
							float fragment_unnamed_5293 = asfloat(0u);
							float fragment_unnamed_6376;
							fragment_unnamed_6376 = fragment_unnamed_4805;
							float fragment_unnamed_6377;
							float fragment_unnamed_6541;
							float fragment_unnamed_6542;
							float fragment_unnamed_6543;
							for (float fragment_unnamed_6378 = fragment_unnamed_5293; !(int(asuint(fragment_unnamed_6378)) >= int(1u)); fragment_unnamed_6541 = mad(fragment_unnamed_2591, fragment_unnamed_5280, fragment_unnamed_6376), fragment_unnamed_6542 = mad(fragment_unnamed_2592, fragment_unnamed_5284, fragment_unnamed_6541), fragment_unnamed_6543 = mad(fragment_unnamed_2593, fragment_unnamed_5288, fragment_unnamed_6542), fragment_unnamed_6377 = mad(fragment_unnamed_2594, fragment_unnamed_5292, fragment_unnamed_6543), fragment_unnamed_6376 = fragment_unnamed_6377, fragment_unnamed_6378 = asfloat(asuint(fragment_unnamed_6378) + 1u))
							{
							}
							fragment_unnamed_1604 = asfloat((int(asuint(fragment_unnamed_1621)) < int(fragment_unnamed_1906)) ? asuint(fragment_unnamed_6376) : asuint(mad(fragment_unnamed_1860, ((-0.0f) - fragment_unnamed_6376) + 1.0f, fragment_unnamed_6376)));
						}
						else
						{
							fragment_unnamed_1604 = asfloat(1065353216u);
						}
						fragment_unnamed_1463 = fragment_unnamed_1604;
						fragment_unnamed_1465 = fragment_unnamed_1604;
						fragment_unnamed_1467 = fragment_unnamed_1604;
					}
					else
					{
						fragment_unnamed_1463 = asfloat(1065353216u);
						fragment_unnamed_1465 = asfloat(1065353216u);
						fragment_unnamed_1467 = asfloat(1065353216u);
					}
					fragment_unnamed_1462 = fragment_unnamed_1463;
					fragment_unnamed_1464 = fragment_unnamed_1465;
					fragment_unnamed_1466 = fragment_unnamed_1467;
				}
				else
				{
					fragment_unnamed_1462 = asfloat(1065353216u);
					fragment_unnamed_1464 = asfloat(1065353216u);
					fragment_unnamed_1466 = asfloat(1065353216u);
				}
				float fragment_unnamed_1489 = asfloat((asuint(fragment_uniform_buffer_0[127u]).w != 0u) ? T5.Load((fragment_unnamed_285 * asuint(fragment_uniform_buffer_0[128u]).x) + fragment_unnamed_283).x : asuint(fragment_uniform_buffer_0[126u]).w);
				uint4 fragment_unnamed_1492 = asuint(fragment_uniform_buffer_0[127u]);
				uint fragment_unnamed_1493 = fragment_unnamed_1492.z;
				uint fragment_unnamed_1498 = 1u << (fragment_unnamed_1493 & 31u);
				uint fragment_unnamed_1531 = uint(int(min(float(int(fragment_unnamed_1498 + 4294967295u)), max(log2(mad(max((1.0f / gl_FragCoord.w) + ((-0.0f) - fragment_uniform_buffer_0[127u].x), 0.0f) / (((-0.0f) - fragment_uniform_buffer_0[127u].x) + fragment_uniform_buffer_0[127u].y), exp2(log2(abs(fragment_unnamed_1489)) * float(int(fragment_unnamed_1498))) + (-1.0f), 1.0f)) / log2(fragment_unnamed_1489), 0.0f))));
				uint4 fragment_unnamed_1544 = T4.Load((((fragment_unnamed_1531 * asuint(fragment_uniform_buffer_0[128u]).y) + fragment_unnamed_285) * asuint(fragment_uniform_buffer_0[128u]).x) + fragment_unnamed_283);
				uint fragment_unnamed_1545 = fragment_unnamed_1544.x;
				uint fragment_unnamed_1546 = fragment_unnamed_1545 & 67108863u;
				uint fragment_unnamed_1548 = fragment_unnamed_1545 >> 26u;
				float fragment_unnamed_1561 = dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_uniform_buffer_0[83u].xyz));
				float fragment_unnamed_1564 = fragment_unnamed_1225 * fragment_unnamed_1225;
				float fragment_unnamed_1572 = exp2(ceil(max((-0.0f) - fragment_uniform_buffer_0[123u].z, 0.0f)));
				float fragment_unnamed_1574 = fragment_unnamed_1225 * (fragment_unnamed_1564 * fragment_unnamed_1564);
				float fragment_unnamed_1575 = asfloat(1065353216u);
				float fragment_unnamed_1576 = asfloat(1065353216u);
				float fragment_unnamed_1577 = asfloat(1065353216u);
				float fragment_unnamed_1578 = asfloat(1065353216u);
				float fragment_unnamed_1579 = asfloat(0u);
				float fragment_unnamed_1580 = asfloat(0u);
				float fragment_unnamed_1581 = asfloat(0u);
				float fragment_unnamed_1582 = asfloat(0u);
				float fragment_unnamed_1583 = asfloat(0u);
				float fragment_unnamed_1584 = asfloat(0u);
				float fragment_unnamed_1585 = asfloat(0u);
				float fragment_unnamed_1605;
				float fragment_unnamed_1607;
				float fragment_unnamed_1609;
				float fragment_unnamed_1611;
				float fragment_unnamed_1613;
				float fragment_unnamed_1615;
				float fragment_unnamed_1617;
				for (;;)
				{
					fragment_unnamed_1605 = fragment_unnamed_1585;
					fragment_unnamed_1607 = fragment_unnamed_1579;
					fragment_unnamed_1609 = fragment_unnamed_1580;
					fragment_unnamed_1611 = fragment_unnamed_1581;
					fragment_unnamed_1613 = fragment_unnamed_1583;
					fragment_unnamed_1615 = fragment_unnamed_1584;
					fragment_unnamed_1617 = fragment_unnamed_1582;
					float fragment_unnamed_1606;
					float fragment_unnamed_1608;
					float fragment_unnamed_1610;
					float fragment_unnamed_1612;
					float fragment_unnamed_1614;
					float fragment_unnamed_1616;
					float fragment_unnamed_1618;
					bool ladder_phi_21;
					for (;;)
					{
						if (asuint(fragment_unnamed_1605) >= fragment_unnamed_1548)
						{
							ladder_phi_21 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_1762 = asuint(fragment_unnamed_1605);
							uint4 fragment_unnamed_1764 = T3.Load(fragment_unnamed_1546 + fragment_unnamed_1762);
							uint fragment_unnamed_1765 = fragment_unnamed_1764.x;
							if (fragment_unnamed_1765 == 4294967295u)
							{
								ladder_phi_21 = false;
								break;
							}
							uint fragment_unnamed_1952 = fragment_unnamed_1765 * 56u;
							uint4 fragment_unnamed_1965 = uint4(T7.Load(fragment_unnamed_1952).x, T7.Load(fragment_unnamed_1952 + 1u).x, T7.Load(fragment_unnamed_1952 + 2u).x, T7.Load(fragment_unnamed_1952 + 3u).x);
							fragment_unnamed_1606 = asfloat(asuint(fragment_unnamed_1605) + 1u);
							if (!((fragment_unnamed_885 & fragment_unnamed_1965.w) != 0u))
							{
								fragment_unnamed_1608 = fragment_unnamed_1607;
								fragment_unnamed_1610 = fragment_unnamed_1609;
								fragment_unnamed_1612 = fragment_unnamed_1611;
								fragment_unnamed_1614 = fragment_unnamed_1613;
								fragment_unnamed_1616 = fragment_unnamed_1615;
								fragment_unnamed_1618 = fragment_unnamed_1617;
								fragment_unnamed_1605 = fragment_unnamed_1606;
								fragment_unnamed_1607 = fragment_unnamed_1608;
								fragment_unnamed_1609 = fragment_unnamed_1610;
								fragment_unnamed_1611 = fragment_unnamed_1612;
								fragment_unnamed_1613 = fragment_unnamed_1614;
								fragment_unnamed_1615 = fragment_unnamed_1616;
								fragment_unnamed_1617 = fragment_unnamed_1618;
								continue;
							}
							uint fragment_unnamed_2245 = (fragment_unnamed_1765 * 56u) + 6u;
							uint4 fragment_unnamed_2257 = uint4(T7.Load(fragment_unnamed_2245).x, T7.Load(fragment_unnamed_2245 + 1u).x, T7.Load(fragment_unnamed_2245 + 2u).x, T7.Load(fragment_unnamed_2245 + 3u).x);
							uint fragment_unnamed_2265 = (fragment_unnamed_1765 * 56u) + 10u;
							uint4 fragment_unnamed_2277 = uint4(T7.Load(fragment_unnamed_2265).x, T7.Load(fragment_unnamed_2265 + 1u).x, T7.Load(fragment_unnamed_2265 + 2u).x, T7.Load(fragment_unnamed_2265 + 3u).x);
							float fragment_unnamed_2280 = asfloat(fragment_unnamed_2277.y);
							uint fragment_unnamed_2281 = fragment_unnamed_2277.z;
							float fragment_unnamed_2292 = ((-0.0f) - asfloat(fragment_unnamed_1965.x)) + fragment_input_6.x;
							float fragment_unnamed_2293 = ((-0.0f) - asfloat(fragment_unnamed_1965.y)) + fragment_input_6.y;
							float fragment_unnamed_2294 = ((-0.0f) - asfloat(fragment_unnamed_1965.z)) + fragment_input_6.z;
							bool fragment_unnamed_2295 = fragment_unnamed_2281 == 4u;
							float fragment_unnamed_2296 = asfloat(fragment_unnamed_2257.z);
							float fragment_unnamed_2297 = asfloat(fragment_unnamed_2257.w);
							float fragment_unnamed_2298 = asfloat(fragment_unnamed_2277.x);
							float fragment_unnamed_2305 = dot(float3((-0.0f) - fragment_unnamed_2292, (-0.0f) - fragment_unnamed_2293, (-0.0f) - fragment_unnamed_2294), float3((-0.0f) - fragment_unnamed_2292, (-0.0f) - fragment_unnamed_2293, (-0.0f) - fragment_unnamed_2294));
							float fragment_unnamed_2308 = rsqrt(fragment_unnamed_2305);
							float fragment_unnamed_2318 = fragment_unnamed_2295 ? ((-0.0f) - fragment_unnamed_2296) : (fragment_unnamed_2308 * ((-0.0f) - fragment_unnamed_2292));
							float fragment_unnamed_2319 = fragment_unnamed_2295 ? ((-0.0f) - fragment_unnamed_2297) : (fragment_unnamed_2308 * ((-0.0f) - fragment_unnamed_2293));
							float fragment_unnamed_2320 = fragment_unnamed_2295 ? ((-0.0f) - fragment_unnamed_2298) : (fragment_unnamed_2308 * ((-0.0f) - fragment_unnamed_2294));
							float fragment_unnamed_2323 = dot(float3(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880), float3(fragment_unnamed_2318, fragment_unnamed_2319, fragment_unnamed_2320));
							float fragment_unnamed_3060;
							float fragment_unnamed_3062;
							float fragment_unnamed_3064;
							float fragment_unnamed_3066;
							float fragment_unnamed_3068;
							float fragment_unnamed_3070;
							if ((((0.0f < asfloat(T7.Load((fragment_unnamed_1765 * 56u) + 4u).x)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_2323) ? 4294967295u : 0u)) != 0u)
							{
								uint fragment_unnamed_2705 = (fragment_unnamed_1765 * 56u) + 14u;
								uint4 fragment_unnamed_2717 = uint4(T7.Load(fragment_unnamed_2705).x, T7.Load(fragment_unnamed_2705 + 1u).x, T7.Load(fragment_unnamed_2705 + 2u).x, T7.Load(fragment_unnamed_2705 + 3u).x);
								float fragment_unnamed_2721 = asfloat(fragment_unnamed_2717.z);
								float fragment_unnamed_2723 = asfloat(fragment_unnamed_2717.w);
								uint fragment_unnamed_2725 = (fragment_unnamed_1765 * 56u) + 18u;
								uint4 fragment_unnamed_2737 = uint4(T7.Load(fragment_unnamed_2725).x, T7.Load(fragment_unnamed_2725 + 1u).x, T7.Load(fragment_unnamed_2725 + 2u).x, T7.Load(fragment_unnamed_2725 + 3u).x);
								uint fragment_unnamed_2743 = fragment_unnamed_2737.y;
								uint fragment_unnamed_2745 = (fragment_unnamed_1765 * 56u) + 22u;
								uint4 fragment_unnamed_2757 = uint4(T7.Load(fragment_unnamed_2745).x, T7.Load(fragment_unnamed_2745 + 1u).x, T7.Load(fragment_unnamed_2745 + 2u).x, T7.Load(fragment_unnamed_2745 + 3u).x);
								uint fragment_unnamed_2760 = fragment_unnamed_2757.z;
								uint fragment_unnamed_2762 = fragment_unnamed_2757.w;
								uint fragment_unnamed_2766 = (fragment_unnamed_1765 * 56u) + 26u;
								uint4 fragment_unnamed_2778 = uint4(T7.Load(fragment_unnamed_2766).x, T7.Load(fragment_unnamed_2766 + 1u).x, T7.Load(fragment_unnamed_2766 + 2u).x, T7.Load(fragment_unnamed_2766 + 3u).x);
								float fragment_unnamed_2782 = asfloat(fragment_unnamed_2778.z);
								uint fragment_unnamed_2783 = fragment_unnamed_2778.x;
								float fragment_unnamed_2786 = asfloat(fragment_unnamed_2778.w);
								uint fragment_unnamed_2789 = (fragment_unnamed_1765 * 56u) + 30u;
								uint4 fragment_unnamed_2801 = uint4(T7.Load(fragment_unnamed_2789).x, T7.Load(fragment_unnamed_2789 + 1u).x, T7.Load(fragment_unnamed_2789 + 2u).x, T7.Load(fragment_unnamed_2789 + 3u).x);
								float fragment_unnamed_2803 = asfloat(fragment_unnamed_2801.x);
								float fragment_unnamed_2805 = asfloat(fragment_unnamed_2801.y);
								uint fragment_unnamed_2810 = (fragment_unnamed_1765 * 56u) + 34u;
								uint2 fragment_unnamed_2816 = uint2(T7.Load(fragment_unnamed_2810).x, T7.Load(fragment_unnamed_2810 + 1u).x);
								float fragment_unnamed_2818 = asfloat(fragment_unnamed_2816.x);
								float fragment_unnamed_2820 = asfloat(fragment_unnamed_2816.y);
								float fragment_unnamed_2826 = dot(float3(fragment_unnamed_2292, fragment_unnamed_2293, fragment_unnamed_2294), float3(fragment_unnamed_2296, fragment_unnamed_2297, fragment_unnamed_2298));
								uint fragment_unnamed_2838 = fragment_unnamed_2295 ? asuint(fragment_unnamed_2826) : asuint(fragment_unnamed_2308 * fragment_unnamed_2305);
								float fragment_unnamed_2839 = asfloat(fragment_unnamed_2838);
								float fragment_unnamed_2848 = asfloat(fragment_unnamed_2757.y) * asfloat(fragment_unnamed_2295 ? asuint(fragment_unnamed_2826 * fragment_unnamed_2826) : asuint(fragment_unnamed_2305));
								float fragment_unnamed_2855 = clamp(mad((1.0f / fragment_unnamed_2839) * fragment_unnamed_2826, asfloat(fragment_unnamed_2257.x), asfloat(fragment_unnamed_2257.y)), 0.0f, 1.0f) * (clamp(mad((-0.0f) - fragment_unnamed_2848, fragment_unnamed_2848, asfloat(fragment_unnamed_2778.y)), 0.0f, 1.0f) * min(asfloat(fragment_unnamed_2295 ? 1065353216u : asuint(rsqrt(asfloat(T7.Load((fragment_unnamed_1765 * 56u) + 44u).x) + fragment_unnamed_2305))), 100.0f));
								float fragment_unnamed_2862 = dot(float3(fragment_unnamed_2318, fragment_unnamed_2319, fragment_unnamed_2320), float3(fragment_uniform_buffer_0[83u].xyz));
								float fragment_unnamed_2866 = max(abs(fragment_unnamed_2862), 0.001000000047497451305389404296875f);
								float fragment_unnamed_2868 = 1.0f / fragment_unnamed_2866;
								float fragment_unnamed_2870 = min(fragment_unnamed_1561, mad(fragment_unnamed_2839, fragment_unnamed_2862, fragment_unnamed_1561));
								float fragment_unnamed_2884 = min(fragment_unnamed_2839, max(fragment_unnamed_2868 * (((-0.0f) - fragment_unnamed_2870) + fragment_uniform_buffer_0[89u].y), 0.0f));
								float fragment_unnamed_2917 = (fragment_unnamed_2855 * fragment_unnamed_2855) * exp2((mad((((-0.0f) - exp2(((fragment_unnamed_2866 * ((-0.0f) - (((-0.0f) - fragment_unnamed_2884) + fragment_unnamed_2839))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_2870 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_2868 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_2884) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
								float fragment_unnamed_3744;
								float fragment_unnamed_3746;
								float fragment_unnamed_3748;
								float fragment_unnamed_3750;
								if (fragment_unnamed_2737.x != 0u)
								{
									float fragment_unnamed_3050 = dot(float3(fragment_unnamed_2292, fragment_unnamed_2293, fragment_unnamed_2294), float3(asfloat(fragment_unnamed_2277.w), asfloat(fragment_unnamed_2717.x), asfloat(fragment_unnamed_2717.y)));
									float fragment_unnamed_3054 = dot(float3(fragment_unnamed_2292, fragment_unnamed_2293, fragment_unnamed_2294), float3(asfloat(fragment_unnamed_2737.z), asfloat(fragment_unnamed_2737.w), asfloat(fragment_unnamed_2757.x)));
									float fragment_unnamed_3980;
									float fragment_unnamed_3981;
									float fragment_unnamed_3982;
									float fragment_unnamed_3983;
									if (fragment_unnamed_2281 == 1u)
									{
										float fragment_unnamed_3601 = 1.0f / max(dot(float3(abs(fragment_unnamed_3050), abs(fragment_unnamed_3054), abs(fragment_unnamed_2826)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
										float fragment_unnamed_3606 = clamp((-0.0f) - (fragment_unnamed_3601 * fragment_unnamed_2826), 0.0f, 1.0f);
										float fragment_unnamed_3609 = (-0.0f) - fragment_unnamed_3606;
										float fragment_unnamed_3623 = 1.0f / (fragment_unnamed_2782 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3624 = 1.0f / (fragment_unnamed_2786 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3636 = fragment_unnamed_2782 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3637 = fragment_unnamed_2786 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3640 = fragment_unnamed_1572 / (fragment_unnamed_3636 + fragment_unnamed_3636);
										float fragment_unnamed_3641 = fragment_unnamed_1572 / (fragment_unnamed_3637 + fragment_unnamed_3637);
										float4 fragment_unnamed_3655 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_3640) + 1.0f, max(fragment_unnamed_3640, mad(clamp(mad(mad(fragment_unnamed_3050, fragment_unnamed_3601, ((fragment_unnamed_3601 * fragment_unnamed_3050) >= 0.0f) ? fragment_unnamed_3606 : fragment_unnamed_3609), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_2782 * fragment_unnamed_3623, mad((-0.0f) - fragment_unnamed_3623, fragment_unnamed_2782, 1.0f) * 0.5f))), fragment_unnamed_2782, fragment_unnamed_2803), mad(min(((-0.0f) - fragment_unnamed_3641) + 1.0f, max(fragment_unnamed_3641, mad(clamp(mad(mad(fragment_unnamed_3054, fragment_unnamed_3601, ((fragment_unnamed_3601 * fragment_unnamed_3054) >= 0.0f) ? fragment_unnamed_3606 : fragment_unnamed_3609), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_2786 * fragment_unnamed_3624, mad((-0.0f) - fragment_unnamed_3624, fragment_unnamed_2786, 1.0f) * 0.5f))), fragment_unnamed_2786, fragment_unnamed_2805)), 0.0f);
										fragment_unnamed_3980 = fragment_unnamed_3655.y;
										fragment_unnamed_3981 = fragment_unnamed_3655.x;
										fragment_unnamed_3982 = fragment_unnamed_3655.z;
										fragment_unnamed_3983 = asfloat(1065353216u);
									}
									else
									{
										bool fragment_unnamed_3667 = fragment_unnamed_2281 != 4u;
										float fragment_unnamed_3673 = asfloat(fragment_unnamed_3667 ? asuint(fragment_unnamed_2826) : 1065353216u);
										float fragment_unnamed_3674 = fragment_unnamed_3050 / fragment_unnamed_3673;
										float fragment_unnamed_3675 = fragment_unnamed_3054 / fragment_unnamed_3673;
										uint fragment_unnamed_3687 = (asfloat(T7.Load((fragment_unnamed_1765 * 56u) + 55u).x) >= max(mad((-0.0f) - fragment_unnamed_2723, 0.5f, abs(mad((-0.0f) - fragment_unnamed_2723, 0.5f, fragment_unnamed_2826))) + 1.0f, max(abs(fragment_unnamed_3675), abs(fragment_unnamed_3674)))) ? 4294967295u : 0u;
										float fragment_unnamed_3705 = 1.0f / (fragment_unnamed_2782 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3706 = 1.0f / (fragment_unnamed_2786 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3718 = fragment_unnamed_2782 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3719 = fragment_unnamed_2786 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3722 = fragment_unnamed_1572 / (fragment_unnamed_3718 + fragment_unnamed_3718);
										float fragment_unnamed_3723 = fragment_unnamed_1572 / (fragment_unnamed_3719 + fragment_unnamed_3719);
										float4 fragment_unnamed_3737 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_3722) + 1.0f, max(fragment_unnamed_3722, mad(mad(fragment_unnamed_3674, 0.5f, 0.5f), fragment_unnamed_2782 * fragment_unnamed_3705, mad((-0.0f) - fragment_unnamed_3705, fragment_unnamed_2782, 1.0f) * 0.5f))), fragment_unnamed_2782, fragment_unnamed_2803), mad(min(((-0.0f) - fragment_unnamed_3723) + 1.0f, max(fragment_unnamed_3723, mad(mad(fragment_unnamed_3675, 0.5f, 0.5f), fragment_unnamed_2786 * fragment_unnamed_3706, mad((-0.0f) - fragment_unnamed_3706, fragment_unnamed_2786, 1.0f) * 0.5f))), fragment_unnamed_2786, fragment_unnamed_2805)), 0.0f);
										fragment_unnamed_3980 = fragment_unnamed_3737.y;
										fragment_unnamed_3981 = fragment_unnamed_3737.x;
										fragment_unnamed_3982 = fragment_unnamed_3737.z;
										fragment_unnamed_3983 = asfloat(((((fragment_unnamed_3667 ? 4294967295u : 0u) & ((fragment_unnamed_2281 != 3u) ? 4294967295u : 0u)) != 0u) ? (fragment_unnamed_3687 & (((fragment_unnamed_2280 * fragment_unnamed_2280) >= dot(float2(fragment_unnamed_3674, fragment_unnamed_3675), float2(fragment_unnamed_3674, fragment_unnamed_3675))) ? 4294967295u : 0u)) : fragment_unnamed_3687) & 1065353216u);
									}
									fragment_unnamed_3744 = fragment_unnamed_3983 * fragment_unnamed_2917;
									fragment_unnamed_3746 = fragment_unnamed_3981 * asfloat(fragment_unnamed_2760);
									fragment_unnamed_3748 = fragment_unnamed_3980 * asfloat(fragment_unnamed_2762);
									fragment_unnamed_3750 = fragment_unnamed_3982 * asfloat(fragment_unnamed_2783);
								}
								else
								{
									fragment_unnamed_3744 = fragment_unnamed_2917;
									fragment_unnamed_3746 = asfloat(fragment_unnamed_2760);
									fragment_unnamed_3748 = asfloat(fragment_unnamed_2762);
									fragment_unnamed_3750 = asfloat(fragment_unnamed_2783);
								}
								float fragment_unnamed_4766;
								if ((((int(fragment_unnamed_2743) >= int(0u)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_2820) ? 4294967295u : 0u)) != 0u)
								{
									bool fragment_unnamed_3986 = fragment_unnamed_2281 != 4u;
									uint fragment_unnamed_3987 = fragment_unnamed_3986 ? 4294967295u : 0u;
									float fragment_unnamed_3993 = asfloat((dot(float3(fragment_unnamed_250, fragment_unnamed_251, fragment_unnamed_252), float3(fragment_unnamed_2318, fragment_unnamed_2319, fragment_unnamed_2320)) >= 0.0f) ? 1065353216u : 3212836864u);
									float fragment_unnamed_3994 = fragment_unnamed_250 * fragment_unnamed_3993;
									float fragment_unnamed_3995 = fragment_unnamed_251 * fragment_unnamed_3993;
									float fragment_unnamed_3996 = fragment_unnamed_252 * fragment_unnamed_3993;
									uint fragment_unnamed_3998 = (fragment_unnamed_2743 * 60u) + 8u;
									uint4 fragment_unnamed_4010 = uint4(T31.Load(fragment_unnamed_3998).x, T31.Load(fragment_unnamed_3998 + 1u).x, T31.Load(fragment_unnamed_3998 + 2u).x, T31.Load(fragment_unnamed_3998 + 3u).x);
									uint fragment_unnamed_4012 = fragment_unnamed_4010.y;
									float fragment_unnamed_4013 = asfloat(fragment_unnamed_4012);
									uint fragment_unnamed_4014 = fragment_unnamed_4010.z;
									float fragment_unnamed_4015 = asfloat(fragment_unnamed_4014);
									uint fragment_unnamed_4016 = fragment_unnamed_4010.w;
									float fragment_unnamed_4017 = asfloat(fragment_unnamed_4016);
									uint fragment_unnamed_4019 = (fragment_unnamed_2743 * 60u) + 12u;
									uint4 fragment_unnamed_4031 = uint4(T31.Load(fragment_unnamed_4019).x, T31.Load(fragment_unnamed_4019 + 1u).x, T31.Load(fragment_unnamed_4019 + 2u).x, T31.Load(fragment_unnamed_4019 + 3u).x);
									float fragment_unnamed_4033 = asfloat(fragment_unnamed_4031.x);
									float fragment_unnamed_4035 = asfloat(fragment_unnamed_4031.y);
									float fragment_unnamed_4037 = asfloat(fragment_unnamed_4031.z);
									float fragment_unnamed_4039 = asfloat(fragment_unnamed_4031.w);
									uint fragment_unnamed_4041 = (fragment_unnamed_2743 * 60u) + 16u;
									uint4 fragment_unnamed_4053 = uint4(T31.Load(fragment_unnamed_4041).x, T31.Load(fragment_unnamed_4041 + 1u).x, T31.Load(fragment_unnamed_4041 + 2u).x, T31.Load(fragment_unnamed_4041 + 3u).x);
									float fragment_unnamed_4059 = asfloat(fragment_unnamed_4053.z);
									float fragment_unnamed_4061 = asfloat(fragment_unnamed_4053.w);
									uint fragment_unnamed_4063 = (fragment_unnamed_2743 * 60u) + 24u;
									uint2 fragment_unnamed_4069 = uint2(T31.Load(fragment_unnamed_4063).x, T31.Load(fragment_unnamed_4063 + 1u).x);
									float fragment_unnamed_4071 = asfloat(fragment_unnamed_4069.x);
									float fragment_unnamed_4073 = asfloat(fragment_unnamed_4069.y);
									uint fragment_unnamed_4075 = (fragment_unnamed_2743 * 60u) + 40u;
									uint4 fragment_unnamed_4087 = uint4(T31.Load(fragment_unnamed_4075).x, T31.Load(fragment_unnamed_4075 + 1u).x, T31.Load(fragment_unnamed_4075 + 2u).x, T31.Load(fragment_unnamed_4075 + 3u).x);
									float fragment_unnamed_4089 = asfloat(fragment_unnamed_4087.x);
									float fragment_unnamed_4091 = asfloat(fragment_unnamed_4087.y);
									float fragment_unnamed_4093 = asfloat(fragment_unnamed_4087.z);
									float fragment_unnamed_4095 = asfloat(fragment_unnamed_4087.w);
									float fragment_unnamed_5170;
									float fragment_unnamed_5171;
									float fragment_unnamed_5172;
									float fragment_unnamed_5173;
									float fragment_unnamed_5174;
									float fragment_unnamed_5175;
									float fragment_unnamed_5176;
									float fragment_unnamed_5177;
									float fragment_unnamed_5178;
									float fragment_unnamed_5179;
									float fragment_unnamed_5180;
									if (fragment_unnamed_2281 == 1u)
									{
										float fragment_unnamed_4630 = abs(fragment_unnamed_2320);
										float fragment_unnamed_4632 = abs(fragment_unnamed_2318);
										uint fragment_unnamed_4659 = uint(float(int(fragment_unnamed_2743)) + asfloat(((((fragment_unnamed_4630 >= abs(fragment_unnamed_2319)) ? 4294967295u : 0u) & ((fragment_unnamed_4630 >= fragment_unnamed_4632) ? 4294967295u : 0u)) != 0u) ? ((((-0.0f) - fragment_unnamed_2320) < 0.0f) ? 1084227584u : 1082130432u) : ((abs(fragment_unnamed_2319) >= fragment_unnamed_4632) ? ((((-0.0f) - fragment_unnamed_2319) < 0.0f) ? 1077936128u : 1073741824u) : (((((-0.0f) - fragment_unnamed_2318) < 0.0f) ? 4294967295u : 0u) & 1065353216u))));
										uint fragment_unnamed_4660 = fragment_unnamed_4659 * 60u;
										uint3 fragment_unnamed_4669 = uint3(T31.Load(fragment_unnamed_4660).x, T31.Load(fragment_unnamed_4660 + 1u).x, T31.Load(fragment_unnamed_4660 + 2u).x);
										uint fragment_unnamed_4677 = (fragment_unnamed_4659 * 60u) + 3u;
										uint3 fragment_unnamed_4686 = uint3(T31.Load(fragment_unnamed_4677).x, T31.Load(fragment_unnamed_4677 + 1u).x, T31.Load(fragment_unnamed_4677 + 2u).x);
										uint fragment_unnamed_4694 = (fragment_unnamed_4659 * 60u) + 6u;
										uint3 fragment_unnamed_4703 = uint3(T31.Load(fragment_unnamed_4694).x, T31.Load(fragment_unnamed_4694 + 1u).x, T31.Load(fragment_unnamed_4694 + 2u).x);
										uint fragment_unnamed_4711 = (fragment_unnamed_4659 * 60u) + 16u;
										uint2 fragment_unnamed_4717 = uint2(T31.Load(fragment_unnamed_4711).x, T31.Load(fragment_unnamed_4711 + 1u).x);
										fragment_unnamed_5170 = asfloat(fragment_unnamed_4717.y);
										fragment_unnamed_5171 = asfloat(fragment_unnamed_4669.x);
										fragment_unnamed_5172 = asfloat(fragment_unnamed_4669.y);
										fragment_unnamed_5173 = asfloat(fragment_unnamed_4669.z);
										fragment_unnamed_5174 = asfloat(fragment_unnamed_4717.x);
										fragment_unnamed_5175 = asfloat(fragment_unnamed_4686.x);
										fragment_unnamed_5176 = asfloat(fragment_unnamed_4686.y);
										fragment_unnamed_5177 = asfloat(fragment_unnamed_4686.z);
										fragment_unnamed_5178 = asfloat(fragment_unnamed_4703.x);
										fragment_unnamed_5179 = asfloat(fragment_unnamed_4703.y);
										fragment_unnamed_5180 = asfloat(fragment_unnamed_4703.z);
									}
									else
									{
										uint fragment_unnamed_4722 = fragment_unnamed_2743 * 60u;
										uint4 fragment_unnamed_4734 = uint4(T31.Load(fragment_unnamed_4722).x, T31.Load(fragment_unnamed_4722 + 1u).x, T31.Load(fragment_unnamed_4722 + 2u).x, T31.Load(fragment_unnamed_4722 + 3u).x);
										uint fragment_unnamed_4741 = (fragment_unnamed_2743 * 60u) + 4u;
										uint4 fragment_unnamed_4753 = uint4(T31.Load(fragment_unnamed_4741).x, T31.Load(fragment_unnamed_4741 + 1u).x, T31.Load(fragment_unnamed_4741 + 2u).x, T31.Load(fragment_unnamed_4741 + 3u).x);
										fragment_unnamed_5170 = asfloat(fragment_unnamed_4053.y);
										fragment_unnamed_5171 = asfloat(fragment_unnamed_4734.x);
										fragment_unnamed_5172 = asfloat(fragment_unnamed_4734.y);
										fragment_unnamed_5173 = asfloat(fragment_unnamed_4734.z);
										fragment_unnamed_5174 = asfloat(fragment_unnamed_4053.x);
										fragment_unnamed_5175 = asfloat(fragment_unnamed_4734.w);
										fragment_unnamed_5176 = asfloat(fragment_unnamed_4753.x);
										fragment_unnamed_5177 = asfloat(fragment_unnamed_4753.y);
										fragment_unnamed_5178 = asfloat(fragment_unnamed_4753.z);
										fragment_unnamed_5179 = asfloat(fragment_unnamed_4753.w);
										fragment_unnamed_5180 = asfloat(fragment_unnamed_4010.x);
									}
									float fragment_unnamed_7981;
									if (0.0f < fragment_unnamed_4095)
									{
										bool fragment_unnamed_5820 = 0.0f != fragment_unnamed_4095;
										uint4 fragment_unnamed_5824 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_5830 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_5834 = asfloat(fragment_unnamed_5820 ? fragment_unnamed_5824.z : fragment_unnamed_5830.z);
										float fragment_unnamed_5836 = asfloat(fragment_unnamed_5820 ? fragment_unnamed_5824.w : fragment_unnamed_5830.w);
										float fragment_unnamed_5838 = asfloat(fragment_unnamed_3986 ? fragment_unnamed_2838 : 1065353216u);
										float fragment_unnamed_5854 = mad(fragment_unnamed_4059 * (fragment_unnamed_3994 * fragment_unnamed_4061), fragment_unnamed_5838, fragment_unnamed_4089 + fragment_input_6.x);
										float fragment_unnamed_5855 = mad(fragment_unnamed_4059 * (fragment_unnamed_3995 * fragment_unnamed_4061), fragment_unnamed_5838, fragment_unnamed_4091 + fragment_input_6.y);
										float fragment_unnamed_5856 = mad(fragment_unnamed_4059 * (fragment_unnamed_3996 * fragment_unnamed_4061), fragment_unnamed_5838, fragment_unnamed_4093 + fragment_input_6.z);
										float fragment_unnamed_5860 = ((-0.0f) - fragment_unnamed_4013) + fragment_unnamed_5854;
										float fragment_unnamed_5861 = ((-0.0f) - fragment_unnamed_4015) + fragment_unnamed_5855;
										float fragment_unnamed_5862 = ((-0.0f) - fragment_unnamed_4017) + fragment_unnamed_5856;
										float fragment_unnamed_5895 = asfloat(fragment_unnamed_3986 ? asuint(dot(float3(fragment_unnamed_5178, fragment_unnamed_5179, fragment_unnamed_5180), float3(fragment_unnamed_5860, fragment_unnamed_5861, fragment_unnamed_5862))) : asuint(dot(float4(fragment_unnamed_5178, fragment_unnamed_5179, fragment_unnamed_5180, asfloat(fragment_unnamed_4016)), float4(fragment_unnamed_5854, fragment_unnamed_5855, fragment_unnamed_5856, fragment_unnamed_1575))));
										float fragment_unnamed_5900 = asfloat(fragment_unnamed_3986 ? asuint(dot(float3(fragment_unnamed_5171, fragment_unnamed_5172, fragment_unnamed_5173), float3(fragment_unnamed_5860, fragment_unnamed_5861, fragment_unnamed_5862))) : asuint(dot(float4(fragment_unnamed_5171, fragment_unnamed_5172, fragment_unnamed_5173, asfloat(fragment_unnamed_4012)), float4(fragment_unnamed_5854, fragment_unnamed_5855, fragment_unnamed_5856, fragment_unnamed_1575)))) * fragment_unnamed_4033;
										float fragment_unnamed_5901 = asfloat(fragment_unnamed_3986 ? asuint(dot(float3(fragment_unnamed_5175, fragment_unnamed_5176, fragment_unnamed_5177), float3(fragment_unnamed_5860, fragment_unnamed_5861, fragment_unnamed_5862))) : asuint(dot(float4(fragment_unnamed_5175, fragment_unnamed_5176, fragment_unnamed_5177, asfloat(fragment_unnamed_4014)), float4(fragment_unnamed_5854, fragment_unnamed_5855, fragment_unnamed_5856, fragment_unnamed_1575)))) * fragment_unnamed_4035;
										float fragment_unnamed_5902 = dot(float2(fragment_unnamed_4037, fragment_unnamed_4039), float2(fragment_unnamed_5895, fragment_unnamed_1576));
										float fragment_unnamed_5905 = dot(float2(asfloat(fragment_unnamed_3986 ? 3212836864u : 0u), asfloat(fragment_unnamed_3986 ? 0u : 1065353216u)), float2(fragment_unnamed_5895, fragment_unnamed_1576));
										bool fragment_unnamed_5914 = (fragment_unnamed_3987 & ((fragment_unnamed_5905 != 0.0f) ? 4294967295u : 0u)) != 0u;
										float fragment_unnamed_5933 = mad(fragment_unnamed_4071 * clamp(mad(asfloat(fragment_unnamed_5914 ? asuint(fragment_unnamed_5900 / fragment_unnamed_5905) : asuint(fragment_unnamed_5900)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5834, fragment_unnamed_5174);
										float fragment_unnamed_5934 = mad(fragment_unnamed_4073 * clamp(mad(asfloat(fragment_unnamed_5914 ? asuint(fragment_unnamed_5901 / fragment_unnamed_5905) : asuint(fragment_unnamed_5901)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5836, fragment_unnamed_5170);
										uint4 fragment_unnamed_5954 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_5961 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_5967 = asfloat(fragment_unnamed_5820 ? fragment_unnamed_5954.z : fragment_unnamed_5961.z);
										float fragment_unnamed_5969 = asfloat(fragment_unnamed_5820 ? fragment_unnamed_5954.w : fragment_unnamed_5961.w);
										float fragment_unnamed_5971 = asfloat(fragment_unnamed_5820 ? fragment_unnamed_5954.x : fragment_unnamed_5961.x);
										uint fragment_unnamed_5972 = fragment_unnamed_5820 ? fragment_unnamed_5954.y : fragment_unnamed_5961.y;
										float fragment_unnamed_5973 = asfloat(fragment_unnamed_5914 ? asuint(fragment_unnamed_5902 / fragment_unnamed_5905) : asuint(fragment_unnamed_5902)) + 1.52587890625e-05f;
										float fragment_unnamed_5977 = floor(mad(fragment_unnamed_5933, fragment_unnamed_5971, 0.5f));
										float fragment_unnamed_5978 = floor(mad(fragment_unnamed_5934, asfloat(fragment_unnamed_5972), 0.5f));
										float fragment_unnamed_5982 = mad(fragment_unnamed_5933, fragment_unnamed_5971, (-0.0f) - fragment_unnamed_5977);
										float fragment_unnamed_5983 = mad(fragment_unnamed_5934, asfloat(fragment_unnamed_5972), (-0.0f) - fragment_unnamed_5978);
										float fragment_unnamed_5984 = fragment_unnamed_5982 + 0.5f;
										float fragment_unnamed_5985 = fragment_unnamed_5982 + 1.0f;
										float fragment_unnamed_5986 = fragment_unnamed_5983 + 0.5f;
										float fragment_unnamed_5987 = fragment_unnamed_5983 + 1.0f;
										float fragment_unnamed_5992 = (fragment_unnamed_5984 * fragment_unnamed_5984) * 0.07999999821186065673828125f;
										float fragment_unnamed_5994 = (fragment_unnamed_5986 * fragment_unnamed_5986) * 0.07999999821186065673828125f;
										float fragment_unnamed_6001 = ((-0.0f) - fragment_unnamed_5982) + 1.0f;
										float fragment_unnamed_6002 = ((-0.0f) - fragment_unnamed_5983) + 1.0f;
										float fragment_unnamed_6003 = min(fragment_unnamed_5982, 0.0f);
										float fragment_unnamed_6004 = min(fragment_unnamed_5983, 0.0f);
										float fragment_unnamed_6009 = max(fragment_unnamed_5982, 0.0f);
										float fragment_unnamed_6010 = max(fragment_unnamed_5983, 0.0f);
										float fragment_unnamed_6022 = fragment_unnamed_6001 * 0.1599999964237213134765625f;
										float fragment_unnamed_6023 = fragment_unnamed_6002 * 0.1599999964237213134765625f;
										float fragment_unnamed_6024 = (mad((-0.0f) - fragment_unnamed_6003, fragment_unnamed_6003, fragment_unnamed_6001) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6026 = (mad((-0.0f) - fragment_unnamed_6009, fragment_unnamed_6009, fragment_unnamed_5985) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6027 = (mad((-0.0f) - fragment_unnamed_6010, fragment_unnamed_6010, fragment_unnamed_5987) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6031 = (fragment_unnamed_5985 * 0.1599999964237213134765625f) + fragment_unnamed_5992;
										float fragment_unnamed_6032 = (mad(fragment_unnamed_5984 * fragment_unnamed_5984, 0.5f, (-0.0f) - fragment_unnamed_5982) * 0.1599999964237213134765625f) + fragment_unnamed_6022;
										float fragment_unnamed_6033 = fragment_unnamed_6024 + fragment_unnamed_6026;
										float fragment_unnamed_6034 = (mad(fragment_unnamed_5986 * fragment_unnamed_5986, 0.5f, (-0.0f) - fragment_unnamed_5983) * 0.1599999964237213134765625f) + fragment_unnamed_6023;
										float fragment_unnamed_6035 = ((mad((-0.0f) - fragment_unnamed_6004, fragment_unnamed_6004, fragment_unnamed_6002) + 1.0f) * 0.1599999964237213134765625f) + fragment_unnamed_6027;
										float fragment_unnamed_6036 = (fragment_unnamed_5987 * 0.1599999964237213134765625f) + fragment_unnamed_5994;
										float fragment_unnamed_6049 = fragment_unnamed_5967 * ((fragment_unnamed_6026 / fragment_unnamed_6033) + (-0.5f));
										float fragment_unnamed_6050 = fragment_unnamed_5967 * ((fragment_unnamed_6022 / fragment_unnamed_6032) + (-2.5f));
										float fragment_unnamed_6051 = fragment_unnamed_5967 * ((fragment_unnamed_5992 / fragment_unnamed_6031) + 1.5f);
										float fragment_unnamed_6052 = fragment_unnamed_5969 * ((fragment_unnamed_6023 / fragment_unnamed_6034) + (-2.5f));
										float fragment_unnamed_6053 = fragment_unnamed_5969 * ((fragment_unnamed_6027 / fragment_unnamed_6035) + (-0.5f));
										float fragment_unnamed_6054 = fragment_unnamed_5969 * ((fragment_unnamed_5994 / fragment_unnamed_6036) + 1.5f);
										float fragment_unnamed_6073 = fragment_unnamed_6034 * fragment_unnamed_6032;
										float fragment_unnamed_6074 = fragment_unnamed_6034 * fragment_unnamed_6033;
										float fragment_unnamed_6075 = fragment_unnamed_6034 * fragment_unnamed_6031;
										float fragment_unnamed_6076 = fragment_unnamed_6035 * fragment_unnamed_6032;
										float fragment_unnamed_6077 = fragment_unnamed_6035 * (fragment_unnamed_6024 + fragment_unnamed_6026);
										float fragment_unnamed_6078 = fragment_unnamed_6035 * fragment_unnamed_6031;
										float fragment_unnamed_6079 = fragment_unnamed_6036 * fragment_unnamed_6032;
										float fragment_unnamed_6080 = fragment_unnamed_6036 * fragment_unnamed_6033;
										float4 fragment_unnamed_6085 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5977, fragment_unnamed_5967, fragment_unnamed_6050), mad(fragment_unnamed_5978, fragment_unnamed_5969, fragment_unnamed_6052)), fragment_unnamed_5973).xxxx;
										float fragment_unnamed_6086 = fragment_unnamed_6085.x;
										float4 fragment_unnamed_6089 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5977, fragment_unnamed_5967, fragment_unnamed_6049), mad(fragment_unnamed_5978, fragment_unnamed_5969, fragment_unnamed_6052)), fragment_unnamed_5973).xxxx;
										float fragment_unnamed_6090 = fragment_unnamed_6089.x;
										float4 fragment_unnamed_6093 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5977, fragment_unnamed_5967, fragment_unnamed_6051), mad(fragment_unnamed_5978, fragment_unnamed_5969, fragment_unnamed_6052)), fragment_unnamed_5973).xxxx;
										float fragment_unnamed_6094 = fragment_unnamed_6093.x;
										float4 fragment_unnamed_6097 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5977, fragment_unnamed_5967, fragment_unnamed_6050), mad(fragment_unnamed_5978, fragment_unnamed_5969, fragment_unnamed_6053)), fragment_unnamed_5973).xxxx;
										float fragment_unnamed_6098 = fragment_unnamed_6097.x;
										float fragment_unnamed_6100 = asfloat(0u);
										float fragment_unnamed_6521;
										fragment_unnamed_6521 = asfloat(0u);
										for (float fragment_unnamed_6523 = fragment_unnamed_6100; !(int(asuint(fragment_unnamed_6523)) >= int(1u)); fragment_unnamed_6521 = mad(fragment_unnamed_6076, fragment_unnamed_6098, mad(fragment_unnamed_6075, fragment_unnamed_6094, mad(fragment_unnamed_6074, fragment_unnamed_6090, mad(fragment_unnamed_6073, fragment_unnamed_6086, fragment_unnamed_6521)))), fragment_unnamed_6523 = asfloat(asuint(fragment_unnamed_6523) + 1u))
										{
										}
										float4 fragment_unnamed_6957 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5977, fragment_unnamed_5967, fragment_unnamed_6049), mad(fragment_unnamed_5978, fragment_unnamed_5969, fragment_unnamed_6053)), fragment_unnamed_5973).xxxx;
										float fragment_unnamed_6958 = fragment_unnamed_6957.x;
										float4 fragment_unnamed_6961 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5977, fragment_unnamed_5967, fragment_unnamed_6051), mad(fragment_unnamed_5978, fragment_unnamed_5969, fragment_unnamed_6053)), fragment_unnamed_5973).xxxx;
										float fragment_unnamed_6962 = fragment_unnamed_6961.x;
										float4 fragment_unnamed_6965 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5977, fragment_unnamed_5967, fragment_unnamed_6050), mad(fragment_unnamed_5978, fragment_unnamed_5969, fragment_unnamed_6054)), fragment_unnamed_5973).xxxx;
										float fragment_unnamed_6966 = fragment_unnamed_6965.x;
										float4 fragment_unnamed_6969 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5977, fragment_unnamed_5967, fragment_unnamed_6049), mad(fragment_unnamed_5978, fragment_unnamed_5969, fragment_unnamed_6054)), fragment_unnamed_5973).xxxx;
										float fragment_unnamed_6970 = fragment_unnamed_6969.x;
										float fragment_unnamed_6971 = asfloat(0u);
										float fragment_unnamed_7419;
										fragment_unnamed_7419 = fragment_unnamed_6521;
										float fragment_unnamed_7420;
										for (float fragment_unnamed_7421 = fragment_unnamed_6971; !(int(asuint(fragment_unnamed_7421)) >= int(1u)); fragment_unnamed_7420 = mad(fragment_unnamed_6080, fragment_unnamed_6970, mad(fragment_unnamed_6079, fragment_unnamed_6966, mad(fragment_unnamed_6078, fragment_unnamed_6962, mad(fragment_unnamed_6077, fragment_unnamed_6958, fragment_unnamed_7419)))), fragment_unnamed_7419 = fragment_unnamed_7420, fragment_unnamed_7421 = asfloat(asuint(fragment_unnamed_7421) + 1u))
										{
										}
										fragment_unnamed_7981 = asfloat((((((fragment_unnamed_5934 < (fragment_unnamed_5836 + fragment_unnamed_5170)) ? 4294967295u : 0u) | ((fragment_unnamed_5933 < (fragment_unnamed_5834 + fragment_unnamed_5174)) ? 4294967295u : 0u)) | (((mad(fragment_unnamed_4073 + (-0.5f), fragment_unnamed_5836, fragment_unnamed_5170) < fragment_unnamed_5934) ? 4294967295u : 0u) | ((mad(fragment_unnamed_4071 + (-0.5f), fragment_unnamed_5834, fragment_unnamed_5174) < fragment_unnamed_5933) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(mad(fragment_unnamed_6036 * fragment_unnamed_6031, _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5977, fragment_unnamed_5967, fragment_unnamed_6051), mad(fragment_unnamed_5978, fragment_unnamed_5969, fragment_unnamed_6054)), fragment_unnamed_5973).xxxx.x, fragment_unnamed_7419)));
									}
									else
									{
										bool fragment_unnamed_6101 = 0.0f != fragment_unnamed_4095;
										uint4 fragment_unnamed_6104 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_6109 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_6113 = asfloat(fragment_unnamed_6101 ? fragment_unnamed_6104.z : fragment_unnamed_6109.z);
										float fragment_unnamed_6115 = asfloat(fragment_unnamed_6101 ? fragment_unnamed_6104.w : fragment_unnamed_6109.w);
										float fragment_unnamed_6117 = asfloat(fragment_unnamed_3986 ? fragment_unnamed_2838 : 1065353216u);
										float fragment_unnamed_6133 = mad(fragment_unnamed_4059 * (fragment_unnamed_3994 * fragment_unnamed_4061), fragment_unnamed_6117, fragment_unnamed_4089 + fragment_input_6.x);
										float fragment_unnamed_6134 = mad(fragment_unnamed_4059 * (fragment_unnamed_3995 * fragment_unnamed_4061), fragment_unnamed_6117, fragment_unnamed_4091 + fragment_input_6.y);
										float fragment_unnamed_6135 = mad(fragment_unnamed_4059 * (fragment_unnamed_3996 * fragment_unnamed_4061), fragment_unnamed_6117, fragment_unnamed_4093 + fragment_input_6.z);
										float fragment_unnamed_6139 = ((-0.0f) - fragment_unnamed_4013) + fragment_unnamed_6133;
										float fragment_unnamed_6140 = ((-0.0f) - fragment_unnamed_4015) + fragment_unnamed_6134;
										float fragment_unnamed_6141 = ((-0.0f) - fragment_unnamed_4017) + fragment_unnamed_6135;
										float fragment_unnamed_6173 = asfloat(fragment_unnamed_3986 ? asuint(dot(float3(fragment_unnamed_5178, fragment_unnamed_5179, fragment_unnamed_5180), float3(fragment_unnamed_6139, fragment_unnamed_6140, fragment_unnamed_6141))) : asuint(dot(float4(fragment_unnamed_5178, fragment_unnamed_5179, fragment_unnamed_5180, fragment_unnamed_4017), float4(fragment_unnamed_6133, fragment_unnamed_6134, fragment_unnamed_6135, fragment_unnamed_1577))));
										float fragment_unnamed_6178 = asfloat(fragment_unnamed_3986 ? asuint(dot(float3(fragment_unnamed_5171, fragment_unnamed_5172, fragment_unnamed_5173), float3(fragment_unnamed_6139, fragment_unnamed_6140, fragment_unnamed_6141))) : asuint(dot(float4(fragment_unnamed_5171, fragment_unnamed_5172, fragment_unnamed_5173, asfloat(fragment_unnamed_4012)), float4(fragment_unnamed_6133, fragment_unnamed_6134, fragment_unnamed_6135, fragment_unnamed_1577)))) * fragment_unnamed_4033;
										float fragment_unnamed_6179 = asfloat(fragment_unnamed_3986 ? asuint(dot(float3(fragment_unnamed_5175, fragment_unnamed_5176, fragment_unnamed_5177), float3(fragment_unnamed_6139, fragment_unnamed_6140, fragment_unnamed_6141))) : asuint(dot(float4(fragment_unnamed_5175, fragment_unnamed_5176, fragment_unnamed_5177, asfloat(fragment_unnamed_4014)), float4(fragment_unnamed_6133, fragment_unnamed_6134, fragment_unnamed_6135, fragment_unnamed_1577)))) * fragment_unnamed_4035;
										float fragment_unnamed_6180 = dot(float2(fragment_unnamed_4037, fragment_unnamed_4039), float2(fragment_unnamed_6173, fragment_unnamed_1578));
										float fragment_unnamed_6183 = dot(float2(asfloat(fragment_unnamed_3986 ? 3212836864u : 0u), asfloat(fragment_unnamed_3986 ? 0u : 1065353216u)), float2(fragment_unnamed_6173, fragment_unnamed_1578));
										bool fragment_unnamed_6192 = (fragment_unnamed_3987 & ((fragment_unnamed_6183 != 0.0f) ? 4294967295u : 0u)) != 0u;
										float fragment_unnamed_6211 = mad(fragment_unnamed_4071 * clamp(mad(asfloat(fragment_unnamed_6192 ? asuint(fragment_unnamed_6178 / fragment_unnamed_6183) : asuint(fragment_unnamed_6178)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6113, fragment_unnamed_5174);
										float fragment_unnamed_6212 = mad(fragment_unnamed_4073 * clamp(mad(asfloat(fragment_unnamed_6192 ? asuint(fragment_unnamed_6179 / fragment_unnamed_6183) : asuint(fragment_unnamed_6179)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6115, fragment_unnamed_5170);
										uint4 fragment_unnamed_6232 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_6239 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_6245 = asfloat(fragment_unnamed_6101 ? fragment_unnamed_6232.z : fragment_unnamed_6239.z);
										float fragment_unnamed_6247 = asfloat(fragment_unnamed_6101 ? fragment_unnamed_6232.w : fragment_unnamed_6239.w);
										float fragment_unnamed_6249 = asfloat(fragment_unnamed_6101 ? fragment_unnamed_6232.x : fragment_unnamed_6239.x);
										float fragment_unnamed_6251 = asfloat(fragment_unnamed_6101 ? fragment_unnamed_6232.y : fragment_unnamed_6239.y);
										float fragment_unnamed_6252 = asfloat(fragment_unnamed_6192 ? asuint(fragment_unnamed_6180 / fragment_unnamed_6183) : asuint(fragment_unnamed_6180)) + 1.52587890625e-05f;
										float fragment_unnamed_6255 = floor(mad(fragment_unnamed_6211, fragment_unnamed_6249, 0.5f));
										float fragment_unnamed_6256 = floor(mad(fragment_unnamed_6212, fragment_unnamed_6251, 0.5f));
										float fragment_unnamed_6259 = mad(fragment_unnamed_6211, fragment_unnamed_6249, (-0.0f) - fragment_unnamed_6255);
										float fragment_unnamed_6260 = mad(fragment_unnamed_6212, fragment_unnamed_6251, (-0.0f) - fragment_unnamed_6256);
										float fragment_unnamed_6261 = fragment_unnamed_6259 + 0.5f;
										float fragment_unnamed_6262 = fragment_unnamed_6259 + 1.0f;
										float fragment_unnamed_6263 = fragment_unnamed_6260 + 0.5f;
										float fragment_unnamed_6264 = fragment_unnamed_6260 + 1.0f;
										float fragment_unnamed_6269 = (fragment_unnamed_6261 * fragment_unnamed_6261) * 0.07999999821186065673828125f;
										float fragment_unnamed_6270 = (fragment_unnamed_6263 * fragment_unnamed_6263) * 0.07999999821186065673828125f;
										float fragment_unnamed_6277 = ((-0.0f) - fragment_unnamed_6259) + 1.0f;
										float fragment_unnamed_6278 = ((-0.0f) - fragment_unnamed_6260) + 1.0f;
										float fragment_unnamed_6279 = min(fragment_unnamed_6259, 0.0f);
										float fragment_unnamed_6280 = min(fragment_unnamed_6260, 0.0f);
										float fragment_unnamed_6285 = max(fragment_unnamed_6259, 0.0f);
										float fragment_unnamed_6286 = max(fragment_unnamed_6260, 0.0f);
										float fragment_unnamed_6297 = fragment_unnamed_6277 * 0.1599999964237213134765625f;
										float fragment_unnamed_6298 = fragment_unnamed_6278 * 0.1599999964237213134765625f;
										float fragment_unnamed_6299 = (mad((-0.0f) - fragment_unnamed_6279, fragment_unnamed_6279, fragment_unnamed_6277) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6301 = (mad((-0.0f) - fragment_unnamed_6285, fragment_unnamed_6285, fragment_unnamed_6262) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6302 = (mad((-0.0f) - fragment_unnamed_6286, fragment_unnamed_6286, fragment_unnamed_6264) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6306 = (fragment_unnamed_6262 * 0.1599999964237213134765625f) + fragment_unnamed_6269;
										float fragment_unnamed_6307 = (mad(fragment_unnamed_6261 * fragment_unnamed_6261, 0.5f, (-0.0f) - fragment_unnamed_6259) * 0.1599999964237213134765625f) + fragment_unnamed_6297;
										float fragment_unnamed_6308 = fragment_unnamed_6299 + fragment_unnamed_6301;
										float fragment_unnamed_6309 = (mad(fragment_unnamed_6263 * fragment_unnamed_6263, 0.5f, (-0.0f) - fragment_unnamed_6260) * 0.1599999964237213134765625f) + fragment_unnamed_6298;
										float fragment_unnamed_6310 = ((mad((-0.0f) - fragment_unnamed_6280, fragment_unnamed_6280, fragment_unnamed_6278) + 1.0f) * 0.1599999964237213134765625f) + fragment_unnamed_6302;
										float fragment_unnamed_6311 = (fragment_unnamed_6264 * 0.1599999964237213134765625f) + fragment_unnamed_6270;
										float fragment_unnamed_6324 = fragment_unnamed_6245 * ((fragment_unnamed_6301 / fragment_unnamed_6308) + (-0.5f));
										float fragment_unnamed_6325 = fragment_unnamed_6245 * ((fragment_unnamed_6297 / fragment_unnamed_6307) + (-2.5f));
										float fragment_unnamed_6326 = fragment_unnamed_6245 * ((fragment_unnamed_6269 / fragment_unnamed_6306) + 1.5f);
										float fragment_unnamed_6327 = fragment_unnamed_6247 * ((fragment_unnamed_6298 / fragment_unnamed_6309) + (-2.5f));
										float fragment_unnamed_6328 = fragment_unnamed_6247 * ((fragment_unnamed_6302 / fragment_unnamed_6310) + (-0.5f));
										float fragment_unnamed_6329 = fragment_unnamed_6247 * ((fragment_unnamed_6270 / fragment_unnamed_6311) + 1.5f);
										float fragment_unnamed_6348 = fragment_unnamed_6309 * fragment_unnamed_6307;
										float fragment_unnamed_6349 = fragment_unnamed_6309 * fragment_unnamed_6308;
										float fragment_unnamed_6350 = fragment_unnamed_6309 * fragment_unnamed_6306;
										float fragment_unnamed_6351 = fragment_unnamed_6310 * fragment_unnamed_6307;
										float fragment_unnamed_6352 = fragment_unnamed_6310 * (fragment_unnamed_6299 + fragment_unnamed_6301);
										float fragment_unnamed_6353 = fragment_unnamed_6310 * fragment_unnamed_6306;
										float fragment_unnamed_6354 = fragment_unnamed_6311 * fragment_unnamed_6307;
										float fragment_unnamed_6355 = fragment_unnamed_6311 * fragment_unnamed_6308;
										float4 fragment_unnamed_6360 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6255, fragment_unnamed_6245, fragment_unnamed_6325), mad(fragment_unnamed_6256, fragment_unnamed_6247, fragment_unnamed_6327)), fragment_unnamed_6252).xxxx;
										float fragment_unnamed_6361 = fragment_unnamed_6360.x;
										float4 fragment_unnamed_6364 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6255, fragment_unnamed_6245, fragment_unnamed_6324), mad(fragment_unnamed_6256, fragment_unnamed_6247, fragment_unnamed_6327)), fragment_unnamed_6252).xxxx;
										float fragment_unnamed_6365 = fragment_unnamed_6364.x;
										float4 fragment_unnamed_6368 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6255, fragment_unnamed_6245, fragment_unnamed_6326), mad(fragment_unnamed_6256, fragment_unnamed_6247, fragment_unnamed_6327)), fragment_unnamed_6252).xxxx;
										float fragment_unnamed_6369 = fragment_unnamed_6368.x;
										float4 fragment_unnamed_6372 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6255, fragment_unnamed_6245, fragment_unnamed_6325), mad(fragment_unnamed_6256, fragment_unnamed_6247, fragment_unnamed_6328)), fragment_unnamed_6252).xxxx;
										float fragment_unnamed_6373 = fragment_unnamed_6372.x;
										float fragment_unnamed_6375 = asfloat(0u);
										float fragment_unnamed_6527;
										fragment_unnamed_6527 = asfloat(0u);
										for (float fragment_unnamed_6529 = fragment_unnamed_6375; !(int(asuint(fragment_unnamed_6529)) >= int(1u)); fragment_unnamed_6527 = mad(fragment_unnamed_6351, fragment_unnamed_6373, mad(fragment_unnamed_6350, fragment_unnamed_6369, mad(fragment_unnamed_6349, fragment_unnamed_6365, mad(fragment_unnamed_6348, fragment_unnamed_6361, fragment_unnamed_6527)))), fragment_unnamed_6529 = asfloat(asuint(fragment_unnamed_6529) + 1u))
										{
										}
										float4 fragment_unnamed_6980 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6255, fragment_unnamed_6245, fragment_unnamed_6324), mad(fragment_unnamed_6256, fragment_unnamed_6247, fragment_unnamed_6328)), fragment_unnamed_6252).xxxx;
										float fragment_unnamed_6981 = fragment_unnamed_6980.x;
										float4 fragment_unnamed_6984 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6255, fragment_unnamed_6245, fragment_unnamed_6326), mad(fragment_unnamed_6256, fragment_unnamed_6247, fragment_unnamed_6328)), fragment_unnamed_6252).xxxx;
										float fragment_unnamed_6985 = fragment_unnamed_6984.x;
										float4 fragment_unnamed_6988 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6255, fragment_unnamed_6245, fragment_unnamed_6325), mad(fragment_unnamed_6256, fragment_unnamed_6247, fragment_unnamed_6329)), fragment_unnamed_6252).xxxx;
										float fragment_unnamed_6989 = fragment_unnamed_6988.x;
										float4 fragment_unnamed_6992 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6255, fragment_unnamed_6245, fragment_unnamed_6324), mad(fragment_unnamed_6256, fragment_unnamed_6247, fragment_unnamed_6329)), fragment_unnamed_6252).xxxx;
										float fragment_unnamed_6993 = fragment_unnamed_6992.x;
										float fragment_unnamed_6994 = asfloat(0u);
										float fragment_unnamed_7425;
										fragment_unnamed_7425 = fragment_unnamed_6527;
										float fragment_unnamed_7426;
										for (float fragment_unnamed_7427 = fragment_unnamed_6994; !(int(asuint(fragment_unnamed_7427)) >= int(1u)); fragment_unnamed_7426 = mad(fragment_unnamed_6355, fragment_unnamed_6993, mad(fragment_unnamed_6354, fragment_unnamed_6989, mad(fragment_unnamed_6353, fragment_unnamed_6985, mad(fragment_unnamed_6352, fragment_unnamed_6981, fragment_unnamed_7425)))), fragment_unnamed_7425 = fragment_unnamed_7426, fragment_unnamed_7427 = asfloat(asuint(fragment_unnamed_7427) + 1u))
										{
										}
										fragment_unnamed_7981 = asfloat((((((fragment_unnamed_6212 < (fragment_unnamed_6115 + fragment_unnamed_5170)) ? 4294967295u : 0u) | ((fragment_unnamed_6211 < (fragment_unnamed_6113 + fragment_unnamed_5174)) ? 4294967295u : 0u)) | (((mad(fragment_unnamed_4073 + (-0.5f), fragment_unnamed_6115, fragment_unnamed_5170) < fragment_unnamed_6212) ? 4294967295u : 0u) | ((mad(fragment_unnamed_4071 + (-0.5f), fragment_unnamed_6113, fragment_unnamed_5174) < fragment_unnamed_6211) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(mad(fragment_unnamed_6311 * fragment_unnamed_6306, _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6255, fragment_unnamed_6245, fragment_unnamed_6326), mad(fragment_unnamed_6256, fragment_unnamed_6247, fragment_unnamed_6329)), fragment_unnamed_6252).xxxx.x, fragment_unnamed_7425)));
									}
									fragment_unnamed_4766 = mad(fragment_unnamed_2820, fragment_unnamed_7981 + (-1.0f), 1.0f);
								}
								else
								{
									fragment_unnamed_4766 = asfloat(1065353216u);
								}
								float fragment_unnamed_4768 = asfloat(fragment_unnamed_2801.z);
								float fragment_unnamed_4769 = asfloat(fragment_unnamed_2801.w);
								float fragment_unnamed_4773 = ((-0.0f) - fragment_unnamed_4768) + 1.0f;
								float fragment_unnamed_4774 = ((-0.0f) - fragment_unnamed_4769) + 1.0f;
								float fragment_unnamed_4775 = ((-0.0f) - fragment_unnamed_2818) + 1.0f;
								float fragment_unnamed_4777 = fragment_unnamed_4766 * (fragment_unnamed_4766 * fragment_unnamed_4766);
								float fragment_unnamed_4780 = (-0.0f) - (((-0.0f) - fragment_unnamed_4766) + 1.0f);
								float fragment_unnamed_4781 = mad(fragment_unnamed_4780, fragment_unnamed_4773, 1.0f);
								float fragment_unnamed_4782 = mad(fragment_unnamed_4780, fragment_unnamed_4774, 1.0f);
								float fragment_unnamed_4783 = mad(fragment_unnamed_4780, fragment_unnamed_4775, 1.0f);
								float fragment_unnamed_4799 = (fragment_unnamed_3744 * fragment_unnamed_3746) * mad(fragment_unnamed_2721, ((-0.0f) - fragment_unnamed_4781) + mad(fragment_unnamed_4777, fragment_unnamed_4773, fragment_unnamed_4768 * fragment_unnamed_4766), fragment_unnamed_4781);
								float fragment_unnamed_4800 = (fragment_unnamed_3744 * fragment_unnamed_3748) * mad(fragment_unnamed_2721, ((-0.0f) - fragment_unnamed_4782) + mad(fragment_unnamed_4777, fragment_unnamed_4774, fragment_unnamed_4769 * fragment_unnamed_4766), fragment_unnamed_4782);
								float fragment_unnamed_4801 = (fragment_unnamed_3744 * fragment_unnamed_3750) * mad(fragment_unnamed_2721, ((-0.0f) - fragment_unnamed_4783) + mad(fragment_unnamed_4777, fragment_unnamed_4775, fragment_unnamed_2818 * fragment_unnamed_4766), fragment_unnamed_4783);
								float fragment_unnamed_3061;
								float fragment_unnamed_3063;
								float fragment_unnamed_3065;
								float fragment_unnamed_3067;
								float fragment_unnamed_3069;
								float fragment_unnamed_3071;
								if (0.0f < max(fragment_unnamed_4801, max(fragment_unnamed_4800, fragment_unnamed_4799)))
								{
									uint fragment_unnamed_5189 = (fragment_unnamed_1765 * 56u) + 49u;
									uint2 fragment_unnamed_5195 = uint2(T7.Load(fragment_unnamed_5189).x, T7.Load(fragment_unnamed_5189 + 1u).x);
									float fragment_unnamed_5197 = asfloat(fragment_unnamed_5195.x);
									float fragment_unnamed_5199 = asfloat(fragment_unnamed_5195.y);
									float fragment_unnamed_5200 = max(fragment_unnamed_1200, asfloat(T7.Load((fragment_unnamed_1765 * 56u) + 38u).x));
									float fragment_unnamed_5201 = clamp(fragment_unnamed_2323, 0.0f, 1.0f);
									float fragment_unnamed_5202 = dot(float3(fragment_unnamed_2318, fragment_unnamed_2319, fragment_unnamed_2320), float3(fragment_unnamed_344, fragment_unnamed_345, fragment_unnamed_346));
									float fragment_unnamed_5207 = rsqrt(max(mad(fragment_unnamed_5202, 2.0f, 2.0f), 5.9604644775390625e-08f));
									float fragment_unnamed_5210 = clamp(fragment_unnamed_5207 * (fragment_unnamed_1155 + fragment_unnamed_2323), 0.0f, 1.0f);
									float fragment_unnamed_5214 = ((-0.0f) - clamp(mad(fragment_unnamed_5207, fragment_unnamed_5202, fragment_unnamed_5207), 0.0f, 1.0f)) + 1.0f;
									float fragment_unnamed_5215 = fragment_unnamed_5214 * fragment_unnamed_5214;
									float fragment_unnamed_5216 = fragment_unnamed_5215 * fragment_unnamed_5215;
									float fragment_unnamed_5221 = fragment_unnamed_5200 * fragment_unnamed_5200;
									float fragment_unnamed_5224 = mad(mad(fragment_unnamed_5210, fragment_unnamed_5221, (-0.0f) - fragment_unnamed_5210), fragment_unnamed_5210, 1.0f);
									float fragment_unnamed_5245 = ((-0.0f) - abs(fragment_unnamed_2323)) + 1.0f;
									float fragment_unnamed_5246 = fragment_unnamed_5245 * fragment_unnamed_5245;
									float fragment_unnamed_5249 = mad(fragment_unnamed_1154, fragment_unnamed_5202, fragment_unnamed_1154) + (-0.5f);
									float fragment_unnamed_5255 = (fragment_unnamed_5201 * (mad(fragment_unnamed_5249, fragment_unnamed_1574, 1.0f) * mad(fragment_unnamed_5249, fragment_unnamed_5245 * (fragment_unnamed_5246 * fragment_unnamed_5246), 1.0f))) * 0.307334959506988525390625f;
									float fragment_unnamed_5257 = fragment_unnamed_5201 * (((fragment_unnamed_5221 * 0.15915493667125701904296875f) / max(mad(abs(fragment_unnamed_2323), fragment_unnamed_1212, fragment_unnamed_1158 * sqrt(mad(mad((-0.0f) - abs(fragment_unnamed_2323), fragment_unnamed_5221, abs(fragment_unnamed_2323)), abs(fragment_unnamed_2323), fragment_unnamed_5221))) * (fragment_unnamed_5224 * fragment_unnamed_5224), 1.1754943508222875079687365372222e-38f)) * mad(mad((-0.0f) - fragment_unnamed_5216, fragment_unnamed_5214, 1.0f), 0.039999999105930328369140625f, fragment_unnamed_5214 * fragment_unnamed_5216));
									fragment_unnamed_3061 = fragment_unnamed_5199 * (fragment_unnamed_4799 * fragment_unnamed_5257);
									fragment_unnamed_3063 = fragment_unnamed_5199 * (fragment_unnamed_4800 * fragment_unnamed_5257);
									fragment_unnamed_3065 = fragment_unnamed_5199 * (fragment_unnamed_4801 * fragment_unnamed_5257);
									fragment_unnamed_3067 = fragment_unnamed_5197 * (fragment_unnamed_4799 * fragment_unnamed_5255);
									fragment_unnamed_3069 = fragment_unnamed_5197 * (fragment_unnamed_4800 * fragment_unnamed_5255);
									fragment_unnamed_3071 = fragment_unnamed_5197 * (fragment_unnamed_4801 * fragment_unnamed_5255);
								}
								else
								{
									fragment_unnamed_3061 = asfloat(0u);
									fragment_unnamed_3063 = asfloat(0u);
									fragment_unnamed_3065 = asfloat(0u);
									fragment_unnamed_3067 = asfloat(0u);
									fragment_unnamed_3069 = asfloat(0u);
									fragment_unnamed_3071 = asfloat(0u);
								}
								fragment_unnamed_3060 = fragment_unnamed_3061;
								fragment_unnamed_3062 = fragment_unnamed_3063;
								fragment_unnamed_3064 = fragment_unnamed_3065;
								fragment_unnamed_3066 = fragment_unnamed_3067;
								fragment_unnamed_3068 = fragment_unnamed_3069;
								fragment_unnamed_3070 = fragment_unnamed_3071;
							}
							else
							{
								fragment_unnamed_3060 = asfloat(0u);
								fragment_unnamed_3062 = asfloat(0u);
								fragment_unnamed_3064 = asfloat(0u);
								fragment_unnamed_3066 = asfloat(0u);
								fragment_unnamed_3068 = asfloat(0u);
								fragment_unnamed_3070 = asfloat(0u);
							}
							fragment_unnamed_1608 = fragment_unnamed_3066 + fragment_unnamed_1607;
							fragment_unnamed_1610 = fragment_unnamed_3068 + fragment_unnamed_1609;
							fragment_unnamed_1612 = fragment_unnamed_3070 + fragment_unnamed_1611;
							fragment_unnamed_1614 = fragment_unnamed_3062 + fragment_unnamed_1613;
							fragment_unnamed_1616 = fragment_unnamed_3064 + fragment_unnamed_1615;
							fragment_unnamed_1618 = fragment_unnamed_3060 + fragment_unnamed_1617;
							fragment_unnamed_1605 = fragment_unnamed_1606;
							fragment_unnamed_1607 = fragment_unnamed_1608;
							fragment_unnamed_1609 = fragment_unnamed_1610;
							fragment_unnamed_1611 = fragment_unnamed_1612;
							fragment_unnamed_1613 = fragment_unnamed_1614;
							fragment_unnamed_1615 = fragment_unnamed_1616;
							fragment_unnamed_1617 = fragment_unnamed_1618;
							continue;
						}
					}
					if (ladder_phi_21)
					{
						break;
					}
					break;
				}
				uint4 fragment_unnamed_1691 = asuint(fragment_uniform_buffer_0[128u]);
				uint fragment_unnamed_1692 = fragment_unnamed_1691.y;
				uint4 fragment_unnamed_1699 = asuint(fragment_uniform_buffer_0[128u]);
				uint fragment_unnamed_1700 = fragment_unnamed_1699.x;
				uint4 fragment_unnamed_1705 = T4.Load(((((fragment_unnamed_1531 + (2u << (fragment_unnamed_1493 & 31u))) * fragment_unnamed_1692) + fragment_unnamed_285) * fragment_unnamed_1700) + fragment_unnamed_283);
				uint fragment_unnamed_1706 = fragment_unnamed_1705.x;
				uint fragment_unnamed_1707 = fragment_unnamed_1706 & 67108863u;
				uint fragment_unnamed_1708 = fragment_unnamed_1706 >> 26u;
				float4 fragment_unnamed_1709 = _SsrLightingTexture.Load(int4(uint3(fragment_unnamed_281, fragment_unnamed_282, 0u), 0u));
				float fragment_unnamed_1714 = fragment_unnamed_1709.w;
				float4 fragment_unnamed_1715 = _PrevExposureTexture.Load(int3(uint2(0u, 0u), 0u));
				float fragment_unnamed_1718 = fragment_unnamed_1715.x;
				float fragment_unnamed_1741 = asfloat((asuint(fragment_uniform_buffer_0[213u]).y != 0u) ? 1065353216u : asuint(1.0f / mad(fragment_unnamed_1718, fragment_uniform_buffer_0[118u].y, asfloat((((fragment_unnamed_1718 * fragment_uniform_buffer_0[118u].y) == 0.0f) ? 4294967295u : 0u) & 1065353216u))));
				float fragment_unnamed_1752 = asfloat((asuint(fragment_uniform_buffer_0[213u]).y != 0u) ? asuint(fragment_unnamed_1714) : 1065353216u);
				float fragment_unnamed_1756 = fragment_unnamed_1201 * (fragment_unnamed_1752 * (fragment_unnamed_1741 * fragment_unnamed_1709.x));
				float fragment_unnamed_1757 = fragment_unnamed_1201 * (fragment_unnamed_1752 * (fragment_unnamed_1741 * fragment_unnamed_1709.y));
				float fragment_unnamed_1758 = fragment_unnamed_1201 * (fragment_unnamed_1752 * (fragment_unnamed_1741 * fragment_unnamed_1709.z));
				float fragment_unnamed_1759 = asfloat(0u);
				float fragment_unnamed_1760 = asfloat(0u);
				float fragment_unnamed_1761 = asfloat(0u);
				float fragment_unnamed_1940;
				float fragment_unnamed_1942;
				float fragment_unnamed_1944;
				float fragment_unnamed_1946;
				float fragment_unnamed_1948;
				for (;;)
				{
					fragment_unnamed_1940 = fragment_unnamed_1714;
					fragment_unnamed_1942 = fragment_unnamed_1761;
					fragment_unnamed_1944 = fragment_unnamed_1756;
					fragment_unnamed_1946 = fragment_unnamed_1757;
					fragment_unnamed_1948 = fragment_unnamed_1758;
					float fragment_unnamed_1943;
					float fragment_unnamed_1941;
					float fragment_unnamed_1945;
					float fragment_unnamed_1947;
					float fragment_unnamed_1949;
					bool ladder_phi_33;
					for (;;)
					{
						if (asuint(fragment_unnamed_1942) >= fragment_unnamed_1708)
						{
							ladder_phi_33 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_2234 = asuint(fragment_unnamed_1942);
							uint4 fragment_unnamed_2236 = T3.Load(fragment_unnamed_1707 + fragment_unnamed_2234);
							uint fragment_unnamed_2237 = fragment_unnamed_2236.x;
							if (fragment_unnamed_2237 == 4294967295u)
							{
								ladder_phi_33 = false;
								break;
							}
							fragment_unnamed_1943 = asfloat(asuint(fragment_unnamed_1942) + 1u);
							if (!(fragment_unnamed_1940 < 1.0f))
							{
								fragment_unnamed_1941 = fragment_unnamed_1940;
								fragment_unnamed_1945 = fragment_unnamed_1944;
								fragment_unnamed_1947 = fragment_unnamed_1946;
								fragment_unnamed_1949 = fragment_unnamed_1948;
								fragment_unnamed_1940 = fragment_unnamed_1941;
								fragment_unnamed_1942 = fragment_unnamed_1943;
								fragment_unnamed_1944 = fragment_unnamed_1945;
								fragment_unnamed_1946 = fragment_unnamed_1947;
								fragment_unnamed_1948 = fragment_unnamed_1949;
								continue;
							}
							uint fragment_unnamed_3020 = fragment_unnamed_2237 * 72u;
							uint4 fragment_unnamed_3033 = uint4(T8.Load(fragment_unnamed_3020).x, T8.Load(fragment_unnamed_3020 + 1u).x, T8.Load(fragment_unnamed_3020 + 2u).x, T8.Load(fragment_unnamed_3020 + 3u).x);
							float fragment_unnamed_3036 = asfloat(fragment_unnamed_3033.y);
							float fragment_unnamed_3038 = asfloat(fragment_unnamed_3033.z);
							float fragment_unnamed_3040 = asfloat(fragment_unnamed_3033.w);
							float fragment_unnamed_3043;
							float fragment_unnamed_3044;
							float fragment_unnamed_3045;
							float fragment_unnamed_3046;
							if ((fragment_unnamed_885 & fragment_unnamed_3033.x) != 0u)
							{
								uint fragment_unnamed_3228 = (fragment_unnamed_2237 * 72u) + 4u;
								uint4 fragment_unnamed_3240 = uint4(T8.Load(fragment_unnamed_3228).x, T8.Load(fragment_unnamed_3228 + 1u).x, T8.Load(fragment_unnamed_3228 + 2u).x, T8.Load(fragment_unnamed_3228 + 3u).x);
								uint fragment_unnamed_3241 = fragment_unnamed_3240.x;
								float fragment_unnamed_3243 = asfloat(fragment_unnamed_3240.y);
								float fragment_unnamed_3245 = asfloat(fragment_unnamed_3240.z);
								float fragment_unnamed_3247 = asfloat(fragment_unnamed_3240.w);
								uint fragment_unnamed_3249 = (fragment_unnamed_2237 * 72u) + 8u;
								uint4 fragment_unnamed_3261 = uint4(T8.Load(fragment_unnamed_3249).x, T8.Load(fragment_unnamed_3249 + 1u).x, T8.Load(fragment_unnamed_3249 + 2u).x, T8.Load(fragment_unnamed_3249 + 3u).x);
								float fragment_unnamed_3263 = asfloat(fragment_unnamed_3261.x);
								uint fragment_unnamed_3271 = (fragment_unnamed_2237 * 72u) + 12u;
								uint4 fragment_unnamed_3283 = uint4(T8.Load(fragment_unnamed_3271).x, T8.Load(fragment_unnamed_3271 + 1u).x, T8.Load(fragment_unnamed_3271 + 2u).x, T8.Load(fragment_unnamed_3271 + 3u).x);
								float fragment_unnamed_3285 = asfloat(fragment_unnamed_3283.x);
								float fragment_unnamed_3287 = asfloat(fragment_unnamed_3283.y);
								float fragment_unnamed_3289 = asfloat(fragment_unnamed_3283.z);
								uint fragment_unnamed_3292 = (fragment_unnamed_2237 * 72u) + 16u;
								uint4 fragment_unnamed_3304 = uint4(T8.Load(fragment_unnamed_3292).x, T8.Load(fragment_unnamed_3292 + 1u).x, T8.Load(fragment_unnamed_3292 + 2u).x, T8.Load(fragment_unnamed_3292 + 3u).x);
								float fragment_unnamed_3307 = asfloat(fragment_unnamed_3304.x);
								float fragment_unnamed_3309 = asfloat(fragment_unnamed_3304.y);
								uint fragment_unnamed_3313 = (fragment_unnamed_2237 * 72u) + 20u;
								uint4 fragment_unnamed_3325 = uint4(T8.Load(fragment_unnamed_3313).x, T8.Load(fragment_unnamed_3313 + 1u).x, T8.Load(fragment_unnamed_3313 + 2u).x, T8.Load(fragment_unnamed_3313 + 3u).x);
								float fragment_unnamed_3331 = asfloat(fragment_unnamed_3325.x);
								uint fragment_unnamed_3335 = (fragment_unnamed_2237 * 72u) + 24u;
								uint4 fragment_unnamed_3347 = uint4(T8.Load(fragment_unnamed_3335).x, T8.Load(fragment_unnamed_3335 + 1u).x, T8.Load(fragment_unnamed_3335 + 2u).x, T8.Load(fragment_unnamed_3335 + 3u).x);
								float fragment_unnamed_3349 = asfloat(fragment_unnamed_3347.x);
								float fragment_unnamed_3351 = asfloat(fragment_unnamed_3347.y);
								float fragment_unnamed_3353 = asfloat(fragment_unnamed_3347.z);
								uint fragment_unnamed_3356 = (fragment_unnamed_2237 * 72u) + 28u;
								uint4 fragment_unnamed_3368 = uint4(T8.Load(fragment_unnamed_3356).x, T8.Load(fragment_unnamed_3356 + 1u).x, T8.Load(fragment_unnamed_3356 + 2u).x, T8.Load(fragment_unnamed_3356 + 3u).x);
								float fragment_unnamed_3371 = asfloat(fragment_unnamed_3368.x);
								float fragment_unnamed_3373 = asfloat(fragment_unnamed_3368.y);
								uint fragment_unnamed_3377 = (fragment_unnamed_2237 * 72u) + 32u;
								uint4 fragment_unnamed_3389 = uint4(T8.Load(fragment_unnamed_3377).x, T8.Load(fragment_unnamed_3377 + 1u).x, T8.Load(fragment_unnamed_3377 + 2u).x, T8.Load(fragment_unnamed_3377 + 3u).x);
								float fragment_unnamed_3392 = asfloat(fragment_unnamed_3389.y);
								float fragment_unnamed_3394 = asfloat(fragment_unnamed_3389.z);
								float fragment_unnamed_3396 = asfloat(fragment_unnamed_3389.w);
								uint fragment_unnamed_3399 = (fragment_unnamed_2237 * 72u) + 36u;
								uint4 fragment_unnamed_3411 = uint4(T8.Load(fragment_unnamed_3399).x, T8.Load(fragment_unnamed_3399 + 1u).x, T8.Load(fragment_unnamed_3399 + 2u).x, T8.Load(fragment_unnamed_3399 + 3u).x);
								float fragment_unnamed_3413 = asfloat(fragment_unnamed_3411.x);
								uint fragment_unnamed_3420 = (fragment_unnamed_2237 * 72u) + 40u;
								uint4 fragment_unnamed_3432 = uint4(T8.Load(fragment_unnamed_3420).x, T8.Load(fragment_unnamed_3420 + 1u).x, T8.Load(fragment_unnamed_3420 + 2u).x, T8.Load(fragment_unnamed_3420 + 3u).x);
								float fragment_unnamed_3434 = asfloat(fragment_unnamed_3432.z);
								uint fragment_unnamed_3441 = (fragment_unnamed_2237 * 72u) + 52u;
								uint4 fragment_unnamed_3453 = uint4(T8.Load(fragment_unnamed_3441).x, T8.Load(fragment_unnamed_3441 + 1u).x, T8.Load(fragment_unnamed_3441 + 2u).x, T8.Load(fragment_unnamed_3441 + 3u).x);
								float fragment_unnamed_3459 = asfloat(fragment_unnamed_3453.w);
								uint fragment_unnamed_3461 = (fragment_unnamed_2237 * 72u) + 56u;
								uint4 fragment_unnamed_3473 = uint4(T8.Load(fragment_unnamed_3461).x, T8.Load(fragment_unnamed_3461 + 1u).x, T8.Load(fragment_unnamed_3461 + 2u).x, T8.Load(fragment_unnamed_3461 + 3u).x);
								float fragment_unnamed_3475 = asfloat(fragment_unnamed_3473.x);
								uint fragment_unnamed_3480 = fragment_unnamed_3473.w;
								bool fragment_unnamed_3481 = int(fragment_unnamed_3480) >= int(0u);
								float fragment_unnamed_3483 = max(fragment_unnamed_1155, 9.9999997473787516355514526367188e-05f);
								float fragment_unnamed_3484 = fragment_unnamed_1154 * fragment_unnamed_1154;
								float fragment_unnamed_3486 = mad((-0.0f) - fragment_unnamed_1154, fragment_unnamed_1154, 1.0f);
								float fragment_unnamed_3493 = clamp(mad(fragment_unnamed_3486, fragment_unnamed_3486, fragment_unnamed_3486 * (fragment_unnamed_3483 * fragment_unnamed_3483)), 0.0f, 1.0f) * mad(fragment_unnamed_1154, fragment_unnamed_1154, sqrt(fragment_unnamed_3486));
								float fragment_unnamed_3500 = mad(fragment_unnamed_3493, mad((-0.0f) - fragment_unnamed_870, fragment_unnamed_877, fragment_unnamed_1221), fragment_unnamed_878);
								float fragment_unnamed_3501 = mad(fragment_unnamed_3493, mad((-0.0f) - fragment_unnamed_871, fragment_unnamed_877, fragment_unnamed_1222), fragment_unnamed_879);
								float fragment_unnamed_3502 = mad(fragment_unnamed_3493, mad((-0.0f) - fragment_unnamed_872, fragment_unnamed_877, fragment_unnamed_1223), fragment_unnamed_880);
								float fragment_unnamed_3504 = min(fragment_unnamed_3484 * fragment_unnamed_3484, 1.0f);
								float fragment_unnamed_3508 = min((fragment_unnamed_3504 * fragment_unnamed_3504) * mad(fragment_unnamed_3504, -2.0f, 3.0f), 1.0f);
								float fragment_unnamed_3525 = asfloat(fragment_unnamed_3481 ? asuint(mad(fragment_unnamed_3508, fragment_unnamed_1221 + ((-0.0f) - fragment_unnamed_3500), fragment_unnamed_3500)) : asuint(fragment_unnamed_1221));
								float fragment_unnamed_3527 = asfloat(fragment_unnamed_3481 ? asuint(mad(fragment_unnamed_3508, fragment_unnamed_1222 + ((-0.0f) - fragment_unnamed_3501), fragment_unnamed_3501)) : asuint(fragment_unnamed_1222));
								float fragment_unnamed_3529 = asfloat(fragment_unnamed_3481 ? asuint(mad(fragment_unnamed_3508, fragment_unnamed_1223 + ((-0.0f) - fragment_unnamed_3502), fragment_unnamed_3502)) : asuint(fragment_unnamed_1223));
								float fragment_unnamed_3539 = ((-0.0f) - asfloat(fragment_unnamed_3325.y)) + fragment_input_6.x;
								float fragment_unnamed_3540 = ((-0.0f) - asfloat(fragment_unnamed_3325.z)) + fragment_input_6.y;
								float fragment_unnamed_3541 = ((-0.0f) - asfloat(fragment_unnamed_3325.w)) + fragment_input_6.z;
								float fragment_unnamed_3542 = asfloat(fragment_unnamed_3368.z);
								float fragment_unnamed_3543 = asfloat(fragment_unnamed_3368.w);
								float fragment_unnamed_3544 = asfloat(fragment_unnamed_3389.x);
								float fragment_unnamed_3545 = dot(float3(fragment_unnamed_3539, fragment_unnamed_3540, fragment_unnamed_3541), float3(fragment_unnamed_3542, fragment_unnamed_3543, fragment_unnamed_3544));
								float fragment_unnamed_3548 = asfloat(fragment_unnamed_3347.w);
								float fragment_unnamed_3549 = dot(float3(fragment_unnamed_3539, fragment_unnamed_3540, fragment_unnamed_3541), float3(fragment_unnamed_3548, fragment_unnamed_3371, fragment_unnamed_3373));
								float fragment_unnamed_3552 = dot(float3(fragment_unnamed_3539, fragment_unnamed_3540, fragment_unnamed_3541), float3(fragment_unnamed_3349, fragment_unnamed_3351, fragment_unnamed_3353));
								float fragment_unnamed_3564 = ((-0.0f) - asfloat(fragment_unnamed_3261.y)) + fragment_input_6.x;
								float fragment_unnamed_3565 = ((-0.0f) - asfloat(fragment_unnamed_3261.z)) + fragment_input_6.y;
								float fragment_unnamed_3566 = ((-0.0f) - asfloat(fragment_unnamed_3261.w)) + fragment_input_6.z;
								float fragment_unnamed_3567 = asfloat(fragment_unnamed_3304.z);
								float fragment_unnamed_3568 = asfloat(fragment_unnamed_3304.w);
								float fragment_unnamed_3569 = dot(float3(fragment_unnamed_3564, fragment_unnamed_3565, fragment_unnamed_3566), float3(fragment_unnamed_3567, fragment_unnamed_3568, fragment_unnamed_3331));
								float fragment_unnamed_3572 = asfloat(fragment_unnamed_3283.w);
								float fragment_unnamed_3573 = dot(float3(fragment_unnamed_3564, fragment_unnamed_3565, fragment_unnamed_3566), float3(fragment_unnamed_3572, fragment_unnamed_3307, fragment_unnamed_3309));
								float fragment_unnamed_3576 = dot(float3(fragment_unnamed_3564, fragment_unnamed_3565, fragment_unnamed_3566), float3(fragment_unnamed_3285, fragment_unnamed_3287, fragment_unnamed_3289));
								float fragment_unnamed_3579 = dot(float3(fragment_unnamed_3525, fragment_unnamed_3527, fragment_unnamed_3529), float3(fragment_unnamed_3567, fragment_unnamed_3568, fragment_unnamed_3331));
								float fragment_unnamed_3582 = dot(float3(fragment_unnamed_3525, fragment_unnamed_3527, fragment_unnamed_3529), float3(fragment_unnamed_3572, fragment_unnamed_3307, fragment_unnamed_3309));
								float fragment_unnamed_3585 = dot(float3(fragment_unnamed_3525, fragment_unnamed_3527, fragment_unnamed_3529), float3(fragment_unnamed_3285, fragment_unnamed_3287, fragment_unnamed_3289));
								float fragment_unnamed_4352;
								float fragment_unnamed_4354;
								float fragment_unnamed_4356;
								float fragment_unnamed_4358;
								float fragment_unnamed_4360;
								if (fragment_unnamed_3241 == 2u)
								{
									float fragment_unnamed_3891 = dot(float3(fragment_unnamed_3579, fragment_unnamed_3582, fragment_unnamed_3585), float3(fragment_unnamed_3569, fragment_unnamed_3573, fragment_unnamed_3576));
									float fragment_unnamed_3894 = fragment_unnamed_3891 + fragment_unnamed_3891;
									float fragment_unnamed_3907 = abs(mad((-0.0f) - fragment_unnamed_3891, 2.0f, sqrt(mad(fragment_unnamed_3894, fragment_unnamed_3894, (-0.0f) - (mad((-0.0f) - fragment_unnamed_3243, fragment_unnamed_3243, dot(float3(fragment_unnamed_3569, fragment_unnamed_3573, fragment_unnamed_3576), float3(fragment_unnamed_3569, fragment_unnamed_3573, fragment_unnamed_3576))) * 4.0f))))) * 0.5f;
									float fragment_unnamed_3916 = max(fragment_unnamed_3263, asfloat((2139095040u < (asuint(fragment_unnamed_3907) & 2147483647u)) ? 3212836864u : asuint(fragment_unnamed_3907)));
									float fragment_unnamed_3935 = sqrt(dot(float3(fragment_unnamed_3545, fragment_unnamed_3549, fragment_unnamed_3552), float3(fragment_unnamed_3545, fragment_unnamed_3549, fragment_unnamed_3552)));
									float fragment_unnamed_3958 = ((-0.0f) - fragment_unnamed_3036) + fragment_input_6.x;
									float fragment_unnamed_3959 = ((-0.0f) - fragment_unnamed_3038) + fragment_input_6.y;
									float fragment_unnamed_3960 = ((-0.0f) - fragment_unnamed_3040) + fragment_input_6.z;
									float fragment_unnamed_3964 = rsqrt(dot(float3(fragment_unnamed_3958, fragment_unnamed_3959, fragment_unnamed_3960), float3(fragment_unnamed_3958, fragment_unnamed_3959, fragment_unnamed_3960)));
									fragment_unnamed_4352 = fragment_unnamed_3916;
									fragment_unnamed_4354 = asfloat(((fragment_unnamed_3392 + ((-0.0f) - fragment_unnamed_3434)) >= fragment_unnamed_3935) ? 1065353216u : asuint(clamp(mad(dot(float3(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880), float3(fragment_unnamed_3964 * fragment_unnamed_3958, fragment_unnamed_3964 * fragment_unnamed_3959, fragment_unnamed_3964 * fragment_unnamed_3960)), -2.5f, 1.5f), 0.0f, 1.0f))) * max(((-0.0f) - (max(fragment_unnamed_3935 + ((-0.0f) - (fragment_unnamed_3392 + ((-0.0f) - fragment_unnamed_3413))), 0.0f) / max(fragment_unnamed_3413, 9.9999997473787516355514526367188e-05f))) + 1.0f, 0.0f);
									fragment_unnamed_4356 = ((-0.0f) - fragment_unnamed_3036) + mad(fragment_unnamed_3916, fragment_unnamed_3525, fragment_input_6.x);
									fragment_unnamed_4358 = ((-0.0f) - fragment_unnamed_3038) + mad(fragment_unnamed_3916, fragment_unnamed_3527, fragment_input_6.y);
									fragment_unnamed_4360 = ((-0.0f) - fragment_unnamed_3040) + mad(fragment_unnamed_3916, fragment_unnamed_3529, fragment_input_6.z);
								}
								else
								{
									float fragment_unnamed_4353;
									float fragment_unnamed_4355;
									float fragment_unnamed_4357;
									float fragment_unnamed_4359;
									float fragment_unnamed_4361;
									if (fragment_unnamed_3241 == 1u)
									{
										uint fragment_unnamed_4395 = (fragment_unnamed_2237 * 72u) + 44u;
										uint4 fragment_unnamed_4407 = uint4(T8.Load(fragment_unnamed_4395).x, T8.Load(fragment_unnamed_4395 + 1u).x, T8.Load(fragment_unnamed_4395 + 2u).x, T8.Load(fragment_unnamed_4395 + 3u).x);
										uint fragment_unnamed_4416 = (fragment_unnamed_2237 * 72u) + 48u;
										uint4 fragment_unnamed_4428 = uint4(T8.Load(fragment_unnamed_4416).x, T8.Load(fragment_unnamed_4416 + 1u).x, T8.Load(fragment_unnamed_4416 + 2u).x, T8.Load(fragment_unnamed_4416 + 3u).x);
										float fragment_unnamed_4437 = dot(float3(fragment_unnamed_3525, fragment_unnamed_3527, fragment_unnamed_3529), float3(fragment_unnamed_3542, fragment_unnamed_3543, fragment_unnamed_3544));
										float fragment_unnamed_4440 = dot(float3(fragment_unnamed_3525, fragment_unnamed_3527, fragment_unnamed_3529), float3(fragment_unnamed_3548, fragment_unnamed_3371, fragment_unnamed_3373));
										float fragment_unnamed_4443 = dot(float3(fragment_unnamed_3525, fragment_unnamed_3527, fragment_unnamed_3529), float3(fragment_unnamed_3349, fragment_unnamed_3351, fragment_unnamed_3353));
										float fragment_unnamed_4449 = rsqrt(dot(float3(fragment_unnamed_4437, fragment_unnamed_4440, fragment_unnamed_4443), float3(fragment_unnamed_4437, fragment_unnamed_4440, fragment_unnamed_4443)));
										float fragment_unnamed_4450 = fragment_unnamed_4449 * fragment_unnamed_4437;
										float fragment_unnamed_4451 = fragment_unnamed_4449 * fragment_unnamed_4440;
										float fragment_unnamed_4452 = fragment_unnamed_4449 * fragment_unnamed_4443;
										float fragment_unnamed_4453 = 1.0f / fragment_unnamed_3579;
										float fragment_unnamed_4454 = 1.0f / fragment_unnamed_3582;
										float fragment_unnamed_4455 = 1.0f / fragment_unnamed_3585;
										float fragment_unnamed_4494 = max(fragment_unnamed_3263, min(asfloat((0.0f < fragment_unnamed_3585) ? asuint(fragment_unnamed_4455 * (fragment_unnamed_3247 + ((-0.0f) - fragment_unnamed_3576))) : asuint(fragment_unnamed_4455 * (((-0.0f) - fragment_unnamed_3247) + ((-0.0f) - fragment_unnamed_3576)))), min(asfloat((0.0f < fragment_unnamed_3582) ? asuint(fragment_unnamed_4454 * (fragment_unnamed_3245 + ((-0.0f) - fragment_unnamed_3573))) : asuint(fragment_unnamed_4454 * (((-0.0f) - fragment_unnamed_3245) + ((-0.0f) - fragment_unnamed_3573)))), asfloat((0.0f < fragment_unnamed_3579) ? asuint(fragment_unnamed_4453 * (fragment_unnamed_3243 + ((-0.0f) - fragment_unnamed_3569))) : asuint(fragment_unnamed_4453 * (((-0.0f) - fragment_unnamed_3243) + ((-0.0f) - fragment_unnamed_3569)))))));
										float fragment_unnamed_4510 = fragment_unnamed_3392 + fragment_unnamed_3545;
										float fragment_unnamed_4511 = fragment_unnamed_3394 + fragment_unnamed_3549;
										float fragment_unnamed_4512 = fragment_unnamed_3396 + fragment_unnamed_3552;
										float fragment_unnamed_4516 = fragment_unnamed_3392 + ((-0.0f) - fragment_unnamed_3545);
										float fragment_unnamed_4517 = fragment_unnamed_3394 + ((-0.0f) - fragment_unnamed_3549);
										float fragment_unnamed_4518 = fragment_unnamed_3396 + ((-0.0f) - fragment_unnamed_3552);
										float fragment_unnamed_4579 = ((-0.0f) - fragment_unnamed_3036) + fragment_input_6.x;
										float fragment_unnamed_4580 = ((-0.0f) - fragment_unnamed_3038) + fragment_input_6.y;
										float fragment_unnamed_4581 = ((-0.0f) - fragment_unnamed_3040) + fragment_input_6.z;
										float fragment_unnamed_4585 = rsqrt(dot(float3(fragment_unnamed_4579, fragment_unnamed_4580, fragment_unnamed_4581), float3(fragment_unnamed_4579, fragment_unnamed_4580, fragment_unnamed_4581)));
										float fragment_unnamed_4597 = asfloat(((((((fragment_unnamed_4512 / max(asfloat(fragment_unnamed_4407.w), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & ((((fragment_unnamed_4511 / max(asfloat(fragment_unnamed_4407.z), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_4510 / max(asfloat(fragment_unnamed_4407.y), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u))) & ((((fragment_unnamed_4518 / max(asfloat(fragment_unnamed_4407.x), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & ((((fragment_unnamed_4517 / max(asfloat(fragment_unnamed_3432.w), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_4516 / max(fragment_unnamed_3434, 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u)))) != 0u) ? 1065353216u : asuint(clamp(mad(dot(float3(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880), float3(fragment_unnamed_4579 * fragment_unnamed_4585, fragment_unnamed_4580 * fragment_unnamed_4585, fragment_unnamed_4581 * fragment_unnamed_4585)), -2.5f, 1.5f), 0.0f, 1.0f)));
										fragment_unnamed_4353 = fragment_unnamed_4494;
										fragment_unnamed_4355 = (clamp(min(min(fragment_unnamed_4512 / max(asfloat(fragment_unnamed_3432.y), 9.9999997473787516355514526367188e-05f), min(fragment_unnamed_4511 / max(asfloat(fragment_unnamed_3432.x), 9.9999997473787516355514526367188e-05f), fragment_unnamed_4510 / max(asfloat(fragment_unnamed_3411.w), 9.9999997473787516355514526367188e-05f))), min(fragment_unnamed_4518 / max(asfloat(fragment_unnamed_3411.z), 9.9999997473787516355514526367188e-05f), min(fragment_unnamed_4517 / max(asfloat(fragment_unnamed_3411.y), 9.9999997473787516355514526367188e-05f), fragment_unnamed_4516 / max(fragment_unnamed_3413, 9.9999997473787516355514526367188e-05f)))), 0.0f, 1.0f) * fragment_unnamed_4597) * min((clamp(asfloat(fragment_unnamed_4428.z) * mad(fragment_unnamed_4452, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4452, -4.0f, -1.0f) * asfloat(fragment_unnamed_3453.y), 0.0f, 1.0f)) + ((clamp(asfloat(fragment_unnamed_4428.y) * mad(fragment_unnamed_4451, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4451, -4.0f, -1.0f) * asfloat(fragment_unnamed_3453.x), 0.0f, 1.0f)) + (clamp(asfloat(fragment_unnamed_4428.x) * mad(fragment_unnamed_4450, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4450, -4.0f, -1.0f) * asfloat(fragment_unnamed_4428.w), 0.0f, 1.0f))), 1.0f);
										fragment_unnamed_4357 = ((-0.0f) - fragment_unnamed_3036) + mad(fragment_unnamed_4494, fragment_unnamed_3525, fragment_input_6.x);
										fragment_unnamed_4359 = ((-0.0f) - fragment_unnamed_3038) + mad(fragment_unnamed_4494, fragment_unnamed_3527, fragment_input_6.y);
										fragment_unnamed_4361 = ((-0.0f) - fragment_unnamed_3040) + mad(fragment_unnamed_4494, fragment_unnamed_3529, fragment_input_6.z);
									}
									else
									{
										fragment_unnamed_4353 = asfloat(0u);
										fragment_unnamed_4355 = asfloat(1065353216u);
										fragment_unnamed_4357 = fragment_unnamed_3525;
										fragment_unnamed_4359 = fragment_unnamed_3527;
										fragment_unnamed_4361 = fragment_unnamed_3529;
									}
									fragment_unnamed_4352 = fragment_unnamed_4353;
									fragment_unnamed_4354 = fragment_unnamed_4355;
									fragment_unnamed_4356 = fragment_unnamed_4357;
									fragment_unnamed_4358 = fragment_unnamed_4359;
									fragment_unnamed_4360 = fragment_unnamed_4361;
								}
								float fragment_unnamed_4366 = asfloat(fragment_unnamed_3453.z) * ((fragment_unnamed_4354 * fragment_unnamed_4354) * mad((-0.0f) - fragment_unnamed_4354, 2.0f, 3.0f));
								float fragment_unnamed_4374 = min(fragment_unnamed_1154, max(fragment_unnamed_1154 * (fragment_unnamed_4352 / sqrt(dot(float3(fragment_unnamed_4356, fragment_unnamed_4358, fragment_unnamed_4360), float3(fragment_unnamed_4356, fragment_unnamed_4358, fragment_unnamed_4360)))), 0.0f));
								float fragment_unnamed_4384 = asfloat(fragment_unnamed_3481 ? asuint(mad(asfloat(fragment_unnamed_3473.z), ((-0.0f) - fragment_unnamed_1154) + mad(fragment_unnamed_1154, fragment_unnamed_1154 + ((-0.0f) - fragment_unnamed_4374), fragment_unnamed_4374), fragment_unnamed_1154)) : asuint(fragment_unnamed_1154));
								float fragment_unnamed_4388 = asfloat(fragment_unnamed_3473.y) * (fragment_unnamed_4384 * mad((-0.0f) - fragment_unnamed_4384, 0.699999988079071044921875f, 1.7000000476837158203125f));
								float fragment_unnamed_4389 = fragment_unnamed_4388 * 6.0f;
								uint fragment_unnamed_4392 = uint(abs(int(fragment_unnamed_3480))) + 4294967295u;
								float fragment_unnamed_5794;
								float fragment_unnamed_5796;
								float fragment_unnamed_5798;
								float fragment_unnamed_5800;
								if ((fragment_unnamed_3481 ? 4294967295u : 0u) == 0u)
								{
									uint fragment_unnamed_5043 = fragment_unnamed_4392 << 2u;
									uint fragment_unnamed_5044 = fragment_unnamed_5043 + 1u;
									uint fragment_unnamed_5065 = fragment_unnamed_5043 + 2u;
									uint fragment_unnamed_5076 = fragment_unnamed_5043 + 3u;
									float fragment_unnamed_5086 = mad(fragment_uniform_buffer_2[fragment_unnamed_5065].w, fragment_unnamed_4360, mad(fragment_uniform_buffer_2[fragment_unnamed_5043].w, fragment_unnamed_4356, fragment_unnamed_4358 * fragment_uniform_buffer_2[fragment_unnamed_5044].w)) + fragment_uniform_buffer_2[fragment_unnamed_5076].w;
									float fragment_unnamed_5087 = (mad(fragment_uniform_buffer_2[fragment_unnamed_5065].x, fragment_unnamed_4360, mad(fragment_uniform_buffer_2[fragment_unnamed_5043].x, fragment_unnamed_4356, fragment_unnamed_4358 * fragment_uniform_buffer_2[fragment_unnamed_5044].x)) + fragment_uniform_buffer_2[fragment_unnamed_5076].x) * 1.0f;
									float fragment_unnamed_5088 = (mad(fragment_uniform_buffer_2[fragment_unnamed_5065].y, fragment_unnamed_4360, mad(fragment_uniform_buffer_2[fragment_unnamed_5043].y, fragment_unnamed_4356, fragment_unnamed_4358 * fragment_uniform_buffer_2[fragment_unnamed_5044].y)) + fragment_uniform_buffer_2[fragment_unnamed_5076].y) * (-1.0f);
									uint fragment_unnamed_5100 = ((abs((mad(fragment_uniform_buffer_2[fragment_unnamed_5065].z, fragment_unnamed_4360, mad(fragment_uniform_buffer_2[fragment_unnamed_5043].z, fragment_unnamed_4356, fragment_unnamed_4358 * fragment_uniform_buffer_2[fragment_unnamed_5044].z)) + fragment_uniform_buffer_2[fragment_unnamed_5076].z) * 1.0f) < fragment_unnamed_5086) ? 4294967295u : 0u) & (((abs(fragment_unnamed_5088) < fragment_unnamed_5086) ? 4294967295u : 0u) & ((abs(fragment_unnamed_5087) < fragment_unnamed_5086) ? 4294967295u : 0u));
									float fragment_unnamed_5795;
									float fragment_unnamed_5797;
									float fragment_unnamed_5799;
									float fragment_unnamed_5801;
									if (fragment_unnamed_5100 != 0u)
									{
										float fragment_unnamed_5654 = 1.0f / fragment_unnamed_5086;
										float fragment_unnamed_5657 = mad(fragment_unnamed_5654 * fragment_unnamed_5087, 0.5f, 0.5f);
										float fragment_unnamed_5658 = mad(fragment_unnamed_5654 * fragment_unnamed_5088, 0.5f, 0.5f);
										uint fragment_unnamed_5666 = fragment_unnamed_4392 + 64u;
										uint fragment_unnamed_5678 = fragment_unnamed_4392 + 64u;
										float fragment_unnamed_5686 = exp2(ceil(fragment_unnamed_4389));
										float fragment_unnamed_5691 = fragment_unnamed_5686 * fragment_uniform_buffer_0[125u].z;
										float fragment_unnamed_5692 = fragment_unnamed_5686 * fragment_uniform_buffer_0[125u].w;
										uint fragment_unnamed_5693 = fragment_unnamed_4392 + 64u;
										uint fragment_unnamed_5700 = fragment_unnamed_4392 + 64u;
										uint fragment_unnamed_5705 = fragment_unnamed_4392 + 64u;
										float4 fragment_unnamed_5723 = _ReflectionAtlas.SampleLevel(S1, float3(min(mad((-0.0f) - fragment_unnamed_5691, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5700].x + fragment_uniform_buffer_2[fragment_unnamed_5705].z), max(mad(fragment_unnamed_5691, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5693].z), mad(fragment_unnamed_5657, ((-0.0f) - fragment_uniform_buffer_0[125u].x) + fragment_uniform_buffer_2[fragment_unnamed_5666].x, mad(fragment_uniform_buffer_0[125u].x, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5678].z)))), min(mad((-0.0f) - fragment_unnamed_5692, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5700].y + fragment_uniform_buffer_2[fragment_unnamed_5705].w), max(mad(fragment_unnamed_5692, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5693].w), mad(fragment_unnamed_5658, ((-0.0f) - fragment_uniform_buffer_0[125u].y) + fragment_uniform_buffer_2[fragment_unnamed_5666].y, mad(fragment_uniform_buffer_0[125u].y, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5678].w)))), fragment_unnamed_1760), fragment_unnamed_4389);
										float fragment_unnamed_5758 = min(abs(mad((-0.0f) - fragment_unnamed_279, fragment_uniform_buffer_0[50u].z, fragment_unnamed_5657)) * 100.0f, 1.0f);
										float fragment_unnamed_5759 = min(abs(mad((-0.0f) - fragment_unnamed_280, fragment_uniform_buffer_0[50u].w, fragment_unnamed_5658)) * 100.0f, 1.0f);
										fragment_unnamed_5795 = (asfloat((((((fragment_unnamed_292 < fragment_unnamed_5658) ? 4294967295u : 0u) & 1u) ^ (((fragment_unnamed_5658 < 0.5f) ? 4294967295u : 0u) & 1u)) != 0u) ? asuint(mad(mad((-0.0f) - fragment_unnamed_5759, 2.0f, 3.0f) * (fragment_unnamed_5759 * fragment_unnamed_5759), min(mad((-0.0f) - abs(mad(clamp(fragment_unnamed_5658, 0.0f, 1.0f), 2.0f, -1.0f)), 2.0f, 2.0f), 1.0f) + (-1.0f), 1.0f)) : 1065353216u) * asfloat((((((fragment_unnamed_291 < fragment_unnamed_5657) ? 4294967295u : 0u) & 1u) ^ (((fragment_unnamed_5657 < 0.5f) ? 4294967295u : 0u) & 1u)) != 0u) ? asuint(mad(mad((-0.0f) - fragment_unnamed_5758, 2.0f, 3.0f) * (fragment_unnamed_5758 * fragment_unnamed_5758), min(mad((-0.0f) - abs(mad(clamp(fragment_unnamed_5657, 0.0f, 1.0f), 2.0f, -1.0f)), 2.0f, 2.0f), 1.0f) + (-1.0f), 1.0f)) : 1065353216u)) * asfloat(fragment_unnamed_5100 & 1065353216u);
										fragment_unnamed_5797 = fragment_unnamed_5723.x;
										fragment_unnamed_5799 = fragment_unnamed_5723.y;
										fragment_unnamed_5801 = fragment_unnamed_5723.z;
									}
									else
									{
										fragment_unnamed_5795 = asfloat(0u);
										fragment_unnamed_5797 = asfloat(0u);
										fragment_unnamed_5799 = asfloat(0u);
										fragment_unnamed_5801 = asfloat(0u);
									}
									fragment_unnamed_5794 = fragment_unnamed_5795;
									fragment_unnamed_5796 = fragment_unnamed_5797;
									fragment_unnamed_5798 = fragment_unnamed_5799;
									fragment_unnamed_5800 = fragment_unnamed_5801;
								}
								else
								{
									float fragment_unnamed_5109 = 1.0f / max(dot(float3(abs(fragment_unnamed_4356), abs(fragment_unnamed_4358), abs(fragment_unnamed_4360)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
									float fragment_unnamed_5114 = clamp((-0.0f) - (fragment_unnamed_5109 * fragment_unnamed_4360), 0.0f, 1.0f);
									float fragment_unnamed_5117 = (-0.0f) - fragment_unnamed_5114;
									float fragment_unnamed_5133 = exp2(max(mad(fragment_unnamed_4388, 6.0f, (-0.0f) - fragment_uniform_buffer_0[124u].z), 0.0f));
									uint fragment_unnamed_5146 = fragment_unnamed_4392 + 80u;
									uint fragment_unnamed_5154 = fragment_unnamed_4392 + 80u;
									float4 fragment_unnamed_5164 = _ReflectionAtlas.SampleLevel(S1, float3(mad(clamp(mad(mad(fragment_unnamed_4356, fragment_unnamed_5109, ((fragment_unnamed_5109 * fragment_unnamed_4356) >= 0.0f) ? fragment_unnamed_5114 : fragment_unnamed_5117), 0.5f, 0.5f), 0.0f, 1.0f), mad((-0.0f) - fragment_uniform_buffer_0[124u].x, fragment_unnamed_5133, fragment_uniform_buffer_2[fragment_unnamed_5146].x), mad(fragment_unnamed_5133 * fragment_uniform_buffer_0[124u].x, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5154].z)), mad(clamp(mad(mad(fragment_unnamed_4358, fragment_unnamed_5109, ((fragment_unnamed_5109 * fragment_unnamed_4358) >= 0.0f) ? fragment_unnamed_5114 : fragment_unnamed_5117), 0.5f, 0.5f), 0.0f, 1.0f), mad((-0.0f) - fragment_uniform_buffer_0[124u].y, fragment_unnamed_5133, fragment_uniform_buffer_2[fragment_unnamed_5146].y), mad(fragment_unnamed_5133 * fragment_uniform_buffer_0[124u].y, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5154].w)), fragment_unnamed_1759), fragment_unnamed_4389);
									fragment_unnamed_5794 = asfloat(1065353216u);
									fragment_unnamed_5796 = fragment_unnamed_5164.x;
									fragment_unnamed_5798 = fragment_unnamed_5164.y;
									fragment_unnamed_5800 = fragment_unnamed_5164.z;
								}
								float fragment_unnamed_5811 = mad(fragment_unnamed_4366, fragment_unnamed_5794, fragment_unnamed_1940);
								float fragment_unnamed_3589 = clamp(fragment_unnamed_5811, 0.0f, 1.0f);
								float fragment_unnamed_5816 = mad(fragment_unnamed_4366, fragment_unnamed_5794, (-0.0f) - clamp(((-0.0f) - fragment_unnamed_3589) + fragment_unnamed_5811, 0.0f, 1.0f));
								fragment_unnamed_3043 = fragment_unnamed_3589;
								fragment_unnamed_3044 = mad(fragment_unnamed_5816 * (fragment_unnamed_1201 * (fragment_unnamed_3475 * min(fragment_unnamed_5796, 65504.0f))), fragment_unnamed_3459, fragment_unnamed_1944);
								fragment_unnamed_3045 = mad(fragment_unnamed_5816 * (fragment_unnamed_1201 * (fragment_unnamed_3475 * min(fragment_unnamed_5798, 65504.0f))), fragment_unnamed_3459, fragment_unnamed_1946);
								fragment_unnamed_3046 = mad(fragment_unnamed_5816 * (fragment_unnamed_1201 * (fragment_unnamed_3475 * min(fragment_unnamed_5800, 65504.0f))), fragment_unnamed_3459, fragment_unnamed_1948);
							}
							else
							{
								fragment_unnamed_3043 = fragment_unnamed_1940;
								fragment_unnamed_3044 = fragment_unnamed_1944;
								fragment_unnamed_3045 = fragment_unnamed_1946;
								fragment_unnamed_3046 = fragment_unnamed_1948;
							}
							fragment_unnamed_1941 = fragment_unnamed_3043;
							fragment_unnamed_1945 = fragment_unnamed_3044;
							fragment_unnamed_1947 = fragment_unnamed_3045;
							fragment_unnamed_1949 = fragment_unnamed_3046;
							fragment_unnamed_1940 = fragment_unnamed_1941;
							fragment_unnamed_1942 = fragment_unnamed_1943;
							fragment_unnamed_1944 = fragment_unnamed_1945;
							fragment_unnamed_1946 = fragment_unnamed_1947;
							fragment_unnamed_1948 = fragment_unnamed_1949;
							continue;
						}
					}
					if (ladder_phi_33)
					{
						break;
					}
					break;
				}
				float fragment_unnamed_2617;
				float fragment_unnamed_2619;
				float fragment_unnamed_2621;
				if (asuint(fragment_uniform_buffer_0[116u]).x != 0u)
				{
					float fragment_unnamed_2618;
					float fragment_unnamed_2620;
					float fragment_unnamed_2622;
					if (fragment_unnamed_1940 < 1.0f)
					{
						float fragment_unnamed_2938 = asfloat((asuint(fragment_uniform_buffer_0[117u]).x != 0u) ? 1065353216u : 0u);
						float fragment_unnamed_2940 = mad((-0.0f) - fragment_unnamed_1154, fragment_unnamed_1154, 1.0f);
						float fragment_unnamed_2947 = clamp(mad(fragment_unnamed_2940, fragment_unnamed_2940, fragment_unnamed_2940 * (fragment_unnamed_1158 * fragment_unnamed_1158)), 0.0f, 1.0f) * mad(fragment_unnamed_1154, fragment_unnamed_1154, sqrt(fragment_unnamed_2940));
						float fragment_unnamed_2954 = mad(fragment_unnamed_2947, mad((-0.0f) - fragment_unnamed_870, fragment_unnamed_877, fragment_unnamed_1221), fragment_unnamed_878);
						float fragment_unnamed_2955 = mad(fragment_unnamed_2947, mad((-0.0f) - fragment_unnamed_871, fragment_unnamed_877, fragment_unnamed_1222), fragment_unnamed_879);
						float fragment_unnamed_2956 = mad(fragment_unnamed_2947, mad((-0.0f) - fragment_unnamed_872, fragment_unnamed_877, fragment_unnamed_1223), fragment_unnamed_880);
						float fragment_unnamed_2957 = min(fragment_unnamed_1208, 1.0f);
						float fragment_unnamed_2961 = min((fragment_unnamed_2957 * fragment_unnamed_2957) * mad(fragment_unnamed_2957, -2.0f, 3.0f), 1.0f);
						float fragment_unnamed_2968 = mad(fragment_unnamed_2961, ((-0.0f) - fragment_unnamed_2954) + fragment_unnamed_1221, fragment_unnamed_2954);
						float fragment_unnamed_2969 = mad(fragment_unnamed_2961, ((-0.0f) - fragment_unnamed_2955) + fragment_unnamed_1222, fragment_unnamed_2955);
						float fragment_unnamed_2970 = mad(fragment_unnamed_2961, ((-0.0f) - fragment_unnamed_2956) + fragment_unnamed_1223, fragment_unnamed_2956);
						float fragment_unnamed_2978 = asfloat(0u);
						float4 fragment_unnamed_2981 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_2968, fragment_unnamed_2969, fragment_unnamed_2970, fragment_unnamed_2978), (mad((-0.0f) - fragment_unnamed_1154, 0.699999988079071044921875f, 1.7000000476837158203125f) * fragment_unnamed_1154) * 6.0f);
						float fragment_unnamed_2986 = min(fragment_unnamed_2981.x, 65504.0f);
						float fragment_unnamed_2988 = min(fragment_unnamed_2981.y, 65504.0f);
						float fragment_unnamed_2989 = min(fragment_unnamed_2981.z, 65504.0f);
						float fragment_unnamed_3178;
						float fragment_unnamed_3180;
						float fragment_unnamed_3182;
						if (asuint(fragment_uniform_buffer_0[84u]).x != 0u)
						{
							float fragment_unnamed_3100 = dot(float3(fragment_unnamed_2968, fragment_unnamed_2969, fragment_unnamed_2970), float3(fragment_uniform_buffer_0[83u].xyz));
							float fragment_unnamed_3116 = max(abs(fragment_unnamed_3100), 0.001000000047497451305389404296875f);
							float fragment_unnamed_3117 = 1.0f / fragment_unnamed_3116;
							float fragment_unnamed_3122 = min(mad(fragment_uniform_buffer_0[84u].w, fragment_unnamed_3100, fragment_unnamed_1561), fragment_unnamed_1561);
							float fragment_unnamed_3139 = min(max(fragment_unnamed_3117 * (((-0.0f) - fragment_unnamed_3122) + fragment_uniform_buffer_0[89u].y), 0.0f), fragment_uniform_buffer_0[84u].w);
							float fragment_unnamed_3173 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_3116 * ((-0.0f) - (((-0.0f) - fragment_unnamed_3139) + fragment_uniform_buffer_0[84u].w))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_3122 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_3117 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_3139) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_4120;
							float fragment_unnamed_4121;
							float fragment_unnamed_4122;
							if (fragment_uniform_buffer_0[86u].x == 1.0f)
							{
								float4 fragment_unnamed_3793 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_2968, fragment_unnamed_2969, fragment_unnamed_2970, fragment_unnamed_2978), mad((-0.0f) - fragment_uniform_buffer_0[87u].z, clamp((fragment_uniform_buffer_0[84u].w + ((-0.0f) - fragment_uniform_buffer_0[87u].x)) / (((-0.0f) - fragment_uniform_buffer_0[87u].x) + fragment_uniform_buffer_0[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_4120 = fragment_unnamed_3793.z * fragment_uniform_buffer_0[85u].z;
								fragment_unnamed_4121 = fragment_unnamed_3793.y * fragment_uniform_buffer_0[85u].y;
								fragment_unnamed_4122 = fragment_unnamed_3793.x * fragment_uniform_buffer_0[85u].x;
							}
							else
							{
								uint4 fragment_unnamed_3809 = asuint(fragment_uniform_buffer_0[85u]);
								fragment_unnamed_4120 = asfloat(fragment_unnamed_3809.z);
								fragment_unnamed_4121 = asfloat(fragment_unnamed_3809.y);
								fragment_unnamed_4122 = asfloat(fragment_unnamed_3809.x);
							}
							float fragment_unnamed_4127 = ((-0.0f) - fragment_unnamed_3173) + 1.0f;
							fragment_unnamed_3178 = mad(fragment_unnamed_2989, fragment_unnamed_3173, fragment_unnamed_4127 * ((fragment_uniform_buffer_0[88u].z / fragment_uniform_buffer_0[89u].x) * fragment_unnamed_4120));
							fragment_unnamed_3180 = mad(fragment_unnamed_2988, fragment_unnamed_3173, fragment_unnamed_4127 * ((fragment_uniform_buffer_0[88u].y / fragment_uniform_buffer_0[89u].x) * fragment_unnamed_4121));
							fragment_unnamed_3182 = mad(fragment_unnamed_2986, fragment_unnamed_3173, fragment_unnamed_4127 * ((fragment_uniform_buffer_0[88u].x / fragment_uniform_buffer_0[89u].x) * fragment_unnamed_4122));
						}
						else
						{
							fragment_unnamed_3178 = fragment_unnamed_2989;
							fragment_unnamed_3180 = fragment_unnamed_2988;
							fragment_unnamed_3182 = fragment_unnamed_2986;
						}
						float fragment_unnamed_3187 = fragment_unnamed_1940 + 1.0f;
						float fragment_unnamed_3193 = ((-0.0f) - clamp(fragment_unnamed_3187 + ((-0.0f) - clamp(fragment_unnamed_3187, 0.0f, 1.0f)), 0.0f, 1.0f)) + 1.0f;
						fragment_unnamed_2618 = mad(fragment_unnamed_3193 * (fragment_unnamed_3182 * fragment_unnamed_1201), fragment_unnamed_2938, fragment_unnamed_1944);
						fragment_unnamed_2620 = mad(fragment_unnamed_3193 * (fragment_unnamed_3180 * fragment_unnamed_1201), fragment_unnamed_2938, fragment_unnamed_1946);
						fragment_unnamed_2622 = mad(fragment_unnamed_3193 * (fragment_unnamed_3178 * fragment_unnamed_1201), fragment_unnamed_2938, fragment_unnamed_1948);
					}
					else
					{
						fragment_unnamed_2618 = fragment_unnamed_1944;
						fragment_unnamed_2620 = fragment_unnamed_1946;
						fragment_unnamed_2622 = fragment_unnamed_1948;
					}
					fragment_unnamed_2617 = fragment_unnamed_2618;
					fragment_unnamed_2619 = fragment_unnamed_2620;
					fragment_unnamed_2621 = fragment_unnamed_2622;
				}
				else
				{
					fragment_unnamed_2617 = fragment_unnamed_1944;
					fragment_unnamed_2619 = fragment_unnamed_1946;
					fragment_unnamed_2621 = fragment_unnamed_1948;
				}
				float fragment_unnamed_2634 = ((-0.0f) - fragment_unnamed_1561) + fragment_uniform_buffer_0[89u].y;
				float fragment_unnamed_2643 = exp2((((-0.0f) - max(fragment_unnamed_1561 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f);
				uint fragment_unnamed_2649 = (fragment_uniform_buffer_0[218u].w == 1.0f) ? 4294967295u : 0u;
				float fragment_unnamed_2664 = fragment_input_6.x + ((-0.0f) - fragment_uniform_buffer_0[218u].x);
				float fragment_unnamed_2665 = fragment_input_6.y + ((-0.0f) - fragment_uniform_buffer_0[218u].y);
				float fragment_unnamed_2666 = fragment_input_6.z + ((-0.0f) - fragment_uniform_buffer_0[218u].z);
				float fragment_unnamed_2682 = fragment_input_6.x + ((-0.0f) - fragment_uniform_buffer_0[82u].x);
				float fragment_unnamed_2683 = fragment_input_6.y + ((-0.0f) - fragment_uniform_buffer_0[82u].y);
				float fragment_unnamed_2684 = fragment_input_6.z + ((-0.0f) - fragment_uniform_buffer_0[82u].z);
				float fragment_unnamed_2691 = fragment_uniform_buffer_0[82u].w + fragment_uniform_buffer_4[12u].w;
				float fragment_unnamed_2696 = mad((-0.0f) - fragment_unnamed_2691, fragment_unnamed_2691, dot(float3(fragment_unnamed_2682, fragment_unnamed_2683, fragment_unnamed_2684), float3(fragment_unnamed_2682, fragment_unnamed_2683, fragment_unnamed_2684)));
				float fragment_unnamed_2697 = dot(fragment_unnamed_778.xx, fragment_unnamed_778.xx);
				float fragment_unnamed_2700 = asfloat(0u);
				float fragment_unnamed_2999;
				float fragment_unnamed_3001;
				float fragment_unnamed_3003;
				float fragment_unnamed_3005;
				float fragment_unnamed_3007;
				float fragment_unnamed_3009;
				fragment_unnamed_2999 = fragment_unnamed_1607;
				fragment_unnamed_3001 = fragment_unnamed_1617;
				fragment_unnamed_3003 = fragment_unnamed_1613;
				fragment_unnamed_3005 = fragment_unnamed_1615;
				fragment_unnamed_3007 = fragment_unnamed_1609;
				fragment_unnamed_3009 = fragment_unnamed_1611;
				float fragment_unnamed_3000;
				float fragment_unnamed_3002;
				float fragment_unnamed_3004;
				float fragment_unnamed_3006;
				float fragment_unnamed_3008;
				float fragment_unnamed_3010;
				for (float fragment_unnamed_3011 = fragment_unnamed_2700; !(asuint(fragment_unnamed_3011) >= asuint(fragment_uniform_buffer_0[114u]).x); fragment_unnamed_2999 = fragment_unnamed_3000, fragment_unnamed_3001 = fragment_unnamed_3002, fragment_unnamed_3003 = fragment_unnamed_3004, fragment_unnamed_3005 = fragment_unnamed_3006, fragment_unnamed_3007 = fragment_unnamed_3008, fragment_unnamed_3009 = fragment_unnamed_3010, fragment_unnamed_3011 = asfloat(asuint(fragment_unnamed_3011) + 1u))
				{
					float frontier_phi_62_pred;
					float frontier_phi_62_pred_1;
					float frontier_phi_62_pred_2;
					float frontier_phi_62_pred_3;
					float frontier_phi_62_pred_4;
					float frontier_phi_62_pred_5;
					if ((fragment_unnamed_885 & T6.Load((asuint(fragment_unnamed_3011) * 44u) + 3u).x) != 0u)
					{
						uint fragment_unnamed_3833 = (asuint(fragment_unnamed_3011) * 44u) + 4u;
						uint4 fragment_unnamed_3845 = uint4(T6.Load(fragment_unnamed_3833).x, T6.Load(fragment_unnamed_3833 + 1u).x, T6.Load(fragment_unnamed_3833 + 2u).x, T6.Load(fragment_unnamed_3833 + 3u).x);
						float fragment_unnamed_3847 = asfloat(fragment_unnamed_3845.x);
						float fragment_unnamed_3849 = asfloat(fragment_unnamed_3845.y);
						float fragment_unnamed_3851 = asfloat(fragment_unnamed_3845.z);
						uint fragment_unnamed_3852 = fragment_unnamed_3845.w;
						uint fragment_unnamed_3855 = (asuint(fragment_unnamed_3011) * 44u) + 36u;
						uint3 fragment_unnamed_3864 = uint3(T6.Load(fragment_unnamed_3855).x, T6.Load(fragment_unnamed_3855 + 1u).x, T6.Load(fragment_unnamed_3855 + 2u).x);
						float fragment_unnamed_3866 = asfloat(fragment_unnamed_3864.x);
						float fragment_unnamed_3868 = asfloat(fragment_unnamed_3864.y);
						float fragment_unnamed_3876 = dot(float3(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880), float3((-0.0f) - fragment_unnamed_3847, (-0.0f) - fragment_unnamed_3849, (-0.0f) - fragment_unnamed_3851));
						float fragment_unnamed_5031;
						float fragment_unnamed_5033;
						float fragment_unnamed_5035;
						float fragment_unnamed_5037;
						float fragment_unnamed_5039;
						float fragment_unnamed_5041;
						if ((((0.0f < asfloat(fragment_unnamed_3864.z)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_3876) ? 4294967295u : 0u)) != 0u)
						{
							uint fragment_unnamed_4234 = (asuint(fragment_unnamed_3011) * 44u) + 12u;
							uint4 fragment_unnamed_4246 = uint4(T6.Load(fragment_unnamed_4234).x, T6.Load(fragment_unnamed_4234 + 1u).x, T6.Load(fragment_unnamed_4234 + 2u).x, T6.Load(fragment_unnamed_4234 + 3u).x);
							float fragment_unnamed_4248 = asfloat(fragment_unnamed_4246.x);
							float fragment_unnamed_4250 = asfloat(fragment_unnamed_4246.y);
							float fragment_unnamed_4252 = asfloat(fragment_unnamed_4246.z);
							uint fragment_unnamed_4256 = (asuint(fragment_unnamed_3011) * 44u) + 16u;
							uint3 fragment_unnamed_4265 = uint3(T6.Load(fragment_unnamed_4256).x, T6.Load(fragment_unnamed_4256 + 1u).x, T6.Load(fragment_unnamed_4256 + 2u).x);
							float fragment_unnamed_4267 = asfloat(fragment_unnamed_4265.x);
							float fragment_unnamed_4269 = asfloat(fragment_unnamed_4265.y);
							float fragment_unnamed_4271 = asfloat(fragment_unnamed_4265.z);
							uint fragment_unnamed_4274 = (asuint(fragment_unnamed_3011) * 44u) + 20u;
							uint3 fragment_unnamed_4283 = uint3(T6.Load(fragment_unnamed_4274).x, T6.Load(fragment_unnamed_4274 + 1u).x, T6.Load(fragment_unnamed_4274 + 2u).x);
							float fragment_unnamed_4285 = asfloat(fragment_unnamed_4283.x);
							float fragment_unnamed_4287 = asfloat(fragment_unnamed_4283.y);
							float fragment_unnamed_4289 = asfloat(fragment_unnamed_4283.z);
							uint fragment_unnamed_4292 = (asuint(fragment_unnamed_3011) * 44u) + 24u;
							uint4 fragment_unnamed_4304 = uint4(T6.Load(fragment_unnamed_4292).x, T6.Load(fragment_unnamed_4292 + 1u).x, T6.Load(fragment_unnamed_4292 + 2u).x, T6.Load(fragment_unnamed_4292 + 3u).x);
							float fragment_unnamed_4306 = asfloat(fragment_unnamed_4304.x);
							float fragment_unnamed_4308 = asfloat(fragment_unnamed_4304.y);
							float fragment_unnamed_4310 = asfloat(fragment_unnamed_4304.z);
							float fragment_unnamed_4312 = asfloat(fragment_unnamed_4304.w);
							float fragment_unnamed_4318 = asfloat(T6.Load((asuint(fragment_unnamed_3011) * 44u) + 40u).x);
							float fragment_unnamed_4331 = 1.0f / max(dot(float3((-0.0f) - fragment_unnamed_3847, (-0.0f) - fragment_unnamed_3849, (-0.0f) - fragment_unnamed_3851), float3(fragment_uniform_buffer_0[83u].xyz)), 0.001000000047497451305389404296875f);
							float fragment_unnamed_4344 = exp2((mad(fragment_unnamed_2643, fragment_unnamed_4331 * fragment_uniform_buffer_0[90u].y, max(fragment_unnamed_2634 * fragment_unnamed_4331, 0.0f)) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_5021;
							float fragment_unnamed_5022;
							float fragment_unnamed_5023;
							if (fragment_unnamed_3852 != 0u)
							{
								uint fragment_unnamed_4906 = asuint(fragment_unnamed_3011) * 44u;
								uint3 fragment_unnamed_4915 = uint3(T6.Load(fragment_unnamed_4906).x, T6.Load(fragment_unnamed_4906 + 1u).x, T6.Load(fragment_unnamed_4906 + 2u).x);
								uint fragment_unnamed_4924 = (asuint(fragment_unnamed_3011) * 44u) + 8u;
								uint4 fragment_unnamed_4936 = uint4(T6.Load(fragment_unnamed_4924).x, T6.Load(fragment_unnamed_4924 + 1u).x, T6.Load(fragment_unnamed_4924 + 2u).x, T6.Load(fragment_unnamed_4924 + 3u).x);
								float fragment_unnamed_4938 = asfloat(fragment_unnamed_4936.x);
								float fragment_unnamed_4940 = asfloat(fragment_unnamed_4936.y);
								float fragment_unnamed_4954 = ((-0.0f) - asfloat(fragment_unnamed_4915.x)) + fragment_input_6.x;
								float fragment_unnamed_4955 = ((-0.0f) - asfloat(fragment_unnamed_4915.y)) + fragment_input_6.y;
								float fragment_unnamed_4956 = ((-0.0f) - asfloat(fragment_unnamed_4915.z)) + fragment_input_6.z;
								float fragment_unnamed_4963 = mad(dot(float3(fragment_unnamed_4954, fragment_unnamed_4955, fragment_unnamed_4956), float3(fragment_unnamed_4248, fragment_unnamed_4250, fragment_unnamed_4252)), 0.5f, 0.5f);
								float fragment_unnamed_4964 = mad(dot(float3(fragment_unnamed_4954, fragment_unnamed_4955, fragment_unnamed_4956), float3(fragment_unnamed_4267, fragment_unnamed_4269, fragment_unnamed_4271)), 0.5f, 0.5f);
								bool fragment_unnamed_4965 = fragment_unnamed_3852 == 2u;
								float fragment_unnamed_4981 = 1.0f / (fragment_unnamed_4938 + fragment_uniform_buffer_0[123u].y);
								float fragment_unnamed_4982 = 1.0f / (fragment_unnamed_4940 + fragment_uniform_buffer_0[123u].y);
								float fragment_unnamed_4994 = fragment_unnamed_4938 * fragment_uniform_buffer_0[123u].x;
								float fragment_unnamed_4995 = fragment_unnamed_4940 * fragment_uniform_buffer_0[123u].x;
								float fragment_unnamed_4998 = fragment_unnamed_1572 / (fragment_unnamed_4994 + fragment_unnamed_4994);
								float fragment_unnamed_4999 = fragment_unnamed_1572 / (fragment_unnamed_4995 + fragment_unnamed_4995);
								float4 fragment_unnamed_5013 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_4998) + 1.0f, max(fragment_unnamed_4998, mad(asfloat(fragment_unnamed_4965 ? asuint(frac(fragment_unnamed_4963)) : asuint(fragment_unnamed_4963)), fragment_unnamed_4938 * fragment_unnamed_4981, mad((-0.0f) - fragment_unnamed_4981, fragment_unnamed_4938, 1.0f) * 0.5f))), fragment_unnamed_4938, asfloat(fragment_unnamed_4936.z)), mad(min(((-0.0f) - fragment_unnamed_4999) + 1.0f, max(fragment_unnamed_4999, mad(asfloat(fragment_unnamed_4965 ? asuint(frac(fragment_unnamed_4964)) : asuint(fragment_unnamed_4964)), fragment_unnamed_4940 * fragment_unnamed_4982, mad((-0.0f) - fragment_unnamed_4982, fragment_unnamed_4940, 1.0f) * 0.5f))), fragment_unnamed_4940, asfloat(fragment_unnamed_4936.w))), 0.0f);
								fragment_unnamed_5021 = fragment_unnamed_4285 * fragment_unnamed_5013.x;
								fragment_unnamed_5022 = fragment_unnamed_4287 * fragment_unnamed_5013.y;
								fragment_unnamed_5023 = fragment_unnamed_4289 * fragment_unnamed_5013.z;
							}
							else
							{
								fragment_unnamed_5021 = fragment_unnamed_4285;
								fragment_unnamed_5022 = fragment_unnamed_4287;
								fragment_unnamed_5023 = fragment_unnamed_4289;
							}
							uint fragment_unnamed_5028 = (int(fragment_unnamed_4246.w) >= int(0u)) ? 4294967295u : 0u;
							float fragment_unnamed_6438;
							float fragment_unnamed_6439;
							float fragment_unnamed_6440;
							if ((fragment_unnamed_2649 & fragment_unnamed_5028) != 0u)
							{
								float fragment_unnamed_5560 = rsqrt(dot(float3(fragment_unnamed_4248, fragment_unnamed_4250, fragment_unnamed_4252), float3(fragment_unnamed_4248, fragment_unnamed_4250, fragment_unnamed_4252)));
								float fragment_unnamed_5564 = dot(float3(fragment_unnamed_2664, fragment_unnamed_2665, fragment_unnamed_2666), float3(fragment_unnamed_5560 * fragment_unnamed_4248, fragment_unnamed_5560 * fragment_unnamed_4250, fragment_unnamed_5560 * fragment_unnamed_4252));
								float fragment_unnamed_5574 = clamp(fragment_unnamed_5564 / fragment_uniform_buffer_0[217u].x, 0.0f, 1.0f);
								float fragment_unnamed_5578 = rsqrt(dot(float3(fragment_unnamed_4267, fragment_unnamed_4269, fragment_unnamed_4271), float3(fragment_unnamed_4267, fragment_unnamed_4269, fragment_unnamed_4271)));
								float fragment_unnamed_5582 = dot(float3(fragment_unnamed_2664, fragment_unnamed_2665, fragment_unnamed_2666), float3(fragment_unnamed_5578 * fragment_unnamed_4267, fragment_unnamed_5578 * fragment_unnamed_4269, fragment_unnamed_5578 * fragment_unnamed_4271));
								float fragment_unnamed_5591 = clamp(fragment_unnamed_5582 / fragment_uniform_buffer_0[217u].y, 0.0f, 1.0f);
								float fragment_unnamed_5592 = dot(float3(fragment_unnamed_3847, fragment_unnamed_3849, fragment_unnamed_3851), float3(fragment_unnamed_3847, fragment_unnamed_3849, fragment_unnamed_3851));
								float fragment_unnamed_5595 = dot(float3(fragment_unnamed_3847, fragment_unnamed_3849, fragment_unnamed_3851), float3(fragment_unnamed_2682, fragment_unnamed_2683, fragment_unnamed_2684));
								float fragment_unnamed_5598 = fragment_unnamed_5595 + fragment_unnamed_5595;
								float4 fragment_unnamed_5614 = _VolumetricCloudsShadowsTexture.SampleLevel(S0, float2(fragment_unnamed_5574, fragment_unnamed_5591), 0.0f);
								float fragment_unnamed_5616 = fragment_unnamed_5614.x;
								float fragment_unnamed_5617 = fragment_unnamed_5614.y;
								float fragment_unnamed_5648 = asfloat((((((fragment_unnamed_5591 != 1.0f) ? 4294967295u : 0u) & ((fragment_unnamed_5574 != 1.0f) ? 4294967295u : 0u)) & (((clamp(fragment_unnamed_5582 / fragment_uniform_buffer_0[217u].y, 0.0f, 1.0f) != 0.0f) ? 4294967295u : 0u) & ((clamp(fragment_unnamed_5564 / fragment_uniform_buffer_0[217u].x, 0.0f, 1.0f) != 0.0f) ? 4294967295u : 0u))) != 0u) ? ((fragment_unnamed_5617 != 1.0f) ? asuint(mad(clamp(((mad((-0.0f) - float(int(-((0.0f < fragment_unnamed_5592) ? 4294967295u : 0u))), sqrt(mad(fragment_unnamed_5598, fragment_unnamed_5598, (-0.0f) - ((fragment_unnamed_2696 * fragment_unnamed_5592) * 4.0f))), (-0.0f) - fragment_unnamed_5598) / (fragment_unnamed_5592 + fragment_unnamed_5592)) + ((-0.0f) - fragment_unnamed_5616)) / (((-0.0f) - fragment_unnamed_5616) + fragment_unnamed_5614.z), 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_5617) + 1.0f, fragment_unnamed_5617)) : 1065353216u) : asuint(fragment_uniform_buffer_0[217u]).w);
								fragment_unnamed_6438 = fragment_unnamed_1462 * fragment_unnamed_5648;
								fragment_unnamed_6439 = fragment_unnamed_1464 * fragment_unnamed_5648;
								fragment_unnamed_6440 = fragment_unnamed_1466 * fragment_unnamed_5648;
							}
							else
							{
								fragment_unnamed_6438 = fragment_unnamed_1462;
								fragment_unnamed_6439 = fragment_unnamed_1464;
								fragment_unnamed_6440 = fragment_unnamed_1466;
							}
							bool fragment_unnamed_6450 = (((0.0f < fragment_unnamed_4312) ? 4294967295u : 0u) & fragment_unnamed_5028) != 0u;
							float fragment_unnamed_6455 = asfloat(fragment_unnamed_6450 ? asuint(mad(fragment_unnamed_4312, fragment_unnamed_6438 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6457 = asfloat(fragment_unnamed_6450 ? asuint(mad(fragment_unnamed_4312, fragment_unnamed_6439 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6459 = asfloat(fragment_unnamed_6450 ? asuint(mad(fragment_unnamed_4312, fragment_unnamed_6440 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6472 = asfloat((fragment_unnamed_3876 >= 0.0f) ? asuint(mad(fragment_uniform_buffer_0[121u].x, clamp((fragment_unnamed_2697 + fragment_unnamed_3876) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6473 = fragment_unnamed_6472 * fragment_unnamed_6455;
							float fragment_unnamed_6474 = fragment_unnamed_6472 * fragment_unnamed_6457;
							float fragment_unnamed_6475 = fragment_unnamed_6472 * fragment_unnamed_6459;
							float fragment_unnamed_6479 = ((-0.0f) - fragment_unnamed_4306) + 1.0f;
							float fragment_unnamed_6480 = ((-0.0f) - fragment_unnamed_4308) + 1.0f;
							float fragment_unnamed_6481 = ((-0.0f) - fragment_unnamed_4310) + 1.0f;
							float fragment_unnamed_6497 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6455, fragment_unnamed_6472, 1.0f), fragment_unnamed_6479, 1.0f);
							float fragment_unnamed_6498 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6457, fragment_unnamed_6472, 1.0f), fragment_unnamed_6480, 1.0f);
							float fragment_unnamed_6499 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6459, fragment_unnamed_6472, 1.0f), fragment_unnamed_6481, 1.0f);
							float fragment_unnamed_6515 = mad(fragment_unnamed_4318, ((-0.0f) - fragment_unnamed_6497) + mad(fragment_unnamed_6473 * (fragment_unnamed_6473 * fragment_unnamed_6473), fragment_unnamed_6479, fragment_unnamed_4306 * fragment_unnamed_6473), fragment_unnamed_6497) * (fragment_unnamed_4344 * fragment_unnamed_5021);
							float fragment_unnamed_6516 = mad(fragment_unnamed_4318, ((-0.0f) - fragment_unnamed_6498) + mad(fragment_unnamed_6474 * (fragment_unnamed_6474 * fragment_unnamed_6474), fragment_unnamed_6480, fragment_unnamed_4308 * fragment_unnamed_6474), fragment_unnamed_6498) * (fragment_unnamed_4344 * fragment_unnamed_5022);
							float fragment_unnamed_6517 = mad(fragment_unnamed_4318, ((-0.0f) - fragment_unnamed_6499) + mad(fragment_unnamed_6475 * (fragment_unnamed_6475 * fragment_unnamed_6475), fragment_unnamed_6481, fragment_unnamed_4310 * fragment_unnamed_6475), fragment_unnamed_6499) * (fragment_unnamed_4344 * fragment_unnamed_5023);
							float fragment_unnamed_5032;
							float fragment_unnamed_5034;
							float fragment_unnamed_5036;
							float fragment_unnamed_5038;
							float fragment_unnamed_5040;
							float fragment_unnamed_5042;
							if (0.0f < max(fragment_unnamed_6517, max(fragment_unnamed_6516, fragment_unnamed_6515)))
							{
								float fragment_unnamed_6878 = max(fragment_unnamed_1200, asfloat(T6.Load((asuint(fragment_unnamed_3011) * 44u) + 30u).x));
								float fragment_unnamed_6879 = clamp(fragment_unnamed_3876, 0.0f, 1.0f);
								float fragment_unnamed_6883 = dot(float3((-0.0f) - fragment_unnamed_3847, (-0.0f) - fragment_unnamed_3849, (-0.0f) - fragment_unnamed_3851), float3(fragment_unnamed_344, fragment_unnamed_345, fragment_unnamed_346));
								float fragment_unnamed_6888 = rsqrt(max(mad(fragment_unnamed_6883, 2.0f, 2.0f), 5.9604644775390625e-08f));
								float fragment_unnamed_6891 = clamp(fragment_unnamed_6888 * (fragment_unnamed_1155 + fragment_unnamed_3876), 0.0f, 1.0f);
								float fragment_unnamed_6895 = ((-0.0f) - clamp(mad(fragment_unnamed_6888, fragment_unnamed_6883, fragment_unnamed_6888), 0.0f, 1.0f)) + 1.0f;
								float fragment_unnamed_6896 = fragment_unnamed_6895 * fragment_unnamed_6895;
								float fragment_unnamed_6897 = fragment_unnamed_6896 * fragment_unnamed_6896;
								float fragment_unnamed_6902 = fragment_unnamed_6878 * fragment_unnamed_6878;
								float fragment_unnamed_6905 = mad(mad(fragment_unnamed_6891, fragment_unnamed_6902, (-0.0f) - fragment_unnamed_6891), fragment_unnamed_6891, 1.0f);
								float fragment_unnamed_6925 = ((-0.0f) - abs(fragment_unnamed_3876)) + 1.0f;
								float fragment_unnamed_6926 = fragment_unnamed_6925 * fragment_unnamed_6925;
								float fragment_unnamed_6929 = mad(fragment_unnamed_1154, fragment_unnamed_6883, fragment_unnamed_1154) + (-0.5f);
								float fragment_unnamed_6934 = ((mad(fragment_unnamed_6929, fragment_unnamed_6925 * (fragment_unnamed_6926 * fragment_unnamed_6926), 1.0f) * mad(fragment_unnamed_6929, fragment_unnamed_1574, 1.0f)) * fragment_unnamed_6879) * 0.307334959506988525390625f;
								float fragment_unnamed_6935 = fragment_unnamed_6879 * (((fragment_unnamed_6902 * 0.15915493667125701904296875f) / max((fragment_unnamed_6905 * fragment_unnamed_6905) * mad(abs(fragment_unnamed_3876), fragment_unnamed_1212, fragment_unnamed_1158 * sqrt(mad(mad((-0.0f) - abs(fragment_unnamed_3876), fragment_unnamed_6902, abs(fragment_unnamed_3876)), abs(fragment_unnamed_3876), fragment_unnamed_6902))), 1.1754943508222875079687365372222e-38f)) * mad(mad((-0.0f) - fragment_unnamed_6897, fragment_unnamed_6895, 1.0f), 0.039999999105930328369140625f, fragment_unnamed_6895 * fragment_unnamed_6897));
								fragment_unnamed_5032 = fragment_unnamed_3868 * (fragment_unnamed_6515 * fragment_unnamed_6935);
								fragment_unnamed_5034 = fragment_unnamed_3868 * (fragment_unnamed_6516 * fragment_unnamed_6935);
								fragment_unnamed_5036 = fragment_unnamed_3868 * (fragment_unnamed_6517 * fragment_unnamed_6935);
								fragment_unnamed_5038 = fragment_unnamed_3866 * (fragment_unnamed_6515 * fragment_unnamed_6934);
								fragment_unnamed_5040 = fragment_unnamed_3866 * (fragment_unnamed_6516 * fragment_unnamed_6934);
								fragment_unnamed_5042 = fragment_unnamed_3866 * (fragment_unnamed_6517 * fragment_unnamed_6934);
							}
							else
							{
								fragment_unnamed_5032 = asfloat(0u);
								fragment_unnamed_5034 = asfloat(0u);
								fragment_unnamed_5036 = asfloat(0u);
								fragment_unnamed_5038 = asfloat(0u);
								fragment_unnamed_5040 = asfloat(0u);
								fragment_unnamed_5042 = asfloat(0u);
							}
							fragment_unnamed_5031 = fragment_unnamed_5032;
							fragment_unnamed_5033 = fragment_unnamed_5034;
							fragment_unnamed_5035 = fragment_unnamed_5036;
							fragment_unnamed_5037 = fragment_unnamed_5038;
							fragment_unnamed_5039 = fragment_unnamed_5040;
							fragment_unnamed_5041 = fragment_unnamed_5042;
						}
						else
						{
							fragment_unnamed_5031 = asfloat(0u);
							fragment_unnamed_5033 = asfloat(0u);
							fragment_unnamed_5035 = asfloat(0u);
							fragment_unnamed_5037 = asfloat(0u);
							fragment_unnamed_5039 = asfloat(0u);
							fragment_unnamed_5041 = asfloat(0u);
						}
						frontier_phi_62_pred = fragment_unnamed_3009 + fragment_unnamed_5041;
						frontier_phi_62_pred_1 = fragment_unnamed_5035 + fragment_unnamed_3005;
						frontier_phi_62_pred_2 = fragment_unnamed_5033 + fragment_unnamed_3003;
						frontier_phi_62_pred_3 = fragment_unnamed_5031 + fragment_unnamed_3001;
						frontier_phi_62_pred_4 = fragment_unnamed_2999 + fragment_unnamed_5037;
						frontier_phi_62_pred_5 = fragment_unnamed_3007 + fragment_unnamed_5039;
					}
					else
					{
						frontier_phi_62_pred = fragment_unnamed_3009;
						frontier_phi_62_pred_1 = fragment_unnamed_3005;
						frontier_phi_62_pred_2 = fragment_unnamed_3003;
						frontier_phi_62_pred_3 = fragment_unnamed_3001;
						frontier_phi_62_pred_4 = fragment_unnamed_2999;
						frontier_phi_62_pred_5 = fragment_unnamed_3007;
					}
					fragment_unnamed_3010 = frontier_phi_62_pred;
					fragment_unnamed_3006 = frontier_phi_62_pred_1;
					fragment_unnamed_3004 = frontier_phi_62_pred_2;
					fragment_unnamed_3002 = frontier_phi_62_pred_3;
					fragment_unnamed_3000 = frontier_phi_62_pred_4;
					fragment_unnamed_3008 = frontier_phi_62_pred_5;
				}
				uint4 fragment_unnamed_3197 = T4.Load(((((fragment_unnamed_1531 + fragment_unnamed_1498) * fragment_unnamed_1692) + fragment_unnamed_285) * fragment_unnamed_1700) + fragment_unnamed_283);
				uint fragment_unnamed_3198 = fragment_unnamed_3197.x;
				uint fragment_unnamed_3199 = fragment_unnamed_3198 & 67108863u;
				uint fragment_unnamed_3200 = fragment_unnamed_3198 >> 26u;
				float fragment_unnamed_3202 = mad((-0.0f) - fragment_unnamed_1238, fragment_unnamed_1236, fragment_unnamed_1235);
				float fragment_unnamed_3203 = fragment_unnamed_3202 * fragment_unnamed_1237;
				float fragment_unnamed_3209 = clamp((((-0.0f) - fragment_unnamed_1154) + 0.300000011920928955078125f) * 3.3333332538604736328125f, 0.0f, 1.0f);
				float fragment_unnamed_3211 = mad((-0.0f) - fragment_unnamed_1244, fragment_unnamed_1242, fragment_unnamed_1241);
				float fragment_unnamed_3212 = fragment_unnamed_3211 * fragment_unnamed_1243;
				float fragment_unnamed_3213 = asfloat(fragment_unnamed_1248 ? asuint(fragment_unnamed_1252 * fragment_unnamed_1259) : asuint(fragment_unnamed_1275));
				float fragment_unnamed_3214 = asfloat(fragment_unnamed_1248 ? asuint(fragment_unnamed_1258) : asuint(fragment_unnamed_1276));
				float fragment_unnamed_3215 = asfloat(1065353216u);
				float fragment_unnamed_3216 = asfloat(1065353216u);
				float fragment_unnamed_3217 = asfloat(fragment_unnamed_1248 ? asuint(fragment_unnamed_879) : asuint(mad(fragment_unnamed_878, fragment_unnamed_1275, (-0.0f) - (fragment_unnamed_879 * fragment_unnamed_1274))));
				float fragment_unnamed_3218 = asfloat(1065353216u);
				float fragment_unnamed_3219 = asfloat(1065353216u);
				float fragment_unnamed_3816;
				float fragment_unnamed_3818;
				float fragment_unnamed_3820;
				float fragment_unnamed_3822;
				float fragment_unnamed_3824;
				float fragment_unnamed_3826;
				uint fragment_unnamed_3828;
				for (;;)
				{
					fragment_unnamed_3816 = fragment_unnamed_2999;
					fragment_unnamed_3818 = fragment_unnamed_3007;
					fragment_unnamed_3820 = fragment_unnamed_3009;
					fragment_unnamed_3822 = fragment_unnamed_3001;
					fragment_unnamed_3824 = fragment_unnamed_3003;
					fragment_unnamed_3826 = fragment_unnamed_3005;
					fragment_unnamed_3828 = 0u;
					uint fragment_unnamed_3829;
					float fragment_unnamed_3817;
					float fragment_unnamed_3819;
					float fragment_unnamed_3821;
					float fragment_unnamed_3823;
					float fragment_unnamed_3825;
					float fragment_unnamed_3827;
					bool ladder_phi_84;
					for (;;)
					{
						if (fragment_unnamed_3828 >= fragment_unnamed_3200)
						{
							ladder_phi_84 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_4228 = fragment_unnamed_3199 + fragment_unnamed_3828;
							uint4 fragment_unnamed_4229 = T3.Load(fragment_unnamed_4228);
							uint fragment_unnamed_4230 = fragment_unnamed_4229.x;
							if (fragment_unnamed_4230 == 4294967295u)
							{
								ladder_phi_84 = false;
								break;
							}
							uint fragment_unnamed_4883 = fragment_unnamed_4230 * 56u;
							uint4 fragment_unnamed_4895 = uint4(T7.Load(fragment_unnamed_4883).x, T7.Load(fragment_unnamed_4883 + 1u).x, T7.Load(fragment_unnamed_4883 + 2u).x, T7.Load(fragment_unnamed_4883 + 3u).x);
							fragment_unnamed_3829 = fragment_unnamed_3828 + 1u;
							if (!((fragment_unnamed_885 & fragment_unnamed_4895.w) != 0u))
							{
								fragment_unnamed_3817 = fragment_unnamed_3816;
								fragment_unnamed_3819 = fragment_unnamed_3818;
								fragment_unnamed_3821 = fragment_unnamed_3820;
								fragment_unnamed_3823 = fragment_unnamed_3822;
								fragment_unnamed_3825 = fragment_unnamed_3824;
								fragment_unnamed_3827 = fragment_unnamed_3826;
								fragment_unnamed_3816 = fragment_unnamed_3817;
								fragment_unnamed_3818 = fragment_unnamed_3819;
								fragment_unnamed_3820 = fragment_unnamed_3821;
								fragment_unnamed_3822 = fragment_unnamed_3823;
								fragment_unnamed_3824 = fragment_unnamed_3825;
								fragment_unnamed_3826 = fragment_unnamed_3827;
								fragment_unnamed_3828 = fragment_unnamed_3829;
								continue;
							}
							uint fragment_unnamed_5360 = (fragment_unnamed_4230 * 56u) + 8u;
							uint3 fragment_unnamed_5369 = uint3(T7.Load(fragment_unnamed_5360).x, T7.Load(fragment_unnamed_5360 + 1u).x, T7.Load(fragment_unnamed_5360 + 2u).x);
							uint fragment_unnamed_5377 = (fragment_unnamed_4230 * 56u) + 12u;
							uint4 fragment_unnamed_5389 = uint4(T7.Load(fragment_unnamed_5377).x, T7.Load(fragment_unnamed_5377 + 1u).x, T7.Load(fragment_unnamed_5377 + 2u).x, T7.Load(fragment_unnamed_5377 + 3u).x);
							float fragment_unnamed_5392 = asfloat(fragment_unnamed_5389.y);
							float fragment_unnamed_5394 = asfloat(fragment_unnamed_5389.z);
							float fragment_unnamed_5396 = asfloat(fragment_unnamed_5389.w);
							uint fragment_unnamed_5398 = (fragment_unnamed_4230 * 56u) + 18u;
							uint4 fragment_unnamed_5410 = uint4(T7.Load(fragment_unnamed_5398).x, T7.Load(fragment_unnamed_5398 + 1u).x, T7.Load(fragment_unnamed_5398 + 2u).x, T7.Load(fragment_unnamed_5398 + 3u).x);
							uint fragment_unnamed_5411 = fragment_unnamed_5410.x;
							uint fragment_unnamed_5412 = fragment_unnamed_5410.y;
							uint fragment_unnamed_5416 = (fragment_unnamed_4230 * 56u) + 22u;
							uint4 fragment_unnamed_5428 = uint4(T7.Load(fragment_unnamed_5416).x, T7.Load(fragment_unnamed_5416 + 1u).x, T7.Load(fragment_unnamed_5416 + 2u).x, T7.Load(fragment_unnamed_5416 + 3u).x);
							float fragment_unnamed_5430 = asfloat(fragment_unnamed_5428.z);
							float fragment_unnamed_5432 = asfloat(fragment_unnamed_5428.w);
							uint fragment_unnamed_5437 = (fragment_unnamed_4230 * 56u) + 26u;
							uint4 fragment_unnamed_5449 = uint4(T7.Load(fragment_unnamed_5437).x, T7.Load(fragment_unnamed_5437 + 1u).x, T7.Load(fragment_unnamed_5437 + 2u).x, T7.Load(fragment_unnamed_5437 + 3u).x);
							uint fragment_unnamed_5450 = fragment_unnamed_5449.x;
							float fragment_unnamed_5454 = asfloat(fragment_unnamed_5449.z);
							float fragment_unnamed_5456 = asfloat(fragment_unnamed_5449.w);
							uint fragment_unnamed_5458 = (fragment_unnamed_4230 * 56u) + 30u;
							uint4 fragment_unnamed_5470 = uint4(T7.Load(fragment_unnamed_5458).x, T7.Load(fragment_unnamed_5458 + 1u).x, T7.Load(fragment_unnamed_5458 + 2u).x, T7.Load(fragment_unnamed_5458 + 3u).x);
							float fragment_unnamed_5472 = asfloat(fragment_unnamed_5470.x);
							float fragment_unnamed_5474 = asfloat(fragment_unnamed_5470.y);
							uint fragment_unnamed_5478 = (fragment_unnamed_4230 * 56u) + 44u;
							uint2 fragment_unnamed_5484 = uint2(T7.Load(fragment_unnamed_5478).x, T7.Load(fragment_unnamed_5478 + 1u).x);
							float fragment_unnamed_5486 = asfloat(fragment_unnamed_5484.x);
							float fragment_unnamed_5488 = asfloat(fragment_unnamed_5484.y);
							bool fragment_unnamed_5489 = fragment_unnamed_5389.x == 6u;
							uint fragment_unnamed_5490 = fragment_unnamed_5489 ? 4294967295u : 0u;
							float fragment_unnamed_5500 = asfloat(fragment_unnamed_4895.x) + ((-0.0f) - fragment_input_6.x);
							float fragment_unnamed_5501 = asfloat(fragment_unnamed_4895.y) + ((-0.0f) - fragment_input_6.y);
							float fragment_unnamed_5502 = asfloat(fragment_unnamed_4895.z) + ((-0.0f) - fragment_input_6.z);
							float fragment_unnamed_5503 = fragment_unnamed_5486 * 0.5f;
							float fragment_unnamed_5504 = fragment_unnamed_5488 * 0.5f;
							float fragment_unnamed_5505 = dot(float3(fragment_unnamed_5500, fragment_unnamed_5501, fragment_unnamed_5502), float3(fragment_unnamed_5392, fragment_unnamed_5394, fragment_unnamed_5396));
							float fragment_unnamed_5511 = max(mad((-0.0f) - fragment_unnamed_5486, 0.5f, abs(fragment_unnamed_5505)), 0.0f);
							float fragment_unnamed_5512 = asfloat(fragment_unnamed_5410.z);
							float fragment_unnamed_5513 = asfloat(fragment_unnamed_5410.w);
							float fragment_unnamed_5514 = asfloat(fragment_unnamed_5428.x);
							float fragment_unnamed_5515 = dot(float3(fragment_unnamed_5500, fragment_unnamed_5501, fragment_unnamed_5502), float3(fragment_unnamed_5512, fragment_unnamed_5513, fragment_unnamed_5514));
							float fragment_unnamed_5521 = max(mad((-0.0f) - fragment_unnamed_5488, 0.5f, abs(fragment_unnamed_5515)), 0.0f);
							float fragment_unnamed_5532 = asfloat(fragment_unnamed_5428.y) * mad(fragment_unnamed_5521, fragment_unnamed_5521, mad(fragment_unnamed_5511, fragment_unnamed_5511, max(mad((-0.0f) - fragment_unnamed_5515, fragment_unnamed_5515, mad((-0.0f) - fragment_unnamed_5505, fragment_unnamed_5505, dot(float3(fragment_unnamed_5500, fragment_unnamed_5501, fragment_unnamed_5502), float3(fragment_unnamed_5500, fragment_unnamed_5501, fragment_unnamed_5502)))), 0.0f)));
							float fragment_unnamed_5535 = clamp(mad((-0.0f) - fragment_unnamed_5532, fragment_unnamed_5532, asfloat(fragment_unnamed_5449.y)), 0.0f, 1.0f);
							float fragment_unnamed_5546 = asfloat(((fragment_unnamed_5490 & ((dot(float3(fragment_unnamed_5500, fragment_unnamed_5501, fragment_unnamed_5502), float3(asfloat(fragment_unnamed_5369.x), asfloat(fragment_unnamed_5369.y), asfloat(fragment_unnamed_5369.z))) >= 0.0f) ? 4294967295u : 0u)) != 0u) ? 0u : asuint(fragment_unnamed_5535 * fragment_unnamed_5535));
							uint fragment_unnamed_5548 = (0.0f < fragment_unnamed_5546) ? 4294967295u : 0u;
							float fragment_unnamed_6861;
							float fragment_unnamed_6863;
							float fragment_unnamed_6865;
							float fragment_unnamed_6867;
							if ((fragment_unnamed_5490 & fragment_unnamed_5548) != 0u)
							{
								float fragment_unnamed_6417 = asfloat(T7.Load((fragment_unnamed_4230 * 56u) + 16u).x);
								uint fragment_unnamed_6419 = (fragment_unnamed_4230 * 56u) + 34u;
								uint2 fragment_unnamed_6425 = uint2(T7.Load(fragment_unnamed_6419).x, T7.Load(fragment_unnamed_6419 + 1u).x);
								float fragment_unnamed_6427 = asfloat(fragment_unnamed_6425.x);
								float fragment_unnamed_6429 = asfloat(fragment_unnamed_6425.y);
								float fragment_unnamed_7314;
								if ((((int(fragment_unnamed_5412) >= int(0u)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_6429) ? 4294967295u : 0u)) != 0u)
								{
									uint fragment_unnamed_6710 = fragment_unnamed_5412 * 60u;
									uint4 fragment_unnamed_6722 = uint4(T31.Load(fragment_unnamed_6710).x, T31.Load(fragment_unnamed_6710 + 1u).x, T31.Load(fragment_unnamed_6710 + 2u).x, T31.Load(fragment_unnamed_6710 + 3u).x);
									float fragment_unnamed_6724 = asfloat(fragment_unnamed_6722.w);
									float fragment_unnamed_6726 = asfloat(fragment_unnamed_6722.x);
									float fragment_unnamed_6728 = asfloat(fragment_unnamed_6722.y);
									float fragment_unnamed_6730 = asfloat(fragment_unnamed_6722.z);
									uint fragment_unnamed_6732 = (fragment_unnamed_5412 * 60u) + 4u;
									uint4 fragment_unnamed_6744 = uint4(T31.Load(fragment_unnamed_6732).x, T31.Load(fragment_unnamed_6732 + 1u).x, T31.Load(fragment_unnamed_6732 + 2u).x, T31.Load(fragment_unnamed_6732 + 3u).x);
									uint fragment_unnamed_6745 = fragment_unnamed_6744.x;
									uint fragment_unnamed_6746 = fragment_unnamed_6744.y;
									uint fragment_unnamed_6747 = fragment_unnamed_6744.z;
									uint fragment_unnamed_6748 = fragment_unnamed_6744.w;
									uint fragment_unnamed_6750 = (fragment_unnamed_5412 * 60u) + 8u;
									uint4 fragment_unnamed_6762 = uint4(T31.Load(fragment_unnamed_6750).x, T31.Load(fragment_unnamed_6750 + 1u).x, T31.Load(fragment_unnamed_6750 + 2u).x, T31.Load(fragment_unnamed_6750 + 3u).x);
									float fragment_unnamed_6764 = asfloat(fragment_unnamed_6762.y);
									float fragment_unnamed_6766 = asfloat(fragment_unnamed_6762.z);
									float fragment_unnamed_6768 = asfloat(fragment_unnamed_6762.x);
									float fragment_unnamed_6770 = asfloat(fragment_unnamed_6762.w);
									uint fragment_unnamed_6772 = (fragment_unnamed_5412 * 60u) + 12u;
									uint4 fragment_unnamed_6784 = uint4(T31.Load(fragment_unnamed_6772).x, T31.Load(fragment_unnamed_6772 + 1u).x, T31.Load(fragment_unnamed_6772 + 2u).x, T31.Load(fragment_unnamed_6772 + 3u).x);
									float fragment_unnamed_6786 = asfloat(fragment_unnamed_6784.x);
									float fragment_unnamed_6788 = asfloat(fragment_unnamed_6784.y);
									float fragment_unnamed_6790 = asfloat(fragment_unnamed_6784.z);
									uint fragment_unnamed_6791 = fragment_unnamed_6784.w;
									uint fragment_unnamed_6793 = (fragment_unnamed_5412 * 60u) + 16u;
									uint2 fragment_unnamed_6799 = uint2(T31.Load(fragment_unnamed_6793).x, T31.Load(fragment_unnamed_6793 + 1u).x);
									float fragment_unnamed_6801 = asfloat(fragment_unnamed_6799.x);
									float fragment_unnamed_6803 = asfloat(fragment_unnamed_6799.y);
									uint fragment_unnamed_6805 = (fragment_unnamed_5412 * 60u) + 24u;
									uint2 fragment_unnamed_6811 = uint2(T31.Load(fragment_unnamed_6805).x, T31.Load(fragment_unnamed_6805 + 1u).x);
									float fragment_unnamed_6813 = asfloat(fragment_unnamed_6811.x);
									float fragment_unnamed_6815 = asfloat(fragment_unnamed_6811.y);
									uint fragment_unnamed_6817 = (fragment_unnamed_5412 * 60u) + 28u;
									uint4 fragment_unnamed_6829 = uint4(T31.Load(fragment_unnamed_6817).x, T31.Load(fragment_unnamed_6817 + 1u).x, T31.Load(fragment_unnamed_6817 + 2u).x, T31.Load(fragment_unnamed_6817 + 3u).x);
									float fragment_unnamed_6831 = asfloat(fragment_unnamed_6829.x);
									float fragment_unnamed_6833 = asfloat(fragment_unnamed_6829.y);
									float fragment_unnamed_6835 = asfloat(fragment_unnamed_6829.z);
									uint fragment_unnamed_6836 = fragment_unnamed_6829.w;
									uint fragment_unnamed_6838 = (fragment_unnamed_5412 * 60u) + 40u;
									uint4 fragment_unnamed_6850 = uint4(T31.Load(fragment_unnamed_6838).x, T31.Load(fragment_unnamed_6838 + 1u).x, T31.Load(fragment_unnamed_6838 + 2u).x, T31.Load(fragment_unnamed_6838 + 3u).x);
									float fragment_unnamed_6852 = asfloat(fragment_unnamed_6850.x);
									float fragment_unnamed_6854 = asfloat(fragment_unnamed_6850.y);
									float fragment_unnamed_6856 = asfloat(fragment_unnamed_6850.z);
									float fragment_unnamed_6858 = asfloat(fragment_unnamed_6850.w);
									float fragment_unnamed_7698;
									if (0.0f < fragment_unnamed_6858)
									{
										bool fragment_unnamed_7053 = 0.0f != fragment_unnamed_6858;
										uint4 fragment_unnamed_7057 = asuint(fragment_uniform_buffer_0[101u]);
										uint4 fragment_unnamed_7063 = asuint(fragment_uniform_buffer_0[99u]);
										float fragment_unnamed_7067 = asfloat(fragment_unnamed_7053 ? fragment_unnamed_7057.z : fragment_unnamed_7063.z);
										float fragment_unnamed_7069 = asfloat(fragment_unnamed_7053 ? fragment_unnamed_7057.w : fragment_unnamed_7063.w);
										float fragment_unnamed_7082 = ((-0.0f) - fragment_unnamed_6764) + (fragment_unnamed_6852 + fragment_input_6.x);
										float fragment_unnamed_7083 = ((-0.0f) - fragment_unnamed_6766) + (fragment_unnamed_6854 + fragment_input_6.y);
										float fragment_unnamed_7084 = ((-0.0f) - fragment_unnamed_6770) + (fragment_unnamed_6856 + fragment_input_6.z);
										float fragment_unnamed_7095 = dot(float3(asfloat(fragment_unnamed_6747), asfloat(fragment_unnamed_6748), fragment_unnamed_6768), float3(fragment_unnamed_7082, fragment_unnamed_7083, fragment_unnamed_7084));
										float fragment_unnamed_7098 = dot(float3(fragment_unnamed_6726, fragment_unnamed_6728, fragment_unnamed_6730), float3(fragment_unnamed_7082, fragment_unnamed_7083, fragment_unnamed_7084)) * fragment_unnamed_6786;
										float fragment_unnamed_7099 = dot(float3(fragment_unnamed_6724, asfloat(fragment_unnamed_6745), asfloat(fragment_unnamed_6746)), float3(fragment_unnamed_7082, fragment_unnamed_7083, fragment_unnamed_7084)) * fragment_unnamed_6788;
										float fragment_unnamed_7101 = dot(float2(fragment_unnamed_6790, asfloat(fragment_unnamed_6791)), float2(fragment_unnamed_7095, fragment_unnamed_3215));
										bool fragment_unnamed_7104 = fragment_unnamed_7095 != (-0.0f);
										float fragment_unnamed_7105 = (-0.0f) - fragment_unnamed_7095;
										float fragment_unnamed_7127 = mad(fragment_unnamed_6813 * clamp(mad(asfloat(fragment_unnamed_7104 ? asuint(fragment_unnamed_7098 / fragment_unnamed_7105) : asuint(fragment_unnamed_7098)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7067, fragment_unnamed_6801);
										float fragment_unnamed_7128 = mad(fragment_unnamed_6815 * clamp(mad(asfloat(fragment_unnamed_7104 ? asuint(fragment_unnamed_7099 / fragment_unnamed_7105) : asuint(fragment_unnamed_7099)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7069, fragment_unnamed_6803);
										float fragment_unnamed_7129 = trunc(mad(min(asfloat(fragment_unnamed_6836), 4.0f), 4.0f, 1.0f));
										float fragment_unnamed_7130 = (-0.0f) - fragment_unnamed_7129;
										float4 fragment_unnamed_7151 = _CachedAreaLightShadowmapAtlas.SampleLevel(S0, float2(fragment_unnamed_7127, fragment_unnamed_7128), 0.0f);
										float fragment_unnamed_7153 = fragment_unnamed_7151.x;
										float fragment_unnamed_7157 = exp2(mad(((-0.0f) - asfloat(fragment_unnamed_7104 ? asuint(fragment_unnamed_7101 / fragment_unnamed_7105) : asuint(fragment_unnamed_7101))) + 1.0f, 2.0f, -1.0f) * fragment_unnamed_6831);
										float fragment_unnamed_7158 = fragment_unnamed_7157 * fragment_unnamed_6831;
										float fragment_unnamed_7163 = max(fragment_unnamed_6835 * (fragment_unnamed_7158 * fragment_unnamed_7158), mad((-0.0f) - fragment_unnamed_7153, fragment_unnamed_7153, fragment_unnamed_7151.y));
										float fragment_unnamed_7165 = ((-0.0f) - fragment_unnamed_7153) + fragment_unnamed_7157;
										fragment_unnamed_7698 = asfloat((((((mad(mad(fragment_unnamed_7130, 0.5f, fragment_unnamed_6815), fragment_unnamed_7069, fragment_unnamed_6803) < fragment_unnamed_7128) ? 4294967295u : 0u) | ((mad(mad(fragment_unnamed_7130, 0.5f, fragment_unnamed_6813), fragment_unnamed_7067, fragment_unnamed_6801) < fragment_unnamed_7127) ? 4294967295u : 0u)) | (((fragment_unnamed_7128 < mad(fragment_unnamed_7069, fragment_unnamed_7129, fragment_unnamed_6803)) ? 4294967295u : 0u) | ((fragment_unnamed_7127 < mad(fragment_unnamed_7067, fragment_unnamed_7129, fragment_unnamed_6801)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(max(asfloat(((fragment_unnamed_7153 >= fragment_unnamed_7157) ? 4294967295u : 0u) & 1065353216u), clamp((((-0.0f) - fragment_unnamed_6833) + (fragment_unnamed_7163 / mad(fragment_unnamed_7165, fragment_unnamed_7165, fragment_unnamed_7163))) / (((-0.0f) - fragment_unnamed_6833) + 1.0f), 0.0f, 1.0f))));
									}
									else
									{
										bool fragment_unnamed_7186 = 0.0f != fragment_unnamed_6858;
										uint4 fragment_unnamed_7189 = asuint(fragment_uniform_buffer_0[101u]);
										uint4 fragment_unnamed_7194 = asuint(fragment_uniform_buffer_0[99u]);
										float fragment_unnamed_7198 = asfloat(fragment_unnamed_7186 ? fragment_unnamed_7189.z : fragment_unnamed_7194.z);
										float fragment_unnamed_7200 = asfloat(fragment_unnamed_7186 ? fragment_unnamed_7189.w : fragment_unnamed_7194.w);
										float fragment_unnamed_7213 = ((-0.0f) - fragment_unnamed_6764) + (fragment_unnamed_6852 + fragment_input_6.x);
										float fragment_unnamed_7214 = ((-0.0f) - fragment_unnamed_6766) + (fragment_unnamed_6854 + fragment_input_6.y);
										float fragment_unnamed_7215 = ((-0.0f) - fragment_unnamed_6770) + (fragment_unnamed_6856 + fragment_input_6.z);
										float fragment_unnamed_7226 = dot(float3(asfloat(fragment_unnamed_6747), asfloat(fragment_unnamed_6748), fragment_unnamed_6768), float3(fragment_unnamed_7213, fragment_unnamed_7214, fragment_unnamed_7215));
										float fragment_unnamed_7229 = dot(float3(fragment_unnamed_6726, fragment_unnamed_6728, fragment_unnamed_6730), float3(fragment_unnamed_7213, fragment_unnamed_7214, fragment_unnamed_7215)) * fragment_unnamed_6786;
										float fragment_unnamed_7230 = dot(float3(fragment_unnamed_6724, asfloat(fragment_unnamed_6745), asfloat(fragment_unnamed_6746)), float3(fragment_unnamed_7213, fragment_unnamed_7214, fragment_unnamed_7215)) * fragment_unnamed_6788;
										float fragment_unnamed_7232 = dot(float2(fragment_unnamed_6790, asfloat(fragment_unnamed_6791)), float2(fragment_unnamed_7226, fragment_unnamed_3216));
										bool fragment_unnamed_7235 = fragment_unnamed_7226 != (-0.0f);
										float fragment_unnamed_7236 = (-0.0f) - fragment_unnamed_7226;
										float fragment_unnamed_7258 = mad(fragment_unnamed_6813 * clamp(mad(asfloat(fragment_unnamed_7235 ? asuint(fragment_unnamed_7229 / fragment_unnamed_7236) : asuint(fragment_unnamed_7229)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7198, fragment_unnamed_6801);
										float fragment_unnamed_7259 = mad(fragment_unnamed_6815 * clamp(mad(asfloat(fragment_unnamed_7235 ? asuint(fragment_unnamed_7230 / fragment_unnamed_7236) : asuint(fragment_unnamed_7230)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7200, fragment_unnamed_6803);
										float fragment_unnamed_7260 = trunc(mad(min(asfloat(fragment_unnamed_6836), 4.0f), 4.0f, 1.0f));
										float fragment_unnamed_7261 = (-0.0f) - fragment_unnamed_7260;
										float4 fragment_unnamed_7282 = _ShadowmapAreaAtlas.SampleLevel(S0, float2(fragment_unnamed_7258, fragment_unnamed_7259), 0.0f);
										float fragment_unnamed_7284 = fragment_unnamed_7282.x;
										float fragment_unnamed_7288 = exp2(mad(((-0.0f) - asfloat(fragment_unnamed_7235 ? asuint(fragment_unnamed_7232 / fragment_unnamed_7236) : asuint(fragment_unnamed_7232))) + 1.0f, 2.0f, -1.0f) * fragment_unnamed_6831);
										float fragment_unnamed_7289 = fragment_unnamed_7288 * fragment_unnamed_6831;
										float fragment_unnamed_7294 = max(fragment_unnamed_6835 * (fragment_unnamed_7289 * fragment_unnamed_7289), mad((-0.0f) - fragment_unnamed_7284, fragment_unnamed_7284, fragment_unnamed_7282.y));
										float fragment_unnamed_7296 = ((-0.0f) - fragment_unnamed_7284) + fragment_unnamed_7288;
										fragment_unnamed_7698 = asfloat((((((mad(mad(fragment_unnamed_7261, 0.5f, fragment_unnamed_6815), fragment_unnamed_7200, fragment_unnamed_6803) < fragment_unnamed_7259) ? 4294967295u : 0u) | ((mad(mad(fragment_unnamed_7261, 0.5f, fragment_unnamed_6813), fragment_unnamed_7198, fragment_unnamed_6801) < fragment_unnamed_7258) ? 4294967295u : 0u)) | (((fragment_unnamed_7259 < mad(fragment_unnamed_7200, fragment_unnamed_7260, fragment_unnamed_6803)) ? 4294967295u : 0u) | ((fragment_unnamed_7258 < mad(fragment_unnamed_7198, fragment_unnamed_7260, fragment_unnamed_6801)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(max(asfloat(((fragment_unnamed_7284 >= fragment_unnamed_7288) ? 4294967295u : 0u) & 1065353216u), clamp((((-0.0f) - fragment_unnamed_6833) + (fragment_unnamed_7294 / mad(fragment_unnamed_7296, fragment_unnamed_7296, fragment_unnamed_7294))) / (((-0.0f) - fragment_unnamed_6833) + 1.0f), 0.0f, 1.0f))));
									}
									fragment_unnamed_7314 = mad(fragment_unnamed_6429, fragment_unnamed_7698 + (-1.0f), 1.0f);
								}
								else
								{
									fragment_unnamed_7314 = asfloat(1065353216u);
								}
								float fragment_unnamed_7316 = asfloat(fragment_unnamed_5470.z);
								float fragment_unnamed_7317 = asfloat(fragment_unnamed_5470.w);
								float fragment_unnamed_7321 = ((-0.0f) - fragment_unnamed_7316) + 1.0f;
								float fragment_unnamed_7322 = ((-0.0f) - fragment_unnamed_7317) + 1.0f;
								float fragment_unnamed_7323 = ((-0.0f) - fragment_unnamed_6427) + 1.0f;
								float fragment_unnamed_7325 = fragment_unnamed_7314 * (fragment_unnamed_7314 * fragment_unnamed_7314);
								float fragment_unnamed_7328 = (-0.0f) - (((-0.0f) - fragment_unnamed_7314) + 1.0f);
								float fragment_unnamed_7329 = mad(fragment_unnamed_7328, fragment_unnamed_7321, 1.0f);
								float fragment_unnamed_7330 = mad(fragment_unnamed_7328, fragment_unnamed_7322, 1.0f);
								float fragment_unnamed_7331 = mad(fragment_unnamed_7328, fragment_unnamed_7323, 1.0f);
								float fragment_unnamed_6862 = mad(fragment_unnamed_6417, ((-0.0f) - fragment_unnamed_7329) + mad(fragment_unnamed_7325, fragment_unnamed_7321, fragment_unnamed_7316 * fragment_unnamed_7314), fragment_unnamed_7329) * fragment_unnamed_5430;
								float fragment_unnamed_6864 = mad(fragment_unnamed_6417, ((-0.0f) - fragment_unnamed_7330) + mad(fragment_unnamed_7325, fragment_unnamed_7322, fragment_unnamed_7317 * fragment_unnamed_7314), fragment_unnamed_7330) * fragment_unnamed_5432;
								float fragment_unnamed_6866 = mad(fragment_unnamed_6417, ((-0.0f) - fragment_unnamed_7331) + mad(fragment_unnamed_7325, fragment_unnamed_7323, fragment_unnamed_6427 * fragment_unnamed_7314), fragment_unnamed_7331) * asfloat(fragment_unnamed_5450);
								fragment_unnamed_6861 = fragment_unnamed_6862;
								fragment_unnamed_6863 = fragment_unnamed_6864;
								fragment_unnamed_6865 = fragment_unnamed_6866;
								fragment_unnamed_6867 = asfloat((0.0f < max(fragment_unnamed_6866, max(fragment_unnamed_6864, fragment_unnamed_6862))) ? 4294967295u : 0u);
							}
							else
							{
								fragment_unnamed_6861 = fragment_unnamed_5430;
								fragment_unnamed_6863 = fragment_unnamed_5432;
								fragment_unnamed_6865 = asfloat(fragment_unnamed_5450);
								fragment_unnamed_6867 = asfloat(4294967295u);
							}
							float fragment_unnamed_7718;
							float fragment_unnamed_7720;
							float fragment_unnamed_7722;
							float fragment_unnamed_7724;
							float fragment_unnamed_7726;
							float fragment_unnamed_7728;
							if ((fragment_unnamed_5548 & asuint(fragment_unnamed_6867)) != 0u)
							{
								uint fragment_unnamed_7353 = (fragment_unnamed_4230 * 56u) + 49u;
								uint2 fragment_unnamed_7359 = uint2(T7.Load(fragment_unnamed_7353).x, T7.Load(fragment_unnamed_7353 + 1u).x);
								float fragment_unnamed_7364 = dot(float3(fragment_unnamed_1305, fragment_unnamed_3213, fragment_unnamed_3214), float3(fragment_unnamed_5500, fragment_unnamed_5501, fragment_unnamed_5502));
								float fragment_unnamed_7367 = dot(float3(fragment_unnamed_1295, fragment_unnamed_1297, fragment_unnamed_3217), float3(fragment_unnamed_5500, fragment_unnamed_5501, fragment_unnamed_5502));
								float fragment_unnamed_7370 = dot(float3(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880), float3(fragment_unnamed_5500, fragment_unnamed_5501, fragment_unnamed_5502));
								float fragment_unnamed_7373 = dot(float3(fragment_unnamed_1305, fragment_unnamed_3213, fragment_unnamed_3214), float3(fragment_unnamed_5392, fragment_unnamed_5394, fragment_unnamed_5396));
								float fragment_unnamed_7376 = dot(float3(fragment_unnamed_1295, fragment_unnamed_1297, fragment_unnamed_3217), float3(fragment_unnamed_5392, fragment_unnamed_5394, fragment_unnamed_5396));
								float fragment_unnamed_7379 = dot(float3(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880), float3(fragment_unnamed_5392, fragment_unnamed_5394, fragment_unnamed_5396));
								float fragment_unnamed_7382 = dot(float3(fragment_unnamed_1305, fragment_unnamed_3213, fragment_unnamed_3214), float3(fragment_unnamed_5512, fragment_unnamed_5513, fragment_unnamed_5514));
								float fragment_unnamed_7385 = dot(float3(fragment_unnamed_1295, fragment_unnamed_1297, fragment_unnamed_3217), float3(fragment_unnamed_5512, fragment_unnamed_5513, fragment_unnamed_5514));
								float fragment_unnamed_7388 = dot(float3(fragment_unnamed_878, fragment_unnamed_879, fragment_unnamed_880), float3(fragment_unnamed_5512, fragment_unnamed_5513, fragment_unnamed_5514));
								float fragment_unnamed_7397 = mad(fragment_unnamed_7367, fragment_unnamed_7379, (-0.0f) - (fragment_unnamed_7376 * fragment_unnamed_7370));
								float fragment_unnamed_7398 = mad(fragment_unnamed_7370, fragment_unnamed_7373, (-0.0f) - (fragment_unnamed_7379 * fragment_unnamed_7364));
								float fragment_unnamed_7399 = mad(fragment_unnamed_7364, fragment_unnamed_7376, (-0.0f) - (fragment_unnamed_7373 * fragment_unnamed_7367));
								float fragment_unnamed_7400 = dot(float3(fragment_unnamed_7397, fragment_unnamed_7398, fragment_unnamed_7399), float3(fragment_unnamed_7397, fragment_unnamed_7398, fragment_unnamed_7399));
								uint fragment_unnamed_7411 = ((fragment_unnamed_7400 == 0.0f) ? 4294967295u : 0u) | ((0.0f >= mad(fragment_unnamed_5504, abs(fragment_unnamed_7388), mad(fragment_unnamed_5503, abs(fragment_unnamed_7379), fragment_unnamed_7370))) ? 4294967295u : 0u);
								float fragment_unnamed_7966;
								float fragment_unnamed_7968;
								float fragment_unnamed_7970;
								float fragment_unnamed_7972;
								if (fragment_unnamed_7411 == 0u)
								{
									float fragment_unnamed_7700 = dot(float2(fragment_unnamed_3218, fragment_unnamed_1236), float2(fragment_unnamed_7370, fragment_unnamed_7364));
									float fragment_unnamed_7703 = dot(float2(fragment_unnamed_3218, fragment_unnamed_1236), float2(fragment_unnamed_7379, fragment_unnamed_7373));
									float fragment_unnamed_7706 = dot(float2(fragment_unnamed_1236, fragment_unnamed_3218), float2(fragment_unnamed_7382, fragment_unnamed_7388));
									float fragment_unnamed_7967;
									float fragment_unnamed_7969;
									float fragment_unnamed_7971;
									float fragment_unnamed_7973;
									if (0.0f < mad(fragment_unnamed_5504, abs(fragment_unnamed_7706), mad(fragment_unnamed_5503, abs(fragment_unnamed_7703), fragment_unnamed_7700)))
									{
										float fragment_unnamed_7954 = dot(float2(fragment_unnamed_1238, fragment_unnamed_1235), float2(fragment_unnamed_7370, fragment_unnamed_7364));
										float fragment_unnamed_7957 = fragment_unnamed_1237 * fragment_unnamed_7367;
										float fragment_unnamed_7958 = dot(float2(fragment_unnamed_1238, fragment_unnamed_1235), float2(fragment_unnamed_7379, fragment_unnamed_7373));
										float fragment_unnamed_7961 = fragment_unnamed_1237 * fragment_unnamed_7376;
										float fragment_unnamed_9026;
										float fragment_unnamed_9027;
										float fragment_unnamed_9028;
										float fragment_unnamed_9029;
										if (fragment_unnamed_5489)
										{
											float fragment_unnamed_8686 = dot(float2(fragment_unnamed_1235, fragment_unnamed_1238), float2(fragment_unnamed_7382, fragment_unnamed_7388));
											float fragment_unnamed_8689 = fragment_unnamed_7385 * fragment_unnamed_1237;
											float fragment_unnamed_8690 = (-0.0f) - fragment_unnamed_5503;
											float fragment_unnamed_8694 = (-0.0f) - fragment_unnamed_5504;
											float fragment_unnamed_8695 = mad(fragment_unnamed_8694, fragment_unnamed_8686, mad(fragment_unnamed_8690, fragment_unnamed_7958, fragment_unnamed_7954));
											float fragment_unnamed_8696 = mad(fragment_unnamed_8694, fragment_unnamed_8689, mad(fragment_unnamed_8690, fragment_unnamed_7961, fragment_unnamed_7957));
											float fragment_unnamed_8697 = mad(fragment_unnamed_8694, fragment_unnamed_7706, mad(fragment_unnamed_8690, fragment_unnamed_7703, fragment_unnamed_7700));
											float fragment_unnamed_8698 = fragment_unnamed_5488 * fragment_unnamed_8686;
											float fragment_unnamed_8699 = fragment_unnamed_5488 * fragment_unnamed_8689;
											float fragment_unnamed_8700 = fragment_unnamed_5488 * fragment_unnamed_7706;
											float fragment_unnamed_8701 = mad(fragment_unnamed_5488, fragment_unnamed_7706, fragment_unnamed_8697);
											float fragment_unnamed_8702 = mad(fragment_unnamed_5488, fragment_unnamed_8686, fragment_unnamed_8695);
											float fragment_unnamed_8703 = mad(fragment_unnamed_5488, fragment_unnamed_8689, fragment_unnamed_8696);
											float fragment_unnamed_8704 = mad(fragment_unnamed_5486, fragment_unnamed_7703, fragment_unnamed_8701);
											float fragment_unnamed_8705 = mad(fragment_unnamed_5486, fragment_unnamed_7958, fragment_unnamed_8702);
											float fragment_unnamed_8706 = mad(fragment_unnamed_5486, fragment_unnamed_7961, fragment_unnamed_8703);
											float fragment_unnamed_8707 = (-0.0f) - fragment_unnamed_5488;
											float fragment_unnamed_8708 = mad(fragment_unnamed_8707, fragment_unnamed_8686, fragment_unnamed_8705);
											float fragment_unnamed_8709 = mad(fragment_unnamed_8707, fragment_unnamed_8689, fragment_unnamed_8706);
											float fragment_unnamed_8710 = mad(fragment_unnamed_8707, fragment_unnamed_7706, fragment_unnamed_8704);
											float fragment_unnamed_8714 = rsqrt(dot(float3(fragment_unnamed_8695, fragment_unnamed_8696, fragment_unnamed_8697), float3(fragment_unnamed_8695, fragment_unnamed_8696, fragment_unnamed_8697)));
											float fragment_unnamed_8715 = fragment_unnamed_8714 * fragment_unnamed_8696;
											float fragment_unnamed_8716 = fragment_unnamed_8714 * fragment_unnamed_8697;
											float fragment_unnamed_8717 = fragment_unnamed_8714 * fragment_unnamed_8695;
											float fragment_unnamed_8721 = rsqrt(dot(float3(fragment_unnamed_8701, fragment_unnamed_8702, fragment_unnamed_8703), float3(fragment_unnamed_8701, fragment_unnamed_8702, fragment_unnamed_8703)));
											float fragment_unnamed_8722 = fragment_unnamed_8721 * fragment_unnamed_8701;
											float fragment_unnamed_8723 = fragment_unnamed_8721 * fragment_unnamed_8702;
											float fragment_unnamed_8724 = fragment_unnamed_8721 * fragment_unnamed_8703;
											float fragment_unnamed_8728 = rsqrt(dot(float3(fragment_unnamed_8704, fragment_unnamed_8705, fragment_unnamed_8706), float3(fragment_unnamed_8704, fragment_unnamed_8705, fragment_unnamed_8706)));
											float fragment_unnamed_8729 = fragment_unnamed_8728 * fragment_unnamed_8704;
											float fragment_unnamed_8730 = fragment_unnamed_8728 * fragment_unnamed_8705;
											float fragment_unnamed_8731 = fragment_unnamed_8728 * fragment_unnamed_8706;
											float fragment_unnamed_8735 = rsqrt(dot(float3(fragment_unnamed_8708, fragment_unnamed_8709, fragment_unnamed_8710), float3(fragment_unnamed_8708, fragment_unnamed_8709, fragment_unnamed_8710)));
											float fragment_unnamed_8736 = fragment_unnamed_8735 * fragment_unnamed_8710;
											float fragment_unnamed_8737 = fragment_unnamed_8735 * fragment_unnamed_8708;
											float fragment_unnamed_8738 = fragment_unnamed_8735 * fragment_unnamed_8709;
											float fragment_unnamed_8739 = dot(float3(fragment_unnamed_8716, fragment_unnamed_8717, fragment_unnamed_8715), float3(fragment_unnamed_8722, fragment_unnamed_8723, fragment_unnamed_8724));
											float fragment_unnamed_8776 = mad(abs(fragment_unnamed_8739), mad(abs(fragment_unnamed_8739), mad(abs(fragment_unnamed_8739), mad(abs(fragment_unnamed_8739), mad(abs(fragment_unnamed_8739), mad(abs(fragment_unnamed_8739), mad(abs(fragment_unnamed_8739), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8784 = asfloat((fragment_unnamed_8739 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8739, fragment_unnamed_8739, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8776)) : asuint(fragment_unnamed_8776));
											float fragment_unnamed_8785 = dot(float3(fragment_unnamed_8722, fragment_unnamed_8723, fragment_unnamed_8724), float3(fragment_unnamed_8729, fragment_unnamed_8730, fragment_unnamed_8731));
											float fragment_unnamed_8815 = mad(abs(fragment_unnamed_8785), mad(abs(fragment_unnamed_8785), mad(abs(fragment_unnamed_8785), mad(abs(fragment_unnamed_8785), mad(abs(fragment_unnamed_8785), mad(abs(fragment_unnamed_8785), mad(abs(fragment_unnamed_8785), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8822 = asfloat((fragment_unnamed_8785 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8785, fragment_unnamed_8785, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8815)) : asuint(fragment_unnamed_8815));
											float fragment_unnamed_8829 = dot(float3(fragment_unnamed_8729, fragment_unnamed_8730, fragment_unnamed_8731), float3(fragment_unnamed_8736, fragment_unnamed_8737, fragment_unnamed_8738));
											float fragment_unnamed_8859 = mad(abs(fragment_unnamed_8829), mad(abs(fragment_unnamed_8829), mad(abs(fragment_unnamed_8829), mad(abs(fragment_unnamed_8829), mad(abs(fragment_unnamed_8829), mad(abs(fragment_unnamed_8829), mad(abs(fragment_unnamed_8829), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8866 = asfloat((fragment_unnamed_8829 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8829, fragment_unnamed_8829, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8859)) : asuint(fragment_unnamed_8859));
											float fragment_unnamed_8870 = dot(float3(fragment_unnamed_8738, fragment_unnamed_8736, fragment_unnamed_8737), float3(fragment_unnamed_8715, fragment_unnamed_8716, fragment_unnamed_8717));
											float fragment_unnamed_8900 = mad(abs(fragment_unnamed_8870), mad(abs(fragment_unnamed_8870), mad(abs(fragment_unnamed_8870), mad(abs(fragment_unnamed_8870), mad(abs(fragment_unnamed_8870), mad(abs(fragment_unnamed_8870), mad(abs(fragment_unnamed_8870), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8907 = asfloat((fragment_unnamed_8870 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8870, fragment_unnamed_8870, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8900)) : asuint(fragment_unnamed_8900));
											float fragment_unnamed_8910 = mad(mad(fragment_unnamed_8737, fragment_unnamed_8715, (-0.0f) - (fragment_unnamed_8717 * fragment_unnamed_8738)), fragment_unnamed_8907, mad(mad(fragment_unnamed_8730, fragment_unnamed_8738, (-0.0f) - (fragment_unnamed_8731 * fragment_unnamed_8737)), fragment_unnamed_8866, mad(mad(fragment_unnamed_8717, fragment_unnamed_8724, (-0.0f) - (fragment_unnamed_8723 * fragment_unnamed_8715)), fragment_unnamed_8784, fragment_unnamed_8822 * mad(fragment_unnamed_8723, fragment_unnamed_8731, (-0.0f) - (fragment_unnamed_8724 * fragment_unnamed_8730)))));
											float fragment_unnamed_8911 = mad(mad(fragment_unnamed_8738, fragment_unnamed_8716, (-0.0f) - (fragment_unnamed_8715 * fragment_unnamed_8736)), fragment_unnamed_8907, mad(mad(fragment_unnamed_8731, fragment_unnamed_8736, (-0.0f) - (fragment_unnamed_8729 * fragment_unnamed_8738)), fragment_unnamed_8866, mad(mad(fragment_unnamed_8715, fragment_unnamed_8722, (-0.0f) - (fragment_unnamed_8724 * fragment_unnamed_8716)), fragment_unnamed_8784, fragment_unnamed_8822 * mad(fragment_unnamed_8724, fragment_unnamed_8729, (-0.0f) - (fragment_unnamed_8722 * fragment_unnamed_8731))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_8912 = mad(mad(fragment_unnamed_8736, fragment_unnamed_8717, (-0.0f) - (fragment_unnamed_8716 * fragment_unnamed_8737)), fragment_unnamed_8907, mad(mad(fragment_unnamed_8729, fragment_unnamed_8737, (-0.0f) - (fragment_unnamed_8730 * fragment_unnamed_8736)), fragment_unnamed_8866, mad(mad(fragment_unnamed_8716, fragment_unnamed_8723, (-0.0f) - (fragment_unnamed_8722 * fragment_unnamed_8717)), fragment_unnamed_8784, fragment_unnamed_8822 * mad(fragment_unnamed_8722, fragment_unnamed_8730, (-0.0f) - (fragment_unnamed_8723 * fragment_unnamed_8729))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_8913 = fragment_unnamed_8910 * 0.15915493667125701904296875f;
											float fragment_unnamed_8914 = dot(float3(fragment_unnamed_8911, fragment_unnamed_8912, fragment_unnamed_8913), float3(fragment_unnamed_8911, fragment_unnamed_8912, fragment_unnamed_8913));
											float fragment_unnamed_9198;
											float fragment_unnamed_9199;
											float fragment_unnamed_9200;
											if (fragment_unnamed_5411 != 0u)
											{
												float fragment_unnamed_9066 = ((-0.0f) - fragment_unnamed_8695) + fragment_unnamed_8708;
												float fragment_unnamed_9067 = ((-0.0f) - fragment_unnamed_8696) + fragment_unnamed_8709;
												float fragment_unnamed_9068 = ((-0.0f) - fragment_unnamed_8697) + fragment_unnamed_8710;
												float fragment_unnamed_9075 = mad(fragment_unnamed_9067, fragment_unnamed_8700, (-0.0f) - (fragment_unnamed_8699 * fragment_unnamed_9068));
												float fragment_unnamed_9076 = mad(fragment_unnamed_9068, fragment_unnamed_8698, (-0.0f) - (fragment_unnamed_8700 * fragment_unnamed_9066));
												float fragment_unnamed_9077 = mad(fragment_unnamed_9066, fragment_unnamed_8699, (-0.0f) - (fragment_unnamed_8698 * fragment_unnamed_9067));
												float fragment_unnamed_9081 = rsqrt(dot(float3(fragment_unnamed_9075, fragment_unnamed_9076, fragment_unnamed_9077), float3(fragment_unnamed_9075, fragment_unnamed_9076, fragment_unnamed_9077)));
												float fragment_unnamed_9082 = fragment_unnamed_9081 * fragment_unnamed_9075;
												float fragment_unnamed_9083 = fragment_unnamed_9081 * fragment_unnamed_9076;
												float fragment_unnamed_9084 = fragment_unnamed_9081 * fragment_unnamed_9077;
												float fragment_unnamed_9091 = dot(float3(fragment_unnamed_8695, fragment_unnamed_8696, fragment_unnamed_8697), float3(fragment_unnamed_9082, fragment_unnamed_9083, fragment_unnamed_9084)) / dot(float3(fragment_unnamed_8911, fragment_unnamed_8912, fragment_unnamed_8913), float3(fragment_unnamed_9082, fragment_unnamed_9083, fragment_unnamed_9084));
												float fragment_unnamed_9095 = mad(fragment_unnamed_9091, fragment_unnamed_9082, (-0.0f) - fragment_unnamed_8695);
												float fragment_unnamed_9096 = mad(fragment_unnamed_9091, fragment_unnamed_9083, (-0.0f) - fragment_unnamed_8696);
												float fragment_unnamed_9097 = mad(fragment_unnamed_9091, fragment_unnamed_9084, (-0.0f) - fragment_unnamed_8697);
												float fragment_unnamed_9101 = 1.0f / dot(float3(fragment_unnamed_9066, fragment_unnamed_9067, fragment_unnamed_9068), float3(fragment_unnamed_9066, fragment_unnamed_9067, fragment_unnamed_9068));
												float fragment_unnamed_9102 = dot(float3(fragment_unnamed_8698, fragment_unnamed_8699, fragment_unnamed_8700), float3(fragment_unnamed_9066, fragment_unnamed_9067, fragment_unnamed_9068));
												float fragment_unnamed_9111 = mad((-0.0f) - (fragment_unnamed_9066 * fragment_unnamed_9102), fragment_unnamed_9101, fragment_unnamed_8698);
												float fragment_unnamed_9112 = mad((-0.0f) - (fragment_unnamed_9067 * fragment_unnamed_9102), fragment_unnamed_9101, fragment_unnamed_8699);
												float fragment_unnamed_9113 = mad((-0.0f) - (fragment_unnamed_9068 * fragment_unnamed_9102), fragment_unnamed_9101, fragment_unnamed_8700);
												float fragment_unnamed_9120 = dot(float3(fragment_unnamed_9095, fragment_unnamed_9096, fragment_unnamed_9097), float3(fragment_unnamed_9111, fragment_unnamed_9112, fragment_unnamed_9113)) / dot(float3(fragment_unnamed_9111, fragment_unnamed_9112, fragment_unnamed_9113), float3(fragment_unnamed_9111, fragment_unnamed_9112, fragment_unnamed_9113));
												float fragment_unnamed_9134 = round(log2(fragment_unnamed_5454 * fragment_uniform_buffer_0[122u].x));
												float fragment_unnamed_9142 = min(fragment_unnamed_9134, max(mad(log2(mad(fragment_unnamed_9081 * (fragment_unnamed_9091 * fragment_unnamed_9091), 3.1415927410125732421875f, 9.9999999392252902907785028219223e-09f)), 0.5f, fragment_unnamed_9134), 0.0f));
												float fragment_unnamed_9156 = 1.0f / (fragment_unnamed_5454 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_9157 = 1.0f / (fragment_unnamed_5456 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_9167 = exp2(ceil(max(fragment_unnamed_9142 + ((-0.0f) - fragment_uniform_buffer_0[123u].z), 0.0f)));
												float fragment_unnamed_9171 = fragment_unnamed_5454 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_9172 = fragment_unnamed_5456 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_9175 = fragment_unnamed_9167 / (fragment_unnamed_9171 + fragment_unnamed_9171);
												float fragment_unnamed_9176 = fragment_unnamed_9167 / (fragment_unnamed_9172 + fragment_unnamed_9172);
												float4 fragment_unnamed_9190 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_9175) + 1.0f, max(fragment_unnamed_9175, mad(clamp(mad((-0.0f) - mad((-0.0f) - fragment_unnamed_9102, fragment_unnamed_9120, dot(float3(fragment_unnamed_9095, fragment_unnamed_9096, fragment_unnamed_9097), float3(fragment_unnamed_9066, fragment_unnamed_9067, fragment_unnamed_9068))), fragment_unnamed_9101, 1.0f), 0.0f, 1.0f), fragment_unnamed_5454 * fragment_unnamed_9156, mad((-0.0f) - fragment_unnamed_9156, fragment_unnamed_5454, 1.0f) * 0.5f))), fragment_unnamed_5454, fragment_unnamed_5472), mad(min(((-0.0f) - fragment_unnamed_9176) + 1.0f, max(fragment_unnamed_9176, mad(clamp(fragment_unnamed_9120, 0.0f, 1.0f), fragment_unnamed_5456 * fragment_unnamed_9157, mad((-0.0f) - fragment_unnamed_9157, fragment_unnamed_5456, 1.0f) * 0.5f))), fragment_unnamed_5456, fragment_unnamed_5474)), fragment_unnamed_9142);
												fragment_unnamed_9198 = fragment_unnamed_9190.x;
												fragment_unnamed_9199 = fragment_unnamed_9190.y;
												fragment_unnamed_9200 = fragment_unnamed_9190.z;
											}
											else
											{
												fragment_unnamed_9198 = asfloat(1065353216u);
												fragment_unnamed_9199 = asfloat(1065353216u);
												fragment_unnamed_9200 = asfloat(1065353216u);
											}
											fragment_unnamed_9026 = max(mad(fragment_unnamed_8910, 0.15915493667125701904296875f, fragment_unnamed_8914) / (sqrt(fragment_unnamed_8914) + 1.0f), 0.0f);
											fragment_unnamed_9027 = fragment_unnamed_9198;
											fragment_unnamed_9028 = fragment_unnamed_9199;
											fragment_unnamed_9029 = fragment_unnamed_9200;
										}
										else
										{
											float fragment_unnamed_8926 = fragment_unnamed_1237 * mad((-0.0f) - fragment_unnamed_1236, fragment_unnamed_7399, fragment_unnamed_7397);
											float fragment_unnamed_8927 = fragment_unnamed_3202 * fragment_unnamed_7398;
											float fragment_unnamed_8930 = fragment_unnamed_1237 * mad((-0.0f) - fragment_unnamed_1238, fragment_unnamed_7397, fragment_unnamed_1235 * fragment_unnamed_7399);
											float fragment_unnamed_8941 = (1.0f / fragment_unnamed_7703) * ((-0.0f) - fragment_unnamed_7700);
											bool fragment_unnamed_8942 = fragment_unnamed_7703 >= 0.0f;
											float fragment_unnamed_8957 = dot(float3(fragment_unnamed_7958, fragment_unnamed_7961, fragment_unnamed_7703), float3(fragment_unnamed_7958, fragment_unnamed_7961, fragment_unnamed_7703));
											float fragment_unnamed_8960 = rsqrt(fragment_unnamed_8957);
											float fragment_unnamed_8961 = fragment_unnamed_8957 * fragment_unnamed_8960;
											float fragment_unnamed_8962 = fragment_unnamed_8960 * fragment_unnamed_7958;
											float fragment_unnamed_8963 = fragment_unnamed_8960 * fragment_unnamed_7961;
											float fragment_unnamed_8964 = fragment_unnamed_8960 * fragment_unnamed_7703;
											float fragment_unnamed_8965 = dot(float3(fragment_unnamed_8962, fragment_unnamed_8963, fragment_unnamed_8964), float3(fragment_unnamed_7954, fragment_unnamed_7957, fragment_unnamed_7700));
											float fragment_unnamed_8968 = (-0.0f) - fragment_unnamed_8965;
											float fragment_unnamed_8969 = mad(fragment_unnamed_8968, fragment_unnamed_8962, fragment_unnamed_7954);
											float fragment_unnamed_8970 = mad(fragment_unnamed_8968, fragment_unnamed_8963, fragment_unnamed_7957);
											float fragment_unnamed_8971 = mad(fragment_unnamed_8968, fragment_unnamed_8964, fragment_unnamed_7700);
											float fragment_unnamed_8972 = dot(float3(fragment_unnamed_8969, fragment_unnamed_8970, fragment_unnamed_8971), float3(fragment_unnamed_8969, fragment_unnamed_8970, fragment_unnamed_8971));
											float fragment_unnamed_8975 = rsqrt(fragment_unnamed_8972);
											float fragment_unnamed_8977 = fragment_unnamed_8975 * fragment_unnamed_8971;
											float fragment_unnamed_8978 = mad(asfloat(fragment_unnamed_8942 ? asuint(max(fragment_unnamed_8941, fragment_unnamed_5503)) : asuint(min(fragment_unnamed_8941, fragment_unnamed_5503))), fragment_unnamed_8961, fragment_unnamed_8965);
											float fragment_unnamed_8979 = mad(asfloat(fragment_unnamed_8942 ? asuint(max(fragment_unnamed_8941, (-0.0f) - fragment_unnamed_5503)) : asuint(min(fragment_unnamed_8941, (-0.0f) - fragment_unnamed_5503))), fragment_unnamed_8961, fragment_unnamed_8965);
											float fragment_unnamed_8980 = mad(fragment_unnamed_8978, fragment_unnamed_8978, fragment_unnamed_8972);
											float fragment_unnamed_8981 = mad(fragment_unnamed_8979, fragment_unnamed_8979, fragment_unnamed_8972);
											float fragment_unnamed_8983 = rsqrt(fragment_unnamed_8980 * fragment_unnamed_8981);
											float fragment_unnamed_8984 = fragment_unnamed_8983 * fragment_unnamed_8983;
											float fragment_unnamed_8987 = (fragment_unnamed_8972 * fragment_unnamed_8975) * fragment_unnamed_8964;
											float fragment_unnamed_8997 = min(fragment_unnamed_8983 * mad(fragment_unnamed_8979, fragment_unnamed_8978, fragment_unnamed_8972), 1.0f);
											float fragment_unnamed_9001 = sqrt(((-0.0f) - abs(fragment_unnamed_8997)) + 1.0f);
											float fragment_unnamed_9007 = mad(mad(mad(abs(fragment_unnamed_8997), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_8997), -0.212114393711090087890625f), abs(fragment_unnamed_8997), 1.570728778839111328125f);
											fragment_unnamed_9026 = ((fragment_unnamed_7400 * (abs(fragment_unnamed_3203) * rsqrt(fragment_unnamed_7400 * dot(float3(fragment_unnamed_8926, fragment_unnamed_8927, fragment_unnamed_8930), float3(fragment_unnamed_8926, fragment_unnamed_8927, fragment_unnamed_8930))))) * max(mad(mad(fragment_unnamed_9007, fragment_unnamed_9001, asfloat(((fragment_unnamed_8997 < ((-0.0f) - fragment_unnamed_8997)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_9001 * fragment_unnamed_9007, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_8975 * fragment_unnamed_8977, mad(mad(fragment_unnamed_8977, fragment_unnamed_8978, (-0.0f) - fragment_unnamed_8987), fragment_unnamed_8981 * fragment_unnamed_8984, (-0.0f) - ((fragment_unnamed_8980 * fragment_unnamed_8984) * mad(fragment_unnamed_8977, fragment_unnamed_8979, (-0.0f) - fragment_unnamed_8987)))), 0.0f)) * 0.3183098733425140380859375f;
											fragment_unnamed_9027 = asfloat(1065353216u);
											fragment_unnamed_9028 = asfloat(1065353216u);
											fragment_unnamed_9029 = asfloat(1065353216u);
										}
										fragment_unnamed_7967 = fragment_unnamed_9026;
										fragment_unnamed_7969 = fragment_unnamed_9027;
										fragment_unnamed_7971 = fragment_unnamed_9028;
										fragment_unnamed_7973 = fragment_unnamed_9029;
									}
									else
									{
										fragment_unnamed_7967 = asfloat(0u);
										fragment_unnamed_7969 = asfloat(1065353216u);
										fragment_unnamed_7971 = asfloat(1065353216u);
										fragment_unnamed_7973 = asfloat(1065353216u);
									}
									fragment_unnamed_7966 = fragment_unnamed_7967;
									fragment_unnamed_7968 = fragment_unnamed_7969;
									fragment_unnamed_7970 = fragment_unnamed_7971;
									fragment_unnamed_7972 = fragment_unnamed_7973;
								}
								else
								{
									fragment_unnamed_7966 = asfloat(0u);
									fragment_unnamed_7968 = asfloat(1065353216u);
									fragment_unnamed_7970 = asfloat(1065353216u);
									fragment_unnamed_7972 = asfloat(1065353216u);
								}
								float fragment_unnamed_7976 = (asfloat(fragment_unnamed_7359.x) * fragment_unnamed_5546) * fragment_unnamed_7966;
								float fragment_unnamed_9213;
								float fragment_unnamed_9215;
								float fragment_unnamed_9217;
								float fragment_unnamed_9219;
								if (fragment_unnamed_7411 == 0u)
								{
									float fragment_unnamed_9030 = dot(float2(fragment_unnamed_3219, fragment_unnamed_1242), float2(fragment_unnamed_7370, fragment_unnamed_7364));
									float fragment_unnamed_9033 = dot(float2(fragment_unnamed_3219, fragment_unnamed_1242), float2(fragment_unnamed_7379, fragment_unnamed_7373));
									float fragment_unnamed_9036 = dot(float2(fragment_unnamed_1242, fragment_unnamed_3219), float2(fragment_unnamed_7382, fragment_unnamed_7388));
									float fragment_unnamed_9214;
									float fragment_unnamed_9216;
									float fragment_unnamed_9218;
									float fragment_unnamed_9220;
									if (0.0f < mad(fragment_unnamed_5504, abs(fragment_unnamed_9036), mad(fragment_unnamed_5503, abs(fragment_unnamed_9033), fragment_unnamed_9030)))
									{
										float fragment_unnamed_9201 = dot(float2(fragment_unnamed_1244, fragment_unnamed_1241), float2(fragment_unnamed_7370, fragment_unnamed_7364));
										float fragment_unnamed_9204 = fragment_unnamed_1243 * fragment_unnamed_7367;
										float fragment_unnamed_9205 = dot(float2(fragment_unnamed_1244, fragment_unnamed_1241), float2(fragment_unnamed_7379, fragment_unnamed_7373));
										float fragment_unnamed_9208 = fragment_unnamed_1243 * fragment_unnamed_7376;
										float fragment_unnamed_9562;
										float fragment_unnamed_9563;
										float fragment_unnamed_9564;
										float fragment_unnamed_9565;
										if (fragment_unnamed_5489)
										{
											float fragment_unnamed_9231 = dot(float2(fragment_unnamed_1241, fragment_unnamed_1244), float2(fragment_unnamed_7382, fragment_unnamed_7388));
											float fragment_unnamed_9234 = fragment_unnamed_7385 * fragment_unnamed_1243;
											float fragment_unnamed_9235 = (-0.0f) - fragment_unnamed_5503;
											float fragment_unnamed_9239 = (-0.0f) - fragment_unnamed_5504;
											float fragment_unnamed_9240 = mad(fragment_unnamed_9239, fragment_unnamed_9231, mad(fragment_unnamed_9235, fragment_unnamed_9205, fragment_unnamed_9201));
											float fragment_unnamed_9241 = mad(fragment_unnamed_9239, fragment_unnamed_9234, mad(fragment_unnamed_9235, fragment_unnamed_9208, fragment_unnamed_9204));
											float fragment_unnamed_9242 = mad(fragment_unnamed_9239, fragment_unnamed_9036, mad(fragment_unnamed_9235, fragment_unnamed_9033, fragment_unnamed_9030));
											float fragment_unnamed_9243 = fragment_unnamed_5488 * fragment_unnamed_9231;
											float fragment_unnamed_9244 = fragment_unnamed_5488 * fragment_unnamed_9234;
											float fragment_unnamed_9245 = fragment_unnamed_5488 * fragment_unnamed_9036;
											float fragment_unnamed_9246 = mad(fragment_unnamed_5488, fragment_unnamed_9036, fragment_unnamed_9242);
											float fragment_unnamed_9247 = mad(fragment_unnamed_5488, fragment_unnamed_9231, fragment_unnamed_9240);
											float fragment_unnamed_9248 = mad(fragment_unnamed_5488, fragment_unnamed_9234, fragment_unnamed_9241);
											float fragment_unnamed_9249 = mad(fragment_unnamed_5486, fragment_unnamed_9033, fragment_unnamed_9246);
											float fragment_unnamed_9250 = mad(fragment_unnamed_5486, fragment_unnamed_9205, fragment_unnamed_9247);
											float fragment_unnamed_9251 = mad(fragment_unnamed_5486, fragment_unnamed_9208, fragment_unnamed_9248);
											float fragment_unnamed_9252 = (-0.0f) - fragment_unnamed_5488;
											float fragment_unnamed_9253 = mad(fragment_unnamed_9252, fragment_unnamed_9231, fragment_unnamed_9250);
											float fragment_unnamed_9254 = mad(fragment_unnamed_9252, fragment_unnamed_9234, fragment_unnamed_9251);
											float fragment_unnamed_9255 = mad(fragment_unnamed_9252, fragment_unnamed_9036, fragment_unnamed_9249);
											float fragment_unnamed_9259 = rsqrt(dot(float3(fragment_unnamed_9240, fragment_unnamed_9241, fragment_unnamed_9242), float3(fragment_unnamed_9240, fragment_unnamed_9241, fragment_unnamed_9242)));
											float fragment_unnamed_9260 = fragment_unnamed_9259 * fragment_unnamed_9241;
											float fragment_unnamed_9261 = fragment_unnamed_9259 * fragment_unnamed_9242;
											float fragment_unnamed_9262 = fragment_unnamed_9259 * fragment_unnamed_9240;
											float fragment_unnamed_9266 = rsqrt(dot(float3(fragment_unnamed_9246, fragment_unnamed_9247, fragment_unnamed_9248), float3(fragment_unnamed_9246, fragment_unnamed_9247, fragment_unnamed_9248)));
											float fragment_unnamed_9267 = fragment_unnamed_9266 * fragment_unnamed_9246;
											float fragment_unnamed_9268 = fragment_unnamed_9266 * fragment_unnamed_9247;
											float fragment_unnamed_9269 = fragment_unnamed_9266 * fragment_unnamed_9248;
											float fragment_unnamed_9273 = rsqrt(dot(float3(fragment_unnamed_9249, fragment_unnamed_9250, fragment_unnamed_9251), float3(fragment_unnamed_9249, fragment_unnamed_9250, fragment_unnamed_9251)));
											float fragment_unnamed_9274 = fragment_unnamed_9273 * fragment_unnamed_9249;
											float fragment_unnamed_9275 = fragment_unnamed_9273 * fragment_unnamed_9250;
											float fragment_unnamed_9276 = fragment_unnamed_9273 * fragment_unnamed_9251;
											float fragment_unnamed_9280 = rsqrt(dot(float3(fragment_unnamed_9253, fragment_unnamed_9254, fragment_unnamed_9255), float3(fragment_unnamed_9253, fragment_unnamed_9254, fragment_unnamed_9255)));
											float fragment_unnamed_9281 = fragment_unnamed_9280 * fragment_unnamed_9255;
											float fragment_unnamed_9282 = fragment_unnamed_9280 * fragment_unnamed_9253;
											float fragment_unnamed_9283 = fragment_unnamed_9280 * fragment_unnamed_9254;
											float fragment_unnamed_9284 = dot(float3(fragment_unnamed_9261, fragment_unnamed_9262, fragment_unnamed_9260), float3(fragment_unnamed_9267, fragment_unnamed_9268, fragment_unnamed_9269));
											float fragment_unnamed_9314 = mad(abs(fragment_unnamed_9284), mad(abs(fragment_unnamed_9284), mad(abs(fragment_unnamed_9284), mad(abs(fragment_unnamed_9284), mad(abs(fragment_unnamed_9284), mad(abs(fragment_unnamed_9284), mad(abs(fragment_unnamed_9284), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9321 = asfloat((fragment_unnamed_9284 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9284, fragment_unnamed_9284, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9314)) : asuint(fragment_unnamed_9314));
											float fragment_unnamed_9322 = dot(float3(fragment_unnamed_9267, fragment_unnamed_9268, fragment_unnamed_9269), float3(fragment_unnamed_9274, fragment_unnamed_9275, fragment_unnamed_9276));
											float fragment_unnamed_9352 = mad(abs(fragment_unnamed_9322), mad(abs(fragment_unnamed_9322), mad(abs(fragment_unnamed_9322), mad(abs(fragment_unnamed_9322), mad(abs(fragment_unnamed_9322), mad(abs(fragment_unnamed_9322), mad(abs(fragment_unnamed_9322), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9359 = asfloat((fragment_unnamed_9322 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9322, fragment_unnamed_9322, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9352)) : asuint(fragment_unnamed_9352));
											float fragment_unnamed_9366 = dot(float3(fragment_unnamed_9274, fragment_unnamed_9275, fragment_unnamed_9276), float3(fragment_unnamed_9281, fragment_unnamed_9282, fragment_unnamed_9283));
											float fragment_unnamed_9396 = mad(abs(fragment_unnamed_9366), mad(abs(fragment_unnamed_9366), mad(abs(fragment_unnamed_9366), mad(abs(fragment_unnamed_9366), mad(abs(fragment_unnamed_9366), mad(abs(fragment_unnamed_9366), mad(abs(fragment_unnamed_9366), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9403 = asfloat((fragment_unnamed_9366 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9366, fragment_unnamed_9366, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9396)) : asuint(fragment_unnamed_9396));
											float fragment_unnamed_9407 = dot(float3(fragment_unnamed_9283, fragment_unnamed_9281, fragment_unnamed_9282), float3(fragment_unnamed_9260, fragment_unnamed_9261, fragment_unnamed_9262));
											float fragment_unnamed_9437 = mad(abs(fragment_unnamed_9407), mad(abs(fragment_unnamed_9407), mad(abs(fragment_unnamed_9407), mad(abs(fragment_unnamed_9407), mad(abs(fragment_unnamed_9407), mad(abs(fragment_unnamed_9407), mad(abs(fragment_unnamed_9407), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9444 = asfloat((fragment_unnamed_9407 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9407, fragment_unnamed_9407, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9437)) : asuint(fragment_unnamed_9437));
											float fragment_unnamed_9447 = mad(mad(fragment_unnamed_9282, fragment_unnamed_9260, (-0.0f) - (fragment_unnamed_9262 * fragment_unnamed_9283)), fragment_unnamed_9444, mad(mad(fragment_unnamed_9275, fragment_unnamed_9283, (-0.0f) - (fragment_unnamed_9276 * fragment_unnamed_9282)), fragment_unnamed_9403, mad(mad(fragment_unnamed_9262, fragment_unnamed_9269, (-0.0f) - (fragment_unnamed_9268 * fragment_unnamed_9260)), fragment_unnamed_9321, fragment_unnamed_9359 * mad(fragment_unnamed_9268, fragment_unnamed_9276, (-0.0f) - (fragment_unnamed_9269 * fragment_unnamed_9275)))));
											float fragment_unnamed_9448 = mad(mad(fragment_unnamed_9283, fragment_unnamed_9261, (-0.0f) - (fragment_unnamed_9260 * fragment_unnamed_9281)), fragment_unnamed_9444, mad(mad(fragment_unnamed_9276, fragment_unnamed_9281, (-0.0f) - (fragment_unnamed_9274 * fragment_unnamed_9283)), fragment_unnamed_9403, mad(mad(fragment_unnamed_9260, fragment_unnamed_9267, (-0.0f) - (fragment_unnamed_9269 * fragment_unnamed_9261)), fragment_unnamed_9321, fragment_unnamed_9359 * mad(fragment_unnamed_9269, fragment_unnamed_9274, (-0.0f) - (fragment_unnamed_9267 * fragment_unnamed_9276))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9449 = mad(mad(fragment_unnamed_9281, fragment_unnamed_9262, (-0.0f) - (fragment_unnamed_9261 * fragment_unnamed_9282)), fragment_unnamed_9444, mad(mad(fragment_unnamed_9274, fragment_unnamed_9282, (-0.0f) - (fragment_unnamed_9275 * fragment_unnamed_9281)), fragment_unnamed_9403, mad(mad(fragment_unnamed_9261, fragment_unnamed_9268, (-0.0f) - (fragment_unnamed_9267 * fragment_unnamed_9262)), fragment_unnamed_9321, fragment_unnamed_9359 * mad(fragment_unnamed_9267, fragment_unnamed_9275, (-0.0f) - (fragment_unnamed_9268 * fragment_unnamed_9274))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9450 = fragment_unnamed_9447 * 0.15915493667125701904296875f;
											float fragment_unnamed_9451 = dot(float3(fragment_unnamed_9448, fragment_unnamed_9449, fragment_unnamed_9450), float3(fragment_unnamed_9448, fragment_unnamed_9449, fragment_unnamed_9450));
											float fragment_unnamed_9702;
											float fragment_unnamed_9703;
											float fragment_unnamed_9704;
											if (fragment_unnamed_5411 != 0u)
											{
												float fragment_unnamed_9569 = ((-0.0f) - fragment_unnamed_9240) + fragment_unnamed_9253;
												float fragment_unnamed_9570 = ((-0.0f) - fragment_unnamed_9241) + fragment_unnamed_9254;
												float fragment_unnamed_9571 = ((-0.0f) - fragment_unnamed_9242) + fragment_unnamed_9255;
												float fragment_unnamed_9578 = mad(fragment_unnamed_9570, fragment_unnamed_9245, (-0.0f) - (fragment_unnamed_9244 * fragment_unnamed_9571));
												float fragment_unnamed_9579 = mad(fragment_unnamed_9571, fragment_unnamed_9243, (-0.0f) - (fragment_unnamed_9245 * fragment_unnamed_9569));
												float fragment_unnamed_9580 = mad(fragment_unnamed_9569, fragment_unnamed_9244, (-0.0f) - (fragment_unnamed_9243 * fragment_unnamed_9570));
												float fragment_unnamed_9584 = rsqrt(dot(float3(fragment_unnamed_9578, fragment_unnamed_9579, fragment_unnamed_9580), float3(fragment_unnamed_9578, fragment_unnamed_9579, fragment_unnamed_9580)));
												float fragment_unnamed_9585 = fragment_unnamed_9584 * fragment_unnamed_9578;
												float fragment_unnamed_9586 = fragment_unnamed_9584 * fragment_unnamed_9579;
												float fragment_unnamed_9587 = fragment_unnamed_9584 * fragment_unnamed_9580;
												float fragment_unnamed_9594 = dot(float3(fragment_unnamed_9240, fragment_unnamed_9241, fragment_unnamed_9242), float3(fragment_unnamed_9585, fragment_unnamed_9586, fragment_unnamed_9587)) / dot(float3(fragment_unnamed_9448, fragment_unnamed_9449, fragment_unnamed_9450), float3(fragment_unnamed_9585, fragment_unnamed_9586, fragment_unnamed_9587));
												float fragment_unnamed_9598 = mad(fragment_unnamed_9594, fragment_unnamed_9585, (-0.0f) - fragment_unnamed_9240);
												float fragment_unnamed_9599 = mad(fragment_unnamed_9594, fragment_unnamed_9586, (-0.0f) - fragment_unnamed_9241);
												float fragment_unnamed_9600 = mad(fragment_unnamed_9594, fragment_unnamed_9587, (-0.0f) - fragment_unnamed_9242);
												float fragment_unnamed_9604 = 1.0f / dot(float3(fragment_unnamed_9569, fragment_unnamed_9570, fragment_unnamed_9571), float3(fragment_unnamed_9569, fragment_unnamed_9570, fragment_unnamed_9571));
												float fragment_unnamed_9605 = dot(float3(fragment_unnamed_9243, fragment_unnamed_9244, fragment_unnamed_9245), float3(fragment_unnamed_9569, fragment_unnamed_9570, fragment_unnamed_9571));
												float fragment_unnamed_9614 = mad((-0.0f) - (fragment_unnamed_9569 * fragment_unnamed_9605), fragment_unnamed_9604, fragment_unnamed_9243);
												float fragment_unnamed_9615 = mad((-0.0f) - (fragment_unnamed_9570 * fragment_unnamed_9605), fragment_unnamed_9604, fragment_unnamed_9244);
												float fragment_unnamed_9616 = mad((-0.0f) - (fragment_unnamed_9571 * fragment_unnamed_9605), fragment_unnamed_9604, fragment_unnamed_9245);
												float fragment_unnamed_9623 = dot(float3(fragment_unnamed_9598, fragment_unnamed_9599, fragment_unnamed_9600), float3(fragment_unnamed_9614, fragment_unnamed_9615, fragment_unnamed_9616)) / dot(float3(fragment_unnamed_9614, fragment_unnamed_9615, fragment_unnamed_9616), float3(fragment_unnamed_9614, fragment_unnamed_9615, fragment_unnamed_9616));
												float fragment_unnamed_9636 = round(log2(fragment_unnamed_5454 * fragment_uniform_buffer_0[122u].x));
												float fragment_unnamed_9646 = min(mad(fragment_unnamed_3209, ((-0.0f) - fragment_unnamed_9636) + 3.0f, fragment_unnamed_9636), max(mad(log2(mad(fragment_unnamed_9584 * (fragment_unnamed_9594 * fragment_unnamed_9594), 3.1415927410125732421875f, 9.9999999392252902907785028219223e-09f)), 0.5f, fragment_unnamed_9636), 0.0f));
												float fragment_unnamed_9660 = 1.0f / (fragment_unnamed_5454 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_9661 = 1.0f / (fragment_unnamed_5456 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_9671 = exp2(ceil(max(fragment_unnamed_9646 + ((-0.0f) - fragment_uniform_buffer_0[123u].z), 0.0f)));
												float fragment_unnamed_9675 = fragment_unnamed_5454 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_9676 = fragment_unnamed_5456 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_9679 = fragment_unnamed_9671 / (fragment_unnamed_9675 + fragment_unnamed_9675);
												float fragment_unnamed_9680 = fragment_unnamed_9671 / (fragment_unnamed_9676 + fragment_unnamed_9676);
												float4 fragment_unnamed_9694 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_9679) + 1.0f, max(fragment_unnamed_9679, mad(clamp(mad((-0.0f) - mad((-0.0f) - fragment_unnamed_9605, fragment_unnamed_9623, dot(float3(fragment_unnamed_9598, fragment_unnamed_9599, fragment_unnamed_9600), float3(fragment_unnamed_9569, fragment_unnamed_9570, fragment_unnamed_9571))), fragment_unnamed_9604, 1.0f), 0.0f, 1.0f), fragment_unnamed_5454 * fragment_unnamed_9660, mad((-0.0f) - fragment_unnamed_9660, fragment_unnamed_5454, 1.0f) * 0.5f))), fragment_unnamed_5454, fragment_unnamed_5472), mad(min(((-0.0f) - fragment_unnamed_9680) + 1.0f, max(fragment_unnamed_9680, mad(clamp(fragment_unnamed_9623, 0.0f, 1.0f), fragment_unnamed_5456 * fragment_unnamed_9661, mad((-0.0f) - fragment_unnamed_9661, fragment_unnamed_5456, 1.0f) * 0.5f))), fragment_unnamed_5456, fragment_unnamed_5474)), fragment_unnamed_9646);
												fragment_unnamed_9702 = fragment_unnamed_9694.x;
												fragment_unnamed_9703 = fragment_unnamed_9694.y;
												fragment_unnamed_9704 = fragment_unnamed_9694.z;
											}
											else
											{
												fragment_unnamed_9702 = asfloat(1065353216u);
												fragment_unnamed_9703 = asfloat(1065353216u);
												fragment_unnamed_9704 = asfloat(1065353216u);
											}
											fragment_unnamed_9562 = fragment_unnamed_9702;
											fragment_unnamed_9563 = fragment_unnamed_9703;
											fragment_unnamed_9564 = fragment_unnamed_9704;
											fragment_unnamed_9565 = max(mad(fragment_unnamed_9447, 0.15915493667125701904296875f, fragment_unnamed_9451) / (sqrt(fragment_unnamed_9451) + 1.0f), 0.0f);
										}
										else
										{
											float fragment_unnamed_9463 = mad((-0.0f) - fragment_unnamed_1242, fragment_unnamed_7399, fragment_unnamed_7397) * fragment_unnamed_1243;
											float fragment_unnamed_9464 = fragment_unnamed_3211 * fragment_unnamed_7398;
											float fragment_unnamed_9467 = mad((-0.0f) - fragment_unnamed_1244, fragment_unnamed_7397, fragment_unnamed_1241 * fragment_unnamed_7399) * fragment_unnamed_1243;
											float fragment_unnamed_9478 = (1.0f / fragment_unnamed_9033) * ((-0.0f) - fragment_unnamed_9030);
											bool fragment_unnamed_9479 = fragment_unnamed_9033 >= 0.0f;
											float fragment_unnamed_9494 = dot(float3(fragment_unnamed_9205, fragment_unnamed_9208, fragment_unnamed_9033), float3(fragment_unnamed_9205, fragment_unnamed_9208, fragment_unnamed_9033));
											float fragment_unnamed_9497 = rsqrt(fragment_unnamed_9494);
											float fragment_unnamed_9498 = fragment_unnamed_9494 * fragment_unnamed_9497;
											float fragment_unnamed_9499 = fragment_unnamed_9497 * fragment_unnamed_9205;
											float fragment_unnamed_9500 = fragment_unnamed_9497 * fragment_unnamed_9208;
											float fragment_unnamed_9501 = fragment_unnamed_9497 * fragment_unnamed_9033;
											float fragment_unnamed_9502 = dot(float3(fragment_unnamed_9499, fragment_unnamed_9500, fragment_unnamed_9501), float3(fragment_unnamed_9201, fragment_unnamed_9204, fragment_unnamed_9030));
											float fragment_unnamed_9505 = (-0.0f) - fragment_unnamed_9502;
											float fragment_unnamed_9506 = mad(fragment_unnamed_9505, fragment_unnamed_9499, fragment_unnamed_9201);
											float fragment_unnamed_9507 = mad(fragment_unnamed_9505, fragment_unnamed_9500, fragment_unnamed_9204);
											float fragment_unnamed_9508 = mad(fragment_unnamed_9505, fragment_unnamed_9501, fragment_unnamed_9030);
											float fragment_unnamed_9509 = dot(float3(fragment_unnamed_9506, fragment_unnamed_9507, fragment_unnamed_9508), float3(fragment_unnamed_9506, fragment_unnamed_9507, fragment_unnamed_9508));
											float fragment_unnamed_9512 = rsqrt(fragment_unnamed_9509);
											float fragment_unnamed_9514 = fragment_unnamed_9512 * fragment_unnamed_9508;
											float fragment_unnamed_9515 = mad(asfloat(fragment_unnamed_9479 ? asuint(max(fragment_unnamed_9478, fragment_unnamed_5503)) : asuint(min(fragment_unnamed_9478, fragment_unnamed_5503))), fragment_unnamed_9498, fragment_unnamed_9502);
											float fragment_unnamed_9516 = mad(asfloat(fragment_unnamed_9479 ? asuint(max(fragment_unnamed_9478, (-0.0f) - fragment_unnamed_5503)) : asuint(min(fragment_unnamed_9478, (-0.0f) - fragment_unnamed_5503))), fragment_unnamed_9498, fragment_unnamed_9502);
											float fragment_unnamed_9517 = mad(fragment_unnamed_9515, fragment_unnamed_9515, fragment_unnamed_9509);
											float fragment_unnamed_9518 = mad(fragment_unnamed_9516, fragment_unnamed_9516, fragment_unnamed_9509);
											float fragment_unnamed_9520 = rsqrt(fragment_unnamed_9517 * fragment_unnamed_9518);
											float fragment_unnamed_9521 = fragment_unnamed_9520 * fragment_unnamed_9520;
											float fragment_unnamed_9524 = (fragment_unnamed_9509 * fragment_unnamed_9512) * fragment_unnamed_9501;
											float fragment_unnamed_9534 = min(fragment_unnamed_9520 * mad(fragment_unnamed_9516, fragment_unnamed_9515, fragment_unnamed_9509), 1.0f);
											float fragment_unnamed_9538 = sqrt(((-0.0f) - abs(fragment_unnamed_9534)) + 1.0f);
											float fragment_unnamed_9544 = mad(mad(mad(abs(fragment_unnamed_9534), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_9534), -0.212114393711090087890625f), abs(fragment_unnamed_9534), 1.570728778839111328125f);
											fragment_unnamed_9562 = asfloat(1065353216u);
											fragment_unnamed_9563 = asfloat(1065353216u);
											fragment_unnamed_9564 = asfloat(1065353216u);
											fragment_unnamed_9565 = ((fragment_unnamed_7400 * (abs(fragment_unnamed_3212) * rsqrt(fragment_unnamed_7400 * dot(float3(fragment_unnamed_9463, fragment_unnamed_9464, fragment_unnamed_9467), float3(fragment_unnamed_9463, fragment_unnamed_9464, fragment_unnamed_9467))))) * max(mad(mad(fragment_unnamed_9544, fragment_unnamed_9538, asfloat(((fragment_unnamed_9534 < ((-0.0f) - fragment_unnamed_9534)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_9538 * fragment_unnamed_9544, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_9512 * fragment_unnamed_9514, mad(mad(fragment_unnamed_9514, fragment_unnamed_9515, (-0.0f) - fragment_unnamed_9524), fragment_unnamed_9518 * fragment_unnamed_9521, (-0.0f) - ((fragment_unnamed_9517 * fragment_unnamed_9521) * mad(fragment_unnamed_9514, fragment_unnamed_9516, (-0.0f) - fragment_unnamed_9524)))), 0.0f)) * 0.3183098733425140380859375f;
										}
										fragment_unnamed_9214 = fragment_unnamed_9562;
										fragment_unnamed_9216 = fragment_unnamed_9563;
										fragment_unnamed_9218 = fragment_unnamed_9564;
										fragment_unnamed_9220 = fragment_unnamed_9565;
									}
									else
									{
										fragment_unnamed_9214 = asfloat(1065353216u);
										fragment_unnamed_9216 = asfloat(1065353216u);
										fragment_unnamed_9218 = asfloat(1065353216u);
										fragment_unnamed_9220 = asfloat(0u);
									}
									fragment_unnamed_9213 = fragment_unnamed_9214;
									fragment_unnamed_9215 = fragment_unnamed_9216;
									fragment_unnamed_9217 = fragment_unnamed_9218;
									fragment_unnamed_9219 = fragment_unnamed_9220;
								}
								else
								{
									fragment_unnamed_9213 = asfloat(1065353216u);
									fragment_unnamed_9215 = asfloat(1065353216u);
									fragment_unnamed_9217 = asfloat(1065353216u);
									fragment_unnamed_9219 = asfloat(0u);
								}
								float fragment_unnamed_9221 = (asfloat(fragment_unnamed_7359.y) * fragment_unnamed_5546) * fragment_unnamed_9219;
								fragment_unnamed_7718 = fragment_unnamed_6861 * (fragment_unnamed_9221 * (fragment_unnamed_1201 * fragment_unnamed_9213));
								fragment_unnamed_7720 = fragment_unnamed_6863 * (fragment_unnamed_9221 * (fragment_unnamed_1201 * fragment_unnamed_9215));
								fragment_unnamed_7722 = fragment_unnamed_6865 * (fragment_unnamed_9221 * (fragment_unnamed_1201 * fragment_unnamed_9217));
								fragment_unnamed_7724 = (fragment_unnamed_1171 * fragment_unnamed_6861) * (fragment_unnamed_7976 * fragment_unnamed_7968);
								fragment_unnamed_7726 = (fragment_unnamed_1171 * fragment_unnamed_6863) * (fragment_unnamed_7976 * fragment_unnamed_7970);
								fragment_unnamed_7728 = (fragment_unnamed_1171 * fragment_unnamed_6865) * (fragment_unnamed_7976 * fragment_unnamed_7972);
							}
							else
							{
								fragment_unnamed_7718 = asfloat(0u);
								fragment_unnamed_7720 = asfloat(0u);
								fragment_unnamed_7722 = asfloat(0u);
								fragment_unnamed_7724 = asfloat(0u);
								fragment_unnamed_7726 = asfloat(0u);
								fragment_unnamed_7728 = asfloat(0u);
							}
							fragment_unnamed_3817 = fragment_unnamed_3816 + fragment_unnamed_7724;
							fragment_unnamed_3819 = fragment_unnamed_3818 + fragment_unnamed_7726;
							fragment_unnamed_3821 = fragment_unnamed_3820 + fragment_unnamed_7728;
							fragment_unnamed_3823 = fragment_unnamed_3822 + fragment_unnamed_7718;
							fragment_unnamed_3825 = fragment_unnamed_3824 + fragment_unnamed_7720;
							fragment_unnamed_3827 = fragment_unnamed_3826 + fragment_unnamed_7722;
							fragment_unnamed_3816 = fragment_unnamed_3817;
							fragment_unnamed_3818 = fragment_unnamed_3819;
							fragment_unnamed_3820 = fragment_unnamed_3821;
							fragment_unnamed_3822 = fragment_unnamed_3823;
							fragment_unnamed_3824 = fragment_unnamed_3825;
							fragment_unnamed_3826 = fragment_unnamed_3827;
							fragment_unnamed_3828 = fragment_unnamed_3829;
							continue;
						}
					}
					if (ladder_phi_84)
					{
						break;
					}
					break;
				}
				float fragment_unnamed_4131 = min(fragment_unnamed_778, 1.0f);
				float fragment_unnamed_4162 = mad(fragment_unnamed_733, fragment_unnamed_3816, max(fragment_unnamed_4131 * mad(mad(fragment_unnamed_4131, mad(fragment_unnamed_733, 2.040400028228759765625f, -0.3323999941349029541015625f), mad(fragment_unnamed_733, -4.79510021209716796875f, 0.6417000293731689453125f)), fragment_unnamed_4131, mad(fragment_unnamed_733, 2.755199909210205078125f, 0.69029998779296875f)), fragment_unnamed_4131) * ((fragment_unnamed_1150 * (fragment_unnamed_733 * fragment_unnamed_1171)) * fragment_unnamed_1194));
				float fragment_unnamed_4163 = mad(fragment_unnamed_735, fragment_unnamed_3818, max(fragment_unnamed_4131 * mad(mad(fragment_unnamed_4131, mad(fragment_unnamed_735, 2.040400028228759765625f, -0.3323999941349029541015625f), mad(fragment_unnamed_735, -4.79510021209716796875f, 0.6417000293731689453125f)), fragment_unnamed_4131, mad(fragment_unnamed_735, 2.755199909210205078125f, 0.69029998779296875f)), fragment_unnamed_4131) * ((fragment_unnamed_1151 * (fragment_unnamed_735 * fragment_unnamed_1171)) * fragment_unnamed_1194));
				float fragment_unnamed_4164 = mad(fragment_unnamed_737, fragment_unnamed_3820, max(fragment_unnamed_4131 * mad(mad(fragment_unnamed_4131, mad(fragment_unnamed_737, 2.040400028228759765625f, -0.3323999941349029541015625f), mad(fragment_unnamed_737, -4.79510021209716796875f, 0.6417000293731689453125f)), fragment_unnamed_4131, mad(fragment_unnamed_737, 2.755199909210205078125f, 0.69029998779296875f)), fragment_unnamed_4131) * ((fragment_unnamed_1152 * (fragment_unnamed_737 * fragment_unnamed_1171)) * fragment_unnamed_1194));
				float fragment_unnamed_4168 = mad((1.0f / fragment_unnamed_1166.y) + (-1.0f), 0.039999999105930328369140625f, 1.0f);
				float fragment_unnamed_4178 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				bool fragment_unnamed_4188 = fragment_uniform_buffer_3[23u].x == 0.0f;
				bool fragment_unnamed_4189 = fragment_uniform_buffer_3[23u].x == 1.0f;
				bool fragment_unnamed_4190 = fragment_uniform_buffer_3[23u].x == 4.0f;
				float fragment_unnamed_4200 = asfloat((0.0f != fragment_uniform_buffer_3[23u].y) ? 1065353216u : asuint(fragment_unnamed_529));
				float fragment_unnamed_4201 = (fragment_unnamed_4178 * (fragment_unnamed_4168 * mad(fragment_unnamed_2617, fragment_unnamed_1196, fragment_unnamed_3822))) * fragment_unnamed_4200;
				float fragment_unnamed_4202 = (fragment_unnamed_4178 * (fragment_unnamed_4168 * mad(fragment_unnamed_2619, fragment_unnamed_1196, fragment_unnamed_3824))) * fragment_unnamed_4200;
				float fragment_unnamed_4203 = (fragment_unnamed_4178 * (fragment_unnamed_4168 * mad(fragment_unnamed_2621, fragment_unnamed_1196, fragment_unnamed_3826))) * fragment_unnamed_4200;
				bool fragment_unnamed_4211 = ((fragment_unnamed_4189 ? 4294967295u : 0u) | (fragment_unnamed_4188 ? 4294967295u : 0u)) != 0u;
				uint fragment_unnamed_4217 = fragment_unnamed_4211 ? asuint(mad(fragment_unnamed_4178 * fragment_unnamed_4162, fragment_unnamed_529, fragment_unnamed_4201)) : asuint(mad(fragment_unnamed_4162, fragment_unnamed_4178, fragment_unnamed_4201));
				uint fragment_unnamed_4219 = fragment_unnamed_4211 ? asuint(mad(fragment_unnamed_4178 * fragment_unnamed_4163, fragment_unnamed_529, fragment_unnamed_4202)) : asuint(mad(fragment_unnamed_4163, fragment_unnamed_4178, fragment_unnamed_4202));
				uint fragment_unnamed_4221 = fragment_unnamed_4211 ? asuint(mad(fragment_unnamed_4178 * fragment_unnamed_4164, fragment_unnamed_529, fragment_unnamed_4203)) : asuint(mad(fragment_unnamed_4164, fragment_unnamed_4178, fragment_unnamed_4203));
				float fragment_unnamed_5347;
				float fragment_unnamed_5349;
				float fragment_unnamed_5351;
				uint fragment_unnamed_5353;
				float fragment_unnamed_5355;
				if (asuint(fragment_uniform_buffer_0[211u]).y != 1u)
				{
					float fragment_unnamed_4817 = float(fragment_unnamed_281);
					float fragment_unnamed_4818 = float(fragment_unnamed_282);
					uint fragment_unnamed_4838 = min(T22.Load(1u).x, max(((-T22.Load(0u).x) + 4294967295u), uint(round(dot(float2(fragment_unnamed_4817, fragment_unnamed_4818), float2(fragment_uniform_buffer_0[103u].y * 1.0f, fragment_uniform_buffer_0[103u].x * (-1.0f))) + ((-0.0f) - fragment_uniform_buffer_0[102u].x)))));
					bool fragment_unnamed_4870 = ((((-0.0f) - float((T22.Load(fragment_unnamed_4838 + 2u).x & 65535u) + 4294967295u)) + floor(dot(float2(fragment_unnamed_4817, fragment_unnamed_4818), float2(fragment_uniform_buffer_0[103u].xy)) + ((-0.0f) - fragment_uniform_buffer_0[102u].z))) / (((-0.0f) - fragment_uniform_buffer_0[102u].z) + fragment_uniform_buffer_0[102u].w)) < 0.0f;
					uint fragment_unnamed_4871 = fragment_unnamed_4870 ? 4294967295u : 0u;
					float fragment_unnamed_4872 = asfloat(fragment_unnamed_4871);
					float fragment_unnamed_5348;
					float fragment_unnamed_5350;
					float fragment_unnamed_5352;
					uint fragment_unnamed_5354;
					float fragment_unnamed_5356;
					if (asuint(fragment_uniform_buffer_0[113u]).x != 0u)
					{
						float4 fragment_unnamed_5299 = _RefractiveDepthBuffer.Load(int4(uint3(fragment_unnamed_281, fragment_unnamed_282, 0u), 0u));
						float fragment_unnamed_5301 = fragment_unnamed_5299.x;
						uint4 fragment_unnamed_5302 = _StencilTexture.Load(int4(uint3(fragment_unnamed_281, fragment_unnamed_282, 0u), 0u));
						uint fragment_unnamed_5304 = fragment_unnamed_5302.y;
						uint fragment_unnamed_5306 = fragment_unnamed_5304 & 32u;
						uint fragment_unnamed_5342 = ((fragment_unnamed_5304 & 1u) != 0u) ? 4294967295u : (((((((fragment_unnamed_5301 >= gl_FragCoord.z) ? 4294967295u : 0u) & (fragment_unnamed_4871 & ((fragment_unnamed_5306 != 0u) ? 4294967295u : 0u))) != 0u) ? 3.4028234663852885981170418348452e+38f : gl_FragCoord.z) < asfloat(fragment_unnamed_4870 ? 2139095039u : ((fragment_unnamed_5306 != 0u) ? asuint(fragment_unnamed_5301) : 0u))) ? (fragment_unnamed_4870 ? asuint(fragment_uniform_buffer_0[107u]).x : (uint(_WaterGBufferTexture3.Load(int4(uint3(fragment_unnamed_281, fragment_unnamed_282, 0u), 0u)).w * 255.0f) & 15u)) : 4294967295u);
						float fragment_unnamed_6389;
						float fragment_unnamed_6390;
						float fragment_unnamed_6391;
						uint fragment_unnamed_6392;
						float fragment_unnamed_6393;
						if (fragment_unnamed_5342 == 4294967295u)
						{
							fragment_unnamed_6389 = asfloat(0u);
							fragment_unnamed_6390 = asfloat(0u);
							fragment_unnamed_6391 = asfloat(0u);
							fragment_unnamed_6392 = 0u;
							fragment_unnamed_6393 = asfloat(0u);
						}
						else
						{
							float fragment_unnamed_6546;
							float fragment_unnamed_6547;
							uint fragment_unnamed_6548;
							if (fragment_unnamed_4871 == 0u)
							{
								uint fragment_unnamed_6550 = (fragment_unnamed_5342 * 28u) + 4u;
								uint3 fragment_unnamed_6559 = uint3(T24.Load(fragment_unnamed_6550).x, T24.Load(fragment_unnamed_6550 + 1u).x, T24.Load(fragment_unnamed_6550 + 2u).x);
								float fragment_unnamed_6572 = mad(fragment_unnamed_4817 * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
								float fragment_unnamed_6574 = (-0.0f) - mad(fragment_unnamed_4818 * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
								float fragment_unnamed_6614 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_5301, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_6572, fragment_unnamed_6574 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
								float fragment_unnamed_6627 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_5301, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_6572, fragment_unnamed_6574 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_6614)) + fragment_input_6.x;
								float fragment_unnamed_6628 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_5301, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_6572, fragment_unnamed_6574 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_6614)) + fragment_input_6.y;
								float fragment_unnamed_6629 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_5301, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_6572, fragment_unnamed_6574 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_6614)) + fragment_input_6.z;
								float fragment_unnamed_6633 = sqrt(dot(float3(fragment_unnamed_6627, fragment_unnamed_6628, fragment_unnamed_6629), float3(fragment_unnamed_6627, fragment_unnamed_6628, fragment_unnamed_6629)));
								float fragment_unnamed_6634 = fragment_unnamed_6633 + fragment_unnamed_6633;
								fragment_unnamed_6546 = ((-0.0f) - exp2((asfloat(fragment_unnamed_6559.z) * fragment_unnamed_6634) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_6547 = ((-0.0f) - exp2((asfloat(fragment_unnamed_6559.y) * fragment_unnamed_6634) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_6548 = asuint(((-0.0f) - exp2((asfloat(fragment_unnamed_6559.x) * fragment_unnamed_6634) * (-1.44269502162933349609375f))) + 1.0f);
							}
							else
							{
								fragment_unnamed_6546 = asfloat(0u);
								fragment_unnamed_6547 = asfloat(0u);
								fragment_unnamed_6548 = 0u;
							}
							fragment_unnamed_6389 = fragment_unnamed_6546;
							fragment_unnamed_6390 = asfloat(~fragment_unnamed_4871);
							fragment_unnamed_6391 = fragment_unnamed_6547;
							fragment_unnamed_6392 = fragment_unnamed_6548;
							fragment_unnamed_6393 = fragment_unnamed_4872;
						}
						fragment_unnamed_5348 = fragment_unnamed_6389;
						fragment_unnamed_5350 = fragment_unnamed_6390;
						fragment_unnamed_5352 = fragment_unnamed_6391;
						fragment_unnamed_5354 = fragment_unnamed_6392;
						fragment_unnamed_5356 = fragment_unnamed_6393;
					}
					else
					{
						fragment_unnamed_5348 = asfloat(0u);
						fragment_unnamed_5350 = asfloat(0u);
						fragment_unnamed_5352 = asfloat(0u);
						fragment_unnamed_5354 = 0u;
						fragment_unnamed_5356 = fragment_unnamed_4872;
					}
					fragment_unnamed_5347 = fragment_unnamed_5348;
					fragment_unnamed_5349 = fragment_unnamed_5350;
					fragment_unnamed_5351 = fragment_unnamed_5352;
					fragment_unnamed_5353 = fragment_unnamed_5354;
					fragment_unnamed_5355 = fragment_unnamed_5356;
				}
				else
				{
					fragment_unnamed_5347 = asfloat(0u);
					fragment_unnamed_5349 = asfloat(0u);
					fragment_unnamed_5351 = asfloat(0u);
					fragment_unnamed_5353 = 0u;
					fragment_unnamed_5355 = asfloat(0u);
				}
				float fragment_unnamed_6662;
				float fragment_unnamed_6664;
				float fragment_unnamed_6666;
				float fragment_unnamed_6668;
				uint fragment_unnamed_6670;
				float fragment_unnamed_6672;
				if (asuint(fragment_unnamed_5349) == 0u)
				{
					float fragment_unnamed_6400 = 1.0f / dot(float3(fragment_unnamed_1213, fragment_unnamed_1214, fragment_unnamed_1215), float3((-0.0f) - asfloat(fragment_unnamed_319), (-0.0f) - asfloat(fragment_unnamed_324), (-0.0f) - asfloat(fragment_unnamed_329)));
					float fragment_unnamed_6404 = fragment_unnamed_6400 * (1.0f / gl_FragCoord.w);
					float fragment_unnamed_7035;
					float fragment_unnamed_7037;
					float fragment_unnamed_7039;
					float fragment_unnamed_7041;
					uint fragment_unnamed_7042;
					float fragment_unnamed_7044;
					float fragment_unnamed_7046;
					if (asuint(fragment_uniform_buffer_0[84u]).x != 0u)
					{
						float fragment_unnamed_7045;
						float fragment_unnamed_7608;
						float fragment_unnamed_7610;
						float fragment_unnamed_7612;
						float fragment_unnamed_7615;
						if (asuint(fragment_uniform_buffer_0[84u]).z != 0u)
						{
							float fragment_unnamed_7023 = mad((-0.0f) - fragment_uniform_buffer_0[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_0[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6400, (-0.0f) - fragment_uniform_buffer_0[94u].z), 0.0f)), fragment_uniform_buffer_0[94u].x));
							float fragment_unnamed_7760;
							float fragment_unnamed_7761;
							float fragment_unnamed_7762;
							float fragment_unnamed_7763;
							if (asuint(fragment_uniform_buffer_0[89u]).w == 0u)
							{
								float fragment_unnamed_7436 = fragment_unnamed_291 * fragment_uniform_buffer_0[91u].x;
								float fragment_unnamed_7437 = fragment_unnamed_292 * fragment_uniform_buffer_0[91u].y;
								float fragment_unnamed_7438 = floor(fragment_unnamed_7436);
								float fragment_unnamed_7439 = floor(fragment_unnamed_7437);
								float fragment_unnamed_7444 = ((-0.0f) - frac(fragment_unnamed_7436)) + 1.0f;
								float fragment_unnamed_7445 = ((-0.0f) - frac(fragment_unnamed_7437)) + 1.0f;
								float fragment_unnamed_7446 = fragment_unnamed_7445 * fragment_unnamed_7445;
								float fragment_unnamed_7447 = fragment_unnamed_7444 * fragment_unnamed_7444;
								float fragment_unnamed_7452 = mad(((-0.0f) - fragment_unnamed_7444) + 1.0f, fragment_unnamed_7444, 0.5f);
								float fragment_unnamed_7453 = mad(((-0.0f) - fragment_unnamed_7445) + 1.0f, fragment_unnamed_7445, 0.5f);
								float fragment_unnamed_7460 = ((-0.0f) - fragment_unnamed_7452) + mad((-0.0f) - fragment_unnamed_7447, 0.5f, 1.0f);
								float fragment_unnamed_7461 = ((-0.0f) - fragment_unnamed_7453) + mad((-0.0f) - fragment_unnamed_7446, 0.5f, 1.0f);
								float fragment_unnamed_7462 = fragment_unnamed_7452 * 0.5f;
								float fragment_unnamed_7463 = fragment_unnamed_7453 * 0.5f;
								float fragment_unnamed_7464 = mad(fragment_unnamed_7446, 0.5f, fragment_unnamed_7463);
								float fragment_unnamed_7465 = mad(fragment_unnamed_7447, 0.5f, fragment_unnamed_7462);
								float fragment_unnamed_7466 = mad(fragment_unnamed_7452, 0.5f, fragment_unnamed_7460);
								float fragment_unnamed_7467 = mad(fragment_unnamed_7453, 0.5f, fragment_unnamed_7461);
								float fragment_unnamed_7470 = mad(fragment_unnamed_7462, 1.0f / fragment_unnamed_7465, -0.5f);
								float fragment_unnamed_7471 = mad(fragment_unnamed_7463, 1.0f / fragment_unnamed_7464, -0.5f);
								float fragment_unnamed_7474 = mad(fragment_unnamed_7460, 1.0f / fragment_unnamed_7466, 0.5f);
								float fragment_unnamed_7475 = mad(fragment_unnamed_7461, 1.0f / fragment_unnamed_7467, 0.5f);
								float fragment_unnamed_7485 = fragment_uniform_buffer_0[91u].z * fragment_uniform_buffer_0[92u].x;
								float fragment_unnamed_7486 = fragment_uniform_buffer_0[91u].w * fragment_uniform_buffer_0[92u].y;
								float fragment_unnamed_7506 = fragment_unnamed_7023 * fragment_uniform_buffer_0[92u].z;
								float fragment_unnamed_7507 = fragment_unnamed_7464 * fragment_unnamed_7465;
								float4 fragment_unnamed_7518 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7485 * (fragment_unnamed_7438 + fragment_unnamed_7470), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7486 * (fragment_unnamed_7439 + fragment_unnamed_7471), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7506, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_7524 = fragment_unnamed_7464 * fragment_unnamed_7466;
								float fragment_unnamed_7525 = fragment_unnamed_7465 * fragment_unnamed_7467;
								float4 fragment_unnamed_7534 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7485 * (fragment_unnamed_7438 + fragment_unnamed_7474), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7486 * (fragment_unnamed_7439 + fragment_unnamed_7471), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7506, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float4 fragment_unnamed_7556 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7485 * (fragment_unnamed_7438 + fragment_unnamed_7470), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7486 * (fragment_unnamed_7439 + fragment_unnamed_7475), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7506, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_7566 = fragment_unnamed_7467 * fragment_unnamed_7466;
								float4 fragment_unnamed_7575 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7485 * (fragment_unnamed_7438 + fragment_unnamed_7474), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7486 * (fragment_unnamed_7439 + fragment_unnamed_7475), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7506, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_7760 = mad(fragment_unnamed_7566, fragment_unnamed_7575.y, mad(fragment_unnamed_7525, fragment_unnamed_7556.y, mad(fragment_unnamed_7507, fragment_unnamed_7518.y, fragment_unnamed_7524 * fragment_unnamed_7534.y)));
								fragment_unnamed_7761 = mad(fragment_unnamed_7566, fragment_unnamed_7575.x, mad(fragment_unnamed_7525, fragment_unnamed_7556.x, mad(fragment_unnamed_7507, fragment_unnamed_7518.x, fragment_unnamed_7524 * fragment_unnamed_7534.x)));
								fragment_unnamed_7762 = mad(fragment_unnamed_7566, fragment_unnamed_7575.z, mad(fragment_unnamed_7525, fragment_unnamed_7556.z, mad(fragment_unnamed_7507, fragment_unnamed_7518.z, fragment_unnamed_7524 * fragment_unnamed_7534.z)));
								fragment_unnamed_7763 = mad(fragment_unnamed_7566, fragment_unnamed_7575.w, mad(fragment_unnamed_7525, fragment_unnamed_7556.w, mad(fragment_unnamed_7507, fragment_unnamed_7518.w, fragment_unnamed_7524 * fragment_unnamed_7534.w)));
							}
							else
							{
								float4 fragment_unnamed_7602 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_291 * fragment_uniform_buffer_0[92u].x, fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_292 * fragment_uniform_buffer_0[92u].y, fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7023 * fragment_uniform_buffer_0[92u].z, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_7760 = fragment_unnamed_7602.y;
								fragment_unnamed_7761 = fragment_unnamed_7602.x;
								fragment_unnamed_7762 = fragment_unnamed_7602.z;
								fragment_unnamed_7763 = fragment_unnamed_7602.w;
							}
							float fragment_unnamed_7609 = ((-0.0f) - exp2(fragment_unnamed_7763 * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_7772 = asfloat((fragment_unnamed_7609 >= 5.9604644775390625e-08f) ? asuint(fragment_unnamed_7609 * (1.0f / fragment_unnamed_7763)) : 1065353216u);
							fragment_unnamed_7608 = fragment_unnamed_7609;
							fragment_unnamed_7610 = fragment_unnamed_7760 * fragment_unnamed_7772;
							fragment_unnamed_7612 = fragment_unnamed_7761 * fragment_unnamed_7772;
							fragment_unnamed_7045 = asfloat(asuint(fragment_uniform_buffer_0[96u]).w);
							fragment_unnamed_7615 = fragment_unnamed_7762 * fragment_unnamed_7772;
						}
						else
						{
							fragment_unnamed_7608 = asfloat(0u);
							fragment_unnamed_7610 = asfloat(0u);
							fragment_unnamed_7612 = asfloat(0u);
							fragment_unnamed_7045 = asfloat(0u);
							fragment_unnamed_7615 = asfloat(0u);
						}
						float fragment_unnamed_7621 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_6400, (-0.0f) - fragment_unnamed_7045);
						float fragment_unnamed_7036;
						float fragment_unnamed_7038;
						float fragment_unnamed_7040;
						float fragment_unnamed_7047;
						if (((~asuint(fragment_unnamed_5355)) & ((0.0f < fragment_unnamed_7621) ? 4294967295u : 0u)) != 0u)
						{
							float fragment_unnamed_7782 = dot(float3(fragment_unnamed_344, fragment_unnamed_345, fragment_unnamed_346), float3(fragment_uniform_buffer_0[83u].xyz));
							float fragment_unnamed_7786 = fragment_unnamed_7045 * ((-0.0f) - fragment_unnamed_7782);
							float fragment_unnamed_7799 = max(abs(fragment_unnamed_7782), 0.001000000047497451305389404296875f);
							float fragment_unnamed_7800 = 1.0f / fragment_unnamed_7799;
							float fragment_unnamed_7803 = min(mad(fragment_unnamed_7621, (-0.0f) - fragment_unnamed_7782, fragment_unnamed_7786), fragment_unnamed_7786);
							float fragment_unnamed_7817 = min(fragment_unnamed_7621, max(fragment_unnamed_7800 * (((-0.0f) - fragment_unnamed_7803) + fragment_uniform_buffer_0[89u].y), 0.0f));
							float fragment_unnamed_7848 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_7799 * ((-0.0f) - (fragment_unnamed_7621 + ((-0.0f) - fragment_unnamed_7817)))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_7803 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_7800 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_7817) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_7850 = ((-0.0f) - fragment_unnamed_7608) + 1.0f;
							float fragment_unnamed_9048;
							float fragment_unnamed_9049;
							float fragment_unnamed_9050;
							if (fragment_uniform_buffer_0[86u].x == 1.0f)
							{
								float4 fragment_unnamed_8009 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_1213, fragment_unnamed_1214, fragment_unnamed_1215, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_0[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6400, (-0.0f) - fragment_uniform_buffer_0[87u].x) / (((-0.0f) - fragment_uniform_buffer_0[87u].x) + fragment_uniform_buffer_0[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_9048 = fragment_unnamed_8009.x * fragment_uniform_buffer_0[85u].x;
								fragment_unnamed_9049 = fragment_unnamed_8009.y * fragment_uniform_buffer_0[85u].y;
								fragment_unnamed_9050 = fragment_unnamed_8009.z * fragment_uniform_buffer_0[85u].z;
							}
							else
							{
								uint4 fragment_unnamed_8024 = asuint(fragment_uniform_buffer_0[85u]);
								fragment_unnamed_9048 = asfloat(fragment_unnamed_8024.x);
								fragment_unnamed_9049 = asfloat(fragment_unnamed_8024.y);
								fragment_unnamed_9050 = asfloat(fragment_unnamed_8024.z);
							}
							float fragment_unnamed_9061 = ((-0.0f) - fragment_unnamed_7848) + 1.0f;
							fragment_unnamed_7036 = mad((-0.0f) - fragment_unnamed_7850, fragment_unnamed_7848, 1.0f);
							fragment_unnamed_7038 = mad((fragment_uniform_buffer_0[88u].y / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_4178 * (fragment_unnamed_7850 * fragment_unnamed_9049)), fragment_unnamed_9061, fragment_unnamed_7610);
							fragment_unnamed_7040 = mad((fragment_uniform_buffer_0[88u].x / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_4178 * (fragment_unnamed_7850 * fragment_unnamed_9048)), fragment_unnamed_9061, fragment_unnamed_7612);
							fragment_unnamed_7047 = mad((fragment_uniform_buffer_0[88u].z / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_4178 * (fragment_unnamed_7850 * fragment_unnamed_9050)), fragment_unnamed_9061, fragment_unnamed_7615);
						}
						else
						{
							fragment_unnamed_7036 = fragment_unnamed_7608;
							fragment_unnamed_7038 = fragment_unnamed_7610;
							fragment_unnamed_7040 = fragment_unnamed_7612;
							fragment_unnamed_7047 = fragment_unnamed_7615;
						}
						fragment_unnamed_7035 = fragment_unnamed_7036;
						fragment_unnamed_7037 = fragment_unnamed_7038;
						fragment_unnamed_7039 = fragment_unnamed_7040;
						fragment_unnamed_7041 = fragment_unnamed_7036;
						fragment_unnamed_7042 = asuint(fragment_unnamed_7036);
						fragment_unnamed_7044 = fragment_unnamed_7045;
						fragment_unnamed_7046 = fragment_unnamed_7047;
					}
					else
					{
						fragment_unnamed_7035 = fragment_unnamed_5347;
						fragment_unnamed_7037 = asfloat(0u);
						fragment_unnamed_7039 = asfloat(0u);
						fragment_unnamed_7041 = fragment_unnamed_5351;
						fragment_unnamed_7042 = fragment_unnamed_5353;
						fragment_unnamed_7044 = asfloat(0u);
						fragment_unnamed_7046 = asfloat(0u);
					}
					float fragment_unnamed_7684;
					float fragment_unnamed_7686;
					float fragment_unnamed_7688;
					float fragment_unnamed_7690;
					uint fragment_unnamed_7692;
					float fragment_unnamed_7694;
					if (asuint(fragment_unnamed_5355) != 0u)
					{
						uint fragment_unnamed_7633 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 4u;
						uint4 fragment_unnamed_7645 = uint4(T24.Load(fragment_unnamed_7633).x, T24.Load(fragment_unnamed_7633 + 1u).x, T24.Load(fragment_unnamed_7633 + 2u).x, T24.Load(fragment_unnamed_7633 + 3u).x);
						float fragment_unnamed_7653 = asfloat(fragment_unnamed_7645.w);
						uint fragment_unnamed_7659 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 20u;
						uint3 fragment_unnamed_7668 = uint3(T24.Load(fragment_unnamed_7659).x, T24.Load(fragment_unnamed_7659 + 1u).x, T24.Load(fragment_unnamed_7659 + 2u).x);
						float fragment_unnamed_7670 = asfloat(fragment_unnamed_7668.x);
						float fragment_unnamed_7672 = asfloat(fragment_unnamed_7668.y);
						float fragment_unnamed_7674 = asfloat(fragment_unnamed_7668.z);
						float fragment_unnamed_7675 = fragment_unnamed_7653 * asfloat(fragment_unnamed_7645.x);
						float fragment_unnamed_7676 = fragment_unnamed_7653 * asfloat(fragment_unnamed_7645.y);
						float fragment_unnamed_7677 = fragment_unnamed_7653 * asfloat(fragment_unnamed_7645.z);
						float fragment_unnamed_7682 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_6400, (-0.0f) - fragment_unnamed_7044);
						float fragment_unnamed_7687;
						float fragment_unnamed_7689;
						float fragment_unnamed_7695;
						float fragment_unnamed_8031;
						float fragment_unnamed_8032;
						float fragment_unnamed_8033;
						if (0.0f < fragment_unnamed_7682)
						{
							uint fragment_unnamed_7864 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 16u;
							uint3 fragment_unnamed_7873 = uint3(T24.Load(fragment_unnamed_7864).x, T24.Load(fragment_unnamed_7864 + 1u).x, T24.Load(fragment_unnamed_7864 + 2u).x);
							float fragment_unnamed_7880 = dot(float3(fragment_unnamed_344, fragment_unnamed_345, fragment_unnamed_346), float3(fragment_unnamed_7670, fragment_unnamed_7672, fragment_unnamed_7674));
							float fragment_unnamed_7883 = fragment_unnamed_7682 * fragment_unnamed_7675;
							float fragment_unnamed_7884 = fragment_unnamed_7682 * fragment_unnamed_7676;
							float fragment_unnamed_7885 = fragment_unnamed_7682 * fragment_unnamed_7677;
							float fragment_unnamed_7893 = fragment_unnamed_4178 * (((-0.0f) - asfloat(fragment_unnamed_7042)) + 1.0f);
							float fragment_unnamed_7894 = fragment_unnamed_4178 * (((-0.0f) - fragment_unnamed_7041) + 1.0f);
							float fragment_unnamed_7895 = fragment_unnamed_4178 * (((-0.0f) - fragment_unnamed_7035) + 1.0f);
							bool fragment_unnamed_7897 = ((-0.0f) - fragment_unnamed_7880) != 1.0f;
							float fragment_unnamed_7899 = 1.0f / (fragment_unnamed_7880 + 1.0f);
							float fragment_unnamed_7903 = (-0.0f) - fragment_unnamed_7880;
							fragment_unnamed_8031 = fragment_unnamed_7883;
							fragment_unnamed_8032 = fragment_unnamed_7884;
							fragment_unnamed_8033 = fragment_unnamed_7885;
							fragment_unnamed_7687 = mad(asfloat(fragment_unnamed_7897 ? asuint(fragment_unnamed_7894 * (fragment_unnamed_7899 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7884, fragment_unnamed_7903, fragment_unnamed_7884) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7894)), asfloat(fragment_unnamed_7873.y), fragment_unnamed_7037);
							fragment_unnamed_7689 = mad(asfloat(fragment_unnamed_7897 ? asuint(fragment_unnamed_7893 * (fragment_unnamed_7899 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7883, fragment_unnamed_7903, fragment_unnamed_7883) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7893)), asfloat(fragment_unnamed_7873.x), fragment_unnamed_7039);
							fragment_unnamed_7695 = mad(asfloat(fragment_unnamed_7897 ? asuint(fragment_unnamed_7895 * (fragment_unnamed_7899 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7885, fragment_unnamed_7903, fragment_unnamed_7885) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7895)), asfloat(fragment_unnamed_7873.z), fragment_unnamed_7046);
						}
						else
						{
							fragment_unnamed_8031 = asfloat(0u);
							fragment_unnamed_8032 = asfloat(0u);
							fragment_unnamed_8033 = asfloat(0u);
							fragment_unnamed_7687 = fragment_unnamed_7037;
							fragment_unnamed_7689 = fragment_unnamed_7039;
							fragment_unnamed_7695 = fragment_unnamed_7046;
						}
						float fragment_unnamed_8049 = max(((-0.0f) - dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_unnamed_7670, fragment_unnamed_7672, fragment_unnamed_7674))) + ((-0.0f) - asfloat(T21.Load(0u).x)), 0.0f);
						fragment_unnamed_7684 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_7035) + 1.0f), exp2(mad(fragment_unnamed_8049, fragment_unnamed_7677, fragment_unnamed_8033) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_7686 = fragment_unnamed_7687;
						fragment_unnamed_7688 = fragment_unnamed_7689;
						fragment_unnamed_7690 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_7041) + 1.0f), exp2(mad(fragment_unnamed_8049, fragment_unnamed_7676, fragment_unnamed_8032) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_7692 = asuint(mad((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_7042)) + 1.0f), exp2(mad(fragment_unnamed_8049, fragment_unnamed_7675, fragment_unnamed_8031) * (-1.44269502162933349609375f)), 1.0f));
						fragment_unnamed_7694 = fragment_unnamed_7695;
					}
					else
					{
						fragment_unnamed_7684 = fragment_unnamed_7035;
						fragment_unnamed_7686 = fragment_unnamed_7037;
						fragment_unnamed_7688 = fragment_unnamed_7039;
						fragment_unnamed_7690 = fragment_unnamed_7041;
						fragment_unnamed_7692 = fragment_unnamed_7042;
						fragment_unnamed_7694 = fragment_unnamed_7046;
					}
					float fragment_unnamed_6663;
					float fragment_unnamed_6665;
					float fragment_unnamed_6667;
					float fragment_unnamed_6669;
					uint fragment_unnamed_6671;
					float fragment_unnamed_6673;
					if (asuint(fragment_unnamed_5355) == 0u)
					{
						float fragment_unnamed_7948;
						float fragment_unnamed_7949;
						float fragment_unnamed_7950;
						float fragment_unnamed_7951;
						uint fragment_unnamed_7952;
						float fragment_unnamed_7953;
						if (asuint(fragment_uniform_buffer_0[84u]).y != 0u)
						{
							float fragment_unnamed_8076 = fragment_uniform_buffer_0[82u].w + fragment_uniform_buffer_0[83u].w;
							float fragment_unnamed_8082 = dot(float3(fragment_uniform_buffer_0[83u].xyz), float3(fragment_unnamed_1213, fragment_unnamed_1214, fragment_unnamed_1215));
							float fragment_unnamed_8085 = 1.0f / fragment_unnamed_8076;
							float fragment_unnamed_8089 = fragment_unnamed_8085 * fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_8093 = sqrt(max(mad((-0.0f) - fragment_unnamed_8089, fragment_unnamed_8089, 1.0f), 0.0f));
							float fragment_unnamed_8097 = fragment_unnamed_8085 * fragment_uniform_buffer_4[0u].x;
							float fragment_unnamed_8100 = max(mad((-0.0f) - fragment_unnamed_8082, fragment_unnamed_8082, 1.0f), 0.0f);
							float fragment_unnamed_8102 = mad(fragment_unnamed_8097, fragment_unnamed_8097, (-0.0f) - fragment_unnamed_8100);
							float4 fragment_unnamed_8127 = _AtmosphericScatteringLUT.SampleLevel(S0, float3(fragment_unnamed_291, fragment_unnamed_292, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6400, (-0.0f) - max(asfloat((fragment_unnamed_8102 < 0.0f) ? asuint(fragment_unnamed_8102) : asuint(fragment_unnamed_8076 * (((-0.0f) - fragment_unnamed_8082) + ((-0.0f) - sqrt(fragment_unnamed_8102))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
							float fragment_unnamed_8136 = (1.0f / fragment_unnamed_6404) * fragment_uniform_buffer_4[0u].x;
							float fragment_unnamed_8138 = mad(fragment_unnamed_8136, fragment_unnamed_8136, (-0.0f) - fragment_unnamed_8100);
							float fragment_unnamed_8152 = min(max(asfloat((fragment_unnamed_8138 < 0.0f) ? asuint(fragment_unnamed_8138) : asuint((((-0.0f) - sqrt(fragment_unnamed_8138)) + ((-0.0f) - fragment_unnamed_8082)) * fragment_unnamed_6404)), 0.0f) + 128000.0f, fragment_unnamed_6404);
							float fragment_unnamed_8169 = dot(float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z), float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z));
							float fragment_unnamed_8172 = rsqrt(fragment_unnamed_8169);
							float fragment_unnamed_8184 = sqrt(fragment_unnamed_8169);
							float fragment_unnamed_8185 = dot(float3(fragment_unnamed_8172 * ((-0.0f) - fragment_uniform_buffer_0[82u].x), fragment_unnamed_8172 * ((-0.0f) - fragment_uniform_buffer_0[82u].y), fragment_unnamed_8172 * ((-0.0f) - fragment_uniform_buffer_0[82u].z)), float3(fragment_unnamed_344, fragment_unnamed_345, fragment_unnamed_346));
							float fragment_unnamed_8196 = mad(fragment_unnamed_8152, fragment_unnamed_1213, (-0.0f) - fragment_uniform_buffer_0[82u].x);
							float fragment_unnamed_8197 = mad(fragment_unnamed_8152, fragment_unnamed_1214, (-0.0f) - fragment_uniform_buffer_0[82u].y);
							float fragment_unnamed_8198 = mad(fragment_unnamed_8152, fragment_unnamed_1215, (-0.0f) - fragment_uniform_buffer_0[82u].z);
							float fragment_unnamed_8202 = sqrt(dot(float3(fragment_unnamed_8196, fragment_unnamed_8197, fragment_unnamed_8198), float3(fragment_unnamed_8196, fragment_unnamed_8197, fragment_unnamed_8198)));
							float fragment_unnamed_8207 = dot(float3(fragment_unnamed_8196, fragment_unnamed_8197, fragment_unnamed_8198), float3(fragment_unnamed_1213, fragment_unnamed_1214, fragment_unnamed_1215)) * (1.0f / fragment_unnamed_8202);
							float fragment_unnamed_8210 = (fragment_unnamed_8207 >= 0.0f) ? ((-0.0f) - fragment_unnamed_8185) : fragment_unnamed_8185;
							float fragment_unnamed_8215 = fragment_unnamed_8184 * fragment_uniform_buffer_4[1u].x;
							float fragment_unnamed_8216 = fragment_unnamed_8184 * fragment_uniform_buffer_4[1u].z;
							float fragment_unnamed_8220 = sqrt(max(mad((-0.0f) - fragment_unnamed_8210, fragment_unnamed_8210, 1.0f), 0.0f));
							float fragment_unnamed_8225 = abs(fragment_unnamed_8210) * abs(fragment_unnamed_8210);
							float fragment_unnamed_8228 = (-0.0f) - fragment_unnamed_8225;
							float fragment_unnamed_8242 = abs(fragment_unnamed_8210);
							float fragment_unnamed_8249 = abs(fragment_unnamed_8210);
							float fragment_unnamed_8267 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].x, (-0.0f) - fragment_unnamed_8215) * 1.44269502162933349609375f) * mad(fragment_unnamed_8249, 0.5f, (1.0f / mad(fragment_unnamed_8242, fragment_unnamed_8215, sqrt(fragment_unnamed_8215 * mad(fragment_unnamed_8215 * fragment_unnamed_8225, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_8228, fragment_unnamed_8215, mad(fragment_unnamed_8215, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							float fragment_unnamed_8268 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].z, (-0.0f) - fragment_unnamed_8216) * 1.44269502162933349609375f) * mad(fragment_unnamed_8249, 0.5f, (1.0f / mad(fragment_unnamed_8242, fragment_unnamed_8216, sqrt(fragment_unnamed_8216 * mad(fragment_unnamed_8216 * fragment_unnamed_8225, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_8228, fragment_unnamed_8216, mad(fragment_unnamed_8216, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							bool fragment_unnamed_8269 = fragment_unnamed_8210 < 0.0f;
							float fragment_unnamed_8270 = fragment_unnamed_8220 * fragment_unnamed_8215;
							float fragment_unnamed_8271 = fragment_unnamed_8220 * fragment_unnamed_8216;
							float fragment_unnamed_8272 = rsqrt(fragment_unnamed_8270);
							float fragment_unnamed_8273 = rsqrt(fragment_unnamed_8271);
							float fragment_unnamed_8316 = fragment_unnamed_8202 * fragment_uniform_buffer_4[1u].x;
							float fragment_unnamed_8317 = fragment_unnamed_8202 * fragment_uniform_buffer_4[1u].z;
							float fragment_unnamed_8322 = abs(fragment_unnamed_8207) * abs(fragment_unnamed_8207);
							float fragment_unnamed_8325 = (-0.0f) - fragment_unnamed_8322;
							float fragment_unnamed_8336 = abs(fragment_unnamed_8207);
							float fragment_unnamed_8343 = abs(fragment_unnamed_8207);
							float fragment_unnamed_8371 = abs(mad((-0.0f) - mad(fragment_unnamed_8343, 0.5f, (mad(fragment_unnamed_8325, fragment_unnamed_8316, mad(fragment_unnamed_8316, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_8336, fragment_unnamed_8316, sqrt(fragment_unnamed_8316 * mad(fragment_unnamed_8316 * fragment_unnamed_8322, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].x, (-0.0f) - fragment_unnamed_8316) * 1.44269502162933349609375f), asfloat(fragment_unnamed_8269 ? asuint(mad((fragment_unnamed_8272 + dot(fragment_unnamed_8270.xx, fragment_unnamed_8272.xx)) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].x, (-0.0f) - fragment_unnamed_8270) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_8267)) : asuint(fragment_unnamed_8267)))) * fragment_uniform_buffer_4[1u].y;
							float fragment_unnamed_8373 = 1.0f / fragment_unnamed_8184;
							float fragment_unnamed_8378 = fragment_unnamed_8373 * fragment_uniform_buffer_4[2u].z;
							float fragment_unnamed_8379 = fragment_unnamed_8373 * fragment_uniform_buffer_4[2u].w;
							float fragment_unnamed_8383 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_8185, fragment_unnamed_8185, 1.0f), 0.0f);
							float fragment_unnamed_8384 = mad(fragment_unnamed_8378, fragment_unnamed_8378, fragment_unnamed_8383);
							float fragment_unnamed_8385 = mad(fragment_unnamed_8379, fragment_unnamed_8379, fragment_unnamed_8383);
							bool fragment_unnamed_8386 = fragment_unnamed_8384 < 0.0f;
							bool fragment_unnamed_8387 = fragment_unnamed_8385 < 0.0f;
							float fragment_unnamed_8388 = sqrt(fragment_unnamed_8384);
							float fragment_unnamed_8389 = sqrt(fragment_unnamed_8385);
							uint fragment_unnamed_8400 = asuint(fragment_unnamed_8384);
							uint fragment_unnamed_8403 = fragment_unnamed_8386 ? fragment_unnamed_8400 : asuint(fragment_unnamed_8184 * (fragment_unnamed_8185 + ((-0.0f) - fragment_unnamed_8388)));
							float fragment_unnamed_8404 = asfloat(fragment_unnamed_8403);
							uint fragment_unnamed_8405 = fragment_unnamed_8386 ? fragment_unnamed_8400 : asuint(fragment_unnamed_8184 * (fragment_unnamed_8185 + fragment_unnamed_8388));
							float fragment_unnamed_8406 = asfloat(fragment_unnamed_8405);
							uint fragment_unnamed_8407 = asuint(fragment_unnamed_8385);
							uint fragment_unnamed_8412 = fragment_unnamed_8387 ? fragment_unnamed_8407 : asuint(fragment_unnamed_8184 * (fragment_unnamed_8185 + fragment_unnamed_8389));
							bool fragment_unnamed_8417 = fragment_unnamed_8404 >= 0.0f;
							float fragment_unnamed_8422 = ((-0.0f) - fragment_unnamed_8406) + asfloat(fragment_unnamed_8412);
							float fragment_unnamed_8425 = max(asfloat(fragment_unnamed_8387 ? fragment_unnamed_8407 : asuint(fragment_unnamed_8184 * (fragment_unnamed_8185 + ((-0.0f) - fragment_unnamed_8389)))), 0.0f);
							uint fragment_unnamed_8426 = fragment_unnamed_8417 ? fragment_unnamed_8403 : fragment_unnamed_8412;
							float fragment_unnamed_8432 = ((-0.0f) - fragment_unnamed_8425) + asfloat(fragment_unnamed_8426);
							bool fragment_unnamed_8435 = (((fragment_unnamed_8406 < fragment_unnamed_8152) ? 4294967295u : 0u) & (fragment_unnamed_8417 ? 4294967295u : 0u)) != 0u;
							bool fragment_unnamed_8441 = (((fragment_unnamed_8404 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_8406 >= 0.0f) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_8446 = asfloat(fragment_unnamed_8441 ? fragment_unnamed_8405 : asuint(fragment_unnamed_8425));
							float fragment_unnamed_8448 = asfloat(fragment_unnamed_8441 ? asuint(fragment_unnamed_8422 * 0.5f) : (fragment_unnamed_8435 ? fragment_unnamed_8405 : asuint(fragment_unnamed_8432 * 0.5f)));
							float fragment_unnamed_8450 = asfloat(fragment_unnamed_8441 ? asuint(fragment_unnamed_8422 * 0.5f) : (fragment_unnamed_8435 ? fragment_unnamed_8426 : asuint(fragment_unnamed_8432 * 0.5f)));
							float fragment_unnamed_8452 = asfloat(fragment_unnamed_8441 ? fragment_unnamed_8412 : (fragment_unnamed_8435 ? fragment_unnamed_8412 : fragment_unnamed_8426));
							float fragment_unnamed_8457 = (-0.0f) - fragment_unnamed_8446;
							float fragment_unnamed_8458 = (-0.0f) - fragment_unnamed_8448;
							float fragment_unnamed_8461 = fragment_unnamed_8457 + min(fragment_unnamed_8152, fragment_unnamed_8450);
							float fragment_unnamed_8462 = fragment_unnamed_8458 + min(fragment_unnamed_8152, fragment_unnamed_8452);
							float fragment_unnamed_8471 = mad(fragment_unnamed_8457 + min(fragment_unnamed_8152, fragment_unnamed_8450), 0.25f, fragment_unnamed_8446);
							float fragment_unnamed_8472 = mad(fragment_unnamed_8458 + min(fragment_unnamed_8152, fragment_unnamed_8452), 0.25f, fragment_unnamed_8448);
							float fragment_unnamed_8473 = mad(fragment_unnamed_8461, 0.75f, fragment_unnamed_8446);
							float fragment_unnamed_8475 = mad(fragment_unnamed_8462, 0.75f, fragment_unnamed_8448);
							float fragment_unnamed_8477 = dot(((-0.0f) - fragment_unnamed_8185).xx, fragment_unnamed_8184.xx);
							float fragment_unnamed_8495 = (-0.0f) - fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_8531 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8475, fragment_unnamed_8475 + fragment_unnamed_8477, fragment_unnamed_8169)) + fragment_unnamed_8495, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_8462, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8473, fragment_unnamed_8473 + fragment_unnamed_8477, fragment_unnamed_8169)) + fragment_unnamed_8495, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_8461, 0.0f) * 0.5f, ((max(fragment_unnamed_8462, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8472, fragment_unnamed_8472 + fragment_unnamed_8477, fragment_unnamed_8169)) + fragment_unnamed_8495, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_8461, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8471, fragment_unnamed_8471 + fragment_unnamed_8477, fragment_unnamed_8169)) + fragment_unnamed_8495, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
							float fragment_unnamed_8536 = (abs(mad((-0.0f) - mad(fragment_unnamed_8343, 0.5f, (mad(fragment_unnamed_8325, fragment_unnamed_8317, mad(fragment_unnamed_8317, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_8336, fragment_unnamed_8317, sqrt(fragment_unnamed_8317 * mad(fragment_unnamed_8317 * fragment_unnamed_8322, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].z, (-0.0f) - fragment_unnamed_8317) * 1.44269502162933349609375f), asfloat(fragment_unnamed_8269 ? asuint(mad((dot(fragment_unnamed_8271.xx, fragment_unnamed_8273.xx) + fragment_unnamed_8273) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].z, (-0.0f) - fragment_unnamed_8271) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_8268)) : asuint(fragment_unnamed_8268)))) * fragment_uniform_buffer_4[1u].w) * fragment_uniform_buffer_4[0u].w;
							float fragment_unnamed_8562 = ((-0.0f) - exp2(mad(fragment_unnamed_8531, fragment_uniform_buffer_4[6u].x, mad(fragment_unnamed_8371, fragment_uniform_buffer_4[3u].x, fragment_unnamed_8536)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8563 = ((-0.0f) - exp2(mad(fragment_unnamed_8531, fragment_uniform_buffer_4[6u].y, mad(fragment_unnamed_8371, fragment_uniform_buffer_4[3u].y, fragment_unnamed_8536)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8564 = ((-0.0f) - exp2(mad(fragment_unnamed_8531, fragment_uniform_buffer_4[6u].z, mad(fragment_unnamed_8371, fragment_uniform_buffer_4[3u].z, fragment_unnamed_8536)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8566 = fragment_unnamed_8564 + (fragment_unnamed_8563 + fragment_unnamed_8562);
							float fragment_unnamed_8567 = fragment_unnamed_8566 * 0.3333333432674407958984375f;
							float fragment_unnamed_8569 = (-0.0f) - fragment_unnamed_8566;
							float fragment_unnamed_8587 = sqrt(((-0.0f) - fragment_unnamed_8093) + 1.0f);
							float fragment_unnamed_8593 = mad(mad(mad(fragment_unnamed_8093, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_8093, -0.212114393711090087890625f), fragment_unnamed_8093, 1.570728778839111328125f);
							float fragment_unnamed_8604 = mad(fragment_unnamed_8593, fragment_unnamed_8587, asfloat(((((-0.0f) - fragment_unnamed_8093) < fragment_unnamed_8093) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_8587 * fragment_unnamed_8593, -2.0f, 3.1415927410125732421875f))));
							float fragment_unnamed_8608 = sqrt(((-0.0f) - abs(fragment_unnamed_8082)) + 1.0f);
							float fragment_unnamed_8614 = mad(mad(mad(abs(fragment_unnamed_8082), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_8082), -0.212114393711090087890625f), abs(fragment_unnamed_8082), 1.570728778839111328125f);
							float fragment_unnamed_8625 = 1.0f / ((-0.0f) - fragment_unnamed_8604);
							float fragment_unnamed_8643 = mad(exp2((clamp(mad(mad(fragment_unnamed_8614, fragment_unnamed_8608, asfloat(((fragment_unnamed_8082 < ((-0.0f) - fragment_unnamed_8082)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_8608 * fragment_unnamed_8614, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_8625, (-0.0f) - (fragment_unnamed_8604 * fragment_unnamed_8625)), 0.0f, 1.0f) * fragment_uniform_buffer_4[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_4[11u].y, (-0.0f) - fragment_uniform_buffer_4[11u].y);
							float fragment_unnamed_8675 = ((-0.0f) - asfloat(fragment_unnamed_7692)) + 1.0f;
							float fragment_unnamed_8676 = ((-0.0f) - fragment_unnamed_7690) + 1.0f;
							float fragment_unnamed_8677 = ((-0.0f) - fragment_unnamed_7684) + 1.0f;
							fragment_unnamed_7948 = mad(fragment_unnamed_8677, mad(mad(fragment_unnamed_8569, 0.3333333432674407958984375f, fragment_unnamed_8564), fragment_uniform_buffer_4[10u].z, fragment_unnamed_8567) * fragment_uniform_buffer_4[10u].w, fragment_unnamed_7684);
							fragment_unnamed_7949 = mad(fragment_unnamed_8676, fragment_unnamed_8127.y * mad(fragment_unnamed_8643, ((-0.0f) - fragment_uniform_buffer_4[8u].y) + fragment_uniform_buffer_4[9u].y, fragment_uniform_buffer_4[8u].y), fragment_unnamed_7686);
							fragment_unnamed_7950 = mad(fragment_unnamed_8675, fragment_unnamed_8127.x * mad(fragment_unnamed_8643, ((-0.0f) - fragment_uniform_buffer_4[8u].x) + fragment_uniform_buffer_4[9u].x, fragment_uniform_buffer_4[8u].x), fragment_unnamed_7688);
							fragment_unnamed_7951 = mad(fragment_unnamed_8676, mad(mad(fragment_unnamed_8569, 0.3333333432674407958984375f, fragment_unnamed_8563), fragment_uniform_buffer_4[10u].z, fragment_unnamed_8567) * fragment_uniform_buffer_4[10u].w, fragment_unnamed_7690);
							fragment_unnamed_7952 = asuint(mad(fragment_unnamed_8675, mad(mad(fragment_unnamed_8569, 0.3333333432674407958984375f, fragment_unnamed_8562), fragment_uniform_buffer_4[10u].z, fragment_unnamed_8567) * fragment_uniform_buffer_4[10u].w, asfloat(fragment_unnamed_7692)));
							fragment_unnamed_7953 = mad(fragment_unnamed_8677, fragment_unnamed_8127.z * mad(fragment_unnamed_8643, ((-0.0f) - fragment_uniform_buffer_4[8u].z) + fragment_uniform_buffer_4[9u].z, fragment_uniform_buffer_4[8u].z), fragment_unnamed_7694);
						}
						else
						{
							fragment_unnamed_7948 = fragment_unnamed_7684;
							fragment_unnamed_7949 = fragment_unnamed_7686;
							fragment_unnamed_7950 = fragment_unnamed_7688;
							fragment_unnamed_7951 = fragment_unnamed_7690;
							fragment_unnamed_7952 = fragment_unnamed_7692;
							fragment_unnamed_7953 = fragment_unnamed_7694;
						}
						fragment_unnamed_6663 = fragment_unnamed_7948;
						fragment_unnamed_6665 = fragment_unnamed_7949;
						fragment_unnamed_6667 = fragment_unnamed_7950;
						fragment_unnamed_6669 = fragment_unnamed_7951;
						fragment_unnamed_6671 = fragment_unnamed_7952;
						fragment_unnamed_6673 = fragment_unnamed_7953;
					}
					else
					{
						fragment_unnamed_6663 = fragment_unnamed_7684;
						fragment_unnamed_6665 = fragment_unnamed_7686;
						fragment_unnamed_6667 = fragment_unnamed_7688;
						fragment_unnamed_6669 = fragment_unnamed_7690;
						fragment_unnamed_6671 = fragment_unnamed_7692;
						fragment_unnamed_6673 = fragment_unnamed_7694;
					}
					fragment_unnamed_6662 = fragment_unnamed_6663;
					fragment_unnamed_6664 = fragment_unnamed_6665;
					fragment_unnamed_6666 = fragment_unnamed_6667;
					fragment_unnamed_6668 = fragment_unnamed_6669;
					fragment_unnamed_6670 = fragment_unnamed_6671;
					fragment_unnamed_6672 = fragment_unnamed_6673;
				}
				else
				{
					fragment_unnamed_6662 = fragment_unnamed_5347;
					fragment_unnamed_6664 = asfloat(0u);
					fragment_unnamed_6666 = asfloat(0u);
					fragment_unnamed_6668 = fragment_unnamed_5351;
					fragment_unnamed_6670 = fragment_unnamed_5353;
					fragment_unnamed_6672 = asfloat(0u);
				}
				float fragment_unnamed_6681 = asfloat(fragment_unnamed_4217) * (((-0.0f) - asfloat(fragment_unnamed_6670)) + 1.0f);
				float fragment_unnamed_6682 = asfloat(fragment_unnamed_4219) * (((-0.0f) - fragment_unnamed_6668) + 1.0f);
				float fragment_unnamed_6683 = asfloat(fragment_unnamed_4221) * (((-0.0f) - fragment_unnamed_6662) + 1.0f);
				float fragment_unnamed_6684 = mad(fragment_unnamed_6666, fragment_unnamed_529, fragment_unnamed_6681);
				float fragment_unnamed_6685 = mad(fragment_unnamed_6664, fragment_unnamed_529, fragment_unnamed_6682);
				float fragment_unnamed_6687 = mad(fragment_unnamed_6672, fragment_unnamed_529, fragment_unnamed_6683);
				fragment_output_0.x = fragment_unnamed_4188 ? fragment_unnamed_6684 : asfloat(fragment_unnamed_4189 ? asuint(fragment_unnamed_6681) : (fragment_unnamed_4190 ? asuint(fragment_unnamed_6684) : fragment_unnamed_4217));
				fragment_output_0.y = fragment_unnamed_4188 ? fragment_unnamed_6685 : asfloat(fragment_unnamed_4189 ? asuint(fragment_unnamed_6682) : (fragment_unnamed_4190 ? asuint(fragment_unnamed_6685) : fragment_unnamed_4219));
				fragment_output_0.z = fragment_unnamed_4188 ? fragment_unnamed_6687 : asfloat(fragment_unnamed_4189 ? asuint(fragment_unnamed_6683) : (fragment_unnamed_4190 ? asuint(fragment_unnamed_6687) : fragment_unnamed_4221));
				fragment_output_0.w = fragment_unnamed_529;
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

				fragment_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_0[74] = float4(_TaaFrameInfo[0], _TaaFrameInfo[1], _TaaFrameInfo[2], _TaaFrameInfo[3]);

				fragment_uniform_buffer_0[82] = float4(_PlanetCenterRadius[0], _PlanetCenterRadius[1], _PlanetCenterRadius[2], _PlanetCenterRadius[3]);

				fragment_uniform_buffer_0[83] = float4(_PlanetUpAltitude[0], _PlanetUpAltitude[1], _PlanetUpAltitude[2], _PlanetUpAltitude[3]);

				fragment_uniform_buffer_0[84] = float4(asfloat(_FogEnabled), fragment_uniform_buffer_0[84][1], fragment_uniform_buffer_0[84][2], fragment_uniform_buffer_0[84][3]);

				fragment_uniform_buffer_0[84] = float4(fragment_uniform_buffer_0[84][0], asfloat(_PBRFogEnabled), fragment_uniform_buffer_0[84][2], fragment_uniform_buffer_0[84][3]);

				fragment_uniform_buffer_0[84] = float4(fragment_uniform_buffer_0[84][0], fragment_uniform_buffer_0[84][1], asfloat(_EnableVolumetricFog), fragment_uniform_buffer_0[84][3]);

				fragment_uniform_buffer_0[84] = float4(fragment_uniform_buffer_0[84][0], fragment_uniform_buffer_0[84][1], fragment_uniform_buffer_0[84][2], _MaxFogDistance);

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

				fragment_uniform_buffer_0[97] = float4(_ShadowAtlasSize[0], _ShadowAtlasSize[1], _ShadowAtlasSize[2], _ShadowAtlasSize[3]);

				fragment_uniform_buffer_0[98] = float4(_CascadeShadowAtlasSize[0], _CascadeShadowAtlasSize[1], _CascadeShadowAtlasSize[2], _CascadeShadowAtlasSize[3]);

				fragment_uniform_buffer_0[99] = float4(_AreaShadowAtlasSize[0], _AreaShadowAtlasSize[1], _AreaShadowAtlasSize[2], _AreaShadowAtlasSize[3]);

				fragment_uniform_buffer_0[100] = float4(_CachedShadowAtlasSize[0], _CachedShadowAtlasSize[1], _CachedShadowAtlasSize[2], _CachedShadowAtlasSize[3]);

				fragment_uniform_buffer_0[101] = float4(_CachedAreaShadowAtlasSize[0], _CachedAreaShadowAtlasSize[1], _CachedAreaShadowAtlasSize[2], _CachedAreaShadowAtlasSize[3]);

				fragment_uniform_buffer_0[102] = float4(_BoundsSS[0], _BoundsSS[1], _BoundsSS[2], _BoundsSS[3]);

				fragment_uniform_buffer_0[103] = float4(_UpDirectionX, fragment_uniform_buffer_0[103][1], fragment_uniform_buffer_0[103][2], fragment_uniform_buffer_0[103][3]);

				fragment_uniform_buffer_0[103] = float4(fragment_uniform_buffer_0[103][0], _UpDirectionY, fragment_uniform_buffer_0[103][2], fragment_uniform_buffer_0[103][3]);

				fragment_uniform_buffer_0[107] = float4(asfloat(_UnderWaterSurfaceIndex), fragment_uniform_buffer_0[107][1], fragment_uniform_buffer_0[107][2], fragment_uniform_buffer_0[107][3]);

				fragment_uniform_buffer_0[113] = float4(asfloat(_PreRefractionPass), fragment_uniform_buffer_0[113][1], fragment_uniform_buffer_0[113][2], fragment_uniform_buffer_0[113][3]);

				fragment_uniform_buffer_0[114] = float4(asfloat(_DirectionalLightCount), fragment_uniform_buffer_0[114][1], fragment_uniform_buffer_0[114][2], fragment_uniform_buffer_0[114][3]);

				fragment_uniform_buffer_0[116] = float4(asfloat(_EnvLightSkyEnabled), fragment_uniform_buffer_0[116][1], fragment_uniform_buffer_0[116][2], fragment_uniform_buffer_0[116][3]);

				fragment_uniform_buffer_0[116] = float4(fragment_uniform_buffer_0[116][0], asfloat(_CascadeShadowCount), fragment_uniform_buffer_0[116][2], fragment_uniform_buffer_0[116][3]);

				fragment_uniform_buffer_0[116] = float4(fragment_uniform_buffer_0[116][0], fragment_uniform_buffer_0[116][1], asfloat(_DirectionalShadowIndex), fragment_uniform_buffer_0[116][3]);

				fragment_uniform_buffer_0[117] = float4(asfloat(_EnableSkyReflection), fragment_uniform_buffer_0[117][1], fragment_uniform_buffer_0[117][2], fragment_uniform_buffer_0[117][3]);

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], _ProbeExposureScale, fragment_uniform_buffer_0[118][2], fragment_uniform_buffer_0[118][3]);

				fragment_uniform_buffer_0[120] = float4(_IndirectDiffuseLightingMultiplier, fragment_uniform_buffer_0[120][1], fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[120] = float4(fragment_uniform_buffer_0[120][0], asfloat(_IndirectDiffuseLightingLayers), fragment_uniform_buffer_0[120][2], fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[120] = float4(fragment_uniform_buffer_0[120][0], fragment_uniform_buffer_0[120][1], _ReflectionLightingMultiplier, fragment_uniform_buffer_0[120][3]);

				fragment_uniform_buffer_0[120] = float4(fragment_uniform_buffer_0[120][0], fragment_uniform_buffer_0[120][1], fragment_uniform_buffer_0[120][2], asfloat(_ReflectionLightingLayers));

				fragment_uniform_buffer_0[121] = float4(_MicroShadowOpacity, fragment_uniform_buffer_0[121][1], fragment_uniform_buffer_0[121][2], fragment_uniform_buffer_0[121][3]);

				fragment_uniform_buffer_0[122] = float4(_CookieAtlasSize[0], _CookieAtlasSize[1], _CookieAtlasSize[2], _CookieAtlasSize[3]);

				fragment_uniform_buffer_0[123] = float4(_CookieAtlasData[0], _CookieAtlasData[1], _CookieAtlasData[2], _CookieAtlasData[3]);

				fragment_uniform_buffer_0[124] = float4(_ReflectionAtlasCubeData[0], _ReflectionAtlasCubeData[1], _ReflectionAtlasCubeData[2], _ReflectionAtlasCubeData[3]);

				fragment_uniform_buffer_0[125] = float4(_ReflectionAtlasPlanarData[0], _ReflectionAtlasPlanarData[1], _ReflectionAtlasPlanarData[2], _ReflectionAtlasPlanarData[3]);

				fragment_uniform_buffer_0[126] = float4(fragment_uniform_buffer_0[126][0], fragment_uniform_buffer_0[126][1], fragment_uniform_buffer_0[126][2], g_fClustBase);

				fragment_uniform_buffer_0[127] = float4(g_fNearPlane, fragment_uniform_buffer_0[127][1], fragment_uniform_buffer_0[127][2], fragment_uniform_buffer_0[127][3]);

				fragment_uniform_buffer_0[127] = float4(fragment_uniform_buffer_0[127][0], g_fFarPlane, fragment_uniform_buffer_0[127][2], fragment_uniform_buffer_0[127][3]);

				fragment_uniform_buffer_0[127] = float4(fragment_uniform_buffer_0[127][0], fragment_uniform_buffer_0[127][1], asfloat(g_iLog2NumClusters), fragment_uniform_buffer_0[127][3]);

				fragment_uniform_buffer_0[127] = float4(fragment_uniform_buffer_0[127][0], fragment_uniform_buffer_0[127][1], fragment_uniform_buffer_0[127][2], asfloat(g_isLogBaseBufferEnabled));

				fragment_uniform_buffer_0[128] = float4(asfloat(_NumTileClusteredX), fragment_uniform_buffer_0[128][1], fragment_uniform_buffer_0[128][2], fragment_uniform_buffer_0[128][3]);

				fragment_uniform_buffer_0[128] = float4(fragment_uniform_buffer_0[128][0], asfloat(_NumTileClusteredY), fragment_uniform_buffer_0[128][2], fragment_uniform_buffer_0[128][3]);

				fragment_uniform_buffer_0[211] = float4(_OffScreenDownsampleFactor, fragment_uniform_buffer_0[211][1], fragment_uniform_buffer_0[211][2], fragment_uniform_buffer_0[211][3]);

				fragment_uniform_buffer_0[211] = float4(fragment_uniform_buffer_0[211][0], asfloat(_OffScreenRendering), fragment_uniform_buffer_0[211][2], fragment_uniform_buffer_0[211][3]);

				fragment_uniform_buffer_0[213] = float4(fragment_uniform_buffer_0[213][0], asfloat(_EnableRayTracedReflections), fragment_uniform_buffer_0[213][2], fragment_uniform_buffer_0[213][3]);

				fragment_uniform_buffer_0[217] = float4(_VolumetricCloudsShadowScale[0], _VolumetricCloudsShadowScale[1], fragment_uniform_buffer_0[217][2], fragment_uniform_buffer_0[217][3]);

				fragment_uniform_buffer_0[217] = float4(fragment_uniform_buffer_0[217][0], fragment_uniform_buffer_0[217][1], fragment_uniform_buffer_0[217][2], _VolumetricCloudsFallBackValue);

				fragment_uniform_buffer_0[218] = float4(_VolumetricCloudsShadowOriginToggle[0], _VolumetricCloudsShadowOriginToggle[1], _VolumetricCloudsShadowOriginToggle[2], _VolumetricCloudsShadowOriginToggle[3]);

				fragment_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

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

				fragment_uniform_buffer_2[0] = float4(_PlanarCaptureVP[0][0][0], _PlanarCaptureVP[0][1][0], _PlanarCaptureVP[0][2][0], _PlanarCaptureVP[0][3][0]);
				fragment_uniform_buffer_2[1] = float4(_PlanarCaptureVP[0][0][1], _PlanarCaptureVP[0][1][1], _PlanarCaptureVP[0][2][1], _PlanarCaptureVP[0][3][1]);
				fragment_uniform_buffer_2[2] = float4(_PlanarCaptureVP[0][0][2], _PlanarCaptureVP[0][1][2], _PlanarCaptureVP[0][2][2], _PlanarCaptureVP[0][3][2]);
				fragment_uniform_buffer_2[3] = float4(_PlanarCaptureVP[0][0][3], _PlanarCaptureVP[0][1][3], _PlanarCaptureVP[0][2][3], _PlanarCaptureVP[0][3][3]);
				fragment_uniform_buffer_2[4] = float4(_PlanarCaptureVP[1][0][0], _PlanarCaptureVP[1][1][0], _PlanarCaptureVP[1][2][0], _PlanarCaptureVP[1][3][0]);
				fragment_uniform_buffer_2[5] = float4(_PlanarCaptureVP[1][0][1], _PlanarCaptureVP[1][1][1], _PlanarCaptureVP[1][2][1], _PlanarCaptureVP[1][3][1]);
				fragment_uniform_buffer_2[6] = float4(_PlanarCaptureVP[1][0][2], _PlanarCaptureVP[1][1][2], _PlanarCaptureVP[1][2][2], _PlanarCaptureVP[1][3][2]);
				fragment_uniform_buffer_2[7] = float4(_PlanarCaptureVP[1][0][3], _PlanarCaptureVP[1][1][3], _PlanarCaptureVP[1][2][3], _PlanarCaptureVP[1][3][3]);
				fragment_uniform_buffer_2[8] = float4(_PlanarCaptureVP[2][0][0], _PlanarCaptureVP[2][1][0], _PlanarCaptureVP[2][2][0], _PlanarCaptureVP[2][3][0]);
				fragment_uniform_buffer_2[9] = float4(_PlanarCaptureVP[2][0][1], _PlanarCaptureVP[2][1][1], _PlanarCaptureVP[2][2][1], _PlanarCaptureVP[2][3][1]);
				fragment_uniform_buffer_2[10] = float4(_PlanarCaptureVP[2][0][2], _PlanarCaptureVP[2][1][2], _PlanarCaptureVP[2][2][2], _PlanarCaptureVP[2][3][2]);
				fragment_uniform_buffer_2[11] = float4(_PlanarCaptureVP[2][0][3], _PlanarCaptureVP[2][1][3], _PlanarCaptureVP[2][2][3], _PlanarCaptureVP[2][3][3]);
				fragment_uniform_buffer_2[12] = float4(_PlanarCaptureVP[3][0][0], _PlanarCaptureVP[3][1][0], _PlanarCaptureVP[3][2][0], _PlanarCaptureVP[3][3][0]);
				fragment_uniform_buffer_2[13] = float4(_PlanarCaptureVP[3][0][1], _PlanarCaptureVP[3][1][1], _PlanarCaptureVP[3][2][1], _PlanarCaptureVP[3][3][1]);
				fragment_uniform_buffer_2[14] = float4(_PlanarCaptureVP[3][0][2], _PlanarCaptureVP[3][1][2], _PlanarCaptureVP[3][2][2], _PlanarCaptureVP[3][3][2]);
				fragment_uniform_buffer_2[15] = float4(_PlanarCaptureVP[3][0][3], _PlanarCaptureVP[3][1][3], _PlanarCaptureVP[3][2][3], _PlanarCaptureVP[3][3][3]);
				fragment_uniform_buffer_2[16] = float4(_PlanarCaptureVP[4][0][0], _PlanarCaptureVP[4][1][0], _PlanarCaptureVP[4][2][0], _PlanarCaptureVP[4][3][0]);
				fragment_uniform_buffer_2[17] = float4(_PlanarCaptureVP[4][0][1], _PlanarCaptureVP[4][1][1], _PlanarCaptureVP[4][2][1], _PlanarCaptureVP[4][3][1]);
				fragment_uniform_buffer_2[18] = float4(_PlanarCaptureVP[4][0][2], _PlanarCaptureVP[4][1][2], _PlanarCaptureVP[4][2][2], _PlanarCaptureVP[4][3][2]);
				fragment_uniform_buffer_2[19] = float4(_PlanarCaptureVP[4][0][3], _PlanarCaptureVP[4][1][3], _PlanarCaptureVP[4][2][3], _PlanarCaptureVP[4][3][3]);
				fragment_uniform_buffer_2[20] = float4(_PlanarCaptureVP[5][0][0], _PlanarCaptureVP[5][1][0], _PlanarCaptureVP[5][2][0], _PlanarCaptureVP[5][3][0]);
				fragment_uniform_buffer_2[21] = float4(_PlanarCaptureVP[5][0][1], _PlanarCaptureVP[5][1][1], _PlanarCaptureVP[5][2][1], _PlanarCaptureVP[5][3][1]);
				fragment_uniform_buffer_2[22] = float4(_PlanarCaptureVP[5][0][2], _PlanarCaptureVP[5][1][2], _PlanarCaptureVP[5][2][2], _PlanarCaptureVP[5][3][2]);
				fragment_uniform_buffer_2[23] = float4(_PlanarCaptureVP[5][0][3], _PlanarCaptureVP[5][1][3], _PlanarCaptureVP[5][2][3], _PlanarCaptureVP[5][3][3]);
				fragment_uniform_buffer_2[24] = float4(_PlanarCaptureVP[6][0][0], _PlanarCaptureVP[6][1][0], _PlanarCaptureVP[6][2][0], _PlanarCaptureVP[6][3][0]);
				fragment_uniform_buffer_2[25] = float4(_PlanarCaptureVP[6][0][1], _PlanarCaptureVP[6][1][1], _PlanarCaptureVP[6][2][1], _PlanarCaptureVP[6][3][1]);
				fragment_uniform_buffer_2[26] = float4(_PlanarCaptureVP[6][0][2], _PlanarCaptureVP[6][1][2], _PlanarCaptureVP[6][2][2], _PlanarCaptureVP[6][3][2]);
				fragment_uniform_buffer_2[27] = float4(_PlanarCaptureVP[6][0][3], _PlanarCaptureVP[6][1][3], _PlanarCaptureVP[6][2][3], _PlanarCaptureVP[6][3][3]);
				fragment_uniform_buffer_2[28] = float4(_PlanarCaptureVP[7][0][0], _PlanarCaptureVP[7][1][0], _PlanarCaptureVP[7][2][0], _PlanarCaptureVP[7][3][0]);
				fragment_uniform_buffer_2[29] = float4(_PlanarCaptureVP[7][0][1], _PlanarCaptureVP[7][1][1], _PlanarCaptureVP[7][2][1], _PlanarCaptureVP[7][3][1]);
				fragment_uniform_buffer_2[30] = float4(_PlanarCaptureVP[7][0][2], _PlanarCaptureVP[7][1][2], _PlanarCaptureVP[7][2][2], _PlanarCaptureVP[7][3][2]);
				fragment_uniform_buffer_2[31] = float4(_PlanarCaptureVP[7][0][3], _PlanarCaptureVP[7][1][3], _PlanarCaptureVP[7][2][3], _PlanarCaptureVP[7][3][3]);
				fragment_uniform_buffer_2[32] = float4(_PlanarCaptureVP[8][0][0], _PlanarCaptureVP[8][1][0], _PlanarCaptureVP[8][2][0], _PlanarCaptureVP[8][3][0]);
				fragment_uniform_buffer_2[33] = float4(_PlanarCaptureVP[8][0][1], _PlanarCaptureVP[8][1][1], _PlanarCaptureVP[8][2][1], _PlanarCaptureVP[8][3][1]);
				fragment_uniform_buffer_2[34] = float4(_PlanarCaptureVP[8][0][2], _PlanarCaptureVP[8][1][2], _PlanarCaptureVP[8][2][2], _PlanarCaptureVP[8][3][2]);
				fragment_uniform_buffer_2[35] = float4(_PlanarCaptureVP[8][0][3], _PlanarCaptureVP[8][1][3], _PlanarCaptureVP[8][2][3], _PlanarCaptureVP[8][3][3]);
				fragment_uniform_buffer_2[36] = float4(_PlanarCaptureVP[9][0][0], _PlanarCaptureVP[9][1][0], _PlanarCaptureVP[9][2][0], _PlanarCaptureVP[9][3][0]);
				fragment_uniform_buffer_2[37] = float4(_PlanarCaptureVP[9][0][1], _PlanarCaptureVP[9][1][1], _PlanarCaptureVP[9][2][1], _PlanarCaptureVP[9][3][1]);
				fragment_uniform_buffer_2[38] = float4(_PlanarCaptureVP[9][0][2], _PlanarCaptureVP[9][1][2], _PlanarCaptureVP[9][2][2], _PlanarCaptureVP[9][3][2]);
				fragment_uniform_buffer_2[39] = float4(_PlanarCaptureVP[9][0][3], _PlanarCaptureVP[9][1][3], _PlanarCaptureVP[9][2][3], _PlanarCaptureVP[9][3][3]);
				fragment_uniform_buffer_2[40] = float4(_PlanarCaptureVP[10][0][0], _PlanarCaptureVP[10][1][0], _PlanarCaptureVP[10][2][0], _PlanarCaptureVP[10][3][0]);
				fragment_uniform_buffer_2[41] = float4(_PlanarCaptureVP[10][0][1], _PlanarCaptureVP[10][1][1], _PlanarCaptureVP[10][2][1], _PlanarCaptureVP[10][3][1]);
				fragment_uniform_buffer_2[42] = float4(_PlanarCaptureVP[10][0][2], _PlanarCaptureVP[10][1][2], _PlanarCaptureVP[10][2][2], _PlanarCaptureVP[10][3][2]);
				fragment_uniform_buffer_2[43] = float4(_PlanarCaptureVP[10][0][3], _PlanarCaptureVP[10][1][3], _PlanarCaptureVP[10][2][3], _PlanarCaptureVP[10][3][3]);
				fragment_uniform_buffer_2[44] = float4(_PlanarCaptureVP[11][0][0], _PlanarCaptureVP[11][1][0], _PlanarCaptureVP[11][2][0], _PlanarCaptureVP[11][3][0]);
				fragment_uniform_buffer_2[45] = float4(_PlanarCaptureVP[11][0][1], _PlanarCaptureVP[11][1][1], _PlanarCaptureVP[11][2][1], _PlanarCaptureVP[11][3][1]);
				fragment_uniform_buffer_2[46] = float4(_PlanarCaptureVP[11][0][2], _PlanarCaptureVP[11][1][2], _PlanarCaptureVP[11][2][2], _PlanarCaptureVP[11][3][2]);
				fragment_uniform_buffer_2[47] = float4(_PlanarCaptureVP[11][0][3], _PlanarCaptureVP[11][1][3], _PlanarCaptureVP[11][2][3], _PlanarCaptureVP[11][3][3]);
				fragment_uniform_buffer_2[48] = float4(_PlanarCaptureVP[12][0][0], _PlanarCaptureVP[12][1][0], _PlanarCaptureVP[12][2][0], _PlanarCaptureVP[12][3][0]);
				fragment_uniform_buffer_2[49] = float4(_PlanarCaptureVP[12][0][1], _PlanarCaptureVP[12][1][1], _PlanarCaptureVP[12][2][1], _PlanarCaptureVP[12][3][1]);
				fragment_uniform_buffer_2[50] = float4(_PlanarCaptureVP[12][0][2], _PlanarCaptureVP[12][1][2], _PlanarCaptureVP[12][2][2], _PlanarCaptureVP[12][3][2]);
				fragment_uniform_buffer_2[51] = float4(_PlanarCaptureVP[12][0][3], _PlanarCaptureVP[12][1][3], _PlanarCaptureVP[12][2][3], _PlanarCaptureVP[12][3][3]);
				fragment_uniform_buffer_2[52] = float4(_PlanarCaptureVP[13][0][0], _PlanarCaptureVP[13][1][0], _PlanarCaptureVP[13][2][0], _PlanarCaptureVP[13][3][0]);
				fragment_uniform_buffer_2[53] = float4(_PlanarCaptureVP[13][0][1], _PlanarCaptureVP[13][1][1], _PlanarCaptureVP[13][2][1], _PlanarCaptureVP[13][3][1]);
				fragment_uniform_buffer_2[54] = float4(_PlanarCaptureVP[13][0][2], _PlanarCaptureVP[13][1][2], _PlanarCaptureVP[13][2][2], _PlanarCaptureVP[13][3][2]);
				fragment_uniform_buffer_2[55] = float4(_PlanarCaptureVP[13][0][3], _PlanarCaptureVP[13][1][3], _PlanarCaptureVP[13][2][3], _PlanarCaptureVP[13][3][3]);
				fragment_uniform_buffer_2[56] = float4(_PlanarCaptureVP[14][0][0], _PlanarCaptureVP[14][1][0], _PlanarCaptureVP[14][2][0], _PlanarCaptureVP[14][3][0]);
				fragment_uniform_buffer_2[57] = float4(_PlanarCaptureVP[14][0][1], _PlanarCaptureVP[14][1][1], _PlanarCaptureVP[14][2][1], _PlanarCaptureVP[14][3][1]);
				fragment_uniform_buffer_2[58] = float4(_PlanarCaptureVP[14][0][2], _PlanarCaptureVP[14][1][2], _PlanarCaptureVP[14][2][2], _PlanarCaptureVP[14][3][2]);
				fragment_uniform_buffer_2[59] = float4(_PlanarCaptureVP[14][0][3], _PlanarCaptureVP[14][1][3], _PlanarCaptureVP[14][2][3], _PlanarCaptureVP[14][3][3]);
				fragment_uniform_buffer_2[60] = float4(_PlanarCaptureVP[15][0][0], _PlanarCaptureVP[15][1][0], _PlanarCaptureVP[15][2][0], _PlanarCaptureVP[15][3][0]);
				fragment_uniform_buffer_2[61] = float4(_PlanarCaptureVP[15][0][1], _PlanarCaptureVP[15][1][1], _PlanarCaptureVP[15][2][1], _PlanarCaptureVP[15][3][1]);
				fragment_uniform_buffer_2[62] = float4(_PlanarCaptureVP[15][0][2], _PlanarCaptureVP[15][1][2], _PlanarCaptureVP[15][2][2], _PlanarCaptureVP[15][3][2]);
				fragment_uniform_buffer_2[63] = float4(_PlanarCaptureVP[15][0][3], _PlanarCaptureVP[15][1][3], _PlanarCaptureVP[15][2][3], _PlanarCaptureVP[15][3][3]);

				fragment_uniform_buffer_2[64] = float4(_PlanarScaleOffset[0][0], _PlanarScaleOffset[0][1], _PlanarScaleOffset[0][2], _PlanarScaleOffset[0][3]);
				fragment_uniform_buffer_2[65] = float4(_PlanarScaleOffset[1][0], _PlanarScaleOffset[1][1], _PlanarScaleOffset[1][2], _PlanarScaleOffset[1][3]);
				fragment_uniform_buffer_2[66] = float4(_PlanarScaleOffset[2][0], _PlanarScaleOffset[2][1], _PlanarScaleOffset[2][2], _PlanarScaleOffset[2][3]);
				fragment_uniform_buffer_2[67] = float4(_PlanarScaleOffset[3][0], _PlanarScaleOffset[3][1], _PlanarScaleOffset[3][2], _PlanarScaleOffset[3][3]);
				fragment_uniform_buffer_2[68] = float4(_PlanarScaleOffset[4][0], _PlanarScaleOffset[4][1], _PlanarScaleOffset[4][2], _PlanarScaleOffset[4][3]);
				fragment_uniform_buffer_2[69] = float4(_PlanarScaleOffset[5][0], _PlanarScaleOffset[5][1], _PlanarScaleOffset[5][2], _PlanarScaleOffset[5][3]);
				fragment_uniform_buffer_2[70] = float4(_PlanarScaleOffset[6][0], _PlanarScaleOffset[6][1], _PlanarScaleOffset[6][2], _PlanarScaleOffset[6][3]);
				fragment_uniform_buffer_2[71] = float4(_PlanarScaleOffset[7][0], _PlanarScaleOffset[7][1], _PlanarScaleOffset[7][2], _PlanarScaleOffset[7][3]);
				fragment_uniform_buffer_2[72] = float4(_PlanarScaleOffset[8][0], _PlanarScaleOffset[8][1], _PlanarScaleOffset[8][2], _PlanarScaleOffset[8][3]);
				fragment_uniform_buffer_2[73] = float4(_PlanarScaleOffset[9][0], _PlanarScaleOffset[9][1], _PlanarScaleOffset[9][2], _PlanarScaleOffset[9][3]);
				fragment_uniform_buffer_2[74] = float4(_PlanarScaleOffset[10][0], _PlanarScaleOffset[10][1], _PlanarScaleOffset[10][2], _PlanarScaleOffset[10][3]);
				fragment_uniform_buffer_2[75] = float4(_PlanarScaleOffset[11][0], _PlanarScaleOffset[11][1], _PlanarScaleOffset[11][2], _PlanarScaleOffset[11][3]);
				fragment_uniform_buffer_2[76] = float4(_PlanarScaleOffset[12][0], _PlanarScaleOffset[12][1], _PlanarScaleOffset[12][2], _PlanarScaleOffset[12][3]);
				fragment_uniform_buffer_2[77] = float4(_PlanarScaleOffset[13][0], _PlanarScaleOffset[13][1], _PlanarScaleOffset[13][2], _PlanarScaleOffset[13][3]);
				fragment_uniform_buffer_2[78] = float4(_PlanarScaleOffset[14][0], _PlanarScaleOffset[14][1], _PlanarScaleOffset[14][2], _PlanarScaleOffset[14][3]);
				fragment_uniform_buffer_2[79] = float4(_PlanarScaleOffset[15][0], _PlanarScaleOffset[15][1], _PlanarScaleOffset[15][2], _PlanarScaleOffset[15][3]);

				fragment_uniform_buffer_2[80] = float4(_CubeScaleOffset[0][0], _CubeScaleOffset[0][1], _CubeScaleOffset[0][2], _CubeScaleOffset[0][3]);
				fragment_uniform_buffer_2[81] = float4(_CubeScaleOffset[1][0], _CubeScaleOffset[1][1], _CubeScaleOffset[1][2], _CubeScaleOffset[1][3]);
				fragment_uniform_buffer_2[82] = float4(_CubeScaleOffset[2][0], _CubeScaleOffset[2][1], _CubeScaleOffset[2][2], _CubeScaleOffset[2][3]);
				fragment_uniform_buffer_2[83] = float4(_CubeScaleOffset[3][0], _CubeScaleOffset[3][1], _CubeScaleOffset[3][2], _CubeScaleOffset[3][3]);
				fragment_uniform_buffer_2[84] = float4(_CubeScaleOffset[4][0], _CubeScaleOffset[4][1], _CubeScaleOffset[4][2], _CubeScaleOffset[4][3]);
				fragment_uniform_buffer_2[85] = float4(_CubeScaleOffset[5][0], _CubeScaleOffset[5][1], _CubeScaleOffset[5][2], _CubeScaleOffset[5][3]);
				fragment_uniform_buffer_2[86] = float4(_CubeScaleOffset[6][0], _CubeScaleOffset[6][1], _CubeScaleOffset[6][2], _CubeScaleOffset[6][3]);
				fragment_uniform_buffer_2[87] = float4(_CubeScaleOffset[7][0], _CubeScaleOffset[7][1], _CubeScaleOffset[7][2], _CubeScaleOffset[7][3]);
				fragment_uniform_buffer_2[88] = float4(_CubeScaleOffset[8][0], _CubeScaleOffset[8][1], _CubeScaleOffset[8][2], _CubeScaleOffset[8][3]);
				fragment_uniform_buffer_2[89] = float4(_CubeScaleOffset[9][0], _CubeScaleOffset[9][1], _CubeScaleOffset[9][2], _CubeScaleOffset[9][3]);
				fragment_uniform_buffer_2[90] = float4(_CubeScaleOffset[10][0], _CubeScaleOffset[10][1], _CubeScaleOffset[10][2], _CubeScaleOffset[10][3]);
				fragment_uniform_buffer_2[91] = float4(_CubeScaleOffset[11][0], _CubeScaleOffset[11][1], _CubeScaleOffset[11][2], _CubeScaleOffset[11][3]);
				fragment_uniform_buffer_2[92] = float4(_CubeScaleOffset[12][0], _CubeScaleOffset[12][1], _CubeScaleOffset[12][2], _CubeScaleOffset[12][3]);
				fragment_uniform_buffer_2[93] = float4(_CubeScaleOffset[13][0], _CubeScaleOffset[13][1], _CubeScaleOffset[13][2], _CubeScaleOffset[13][3]);
				fragment_uniform_buffer_2[94] = float4(_CubeScaleOffset[14][0], _CubeScaleOffset[14][1], _CubeScaleOffset[14][2], _CubeScaleOffset[14][3]);
				fragment_uniform_buffer_2[95] = float4(_CubeScaleOffset[15][0], _CubeScaleOffset[15][1], _CubeScaleOffset[15][2], _CubeScaleOffset[15][3]);
				fragment_uniform_buffer_2[96] = float4(_CubeScaleOffset[16][0], _CubeScaleOffset[16][1], _CubeScaleOffset[16][2], _CubeScaleOffset[16][3]);
				fragment_uniform_buffer_2[97] = float4(_CubeScaleOffset[17][0], _CubeScaleOffset[17][1], _CubeScaleOffset[17][2], _CubeScaleOffset[17][3]);
				fragment_uniform_buffer_2[98] = float4(_CubeScaleOffset[18][0], _CubeScaleOffset[18][1], _CubeScaleOffset[18][2], _CubeScaleOffset[18][3]);
				fragment_uniform_buffer_2[99] = float4(_CubeScaleOffset[19][0], _CubeScaleOffset[19][1], _CubeScaleOffset[19][2], _CubeScaleOffset[19][3]);
				fragment_uniform_buffer_2[100] = float4(_CubeScaleOffset[20][0], _CubeScaleOffset[20][1], _CubeScaleOffset[20][2], _CubeScaleOffset[20][3]);
				fragment_uniform_buffer_2[101] = float4(_CubeScaleOffset[21][0], _CubeScaleOffset[21][1], _CubeScaleOffset[21][2], _CubeScaleOffset[21][3]);
				fragment_uniform_buffer_2[102] = float4(_CubeScaleOffset[22][0], _CubeScaleOffset[22][1], _CubeScaleOffset[22][2], _CubeScaleOffset[22][3]);
				fragment_uniform_buffer_2[103] = float4(_CubeScaleOffset[23][0], _CubeScaleOffset[23][1], _CubeScaleOffset[23][2], _CubeScaleOffset[23][3]);
				fragment_uniform_buffer_2[104] = float4(_CubeScaleOffset[24][0], _CubeScaleOffset[24][1], _CubeScaleOffset[24][2], _CubeScaleOffset[24][3]);
				fragment_uniform_buffer_2[105] = float4(_CubeScaleOffset[25][0], _CubeScaleOffset[25][1], _CubeScaleOffset[25][2], _CubeScaleOffset[25][3]);
				fragment_uniform_buffer_2[106] = float4(_CubeScaleOffset[26][0], _CubeScaleOffset[26][1], _CubeScaleOffset[26][2], _CubeScaleOffset[26][3]);
				fragment_uniform_buffer_2[107] = float4(_CubeScaleOffset[27][0], _CubeScaleOffset[27][1], _CubeScaleOffset[27][2], _CubeScaleOffset[27][3]);
				fragment_uniform_buffer_2[108] = float4(_CubeScaleOffset[28][0], _CubeScaleOffset[28][1], _CubeScaleOffset[28][2], _CubeScaleOffset[28][3]);
				fragment_uniform_buffer_2[109] = float4(_CubeScaleOffset[29][0], _CubeScaleOffset[29][1], _CubeScaleOffset[29][2], _CubeScaleOffset[29][3]);
				fragment_uniform_buffer_2[110] = float4(_CubeScaleOffset[30][0], _CubeScaleOffset[30][1], _CubeScaleOffset[30][2], _CubeScaleOffset[30][3]);
				fragment_uniform_buffer_2[111] = float4(_CubeScaleOffset[31][0], _CubeScaleOffset[31][1], _CubeScaleOffset[31][2], _CubeScaleOffset[31][3]);
				fragment_uniform_buffer_2[112] = float4(_CubeScaleOffset[32][0], _CubeScaleOffset[32][1], _CubeScaleOffset[32][2], _CubeScaleOffset[32][3]);
				fragment_uniform_buffer_2[113] = float4(_CubeScaleOffset[33][0], _CubeScaleOffset[33][1], _CubeScaleOffset[33][2], _CubeScaleOffset[33][3]);
				fragment_uniform_buffer_2[114] = float4(_CubeScaleOffset[34][0], _CubeScaleOffset[34][1], _CubeScaleOffset[34][2], _CubeScaleOffset[34][3]);
				fragment_uniform_buffer_2[115] = float4(_CubeScaleOffset[35][0], _CubeScaleOffset[35][1], _CubeScaleOffset[35][2], _CubeScaleOffset[35][3]);
				fragment_uniform_buffer_2[116] = float4(_CubeScaleOffset[36][0], _CubeScaleOffset[36][1], _CubeScaleOffset[36][2], _CubeScaleOffset[36][3]);
				fragment_uniform_buffer_2[117] = float4(_CubeScaleOffset[37][0], _CubeScaleOffset[37][1], _CubeScaleOffset[37][2], _CubeScaleOffset[37][3]);
				fragment_uniform_buffer_2[118] = float4(_CubeScaleOffset[38][0], _CubeScaleOffset[38][1], _CubeScaleOffset[38][2], _CubeScaleOffset[38][3]);
				fragment_uniform_buffer_2[119] = float4(_CubeScaleOffset[39][0], _CubeScaleOffset[39][1], _CubeScaleOffset[39][2], _CubeScaleOffset[39][3]);
				fragment_uniform_buffer_2[120] = float4(_CubeScaleOffset[40][0], _CubeScaleOffset[40][1], _CubeScaleOffset[40][2], _CubeScaleOffset[40][3]);
				fragment_uniform_buffer_2[121] = float4(_CubeScaleOffset[41][0], _CubeScaleOffset[41][1], _CubeScaleOffset[41][2], _CubeScaleOffset[41][3]);
				fragment_uniform_buffer_2[122] = float4(_CubeScaleOffset[42][0], _CubeScaleOffset[42][1], _CubeScaleOffset[42][2], _CubeScaleOffset[42][3]);
				fragment_uniform_buffer_2[123] = float4(_CubeScaleOffset[43][0], _CubeScaleOffset[43][1], _CubeScaleOffset[43][2], _CubeScaleOffset[43][3]);
				fragment_uniform_buffer_2[124] = float4(_CubeScaleOffset[44][0], _CubeScaleOffset[44][1], _CubeScaleOffset[44][2], _CubeScaleOffset[44][3]);
				fragment_uniform_buffer_2[125] = float4(_CubeScaleOffset[45][0], _CubeScaleOffset[45][1], _CubeScaleOffset[45][2], _CubeScaleOffset[45][3]);
				fragment_uniform_buffer_2[126] = float4(_CubeScaleOffset[46][0], _CubeScaleOffset[46][1], _CubeScaleOffset[46][2], _CubeScaleOffset[46][3]);
				fragment_uniform_buffer_2[127] = float4(_CubeScaleOffset[47][0], _CubeScaleOffset[47][1], _CubeScaleOffset[47][2], _CubeScaleOffset[47][3]);
				fragment_uniform_buffer_2[128] = float4(_CubeScaleOffset[48][0], _CubeScaleOffset[48][1], _CubeScaleOffset[48][2], _CubeScaleOffset[48][3]);
				fragment_uniform_buffer_2[129] = float4(_CubeScaleOffset[49][0], _CubeScaleOffset[49][1], _CubeScaleOffset[49][2], _CubeScaleOffset[49][3]);
				fragment_uniform_buffer_2[130] = float4(_CubeScaleOffset[50][0], _CubeScaleOffset[50][1], _CubeScaleOffset[50][2], _CubeScaleOffset[50][3]);
				fragment_uniform_buffer_2[131] = float4(_CubeScaleOffset[51][0], _CubeScaleOffset[51][1], _CubeScaleOffset[51][2], _CubeScaleOffset[51][3]);
				fragment_uniform_buffer_2[132] = float4(_CubeScaleOffset[52][0], _CubeScaleOffset[52][1], _CubeScaleOffset[52][2], _CubeScaleOffset[52][3]);
				fragment_uniform_buffer_2[133] = float4(_CubeScaleOffset[53][0], _CubeScaleOffset[53][1], _CubeScaleOffset[53][2], _CubeScaleOffset[53][3]);
				fragment_uniform_buffer_2[134] = float4(_CubeScaleOffset[54][0], _CubeScaleOffset[54][1], _CubeScaleOffset[54][2], _CubeScaleOffset[54][3]);
				fragment_uniform_buffer_2[135] = float4(_CubeScaleOffset[55][0], _CubeScaleOffset[55][1], _CubeScaleOffset[55][2], _CubeScaleOffset[55][3]);
				fragment_uniform_buffer_2[136] = float4(_CubeScaleOffset[56][0], _CubeScaleOffset[56][1], _CubeScaleOffset[56][2], _CubeScaleOffset[56][3]);
				fragment_uniform_buffer_2[137] = float4(_CubeScaleOffset[57][0], _CubeScaleOffset[57][1], _CubeScaleOffset[57][2], _CubeScaleOffset[57][3]);
				fragment_uniform_buffer_2[138] = float4(_CubeScaleOffset[58][0], _CubeScaleOffset[58][1], _CubeScaleOffset[58][2], _CubeScaleOffset[58][3]);
				fragment_uniform_buffer_2[139] = float4(_CubeScaleOffset[59][0], _CubeScaleOffset[59][1], _CubeScaleOffset[59][2], _CubeScaleOffset[59][3]);
				fragment_uniform_buffer_2[140] = float4(_CubeScaleOffset[60][0], _CubeScaleOffset[60][1], _CubeScaleOffset[60][2], _CubeScaleOffset[60][3]);
				fragment_uniform_buffer_2[141] = float4(_CubeScaleOffset[61][0], _CubeScaleOffset[61][1], _CubeScaleOffset[61][2], _CubeScaleOffset[61][3]);
				fragment_uniform_buffer_2[142] = float4(_CubeScaleOffset[62][0], _CubeScaleOffset[62][1], _CubeScaleOffset[62][2], _CubeScaleOffset[62][3]);
				fragment_uniform_buffer_2[143] = float4(_CubeScaleOffset[63][0], _CubeScaleOffset[63][1], _CubeScaleOffset[63][2], _CubeScaleOffset[63][3]);
				fragment_uniform_buffer_2[144] = float4(_CubeScaleOffset[64][0], _CubeScaleOffset[64][1], _CubeScaleOffset[64][2], _CubeScaleOffset[64][3]);
				fragment_uniform_buffer_2[145] = float4(_CubeScaleOffset[65][0], _CubeScaleOffset[65][1], _CubeScaleOffset[65][2], _CubeScaleOffset[65][3]);
				fragment_uniform_buffer_2[146] = float4(_CubeScaleOffset[66][0], _CubeScaleOffset[66][1], _CubeScaleOffset[66][2], _CubeScaleOffset[66][3]);
				fragment_uniform_buffer_2[147] = float4(_CubeScaleOffset[67][0], _CubeScaleOffset[67][1], _CubeScaleOffset[67][2], _CubeScaleOffset[67][3]);
				fragment_uniform_buffer_2[148] = float4(_CubeScaleOffset[68][0], _CubeScaleOffset[68][1], _CubeScaleOffset[68][2], _CubeScaleOffset[68][3]);
				fragment_uniform_buffer_2[149] = float4(_CubeScaleOffset[69][0], _CubeScaleOffset[69][1], _CubeScaleOffset[69][2], _CubeScaleOffset[69][3]);
				fragment_uniform_buffer_2[150] = float4(_CubeScaleOffset[70][0], _CubeScaleOffset[70][1], _CubeScaleOffset[70][2], _CubeScaleOffset[70][3]);
				fragment_uniform_buffer_2[151] = float4(_CubeScaleOffset[71][0], _CubeScaleOffset[71][1], _CubeScaleOffset[71][2], _CubeScaleOffset[71][3]);
				fragment_uniform_buffer_2[152] = float4(_CubeScaleOffset[72][0], _CubeScaleOffset[72][1], _CubeScaleOffset[72][2], _CubeScaleOffset[72][3]);
				fragment_uniform_buffer_2[153] = float4(_CubeScaleOffset[73][0], _CubeScaleOffset[73][1], _CubeScaleOffset[73][2], _CubeScaleOffset[73][3]);
				fragment_uniform_buffer_2[154] = float4(_CubeScaleOffset[74][0], _CubeScaleOffset[74][1], _CubeScaleOffset[74][2], _CubeScaleOffset[74][3]);
				fragment_uniform_buffer_2[155] = float4(_CubeScaleOffset[75][0], _CubeScaleOffset[75][1], _CubeScaleOffset[75][2], _CubeScaleOffset[75][3]);
				fragment_uniform_buffer_2[156] = float4(_CubeScaleOffset[76][0], _CubeScaleOffset[76][1], _CubeScaleOffset[76][2], _CubeScaleOffset[76][3]);
				fragment_uniform_buffer_2[157] = float4(_CubeScaleOffset[77][0], _CubeScaleOffset[77][1], _CubeScaleOffset[77][2], _CubeScaleOffset[77][3]);
				fragment_uniform_buffer_2[158] = float4(_CubeScaleOffset[78][0], _CubeScaleOffset[78][1], _CubeScaleOffset[78][2], _CubeScaleOffset[78][3]);
				fragment_uniform_buffer_2[159] = float4(_CubeScaleOffset[79][0], _CubeScaleOffset[79][1], _CubeScaleOffset[79][2], _CubeScaleOffset[79][3]);
				fragment_uniform_buffer_2[160] = float4(_CubeScaleOffset[80][0], _CubeScaleOffset[80][1], _CubeScaleOffset[80][2], _CubeScaleOffset[80][3]);
				fragment_uniform_buffer_2[161] = float4(_CubeScaleOffset[81][0], _CubeScaleOffset[81][1], _CubeScaleOffset[81][2], _CubeScaleOffset[81][3]);
				fragment_uniform_buffer_2[162] = float4(_CubeScaleOffset[82][0], _CubeScaleOffset[82][1], _CubeScaleOffset[82][2], _CubeScaleOffset[82][3]);
				fragment_uniform_buffer_2[163] = float4(_CubeScaleOffset[83][0], _CubeScaleOffset[83][1], _CubeScaleOffset[83][2], _CubeScaleOffset[83][3]);
				fragment_uniform_buffer_2[164] = float4(_CubeScaleOffset[84][0], _CubeScaleOffset[84][1], _CubeScaleOffset[84][2], _CubeScaleOffset[84][3]);
				fragment_uniform_buffer_2[165] = float4(_CubeScaleOffset[85][0], _CubeScaleOffset[85][1], _CubeScaleOffset[85][2], _CubeScaleOffset[85][3]);
				fragment_uniform_buffer_2[166] = float4(_CubeScaleOffset[86][0], _CubeScaleOffset[86][1], _CubeScaleOffset[86][2], _CubeScaleOffset[86][3]);
				fragment_uniform_buffer_2[167] = float4(_CubeScaleOffset[87][0], _CubeScaleOffset[87][1], _CubeScaleOffset[87][2], _CubeScaleOffset[87][3]);
				fragment_uniform_buffer_2[168] = float4(_CubeScaleOffset[88][0], _CubeScaleOffset[88][1], _CubeScaleOffset[88][2], _CubeScaleOffset[88][3]);
				fragment_uniform_buffer_2[169] = float4(_CubeScaleOffset[89][0], _CubeScaleOffset[89][1], _CubeScaleOffset[89][2], _CubeScaleOffset[89][3]);
				fragment_uniform_buffer_2[170] = float4(_CubeScaleOffset[90][0], _CubeScaleOffset[90][1], _CubeScaleOffset[90][2], _CubeScaleOffset[90][3]);
				fragment_uniform_buffer_2[171] = float4(_CubeScaleOffset[91][0], _CubeScaleOffset[91][1], _CubeScaleOffset[91][2], _CubeScaleOffset[91][3]);
				fragment_uniform_buffer_2[172] = float4(_CubeScaleOffset[92][0], _CubeScaleOffset[92][1], _CubeScaleOffset[92][2], _CubeScaleOffset[92][3]);
				fragment_uniform_buffer_2[173] = float4(_CubeScaleOffset[93][0], _CubeScaleOffset[93][1], _CubeScaleOffset[93][2], _CubeScaleOffset[93][3]);
				fragment_uniform_buffer_2[174] = float4(_CubeScaleOffset[94][0], _CubeScaleOffset[94][1], _CubeScaleOffset[94][2], _CubeScaleOffset[94][3]);
				fragment_uniform_buffer_2[175] = float4(_CubeScaleOffset[95][0], _CubeScaleOffset[95][1], _CubeScaleOffset[95][2], _CubeScaleOffset[95][3]);
				fragment_uniform_buffer_2[176] = float4(_CubeScaleOffset[96][0], _CubeScaleOffset[96][1], _CubeScaleOffset[96][2], _CubeScaleOffset[96][3]);
				fragment_uniform_buffer_2[177] = float4(_CubeScaleOffset[97][0], _CubeScaleOffset[97][1], _CubeScaleOffset[97][2], _CubeScaleOffset[97][3]);
				fragment_uniform_buffer_2[178] = float4(_CubeScaleOffset[98][0], _CubeScaleOffset[98][1], _CubeScaleOffset[98][2], _CubeScaleOffset[98][3]);
				fragment_uniform_buffer_2[179] = float4(_CubeScaleOffset[99][0], _CubeScaleOffset[99][1], _CubeScaleOffset[99][2], _CubeScaleOffset[99][3]);
				fragment_uniform_buffer_2[180] = float4(_CubeScaleOffset[100][0], _CubeScaleOffset[100][1], _CubeScaleOffset[100][2], _CubeScaleOffset[100][3]);
				fragment_uniform_buffer_2[181] = float4(_CubeScaleOffset[101][0], _CubeScaleOffset[101][1], _CubeScaleOffset[101][2], _CubeScaleOffset[101][3]);
				fragment_uniform_buffer_2[182] = float4(_CubeScaleOffset[102][0], _CubeScaleOffset[102][1], _CubeScaleOffset[102][2], _CubeScaleOffset[102][3]);
				fragment_uniform_buffer_2[183] = float4(_CubeScaleOffset[103][0], _CubeScaleOffset[103][1], _CubeScaleOffset[103][2], _CubeScaleOffset[103][3]);
				fragment_uniform_buffer_2[184] = float4(_CubeScaleOffset[104][0], _CubeScaleOffset[104][1], _CubeScaleOffset[104][2], _CubeScaleOffset[104][3]);
				fragment_uniform_buffer_2[185] = float4(_CubeScaleOffset[105][0], _CubeScaleOffset[105][1], _CubeScaleOffset[105][2], _CubeScaleOffset[105][3]);
				fragment_uniform_buffer_2[186] = float4(_CubeScaleOffset[106][0], _CubeScaleOffset[106][1], _CubeScaleOffset[106][2], _CubeScaleOffset[106][3]);
				fragment_uniform_buffer_2[187] = float4(_CubeScaleOffset[107][0], _CubeScaleOffset[107][1], _CubeScaleOffset[107][2], _CubeScaleOffset[107][3]);
				fragment_uniform_buffer_2[188] = float4(_CubeScaleOffset[108][0], _CubeScaleOffset[108][1], _CubeScaleOffset[108][2], _CubeScaleOffset[108][3]);
				fragment_uniform_buffer_2[189] = float4(_CubeScaleOffset[109][0], _CubeScaleOffset[109][1], _CubeScaleOffset[109][2], _CubeScaleOffset[109][3]);
				fragment_uniform_buffer_2[190] = float4(_CubeScaleOffset[110][0], _CubeScaleOffset[110][1], _CubeScaleOffset[110][2], _CubeScaleOffset[110][3]);
				fragment_uniform_buffer_2[191] = float4(_CubeScaleOffset[111][0], _CubeScaleOffset[111][1], _CubeScaleOffset[111][2], _CubeScaleOffset[111][3]);
				fragment_uniform_buffer_2[192] = float4(_CubeScaleOffset[112][0], _CubeScaleOffset[112][1], _CubeScaleOffset[112][2], _CubeScaleOffset[112][3]);
				fragment_uniform_buffer_2[193] = float4(_CubeScaleOffset[113][0], _CubeScaleOffset[113][1], _CubeScaleOffset[113][2], _CubeScaleOffset[113][3]);
				fragment_uniform_buffer_2[194] = float4(_CubeScaleOffset[114][0], _CubeScaleOffset[114][1], _CubeScaleOffset[114][2], _CubeScaleOffset[114][3]);
				fragment_uniform_buffer_2[195] = float4(_CubeScaleOffset[115][0], _CubeScaleOffset[115][1], _CubeScaleOffset[115][2], _CubeScaleOffset[115][3]);
				fragment_uniform_buffer_2[196] = float4(_CubeScaleOffset[116][0], _CubeScaleOffset[116][1], _CubeScaleOffset[116][2], _CubeScaleOffset[116][3]);
				fragment_uniform_buffer_2[197] = float4(_CubeScaleOffset[117][0], _CubeScaleOffset[117][1], _CubeScaleOffset[117][2], _CubeScaleOffset[117][3]);
				fragment_uniform_buffer_2[198] = float4(_CubeScaleOffset[118][0], _CubeScaleOffset[118][1], _CubeScaleOffset[118][2], _CubeScaleOffset[118][3]);
				fragment_uniform_buffer_2[199] = float4(_CubeScaleOffset[119][0], _CubeScaleOffset[119][1], _CubeScaleOffset[119][2], _CubeScaleOffset[119][3]);
				fragment_uniform_buffer_2[200] = float4(_CubeScaleOffset[120][0], _CubeScaleOffset[120][1], _CubeScaleOffset[120][2], _CubeScaleOffset[120][3]);
				fragment_uniform_buffer_2[201] = float4(_CubeScaleOffset[121][0], _CubeScaleOffset[121][1], _CubeScaleOffset[121][2], _CubeScaleOffset[121][3]);
				fragment_uniform_buffer_2[202] = float4(_CubeScaleOffset[122][0], _CubeScaleOffset[122][1], _CubeScaleOffset[122][2], _CubeScaleOffset[122][3]);
				fragment_uniform_buffer_2[203] = float4(_CubeScaleOffset[123][0], _CubeScaleOffset[123][1], _CubeScaleOffset[123][2], _CubeScaleOffset[123][3]);
				fragment_uniform_buffer_2[204] = float4(_CubeScaleOffset[124][0], _CubeScaleOffset[124][1], _CubeScaleOffset[124][2], _CubeScaleOffset[124][3]);
				fragment_uniform_buffer_2[205] = float4(_CubeScaleOffset[125][0], _CubeScaleOffset[125][1], _CubeScaleOffset[125][2], _CubeScaleOffset[125][3]);
				fragment_uniform_buffer_2[206] = float4(_CubeScaleOffset[126][0], _CubeScaleOffset[126][1], _CubeScaleOffset[126][2], _CubeScaleOffset[126][3]);
				fragment_uniform_buffer_2[207] = float4(_CubeScaleOffset[127][0], _CubeScaleOffset[127][1], _CubeScaleOffset[127][2], _CubeScaleOffset[127][3]);

				fragment_uniform_buffer_3[2] = float4(_BaseColor[0], _BaseColor[1], _BaseColor[2], _BaseColor[3]);

				fragment_uniform_buffer_3[5] = float4(fragment_uniform_buffer_3[5][0], _SmoothnessRemapMin, fragment_uniform_buffer_3[5][2], fragment_uniform_buffer_3[5][3]);

				fragment_uniform_buffer_3[5] = float4(fragment_uniform_buffer_3[5][0], fragment_uniform_buffer_3[5][1], _SmoothnessRemapMax, fragment_uniform_buffer_3[5][3]);

				fragment_uniform_buffer_3[5] = float4(fragment_uniform_buffer_3[5][0], fragment_uniform_buffer_3[5][1], fragment_uniform_buffer_3[5][2], _AORemapMin);

				fragment_uniform_buffer_3[6] = float4(_AORemapMax, fragment_uniform_buffer_3[6][1], fragment_uniform_buffer_3[6][2], fragment_uniform_buffer_3[6][3]);

				fragment_uniform_buffer_3[8] = float4(_NormalScale, fragment_uniform_buffer_3[8][1], fragment_uniform_buffer_3[8][2], fragment_uniform_buffer_3[8][3]);

				fragment_uniform_buffer_3[8] = float4(fragment_uniform_buffer_3[8][0], _UVBase, fragment_uniform_buffer_3[8][2], fragment_uniform_buffer_3[8][3]);

				fragment_uniform_buffer_3[8] = float4(fragment_uniform_buffer_3[8][0], fragment_uniform_buffer_3[8][1], _WorldMapping, fragment_uniform_buffer_3[8][3]);

				fragment_uniform_buffer_3[8] = float4(fragment_uniform_buffer_3[8][0], fragment_uniform_buffer_3[8][1], fragment_uniform_buffer_3[8][2], _TexWorldScale);

				fragment_uniform_buffer_3[9] = float4(_BaseColorMap_TO[0], _BaseColorMap_TO[1], _BaseColorMap_TO[2], _BaseColorMap_TO[3]);

				fragment_uniform_buffer_3[10] = float4(_EnableDetail, fragment_uniform_buffer_3[10][1], fragment_uniform_buffer_3[10][2], fragment_uniform_buffer_3[10][3]);

				fragment_uniform_buffer_3[12] = float4(_UVDetail, fragment_uniform_buffer_3[12][1], fragment_uniform_buffer_3[12][2], fragment_uniform_buffer_3[12][3]);

				fragment_uniform_buffer_3[12] = float4(fragment_uniform_buffer_3[12][0], _LinkDetailsWithBase, fragment_uniform_buffer_3[12][2], fragment_uniform_buffer_3[12][3]);

				fragment_uniform_buffer_3[12] = float4(fragment_uniform_buffer_3[12][0], fragment_uniform_buffer_3[12][1], _DetailAlbedoScale, fragment_uniform_buffer_3[12][3]);

				fragment_uniform_buffer_3[12] = float4(fragment_uniform_buffer_3[12][0], fragment_uniform_buffer_3[12][1], fragment_uniform_buffer_3[12][2], _DetailNormalScale);

				fragment_uniform_buffer_3[13] = float4(_DetailSmoothnessScale, fragment_uniform_buffer_3[13][1], fragment_uniform_buffer_3[13][2], fragment_uniform_buffer_3[13][3]);

				fragment_uniform_buffer_3[14] = float4(_DetailMap_TO[0], _DetailMap_TO[1], _DetailMap_TO[2], _DetailMap_TO[3]);

				fragment_uniform_buffer_3[23] = float4(_BlendMode, fragment_uniform_buffer_3[23][1], fragment_uniform_buffer_3[23][2], fragment_uniform_buffer_3[23][3]);

				fragment_uniform_buffer_3[23] = float4(fragment_uniform_buffer_3[23][0], _EnableBlendModePreserveSpecularLighting, fragment_uniform_buffer_3[23][2], fragment_uniform_buffer_3[23][3]);

				fragment_uniform_buffer_4[0] = float4(_AtmosphericRadius, fragment_uniform_buffer_4[0][1], fragment_uniform_buffer_4[0][2], fragment_uniform_buffer_4[0][3]);

				fragment_uniform_buffer_4[0] = float4(fragment_uniform_buffer_4[0][0], fragment_uniform_buffer_4[0][1], fragment_uniform_buffer_4[0][2], _AerosolSeaLevelExtinction);

				fragment_uniform_buffer_4[1] = float4(_AirDensityFalloff, fragment_uniform_buffer_4[1][1], fragment_uniform_buffer_4[1][2], fragment_uniform_buffer_4[1][3]);

				fragment_uniform_buffer_4[1] = float4(fragment_uniform_buffer_4[1][0], _AirScaleHeight, fragment_uniform_buffer_4[1][2], fragment_uniform_buffer_4[1][3]);

				fragment_uniform_buffer_4[1] = float4(fragment_uniform_buffer_4[1][0], fragment_uniform_buffer_4[1][1], _AerosolDensityFalloff, fragment_uniform_buffer_4[1][3]);

				fragment_uniform_buffer_4[1] = float4(fragment_uniform_buffer_4[1][0], fragment_uniform_buffer_4[1][1], fragment_uniform_buffer_4[1][2], _AerosolScaleHeight);

				fragment_uniform_buffer_4[2] = float4(_OzoneScaleOffset[0], _OzoneScaleOffset[1], fragment_uniform_buffer_4[2][2], fragment_uniform_buffer_4[2][3]);

				fragment_uniform_buffer_4[2] = float4(fragment_uniform_buffer_4[2][0], fragment_uniform_buffer_4[2][1], _OzoneLayerStart, fragment_uniform_buffer_4[2][3]);

				fragment_uniform_buffer_4[2] = float4(fragment_uniform_buffer_4[2][0], fragment_uniform_buffer_4[2][1], fragment_uniform_buffer_4[2][2], _OzoneLayerEnd);

				fragment_uniform_buffer_4[3] = float4(_AirSeaLevelExtinction[0], _AirSeaLevelExtinction[1], _AirSeaLevelExtinction[2], _AirSeaLevelExtinction[3]);

				fragment_uniform_buffer_4[6] = float4(_OzoneSeaLevelExtinction[0], _OzoneSeaLevelExtinction[1], _OzoneSeaLevelExtinction[2], _OzoneSeaLevelExtinction[3]);

				fragment_uniform_buffer_4[8] = float4(_HorizonTint[0], _HorizonTint[1], _HorizonTint[2], _HorizonTint[3]);

				fragment_uniform_buffer_4[9] = float4(_ZenithTint[0], _ZenithTint[1], _ZenithTint[2], _ZenithTint[3]);

				fragment_uniform_buffer_4[10] = float4(fragment_uniform_buffer_4[10][0], fragment_uniform_buffer_4[10][1], _AlphaSaturation, fragment_uniform_buffer_4[10][3]);

				fragment_uniform_buffer_4[10] = float4(fragment_uniform_buffer_4[10][0], fragment_uniform_buffer_4[10][1], fragment_uniform_buffer_4[10][2], _AlphaMultiplier);

				fragment_uniform_buffer_4[11] = float4(_HorizonZenithShiftPower, fragment_uniform_buffer_4[11][1], fragment_uniform_buffer_4[11][2], fragment_uniform_buffer_4[11][3]);

				fragment_uniform_buffer_4[11] = float4(fragment_uniform_buffer_4[11][0], _HorizonZenithShiftScale, fragment_uniform_buffer_4[11][2], fragment_uniform_buffer_4[11][3]);

				fragment_uniform_buffer_4[12] = float4(fragment_uniform_buffer_4[12][0], fragment_uniform_buffer_4[12][1], fragment_uniform_buffer_4[12][2], _VolumetricCloudsBottomAltitude);

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
				return stage_output;
			}

			#endif // defined(AREA_SHADOW_MEDIUM) && defined(DECALS_3RT) && defined(DIRECTIONAL_SHADOW_MEDIUM) && defined(PUNCTUAL_SHADOW_MEDIUM) && defined(SCREEN_SPACE_SHADOWS_OFF) && defined(USE_CLUSTERED_LIGHTLIST) && defined(_DISABLE_DECALS) && defined(_ENABLE_FOG_ON_TRANSPARENT) && defined(_SURFACE_TYPE_TRANSPARENT)


			#if defined(_SURFACE_TYPE_TRANSPARENT) && !defined(AREA_SHADOW_MEDIUM) && !defined(DECALS_3RT) && !defined(DIRECTIONAL_SHADOW_MEDIUM) && !defined(PUNCTUAL_SHADOW_MEDIUM) && !defined(SCREEN_SPACE_SHADOWS_OFF) && !defined(USE_CLUSTERED_LIGHTLIST) && !defined(_DISABLE_DECALS) && !defined(_ENABLE_FOG_ON_TRANSPARENT)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[24];
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
				if ((((0.0f < vertex_uniform_buffer_2[23u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[23] = float4(vertex_uniform_buffer_2[23][0], vertex_uniform_buffer_2[23][1], _RayTracing, vertex_uniform_buffer_2[23][3]);

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

			#endif // defined(_SURFACE_TYPE_TRANSPARENT) && !defined(AREA_SHADOW_MEDIUM) && !defined(DECALS_3RT) && !defined(DIRECTIONAL_SHADOW_MEDIUM) && !defined(PUNCTUAL_SHADOW_MEDIUM) && !defined(SCREEN_SPACE_SHADOWS_OFF) && !defined(USE_CLUSTERED_LIGHTLIST) && !defined(_DISABLE_DECALS) && !defined(_ENABLE_FOG_ON_TRANSPARENT)


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
	SubShader
	{
		Tags { "DisableBatching" = "False" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
		Pass
		{
			Name "IndirectDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "IndirectDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 772489

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "VisibilityDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "VisibilityDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 794314

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "ForwardDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "ForwardDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 892451

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "GBufferDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "GBufferDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 927163

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "DebugDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DebugDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 999080

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "PathTracingDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "PathTracingDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 1050548

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "SubSurfaceDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "SubSurfaceDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 1140394

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
