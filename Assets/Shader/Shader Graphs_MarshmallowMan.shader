Shader "Shader Graphs/MarshmallowMan"
{
	Properties
	{
		_Fade ("Fade", Range(0, 1)) = 0
		_DeployStatus ("DeployStatus", Range(0, 1)) = 0
		[NoScaleOffset] _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_MaskMap_253529681_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_NormalMap_970140622_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_DetailMap_913208011_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_EmissiveColorMap_243130236_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
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
			GpuProgramID 10135

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DOUBLESIDED_ON


			#if (!defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float _DeployStatus;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[7];
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
				float vertex_unnamed_52 = mad(vertex_input_0.x, 1.0f, 0.0f);
				float vertex_unnamed_55 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
				float vertex_unnamed_58 = mad(vertex_input_0.z, 1.0f, 0.0f);
				float vertex_unnamed_67 = clamp((sqrt(dot(float3(vertex_unnamed_52, vertex_unnamed_55, vertex_unnamed_58), float3(vertex_unnamed_52, vertex_unnamed_55, vertex_unnamed_58))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
				float vertex_unnamed_79 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_81 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_82 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_106 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
				float vertex_unnamed_116 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_106 * mad(vertex_unnamed_67, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_79), vertex_unnamed_79));
				float vertex_unnamed_117 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_106 * mad(vertex_unnamed_67, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_81), vertex_unnamed_81));
				float vertex_unnamed_119 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_106 * mad(vertex_unnamed_67, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_82), vertex_unnamed_82));
				float vertex_unnamed_154 = asfloat(1065353216u);
				float vertex_unnamed_156 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_116, vertex_unnamed_117, vertex_unnamed_119, vertex_unnamed_154));
				float vertex_unnamed_185 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_116, vertex_unnamed_117, vertex_unnamed_119, vertex_unnamed_154));
				float vertex_unnamed_214 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_116, vertex_unnamed_117, vertex_unnamed_119, vertex_unnamed_154));
				vertex_output_5.x = vertex_unnamed_185;
				vertex_output_5.y = vertex_unnamed_156;
				vertex_output_5.z = vertex_unnamed_214;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

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
			#if (!defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)) && defined(SHADER_STAGE_FRAGMENT)
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
			#if (defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float _DeployStatus;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[7];
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
				float vertex_unnamed_52 = mad(vertex_input_0.x, 1.0f, 0.0f);
				float vertex_unnamed_55 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
				float vertex_unnamed_58 = mad(vertex_input_0.z, 1.0f, 0.0f);
				float vertex_unnamed_67 = clamp((sqrt(dot(float3(vertex_unnamed_52, vertex_unnamed_55, vertex_unnamed_58), float3(vertex_unnamed_52, vertex_unnamed_55, vertex_unnamed_58))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
				float vertex_unnamed_79 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_81 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_82 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_106 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
				float vertex_unnamed_116 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_106 * mad(vertex_unnamed_67, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_79), vertex_unnamed_79));
				float vertex_unnamed_117 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_106 * mad(vertex_unnamed_67, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_81), vertex_unnamed_81));
				float vertex_unnamed_119 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_106 * mad(vertex_unnamed_67, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_82), vertex_unnamed_82));
				float vertex_unnamed_154 = asfloat(1065353216u);
				float vertex_unnamed_156 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_116, vertex_unnamed_117, vertex_unnamed_119, vertex_unnamed_154));
				float vertex_unnamed_185 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_116, vertex_unnamed_117, vertex_unnamed_119, vertex_unnamed_154));
				float vertex_unnamed_214 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_116, vertex_unnamed_117, vertex_unnamed_119, vertex_unnamed_154));
				vertex_output_5.x = vertex_unnamed_185;
				vertex_output_5.y = vertex_unnamed_156;
				vertex_output_5.z = vertex_unnamed_214;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

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
			#if (defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float _Fade;
			float _DeployStatus;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[7];
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			Texture2D<float4> _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			SamplerState sampler_SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_228)
			{
				if (fragment_unnamed_228)
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
				uint fragment_unnamed_138 = 2u & 31u;
				uint fragment_unnamed_144 = 0u & 31u;
				float4 fragment_unnamed_172 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_175 = fragment_unnamed_172.w;
				discard_cond(((((((fragment_uniform_buffer_1[6u].y == 1.0f) ? 4294967295u : 0u) | ((0.0f < (mad(exp2(log2(fragment_uniform_buffer_1[6u].y) * 0.25f) + 0.0199999995529651641845703125f, 1.01010096073150634765625f, _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D, float2(fragment_input_1.x * 6.0f, fragment_input_1.y * 4.0f), fragment_uniform_buffer_0[86u].y).x) + (-1.0f))) ? 4294967295u : 0u)) != 0u) ? ((-0.0f) - (((-0.0f) - (((-0.0f) - fragment_unnamed_175) + 1.0f)) + (((-0.0f) - asfloat(fragment_unnamed_41[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_138, min((2u & 31u), (32u - fragment_unnamed_138))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_144, min((2u & 31u), (32u - fragment_unnamed_144))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_1[6u].x) + 2.0f)))) : (-100.0f)) + fragment_unnamed_175) < 0.0f);
				discard_exit();
			}

			void frag(Fragment_Stage_Input stage_input)
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

			#endif
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float _DeployStatus;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[7];
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
				float vertex_unnamed_52 = mad(vertex_input_0.x, 1.0f, 0.0f);
				float vertex_unnamed_55 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
				float vertex_unnamed_58 = mad(vertex_input_0.z, 1.0f, 0.0f);
				float vertex_unnamed_67 = clamp((sqrt(dot(float3(vertex_unnamed_52, vertex_unnamed_55, vertex_unnamed_58), float3(vertex_unnamed_52, vertex_unnamed_55, vertex_unnamed_58))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
				float vertex_unnamed_79 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_81 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_82 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_106 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
				float vertex_unnamed_116 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_106 * mad(vertex_unnamed_67, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_79), vertex_unnamed_79));
				float vertex_unnamed_117 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_106 * mad(vertex_unnamed_67, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_81), vertex_unnamed_81));
				float vertex_unnamed_119 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_106 * mad(vertex_unnamed_67, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_82), vertex_unnamed_82));
				float vertex_unnamed_154 = asfloat(1065353216u);
				float vertex_unnamed_156 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_116, vertex_unnamed_117, vertex_unnamed_119, vertex_unnamed_154));
				float vertex_unnamed_185 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_116, vertex_unnamed_117, vertex_unnamed_119, vertex_unnamed_154));
				float vertex_unnamed_214 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_116, vertex_unnamed_117, vertex_unnamed_119, vertex_unnamed_154));
				vertex_output_5.x = vertex_unnamed_185;
				vertex_output_5.y = vertex_unnamed_156;
				vertex_output_5.z = vertex_unnamed_214;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_214, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_185, vertex_unnamed_156 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

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
			GpuProgramID 289480

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DOUBLESIDED_ON


			#if (!defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;
			float4 unity_MotionVectorsParams;
			float _DeployStatus;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[7];
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
				float vertex_unnamed_61 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_63 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_64 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_72 = mad(vertex_input_0.x, 1.0f, 0.0f);
				float vertex_unnamed_75 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
				float vertex_unnamed_78 = mad(vertex_input_0.z, 1.0f, 0.0f);
				float vertex_unnamed_87 = clamp((sqrt(dot(float3(vertex_unnamed_72, vertex_unnamed_75, vertex_unnamed_78), float3(vertex_unnamed_72, vertex_unnamed_75, vertex_unnamed_78))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
				float vertex_unnamed_111 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
				float vertex_unnamed_121 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_87, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_61), vertex_unnamed_61));
				float vertex_unnamed_122 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_111 * mad(vertex_unnamed_87, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_63), vertex_unnamed_63));
				float vertex_unnamed_124 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_87, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_64), vertex_unnamed_64));
				float vertex_unnamed_159 = asfloat(1065353216u);
				float vertex_unnamed_161 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_121, vertex_unnamed_122, vertex_unnamed_124, vertex_unnamed_159));
				float vertex_unnamed_179 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_121, vertex_unnamed_122, vertex_unnamed_124, vertex_unnamed_159));
				float vertex_unnamed_197 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_121, vertex_unnamed_122, vertex_unnamed_124, vertex_unnamed_159));
				float vertex_unnamed_212 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_227 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_241 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_249 = rsqrt(max(dot(float3(vertex_unnamed_212, vertex_unnamed_227, vertex_unnamed_241), float3(vertex_unnamed_212, vertex_unnamed_227, vertex_unnamed_241)), 1.1754943508222875079687365372222e-38f));
				vertex_output_9.x = vertex_unnamed_249 * vertex_unnamed_212;
				vertex_output_9.y = vertex_unnamed_249 * vertex_unnamed_227;
				vertex_output_9.z = vertex_unnamed_249 * vertex_unnamed_241;
				float vertex_unnamed_284 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_285 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_286 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_291 = rsqrt(max(dot(float3(vertex_unnamed_284, vertex_unnamed_285, vertex_unnamed_286), float3(vertex_unnamed_284, vertex_unnamed_285, vertex_unnamed_286)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_291 * vertex_unnamed_284;
				vertex_output_3.y = vertex_unnamed_291 * vertex_unnamed_285;
				vertex_output_3.z = vertex_unnamed_291 * vertex_unnamed_286;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_197, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_197, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_197, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_397 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_410 = vertex_unnamed_397 ? vertex_input_7.x : vertex_input_0.x;
					float vertex_unnamed_411 = vertex_unnamed_397 ? vertex_input_7.y : vertex_input_0.y;
					float vertex_unnamed_412 = vertex_unnamed_397 ? vertex_input_7.z : vertex_input_0.z;
					float vertex_unnamed_416 = (vertex_unnamed_410 + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_417 = (vertex_unnamed_411 + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_418 = (vertex_unnamed_412 + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_420 = vertex_unnamed_410 + 0.0f;
					float vertex_unnamed_421 = (vertex_unnamed_411 * 0.579999983310699462890625f) + (-0.660000026226043701171875f);
					float vertex_unnamed_422 = vertex_unnamed_412 + 0.0f;
					float vertex_unnamed_429 = clamp((sqrt(dot(float3(vertex_unnamed_420, vertex_unnamed_421, vertex_unnamed_422), float3(vertex_unnamed_420, vertex_unnamed_421, vertex_unnamed_422))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
					float vertex_unnamed_448 = mad(vertex_unnamed_410, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_429, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_416), vertex_unnamed_416));
					float vertex_unnamed_449 = mad(vertex_unnamed_411, 0.949999988079071044921875f, vertex_unnamed_111 * mad(vertex_unnamed_429, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_417), vertex_unnamed_417));
					float vertex_unnamed_450 = mad(vertex_unnamed_412, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_429, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_418), vertex_unnamed_418));
					float vertex_unnamed_484 = asfloat(1065353216u);
					float vertex_unnamed_485 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_448, vertex_unnamed_449, vertex_unnamed_450, vertex_unnamed_484));
					float vertex_unnamed_503 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_448, vertex_unnamed_449, vertex_unnamed_450, vertex_unnamed_484));
					float vertex_unnamed_521 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_448, vertex_unnamed_449, vertex_unnamed_450, vertex_unnamed_484));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_521, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_485, vertex_unnamed_503 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_521, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_485, vertex_unnamed_503 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_521, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_485, vertex_unnamed_503 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
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
				vertex_output_8.x = vertex_unnamed_161;
				vertex_output_8.y = vertex_unnamed_179;
				vertex_output_8.z = vertex_unnamed_197;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

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
			#if (!defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
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
			#if (defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;
			float4 unity_MotionVectorsParams;
			float _DeployStatus;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[7];
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
				float vertex_unnamed_61 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_63 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_64 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_72 = mad(vertex_input_0.x, 1.0f, 0.0f);
				float vertex_unnamed_75 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
				float vertex_unnamed_78 = mad(vertex_input_0.z, 1.0f, 0.0f);
				float vertex_unnamed_87 = clamp((sqrt(dot(float3(vertex_unnamed_72, vertex_unnamed_75, vertex_unnamed_78), float3(vertex_unnamed_72, vertex_unnamed_75, vertex_unnamed_78))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
				float vertex_unnamed_111 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
				float vertex_unnamed_121 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_87, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_61), vertex_unnamed_61));
				float vertex_unnamed_122 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_111 * mad(vertex_unnamed_87, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_63), vertex_unnamed_63));
				float vertex_unnamed_124 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_87, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_64), vertex_unnamed_64));
				float vertex_unnamed_159 = asfloat(1065353216u);
				float vertex_unnamed_161 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_121, vertex_unnamed_122, vertex_unnamed_124, vertex_unnamed_159));
				float vertex_unnamed_179 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_121, vertex_unnamed_122, vertex_unnamed_124, vertex_unnamed_159));
				float vertex_unnamed_197 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_121, vertex_unnamed_122, vertex_unnamed_124, vertex_unnamed_159));
				float vertex_unnamed_212 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_227 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_241 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_249 = rsqrt(max(dot(float3(vertex_unnamed_212, vertex_unnamed_227, vertex_unnamed_241), float3(vertex_unnamed_212, vertex_unnamed_227, vertex_unnamed_241)), 1.1754943508222875079687365372222e-38f));
				vertex_output_9.x = vertex_unnamed_249 * vertex_unnamed_212;
				vertex_output_9.y = vertex_unnamed_249 * vertex_unnamed_227;
				vertex_output_9.z = vertex_unnamed_249 * vertex_unnamed_241;
				float vertex_unnamed_284 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_285 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_286 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_291 = rsqrt(max(dot(float3(vertex_unnamed_284, vertex_unnamed_285, vertex_unnamed_286), float3(vertex_unnamed_284, vertex_unnamed_285, vertex_unnamed_286)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_291 * vertex_unnamed_284;
				vertex_output_3.y = vertex_unnamed_291 * vertex_unnamed_285;
				vertex_output_3.z = vertex_unnamed_291 * vertex_unnamed_286;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_197, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_197, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_197, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_397 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_410 = vertex_unnamed_397 ? vertex_input_7.x : vertex_input_0.x;
					float vertex_unnamed_411 = vertex_unnamed_397 ? vertex_input_7.y : vertex_input_0.y;
					float vertex_unnamed_412 = vertex_unnamed_397 ? vertex_input_7.z : vertex_input_0.z;
					float vertex_unnamed_416 = (vertex_unnamed_410 + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_417 = (vertex_unnamed_411 + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_418 = (vertex_unnamed_412 + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_420 = vertex_unnamed_410 + 0.0f;
					float vertex_unnamed_421 = (vertex_unnamed_411 * 0.579999983310699462890625f) + (-0.660000026226043701171875f);
					float vertex_unnamed_422 = vertex_unnamed_412 + 0.0f;
					float vertex_unnamed_429 = clamp((sqrt(dot(float3(vertex_unnamed_420, vertex_unnamed_421, vertex_unnamed_422), float3(vertex_unnamed_420, vertex_unnamed_421, vertex_unnamed_422))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
					float vertex_unnamed_448 = mad(vertex_unnamed_410, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_429, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_416), vertex_unnamed_416));
					float vertex_unnamed_449 = mad(vertex_unnamed_411, 0.949999988079071044921875f, vertex_unnamed_111 * mad(vertex_unnamed_429, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_417), vertex_unnamed_417));
					float vertex_unnamed_450 = mad(vertex_unnamed_412, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_429, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_418), vertex_unnamed_418));
					float vertex_unnamed_484 = asfloat(1065353216u);
					float vertex_unnamed_485 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_448, vertex_unnamed_449, vertex_unnamed_450, vertex_unnamed_484));
					float vertex_unnamed_503 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_448, vertex_unnamed_449, vertex_unnamed_450, vertex_unnamed_484));
					float vertex_unnamed_521 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_448, vertex_unnamed_449, vertex_unnamed_450, vertex_unnamed_484));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_521, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_485, vertex_unnamed_503 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_521, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_485, vertex_unnamed_503 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_521, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_485, vertex_unnamed_503 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
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
				vertex_output_8.x = vertex_unnamed_161;
				vertex_output_8.y = vertex_unnamed_179;
				vertex_output_8.z = vertex_unnamed_197;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

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
			#if (defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			float _Fade;
			float _DeployStatus;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[7];
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			Texture2D<float4> _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			SamplerState sampler_SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_313)
			{
				if (fragment_unnamed_313)
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
				uint fragment_unnamed_52[64];
				fragment_unnamed_52[0u] = 1030811889u;
				fragment_unnamed_52[4u] = 1057458056u;
				fragment_unnamed_52[8u] = 1043641525u;
				fragment_unnamed_52[12u] = 1059431846u;
				fragment_unnamed_52[16u] = 1061405636u;
				fragment_unnamed_52[20u] = 1050056343u;
				fragment_unnamed_52[24u] = 1063379426u;
				fragment_unnamed_52[28u] = 1054003923u;
				fragment_unnamed_52[32u] = 1047589105u;
				fragment_unnamed_52[36u] = 1060418741u;
				fragment_unnamed_52[40u] = 1039200497u;
				fragment_unnamed_52[44u] = 1058444951u;
				fragment_unnamed_52[48u] = 1064366321u;
				fragment_unnamed_52[52u] = 1055977713u;
				fragment_unnamed_52[56u] = 1062392531u;
				fragment_unnamed_52[60u] = 1052030133u;
				uint fragment_unnamed_149 = 2u & 31u;
				uint fragment_unnamed_155 = 0u & 31u;
				float4 fragment_unnamed_183 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_186 = fragment_unnamed_183.w;
				discard_cond(((((((fragment_uniform_buffer_2[6u].y == 1.0f) ? 4294967295u : 0u) | ((0.0f < (mad(exp2(log2(fragment_uniform_buffer_2[6u].y) * 0.25f) + 0.0199999995529651641845703125f, 1.01010096073150634765625f, _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D, float2(fragment_input_4.x * 6.0f, fragment_input_4.y * 4.0f), fragment_uniform_buffer_0[86u].y).x) + (-1.0f))) ? 4294967295u : 0u)) != 0u) ? ((-0.0f) - (((-0.0f) - (((-0.0f) - fragment_unnamed_186) + 1.0f)) + (((-0.0f) - asfloat(fragment_unnamed_52[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_149, min((2u & 31u), (32u - fragment_unnamed_149))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_155, min((2u & 31u), (32u - fragment_unnamed_155))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[6u].x) + 2.0f)))) : (-100.0f)) + fragment_unnamed_186) < 0.0f);
				float fragment_unnamed_255 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_256 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_302 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_302 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_255) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_255)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_302 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_256) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_256)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[6] = float4(_Fade, fragment_uniform_buffer_2[6][1], fragment_uniform_buffer_2[6][2], fragment_uniform_buffer_2[6][3]);

				fragment_uniform_buffer_2[6] = float4(fragment_uniform_buffer_2[6][0], _DeployStatus, fragment_uniform_buffer_2[6][2], fragment_uniform_buffer_2[6][3]);

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

			#endif
			#if (defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Fade;
			float _DeployStatus;
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[10];
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			Texture2D<float4> _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			SamplerState sampler_SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D;

			static float4 gl_FragCoord;
			static bool gl_FrontFacing;
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
				bool gl_FrontFacing : SV_IsFrontFace;
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

			void discard_cond(bool fragment_unnamed_406)
			{
				if (fragment_unnamed_406)
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
				uint fragment_unnamed_53[64];
				fragment_unnamed_53[0u] = 1030811889u;
				fragment_unnamed_53[4u] = 1057458056u;
				fragment_unnamed_53[8u] = 1043641525u;
				fragment_unnamed_53[12u] = 1059431846u;
				fragment_unnamed_53[16u] = 1061405636u;
				fragment_unnamed_53[20u] = 1050056343u;
				fragment_unnamed_53[24u] = 1063379426u;
				fragment_unnamed_53[28u] = 1054003923u;
				fragment_unnamed_53[32u] = 1047589105u;
				fragment_unnamed_53[36u] = 1060418741u;
				fragment_unnamed_53[40u] = 1039200497u;
				fragment_unnamed_53[44u] = 1058444951u;
				fragment_unnamed_53[48u] = 1064366321u;
				fragment_unnamed_53[52u] = 1055977713u;
				fragment_unnamed_53[56u] = 1062392531u;
				fragment_unnamed_53[60u] = 1052030133u;
				uint fragment_unnamed_150 = 2u & 31u;
				uint fragment_unnamed_156 = 0u & 31u;
				float4 fragment_unnamed_184 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_187 = fragment_unnamed_184.w;
				discard_cond(((((((fragment_uniform_buffer_2[6u].y == 1.0f) ? 4294967295u : 0u) | ((0.0f < (mad(exp2(log2(fragment_uniform_buffer_2[6u].y) * 0.25f) + 0.0199999995529651641845703125f, 1.01010096073150634765625f, _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D, float2(fragment_input_4.x * 6.0f, fragment_input_4.y * 4.0f), fragment_uniform_buffer_0[86u].y).x) + (-1.0f))) ? 4294967295u : 0u)) != 0u) ? ((-0.0f) - (((-0.0f) - (((-0.0f) - fragment_unnamed_187) + 1.0f)) + (((-0.0f) - asfloat(fragment_unnamed_53[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_150, min((2u & 31u), (32u - fragment_unnamed_150))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_156, min((2u & 31u), (32u - fragment_unnamed_156))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[6u].x) + 2.0f)))) : (-100.0f)) + fragment_unnamed_187) < 0.0f);
				float fragment_unnamed_256 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_257 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_303 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_303 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_256) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_256)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_303 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_257) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_257)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_330 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_351 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 1065353216u : asuint(fragment_uniform_buffer_2[9u]).z);
				float fragment_unnamed_352 = (fragment_unnamed_330 * fragment_input_9.x) * fragment_unnamed_351;
				float fragment_unnamed_353 = (fragment_unnamed_330 * fragment_input_9.y) * fragment_unnamed_351;
				float fragment_unnamed_354 = (fragment_unnamed_330 * fragment_input_9.z) * fragment_unnamed_351;
				float fragment_unnamed_363 = 1.0f / max(dot(float3(abs(fragment_unnamed_352), abs(fragment_unnamed_353), abs(fragment_unnamed_354)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_368 = clamp((-0.0f) - (fragment_unnamed_363 * fragment_unnamed_354), 0.0f, 1.0f);
				float fragment_unnamed_371 = (-0.0f) - fragment_unnamed_368;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_352, fragment_unnamed_363, ((fragment_unnamed_363 * fragment_unnamed_352) >= 0.0f) ? fragment_unnamed_368 : fragment_unnamed_371), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_353, fragment_unnamed_363, ((fragment_unnamed_363 * fragment_unnamed_353) >= 0.0f) ? fragment_unnamed_368 : fragment_unnamed_371), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_387 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_387, min((8u & 31u), (32u - fragment_unnamed_387)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[6] = float4(_Fade, fragment_uniform_buffer_2[6][1], fragment_uniform_buffer_2[6][2], fragment_uniform_buffer_2[6][3]);

				fragment_uniform_buffer_2[6] = float4(fragment_uniform_buffer_2[6][0], _DeployStatus, fragment_uniform_buffer_2[6][2], fragment_uniform_buffer_2[6][3]);

				fragment_uniform_buffer_2[9] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				gl_FrontFacing = stage_input.gl_FrontFacing;
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
			#if (defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)) && defined(SHADER_STAGE_FRAGMENT)
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
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;
			float4 unity_MotionVectorsParams;
			float _DeployStatus;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[7];
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
				float vertex_unnamed_61 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_63 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_64 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
				float vertex_unnamed_72 = mad(vertex_input_0.x, 1.0f, 0.0f);
				float vertex_unnamed_75 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
				float vertex_unnamed_78 = mad(vertex_input_0.z, 1.0f, 0.0f);
				float vertex_unnamed_87 = clamp((sqrt(dot(float3(vertex_unnamed_72, vertex_unnamed_75, vertex_unnamed_78), float3(vertex_unnamed_72, vertex_unnamed_75, vertex_unnamed_78))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
				float vertex_unnamed_111 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
				float vertex_unnamed_121 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_87, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_61), vertex_unnamed_61));
				float vertex_unnamed_122 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_111 * mad(vertex_unnamed_87, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_63), vertex_unnamed_63));
				float vertex_unnamed_124 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_87, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_64), vertex_unnamed_64));
				float vertex_unnamed_159 = asfloat(1065353216u);
				float vertex_unnamed_161 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_121, vertex_unnamed_122, vertex_unnamed_124, vertex_unnamed_159));
				float vertex_unnamed_179 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_121, vertex_unnamed_122, vertex_unnamed_124, vertex_unnamed_159));
				float vertex_unnamed_197 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_121, vertex_unnamed_122, vertex_unnamed_124, vertex_unnamed_159));
				float vertex_unnamed_212 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_227 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_241 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_249 = rsqrt(max(dot(float3(vertex_unnamed_212, vertex_unnamed_227, vertex_unnamed_241), float3(vertex_unnamed_212, vertex_unnamed_227, vertex_unnamed_241)), 1.1754943508222875079687365372222e-38f));
				vertex_output_9.x = vertex_unnamed_249 * vertex_unnamed_212;
				vertex_output_9.y = vertex_unnamed_249 * vertex_unnamed_227;
				vertex_output_9.z = vertex_unnamed_249 * vertex_unnamed_241;
				float vertex_unnamed_284 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_285 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_286 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_291 = rsqrt(max(dot(float3(vertex_unnamed_284, vertex_unnamed_285, vertex_unnamed_286), float3(vertex_unnamed_284, vertex_unnamed_285, vertex_unnamed_286)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_291 * vertex_unnamed_284;
				vertex_output_3.y = vertex_unnamed_291 * vertex_unnamed_285;
				vertex_output_3.z = vertex_unnamed_291 * vertex_unnamed_286;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_197, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_197, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_197, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_197, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_161, vertex_unnamed_179 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_397 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_410 = vertex_unnamed_397 ? vertex_input_7.x : vertex_input_0.x;
					float vertex_unnamed_411 = vertex_unnamed_397 ? vertex_input_7.y : vertex_input_0.y;
					float vertex_unnamed_412 = vertex_unnamed_397 ? vertex_input_7.z : vertex_input_0.z;
					float vertex_unnamed_416 = (vertex_unnamed_410 + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_417 = (vertex_unnamed_411 + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_418 = (vertex_unnamed_412 + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_420 = vertex_unnamed_410 + 0.0f;
					float vertex_unnamed_421 = (vertex_unnamed_411 * 0.579999983310699462890625f) + (-0.660000026226043701171875f);
					float vertex_unnamed_422 = vertex_unnamed_412 + 0.0f;
					float vertex_unnamed_429 = clamp((sqrt(dot(float3(vertex_unnamed_420, vertex_unnamed_421, vertex_unnamed_422), float3(vertex_unnamed_420, vertex_unnamed_421, vertex_unnamed_422))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
					float vertex_unnamed_448 = mad(vertex_unnamed_410, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_429, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_416), vertex_unnamed_416));
					float vertex_unnamed_449 = mad(vertex_unnamed_411, 0.949999988079071044921875f, vertex_unnamed_111 * mad(vertex_unnamed_429, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_417), vertex_unnamed_417));
					float vertex_unnamed_450 = mad(vertex_unnamed_412, 1.0f, vertex_unnamed_111 * mad(vertex_unnamed_429, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_418), vertex_unnamed_418));
					float vertex_unnamed_484 = asfloat(1065353216u);
					float vertex_unnamed_485 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_448, vertex_unnamed_449, vertex_unnamed_450, vertex_unnamed_484));
					float vertex_unnamed_503 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_448, vertex_unnamed_449, vertex_unnamed_450, vertex_unnamed_484));
					float vertex_unnamed_521 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_448, vertex_unnamed_449, vertex_unnamed_450, vertex_unnamed_484));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_521, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_485, vertex_unnamed_503 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_521, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_485, vertex_unnamed_503 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_521, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_485, vertex_unnamed_503 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
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
				vertex_output_8.x = vertex_unnamed_161;
				vertex_output_8.y = vertex_unnamed_179;
				vertex_output_8.z = vertex_unnamed_197;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

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
			GpuProgramID 482339

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DOUBLESIDED_ON


			#if (!defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _DeployStatus;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[15];
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
				if ((((0.0f < vertex_uniform_buffer_2[14u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					float vertex_unnamed_110 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_112 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_113 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_121 = mad(vertex_input_0.x, 1.0f, 0.0f);
					float vertex_unnamed_123 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
					float vertex_unnamed_126 = mad(vertex_input_0.z, 1.0f, 0.0f);
					float vertex_unnamed_135 = clamp((sqrt(dot(float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126), float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
					float vertex_unnamed_158 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
					float vertex_unnamed_168 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_110), vertex_unnamed_110));
					float vertex_unnamed_169 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_112), vertex_unnamed_112));
					float vertex_unnamed_171 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_113), vertex_unnamed_113));
					float vertex_unnamed_204 = asfloat(1065353216u);
					float vertex_unnamed_206 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_224 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_242 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_257 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_272 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_286 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_294 = rsqrt(max(dot(float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286), float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_294 * vertex_unnamed_257;
					vertex_output_7.y = vertex_unnamed_294 * vertex_unnamed_272;
					vertex_output_7.z = vertex_unnamed_294 * vertex_unnamed_286;
					float vertex_unnamed_328 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_329 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_330 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_335 = rsqrt(max(dot(float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330), float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_335 * vertex_unnamed_328;
					vertex_output_1.y = vertex_unnamed_335 * vertex_unnamed_329;
					vertex_output_1.z = vertex_unnamed_335 * vertex_unnamed_330;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_206;
					vertex_output_6.y = vertex_unnamed_224;
					vertex_output_6.z = vertex_unnamed_242;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

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
			#if (!defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
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
			#if (defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _DeployStatus;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[15];
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
				if ((((0.0f < vertex_uniform_buffer_2[14u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					float vertex_unnamed_110 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_112 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_113 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_121 = mad(vertex_input_0.x, 1.0f, 0.0f);
					float vertex_unnamed_123 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
					float vertex_unnamed_126 = mad(vertex_input_0.z, 1.0f, 0.0f);
					float vertex_unnamed_135 = clamp((sqrt(dot(float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126), float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
					float vertex_unnamed_158 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
					float vertex_unnamed_168 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_110), vertex_unnamed_110));
					float vertex_unnamed_169 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_112), vertex_unnamed_112));
					float vertex_unnamed_171 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_113), vertex_unnamed_113));
					float vertex_unnamed_204 = asfloat(1065353216u);
					float vertex_unnamed_206 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_224 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_242 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_257 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_272 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_286 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_294 = rsqrt(max(dot(float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286), float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_294 * vertex_unnamed_257;
					vertex_output_7.y = vertex_unnamed_294 * vertex_unnamed_272;
					vertex_output_7.z = vertex_unnamed_294 * vertex_unnamed_286;
					float vertex_unnamed_328 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_329 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_330 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_335 = rsqrt(max(dot(float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330), float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_335 * vertex_unnamed_328;
					vertex_output_1.y = vertex_unnamed_335 * vertex_unnamed_329;
					vertex_output_1.z = vertex_unnamed_335 * vertex_unnamed_330;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_206;
					vertex_output_6.y = vertex_unnamed_224;
					vertex_output_6.z = vertex_unnamed_242;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

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
			#if (defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float _Fade;
			float _DeployStatus;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[7];
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			Texture2D<float4> _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			SamplerState sampler_SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_230)
			{
				if (fragment_unnamed_230)
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
				uint fragment_unnamed_140 = 2u & 31u;
				uint fragment_unnamed_146 = 0u & 31u;
				float4 fragment_unnamed_174 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_177 = fragment_unnamed_174.w;
				discard_cond(((((((fragment_uniform_buffer_1[6u].y == 1.0f) ? 4294967295u : 0u) | ((0.0f < (mad(exp2(log2(fragment_uniform_buffer_1[6u].y) * 0.25f) + 0.0199999995529651641845703125f, 1.01010096073150634765625f, _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D, float2(fragment_input_2.x * 6.0f, fragment_input_2.y * 4.0f), fragment_uniform_buffer_0[86u].y).x) + (-1.0f))) ? 4294967295u : 0u)) != 0u) ? ((-0.0f) - (((-0.0f) - (((-0.0f) - fragment_unnamed_177) + 1.0f)) + (((-0.0f) - asfloat(fragment_unnamed_43[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_140, min((2u & 31u), (32u - fragment_unnamed_140))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_146, min((2u & 31u), (32u - fragment_unnamed_146))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_1[6u].x) + 2.0f)))) : (-100.0f)) + fragment_unnamed_177) < 0.0f);
				discard_exit();
			}

			void frag(Fragment_Stage_Input stage_input)
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

			#endif
			#if (defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Fade;
			float _DeployStatus;
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			static float4 fragment_uniform_buffer_2[10];
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			Texture2D<float4> _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			SamplerState sampler_SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D;

			static float4 gl_FragCoord;
			static bool gl_FrontFacing;
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
				bool gl_FrontFacing : SV_IsFrontFace;
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

			void discard_cond(bool fragment_unnamed_332)
			{
				if (fragment_unnamed_332)
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
				uint fragment_unnamed_50[64];
				fragment_unnamed_50[0u] = 1030811889u;
				fragment_unnamed_50[4u] = 1057458056u;
				fragment_unnamed_50[8u] = 1043641525u;
				fragment_unnamed_50[12u] = 1059431846u;
				fragment_unnamed_50[16u] = 1061405636u;
				fragment_unnamed_50[20u] = 1050056343u;
				fragment_unnamed_50[24u] = 1063379426u;
				fragment_unnamed_50[28u] = 1054003923u;
				fragment_unnamed_50[32u] = 1047589105u;
				fragment_unnamed_50[36u] = 1060418741u;
				fragment_unnamed_50[40u] = 1039200497u;
				fragment_unnamed_50[44u] = 1058444951u;
				fragment_unnamed_50[48u] = 1064366321u;
				fragment_unnamed_50[52u] = 1055977713u;
				fragment_unnamed_50[56u] = 1062392531u;
				fragment_unnamed_50[60u] = 1052030133u;
				uint fragment_unnamed_147 = 2u & 31u;
				uint fragment_unnamed_153 = 0u & 31u;
				float4 fragment_unnamed_181 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_184 = fragment_unnamed_181.w;
				discard_cond(((((((fragment_uniform_buffer_2[6u].y == 1.0f) ? 4294967295u : 0u) | ((0.0f < (mad(exp2(log2(fragment_uniform_buffer_2[6u].y) * 0.25f) + 0.0199999995529651641845703125f, 1.01010096073150634765625f, _SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_4b1808c8924a4e929c454897ef99867f_Texture_1_Texture2D, float2(fragment_input_2.x * 6.0f, fragment_input_2.y * 4.0f), fragment_uniform_buffer_0[86u].y).x) + (-1.0f))) ? 4294967295u : 0u)) != 0u) ? ((-0.0f) - (((-0.0f) - (((-0.0f) - fragment_unnamed_184) + 1.0f)) + (((-0.0f) - asfloat(fragment_unnamed_50[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_147, min((2u & 31u), (32u - fragment_unnamed_147))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_153, min((2u & 31u), (32u - fragment_unnamed_153))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[6u].x) + 2.0f)))) : (-100.0f)) + fragment_unnamed_184) < 0.0f);
				float fragment_unnamed_253 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_274 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 1065353216u : asuint(fragment_uniform_buffer_2[9u]).z);
				float fragment_unnamed_275 = (fragment_unnamed_253 * fragment_input_7.x) * fragment_unnamed_274;
				float fragment_unnamed_276 = (fragment_unnamed_253 * fragment_input_7.y) * fragment_unnamed_274;
				float fragment_unnamed_277 = (fragment_unnamed_253 * fragment_input_7.z) * fragment_unnamed_274;
				float fragment_unnamed_286 = 1.0f / max(dot(float3(abs(fragment_unnamed_275), abs(fragment_unnamed_276), abs(fragment_unnamed_277)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_291 = clamp((-0.0f) - (fragment_unnamed_286 * fragment_unnamed_277), 0.0f, 1.0f);
				float fragment_unnamed_294 = (-0.0f) - fragment_unnamed_291;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_275, fragment_unnamed_286, ((fragment_unnamed_286 * fragment_unnamed_275) >= 0.0f) ? fragment_unnamed_291 : fragment_unnamed_294), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_276, fragment_unnamed_286, ((fragment_unnamed_286 * fragment_unnamed_276) >= 0.0f) ? fragment_unnamed_291 : fragment_unnamed_294), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_313 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_313, min((8u & 31u), (32u - fragment_unnamed_313)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[6] = float4(_Fade, fragment_uniform_buffer_2[6][1], fragment_uniform_buffer_2[6][2], fragment_uniform_buffer_2[6][3]);

				fragment_uniform_buffer_2[6] = float4(fragment_uniform_buffer_2[6][0], _DeployStatus, fragment_uniform_buffer_2[6][2], fragment_uniform_buffer_2[6][3]);

				fragment_uniform_buffer_2[9] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				gl_FrontFacing = stage_input.gl_FrontFacing;
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
			#if (defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)) && defined(SHADER_STAGE_FRAGMENT)
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
			#if defined(SHADER_STAGE_VERTEX) && !defined(RIP_HAS_VERT)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _DeployStatus;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[15];
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
				if ((((0.0f < vertex_uniform_buffer_2[14u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					float vertex_unnamed_110 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_112 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_113 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_121 = mad(vertex_input_0.x, 1.0f, 0.0f);
					float vertex_unnamed_123 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
					float vertex_unnamed_126 = mad(vertex_input_0.z, 1.0f, 0.0f);
					float vertex_unnamed_135 = clamp((sqrt(dot(float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126), float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
					float vertex_unnamed_158 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
					float vertex_unnamed_168 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_110), vertex_unnamed_110));
					float vertex_unnamed_169 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_112), vertex_unnamed_112));
					float vertex_unnamed_171 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_113), vertex_unnamed_113));
					float vertex_unnamed_204 = asfloat(1065353216u);
					float vertex_unnamed_206 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_224 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_242 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_257 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_272 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_286 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_294 = rsqrt(max(dot(float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286), float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_294 * vertex_unnamed_257;
					vertex_output_7.y = vertex_unnamed_294 * vertex_unnamed_272;
					vertex_output_7.z = vertex_unnamed_294 * vertex_unnamed_286;
					float vertex_unnamed_328 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_329 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_330 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_335 = rsqrt(max(dot(float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330), float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_335 * vertex_unnamed_328;
					vertex_output_1.y = vertex_unnamed_335 * vertex_unnamed_329;
					vertex_output_1.z = vertex_unnamed_335 * vertex_unnamed_330;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_206;
					vertex_output_6.y = vertex_unnamed_224;
					vertex_output_6.z = vertex_unnamed_242;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

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
			GpuProgramID 547167

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ DECALS_3RT
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DOUBLESIDED_ON


			#if (!defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _DeployStatus;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[15];
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
				if ((((0.0f < vertex_uniform_buffer_2[14u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					float vertex_unnamed_110 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_112 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_113 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_121 = mad(vertex_input_0.x, 1.0f, 0.0f);
					float vertex_unnamed_123 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
					float vertex_unnamed_126 = mad(vertex_input_0.z, 1.0f, 0.0f);
					float vertex_unnamed_135 = clamp((sqrt(dot(float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126), float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
					float vertex_unnamed_158 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
					float vertex_unnamed_168 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_110), vertex_unnamed_110));
					float vertex_unnamed_169 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_112), vertex_unnamed_112));
					float vertex_unnamed_171 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_113), vertex_unnamed_113));
					float vertex_unnamed_204 = asfloat(1065353216u);
					float vertex_unnamed_206 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_224 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_242 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_257 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_272 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_286 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_294 = rsqrt(max(dot(float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286), float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_294 * vertex_unnamed_257;
					vertex_output_7.y = vertex_unnamed_294 * vertex_unnamed_272;
					vertex_output_7.z = vertex_unnamed_294 * vertex_unnamed_286;
					float vertex_unnamed_328 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_329 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_330 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_335 = rsqrt(max(dot(float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330), float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_335 * vertex_unnamed_328;
					vertex_output_1.y = vertex_unnamed_335 * vertex_unnamed_329;
					vertex_output_1.z = vertex_unnamed_335 * vertex_unnamed_330;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_206;
					vertex_output_6.y = vertex_unnamed_224;
					vertex_output_6.z = vertex_unnamed_242;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

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
			#if (defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _DeployStatus;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[15];
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
				if ((((0.0f < vertex_uniform_buffer_2[14u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					float vertex_unnamed_110 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_112 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_113 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_121 = mad(vertex_input_0.x, 1.0f, 0.0f);
					float vertex_unnamed_123 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
					float vertex_unnamed_126 = mad(vertex_input_0.z, 1.0f, 0.0f);
					float vertex_unnamed_135 = clamp((sqrt(dot(float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126), float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
					float vertex_unnamed_158 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
					float vertex_unnamed_168 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_110), vertex_unnamed_110));
					float vertex_unnamed_169 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_112), vertex_unnamed_112));
					float vertex_unnamed_171 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_113), vertex_unnamed_113));
					float vertex_unnamed_204 = asfloat(1065353216u);
					float vertex_unnamed_206 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_224 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_242 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_257 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_272 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_286 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_294 = rsqrt(max(dot(float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286), float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_294 * vertex_unnamed_257;
					vertex_output_7.y = vertex_unnamed_294 * vertex_unnamed_272;
					vertex_output_7.z = vertex_unnamed_294 * vertex_unnamed_286;
					float vertex_unnamed_328 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_329 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_330 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_335 = rsqrt(max(dot(float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330), float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_335 * vertex_unnamed_328;
					vertex_output_1.y = vertex_unnamed_335 * vertex_unnamed_329;
					vertex_output_1.z = vertex_unnamed_335 * vertex_unnamed_330;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_206;
					vertex_output_6.y = vertex_unnamed_224;
					vertex_output_6.z = vertex_unnamed_242;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

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
			#if (defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)) && defined(SHADER_STAGE_FRAGMENT)
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
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[10];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_MaskMap_253529681_Texture2D;
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_NormalMap_970140622_Texture2D;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_MaskMap_253529681_Texture2D;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_NormalMap_970140622_Texture2D;

			static float4 gl_FragCoord;
			static bool gl_FrontFacing;
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
				bool gl_FrontFacing : SV_IsFrontFace;
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
				float fragment_unnamed_101 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_120 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_183 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_209 = asfloat(fragment_unnamed_183 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_216 = asfloat(fragment_unnamed_183 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_223 = asfloat(fragment_unnamed_183 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_227 = rsqrt(dot(float3(fragment_unnamed_209, fragment_unnamed_216, fragment_unnamed_223), float3(fragment_unnamed_209, fragment_unnamed_216, fragment_unnamed_223)));
				bool fragment_unnamed_234 = (gl_FrontFacing ? 4294967295u : 0u) != 0u;
				uint4 fragment_unnamed_237 = asuint(fragment_uniform_buffer_2[9u]);
				float fragment_unnamed_241 = asfloat(fragment_unnamed_234 ? 1065353216u : fragment_unnamed_237.z);
				float fragment_unnamed_243 = asfloat(fragment_unnamed_234 ? 1065353216u : fragment_unnamed_237.x);
				float4 fragment_unnamed_257 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_260 = fragment_unnamed_257.x;
				float fragment_unnamed_261 = fragment_unnamed_257.y;
				float fragment_unnamed_262 = fragment_unnamed_257.z;
				float4 fragment_unnamed_271 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_MaskMap_253529681_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_MaskMap_253529681_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_273 = fragment_unnamed_271.w;
				float fragment_unnamed_274 = fragment_unnamed_271.x;
				float fragment_unnamed_275 = fragment_unnamed_271.y;
				float4 fragment_unnamed_284 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_NormalMap_970140622_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_NormalMap_970140622_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_290 = mad(fragment_unnamed_284.x * fragment_unnamed_284.w, 2.0f, -1.0f);
				float fragment_unnamed_293 = mad(fragment_unnamed_284.y, 2.0f, -1.0f);
				float fragment_unnamed_301 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_290, fragment_unnamed_293), float2(fragment_unnamed_290, fragment_unnamed_293)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_303 = fragment_unnamed_243 * fragment_unnamed_290;
				float fragment_unnamed_304 = fragment_unnamed_243 * fragment_unnamed_293;
				float fragment_unnamed_311 = mad(fragment_unnamed_301, (fragment_unnamed_101 * fragment_input_7.x) * fragment_unnamed_241, mad(fragment_unnamed_303, fragment_unnamed_101 * fragment_input_1.x, (fragment_unnamed_101 * (fragment_unnamed_120 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_304));
				float fragment_unnamed_312 = mad(fragment_unnamed_301, (fragment_unnamed_101 * fragment_input_7.y) * fragment_unnamed_241, mad(fragment_unnamed_303, fragment_unnamed_101 * fragment_input_1.y, (fragment_unnamed_101 * (fragment_unnamed_120 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_304));
				float fragment_unnamed_313 = mad(fragment_unnamed_301, (fragment_unnamed_101 * fragment_input_7.z) * fragment_unnamed_241, mad(fragment_unnamed_303, fragment_unnamed_101 * fragment_input_1.z, (fragment_unnamed_101 * (fragment_unnamed_120 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_304));
				float fragment_unnamed_318 = rsqrt(max(dot(float3(fragment_unnamed_311, fragment_unnamed_312, fragment_unnamed_313), float3(fragment_unnamed_311, fragment_unnamed_312, fragment_unnamed_313)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_319 = fragment_unnamed_318 * fragment_unnamed_311;
				float fragment_unnamed_320 = fragment_unnamed_318 * fragment_unnamed_312;
				float fragment_unnamed_321 = fragment_unnamed_318 * fragment_unnamed_313;
				float fragment_unnamed_385;
				float fragment_unnamed_386;
				float fragment_unnamed_387;
				float fragment_unnamed_388;
				float fragment_unnamed_389;
				float fragment_unnamed_390;
				float fragment_unnamed_391;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_332 = uint(gl_FragCoord.x);
					uint fragment_unnamed_333 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_334 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_332, fragment_unnamed_333, 0u), 0u));
					float fragment_unnamed_340 = fragment_unnamed_334.w;
					float4 fragment_unnamed_341 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_332, fragment_unnamed_333, 0u), 0u));
					float fragment_unnamed_346 = fragment_unnamed_341.w;
					float4 fragment_unnamed_347 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_332, fragment_unnamed_333, 0u), 0u));
					bool fragment_unnamed_357 = fragment_unnamed_346 < 1.0f;
					float fragment_unnamed_358 = mad(fragment_unnamed_319, fragment_unnamed_346, fragment_unnamed_243 * mad(fragment_unnamed_341.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_359 = mad(fragment_unnamed_320, fragment_unnamed_346, fragment_unnamed_243 * mad(fragment_unnamed_341.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_360 = mad(fragment_unnamed_321, fragment_unnamed_346, mad(fragment_unnamed_341.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_365 = rsqrt(max(dot(float3(fragment_unnamed_358, fragment_unnamed_359, fragment_unnamed_360), float3(fragment_unnamed_358, fragment_unnamed_359, fragment_unnamed_360)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_385 = mad(fragment_unnamed_260, fragment_unnamed_340, fragment_unnamed_334.x);
					fragment_unnamed_386 = mad(fragment_unnamed_261, fragment_unnamed_340, fragment_unnamed_334.y);
					fragment_unnamed_387 = mad(fragment_unnamed_262, fragment_unnamed_340, fragment_unnamed_334.z);
					fragment_unnamed_388 = mad(fragment_unnamed_273, fragment_unnamed_347.w, fragment_unnamed_347.z);
					fragment_unnamed_389 = asfloat(fragment_unnamed_357 ? asuint(fragment_unnamed_365 * fragment_unnamed_360) : asuint(fragment_unnamed_321));
					fragment_unnamed_390 = asfloat(fragment_unnamed_357 ? asuint(fragment_unnamed_365 * fragment_unnamed_359) : asuint(fragment_unnamed_320));
					fragment_unnamed_391 = asfloat(fragment_unnamed_357 ? asuint(fragment_unnamed_365 * fragment_unnamed_358) : asuint(fragment_unnamed_319));
				}
				else
				{
					fragment_unnamed_385 = fragment_unnamed_260;
					fragment_unnamed_386 = fragment_unnamed_261;
					fragment_unnamed_387 = fragment_unnamed_262;
					fragment_unnamed_388 = fragment_unnamed_273;
					fragment_unnamed_389 = fragment_unnamed_321;
					fragment_unnamed_390 = fragment_unnamed_320;
					fragment_unnamed_391 = fragment_unnamed_319;
				}
				float fragment_unnamed_395 = max(dot(float3(fragment_unnamed_391, fragment_unnamed_390, fragment_unnamed_389), float3(fragment_unnamed_227 * fragment_unnamed_209, fragment_unnamed_227 * fragment_unnamed_216, fragment_unnamed_227 * fragment_unnamed_223)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_398 = ((-0.0f) - fragment_unnamed_388) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_275 + exp2(log2(abs(fragment_unnamed_275 + fragment_unnamed_395)) * exp2(mad(fragment_unnamed_398 * fragment_unnamed_398, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_426 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_427 = fragment_unnamed_426.x;
				float fragment_unnamed_713;
				float fragment_unnamed_715;
				float fragment_unnamed_717;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_427 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_427 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_714;
					float fragment_unnamed_716;
					float fragment_unnamed_718;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_450 = asfloat(1065353216u);
						float fragment_unnamed_480 = fragment_unnamed_390 * fragment_unnamed_391;
						float fragment_unnamed_481 = fragment_unnamed_389 * fragment_unnamed_390;
						float fragment_unnamed_482 = fragment_unnamed_389 * fragment_unnamed_389;
						float fragment_unnamed_483 = fragment_unnamed_391 * fragment_unnamed_389;
						float fragment_unnamed_516 = mad(fragment_unnamed_391, fragment_unnamed_391, (-0.0f) - (fragment_unnamed_390 * fragment_unnamed_390));
						fragment_unnamed_714 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_391, fragment_unnamed_390, fragment_unnamed_389, fragment_unnamed_450)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_516, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482, fragment_unnamed_483)));
						fragment_unnamed_716 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_391, fragment_unnamed_390, fragment_unnamed_389, fragment_unnamed_450)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_516, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482, fragment_unnamed_483)));
						fragment_unnamed_718 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_391, fragment_unnamed_390, fragment_unnamed_389, fragment_unnamed_450)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_516, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482, fragment_unnamed_483)));
					}
					else
					{
						bool fragment_unnamed_532 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_533 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_555 = fragment_unnamed_532 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_556 = fragment_unnamed_532 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_557 = fragment_unnamed_532 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_661 = (asfloat(fragment_unnamed_533 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_557, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_555, fragment_unnamed_556 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_556)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_662 = (asfloat(fragment_unnamed_533 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_557, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_555, fragment_unnamed_556 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_557)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_676 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_533 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_557, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_555, fragment_unnamed_556 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_555)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_703 = asfloat(1065353216u);
						fragment_unnamed_714 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_676, fragment_unnamed_661, fragment_unnamed_662), 0.0f)), float4(fragment_unnamed_391, fragment_unnamed_390, fragment_unnamed_389, fragment_unnamed_703));
						fragment_unnamed_716 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_676 + 0.25f, fragment_unnamed_661 + 0.0f, fragment_unnamed_662 + 0.0f), 0.0f)), float4(fragment_unnamed_391, fragment_unnamed_390, fragment_unnamed_389, fragment_unnamed_703));
						fragment_unnamed_718 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_676 + 0.5f, fragment_unnamed_661 + 0.0f, fragment_unnamed_662 + 0.0f), 0.0f)), float4(fragment_unnamed_391, fragment_unnamed_390, fragment_unnamed_389, fragment_unnamed_703));
					}
					fragment_unnamed_713 = fragment_unnamed_714;
					fragment_unnamed_715 = fragment_unnamed_716;
					fragment_unnamed_717 = fragment_unnamed_718;
				}
				else
				{
					fragment_unnamed_713 = asfloat(0u);
					fragment_unnamed_715 = asfloat(0u);
					fragment_unnamed_717 = asfloat(0u);
				}
				float fragment_unnamed_720 = ((-0.0f) - fragment_unnamed_274) + 1.0f;
				float fragment_unnamed_721 = fragment_unnamed_720 * fragment_unnamed_385;
				float fragment_unnamed_722 = fragment_unnamed_720 * fragment_unnamed_386;
				float fragment_unnamed_723 = fragment_unnamed_720 * fragment_unnamed_387;
				float fragment_unnamed_728 = mad(fragment_unnamed_274, fragment_unnamed_385 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_730 = mad(fragment_unnamed_274, fragment_unnamed_386 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_731 = mad(fragment_unnamed_274, fragment_unnamed_387 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_743 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_395), 0.984375f, 0.0078125f), mad(fragment_unnamed_398, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_753 = clamp((max(fragment_unnamed_731, max(fragment_unnamed_730, fragment_unnamed_728)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_777 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_782 = max(abs(fragment_unnamed_389), 0.0009765625f);
				float fragment_unnamed_786 = (fragment_unnamed_389 >= 0.0f) ? fragment_unnamed_782 : ((-0.0f) - fragment_unnamed_782);
				float fragment_unnamed_795 = 1.0f / max(dot(float3(abs(fragment_unnamed_391), abs(fragment_unnamed_390), abs(fragment_unnamed_786)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_800 = clamp((-0.0f) - (fragment_unnamed_795 * fragment_unnamed_786), 0.0f, 1.0f);
				float fragment_unnamed_803 = (-0.0f) - fragment_unnamed_800;
				uint fragment_unnamed_815 = uint(clamp(mad(mad(fragment_unnamed_391, fragment_unnamed_795, ((fragment_unnamed_795 * fragment_unnamed_391) >= 0.0f) ? fragment_unnamed_800 : fragment_unnamed_803), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_816 = uint(clamp(mad(mad(fragment_unnamed_390, fragment_unnamed_795, ((fragment_unnamed_795 * fragment_unnamed_390) >= 0.0f) ? fragment_unnamed_800 : fragment_unnamed_803), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_815 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_816 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_816 >> 8u) * 16u) + (fragment_unnamed_815 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_728)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_730)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_731)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_869 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_870 = fragment_unnamed_869 * (fragment_unnamed_275 * (fragment_unnamed_777 * ((fragment_unnamed_743 * mad(fragment_unnamed_753, mad((-0.0f) - fragment_unnamed_385, fragment_unnamed_720, fragment_unnamed_728), fragment_unnamed_721)) * fragment_unnamed_713)));
				float fragment_unnamed_871 = fragment_unnamed_869 * (fragment_unnamed_275 * (fragment_unnamed_777 * ((fragment_unnamed_743 * mad(fragment_unnamed_753, mad((-0.0f) - fragment_unnamed_386, fragment_unnamed_720, fragment_unnamed_730), fragment_unnamed_722)) * fragment_unnamed_715)));
				float fragment_unnamed_872 = fragment_unnamed_869 * (fragment_unnamed_275 * (fragment_unnamed_777 * ((fragment_unnamed_743 * mad(fragment_unnamed_753, mad((-0.0f) - fragment_unnamed_387, fragment_unnamed_720, fragment_unnamed_731), fragment_unnamed_723)) * fragment_unnamed_717)));
				bool fragment_unnamed_885 = (((fragment_unnamed_872 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_871 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_870 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_885 ? asfloat(1157627904u) : fragment_unnamed_870;
				fragment_output_3.y = fragment_unnamed_885 ? fragment_unnamed_275 : fragment_unnamed_871;
				fragment_output_3.z = fragment_unnamed_885 ? asfloat(1149239296u) : fragment_unnamed_872;
				fragment_output_0.x = fragment_unnamed_721;
				fragment_output_0.y = fragment_unnamed_722;
				fragment_output_0.z = fragment_unnamed_723;
				fragment_output_1.w = fragment_unnamed_398;
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

				fragment_uniform_buffer_2[9] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				gl_FrontFacing = stage_input.gl_FrontFacing;
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
			#if (defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)) && defined(SHADER_STAGE_FRAGMENT)
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

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_MaskMap_253529681_Texture2D;
			Texture2D<float4> _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_NormalMap_970140622_Texture2D;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_MaskMap_253529681_Texture2D;
			SamplerState sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_NormalMap_970140622_Texture2D;

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
				float fragment_unnamed_93 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_113 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_176 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_202 = asfloat(fragment_unnamed_176 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_209 = asfloat(fragment_unnamed_176 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_216 = asfloat(fragment_unnamed_176 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_220 = rsqrt(dot(float3(fragment_unnamed_202, fragment_unnamed_209, fragment_unnamed_216), float3(fragment_unnamed_202, fragment_unnamed_209, fragment_unnamed_216)));
				float4 fragment_unnamed_234 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_BaseColorMap_1793653899_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_237 = fragment_unnamed_234.x;
				float fragment_unnamed_238 = fragment_unnamed_234.y;
				float fragment_unnamed_239 = fragment_unnamed_234.z;
				float4 fragment_unnamed_248 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_MaskMap_253529681_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_MaskMap_253529681_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_250 = fragment_unnamed_248.w;
				float fragment_unnamed_251 = fragment_unnamed_248.x;
				float fragment_unnamed_252 = fragment_unnamed_248.y;
				float4 fragment_unnamed_261 = _HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_NormalMap_970140622_Texture2D.SampleBias(sampler_HDRPLit_ed8b10e99836460dab8d67a39f9dd42d_NormalMap_970140622_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_267 = mad(fragment_unnamed_261.x * fragment_unnamed_261.w, 2.0f, -1.0f);
				float fragment_unnamed_270 = mad(fragment_unnamed_261.y, 2.0f, -1.0f);
				float fragment_unnamed_278 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_267, fragment_unnamed_270), float2(fragment_unnamed_267, fragment_unnamed_270)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_286 = mad(fragment_unnamed_278, fragment_unnamed_93 * fragment_input_7.x, mad(fragment_unnamed_267, fragment_unnamed_93 * fragment_input_1.x, (fragment_unnamed_93 * (fragment_unnamed_113 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_270));
				float fragment_unnamed_287 = mad(fragment_unnamed_278, fragment_unnamed_93 * fragment_input_7.y, mad(fragment_unnamed_267, fragment_unnamed_93 * fragment_input_1.y, (fragment_unnamed_93 * (fragment_unnamed_113 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_270));
				float fragment_unnamed_288 = mad(fragment_unnamed_278, fragment_unnamed_93 * fragment_input_7.z, mad(fragment_unnamed_267, fragment_unnamed_93 * fragment_input_1.z, (fragment_unnamed_93 * (fragment_unnamed_113 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_270));
				float fragment_unnamed_293 = rsqrt(max(dot(float3(fragment_unnamed_286, fragment_unnamed_287, fragment_unnamed_288), float3(fragment_unnamed_286, fragment_unnamed_287, fragment_unnamed_288)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_294 = fragment_unnamed_293 * fragment_unnamed_286;
				float fragment_unnamed_295 = fragment_unnamed_293 * fragment_unnamed_287;
				float fragment_unnamed_296 = fragment_unnamed_293 * fragment_unnamed_288;
				float fragment_unnamed_358;
				float fragment_unnamed_359;
				float fragment_unnamed_360;
				float fragment_unnamed_361;
				float fragment_unnamed_362;
				float fragment_unnamed_363;
				float fragment_unnamed_364;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_307 = uint(gl_FragCoord.x);
					uint fragment_unnamed_308 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_309 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_307, fragment_unnamed_308, 0u), 0u));
					float fragment_unnamed_315 = fragment_unnamed_309.w;
					float4 fragment_unnamed_316 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_307, fragment_unnamed_308, 0u), 0u));
					float fragment_unnamed_321 = fragment_unnamed_316.w;
					float4 fragment_unnamed_322 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_307, fragment_unnamed_308, 0u), 0u));
					bool fragment_unnamed_330 = fragment_unnamed_321 < 1.0f;
					float fragment_unnamed_331 = mad(fragment_unnamed_294, fragment_unnamed_321, mad(fragment_unnamed_316.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_332 = mad(fragment_unnamed_295, fragment_unnamed_321, mad(fragment_unnamed_316.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_333 = mad(fragment_unnamed_296, fragment_unnamed_321, mad(fragment_unnamed_316.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_338 = rsqrt(max(dot(float3(fragment_unnamed_331, fragment_unnamed_332, fragment_unnamed_333), float3(fragment_unnamed_331, fragment_unnamed_332, fragment_unnamed_333)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_358 = mad(fragment_unnamed_237, fragment_unnamed_315, fragment_unnamed_309.x);
					fragment_unnamed_359 = mad(fragment_unnamed_238, fragment_unnamed_315, fragment_unnamed_309.y);
					fragment_unnamed_360 = mad(fragment_unnamed_239, fragment_unnamed_315, fragment_unnamed_309.z);
					fragment_unnamed_361 = mad(fragment_unnamed_250, fragment_unnamed_322.w, fragment_unnamed_322.z);
					fragment_unnamed_362 = asfloat(fragment_unnamed_330 ? asuint(fragment_unnamed_338 * fragment_unnamed_333) : asuint(fragment_unnamed_296));
					fragment_unnamed_363 = asfloat(fragment_unnamed_330 ? asuint(fragment_unnamed_338 * fragment_unnamed_332) : asuint(fragment_unnamed_295));
					fragment_unnamed_364 = asfloat(fragment_unnamed_330 ? asuint(fragment_unnamed_338 * fragment_unnamed_331) : asuint(fragment_unnamed_294));
				}
				else
				{
					fragment_unnamed_358 = fragment_unnamed_237;
					fragment_unnamed_359 = fragment_unnamed_238;
					fragment_unnamed_360 = fragment_unnamed_239;
					fragment_unnamed_361 = fragment_unnamed_250;
					fragment_unnamed_362 = fragment_unnamed_296;
					fragment_unnamed_363 = fragment_unnamed_295;
					fragment_unnamed_364 = fragment_unnamed_294;
				}
				float fragment_unnamed_368 = max(dot(float3(fragment_unnamed_364, fragment_unnamed_363, fragment_unnamed_362), float3(fragment_unnamed_220 * fragment_unnamed_202, fragment_unnamed_220 * fragment_unnamed_209, fragment_unnamed_220 * fragment_unnamed_216)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_371 = ((-0.0f) - fragment_unnamed_361) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_252 + exp2(log2(abs(fragment_unnamed_252 + fragment_unnamed_368)) * exp2(mad(fragment_unnamed_371 * fragment_unnamed_371, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_400 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_401 = fragment_unnamed_400.x;
				float fragment_unnamed_688;
				float fragment_unnamed_690;
				float fragment_unnamed_692;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_401 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_401 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_689;
					float fragment_unnamed_691;
					float fragment_unnamed_693;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_425 = asfloat(1065353216u);
						float fragment_unnamed_455 = fragment_unnamed_363 * fragment_unnamed_364;
						float fragment_unnamed_456 = fragment_unnamed_362 * fragment_unnamed_363;
						float fragment_unnamed_457 = fragment_unnamed_362 * fragment_unnamed_362;
						float fragment_unnamed_458 = fragment_unnamed_364 * fragment_unnamed_362;
						float fragment_unnamed_491 = mad(fragment_unnamed_364, fragment_unnamed_364, (-0.0f) - (fragment_unnamed_363 * fragment_unnamed_363));
						fragment_unnamed_689 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_364, fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_425)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_491, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_455, fragment_unnamed_456, fragment_unnamed_457, fragment_unnamed_458)));
						fragment_unnamed_691 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_364, fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_425)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_491, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_455, fragment_unnamed_456, fragment_unnamed_457, fragment_unnamed_458)));
						fragment_unnamed_693 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_364, fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_425)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_491, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_455, fragment_unnamed_456, fragment_unnamed_457, fragment_unnamed_458)));
					}
					else
					{
						bool fragment_unnamed_507 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_508 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_530 = fragment_unnamed_507 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_531 = fragment_unnamed_507 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_532 = fragment_unnamed_507 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_636 = (asfloat(fragment_unnamed_508 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_532, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_530, fragment_unnamed_531 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_531)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_637 = (asfloat(fragment_unnamed_508 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_532, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_530, fragment_unnamed_531 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_532)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_651 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_508 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_532, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_530, fragment_unnamed_531 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_530)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_678 = asfloat(1065353216u);
						fragment_unnamed_689 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_651, fragment_unnamed_636, fragment_unnamed_637), 0.0f)), float4(fragment_unnamed_364, fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_678));
						fragment_unnamed_691 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_651 + 0.25f, fragment_unnamed_636 + 0.0f, fragment_unnamed_637 + 0.0f), 0.0f)), float4(fragment_unnamed_364, fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_678));
						fragment_unnamed_693 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_651 + 0.5f, fragment_unnamed_636 + 0.0f, fragment_unnamed_637 + 0.0f), 0.0f)), float4(fragment_unnamed_364, fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_678));
					}
					fragment_unnamed_688 = fragment_unnamed_689;
					fragment_unnamed_690 = fragment_unnamed_691;
					fragment_unnamed_692 = fragment_unnamed_693;
				}
				else
				{
					fragment_unnamed_688 = asfloat(0u);
					fragment_unnamed_690 = asfloat(0u);
					fragment_unnamed_692 = asfloat(0u);
				}
				float fragment_unnamed_695 = ((-0.0f) - fragment_unnamed_251) + 1.0f;
				float fragment_unnamed_696 = fragment_unnamed_695 * fragment_unnamed_358;
				float fragment_unnamed_697 = fragment_unnamed_695 * fragment_unnamed_359;
				float fragment_unnamed_698 = fragment_unnamed_695 * fragment_unnamed_360;
				float fragment_unnamed_703 = mad(fragment_unnamed_251, fragment_unnamed_358 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_705 = mad(fragment_unnamed_251, fragment_unnamed_359 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_706 = mad(fragment_unnamed_251, fragment_unnamed_360 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_718 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_368), 0.984375f, 0.0078125f), mad(fragment_unnamed_371, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_728 = clamp((max(fragment_unnamed_706, max(fragment_unnamed_705, fragment_unnamed_703)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_752 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_757 = max(abs(fragment_unnamed_362), 0.0009765625f);
				float fragment_unnamed_761 = (fragment_unnamed_362 >= 0.0f) ? fragment_unnamed_757 : ((-0.0f) - fragment_unnamed_757);
				float fragment_unnamed_770 = 1.0f / max(dot(float3(abs(fragment_unnamed_364), abs(fragment_unnamed_363), abs(fragment_unnamed_761)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_775 = clamp((-0.0f) - (fragment_unnamed_770 * fragment_unnamed_761), 0.0f, 1.0f);
				float fragment_unnamed_778 = (-0.0f) - fragment_unnamed_775;
				uint fragment_unnamed_790 = uint(clamp(mad(mad(fragment_unnamed_364, fragment_unnamed_770, ((fragment_unnamed_770 * fragment_unnamed_364) >= 0.0f) ? fragment_unnamed_775 : fragment_unnamed_778), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_791 = uint(clamp(mad(mad(fragment_unnamed_363, fragment_unnamed_770, ((fragment_unnamed_770 * fragment_unnamed_363) >= 0.0f) ? fragment_unnamed_775 : fragment_unnamed_778), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_790 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_791 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_791 >> 8u) * 16u) + (fragment_unnamed_790 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_703)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_705)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_706)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_844 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_845 = fragment_unnamed_844 * (fragment_unnamed_252 * (fragment_unnamed_752 * ((fragment_unnamed_718 * mad(fragment_unnamed_728, mad((-0.0f) - fragment_unnamed_358, fragment_unnamed_695, fragment_unnamed_703), fragment_unnamed_696)) * fragment_unnamed_688)));
				float fragment_unnamed_846 = fragment_unnamed_844 * (fragment_unnamed_252 * (fragment_unnamed_752 * ((fragment_unnamed_718 * mad(fragment_unnamed_728, mad((-0.0f) - fragment_unnamed_359, fragment_unnamed_695, fragment_unnamed_705), fragment_unnamed_697)) * fragment_unnamed_690)));
				float fragment_unnamed_847 = fragment_unnamed_844 * (fragment_unnamed_252 * (fragment_unnamed_752 * ((fragment_unnamed_718 * mad(fragment_unnamed_728, mad((-0.0f) - fragment_unnamed_360, fragment_unnamed_695, fragment_unnamed_706), fragment_unnamed_698)) * fragment_unnamed_692)));
				bool fragment_unnamed_860 = (((fragment_unnamed_847 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_846 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_845 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_860 ? asfloat(1157627904u) : fragment_unnamed_845;
				fragment_output_3.y = fragment_unnamed_860 ? fragment_unnamed_252 : fragment_unnamed_846;
				fragment_output_3.z = fragment_unnamed_860 ? asfloat(1149239296u) : fragment_unnamed_847;
				fragment_output_0.x = fragment_unnamed_696;
				fragment_output_0.y = fragment_unnamed_697;
				fragment_output_0.z = fragment_unnamed_698;
				fragment_output_1.w = fragment_unnamed_371;
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
			float _DeployStatus;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[15];
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
				if ((((0.0f < vertex_uniform_buffer_2[14u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					float vertex_unnamed_110 = (vertex_input_0.x + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_112 = (vertex_input_0.y + (-1.12000000476837158203125f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_113 = (vertex_input_0.z + (-0.0f)) * (-0.4000000059604644775390625f);
					float vertex_unnamed_121 = mad(vertex_input_0.x, 1.0f, 0.0f);
					float vertex_unnamed_123 = mad(vertex_input_0.y, 0.579999983310699462890625f, -0.660000026226043701171875f);
					float vertex_unnamed_126 = mad(vertex_input_0.z, 1.0f, 0.0f);
					float vertex_unnamed_135 = clamp((sqrt(dot(float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126), float3(vertex_unnamed_121, vertex_unnamed_123, vertex_unnamed_126))) + (-0.20000000298023223876953125f)) * 4.000000476837158203125f, 0.0f, 1.0f);
					float vertex_unnamed_158 = ((-0.0f) - vertex_uniform_buffer_2[6u].y) + 1.0f;
					float vertex_unnamed_168 = mad(vertex_input_0.x, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.x, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_110), vertex_unnamed_110));
					float vertex_unnamed_169 = mad(vertex_input_0.y, 0.949999988079071044921875f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.y, -0.0005000000237487256526947021484375f, (-0.0f) - vertex_unnamed_112), vertex_unnamed_112));
					float vertex_unnamed_171 = mad(vertex_input_0.z, 1.0f, vertex_unnamed_158 * mad(vertex_unnamed_135, mad(vertex_input_1.z, -0.00200000009499490261077880859375f, (-0.0f) - vertex_unnamed_113), vertex_unnamed_113));
					float vertex_unnamed_204 = asfloat(1065353216u);
					float vertex_unnamed_206 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_224 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_242 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_168, vertex_unnamed_169, vertex_unnamed_171, vertex_unnamed_204));
					float vertex_unnamed_257 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_272 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_286 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_294 = rsqrt(max(dot(float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286), float3(vertex_unnamed_257, vertex_unnamed_272, vertex_unnamed_286)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_294 * vertex_unnamed_257;
					vertex_output_7.y = vertex_unnamed_294 * vertex_unnamed_272;
					vertex_output_7.z = vertex_unnamed_294 * vertex_unnamed_286;
					float vertex_unnamed_328 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_329 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_330 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_335 = rsqrt(max(dot(float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330), float3(vertex_unnamed_328, vertex_unnamed_329, vertex_unnamed_330)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_335 * vertex_unnamed_328;
					vertex_output_1.y = vertex_unnamed_335 * vertex_unnamed_329;
					vertex_output_1.z = vertex_unnamed_335 * vertex_unnamed_330;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_242, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_206, vertex_unnamed_224 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_206;
					vertex_output_6.y = vertex_unnamed_224;
					vertex_output_6.z = vertex_unnamed_242;
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

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _DeployStatus, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

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
			GpuProgramID 776833

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
			GpuProgramID 839577

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
			GpuProgramID 878883

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
			GpuProgramID 922422

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
			GpuProgramID 1005494

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
			GpuProgramID 1092803

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
