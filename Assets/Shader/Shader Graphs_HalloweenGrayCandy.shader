Shader "Shader Graphs/HalloweenGrayCandy"
{
	Properties
	{
		_Fade ("Fade", Range(0, 1)) = 1
		_Metallic ("Metallic", Float) = 0.77
		_Color ("Color", Color) = (0.6470588,0.7019608,0.7254902,0)
		_Smoothness ("Smoothness", Float) = 0
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
			GpuProgramID 25014

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ _ALPHATEST_ON


			#if (!defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_VERTEX)
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
			#if (!defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			void frag_main()
			{
			}

			void frag()
			{
				frag_main();
			}

			#endif
			#if (defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_VERTEX)
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
			#if (defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _Fade;

			static float4 fragment_uniform_buffer_0[62];
			static float4 fragment_uniform_buffer_1[1];
			static float4 gl_FragCoord;
			struct Fragment_Stage_Input
			{
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

			void discard_cond(bool fragment_unnamed_147)
			{
				if (fragment_unnamed_147)
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
				uint fragment_unnamed_23[64];
				fragment_unnamed_23[0u] = 1030811889u;
				fragment_unnamed_23[4u] = 1057458056u;
				fragment_unnamed_23[8u] = 1043641525u;
				fragment_unnamed_23[12u] = 1059431846u;
				fragment_unnamed_23[16u] = 1061405636u;
				fragment_unnamed_23[20u] = 1050056343u;
				fragment_unnamed_23[24u] = 1063379426u;
				fragment_unnamed_23[28u] = 1054003923u;
				fragment_unnamed_23[32u] = 1047589105u;
				fragment_unnamed_23[36u] = 1060418741u;
				fragment_unnamed_23[40u] = 1039200497u;
				fragment_unnamed_23[44u] = 1058444951u;
				fragment_unnamed_23[48u] = 1064366321u;
				fragment_unnamed_23[52u] = 1055977713u;
				fragment_unnamed_23[56u] = 1062392531u;
				fragment_unnamed_23[60u] = 1052030133u;
				uint fragment_unnamed_116 = 2u & 31u;
				uint fragment_unnamed_122 = 0u & 31u;
				discard_cond((((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_23[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_116, min((2u & 31u), (32u - fragment_unnamed_116))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_122, min((2u & 31u), (32u - fragment_unnamed_122))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_1[0u].x) + 2.0f))) + 1.0f) < 0.0f);
				discard_exit();
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
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
			GpuProgramID 297831

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma multi_compile _ _ALPHATEST_ON


			#if (!defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_VERTEX)
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
			static float3 vertex_input_3;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float3 vertex_input_3 : TEXCOORD4; // TEXCOORD_4
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float3 vertex_output_4 : INTERP1; // INTERP_1
				float3 vertex_output_5 : INTERP2; // INTERP_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_79 = asfloat(1065353216u);
				float vertex_unnamed_81 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_99 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_117 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_132 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_147 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_162 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_171 = rsqrt(max(dot(float3(vertex_unnamed_132, vertex_unnamed_147, vertex_unnamed_162), float3(vertex_unnamed_132, vertex_unnamed_147, vertex_unnamed_162)), 1.1754943508222875079687365372222e-38f));
				vertex_output_5.x = vertex_unnamed_171 * vertex_unnamed_132;
				vertex_output_5.y = vertex_unnamed_171 * vertex_unnamed_147;
				vertex_output_5.z = vertex_unnamed_171 * vertex_unnamed_162;
				float vertex_unnamed_206 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_207 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_208 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_213 = rsqrt(max(dot(float3(vertex_unnamed_206, vertex_unnamed_207, vertex_unnamed_208), float3(vertex_unnamed_206, vertex_unnamed_207, vertex_unnamed_208)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_213 * vertex_unnamed_206;
				vertex_output_3.y = vertex_unnamed_213 * vertex_unnamed_207;
				vertex_output_3.z = vertex_unnamed_213 * vertex_unnamed_208;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_321 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_334 = vertex_unnamed_321 ? vertex_input_3.x : vertex_input_0.x;
					float vertex_unnamed_335 = vertex_unnamed_321 ? vertex_input_3.y : vertex_input_0.y;
					float vertex_unnamed_336 = vertex_unnamed_321 ? vertex_input_3.z : vertex_input_0.z;
					float vertex_unnamed_370 = asfloat(1065353216u);
					float vertex_unnamed_371 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_334, vertex_unnamed_335, vertex_unnamed_336, vertex_unnamed_370));
					float vertex_unnamed_389 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_334, vertex_unnamed_335, vertex_unnamed_336, vertex_unnamed_370));
					float vertex_unnamed_407 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_334, vertex_unnamed_335, vertex_unnamed_336, vertex_unnamed_370));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_407, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_371, vertex_unnamed_389 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_407, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_371, vertex_unnamed_389 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_407, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_371, vertex_unnamed_389 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_unnamed_81;
				vertex_output_4.y = vertex_unnamed_99;
				vertex_output_4.z = vertex_unnamed_117;
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}
			#endif
			#if (!defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ScreenSize;
			float4 unity_MotionVectorsParams;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float3 fragment_input_4 : INTERP1; // INTERP_1
				float3 fragment_input_5 : INTERP2; // INTERP_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_52 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_53 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_103 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_103 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_52) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_52)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_103 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_53) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_53)))) * (-0.5f));
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
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_VERTEX)
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
			static float3 vertex_input_3;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float3 vertex_input_3 : TEXCOORD4; // TEXCOORD_4
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float3 vertex_output_4 : INTERP1; // INTERP_1
				float3 vertex_output_5 : INTERP2; // INTERP_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_79 = asfloat(1065353216u);
				float vertex_unnamed_81 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_99 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_117 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_132 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_147 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_162 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_171 = rsqrt(max(dot(float3(vertex_unnamed_132, vertex_unnamed_147, vertex_unnamed_162), float3(vertex_unnamed_132, vertex_unnamed_147, vertex_unnamed_162)), 1.1754943508222875079687365372222e-38f));
				vertex_output_5.x = vertex_unnamed_171 * vertex_unnamed_132;
				vertex_output_5.y = vertex_unnamed_171 * vertex_unnamed_147;
				vertex_output_5.z = vertex_unnamed_171 * vertex_unnamed_162;
				float vertex_unnamed_206 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_207 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_208 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_213 = rsqrt(max(dot(float3(vertex_unnamed_206, vertex_unnamed_207, vertex_unnamed_208), float3(vertex_unnamed_206, vertex_unnamed_207, vertex_unnamed_208)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_213 * vertex_unnamed_206;
				vertex_output_3.y = vertex_unnamed_213 * vertex_unnamed_207;
				vertex_output_3.z = vertex_unnamed_213 * vertex_unnamed_208;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_321 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_334 = vertex_unnamed_321 ? vertex_input_3.x : vertex_input_0.x;
					float vertex_unnamed_335 = vertex_unnamed_321 ? vertex_input_3.y : vertex_input_0.y;
					float vertex_unnamed_336 = vertex_unnamed_321 ? vertex_input_3.z : vertex_input_0.z;
					float vertex_unnamed_370 = asfloat(1065353216u);
					float vertex_unnamed_371 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_334, vertex_unnamed_335, vertex_unnamed_336, vertex_unnamed_370));
					float vertex_unnamed_389 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_334, vertex_unnamed_335, vertex_unnamed_336, vertex_unnamed_370));
					float vertex_unnamed_407 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_334, vertex_unnamed_335, vertex_unnamed_336, vertex_unnamed_370));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_407, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_371, vertex_unnamed_389 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_407, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_371, vertex_unnamed_389 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_407, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_371, vertex_unnamed_389 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_unnamed_81;
				vertex_output_4.y = vertex_unnamed_99;
				vertex_output_4.z = vertex_unnamed_117;
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
				return stage_output;
			}
			#endif
			#if (defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ProjectionParams;
			float4 _ScreenParams;
			float4 unity_MotionVectorsParams;
			float _Fade;

			static float4 fragment_uniform_buffer_0[62];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[1];
			static float4 gl_FragCoord;
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float3 fragment_input_4 : INTERP1; // INTERP_1
				float3 fragment_input_5 : INTERP2; // INTERP_2
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

			void discard_cond(bool fragment_unnamed_235)
			{
				if (fragment_unnamed_235)
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
				uint fragment_unnamed_37[64];
				fragment_unnamed_37[0u] = 1030811889u;
				fragment_unnamed_37[4u] = 1057458056u;
				fragment_unnamed_37[8u] = 1043641525u;
				fragment_unnamed_37[12u] = 1059431846u;
				fragment_unnamed_37[16u] = 1061405636u;
				fragment_unnamed_37[20u] = 1050056343u;
				fragment_unnamed_37[24u] = 1063379426u;
				fragment_unnamed_37[28u] = 1054003923u;
				fragment_unnamed_37[32u] = 1047589105u;
				fragment_unnamed_37[36u] = 1060418741u;
				fragment_unnamed_37[40u] = 1039200497u;
				fragment_unnamed_37[44u] = 1058444951u;
				fragment_unnamed_37[48u] = 1064366321u;
				fragment_unnamed_37[52u] = 1055977713u;
				fragment_unnamed_37[56u] = 1062392531u;
				fragment_unnamed_37[60u] = 1052030133u;
				uint fragment_unnamed_130 = 2u & 31u;
				uint fragment_unnamed_136 = 0u & 31u;
				discard_cond((((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_37[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_130, min((2u & 31u), (32u - fragment_unnamed_130))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_136, min((2u & 31u), (32u - fragment_unnamed_136))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[0u].x) + 2.0f))) + 1.0f) < 0.0f);
				float fragment_unnamed_177 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_178 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_224 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_224 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_177) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_177)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_224 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_178) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_178)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[0] = float4(_Fade, fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 _ProjectionParams;
			float4 _ScreenParams;
			float4 unity_RenderingLayer;
			float _Fade;

			static float4 fragment_uniform_buffer_0[62];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[1];
			static float4 gl_FragCoord;
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float3 fragment_input_4 : INTERP1; // INTERP_1
				float3 fragment_input_5 : INTERP2; // INTERP_2
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

			void discard_cond(bool fragment_unnamed_315)
			{
				if (fragment_unnamed_315)
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
				uint fragment_unnamed_38[64];
				fragment_unnamed_38[0u] = 1030811889u;
				fragment_unnamed_38[4u] = 1057458056u;
				fragment_unnamed_38[8u] = 1043641525u;
				fragment_unnamed_38[12u] = 1059431846u;
				fragment_unnamed_38[16u] = 1061405636u;
				fragment_unnamed_38[20u] = 1050056343u;
				fragment_unnamed_38[24u] = 1063379426u;
				fragment_unnamed_38[28u] = 1054003923u;
				fragment_unnamed_38[32u] = 1047589105u;
				fragment_unnamed_38[36u] = 1060418741u;
				fragment_unnamed_38[40u] = 1039200497u;
				fragment_unnamed_38[44u] = 1058444951u;
				fragment_unnamed_38[48u] = 1064366321u;
				fragment_unnamed_38[52u] = 1055977713u;
				fragment_unnamed_38[56u] = 1062392531u;
				fragment_unnamed_38[60u] = 1052030133u;
				uint fragment_unnamed_131 = 2u & 31u;
				uint fragment_unnamed_137 = 0u & 31u;
				discard_cond((((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_38[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_131, min((2u & 31u), (32u - fragment_unnamed_131))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_137, min((2u & 31u), (32u - fragment_unnamed_137))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[0u].x) + 2.0f))) + 1.0f) < 0.0f);
				float fragment_unnamed_178 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_179 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_225 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_225 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_178) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_178)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_225 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_179) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_179)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_252 = 1.0f / max(sqrt(dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_259 = fragment_unnamed_252 * fragment_input_5.x;
				float fragment_unnamed_260 = fragment_unnamed_252 * fragment_input_5.y;
				float fragment_unnamed_261 = fragment_unnamed_252 * fragment_input_5.z;
				float fragment_unnamed_270 = 1.0f / max(dot(float3(abs(fragment_unnamed_259), abs(fragment_unnamed_260), abs(fragment_unnamed_261)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_275 = clamp((-0.0f) - (fragment_unnamed_270 * fragment_unnamed_261), 0.0f, 1.0f);
				float fragment_unnamed_278 = (-0.0f) - fragment_unnamed_275;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_259, fragment_unnamed_270, ((fragment_unnamed_270 * fragment_unnamed_259) >= 0.0f) ? fragment_unnamed_275 : fragment_unnamed_278), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_260, fragment_unnamed_270, ((fragment_unnamed_270 * fragment_unnamed_260) >= 0.0f) ? fragment_unnamed_275 : fragment_unnamed_278), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_296 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_296, min((8u & 31u), (32u - fragment_unnamed_296)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[0] = float4(_Fade, fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 _ScreenSize;
			float4 unity_RenderingLayer;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float3 fragment_input_4 : INTERP1; // INTERP_1
				float3 fragment_input_5 : INTERP2; // INTERP_2
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
				float fragment_unnamed_53 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_54 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_104 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_104 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_53) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_53)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_104 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_54) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_54)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_132 = 1.0f / max(sqrt(dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_140 = fragment_unnamed_132 * fragment_input_5.x;
				float fragment_unnamed_141 = fragment_unnamed_132 * fragment_input_5.y;
				float fragment_unnamed_142 = fragment_unnamed_132 * fragment_input_5.z;
				float fragment_unnamed_151 = 1.0f / max(dot(float3(abs(fragment_unnamed_140), abs(fragment_unnamed_141), abs(fragment_unnamed_142)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_156 = clamp((-0.0f) - (fragment_unnamed_151 * fragment_unnamed_142), 0.0f, 1.0f);
				float fragment_unnamed_159 = (-0.0f) - fragment_unnamed_156;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_140, fragment_unnamed_151, ((fragment_unnamed_151 * fragment_unnamed_140) >= 0.0f) ? fragment_unnamed_156 : fragment_unnamed_159), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_141, fragment_unnamed_151, ((fragment_unnamed_151 * fragment_unnamed_141) >= 0.0f) ? fragment_unnamed_156 : fragment_unnamed_159), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_179 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_179, min((8u & 31u), (32u - fragment_unnamed_179)))) * 0.0039215688593685626983642578125f;
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

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float3 vertex_input_3;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float3 vertex_input_3 : TEXCOORD4; // TEXCOORD_4
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float3 vertex_output_4 : INTERP1; // INTERP_1
				float3 vertex_output_5 : INTERP2; // INTERP_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_79 = asfloat(1065353216u);
				float vertex_unnamed_81 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_99 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_117 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_132 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_147 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_162 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_171 = rsqrt(max(dot(float3(vertex_unnamed_132, vertex_unnamed_147, vertex_unnamed_162), float3(vertex_unnamed_132, vertex_unnamed_147, vertex_unnamed_162)), 1.1754943508222875079687365372222e-38f));
				vertex_output_5.x = vertex_unnamed_171 * vertex_unnamed_132;
				vertex_output_5.y = vertex_unnamed_171 * vertex_unnamed_147;
				vertex_output_5.z = vertex_unnamed_171 * vertex_unnamed_162;
				float vertex_unnamed_206 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_207 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_208 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_213 = rsqrt(max(dot(float3(vertex_unnamed_206, vertex_unnamed_207, vertex_unnamed_208), float3(vertex_unnamed_206, vertex_unnamed_207, vertex_unnamed_208)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_213 * vertex_unnamed_206;
				vertex_output_3.y = vertex_unnamed_213 * vertex_unnamed_207;
				vertex_output_3.z = vertex_unnamed_213 * vertex_unnamed_208;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_117, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_117, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_117, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_81, vertex_unnamed_99 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_321 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_334 = vertex_unnamed_321 ? vertex_input_3.x : vertex_input_0.x;
					float vertex_unnamed_335 = vertex_unnamed_321 ? vertex_input_3.y : vertex_input_0.y;
					float vertex_unnamed_336 = vertex_unnamed_321 ? vertex_input_3.z : vertex_input_0.z;
					float vertex_unnamed_370 = asfloat(1065353216u);
					float vertex_unnamed_371 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_334, vertex_unnamed_335, vertex_unnamed_336, vertex_unnamed_370));
					float vertex_unnamed_389 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_334, vertex_unnamed_335, vertex_unnamed_336, vertex_unnamed_370));
					float vertex_unnamed_407 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_334, vertex_unnamed_335, vertex_unnamed_336, vertex_unnamed_370));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_407, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_371, vertex_unnamed_389 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_407, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_371, vertex_unnamed_389 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_407, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_371, vertex_unnamed_389 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_unnamed_81;
				vertex_output_4.y = vertex_unnamed_99;
				vertex_output_4.z = vertex_unnamed_117;
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_0 = vertex_output_0;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				stage_output.vertex_output_5 = vertex_output_5;
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
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float3 fragment_input_4 : INTERP1; // INTERP_1
				float3 fragment_input_5 : INTERP2; // INTERP_2
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_52 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_53 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_103 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_103 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_52) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_52)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_103 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_53) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_53)))) * (-0.5f));
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
			GpuProgramID 476496

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER
			#pragma multi_compile _ _ALPHATEST_ON


			#if (!defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[11];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_output_1;
			static float3 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float3 vertex_output_2 : INTERP1; // INTERP_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_80 = asfloat(1065353216u);
				float vertex_unnamed_82 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_80));
				float vertex_unnamed_111 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_80));
				float vertex_unnamed_141 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_80));
				uint vertex_unnamed_182 = ((0.0f < vertex_uniform_buffer_2[10u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u);
				bool vertex_unnamed_183 = vertex_unnamed_182 != 0u;
				gl_Position.x = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x);
				gl_Position.y = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y);
				gl_Position.z = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z);
				gl_Position.w = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w);
				float vertex_unnamed_220 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_221 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_222 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_228 = rsqrt(max(dot(float3(vertex_unnamed_220, vertex_unnamed_221, vertex_unnamed_222), float3(vertex_unnamed_220, vertex_unnamed_221, vertex_unnamed_222)), 1.1754943508222875079687365372222e-38f));
				bool vertex_unnamed_234 = vertex_unnamed_182 != 0u;
				vertex_output_1.x = vertex_unnamed_234 ? 0.0f : (vertex_unnamed_228 * vertex_unnamed_220);
				vertex_output_1.y = vertex_unnamed_234 ? 0.0f : (vertex_unnamed_228 * vertex_unnamed_221);
				vertex_output_1.z = vertex_unnamed_234 ? 0.0f : (vertex_unnamed_228 * vertex_unnamed_222);
				vertex_output_1.w = vertex_unnamed_234 ? 0.0f : vertex_input_2.w;
				float vertex_unnamed_255 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_270 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_285 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_292 = rsqrt(max(dot(float3(vertex_unnamed_255, vertex_unnamed_270, vertex_unnamed_285), float3(vertex_unnamed_255, vertex_unnamed_270, vertex_unnamed_285)), 1.1754943508222875079687365372222e-38f));
				bool vertex_unnamed_296 = vertex_unnamed_182 != 0u;
				vertex_output_2.x = vertex_unnamed_296 ? 0.0f : (vertex_unnamed_292 * vertex_unnamed_255);
				vertex_output_2.y = vertex_unnamed_296 ? 0.0f : (vertex_unnamed_292 * vertex_unnamed_270);
				vertex_output_2.z = vertex_unnamed_296 ? 0.0f : (vertex_unnamed_292 * vertex_unnamed_285);
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

				vertex_uniform_buffer_2[10] = float4(vertex_uniform_buffer_2[10][0], vertex_uniform_buffer_2[10][1], _RayTracing, vertex_uniform_buffer_2[10][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}
			#endif
			#if (!defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float3 fragment_input_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float3 fragment_input_2 : INTERP1; // INTERP_1
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
			}

			#endif
			#if (defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[11];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_output_1;
			static float3 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float3 vertex_output_2 : INTERP1; // INTERP_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_80 = asfloat(1065353216u);
				float vertex_unnamed_82 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_80));
				float vertex_unnamed_111 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_80));
				float vertex_unnamed_141 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_80));
				uint vertex_unnamed_182 = ((0.0f < vertex_uniform_buffer_2[10u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u);
				bool vertex_unnamed_183 = vertex_unnamed_182 != 0u;
				gl_Position.x = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x);
				gl_Position.y = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y);
				gl_Position.z = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z);
				gl_Position.w = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w);
				float vertex_unnamed_220 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_221 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_222 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_228 = rsqrt(max(dot(float3(vertex_unnamed_220, vertex_unnamed_221, vertex_unnamed_222), float3(vertex_unnamed_220, vertex_unnamed_221, vertex_unnamed_222)), 1.1754943508222875079687365372222e-38f));
				bool vertex_unnamed_234 = vertex_unnamed_182 != 0u;
				vertex_output_1.x = vertex_unnamed_234 ? 0.0f : (vertex_unnamed_228 * vertex_unnamed_220);
				vertex_output_1.y = vertex_unnamed_234 ? 0.0f : (vertex_unnamed_228 * vertex_unnamed_221);
				vertex_output_1.z = vertex_unnamed_234 ? 0.0f : (vertex_unnamed_228 * vertex_unnamed_222);
				vertex_output_1.w = vertex_unnamed_234 ? 0.0f : vertex_input_2.w;
				float vertex_unnamed_255 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_270 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_285 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_292 = rsqrt(max(dot(float3(vertex_unnamed_255, vertex_unnamed_270, vertex_unnamed_285), float3(vertex_unnamed_255, vertex_unnamed_270, vertex_unnamed_285)), 1.1754943508222875079687365372222e-38f));
				bool vertex_unnamed_296 = vertex_unnamed_182 != 0u;
				vertex_output_2.x = vertex_unnamed_296 ? 0.0f : (vertex_unnamed_292 * vertex_unnamed_255);
				vertex_output_2.y = vertex_unnamed_296 ? 0.0f : (vertex_unnamed_292 * vertex_unnamed_270);
				vertex_output_2.z = vertex_unnamed_296 ? 0.0f : (vertex_unnamed_292 * vertex_unnamed_285);
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

				vertex_uniform_buffer_2[10] = float4(vertex_uniform_buffer_2[10][0], vertex_uniform_buffer_2[10][1], _RayTracing, vertex_uniform_buffer_2[10][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}
			#endif
			#if (defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _Fade;

			static float4 fragment_uniform_buffer_0[62];
			static float4 fragment_uniform_buffer_1[1];
			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float3 fragment_input_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float3 fragment_input_2 : INTERP1; // INTERP_1
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

			void discard_cond(bool fragment_unnamed_151)
			{
				if (fragment_unnamed_151)
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
				uint fragment_unnamed_27[64];
				fragment_unnamed_27[0u] = 1030811889u;
				fragment_unnamed_27[4u] = 1057458056u;
				fragment_unnamed_27[8u] = 1043641525u;
				fragment_unnamed_27[12u] = 1059431846u;
				fragment_unnamed_27[16u] = 1061405636u;
				fragment_unnamed_27[20u] = 1050056343u;
				fragment_unnamed_27[24u] = 1063379426u;
				fragment_unnamed_27[28u] = 1054003923u;
				fragment_unnamed_27[32u] = 1047589105u;
				fragment_unnamed_27[36u] = 1060418741u;
				fragment_unnamed_27[40u] = 1039200497u;
				fragment_unnamed_27[44u] = 1058444951u;
				fragment_unnamed_27[48u] = 1064366321u;
				fragment_unnamed_27[52u] = 1055977713u;
				fragment_unnamed_27[56u] = 1062392531u;
				fragment_unnamed_27[60u] = 1052030133u;
				uint fragment_unnamed_120 = 2u & 31u;
				uint fragment_unnamed_126 = 0u & 31u;
				discard_cond((((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_27[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_120, min((2u & 31u), (32u - fragment_unnamed_120))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_126, min((2u & 31u), (32u - fragment_unnamed_126))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_1[0u].x) + 2.0f))) + 1.0f) < 0.0f);
				discard_exit();
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 _ProjectionParams;
			float4 _ScreenParams;
			float4 unity_RenderingLayer;
			float _Fade;

			static float4 fragment_uniform_buffer_0[62];
			static float4 fragment_uniform_buffer_1[11];
			static float4 fragment_uniform_buffer_2[1];
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

			void discard_cond(bool fragment_unnamed_240)
			{
				if (fragment_unnamed_240)
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
				uint fragment_unnamed_34[64];
				fragment_unnamed_34[0u] = 1030811889u;
				fragment_unnamed_34[4u] = 1057458056u;
				fragment_unnamed_34[8u] = 1043641525u;
				fragment_unnamed_34[12u] = 1059431846u;
				fragment_unnamed_34[16u] = 1061405636u;
				fragment_unnamed_34[20u] = 1050056343u;
				fragment_unnamed_34[24u] = 1063379426u;
				fragment_unnamed_34[28u] = 1054003923u;
				fragment_unnamed_34[32u] = 1047589105u;
				fragment_unnamed_34[36u] = 1060418741u;
				fragment_unnamed_34[40u] = 1039200497u;
				fragment_unnamed_34[44u] = 1058444951u;
				fragment_unnamed_34[48u] = 1064366321u;
				fragment_unnamed_34[52u] = 1055977713u;
				fragment_unnamed_34[56u] = 1062392531u;
				fragment_unnamed_34[60u] = 1052030133u;
				uint fragment_unnamed_127 = 2u & 31u;
				uint fragment_unnamed_133 = 0u & 31u;
				discard_cond((((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_34[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_127, min((2u & 31u), (32u - fragment_unnamed_127))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_133, min((2u & 31u), (32u - fragment_unnamed_133))) * 4u) + 0u])) + (((-0.0f) - fragment_uniform_buffer_2[0u].x) + 2.0f))) + 1.0f) < 0.0f);
				float fragment_unnamed_174 = 1.0f / max(sqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_181 = fragment_unnamed_174 * fragment_input_2.x;
				float fragment_unnamed_182 = fragment_unnamed_174 * fragment_input_2.y;
				float fragment_unnamed_183 = fragment_unnamed_174 * fragment_input_2.z;
				float fragment_unnamed_192 = 1.0f / max(dot(float3(abs(fragment_unnamed_181), abs(fragment_unnamed_182), abs(fragment_unnamed_183)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_197 = clamp((-0.0f) - (fragment_unnamed_192 * fragment_unnamed_183), 0.0f, 1.0f);
				float fragment_unnamed_200 = (-0.0f) - fragment_unnamed_197;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_181, fragment_unnamed_192, ((fragment_unnamed_192 * fragment_unnamed_181) >= 0.0f) ? fragment_unnamed_197 : fragment_unnamed_200), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_182, fragment_unnamed_192, ((fragment_unnamed_192 * fragment_unnamed_182) >= 0.0f) ? fragment_unnamed_197 : fragment_unnamed_200), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_221 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_221, min((8u & 31u), (32u - fragment_unnamed_221)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[0] = float4(_Fade, fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 unity_RenderingLayer;

			static float4 fragment_uniform_buffer_0[11];
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
				float fragment_unnamed_44 = 1.0f / max(sqrt(dot(float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z), float3(fragment_input_2.x, fragment_input_2.y, fragment_input_2.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_52 = fragment_unnamed_44 * fragment_input_2.x;
				float fragment_unnamed_53 = fragment_unnamed_44 * fragment_input_2.y;
				float fragment_unnamed_54 = fragment_unnamed_44 * fragment_input_2.z;
				float fragment_unnamed_63 = 1.0f / max(dot(float3(abs(fragment_unnamed_52), abs(fragment_unnamed_53), abs(fragment_unnamed_54)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_70 = clamp((-0.0f) - (fragment_unnamed_63 * fragment_unnamed_54), 0.0f, 1.0f);
				float fragment_unnamed_74 = (-0.0f) - fragment_unnamed_70;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_52, fragment_unnamed_63, ((fragment_unnamed_63 * fragment_unnamed_52) >= 0.0f) ? fragment_unnamed_70 : fragment_unnamed_74), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_53, fragment_unnamed_63, ((fragment_unnamed_63 * fragment_unnamed_53) >= 0.0f) ? fragment_unnamed_70 : fragment_unnamed_74), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_98 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_0[10u]).x, fragment_unnamed_98, min((8u & 31u), (32u - fragment_unnamed_98)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_0[10u]).x & 255u) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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
			static float4 vertex_uniform_buffer_2[11];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_output_1;
			static float3 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float3 vertex_output_2 : INTERP1; // INTERP_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_80 = asfloat(1065353216u);
				float vertex_unnamed_82 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_80));
				float vertex_unnamed_111 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_80));
				float vertex_unnamed_141 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_80));
				uint vertex_unnamed_182 = ((0.0f < vertex_uniform_buffer_2[10u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u);
				bool vertex_unnamed_183 = vertex_unnamed_182 != 0u;
				gl_Position.x = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x);
				gl_Position.y = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y);
				gl_Position.z = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z);
				gl_Position.w = vertex_unnamed_183 ? 0.0f : (mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_141, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_111, vertex_unnamed_82 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w);
				float vertex_unnamed_220 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_221 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_222 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_228 = rsqrt(max(dot(float3(vertex_unnamed_220, vertex_unnamed_221, vertex_unnamed_222), float3(vertex_unnamed_220, vertex_unnamed_221, vertex_unnamed_222)), 1.1754943508222875079687365372222e-38f));
				bool vertex_unnamed_234 = vertex_unnamed_182 != 0u;
				vertex_output_1.x = vertex_unnamed_234 ? 0.0f : (vertex_unnamed_228 * vertex_unnamed_220);
				vertex_output_1.y = vertex_unnamed_234 ? 0.0f : (vertex_unnamed_228 * vertex_unnamed_221);
				vertex_output_1.z = vertex_unnamed_234 ? 0.0f : (vertex_unnamed_228 * vertex_unnamed_222);
				vertex_output_1.w = vertex_unnamed_234 ? 0.0f : vertex_input_2.w;
				float vertex_unnamed_255 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_270 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_285 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_292 = rsqrt(max(dot(float3(vertex_unnamed_255, vertex_unnamed_270, vertex_unnamed_285), float3(vertex_unnamed_255, vertex_unnamed_270, vertex_unnamed_285)), 1.1754943508222875079687365372222e-38f));
				bool vertex_unnamed_296 = vertex_unnamed_182 != 0u;
				vertex_output_2.x = vertex_unnamed_296 ? 0.0f : (vertex_unnamed_292 * vertex_unnamed_255);
				vertex_output_2.y = vertex_unnamed_296 ? 0.0f : (vertex_unnamed_292 * vertex_unnamed_270);
				vertex_output_2.z = vertex_unnamed_296 ? 0.0f : (vertex_unnamed_292 * vertex_unnamed_285);
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

				vertex_uniform_buffer_2[10] = float4(vertex_uniform_buffer_2[10][0], vertex_uniform_buffer_2[10][1], _RayTracing, vertex_uniform_buffer_2[10][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float3 fragment_input_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float3 fragment_input_2 : INTERP1; // INTERP_1
			};

			void frag_main()
			{
			}

			void frag(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
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
			GpuProgramID 543460

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ DECALS_3RT
			#pragma multi_compile _ _ALPHATEST_ON


			#if (!defined(_ALPHATEST_ON) && !defined(DECALS_3RT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[11];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_4 : TEXCOORD2; // TEXCOORD_2
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				float3 vertex_output_5 : INTERP4; // INTERP_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				if ((((0.0f < vertex_uniform_buffer_2[10u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_126 = asfloat(1065353216u);
					float vertex_unnamed_128 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_126));
					float vertex_unnamed_146 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_126));
					float vertex_unnamed_164 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_126));
					float vertex_unnamed_179 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_194 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_209 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_218 = rsqrt(max(dot(float3(vertex_unnamed_179, vertex_unnamed_194, vertex_unnamed_209), float3(vertex_unnamed_179, vertex_unnamed_194, vertex_unnamed_209)), 1.1754943508222875079687365372222e-38f));
					vertex_output_5.x = vertex_unnamed_218 * vertex_unnamed_179;
					vertex_output_5.y = vertex_unnamed_218 * vertex_unnamed_194;
					vertex_output_5.z = vertex_unnamed_218 * vertex_unnamed_209;
					float vertex_unnamed_252 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_253 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_254 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_259 = rsqrt(max(dot(float3(vertex_unnamed_252, vertex_unnamed_253, vertex_unnamed_254), float3(vertex_unnamed_252, vertex_unnamed_253, vertex_unnamed_254)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_259 * vertex_unnamed_252;
					vertex_output_1.y = vertex_unnamed_259 * vertex_unnamed_253;
					vertex_output_1.z = vertex_unnamed_259 * vertex_unnamed_254;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
					vertex_output_1.w = vertex_input_2.w;
					vertex_output_2.x = vertex_input_3.x;
					vertex_output_2.y = vertex_input_3.y;
					vertex_output_2.z = vertex_input_3.z;
					vertex_output_2.w = vertex_input_3.w;
					vertex_output_3.x = vertex_input_4.x;
					vertex_output_3.y = vertex_input_4.y;
					vertex_output_3.z = vertex_input_4.z;
					vertex_output_3.w = vertex_input_4.w;
					vertex_output_4.x = vertex_unnamed_128;
					vertex_output_4.y = vertex_unnamed_146;
					vertex_output_4.z = vertex_unnamed_164;
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

				vertex_uniform_buffer_2[10] = float4(vertex_uniform_buffer_2[10][0], vertex_uniform_buffer_2[10][1], _RayTracing, vertex_uniform_buffer_2[10][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
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
			#if (defined(_ALPHATEST_ON) && !defined(DECALS_3RT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[11];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_4 : TEXCOORD2; // TEXCOORD_2
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				float3 vertex_output_5 : INTERP4; // INTERP_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				if ((((0.0f < vertex_uniform_buffer_2[10u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_126 = asfloat(1065353216u);
					float vertex_unnamed_128 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_126));
					float vertex_unnamed_146 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_126));
					float vertex_unnamed_164 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_126));
					float vertex_unnamed_179 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_194 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_209 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_218 = rsqrt(max(dot(float3(vertex_unnamed_179, vertex_unnamed_194, vertex_unnamed_209), float3(vertex_unnamed_179, vertex_unnamed_194, vertex_unnamed_209)), 1.1754943508222875079687365372222e-38f));
					vertex_output_5.x = vertex_unnamed_218 * vertex_unnamed_179;
					vertex_output_5.y = vertex_unnamed_218 * vertex_unnamed_194;
					vertex_output_5.z = vertex_unnamed_218 * vertex_unnamed_209;
					float vertex_unnamed_252 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_253 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_254 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_259 = rsqrt(max(dot(float3(vertex_unnamed_252, vertex_unnamed_253, vertex_unnamed_254), float3(vertex_unnamed_252, vertex_unnamed_253, vertex_unnamed_254)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_259 * vertex_unnamed_252;
					vertex_output_1.y = vertex_unnamed_259 * vertex_unnamed_253;
					vertex_output_1.z = vertex_unnamed_259 * vertex_unnamed_254;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
					vertex_output_1.w = vertex_input_2.w;
					vertex_output_2.x = vertex_input_3.x;
					vertex_output_2.y = vertex_input_3.y;
					vertex_output_2.z = vertex_input_3.z;
					vertex_output_2.w = vertex_input_3.w;
					vertex_output_3.x = vertex_input_4.x;
					vertex_output_3.y = vertex_input_4.y;
					vertex_output_3.z = vertex_input_4.z;
					vertex_output_3.w = vertex_input_4.w;
					vertex_output_4.x = vertex_unnamed_128;
					vertex_output_4.y = vertex_unnamed_146;
					vertex_output_4.z = vertex_unnamed_164;
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

				vertex_uniform_buffer_2[10] = float4(vertex_uniform_buffer_2[10][0], vertex_uniform_buffer_2[10][1], _RayTracing, vertex_uniform_buffer_2[10][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
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
			#if (defined(DECALS_3RT) && defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
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
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float4 unity_ProbeVolumeSizeInv;
			float4 unity_ProbeVolumeMin;
			float _Metallic;
			float4 _Color;
			float _Smoothness;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[3];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;
			static float4 fragment_output_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
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
				float fragment_unnamed_84 = 1.0f / max(sqrt(dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_92 = fragment_unnamed_84 * fragment_input_5.x;
				float fragment_unnamed_93 = fragment_unnamed_84 * fragment_input_5.y;
				float fragment_unnamed_94 = fragment_unnamed_84 * fragment_input_5.z;
				bool fragment_unnamed_101 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_129 = asfloat(fragment_unnamed_101 ? asuint(((-0.0f) - fragment_input_4.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_136 = asfloat(fragment_unnamed_101 ? asuint(((-0.0f) - fragment_input_4.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_143 = asfloat(fragment_unnamed_101 ? asuint(((-0.0f) - fragment_input_4.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_147 = rsqrt(dot(float3(fragment_unnamed_129, fragment_unnamed_136, fragment_unnamed_143), float3(fragment_unnamed_129, fragment_unnamed_136, fragment_unnamed_143)));
				float fragment_unnamed_155 = rsqrt(max(dot(float3(fragment_unnamed_92, fragment_unnamed_93, fragment_unnamed_94), float3(fragment_unnamed_92, fragment_unnamed_93, fragment_unnamed_94)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_156 = fragment_unnamed_155 * fragment_unnamed_92;
				float fragment_unnamed_157 = fragment_unnamed_155 * fragment_unnamed_93;
				float fragment_unnamed_158 = fragment_unnamed_155 * fragment_unnamed_94;
				float fragment_unnamed_243;
				float fragment_unnamed_244;
				float fragment_unnamed_245;
				float fragment_unnamed_246;
				float fragment_unnamed_247;
				uint fragment_unnamed_248;
				float fragment_unnamed_249;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_169 = uint(gl_FragCoord.x);
					uint fragment_unnamed_170 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_171 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_169, fragment_unnamed_170, 0u), 0u));
					float fragment_unnamed_177 = fragment_unnamed_171.w;
					float4 fragment_unnamed_178 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_169, fragment_unnamed_170, 0u), 0u));
					float fragment_unnamed_183 = fragment_unnamed_178.w;
					float4 fragment_unnamed_184 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_169, fragment_unnamed_170, 0u), 0u));
					bool fragment_unnamed_193 = fragment_unnamed_183 < 1.0f;
					float fragment_unnamed_194 = mad(fragment_unnamed_156, fragment_unnamed_183, mad(fragment_unnamed_178.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_195 = mad(fragment_unnamed_157, fragment_unnamed_183, mad(fragment_unnamed_178.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_196 = mad(fragment_unnamed_158, fragment_unnamed_183, mad(fragment_unnamed_178.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_201 = rsqrt(max(dot(float3(fragment_unnamed_194, fragment_unnamed_195, fragment_unnamed_196), float3(fragment_unnamed_194, fragment_unnamed_195, fragment_unnamed_196)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_243 = asfloat(fragment_unnamed_193 ? asuint(fragment_unnamed_201 * fragment_unnamed_195) : asuint(fragment_unnamed_157));
					fragment_unnamed_244 = asfloat(fragment_unnamed_193 ? asuint(fragment_unnamed_201 * fragment_unnamed_196) : asuint(fragment_unnamed_158));
					fragment_unnamed_245 = mad(fragment_uniform_buffer_2[1u].x, fragment_unnamed_177, fragment_unnamed_171.x);
					fragment_unnamed_246 = mad(fragment_uniform_buffer_2[1u].y, fragment_unnamed_177, fragment_unnamed_171.y);
					fragment_unnamed_247 = mad(fragment_uniform_buffer_2[1u].z, fragment_unnamed_177, fragment_unnamed_171.z);
					fragment_unnamed_248 = asuint(mad(fragment_uniform_buffer_2[2u].x, fragment_unnamed_184.w, fragment_unnamed_184.z));
					fragment_unnamed_249 = asfloat(fragment_unnamed_193 ? asuint(fragment_unnamed_201 * fragment_unnamed_194) : asuint(fragment_unnamed_156));
				}
				else
				{
					uint4 fragment_unnamed_236 = asuint(fragment_uniform_buffer_2[1u]);
					fragment_unnamed_243 = fragment_unnamed_157;
					fragment_unnamed_244 = fragment_unnamed_158;
					fragment_unnamed_245 = asfloat(fragment_unnamed_236.x);
					fragment_unnamed_246 = asfloat(fragment_unnamed_236.y);
					fragment_unnamed_247 = asfloat(fragment_unnamed_236.z);
					fragment_unnamed_248 = asuint(fragment_uniform_buffer_2[2u]).x;
					fragment_unnamed_249 = fragment_unnamed_156;
				}
				uint4 fragment_unnamed_264 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_265 = fragment_unnamed_264.x;
				float fragment_unnamed_553;
				float fragment_unnamed_555;
				float fragment_unnamed_557;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_265 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_265 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_554;
					float fragment_unnamed_556;
					float fragment_unnamed_558;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_289 = asfloat(1065353216u);
						float fragment_unnamed_320 = fragment_unnamed_243 * fragment_unnamed_249;
						float fragment_unnamed_321 = fragment_unnamed_244 * fragment_unnamed_243;
						float fragment_unnamed_322 = fragment_unnamed_244 * fragment_unnamed_244;
						float fragment_unnamed_323 = fragment_unnamed_249 * fragment_unnamed_244;
						float fragment_unnamed_356 = mad(fragment_unnamed_249, fragment_unnamed_249, (-0.0f) - (fragment_unnamed_243 * fragment_unnamed_243));
						fragment_unnamed_554 = mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_356, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_320, fragment_unnamed_321, fragment_unnamed_322, fragment_unnamed_323))) + dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_289));
						fragment_unnamed_556 = mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_356, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_320, fragment_unnamed_321, fragment_unnamed_322, fragment_unnamed_323))) + dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_289));
						fragment_unnamed_558 = mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_356, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_320, fragment_unnamed_321, fragment_unnamed_322, fragment_unnamed_323))) + dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_289));
					}
					else
					{
						bool fragment_unnamed_372 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_373 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_395 = fragment_unnamed_372 ? (fragment_input_4.x + fragment_uniform_buffer_0[48u].x) : fragment_input_4.x;
						float fragment_unnamed_396 = fragment_unnamed_372 ? (fragment_input_4.y + fragment_uniform_buffer_0[48u].y) : fragment_input_4.y;
						float fragment_unnamed_397 = fragment_unnamed_372 ? (fragment_input_4.z + fragment_uniform_buffer_0[48u].z) : fragment_input_4.z;
						float fragment_unnamed_501 = (asfloat(fragment_unnamed_373 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_397, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_395, fragment_unnamed_396 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_396)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_502 = (asfloat(fragment_unnamed_373 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_397, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_395, fragment_unnamed_396 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_397)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_516 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(((asfloat(fragment_unnamed_373 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_397, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_395, fragment_unnamed_396 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_395)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f, fragment_uniform_buffer_1[22u].z * 0.5f));
						float fragment_unnamed_543 = asfloat(1065353216u);
						fragment_unnamed_554 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_516, fragment_unnamed_501, fragment_unnamed_502), 0.0f)), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_543));
						fragment_unnamed_556 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_516 + 0.25f, fragment_unnamed_501 + 0.0f, fragment_unnamed_502 + 0.0f), 0.0f)), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_543));
						fragment_unnamed_558 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_516 + 0.5f, fragment_unnamed_501 + 0.0f, fragment_unnamed_502 + 0.0f), 0.0f)), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_543));
					}
					fragment_unnamed_553 = fragment_unnamed_554;
					fragment_unnamed_555 = fragment_unnamed_556;
					fragment_unnamed_557 = fragment_unnamed_558;
				}
				else
				{
					fragment_unnamed_553 = asfloat(0u);
					fragment_unnamed_555 = asfloat(0u);
					fragment_unnamed_557 = asfloat(0u);
				}
				float fragment_unnamed_561 = ((-0.0f) - asfloat(fragment_unnamed_248)) + 1.0f;
				float fragment_unnamed_566 = ((-0.0f) - fragment_uniform_buffer_2[0u].y) + 1.0f;
				float fragment_unnamed_567 = fragment_unnamed_566 * fragment_unnamed_245;
				float fragment_unnamed_568 = fragment_unnamed_566 * fragment_unnamed_246;
				float fragment_unnamed_569 = fragment_unnamed_566 * fragment_unnamed_247;
				float fragment_unnamed_577 = mad(fragment_uniform_buffer_2[0u].y, fragment_unnamed_245 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_579 = mad(fragment_uniform_buffer_2[0u].y, fragment_unnamed_246 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_580 = mad(fragment_uniform_buffer_2[0u].y, fragment_unnamed_247 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_599 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244), float3(fragment_unnamed_147 * fragment_unnamed_129, fragment_unnamed_147 * fragment_unnamed_136, fragment_unnamed_147 * fragment_unnamed_143)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_561, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_609 = clamp((max(fragment_unnamed_580, max(fragment_unnamed_579, fragment_unnamed_577)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_633 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_638 = max(abs(fragment_unnamed_244), 0.0009765625f);
				float fragment_unnamed_642 = (fragment_unnamed_244 >= 0.0f) ? fragment_unnamed_638 : ((-0.0f) - fragment_unnamed_638);
				float fragment_unnamed_651 = 1.0f / max(dot(float3(abs(fragment_unnamed_249), abs(fragment_unnamed_243), abs(fragment_unnamed_642)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_656 = clamp((-0.0f) - (fragment_unnamed_651 * fragment_unnamed_642), 0.0f, 1.0f);
				float fragment_unnamed_659 = (-0.0f) - fragment_unnamed_656;
				uint fragment_unnamed_671 = uint(clamp(mad(mad(fragment_unnamed_249, fragment_unnamed_651, ((fragment_unnamed_651 * fragment_unnamed_249) >= 0.0f) ? fragment_unnamed_656 : fragment_unnamed_659), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_672 = uint(clamp(mad(mad(fragment_unnamed_243, fragment_unnamed_651, ((fragment_unnamed_651 * fragment_unnamed_243) >= 0.0f) ? fragment_unnamed_656 : fragment_unnamed_659), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_671 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_672 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_672 >> 8u) * 16u) + (fragment_unnamed_671 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_577)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_579)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_580)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_723 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_724 = fragment_unnamed_723 * (fragment_unnamed_633 * ((mad(fragment_unnamed_609, mad((-0.0f) - fragment_unnamed_245, fragment_unnamed_566, fragment_unnamed_577), fragment_unnamed_567) * fragment_unnamed_599) * fragment_unnamed_553));
				float fragment_unnamed_725 = fragment_unnamed_723 * (fragment_unnamed_633 * ((mad(fragment_unnamed_609, mad((-0.0f) - fragment_unnamed_246, fragment_unnamed_566, fragment_unnamed_579), fragment_unnamed_568) * fragment_unnamed_599) * fragment_unnamed_555));
				float fragment_unnamed_726 = fragment_unnamed_723 * (fragment_unnamed_633 * ((mad(fragment_unnamed_609, mad((-0.0f) - fragment_unnamed_247, fragment_unnamed_566, fragment_unnamed_580), fragment_unnamed_569) * fragment_unnamed_599) * fragment_unnamed_557));
				bool fragment_unnamed_735 = (((fragment_unnamed_726 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_725 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_724 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_735 ? 2048.0f : fragment_unnamed_724;
				fragment_output_3.y = fragment_unnamed_735 ? 1.0f : fragment_unnamed_725;
				fragment_output_3.z = fragment_unnamed_735 ? 1024.0f : fragment_unnamed_726;
				fragment_output_0.x = fragment_unnamed_567;
				fragment_output_0.y = fragment_unnamed_568;
				fragment_output_0.z = fragment_unnamed_569;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_unnamed_561;
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

				fragment_uniform_buffer_1[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_1[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_1[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_1[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_1[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_1[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_1[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_2[0] = float4(fragment_uniform_buffer_2[0][0], _Metallic, fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_2[1] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_2[2] = float4(_Smoothness, fragment_uniform_buffer_2[2][1], fragment_uniform_buffer_2[2][2], fragment_uniform_buffer_2[2][3]);

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
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif
			#if (defined(DECALS_3RT) && !defined(_ALPHATEST_ON)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
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
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float4 unity_ProbeVolumeSizeInv;
			float4 unity_ProbeVolumeMin;
			float _Metallic;
			float4 _Color;
			float _Smoothness;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[3];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_output_0;
			static float4 fragment_output_1;
			static float4 fragment_output_2;
			static float4 fragment_output_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
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
				float fragment_unnamed_84 = 1.0f / max(sqrt(dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_92 = fragment_unnamed_84 * fragment_input_5.x;
				float fragment_unnamed_93 = fragment_unnamed_84 * fragment_input_5.y;
				float fragment_unnamed_94 = fragment_unnamed_84 * fragment_input_5.z;
				bool fragment_unnamed_101 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_129 = asfloat(fragment_unnamed_101 ? asuint(((-0.0f) - fragment_input_4.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_136 = asfloat(fragment_unnamed_101 ? asuint(((-0.0f) - fragment_input_4.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_143 = asfloat(fragment_unnamed_101 ? asuint(((-0.0f) - fragment_input_4.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_147 = rsqrt(dot(float3(fragment_unnamed_129, fragment_unnamed_136, fragment_unnamed_143), float3(fragment_unnamed_129, fragment_unnamed_136, fragment_unnamed_143)));
				float fragment_unnamed_155 = rsqrt(max(dot(float3(fragment_unnamed_92, fragment_unnamed_93, fragment_unnamed_94), float3(fragment_unnamed_92, fragment_unnamed_93, fragment_unnamed_94)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_156 = fragment_unnamed_155 * fragment_unnamed_92;
				float fragment_unnamed_157 = fragment_unnamed_155 * fragment_unnamed_93;
				float fragment_unnamed_158 = fragment_unnamed_155 * fragment_unnamed_94;
				float fragment_unnamed_243;
				float fragment_unnamed_244;
				float fragment_unnamed_245;
				float fragment_unnamed_246;
				float fragment_unnamed_247;
				uint fragment_unnamed_248;
				float fragment_unnamed_249;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_169 = uint(gl_FragCoord.x);
					uint fragment_unnamed_170 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_171 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_169, fragment_unnamed_170, 0u), 0u));
					float fragment_unnamed_177 = fragment_unnamed_171.w;
					float4 fragment_unnamed_178 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_169, fragment_unnamed_170, 0u), 0u));
					float fragment_unnamed_183 = fragment_unnamed_178.w;
					float4 fragment_unnamed_184 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_169, fragment_unnamed_170, 0u), 0u));
					bool fragment_unnamed_193 = fragment_unnamed_183 < 1.0f;
					float fragment_unnamed_194 = mad(fragment_unnamed_156, fragment_unnamed_183, mad(fragment_unnamed_178.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_195 = mad(fragment_unnamed_157, fragment_unnamed_183, mad(fragment_unnamed_178.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_196 = mad(fragment_unnamed_158, fragment_unnamed_183, mad(fragment_unnamed_178.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_201 = rsqrt(max(dot(float3(fragment_unnamed_194, fragment_unnamed_195, fragment_unnamed_196), float3(fragment_unnamed_194, fragment_unnamed_195, fragment_unnamed_196)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_243 = asfloat(fragment_unnamed_193 ? asuint(fragment_unnamed_201 * fragment_unnamed_195) : asuint(fragment_unnamed_157));
					fragment_unnamed_244 = asfloat(fragment_unnamed_193 ? asuint(fragment_unnamed_201 * fragment_unnamed_196) : asuint(fragment_unnamed_158));
					fragment_unnamed_245 = mad(fragment_uniform_buffer_2[1u].x, fragment_unnamed_177, fragment_unnamed_171.x);
					fragment_unnamed_246 = mad(fragment_uniform_buffer_2[1u].y, fragment_unnamed_177, fragment_unnamed_171.y);
					fragment_unnamed_247 = mad(fragment_uniform_buffer_2[1u].z, fragment_unnamed_177, fragment_unnamed_171.z);
					fragment_unnamed_248 = asuint(mad(fragment_uniform_buffer_2[2u].x, fragment_unnamed_184.w, fragment_unnamed_184.z));
					fragment_unnamed_249 = asfloat(fragment_unnamed_193 ? asuint(fragment_unnamed_201 * fragment_unnamed_194) : asuint(fragment_unnamed_156));
				}
				else
				{
					uint4 fragment_unnamed_236 = asuint(fragment_uniform_buffer_2[1u]);
					fragment_unnamed_243 = fragment_unnamed_157;
					fragment_unnamed_244 = fragment_unnamed_158;
					fragment_unnamed_245 = asfloat(fragment_unnamed_236.x);
					fragment_unnamed_246 = asfloat(fragment_unnamed_236.y);
					fragment_unnamed_247 = asfloat(fragment_unnamed_236.z);
					fragment_unnamed_248 = asuint(fragment_uniform_buffer_2[2u]).x;
					fragment_unnamed_249 = fragment_unnamed_156;
				}
				uint4 fragment_unnamed_264 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_265 = fragment_unnamed_264.x;
				float fragment_unnamed_553;
				float fragment_unnamed_555;
				float fragment_unnamed_557;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_265 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_265 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_554;
					float fragment_unnamed_556;
					float fragment_unnamed_558;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_289 = asfloat(1065353216u);
						float fragment_unnamed_320 = fragment_unnamed_243 * fragment_unnamed_249;
						float fragment_unnamed_321 = fragment_unnamed_244 * fragment_unnamed_243;
						float fragment_unnamed_322 = fragment_unnamed_244 * fragment_unnamed_244;
						float fragment_unnamed_323 = fragment_unnamed_249 * fragment_unnamed_244;
						float fragment_unnamed_356 = mad(fragment_unnamed_249, fragment_unnamed_249, (-0.0f) - (fragment_unnamed_243 * fragment_unnamed_243));
						fragment_unnamed_554 = mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_356, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_320, fragment_unnamed_321, fragment_unnamed_322, fragment_unnamed_323))) + dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_289));
						fragment_unnamed_556 = mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_356, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_320, fragment_unnamed_321, fragment_unnamed_322, fragment_unnamed_323))) + dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_289));
						fragment_unnamed_558 = mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_356, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_320, fragment_unnamed_321, fragment_unnamed_322, fragment_unnamed_323))) + dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_289));
					}
					else
					{
						bool fragment_unnamed_372 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_373 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_395 = fragment_unnamed_372 ? (fragment_input_4.x + fragment_uniform_buffer_0[48u].x) : fragment_input_4.x;
						float fragment_unnamed_396 = fragment_unnamed_372 ? (fragment_input_4.y + fragment_uniform_buffer_0[48u].y) : fragment_input_4.y;
						float fragment_unnamed_397 = fragment_unnamed_372 ? (fragment_input_4.z + fragment_uniform_buffer_0[48u].z) : fragment_input_4.z;
						float fragment_unnamed_501 = (asfloat(fragment_unnamed_373 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_397, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_395, fragment_unnamed_396 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_396)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_502 = (asfloat(fragment_unnamed_373 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_397, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_395, fragment_unnamed_396 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_397)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_516 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(((asfloat(fragment_unnamed_373 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_397, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_395, fragment_unnamed_396 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_395)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f, fragment_uniform_buffer_1[22u].z * 0.5f));
						float fragment_unnamed_543 = asfloat(1065353216u);
						fragment_unnamed_554 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_516, fragment_unnamed_501, fragment_unnamed_502), 0.0f)), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_543));
						fragment_unnamed_556 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_516 + 0.25f, fragment_unnamed_501 + 0.0f, fragment_unnamed_502 + 0.0f), 0.0f)), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_543));
						fragment_unnamed_558 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_516 + 0.5f, fragment_unnamed_501 + 0.0f, fragment_unnamed_502 + 0.0f), 0.0f)), float4(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244, fragment_unnamed_543));
					}
					fragment_unnamed_553 = fragment_unnamed_554;
					fragment_unnamed_555 = fragment_unnamed_556;
					fragment_unnamed_557 = fragment_unnamed_558;
				}
				else
				{
					fragment_unnamed_553 = asfloat(0u);
					fragment_unnamed_555 = asfloat(0u);
					fragment_unnamed_557 = asfloat(0u);
				}
				float fragment_unnamed_561 = ((-0.0f) - asfloat(fragment_unnamed_248)) + 1.0f;
				float fragment_unnamed_566 = ((-0.0f) - fragment_uniform_buffer_2[0u].y) + 1.0f;
				float fragment_unnamed_567 = fragment_unnamed_566 * fragment_unnamed_245;
				float fragment_unnamed_568 = fragment_unnamed_566 * fragment_unnamed_246;
				float fragment_unnamed_569 = fragment_unnamed_566 * fragment_unnamed_247;
				float fragment_unnamed_577 = mad(fragment_uniform_buffer_2[0u].y, fragment_unnamed_245 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_579 = mad(fragment_uniform_buffer_2[0u].y, fragment_unnamed_246 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_580 = mad(fragment_uniform_buffer_2[0u].y, fragment_unnamed_247 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_599 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_249, fragment_unnamed_243, fragment_unnamed_244), float3(fragment_unnamed_147 * fragment_unnamed_129, fragment_unnamed_147 * fragment_unnamed_136, fragment_unnamed_147 * fragment_unnamed_143)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_561, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_609 = clamp((max(fragment_unnamed_580, max(fragment_unnamed_579, fragment_unnamed_577)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_633 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_638 = max(abs(fragment_unnamed_244), 0.0009765625f);
				float fragment_unnamed_642 = (fragment_unnamed_244 >= 0.0f) ? fragment_unnamed_638 : ((-0.0f) - fragment_unnamed_638);
				float fragment_unnamed_651 = 1.0f / max(dot(float3(abs(fragment_unnamed_249), abs(fragment_unnamed_243), abs(fragment_unnamed_642)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_656 = clamp((-0.0f) - (fragment_unnamed_651 * fragment_unnamed_642), 0.0f, 1.0f);
				float fragment_unnamed_659 = (-0.0f) - fragment_unnamed_656;
				uint fragment_unnamed_671 = uint(clamp(mad(mad(fragment_unnamed_249, fragment_unnamed_651, ((fragment_unnamed_651 * fragment_unnamed_249) >= 0.0f) ? fragment_unnamed_656 : fragment_unnamed_659), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_672 = uint(clamp(mad(mad(fragment_unnamed_243, fragment_unnamed_651, ((fragment_unnamed_651 * fragment_unnamed_243) >= 0.0f) ? fragment_unnamed_656 : fragment_unnamed_659), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_671 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_672 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_672 >> 8u) * 16u) + (fragment_unnamed_671 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_577)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_579)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_580)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_723 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_724 = fragment_unnamed_723 * (fragment_unnamed_633 * ((mad(fragment_unnamed_609, mad((-0.0f) - fragment_unnamed_245, fragment_unnamed_566, fragment_unnamed_577), fragment_unnamed_567) * fragment_unnamed_599) * fragment_unnamed_553));
				float fragment_unnamed_725 = fragment_unnamed_723 * (fragment_unnamed_633 * ((mad(fragment_unnamed_609, mad((-0.0f) - fragment_unnamed_246, fragment_unnamed_566, fragment_unnamed_579), fragment_unnamed_568) * fragment_unnamed_599) * fragment_unnamed_555));
				float fragment_unnamed_726 = fragment_unnamed_723 * (fragment_unnamed_633 * ((mad(fragment_unnamed_609, mad((-0.0f) - fragment_unnamed_247, fragment_unnamed_566, fragment_unnamed_580), fragment_unnamed_569) * fragment_unnamed_599) * fragment_unnamed_557));
				bool fragment_unnamed_735 = (((fragment_unnamed_726 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_725 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_724 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_735 ? 2048.0f : fragment_unnamed_724;
				fragment_output_3.y = fragment_unnamed_735 ? 1.0f : fragment_unnamed_725;
				fragment_output_3.z = fragment_unnamed_735 ? 1024.0f : fragment_unnamed_726;
				fragment_output_0.x = fragment_unnamed_567;
				fragment_output_0.y = fragment_unnamed_568;
				fragment_output_0.z = fragment_unnamed_569;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_unnamed_561;
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

				fragment_uniform_buffer_1[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_1[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_1[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_1[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_1[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_1[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_1[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_2[0] = float4(fragment_uniform_buffer_2[0][0], _Metallic, fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_2[1] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_uniform_buffer_2[2] = float4(_Smoothness, fragment_uniform_buffer_2[2][1], fragment_uniform_buffer_2[2][2], fragment_uniform_buffer_2[2][3]);

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
			static float4 vertex_uniform_buffer_2[11];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float3 vertex_output_4;
			static float3 vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
				float4 vertex_input_4 : TEXCOORD2; // TEXCOORD_2
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				float3 vertex_output_5 : INTERP4; // INTERP_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				if ((((0.0f < vertex_uniform_buffer_2[10u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					vertex_output_5.x = 0.0f;
					vertex_output_5.y = 0.0f;
					vertex_output_5.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_126 = asfloat(1065353216u);
					float vertex_unnamed_128 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_126));
					float vertex_unnamed_146 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_126));
					float vertex_unnamed_164 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_126));
					float vertex_unnamed_179 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_194 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_209 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_218 = rsqrt(max(dot(float3(vertex_unnamed_179, vertex_unnamed_194, vertex_unnamed_209), float3(vertex_unnamed_179, vertex_unnamed_194, vertex_unnamed_209)), 1.1754943508222875079687365372222e-38f));
					vertex_output_5.x = vertex_unnamed_218 * vertex_unnamed_179;
					vertex_output_5.y = vertex_unnamed_218 * vertex_unnamed_194;
					vertex_output_5.z = vertex_unnamed_218 * vertex_unnamed_209;
					float vertex_unnamed_252 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_253 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_254 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_259 = rsqrt(max(dot(float3(vertex_unnamed_252, vertex_unnamed_253, vertex_unnamed_254), float3(vertex_unnamed_252, vertex_unnamed_253, vertex_unnamed_254)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_259 * vertex_unnamed_252;
					vertex_output_1.y = vertex_unnamed_259 * vertex_unnamed_253;
					vertex_output_1.z = vertex_unnamed_259 * vertex_unnamed_254;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_164, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_128, vertex_unnamed_146 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
					vertex_output_1.w = vertex_input_2.w;
					vertex_output_2.x = vertex_input_3.x;
					vertex_output_2.y = vertex_input_3.y;
					vertex_output_2.z = vertex_input_3.z;
					vertex_output_2.w = vertex_input_3.w;
					vertex_output_3.x = vertex_input_4.x;
					vertex_output_3.y = vertex_input_4.y;
					vertex_output_3.z = vertex_input_4.z;
					vertex_output_3.w = vertex_input_4.w;
					vertex_output_4.x = vertex_unnamed_128;
					vertex_output_4.y = vertex_unnamed_146;
					vertex_output_4.z = vertex_unnamed_164;
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

				vertex_uniform_buffer_2[10] = float4(vertex_uniform_buffer_2[10][0], vertex_uniform_buffer_2[10][1], _RayTracing, vertex_uniform_buffer_2[10][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
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
			GpuProgramID 768798

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
			GpuProgramID 847540

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
			GpuProgramID 903126

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
			GpuProgramID 970441

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
			GpuProgramID 1007226

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
			GpuProgramID 1092324

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
