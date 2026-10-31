Shader "Shader Graphs/GlowingBarrel"
{
	Properties
	{
		[NoScaleOffset] _MaskMap ("MaskMap", 2D) = "white" {}
		[NoScaleOffset] _BaseColorMap ("BaseColorMap", 2D) = "white" {}
		[NoScaleOffset] _TemperatureGradient ("TemperatureGradient", 2D) = "white" {}
		_Temperature ("Temperature", Range(0, 1)) = 0
		[NoScaleOffset] _HeatMap ("HeatMap", 2D) = "white" {}
		_GradientIntensity ("GradientIntensity", Float) = 1
		_HeatMapMinMax ("HeatMapMinMax", Vector) = (0,1,0,0)
		_HeatMapPow ("HeatMapPow", Float) = 1
		[NoScaleOffset] _NormalMap ("NormalMap", 2D) = "white" {}
		[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
		[HideInInspector] _RenderQueueType ("Float", Float) = 4
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
		[ToggleUI] [HideInInspector] _RequireSplitLighting ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _ReceivesSSR ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _ReceivesSSRTransparent ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _EnableBlendModePreserveSpecularLighting ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _SupportDecals ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _ExcludeFromTUAndAA ("Boolean", Float) = 0
		[HideInInspector] _StencilRef ("Float", Float) = 0
		[HideInInspector] _StencilWriteMask ("Float", Float) = 6
		[HideInInspector] _StencilRefDepth ("Float", Float) = 0
		[HideInInspector] _StencilWriteMaskDepth ("Float", Float) = 9
		[HideInInspector] _StencilRefMV ("Float", Float) = 32
		[HideInInspector] _StencilWriteMaskMV ("Float", Float) = 41
		[HideInInspector] _StencilRefDistortionVec ("Float", Float) = 4
		[HideInInspector] _StencilWriteMaskDistortionVec ("Float", Float) = 4
		[HideInInspector] _StencilWriteMaskGBuffer ("Float", Float) = 15
		[HideInInspector] _StencilRefGBuffer ("Float", Float) = 2
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
			GpuProgramID 7917

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			#if defined(SHADER_STAGE_VERTEX)
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

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
			};

			struct Vertex_Stage_Output
			{
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_72 = asfloat(1065353216u);
				float vertex_unnamed_74 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_72));
				float vertex_unnamed_103 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_72));
				float vertex_unnamed_133 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_72));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_133, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_103, vertex_unnamed_74 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_133, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_103, vertex_unnamed_74 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_133, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_103, vertex_unnamed_74 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_133, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_103, vertex_unnamed_74 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			void frag_main()
			{
			}

			void frag()
			{
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

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
			};

			struct Vertex_Stage_Output
			{
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_72 = asfloat(1065353216u);
				float vertex_unnamed_74 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_72));
				float vertex_unnamed_103 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_72));
				float vertex_unnamed_133 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_72));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_133, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_103, vertex_unnamed_74 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_133, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_103, vertex_unnamed_74 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_133, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_103, vertex_unnamed_74 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_133, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_103, vertex_unnamed_74 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			void frag_main()
			{
			}

			void frag()
			{
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
			GpuProgramID 280475

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma multi_compile _ _DISABLE_DECALS


			#if (!defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

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
			static float3 vertex_input_4;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float3 vertex_input_4 : TEXCOORD4; // TEXCOORD_4
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float4 vertex_output_4 : INTERP1; // INTERP_1
				float3 vertex_output_5 : INTERP2; // INTERP_2
				float3 vertex_output_6 : INTERP3; // INTERP_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_81 = asfloat(1065353216u);
				float vertex_unnamed_83 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_81));
				float vertex_unnamed_101 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_81));
				float vertex_unnamed_119 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_81));
				float vertex_unnamed_134 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_149 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_164 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_173 = rsqrt(max(dot(float3(vertex_unnamed_134, vertex_unnamed_149, vertex_unnamed_164), float3(vertex_unnamed_134, vertex_unnamed_149, vertex_unnamed_164)), 1.1754943508222875079687365372222e-38f));
				vertex_output_6.x = vertex_unnamed_173 * vertex_unnamed_134;
				vertex_output_6.y = vertex_unnamed_173 * vertex_unnamed_149;
				vertex_output_6.z = vertex_unnamed_173 * vertex_unnamed_164;
				float vertex_unnamed_208 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_209 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_210 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_215 = rsqrt(max(dot(float3(vertex_unnamed_208, vertex_unnamed_209, vertex_unnamed_210), float3(vertex_unnamed_208, vertex_unnamed_209, vertex_unnamed_210)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_215 * vertex_unnamed_208;
				vertex_output_3.y = vertex_unnamed_215 * vertex_unnamed_209;
				vertex_output_3.z = vertex_unnamed_215 * vertex_unnamed_210;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_119, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_119, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_119, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_119, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_119, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_119, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_119, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_323 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_336 = vertex_unnamed_323 ? vertex_input_4.x : vertex_input_0.x;
					float vertex_unnamed_337 = vertex_unnamed_323 ? vertex_input_4.y : vertex_input_0.y;
					float vertex_unnamed_338 = vertex_unnamed_323 ? vertex_input_4.z : vertex_input_0.z;
					float vertex_unnamed_372 = asfloat(1065353216u);
					float vertex_unnamed_373 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_336, vertex_unnamed_337, vertex_unnamed_338, vertex_unnamed_372));
					float vertex_unnamed_391 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_336, vertex_unnamed_337, vertex_unnamed_338, vertex_unnamed_372));
					float vertex_unnamed_409 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_336, vertex_unnamed_337, vertex_unnamed_338, vertex_unnamed_372));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_409, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_373, vertex_unnamed_391 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_409, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_373, vertex_unnamed_391 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_409, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_373, vertex_unnamed_391 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_input_3.x;
				vertex_output_4.y = vertex_input_3.y;
				vertex_output_4.z = vertex_input_3.z;
				vertex_output_4.w = vertex_input_3.w;
				vertex_output_5.x = vertex_unnamed_83;
				vertex_output_5.y = vertex_unnamed_101;
				vertex_output_5.z = vertex_unnamed_119;
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
				return stage_output;
			}
			#endif
			#if (!defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ScreenSize;
			float4 unity_MotionVectorsParams;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float3 fragment_input_5 : INTERP2; // INTERP_2
				float3 fragment_input_6 : INTERP3; // INTERP_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_53 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_54 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_104 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_104 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_53) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_53)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_104 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_54) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_54)))) * (-0.5f));
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
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 _ScreenSize;
			float4 unity_RenderingLayer;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float3 fragment_input_5 : INTERP2; // INTERP_2
				float3 fragment_input_6 : INTERP3; // INTERP_3
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
				float fragment_unnamed_54 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_55 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_105 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_105 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_54) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_54)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_105 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_55) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_55)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				uint fragment_unnamed_124 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_124, min((8u & 31u), (32u - fragment_unnamed_124)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = 0.5f;
				fragment_output_1.w = 0.5f;
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
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 _ScreenSize;
			float4 unity_RenderingLayer;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float3 fragment_input_5 : INTERP2; // INTERP_2
				float3 fragment_input_6 : INTERP3; // INTERP_3
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
				float fragment_unnamed_54 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_55 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_105 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_105 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_54) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_54)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_105 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_55) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_55)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_133 = 1.0f / max(sqrt(dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_141 = fragment_unnamed_133 * fragment_input_6.x;
				float fragment_unnamed_142 = fragment_unnamed_133 * fragment_input_6.y;
				float fragment_unnamed_143 = fragment_unnamed_133 * fragment_input_6.z;
				float fragment_unnamed_152 = 1.0f / max(dot(float3(abs(fragment_unnamed_141), abs(fragment_unnamed_142), abs(fragment_unnamed_143)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_157 = clamp((-0.0f) - (fragment_unnamed_152 * fragment_unnamed_143), 0.0f, 1.0f);
				float fragment_unnamed_160 = (-0.0f) - fragment_unnamed_157;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_141, fragment_unnamed_152, ((fragment_unnamed_152 * fragment_unnamed_141) >= 0.0f) ? fragment_unnamed_157 : fragment_unnamed_160), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_142, fragment_unnamed_152, ((fragment_unnamed_152 * fragment_unnamed_142) >= 0.0f) ? fragment_unnamed_157 : fragment_unnamed_160), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_180 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_180, min((8u & 31u), (32u - fragment_unnamed_180)))) * 0.0039215688593685626983642578125f;
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
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}

			#endif
			#if (defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 _ScreenSize;
			float4 unity_MotionVectorsParams;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float3 fragment_input_5 : INTERP2; // INTERP_2
				float3 fragment_input_6 : INTERP3; // INTERP_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_53 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_54 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_104 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_104 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_53) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_53)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_104 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_54) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_54)))) * (-0.5f));
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
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
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

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float3 vertex_input_4;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float3 vertex_input_4 : TEXCOORD4; // TEXCOORD_4
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float4 vertex_output_4 : INTERP1; // INTERP_1
				float3 vertex_output_5 : INTERP2; // INTERP_2
				float3 vertex_output_6 : INTERP3; // INTERP_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_81 = asfloat(1065353216u);
				float vertex_unnamed_83 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_81));
				float vertex_unnamed_101 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_81));
				float vertex_unnamed_119 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_81));
				float vertex_unnamed_134 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_149 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_164 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_173 = rsqrt(max(dot(float3(vertex_unnamed_134, vertex_unnamed_149, vertex_unnamed_164), float3(vertex_unnamed_134, vertex_unnamed_149, vertex_unnamed_164)), 1.1754943508222875079687365372222e-38f));
				vertex_output_6.x = vertex_unnamed_173 * vertex_unnamed_134;
				vertex_output_6.y = vertex_unnamed_173 * vertex_unnamed_149;
				vertex_output_6.z = vertex_unnamed_173 * vertex_unnamed_164;
				float vertex_unnamed_208 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_209 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_210 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_215 = rsqrt(max(dot(float3(vertex_unnamed_208, vertex_unnamed_209, vertex_unnamed_210), float3(vertex_unnamed_208, vertex_unnamed_209, vertex_unnamed_210)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_215 * vertex_unnamed_208;
				vertex_output_3.y = vertex_unnamed_215 * vertex_unnamed_209;
				vertex_output_3.z = vertex_unnamed_215 * vertex_unnamed_210;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_119, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_119, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_119, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_119, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_119, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_119, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_119, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_83, vertex_unnamed_101 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_323 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_336 = vertex_unnamed_323 ? vertex_input_4.x : vertex_input_0.x;
					float vertex_unnamed_337 = vertex_unnamed_323 ? vertex_input_4.y : vertex_input_0.y;
					float vertex_unnamed_338 = vertex_unnamed_323 ? vertex_input_4.z : vertex_input_0.z;
					float vertex_unnamed_372 = asfloat(1065353216u);
					float vertex_unnamed_373 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_336, vertex_unnamed_337, vertex_unnamed_338, vertex_unnamed_372));
					float vertex_unnamed_391 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_336, vertex_unnamed_337, vertex_unnamed_338, vertex_unnamed_372));
					float vertex_unnamed_409 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_336, vertex_unnamed_337, vertex_unnamed_338, vertex_unnamed_372));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_409, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_373, vertex_unnamed_391 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_409, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_373, vertex_unnamed_391 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_409, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_373, vertex_unnamed_391 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_input_3.x;
				vertex_output_4.y = vertex_input_3.y;
				vertex_output_4.z = vertex_input_3.z;
				vertex_output_4.w = vertex_input_3.w;
				vertex_output_5.x = vertex_unnamed_83;
				vertex_output_5.y = vertex_unnamed_101;
				vertex_output_5.z = vertex_unnamed_119;
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				stage_output.vertex_output_6 = vertex_output_6;
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
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float3 fragment_input_5 : INTERP2; // INTERP_2
				float3 fragment_input_6 : INTERP3; // INTERP_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_53 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_54 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_104 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_104 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_53) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_53)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_104 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_54) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_54)))) * (-0.5f));
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
			GpuProgramID 389582

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ _DISABLE_DECALS
			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT


			#if (defined(_DISABLE_DECALS) && defined(_SURFACE_TYPE_TRANSPARENT)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float _GlobalMipBias;
			float4 unity_WorldTransformParams;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _MaskMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_59 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_118 = 1.0f / max(sqrt(dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z))), 1.1754943508222875079687365372222e-38f);
				float4 fragment_unnamed_133 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_140 = mad(fragment_unnamed_133.x * fragment_unnamed_133.w, 2.0f, -1.0f);
				float fragment_unnamed_143 = mad(fragment_unnamed_133.y, 2.0f, -1.0f);
				float fragment_unnamed_175 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_140, fragment_unnamed_143), float2(fragment_unnamed_140, fragment_unnamed_143)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_177 = mad(fragment_unnamed_175, fragment_unnamed_118 * fragment_input_3.x, mad(fragment_unnamed_140, fragment_unnamed_118 * fragment_input_1.x, (fragment_unnamed_118 * (fragment_unnamed_59 * mad(fragment_input_3.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_3.z)))) * fragment_unnamed_143));
				float fragment_unnamed_178 = mad(fragment_unnamed_175, fragment_unnamed_118 * fragment_input_3.y, mad(fragment_unnamed_140, fragment_unnamed_118 * fragment_input_1.y, (fragment_unnamed_118 * (fragment_unnamed_59 * mad(fragment_input_3.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_3.x)))) * fragment_unnamed_143));
				float fragment_unnamed_179 = mad(fragment_unnamed_175, fragment_unnamed_118 * fragment_input_3.z, mad(fragment_unnamed_140, fragment_unnamed_118 * fragment_input_1.z, (fragment_unnamed_118 * (fragment_unnamed_59 * mad(fragment_input_3.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_3.y)))) * fragment_unnamed_143));
				float fragment_unnamed_184 = rsqrt(max(dot(float3(fragment_unnamed_177, fragment_unnamed_178, fragment_unnamed_179), float3(fragment_unnamed_177, fragment_unnamed_178, fragment_unnamed_179)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_185 = fragment_unnamed_184 * fragment_unnamed_177;
				float fragment_unnamed_186 = fragment_unnamed_184 * fragment_unnamed_178;
				float fragment_unnamed_187 = fragment_unnamed_184 * fragment_unnamed_179;
				float fragment_unnamed_189 = max(abs(fragment_unnamed_187), 0.0009765625f);
				float fragment_unnamed_193 = (fragment_unnamed_187 >= 0.0f) ? fragment_unnamed_189 : ((-0.0f) - fragment_unnamed_189);
				float fragment_unnamed_202 = 1.0f / max(dot(float3(abs(fragment_unnamed_185), abs(fragment_unnamed_186), abs(fragment_unnamed_193)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_207 = clamp((-0.0f) - (fragment_unnamed_202 * fragment_unnamed_193), 0.0f, 1.0f);
				float fragment_unnamed_210 = (-0.0f) - fragment_unnamed_207;
				uint fragment_unnamed_223 = uint(clamp(mad(mad(fragment_unnamed_185, fragment_unnamed_202, ((fragment_unnamed_202 * fragment_unnamed_185) >= 0.0f) ? fragment_unnamed_207 : fragment_unnamed_210), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_224 = uint(clamp(mad(mad(fragment_unnamed_186, fragment_unnamed_202, ((fragment_unnamed_202 * fragment_unnamed_186) >= 0.0f) ? fragment_unnamed_207 : fragment_unnamed_210), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_0.x = float(fragment_unnamed_223 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(fragment_unnamed_224 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_0.z = float(((fragment_unnamed_224 >> 8u) * 16u) + (fragment_unnamed_223 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_0.w = ((-0.0f) - _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).w) + 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

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
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;

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
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_77 = asfloat(1065353216u);
				float vertex_unnamed_79 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_77));
				float vertex_unnamed_108 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_77));
				float vertex_unnamed_138 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_77));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_138, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_108, vertex_unnamed_79 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_138, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_108, vertex_unnamed_79 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_138, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_108, vertex_unnamed_79 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_138, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_108, vertex_unnamed_79 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_195 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_196 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_197 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_203 = rsqrt(max(dot(float3(vertex_unnamed_195, vertex_unnamed_196, vertex_unnamed_197), float3(vertex_unnamed_195, vertex_unnamed_196, vertex_unnamed_197)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_203 * vertex_unnamed_195;
				vertex_output_1.y = vertex_unnamed_203 * vertex_unnamed_196;
				vertex_output_1.z = vertex_unnamed_203 * vertex_unnamed_197;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				float vertex_unnamed_237 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_252 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_267 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_274 = rsqrt(max(dot(float3(vertex_unnamed_237, vertex_unnamed_252, vertex_unnamed_267), float3(vertex_unnamed_237, vertex_unnamed_252, vertex_unnamed_267)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_274 * vertex_unnamed_237;
				vertex_output_3.y = vertex_unnamed_274 * vertex_unnamed_252;
				vertex_output_3.z = vertex_unnamed_274 * vertex_unnamed_267;
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
			GpuProgramID 463626

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER
			#pragma multi_compile _ _DISABLE_DECALS


			#if (!defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[15];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;

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
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_82 = asfloat(1065353216u);
				float vertex_unnamed_84 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				float vertex_unnamed_113 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				float vertex_unnamed_143 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				uint vertex_unnamed_184 = ((0.0f < vertex_uniform_buffer_2[14u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u);
				bool vertex_unnamed_185 = vertex_unnamed_184 != 0u;
				gl_Position.x = vertex_unnamed_185 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x);
				gl_Position.y = vertex_unnamed_185 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y);
				gl_Position.z = vertex_unnamed_185 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z);
				gl_Position.w = vertex_unnamed_185 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w);
				float vertex_unnamed_222 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_223 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_224 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_230 = rsqrt(max(dot(float3(vertex_unnamed_222, vertex_unnamed_223, vertex_unnamed_224), float3(vertex_unnamed_222, vertex_unnamed_223, vertex_unnamed_224)), 1.1754943508222875079687365372222e-38f));
				bool vertex_unnamed_236 = vertex_unnamed_184 != 0u;
				vertex_output_1.x = vertex_unnamed_236 ? 0.0f : (vertex_unnamed_230 * vertex_unnamed_222);
				vertex_output_1.y = vertex_unnamed_236 ? 0.0f : (vertex_unnamed_230 * vertex_unnamed_223);
				vertex_output_1.z = vertex_unnamed_236 ? 0.0f : (vertex_unnamed_230 * vertex_unnamed_224);
				vertex_output_1.w = vertex_unnamed_236 ? 0.0f : vertex_input_2.w;
				bool vertex_unnamed_245 = vertex_unnamed_184 != 0u;
				vertex_output_2.x = vertex_unnamed_245 ? 0.0f : vertex_input_3.x;
				vertex_output_2.y = vertex_unnamed_245 ? 0.0f : vertex_input_3.y;
				vertex_output_2.z = vertex_unnamed_245 ? 0.0f : vertex_input_3.z;
				vertex_output_2.w = vertex_unnamed_245 ? 0.0f : vertex_input_3.w;
				float vertex_unnamed_274 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_289 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_304 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_311 = rsqrt(max(dot(float3(vertex_unnamed_274, vertex_unnamed_289, vertex_unnamed_304), float3(vertex_unnamed_274, vertex_unnamed_289, vertex_unnamed_304)), 1.1754943508222875079687365372222e-38f));
				bool vertex_unnamed_315 = vertex_unnamed_184 != 0u;
				vertex_output_3.x = vertex_unnamed_315 ? 0.0f : (vertex_unnamed_311 * vertex_unnamed_274);
				vertex_output_3.y = vertex_unnamed_315 ? 0.0f : (vertex_unnamed_311 * vertex_unnamed_289);
				vertex_output_3.z = vertex_unnamed_315 ? 0.0f : (vertex_unnamed_311 * vertex_unnamed_304);
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

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

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
				return stage_output;
			}
			#endif
			#if (!defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER) && defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
			}

			#endif
			#if (defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 unity_RenderingLayer;

			static float4 fragment_uniform_buffer_0[11];
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
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
				float fragment_unnamed_45 = 1.0f / max(sqrt(dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_53 = fragment_unnamed_45 * fragment_input_3.x;
				float fragment_unnamed_54 = fragment_unnamed_45 * fragment_input_3.y;
				float fragment_unnamed_55 = fragment_unnamed_45 * fragment_input_3.z;
				float fragment_unnamed_64 = 1.0f / max(dot(float3(abs(fragment_unnamed_53), abs(fragment_unnamed_54), abs(fragment_unnamed_55)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_71 = clamp((-0.0f) - (fragment_unnamed_64 * fragment_unnamed_55), 0.0f, 1.0f);
				float fragment_unnamed_75 = (-0.0f) - fragment_unnamed_71;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_53, fragment_unnamed_64, ((fragment_unnamed_64 * fragment_unnamed_53) >= 0.0f) ? fragment_unnamed_71 : fragment_unnamed_75), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_54, fragment_unnamed_64, ((fragment_unnamed_64 * fragment_unnamed_54) >= 0.0f) ? fragment_unnamed_71 : fragment_unnamed_75), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_99 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_0[10u]).x, fragment_unnamed_99, min((8u & 31u), (32u - fragment_unnamed_99)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_0[10u]).x & 255u) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
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
			static float4 vertex_uniform_buffer_2[15];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;

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
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_82 = asfloat(1065353216u);
				float vertex_unnamed_84 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				float vertex_unnamed_113 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				float vertex_unnamed_143 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_82));
				uint vertex_unnamed_184 = ((0.0f < vertex_uniform_buffer_2[14u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u);
				bool vertex_unnamed_185 = vertex_unnamed_184 != 0u;
				gl_Position.x = vertex_unnamed_185 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x);
				gl_Position.y = vertex_unnamed_185 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y);
				gl_Position.z = vertex_unnamed_185 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z);
				gl_Position.w = vertex_unnamed_185 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_143, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_113, vertex_unnamed_84 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w);
				float vertex_unnamed_222 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_223 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_224 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_230 = rsqrt(max(dot(float3(vertex_unnamed_222, vertex_unnamed_223, vertex_unnamed_224), float3(vertex_unnamed_222, vertex_unnamed_223, vertex_unnamed_224)), 1.1754943508222875079687365372222e-38f));
				bool vertex_unnamed_236 = vertex_unnamed_184 != 0u;
				vertex_output_1.x = vertex_unnamed_236 ? 0.0f : (vertex_unnamed_230 * vertex_unnamed_222);
				vertex_output_1.y = vertex_unnamed_236 ? 0.0f : (vertex_unnamed_230 * vertex_unnamed_223);
				vertex_output_1.z = vertex_unnamed_236 ? 0.0f : (vertex_unnamed_230 * vertex_unnamed_224);
				vertex_output_1.w = vertex_unnamed_236 ? 0.0f : vertex_input_2.w;
				bool vertex_unnamed_245 = vertex_unnamed_184 != 0u;
				vertex_output_2.x = vertex_unnamed_245 ? 0.0f : vertex_input_3.x;
				vertex_output_2.y = vertex_unnamed_245 ? 0.0f : vertex_input_3.y;
				vertex_output_2.z = vertex_unnamed_245 ? 0.0f : vertex_input_3.z;
				vertex_output_2.w = vertex_unnamed_245 ? 0.0f : vertex_input_3.w;
				float vertex_unnamed_274 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_289 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_304 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_311 = rsqrt(max(dot(float3(vertex_unnamed_274, vertex_unnamed_289, vertex_unnamed_304), float3(vertex_unnamed_274, vertex_unnamed_289, vertex_unnamed_304)), 1.1754943508222875079687365372222e-38f));
				bool vertex_unnamed_315 = vertex_unnamed_184 != 0u;
				vertex_output_3.x = vertex_unnamed_315 ? 0.0f : (vertex_unnamed_311 * vertex_unnamed_274);
				vertex_output_3.y = vertex_unnamed_315 ? 0.0f : (vertex_unnamed_311 * vertex_unnamed_289);
				vertex_output_3.z = vertex_unnamed_315 ? 0.0f : (vertex_unnamed_311 * vertex_unnamed_304);
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

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

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
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
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
			GpuProgramID 572600

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature DECALS_3RT
			#pragma shader_feature _DISABLE_DECALS


			#if (!defined(DECALS_3RT) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
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
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float3 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
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
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_132 = asfloat(1065353216u);
					float vertex_unnamed_134 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_132));
					float vertex_unnamed_152 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_132));
					float vertex_unnamed_170 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_132));
					float vertex_unnamed_185 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_200 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_215 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_224 = rsqrt(max(dot(float3(vertex_unnamed_185, vertex_unnamed_200, vertex_unnamed_215), float3(vertex_unnamed_185, vertex_unnamed_200, vertex_unnamed_215)), 1.1754943508222875079687365372222e-38f));
					vertex_output_6.x = vertex_unnamed_224 * vertex_unnamed_185;
					vertex_output_6.y = vertex_unnamed_224 * vertex_unnamed_200;
					vertex_output_6.z = vertex_unnamed_224 * vertex_unnamed_215;
					float vertex_unnamed_258 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_259 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_260 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_265 = rsqrt(max(dot(float3(vertex_unnamed_258, vertex_unnamed_259, vertex_unnamed_260), float3(vertex_unnamed_258, vertex_unnamed_259, vertex_unnamed_260)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_265 * vertex_unnamed_258;
					vertex_output_1.y = vertex_unnamed_265 * vertex_unnamed_259;
					vertex_output_1.z = vertex_unnamed_265 * vertex_unnamed_260;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_5.x = vertex_unnamed_134;
					vertex_output_5.y = vertex_unnamed_152;
					vertex_output_5.z = vertex_unnamed_170;
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

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
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
			#if (defined(DECALS_3RT) && defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
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
			float _Temperature;
			float _GradientIntensity;
			float2 _HeatMapMinMax;
			float _HeatMapPow;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[5];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _TemperatureGradient;
			Texture2D<float4> _HeatMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState S2;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_HeatMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
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
				float3 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
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
				float fragment_unnamed_97 = 1.0f / max(sqrt(dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_117 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_180 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_206 = asfloat(fragment_unnamed_180 ? asuint(((-0.0f) - fragment_input_5.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_213 = asfloat(fragment_unnamed_180 ? asuint(((-0.0f) - fragment_input_5.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_220 = asfloat(fragment_unnamed_180 ? asuint(((-0.0f) - fragment_input_5.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_224 = rsqrt(dot(float3(fragment_unnamed_206, fragment_unnamed_213, fragment_unnamed_220), float3(fragment_unnamed_206, fragment_unnamed_213, fragment_unnamed_220)));
				float4 fragment_unnamed_238 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_241 = fragment_unnamed_238.x;
				float fragment_unnamed_242 = fragment_unnamed_238.y;
				float fragment_unnamed_243 = fragment_unnamed_238.z;
				float4 fragment_unnamed_252 = _HeatMap.SampleBias(sampler_HeatMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_286 = _TemperatureGradient.SampleBias(S2, float2(min(exp2(log2((fragment_unnamed_252.x + ((-0.0f) - fragment_uniform_buffer_2[4u].y)) / (((-0.0f) - fragment_uniform_buffer_2[4u].y) + fragment_uniform_buffer_2[4u].z)) * fragment_uniform_buffer_2[4u].w), 1.0f) * fragment_uniform_buffer_2[2u].x, asfloat(0u)), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_305 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_307 = fragment_unnamed_305.x;
				float fragment_unnamed_308 = fragment_unnamed_305.y;
				float4 fragment_unnamed_318 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_324 = mad(fragment_unnamed_318.x * fragment_unnamed_318.w, 2.0f, -1.0f);
				float fragment_unnamed_327 = mad(fragment_unnamed_318.y, 2.0f, -1.0f);
				float fragment_unnamed_335 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_324, fragment_unnamed_327), float2(fragment_unnamed_324, fragment_unnamed_327)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_343 = mad(fragment_unnamed_335, fragment_unnamed_97 * fragment_input_6.x, mad(fragment_unnamed_324, fragment_unnamed_97 * fragment_input_1.x, (fragment_unnamed_97 * (fragment_unnamed_117 * mad(fragment_input_6.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_6.z)))) * fragment_unnamed_327));
				float fragment_unnamed_344 = mad(fragment_unnamed_335, fragment_unnamed_97 * fragment_input_6.y, mad(fragment_unnamed_324, fragment_unnamed_97 * fragment_input_1.y, (fragment_unnamed_97 * (fragment_unnamed_117 * mad(fragment_input_6.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_6.x)))) * fragment_unnamed_327));
				float fragment_unnamed_345 = mad(fragment_unnamed_335, fragment_unnamed_97 * fragment_input_6.z, mad(fragment_unnamed_324, fragment_unnamed_97 * fragment_input_1.z, (fragment_unnamed_97 * (fragment_unnamed_117 * mad(fragment_input_6.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_6.y)))) * fragment_unnamed_327));
				float fragment_unnamed_350 = rsqrt(max(dot(float3(fragment_unnamed_343, fragment_unnamed_344, fragment_unnamed_345), float3(fragment_unnamed_343, fragment_unnamed_344, fragment_unnamed_345)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_351 = fragment_unnamed_350 * fragment_unnamed_343;
				float fragment_unnamed_352 = fragment_unnamed_350 * fragment_unnamed_344;
				float fragment_unnamed_353 = fragment_unnamed_350 * fragment_unnamed_345;
				uint4 fragment_unnamed_368 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_369 = fragment_unnamed_368.x;
				float fragment_unnamed_656;
				float fragment_unnamed_658;
				float fragment_unnamed_660;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_369 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_369 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_657;
					float fragment_unnamed_659;
					float fragment_unnamed_661;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_393 = asfloat(1065353216u);
						float fragment_unnamed_423 = fragment_unnamed_352 * fragment_unnamed_351;
						float fragment_unnamed_424 = fragment_unnamed_353 * fragment_unnamed_352;
						float fragment_unnamed_425 = fragment_unnamed_353 * fragment_unnamed_353;
						float fragment_unnamed_426 = fragment_unnamed_351 * fragment_unnamed_353;
						float fragment_unnamed_459 = mad(fragment_unnamed_351, fragment_unnamed_351, (-0.0f) - (fragment_unnamed_352 * fragment_unnamed_352));
						fragment_unnamed_657 = mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_459, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_423, fragment_unnamed_424, fragment_unnamed_425, fragment_unnamed_426))) + dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353, fragment_unnamed_393));
						fragment_unnamed_659 = mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_459, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_423, fragment_unnamed_424, fragment_unnamed_425, fragment_unnamed_426))) + dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353, fragment_unnamed_393));
						fragment_unnamed_661 = mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_459, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_423, fragment_unnamed_424, fragment_unnamed_425, fragment_unnamed_426))) + dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353, fragment_unnamed_393));
					}
					else
					{
						bool fragment_unnamed_475 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_476 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_498 = fragment_unnamed_475 ? (fragment_input_5.x + fragment_uniform_buffer_0[48u].x) : fragment_input_5.x;
						float fragment_unnamed_499 = fragment_unnamed_475 ? (fragment_input_5.y + fragment_uniform_buffer_0[48u].y) : fragment_input_5.y;
						float fragment_unnamed_500 = fragment_unnamed_475 ? (fragment_input_5.z + fragment_uniform_buffer_0[48u].z) : fragment_input_5.z;
						float fragment_unnamed_604 = (asfloat(fragment_unnamed_476 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_500, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_498, fragment_unnamed_499 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_499)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_605 = (asfloat(fragment_unnamed_476 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_500, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_498, fragment_unnamed_499 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_500)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_619 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(((asfloat(fragment_unnamed_476 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_500, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_498, fragment_unnamed_499 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_498)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f, fragment_uniform_buffer_1[22u].z * 0.5f));
						float fragment_unnamed_646 = asfloat(1065353216u);
						fragment_unnamed_657 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_619 + 0.5f, fragment_unnamed_604 + 0.0f, fragment_unnamed_605 + 0.0f), 0.0f)), float4(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353, fragment_unnamed_646));
						fragment_unnamed_659 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_619 + 0.25f, fragment_unnamed_604 + 0.0f, fragment_unnamed_605 + 0.0f), 0.0f)), float4(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353, fragment_unnamed_646));
						fragment_unnamed_661 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_619, fragment_unnamed_604, fragment_unnamed_605), 0.0f)), float4(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353, fragment_unnamed_646));
					}
					fragment_unnamed_656 = fragment_unnamed_657;
					fragment_unnamed_658 = fragment_unnamed_659;
					fragment_unnamed_660 = fragment_unnamed_661;
				}
				else
				{
					fragment_unnamed_656 = asfloat(0u);
					fragment_unnamed_658 = asfloat(0u);
					fragment_unnamed_660 = asfloat(0u);
				}
				float fragment_unnamed_664 = ((-0.0f) - fragment_unnamed_305.w) + 1.0f;
				float fragment_unnamed_665 = ((-0.0f) - fragment_unnamed_307) + 1.0f;
				float fragment_unnamed_666 = fragment_unnamed_665 * fragment_unnamed_241;
				float fragment_unnamed_667 = fragment_unnamed_665 * fragment_unnamed_242;
				float fragment_unnamed_668 = fragment_unnamed_665 * fragment_unnamed_243;
				float fragment_unnamed_673 = mad(fragment_unnamed_307, fragment_unnamed_241 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_675 = mad(fragment_unnamed_307, fragment_unnamed_242 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_676 = mad(fragment_unnamed_307, fragment_unnamed_243 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_691 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353), float3(fragment_unnamed_224 * fragment_unnamed_206, fragment_unnamed_224 * fragment_unnamed_213, fragment_unnamed_224 * fragment_unnamed_220)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_664, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_703 = clamp((max(fragment_unnamed_676, max(fragment_unnamed_675, fragment_unnamed_673)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_727 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_732 = max(abs(fragment_unnamed_353), 0.0009765625f);
				float fragment_unnamed_736 = (fragment_unnamed_353 >= 0.0f) ? fragment_unnamed_732 : ((-0.0f) - fragment_unnamed_732);
				float fragment_unnamed_745 = 1.0f / max(dot(float3(abs(fragment_unnamed_351), abs(fragment_unnamed_352), abs(fragment_unnamed_736)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_750 = clamp((-0.0f) - (fragment_unnamed_745 * fragment_unnamed_736), 0.0f, 1.0f);
				float fragment_unnamed_753 = (-0.0f) - fragment_unnamed_750;
				uint fragment_unnamed_765 = uint(clamp(mad(mad(fragment_unnamed_351, fragment_unnamed_745, ((fragment_unnamed_745 * fragment_unnamed_351) >= 0.0f) ? fragment_unnamed_750 : fragment_unnamed_753), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_766 = uint(clamp(mad(mad(fragment_unnamed_352, fragment_unnamed_745, ((fragment_unnamed_745 * fragment_unnamed_352) >= 0.0f) ? fragment_unnamed_750 : fragment_unnamed_753), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_765 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_766 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_766 >> 8u) * 16u) + (fragment_unnamed_765 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_673)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_675)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_676)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_820 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_821 = fragment_unnamed_820 * mad(fragment_unnamed_727 * (fragment_unnamed_660 * (fragment_unnamed_691 * mad(fragment_unnamed_703, mad((-0.0f) - fragment_unnamed_241, fragment_unnamed_665, fragment_unnamed_673), fragment_unnamed_666))), fragment_unnamed_308, fragment_unnamed_286.x * fragment_uniform_buffer_2[4u].x);
				float fragment_unnamed_822 = fragment_unnamed_820 * mad(fragment_unnamed_727 * (fragment_unnamed_658 * (fragment_unnamed_691 * mad(fragment_unnamed_703, mad((-0.0f) - fragment_unnamed_242, fragment_unnamed_665, fragment_unnamed_675), fragment_unnamed_667))), fragment_unnamed_308, fragment_unnamed_286.y * fragment_uniform_buffer_2[4u].x);
				float fragment_unnamed_823 = fragment_unnamed_820 * mad(fragment_unnamed_727 * (fragment_unnamed_656 * (fragment_unnamed_691 * mad(fragment_unnamed_703, mad((-0.0f) - fragment_unnamed_243, fragment_unnamed_665, fragment_unnamed_676), fragment_unnamed_668))), fragment_unnamed_308, fragment_unnamed_286.z * fragment_uniform_buffer_2[4u].x);
				bool fragment_unnamed_836 = (((fragment_unnamed_823 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_822 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_821 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_836 ? asfloat(1157627904u) : fragment_unnamed_821;
				fragment_output_3.y = fragment_unnamed_836 ? fragment_unnamed_308 : fragment_unnamed_822;
				fragment_output_3.z = fragment_unnamed_836 ? asfloat(1149239296u) : fragment_unnamed_823;
				fragment_output_0.x = fragment_unnamed_666;
				fragment_output_0.y = fragment_unnamed_667;
				fragment_output_0.z = fragment_unnamed_668;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_unnamed_664;
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

				fragment_uniform_buffer_2[2] = float4(_Temperature, fragment_uniform_buffer_2[2][1], fragment_uniform_buffer_2[2][2], fragment_uniform_buffer_2[2][3]);

				fragment_uniform_buffer_2[4] = float4(_GradientIntensity, fragment_uniform_buffer_2[4][1], fragment_uniform_buffer_2[4][2], fragment_uniform_buffer_2[4][3]);

				fragment_uniform_buffer_2[4] = float4(fragment_uniform_buffer_2[4][0], _HeatMapMinMax[0], _HeatMapMinMax[1], fragment_uniform_buffer_2[4][3]);

				fragment_uniform_buffer_2[4] = float4(fragment_uniform_buffer_2[4][0], fragment_uniform_buffer_2[4][1], fragment_uniform_buffer_2[4][2], _HeatMapPow);

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
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif
			#if (defined(DECALS_3RT) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			int _EnableDecals;
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
			float _Temperature;
			float _GradientIntensity;
			float2 _HeatMapMinMax;
			float _HeatMapPow;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[5];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _TemperatureGradient;
			Texture2D<float4> _HeatMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState S2;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_HeatMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
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
				float3 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
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
				float fragment_unnamed_105 = 1.0f / max(sqrt(dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_125 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_188 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_214 = asfloat(fragment_unnamed_188 ? asuint(((-0.0f) - fragment_input_5.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_221 = asfloat(fragment_unnamed_188 ? asuint(((-0.0f) - fragment_input_5.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_228 = asfloat(fragment_unnamed_188 ? asuint(((-0.0f) - fragment_input_5.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_232 = rsqrt(dot(float3(fragment_unnamed_214, fragment_unnamed_221, fragment_unnamed_228), float3(fragment_unnamed_214, fragment_unnamed_221, fragment_unnamed_228)));
				float4 fragment_unnamed_246 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_249 = fragment_unnamed_246.x;
				float fragment_unnamed_250 = fragment_unnamed_246.y;
				float fragment_unnamed_251 = fragment_unnamed_246.z;
				float4 fragment_unnamed_260 = _HeatMap.SampleBias(sampler_HeatMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_294 = _TemperatureGradient.SampleBias(S2, float2(min(exp2(log2((fragment_unnamed_260.x + ((-0.0f) - fragment_uniform_buffer_2[4u].y)) / (((-0.0f) - fragment_uniform_buffer_2[4u].y) + fragment_uniform_buffer_2[4u].z)) * fragment_uniform_buffer_2[4u].w), 1.0f) * fragment_uniform_buffer_2[2u].x, asfloat(0u)), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_313 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_315 = fragment_unnamed_313.w;
				float fragment_unnamed_316 = fragment_unnamed_313.x;
				float fragment_unnamed_317 = fragment_unnamed_313.y;
				float4 fragment_unnamed_326 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_332 = mad(fragment_unnamed_326.x * fragment_unnamed_326.w, 2.0f, -1.0f);
				float fragment_unnamed_335 = mad(fragment_unnamed_326.y, 2.0f, -1.0f);
				float fragment_unnamed_343 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_332, fragment_unnamed_335), float2(fragment_unnamed_332, fragment_unnamed_335)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_351 = mad(fragment_unnamed_343, fragment_unnamed_105 * fragment_input_6.x, mad(fragment_unnamed_332, fragment_unnamed_105 * fragment_input_1.x, (fragment_unnamed_105 * (fragment_unnamed_125 * mad(fragment_input_6.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_6.z)))) * fragment_unnamed_335));
				float fragment_unnamed_352 = mad(fragment_unnamed_343, fragment_unnamed_105 * fragment_input_6.y, mad(fragment_unnamed_332, fragment_unnamed_105 * fragment_input_1.y, (fragment_unnamed_105 * (fragment_unnamed_125 * mad(fragment_input_6.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_6.x)))) * fragment_unnamed_335));
				float fragment_unnamed_353 = mad(fragment_unnamed_343, fragment_unnamed_105 * fragment_input_6.z, mad(fragment_unnamed_332, fragment_unnamed_105 * fragment_input_1.z, (fragment_unnamed_105 * (fragment_unnamed_125 * mad(fragment_input_6.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_6.y)))) * fragment_unnamed_335));
				float fragment_unnamed_358 = rsqrt(max(dot(float3(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353), float3(fragment_unnamed_351, fragment_unnamed_352, fragment_unnamed_353)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_359 = fragment_unnamed_358 * fragment_unnamed_351;
				float fragment_unnamed_360 = fragment_unnamed_358 * fragment_unnamed_352;
				float fragment_unnamed_361 = fragment_unnamed_358 * fragment_unnamed_353;
				float fragment_unnamed_423;
				float fragment_unnamed_424;
				float fragment_unnamed_425;
				float fragment_unnamed_426;
				float fragment_unnamed_427;
				float fragment_unnamed_428;
				float fragment_unnamed_429;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_372 = uint(gl_FragCoord.x);
					uint fragment_unnamed_373 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_374 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_372, fragment_unnamed_373, 0u), 0u));
					float fragment_unnamed_380 = fragment_unnamed_374.w;
					float4 fragment_unnamed_381 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_372, fragment_unnamed_373, 0u), 0u));
					float fragment_unnamed_386 = fragment_unnamed_381.w;
					float4 fragment_unnamed_387 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_372, fragment_unnamed_373, 0u), 0u));
					bool fragment_unnamed_395 = fragment_unnamed_386 < 1.0f;
					float fragment_unnamed_396 = mad(fragment_unnamed_359, fragment_unnamed_386, mad(fragment_unnamed_381.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_397 = mad(fragment_unnamed_360, fragment_unnamed_386, mad(fragment_unnamed_381.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_398 = mad(fragment_unnamed_361, fragment_unnamed_386, mad(fragment_unnamed_381.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_403 = rsqrt(max(dot(float3(fragment_unnamed_396, fragment_unnamed_397, fragment_unnamed_398), float3(fragment_unnamed_396, fragment_unnamed_397, fragment_unnamed_398)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_423 = mad(fragment_unnamed_249, fragment_unnamed_380, fragment_unnamed_374.x);
					fragment_unnamed_424 = mad(fragment_unnamed_250, fragment_unnamed_380, fragment_unnamed_374.y);
					fragment_unnamed_425 = mad(fragment_unnamed_251, fragment_unnamed_380, fragment_unnamed_374.z);
					fragment_unnamed_426 = mad(fragment_unnamed_315, fragment_unnamed_387.w, fragment_unnamed_387.z);
					fragment_unnamed_427 = asfloat(fragment_unnamed_395 ? asuint(fragment_unnamed_403 * fragment_unnamed_398) : asuint(fragment_unnamed_361));
					fragment_unnamed_428 = asfloat(fragment_unnamed_395 ? asuint(fragment_unnamed_403 * fragment_unnamed_397) : asuint(fragment_unnamed_360));
					fragment_unnamed_429 = asfloat(fragment_unnamed_395 ? asuint(fragment_unnamed_403 * fragment_unnamed_396) : asuint(fragment_unnamed_359));
				}
				else
				{
					fragment_unnamed_423 = fragment_unnamed_249;
					fragment_unnamed_424 = fragment_unnamed_250;
					fragment_unnamed_425 = fragment_unnamed_251;
					fragment_unnamed_426 = fragment_unnamed_315;
					fragment_unnamed_427 = fragment_unnamed_361;
					fragment_unnamed_428 = fragment_unnamed_360;
					fragment_unnamed_429 = fragment_unnamed_359;
				}
				uint4 fragment_unnamed_444 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_445 = fragment_unnamed_444.x;
				float fragment_unnamed_732;
				float fragment_unnamed_734;
				float fragment_unnamed_736;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_445 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_445 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_733;
					float fragment_unnamed_735;
					float fragment_unnamed_737;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_469 = asfloat(1065353216u);
						float fragment_unnamed_499 = fragment_unnamed_428 * fragment_unnamed_429;
						float fragment_unnamed_500 = fragment_unnamed_427 * fragment_unnamed_428;
						float fragment_unnamed_501 = fragment_unnamed_427 * fragment_unnamed_427;
						float fragment_unnamed_502 = fragment_unnamed_429 * fragment_unnamed_427;
						float fragment_unnamed_535 = mad(fragment_unnamed_429, fragment_unnamed_429, (-0.0f) - (fragment_unnamed_428 * fragment_unnamed_428));
						fragment_unnamed_733 = mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_535, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_499, fragment_unnamed_500, fragment_unnamed_501, fragment_unnamed_502))) + dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_429, fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_469));
						fragment_unnamed_735 = mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_535, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_499, fragment_unnamed_500, fragment_unnamed_501, fragment_unnamed_502))) + dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_429, fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_469));
						fragment_unnamed_737 = mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_535, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_499, fragment_unnamed_500, fragment_unnamed_501, fragment_unnamed_502))) + dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_429, fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_469));
					}
					else
					{
						bool fragment_unnamed_551 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_552 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_574 = fragment_unnamed_551 ? (fragment_input_5.x + fragment_uniform_buffer_0[48u].x) : fragment_input_5.x;
						float fragment_unnamed_575 = fragment_unnamed_551 ? (fragment_input_5.y + fragment_uniform_buffer_0[48u].y) : fragment_input_5.y;
						float fragment_unnamed_576 = fragment_unnamed_551 ? (fragment_input_5.z + fragment_uniform_buffer_0[48u].z) : fragment_input_5.z;
						float fragment_unnamed_680 = (asfloat(fragment_unnamed_552 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_576, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_574, fragment_unnamed_575 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_575)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_681 = (asfloat(fragment_unnamed_552 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_576, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_574, fragment_unnamed_575 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_576)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_695 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(((asfloat(fragment_unnamed_552 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_576, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_574, fragment_unnamed_575 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_574)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f, fragment_uniform_buffer_1[22u].z * 0.5f));
						float fragment_unnamed_722 = asfloat(1065353216u);
						fragment_unnamed_733 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_695 + 0.25f, fragment_unnamed_680 + 0.0f, fragment_unnamed_681 + 0.0f), 0.0f)), float4(fragment_unnamed_429, fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_722));
						fragment_unnamed_735 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_695 + 0.5f, fragment_unnamed_680 + 0.0f, fragment_unnamed_681 + 0.0f), 0.0f)), float4(fragment_unnamed_429, fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_722));
						fragment_unnamed_737 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_695, fragment_unnamed_680, fragment_unnamed_681), 0.0f)), float4(fragment_unnamed_429, fragment_unnamed_428, fragment_unnamed_427, fragment_unnamed_722));
					}
					fragment_unnamed_732 = fragment_unnamed_733;
					fragment_unnamed_734 = fragment_unnamed_735;
					fragment_unnamed_736 = fragment_unnamed_737;
				}
				else
				{
					fragment_unnamed_732 = asfloat(0u);
					fragment_unnamed_734 = asfloat(0u);
					fragment_unnamed_736 = asfloat(0u);
				}
				float fragment_unnamed_739 = ((-0.0f) - fragment_unnamed_426) + 1.0f;
				float fragment_unnamed_741 = ((-0.0f) - fragment_unnamed_316) + 1.0f;
				float fragment_unnamed_742 = fragment_unnamed_741 * fragment_unnamed_423;
				float fragment_unnamed_743 = fragment_unnamed_741 * fragment_unnamed_424;
				float fragment_unnamed_744 = fragment_unnamed_741 * fragment_unnamed_425;
				float fragment_unnamed_749 = mad(fragment_unnamed_316, fragment_unnamed_423 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_751 = mad(fragment_unnamed_316, fragment_unnamed_424 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_752 = mad(fragment_unnamed_316, fragment_unnamed_425 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_769 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_429, fragment_unnamed_428, fragment_unnamed_427), float3(fragment_unnamed_232 * fragment_unnamed_214, fragment_unnamed_232 * fragment_unnamed_221, fragment_unnamed_232 * fragment_unnamed_228)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_739, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_779 = clamp((max(fragment_unnamed_752, max(fragment_unnamed_751, fragment_unnamed_749)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_803 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_808 = max(abs(fragment_unnamed_427), 0.0009765625f);
				float fragment_unnamed_812 = (fragment_unnamed_427 >= 0.0f) ? fragment_unnamed_808 : ((-0.0f) - fragment_unnamed_808);
				float fragment_unnamed_821 = 1.0f / max(dot(float3(abs(fragment_unnamed_429), abs(fragment_unnamed_428), abs(fragment_unnamed_812)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_826 = clamp((-0.0f) - (fragment_unnamed_821 * fragment_unnamed_812), 0.0f, 1.0f);
				float fragment_unnamed_829 = (-0.0f) - fragment_unnamed_826;
				uint fragment_unnamed_841 = uint(clamp(mad(mad(fragment_unnamed_429, fragment_unnamed_821, ((fragment_unnamed_821 * fragment_unnamed_429) >= 0.0f) ? fragment_unnamed_826 : fragment_unnamed_829), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_842 = uint(clamp(mad(mad(fragment_unnamed_428, fragment_unnamed_821, ((fragment_unnamed_821 * fragment_unnamed_428) >= 0.0f) ? fragment_unnamed_826 : fragment_unnamed_829), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_841 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_842 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_842 >> 8u) * 16u) + (fragment_unnamed_841 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_749)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_751)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_752)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_896 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_897 = fragment_unnamed_896 * mad(fragment_unnamed_803 * (fragment_unnamed_736 * (fragment_unnamed_769 * mad(fragment_unnamed_779, mad((-0.0f) - fragment_unnamed_423, fragment_unnamed_741, fragment_unnamed_749), fragment_unnamed_742))), fragment_unnamed_317, fragment_unnamed_294.x * fragment_uniform_buffer_2[4u].x);
				float fragment_unnamed_898 = fragment_unnamed_896 * mad(fragment_unnamed_803 * (fragment_unnamed_732 * (fragment_unnamed_769 * mad(fragment_unnamed_779, mad((-0.0f) - fragment_unnamed_424, fragment_unnamed_741, fragment_unnamed_751), fragment_unnamed_743))), fragment_unnamed_317, fragment_unnamed_294.y * fragment_uniform_buffer_2[4u].x);
				float fragment_unnamed_899 = fragment_unnamed_896 * mad(fragment_unnamed_803 * (fragment_unnamed_734 * (fragment_unnamed_769 * mad(fragment_unnamed_779, mad((-0.0f) - fragment_unnamed_425, fragment_unnamed_741, fragment_unnamed_752), fragment_unnamed_744))), fragment_unnamed_317, fragment_unnamed_294.z * fragment_uniform_buffer_2[4u].x);
				bool fragment_unnamed_912 = (((fragment_unnamed_899 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_898 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_897 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_912 ? asfloat(1157627904u) : fragment_unnamed_897;
				fragment_output_3.y = fragment_unnamed_912 ? fragment_unnamed_317 : fragment_unnamed_898;
				fragment_output_3.z = fragment_unnamed_912 ? asfloat(1149239296u) : fragment_unnamed_899;
				fragment_output_0.x = fragment_unnamed_742;
				fragment_output_0.y = fragment_unnamed_743;
				fragment_output_0.z = fragment_unnamed_744;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_unnamed_739;
				fragment_output_2.w = 0.0f;
				fragment_output_3.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[210] = float4(fragment_uniform_buffer_0[210][0], fragment_uniform_buffer_0[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_0[210][3]);

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

				fragment_uniform_buffer_2[2] = float4(_Temperature, fragment_uniform_buffer_2[2][1], fragment_uniform_buffer_2[2][2], fragment_uniform_buffer_2[2][3]);

				fragment_uniform_buffer_2[4] = float4(_GradientIntensity, fragment_uniform_buffer_2[4][1], fragment_uniform_buffer_2[4][2], fragment_uniform_buffer_2[4][3]);

				fragment_uniform_buffer_2[4] = float4(fragment_uniform_buffer_2[4][0], _HeatMapMinMax[0], _HeatMapMinMax[1], fragment_uniform_buffer_2[4][3]);

				fragment_uniform_buffer_2[4] = float4(fragment_uniform_buffer_2[4][0], fragment_uniform_buffer_2[4][1], fragment_uniform_buffer_2[4][2], _HeatMapPow);

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
			static float4 vertex_uniform_buffer_2[15];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_input_5;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float3 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
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
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_132 = asfloat(1065353216u);
					float vertex_unnamed_134 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_132));
					float vertex_unnamed_152 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_132));
					float vertex_unnamed_170 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_132));
					float vertex_unnamed_185 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_200 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_215 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_224 = rsqrt(max(dot(float3(vertex_unnamed_185, vertex_unnamed_200, vertex_unnamed_215), float3(vertex_unnamed_185, vertex_unnamed_200, vertex_unnamed_215)), 1.1754943508222875079687365372222e-38f));
					vertex_output_6.x = vertex_unnamed_224 * vertex_unnamed_185;
					vertex_output_6.y = vertex_unnamed_224 * vertex_unnamed_200;
					vertex_output_6.z = vertex_unnamed_224 * vertex_unnamed_215;
					float vertex_unnamed_258 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_259 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_260 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_265 = rsqrt(max(dot(float3(vertex_unnamed_258, vertex_unnamed_259, vertex_unnamed_260), float3(vertex_unnamed_258, vertex_unnamed_259, vertex_unnamed_260)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_265 * vertex_unnamed_258;
					vertex_output_1.y = vertex_unnamed_265 * vertex_unnamed_259;
					vertex_output_1.z = vertex_unnamed_265 * vertex_unnamed_260;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_5.x = vertex_unnamed_134;
					vertex_output_5.y = vertex_unnamed_152;
					vertex_output_5.z = vertex_unnamed_170;
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

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
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
			GpuProgramID 637639

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


			#if (defined(AREA_SHADOW_MEDIUM) && defined(DECALS_3RT) && defined(DIRECTIONAL_SHADOW_MEDIUM) && defined(PUNCTUAL_SHADOW_MEDIUM) && defined(SCREEN_SPACE_SHADOWS_OFF) && defined(USE_CLUSTERED_LIGHTLIST) && defined(_DISABLE_DECALS) && defined(_ENABLE_FOG_ON_TRANSPARENT) && defined(_SURFACE_TYPE_TRANSPARENT)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

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
			int _SpecularFade;
			int _DirectionalLightCount;
			int _EnvLightSkyEnabled;
			int _CascadeShadowCount;
			int _DirectionalShadowIndex;
			int _EnableSkyReflection;
			float _ProbeExposureScale;
			float _ReplaceDiffuseForIndirect;
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
			float _Temperature;
			float _GradientIntensity;
			float2 _HeatMapMinMax;
			float _HeatMapPow;
			float _BlendMode;
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
			static float4 fragment_uniform_buffer_3[15];
			static float4 fragment_uniform_buffer_4[13];
			static const float fragment_unnamed_108[16] = { 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };

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
			Texture2D<float4> _TemperatureGradient;
			Texture2D<float4> _HeatMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _MaskMap;
			Texture3D<float4> _AtmosphericScatteringLUT;
			Texture2DArray<uint4> _StencilTexture;
			Texture2DArray<float4> _RefractiveDepthBuffer;
			Buffer<uint4> T22;
			Buffer<uint4> T23;
			Texture2DArray<float4> _WaterGBufferTexture3;
			Buffer<uint4> T25;
			Texture3D<float4> _VBufferLighting;
			Texture2D<float4> _ShadowmapAtlas;
			Texture2D<float4> _CachedShadowmapAtlas;
			Texture2D<float4> _ShadowmapCascadeAtlas;
			Texture2D<float4> _ShadowmapAreaAtlas;
			Texture2D<float4> _CachedAreaLightShadowmapAtlas;
			Buffer<uint4> T32;
			Buffer<uint4> T33;
			Texture2DArray<float4> _LtcData;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			SamplerState S0;
			SamplerState S1;
			SamplerComparisonState S2;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState S4;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_HeatMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float3 fragment_input_5;
			static float3 fragment_input_6;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float4 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
				float3 fragment_input_6 : INTERP5; // INTERP_5
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_179 = 1.0f / max(sqrt(dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_197 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_253 = fragment_unnamed_179 * fragment_input_6.x;
				float fragment_unnamed_254 = fragment_unnamed_179 * fragment_input_6.y;
				float fragment_unnamed_255 = fragment_unnamed_179 * fragment_input_6.z;
				bool fragment_unnamed_262 = 0u < asuint(fragment_uniform_buffer_0[211u]).y;
				float fragment_unnamed_282 = fragment_unnamed_262 ? float(uint(round(gl_FragCoord.x * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.x;
				float fragment_unnamed_283 = fragment_unnamed_262 ? float(uint(round(gl_FragCoord.y * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.y;
				uint fragment_unnamed_284 = uint(fragment_unnamed_282);
				uint fragment_unnamed_285 = uint(fragment_unnamed_283);
				uint fragment_unnamed_286 = fragment_unnamed_284 >> 5u;
				uint fragment_unnamed_288 = fragment_unnamed_285 >> 5u;
				float fragment_unnamed_294 = fragment_unnamed_282 * fragment_uniform_buffer_0[50u].z;
				float fragment_unnamed_295 = fragment_unnamed_283 * fragment_uniform_buffer_0[50u].w;
				bool fragment_unnamed_299 = fragment_uniform_buffer_0[15u].w == 0.0f;
				uint4 fragment_unnamed_320 = asuint(fragment_uniform_buffer_0[0u]);
				uint fragment_unnamed_321 = fragment_unnamed_320.z;
				uint4 fragment_unnamed_325 = asuint(fragment_uniform_buffer_0[1u]);
				uint fragment_unnamed_326 = fragment_unnamed_325.z;
				uint4 fragment_unnamed_330 = asuint(fragment_uniform_buffer_0[2u]);
				uint fragment_unnamed_331 = fragment_unnamed_330.z;
				float fragment_unnamed_337 = asfloat(fragment_unnamed_299 ? asuint(((-0.0f) - fragment_input_5.x) + fragment_uniform_buffer_0[11u].x) : fragment_unnamed_321);
				float fragment_unnamed_339 = asfloat(fragment_unnamed_299 ? asuint(((-0.0f) - fragment_input_5.y) + fragment_uniform_buffer_0[11u].y) : fragment_unnamed_326);
				float fragment_unnamed_341 = asfloat(fragment_unnamed_299 ? asuint(((-0.0f) - fragment_input_5.z) + fragment_uniform_buffer_0[11u].z) : fragment_unnamed_331);
				float fragment_unnamed_345 = rsqrt(dot(float3(fragment_unnamed_337, fragment_unnamed_339, fragment_unnamed_341), float3(fragment_unnamed_337, fragment_unnamed_339, fragment_unnamed_341)));
				float fragment_unnamed_346 = fragment_unnamed_345 * fragment_unnamed_337;
				float fragment_unnamed_347 = fragment_unnamed_345 * fragment_unnamed_339;
				float fragment_unnamed_348 = fragment_unnamed_345 * fragment_unnamed_341;
				float4 fragment_unnamed_359 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_362 = fragment_unnamed_359.x;
				float fragment_unnamed_363 = fragment_unnamed_359.y;
				float fragment_unnamed_364 = fragment_unnamed_359.z;
				float4 fragment_unnamed_373 = _HeatMap.SampleBias(sampler_HeatMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_403 = asfloat(1065353216u);
				float4 fragment_unnamed_408 = _TemperatureGradient.SampleBias(S4, float2(min(exp2(log2((fragment_unnamed_373.x + ((-0.0f) - fragment_uniform_buffer_3[4u].y)) / (((-0.0f) - fragment_uniform_buffer_3[4u].y) + fragment_uniform_buffer_3[4u].z)) * fragment_uniform_buffer_3[4u].w), 1.0f) * fragment_uniform_buffer_3[2u].x, asfloat(0u)), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_421 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_423 = fragment_unnamed_421.x;
				float fragment_unnamed_424 = fragment_unnamed_421.y;
				float4 fragment_unnamed_434 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_440 = mad(fragment_unnamed_434.x * fragment_unnamed_434.w, 2.0f, -1.0f);
				float fragment_unnamed_443 = mad(fragment_unnamed_434.y, 2.0f, -1.0f);
				float fragment_unnamed_451 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_440, fragment_unnamed_443), float2(fragment_unnamed_440, fragment_unnamed_443)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_459 = mad(fragment_unnamed_451, fragment_unnamed_253, mad(fragment_unnamed_440, fragment_unnamed_179 * fragment_input_1.x, (fragment_unnamed_179 * (fragment_unnamed_197 * mad(fragment_input_6.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_6.z)))) * fragment_unnamed_443));
				float fragment_unnamed_460 = mad(fragment_unnamed_451, fragment_unnamed_254, mad(fragment_unnamed_440, fragment_unnamed_179 * fragment_input_1.y, (fragment_unnamed_179 * (fragment_unnamed_197 * mad(fragment_input_6.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_6.x)))) * fragment_unnamed_443));
				float fragment_unnamed_461 = mad(fragment_unnamed_451, fragment_unnamed_255, mad(fragment_unnamed_440, fragment_unnamed_179 * fragment_input_1.z, (fragment_unnamed_179 * (fragment_unnamed_197 * mad(fragment_input_6.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_6.y)))) * fragment_unnamed_443));
				float fragment_unnamed_466 = rsqrt(max(dot(float3(fragment_unnamed_459, fragment_unnamed_460, fragment_unnamed_461), float3(fragment_unnamed_459, fragment_unnamed_460, fragment_unnamed_461)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_467 = fragment_unnamed_466 * fragment_unnamed_459;
				float fragment_unnamed_468 = fragment_unnamed_466 * fragment_unnamed_460;
				float fragment_unnamed_469 = fragment_unnamed_466 * fragment_unnamed_461;
				uint fragment_unnamed_475 = asuint(fragment_uniform_buffer_1[10u]).x & 65535u;
				float fragment_unnamed_743;
				float fragment_unnamed_744;
				float fragment_unnamed_745;
				if (fragment_uniform_buffer_1[22u].x == 0.0f)
				{
					float fragment_unnamed_482 = asfloat(1065353216u);
					float fragment_unnamed_511 = fragment_unnamed_468 * fragment_unnamed_467;
					float fragment_unnamed_512 = fragment_unnamed_469 * fragment_unnamed_468;
					float fragment_unnamed_513 = fragment_unnamed_469 * fragment_unnamed_469;
					float fragment_unnamed_514 = fragment_unnamed_467 * fragment_unnamed_469;
					float fragment_unnamed_546 = mad(fragment_unnamed_467, fragment_unnamed_467, (-0.0f) - (fragment_unnamed_468 * fragment_unnamed_468));
					fragment_unnamed_743 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469, fragment_unnamed_482)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_546, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_511, fragment_unnamed_512, fragment_unnamed_513, fragment_unnamed_514)));
					fragment_unnamed_744 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469, fragment_unnamed_482)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_546, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_511, fragment_unnamed_512, fragment_unnamed_513, fragment_unnamed_514)));
					fragment_unnamed_745 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469, fragment_unnamed_482)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_546, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_511, fragment_unnamed_512, fragment_unnamed_513, fragment_unnamed_514)));
				}
				else
				{
					bool fragment_unnamed_562 = fragment_uniform_buffer_1[22u].y == 0.0f;
					bool fragment_unnamed_563 = fragment_uniform_buffer_1[22u].y == 1.0f;
					float fragment_unnamed_585 = fragment_unnamed_562 ? (fragment_input_5.x + fragment_uniform_buffer_0[48u].x) : fragment_input_5.x;
					float fragment_unnamed_586 = fragment_unnamed_562 ? (fragment_input_5.y + fragment_uniform_buffer_0[48u].y) : fragment_input_5.y;
					float fragment_unnamed_587 = fragment_unnamed_562 ? (fragment_input_5.z + fragment_uniform_buffer_0[48u].z) : fragment_input_5.z;
					float fragment_unnamed_691 = (asfloat(fragment_unnamed_563 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_587, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_585, fragment_unnamed_586 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_586)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
					float fragment_unnamed_692 = (asfloat(fragment_unnamed_563 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_587, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_585, fragment_unnamed_586 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_587)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
					float fragment_unnamed_706 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(((asfloat(fragment_unnamed_563 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_587, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_585, fragment_unnamed_586 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_585)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f, fragment_uniform_buffer_1[22u].z * 0.5f));
					float fragment_unnamed_733 = asfloat(1065353216u);
					fragment_unnamed_743 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_706, fragment_unnamed_691, fragment_unnamed_692), 0.0f)), float4(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469, fragment_unnamed_733));
					fragment_unnamed_744 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_706 + 0.25f, fragment_unnamed_691 + 0.0f, fragment_unnamed_692 + 0.0f), 0.0f)), float4(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469, fragment_unnamed_733));
					fragment_unnamed_745 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_706 + 0.5f, fragment_unnamed_691 + 0.0f, fragment_unnamed_692 + 0.0f), 0.0f)), float4(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469, fragment_unnamed_733));
				}
				float fragment_unnamed_748 = ((-0.0f) - fragment_unnamed_421.w) + 1.0f;
				float fragment_unnamed_749 = ((-0.0f) - fragment_unnamed_423) + 1.0f;
				float fragment_unnamed_750 = fragment_unnamed_362 * fragment_unnamed_749;
				float fragment_unnamed_751 = fragment_unnamed_363 * fragment_unnamed_749;
				float fragment_unnamed_752 = fragment_unnamed_364 * fragment_unnamed_749;
				float fragment_unnamed_757 = mad(fragment_unnamed_423, fragment_unnamed_362 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_759 = mad(fragment_unnamed_423, fragment_unnamed_363 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_760 = mad(fragment_unnamed_423, fragment_unnamed_364 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_761 = dot(float3(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469), float3(fragment_unnamed_346, fragment_unnamed_347, fragment_unnamed_348));
				float fragment_unnamed_764 = max(fragment_unnamed_761, 9.9999997473787516355514526367188e-05f);
				float4 fragment_unnamed_772 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_764), 0.984375f, 0.0078125f), mad(fragment_unnamed_748, 0.984375f, 0.0078125f)), 0.0f);
				float fragment_unnamed_774 = fragment_unnamed_772.x;
				float fragment_unnamed_775 = fragment_unnamed_772.y;
				float fragment_unnamed_777 = fragment_unnamed_772.z + 0.5f;
				float fragment_unnamed_789 = clamp((max(fragment_unnamed_760, max(fragment_unnamed_759, fragment_unnamed_757)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				uint4 fragment_unnamed_808 = asuint(fragment_uniform_buffer_0[120u]);
				uint4 fragment_unnamed_817 = asuint(fragment_uniform_buffer_0[120u]);
				float fragment_unnamed_821 = asfloat(((fragment_unnamed_475 & fragment_unnamed_808.y) != 0u) ? fragment_unnamed_817.x : 1065353216u);
				float fragment_unnamed_823 = asfloat(((fragment_unnamed_475 & fragment_unnamed_808.w) != 0u) ? fragment_unnamed_817.z : 1065353216u);
				float fragment_unnamed_842 = asfloat((asuint(fragment_uniform_buffer_0[113u]).y == 1u) ? asuint(clamp(dot(float3(fragment_unnamed_757, fragment_unnamed_759, fragment_unnamed_760), 0.333000004291534423828125f.xxx) * 50.0f, 0.0f, 1.0f)) : 1065353216u);
				float fragment_unnamed_843 = fragment_unnamed_748 * fragment_unnamed_748;
				float fragment_unnamed_853 = mad(((-0.0f) - fragment_unnamed_757) + fragment_unnamed_842, fragment_unnamed_774, fragment_unnamed_757 * fragment_unnamed_775);
				float fragment_unnamed_854 = mad(((-0.0f) - fragment_unnamed_759) + fragment_unnamed_842, fragment_unnamed_774, fragment_unnamed_759 * fragment_unnamed_775);
				float fragment_unnamed_855 = mad(((-0.0f) - fragment_unnamed_760) + fragment_unnamed_842, fragment_unnamed_774, fragment_unnamed_760 * fragment_unnamed_775);
				float fragment_unnamed_857 = (1.0f / fragment_unnamed_775) + (-1.0f);
				float fragment_unnamed_858 = fragment_unnamed_843 * fragment_unnamed_843;
				float fragment_unnamed_862 = sqrt(mad(mad((-0.0f) - fragment_unnamed_764, fragment_unnamed_858, fragment_unnamed_764), fragment_unnamed_764, fragment_unnamed_858));
				float fragment_unnamed_863 = (-0.0f) - fragment_unnamed_346;
				float fragment_unnamed_864 = (-0.0f) - fragment_unnamed_347;
				float fragment_unnamed_865 = (-0.0f) - fragment_unnamed_348;
				float fragment_unnamed_866 = dot(float3(fragment_unnamed_863, fragment_unnamed_864, fragment_unnamed_865), float3(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469));
				float fragment_unnamed_870 = (-0.0f) - (fragment_unnamed_866 + fragment_unnamed_866);
				float fragment_unnamed_871 = mad(fragment_unnamed_467, fragment_unnamed_870, fragment_unnamed_863);
				float fragment_unnamed_872 = mad(fragment_unnamed_468, fragment_unnamed_870, fragment_unnamed_864);
				float fragment_unnamed_873 = mad(fragment_unnamed_469, fragment_unnamed_870, fragment_unnamed_865);
				float fragment_unnamed_875 = ((-0.0f) - fragment_unnamed_764) + 1.0f;
				float fragment_unnamed_877 = mad(fragment_unnamed_748, 0.984375f, 0.0078125f);
				float fragment_unnamed_878 = mad(sqrt(fragment_unnamed_875), 0.984375f, 0.0078125f);
				float4 fragment_unnamed_883 = _LtcData.SampleLevel(S0, float3(fragment_unnamed_877, fragment_unnamed_878, asfloat(1065353216u)), 0.0f);
				float fragment_unnamed_885 = fragment_unnamed_883.x;
				float fragment_unnamed_886 = fragment_unnamed_883.y;
				float fragment_unnamed_887 = fragment_unnamed_883.z;
				float fragment_unnamed_888 = fragment_unnamed_883.w;
				float4 fragment_unnamed_889 = _LtcData.SampleLevel(S0, float3(fragment_unnamed_877, fragment_unnamed_878, asfloat(0u)), 0.0f);
				float fragment_unnamed_891 = fragment_unnamed_889.x;
				float fragment_unnamed_892 = fragment_unnamed_889.y;
				float fragment_unnamed_893 = fragment_unnamed_889.z;
				float fragment_unnamed_894 = fragment_unnamed_889.w;
				bool fragment_unnamed_898 = 5.9604644775390625e-08f >= abs(((-0.0f) - fragment_unnamed_761) + 1.0f);
				bool fragment_unnamed_900 = fragment_unnamed_469 >= 0.0f;
				float fragment_unnamed_902 = asfloat(fragment_unnamed_900 ? 1065353216u : 3212836864u);
				float fragment_unnamed_906 = 1.0f / mad(fragment_unnamed_461, fragment_unnamed_466, fragment_unnamed_902);
				float fragment_unnamed_907 = fragment_unnamed_468 * fragment_unnamed_906;
				float fragment_unnamed_908 = fragment_unnamed_467 * fragment_unnamed_907;
				float fragment_unnamed_909 = fragment_unnamed_467 * fragment_unnamed_902;
				float fragment_unnamed_917 = mad((-0.0f) - fragment_unnamed_467, fragment_unnamed_761, fragment_unnamed_346);
				float fragment_unnamed_918 = mad((-0.0f) - fragment_unnamed_468, fragment_unnamed_761, fragment_unnamed_347);
				float fragment_unnamed_919 = mad((-0.0f) - fragment_unnamed_469, fragment_unnamed_761, fragment_unnamed_348);
				float fragment_unnamed_923 = rsqrt(dot(float3(fragment_unnamed_917, fragment_unnamed_918, fragment_unnamed_919), float3(fragment_unnamed_917, fragment_unnamed_918, fragment_unnamed_919)));
				float fragment_unnamed_924 = fragment_unnamed_923 * fragment_unnamed_917;
				float fragment_unnamed_925 = fragment_unnamed_923 * fragment_unnamed_918;
				float fragment_unnamed_926 = fragment_unnamed_923 * fragment_unnamed_919;
				float fragment_unnamed_945 = asfloat(fragment_unnamed_898 ? asuint(fragment_unnamed_908) : asuint(mad(fragment_unnamed_468, fragment_unnamed_926, (-0.0f) - (fragment_unnamed_469 * fragment_unnamed_925))));
				float fragment_unnamed_947 = asfloat(fragment_unnamed_898 ? asuint(mad(fragment_unnamed_468, fragment_unnamed_907, asfloat(fragment_unnamed_900 ? 3212836864u : 1065353216u))) : asuint(mad(fragment_unnamed_469, fragment_unnamed_924, (-0.0f) - (fragment_unnamed_467 * fragment_unnamed_926))));
				float fragment_unnamed_955 = asfloat(fragment_unnamed_898 ? asuint(mad(fragment_unnamed_467 * fragment_unnamed_909, fragment_unnamed_906, -1.0f)) : asuint(fragment_unnamed_924));
				float fragment_unnamed_1115;
				float fragment_unnamed_1117;
				float fragment_unnamed_1119;
				if (int(asuint(fragment_uniform_buffer_0[116u]).z) >= int(0u))
				{
					uint fragment_unnamed_969 = (asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 4u;
					uint3 fragment_unnamed_979 = uint3(T6.Load(fragment_unnamed_969).x, T6.Load(fragment_unnamed_969 + 1u).x, T6.Load(fragment_unnamed_969 + 2u).x);
					float fragment_unnamed_981 = asfloat(fragment_unnamed_979.x);
					float fragment_unnamed_983 = asfloat(fragment_unnamed_979.y);
					float fragment_unnamed_985 = asfloat(fragment_unnamed_979.z);
					float fragment_unnamed_1116;
					float fragment_unnamed_1118;
					float fragment_unnamed_1120;
					if ((((0.0f < dot(float3(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469), float3((-0.0f) - fragment_unnamed_981, (-0.0f) - fragment_unnamed_983, (-0.0f) - fragment_unnamed_985))) ? 4294967295u : 0u) & (((0.0f < asfloat(T6.Load((asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 27u).x)) ? 4294967295u : 0u) & ((0.0f < asfloat(T6.Load((asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 38u).x)) ? 4294967295u : 0u))) != 0u)
					{
						uint4 fragment_unnamed_1035 = uint4(T33.Load(0u).x, T33.Load(0u + 1u).x, T33.Load(0u + 2u).x, T33.Load(0u + 3u).x);
						float fragment_unnamed_1037 = asfloat(fragment_unnamed_1035.x);
						float fragment_unnamed_1039 = asfloat(fragment_unnamed_1035.y);
						float fragment_unnamed_1041 = asfloat(fragment_unnamed_1035.z);
						float fragment_unnamed_1043 = asfloat(fragment_unnamed_1035.w);
						uint4 fragment_unnamed_1055 = uint4(T33.Load(4u).x, T33.Load(4u + 1u).x, T33.Load(4u + 2u).x, T33.Load(4u + 3u).x);
						float fragment_unnamed_1057 = asfloat(fragment_unnamed_1055.x);
						float fragment_unnamed_1059 = asfloat(fragment_unnamed_1055.y);
						float fragment_unnamed_1061 = asfloat(fragment_unnamed_1055.z);
						float fragment_unnamed_1063 = asfloat(fragment_unnamed_1055.w);
						uint4 fragment_unnamed_1076 = uint4(T33.Load(8u).x, T33.Load(8u + 1u).x, T33.Load(8u + 2u).x, T33.Load(8u + 3u).x);
						float fragment_unnamed_1078 = asfloat(fragment_unnamed_1076.x);
						float fragment_unnamed_1080 = asfloat(fragment_unnamed_1076.y);
						float fragment_unnamed_1082 = asfloat(fragment_unnamed_1076.z);
						float fragment_unnamed_1084 = asfloat(fragment_unnamed_1076.w);
						uint4 fragment_unnamed_1097 = uint4(T33.Load(12u).x, T33.Load(12u + 1u).x, T33.Load(12u + 2u).x, T33.Load(12u + 3u).x);
						float fragment_unnamed_1099 = asfloat(fragment_unnamed_1097.x);
						float fragment_unnamed_1101 = asfloat(fragment_unnamed_1097.y);
						float fragment_unnamed_1103 = asfloat(fragment_unnamed_1097.z);
						float fragment_unnamed_1105 = asfloat(fragment_unnamed_1097.w);
						float fragment_unnamed_1106 = asfloat(0u);
						float fragment_unnamed_1107 = asfloat(0u);
						float fragment_unnamed_1108 = asfloat(0u);
						float fragment_unnamed_1109 = asfloat(4294967295u);
						float fragment_unnamed_1110 = asfloat(0u);
						float fragment_unnamed_1111 = asfloat(0u);
						float fragment_unnamed_1242;
						float fragment_unnamed_1246;
						float fragment_unnamed_1248;
						float fragment_unnamed_1250;
						float fragment_unnamed_1276;
						float fragment_unnamed_1277;
						float fragment_unnamed_1278;
						float fragment_unnamed_1280;
						float fragment_unnamed_1282;
						float fragment_unnamed_1239 = fragment_unnamed_1109;
						float fragment_unnamed_1241 = fragment_unnamed_1110;
						float fragment_unnamed_1243 = fragment_unnamed_1111;
						float fragment_unnamed_1245 = fragment_unnamed_1106;
						float fragment_unnamed_1247 = fragment_unnamed_1107;
						float fragment_unnamed_1249 = fragment_unnamed_1108;
						for (;;)
						{
							if (asuint(fragment_unnamed_1243) >= asuint(fragment_uniform_buffer_0[116u]).y)
							{
								fragment_unnamed_1276 = fragment_unnamed_1239;
								fragment_unnamed_1277 = fragment_unnamed_1241;
								fragment_unnamed_1278 = fragment_unnamed_1245;
								fragment_unnamed_1280 = fragment_unnamed_1247;
								fragment_unnamed_1282 = fragment_unnamed_1249;
								break;
							}
							else
							{
								uint fragment_unnamed_1289 = (asuint(fragment_unnamed_1243) * 4u) + 0u;
								uint fragment_unnamed_1299 = (asuint(fragment_unnamed_1243) * 4u) + 1u;
								uint fragment_unnamed_1308 = (asuint(fragment_unnamed_1243) * 4u) + 2u;
								uint fragment_unnamed_1317 = (asuint(fragment_unnamed_1243) * 4u) + 3u;
								fragment_unnamed_1246 = ((-0.0f) - mad(fragment_unnamed_108[fragment_unnamed_1317], fragment_unnamed_1099, mad(fragment_unnamed_108[fragment_unnamed_1308], fragment_unnamed_1078, mad(fragment_unnamed_108[fragment_unnamed_1299], fragment_unnamed_1057, fragment_unnamed_1037 * fragment_unnamed_108[fragment_unnamed_1289])))) + fragment_input_5.x;
								fragment_unnamed_1248 = ((-0.0f) - mad(fragment_unnamed_108[fragment_unnamed_1317], fragment_unnamed_1101, mad(fragment_unnamed_108[fragment_unnamed_1308], fragment_unnamed_1080, mad(fragment_unnamed_108[fragment_unnamed_1299], fragment_unnamed_1059, fragment_unnamed_1039 * fragment_unnamed_108[fragment_unnamed_1289])))) + fragment_input_5.y;
								fragment_unnamed_1250 = ((-0.0f) - mad(fragment_unnamed_108[fragment_unnamed_1317], fragment_unnamed_1103, mad(fragment_unnamed_108[fragment_unnamed_1308], fragment_unnamed_1082, mad(fragment_unnamed_108[fragment_unnamed_1299], fragment_unnamed_1061, fragment_unnamed_1041 * fragment_unnamed_108[fragment_unnamed_1289])))) + fragment_input_5.z;
								float fragment_unnamed_1333 = dot(float3(fragment_unnamed_1246, fragment_unnamed_1248, fragment_unnamed_1250), float3(fragment_unnamed_1246, fragment_unnamed_1248, fragment_unnamed_1250));
								fragment_unnamed_1242 = fragment_unnamed_1333 / mad(fragment_unnamed_108[fragment_unnamed_1317], fragment_unnamed_1105, mad(fragment_unnamed_108[fragment_unnamed_1308], fragment_unnamed_1084, mad(fragment_unnamed_108[fragment_unnamed_1299], fragment_unnamed_1063, fragment_unnamed_1043 * fragment_unnamed_108[fragment_unnamed_1289])));
								if (!((((0.0f < fragment_unnamed_1242) ? 4294967295u : 0u) & ((1.0f >= fragment_unnamed_1242) ? 4294967295u : 0u)) != 0u))
								{
									fragment_unnamed_1239 = asfloat(4294967295u);
									fragment_unnamed_1241 = fragment_unnamed_1242;
									fragment_unnamed_1243 = asfloat(asuint(fragment_unnamed_1243) + 1u);
									fragment_unnamed_1245 = fragment_unnamed_1246;
									fragment_unnamed_1247 = fragment_unnamed_1248;
									fragment_unnamed_1249 = fragment_unnamed_1250;
									continue;
								}
								float fragment_unnamed_1592 = sqrt(fragment_unnamed_1333);
								fragment_unnamed_1276 = fragment_unnamed_1243;
								fragment_unnamed_1277 = fragment_unnamed_1242;
								fragment_unnamed_1278 = fragment_unnamed_1246 / fragment_unnamed_1592;
								fragment_unnamed_1280 = fragment_unnamed_1248 / fragment_unnamed_1592;
								fragment_unnamed_1282 = fragment_unnamed_1250 / fragment_unnamed_1592;
								break;
							}
						}
						float fragment_unnamed_1285 = float(int(asuint(fragment_unnamed_1276)));
						float fragment_unnamed_1257;
						if (fragment_unnamed_1285 >= 0.0f)
						{
							uint4 fragment_unnamed_1432 = uint4(T33.Load(19u).x, T33.Load(19u + 1u).x, T33.Load(19u + 2u).x, T33.Load(19u + 3u).x);
							uint4 fragment_unnamed_1447 = T6.Load((asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 15u);
							uint fragment_unnamed_1448 = fragment_unnamed_1447.x;
							float fragment_unnamed_1459 = asfloat((dot(float3(fragment_unnamed_253, fragment_unnamed_254, fragment_unnamed_255), float3((-0.0f) - fragment_unnamed_981, (-0.0f) - fragment_unnamed_983, (-0.0f) - fragment_unnamed_985)) >= 0.0f) ? 1065353216u : 3212836864u);
							uint fragment_unnamed_1467 = asuint(fragment_unnamed_1276);
							float fragment_unnamed_1484 = dot(float4(asfloat(fragment_unnamed_1432.y), asfloat(fragment_unnamed_1432.z), asfloat(fragment_unnamed_1432.w), asfloat(T33.Load(23u).x)), float4(fragment_unnamed_108[(fragment_unnamed_1467 * 4u) + 0u], fragment_unnamed_108[(fragment_unnamed_1467 * 4u) + 1u], fragment_unnamed_108[(fragment_unnamed_1467 * 4u) + 2u], fragment_unnamed_108[(fragment_unnamed_1467 * 4u) + 3u]));
							float fragment_unnamed_1496 = asfloat((0.0f >= fragment_unnamed_1484) ? 0u : asuint(clamp((fragment_unnamed_1277 + ((-0.0f) - (((-0.0f) - fragment_unnamed_1484) + 1.0f))) / fragment_unnamed_1484, 0.0f, 1.0f)));
							float fragment_unnamed_1503 = clamp((fragment_unnamed_1484 + (-1.0f)) * (-3.3333332538604736328125f), 0.0f, 1.0f);
							float fragment_unnamed_1515 = mad(clamp(mad((fragment_unnamed_1503 * fragment_unnamed_1503) * mad(fragment_unnamed_1503, -2.0f, 3.0f), 512.0f, 8.0f) * dot(float3(fragment_unnamed_337, fragment_unnamed_339, fragment_unnamed_341), float3(fragment_unnamed_1278, fragment_unnamed_1280, fragment_unnamed_1282)), 0.0f, 1.0f), (-0.0f) - fragment_unnamed_1496, fragment_unnamed_1496);
							float fragment_unnamed_1521 = asfloat(T32.Load((fragment_unnamed_1448 * 60u) + 19u).x);
							uint fragment_unnamed_1523 = (fragment_unnamed_1448 * 60u) + 24u;
							uint2 fragment_unnamed_1529 = uint2(T32.Load(fragment_unnamed_1523).x, T32.Load(fragment_unnamed_1523 + 1u).x);
							uint fragment_unnamed_1535 = asuint(fragment_unnamed_1276) + fragment_unnamed_1448;
							uint fragment_unnamed_1537 = (fragment_unnamed_1535 * 60u) + 16u;
							uint3 fragment_unnamed_1546 = uint3(T32.Load(fragment_unnamed_1537).x, T32.Load(fragment_unnamed_1537 + 1u).x, T32.Load(fragment_unnamed_1537 + 2u).x);
							float fragment_unnamed_1552 = asfloat(fragment_unnamed_1546.z);
							float fragment_unnamed_1556 = fragment_unnamed_1552 * (fragment_unnamed_1521 * (fragment_unnamed_253 * fragment_unnamed_1459));
							float fragment_unnamed_1557 = fragment_unnamed_1552 * (fragment_unnamed_1521 * (fragment_unnamed_254 * fragment_unnamed_1459));
							float fragment_unnamed_1558 = fragment_unnamed_1552 * (fragment_unnamed_1521 * (fragment_unnamed_255 * fragment_unnamed_1459));
							uint fragment_unnamed_1561 = uint(int(asfloat(fragment_unnamed_1432.x))) + 4294967295u;
							float fragment_unnamed_1563 = float(int(uint(min(int(asuint(fragment_unnamed_1276) + 1u), int(fragment_unnamed_1561)))));
							float fragment_unnamed_1573 = trunc(fragment_uniform_buffer_0[74u].z);
							float fragment_unnamed_1993;
							float fragment_unnamed_1994;
							float fragment_unnamed_1995;
							float fragment_unnamed_1996;
							float fragment_unnamed_1997;
							float fragment_unnamed_1998;
							float fragment_unnamed_1999;
							float fragment_unnamed_2000;
							float fragment_unnamed_2001;
							float fragment_unnamed_2002;
							float fragment_unnamed_2003;
							float fragment_unnamed_2004;
							float fragment_unnamed_2005;
							float fragment_unnamed_2006;
							float fragment_unnamed_2007;
							float fragment_unnamed_2008;
							float fragment_unnamed_2009;
							float fragment_unnamed_2010;
							float fragment_unnamed_2011;
							float fragment_unnamed_2012;
							float fragment_unnamed_2013;
							float fragment_unnamed_2014;
							float fragment_unnamed_2015;
							float fragment_unnamed_2016;
							if (((((fragment_unnamed_1285 != fragment_unnamed_1563) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1515) ? 4294967295u : 0u)) & ((fragment_unnamed_1515 >= frac(frac(dot(float2(mad(fragment_unnamed_1573, 2.0829999446868896484375f, float(fragment_unnamed_284)), mad(fragment_unnamed_1573, 4.867000102996826171875f, float(fragment_unnamed_285))), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f))) * 52.98291778564453125f)) ? 4294967295u : 0u)) != 0u)
							{
								uint fragment_unnamed_1634 = uint(int(fragment_unnamed_1563 + float(int(fragment_unnamed_1448))));
								uint fragment_unnamed_1635 = fragment_unnamed_1634 * 60u;
								uint4 fragment_unnamed_1647 = uint4(T32.Load(fragment_unnamed_1635).x, T32.Load(fragment_unnamed_1635 + 1u).x, T32.Load(fragment_unnamed_1635 + 2u).x, T32.Load(fragment_unnamed_1635 + 3u).x);
								uint fragment_unnamed_1654 = (fragment_unnamed_1634 * 60u) + 4u;
								uint4 fragment_unnamed_1666 = uint4(T32.Load(fragment_unnamed_1654).x, T32.Load(fragment_unnamed_1654 + 1u).x, T32.Load(fragment_unnamed_1654 + 2u).x, T32.Load(fragment_unnamed_1654 + 3u).x);
								uint fragment_unnamed_1672 = (fragment_unnamed_1634 * 60u) + 12u;
								uint4 fragment_unnamed_1684 = uint4(T32.Load(fragment_unnamed_1672).x, T32.Load(fragment_unnamed_1672 + 1u).x, T32.Load(fragment_unnamed_1672 + 2u).x, T32.Load(fragment_unnamed_1672 + 3u).x);
								uint fragment_unnamed_1694 = (fragment_unnamed_1634 * 60u) + 8u;
								uint4 fragment_unnamed_1706 = uint4(T32.Load(fragment_unnamed_1694).x, T32.Load(fragment_unnamed_1694 + 1u).x, T32.Load(fragment_unnamed_1694 + 2u).x, T32.Load(fragment_unnamed_1694 + 3u).x);
								uint fragment_unnamed_1714 = (fragment_unnamed_1634 * 60u) + 16u;
								uint3 fragment_unnamed_1723 = uint3(T32.Load(fragment_unnamed_1714).x, T32.Load(fragment_unnamed_1714 + 1u).x, T32.Load(fragment_unnamed_1714 + 2u).x);
								uint fragment_unnamed_1730 = (fragment_unnamed_1634 * 60u) + 40u;
								uint3 fragment_unnamed_1739 = uint3(T32.Load(fragment_unnamed_1730).x, T32.Load(fragment_unnamed_1730 + 1u).x, T32.Load(fragment_unnamed_1730 + 2u).x);
								float fragment_unnamed_1755 = asfloat(fragment_unnamed_1723.z) / fragment_unnamed_1552;
								fragment_unnamed_1993 = fragment_unnamed_1755 * fragment_unnamed_1556;
								fragment_unnamed_1994 = asfloat(fragment_unnamed_1723.x);
								fragment_unnamed_1995 = asfloat(fragment_unnamed_1723.y);
								fragment_unnamed_1996 = fragment_unnamed_1755 * fragment_unnamed_1557;
								fragment_unnamed_1997 = fragment_unnamed_1755 * fragment_unnamed_1558;
								fragment_unnamed_1998 = asfloat(fragment_unnamed_1647.w);
								fragment_unnamed_1999 = asfloat(fragment_unnamed_1666.x);
								fragment_unnamed_2000 = asfloat(fragment_unnamed_1666.y);
								fragment_unnamed_2001 = asfloat(fragment_unnamed_1706.z);
								fragment_unnamed_2002 = asfloat(fragment_unnamed_1684.z);
								fragment_unnamed_2003 = asfloat(fragment_unnamed_1684.w);
								fragment_unnamed_2004 = asfloat(fragment_unnamed_1684.x);
								fragment_unnamed_2005 = asfloat(fragment_unnamed_1666.z);
								fragment_unnamed_2006 = asfloat(fragment_unnamed_1666.w);
								fragment_unnamed_2007 = asfloat(fragment_unnamed_1706.x);
								fragment_unnamed_2008 = asfloat(fragment_unnamed_1706.w);
								fragment_unnamed_2009 = asfloat(fragment_unnamed_1684.y);
								fragment_unnamed_2010 = asfloat(fragment_unnamed_1739.x) + fragment_input_5.x;
								fragment_unnamed_2011 = asfloat(fragment_unnamed_1739.y) + fragment_input_5.y;
								fragment_unnamed_2012 = asfloat(fragment_unnamed_1739.z) + fragment_input_5.z;
								fragment_unnamed_2013 = asfloat(fragment_unnamed_1647.x);
								fragment_unnamed_2014 = asfloat(fragment_unnamed_1647.y);
								fragment_unnamed_2015 = asfloat(fragment_unnamed_1647.z);
								fragment_unnamed_2016 = asfloat(fragment_unnamed_1706.y);
							}
							else
							{
								uint fragment_unnamed_1770 = fragment_unnamed_1535 * 60u;
								uint4 fragment_unnamed_1782 = uint4(T32.Load(fragment_unnamed_1770).x, T32.Load(fragment_unnamed_1770 + 1u).x, T32.Load(fragment_unnamed_1770 + 2u).x, T32.Load(fragment_unnamed_1770 + 3u).x);
								uint fragment_unnamed_1789 = (fragment_unnamed_1535 * 60u) + 4u;
								uint4 fragment_unnamed_1801 = uint4(T32.Load(fragment_unnamed_1789).x, T32.Load(fragment_unnamed_1789 + 1u).x, T32.Load(fragment_unnamed_1789 + 2u).x, T32.Load(fragment_unnamed_1789 + 3u).x);
								uint fragment_unnamed_1807 = (fragment_unnamed_1535 * 60u) + 12u;
								uint4 fragment_unnamed_1819 = uint4(T32.Load(fragment_unnamed_1807).x, T32.Load(fragment_unnamed_1807 + 1u).x, T32.Load(fragment_unnamed_1807 + 2u).x, T32.Load(fragment_unnamed_1807 + 3u).x);
								uint fragment_unnamed_1829 = (fragment_unnamed_1535 * 60u) + 8u;
								uint4 fragment_unnamed_1841 = uint4(T32.Load(fragment_unnamed_1829).x, T32.Load(fragment_unnamed_1829 + 1u).x, T32.Load(fragment_unnamed_1829 + 2u).x, T32.Load(fragment_unnamed_1829 + 3u).x);
								uint fragment_unnamed_1849 = (fragment_unnamed_1535 * 60u) + 40u;
								uint3 fragment_unnamed_1858 = uint3(T32.Load(fragment_unnamed_1849).x, T32.Load(fragment_unnamed_1849 + 1u).x, T32.Load(fragment_unnamed_1849 + 2u).x);
								fragment_unnamed_1993 = fragment_unnamed_1556;
								fragment_unnamed_1994 = asfloat(fragment_unnamed_1546.x);
								fragment_unnamed_1995 = asfloat(fragment_unnamed_1546.y);
								fragment_unnamed_1996 = fragment_unnamed_1557;
								fragment_unnamed_1997 = fragment_unnamed_1558;
								fragment_unnamed_1998 = asfloat(fragment_unnamed_1782.w);
								fragment_unnamed_1999 = asfloat(fragment_unnamed_1801.x);
								fragment_unnamed_2000 = asfloat(fragment_unnamed_1801.y);
								fragment_unnamed_2001 = asfloat(fragment_unnamed_1841.z);
								fragment_unnamed_2002 = asfloat(fragment_unnamed_1819.z);
								fragment_unnamed_2003 = asfloat(fragment_unnamed_1819.w);
								fragment_unnamed_2004 = asfloat(fragment_unnamed_1819.x);
								fragment_unnamed_2005 = asfloat(fragment_unnamed_1801.z);
								fragment_unnamed_2006 = asfloat(fragment_unnamed_1801.w);
								fragment_unnamed_2007 = asfloat(fragment_unnamed_1841.x);
								fragment_unnamed_2008 = asfloat(fragment_unnamed_1841.w);
								fragment_unnamed_2009 = asfloat(fragment_unnamed_1819.y);
								fragment_unnamed_2010 = asfloat(fragment_unnamed_1858.x) + fragment_input_5.x;
								fragment_unnamed_2011 = asfloat(fragment_unnamed_1858.y) + fragment_input_5.y;
								fragment_unnamed_2012 = asfloat(fragment_unnamed_1858.z) + fragment_input_5.z;
								fragment_unnamed_2013 = asfloat(fragment_unnamed_1782.x);
								fragment_unnamed_2014 = asfloat(fragment_unnamed_1782.y);
								fragment_unnamed_2015 = asfloat(fragment_unnamed_1782.z);
								fragment_unnamed_2016 = asfloat(fragment_unnamed_1841.y);
							}
							float fragment_unnamed_2017 = fragment_unnamed_1993 + fragment_unnamed_2010;
							float fragment_unnamed_2018 = fragment_unnamed_1996 + fragment_unnamed_2011;
							float fragment_unnamed_2019 = fragment_unnamed_1997 + fragment_unnamed_2012;
							float fragment_unnamed_2020 = asfloat(1065353216u);
							float fragment_unnamed_2047 = mad(asfloat(fragment_unnamed_1529.x) * clamp(mad(dot(float4(fragment_unnamed_2013, fragment_unnamed_2014, fragment_unnamed_2015, fragment_unnamed_2016), float4(fragment_unnamed_2017, fragment_unnamed_2018, fragment_unnamed_2019, fragment_unnamed_2020)) * fragment_unnamed_2004, 0.5f, 0.5f), 0.0f, 1.0f), fragment_uniform_buffer_0[98u].z, fragment_unnamed_1994);
							float fragment_unnamed_2048 = mad(asfloat(fragment_unnamed_1529.y) * clamp(mad(dot(float4(fragment_unnamed_1998, fragment_unnamed_1999, fragment_unnamed_2000, fragment_unnamed_2001), float4(fragment_unnamed_2017, fragment_unnamed_2018, fragment_unnamed_2019, fragment_unnamed_2020)) * fragment_unnamed_2009, 0.5f, 0.5f), 0.0f, 1.0f), fragment_uniform_buffer_0[98u].w, fragment_unnamed_1995);
							float fragment_unnamed_2049 = dot(float2(fragment_unnamed_2002, fragment_unnamed_2003), float2(dot(float4(fragment_unnamed_2005, fragment_unnamed_2006, fragment_unnamed_2007, fragment_unnamed_2008), float4(fragment_unnamed_2017, fragment_unnamed_2018, fragment_unnamed_2019, fragment_unnamed_2020)), asfloat(1065353216u))) + 1.52587890625e-05f;
							float fragment_unnamed_2057 = floor(mad(fragment_unnamed_2047, fragment_uniform_buffer_0[98u].x, 0.5f));
							float fragment_unnamed_2058 = floor(mad(fragment_unnamed_2048, fragment_uniform_buffer_0[98u].y, 0.5f));
							float fragment_unnamed_2065 = mad(fragment_unnamed_2047, fragment_uniform_buffer_0[98u].x, (-0.0f) - fragment_unnamed_2057);
							float fragment_unnamed_2066 = mad(fragment_unnamed_2048, fragment_uniform_buffer_0[98u].y, (-0.0f) - fragment_unnamed_2058);
							float fragment_unnamed_2067 = fragment_unnamed_2065 + 0.5f;
							float fragment_unnamed_2069 = fragment_unnamed_2066 + 0.5f;
							float fragment_unnamed_2075 = (fragment_unnamed_2067 * fragment_unnamed_2067) * 0.040816001594066619873046875f;
							float fragment_unnamed_2077 = (fragment_unnamed_2069 * fragment_unnamed_2069) * 0.040816001594066619873046875f;
							float fragment_unnamed_2086 = min(fragment_unnamed_2065, 0.0f);
							float fragment_unnamed_2087 = min(fragment_unnamed_2066, 0.0f);
							float fragment_unnamed_2092 = max(fragment_unnamed_2065, 0.0f);
							float fragment_unnamed_2093 = max(fragment_unnamed_2066, 0.0f);
							float fragment_unnamed_2107 = (mad((-0.0f) - fragment_unnamed_2086, fragment_unnamed_2086, ((-0.0f) - fragment_unnamed_2065) + 1.0f) + 2.0f) * 0.08163200318813323974609375f;
							float fragment_unnamed_2108 = (mad((-0.0f) - fragment_unnamed_2087, fragment_unnamed_2087, ((-0.0f) - fragment_unnamed_2066) + 1.0f) + 2.0f) * 0.08163200318813323974609375f;
							float fragment_unnamed_2113 = mad(fragment_unnamed_2065, -0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2114 = mad(fragment_unnamed_2065, 0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2115 = fragment_unnamed_2113 + (mad(fragment_unnamed_2067 * fragment_unnamed_2067, 0.5f, (-0.0f) - fragment_unnamed_2065) * 0.08163200318813323974609375f);
							float fragment_unnamed_2116 = fragment_unnamed_2107 + mad(fragment_unnamed_2065, -0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2117 = fragment_unnamed_2114 + ((mad((-0.0f) - fragment_unnamed_2092, fragment_unnamed_2092, fragment_unnamed_2065 + 1.0f) + 2.0f) * 0.08163200318813323974609375f);
							float fragment_unnamed_2118 = fragment_unnamed_2075 + mad(fragment_unnamed_2065, 0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2121 = mad(fragment_unnamed_2066, -0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2122 = mad(fragment_unnamed_2066, 0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2123 = fragment_unnamed_2121 + (mad(fragment_unnamed_2069 * fragment_unnamed_2069, 0.5f, (-0.0f) - fragment_unnamed_2066) * 0.08163200318813323974609375f);
							float fragment_unnamed_2124 = fragment_unnamed_2108 + mad(fragment_unnamed_2066, -0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2125 = fragment_unnamed_2122 + ((mad((-0.0f) - fragment_unnamed_2093, fragment_unnamed_2093, fragment_unnamed_2066 + 1.0f) + 2.0f) * 0.08163200318813323974609375f);
							float fragment_unnamed_2126 = fragment_unnamed_2077 + mad(fragment_unnamed_2066, 0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2149 = ((fragment_unnamed_2075 / fragment_unnamed_2118) + 2.5f) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2150 = ((fragment_unnamed_2113 / fragment_unnamed_2115) + (-3.5f)) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2151 = ((fragment_unnamed_2107 / fragment_unnamed_2116) + (-1.5f)) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2152 = ((fragment_unnamed_2114 / fragment_unnamed_2117) + 0.5f) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2156 = ((fragment_unnamed_2121 / fragment_unnamed_2123) + (-3.5f)) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2157 = ((fragment_unnamed_2077 / fragment_unnamed_2126) + 2.5f) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2158 = ((fragment_unnamed_2108 / fragment_unnamed_2124) + (-1.5f)) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2159 = ((fragment_unnamed_2122 / fragment_unnamed_2125) + 0.5f) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2236 = fragment_unnamed_2123 * fragment_unnamed_2115;
							float fragment_unnamed_2237 = fragment_unnamed_2123 * fragment_unnamed_2116;
							float fragment_unnamed_2238 = fragment_unnamed_2123 * fragment_unnamed_2117;
							float fragment_unnamed_2239 = fragment_unnamed_2123 * fragment_unnamed_2118;
							float fragment_unnamed_2240 = fragment_unnamed_2124 * fragment_unnamed_2115;
							float fragment_unnamed_2241 = fragment_unnamed_2124 * fragment_unnamed_2116;
							float fragment_unnamed_2242 = fragment_unnamed_2124 * fragment_unnamed_2117;
							float fragment_unnamed_2243 = fragment_unnamed_2124 * fragment_unnamed_2118;
							float fragment_unnamed_2244 = fragment_unnamed_2125 * fragment_unnamed_2115;
							float fragment_unnamed_2245 = fragment_unnamed_2125 * fragment_unnamed_2116;
							float fragment_unnamed_2246 = fragment_unnamed_2125 * fragment_unnamed_2117;
							float fragment_unnamed_2247 = fragment_unnamed_2125 * fragment_unnamed_2118;
							float fragment_unnamed_2248 = fragment_unnamed_2126 * fragment_unnamed_2115;
							float fragment_unnamed_2249 = fragment_unnamed_2126 * fragment_unnamed_2116;
							float fragment_unnamed_2250 = fragment_unnamed_2126 * fragment_unnamed_2117;
							float fragment_unnamed_2251 = fragment_unnamed_2126 * fragment_unnamed_2118;
							float4 fragment_unnamed_2257 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2150), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2156)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_2258 = fragment_unnamed_2257.x;
							float4 fragment_unnamed_2261 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2151), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2156)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_2262 = fragment_unnamed_2261.x;
							float4 fragment_unnamed_2265 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2152), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2156)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_2266 = fragment_unnamed_2265.x;
							float4 fragment_unnamed_2269 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2149), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2156)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_2270 = fragment_unnamed_2269.x;
							float fragment_unnamed_2272 = asfloat(0u);
							float fragment_unnamed_2585;
							fragment_unnamed_2585 = asfloat(0u);
							float fragment_unnamed_2586;
							float fragment_unnamed_2749;
							float fragment_unnamed_2750;
							float fragment_unnamed_2751;
							for (float fragment_unnamed_2583 = fragment_unnamed_2272; !(int(asuint(fragment_unnamed_2583)) >= int(1u)); fragment_unnamed_2749 = mad(fragment_unnamed_2236, fragment_unnamed_2258, fragment_unnamed_2585), fragment_unnamed_2750 = mad(fragment_unnamed_2237, fragment_unnamed_2262, fragment_unnamed_2749), fragment_unnamed_2751 = mad(fragment_unnamed_2238, fragment_unnamed_2266, fragment_unnamed_2750), fragment_unnamed_2586 = mad(fragment_unnamed_2239, fragment_unnamed_2270, fragment_unnamed_2751), fragment_unnamed_2583 = asfloat(asuint(fragment_unnamed_2583) + 1u), fragment_unnamed_2585 = fragment_unnamed_2586)
							{
							}
							float4 fragment_unnamed_2734 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2150), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2158)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_2735 = fragment_unnamed_2734.x;
							float4 fragment_unnamed_2738 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2151), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2158)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_2739 = fragment_unnamed_2738.x;
							float4 fragment_unnamed_2742 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2152), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2158)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_2743 = fragment_unnamed_2742.x;
							float4 fragment_unnamed_2746 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2149), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2158)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_2747 = fragment_unnamed_2746.x;
							float fragment_unnamed_2748 = asfloat(0u);
							float fragment_unnamed_3419;
							fragment_unnamed_3419 = fragment_unnamed_2585;
							float fragment_unnamed_3420;
							float fragment_unnamed_3774;
							float fragment_unnamed_3775;
							float fragment_unnamed_3776;
							for (float fragment_unnamed_3421 = fragment_unnamed_2748; !(int(asuint(fragment_unnamed_3421)) >= int(1u)); fragment_unnamed_3774 = mad(fragment_unnamed_2240, fragment_unnamed_2735, fragment_unnamed_3419), fragment_unnamed_3775 = mad(fragment_unnamed_2241, fragment_unnamed_2739, fragment_unnamed_3774), fragment_unnamed_3776 = mad(fragment_unnamed_2242, fragment_unnamed_2743, fragment_unnamed_3775), fragment_unnamed_3420 = mad(fragment_unnamed_2243, fragment_unnamed_2747, fragment_unnamed_3776), fragment_unnamed_3419 = fragment_unnamed_3420, fragment_unnamed_3421 = asfloat(asuint(fragment_unnamed_3421) + 1u))
							{
							}
							float4 fragment_unnamed_3759 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2150), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2159)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_3760 = fragment_unnamed_3759.x;
							float4 fragment_unnamed_3763 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2151), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2159)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_3764 = fragment_unnamed_3763.x;
							float4 fragment_unnamed_3767 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2152), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2159)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_3768 = fragment_unnamed_3767.x;
							float4 fragment_unnamed_3771 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2149), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2159)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_3772 = fragment_unnamed_3771.x;
							float fragment_unnamed_3773 = asfloat(0u);
							float fragment_unnamed_4457;
							fragment_unnamed_4457 = fragment_unnamed_3419;
							float fragment_unnamed_4458;
							float fragment_unnamed_4952;
							float fragment_unnamed_4953;
							float fragment_unnamed_4954;
							for (float fragment_unnamed_4455 = fragment_unnamed_3773; !(int(asuint(fragment_unnamed_4455)) >= int(1u)); fragment_unnamed_4952 = mad(fragment_unnamed_2244, fragment_unnamed_3760, fragment_unnamed_4457), fragment_unnamed_4953 = mad(fragment_unnamed_2245, fragment_unnamed_3764, fragment_unnamed_4952), fragment_unnamed_4954 = mad(fragment_unnamed_2246, fragment_unnamed_3768, fragment_unnamed_4953), fragment_unnamed_4458 = mad(fragment_unnamed_2247, fragment_unnamed_3772, fragment_unnamed_4954), fragment_unnamed_4455 = asfloat(asuint(fragment_unnamed_4455) + 1u), fragment_unnamed_4457 = fragment_unnamed_4458)
							{
							}
							float4 fragment_unnamed_4937 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2150), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2157)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_4938 = fragment_unnamed_4937.x;
							float4 fragment_unnamed_4941 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2151), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2157)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_4942 = fragment_unnamed_4941.x;
							float4 fragment_unnamed_4945 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2152), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2157)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_4946 = fragment_unnamed_4945.x;
							float4 fragment_unnamed_4949 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2057, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2149), mad(fragment_unnamed_2058, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2157)), fragment_unnamed_2049).xxxx;
							float fragment_unnamed_4950 = fragment_unnamed_4949.x;
							float fragment_unnamed_4951 = asfloat(0u);
							float fragment_unnamed_6034;
							fragment_unnamed_6034 = fragment_unnamed_4457;
							float fragment_unnamed_6035;
							float fragment_unnamed_6199;
							float fragment_unnamed_6200;
							float fragment_unnamed_6201;
							for (float fragment_unnamed_6036 = fragment_unnamed_4951; !(int(asuint(fragment_unnamed_6036)) >= int(1u)); fragment_unnamed_6199 = mad(fragment_unnamed_2248, fragment_unnamed_4938, fragment_unnamed_6034), fragment_unnamed_6200 = mad(fragment_unnamed_2249, fragment_unnamed_4942, fragment_unnamed_6199), fragment_unnamed_6201 = mad(fragment_unnamed_2250, fragment_unnamed_4946, fragment_unnamed_6200), fragment_unnamed_6035 = mad(fragment_unnamed_2251, fragment_unnamed_4950, fragment_unnamed_6201), fragment_unnamed_6034 = fragment_unnamed_6035, fragment_unnamed_6036 = asfloat(asuint(fragment_unnamed_6036) + 1u))
							{
							}
							fragment_unnamed_1257 = asfloat((int(asuint(fragment_unnamed_1276)) < int(fragment_unnamed_1561)) ? asuint(fragment_unnamed_6034) : asuint(mad(fragment_unnamed_1515, ((-0.0f) - fragment_unnamed_6034) + 1.0f, fragment_unnamed_6034)));
						}
						else
						{
							fragment_unnamed_1257 = asfloat(1065353216u);
						}
						fragment_unnamed_1116 = fragment_unnamed_1257;
						fragment_unnamed_1118 = fragment_unnamed_1257;
						fragment_unnamed_1120 = fragment_unnamed_1257;
					}
					else
					{
						fragment_unnamed_1116 = asfloat(1065353216u);
						fragment_unnamed_1118 = asfloat(1065353216u);
						fragment_unnamed_1120 = asfloat(1065353216u);
					}
					fragment_unnamed_1115 = fragment_unnamed_1116;
					fragment_unnamed_1117 = fragment_unnamed_1118;
					fragment_unnamed_1119 = fragment_unnamed_1120;
				}
				else
				{
					fragment_unnamed_1115 = asfloat(1065353216u);
					fragment_unnamed_1117 = asfloat(1065353216u);
					fragment_unnamed_1119 = asfloat(1065353216u);
				}
				float fragment_unnamed_1142 = asfloat((asuint(fragment_uniform_buffer_0[127u]).w != 0u) ? T5.Load((fragment_unnamed_288 * asuint(fragment_uniform_buffer_0[128u]).x) + fragment_unnamed_286).x : asuint(fragment_uniform_buffer_0[126u]).w);
				uint4 fragment_unnamed_1145 = asuint(fragment_uniform_buffer_0[127u]);
				uint fragment_unnamed_1146 = fragment_unnamed_1145.z;
				uint fragment_unnamed_1151 = 1u << (fragment_unnamed_1146 & 31u);
				uint fragment_unnamed_1184 = uint(int(min(float(int(fragment_unnamed_1151 + 4294967295u)), max(log2(mad(max((1.0f / gl_FragCoord.w) + ((-0.0f) - fragment_uniform_buffer_0[127u].x), 0.0f) / (((-0.0f) - fragment_uniform_buffer_0[127u].x) + fragment_uniform_buffer_0[127u].y), exp2(float(int(fragment_unnamed_1151)) * log2(abs(fragment_unnamed_1142))) + (-1.0f), 1.0f)) / log2(fragment_unnamed_1142), 0.0f))));
				uint4 fragment_unnamed_1197 = T4.Load((((fragment_unnamed_1184 * asuint(fragment_uniform_buffer_0[128u]).y) + fragment_unnamed_288) * asuint(fragment_uniform_buffer_0[128u]).x) + fragment_unnamed_286);
				uint fragment_unnamed_1198 = fragment_unnamed_1197.x;
				uint fragment_unnamed_1199 = fragment_unnamed_1198 & 67108863u;
				uint fragment_unnamed_1201 = fragment_unnamed_1198 >> 26u;
				float fragment_unnamed_1214 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_uniform_buffer_0[83u].xyz));
				float fragment_unnamed_1217 = fragment_unnamed_875 * fragment_unnamed_875;
				float fragment_unnamed_1225 = exp2(ceil(max((-0.0f) - fragment_uniform_buffer_0[123u].z, 0.0f)));
				float fragment_unnamed_1227 = fragment_unnamed_875 * (fragment_unnamed_1217 * fragment_unnamed_1217);
				float fragment_unnamed_1228 = asfloat(1065353216u);
				float fragment_unnamed_1229 = asfloat(1065353216u);
				float fragment_unnamed_1230 = asfloat(1065353216u);
				float fragment_unnamed_1231 = asfloat(1065353216u);
				float fragment_unnamed_1232 = asfloat(0u);
				float fragment_unnamed_1233 = asfloat(0u);
				float fragment_unnamed_1234 = asfloat(0u);
				float fragment_unnamed_1235 = asfloat(0u);
				float fragment_unnamed_1236 = asfloat(0u);
				float fragment_unnamed_1237 = asfloat(0u);
				float fragment_unnamed_1238 = asfloat(0u);
				float fragment_unnamed_1258;
				float fragment_unnamed_1260;
				float fragment_unnamed_1262;
				float fragment_unnamed_1264;
				float fragment_unnamed_1266;
				float fragment_unnamed_1268;
				uint fragment_unnamed_1270;
				float fragment_unnamed_1272;
				for (;;)
				{
					fragment_unnamed_1258 = fragment_unnamed_1237;
					fragment_unnamed_1260 = fragment_unnamed_1232;
					fragment_unnamed_1262 = fragment_unnamed_1233;
					fragment_unnamed_1264 = fragment_unnamed_1234;
					fragment_unnamed_1266 = fragment_unnamed_1235;
					fragment_unnamed_1268 = fragment_unnamed_1236;
					fragment_unnamed_1270 = 0u;
					fragment_unnamed_1272 = fragment_unnamed_1238;
					float fragment_unnamed_1259;
					float fragment_unnamed_1261;
					float fragment_unnamed_1263;
					float fragment_unnamed_1265;
					float fragment_unnamed_1267;
					float fragment_unnamed_1269;
					uint fragment_unnamed_1271;
					float fragment_unnamed_1273;
					bool ladder_phi_21;
					for (;;)
					{
						if (asuint(fragment_unnamed_1258) >= fragment_unnamed_1201)
						{
							ladder_phi_21 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_1416 = asuint(fragment_unnamed_1258);
							uint4 fragment_unnamed_1418 = T3.Load(fragment_unnamed_1199 + fragment_unnamed_1416);
							uint fragment_unnamed_1419 = fragment_unnamed_1418.x;
							if (fragment_unnamed_1419 == 4294967295u)
							{
								ladder_phi_21 = false;
								break;
							}
							uint fragment_unnamed_1607 = fragment_unnamed_1419 * 56u;
							uint4 fragment_unnamed_1620 = uint4(T7.Load(fragment_unnamed_1607).x, T7.Load(fragment_unnamed_1607 + 1u).x, T7.Load(fragment_unnamed_1607 + 2u).x, T7.Load(fragment_unnamed_1607 + 3u).x);
							fragment_unnamed_1259 = asfloat(asuint(fragment_unnamed_1258) + 1u);
							if (!((fragment_unnamed_475 & fragment_unnamed_1620.w) != 0u))
							{
								fragment_unnamed_1261 = fragment_unnamed_1260;
								fragment_unnamed_1263 = fragment_unnamed_1262;
								fragment_unnamed_1265 = fragment_unnamed_1264;
								fragment_unnamed_1267 = fragment_unnamed_1266;
								fragment_unnamed_1269 = fragment_unnamed_1268;
								fragment_unnamed_1271 = fragment_unnamed_1270;
								fragment_unnamed_1273 = fragment_unnamed_1272;
								fragment_unnamed_1258 = fragment_unnamed_1259;
								fragment_unnamed_1260 = fragment_unnamed_1261;
								fragment_unnamed_1262 = fragment_unnamed_1263;
								fragment_unnamed_1264 = fragment_unnamed_1265;
								fragment_unnamed_1266 = fragment_unnamed_1267;
								fragment_unnamed_1268 = fragment_unnamed_1269;
								fragment_unnamed_1270 = fragment_unnamed_1271;
								fragment_unnamed_1272 = fragment_unnamed_1273;
								continue;
							}
							uint fragment_unnamed_1901 = (fragment_unnamed_1419 * 56u) + 6u;
							uint4 fragment_unnamed_1913 = uint4(T7.Load(fragment_unnamed_1901).x, T7.Load(fragment_unnamed_1901 + 1u).x, T7.Load(fragment_unnamed_1901 + 2u).x, T7.Load(fragment_unnamed_1901 + 3u).x);
							uint fragment_unnamed_1921 = (fragment_unnamed_1419 * 56u) + 10u;
							uint4 fragment_unnamed_1933 = uint4(T7.Load(fragment_unnamed_1921).x, T7.Load(fragment_unnamed_1921 + 1u).x, T7.Load(fragment_unnamed_1921 + 2u).x, T7.Load(fragment_unnamed_1921 + 3u).x);
							float fragment_unnamed_1936 = asfloat(fragment_unnamed_1933.y);
							uint fragment_unnamed_1937 = fragment_unnamed_1933.z;
							float fragment_unnamed_1948 = ((-0.0f) - asfloat(fragment_unnamed_1620.x)) + fragment_input_5.x;
							float fragment_unnamed_1949 = ((-0.0f) - asfloat(fragment_unnamed_1620.y)) + fragment_input_5.y;
							float fragment_unnamed_1950 = ((-0.0f) - asfloat(fragment_unnamed_1620.z)) + fragment_input_5.z;
							bool fragment_unnamed_1951 = fragment_unnamed_1937 == 4u;
							float fragment_unnamed_1952 = asfloat(fragment_unnamed_1913.z);
							float fragment_unnamed_1953 = asfloat(fragment_unnamed_1913.w);
							float fragment_unnamed_1954 = asfloat(fragment_unnamed_1933.x);
							float fragment_unnamed_1961 = dot(float3((-0.0f) - fragment_unnamed_1948, (-0.0f) - fragment_unnamed_1949, (-0.0f) - fragment_unnamed_1950), float3((-0.0f) - fragment_unnamed_1948, (-0.0f) - fragment_unnamed_1949, (-0.0f) - fragment_unnamed_1950));
							float fragment_unnamed_1964 = rsqrt(fragment_unnamed_1961);
							float fragment_unnamed_1974 = fragment_unnamed_1951 ? ((-0.0f) - fragment_unnamed_1952) : (((-0.0f) - fragment_unnamed_1948) * fragment_unnamed_1964);
							float fragment_unnamed_1975 = fragment_unnamed_1951 ? ((-0.0f) - fragment_unnamed_1953) : (((-0.0f) - fragment_unnamed_1949) * fragment_unnamed_1964);
							float fragment_unnamed_1976 = fragment_unnamed_1951 ? ((-0.0f) - fragment_unnamed_1954) : (((-0.0f) - fragment_unnamed_1950) * fragment_unnamed_1964);
							float fragment_unnamed_1979 = dot(float3(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469), float3(fragment_unnamed_1974, fragment_unnamed_1975, fragment_unnamed_1976));
							float fragment_unnamed_2718;
							float fragment_unnamed_2720;
							float fragment_unnamed_2722;
							float fragment_unnamed_2724;
							float fragment_unnamed_2726;
							float fragment_unnamed_2728;
							if ((((0.0f < asfloat(T7.Load((fragment_unnamed_1419 * 56u) + 4u).x)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1979) ? 4294967295u : 0u)) != 0u)
							{
								uint fragment_unnamed_2363 = (fragment_unnamed_1419 * 56u) + 14u;
								uint4 fragment_unnamed_2375 = uint4(T7.Load(fragment_unnamed_2363).x, T7.Load(fragment_unnamed_2363 + 1u).x, T7.Load(fragment_unnamed_2363 + 2u).x, T7.Load(fragment_unnamed_2363 + 3u).x);
								float fragment_unnamed_2379 = asfloat(fragment_unnamed_2375.z);
								float fragment_unnamed_2381 = asfloat(fragment_unnamed_2375.w);
								uint fragment_unnamed_2383 = (fragment_unnamed_1419 * 56u) + 18u;
								uint4 fragment_unnamed_2395 = uint4(T7.Load(fragment_unnamed_2383).x, T7.Load(fragment_unnamed_2383 + 1u).x, T7.Load(fragment_unnamed_2383 + 2u).x, T7.Load(fragment_unnamed_2383 + 3u).x);
								uint fragment_unnamed_2401 = fragment_unnamed_2395.y;
								uint fragment_unnamed_2403 = (fragment_unnamed_1419 * 56u) + 22u;
								uint4 fragment_unnamed_2415 = uint4(T7.Load(fragment_unnamed_2403).x, T7.Load(fragment_unnamed_2403 + 1u).x, T7.Load(fragment_unnamed_2403 + 2u).x, T7.Load(fragment_unnamed_2403 + 3u).x);
								uint fragment_unnamed_2418 = fragment_unnamed_2415.z;
								uint fragment_unnamed_2420 = fragment_unnamed_2415.w;
								uint fragment_unnamed_2424 = (fragment_unnamed_1419 * 56u) + 26u;
								uint4 fragment_unnamed_2436 = uint4(T7.Load(fragment_unnamed_2424).x, T7.Load(fragment_unnamed_2424 + 1u).x, T7.Load(fragment_unnamed_2424 + 2u).x, T7.Load(fragment_unnamed_2424 + 3u).x);
								float fragment_unnamed_2440 = asfloat(fragment_unnamed_2436.z);
								uint fragment_unnamed_2441 = fragment_unnamed_2436.x;
								float fragment_unnamed_2444 = asfloat(fragment_unnamed_2436.w);
								uint fragment_unnamed_2447 = (fragment_unnamed_1419 * 56u) + 30u;
								uint4 fragment_unnamed_2459 = uint4(T7.Load(fragment_unnamed_2447).x, T7.Load(fragment_unnamed_2447 + 1u).x, T7.Load(fragment_unnamed_2447 + 2u).x, T7.Load(fragment_unnamed_2447 + 3u).x);
								float fragment_unnamed_2461 = asfloat(fragment_unnamed_2459.x);
								float fragment_unnamed_2463 = asfloat(fragment_unnamed_2459.y);
								uint fragment_unnamed_2465 = fragment_unnamed_2459.w;
								uint fragment_unnamed_2468 = (fragment_unnamed_1419 * 56u) + 34u;
								uint2 fragment_unnamed_2474 = uint2(T7.Load(fragment_unnamed_2468).x, T7.Load(fragment_unnamed_2468 + 1u).x);
								float fragment_unnamed_2476 = asfloat(fragment_unnamed_2474.x);
								float fragment_unnamed_2478 = asfloat(fragment_unnamed_2474.y);
								float fragment_unnamed_2484 = dot(float3(fragment_unnamed_1948, fragment_unnamed_1949, fragment_unnamed_1950), float3(fragment_unnamed_1952, fragment_unnamed_1953, fragment_unnamed_1954));
								uint fragment_unnamed_2496 = fragment_unnamed_1951 ? asuint(fragment_unnamed_2484) : asuint(fragment_unnamed_1964 * fragment_unnamed_1961);
								float fragment_unnamed_2497 = asfloat(fragment_unnamed_2496);
								float fragment_unnamed_2506 = asfloat(fragment_unnamed_2415.y) * asfloat(fragment_unnamed_1951 ? asuint(fragment_unnamed_2484 * fragment_unnamed_2484) : asuint(fragment_unnamed_1961));
								float fragment_unnamed_2513 = clamp(mad((1.0f / fragment_unnamed_2497) * fragment_unnamed_2484, asfloat(fragment_unnamed_1913.x), asfloat(fragment_unnamed_1913.y)), 0.0f, 1.0f) * (min(asfloat(fragment_unnamed_1951 ? 1065353216u : asuint(rsqrt(asfloat(T7.Load((fragment_unnamed_1419 * 56u) + 44u).x) + fragment_unnamed_1961))), 100.0f) * clamp(mad((-0.0f) - fragment_unnamed_2506, fragment_unnamed_2506, asfloat(fragment_unnamed_2436.y)), 0.0f, 1.0f));
								float fragment_unnamed_2520 = dot(float3(fragment_unnamed_1974, fragment_unnamed_1975, fragment_unnamed_1976), float3(fragment_uniform_buffer_0[83u].xyz));
								float fragment_unnamed_2524 = max(abs(fragment_unnamed_2520), 0.001000000047497451305389404296875f);
								float fragment_unnamed_2526 = 1.0f / fragment_unnamed_2524;
								float fragment_unnamed_2528 = min(fragment_unnamed_1214, mad(fragment_unnamed_2497, fragment_unnamed_2520, fragment_unnamed_1214));
								float fragment_unnamed_2542 = min(fragment_unnamed_2497, max(fragment_unnamed_2526 * (((-0.0f) - fragment_unnamed_2528) + fragment_uniform_buffer_0[89u].y), 0.0f));
								float fragment_unnamed_2575 = (fragment_unnamed_2513 * fragment_unnamed_2513) * exp2((mad((((-0.0f) - exp2(((fragment_unnamed_2524 * ((-0.0f) - (((-0.0f) - fragment_unnamed_2542) + fragment_unnamed_2497))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_2528 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_2526 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_2542) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
								float fragment_unnamed_3402;
								float fragment_unnamed_3404;
								float fragment_unnamed_3406;
								float fragment_unnamed_3408;
								if (fragment_unnamed_2395.x != 0u)
								{
									float fragment_unnamed_2708 = dot(float3(fragment_unnamed_1948, fragment_unnamed_1949, fragment_unnamed_1950), float3(asfloat(fragment_unnamed_1933.w), asfloat(fragment_unnamed_2375.x), asfloat(fragment_unnamed_2375.y)));
									float fragment_unnamed_2712 = dot(float3(fragment_unnamed_1948, fragment_unnamed_1949, fragment_unnamed_1950), float3(asfloat(fragment_unnamed_2395.z), asfloat(fragment_unnamed_2395.w), asfloat(fragment_unnamed_2415.x)));
									float fragment_unnamed_3639;
									float fragment_unnamed_3640;
									float fragment_unnamed_3641;
									float fragment_unnamed_3642;
									if (fragment_unnamed_1937 == 1u)
									{
										float fragment_unnamed_3259 = 1.0f / max(dot(float3(abs(fragment_unnamed_2708), abs(fragment_unnamed_2712), abs(fragment_unnamed_2484)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
										float fragment_unnamed_3264 = clamp((-0.0f) - (fragment_unnamed_3259 * fragment_unnamed_2484), 0.0f, 1.0f);
										float fragment_unnamed_3267 = (-0.0f) - fragment_unnamed_3264;
										float fragment_unnamed_3281 = 1.0f / (fragment_unnamed_2440 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3282 = 1.0f / (fragment_unnamed_2444 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3294 = fragment_unnamed_2440 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3295 = fragment_unnamed_2444 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3298 = fragment_unnamed_1225 / (fragment_unnamed_3294 + fragment_unnamed_3294);
										float fragment_unnamed_3299 = fragment_unnamed_1225 / (fragment_unnamed_3295 + fragment_unnamed_3295);
										float4 fragment_unnamed_3313 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_3298) + 1.0f, max(fragment_unnamed_3298, mad(clamp(mad(mad(fragment_unnamed_2708, fragment_unnamed_3259, ((fragment_unnamed_3259 * fragment_unnamed_2708) >= 0.0f) ? fragment_unnamed_3264 : fragment_unnamed_3267), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_2440 * fragment_unnamed_3281, mad((-0.0f) - fragment_unnamed_3281, fragment_unnamed_2440, 1.0f) * 0.5f))), fragment_unnamed_2440, fragment_unnamed_2461), mad(min(((-0.0f) - fragment_unnamed_3299) + 1.0f, max(fragment_unnamed_3299, mad(clamp(mad(mad(fragment_unnamed_2712, fragment_unnamed_3259, ((fragment_unnamed_3259 * fragment_unnamed_2712) >= 0.0f) ? fragment_unnamed_3264 : fragment_unnamed_3267), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_2444 * fragment_unnamed_3282, mad((-0.0f) - fragment_unnamed_3282, fragment_unnamed_2444, 1.0f) * 0.5f))), fragment_unnamed_2444, fragment_unnamed_2463)), 0.0f);
										fragment_unnamed_3639 = fragment_unnamed_3313.x;
										fragment_unnamed_3640 = fragment_unnamed_3313.y;
										fragment_unnamed_3641 = fragment_unnamed_3313.z;
										fragment_unnamed_3642 = asfloat(1065353216u);
									}
									else
									{
										bool fragment_unnamed_3325 = fragment_unnamed_1937 != 4u;
										float fragment_unnamed_3331 = asfloat(fragment_unnamed_3325 ? asuint(fragment_unnamed_2484) : 1065353216u);
										float fragment_unnamed_3332 = fragment_unnamed_2708 / fragment_unnamed_3331;
										float fragment_unnamed_3333 = fragment_unnamed_2712 / fragment_unnamed_3331;
										uint fragment_unnamed_3345 = (asfloat(T7.Load((fragment_unnamed_1419 * 56u) + 55u).x) >= max(mad((-0.0f) - fragment_unnamed_2381, 0.5f, abs(mad((-0.0f) - fragment_unnamed_2381, 0.5f, fragment_unnamed_2484))) + 1.0f, max(abs(fragment_unnamed_3333), abs(fragment_unnamed_3332)))) ? 4294967295u : 0u;
										float fragment_unnamed_3363 = 1.0f / (fragment_unnamed_2440 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3364 = 1.0f / (fragment_unnamed_2444 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3376 = fragment_unnamed_2440 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3377 = fragment_unnamed_2444 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3380 = fragment_unnamed_1225 / (fragment_unnamed_3376 + fragment_unnamed_3376);
										float fragment_unnamed_3381 = fragment_unnamed_1225 / (fragment_unnamed_3377 + fragment_unnamed_3377);
										float4 fragment_unnamed_3395 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_3380) + 1.0f, max(fragment_unnamed_3380, mad(mad(fragment_unnamed_3332, 0.5f, 0.5f), fragment_unnamed_2440 * fragment_unnamed_3363, mad((-0.0f) - fragment_unnamed_3363, fragment_unnamed_2440, 1.0f) * 0.5f))), fragment_unnamed_2440, fragment_unnamed_2461), mad(min(((-0.0f) - fragment_unnamed_3381) + 1.0f, max(fragment_unnamed_3381, mad(mad(fragment_unnamed_3333, 0.5f, 0.5f), fragment_unnamed_2444 * fragment_unnamed_3364, mad((-0.0f) - fragment_unnamed_3364, fragment_unnamed_2444, 1.0f) * 0.5f))), fragment_unnamed_2444, fragment_unnamed_2463)), 0.0f);
										fragment_unnamed_3639 = fragment_unnamed_3395.x;
										fragment_unnamed_3640 = fragment_unnamed_3395.y;
										fragment_unnamed_3641 = fragment_unnamed_3395.z;
										fragment_unnamed_3642 = asfloat(((((fragment_unnamed_3325 ? 4294967295u : 0u) & ((fragment_unnamed_1937 != 3u) ? 4294967295u : 0u)) != 0u) ? (fragment_unnamed_3345 & (((fragment_unnamed_1936 * fragment_unnamed_1936) >= dot(float2(fragment_unnamed_3332, fragment_unnamed_3333), float2(fragment_unnamed_3332, fragment_unnamed_3333))) ? 4294967295u : 0u)) : fragment_unnamed_3345) & 1065353216u);
									}
									fragment_unnamed_3402 = fragment_unnamed_3642 * fragment_unnamed_2575;
									fragment_unnamed_3404 = fragment_unnamed_3639 * asfloat(fragment_unnamed_2418);
									fragment_unnamed_3406 = fragment_unnamed_3640 * asfloat(fragment_unnamed_2420);
									fragment_unnamed_3408 = fragment_unnamed_3641 * asfloat(fragment_unnamed_2441);
								}
								else
								{
									fragment_unnamed_3402 = fragment_unnamed_2575;
									fragment_unnamed_3404 = asfloat(fragment_unnamed_2418);
									fragment_unnamed_3406 = asfloat(fragment_unnamed_2420);
									fragment_unnamed_3408 = asfloat(fragment_unnamed_2441);
								}
								float fragment_unnamed_4415;
								if ((((0.0f < fragment_unnamed_2478) ? 4294967295u : 0u) & ((int(fragment_unnamed_2401) >= int(0u)) ? 4294967295u : 0u)) != 0u)
								{
									bool fragment_unnamed_3645 = fragment_unnamed_1937 != 4u;
									uint fragment_unnamed_3646 = fragment_unnamed_3645 ? 4294967295u : 0u;
									float fragment_unnamed_3652 = asfloat((dot(float3(fragment_unnamed_253, fragment_unnamed_254, fragment_unnamed_255), float3(fragment_unnamed_1974, fragment_unnamed_1975, fragment_unnamed_1976)) >= 0.0f) ? 1065353216u : 3212836864u);
									float fragment_unnamed_3653 = fragment_unnamed_253 * fragment_unnamed_3652;
									float fragment_unnamed_3654 = fragment_unnamed_254 * fragment_unnamed_3652;
									float fragment_unnamed_3655 = fragment_unnamed_255 * fragment_unnamed_3652;
									uint fragment_unnamed_3657 = (fragment_unnamed_2401 * 60u) + 8u;
									uint4 fragment_unnamed_3669 = uint4(T32.Load(fragment_unnamed_3657).x, T32.Load(fragment_unnamed_3657 + 1u).x, T32.Load(fragment_unnamed_3657 + 2u).x, T32.Load(fragment_unnamed_3657 + 3u).x);
									uint fragment_unnamed_3671 = fragment_unnamed_3669.y;
									float fragment_unnamed_3672 = asfloat(fragment_unnamed_3671);
									uint fragment_unnamed_3673 = fragment_unnamed_3669.z;
									float fragment_unnamed_3674 = asfloat(fragment_unnamed_3673);
									uint fragment_unnamed_3675 = fragment_unnamed_3669.w;
									float fragment_unnamed_3676 = asfloat(fragment_unnamed_3675);
									uint fragment_unnamed_3678 = (fragment_unnamed_2401 * 60u) + 12u;
									uint4 fragment_unnamed_3690 = uint4(T32.Load(fragment_unnamed_3678).x, T32.Load(fragment_unnamed_3678 + 1u).x, T32.Load(fragment_unnamed_3678 + 2u).x, T32.Load(fragment_unnamed_3678 + 3u).x);
									float fragment_unnamed_3692 = asfloat(fragment_unnamed_3690.x);
									float fragment_unnamed_3694 = asfloat(fragment_unnamed_3690.y);
									float fragment_unnamed_3696 = asfloat(fragment_unnamed_3690.z);
									float fragment_unnamed_3698 = asfloat(fragment_unnamed_3690.w);
									uint fragment_unnamed_3700 = (fragment_unnamed_2401 * 60u) + 16u;
									uint4 fragment_unnamed_3712 = uint4(T32.Load(fragment_unnamed_3700).x, T32.Load(fragment_unnamed_3700 + 1u).x, T32.Load(fragment_unnamed_3700 + 2u).x, T32.Load(fragment_unnamed_3700 + 3u).x);
									float fragment_unnamed_3718 = asfloat(fragment_unnamed_3712.z);
									float fragment_unnamed_3720 = asfloat(fragment_unnamed_3712.w);
									uint fragment_unnamed_3722 = (fragment_unnamed_2401 * 60u) + 24u;
									uint2 fragment_unnamed_3728 = uint2(T32.Load(fragment_unnamed_3722).x, T32.Load(fragment_unnamed_3722 + 1u).x);
									float fragment_unnamed_3730 = asfloat(fragment_unnamed_3728.x);
									float fragment_unnamed_3732 = asfloat(fragment_unnamed_3728.y);
									uint fragment_unnamed_3734 = (fragment_unnamed_2401 * 60u) + 40u;
									uint4 fragment_unnamed_3746 = uint4(T32.Load(fragment_unnamed_3734).x, T32.Load(fragment_unnamed_3734 + 1u).x, T32.Load(fragment_unnamed_3734 + 2u).x, T32.Load(fragment_unnamed_3734 + 3u).x);
									float fragment_unnamed_3748 = asfloat(fragment_unnamed_3746.x);
									float fragment_unnamed_3750 = asfloat(fragment_unnamed_3746.y);
									float fragment_unnamed_3752 = asfloat(fragment_unnamed_3746.z);
									float fragment_unnamed_3754 = asfloat(fragment_unnamed_3746.w);
									float fragment_unnamed_4821;
									float fragment_unnamed_4822;
									float fragment_unnamed_4823;
									float fragment_unnamed_4824;
									float fragment_unnamed_4825;
									float fragment_unnamed_4826;
									float fragment_unnamed_4827;
									float fragment_unnamed_4828;
									float fragment_unnamed_4829;
									float fragment_unnamed_4830;
									float fragment_unnamed_4831;
									if (fragment_unnamed_1937 == 1u)
									{
										float fragment_unnamed_4279 = abs(fragment_unnamed_1976);
										float fragment_unnamed_4281 = abs(fragment_unnamed_1974);
										uint fragment_unnamed_4308 = uint(float(int(fragment_unnamed_2401)) + asfloat(((((fragment_unnamed_4279 >= abs(fragment_unnamed_1975)) ? 4294967295u : 0u) & ((fragment_unnamed_4279 >= fragment_unnamed_4281) ? 4294967295u : 0u)) != 0u) ? ((((-0.0f) - fragment_unnamed_1976) < 0.0f) ? 1084227584u : 1082130432u) : ((abs(fragment_unnamed_1975) >= fragment_unnamed_4281) ? ((((-0.0f) - fragment_unnamed_1975) < 0.0f) ? 1077936128u : 1073741824u) : (((((-0.0f) - fragment_unnamed_1974) < 0.0f) ? 4294967295u : 0u) & 1065353216u))));
										uint fragment_unnamed_4309 = fragment_unnamed_4308 * 60u;
										uint3 fragment_unnamed_4318 = uint3(T32.Load(fragment_unnamed_4309).x, T32.Load(fragment_unnamed_4309 + 1u).x, T32.Load(fragment_unnamed_4309 + 2u).x);
										uint fragment_unnamed_4326 = (fragment_unnamed_4308 * 60u) + 3u;
										uint3 fragment_unnamed_4335 = uint3(T32.Load(fragment_unnamed_4326).x, T32.Load(fragment_unnamed_4326 + 1u).x, T32.Load(fragment_unnamed_4326 + 2u).x);
										uint fragment_unnamed_4343 = (fragment_unnamed_4308 * 60u) + 6u;
										uint3 fragment_unnamed_4352 = uint3(T32.Load(fragment_unnamed_4343).x, T32.Load(fragment_unnamed_4343 + 1u).x, T32.Load(fragment_unnamed_4343 + 2u).x);
										uint fragment_unnamed_4360 = (fragment_unnamed_4308 * 60u) + 16u;
										uint2 fragment_unnamed_4366 = uint2(T32.Load(fragment_unnamed_4360).x, T32.Load(fragment_unnamed_4360 + 1u).x);
										fragment_unnamed_4821 = asfloat(fragment_unnamed_4366.x);
										fragment_unnamed_4822 = asfloat(fragment_unnamed_4366.y);
										fragment_unnamed_4823 = asfloat(fragment_unnamed_4318.x);
										fragment_unnamed_4824 = asfloat(fragment_unnamed_4318.y);
										fragment_unnamed_4825 = asfloat(fragment_unnamed_4318.z);
										fragment_unnamed_4826 = asfloat(fragment_unnamed_4335.x);
										fragment_unnamed_4827 = asfloat(fragment_unnamed_4335.y);
										fragment_unnamed_4828 = asfloat(fragment_unnamed_4335.z);
										fragment_unnamed_4829 = asfloat(fragment_unnamed_4352.x);
										fragment_unnamed_4830 = asfloat(fragment_unnamed_4352.y);
										fragment_unnamed_4831 = asfloat(fragment_unnamed_4352.z);
									}
									else
									{
										uint fragment_unnamed_4371 = fragment_unnamed_2401 * 60u;
										uint4 fragment_unnamed_4383 = uint4(T32.Load(fragment_unnamed_4371).x, T32.Load(fragment_unnamed_4371 + 1u).x, T32.Load(fragment_unnamed_4371 + 2u).x, T32.Load(fragment_unnamed_4371 + 3u).x);
										uint fragment_unnamed_4390 = (fragment_unnamed_2401 * 60u) + 4u;
										uint4 fragment_unnamed_4402 = uint4(T32.Load(fragment_unnamed_4390).x, T32.Load(fragment_unnamed_4390 + 1u).x, T32.Load(fragment_unnamed_4390 + 2u).x, T32.Load(fragment_unnamed_4390 + 3u).x);
										fragment_unnamed_4821 = asfloat(fragment_unnamed_3712.x);
										fragment_unnamed_4822 = asfloat(fragment_unnamed_3712.y);
										fragment_unnamed_4823 = asfloat(fragment_unnamed_4383.x);
										fragment_unnamed_4824 = asfloat(fragment_unnamed_4383.y);
										fragment_unnamed_4825 = asfloat(fragment_unnamed_4383.z);
										fragment_unnamed_4826 = asfloat(fragment_unnamed_4383.w);
										fragment_unnamed_4827 = asfloat(fragment_unnamed_4402.x);
										fragment_unnamed_4828 = asfloat(fragment_unnamed_4402.y);
										fragment_unnamed_4829 = asfloat(fragment_unnamed_4402.z);
										fragment_unnamed_4830 = asfloat(fragment_unnamed_4402.w);
										fragment_unnamed_4831 = asfloat(fragment_unnamed_3669.x);
									}
									float fragment_unnamed_7654;
									if (0.0f < fragment_unnamed_3754)
									{
										bool fragment_unnamed_5479 = 0.0f != fragment_unnamed_3754;
										uint4 fragment_unnamed_5483 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_5489 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_5493 = asfloat(fragment_unnamed_5479 ? fragment_unnamed_5483.z : fragment_unnamed_5489.z);
										float fragment_unnamed_5495 = asfloat(fragment_unnamed_5479 ? fragment_unnamed_5483.w : fragment_unnamed_5489.w);
										float fragment_unnamed_5497 = asfloat(fragment_unnamed_3645 ? fragment_unnamed_2496 : 1065353216u);
										float fragment_unnamed_5513 = mad(fragment_unnamed_3718 * (fragment_unnamed_3653 * fragment_unnamed_3720), fragment_unnamed_5497, fragment_unnamed_3748 + fragment_input_5.x);
										float fragment_unnamed_5514 = mad(fragment_unnamed_3718 * (fragment_unnamed_3654 * fragment_unnamed_3720), fragment_unnamed_5497, fragment_unnamed_3750 + fragment_input_5.y);
										float fragment_unnamed_5515 = mad(fragment_unnamed_3718 * (fragment_unnamed_3655 * fragment_unnamed_3720), fragment_unnamed_5497, fragment_unnamed_3752 + fragment_input_5.z);
										float fragment_unnamed_5519 = ((-0.0f) - fragment_unnamed_3672) + fragment_unnamed_5513;
										float fragment_unnamed_5520 = ((-0.0f) - fragment_unnamed_3674) + fragment_unnamed_5514;
										float fragment_unnamed_5521 = ((-0.0f) - fragment_unnamed_3676) + fragment_unnamed_5515;
										float fragment_unnamed_5554 = asfloat(fragment_unnamed_3645 ? asuint(dot(float3(fragment_unnamed_4829, fragment_unnamed_4830, fragment_unnamed_4831), float3(fragment_unnamed_5519, fragment_unnamed_5520, fragment_unnamed_5521))) : asuint(dot(float4(fragment_unnamed_4829, fragment_unnamed_4830, fragment_unnamed_4831, asfloat(fragment_unnamed_3675)), float4(fragment_unnamed_5513, fragment_unnamed_5514, fragment_unnamed_5515, fragment_unnamed_1228))));
										float fragment_unnamed_5559 = asfloat(fragment_unnamed_3645 ? asuint(dot(float3(fragment_unnamed_4823, fragment_unnamed_4824, fragment_unnamed_4825), float3(fragment_unnamed_5519, fragment_unnamed_5520, fragment_unnamed_5521))) : asuint(dot(float4(fragment_unnamed_4823, fragment_unnamed_4824, fragment_unnamed_4825, asfloat(fragment_unnamed_3671)), float4(fragment_unnamed_5513, fragment_unnamed_5514, fragment_unnamed_5515, fragment_unnamed_1228)))) * fragment_unnamed_3692;
										float fragment_unnamed_5560 = asfloat(fragment_unnamed_3645 ? asuint(dot(float3(fragment_unnamed_4826, fragment_unnamed_4827, fragment_unnamed_4828), float3(fragment_unnamed_5519, fragment_unnamed_5520, fragment_unnamed_5521))) : asuint(dot(float4(fragment_unnamed_4826, fragment_unnamed_4827, fragment_unnamed_4828, asfloat(fragment_unnamed_3673)), float4(fragment_unnamed_5513, fragment_unnamed_5514, fragment_unnamed_5515, fragment_unnamed_1228)))) * fragment_unnamed_3694;
										float fragment_unnamed_5561 = dot(float2(fragment_unnamed_3696, fragment_unnamed_3698), float2(fragment_unnamed_5554, fragment_unnamed_1229));
										float fragment_unnamed_5564 = dot(float2(asfloat(fragment_unnamed_3645 ? 3212836864u : 0u), asfloat(fragment_unnamed_3645 ? 0u : 1065353216u)), float2(fragment_unnamed_5554, fragment_unnamed_1229));
										bool fragment_unnamed_5573 = (fragment_unnamed_3646 & ((fragment_unnamed_5564 != 0.0f) ? 4294967295u : 0u)) != 0u;
										float fragment_unnamed_5592 = mad(fragment_unnamed_3730 * clamp(mad(asfloat(fragment_unnamed_5573 ? asuint(fragment_unnamed_5559 / fragment_unnamed_5564) : asuint(fragment_unnamed_5559)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5493, fragment_unnamed_4821);
										float fragment_unnamed_5593 = mad(fragment_unnamed_3732 * clamp(mad(asfloat(fragment_unnamed_5573 ? asuint(fragment_unnamed_5560 / fragment_unnamed_5564) : asuint(fragment_unnamed_5560)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5495, fragment_unnamed_4822);
										uint4 fragment_unnamed_5613 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_5620 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_5626 = asfloat(fragment_unnamed_5479 ? fragment_unnamed_5613.z : fragment_unnamed_5620.z);
										float fragment_unnamed_5628 = asfloat(fragment_unnamed_5479 ? fragment_unnamed_5613.w : fragment_unnamed_5620.w);
										float fragment_unnamed_5630 = asfloat(fragment_unnamed_5479 ? fragment_unnamed_5613.x : fragment_unnamed_5620.x);
										float fragment_unnamed_5632 = asfloat(fragment_unnamed_5479 ? fragment_unnamed_5613.y : fragment_unnamed_5620.y);
										float fragment_unnamed_5633 = asfloat(fragment_unnamed_5573 ? asuint(fragment_unnamed_5561 / fragment_unnamed_5564) : asuint(fragment_unnamed_5561)) + 1.52587890625e-05f;
										float fragment_unnamed_5636 = floor(mad(fragment_unnamed_5592, fragment_unnamed_5630, 0.5f));
										float fragment_unnamed_5637 = floor(mad(fragment_unnamed_5593, fragment_unnamed_5632, 0.5f));
										float fragment_unnamed_5640 = mad(fragment_unnamed_5592, fragment_unnamed_5630, (-0.0f) - fragment_unnamed_5636);
										float fragment_unnamed_5641 = mad(fragment_unnamed_5593, fragment_unnamed_5632, (-0.0f) - fragment_unnamed_5637);
										float fragment_unnamed_5642 = fragment_unnamed_5640 + 0.5f;
										float fragment_unnamed_5643 = fragment_unnamed_5640 + 1.0f;
										float fragment_unnamed_5644 = fragment_unnamed_5641 + 0.5f;
										float fragment_unnamed_5645 = fragment_unnamed_5641 + 1.0f;
										float fragment_unnamed_5650 = (fragment_unnamed_5642 * fragment_unnamed_5642) * 0.07999999821186065673828125f;
										float fragment_unnamed_5652 = (fragment_unnamed_5644 * fragment_unnamed_5644) * 0.07999999821186065673828125f;
										float fragment_unnamed_5659 = ((-0.0f) - fragment_unnamed_5640) + 1.0f;
										float fragment_unnamed_5660 = ((-0.0f) - fragment_unnamed_5641) + 1.0f;
										float fragment_unnamed_5661 = min(fragment_unnamed_5640, 0.0f);
										float fragment_unnamed_5662 = min(fragment_unnamed_5641, 0.0f);
										float fragment_unnamed_5667 = max(fragment_unnamed_5640, 0.0f);
										float fragment_unnamed_5668 = max(fragment_unnamed_5641, 0.0f);
										float fragment_unnamed_5680 = fragment_unnamed_5659 * 0.1599999964237213134765625f;
										float fragment_unnamed_5681 = fragment_unnamed_5660 * 0.1599999964237213134765625f;
										float fragment_unnamed_5682 = (mad((-0.0f) - fragment_unnamed_5661, fragment_unnamed_5661, fragment_unnamed_5659) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5684 = (mad((-0.0f) - fragment_unnamed_5667, fragment_unnamed_5667, fragment_unnamed_5643) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5685 = (mad((-0.0f) - fragment_unnamed_5668, fragment_unnamed_5668, fragment_unnamed_5645) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5689 = (fragment_unnamed_5643 * 0.1599999964237213134765625f) + fragment_unnamed_5650;
										float fragment_unnamed_5690 = (mad(fragment_unnamed_5642 * fragment_unnamed_5642, 0.5f, (-0.0f) - fragment_unnamed_5640) * 0.1599999964237213134765625f) + fragment_unnamed_5680;
										float fragment_unnamed_5691 = fragment_unnamed_5682 + fragment_unnamed_5684;
										float fragment_unnamed_5692 = (mad(fragment_unnamed_5644 * fragment_unnamed_5644, 0.5f, (-0.0f) - fragment_unnamed_5641) * 0.1599999964237213134765625f) + fragment_unnamed_5681;
										float fragment_unnamed_5693 = ((mad((-0.0f) - fragment_unnamed_5662, fragment_unnamed_5662, fragment_unnamed_5660) + 1.0f) * 0.1599999964237213134765625f) + fragment_unnamed_5685;
										float fragment_unnamed_5694 = (fragment_unnamed_5645 * 0.1599999964237213134765625f) + fragment_unnamed_5652;
										float fragment_unnamed_5707 = fragment_unnamed_5626 * ((fragment_unnamed_5684 / fragment_unnamed_5691) + (-0.5f));
										float fragment_unnamed_5708 = fragment_unnamed_5626 * ((fragment_unnamed_5680 / fragment_unnamed_5690) + (-2.5f));
										float fragment_unnamed_5709 = fragment_unnamed_5626 * ((fragment_unnamed_5650 / fragment_unnamed_5689) + 1.5f);
										float fragment_unnamed_5710 = fragment_unnamed_5628 * ((fragment_unnamed_5681 / fragment_unnamed_5692) + (-2.5f));
										float fragment_unnamed_5711 = fragment_unnamed_5628 * ((fragment_unnamed_5685 / fragment_unnamed_5693) + (-0.5f));
										float fragment_unnamed_5712 = fragment_unnamed_5628 * ((fragment_unnamed_5652 / fragment_unnamed_5694) + 1.5f);
										float fragment_unnamed_5731 = fragment_unnamed_5692 * fragment_unnamed_5690;
										float fragment_unnamed_5732 = fragment_unnamed_5692 * fragment_unnamed_5691;
										float fragment_unnamed_5733 = fragment_unnamed_5692 * fragment_unnamed_5689;
										float fragment_unnamed_5734 = fragment_unnamed_5693 * fragment_unnamed_5690;
										float fragment_unnamed_5735 = fragment_unnamed_5693 * (fragment_unnamed_5682 + fragment_unnamed_5684);
										float fragment_unnamed_5736 = fragment_unnamed_5693 * fragment_unnamed_5689;
										float fragment_unnamed_5737 = fragment_unnamed_5694 * fragment_unnamed_5690;
										float fragment_unnamed_5738 = fragment_unnamed_5694 * fragment_unnamed_5691;
										float4 fragment_unnamed_5743 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5636, fragment_unnamed_5626, fragment_unnamed_5708), mad(fragment_unnamed_5637, fragment_unnamed_5628, fragment_unnamed_5710)), fragment_unnamed_5633).xxxx;
										float fragment_unnamed_5744 = fragment_unnamed_5743.x;
										float4 fragment_unnamed_5747 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5636, fragment_unnamed_5626, fragment_unnamed_5707), mad(fragment_unnamed_5637, fragment_unnamed_5628, fragment_unnamed_5710)), fragment_unnamed_5633).xxxx;
										float fragment_unnamed_5748 = fragment_unnamed_5747.x;
										float4 fragment_unnamed_5751 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5636, fragment_unnamed_5626, fragment_unnamed_5709), mad(fragment_unnamed_5637, fragment_unnamed_5628, fragment_unnamed_5710)), fragment_unnamed_5633).xxxx;
										float fragment_unnamed_5752 = fragment_unnamed_5751.x;
										float4 fragment_unnamed_5755 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5636, fragment_unnamed_5626, fragment_unnamed_5708), mad(fragment_unnamed_5637, fragment_unnamed_5628, fragment_unnamed_5711)), fragment_unnamed_5633).xxxx;
										float fragment_unnamed_5756 = fragment_unnamed_5755.x;
										float fragment_unnamed_5758 = asfloat(0u);
										float fragment_unnamed_6181;
										fragment_unnamed_6181 = asfloat(0u);
										for (float fragment_unnamed_6179 = fragment_unnamed_5758; !(int(asuint(fragment_unnamed_6179)) >= int(1u)); fragment_unnamed_6179 = asfloat(asuint(fragment_unnamed_6179) + 1u), fragment_unnamed_6181 = mad(fragment_unnamed_5734, fragment_unnamed_5756, mad(fragment_unnamed_5733, fragment_unnamed_5752, mad(fragment_unnamed_5732, fragment_unnamed_5748, mad(fragment_unnamed_5731, fragment_unnamed_5744, fragment_unnamed_6181)))))
										{
										}
										float4 fragment_unnamed_6632 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5636, fragment_unnamed_5626, fragment_unnamed_5707), mad(fragment_unnamed_5637, fragment_unnamed_5628, fragment_unnamed_5711)), fragment_unnamed_5633).xxxx;
										float fragment_unnamed_6633 = fragment_unnamed_6632.x;
										float4 fragment_unnamed_6636 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5636, fragment_unnamed_5626, fragment_unnamed_5709), mad(fragment_unnamed_5637, fragment_unnamed_5628, fragment_unnamed_5711)), fragment_unnamed_5633).xxxx;
										float fragment_unnamed_6637 = fragment_unnamed_6636.x;
										float4 fragment_unnamed_6640 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5636, fragment_unnamed_5626, fragment_unnamed_5708), mad(fragment_unnamed_5637, fragment_unnamed_5628, fragment_unnamed_5712)), fragment_unnamed_5633).xxxx;
										float fragment_unnamed_6641 = fragment_unnamed_6640.x;
										float4 fragment_unnamed_6644 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5636, fragment_unnamed_5626, fragment_unnamed_5707), mad(fragment_unnamed_5637, fragment_unnamed_5628, fragment_unnamed_5712)), fragment_unnamed_5633).xxxx;
										float fragment_unnamed_6645 = fragment_unnamed_6644.x;
										float fragment_unnamed_6646 = asfloat(0u);
										float fragment_unnamed_7092;
										fragment_unnamed_7092 = fragment_unnamed_6181;
										float fragment_unnamed_7093;
										for (float fragment_unnamed_7094 = fragment_unnamed_6646; !(int(asuint(fragment_unnamed_7094)) >= int(1u)); fragment_unnamed_7093 = mad(fragment_unnamed_5738, fragment_unnamed_6645, mad(fragment_unnamed_5737, fragment_unnamed_6641, mad(fragment_unnamed_5736, fragment_unnamed_6637, mad(fragment_unnamed_5735, fragment_unnamed_6633, fragment_unnamed_7092)))), fragment_unnamed_7092 = fragment_unnamed_7093, fragment_unnamed_7094 = asfloat(asuint(fragment_unnamed_7094) + 1u))
										{
										}
										fragment_unnamed_7654 = asfloat((((((fragment_unnamed_5593 < (fragment_unnamed_5495 + fragment_unnamed_4822)) ? 4294967295u : 0u) | ((fragment_unnamed_5592 < (fragment_unnamed_5493 + fragment_unnamed_4821)) ? 4294967295u : 0u)) | (((mad(fragment_unnamed_3732 + (-0.5f), fragment_unnamed_5495, fragment_unnamed_4822) < fragment_unnamed_5593) ? 4294967295u : 0u) | ((mad(fragment_unnamed_3730 + (-0.5f), fragment_unnamed_5493, fragment_unnamed_4821) < fragment_unnamed_5592) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(mad(fragment_unnamed_5694 * fragment_unnamed_5689, _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5636, fragment_unnamed_5626, fragment_unnamed_5709), mad(fragment_unnamed_5637, fragment_unnamed_5628, fragment_unnamed_5712)), fragment_unnamed_5633).xxxx.x, fragment_unnamed_7092)));
									}
									else
									{
										bool fragment_unnamed_5759 = 0.0f != fragment_unnamed_3754;
										uint4 fragment_unnamed_5762 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_5767 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_5771 = asfloat(fragment_unnamed_5759 ? fragment_unnamed_5762.z : fragment_unnamed_5767.z);
										float fragment_unnamed_5773 = asfloat(fragment_unnamed_5759 ? fragment_unnamed_5762.w : fragment_unnamed_5767.w);
										float fragment_unnamed_5775 = asfloat(fragment_unnamed_3645 ? fragment_unnamed_2496 : 1065353216u);
										float fragment_unnamed_5791 = mad(fragment_unnamed_3718 * (fragment_unnamed_3653 * fragment_unnamed_3720), fragment_unnamed_5775, fragment_unnamed_3748 + fragment_input_5.x);
										float fragment_unnamed_5792 = mad(fragment_unnamed_3718 * (fragment_unnamed_3654 * fragment_unnamed_3720), fragment_unnamed_5775, fragment_unnamed_3750 + fragment_input_5.y);
										float fragment_unnamed_5793 = mad(fragment_unnamed_3718 * (fragment_unnamed_3655 * fragment_unnamed_3720), fragment_unnamed_5775, fragment_unnamed_3752 + fragment_input_5.z);
										float fragment_unnamed_5797 = ((-0.0f) - fragment_unnamed_3672) + fragment_unnamed_5791;
										float fragment_unnamed_5798 = ((-0.0f) - fragment_unnamed_3674) + fragment_unnamed_5792;
										float fragment_unnamed_5799 = ((-0.0f) - fragment_unnamed_3676) + fragment_unnamed_5793;
										float fragment_unnamed_5831 = asfloat(fragment_unnamed_3645 ? asuint(dot(float3(fragment_unnamed_4829, fragment_unnamed_4830, fragment_unnamed_4831), float3(fragment_unnamed_5797, fragment_unnamed_5798, fragment_unnamed_5799))) : asuint(dot(float4(fragment_unnamed_4829, fragment_unnamed_4830, fragment_unnamed_4831, fragment_unnamed_3676), float4(fragment_unnamed_5791, fragment_unnamed_5792, fragment_unnamed_5793, fragment_unnamed_1230))));
										float fragment_unnamed_5836 = asfloat(fragment_unnamed_3645 ? asuint(dot(float3(fragment_unnamed_4823, fragment_unnamed_4824, fragment_unnamed_4825), float3(fragment_unnamed_5797, fragment_unnamed_5798, fragment_unnamed_5799))) : asuint(dot(float4(fragment_unnamed_4823, fragment_unnamed_4824, fragment_unnamed_4825, asfloat(fragment_unnamed_3671)), float4(fragment_unnamed_5791, fragment_unnamed_5792, fragment_unnamed_5793, fragment_unnamed_1230)))) * fragment_unnamed_3692;
										float fragment_unnamed_5837 = asfloat(fragment_unnamed_3645 ? asuint(dot(float3(fragment_unnamed_4826, fragment_unnamed_4827, fragment_unnamed_4828), float3(fragment_unnamed_5797, fragment_unnamed_5798, fragment_unnamed_5799))) : asuint(dot(float4(fragment_unnamed_4826, fragment_unnamed_4827, fragment_unnamed_4828, asfloat(fragment_unnamed_3673)), float4(fragment_unnamed_5791, fragment_unnamed_5792, fragment_unnamed_5793, fragment_unnamed_1230)))) * fragment_unnamed_3694;
										float fragment_unnamed_5838 = dot(float2(fragment_unnamed_3696, fragment_unnamed_3698), float2(fragment_unnamed_5831, fragment_unnamed_1231));
										float fragment_unnamed_5841 = dot(float2(asfloat(fragment_unnamed_3645 ? 3212836864u : 0u), asfloat(fragment_unnamed_3645 ? 0u : 1065353216u)), float2(fragment_unnamed_5831, fragment_unnamed_1231));
										bool fragment_unnamed_5850 = (fragment_unnamed_3646 & ((fragment_unnamed_5841 != 0.0f) ? 4294967295u : 0u)) != 0u;
										float fragment_unnamed_5869 = mad(fragment_unnamed_3730 * clamp(mad(asfloat(fragment_unnamed_5850 ? asuint(fragment_unnamed_5836 / fragment_unnamed_5841) : asuint(fragment_unnamed_5836)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5771, fragment_unnamed_4821);
										float fragment_unnamed_5870 = mad(fragment_unnamed_3732 * clamp(mad(asfloat(fragment_unnamed_5850 ? asuint(fragment_unnamed_5837 / fragment_unnamed_5841) : asuint(fragment_unnamed_5837)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5773, fragment_unnamed_4822);
										uint4 fragment_unnamed_5890 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_5897 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_5903 = asfloat(fragment_unnamed_5759 ? fragment_unnamed_5890.z : fragment_unnamed_5897.z);
										float fragment_unnamed_5905 = asfloat(fragment_unnamed_5759 ? fragment_unnamed_5890.w : fragment_unnamed_5897.w);
										float fragment_unnamed_5907 = asfloat(fragment_unnamed_5759 ? fragment_unnamed_5890.x : fragment_unnamed_5897.x);
										float fragment_unnamed_5909 = asfloat(fragment_unnamed_5759 ? fragment_unnamed_5890.y : fragment_unnamed_5897.y);
										float fragment_unnamed_5910 = asfloat(fragment_unnamed_5850 ? asuint(fragment_unnamed_5838 / fragment_unnamed_5841) : asuint(fragment_unnamed_5838)) + 1.52587890625e-05f;
										float fragment_unnamed_5913 = floor(mad(fragment_unnamed_5869, fragment_unnamed_5907, 0.5f));
										float fragment_unnamed_5914 = floor(mad(fragment_unnamed_5870, fragment_unnamed_5909, 0.5f));
										float fragment_unnamed_5917 = mad(fragment_unnamed_5869, fragment_unnamed_5907, (-0.0f) - fragment_unnamed_5913);
										float fragment_unnamed_5918 = mad(fragment_unnamed_5870, fragment_unnamed_5909, (-0.0f) - fragment_unnamed_5914);
										float fragment_unnamed_5919 = fragment_unnamed_5917 + 0.5f;
										float fragment_unnamed_5920 = fragment_unnamed_5917 + 1.0f;
										float fragment_unnamed_5921 = fragment_unnamed_5918 + 0.5f;
										float fragment_unnamed_5922 = fragment_unnamed_5918 + 1.0f;
										float fragment_unnamed_5927 = (fragment_unnamed_5919 * fragment_unnamed_5919) * 0.07999999821186065673828125f;
										float fragment_unnamed_5928 = (fragment_unnamed_5921 * fragment_unnamed_5921) * 0.07999999821186065673828125f;
										float fragment_unnamed_5935 = ((-0.0f) - fragment_unnamed_5917) + 1.0f;
										float fragment_unnamed_5936 = ((-0.0f) - fragment_unnamed_5918) + 1.0f;
										float fragment_unnamed_5937 = min(fragment_unnamed_5917, 0.0f);
										float fragment_unnamed_5938 = min(fragment_unnamed_5918, 0.0f);
										float fragment_unnamed_5943 = max(fragment_unnamed_5917, 0.0f);
										float fragment_unnamed_5944 = max(fragment_unnamed_5918, 0.0f);
										float fragment_unnamed_5955 = fragment_unnamed_5935 * 0.1599999964237213134765625f;
										float fragment_unnamed_5956 = fragment_unnamed_5936 * 0.1599999964237213134765625f;
										float fragment_unnamed_5957 = (mad((-0.0f) - fragment_unnamed_5937, fragment_unnamed_5937, fragment_unnamed_5935) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5959 = (mad((-0.0f) - fragment_unnamed_5943, fragment_unnamed_5943, fragment_unnamed_5920) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5960 = (mad((-0.0f) - fragment_unnamed_5944, fragment_unnamed_5944, fragment_unnamed_5922) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5964 = (fragment_unnamed_5920 * 0.1599999964237213134765625f) + fragment_unnamed_5927;
										float fragment_unnamed_5965 = (mad(fragment_unnamed_5919 * fragment_unnamed_5919, 0.5f, (-0.0f) - fragment_unnamed_5917) * 0.1599999964237213134765625f) + fragment_unnamed_5955;
										float fragment_unnamed_5966 = fragment_unnamed_5957 + fragment_unnamed_5959;
										float fragment_unnamed_5967 = (mad(fragment_unnamed_5921 * fragment_unnamed_5921, 0.5f, (-0.0f) - fragment_unnamed_5918) * 0.1599999964237213134765625f) + fragment_unnamed_5956;
										float fragment_unnamed_5968 = ((mad((-0.0f) - fragment_unnamed_5938, fragment_unnamed_5938, fragment_unnamed_5936) + 1.0f) * 0.1599999964237213134765625f) + fragment_unnamed_5960;
										float fragment_unnamed_5969 = (fragment_unnamed_5922 * 0.1599999964237213134765625f) + fragment_unnamed_5928;
										float fragment_unnamed_5982 = fragment_unnamed_5903 * ((fragment_unnamed_5959 / fragment_unnamed_5966) + (-0.5f));
										float fragment_unnamed_5983 = fragment_unnamed_5903 * ((fragment_unnamed_5955 / fragment_unnamed_5965) + (-2.5f));
										float fragment_unnamed_5984 = fragment_unnamed_5903 * ((fragment_unnamed_5927 / fragment_unnamed_5964) + 1.5f);
										float fragment_unnamed_5985 = fragment_unnamed_5905 * ((fragment_unnamed_5956 / fragment_unnamed_5967) + (-2.5f));
										float fragment_unnamed_5986 = fragment_unnamed_5905 * ((fragment_unnamed_5960 / fragment_unnamed_5968) + (-0.5f));
										float fragment_unnamed_5987 = fragment_unnamed_5905 * ((fragment_unnamed_5928 / fragment_unnamed_5969) + 1.5f);
										float fragment_unnamed_6006 = fragment_unnamed_5967 * fragment_unnamed_5965;
										float fragment_unnamed_6007 = fragment_unnamed_5967 * fragment_unnamed_5966;
										float fragment_unnamed_6008 = fragment_unnamed_5967 * fragment_unnamed_5964;
										float fragment_unnamed_6009 = fragment_unnamed_5968 * fragment_unnamed_5965;
										float fragment_unnamed_6010 = fragment_unnamed_5968 * (fragment_unnamed_5957 + fragment_unnamed_5959);
										float fragment_unnamed_6011 = fragment_unnamed_5968 * fragment_unnamed_5964;
										float fragment_unnamed_6012 = fragment_unnamed_5969 * fragment_unnamed_5965;
										float fragment_unnamed_6013 = fragment_unnamed_5969 * fragment_unnamed_5966;
										float4 fragment_unnamed_6018 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5913, fragment_unnamed_5903, fragment_unnamed_5983), mad(fragment_unnamed_5914, fragment_unnamed_5905, fragment_unnamed_5985)), fragment_unnamed_5910).xxxx;
										float fragment_unnamed_6019 = fragment_unnamed_6018.x;
										float4 fragment_unnamed_6022 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5913, fragment_unnamed_5903, fragment_unnamed_5982), mad(fragment_unnamed_5914, fragment_unnamed_5905, fragment_unnamed_5985)), fragment_unnamed_5910).xxxx;
										float fragment_unnamed_6023 = fragment_unnamed_6022.x;
										float4 fragment_unnamed_6026 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5913, fragment_unnamed_5903, fragment_unnamed_5984), mad(fragment_unnamed_5914, fragment_unnamed_5905, fragment_unnamed_5985)), fragment_unnamed_5910).xxxx;
										float fragment_unnamed_6027 = fragment_unnamed_6026.x;
										float4 fragment_unnamed_6030 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5913, fragment_unnamed_5903, fragment_unnamed_5983), mad(fragment_unnamed_5914, fragment_unnamed_5905, fragment_unnamed_5986)), fragment_unnamed_5910).xxxx;
										float fragment_unnamed_6031 = fragment_unnamed_6030.x;
										float fragment_unnamed_6033 = asfloat(0u);
										float fragment_unnamed_6185;
										fragment_unnamed_6185 = asfloat(0u);
										for (float fragment_unnamed_6187 = fragment_unnamed_6033; !(int(asuint(fragment_unnamed_6187)) >= int(1u)); fragment_unnamed_6185 = mad(fragment_unnamed_6009, fragment_unnamed_6031, mad(fragment_unnamed_6008, fragment_unnamed_6027, mad(fragment_unnamed_6007, fragment_unnamed_6023, mad(fragment_unnamed_6006, fragment_unnamed_6019, fragment_unnamed_6185)))), fragment_unnamed_6187 = asfloat(asuint(fragment_unnamed_6187) + 1u))
										{
										}
										float4 fragment_unnamed_6655 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5913, fragment_unnamed_5903, fragment_unnamed_5982), mad(fragment_unnamed_5914, fragment_unnamed_5905, fragment_unnamed_5986)), fragment_unnamed_5910).xxxx;
										float fragment_unnamed_6656 = fragment_unnamed_6655.x;
										float4 fragment_unnamed_6659 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5913, fragment_unnamed_5903, fragment_unnamed_5984), mad(fragment_unnamed_5914, fragment_unnamed_5905, fragment_unnamed_5986)), fragment_unnamed_5910).xxxx;
										float fragment_unnamed_6660 = fragment_unnamed_6659.x;
										float4 fragment_unnamed_6663 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5913, fragment_unnamed_5903, fragment_unnamed_5983), mad(fragment_unnamed_5914, fragment_unnamed_5905, fragment_unnamed_5987)), fragment_unnamed_5910).xxxx;
										float fragment_unnamed_6664 = fragment_unnamed_6663.x;
										float4 fragment_unnamed_6667 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5913, fragment_unnamed_5903, fragment_unnamed_5982), mad(fragment_unnamed_5914, fragment_unnamed_5905, fragment_unnamed_5987)), fragment_unnamed_5910).xxxx;
										float fragment_unnamed_6668 = fragment_unnamed_6667.x;
										float fragment_unnamed_6669 = asfloat(0u);
										float fragment_unnamed_7098;
										fragment_unnamed_7098 = fragment_unnamed_6185;
										float fragment_unnamed_7099;
										for (float fragment_unnamed_7100 = fragment_unnamed_6669; !(int(asuint(fragment_unnamed_7100)) >= int(1u)); fragment_unnamed_7099 = mad(fragment_unnamed_6013, fragment_unnamed_6668, mad(fragment_unnamed_6012, fragment_unnamed_6664, mad(fragment_unnamed_6011, fragment_unnamed_6660, mad(fragment_unnamed_6010, fragment_unnamed_6656, fragment_unnamed_7098)))), fragment_unnamed_7098 = fragment_unnamed_7099, fragment_unnamed_7100 = asfloat(asuint(fragment_unnamed_7100) + 1u))
										{
										}
										fragment_unnamed_7654 = asfloat((((((mad(fragment_unnamed_3732 + (-0.5f), fragment_unnamed_5773, fragment_unnamed_4822) < fragment_unnamed_5870) ? 4294967295u : 0u) | ((mad(fragment_unnamed_3730 + (-0.5f), fragment_unnamed_5771, fragment_unnamed_4821) < fragment_unnamed_5869) ? 4294967295u : 0u)) | (((fragment_unnamed_5870 < (fragment_unnamed_5773 + fragment_unnamed_4822)) ? 4294967295u : 0u) | ((fragment_unnamed_5869 < (fragment_unnamed_5771 + fragment_unnamed_4821)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(mad(fragment_unnamed_5969 * fragment_unnamed_5964, _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5913, fragment_unnamed_5903, fragment_unnamed_5984), mad(fragment_unnamed_5914, fragment_unnamed_5905, fragment_unnamed_5987)), fragment_unnamed_5910).xxxx.x, fragment_unnamed_7098)));
									}
									fragment_unnamed_4415 = mad(fragment_unnamed_2478, fragment_unnamed_7654 + (-1.0f), 1.0f);
								}
								else
								{
									fragment_unnamed_4415 = asfloat(1065353216u);
								}
								float fragment_unnamed_4417 = asfloat(fragment_unnamed_2459.z);
								float fragment_unnamed_4422 = ((-0.0f) - fragment_unnamed_4417) + 1.0f;
								float fragment_unnamed_4423 = ((-0.0f) - asfloat(fragment_unnamed_2465)) + 1.0f;
								float fragment_unnamed_4424 = ((-0.0f) - fragment_unnamed_2476) + 1.0f;
								float fragment_unnamed_4426 = fragment_unnamed_4415 * (fragment_unnamed_4415 * fragment_unnamed_4415);
								float fragment_unnamed_4429 = (-0.0f) - (((-0.0f) - fragment_unnamed_4415) + 1.0f);
								float fragment_unnamed_4430 = mad(fragment_unnamed_4429, fragment_unnamed_4422, 1.0f);
								float fragment_unnamed_4431 = mad(fragment_unnamed_4429, fragment_unnamed_4423, 1.0f);
								float fragment_unnamed_4432 = mad(fragment_unnamed_4429, fragment_unnamed_4424, 1.0f);
								float fragment_unnamed_4449 = (fragment_unnamed_3402 * fragment_unnamed_3404) * mad(fragment_unnamed_2379, ((-0.0f) - fragment_unnamed_4430) + mad(fragment_unnamed_4426, fragment_unnamed_4422, fragment_unnamed_4417 * fragment_unnamed_4415), fragment_unnamed_4430);
								float fragment_unnamed_4450 = (fragment_unnamed_3402 * fragment_unnamed_3406) * mad(fragment_unnamed_2379, ((-0.0f) - fragment_unnamed_4431) + mad(fragment_unnamed_4426, fragment_unnamed_4423, asfloat(fragment_unnamed_2465) * fragment_unnamed_4415), fragment_unnamed_4431);
								float fragment_unnamed_4451 = (fragment_unnamed_3402 * fragment_unnamed_3408) * mad(fragment_unnamed_2379, ((-0.0f) - fragment_unnamed_4432) + mad(fragment_unnamed_4426, fragment_unnamed_4424, fragment_unnamed_2476 * fragment_unnamed_4415), fragment_unnamed_4432);
								float fragment_unnamed_2719;
								float fragment_unnamed_2721;
								float fragment_unnamed_2723;
								float fragment_unnamed_2725;
								float fragment_unnamed_2727;
								float fragment_unnamed_2729;
								if (0.0f < max(fragment_unnamed_4451, max(fragment_unnamed_4450, fragment_unnamed_4449)))
								{
									uint fragment_unnamed_4840 = (fragment_unnamed_1419 * 56u) + 49u;
									uint2 fragment_unnamed_4846 = uint2(T7.Load(fragment_unnamed_4840).x, T7.Load(fragment_unnamed_4840 + 1u).x);
									float fragment_unnamed_4848 = asfloat(fragment_unnamed_4846.x);
									float fragment_unnamed_4850 = asfloat(fragment_unnamed_4846.y);
									float fragment_unnamed_4851 = max(fragment_unnamed_843, asfloat(T7.Load((fragment_unnamed_1419 * 56u) + 38u).x));
									float fragment_unnamed_4852 = clamp(fragment_unnamed_1979, 0.0f, 1.0f);
									float fragment_unnamed_4853 = dot(float3(fragment_unnamed_1974, fragment_unnamed_1975, fragment_unnamed_1976), float3(fragment_unnamed_346, fragment_unnamed_347, fragment_unnamed_348));
									float fragment_unnamed_4858 = rsqrt(max(mad(fragment_unnamed_4853, 2.0f, 2.0f), 5.9604644775390625e-08f));
									float fragment_unnamed_4861 = clamp(fragment_unnamed_4858 * (fragment_unnamed_761 + fragment_unnamed_1979), 0.0f, 1.0f);
									float fragment_unnamed_4865 = ((-0.0f) - clamp(mad(fragment_unnamed_4858, fragment_unnamed_4853, fragment_unnamed_4858), 0.0f, 1.0f)) + 1.0f;
									float fragment_unnamed_4866 = fragment_unnamed_4865 * fragment_unnamed_4865;
									float fragment_unnamed_4867 = fragment_unnamed_4866 * fragment_unnamed_4866;
									float fragment_unnamed_4870 = mad((-0.0f) - fragment_unnamed_4867, fragment_unnamed_4865, 1.0f);
									float fragment_unnamed_4871 = fragment_unnamed_842 * (fragment_unnamed_4865 * fragment_unnamed_4867);
									float fragment_unnamed_4875 = fragment_unnamed_4851 * fragment_unnamed_4851;
									float fragment_unnamed_4878 = mad(mad(fragment_unnamed_4861, fragment_unnamed_4875, (-0.0f) - fragment_unnamed_4861), fragment_unnamed_4861, 1.0f);
									float fragment_unnamed_4894 = (fragment_unnamed_4875 * 0.15915493667125701904296875f) / max((fragment_unnamed_4878 * fragment_unnamed_4878) * mad(abs(fragment_unnamed_1979), fragment_unnamed_862, fragment_unnamed_764 * sqrt(mad(mad((-0.0f) - abs(fragment_unnamed_1979), fragment_unnamed_4875, abs(fragment_unnamed_1979)), abs(fragment_unnamed_1979), fragment_unnamed_4875))), 1.1754943508222875079687365372222e-38f);
									float fragment_unnamed_4901 = ((-0.0f) - abs(fragment_unnamed_1979)) + 1.0f;
									float fragment_unnamed_4902 = fragment_unnamed_4901 * fragment_unnamed_4901;
									float fragment_unnamed_4905 = mad(fragment_unnamed_748, fragment_unnamed_4853, fragment_unnamed_748) + (-0.5f);
									float fragment_unnamed_4911 = ((mad(fragment_unnamed_4905, fragment_unnamed_1227, 1.0f) * mad(fragment_unnamed_4905, fragment_unnamed_4901 * (fragment_unnamed_4902 * fragment_unnamed_4902), 1.0f)) * fragment_unnamed_4852) * 0.307334959506988525390625f;
									fragment_unnamed_2719 = fragment_unnamed_4850 * (fragment_unnamed_4449 * (fragment_unnamed_4852 * (fragment_unnamed_4894 * mad(fragment_unnamed_757, fragment_unnamed_4870, fragment_unnamed_4871))));
									fragment_unnamed_2721 = fragment_unnamed_4850 * (fragment_unnamed_4450 * (fragment_unnamed_4852 * (fragment_unnamed_4894 * mad(fragment_unnamed_759, fragment_unnamed_4870, fragment_unnamed_4871))));
									fragment_unnamed_2723 = fragment_unnamed_4850 * (fragment_unnamed_4451 * (fragment_unnamed_4852 * (fragment_unnamed_4894 * mad(fragment_unnamed_760, fragment_unnamed_4870, fragment_unnamed_4871))));
									fragment_unnamed_2725 = fragment_unnamed_4848 * (fragment_unnamed_4449 * fragment_unnamed_4911);
									fragment_unnamed_2727 = fragment_unnamed_4848 * (fragment_unnamed_4450 * fragment_unnamed_4911);
									fragment_unnamed_2729 = fragment_unnamed_4848 * (fragment_unnamed_4451 * fragment_unnamed_4911);
								}
								else
								{
									fragment_unnamed_2719 = asfloat(0u);
									fragment_unnamed_2721 = asfloat(0u);
									fragment_unnamed_2723 = asfloat(0u);
									fragment_unnamed_2725 = asfloat(0u);
									fragment_unnamed_2727 = asfloat(0u);
									fragment_unnamed_2729 = asfloat(0u);
								}
								fragment_unnamed_2718 = fragment_unnamed_2719;
								fragment_unnamed_2720 = fragment_unnamed_2721;
								fragment_unnamed_2722 = fragment_unnamed_2723;
								fragment_unnamed_2724 = fragment_unnamed_2725;
								fragment_unnamed_2726 = fragment_unnamed_2727;
								fragment_unnamed_2728 = fragment_unnamed_2729;
							}
							else
							{
								fragment_unnamed_2718 = asfloat(0u);
								fragment_unnamed_2720 = asfloat(0u);
								fragment_unnamed_2722 = asfloat(0u);
								fragment_unnamed_2724 = asfloat(0u);
								fragment_unnamed_2726 = asfloat(0u);
								fragment_unnamed_2728 = asfloat(0u);
							}
							float fragment_unnamed_1992 = fragment_unnamed_2718 + asfloat(fragment_unnamed_1270);
							fragment_unnamed_1261 = fragment_unnamed_2724 + fragment_unnamed_1260;
							fragment_unnamed_1263 = fragment_unnamed_2726 + fragment_unnamed_1262;
							fragment_unnamed_1265 = fragment_unnamed_2728 + fragment_unnamed_1264;
							fragment_unnamed_1267 = fragment_unnamed_2720 + fragment_unnamed_1266;
							fragment_unnamed_1269 = fragment_unnamed_2722 + fragment_unnamed_1268;
							fragment_unnamed_1271 = asuint(fragment_unnamed_1992);
							fragment_unnamed_1273 = fragment_unnamed_1992;
							fragment_unnamed_1258 = fragment_unnamed_1259;
							fragment_unnamed_1260 = fragment_unnamed_1261;
							fragment_unnamed_1262 = fragment_unnamed_1263;
							fragment_unnamed_1264 = fragment_unnamed_1265;
							fragment_unnamed_1266 = fragment_unnamed_1267;
							fragment_unnamed_1268 = fragment_unnamed_1269;
							fragment_unnamed_1270 = fragment_unnamed_1271;
							fragment_unnamed_1272 = fragment_unnamed_1273;
							continue;
						}
					}
					if (ladder_phi_21)
					{
						break;
					}
					break;
				}
				uint4 fragment_unnamed_1346 = asuint(fragment_uniform_buffer_0[128u]);
				uint fragment_unnamed_1347 = fragment_unnamed_1346.y;
				uint4 fragment_unnamed_1354 = asuint(fragment_uniform_buffer_0[128u]);
				uint fragment_unnamed_1355 = fragment_unnamed_1354.x;
				uint4 fragment_unnamed_1360 = T4.Load(((((fragment_unnamed_1184 + (2u << (fragment_unnamed_1146 & 31u))) * fragment_unnamed_1347) + fragment_unnamed_288) * fragment_unnamed_1355) + fragment_unnamed_286);
				uint fragment_unnamed_1361 = fragment_unnamed_1360.x;
				uint fragment_unnamed_1362 = fragment_unnamed_1361 & 67108863u;
				uint fragment_unnamed_1363 = fragment_unnamed_1361 >> 26u;
				float4 fragment_unnamed_1364 = _SsrLightingTexture.Load(int4(uint3(fragment_unnamed_284, fragment_unnamed_285, 0u), 0u));
				float fragment_unnamed_1369 = fragment_unnamed_1364.w;
				float4 fragment_unnamed_1370 = _PrevExposureTexture.Load(int3(uint2(0u, 0u), 0u));
				float fragment_unnamed_1373 = fragment_unnamed_1370.x;
				float fragment_unnamed_1395 = asfloat((asuint(fragment_uniform_buffer_0[213u]).y != 0u) ? 1065353216u : asuint(1.0f / mad(fragment_unnamed_1373, fragment_uniform_buffer_0[118u].y, asfloat((((fragment_unnamed_1373 * fragment_uniform_buffer_0[118u].y) == 0.0f) ? 4294967295u : 0u) & 1065353216u))));
				float fragment_unnamed_1406 = asfloat((asuint(fragment_uniform_buffer_0[213u]).y != 0u) ? asuint(fragment_unnamed_1369) : 1065353216u);
				float fragment_unnamed_1410 = fragment_unnamed_853 * (fragment_unnamed_1406 * (fragment_unnamed_1395 * fragment_unnamed_1364.x));
				float fragment_unnamed_1411 = fragment_unnamed_854 * (fragment_unnamed_1406 * (fragment_unnamed_1395 * fragment_unnamed_1364.y));
				float fragment_unnamed_1412 = fragment_unnamed_855 * (fragment_unnamed_1406 * (fragment_unnamed_1395 * fragment_unnamed_1364.z));
				float fragment_unnamed_1413 = asfloat(0u);
				float fragment_unnamed_1414 = asfloat(0u);
				float fragment_unnamed_1415 = asfloat(0u);
				float fragment_unnamed_1595;
				float fragment_unnamed_1597;
				float fragment_unnamed_1599;
				float fragment_unnamed_1601;
				float fragment_unnamed_1603;
				for (;;)
				{
					fragment_unnamed_1595 = fragment_unnamed_1369;
					fragment_unnamed_1597 = fragment_unnamed_1415;
					fragment_unnamed_1599 = fragment_unnamed_1410;
					fragment_unnamed_1601 = fragment_unnamed_1411;
					fragment_unnamed_1603 = fragment_unnamed_1412;
					float fragment_unnamed_1598;
					float fragment_unnamed_1596;
					float fragment_unnamed_1600;
					float fragment_unnamed_1602;
					float fragment_unnamed_1604;
					bool ladder_phi_33;
					for (;;)
					{
						if (asuint(fragment_unnamed_1597) >= fragment_unnamed_1363)
						{
							ladder_phi_33 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_1889 = asuint(fragment_unnamed_1597);
							uint4 fragment_unnamed_1891 = T3.Load(fragment_unnamed_1362 + fragment_unnamed_1889);
							uint fragment_unnamed_1892 = fragment_unnamed_1891.x;
							if (fragment_unnamed_1892 == 4294967295u)
							{
								ladder_phi_33 = false;
								break;
							}
							fragment_unnamed_1598 = asfloat(asuint(fragment_unnamed_1597) + 1u);
							if (!(fragment_unnamed_1595 < 1.0f))
							{
								fragment_unnamed_1596 = fragment_unnamed_1595;
								fragment_unnamed_1600 = fragment_unnamed_1599;
								fragment_unnamed_1602 = fragment_unnamed_1601;
								fragment_unnamed_1604 = fragment_unnamed_1603;
								fragment_unnamed_1595 = fragment_unnamed_1596;
								fragment_unnamed_1597 = fragment_unnamed_1598;
								fragment_unnamed_1599 = fragment_unnamed_1600;
								fragment_unnamed_1601 = fragment_unnamed_1602;
								fragment_unnamed_1603 = fragment_unnamed_1604;
								continue;
							}
							uint fragment_unnamed_2678 = fragment_unnamed_1892 * 72u;
							uint4 fragment_unnamed_2691 = uint4(T8.Load(fragment_unnamed_2678).x, T8.Load(fragment_unnamed_2678 + 1u).x, T8.Load(fragment_unnamed_2678 + 2u).x, T8.Load(fragment_unnamed_2678 + 3u).x);
							float fragment_unnamed_2694 = asfloat(fragment_unnamed_2691.y);
							float fragment_unnamed_2696 = asfloat(fragment_unnamed_2691.z);
							float fragment_unnamed_2698 = asfloat(fragment_unnamed_2691.w);
							float fragment_unnamed_2701;
							float fragment_unnamed_2702;
							float fragment_unnamed_2703;
							float fragment_unnamed_2704;
							if ((fragment_unnamed_475 & fragment_unnamed_2691.x) != 0u)
							{
								uint fragment_unnamed_2887 = (fragment_unnamed_1892 * 72u) + 4u;
								uint4 fragment_unnamed_2899 = uint4(T8.Load(fragment_unnamed_2887).x, T8.Load(fragment_unnamed_2887 + 1u).x, T8.Load(fragment_unnamed_2887 + 2u).x, T8.Load(fragment_unnamed_2887 + 3u).x);
								uint fragment_unnamed_2900 = fragment_unnamed_2899.x;
								float fragment_unnamed_2902 = asfloat(fragment_unnamed_2899.y);
								float fragment_unnamed_2904 = asfloat(fragment_unnamed_2899.z);
								float fragment_unnamed_2906 = asfloat(fragment_unnamed_2899.w);
								uint fragment_unnamed_2908 = (fragment_unnamed_1892 * 72u) + 8u;
								uint4 fragment_unnamed_2920 = uint4(T8.Load(fragment_unnamed_2908).x, T8.Load(fragment_unnamed_2908 + 1u).x, T8.Load(fragment_unnamed_2908 + 2u).x, T8.Load(fragment_unnamed_2908 + 3u).x);
								float fragment_unnamed_2922 = asfloat(fragment_unnamed_2920.x);
								uint fragment_unnamed_2930 = (fragment_unnamed_1892 * 72u) + 12u;
								uint4 fragment_unnamed_2942 = uint4(T8.Load(fragment_unnamed_2930).x, T8.Load(fragment_unnamed_2930 + 1u).x, T8.Load(fragment_unnamed_2930 + 2u).x, T8.Load(fragment_unnamed_2930 + 3u).x);
								float fragment_unnamed_2944 = asfloat(fragment_unnamed_2942.x);
								float fragment_unnamed_2946 = asfloat(fragment_unnamed_2942.y);
								float fragment_unnamed_2948 = asfloat(fragment_unnamed_2942.z);
								uint fragment_unnamed_2951 = (fragment_unnamed_1892 * 72u) + 16u;
								uint4 fragment_unnamed_2963 = uint4(T8.Load(fragment_unnamed_2951).x, T8.Load(fragment_unnamed_2951 + 1u).x, T8.Load(fragment_unnamed_2951 + 2u).x, T8.Load(fragment_unnamed_2951 + 3u).x);
								float fragment_unnamed_2966 = asfloat(fragment_unnamed_2963.x);
								float fragment_unnamed_2968 = asfloat(fragment_unnamed_2963.y);
								uint fragment_unnamed_2972 = (fragment_unnamed_1892 * 72u) + 20u;
								uint4 fragment_unnamed_2984 = uint4(T8.Load(fragment_unnamed_2972).x, T8.Load(fragment_unnamed_2972 + 1u).x, T8.Load(fragment_unnamed_2972 + 2u).x, T8.Load(fragment_unnamed_2972 + 3u).x);
								float fragment_unnamed_2990 = asfloat(fragment_unnamed_2984.x);
								uint fragment_unnamed_2994 = (fragment_unnamed_1892 * 72u) + 24u;
								uint4 fragment_unnamed_3006 = uint4(T8.Load(fragment_unnamed_2994).x, T8.Load(fragment_unnamed_2994 + 1u).x, T8.Load(fragment_unnamed_2994 + 2u).x, T8.Load(fragment_unnamed_2994 + 3u).x);
								float fragment_unnamed_3008 = asfloat(fragment_unnamed_3006.x);
								float fragment_unnamed_3010 = asfloat(fragment_unnamed_3006.y);
								float fragment_unnamed_3012 = asfloat(fragment_unnamed_3006.z);
								uint fragment_unnamed_3015 = (fragment_unnamed_1892 * 72u) + 28u;
								uint4 fragment_unnamed_3027 = uint4(T8.Load(fragment_unnamed_3015).x, T8.Load(fragment_unnamed_3015 + 1u).x, T8.Load(fragment_unnamed_3015 + 2u).x, T8.Load(fragment_unnamed_3015 + 3u).x);
								float fragment_unnamed_3030 = asfloat(fragment_unnamed_3027.x);
								float fragment_unnamed_3032 = asfloat(fragment_unnamed_3027.y);
								uint fragment_unnamed_3036 = (fragment_unnamed_1892 * 72u) + 32u;
								uint4 fragment_unnamed_3048 = uint4(T8.Load(fragment_unnamed_3036).x, T8.Load(fragment_unnamed_3036 + 1u).x, T8.Load(fragment_unnamed_3036 + 2u).x, T8.Load(fragment_unnamed_3036 + 3u).x);
								float fragment_unnamed_3051 = asfloat(fragment_unnamed_3048.y);
								float fragment_unnamed_3053 = asfloat(fragment_unnamed_3048.z);
								float fragment_unnamed_3055 = asfloat(fragment_unnamed_3048.w);
								uint fragment_unnamed_3058 = (fragment_unnamed_1892 * 72u) + 36u;
								uint4 fragment_unnamed_3070 = uint4(T8.Load(fragment_unnamed_3058).x, T8.Load(fragment_unnamed_3058 + 1u).x, T8.Load(fragment_unnamed_3058 + 2u).x, T8.Load(fragment_unnamed_3058 + 3u).x);
								float fragment_unnamed_3072 = asfloat(fragment_unnamed_3070.x);
								uint fragment_unnamed_3079 = (fragment_unnamed_1892 * 72u) + 40u;
								uint4 fragment_unnamed_3091 = uint4(T8.Load(fragment_unnamed_3079).x, T8.Load(fragment_unnamed_3079 + 1u).x, T8.Load(fragment_unnamed_3079 + 2u).x, T8.Load(fragment_unnamed_3079 + 3u).x);
								float fragment_unnamed_3093 = asfloat(fragment_unnamed_3091.z);
								uint fragment_unnamed_3100 = (fragment_unnamed_1892 * 72u) + 52u;
								uint4 fragment_unnamed_3112 = uint4(T8.Load(fragment_unnamed_3100).x, T8.Load(fragment_unnamed_3100 + 1u).x, T8.Load(fragment_unnamed_3100 + 2u).x, T8.Load(fragment_unnamed_3100 + 3u).x);
								uint fragment_unnamed_3119 = (fragment_unnamed_1892 * 72u) + 56u;
								uint4 fragment_unnamed_3131 = uint4(T8.Load(fragment_unnamed_3119).x, T8.Load(fragment_unnamed_3119 + 1u).x, T8.Load(fragment_unnamed_3119 + 2u).x, T8.Load(fragment_unnamed_3119 + 3u).x);
								float fragment_unnamed_3133 = asfloat(fragment_unnamed_3131.x);
								uint fragment_unnamed_3138 = fragment_unnamed_3131.w;
								bool fragment_unnamed_3139 = int(fragment_unnamed_3138) >= int(0u);
								float fragment_unnamed_3141 = max(fragment_unnamed_761, 9.9999997473787516355514526367188e-05f);
								float fragment_unnamed_3142 = fragment_unnamed_748 * fragment_unnamed_748;
								float fragment_unnamed_3144 = mad((-0.0f) - fragment_unnamed_748, fragment_unnamed_748, 1.0f);
								float fragment_unnamed_3151 = clamp(mad(fragment_unnamed_3144, fragment_unnamed_3144, fragment_unnamed_3144 * (fragment_unnamed_3141 * fragment_unnamed_3141)), 0.0f, 1.0f) * mad(fragment_unnamed_748, fragment_unnamed_748, sqrt(fragment_unnamed_3144));
								float fragment_unnamed_3158 = mad(fragment_unnamed_3151, mad((-0.0f) - fragment_unnamed_459, fragment_unnamed_466, fragment_unnamed_871), fragment_unnamed_467);
								float fragment_unnamed_3159 = mad(fragment_unnamed_3151, mad((-0.0f) - fragment_unnamed_460, fragment_unnamed_466, fragment_unnamed_872), fragment_unnamed_468);
								float fragment_unnamed_3160 = mad(fragment_unnamed_3151, mad((-0.0f) - fragment_unnamed_461, fragment_unnamed_466, fragment_unnamed_873), fragment_unnamed_469);
								float fragment_unnamed_3162 = min(fragment_unnamed_3142 * fragment_unnamed_3142, 1.0f);
								float fragment_unnamed_3166 = min((fragment_unnamed_3162 * fragment_unnamed_3162) * mad(fragment_unnamed_3162, -2.0f, 3.0f), 1.0f);
								float fragment_unnamed_3183 = asfloat(fragment_unnamed_3139 ? asuint(mad(fragment_unnamed_3166, fragment_unnamed_871 + ((-0.0f) - fragment_unnamed_3158), fragment_unnamed_3158)) : asuint(fragment_unnamed_871));
								float fragment_unnamed_3185 = asfloat(fragment_unnamed_3139 ? asuint(mad(fragment_unnamed_3166, fragment_unnamed_872 + ((-0.0f) - fragment_unnamed_3159), fragment_unnamed_3159)) : asuint(fragment_unnamed_872));
								float fragment_unnamed_3187 = asfloat(fragment_unnamed_3139 ? asuint(mad(fragment_unnamed_3166, fragment_unnamed_873 + ((-0.0f) - fragment_unnamed_3160), fragment_unnamed_3160)) : asuint(fragment_unnamed_873));
								float fragment_unnamed_3197 = ((-0.0f) - asfloat(fragment_unnamed_2984.y)) + fragment_input_5.x;
								float fragment_unnamed_3198 = ((-0.0f) - asfloat(fragment_unnamed_2984.z)) + fragment_input_5.y;
								float fragment_unnamed_3199 = ((-0.0f) - asfloat(fragment_unnamed_2984.w)) + fragment_input_5.z;
								float fragment_unnamed_3200 = asfloat(fragment_unnamed_3027.z);
								float fragment_unnamed_3201 = asfloat(fragment_unnamed_3027.w);
								float fragment_unnamed_3202 = asfloat(fragment_unnamed_3048.x);
								float fragment_unnamed_3203 = dot(float3(fragment_unnamed_3197, fragment_unnamed_3198, fragment_unnamed_3199), float3(fragment_unnamed_3200, fragment_unnamed_3201, fragment_unnamed_3202));
								float fragment_unnamed_3206 = asfloat(fragment_unnamed_3006.w);
								float fragment_unnamed_3207 = dot(float3(fragment_unnamed_3197, fragment_unnamed_3198, fragment_unnamed_3199), float3(fragment_unnamed_3206, fragment_unnamed_3030, fragment_unnamed_3032));
								float fragment_unnamed_3210 = dot(float3(fragment_unnamed_3197, fragment_unnamed_3198, fragment_unnamed_3199), float3(fragment_unnamed_3008, fragment_unnamed_3010, fragment_unnamed_3012));
								float fragment_unnamed_3222 = ((-0.0f) - asfloat(fragment_unnamed_2920.y)) + fragment_input_5.x;
								float fragment_unnamed_3223 = ((-0.0f) - asfloat(fragment_unnamed_2920.z)) + fragment_input_5.y;
								float fragment_unnamed_3224 = ((-0.0f) - asfloat(fragment_unnamed_2920.w)) + fragment_input_5.z;
								float fragment_unnamed_3225 = asfloat(fragment_unnamed_2963.z);
								float fragment_unnamed_3226 = asfloat(fragment_unnamed_2963.w);
								float fragment_unnamed_3227 = dot(float3(fragment_unnamed_3222, fragment_unnamed_3223, fragment_unnamed_3224), float3(fragment_unnamed_3225, fragment_unnamed_3226, fragment_unnamed_2990));
								float fragment_unnamed_3230 = asfloat(fragment_unnamed_2942.w);
								float fragment_unnamed_3231 = dot(float3(fragment_unnamed_3222, fragment_unnamed_3223, fragment_unnamed_3224), float3(fragment_unnamed_3230, fragment_unnamed_2966, fragment_unnamed_2968));
								float fragment_unnamed_3234 = dot(float3(fragment_unnamed_3222, fragment_unnamed_3223, fragment_unnamed_3224), float3(fragment_unnamed_2944, fragment_unnamed_2946, fragment_unnamed_2948));
								float fragment_unnamed_3237 = dot(float3(fragment_unnamed_3183, fragment_unnamed_3185, fragment_unnamed_3187), float3(fragment_unnamed_3225, fragment_unnamed_3226, fragment_unnamed_2990));
								float fragment_unnamed_3240 = dot(float3(fragment_unnamed_3183, fragment_unnamed_3185, fragment_unnamed_3187), float3(fragment_unnamed_3230, fragment_unnamed_2966, fragment_unnamed_2968));
								float fragment_unnamed_3243 = dot(float3(fragment_unnamed_3183, fragment_unnamed_3185, fragment_unnamed_3187), float3(fragment_unnamed_2944, fragment_unnamed_2946, fragment_unnamed_2948));
								float fragment_unnamed_4001;
								float fragment_unnamed_4003;
								float fragment_unnamed_4005;
								float fragment_unnamed_4007;
								float fragment_unnamed_4009;
								if (fragment_unnamed_2900 == 2u)
								{
									float fragment_unnamed_3550 = dot(float3(fragment_unnamed_3237, fragment_unnamed_3240, fragment_unnamed_3243), float3(fragment_unnamed_3227, fragment_unnamed_3231, fragment_unnamed_3234));
									float fragment_unnamed_3553 = fragment_unnamed_3550 + fragment_unnamed_3550;
									float fragment_unnamed_3566 = abs(mad((-0.0f) - fragment_unnamed_3550, 2.0f, sqrt(mad(fragment_unnamed_3553, fragment_unnamed_3553, (-0.0f) - (mad((-0.0f) - fragment_unnamed_2902, fragment_unnamed_2902, dot(float3(fragment_unnamed_3227, fragment_unnamed_3231, fragment_unnamed_3234), float3(fragment_unnamed_3227, fragment_unnamed_3231, fragment_unnamed_3234))) * 4.0f))))) * 0.5f;
									float fragment_unnamed_3575 = max(fragment_unnamed_2922, asfloat((2139095040u < (asuint(fragment_unnamed_3566) & 2147483647u)) ? 3212836864u : asuint(fragment_unnamed_3566)));
									float fragment_unnamed_3594 = sqrt(dot(float3(fragment_unnamed_3203, fragment_unnamed_3207, fragment_unnamed_3210), float3(fragment_unnamed_3203, fragment_unnamed_3207, fragment_unnamed_3210)));
									float fragment_unnamed_3617 = ((-0.0f) - fragment_unnamed_2694) + fragment_input_5.x;
									float fragment_unnamed_3618 = ((-0.0f) - fragment_unnamed_2696) + fragment_input_5.y;
									float fragment_unnamed_3619 = ((-0.0f) - fragment_unnamed_2698) + fragment_input_5.z;
									float fragment_unnamed_3623 = rsqrt(dot(float3(fragment_unnamed_3617, fragment_unnamed_3618, fragment_unnamed_3619), float3(fragment_unnamed_3617, fragment_unnamed_3618, fragment_unnamed_3619)));
									fragment_unnamed_4001 = fragment_unnamed_3575;
									fragment_unnamed_4003 = asfloat(((fragment_unnamed_3051 + ((-0.0f) - fragment_unnamed_3093)) >= fragment_unnamed_3594) ? 1065353216u : asuint(clamp(mad(dot(float3(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469), float3(fragment_unnamed_3623 * fragment_unnamed_3617, fragment_unnamed_3623 * fragment_unnamed_3618, fragment_unnamed_3623 * fragment_unnamed_3619)), -2.5f, 1.5f), 0.0f, 1.0f))) * max(((-0.0f) - (max(fragment_unnamed_3594 + ((-0.0f) - (fragment_unnamed_3051 + ((-0.0f) - fragment_unnamed_3072))), 0.0f) / max(fragment_unnamed_3072, 9.9999997473787516355514526367188e-05f))) + 1.0f, 0.0f);
									fragment_unnamed_4005 = ((-0.0f) - fragment_unnamed_2694) + mad(fragment_unnamed_3575, fragment_unnamed_3183, fragment_input_5.x);
									fragment_unnamed_4007 = ((-0.0f) - fragment_unnamed_2696) + mad(fragment_unnamed_3575, fragment_unnamed_3185, fragment_input_5.y);
									fragment_unnamed_4009 = ((-0.0f) - fragment_unnamed_2698) + mad(fragment_unnamed_3575, fragment_unnamed_3187, fragment_input_5.z);
								}
								else
								{
									float fragment_unnamed_4002;
									float fragment_unnamed_4004;
									float fragment_unnamed_4006;
									float fragment_unnamed_4008;
									float fragment_unnamed_4010;
									if (fragment_unnamed_2900 == 1u)
									{
										uint fragment_unnamed_4044 = (fragment_unnamed_1892 * 72u) + 44u;
										uint4 fragment_unnamed_4056 = uint4(T8.Load(fragment_unnamed_4044).x, T8.Load(fragment_unnamed_4044 + 1u).x, T8.Load(fragment_unnamed_4044 + 2u).x, T8.Load(fragment_unnamed_4044 + 3u).x);
										uint fragment_unnamed_4065 = (fragment_unnamed_1892 * 72u) + 48u;
										uint4 fragment_unnamed_4077 = uint4(T8.Load(fragment_unnamed_4065).x, T8.Load(fragment_unnamed_4065 + 1u).x, T8.Load(fragment_unnamed_4065 + 2u).x, T8.Load(fragment_unnamed_4065 + 3u).x);
										float fragment_unnamed_4086 = dot(float3(fragment_unnamed_3183, fragment_unnamed_3185, fragment_unnamed_3187), float3(fragment_unnamed_3200, fragment_unnamed_3201, fragment_unnamed_3202));
										float fragment_unnamed_4089 = dot(float3(fragment_unnamed_3183, fragment_unnamed_3185, fragment_unnamed_3187), float3(fragment_unnamed_3206, fragment_unnamed_3030, fragment_unnamed_3032));
										float fragment_unnamed_4092 = dot(float3(fragment_unnamed_3183, fragment_unnamed_3185, fragment_unnamed_3187), float3(fragment_unnamed_3008, fragment_unnamed_3010, fragment_unnamed_3012));
										float fragment_unnamed_4098 = rsqrt(dot(float3(fragment_unnamed_4086, fragment_unnamed_4089, fragment_unnamed_4092), float3(fragment_unnamed_4086, fragment_unnamed_4089, fragment_unnamed_4092)));
										float fragment_unnamed_4099 = fragment_unnamed_4098 * fragment_unnamed_4086;
										float fragment_unnamed_4100 = fragment_unnamed_4098 * fragment_unnamed_4089;
										float fragment_unnamed_4101 = fragment_unnamed_4098 * fragment_unnamed_4092;
										float fragment_unnamed_4102 = 1.0f / fragment_unnamed_3237;
										float fragment_unnamed_4103 = 1.0f / fragment_unnamed_3240;
										float fragment_unnamed_4104 = 1.0f / fragment_unnamed_3243;
										float fragment_unnamed_4143 = max(fragment_unnamed_2922, min(asfloat((0.0f < fragment_unnamed_3243) ? asuint(fragment_unnamed_4104 * (fragment_unnamed_2906 + ((-0.0f) - fragment_unnamed_3234))) : asuint(fragment_unnamed_4104 * (((-0.0f) - fragment_unnamed_2906) + ((-0.0f) - fragment_unnamed_3234)))), min(asfloat((0.0f < fragment_unnamed_3240) ? asuint(fragment_unnamed_4103 * (fragment_unnamed_2904 + ((-0.0f) - fragment_unnamed_3231))) : asuint(fragment_unnamed_4103 * (((-0.0f) - fragment_unnamed_2904) + ((-0.0f) - fragment_unnamed_3231)))), asfloat((0.0f < fragment_unnamed_3237) ? asuint(fragment_unnamed_4102 * (fragment_unnamed_2902 + ((-0.0f) - fragment_unnamed_3227))) : asuint(fragment_unnamed_4102 * (((-0.0f) - fragment_unnamed_2902) + ((-0.0f) - fragment_unnamed_3227)))))));
										float fragment_unnamed_4159 = fragment_unnamed_3051 + fragment_unnamed_3203;
										float fragment_unnamed_4160 = fragment_unnamed_3053 + fragment_unnamed_3207;
										float fragment_unnamed_4161 = fragment_unnamed_3055 + fragment_unnamed_3210;
										float fragment_unnamed_4165 = fragment_unnamed_3051 + ((-0.0f) - fragment_unnamed_3203);
										float fragment_unnamed_4166 = fragment_unnamed_3053 + ((-0.0f) - fragment_unnamed_3207);
										float fragment_unnamed_4167 = fragment_unnamed_3055 + ((-0.0f) - fragment_unnamed_3210);
										float fragment_unnamed_4228 = ((-0.0f) - fragment_unnamed_2694) + fragment_input_5.x;
										float fragment_unnamed_4229 = ((-0.0f) - fragment_unnamed_2696) + fragment_input_5.y;
										float fragment_unnamed_4230 = ((-0.0f) - fragment_unnamed_2698) + fragment_input_5.z;
										float fragment_unnamed_4234 = rsqrt(dot(float3(fragment_unnamed_4228, fragment_unnamed_4229, fragment_unnamed_4230), float3(fragment_unnamed_4228, fragment_unnamed_4229, fragment_unnamed_4230)));
										float fragment_unnamed_4246 = asfloat(((((((fragment_unnamed_4167 / max(asfloat(fragment_unnamed_4056.x), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & ((((fragment_unnamed_4166 / max(asfloat(fragment_unnamed_3091.w), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_4165 / max(fragment_unnamed_3093, 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u))) & ((((fragment_unnamed_4161 / max(asfloat(fragment_unnamed_4056.w), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & ((((fragment_unnamed_4160 / max(asfloat(fragment_unnamed_4056.z), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_4159 / max(asfloat(fragment_unnamed_4056.y), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u)))) != 0u) ? 1065353216u : asuint(clamp(mad(dot(float3(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469), float3(fragment_unnamed_4234 * fragment_unnamed_4228, fragment_unnamed_4234 * fragment_unnamed_4229, fragment_unnamed_4234 * fragment_unnamed_4230)), -2.5f, 1.5f), 0.0f, 1.0f)));
										fragment_unnamed_4002 = fragment_unnamed_4143;
										fragment_unnamed_4004 = (clamp(min(min(fragment_unnamed_4161 / max(asfloat(fragment_unnamed_3091.y), 9.9999997473787516355514526367188e-05f), min(fragment_unnamed_4160 / max(asfloat(fragment_unnamed_3091.x), 9.9999997473787516355514526367188e-05f), fragment_unnamed_4159 / max(asfloat(fragment_unnamed_3070.w), 9.9999997473787516355514526367188e-05f))), min(fragment_unnamed_4167 / max(asfloat(fragment_unnamed_3070.z), 9.9999997473787516355514526367188e-05f), min(fragment_unnamed_4166 / max(asfloat(fragment_unnamed_3070.y), 9.9999997473787516355514526367188e-05f), fragment_unnamed_4165 / max(fragment_unnamed_3072, 9.9999997473787516355514526367188e-05f)))), 0.0f, 1.0f) * fragment_unnamed_4246) * min((clamp(asfloat(fragment_unnamed_4077.z) * mad(fragment_unnamed_4101, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4101, -4.0f, -1.0f) * asfloat(fragment_unnamed_3112.y), 0.0f, 1.0f)) + ((clamp(asfloat(fragment_unnamed_4077.y) * mad(fragment_unnamed_4100, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4100, -4.0f, -1.0f) * asfloat(fragment_unnamed_3112.x), 0.0f, 1.0f)) + (clamp(asfloat(fragment_unnamed_4077.x) * mad(fragment_unnamed_4099, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4099, -4.0f, -1.0f) * asfloat(fragment_unnamed_4077.w), 0.0f, 1.0f))), 1.0f);
										fragment_unnamed_4006 = ((-0.0f) - fragment_unnamed_2694) + mad(fragment_unnamed_4143, fragment_unnamed_3183, fragment_input_5.x);
										fragment_unnamed_4008 = ((-0.0f) - fragment_unnamed_2696) + mad(fragment_unnamed_4143, fragment_unnamed_3185, fragment_input_5.y);
										fragment_unnamed_4010 = ((-0.0f) - fragment_unnamed_2698) + mad(fragment_unnamed_4143, fragment_unnamed_3187, fragment_input_5.z);
									}
									else
									{
										fragment_unnamed_4002 = asfloat(0u);
										fragment_unnamed_4004 = asfloat(1065353216u);
										fragment_unnamed_4006 = fragment_unnamed_3183;
										fragment_unnamed_4008 = fragment_unnamed_3185;
										fragment_unnamed_4010 = fragment_unnamed_3187;
									}
									fragment_unnamed_4001 = fragment_unnamed_4002;
									fragment_unnamed_4003 = fragment_unnamed_4004;
									fragment_unnamed_4005 = fragment_unnamed_4006;
									fragment_unnamed_4007 = fragment_unnamed_4008;
									fragment_unnamed_4009 = fragment_unnamed_4010;
								}
								float fragment_unnamed_4015 = asfloat(fragment_unnamed_3112.z) * ((fragment_unnamed_4003 * fragment_unnamed_4003) * mad((-0.0f) - fragment_unnamed_4003, 2.0f, 3.0f));
								float fragment_unnamed_4023 = min(fragment_unnamed_748, max(fragment_unnamed_748 * (fragment_unnamed_4001 / sqrt(dot(float3(fragment_unnamed_4005, fragment_unnamed_4007, fragment_unnamed_4009), float3(fragment_unnamed_4005, fragment_unnamed_4007, fragment_unnamed_4009)))), 0.0f));
								float fragment_unnamed_4033 = asfloat(fragment_unnamed_3139 ? asuint(mad(asfloat(fragment_unnamed_3131.z), ((-0.0f) - fragment_unnamed_748) + mad(fragment_unnamed_748, fragment_unnamed_748 + ((-0.0f) - fragment_unnamed_4023), fragment_unnamed_4023), fragment_unnamed_748)) : asuint(fragment_unnamed_748));
								float fragment_unnamed_4037 = asfloat(fragment_unnamed_3131.y) * (fragment_unnamed_4033 * mad((-0.0f) - fragment_unnamed_4033, 0.699999988079071044921875f, 1.7000000476837158203125f));
								float fragment_unnamed_4038 = fragment_unnamed_4037 * 6.0f;
								uint fragment_unnamed_4041 = uint(abs(int(fragment_unnamed_3138))) + 4294967295u;
								float fragment_unnamed_5452;
								float fragment_unnamed_5454;
								float fragment_unnamed_5456;
								float fragment_unnamed_5458;
								if ((fragment_unnamed_3139 ? 4294967295u : 0u) == 0u)
								{
									uint fragment_unnamed_4694 = fragment_unnamed_4041 << 2u;
									uint fragment_unnamed_4695 = fragment_unnamed_4694 + 1u;
									uint fragment_unnamed_4716 = fragment_unnamed_4694 + 2u;
									uint fragment_unnamed_4727 = fragment_unnamed_4694 + 3u;
									float fragment_unnamed_4737 = mad(fragment_uniform_buffer_2[fragment_unnamed_4716].w, fragment_unnamed_4009, mad(fragment_uniform_buffer_2[fragment_unnamed_4694].w, fragment_unnamed_4005, fragment_unnamed_4007 * fragment_uniform_buffer_2[fragment_unnamed_4695].w)) + fragment_uniform_buffer_2[fragment_unnamed_4727].w;
									float fragment_unnamed_4738 = (mad(fragment_uniform_buffer_2[fragment_unnamed_4716].x, fragment_unnamed_4009, mad(fragment_uniform_buffer_2[fragment_unnamed_4694].x, fragment_unnamed_4005, fragment_unnamed_4007 * fragment_uniform_buffer_2[fragment_unnamed_4695].x)) + fragment_uniform_buffer_2[fragment_unnamed_4727].x) * 1.0f;
									float fragment_unnamed_4739 = (mad(fragment_uniform_buffer_2[fragment_unnamed_4716].y, fragment_unnamed_4009, mad(fragment_uniform_buffer_2[fragment_unnamed_4694].y, fragment_unnamed_4005, fragment_unnamed_4007 * fragment_uniform_buffer_2[fragment_unnamed_4695].y)) + fragment_uniform_buffer_2[fragment_unnamed_4727].y) * (-1.0f);
									uint fragment_unnamed_4751 = ((abs((mad(fragment_uniform_buffer_2[fragment_unnamed_4716].z, fragment_unnamed_4009, mad(fragment_uniform_buffer_2[fragment_unnamed_4694].z, fragment_unnamed_4005, fragment_unnamed_4007 * fragment_uniform_buffer_2[fragment_unnamed_4695].z)) + fragment_uniform_buffer_2[fragment_unnamed_4727].z) * 1.0f) < fragment_unnamed_4737) ? 4294967295u : 0u) & (((abs(fragment_unnamed_4739) < fragment_unnamed_4737) ? 4294967295u : 0u) & ((abs(fragment_unnamed_4738) < fragment_unnamed_4737) ? 4294967295u : 0u));
									float fragment_unnamed_5453;
									float fragment_unnamed_5455;
									float fragment_unnamed_5457;
									float fragment_unnamed_5459;
									if (fragment_unnamed_4751 != 0u)
									{
										float fragment_unnamed_5312 = 1.0f / fragment_unnamed_4737;
										float fragment_unnamed_5315 = mad(fragment_unnamed_5312 * fragment_unnamed_4738, 0.5f, 0.5f);
										float fragment_unnamed_5316 = mad(fragment_unnamed_5312 * fragment_unnamed_4739, 0.5f, 0.5f);
										uint fragment_unnamed_5324 = fragment_unnamed_4041 + 64u;
										uint fragment_unnamed_5336 = fragment_unnamed_4041 + 64u;
										float fragment_unnamed_5344 = exp2(ceil(fragment_unnamed_4038));
										float fragment_unnamed_5349 = fragment_unnamed_5344 * fragment_uniform_buffer_0[125u].z;
										float fragment_unnamed_5350 = fragment_unnamed_5344 * fragment_uniform_buffer_0[125u].w;
										uint fragment_unnamed_5351 = fragment_unnamed_4041 + 64u;
										uint fragment_unnamed_5358 = fragment_unnamed_4041 + 64u;
										uint fragment_unnamed_5363 = fragment_unnamed_4041 + 64u;
										float4 fragment_unnamed_5381 = _ReflectionAtlas.SampleLevel(S1, float3(min(mad((-0.0f) - fragment_unnamed_5349, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5358].x + fragment_uniform_buffer_2[fragment_unnamed_5363].z), max(mad(fragment_unnamed_5349, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5351].z), mad(fragment_unnamed_5315, ((-0.0f) - fragment_uniform_buffer_0[125u].x) + fragment_uniform_buffer_2[fragment_unnamed_5324].x, mad(fragment_uniform_buffer_0[125u].x, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5336].z)))), min(mad((-0.0f) - fragment_unnamed_5350, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5358].y + fragment_uniform_buffer_2[fragment_unnamed_5363].w), max(mad(fragment_unnamed_5350, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5351].w), mad(fragment_unnamed_5316, ((-0.0f) - fragment_uniform_buffer_0[125u].y) + fragment_uniform_buffer_2[fragment_unnamed_5324].y, mad(fragment_uniform_buffer_0[125u].y, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5336].w)))), fragment_unnamed_1414), fragment_unnamed_4038);
										float fragment_unnamed_5416 = min(abs(mad((-0.0f) - fragment_unnamed_282, fragment_uniform_buffer_0[50u].z, fragment_unnamed_5315)) * 100.0f, 1.0f);
										float fragment_unnamed_5417 = min(abs(mad((-0.0f) - fragment_unnamed_283, fragment_uniform_buffer_0[50u].w, fragment_unnamed_5316)) * 100.0f, 1.0f);
										fragment_unnamed_5453 = (asfloat((((((fragment_unnamed_295 < fragment_unnamed_5316) ? 4294967295u : 0u) & 1u) ^ (((fragment_unnamed_5316 < 0.5f) ? 4294967295u : 0u) & 1u)) != 0u) ? asuint(mad(mad((-0.0f) - fragment_unnamed_5417, 2.0f, 3.0f) * (fragment_unnamed_5417 * fragment_unnamed_5417), min(mad((-0.0f) - abs(mad(clamp(fragment_unnamed_5316, 0.0f, 1.0f), 2.0f, -1.0f)), 2.0f, 2.0f), 1.0f) + (-1.0f), 1.0f)) : 1065353216u) * asfloat((((((fragment_unnamed_294 < fragment_unnamed_5315) ? 4294967295u : 0u) & 1u) ^ (((fragment_unnamed_5315 < 0.5f) ? 4294967295u : 0u) & 1u)) != 0u) ? asuint(mad(mad((-0.0f) - fragment_unnamed_5416, 2.0f, 3.0f) * (fragment_unnamed_5416 * fragment_unnamed_5416), min(mad((-0.0f) - abs(mad(clamp(fragment_unnamed_5315, 0.0f, 1.0f), 2.0f, -1.0f)), 2.0f, 2.0f), 1.0f) + (-1.0f), 1.0f)) : 1065353216u)) * asfloat(fragment_unnamed_4751 & 1065353216u);
										fragment_unnamed_5455 = fragment_unnamed_5381.x;
										fragment_unnamed_5457 = fragment_unnamed_5381.y;
										fragment_unnamed_5459 = fragment_unnamed_5381.z;
									}
									else
									{
										fragment_unnamed_5453 = asfloat(0u);
										fragment_unnamed_5455 = asfloat(0u);
										fragment_unnamed_5457 = asfloat(0u);
										fragment_unnamed_5459 = asfloat(0u);
									}
									fragment_unnamed_5452 = fragment_unnamed_5453;
									fragment_unnamed_5454 = fragment_unnamed_5455;
									fragment_unnamed_5456 = fragment_unnamed_5457;
									fragment_unnamed_5458 = fragment_unnamed_5459;
								}
								else
								{
									float fragment_unnamed_4760 = 1.0f / max(dot(float3(abs(fragment_unnamed_4005), abs(fragment_unnamed_4007), abs(fragment_unnamed_4009)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
									float fragment_unnamed_4765 = clamp((-0.0f) - (fragment_unnamed_4760 * fragment_unnamed_4009), 0.0f, 1.0f);
									float fragment_unnamed_4768 = (-0.0f) - fragment_unnamed_4765;
									float fragment_unnamed_4784 = exp2(max(mad(fragment_unnamed_4037, 6.0f, (-0.0f) - fragment_uniform_buffer_0[124u].z), 0.0f));
									uint fragment_unnamed_4797 = fragment_unnamed_4041 + 80u;
									uint fragment_unnamed_4805 = fragment_unnamed_4041 + 80u;
									float4 fragment_unnamed_4815 = _ReflectionAtlas.SampleLevel(S1, float3(mad(clamp(mad(mad(fragment_unnamed_4005, fragment_unnamed_4760, ((fragment_unnamed_4760 * fragment_unnamed_4005) >= 0.0f) ? fragment_unnamed_4765 : fragment_unnamed_4768), 0.5f, 0.5f), 0.0f, 1.0f), mad((-0.0f) - fragment_uniform_buffer_0[124u].x, fragment_unnamed_4784, fragment_uniform_buffer_2[fragment_unnamed_4797].x), mad(fragment_unnamed_4784 * fragment_uniform_buffer_0[124u].x, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_4805].z)), mad(clamp(mad(mad(fragment_unnamed_4007, fragment_unnamed_4760, ((fragment_unnamed_4760 * fragment_unnamed_4007) >= 0.0f) ? fragment_unnamed_4765 : fragment_unnamed_4768), 0.5f, 0.5f), 0.0f, 1.0f), mad((-0.0f) - fragment_uniform_buffer_0[124u].y, fragment_unnamed_4784, fragment_uniform_buffer_2[fragment_unnamed_4797].y), mad(fragment_unnamed_4784 * fragment_uniform_buffer_0[124u].y, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_4805].w)), fragment_unnamed_1413), fragment_unnamed_4038);
									fragment_unnamed_5452 = asfloat(1065353216u);
									fragment_unnamed_5454 = fragment_unnamed_4815.x;
									fragment_unnamed_5456 = fragment_unnamed_4815.y;
									fragment_unnamed_5458 = fragment_unnamed_4815.z;
								}
								float fragment_unnamed_5469 = mad(fragment_unnamed_4015, fragment_unnamed_5452, fragment_unnamed_1595);
								float fragment_unnamed_3247 = clamp(fragment_unnamed_5469, 0.0f, 1.0f);
								float fragment_unnamed_5474 = mad(fragment_unnamed_4015, fragment_unnamed_5452, (-0.0f) - clamp(((-0.0f) - fragment_unnamed_3247) + fragment_unnamed_5469, 0.0f, 1.0f));
								float fragment_unnamed_5478 = asfloat(fragment_unnamed_3112.w);
								fragment_unnamed_2701 = fragment_unnamed_3247;
								fragment_unnamed_2702 = mad(fragment_unnamed_5474 * (fragment_unnamed_853 * (fragment_unnamed_3133 * min(fragment_unnamed_5454, 65504.0f))), fragment_unnamed_5478, fragment_unnamed_1599);
								fragment_unnamed_2703 = mad(fragment_unnamed_5474 * (fragment_unnamed_854 * (fragment_unnamed_3133 * min(fragment_unnamed_5456, 65504.0f))), fragment_unnamed_5478, fragment_unnamed_1601);
								fragment_unnamed_2704 = mad(fragment_unnamed_5474 * (fragment_unnamed_855 * (fragment_unnamed_3133 * min(fragment_unnamed_5458, 65504.0f))), fragment_unnamed_5478, fragment_unnamed_1603);
							}
							else
							{
								fragment_unnamed_2701 = fragment_unnamed_1595;
								fragment_unnamed_2702 = fragment_unnamed_1599;
								fragment_unnamed_2703 = fragment_unnamed_1601;
								fragment_unnamed_2704 = fragment_unnamed_1603;
							}
							fragment_unnamed_1596 = fragment_unnamed_2701;
							fragment_unnamed_1600 = fragment_unnamed_2702;
							fragment_unnamed_1602 = fragment_unnamed_2703;
							fragment_unnamed_1604 = fragment_unnamed_2704;
							fragment_unnamed_1595 = fragment_unnamed_1596;
							fragment_unnamed_1597 = fragment_unnamed_1598;
							fragment_unnamed_1599 = fragment_unnamed_1600;
							fragment_unnamed_1601 = fragment_unnamed_1602;
							fragment_unnamed_1603 = fragment_unnamed_1604;
							continue;
						}
					}
					if (ladder_phi_33)
					{
						break;
					}
					break;
				}
				float fragment_unnamed_2274;
				float fragment_unnamed_2276;
				float fragment_unnamed_2278;
				if (asuint(fragment_uniform_buffer_0[116u]).x != 0u)
				{
					float fragment_unnamed_2275;
					float fragment_unnamed_2277;
					float fragment_unnamed_2279;
					if (fragment_unnamed_1595 < 1.0f)
					{
						float fragment_unnamed_2596 = asfloat((asuint(fragment_uniform_buffer_0[117u]).x != 0u) ? 1065353216u : 0u);
						float fragment_unnamed_2598 = mad((-0.0f) - fragment_unnamed_748, fragment_unnamed_748, 1.0f);
						float fragment_unnamed_2605 = clamp(mad(fragment_unnamed_2598, fragment_unnamed_2598, fragment_unnamed_2598 * (fragment_unnamed_764 * fragment_unnamed_764)), 0.0f, 1.0f) * mad(fragment_unnamed_748, fragment_unnamed_748, sqrt(fragment_unnamed_2598));
						float fragment_unnamed_2612 = mad(fragment_unnamed_2605, mad((-0.0f) - fragment_unnamed_459, fragment_unnamed_466, fragment_unnamed_871), fragment_unnamed_467);
						float fragment_unnamed_2613 = mad(fragment_unnamed_2605, mad((-0.0f) - fragment_unnamed_460, fragment_unnamed_466, fragment_unnamed_872), fragment_unnamed_468);
						float fragment_unnamed_2614 = mad(fragment_unnamed_2605, mad((-0.0f) - fragment_unnamed_461, fragment_unnamed_466, fragment_unnamed_873), fragment_unnamed_469);
						float fragment_unnamed_2615 = min(fragment_unnamed_858, 1.0f);
						float fragment_unnamed_2619 = min((fragment_unnamed_2615 * fragment_unnamed_2615) * mad(fragment_unnamed_2615, -2.0f, 3.0f), 1.0f);
						float fragment_unnamed_2626 = mad(fragment_unnamed_2619, ((-0.0f) - fragment_unnamed_2612) + fragment_unnamed_871, fragment_unnamed_2612);
						float fragment_unnamed_2627 = mad(fragment_unnamed_2619, ((-0.0f) - fragment_unnamed_2613) + fragment_unnamed_872, fragment_unnamed_2613);
						float fragment_unnamed_2628 = mad(fragment_unnamed_2619, ((-0.0f) - fragment_unnamed_2614) + fragment_unnamed_873, fragment_unnamed_2614);
						float fragment_unnamed_2636 = asfloat(0u);
						float4 fragment_unnamed_2639 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_2626, fragment_unnamed_2627, fragment_unnamed_2628, fragment_unnamed_2636), (mad((-0.0f) - fragment_unnamed_748, 0.699999988079071044921875f, 1.7000000476837158203125f) * fragment_unnamed_748) * 6.0f);
						float fragment_unnamed_2644 = min(fragment_unnamed_2639.x, 65504.0f);
						float fragment_unnamed_2646 = min(fragment_unnamed_2639.y, 65504.0f);
						float fragment_unnamed_2647 = min(fragment_unnamed_2639.z, 65504.0f);
						float fragment_unnamed_2837;
						float fragment_unnamed_2839;
						float fragment_unnamed_2841;
						if (asuint(fragment_uniform_buffer_0[84u]).x != 0u)
						{
							float fragment_unnamed_2759 = dot(float3(fragment_unnamed_2626, fragment_unnamed_2627, fragment_unnamed_2628), float3(fragment_uniform_buffer_0[83u].xyz));
							float fragment_unnamed_2775 = max(abs(fragment_unnamed_2759), 0.001000000047497451305389404296875f);
							float fragment_unnamed_2776 = 1.0f / fragment_unnamed_2775;
							float fragment_unnamed_2781 = min(mad(fragment_uniform_buffer_0[84u].w, fragment_unnamed_2759, fragment_unnamed_1214), fragment_unnamed_1214);
							float fragment_unnamed_2798 = min(max(fragment_unnamed_2776 * (((-0.0f) - fragment_unnamed_2781) + fragment_uniform_buffer_0[89u].y), 0.0f), fragment_uniform_buffer_0[84u].w);
							float fragment_unnamed_2832 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_2775 * ((-0.0f) - (((-0.0f) - fragment_unnamed_2798) + fragment_uniform_buffer_0[84u].w))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_2781 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_2776 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_2798) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_3779;
							float fragment_unnamed_3780;
							float fragment_unnamed_3781;
							if (fragment_uniform_buffer_0[86u].x == 1.0f)
							{
								float4 fragment_unnamed_3451 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_2626, fragment_unnamed_2627, fragment_unnamed_2628, fragment_unnamed_2636), mad((-0.0f) - fragment_uniform_buffer_0[87u].z, clamp((fragment_uniform_buffer_0[84u].w + ((-0.0f) - fragment_uniform_buffer_0[87u].x)) / (((-0.0f) - fragment_uniform_buffer_0[87u].x) + fragment_uniform_buffer_0[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_3779 = fragment_unnamed_3451.z * fragment_uniform_buffer_0[85u].z;
								fragment_unnamed_3780 = fragment_unnamed_3451.y * fragment_uniform_buffer_0[85u].y;
								fragment_unnamed_3781 = fragment_unnamed_3451.x * fragment_uniform_buffer_0[85u].x;
							}
							else
							{
								uint4 fragment_unnamed_3467 = asuint(fragment_uniform_buffer_0[85u]);
								fragment_unnamed_3779 = asfloat(fragment_unnamed_3467.z);
								fragment_unnamed_3780 = asfloat(fragment_unnamed_3467.y);
								fragment_unnamed_3781 = asfloat(fragment_unnamed_3467.x);
							}
							float fragment_unnamed_3786 = ((-0.0f) - fragment_unnamed_2832) + 1.0f;
							fragment_unnamed_2837 = mad(fragment_unnamed_2647, fragment_unnamed_2832, fragment_unnamed_3786 * ((fragment_uniform_buffer_0[88u].z / fragment_uniform_buffer_0[89u].x) * fragment_unnamed_3779));
							fragment_unnamed_2839 = mad(fragment_unnamed_2646, fragment_unnamed_2832, fragment_unnamed_3786 * ((fragment_uniform_buffer_0[88u].y / fragment_uniform_buffer_0[89u].x) * fragment_unnamed_3780));
							fragment_unnamed_2841 = mad(fragment_unnamed_2644, fragment_unnamed_2832, fragment_unnamed_3786 * ((fragment_uniform_buffer_0[88u].x / fragment_uniform_buffer_0[89u].x) * fragment_unnamed_3781));
						}
						else
						{
							fragment_unnamed_2837 = fragment_unnamed_2647;
							fragment_unnamed_2839 = fragment_unnamed_2646;
							fragment_unnamed_2841 = fragment_unnamed_2644;
						}
						float fragment_unnamed_2846 = fragment_unnamed_1595 + 1.0f;
						float fragment_unnamed_2852 = ((-0.0f) - clamp(fragment_unnamed_2846 + ((-0.0f) - clamp(fragment_unnamed_2846, 0.0f, 1.0f)), 0.0f, 1.0f)) + 1.0f;
						fragment_unnamed_2275 = mad(fragment_unnamed_2852 * (fragment_unnamed_2841 * fragment_unnamed_853), fragment_unnamed_2596, fragment_unnamed_1599);
						fragment_unnamed_2277 = mad(fragment_unnamed_2852 * (fragment_unnamed_2839 * fragment_unnamed_854), fragment_unnamed_2596, fragment_unnamed_1601);
						fragment_unnamed_2279 = mad(fragment_unnamed_2852 * (fragment_unnamed_2837 * fragment_unnamed_855), fragment_unnamed_2596, fragment_unnamed_1603);
					}
					else
					{
						fragment_unnamed_2275 = fragment_unnamed_1599;
						fragment_unnamed_2277 = fragment_unnamed_1601;
						fragment_unnamed_2279 = fragment_unnamed_1603;
					}
					fragment_unnamed_2274 = fragment_unnamed_2275;
					fragment_unnamed_2276 = fragment_unnamed_2277;
					fragment_unnamed_2278 = fragment_unnamed_2279;
				}
				else
				{
					fragment_unnamed_2274 = fragment_unnamed_1599;
					fragment_unnamed_2276 = fragment_unnamed_1601;
					fragment_unnamed_2278 = fragment_unnamed_1603;
				}
				float fragment_unnamed_2291 = ((-0.0f) - fragment_unnamed_1214) + fragment_uniform_buffer_0[89u].y;
				float fragment_unnamed_2300 = exp2((((-0.0f) - max(fragment_unnamed_1214 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f);
				uint fragment_unnamed_2306 = (fragment_uniform_buffer_0[218u].w == 1.0f) ? 4294967295u : 0u;
				float fragment_unnamed_2321 = fragment_input_5.x + ((-0.0f) - fragment_uniform_buffer_0[218u].x);
				float fragment_unnamed_2322 = fragment_input_5.y + ((-0.0f) - fragment_uniform_buffer_0[218u].y);
				float fragment_unnamed_2323 = fragment_input_5.z + ((-0.0f) - fragment_uniform_buffer_0[218u].z);
				float fragment_unnamed_2339 = fragment_input_5.x + ((-0.0f) - fragment_uniform_buffer_0[82u].x);
				float fragment_unnamed_2340 = fragment_input_5.y + ((-0.0f) - fragment_uniform_buffer_0[82u].y);
				float fragment_unnamed_2341 = fragment_input_5.z + ((-0.0f) - fragment_uniform_buffer_0[82u].z);
				float fragment_unnamed_2348 = fragment_uniform_buffer_0[82u].w + fragment_uniform_buffer_4[12u].w;
				float fragment_unnamed_2353 = mad((-0.0f) - fragment_unnamed_2348, fragment_unnamed_2348, dot(float3(fragment_unnamed_2339, fragment_unnamed_2340, fragment_unnamed_2341), float3(fragment_unnamed_2339, fragment_unnamed_2340, fragment_unnamed_2341)));
				float fragment_unnamed_2354 = dot(fragment_unnamed_424.xx, fragment_unnamed_424.xx);
				float fragment_unnamed_2358 = asfloat(0u);
				float fragment_unnamed_2657;
				float fragment_unnamed_2659;
				float fragment_unnamed_2661;
				float fragment_unnamed_2663;
				float fragment_unnamed_2665;
				float fragment_unnamed_2667;
				fragment_unnamed_2657 = fragment_unnamed_1260;
				fragment_unnamed_2659 = asfloat(fragment_unnamed_1270);
				fragment_unnamed_2661 = fragment_unnamed_1266;
				fragment_unnamed_2663 = fragment_unnamed_1268;
				fragment_unnamed_2665 = fragment_unnamed_1262;
				fragment_unnamed_2667 = fragment_unnamed_1264;
				float fragment_unnamed_2658;
				float fragment_unnamed_2660;
				float fragment_unnamed_2662;
				float fragment_unnamed_2664;
				float fragment_unnamed_2666;
				float fragment_unnamed_2668;
				for (float fragment_unnamed_2669 = fragment_unnamed_2358; !(asuint(fragment_unnamed_2669) >= asuint(fragment_uniform_buffer_0[114u]).x); fragment_unnamed_2657 = fragment_unnamed_2658, fragment_unnamed_2659 = fragment_unnamed_2660, fragment_unnamed_2661 = fragment_unnamed_2662, fragment_unnamed_2663 = fragment_unnamed_2664, fragment_unnamed_2665 = fragment_unnamed_2666, fragment_unnamed_2667 = fragment_unnamed_2668, fragment_unnamed_2669 = asfloat(asuint(fragment_unnamed_2669) + 1u))
				{
					float frontier_phi_62_pred;
					float frontier_phi_62_pred_1;
					float frontier_phi_62_pred_2;
					float frontier_phi_62_pred_3;
					float frontier_phi_62_pred_4;
					float frontier_phi_62_pred_5;
					if ((fragment_unnamed_475 & T6.Load((asuint(fragment_unnamed_2669) * 44u) + 3u).x) != 0u)
					{
						uint fragment_unnamed_3492 = (asuint(fragment_unnamed_2669) * 44u) + 4u;
						uint4 fragment_unnamed_3504 = uint4(T6.Load(fragment_unnamed_3492).x, T6.Load(fragment_unnamed_3492 + 1u).x, T6.Load(fragment_unnamed_3492 + 2u).x, T6.Load(fragment_unnamed_3492 + 3u).x);
						float fragment_unnamed_3506 = asfloat(fragment_unnamed_3504.x);
						float fragment_unnamed_3508 = asfloat(fragment_unnamed_3504.y);
						float fragment_unnamed_3510 = asfloat(fragment_unnamed_3504.z);
						uint fragment_unnamed_3511 = fragment_unnamed_3504.w;
						uint fragment_unnamed_3514 = (asuint(fragment_unnamed_2669) * 44u) + 36u;
						uint3 fragment_unnamed_3523 = uint3(T6.Load(fragment_unnamed_3514).x, T6.Load(fragment_unnamed_3514 + 1u).x, T6.Load(fragment_unnamed_3514 + 2u).x);
						float fragment_unnamed_3525 = asfloat(fragment_unnamed_3523.x);
						float fragment_unnamed_3527 = asfloat(fragment_unnamed_3523.y);
						float fragment_unnamed_3535 = dot(float3(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469), float3((-0.0f) - fragment_unnamed_3506, (-0.0f) - fragment_unnamed_3508, (-0.0f) - fragment_unnamed_3510));
						float fragment_unnamed_4682;
						float fragment_unnamed_4684;
						float fragment_unnamed_4686;
						float fragment_unnamed_4688;
						float fragment_unnamed_4690;
						float fragment_unnamed_4692;
						if ((((0.0f < asfloat(fragment_unnamed_3523.z)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_3535) ? 4294967295u : 0u)) != 0u)
						{
							uint fragment_unnamed_3883 = (asuint(fragment_unnamed_2669) * 44u) + 12u;
							uint4 fragment_unnamed_3895 = uint4(T6.Load(fragment_unnamed_3883).x, T6.Load(fragment_unnamed_3883 + 1u).x, T6.Load(fragment_unnamed_3883 + 2u).x, T6.Load(fragment_unnamed_3883 + 3u).x);
							float fragment_unnamed_3897 = asfloat(fragment_unnamed_3895.x);
							float fragment_unnamed_3899 = asfloat(fragment_unnamed_3895.y);
							float fragment_unnamed_3901 = asfloat(fragment_unnamed_3895.z);
							uint fragment_unnamed_3905 = (asuint(fragment_unnamed_2669) * 44u) + 16u;
							uint3 fragment_unnamed_3914 = uint3(T6.Load(fragment_unnamed_3905).x, T6.Load(fragment_unnamed_3905 + 1u).x, T6.Load(fragment_unnamed_3905 + 2u).x);
							float fragment_unnamed_3916 = asfloat(fragment_unnamed_3914.x);
							float fragment_unnamed_3918 = asfloat(fragment_unnamed_3914.y);
							float fragment_unnamed_3920 = asfloat(fragment_unnamed_3914.z);
							uint fragment_unnamed_3923 = (asuint(fragment_unnamed_2669) * 44u) + 20u;
							uint3 fragment_unnamed_3932 = uint3(T6.Load(fragment_unnamed_3923).x, T6.Load(fragment_unnamed_3923 + 1u).x, T6.Load(fragment_unnamed_3923 + 2u).x);
							float fragment_unnamed_3934 = asfloat(fragment_unnamed_3932.x);
							float fragment_unnamed_3936 = asfloat(fragment_unnamed_3932.y);
							float fragment_unnamed_3938 = asfloat(fragment_unnamed_3932.z);
							uint fragment_unnamed_3941 = (asuint(fragment_unnamed_2669) * 44u) + 24u;
							uint4 fragment_unnamed_3953 = uint4(T6.Load(fragment_unnamed_3941).x, T6.Load(fragment_unnamed_3941 + 1u).x, T6.Load(fragment_unnamed_3941 + 2u).x, T6.Load(fragment_unnamed_3941 + 3u).x);
							float fragment_unnamed_3955 = asfloat(fragment_unnamed_3953.x);
							float fragment_unnamed_3957 = asfloat(fragment_unnamed_3953.y);
							float fragment_unnamed_3959 = asfloat(fragment_unnamed_3953.z);
							float fragment_unnamed_3961 = asfloat(fragment_unnamed_3953.w);
							float fragment_unnamed_3967 = asfloat(T6.Load((asuint(fragment_unnamed_2669) * 44u) + 40u).x);
							float fragment_unnamed_3980 = 1.0f / max(dot(float3((-0.0f) - fragment_unnamed_3506, (-0.0f) - fragment_unnamed_3508, (-0.0f) - fragment_unnamed_3510), float3(fragment_uniform_buffer_0[83u].xyz)), 0.001000000047497451305389404296875f);
							float fragment_unnamed_3993 = exp2((mad(fragment_unnamed_2300, fragment_unnamed_3980 * fragment_uniform_buffer_0[90u].y, max(fragment_unnamed_2291 * fragment_unnamed_3980, 0.0f)) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_4672;
							float fragment_unnamed_4673;
							float fragment_unnamed_4674;
							if (fragment_unnamed_3511 != 0u)
							{
								uint fragment_unnamed_4557 = asuint(fragment_unnamed_2669) * 44u;
								uint3 fragment_unnamed_4566 = uint3(T6.Load(fragment_unnamed_4557).x, T6.Load(fragment_unnamed_4557 + 1u).x, T6.Load(fragment_unnamed_4557 + 2u).x);
								uint fragment_unnamed_4575 = (asuint(fragment_unnamed_2669) * 44u) + 8u;
								uint4 fragment_unnamed_4587 = uint4(T6.Load(fragment_unnamed_4575).x, T6.Load(fragment_unnamed_4575 + 1u).x, T6.Load(fragment_unnamed_4575 + 2u).x, T6.Load(fragment_unnamed_4575 + 3u).x);
								float fragment_unnamed_4589 = asfloat(fragment_unnamed_4587.x);
								float fragment_unnamed_4591 = asfloat(fragment_unnamed_4587.y);
								float fragment_unnamed_4605 = ((-0.0f) - asfloat(fragment_unnamed_4566.x)) + fragment_input_5.x;
								float fragment_unnamed_4606 = ((-0.0f) - asfloat(fragment_unnamed_4566.y)) + fragment_input_5.y;
								float fragment_unnamed_4607 = ((-0.0f) - asfloat(fragment_unnamed_4566.z)) + fragment_input_5.z;
								float fragment_unnamed_4614 = mad(dot(float3(fragment_unnamed_4605, fragment_unnamed_4606, fragment_unnamed_4607), float3(fragment_unnamed_3897, fragment_unnamed_3899, fragment_unnamed_3901)), 0.5f, 0.5f);
								float fragment_unnamed_4615 = mad(dot(float3(fragment_unnamed_4605, fragment_unnamed_4606, fragment_unnamed_4607), float3(fragment_unnamed_3916, fragment_unnamed_3918, fragment_unnamed_3920)), 0.5f, 0.5f);
								bool fragment_unnamed_4616 = fragment_unnamed_3511 == 2u;
								float fragment_unnamed_4632 = 1.0f / (fragment_unnamed_4589 + fragment_uniform_buffer_0[123u].y);
								float fragment_unnamed_4633 = 1.0f / (fragment_unnamed_4591 + fragment_uniform_buffer_0[123u].y);
								float fragment_unnamed_4645 = fragment_unnamed_4589 * fragment_uniform_buffer_0[123u].x;
								float fragment_unnamed_4646 = fragment_unnamed_4591 * fragment_uniform_buffer_0[123u].x;
								float fragment_unnamed_4649 = fragment_unnamed_1225 / (fragment_unnamed_4645 + fragment_unnamed_4645);
								float fragment_unnamed_4650 = fragment_unnamed_1225 / (fragment_unnamed_4646 + fragment_unnamed_4646);
								float4 fragment_unnamed_4664 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_4649) + 1.0f, max(fragment_unnamed_4649, mad(asfloat(fragment_unnamed_4616 ? asuint(frac(fragment_unnamed_4614)) : asuint(fragment_unnamed_4614)), fragment_unnamed_4589 * fragment_unnamed_4632, mad((-0.0f) - fragment_unnamed_4632, fragment_unnamed_4589, 1.0f) * 0.5f))), fragment_unnamed_4589, asfloat(fragment_unnamed_4587.z)), mad(min(((-0.0f) - fragment_unnamed_4650) + 1.0f, max(fragment_unnamed_4650, mad(asfloat(fragment_unnamed_4616 ? asuint(frac(fragment_unnamed_4615)) : asuint(fragment_unnamed_4615)), fragment_unnamed_4591 * fragment_unnamed_4633, mad((-0.0f) - fragment_unnamed_4633, fragment_unnamed_4591, 1.0f) * 0.5f))), fragment_unnamed_4591, asfloat(fragment_unnamed_4587.w))), 0.0f);
								fragment_unnamed_4672 = fragment_unnamed_3934 * fragment_unnamed_4664.x;
								fragment_unnamed_4673 = fragment_unnamed_3936 * fragment_unnamed_4664.y;
								fragment_unnamed_4674 = fragment_unnamed_3938 * fragment_unnamed_4664.z;
							}
							else
							{
								fragment_unnamed_4672 = fragment_unnamed_3934;
								fragment_unnamed_4673 = fragment_unnamed_3936;
								fragment_unnamed_4674 = fragment_unnamed_3938;
							}
							uint fragment_unnamed_4679 = (int(fragment_unnamed_3895.w) >= int(0u)) ? 4294967295u : 0u;
							float fragment_unnamed_6096;
							float fragment_unnamed_6097;
							float fragment_unnamed_6098;
							if ((fragment_unnamed_2306 & fragment_unnamed_4679) != 0u)
							{
								float fragment_unnamed_5218 = rsqrt(dot(float3(fragment_unnamed_3897, fragment_unnamed_3899, fragment_unnamed_3901), float3(fragment_unnamed_3897, fragment_unnamed_3899, fragment_unnamed_3901)));
								float fragment_unnamed_5222 = dot(float3(fragment_unnamed_2321, fragment_unnamed_2322, fragment_unnamed_2323), float3(fragment_unnamed_5218 * fragment_unnamed_3897, fragment_unnamed_5218 * fragment_unnamed_3899, fragment_unnamed_5218 * fragment_unnamed_3901));
								float fragment_unnamed_5232 = clamp(fragment_unnamed_5222 / fragment_uniform_buffer_0[217u].x, 0.0f, 1.0f);
								float fragment_unnamed_5236 = rsqrt(dot(float3(fragment_unnamed_3916, fragment_unnamed_3918, fragment_unnamed_3920), float3(fragment_unnamed_3916, fragment_unnamed_3918, fragment_unnamed_3920)));
								float fragment_unnamed_5240 = dot(float3(fragment_unnamed_2321, fragment_unnamed_2322, fragment_unnamed_2323), float3(fragment_unnamed_5236 * fragment_unnamed_3916, fragment_unnamed_5236 * fragment_unnamed_3918, fragment_unnamed_5236 * fragment_unnamed_3920));
								float fragment_unnamed_5249 = clamp(fragment_unnamed_5240 / fragment_uniform_buffer_0[217u].y, 0.0f, 1.0f);
								float fragment_unnamed_5250 = dot(float3(fragment_unnamed_3506, fragment_unnamed_3508, fragment_unnamed_3510), float3(fragment_unnamed_3506, fragment_unnamed_3508, fragment_unnamed_3510));
								float fragment_unnamed_5253 = dot(float3(fragment_unnamed_3506, fragment_unnamed_3508, fragment_unnamed_3510), float3(fragment_unnamed_2339, fragment_unnamed_2340, fragment_unnamed_2341));
								float fragment_unnamed_5256 = fragment_unnamed_5253 + fragment_unnamed_5253;
								float4 fragment_unnamed_5272 = _VolumetricCloudsShadowsTexture.SampleLevel(S0, float2(fragment_unnamed_5232, fragment_unnamed_5249), 0.0f);
								float fragment_unnamed_5274 = fragment_unnamed_5272.x;
								float fragment_unnamed_5275 = fragment_unnamed_5272.y;
								float fragment_unnamed_5306 = asfloat((((((fragment_unnamed_5249 != 1.0f) ? 4294967295u : 0u) & ((fragment_unnamed_5232 != 1.0f) ? 4294967295u : 0u)) & (((clamp(fragment_unnamed_5240 / fragment_uniform_buffer_0[217u].y, 0.0f, 1.0f) != 0.0f) ? 4294967295u : 0u) & ((clamp(fragment_unnamed_5222 / fragment_uniform_buffer_0[217u].x, 0.0f, 1.0f) != 0.0f) ? 4294967295u : 0u))) != 0u) ? ((fragment_unnamed_5275 != 1.0f) ? asuint(mad(clamp(((mad((-0.0f) - float(int(-((0.0f < fragment_unnamed_5250) ? 4294967295u : 0u))), sqrt(mad(fragment_unnamed_5256, fragment_unnamed_5256, (-0.0f) - ((fragment_unnamed_2353 * fragment_unnamed_5250) * 4.0f))), (-0.0f) - fragment_unnamed_5256) / (fragment_unnamed_5250 + fragment_unnamed_5250)) + ((-0.0f) - fragment_unnamed_5274)) / (((-0.0f) - fragment_unnamed_5274) + fragment_unnamed_5272.z), 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_5275) + 1.0f, fragment_unnamed_5275)) : 1065353216u) : asuint(fragment_uniform_buffer_0[217u]).w);
								fragment_unnamed_6096 = fragment_unnamed_1119 * fragment_unnamed_5306;
								fragment_unnamed_6097 = fragment_unnamed_1115 * fragment_unnamed_5306;
								fragment_unnamed_6098 = fragment_unnamed_1117 * fragment_unnamed_5306;
							}
							else
							{
								fragment_unnamed_6096 = fragment_unnamed_1119;
								fragment_unnamed_6097 = fragment_unnamed_1115;
								fragment_unnamed_6098 = fragment_unnamed_1117;
							}
							bool fragment_unnamed_6108 = (((0.0f < fragment_unnamed_3961) ? 4294967295u : 0u) & fragment_unnamed_4679) != 0u;
							float fragment_unnamed_6113 = asfloat(fragment_unnamed_6108 ? asuint(mad(fragment_unnamed_3961, fragment_unnamed_6096 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6115 = asfloat(fragment_unnamed_6108 ? asuint(mad(fragment_unnamed_3961, fragment_unnamed_6097 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6117 = asfloat(fragment_unnamed_6108 ? asuint(mad(fragment_unnamed_3961, fragment_unnamed_6098 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6130 = asfloat((fragment_unnamed_3535 >= 0.0f) ? asuint(mad(fragment_uniform_buffer_0[121u].x, clamp((fragment_unnamed_2354 + fragment_unnamed_3535) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6131 = fragment_unnamed_6130 * fragment_unnamed_6113;
							float fragment_unnamed_6132 = fragment_unnamed_6130 * fragment_unnamed_6115;
							float fragment_unnamed_6133 = fragment_unnamed_6130 * fragment_unnamed_6117;
							float fragment_unnamed_6137 = ((-0.0f) - fragment_unnamed_3955) + 1.0f;
							float fragment_unnamed_6138 = ((-0.0f) - fragment_unnamed_3957) + 1.0f;
							float fragment_unnamed_6139 = ((-0.0f) - fragment_unnamed_3959) + 1.0f;
							float fragment_unnamed_6155 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6113, fragment_unnamed_6130, 1.0f), fragment_unnamed_6137, 1.0f);
							float fragment_unnamed_6156 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6115, fragment_unnamed_6130, 1.0f), fragment_unnamed_6138, 1.0f);
							float fragment_unnamed_6157 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6117, fragment_unnamed_6130, 1.0f), fragment_unnamed_6139, 1.0f);
							float fragment_unnamed_6173 = mad(fragment_unnamed_3967, ((-0.0f) - fragment_unnamed_6155) + mad(fragment_unnamed_6131 * (fragment_unnamed_6131 * fragment_unnamed_6131), fragment_unnamed_6137, fragment_unnamed_3955 * fragment_unnamed_6131), fragment_unnamed_6155) * (fragment_unnamed_3993 * fragment_unnamed_4672);
							float fragment_unnamed_6174 = mad(fragment_unnamed_3967, ((-0.0f) - fragment_unnamed_6156) + mad(fragment_unnamed_6132 * (fragment_unnamed_6132 * fragment_unnamed_6132), fragment_unnamed_6138, fragment_unnamed_3957 * fragment_unnamed_6132), fragment_unnamed_6156) * (fragment_unnamed_3993 * fragment_unnamed_4673);
							float fragment_unnamed_6175 = mad(fragment_unnamed_3967, ((-0.0f) - fragment_unnamed_6157) + mad(fragment_unnamed_6133 * (fragment_unnamed_6133 * fragment_unnamed_6133), fragment_unnamed_6139, fragment_unnamed_3959 * fragment_unnamed_6133), fragment_unnamed_6157) * (fragment_unnamed_3993 * fragment_unnamed_4674);
							float fragment_unnamed_4683;
							float fragment_unnamed_4685;
							float fragment_unnamed_4687;
							float fragment_unnamed_4689;
							float fragment_unnamed_4691;
							float fragment_unnamed_4693;
							if (0.0f < max(fragment_unnamed_6175, max(fragment_unnamed_6174, fragment_unnamed_6173)))
							{
								float fragment_unnamed_6546 = max(fragment_unnamed_843, asfloat(T6.Load((asuint(fragment_unnamed_2669) * 44u) + 30u).x));
								float fragment_unnamed_6547 = clamp(fragment_unnamed_3535, 0.0f, 1.0f);
								float fragment_unnamed_6551 = dot(float3((-0.0f) - fragment_unnamed_3506, (-0.0f) - fragment_unnamed_3508, (-0.0f) - fragment_unnamed_3510), float3(fragment_unnamed_346, fragment_unnamed_347, fragment_unnamed_348));
								float fragment_unnamed_6556 = rsqrt(max(mad(fragment_unnamed_6551, 2.0f, 2.0f), 5.9604644775390625e-08f));
								float fragment_unnamed_6559 = clamp(fragment_unnamed_6556 * (fragment_unnamed_761 + fragment_unnamed_3535), 0.0f, 1.0f);
								float fragment_unnamed_6563 = ((-0.0f) - clamp(mad(fragment_unnamed_6556, fragment_unnamed_6551, fragment_unnamed_6556), 0.0f, 1.0f)) + 1.0f;
								float fragment_unnamed_6564 = fragment_unnamed_6563 * fragment_unnamed_6563;
								float fragment_unnamed_6565 = fragment_unnamed_6564 * fragment_unnamed_6564;
								float fragment_unnamed_6568 = mad((-0.0f) - fragment_unnamed_6565, fragment_unnamed_6563, 1.0f);
								float fragment_unnamed_6569 = fragment_unnamed_842 * (fragment_unnamed_6563 * fragment_unnamed_6565);
								float fragment_unnamed_6573 = fragment_unnamed_6546 * fragment_unnamed_6546;
								float fragment_unnamed_6576 = mad(mad(fragment_unnamed_6559, fragment_unnamed_6573, (-0.0f) - fragment_unnamed_6559), fragment_unnamed_6559, 1.0f);
								float fragment_unnamed_6591 = (fragment_unnamed_6573 * 0.15915493667125701904296875f) / max((fragment_unnamed_6576 * fragment_unnamed_6576) * mad(abs(fragment_unnamed_3535), fragment_unnamed_862, fragment_unnamed_764 * sqrt(mad(mad((-0.0f) - abs(fragment_unnamed_3535), fragment_unnamed_6573, abs(fragment_unnamed_3535)), abs(fragment_unnamed_3535), fragment_unnamed_6573))), 1.1754943508222875079687365372222e-38f);
								float fragment_unnamed_6598 = ((-0.0f) - abs(fragment_unnamed_3535)) + 1.0f;
								float fragment_unnamed_6599 = fragment_unnamed_6598 * fragment_unnamed_6598;
								float fragment_unnamed_6602 = mad(fragment_unnamed_748, fragment_unnamed_6551, fragment_unnamed_748) + (-0.5f);
								float fragment_unnamed_6607 = ((mad(fragment_unnamed_6602, fragment_unnamed_1227, 1.0f) * mad(fragment_unnamed_6602, fragment_unnamed_6598 * (fragment_unnamed_6599 * fragment_unnamed_6599), 1.0f)) * fragment_unnamed_6547) * 0.307334959506988525390625f;
								fragment_unnamed_4683 = fragment_unnamed_3527 * (fragment_unnamed_6173 * (fragment_unnamed_6547 * (fragment_unnamed_6591 * mad(fragment_unnamed_757, fragment_unnamed_6568, fragment_unnamed_6569))));
								fragment_unnamed_4685 = fragment_unnamed_3527 * (fragment_unnamed_6174 * (fragment_unnamed_6547 * (fragment_unnamed_6591 * mad(fragment_unnamed_759, fragment_unnamed_6568, fragment_unnamed_6569))));
								fragment_unnamed_4687 = fragment_unnamed_3527 * (fragment_unnamed_6175 * (fragment_unnamed_6547 * (fragment_unnamed_6591 * mad(fragment_unnamed_760, fragment_unnamed_6568, fragment_unnamed_6569))));
								fragment_unnamed_4689 = fragment_unnamed_3525 * (fragment_unnamed_6173 * fragment_unnamed_6607);
								fragment_unnamed_4691 = fragment_unnamed_3525 * (fragment_unnamed_6174 * fragment_unnamed_6607);
								fragment_unnamed_4693 = fragment_unnamed_3525 * (fragment_unnamed_6175 * fragment_unnamed_6607);
							}
							else
							{
								fragment_unnamed_4683 = asfloat(0u);
								fragment_unnamed_4685 = asfloat(0u);
								fragment_unnamed_4687 = asfloat(0u);
								fragment_unnamed_4689 = asfloat(0u);
								fragment_unnamed_4691 = asfloat(0u);
								fragment_unnamed_4693 = asfloat(0u);
							}
							fragment_unnamed_4682 = fragment_unnamed_4683;
							fragment_unnamed_4684 = fragment_unnamed_4685;
							fragment_unnamed_4686 = fragment_unnamed_4687;
							fragment_unnamed_4688 = fragment_unnamed_4689;
							fragment_unnamed_4690 = fragment_unnamed_4691;
							fragment_unnamed_4692 = fragment_unnamed_4693;
						}
						else
						{
							fragment_unnamed_4682 = asfloat(0u);
							fragment_unnamed_4684 = asfloat(0u);
							fragment_unnamed_4686 = asfloat(0u);
							fragment_unnamed_4688 = asfloat(0u);
							fragment_unnamed_4690 = asfloat(0u);
							fragment_unnamed_4692 = asfloat(0u);
						}
						frontier_phi_62_pred = fragment_unnamed_2667 + fragment_unnamed_4692;
						frontier_phi_62_pred_1 = fragment_unnamed_2659 + fragment_unnamed_4682;
						frontier_phi_62_pred_2 = fragment_unnamed_2657 + fragment_unnamed_4688;
						frontier_phi_62_pred_3 = fragment_unnamed_2663 + fragment_unnamed_4686;
						frontier_phi_62_pred_4 = fragment_unnamed_2665 + fragment_unnamed_4690;
						frontier_phi_62_pred_5 = fragment_unnamed_2661 + fragment_unnamed_4684;
					}
					else
					{
						frontier_phi_62_pred = fragment_unnamed_2667;
						frontier_phi_62_pred_1 = fragment_unnamed_2659;
						frontier_phi_62_pred_2 = fragment_unnamed_2657;
						frontier_phi_62_pred_3 = fragment_unnamed_2663;
						frontier_phi_62_pred_4 = fragment_unnamed_2665;
						frontier_phi_62_pred_5 = fragment_unnamed_2661;
					}
					fragment_unnamed_2668 = frontier_phi_62_pred;
					fragment_unnamed_2660 = frontier_phi_62_pred_1;
					fragment_unnamed_2658 = frontier_phi_62_pred_2;
					fragment_unnamed_2664 = frontier_phi_62_pred_3;
					fragment_unnamed_2666 = frontier_phi_62_pred_4;
					fragment_unnamed_2662 = frontier_phi_62_pred_5;
				}
				uint4 fragment_unnamed_2856 = T4.Load(((((fragment_unnamed_1184 + fragment_unnamed_1151) * fragment_unnamed_1347) + fragment_unnamed_288) * fragment_unnamed_1355) + fragment_unnamed_286);
				uint fragment_unnamed_2857 = fragment_unnamed_2856.x;
				uint fragment_unnamed_2858 = fragment_unnamed_2857 & 67108863u;
				uint fragment_unnamed_2859 = fragment_unnamed_2857 >> 26u;
				float fragment_unnamed_2861 = mad((-0.0f) - fragment_unnamed_888, fragment_unnamed_886, fragment_unnamed_885);
				float fragment_unnamed_2862 = fragment_unnamed_2861 * fragment_unnamed_887;
				float fragment_unnamed_2868 = clamp((((-0.0f) - fragment_unnamed_748) + 0.300000011920928955078125f) * 3.3333332538604736328125f, 0.0f, 1.0f);
				float fragment_unnamed_2870 = mad((-0.0f) - fragment_unnamed_894, fragment_unnamed_892, fragment_unnamed_891);
				float fragment_unnamed_2871 = fragment_unnamed_2870 * fragment_unnamed_893;
				float fragment_unnamed_2872 = asfloat(fragment_unnamed_898 ? asuint(fragment_unnamed_902 * fragment_unnamed_908) : asuint(fragment_unnamed_925));
				float fragment_unnamed_2873 = asfloat(fragment_unnamed_898 ? asuint(fragment_unnamed_909) : asuint(fragment_unnamed_926));
				float fragment_unnamed_2874 = asfloat(fragment_unnamed_898 ? asuint(fragment_unnamed_468) : asuint(mad(fragment_unnamed_467, fragment_unnamed_925, (-0.0f) - (fragment_unnamed_468 * fragment_unnamed_924))));
				float fragment_unnamed_2875 = asfloat(1065353216u);
				float fragment_unnamed_2876 = asfloat(1065353216u);
				float fragment_unnamed_2877 = asfloat(1065353216u);
				float fragment_unnamed_2878 = asfloat(0u);
				float fragment_unnamed_3474;
				float fragment_unnamed_3476;
				float fragment_unnamed_3478;
				float fragment_unnamed_3480;
				float fragment_unnamed_3482;
				float fragment_unnamed_3484;
				float fragment_unnamed_3486;
				for (;;)
				{
					fragment_unnamed_3474 = fragment_unnamed_2657;
					fragment_unnamed_3476 = fragment_unnamed_2665;
					fragment_unnamed_3478 = fragment_unnamed_2667;
					fragment_unnamed_3480 = fragment_unnamed_2659;
					fragment_unnamed_3482 = fragment_unnamed_2661;
					fragment_unnamed_3484 = fragment_unnamed_2663;
					fragment_unnamed_3486 = fragment_unnamed_2878;
					float fragment_unnamed_3487;
					float fragment_unnamed_3475;
					float fragment_unnamed_3477;
					float fragment_unnamed_3479;
					float fragment_unnamed_3481;
					float fragment_unnamed_3483;
					float fragment_unnamed_3485;
					bool ladder_phi_84;
					for (;;)
					{
						if (asuint(fragment_unnamed_3486) >= fragment_unnamed_2859)
						{
							ladder_phi_84 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_3876 = asuint(fragment_unnamed_3486);
							uint4 fragment_unnamed_3878 = T3.Load(fragment_unnamed_2858 + fragment_unnamed_3876);
							uint fragment_unnamed_3879 = fragment_unnamed_3878.x;
							if (fragment_unnamed_3879 == 4294967295u)
							{
								ladder_phi_84 = false;
								break;
							}
							uint fragment_unnamed_4532 = fragment_unnamed_3879 * 56u;
							uint4 fragment_unnamed_4544 = uint4(T7.Load(fragment_unnamed_4532).x, T7.Load(fragment_unnamed_4532 + 1u).x, T7.Load(fragment_unnamed_4532 + 2u).x, T7.Load(fragment_unnamed_4532 + 3u).x);
							fragment_unnamed_3487 = asfloat(asuint(fragment_unnamed_3486) + 1u);
							if (!((fragment_unnamed_475 & fragment_unnamed_4544.w) != 0u))
							{
								fragment_unnamed_3475 = fragment_unnamed_3474;
								fragment_unnamed_3477 = fragment_unnamed_3476;
								fragment_unnamed_3479 = fragment_unnamed_3478;
								fragment_unnamed_3481 = fragment_unnamed_3480;
								fragment_unnamed_3483 = fragment_unnamed_3482;
								fragment_unnamed_3485 = fragment_unnamed_3484;
								fragment_unnamed_3474 = fragment_unnamed_3475;
								fragment_unnamed_3476 = fragment_unnamed_3477;
								fragment_unnamed_3478 = fragment_unnamed_3479;
								fragment_unnamed_3480 = fragment_unnamed_3481;
								fragment_unnamed_3482 = fragment_unnamed_3483;
								fragment_unnamed_3484 = fragment_unnamed_3485;
								fragment_unnamed_3486 = fragment_unnamed_3487;
								continue;
							}
							uint fragment_unnamed_5018 = (fragment_unnamed_3879 * 56u) + 8u;
							uint3 fragment_unnamed_5027 = uint3(T7.Load(fragment_unnamed_5018).x, T7.Load(fragment_unnamed_5018 + 1u).x, T7.Load(fragment_unnamed_5018 + 2u).x);
							uint fragment_unnamed_5035 = (fragment_unnamed_3879 * 56u) + 12u;
							uint4 fragment_unnamed_5047 = uint4(T7.Load(fragment_unnamed_5035).x, T7.Load(fragment_unnamed_5035 + 1u).x, T7.Load(fragment_unnamed_5035 + 2u).x, T7.Load(fragment_unnamed_5035 + 3u).x);
							float fragment_unnamed_5050 = asfloat(fragment_unnamed_5047.y);
							float fragment_unnamed_5052 = asfloat(fragment_unnamed_5047.z);
							float fragment_unnamed_5054 = asfloat(fragment_unnamed_5047.w);
							uint fragment_unnamed_5056 = (fragment_unnamed_3879 * 56u) + 18u;
							uint4 fragment_unnamed_5068 = uint4(T7.Load(fragment_unnamed_5056).x, T7.Load(fragment_unnamed_5056 + 1u).x, T7.Load(fragment_unnamed_5056 + 2u).x, T7.Load(fragment_unnamed_5056 + 3u).x);
							uint fragment_unnamed_5069 = fragment_unnamed_5068.x;
							uint fragment_unnamed_5070 = fragment_unnamed_5068.y;
							uint fragment_unnamed_5074 = (fragment_unnamed_3879 * 56u) + 22u;
							uint4 fragment_unnamed_5086 = uint4(T7.Load(fragment_unnamed_5074).x, T7.Load(fragment_unnamed_5074 + 1u).x, T7.Load(fragment_unnamed_5074 + 2u).x, T7.Load(fragment_unnamed_5074 + 3u).x);
							float fragment_unnamed_5088 = asfloat(fragment_unnamed_5086.z);
							float fragment_unnamed_5090 = asfloat(fragment_unnamed_5086.w);
							uint fragment_unnamed_5094 = (fragment_unnamed_3879 * 56u) + 26u;
							uint4 fragment_unnamed_5106 = uint4(T7.Load(fragment_unnamed_5094).x, T7.Load(fragment_unnamed_5094 + 1u).x, T7.Load(fragment_unnamed_5094 + 2u).x, T7.Load(fragment_unnamed_5094 + 3u).x);
							uint fragment_unnamed_5107 = fragment_unnamed_5106.x;
							float fragment_unnamed_5111 = asfloat(fragment_unnamed_5106.z);
							float fragment_unnamed_5113 = asfloat(fragment_unnamed_5106.w);
							uint fragment_unnamed_5115 = (fragment_unnamed_3879 * 56u) + 30u;
							uint4 fragment_unnamed_5127 = uint4(T7.Load(fragment_unnamed_5115).x, T7.Load(fragment_unnamed_5115 + 1u).x, T7.Load(fragment_unnamed_5115 + 2u).x, T7.Load(fragment_unnamed_5115 + 3u).x);
							float fragment_unnamed_5129 = asfloat(fragment_unnamed_5127.x);
							float fragment_unnamed_5131 = asfloat(fragment_unnamed_5127.y);
							uint fragment_unnamed_5135 = (fragment_unnamed_3879 * 56u) + 44u;
							uint2 fragment_unnamed_5141 = uint2(T7.Load(fragment_unnamed_5135).x, T7.Load(fragment_unnamed_5135 + 1u).x);
							float fragment_unnamed_5143 = asfloat(fragment_unnamed_5141.x);
							float fragment_unnamed_5145 = asfloat(fragment_unnamed_5141.y);
							bool fragment_unnamed_5146 = fragment_unnamed_5047.x == 6u;
							uint fragment_unnamed_5147 = fragment_unnamed_5146 ? 4294967295u : 0u;
							float fragment_unnamed_5157 = asfloat(fragment_unnamed_4544.x) + ((-0.0f) - fragment_input_5.x);
							float fragment_unnamed_5158 = asfloat(fragment_unnamed_4544.y) + ((-0.0f) - fragment_input_5.y);
							float fragment_unnamed_5159 = asfloat(fragment_unnamed_4544.z) + ((-0.0f) - fragment_input_5.z);
							float fragment_unnamed_5160 = fragment_unnamed_5143 * 0.5f;
							float fragment_unnamed_5161 = fragment_unnamed_5145 * 0.5f;
							float fragment_unnamed_5162 = dot(float3(fragment_unnamed_5157, fragment_unnamed_5158, fragment_unnamed_5159), float3(fragment_unnamed_5050, fragment_unnamed_5052, fragment_unnamed_5054));
							float fragment_unnamed_5168 = max(mad((-0.0f) - fragment_unnamed_5143, 0.5f, abs(fragment_unnamed_5162)), 0.0f);
							float fragment_unnamed_5169 = asfloat(fragment_unnamed_5068.z);
							float fragment_unnamed_5170 = asfloat(fragment_unnamed_5068.w);
							float fragment_unnamed_5171 = asfloat(fragment_unnamed_5086.x);
							float fragment_unnamed_5172 = dot(float3(fragment_unnamed_5157, fragment_unnamed_5158, fragment_unnamed_5159), float3(fragment_unnamed_5169, fragment_unnamed_5170, fragment_unnamed_5171));
							float fragment_unnamed_5178 = max(mad((-0.0f) - fragment_unnamed_5145, 0.5f, abs(fragment_unnamed_5172)), 0.0f);
							float fragment_unnamed_5190 = asfloat(fragment_unnamed_5086.y) * mad(fragment_unnamed_5178, fragment_unnamed_5178, mad(fragment_unnamed_5168, fragment_unnamed_5168, max(mad((-0.0f) - fragment_unnamed_5172, fragment_unnamed_5172, mad((-0.0f) - fragment_unnamed_5162, fragment_unnamed_5162, dot(float3(fragment_unnamed_5157, fragment_unnamed_5158, fragment_unnamed_5159), float3(fragment_unnamed_5157, fragment_unnamed_5158, fragment_unnamed_5159)))), 0.0f)));
							float fragment_unnamed_5193 = clamp(mad((-0.0f) - fragment_unnamed_5190, fragment_unnamed_5190, asfloat(fragment_unnamed_5106.y)), 0.0f, 1.0f);
							float fragment_unnamed_5204 = asfloat(((fragment_unnamed_5147 & ((dot(float3(fragment_unnamed_5157, fragment_unnamed_5158, fragment_unnamed_5159), float3(asfloat(fragment_unnamed_5027.x), asfloat(fragment_unnamed_5027.y), asfloat(fragment_unnamed_5027.z))) >= 0.0f) ? 4294967295u : 0u)) != 0u) ? 0u : asuint(fragment_unnamed_5193 * fragment_unnamed_5193));
							uint fragment_unnamed_5206 = (0.0f < fragment_unnamed_5204) ? 4294967295u : 0u;
							float fragment_unnamed_6529;
							float fragment_unnamed_6531;
							float fragment_unnamed_6533;
							float fragment_unnamed_6535;
							if ((fragment_unnamed_5147 & fragment_unnamed_5206) != 0u)
							{
								float fragment_unnamed_6075 = asfloat(T7.Load((fragment_unnamed_3879 * 56u) + 16u).x);
								uint fragment_unnamed_6077 = (fragment_unnamed_3879 * 56u) + 34u;
								uint2 fragment_unnamed_6083 = uint2(T7.Load(fragment_unnamed_6077).x, T7.Load(fragment_unnamed_6077 + 1u).x);
								float fragment_unnamed_6085 = asfloat(fragment_unnamed_6083.x);
								float fragment_unnamed_6087 = asfloat(fragment_unnamed_6083.y);
								float fragment_unnamed_6987;
								if ((((int(fragment_unnamed_5070) >= int(0u)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_6087) ? 4294967295u : 0u)) != 0u)
								{
									uint fragment_unnamed_6377 = fragment_unnamed_5070 * 60u;
									uint4 fragment_unnamed_6389 = uint4(T32.Load(fragment_unnamed_6377).x, T32.Load(fragment_unnamed_6377 + 1u).x, T32.Load(fragment_unnamed_6377 + 2u).x, T32.Load(fragment_unnamed_6377 + 3u).x);
									float fragment_unnamed_6391 = asfloat(fragment_unnamed_6389.w);
									float fragment_unnamed_6393 = asfloat(fragment_unnamed_6389.x);
									float fragment_unnamed_6395 = asfloat(fragment_unnamed_6389.y);
									float fragment_unnamed_6397 = asfloat(fragment_unnamed_6389.z);
									uint fragment_unnamed_6399 = (fragment_unnamed_5070 * 60u) + 4u;
									uint4 fragment_unnamed_6411 = uint4(T32.Load(fragment_unnamed_6399).x, T32.Load(fragment_unnamed_6399 + 1u).x, T32.Load(fragment_unnamed_6399 + 2u).x, T32.Load(fragment_unnamed_6399 + 3u).x);
									uint fragment_unnamed_6412 = fragment_unnamed_6411.x;
									uint fragment_unnamed_6413 = fragment_unnamed_6411.y;
									uint fragment_unnamed_6414 = fragment_unnamed_6411.z;
									uint fragment_unnamed_6415 = fragment_unnamed_6411.w;
									uint fragment_unnamed_6417 = (fragment_unnamed_5070 * 60u) + 8u;
									uint4 fragment_unnamed_6429 = uint4(T32.Load(fragment_unnamed_6417).x, T32.Load(fragment_unnamed_6417 + 1u).x, T32.Load(fragment_unnamed_6417 + 2u).x, T32.Load(fragment_unnamed_6417 + 3u).x);
									float fragment_unnamed_6431 = asfloat(fragment_unnamed_6429.y);
									float fragment_unnamed_6433 = asfloat(fragment_unnamed_6429.z);
									float fragment_unnamed_6435 = asfloat(fragment_unnamed_6429.x);
									uint fragment_unnamed_6436 = fragment_unnamed_6429.w;
									uint fragment_unnamed_6438 = (fragment_unnamed_5070 * 60u) + 12u;
									uint4 fragment_unnamed_6450 = uint4(T32.Load(fragment_unnamed_6438).x, T32.Load(fragment_unnamed_6438 + 1u).x, T32.Load(fragment_unnamed_6438 + 2u).x, T32.Load(fragment_unnamed_6438 + 3u).x);
									float fragment_unnamed_6452 = asfloat(fragment_unnamed_6450.x);
									float fragment_unnamed_6454 = asfloat(fragment_unnamed_6450.y);
									float fragment_unnamed_6456 = asfloat(fragment_unnamed_6450.z);
									float fragment_unnamed_6458 = asfloat(fragment_unnamed_6450.w);
									uint fragment_unnamed_6460 = (fragment_unnamed_5070 * 60u) + 16u;
									uint2 fragment_unnamed_6466 = uint2(T32.Load(fragment_unnamed_6460).x, T32.Load(fragment_unnamed_6460 + 1u).x);
									float fragment_unnamed_6468 = asfloat(fragment_unnamed_6466.x);
									float fragment_unnamed_6470 = asfloat(fragment_unnamed_6466.y);
									uint fragment_unnamed_6472 = (fragment_unnamed_5070 * 60u) + 24u;
									uint2 fragment_unnamed_6478 = uint2(T32.Load(fragment_unnamed_6472).x, T32.Load(fragment_unnamed_6472 + 1u).x);
									float fragment_unnamed_6480 = asfloat(fragment_unnamed_6478.x);
									float fragment_unnamed_6482 = asfloat(fragment_unnamed_6478.y);
									uint fragment_unnamed_6484 = (fragment_unnamed_5070 * 60u) + 28u;
									uint4 fragment_unnamed_6496 = uint4(T32.Load(fragment_unnamed_6484).x, T32.Load(fragment_unnamed_6484 + 1u).x, T32.Load(fragment_unnamed_6484 + 2u).x, T32.Load(fragment_unnamed_6484 + 3u).x);
									float fragment_unnamed_6498 = asfloat(fragment_unnamed_6496.x);
									float fragment_unnamed_6500 = asfloat(fragment_unnamed_6496.y);
									float fragment_unnamed_6502 = asfloat(fragment_unnamed_6496.z);
									float fragment_unnamed_6504 = asfloat(fragment_unnamed_6496.w);
									uint fragment_unnamed_6506 = (fragment_unnamed_5070 * 60u) + 40u;
									uint4 fragment_unnamed_6518 = uint4(T32.Load(fragment_unnamed_6506).x, T32.Load(fragment_unnamed_6506 + 1u).x, T32.Load(fragment_unnamed_6506 + 2u).x, T32.Load(fragment_unnamed_6506 + 3u).x);
									float fragment_unnamed_6520 = asfloat(fragment_unnamed_6518.x);
									float fragment_unnamed_6522 = asfloat(fragment_unnamed_6518.y);
									float fragment_unnamed_6524 = asfloat(fragment_unnamed_6518.z);
									float fragment_unnamed_6526 = asfloat(fragment_unnamed_6518.w);
									float fragment_unnamed_7371;
									if (0.0f < fragment_unnamed_6526)
									{
										bool fragment_unnamed_6727 = 0.0f != fragment_unnamed_6526;
										uint4 fragment_unnamed_6731 = asuint(fragment_uniform_buffer_0[101u]);
										uint4 fragment_unnamed_6737 = asuint(fragment_uniform_buffer_0[99u]);
										float fragment_unnamed_6741 = asfloat(fragment_unnamed_6727 ? fragment_unnamed_6731.z : fragment_unnamed_6737.z);
										float fragment_unnamed_6743 = asfloat(fragment_unnamed_6727 ? fragment_unnamed_6731.w : fragment_unnamed_6737.w);
										float fragment_unnamed_6757 = ((-0.0f) - fragment_unnamed_6431) + (fragment_unnamed_6520 + fragment_input_5.x);
										float fragment_unnamed_6758 = ((-0.0f) - fragment_unnamed_6433) + (fragment_unnamed_6522 + fragment_input_5.y);
										float fragment_unnamed_6759 = ((-0.0f) - asfloat(fragment_unnamed_6436)) + (fragment_unnamed_6524 + fragment_input_5.z);
										float fragment_unnamed_6770 = dot(float3(asfloat(fragment_unnamed_6414), asfloat(fragment_unnamed_6415), fragment_unnamed_6435), float3(fragment_unnamed_6757, fragment_unnamed_6758, fragment_unnamed_6759));
										float fragment_unnamed_6773 = dot(float3(fragment_unnamed_6393, fragment_unnamed_6395, fragment_unnamed_6397), float3(fragment_unnamed_6757, fragment_unnamed_6758, fragment_unnamed_6759)) * fragment_unnamed_6452;
										float fragment_unnamed_6774 = dot(float3(fragment_unnamed_6391, asfloat(fragment_unnamed_6412), asfloat(fragment_unnamed_6413)), float3(fragment_unnamed_6757, fragment_unnamed_6758, fragment_unnamed_6759)) * fragment_unnamed_6454;
										float fragment_unnamed_6775 = dot(float2(fragment_unnamed_6456, fragment_unnamed_6458), float2(fragment_unnamed_6770, fragment_unnamed_403));
										bool fragment_unnamed_6778 = fragment_unnamed_6770 != (-0.0f);
										float fragment_unnamed_6779 = (-0.0f) - fragment_unnamed_6770;
										float fragment_unnamed_6801 = mad(fragment_unnamed_6480 * clamp(mad(asfloat(fragment_unnamed_6778 ? asuint(fragment_unnamed_6773 / fragment_unnamed_6779) : asuint(fragment_unnamed_6773)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6741, fragment_unnamed_6468);
										float fragment_unnamed_6802 = mad(fragment_unnamed_6482 * clamp(mad(asfloat(fragment_unnamed_6778 ? asuint(fragment_unnamed_6774 / fragment_unnamed_6779) : asuint(fragment_unnamed_6774)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6743, fragment_unnamed_6470);
										float fragment_unnamed_6803 = trunc(mad(min(fragment_unnamed_6504, 4.0f), 4.0f, 1.0f));
										float fragment_unnamed_6804 = (-0.0f) - fragment_unnamed_6803;
										float4 fragment_unnamed_6825 = _CachedAreaLightShadowmapAtlas.SampleLevel(S0, float2(fragment_unnamed_6801, fragment_unnamed_6802), 0.0f);
										float fragment_unnamed_6827 = fragment_unnamed_6825.x;
										float fragment_unnamed_6831 = exp2(mad(((-0.0f) - asfloat(fragment_unnamed_6778 ? asuint(fragment_unnamed_6775 / fragment_unnamed_6779) : asuint(fragment_unnamed_6775))) + 1.0f, 2.0f, -1.0f) * fragment_unnamed_6498);
										float fragment_unnamed_6832 = fragment_unnamed_6831 * fragment_unnamed_6498;
										float fragment_unnamed_6837 = max(fragment_unnamed_6502 * (fragment_unnamed_6832 * fragment_unnamed_6832), mad((-0.0f) - fragment_unnamed_6827, fragment_unnamed_6827, fragment_unnamed_6825.y));
										float fragment_unnamed_6839 = ((-0.0f) - fragment_unnamed_6827) + fragment_unnamed_6831;
										fragment_unnamed_7371 = asfloat((((((mad(mad(fragment_unnamed_6804, 0.5f, fragment_unnamed_6482), fragment_unnamed_6743, fragment_unnamed_6470) < fragment_unnamed_6802) ? 4294967295u : 0u) | ((mad(mad(fragment_unnamed_6804, 0.5f, fragment_unnamed_6480), fragment_unnamed_6741, fragment_unnamed_6468) < fragment_unnamed_6801) ? 4294967295u : 0u)) | (((fragment_unnamed_6802 < mad(fragment_unnamed_6743, fragment_unnamed_6803, fragment_unnamed_6470)) ? 4294967295u : 0u) | ((fragment_unnamed_6801 < mad(fragment_unnamed_6741, fragment_unnamed_6803, fragment_unnamed_6468)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(max(asfloat(((fragment_unnamed_6827 >= fragment_unnamed_6831) ? 4294967295u : 0u) & 1065353216u), clamp((((-0.0f) - fragment_unnamed_6500) + (fragment_unnamed_6837 / mad(fragment_unnamed_6839, fragment_unnamed_6839, fragment_unnamed_6837))) / (((-0.0f) - fragment_unnamed_6500) + 1.0f), 0.0f, 1.0f))));
									}
									else
									{
										bool fragment_unnamed_6859 = 0.0f != fragment_unnamed_6526;
										uint4 fragment_unnamed_6862 = asuint(fragment_uniform_buffer_0[101u]);
										uint4 fragment_unnamed_6867 = asuint(fragment_uniform_buffer_0[99u]);
										float fragment_unnamed_6871 = asfloat(fragment_unnamed_6859 ? fragment_unnamed_6862.z : fragment_unnamed_6867.z);
										float fragment_unnamed_6873 = asfloat(fragment_unnamed_6859 ? fragment_unnamed_6862.w : fragment_unnamed_6867.w);
										float fragment_unnamed_6887 = ((-0.0f) - fragment_unnamed_6431) + (fragment_unnamed_6520 + fragment_input_5.x);
										float fragment_unnamed_6888 = ((-0.0f) - fragment_unnamed_6433) + (fragment_unnamed_6522 + fragment_input_5.y);
										float fragment_unnamed_6889 = ((-0.0f) - asfloat(fragment_unnamed_6436)) + (fragment_unnamed_6524 + fragment_input_5.z);
										float fragment_unnamed_6900 = dot(float3(asfloat(fragment_unnamed_6414), asfloat(fragment_unnamed_6415), fragment_unnamed_6435), float3(fragment_unnamed_6887, fragment_unnamed_6888, fragment_unnamed_6889));
										float fragment_unnamed_6903 = dot(float3(fragment_unnamed_6393, fragment_unnamed_6395, fragment_unnamed_6397), float3(fragment_unnamed_6887, fragment_unnamed_6888, fragment_unnamed_6889)) * fragment_unnamed_6452;
										float fragment_unnamed_6904 = dot(float3(fragment_unnamed_6391, asfloat(fragment_unnamed_6412), asfloat(fragment_unnamed_6413)), float3(fragment_unnamed_6887, fragment_unnamed_6888, fragment_unnamed_6889)) * fragment_unnamed_6454;
										float fragment_unnamed_6905 = dot(float2(fragment_unnamed_6456, fragment_unnamed_6458), float2(fragment_unnamed_6900, fragment_unnamed_2875));
										bool fragment_unnamed_6908 = fragment_unnamed_6900 != (-0.0f);
										float fragment_unnamed_6909 = (-0.0f) - fragment_unnamed_6900;
										float fragment_unnamed_6931 = mad(fragment_unnamed_6480 * clamp(mad(asfloat(fragment_unnamed_6908 ? asuint(fragment_unnamed_6903 / fragment_unnamed_6909) : asuint(fragment_unnamed_6903)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6871, fragment_unnamed_6468);
										float fragment_unnamed_6932 = mad(fragment_unnamed_6482 * clamp(mad(asfloat(fragment_unnamed_6908 ? asuint(fragment_unnamed_6904 / fragment_unnamed_6909) : asuint(fragment_unnamed_6904)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6873, fragment_unnamed_6470);
										float fragment_unnamed_6933 = trunc(mad(min(fragment_unnamed_6504, 4.0f), 4.0f, 1.0f));
										float fragment_unnamed_6934 = (-0.0f) - fragment_unnamed_6933;
										float4 fragment_unnamed_6955 = _ShadowmapAreaAtlas.SampleLevel(S0, float2(fragment_unnamed_6931, fragment_unnamed_6932), 0.0f);
										float fragment_unnamed_6957 = fragment_unnamed_6955.x;
										float fragment_unnamed_6961 = exp2(mad(((-0.0f) - asfloat(fragment_unnamed_6908 ? asuint(fragment_unnamed_6905 / fragment_unnamed_6909) : asuint(fragment_unnamed_6905))) + 1.0f, 2.0f, -1.0f) * fragment_unnamed_6498);
										float fragment_unnamed_6962 = fragment_unnamed_6961 * fragment_unnamed_6498;
										float fragment_unnamed_6967 = max(fragment_unnamed_6502 * (fragment_unnamed_6962 * fragment_unnamed_6962), mad((-0.0f) - fragment_unnamed_6957, fragment_unnamed_6957, fragment_unnamed_6955.y));
										float fragment_unnamed_6969 = ((-0.0f) - fragment_unnamed_6957) + fragment_unnamed_6961;
										fragment_unnamed_7371 = asfloat((((((mad(mad(fragment_unnamed_6934, 0.5f, fragment_unnamed_6482), fragment_unnamed_6873, fragment_unnamed_6470) < fragment_unnamed_6932) ? 4294967295u : 0u) | ((mad(mad(fragment_unnamed_6934, 0.5f, fragment_unnamed_6480), fragment_unnamed_6871, fragment_unnamed_6468) < fragment_unnamed_6931) ? 4294967295u : 0u)) | (((fragment_unnamed_6932 < mad(fragment_unnamed_6873, fragment_unnamed_6933, fragment_unnamed_6470)) ? 4294967295u : 0u) | ((fragment_unnamed_6931 < mad(fragment_unnamed_6871, fragment_unnamed_6933, fragment_unnamed_6468)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(max(asfloat(((fragment_unnamed_6957 >= fragment_unnamed_6961) ? 4294967295u : 0u) & 1065353216u), clamp((((-0.0f) - fragment_unnamed_6500) + (fragment_unnamed_6967 / mad(fragment_unnamed_6969, fragment_unnamed_6969, fragment_unnamed_6967))) / (((-0.0f) - fragment_unnamed_6500) + 1.0f), 0.0f, 1.0f))));
									}
									fragment_unnamed_6987 = mad(fragment_unnamed_6087, fragment_unnamed_7371 + (-1.0f), 1.0f);
								}
								else
								{
									fragment_unnamed_6987 = asfloat(1065353216u);
								}
								float fragment_unnamed_6989 = asfloat(fragment_unnamed_5127.z);
								float fragment_unnamed_6990 = asfloat(fragment_unnamed_5127.w);
								float fragment_unnamed_6994 = ((-0.0f) - fragment_unnamed_6989) + 1.0f;
								float fragment_unnamed_6995 = ((-0.0f) - fragment_unnamed_6990) + 1.0f;
								float fragment_unnamed_6996 = ((-0.0f) - fragment_unnamed_6085) + 1.0f;
								float fragment_unnamed_6998 = fragment_unnamed_6987 * (fragment_unnamed_6987 * fragment_unnamed_6987);
								float fragment_unnamed_7001 = (-0.0f) - (((-0.0f) - fragment_unnamed_6987) + 1.0f);
								float fragment_unnamed_7002 = mad(fragment_unnamed_7001, fragment_unnamed_6994, 1.0f);
								float fragment_unnamed_7003 = mad(fragment_unnamed_7001, fragment_unnamed_6995, 1.0f);
								float fragment_unnamed_7004 = mad(fragment_unnamed_7001, fragment_unnamed_6996, 1.0f);
								float fragment_unnamed_6530 = mad(fragment_unnamed_6075, ((-0.0f) - fragment_unnamed_7002) + mad(fragment_unnamed_6998, fragment_unnamed_6994, fragment_unnamed_6989 * fragment_unnamed_6987), fragment_unnamed_7002) * fragment_unnamed_5088;
								float fragment_unnamed_6532 = mad(fragment_unnamed_6075, ((-0.0f) - fragment_unnamed_7003) + mad(fragment_unnamed_6998, fragment_unnamed_6995, fragment_unnamed_6990 * fragment_unnamed_6987), fragment_unnamed_7003) * fragment_unnamed_5090;
								float fragment_unnamed_6534 = mad(fragment_unnamed_6075, ((-0.0f) - fragment_unnamed_7004) + mad(fragment_unnamed_6998, fragment_unnamed_6996, fragment_unnamed_6085 * fragment_unnamed_6987), fragment_unnamed_7004) * asfloat(fragment_unnamed_5107);
								fragment_unnamed_6529 = fragment_unnamed_6530;
								fragment_unnamed_6531 = fragment_unnamed_6532;
								fragment_unnamed_6533 = fragment_unnamed_6534;
								fragment_unnamed_6535 = asfloat((0.0f < max(fragment_unnamed_6534, max(fragment_unnamed_6532, fragment_unnamed_6530))) ? 4294967295u : 0u);
							}
							else
							{
								fragment_unnamed_6529 = fragment_unnamed_5088;
								fragment_unnamed_6531 = fragment_unnamed_5090;
								fragment_unnamed_6533 = asfloat(fragment_unnamed_5107);
								fragment_unnamed_6535 = asfloat(4294967295u);
							}
							float fragment_unnamed_7391;
							float fragment_unnamed_7393;
							float fragment_unnamed_7395;
							float fragment_unnamed_7397;
							float fragment_unnamed_7399;
							float fragment_unnamed_7401;
							if ((fragment_unnamed_5206 & asuint(fragment_unnamed_6535)) != 0u)
							{
								uint fragment_unnamed_7026 = (fragment_unnamed_3879 * 56u) + 49u;
								uint2 fragment_unnamed_7032 = uint2(T7.Load(fragment_unnamed_7026).x, T7.Load(fragment_unnamed_7026 + 1u).x);
								float fragment_unnamed_7037 = dot(float3(fragment_unnamed_955, fragment_unnamed_2872, fragment_unnamed_2873), float3(fragment_unnamed_5157, fragment_unnamed_5158, fragment_unnamed_5159));
								float fragment_unnamed_7040 = dot(float3(fragment_unnamed_945, fragment_unnamed_947, fragment_unnamed_2874), float3(fragment_unnamed_5157, fragment_unnamed_5158, fragment_unnamed_5159));
								float fragment_unnamed_7043 = dot(float3(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469), float3(fragment_unnamed_5157, fragment_unnamed_5158, fragment_unnamed_5159));
								float fragment_unnamed_7046 = dot(float3(fragment_unnamed_955, fragment_unnamed_2872, fragment_unnamed_2873), float3(fragment_unnamed_5050, fragment_unnamed_5052, fragment_unnamed_5054));
								float fragment_unnamed_7049 = dot(float3(fragment_unnamed_945, fragment_unnamed_947, fragment_unnamed_2874), float3(fragment_unnamed_5050, fragment_unnamed_5052, fragment_unnamed_5054));
								float fragment_unnamed_7052 = dot(float3(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469), float3(fragment_unnamed_5050, fragment_unnamed_5052, fragment_unnamed_5054));
								float fragment_unnamed_7055 = dot(float3(fragment_unnamed_955, fragment_unnamed_2872, fragment_unnamed_2873), float3(fragment_unnamed_5169, fragment_unnamed_5170, fragment_unnamed_5171));
								float fragment_unnamed_7058 = dot(float3(fragment_unnamed_945, fragment_unnamed_947, fragment_unnamed_2874), float3(fragment_unnamed_5169, fragment_unnamed_5170, fragment_unnamed_5171));
								float fragment_unnamed_7061 = dot(float3(fragment_unnamed_467, fragment_unnamed_468, fragment_unnamed_469), float3(fragment_unnamed_5169, fragment_unnamed_5170, fragment_unnamed_5171));
								float fragment_unnamed_7070 = mad(fragment_unnamed_7040, fragment_unnamed_7052, (-0.0f) - (fragment_unnamed_7049 * fragment_unnamed_7043));
								float fragment_unnamed_7071 = mad(fragment_unnamed_7043, fragment_unnamed_7046, (-0.0f) - (fragment_unnamed_7052 * fragment_unnamed_7037));
								float fragment_unnamed_7072 = mad(fragment_unnamed_7037, fragment_unnamed_7049, (-0.0f) - (fragment_unnamed_7046 * fragment_unnamed_7040));
								float fragment_unnamed_7073 = dot(float3(fragment_unnamed_7070, fragment_unnamed_7071, fragment_unnamed_7072), float3(fragment_unnamed_7070, fragment_unnamed_7071, fragment_unnamed_7072));
								uint fragment_unnamed_7084 = ((fragment_unnamed_7073 == 0.0f) ? 4294967295u : 0u) | ((0.0f >= mad(fragment_unnamed_5161, abs(fragment_unnamed_7061), mad(fragment_unnamed_5160, abs(fragment_unnamed_7052), fragment_unnamed_7043))) ? 4294967295u : 0u);
								float fragment_unnamed_7639;
								float fragment_unnamed_7641;
								float fragment_unnamed_7643;
								float fragment_unnamed_7645;
								if (fragment_unnamed_7084 == 0u)
								{
									float fragment_unnamed_7373 = dot(float2(fragment_unnamed_2876, fragment_unnamed_886), float2(fragment_unnamed_7043, fragment_unnamed_7037));
									float fragment_unnamed_7376 = dot(float2(fragment_unnamed_2876, fragment_unnamed_886), float2(fragment_unnamed_7052, fragment_unnamed_7046));
									float fragment_unnamed_7379 = dot(float2(fragment_unnamed_886, fragment_unnamed_2876), float2(fragment_unnamed_7055, fragment_unnamed_7061));
									float fragment_unnamed_7640;
									float fragment_unnamed_7642;
									float fragment_unnamed_7644;
									float fragment_unnamed_7646;
									if (0.0f < mad(fragment_unnamed_5161, abs(fragment_unnamed_7379), mad(fragment_unnamed_5160, abs(fragment_unnamed_7376), fragment_unnamed_7373)))
									{
										float fragment_unnamed_7627 = dot(float2(fragment_unnamed_888, fragment_unnamed_885), float2(fragment_unnamed_7043, fragment_unnamed_7037));
										float fragment_unnamed_7630 = fragment_unnamed_887 * fragment_unnamed_7040;
										float fragment_unnamed_7631 = dot(float2(fragment_unnamed_888, fragment_unnamed_885), float2(fragment_unnamed_7052, fragment_unnamed_7046));
										float fragment_unnamed_7634 = fragment_unnamed_887 * fragment_unnamed_7049;
										float fragment_unnamed_8699;
										float fragment_unnamed_8700;
										float fragment_unnamed_8701;
										float fragment_unnamed_8702;
										if (fragment_unnamed_5146)
										{
											float fragment_unnamed_8359 = dot(float2(fragment_unnamed_885, fragment_unnamed_888), float2(fragment_unnamed_7055, fragment_unnamed_7061));
											float fragment_unnamed_8362 = fragment_unnamed_7058 * fragment_unnamed_887;
											float fragment_unnamed_8363 = (-0.0f) - fragment_unnamed_5160;
											float fragment_unnamed_8367 = (-0.0f) - fragment_unnamed_5161;
											float fragment_unnamed_8368 = mad(fragment_unnamed_8367, fragment_unnamed_8359, mad(fragment_unnamed_8363, fragment_unnamed_7631, fragment_unnamed_7627));
											float fragment_unnamed_8369 = mad(fragment_unnamed_8367, fragment_unnamed_8362, mad(fragment_unnamed_8363, fragment_unnamed_7634, fragment_unnamed_7630));
											float fragment_unnamed_8370 = mad(fragment_unnamed_8367, fragment_unnamed_7379, mad(fragment_unnamed_8363, fragment_unnamed_7376, fragment_unnamed_7373));
											float fragment_unnamed_8371 = fragment_unnamed_5145 * fragment_unnamed_8359;
											float fragment_unnamed_8372 = fragment_unnamed_5145 * fragment_unnamed_8362;
											float fragment_unnamed_8373 = fragment_unnamed_5145 * fragment_unnamed_7379;
											float fragment_unnamed_8374 = mad(fragment_unnamed_5145, fragment_unnamed_7379, fragment_unnamed_8370);
											float fragment_unnamed_8375 = mad(fragment_unnamed_5145, fragment_unnamed_8359, fragment_unnamed_8368);
											float fragment_unnamed_8376 = mad(fragment_unnamed_5145, fragment_unnamed_8362, fragment_unnamed_8369);
											float fragment_unnamed_8377 = mad(fragment_unnamed_5143, fragment_unnamed_7376, fragment_unnamed_8374);
											float fragment_unnamed_8378 = mad(fragment_unnamed_5143, fragment_unnamed_7631, fragment_unnamed_8375);
											float fragment_unnamed_8379 = mad(fragment_unnamed_5143, fragment_unnamed_7634, fragment_unnamed_8376);
											float fragment_unnamed_8380 = (-0.0f) - fragment_unnamed_5145;
											float fragment_unnamed_8381 = mad(fragment_unnamed_8380, fragment_unnamed_8359, fragment_unnamed_8378);
											float fragment_unnamed_8382 = mad(fragment_unnamed_8380, fragment_unnamed_8362, fragment_unnamed_8379);
											float fragment_unnamed_8383 = mad(fragment_unnamed_8380, fragment_unnamed_7379, fragment_unnamed_8377);
											float fragment_unnamed_8387 = rsqrt(dot(float3(fragment_unnamed_8368, fragment_unnamed_8369, fragment_unnamed_8370), float3(fragment_unnamed_8368, fragment_unnamed_8369, fragment_unnamed_8370)));
											float fragment_unnamed_8388 = fragment_unnamed_8387 * fragment_unnamed_8369;
											float fragment_unnamed_8389 = fragment_unnamed_8387 * fragment_unnamed_8370;
											float fragment_unnamed_8390 = fragment_unnamed_8387 * fragment_unnamed_8368;
											float fragment_unnamed_8394 = rsqrt(dot(float3(fragment_unnamed_8374, fragment_unnamed_8375, fragment_unnamed_8376), float3(fragment_unnamed_8374, fragment_unnamed_8375, fragment_unnamed_8376)));
											float fragment_unnamed_8395 = fragment_unnamed_8394 * fragment_unnamed_8374;
											float fragment_unnamed_8396 = fragment_unnamed_8394 * fragment_unnamed_8375;
											float fragment_unnamed_8397 = fragment_unnamed_8394 * fragment_unnamed_8376;
											float fragment_unnamed_8401 = rsqrt(dot(float3(fragment_unnamed_8377, fragment_unnamed_8378, fragment_unnamed_8379), float3(fragment_unnamed_8377, fragment_unnamed_8378, fragment_unnamed_8379)));
											float fragment_unnamed_8402 = fragment_unnamed_8401 * fragment_unnamed_8377;
											float fragment_unnamed_8403 = fragment_unnamed_8401 * fragment_unnamed_8378;
											float fragment_unnamed_8404 = fragment_unnamed_8401 * fragment_unnamed_8379;
											float fragment_unnamed_8408 = rsqrt(dot(float3(fragment_unnamed_8381, fragment_unnamed_8382, fragment_unnamed_8383), float3(fragment_unnamed_8381, fragment_unnamed_8382, fragment_unnamed_8383)));
											float fragment_unnamed_8409 = fragment_unnamed_8408 * fragment_unnamed_8383;
											float fragment_unnamed_8410 = fragment_unnamed_8408 * fragment_unnamed_8381;
											float fragment_unnamed_8411 = fragment_unnamed_8408 * fragment_unnamed_8382;
											float fragment_unnamed_8412 = dot(float3(fragment_unnamed_8389, fragment_unnamed_8390, fragment_unnamed_8388), float3(fragment_unnamed_8395, fragment_unnamed_8396, fragment_unnamed_8397));
											float fragment_unnamed_8449 = mad(abs(fragment_unnamed_8412), mad(abs(fragment_unnamed_8412), mad(abs(fragment_unnamed_8412), mad(abs(fragment_unnamed_8412), mad(abs(fragment_unnamed_8412), mad(abs(fragment_unnamed_8412), mad(abs(fragment_unnamed_8412), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8457 = asfloat((fragment_unnamed_8412 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8412, fragment_unnamed_8412, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8449)) : asuint(fragment_unnamed_8449));
											float fragment_unnamed_8458 = dot(float3(fragment_unnamed_8395, fragment_unnamed_8396, fragment_unnamed_8397), float3(fragment_unnamed_8402, fragment_unnamed_8403, fragment_unnamed_8404));
											float fragment_unnamed_8488 = mad(abs(fragment_unnamed_8458), mad(abs(fragment_unnamed_8458), mad(abs(fragment_unnamed_8458), mad(abs(fragment_unnamed_8458), mad(abs(fragment_unnamed_8458), mad(abs(fragment_unnamed_8458), mad(abs(fragment_unnamed_8458), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8495 = asfloat((fragment_unnamed_8458 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8458, fragment_unnamed_8458, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8488)) : asuint(fragment_unnamed_8488));
											float fragment_unnamed_8502 = dot(float3(fragment_unnamed_8402, fragment_unnamed_8403, fragment_unnamed_8404), float3(fragment_unnamed_8409, fragment_unnamed_8410, fragment_unnamed_8411));
											float fragment_unnamed_8532 = mad(abs(fragment_unnamed_8502), mad(abs(fragment_unnamed_8502), mad(abs(fragment_unnamed_8502), mad(abs(fragment_unnamed_8502), mad(abs(fragment_unnamed_8502), mad(abs(fragment_unnamed_8502), mad(abs(fragment_unnamed_8502), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8539 = asfloat((fragment_unnamed_8502 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8502, fragment_unnamed_8502, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8532)) : asuint(fragment_unnamed_8532));
											float fragment_unnamed_8543 = dot(float3(fragment_unnamed_8411, fragment_unnamed_8409, fragment_unnamed_8410), float3(fragment_unnamed_8388, fragment_unnamed_8389, fragment_unnamed_8390));
											float fragment_unnamed_8573 = mad(abs(fragment_unnamed_8543), mad(abs(fragment_unnamed_8543), mad(abs(fragment_unnamed_8543), mad(abs(fragment_unnamed_8543), mad(abs(fragment_unnamed_8543), mad(abs(fragment_unnamed_8543), mad(abs(fragment_unnamed_8543), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8580 = asfloat((fragment_unnamed_8543 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8543, fragment_unnamed_8543, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8573)) : asuint(fragment_unnamed_8573));
											float fragment_unnamed_8583 = mad(mad(fragment_unnamed_8410, fragment_unnamed_8388, (-0.0f) - (fragment_unnamed_8390 * fragment_unnamed_8411)), fragment_unnamed_8580, mad(mad(fragment_unnamed_8403, fragment_unnamed_8411, (-0.0f) - (fragment_unnamed_8404 * fragment_unnamed_8410)), fragment_unnamed_8539, mad(mad(fragment_unnamed_8390, fragment_unnamed_8397, (-0.0f) - (fragment_unnamed_8396 * fragment_unnamed_8388)), fragment_unnamed_8457, fragment_unnamed_8495 * mad(fragment_unnamed_8396, fragment_unnamed_8404, (-0.0f) - (fragment_unnamed_8397 * fragment_unnamed_8403)))));
											float fragment_unnamed_8584 = mad(mad(fragment_unnamed_8411, fragment_unnamed_8389, (-0.0f) - (fragment_unnamed_8388 * fragment_unnamed_8409)), fragment_unnamed_8580, mad(mad(fragment_unnamed_8404, fragment_unnamed_8409, (-0.0f) - (fragment_unnamed_8402 * fragment_unnamed_8411)), fragment_unnamed_8539, mad(mad(fragment_unnamed_8388, fragment_unnamed_8395, (-0.0f) - (fragment_unnamed_8397 * fragment_unnamed_8389)), fragment_unnamed_8457, fragment_unnamed_8495 * mad(fragment_unnamed_8397, fragment_unnamed_8402, (-0.0f) - (fragment_unnamed_8395 * fragment_unnamed_8404))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_8585 = mad(mad(fragment_unnamed_8409, fragment_unnamed_8390, (-0.0f) - (fragment_unnamed_8389 * fragment_unnamed_8410)), fragment_unnamed_8580, mad(mad(fragment_unnamed_8402, fragment_unnamed_8410, (-0.0f) - (fragment_unnamed_8403 * fragment_unnamed_8409)), fragment_unnamed_8539, mad(mad(fragment_unnamed_8389, fragment_unnamed_8396, (-0.0f) - (fragment_unnamed_8395 * fragment_unnamed_8390)), fragment_unnamed_8457, fragment_unnamed_8495 * mad(fragment_unnamed_8395, fragment_unnamed_8403, (-0.0f) - (fragment_unnamed_8396 * fragment_unnamed_8402))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_8586 = fragment_unnamed_8583 * 0.15915493667125701904296875f;
											float fragment_unnamed_8587 = dot(float3(fragment_unnamed_8584, fragment_unnamed_8585, fragment_unnamed_8586), float3(fragment_unnamed_8584, fragment_unnamed_8585, fragment_unnamed_8586));
											float fragment_unnamed_8871;
											float fragment_unnamed_8872;
											float fragment_unnamed_8873;
											if (fragment_unnamed_5069 != 0u)
											{
												float fragment_unnamed_8739 = ((-0.0f) - fragment_unnamed_8368) + fragment_unnamed_8381;
												float fragment_unnamed_8740 = ((-0.0f) - fragment_unnamed_8369) + fragment_unnamed_8382;
												float fragment_unnamed_8741 = ((-0.0f) - fragment_unnamed_8370) + fragment_unnamed_8383;
												float fragment_unnamed_8748 = mad(fragment_unnamed_8740, fragment_unnamed_8373, (-0.0f) - (fragment_unnamed_8372 * fragment_unnamed_8741));
												float fragment_unnamed_8749 = mad(fragment_unnamed_8741, fragment_unnamed_8371, (-0.0f) - (fragment_unnamed_8373 * fragment_unnamed_8739));
												float fragment_unnamed_8750 = mad(fragment_unnamed_8739, fragment_unnamed_8372, (-0.0f) - (fragment_unnamed_8371 * fragment_unnamed_8740));
												float fragment_unnamed_8754 = rsqrt(dot(float3(fragment_unnamed_8748, fragment_unnamed_8749, fragment_unnamed_8750), float3(fragment_unnamed_8748, fragment_unnamed_8749, fragment_unnamed_8750)));
												float fragment_unnamed_8755 = fragment_unnamed_8754 * fragment_unnamed_8748;
												float fragment_unnamed_8756 = fragment_unnamed_8754 * fragment_unnamed_8749;
												float fragment_unnamed_8757 = fragment_unnamed_8754 * fragment_unnamed_8750;
												float fragment_unnamed_8764 = dot(float3(fragment_unnamed_8368, fragment_unnamed_8369, fragment_unnamed_8370), float3(fragment_unnamed_8755, fragment_unnamed_8756, fragment_unnamed_8757)) / dot(float3(fragment_unnamed_8584, fragment_unnamed_8585, fragment_unnamed_8586), float3(fragment_unnamed_8755, fragment_unnamed_8756, fragment_unnamed_8757));
												float fragment_unnamed_8768 = mad(fragment_unnamed_8764, fragment_unnamed_8755, (-0.0f) - fragment_unnamed_8368);
												float fragment_unnamed_8769 = mad(fragment_unnamed_8764, fragment_unnamed_8756, (-0.0f) - fragment_unnamed_8369);
												float fragment_unnamed_8770 = mad(fragment_unnamed_8764, fragment_unnamed_8757, (-0.0f) - fragment_unnamed_8370);
												float fragment_unnamed_8774 = 1.0f / dot(float3(fragment_unnamed_8739, fragment_unnamed_8740, fragment_unnamed_8741), float3(fragment_unnamed_8739, fragment_unnamed_8740, fragment_unnamed_8741));
												float fragment_unnamed_8775 = dot(float3(fragment_unnamed_8371, fragment_unnamed_8372, fragment_unnamed_8373), float3(fragment_unnamed_8739, fragment_unnamed_8740, fragment_unnamed_8741));
												float fragment_unnamed_8784 = mad((-0.0f) - (fragment_unnamed_8739 * fragment_unnamed_8775), fragment_unnamed_8774, fragment_unnamed_8371);
												float fragment_unnamed_8785 = mad((-0.0f) - (fragment_unnamed_8740 * fragment_unnamed_8775), fragment_unnamed_8774, fragment_unnamed_8372);
												float fragment_unnamed_8786 = mad((-0.0f) - (fragment_unnamed_8741 * fragment_unnamed_8775), fragment_unnamed_8774, fragment_unnamed_8373);
												float fragment_unnamed_8793 = dot(float3(fragment_unnamed_8768, fragment_unnamed_8769, fragment_unnamed_8770), float3(fragment_unnamed_8784, fragment_unnamed_8785, fragment_unnamed_8786)) / dot(float3(fragment_unnamed_8784, fragment_unnamed_8785, fragment_unnamed_8786), float3(fragment_unnamed_8784, fragment_unnamed_8785, fragment_unnamed_8786));
												float fragment_unnamed_8807 = round(log2(fragment_unnamed_5111 * fragment_uniform_buffer_0[122u].x));
												float fragment_unnamed_8815 = min(fragment_unnamed_8807, max(mad(log2(mad(fragment_unnamed_8754 * (fragment_unnamed_8764 * fragment_unnamed_8764), 3.1415927410125732421875f, 9.9999999392252902907785028219223e-09f)), 0.5f, fragment_unnamed_8807), 0.0f));
												float fragment_unnamed_8829 = 1.0f / (fragment_unnamed_5111 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_8830 = 1.0f / (fragment_unnamed_5113 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_8840 = exp2(ceil(max(fragment_unnamed_8815 + ((-0.0f) - fragment_uniform_buffer_0[123u].z), 0.0f)));
												float fragment_unnamed_8844 = fragment_unnamed_5111 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_8845 = fragment_unnamed_5113 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_8848 = fragment_unnamed_8840 / (fragment_unnamed_8844 + fragment_unnamed_8844);
												float fragment_unnamed_8849 = fragment_unnamed_8840 / (fragment_unnamed_8845 + fragment_unnamed_8845);
												float4 fragment_unnamed_8863 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_8848) + 1.0f, max(fragment_unnamed_8848, mad(clamp(mad((-0.0f) - mad((-0.0f) - fragment_unnamed_8775, fragment_unnamed_8793, dot(float3(fragment_unnamed_8768, fragment_unnamed_8769, fragment_unnamed_8770), float3(fragment_unnamed_8739, fragment_unnamed_8740, fragment_unnamed_8741))), fragment_unnamed_8774, 1.0f), 0.0f, 1.0f), fragment_unnamed_5111 * fragment_unnamed_8829, mad((-0.0f) - fragment_unnamed_8829, fragment_unnamed_5111, 1.0f) * 0.5f))), fragment_unnamed_5111, fragment_unnamed_5129), mad(min(((-0.0f) - fragment_unnamed_8849) + 1.0f, max(fragment_unnamed_8849, mad(clamp(fragment_unnamed_8793, 0.0f, 1.0f), fragment_unnamed_5113 * fragment_unnamed_8830, mad((-0.0f) - fragment_unnamed_8830, fragment_unnamed_5113, 1.0f) * 0.5f))), fragment_unnamed_5113, fragment_unnamed_5131)), fragment_unnamed_8815);
												fragment_unnamed_8871 = fragment_unnamed_8863.x;
												fragment_unnamed_8872 = fragment_unnamed_8863.y;
												fragment_unnamed_8873 = fragment_unnamed_8863.z;
											}
											else
											{
												fragment_unnamed_8871 = asfloat(1065353216u);
												fragment_unnamed_8872 = asfloat(1065353216u);
												fragment_unnamed_8873 = asfloat(1065353216u);
											}
											fragment_unnamed_8699 = fragment_unnamed_8871;
											fragment_unnamed_8700 = fragment_unnamed_8872;
											fragment_unnamed_8701 = fragment_unnamed_8873;
											fragment_unnamed_8702 = max(mad(fragment_unnamed_8583, 0.15915493667125701904296875f, fragment_unnamed_8587) / (sqrt(fragment_unnamed_8587) + 1.0f), 0.0f);
										}
										else
										{
											float fragment_unnamed_8599 = mad((-0.0f) - fragment_unnamed_886, fragment_unnamed_7072, fragment_unnamed_7070) * fragment_unnamed_887;
											float fragment_unnamed_8600 = fragment_unnamed_2861 * fragment_unnamed_7071;
											float fragment_unnamed_8603 = mad((-0.0f) - fragment_unnamed_888, fragment_unnamed_7070, fragment_unnamed_885 * fragment_unnamed_7072) * fragment_unnamed_887;
											float fragment_unnamed_8614 = (1.0f / fragment_unnamed_7376) * ((-0.0f) - fragment_unnamed_7373);
											bool fragment_unnamed_8615 = fragment_unnamed_7376 >= 0.0f;
											float fragment_unnamed_8630 = dot(float3(fragment_unnamed_7631, fragment_unnamed_7634, fragment_unnamed_7376), float3(fragment_unnamed_7631, fragment_unnamed_7634, fragment_unnamed_7376));
											float fragment_unnamed_8633 = rsqrt(fragment_unnamed_8630);
											float fragment_unnamed_8634 = fragment_unnamed_8630 * fragment_unnamed_8633;
											float fragment_unnamed_8635 = fragment_unnamed_8633 * fragment_unnamed_7631;
											float fragment_unnamed_8636 = fragment_unnamed_8633 * fragment_unnamed_7634;
											float fragment_unnamed_8637 = fragment_unnamed_8633 * fragment_unnamed_7376;
											float fragment_unnamed_8638 = dot(float3(fragment_unnamed_8635, fragment_unnamed_8636, fragment_unnamed_8637), float3(fragment_unnamed_7627, fragment_unnamed_7630, fragment_unnamed_7373));
											float fragment_unnamed_8641 = (-0.0f) - fragment_unnamed_8638;
											float fragment_unnamed_8642 = mad(fragment_unnamed_8641, fragment_unnamed_8635, fragment_unnamed_7627);
											float fragment_unnamed_8643 = mad(fragment_unnamed_8641, fragment_unnamed_8636, fragment_unnamed_7630);
											float fragment_unnamed_8644 = mad(fragment_unnamed_8641, fragment_unnamed_8637, fragment_unnamed_7373);
											float fragment_unnamed_8645 = dot(float3(fragment_unnamed_8642, fragment_unnamed_8643, fragment_unnamed_8644), float3(fragment_unnamed_8642, fragment_unnamed_8643, fragment_unnamed_8644));
											float fragment_unnamed_8648 = rsqrt(fragment_unnamed_8645);
											float fragment_unnamed_8650 = fragment_unnamed_8648 * fragment_unnamed_8644;
											float fragment_unnamed_8651 = mad(asfloat(fragment_unnamed_8615 ? asuint(max(fragment_unnamed_8614, fragment_unnamed_5160)) : asuint(min(fragment_unnamed_8614, fragment_unnamed_5160))), fragment_unnamed_8634, fragment_unnamed_8638);
											float fragment_unnamed_8652 = mad(asfloat(fragment_unnamed_8615 ? asuint(max(fragment_unnamed_8614, (-0.0f) - fragment_unnamed_5160)) : asuint(min(fragment_unnamed_8614, (-0.0f) - fragment_unnamed_5160))), fragment_unnamed_8634, fragment_unnamed_8638);
											float fragment_unnamed_8653 = mad(fragment_unnamed_8651, fragment_unnamed_8651, fragment_unnamed_8645);
											float fragment_unnamed_8654 = mad(fragment_unnamed_8652, fragment_unnamed_8652, fragment_unnamed_8645);
											float fragment_unnamed_8656 = rsqrt(fragment_unnamed_8653 * fragment_unnamed_8654);
											float fragment_unnamed_8657 = fragment_unnamed_8656 * fragment_unnamed_8656;
											float fragment_unnamed_8660 = (fragment_unnamed_8645 * fragment_unnamed_8648) * fragment_unnamed_8637;
											float fragment_unnamed_8670 = min(fragment_unnamed_8656 * mad(fragment_unnamed_8652, fragment_unnamed_8651, fragment_unnamed_8645), 1.0f);
											float fragment_unnamed_8674 = sqrt(((-0.0f) - abs(fragment_unnamed_8670)) + 1.0f);
											float fragment_unnamed_8680 = mad(mad(mad(abs(fragment_unnamed_8670), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_8670), -0.212114393711090087890625f), abs(fragment_unnamed_8670), 1.570728778839111328125f);
											fragment_unnamed_8699 = asfloat(1065353216u);
											fragment_unnamed_8700 = asfloat(1065353216u);
											fragment_unnamed_8701 = asfloat(1065353216u);
											fragment_unnamed_8702 = ((fragment_unnamed_7073 * (abs(fragment_unnamed_2862) * rsqrt(fragment_unnamed_7073 * dot(float3(fragment_unnamed_8599, fragment_unnamed_8600, fragment_unnamed_8603), float3(fragment_unnamed_8599, fragment_unnamed_8600, fragment_unnamed_8603))))) * max(mad(mad(fragment_unnamed_8680, fragment_unnamed_8674, asfloat(((fragment_unnamed_8670 < ((-0.0f) - fragment_unnamed_8670)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_8674 * fragment_unnamed_8680, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_8648 * fragment_unnamed_8650, mad(mad(fragment_unnamed_8650, fragment_unnamed_8651, (-0.0f) - fragment_unnamed_8660), fragment_unnamed_8654 * fragment_unnamed_8657, (-0.0f) - ((fragment_unnamed_8653 * fragment_unnamed_8657) * mad(fragment_unnamed_8650, fragment_unnamed_8652, (-0.0f) - fragment_unnamed_8660)))), 0.0f)) * 0.3183098733425140380859375f;
										}
										fragment_unnamed_7640 = fragment_unnamed_8699;
										fragment_unnamed_7642 = fragment_unnamed_8700;
										fragment_unnamed_7644 = fragment_unnamed_8701;
										fragment_unnamed_7646 = fragment_unnamed_8702;
									}
									else
									{
										fragment_unnamed_7640 = asfloat(1065353216u);
										fragment_unnamed_7642 = asfloat(1065353216u);
										fragment_unnamed_7644 = asfloat(1065353216u);
										fragment_unnamed_7646 = asfloat(0u);
									}
									fragment_unnamed_7639 = fragment_unnamed_7640;
									fragment_unnamed_7641 = fragment_unnamed_7642;
									fragment_unnamed_7643 = fragment_unnamed_7644;
									fragment_unnamed_7645 = fragment_unnamed_7646;
								}
								else
								{
									fragment_unnamed_7639 = asfloat(1065353216u);
									fragment_unnamed_7641 = asfloat(1065353216u);
									fragment_unnamed_7643 = asfloat(1065353216u);
									fragment_unnamed_7645 = asfloat(0u);
								}
								float fragment_unnamed_7649 = fragment_unnamed_7645 * (fragment_unnamed_5204 * asfloat(fragment_unnamed_7032.x));
								float fragment_unnamed_8886;
								float fragment_unnamed_8888;
								float fragment_unnamed_8890;
								float fragment_unnamed_8892;
								if (fragment_unnamed_7084 == 0u)
								{
									float fragment_unnamed_8703 = dot(float2(fragment_unnamed_2877, fragment_unnamed_892), float2(fragment_unnamed_7043, fragment_unnamed_7037));
									float fragment_unnamed_8706 = dot(float2(fragment_unnamed_2877, fragment_unnamed_892), float2(fragment_unnamed_7052, fragment_unnamed_7046));
									float fragment_unnamed_8709 = dot(float2(fragment_unnamed_892, fragment_unnamed_2877), float2(fragment_unnamed_7055, fragment_unnamed_7061));
									float fragment_unnamed_8887;
									float fragment_unnamed_8889;
									float fragment_unnamed_8891;
									float fragment_unnamed_8893;
									if (0.0f < mad(fragment_unnamed_5161, abs(fragment_unnamed_8709), mad(fragment_unnamed_5160, abs(fragment_unnamed_8706), fragment_unnamed_8703)))
									{
										float fragment_unnamed_8874 = dot(float2(fragment_unnamed_894, fragment_unnamed_891), float2(fragment_unnamed_7043, fragment_unnamed_7037));
										float fragment_unnamed_8877 = fragment_unnamed_893 * fragment_unnamed_7040;
										float fragment_unnamed_8878 = dot(float2(fragment_unnamed_894, fragment_unnamed_891), float2(fragment_unnamed_7052, fragment_unnamed_7046));
										float fragment_unnamed_8881 = fragment_unnamed_893 * fragment_unnamed_7049;
										float fragment_unnamed_9235;
										float fragment_unnamed_9236;
										float fragment_unnamed_9237;
										float fragment_unnamed_9238;
										if (fragment_unnamed_5146)
										{
											float fragment_unnamed_8904 = dot(float2(fragment_unnamed_891, fragment_unnamed_894), float2(fragment_unnamed_7055, fragment_unnamed_7061));
											float fragment_unnamed_8907 = fragment_unnamed_7058 * fragment_unnamed_893;
											float fragment_unnamed_8908 = (-0.0f) - fragment_unnamed_5160;
											float fragment_unnamed_8912 = (-0.0f) - fragment_unnamed_5161;
											float fragment_unnamed_8913 = mad(fragment_unnamed_8912, fragment_unnamed_8904, mad(fragment_unnamed_8908, fragment_unnamed_8878, fragment_unnamed_8874));
											float fragment_unnamed_8914 = mad(fragment_unnamed_8912, fragment_unnamed_8907, mad(fragment_unnamed_8908, fragment_unnamed_8881, fragment_unnamed_8877));
											float fragment_unnamed_8915 = mad(fragment_unnamed_8912, fragment_unnamed_8709, mad(fragment_unnamed_8908, fragment_unnamed_8706, fragment_unnamed_8703));
											float fragment_unnamed_8916 = fragment_unnamed_5145 * fragment_unnamed_8904;
											float fragment_unnamed_8917 = fragment_unnamed_5145 * fragment_unnamed_8907;
											float fragment_unnamed_8918 = fragment_unnamed_5145 * fragment_unnamed_8709;
											float fragment_unnamed_8919 = mad(fragment_unnamed_5145, fragment_unnamed_8709, fragment_unnamed_8915);
											float fragment_unnamed_8920 = mad(fragment_unnamed_5145, fragment_unnamed_8904, fragment_unnamed_8913);
											float fragment_unnamed_8921 = mad(fragment_unnamed_5145, fragment_unnamed_8907, fragment_unnamed_8914);
											float fragment_unnamed_8922 = mad(fragment_unnamed_5143, fragment_unnamed_8706, fragment_unnamed_8919);
											float fragment_unnamed_8923 = mad(fragment_unnamed_5143, fragment_unnamed_8878, fragment_unnamed_8920);
											float fragment_unnamed_8924 = mad(fragment_unnamed_5143, fragment_unnamed_8881, fragment_unnamed_8921);
											float fragment_unnamed_8925 = (-0.0f) - fragment_unnamed_5145;
											float fragment_unnamed_8926 = mad(fragment_unnamed_8925, fragment_unnamed_8904, fragment_unnamed_8923);
											float fragment_unnamed_8927 = mad(fragment_unnamed_8925, fragment_unnamed_8907, fragment_unnamed_8924);
											float fragment_unnamed_8928 = mad(fragment_unnamed_8925, fragment_unnamed_8709, fragment_unnamed_8922);
											float fragment_unnamed_8932 = rsqrt(dot(float3(fragment_unnamed_8913, fragment_unnamed_8914, fragment_unnamed_8915), float3(fragment_unnamed_8913, fragment_unnamed_8914, fragment_unnamed_8915)));
											float fragment_unnamed_8933 = fragment_unnamed_8932 * fragment_unnamed_8914;
											float fragment_unnamed_8934 = fragment_unnamed_8932 * fragment_unnamed_8915;
											float fragment_unnamed_8935 = fragment_unnamed_8932 * fragment_unnamed_8913;
											float fragment_unnamed_8939 = rsqrt(dot(float3(fragment_unnamed_8919, fragment_unnamed_8920, fragment_unnamed_8921), float3(fragment_unnamed_8919, fragment_unnamed_8920, fragment_unnamed_8921)));
											float fragment_unnamed_8940 = fragment_unnamed_8939 * fragment_unnamed_8919;
											float fragment_unnamed_8941 = fragment_unnamed_8939 * fragment_unnamed_8920;
											float fragment_unnamed_8942 = fragment_unnamed_8939 * fragment_unnamed_8921;
											float fragment_unnamed_8946 = rsqrt(dot(float3(fragment_unnamed_8922, fragment_unnamed_8923, fragment_unnamed_8924), float3(fragment_unnamed_8922, fragment_unnamed_8923, fragment_unnamed_8924)));
											float fragment_unnamed_8947 = fragment_unnamed_8946 * fragment_unnamed_8922;
											float fragment_unnamed_8948 = fragment_unnamed_8946 * fragment_unnamed_8923;
											float fragment_unnamed_8949 = fragment_unnamed_8946 * fragment_unnamed_8924;
											float fragment_unnamed_8953 = rsqrt(dot(float3(fragment_unnamed_8926, fragment_unnamed_8927, fragment_unnamed_8928), float3(fragment_unnamed_8926, fragment_unnamed_8927, fragment_unnamed_8928)));
											float fragment_unnamed_8954 = fragment_unnamed_8953 * fragment_unnamed_8928;
											float fragment_unnamed_8955 = fragment_unnamed_8953 * fragment_unnamed_8926;
											float fragment_unnamed_8956 = fragment_unnamed_8953 * fragment_unnamed_8927;
											float fragment_unnamed_8957 = dot(float3(fragment_unnamed_8934, fragment_unnamed_8935, fragment_unnamed_8933), float3(fragment_unnamed_8940, fragment_unnamed_8941, fragment_unnamed_8942));
											float fragment_unnamed_8987 = mad(abs(fragment_unnamed_8957), mad(abs(fragment_unnamed_8957), mad(abs(fragment_unnamed_8957), mad(abs(fragment_unnamed_8957), mad(abs(fragment_unnamed_8957), mad(abs(fragment_unnamed_8957), mad(abs(fragment_unnamed_8957), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8994 = asfloat((fragment_unnamed_8957 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8957, fragment_unnamed_8957, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8987)) : asuint(fragment_unnamed_8987));
											float fragment_unnamed_8995 = dot(float3(fragment_unnamed_8940, fragment_unnamed_8941, fragment_unnamed_8942), float3(fragment_unnamed_8947, fragment_unnamed_8948, fragment_unnamed_8949));
											float fragment_unnamed_9025 = mad(abs(fragment_unnamed_8995), mad(abs(fragment_unnamed_8995), mad(abs(fragment_unnamed_8995), mad(abs(fragment_unnamed_8995), mad(abs(fragment_unnamed_8995), mad(abs(fragment_unnamed_8995), mad(abs(fragment_unnamed_8995), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9032 = asfloat((fragment_unnamed_8995 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8995, fragment_unnamed_8995, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9025)) : asuint(fragment_unnamed_9025));
											float fragment_unnamed_9039 = dot(float3(fragment_unnamed_8947, fragment_unnamed_8948, fragment_unnamed_8949), float3(fragment_unnamed_8954, fragment_unnamed_8955, fragment_unnamed_8956));
											float fragment_unnamed_9069 = mad(abs(fragment_unnamed_9039), mad(abs(fragment_unnamed_9039), mad(abs(fragment_unnamed_9039), mad(abs(fragment_unnamed_9039), mad(abs(fragment_unnamed_9039), mad(abs(fragment_unnamed_9039), mad(abs(fragment_unnamed_9039), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9076 = asfloat((fragment_unnamed_9039 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9039, fragment_unnamed_9039, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9069)) : asuint(fragment_unnamed_9069));
											float fragment_unnamed_9080 = dot(float3(fragment_unnamed_8956, fragment_unnamed_8954, fragment_unnamed_8955), float3(fragment_unnamed_8933, fragment_unnamed_8934, fragment_unnamed_8935));
											float fragment_unnamed_9110 = mad(abs(fragment_unnamed_9080), mad(abs(fragment_unnamed_9080), mad(abs(fragment_unnamed_9080), mad(abs(fragment_unnamed_9080), mad(abs(fragment_unnamed_9080), mad(abs(fragment_unnamed_9080), mad(abs(fragment_unnamed_9080), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9117 = asfloat((fragment_unnamed_9080 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9080, fragment_unnamed_9080, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9110)) : asuint(fragment_unnamed_9110));
											float fragment_unnamed_9120 = mad(mad(fragment_unnamed_8955, fragment_unnamed_8933, (-0.0f) - (fragment_unnamed_8935 * fragment_unnamed_8956)), fragment_unnamed_9117, mad(mad(fragment_unnamed_8948, fragment_unnamed_8956, (-0.0f) - (fragment_unnamed_8949 * fragment_unnamed_8955)), fragment_unnamed_9076, mad(mad(fragment_unnamed_8935, fragment_unnamed_8942, (-0.0f) - (fragment_unnamed_8941 * fragment_unnamed_8933)), fragment_unnamed_8994, fragment_unnamed_9032 * mad(fragment_unnamed_8941, fragment_unnamed_8949, (-0.0f) - (fragment_unnamed_8942 * fragment_unnamed_8948)))));
											float fragment_unnamed_9121 = mad(mad(fragment_unnamed_8956, fragment_unnamed_8934, (-0.0f) - (fragment_unnamed_8933 * fragment_unnamed_8954)), fragment_unnamed_9117, mad(mad(fragment_unnamed_8949, fragment_unnamed_8954, (-0.0f) - (fragment_unnamed_8947 * fragment_unnamed_8956)), fragment_unnamed_9076, mad(mad(fragment_unnamed_8933, fragment_unnamed_8940, (-0.0f) - (fragment_unnamed_8942 * fragment_unnamed_8934)), fragment_unnamed_8994, fragment_unnamed_9032 * mad(fragment_unnamed_8942, fragment_unnamed_8947, (-0.0f) - (fragment_unnamed_8940 * fragment_unnamed_8949))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9122 = mad(mad(fragment_unnamed_8954, fragment_unnamed_8935, (-0.0f) - (fragment_unnamed_8934 * fragment_unnamed_8955)), fragment_unnamed_9117, mad(mad(fragment_unnamed_8947, fragment_unnamed_8955, (-0.0f) - (fragment_unnamed_8948 * fragment_unnamed_8954)), fragment_unnamed_9076, mad(mad(fragment_unnamed_8934, fragment_unnamed_8941, (-0.0f) - (fragment_unnamed_8940 * fragment_unnamed_8935)), fragment_unnamed_8994, fragment_unnamed_9032 * mad(fragment_unnamed_8940, fragment_unnamed_8948, (-0.0f) - (fragment_unnamed_8941 * fragment_unnamed_8947))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9123 = fragment_unnamed_9120 * 0.15915493667125701904296875f;
											float fragment_unnamed_9124 = dot(float3(fragment_unnamed_9121, fragment_unnamed_9122, fragment_unnamed_9123), float3(fragment_unnamed_9121, fragment_unnamed_9122, fragment_unnamed_9123));
											float fragment_unnamed_9375;
											float fragment_unnamed_9376;
											float fragment_unnamed_9377;
											if (fragment_unnamed_5069 != 0u)
											{
												float fragment_unnamed_9242 = ((-0.0f) - fragment_unnamed_8913) + fragment_unnamed_8926;
												float fragment_unnamed_9243 = ((-0.0f) - fragment_unnamed_8914) + fragment_unnamed_8927;
												float fragment_unnamed_9244 = ((-0.0f) - fragment_unnamed_8915) + fragment_unnamed_8928;
												float fragment_unnamed_9251 = mad(fragment_unnamed_9243, fragment_unnamed_8918, (-0.0f) - (fragment_unnamed_8917 * fragment_unnamed_9244));
												float fragment_unnamed_9252 = mad(fragment_unnamed_9244, fragment_unnamed_8916, (-0.0f) - (fragment_unnamed_8918 * fragment_unnamed_9242));
												float fragment_unnamed_9253 = mad(fragment_unnamed_9242, fragment_unnamed_8917, (-0.0f) - (fragment_unnamed_8916 * fragment_unnamed_9243));
												float fragment_unnamed_9257 = rsqrt(dot(float3(fragment_unnamed_9251, fragment_unnamed_9252, fragment_unnamed_9253), float3(fragment_unnamed_9251, fragment_unnamed_9252, fragment_unnamed_9253)));
												float fragment_unnamed_9258 = fragment_unnamed_9257 * fragment_unnamed_9251;
												float fragment_unnamed_9259 = fragment_unnamed_9257 * fragment_unnamed_9252;
												float fragment_unnamed_9260 = fragment_unnamed_9257 * fragment_unnamed_9253;
												float fragment_unnamed_9267 = dot(float3(fragment_unnamed_8913, fragment_unnamed_8914, fragment_unnamed_8915), float3(fragment_unnamed_9258, fragment_unnamed_9259, fragment_unnamed_9260)) / dot(float3(fragment_unnamed_9121, fragment_unnamed_9122, fragment_unnamed_9123), float3(fragment_unnamed_9258, fragment_unnamed_9259, fragment_unnamed_9260));
												float fragment_unnamed_9271 = mad(fragment_unnamed_9267, fragment_unnamed_9258, (-0.0f) - fragment_unnamed_8913);
												float fragment_unnamed_9272 = mad(fragment_unnamed_9267, fragment_unnamed_9259, (-0.0f) - fragment_unnamed_8914);
												float fragment_unnamed_9273 = mad(fragment_unnamed_9267, fragment_unnamed_9260, (-0.0f) - fragment_unnamed_8915);
												float fragment_unnamed_9277 = 1.0f / dot(float3(fragment_unnamed_9242, fragment_unnamed_9243, fragment_unnamed_9244), float3(fragment_unnamed_9242, fragment_unnamed_9243, fragment_unnamed_9244));
												float fragment_unnamed_9278 = dot(float3(fragment_unnamed_8916, fragment_unnamed_8917, fragment_unnamed_8918), float3(fragment_unnamed_9242, fragment_unnamed_9243, fragment_unnamed_9244));
												float fragment_unnamed_9287 = mad((-0.0f) - (fragment_unnamed_9242 * fragment_unnamed_9278), fragment_unnamed_9277, fragment_unnamed_8916);
												float fragment_unnamed_9288 = mad((-0.0f) - (fragment_unnamed_9243 * fragment_unnamed_9278), fragment_unnamed_9277, fragment_unnamed_8917);
												float fragment_unnamed_9289 = mad((-0.0f) - (fragment_unnamed_9244 * fragment_unnamed_9278), fragment_unnamed_9277, fragment_unnamed_8918);
												float fragment_unnamed_9296 = dot(float3(fragment_unnamed_9271, fragment_unnamed_9272, fragment_unnamed_9273), float3(fragment_unnamed_9287, fragment_unnamed_9288, fragment_unnamed_9289)) / dot(float3(fragment_unnamed_9287, fragment_unnamed_9288, fragment_unnamed_9289), float3(fragment_unnamed_9287, fragment_unnamed_9288, fragment_unnamed_9289));
												float fragment_unnamed_9309 = round(log2(fragment_unnamed_5111 * fragment_uniform_buffer_0[122u].x));
												float fragment_unnamed_9319 = min(mad(fragment_unnamed_2868, ((-0.0f) - fragment_unnamed_9309) + 3.0f, fragment_unnamed_9309), max(mad(log2(mad(fragment_unnamed_9257 * (fragment_unnamed_9267 * fragment_unnamed_9267), 3.1415927410125732421875f, 9.9999999392252902907785028219223e-09f)), 0.5f, fragment_unnamed_9309), 0.0f));
												float fragment_unnamed_9333 = 1.0f / (fragment_unnamed_5111 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_9334 = 1.0f / (fragment_unnamed_5113 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_9344 = exp2(ceil(max(fragment_unnamed_9319 + ((-0.0f) - fragment_uniform_buffer_0[123u].z), 0.0f)));
												float fragment_unnamed_9348 = fragment_unnamed_5111 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_9349 = fragment_unnamed_5113 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_9352 = fragment_unnamed_9344 / (fragment_unnamed_9348 + fragment_unnamed_9348);
												float fragment_unnamed_9353 = fragment_unnamed_9344 / (fragment_unnamed_9349 + fragment_unnamed_9349);
												float4 fragment_unnamed_9367 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_9352) + 1.0f, max(fragment_unnamed_9352, mad(clamp(mad((-0.0f) - mad((-0.0f) - fragment_unnamed_9278, fragment_unnamed_9296, dot(float3(fragment_unnamed_9271, fragment_unnamed_9272, fragment_unnamed_9273), float3(fragment_unnamed_9242, fragment_unnamed_9243, fragment_unnamed_9244))), fragment_unnamed_9277, 1.0f), 0.0f, 1.0f), fragment_unnamed_5111 * fragment_unnamed_9333, mad((-0.0f) - fragment_unnamed_9333, fragment_unnamed_5111, 1.0f) * 0.5f))), fragment_unnamed_5111, fragment_unnamed_5129), mad(min(((-0.0f) - fragment_unnamed_9353) + 1.0f, max(fragment_unnamed_9353, mad(clamp(fragment_unnamed_9296, 0.0f, 1.0f), fragment_unnamed_5113 * fragment_unnamed_9334, mad((-0.0f) - fragment_unnamed_9334, fragment_unnamed_5113, 1.0f) * 0.5f))), fragment_unnamed_5113, fragment_unnamed_5131)), fragment_unnamed_9319);
												fragment_unnamed_9375 = fragment_unnamed_9367.x;
												fragment_unnamed_9376 = fragment_unnamed_9367.y;
												fragment_unnamed_9377 = fragment_unnamed_9367.z;
											}
											else
											{
												fragment_unnamed_9375 = asfloat(1065353216u);
												fragment_unnamed_9376 = asfloat(1065353216u);
												fragment_unnamed_9377 = asfloat(1065353216u);
											}
											fragment_unnamed_9235 = fragment_unnamed_9375;
											fragment_unnamed_9236 = fragment_unnamed_9376;
											fragment_unnamed_9237 = fragment_unnamed_9377;
											fragment_unnamed_9238 = max(mad(fragment_unnamed_9120, 0.15915493667125701904296875f, fragment_unnamed_9124) / (sqrt(fragment_unnamed_9124) + 1.0f), 0.0f);
										}
										else
										{
											float fragment_unnamed_9136 = mad((-0.0f) - fragment_unnamed_892, fragment_unnamed_7072, fragment_unnamed_7070) * fragment_unnamed_893;
											float fragment_unnamed_9137 = fragment_unnamed_2870 * fragment_unnamed_7071;
											float fragment_unnamed_9140 = mad((-0.0f) - fragment_unnamed_894, fragment_unnamed_7070, fragment_unnamed_891 * fragment_unnamed_7072) * fragment_unnamed_893;
											float fragment_unnamed_9151 = (1.0f / fragment_unnamed_8706) * ((-0.0f) - fragment_unnamed_8703);
											bool fragment_unnamed_9152 = fragment_unnamed_8706 >= 0.0f;
											float fragment_unnamed_9167 = dot(float3(fragment_unnamed_8878, fragment_unnamed_8881, fragment_unnamed_8706), float3(fragment_unnamed_8878, fragment_unnamed_8881, fragment_unnamed_8706));
											float fragment_unnamed_9170 = rsqrt(fragment_unnamed_9167);
											float fragment_unnamed_9171 = fragment_unnamed_9167 * fragment_unnamed_9170;
											float fragment_unnamed_9172 = fragment_unnamed_9170 * fragment_unnamed_8878;
											float fragment_unnamed_9173 = fragment_unnamed_9170 * fragment_unnamed_8881;
											float fragment_unnamed_9174 = fragment_unnamed_9170 * fragment_unnamed_8706;
											float fragment_unnamed_9175 = dot(float3(fragment_unnamed_9172, fragment_unnamed_9173, fragment_unnamed_9174), float3(fragment_unnamed_8874, fragment_unnamed_8877, fragment_unnamed_8703));
											float fragment_unnamed_9178 = (-0.0f) - fragment_unnamed_9175;
											float fragment_unnamed_9179 = mad(fragment_unnamed_9178, fragment_unnamed_9172, fragment_unnamed_8874);
											float fragment_unnamed_9180 = mad(fragment_unnamed_9178, fragment_unnamed_9173, fragment_unnamed_8877);
											float fragment_unnamed_9181 = mad(fragment_unnamed_9178, fragment_unnamed_9174, fragment_unnamed_8703);
											float fragment_unnamed_9182 = dot(float3(fragment_unnamed_9179, fragment_unnamed_9180, fragment_unnamed_9181), float3(fragment_unnamed_9179, fragment_unnamed_9180, fragment_unnamed_9181));
											float fragment_unnamed_9185 = rsqrt(fragment_unnamed_9182);
											float fragment_unnamed_9187 = fragment_unnamed_9185 * fragment_unnamed_9181;
											float fragment_unnamed_9188 = mad(asfloat(fragment_unnamed_9152 ? asuint(max(fragment_unnamed_9151, fragment_unnamed_5160)) : asuint(min(fragment_unnamed_9151, fragment_unnamed_5160))), fragment_unnamed_9171, fragment_unnamed_9175);
											float fragment_unnamed_9189 = mad(asfloat(fragment_unnamed_9152 ? asuint(max(fragment_unnamed_9151, (-0.0f) - fragment_unnamed_5160)) : asuint(min(fragment_unnamed_9151, (-0.0f) - fragment_unnamed_5160))), fragment_unnamed_9171, fragment_unnamed_9175);
											float fragment_unnamed_9190 = mad(fragment_unnamed_9188, fragment_unnamed_9188, fragment_unnamed_9182);
											float fragment_unnamed_9191 = mad(fragment_unnamed_9189, fragment_unnamed_9189, fragment_unnamed_9182);
											float fragment_unnamed_9193 = rsqrt(fragment_unnamed_9190 * fragment_unnamed_9191);
											float fragment_unnamed_9194 = fragment_unnamed_9193 * fragment_unnamed_9193;
											float fragment_unnamed_9197 = (fragment_unnamed_9182 * fragment_unnamed_9185) * fragment_unnamed_9174;
											float fragment_unnamed_9207 = min(fragment_unnamed_9193 * mad(fragment_unnamed_9189, fragment_unnamed_9188, fragment_unnamed_9182), 1.0f);
											float fragment_unnamed_9211 = sqrt(((-0.0f) - abs(fragment_unnamed_9207)) + 1.0f);
											float fragment_unnamed_9217 = mad(mad(mad(abs(fragment_unnamed_9207), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_9207), -0.212114393711090087890625f), abs(fragment_unnamed_9207), 1.570728778839111328125f);
											fragment_unnamed_9235 = asfloat(1065353216u);
											fragment_unnamed_9236 = asfloat(1065353216u);
											fragment_unnamed_9237 = asfloat(1065353216u);
											fragment_unnamed_9238 = (max(mad(mad(fragment_unnamed_9217, fragment_unnamed_9211, asfloat(((fragment_unnamed_9207 < ((-0.0f) - fragment_unnamed_9207)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_9211 * fragment_unnamed_9217, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_9185 * fragment_unnamed_9187, mad(mad(fragment_unnamed_9187, fragment_unnamed_9188, (-0.0f) - fragment_unnamed_9197), fragment_unnamed_9191 * fragment_unnamed_9194, (-0.0f) - ((fragment_unnamed_9190 * fragment_unnamed_9194) * mad(fragment_unnamed_9187, fragment_unnamed_9189, (-0.0f) - fragment_unnamed_9197)))), 0.0f) * (fragment_unnamed_7073 * (abs(fragment_unnamed_2871) * rsqrt(fragment_unnamed_7073 * dot(float3(fragment_unnamed_9136, fragment_unnamed_9137, fragment_unnamed_9140), float3(fragment_unnamed_9136, fragment_unnamed_9137, fragment_unnamed_9140)))))) * 0.3183098733425140380859375f;
										}
										fragment_unnamed_8887 = fragment_unnamed_9235;
										fragment_unnamed_8889 = fragment_unnamed_9236;
										fragment_unnamed_8891 = fragment_unnamed_9237;
										fragment_unnamed_8893 = fragment_unnamed_9238;
									}
									else
									{
										fragment_unnamed_8887 = asfloat(1065353216u);
										fragment_unnamed_8889 = asfloat(1065353216u);
										fragment_unnamed_8891 = asfloat(1065353216u);
										fragment_unnamed_8893 = asfloat(0u);
									}
									fragment_unnamed_8886 = fragment_unnamed_8887;
									fragment_unnamed_8888 = fragment_unnamed_8889;
									fragment_unnamed_8890 = fragment_unnamed_8891;
									fragment_unnamed_8892 = fragment_unnamed_8893;
								}
								else
								{
									fragment_unnamed_8886 = asfloat(1065353216u);
									fragment_unnamed_8888 = asfloat(1065353216u);
									fragment_unnamed_8890 = asfloat(1065353216u);
									fragment_unnamed_8892 = asfloat(0u);
								}
								float fragment_unnamed_8894 = (fragment_unnamed_5204 * asfloat(fragment_unnamed_7032.y)) * fragment_unnamed_8892;
								fragment_unnamed_7391 = fragment_unnamed_6529 * (fragment_unnamed_8894 * (fragment_unnamed_853 * fragment_unnamed_8886));
								fragment_unnamed_7393 = fragment_unnamed_6531 * (fragment_unnamed_8894 * (fragment_unnamed_854 * fragment_unnamed_8888));
								fragment_unnamed_7395 = fragment_unnamed_6533 * (fragment_unnamed_8894 * (fragment_unnamed_855 * fragment_unnamed_8890));
								fragment_unnamed_7397 = (fragment_unnamed_7649 * fragment_unnamed_7639) * (fragment_unnamed_777 * fragment_unnamed_6529);
								fragment_unnamed_7399 = (fragment_unnamed_7649 * fragment_unnamed_7641) * (fragment_unnamed_777 * fragment_unnamed_6531);
								fragment_unnamed_7401 = (fragment_unnamed_7649 * fragment_unnamed_7643) * (fragment_unnamed_777 * fragment_unnamed_6533);
							}
							else
							{
								fragment_unnamed_7391 = asfloat(0u);
								fragment_unnamed_7393 = asfloat(0u);
								fragment_unnamed_7395 = asfloat(0u);
								fragment_unnamed_7397 = asfloat(0u);
								fragment_unnamed_7399 = asfloat(0u);
								fragment_unnamed_7401 = asfloat(0u);
							}
							fragment_unnamed_3475 = fragment_unnamed_3474 + fragment_unnamed_7397;
							fragment_unnamed_3477 = fragment_unnamed_3476 + fragment_unnamed_7399;
							fragment_unnamed_3479 = fragment_unnamed_3478 + fragment_unnamed_7401;
							fragment_unnamed_3481 = fragment_unnamed_3480 + fragment_unnamed_7391;
							fragment_unnamed_3483 = fragment_unnamed_3482 + fragment_unnamed_7393;
							fragment_unnamed_3485 = fragment_unnamed_3484 + fragment_unnamed_7395;
							fragment_unnamed_3474 = fragment_unnamed_3475;
							fragment_unnamed_3476 = fragment_unnamed_3477;
							fragment_unnamed_3478 = fragment_unnamed_3479;
							fragment_unnamed_3480 = fragment_unnamed_3481;
							fragment_unnamed_3482 = fragment_unnamed_3483;
							fragment_unnamed_3484 = fragment_unnamed_3485;
							fragment_unnamed_3486 = fragment_unnamed_3487;
							continue;
						}
					}
					if (ladder_phi_84)
					{
						break;
					}
					break;
				}
				float fragment_unnamed_3813 = min(fragment_unnamed_424, 1.0f);
				float fragment_unnamed_3864 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_3868 = mad(mad(fragment_uniform_buffer_3[4u].x, fragment_unnamed_408.x, mad(fragment_unnamed_750, fragment_unnamed_3474, max(fragment_unnamed_3813, fragment_unnamed_3813 * mad(mad(fragment_unnamed_3813, mad(fragment_unnamed_750, 2.040400028228759765625f, -0.3323999941349029541015625f), mad(fragment_unnamed_750, -4.79510021209716796875f, 0.6417000293731689453125f)), fragment_unnamed_3813, mad(fragment_unnamed_750, 2.755199909210205078125f, 0.69029998779296875f))) * (((fragment_unnamed_777 * mad(fragment_unnamed_789, mad((-0.0f) - fragment_unnamed_362, fragment_unnamed_749, fragment_unnamed_757), fragment_unnamed_750)) * fragment_unnamed_743) * fragment_unnamed_821))), fragment_unnamed_3864, fragment_unnamed_3864 * (mad(fragment_unnamed_823 * fragment_unnamed_2274, max(mad(fragment_unnamed_757, 2.755199909210205078125f, mad(fragment_unnamed_757, -4.79510021209716796875f, mad(fragment_unnamed_757, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_3480) * mad(fragment_unnamed_757, fragment_unnamed_857, 1.0f)));
				float fragment_unnamed_3869 = mad(mad(fragment_uniform_buffer_3[4u].x, fragment_unnamed_408.y, mad(fragment_unnamed_751, fragment_unnamed_3476, max(fragment_unnamed_3813, fragment_unnamed_3813 * mad(mad(fragment_unnamed_3813, mad(fragment_unnamed_751, 2.040400028228759765625f, -0.3323999941349029541015625f), mad(fragment_unnamed_751, -4.79510021209716796875f, 0.6417000293731689453125f)), fragment_unnamed_3813, mad(fragment_unnamed_751, 2.755199909210205078125f, 0.69029998779296875f))) * (((fragment_unnamed_777 * mad(fragment_unnamed_789, mad((-0.0f) - fragment_unnamed_363, fragment_unnamed_749, fragment_unnamed_759), fragment_unnamed_751)) * fragment_unnamed_744) * fragment_unnamed_821))), fragment_unnamed_3864, fragment_unnamed_3864 * (mad(fragment_unnamed_823 * fragment_unnamed_2276, max(mad(fragment_unnamed_759, 2.755199909210205078125f, mad(fragment_unnamed_759, -4.79510021209716796875f, mad(fragment_unnamed_759, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_3482) * mad(fragment_unnamed_759, fragment_unnamed_857, 1.0f)));
				float fragment_unnamed_3870 = mad(mad(fragment_uniform_buffer_3[4u].x, fragment_unnamed_408.z, mad(fragment_unnamed_752, fragment_unnamed_3478, max(fragment_unnamed_3813, fragment_unnamed_3813 * mad(mad(fragment_unnamed_3813, mad(fragment_unnamed_752, 2.040400028228759765625f, -0.3323999941349029541015625f), mad(fragment_unnamed_752, -4.79510021209716796875f, 0.6417000293731689453125f)), fragment_unnamed_3813, mad(fragment_unnamed_752, 2.755199909210205078125f, 0.69029998779296875f))) * (((fragment_unnamed_777 * mad(fragment_unnamed_789, mad((-0.0f) - fragment_unnamed_364, fragment_unnamed_749, fragment_unnamed_760), fragment_unnamed_752)) * fragment_unnamed_745) * fragment_unnamed_821))), fragment_unnamed_3864, fragment_unnamed_3864 * (mad(fragment_unnamed_823 * fragment_unnamed_2278, max(mad(fragment_unnamed_760, 2.755199909210205078125f, mad(fragment_unnamed_760, -4.79510021209716796875f, mad(fragment_unnamed_760, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_3484) * mad(fragment_unnamed_760, fragment_unnamed_857, 1.0f)));
				uint fragment_unnamed_5005;
				float fragment_unnamed_5007;
				float fragment_unnamed_5009;
				float fragment_unnamed_5011;
				float fragment_unnamed_5013;
				if (asuint(fragment_uniform_buffer_0[211u]).y != 1u)
				{
					float fragment_unnamed_4467 = float(fragment_unnamed_284);
					float fragment_unnamed_4468 = float(fragment_unnamed_285);
					uint fragment_unnamed_4488 = min(T23.Load(1u).x, max(((-T23.Load(0u).x) + 4294967295u), uint(round(dot(float2(fragment_unnamed_4467, fragment_unnamed_4468), float2(fragment_uniform_buffer_0[103u].y * 1.0f, fragment_uniform_buffer_0[103u].x * (-1.0f))) + ((-0.0f) - fragment_uniform_buffer_0[102u].x)))));
					bool fragment_unnamed_4520 = ((((-0.0f) - float((T23.Load(fragment_unnamed_4488 + 2u).x & 65535u) + 4294967295u)) + floor(dot(float2(fragment_unnamed_4467, fragment_unnamed_4468), float2(fragment_uniform_buffer_0[103u].xy)) + ((-0.0f) - fragment_uniform_buffer_0[102u].z))) / (((-0.0f) - fragment_uniform_buffer_0[102u].z) + fragment_uniform_buffer_0[102u].w)) < 0.0f;
					uint fragment_unnamed_4521 = fragment_unnamed_4520 ? 4294967295u : 0u;
					float fragment_unnamed_4522 = asfloat(fragment_unnamed_4521);
					uint fragment_unnamed_5006;
					float fragment_unnamed_5008;
					float fragment_unnamed_5010;
					float fragment_unnamed_5012;
					float fragment_unnamed_5014;
					if (asuint(fragment_uniform_buffer_0[113u]).x != 0u)
					{
						float4 fragment_unnamed_4957 = _RefractiveDepthBuffer.Load(int4(uint3(fragment_unnamed_284, fragment_unnamed_285, 0u), 0u));
						float fragment_unnamed_4959 = fragment_unnamed_4957.x;
						uint4 fragment_unnamed_4960 = _StencilTexture.Load(int4(uint3(fragment_unnamed_284, fragment_unnamed_285, 0u), 0u));
						uint fragment_unnamed_4962 = fragment_unnamed_4960.y;
						uint fragment_unnamed_4964 = fragment_unnamed_4962 & 32u;
						uint fragment_unnamed_5000 = ((fragment_unnamed_4962 & 1u) != 0u) ? 4294967295u : (((((((fragment_unnamed_4959 >= gl_FragCoord.z) ? 4294967295u : 0u) & (fragment_unnamed_4521 & ((fragment_unnamed_4964 != 0u) ? 4294967295u : 0u))) != 0u) ? 3.4028234663852885981170418348452e+38f : gl_FragCoord.z) < asfloat(fragment_unnamed_4520 ? 2139095039u : ((fragment_unnamed_4964 != 0u) ? asuint(fragment_unnamed_4959) : 0u))) ? (fragment_unnamed_4520 ? asuint(fragment_uniform_buffer_0[107u]).x : (uint(_WaterGBufferTexture3.Load(int4(uint3(fragment_unnamed_284, fragment_unnamed_285, 0u), 0u)).w * 255.0f) & 15u)) : 4294967295u);
						uint fragment_unnamed_6047;
						float fragment_unnamed_6048;
						float fragment_unnamed_6049;
						float fragment_unnamed_6050;
						float fragment_unnamed_6051;
						if (fragment_unnamed_5000 == 4294967295u)
						{
							fragment_unnamed_6047 = 0u;
							fragment_unnamed_6048 = asfloat(0u);
							fragment_unnamed_6049 = asfloat(0u);
							fragment_unnamed_6050 = asfloat(0u);
							fragment_unnamed_6051 = asfloat(0u);
						}
						else
						{
							uint fragment_unnamed_6204;
							float fragment_unnamed_6205;
							float fragment_unnamed_6206;
							if (fragment_unnamed_4521 == 0u)
							{
								uint fragment_unnamed_6208 = (fragment_unnamed_5000 * 28u) + 4u;
								uint3 fragment_unnamed_6217 = uint3(T25.Load(fragment_unnamed_6208).x, T25.Load(fragment_unnamed_6208 + 1u).x, T25.Load(fragment_unnamed_6208 + 2u).x);
								float fragment_unnamed_6230 = mad(fragment_unnamed_4467 * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
								float fragment_unnamed_6232 = (-0.0f) - mad(fragment_unnamed_4468 * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
								float fragment_unnamed_6272 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_4959, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_6230, fragment_unnamed_6232 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
								float fragment_unnamed_6285 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_4959, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_6230, fragment_unnamed_6232 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_6272)) + fragment_input_5.x;
								float fragment_unnamed_6286 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_4959, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_6230, fragment_unnamed_6232 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_6272)) + fragment_input_5.y;
								float fragment_unnamed_6287 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_4959, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_6230, fragment_unnamed_6232 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_6272)) + fragment_input_5.z;
								float fragment_unnamed_6291 = sqrt(dot(float3(fragment_unnamed_6285, fragment_unnamed_6286, fragment_unnamed_6287), float3(fragment_unnamed_6285, fragment_unnamed_6286, fragment_unnamed_6287)));
								float fragment_unnamed_6292 = fragment_unnamed_6291 + fragment_unnamed_6291;
								fragment_unnamed_6204 = asuint(((-0.0f) - exp2((asfloat(fragment_unnamed_6217.z) * fragment_unnamed_6292) * (-1.44269502162933349609375f))) + 1.0f);
								fragment_unnamed_6205 = ((-0.0f) - exp2((asfloat(fragment_unnamed_6217.y) * fragment_unnamed_6292) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_6206 = ((-0.0f) - exp2((asfloat(fragment_unnamed_6217.x) * fragment_unnamed_6292) * (-1.44269502162933349609375f))) + 1.0f;
							}
							else
							{
								fragment_unnamed_6204 = 0u;
								fragment_unnamed_6205 = asfloat(0u);
								fragment_unnamed_6206 = asfloat(0u);
							}
							fragment_unnamed_6047 = fragment_unnamed_6204;
							fragment_unnamed_6048 = asfloat(~fragment_unnamed_4521);
							fragment_unnamed_6049 = fragment_unnamed_6205;
							fragment_unnamed_6050 = fragment_unnamed_6206;
							fragment_unnamed_6051 = fragment_unnamed_4522;
						}
						fragment_unnamed_5006 = fragment_unnamed_6047;
						fragment_unnamed_5008 = fragment_unnamed_6048;
						fragment_unnamed_5010 = fragment_unnamed_6049;
						fragment_unnamed_5012 = fragment_unnamed_6050;
						fragment_unnamed_5014 = fragment_unnamed_6051;
					}
					else
					{
						fragment_unnamed_5006 = 0u;
						fragment_unnamed_5008 = asfloat(0u);
						fragment_unnamed_5010 = asfloat(0u);
						fragment_unnamed_5012 = asfloat(0u);
						fragment_unnamed_5014 = fragment_unnamed_4522;
					}
					fragment_unnamed_5005 = fragment_unnamed_5006;
					fragment_unnamed_5007 = fragment_unnamed_5008;
					fragment_unnamed_5009 = fragment_unnamed_5010;
					fragment_unnamed_5011 = fragment_unnamed_5012;
					fragment_unnamed_5013 = fragment_unnamed_5014;
				}
				else
				{
					fragment_unnamed_5005 = 0u;
					fragment_unnamed_5007 = asfloat(0u);
					fragment_unnamed_5009 = asfloat(0u);
					fragment_unnamed_5011 = asfloat(0u);
					fragment_unnamed_5013 = asfloat(0u);
				}
				uint fragment_unnamed_6320;
				float fragment_unnamed_6322;
				float fragment_unnamed_6324;
				float fragment_unnamed_6326;
				float fragment_unnamed_6328;
				float fragment_unnamed_6330;
				if (asuint(fragment_unnamed_5007) == 0u)
				{
					float fragment_unnamed_6058 = 1.0f / dot(float3(fragment_unnamed_863, fragment_unnamed_864, fragment_unnamed_865), float3((-0.0f) - asfloat(fragment_unnamed_321), (-0.0f) - asfloat(fragment_unnamed_326), (-0.0f) - asfloat(fragment_unnamed_331)));
					float fragment_unnamed_6062 = fragment_unnamed_6058 * (1.0f / gl_FragCoord.w);
					uint fragment_unnamed_6710;
					float fragment_unnamed_6712;
					float fragment_unnamed_6714;
					float fragment_unnamed_6716;
					float fragment_unnamed_6718;
					float fragment_unnamed_6720;
					float fragment_unnamed_6721;
					if (asuint(fragment_uniform_buffer_0[84u]).x != 0u)
					{
						float fragment_unnamed_6722;
						float fragment_unnamed_7281;
						float fragment_unnamed_7283;
						float fragment_unnamed_7285;
						float fragment_unnamed_7287;
						if (asuint(fragment_uniform_buffer_0[84u]).z != 0u)
						{
							float fragment_unnamed_6698 = mad((-0.0f) - fragment_uniform_buffer_0[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_0[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6058, (-0.0f) - fragment_uniform_buffer_0[94u].z), 0.0f)), fragment_uniform_buffer_0[94u].x));
							float fragment_unnamed_7433;
							float fragment_unnamed_7434;
							float fragment_unnamed_7435;
							float fragment_unnamed_7436;
							if (asuint(fragment_uniform_buffer_0[89u]).w == 0u)
							{
								float fragment_unnamed_7109 = fragment_unnamed_294 * fragment_uniform_buffer_0[91u].x;
								float fragment_unnamed_7110 = fragment_unnamed_295 * fragment_uniform_buffer_0[91u].y;
								float fragment_unnamed_7111 = floor(fragment_unnamed_7109);
								float fragment_unnamed_7112 = floor(fragment_unnamed_7110);
								float fragment_unnamed_7117 = ((-0.0f) - frac(fragment_unnamed_7109)) + 1.0f;
								float fragment_unnamed_7118 = ((-0.0f) - frac(fragment_unnamed_7110)) + 1.0f;
								float fragment_unnamed_7119 = fragment_unnamed_7118 * fragment_unnamed_7118;
								float fragment_unnamed_7120 = fragment_unnamed_7117 * fragment_unnamed_7117;
								float fragment_unnamed_7125 = mad(((-0.0f) - fragment_unnamed_7117) + 1.0f, fragment_unnamed_7117, 0.5f);
								float fragment_unnamed_7126 = mad(((-0.0f) - fragment_unnamed_7118) + 1.0f, fragment_unnamed_7118, 0.5f);
								float fragment_unnamed_7133 = ((-0.0f) - fragment_unnamed_7125) + mad((-0.0f) - fragment_unnamed_7120, 0.5f, 1.0f);
								float fragment_unnamed_7134 = ((-0.0f) - fragment_unnamed_7126) + mad((-0.0f) - fragment_unnamed_7119, 0.5f, 1.0f);
								float fragment_unnamed_7135 = fragment_unnamed_7125 * 0.5f;
								float fragment_unnamed_7136 = fragment_unnamed_7126 * 0.5f;
								float fragment_unnamed_7137 = mad(fragment_unnamed_7119, 0.5f, fragment_unnamed_7136);
								float fragment_unnamed_7138 = mad(fragment_unnamed_7120, 0.5f, fragment_unnamed_7135);
								float fragment_unnamed_7139 = mad(fragment_unnamed_7125, 0.5f, fragment_unnamed_7133);
								float fragment_unnamed_7140 = mad(fragment_unnamed_7126, 0.5f, fragment_unnamed_7134);
								float fragment_unnamed_7143 = mad(fragment_unnamed_7135, 1.0f / fragment_unnamed_7138, -0.5f);
								float fragment_unnamed_7144 = mad(fragment_unnamed_7136, 1.0f / fragment_unnamed_7137, -0.5f);
								float fragment_unnamed_7147 = mad(fragment_unnamed_7133, 1.0f / fragment_unnamed_7139, 0.5f);
								float fragment_unnamed_7148 = mad(fragment_unnamed_7134, 1.0f / fragment_unnamed_7140, 0.5f);
								float fragment_unnamed_7158 = fragment_uniform_buffer_0[91u].z * fragment_uniform_buffer_0[92u].x;
								float fragment_unnamed_7159 = fragment_uniform_buffer_0[91u].w * fragment_uniform_buffer_0[92u].y;
								float fragment_unnamed_7179 = fragment_unnamed_6698 * fragment_uniform_buffer_0[92u].z;
								float fragment_unnamed_7180 = fragment_unnamed_7137 * fragment_unnamed_7138;
								float4 fragment_unnamed_7191 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7158 * (fragment_unnamed_7111 + fragment_unnamed_7143), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7159 * (fragment_unnamed_7112 + fragment_unnamed_7144), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7179, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_7197 = fragment_unnamed_7137 * fragment_unnamed_7139;
								float fragment_unnamed_7198 = fragment_unnamed_7138 * fragment_unnamed_7140;
								float4 fragment_unnamed_7207 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7158 * (fragment_unnamed_7111 + fragment_unnamed_7147), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7159 * (fragment_unnamed_7112 + fragment_unnamed_7144), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7179, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float4 fragment_unnamed_7229 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7158 * (fragment_unnamed_7111 + fragment_unnamed_7143), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7159 * (fragment_unnamed_7112 + fragment_unnamed_7148), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7179, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_7239 = fragment_unnamed_7140 * fragment_unnamed_7139;
								float4 fragment_unnamed_7248 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7158 * (fragment_unnamed_7111 + fragment_unnamed_7147), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7159 * (fragment_unnamed_7112 + fragment_unnamed_7148), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7179, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_7433 = mad(fragment_unnamed_7239, fragment_unnamed_7248.w, mad(fragment_unnamed_7198, fragment_unnamed_7229.w, mad(fragment_unnamed_7180, fragment_unnamed_7191.w, fragment_unnamed_7197 * fragment_unnamed_7207.w)));
								fragment_unnamed_7434 = mad(fragment_unnamed_7239, fragment_unnamed_7248.z, mad(fragment_unnamed_7198, fragment_unnamed_7229.z, mad(fragment_unnamed_7180, fragment_unnamed_7191.z, fragment_unnamed_7197 * fragment_unnamed_7207.z)));
								fragment_unnamed_7435 = mad(fragment_unnamed_7239, fragment_unnamed_7248.y, mad(fragment_unnamed_7198, fragment_unnamed_7229.y, mad(fragment_unnamed_7180, fragment_unnamed_7191.y, fragment_unnamed_7197 * fragment_unnamed_7207.y)));
								fragment_unnamed_7436 = mad(fragment_unnamed_7239, fragment_unnamed_7248.x, mad(fragment_unnamed_7198, fragment_unnamed_7229.x, mad(fragment_unnamed_7180, fragment_unnamed_7191.x, fragment_unnamed_7197 * fragment_unnamed_7207.x)));
							}
							else
							{
								float4 fragment_unnamed_7275 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_294 * fragment_uniform_buffer_0[92u].x, fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_295 * fragment_uniform_buffer_0[92u].y, fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_6698 * fragment_uniform_buffer_0[92u].z, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_7433 = fragment_unnamed_7275.w;
								fragment_unnamed_7434 = fragment_unnamed_7275.z;
								fragment_unnamed_7435 = fragment_unnamed_7275.y;
								fragment_unnamed_7436 = fragment_unnamed_7275.x;
							}
							float fragment_unnamed_7282 = ((-0.0f) - exp2(fragment_unnamed_7433 * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_7445 = asfloat((fragment_unnamed_7282 >= 5.9604644775390625e-08f) ? asuint(fragment_unnamed_7282 * (1.0f / fragment_unnamed_7433)) : 1065353216u);
							fragment_unnamed_7281 = fragment_unnamed_7282;
							fragment_unnamed_7283 = fragment_unnamed_7434 * fragment_unnamed_7445;
							fragment_unnamed_7285 = fragment_unnamed_7435 * fragment_unnamed_7445;
							fragment_unnamed_7287 = fragment_unnamed_7436 * fragment_unnamed_7445;
							fragment_unnamed_6722 = asfloat(asuint(fragment_uniform_buffer_0[96u]).w);
						}
						else
						{
							fragment_unnamed_7281 = asfloat(0u);
							fragment_unnamed_7283 = asfloat(0u);
							fragment_unnamed_7285 = asfloat(0u);
							fragment_unnamed_7287 = asfloat(0u);
							fragment_unnamed_6722 = asfloat(0u);
						}
						float fragment_unnamed_7294 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_6058, (-0.0f) - fragment_unnamed_6722);
						float fragment_unnamed_6713;
						float fragment_unnamed_6715;
						float fragment_unnamed_6717;
						float fragment_unnamed_6719;
						if ((((0.0f < fragment_unnamed_7294) ? 4294967295u : 0u) & (~asuint(fragment_unnamed_5013))) != 0u)
						{
							float fragment_unnamed_7455 = dot(float3(fragment_unnamed_346, fragment_unnamed_347, fragment_unnamed_348), float3(fragment_uniform_buffer_0[83u].xyz));
							float fragment_unnamed_7459 = fragment_unnamed_6722 * ((-0.0f) - fragment_unnamed_7455);
							float fragment_unnamed_7472 = max(abs(fragment_unnamed_7455), 0.001000000047497451305389404296875f);
							float fragment_unnamed_7473 = 1.0f / fragment_unnamed_7472;
							float fragment_unnamed_7476 = min(mad(fragment_unnamed_7294, (-0.0f) - fragment_unnamed_7455, fragment_unnamed_7459), fragment_unnamed_7459);
							float fragment_unnamed_7490 = min(fragment_unnamed_7294, max(fragment_unnamed_7473 * (((-0.0f) - fragment_unnamed_7476) + fragment_uniform_buffer_0[89u].y), 0.0f));
							float fragment_unnamed_7521 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_7472 * ((-0.0f) - (fragment_unnamed_7294 + ((-0.0f) - fragment_unnamed_7490)))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_7476 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_7473 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_7490) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_7523 = ((-0.0f) - fragment_unnamed_7281) + 1.0f;
							float fragment_unnamed_8721;
							float fragment_unnamed_8722;
							float fragment_unnamed_8723;
							if (fragment_uniform_buffer_0[86u].x == 1.0f)
							{
								float4 fragment_unnamed_7682 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_863, fragment_unnamed_864, fragment_unnamed_865, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_0[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6058, (-0.0f) - fragment_uniform_buffer_0[87u].x) / (((-0.0f) - fragment_uniform_buffer_0[87u].x) + fragment_uniform_buffer_0[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_8721 = fragment_unnamed_7682.x * fragment_uniform_buffer_0[85u].x;
								fragment_unnamed_8722 = fragment_unnamed_7682.y * fragment_uniform_buffer_0[85u].y;
								fragment_unnamed_8723 = fragment_unnamed_7682.z * fragment_uniform_buffer_0[85u].z;
							}
							else
							{
								uint4 fragment_unnamed_7697 = asuint(fragment_uniform_buffer_0[85u]);
								fragment_unnamed_8721 = asfloat(fragment_unnamed_7697.x);
								fragment_unnamed_8722 = asfloat(fragment_unnamed_7697.y);
								fragment_unnamed_8723 = asfloat(fragment_unnamed_7697.z);
							}
							float fragment_unnamed_8734 = ((-0.0f) - fragment_unnamed_7521) + 1.0f;
							fragment_unnamed_6719 = mad((-0.0f) - fragment_unnamed_7523, fragment_unnamed_7521, 1.0f);
							fragment_unnamed_6713 = mad((fragment_uniform_buffer_0[88u].z / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_3864 * (fragment_unnamed_8723 * fragment_unnamed_7523)), fragment_unnamed_8734, fragment_unnamed_7283);
							fragment_unnamed_6715 = mad((fragment_uniform_buffer_0[88u].y / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_3864 * (fragment_unnamed_8722 * fragment_unnamed_7523)), fragment_unnamed_8734, fragment_unnamed_7285);
							fragment_unnamed_6717 = mad((fragment_uniform_buffer_0[88u].x / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_3864 * (fragment_unnamed_8721 * fragment_unnamed_7523)), fragment_unnamed_8734, fragment_unnamed_7287);
						}
						else
						{
							fragment_unnamed_6719 = fragment_unnamed_7281;
							fragment_unnamed_6713 = fragment_unnamed_7283;
							fragment_unnamed_6715 = fragment_unnamed_7285;
							fragment_unnamed_6717 = fragment_unnamed_7287;
						}
						fragment_unnamed_6710 = asuint(fragment_unnamed_6719);
						fragment_unnamed_6712 = fragment_unnamed_6713;
						fragment_unnamed_6714 = fragment_unnamed_6715;
						fragment_unnamed_6716 = fragment_unnamed_6717;
						fragment_unnamed_6718 = fragment_unnamed_6719;
						fragment_unnamed_6720 = fragment_unnamed_6719;
						fragment_unnamed_6721 = fragment_unnamed_6722;
					}
					else
					{
						fragment_unnamed_6710 = fragment_unnamed_5005;
						fragment_unnamed_6712 = asfloat(0u);
						fragment_unnamed_6714 = asfloat(0u);
						fragment_unnamed_6716 = asfloat(0u);
						fragment_unnamed_6718 = fragment_unnamed_5009;
						fragment_unnamed_6720 = fragment_unnamed_5011;
						fragment_unnamed_6721 = asfloat(0u);
					}
					uint fragment_unnamed_7357;
					float fragment_unnamed_7359;
					float fragment_unnamed_7361;
					float fragment_unnamed_7363;
					float fragment_unnamed_7365;
					float fragment_unnamed_7367;
					if (asuint(fragment_unnamed_5013) != 0u)
					{
						uint fragment_unnamed_7306 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 4u;
						uint4 fragment_unnamed_7318 = uint4(T25.Load(fragment_unnamed_7306).x, T25.Load(fragment_unnamed_7306 + 1u).x, T25.Load(fragment_unnamed_7306 + 2u).x, T25.Load(fragment_unnamed_7306 + 3u).x);
						float fragment_unnamed_7326 = asfloat(fragment_unnamed_7318.w);
						uint fragment_unnamed_7332 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 20u;
						uint3 fragment_unnamed_7341 = uint3(T25.Load(fragment_unnamed_7332).x, T25.Load(fragment_unnamed_7332 + 1u).x, T25.Load(fragment_unnamed_7332 + 2u).x);
						float fragment_unnamed_7343 = asfloat(fragment_unnamed_7341.x);
						float fragment_unnamed_7345 = asfloat(fragment_unnamed_7341.y);
						float fragment_unnamed_7347 = asfloat(fragment_unnamed_7341.z);
						float fragment_unnamed_7348 = fragment_unnamed_7326 * asfloat(fragment_unnamed_7318.x);
						float fragment_unnamed_7349 = fragment_unnamed_7326 * asfloat(fragment_unnamed_7318.y);
						float fragment_unnamed_7350 = fragment_unnamed_7326 * asfloat(fragment_unnamed_7318.z);
						float fragment_unnamed_7355 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_6058, (-0.0f) - fragment_unnamed_6721);
						float fragment_unnamed_7360;
						float fragment_unnamed_7362;
						float fragment_unnamed_7364;
						float fragment_unnamed_7704;
						float fragment_unnamed_7705;
						float fragment_unnamed_7706;
						if (0.0f < fragment_unnamed_7355)
						{
							uint fragment_unnamed_7537 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 16u;
							uint3 fragment_unnamed_7546 = uint3(T25.Load(fragment_unnamed_7537).x, T25.Load(fragment_unnamed_7537 + 1u).x, T25.Load(fragment_unnamed_7537 + 2u).x);
							float fragment_unnamed_7553 = dot(float3(fragment_unnamed_346, fragment_unnamed_347, fragment_unnamed_348), float3(fragment_unnamed_7343, fragment_unnamed_7345, fragment_unnamed_7347));
							float fragment_unnamed_7556 = fragment_unnamed_7355 * fragment_unnamed_7348;
							float fragment_unnamed_7557 = fragment_unnamed_7355 * fragment_unnamed_7349;
							float fragment_unnamed_7558 = fragment_unnamed_7355 * fragment_unnamed_7350;
							float fragment_unnamed_7566 = fragment_unnamed_3864 * (((-0.0f) - fragment_unnamed_6720) + 1.0f);
							float fragment_unnamed_7567 = fragment_unnamed_3864 * (((-0.0f) - fragment_unnamed_6718) + 1.0f);
							float fragment_unnamed_7568 = fragment_unnamed_3864 * (((-0.0f) - asfloat(fragment_unnamed_6710)) + 1.0f);
							bool fragment_unnamed_7570 = ((-0.0f) - fragment_unnamed_7553) != 1.0f;
							float fragment_unnamed_7572 = 1.0f / (fragment_unnamed_7553 + 1.0f);
							float fragment_unnamed_7576 = (-0.0f) - fragment_unnamed_7553;
							fragment_unnamed_7704 = fragment_unnamed_7556;
							fragment_unnamed_7705 = fragment_unnamed_7557;
							fragment_unnamed_7706 = fragment_unnamed_7558;
							fragment_unnamed_7360 = mad(asfloat(fragment_unnamed_7570 ? asuint(fragment_unnamed_7568 * (fragment_unnamed_7572 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7558, fragment_unnamed_7576, fragment_unnamed_7558) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7568)), asfloat(fragment_unnamed_7546.z), fragment_unnamed_6712);
							fragment_unnamed_7362 = mad(asfloat(fragment_unnamed_7570 ? asuint(fragment_unnamed_7567 * (fragment_unnamed_7572 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7557, fragment_unnamed_7576, fragment_unnamed_7557) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7567)), asfloat(fragment_unnamed_7546.y), fragment_unnamed_6714);
							fragment_unnamed_7364 = mad(asfloat(fragment_unnamed_7570 ? asuint(fragment_unnamed_7566 * (fragment_unnamed_7572 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7556, fragment_unnamed_7576, fragment_unnamed_7556) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7566)), asfloat(fragment_unnamed_7546.x), fragment_unnamed_6716);
						}
						else
						{
							fragment_unnamed_7704 = asfloat(0u);
							fragment_unnamed_7705 = asfloat(0u);
							fragment_unnamed_7706 = asfloat(0u);
							fragment_unnamed_7360 = fragment_unnamed_6712;
							fragment_unnamed_7362 = fragment_unnamed_6714;
							fragment_unnamed_7364 = fragment_unnamed_6716;
						}
						float fragment_unnamed_7722 = max(((-0.0f) - dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_7343, fragment_unnamed_7345, fragment_unnamed_7347))) + ((-0.0f) - asfloat(T22.Load(0u).x)), 0.0f);
						fragment_unnamed_7357 = asuint(mad((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_6710)) + 1.0f), exp2(mad(fragment_unnamed_7722, fragment_unnamed_7350, fragment_unnamed_7706) * (-1.44269502162933349609375f)), 1.0f));
						fragment_unnamed_7359 = fragment_unnamed_7360;
						fragment_unnamed_7361 = fragment_unnamed_7362;
						fragment_unnamed_7363 = fragment_unnamed_7364;
						fragment_unnamed_7365 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_6718) + 1.0f), exp2(mad(fragment_unnamed_7722, fragment_unnamed_7349, fragment_unnamed_7705) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_7367 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_6720) + 1.0f), exp2(mad(fragment_unnamed_7722, fragment_unnamed_7348, fragment_unnamed_7704) * (-1.44269502162933349609375f)), 1.0f);
					}
					else
					{
						fragment_unnamed_7357 = fragment_unnamed_6710;
						fragment_unnamed_7359 = fragment_unnamed_6712;
						fragment_unnamed_7361 = fragment_unnamed_6714;
						fragment_unnamed_7363 = fragment_unnamed_6716;
						fragment_unnamed_7365 = fragment_unnamed_6718;
						fragment_unnamed_7367 = fragment_unnamed_6720;
					}
					uint fragment_unnamed_6321;
					float fragment_unnamed_6323;
					float fragment_unnamed_6325;
					float fragment_unnamed_6327;
					float fragment_unnamed_6329;
					float fragment_unnamed_6331;
					if (asuint(fragment_unnamed_5013) == 0u)
					{
						uint fragment_unnamed_7621;
						float fragment_unnamed_7622;
						float fragment_unnamed_7623;
						float fragment_unnamed_7624;
						float fragment_unnamed_7625;
						float fragment_unnamed_7626;
						if (asuint(fragment_uniform_buffer_0[84u]).y != 0u)
						{
							float fragment_unnamed_7749 = fragment_uniform_buffer_0[82u].w + fragment_uniform_buffer_0[83u].w;
							float fragment_unnamed_7755 = dot(float3(fragment_uniform_buffer_0[83u].xyz), float3(fragment_unnamed_863, fragment_unnamed_864, fragment_unnamed_865));
							float fragment_unnamed_7758 = 1.0f / fragment_unnamed_7749;
							float fragment_unnamed_7762 = fragment_unnamed_7758 * fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_7766 = sqrt(max(mad((-0.0f) - fragment_unnamed_7762, fragment_unnamed_7762, 1.0f), 0.0f));
							float fragment_unnamed_7770 = fragment_unnamed_7758 * fragment_uniform_buffer_4[0u].x;
							float fragment_unnamed_7773 = max(mad((-0.0f) - fragment_unnamed_7755, fragment_unnamed_7755, 1.0f), 0.0f);
							float fragment_unnamed_7775 = mad(fragment_unnamed_7770, fragment_unnamed_7770, (-0.0f) - fragment_unnamed_7773);
							float4 fragment_unnamed_7800 = _AtmosphericScatteringLUT.SampleLevel(S0, float3(fragment_unnamed_294, fragment_unnamed_295, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6058, (-0.0f) - max(asfloat((fragment_unnamed_7775 < 0.0f) ? asuint(fragment_unnamed_7775) : asuint(fragment_unnamed_7749 * (((-0.0f) - fragment_unnamed_7755) + ((-0.0f) - sqrt(fragment_unnamed_7775))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
							float fragment_unnamed_7809 = (1.0f / fragment_unnamed_6062) * fragment_uniform_buffer_4[0u].x;
							float fragment_unnamed_7811 = mad(fragment_unnamed_7809, fragment_unnamed_7809, (-0.0f) - fragment_unnamed_7773);
							float fragment_unnamed_7825 = min(max(asfloat((fragment_unnamed_7811 < 0.0f) ? asuint(fragment_unnamed_7811) : asuint((((-0.0f) - sqrt(fragment_unnamed_7811)) + ((-0.0f) - fragment_unnamed_7755)) * fragment_unnamed_6062)), 0.0f) + 128000.0f, fragment_unnamed_6062);
							float fragment_unnamed_7842 = dot(float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z), float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z));
							float fragment_unnamed_7845 = rsqrt(fragment_unnamed_7842);
							float fragment_unnamed_7857 = sqrt(fragment_unnamed_7842);
							float fragment_unnamed_7858 = dot(float3(fragment_unnamed_7845 * ((-0.0f) - fragment_uniform_buffer_0[82u].x), fragment_unnamed_7845 * ((-0.0f) - fragment_uniform_buffer_0[82u].y), fragment_unnamed_7845 * ((-0.0f) - fragment_uniform_buffer_0[82u].z)), float3(fragment_unnamed_346, fragment_unnamed_347, fragment_unnamed_348));
							float fragment_unnamed_7869 = mad(fragment_unnamed_7825, fragment_unnamed_863, (-0.0f) - fragment_uniform_buffer_0[82u].x);
							float fragment_unnamed_7870 = mad(fragment_unnamed_7825, fragment_unnamed_864, (-0.0f) - fragment_uniform_buffer_0[82u].y);
							float fragment_unnamed_7871 = mad(fragment_unnamed_7825, fragment_unnamed_865, (-0.0f) - fragment_uniform_buffer_0[82u].z);
							float fragment_unnamed_7875 = sqrt(dot(float3(fragment_unnamed_7869, fragment_unnamed_7870, fragment_unnamed_7871), float3(fragment_unnamed_7869, fragment_unnamed_7870, fragment_unnamed_7871)));
							float fragment_unnamed_7880 = dot(float3(fragment_unnamed_7869, fragment_unnamed_7870, fragment_unnamed_7871), float3(fragment_unnamed_863, fragment_unnamed_864, fragment_unnamed_865)) * (1.0f / fragment_unnamed_7875);
							float fragment_unnamed_7883 = (fragment_unnamed_7880 >= 0.0f) ? ((-0.0f) - fragment_unnamed_7858) : fragment_unnamed_7858;
							float fragment_unnamed_7888 = fragment_unnamed_7857 * fragment_uniform_buffer_4[1u].x;
							float fragment_unnamed_7889 = fragment_unnamed_7857 * fragment_uniform_buffer_4[1u].z;
							float fragment_unnamed_7893 = sqrt(max(mad((-0.0f) - fragment_unnamed_7883, fragment_unnamed_7883, 1.0f), 0.0f));
							float fragment_unnamed_7898 = abs(fragment_unnamed_7883) * abs(fragment_unnamed_7883);
							float fragment_unnamed_7901 = (-0.0f) - fragment_unnamed_7898;
							float fragment_unnamed_7915 = abs(fragment_unnamed_7883);
							float fragment_unnamed_7922 = abs(fragment_unnamed_7883);
							float fragment_unnamed_7940 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].x, (-0.0f) - fragment_unnamed_7888) * 1.44269502162933349609375f) * mad(fragment_unnamed_7922, 0.5f, (1.0f / mad(fragment_unnamed_7915, fragment_unnamed_7888, sqrt(fragment_unnamed_7888 * mad(fragment_unnamed_7888 * fragment_unnamed_7898, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_7901, fragment_unnamed_7888, mad(fragment_unnamed_7888, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							float fragment_unnamed_7941 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].z, (-0.0f) - fragment_unnamed_7889) * 1.44269502162933349609375f) * mad(fragment_unnamed_7922, 0.5f, (1.0f / mad(fragment_unnamed_7915, fragment_unnamed_7889, sqrt(fragment_unnamed_7889 * mad(fragment_unnamed_7889 * fragment_unnamed_7898, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_7901, fragment_unnamed_7889, mad(fragment_unnamed_7889, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							bool fragment_unnamed_7942 = fragment_unnamed_7883 < 0.0f;
							float fragment_unnamed_7943 = fragment_unnamed_7893 * fragment_unnamed_7888;
							float fragment_unnamed_7944 = fragment_unnamed_7893 * fragment_unnamed_7889;
							float fragment_unnamed_7945 = rsqrt(fragment_unnamed_7943);
							float fragment_unnamed_7946 = rsqrt(fragment_unnamed_7944);
							float fragment_unnamed_7989 = fragment_unnamed_7875 * fragment_uniform_buffer_4[1u].x;
							float fragment_unnamed_7990 = fragment_unnamed_7875 * fragment_uniform_buffer_4[1u].z;
							float fragment_unnamed_7995 = abs(fragment_unnamed_7880) * abs(fragment_unnamed_7880);
							float fragment_unnamed_7998 = (-0.0f) - fragment_unnamed_7995;
							float fragment_unnamed_8009 = abs(fragment_unnamed_7880);
							float fragment_unnamed_8016 = abs(fragment_unnamed_7880);
							float fragment_unnamed_8044 = abs(mad((-0.0f) - mad(fragment_unnamed_8016, 0.5f, (mad(fragment_unnamed_7998, fragment_unnamed_7989, mad(fragment_unnamed_7989, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_8009, fragment_unnamed_7989, sqrt(fragment_unnamed_7989 * mad(fragment_unnamed_7989 * fragment_unnamed_7995, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].x, (-0.0f) - fragment_unnamed_7989) * 1.44269502162933349609375f), asfloat(fragment_unnamed_7942 ? asuint(mad((dot(fragment_unnamed_7943.xx, fragment_unnamed_7945.xx) + fragment_unnamed_7945) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].x, (-0.0f) - fragment_unnamed_7943) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_7940)) : asuint(fragment_unnamed_7940)))) * fragment_uniform_buffer_4[1u].y;
							float fragment_unnamed_8046 = 1.0f / fragment_unnamed_7857;
							float fragment_unnamed_8051 = fragment_unnamed_8046 * fragment_uniform_buffer_4[2u].z;
							float fragment_unnamed_8052 = fragment_unnamed_8046 * fragment_uniform_buffer_4[2u].w;
							float fragment_unnamed_8056 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_7858, fragment_unnamed_7858, 1.0f), 0.0f);
							float fragment_unnamed_8057 = mad(fragment_unnamed_8051, fragment_unnamed_8051, fragment_unnamed_8056);
							float fragment_unnamed_8058 = mad(fragment_unnamed_8052, fragment_unnamed_8052, fragment_unnamed_8056);
							bool fragment_unnamed_8059 = fragment_unnamed_8057 < 0.0f;
							bool fragment_unnamed_8060 = fragment_unnamed_8058 < 0.0f;
							float fragment_unnamed_8061 = sqrt(fragment_unnamed_8057);
							float fragment_unnamed_8062 = sqrt(fragment_unnamed_8058);
							uint fragment_unnamed_8073 = asuint(fragment_unnamed_8057);
							uint fragment_unnamed_8076 = fragment_unnamed_8059 ? fragment_unnamed_8073 : asuint(fragment_unnamed_7857 * (fragment_unnamed_7858 + ((-0.0f) - fragment_unnamed_8061)));
							float fragment_unnamed_8077 = asfloat(fragment_unnamed_8076);
							uint fragment_unnamed_8078 = fragment_unnamed_8059 ? fragment_unnamed_8073 : asuint(fragment_unnamed_7857 * (fragment_unnamed_7858 + fragment_unnamed_8061));
							float fragment_unnamed_8079 = asfloat(fragment_unnamed_8078);
							uint fragment_unnamed_8080 = asuint(fragment_unnamed_8058);
							uint fragment_unnamed_8085 = fragment_unnamed_8060 ? fragment_unnamed_8080 : asuint(fragment_unnamed_7857 * (fragment_unnamed_7858 + fragment_unnamed_8062));
							bool fragment_unnamed_8090 = fragment_unnamed_8077 >= 0.0f;
							float fragment_unnamed_8095 = ((-0.0f) - fragment_unnamed_8079) + asfloat(fragment_unnamed_8085);
							float fragment_unnamed_8098 = max(asfloat(fragment_unnamed_8060 ? fragment_unnamed_8080 : asuint(fragment_unnamed_7857 * (fragment_unnamed_7858 + ((-0.0f) - fragment_unnamed_8062)))), 0.0f);
							uint fragment_unnamed_8099 = fragment_unnamed_8090 ? fragment_unnamed_8076 : fragment_unnamed_8085;
							float fragment_unnamed_8105 = ((-0.0f) - fragment_unnamed_8098) + asfloat(fragment_unnamed_8099);
							bool fragment_unnamed_8108 = (((fragment_unnamed_8079 < fragment_unnamed_7825) ? 4294967295u : 0u) & (fragment_unnamed_8090 ? 4294967295u : 0u)) != 0u;
							bool fragment_unnamed_8114 = (((fragment_unnamed_8077 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_8079 >= 0.0f) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_8119 = asfloat(fragment_unnamed_8114 ? fragment_unnamed_8078 : asuint(fragment_unnamed_8098));
							float fragment_unnamed_8121 = asfloat(fragment_unnamed_8114 ? asuint(fragment_unnamed_8095 * 0.5f) : (fragment_unnamed_8108 ? fragment_unnamed_8078 : asuint(fragment_unnamed_8105 * 0.5f)));
							float fragment_unnamed_8123 = asfloat(fragment_unnamed_8114 ? asuint(fragment_unnamed_8095 * 0.5f) : (fragment_unnamed_8108 ? fragment_unnamed_8099 : asuint(fragment_unnamed_8105 * 0.5f)));
							float fragment_unnamed_8125 = asfloat(fragment_unnamed_8114 ? fragment_unnamed_8085 : (fragment_unnamed_8108 ? fragment_unnamed_8085 : fragment_unnamed_8099));
							float fragment_unnamed_8130 = (-0.0f) - fragment_unnamed_8119;
							float fragment_unnamed_8131 = (-0.0f) - fragment_unnamed_8121;
							float fragment_unnamed_8134 = fragment_unnamed_8130 + min(fragment_unnamed_7825, fragment_unnamed_8123);
							float fragment_unnamed_8135 = fragment_unnamed_8131 + min(fragment_unnamed_7825, fragment_unnamed_8125);
							float fragment_unnamed_8144 = mad(fragment_unnamed_8130 + min(fragment_unnamed_7825, fragment_unnamed_8123), 0.25f, fragment_unnamed_8119);
							float fragment_unnamed_8145 = mad(fragment_unnamed_8131 + min(fragment_unnamed_7825, fragment_unnamed_8125), 0.25f, fragment_unnamed_8121);
							float fragment_unnamed_8146 = mad(fragment_unnamed_8134, 0.75f, fragment_unnamed_8119);
							float fragment_unnamed_8148 = mad(fragment_unnamed_8135, 0.75f, fragment_unnamed_8121);
							float fragment_unnamed_8150 = dot(((-0.0f) - fragment_unnamed_7858).xx, fragment_unnamed_7857.xx);
							float fragment_unnamed_8168 = (-0.0f) - fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_8204 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8148, fragment_unnamed_8148 + fragment_unnamed_8150, fragment_unnamed_7842)) + fragment_unnamed_8168, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_8135, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8146, fragment_unnamed_8146 + fragment_unnamed_8150, fragment_unnamed_7842)) + fragment_unnamed_8168, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_8134, 0.0f) * 0.5f, ((max(fragment_unnamed_8135, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8145, fragment_unnamed_8145 + fragment_unnamed_8150, fragment_unnamed_7842)) + fragment_unnamed_8168, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_8134, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8144, fragment_unnamed_8144 + fragment_unnamed_8150, fragment_unnamed_7842)) + fragment_unnamed_8168, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
							float fragment_unnamed_8209 = (abs(mad((-0.0f) - mad(fragment_unnamed_8016, 0.5f, (mad(fragment_unnamed_7998, fragment_unnamed_7990, mad(fragment_unnamed_7990, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_8009, fragment_unnamed_7990, sqrt(fragment_unnamed_7990 * mad(fragment_unnamed_7990 * fragment_unnamed_7995, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].z, (-0.0f) - fragment_unnamed_7990) * 1.44269502162933349609375f), asfloat(fragment_unnamed_7942 ? asuint(mad((dot(fragment_unnamed_7944.xx, fragment_unnamed_7946.xx) + fragment_unnamed_7946) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].z, (-0.0f) - fragment_unnamed_7944) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_7941)) : asuint(fragment_unnamed_7941)))) * fragment_uniform_buffer_4[1u].w) * fragment_uniform_buffer_4[0u].w;
							float fragment_unnamed_8235 = ((-0.0f) - exp2(mad(fragment_unnamed_8204, fragment_uniform_buffer_4[6u].x, mad(fragment_unnamed_8044, fragment_uniform_buffer_4[3u].x, fragment_unnamed_8209)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8236 = ((-0.0f) - exp2(mad(fragment_unnamed_8204, fragment_uniform_buffer_4[6u].y, mad(fragment_unnamed_8044, fragment_uniform_buffer_4[3u].y, fragment_unnamed_8209)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8237 = ((-0.0f) - exp2(mad(fragment_unnamed_8204, fragment_uniform_buffer_4[6u].z, mad(fragment_unnamed_8044, fragment_uniform_buffer_4[3u].z, fragment_unnamed_8209)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8239 = fragment_unnamed_8237 + (fragment_unnamed_8236 + fragment_unnamed_8235);
							float fragment_unnamed_8240 = fragment_unnamed_8239 * 0.3333333432674407958984375f;
							float fragment_unnamed_8242 = (-0.0f) - fragment_unnamed_8239;
							float fragment_unnamed_8260 = sqrt(((-0.0f) - fragment_unnamed_7766) + 1.0f);
							float fragment_unnamed_8266 = mad(mad(mad(fragment_unnamed_7766, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_7766, -0.212114393711090087890625f), fragment_unnamed_7766, 1.570728778839111328125f);
							float fragment_unnamed_8277 = mad(fragment_unnamed_8266, fragment_unnamed_8260, asfloat(((((-0.0f) - fragment_unnamed_7766) < fragment_unnamed_7766) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_8260 * fragment_unnamed_8266, -2.0f, 3.1415927410125732421875f))));
							float fragment_unnamed_8281 = sqrt(((-0.0f) - abs(fragment_unnamed_7755)) + 1.0f);
							float fragment_unnamed_8287 = mad(mad(mad(abs(fragment_unnamed_7755), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_7755), -0.212114393711090087890625f), abs(fragment_unnamed_7755), 1.570728778839111328125f);
							float fragment_unnamed_8298 = 1.0f / ((-0.0f) - fragment_unnamed_8277);
							float fragment_unnamed_8316 = mad(exp2((clamp(mad(mad(fragment_unnamed_8287, fragment_unnamed_8281, asfloat(((fragment_unnamed_7755 < ((-0.0f) - fragment_unnamed_7755)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_8281 * fragment_unnamed_8287, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_8298, (-0.0f) - (fragment_unnamed_8277 * fragment_unnamed_8298)), 0.0f, 1.0f) * fragment_uniform_buffer_4[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_4[11u].y, (-0.0f) - fragment_uniform_buffer_4[11u].y);
							float fragment_unnamed_8348 = ((-0.0f) - fragment_unnamed_7367) + 1.0f;
							float fragment_unnamed_8349 = ((-0.0f) - fragment_unnamed_7365) + 1.0f;
							float fragment_unnamed_8350 = ((-0.0f) - asfloat(fragment_unnamed_7357)) + 1.0f;
							fragment_unnamed_7621 = asuint(mad(fragment_unnamed_8350, mad(mad(fragment_unnamed_8242, 0.3333333432674407958984375f, fragment_unnamed_8237), fragment_uniform_buffer_4[10u].z, fragment_unnamed_8240) * fragment_uniform_buffer_4[10u].w, asfloat(fragment_unnamed_7357)));
							fragment_unnamed_7622 = mad(fragment_unnamed_8350, fragment_unnamed_7800.z * mad(fragment_unnamed_8316, ((-0.0f) - fragment_uniform_buffer_4[8u].z) + fragment_uniform_buffer_4[9u].z, fragment_uniform_buffer_4[8u].z), fragment_unnamed_7359);
							fragment_unnamed_7623 = mad(fragment_unnamed_8349, fragment_unnamed_7800.y * mad(fragment_unnamed_8316, ((-0.0f) - fragment_uniform_buffer_4[8u].y) + fragment_uniform_buffer_4[9u].y, fragment_uniform_buffer_4[8u].y), fragment_unnamed_7361);
							fragment_unnamed_7624 = mad(fragment_unnamed_8348, fragment_unnamed_7800.x * mad(fragment_unnamed_8316, ((-0.0f) - fragment_uniform_buffer_4[8u].x) + fragment_uniform_buffer_4[9u].x, fragment_uniform_buffer_4[8u].x), fragment_unnamed_7363);
							fragment_unnamed_7625 = mad(fragment_unnamed_8349, mad(mad(fragment_unnamed_8242, 0.3333333432674407958984375f, fragment_unnamed_8236), fragment_uniform_buffer_4[10u].z, fragment_unnamed_8240) * fragment_uniform_buffer_4[10u].w, fragment_unnamed_7365);
							fragment_unnamed_7626 = mad(fragment_unnamed_8348, mad(mad(fragment_unnamed_8242, 0.3333333432674407958984375f, fragment_unnamed_8235), fragment_uniform_buffer_4[10u].z, fragment_unnamed_8240) * fragment_uniform_buffer_4[10u].w, fragment_unnamed_7367);
						}
						else
						{
							fragment_unnamed_7621 = fragment_unnamed_7357;
							fragment_unnamed_7622 = fragment_unnamed_7359;
							fragment_unnamed_7623 = fragment_unnamed_7361;
							fragment_unnamed_7624 = fragment_unnamed_7363;
							fragment_unnamed_7625 = fragment_unnamed_7365;
							fragment_unnamed_7626 = fragment_unnamed_7367;
						}
						fragment_unnamed_6321 = fragment_unnamed_7621;
						fragment_unnamed_6323 = fragment_unnamed_7622;
						fragment_unnamed_6325 = fragment_unnamed_7623;
						fragment_unnamed_6327 = fragment_unnamed_7624;
						fragment_unnamed_6329 = fragment_unnamed_7625;
						fragment_unnamed_6331 = fragment_unnamed_7626;
					}
					else
					{
						fragment_unnamed_6321 = fragment_unnamed_7357;
						fragment_unnamed_6323 = fragment_unnamed_7359;
						fragment_unnamed_6325 = fragment_unnamed_7361;
						fragment_unnamed_6327 = fragment_unnamed_7363;
						fragment_unnamed_6329 = fragment_unnamed_7365;
						fragment_unnamed_6331 = fragment_unnamed_7367;
					}
					fragment_unnamed_6320 = fragment_unnamed_6321;
					fragment_unnamed_6322 = fragment_unnamed_6323;
					fragment_unnamed_6324 = fragment_unnamed_6325;
					fragment_unnamed_6326 = fragment_unnamed_6327;
					fragment_unnamed_6328 = fragment_unnamed_6329;
					fragment_unnamed_6330 = fragment_unnamed_6331;
				}
				else
				{
					fragment_unnamed_6320 = fragment_unnamed_5005;
					fragment_unnamed_6322 = asfloat(0u);
					fragment_unnamed_6324 = asfloat(0u);
					fragment_unnamed_6326 = asfloat(0u);
					fragment_unnamed_6328 = fragment_unnamed_5009;
					fragment_unnamed_6330 = fragment_unnamed_5011;
				}
				float fragment_unnamed_6336 = ((-0.0f) - fragment_unnamed_6330) + 1.0f;
				float fragment_unnamed_6337 = ((-0.0f) - fragment_unnamed_6328) + 1.0f;
				float fragment_unnamed_6338 = ((-0.0f) - asfloat(fragment_unnamed_6320)) + 1.0f;
				float fragment_unnamed_6342 = mad(fragment_unnamed_3868, fragment_unnamed_6336, fragment_unnamed_6326);
				float fragment_unnamed_6343 = mad(fragment_unnamed_3869, fragment_unnamed_6337, fragment_unnamed_6324);
				float fragment_unnamed_6344 = mad(fragment_unnamed_3870, fragment_unnamed_6338, fragment_unnamed_6322);
				bool fragment_unnamed_6348 = fragment_uniform_buffer_3[14u].x == 0.0f;
				bool fragment_unnamed_6349 = fragment_uniform_buffer_3[14u].x == 1.0f;
				bool fragment_unnamed_6350 = fragment_uniform_buffer_3[14u].x == 4.0f;
				fragment_output_0.x = fragment_unnamed_6348 ? fragment_unnamed_6342 : asfloat(fragment_unnamed_6349 ? asuint(fragment_unnamed_3868 * fragment_unnamed_6336) : (fragment_unnamed_6350 ? asuint(fragment_unnamed_6342) : asuint(fragment_unnamed_3868)));
				fragment_output_0.y = fragment_unnamed_6348 ? fragment_unnamed_6343 : asfloat(fragment_unnamed_6349 ? asuint(fragment_unnamed_3869 * fragment_unnamed_6337) : (fragment_unnamed_6350 ? asuint(fragment_unnamed_6343) : asuint(fragment_unnamed_3869)));
				fragment_output_0.z = fragment_unnamed_6348 ? fragment_unnamed_6344 : asfloat(fragment_unnamed_6349 ? asuint(fragment_unnamed_3870 * fragment_unnamed_6338) : (fragment_unnamed_6350 ? asuint(fragment_unnamed_6344) : asuint(fragment_unnamed_3870)));
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

				fragment_uniform_buffer_0[113] = float4(fragment_uniform_buffer_0[113][0], asfloat(_SpecularFade), fragment_uniform_buffer_0[113][2], fragment_uniform_buffer_0[113][3]);

				fragment_uniform_buffer_0[114] = float4(asfloat(_DirectionalLightCount), fragment_uniform_buffer_0[114][1], fragment_uniform_buffer_0[114][2], fragment_uniform_buffer_0[114][3]);

				fragment_uniform_buffer_0[116] = float4(asfloat(_EnvLightSkyEnabled), fragment_uniform_buffer_0[116][1], fragment_uniform_buffer_0[116][2], fragment_uniform_buffer_0[116][3]);

				fragment_uniform_buffer_0[116] = float4(fragment_uniform_buffer_0[116][0], asfloat(_CascadeShadowCount), fragment_uniform_buffer_0[116][2], fragment_uniform_buffer_0[116][3]);

				fragment_uniform_buffer_0[116] = float4(fragment_uniform_buffer_0[116][0], fragment_uniform_buffer_0[116][1], asfloat(_DirectionalShadowIndex), fragment_uniform_buffer_0[116][3]);

				fragment_uniform_buffer_0[117] = float4(asfloat(_EnableSkyReflection), fragment_uniform_buffer_0[117][1], fragment_uniform_buffer_0[117][2], fragment_uniform_buffer_0[117][3]);

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], _ProbeExposureScale, fragment_uniform_buffer_0[118][2], fragment_uniform_buffer_0[118][3]);

				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], fragment_uniform_buffer_0[118][1], fragment_uniform_buffer_0[118][2], _ReplaceDiffuseForIndirect);

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

				fragment_uniform_buffer_3[2] = float4(_Temperature, fragment_uniform_buffer_3[2][1], fragment_uniform_buffer_3[2][2], fragment_uniform_buffer_3[2][3]);

				fragment_uniform_buffer_3[4] = float4(_GradientIntensity, fragment_uniform_buffer_3[4][1], fragment_uniform_buffer_3[4][2], fragment_uniform_buffer_3[4][3]);

				fragment_uniform_buffer_3[4] = float4(fragment_uniform_buffer_3[4][0], _HeatMapMinMax[0], _HeatMapMinMax[1], fragment_uniform_buffer_3[4][3]);

				fragment_uniform_buffer_3[4] = float4(fragment_uniform_buffer_3[4][0], fragment_uniform_buffer_3[4][1], fragment_uniform_buffer_3[4][2], _HeatMapPow);

				fragment_uniform_buffer_3[14] = float4(_BlendMode, fragment_uniform_buffer_3[14][1], fragment_uniform_buffer_3[14][2], fragment_uniform_buffer_3[14][3]);

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
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(_SURFACE_TYPE_TRANSPARENT) && !defined(AREA_SHADOW_MEDIUM) && !defined(DECALS_3RT) && !defined(DIRECTIONAL_SHADOW_MEDIUM) && !defined(PUNCTUAL_SHADOW_MEDIUM) && !defined(SCREEN_SPACE_SHADOWS_OFF) && !defined(USE_CLUSTERED_LIGHTLIST) && !defined(_DISABLE_DECALS) && !defined(_ENABLE_FOG_ON_TRANSPARENT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
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
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float3 vertex_output_5;
			static float3 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD0; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD2; // TEXCOORD_2
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float4 vertex_output_4 : INTERP3; // INTERP_3
				float3 vertex_output_5 : INTERP4; // INTERP_4
				float3 vertex_output_6 : INTERP5; // INTERP_5
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
					vertex_output_6.x = 0.0f;
					vertex_output_6.y = 0.0f;
					vertex_output_6.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_132 = asfloat(1065353216u);
					float vertex_unnamed_134 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_132));
					float vertex_unnamed_152 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_132));
					float vertex_unnamed_170 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_132));
					float vertex_unnamed_185 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_200 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_215 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_224 = rsqrt(max(dot(float3(vertex_unnamed_185, vertex_unnamed_200, vertex_unnamed_215), float3(vertex_unnamed_185, vertex_unnamed_200, vertex_unnamed_215)), 1.1754943508222875079687365372222e-38f));
					vertex_output_6.x = vertex_unnamed_224 * vertex_unnamed_185;
					vertex_output_6.y = vertex_unnamed_224 * vertex_unnamed_200;
					vertex_output_6.z = vertex_unnamed_224 * vertex_unnamed_215;
					float vertex_unnamed_258 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_259 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_260 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_265 = rsqrt(max(dot(float3(vertex_unnamed_258, vertex_unnamed_259, vertex_unnamed_260), float3(vertex_unnamed_258, vertex_unnamed_259, vertex_unnamed_260)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_265 * vertex_unnamed_258;
					vertex_output_1.y = vertex_unnamed_265 * vertex_unnamed_259;
					vertex_output_1.z = vertex_unnamed_265 * vertex_unnamed_260;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_170, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_134, vertex_unnamed_152 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_5.x = vertex_unnamed_134;
					vertex_output_5.y = vertex_unnamed_152;
					vertex_output_5.z = vertex_unnamed_170;
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

				vertex_uniform_buffer_2[14] = float4(vertex_uniform_buffer_2[14][0], vertex_uniform_buffer_2[14][1], _RayTracing, vertex_uniform_buffer_2[14][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_5 = stage_input.vertex_input_5;
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
			GpuProgramID 730327

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
			GpuProgramID 813501

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
			GpuProgramID 876560

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
			GpuProgramID 967113

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
			GpuProgramID 1040726

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
			GpuProgramID 1110486

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
