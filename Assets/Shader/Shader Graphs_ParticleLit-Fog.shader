Shader "Shader Graphs/ParticleLit-Fog"
{
	Properties
	{
		[NoScaleOffset] Texture2D_23DD87FD ("Albedo", 2D) = "white" {}
		_Smoothness ("Smoothness", Range(0, 1)) = 0.5
		_Metallic ("Metallic", Range(0, 1)) = 0
		[NoScaleOffset] [Normal] _NormalMap ("NormalMap", 2D) = "bump" {}
		[HDR] _Emission ("Emission", Color) = (0,0,0,0)
		[Toggle(_IGNOREGLOBALFOG)] _IGNOREGLOBALFOG ("IgnoreGlobalFog", Float) = 0
		_Bloom ("Bloom", Float) = 0
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
		[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Boolean", Float) = 0
		[HideInInspector] _CullModeForward ("Float", Float) = 2
		[Enum(Front, 1, Back, 2)] [HideInInspector] _TransparentCullMode ("Float", Float) = 2
		[Enum(UnityEngine.Rendering.HighDefinition.OpaqueCullMode)] [HideInInspector] _OpaqueCullMode ("Float", Float) = 2
		[HideInInspector] _ZTestDepthEqualForOpaque ("Float", Float) = 4
		[Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _ZTestTransparent ("Float", Float) = 4
		[ToggleUI] [HideInInspector] _TransparentBackfaceEnable ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _RequireSplitLighting ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _ReceivesSSR ("Boolean", Float) = 1
		[ToggleUI] [HideInInspector] _ReceivesSSRTransparent ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _EnableBlendModePreserveSpecularLighting ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _SupportDecals ("Boolean", Float) = 0
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
			GpuProgramID 5160

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
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_76 = asfloat(1065353216u);
				float vertex_unnamed_78 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				float vertex_unnamed_107 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				float vertex_unnamed_137 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
				vertex_output_2.x = vertex_input_4.x;
				vertex_output_2.y = vertex_input_4.y;
				vertex_output_2.z = vertex_input_4.z;
				vertex_output_2.w = vertex_input_4.w;
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}
			#endif
			#if defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
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
			static float4 vertex_output_1;
			static float4 vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : COLOR; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_76 = asfloat(1065353216u);
				float vertex_unnamed_78 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				float vertex_unnamed_107 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				float vertex_unnamed_137 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
				vertex_output_2.x = vertex_input_4.x;
				vertex_output_2.y = vertex_input_4.y;
				vertex_output_2.z = vertex_input_4.z;
				vertex_output_2.w = vertex_input_4.w;
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
			static float4 fragment_input_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
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
			GpuProgramID 326032

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER


			#if (!defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_VERTEX)
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
			static float4 vertex_input_4;
			static float3 vertex_input_5;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
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
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // COLOR
				float3 vertex_input_5 : TEXCOORD4; // TEXCOORD_4
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float4 vertex_output_4 : INTERP1; // INTERP_1
				float4 vertex_output_5 : INTERP2; // INTERP_2
				float3 vertex_output_6 : INTERP3; // INTERP_3
				float3 vertex_output_7 : INTERP4; // INTERP_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_83 = asfloat(1065353216u);
				float vertex_unnamed_85 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_83));
				float vertex_unnamed_103 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_83));
				float vertex_unnamed_121 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_83));
				float vertex_unnamed_136 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_151 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_166 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_175 = rsqrt(max(dot(float3(vertex_unnamed_136, vertex_unnamed_151, vertex_unnamed_166), float3(vertex_unnamed_136, vertex_unnamed_151, vertex_unnamed_166)), 1.1754943508222875079687365372222e-38f));
				vertex_output_7.x = vertex_unnamed_175 * vertex_unnamed_136;
				vertex_output_7.y = vertex_unnamed_175 * vertex_unnamed_151;
				vertex_output_7.z = vertex_unnamed_175 * vertex_unnamed_166;
				float vertex_unnamed_210 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_211 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_212 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_217 = rsqrt(max(dot(float3(vertex_unnamed_210, vertex_unnamed_211, vertex_unnamed_212), float3(vertex_unnamed_210, vertex_unnamed_211, vertex_unnamed_212)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_217 * vertex_unnamed_210;
				vertex_output_3.y = vertex_unnamed_217 * vertex_unnamed_211;
				vertex_output_3.z = vertex_unnamed_217 * vertex_unnamed_212;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_121, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_121, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_121, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_121, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_121, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_121, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_121, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_325 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_338 = vertex_unnamed_325 ? vertex_input_5.x : vertex_input_0.x;
					float vertex_unnamed_339 = vertex_unnamed_325 ? vertex_input_5.y : vertex_input_0.y;
					float vertex_unnamed_340 = vertex_unnamed_325 ? vertex_input_5.z : vertex_input_0.z;
					float vertex_unnamed_374 = asfloat(1065353216u);
					float vertex_unnamed_375 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_338, vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_374));
					float vertex_unnamed_393 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_338, vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_374));
					float vertex_unnamed_411 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_338, vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_374));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_411, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_375, vertex_unnamed_393 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_411, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_375, vertex_unnamed_393 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_411, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_375, vertex_unnamed_393 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
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
				vertex_output_6.x = vertex_unnamed_85;
				vertex_output_6.y = vertex_unnamed_103;
				vertex_output_6.z = vertex_unnamed_121;
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
				return stage_output;
			}
			#endif
			#if (!defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
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
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float3 fragment_input_6 : INTERP3; // INTERP_3
				float3 fragment_input_7 : INTERP4; // INTERP_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_54 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_55 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_105 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_105 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_54) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_54)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_105 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_55) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_55)))) * (-0.5f));
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
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif
			#if (defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)) && defined(SHADER_STAGE_FRAGMENT)
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
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static float4 fragment_output_0;
			static float4 fragment_output_1;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float3 fragment_input_6 : INTERP3; // INTERP_3
				float3 fragment_input_7 : INTERP4; // INTERP_4
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
				float fragment_unnamed_55 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_56 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_106 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_106 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_55) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_55)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_106 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_56) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_56)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_134 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_142 = fragment_unnamed_134 * fragment_input_7.x;
				float fragment_unnamed_143 = fragment_unnamed_134 * fragment_input_7.y;
				float fragment_unnamed_144 = fragment_unnamed_134 * fragment_input_7.z;
				float fragment_unnamed_153 = 1.0f / max(dot(float3(abs(fragment_unnamed_142), abs(fragment_unnamed_143), abs(fragment_unnamed_144)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_158 = clamp((-0.0f) - (fragment_unnamed_153 * fragment_unnamed_144), 0.0f, 1.0f);
				float fragment_unnamed_161 = (-0.0f) - fragment_unnamed_158;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_142, fragment_unnamed_153, ((fragment_unnamed_153 * fragment_unnamed_142) >= 0.0f) ? fragment_unnamed_158 : fragment_unnamed_161), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_143, fragment_unnamed_153, ((fragment_unnamed_153 * fragment_unnamed_143) >= 0.0f) ? fragment_unnamed_158 : fragment_unnamed_161), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_181 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_181, min((8u & 31u), (32u - fragment_unnamed_181)))) * 0.0039215688593685626983642578125f;
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
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float3 vertex_input_5;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
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
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // COLOR
				float3 vertex_input_5 : TEXCOORD4; // TEXCOORD_4
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_0 : TEXCOORD8; // TEXCOORD_8
				float3 vertex_output_1 : TEXCOORD9; // TEXCOORD_9
				float4 vertex_output_3 : INTERP; // INTERP
				float4 vertex_output_4 : INTERP1; // INTERP_1
				float4 vertex_output_5 : INTERP2; // INTERP_2
				float3 vertex_output_6 : INTERP3; // INTERP_3
				float3 vertex_output_7 : INTERP4; // INTERP_4
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_83 = asfloat(1065353216u);
				float vertex_unnamed_85 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_83));
				float vertex_unnamed_103 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_83));
				float vertex_unnamed_121 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_83));
				float vertex_unnamed_136 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_151 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_166 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_175 = rsqrt(max(dot(float3(vertex_unnamed_136, vertex_unnamed_151, vertex_unnamed_166), float3(vertex_unnamed_136, vertex_unnamed_151, vertex_unnamed_166)), 1.1754943508222875079687365372222e-38f));
				vertex_output_7.x = vertex_unnamed_175 * vertex_unnamed_136;
				vertex_output_7.y = vertex_unnamed_175 * vertex_unnamed_151;
				vertex_output_7.z = vertex_unnamed_175 * vertex_unnamed_166;
				float vertex_unnamed_210 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_211 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_212 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_217 = rsqrt(max(dot(float3(vertex_unnamed_210, vertex_unnamed_211, vertex_unnamed_212), float3(vertex_unnamed_210, vertex_unnamed_211, vertex_unnamed_212)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_217 * vertex_unnamed_210;
				vertex_output_3.y = vertex_unnamed_217 * vertex_unnamed_211;
				vertex_output_3.z = vertex_unnamed_217 * vertex_unnamed_212;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_121, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_121, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_121, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_121, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_121, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_121, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_121, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_85, vertex_unnamed_103 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_325 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_338 = vertex_unnamed_325 ? vertex_input_5.x : vertex_input_0.x;
					float vertex_unnamed_339 = vertex_unnamed_325 ? vertex_input_5.y : vertex_input_0.y;
					float vertex_unnamed_340 = vertex_unnamed_325 ? vertex_input_5.z : vertex_input_0.z;
					float vertex_unnamed_374 = asfloat(1065353216u);
					float vertex_unnamed_375 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_338, vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_374));
					float vertex_unnamed_393 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_338, vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_374));
					float vertex_unnamed_411 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_338, vertex_unnamed_339, vertex_unnamed_340, vertex_unnamed_374));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_411, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_375, vertex_unnamed_393 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_411, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_375, vertex_unnamed_393 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_411, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_375, vertex_unnamed_393 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
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
				vertex_output_6.x = vertex_unnamed_85;
				vertex_output_6.y = vertex_unnamed_103;
				vertex_output_6.z = vertex_unnamed_121;
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
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_0 : TEXCOORD8; // TEXCOORD_8
				float3 fragment_input_1 : TEXCOORD9; // TEXCOORD_9
				float4 fragment_input_3 : INTERP; // INTERP
				float4 fragment_input_4 : INTERP1; // INTERP_1
				float4 fragment_input_5 : INTERP2; // INTERP_2
				float3 fragment_input_6 : INTERP3; // INTERP_3
				float3 fragment_input_7 : INTERP4; // INTERP_4
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_54 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_55 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_105 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_105 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_54) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_54)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_105 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_55) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_55)))) * (-0.5f));
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
			GpuProgramID 367970

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
			float _Smoothness;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			static float4 fragment_uniform_buffer_2[2];
			Texture2D<float4> _NormalMap;
			SamplerState sampler_NormalMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_61 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_119 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float4 fragment_unnamed_134 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_141 = mad(fragment_unnamed_134.x * fragment_unnamed_134.w, 2.0f, -1.0f);
				float fragment_unnamed_144 = mad(fragment_unnamed_134.y, 2.0f, -1.0f);
				float fragment_unnamed_176 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_141, fragment_unnamed_144), float2(fragment_unnamed_141, fragment_unnamed_144)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_178 = mad(fragment_unnamed_176, fragment_unnamed_119 * fragment_input_4.x, mad(fragment_unnamed_141, fragment_unnamed_119 * fragment_input_1.x, (fragment_unnamed_119 * (fragment_unnamed_61 * mad(fragment_input_4.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_4.z)))) * fragment_unnamed_144));
				float fragment_unnamed_179 = mad(fragment_unnamed_176, fragment_unnamed_119 * fragment_input_4.y, mad(fragment_unnamed_141, fragment_unnamed_119 * fragment_input_1.y, (fragment_unnamed_119 * (fragment_unnamed_61 * mad(fragment_input_4.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_4.x)))) * fragment_unnamed_144));
				float fragment_unnamed_180 = mad(fragment_unnamed_176, fragment_unnamed_119 * fragment_input_4.z, mad(fragment_unnamed_141, fragment_unnamed_119 * fragment_input_1.z, (fragment_unnamed_119 * (fragment_unnamed_61 * mad(fragment_input_4.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_4.y)))) * fragment_unnamed_144));
				float fragment_unnamed_185 = rsqrt(max(dot(float3(fragment_unnamed_178, fragment_unnamed_179, fragment_unnamed_180), float3(fragment_unnamed_178, fragment_unnamed_179, fragment_unnamed_180)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_186 = fragment_unnamed_185 * fragment_unnamed_178;
				float fragment_unnamed_187 = fragment_unnamed_185 * fragment_unnamed_179;
				float fragment_unnamed_188 = fragment_unnamed_185 * fragment_unnamed_180;
				float fragment_unnamed_190 = max(abs(fragment_unnamed_188), 0.0009765625f);
				float fragment_unnamed_194 = (fragment_unnamed_188 >= 0.0f) ? fragment_unnamed_190 : ((-0.0f) - fragment_unnamed_190);
				float fragment_unnamed_203 = 1.0f / max(dot(float3(abs(fragment_unnamed_186), abs(fragment_unnamed_187), abs(fragment_unnamed_194)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_208 = clamp((-0.0f) - (fragment_unnamed_203 * fragment_unnamed_194), 0.0f, 1.0f);
				float fragment_unnamed_211 = (-0.0f) - fragment_unnamed_208;
				uint fragment_unnamed_224 = uint(clamp(mad(mad(fragment_unnamed_186, fragment_unnamed_203, ((fragment_unnamed_203 * fragment_unnamed_186) >= 0.0f) ? fragment_unnamed_208 : fragment_unnamed_211), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_225 = uint(clamp(mad(mad(fragment_unnamed_187, fragment_unnamed_203, ((fragment_unnamed_203 * fragment_unnamed_187) >= 0.0f) ? fragment_unnamed_208 : fragment_unnamed_211), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_0.x = float(fragment_unnamed_224 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(fragment_unnamed_225 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_0.z = float(((fragment_unnamed_225 >> 8u) * 16u) + (fragment_unnamed_224 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_0.w = ((-0.0f) - fragment_uniform_buffer_2[1u].x) + 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[1] = float4(_Smoothness, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			static float4 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float3 vertex_output_4;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // COLOR
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_79 = asfloat(1065353216u);
				float vertex_unnamed_81 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_110 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				float vertex_unnamed_140 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_79));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_140, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_110, vertex_unnamed_81 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_140, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_110, vertex_unnamed_81 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_140, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_110, vertex_unnamed_81 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_140, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_110, vertex_unnamed_81 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_197 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_198 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_199 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_205 = rsqrt(max(dot(float3(vertex_unnamed_197, vertex_unnamed_198, vertex_unnamed_199), float3(vertex_unnamed_197, vertex_unnamed_198, vertex_unnamed_199)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_205 * vertex_unnamed_197;
				vertex_output_1.y = vertex_unnamed_205 * vertex_unnamed_198;
				vertex_output_1.z = vertex_unnamed_205 * vertex_unnamed_199;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				vertex_output_3.x = vertex_input_4.x;
				vertex_output_3.y = vertex_input_4.y;
				vertex_output_3.z = vertex_input_4.z;
				vertex_output_3.w = vertex_input_4.w;
				float vertex_unnamed_251 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_266 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_281 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_288 = rsqrt(max(dot(float3(vertex_unnamed_251, vertex_unnamed_266, vertex_unnamed_281), float3(vertex_unnamed_251, vertex_unnamed_266, vertex_unnamed_281)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_288 * vertex_unnamed_251;
				vertex_output_4.y = vertex_unnamed_288 * vertex_unnamed_266;
				vertex_output_4.z = vertex_unnamed_288 * vertex_unnamed_281;
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}
			#endif
			#if (defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			float _GlobalMipBias;
			float4 unity_WorldTransformParams;
			float _Smoothness;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			static float4 fragment_uniform_buffer_2[2];
			Texture2D<float4> _NormalMap;
			SamplerState sampler_NormalMap;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_61 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_119 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float4 fragment_unnamed_134 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_141 = mad(fragment_unnamed_134.x * fragment_unnamed_134.w, 2.0f, -1.0f);
				float fragment_unnamed_144 = mad(fragment_unnamed_134.y, 2.0f, -1.0f);
				float fragment_unnamed_176 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_141, fragment_unnamed_144), float2(fragment_unnamed_141, fragment_unnamed_144)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_178 = mad(fragment_unnamed_176, fragment_unnamed_119 * fragment_input_4.x, mad(fragment_unnamed_141, fragment_unnamed_119 * fragment_input_1.x, (fragment_unnamed_119 * (fragment_unnamed_61 * mad(fragment_input_4.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_4.z)))) * fragment_unnamed_144));
				float fragment_unnamed_179 = mad(fragment_unnamed_176, fragment_unnamed_119 * fragment_input_4.y, mad(fragment_unnamed_141, fragment_unnamed_119 * fragment_input_1.y, (fragment_unnamed_119 * (fragment_unnamed_61 * mad(fragment_input_4.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_4.x)))) * fragment_unnamed_144));
				float fragment_unnamed_180 = mad(fragment_unnamed_176, fragment_unnamed_119 * fragment_input_4.z, mad(fragment_unnamed_141, fragment_unnamed_119 * fragment_input_1.z, (fragment_unnamed_119 * (fragment_unnamed_61 * mad(fragment_input_4.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_4.y)))) * fragment_unnamed_144));
				float fragment_unnamed_185 = rsqrt(max(dot(float3(fragment_unnamed_178, fragment_unnamed_179, fragment_unnamed_180), float3(fragment_unnamed_178, fragment_unnamed_179, fragment_unnamed_180)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_186 = fragment_unnamed_185 * fragment_unnamed_178;
				float fragment_unnamed_187 = fragment_unnamed_185 * fragment_unnamed_179;
				float fragment_unnamed_188 = fragment_unnamed_185 * fragment_unnamed_180;
				float fragment_unnamed_190 = max(abs(fragment_unnamed_188), 0.0009765625f);
				float fragment_unnamed_194 = (fragment_unnamed_188 >= 0.0f) ? fragment_unnamed_190 : ((-0.0f) - fragment_unnamed_190);
				float fragment_unnamed_203 = 1.0f / max(dot(float3(abs(fragment_unnamed_186), abs(fragment_unnamed_187), abs(fragment_unnamed_194)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_208 = clamp((-0.0f) - (fragment_unnamed_203 * fragment_unnamed_194), 0.0f, 1.0f);
				float fragment_unnamed_211 = (-0.0f) - fragment_unnamed_208;
				uint fragment_unnamed_224 = uint(clamp(mad(mad(fragment_unnamed_186, fragment_unnamed_203, ((fragment_unnamed_203 * fragment_unnamed_186) >= 0.0f) ? fragment_unnamed_208 : fragment_unnamed_211), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_225 = uint(clamp(mad(mad(fragment_unnamed_187, fragment_unnamed_203, ((fragment_unnamed_203 * fragment_unnamed_187) >= 0.0f) ? fragment_unnamed_208 : fragment_unnamed_211), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_0.x = float(fragment_unnamed_224 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(fragment_unnamed_225 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_0.z = float(((fragment_unnamed_225 >> 8u) * 16u) + (fragment_unnamed_224 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_0.w = ((-0.0f) - fragment_uniform_buffer_2[1u].x) + 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[1] = float4(_Smoothness, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			GpuProgramID 475854

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
			static float4 vertex_uniform_buffer_2[13];
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
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // COLOR
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
				if ((((0.0f < vertex_uniform_buffer_2[12u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _RayTracing, vertex_uniform_buffer_2[12][3]);

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
			#if (!defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
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
			#if (defined(WRITE_DECAL_BUFFER) && defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
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
			#if (defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
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
			#if (defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float4 unity_RenderingLayer;

			static float4 fragment_uniform_buffer_0[11];
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				float3 fragment_input_5 : INTERP4; // INTERP_4
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
				float fragment_unnamed_47 = 1.0f / max(sqrt(dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_55 = fragment_unnamed_47 * fragment_input_5.x;
				float fragment_unnamed_56 = fragment_unnamed_47 * fragment_input_5.y;
				float fragment_unnamed_57 = fragment_unnamed_47 * fragment_input_5.z;
				float fragment_unnamed_66 = 1.0f / max(dot(float3(abs(fragment_unnamed_55), abs(fragment_unnamed_56), abs(fragment_unnamed_57)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_73 = clamp((-0.0f) - (fragment_unnamed_66 * fragment_unnamed_57), 0.0f, 1.0f);
				float fragment_unnamed_77 = (-0.0f) - fragment_unnamed_73;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_55, fragment_unnamed_66, ((fragment_unnamed_66 * fragment_unnamed_55) >= 0.0f) ? fragment_unnamed_73 : fragment_unnamed_77), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_56, fragment_unnamed_66, ((fragment_unnamed_66 * fragment_unnamed_56) >= 0.0f) ? fragment_unnamed_73 : fragment_unnamed_77), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_101 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_0[10u]).x, fragment_unnamed_101, min((8u & 31u), (32u - fragment_unnamed_101)))) * 0.0039215688593685626983642578125f;
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
			static float4 vertex_uniform_buffer_2[13];
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
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // COLOR
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
				if ((((0.0f < vertex_uniform_buffer_2[12u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _RayTracing, vertex_uniform_buffer_2[12][3]);

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
			#if defined(SHADER_STAGE_FRAGMENT) && !defined(RIP_HAS_FRAG)
			#define RIP_HAS_FRAG


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static float3 fragment_input_5;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
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
			GpuProgramID 563558

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ DECALS_3RT


			#if (!defined(DECALS_3RT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[13];
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
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD1; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD2; // COLOR
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
				if ((((0.0f < vertex_uniform_buffer_2[12u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _RayTracing, vertex_uniform_buffer_2[12][3]);

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
			#if (defined(DECALS_3RT)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float2 _GlobalFogDistance;
			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4x4 _ViewProjMatrix;
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
			float _Smoothness;
			float _Metallic;
			float4 _Emission;
			float _Bloom;

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[214];
			static float4 fragment_uniform_buffer_2[29];
			static float4 fragment_uniform_buffer_3[5];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> Texture2D_23DD87FD;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState samplerTexture2D_23DD87FD;
			SamplerState sampler_NormalMap;

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
				float fragment_unnamed_98 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_118 = asfloat((fragment_uniform_buffer_2[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_181 = fragment_uniform_buffer_1[15u].w == 0.0f;
				float fragment_unnamed_207 = asfloat(fragment_unnamed_181 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_1[11u].x) : asuint(fragment_uniform_buffer_1[0u]).z);
				float fragment_unnamed_214 = asfloat(fragment_unnamed_181 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_1[11u].y) : asuint(fragment_uniform_buffer_1[1u]).z);
				float fragment_unnamed_221 = asfloat(fragment_unnamed_181 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_1[11u].z) : asuint(fragment_uniform_buffer_1[2u]).z);
				float fragment_unnamed_225 = rsqrt(dot(float3(fragment_unnamed_207, fragment_unnamed_214, fragment_unnamed_221), float3(fragment_unnamed_207, fragment_unnamed_214, fragment_unnamed_221)));
				float4 fragment_unnamed_265 = Texture2D_23DD87FD.SampleBias(samplerTexture2D_23DD87FD, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_1[86u].y);
				float fragment_unnamed_277 = fragment_unnamed_265.x * fragment_input_5.x;
				float fragment_unnamed_278 = fragment_unnamed_265.y * fragment_input_5.y;
				float fragment_unnamed_279 = fragment_unnamed_265.z * fragment_input_5.z;
				float fragment_unnamed_308 = ((-0.0f) - clamp(((mad(fragment_uniform_buffer_1[22u].w, fragment_input_6.z, mad(fragment_uniform_buffer_1[20u].w, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[21u].w)) + fragment_uniform_buffer_1[23u].w) + ((-0.0f) - fragment_uniform_buffer_0[0u].x)) / (((-0.0f) - fragment_uniform_buffer_0[0u].x) + fragment_uniform_buffer_0[0u].y), 0.0f, 1.0f)) + 1.0f;
				float4 fragment_unnamed_320 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_1[86u].y);
				float fragment_unnamed_326 = mad(fragment_unnamed_320.x * fragment_unnamed_320.w, 2.0f, -1.0f);
				float fragment_unnamed_329 = mad(fragment_unnamed_320.y, 2.0f, -1.0f);
				float fragment_unnamed_337 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_326, fragment_unnamed_329), float2(fragment_unnamed_326, fragment_unnamed_329)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_345 = mad(fragment_unnamed_337, fragment_unnamed_98 * fragment_input_7.x, mad(fragment_unnamed_326, fragment_unnamed_98 * fragment_input_1.x, (fragment_unnamed_98 * (fragment_unnamed_118 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_329));
				float fragment_unnamed_346 = mad(fragment_unnamed_337, fragment_unnamed_98 * fragment_input_7.y, mad(fragment_unnamed_326, fragment_unnamed_98 * fragment_input_1.y, (fragment_unnamed_98 * (fragment_unnamed_118 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_329));
				float fragment_unnamed_347 = mad(fragment_unnamed_337, fragment_unnamed_98 * fragment_input_7.z, mad(fragment_unnamed_326, fragment_unnamed_98 * fragment_input_1.z, (fragment_unnamed_98 * (fragment_unnamed_118 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_329));
				float fragment_unnamed_352 = rsqrt(max(dot(float3(fragment_unnamed_345, fragment_unnamed_346, fragment_unnamed_347), float3(fragment_unnamed_345, fragment_unnamed_346, fragment_unnamed_347)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_353 = fragment_unnamed_352 * fragment_unnamed_345;
				float fragment_unnamed_354 = fragment_unnamed_352 * fragment_unnamed_346;
				float fragment_unnamed_355 = fragment_unnamed_352 * fragment_unnamed_347;
				float fragment_unnamed_425;
				float fragment_unnamed_426;
				float fragment_unnamed_427;
				float fragment_unnamed_428;
				float fragment_unnamed_429;
				float fragment_unnamed_430;
				float fragment_unnamed_431;
				if (asuint(fragment_uniform_buffer_1[210u]).z != 0u)
				{
					uint fragment_unnamed_366 = uint(gl_FragCoord.x);
					uint fragment_unnamed_367 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_368 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_366, fragment_unnamed_367, 0u), 0u));
					float fragment_unnamed_374 = fragment_unnamed_368.w;
					float4 fragment_unnamed_375 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_366, fragment_unnamed_367, 0u), 0u));
					float fragment_unnamed_380 = fragment_unnamed_375.w;
					float4 fragment_unnamed_381 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_366, fragment_unnamed_367, 0u), 0u));
					bool fragment_unnamed_389 = fragment_unnamed_380 < 1.0f;
					float fragment_unnamed_390 = mad(fragment_unnamed_353, fragment_unnamed_380, mad(fragment_unnamed_375.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_391 = mad(fragment_unnamed_354, fragment_unnamed_380, mad(fragment_unnamed_375.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_392 = mad(fragment_unnamed_355, fragment_unnamed_380, mad(fragment_unnamed_375.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_397 = rsqrt(max(dot(float3(fragment_unnamed_390, fragment_unnamed_391, fragment_unnamed_392), float3(fragment_unnamed_390, fragment_unnamed_391, fragment_unnamed_392)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_425 = mad(fragment_unnamed_277, fragment_unnamed_374, fragment_unnamed_368.x);
					fragment_unnamed_426 = mad(fragment_unnamed_278, fragment_unnamed_374, fragment_unnamed_368.y);
					fragment_unnamed_427 = mad(fragment_unnamed_279, fragment_unnamed_374, fragment_unnamed_368.z);
					fragment_unnamed_428 = mad(fragment_uniform_buffer_3[1u].x, fragment_unnamed_381.w, fragment_unnamed_381.z);
					fragment_unnamed_429 = asfloat(fragment_unnamed_389 ? asuint(fragment_unnamed_397 * fragment_unnamed_392) : asuint(fragment_unnamed_355));
					fragment_unnamed_430 = asfloat(fragment_unnamed_389 ? asuint(fragment_unnamed_397 * fragment_unnamed_391) : asuint(fragment_unnamed_354));
					fragment_unnamed_431 = asfloat(fragment_unnamed_389 ? asuint(fragment_unnamed_397 * fragment_unnamed_390) : asuint(fragment_unnamed_353));
				}
				else
				{
					fragment_unnamed_425 = fragment_unnamed_277;
					fragment_unnamed_426 = fragment_unnamed_278;
					fragment_unnamed_427 = fragment_unnamed_279;
					fragment_unnamed_428 = asfloat(asuint(fragment_uniform_buffer_3[1u]).x);
					fragment_unnamed_429 = fragment_unnamed_355;
					fragment_unnamed_430 = fragment_unnamed_354;
					fragment_unnamed_431 = fragment_unnamed_353;
				}
				uint4 fragment_unnamed_446 = asuint(fragment_uniform_buffer_1[213u]);
				uint fragment_unnamed_447 = fragment_unnamed_446.x;
				float fragment_unnamed_732;
				float fragment_unnamed_734;
				float fragment_unnamed_736;
				if ((((asuint(fragment_uniform_buffer_1[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_447 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_447 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_733;
					float fragment_unnamed_735;
					float fragment_unnamed_737;
					if (fragment_uniform_buffer_2[22u].x == 0.0f)
					{
						float fragment_unnamed_470 = asfloat(1065353216u);
						float fragment_unnamed_500 = fragment_unnamed_430 * fragment_unnamed_431;
						float fragment_unnamed_501 = fragment_unnamed_429 * fragment_unnamed_430;
						float fragment_unnamed_502 = fragment_unnamed_429 * fragment_unnamed_429;
						float fragment_unnamed_503 = fragment_unnamed_431 * fragment_unnamed_429;
						float fragment_unnamed_536 = mad(fragment_unnamed_431, fragment_unnamed_431, (-0.0f) - (fragment_unnamed_430 * fragment_unnamed_430));
						fragment_unnamed_733 = dot(float4(fragment_uniform_buffer_2[13u]), float4(fragment_unnamed_431, fragment_unnamed_430, fragment_unnamed_429, fragment_unnamed_470)) + mad(fragment_uniform_buffer_2[19u].x, fragment_unnamed_536, dot(float4(fragment_uniform_buffer_2[16u]), float4(fragment_unnamed_500, fragment_unnamed_501, fragment_unnamed_502, fragment_unnamed_503)));
						fragment_unnamed_735 = dot(float4(fragment_uniform_buffer_2[14u]), float4(fragment_unnamed_431, fragment_unnamed_430, fragment_unnamed_429, fragment_unnamed_470)) + mad(fragment_uniform_buffer_2[19u].y, fragment_unnamed_536, dot(float4(fragment_uniform_buffer_2[17u]), float4(fragment_unnamed_500, fragment_unnamed_501, fragment_unnamed_502, fragment_unnamed_503)));
						fragment_unnamed_737 = dot(float4(fragment_uniform_buffer_2[15u]), float4(fragment_unnamed_431, fragment_unnamed_430, fragment_unnamed_429, fragment_unnamed_470)) + mad(fragment_uniform_buffer_2[19u].z, fragment_unnamed_536, dot(float4(fragment_uniform_buffer_2[18u]), float4(fragment_unnamed_500, fragment_unnamed_501, fragment_unnamed_502, fragment_unnamed_503)));
					}
					else
					{
						bool fragment_unnamed_552 = fragment_uniform_buffer_2[22u].y == 0.0f;
						bool fragment_unnamed_553 = fragment_uniform_buffer_2[22u].y == 1.0f;
						float fragment_unnamed_575 = fragment_unnamed_552 ? (fragment_input_6.x + fragment_uniform_buffer_1[48u].x) : fragment_input_6.x;
						float fragment_unnamed_576 = fragment_unnamed_552 ? (fragment_input_6.y + fragment_uniform_buffer_1[48u].y) : fragment_input_6.y;
						float fragment_unnamed_577 = fragment_unnamed_552 ? (fragment_input_6.z + fragment_uniform_buffer_1[48u].z) : fragment_input_6.z;
						float fragment_unnamed_680 = (asfloat(fragment_unnamed_553 ? asuint((mad(fragment_uniform_buffer_2[25u].y, fragment_uniform_buffer_1[48u].z, mad(fragment_uniform_buffer_2[23u].y, fragment_uniform_buffer_1[48u].x, fragment_uniform_buffer_1[48u].y * fragment_uniform_buffer_2[24u].y)) + fragment_uniform_buffer_2[26u].y) + mad(fragment_uniform_buffer_2[25u].y, fragment_unnamed_577, mad(fragment_uniform_buffer_2[23u].y, fragment_unnamed_575, fragment_unnamed_576 * fragment_uniform_buffer_2[24u].y))) : asuint(fragment_unnamed_576)) + ((-0.0f) - fragment_uniform_buffer_2[28u].y)) * fragment_uniform_buffer_2[27u].y;
						float fragment_unnamed_681 = (asfloat(fragment_unnamed_553 ? asuint((mad(fragment_uniform_buffer_2[25u].z, fragment_uniform_buffer_1[48u].z, mad(fragment_uniform_buffer_2[23u].z, fragment_uniform_buffer_1[48u].x, fragment_uniform_buffer_1[48u].y * fragment_uniform_buffer_2[24u].z)) + fragment_uniform_buffer_2[26u].z) + mad(fragment_uniform_buffer_2[25u].z, fragment_unnamed_577, mad(fragment_uniform_buffer_2[23u].z, fragment_unnamed_575, fragment_unnamed_576 * fragment_uniform_buffer_2[24u].z))) : asuint(fragment_unnamed_577)) + ((-0.0f) - fragment_uniform_buffer_2[28u].z)) * fragment_uniform_buffer_2[27u].z;
						float fragment_unnamed_695 = min(mad((-0.0f) - fragment_uniform_buffer_2[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_2[22u].z * 0.5f, ((asfloat(fragment_unnamed_553 ? asuint((mad(fragment_uniform_buffer_2[25u].x, fragment_uniform_buffer_1[48u].z, mad(fragment_uniform_buffer_2[23u].x, fragment_uniform_buffer_1[48u].x, fragment_uniform_buffer_1[48u].y * fragment_uniform_buffer_2[24u].x)) + fragment_uniform_buffer_2[26u].x) + mad(fragment_uniform_buffer_2[25u].x, fragment_unnamed_577, mad(fragment_uniform_buffer_2[23u].x, fragment_unnamed_575, fragment_unnamed_576 * fragment_uniform_buffer_2[24u].x))) : asuint(fragment_unnamed_575)) + ((-0.0f) - fragment_uniform_buffer_2[28u].x)) * fragment_uniform_buffer_2[27u].x) * 0.25f));
						float fragment_unnamed_722 = asfloat(1065353216u);
						fragment_unnamed_733 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_695, fragment_unnamed_680, fragment_unnamed_681), 0.0f)), float4(fragment_unnamed_431, fragment_unnamed_430, fragment_unnamed_429, fragment_unnamed_722));
						fragment_unnamed_735 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_695 + 0.25f, fragment_unnamed_680 + 0.0f, fragment_unnamed_681 + 0.0f), 0.0f)), float4(fragment_unnamed_431, fragment_unnamed_430, fragment_unnamed_429, fragment_unnamed_722));
						fragment_unnamed_737 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_695 + 0.5f, fragment_unnamed_680 + 0.0f, fragment_unnamed_681 + 0.0f), 0.0f)), float4(fragment_unnamed_431, fragment_unnamed_430, fragment_unnamed_429, fragment_unnamed_722));
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
				float fragment_unnamed_739 = ((-0.0f) - fragment_unnamed_428) + 1.0f;
				float fragment_unnamed_744 = ((-0.0f) - fragment_uniform_buffer_3[1u].y) + 1.0f;
				float fragment_unnamed_745 = fragment_unnamed_744 * fragment_unnamed_425;
				float fragment_unnamed_746 = fragment_unnamed_744 * fragment_unnamed_426;
				float fragment_unnamed_747 = fragment_unnamed_744 * fragment_unnamed_427;
				float fragment_unnamed_755 = mad(fragment_uniform_buffer_3[1u].y, fragment_unnamed_425 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_757 = mad(fragment_uniform_buffer_3[1u].y, fragment_unnamed_426 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_758 = mad(fragment_uniform_buffer_3[1u].y, fragment_unnamed_427 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_773 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_431, fragment_unnamed_430, fragment_unnamed_429), float3(fragment_unnamed_225 * fragment_unnamed_207, fragment_unnamed_225 * fragment_unnamed_214, fragment_unnamed_225 * fragment_unnamed_221)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_739, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_785 = clamp((max(fragment_unnamed_758, max(fragment_unnamed_757, fragment_unnamed_755)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_1[118u].w;
				float fragment_unnamed_809 = asfloat((((asuint(fragment_uniform_buffer_1[120u]).y & asuint(fragment_uniform_buffer_2[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_1[120u]).x : 1065353216u);
				float fragment_unnamed_811 = max(abs(fragment_unnamed_429), 0.0009765625f);
				float fragment_unnamed_815 = (fragment_unnamed_429 >= 0.0f) ? fragment_unnamed_811 : ((-0.0f) - fragment_unnamed_811);
				float fragment_unnamed_824 = 1.0f / max(dot(float3(abs(fragment_unnamed_431), abs(fragment_unnamed_430), abs(fragment_unnamed_815)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_829 = clamp((-0.0f) - (fragment_unnamed_815 * fragment_unnamed_824), 0.0f, 1.0f);
				float fragment_unnamed_832 = (-0.0f) - fragment_unnamed_829;
				uint fragment_unnamed_844 = uint(clamp(mad(mad(fragment_unnamed_431, fragment_unnamed_824, ((fragment_unnamed_431 * fragment_unnamed_824) >= 0.0f) ? fragment_unnamed_829 : fragment_unnamed_832), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_845 = uint(clamp(mad(mad(fragment_unnamed_430, fragment_unnamed_824, ((fragment_unnamed_430 * fragment_unnamed_824) >= 0.0f) ? fragment_unnamed_829 : fragment_unnamed_832), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_844 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_845 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_845 >> 8u) * 16u) + (fragment_unnamed_844 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_755)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_757)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_758)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_899 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_1[118u].y;
				float fragment_unnamed_900 = fragment_unnamed_899 * mad(fragment_unnamed_732 * (fragment_unnamed_773 * mad(fragment_unnamed_785, mad((-0.0f) - fragment_unnamed_425, fragment_unnamed_744, fragment_unnamed_755), fragment_unnamed_745)), fragment_unnamed_809, (fragment_uniform_buffer_3[2u].x * fragment_uniform_buffer_3[4u].x) * fragment_unnamed_308);
				float fragment_unnamed_901 = fragment_unnamed_899 * mad(fragment_unnamed_734 * (fragment_unnamed_773 * mad(fragment_unnamed_785, mad((-0.0f) - fragment_unnamed_426, fragment_unnamed_744, fragment_unnamed_757), fragment_unnamed_746)), fragment_unnamed_809, (fragment_uniform_buffer_3[2u].y * fragment_uniform_buffer_3[4u].x) * fragment_unnamed_308);
				float fragment_unnamed_902 = fragment_unnamed_899 * mad(fragment_unnamed_736 * (fragment_unnamed_773 * mad(fragment_unnamed_785, mad((-0.0f) - fragment_unnamed_427, fragment_unnamed_744, fragment_unnamed_758), fragment_unnamed_747)), fragment_unnamed_809, (fragment_uniform_buffer_3[2u].z * fragment_uniform_buffer_3[4u].x) * fragment_unnamed_308);
				bool fragment_unnamed_911 = (((fragment_unnamed_902 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_901 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_900 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_911 ? 2048.0f : fragment_unnamed_900;
				fragment_output_3.y = fragment_unnamed_911 ? 1.0f : fragment_unnamed_901;
				fragment_output_3.z = fragment_unnamed_911 ? 1024.0f : fragment_unnamed_902;
				fragment_output_0.x = fragment_unnamed_745;
				fragment_output_0.y = fragment_unnamed_746;
				fragment_output_0.z = fragment_unnamed_747;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_unnamed_739;
				fragment_output_2.w = 0.0f;
				fragment_output_3.w = 0.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_GlobalFogDistance[0], _GlobalFogDistance[1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				fragment_uniform_buffer_1[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				fragment_uniform_buffer_1[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				fragment_uniform_buffer_1[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				fragment_uniform_buffer_1[8] = float4(_InvViewMatrix[0][0], _InvViewMatrix[1][0], _InvViewMatrix[2][0], _InvViewMatrix[3][0]);
				fragment_uniform_buffer_1[9] = float4(_InvViewMatrix[0][1], _InvViewMatrix[1][1], _InvViewMatrix[2][1], _InvViewMatrix[3][1]);
				fragment_uniform_buffer_1[10] = float4(_InvViewMatrix[0][2], _InvViewMatrix[1][2], _InvViewMatrix[2][2], _InvViewMatrix[3][2]);
				fragment_uniform_buffer_1[11] = float4(_InvViewMatrix[0][3], _InvViewMatrix[1][3], _InvViewMatrix[2][3], _InvViewMatrix[3][3]);

				fragment_uniform_buffer_1[12] = float4(_ProjMatrix[0][0], _ProjMatrix[1][0], _ProjMatrix[2][0], _ProjMatrix[3][0]);
				fragment_uniform_buffer_1[13] = float4(_ProjMatrix[0][1], _ProjMatrix[1][1], _ProjMatrix[2][1], _ProjMatrix[3][1]);
				fragment_uniform_buffer_1[14] = float4(_ProjMatrix[0][2], _ProjMatrix[1][2], _ProjMatrix[2][2], _ProjMatrix[3][2]);
				fragment_uniform_buffer_1[15] = float4(_ProjMatrix[0][3], _ProjMatrix[1][3], _ProjMatrix[2][3], _ProjMatrix[3][3]);

				fragment_uniform_buffer_1[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				fragment_uniform_buffer_1[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				fragment_uniform_buffer_1[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				fragment_uniform_buffer_1[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				fragment_uniform_buffer_1[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_1[86] = float4(fragment_uniform_buffer_1[86][0], _GlobalMipBias, fragment_uniform_buffer_1[86][2], fragment_uniform_buffer_1[86][3]);

				fragment_uniform_buffer_1[113] = float4(fragment_uniform_buffer_1[113][0], fragment_uniform_buffer_1[113][1], fragment_uniform_buffer_1[113][2], asfloat(_ReflectionsMode));

				fragment_uniform_buffer_1[118] = float4(fragment_uniform_buffer_1[118][0], _ProbeExposureScale, fragment_uniform_buffer_1[118][2], fragment_uniform_buffer_1[118][3]);

				fragment_uniform_buffer_1[118] = float4(fragment_uniform_buffer_1[118][0], fragment_uniform_buffer_1[118][1], fragment_uniform_buffer_1[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_1[120] = float4(_IndirectDiffuseLightingMultiplier, fragment_uniform_buffer_1[120][1], fragment_uniform_buffer_1[120][2], fragment_uniform_buffer_1[120][3]);

				fragment_uniform_buffer_1[120] = float4(fragment_uniform_buffer_1[120][0], asfloat(_IndirectDiffuseLightingLayers), fragment_uniform_buffer_1[120][2], fragment_uniform_buffer_1[120][3]);

				fragment_uniform_buffer_1[210] = float4(fragment_uniform_buffer_1[210][0], fragment_uniform_buffer_1[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_1[210][3]);

				fragment_uniform_buffer_1[213] = float4(asfloat(_IndirectDiffuseMode), fragment_uniform_buffer_1[213][1], fragment_uniform_buffer_1[213][2], fragment_uniform_buffer_1[213][3]);

				fragment_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[13] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[14] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[15] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[16] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				fragment_uniform_buffer_2[17] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				fragment_uniform_buffer_2[18] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				fragment_uniform_buffer_2[19] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				fragment_uniform_buffer_2[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_2[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_2[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_2[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_2[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_2[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_2[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_3[1] = float4(_Smoothness, fragment_uniform_buffer_3[1][1], fragment_uniform_buffer_3[1][2], fragment_uniform_buffer_3[1][3]);

				fragment_uniform_buffer_3[1] = float4(fragment_uniform_buffer_3[1][0], _Metallic, fragment_uniform_buffer_3[1][2], fragment_uniform_buffer_3[1][3]);

				fragment_uniform_buffer_3[2] = float4(_Emission[0], _Emission[1], _Emission[2], _Emission[3]);

				fragment_uniform_buffer_3[4] = float4(_Bloom, fragment_uniform_buffer_3[4][1], fragment_uniform_buffer_3[4][2], fragment_uniform_buffer_3[4][3]);

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
			static float4 vertex_uniform_buffer_2[13];
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
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD1; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD2; // COLOR
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
				if ((((0.0f < vertex_uniform_buffer_2[12u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _RayTracing, vertex_uniform_buffer_2[12][3]);

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
			GpuProgramID 644249

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
			#pragma shader_feature _DISABLE_SSR_TRANSPARENT
			#pragma shader_feature _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT


			#if (defined(AREA_SHADOW_MEDIUM) && defined(DECALS_3RT) && defined(DIRECTIONAL_SHADOW_MEDIUM) && defined(PUNCTUAL_SHADOW_MEDIUM) && defined(SCREEN_SPACE_SHADOWS_OFF) && defined(USE_CLUSTERED_LIGHTLIST) && defined(_DISABLE_DECALS) && defined(_DISABLE_SSR_TRANSPARENT) && defined(_ENABLE_FOG_ON_TRANSPARENT) && defined(_SURFACE_TYPE_TRANSPARENT)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float2 _GlobalFogDistance;
			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4x4 _ViewProjMatrix;
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
			float _Smoothness;
			float _Metallic;
			float4 _Emission;
			float _Bloom;
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

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[219];
			static float4 fragment_uniform_buffer_2[29];
			static float4 fragment_uniform_buffer_3[208];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[13];
			static const float fragment_unnamed_105[16] = { 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };

			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Buffer<uint4> T2;
			Buffer<uint4> T3;
			Buffer<uint4> T4;
			Buffer<uint4> T5;
			Buffer<uint4> T6;
			Buffer<uint4> T7;
			Texture2D<float4> _CookieAtlas;
			Texture2DArray<float4> _ReflectionAtlas;
			Texture2D<float4> _VolumetricCloudsShadowsTexture;
			TextureCubeArray<float4> _SkyTexture;
			Texture2D<float4> Texture2D_23DD87FD;
			Texture2D<float4> _NormalMap;
			Texture3D<float4> _AtmosphericScatteringLUT;
			Texture2DArray<uint4> _StencilTexture;
			Texture2DArray<float4> _RefractiveDepthBuffer;
			Buffer<uint4> T17;
			Buffer<uint4> T18;
			Texture2DArray<float4> _WaterGBufferTexture3;
			Buffer<uint4> T20;
			Texture3D<float4> _VBufferLighting;
			Texture2D<float4> _ShadowmapAtlas;
			Texture2D<float4> _CachedShadowmapAtlas;
			Texture2D<float4> _ShadowmapCascadeAtlas;
			Texture2D<float4> _ShadowmapAreaAtlas;
			Texture2D<float4> _CachedAreaLightShadowmapAtlas;
			Buffer<uint4> T27;
			Buffer<uint4> T28;
			Texture2DArray<float4> _LtcData;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			SamplerState S0;
			SamplerState S1;
			SamplerComparisonState S2;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState samplerTexture2D_23DD87FD;
			SamplerState sampler_NormalMap;

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
				float fragment_unnamed_167 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_185 = asfloat((fragment_uniform_buffer_2[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_241 = fragment_unnamed_167 * fragment_input_7.x;
				float fragment_unnamed_242 = fragment_unnamed_167 * fragment_input_7.y;
				float fragment_unnamed_243 = fragment_unnamed_167 * fragment_input_7.z;
				bool fragment_unnamed_250 = 0u < asuint(fragment_uniform_buffer_1[211u]).y;
				float fragment_unnamed_270 = fragment_unnamed_250 ? float(uint(round(gl_FragCoord.x * fragment_uniform_buffer_1[211u].x))) : gl_FragCoord.x;
				float fragment_unnamed_271 = fragment_unnamed_250 ? float(uint(round(gl_FragCoord.y * fragment_uniform_buffer_1[211u].x))) : gl_FragCoord.y;
				uint fragment_unnamed_272 = uint(fragment_unnamed_270);
				uint fragment_unnamed_273 = uint(fragment_unnamed_271);
				uint fragment_unnamed_274 = fragment_unnamed_272 >> 5u;
				uint fragment_unnamed_276 = fragment_unnamed_273 >> 5u;
				float fragment_unnamed_282 = fragment_unnamed_270 * fragment_uniform_buffer_1[50u].z;
				float fragment_unnamed_283 = fragment_unnamed_271 * fragment_uniform_buffer_1[50u].w;
				bool fragment_unnamed_288 = fragment_uniform_buffer_1[15u].w == 0.0f;
				uint4 fragment_unnamed_309 = asuint(fragment_uniform_buffer_1[0u]);
				uint fragment_unnamed_310 = fragment_unnamed_309.z;
				uint4 fragment_unnamed_314 = asuint(fragment_uniform_buffer_1[1u]);
				uint fragment_unnamed_315 = fragment_unnamed_314.z;
				uint4 fragment_unnamed_319 = asuint(fragment_uniform_buffer_1[2u]);
				uint fragment_unnamed_320 = fragment_unnamed_319.z;
				float fragment_unnamed_326 = asfloat(fragment_unnamed_288 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_1[11u].x) : fragment_unnamed_310);
				float fragment_unnamed_328 = asfloat(fragment_unnamed_288 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_1[11u].y) : fragment_unnamed_315);
				float fragment_unnamed_330 = asfloat(fragment_unnamed_288 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_1[11u].z) : fragment_unnamed_320);
				float fragment_unnamed_334 = rsqrt(dot(float3(fragment_unnamed_326, fragment_unnamed_328, fragment_unnamed_330), float3(fragment_unnamed_326, fragment_unnamed_328, fragment_unnamed_330)));
				float fragment_unnamed_335 = fragment_unnamed_334 * fragment_unnamed_326;
				float fragment_unnamed_336 = fragment_unnamed_334 * fragment_unnamed_328;
				float fragment_unnamed_337 = fragment_unnamed_334 * fragment_unnamed_330;
				float4 fragment_unnamed_374 = Texture2D_23DD87FD.SampleBias(samplerTexture2D_23DD87FD, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_1[86u].y);
				float fragment_unnamed_377 = fragment_unnamed_374.x;
				float fragment_unnamed_378 = fragment_unnamed_374.y;
				float fragment_unnamed_379 = fragment_unnamed_374.z;
				float fragment_unnamed_380 = fragment_unnamed_374.w;
				float fragment_unnamed_387 = fragment_unnamed_377 * fragment_input_5.x;
				float fragment_unnamed_388 = fragment_unnamed_378 * fragment_input_5.y;
				float fragment_unnamed_389 = fragment_unnamed_379 * fragment_input_5.z;
				float fragment_unnamed_419 = ((-0.0f) - clamp(((mad(fragment_uniform_buffer_1[22u].w, fragment_input_6.z, mad(fragment_uniform_buffer_1[20u].w, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[21u].w)) + fragment_uniform_buffer_1[23u].w) + ((-0.0f) - fragment_uniform_buffer_0[0u].x)) / (((-0.0f) - fragment_uniform_buffer_0[0u].x) + fragment_uniform_buffer_0[0u].y), 0.0f, 1.0f)) + 1.0f;
				float fragment_unnamed_422 = (fragment_unnamed_380 * fragment_unnamed_380) * fragment_input_5.w;
				float4 fragment_unnamed_431 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_1[86u].y);
				float fragment_unnamed_437 = mad(fragment_unnamed_431.x * fragment_unnamed_431.w, 2.0f, -1.0f);
				float fragment_unnamed_440 = mad(fragment_unnamed_431.y, 2.0f, -1.0f);
				float fragment_unnamed_448 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_437, fragment_unnamed_440), float2(fragment_unnamed_437, fragment_unnamed_440)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_456 = mad(fragment_unnamed_448, fragment_unnamed_241, mad(fragment_unnamed_437, fragment_unnamed_167 * fragment_input_1.x, (fragment_unnamed_167 * (fragment_unnamed_185 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_440));
				float fragment_unnamed_457 = mad(fragment_unnamed_448, fragment_unnamed_242, mad(fragment_unnamed_437, fragment_unnamed_167 * fragment_input_1.y, (fragment_unnamed_167 * (fragment_unnamed_185 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_440));
				float fragment_unnamed_458 = mad(fragment_unnamed_448, fragment_unnamed_243, mad(fragment_unnamed_437, fragment_unnamed_167 * fragment_input_1.z, (fragment_unnamed_167 * (fragment_unnamed_185 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_440));
				float fragment_unnamed_463 = rsqrt(max(dot(float3(fragment_unnamed_456, fragment_unnamed_457, fragment_unnamed_458), float3(fragment_unnamed_456, fragment_unnamed_457, fragment_unnamed_458)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_464 = fragment_unnamed_456 * fragment_unnamed_463;
				float fragment_unnamed_465 = fragment_unnamed_457 * fragment_unnamed_463;
				float fragment_unnamed_466 = fragment_unnamed_458 * fragment_unnamed_463;
				uint fragment_unnamed_472 = asuint(fragment_uniform_buffer_2[10u]).x & 65535u;
				float fragment_unnamed_738;
				float fragment_unnamed_739;
				float fragment_unnamed_740;
				if (fragment_uniform_buffer_2[22u].x == 0.0f)
				{
					float fragment_unnamed_478 = asfloat(1065353216u);
					float fragment_unnamed_507 = fragment_unnamed_465 * fragment_unnamed_464;
					float fragment_unnamed_508 = fragment_unnamed_466 * fragment_unnamed_465;
					float fragment_unnamed_509 = fragment_unnamed_466 * fragment_unnamed_466;
					float fragment_unnamed_510 = fragment_unnamed_464 * fragment_unnamed_466;
					float fragment_unnamed_542 = mad(fragment_unnamed_464, fragment_unnamed_464, (-0.0f) - (fragment_unnamed_465 * fragment_unnamed_465));
					fragment_unnamed_738 = dot(float4(fragment_uniform_buffer_2[13u]), float4(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466, fragment_unnamed_478)) + mad(fragment_uniform_buffer_2[19u].x, fragment_unnamed_542, dot(float4(fragment_uniform_buffer_2[16u]), float4(fragment_unnamed_507, fragment_unnamed_508, fragment_unnamed_509, fragment_unnamed_510)));
					fragment_unnamed_739 = dot(float4(fragment_uniform_buffer_2[14u]), float4(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466, fragment_unnamed_478)) + mad(fragment_uniform_buffer_2[19u].y, fragment_unnamed_542, dot(float4(fragment_uniform_buffer_2[17u]), float4(fragment_unnamed_507, fragment_unnamed_508, fragment_unnamed_509, fragment_unnamed_510)));
					fragment_unnamed_740 = dot(float4(fragment_uniform_buffer_2[15u]), float4(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466, fragment_unnamed_478)) + mad(fragment_uniform_buffer_2[19u].z, fragment_unnamed_542, dot(float4(fragment_uniform_buffer_2[18u]), float4(fragment_unnamed_507, fragment_unnamed_508, fragment_unnamed_509, fragment_unnamed_510)));
				}
				else
				{
					bool fragment_unnamed_558 = fragment_uniform_buffer_2[22u].y == 0.0f;
					bool fragment_unnamed_559 = fragment_uniform_buffer_2[22u].y == 1.0f;
					float fragment_unnamed_581 = fragment_unnamed_558 ? (fragment_input_6.x + fragment_uniform_buffer_1[48u].x) : fragment_input_6.x;
					float fragment_unnamed_582 = fragment_unnamed_558 ? (fragment_input_6.y + fragment_uniform_buffer_1[48u].y) : fragment_input_6.y;
					float fragment_unnamed_583 = fragment_unnamed_558 ? (fragment_input_6.z + fragment_uniform_buffer_1[48u].z) : fragment_input_6.z;
					float fragment_unnamed_686 = (asfloat(fragment_unnamed_559 ? asuint((mad(fragment_uniform_buffer_2[25u].y, fragment_uniform_buffer_1[48u].z, mad(fragment_uniform_buffer_2[23u].y, fragment_uniform_buffer_1[48u].x, fragment_uniform_buffer_1[48u].y * fragment_uniform_buffer_2[24u].y)) + fragment_uniform_buffer_2[26u].y) + mad(fragment_uniform_buffer_2[25u].y, fragment_unnamed_583, mad(fragment_uniform_buffer_2[23u].y, fragment_unnamed_581, fragment_unnamed_582 * fragment_uniform_buffer_2[24u].y))) : asuint(fragment_unnamed_582)) + ((-0.0f) - fragment_uniform_buffer_2[28u].y)) * fragment_uniform_buffer_2[27u].y;
					float fragment_unnamed_687 = (asfloat(fragment_unnamed_559 ? asuint((mad(fragment_uniform_buffer_2[25u].z, fragment_uniform_buffer_1[48u].z, mad(fragment_uniform_buffer_2[23u].z, fragment_uniform_buffer_1[48u].x, fragment_uniform_buffer_1[48u].y * fragment_uniform_buffer_2[24u].z)) + fragment_uniform_buffer_2[26u].z) + mad(fragment_uniform_buffer_2[25u].z, fragment_unnamed_583, mad(fragment_uniform_buffer_2[23u].z, fragment_unnamed_581, fragment_unnamed_582 * fragment_uniform_buffer_2[24u].z))) : asuint(fragment_unnamed_583)) + ((-0.0f) - fragment_uniform_buffer_2[28u].z)) * fragment_uniform_buffer_2[27u].z;
					float fragment_unnamed_701 = min(mad((-0.0f) - fragment_uniform_buffer_2[22u].z, 0.5f, 0.25f), max(((asfloat(fragment_unnamed_559 ? asuint((mad(fragment_uniform_buffer_2[25u].x, fragment_uniform_buffer_1[48u].z, mad(fragment_uniform_buffer_2[23u].x, fragment_uniform_buffer_1[48u].x, fragment_uniform_buffer_1[48u].y * fragment_uniform_buffer_2[24u].x)) + fragment_uniform_buffer_2[26u].x) + mad(fragment_uniform_buffer_2[25u].x, fragment_unnamed_583, mad(fragment_uniform_buffer_2[23u].x, fragment_unnamed_581, fragment_unnamed_582 * fragment_uniform_buffer_2[24u].x))) : asuint(fragment_unnamed_581)) + ((-0.0f) - fragment_uniform_buffer_2[28u].x)) * fragment_uniform_buffer_2[27u].x) * 0.25f, fragment_uniform_buffer_2[22u].z * 0.5f));
					float fragment_unnamed_728 = asfloat(1065353216u);
					fragment_unnamed_738 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_701, fragment_unnamed_686, fragment_unnamed_687), 0.0f)), float4(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466, fragment_unnamed_728));
					fragment_unnamed_739 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_701 + 0.25f, fragment_unnamed_686 + 0.0f, fragment_unnamed_687 + 0.0f), 0.0f)), float4(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466, fragment_unnamed_728));
					fragment_unnamed_740 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_701 + 0.5f, fragment_unnamed_686 + 0.0f, fragment_unnamed_687 + 0.0f), 0.0f)), float4(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466, fragment_unnamed_728));
				}
				float fragment_unnamed_747 = ((-0.0f) - fragment_uniform_buffer_4[1u].x) + 1.0f;
				float fragment_unnamed_748 = ((-0.0f) - fragment_uniform_buffer_4[1u].y) + 1.0f;
				float fragment_unnamed_749 = fragment_unnamed_387 * fragment_unnamed_748;
				float fragment_unnamed_750 = fragment_unnamed_388 * fragment_unnamed_748;
				float fragment_unnamed_751 = fragment_unnamed_389 * fragment_unnamed_748;
				float fragment_unnamed_759 = mad(fragment_uniform_buffer_4[1u].y, mad(fragment_input_5.x, fragment_unnamed_377, -0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_761 = mad(fragment_uniform_buffer_4[1u].y, mad(fragment_input_5.y, fragment_unnamed_378, -0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_762 = mad(fragment_uniform_buffer_4[1u].y, mad(fragment_input_5.z, fragment_unnamed_379, -0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_763 = dot(float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466), float3(fragment_unnamed_335, fragment_unnamed_336, fragment_unnamed_337));
				float fragment_unnamed_766 = max(fragment_unnamed_763, 9.9999997473787516355514526367188e-05f);
				float4 fragment_unnamed_777 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2((sqrt(fragment_unnamed_766) * 0.984375f) + 0.0078125f, (fragment_unnamed_747 * 0.984375f) + 0.0078125f), 0.0f);
				float fragment_unnamed_779 = fragment_unnamed_777.x;
				float fragment_unnamed_780 = fragment_unnamed_777.y;
				float fragment_unnamed_782 = fragment_unnamed_777.z + 0.5f;
				float fragment_unnamed_794 = clamp((max(fragment_unnamed_762, max(fragment_unnamed_761, fragment_unnamed_759)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_1[118u].w;
				uint4 fragment_unnamed_813 = asuint(fragment_uniform_buffer_1[120u]);
				uint4 fragment_unnamed_822 = asuint(fragment_uniform_buffer_1[120u]);
				float fragment_unnamed_826 = asfloat(((fragment_unnamed_472 & fragment_unnamed_813.y) != 0u) ? fragment_unnamed_822.x : 1065353216u);
				float fragment_unnamed_828 = asfloat(((fragment_unnamed_472 & fragment_unnamed_813.w) != 0u) ? fragment_unnamed_822.z : 1065353216u);
				float fragment_unnamed_847 = asfloat((asuint(fragment_uniform_buffer_1[113u]).y == 1u) ? asuint(clamp(dot(float3(fragment_unnamed_759, fragment_unnamed_761, fragment_unnamed_762), 0.333000004291534423828125f.xxx) * 50.0f, 0.0f, 1.0f)) : 1065353216u);
				float fragment_unnamed_848 = fragment_unnamed_747 * fragment_unnamed_747;
				float fragment_unnamed_858 = mad(((-0.0f) - fragment_unnamed_759) + fragment_unnamed_847, fragment_unnamed_779, fragment_unnamed_759 * fragment_unnamed_780);
				float fragment_unnamed_859 = mad(((-0.0f) - fragment_unnamed_761) + fragment_unnamed_847, fragment_unnamed_779, fragment_unnamed_761 * fragment_unnamed_780);
				float fragment_unnamed_860 = mad(((-0.0f) - fragment_unnamed_762) + fragment_unnamed_847, fragment_unnamed_779, fragment_unnamed_762 * fragment_unnamed_780);
				float fragment_unnamed_862 = (1.0f / fragment_unnamed_780) + (-1.0f);
				float fragment_unnamed_863 = fragment_unnamed_848 * fragment_unnamed_848;
				float fragment_unnamed_867 = sqrt(mad(mad((-0.0f) - fragment_unnamed_766, fragment_unnamed_863, fragment_unnamed_766), fragment_unnamed_766, fragment_unnamed_863));
				float fragment_unnamed_868 = (-0.0f) - fragment_unnamed_335;
				float fragment_unnamed_869 = (-0.0f) - fragment_unnamed_336;
				float fragment_unnamed_870 = (-0.0f) - fragment_unnamed_337;
				float fragment_unnamed_871 = dot(float3(fragment_unnamed_868, fragment_unnamed_869, fragment_unnamed_870), float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466));
				float fragment_unnamed_875 = (-0.0f) - (fragment_unnamed_871 + fragment_unnamed_871);
				float fragment_unnamed_876 = mad(fragment_unnamed_464, fragment_unnamed_875, fragment_unnamed_868);
				float fragment_unnamed_877 = mad(fragment_unnamed_465, fragment_unnamed_875, fragment_unnamed_869);
				float fragment_unnamed_878 = mad(fragment_unnamed_466, fragment_unnamed_875, fragment_unnamed_870);
				float fragment_unnamed_880 = ((-0.0f) - fragment_unnamed_766) + 1.0f;
				float fragment_unnamed_883 = (fragment_unnamed_747 * 0.984375f) + 0.0078125f;
				float fragment_unnamed_884 = (sqrt(fragment_unnamed_880) * 0.984375f) + 0.0078125f;
				float4 fragment_unnamed_889 = _LtcData.SampleLevel(S0, float3(fragment_unnamed_883, fragment_unnamed_884, asfloat(1065353216u)), 0.0f);
				float fragment_unnamed_891 = fragment_unnamed_889.x;
				float fragment_unnamed_892 = fragment_unnamed_889.y;
				float fragment_unnamed_893 = fragment_unnamed_889.z;
				float fragment_unnamed_894 = fragment_unnamed_889.w;
				float4 fragment_unnamed_895 = _LtcData.SampleLevel(S0, float3(fragment_unnamed_883, fragment_unnamed_884, asfloat(0u)), 0.0f);
				float fragment_unnamed_897 = fragment_unnamed_895.x;
				float fragment_unnamed_898 = fragment_unnamed_895.y;
				float fragment_unnamed_899 = fragment_unnamed_895.z;
				float fragment_unnamed_900 = fragment_unnamed_895.w;
				bool fragment_unnamed_904 = 5.9604644775390625e-08f >= abs(((-0.0f) - fragment_unnamed_763) + 1.0f);
				bool fragment_unnamed_906 = fragment_unnamed_466 >= 0.0f;
				float fragment_unnamed_908 = asfloat(fragment_unnamed_906 ? 1065353216u : 3212836864u);
				float fragment_unnamed_912 = 1.0f / mad(fragment_unnamed_458, fragment_unnamed_463, fragment_unnamed_908);
				float fragment_unnamed_913 = fragment_unnamed_912 * fragment_unnamed_465;
				float fragment_unnamed_914 = fragment_unnamed_913 * fragment_unnamed_464;
				float fragment_unnamed_915 = fragment_unnamed_464 * fragment_unnamed_908;
				float fragment_unnamed_923 = mad((-0.0f) - fragment_unnamed_464, fragment_unnamed_763, fragment_unnamed_335);
				float fragment_unnamed_924 = mad((-0.0f) - fragment_unnamed_465, fragment_unnamed_763, fragment_unnamed_336);
				float fragment_unnamed_925 = mad((-0.0f) - fragment_unnamed_466, fragment_unnamed_763, fragment_unnamed_337);
				float fragment_unnamed_929 = rsqrt(dot(float3(fragment_unnamed_923, fragment_unnamed_924, fragment_unnamed_925), float3(fragment_unnamed_923, fragment_unnamed_924, fragment_unnamed_925)));
				float fragment_unnamed_930 = fragment_unnamed_929 * fragment_unnamed_923;
				float fragment_unnamed_931 = fragment_unnamed_929 * fragment_unnamed_924;
				float fragment_unnamed_932 = fragment_unnamed_929 * fragment_unnamed_925;
				float fragment_unnamed_951 = asfloat(fragment_unnamed_904 ? asuint(fragment_unnamed_914) : asuint(mad(fragment_unnamed_465, fragment_unnamed_932, (-0.0f) - (fragment_unnamed_466 * fragment_unnamed_931))));
				float fragment_unnamed_953 = asfloat(fragment_unnamed_904 ? asuint(mad(fragment_unnamed_465, fragment_unnamed_913, asfloat(fragment_unnamed_906 ? 3212836864u : 1065353216u))) : asuint(mad(fragment_unnamed_466, fragment_unnamed_930, (-0.0f) - (fragment_unnamed_464 * fragment_unnamed_932))));
				float fragment_unnamed_961 = asfloat(fragment_unnamed_904 ? asuint(mad(fragment_unnamed_464 * fragment_unnamed_915, fragment_unnamed_912, -1.0f)) : asuint(fragment_unnamed_930));
				float fragment_unnamed_1121;
				float fragment_unnamed_1123;
				float fragment_unnamed_1125;
				if (int(asuint(fragment_uniform_buffer_1[116u]).z) >= int(0u))
				{
					uint fragment_unnamed_975 = (asuint(fragment_uniform_buffer_1[116u]).z * 44u) + 4u;
					uint3 fragment_unnamed_985 = uint3(T5.Load(fragment_unnamed_975).x, T5.Load(fragment_unnamed_975 + 1u).x, T5.Load(fragment_unnamed_975 + 2u).x);
					float fragment_unnamed_987 = asfloat(fragment_unnamed_985.x);
					float fragment_unnamed_989 = asfloat(fragment_unnamed_985.y);
					float fragment_unnamed_991 = asfloat(fragment_unnamed_985.z);
					float fragment_unnamed_1122;
					float fragment_unnamed_1124;
					float fragment_unnamed_1126;
					if ((((0.0f < dot(float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466), float3((-0.0f) - fragment_unnamed_987, (-0.0f) - fragment_unnamed_989, (-0.0f) - fragment_unnamed_991))) ? 4294967295u : 0u) & (((0.0f < asfloat(T5.Load((asuint(fragment_uniform_buffer_1[116u]).z * 44u) + 27u).x)) ? 4294967295u : 0u) & ((0.0f < asfloat(T5.Load((asuint(fragment_uniform_buffer_1[116u]).z * 44u) + 38u).x)) ? 4294967295u : 0u))) != 0u)
					{
						uint4 fragment_unnamed_1041 = uint4(T28.Load(0u).x, T28.Load(0u + 1u).x, T28.Load(0u + 2u).x, T28.Load(0u + 3u).x);
						float fragment_unnamed_1043 = asfloat(fragment_unnamed_1041.x);
						float fragment_unnamed_1045 = asfloat(fragment_unnamed_1041.y);
						float fragment_unnamed_1047 = asfloat(fragment_unnamed_1041.z);
						float fragment_unnamed_1049 = asfloat(fragment_unnamed_1041.w);
						uint4 fragment_unnamed_1061 = uint4(T28.Load(4u).x, T28.Load(4u + 1u).x, T28.Load(4u + 2u).x, T28.Load(4u + 3u).x);
						float fragment_unnamed_1063 = asfloat(fragment_unnamed_1061.x);
						float fragment_unnamed_1065 = asfloat(fragment_unnamed_1061.y);
						float fragment_unnamed_1067 = asfloat(fragment_unnamed_1061.z);
						float fragment_unnamed_1069 = asfloat(fragment_unnamed_1061.w);
						uint4 fragment_unnamed_1082 = uint4(T28.Load(8u).x, T28.Load(8u + 1u).x, T28.Load(8u + 2u).x, T28.Load(8u + 3u).x);
						float fragment_unnamed_1084 = asfloat(fragment_unnamed_1082.x);
						float fragment_unnamed_1086 = asfloat(fragment_unnamed_1082.y);
						float fragment_unnamed_1088 = asfloat(fragment_unnamed_1082.z);
						float fragment_unnamed_1090 = asfloat(fragment_unnamed_1082.w);
						uint4 fragment_unnamed_1103 = uint4(T28.Load(12u).x, T28.Load(12u + 1u).x, T28.Load(12u + 2u).x, T28.Load(12u + 3u).x);
						float fragment_unnamed_1105 = asfloat(fragment_unnamed_1103.x);
						float fragment_unnamed_1107 = asfloat(fragment_unnamed_1103.y);
						float fragment_unnamed_1109 = asfloat(fragment_unnamed_1103.z);
						float fragment_unnamed_1111 = asfloat(fragment_unnamed_1103.w);
						float fragment_unnamed_1112 = asfloat(0u);
						float fragment_unnamed_1113 = asfloat(0u);
						float fragment_unnamed_1114 = asfloat(0u);
						float fragment_unnamed_1115 = asfloat(4294967295u);
						float fragment_unnamed_1116 = asfloat(0u);
						float fragment_unnamed_1117 = asfloat(0u);
						float fragment_unnamed_1248;
						float fragment_unnamed_1252;
						float fragment_unnamed_1254;
						float fragment_unnamed_1256;
						float fragment_unnamed_1280;
						float fragment_unnamed_1281;
						float fragment_unnamed_1282;
						float fragment_unnamed_1284;
						float fragment_unnamed_1286;
						float fragment_unnamed_1245 = fragment_unnamed_1115;
						float fragment_unnamed_1247 = fragment_unnamed_1116;
						float fragment_unnamed_1249 = fragment_unnamed_1117;
						float fragment_unnamed_1251 = fragment_unnamed_1112;
						float fragment_unnamed_1253 = fragment_unnamed_1113;
						float fragment_unnamed_1255 = fragment_unnamed_1114;
						for (;;)
						{
							if (asuint(fragment_unnamed_1249) >= asuint(fragment_uniform_buffer_1[116u]).y)
							{
								fragment_unnamed_1280 = fragment_unnamed_1245;
								fragment_unnamed_1281 = fragment_unnamed_1247;
								fragment_unnamed_1282 = fragment_unnamed_1251;
								fragment_unnamed_1284 = fragment_unnamed_1253;
								fragment_unnamed_1286 = fragment_unnamed_1255;
								break;
							}
							else
							{
								uint fragment_unnamed_1293 = (asuint(fragment_unnamed_1249) * 4u) + 0u;
								uint fragment_unnamed_1303 = (asuint(fragment_unnamed_1249) * 4u) + 1u;
								uint fragment_unnamed_1312 = (asuint(fragment_unnamed_1249) * 4u) + 2u;
								uint fragment_unnamed_1321 = (asuint(fragment_unnamed_1249) * 4u) + 3u;
								fragment_unnamed_1252 = ((-0.0f) - mad(fragment_unnamed_105[fragment_unnamed_1321], fragment_unnamed_1105, mad(fragment_unnamed_105[fragment_unnamed_1312], fragment_unnamed_1084, mad(fragment_unnamed_105[fragment_unnamed_1303], fragment_unnamed_1063, fragment_unnamed_1043 * fragment_unnamed_105[fragment_unnamed_1293])))) + fragment_input_6.x;
								fragment_unnamed_1254 = ((-0.0f) - mad(fragment_unnamed_105[fragment_unnamed_1321], fragment_unnamed_1107, mad(fragment_unnamed_105[fragment_unnamed_1312], fragment_unnamed_1086, mad(fragment_unnamed_105[fragment_unnamed_1303], fragment_unnamed_1065, fragment_unnamed_1045 * fragment_unnamed_105[fragment_unnamed_1293])))) + fragment_input_6.y;
								fragment_unnamed_1256 = ((-0.0f) - mad(fragment_unnamed_105[fragment_unnamed_1321], fragment_unnamed_1109, mad(fragment_unnamed_105[fragment_unnamed_1312], fragment_unnamed_1088, mad(fragment_unnamed_105[fragment_unnamed_1303], fragment_unnamed_1067, fragment_unnamed_1047 * fragment_unnamed_105[fragment_unnamed_1293])))) + fragment_input_6.z;
								float fragment_unnamed_1337 = dot(float3(fragment_unnamed_1252, fragment_unnamed_1254, fragment_unnamed_1256), float3(fragment_unnamed_1252, fragment_unnamed_1254, fragment_unnamed_1256));
								fragment_unnamed_1248 = fragment_unnamed_1337 / mad(fragment_unnamed_105[fragment_unnamed_1321], fragment_unnamed_1111, mad(fragment_unnamed_105[fragment_unnamed_1312], fragment_unnamed_1090, mad(fragment_unnamed_105[fragment_unnamed_1303], fragment_unnamed_1069, fragment_unnamed_1049 * fragment_unnamed_105[fragment_unnamed_1293])));
								if (!((((0.0f < fragment_unnamed_1248) ? 4294967295u : 0u) & ((1.0f >= fragment_unnamed_1248) ? 4294967295u : 0u)) != 0u))
								{
									fragment_unnamed_1245 = asfloat(4294967295u);
									fragment_unnamed_1247 = fragment_unnamed_1248;
									fragment_unnamed_1249 = asfloat(asuint(fragment_unnamed_1249) + 1u);
									fragment_unnamed_1251 = fragment_unnamed_1252;
									fragment_unnamed_1253 = fragment_unnamed_1254;
									fragment_unnamed_1255 = fragment_unnamed_1256;
									continue;
								}
								float fragment_unnamed_1552 = sqrt(fragment_unnamed_1337);
								fragment_unnamed_1280 = fragment_unnamed_1249;
								fragment_unnamed_1281 = fragment_unnamed_1248;
								fragment_unnamed_1282 = fragment_unnamed_1252 / fragment_unnamed_1552;
								fragment_unnamed_1284 = fragment_unnamed_1254 / fragment_unnamed_1552;
								fragment_unnamed_1286 = fragment_unnamed_1256 / fragment_unnamed_1552;
								break;
							}
						}
						float fragment_unnamed_1289 = float(int(asuint(fragment_unnamed_1280)));
						float fragment_unnamed_1263;
						if (fragment_unnamed_1289 >= 0.0f)
						{
							uint4 fragment_unnamed_1391 = uint4(T28.Load(19u).x, T28.Load(19u + 1u).x, T28.Load(19u + 2u).x, T28.Load(19u + 3u).x);
							uint4 fragment_unnamed_1406 = T5.Load((asuint(fragment_uniform_buffer_1[116u]).z * 44u) + 15u);
							uint fragment_unnamed_1407 = fragment_unnamed_1406.x;
							float fragment_unnamed_1418 = asfloat((dot(float3(fragment_unnamed_241, fragment_unnamed_242, fragment_unnamed_243), float3((-0.0f) - fragment_unnamed_987, (-0.0f) - fragment_unnamed_989, (-0.0f) - fragment_unnamed_991)) >= 0.0f) ? 1065353216u : 3212836864u);
							uint fragment_unnamed_1426 = asuint(fragment_unnamed_1280);
							float fragment_unnamed_1443 = dot(float4(asfloat(fragment_unnamed_1391.y), asfloat(fragment_unnamed_1391.z), asfloat(fragment_unnamed_1391.w), asfloat(T28.Load(23u).x)), float4(fragment_unnamed_105[(fragment_unnamed_1426 * 4u) + 0u], fragment_unnamed_105[(fragment_unnamed_1426 * 4u) + 1u], fragment_unnamed_105[(fragment_unnamed_1426 * 4u) + 2u], fragment_unnamed_105[(fragment_unnamed_1426 * 4u) + 3u]));
							float fragment_unnamed_1455 = asfloat((0.0f >= fragment_unnamed_1443) ? 0u : asuint(clamp((fragment_unnamed_1281 + ((-0.0f) - (((-0.0f) - fragment_unnamed_1443) + 1.0f))) / fragment_unnamed_1443, 0.0f, 1.0f)));
							float fragment_unnamed_1462 = clamp((fragment_unnamed_1443 + (-1.0f)) * (-3.3333332538604736328125f), 0.0f, 1.0f);
							float fragment_unnamed_1474 = mad(clamp(mad((fragment_unnamed_1462 * fragment_unnamed_1462) * mad(fragment_unnamed_1462, -2.0f, 3.0f), 512.0f, 8.0f) * dot(float3(fragment_unnamed_326, fragment_unnamed_328, fragment_unnamed_330), float3(fragment_unnamed_1282, fragment_unnamed_1284, fragment_unnamed_1286)), 0.0f, 1.0f), (-0.0f) - fragment_unnamed_1455, fragment_unnamed_1455);
							float fragment_unnamed_1480 = asfloat(T27.Load((fragment_unnamed_1407 * 60u) + 19u).x);
							uint fragment_unnamed_1482 = (fragment_unnamed_1407 * 60u) + 24u;
							uint2 fragment_unnamed_1489 = uint2(T27.Load(fragment_unnamed_1482).x, T27.Load(fragment_unnamed_1482 + 1u).x);
							uint fragment_unnamed_1495 = asuint(fragment_unnamed_1280) + fragment_unnamed_1407;
							uint fragment_unnamed_1497 = (fragment_unnamed_1495 * 60u) + 16u;
							uint3 fragment_unnamed_1506 = uint3(T27.Load(fragment_unnamed_1497).x, T27.Load(fragment_unnamed_1497 + 1u).x, T27.Load(fragment_unnamed_1497 + 2u).x);
							float fragment_unnamed_1512 = asfloat(fragment_unnamed_1506.z);
							float fragment_unnamed_1516 = fragment_unnamed_1512 * (fragment_unnamed_1480 * (fragment_unnamed_241 * fragment_unnamed_1418));
							float fragment_unnamed_1517 = fragment_unnamed_1512 * (fragment_unnamed_1480 * (fragment_unnamed_242 * fragment_unnamed_1418));
							float fragment_unnamed_1518 = fragment_unnamed_1512 * (fragment_unnamed_1480 * (fragment_unnamed_243 * fragment_unnamed_1418));
							uint fragment_unnamed_1521 = uint(int(asfloat(fragment_unnamed_1391.x))) + 4294967295u;
							float fragment_unnamed_1523 = float(int(uint(min(int(asuint(fragment_unnamed_1280) + 1u), int(fragment_unnamed_1521)))));
							float fragment_unnamed_1533 = trunc(fragment_uniform_buffer_1[74u].z);
							float fragment_unnamed_1952;
							float fragment_unnamed_1953;
							float fragment_unnamed_1954;
							float fragment_unnamed_1955;
							float fragment_unnamed_1956;
							float fragment_unnamed_1957;
							float fragment_unnamed_1958;
							float fragment_unnamed_1959;
							float fragment_unnamed_1960;
							float fragment_unnamed_1961;
							float fragment_unnamed_1962;
							float fragment_unnamed_1963;
							float fragment_unnamed_1964;
							float fragment_unnamed_1965;
							float fragment_unnamed_1966;
							float fragment_unnamed_1967;
							float fragment_unnamed_1968;
							float fragment_unnamed_1969;
							float fragment_unnamed_1970;
							float fragment_unnamed_1971;
							float fragment_unnamed_1972;
							float fragment_unnamed_1973;
							float fragment_unnamed_1974;
							float fragment_unnamed_1975;
							if (((((fragment_unnamed_1289 != fragment_unnamed_1523) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1474) ? 4294967295u : 0u)) & ((fragment_unnamed_1474 >= frac(frac(dot(float2(mad(fragment_unnamed_1533, 2.0829999446868896484375f, float(fragment_unnamed_272)), mad(fragment_unnamed_1533, 4.867000102996826171875f, float(fragment_unnamed_273))), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f))) * 52.98291778564453125f)) ? 4294967295u : 0u)) != 0u)
							{
								uint fragment_unnamed_1594 = uint(int(fragment_unnamed_1523 + float(int(fragment_unnamed_1407))));
								uint fragment_unnamed_1595 = fragment_unnamed_1594 * 60u;
								uint4 fragment_unnamed_1607 = uint4(T27.Load(fragment_unnamed_1595).x, T27.Load(fragment_unnamed_1595 + 1u).x, T27.Load(fragment_unnamed_1595 + 2u).x, T27.Load(fragment_unnamed_1595 + 3u).x);
								uint fragment_unnamed_1614 = (fragment_unnamed_1594 * 60u) + 4u;
								uint4 fragment_unnamed_1626 = uint4(T27.Load(fragment_unnamed_1614).x, T27.Load(fragment_unnamed_1614 + 1u).x, T27.Load(fragment_unnamed_1614 + 2u).x, T27.Load(fragment_unnamed_1614 + 3u).x);
								uint fragment_unnamed_1632 = (fragment_unnamed_1594 * 60u) + 12u;
								uint4 fragment_unnamed_1644 = uint4(T27.Load(fragment_unnamed_1632).x, T27.Load(fragment_unnamed_1632 + 1u).x, T27.Load(fragment_unnamed_1632 + 2u).x, T27.Load(fragment_unnamed_1632 + 3u).x);
								uint fragment_unnamed_1654 = (fragment_unnamed_1594 * 60u) + 8u;
								uint4 fragment_unnamed_1666 = uint4(T27.Load(fragment_unnamed_1654).x, T27.Load(fragment_unnamed_1654 + 1u).x, T27.Load(fragment_unnamed_1654 + 2u).x, T27.Load(fragment_unnamed_1654 + 3u).x);
								uint fragment_unnamed_1674 = (fragment_unnamed_1594 * 60u) + 16u;
								uint3 fragment_unnamed_1683 = uint3(T27.Load(fragment_unnamed_1674).x, T27.Load(fragment_unnamed_1674 + 1u).x, T27.Load(fragment_unnamed_1674 + 2u).x);
								uint fragment_unnamed_1690 = (fragment_unnamed_1594 * 60u) + 40u;
								uint3 fragment_unnamed_1699 = uint3(T27.Load(fragment_unnamed_1690).x, T27.Load(fragment_unnamed_1690 + 1u).x, T27.Load(fragment_unnamed_1690 + 2u).x);
								float fragment_unnamed_1715 = asfloat(fragment_unnamed_1683.z) / fragment_unnamed_1512;
								fragment_unnamed_1952 = fragment_unnamed_1715 * fragment_unnamed_1516;
								fragment_unnamed_1953 = asfloat(fragment_unnamed_1683.x);
								fragment_unnamed_1954 = asfloat(fragment_unnamed_1683.y);
								fragment_unnamed_1955 = fragment_unnamed_1715 * fragment_unnamed_1517;
								fragment_unnamed_1956 = fragment_unnamed_1715 * fragment_unnamed_1518;
								fragment_unnamed_1957 = asfloat(fragment_unnamed_1607.w);
								fragment_unnamed_1958 = asfloat(fragment_unnamed_1626.x);
								fragment_unnamed_1959 = asfloat(fragment_unnamed_1626.y);
								fragment_unnamed_1960 = asfloat(fragment_unnamed_1666.z);
								fragment_unnamed_1961 = asfloat(fragment_unnamed_1644.z);
								fragment_unnamed_1962 = asfloat(fragment_unnamed_1644.w);
								fragment_unnamed_1963 = asfloat(fragment_unnamed_1644.x);
								fragment_unnamed_1964 = asfloat(fragment_unnamed_1626.z);
								fragment_unnamed_1965 = asfloat(fragment_unnamed_1626.w);
								fragment_unnamed_1966 = asfloat(fragment_unnamed_1666.x);
								fragment_unnamed_1967 = asfloat(fragment_unnamed_1666.w);
								fragment_unnamed_1968 = asfloat(fragment_unnamed_1644.y);
								fragment_unnamed_1969 = asfloat(fragment_unnamed_1699.x) + fragment_input_6.x;
								fragment_unnamed_1970 = asfloat(fragment_unnamed_1699.y) + fragment_input_6.y;
								fragment_unnamed_1971 = asfloat(fragment_unnamed_1699.z) + fragment_input_6.z;
								fragment_unnamed_1972 = asfloat(fragment_unnamed_1607.x);
								fragment_unnamed_1973 = asfloat(fragment_unnamed_1607.y);
								fragment_unnamed_1974 = asfloat(fragment_unnamed_1607.z);
								fragment_unnamed_1975 = asfloat(fragment_unnamed_1666.y);
							}
							else
							{
								uint fragment_unnamed_1730 = fragment_unnamed_1495 * 60u;
								uint4 fragment_unnamed_1742 = uint4(T27.Load(fragment_unnamed_1730).x, T27.Load(fragment_unnamed_1730 + 1u).x, T27.Load(fragment_unnamed_1730 + 2u).x, T27.Load(fragment_unnamed_1730 + 3u).x);
								uint fragment_unnamed_1749 = (fragment_unnamed_1495 * 60u) + 4u;
								uint4 fragment_unnamed_1761 = uint4(T27.Load(fragment_unnamed_1749).x, T27.Load(fragment_unnamed_1749 + 1u).x, T27.Load(fragment_unnamed_1749 + 2u).x, T27.Load(fragment_unnamed_1749 + 3u).x);
								uint fragment_unnamed_1767 = (fragment_unnamed_1495 * 60u) + 12u;
								uint4 fragment_unnamed_1779 = uint4(T27.Load(fragment_unnamed_1767).x, T27.Load(fragment_unnamed_1767 + 1u).x, T27.Load(fragment_unnamed_1767 + 2u).x, T27.Load(fragment_unnamed_1767 + 3u).x);
								uint fragment_unnamed_1789 = (fragment_unnamed_1495 * 60u) + 8u;
								uint4 fragment_unnamed_1801 = uint4(T27.Load(fragment_unnamed_1789).x, T27.Load(fragment_unnamed_1789 + 1u).x, T27.Load(fragment_unnamed_1789 + 2u).x, T27.Load(fragment_unnamed_1789 + 3u).x);
								uint fragment_unnamed_1809 = (fragment_unnamed_1495 * 60u) + 40u;
								uint3 fragment_unnamed_1818 = uint3(T27.Load(fragment_unnamed_1809).x, T27.Load(fragment_unnamed_1809 + 1u).x, T27.Load(fragment_unnamed_1809 + 2u).x);
								fragment_unnamed_1952 = fragment_unnamed_1516;
								fragment_unnamed_1953 = asfloat(fragment_unnamed_1506.x);
								fragment_unnamed_1954 = asfloat(fragment_unnamed_1506.y);
								fragment_unnamed_1955 = fragment_unnamed_1517;
								fragment_unnamed_1956 = fragment_unnamed_1518;
								fragment_unnamed_1957 = asfloat(fragment_unnamed_1742.w);
								fragment_unnamed_1958 = asfloat(fragment_unnamed_1761.x);
								fragment_unnamed_1959 = asfloat(fragment_unnamed_1761.y);
								fragment_unnamed_1960 = asfloat(fragment_unnamed_1801.z);
								fragment_unnamed_1961 = asfloat(fragment_unnamed_1779.z);
								fragment_unnamed_1962 = asfloat(fragment_unnamed_1779.w);
								fragment_unnamed_1963 = asfloat(fragment_unnamed_1779.x);
								fragment_unnamed_1964 = asfloat(fragment_unnamed_1761.z);
								fragment_unnamed_1965 = asfloat(fragment_unnamed_1761.w);
								fragment_unnamed_1966 = asfloat(fragment_unnamed_1801.x);
								fragment_unnamed_1967 = asfloat(fragment_unnamed_1801.w);
								fragment_unnamed_1968 = asfloat(fragment_unnamed_1779.y);
								fragment_unnamed_1969 = asfloat(fragment_unnamed_1818.x) + fragment_input_6.x;
								fragment_unnamed_1970 = asfloat(fragment_unnamed_1818.y) + fragment_input_6.y;
								fragment_unnamed_1971 = asfloat(fragment_unnamed_1818.z) + fragment_input_6.z;
								fragment_unnamed_1972 = asfloat(fragment_unnamed_1742.x);
								fragment_unnamed_1973 = asfloat(fragment_unnamed_1742.y);
								fragment_unnamed_1974 = asfloat(fragment_unnamed_1742.z);
								fragment_unnamed_1975 = asfloat(fragment_unnamed_1801.y);
							}
							float fragment_unnamed_1976 = fragment_unnamed_1952 + fragment_unnamed_1969;
							float fragment_unnamed_1977 = fragment_unnamed_1955 + fragment_unnamed_1970;
							float fragment_unnamed_1978 = fragment_unnamed_1956 + fragment_unnamed_1971;
							float fragment_unnamed_1979 = asfloat(1065353216u);
							float fragment_unnamed_2006 = mad(asfloat(fragment_unnamed_1489.x) * clamp(mad(dot(float4(fragment_unnamed_1972, fragment_unnamed_1973, fragment_unnamed_1974, fragment_unnamed_1975), float4(fragment_unnamed_1976, fragment_unnamed_1977, fragment_unnamed_1978, fragment_unnamed_1979)) * fragment_unnamed_1963, 0.5f, 0.5f), 0.0f, 1.0f), fragment_uniform_buffer_1[98u].z, fragment_unnamed_1953);
							float fragment_unnamed_2007 = mad(asfloat(fragment_unnamed_1489.y) * clamp(mad(dot(float4(fragment_unnamed_1957, fragment_unnamed_1958, fragment_unnamed_1959, fragment_unnamed_1960), float4(fragment_unnamed_1976, fragment_unnamed_1977, fragment_unnamed_1978, fragment_unnamed_1979)) * fragment_unnamed_1968, 0.5f, 0.5f), 0.0f, 1.0f), fragment_uniform_buffer_1[98u].w, fragment_unnamed_1954);
							float fragment_unnamed_2008 = dot(float2(fragment_unnamed_1961, fragment_unnamed_1962), float2(dot(float4(fragment_unnamed_1964, fragment_unnamed_1965, fragment_unnamed_1966, fragment_unnamed_1967), float4(fragment_unnamed_1976, fragment_unnamed_1977, fragment_unnamed_1978, fragment_unnamed_1979)), asfloat(1065353216u))) + 1.52587890625e-05f;
							float fragment_unnamed_2016 = floor(mad(fragment_unnamed_2006, fragment_uniform_buffer_1[98u].x, 0.5f));
							float fragment_unnamed_2017 = floor(mad(fragment_unnamed_2007, fragment_uniform_buffer_1[98u].y, 0.5f));
							float fragment_unnamed_2024 = mad(fragment_unnamed_2006, fragment_uniform_buffer_1[98u].x, (-0.0f) - fragment_unnamed_2016);
							float fragment_unnamed_2025 = mad(fragment_unnamed_2007, fragment_uniform_buffer_1[98u].y, (-0.0f) - fragment_unnamed_2017);
							float fragment_unnamed_2026 = fragment_unnamed_2024 + 0.5f;
							float fragment_unnamed_2028 = fragment_unnamed_2025 + 0.5f;
							float fragment_unnamed_2034 = (fragment_unnamed_2026 * fragment_unnamed_2026) * 0.040816001594066619873046875f;
							float fragment_unnamed_2036 = (fragment_unnamed_2028 * fragment_unnamed_2028) * 0.040816001594066619873046875f;
							float fragment_unnamed_2045 = min(fragment_unnamed_2024, 0.0f);
							float fragment_unnamed_2046 = min(fragment_unnamed_2025, 0.0f);
							float fragment_unnamed_2051 = max(fragment_unnamed_2024, 0.0f);
							float fragment_unnamed_2052 = max(fragment_unnamed_2025, 0.0f);
							float fragment_unnamed_2066 = (mad((-0.0f) - fragment_unnamed_2045, fragment_unnamed_2045, ((-0.0f) - fragment_unnamed_2024) + 1.0f) + 2.0f) * 0.08163200318813323974609375f;
							float fragment_unnamed_2067 = (mad((-0.0f) - fragment_unnamed_2046, fragment_unnamed_2046, ((-0.0f) - fragment_unnamed_2025) + 1.0f) + 2.0f) * 0.08163200318813323974609375f;
							float fragment_unnamed_2072 = mad(fragment_unnamed_2024, -0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2073 = mad(fragment_unnamed_2024, 0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2074 = fragment_unnamed_2072 + (mad(fragment_unnamed_2026 * fragment_unnamed_2026, 0.5f, (-0.0f) - fragment_unnamed_2024) * 0.08163200318813323974609375f);
							float fragment_unnamed_2075 = fragment_unnamed_2066 + mad(fragment_unnamed_2024, -0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2076 = fragment_unnamed_2073 + ((mad((-0.0f) - fragment_unnamed_2051, fragment_unnamed_2051, fragment_unnamed_2024 + 1.0f) + 2.0f) * 0.08163200318813323974609375f);
							float fragment_unnamed_2077 = fragment_unnamed_2034 + mad(fragment_unnamed_2024, 0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2080 = mad(fragment_unnamed_2025, -0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2081 = mad(fragment_unnamed_2025, 0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2082 = fragment_unnamed_2080 + (mad(fragment_unnamed_2028 * fragment_unnamed_2028, 0.5f, (-0.0f) - fragment_unnamed_2025) * 0.08163200318813323974609375f);
							float fragment_unnamed_2083 = fragment_unnamed_2067 + mad(fragment_unnamed_2025, -0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2084 = fragment_unnamed_2081 + ((mad((-0.0f) - fragment_unnamed_2052, fragment_unnamed_2052, fragment_unnamed_2025 + 1.0f) + 2.0f) * 0.08163200318813323974609375f);
							float fragment_unnamed_2085 = fragment_unnamed_2036 + mad(fragment_unnamed_2025, 0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2108 = ((fragment_unnamed_2034 / fragment_unnamed_2077) + 2.5f) * fragment_uniform_buffer_1[98u].z;
							float fragment_unnamed_2109 = ((fragment_unnamed_2072 / fragment_unnamed_2074) + (-3.5f)) * fragment_uniform_buffer_1[98u].z;
							float fragment_unnamed_2110 = ((fragment_unnamed_2066 / fragment_unnamed_2075) + (-1.5f)) * fragment_uniform_buffer_1[98u].z;
							float fragment_unnamed_2111 = ((fragment_unnamed_2073 / fragment_unnamed_2076) + 0.5f) * fragment_uniform_buffer_1[98u].z;
							float fragment_unnamed_2115 = ((fragment_unnamed_2080 / fragment_unnamed_2082) + (-3.5f)) * fragment_uniform_buffer_1[98u].w;
							float fragment_unnamed_2116 = ((fragment_unnamed_2036 / fragment_unnamed_2085) + 2.5f) * fragment_uniform_buffer_1[98u].w;
							float fragment_unnamed_2117 = ((fragment_unnamed_2067 / fragment_unnamed_2083) + (-1.5f)) * fragment_uniform_buffer_1[98u].w;
							float fragment_unnamed_2118 = ((fragment_unnamed_2081 / fragment_unnamed_2084) + 0.5f) * fragment_uniform_buffer_1[98u].w;
							float fragment_unnamed_2195 = fragment_unnamed_2082 * fragment_unnamed_2074;
							float fragment_unnamed_2196 = fragment_unnamed_2082 * fragment_unnamed_2075;
							float fragment_unnamed_2197 = fragment_unnamed_2082 * fragment_unnamed_2076;
							float fragment_unnamed_2198 = fragment_unnamed_2082 * fragment_unnamed_2077;
							float fragment_unnamed_2199 = fragment_unnamed_2083 * fragment_unnamed_2074;
							float fragment_unnamed_2200 = fragment_unnamed_2083 * fragment_unnamed_2075;
							float fragment_unnamed_2201 = fragment_unnamed_2083 * fragment_unnamed_2076;
							float fragment_unnamed_2202 = fragment_unnamed_2083 * fragment_unnamed_2077;
							float fragment_unnamed_2203 = fragment_unnamed_2084 * fragment_unnamed_2074;
							float fragment_unnamed_2204 = fragment_unnamed_2084 * fragment_unnamed_2075;
							float fragment_unnamed_2205 = fragment_unnamed_2084 * fragment_unnamed_2076;
							float fragment_unnamed_2206 = fragment_unnamed_2084 * fragment_unnamed_2077;
							float fragment_unnamed_2207 = fragment_unnamed_2085 * fragment_unnamed_2074;
							float fragment_unnamed_2208 = fragment_unnamed_2085 * fragment_unnamed_2075;
							float fragment_unnamed_2209 = fragment_unnamed_2085 * fragment_unnamed_2076;
							float fragment_unnamed_2210 = fragment_unnamed_2085 * fragment_unnamed_2077;
							float4 fragment_unnamed_2216 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2109), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2115)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_2217 = fragment_unnamed_2216.x;
							float4 fragment_unnamed_2220 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2110), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2115)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_2221 = fragment_unnamed_2220.x;
							float4 fragment_unnamed_2224 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2111), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2115)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_2225 = fragment_unnamed_2224.x;
							float4 fragment_unnamed_2228 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2108), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2115)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_2229 = fragment_unnamed_2228.x;
							float fragment_unnamed_2231 = asfloat(0u);
							float fragment_unnamed_2538;
							fragment_unnamed_2538 = asfloat(0u);
							float fragment_unnamed_2539;
							float fragment_unnamed_2700;
							float fragment_unnamed_2701;
							float fragment_unnamed_2702;
							for (float fragment_unnamed_2540 = fragment_unnamed_2231; !(int(asuint(fragment_unnamed_2540)) >= int(1u)); fragment_unnamed_2700 = mad(fragment_unnamed_2195, fragment_unnamed_2217, fragment_unnamed_2538), fragment_unnamed_2701 = mad(fragment_unnamed_2196, fragment_unnamed_2221, fragment_unnamed_2700), fragment_unnamed_2702 = mad(fragment_unnamed_2197, fragment_unnamed_2225, fragment_unnamed_2701), fragment_unnamed_2539 = mad(fragment_unnamed_2198, fragment_unnamed_2229, fragment_unnamed_2702), fragment_unnamed_2538 = fragment_unnamed_2539, fragment_unnamed_2540 = asfloat(asuint(fragment_unnamed_2540) + 1u))
							{
							}
							float4 fragment_unnamed_2685 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2109), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2117)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_2686 = fragment_unnamed_2685.x;
							float4 fragment_unnamed_2689 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2110), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2117)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_2690 = fragment_unnamed_2689.x;
							float4 fragment_unnamed_2693 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2111), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2117)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_2694 = fragment_unnamed_2693.x;
							float4 fragment_unnamed_2697 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2108), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2117)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_2698 = fragment_unnamed_2697.x;
							float fragment_unnamed_2699 = asfloat(0u);
							float fragment_unnamed_3372;
							fragment_unnamed_3372 = fragment_unnamed_2538;
							float fragment_unnamed_3373;
							float fragment_unnamed_3725;
							float fragment_unnamed_3726;
							float fragment_unnamed_3727;
							for (float fragment_unnamed_3370 = fragment_unnamed_2699; !(int(asuint(fragment_unnamed_3370)) >= int(1u)); fragment_unnamed_3725 = mad(fragment_unnamed_2199, fragment_unnamed_2686, fragment_unnamed_3372), fragment_unnamed_3726 = mad(fragment_unnamed_2200, fragment_unnamed_2690, fragment_unnamed_3725), fragment_unnamed_3727 = mad(fragment_unnamed_2201, fragment_unnamed_2694, fragment_unnamed_3726), fragment_unnamed_3373 = mad(fragment_unnamed_2202, fragment_unnamed_2698, fragment_unnamed_3727), fragment_unnamed_3370 = asfloat(asuint(fragment_unnamed_3370) + 1u), fragment_unnamed_3372 = fragment_unnamed_3373)
							{
							}
							float4 fragment_unnamed_3710 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2109), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2118)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_3711 = fragment_unnamed_3710.x;
							float4 fragment_unnamed_3714 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2110), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2118)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_3715 = fragment_unnamed_3714.x;
							float4 fragment_unnamed_3718 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2111), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2118)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_3719 = fragment_unnamed_3718.x;
							float4 fragment_unnamed_3722 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2108), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2118)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_3723 = fragment_unnamed_3722.x;
							float fragment_unnamed_3724 = asfloat(0u);
							float fragment_unnamed_4431;
							fragment_unnamed_4431 = fragment_unnamed_3372;
							float fragment_unnamed_4432;
							float fragment_unnamed_4927;
							float fragment_unnamed_4928;
							float fragment_unnamed_4929;
							for (float fragment_unnamed_4433 = fragment_unnamed_3724; !(int(asuint(fragment_unnamed_4433)) >= int(1u)); fragment_unnamed_4927 = mad(fragment_unnamed_2203, fragment_unnamed_3711, fragment_unnamed_4431), fragment_unnamed_4928 = mad(fragment_unnamed_2204, fragment_unnamed_3715, fragment_unnamed_4927), fragment_unnamed_4929 = mad(fragment_unnamed_2205, fragment_unnamed_3719, fragment_unnamed_4928), fragment_unnamed_4432 = mad(fragment_unnamed_2206, fragment_unnamed_3723, fragment_unnamed_4929), fragment_unnamed_4431 = fragment_unnamed_4432, fragment_unnamed_4433 = asfloat(asuint(fragment_unnamed_4433) + 1u))
							{
							}
							float4 fragment_unnamed_4912 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2109), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2116)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_4913 = fragment_unnamed_4912.x;
							float4 fragment_unnamed_4916 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2110), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2116)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_4917 = fragment_unnamed_4916.x;
							float4 fragment_unnamed_4920 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2111), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2116)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_4921 = fragment_unnamed_4920.x;
							float4 fragment_unnamed_4924 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2016, fragment_uniform_buffer_1[98u].z, fragment_unnamed_2108), mad(fragment_unnamed_2017, fragment_uniform_buffer_1[98u].w, fragment_unnamed_2116)), fragment_unnamed_2008).xxxx;
							float fragment_unnamed_4925 = fragment_unnamed_4924.x;
							float fragment_unnamed_4926 = asfloat(0u);
							float fragment_unnamed_6007;
							fragment_unnamed_6007 = fragment_unnamed_4431;
							float fragment_unnamed_6008;
							float fragment_unnamed_6170;
							float fragment_unnamed_6171;
							float fragment_unnamed_6172;
							for (float fragment_unnamed_6009 = fragment_unnamed_4926; !(int(asuint(fragment_unnamed_6009)) >= int(1u)); fragment_unnamed_6170 = mad(fragment_unnamed_2207, fragment_unnamed_4913, fragment_unnamed_6007), fragment_unnamed_6171 = mad(fragment_unnamed_2208, fragment_unnamed_4917, fragment_unnamed_6170), fragment_unnamed_6172 = mad(fragment_unnamed_2209, fragment_unnamed_4921, fragment_unnamed_6171), fragment_unnamed_6008 = mad(fragment_unnamed_2210, fragment_unnamed_4925, fragment_unnamed_6172), fragment_unnamed_6007 = fragment_unnamed_6008, fragment_unnamed_6009 = asfloat(asuint(fragment_unnamed_6009) + 1u))
							{
							}
							fragment_unnamed_1263 = asfloat((int(asuint(fragment_unnamed_1280)) < int(fragment_unnamed_1521)) ? asuint(fragment_unnamed_6007) : asuint(mad(fragment_unnamed_1474, ((-0.0f) - fragment_unnamed_6007) + 1.0f, fragment_unnamed_6007)));
						}
						else
						{
							fragment_unnamed_1263 = asfloat(1065353216u);
						}
						fragment_unnamed_1122 = fragment_unnamed_1263;
						fragment_unnamed_1124 = fragment_unnamed_1263;
						fragment_unnamed_1126 = fragment_unnamed_1263;
					}
					else
					{
						fragment_unnamed_1122 = asfloat(1065353216u);
						fragment_unnamed_1124 = asfloat(1065353216u);
						fragment_unnamed_1126 = asfloat(1065353216u);
					}
					fragment_unnamed_1121 = fragment_unnamed_1122;
					fragment_unnamed_1123 = fragment_unnamed_1124;
					fragment_unnamed_1125 = fragment_unnamed_1126;
				}
				else
				{
					fragment_unnamed_1121 = asfloat(1065353216u);
					fragment_unnamed_1123 = asfloat(1065353216u);
					fragment_unnamed_1125 = asfloat(1065353216u);
				}
				float fragment_unnamed_1148 = asfloat((asuint(fragment_uniform_buffer_1[127u]).w != 0u) ? T4.Load((fragment_unnamed_276 * asuint(fragment_uniform_buffer_1[128u]).x) + fragment_unnamed_274).x : asuint(fragment_uniform_buffer_1[126u]).w);
				uint4 fragment_unnamed_1151 = asuint(fragment_uniform_buffer_1[127u]);
				uint fragment_unnamed_1152 = fragment_unnamed_1151.z;
				uint fragment_unnamed_1157 = 1u << (fragment_unnamed_1152 & 31u);
				uint fragment_unnamed_1190 = uint(int(min(float(int(fragment_unnamed_1157 + 4294967295u)), max(log2(mad(max((1.0f / gl_FragCoord.w) + ((-0.0f) - fragment_uniform_buffer_1[127u].x), 0.0f) / (((-0.0f) - fragment_uniform_buffer_1[127u].x) + fragment_uniform_buffer_1[127u].y), exp2(float(int(fragment_unnamed_1157)) * log2(abs(fragment_unnamed_1148))) + (-1.0f), 1.0f)) / log2(fragment_unnamed_1148), 0.0f))));
				uint4 fragment_unnamed_1203 = T3.Load((((fragment_unnamed_1190 * asuint(fragment_uniform_buffer_1[128u]).y) + fragment_unnamed_276) * asuint(fragment_uniform_buffer_1[128u]).x) + fragment_unnamed_274);
				uint fragment_unnamed_1204 = fragment_unnamed_1203.x;
				uint fragment_unnamed_1205 = fragment_unnamed_1204 & 67108863u;
				uint fragment_unnamed_1207 = fragment_unnamed_1204 >> 26u;
				float fragment_unnamed_1220 = dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_uniform_buffer_1[83u].xyz));
				float fragment_unnamed_1223 = fragment_unnamed_880 * fragment_unnamed_880;
				float fragment_unnamed_1231 = exp2(ceil(max((-0.0f) - fragment_uniform_buffer_1[123u].z, 0.0f)));
				float fragment_unnamed_1233 = fragment_unnamed_880 * (fragment_unnamed_1223 * fragment_unnamed_1223);
				float fragment_unnamed_1234 = asfloat(1065353216u);
				float fragment_unnamed_1235 = asfloat(1065353216u);
				float fragment_unnamed_1236 = asfloat(1065353216u);
				float fragment_unnamed_1237 = asfloat(1065353216u);
				float fragment_unnamed_1238 = asfloat(0u);
				float fragment_unnamed_1239 = asfloat(0u);
				float fragment_unnamed_1240 = asfloat(0u);
				float fragment_unnamed_1241 = asfloat(0u);
				float fragment_unnamed_1242 = asfloat(0u);
				float fragment_unnamed_1243 = asfloat(0u);
				float fragment_unnamed_1244 = asfloat(0u);
				float fragment_unnamed_1264;
				float fragment_unnamed_1266;
				float fragment_unnamed_1268;
				float fragment_unnamed_1270;
				float fragment_unnamed_1272;
				float fragment_unnamed_1274;
				float fragment_unnamed_1276;
				for (;;)
				{
					fragment_unnamed_1264 = fragment_unnamed_1244;
					fragment_unnamed_1266 = fragment_unnamed_1238;
					fragment_unnamed_1268 = fragment_unnamed_1239;
					fragment_unnamed_1270 = fragment_unnamed_1240;
					fragment_unnamed_1272 = fragment_unnamed_1241;
					fragment_unnamed_1274 = fragment_unnamed_1242;
					fragment_unnamed_1276 = fragment_unnamed_1243;
					float fragment_unnamed_1265;
					float fragment_unnamed_1267;
					float fragment_unnamed_1269;
					float fragment_unnamed_1271;
					float fragment_unnamed_1273;
					float fragment_unnamed_1275;
					float fragment_unnamed_1277;
					bool ladder_phi_21;
					for (;;)
					{
						if (asuint(fragment_unnamed_1264) >= fragment_unnamed_1207)
						{
							ladder_phi_21 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_1375 = asuint(fragment_unnamed_1264);
							uint4 fragment_unnamed_1377 = T2.Load(fragment_unnamed_1205 + fragment_unnamed_1375);
							uint fragment_unnamed_1378 = fragment_unnamed_1377.x;
							if (fragment_unnamed_1378 == 4294967295u)
							{
								ladder_phi_21 = false;
								break;
							}
							uint fragment_unnamed_1567 = fragment_unnamed_1378 * 56u;
							uint4 fragment_unnamed_1580 = uint4(T6.Load(fragment_unnamed_1567).x, T6.Load(fragment_unnamed_1567 + 1u).x, T6.Load(fragment_unnamed_1567 + 2u).x, T6.Load(fragment_unnamed_1567 + 3u).x);
							fragment_unnamed_1265 = asfloat(asuint(fragment_unnamed_1264) + 1u);
							if (!((fragment_unnamed_472 & fragment_unnamed_1580.w) != 0u))
							{
								fragment_unnamed_1267 = fragment_unnamed_1266;
								fragment_unnamed_1269 = fragment_unnamed_1268;
								fragment_unnamed_1271 = fragment_unnamed_1270;
								fragment_unnamed_1273 = fragment_unnamed_1272;
								fragment_unnamed_1275 = fragment_unnamed_1274;
								fragment_unnamed_1277 = fragment_unnamed_1276;
								fragment_unnamed_1264 = fragment_unnamed_1265;
								fragment_unnamed_1266 = fragment_unnamed_1267;
								fragment_unnamed_1268 = fragment_unnamed_1269;
								fragment_unnamed_1270 = fragment_unnamed_1271;
								fragment_unnamed_1272 = fragment_unnamed_1273;
								fragment_unnamed_1274 = fragment_unnamed_1275;
								fragment_unnamed_1276 = fragment_unnamed_1277;
								continue;
							}
							uint fragment_unnamed_1861 = (fragment_unnamed_1378 * 56u) + 6u;
							uint4 fragment_unnamed_1873 = uint4(T6.Load(fragment_unnamed_1861).x, T6.Load(fragment_unnamed_1861 + 1u).x, T6.Load(fragment_unnamed_1861 + 2u).x, T6.Load(fragment_unnamed_1861 + 3u).x);
							uint fragment_unnamed_1881 = (fragment_unnamed_1378 * 56u) + 10u;
							uint4 fragment_unnamed_1893 = uint4(T6.Load(fragment_unnamed_1881).x, T6.Load(fragment_unnamed_1881 + 1u).x, T6.Load(fragment_unnamed_1881 + 2u).x, T6.Load(fragment_unnamed_1881 + 3u).x);
							float fragment_unnamed_1896 = asfloat(fragment_unnamed_1893.y);
							uint fragment_unnamed_1897 = fragment_unnamed_1893.z;
							float fragment_unnamed_1908 = ((-0.0f) - asfloat(fragment_unnamed_1580.x)) + fragment_input_6.x;
							float fragment_unnamed_1909 = ((-0.0f) - asfloat(fragment_unnamed_1580.y)) + fragment_input_6.y;
							float fragment_unnamed_1910 = ((-0.0f) - asfloat(fragment_unnamed_1580.z)) + fragment_input_6.z;
							bool fragment_unnamed_1911 = fragment_unnamed_1897 == 4u;
							float fragment_unnamed_1912 = asfloat(fragment_unnamed_1873.z);
							float fragment_unnamed_1913 = asfloat(fragment_unnamed_1873.w);
							float fragment_unnamed_1914 = asfloat(fragment_unnamed_1893.x);
							float fragment_unnamed_1921 = dot(float3((-0.0f) - fragment_unnamed_1908, (-0.0f) - fragment_unnamed_1909, (-0.0f) - fragment_unnamed_1910), float3((-0.0f) - fragment_unnamed_1908, (-0.0f) - fragment_unnamed_1909, (-0.0f) - fragment_unnamed_1910));
							float fragment_unnamed_1924 = rsqrt(fragment_unnamed_1921);
							float fragment_unnamed_1934 = fragment_unnamed_1911 ? ((-0.0f) - fragment_unnamed_1912) : (fragment_unnamed_1924 * ((-0.0f) - fragment_unnamed_1908));
							float fragment_unnamed_1935 = fragment_unnamed_1911 ? ((-0.0f) - fragment_unnamed_1913) : (fragment_unnamed_1924 * ((-0.0f) - fragment_unnamed_1909));
							float fragment_unnamed_1936 = fragment_unnamed_1911 ? ((-0.0f) - fragment_unnamed_1914) : (fragment_unnamed_1924 * ((-0.0f) - fragment_unnamed_1910));
							float fragment_unnamed_1939 = dot(float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466), float3(fragment_unnamed_1934, fragment_unnamed_1935, fragment_unnamed_1936));
							float fragment_unnamed_2670;
							float fragment_unnamed_2672;
							float fragment_unnamed_2674;
							float fragment_unnamed_2676;
							float fragment_unnamed_2678;
							float fragment_unnamed_2680;
							if ((((0.0f < asfloat(T6.Load((fragment_unnamed_1378 * 56u) + 4u).x)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1939) ? 4294967295u : 0u)) != 0u)
							{
								uint fragment_unnamed_2318 = (fragment_unnamed_1378 * 56u) + 14u;
								uint4 fragment_unnamed_2330 = uint4(T6.Load(fragment_unnamed_2318).x, T6.Load(fragment_unnamed_2318 + 1u).x, T6.Load(fragment_unnamed_2318 + 2u).x, T6.Load(fragment_unnamed_2318 + 3u).x);
								float fragment_unnamed_2334 = asfloat(fragment_unnamed_2330.z);
								float fragment_unnamed_2336 = asfloat(fragment_unnamed_2330.w);
								uint fragment_unnamed_2338 = (fragment_unnamed_1378 * 56u) + 18u;
								uint4 fragment_unnamed_2350 = uint4(T6.Load(fragment_unnamed_2338).x, T6.Load(fragment_unnamed_2338 + 1u).x, T6.Load(fragment_unnamed_2338 + 2u).x, T6.Load(fragment_unnamed_2338 + 3u).x);
								uint fragment_unnamed_2356 = fragment_unnamed_2350.y;
								uint fragment_unnamed_2358 = (fragment_unnamed_1378 * 56u) + 22u;
								uint4 fragment_unnamed_2370 = uint4(T6.Load(fragment_unnamed_2358).x, T6.Load(fragment_unnamed_2358 + 1u).x, T6.Load(fragment_unnamed_2358 + 2u).x, T6.Load(fragment_unnamed_2358 + 3u).x);
								uint fragment_unnamed_2373 = fragment_unnamed_2370.z;
								uint fragment_unnamed_2375 = fragment_unnamed_2370.w;
								uint fragment_unnamed_2379 = (fragment_unnamed_1378 * 56u) + 26u;
								uint4 fragment_unnamed_2391 = uint4(T6.Load(fragment_unnamed_2379).x, T6.Load(fragment_unnamed_2379 + 1u).x, T6.Load(fragment_unnamed_2379 + 2u).x, T6.Load(fragment_unnamed_2379 + 3u).x);
								float fragment_unnamed_2395 = asfloat(fragment_unnamed_2391.z);
								uint fragment_unnamed_2396 = fragment_unnamed_2391.x;
								float fragment_unnamed_2399 = asfloat(fragment_unnamed_2391.w);
								uint fragment_unnamed_2402 = (fragment_unnamed_1378 * 56u) + 30u;
								uint4 fragment_unnamed_2414 = uint4(T6.Load(fragment_unnamed_2402).x, T6.Load(fragment_unnamed_2402 + 1u).x, T6.Load(fragment_unnamed_2402 + 2u).x, T6.Load(fragment_unnamed_2402 + 3u).x);
								float fragment_unnamed_2416 = asfloat(fragment_unnamed_2414.x);
								float fragment_unnamed_2418 = asfloat(fragment_unnamed_2414.y);
								uint fragment_unnamed_2423 = (fragment_unnamed_1378 * 56u) + 34u;
								uint2 fragment_unnamed_2429 = uint2(T6.Load(fragment_unnamed_2423).x, T6.Load(fragment_unnamed_2423 + 1u).x);
								float fragment_unnamed_2431 = asfloat(fragment_unnamed_2429.x);
								float fragment_unnamed_2433 = asfloat(fragment_unnamed_2429.y);
								float fragment_unnamed_2439 = dot(float3(fragment_unnamed_1908, fragment_unnamed_1909, fragment_unnamed_1910), float3(fragment_unnamed_1912, fragment_unnamed_1913, fragment_unnamed_1914));
								uint fragment_unnamed_2451 = fragment_unnamed_1911 ? asuint(fragment_unnamed_2439) : asuint(fragment_unnamed_1924 * fragment_unnamed_1921);
								float fragment_unnamed_2452 = asfloat(fragment_unnamed_2451);
								float fragment_unnamed_2461 = asfloat(fragment_unnamed_2370.y) * asfloat(fragment_unnamed_1911 ? asuint(fragment_unnamed_2439 * fragment_unnamed_2439) : asuint(fragment_unnamed_1921));
								float fragment_unnamed_2468 = clamp(mad((1.0f / fragment_unnamed_2452) * fragment_unnamed_2439, asfloat(fragment_unnamed_1873.x), asfloat(fragment_unnamed_1873.y)), 0.0f, 1.0f) * (min(asfloat(fragment_unnamed_1911 ? 1065353216u : asuint(rsqrt(asfloat(T6.Load((fragment_unnamed_1378 * 56u) + 44u).x) + fragment_unnamed_1921))), 100.0f) * clamp(mad((-0.0f) - fragment_unnamed_2461, fragment_unnamed_2461, asfloat(fragment_unnamed_2391.y)), 0.0f, 1.0f));
								float fragment_unnamed_2475 = dot(float3(fragment_unnamed_1934, fragment_unnamed_1935, fragment_unnamed_1936), float3(fragment_uniform_buffer_1[83u].xyz));
								float fragment_unnamed_2479 = max(abs(fragment_unnamed_2475), 0.001000000047497451305389404296875f);
								float fragment_unnamed_2481 = 1.0f / fragment_unnamed_2479;
								float fragment_unnamed_2483 = min(fragment_unnamed_1220, mad(fragment_unnamed_2452, fragment_unnamed_2475, fragment_unnamed_1220));
								float fragment_unnamed_2497 = min(fragment_unnamed_2452, max(fragment_unnamed_2481 * (((-0.0f) - fragment_unnamed_2483) + fragment_uniform_buffer_1[89u].y), 0.0f));
								float fragment_unnamed_2530 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_2479 * ((-0.0f) - (((-0.0f) - fragment_unnamed_2497) + fragment_unnamed_2452))) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_2483 + ((-0.0f) - fragment_uniform_buffer_1[89u].y), 0.0f)) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f), fragment_unnamed_2481 * fragment_uniform_buffer_1[90u].y, fragment_unnamed_2497) * fragment_uniform_buffer_1[89u].x) * (-1.44269502162933349609375f)) * (fragment_unnamed_2468 * fragment_unnamed_2468);
								float fragment_unnamed_3353;
								float fragment_unnamed_3355;
								float fragment_unnamed_3357;
								float fragment_unnamed_3359;
								if (fragment_unnamed_2350.x != 0u)
								{
									float fragment_unnamed_2660 = dot(float3(fragment_unnamed_1908, fragment_unnamed_1909, fragment_unnamed_1910), float3(asfloat(fragment_unnamed_1893.w), asfloat(fragment_unnamed_2330.x), asfloat(fragment_unnamed_2330.y)));
									float fragment_unnamed_2664 = dot(float3(fragment_unnamed_1908, fragment_unnamed_1909, fragment_unnamed_1910), float3(asfloat(fragment_unnamed_2350.z), asfloat(fragment_unnamed_2350.w), asfloat(fragment_unnamed_2370.x)));
									float fragment_unnamed_3590;
									float fragment_unnamed_3591;
									float fragment_unnamed_3592;
									float fragment_unnamed_3593;
									if (fragment_unnamed_1897 == 1u)
									{
										float fragment_unnamed_3210 = 1.0f / max(dot(float3(abs(fragment_unnamed_2660), abs(fragment_unnamed_2664), abs(fragment_unnamed_2439)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
										float fragment_unnamed_3215 = clamp((-0.0f) - (fragment_unnamed_3210 * fragment_unnamed_2439), 0.0f, 1.0f);
										float fragment_unnamed_3218 = (-0.0f) - fragment_unnamed_3215;
										float fragment_unnamed_3232 = 1.0f / (fragment_unnamed_2395 + fragment_uniform_buffer_1[123u].y);
										float fragment_unnamed_3233 = 1.0f / (fragment_unnamed_2399 + fragment_uniform_buffer_1[123u].y);
										float fragment_unnamed_3245 = fragment_unnamed_2395 * fragment_uniform_buffer_1[123u].x;
										float fragment_unnamed_3246 = fragment_unnamed_2399 * fragment_uniform_buffer_1[123u].x;
										float fragment_unnamed_3249 = fragment_unnamed_1231 / (fragment_unnamed_3245 + fragment_unnamed_3245);
										float fragment_unnamed_3250 = fragment_unnamed_1231 / (fragment_unnamed_3246 + fragment_unnamed_3246);
										float4 fragment_unnamed_3264 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_3249) + 1.0f, max(fragment_unnamed_3249, mad(clamp(mad(mad(fragment_unnamed_2660, fragment_unnamed_3210, ((fragment_unnamed_3210 * fragment_unnamed_2660) >= 0.0f) ? fragment_unnamed_3215 : fragment_unnamed_3218), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_2395 * fragment_unnamed_3232, mad((-0.0f) - fragment_unnamed_3232, fragment_unnamed_2395, 1.0f) * 0.5f))), fragment_unnamed_2395, fragment_unnamed_2416), mad(min(((-0.0f) - fragment_unnamed_3250) + 1.0f, max(fragment_unnamed_3250, mad(clamp(mad(mad(fragment_unnamed_2664, fragment_unnamed_3210, ((fragment_unnamed_3210 * fragment_unnamed_2664) >= 0.0f) ? fragment_unnamed_3215 : fragment_unnamed_3218), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_2399 * fragment_unnamed_3233, mad((-0.0f) - fragment_unnamed_3233, fragment_unnamed_2399, 1.0f) * 0.5f))), fragment_unnamed_2399, fragment_unnamed_2418)), 0.0f);
										fragment_unnamed_3590 = fragment_unnamed_3264.x;
										fragment_unnamed_3591 = fragment_unnamed_3264.y;
										fragment_unnamed_3592 = fragment_unnamed_3264.z;
										fragment_unnamed_3593 = asfloat(1065353216u);
									}
									else
									{
										bool fragment_unnamed_3276 = fragment_unnamed_1897 != 4u;
										float fragment_unnamed_3282 = asfloat(fragment_unnamed_3276 ? asuint(fragment_unnamed_2439) : 1065353216u);
										float fragment_unnamed_3283 = fragment_unnamed_2660 / fragment_unnamed_3282;
										float fragment_unnamed_3284 = fragment_unnamed_2664 / fragment_unnamed_3282;
										uint fragment_unnamed_3296 = (asfloat(T6.Load((fragment_unnamed_1378 * 56u) + 55u).x) >= max(mad((-0.0f) - fragment_unnamed_2336, 0.5f, abs(mad((-0.0f) - fragment_unnamed_2336, 0.5f, fragment_unnamed_2439))) + 1.0f, max(abs(fragment_unnamed_3284), abs(fragment_unnamed_3283)))) ? 4294967295u : 0u;
										float fragment_unnamed_3314 = 1.0f / (fragment_unnamed_2395 + fragment_uniform_buffer_1[123u].y);
										float fragment_unnamed_3315 = 1.0f / (fragment_unnamed_2399 + fragment_uniform_buffer_1[123u].y);
										float fragment_unnamed_3327 = fragment_unnamed_2395 * fragment_uniform_buffer_1[123u].x;
										float fragment_unnamed_3328 = fragment_unnamed_2399 * fragment_uniform_buffer_1[123u].x;
										float fragment_unnamed_3331 = fragment_unnamed_1231 / (fragment_unnamed_3327 + fragment_unnamed_3327);
										float fragment_unnamed_3332 = fragment_unnamed_1231 / (fragment_unnamed_3328 + fragment_unnamed_3328);
										float4 fragment_unnamed_3346 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_3331) + 1.0f, max(fragment_unnamed_3331, mad(mad(fragment_unnamed_3283, 0.5f, 0.5f), fragment_unnamed_2395 * fragment_unnamed_3314, mad((-0.0f) - fragment_unnamed_3314, fragment_unnamed_2395, 1.0f) * 0.5f))), fragment_unnamed_2395, fragment_unnamed_2416), mad(min(((-0.0f) - fragment_unnamed_3332) + 1.0f, max(fragment_unnamed_3332, mad(mad(fragment_unnamed_3284, 0.5f, 0.5f), fragment_unnamed_2399 * fragment_unnamed_3315, mad((-0.0f) - fragment_unnamed_3315, fragment_unnamed_2399, 1.0f) * 0.5f))), fragment_unnamed_2399, fragment_unnamed_2418)), 0.0f);
										fragment_unnamed_3590 = fragment_unnamed_3346.x;
										fragment_unnamed_3591 = fragment_unnamed_3346.y;
										fragment_unnamed_3592 = fragment_unnamed_3346.z;
										fragment_unnamed_3593 = asfloat(((((fragment_unnamed_3276 ? 4294967295u : 0u) & ((fragment_unnamed_1897 != 3u) ? 4294967295u : 0u)) != 0u) ? ((((fragment_unnamed_1896 * fragment_unnamed_1896) >= dot(float2(fragment_unnamed_3283, fragment_unnamed_3284), float2(fragment_unnamed_3283, fragment_unnamed_3284))) ? 4294967295u : 0u) & fragment_unnamed_3296) : fragment_unnamed_3296) & 1065353216u);
									}
									fragment_unnamed_3353 = fragment_unnamed_3593 * fragment_unnamed_2530;
									fragment_unnamed_3355 = fragment_unnamed_3590 * asfloat(fragment_unnamed_2373);
									fragment_unnamed_3357 = fragment_unnamed_3591 * asfloat(fragment_unnamed_2375);
									fragment_unnamed_3359 = fragment_unnamed_3592 * asfloat(fragment_unnamed_2396);
								}
								else
								{
									fragment_unnamed_3353 = fragment_unnamed_2530;
									fragment_unnamed_3355 = asfloat(fragment_unnamed_2373);
									fragment_unnamed_3357 = asfloat(fragment_unnamed_2375);
									fragment_unnamed_3359 = asfloat(fragment_unnamed_2396);
								}
								float fragment_unnamed_4392;
								if ((((0.0f < fragment_unnamed_2433) ? 4294967295u : 0u) & ((int(fragment_unnamed_2356) >= int(0u)) ? 4294967295u : 0u)) != 0u)
								{
									bool fragment_unnamed_3596 = fragment_unnamed_1897 != 4u;
									uint fragment_unnamed_3597 = fragment_unnamed_3596 ? 4294967295u : 0u;
									float fragment_unnamed_3603 = asfloat((dot(float3(fragment_unnamed_241, fragment_unnamed_242, fragment_unnamed_243), float3(fragment_unnamed_1934, fragment_unnamed_1935, fragment_unnamed_1936)) >= 0.0f) ? 1065353216u : 3212836864u);
									float fragment_unnamed_3604 = fragment_unnamed_241 * fragment_unnamed_3603;
									float fragment_unnamed_3605 = fragment_unnamed_242 * fragment_unnamed_3603;
									float fragment_unnamed_3606 = fragment_unnamed_243 * fragment_unnamed_3603;
									uint fragment_unnamed_3608 = (fragment_unnamed_2356 * 60u) + 8u;
									uint4 fragment_unnamed_3620 = uint4(T27.Load(fragment_unnamed_3608).x, T27.Load(fragment_unnamed_3608 + 1u).x, T27.Load(fragment_unnamed_3608 + 2u).x, T27.Load(fragment_unnamed_3608 + 3u).x);
									uint fragment_unnamed_3622 = fragment_unnamed_3620.y;
									float fragment_unnamed_3623 = asfloat(fragment_unnamed_3622);
									uint fragment_unnamed_3624 = fragment_unnamed_3620.z;
									float fragment_unnamed_3625 = asfloat(fragment_unnamed_3624);
									uint fragment_unnamed_3626 = fragment_unnamed_3620.w;
									float fragment_unnamed_3627 = asfloat(fragment_unnamed_3626);
									uint fragment_unnamed_3629 = (fragment_unnamed_2356 * 60u) + 12u;
									uint4 fragment_unnamed_3641 = uint4(T27.Load(fragment_unnamed_3629).x, T27.Load(fragment_unnamed_3629 + 1u).x, T27.Load(fragment_unnamed_3629 + 2u).x, T27.Load(fragment_unnamed_3629 + 3u).x);
									float fragment_unnamed_3643 = asfloat(fragment_unnamed_3641.x);
									float fragment_unnamed_3645 = asfloat(fragment_unnamed_3641.y);
									float fragment_unnamed_3647 = asfloat(fragment_unnamed_3641.z);
									float fragment_unnamed_3649 = asfloat(fragment_unnamed_3641.w);
									uint fragment_unnamed_3651 = (fragment_unnamed_2356 * 60u) + 16u;
									uint4 fragment_unnamed_3663 = uint4(T27.Load(fragment_unnamed_3651).x, T27.Load(fragment_unnamed_3651 + 1u).x, T27.Load(fragment_unnamed_3651 + 2u).x, T27.Load(fragment_unnamed_3651 + 3u).x);
									float fragment_unnamed_3669 = asfloat(fragment_unnamed_3663.z);
									float fragment_unnamed_3671 = asfloat(fragment_unnamed_3663.w);
									uint fragment_unnamed_3673 = (fragment_unnamed_2356 * 60u) + 24u;
									uint2 fragment_unnamed_3679 = uint2(T27.Load(fragment_unnamed_3673).x, T27.Load(fragment_unnamed_3673 + 1u).x);
									float fragment_unnamed_3681 = asfloat(fragment_unnamed_3679.x);
									float fragment_unnamed_3683 = asfloat(fragment_unnamed_3679.y);
									uint fragment_unnamed_3685 = (fragment_unnamed_2356 * 60u) + 40u;
									uint4 fragment_unnamed_3697 = uint4(T27.Load(fragment_unnamed_3685).x, T27.Load(fragment_unnamed_3685 + 1u).x, T27.Load(fragment_unnamed_3685 + 2u).x, T27.Load(fragment_unnamed_3685 + 3u).x);
									float fragment_unnamed_3699 = asfloat(fragment_unnamed_3697.x);
									float fragment_unnamed_3701 = asfloat(fragment_unnamed_3697.y);
									float fragment_unnamed_3703 = asfloat(fragment_unnamed_3697.z);
									float fragment_unnamed_3705 = asfloat(fragment_unnamed_3697.w);
									float fragment_unnamed_4796;
									float fragment_unnamed_4797;
									float fragment_unnamed_4798;
									float fragment_unnamed_4799;
									float fragment_unnamed_4800;
									float fragment_unnamed_4801;
									float fragment_unnamed_4802;
									float fragment_unnamed_4803;
									float fragment_unnamed_4804;
									float fragment_unnamed_4805;
									float fragment_unnamed_4806;
									if (fragment_unnamed_1897 == 1u)
									{
										float fragment_unnamed_4256 = abs(fragment_unnamed_1936);
										float fragment_unnamed_4258 = abs(fragment_unnamed_1934);
										uint fragment_unnamed_4285 = uint(asfloat(((((fragment_unnamed_4256 >= abs(fragment_unnamed_1935)) ? 4294967295u : 0u) & ((fragment_unnamed_4256 >= fragment_unnamed_4258) ? 4294967295u : 0u)) != 0u) ? ((((-0.0f) - fragment_unnamed_1936) < 0.0f) ? 1084227584u : 1082130432u) : ((abs(fragment_unnamed_1935) >= fragment_unnamed_4258) ? ((((-0.0f) - fragment_unnamed_1935) < 0.0f) ? 1077936128u : 1073741824u) : (((((-0.0f) - fragment_unnamed_1934) < 0.0f) ? 4294967295u : 0u) & 1065353216u))) + float(int(fragment_unnamed_2356)));
										uint fragment_unnamed_4286 = fragment_unnamed_4285 * 60u;
										uint3 fragment_unnamed_4295 = uint3(T27.Load(fragment_unnamed_4286).x, T27.Load(fragment_unnamed_4286 + 1u).x, T27.Load(fragment_unnamed_4286 + 2u).x);
										uint fragment_unnamed_4303 = (fragment_unnamed_4285 * 60u) + 3u;
										uint3 fragment_unnamed_4312 = uint3(T27.Load(fragment_unnamed_4303).x, T27.Load(fragment_unnamed_4303 + 1u).x, T27.Load(fragment_unnamed_4303 + 2u).x);
										uint fragment_unnamed_4320 = (fragment_unnamed_4285 * 60u) + 6u;
										uint3 fragment_unnamed_4329 = uint3(T27.Load(fragment_unnamed_4320).x, T27.Load(fragment_unnamed_4320 + 1u).x, T27.Load(fragment_unnamed_4320 + 2u).x);
										uint fragment_unnamed_4337 = (fragment_unnamed_4285 * 60u) + 16u;
										uint2 fragment_unnamed_4343 = uint2(T27.Load(fragment_unnamed_4337).x, T27.Load(fragment_unnamed_4337 + 1u).x);
										fragment_unnamed_4796 = asfloat(fragment_unnamed_4343.x);
										fragment_unnamed_4797 = asfloat(fragment_unnamed_4343.y);
										fragment_unnamed_4798 = asfloat(fragment_unnamed_4295.x);
										fragment_unnamed_4799 = asfloat(fragment_unnamed_4295.y);
										fragment_unnamed_4800 = asfloat(fragment_unnamed_4295.z);
										fragment_unnamed_4801 = asfloat(fragment_unnamed_4312.x);
										fragment_unnamed_4802 = asfloat(fragment_unnamed_4312.y);
										fragment_unnamed_4803 = asfloat(fragment_unnamed_4312.z);
										fragment_unnamed_4804 = asfloat(fragment_unnamed_4329.x);
										fragment_unnamed_4805 = asfloat(fragment_unnamed_4329.y);
										fragment_unnamed_4806 = asfloat(fragment_unnamed_4329.z);
									}
									else
									{
										uint fragment_unnamed_4348 = fragment_unnamed_2356 * 60u;
										uint4 fragment_unnamed_4360 = uint4(T27.Load(fragment_unnamed_4348).x, T27.Load(fragment_unnamed_4348 + 1u).x, T27.Load(fragment_unnamed_4348 + 2u).x, T27.Load(fragment_unnamed_4348 + 3u).x);
										uint fragment_unnamed_4367 = (fragment_unnamed_2356 * 60u) + 4u;
										uint4 fragment_unnamed_4379 = uint4(T27.Load(fragment_unnamed_4367).x, T27.Load(fragment_unnamed_4367 + 1u).x, T27.Load(fragment_unnamed_4367 + 2u).x, T27.Load(fragment_unnamed_4367 + 3u).x);
										fragment_unnamed_4796 = asfloat(fragment_unnamed_3663.x);
										fragment_unnamed_4797 = asfloat(fragment_unnamed_3663.y);
										fragment_unnamed_4798 = asfloat(fragment_unnamed_4360.x);
										fragment_unnamed_4799 = asfloat(fragment_unnamed_4360.y);
										fragment_unnamed_4800 = asfloat(fragment_unnamed_4360.z);
										fragment_unnamed_4801 = asfloat(fragment_unnamed_4360.w);
										fragment_unnamed_4802 = asfloat(fragment_unnamed_4379.x);
										fragment_unnamed_4803 = asfloat(fragment_unnamed_4379.y);
										fragment_unnamed_4804 = asfloat(fragment_unnamed_4379.z);
										fragment_unnamed_4805 = asfloat(fragment_unnamed_4379.w);
										fragment_unnamed_4806 = asfloat(fragment_unnamed_3620.x);
									}
									float fragment_unnamed_7618;
									if (0.0f < fragment_unnamed_3705)
									{
										bool fragment_unnamed_5452 = 0.0f != fragment_unnamed_3705;
										uint4 fragment_unnamed_5456 = asuint(fragment_uniform_buffer_1[100u]);
										uint4 fragment_unnamed_5462 = asuint(fragment_uniform_buffer_1[97u]);
										float fragment_unnamed_5466 = asfloat(fragment_unnamed_5452 ? fragment_unnamed_5456.z : fragment_unnamed_5462.z);
										float fragment_unnamed_5468 = asfloat(fragment_unnamed_5452 ? fragment_unnamed_5456.w : fragment_unnamed_5462.w);
										float fragment_unnamed_5470 = asfloat(fragment_unnamed_3596 ? fragment_unnamed_2451 : 1065353216u);
										float fragment_unnamed_5486 = mad(fragment_unnamed_3669 * (fragment_unnamed_3604 * fragment_unnamed_3671), fragment_unnamed_5470, fragment_unnamed_3699 + fragment_input_6.x);
										float fragment_unnamed_5487 = mad(fragment_unnamed_3669 * (fragment_unnamed_3605 * fragment_unnamed_3671), fragment_unnamed_5470, fragment_unnamed_3701 + fragment_input_6.y);
										float fragment_unnamed_5488 = mad(fragment_unnamed_3669 * (fragment_unnamed_3606 * fragment_unnamed_3671), fragment_unnamed_5470, fragment_unnamed_3703 + fragment_input_6.z);
										float fragment_unnamed_5492 = ((-0.0f) - fragment_unnamed_3623) + fragment_unnamed_5486;
										float fragment_unnamed_5493 = ((-0.0f) - fragment_unnamed_3625) + fragment_unnamed_5487;
										float fragment_unnamed_5494 = ((-0.0f) - fragment_unnamed_3627) + fragment_unnamed_5488;
										float fragment_unnamed_5527 = asfloat(fragment_unnamed_3596 ? asuint(dot(float3(fragment_unnamed_4804, fragment_unnamed_4805, fragment_unnamed_4806), float3(fragment_unnamed_5492, fragment_unnamed_5493, fragment_unnamed_5494))) : asuint(dot(float4(fragment_unnamed_4804, fragment_unnamed_4805, fragment_unnamed_4806, asfloat(fragment_unnamed_3626)), float4(fragment_unnamed_5486, fragment_unnamed_5487, fragment_unnamed_5488, fragment_unnamed_1234))));
										float fragment_unnamed_5532 = asfloat(fragment_unnamed_3596 ? asuint(dot(float3(fragment_unnamed_4798, fragment_unnamed_4799, fragment_unnamed_4800), float3(fragment_unnamed_5492, fragment_unnamed_5493, fragment_unnamed_5494))) : asuint(dot(float4(fragment_unnamed_4798, fragment_unnamed_4799, fragment_unnamed_4800, asfloat(fragment_unnamed_3622)), float4(fragment_unnamed_5486, fragment_unnamed_5487, fragment_unnamed_5488, fragment_unnamed_1234)))) * fragment_unnamed_3643;
										float fragment_unnamed_5533 = asfloat(fragment_unnamed_3596 ? asuint(dot(float3(fragment_unnamed_4801, fragment_unnamed_4802, fragment_unnamed_4803), float3(fragment_unnamed_5492, fragment_unnamed_5493, fragment_unnamed_5494))) : asuint(dot(float4(fragment_unnamed_4801, fragment_unnamed_4802, fragment_unnamed_4803, asfloat(fragment_unnamed_3624)), float4(fragment_unnamed_5486, fragment_unnamed_5487, fragment_unnamed_5488, fragment_unnamed_1234)))) * fragment_unnamed_3645;
										float fragment_unnamed_5534 = dot(float2(fragment_unnamed_3647, fragment_unnamed_3649), float2(fragment_unnamed_5527, fragment_unnamed_1235));
										float fragment_unnamed_5537 = dot(float2(asfloat(fragment_unnamed_3596 ? 3212836864u : 0u), asfloat(fragment_unnamed_3596 ? 0u : 1065353216u)), float2(fragment_unnamed_5527, fragment_unnamed_1235));
										bool fragment_unnamed_5546 = (fragment_unnamed_3597 & ((fragment_unnamed_5537 != 0.0f) ? 4294967295u : 0u)) != 0u;
										float fragment_unnamed_5565 = mad(fragment_unnamed_3681 * clamp(mad(asfloat(fragment_unnamed_5546 ? asuint(fragment_unnamed_5532 / fragment_unnamed_5537) : asuint(fragment_unnamed_5532)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5466, fragment_unnamed_4796);
										float fragment_unnamed_5566 = mad(fragment_unnamed_3683 * clamp(mad(asfloat(fragment_unnamed_5546 ? asuint(fragment_unnamed_5533 / fragment_unnamed_5537) : asuint(fragment_unnamed_5533)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5468, fragment_unnamed_4797);
										uint4 fragment_unnamed_5586 = asuint(fragment_uniform_buffer_1[100u]);
										uint4 fragment_unnamed_5593 = asuint(fragment_uniform_buffer_1[97u]);
										float fragment_unnamed_5599 = asfloat(fragment_unnamed_5452 ? fragment_unnamed_5586.z : fragment_unnamed_5593.z);
										float fragment_unnamed_5601 = asfloat(fragment_unnamed_5452 ? fragment_unnamed_5586.w : fragment_unnamed_5593.w);
										float fragment_unnamed_5603 = asfloat(fragment_unnamed_5452 ? fragment_unnamed_5586.x : fragment_unnamed_5593.x);
										float fragment_unnamed_5605 = asfloat(fragment_unnamed_5452 ? fragment_unnamed_5586.y : fragment_unnamed_5593.y);
										float fragment_unnamed_5606 = asfloat(fragment_unnamed_5546 ? asuint(fragment_unnamed_5534 / fragment_unnamed_5537) : asuint(fragment_unnamed_5534)) + 1.52587890625e-05f;
										float fragment_unnamed_5609 = floor(mad(fragment_unnamed_5565, fragment_unnamed_5603, 0.5f));
										float fragment_unnamed_5610 = floor(mad(fragment_unnamed_5566, fragment_unnamed_5605, 0.5f));
										float fragment_unnamed_5613 = mad(fragment_unnamed_5565, fragment_unnamed_5603, (-0.0f) - fragment_unnamed_5609);
										float fragment_unnamed_5614 = mad(fragment_unnamed_5566, fragment_unnamed_5605, (-0.0f) - fragment_unnamed_5610);
										float fragment_unnamed_5615 = fragment_unnamed_5613 + 0.5f;
										float fragment_unnamed_5616 = fragment_unnamed_5613 + 1.0f;
										float fragment_unnamed_5617 = fragment_unnamed_5614 + 0.5f;
										float fragment_unnamed_5618 = fragment_unnamed_5614 + 1.0f;
										float fragment_unnamed_5623 = (fragment_unnamed_5615 * fragment_unnamed_5615) * 0.07999999821186065673828125f;
										float fragment_unnamed_5625 = (fragment_unnamed_5617 * fragment_unnamed_5617) * 0.07999999821186065673828125f;
										float fragment_unnamed_5632 = ((-0.0f) - fragment_unnamed_5613) + 1.0f;
										float fragment_unnamed_5633 = ((-0.0f) - fragment_unnamed_5614) + 1.0f;
										float fragment_unnamed_5634 = min(fragment_unnamed_5613, 0.0f);
										float fragment_unnamed_5635 = min(fragment_unnamed_5614, 0.0f);
										float fragment_unnamed_5640 = max(fragment_unnamed_5613, 0.0f);
										float fragment_unnamed_5641 = max(fragment_unnamed_5614, 0.0f);
										float fragment_unnamed_5653 = fragment_unnamed_5632 * 0.1599999964237213134765625f;
										float fragment_unnamed_5654 = fragment_unnamed_5633 * 0.1599999964237213134765625f;
										float fragment_unnamed_5655 = (mad((-0.0f) - fragment_unnamed_5634, fragment_unnamed_5634, fragment_unnamed_5632) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5657 = (mad((-0.0f) - fragment_unnamed_5640, fragment_unnamed_5640, fragment_unnamed_5616) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5658 = (mad((-0.0f) - fragment_unnamed_5641, fragment_unnamed_5641, fragment_unnamed_5618) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5662 = (fragment_unnamed_5616 * 0.1599999964237213134765625f) + fragment_unnamed_5623;
										float fragment_unnamed_5663 = (mad(fragment_unnamed_5615 * fragment_unnamed_5615, 0.5f, (-0.0f) - fragment_unnamed_5613) * 0.1599999964237213134765625f) + fragment_unnamed_5653;
										float fragment_unnamed_5664 = fragment_unnamed_5655 + fragment_unnamed_5657;
										float fragment_unnamed_5665 = (mad(fragment_unnamed_5617 * fragment_unnamed_5617, 0.5f, (-0.0f) - fragment_unnamed_5614) * 0.1599999964237213134765625f) + fragment_unnamed_5654;
										float fragment_unnamed_5666 = ((mad((-0.0f) - fragment_unnamed_5635, fragment_unnamed_5635, fragment_unnamed_5633) + 1.0f) * 0.1599999964237213134765625f) + fragment_unnamed_5658;
										float fragment_unnamed_5667 = (fragment_unnamed_5618 * 0.1599999964237213134765625f) + fragment_unnamed_5625;
										float fragment_unnamed_5680 = fragment_unnamed_5599 * ((fragment_unnamed_5657 / fragment_unnamed_5664) + (-0.5f));
										float fragment_unnamed_5681 = fragment_unnamed_5599 * ((fragment_unnamed_5653 / fragment_unnamed_5663) + (-2.5f));
										float fragment_unnamed_5682 = fragment_unnamed_5599 * ((fragment_unnamed_5623 / fragment_unnamed_5662) + 1.5f);
										float fragment_unnamed_5683 = fragment_unnamed_5601 * ((fragment_unnamed_5654 / fragment_unnamed_5665) + (-2.5f));
										float fragment_unnamed_5684 = fragment_unnamed_5601 * ((fragment_unnamed_5658 / fragment_unnamed_5666) + (-0.5f));
										float fragment_unnamed_5685 = fragment_unnamed_5601 * ((fragment_unnamed_5625 / fragment_unnamed_5667) + 1.5f);
										float fragment_unnamed_5704 = fragment_unnamed_5665 * fragment_unnamed_5663;
										float fragment_unnamed_5705 = fragment_unnamed_5665 * fragment_unnamed_5664;
										float fragment_unnamed_5706 = fragment_unnamed_5665 * fragment_unnamed_5662;
										float fragment_unnamed_5707 = fragment_unnamed_5666 * fragment_unnamed_5663;
										float fragment_unnamed_5708 = fragment_unnamed_5666 * (fragment_unnamed_5655 + fragment_unnamed_5657);
										float fragment_unnamed_5709 = fragment_unnamed_5666 * fragment_unnamed_5662;
										float fragment_unnamed_5710 = fragment_unnamed_5667 * fragment_unnamed_5663;
										float fragment_unnamed_5711 = fragment_unnamed_5667 * fragment_unnamed_5664;
										float4 fragment_unnamed_5716 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5609, fragment_unnamed_5599, fragment_unnamed_5681), mad(fragment_unnamed_5610, fragment_unnamed_5601, fragment_unnamed_5683)), fragment_unnamed_5606).xxxx;
										float fragment_unnamed_5717 = fragment_unnamed_5716.x;
										float4 fragment_unnamed_5720 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5609, fragment_unnamed_5599, fragment_unnamed_5680), mad(fragment_unnamed_5610, fragment_unnamed_5601, fragment_unnamed_5683)), fragment_unnamed_5606).xxxx;
										float fragment_unnamed_5721 = fragment_unnamed_5720.x;
										float4 fragment_unnamed_5724 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5609, fragment_unnamed_5599, fragment_unnamed_5682), mad(fragment_unnamed_5610, fragment_unnamed_5601, fragment_unnamed_5683)), fragment_unnamed_5606).xxxx;
										float fragment_unnamed_5725 = fragment_unnamed_5724.x;
										float4 fragment_unnamed_5728 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5609, fragment_unnamed_5599, fragment_unnamed_5681), mad(fragment_unnamed_5610, fragment_unnamed_5601, fragment_unnamed_5684)), fragment_unnamed_5606).xxxx;
										float fragment_unnamed_5729 = fragment_unnamed_5728.x;
										float fragment_unnamed_5731 = asfloat(0u);
										float fragment_unnamed_6150;
										fragment_unnamed_6150 = asfloat(0u);
										for (float fragment_unnamed_6152 = fragment_unnamed_5731; !(int(asuint(fragment_unnamed_6152)) >= int(1u)); fragment_unnamed_6150 = mad(fragment_unnamed_5707, fragment_unnamed_5729, mad(fragment_unnamed_5706, fragment_unnamed_5725, mad(fragment_unnamed_5705, fragment_unnamed_5721, mad(fragment_unnamed_5704, fragment_unnamed_5717, fragment_unnamed_6150)))), fragment_unnamed_6152 = asfloat(asuint(fragment_unnamed_6152) + 1u))
										{
										}
										float4 fragment_unnamed_6595 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5609, fragment_unnamed_5599, fragment_unnamed_5680), mad(fragment_unnamed_5610, fragment_unnamed_5601, fragment_unnamed_5684)), fragment_unnamed_5606).xxxx;
										float fragment_unnamed_6596 = fragment_unnamed_6595.x;
										float4 fragment_unnamed_6599 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5609, fragment_unnamed_5599, fragment_unnamed_5682), mad(fragment_unnamed_5610, fragment_unnamed_5601, fragment_unnamed_5684)), fragment_unnamed_5606).xxxx;
										float fragment_unnamed_6600 = fragment_unnamed_6599.x;
										float4 fragment_unnamed_6603 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5609, fragment_unnamed_5599, fragment_unnamed_5681), mad(fragment_unnamed_5610, fragment_unnamed_5601, fragment_unnamed_5685)), fragment_unnamed_5606).xxxx;
										float fragment_unnamed_6604 = fragment_unnamed_6603.x;
										float4 fragment_unnamed_6607 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5609, fragment_unnamed_5599, fragment_unnamed_5680), mad(fragment_unnamed_5610, fragment_unnamed_5601, fragment_unnamed_5685)), fragment_unnamed_5606).xxxx;
										float fragment_unnamed_6608 = fragment_unnamed_6607.x;
										float fragment_unnamed_6609 = asfloat(0u);
										float fragment_unnamed_7055;
										fragment_unnamed_7055 = fragment_unnamed_6150;
										float fragment_unnamed_7056;
										for (float fragment_unnamed_7057 = fragment_unnamed_6609; !(int(asuint(fragment_unnamed_7057)) >= int(1u)); fragment_unnamed_7056 = mad(fragment_unnamed_5711, fragment_unnamed_6608, mad(fragment_unnamed_5710, fragment_unnamed_6604, mad(fragment_unnamed_5709, fragment_unnamed_6600, mad(fragment_unnamed_5708, fragment_unnamed_6596, fragment_unnamed_7055)))), fragment_unnamed_7055 = fragment_unnamed_7056, fragment_unnamed_7057 = asfloat(asuint(fragment_unnamed_7057) + 1u))
										{
										}
										fragment_unnamed_7618 = asfloat((((((mad(fragment_unnamed_3683 + (-0.5f), fragment_unnamed_5468, fragment_unnamed_4797) < fragment_unnamed_5566) ? 4294967295u : 0u) | ((mad(fragment_unnamed_3681 + (-0.5f), fragment_unnamed_5466, fragment_unnamed_4796) < fragment_unnamed_5565) ? 4294967295u : 0u)) | (((fragment_unnamed_5566 < (fragment_unnamed_4797 + fragment_unnamed_5468)) ? 4294967295u : 0u) | ((fragment_unnamed_5565 < (fragment_unnamed_4796 + fragment_unnamed_5466)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(mad(fragment_unnamed_5667 * fragment_unnamed_5662, _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5609, fragment_unnamed_5599, fragment_unnamed_5682), mad(fragment_unnamed_5610, fragment_unnamed_5601, fragment_unnamed_5685)), fragment_unnamed_5606).xxxx.x, fragment_unnamed_7055)));
									}
									else
									{
										bool fragment_unnamed_5732 = 0.0f != fragment_unnamed_3705;
										uint4 fragment_unnamed_5735 = asuint(fragment_uniform_buffer_1[100u]);
										uint4 fragment_unnamed_5740 = asuint(fragment_uniform_buffer_1[97u]);
										float fragment_unnamed_5744 = asfloat(fragment_unnamed_5732 ? fragment_unnamed_5735.z : fragment_unnamed_5740.z);
										float fragment_unnamed_5746 = asfloat(fragment_unnamed_5732 ? fragment_unnamed_5735.w : fragment_unnamed_5740.w);
										float fragment_unnamed_5748 = asfloat(fragment_unnamed_3596 ? fragment_unnamed_2451 : 1065353216u);
										float fragment_unnamed_5764 = mad(fragment_unnamed_3669 * (fragment_unnamed_3604 * fragment_unnamed_3671), fragment_unnamed_5748, fragment_unnamed_3699 + fragment_input_6.x);
										float fragment_unnamed_5765 = mad(fragment_unnamed_3669 * (fragment_unnamed_3605 * fragment_unnamed_3671), fragment_unnamed_5748, fragment_unnamed_3701 + fragment_input_6.y);
										float fragment_unnamed_5766 = mad(fragment_unnamed_3669 * (fragment_unnamed_3606 * fragment_unnamed_3671), fragment_unnamed_5748, fragment_unnamed_3703 + fragment_input_6.z);
										float fragment_unnamed_5770 = ((-0.0f) - fragment_unnamed_3623) + fragment_unnamed_5764;
										float fragment_unnamed_5771 = ((-0.0f) - fragment_unnamed_3625) + fragment_unnamed_5765;
										float fragment_unnamed_5772 = ((-0.0f) - fragment_unnamed_3627) + fragment_unnamed_5766;
										float fragment_unnamed_5804 = asfloat(fragment_unnamed_3596 ? asuint(dot(float3(fragment_unnamed_4804, fragment_unnamed_4805, fragment_unnamed_4806), float3(fragment_unnamed_5770, fragment_unnamed_5771, fragment_unnamed_5772))) : asuint(dot(float4(fragment_unnamed_4804, fragment_unnamed_4805, fragment_unnamed_4806, fragment_unnamed_3627), float4(fragment_unnamed_5764, fragment_unnamed_5765, fragment_unnamed_5766, fragment_unnamed_1236))));
										float fragment_unnamed_5809 = asfloat(fragment_unnamed_3596 ? asuint(dot(float3(fragment_unnamed_4798, fragment_unnamed_4799, fragment_unnamed_4800), float3(fragment_unnamed_5770, fragment_unnamed_5771, fragment_unnamed_5772))) : asuint(dot(float4(fragment_unnamed_4798, fragment_unnamed_4799, fragment_unnamed_4800, asfloat(fragment_unnamed_3622)), float4(fragment_unnamed_5764, fragment_unnamed_5765, fragment_unnamed_5766, fragment_unnamed_1236)))) * fragment_unnamed_3643;
										float fragment_unnamed_5810 = asfloat(fragment_unnamed_3596 ? asuint(dot(float3(fragment_unnamed_4801, fragment_unnamed_4802, fragment_unnamed_4803), float3(fragment_unnamed_5770, fragment_unnamed_5771, fragment_unnamed_5772))) : asuint(dot(float4(fragment_unnamed_4801, fragment_unnamed_4802, fragment_unnamed_4803, asfloat(fragment_unnamed_3624)), float4(fragment_unnamed_5764, fragment_unnamed_5765, fragment_unnamed_5766, fragment_unnamed_1236)))) * fragment_unnamed_3645;
										float fragment_unnamed_5811 = dot(float2(fragment_unnamed_3647, fragment_unnamed_3649), float2(fragment_unnamed_5804, fragment_unnamed_1237));
										float fragment_unnamed_5814 = dot(float2(asfloat(fragment_unnamed_3596 ? 3212836864u : 0u), asfloat(fragment_unnamed_3596 ? 0u : 1065353216u)), float2(fragment_unnamed_5804, fragment_unnamed_1237));
										bool fragment_unnamed_5823 = (fragment_unnamed_3597 & ((fragment_unnamed_5814 != 0.0f) ? 4294967295u : 0u)) != 0u;
										float fragment_unnamed_5842 = mad(fragment_unnamed_3681 * clamp(mad(asfloat(fragment_unnamed_5823 ? asuint(fragment_unnamed_5809 / fragment_unnamed_5814) : asuint(fragment_unnamed_5809)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5744, fragment_unnamed_4796);
										float fragment_unnamed_5843 = mad(fragment_unnamed_3683 * clamp(mad(asfloat(fragment_unnamed_5823 ? asuint(fragment_unnamed_5810 / fragment_unnamed_5814) : asuint(fragment_unnamed_5810)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5746, fragment_unnamed_4797);
										uint4 fragment_unnamed_5863 = asuint(fragment_uniform_buffer_1[100u]);
										uint4 fragment_unnamed_5870 = asuint(fragment_uniform_buffer_1[97u]);
										float fragment_unnamed_5876 = asfloat(fragment_unnamed_5732 ? fragment_unnamed_5863.z : fragment_unnamed_5870.z);
										float fragment_unnamed_5878 = asfloat(fragment_unnamed_5732 ? fragment_unnamed_5863.w : fragment_unnamed_5870.w);
										float fragment_unnamed_5880 = asfloat(fragment_unnamed_5732 ? fragment_unnamed_5863.x : fragment_unnamed_5870.x);
										float fragment_unnamed_5882 = asfloat(fragment_unnamed_5732 ? fragment_unnamed_5863.y : fragment_unnamed_5870.y);
										float fragment_unnamed_5883 = asfloat(fragment_unnamed_5823 ? asuint(fragment_unnamed_5811 / fragment_unnamed_5814) : asuint(fragment_unnamed_5811)) + 1.52587890625e-05f;
										float fragment_unnamed_5886 = floor(mad(fragment_unnamed_5842, fragment_unnamed_5880, 0.5f));
										float fragment_unnamed_5887 = floor(mad(fragment_unnamed_5843, fragment_unnamed_5882, 0.5f));
										float fragment_unnamed_5890 = mad(fragment_unnamed_5842, fragment_unnamed_5880, (-0.0f) - fragment_unnamed_5886);
										float fragment_unnamed_5891 = mad(fragment_unnamed_5843, fragment_unnamed_5882, (-0.0f) - fragment_unnamed_5887);
										float fragment_unnamed_5892 = fragment_unnamed_5890 + 0.5f;
										float fragment_unnamed_5893 = fragment_unnamed_5890 + 1.0f;
										float fragment_unnamed_5894 = fragment_unnamed_5891 + 0.5f;
										float fragment_unnamed_5895 = fragment_unnamed_5891 + 1.0f;
										float fragment_unnamed_5900 = (fragment_unnamed_5892 * fragment_unnamed_5892) * 0.07999999821186065673828125f;
										float fragment_unnamed_5901 = (fragment_unnamed_5894 * fragment_unnamed_5894) * 0.07999999821186065673828125f;
										float fragment_unnamed_5908 = ((-0.0f) - fragment_unnamed_5890) + 1.0f;
										float fragment_unnamed_5909 = ((-0.0f) - fragment_unnamed_5891) + 1.0f;
										float fragment_unnamed_5910 = min(fragment_unnamed_5890, 0.0f);
										float fragment_unnamed_5911 = min(fragment_unnamed_5891, 0.0f);
										float fragment_unnamed_5916 = max(fragment_unnamed_5890, 0.0f);
										float fragment_unnamed_5917 = max(fragment_unnamed_5891, 0.0f);
										float fragment_unnamed_5928 = fragment_unnamed_5908 * 0.1599999964237213134765625f;
										float fragment_unnamed_5929 = fragment_unnamed_5909 * 0.1599999964237213134765625f;
										float fragment_unnamed_5930 = (mad((-0.0f) - fragment_unnamed_5910, fragment_unnamed_5910, fragment_unnamed_5908) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5932 = (mad((-0.0f) - fragment_unnamed_5916, fragment_unnamed_5916, fragment_unnamed_5893) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5933 = (mad((-0.0f) - fragment_unnamed_5917, fragment_unnamed_5917, fragment_unnamed_5895) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_5937 = (fragment_unnamed_5893 * 0.1599999964237213134765625f) + fragment_unnamed_5900;
										float fragment_unnamed_5938 = (mad(fragment_unnamed_5892 * fragment_unnamed_5892, 0.5f, (-0.0f) - fragment_unnamed_5890) * 0.1599999964237213134765625f) + fragment_unnamed_5928;
										float fragment_unnamed_5939 = fragment_unnamed_5930 + fragment_unnamed_5932;
										float fragment_unnamed_5940 = (mad(fragment_unnamed_5894 * fragment_unnamed_5894, 0.5f, (-0.0f) - fragment_unnamed_5891) * 0.1599999964237213134765625f) + fragment_unnamed_5929;
										float fragment_unnamed_5941 = ((mad((-0.0f) - fragment_unnamed_5911, fragment_unnamed_5911, fragment_unnamed_5909) + 1.0f) * 0.1599999964237213134765625f) + fragment_unnamed_5933;
										float fragment_unnamed_5942 = (fragment_unnamed_5895 * 0.1599999964237213134765625f) + fragment_unnamed_5901;
										float fragment_unnamed_5955 = fragment_unnamed_5876 * ((fragment_unnamed_5932 / fragment_unnamed_5939) + (-0.5f));
										float fragment_unnamed_5956 = fragment_unnamed_5876 * ((fragment_unnamed_5928 / fragment_unnamed_5938) + (-2.5f));
										float fragment_unnamed_5957 = fragment_unnamed_5876 * ((fragment_unnamed_5900 / fragment_unnamed_5937) + 1.5f);
										float fragment_unnamed_5958 = fragment_unnamed_5878 * ((fragment_unnamed_5929 / fragment_unnamed_5940) + (-2.5f));
										float fragment_unnamed_5959 = fragment_unnamed_5878 * ((fragment_unnamed_5933 / fragment_unnamed_5941) + (-0.5f));
										float fragment_unnamed_5960 = fragment_unnamed_5878 * ((fragment_unnamed_5901 / fragment_unnamed_5942) + 1.5f);
										float fragment_unnamed_5979 = fragment_unnamed_5940 * fragment_unnamed_5938;
										float fragment_unnamed_5980 = fragment_unnamed_5940 * fragment_unnamed_5939;
										float fragment_unnamed_5981 = fragment_unnamed_5940 * fragment_unnamed_5937;
										float fragment_unnamed_5982 = fragment_unnamed_5941 * fragment_unnamed_5938;
										float fragment_unnamed_5983 = fragment_unnamed_5941 * (fragment_unnamed_5930 + fragment_unnamed_5932);
										float fragment_unnamed_5984 = fragment_unnamed_5941 * fragment_unnamed_5937;
										float fragment_unnamed_5985 = fragment_unnamed_5942 * fragment_unnamed_5938;
										float fragment_unnamed_5986 = fragment_unnamed_5942 * fragment_unnamed_5939;
										float4 fragment_unnamed_5991 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5886, fragment_unnamed_5876, fragment_unnamed_5956), mad(fragment_unnamed_5887, fragment_unnamed_5878, fragment_unnamed_5958)), fragment_unnamed_5883).xxxx;
										float fragment_unnamed_5992 = fragment_unnamed_5991.x;
										float4 fragment_unnamed_5995 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5886, fragment_unnamed_5876, fragment_unnamed_5955), mad(fragment_unnamed_5887, fragment_unnamed_5878, fragment_unnamed_5958)), fragment_unnamed_5883).xxxx;
										float fragment_unnamed_5996 = fragment_unnamed_5995.x;
										float4 fragment_unnamed_5999 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5886, fragment_unnamed_5876, fragment_unnamed_5957), mad(fragment_unnamed_5887, fragment_unnamed_5878, fragment_unnamed_5958)), fragment_unnamed_5883).xxxx;
										float fragment_unnamed_6000 = fragment_unnamed_5999.x;
										float4 fragment_unnamed_6003 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5886, fragment_unnamed_5876, fragment_unnamed_5956), mad(fragment_unnamed_5887, fragment_unnamed_5878, fragment_unnamed_5959)), fragment_unnamed_5883).xxxx;
										float fragment_unnamed_6004 = fragment_unnamed_6003.x;
										float fragment_unnamed_6006 = asfloat(0u);
										float fragment_unnamed_6156;
										fragment_unnamed_6156 = asfloat(0u);
										for (float fragment_unnamed_6158 = fragment_unnamed_6006; !(int(asuint(fragment_unnamed_6158)) >= int(1u)); fragment_unnamed_6156 = mad(fragment_unnamed_5982, fragment_unnamed_6004, mad(fragment_unnamed_5981, fragment_unnamed_6000, mad(fragment_unnamed_5980, fragment_unnamed_5996, mad(fragment_unnamed_5979, fragment_unnamed_5992, fragment_unnamed_6156)))), fragment_unnamed_6158 = asfloat(asuint(fragment_unnamed_6158) + 1u))
										{
										}
										float4 fragment_unnamed_6618 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5886, fragment_unnamed_5876, fragment_unnamed_5955), mad(fragment_unnamed_5887, fragment_unnamed_5878, fragment_unnamed_5959)), fragment_unnamed_5883).xxxx;
										float fragment_unnamed_6619 = fragment_unnamed_6618.x;
										float4 fragment_unnamed_6622 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5886, fragment_unnamed_5876, fragment_unnamed_5957), mad(fragment_unnamed_5887, fragment_unnamed_5878, fragment_unnamed_5959)), fragment_unnamed_5883).xxxx;
										float fragment_unnamed_6623 = fragment_unnamed_6622.x;
										float4 fragment_unnamed_6626 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5886, fragment_unnamed_5876, fragment_unnamed_5956), mad(fragment_unnamed_5887, fragment_unnamed_5878, fragment_unnamed_5960)), fragment_unnamed_5883).xxxx;
										float fragment_unnamed_6627 = fragment_unnamed_6626.x;
										float4 fragment_unnamed_6630 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5886, fragment_unnamed_5876, fragment_unnamed_5955), mad(fragment_unnamed_5887, fragment_unnamed_5878, fragment_unnamed_5960)), fragment_unnamed_5883).xxxx;
										float fragment_unnamed_6631 = fragment_unnamed_6630.x;
										float fragment_unnamed_6632 = asfloat(0u);
										float fragment_unnamed_7061;
										fragment_unnamed_7061 = fragment_unnamed_6156;
										float fragment_unnamed_7062;
										for (float fragment_unnamed_7063 = fragment_unnamed_6632; !(int(asuint(fragment_unnamed_7063)) >= int(1u)); fragment_unnamed_7062 = mad(fragment_unnamed_5986, fragment_unnamed_6631, mad(fragment_unnamed_5985, fragment_unnamed_6627, mad(fragment_unnamed_5984, fragment_unnamed_6623, mad(fragment_unnamed_5983, fragment_unnamed_6619, fragment_unnamed_7061)))), fragment_unnamed_7061 = fragment_unnamed_7062, fragment_unnamed_7063 = asfloat(asuint(fragment_unnamed_7063) + 1u))
										{
										}
										fragment_unnamed_7618 = asfloat((((((mad(fragment_unnamed_3683 + (-0.5f), fragment_unnamed_5746, fragment_unnamed_4797) < fragment_unnamed_5843) ? 4294967295u : 0u) | ((mad(fragment_unnamed_3681 + (-0.5f), fragment_unnamed_5744, fragment_unnamed_4796) < fragment_unnamed_5842) ? 4294967295u : 0u)) | (((fragment_unnamed_5843 < (fragment_unnamed_5746 + fragment_unnamed_4797)) ? 4294967295u : 0u) | ((fragment_unnamed_5842 < (fragment_unnamed_5744 + fragment_unnamed_4796)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(mad(fragment_unnamed_5942 * fragment_unnamed_5937, _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5886, fragment_unnamed_5876, fragment_unnamed_5957), mad(fragment_unnamed_5887, fragment_unnamed_5878, fragment_unnamed_5960)), fragment_unnamed_5883).xxxx.x, fragment_unnamed_7061)));
									}
									fragment_unnamed_4392 = mad(fragment_unnamed_2433, fragment_unnamed_7618 + (-1.0f), 1.0f);
								}
								else
								{
									fragment_unnamed_4392 = asfloat(1065353216u);
								}
								float fragment_unnamed_4394 = asfloat(fragment_unnamed_2414.z);
								float fragment_unnamed_4395 = asfloat(fragment_unnamed_2414.w);
								float fragment_unnamed_4399 = ((-0.0f) - fragment_unnamed_4394) + 1.0f;
								float fragment_unnamed_4400 = ((-0.0f) - fragment_unnamed_4395) + 1.0f;
								float fragment_unnamed_4401 = ((-0.0f) - fragment_unnamed_2431) + 1.0f;
								float fragment_unnamed_4403 = fragment_unnamed_4392 * (fragment_unnamed_4392 * fragment_unnamed_4392);
								float fragment_unnamed_4406 = (-0.0f) - (((-0.0f) - fragment_unnamed_4392) + 1.0f);
								float fragment_unnamed_4407 = mad(fragment_unnamed_4406, fragment_unnamed_4399, 1.0f);
								float fragment_unnamed_4408 = mad(fragment_unnamed_4406, fragment_unnamed_4400, 1.0f);
								float fragment_unnamed_4409 = mad(fragment_unnamed_4406, fragment_unnamed_4401, 1.0f);
								float fragment_unnamed_4425 = (fragment_unnamed_3353 * fragment_unnamed_3355) * mad(fragment_unnamed_2334, ((-0.0f) - fragment_unnamed_4407) + mad(fragment_unnamed_4403, fragment_unnamed_4399, fragment_unnamed_4394 * fragment_unnamed_4392), fragment_unnamed_4407);
								float fragment_unnamed_4426 = (fragment_unnamed_3353 * fragment_unnamed_3357) * mad(fragment_unnamed_2334, ((-0.0f) - fragment_unnamed_4408) + mad(fragment_unnamed_4403, fragment_unnamed_4400, fragment_unnamed_4395 * fragment_unnamed_4392), fragment_unnamed_4408);
								float fragment_unnamed_4427 = (fragment_unnamed_3353 * fragment_unnamed_3359) * mad(fragment_unnamed_2334, ((-0.0f) - fragment_unnamed_4409) + mad(fragment_unnamed_4403, fragment_unnamed_4401, fragment_unnamed_2431 * fragment_unnamed_4392), fragment_unnamed_4409);
								float fragment_unnamed_2671;
								float fragment_unnamed_2673;
								float fragment_unnamed_2675;
								float fragment_unnamed_2677;
								float fragment_unnamed_2679;
								float fragment_unnamed_2681;
								if (0.0f < max(fragment_unnamed_4427, max(fragment_unnamed_4426, fragment_unnamed_4425)))
								{
									uint fragment_unnamed_4815 = (fragment_unnamed_1378 * 56u) + 49u;
									uint2 fragment_unnamed_4821 = uint2(T6.Load(fragment_unnamed_4815).x, T6.Load(fragment_unnamed_4815 + 1u).x);
									float fragment_unnamed_4823 = asfloat(fragment_unnamed_4821.x);
									float fragment_unnamed_4825 = asfloat(fragment_unnamed_4821.y);
									float fragment_unnamed_4826 = max(fragment_unnamed_848, asfloat(T6.Load((fragment_unnamed_1378 * 56u) + 38u).x));
									float fragment_unnamed_4827 = clamp(fragment_unnamed_1939, 0.0f, 1.0f);
									float fragment_unnamed_4828 = dot(float3(fragment_unnamed_1934, fragment_unnamed_1935, fragment_unnamed_1936), float3(fragment_unnamed_335, fragment_unnamed_336, fragment_unnamed_337));
									float fragment_unnamed_4833 = rsqrt(max(mad(fragment_unnamed_4828, 2.0f, 2.0f), 5.9604644775390625e-08f));
									float fragment_unnamed_4836 = clamp(fragment_unnamed_4833 * (fragment_unnamed_763 + fragment_unnamed_1939), 0.0f, 1.0f);
									float fragment_unnamed_4840 = ((-0.0f) - clamp(mad(fragment_unnamed_4833, fragment_unnamed_4828, fragment_unnamed_4833), 0.0f, 1.0f)) + 1.0f;
									float fragment_unnamed_4841 = fragment_unnamed_4840 * fragment_unnamed_4840;
									float fragment_unnamed_4842 = fragment_unnamed_4841 * fragment_unnamed_4841;
									float fragment_unnamed_4845 = mad((-0.0f) - fragment_unnamed_4842, fragment_unnamed_4840, 1.0f);
									float fragment_unnamed_4846 = fragment_unnamed_847 * (fragment_unnamed_4840 * fragment_unnamed_4842);
									float fragment_unnamed_4850 = fragment_unnamed_4826 * fragment_unnamed_4826;
									float fragment_unnamed_4853 = mad(mad(fragment_unnamed_4836, fragment_unnamed_4850, (-0.0f) - fragment_unnamed_4836), fragment_unnamed_4836, 1.0f);
									float fragment_unnamed_4869 = (fragment_unnamed_4850 * 0.15915493667125701904296875f) / max(mad(abs(fragment_unnamed_1939), fragment_unnamed_867, fragment_unnamed_766 * sqrt(mad(mad((-0.0f) - abs(fragment_unnamed_1939), fragment_unnamed_4850, abs(fragment_unnamed_1939)), abs(fragment_unnamed_1939), fragment_unnamed_4850))) * (fragment_unnamed_4853 * fragment_unnamed_4853), 1.1754943508222875079687365372222e-38f);
									float fragment_unnamed_4876 = ((-0.0f) - abs(fragment_unnamed_1939)) + 1.0f;
									float fragment_unnamed_4877 = fragment_unnamed_4876 * fragment_unnamed_4876;
									float fragment_unnamed_4880 = mad(fragment_unnamed_747, fragment_unnamed_4828, fragment_unnamed_747) + (-0.5f);
									float fragment_unnamed_4886 = ((mad(fragment_unnamed_4880, fragment_unnamed_1233, 1.0f) * mad(fragment_unnamed_4880, fragment_unnamed_4876 * (fragment_unnamed_4877 * fragment_unnamed_4877), 1.0f)) * fragment_unnamed_4827) * 0.307334959506988525390625f;
									fragment_unnamed_2671 = fragment_unnamed_4825 * (fragment_unnamed_4425 * (fragment_unnamed_4827 * (fragment_unnamed_4869 * mad(fragment_unnamed_759, fragment_unnamed_4845, fragment_unnamed_4846))));
									fragment_unnamed_2673 = fragment_unnamed_4825 * (fragment_unnamed_4426 * (fragment_unnamed_4827 * (fragment_unnamed_4869 * mad(fragment_unnamed_761, fragment_unnamed_4845, fragment_unnamed_4846))));
									fragment_unnamed_2675 = fragment_unnamed_4825 * (fragment_unnamed_4427 * (fragment_unnamed_4827 * (fragment_unnamed_4869 * mad(fragment_unnamed_762, fragment_unnamed_4845, fragment_unnamed_4846))));
									fragment_unnamed_2677 = fragment_unnamed_4823 * (fragment_unnamed_4425 * fragment_unnamed_4886);
									fragment_unnamed_2679 = fragment_unnamed_4823 * (fragment_unnamed_4426 * fragment_unnamed_4886);
									fragment_unnamed_2681 = fragment_unnamed_4823 * (fragment_unnamed_4427 * fragment_unnamed_4886);
								}
								else
								{
									fragment_unnamed_2671 = asfloat(0u);
									fragment_unnamed_2673 = asfloat(0u);
									fragment_unnamed_2675 = asfloat(0u);
									fragment_unnamed_2677 = asfloat(0u);
									fragment_unnamed_2679 = asfloat(0u);
									fragment_unnamed_2681 = asfloat(0u);
								}
								fragment_unnamed_2670 = fragment_unnamed_2671;
								fragment_unnamed_2672 = fragment_unnamed_2673;
								fragment_unnamed_2674 = fragment_unnamed_2675;
								fragment_unnamed_2676 = fragment_unnamed_2677;
								fragment_unnamed_2678 = fragment_unnamed_2679;
								fragment_unnamed_2680 = fragment_unnamed_2681;
							}
							else
							{
								fragment_unnamed_2670 = asfloat(0u);
								fragment_unnamed_2672 = asfloat(0u);
								fragment_unnamed_2674 = asfloat(0u);
								fragment_unnamed_2676 = asfloat(0u);
								fragment_unnamed_2678 = asfloat(0u);
								fragment_unnamed_2680 = asfloat(0u);
							}
							fragment_unnamed_1267 = fragment_unnamed_2676 + fragment_unnamed_1266;
							fragment_unnamed_1269 = fragment_unnamed_2678 + fragment_unnamed_1268;
							fragment_unnamed_1271 = fragment_unnamed_2680 + fragment_unnamed_1270;
							fragment_unnamed_1273 = fragment_unnamed_2670 + fragment_unnamed_1272;
							fragment_unnamed_1275 = fragment_unnamed_2672 + fragment_unnamed_1274;
							fragment_unnamed_1277 = fragment_unnamed_2674 + fragment_unnamed_1276;
							fragment_unnamed_1264 = fragment_unnamed_1265;
							fragment_unnamed_1266 = fragment_unnamed_1267;
							fragment_unnamed_1268 = fragment_unnamed_1269;
							fragment_unnamed_1270 = fragment_unnamed_1271;
							fragment_unnamed_1272 = fragment_unnamed_1273;
							fragment_unnamed_1274 = fragment_unnamed_1275;
							fragment_unnamed_1276 = fragment_unnamed_1277;
							continue;
						}
					}
					if (ladder_phi_21)
					{
						break;
					}
					break;
				}
				uint4 fragment_unnamed_1350 = asuint(fragment_uniform_buffer_1[128u]);
				uint fragment_unnamed_1351 = fragment_unnamed_1350.y;
				uint4 fragment_unnamed_1358 = asuint(fragment_uniform_buffer_1[128u]);
				uint fragment_unnamed_1359 = fragment_unnamed_1358.x;
				uint4 fragment_unnamed_1364 = T3.Load(((((fragment_unnamed_1190 + (2u << (fragment_unnamed_1152 & 31u))) * fragment_unnamed_1351) + fragment_unnamed_276) * fragment_unnamed_1359) + fragment_unnamed_274);
				uint fragment_unnamed_1365 = fragment_unnamed_1364.x;
				uint fragment_unnamed_1366 = fragment_unnamed_1365 & 67108863u;
				uint fragment_unnamed_1367 = fragment_unnamed_1365 >> 26u;
				float fragment_unnamed_1368 = asfloat(0u);
				float fragment_unnamed_1369 = asfloat(0u);
				float fragment_unnamed_1370 = asfloat(0u);
				float fragment_unnamed_1371 = asfloat(0u);
				float fragment_unnamed_1372 = asfloat(0u);
				float fragment_unnamed_1373 = asfloat(0u);
				float fragment_unnamed_1374 = asfloat(0u);
				float fragment_unnamed_1555;
				float fragment_unnamed_1557;
				float fragment_unnamed_1559;
				float fragment_unnamed_1561;
				float fragment_unnamed_1563;
				for (;;)
				{
					fragment_unnamed_1555 = fragment_unnamed_1373;
					fragment_unnamed_1557 = fragment_unnamed_1374;
					fragment_unnamed_1559 = fragment_unnamed_1370;
					fragment_unnamed_1561 = fragment_unnamed_1371;
					fragment_unnamed_1563 = fragment_unnamed_1372;
					float fragment_unnamed_1558;
					float fragment_unnamed_1556;
					float fragment_unnamed_1560;
					float fragment_unnamed_1562;
					float fragment_unnamed_1564;
					bool ladder_phi_33;
					for (;;)
					{
						if (asuint(fragment_unnamed_1557) >= fragment_unnamed_1367)
						{
							ladder_phi_33 = true;
							break;
						}
						else
						{
							uint4 fragment_unnamed_1851 = T2.Load(fragment_unnamed_1366 + asuint(fragment_unnamed_1557));
							uint fragment_unnamed_1852 = fragment_unnamed_1851.x;
							if (fragment_unnamed_1852 == 4294967295u)
							{
								ladder_phi_33 = false;
								break;
							}
							fragment_unnamed_1558 = asfloat(asuint(fragment_unnamed_1557) + 1u);
							if (fragment_unnamed_1555 < 1.0f)
							{
								uint fragment_unnamed_2633 = fragment_unnamed_1852 * 72u;
								uint4 fragment_unnamed_2646 = uint4(T7.Load(fragment_unnamed_2633).x, T7.Load(fragment_unnamed_2633 + 1u).x, T7.Load(fragment_unnamed_2633 + 2u).x, T7.Load(fragment_unnamed_2633 + 3u).x);
								float fragment_unnamed_2649 = asfloat(fragment_unnamed_2646.y);
								float fragment_unnamed_2651 = asfloat(fragment_unnamed_2646.z);
								float fragment_unnamed_2653 = asfloat(fragment_unnamed_2646.w);
								float fragment_unnamed_3194;
								float fragment_unnamed_3196;
								float fragment_unnamed_3198;
								float fragment_unnamed_3200;
								if ((fragment_unnamed_472 & fragment_unnamed_2646.x) != 0u)
								{
									uint fragment_unnamed_2834 = (fragment_unnamed_1852 * 72u) + 4u;
									uint4 fragment_unnamed_2846 = uint4(T7.Load(fragment_unnamed_2834).x, T7.Load(fragment_unnamed_2834 + 1u).x, T7.Load(fragment_unnamed_2834 + 2u).x, T7.Load(fragment_unnamed_2834 + 3u).x);
									uint fragment_unnamed_2847 = fragment_unnamed_2846.x;
									float fragment_unnamed_2849 = asfloat(fragment_unnamed_2846.y);
									float fragment_unnamed_2851 = asfloat(fragment_unnamed_2846.z);
									float fragment_unnamed_2853 = asfloat(fragment_unnamed_2846.w);
									uint fragment_unnamed_2855 = (fragment_unnamed_1852 * 72u) + 8u;
									uint4 fragment_unnamed_2867 = uint4(T7.Load(fragment_unnamed_2855).x, T7.Load(fragment_unnamed_2855 + 1u).x, T7.Load(fragment_unnamed_2855 + 2u).x, T7.Load(fragment_unnamed_2855 + 3u).x);
									float fragment_unnamed_2869 = asfloat(fragment_unnamed_2867.x);
									uint fragment_unnamed_2877 = (fragment_unnamed_1852 * 72u) + 12u;
									uint4 fragment_unnamed_2889 = uint4(T7.Load(fragment_unnamed_2877).x, T7.Load(fragment_unnamed_2877 + 1u).x, T7.Load(fragment_unnamed_2877 + 2u).x, T7.Load(fragment_unnamed_2877 + 3u).x);
									float fragment_unnamed_2891 = asfloat(fragment_unnamed_2889.x);
									float fragment_unnamed_2893 = asfloat(fragment_unnamed_2889.y);
									float fragment_unnamed_2895 = asfloat(fragment_unnamed_2889.z);
									uint fragment_unnamed_2898 = (fragment_unnamed_1852 * 72u) + 16u;
									uint4 fragment_unnamed_2910 = uint4(T7.Load(fragment_unnamed_2898).x, T7.Load(fragment_unnamed_2898 + 1u).x, T7.Load(fragment_unnamed_2898 + 2u).x, T7.Load(fragment_unnamed_2898 + 3u).x);
									float fragment_unnamed_2913 = asfloat(fragment_unnamed_2910.x);
									float fragment_unnamed_2915 = asfloat(fragment_unnamed_2910.y);
									uint fragment_unnamed_2918 = (fragment_unnamed_1852 * 72u) + 20u;
									uint4 fragment_unnamed_2930 = uint4(T7.Load(fragment_unnamed_2918).x, T7.Load(fragment_unnamed_2918 + 1u).x, T7.Load(fragment_unnamed_2918 + 2u).x, T7.Load(fragment_unnamed_2918 + 3u).x);
									float fragment_unnamed_2936 = asfloat(fragment_unnamed_2930.x);
									uint fragment_unnamed_2940 = (fragment_unnamed_1852 * 72u) + 24u;
									uint4 fragment_unnamed_2952 = uint4(T7.Load(fragment_unnamed_2940).x, T7.Load(fragment_unnamed_2940 + 1u).x, T7.Load(fragment_unnamed_2940 + 2u).x, T7.Load(fragment_unnamed_2940 + 3u).x);
									float fragment_unnamed_2954 = asfloat(fragment_unnamed_2952.x);
									float fragment_unnamed_2956 = asfloat(fragment_unnamed_2952.y);
									float fragment_unnamed_2958 = asfloat(fragment_unnamed_2952.z);
									uint fragment_unnamed_2961 = (fragment_unnamed_1852 * 72u) + 28u;
									uint4 fragment_unnamed_2973 = uint4(T7.Load(fragment_unnamed_2961).x, T7.Load(fragment_unnamed_2961 + 1u).x, T7.Load(fragment_unnamed_2961 + 2u).x, T7.Load(fragment_unnamed_2961 + 3u).x);
									float fragment_unnamed_2976 = asfloat(fragment_unnamed_2973.x);
									float fragment_unnamed_2978 = asfloat(fragment_unnamed_2973.y);
									uint fragment_unnamed_2982 = (fragment_unnamed_1852 * 72u) + 32u;
									uint4 fragment_unnamed_2994 = uint4(T7.Load(fragment_unnamed_2982).x, T7.Load(fragment_unnamed_2982 + 1u).x, T7.Load(fragment_unnamed_2982 + 2u).x, T7.Load(fragment_unnamed_2982 + 3u).x);
									float fragment_unnamed_2997 = asfloat(fragment_unnamed_2994.y);
									float fragment_unnamed_2999 = asfloat(fragment_unnamed_2994.z);
									float fragment_unnamed_3001 = asfloat(fragment_unnamed_2994.w);
									uint fragment_unnamed_3004 = (fragment_unnamed_1852 * 72u) + 36u;
									uint4 fragment_unnamed_3016 = uint4(T7.Load(fragment_unnamed_3004).x, T7.Load(fragment_unnamed_3004 + 1u).x, T7.Load(fragment_unnamed_3004 + 2u).x, T7.Load(fragment_unnamed_3004 + 3u).x);
									float fragment_unnamed_3018 = asfloat(fragment_unnamed_3016.x);
									uint fragment_unnamed_3025 = (fragment_unnamed_1852 * 72u) + 40u;
									uint4 fragment_unnamed_3037 = uint4(T7.Load(fragment_unnamed_3025).x, T7.Load(fragment_unnamed_3025 + 1u).x, T7.Load(fragment_unnamed_3025 + 2u).x, T7.Load(fragment_unnamed_3025 + 3u).x);
									float fragment_unnamed_3039 = asfloat(fragment_unnamed_3037.z);
									uint fragment_unnamed_3046 = (fragment_unnamed_1852 * 72u) + 52u;
									uint4 fragment_unnamed_3058 = uint4(T7.Load(fragment_unnamed_3046).x, T7.Load(fragment_unnamed_3046 + 1u).x, T7.Load(fragment_unnamed_3046 + 2u).x, T7.Load(fragment_unnamed_3046 + 3u).x);
									float fragment_unnamed_3064 = asfloat(fragment_unnamed_3058.w);
									uint fragment_unnamed_3066 = (fragment_unnamed_1852 * 72u) + 56u;
									uint4 fragment_unnamed_3078 = uint4(T7.Load(fragment_unnamed_3066).x, T7.Load(fragment_unnamed_3066 + 1u).x, T7.Load(fragment_unnamed_3066 + 2u).x, T7.Load(fragment_unnamed_3066 + 3u).x);
									float fragment_unnamed_3080 = asfloat(fragment_unnamed_3078.x);
									uint fragment_unnamed_3085 = fragment_unnamed_3078.w;
									bool fragment_unnamed_3086 = int(fragment_unnamed_3085) >= int(0u);
									float fragment_unnamed_3088 = max(fragment_unnamed_763, 9.9999997473787516355514526367188e-05f);
									float fragment_unnamed_3089 = fragment_unnamed_747 * fragment_unnamed_747;
									float fragment_unnamed_3091 = mad((-0.0f) - fragment_unnamed_747, fragment_unnamed_747, 1.0f);
									float fragment_unnamed_3098 = clamp(mad(fragment_unnamed_3091, fragment_unnamed_3091, fragment_unnamed_3091 * (fragment_unnamed_3088 * fragment_unnamed_3088)), 0.0f, 1.0f) * mad(fragment_unnamed_747, fragment_unnamed_747, sqrt(fragment_unnamed_3091));
									float fragment_unnamed_3105 = mad(fragment_unnamed_3098, mad((-0.0f) - fragment_unnamed_456, fragment_unnamed_463, fragment_unnamed_876), fragment_unnamed_464);
									float fragment_unnamed_3106 = mad(fragment_unnamed_3098, mad((-0.0f) - fragment_unnamed_457, fragment_unnamed_463, fragment_unnamed_877), fragment_unnamed_465);
									float fragment_unnamed_3107 = mad(fragment_unnamed_3098, mad((-0.0f) - fragment_unnamed_458, fragment_unnamed_463, fragment_unnamed_878), fragment_unnamed_466);
									float fragment_unnamed_3109 = min(fragment_unnamed_3089 * fragment_unnamed_3089, 1.0f);
									float fragment_unnamed_3113 = min((fragment_unnamed_3109 * fragment_unnamed_3109) * mad(fragment_unnamed_3109, -2.0f, 3.0f), 1.0f);
									float fragment_unnamed_3130 = asfloat(fragment_unnamed_3086 ? asuint(mad(fragment_unnamed_3113, fragment_unnamed_876 + ((-0.0f) - fragment_unnamed_3105), fragment_unnamed_3105)) : asuint(fragment_unnamed_876));
									float fragment_unnamed_3132 = asfloat(fragment_unnamed_3086 ? asuint(mad(fragment_unnamed_3113, fragment_unnamed_877 + ((-0.0f) - fragment_unnamed_3106), fragment_unnamed_3106)) : asuint(fragment_unnamed_877));
									float fragment_unnamed_3134 = asfloat(fragment_unnamed_3086 ? asuint(mad(fragment_unnamed_3113, fragment_unnamed_878 + ((-0.0f) - fragment_unnamed_3107), fragment_unnamed_3107)) : asuint(fragment_unnamed_878));
									float fragment_unnamed_3144 = ((-0.0f) - asfloat(fragment_unnamed_2930.y)) + fragment_input_6.x;
									float fragment_unnamed_3145 = ((-0.0f) - asfloat(fragment_unnamed_2930.z)) + fragment_input_6.y;
									float fragment_unnamed_3146 = ((-0.0f) - asfloat(fragment_unnamed_2930.w)) + fragment_input_6.z;
									float fragment_unnamed_3147 = asfloat(fragment_unnamed_2973.z);
									float fragment_unnamed_3148 = asfloat(fragment_unnamed_2973.w);
									float fragment_unnamed_3149 = asfloat(fragment_unnamed_2994.x);
									float fragment_unnamed_3150 = dot(float3(fragment_unnamed_3144, fragment_unnamed_3145, fragment_unnamed_3146), float3(fragment_unnamed_3147, fragment_unnamed_3148, fragment_unnamed_3149));
									float fragment_unnamed_3153 = asfloat(fragment_unnamed_2952.w);
									float fragment_unnamed_3154 = dot(float3(fragment_unnamed_3144, fragment_unnamed_3145, fragment_unnamed_3146), float3(fragment_unnamed_3153, fragment_unnamed_2976, fragment_unnamed_2978));
									float fragment_unnamed_3157 = dot(float3(fragment_unnamed_3144, fragment_unnamed_3145, fragment_unnamed_3146), float3(fragment_unnamed_2954, fragment_unnamed_2956, fragment_unnamed_2958));
									float fragment_unnamed_3169 = ((-0.0f) - asfloat(fragment_unnamed_2867.y)) + fragment_input_6.x;
									float fragment_unnamed_3170 = ((-0.0f) - asfloat(fragment_unnamed_2867.z)) + fragment_input_6.y;
									float fragment_unnamed_3171 = ((-0.0f) - asfloat(fragment_unnamed_2867.w)) + fragment_input_6.z;
									float fragment_unnamed_3172 = asfloat(fragment_unnamed_2910.z);
									float fragment_unnamed_3173 = asfloat(fragment_unnamed_2910.w);
									float fragment_unnamed_3174 = dot(float3(fragment_unnamed_3169, fragment_unnamed_3170, fragment_unnamed_3171), float3(fragment_unnamed_3172, fragment_unnamed_3173, fragment_unnamed_2936));
									float fragment_unnamed_3177 = asfloat(fragment_unnamed_2889.w);
									float fragment_unnamed_3178 = dot(float3(fragment_unnamed_3169, fragment_unnamed_3170, fragment_unnamed_3171), float3(fragment_unnamed_3177, fragment_unnamed_2913, fragment_unnamed_2915));
									float fragment_unnamed_3181 = dot(float3(fragment_unnamed_3169, fragment_unnamed_3170, fragment_unnamed_3171), float3(fragment_unnamed_2891, fragment_unnamed_2893, fragment_unnamed_2895));
									float fragment_unnamed_3184 = dot(float3(fragment_unnamed_3130, fragment_unnamed_3132, fragment_unnamed_3134), float3(fragment_unnamed_3172, fragment_unnamed_3173, fragment_unnamed_2936));
									float fragment_unnamed_3187 = dot(float3(fragment_unnamed_3130, fragment_unnamed_3132, fragment_unnamed_3134), float3(fragment_unnamed_3177, fragment_unnamed_2913, fragment_unnamed_2915));
									float fragment_unnamed_3190 = dot(float3(fragment_unnamed_3130, fragment_unnamed_3132, fragment_unnamed_3134), float3(fragment_unnamed_2891, fragment_unnamed_2893, fragment_unnamed_2895));
									float fragment_unnamed_3978;
									float fragment_unnamed_3980;
									float fragment_unnamed_3982;
									float fragment_unnamed_3984;
									float fragment_unnamed_3986;
									if (fragment_unnamed_2847 == 2u)
									{
										float fragment_unnamed_3501 = dot(float3(fragment_unnamed_3184, fragment_unnamed_3187, fragment_unnamed_3190), float3(fragment_unnamed_3174, fragment_unnamed_3178, fragment_unnamed_3181));
										float fragment_unnamed_3504 = fragment_unnamed_3501 + fragment_unnamed_3501;
										float fragment_unnamed_3517 = abs(mad((-0.0f) - fragment_unnamed_3501, 2.0f, sqrt(mad(fragment_unnamed_3504, fragment_unnamed_3504, (-0.0f) - (mad((-0.0f) - fragment_unnamed_2849, fragment_unnamed_2849, dot(float3(fragment_unnamed_3174, fragment_unnamed_3178, fragment_unnamed_3181), float3(fragment_unnamed_3174, fragment_unnamed_3178, fragment_unnamed_3181))) * 4.0f))))) * 0.5f;
										float fragment_unnamed_3526 = max(fragment_unnamed_2869, asfloat((2139095040u < (asuint(fragment_unnamed_3517) & 2147483647u)) ? 3212836864u : asuint(fragment_unnamed_3517)));
										float fragment_unnamed_3545 = sqrt(dot(float3(fragment_unnamed_3150, fragment_unnamed_3154, fragment_unnamed_3157), float3(fragment_unnamed_3150, fragment_unnamed_3154, fragment_unnamed_3157)));
										float fragment_unnamed_3568 = ((-0.0f) - fragment_unnamed_2649) + fragment_input_6.x;
										float fragment_unnamed_3569 = ((-0.0f) - fragment_unnamed_2651) + fragment_input_6.y;
										float fragment_unnamed_3570 = ((-0.0f) - fragment_unnamed_2653) + fragment_input_6.z;
										float fragment_unnamed_3574 = rsqrt(dot(float3(fragment_unnamed_3568, fragment_unnamed_3569, fragment_unnamed_3570), float3(fragment_unnamed_3568, fragment_unnamed_3569, fragment_unnamed_3570)));
										fragment_unnamed_3978 = asfloat(((fragment_unnamed_2997 + ((-0.0f) - fragment_unnamed_3039)) >= fragment_unnamed_3545) ? 1065353216u : asuint(clamp(mad(dot(float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466), float3(fragment_unnamed_3574 * fragment_unnamed_3568, fragment_unnamed_3574 * fragment_unnamed_3569, fragment_unnamed_3574 * fragment_unnamed_3570)), -2.5f, 1.5f), 0.0f, 1.0f))) * max(((-0.0f) - (max(fragment_unnamed_3545 + ((-0.0f) - (fragment_unnamed_2997 + ((-0.0f) - fragment_unnamed_3018))), 0.0f) / max(fragment_unnamed_3018, 9.9999997473787516355514526367188e-05f))) + 1.0f, 0.0f);
										fragment_unnamed_3980 = fragment_unnamed_3526;
										fragment_unnamed_3982 = ((-0.0f) - fragment_unnamed_2649) + mad(fragment_unnamed_3526, fragment_unnamed_3130, fragment_input_6.x);
										fragment_unnamed_3984 = ((-0.0f) - fragment_unnamed_2651) + mad(fragment_unnamed_3526, fragment_unnamed_3132, fragment_input_6.y);
										fragment_unnamed_3986 = ((-0.0f) - fragment_unnamed_2653) + mad(fragment_unnamed_3526, fragment_unnamed_3134, fragment_input_6.z);
									}
									else
									{
										float fragment_unnamed_3979;
										float fragment_unnamed_3981;
										float fragment_unnamed_3983;
										float fragment_unnamed_3985;
										float fragment_unnamed_3987;
										if (fragment_unnamed_2847 == 1u)
										{
											uint fragment_unnamed_4021 = (fragment_unnamed_1852 * 72u) + 44u;
											uint4 fragment_unnamed_4033 = uint4(T7.Load(fragment_unnamed_4021).x, T7.Load(fragment_unnamed_4021 + 1u).x, T7.Load(fragment_unnamed_4021 + 2u).x, T7.Load(fragment_unnamed_4021 + 3u).x);
											uint fragment_unnamed_4042 = (fragment_unnamed_1852 * 72u) + 48u;
											uint4 fragment_unnamed_4054 = uint4(T7.Load(fragment_unnamed_4042).x, T7.Load(fragment_unnamed_4042 + 1u).x, T7.Load(fragment_unnamed_4042 + 2u).x, T7.Load(fragment_unnamed_4042 + 3u).x);
											float fragment_unnamed_4063 = dot(float3(fragment_unnamed_3130, fragment_unnamed_3132, fragment_unnamed_3134), float3(fragment_unnamed_3147, fragment_unnamed_3148, fragment_unnamed_3149));
											float fragment_unnamed_4066 = dot(float3(fragment_unnamed_3130, fragment_unnamed_3132, fragment_unnamed_3134), float3(fragment_unnamed_3153, fragment_unnamed_2976, fragment_unnamed_2978));
											float fragment_unnamed_4069 = dot(float3(fragment_unnamed_3130, fragment_unnamed_3132, fragment_unnamed_3134), float3(fragment_unnamed_2954, fragment_unnamed_2956, fragment_unnamed_2958));
											float fragment_unnamed_4075 = rsqrt(dot(float3(fragment_unnamed_4063, fragment_unnamed_4066, fragment_unnamed_4069), float3(fragment_unnamed_4063, fragment_unnamed_4066, fragment_unnamed_4069)));
											float fragment_unnamed_4076 = fragment_unnamed_4075 * fragment_unnamed_4063;
											float fragment_unnamed_4077 = fragment_unnamed_4075 * fragment_unnamed_4066;
											float fragment_unnamed_4078 = fragment_unnamed_4075 * fragment_unnamed_4069;
											float fragment_unnamed_4079 = 1.0f / fragment_unnamed_3184;
											float fragment_unnamed_4080 = 1.0f / fragment_unnamed_3187;
											float fragment_unnamed_4081 = 1.0f / fragment_unnamed_3190;
											float fragment_unnamed_4120 = max(fragment_unnamed_2869, min(asfloat((0.0f < fragment_unnamed_3190) ? asuint(fragment_unnamed_4081 * (fragment_unnamed_2853 + ((-0.0f) - fragment_unnamed_3181))) : asuint(fragment_unnamed_4081 * (((-0.0f) - fragment_unnamed_2853) + ((-0.0f) - fragment_unnamed_3181)))), min(asfloat((0.0f < fragment_unnamed_3187) ? asuint(fragment_unnamed_4080 * (fragment_unnamed_2851 + ((-0.0f) - fragment_unnamed_3178))) : asuint(fragment_unnamed_4080 * (((-0.0f) - fragment_unnamed_2851) + ((-0.0f) - fragment_unnamed_3178)))), asfloat((0.0f < fragment_unnamed_3184) ? asuint(fragment_unnamed_4079 * (fragment_unnamed_2849 + ((-0.0f) - fragment_unnamed_3174))) : asuint(fragment_unnamed_4079 * (((-0.0f) - fragment_unnamed_2849) + ((-0.0f) - fragment_unnamed_3174)))))));
											float fragment_unnamed_4136 = fragment_unnamed_2997 + fragment_unnamed_3150;
											float fragment_unnamed_4137 = fragment_unnamed_2999 + fragment_unnamed_3154;
											float fragment_unnamed_4138 = fragment_unnamed_3001 + fragment_unnamed_3157;
											float fragment_unnamed_4142 = fragment_unnamed_2997 + ((-0.0f) - fragment_unnamed_3150);
											float fragment_unnamed_4143 = fragment_unnamed_2999 + ((-0.0f) - fragment_unnamed_3154);
											float fragment_unnamed_4144 = fragment_unnamed_3001 + ((-0.0f) - fragment_unnamed_3157);
											float fragment_unnamed_4205 = ((-0.0f) - fragment_unnamed_2649) + fragment_input_6.x;
											float fragment_unnamed_4206 = ((-0.0f) - fragment_unnamed_2651) + fragment_input_6.y;
											float fragment_unnamed_4207 = ((-0.0f) - fragment_unnamed_2653) + fragment_input_6.z;
											float fragment_unnamed_4211 = rsqrt(dot(float3(fragment_unnamed_4205, fragment_unnamed_4206, fragment_unnamed_4207), float3(fragment_unnamed_4205, fragment_unnamed_4206, fragment_unnamed_4207)));
											float fragment_unnamed_4223 = asfloat(((((((fragment_unnamed_4144 / max(asfloat(fragment_unnamed_4033.x), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & ((((fragment_unnamed_4143 / max(asfloat(fragment_unnamed_3037.w), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_4142 / max(fragment_unnamed_3039, 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u))) & ((((fragment_unnamed_4138 / max(asfloat(fragment_unnamed_4033.w), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & ((((fragment_unnamed_4137 / max(asfloat(fragment_unnamed_4033.z), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_4136 / max(asfloat(fragment_unnamed_4033.y), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u)))) != 0u) ? 1065353216u : asuint(clamp(mad(dot(float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466), float3(fragment_unnamed_4211 * fragment_unnamed_4205, fragment_unnamed_4211 * fragment_unnamed_4206, fragment_unnamed_4211 * fragment_unnamed_4207)), -2.5f, 1.5f), 0.0f, 1.0f)));
											fragment_unnamed_3979 = (clamp(min(min(fragment_unnamed_4138 / max(asfloat(fragment_unnamed_3037.y), 9.9999997473787516355514526367188e-05f), min(fragment_unnamed_4137 / max(asfloat(fragment_unnamed_3037.x), 9.9999997473787516355514526367188e-05f), fragment_unnamed_4136 / max(asfloat(fragment_unnamed_3016.w), 9.9999997473787516355514526367188e-05f))), min(fragment_unnamed_4144 / max(asfloat(fragment_unnamed_3016.z), 9.9999997473787516355514526367188e-05f), min(fragment_unnamed_4143 / max(asfloat(fragment_unnamed_3016.y), 9.9999997473787516355514526367188e-05f), fragment_unnamed_4142 / max(fragment_unnamed_3018, 9.9999997473787516355514526367188e-05f)))), 0.0f, 1.0f) * fragment_unnamed_4223) * min((clamp(asfloat(fragment_unnamed_4054.z) * mad(fragment_unnamed_4078, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4078, -4.0f, -1.0f) * asfloat(fragment_unnamed_3058.y), 0.0f, 1.0f)) + ((clamp(asfloat(fragment_unnamed_4054.y) * mad(fragment_unnamed_4077, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4077, -4.0f, -1.0f) * asfloat(fragment_unnamed_3058.x), 0.0f, 1.0f)) + (clamp(asfloat(fragment_unnamed_4054.x) * mad(fragment_unnamed_4076, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4076, -4.0f, -1.0f) * asfloat(fragment_unnamed_4054.w), 0.0f, 1.0f))), 1.0f);
											fragment_unnamed_3981 = fragment_unnamed_4120;
											fragment_unnamed_3983 = ((-0.0f) - fragment_unnamed_2649) + mad(fragment_unnamed_4120, fragment_unnamed_3130, fragment_input_6.x);
											fragment_unnamed_3985 = ((-0.0f) - fragment_unnamed_2651) + mad(fragment_unnamed_4120, fragment_unnamed_3132, fragment_input_6.y);
											fragment_unnamed_3987 = ((-0.0f) - fragment_unnamed_2653) + mad(fragment_unnamed_4120, fragment_unnamed_3134, fragment_input_6.z);
										}
										else
										{
											fragment_unnamed_3979 = asfloat(1065353216u);
											fragment_unnamed_3981 = asfloat(0u);
											fragment_unnamed_3983 = fragment_unnamed_3130;
											fragment_unnamed_3985 = fragment_unnamed_3132;
											fragment_unnamed_3987 = fragment_unnamed_3134;
										}
										fragment_unnamed_3978 = fragment_unnamed_3979;
										fragment_unnamed_3980 = fragment_unnamed_3981;
										fragment_unnamed_3982 = fragment_unnamed_3983;
										fragment_unnamed_3984 = fragment_unnamed_3985;
										fragment_unnamed_3986 = fragment_unnamed_3987;
									}
									float fragment_unnamed_3992 = asfloat(fragment_unnamed_3058.z) * ((fragment_unnamed_3978 * fragment_unnamed_3978) * mad((-0.0f) - fragment_unnamed_3978, 2.0f, 3.0f));
									float fragment_unnamed_4000 = min(fragment_unnamed_747, max(fragment_unnamed_747 * (fragment_unnamed_3980 / sqrt(dot(float3(fragment_unnamed_3982, fragment_unnamed_3984, fragment_unnamed_3986), float3(fragment_unnamed_3982, fragment_unnamed_3984, fragment_unnamed_3986)))), 0.0f));
									float fragment_unnamed_4010 = asfloat(fragment_unnamed_3086 ? asuint(mad(asfloat(fragment_unnamed_3078.z), ((-0.0f) - fragment_unnamed_747) + mad(fragment_unnamed_747, fragment_unnamed_747 + ((-0.0f) - fragment_unnamed_4000), fragment_unnamed_4000), fragment_unnamed_747)) : asuint(fragment_unnamed_747));
									float fragment_unnamed_4014 = asfloat(fragment_unnamed_3078.y) * (fragment_unnamed_4010 * mad((-0.0f) - fragment_unnamed_4010, 0.699999988079071044921875f, 1.7000000476837158203125f));
									float fragment_unnamed_4015 = fragment_unnamed_4014 * 6.0f;
									uint fragment_unnamed_4018 = uint(abs(int(fragment_unnamed_3085))) + 4294967295u;
									float fragment_unnamed_5426;
									float fragment_unnamed_5428;
									float fragment_unnamed_5430;
									float fragment_unnamed_5432;
									if ((fragment_unnamed_3086 ? 4294967295u : 0u) == 0u)
									{
										uint fragment_unnamed_4669 = fragment_unnamed_4018 << 2u;
										uint fragment_unnamed_4670 = fragment_unnamed_4669 + 1u;
										uint fragment_unnamed_4691 = fragment_unnamed_4669 + 2u;
										uint fragment_unnamed_4702 = fragment_unnamed_4669 + 3u;
										float fragment_unnamed_4712 = mad(fragment_uniform_buffer_3[fragment_unnamed_4691].w, fragment_unnamed_3986, mad(fragment_uniform_buffer_3[fragment_unnamed_4669].w, fragment_unnamed_3982, fragment_unnamed_3984 * fragment_uniform_buffer_3[fragment_unnamed_4670].w)) + fragment_uniform_buffer_3[fragment_unnamed_4702].w;
										float fragment_unnamed_4713 = (mad(fragment_uniform_buffer_3[fragment_unnamed_4691].x, fragment_unnamed_3986, mad(fragment_uniform_buffer_3[fragment_unnamed_4669].x, fragment_unnamed_3982, fragment_unnamed_3984 * fragment_uniform_buffer_3[fragment_unnamed_4670].x)) + fragment_uniform_buffer_3[fragment_unnamed_4702].x) * 1.0f;
										float fragment_unnamed_4714 = (mad(fragment_uniform_buffer_3[fragment_unnamed_4691].y, fragment_unnamed_3986, mad(fragment_uniform_buffer_3[fragment_unnamed_4669].y, fragment_unnamed_3982, fragment_unnamed_3984 * fragment_uniform_buffer_3[fragment_unnamed_4670].y)) + fragment_uniform_buffer_3[fragment_unnamed_4702].y) * (-1.0f);
										uint fragment_unnamed_4726 = ((abs((mad(fragment_uniform_buffer_3[fragment_unnamed_4691].z, fragment_unnamed_3986, mad(fragment_uniform_buffer_3[fragment_unnamed_4669].z, fragment_unnamed_3982, fragment_unnamed_3984 * fragment_uniform_buffer_3[fragment_unnamed_4670].z)) + fragment_uniform_buffer_3[fragment_unnamed_4702].z) * 1.0f) < fragment_unnamed_4712) ? 4294967295u : 0u) & (((abs(fragment_unnamed_4714) < fragment_unnamed_4712) ? 4294967295u : 0u) & ((abs(fragment_unnamed_4713) < fragment_unnamed_4712) ? 4294967295u : 0u));
										float fragment_unnamed_5427;
										float fragment_unnamed_5429;
										float fragment_unnamed_5431;
										float fragment_unnamed_5433;
										if (fragment_unnamed_4726 != 0u)
										{
											float fragment_unnamed_5286 = 1.0f / fragment_unnamed_4712;
											float fragment_unnamed_5289 = mad(fragment_unnamed_5286 * fragment_unnamed_4713, 0.5f, 0.5f);
											float fragment_unnamed_5290 = mad(fragment_unnamed_5286 * fragment_unnamed_4714, 0.5f, 0.5f);
											uint fragment_unnamed_5298 = fragment_unnamed_4018 + 64u;
											uint fragment_unnamed_5310 = fragment_unnamed_4018 + 64u;
											float fragment_unnamed_5318 = exp2(ceil(fragment_unnamed_4015));
											float fragment_unnamed_5323 = fragment_unnamed_5318 * fragment_uniform_buffer_1[125u].z;
											float fragment_unnamed_5324 = fragment_unnamed_5318 * fragment_uniform_buffer_1[125u].w;
											uint fragment_unnamed_5325 = fragment_unnamed_4018 + 64u;
											uint fragment_unnamed_5332 = fragment_unnamed_4018 + 64u;
											uint fragment_unnamed_5337 = fragment_unnamed_4018 + 64u;
											float4 fragment_unnamed_5355 = _ReflectionAtlas.SampleLevel(S1, float3(min(mad((-0.0f) - fragment_unnamed_5323, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_5332].x + fragment_uniform_buffer_3[fragment_unnamed_5337].z), max(mad(fragment_unnamed_5323, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_5325].z), mad(fragment_unnamed_5289, ((-0.0f) - fragment_uniform_buffer_1[125u].x) + fragment_uniform_buffer_3[fragment_unnamed_5298].x, mad(fragment_uniform_buffer_1[125u].x, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_5310].z)))), min(mad((-0.0f) - fragment_unnamed_5324, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_5332].y + fragment_uniform_buffer_3[fragment_unnamed_5337].w), max(mad(fragment_unnamed_5324, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_5325].w), mad(fragment_unnamed_5290, ((-0.0f) - fragment_uniform_buffer_1[125u].y) + fragment_uniform_buffer_3[fragment_unnamed_5298].y, mad(fragment_uniform_buffer_1[125u].y, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_5310].w)))), fragment_unnamed_1369), fragment_unnamed_4015);
											float fragment_unnamed_5390 = min(abs(mad((-0.0f) - fragment_unnamed_270, fragment_uniform_buffer_1[50u].z, fragment_unnamed_5289)) * 100.0f, 1.0f);
											float fragment_unnamed_5391 = min(abs(mad((-0.0f) - fragment_unnamed_271, fragment_uniform_buffer_1[50u].w, fragment_unnamed_5290)) * 100.0f, 1.0f);
											fragment_unnamed_5427 = asfloat(fragment_unnamed_4726 & 1065353216u) * (asfloat((((((fragment_unnamed_283 < fragment_unnamed_5290) ? 4294967295u : 0u) & 1u) ^ (((fragment_unnamed_5290 < 0.5f) ? 4294967295u : 0u) & 1u)) != 0u) ? asuint(mad(mad((-0.0f) - fragment_unnamed_5391, 2.0f, 3.0f) * (fragment_unnamed_5391 * fragment_unnamed_5391), min(mad((-0.0f) - abs(mad(clamp(fragment_unnamed_5290, 0.0f, 1.0f), 2.0f, -1.0f)), 2.0f, 2.0f), 1.0f) + (-1.0f), 1.0f)) : 1065353216u) * asfloat((((((fragment_unnamed_282 < fragment_unnamed_5289) ? 4294967295u : 0u) & 1u) ^ (((fragment_unnamed_5289 < 0.5f) ? 4294967295u : 0u) & 1u)) != 0u) ? asuint(mad(mad((-0.0f) - fragment_unnamed_5390, 2.0f, 3.0f) * (fragment_unnamed_5390 * fragment_unnamed_5390), min(mad((-0.0f) - abs(mad(clamp(fragment_unnamed_5289, 0.0f, 1.0f), 2.0f, -1.0f)), 2.0f, 2.0f), 1.0f) + (-1.0f), 1.0f)) : 1065353216u));
											fragment_unnamed_5429 = fragment_unnamed_5355.x;
											fragment_unnamed_5431 = fragment_unnamed_5355.y;
											fragment_unnamed_5433 = fragment_unnamed_5355.z;
										}
										else
										{
											fragment_unnamed_5427 = asfloat(0u);
											fragment_unnamed_5429 = asfloat(0u);
											fragment_unnamed_5431 = asfloat(0u);
											fragment_unnamed_5433 = asfloat(0u);
										}
										fragment_unnamed_5426 = fragment_unnamed_5427;
										fragment_unnamed_5428 = fragment_unnamed_5429;
										fragment_unnamed_5430 = fragment_unnamed_5431;
										fragment_unnamed_5432 = fragment_unnamed_5433;
									}
									else
									{
										float fragment_unnamed_4735 = 1.0f / max(dot(float3(abs(fragment_unnamed_3982), abs(fragment_unnamed_3984), abs(fragment_unnamed_3986)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
										float fragment_unnamed_4740 = clamp((-0.0f) - (fragment_unnamed_4735 * fragment_unnamed_3986), 0.0f, 1.0f);
										float fragment_unnamed_4743 = (-0.0f) - fragment_unnamed_4740;
										float fragment_unnamed_4759 = exp2(max(mad(fragment_unnamed_4014, 6.0f, (-0.0f) - fragment_uniform_buffer_1[124u].z), 0.0f));
										uint fragment_unnamed_4772 = fragment_unnamed_4018 + 80u;
										uint fragment_unnamed_4780 = fragment_unnamed_4018 + 80u;
										float4 fragment_unnamed_4790 = _ReflectionAtlas.SampleLevel(S1, float3(mad(clamp(mad(mad(fragment_unnamed_3982, fragment_unnamed_4735, ((fragment_unnamed_4735 * fragment_unnamed_3982) >= 0.0f) ? fragment_unnamed_4740 : fragment_unnamed_4743), 0.5f, 0.5f), 0.0f, 1.0f), mad((-0.0f) - fragment_uniform_buffer_1[124u].x, fragment_unnamed_4759, fragment_uniform_buffer_3[fragment_unnamed_4772].x), mad(fragment_unnamed_4759 * fragment_uniform_buffer_1[124u].x, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_4780].z)), mad(clamp(mad(mad(fragment_unnamed_3984, fragment_unnamed_4735, ((fragment_unnamed_4735 * fragment_unnamed_3984) >= 0.0f) ? fragment_unnamed_4740 : fragment_unnamed_4743), 0.5f, 0.5f), 0.0f, 1.0f), mad((-0.0f) - fragment_uniform_buffer_1[124u].y, fragment_unnamed_4759, fragment_uniform_buffer_3[fragment_unnamed_4772].y), mad(fragment_unnamed_4759 * fragment_uniform_buffer_1[124u].y, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_4780].w)), fragment_unnamed_1368), fragment_unnamed_4015);
										fragment_unnamed_5426 = asfloat(1065353216u);
										fragment_unnamed_5428 = fragment_unnamed_4790.x;
										fragment_unnamed_5430 = fragment_unnamed_4790.y;
										fragment_unnamed_5432 = fragment_unnamed_4790.z;
									}
									float fragment_unnamed_5443 = mad(fragment_unnamed_3992, fragment_unnamed_5426, fragment_unnamed_1555);
									float fragment_unnamed_3195 = clamp(fragment_unnamed_5443, 0.0f, 1.0f);
									float fragment_unnamed_5448 = mad(fragment_unnamed_3992, fragment_unnamed_5426, (-0.0f) - clamp(((-0.0f) - fragment_unnamed_3195) + fragment_unnamed_5443, 0.0f, 1.0f));
									fragment_unnamed_3194 = fragment_unnamed_3195;
									fragment_unnamed_3196 = mad(fragment_unnamed_5448 * ((fragment_unnamed_3080 * min(fragment_unnamed_5428, 65504.0f)) * fragment_unnamed_858), fragment_unnamed_3064, fragment_unnamed_1559);
									fragment_unnamed_3198 = mad(fragment_unnamed_5448 * ((fragment_unnamed_3080 * min(fragment_unnamed_5430, 65504.0f)) * fragment_unnamed_859), fragment_unnamed_3064, fragment_unnamed_1561);
									fragment_unnamed_3200 = mad(fragment_unnamed_5448 * ((fragment_unnamed_3080 * min(fragment_unnamed_5432, 65504.0f)) * fragment_unnamed_860), fragment_unnamed_3064, fragment_unnamed_1563);
								}
								else
								{
									fragment_unnamed_3194 = fragment_unnamed_1555;
									fragment_unnamed_3196 = fragment_unnamed_1559;
									fragment_unnamed_3198 = fragment_unnamed_1561;
									fragment_unnamed_3200 = fragment_unnamed_1563;
								}
								fragment_unnamed_1556 = fragment_unnamed_3194;
								fragment_unnamed_1560 = fragment_unnamed_3196;
								fragment_unnamed_1562 = fragment_unnamed_3198;
								fragment_unnamed_1564 = fragment_unnamed_3200;
								fragment_unnamed_1555 = fragment_unnamed_1556;
								fragment_unnamed_1557 = fragment_unnamed_1558;
								fragment_unnamed_1559 = fragment_unnamed_1560;
								fragment_unnamed_1561 = fragment_unnamed_1562;
								fragment_unnamed_1563 = fragment_unnamed_1564;
								continue;
							}
							else
							{
								fragment_unnamed_1556 = asfloat(1065353216u);
								fragment_unnamed_1560 = fragment_unnamed_1559;
								fragment_unnamed_1562 = fragment_unnamed_1561;
								fragment_unnamed_1564 = fragment_unnamed_1563;
								fragment_unnamed_1555 = fragment_unnamed_1556;
								fragment_unnamed_1557 = fragment_unnamed_1558;
								fragment_unnamed_1559 = fragment_unnamed_1560;
								fragment_unnamed_1561 = fragment_unnamed_1562;
								fragment_unnamed_1563 = fragment_unnamed_1564;
								continue;
							}
						}
					}
					if (ladder_phi_33)
					{
						break;
					}
					break;
				}
				float fragment_unnamed_2233;
				float fragment_unnamed_2235;
				float fragment_unnamed_2237;
				if (asuint(fragment_uniform_buffer_1[116u]).x != 0u)
				{
					float fragment_unnamed_2234;
					float fragment_unnamed_2236;
					float fragment_unnamed_2238;
					if (fragment_unnamed_1555 < 1.0f)
					{
						float fragment_unnamed_2551 = asfloat((asuint(fragment_uniform_buffer_1[117u]).x != 0u) ? 1065353216u : 0u);
						float fragment_unnamed_2553 = mad((-0.0f) - fragment_unnamed_747, fragment_unnamed_747, 1.0f);
						float fragment_unnamed_2560 = clamp(mad(fragment_unnamed_2553, fragment_unnamed_2553, fragment_unnamed_2553 * (fragment_unnamed_766 * fragment_unnamed_766)), 0.0f, 1.0f) * mad(fragment_unnamed_747, fragment_unnamed_747, sqrt(fragment_unnamed_2553));
						float fragment_unnamed_2567 = mad(fragment_unnamed_2560, mad((-0.0f) - fragment_unnamed_456, fragment_unnamed_463, fragment_unnamed_876), fragment_unnamed_464);
						float fragment_unnamed_2568 = mad(fragment_unnamed_2560, mad((-0.0f) - fragment_unnamed_457, fragment_unnamed_463, fragment_unnamed_877), fragment_unnamed_465);
						float fragment_unnamed_2569 = mad(fragment_unnamed_2560, mad((-0.0f) - fragment_unnamed_458, fragment_unnamed_463, fragment_unnamed_878), fragment_unnamed_466);
						float fragment_unnamed_2570 = min(fragment_unnamed_863, 1.0f);
						float fragment_unnamed_2574 = min((fragment_unnamed_2570 * fragment_unnamed_2570) * mad(fragment_unnamed_2570, -2.0f, 3.0f), 1.0f);
						float fragment_unnamed_2581 = mad(fragment_unnamed_2574, ((-0.0f) - fragment_unnamed_2567) + fragment_unnamed_876, fragment_unnamed_2567);
						float fragment_unnamed_2582 = mad(fragment_unnamed_2574, ((-0.0f) - fragment_unnamed_2568) + fragment_unnamed_877, fragment_unnamed_2568);
						float fragment_unnamed_2583 = mad(fragment_unnamed_2574, ((-0.0f) - fragment_unnamed_2569) + fragment_unnamed_878, fragment_unnamed_2569);
						float fragment_unnamed_2591 = asfloat(0u);
						float4 fragment_unnamed_2594 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_2581, fragment_unnamed_2582, fragment_unnamed_2583, fragment_unnamed_2591), (mad((-0.0f) - fragment_unnamed_747, 0.699999988079071044921875f, 1.7000000476837158203125f) * fragment_unnamed_747) * 6.0f);
						float fragment_unnamed_2599 = min(fragment_unnamed_2594.x, 65504.0f);
						float fragment_unnamed_2601 = min(fragment_unnamed_2594.y, 65504.0f);
						float fragment_unnamed_2602 = min(fragment_unnamed_2594.z, 65504.0f);
						float fragment_unnamed_2788;
						float fragment_unnamed_2790;
						float fragment_unnamed_2792;
						if (asuint(fragment_uniform_buffer_1[84u]).x != 0u)
						{
							float fragment_unnamed_2710 = dot(float3(fragment_unnamed_2581, fragment_unnamed_2582, fragment_unnamed_2583), float3(fragment_uniform_buffer_1[83u].xyz));
							float fragment_unnamed_2726 = max(abs(fragment_unnamed_2710), 0.001000000047497451305389404296875f);
							float fragment_unnamed_2727 = 1.0f / fragment_unnamed_2726;
							float fragment_unnamed_2732 = min(mad(fragment_uniform_buffer_1[84u].w, fragment_unnamed_2710, fragment_unnamed_1220), fragment_unnamed_1220);
							float fragment_unnamed_2749 = min(max(fragment_unnamed_2727 * (((-0.0f) - fragment_unnamed_2732) + fragment_uniform_buffer_1[89u].y), 0.0f), fragment_uniform_buffer_1[84u].w);
							float fragment_unnamed_2783 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_2726 * ((-0.0f) - (((-0.0f) - fragment_unnamed_2749) + fragment_uniform_buffer_1[84u].w))) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_2732 + ((-0.0f) - fragment_uniform_buffer_1[89u].y), 0.0f)) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f), fragment_unnamed_2727 * fragment_uniform_buffer_1[90u].y, fragment_unnamed_2749) * fragment_uniform_buffer_1[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_3730;
							float fragment_unnamed_3731;
							float fragment_unnamed_3732;
							if (fragment_uniform_buffer_1[86u].x == 1.0f)
							{
								float4 fragment_unnamed_3402 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_2581, fragment_unnamed_2582, fragment_unnamed_2583, fragment_unnamed_2591), mad((-0.0f) - fragment_uniform_buffer_1[87u].z, clamp((fragment_uniform_buffer_1[84u].w + ((-0.0f) - fragment_uniform_buffer_1[87u].x)) / (((-0.0f) - fragment_uniform_buffer_1[87u].x) + fragment_uniform_buffer_1[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_3730 = fragment_unnamed_3402.z * fragment_uniform_buffer_1[85u].z;
								fragment_unnamed_3731 = fragment_unnamed_3402.y * fragment_uniform_buffer_1[85u].y;
								fragment_unnamed_3732 = fragment_unnamed_3402.x * fragment_uniform_buffer_1[85u].x;
							}
							else
							{
								uint4 fragment_unnamed_3418 = asuint(fragment_uniform_buffer_1[85u]);
								fragment_unnamed_3730 = asfloat(fragment_unnamed_3418.z);
								fragment_unnamed_3731 = asfloat(fragment_unnamed_3418.y);
								fragment_unnamed_3732 = asfloat(fragment_unnamed_3418.x);
							}
							float fragment_unnamed_3737 = ((-0.0f) - fragment_unnamed_2783) + 1.0f;
							fragment_unnamed_2788 = mad(fragment_unnamed_2602, fragment_unnamed_2783, fragment_unnamed_3737 * ((fragment_uniform_buffer_1[88u].z / fragment_uniform_buffer_1[89u].x) * fragment_unnamed_3730));
							fragment_unnamed_2790 = mad(fragment_unnamed_2601, fragment_unnamed_2783, fragment_unnamed_3737 * ((fragment_uniform_buffer_1[88u].y / fragment_uniform_buffer_1[89u].x) * fragment_unnamed_3731));
							fragment_unnamed_2792 = mad(fragment_unnamed_2599, fragment_unnamed_2783, fragment_unnamed_3737 * ((fragment_uniform_buffer_1[88u].x / fragment_uniform_buffer_1[89u].x) * fragment_unnamed_3732));
						}
						else
						{
							fragment_unnamed_2788 = fragment_unnamed_2602;
							fragment_unnamed_2790 = fragment_unnamed_2601;
							fragment_unnamed_2792 = fragment_unnamed_2599;
						}
						float fragment_unnamed_2798 = ((-0.0f) - fragment_unnamed_1555) + 1.0f;
						fragment_unnamed_2234 = mad((fragment_unnamed_2792 * fragment_unnamed_858) * fragment_unnamed_2798, fragment_unnamed_2551, fragment_unnamed_1559);
						fragment_unnamed_2236 = mad((fragment_unnamed_2790 * fragment_unnamed_859) * fragment_unnamed_2798, fragment_unnamed_2551, fragment_unnamed_1561);
						fragment_unnamed_2238 = mad((fragment_unnamed_2788 * fragment_unnamed_860) * fragment_unnamed_2798, fragment_unnamed_2551, fragment_unnamed_1563);
					}
					else
					{
						fragment_unnamed_2234 = fragment_unnamed_1559;
						fragment_unnamed_2236 = fragment_unnamed_1561;
						fragment_unnamed_2238 = fragment_unnamed_1563;
					}
					fragment_unnamed_2233 = fragment_unnamed_2234;
					fragment_unnamed_2235 = fragment_unnamed_2236;
					fragment_unnamed_2237 = fragment_unnamed_2238;
				}
				else
				{
					fragment_unnamed_2233 = fragment_unnamed_1559;
					fragment_unnamed_2235 = fragment_unnamed_1561;
					fragment_unnamed_2237 = fragment_unnamed_1563;
				}
				float fragment_unnamed_2250 = ((-0.0f) - fragment_unnamed_1220) + fragment_uniform_buffer_1[89u].y;
				float fragment_unnamed_2259 = exp2((((-0.0f) - max(fragment_unnamed_1220 + ((-0.0f) - fragment_uniform_buffer_1[89u].y), 0.0f)) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f);
				uint fragment_unnamed_2265 = (fragment_uniform_buffer_1[218u].w == 1.0f) ? 4294967295u : 0u;
				float fragment_unnamed_2280 = fragment_input_6.x + ((-0.0f) - fragment_uniform_buffer_1[218u].x);
				float fragment_unnamed_2281 = fragment_input_6.y + ((-0.0f) - fragment_uniform_buffer_1[218u].y);
				float fragment_unnamed_2282 = fragment_input_6.z + ((-0.0f) - fragment_uniform_buffer_1[218u].z);
				float fragment_unnamed_2298 = fragment_input_6.x + ((-0.0f) - fragment_uniform_buffer_1[82u].x);
				float fragment_unnamed_2299 = fragment_input_6.y + ((-0.0f) - fragment_uniform_buffer_1[82u].y);
				float fragment_unnamed_2300 = fragment_input_6.z + ((-0.0f) - fragment_uniform_buffer_1[82u].z);
				float fragment_unnamed_2307 = fragment_uniform_buffer_1[82u].w + fragment_uniform_buffer_5[12u].w;
				float fragment_unnamed_2312 = mad((-0.0f) - fragment_unnamed_2307, fragment_unnamed_2307, dot(float3(fragment_unnamed_2298, fragment_unnamed_2299, fragment_unnamed_2300), float3(fragment_unnamed_2298, fragment_unnamed_2299, fragment_unnamed_2300)));
				float fragment_unnamed_2313 = asfloat(0u);
				float fragment_unnamed_2612;
				float fragment_unnamed_2614;
				float fragment_unnamed_2616;
				float fragment_unnamed_2618;
				float fragment_unnamed_2620;
				float fragment_unnamed_2622;
				fragment_unnamed_2612 = fragment_unnamed_1266;
				fragment_unnamed_2614 = fragment_unnamed_1268;
				fragment_unnamed_2616 = fragment_unnamed_1270;
				fragment_unnamed_2618 = fragment_unnamed_1272;
				fragment_unnamed_2620 = fragment_unnamed_1274;
				fragment_unnamed_2622 = fragment_unnamed_1276;
				float fragment_unnamed_2613;
				float fragment_unnamed_2615;
				float fragment_unnamed_2617;
				float fragment_unnamed_2619;
				float fragment_unnamed_2621;
				float fragment_unnamed_2623;
				for (float fragment_unnamed_2624 = fragment_unnamed_2313; !(asuint(fragment_unnamed_2624) >= asuint(fragment_uniform_buffer_1[114u]).x); fragment_unnamed_2612 = fragment_unnamed_2613, fragment_unnamed_2614 = fragment_unnamed_2615, fragment_unnamed_2616 = fragment_unnamed_2617, fragment_unnamed_2618 = fragment_unnamed_2619, fragment_unnamed_2620 = fragment_unnamed_2621, fragment_unnamed_2622 = fragment_unnamed_2623, fragment_unnamed_2624 = asfloat(asuint(fragment_unnamed_2624) + 1u))
				{
					float frontier_phi_63_pred;
					float frontier_phi_63_pred_1;
					float frontier_phi_63_pred_2;
					float frontier_phi_63_pred_3;
					float frontier_phi_63_pred_4;
					float frontier_phi_63_pred_5;
					if ((fragment_unnamed_472 & T5.Load((asuint(fragment_unnamed_2624) * 44u) + 3u).x) != 0u)
					{
						uint fragment_unnamed_3443 = (asuint(fragment_unnamed_2624) * 44u) + 4u;
						uint4 fragment_unnamed_3455 = uint4(T5.Load(fragment_unnamed_3443).x, T5.Load(fragment_unnamed_3443 + 1u).x, T5.Load(fragment_unnamed_3443 + 2u).x, T5.Load(fragment_unnamed_3443 + 3u).x);
						float fragment_unnamed_3457 = asfloat(fragment_unnamed_3455.x);
						float fragment_unnamed_3459 = asfloat(fragment_unnamed_3455.y);
						float fragment_unnamed_3461 = asfloat(fragment_unnamed_3455.z);
						uint fragment_unnamed_3462 = fragment_unnamed_3455.w;
						uint fragment_unnamed_3465 = (asuint(fragment_unnamed_2624) * 44u) + 36u;
						uint3 fragment_unnamed_3474 = uint3(T5.Load(fragment_unnamed_3465).x, T5.Load(fragment_unnamed_3465 + 1u).x, T5.Load(fragment_unnamed_3465 + 2u).x);
						float fragment_unnamed_3476 = asfloat(fragment_unnamed_3474.x);
						float fragment_unnamed_3478 = asfloat(fragment_unnamed_3474.y);
						float fragment_unnamed_3486 = dot(float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466), float3((-0.0f) - fragment_unnamed_3457, (-0.0f) - fragment_unnamed_3459, (-0.0f) - fragment_unnamed_3461));
						float fragment_unnamed_4657;
						float fragment_unnamed_4659;
						float fragment_unnamed_4661;
						float fragment_unnamed_4663;
						float fragment_unnamed_4665;
						float fragment_unnamed_4667;
						if ((((0.0f < asfloat(fragment_unnamed_3474.z)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_3486) ? 4294967295u : 0u)) != 0u)
						{
							uint fragment_unnamed_3860 = (asuint(fragment_unnamed_2624) * 44u) + 12u;
							uint4 fragment_unnamed_3872 = uint4(T5.Load(fragment_unnamed_3860).x, T5.Load(fragment_unnamed_3860 + 1u).x, T5.Load(fragment_unnamed_3860 + 2u).x, T5.Load(fragment_unnamed_3860 + 3u).x);
							float fragment_unnamed_3874 = asfloat(fragment_unnamed_3872.x);
							float fragment_unnamed_3876 = asfloat(fragment_unnamed_3872.y);
							float fragment_unnamed_3878 = asfloat(fragment_unnamed_3872.z);
							uint fragment_unnamed_3882 = (asuint(fragment_unnamed_2624) * 44u) + 16u;
							uint3 fragment_unnamed_3891 = uint3(T5.Load(fragment_unnamed_3882).x, T5.Load(fragment_unnamed_3882 + 1u).x, T5.Load(fragment_unnamed_3882 + 2u).x);
							float fragment_unnamed_3893 = asfloat(fragment_unnamed_3891.x);
							float fragment_unnamed_3895 = asfloat(fragment_unnamed_3891.y);
							float fragment_unnamed_3897 = asfloat(fragment_unnamed_3891.z);
							uint fragment_unnamed_3900 = (asuint(fragment_unnamed_2624) * 44u) + 20u;
							uint3 fragment_unnamed_3909 = uint3(T5.Load(fragment_unnamed_3900).x, T5.Load(fragment_unnamed_3900 + 1u).x, T5.Load(fragment_unnamed_3900 + 2u).x);
							float fragment_unnamed_3911 = asfloat(fragment_unnamed_3909.x);
							float fragment_unnamed_3913 = asfloat(fragment_unnamed_3909.y);
							float fragment_unnamed_3915 = asfloat(fragment_unnamed_3909.z);
							uint fragment_unnamed_3918 = (asuint(fragment_unnamed_2624) * 44u) + 24u;
							uint4 fragment_unnamed_3930 = uint4(T5.Load(fragment_unnamed_3918).x, T5.Load(fragment_unnamed_3918 + 1u).x, T5.Load(fragment_unnamed_3918 + 2u).x, T5.Load(fragment_unnamed_3918 + 3u).x);
							float fragment_unnamed_3932 = asfloat(fragment_unnamed_3930.x);
							float fragment_unnamed_3934 = asfloat(fragment_unnamed_3930.y);
							float fragment_unnamed_3936 = asfloat(fragment_unnamed_3930.z);
							float fragment_unnamed_3938 = asfloat(fragment_unnamed_3930.w);
							float fragment_unnamed_3944 = asfloat(T5.Load((asuint(fragment_unnamed_2624) * 44u) + 40u).x);
							float fragment_unnamed_3957 = 1.0f / max(dot(float3((-0.0f) - fragment_unnamed_3457, (-0.0f) - fragment_unnamed_3459, (-0.0f) - fragment_unnamed_3461), float3(fragment_uniform_buffer_1[83u].xyz)), 0.001000000047497451305389404296875f);
							float fragment_unnamed_3970 = exp2((mad(fragment_unnamed_2259, fragment_unnamed_3957 * fragment_uniform_buffer_1[90u].y, max(fragment_unnamed_2250 * fragment_unnamed_3957, 0.0f)) * fragment_uniform_buffer_1[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_4647;
							float fragment_unnamed_4648;
							float fragment_unnamed_4649;
							if (fragment_unnamed_3462 != 0u)
							{
								uint fragment_unnamed_4532 = asuint(fragment_unnamed_2624) * 44u;
								uint3 fragment_unnamed_4541 = uint3(T5.Load(fragment_unnamed_4532).x, T5.Load(fragment_unnamed_4532 + 1u).x, T5.Load(fragment_unnamed_4532 + 2u).x);
								uint fragment_unnamed_4550 = (asuint(fragment_unnamed_2624) * 44u) + 8u;
								uint4 fragment_unnamed_4562 = uint4(T5.Load(fragment_unnamed_4550).x, T5.Load(fragment_unnamed_4550 + 1u).x, T5.Load(fragment_unnamed_4550 + 2u).x, T5.Load(fragment_unnamed_4550 + 3u).x);
								float fragment_unnamed_4564 = asfloat(fragment_unnamed_4562.x);
								float fragment_unnamed_4566 = asfloat(fragment_unnamed_4562.y);
								float fragment_unnamed_4580 = ((-0.0f) - asfloat(fragment_unnamed_4541.x)) + fragment_input_6.x;
								float fragment_unnamed_4581 = ((-0.0f) - asfloat(fragment_unnamed_4541.y)) + fragment_input_6.y;
								float fragment_unnamed_4582 = ((-0.0f) - asfloat(fragment_unnamed_4541.z)) + fragment_input_6.z;
								float fragment_unnamed_4589 = mad(dot(float3(fragment_unnamed_4580, fragment_unnamed_4581, fragment_unnamed_4582), float3(fragment_unnamed_3874, fragment_unnamed_3876, fragment_unnamed_3878)), 0.5f, 0.5f);
								float fragment_unnamed_4590 = mad(dot(float3(fragment_unnamed_4580, fragment_unnamed_4581, fragment_unnamed_4582), float3(fragment_unnamed_3893, fragment_unnamed_3895, fragment_unnamed_3897)), 0.5f, 0.5f);
								bool fragment_unnamed_4591 = fragment_unnamed_3462 == 2u;
								float fragment_unnamed_4607 = 1.0f / (fragment_unnamed_4564 + fragment_uniform_buffer_1[123u].y);
								float fragment_unnamed_4608 = 1.0f / (fragment_unnamed_4566 + fragment_uniform_buffer_1[123u].y);
								float fragment_unnamed_4620 = fragment_unnamed_4564 * fragment_uniform_buffer_1[123u].x;
								float fragment_unnamed_4621 = fragment_unnamed_4566 * fragment_uniform_buffer_1[123u].x;
								float fragment_unnamed_4624 = fragment_unnamed_1231 / (fragment_unnamed_4620 + fragment_unnamed_4620);
								float fragment_unnamed_4625 = fragment_unnamed_1231 / (fragment_unnamed_4621 + fragment_unnamed_4621);
								float4 fragment_unnamed_4639 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_4624) + 1.0f, max(fragment_unnamed_4624, mad(asfloat(fragment_unnamed_4591 ? asuint(frac(fragment_unnamed_4589)) : asuint(fragment_unnamed_4589)), fragment_unnamed_4564 * fragment_unnamed_4607, mad((-0.0f) - fragment_unnamed_4607, fragment_unnamed_4564, 1.0f) * 0.5f))), fragment_unnamed_4564, asfloat(fragment_unnamed_4562.z)), mad(min(((-0.0f) - fragment_unnamed_4625) + 1.0f, max(fragment_unnamed_4625, mad(asfloat(fragment_unnamed_4591 ? asuint(frac(fragment_unnamed_4590)) : asuint(fragment_unnamed_4590)), fragment_unnamed_4566 * fragment_unnamed_4608, mad((-0.0f) - fragment_unnamed_4608, fragment_unnamed_4566, 1.0f) * 0.5f))), fragment_unnamed_4566, asfloat(fragment_unnamed_4562.w))), 0.0f);
								fragment_unnamed_4647 = fragment_unnamed_3911 * fragment_unnamed_4639.x;
								fragment_unnamed_4648 = fragment_unnamed_3913 * fragment_unnamed_4639.y;
								fragment_unnamed_4649 = fragment_unnamed_3915 * fragment_unnamed_4639.z;
							}
							else
							{
								fragment_unnamed_4647 = fragment_unnamed_3911;
								fragment_unnamed_4648 = fragment_unnamed_3913;
								fragment_unnamed_4649 = fragment_unnamed_3915;
							}
							uint fragment_unnamed_4654 = (int(fragment_unnamed_3872.w) >= int(0u)) ? 4294967295u : 0u;
							float fragment_unnamed_6068;
							float fragment_unnamed_6069;
							float fragment_unnamed_6070;
							if ((fragment_unnamed_2265 & fragment_unnamed_4654) != 0u)
							{
								float fragment_unnamed_5192 = rsqrt(dot(float3(fragment_unnamed_3874, fragment_unnamed_3876, fragment_unnamed_3878), float3(fragment_unnamed_3874, fragment_unnamed_3876, fragment_unnamed_3878)));
								float fragment_unnamed_5196 = dot(float3(fragment_unnamed_2280, fragment_unnamed_2281, fragment_unnamed_2282), float3(fragment_unnamed_5192 * fragment_unnamed_3874, fragment_unnamed_5192 * fragment_unnamed_3876, fragment_unnamed_5192 * fragment_unnamed_3878));
								float fragment_unnamed_5206 = clamp(fragment_unnamed_5196 / fragment_uniform_buffer_1[217u].x, 0.0f, 1.0f);
								float fragment_unnamed_5210 = rsqrt(dot(float3(fragment_unnamed_3893, fragment_unnamed_3895, fragment_unnamed_3897), float3(fragment_unnamed_3893, fragment_unnamed_3895, fragment_unnamed_3897)));
								float fragment_unnamed_5214 = dot(float3(fragment_unnamed_2280, fragment_unnamed_2281, fragment_unnamed_2282), float3(fragment_unnamed_5210 * fragment_unnamed_3893, fragment_unnamed_5210 * fragment_unnamed_3895, fragment_unnamed_5210 * fragment_unnamed_3897));
								float fragment_unnamed_5223 = clamp(fragment_unnamed_5214 / fragment_uniform_buffer_1[217u].y, 0.0f, 1.0f);
								float fragment_unnamed_5224 = dot(float3(fragment_unnamed_3457, fragment_unnamed_3459, fragment_unnamed_3461), float3(fragment_unnamed_3457, fragment_unnamed_3459, fragment_unnamed_3461));
								float fragment_unnamed_5227 = dot(float3(fragment_unnamed_3457, fragment_unnamed_3459, fragment_unnamed_3461), float3(fragment_unnamed_2298, fragment_unnamed_2299, fragment_unnamed_2300));
								float fragment_unnamed_5230 = fragment_unnamed_5227 + fragment_unnamed_5227;
								float4 fragment_unnamed_5246 = _VolumetricCloudsShadowsTexture.SampleLevel(S0, float2(fragment_unnamed_5206, fragment_unnamed_5223), 0.0f);
								float fragment_unnamed_5248 = fragment_unnamed_5246.x;
								float fragment_unnamed_5249 = fragment_unnamed_5246.y;
								float fragment_unnamed_5280 = asfloat((((((fragment_unnamed_5223 != 1.0f) ? 4294967295u : 0u) & ((fragment_unnamed_5206 != 1.0f) ? 4294967295u : 0u)) & (((clamp(fragment_unnamed_5214 / fragment_uniform_buffer_1[217u].y, 0.0f, 1.0f) != 0.0f) ? 4294967295u : 0u) & ((clamp(fragment_unnamed_5196 / fragment_uniform_buffer_1[217u].x, 0.0f, 1.0f) != 0.0f) ? 4294967295u : 0u))) != 0u) ? ((fragment_unnamed_5249 != 1.0f) ? asuint(mad(clamp(((mad((-0.0f) - float(int(-((0.0f < fragment_unnamed_5224) ? 4294967295u : 0u))), sqrt(mad(fragment_unnamed_5230, fragment_unnamed_5230, (-0.0f) - ((fragment_unnamed_2312 * fragment_unnamed_5224) * 4.0f))), (-0.0f) - fragment_unnamed_5230) / (fragment_unnamed_5224 + fragment_unnamed_5224)) + ((-0.0f) - fragment_unnamed_5248)) / (((-0.0f) - fragment_unnamed_5248) + fragment_unnamed_5246.z), 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_5249) + 1.0f, fragment_unnamed_5249)) : 1065353216u) : asuint(fragment_uniform_buffer_1[217u]).w);
								fragment_unnamed_6068 = fragment_unnamed_1121 * fragment_unnamed_5280;
								fragment_unnamed_6069 = fragment_unnamed_1123 * fragment_unnamed_5280;
								fragment_unnamed_6070 = fragment_unnamed_1125 * fragment_unnamed_5280;
							}
							else
							{
								fragment_unnamed_6068 = fragment_unnamed_1121;
								fragment_unnamed_6069 = fragment_unnamed_1123;
								fragment_unnamed_6070 = fragment_unnamed_1125;
							}
							bool fragment_unnamed_6080 = (fragment_unnamed_4654 & ((0.0f < fragment_unnamed_3938) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_6085 = asfloat(fragment_unnamed_6080 ? asuint(mad(fragment_unnamed_3938, fragment_unnamed_6068 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6087 = asfloat(fragment_unnamed_6080 ? asuint(mad(fragment_unnamed_3938, fragment_unnamed_6069 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6089 = asfloat(fragment_unnamed_6080 ? asuint(mad(fragment_unnamed_3938, fragment_unnamed_6070 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6101 = asfloat((fragment_unnamed_3486 >= 0.0f) ? asuint(mad(fragment_uniform_buffer_1[121u].x, clamp(fragment_unnamed_3486 + 1.0f, 0.0f, 1.0f) + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6102 = fragment_unnamed_6101 * fragment_unnamed_6085;
							float fragment_unnamed_6103 = fragment_unnamed_6101 * fragment_unnamed_6087;
							float fragment_unnamed_6104 = fragment_unnamed_6101 * fragment_unnamed_6089;
							float fragment_unnamed_6108 = ((-0.0f) - fragment_unnamed_3932) + 1.0f;
							float fragment_unnamed_6109 = ((-0.0f) - fragment_unnamed_3934) + 1.0f;
							float fragment_unnamed_6110 = ((-0.0f) - fragment_unnamed_3936) + 1.0f;
							float fragment_unnamed_6126 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6085, fragment_unnamed_6101, 1.0f), fragment_unnamed_6108, 1.0f);
							float fragment_unnamed_6127 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6087, fragment_unnamed_6101, 1.0f), fragment_unnamed_6109, 1.0f);
							float fragment_unnamed_6128 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6089, fragment_unnamed_6101, 1.0f), fragment_unnamed_6110, 1.0f);
							float fragment_unnamed_6144 = mad(fragment_unnamed_3944, ((-0.0f) - fragment_unnamed_6126) + mad(fragment_unnamed_6102 * (fragment_unnamed_6102 * fragment_unnamed_6102), fragment_unnamed_6108, fragment_unnamed_3932 * fragment_unnamed_6102), fragment_unnamed_6126) * (fragment_unnamed_3970 * fragment_unnamed_4647);
							float fragment_unnamed_6145 = mad(fragment_unnamed_3944, ((-0.0f) - fragment_unnamed_6127) + mad(fragment_unnamed_6103 * (fragment_unnamed_6103 * fragment_unnamed_6103), fragment_unnamed_6109, fragment_unnamed_3934 * fragment_unnamed_6103), fragment_unnamed_6127) * (fragment_unnamed_3970 * fragment_unnamed_4648);
							float fragment_unnamed_6146 = mad(fragment_unnamed_3944, ((-0.0f) - fragment_unnamed_6128) + mad(fragment_unnamed_6104 * (fragment_unnamed_6104 * fragment_unnamed_6104), fragment_unnamed_6110, fragment_unnamed_3936 * fragment_unnamed_6104), fragment_unnamed_6128) * (fragment_unnamed_3970 * fragment_unnamed_4649);
							float fragment_unnamed_4658;
							float fragment_unnamed_4660;
							float fragment_unnamed_4662;
							float fragment_unnamed_4664;
							float fragment_unnamed_4666;
							float fragment_unnamed_4668;
							if (0.0f < max(fragment_unnamed_6146, max(fragment_unnamed_6145, fragment_unnamed_6144)))
							{
								float fragment_unnamed_6509 = max(fragment_unnamed_848, asfloat(T5.Load((asuint(fragment_unnamed_2624) * 44u) + 30u).x));
								float fragment_unnamed_6510 = clamp(fragment_unnamed_3486, 0.0f, 1.0f);
								float fragment_unnamed_6514 = dot(float3((-0.0f) - fragment_unnamed_3457, (-0.0f) - fragment_unnamed_3459, (-0.0f) - fragment_unnamed_3461), float3(fragment_unnamed_335, fragment_unnamed_336, fragment_unnamed_337));
								float fragment_unnamed_6519 = rsqrt(max(mad(fragment_unnamed_6514, 2.0f, 2.0f), 5.9604644775390625e-08f));
								float fragment_unnamed_6522 = clamp(fragment_unnamed_6519 * (fragment_unnamed_763 + fragment_unnamed_3486), 0.0f, 1.0f);
								float fragment_unnamed_6526 = ((-0.0f) - clamp(mad(fragment_unnamed_6519, fragment_unnamed_6514, fragment_unnamed_6519), 0.0f, 1.0f)) + 1.0f;
								float fragment_unnamed_6527 = fragment_unnamed_6526 * fragment_unnamed_6526;
								float fragment_unnamed_6528 = fragment_unnamed_6527 * fragment_unnamed_6527;
								float fragment_unnamed_6531 = mad((-0.0f) - fragment_unnamed_6528, fragment_unnamed_6526, 1.0f);
								float fragment_unnamed_6532 = fragment_unnamed_847 * (fragment_unnamed_6526 * fragment_unnamed_6528);
								float fragment_unnamed_6536 = fragment_unnamed_6509 * fragment_unnamed_6509;
								float fragment_unnamed_6539 = mad(mad(fragment_unnamed_6522, fragment_unnamed_6536, (-0.0f) - fragment_unnamed_6522), fragment_unnamed_6522, 1.0f);
								float fragment_unnamed_6554 = (fragment_unnamed_6536 * 0.15915493667125701904296875f) / max((fragment_unnamed_6539 * fragment_unnamed_6539) * mad(abs(fragment_unnamed_3486), fragment_unnamed_867, fragment_unnamed_766 * sqrt(mad(mad((-0.0f) - abs(fragment_unnamed_3486), fragment_unnamed_6536, abs(fragment_unnamed_3486)), abs(fragment_unnamed_3486), fragment_unnamed_6536))), 1.1754943508222875079687365372222e-38f);
								float fragment_unnamed_6561 = ((-0.0f) - abs(fragment_unnamed_3486)) + 1.0f;
								float fragment_unnamed_6562 = fragment_unnamed_6561 * fragment_unnamed_6561;
								float fragment_unnamed_6565 = mad(fragment_unnamed_747, fragment_unnamed_6514, fragment_unnamed_747) + (-0.5f);
								float fragment_unnamed_6570 = ((mad(fragment_unnamed_6565, fragment_unnamed_1233, 1.0f) * mad(fragment_unnamed_6565, fragment_unnamed_6561 * (fragment_unnamed_6562 * fragment_unnamed_6562), 1.0f)) * fragment_unnamed_6510) * 0.307334959506988525390625f;
								fragment_unnamed_4658 = fragment_unnamed_3478 * (fragment_unnamed_6144 * (fragment_unnamed_6510 * (fragment_unnamed_6554 * mad(fragment_unnamed_759, fragment_unnamed_6531, fragment_unnamed_6532))));
								fragment_unnamed_4660 = fragment_unnamed_3478 * (fragment_unnamed_6145 * (fragment_unnamed_6510 * (fragment_unnamed_6554 * mad(fragment_unnamed_761, fragment_unnamed_6531, fragment_unnamed_6532))));
								fragment_unnamed_4662 = fragment_unnamed_3478 * (fragment_unnamed_6146 * (fragment_unnamed_6510 * (fragment_unnamed_6554 * mad(fragment_unnamed_762, fragment_unnamed_6531, fragment_unnamed_6532))));
								fragment_unnamed_4664 = fragment_unnamed_3476 * (fragment_unnamed_6144 * fragment_unnamed_6570);
								fragment_unnamed_4666 = fragment_unnamed_3476 * (fragment_unnamed_6145 * fragment_unnamed_6570);
								fragment_unnamed_4668 = fragment_unnamed_3476 * (fragment_unnamed_6146 * fragment_unnamed_6570);
							}
							else
							{
								fragment_unnamed_4658 = asfloat(0u);
								fragment_unnamed_4660 = asfloat(0u);
								fragment_unnamed_4662 = asfloat(0u);
								fragment_unnamed_4664 = asfloat(0u);
								fragment_unnamed_4666 = asfloat(0u);
								fragment_unnamed_4668 = asfloat(0u);
							}
							fragment_unnamed_4657 = fragment_unnamed_4658;
							fragment_unnamed_4659 = fragment_unnamed_4660;
							fragment_unnamed_4661 = fragment_unnamed_4662;
							fragment_unnamed_4663 = fragment_unnamed_4664;
							fragment_unnamed_4665 = fragment_unnamed_4666;
							fragment_unnamed_4667 = fragment_unnamed_4668;
						}
						else
						{
							fragment_unnamed_4657 = asfloat(0u);
							fragment_unnamed_4659 = asfloat(0u);
							fragment_unnamed_4661 = asfloat(0u);
							fragment_unnamed_4663 = asfloat(0u);
							fragment_unnamed_4665 = asfloat(0u);
							fragment_unnamed_4667 = asfloat(0u);
						}
						frontier_phi_63_pred = fragment_unnamed_2622 + fragment_unnamed_4661;
						frontier_phi_63_pred_1 = fragment_unnamed_2618 + fragment_unnamed_4657;
						frontier_phi_63_pred_2 = fragment_unnamed_2616 + fragment_unnamed_4667;
						frontier_phi_63_pred_3 = fragment_unnamed_2614 + fragment_unnamed_4665;
						frontier_phi_63_pred_4 = fragment_unnamed_2612 + fragment_unnamed_4663;
						frontier_phi_63_pred_5 = fragment_unnamed_2620 + fragment_unnamed_4659;
					}
					else
					{
						frontier_phi_63_pred = fragment_unnamed_2622;
						frontier_phi_63_pred_1 = fragment_unnamed_2618;
						frontier_phi_63_pred_2 = fragment_unnamed_2616;
						frontier_phi_63_pred_3 = fragment_unnamed_2614;
						frontier_phi_63_pred_4 = fragment_unnamed_2612;
						frontier_phi_63_pred_5 = fragment_unnamed_2620;
					}
					fragment_unnamed_2623 = frontier_phi_63_pred;
					fragment_unnamed_2619 = frontier_phi_63_pred_1;
					fragment_unnamed_2617 = frontier_phi_63_pred_2;
					fragment_unnamed_2615 = frontier_phi_63_pred_3;
					fragment_unnamed_2613 = frontier_phi_63_pred_4;
					fragment_unnamed_2621 = frontier_phi_63_pred_5;
				}
				uint4 fragment_unnamed_2802 = T3.Load(((((fragment_unnamed_1190 + fragment_unnamed_1157) * fragment_unnamed_1351) + fragment_unnamed_276) * fragment_unnamed_1359) + fragment_unnamed_274);
				uint fragment_unnamed_2803 = fragment_unnamed_2802.x;
				uint fragment_unnamed_2804 = fragment_unnamed_2803 & 67108863u;
				uint fragment_unnamed_2805 = fragment_unnamed_2803 >> 26u;
				float fragment_unnamed_2807 = mad((-0.0f) - fragment_unnamed_894, fragment_unnamed_892, fragment_unnamed_891);
				float fragment_unnamed_2808 = fragment_unnamed_2807 * fragment_unnamed_893;
				float fragment_unnamed_2814 = clamp((((-0.0f) - fragment_unnamed_747) + 0.300000011920928955078125f) * 3.3333332538604736328125f, 0.0f, 1.0f);
				float fragment_unnamed_2816 = mad((-0.0f) - fragment_unnamed_900, fragment_unnamed_898, fragment_unnamed_897);
				float fragment_unnamed_2817 = fragment_unnamed_2816 * fragment_unnamed_899;
				float fragment_unnamed_2818 = asfloat(fragment_unnamed_904 ? asuint(fragment_unnamed_908 * fragment_unnamed_914) : asuint(fragment_unnamed_931));
				float fragment_unnamed_2819 = asfloat(fragment_unnamed_904 ? asuint(fragment_unnamed_915) : asuint(fragment_unnamed_932));
				float fragment_unnamed_2820 = asfloat(1065353216u);
				float fragment_unnamed_2821 = asfloat(1065353216u);
				float fragment_unnamed_2822 = asfloat(fragment_unnamed_904 ? asuint(fragment_unnamed_465) : asuint(mad(fragment_unnamed_464, fragment_unnamed_931, (-0.0f) - (fragment_unnamed_465 * fragment_unnamed_930))));
				float fragment_unnamed_2823 = asfloat(1065353216u);
				float fragment_unnamed_2824 = asfloat(1065353216u);
				float fragment_unnamed_2825 = asfloat(0u);
				float fragment_unnamed_3425;
				float fragment_unnamed_3427;
				float fragment_unnamed_3429;
				float fragment_unnamed_3431;
				float fragment_unnamed_3433;
				float fragment_unnamed_3435;
				float fragment_unnamed_3437;
				for (;;)
				{
					fragment_unnamed_3425 = fragment_unnamed_2612;
					fragment_unnamed_3427 = fragment_unnamed_2614;
					fragment_unnamed_3429 = fragment_unnamed_2616;
					fragment_unnamed_3431 = fragment_unnamed_2618;
					fragment_unnamed_3433 = fragment_unnamed_2620;
					fragment_unnamed_3435 = fragment_unnamed_2622;
					fragment_unnamed_3437 = fragment_unnamed_2825;
					float fragment_unnamed_3438;
					float fragment_unnamed_3426;
					float fragment_unnamed_3428;
					float fragment_unnamed_3430;
					float fragment_unnamed_3432;
					float fragment_unnamed_3434;
					float fragment_unnamed_3436;
					bool ladder_phi_85;
					for (;;)
					{
						if (asuint(fragment_unnamed_3437) >= fragment_unnamed_2805)
						{
							ladder_phi_85 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_3853 = asuint(fragment_unnamed_3437);
							uint4 fragment_unnamed_3855 = T2.Load(fragment_unnamed_2804 + fragment_unnamed_3853);
							uint fragment_unnamed_3856 = fragment_unnamed_3855.x;
							if (fragment_unnamed_3856 == 4294967295u)
							{
								ladder_phi_85 = false;
								break;
							}
							uint fragment_unnamed_4507 = fragment_unnamed_3856 * 56u;
							uint4 fragment_unnamed_4519 = uint4(T6.Load(fragment_unnamed_4507).x, T6.Load(fragment_unnamed_4507 + 1u).x, T6.Load(fragment_unnamed_4507 + 2u).x, T6.Load(fragment_unnamed_4507 + 3u).x);
							fragment_unnamed_3438 = asfloat(asuint(fragment_unnamed_3437) + 1u);
							if (!((fragment_unnamed_472 & fragment_unnamed_4519.w) != 0u))
							{
								fragment_unnamed_3426 = fragment_unnamed_3425;
								fragment_unnamed_3428 = fragment_unnamed_3427;
								fragment_unnamed_3430 = fragment_unnamed_3429;
								fragment_unnamed_3432 = fragment_unnamed_3431;
								fragment_unnamed_3434 = fragment_unnamed_3433;
								fragment_unnamed_3436 = fragment_unnamed_3435;
								fragment_unnamed_3425 = fragment_unnamed_3426;
								fragment_unnamed_3427 = fragment_unnamed_3428;
								fragment_unnamed_3429 = fragment_unnamed_3430;
								fragment_unnamed_3431 = fragment_unnamed_3432;
								fragment_unnamed_3433 = fragment_unnamed_3434;
								fragment_unnamed_3435 = fragment_unnamed_3436;
								fragment_unnamed_3437 = fragment_unnamed_3438;
								continue;
							}
							uint fragment_unnamed_4992 = (fragment_unnamed_3856 * 56u) + 8u;
							uint3 fragment_unnamed_5001 = uint3(T6.Load(fragment_unnamed_4992).x, T6.Load(fragment_unnamed_4992 + 1u).x, T6.Load(fragment_unnamed_4992 + 2u).x);
							uint fragment_unnamed_5009 = (fragment_unnamed_3856 * 56u) + 12u;
							uint4 fragment_unnamed_5021 = uint4(T6.Load(fragment_unnamed_5009).x, T6.Load(fragment_unnamed_5009 + 1u).x, T6.Load(fragment_unnamed_5009 + 2u).x, T6.Load(fragment_unnamed_5009 + 3u).x);
							float fragment_unnamed_5024 = asfloat(fragment_unnamed_5021.y);
							float fragment_unnamed_5026 = asfloat(fragment_unnamed_5021.z);
							float fragment_unnamed_5028 = asfloat(fragment_unnamed_5021.w);
							uint fragment_unnamed_5030 = (fragment_unnamed_3856 * 56u) + 18u;
							uint4 fragment_unnamed_5042 = uint4(T6.Load(fragment_unnamed_5030).x, T6.Load(fragment_unnamed_5030 + 1u).x, T6.Load(fragment_unnamed_5030 + 2u).x, T6.Load(fragment_unnamed_5030 + 3u).x);
							uint fragment_unnamed_5043 = fragment_unnamed_5042.x;
							uint fragment_unnamed_5044 = fragment_unnamed_5042.y;
							uint fragment_unnamed_5048 = (fragment_unnamed_3856 * 56u) + 22u;
							uint4 fragment_unnamed_5060 = uint4(T6.Load(fragment_unnamed_5048).x, T6.Load(fragment_unnamed_5048 + 1u).x, T6.Load(fragment_unnamed_5048 + 2u).x, T6.Load(fragment_unnamed_5048 + 3u).x);
							float fragment_unnamed_5062 = asfloat(fragment_unnamed_5060.z);
							float fragment_unnamed_5064 = asfloat(fragment_unnamed_5060.w);
							uint fragment_unnamed_5069 = (fragment_unnamed_3856 * 56u) + 26u;
							uint4 fragment_unnamed_5081 = uint4(T6.Load(fragment_unnamed_5069).x, T6.Load(fragment_unnamed_5069 + 1u).x, T6.Load(fragment_unnamed_5069 + 2u).x, T6.Load(fragment_unnamed_5069 + 3u).x);
							uint fragment_unnamed_5082 = fragment_unnamed_5081.x;
							float fragment_unnamed_5086 = asfloat(fragment_unnamed_5081.z);
							float fragment_unnamed_5088 = asfloat(fragment_unnamed_5081.w);
							uint fragment_unnamed_5090 = (fragment_unnamed_3856 * 56u) + 30u;
							uint4 fragment_unnamed_5102 = uint4(T6.Load(fragment_unnamed_5090).x, T6.Load(fragment_unnamed_5090 + 1u).x, T6.Load(fragment_unnamed_5090 + 2u).x, T6.Load(fragment_unnamed_5090 + 3u).x);
							float fragment_unnamed_5104 = asfloat(fragment_unnamed_5102.x);
							float fragment_unnamed_5106 = asfloat(fragment_unnamed_5102.y);
							uint fragment_unnamed_5110 = (fragment_unnamed_3856 * 56u) + 44u;
							uint2 fragment_unnamed_5116 = uint2(T6.Load(fragment_unnamed_5110).x, T6.Load(fragment_unnamed_5110 + 1u).x);
							float fragment_unnamed_5118 = asfloat(fragment_unnamed_5116.x);
							float fragment_unnamed_5120 = asfloat(fragment_unnamed_5116.y);
							bool fragment_unnamed_5121 = fragment_unnamed_5021.x == 6u;
							uint fragment_unnamed_5122 = fragment_unnamed_5121 ? 4294967295u : 0u;
							float fragment_unnamed_5132 = asfloat(fragment_unnamed_4519.x) + ((-0.0f) - fragment_input_6.x);
							float fragment_unnamed_5133 = asfloat(fragment_unnamed_4519.y) + ((-0.0f) - fragment_input_6.y);
							float fragment_unnamed_5134 = asfloat(fragment_unnamed_4519.z) + ((-0.0f) - fragment_input_6.z);
							float fragment_unnamed_5135 = fragment_unnamed_5118 * 0.5f;
							float fragment_unnamed_5136 = fragment_unnamed_5120 * 0.5f;
							float fragment_unnamed_5137 = dot(float3(fragment_unnamed_5132, fragment_unnamed_5133, fragment_unnamed_5134), float3(fragment_unnamed_5024, fragment_unnamed_5026, fragment_unnamed_5028));
							float fragment_unnamed_5143 = max(mad((-0.0f) - fragment_unnamed_5118, 0.5f, abs(fragment_unnamed_5137)), 0.0f);
							float fragment_unnamed_5144 = asfloat(fragment_unnamed_5042.z);
							float fragment_unnamed_5145 = asfloat(fragment_unnamed_5042.w);
							float fragment_unnamed_5146 = asfloat(fragment_unnamed_5060.x);
							float fragment_unnamed_5147 = dot(float3(fragment_unnamed_5132, fragment_unnamed_5133, fragment_unnamed_5134), float3(fragment_unnamed_5144, fragment_unnamed_5145, fragment_unnamed_5146));
							float fragment_unnamed_5153 = max(mad((-0.0f) - fragment_unnamed_5120, 0.5f, abs(fragment_unnamed_5147)), 0.0f);
							float fragment_unnamed_5164 = asfloat(fragment_unnamed_5060.y) * mad(fragment_unnamed_5153, fragment_unnamed_5153, mad(fragment_unnamed_5143, fragment_unnamed_5143, max(mad((-0.0f) - fragment_unnamed_5147, fragment_unnamed_5147, mad((-0.0f) - fragment_unnamed_5137, fragment_unnamed_5137, dot(float3(fragment_unnamed_5132, fragment_unnamed_5133, fragment_unnamed_5134), float3(fragment_unnamed_5132, fragment_unnamed_5133, fragment_unnamed_5134)))), 0.0f)));
							float fragment_unnamed_5167 = clamp(mad((-0.0f) - fragment_unnamed_5164, fragment_unnamed_5164, asfloat(fragment_unnamed_5081.y)), 0.0f, 1.0f);
							float fragment_unnamed_5178 = asfloat(((fragment_unnamed_5122 & ((dot(float3(fragment_unnamed_5132, fragment_unnamed_5133, fragment_unnamed_5134), float3(asfloat(fragment_unnamed_5001.x), asfloat(fragment_unnamed_5001.y), asfloat(fragment_unnamed_5001.z))) >= 0.0f) ? 4294967295u : 0u)) != 0u) ? 0u : asuint(fragment_unnamed_5167 * fragment_unnamed_5167));
							uint fragment_unnamed_5180 = (0.0f < fragment_unnamed_5178) ? 4294967295u : 0u;
							float fragment_unnamed_6492;
							float fragment_unnamed_6494;
							float fragment_unnamed_6496;
							float fragment_unnamed_6498;
							if ((fragment_unnamed_5122 & fragment_unnamed_5180) != 0u)
							{
								float fragment_unnamed_6047 = asfloat(T6.Load((fragment_unnamed_3856 * 56u) + 16u).x);
								uint fragment_unnamed_6049 = (fragment_unnamed_3856 * 56u) + 34u;
								uint2 fragment_unnamed_6055 = uint2(T6.Load(fragment_unnamed_6049).x, T6.Load(fragment_unnamed_6049 + 1u).x);
								float fragment_unnamed_6057 = asfloat(fragment_unnamed_6055.x);
								float fragment_unnamed_6059 = asfloat(fragment_unnamed_6055.y);
								float fragment_unnamed_6950;
								if ((((int(fragment_unnamed_5044) >= int(0u)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_6059) ? 4294967295u : 0u)) != 0u)
								{
									uint fragment_unnamed_6340 = fragment_unnamed_5044 * 60u;
									uint4 fragment_unnamed_6352 = uint4(T27.Load(fragment_unnamed_6340).x, T27.Load(fragment_unnamed_6340 + 1u).x, T27.Load(fragment_unnamed_6340 + 2u).x, T27.Load(fragment_unnamed_6340 + 3u).x);
									float fragment_unnamed_6354 = asfloat(fragment_unnamed_6352.w);
									float fragment_unnamed_6356 = asfloat(fragment_unnamed_6352.x);
									float fragment_unnamed_6358 = asfloat(fragment_unnamed_6352.y);
									float fragment_unnamed_6360 = asfloat(fragment_unnamed_6352.z);
									uint fragment_unnamed_6362 = (fragment_unnamed_5044 * 60u) + 4u;
									uint4 fragment_unnamed_6374 = uint4(T27.Load(fragment_unnamed_6362).x, T27.Load(fragment_unnamed_6362 + 1u).x, T27.Load(fragment_unnamed_6362 + 2u).x, T27.Load(fragment_unnamed_6362 + 3u).x);
									uint fragment_unnamed_6375 = fragment_unnamed_6374.x;
									uint fragment_unnamed_6376 = fragment_unnamed_6374.y;
									uint fragment_unnamed_6377 = fragment_unnamed_6374.z;
									uint fragment_unnamed_6378 = fragment_unnamed_6374.w;
									uint fragment_unnamed_6380 = (fragment_unnamed_5044 * 60u) + 8u;
									uint4 fragment_unnamed_6392 = uint4(T27.Load(fragment_unnamed_6380).x, T27.Load(fragment_unnamed_6380 + 1u).x, T27.Load(fragment_unnamed_6380 + 2u).x, T27.Load(fragment_unnamed_6380 + 3u).x);
									float fragment_unnamed_6394 = asfloat(fragment_unnamed_6392.y);
									float fragment_unnamed_6396 = asfloat(fragment_unnamed_6392.z);
									float fragment_unnamed_6398 = asfloat(fragment_unnamed_6392.x);
									uint fragment_unnamed_6399 = fragment_unnamed_6392.w;
									uint fragment_unnamed_6401 = (fragment_unnamed_5044 * 60u) + 12u;
									uint4 fragment_unnamed_6413 = uint4(T27.Load(fragment_unnamed_6401).x, T27.Load(fragment_unnamed_6401 + 1u).x, T27.Load(fragment_unnamed_6401 + 2u).x, T27.Load(fragment_unnamed_6401 + 3u).x);
									float fragment_unnamed_6415 = asfloat(fragment_unnamed_6413.x);
									float fragment_unnamed_6417 = asfloat(fragment_unnamed_6413.y);
									float fragment_unnamed_6419 = asfloat(fragment_unnamed_6413.z);
									float fragment_unnamed_6421 = asfloat(fragment_unnamed_6413.w);
									uint fragment_unnamed_6423 = (fragment_unnamed_5044 * 60u) + 16u;
									uint2 fragment_unnamed_6429 = uint2(T27.Load(fragment_unnamed_6423).x, T27.Load(fragment_unnamed_6423 + 1u).x);
									float fragment_unnamed_6431 = asfloat(fragment_unnamed_6429.x);
									float fragment_unnamed_6433 = asfloat(fragment_unnamed_6429.y);
									uint fragment_unnamed_6435 = (fragment_unnamed_5044 * 60u) + 24u;
									uint2 fragment_unnamed_6441 = uint2(T27.Load(fragment_unnamed_6435).x, T27.Load(fragment_unnamed_6435 + 1u).x);
									float fragment_unnamed_6443 = asfloat(fragment_unnamed_6441.x);
									float fragment_unnamed_6445 = asfloat(fragment_unnamed_6441.y);
									uint fragment_unnamed_6447 = (fragment_unnamed_5044 * 60u) + 28u;
									uint4 fragment_unnamed_6459 = uint4(T27.Load(fragment_unnamed_6447).x, T27.Load(fragment_unnamed_6447 + 1u).x, T27.Load(fragment_unnamed_6447 + 2u).x, T27.Load(fragment_unnamed_6447 + 3u).x);
									float fragment_unnamed_6461 = asfloat(fragment_unnamed_6459.x);
									float fragment_unnamed_6463 = asfloat(fragment_unnamed_6459.y);
									float fragment_unnamed_6465 = asfloat(fragment_unnamed_6459.z);
									float fragment_unnamed_6467 = asfloat(fragment_unnamed_6459.w);
									uint fragment_unnamed_6469 = (fragment_unnamed_5044 * 60u) + 40u;
									uint4 fragment_unnamed_6481 = uint4(T27.Load(fragment_unnamed_6469).x, T27.Load(fragment_unnamed_6469 + 1u).x, T27.Load(fragment_unnamed_6469 + 2u).x, T27.Load(fragment_unnamed_6469 + 3u).x);
									float fragment_unnamed_6483 = asfloat(fragment_unnamed_6481.x);
									float fragment_unnamed_6485 = asfloat(fragment_unnamed_6481.y);
									float fragment_unnamed_6487 = asfloat(fragment_unnamed_6481.z);
									float fragment_unnamed_6489 = asfloat(fragment_unnamed_6481.w);
									float fragment_unnamed_7334;
									if (0.0f < fragment_unnamed_6489)
									{
										bool fragment_unnamed_6690 = 0.0f != fragment_unnamed_6489;
										uint4 fragment_unnamed_6694 = asuint(fragment_uniform_buffer_1[101u]);
										uint4 fragment_unnamed_6700 = asuint(fragment_uniform_buffer_1[99u]);
										float fragment_unnamed_6704 = asfloat(fragment_unnamed_6690 ? fragment_unnamed_6694.z : fragment_unnamed_6700.z);
										float fragment_unnamed_6706 = asfloat(fragment_unnamed_6690 ? fragment_unnamed_6694.w : fragment_unnamed_6700.w);
										float fragment_unnamed_6720 = ((-0.0f) - fragment_unnamed_6394) + (fragment_unnamed_6483 + fragment_input_6.x);
										float fragment_unnamed_6721 = ((-0.0f) - fragment_unnamed_6396) + (fragment_unnamed_6485 + fragment_input_6.y);
										float fragment_unnamed_6722 = ((-0.0f) - asfloat(fragment_unnamed_6399)) + (fragment_unnamed_6487 + fragment_input_6.z);
										float fragment_unnamed_6733 = dot(float3(asfloat(fragment_unnamed_6377), asfloat(fragment_unnamed_6378), fragment_unnamed_6398), float3(fragment_unnamed_6720, fragment_unnamed_6721, fragment_unnamed_6722));
										float fragment_unnamed_6736 = dot(float3(fragment_unnamed_6356, fragment_unnamed_6358, fragment_unnamed_6360), float3(fragment_unnamed_6720, fragment_unnamed_6721, fragment_unnamed_6722)) * fragment_unnamed_6415;
										float fragment_unnamed_6737 = dot(float3(fragment_unnamed_6354, asfloat(fragment_unnamed_6375), asfloat(fragment_unnamed_6376)), float3(fragment_unnamed_6720, fragment_unnamed_6721, fragment_unnamed_6722)) * fragment_unnamed_6417;
										float fragment_unnamed_6738 = dot(float2(fragment_unnamed_6419, fragment_unnamed_6421), float2(fragment_unnamed_6733, fragment_unnamed_2820));
										bool fragment_unnamed_6741 = fragment_unnamed_6733 != (-0.0f);
										float fragment_unnamed_6742 = (-0.0f) - fragment_unnamed_6733;
										float fragment_unnamed_6764 = mad(fragment_unnamed_6443 * clamp(mad(asfloat(fragment_unnamed_6741 ? asuint(fragment_unnamed_6736 / fragment_unnamed_6742) : asuint(fragment_unnamed_6736)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6704, fragment_unnamed_6431);
										float fragment_unnamed_6765 = mad(fragment_unnamed_6445 * clamp(mad(asfloat(fragment_unnamed_6741 ? asuint(fragment_unnamed_6737 / fragment_unnamed_6742) : asuint(fragment_unnamed_6737)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6706, fragment_unnamed_6433);
										float fragment_unnamed_6766 = trunc(mad(min(fragment_unnamed_6467, 4.0f), 4.0f, 1.0f));
										float fragment_unnamed_6767 = (-0.0f) - fragment_unnamed_6766;
										float4 fragment_unnamed_6788 = _CachedAreaLightShadowmapAtlas.SampleLevel(S0, float2(fragment_unnamed_6764, fragment_unnamed_6765), 0.0f);
										float fragment_unnamed_6790 = fragment_unnamed_6788.x;
										float fragment_unnamed_6794 = exp2(mad(((-0.0f) - asfloat(fragment_unnamed_6741 ? asuint(fragment_unnamed_6738 / fragment_unnamed_6742) : asuint(fragment_unnamed_6738))) + 1.0f, 2.0f, -1.0f) * fragment_unnamed_6461);
										float fragment_unnamed_6795 = fragment_unnamed_6794 * fragment_unnamed_6461;
										float fragment_unnamed_6800 = max(fragment_unnamed_6465 * (fragment_unnamed_6795 * fragment_unnamed_6795), mad((-0.0f) - fragment_unnamed_6790, fragment_unnamed_6790, fragment_unnamed_6788.y));
										float fragment_unnamed_6802 = ((-0.0f) - fragment_unnamed_6790) + fragment_unnamed_6794;
										fragment_unnamed_7334 = asfloat((((((mad(mad(fragment_unnamed_6767, 0.5f, fragment_unnamed_6445), fragment_unnamed_6706, fragment_unnamed_6433) < fragment_unnamed_6765) ? 4294967295u : 0u) | ((mad(mad(fragment_unnamed_6767, 0.5f, fragment_unnamed_6443), fragment_unnamed_6704, fragment_unnamed_6431) < fragment_unnamed_6764) ? 4294967295u : 0u)) | (((fragment_unnamed_6765 < mad(fragment_unnamed_6706, fragment_unnamed_6766, fragment_unnamed_6433)) ? 4294967295u : 0u) | ((fragment_unnamed_6764 < mad(fragment_unnamed_6704, fragment_unnamed_6766, fragment_unnamed_6431)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(max(asfloat(((fragment_unnamed_6790 >= fragment_unnamed_6794) ? 4294967295u : 0u) & 1065353216u), clamp((((-0.0f) - fragment_unnamed_6463) + (fragment_unnamed_6800 / mad(fragment_unnamed_6802, fragment_unnamed_6802, fragment_unnamed_6800))) / (((-0.0f) - fragment_unnamed_6463) + 1.0f), 0.0f, 1.0f))));
									}
									else
									{
										bool fragment_unnamed_6822 = 0.0f != fragment_unnamed_6489;
										uint4 fragment_unnamed_6825 = asuint(fragment_uniform_buffer_1[101u]);
										uint4 fragment_unnamed_6830 = asuint(fragment_uniform_buffer_1[99u]);
										float fragment_unnamed_6834 = asfloat(fragment_unnamed_6822 ? fragment_unnamed_6825.z : fragment_unnamed_6830.z);
										float fragment_unnamed_6836 = asfloat(fragment_unnamed_6822 ? fragment_unnamed_6825.w : fragment_unnamed_6830.w);
										float fragment_unnamed_6850 = ((-0.0f) - fragment_unnamed_6394) + (fragment_unnamed_6483 + fragment_input_6.x);
										float fragment_unnamed_6851 = ((-0.0f) - fragment_unnamed_6396) + (fragment_unnamed_6485 + fragment_input_6.y);
										float fragment_unnamed_6852 = ((-0.0f) - asfloat(fragment_unnamed_6399)) + (fragment_unnamed_6487 + fragment_input_6.z);
										float fragment_unnamed_6863 = dot(float3(asfloat(fragment_unnamed_6377), asfloat(fragment_unnamed_6378), fragment_unnamed_6398), float3(fragment_unnamed_6850, fragment_unnamed_6851, fragment_unnamed_6852));
										float fragment_unnamed_6866 = dot(float3(fragment_unnamed_6356, fragment_unnamed_6358, fragment_unnamed_6360), float3(fragment_unnamed_6850, fragment_unnamed_6851, fragment_unnamed_6852)) * fragment_unnamed_6415;
										float fragment_unnamed_6867 = dot(float3(fragment_unnamed_6354, asfloat(fragment_unnamed_6375), asfloat(fragment_unnamed_6376)), float3(fragment_unnamed_6850, fragment_unnamed_6851, fragment_unnamed_6852)) * fragment_unnamed_6417;
										float fragment_unnamed_6868 = dot(float2(fragment_unnamed_6419, fragment_unnamed_6421), float2(fragment_unnamed_6863, fragment_unnamed_2821));
										bool fragment_unnamed_6871 = fragment_unnamed_6863 != (-0.0f);
										float fragment_unnamed_6872 = (-0.0f) - fragment_unnamed_6863;
										float fragment_unnamed_6894 = mad(fragment_unnamed_6443 * clamp(mad(asfloat(fragment_unnamed_6871 ? asuint(fragment_unnamed_6866 / fragment_unnamed_6872) : asuint(fragment_unnamed_6866)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6834, fragment_unnamed_6431);
										float fragment_unnamed_6895 = mad(fragment_unnamed_6445 * clamp(mad(asfloat(fragment_unnamed_6871 ? asuint(fragment_unnamed_6867 / fragment_unnamed_6872) : asuint(fragment_unnamed_6867)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6836, fragment_unnamed_6433);
										float fragment_unnamed_6896 = trunc(mad(min(fragment_unnamed_6467, 4.0f), 4.0f, 1.0f));
										float fragment_unnamed_6897 = (-0.0f) - fragment_unnamed_6896;
										float4 fragment_unnamed_6918 = _ShadowmapAreaAtlas.SampleLevel(S0, float2(fragment_unnamed_6894, fragment_unnamed_6895), 0.0f);
										float fragment_unnamed_6920 = fragment_unnamed_6918.x;
										float fragment_unnamed_6924 = exp2(mad(((-0.0f) - asfloat(fragment_unnamed_6871 ? asuint(fragment_unnamed_6868 / fragment_unnamed_6872) : asuint(fragment_unnamed_6868))) + 1.0f, 2.0f, -1.0f) * fragment_unnamed_6461);
										float fragment_unnamed_6925 = fragment_unnamed_6924 * fragment_unnamed_6461;
										float fragment_unnamed_6930 = max(fragment_unnamed_6465 * (fragment_unnamed_6925 * fragment_unnamed_6925), mad((-0.0f) - fragment_unnamed_6920, fragment_unnamed_6920, fragment_unnamed_6918.y));
										float fragment_unnamed_6932 = ((-0.0f) - fragment_unnamed_6920) + fragment_unnamed_6924;
										fragment_unnamed_7334 = asfloat((((((mad(mad(fragment_unnamed_6897, 0.5f, fragment_unnamed_6445), fragment_unnamed_6836, fragment_unnamed_6433) < fragment_unnamed_6895) ? 4294967295u : 0u) | ((mad(mad(fragment_unnamed_6897, 0.5f, fragment_unnamed_6443), fragment_unnamed_6834, fragment_unnamed_6431) < fragment_unnamed_6894) ? 4294967295u : 0u)) | (((fragment_unnamed_6895 < mad(fragment_unnamed_6836, fragment_unnamed_6896, fragment_unnamed_6433)) ? 4294967295u : 0u) | ((fragment_unnamed_6894 < mad(fragment_unnamed_6834, fragment_unnamed_6896, fragment_unnamed_6431)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(max(asfloat(((fragment_unnamed_6920 >= fragment_unnamed_6924) ? 4294967295u : 0u) & 1065353216u), clamp((((-0.0f) - fragment_unnamed_6463) + (fragment_unnamed_6930 / mad(fragment_unnamed_6932, fragment_unnamed_6932, fragment_unnamed_6930))) / (((-0.0f) - fragment_unnamed_6463) + 1.0f), 0.0f, 1.0f))));
									}
									fragment_unnamed_6950 = mad(fragment_unnamed_6059, fragment_unnamed_7334 + (-1.0f), 1.0f);
								}
								else
								{
									fragment_unnamed_6950 = asfloat(1065353216u);
								}
								float fragment_unnamed_6952 = asfloat(fragment_unnamed_5102.z);
								float fragment_unnamed_6953 = asfloat(fragment_unnamed_5102.w);
								float fragment_unnamed_6957 = ((-0.0f) - fragment_unnamed_6952) + 1.0f;
								float fragment_unnamed_6958 = ((-0.0f) - fragment_unnamed_6953) + 1.0f;
								float fragment_unnamed_6959 = ((-0.0f) - fragment_unnamed_6057) + 1.0f;
								float fragment_unnamed_6961 = fragment_unnamed_6950 * (fragment_unnamed_6950 * fragment_unnamed_6950);
								float fragment_unnamed_6964 = (-0.0f) - (((-0.0f) - fragment_unnamed_6950) + 1.0f);
								float fragment_unnamed_6965 = mad(fragment_unnamed_6964, fragment_unnamed_6957, 1.0f);
								float fragment_unnamed_6966 = mad(fragment_unnamed_6964, fragment_unnamed_6958, 1.0f);
								float fragment_unnamed_6967 = mad(fragment_unnamed_6964, fragment_unnamed_6959, 1.0f);
								float fragment_unnamed_6493 = mad(fragment_unnamed_6047, ((-0.0f) - fragment_unnamed_6965) + mad(fragment_unnamed_6961, fragment_unnamed_6957, fragment_unnamed_6952 * fragment_unnamed_6950), fragment_unnamed_6965) * fragment_unnamed_5062;
								float fragment_unnamed_6495 = mad(fragment_unnamed_6047, ((-0.0f) - fragment_unnamed_6966) + mad(fragment_unnamed_6961, fragment_unnamed_6958, fragment_unnamed_6953 * fragment_unnamed_6950), fragment_unnamed_6966) * fragment_unnamed_5064;
								float fragment_unnamed_6497 = mad(fragment_unnamed_6047, ((-0.0f) - fragment_unnamed_6967) + mad(fragment_unnamed_6961, fragment_unnamed_6959, fragment_unnamed_6057 * fragment_unnamed_6950), fragment_unnamed_6967) * asfloat(fragment_unnamed_5082);
								fragment_unnamed_6492 = fragment_unnamed_6493;
								fragment_unnamed_6494 = fragment_unnamed_6495;
								fragment_unnamed_6496 = fragment_unnamed_6497;
								fragment_unnamed_6498 = asfloat((0.0f < max(fragment_unnamed_6497, max(fragment_unnamed_6495, fragment_unnamed_6493))) ? 4294967295u : 0u);
							}
							else
							{
								fragment_unnamed_6492 = fragment_unnamed_5062;
								fragment_unnamed_6494 = fragment_unnamed_5064;
								fragment_unnamed_6496 = asfloat(fragment_unnamed_5082);
								fragment_unnamed_6498 = asfloat(4294967295u);
							}
							float fragment_unnamed_7354;
							float fragment_unnamed_7356;
							float fragment_unnamed_7358;
							float fragment_unnamed_7360;
							float fragment_unnamed_7362;
							float fragment_unnamed_7364;
							if ((fragment_unnamed_5180 & asuint(fragment_unnamed_6498)) != 0u)
							{
								uint fragment_unnamed_6989 = (fragment_unnamed_3856 * 56u) + 49u;
								uint2 fragment_unnamed_6995 = uint2(T6.Load(fragment_unnamed_6989).x, T6.Load(fragment_unnamed_6989 + 1u).x);
								float fragment_unnamed_7000 = dot(float3(fragment_unnamed_961, fragment_unnamed_2818, fragment_unnamed_2819), float3(fragment_unnamed_5132, fragment_unnamed_5133, fragment_unnamed_5134));
								float fragment_unnamed_7003 = dot(float3(fragment_unnamed_951, fragment_unnamed_953, fragment_unnamed_2822), float3(fragment_unnamed_5132, fragment_unnamed_5133, fragment_unnamed_5134));
								float fragment_unnamed_7006 = dot(float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466), float3(fragment_unnamed_5132, fragment_unnamed_5133, fragment_unnamed_5134));
								float fragment_unnamed_7009 = dot(float3(fragment_unnamed_961, fragment_unnamed_2818, fragment_unnamed_2819), float3(fragment_unnamed_5024, fragment_unnamed_5026, fragment_unnamed_5028));
								float fragment_unnamed_7012 = dot(float3(fragment_unnamed_951, fragment_unnamed_953, fragment_unnamed_2822), float3(fragment_unnamed_5024, fragment_unnamed_5026, fragment_unnamed_5028));
								float fragment_unnamed_7015 = dot(float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466), float3(fragment_unnamed_5024, fragment_unnamed_5026, fragment_unnamed_5028));
								float fragment_unnamed_7018 = dot(float3(fragment_unnamed_961, fragment_unnamed_2818, fragment_unnamed_2819), float3(fragment_unnamed_5144, fragment_unnamed_5145, fragment_unnamed_5146));
								float fragment_unnamed_7021 = dot(float3(fragment_unnamed_951, fragment_unnamed_953, fragment_unnamed_2822), float3(fragment_unnamed_5144, fragment_unnamed_5145, fragment_unnamed_5146));
								float fragment_unnamed_7024 = dot(float3(fragment_unnamed_464, fragment_unnamed_465, fragment_unnamed_466), float3(fragment_unnamed_5144, fragment_unnamed_5145, fragment_unnamed_5146));
								float fragment_unnamed_7033 = mad(fragment_unnamed_7003, fragment_unnamed_7015, (-0.0f) - (fragment_unnamed_7012 * fragment_unnamed_7006));
								float fragment_unnamed_7034 = mad(fragment_unnamed_7006, fragment_unnamed_7009, (-0.0f) - (fragment_unnamed_7015 * fragment_unnamed_7000));
								float fragment_unnamed_7035 = mad(fragment_unnamed_7000, fragment_unnamed_7012, (-0.0f) - (fragment_unnamed_7009 * fragment_unnamed_7003));
								float fragment_unnamed_7036 = dot(float3(fragment_unnamed_7033, fragment_unnamed_7034, fragment_unnamed_7035), float3(fragment_unnamed_7033, fragment_unnamed_7034, fragment_unnamed_7035));
								uint fragment_unnamed_7047 = ((fragment_unnamed_7036 == 0.0f) ? 4294967295u : 0u) | ((0.0f >= mad(fragment_unnamed_5136, abs(fragment_unnamed_7024), mad(fragment_unnamed_5135, abs(fragment_unnamed_7015), fragment_unnamed_7006))) ? 4294967295u : 0u);
								float fragment_unnamed_7603;
								float fragment_unnamed_7605;
								float fragment_unnamed_7607;
								float fragment_unnamed_7609;
								if (fragment_unnamed_7047 == 0u)
								{
									float fragment_unnamed_7336 = dot(float2(fragment_unnamed_2823, fragment_unnamed_892), float2(fragment_unnamed_7006, fragment_unnamed_7000));
									float fragment_unnamed_7339 = dot(float2(fragment_unnamed_2823, fragment_unnamed_892), float2(fragment_unnamed_7015, fragment_unnamed_7009));
									float fragment_unnamed_7342 = dot(float2(fragment_unnamed_892, fragment_unnamed_2823), float2(fragment_unnamed_7018, fragment_unnamed_7024));
									float fragment_unnamed_7604;
									float fragment_unnamed_7606;
									float fragment_unnamed_7608;
									float fragment_unnamed_7610;
									if (0.0f < mad(fragment_unnamed_5136, abs(fragment_unnamed_7342), mad(fragment_unnamed_5135, abs(fragment_unnamed_7339), fragment_unnamed_7336)))
									{
										float fragment_unnamed_7591 = dot(float2(fragment_unnamed_894, fragment_unnamed_891), float2(fragment_unnamed_7006, fragment_unnamed_7000));
										float fragment_unnamed_7594 = fragment_unnamed_893 * fragment_unnamed_7003;
										float fragment_unnamed_7595 = dot(float2(fragment_unnamed_894, fragment_unnamed_891), float2(fragment_unnamed_7015, fragment_unnamed_7009));
										float fragment_unnamed_7598 = fragment_unnamed_893 * fragment_unnamed_7012;
										float fragment_unnamed_8668;
										float fragment_unnamed_8669;
										float fragment_unnamed_8670;
										float fragment_unnamed_8671;
										if (fragment_unnamed_5121)
										{
											float fragment_unnamed_8328 = dot(float2(fragment_unnamed_891, fragment_unnamed_894), float2(fragment_unnamed_7018, fragment_unnamed_7024));
											float fragment_unnamed_8331 = fragment_unnamed_7021 * fragment_unnamed_893;
											float fragment_unnamed_8332 = (-0.0f) - fragment_unnamed_5135;
											float fragment_unnamed_8336 = (-0.0f) - fragment_unnamed_5136;
											float fragment_unnamed_8337 = mad(fragment_unnamed_8336, fragment_unnamed_8328, mad(fragment_unnamed_8332, fragment_unnamed_7595, fragment_unnamed_7591));
											float fragment_unnamed_8338 = mad(fragment_unnamed_8336, fragment_unnamed_8331, mad(fragment_unnamed_8332, fragment_unnamed_7598, fragment_unnamed_7594));
											float fragment_unnamed_8339 = mad(fragment_unnamed_8336, fragment_unnamed_7342, mad(fragment_unnamed_8332, fragment_unnamed_7339, fragment_unnamed_7336));
											float fragment_unnamed_8340 = fragment_unnamed_5120 * fragment_unnamed_8328;
											float fragment_unnamed_8341 = fragment_unnamed_5120 * fragment_unnamed_8331;
											float fragment_unnamed_8342 = fragment_unnamed_5120 * fragment_unnamed_7342;
											float fragment_unnamed_8343 = mad(fragment_unnamed_5120, fragment_unnamed_7342, fragment_unnamed_8339);
											float fragment_unnamed_8344 = mad(fragment_unnamed_5120, fragment_unnamed_8328, fragment_unnamed_8337);
											float fragment_unnamed_8345 = mad(fragment_unnamed_5120, fragment_unnamed_8331, fragment_unnamed_8338);
											float fragment_unnamed_8346 = mad(fragment_unnamed_5118, fragment_unnamed_7339, fragment_unnamed_8343);
											float fragment_unnamed_8347 = mad(fragment_unnamed_5118, fragment_unnamed_7595, fragment_unnamed_8344);
											float fragment_unnamed_8348 = mad(fragment_unnamed_5118, fragment_unnamed_7598, fragment_unnamed_8345);
											float fragment_unnamed_8349 = (-0.0f) - fragment_unnamed_5120;
											float fragment_unnamed_8350 = mad(fragment_unnamed_8349, fragment_unnamed_8328, fragment_unnamed_8347);
											float fragment_unnamed_8351 = mad(fragment_unnamed_8349, fragment_unnamed_8331, fragment_unnamed_8348);
											float fragment_unnamed_8352 = mad(fragment_unnamed_8349, fragment_unnamed_7342, fragment_unnamed_8346);
											float fragment_unnamed_8356 = rsqrt(dot(float3(fragment_unnamed_8337, fragment_unnamed_8338, fragment_unnamed_8339), float3(fragment_unnamed_8337, fragment_unnamed_8338, fragment_unnamed_8339)));
											float fragment_unnamed_8357 = fragment_unnamed_8356 * fragment_unnamed_8338;
											float fragment_unnamed_8358 = fragment_unnamed_8356 * fragment_unnamed_8339;
											float fragment_unnamed_8359 = fragment_unnamed_8356 * fragment_unnamed_8337;
											float fragment_unnamed_8363 = rsqrt(dot(float3(fragment_unnamed_8343, fragment_unnamed_8344, fragment_unnamed_8345), float3(fragment_unnamed_8343, fragment_unnamed_8344, fragment_unnamed_8345)));
											float fragment_unnamed_8364 = fragment_unnamed_8363 * fragment_unnamed_8343;
											float fragment_unnamed_8365 = fragment_unnamed_8363 * fragment_unnamed_8344;
											float fragment_unnamed_8366 = fragment_unnamed_8363 * fragment_unnamed_8345;
											float fragment_unnamed_8370 = rsqrt(dot(float3(fragment_unnamed_8346, fragment_unnamed_8347, fragment_unnamed_8348), float3(fragment_unnamed_8346, fragment_unnamed_8347, fragment_unnamed_8348)));
											float fragment_unnamed_8371 = fragment_unnamed_8370 * fragment_unnamed_8346;
											float fragment_unnamed_8372 = fragment_unnamed_8370 * fragment_unnamed_8347;
											float fragment_unnamed_8373 = fragment_unnamed_8370 * fragment_unnamed_8348;
											float fragment_unnamed_8377 = rsqrt(dot(float3(fragment_unnamed_8350, fragment_unnamed_8351, fragment_unnamed_8352), float3(fragment_unnamed_8350, fragment_unnamed_8351, fragment_unnamed_8352)));
											float fragment_unnamed_8378 = fragment_unnamed_8377 * fragment_unnamed_8352;
											float fragment_unnamed_8379 = fragment_unnamed_8377 * fragment_unnamed_8350;
											float fragment_unnamed_8380 = fragment_unnamed_8377 * fragment_unnamed_8351;
											float fragment_unnamed_8381 = dot(float3(fragment_unnamed_8358, fragment_unnamed_8359, fragment_unnamed_8357), float3(fragment_unnamed_8364, fragment_unnamed_8365, fragment_unnamed_8366));
											float fragment_unnamed_8418 = mad(abs(fragment_unnamed_8381), mad(abs(fragment_unnamed_8381), mad(abs(fragment_unnamed_8381), mad(abs(fragment_unnamed_8381), mad(abs(fragment_unnamed_8381), mad(abs(fragment_unnamed_8381), mad(abs(fragment_unnamed_8381), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8426 = asfloat((fragment_unnamed_8381 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8381, fragment_unnamed_8381, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8418)) : asuint(fragment_unnamed_8418));
											float fragment_unnamed_8427 = dot(float3(fragment_unnamed_8364, fragment_unnamed_8365, fragment_unnamed_8366), float3(fragment_unnamed_8371, fragment_unnamed_8372, fragment_unnamed_8373));
											float fragment_unnamed_8457 = mad(abs(fragment_unnamed_8427), mad(abs(fragment_unnamed_8427), mad(abs(fragment_unnamed_8427), mad(abs(fragment_unnamed_8427), mad(abs(fragment_unnamed_8427), mad(abs(fragment_unnamed_8427), mad(abs(fragment_unnamed_8427), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8464 = asfloat((fragment_unnamed_8427 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8427, fragment_unnamed_8427, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8457)) : asuint(fragment_unnamed_8457));
											float fragment_unnamed_8471 = dot(float3(fragment_unnamed_8371, fragment_unnamed_8372, fragment_unnamed_8373), float3(fragment_unnamed_8378, fragment_unnamed_8379, fragment_unnamed_8380));
											float fragment_unnamed_8501 = mad(abs(fragment_unnamed_8471), mad(abs(fragment_unnamed_8471), mad(abs(fragment_unnamed_8471), mad(abs(fragment_unnamed_8471), mad(abs(fragment_unnamed_8471), mad(abs(fragment_unnamed_8471), mad(abs(fragment_unnamed_8471), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8508 = asfloat((fragment_unnamed_8471 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8471, fragment_unnamed_8471, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8501)) : asuint(fragment_unnamed_8501));
											float fragment_unnamed_8512 = dot(float3(fragment_unnamed_8380, fragment_unnamed_8378, fragment_unnamed_8379), float3(fragment_unnamed_8357, fragment_unnamed_8358, fragment_unnamed_8359));
											float fragment_unnamed_8542 = mad(abs(fragment_unnamed_8512), mad(abs(fragment_unnamed_8512), mad(abs(fragment_unnamed_8512), mad(abs(fragment_unnamed_8512), mad(abs(fragment_unnamed_8512), mad(abs(fragment_unnamed_8512), mad(abs(fragment_unnamed_8512), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8549 = asfloat((fragment_unnamed_8512 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8512, fragment_unnamed_8512, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8542)) : asuint(fragment_unnamed_8542));
											float fragment_unnamed_8552 = mad(mad(fragment_unnamed_8379, fragment_unnamed_8357, (-0.0f) - (fragment_unnamed_8359 * fragment_unnamed_8380)), fragment_unnamed_8549, mad(mad(fragment_unnamed_8372, fragment_unnamed_8380, (-0.0f) - (fragment_unnamed_8373 * fragment_unnamed_8379)), fragment_unnamed_8508, mad(mad(fragment_unnamed_8359, fragment_unnamed_8366, (-0.0f) - (fragment_unnamed_8365 * fragment_unnamed_8357)), fragment_unnamed_8426, fragment_unnamed_8464 * mad(fragment_unnamed_8365, fragment_unnamed_8373, (-0.0f) - (fragment_unnamed_8366 * fragment_unnamed_8372)))));
											float fragment_unnamed_8553 = mad(mad(fragment_unnamed_8380, fragment_unnamed_8358, (-0.0f) - (fragment_unnamed_8357 * fragment_unnamed_8378)), fragment_unnamed_8549, mad(mad(fragment_unnamed_8373, fragment_unnamed_8378, (-0.0f) - (fragment_unnamed_8371 * fragment_unnamed_8380)), fragment_unnamed_8508, mad(mad(fragment_unnamed_8357, fragment_unnamed_8364, (-0.0f) - (fragment_unnamed_8366 * fragment_unnamed_8358)), fragment_unnamed_8426, fragment_unnamed_8464 * mad(fragment_unnamed_8366, fragment_unnamed_8371, (-0.0f) - (fragment_unnamed_8364 * fragment_unnamed_8373))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_8554 = mad(mad(fragment_unnamed_8378, fragment_unnamed_8359, (-0.0f) - (fragment_unnamed_8358 * fragment_unnamed_8379)), fragment_unnamed_8549, mad(mad(fragment_unnamed_8371, fragment_unnamed_8379, (-0.0f) - (fragment_unnamed_8372 * fragment_unnamed_8378)), fragment_unnamed_8508, mad(mad(fragment_unnamed_8358, fragment_unnamed_8365, (-0.0f) - (fragment_unnamed_8364 * fragment_unnamed_8359)), fragment_unnamed_8426, fragment_unnamed_8464 * mad(fragment_unnamed_8364, fragment_unnamed_8372, (-0.0f) - (fragment_unnamed_8365 * fragment_unnamed_8371))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_8555 = fragment_unnamed_8552 * 0.15915493667125701904296875f;
											float fragment_unnamed_8556 = dot(float3(fragment_unnamed_8553, fragment_unnamed_8554, fragment_unnamed_8555), float3(fragment_unnamed_8553, fragment_unnamed_8554, fragment_unnamed_8555));
											float fragment_unnamed_8840;
											float fragment_unnamed_8841;
											float fragment_unnamed_8842;
											if (fragment_unnamed_5043 != 0u)
											{
												float fragment_unnamed_8708 = ((-0.0f) - fragment_unnamed_8337) + fragment_unnamed_8350;
												float fragment_unnamed_8709 = ((-0.0f) - fragment_unnamed_8338) + fragment_unnamed_8351;
												float fragment_unnamed_8710 = ((-0.0f) - fragment_unnamed_8339) + fragment_unnamed_8352;
												float fragment_unnamed_8717 = mad(fragment_unnamed_8709, fragment_unnamed_8342, (-0.0f) - (fragment_unnamed_8341 * fragment_unnamed_8710));
												float fragment_unnamed_8718 = mad(fragment_unnamed_8710, fragment_unnamed_8340, (-0.0f) - (fragment_unnamed_8342 * fragment_unnamed_8708));
												float fragment_unnamed_8719 = mad(fragment_unnamed_8708, fragment_unnamed_8341, (-0.0f) - (fragment_unnamed_8340 * fragment_unnamed_8709));
												float fragment_unnamed_8723 = rsqrt(dot(float3(fragment_unnamed_8717, fragment_unnamed_8718, fragment_unnamed_8719), float3(fragment_unnamed_8717, fragment_unnamed_8718, fragment_unnamed_8719)));
												float fragment_unnamed_8724 = fragment_unnamed_8723 * fragment_unnamed_8717;
												float fragment_unnamed_8725 = fragment_unnamed_8723 * fragment_unnamed_8718;
												float fragment_unnamed_8726 = fragment_unnamed_8723 * fragment_unnamed_8719;
												float fragment_unnamed_8733 = dot(float3(fragment_unnamed_8337, fragment_unnamed_8338, fragment_unnamed_8339), float3(fragment_unnamed_8724, fragment_unnamed_8725, fragment_unnamed_8726)) / dot(float3(fragment_unnamed_8553, fragment_unnamed_8554, fragment_unnamed_8555), float3(fragment_unnamed_8724, fragment_unnamed_8725, fragment_unnamed_8726));
												float fragment_unnamed_8737 = mad(fragment_unnamed_8733, fragment_unnamed_8724, (-0.0f) - fragment_unnamed_8337);
												float fragment_unnamed_8738 = mad(fragment_unnamed_8733, fragment_unnamed_8725, (-0.0f) - fragment_unnamed_8338);
												float fragment_unnamed_8739 = mad(fragment_unnamed_8733, fragment_unnamed_8726, (-0.0f) - fragment_unnamed_8339);
												float fragment_unnamed_8743 = 1.0f / dot(float3(fragment_unnamed_8708, fragment_unnamed_8709, fragment_unnamed_8710), float3(fragment_unnamed_8708, fragment_unnamed_8709, fragment_unnamed_8710));
												float fragment_unnamed_8744 = dot(float3(fragment_unnamed_8340, fragment_unnamed_8341, fragment_unnamed_8342), float3(fragment_unnamed_8708, fragment_unnamed_8709, fragment_unnamed_8710));
												float fragment_unnamed_8753 = mad((-0.0f) - (fragment_unnamed_8708 * fragment_unnamed_8744), fragment_unnamed_8743, fragment_unnamed_8340);
												float fragment_unnamed_8754 = mad((-0.0f) - (fragment_unnamed_8709 * fragment_unnamed_8744), fragment_unnamed_8743, fragment_unnamed_8341);
												float fragment_unnamed_8755 = mad((-0.0f) - (fragment_unnamed_8710 * fragment_unnamed_8744), fragment_unnamed_8743, fragment_unnamed_8342);
												float fragment_unnamed_8762 = dot(float3(fragment_unnamed_8737, fragment_unnamed_8738, fragment_unnamed_8739), float3(fragment_unnamed_8753, fragment_unnamed_8754, fragment_unnamed_8755)) / dot(float3(fragment_unnamed_8753, fragment_unnamed_8754, fragment_unnamed_8755), float3(fragment_unnamed_8753, fragment_unnamed_8754, fragment_unnamed_8755));
												float fragment_unnamed_8776 = round(log2(fragment_unnamed_5086 * fragment_uniform_buffer_1[122u].x));
												float fragment_unnamed_8784 = min(fragment_unnamed_8776, max(mad(log2(mad(fragment_unnamed_8723 * (fragment_unnamed_8733 * fragment_unnamed_8733), 3.1415927410125732421875f, 9.9999999392252902907785028219223e-09f)), 0.5f, fragment_unnamed_8776), 0.0f));
												float fragment_unnamed_8798 = 1.0f / (fragment_unnamed_5086 + fragment_uniform_buffer_1[123u].y);
												float fragment_unnamed_8799 = 1.0f / (fragment_unnamed_5088 + fragment_uniform_buffer_1[123u].y);
												float fragment_unnamed_8809 = exp2(ceil(max(fragment_unnamed_8784 + ((-0.0f) - fragment_uniform_buffer_1[123u].z), 0.0f)));
												float fragment_unnamed_8813 = fragment_unnamed_5086 * fragment_uniform_buffer_1[123u].x;
												float fragment_unnamed_8814 = fragment_unnamed_5088 * fragment_uniform_buffer_1[123u].x;
												float fragment_unnamed_8817 = fragment_unnamed_8809 / (fragment_unnamed_8813 + fragment_unnamed_8813);
												float fragment_unnamed_8818 = fragment_unnamed_8809 / (fragment_unnamed_8814 + fragment_unnamed_8814);
												float4 fragment_unnamed_8832 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_8817) + 1.0f, max(fragment_unnamed_8817, mad(clamp(mad((-0.0f) - mad((-0.0f) - fragment_unnamed_8744, fragment_unnamed_8762, dot(float3(fragment_unnamed_8737, fragment_unnamed_8738, fragment_unnamed_8739), float3(fragment_unnamed_8708, fragment_unnamed_8709, fragment_unnamed_8710))), fragment_unnamed_8743, 1.0f), 0.0f, 1.0f), fragment_unnamed_5086 * fragment_unnamed_8798, mad((-0.0f) - fragment_unnamed_8798, fragment_unnamed_5086, 1.0f) * 0.5f))), fragment_unnamed_5086, fragment_unnamed_5104), mad(min(((-0.0f) - fragment_unnamed_8818) + 1.0f, max(fragment_unnamed_8818, mad(clamp(fragment_unnamed_8762, 0.0f, 1.0f), fragment_unnamed_5088 * fragment_unnamed_8799, mad((-0.0f) - fragment_unnamed_8799, fragment_unnamed_5088, 1.0f) * 0.5f))), fragment_unnamed_5088, fragment_unnamed_5106)), fragment_unnamed_8784);
												fragment_unnamed_8840 = fragment_unnamed_8832.x;
												fragment_unnamed_8841 = fragment_unnamed_8832.y;
												fragment_unnamed_8842 = fragment_unnamed_8832.z;
											}
											else
											{
												fragment_unnamed_8840 = asfloat(1065353216u);
												fragment_unnamed_8841 = asfloat(1065353216u);
												fragment_unnamed_8842 = asfloat(1065353216u);
											}
											fragment_unnamed_8668 = max(mad(fragment_unnamed_8552, 0.15915493667125701904296875f, fragment_unnamed_8556) / (sqrt(fragment_unnamed_8556) + 1.0f), 0.0f);
											fragment_unnamed_8669 = fragment_unnamed_8840;
											fragment_unnamed_8670 = fragment_unnamed_8841;
											fragment_unnamed_8671 = fragment_unnamed_8842;
										}
										else
										{
											float fragment_unnamed_8568 = mad((-0.0f) - fragment_unnamed_892, fragment_unnamed_7035, fragment_unnamed_7033) * fragment_unnamed_893;
											float fragment_unnamed_8569 = fragment_unnamed_2807 * fragment_unnamed_7034;
											float fragment_unnamed_8572 = mad((-0.0f) - fragment_unnamed_894, fragment_unnamed_7033, fragment_unnamed_891 * fragment_unnamed_7035) * fragment_unnamed_893;
											float fragment_unnamed_8583 = (1.0f / fragment_unnamed_7339) * ((-0.0f) - fragment_unnamed_7336);
											bool fragment_unnamed_8584 = fragment_unnamed_7339 >= 0.0f;
											float fragment_unnamed_8599 = dot(float3(fragment_unnamed_7595, fragment_unnamed_7598, fragment_unnamed_7339), float3(fragment_unnamed_7595, fragment_unnamed_7598, fragment_unnamed_7339));
											float fragment_unnamed_8602 = rsqrt(fragment_unnamed_8599);
											float fragment_unnamed_8603 = fragment_unnamed_8599 * fragment_unnamed_8602;
											float fragment_unnamed_8604 = fragment_unnamed_8602 * fragment_unnamed_7595;
											float fragment_unnamed_8605 = fragment_unnamed_8602 * fragment_unnamed_7598;
											float fragment_unnamed_8606 = fragment_unnamed_8602 * fragment_unnamed_7339;
											float fragment_unnamed_8607 = dot(float3(fragment_unnamed_8604, fragment_unnamed_8605, fragment_unnamed_8606), float3(fragment_unnamed_7591, fragment_unnamed_7594, fragment_unnamed_7336));
											float fragment_unnamed_8610 = (-0.0f) - fragment_unnamed_8607;
											float fragment_unnamed_8611 = mad(fragment_unnamed_8610, fragment_unnamed_8604, fragment_unnamed_7591);
											float fragment_unnamed_8612 = mad(fragment_unnamed_8610, fragment_unnamed_8605, fragment_unnamed_7594);
											float fragment_unnamed_8613 = mad(fragment_unnamed_8610, fragment_unnamed_8606, fragment_unnamed_7336);
											float fragment_unnamed_8614 = dot(float3(fragment_unnamed_8611, fragment_unnamed_8612, fragment_unnamed_8613), float3(fragment_unnamed_8611, fragment_unnamed_8612, fragment_unnamed_8613));
											float fragment_unnamed_8617 = rsqrt(fragment_unnamed_8614);
											float fragment_unnamed_8619 = fragment_unnamed_8617 * fragment_unnamed_8613;
											float fragment_unnamed_8620 = mad(asfloat(fragment_unnamed_8584 ? asuint(max(fragment_unnamed_8583, fragment_unnamed_5135)) : asuint(min(fragment_unnamed_8583, fragment_unnamed_5135))), fragment_unnamed_8603, fragment_unnamed_8607);
											float fragment_unnamed_8621 = mad(asfloat(fragment_unnamed_8584 ? asuint(max(fragment_unnamed_8583, (-0.0f) - fragment_unnamed_5135)) : asuint(min(fragment_unnamed_8583, (-0.0f) - fragment_unnamed_5135))), fragment_unnamed_8603, fragment_unnamed_8607);
											float fragment_unnamed_8622 = mad(fragment_unnamed_8620, fragment_unnamed_8620, fragment_unnamed_8614);
											float fragment_unnamed_8623 = mad(fragment_unnamed_8621, fragment_unnamed_8621, fragment_unnamed_8614);
											float fragment_unnamed_8625 = rsqrt(fragment_unnamed_8622 * fragment_unnamed_8623);
											float fragment_unnamed_8626 = fragment_unnamed_8625 * fragment_unnamed_8625;
											float fragment_unnamed_8629 = (fragment_unnamed_8614 * fragment_unnamed_8617) * fragment_unnamed_8606;
											float fragment_unnamed_8639 = min(fragment_unnamed_8625 * mad(fragment_unnamed_8621, fragment_unnamed_8620, fragment_unnamed_8614), 1.0f);
											float fragment_unnamed_8643 = sqrt(((-0.0f) - abs(fragment_unnamed_8639)) + 1.0f);
											float fragment_unnamed_8649 = mad(mad(mad(abs(fragment_unnamed_8639), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_8639), -0.212114393711090087890625f), abs(fragment_unnamed_8639), 1.570728778839111328125f);
											fragment_unnamed_8668 = ((fragment_unnamed_7036 * (abs(fragment_unnamed_2808) * rsqrt(fragment_unnamed_7036 * dot(float3(fragment_unnamed_8568, fragment_unnamed_8569, fragment_unnamed_8572), float3(fragment_unnamed_8568, fragment_unnamed_8569, fragment_unnamed_8572))))) * max(mad(mad(fragment_unnamed_8649, fragment_unnamed_8643, asfloat(((fragment_unnamed_8639 < ((-0.0f) - fragment_unnamed_8639)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_8643 * fragment_unnamed_8649, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_8617 * fragment_unnamed_8619, mad(mad(fragment_unnamed_8619, fragment_unnamed_8620, (-0.0f) - fragment_unnamed_8629), fragment_unnamed_8623 * fragment_unnamed_8626, (-0.0f) - ((fragment_unnamed_8622 * fragment_unnamed_8626) * mad(fragment_unnamed_8619, fragment_unnamed_8621, (-0.0f) - fragment_unnamed_8629)))), 0.0f)) * 0.3183098733425140380859375f;
											fragment_unnamed_8669 = asfloat(1065353216u);
											fragment_unnamed_8670 = asfloat(1065353216u);
											fragment_unnamed_8671 = asfloat(1065353216u);
										}
										fragment_unnamed_7604 = fragment_unnamed_8668;
										fragment_unnamed_7606 = fragment_unnamed_8669;
										fragment_unnamed_7608 = fragment_unnamed_8670;
										fragment_unnamed_7610 = fragment_unnamed_8671;
									}
									else
									{
										fragment_unnamed_7604 = asfloat(0u);
										fragment_unnamed_7606 = asfloat(1065353216u);
										fragment_unnamed_7608 = asfloat(1065353216u);
										fragment_unnamed_7610 = asfloat(1065353216u);
									}
									fragment_unnamed_7603 = fragment_unnamed_7604;
									fragment_unnamed_7605 = fragment_unnamed_7606;
									fragment_unnamed_7607 = fragment_unnamed_7608;
									fragment_unnamed_7609 = fragment_unnamed_7610;
								}
								else
								{
									fragment_unnamed_7603 = asfloat(0u);
									fragment_unnamed_7605 = asfloat(1065353216u);
									fragment_unnamed_7607 = asfloat(1065353216u);
									fragment_unnamed_7609 = asfloat(1065353216u);
								}
								float fragment_unnamed_7613 = (asfloat(fragment_unnamed_6995.x) * fragment_unnamed_5178) * fragment_unnamed_7603;
								float fragment_unnamed_8855;
								float fragment_unnamed_8857;
								float fragment_unnamed_8859;
								float fragment_unnamed_8861;
								if (fragment_unnamed_7047 == 0u)
								{
									float fragment_unnamed_8672 = dot(float2(fragment_unnamed_2824, fragment_unnamed_898), float2(fragment_unnamed_7006, fragment_unnamed_7000));
									float fragment_unnamed_8675 = dot(float2(fragment_unnamed_2824, fragment_unnamed_898), float2(fragment_unnamed_7015, fragment_unnamed_7009));
									float fragment_unnamed_8678 = dot(float2(fragment_unnamed_898, fragment_unnamed_2824), float2(fragment_unnamed_7018, fragment_unnamed_7024));
									float fragment_unnamed_8856;
									float fragment_unnamed_8858;
									float fragment_unnamed_8860;
									float fragment_unnamed_8862;
									if (0.0f < mad(fragment_unnamed_5136, abs(fragment_unnamed_8678), mad(fragment_unnamed_5135, abs(fragment_unnamed_8675), fragment_unnamed_8672)))
									{
										float fragment_unnamed_8843 = dot(float2(fragment_unnamed_900, fragment_unnamed_897), float2(fragment_unnamed_7006, fragment_unnamed_7000));
										float fragment_unnamed_8846 = fragment_unnamed_899 * fragment_unnamed_7003;
										float fragment_unnamed_8847 = dot(float2(fragment_unnamed_900, fragment_unnamed_897), float2(fragment_unnamed_7015, fragment_unnamed_7009));
										float fragment_unnamed_8850 = fragment_unnamed_899 * fragment_unnamed_7012;
										float fragment_unnamed_9204;
										float fragment_unnamed_9205;
										float fragment_unnamed_9206;
										float fragment_unnamed_9207;
										if (fragment_unnamed_5121)
										{
											float fragment_unnamed_8873 = dot(float2(fragment_unnamed_897, fragment_unnamed_900), float2(fragment_unnamed_7018, fragment_unnamed_7024));
											float fragment_unnamed_8876 = fragment_unnamed_7021 * fragment_unnamed_899;
											float fragment_unnamed_8877 = (-0.0f) - fragment_unnamed_5135;
											float fragment_unnamed_8881 = (-0.0f) - fragment_unnamed_5136;
											float fragment_unnamed_8882 = mad(fragment_unnamed_8881, fragment_unnamed_8873, mad(fragment_unnamed_8877, fragment_unnamed_8847, fragment_unnamed_8843));
											float fragment_unnamed_8883 = mad(fragment_unnamed_8881, fragment_unnamed_8876, mad(fragment_unnamed_8877, fragment_unnamed_8850, fragment_unnamed_8846));
											float fragment_unnamed_8884 = mad(fragment_unnamed_8881, fragment_unnamed_8678, mad(fragment_unnamed_8877, fragment_unnamed_8675, fragment_unnamed_8672));
											float fragment_unnamed_8885 = fragment_unnamed_5120 * fragment_unnamed_8873;
											float fragment_unnamed_8886 = fragment_unnamed_5120 * fragment_unnamed_8876;
											float fragment_unnamed_8887 = fragment_unnamed_5120 * fragment_unnamed_8678;
											float fragment_unnamed_8888 = mad(fragment_unnamed_5120, fragment_unnamed_8678, fragment_unnamed_8884);
											float fragment_unnamed_8889 = mad(fragment_unnamed_5120, fragment_unnamed_8873, fragment_unnamed_8882);
											float fragment_unnamed_8890 = mad(fragment_unnamed_5120, fragment_unnamed_8876, fragment_unnamed_8883);
											float fragment_unnamed_8891 = mad(fragment_unnamed_5118, fragment_unnamed_8675, fragment_unnamed_8888);
											float fragment_unnamed_8892 = mad(fragment_unnamed_5118, fragment_unnamed_8847, fragment_unnamed_8889);
											float fragment_unnamed_8893 = mad(fragment_unnamed_5118, fragment_unnamed_8850, fragment_unnamed_8890);
											float fragment_unnamed_8894 = (-0.0f) - fragment_unnamed_5120;
											float fragment_unnamed_8895 = mad(fragment_unnamed_8894, fragment_unnamed_8873, fragment_unnamed_8892);
											float fragment_unnamed_8896 = mad(fragment_unnamed_8894, fragment_unnamed_8876, fragment_unnamed_8893);
											float fragment_unnamed_8897 = mad(fragment_unnamed_8894, fragment_unnamed_8678, fragment_unnamed_8891);
											float fragment_unnamed_8901 = rsqrt(dot(float3(fragment_unnamed_8882, fragment_unnamed_8883, fragment_unnamed_8884), float3(fragment_unnamed_8882, fragment_unnamed_8883, fragment_unnamed_8884)));
											float fragment_unnamed_8902 = fragment_unnamed_8901 * fragment_unnamed_8883;
											float fragment_unnamed_8903 = fragment_unnamed_8901 * fragment_unnamed_8884;
											float fragment_unnamed_8904 = fragment_unnamed_8901 * fragment_unnamed_8882;
											float fragment_unnamed_8908 = rsqrt(dot(float3(fragment_unnamed_8888, fragment_unnamed_8889, fragment_unnamed_8890), float3(fragment_unnamed_8888, fragment_unnamed_8889, fragment_unnamed_8890)));
											float fragment_unnamed_8909 = fragment_unnamed_8908 * fragment_unnamed_8888;
											float fragment_unnamed_8910 = fragment_unnamed_8908 * fragment_unnamed_8889;
											float fragment_unnamed_8911 = fragment_unnamed_8908 * fragment_unnamed_8890;
											float fragment_unnamed_8915 = rsqrt(dot(float3(fragment_unnamed_8891, fragment_unnamed_8892, fragment_unnamed_8893), float3(fragment_unnamed_8891, fragment_unnamed_8892, fragment_unnamed_8893)));
											float fragment_unnamed_8916 = fragment_unnamed_8915 * fragment_unnamed_8891;
											float fragment_unnamed_8917 = fragment_unnamed_8915 * fragment_unnamed_8892;
											float fragment_unnamed_8918 = fragment_unnamed_8915 * fragment_unnamed_8893;
											float fragment_unnamed_8922 = rsqrt(dot(float3(fragment_unnamed_8895, fragment_unnamed_8896, fragment_unnamed_8897), float3(fragment_unnamed_8895, fragment_unnamed_8896, fragment_unnamed_8897)));
											float fragment_unnamed_8923 = fragment_unnamed_8922 * fragment_unnamed_8897;
											float fragment_unnamed_8924 = fragment_unnamed_8922 * fragment_unnamed_8895;
											float fragment_unnamed_8925 = fragment_unnamed_8922 * fragment_unnamed_8896;
											float fragment_unnamed_8926 = dot(float3(fragment_unnamed_8903, fragment_unnamed_8904, fragment_unnamed_8902), float3(fragment_unnamed_8909, fragment_unnamed_8910, fragment_unnamed_8911));
											float fragment_unnamed_8956 = mad(abs(fragment_unnamed_8926), mad(abs(fragment_unnamed_8926), mad(abs(fragment_unnamed_8926), mad(abs(fragment_unnamed_8926), mad(abs(fragment_unnamed_8926), mad(abs(fragment_unnamed_8926), mad(abs(fragment_unnamed_8926), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8963 = asfloat((fragment_unnamed_8926 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8926, fragment_unnamed_8926, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8956)) : asuint(fragment_unnamed_8956));
											float fragment_unnamed_8964 = dot(float3(fragment_unnamed_8909, fragment_unnamed_8910, fragment_unnamed_8911), float3(fragment_unnamed_8916, fragment_unnamed_8917, fragment_unnamed_8918));
											float fragment_unnamed_8994 = mad(abs(fragment_unnamed_8964), mad(abs(fragment_unnamed_8964), mad(abs(fragment_unnamed_8964), mad(abs(fragment_unnamed_8964), mad(abs(fragment_unnamed_8964), mad(abs(fragment_unnamed_8964), mad(abs(fragment_unnamed_8964), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9001 = asfloat((fragment_unnamed_8964 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8964, fragment_unnamed_8964, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8994)) : asuint(fragment_unnamed_8994));
											float fragment_unnamed_9008 = dot(float3(fragment_unnamed_8916, fragment_unnamed_8917, fragment_unnamed_8918), float3(fragment_unnamed_8923, fragment_unnamed_8924, fragment_unnamed_8925));
											float fragment_unnamed_9038 = mad(abs(fragment_unnamed_9008), mad(abs(fragment_unnamed_9008), mad(abs(fragment_unnamed_9008), mad(abs(fragment_unnamed_9008), mad(abs(fragment_unnamed_9008), mad(abs(fragment_unnamed_9008), mad(abs(fragment_unnamed_9008), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9045 = asfloat((fragment_unnamed_9008 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9008, fragment_unnamed_9008, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9038)) : asuint(fragment_unnamed_9038));
											float fragment_unnamed_9049 = dot(float3(fragment_unnamed_8925, fragment_unnamed_8923, fragment_unnamed_8924), float3(fragment_unnamed_8902, fragment_unnamed_8903, fragment_unnamed_8904));
											float fragment_unnamed_9079 = mad(abs(fragment_unnamed_9049), mad(abs(fragment_unnamed_9049), mad(abs(fragment_unnamed_9049), mad(abs(fragment_unnamed_9049), mad(abs(fragment_unnamed_9049), mad(abs(fragment_unnamed_9049), mad(abs(fragment_unnamed_9049), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9086 = asfloat((fragment_unnamed_9049 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9049, fragment_unnamed_9049, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9079)) : asuint(fragment_unnamed_9079));
											float fragment_unnamed_9089 = mad(mad(fragment_unnamed_8924, fragment_unnamed_8902, (-0.0f) - (fragment_unnamed_8904 * fragment_unnamed_8925)), fragment_unnamed_9086, mad(mad(fragment_unnamed_8917, fragment_unnamed_8925, (-0.0f) - (fragment_unnamed_8918 * fragment_unnamed_8924)), fragment_unnamed_9045, mad(mad(fragment_unnamed_8904, fragment_unnamed_8911, (-0.0f) - (fragment_unnamed_8910 * fragment_unnamed_8902)), fragment_unnamed_8963, fragment_unnamed_9001 * mad(fragment_unnamed_8910, fragment_unnamed_8918, (-0.0f) - (fragment_unnamed_8911 * fragment_unnamed_8917)))));
											float fragment_unnamed_9090 = mad(mad(fragment_unnamed_8925, fragment_unnamed_8903, (-0.0f) - (fragment_unnamed_8902 * fragment_unnamed_8923)), fragment_unnamed_9086, mad(mad(fragment_unnamed_8918, fragment_unnamed_8923, (-0.0f) - (fragment_unnamed_8916 * fragment_unnamed_8925)), fragment_unnamed_9045, mad(mad(fragment_unnamed_8902, fragment_unnamed_8909, (-0.0f) - (fragment_unnamed_8911 * fragment_unnamed_8903)), fragment_unnamed_8963, fragment_unnamed_9001 * mad(fragment_unnamed_8911, fragment_unnamed_8916, (-0.0f) - (fragment_unnamed_8909 * fragment_unnamed_8918))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9091 = mad(mad(fragment_unnamed_8923, fragment_unnamed_8904, (-0.0f) - (fragment_unnamed_8903 * fragment_unnamed_8924)), fragment_unnamed_9086, mad(mad(fragment_unnamed_8916, fragment_unnamed_8924, (-0.0f) - (fragment_unnamed_8917 * fragment_unnamed_8923)), fragment_unnamed_9045, mad(mad(fragment_unnamed_8903, fragment_unnamed_8910, (-0.0f) - (fragment_unnamed_8909 * fragment_unnamed_8904)), fragment_unnamed_8963, fragment_unnamed_9001 * mad(fragment_unnamed_8909, fragment_unnamed_8917, (-0.0f) - (fragment_unnamed_8910 * fragment_unnamed_8916))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9092 = fragment_unnamed_9089 * 0.15915493667125701904296875f;
											float fragment_unnamed_9093 = dot(float3(fragment_unnamed_9090, fragment_unnamed_9091, fragment_unnamed_9092), float3(fragment_unnamed_9090, fragment_unnamed_9091, fragment_unnamed_9092));
											float fragment_unnamed_9344;
											float fragment_unnamed_9345;
											float fragment_unnamed_9346;
											if (fragment_unnamed_5043 != 0u)
											{
												float fragment_unnamed_9211 = ((-0.0f) - fragment_unnamed_8882) + fragment_unnamed_8895;
												float fragment_unnamed_9212 = ((-0.0f) - fragment_unnamed_8883) + fragment_unnamed_8896;
												float fragment_unnamed_9213 = ((-0.0f) - fragment_unnamed_8884) + fragment_unnamed_8897;
												float fragment_unnamed_9220 = mad(fragment_unnamed_9212, fragment_unnamed_8887, (-0.0f) - (fragment_unnamed_8886 * fragment_unnamed_9213));
												float fragment_unnamed_9221 = mad(fragment_unnamed_9213, fragment_unnamed_8885, (-0.0f) - (fragment_unnamed_8887 * fragment_unnamed_9211));
												float fragment_unnamed_9222 = mad(fragment_unnamed_9211, fragment_unnamed_8886, (-0.0f) - (fragment_unnamed_8885 * fragment_unnamed_9212));
												float fragment_unnamed_9226 = rsqrt(dot(float3(fragment_unnamed_9220, fragment_unnamed_9221, fragment_unnamed_9222), float3(fragment_unnamed_9220, fragment_unnamed_9221, fragment_unnamed_9222)));
												float fragment_unnamed_9227 = fragment_unnamed_9226 * fragment_unnamed_9220;
												float fragment_unnamed_9228 = fragment_unnamed_9226 * fragment_unnamed_9221;
												float fragment_unnamed_9229 = fragment_unnamed_9226 * fragment_unnamed_9222;
												float fragment_unnamed_9236 = dot(float3(fragment_unnamed_8882, fragment_unnamed_8883, fragment_unnamed_8884), float3(fragment_unnamed_9227, fragment_unnamed_9228, fragment_unnamed_9229)) / dot(float3(fragment_unnamed_9090, fragment_unnamed_9091, fragment_unnamed_9092), float3(fragment_unnamed_9227, fragment_unnamed_9228, fragment_unnamed_9229));
												float fragment_unnamed_9240 = mad(fragment_unnamed_9236, fragment_unnamed_9227, (-0.0f) - fragment_unnamed_8882);
												float fragment_unnamed_9241 = mad(fragment_unnamed_9236, fragment_unnamed_9228, (-0.0f) - fragment_unnamed_8883);
												float fragment_unnamed_9242 = mad(fragment_unnamed_9236, fragment_unnamed_9229, (-0.0f) - fragment_unnamed_8884);
												float fragment_unnamed_9246 = 1.0f / dot(float3(fragment_unnamed_9211, fragment_unnamed_9212, fragment_unnamed_9213), float3(fragment_unnamed_9211, fragment_unnamed_9212, fragment_unnamed_9213));
												float fragment_unnamed_9247 = dot(float3(fragment_unnamed_8885, fragment_unnamed_8886, fragment_unnamed_8887), float3(fragment_unnamed_9211, fragment_unnamed_9212, fragment_unnamed_9213));
												float fragment_unnamed_9256 = mad((-0.0f) - (fragment_unnamed_9211 * fragment_unnamed_9247), fragment_unnamed_9246, fragment_unnamed_8885);
												float fragment_unnamed_9257 = mad((-0.0f) - (fragment_unnamed_9212 * fragment_unnamed_9247), fragment_unnamed_9246, fragment_unnamed_8886);
												float fragment_unnamed_9258 = mad((-0.0f) - (fragment_unnamed_9213 * fragment_unnamed_9247), fragment_unnamed_9246, fragment_unnamed_8887);
												float fragment_unnamed_9265 = dot(float3(fragment_unnamed_9240, fragment_unnamed_9241, fragment_unnamed_9242), float3(fragment_unnamed_9256, fragment_unnamed_9257, fragment_unnamed_9258)) / dot(float3(fragment_unnamed_9256, fragment_unnamed_9257, fragment_unnamed_9258), float3(fragment_unnamed_9256, fragment_unnamed_9257, fragment_unnamed_9258));
												float fragment_unnamed_9278 = round(log2(fragment_unnamed_5086 * fragment_uniform_buffer_1[122u].x));
												float fragment_unnamed_9288 = min(mad(fragment_unnamed_2814, ((-0.0f) - fragment_unnamed_9278) + 3.0f, fragment_unnamed_9278), max(mad(log2(mad(fragment_unnamed_9226 * (fragment_unnamed_9236 * fragment_unnamed_9236), 3.1415927410125732421875f, 9.9999999392252902907785028219223e-09f)), 0.5f, fragment_unnamed_9278), 0.0f));
												float fragment_unnamed_9302 = 1.0f / (fragment_unnamed_5086 + fragment_uniform_buffer_1[123u].y);
												float fragment_unnamed_9303 = 1.0f / (fragment_unnamed_5088 + fragment_uniform_buffer_1[123u].y);
												float fragment_unnamed_9313 = exp2(ceil(max(fragment_unnamed_9288 + ((-0.0f) - fragment_uniform_buffer_1[123u].z), 0.0f)));
												float fragment_unnamed_9317 = fragment_unnamed_5086 * fragment_uniform_buffer_1[123u].x;
												float fragment_unnamed_9318 = fragment_unnamed_5088 * fragment_uniform_buffer_1[123u].x;
												float fragment_unnamed_9321 = fragment_unnamed_9313 / (fragment_unnamed_9317 + fragment_unnamed_9317);
												float fragment_unnamed_9322 = fragment_unnamed_9313 / (fragment_unnamed_9318 + fragment_unnamed_9318);
												float4 fragment_unnamed_9336 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_9321) + 1.0f, max(fragment_unnamed_9321, mad(clamp(mad((-0.0f) - mad((-0.0f) - fragment_unnamed_9247, fragment_unnamed_9265, dot(float3(fragment_unnamed_9240, fragment_unnamed_9241, fragment_unnamed_9242), float3(fragment_unnamed_9211, fragment_unnamed_9212, fragment_unnamed_9213))), fragment_unnamed_9246, 1.0f), 0.0f, 1.0f), fragment_unnamed_5086 * fragment_unnamed_9302, mad((-0.0f) - fragment_unnamed_9302, fragment_unnamed_5086, 1.0f) * 0.5f))), fragment_unnamed_5086, fragment_unnamed_5104), mad(min(((-0.0f) - fragment_unnamed_9322) + 1.0f, max(fragment_unnamed_9322, mad(clamp(fragment_unnamed_9265, 0.0f, 1.0f), fragment_unnamed_5088 * fragment_unnamed_9303, mad((-0.0f) - fragment_unnamed_9303, fragment_unnamed_5088, 1.0f) * 0.5f))), fragment_unnamed_5088, fragment_unnamed_5106)), fragment_unnamed_9288);
												fragment_unnamed_9344 = fragment_unnamed_9336.x;
												fragment_unnamed_9345 = fragment_unnamed_9336.y;
												fragment_unnamed_9346 = fragment_unnamed_9336.z;
											}
											else
											{
												fragment_unnamed_9344 = asfloat(1065353216u);
												fragment_unnamed_9345 = asfloat(1065353216u);
												fragment_unnamed_9346 = asfloat(1065353216u);
											}
											fragment_unnamed_9204 = max(mad(fragment_unnamed_9089, 0.15915493667125701904296875f, fragment_unnamed_9093) / (sqrt(fragment_unnamed_9093) + 1.0f), 0.0f);
											fragment_unnamed_9205 = fragment_unnamed_9344;
											fragment_unnamed_9206 = fragment_unnamed_9345;
											fragment_unnamed_9207 = fragment_unnamed_9346;
										}
										else
										{
											float fragment_unnamed_9105 = mad((-0.0f) - fragment_unnamed_898, fragment_unnamed_7035, fragment_unnamed_7033) * fragment_unnamed_899;
											float fragment_unnamed_9106 = fragment_unnamed_2816 * fragment_unnamed_7034;
											float fragment_unnamed_9109 = mad((-0.0f) - fragment_unnamed_900, fragment_unnamed_7033, fragment_unnamed_897 * fragment_unnamed_7035) * fragment_unnamed_899;
											float fragment_unnamed_9120 = (1.0f / fragment_unnamed_8675) * ((-0.0f) - fragment_unnamed_8672);
											bool fragment_unnamed_9121 = fragment_unnamed_8675 >= 0.0f;
											float fragment_unnamed_9136 = dot(float3(fragment_unnamed_8847, fragment_unnamed_8850, fragment_unnamed_8675), float3(fragment_unnamed_8847, fragment_unnamed_8850, fragment_unnamed_8675));
											float fragment_unnamed_9139 = rsqrt(fragment_unnamed_9136);
											float fragment_unnamed_9140 = fragment_unnamed_9136 * fragment_unnamed_9139;
											float fragment_unnamed_9141 = fragment_unnamed_9139 * fragment_unnamed_8847;
											float fragment_unnamed_9142 = fragment_unnamed_9139 * fragment_unnamed_8850;
											float fragment_unnamed_9143 = fragment_unnamed_9139 * fragment_unnamed_8675;
											float fragment_unnamed_9144 = dot(float3(fragment_unnamed_9141, fragment_unnamed_9142, fragment_unnamed_9143), float3(fragment_unnamed_8843, fragment_unnamed_8846, fragment_unnamed_8672));
											float fragment_unnamed_9147 = (-0.0f) - fragment_unnamed_9144;
											float fragment_unnamed_9148 = mad(fragment_unnamed_9147, fragment_unnamed_9141, fragment_unnamed_8843);
											float fragment_unnamed_9149 = mad(fragment_unnamed_9147, fragment_unnamed_9142, fragment_unnamed_8846);
											float fragment_unnamed_9150 = mad(fragment_unnamed_9147, fragment_unnamed_9143, fragment_unnamed_8672);
											float fragment_unnamed_9151 = dot(float3(fragment_unnamed_9148, fragment_unnamed_9149, fragment_unnamed_9150), float3(fragment_unnamed_9148, fragment_unnamed_9149, fragment_unnamed_9150));
											float fragment_unnamed_9154 = rsqrt(fragment_unnamed_9151);
											float fragment_unnamed_9156 = fragment_unnamed_9154 * fragment_unnamed_9150;
											float fragment_unnamed_9157 = mad(asfloat(fragment_unnamed_9121 ? asuint(max(fragment_unnamed_9120, fragment_unnamed_5135)) : asuint(min(fragment_unnamed_9120, fragment_unnamed_5135))), fragment_unnamed_9140, fragment_unnamed_9144);
											float fragment_unnamed_9158 = mad(asfloat(fragment_unnamed_9121 ? asuint(max(fragment_unnamed_9120, (-0.0f) - fragment_unnamed_5135)) : asuint(min(fragment_unnamed_9120, (-0.0f) - fragment_unnamed_5135))), fragment_unnamed_9140, fragment_unnamed_9144);
											float fragment_unnamed_9159 = mad(fragment_unnamed_9157, fragment_unnamed_9157, fragment_unnamed_9151);
											float fragment_unnamed_9160 = mad(fragment_unnamed_9158, fragment_unnamed_9158, fragment_unnamed_9151);
											float fragment_unnamed_9162 = rsqrt(fragment_unnamed_9159 * fragment_unnamed_9160);
											float fragment_unnamed_9163 = fragment_unnamed_9162 * fragment_unnamed_9162;
											float fragment_unnamed_9166 = (fragment_unnamed_9151 * fragment_unnamed_9154) * fragment_unnamed_9143;
											float fragment_unnamed_9176 = min(fragment_unnamed_9162 * mad(fragment_unnamed_9158, fragment_unnamed_9157, fragment_unnamed_9151), 1.0f);
											float fragment_unnamed_9180 = sqrt(((-0.0f) - abs(fragment_unnamed_9176)) + 1.0f);
											float fragment_unnamed_9186 = mad(mad(mad(abs(fragment_unnamed_9176), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_9176), -0.212114393711090087890625f), abs(fragment_unnamed_9176), 1.570728778839111328125f);
											fragment_unnamed_9204 = ((fragment_unnamed_7036 * (abs(fragment_unnamed_2817) * rsqrt(fragment_unnamed_7036 * dot(float3(fragment_unnamed_9105, fragment_unnamed_9106, fragment_unnamed_9109), float3(fragment_unnamed_9105, fragment_unnamed_9106, fragment_unnamed_9109))))) * max(mad(mad(fragment_unnamed_9186, fragment_unnamed_9180, asfloat(((fragment_unnamed_9176 < ((-0.0f) - fragment_unnamed_9176)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_9180 * fragment_unnamed_9186, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_9154 * fragment_unnamed_9156, mad(mad(fragment_unnamed_9156, fragment_unnamed_9157, (-0.0f) - fragment_unnamed_9166), fragment_unnamed_9160 * fragment_unnamed_9163, (-0.0f) - ((fragment_unnamed_9159 * fragment_unnamed_9163) * mad(fragment_unnamed_9156, fragment_unnamed_9158, (-0.0f) - fragment_unnamed_9166)))), 0.0f)) * 0.3183098733425140380859375f;
											fragment_unnamed_9205 = asfloat(1065353216u);
											fragment_unnamed_9206 = asfloat(1065353216u);
											fragment_unnamed_9207 = asfloat(1065353216u);
										}
										fragment_unnamed_8856 = fragment_unnamed_9204;
										fragment_unnamed_8858 = fragment_unnamed_9205;
										fragment_unnamed_8860 = fragment_unnamed_9206;
										fragment_unnamed_8862 = fragment_unnamed_9207;
									}
									else
									{
										fragment_unnamed_8856 = asfloat(0u);
										fragment_unnamed_8858 = asfloat(1065353216u);
										fragment_unnamed_8860 = asfloat(1065353216u);
										fragment_unnamed_8862 = asfloat(1065353216u);
									}
									fragment_unnamed_8855 = fragment_unnamed_8856;
									fragment_unnamed_8857 = fragment_unnamed_8858;
									fragment_unnamed_8859 = fragment_unnamed_8860;
									fragment_unnamed_8861 = fragment_unnamed_8862;
								}
								else
								{
									fragment_unnamed_8855 = asfloat(0u);
									fragment_unnamed_8857 = asfloat(1065353216u);
									fragment_unnamed_8859 = asfloat(1065353216u);
									fragment_unnamed_8861 = asfloat(1065353216u);
								}
								float fragment_unnamed_8863 = (asfloat(fragment_unnamed_6995.y) * fragment_unnamed_5178) * fragment_unnamed_8855;
								fragment_unnamed_7354 = fragment_unnamed_6492 * (fragment_unnamed_8863 * (fragment_unnamed_858 * fragment_unnamed_8857));
								fragment_unnamed_7356 = fragment_unnamed_6494 * (fragment_unnamed_8863 * (fragment_unnamed_859 * fragment_unnamed_8859));
								fragment_unnamed_7358 = fragment_unnamed_6496 * (fragment_unnamed_8863 * (fragment_unnamed_860 * fragment_unnamed_8861));
								fragment_unnamed_7360 = (fragment_unnamed_782 * fragment_unnamed_6492) * (fragment_unnamed_7613 * fragment_unnamed_7605);
								fragment_unnamed_7362 = (fragment_unnamed_782 * fragment_unnamed_6494) * (fragment_unnamed_7613 * fragment_unnamed_7607);
								fragment_unnamed_7364 = (fragment_unnamed_782 * fragment_unnamed_6496) * (fragment_unnamed_7613 * fragment_unnamed_7609);
							}
							else
							{
								fragment_unnamed_7354 = asfloat(0u);
								fragment_unnamed_7356 = asfloat(0u);
								fragment_unnamed_7358 = asfloat(0u);
								fragment_unnamed_7360 = asfloat(0u);
								fragment_unnamed_7362 = asfloat(0u);
								fragment_unnamed_7364 = asfloat(0u);
							}
							fragment_unnamed_3426 = fragment_unnamed_3425 + fragment_unnamed_7360;
							fragment_unnamed_3428 = fragment_unnamed_3427 + fragment_unnamed_7362;
							fragment_unnamed_3430 = fragment_unnamed_3429 + fragment_unnamed_7364;
							fragment_unnamed_3432 = fragment_unnamed_3431 + fragment_unnamed_7354;
							fragment_unnamed_3434 = fragment_unnamed_3433 + fragment_unnamed_7356;
							fragment_unnamed_3436 = fragment_unnamed_3435 + fragment_unnamed_7358;
							fragment_unnamed_3425 = fragment_unnamed_3426;
							fragment_unnamed_3427 = fragment_unnamed_3428;
							fragment_unnamed_3429 = fragment_unnamed_3430;
							fragment_unnamed_3431 = fragment_unnamed_3432;
							fragment_unnamed_3433 = fragment_unnamed_3434;
							fragment_unnamed_3435 = fragment_unnamed_3436;
							fragment_unnamed_3437 = fragment_unnamed_3438;
							continue;
						}
					}
					if (ladder_phi_85)
					{
						break;
					}
					break;
				}
				float fragment_unnamed_3785 = mad(fragment_unnamed_419, fragment_uniform_buffer_4[2u].x * fragment_uniform_buffer_4[4u].x, mad(fragment_unnamed_749, fragment_unnamed_3425, max(mad(fragment_unnamed_749, 2.755199909210205078125f, mad(fragment_unnamed_749, -4.79510021209716796875f, mad(fragment_unnamed_749, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f) * (fragment_unnamed_826 * ((fragment_unnamed_782 * mad(fragment_unnamed_794, mad((-0.0f) - fragment_unnamed_387, fragment_unnamed_748, fragment_unnamed_759), fragment_unnamed_749)) * fragment_unnamed_738))));
				float fragment_unnamed_3786 = mad(fragment_unnamed_419, fragment_uniform_buffer_4[2u].y * fragment_uniform_buffer_4[4u].x, mad(fragment_unnamed_750, fragment_unnamed_3427, max(mad(fragment_unnamed_750, 2.755199909210205078125f, mad(fragment_unnamed_750, -4.79510021209716796875f, mad(fragment_unnamed_750, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f) * (fragment_unnamed_826 * ((fragment_unnamed_782 * mad(fragment_unnamed_794, mad((-0.0f) - fragment_unnamed_388, fragment_unnamed_748, fragment_unnamed_761), fragment_unnamed_750)) * fragment_unnamed_739))));
				float fragment_unnamed_3787 = mad(fragment_unnamed_419, fragment_uniform_buffer_4[2u].z * fragment_uniform_buffer_4[4u].x, mad(fragment_unnamed_751, fragment_unnamed_3429, max(mad(fragment_unnamed_751, 2.755199909210205078125f, mad(fragment_unnamed_751, -4.79510021209716796875f, mad(fragment_unnamed_751, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f) * (fragment_unnamed_826 * ((fragment_unnamed_782 * mad(fragment_unnamed_794, mad((-0.0f) - fragment_unnamed_389, fragment_unnamed_748, fragment_unnamed_762), fragment_unnamed_751)) * fragment_unnamed_740))));
				float fragment_unnamed_3803 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_1[118u].y;
				bool fragment_unnamed_3813 = fragment_uniform_buffer_4[12u].x == 0.0f;
				bool fragment_unnamed_3814 = fragment_uniform_buffer_4[12u].x == 1.0f;
				bool fragment_unnamed_3815 = fragment_uniform_buffer_4[12u].x == 4.0f;
				float fragment_unnamed_3825 = asfloat((0.0f != fragment_uniform_buffer_4[12u].y) ? 1065353216u : asuint(fragment_unnamed_422));
				float fragment_unnamed_3826 = (fragment_unnamed_3803 * (mad(fragment_unnamed_828 * fragment_unnamed_2233, max(mad(fragment_unnamed_759, 2.755199909210205078125f, mad(fragment_unnamed_759, -4.79510021209716796875f, mad(fragment_unnamed_759, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_3431) * mad(fragment_unnamed_759, fragment_unnamed_862, 1.0f))) * fragment_unnamed_3825;
				float fragment_unnamed_3827 = (fragment_unnamed_3803 * (mad(fragment_unnamed_828 * fragment_unnamed_2235, max(mad(fragment_unnamed_761, 2.755199909210205078125f, mad(fragment_unnamed_761, -4.79510021209716796875f, mad(fragment_unnamed_761, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_3433) * mad(fragment_unnamed_761, fragment_unnamed_862, 1.0f))) * fragment_unnamed_3825;
				float fragment_unnamed_3828 = (fragment_unnamed_3803 * (mad(fragment_unnamed_828 * fragment_unnamed_2237, max(mad(fragment_unnamed_762, 2.755199909210205078125f, mad(fragment_unnamed_762, -4.79510021209716796875f, mad(fragment_unnamed_762, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_3435) * mad(fragment_unnamed_762, fragment_unnamed_862, 1.0f))) * fragment_unnamed_3825;
				bool fragment_unnamed_3835 = ((fragment_unnamed_3814 ? 4294967295u : 0u) | (fragment_unnamed_3813 ? 4294967295u : 0u)) != 0u;
				uint fragment_unnamed_3842 = fragment_unnamed_3835 ? asuint(mad(fragment_unnamed_3803 * fragment_unnamed_3785, fragment_unnamed_422, fragment_unnamed_3826)) : asuint(mad(fragment_unnamed_3785, fragment_unnamed_3803, fragment_unnamed_3826));
				uint fragment_unnamed_3844 = fragment_unnamed_3835 ? asuint(mad(fragment_unnamed_3803 * fragment_unnamed_3786, fragment_unnamed_422, fragment_unnamed_3827)) : asuint(mad(fragment_unnamed_3786, fragment_unnamed_3803, fragment_unnamed_3827));
				uint fragment_unnamed_3846 = fragment_unnamed_3835 ? asuint(mad(fragment_unnamed_3803 * fragment_unnamed_3787, fragment_unnamed_422, fragment_unnamed_3828)) : asuint(mad(fragment_unnamed_3787, fragment_unnamed_3803, fragment_unnamed_3828));
				uint fragment_unnamed_4979;
				uint fragment_unnamed_4981;
				float fragment_unnamed_4983;
				float fragment_unnamed_4985;
				float fragment_unnamed_4987;
				if (asuint(fragment_uniform_buffer_1[211u]).y != 1u)
				{
					float fragment_unnamed_4443 = float(fragment_unnamed_272);
					float fragment_unnamed_4444 = float(fragment_unnamed_273);
					uint fragment_unnamed_4464 = min(T18.Load(1u).x, max(((-T18.Load(0u).x) + 4294967295u), uint(round(dot(float2(fragment_unnamed_4443, fragment_unnamed_4444), float2(fragment_uniform_buffer_1[103u].y * 1.0f, fragment_uniform_buffer_1[103u].x * (-1.0f))) + ((-0.0f) - fragment_uniform_buffer_1[102u].x)))));
					bool fragment_unnamed_4496 = ((((-0.0f) - float((T18.Load(fragment_unnamed_4464 + 2u).x & 65535u) + 4294967295u)) + floor(dot(float2(fragment_unnamed_4443, fragment_unnamed_4444), float2(fragment_uniform_buffer_1[103u].xy)) + ((-0.0f) - fragment_uniform_buffer_1[102u].z))) / (((-0.0f) - fragment_uniform_buffer_1[102u].z) + fragment_uniform_buffer_1[102u].w)) < 0.0f;
					uint fragment_unnamed_4497 = fragment_unnamed_4496 ? 4294967295u : 0u;
					float fragment_unnamed_4498 = asfloat(fragment_unnamed_4497);
					uint fragment_unnamed_4980;
					uint fragment_unnamed_4982;
					float fragment_unnamed_4984;
					float fragment_unnamed_4986;
					float fragment_unnamed_4988;
					if (asuint(fragment_uniform_buffer_1[113u]).x != 0u)
					{
						float4 fragment_unnamed_4932 = _RefractiveDepthBuffer.Load(int4(uint3(fragment_unnamed_272, fragment_unnamed_273, 0u), 0u));
						float fragment_unnamed_4934 = fragment_unnamed_4932.x;
						uint4 fragment_unnamed_4935 = _StencilTexture.Load(int4(uint3(fragment_unnamed_272, fragment_unnamed_273, 0u), 0u));
						uint fragment_unnamed_4937 = fragment_unnamed_4935.y;
						uint fragment_unnamed_4939 = fragment_unnamed_4937 & 32u;
						uint fragment_unnamed_4975 = ((fragment_unnamed_4937 & 1u) != 0u) ? 4294967295u : ((((((((fragment_unnamed_4939 != 0u) ? 4294967295u : 0u) & fragment_unnamed_4497) & ((fragment_unnamed_4934 >= gl_FragCoord.z) ? 4294967295u : 0u)) != 0u) ? 3.4028234663852885981170418348452e+38f : gl_FragCoord.z) < asfloat(fragment_unnamed_4496 ? 2139095039u : ((fragment_unnamed_4939 != 0u) ? asuint(fragment_unnamed_4934) : 0u))) ? (fragment_unnamed_4496 ? asuint(fragment_uniform_buffer_1[107u]).x : (uint(_WaterGBufferTexture3.Load(int4(uint3(fragment_unnamed_272, fragment_unnamed_273, 0u), 0u)).w * 255.0f) & 15u)) : 4294967295u);
						uint fragment_unnamed_6019;
						uint fragment_unnamed_6020;
						float fragment_unnamed_6021;
						float fragment_unnamed_6022;
						float fragment_unnamed_6023;
						if (fragment_unnamed_4975 == 4294967295u)
						{
							fragment_unnamed_6019 = 0u;
							fragment_unnamed_6020 = 0u;
							fragment_unnamed_6021 = asfloat(0u);
							fragment_unnamed_6022 = asfloat(0u);
							fragment_unnamed_6023 = asfloat(0u);
						}
						else
						{
							uint fragment_unnamed_6175;
							uint fragment_unnamed_6176;
							float fragment_unnamed_6177;
							if (fragment_unnamed_4497 == 0u)
							{
								uint fragment_unnamed_6179 = (fragment_unnamed_4975 * 28u) + 4u;
								uint3 fragment_unnamed_6188 = uint3(T20.Load(fragment_unnamed_6179).x, T20.Load(fragment_unnamed_6179 + 1u).x, T20.Load(fragment_unnamed_6179 + 2u).x);
								float fragment_unnamed_6201 = mad(fragment_unnamed_4443 * fragment_uniform_buffer_1[50u].z, 2.0f, -1.0f);
								float fragment_unnamed_6203 = (-0.0f) - mad(fragment_unnamed_4444 * fragment_uniform_buffer_1[50u].w, 2.0f, -1.0f);
								float fragment_unnamed_6243 = mad(fragment_uniform_buffer_1[30u].w, fragment_unnamed_4934, mad(fragment_uniform_buffer_1[28u].w, fragment_unnamed_6201, fragment_unnamed_6203 * fragment_uniform_buffer_1[29u].w)) + fragment_uniform_buffer_1[31u].w;
								float fragment_unnamed_6256 = ((-0.0f) - ((mad(fragment_uniform_buffer_1[30u].x, fragment_unnamed_4934, mad(fragment_uniform_buffer_1[28u].x, fragment_unnamed_6201, fragment_unnamed_6203 * fragment_uniform_buffer_1[29u].x)) + fragment_uniform_buffer_1[31u].x) / fragment_unnamed_6243)) + fragment_input_6.x;
								float fragment_unnamed_6257 = ((-0.0f) - ((mad(fragment_uniform_buffer_1[30u].y, fragment_unnamed_4934, mad(fragment_uniform_buffer_1[28u].y, fragment_unnamed_6201, fragment_unnamed_6203 * fragment_uniform_buffer_1[29u].y)) + fragment_uniform_buffer_1[31u].y) / fragment_unnamed_6243)) + fragment_input_6.y;
								float fragment_unnamed_6258 = ((-0.0f) - ((mad(fragment_uniform_buffer_1[30u].z, fragment_unnamed_4934, mad(fragment_uniform_buffer_1[28u].z, fragment_unnamed_6201, fragment_unnamed_6203 * fragment_uniform_buffer_1[29u].z)) + fragment_uniform_buffer_1[31u].z) / fragment_unnamed_6243)) + fragment_input_6.z;
								float fragment_unnamed_6262 = sqrt(dot(float3(fragment_unnamed_6256, fragment_unnamed_6257, fragment_unnamed_6258), float3(fragment_unnamed_6256, fragment_unnamed_6257, fragment_unnamed_6258)));
								float fragment_unnamed_6263 = fragment_unnamed_6262 + fragment_unnamed_6262;
								fragment_unnamed_6175 = asuint(((-0.0f) - exp2((asfloat(fragment_unnamed_6188.y) * fragment_unnamed_6263) * (-1.44269502162933349609375f))) + 1.0f);
								fragment_unnamed_6176 = asuint(((-0.0f) - exp2((asfloat(fragment_unnamed_6188.x) * fragment_unnamed_6263) * (-1.44269502162933349609375f))) + 1.0f);
								fragment_unnamed_6177 = ((-0.0f) - exp2((asfloat(fragment_unnamed_6188.z) * fragment_unnamed_6263) * (-1.44269502162933349609375f))) + 1.0f;
							}
							else
							{
								fragment_unnamed_6175 = 0u;
								fragment_unnamed_6176 = 0u;
								fragment_unnamed_6177 = asfloat(0u);
							}
							fragment_unnamed_6019 = fragment_unnamed_6175;
							fragment_unnamed_6020 = fragment_unnamed_6176;
							fragment_unnamed_6021 = asfloat(~fragment_unnamed_4497);
							fragment_unnamed_6022 = fragment_unnamed_4498;
							fragment_unnamed_6023 = fragment_unnamed_6177;
						}
						fragment_unnamed_4980 = fragment_unnamed_6019;
						fragment_unnamed_4982 = fragment_unnamed_6020;
						fragment_unnamed_4984 = fragment_unnamed_6021;
						fragment_unnamed_4986 = fragment_unnamed_6022;
						fragment_unnamed_4988 = fragment_unnamed_6023;
					}
					else
					{
						fragment_unnamed_4980 = 0u;
						fragment_unnamed_4982 = 0u;
						fragment_unnamed_4984 = asfloat(0u);
						fragment_unnamed_4986 = fragment_unnamed_4498;
						fragment_unnamed_4988 = asfloat(0u);
					}
					fragment_unnamed_4979 = fragment_unnamed_4980;
					fragment_unnamed_4981 = fragment_unnamed_4982;
					fragment_unnamed_4983 = fragment_unnamed_4984;
					fragment_unnamed_4985 = fragment_unnamed_4986;
					fragment_unnamed_4987 = fragment_unnamed_4988;
				}
				else
				{
					fragment_unnamed_4979 = 0u;
					fragment_unnamed_4981 = 0u;
					fragment_unnamed_4983 = asfloat(0u);
					fragment_unnamed_4985 = asfloat(0u);
					fragment_unnamed_4987 = asfloat(0u);
				}
				uint fragment_unnamed_6291;
				uint fragment_unnamed_6293;
				float fragment_unnamed_6295;
				float fragment_unnamed_6297;
				float fragment_unnamed_6299;
				float fragment_unnamed_6301;
				if (asuint(fragment_unnamed_4983) == 0u)
				{
					float fragment_unnamed_6030 = 1.0f / dot(float3(fragment_unnamed_868, fragment_unnamed_869, fragment_unnamed_870), float3((-0.0f) - asfloat(fragment_unnamed_310), (-0.0f) - asfloat(fragment_unnamed_315), (-0.0f) - asfloat(fragment_unnamed_320)));
					float fragment_unnamed_6034 = fragment_unnamed_6030 * (1.0f / gl_FragCoord.w);
					float fragment_unnamed_6673;
					uint fragment_unnamed_6675;
					uint fragment_unnamed_6677;
					float fragment_unnamed_6678;
					float fragment_unnamed_6680;
					float fragment_unnamed_6682;
					float fragment_unnamed_6684;
					if (asuint(fragment_uniform_buffer_1[84u]).x != 0u)
					{
						float fragment_unnamed_6674;
						float fragment_unnamed_7245;
						float fragment_unnamed_7247;
						float fragment_unnamed_7249;
						float fragment_unnamed_7251;
						if (asuint(fragment_uniform_buffer_1[84u]).z != 0u)
						{
							float fragment_unnamed_6661 = mad((-0.0f) - fragment_uniform_buffer_1[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_1[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6030, (-0.0f) - fragment_uniform_buffer_1[94u].z), 0.0f)), fragment_uniform_buffer_1[94u].x));
							float fragment_unnamed_7396;
							float fragment_unnamed_7397;
							float fragment_unnamed_7398;
							float fragment_unnamed_7399;
							if (asuint(fragment_uniform_buffer_1[89u]).w == 0u)
							{
								float fragment_unnamed_7072 = fragment_unnamed_282 * fragment_uniform_buffer_1[91u].x;
								float fragment_unnamed_7073 = fragment_unnamed_283 * fragment_uniform_buffer_1[91u].y;
								float fragment_unnamed_7074 = floor(fragment_unnamed_7072);
								float fragment_unnamed_7075 = floor(fragment_unnamed_7073);
								float fragment_unnamed_7080 = ((-0.0f) - frac(fragment_unnamed_7072)) + 1.0f;
								float fragment_unnamed_7081 = ((-0.0f) - frac(fragment_unnamed_7073)) + 1.0f;
								float fragment_unnamed_7082 = fragment_unnamed_7081 * fragment_unnamed_7081;
								float fragment_unnamed_7083 = fragment_unnamed_7080 * fragment_unnamed_7080;
								float fragment_unnamed_7088 = mad(((-0.0f) - fragment_unnamed_7080) + 1.0f, fragment_unnamed_7080, 0.5f);
								float fragment_unnamed_7089 = mad(((-0.0f) - fragment_unnamed_7081) + 1.0f, fragment_unnamed_7081, 0.5f);
								float fragment_unnamed_7096 = ((-0.0f) - fragment_unnamed_7088) + mad((-0.0f) - fragment_unnamed_7083, 0.5f, 1.0f);
								float fragment_unnamed_7097 = ((-0.0f) - fragment_unnamed_7089) + mad((-0.0f) - fragment_unnamed_7082, 0.5f, 1.0f);
								float fragment_unnamed_7098 = fragment_unnamed_7088 * 0.5f;
								float fragment_unnamed_7099 = fragment_unnamed_7089 * 0.5f;
								float fragment_unnamed_7100 = mad(fragment_unnamed_7082, 0.5f, fragment_unnamed_7099);
								float fragment_unnamed_7101 = mad(fragment_unnamed_7083, 0.5f, fragment_unnamed_7098);
								float fragment_unnamed_7102 = mad(fragment_unnamed_7088, 0.5f, fragment_unnamed_7096);
								float fragment_unnamed_7103 = mad(fragment_unnamed_7089, 0.5f, fragment_unnamed_7097);
								float fragment_unnamed_7106 = mad(fragment_unnamed_7098, 1.0f / fragment_unnamed_7101, -0.5f);
								float fragment_unnamed_7107 = mad(fragment_unnamed_7099, 1.0f / fragment_unnamed_7100, -0.5f);
								float fragment_unnamed_7110 = mad(fragment_unnamed_7096, 1.0f / fragment_unnamed_7102, 0.5f);
								float fragment_unnamed_7111 = mad(fragment_unnamed_7097, 1.0f / fragment_unnamed_7103, 0.5f);
								float fragment_unnamed_7121 = fragment_uniform_buffer_1[91u].z * fragment_uniform_buffer_1[92u].x;
								float fragment_unnamed_7122 = fragment_uniform_buffer_1[91u].w * fragment_uniform_buffer_1[92u].y;
								float fragment_unnamed_7142 = fragment_unnamed_6661 * fragment_uniform_buffer_1[92u].z;
								float fragment_unnamed_7143 = fragment_unnamed_7100 * fragment_unnamed_7101;
								float4 fragment_unnamed_7154 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7121 * (fragment_unnamed_7074 + fragment_unnamed_7106), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_7122 * (fragment_unnamed_7075 + fragment_unnamed_7107), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_7142, fragment_uniform_buffer_1[93u].z)), 0.0f);
								float fragment_unnamed_7160 = fragment_unnamed_7100 * fragment_unnamed_7102;
								float fragment_unnamed_7161 = fragment_unnamed_7101 * fragment_unnamed_7103;
								float4 fragment_unnamed_7170 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7121 * (fragment_unnamed_7074 + fragment_unnamed_7110), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_7122 * (fragment_unnamed_7075 + fragment_unnamed_7107), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_7142, fragment_uniform_buffer_1[93u].z)), 0.0f);
								float4 fragment_unnamed_7192 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7121 * (fragment_unnamed_7074 + fragment_unnamed_7106), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_7122 * (fragment_unnamed_7075 + fragment_unnamed_7111), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_7142, fragment_uniform_buffer_1[93u].z)), 0.0f);
								float fragment_unnamed_7202 = fragment_unnamed_7103 * fragment_unnamed_7102;
								float4 fragment_unnamed_7211 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7121 * (fragment_unnamed_7074 + fragment_unnamed_7110), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_7122 * (fragment_unnamed_7075 + fragment_unnamed_7111), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_7142, fragment_uniform_buffer_1[93u].z)), 0.0f);
								fragment_unnamed_7396 = mad(fragment_unnamed_7202, fragment_unnamed_7211.w, mad(fragment_unnamed_7161, fragment_unnamed_7192.w, mad(fragment_unnamed_7143, fragment_unnamed_7154.w, fragment_unnamed_7160 * fragment_unnamed_7170.w)));
								fragment_unnamed_7397 = mad(fragment_unnamed_7202, fragment_unnamed_7211.z, mad(fragment_unnamed_7161, fragment_unnamed_7192.z, mad(fragment_unnamed_7143, fragment_unnamed_7154.z, fragment_unnamed_7160 * fragment_unnamed_7170.z)));
								fragment_unnamed_7398 = mad(fragment_unnamed_7202, fragment_unnamed_7211.y, mad(fragment_unnamed_7161, fragment_unnamed_7192.y, mad(fragment_unnamed_7143, fragment_unnamed_7154.y, fragment_unnamed_7160 * fragment_unnamed_7170.y)));
								fragment_unnamed_7399 = mad(fragment_unnamed_7202, fragment_unnamed_7211.x, mad(fragment_unnamed_7161, fragment_unnamed_7192.x, mad(fragment_unnamed_7143, fragment_unnamed_7154.x, fragment_unnamed_7160 * fragment_unnamed_7170.x)));
							}
							else
							{
								float4 fragment_unnamed_7238 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_282 * fragment_uniform_buffer_1[92u].x, fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_283 * fragment_uniform_buffer_1[92u].y, fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_6661 * fragment_uniform_buffer_1[92u].z, fragment_uniform_buffer_1[93u].z)), 0.0f);
								fragment_unnamed_7396 = fragment_unnamed_7238.w;
								fragment_unnamed_7397 = fragment_unnamed_7238.z;
								fragment_unnamed_7398 = fragment_unnamed_7238.y;
								fragment_unnamed_7399 = fragment_unnamed_7238.x;
							}
							float fragment_unnamed_7246 = ((-0.0f) - exp2(fragment_unnamed_7396 * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_7408 = asfloat((fragment_unnamed_7246 >= 5.9604644775390625e-08f) ? asuint((1.0f / fragment_unnamed_7396) * fragment_unnamed_7246) : 1065353216u);
							fragment_unnamed_6674 = asfloat(asuint(fragment_uniform_buffer_1[96u]).w);
							fragment_unnamed_7245 = fragment_unnamed_7246;
							fragment_unnamed_7247 = fragment_unnamed_7397 * fragment_unnamed_7408;
							fragment_unnamed_7249 = fragment_unnamed_7398 * fragment_unnamed_7408;
							fragment_unnamed_7251 = fragment_unnamed_7399 * fragment_unnamed_7408;
						}
						else
						{
							fragment_unnamed_6674 = asfloat(0u);
							fragment_unnamed_7245 = asfloat(0u);
							fragment_unnamed_7247 = asfloat(0u);
							fragment_unnamed_7249 = asfloat(0u);
							fragment_unnamed_7251 = asfloat(0u);
						}
						float fragment_unnamed_7257 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_6030, (-0.0f) - fragment_unnamed_6674);
						float fragment_unnamed_6679;
						float fragment_unnamed_6681;
						float fragment_unnamed_6683;
						float fragment_unnamed_6685;
						if (((~asuint(fragment_unnamed_4985)) & ((0.0f < fragment_unnamed_7257) ? 4294967295u : 0u)) != 0u)
						{
							float fragment_unnamed_7418 = dot(float3(fragment_unnamed_335, fragment_unnamed_336, fragment_unnamed_337), float3(fragment_uniform_buffer_1[83u].xyz));
							float fragment_unnamed_7422 = fragment_unnamed_6674 * ((-0.0f) - fragment_unnamed_7418);
							float fragment_unnamed_7435 = max(abs(fragment_unnamed_7418), 0.001000000047497451305389404296875f);
							float fragment_unnamed_7436 = 1.0f / fragment_unnamed_7435;
							float fragment_unnamed_7439 = min(mad(fragment_unnamed_7257, (-0.0f) - fragment_unnamed_7418, fragment_unnamed_7422), fragment_unnamed_7422);
							float fragment_unnamed_7453 = min(fragment_unnamed_7257, max(fragment_unnamed_7436 * (((-0.0f) - fragment_unnamed_7439) + fragment_uniform_buffer_1[89u].y), 0.0f));
							float fragment_unnamed_7484 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_7435 * ((-0.0f) - (fragment_unnamed_7257 + ((-0.0f) - fragment_unnamed_7453)))) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_7439 + ((-0.0f) - fragment_uniform_buffer_1[89u].y), 0.0f)) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f), fragment_unnamed_7436 * fragment_uniform_buffer_1[90u].y, fragment_unnamed_7453) * fragment_uniform_buffer_1[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_7486 = ((-0.0f) - fragment_unnamed_7245) + 1.0f;
							float fragment_unnamed_8690;
							float fragment_unnamed_8691;
							float fragment_unnamed_8692;
							if (fragment_uniform_buffer_1[86u].x == 1.0f)
							{
								float4 fragment_unnamed_7646 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_868, fragment_unnamed_869, fragment_unnamed_870, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_1[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6030, (-0.0f) - fragment_uniform_buffer_1[87u].x) / (((-0.0f) - fragment_uniform_buffer_1[87u].x) + fragment_uniform_buffer_1[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_8690 = fragment_unnamed_7646.x * fragment_uniform_buffer_1[85u].x;
								fragment_unnamed_8691 = fragment_unnamed_7646.y * fragment_uniform_buffer_1[85u].y;
								fragment_unnamed_8692 = fragment_unnamed_7646.z * fragment_uniform_buffer_1[85u].z;
							}
							else
							{
								uint4 fragment_unnamed_7661 = asuint(fragment_uniform_buffer_1[85u]);
								fragment_unnamed_8690 = asfloat(fragment_unnamed_7661.x);
								fragment_unnamed_8691 = asfloat(fragment_unnamed_7661.y);
								fragment_unnamed_8692 = asfloat(fragment_unnamed_7661.z);
							}
							float fragment_unnamed_8703 = ((-0.0f) - fragment_unnamed_7484) + 1.0f;
							fragment_unnamed_6685 = mad((-0.0f) - fragment_unnamed_7486, fragment_unnamed_7484, 1.0f);
							fragment_unnamed_6679 = mad((fragment_uniform_buffer_1[88u].z / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_3803 * (fragment_unnamed_7486 * fragment_unnamed_8692)), fragment_unnamed_8703, fragment_unnamed_7247);
							fragment_unnamed_6681 = mad((fragment_uniform_buffer_1[88u].y / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_3803 * (fragment_unnamed_7486 * fragment_unnamed_8691)), fragment_unnamed_8703, fragment_unnamed_7249);
							fragment_unnamed_6683 = mad((fragment_uniform_buffer_1[88u].x / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_3803 * (fragment_unnamed_7486 * fragment_unnamed_8690)), fragment_unnamed_8703, fragment_unnamed_7251);
						}
						else
						{
							fragment_unnamed_6685 = fragment_unnamed_7245;
							fragment_unnamed_6679 = fragment_unnamed_7247;
							fragment_unnamed_6681 = fragment_unnamed_7249;
							fragment_unnamed_6683 = fragment_unnamed_7251;
						}
						uint fragment_unnamed_6676 = asuint(fragment_unnamed_6685);
						fragment_unnamed_6673 = fragment_unnamed_6674;
						fragment_unnamed_6675 = fragment_unnamed_6676;
						fragment_unnamed_6677 = fragment_unnamed_6676;
						fragment_unnamed_6678 = fragment_unnamed_6679;
						fragment_unnamed_6680 = fragment_unnamed_6681;
						fragment_unnamed_6682 = fragment_unnamed_6683;
						fragment_unnamed_6684 = fragment_unnamed_6685;
					}
					else
					{
						fragment_unnamed_6673 = asfloat(0u);
						fragment_unnamed_6675 = fragment_unnamed_4979;
						fragment_unnamed_6677 = fragment_unnamed_4981;
						fragment_unnamed_6678 = asfloat(0u);
						fragment_unnamed_6680 = asfloat(0u);
						fragment_unnamed_6682 = asfloat(0u);
						fragment_unnamed_6684 = fragment_unnamed_4987;
					}
					uint fragment_unnamed_7320;
					uint fragment_unnamed_7322;
					float fragment_unnamed_7324;
					float fragment_unnamed_7326;
					float fragment_unnamed_7328;
					float fragment_unnamed_7330;
					if (asuint(fragment_unnamed_4985) != 0u)
					{
						uint fragment_unnamed_7269 = (asuint(fragment_uniform_buffer_1[107u]).x * 28u) + 4u;
						uint4 fragment_unnamed_7281 = uint4(T20.Load(fragment_unnamed_7269).x, T20.Load(fragment_unnamed_7269 + 1u).x, T20.Load(fragment_unnamed_7269 + 2u).x, T20.Load(fragment_unnamed_7269 + 3u).x);
						float fragment_unnamed_7289 = asfloat(fragment_unnamed_7281.w);
						uint fragment_unnamed_7295 = (asuint(fragment_uniform_buffer_1[107u]).x * 28u) + 20u;
						uint3 fragment_unnamed_7304 = uint3(T20.Load(fragment_unnamed_7295).x, T20.Load(fragment_unnamed_7295 + 1u).x, T20.Load(fragment_unnamed_7295 + 2u).x);
						float fragment_unnamed_7306 = asfloat(fragment_unnamed_7304.x);
						float fragment_unnamed_7308 = asfloat(fragment_unnamed_7304.y);
						float fragment_unnamed_7310 = asfloat(fragment_unnamed_7304.z);
						float fragment_unnamed_7311 = fragment_unnamed_7289 * asfloat(fragment_unnamed_7281.x);
						float fragment_unnamed_7312 = fragment_unnamed_7289 * asfloat(fragment_unnamed_7281.y);
						float fragment_unnamed_7313 = fragment_unnamed_7289 * asfloat(fragment_unnamed_7281.z);
						float fragment_unnamed_7318 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_6030, (-0.0f) - fragment_unnamed_6673);
						float fragment_unnamed_7325;
						float fragment_unnamed_7327;
						float fragment_unnamed_7329;
						float fragment_unnamed_7668;
						float fragment_unnamed_7669;
						float fragment_unnamed_7670;
						if (0.0f < fragment_unnamed_7318)
						{
							uint fragment_unnamed_7500 = (asuint(fragment_uniform_buffer_1[107u]).x * 28u) + 16u;
							uint3 fragment_unnamed_7509 = uint3(T20.Load(fragment_unnamed_7500).x, T20.Load(fragment_unnamed_7500 + 1u).x, T20.Load(fragment_unnamed_7500 + 2u).x);
							float fragment_unnamed_7516 = dot(float3(fragment_unnamed_335, fragment_unnamed_336, fragment_unnamed_337), float3(fragment_unnamed_7306, fragment_unnamed_7308, fragment_unnamed_7310));
							float fragment_unnamed_7519 = fragment_unnamed_7318 * fragment_unnamed_7311;
							float fragment_unnamed_7520 = fragment_unnamed_7318 * fragment_unnamed_7312;
							float fragment_unnamed_7521 = fragment_unnamed_7318 * fragment_unnamed_7313;
							float fragment_unnamed_7530 = fragment_unnamed_3803 * (((-0.0f) - asfloat(fragment_unnamed_6677)) + 1.0f);
							float fragment_unnamed_7531 = fragment_unnamed_3803 * (((-0.0f) - asfloat(fragment_unnamed_6675)) + 1.0f);
							float fragment_unnamed_7532 = fragment_unnamed_3803 * (((-0.0f) - fragment_unnamed_6684) + 1.0f);
							bool fragment_unnamed_7534 = ((-0.0f) - fragment_unnamed_7516) != 1.0f;
							float fragment_unnamed_7536 = 1.0f / (fragment_unnamed_7516 + 1.0f);
							float fragment_unnamed_7540 = (-0.0f) - fragment_unnamed_7516;
							fragment_unnamed_7668 = fragment_unnamed_7519;
							fragment_unnamed_7669 = fragment_unnamed_7520;
							fragment_unnamed_7670 = fragment_unnamed_7521;
							fragment_unnamed_7325 = mad(asfloat(fragment_unnamed_7534 ? asuint(fragment_unnamed_7532 * (fragment_unnamed_7536 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7521, fragment_unnamed_7540, fragment_unnamed_7521) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7532)), asfloat(fragment_unnamed_7509.z), fragment_unnamed_6678);
							fragment_unnamed_7327 = mad(asfloat(fragment_unnamed_7534 ? asuint(fragment_unnamed_7531 * (fragment_unnamed_7536 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7520, fragment_unnamed_7540, fragment_unnamed_7520) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7531)), asfloat(fragment_unnamed_7509.y), fragment_unnamed_6680);
							fragment_unnamed_7329 = mad(asfloat(fragment_unnamed_7534 ? asuint(fragment_unnamed_7530 * (fragment_unnamed_7536 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7519, fragment_unnamed_7540, fragment_unnamed_7519) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7530)), asfloat(fragment_unnamed_7509.x), fragment_unnamed_6682);
						}
						else
						{
							fragment_unnamed_7668 = asfloat(0u);
							fragment_unnamed_7669 = asfloat(0u);
							fragment_unnamed_7670 = asfloat(0u);
							fragment_unnamed_7325 = fragment_unnamed_6678;
							fragment_unnamed_7327 = fragment_unnamed_6680;
							fragment_unnamed_7329 = fragment_unnamed_6682;
						}
						float fragment_unnamed_7686 = max(((-0.0f) - dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_unnamed_7306, fragment_unnamed_7308, fragment_unnamed_7310))) + ((-0.0f) - asfloat(T17.Load(0u).x)), 0.0f);
						fragment_unnamed_7320 = asuint(mad((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_6675)) + 1.0f), exp2(mad(fragment_unnamed_7686, fragment_unnamed_7312, fragment_unnamed_7669) * (-1.44269502162933349609375f)), 1.0f));
						fragment_unnamed_7322 = asuint(mad((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_6677)) + 1.0f), exp2(mad(fragment_unnamed_7686, fragment_unnamed_7311, fragment_unnamed_7668) * (-1.44269502162933349609375f)), 1.0f));
						fragment_unnamed_7324 = fragment_unnamed_7325;
						fragment_unnamed_7326 = fragment_unnamed_7327;
						fragment_unnamed_7328 = fragment_unnamed_7329;
						fragment_unnamed_7330 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_6684) + 1.0f), exp2(mad(fragment_unnamed_7686, fragment_unnamed_7313, fragment_unnamed_7670) * (-1.44269502162933349609375f)), 1.0f);
					}
					else
					{
						fragment_unnamed_7320 = fragment_unnamed_6675;
						fragment_unnamed_7322 = fragment_unnamed_6677;
						fragment_unnamed_7324 = fragment_unnamed_6678;
						fragment_unnamed_7326 = fragment_unnamed_6680;
						fragment_unnamed_7328 = fragment_unnamed_6682;
						fragment_unnamed_7330 = fragment_unnamed_6684;
					}
					uint fragment_unnamed_6292;
					uint fragment_unnamed_6294;
					float fragment_unnamed_6296;
					float fragment_unnamed_6298;
					float fragment_unnamed_6300;
					float fragment_unnamed_6302;
					if (asuint(fragment_unnamed_4985) == 0u)
					{
						uint fragment_unnamed_7585;
						uint fragment_unnamed_7586;
						float fragment_unnamed_7587;
						float fragment_unnamed_7588;
						float fragment_unnamed_7589;
						float fragment_unnamed_7590;
						if (asuint(fragment_uniform_buffer_1[84u]).y != 0u)
						{
							float fragment_unnamed_7715 = fragment_uniform_buffer_1[82u].w + fragment_uniform_buffer_1[83u].w;
							float fragment_unnamed_7721 = dot(float3(fragment_uniform_buffer_1[83u].xyz), float3(fragment_unnamed_868, fragment_unnamed_869, fragment_unnamed_870));
							float fragment_unnamed_7724 = 1.0f / fragment_unnamed_7715;
							float fragment_unnamed_7728 = fragment_unnamed_7724 * fragment_uniform_buffer_1[82u].w;
							float fragment_unnamed_7732 = sqrt(max(mad((-0.0f) - fragment_unnamed_7728, fragment_unnamed_7728, 1.0f), 0.0f));
							float fragment_unnamed_7736 = fragment_unnamed_7724 * fragment_uniform_buffer_5[0u].x;
							float fragment_unnamed_7739 = max(mad((-0.0f) - fragment_unnamed_7721, fragment_unnamed_7721, 1.0f), 0.0f);
							float fragment_unnamed_7741 = mad(fragment_unnamed_7736, fragment_unnamed_7736, (-0.0f) - fragment_unnamed_7739);
							float4 fragment_unnamed_7766 = _AtmosphericScatteringLUT.SampleLevel(S0, float3(fragment_unnamed_282, fragment_unnamed_283, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6030, (-0.0f) - max(asfloat((fragment_unnamed_7741 < 0.0f) ? asuint(fragment_unnamed_7741) : asuint(fragment_unnamed_7715 * (((-0.0f) - fragment_unnamed_7721) + ((-0.0f) - sqrt(fragment_unnamed_7741))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
							float fragment_unnamed_7775 = (1.0f / fragment_unnamed_6034) * fragment_uniform_buffer_5[0u].x;
							float fragment_unnamed_7777 = mad(fragment_unnamed_7775, fragment_unnamed_7775, (-0.0f) - fragment_unnamed_7739);
							float fragment_unnamed_7791 = min(max(asfloat((fragment_unnamed_7777 < 0.0f) ? asuint(fragment_unnamed_7777) : asuint(fragment_unnamed_6034 * (((-0.0f) - fragment_unnamed_7721) + ((-0.0f) - sqrt(fragment_unnamed_7777))))), 0.0f) + 128000.0f, fragment_unnamed_6034);
							float fragment_unnamed_7808 = dot(float3((-0.0f) - fragment_uniform_buffer_1[82u].x, (-0.0f) - fragment_uniform_buffer_1[82u].y, (-0.0f) - fragment_uniform_buffer_1[82u].z), float3((-0.0f) - fragment_uniform_buffer_1[82u].x, (-0.0f) - fragment_uniform_buffer_1[82u].y, (-0.0f) - fragment_uniform_buffer_1[82u].z));
							float fragment_unnamed_7811 = rsqrt(fragment_unnamed_7808);
							float fragment_unnamed_7823 = sqrt(fragment_unnamed_7808);
							float fragment_unnamed_7824 = dot(float3(fragment_unnamed_7811 * ((-0.0f) - fragment_uniform_buffer_1[82u].x), fragment_unnamed_7811 * ((-0.0f) - fragment_uniform_buffer_1[82u].y), fragment_unnamed_7811 * ((-0.0f) - fragment_uniform_buffer_1[82u].z)), float3(fragment_unnamed_335, fragment_unnamed_336, fragment_unnamed_337));
							float fragment_unnamed_7835 = mad(fragment_unnamed_7791, fragment_unnamed_868, (-0.0f) - fragment_uniform_buffer_1[82u].x);
							float fragment_unnamed_7836 = mad(fragment_unnamed_7791, fragment_unnamed_869, (-0.0f) - fragment_uniform_buffer_1[82u].y);
							float fragment_unnamed_7837 = mad(fragment_unnamed_7791, fragment_unnamed_870, (-0.0f) - fragment_uniform_buffer_1[82u].z);
							float fragment_unnamed_7841 = sqrt(dot(float3(fragment_unnamed_7835, fragment_unnamed_7836, fragment_unnamed_7837), float3(fragment_unnamed_7835, fragment_unnamed_7836, fragment_unnamed_7837)));
							float fragment_unnamed_7846 = dot(float3(fragment_unnamed_7835, fragment_unnamed_7836, fragment_unnamed_7837), float3(fragment_unnamed_868, fragment_unnamed_869, fragment_unnamed_870)) * (1.0f / fragment_unnamed_7841);
							float fragment_unnamed_7849 = (fragment_unnamed_7846 >= 0.0f) ? ((-0.0f) - fragment_unnamed_7824) : fragment_unnamed_7824;
							float fragment_unnamed_7854 = fragment_unnamed_7823 * fragment_uniform_buffer_5[1u].x;
							float fragment_unnamed_7855 = fragment_unnamed_7823 * fragment_uniform_buffer_5[1u].z;
							float fragment_unnamed_7859 = sqrt(max(mad((-0.0f) - fragment_unnamed_7849, fragment_unnamed_7849, 1.0f), 0.0f));
							float fragment_unnamed_7864 = abs(fragment_unnamed_7849) * abs(fragment_unnamed_7849);
							float fragment_unnamed_7867 = (-0.0f) - fragment_unnamed_7864;
							float fragment_unnamed_7881 = abs(fragment_unnamed_7849);
							float fragment_unnamed_7888 = abs(fragment_unnamed_7849);
							float fragment_unnamed_7906 = exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].x, (-0.0f) - fragment_unnamed_7854) * 1.44269502162933349609375f) * mad(fragment_unnamed_7888, 0.5f, (1.0f / mad(fragment_unnamed_7881, fragment_unnamed_7854, sqrt(fragment_unnamed_7854 * mad(fragment_unnamed_7854 * fragment_unnamed_7864, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_7867, fragment_unnamed_7854, mad(fragment_unnamed_7854, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							float fragment_unnamed_7907 = exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].z, (-0.0f) - fragment_unnamed_7855) * 1.44269502162933349609375f) * mad(fragment_unnamed_7888, 0.5f, (1.0f / mad(fragment_unnamed_7881, fragment_unnamed_7855, sqrt(fragment_unnamed_7855 * mad(fragment_unnamed_7855 * fragment_unnamed_7864, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_7867, fragment_unnamed_7855, mad(fragment_unnamed_7855, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							bool fragment_unnamed_7908 = fragment_unnamed_7849 < 0.0f;
							float fragment_unnamed_7909 = fragment_unnamed_7859 * fragment_unnamed_7854;
							float fragment_unnamed_7910 = fragment_unnamed_7859 * fragment_unnamed_7855;
							float fragment_unnamed_7911 = rsqrt(fragment_unnamed_7909);
							float fragment_unnamed_7912 = rsqrt(fragment_unnamed_7910);
							float fragment_unnamed_7955 = fragment_unnamed_7841 * fragment_uniform_buffer_5[1u].x;
							float fragment_unnamed_7956 = fragment_unnamed_7841 * fragment_uniform_buffer_5[1u].z;
							float fragment_unnamed_7961 = abs(fragment_unnamed_7846) * abs(fragment_unnamed_7846);
							float fragment_unnamed_7964 = (-0.0f) - fragment_unnamed_7961;
							float fragment_unnamed_7975 = abs(fragment_unnamed_7846);
							float fragment_unnamed_7982 = abs(fragment_unnamed_7846);
							float fragment_unnamed_8010 = abs(mad((-0.0f) - mad(fragment_unnamed_7982, 0.5f, (mad(fragment_unnamed_7964, fragment_unnamed_7955, mad(fragment_unnamed_7955, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_7975, fragment_unnamed_7955, sqrt(fragment_unnamed_7955 * mad(fragment_unnamed_7955 * fragment_unnamed_7961, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].x, (-0.0f) - fragment_unnamed_7955) * 1.44269502162933349609375f), asfloat(fragment_unnamed_7908 ? asuint(mad((dot(fragment_unnamed_7909.xx, fragment_unnamed_7911.xx) + fragment_unnamed_7911) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].x, (-0.0f) - fragment_unnamed_7909) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_7906)) : asuint(fragment_unnamed_7906)))) * fragment_uniform_buffer_5[1u].y;
							float fragment_unnamed_8012 = 1.0f / fragment_unnamed_7823;
							float fragment_unnamed_8017 = fragment_unnamed_8012 * fragment_uniform_buffer_5[2u].z;
							float fragment_unnamed_8018 = fragment_unnamed_8012 * fragment_uniform_buffer_5[2u].w;
							float fragment_unnamed_8022 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_7824, fragment_unnamed_7824, 1.0f), 0.0f);
							float fragment_unnamed_8023 = mad(fragment_unnamed_8017, fragment_unnamed_8017, fragment_unnamed_8022);
							float fragment_unnamed_8024 = mad(fragment_unnamed_8018, fragment_unnamed_8018, fragment_unnamed_8022);
							bool fragment_unnamed_8025 = fragment_unnamed_8023 < 0.0f;
							bool fragment_unnamed_8026 = fragment_unnamed_8024 < 0.0f;
							float fragment_unnamed_8027 = sqrt(fragment_unnamed_8023);
							float fragment_unnamed_8028 = sqrt(fragment_unnamed_8024);
							uint fragment_unnamed_8039 = asuint(fragment_unnamed_8023);
							uint fragment_unnamed_8042 = fragment_unnamed_8025 ? fragment_unnamed_8039 : asuint(fragment_unnamed_7823 * (fragment_unnamed_7824 + ((-0.0f) - fragment_unnamed_8027)));
							float fragment_unnamed_8043 = asfloat(fragment_unnamed_8042);
							uint fragment_unnamed_8044 = fragment_unnamed_8025 ? fragment_unnamed_8039 : asuint(fragment_unnamed_7823 * (fragment_unnamed_7824 + fragment_unnamed_8027));
							float fragment_unnamed_8045 = asfloat(fragment_unnamed_8044);
							uint fragment_unnamed_8046 = asuint(fragment_unnamed_8024);
							uint fragment_unnamed_8051 = fragment_unnamed_8026 ? fragment_unnamed_8046 : asuint(fragment_unnamed_7823 * (fragment_unnamed_7824 + fragment_unnamed_8028));
							bool fragment_unnamed_8056 = fragment_unnamed_8043 >= 0.0f;
							float fragment_unnamed_8061 = ((-0.0f) - fragment_unnamed_8045) + asfloat(fragment_unnamed_8051);
							float fragment_unnamed_8064 = max(asfloat(fragment_unnamed_8026 ? fragment_unnamed_8046 : asuint(fragment_unnamed_7823 * (fragment_unnamed_7824 + ((-0.0f) - fragment_unnamed_8028)))), 0.0f);
							uint fragment_unnamed_8065 = fragment_unnamed_8056 ? fragment_unnamed_8042 : fragment_unnamed_8051;
							float fragment_unnamed_8071 = ((-0.0f) - fragment_unnamed_8064) + asfloat(fragment_unnamed_8065);
							bool fragment_unnamed_8074 = (((fragment_unnamed_8045 < fragment_unnamed_7791) ? 4294967295u : 0u) & (fragment_unnamed_8056 ? 4294967295u : 0u)) != 0u;
							bool fragment_unnamed_8080 = (((fragment_unnamed_8043 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_8045 >= 0.0f) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_8085 = asfloat(fragment_unnamed_8080 ? fragment_unnamed_8044 : asuint(fragment_unnamed_8064));
							float fragment_unnamed_8087 = asfloat(fragment_unnamed_8080 ? asuint(fragment_unnamed_8061 * 0.5f) : (fragment_unnamed_8074 ? fragment_unnamed_8044 : asuint(fragment_unnamed_8071 * 0.5f)));
							float fragment_unnamed_8089 = asfloat(fragment_unnamed_8080 ? asuint(fragment_unnamed_8061 * 0.5f) : (fragment_unnamed_8074 ? fragment_unnamed_8065 : asuint(fragment_unnamed_8071 * 0.5f)));
							float fragment_unnamed_8091 = asfloat(fragment_unnamed_8080 ? fragment_unnamed_8051 : (fragment_unnamed_8074 ? fragment_unnamed_8051 : fragment_unnamed_8065));
							float fragment_unnamed_8096 = (-0.0f) - fragment_unnamed_8085;
							float fragment_unnamed_8097 = (-0.0f) - fragment_unnamed_8087;
							float fragment_unnamed_8100 = fragment_unnamed_8096 + min(fragment_unnamed_7791, fragment_unnamed_8089);
							float fragment_unnamed_8101 = fragment_unnamed_8097 + min(fragment_unnamed_7791, fragment_unnamed_8091);
							float fragment_unnamed_8110 = mad(fragment_unnamed_8096 + min(fragment_unnamed_7791, fragment_unnamed_8089), 0.25f, fragment_unnamed_8085);
							float fragment_unnamed_8111 = mad(fragment_unnamed_8097 + min(fragment_unnamed_7791, fragment_unnamed_8091), 0.25f, fragment_unnamed_8087);
							float fragment_unnamed_8112 = mad(fragment_unnamed_8100, 0.75f, fragment_unnamed_8085);
							float fragment_unnamed_8114 = mad(fragment_unnamed_8101, 0.75f, fragment_unnamed_8087);
							float fragment_unnamed_8116 = dot(((-0.0f) - fragment_unnamed_7824).xx, fragment_unnamed_7823.xx);
							float fragment_unnamed_8134 = (-0.0f) - fragment_uniform_buffer_1[82u].w;
							float fragment_unnamed_8170 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8114, fragment_unnamed_8114 + fragment_unnamed_8116, fragment_unnamed_7808)) + fragment_unnamed_8134, fragment_uniform_buffer_5[2u].x, fragment_uniform_buffer_5[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_8101, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8112, fragment_unnamed_8112 + fragment_unnamed_8116, fragment_unnamed_7808)) + fragment_unnamed_8134, fragment_uniform_buffer_5[2u].x, fragment_uniform_buffer_5[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_8100, 0.0f) * 0.5f, ((max(fragment_unnamed_8101, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8111, fragment_unnamed_8111 + fragment_unnamed_8116, fragment_unnamed_7808)) + fragment_unnamed_8134, fragment_uniform_buffer_5[2u].x, fragment_uniform_buffer_5[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_8100, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8110, fragment_unnamed_8110 + fragment_unnamed_8116, fragment_unnamed_7808)) + fragment_unnamed_8134, fragment_uniform_buffer_5[2u].x, fragment_uniform_buffer_5[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
							float fragment_unnamed_8175 = (abs(mad((-0.0f) - mad(fragment_unnamed_7982, 0.5f, (mad(fragment_unnamed_7964, fragment_unnamed_7956, mad(fragment_unnamed_7956, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_7975, fragment_unnamed_7956, sqrt(fragment_unnamed_7956 * mad(fragment_unnamed_7956 * fragment_unnamed_7961, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].z, (-0.0f) - fragment_unnamed_7956) * 1.44269502162933349609375f), asfloat(fragment_unnamed_7908 ? asuint(mad((dot(fragment_unnamed_7910.xx, fragment_unnamed_7912.xx) + fragment_unnamed_7912) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].z, (-0.0f) - fragment_unnamed_7910) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_7907)) : asuint(fragment_unnamed_7907)))) * fragment_uniform_buffer_5[1u].w) * fragment_uniform_buffer_5[0u].w;
							float fragment_unnamed_8201 = ((-0.0f) - exp2(mad(fragment_unnamed_8170, fragment_uniform_buffer_5[6u].x, mad(fragment_unnamed_8010, fragment_uniform_buffer_5[3u].x, fragment_unnamed_8175)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8202 = ((-0.0f) - exp2(mad(fragment_unnamed_8170, fragment_uniform_buffer_5[6u].y, mad(fragment_unnamed_8010, fragment_uniform_buffer_5[3u].y, fragment_unnamed_8175)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8203 = ((-0.0f) - exp2(mad(fragment_unnamed_8170, fragment_uniform_buffer_5[6u].z, mad(fragment_unnamed_8010, fragment_uniform_buffer_5[3u].z, fragment_unnamed_8175)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8205 = fragment_unnamed_8203 + (fragment_unnamed_8202 + fragment_unnamed_8201);
							float fragment_unnamed_8206 = fragment_unnamed_8205 * 0.3333333432674407958984375f;
							float fragment_unnamed_8208 = (-0.0f) - fragment_unnamed_8205;
							float fragment_unnamed_8226 = sqrt(((-0.0f) - fragment_unnamed_7732) + 1.0f);
							float fragment_unnamed_8232 = mad(mad(mad(fragment_unnamed_7732, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_7732, -0.212114393711090087890625f), fragment_unnamed_7732, 1.570728778839111328125f);
							float fragment_unnamed_8243 = mad(fragment_unnamed_8232, fragment_unnamed_8226, asfloat(asuint(mad(fragment_unnamed_8226 * fragment_unnamed_8232, -2.0f, 3.1415927410125732421875f)) & ((((-0.0f) - fragment_unnamed_7732) < fragment_unnamed_7732) ? 4294967295u : 0u)));
							float fragment_unnamed_8247 = sqrt(((-0.0f) - abs(fragment_unnamed_7721)) + 1.0f);
							float fragment_unnamed_8253 = mad(mad(mad(abs(fragment_unnamed_7721), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_7721), -0.212114393711090087890625f), abs(fragment_unnamed_7721), 1.570728778839111328125f);
							float fragment_unnamed_8264 = 1.0f / ((-0.0f) - fragment_unnamed_8243);
							float fragment_unnamed_8282 = mad(exp2((clamp(mad(mad(fragment_unnamed_8253, fragment_unnamed_8247, asfloat(((fragment_unnamed_7721 < ((-0.0f) - fragment_unnamed_7721)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_8247 * fragment_unnamed_8253, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_8264, (-0.0f) - (fragment_unnamed_8243 * fragment_unnamed_8264)), 0.0f, 1.0f) * fragment_uniform_buffer_5[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_5[11u].y, (-0.0f) - fragment_uniform_buffer_5[11u].y);
							float fragment_unnamed_8315 = ((-0.0f) - asfloat(fragment_unnamed_7322)) + 1.0f;
							float fragment_unnamed_8316 = ((-0.0f) - asfloat(fragment_unnamed_7320)) + 1.0f;
							float fragment_unnamed_8317 = ((-0.0f) - fragment_unnamed_7330) + 1.0f;
							fragment_unnamed_7585 = asuint(mad(fragment_unnamed_8316, mad(mad(fragment_unnamed_8208, 0.3333333432674407958984375f, fragment_unnamed_8202), fragment_uniform_buffer_5[10u].z, fragment_unnamed_8206) * fragment_uniform_buffer_5[10u].w, asfloat(fragment_unnamed_7320)));
							fragment_unnamed_7586 = asuint(mad(fragment_unnamed_8315, mad(mad(fragment_unnamed_8208, 0.3333333432674407958984375f, fragment_unnamed_8201), fragment_uniform_buffer_5[10u].z, fragment_unnamed_8206) * fragment_uniform_buffer_5[10u].w, asfloat(fragment_unnamed_7322)));
							fragment_unnamed_7587 = mad(fragment_unnamed_8317, mad(fragment_unnamed_8282, ((-0.0f) - fragment_uniform_buffer_5[8u].z) + fragment_uniform_buffer_5[9u].z, fragment_uniform_buffer_5[8u].z) * fragment_unnamed_7766.z, fragment_unnamed_7324);
							fragment_unnamed_7588 = mad(fragment_unnamed_8316, mad(fragment_unnamed_8282, ((-0.0f) - fragment_uniform_buffer_5[8u].y) + fragment_uniform_buffer_5[9u].y, fragment_uniform_buffer_5[8u].y) * fragment_unnamed_7766.y, fragment_unnamed_7326);
							fragment_unnamed_7589 = mad(fragment_unnamed_8315, mad(fragment_unnamed_8282, ((-0.0f) - fragment_uniform_buffer_5[8u].x) + fragment_uniform_buffer_5[9u].x, fragment_uniform_buffer_5[8u].x) * fragment_unnamed_7766.x, fragment_unnamed_7328);
							fragment_unnamed_7590 = mad(fragment_unnamed_8317, mad(mad(fragment_unnamed_8208, 0.3333333432674407958984375f, fragment_unnamed_8203), fragment_uniform_buffer_5[10u].z, fragment_unnamed_8206) * fragment_uniform_buffer_5[10u].w, fragment_unnamed_7330);
						}
						else
						{
							fragment_unnamed_7585 = fragment_unnamed_7320;
							fragment_unnamed_7586 = fragment_unnamed_7322;
							fragment_unnamed_7587 = fragment_unnamed_7324;
							fragment_unnamed_7588 = fragment_unnamed_7326;
							fragment_unnamed_7589 = fragment_unnamed_7328;
							fragment_unnamed_7590 = fragment_unnamed_7330;
						}
						fragment_unnamed_6292 = fragment_unnamed_7585;
						fragment_unnamed_6294 = fragment_unnamed_7586;
						fragment_unnamed_6296 = fragment_unnamed_7587;
						fragment_unnamed_6298 = fragment_unnamed_7588;
						fragment_unnamed_6300 = fragment_unnamed_7589;
						fragment_unnamed_6302 = fragment_unnamed_7590;
					}
					else
					{
						fragment_unnamed_6292 = fragment_unnamed_7320;
						fragment_unnamed_6294 = fragment_unnamed_7322;
						fragment_unnamed_6296 = fragment_unnamed_7324;
						fragment_unnamed_6298 = fragment_unnamed_7326;
						fragment_unnamed_6300 = fragment_unnamed_7328;
						fragment_unnamed_6302 = fragment_unnamed_7330;
					}
					fragment_unnamed_6291 = fragment_unnamed_6292;
					fragment_unnamed_6293 = fragment_unnamed_6294;
					fragment_unnamed_6295 = fragment_unnamed_6296;
					fragment_unnamed_6297 = fragment_unnamed_6298;
					fragment_unnamed_6299 = fragment_unnamed_6300;
					fragment_unnamed_6301 = fragment_unnamed_6302;
				}
				else
				{
					fragment_unnamed_6291 = fragment_unnamed_4979;
					fragment_unnamed_6293 = fragment_unnamed_4981;
					fragment_unnamed_6295 = asfloat(0u);
					fragment_unnamed_6297 = asfloat(0u);
					fragment_unnamed_6299 = asfloat(0u);
					fragment_unnamed_6301 = fragment_unnamed_4987;
				}
				float fragment_unnamed_6311 = asfloat(fragment_unnamed_3842) * (((-0.0f) - asfloat(fragment_unnamed_6293)) + 1.0f);
				float fragment_unnamed_6312 = asfloat(fragment_unnamed_3844) * (((-0.0f) - asfloat(fragment_unnamed_6291)) + 1.0f);
				float fragment_unnamed_6313 = asfloat(fragment_unnamed_3846) * (((-0.0f) - fragment_unnamed_6301) + 1.0f);
				float fragment_unnamed_6314 = mad(fragment_unnamed_6299, fragment_unnamed_422, fragment_unnamed_6311);
				float fragment_unnamed_6315 = mad(fragment_unnamed_6297, fragment_unnamed_422, fragment_unnamed_6312);
				float fragment_unnamed_6316 = mad(fragment_unnamed_6295, fragment_unnamed_422, fragment_unnamed_6313);
				fragment_output_0.x = fragment_unnamed_3813 ? fragment_unnamed_6314 : asfloat(fragment_unnamed_3814 ? asuint(fragment_unnamed_6311) : (fragment_unnamed_3815 ? asuint(fragment_unnamed_6314) : fragment_unnamed_3842));
				fragment_output_0.y = fragment_unnamed_3813 ? fragment_unnamed_6315 : asfloat(fragment_unnamed_3814 ? asuint(fragment_unnamed_6312) : (fragment_unnamed_3815 ? asuint(fragment_unnamed_6315) : fragment_unnamed_3844));
				fragment_output_0.z = fragment_unnamed_3813 ? fragment_unnamed_6316 : asfloat(fragment_unnamed_3814 ? asuint(fragment_unnamed_6313) : (fragment_unnamed_3815 ? asuint(fragment_unnamed_6316) : fragment_unnamed_3846));
				fragment_output_0.w = fragment_unnamed_422;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_GlobalFogDistance[0], _GlobalFogDistance[1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				fragment_uniform_buffer_1[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				fragment_uniform_buffer_1[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				fragment_uniform_buffer_1[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				fragment_uniform_buffer_1[8] = float4(_InvViewMatrix[0][0], _InvViewMatrix[1][0], _InvViewMatrix[2][0], _InvViewMatrix[3][0]);
				fragment_uniform_buffer_1[9] = float4(_InvViewMatrix[0][1], _InvViewMatrix[1][1], _InvViewMatrix[2][1], _InvViewMatrix[3][1]);
				fragment_uniform_buffer_1[10] = float4(_InvViewMatrix[0][2], _InvViewMatrix[1][2], _InvViewMatrix[2][2], _InvViewMatrix[3][2]);
				fragment_uniform_buffer_1[11] = float4(_InvViewMatrix[0][3], _InvViewMatrix[1][3], _InvViewMatrix[2][3], _InvViewMatrix[3][3]);

				fragment_uniform_buffer_1[12] = float4(_ProjMatrix[0][0], _ProjMatrix[1][0], _ProjMatrix[2][0], _ProjMatrix[3][0]);
				fragment_uniform_buffer_1[13] = float4(_ProjMatrix[0][1], _ProjMatrix[1][1], _ProjMatrix[2][1], _ProjMatrix[3][1]);
				fragment_uniform_buffer_1[14] = float4(_ProjMatrix[0][2], _ProjMatrix[1][2], _ProjMatrix[2][2], _ProjMatrix[3][2]);
				fragment_uniform_buffer_1[15] = float4(_ProjMatrix[0][3], _ProjMatrix[1][3], _ProjMatrix[2][3], _ProjMatrix[3][3]);

				fragment_uniform_buffer_1[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				fragment_uniform_buffer_1[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				fragment_uniform_buffer_1[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				fragment_uniform_buffer_1[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				fragment_uniform_buffer_1[28] = float4(_InvViewProjMatrix[0][0], _InvViewProjMatrix[1][0], _InvViewProjMatrix[2][0], _InvViewProjMatrix[3][0]);
				fragment_uniform_buffer_1[29] = float4(_InvViewProjMatrix[0][1], _InvViewProjMatrix[1][1], _InvViewProjMatrix[2][1], _InvViewProjMatrix[3][1]);
				fragment_uniform_buffer_1[30] = float4(_InvViewProjMatrix[0][2], _InvViewProjMatrix[1][2], _InvViewProjMatrix[2][2], _InvViewProjMatrix[3][2]);
				fragment_uniform_buffer_1[31] = float4(_InvViewProjMatrix[0][3], _InvViewProjMatrix[1][3], _InvViewProjMatrix[2][3], _InvViewProjMatrix[3][3]);

				fragment_uniform_buffer_1[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				fragment_uniform_buffer_1[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[74] = float4(_TaaFrameInfo[0], _TaaFrameInfo[1], _TaaFrameInfo[2], _TaaFrameInfo[3]);

				fragment_uniform_buffer_1[82] = float4(_PlanetCenterRadius[0], _PlanetCenterRadius[1], _PlanetCenterRadius[2], _PlanetCenterRadius[3]);

				fragment_uniform_buffer_1[83] = float4(_PlanetUpAltitude[0], _PlanetUpAltitude[1], _PlanetUpAltitude[2], _PlanetUpAltitude[3]);

				fragment_uniform_buffer_1[84] = float4(asfloat(_FogEnabled), fragment_uniform_buffer_1[84][1], fragment_uniform_buffer_1[84][2], fragment_uniform_buffer_1[84][3]);

				fragment_uniform_buffer_1[84] = float4(fragment_uniform_buffer_1[84][0], asfloat(_PBRFogEnabled), fragment_uniform_buffer_1[84][2], fragment_uniform_buffer_1[84][3]);

				fragment_uniform_buffer_1[84] = float4(fragment_uniform_buffer_1[84][0], fragment_uniform_buffer_1[84][1], asfloat(_EnableVolumetricFog), fragment_uniform_buffer_1[84][3]);

				fragment_uniform_buffer_1[84] = float4(fragment_uniform_buffer_1[84][0], fragment_uniform_buffer_1[84][1], fragment_uniform_buffer_1[84][2], _MaxFogDistance);

				fragment_uniform_buffer_1[85] = float4(_FogColor[0], _FogColor[1], _FogColor[2], _FogColor[3]);

				fragment_uniform_buffer_1[86] = float4(_FogColorMode, fragment_uniform_buffer_1[86][1], fragment_uniform_buffer_1[86][2], fragment_uniform_buffer_1[86][3]);

				fragment_uniform_buffer_1[86] = float4(fragment_uniform_buffer_1[86][0], _GlobalMipBias, fragment_uniform_buffer_1[86][2], fragment_uniform_buffer_1[86][3]);

				fragment_uniform_buffer_1[87] = float4(_MipFogParameters[0], _MipFogParameters[1], _MipFogParameters[2], _MipFogParameters[3]);

				fragment_uniform_buffer_1[88] = float4(_HeightFogBaseScattering[0], _HeightFogBaseScattering[1], _HeightFogBaseScattering[2], _HeightFogBaseScattering[3]);

				fragment_uniform_buffer_1[89] = float4(_HeightFogBaseExtinction, fragment_uniform_buffer_1[89][1], fragment_uniform_buffer_1[89][2], fragment_uniform_buffer_1[89][3]);

				fragment_uniform_buffer_1[89] = float4(fragment_uniform_buffer_1[89][0], _HeightFogBaseHeight, fragment_uniform_buffer_1[89][2], fragment_uniform_buffer_1[89][3]);

				fragment_uniform_buffer_1[89] = float4(fragment_uniform_buffer_1[89][0], fragment_uniform_buffer_1[89][1], fragment_uniform_buffer_1[89][2], asfloat(_VolumetricFilteringEnabled));

				fragment_uniform_buffer_1[90] = float4(_HeightFogExponents[0], _HeightFogExponents[1], fragment_uniform_buffer_1[90][2], fragment_uniform_buffer_1[90][3]);

				fragment_uniform_buffer_1[91] = float4(_VBufferViewportSize[0], _VBufferViewportSize[1], _VBufferViewportSize[2], _VBufferViewportSize[3]);

				fragment_uniform_buffer_1[92] = float4(_VBufferLightingViewportScale[0], _VBufferLightingViewportScale[1], _VBufferLightingViewportScale[2], _VBufferLightingViewportScale[3]);

				fragment_uniform_buffer_1[93] = float4(_VBufferLightingViewportLimit[0], _VBufferLightingViewportLimit[1], _VBufferLightingViewportLimit[2], _VBufferLightingViewportLimit[3]);

				fragment_uniform_buffer_1[94] = float4(_VBufferDistanceEncodingParams[0], _VBufferDistanceEncodingParams[1], _VBufferDistanceEncodingParams[2], _VBufferDistanceEncodingParams[3]);

				fragment_uniform_buffer_1[96] = float4(fragment_uniform_buffer_1[96][0], _VBufferRcpSliceCount, fragment_uniform_buffer_1[96][2], fragment_uniform_buffer_1[96][3]);

				fragment_uniform_buffer_1[96] = float4(fragment_uniform_buffer_1[96][0], fragment_uniform_buffer_1[96][1], fragment_uniform_buffer_1[96][2], _VBufferLastSliceDist);

				fragment_uniform_buffer_1[97] = float4(_ShadowAtlasSize[0], _ShadowAtlasSize[1], _ShadowAtlasSize[2], _ShadowAtlasSize[3]);

				fragment_uniform_buffer_1[98] = float4(_CascadeShadowAtlasSize[0], _CascadeShadowAtlasSize[1], _CascadeShadowAtlasSize[2], _CascadeShadowAtlasSize[3]);

				fragment_uniform_buffer_1[99] = float4(_AreaShadowAtlasSize[0], _AreaShadowAtlasSize[1], _AreaShadowAtlasSize[2], _AreaShadowAtlasSize[3]);

				fragment_uniform_buffer_1[100] = float4(_CachedShadowAtlasSize[0], _CachedShadowAtlasSize[1], _CachedShadowAtlasSize[2], _CachedShadowAtlasSize[3]);

				fragment_uniform_buffer_1[101] = float4(_CachedAreaShadowAtlasSize[0], _CachedAreaShadowAtlasSize[1], _CachedAreaShadowAtlasSize[2], _CachedAreaShadowAtlasSize[3]);

				fragment_uniform_buffer_1[102] = float4(_BoundsSS[0], _BoundsSS[1], _BoundsSS[2], _BoundsSS[3]);

				fragment_uniform_buffer_1[103] = float4(_UpDirectionX, fragment_uniform_buffer_1[103][1], fragment_uniform_buffer_1[103][2], fragment_uniform_buffer_1[103][3]);

				fragment_uniform_buffer_1[103] = float4(fragment_uniform_buffer_1[103][0], _UpDirectionY, fragment_uniform_buffer_1[103][2], fragment_uniform_buffer_1[103][3]);

				fragment_uniform_buffer_1[107] = float4(asfloat(_UnderWaterSurfaceIndex), fragment_uniform_buffer_1[107][1], fragment_uniform_buffer_1[107][2], fragment_uniform_buffer_1[107][3]);

				fragment_uniform_buffer_1[113] = float4(asfloat(_PreRefractionPass), fragment_uniform_buffer_1[113][1], fragment_uniform_buffer_1[113][2], fragment_uniform_buffer_1[113][3]);

				fragment_uniform_buffer_1[113] = float4(fragment_uniform_buffer_1[113][0], asfloat(_SpecularFade), fragment_uniform_buffer_1[113][2], fragment_uniform_buffer_1[113][3]);

				fragment_uniform_buffer_1[114] = float4(asfloat(_DirectionalLightCount), fragment_uniform_buffer_1[114][1], fragment_uniform_buffer_1[114][2], fragment_uniform_buffer_1[114][3]);

				fragment_uniform_buffer_1[116] = float4(asfloat(_EnvLightSkyEnabled), fragment_uniform_buffer_1[116][1], fragment_uniform_buffer_1[116][2], fragment_uniform_buffer_1[116][3]);

				fragment_uniform_buffer_1[116] = float4(fragment_uniform_buffer_1[116][0], asfloat(_CascadeShadowCount), fragment_uniform_buffer_1[116][2], fragment_uniform_buffer_1[116][3]);

				fragment_uniform_buffer_1[116] = float4(fragment_uniform_buffer_1[116][0], fragment_uniform_buffer_1[116][1], asfloat(_DirectionalShadowIndex), fragment_uniform_buffer_1[116][3]);

				fragment_uniform_buffer_1[117] = float4(asfloat(_EnableSkyReflection), fragment_uniform_buffer_1[117][1], fragment_uniform_buffer_1[117][2], fragment_uniform_buffer_1[117][3]);

				fragment_uniform_buffer_1[118] = float4(fragment_uniform_buffer_1[118][0], _ProbeExposureScale, fragment_uniform_buffer_1[118][2], fragment_uniform_buffer_1[118][3]);

				fragment_uniform_buffer_1[118] = float4(fragment_uniform_buffer_1[118][0], fragment_uniform_buffer_1[118][1], fragment_uniform_buffer_1[118][2], _ReplaceDiffuseForIndirect);

				fragment_uniform_buffer_1[120] = float4(_IndirectDiffuseLightingMultiplier, fragment_uniform_buffer_1[120][1], fragment_uniform_buffer_1[120][2], fragment_uniform_buffer_1[120][3]);

				fragment_uniform_buffer_1[120] = float4(fragment_uniform_buffer_1[120][0], asfloat(_IndirectDiffuseLightingLayers), fragment_uniform_buffer_1[120][2], fragment_uniform_buffer_1[120][3]);

				fragment_uniform_buffer_1[120] = float4(fragment_uniform_buffer_1[120][0], fragment_uniform_buffer_1[120][1], _ReflectionLightingMultiplier, fragment_uniform_buffer_1[120][3]);

				fragment_uniform_buffer_1[120] = float4(fragment_uniform_buffer_1[120][0], fragment_uniform_buffer_1[120][1], fragment_uniform_buffer_1[120][2], asfloat(_ReflectionLightingLayers));

				fragment_uniform_buffer_1[121] = float4(_MicroShadowOpacity, fragment_uniform_buffer_1[121][1], fragment_uniform_buffer_1[121][2], fragment_uniform_buffer_1[121][3]);

				fragment_uniform_buffer_1[122] = float4(_CookieAtlasSize[0], _CookieAtlasSize[1], _CookieAtlasSize[2], _CookieAtlasSize[3]);

				fragment_uniform_buffer_1[123] = float4(_CookieAtlasData[0], _CookieAtlasData[1], _CookieAtlasData[2], _CookieAtlasData[3]);

				fragment_uniform_buffer_1[124] = float4(_ReflectionAtlasCubeData[0], _ReflectionAtlasCubeData[1], _ReflectionAtlasCubeData[2], _ReflectionAtlasCubeData[3]);

				fragment_uniform_buffer_1[125] = float4(_ReflectionAtlasPlanarData[0], _ReflectionAtlasPlanarData[1], _ReflectionAtlasPlanarData[2], _ReflectionAtlasPlanarData[3]);

				fragment_uniform_buffer_1[126] = float4(fragment_uniform_buffer_1[126][0], fragment_uniform_buffer_1[126][1], fragment_uniform_buffer_1[126][2], g_fClustBase);

				fragment_uniform_buffer_1[127] = float4(g_fNearPlane, fragment_uniform_buffer_1[127][1], fragment_uniform_buffer_1[127][2], fragment_uniform_buffer_1[127][3]);

				fragment_uniform_buffer_1[127] = float4(fragment_uniform_buffer_1[127][0], g_fFarPlane, fragment_uniform_buffer_1[127][2], fragment_uniform_buffer_1[127][3]);

				fragment_uniform_buffer_1[127] = float4(fragment_uniform_buffer_1[127][0], fragment_uniform_buffer_1[127][1], asfloat(g_iLog2NumClusters), fragment_uniform_buffer_1[127][3]);

				fragment_uniform_buffer_1[127] = float4(fragment_uniform_buffer_1[127][0], fragment_uniform_buffer_1[127][1], fragment_uniform_buffer_1[127][2], asfloat(g_isLogBaseBufferEnabled));

				fragment_uniform_buffer_1[128] = float4(asfloat(_NumTileClusteredX), fragment_uniform_buffer_1[128][1], fragment_uniform_buffer_1[128][2], fragment_uniform_buffer_1[128][3]);

				fragment_uniform_buffer_1[128] = float4(fragment_uniform_buffer_1[128][0], asfloat(_NumTileClusteredY), fragment_uniform_buffer_1[128][2], fragment_uniform_buffer_1[128][3]);

				fragment_uniform_buffer_1[211] = float4(_OffScreenDownsampleFactor, fragment_uniform_buffer_1[211][1], fragment_uniform_buffer_1[211][2], fragment_uniform_buffer_1[211][3]);

				fragment_uniform_buffer_1[211] = float4(fragment_uniform_buffer_1[211][0], asfloat(_OffScreenRendering), fragment_uniform_buffer_1[211][2], fragment_uniform_buffer_1[211][3]);

				fragment_uniform_buffer_1[217] = float4(_VolumetricCloudsShadowScale[0], _VolumetricCloudsShadowScale[1], fragment_uniform_buffer_1[217][2], fragment_uniform_buffer_1[217][3]);

				fragment_uniform_buffer_1[217] = float4(fragment_uniform_buffer_1[217][0], fragment_uniform_buffer_1[217][1], fragment_uniform_buffer_1[217][2], _VolumetricCloudsFallBackValue);

				fragment_uniform_buffer_1[218] = float4(_VolumetricCloudsShadowOriginToggle[0], _VolumetricCloudsShadowOriginToggle[1], _VolumetricCloudsShadowOriginToggle[2], _VolumetricCloudsShadowOriginToggle[3]);

				fragment_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[13] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[14] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[15] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[16] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				fragment_uniform_buffer_2[17] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				fragment_uniform_buffer_2[18] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				fragment_uniform_buffer_2[19] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				fragment_uniform_buffer_2[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_2[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_2[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_2[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_2[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_2[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_2[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_3[0] = float4(_PlanarCaptureVP[0][0][0], _PlanarCaptureVP[0][1][0], _PlanarCaptureVP[0][2][0], _PlanarCaptureVP[0][3][0]);
				fragment_uniform_buffer_3[1] = float4(_PlanarCaptureVP[0][0][1], _PlanarCaptureVP[0][1][1], _PlanarCaptureVP[0][2][1], _PlanarCaptureVP[0][3][1]);
				fragment_uniform_buffer_3[2] = float4(_PlanarCaptureVP[0][0][2], _PlanarCaptureVP[0][1][2], _PlanarCaptureVP[0][2][2], _PlanarCaptureVP[0][3][2]);
				fragment_uniform_buffer_3[3] = float4(_PlanarCaptureVP[0][0][3], _PlanarCaptureVP[0][1][3], _PlanarCaptureVP[0][2][3], _PlanarCaptureVP[0][3][3]);
				fragment_uniform_buffer_3[4] = float4(_PlanarCaptureVP[1][0][0], _PlanarCaptureVP[1][1][0], _PlanarCaptureVP[1][2][0], _PlanarCaptureVP[1][3][0]);
				fragment_uniform_buffer_3[5] = float4(_PlanarCaptureVP[1][0][1], _PlanarCaptureVP[1][1][1], _PlanarCaptureVP[1][2][1], _PlanarCaptureVP[1][3][1]);
				fragment_uniform_buffer_3[6] = float4(_PlanarCaptureVP[1][0][2], _PlanarCaptureVP[1][1][2], _PlanarCaptureVP[1][2][2], _PlanarCaptureVP[1][3][2]);
				fragment_uniform_buffer_3[7] = float4(_PlanarCaptureVP[1][0][3], _PlanarCaptureVP[1][1][3], _PlanarCaptureVP[1][2][3], _PlanarCaptureVP[1][3][3]);
				fragment_uniform_buffer_3[8] = float4(_PlanarCaptureVP[2][0][0], _PlanarCaptureVP[2][1][0], _PlanarCaptureVP[2][2][0], _PlanarCaptureVP[2][3][0]);
				fragment_uniform_buffer_3[9] = float4(_PlanarCaptureVP[2][0][1], _PlanarCaptureVP[2][1][1], _PlanarCaptureVP[2][2][1], _PlanarCaptureVP[2][3][1]);
				fragment_uniform_buffer_3[10] = float4(_PlanarCaptureVP[2][0][2], _PlanarCaptureVP[2][1][2], _PlanarCaptureVP[2][2][2], _PlanarCaptureVP[2][3][2]);
				fragment_uniform_buffer_3[11] = float4(_PlanarCaptureVP[2][0][3], _PlanarCaptureVP[2][1][3], _PlanarCaptureVP[2][2][3], _PlanarCaptureVP[2][3][3]);
				fragment_uniform_buffer_3[12] = float4(_PlanarCaptureVP[3][0][0], _PlanarCaptureVP[3][1][0], _PlanarCaptureVP[3][2][0], _PlanarCaptureVP[3][3][0]);
				fragment_uniform_buffer_3[13] = float4(_PlanarCaptureVP[3][0][1], _PlanarCaptureVP[3][1][1], _PlanarCaptureVP[3][2][1], _PlanarCaptureVP[3][3][1]);
				fragment_uniform_buffer_3[14] = float4(_PlanarCaptureVP[3][0][2], _PlanarCaptureVP[3][1][2], _PlanarCaptureVP[3][2][2], _PlanarCaptureVP[3][3][2]);
				fragment_uniform_buffer_3[15] = float4(_PlanarCaptureVP[3][0][3], _PlanarCaptureVP[3][1][3], _PlanarCaptureVP[3][2][3], _PlanarCaptureVP[3][3][3]);
				fragment_uniform_buffer_3[16] = float4(_PlanarCaptureVP[4][0][0], _PlanarCaptureVP[4][1][0], _PlanarCaptureVP[4][2][0], _PlanarCaptureVP[4][3][0]);
				fragment_uniform_buffer_3[17] = float4(_PlanarCaptureVP[4][0][1], _PlanarCaptureVP[4][1][1], _PlanarCaptureVP[4][2][1], _PlanarCaptureVP[4][3][1]);
				fragment_uniform_buffer_3[18] = float4(_PlanarCaptureVP[4][0][2], _PlanarCaptureVP[4][1][2], _PlanarCaptureVP[4][2][2], _PlanarCaptureVP[4][3][2]);
				fragment_uniform_buffer_3[19] = float4(_PlanarCaptureVP[4][0][3], _PlanarCaptureVP[4][1][3], _PlanarCaptureVP[4][2][3], _PlanarCaptureVP[4][3][3]);
				fragment_uniform_buffer_3[20] = float4(_PlanarCaptureVP[5][0][0], _PlanarCaptureVP[5][1][0], _PlanarCaptureVP[5][2][0], _PlanarCaptureVP[5][3][0]);
				fragment_uniform_buffer_3[21] = float4(_PlanarCaptureVP[5][0][1], _PlanarCaptureVP[5][1][1], _PlanarCaptureVP[5][2][1], _PlanarCaptureVP[5][3][1]);
				fragment_uniform_buffer_3[22] = float4(_PlanarCaptureVP[5][0][2], _PlanarCaptureVP[5][1][2], _PlanarCaptureVP[5][2][2], _PlanarCaptureVP[5][3][2]);
				fragment_uniform_buffer_3[23] = float4(_PlanarCaptureVP[5][0][3], _PlanarCaptureVP[5][1][3], _PlanarCaptureVP[5][2][3], _PlanarCaptureVP[5][3][3]);
				fragment_uniform_buffer_3[24] = float4(_PlanarCaptureVP[6][0][0], _PlanarCaptureVP[6][1][0], _PlanarCaptureVP[6][2][0], _PlanarCaptureVP[6][3][0]);
				fragment_uniform_buffer_3[25] = float4(_PlanarCaptureVP[6][0][1], _PlanarCaptureVP[6][1][1], _PlanarCaptureVP[6][2][1], _PlanarCaptureVP[6][3][1]);
				fragment_uniform_buffer_3[26] = float4(_PlanarCaptureVP[6][0][2], _PlanarCaptureVP[6][1][2], _PlanarCaptureVP[6][2][2], _PlanarCaptureVP[6][3][2]);
				fragment_uniform_buffer_3[27] = float4(_PlanarCaptureVP[6][0][3], _PlanarCaptureVP[6][1][3], _PlanarCaptureVP[6][2][3], _PlanarCaptureVP[6][3][3]);
				fragment_uniform_buffer_3[28] = float4(_PlanarCaptureVP[7][0][0], _PlanarCaptureVP[7][1][0], _PlanarCaptureVP[7][2][0], _PlanarCaptureVP[7][3][0]);
				fragment_uniform_buffer_3[29] = float4(_PlanarCaptureVP[7][0][1], _PlanarCaptureVP[7][1][1], _PlanarCaptureVP[7][2][1], _PlanarCaptureVP[7][3][1]);
				fragment_uniform_buffer_3[30] = float4(_PlanarCaptureVP[7][0][2], _PlanarCaptureVP[7][1][2], _PlanarCaptureVP[7][2][2], _PlanarCaptureVP[7][3][2]);
				fragment_uniform_buffer_3[31] = float4(_PlanarCaptureVP[7][0][3], _PlanarCaptureVP[7][1][3], _PlanarCaptureVP[7][2][3], _PlanarCaptureVP[7][3][3]);
				fragment_uniform_buffer_3[32] = float4(_PlanarCaptureVP[8][0][0], _PlanarCaptureVP[8][1][0], _PlanarCaptureVP[8][2][0], _PlanarCaptureVP[8][3][0]);
				fragment_uniform_buffer_3[33] = float4(_PlanarCaptureVP[8][0][1], _PlanarCaptureVP[8][1][1], _PlanarCaptureVP[8][2][1], _PlanarCaptureVP[8][3][1]);
				fragment_uniform_buffer_3[34] = float4(_PlanarCaptureVP[8][0][2], _PlanarCaptureVP[8][1][2], _PlanarCaptureVP[8][2][2], _PlanarCaptureVP[8][3][2]);
				fragment_uniform_buffer_3[35] = float4(_PlanarCaptureVP[8][0][3], _PlanarCaptureVP[8][1][3], _PlanarCaptureVP[8][2][3], _PlanarCaptureVP[8][3][3]);
				fragment_uniform_buffer_3[36] = float4(_PlanarCaptureVP[9][0][0], _PlanarCaptureVP[9][1][0], _PlanarCaptureVP[9][2][0], _PlanarCaptureVP[9][3][0]);
				fragment_uniform_buffer_3[37] = float4(_PlanarCaptureVP[9][0][1], _PlanarCaptureVP[9][1][1], _PlanarCaptureVP[9][2][1], _PlanarCaptureVP[9][3][1]);
				fragment_uniform_buffer_3[38] = float4(_PlanarCaptureVP[9][0][2], _PlanarCaptureVP[9][1][2], _PlanarCaptureVP[9][2][2], _PlanarCaptureVP[9][3][2]);
				fragment_uniform_buffer_3[39] = float4(_PlanarCaptureVP[9][0][3], _PlanarCaptureVP[9][1][3], _PlanarCaptureVP[9][2][3], _PlanarCaptureVP[9][3][3]);
				fragment_uniform_buffer_3[40] = float4(_PlanarCaptureVP[10][0][0], _PlanarCaptureVP[10][1][0], _PlanarCaptureVP[10][2][0], _PlanarCaptureVP[10][3][0]);
				fragment_uniform_buffer_3[41] = float4(_PlanarCaptureVP[10][0][1], _PlanarCaptureVP[10][1][1], _PlanarCaptureVP[10][2][1], _PlanarCaptureVP[10][3][1]);
				fragment_uniform_buffer_3[42] = float4(_PlanarCaptureVP[10][0][2], _PlanarCaptureVP[10][1][2], _PlanarCaptureVP[10][2][2], _PlanarCaptureVP[10][3][2]);
				fragment_uniform_buffer_3[43] = float4(_PlanarCaptureVP[10][0][3], _PlanarCaptureVP[10][1][3], _PlanarCaptureVP[10][2][3], _PlanarCaptureVP[10][3][3]);
				fragment_uniform_buffer_3[44] = float4(_PlanarCaptureVP[11][0][0], _PlanarCaptureVP[11][1][0], _PlanarCaptureVP[11][2][0], _PlanarCaptureVP[11][3][0]);
				fragment_uniform_buffer_3[45] = float4(_PlanarCaptureVP[11][0][1], _PlanarCaptureVP[11][1][1], _PlanarCaptureVP[11][2][1], _PlanarCaptureVP[11][3][1]);
				fragment_uniform_buffer_3[46] = float4(_PlanarCaptureVP[11][0][2], _PlanarCaptureVP[11][1][2], _PlanarCaptureVP[11][2][2], _PlanarCaptureVP[11][3][2]);
				fragment_uniform_buffer_3[47] = float4(_PlanarCaptureVP[11][0][3], _PlanarCaptureVP[11][1][3], _PlanarCaptureVP[11][2][3], _PlanarCaptureVP[11][3][3]);
				fragment_uniform_buffer_3[48] = float4(_PlanarCaptureVP[12][0][0], _PlanarCaptureVP[12][1][0], _PlanarCaptureVP[12][2][0], _PlanarCaptureVP[12][3][0]);
				fragment_uniform_buffer_3[49] = float4(_PlanarCaptureVP[12][0][1], _PlanarCaptureVP[12][1][1], _PlanarCaptureVP[12][2][1], _PlanarCaptureVP[12][3][1]);
				fragment_uniform_buffer_3[50] = float4(_PlanarCaptureVP[12][0][2], _PlanarCaptureVP[12][1][2], _PlanarCaptureVP[12][2][2], _PlanarCaptureVP[12][3][2]);
				fragment_uniform_buffer_3[51] = float4(_PlanarCaptureVP[12][0][3], _PlanarCaptureVP[12][1][3], _PlanarCaptureVP[12][2][3], _PlanarCaptureVP[12][3][3]);
				fragment_uniform_buffer_3[52] = float4(_PlanarCaptureVP[13][0][0], _PlanarCaptureVP[13][1][0], _PlanarCaptureVP[13][2][0], _PlanarCaptureVP[13][3][0]);
				fragment_uniform_buffer_3[53] = float4(_PlanarCaptureVP[13][0][1], _PlanarCaptureVP[13][1][1], _PlanarCaptureVP[13][2][1], _PlanarCaptureVP[13][3][1]);
				fragment_uniform_buffer_3[54] = float4(_PlanarCaptureVP[13][0][2], _PlanarCaptureVP[13][1][2], _PlanarCaptureVP[13][2][2], _PlanarCaptureVP[13][3][2]);
				fragment_uniform_buffer_3[55] = float4(_PlanarCaptureVP[13][0][3], _PlanarCaptureVP[13][1][3], _PlanarCaptureVP[13][2][3], _PlanarCaptureVP[13][3][3]);
				fragment_uniform_buffer_3[56] = float4(_PlanarCaptureVP[14][0][0], _PlanarCaptureVP[14][1][0], _PlanarCaptureVP[14][2][0], _PlanarCaptureVP[14][3][0]);
				fragment_uniform_buffer_3[57] = float4(_PlanarCaptureVP[14][0][1], _PlanarCaptureVP[14][1][1], _PlanarCaptureVP[14][2][1], _PlanarCaptureVP[14][3][1]);
				fragment_uniform_buffer_3[58] = float4(_PlanarCaptureVP[14][0][2], _PlanarCaptureVP[14][1][2], _PlanarCaptureVP[14][2][2], _PlanarCaptureVP[14][3][2]);
				fragment_uniform_buffer_3[59] = float4(_PlanarCaptureVP[14][0][3], _PlanarCaptureVP[14][1][3], _PlanarCaptureVP[14][2][3], _PlanarCaptureVP[14][3][3]);
				fragment_uniform_buffer_3[60] = float4(_PlanarCaptureVP[15][0][0], _PlanarCaptureVP[15][1][0], _PlanarCaptureVP[15][2][0], _PlanarCaptureVP[15][3][0]);
				fragment_uniform_buffer_3[61] = float4(_PlanarCaptureVP[15][0][1], _PlanarCaptureVP[15][1][1], _PlanarCaptureVP[15][2][1], _PlanarCaptureVP[15][3][1]);
				fragment_uniform_buffer_3[62] = float4(_PlanarCaptureVP[15][0][2], _PlanarCaptureVP[15][1][2], _PlanarCaptureVP[15][2][2], _PlanarCaptureVP[15][3][2]);
				fragment_uniform_buffer_3[63] = float4(_PlanarCaptureVP[15][0][3], _PlanarCaptureVP[15][1][3], _PlanarCaptureVP[15][2][3], _PlanarCaptureVP[15][3][3]);

				fragment_uniform_buffer_3[64] = float4(_PlanarScaleOffset[0][0], _PlanarScaleOffset[0][1], _PlanarScaleOffset[0][2], _PlanarScaleOffset[0][3]);
				fragment_uniform_buffer_3[65] = float4(_PlanarScaleOffset[1][0], _PlanarScaleOffset[1][1], _PlanarScaleOffset[1][2], _PlanarScaleOffset[1][3]);
				fragment_uniform_buffer_3[66] = float4(_PlanarScaleOffset[2][0], _PlanarScaleOffset[2][1], _PlanarScaleOffset[2][2], _PlanarScaleOffset[2][3]);
				fragment_uniform_buffer_3[67] = float4(_PlanarScaleOffset[3][0], _PlanarScaleOffset[3][1], _PlanarScaleOffset[3][2], _PlanarScaleOffset[3][3]);
				fragment_uniform_buffer_3[68] = float4(_PlanarScaleOffset[4][0], _PlanarScaleOffset[4][1], _PlanarScaleOffset[4][2], _PlanarScaleOffset[4][3]);
				fragment_uniform_buffer_3[69] = float4(_PlanarScaleOffset[5][0], _PlanarScaleOffset[5][1], _PlanarScaleOffset[5][2], _PlanarScaleOffset[5][3]);
				fragment_uniform_buffer_3[70] = float4(_PlanarScaleOffset[6][0], _PlanarScaleOffset[6][1], _PlanarScaleOffset[6][2], _PlanarScaleOffset[6][3]);
				fragment_uniform_buffer_3[71] = float4(_PlanarScaleOffset[7][0], _PlanarScaleOffset[7][1], _PlanarScaleOffset[7][2], _PlanarScaleOffset[7][3]);
				fragment_uniform_buffer_3[72] = float4(_PlanarScaleOffset[8][0], _PlanarScaleOffset[8][1], _PlanarScaleOffset[8][2], _PlanarScaleOffset[8][3]);
				fragment_uniform_buffer_3[73] = float4(_PlanarScaleOffset[9][0], _PlanarScaleOffset[9][1], _PlanarScaleOffset[9][2], _PlanarScaleOffset[9][3]);
				fragment_uniform_buffer_3[74] = float4(_PlanarScaleOffset[10][0], _PlanarScaleOffset[10][1], _PlanarScaleOffset[10][2], _PlanarScaleOffset[10][3]);
				fragment_uniform_buffer_3[75] = float4(_PlanarScaleOffset[11][0], _PlanarScaleOffset[11][1], _PlanarScaleOffset[11][2], _PlanarScaleOffset[11][3]);
				fragment_uniform_buffer_3[76] = float4(_PlanarScaleOffset[12][0], _PlanarScaleOffset[12][1], _PlanarScaleOffset[12][2], _PlanarScaleOffset[12][3]);
				fragment_uniform_buffer_3[77] = float4(_PlanarScaleOffset[13][0], _PlanarScaleOffset[13][1], _PlanarScaleOffset[13][2], _PlanarScaleOffset[13][3]);
				fragment_uniform_buffer_3[78] = float4(_PlanarScaleOffset[14][0], _PlanarScaleOffset[14][1], _PlanarScaleOffset[14][2], _PlanarScaleOffset[14][3]);
				fragment_uniform_buffer_3[79] = float4(_PlanarScaleOffset[15][0], _PlanarScaleOffset[15][1], _PlanarScaleOffset[15][2], _PlanarScaleOffset[15][3]);

				fragment_uniform_buffer_3[80] = float4(_CubeScaleOffset[0][0], _CubeScaleOffset[0][1], _CubeScaleOffset[0][2], _CubeScaleOffset[0][3]);
				fragment_uniform_buffer_3[81] = float4(_CubeScaleOffset[1][0], _CubeScaleOffset[1][1], _CubeScaleOffset[1][2], _CubeScaleOffset[1][3]);
				fragment_uniform_buffer_3[82] = float4(_CubeScaleOffset[2][0], _CubeScaleOffset[2][1], _CubeScaleOffset[2][2], _CubeScaleOffset[2][3]);
				fragment_uniform_buffer_3[83] = float4(_CubeScaleOffset[3][0], _CubeScaleOffset[3][1], _CubeScaleOffset[3][2], _CubeScaleOffset[3][3]);
				fragment_uniform_buffer_3[84] = float4(_CubeScaleOffset[4][0], _CubeScaleOffset[4][1], _CubeScaleOffset[4][2], _CubeScaleOffset[4][3]);
				fragment_uniform_buffer_3[85] = float4(_CubeScaleOffset[5][0], _CubeScaleOffset[5][1], _CubeScaleOffset[5][2], _CubeScaleOffset[5][3]);
				fragment_uniform_buffer_3[86] = float4(_CubeScaleOffset[6][0], _CubeScaleOffset[6][1], _CubeScaleOffset[6][2], _CubeScaleOffset[6][3]);
				fragment_uniform_buffer_3[87] = float4(_CubeScaleOffset[7][0], _CubeScaleOffset[7][1], _CubeScaleOffset[7][2], _CubeScaleOffset[7][3]);
				fragment_uniform_buffer_3[88] = float4(_CubeScaleOffset[8][0], _CubeScaleOffset[8][1], _CubeScaleOffset[8][2], _CubeScaleOffset[8][3]);
				fragment_uniform_buffer_3[89] = float4(_CubeScaleOffset[9][0], _CubeScaleOffset[9][1], _CubeScaleOffset[9][2], _CubeScaleOffset[9][3]);
				fragment_uniform_buffer_3[90] = float4(_CubeScaleOffset[10][0], _CubeScaleOffset[10][1], _CubeScaleOffset[10][2], _CubeScaleOffset[10][3]);
				fragment_uniform_buffer_3[91] = float4(_CubeScaleOffset[11][0], _CubeScaleOffset[11][1], _CubeScaleOffset[11][2], _CubeScaleOffset[11][3]);
				fragment_uniform_buffer_3[92] = float4(_CubeScaleOffset[12][0], _CubeScaleOffset[12][1], _CubeScaleOffset[12][2], _CubeScaleOffset[12][3]);
				fragment_uniform_buffer_3[93] = float4(_CubeScaleOffset[13][0], _CubeScaleOffset[13][1], _CubeScaleOffset[13][2], _CubeScaleOffset[13][3]);
				fragment_uniform_buffer_3[94] = float4(_CubeScaleOffset[14][0], _CubeScaleOffset[14][1], _CubeScaleOffset[14][2], _CubeScaleOffset[14][3]);
				fragment_uniform_buffer_3[95] = float4(_CubeScaleOffset[15][0], _CubeScaleOffset[15][1], _CubeScaleOffset[15][2], _CubeScaleOffset[15][3]);
				fragment_uniform_buffer_3[96] = float4(_CubeScaleOffset[16][0], _CubeScaleOffset[16][1], _CubeScaleOffset[16][2], _CubeScaleOffset[16][3]);
				fragment_uniform_buffer_3[97] = float4(_CubeScaleOffset[17][0], _CubeScaleOffset[17][1], _CubeScaleOffset[17][2], _CubeScaleOffset[17][3]);
				fragment_uniform_buffer_3[98] = float4(_CubeScaleOffset[18][0], _CubeScaleOffset[18][1], _CubeScaleOffset[18][2], _CubeScaleOffset[18][3]);
				fragment_uniform_buffer_3[99] = float4(_CubeScaleOffset[19][0], _CubeScaleOffset[19][1], _CubeScaleOffset[19][2], _CubeScaleOffset[19][3]);
				fragment_uniform_buffer_3[100] = float4(_CubeScaleOffset[20][0], _CubeScaleOffset[20][1], _CubeScaleOffset[20][2], _CubeScaleOffset[20][3]);
				fragment_uniform_buffer_3[101] = float4(_CubeScaleOffset[21][0], _CubeScaleOffset[21][1], _CubeScaleOffset[21][2], _CubeScaleOffset[21][3]);
				fragment_uniform_buffer_3[102] = float4(_CubeScaleOffset[22][0], _CubeScaleOffset[22][1], _CubeScaleOffset[22][2], _CubeScaleOffset[22][3]);
				fragment_uniform_buffer_3[103] = float4(_CubeScaleOffset[23][0], _CubeScaleOffset[23][1], _CubeScaleOffset[23][2], _CubeScaleOffset[23][3]);
				fragment_uniform_buffer_3[104] = float4(_CubeScaleOffset[24][0], _CubeScaleOffset[24][1], _CubeScaleOffset[24][2], _CubeScaleOffset[24][3]);
				fragment_uniform_buffer_3[105] = float4(_CubeScaleOffset[25][0], _CubeScaleOffset[25][1], _CubeScaleOffset[25][2], _CubeScaleOffset[25][3]);
				fragment_uniform_buffer_3[106] = float4(_CubeScaleOffset[26][0], _CubeScaleOffset[26][1], _CubeScaleOffset[26][2], _CubeScaleOffset[26][3]);
				fragment_uniform_buffer_3[107] = float4(_CubeScaleOffset[27][0], _CubeScaleOffset[27][1], _CubeScaleOffset[27][2], _CubeScaleOffset[27][3]);
				fragment_uniform_buffer_3[108] = float4(_CubeScaleOffset[28][0], _CubeScaleOffset[28][1], _CubeScaleOffset[28][2], _CubeScaleOffset[28][3]);
				fragment_uniform_buffer_3[109] = float4(_CubeScaleOffset[29][0], _CubeScaleOffset[29][1], _CubeScaleOffset[29][2], _CubeScaleOffset[29][3]);
				fragment_uniform_buffer_3[110] = float4(_CubeScaleOffset[30][0], _CubeScaleOffset[30][1], _CubeScaleOffset[30][2], _CubeScaleOffset[30][3]);
				fragment_uniform_buffer_3[111] = float4(_CubeScaleOffset[31][0], _CubeScaleOffset[31][1], _CubeScaleOffset[31][2], _CubeScaleOffset[31][3]);
				fragment_uniform_buffer_3[112] = float4(_CubeScaleOffset[32][0], _CubeScaleOffset[32][1], _CubeScaleOffset[32][2], _CubeScaleOffset[32][3]);
				fragment_uniform_buffer_3[113] = float4(_CubeScaleOffset[33][0], _CubeScaleOffset[33][1], _CubeScaleOffset[33][2], _CubeScaleOffset[33][3]);
				fragment_uniform_buffer_3[114] = float4(_CubeScaleOffset[34][0], _CubeScaleOffset[34][1], _CubeScaleOffset[34][2], _CubeScaleOffset[34][3]);
				fragment_uniform_buffer_3[115] = float4(_CubeScaleOffset[35][0], _CubeScaleOffset[35][1], _CubeScaleOffset[35][2], _CubeScaleOffset[35][3]);
				fragment_uniform_buffer_3[116] = float4(_CubeScaleOffset[36][0], _CubeScaleOffset[36][1], _CubeScaleOffset[36][2], _CubeScaleOffset[36][3]);
				fragment_uniform_buffer_3[117] = float4(_CubeScaleOffset[37][0], _CubeScaleOffset[37][1], _CubeScaleOffset[37][2], _CubeScaleOffset[37][3]);
				fragment_uniform_buffer_3[118] = float4(_CubeScaleOffset[38][0], _CubeScaleOffset[38][1], _CubeScaleOffset[38][2], _CubeScaleOffset[38][3]);
				fragment_uniform_buffer_3[119] = float4(_CubeScaleOffset[39][0], _CubeScaleOffset[39][1], _CubeScaleOffset[39][2], _CubeScaleOffset[39][3]);
				fragment_uniform_buffer_3[120] = float4(_CubeScaleOffset[40][0], _CubeScaleOffset[40][1], _CubeScaleOffset[40][2], _CubeScaleOffset[40][3]);
				fragment_uniform_buffer_3[121] = float4(_CubeScaleOffset[41][0], _CubeScaleOffset[41][1], _CubeScaleOffset[41][2], _CubeScaleOffset[41][3]);
				fragment_uniform_buffer_3[122] = float4(_CubeScaleOffset[42][0], _CubeScaleOffset[42][1], _CubeScaleOffset[42][2], _CubeScaleOffset[42][3]);
				fragment_uniform_buffer_3[123] = float4(_CubeScaleOffset[43][0], _CubeScaleOffset[43][1], _CubeScaleOffset[43][2], _CubeScaleOffset[43][3]);
				fragment_uniform_buffer_3[124] = float4(_CubeScaleOffset[44][0], _CubeScaleOffset[44][1], _CubeScaleOffset[44][2], _CubeScaleOffset[44][3]);
				fragment_uniform_buffer_3[125] = float4(_CubeScaleOffset[45][0], _CubeScaleOffset[45][1], _CubeScaleOffset[45][2], _CubeScaleOffset[45][3]);
				fragment_uniform_buffer_3[126] = float4(_CubeScaleOffset[46][0], _CubeScaleOffset[46][1], _CubeScaleOffset[46][2], _CubeScaleOffset[46][3]);
				fragment_uniform_buffer_3[127] = float4(_CubeScaleOffset[47][0], _CubeScaleOffset[47][1], _CubeScaleOffset[47][2], _CubeScaleOffset[47][3]);
				fragment_uniform_buffer_3[128] = float4(_CubeScaleOffset[48][0], _CubeScaleOffset[48][1], _CubeScaleOffset[48][2], _CubeScaleOffset[48][3]);
				fragment_uniform_buffer_3[129] = float4(_CubeScaleOffset[49][0], _CubeScaleOffset[49][1], _CubeScaleOffset[49][2], _CubeScaleOffset[49][3]);
				fragment_uniform_buffer_3[130] = float4(_CubeScaleOffset[50][0], _CubeScaleOffset[50][1], _CubeScaleOffset[50][2], _CubeScaleOffset[50][3]);
				fragment_uniform_buffer_3[131] = float4(_CubeScaleOffset[51][0], _CubeScaleOffset[51][1], _CubeScaleOffset[51][2], _CubeScaleOffset[51][3]);
				fragment_uniform_buffer_3[132] = float4(_CubeScaleOffset[52][0], _CubeScaleOffset[52][1], _CubeScaleOffset[52][2], _CubeScaleOffset[52][3]);
				fragment_uniform_buffer_3[133] = float4(_CubeScaleOffset[53][0], _CubeScaleOffset[53][1], _CubeScaleOffset[53][2], _CubeScaleOffset[53][3]);
				fragment_uniform_buffer_3[134] = float4(_CubeScaleOffset[54][0], _CubeScaleOffset[54][1], _CubeScaleOffset[54][2], _CubeScaleOffset[54][3]);
				fragment_uniform_buffer_3[135] = float4(_CubeScaleOffset[55][0], _CubeScaleOffset[55][1], _CubeScaleOffset[55][2], _CubeScaleOffset[55][3]);
				fragment_uniform_buffer_3[136] = float4(_CubeScaleOffset[56][0], _CubeScaleOffset[56][1], _CubeScaleOffset[56][2], _CubeScaleOffset[56][3]);
				fragment_uniform_buffer_3[137] = float4(_CubeScaleOffset[57][0], _CubeScaleOffset[57][1], _CubeScaleOffset[57][2], _CubeScaleOffset[57][3]);
				fragment_uniform_buffer_3[138] = float4(_CubeScaleOffset[58][0], _CubeScaleOffset[58][1], _CubeScaleOffset[58][2], _CubeScaleOffset[58][3]);
				fragment_uniform_buffer_3[139] = float4(_CubeScaleOffset[59][0], _CubeScaleOffset[59][1], _CubeScaleOffset[59][2], _CubeScaleOffset[59][3]);
				fragment_uniform_buffer_3[140] = float4(_CubeScaleOffset[60][0], _CubeScaleOffset[60][1], _CubeScaleOffset[60][2], _CubeScaleOffset[60][3]);
				fragment_uniform_buffer_3[141] = float4(_CubeScaleOffset[61][0], _CubeScaleOffset[61][1], _CubeScaleOffset[61][2], _CubeScaleOffset[61][3]);
				fragment_uniform_buffer_3[142] = float4(_CubeScaleOffset[62][0], _CubeScaleOffset[62][1], _CubeScaleOffset[62][2], _CubeScaleOffset[62][3]);
				fragment_uniform_buffer_3[143] = float4(_CubeScaleOffset[63][0], _CubeScaleOffset[63][1], _CubeScaleOffset[63][2], _CubeScaleOffset[63][3]);
				fragment_uniform_buffer_3[144] = float4(_CubeScaleOffset[64][0], _CubeScaleOffset[64][1], _CubeScaleOffset[64][2], _CubeScaleOffset[64][3]);
				fragment_uniform_buffer_3[145] = float4(_CubeScaleOffset[65][0], _CubeScaleOffset[65][1], _CubeScaleOffset[65][2], _CubeScaleOffset[65][3]);
				fragment_uniform_buffer_3[146] = float4(_CubeScaleOffset[66][0], _CubeScaleOffset[66][1], _CubeScaleOffset[66][2], _CubeScaleOffset[66][3]);
				fragment_uniform_buffer_3[147] = float4(_CubeScaleOffset[67][0], _CubeScaleOffset[67][1], _CubeScaleOffset[67][2], _CubeScaleOffset[67][3]);
				fragment_uniform_buffer_3[148] = float4(_CubeScaleOffset[68][0], _CubeScaleOffset[68][1], _CubeScaleOffset[68][2], _CubeScaleOffset[68][3]);
				fragment_uniform_buffer_3[149] = float4(_CubeScaleOffset[69][0], _CubeScaleOffset[69][1], _CubeScaleOffset[69][2], _CubeScaleOffset[69][3]);
				fragment_uniform_buffer_3[150] = float4(_CubeScaleOffset[70][0], _CubeScaleOffset[70][1], _CubeScaleOffset[70][2], _CubeScaleOffset[70][3]);
				fragment_uniform_buffer_3[151] = float4(_CubeScaleOffset[71][0], _CubeScaleOffset[71][1], _CubeScaleOffset[71][2], _CubeScaleOffset[71][3]);
				fragment_uniform_buffer_3[152] = float4(_CubeScaleOffset[72][0], _CubeScaleOffset[72][1], _CubeScaleOffset[72][2], _CubeScaleOffset[72][3]);
				fragment_uniform_buffer_3[153] = float4(_CubeScaleOffset[73][0], _CubeScaleOffset[73][1], _CubeScaleOffset[73][2], _CubeScaleOffset[73][3]);
				fragment_uniform_buffer_3[154] = float4(_CubeScaleOffset[74][0], _CubeScaleOffset[74][1], _CubeScaleOffset[74][2], _CubeScaleOffset[74][3]);
				fragment_uniform_buffer_3[155] = float4(_CubeScaleOffset[75][0], _CubeScaleOffset[75][1], _CubeScaleOffset[75][2], _CubeScaleOffset[75][3]);
				fragment_uniform_buffer_3[156] = float4(_CubeScaleOffset[76][0], _CubeScaleOffset[76][1], _CubeScaleOffset[76][2], _CubeScaleOffset[76][3]);
				fragment_uniform_buffer_3[157] = float4(_CubeScaleOffset[77][0], _CubeScaleOffset[77][1], _CubeScaleOffset[77][2], _CubeScaleOffset[77][3]);
				fragment_uniform_buffer_3[158] = float4(_CubeScaleOffset[78][0], _CubeScaleOffset[78][1], _CubeScaleOffset[78][2], _CubeScaleOffset[78][3]);
				fragment_uniform_buffer_3[159] = float4(_CubeScaleOffset[79][0], _CubeScaleOffset[79][1], _CubeScaleOffset[79][2], _CubeScaleOffset[79][3]);
				fragment_uniform_buffer_3[160] = float4(_CubeScaleOffset[80][0], _CubeScaleOffset[80][1], _CubeScaleOffset[80][2], _CubeScaleOffset[80][3]);
				fragment_uniform_buffer_3[161] = float4(_CubeScaleOffset[81][0], _CubeScaleOffset[81][1], _CubeScaleOffset[81][2], _CubeScaleOffset[81][3]);
				fragment_uniform_buffer_3[162] = float4(_CubeScaleOffset[82][0], _CubeScaleOffset[82][1], _CubeScaleOffset[82][2], _CubeScaleOffset[82][3]);
				fragment_uniform_buffer_3[163] = float4(_CubeScaleOffset[83][0], _CubeScaleOffset[83][1], _CubeScaleOffset[83][2], _CubeScaleOffset[83][3]);
				fragment_uniform_buffer_3[164] = float4(_CubeScaleOffset[84][0], _CubeScaleOffset[84][1], _CubeScaleOffset[84][2], _CubeScaleOffset[84][3]);
				fragment_uniform_buffer_3[165] = float4(_CubeScaleOffset[85][0], _CubeScaleOffset[85][1], _CubeScaleOffset[85][2], _CubeScaleOffset[85][3]);
				fragment_uniform_buffer_3[166] = float4(_CubeScaleOffset[86][0], _CubeScaleOffset[86][1], _CubeScaleOffset[86][2], _CubeScaleOffset[86][3]);
				fragment_uniform_buffer_3[167] = float4(_CubeScaleOffset[87][0], _CubeScaleOffset[87][1], _CubeScaleOffset[87][2], _CubeScaleOffset[87][3]);
				fragment_uniform_buffer_3[168] = float4(_CubeScaleOffset[88][0], _CubeScaleOffset[88][1], _CubeScaleOffset[88][2], _CubeScaleOffset[88][3]);
				fragment_uniform_buffer_3[169] = float4(_CubeScaleOffset[89][0], _CubeScaleOffset[89][1], _CubeScaleOffset[89][2], _CubeScaleOffset[89][3]);
				fragment_uniform_buffer_3[170] = float4(_CubeScaleOffset[90][0], _CubeScaleOffset[90][1], _CubeScaleOffset[90][2], _CubeScaleOffset[90][3]);
				fragment_uniform_buffer_3[171] = float4(_CubeScaleOffset[91][0], _CubeScaleOffset[91][1], _CubeScaleOffset[91][2], _CubeScaleOffset[91][3]);
				fragment_uniform_buffer_3[172] = float4(_CubeScaleOffset[92][0], _CubeScaleOffset[92][1], _CubeScaleOffset[92][2], _CubeScaleOffset[92][3]);
				fragment_uniform_buffer_3[173] = float4(_CubeScaleOffset[93][0], _CubeScaleOffset[93][1], _CubeScaleOffset[93][2], _CubeScaleOffset[93][3]);
				fragment_uniform_buffer_3[174] = float4(_CubeScaleOffset[94][0], _CubeScaleOffset[94][1], _CubeScaleOffset[94][2], _CubeScaleOffset[94][3]);
				fragment_uniform_buffer_3[175] = float4(_CubeScaleOffset[95][0], _CubeScaleOffset[95][1], _CubeScaleOffset[95][2], _CubeScaleOffset[95][3]);
				fragment_uniform_buffer_3[176] = float4(_CubeScaleOffset[96][0], _CubeScaleOffset[96][1], _CubeScaleOffset[96][2], _CubeScaleOffset[96][3]);
				fragment_uniform_buffer_3[177] = float4(_CubeScaleOffset[97][0], _CubeScaleOffset[97][1], _CubeScaleOffset[97][2], _CubeScaleOffset[97][3]);
				fragment_uniform_buffer_3[178] = float4(_CubeScaleOffset[98][0], _CubeScaleOffset[98][1], _CubeScaleOffset[98][2], _CubeScaleOffset[98][3]);
				fragment_uniform_buffer_3[179] = float4(_CubeScaleOffset[99][0], _CubeScaleOffset[99][1], _CubeScaleOffset[99][2], _CubeScaleOffset[99][3]);
				fragment_uniform_buffer_3[180] = float4(_CubeScaleOffset[100][0], _CubeScaleOffset[100][1], _CubeScaleOffset[100][2], _CubeScaleOffset[100][3]);
				fragment_uniform_buffer_3[181] = float4(_CubeScaleOffset[101][0], _CubeScaleOffset[101][1], _CubeScaleOffset[101][2], _CubeScaleOffset[101][3]);
				fragment_uniform_buffer_3[182] = float4(_CubeScaleOffset[102][0], _CubeScaleOffset[102][1], _CubeScaleOffset[102][2], _CubeScaleOffset[102][3]);
				fragment_uniform_buffer_3[183] = float4(_CubeScaleOffset[103][0], _CubeScaleOffset[103][1], _CubeScaleOffset[103][2], _CubeScaleOffset[103][3]);
				fragment_uniform_buffer_3[184] = float4(_CubeScaleOffset[104][0], _CubeScaleOffset[104][1], _CubeScaleOffset[104][2], _CubeScaleOffset[104][3]);
				fragment_uniform_buffer_3[185] = float4(_CubeScaleOffset[105][0], _CubeScaleOffset[105][1], _CubeScaleOffset[105][2], _CubeScaleOffset[105][3]);
				fragment_uniform_buffer_3[186] = float4(_CubeScaleOffset[106][0], _CubeScaleOffset[106][1], _CubeScaleOffset[106][2], _CubeScaleOffset[106][3]);
				fragment_uniform_buffer_3[187] = float4(_CubeScaleOffset[107][0], _CubeScaleOffset[107][1], _CubeScaleOffset[107][2], _CubeScaleOffset[107][3]);
				fragment_uniform_buffer_3[188] = float4(_CubeScaleOffset[108][0], _CubeScaleOffset[108][1], _CubeScaleOffset[108][2], _CubeScaleOffset[108][3]);
				fragment_uniform_buffer_3[189] = float4(_CubeScaleOffset[109][0], _CubeScaleOffset[109][1], _CubeScaleOffset[109][2], _CubeScaleOffset[109][3]);
				fragment_uniform_buffer_3[190] = float4(_CubeScaleOffset[110][0], _CubeScaleOffset[110][1], _CubeScaleOffset[110][2], _CubeScaleOffset[110][3]);
				fragment_uniform_buffer_3[191] = float4(_CubeScaleOffset[111][0], _CubeScaleOffset[111][1], _CubeScaleOffset[111][2], _CubeScaleOffset[111][3]);
				fragment_uniform_buffer_3[192] = float4(_CubeScaleOffset[112][0], _CubeScaleOffset[112][1], _CubeScaleOffset[112][2], _CubeScaleOffset[112][3]);
				fragment_uniform_buffer_3[193] = float4(_CubeScaleOffset[113][0], _CubeScaleOffset[113][1], _CubeScaleOffset[113][2], _CubeScaleOffset[113][3]);
				fragment_uniform_buffer_3[194] = float4(_CubeScaleOffset[114][0], _CubeScaleOffset[114][1], _CubeScaleOffset[114][2], _CubeScaleOffset[114][3]);
				fragment_uniform_buffer_3[195] = float4(_CubeScaleOffset[115][0], _CubeScaleOffset[115][1], _CubeScaleOffset[115][2], _CubeScaleOffset[115][3]);
				fragment_uniform_buffer_3[196] = float4(_CubeScaleOffset[116][0], _CubeScaleOffset[116][1], _CubeScaleOffset[116][2], _CubeScaleOffset[116][3]);
				fragment_uniform_buffer_3[197] = float4(_CubeScaleOffset[117][0], _CubeScaleOffset[117][1], _CubeScaleOffset[117][2], _CubeScaleOffset[117][3]);
				fragment_uniform_buffer_3[198] = float4(_CubeScaleOffset[118][0], _CubeScaleOffset[118][1], _CubeScaleOffset[118][2], _CubeScaleOffset[118][3]);
				fragment_uniform_buffer_3[199] = float4(_CubeScaleOffset[119][0], _CubeScaleOffset[119][1], _CubeScaleOffset[119][2], _CubeScaleOffset[119][3]);
				fragment_uniform_buffer_3[200] = float4(_CubeScaleOffset[120][0], _CubeScaleOffset[120][1], _CubeScaleOffset[120][2], _CubeScaleOffset[120][3]);
				fragment_uniform_buffer_3[201] = float4(_CubeScaleOffset[121][0], _CubeScaleOffset[121][1], _CubeScaleOffset[121][2], _CubeScaleOffset[121][3]);
				fragment_uniform_buffer_3[202] = float4(_CubeScaleOffset[122][0], _CubeScaleOffset[122][1], _CubeScaleOffset[122][2], _CubeScaleOffset[122][3]);
				fragment_uniform_buffer_3[203] = float4(_CubeScaleOffset[123][0], _CubeScaleOffset[123][1], _CubeScaleOffset[123][2], _CubeScaleOffset[123][3]);
				fragment_uniform_buffer_3[204] = float4(_CubeScaleOffset[124][0], _CubeScaleOffset[124][1], _CubeScaleOffset[124][2], _CubeScaleOffset[124][3]);
				fragment_uniform_buffer_3[205] = float4(_CubeScaleOffset[125][0], _CubeScaleOffset[125][1], _CubeScaleOffset[125][2], _CubeScaleOffset[125][3]);
				fragment_uniform_buffer_3[206] = float4(_CubeScaleOffset[126][0], _CubeScaleOffset[126][1], _CubeScaleOffset[126][2], _CubeScaleOffset[126][3]);
				fragment_uniform_buffer_3[207] = float4(_CubeScaleOffset[127][0], _CubeScaleOffset[127][1], _CubeScaleOffset[127][2], _CubeScaleOffset[127][3]);

				fragment_uniform_buffer_4[1] = float4(_Smoothness, fragment_uniform_buffer_4[1][1], fragment_uniform_buffer_4[1][2], fragment_uniform_buffer_4[1][3]);

				fragment_uniform_buffer_4[1] = float4(fragment_uniform_buffer_4[1][0], _Metallic, fragment_uniform_buffer_4[1][2], fragment_uniform_buffer_4[1][3]);

				fragment_uniform_buffer_4[2] = float4(_Emission[0], _Emission[1], _Emission[2], _Emission[3]);

				fragment_uniform_buffer_4[4] = float4(_Bloom, fragment_uniform_buffer_4[4][1], fragment_uniform_buffer_4[4][2], fragment_uniform_buffer_4[4][3]);

				fragment_uniform_buffer_4[12] = float4(_BlendMode, fragment_uniform_buffer_4[12][1], fragment_uniform_buffer_4[12][2], fragment_uniform_buffer_4[12][3]);

				fragment_uniform_buffer_4[12] = float4(fragment_uniform_buffer_4[12][0], _EnableBlendModePreserveSpecularLighting, fragment_uniform_buffer_4[12][2], fragment_uniform_buffer_4[12][3]);

				fragment_uniform_buffer_5[0] = float4(_AtmosphericRadius, fragment_uniform_buffer_5[0][1], fragment_uniform_buffer_5[0][2], fragment_uniform_buffer_5[0][3]);

				fragment_uniform_buffer_5[0] = float4(fragment_uniform_buffer_5[0][0], fragment_uniform_buffer_5[0][1], fragment_uniform_buffer_5[0][2], _AerosolSeaLevelExtinction);

				fragment_uniform_buffer_5[1] = float4(_AirDensityFalloff, fragment_uniform_buffer_5[1][1], fragment_uniform_buffer_5[1][2], fragment_uniform_buffer_5[1][3]);

				fragment_uniform_buffer_5[1] = float4(fragment_uniform_buffer_5[1][0], _AirScaleHeight, fragment_uniform_buffer_5[1][2], fragment_uniform_buffer_5[1][3]);

				fragment_uniform_buffer_5[1] = float4(fragment_uniform_buffer_5[1][0], fragment_uniform_buffer_5[1][1], _AerosolDensityFalloff, fragment_uniform_buffer_5[1][3]);

				fragment_uniform_buffer_5[1] = float4(fragment_uniform_buffer_5[1][0], fragment_uniform_buffer_5[1][1], fragment_uniform_buffer_5[1][2], _AerosolScaleHeight);

				fragment_uniform_buffer_5[2] = float4(_OzoneScaleOffset[0], _OzoneScaleOffset[1], fragment_uniform_buffer_5[2][2], fragment_uniform_buffer_5[2][3]);

				fragment_uniform_buffer_5[2] = float4(fragment_uniform_buffer_5[2][0], fragment_uniform_buffer_5[2][1], _OzoneLayerStart, fragment_uniform_buffer_5[2][3]);

				fragment_uniform_buffer_5[2] = float4(fragment_uniform_buffer_5[2][0], fragment_uniform_buffer_5[2][1], fragment_uniform_buffer_5[2][2], _OzoneLayerEnd);

				fragment_uniform_buffer_5[3] = float4(_AirSeaLevelExtinction[0], _AirSeaLevelExtinction[1], _AirSeaLevelExtinction[2], _AirSeaLevelExtinction[3]);

				fragment_uniform_buffer_5[6] = float4(_OzoneSeaLevelExtinction[0], _OzoneSeaLevelExtinction[1], _OzoneSeaLevelExtinction[2], _OzoneSeaLevelExtinction[3]);

				fragment_uniform_buffer_5[8] = float4(_HorizonTint[0], _HorizonTint[1], _HorizonTint[2], _HorizonTint[3]);

				fragment_uniform_buffer_5[9] = float4(_ZenithTint[0], _ZenithTint[1], _ZenithTint[2], _ZenithTint[3]);

				fragment_uniform_buffer_5[10] = float4(fragment_uniform_buffer_5[10][0], fragment_uniform_buffer_5[10][1], _AlphaSaturation, fragment_uniform_buffer_5[10][3]);

				fragment_uniform_buffer_5[10] = float4(fragment_uniform_buffer_5[10][0], fragment_uniform_buffer_5[10][1], fragment_uniform_buffer_5[10][2], _AlphaMultiplier);

				fragment_uniform_buffer_5[11] = float4(_HorizonZenithShiftPower, fragment_uniform_buffer_5[11][1], fragment_uniform_buffer_5[11][2], fragment_uniform_buffer_5[11][3]);

				fragment_uniform_buffer_5[11] = float4(fragment_uniform_buffer_5[11][0], _HorizonZenithShiftScale, fragment_uniform_buffer_5[11][2], fragment_uniform_buffer_5[11][3]);

				fragment_uniform_buffer_5[12] = float4(fragment_uniform_buffer_5[12][0], fragment_uniform_buffer_5[12][1], fragment_uniform_buffer_5[12][2], _VolumetricCloudsBottomAltitude);

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

			#endif
			#if (defined(_SURFACE_TYPE_TRANSPARENT) && !defined(AREA_SHADOW_MEDIUM) && !defined(DECALS_3RT) && !defined(DIRECTIONAL_SHADOW_MEDIUM) && !defined(PUNCTUAL_SHADOW_MEDIUM) && !defined(SCREEN_SPACE_SHADOWS_OFF) && !defined(USE_CLUSTERED_LIGHTLIST) && !defined(_DISABLE_DECALS) && !defined(_DISABLE_SSR_TRANSPARENT) && !defined(_ENABLE_FOG_ON_TRANSPARENT)) && defined(SHADER_STAGE_VERTEX)
			#define RIP_HAS_VERT

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[13];
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
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD1; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD2; // COLOR
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
				if ((((0.0f < vertex_uniform_buffer_2[12u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _RayTracing, vertex_uniform_buffer_2[12][3]);

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
			#if (defined(AREA_SHADOW_MEDIUM) && defined(DECALS_3RT) && defined(DIRECTIONAL_SHADOW_MEDIUM) && defined(PUNCTUAL_SHADOW_MEDIUM) && defined(SCREEN_SPACE_SHADOWS_OFF) && defined(USE_CLUSTERED_LIGHTLIST) && defined(_DISABLE_SSR_TRANSPARENT) && defined(_ENABLE_FOG_ON_TRANSPARENT) && defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_DISABLE_DECALS)) && defined(SHADER_STAGE_FRAGMENT)
			#define RIP_HAS_FRAG

			float2 _GlobalFogDistance;
			int _EnableDecalLayers;
			float2 _DecalAtlasResolution;
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
			float4x4 _PlanarCaptureVP[16];
			float4 _PlanarScaleOffset[16];
			float4 _CubeScaleOffset[128];
			float _Smoothness;
			float _Metallic;
			float4 _Emission;
			float _Bloom;
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

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[219];
			static float4 fragment_uniform_buffer_2[29];
			static float4 fragment_uniform_buffer_3[208];
			static float4 fragment_uniform_buffer_4[13];
			static float4 fragment_uniform_buffer_5[13];
			static const float fragment_unnamed_108[16] = { 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f };

			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Buffer<uint4> T2;
			Buffer<uint4> T3;
			Buffer<uint4> T4;
			Buffer<uint4> T5;
			Buffer<uint4> T6;
			Buffer<uint4> T7;
			Texture2D<float4> _CookieAtlas;
			Texture2DArray<float4> _ReflectionAtlas;
			Texture2D<float4> _VolumetricCloudsShadowsTexture;
			TextureCubeArray<float4> _SkyTexture;
			Buffer<uint4> T12;
			Texture2D<float4> _DecalAtlas2D;
			Texture2D<float4> Texture2D_23DD87FD;
			Texture2D<float4> _NormalMap;
			Texture3D<float4> _AtmosphericScatteringLUT;
			Texture2DArray<uint4> _StencilTexture;
			Texture2DArray<float4> _RefractiveDepthBuffer;
			Buffer<uint4> T19;
			Buffer<uint4> T20;
			Texture2DArray<float4> _WaterGBufferTexture3;
			Buffer<uint4> T22;
			Texture3D<float4> _VBufferLighting;
			Texture2D<float4> _ShadowmapAtlas;
			Texture2D<float4> _CachedShadowmapAtlas;
			Texture2D<float4> _ShadowmapCascadeAtlas;
			Texture2D<float4> _ShadowmapAreaAtlas;
			Texture2D<float4> _CachedAreaLightShadowmapAtlas;
			Buffer<uint4> T29;
			Buffer<uint4> T30;
			Texture2DArray<float4> _LtcData;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			SamplerState S0;
			SamplerState S1;
			SamplerComparisonState S2;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState S4;
			SamplerState samplerTexture2D_23DD87FD;
			SamplerState sampler_NormalMap;

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
				float fragment_unnamed_173 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_191 = asfloat((fragment_uniform_buffer_2[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_247 = fragment_unnamed_173 * fragment_input_7.x;
				float fragment_unnamed_248 = fragment_unnamed_173 * fragment_input_7.y;
				float fragment_unnamed_249 = fragment_unnamed_173 * fragment_input_7.z;
				bool fragment_unnamed_256 = 0u < asuint(fragment_uniform_buffer_1[211u]).y;
				float fragment_unnamed_276 = fragment_unnamed_256 ? float(uint(round(gl_FragCoord.x * fragment_uniform_buffer_1[211u].x))) : gl_FragCoord.x;
				float fragment_unnamed_277 = fragment_unnamed_256 ? float(uint(round(gl_FragCoord.y * fragment_uniform_buffer_1[211u].x))) : gl_FragCoord.y;
				uint fragment_unnamed_278 = uint(fragment_unnamed_276);
				uint fragment_unnamed_279 = uint(fragment_unnamed_277);
				uint fragment_unnamed_280 = fragment_unnamed_278 >> 5u;
				uint fragment_unnamed_282 = fragment_unnamed_279 >> 5u;
				float fragment_unnamed_288 = fragment_unnamed_276 * fragment_uniform_buffer_1[50u].z;
				float fragment_unnamed_289 = fragment_unnamed_277 * fragment_uniform_buffer_1[50u].w;
				bool fragment_unnamed_294 = fragment_uniform_buffer_1[15u].w == 0.0f;
				uint4 fragment_unnamed_315 = asuint(fragment_uniform_buffer_1[0u]);
				uint fragment_unnamed_316 = fragment_unnamed_315.z;
				uint4 fragment_unnamed_320 = asuint(fragment_uniform_buffer_1[1u]);
				uint fragment_unnamed_321 = fragment_unnamed_320.z;
				uint4 fragment_unnamed_325 = asuint(fragment_uniform_buffer_1[2u]);
				uint fragment_unnamed_326 = fragment_unnamed_325.z;
				float fragment_unnamed_332 = asfloat(fragment_unnamed_294 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_1[11u].x) : fragment_unnamed_316);
				float fragment_unnamed_334 = asfloat(fragment_unnamed_294 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_1[11u].y) : fragment_unnamed_321);
				float fragment_unnamed_336 = asfloat(fragment_unnamed_294 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_1[11u].z) : fragment_unnamed_326);
				float fragment_unnamed_340 = rsqrt(dot(float3(fragment_unnamed_332, fragment_unnamed_334, fragment_unnamed_336), float3(fragment_unnamed_332, fragment_unnamed_334, fragment_unnamed_336)));
				float fragment_unnamed_341 = fragment_unnamed_340 * fragment_unnamed_332;
				float fragment_unnamed_342 = fragment_unnamed_340 * fragment_unnamed_334;
				float fragment_unnamed_343 = fragment_unnamed_340 * fragment_unnamed_336;
				float4 fragment_unnamed_380 = Texture2D_23DD87FD.SampleBias(samplerTexture2D_23DD87FD, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_1[86u].y);
				float fragment_unnamed_386 = fragment_unnamed_380.w;
				float fragment_unnamed_393 = fragment_unnamed_380.x * fragment_input_5.x;
				float fragment_unnamed_394 = fragment_unnamed_380.y * fragment_input_5.y;
				float fragment_unnamed_395 = fragment_unnamed_380.z * fragment_input_5.z;
				float fragment_unnamed_425 = ((-0.0f) - clamp(((mad(fragment_uniform_buffer_1[22u].w, fragment_input_6.z, mad(fragment_uniform_buffer_1[20u].w, fragment_input_6.x, fragment_input_6.y * fragment_uniform_buffer_1[21u].w)) + fragment_uniform_buffer_1[23u].w) + ((-0.0f) - fragment_uniform_buffer_0[0u].x)) / (((-0.0f) - fragment_uniform_buffer_0[0u].x) + fragment_uniform_buffer_0[0u].y), 0.0f, 1.0f)) + 1.0f;
				float fragment_unnamed_428 = (fragment_unnamed_386 * fragment_unnamed_386) * fragment_input_5.w;
				float4 fragment_unnamed_437 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_1[86u].y);
				float fragment_unnamed_443 = mad(fragment_unnamed_437.x * fragment_unnamed_437.w, 2.0f, -1.0f);
				float fragment_unnamed_446 = mad(fragment_unnamed_437.y, 2.0f, -1.0f);
				float fragment_unnamed_454 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_443, fragment_unnamed_446), float2(fragment_unnamed_443, fragment_unnamed_446)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_462 = mad(fragment_unnamed_454, fragment_unnamed_247, mad(fragment_unnamed_443, fragment_unnamed_173 * fragment_input_1.x, (fragment_unnamed_173 * (fragment_unnamed_191 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_446));
				float fragment_unnamed_463 = mad(fragment_unnamed_454, fragment_unnamed_248, mad(fragment_unnamed_443, fragment_unnamed_173 * fragment_input_1.y, (fragment_unnamed_173 * (fragment_unnamed_191 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_446));
				float fragment_unnamed_464 = mad(fragment_unnamed_454, fragment_unnamed_249, mad(fragment_unnamed_443, fragment_unnamed_173 * fragment_input_1.z, (fragment_unnamed_173 * (fragment_unnamed_191 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_446));
				float fragment_unnamed_469 = rsqrt(max(dot(float3(fragment_unnamed_462, fragment_unnamed_463, fragment_unnamed_464), float3(fragment_unnamed_462, fragment_unnamed_463, fragment_unnamed_464)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_470 = fragment_unnamed_462 * fragment_unnamed_469;
				float fragment_unnamed_471 = fragment_unnamed_463 * fragment_unnamed_469;
				float fragment_unnamed_472 = fragment_unnamed_464 * fragment_unnamed_469;
				float fragment_unnamed_658;
				float fragment_unnamed_660;
				float fragment_unnamed_662;
				float fragment_unnamed_664;
				float fragment_unnamed_666;
				float fragment_unnamed_668;
				float fragment_unnamed_670;
				if (asuint(fragment_uniform_buffer_1[210u]).z != 0u)
				{
					uint fragment_unnamed_484 = asuint(fragment_uniform_buffer_2[10u]).x & 65535u;
					float fragment_unnamed_507 = asfloat((asuint(fragment_uniform_buffer_1[127u]).w != 0u) ? T4.Load((fragment_unnamed_282 * asuint(fragment_uniform_buffer_1[128u]).x) + fragment_unnamed_280).x : asuint(fragment_uniform_buffer_1[126u]).w);
					uint4 fragment_unnamed_510 = asuint(fragment_uniform_buffer_1[127u]);
					uint fragment_unnamed_511 = fragment_unnamed_510.z;
					uint fragment_unnamed_514 = 1u << (fragment_unnamed_511 & 31u);
					uint4 fragment_unnamed_564 = T3.Load(((((uint(int(min(float(int(fragment_unnamed_514 + 4294967295u)), max(log2(mad(max((1.0f / gl_FragCoord.w) + ((-0.0f) - fragment_uniform_buffer_1[127u].x), 0.0f) / (((-0.0f) - fragment_uniform_buffer_1[127u].x) + fragment_uniform_buffer_1[127u].y), exp2(float(int(fragment_unnamed_514)) * log2(abs(fragment_unnamed_507))) + (-1.0f), 1.0f)) / log2(fragment_unnamed_507), 0.0f)))) + (3u << (fragment_unnamed_511 & 31u))) * asuint(fragment_uniform_buffer_1[128u]).y) + fragment_unnamed_282) * asuint(fragment_uniform_buffer_1[128u]).x) + fragment_unnamed_280);
					uint fragment_unnamed_565 = fragment_unnamed_564.x;
					uint fragment_unnamed_566 = fragment_unnamed_565 & 67108863u;
					uint fragment_unnamed_568 = fragment_unnamed_565 >> 26u;
					float fragment_unnamed_576 = ddx_coarse(fragment_input_6.x);
					float fragment_unnamed_577 = ddx_coarse(fragment_input_6.y);
					float fragment_unnamed_578 = ddx_coarse(fragment_input_6.z);
					float fragment_unnamed_585 = ddy_coarse(fragment_input_6.x);
					float fragment_unnamed_586 = ddy_coarse(fragment_input_6.y);
					float fragment_unnamed_587 = ddy_coarse(fragment_input_6.z);
					float fragment_unnamed_592 = 0.5f / fragment_uniform_buffer_1[210u].x;
					float fragment_unnamed_594 = 0.5f / fragment_uniform_buffer_1[210u].y;
					uint4 fragment_unnamed_598 = asuint(fragment_uniform_buffer_1[48u]);
					float fragment_unnamed_600 = asfloat(fragment_unnamed_598.x);
					float fragment_unnamed_602 = asfloat(fragment_unnamed_598.y);
					float fragment_unnamed_604 = asfloat(fragment_unnamed_598.z);
					float fragment_unnamed_605 = asfloat(1065353216u);
					float fragment_unnamed_612 = asfloat(1065353216u);
					uint4 fragment_unnamed_626 = asuint(fragment_uniform_buffer_1[128u]);
					uint fragment_unnamed_627 = fragment_unnamed_626.w;
					float fragment_unnamed_628 = asfloat(0u);
					float fragment_unnamed_634;
					float fragment_unnamed_636;
					float fragment_unnamed_638;
					float fragment_unnamed_640;
					float fragment_unnamed_642;
					float fragment_unnamed_644;
					float fragment_unnamed_646;
					float fragment_unnamed_648;
					float fragment_unnamed_650;
					float fragment_unnamed_652;
					fragment_unnamed_634 = asfloat(0u);
					fragment_unnamed_636 = asfloat(0u);
					fragment_unnamed_638 = asfloat(0u);
					fragment_unnamed_640 = asfloat(1065353216u);
					fragment_unnamed_642 = asfloat(1056964608u);
					fragment_unnamed_644 = asfloat(1056964608u);
					fragment_unnamed_646 = asfloat(1056964608u);
					fragment_unnamed_648 = asfloat(1065353216u);
					fragment_unnamed_650 = asfloat(0u);
					fragment_unnamed_652 = asfloat(1065353216u);
					float fragment_unnamed_655;
					float fragment_unnamed_635;
					float fragment_unnamed_637;
					float fragment_unnamed_639;
					float fragment_unnamed_641;
					float fragment_unnamed_643;
					float fragment_unnamed_645;
					float fragment_unnamed_647;
					float fragment_unnamed_649;
					float fragment_unnamed_651;
					float fragment_unnamed_653;
					for (float fragment_unnamed_654 = fragment_unnamed_628; !(asuint(fragment_unnamed_654) >= fragment_unnamed_568); fragment_unnamed_634 = fragment_unnamed_635, fragment_unnamed_636 = fragment_unnamed_637, fragment_unnamed_638 = fragment_unnamed_639, fragment_unnamed_640 = fragment_unnamed_641, fragment_unnamed_642 = fragment_unnamed_643, fragment_unnamed_644 = fragment_unnamed_645, fragment_unnamed_646 = fragment_unnamed_647, fragment_unnamed_648 = fragment_unnamed_649, fragment_unnamed_650 = fragment_unnamed_651, fragment_unnamed_652 = fragment_unnamed_653, fragment_unnamed_654 = fragment_unnamed_655)
					{
						uint4 fragment_unnamed_711 = T2.Load(fragment_unnamed_566 + asuint(fragment_unnamed_654));
						uint fragment_unnamed_712 = fragment_unnamed_711.x;
						if (!(fragment_unnamed_712 == 4294967295u))
						{
							fragment_unnamed_655 = asfloat(asuint(fragment_unnamed_654) + 1u);
							uint fragment_unnamed_976 = (fragment_unnamed_712 * 60u) + 58u;
							uint2 fragment_unnamed_983 = uint2(T12.Load(fragment_unnamed_976).x, T12.Load(fragment_unnamed_976 + 1u).x);
							uint fragment_unnamed_988 = (fragment_unnamed_627 != 0u) ? 4294967295u : 0u;
							if (!((fragment_unnamed_988 & (((fragment_unnamed_484 & fragment_unnamed_983.y) == 0u) ? 4294967295u : 0u)) == 0u))
							{
								fragment_unnamed_635 = fragment_unnamed_634;
								fragment_unnamed_637 = fragment_unnamed_636;
								fragment_unnamed_639 = fragment_unnamed_638;
								fragment_unnamed_641 = fragment_unnamed_640;
								fragment_unnamed_643 = fragment_unnamed_642;
								fragment_unnamed_645 = fragment_unnamed_644;
								fragment_unnamed_647 = fragment_unnamed_646;
								fragment_unnamed_649 = fragment_unnamed_648;
								fragment_unnamed_651 = fragment_unnamed_650;
								fragment_unnamed_653 = fragment_unnamed_652;
								continue;
							}
							uint fragment_unnamed_1218 = fragment_unnamed_712 * 60u;
							uint3 fragment_unnamed_1228 = uint3(T12.Load(fragment_unnamed_1218).x, T12.Load(fragment_unnamed_1218 + 1u).x, T12.Load(fragment_unnamed_1218 + 2u).x);
							uint fragment_unnamed_1233 = (fragment_unnamed_712 * 60u) + 4u;
							uint3 fragment_unnamed_1242 = uint3(T12.Load(fragment_unnamed_1233).x, T12.Load(fragment_unnamed_1233 + 1u).x, T12.Load(fragment_unnamed_1233 + 2u).x);
							uint fragment_unnamed_1248 = (fragment_unnamed_712 * 60u) + 8u;
							uint3 fragment_unnamed_1257 = uint3(T12.Load(fragment_unnamed_1248).x, T12.Load(fragment_unnamed_1248 + 1u).x, T12.Load(fragment_unnamed_1248 + 2u).x);
							uint fragment_unnamed_1263 = (fragment_unnamed_712 * 60u) + 12u;
							uint3 fragment_unnamed_1272 = uint3(T12.Load(fragment_unnamed_1263).x, T12.Load(fragment_unnamed_1263 + 1u).x, T12.Load(fragment_unnamed_1263 + 2u).x);
							float fragment_unnamed_1277 = asfloat(fragment_unnamed_1228.x);
							float fragment_unnamed_1278 = asfloat(fragment_unnamed_1242.x);
							float fragment_unnamed_1279 = asfloat(fragment_unnamed_1257.x);
							float fragment_unnamed_1284 = asfloat(fragment_unnamed_1228.y);
							float fragment_unnamed_1285 = asfloat(fragment_unnamed_1242.y);
							float fragment_unnamed_1286 = asfloat(fragment_unnamed_1257.y);
							float fragment_unnamed_1291 = asfloat(fragment_unnamed_1228.z);
							float fragment_unnamed_1292 = asfloat(fragment_unnamed_1242.z);
							float fragment_unnamed_1293 = asfloat(fragment_unnamed_1257.z);
							float fragment_unnamed_1306 = mad(dot(float4(fragment_unnamed_1277, fragment_unnamed_1278, fragment_unnamed_1279, dot(float4(fragment_unnamed_1277, fragment_unnamed_1278, fragment_unnamed_1279, asfloat(fragment_unnamed_1272.x)), float4(fragment_unnamed_600, fragment_unnamed_602, fragment_unnamed_604, fragment_unnamed_605))), float4(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z, fragment_unnamed_612)), 1.0f, 0.5f);
							float fragment_unnamed_1307 = mad(dot(float4(fragment_unnamed_1284, fragment_unnamed_1285, fragment_unnamed_1286, dot(float4(fragment_unnamed_1284, fragment_unnamed_1285, fragment_unnamed_1286, asfloat(fragment_unnamed_1272.y)), float4(fragment_unnamed_600, fragment_unnamed_602, fragment_unnamed_604, fragment_unnamed_605))), float4(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z, fragment_unnamed_612)), -1.0f, 0.5f);
							float fragment_unnamed_1308 = mad(dot(float4(fragment_unnamed_1291, fragment_unnamed_1292, fragment_unnamed_1293, dot(float4(fragment_unnamed_1291, fragment_unnamed_1292, fragment_unnamed_1293, asfloat(fragment_unnamed_1272.z)), float4(fragment_unnamed_600, fragment_unnamed_602, fragment_unnamed_604, fragment_unnamed_605))), float4(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z, fragment_unnamed_612)), 1.0f, 0.5f);
							float fragment_unnamed_1333;
							float fragment_unnamed_1334;
							float fragment_unnamed_1335;
							float fragment_unnamed_1336;
							float fragment_unnamed_1337;
							float fragment_unnamed_1338;
							float fragment_unnamed_1339;
							float fragment_unnamed_1340;
							float fragment_unnamed_1341;
							float fragment_unnamed_1342;
							if (((((0.0f < fragment_unnamed_1308) ? 4294967295u : 0u) & (((0.0f < fragment_unnamed_1307) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1306) ? 4294967295u : 0u))) & (((0.0f < (((-0.0f) - fragment_unnamed_1308) + 1.0f)) ? 4294967295u : 0u) & (((0.0f < (((-0.0f) - fragment_unnamed_1307) + 1.0f)) ? 4294967295u : 0u) & ((0.0f < (((-0.0f) - fragment_unnamed_1306) + 1.0f)) ? 4294967295u : 0u)))) != 0u)
							{
								uint fragment_unnamed_1403 = (fragment_unnamed_712 * 60u) + 16u;
								uint4 fragment_unnamed_1415 = uint4(T12.Load(fragment_unnamed_1403).x, T12.Load(fragment_unnamed_1403 + 1u).x, T12.Load(fragment_unnamed_1403 + 2u).x, T12.Load(fragment_unnamed_1403 + 3u).x);
								uint fragment_unnamed_1421 = (fragment_unnamed_712 * 60u) + 20u;
								uint4 fragment_unnamed_1433 = uint4(T12.Load(fragment_unnamed_1421).x, T12.Load(fragment_unnamed_1421 + 1u).x, T12.Load(fragment_unnamed_1421 + 2u).x, T12.Load(fragment_unnamed_1421 + 3u).x);
								uint fragment_unnamed_1439 = (fragment_unnamed_712 * 60u) + 24u;
								uint4 fragment_unnamed_1451 = uint4(T12.Load(fragment_unnamed_1439).x, T12.Load(fragment_unnamed_1439 + 1u).x, T12.Load(fragment_unnamed_1439 + 2u).x, T12.Load(fragment_unnamed_1439 + 3u).x);
								uint fragment_unnamed_1452 = fragment_unnamed_1451.x;
								uint fragment_unnamed_1454 = fragment_unnamed_1451.y;
								float fragment_unnamed_1457 = asfloat(fragment_unnamed_1451.z);
								uint fragment_unnamed_1460 = (fragment_unnamed_712 * 60u) + 28u;
								uint4 fragment_unnamed_1472 = uint4(T12.Load(fragment_unnamed_1460).x, T12.Load(fragment_unnamed_1460 + 1u).x, T12.Load(fragment_unnamed_1460 + 2u).x, T12.Load(fragment_unnamed_1460 + 3u).x);
								uint fragment_unnamed_1473 = fragment_unnamed_1472.x;
								float fragment_unnamed_1476 = asfloat(fragment_unnamed_1472.y);
								uint fragment_unnamed_1482 = (fragment_unnamed_712 * 60u) + 32u;
								uint4 fragment_unnamed_1494 = uint4(T12.Load(fragment_unnamed_1482).x, T12.Load(fragment_unnamed_1482 + 1u).x, T12.Load(fragment_unnamed_1482 + 2u).x, T12.Load(fragment_unnamed_1482 + 3u).x);
								float fragment_unnamed_1496 = asfloat(fragment_unnamed_1494.x);
								float fragment_unnamed_1498 = asfloat(fragment_unnamed_1494.y);
								float fragment_unnamed_1500 = asfloat(fragment_unnamed_1494.z);
								float fragment_unnamed_1502 = asfloat(fragment_unnamed_1494.w);
								uint fragment_unnamed_1504 = (fragment_unnamed_712 * 60u) + 44u;
								uint4 fragment_unnamed_1516 = uint4(T12.Load(fragment_unnamed_1504).x, T12.Load(fragment_unnamed_1504 + 1u).x, T12.Load(fragment_unnamed_1504 + 2u).x, T12.Load(fragment_unnamed_1504 + 3u).x);
								float fragment_unnamed_1518 = asfloat(fragment_unnamed_1516.x);
								float fragment_unnamed_1520 = asfloat(fragment_unnamed_1516.y);
								float fragment_unnamed_1522 = asfloat(fragment_unnamed_1516.z);
								float fragment_unnamed_1524 = asfloat(fragment_unnamed_1516.w);
								uint fragment_unnamed_1527 = (fragment_unnamed_712 * 60u) + 54u;
								uint4 fragment_unnamed_1539 = uint4(T12.Load(fragment_unnamed_1527).x, T12.Load(fragment_unnamed_1527 + 1u).x, T12.Load(fragment_unnamed_1527 + 2u).x, T12.Load(fragment_unnamed_1527 + 3u).x);
								float fragment_unnamed_1554 = frac(mad(fragment_unnamed_1306, asfloat(fragment_unnamed_1415.w), asfloat(fragment_unnamed_1451.w)));
								float fragment_unnamed_1555 = frac(mad(fragment_unnamed_1308, asfloat(fragment_unnamed_1433.w), asfloat(fragment_unnamed_1472.w)));
								float fragment_unnamed_1556 = dot(float3(fragment_unnamed_1277, fragment_unnamed_1278, fragment_unnamed_1279), float3(fragment_unnamed_576, fragment_unnamed_577, fragment_unnamed_578));
								float fragment_unnamed_1559 = dot(float3(fragment_unnamed_1291, fragment_unnamed_1292, fragment_unnamed_1293), float3(fragment_unnamed_576, fragment_unnamed_577, fragment_unnamed_578));
								float fragment_unnamed_1562 = dot(float3(fragment_unnamed_1277, fragment_unnamed_1278, fragment_unnamed_1279), float3(fragment_unnamed_585, fragment_unnamed_586, fragment_unnamed_587));
								float fragment_unnamed_1565 = dot(float3(fragment_unnamed_1291, fragment_unnamed_1292, fragment_unnamed_1293), float3(fragment_unnamed_585, fragment_unnamed_586, fragment_unnamed_587));
								uint fragment_unnamed_1569 = uint(int(asfloat(fragment_unnamed_983.x) + 0.5f));
								float fragment_unnamed_1573 = dot(float3(fragment_unnamed_247, fragment_unnamed_248, fragment_unnamed_249), float3(asfloat(fragment_unnamed_1452), asfloat(fragment_unnamed_1454), fragment_unnamed_1457));
								float fragment_unnamed_1585 = asfloat(((fragment_unnamed_988 & ((0.0f < fragment_unnamed_1476) ? 4294967295u : 0u)) != 0u) ? asuint(clamp(mad(fragment_unnamed_1573 * mad(fragment_unnamed_1573, fragment_unnamed_1573, 1.25f), fragment_unnamed_1476, asfloat(fragment_unnamed_1472.z)), 0.0f, 1.0f) * asfloat(fragment_unnamed_1473)) : fragment_unnamed_1473);
								float fragment_unnamed_1586 = asfloat(fragment_unnamed_1539.x) * fragment_unnamed_1585;
								float fragment_unnamed_1863;
								float fragment_unnamed_1864;
								float fragment_unnamed_1865;
								float fragment_unnamed_1866;
								if ((((0.0f < fragment_unnamed_1498) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1496) ? 4294967295u : 0u)) != 0u)
								{
									float fragment_unnamed_1833 = (fragment_unnamed_1496 * fragment_unnamed_1556) * fragment_uniform_buffer_1[210u].x;
									float fragment_unnamed_1834 = (fragment_unnamed_1498 * fragment_unnamed_1559) * fragment_uniform_buffer_1[210u].y;
									float fragment_unnamed_1835 = (fragment_unnamed_1496 * fragment_unnamed_1562) * fragment_uniform_buffer_1[210u].x;
									float fragment_unnamed_1836 = (fragment_unnamed_1498 * fragment_unnamed_1565) * fragment_uniform_buffer_1[210u].y;
									float4 fragment_unnamed_1853 = _DecalAtlas2D.SampleLevel(S4, float2(min(((-0.0f) - fragment_unnamed_592) + (fragment_unnamed_1496 + fragment_unnamed_1500), max(fragment_unnamed_592 + fragment_unnamed_1500, mad(fragment_unnamed_1554, fragment_unnamed_1496, fragment_unnamed_1500))), min(((-0.0f) - fragment_unnamed_594) + (fragment_unnamed_1498 + fragment_unnamed_1502), max(fragment_unnamed_594 + fragment_unnamed_1502, mad(fragment_unnamed_1555, fragment_unnamed_1498, fragment_unnamed_1502)))), max(mad(log2(max(dot(float2(fragment_unnamed_1833, fragment_unnamed_1834), float2(fragment_unnamed_1833, fragment_unnamed_1834)), dot(float2(fragment_unnamed_1835, fragment_unnamed_1836), float2(fragment_unnamed_1835, fragment_unnamed_1836)))), 0.5f, -0.5f), 0.0f) + fragment_uniform_buffer_1[86u].y);
									fragment_unnamed_1863 = fragment_unnamed_1853.x * fragment_unnamed_1518;
									fragment_unnamed_1864 = fragment_unnamed_1853.y * fragment_unnamed_1520;
									fragment_unnamed_1865 = fragment_unnamed_1853.z * fragment_unnamed_1522;
									fragment_unnamed_1866 = fragment_unnamed_1853.w * fragment_unnamed_1524;
								}
								else
								{
									fragment_unnamed_1863 = fragment_unnamed_1518;
									fragment_unnamed_1864 = fragment_unnamed_1520;
									fragment_unnamed_1865 = fragment_unnamed_1522;
									fragment_unnamed_1866 = fragment_unnamed_1524;
								}
								float fragment_unnamed_1867 = fragment_unnamed_1585 * fragment_unnamed_1866;
								uint fragment_unnamed_1869 = fragment_unnamed_1569 & 16u;
								float fragment_unnamed_1872 = mad((-0.0f) - fragment_unnamed_1866, fragment_unnamed_1585, 1.0f);
								bool fragment_unnamed_1880 = (fragment_unnamed_1569 & 1u) != 0u;
								float fragment_unnamed_1601;
								float fragment_unnamed_1602;
								float fragment_unnamed_1970;
								if (fragment_unnamed_1869 != 0u)
								{
									uint fragment_unnamed_1931 = (fragment_unnamed_712 * 60u) + 40u;
									uint4 fragment_unnamed_1943 = uint4(T12.Load(fragment_unnamed_1931).x, T12.Load(fragment_unnamed_1931 + 1u).x, T12.Load(fragment_unnamed_1931 + 2u).x, T12.Load(fragment_unnamed_1931 + 3u).x);
									float fragment_unnamed_1945 = asfloat(fragment_unnamed_1943.x);
									float fragment_unnamed_1947 = asfloat(fragment_unnamed_1943.y);
									float fragment_unnamed_1949 = asfloat(fragment_unnamed_1943.z);
									float fragment_unnamed_1951 = asfloat(fragment_unnamed_1943.w);
									uint fragment_unnamed_1953 = (fragment_unnamed_712 * 60u) + 50u;
									uint2 fragment_unnamed_1959 = uint2(T12.Load(fragment_unnamed_1953).x, T12.Load(fragment_unnamed_1953 + 1u).x);
									float fragment_unnamed_1961 = asfloat(fragment_unnamed_1959.x);
									float fragment_unnamed_1971;
									float fragment_unnamed_2128;
									if ((((0.0f < fragment_unnamed_1947) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1945) ? 4294967295u : 0u)) != 0u)
									{
										float fragment_unnamed_2097 = (fragment_unnamed_1945 * fragment_unnamed_1556) * fragment_uniform_buffer_1[210u].x;
										float fragment_unnamed_2098 = (fragment_unnamed_1947 * fragment_unnamed_1559) * fragment_uniform_buffer_1[210u].y;
										float fragment_unnamed_2103 = (fragment_unnamed_1562 * fragment_unnamed_1945) * fragment_uniform_buffer_1[210u].x;
										float fragment_unnamed_2104 = (fragment_unnamed_1565 * fragment_unnamed_1947) * fragment_uniform_buffer_1[210u].y;
										float4 fragment_unnamed_2120 = _DecalAtlas2D.SampleLevel(S4, float2(min(((-0.0f) - fragment_unnamed_592) + (fragment_unnamed_1945 + fragment_unnamed_1949), max(fragment_unnamed_592 + fragment_unnamed_1949, mad(fragment_unnamed_1554, fragment_unnamed_1945, fragment_unnamed_1949))), min(((-0.0f) - fragment_unnamed_594) + (fragment_unnamed_1947 + fragment_unnamed_1951), max(fragment_unnamed_594 + fragment_unnamed_1951, mad(fragment_unnamed_1555, fragment_unnamed_1947, fragment_unnamed_1951)))), max(mad(log2(max(dot(float2(fragment_unnamed_2097, fragment_unnamed_2098), float2(fragment_unnamed_2097, fragment_unnamed_2098)), dot(float2(fragment_unnamed_2103, fragment_unnamed_2104), float2(fragment_unnamed_2103, fragment_unnamed_2104)))), 0.5f, -0.5f), 0.0f) + fragment_uniform_buffer_1[86u].y);
										fragment_unnamed_1971 = fragment_unnamed_1586 * fragment_unnamed_2120.z;
										fragment_unnamed_2128 = mad(fragment_unnamed_2120.w, ((-0.0f) - fragment_unnamed_1961) + asfloat(fragment_unnamed_1959.y), fragment_unnamed_1961);
									}
									else
									{
										fragment_unnamed_1971 = fragment_unnamed_1586;
										fragment_unnamed_2128 = fragment_unnamed_1961;
									}
									float fragment_unnamed_2133 = asfloat((asfloat(fragment_unnamed_1539.w) == 1.0f) ? asuint(fragment_unnamed_1971) : asuint(fragment_unnamed_1867));
									float fragment_unnamed_2135 = ((-0.0f) - fragment_unnamed_2133) + 1.0f;
									fragment_unnamed_1970 = fragment_unnamed_1971;
									fragment_unnamed_1601 = asfloat((fragment_unnamed_1869 != 0u) ? asuint(mad(fragment_unnamed_2128, fragment_unnamed_2133, fragment_unnamed_2135 * fragment_unnamed_650)) : asuint(fragment_unnamed_650));
									fragment_unnamed_1602 = asfloat((fragment_unnamed_1869 != 0u) ? asuint(fragment_unnamed_2135 * fragment_unnamed_652) : asuint(fragment_unnamed_652));
								}
								else
								{
									fragment_unnamed_1970 = fragment_unnamed_1586;
									fragment_unnamed_1601 = fragment_unnamed_650;
									fragment_unnamed_1602 = fragment_unnamed_652;
								}
								float fragment_unnamed_1597;
								float fragment_unnamed_1598;
								float fragment_unnamed_1599;
								float fragment_unnamed_1600;
								if ((fragment_unnamed_1569 & 2u) != 0u)
								{
									uint fragment_unnamed_2149 = (fragment_unnamed_712 * 60u) + 36u;
									uint4 fragment_unnamed_2161 = uint4(T12.Load(fragment_unnamed_2149).x, T12.Load(fragment_unnamed_2149 + 1u).x, T12.Load(fragment_unnamed_2149 + 2u).x, T12.Load(fragment_unnamed_2149 + 3u).x);
									float fragment_unnamed_2163 = asfloat(fragment_unnamed_2161.x);
									float fragment_unnamed_2165 = asfloat(fragment_unnamed_2161.y);
									float fragment_unnamed_2167 = asfloat(fragment_unnamed_2161.z);
									float fragment_unnamed_2169 = asfloat(fragment_unnamed_2161.w);
									float fragment_unnamed_2815;
									float fragment_unnamed_2816;
									float fragment_unnamed_2817;
									float fragment_unnamed_2818;
									if ((((0.0f < fragment_unnamed_2165) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_2163) ? 4294967295u : 0u)) != 0u)
									{
										float fragment_unnamed_2412 = (fragment_unnamed_2163 * fragment_unnamed_1556) * fragment_uniform_buffer_1[210u].x;
										float fragment_unnamed_2413 = (fragment_unnamed_2165 * fragment_unnamed_1559) * fragment_uniform_buffer_1[210u].y;
										float fragment_unnamed_2418 = (fragment_unnamed_2163 * fragment_unnamed_1562) * fragment_uniform_buffer_1[210u].x;
										float fragment_unnamed_2419 = (fragment_unnamed_2165 * fragment_unnamed_1565) * fragment_uniform_buffer_1[210u].y;
										float4 fragment_unnamed_2435 = _DecalAtlas2D.SampleLevel(S4, float2(min(((-0.0f) - fragment_unnamed_592) + (fragment_unnamed_2163 + fragment_unnamed_2167), max(fragment_unnamed_592 + fragment_unnamed_2167, mad(fragment_unnamed_1554, fragment_unnamed_2163, fragment_unnamed_2167))), min(((-0.0f) - fragment_unnamed_594) + (fragment_unnamed_2165 + fragment_unnamed_2169), max(fragment_unnamed_594 + fragment_unnamed_2169, mad(fragment_unnamed_1555, fragment_unnamed_2165, fragment_unnamed_2169)))), max(mad(log2(max(dot(float2(fragment_unnamed_2412, fragment_unnamed_2413), float2(fragment_unnamed_2412, fragment_unnamed_2413)), dot(float2(fragment_unnamed_2418, fragment_unnamed_2419), float2(fragment_unnamed_2418, fragment_unnamed_2419)))), 0.5f, -0.5f), 0.0f) + fragment_uniform_buffer_1[86u].y);
										float fragment_unnamed_2442 = mad(fragment_unnamed_2435.x * fragment_unnamed_2435.w, 2.0f, -1.0f);
										float fragment_unnamed_2443 = mad(fragment_unnamed_2435.y, 2.0f, -1.0f);
										fragment_unnamed_2815 = fragment_unnamed_2435.z;
										fragment_unnamed_2816 = fragment_unnamed_2442;
										fragment_unnamed_2817 = fragment_unnamed_2443;
										fragment_unnamed_2818 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_2442, fragment_unnamed_2443), float2(fragment_unnamed_2442, fragment_unnamed_2443)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
									}
									else
									{
										fragment_unnamed_2815 = asfloat(0u);
										fragment_unnamed_2816 = asfloat(0u);
										fragment_unnamed_2817 = asfloat(0u);
										fragment_unnamed_2818 = asfloat(1065353216u);
									}
									float fragment_unnamed_2846 = asfloat((asfloat(fragment_unnamed_1539.y) == 1.0f) ? asuint(fragment_unnamed_2815) : ((asfloat(fragment_unnamed_1539.z) == 1.0f) ? asuint(fragment_unnamed_1970) : asuint(fragment_unnamed_1867)));
									float fragment_unnamed_2848 = ((-0.0f) - fragment_unnamed_2846) + 1.0f;
									fragment_unnamed_1597 = mad(mad(dot(float3(asfloat(fragment_unnamed_1415.x), asfloat(fragment_unnamed_1433.x), asfloat(fragment_unnamed_1452)), float3(fragment_unnamed_2816, fragment_unnamed_2817, fragment_unnamed_2818)), 0.5f, 0.5f), fragment_unnamed_2846, fragment_unnamed_2848 * fragment_unnamed_642);
									fragment_unnamed_1598 = mad(mad(dot(float3(asfloat(fragment_unnamed_1415.y), asfloat(fragment_unnamed_1433.y), asfloat(fragment_unnamed_1454)), float3(fragment_unnamed_2816, fragment_unnamed_2817, fragment_unnamed_2818)), 0.5f, 0.5f), fragment_unnamed_2846, fragment_unnamed_2848 * fragment_unnamed_644);
									fragment_unnamed_1599 = mad(mad(dot(float3(asfloat(fragment_unnamed_1415.z), asfloat(fragment_unnamed_1433.z), fragment_unnamed_1457), float3(fragment_unnamed_2816, fragment_unnamed_2817, fragment_unnamed_2818)), 0.5f, 0.5f), fragment_unnamed_2846, fragment_unnamed_2848 * fragment_unnamed_646);
									fragment_unnamed_1600 = fragment_unnamed_2848 * fragment_unnamed_648;
								}
								else
								{
									fragment_unnamed_1597 = fragment_unnamed_642;
									fragment_unnamed_1598 = fragment_unnamed_644;
									fragment_unnamed_1599 = fragment_unnamed_646;
									fragment_unnamed_1600 = fragment_unnamed_648;
								}
								fragment_unnamed_1333 = asfloat(fragment_unnamed_1880 ? asuint(mad(fragment_unnamed_1863, fragment_unnamed_1867, fragment_unnamed_1872 * fragment_unnamed_634)) : asuint(fragment_unnamed_634));
								fragment_unnamed_1334 = asfloat(fragment_unnamed_1880 ? asuint(mad(fragment_unnamed_1864, fragment_unnamed_1867, fragment_unnamed_1872 * fragment_unnamed_636)) : asuint(fragment_unnamed_636));
								fragment_unnamed_1335 = asfloat(fragment_unnamed_1880 ? asuint(mad(fragment_unnamed_1865, fragment_unnamed_1867, fragment_unnamed_1872 * fragment_unnamed_638)) : asuint(fragment_unnamed_638));
								fragment_unnamed_1336 = asfloat(fragment_unnamed_1880 ? asuint(fragment_unnamed_1872 * fragment_unnamed_640) : asuint(fragment_unnamed_640));
								fragment_unnamed_1337 = fragment_unnamed_1597;
								fragment_unnamed_1338 = fragment_unnamed_1598;
								fragment_unnamed_1339 = fragment_unnamed_1599;
								fragment_unnamed_1340 = fragment_unnamed_1600;
								fragment_unnamed_1341 = fragment_unnamed_1601;
								fragment_unnamed_1342 = fragment_unnamed_1602;
							}
							else
							{
								fragment_unnamed_1333 = fragment_unnamed_634;
								fragment_unnamed_1334 = fragment_unnamed_636;
								fragment_unnamed_1335 = fragment_unnamed_638;
								fragment_unnamed_1336 = fragment_unnamed_640;
								fragment_unnamed_1337 = fragment_unnamed_642;
								fragment_unnamed_1338 = fragment_unnamed_644;
								fragment_unnamed_1339 = fragment_unnamed_646;
								fragment_unnamed_1340 = fragment_unnamed_648;
								fragment_unnamed_1341 = fragment_unnamed_650;
								fragment_unnamed_1342 = fragment_unnamed_652;
							}
							fragment_unnamed_635 = fragment_unnamed_1333;
							fragment_unnamed_637 = fragment_unnamed_1334;
							fragment_unnamed_639 = fragment_unnamed_1335;
							fragment_unnamed_641 = fragment_unnamed_1336;
							fragment_unnamed_643 = fragment_unnamed_1337;
							fragment_unnamed_645 = fragment_unnamed_1338;
							fragment_unnamed_647 = fragment_unnamed_1339;
							fragment_unnamed_649 = fragment_unnamed_1340;
							fragment_unnamed_651 = fragment_unnamed_1341;
							fragment_unnamed_653 = fragment_unnamed_1342;
							continue;
						}
						break;
					}
					bool fragment_unnamed_685 = fragment_unnamed_648 < 1.0f;
					float fragment_unnamed_686 = mad(fragment_unnamed_470, fragment_unnamed_648, mad(fragment_unnamed_642, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_687 = mad(fragment_unnamed_471, fragment_unnamed_648, mad(fragment_unnamed_644, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_688 = mad(fragment_unnamed_472, fragment_unnamed_648, mad(fragment_unnamed_646, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_693 = rsqrt(max(dot(float3(fragment_unnamed_686, fragment_unnamed_687, fragment_unnamed_688), float3(fragment_unnamed_686, fragment_unnamed_687, fragment_unnamed_688)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_658 = mad(fragment_unnamed_393, fragment_unnamed_640, fragment_unnamed_634);
					fragment_unnamed_660 = mad(fragment_unnamed_394, fragment_unnamed_640, fragment_unnamed_636);
					fragment_unnamed_662 = mad(fragment_unnamed_395, fragment_unnamed_640, fragment_unnamed_638);
					fragment_unnamed_664 = asfloat(fragment_unnamed_685 ? asuint(fragment_unnamed_686 * fragment_unnamed_693) : asuint(fragment_unnamed_470));
					fragment_unnamed_666 = asfloat(fragment_unnamed_685 ? asuint(fragment_unnamed_687 * fragment_unnamed_693) : asuint(fragment_unnamed_471));
					fragment_unnamed_668 = asfloat(fragment_unnamed_685 ? asuint(fragment_unnamed_688 * fragment_unnamed_693) : asuint(fragment_unnamed_472));
					fragment_unnamed_670 = mad(fragment_uniform_buffer_4[1u].x, fragment_unnamed_652, fragment_unnamed_650);
				}
				else
				{
					fragment_unnamed_658 = fragment_unnamed_393;
					fragment_unnamed_660 = fragment_unnamed_394;
					fragment_unnamed_662 = fragment_unnamed_395;
					fragment_unnamed_664 = fragment_unnamed_470;
					fragment_unnamed_666 = fragment_unnamed_471;
					fragment_unnamed_668 = fragment_unnamed_472;
					fragment_unnamed_670 = asfloat(asuint(fragment_uniform_buffer_4[1u]).x);
				}
				uint fragment_unnamed_676 = asuint(fragment_uniform_buffer_2[10u]).x & 65535u;
				float fragment_unnamed_994;
				float fragment_unnamed_995;
				float fragment_unnamed_996;
				if (fragment_uniform_buffer_2[22u].x == 0.0f)
				{
					float fragment_unnamed_714 = asfloat(1065353216u);
					float fragment_unnamed_743 = fragment_unnamed_666 * fragment_unnamed_664;
					float fragment_unnamed_744 = fragment_unnamed_668 * fragment_unnamed_666;
					float fragment_unnamed_745 = fragment_unnamed_668 * fragment_unnamed_668;
					float fragment_unnamed_746 = fragment_unnamed_664 * fragment_unnamed_668;
					float fragment_unnamed_778 = mad(fragment_unnamed_664, fragment_unnamed_664, (-0.0f) - (fragment_unnamed_666 * fragment_unnamed_666));
					fragment_unnamed_994 = dot(float4(fragment_uniform_buffer_2[15u]), float4(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668, fragment_unnamed_714)) + mad(fragment_uniform_buffer_2[19u].z, fragment_unnamed_778, dot(float4(fragment_uniform_buffer_2[18u]), float4(fragment_unnamed_743, fragment_unnamed_744, fragment_unnamed_745, fragment_unnamed_746)));
					fragment_unnamed_995 = dot(float4(fragment_uniform_buffer_2[14u]), float4(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668, fragment_unnamed_714)) + mad(fragment_uniform_buffer_2[19u].y, fragment_unnamed_778, dot(float4(fragment_uniform_buffer_2[17u]), float4(fragment_unnamed_743, fragment_unnamed_744, fragment_unnamed_745, fragment_unnamed_746)));
					fragment_unnamed_996 = dot(float4(fragment_uniform_buffer_2[13u]), float4(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668, fragment_unnamed_714)) + mad(fragment_uniform_buffer_2[19u].x, fragment_unnamed_778, dot(float4(fragment_uniform_buffer_2[16u]), float4(fragment_unnamed_743, fragment_unnamed_744, fragment_unnamed_745, fragment_unnamed_746)));
				}
				else
				{
					bool fragment_unnamed_794 = fragment_uniform_buffer_2[22u].y == 0.0f;
					bool fragment_unnamed_795 = fragment_uniform_buffer_2[22u].y == 1.0f;
					float fragment_unnamed_816 = fragment_unnamed_794 ? (fragment_input_6.x + fragment_uniform_buffer_1[48u].x) : fragment_input_6.x;
					float fragment_unnamed_817 = fragment_unnamed_794 ? (fragment_input_6.y + fragment_uniform_buffer_1[48u].y) : fragment_input_6.y;
					float fragment_unnamed_818 = fragment_unnamed_794 ? (fragment_input_6.z + fragment_uniform_buffer_1[48u].z) : fragment_input_6.z;
					float fragment_unnamed_920 = (asfloat(fragment_unnamed_795 ? asuint((mad(fragment_uniform_buffer_2[25u].y, fragment_uniform_buffer_1[48u].z, mad(fragment_uniform_buffer_2[23u].y, fragment_uniform_buffer_1[48u].x, fragment_uniform_buffer_1[48u].y * fragment_uniform_buffer_2[24u].y)) + fragment_uniform_buffer_2[26u].y) + mad(fragment_uniform_buffer_2[25u].y, fragment_unnamed_818, mad(fragment_uniform_buffer_2[23u].y, fragment_unnamed_816, fragment_unnamed_817 * fragment_uniform_buffer_2[24u].y))) : asuint(fragment_unnamed_817)) + ((-0.0f) - fragment_uniform_buffer_2[28u].y)) * fragment_uniform_buffer_2[27u].y;
					float fragment_unnamed_921 = (asfloat(fragment_unnamed_795 ? asuint((mad(fragment_uniform_buffer_2[25u].z, fragment_uniform_buffer_1[48u].z, mad(fragment_uniform_buffer_2[23u].z, fragment_uniform_buffer_1[48u].x, fragment_uniform_buffer_1[48u].y * fragment_uniform_buffer_2[24u].z)) + fragment_uniform_buffer_2[26u].z) + mad(fragment_uniform_buffer_2[25u].z, fragment_unnamed_818, mad(fragment_uniform_buffer_2[23u].z, fragment_unnamed_816, fragment_unnamed_817 * fragment_uniform_buffer_2[24u].z))) : asuint(fragment_unnamed_818)) + ((-0.0f) - fragment_uniform_buffer_2[28u].z)) * fragment_uniform_buffer_2[27u].z;
					float fragment_unnamed_934 = min(mad((-0.0f) - fragment_uniform_buffer_2[22u].z, 0.5f, 0.25f), max(((asfloat(fragment_unnamed_795 ? asuint((mad(fragment_uniform_buffer_2[25u].x, fragment_uniform_buffer_1[48u].z, mad(fragment_uniform_buffer_2[23u].x, fragment_uniform_buffer_1[48u].x, fragment_uniform_buffer_1[48u].y * fragment_uniform_buffer_2[24u].x)) + fragment_uniform_buffer_2[26u].x) + mad(fragment_uniform_buffer_2[25u].x, fragment_unnamed_818, mad(fragment_uniform_buffer_2[23u].x, fragment_unnamed_816, fragment_unnamed_817 * fragment_uniform_buffer_2[24u].x))) : asuint(fragment_unnamed_816)) + ((-0.0f) - fragment_uniform_buffer_2[28u].x)) * fragment_uniform_buffer_2[27u].x) * 0.25f, fragment_uniform_buffer_2[22u].z * 0.5f));
					float fragment_unnamed_961 = asfloat(1065353216u);
					fragment_unnamed_994 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_934 + 0.5f, fragment_unnamed_920 + 0.0f, fragment_unnamed_921 + 0.0f), 0.0f)), float4(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668, fragment_unnamed_961));
					fragment_unnamed_995 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_934 + 0.25f, fragment_unnamed_920 + 0.0f, fragment_unnamed_921 + 0.0f), 0.0f)), float4(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668, fragment_unnamed_961));
					fragment_unnamed_996 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_934, fragment_unnamed_920, fragment_unnamed_921), 0.0f)), float4(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668, fragment_unnamed_961));
				}
				float fragment_unnamed_998 = ((-0.0f) - fragment_unnamed_670) + 1.0f;
				float fragment_unnamed_1003 = ((-0.0f) - fragment_uniform_buffer_4[1u].y) + 1.0f;
				float fragment_unnamed_1004 = fragment_unnamed_1003 * fragment_unnamed_658;
				float fragment_unnamed_1005 = fragment_unnamed_1003 * fragment_unnamed_660;
				float fragment_unnamed_1006 = fragment_unnamed_1003 * fragment_unnamed_662;
				float fragment_unnamed_1014 = mad(fragment_uniform_buffer_4[1u].y, fragment_unnamed_658 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1016 = mad(fragment_uniform_buffer_4[1u].y, fragment_unnamed_660 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1017 = mad(fragment_uniform_buffer_4[1u].y, fragment_unnamed_662 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1018 = dot(float3(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668), float3(fragment_unnamed_341, fragment_unnamed_342, fragment_unnamed_343));
				float fragment_unnamed_1021 = max(fragment_unnamed_1018, 9.9999997473787516355514526367188e-05f);
				float4 fragment_unnamed_1029 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_1021), 0.984375f, 0.0078125f), mad(fragment_unnamed_998, 0.984375f, 0.0078125f)), 0.0f);
				float fragment_unnamed_1031 = fragment_unnamed_1029.x;
				float fragment_unnamed_1032 = fragment_unnamed_1029.y;
				float fragment_unnamed_1034 = fragment_unnamed_1029.z + 0.5f;
				float fragment_unnamed_1046 = clamp((max(fragment_unnamed_1017, max(fragment_unnamed_1016, fragment_unnamed_1014)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_1[118u].w;
				uint4 fragment_unnamed_1065 = asuint(fragment_uniform_buffer_1[120u]);
				uint4 fragment_unnamed_1074 = asuint(fragment_uniform_buffer_1[120u]);
				float fragment_unnamed_1078 = asfloat(((fragment_unnamed_676 & fragment_unnamed_1065.y) != 0u) ? fragment_unnamed_1074.x : 1065353216u);
				float fragment_unnamed_1080 = asfloat(((fragment_unnamed_676 & fragment_unnamed_1065.w) != 0u) ? fragment_unnamed_1074.z : 1065353216u);
				float fragment_unnamed_1099 = asfloat((asuint(fragment_uniform_buffer_1[113u]).y == 1u) ? asuint(clamp(dot(float3(fragment_unnamed_1014, fragment_unnamed_1016, fragment_unnamed_1017), 0.333000004291534423828125f.xxx) * 50.0f, 0.0f, 1.0f)) : 1065353216u);
				float fragment_unnamed_1100 = fragment_unnamed_998 * fragment_unnamed_998;
				float fragment_unnamed_1110 = mad(((-0.0f) - fragment_unnamed_1014) + fragment_unnamed_1099, fragment_unnamed_1031, fragment_unnamed_1014 * fragment_unnamed_1032);
				float fragment_unnamed_1111 = mad(((-0.0f) - fragment_unnamed_1016) + fragment_unnamed_1099, fragment_unnamed_1031, fragment_unnamed_1016 * fragment_unnamed_1032);
				float fragment_unnamed_1112 = mad(((-0.0f) - fragment_unnamed_1017) + fragment_unnamed_1099, fragment_unnamed_1031, fragment_unnamed_1017 * fragment_unnamed_1032);
				float fragment_unnamed_1114 = (1.0f / fragment_unnamed_1032) + (-1.0f);
				float fragment_unnamed_1115 = fragment_unnamed_1100 * fragment_unnamed_1100;
				float fragment_unnamed_1119 = sqrt(mad(mad((-0.0f) - fragment_unnamed_1021, fragment_unnamed_1115, fragment_unnamed_1021), fragment_unnamed_1021, fragment_unnamed_1115));
				float fragment_unnamed_1120 = (-0.0f) - fragment_unnamed_341;
				float fragment_unnamed_1121 = (-0.0f) - fragment_unnamed_342;
				float fragment_unnamed_1122 = (-0.0f) - fragment_unnamed_343;
				float fragment_unnamed_1123 = dot(float3(fragment_unnamed_1120, fragment_unnamed_1121, fragment_unnamed_1122), float3(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668));
				float fragment_unnamed_1127 = (-0.0f) - (fragment_unnamed_1123 + fragment_unnamed_1123);
				float fragment_unnamed_1128 = mad(fragment_unnamed_664, fragment_unnamed_1127, fragment_unnamed_1120);
				float fragment_unnamed_1129 = mad(fragment_unnamed_666, fragment_unnamed_1127, fragment_unnamed_1121);
				float fragment_unnamed_1130 = mad(fragment_unnamed_668, fragment_unnamed_1127, fragment_unnamed_1122);
				float fragment_unnamed_1132 = ((-0.0f) - fragment_unnamed_1021) + 1.0f;
				float fragment_unnamed_1134 = mad(fragment_unnamed_998, 0.984375f, 0.0078125f);
				float fragment_unnamed_1135 = mad(sqrt(fragment_unnamed_1132), 0.984375f, 0.0078125f);
				float4 fragment_unnamed_1140 = _LtcData.SampleLevel(S0, float3(fragment_unnamed_1134, fragment_unnamed_1135, asfloat(1065353216u)), 0.0f);
				float fragment_unnamed_1142 = fragment_unnamed_1140.x;
				float fragment_unnamed_1143 = fragment_unnamed_1140.y;
				float fragment_unnamed_1144 = fragment_unnamed_1140.z;
				float fragment_unnamed_1145 = fragment_unnamed_1140.w;
				float4 fragment_unnamed_1146 = _LtcData.SampleLevel(S0, float3(fragment_unnamed_1134, fragment_unnamed_1135, asfloat(0u)), 0.0f);
				float fragment_unnamed_1148 = fragment_unnamed_1146.x;
				float fragment_unnamed_1149 = fragment_unnamed_1146.y;
				float fragment_unnamed_1150 = fragment_unnamed_1146.z;
				float fragment_unnamed_1151 = fragment_unnamed_1146.w;
				bool fragment_unnamed_1155 = 5.9604644775390625e-08f >= abs(((-0.0f) - fragment_unnamed_1018) + 1.0f);
				bool fragment_unnamed_1157 = fragment_unnamed_668 >= 0.0f;
				float fragment_unnamed_1159 = asfloat(fragment_unnamed_1157 ? 1065353216u : 3212836864u);
				float fragment_unnamed_1163 = 1.0f / (fragment_unnamed_668 + fragment_unnamed_1159);
				float fragment_unnamed_1164 = fragment_unnamed_666 * fragment_unnamed_1163;
				float fragment_unnamed_1165 = fragment_unnamed_664 * fragment_unnamed_1164;
				float fragment_unnamed_1167 = fragment_unnamed_664 * fragment_unnamed_1159;
				float fragment_unnamed_1177 = mad((-0.0f) - fragment_unnamed_664, fragment_unnamed_1018, fragment_unnamed_341);
				float fragment_unnamed_1178 = mad((-0.0f) - fragment_unnamed_666, fragment_unnamed_1018, fragment_unnamed_342);
				float fragment_unnamed_1179 = mad((-0.0f) - fragment_unnamed_668, fragment_unnamed_1018, fragment_unnamed_343);
				float fragment_unnamed_1183 = rsqrt(dot(float3(fragment_unnamed_1177, fragment_unnamed_1178, fragment_unnamed_1179), float3(fragment_unnamed_1177, fragment_unnamed_1178, fragment_unnamed_1179)));
				float fragment_unnamed_1184 = fragment_unnamed_1183 * fragment_unnamed_1177;
				float fragment_unnamed_1185 = fragment_unnamed_1183 * fragment_unnamed_1178;
				float fragment_unnamed_1186 = fragment_unnamed_1183 * fragment_unnamed_1179;
				uint fragment_unnamed_1201 = fragment_unnamed_1155 ? asuint(fragment_unnamed_1165) : asuint(mad(fragment_unnamed_666, fragment_unnamed_1186, (-0.0f) - (fragment_unnamed_668 * fragment_unnamed_1185)));
				uint fragment_unnamed_1202 = fragment_unnamed_1155 ? asuint(mad(fragment_unnamed_666, fragment_unnamed_1164, asfloat(fragment_unnamed_1157 ? 3212836864u : 1065353216u))) : asuint(mad(fragment_unnamed_668, fragment_unnamed_1184, (-0.0f) - (fragment_unnamed_664 * fragment_unnamed_1186)));
				float fragment_unnamed_1210 = asfloat(fragment_unnamed_1155 ? asuint(mad(fragment_unnamed_664 * fragment_unnamed_1167, fragment_unnamed_1163, -1.0f)) : asuint(fragment_unnamed_1184));
				uint fragment_unnamed_1211 = fragment_unnamed_1155 ? asuint(fragment_unnamed_666) : asuint(mad(fragment_unnamed_664, fragment_unnamed_1185, (-0.0f) - (fragment_unnamed_666 * fragment_unnamed_1184)));
				float fragment_unnamed_1692;
				float fragment_unnamed_1694;
				float fragment_unnamed_1696;
				if (int(asuint(fragment_uniform_buffer_1[116u]).z) >= int(0u))
				{
					uint fragment_unnamed_1349 = (asuint(fragment_uniform_buffer_1[116u]).z * 44u) + 4u;
					uint3 fragment_unnamed_1358 = uint3(T5.Load(fragment_unnamed_1349).x, T5.Load(fragment_unnamed_1349 + 1u).x, T5.Load(fragment_unnamed_1349 + 2u).x);
					float fragment_unnamed_1360 = asfloat(fragment_unnamed_1358.x);
					float fragment_unnamed_1362 = asfloat(fragment_unnamed_1358.y);
					float fragment_unnamed_1364 = asfloat(fragment_unnamed_1358.z);
					float fragment_unnamed_1693;
					float fragment_unnamed_1695;
					float fragment_unnamed_1697;
					if ((((0.0f < dot(float3(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668), float3((-0.0f) - fragment_unnamed_1360, (-0.0f) - fragment_unnamed_1362, (-0.0f) - fragment_unnamed_1364))) ? 4294967295u : 0u) & (((0.0f < asfloat(T5.Load((asuint(fragment_uniform_buffer_1[116u]).z * 44u) + 27u).x)) ? 4294967295u : 0u) & ((0.0f < asfloat(T5.Load((asuint(fragment_uniform_buffer_1[116u]).z * 44u) + 38u).x)) ? 4294967295u : 0u))) != 0u)
					{
						uint4 fragment_unnamed_1614 = uint4(T30.Load(0u).x, T30.Load(0u + 1u).x, T30.Load(0u + 2u).x, T30.Load(0u + 3u).x);
						float fragment_unnamed_1616 = asfloat(fragment_unnamed_1614.x);
						float fragment_unnamed_1618 = asfloat(fragment_unnamed_1614.y);
						float fragment_unnamed_1620 = asfloat(fragment_unnamed_1614.z);
						float fragment_unnamed_1622 = asfloat(fragment_unnamed_1614.w);
						uint4 fragment_unnamed_1634 = uint4(T30.Load(4u).x, T30.Load(4u + 1u).x, T30.Load(4u + 2u).x, T30.Load(4u + 3u).x);
						float fragment_unnamed_1636 = asfloat(fragment_unnamed_1634.x);
						float fragment_unnamed_1638 = asfloat(fragment_unnamed_1634.y);
						float fragment_unnamed_1640 = asfloat(fragment_unnamed_1634.z);
						float fragment_unnamed_1642 = asfloat(fragment_unnamed_1634.w);
						uint4 fragment_unnamed_1654 = uint4(T30.Load(8u).x, T30.Load(8u + 1u).x, T30.Load(8u + 2u).x, T30.Load(8u + 3u).x);
						float fragment_unnamed_1656 = asfloat(fragment_unnamed_1654.x);
						float fragment_unnamed_1658 = asfloat(fragment_unnamed_1654.y);
						float fragment_unnamed_1660 = asfloat(fragment_unnamed_1654.z);
						float fragment_unnamed_1662 = asfloat(fragment_unnamed_1654.w);
						uint4 fragment_unnamed_1674 = uint4(T30.Load(12u).x, T30.Load(12u + 1u).x, T30.Load(12u + 2u).x, T30.Load(12u + 3u).x);
						float fragment_unnamed_1676 = asfloat(fragment_unnamed_1674.x);
						float fragment_unnamed_1678 = asfloat(fragment_unnamed_1674.y);
						float fragment_unnamed_1680 = asfloat(fragment_unnamed_1674.z);
						float fragment_unnamed_1682 = asfloat(fragment_unnamed_1674.w);
						float fragment_unnamed_1683 = asfloat(0u);
						float fragment_unnamed_1684 = asfloat(0u);
						float fragment_unnamed_1685 = asfloat(0u);
						float fragment_unnamed_1686 = asfloat(4294967295u);
						float fragment_unnamed_1687 = asfloat(0u);
						float fragment_unnamed_1688 = asfloat(0u);
						float fragment_unnamed_1899;
						float fragment_unnamed_1901;
						float fragment_unnamed_1903;
						float fragment_unnamed_1905;
						float fragment_unnamed_1975;
						float fragment_unnamed_1976;
						float fragment_unnamed_1978;
						float fragment_unnamed_1980;
						float fragment_unnamed_1982;
						float fragment_unnamed_1894 = fragment_unnamed_1686;
						float fragment_unnamed_1896 = fragment_unnamed_1688;
						float fragment_unnamed_1898 = fragment_unnamed_1683;
						float fragment_unnamed_1900 = fragment_unnamed_1684;
						float fragment_unnamed_1902 = fragment_unnamed_1685;
						float fragment_unnamed_1904 = fragment_unnamed_1687;
						for (;;)
						{
							if (asuint(fragment_unnamed_1896) >= asuint(fragment_uniform_buffer_1[116u]).y)
							{
								fragment_unnamed_1975 = fragment_unnamed_1894;
								fragment_unnamed_1976 = fragment_unnamed_1898;
								fragment_unnamed_1978 = fragment_unnamed_1900;
								fragment_unnamed_1980 = fragment_unnamed_1902;
								fragment_unnamed_1982 = fragment_unnamed_1904;
								break;
							}
							else
							{
								uint fragment_unnamed_1988 = (asuint(fragment_unnamed_1896) * 4u) + 0u;
								uint fragment_unnamed_1998 = (asuint(fragment_unnamed_1896) * 4u) + 1u;
								uint fragment_unnamed_2007 = (asuint(fragment_unnamed_1896) * 4u) + 2u;
								uint fragment_unnamed_2016 = (asuint(fragment_unnamed_1896) * 4u) + 3u;
								fragment_unnamed_1899 = ((-0.0f) - mad(fragment_unnamed_108[fragment_unnamed_2016], fragment_unnamed_1676, mad(fragment_unnamed_108[fragment_unnamed_2007], fragment_unnamed_1656, mad(fragment_unnamed_108[fragment_unnamed_1998], fragment_unnamed_1636, fragment_unnamed_1616 * fragment_unnamed_108[fragment_unnamed_1988])))) + fragment_input_6.x;
								fragment_unnamed_1901 = ((-0.0f) - mad(fragment_unnamed_108[fragment_unnamed_2016], fragment_unnamed_1678, mad(fragment_unnamed_108[fragment_unnamed_2007], fragment_unnamed_1658, mad(fragment_unnamed_108[fragment_unnamed_1998], fragment_unnamed_1638, fragment_unnamed_1618 * fragment_unnamed_108[fragment_unnamed_1988])))) + fragment_input_6.y;
								fragment_unnamed_1903 = ((-0.0f) - mad(fragment_unnamed_108[fragment_unnamed_2016], fragment_unnamed_1680, mad(fragment_unnamed_108[fragment_unnamed_2007], fragment_unnamed_1660, mad(fragment_unnamed_108[fragment_unnamed_1998], fragment_unnamed_1640, fragment_unnamed_1620 * fragment_unnamed_108[fragment_unnamed_1988])))) + fragment_input_6.z;
								float fragment_unnamed_2032 = dot(float3(fragment_unnamed_1899, fragment_unnamed_1901, fragment_unnamed_1903), float3(fragment_unnamed_1899, fragment_unnamed_1901, fragment_unnamed_1903));
								fragment_unnamed_1905 = fragment_unnamed_2032 / mad(fragment_unnamed_108[fragment_unnamed_2016], fragment_unnamed_1682, mad(fragment_unnamed_108[fragment_unnamed_2007], fragment_unnamed_1662, mad(fragment_unnamed_108[fragment_unnamed_1998], fragment_unnamed_1642, fragment_unnamed_1622 * fragment_unnamed_108[fragment_unnamed_1988])));
								if (!((((0.0f < fragment_unnamed_1905) ? 4294967295u : 0u) & ((1.0f >= fragment_unnamed_1905) ? 4294967295u : 0u)) != 0u))
								{
									fragment_unnamed_1894 = asfloat(4294967295u);
									fragment_unnamed_1896 = asfloat(asuint(fragment_unnamed_1896) + 1u);
									fragment_unnamed_1898 = fragment_unnamed_1899;
									fragment_unnamed_1900 = fragment_unnamed_1901;
									fragment_unnamed_1902 = fragment_unnamed_1903;
									fragment_unnamed_1904 = fragment_unnamed_1905;
									continue;
								}
								float fragment_unnamed_2350 = sqrt(fragment_unnamed_2032);
								fragment_unnamed_1975 = fragment_unnamed_1896;
								fragment_unnamed_1976 = fragment_unnamed_1899 / fragment_unnamed_2350;
								fragment_unnamed_1978 = fragment_unnamed_1901 / fragment_unnamed_2350;
								fragment_unnamed_1980 = fragment_unnamed_1903 / fragment_unnamed_2350;
								fragment_unnamed_1982 = fragment_unnamed_1905;
								break;
							}
						}
						float fragment_unnamed_1984 = float(int(asuint(fragment_unnamed_1975)));
						float fragment_unnamed_1912;
						if (fragment_unnamed_1984 >= 0.0f)
						{
							uint4 fragment_unnamed_2191 = uint4(T30.Load(19u).x, T30.Load(19u + 1u).x, T30.Load(19u + 2u).x, T30.Load(19u + 3u).x);
							uint4 fragment_unnamed_2206 = T5.Load((asuint(fragment_uniform_buffer_1[116u]).z * 44u) + 15u);
							uint fragment_unnamed_2207 = fragment_unnamed_2206.x;
							float fragment_unnamed_2218 = asfloat((dot(float3(fragment_unnamed_247, fragment_unnamed_248, fragment_unnamed_249), float3((-0.0f) - fragment_unnamed_1360, (-0.0f) - fragment_unnamed_1362, (-0.0f) - fragment_unnamed_1364)) >= 0.0f) ? 1065353216u : 3212836864u);
							uint fragment_unnamed_2226 = asuint(fragment_unnamed_1975);
							float fragment_unnamed_2243 = dot(float4(asfloat(fragment_unnamed_2191.y), asfloat(fragment_unnamed_2191.z), asfloat(fragment_unnamed_2191.w), asfloat(T30.Load(23u).x)), float4(fragment_unnamed_108[(fragment_unnamed_2226 * 4u) + 0u], fragment_unnamed_108[(fragment_unnamed_2226 * 4u) + 1u], fragment_unnamed_108[(fragment_unnamed_2226 * 4u) + 2u], fragment_unnamed_108[(fragment_unnamed_2226 * 4u) + 3u]));
							float fragment_unnamed_2255 = asfloat((0.0f >= fragment_unnamed_2243) ? 0u : asuint(clamp((fragment_unnamed_1982 + ((-0.0f) - (((-0.0f) - fragment_unnamed_2243) + 1.0f))) / fragment_unnamed_2243, 0.0f, 1.0f)));
							float fragment_unnamed_2262 = clamp((fragment_unnamed_2243 + (-1.0f)) * (-3.3333332538604736328125f), 0.0f, 1.0f);
							float fragment_unnamed_2274 = mad(clamp(mad((fragment_unnamed_2262 * fragment_unnamed_2262) * mad(fragment_unnamed_2262, -2.0f, 3.0f), 512.0f, 8.0f) * dot(float3(fragment_unnamed_332, fragment_unnamed_334, fragment_unnamed_336), float3(fragment_unnamed_1976, fragment_unnamed_1978, fragment_unnamed_1980)), 0.0f, 1.0f), (-0.0f) - fragment_unnamed_2255, fragment_unnamed_2255);
							float fragment_unnamed_2279 = asfloat(T29.Load((fragment_unnamed_2207 * 60u) + 19u).x);
							uint fragment_unnamed_2281 = (fragment_unnamed_2207 * 60u) + 24u;
							uint2 fragment_unnamed_2287 = uint2(T29.Load(fragment_unnamed_2281).x, T29.Load(fragment_unnamed_2281 + 1u).x);
							uint fragment_unnamed_2293 = asuint(fragment_unnamed_1975) + fragment_unnamed_2207;
							uint fragment_unnamed_2295 = (fragment_unnamed_2293 * 60u) + 16u;
							uint3 fragment_unnamed_2304 = uint3(T29.Load(fragment_unnamed_2295).x, T29.Load(fragment_unnamed_2295 + 1u).x, T29.Load(fragment_unnamed_2295 + 2u).x);
							float fragment_unnamed_2310 = asfloat(fragment_unnamed_2304.z);
							float fragment_unnamed_2314 = fragment_unnamed_2310 * (fragment_unnamed_2279 * (fragment_unnamed_247 * fragment_unnamed_2218));
							float fragment_unnamed_2315 = fragment_unnamed_2310 * (fragment_unnamed_2279 * (fragment_unnamed_248 * fragment_unnamed_2218));
							float fragment_unnamed_2316 = fragment_unnamed_2310 * (fragment_unnamed_2279 * (fragment_unnamed_249 * fragment_unnamed_2218));
							uint fragment_unnamed_2319 = uint(int(asfloat(fragment_unnamed_2191.x))) + 4294967295u;
							float fragment_unnamed_2321 = float(int(uint(min(int(asuint(fragment_unnamed_1975) + 1u), int(fragment_unnamed_2319)))));
							float fragment_unnamed_2331 = trunc(fragment_uniform_buffer_1[74u].z);
							float fragment_unnamed_2852;
							float fragment_unnamed_2853;
							float fragment_unnamed_2854;
							float fragment_unnamed_2855;
							float fragment_unnamed_2856;
							float fragment_unnamed_2857;
							float fragment_unnamed_2858;
							float fragment_unnamed_2859;
							float fragment_unnamed_2860;
							float fragment_unnamed_2861;
							float fragment_unnamed_2862;
							float fragment_unnamed_2863;
							float fragment_unnamed_2864;
							float fragment_unnamed_2865;
							float fragment_unnamed_2866;
							float fragment_unnamed_2867;
							float fragment_unnamed_2868;
							float fragment_unnamed_2869;
							float fragment_unnamed_2870;
							float fragment_unnamed_2871;
							float fragment_unnamed_2872;
							float fragment_unnamed_2873;
							float fragment_unnamed_2874;
							float fragment_unnamed_2875;
							if (((((fragment_unnamed_1984 != fragment_unnamed_2321) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_2274) ? 4294967295u : 0u)) & ((fragment_unnamed_2274 >= frac(frac(dot(float2(mad(fragment_unnamed_2331, 2.0829999446868896484375f, float(fragment_unnamed_278)), mad(fragment_unnamed_2331, 4.867000102996826171875f, float(fragment_unnamed_279))), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f))) * 52.98291778564453125f)) ? 4294967295u : 0u)) != 0u)
							{
								uint fragment_unnamed_2458 = uint(int(fragment_unnamed_2321 + float(int(fragment_unnamed_2207))));
								uint fragment_unnamed_2459 = fragment_unnamed_2458 * 60u;
								uint4 fragment_unnamed_2471 = uint4(T29.Load(fragment_unnamed_2459).x, T29.Load(fragment_unnamed_2459 + 1u).x, T29.Load(fragment_unnamed_2459 + 2u).x, T29.Load(fragment_unnamed_2459 + 3u).x);
								uint fragment_unnamed_2478 = (fragment_unnamed_2458 * 60u) + 4u;
								uint4 fragment_unnamed_2490 = uint4(T29.Load(fragment_unnamed_2478).x, T29.Load(fragment_unnamed_2478 + 1u).x, T29.Load(fragment_unnamed_2478 + 2u).x, T29.Load(fragment_unnamed_2478 + 3u).x);
								uint fragment_unnamed_2496 = (fragment_unnamed_2458 * 60u) + 12u;
								uint4 fragment_unnamed_2508 = uint4(T29.Load(fragment_unnamed_2496).x, T29.Load(fragment_unnamed_2496 + 1u).x, T29.Load(fragment_unnamed_2496 + 2u).x, T29.Load(fragment_unnamed_2496 + 3u).x);
								uint fragment_unnamed_2518 = (fragment_unnamed_2458 * 60u) + 8u;
								uint4 fragment_unnamed_2530 = uint4(T29.Load(fragment_unnamed_2518).x, T29.Load(fragment_unnamed_2518 + 1u).x, T29.Load(fragment_unnamed_2518 + 2u).x, T29.Load(fragment_unnamed_2518 + 3u).x);
								uint fragment_unnamed_2538 = (fragment_unnamed_2458 * 60u) + 16u;
								uint3 fragment_unnamed_2547 = uint3(T29.Load(fragment_unnamed_2538).x, T29.Load(fragment_unnamed_2538 + 1u).x, T29.Load(fragment_unnamed_2538 + 2u).x);
								uint fragment_unnamed_2553 = (fragment_unnamed_2458 * 60u) + 40u;
								uint3 fragment_unnamed_2562 = uint3(T29.Load(fragment_unnamed_2553).x, T29.Load(fragment_unnamed_2553 + 1u).x, T29.Load(fragment_unnamed_2553 + 2u).x);
								float fragment_unnamed_2578 = asfloat(fragment_unnamed_2547.z) / fragment_unnamed_2310;
								fragment_unnamed_2852 = fragment_unnamed_2578 * fragment_unnamed_2314;
								fragment_unnamed_2853 = fragment_unnamed_2578 * fragment_unnamed_2315;
								fragment_unnamed_2854 = asfloat(fragment_unnamed_2547.x);
								fragment_unnamed_2855 = asfloat(fragment_unnamed_2547.y);
								fragment_unnamed_2856 = fragment_unnamed_2578 * fragment_unnamed_2316;
								fragment_unnamed_2857 = asfloat(fragment_unnamed_2471.w);
								fragment_unnamed_2858 = asfloat(fragment_unnamed_2490.x);
								fragment_unnamed_2859 = asfloat(fragment_unnamed_2490.y);
								fragment_unnamed_2860 = asfloat(fragment_unnamed_2530.z);
								fragment_unnamed_2861 = asfloat(fragment_unnamed_2508.z);
								fragment_unnamed_2862 = asfloat(fragment_unnamed_2508.w);
								fragment_unnamed_2863 = asfloat(fragment_unnamed_2508.x);
								fragment_unnamed_2864 = asfloat(fragment_unnamed_2508.y);
								fragment_unnamed_2865 = asfloat(fragment_unnamed_2490.z);
								fragment_unnamed_2866 = asfloat(fragment_unnamed_2490.w);
								fragment_unnamed_2867 = asfloat(fragment_unnamed_2530.x);
								fragment_unnamed_2868 = asfloat(fragment_unnamed_2530.w);
								fragment_unnamed_2869 = asfloat(fragment_unnamed_2562.x) + fragment_input_6.x;
								fragment_unnamed_2870 = asfloat(fragment_unnamed_2562.y) + fragment_input_6.y;
								fragment_unnamed_2871 = asfloat(fragment_unnamed_2562.z) + fragment_input_6.z;
								fragment_unnamed_2872 = asfloat(fragment_unnamed_2471.x);
								fragment_unnamed_2873 = asfloat(fragment_unnamed_2471.y);
								fragment_unnamed_2874 = asfloat(fragment_unnamed_2471.z);
								fragment_unnamed_2875 = asfloat(fragment_unnamed_2530.y);
							}
							else
							{
								uint fragment_unnamed_2593 = fragment_unnamed_2293 * 60u;
								uint4 fragment_unnamed_2605 = uint4(T29.Load(fragment_unnamed_2593).x, T29.Load(fragment_unnamed_2593 + 1u).x, T29.Load(fragment_unnamed_2593 + 2u).x, T29.Load(fragment_unnamed_2593 + 3u).x);
								uint fragment_unnamed_2612 = (fragment_unnamed_2293 * 60u) + 4u;
								uint4 fragment_unnamed_2624 = uint4(T29.Load(fragment_unnamed_2612).x, T29.Load(fragment_unnamed_2612 + 1u).x, T29.Load(fragment_unnamed_2612 + 2u).x, T29.Load(fragment_unnamed_2612 + 3u).x);
								uint fragment_unnamed_2630 = (fragment_unnamed_2293 * 60u) + 12u;
								uint4 fragment_unnamed_2642 = uint4(T29.Load(fragment_unnamed_2630).x, T29.Load(fragment_unnamed_2630 + 1u).x, T29.Load(fragment_unnamed_2630 + 2u).x, T29.Load(fragment_unnamed_2630 + 3u).x);
								uint fragment_unnamed_2652 = (fragment_unnamed_2293 * 60u) + 8u;
								uint4 fragment_unnamed_2664 = uint4(T29.Load(fragment_unnamed_2652).x, T29.Load(fragment_unnamed_2652 + 1u).x, T29.Load(fragment_unnamed_2652 + 2u).x, T29.Load(fragment_unnamed_2652 + 3u).x);
								uint fragment_unnamed_2672 = (fragment_unnamed_2293 * 60u) + 40u;
								uint3 fragment_unnamed_2681 = uint3(T29.Load(fragment_unnamed_2672).x, T29.Load(fragment_unnamed_2672 + 1u).x, T29.Load(fragment_unnamed_2672 + 2u).x);
								fragment_unnamed_2852 = fragment_unnamed_2314;
								fragment_unnamed_2853 = fragment_unnamed_2315;
								fragment_unnamed_2854 = asfloat(fragment_unnamed_2304.x);
								fragment_unnamed_2855 = asfloat(fragment_unnamed_2304.y);
								fragment_unnamed_2856 = fragment_unnamed_2316;
								fragment_unnamed_2857 = asfloat(fragment_unnamed_2605.w);
								fragment_unnamed_2858 = asfloat(fragment_unnamed_2624.x);
								fragment_unnamed_2859 = asfloat(fragment_unnamed_2624.y);
								fragment_unnamed_2860 = asfloat(fragment_unnamed_2664.z);
								fragment_unnamed_2861 = asfloat(fragment_unnamed_2642.z);
								fragment_unnamed_2862 = asfloat(fragment_unnamed_2642.w);
								fragment_unnamed_2863 = asfloat(fragment_unnamed_2642.x);
								fragment_unnamed_2864 = asfloat(fragment_unnamed_2642.y);
								fragment_unnamed_2865 = asfloat(fragment_unnamed_2624.z);
								fragment_unnamed_2866 = asfloat(fragment_unnamed_2624.w);
								fragment_unnamed_2867 = asfloat(fragment_unnamed_2664.x);
								fragment_unnamed_2868 = asfloat(fragment_unnamed_2664.w);
								fragment_unnamed_2869 = asfloat(fragment_unnamed_2681.x) + fragment_input_6.x;
								fragment_unnamed_2870 = asfloat(fragment_unnamed_2681.y) + fragment_input_6.y;
								fragment_unnamed_2871 = asfloat(fragment_unnamed_2681.z) + fragment_input_6.z;
								fragment_unnamed_2872 = asfloat(fragment_unnamed_2605.x);
								fragment_unnamed_2873 = asfloat(fragment_unnamed_2605.y);
								fragment_unnamed_2874 = asfloat(fragment_unnamed_2605.z);
								fragment_unnamed_2875 = asfloat(fragment_unnamed_2664.y);
							}
							float fragment_unnamed_2876 = fragment_unnamed_2852 + fragment_unnamed_2869;
							float fragment_unnamed_2877 = fragment_unnamed_2853 + fragment_unnamed_2870;
							float fragment_unnamed_2878 = fragment_unnamed_2856 + fragment_unnamed_2871;
							float fragment_unnamed_2879 = asfloat(1065353216u);
							float fragment_unnamed_2906 = mad(asfloat(fragment_unnamed_2287.x) * clamp(mad(dot(float4(fragment_unnamed_2872, fragment_unnamed_2873, fragment_unnamed_2874, fragment_unnamed_2875), float4(fragment_unnamed_2876, fragment_unnamed_2877, fragment_unnamed_2878, fragment_unnamed_2879)) * fragment_unnamed_2863, 0.5f, 0.5f), 0.0f, 1.0f), fragment_uniform_buffer_1[98u].z, fragment_unnamed_2854);
							float fragment_unnamed_2907 = mad(asfloat(fragment_unnamed_2287.y) * clamp(mad(dot(float4(fragment_unnamed_2857, fragment_unnamed_2858, fragment_unnamed_2859, fragment_unnamed_2860), float4(fragment_unnamed_2876, fragment_unnamed_2877, fragment_unnamed_2878, fragment_unnamed_2879)) * fragment_unnamed_2864, 0.5f, 0.5f), 0.0f, 1.0f), fragment_uniform_buffer_1[98u].w, fragment_unnamed_2855);
							float fragment_unnamed_2908 = dot(float2(fragment_unnamed_2861, fragment_unnamed_2862), float2(dot(float4(fragment_unnamed_2865, fragment_unnamed_2866, fragment_unnamed_2867, fragment_unnamed_2868), float4(fragment_unnamed_2876, fragment_unnamed_2877, fragment_unnamed_2878, fragment_unnamed_2879)), asfloat(1065353216u))) + 1.52587890625e-05f;
							float fragment_unnamed_2916 = floor(mad(fragment_unnamed_2906, fragment_uniform_buffer_1[98u].x, 0.5f));
							float fragment_unnamed_2917 = floor(mad(fragment_unnamed_2907, fragment_uniform_buffer_1[98u].y, 0.5f));
							float fragment_unnamed_2924 = mad(fragment_unnamed_2906, fragment_uniform_buffer_1[98u].x, (-0.0f) - fragment_unnamed_2916);
							float fragment_unnamed_2925 = mad(fragment_unnamed_2907, fragment_uniform_buffer_1[98u].y, (-0.0f) - fragment_unnamed_2917);
							float fragment_unnamed_2926 = fragment_unnamed_2924 + 0.5f;
							float fragment_unnamed_2928 = fragment_unnamed_2925 + 0.5f;
							float fragment_unnamed_2934 = (fragment_unnamed_2926 * fragment_unnamed_2926) * 0.040816001594066619873046875f;
							float fragment_unnamed_2936 = (fragment_unnamed_2928 * fragment_unnamed_2928) * 0.040816001594066619873046875f;
							float fragment_unnamed_2945 = min(fragment_unnamed_2924, 0.0f);
							float fragment_unnamed_2946 = min(fragment_unnamed_2925, 0.0f);
							float fragment_unnamed_2951 = max(fragment_unnamed_2924, 0.0f);
							float fragment_unnamed_2952 = max(fragment_unnamed_2925, 0.0f);
							float fragment_unnamed_2966 = (mad((-0.0f) - fragment_unnamed_2945, fragment_unnamed_2945, ((-0.0f) - fragment_unnamed_2924) + 1.0f) + 2.0f) * 0.08163200318813323974609375f;
							float fragment_unnamed_2967 = (mad((-0.0f) - fragment_unnamed_2946, fragment_unnamed_2946, ((-0.0f) - fragment_unnamed_2925) + 1.0f) + 2.0f) * 0.08163200318813323974609375f;
							float fragment_unnamed_2972 = mad(fragment_unnamed_2924, -0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2973 = mad(fragment_unnamed_2924, 0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2974 = fragment_unnamed_2972 + (mad(fragment_unnamed_2926 * fragment_unnamed_2926, 0.5f, (-0.0f) - fragment_unnamed_2924) * 0.08163200318813323974609375f);
							float fragment_unnamed_2975 = fragment_unnamed_2966 + mad(fragment_unnamed_2924, -0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2976 = fragment_unnamed_2973 + ((mad((-0.0f) - fragment_unnamed_2951, fragment_unnamed_2951, fragment_unnamed_2924 + 1.0f) + 2.0f) * 0.08163200318813323974609375f);
							float fragment_unnamed_2977 = fragment_unnamed_2934 + mad(fragment_unnamed_2924, 0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2980 = mad(fragment_unnamed_2925, -0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2981 = mad(fragment_unnamed_2925, 0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2982 = fragment_unnamed_2980 + (mad(fragment_unnamed_2928 * fragment_unnamed_2928, 0.5f, (-0.0f) - fragment_unnamed_2925) * 0.08163200318813323974609375f);
							float fragment_unnamed_2983 = fragment_unnamed_2967 + mad(fragment_unnamed_2925, -0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2984 = fragment_unnamed_2981 + ((mad((-0.0f) - fragment_unnamed_2952, fragment_unnamed_2952, fragment_unnamed_2925 + 1.0f) + 2.0f) * 0.08163200318813323974609375f);
							float fragment_unnamed_2985 = fragment_unnamed_2936 + mad(fragment_unnamed_2925, 0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_3008 = ((fragment_unnamed_2934 / fragment_unnamed_2977) + 2.5f) * fragment_uniform_buffer_1[98u].z;
							float fragment_unnamed_3009 = ((fragment_unnamed_2972 / fragment_unnamed_2974) + (-3.5f)) * fragment_uniform_buffer_1[98u].z;
							float fragment_unnamed_3010 = ((fragment_unnamed_2966 / fragment_unnamed_2975) + (-1.5f)) * fragment_uniform_buffer_1[98u].z;
							float fragment_unnamed_3011 = ((fragment_unnamed_2973 / fragment_unnamed_2976) + 0.5f) * fragment_uniform_buffer_1[98u].z;
							float fragment_unnamed_3015 = ((fragment_unnamed_2980 / fragment_unnamed_2982) + (-3.5f)) * fragment_uniform_buffer_1[98u].w;
							float fragment_unnamed_3016 = ((fragment_unnamed_2936 / fragment_unnamed_2985) + 2.5f) * fragment_uniform_buffer_1[98u].w;
							float fragment_unnamed_3017 = ((fragment_unnamed_2967 / fragment_unnamed_2983) + (-1.5f)) * fragment_uniform_buffer_1[98u].w;
							float fragment_unnamed_3018 = ((fragment_unnamed_2981 / fragment_unnamed_2984) + 0.5f) * fragment_uniform_buffer_1[98u].w;
							float fragment_unnamed_3095 = fragment_unnamed_2982 * fragment_unnamed_2974;
							float fragment_unnamed_3096 = fragment_unnamed_2982 * fragment_unnamed_2975;
							float fragment_unnamed_3097 = fragment_unnamed_2982 * fragment_unnamed_2976;
							float fragment_unnamed_3098 = fragment_unnamed_2982 * fragment_unnamed_2977;
							float fragment_unnamed_3099 = fragment_unnamed_2983 * fragment_unnamed_2974;
							float fragment_unnamed_3100 = fragment_unnamed_2983 * fragment_unnamed_2975;
							float fragment_unnamed_3101 = fragment_unnamed_2983 * fragment_unnamed_2976;
							float fragment_unnamed_3102 = fragment_unnamed_2983 * fragment_unnamed_2977;
							float fragment_unnamed_3103 = fragment_unnamed_2984 * fragment_unnamed_2974;
							float fragment_unnamed_3104 = fragment_unnamed_2984 * fragment_unnamed_2975;
							float fragment_unnamed_3105 = fragment_unnamed_2984 * fragment_unnamed_2976;
							float fragment_unnamed_3106 = fragment_unnamed_2984 * fragment_unnamed_2977;
							float fragment_unnamed_3107 = fragment_unnamed_2985 * fragment_unnamed_2974;
							float fragment_unnamed_3108 = fragment_unnamed_2985 * fragment_unnamed_2975;
							float fragment_unnamed_3109 = fragment_unnamed_2985 * fragment_unnamed_2976;
							float fragment_unnamed_3110 = fragment_unnamed_2985 * fragment_unnamed_2977;
							float4 fragment_unnamed_3116 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3009), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3015)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_3117 = fragment_unnamed_3116.x;
							float4 fragment_unnamed_3120 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3010), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3015)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_3121 = fragment_unnamed_3120.x;
							float4 fragment_unnamed_3124 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3011), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3015)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_3125 = fragment_unnamed_3124.x;
							float4 fragment_unnamed_3128 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3008), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3015)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_3129 = fragment_unnamed_3128.x;
							float fragment_unnamed_3131 = asfloat(0u);
							float fragment_unnamed_3438;
							fragment_unnamed_3438 = asfloat(0u);
							float fragment_unnamed_3439;
							float fragment_unnamed_3600;
							float fragment_unnamed_3601;
							float fragment_unnamed_3602;
							for (float fragment_unnamed_3440 = fragment_unnamed_3131; !(int(asuint(fragment_unnamed_3440)) >= int(1u)); fragment_unnamed_3600 = mad(fragment_unnamed_3095, fragment_unnamed_3117, fragment_unnamed_3438), fragment_unnamed_3601 = mad(fragment_unnamed_3096, fragment_unnamed_3121, fragment_unnamed_3600), fragment_unnamed_3602 = mad(fragment_unnamed_3097, fragment_unnamed_3125, fragment_unnamed_3601), fragment_unnamed_3439 = mad(fragment_unnamed_3098, fragment_unnamed_3129, fragment_unnamed_3602), fragment_unnamed_3438 = fragment_unnamed_3439, fragment_unnamed_3440 = asfloat(asuint(fragment_unnamed_3440) + 1u))
							{
							}
							float4 fragment_unnamed_3585 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3009), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3017)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_3586 = fragment_unnamed_3585.x;
							float4 fragment_unnamed_3589 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3010), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3017)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_3590 = fragment_unnamed_3589.x;
							float4 fragment_unnamed_3593 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3011), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3017)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_3594 = fragment_unnamed_3593.x;
							float4 fragment_unnamed_3597 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3008), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3017)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_3598 = fragment_unnamed_3597.x;
							float fragment_unnamed_3599 = asfloat(0u);
							float fragment_unnamed_4267;
							fragment_unnamed_4267 = fragment_unnamed_3438;
							float fragment_unnamed_4268;
							float fragment_unnamed_4622;
							float fragment_unnamed_4623;
							float fragment_unnamed_4624;
							for (float fragment_unnamed_4269 = fragment_unnamed_3599; !(int(asuint(fragment_unnamed_4269)) >= int(1u)); fragment_unnamed_4622 = mad(fragment_unnamed_3099, fragment_unnamed_3586, fragment_unnamed_4267), fragment_unnamed_4623 = mad(fragment_unnamed_3100, fragment_unnamed_3590, fragment_unnamed_4622), fragment_unnamed_4624 = mad(fragment_unnamed_3101, fragment_unnamed_3594, fragment_unnamed_4623), fragment_unnamed_4268 = mad(fragment_unnamed_3102, fragment_unnamed_3598, fragment_unnamed_4624), fragment_unnamed_4267 = fragment_unnamed_4268, fragment_unnamed_4269 = asfloat(asuint(fragment_unnamed_4269) + 1u))
							{
							}
							float4 fragment_unnamed_4607 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3009), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3018)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_4608 = fragment_unnamed_4607.x;
							float4 fragment_unnamed_4611 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3010), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3018)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_4612 = fragment_unnamed_4611.x;
							float4 fragment_unnamed_4615 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3011), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3018)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_4616 = fragment_unnamed_4615.x;
							float4 fragment_unnamed_4619 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3008), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3018)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_4620 = fragment_unnamed_4619.x;
							float fragment_unnamed_4621 = asfloat(0u);
							float fragment_unnamed_5328;
							fragment_unnamed_5328 = fragment_unnamed_4267;
							float fragment_unnamed_5329;
							float fragment_unnamed_5823;
							float fragment_unnamed_5824;
							float fragment_unnamed_5825;
							for (float fragment_unnamed_5330 = fragment_unnamed_4621; !(int(asuint(fragment_unnamed_5330)) >= int(1u)); fragment_unnamed_5823 = mad(fragment_unnamed_3103, fragment_unnamed_4608, fragment_unnamed_5328), fragment_unnamed_5824 = mad(fragment_unnamed_3104, fragment_unnamed_4612, fragment_unnamed_5823), fragment_unnamed_5825 = mad(fragment_unnamed_3105, fragment_unnamed_4616, fragment_unnamed_5824), fragment_unnamed_5329 = mad(fragment_unnamed_3106, fragment_unnamed_4620, fragment_unnamed_5825), fragment_unnamed_5328 = fragment_unnamed_5329, fragment_unnamed_5330 = asfloat(asuint(fragment_unnamed_5330) + 1u))
							{
							}
							float4 fragment_unnamed_5808 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3009), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3016)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_5809 = fragment_unnamed_5808.x;
							float4 fragment_unnamed_5812 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3010), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3016)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_5813 = fragment_unnamed_5812.x;
							float4 fragment_unnamed_5816 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3011), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3016)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_5817 = fragment_unnamed_5816.x;
							float4 fragment_unnamed_5820 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2916, fragment_uniform_buffer_1[98u].z, fragment_unnamed_3008), mad(fragment_unnamed_2917, fragment_uniform_buffer_1[98u].w, fragment_unnamed_3016)), fragment_unnamed_2908).xxxx;
							float fragment_unnamed_5821 = fragment_unnamed_5820.x;
							float fragment_unnamed_5822 = asfloat(0u);
							float fragment_unnamed_6903;
							fragment_unnamed_6903 = fragment_unnamed_5328;
							float fragment_unnamed_6904;
							float fragment_unnamed_7066;
							float fragment_unnamed_7067;
							float fragment_unnamed_7068;
							for (float fragment_unnamed_6905 = fragment_unnamed_5822; !(int(asuint(fragment_unnamed_6905)) >= int(1u)); fragment_unnamed_7066 = mad(fragment_unnamed_3107, fragment_unnamed_5809, fragment_unnamed_6903), fragment_unnamed_7067 = mad(fragment_unnamed_3108, fragment_unnamed_5813, fragment_unnamed_7066), fragment_unnamed_7068 = mad(fragment_unnamed_3109, fragment_unnamed_5817, fragment_unnamed_7067), fragment_unnamed_6904 = mad(fragment_unnamed_3110, fragment_unnamed_5821, fragment_unnamed_7068), fragment_unnamed_6903 = fragment_unnamed_6904, fragment_unnamed_6905 = asfloat(asuint(fragment_unnamed_6905) + 1u))
							{
							}
							fragment_unnamed_1912 = asfloat((int(asuint(fragment_unnamed_1975)) < int(fragment_unnamed_2319)) ? asuint(fragment_unnamed_6903) : asuint(mad(fragment_unnamed_2274, ((-0.0f) - fragment_unnamed_6903) + 1.0f, fragment_unnamed_6903)));
						}
						else
						{
							fragment_unnamed_1912 = asfloat(1065353216u);
						}
						fragment_unnamed_1693 = fragment_unnamed_1912;
						fragment_unnamed_1695 = fragment_unnamed_1912;
						fragment_unnamed_1697 = fragment_unnamed_1912;
					}
					else
					{
						fragment_unnamed_1693 = asfloat(1065353216u);
						fragment_unnamed_1695 = asfloat(1065353216u);
						fragment_unnamed_1697 = asfloat(1065353216u);
					}
					fragment_unnamed_1692 = fragment_unnamed_1693;
					fragment_unnamed_1694 = fragment_unnamed_1695;
					fragment_unnamed_1696 = fragment_unnamed_1697;
				}
				else
				{
					fragment_unnamed_1692 = asfloat(1065353216u);
					fragment_unnamed_1694 = asfloat(1065353216u);
					fragment_unnamed_1696 = asfloat(1065353216u);
				}
				float fragment_unnamed_1716 = asfloat((asuint(fragment_uniform_buffer_1[127u]).w != 0u) ? T4.Load((fragment_unnamed_282 * asuint(fragment_uniform_buffer_1[128u]).x) + fragment_unnamed_280).x : asuint(fragment_uniform_buffer_1[126u]).w);
				uint4 fragment_unnamed_1719 = asuint(fragment_uniform_buffer_1[127u]);
				uint fragment_unnamed_1720 = fragment_unnamed_1719.z;
				uint fragment_unnamed_1724 = 1u << (fragment_unnamed_1720 & 31u);
				uint fragment_unnamed_1757 = uint(int(min(float(int(fragment_unnamed_1724 + 4294967295u)), max(log2(mad(max((1.0f / gl_FragCoord.w) + ((-0.0f) - fragment_uniform_buffer_1[127u].x), 0.0f) / (((-0.0f) - fragment_uniform_buffer_1[127u].x) + fragment_uniform_buffer_1[127u].y), exp2(float(int(fragment_unnamed_1724)) * log2(abs(fragment_unnamed_1716))) + (-1.0f), 1.0f)) / log2(fragment_unnamed_1716), 0.0f))));
				uint4 fragment_unnamed_1770 = T3.Load((((fragment_unnamed_1757 * asuint(fragment_uniform_buffer_1[128u]).y) + fragment_unnamed_282) * asuint(fragment_uniform_buffer_1[128u]).x) + fragment_unnamed_280);
				uint fragment_unnamed_1771 = fragment_unnamed_1770.x;
				uint fragment_unnamed_1772 = fragment_unnamed_1771 & 67108863u;
				uint fragment_unnamed_1773 = fragment_unnamed_1771 >> 26u;
				float fragment_unnamed_1786 = dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_uniform_buffer_1[83u].xyz));
				float fragment_unnamed_1789 = fragment_unnamed_1132 * fragment_unnamed_1132;
				float fragment_unnamed_1797 = exp2(ceil(max((-0.0f) - fragment_uniform_buffer_1[123u].z, 0.0f)));
				float fragment_unnamed_1799 = fragment_unnamed_1132 * (fragment_unnamed_1789 * fragment_unnamed_1789);
				float fragment_unnamed_1800 = asfloat(1065353216u);
				float fragment_unnamed_1801 = asfloat(1065353216u);
				float fragment_unnamed_1802 = asfloat(1065353216u);
				float fragment_unnamed_1803 = asfloat(1065353216u);
				float fragment_unnamed_1804 = asfloat(0u);
				float fragment_unnamed_1805 = asfloat(0u);
				float fragment_unnamed_1806 = asfloat(0u);
				float fragment_unnamed_1807 = asfloat(0u);
				float fragment_unnamed_1808 = asfloat(0u);
				float fragment_unnamed_1809 = asfloat(0u);
				float fragment_unnamed_1810 = asfloat(0u);
				float fragment_unnamed_1913;
				float fragment_unnamed_1915;
				float fragment_unnamed_1917;
				float fragment_unnamed_1919;
				float fragment_unnamed_1921;
				float fragment_unnamed_1923;
				float fragment_unnamed_1925;
				for (;;)
				{
					fragment_unnamed_1913 = fragment_unnamed_1810;
					fragment_unnamed_1915 = fragment_unnamed_1804;
					fragment_unnamed_1917 = fragment_unnamed_1805;
					fragment_unnamed_1919 = fragment_unnamed_1807;
					fragment_unnamed_1921 = fragment_unnamed_1808;
					fragment_unnamed_1923 = fragment_unnamed_1806;
					fragment_unnamed_1925 = fragment_unnamed_1809;
					float fragment_unnamed_1914;
					float fragment_unnamed_1916;
					float fragment_unnamed_1918;
					float fragment_unnamed_1920;
					float fragment_unnamed_1922;
					float fragment_unnamed_1924;
					float fragment_unnamed_1926;
					bool ladder_phi_41;
					for (;;)
					{
						if (asuint(fragment_unnamed_1913) >= fragment_unnamed_1773)
						{
							ladder_phi_41 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_2070 = asuint(fragment_unnamed_1913);
							uint4 fragment_unnamed_2072 = T2.Load(fragment_unnamed_1772 + fragment_unnamed_2070);
							uint fragment_unnamed_2073 = fragment_unnamed_2072.x;
							if (fragment_unnamed_2073 == 4294967295u)
							{
								ladder_phi_41 = false;
								break;
							}
							uint fragment_unnamed_2365 = fragment_unnamed_2073 * 56u;
							uint4 fragment_unnamed_2378 = uint4(T6.Load(fragment_unnamed_2365).x, T6.Load(fragment_unnamed_2365 + 1u).x, T6.Load(fragment_unnamed_2365 + 2u).x, T6.Load(fragment_unnamed_2365 + 3u).x);
							fragment_unnamed_1914 = asfloat(asuint(fragment_unnamed_1913) + 1u);
							if (!((fragment_unnamed_676 & fragment_unnamed_2378.w) != 0u))
							{
								fragment_unnamed_1916 = fragment_unnamed_1915;
								fragment_unnamed_1918 = fragment_unnamed_1917;
								fragment_unnamed_1920 = fragment_unnamed_1919;
								fragment_unnamed_1922 = fragment_unnamed_1921;
								fragment_unnamed_1924 = fragment_unnamed_1923;
								fragment_unnamed_1926 = fragment_unnamed_1925;
								fragment_unnamed_1913 = fragment_unnamed_1914;
								fragment_unnamed_1915 = fragment_unnamed_1916;
								fragment_unnamed_1917 = fragment_unnamed_1918;
								fragment_unnamed_1919 = fragment_unnamed_1920;
								fragment_unnamed_1921 = fragment_unnamed_1922;
								fragment_unnamed_1923 = fragment_unnamed_1924;
								fragment_unnamed_1925 = fragment_unnamed_1926;
								continue;
							}
							uint fragment_unnamed_2724 = (fragment_unnamed_2073 * 56u) + 6u;
							uint4 fragment_unnamed_2736 = uint4(T6.Load(fragment_unnamed_2724).x, T6.Load(fragment_unnamed_2724 + 1u).x, T6.Load(fragment_unnamed_2724 + 2u).x, T6.Load(fragment_unnamed_2724 + 3u).x);
							uint fragment_unnamed_2744 = (fragment_unnamed_2073 * 56u) + 10u;
							uint4 fragment_unnamed_2756 = uint4(T6.Load(fragment_unnamed_2744).x, T6.Load(fragment_unnamed_2744 + 1u).x, T6.Load(fragment_unnamed_2744 + 2u).x, T6.Load(fragment_unnamed_2744 + 3u).x);
							float fragment_unnamed_2759 = asfloat(fragment_unnamed_2756.y);
							uint fragment_unnamed_2760 = fragment_unnamed_2756.z;
							float fragment_unnamed_2771 = ((-0.0f) - asfloat(fragment_unnamed_2378.x)) + fragment_input_6.x;
							float fragment_unnamed_2772 = ((-0.0f) - asfloat(fragment_unnamed_2378.y)) + fragment_input_6.y;
							float fragment_unnamed_2773 = ((-0.0f) - asfloat(fragment_unnamed_2378.z)) + fragment_input_6.z;
							bool fragment_unnamed_2774 = fragment_unnamed_2760 == 4u;
							float fragment_unnamed_2775 = asfloat(fragment_unnamed_2736.z);
							float fragment_unnamed_2776 = asfloat(fragment_unnamed_2736.w);
							float fragment_unnamed_2777 = asfloat(fragment_unnamed_2756.x);
							float fragment_unnamed_2784 = dot(float3((-0.0f) - fragment_unnamed_2771, (-0.0f) - fragment_unnamed_2772, (-0.0f) - fragment_unnamed_2773), float3((-0.0f) - fragment_unnamed_2771, (-0.0f) - fragment_unnamed_2772, (-0.0f) - fragment_unnamed_2773));
							float fragment_unnamed_2787 = rsqrt(fragment_unnamed_2784);
							float fragment_unnamed_2797 = fragment_unnamed_2774 ? ((-0.0f) - fragment_unnamed_2775) : (fragment_unnamed_2787 * ((-0.0f) - fragment_unnamed_2771));
							float fragment_unnamed_2798 = fragment_unnamed_2774 ? ((-0.0f) - fragment_unnamed_2776) : (fragment_unnamed_2787 * ((-0.0f) - fragment_unnamed_2772));
							float fragment_unnamed_2799 = fragment_unnamed_2774 ? ((-0.0f) - fragment_unnamed_2777) : (fragment_unnamed_2787 * ((-0.0f) - fragment_unnamed_2773));
							float fragment_unnamed_2802 = dot(float3(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668), float3(fragment_unnamed_2797, fragment_unnamed_2798, fragment_unnamed_2799));
							float fragment_unnamed_3570;
							float fragment_unnamed_3572;
							float fragment_unnamed_3574;
							float fragment_unnamed_3576;
							float fragment_unnamed_3578;
							float fragment_unnamed_3580;
							if ((((0.0f < asfloat(T6.Load((fragment_unnamed_2073 * 56u) + 4u).x)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_2802) ? 4294967295u : 0u)) != 0u)
							{
								uint fragment_unnamed_3218 = (fragment_unnamed_2073 * 56u) + 14u;
								uint4 fragment_unnamed_3230 = uint4(T6.Load(fragment_unnamed_3218).x, T6.Load(fragment_unnamed_3218 + 1u).x, T6.Load(fragment_unnamed_3218 + 2u).x, T6.Load(fragment_unnamed_3218 + 3u).x);
								float fragment_unnamed_3234 = asfloat(fragment_unnamed_3230.z);
								float fragment_unnamed_3236 = asfloat(fragment_unnamed_3230.w);
								uint fragment_unnamed_3238 = (fragment_unnamed_2073 * 56u) + 18u;
								uint4 fragment_unnamed_3250 = uint4(T6.Load(fragment_unnamed_3238).x, T6.Load(fragment_unnamed_3238 + 1u).x, T6.Load(fragment_unnamed_3238 + 2u).x, T6.Load(fragment_unnamed_3238 + 3u).x);
								uint fragment_unnamed_3256 = fragment_unnamed_3250.y;
								uint fragment_unnamed_3258 = (fragment_unnamed_2073 * 56u) + 22u;
								uint4 fragment_unnamed_3270 = uint4(T6.Load(fragment_unnamed_3258).x, T6.Load(fragment_unnamed_3258 + 1u).x, T6.Load(fragment_unnamed_3258 + 2u).x, T6.Load(fragment_unnamed_3258 + 3u).x);
								uint fragment_unnamed_3273 = fragment_unnamed_3270.z;
								uint fragment_unnamed_3275 = fragment_unnamed_3270.w;
								uint fragment_unnamed_3279 = (fragment_unnamed_2073 * 56u) + 26u;
								uint4 fragment_unnamed_3291 = uint4(T6.Load(fragment_unnamed_3279).x, T6.Load(fragment_unnamed_3279 + 1u).x, T6.Load(fragment_unnamed_3279 + 2u).x, T6.Load(fragment_unnamed_3279 + 3u).x);
								float fragment_unnamed_3295 = asfloat(fragment_unnamed_3291.z);
								uint fragment_unnamed_3296 = fragment_unnamed_3291.x;
								float fragment_unnamed_3299 = asfloat(fragment_unnamed_3291.w);
								uint fragment_unnamed_3302 = (fragment_unnamed_2073 * 56u) + 30u;
								uint4 fragment_unnamed_3314 = uint4(T6.Load(fragment_unnamed_3302).x, T6.Load(fragment_unnamed_3302 + 1u).x, T6.Load(fragment_unnamed_3302 + 2u).x, T6.Load(fragment_unnamed_3302 + 3u).x);
								float fragment_unnamed_3316 = asfloat(fragment_unnamed_3314.x);
								float fragment_unnamed_3318 = asfloat(fragment_unnamed_3314.y);
								uint fragment_unnamed_3323 = (fragment_unnamed_2073 * 56u) + 34u;
								uint2 fragment_unnamed_3329 = uint2(T6.Load(fragment_unnamed_3323).x, T6.Load(fragment_unnamed_3323 + 1u).x);
								float fragment_unnamed_3331 = asfloat(fragment_unnamed_3329.x);
								float fragment_unnamed_3333 = asfloat(fragment_unnamed_3329.y);
								float fragment_unnamed_3339 = dot(float3(fragment_unnamed_2771, fragment_unnamed_2772, fragment_unnamed_2773), float3(fragment_unnamed_2775, fragment_unnamed_2776, fragment_unnamed_2777));
								uint fragment_unnamed_3351 = fragment_unnamed_2774 ? asuint(fragment_unnamed_3339) : asuint(fragment_unnamed_2787 * fragment_unnamed_2784);
								float fragment_unnamed_3352 = asfloat(fragment_unnamed_3351);
								float fragment_unnamed_3361 = asfloat(fragment_unnamed_3270.y) * asfloat(fragment_unnamed_2774 ? asuint(fragment_unnamed_3339 * fragment_unnamed_3339) : asuint(fragment_unnamed_2784));
								float fragment_unnamed_3368 = clamp(mad((1.0f / fragment_unnamed_3352) * fragment_unnamed_3339, asfloat(fragment_unnamed_2736.x), asfloat(fragment_unnamed_2736.y)), 0.0f, 1.0f) * (min(asfloat(fragment_unnamed_2774 ? 1065353216u : asuint(rsqrt(asfloat(T6.Load((fragment_unnamed_2073 * 56u) + 44u).x) + fragment_unnamed_2784))), 100.0f) * clamp(mad((-0.0f) - fragment_unnamed_3361, fragment_unnamed_3361, asfloat(fragment_unnamed_3291.y)), 0.0f, 1.0f));
								float fragment_unnamed_3375 = dot(float3(fragment_unnamed_2797, fragment_unnamed_2798, fragment_unnamed_2799), float3(fragment_uniform_buffer_1[83u].xyz));
								float fragment_unnamed_3379 = max(abs(fragment_unnamed_3375), 0.001000000047497451305389404296875f);
								float fragment_unnamed_3381 = 1.0f / fragment_unnamed_3379;
								float fragment_unnamed_3383 = min(fragment_unnamed_1786, mad(fragment_unnamed_3352, fragment_unnamed_3375, fragment_unnamed_1786));
								float fragment_unnamed_3397 = min(fragment_unnamed_3352, max(fragment_unnamed_3381 * (((-0.0f) - fragment_unnamed_3383) + fragment_uniform_buffer_1[89u].y), 0.0f));
								float fragment_unnamed_3430 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_3379 * ((-0.0f) - (((-0.0f) - fragment_unnamed_3397) + fragment_unnamed_3352))) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_3383 + ((-0.0f) - fragment_uniform_buffer_1[89u].y), 0.0f)) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f), fragment_unnamed_3381 * fragment_uniform_buffer_1[90u].y, fragment_unnamed_3397) * fragment_uniform_buffer_1[89u].x) * (-1.44269502162933349609375f)) * (fragment_unnamed_3368 * fragment_unnamed_3368);
								float fragment_unnamed_4250;
								float fragment_unnamed_4252;
								float fragment_unnamed_4254;
								float fragment_unnamed_4256;
								if (fragment_unnamed_3250.x != 0u)
								{
									float fragment_unnamed_3560 = dot(float3(fragment_unnamed_2771, fragment_unnamed_2772, fragment_unnamed_2773), float3(asfloat(fragment_unnamed_2756.w), asfloat(fragment_unnamed_3230.x), asfloat(fragment_unnamed_3230.y)));
									float fragment_unnamed_3564 = dot(float3(fragment_unnamed_2771, fragment_unnamed_2772, fragment_unnamed_2773), float3(asfloat(fragment_unnamed_3250.z), asfloat(fragment_unnamed_3250.w), asfloat(fragment_unnamed_3270.x)));
									float fragment_unnamed_4487;
									float fragment_unnamed_4488;
									float fragment_unnamed_4489;
									float fragment_unnamed_4490;
									if (fragment_unnamed_2760 == 1u)
									{
										float fragment_unnamed_4107 = 1.0f / max(dot(float3(abs(fragment_unnamed_3560), abs(fragment_unnamed_3564), abs(fragment_unnamed_3339)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
										float fragment_unnamed_4112 = clamp((-0.0f) - (fragment_unnamed_4107 * fragment_unnamed_3339), 0.0f, 1.0f);
										float fragment_unnamed_4115 = (-0.0f) - fragment_unnamed_4112;
										float fragment_unnamed_4129 = 1.0f / (fragment_unnamed_3295 + fragment_uniform_buffer_1[123u].y);
										float fragment_unnamed_4130 = 1.0f / (fragment_unnamed_3299 + fragment_uniform_buffer_1[123u].y);
										float fragment_unnamed_4142 = fragment_unnamed_3295 * fragment_uniform_buffer_1[123u].x;
										float fragment_unnamed_4143 = fragment_unnamed_3299 * fragment_uniform_buffer_1[123u].x;
										float fragment_unnamed_4146 = fragment_unnamed_1797 / (fragment_unnamed_4142 + fragment_unnamed_4142);
										float fragment_unnamed_4147 = fragment_unnamed_1797 / (fragment_unnamed_4143 + fragment_unnamed_4143);
										float4 fragment_unnamed_4161 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_4146) + 1.0f, max(fragment_unnamed_4146, mad(clamp(mad(mad(fragment_unnamed_3560, fragment_unnamed_4107, ((fragment_unnamed_4107 * fragment_unnamed_3560) >= 0.0f) ? fragment_unnamed_4112 : fragment_unnamed_4115), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_3295 * fragment_unnamed_4129, mad((-0.0f) - fragment_unnamed_4129, fragment_unnamed_3295, 1.0f) * 0.5f))), fragment_unnamed_3295, fragment_unnamed_3316), mad(min(((-0.0f) - fragment_unnamed_4147) + 1.0f, max(fragment_unnamed_4147, mad(clamp(mad(mad(fragment_unnamed_3564, fragment_unnamed_4107, ((fragment_unnamed_4107 * fragment_unnamed_3564) >= 0.0f) ? fragment_unnamed_4112 : fragment_unnamed_4115), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_3299 * fragment_unnamed_4130, mad((-0.0f) - fragment_unnamed_4130, fragment_unnamed_3299, 1.0f) * 0.5f))), fragment_unnamed_3299, fragment_unnamed_3318)), 0.0f);
										fragment_unnamed_4487 = fragment_unnamed_4161.x;
										fragment_unnamed_4488 = fragment_unnamed_4161.y;
										fragment_unnamed_4489 = fragment_unnamed_4161.z;
										fragment_unnamed_4490 = asfloat(1065353216u);
									}
									else
									{
										bool fragment_unnamed_4173 = fragment_unnamed_2760 != 4u;
										float fragment_unnamed_4179 = asfloat(fragment_unnamed_4173 ? asuint(fragment_unnamed_3339) : 1065353216u);
										float fragment_unnamed_4180 = fragment_unnamed_3560 / fragment_unnamed_4179;
										float fragment_unnamed_4181 = fragment_unnamed_3564 / fragment_unnamed_4179;
										uint fragment_unnamed_4193 = (asfloat(T6.Load((fragment_unnamed_2073 * 56u) + 55u).x) >= max(mad((-0.0f) - fragment_unnamed_3236, 0.5f, abs(mad((-0.0f) - fragment_unnamed_3236, 0.5f, fragment_unnamed_3339))) + 1.0f, max(abs(fragment_unnamed_4181), abs(fragment_unnamed_4180)))) ? 4294967295u : 0u;
										float fragment_unnamed_4211 = 1.0f / (fragment_unnamed_3295 + fragment_uniform_buffer_1[123u].y);
										float fragment_unnamed_4212 = 1.0f / (fragment_unnamed_3299 + fragment_uniform_buffer_1[123u].y);
										float fragment_unnamed_4224 = fragment_unnamed_3295 * fragment_uniform_buffer_1[123u].x;
										float fragment_unnamed_4225 = fragment_unnamed_3299 * fragment_uniform_buffer_1[123u].x;
										float fragment_unnamed_4228 = fragment_unnamed_1797 / (fragment_unnamed_4224 + fragment_unnamed_4224);
										float fragment_unnamed_4229 = fragment_unnamed_1797 / (fragment_unnamed_4225 + fragment_unnamed_4225);
										float4 fragment_unnamed_4243 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_4228) + 1.0f, max(fragment_unnamed_4228, mad(mad(fragment_unnamed_4180, 0.5f, 0.5f), fragment_unnamed_3295 * fragment_unnamed_4211, mad((-0.0f) - fragment_unnamed_4211, fragment_unnamed_3295, 1.0f) * 0.5f))), fragment_unnamed_3295, fragment_unnamed_3316), mad(min(((-0.0f) - fragment_unnamed_4229) + 1.0f, max(fragment_unnamed_4229, mad(mad(fragment_unnamed_4181, 0.5f, 0.5f), fragment_unnamed_3299 * fragment_unnamed_4212, mad((-0.0f) - fragment_unnamed_4212, fragment_unnamed_3299, 1.0f) * 0.5f))), fragment_unnamed_3299, fragment_unnamed_3318)), 0.0f);
										fragment_unnamed_4487 = fragment_unnamed_4243.x;
										fragment_unnamed_4488 = fragment_unnamed_4243.y;
										fragment_unnamed_4489 = fragment_unnamed_4243.z;
										fragment_unnamed_4490 = asfloat(((((fragment_unnamed_4173 ? 4294967295u : 0u) & ((fragment_unnamed_2760 != 3u) ? 4294967295u : 0u)) != 0u) ? ((((fragment_unnamed_2759 * fragment_unnamed_2759) >= dot(float2(fragment_unnamed_4180, fragment_unnamed_4181), float2(fragment_unnamed_4180, fragment_unnamed_4181))) ? 4294967295u : 0u) & fragment_unnamed_4193) : fragment_unnamed_4193) & 1065353216u);
									}
									fragment_unnamed_4250 = fragment_unnamed_4490 * fragment_unnamed_3430;
									fragment_unnamed_4252 = fragment_unnamed_4487 * asfloat(fragment_unnamed_3273);
									fragment_unnamed_4254 = fragment_unnamed_4488 * asfloat(fragment_unnamed_3275);
									fragment_unnamed_4256 = fragment_unnamed_4489 * asfloat(fragment_unnamed_3296);
								}
								else
								{
									fragment_unnamed_4250 = fragment_unnamed_3430;
									fragment_unnamed_4252 = asfloat(fragment_unnamed_3273);
									fragment_unnamed_4254 = asfloat(fragment_unnamed_3275);
									fragment_unnamed_4256 = asfloat(fragment_unnamed_3296);
								}
								float fragment_unnamed_5289;
								if ((((0.0f < fragment_unnamed_3333) ? 4294967295u : 0u) & ((int(fragment_unnamed_3256) >= int(0u)) ? 4294967295u : 0u)) != 0u)
								{
									bool fragment_unnamed_4493 = fragment_unnamed_2760 != 4u;
									uint fragment_unnamed_4494 = fragment_unnamed_4493 ? 4294967295u : 0u;
									float fragment_unnamed_4500 = asfloat((dot(float3(fragment_unnamed_247, fragment_unnamed_248, fragment_unnamed_249), float3(fragment_unnamed_2797, fragment_unnamed_2798, fragment_unnamed_2799)) >= 0.0f) ? 1065353216u : 3212836864u);
									float fragment_unnamed_4501 = fragment_unnamed_247 * fragment_unnamed_4500;
									float fragment_unnamed_4502 = fragment_unnamed_248 * fragment_unnamed_4500;
									float fragment_unnamed_4503 = fragment_unnamed_249 * fragment_unnamed_4500;
									uint fragment_unnamed_4505 = (fragment_unnamed_3256 * 60u) + 8u;
									uint4 fragment_unnamed_4517 = uint4(T29.Load(fragment_unnamed_4505).x, T29.Load(fragment_unnamed_4505 + 1u).x, T29.Load(fragment_unnamed_4505 + 2u).x, T29.Load(fragment_unnamed_4505 + 3u).x);
									uint fragment_unnamed_4519 = fragment_unnamed_4517.y;
									float fragment_unnamed_4520 = asfloat(fragment_unnamed_4519);
									uint fragment_unnamed_4521 = fragment_unnamed_4517.z;
									float fragment_unnamed_4522 = asfloat(fragment_unnamed_4521);
									uint fragment_unnamed_4523 = fragment_unnamed_4517.w;
									float fragment_unnamed_4524 = asfloat(fragment_unnamed_4523);
									uint fragment_unnamed_4526 = (fragment_unnamed_3256 * 60u) + 12u;
									uint4 fragment_unnamed_4538 = uint4(T29.Load(fragment_unnamed_4526).x, T29.Load(fragment_unnamed_4526 + 1u).x, T29.Load(fragment_unnamed_4526 + 2u).x, T29.Load(fragment_unnamed_4526 + 3u).x);
									float fragment_unnamed_4540 = asfloat(fragment_unnamed_4538.x);
									float fragment_unnamed_4542 = asfloat(fragment_unnamed_4538.y);
									float fragment_unnamed_4544 = asfloat(fragment_unnamed_4538.z);
									float fragment_unnamed_4546 = asfloat(fragment_unnamed_4538.w);
									uint fragment_unnamed_4548 = (fragment_unnamed_3256 * 60u) + 16u;
									uint4 fragment_unnamed_4560 = uint4(T29.Load(fragment_unnamed_4548).x, T29.Load(fragment_unnamed_4548 + 1u).x, T29.Load(fragment_unnamed_4548 + 2u).x, T29.Load(fragment_unnamed_4548 + 3u).x);
									float fragment_unnamed_4566 = asfloat(fragment_unnamed_4560.z);
									float fragment_unnamed_4568 = asfloat(fragment_unnamed_4560.w);
									uint fragment_unnamed_4570 = (fragment_unnamed_3256 * 60u) + 24u;
									uint2 fragment_unnamed_4576 = uint2(T29.Load(fragment_unnamed_4570).x, T29.Load(fragment_unnamed_4570 + 1u).x);
									float fragment_unnamed_4578 = asfloat(fragment_unnamed_4576.x);
									float fragment_unnamed_4580 = asfloat(fragment_unnamed_4576.y);
									uint fragment_unnamed_4582 = (fragment_unnamed_3256 * 60u) + 40u;
									uint4 fragment_unnamed_4594 = uint4(T29.Load(fragment_unnamed_4582).x, T29.Load(fragment_unnamed_4582 + 1u).x, T29.Load(fragment_unnamed_4582 + 2u).x, T29.Load(fragment_unnamed_4582 + 3u).x);
									float fragment_unnamed_4596 = asfloat(fragment_unnamed_4594.x);
									float fragment_unnamed_4598 = asfloat(fragment_unnamed_4594.y);
									float fragment_unnamed_4600 = asfloat(fragment_unnamed_4594.z);
									float fragment_unnamed_4602 = asfloat(fragment_unnamed_4594.w);
									float fragment_unnamed_5693;
									float fragment_unnamed_5694;
									float fragment_unnamed_5695;
									float fragment_unnamed_5696;
									float fragment_unnamed_5697;
									float fragment_unnamed_5698;
									float fragment_unnamed_5699;
									float fragment_unnamed_5700;
									float fragment_unnamed_5701;
									float fragment_unnamed_5702;
									float fragment_unnamed_5703;
									if (fragment_unnamed_2760 == 1u)
									{
										float fragment_unnamed_5153 = abs(fragment_unnamed_2799);
										float fragment_unnamed_5155 = abs(fragment_unnamed_2797);
										uint fragment_unnamed_5182 = uint(asfloat(((((fragment_unnamed_5153 >= abs(fragment_unnamed_2798)) ? 4294967295u : 0u) & ((fragment_unnamed_5153 >= fragment_unnamed_5155) ? 4294967295u : 0u)) != 0u) ? ((((-0.0f) - fragment_unnamed_2799) < 0.0f) ? 1084227584u : 1082130432u) : ((abs(fragment_unnamed_2798) >= fragment_unnamed_5155) ? ((((-0.0f) - fragment_unnamed_2798) < 0.0f) ? 1077936128u : 1073741824u) : (((((-0.0f) - fragment_unnamed_2797) < 0.0f) ? 4294967295u : 0u) & 1065353216u))) + float(int(fragment_unnamed_3256)));
										uint fragment_unnamed_5183 = fragment_unnamed_5182 * 60u;
										uint3 fragment_unnamed_5192 = uint3(T29.Load(fragment_unnamed_5183).x, T29.Load(fragment_unnamed_5183 + 1u).x, T29.Load(fragment_unnamed_5183 + 2u).x);
										uint fragment_unnamed_5200 = (fragment_unnamed_5182 * 60u) + 3u;
										uint3 fragment_unnamed_5209 = uint3(T29.Load(fragment_unnamed_5200).x, T29.Load(fragment_unnamed_5200 + 1u).x, T29.Load(fragment_unnamed_5200 + 2u).x);
										uint fragment_unnamed_5217 = (fragment_unnamed_5182 * 60u) + 6u;
										uint3 fragment_unnamed_5226 = uint3(T29.Load(fragment_unnamed_5217).x, T29.Load(fragment_unnamed_5217 + 1u).x, T29.Load(fragment_unnamed_5217 + 2u).x);
										uint fragment_unnamed_5234 = (fragment_unnamed_5182 * 60u) + 16u;
										uint2 fragment_unnamed_5240 = uint2(T29.Load(fragment_unnamed_5234).x, T29.Load(fragment_unnamed_5234 + 1u).x);
										fragment_unnamed_5693 = asfloat(fragment_unnamed_5240.x);
										fragment_unnamed_5694 = asfloat(fragment_unnamed_5240.y);
										fragment_unnamed_5695 = asfloat(fragment_unnamed_5192.x);
										fragment_unnamed_5696 = asfloat(fragment_unnamed_5192.y);
										fragment_unnamed_5697 = asfloat(fragment_unnamed_5192.z);
										fragment_unnamed_5698 = asfloat(fragment_unnamed_5209.x);
										fragment_unnamed_5699 = asfloat(fragment_unnamed_5209.y);
										fragment_unnamed_5700 = asfloat(fragment_unnamed_5209.z);
										fragment_unnamed_5701 = asfloat(fragment_unnamed_5226.x);
										fragment_unnamed_5702 = asfloat(fragment_unnamed_5226.y);
										fragment_unnamed_5703 = asfloat(fragment_unnamed_5226.z);
									}
									else
									{
										uint fragment_unnamed_5245 = fragment_unnamed_3256 * 60u;
										uint4 fragment_unnamed_5257 = uint4(T29.Load(fragment_unnamed_5245).x, T29.Load(fragment_unnamed_5245 + 1u).x, T29.Load(fragment_unnamed_5245 + 2u).x, T29.Load(fragment_unnamed_5245 + 3u).x);
										uint fragment_unnamed_5264 = (fragment_unnamed_3256 * 60u) + 4u;
										uint4 fragment_unnamed_5276 = uint4(T29.Load(fragment_unnamed_5264).x, T29.Load(fragment_unnamed_5264 + 1u).x, T29.Load(fragment_unnamed_5264 + 2u).x, T29.Load(fragment_unnamed_5264 + 3u).x);
										fragment_unnamed_5693 = asfloat(fragment_unnamed_4560.x);
										fragment_unnamed_5694 = asfloat(fragment_unnamed_4560.y);
										fragment_unnamed_5695 = asfloat(fragment_unnamed_5257.x);
										fragment_unnamed_5696 = asfloat(fragment_unnamed_5257.y);
										fragment_unnamed_5697 = asfloat(fragment_unnamed_5257.z);
										fragment_unnamed_5698 = asfloat(fragment_unnamed_5257.w);
										fragment_unnamed_5699 = asfloat(fragment_unnamed_5276.x);
										fragment_unnamed_5700 = asfloat(fragment_unnamed_5276.y);
										fragment_unnamed_5701 = asfloat(fragment_unnamed_5276.z);
										fragment_unnamed_5702 = asfloat(fragment_unnamed_5276.w);
										fragment_unnamed_5703 = asfloat(fragment_unnamed_4517.x);
									}
									float fragment_unnamed_8523;
									if (0.0f < fragment_unnamed_4602)
									{
										bool fragment_unnamed_6348 = 0.0f != fragment_unnamed_4602;
										uint4 fragment_unnamed_6352 = asuint(fragment_uniform_buffer_1[100u]);
										uint4 fragment_unnamed_6358 = asuint(fragment_uniform_buffer_1[97u]);
										float fragment_unnamed_6362 = asfloat(fragment_unnamed_6348 ? fragment_unnamed_6352.z : fragment_unnamed_6358.z);
										float fragment_unnamed_6364 = asfloat(fragment_unnamed_6348 ? fragment_unnamed_6352.w : fragment_unnamed_6358.w);
										float fragment_unnamed_6366 = asfloat(fragment_unnamed_4493 ? fragment_unnamed_3351 : 1065353216u);
										float fragment_unnamed_6382 = mad(fragment_unnamed_4566 * (fragment_unnamed_4501 * fragment_unnamed_4568), fragment_unnamed_6366, fragment_unnamed_4596 + fragment_input_6.x);
										float fragment_unnamed_6383 = mad(fragment_unnamed_4566 * (fragment_unnamed_4502 * fragment_unnamed_4568), fragment_unnamed_6366, fragment_unnamed_4598 + fragment_input_6.y);
										float fragment_unnamed_6384 = mad(fragment_unnamed_4566 * (fragment_unnamed_4503 * fragment_unnamed_4568), fragment_unnamed_6366, fragment_unnamed_4600 + fragment_input_6.z);
										float fragment_unnamed_6388 = ((-0.0f) - fragment_unnamed_4520) + fragment_unnamed_6382;
										float fragment_unnamed_6389 = ((-0.0f) - fragment_unnamed_4522) + fragment_unnamed_6383;
										float fragment_unnamed_6390 = ((-0.0f) - fragment_unnamed_4524) + fragment_unnamed_6384;
										float fragment_unnamed_6423 = asfloat(fragment_unnamed_4493 ? asuint(dot(float3(fragment_unnamed_5701, fragment_unnamed_5702, fragment_unnamed_5703), float3(fragment_unnamed_6388, fragment_unnamed_6389, fragment_unnamed_6390))) : asuint(dot(float4(fragment_unnamed_5701, fragment_unnamed_5702, fragment_unnamed_5703, asfloat(fragment_unnamed_4523)), float4(fragment_unnamed_6382, fragment_unnamed_6383, fragment_unnamed_6384, fragment_unnamed_1800))));
										float fragment_unnamed_6428 = asfloat(fragment_unnamed_4493 ? asuint(dot(float3(fragment_unnamed_5695, fragment_unnamed_5696, fragment_unnamed_5697), float3(fragment_unnamed_6388, fragment_unnamed_6389, fragment_unnamed_6390))) : asuint(dot(float4(fragment_unnamed_5695, fragment_unnamed_5696, fragment_unnamed_5697, asfloat(fragment_unnamed_4519)), float4(fragment_unnamed_6382, fragment_unnamed_6383, fragment_unnamed_6384, fragment_unnamed_1800)))) * fragment_unnamed_4540;
										float fragment_unnamed_6429 = asfloat(fragment_unnamed_4493 ? asuint(dot(float3(fragment_unnamed_5698, fragment_unnamed_5699, fragment_unnamed_5700), float3(fragment_unnamed_6388, fragment_unnamed_6389, fragment_unnamed_6390))) : asuint(dot(float4(fragment_unnamed_5698, fragment_unnamed_5699, fragment_unnamed_5700, asfloat(fragment_unnamed_4521)), float4(fragment_unnamed_6382, fragment_unnamed_6383, fragment_unnamed_6384, fragment_unnamed_1800)))) * fragment_unnamed_4542;
										float fragment_unnamed_6430 = dot(float2(fragment_unnamed_4544, fragment_unnamed_4546), float2(fragment_unnamed_6423, fragment_unnamed_1801));
										float fragment_unnamed_6433 = dot(float2(asfloat(fragment_unnamed_4493 ? 3212836864u : 0u), asfloat(fragment_unnamed_4493 ? 0u : 1065353216u)), float2(fragment_unnamed_6423, fragment_unnamed_1801));
										bool fragment_unnamed_6442 = (fragment_unnamed_4494 & ((fragment_unnamed_6433 != 0.0f) ? 4294967295u : 0u)) != 0u;
										float fragment_unnamed_6461 = mad(fragment_unnamed_4578 * clamp(mad(asfloat(fragment_unnamed_6442 ? asuint(fragment_unnamed_6428 / fragment_unnamed_6433) : asuint(fragment_unnamed_6428)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6362, fragment_unnamed_5693);
										float fragment_unnamed_6462 = mad(fragment_unnamed_4580 * clamp(mad(asfloat(fragment_unnamed_6442 ? asuint(fragment_unnamed_6429 / fragment_unnamed_6433) : asuint(fragment_unnamed_6429)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6364, fragment_unnamed_5694);
										uint4 fragment_unnamed_6482 = asuint(fragment_uniform_buffer_1[100u]);
										uint4 fragment_unnamed_6489 = asuint(fragment_uniform_buffer_1[97u]);
										float fragment_unnamed_6495 = asfloat(fragment_unnamed_6348 ? fragment_unnamed_6482.z : fragment_unnamed_6489.z);
										float fragment_unnamed_6497 = asfloat(fragment_unnamed_6348 ? fragment_unnamed_6482.w : fragment_unnamed_6489.w);
										float fragment_unnamed_6499 = asfloat(fragment_unnamed_6348 ? fragment_unnamed_6482.x : fragment_unnamed_6489.x);
										float fragment_unnamed_6501 = asfloat(fragment_unnamed_6348 ? fragment_unnamed_6482.y : fragment_unnamed_6489.y);
										float fragment_unnamed_6502 = asfloat(fragment_unnamed_6442 ? asuint(fragment_unnamed_6430 / fragment_unnamed_6433) : asuint(fragment_unnamed_6430)) + 1.52587890625e-05f;
										float fragment_unnamed_6505 = floor(mad(fragment_unnamed_6461, fragment_unnamed_6499, 0.5f));
										float fragment_unnamed_6506 = floor(mad(fragment_unnamed_6462, fragment_unnamed_6501, 0.5f));
										float fragment_unnamed_6509 = mad(fragment_unnamed_6461, fragment_unnamed_6499, (-0.0f) - fragment_unnamed_6505);
										float fragment_unnamed_6510 = mad(fragment_unnamed_6462, fragment_unnamed_6501, (-0.0f) - fragment_unnamed_6506);
										float fragment_unnamed_6511 = fragment_unnamed_6509 + 0.5f;
										float fragment_unnamed_6512 = fragment_unnamed_6509 + 1.0f;
										float fragment_unnamed_6513 = fragment_unnamed_6510 + 0.5f;
										float fragment_unnamed_6514 = fragment_unnamed_6510 + 1.0f;
										float fragment_unnamed_6519 = (fragment_unnamed_6511 * fragment_unnamed_6511) * 0.07999999821186065673828125f;
										float fragment_unnamed_6521 = (fragment_unnamed_6513 * fragment_unnamed_6513) * 0.07999999821186065673828125f;
										float fragment_unnamed_6528 = ((-0.0f) - fragment_unnamed_6509) + 1.0f;
										float fragment_unnamed_6529 = ((-0.0f) - fragment_unnamed_6510) + 1.0f;
										float fragment_unnamed_6530 = min(fragment_unnamed_6509, 0.0f);
										float fragment_unnamed_6531 = min(fragment_unnamed_6510, 0.0f);
										float fragment_unnamed_6536 = max(fragment_unnamed_6509, 0.0f);
										float fragment_unnamed_6537 = max(fragment_unnamed_6510, 0.0f);
										float fragment_unnamed_6549 = fragment_unnamed_6528 * 0.1599999964237213134765625f;
										float fragment_unnamed_6550 = fragment_unnamed_6529 * 0.1599999964237213134765625f;
										float fragment_unnamed_6551 = (mad((-0.0f) - fragment_unnamed_6530, fragment_unnamed_6530, fragment_unnamed_6528) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6553 = (mad((-0.0f) - fragment_unnamed_6536, fragment_unnamed_6536, fragment_unnamed_6512) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6554 = (mad((-0.0f) - fragment_unnamed_6537, fragment_unnamed_6537, fragment_unnamed_6514) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6558 = (fragment_unnamed_6512 * 0.1599999964237213134765625f) + fragment_unnamed_6519;
										float fragment_unnamed_6559 = (mad(fragment_unnamed_6511 * fragment_unnamed_6511, 0.5f, (-0.0f) - fragment_unnamed_6509) * 0.1599999964237213134765625f) + fragment_unnamed_6549;
										float fragment_unnamed_6560 = fragment_unnamed_6551 + fragment_unnamed_6553;
										float fragment_unnamed_6561 = (mad(fragment_unnamed_6513 * fragment_unnamed_6513, 0.5f, (-0.0f) - fragment_unnamed_6510) * 0.1599999964237213134765625f) + fragment_unnamed_6550;
										float fragment_unnamed_6562 = ((mad((-0.0f) - fragment_unnamed_6531, fragment_unnamed_6531, fragment_unnamed_6529) + 1.0f) * 0.1599999964237213134765625f) + fragment_unnamed_6554;
										float fragment_unnamed_6563 = (fragment_unnamed_6514 * 0.1599999964237213134765625f) + fragment_unnamed_6521;
										float fragment_unnamed_6576 = fragment_unnamed_6495 * ((fragment_unnamed_6553 / fragment_unnamed_6560) + (-0.5f));
										float fragment_unnamed_6577 = fragment_unnamed_6495 * ((fragment_unnamed_6549 / fragment_unnamed_6559) + (-2.5f));
										float fragment_unnamed_6578 = fragment_unnamed_6495 * ((fragment_unnamed_6519 / fragment_unnamed_6558) + 1.5f);
										float fragment_unnamed_6579 = fragment_unnamed_6497 * ((fragment_unnamed_6550 / fragment_unnamed_6561) + (-2.5f));
										float fragment_unnamed_6580 = fragment_unnamed_6497 * ((fragment_unnamed_6554 / fragment_unnamed_6562) + (-0.5f));
										float fragment_unnamed_6581 = fragment_unnamed_6497 * ((fragment_unnamed_6521 / fragment_unnamed_6563) + 1.5f);
										float fragment_unnamed_6600 = fragment_unnamed_6561 * fragment_unnamed_6559;
										float fragment_unnamed_6601 = fragment_unnamed_6561 * fragment_unnamed_6560;
										float fragment_unnamed_6602 = fragment_unnamed_6561 * fragment_unnamed_6558;
										float fragment_unnamed_6603 = fragment_unnamed_6562 * fragment_unnamed_6559;
										float fragment_unnamed_6604 = fragment_unnamed_6562 * (fragment_unnamed_6551 + fragment_unnamed_6553);
										float fragment_unnamed_6605 = fragment_unnamed_6562 * fragment_unnamed_6558;
										float fragment_unnamed_6606 = fragment_unnamed_6563 * fragment_unnamed_6559;
										float fragment_unnamed_6607 = fragment_unnamed_6563 * fragment_unnamed_6560;
										float4 fragment_unnamed_6612 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6505, fragment_unnamed_6495, fragment_unnamed_6577), mad(fragment_unnamed_6506, fragment_unnamed_6497, fragment_unnamed_6579)), fragment_unnamed_6502).xxxx;
										float fragment_unnamed_6613 = fragment_unnamed_6612.x;
										float4 fragment_unnamed_6616 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6505, fragment_unnamed_6495, fragment_unnamed_6576), mad(fragment_unnamed_6506, fragment_unnamed_6497, fragment_unnamed_6579)), fragment_unnamed_6502).xxxx;
										float fragment_unnamed_6617 = fragment_unnamed_6616.x;
										float4 fragment_unnamed_6620 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6505, fragment_unnamed_6495, fragment_unnamed_6578), mad(fragment_unnamed_6506, fragment_unnamed_6497, fragment_unnamed_6579)), fragment_unnamed_6502).xxxx;
										float fragment_unnamed_6621 = fragment_unnamed_6620.x;
										float4 fragment_unnamed_6624 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6505, fragment_unnamed_6495, fragment_unnamed_6577), mad(fragment_unnamed_6506, fragment_unnamed_6497, fragment_unnamed_6580)), fragment_unnamed_6502).xxxx;
										float fragment_unnamed_6625 = fragment_unnamed_6624.x;
										float fragment_unnamed_6627 = asfloat(0u);
										float fragment_unnamed_7046;
										fragment_unnamed_7046 = asfloat(0u);
										for (float fragment_unnamed_7048 = fragment_unnamed_6627; !(int(asuint(fragment_unnamed_7048)) >= int(1u)); fragment_unnamed_7046 = mad(fragment_unnamed_6603, fragment_unnamed_6625, mad(fragment_unnamed_6602, fragment_unnamed_6621, mad(fragment_unnamed_6601, fragment_unnamed_6617, mad(fragment_unnamed_6600, fragment_unnamed_6613, fragment_unnamed_7046)))), fragment_unnamed_7048 = asfloat(asuint(fragment_unnamed_7048) + 1u))
										{
										}
										float4 fragment_unnamed_7491 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6505, fragment_unnamed_6495, fragment_unnamed_6576), mad(fragment_unnamed_6506, fragment_unnamed_6497, fragment_unnamed_6580)), fragment_unnamed_6502).xxxx;
										float fragment_unnamed_7492 = fragment_unnamed_7491.x;
										float4 fragment_unnamed_7495 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6505, fragment_unnamed_6495, fragment_unnamed_6578), mad(fragment_unnamed_6506, fragment_unnamed_6497, fragment_unnamed_6580)), fragment_unnamed_6502).xxxx;
										float fragment_unnamed_7496 = fragment_unnamed_7495.x;
										float4 fragment_unnamed_7499 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6505, fragment_unnamed_6495, fragment_unnamed_6577), mad(fragment_unnamed_6506, fragment_unnamed_6497, fragment_unnamed_6581)), fragment_unnamed_6502).xxxx;
										float fragment_unnamed_7500 = fragment_unnamed_7499.x;
										float4 fragment_unnamed_7503 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6505, fragment_unnamed_6495, fragment_unnamed_6576), mad(fragment_unnamed_6506, fragment_unnamed_6497, fragment_unnamed_6581)), fragment_unnamed_6502).xxxx;
										float fragment_unnamed_7504 = fragment_unnamed_7503.x;
										float fragment_unnamed_7505 = asfloat(0u);
										float fragment_unnamed_7960;
										fragment_unnamed_7960 = fragment_unnamed_7046;
										float fragment_unnamed_7961;
										for (float fragment_unnamed_7962 = fragment_unnamed_7505; !(int(asuint(fragment_unnamed_7962)) >= int(1u)); fragment_unnamed_7961 = mad(fragment_unnamed_6607, fragment_unnamed_7504, mad(fragment_unnamed_6606, fragment_unnamed_7500, mad(fragment_unnamed_6605, fragment_unnamed_7496, mad(fragment_unnamed_6604, fragment_unnamed_7492, fragment_unnamed_7960)))), fragment_unnamed_7960 = fragment_unnamed_7961, fragment_unnamed_7962 = asfloat(asuint(fragment_unnamed_7962) + 1u))
										{
										}
										fragment_unnamed_8523 = asfloat((((((mad(fragment_unnamed_4580 + (-0.5f), fragment_unnamed_6364, fragment_unnamed_5694) < fragment_unnamed_6462) ? 4294967295u : 0u) | ((mad(fragment_unnamed_4578 + (-0.5f), fragment_unnamed_6362, fragment_unnamed_5693) < fragment_unnamed_6461) ? 4294967295u : 0u)) | (((fragment_unnamed_6462 < (fragment_unnamed_5694 + fragment_unnamed_6364)) ? 4294967295u : 0u) | ((fragment_unnamed_6461 < (fragment_unnamed_5693 + fragment_unnamed_6362)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(mad(fragment_unnamed_6563 * fragment_unnamed_6558, _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6505, fragment_unnamed_6495, fragment_unnamed_6578), mad(fragment_unnamed_6506, fragment_unnamed_6497, fragment_unnamed_6581)), fragment_unnamed_6502).xxxx.x, fragment_unnamed_7960)));
									}
									else
									{
										bool fragment_unnamed_6628 = 0.0f != fragment_unnamed_4602;
										uint4 fragment_unnamed_6631 = asuint(fragment_uniform_buffer_1[100u]);
										uint4 fragment_unnamed_6636 = asuint(fragment_uniform_buffer_1[97u]);
										float fragment_unnamed_6640 = asfloat(fragment_unnamed_6628 ? fragment_unnamed_6631.z : fragment_unnamed_6636.z);
										float fragment_unnamed_6642 = asfloat(fragment_unnamed_6628 ? fragment_unnamed_6631.w : fragment_unnamed_6636.w);
										float fragment_unnamed_6644 = asfloat(fragment_unnamed_4493 ? fragment_unnamed_3351 : 1065353216u);
										float fragment_unnamed_6660 = mad(fragment_unnamed_4566 * (fragment_unnamed_4501 * fragment_unnamed_4568), fragment_unnamed_6644, fragment_unnamed_4596 + fragment_input_6.x);
										float fragment_unnamed_6661 = mad(fragment_unnamed_4566 * (fragment_unnamed_4502 * fragment_unnamed_4568), fragment_unnamed_6644, fragment_unnamed_4598 + fragment_input_6.y);
										float fragment_unnamed_6662 = mad(fragment_unnamed_4566 * (fragment_unnamed_4503 * fragment_unnamed_4568), fragment_unnamed_6644, fragment_unnamed_4600 + fragment_input_6.z);
										float fragment_unnamed_6666 = ((-0.0f) - fragment_unnamed_4520) + fragment_unnamed_6660;
										float fragment_unnamed_6667 = ((-0.0f) - fragment_unnamed_4522) + fragment_unnamed_6661;
										float fragment_unnamed_6668 = ((-0.0f) - fragment_unnamed_4524) + fragment_unnamed_6662;
										float fragment_unnamed_6700 = asfloat(fragment_unnamed_4493 ? asuint(dot(float3(fragment_unnamed_5701, fragment_unnamed_5702, fragment_unnamed_5703), float3(fragment_unnamed_6666, fragment_unnamed_6667, fragment_unnamed_6668))) : asuint(dot(float4(fragment_unnamed_5701, fragment_unnamed_5702, fragment_unnamed_5703, fragment_unnamed_4524), float4(fragment_unnamed_6660, fragment_unnamed_6661, fragment_unnamed_6662, fragment_unnamed_1802))));
										float fragment_unnamed_6705 = asfloat(fragment_unnamed_4493 ? asuint(dot(float3(fragment_unnamed_5695, fragment_unnamed_5696, fragment_unnamed_5697), float3(fragment_unnamed_6666, fragment_unnamed_6667, fragment_unnamed_6668))) : asuint(dot(float4(fragment_unnamed_5695, fragment_unnamed_5696, fragment_unnamed_5697, asfloat(fragment_unnamed_4519)), float4(fragment_unnamed_6660, fragment_unnamed_6661, fragment_unnamed_6662, fragment_unnamed_1802)))) * fragment_unnamed_4540;
										float fragment_unnamed_6706 = asfloat(fragment_unnamed_4493 ? asuint(dot(float3(fragment_unnamed_5698, fragment_unnamed_5699, fragment_unnamed_5700), float3(fragment_unnamed_6666, fragment_unnamed_6667, fragment_unnamed_6668))) : asuint(dot(float4(fragment_unnamed_5698, fragment_unnamed_5699, fragment_unnamed_5700, asfloat(fragment_unnamed_4521)), float4(fragment_unnamed_6660, fragment_unnamed_6661, fragment_unnamed_6662, fragment_unnamed_1802)))) * fragment_unnamed_4542;
										float fragment_unnamed_6707 = dot(float2(fragment_unnamed_4544, fragment_unnamed_4546), float2(fragment_unnamed_6700, fragment_unnamed_1803));
										float fragment_unnamed_6710 = dot(float2(asfloat(fragment_unnamed_4493 ? 3212836864u : 0u), asfloat(fragment_unnamed_4493 ? 0u : 1065353216u)), float2(fragment_unnamed_6700, fragment_unnamed_1803));
										bool fragment_unnamed_6719 = (fragment_unnamed_4494 & ((fragment_unnamed_6710 != 0.0f) ? 4294967295u : 0u)) != 0u;
										float fragment_unnamed_6738 = mad(fragment_unnamed_4578 * clamp(mad(asfloat(fragment_unnamed_6719 ? asuint(fragment_unnamed_6705 / fragment_unnamed_6710) : asuint(fragment_unnamed_6705)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6640, fragment_unnamed_5693);
										float fragment_unnamed_6739 = mad(fragment_unnamed_4580 * clamp(mad(asfloat(fragment_unnamed_6719 ? asuint(fragment_unnamed_6706 / fragment_unnamed_6710) : asuint(fragment_unnamed_6706)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6642, fragment_unnamed_5694);
										uint4 fragment_unnamed_6759 = asuint(fragment_uniform_buffer_1[100u]);
										uint4 fragment_unnamed_6766 = asuint(fragment_uniform_buffer_1[97u]);
										float fragment_unnamed_6772 = asfloat(fragment_unnamed_6628 ? fragment_unnamed_6759.z : fragment_unnamed_6766.z);
										float fragment_unnamed_6774 = asfloat(fragment_unnamed_6628 ? fragment_unnamed_6759.w : fragment_unnamed_6766.w);
										float fragment_unnamed_6776 = asfloat(fragment_unnamed_6628 ? fragment_unnamed_6759.x : fragment_unnamed_6766.x);
										float fragment_unnamed_6778 = asfloat(fragment_unnamed_6628 ? fragment_unnamed_6759.y : fragment_unnamed_6766.y);
										float fragment_unnamed_6779 = asfloat(fragment_unnamed_6719 ? asuint(fragment_unnamed_6707 / fragment_unnamed_6710) : asuint(fragment_unnamed_6707)) + 1.52587890625e-05f;
										float fragment_unnamed_6782 = floor(mad(fragment_unnamed_6738, fragment_unnamed_6776, 0.5f));
										float fragment_unnamed_6783 = floor(mad(fragment_unnamed_6739, fragment_unnamed_6778, 0.5f));
										float fragment_unnamed_6786 = mad(fragment_unnamed_6738, fragment_unnamed_6776, (-0.0f) - fragment_unnamed_6782);
										float fragment_unnamed_6787 = mad(fragment_unnamed_6739, fragment_unnamed_6778, (-0.0f) - fragment_unnamed_6783);
										float fragment_unnamed_6788 = fragment_unnamed_6786 + 0.5f;
										float fragment_unnamed_6789 = fragment_unnamed_6786 + 1.0f;
										float fragment_unnamed_6790 = fragment_unnamed_6787 + 0.5f;
										float fragment_unnamed_6791 = fragment_unnamed_6787 + 1.0f;
										float fragment_unnamed_6796 = (fragment_unnamed_6788 * fragment_unnamed_6788) * 0.07999999821186065673828125f;
										float fragment_unnamed_6797 = (fragment_unnamed_6790 * fragment_unnamed_6790) * 0.07999999821186065673828125f;
										float fragment_unnamed_6804 = ((-0.0f) - fragment_unnamed_6786) + 1.0f;
										float fragment_unnamed_6805 = ((-0.0f) - fragment_unnamed_6787) + 1.0f;
										float fragment_unnamed_6806 = min(fragment_unnamed_6786, 0.0f);
										float fragment_unnamed_6807 = min(fragment_unnamed_6787, 0.0f);
										float fragment_unnamed_6812 = max(fragment_unnamed_6786, 0.0f);
										float fragment_unnamed_6813 = max(fragment_unnamed_6787, 0.0f);
										float fragment_unnamed_6824 = fragment_unnamed_6804 * 0.1599999964237213134765625f;
										float fragment_unnamed_6825 = fragment_unnamed_6805 * 0.1599999964237213134765625f;
										float fragment_unnamed_6826 = (mad((-0.0f) - fragment_unnamed_6806, fragment_unnamed_6806, fragment_unnamed_6804) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6828 = (mad((-0.0f) - fragment_unnamed_6812, fragment_unnamed_6812, fragment_unnamed_6789) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6829 = (mad((-0.0f) - fragment_unnamed_6813, fragment_unnamed_6813, fragment_unnamed_6791) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6833 = (fragment_unnamed_6789 * 0.1599999964237213134765625f) + fragment_unnamed_6796;
										float fragment_unnamed_6834 = (mad(fragment_unnamed_6788 * fragment_unnamed_6788, 0.5f, (-0.0f) - fragment_unnamed_6786) * 0.1599999964237213134765625f) + fragment_unnamed_6824;
										float fragment_unnamed_6835 = fragment_unnamed_6826 + fragment_unnamed_6828;
										float fragment_unnamed_6836 = (mad(fragment_unnamed_6790 * fragment_unnamed_6790, 0.5f, (-0.0f) - fragment_unnamed_6787) * 0.1599999964237213134765625f) + fragment_unnamed_6825;
										float fragment_unnamed_6837 = ((mad((-0.0f) - fragment_unnamed_6807, fragment_unnamed_6807, fragment_unnamed_6805) + 1.0f) * 0.1599999964237213134765625f) + fragment_unnamed_6829;
										float fragment_unnamed_6838 = (fragment_unnamed_6791 * 0.1599999964237213134765625f) + fragment_unnamed_6797;
										float fragment_unnamed_6851 = fragment_unnamed_6772 * ((fragment_unnamed_6828 / fragment_unnamed_6835) + (-0.5f));
										float fragment_unnamed_6852 = fragment_unnamed_6772 * ((fragment_unnamed_6824 / fragment_unnamed_6834) + (-2.5f));
										float fragment_unnamed_6853 = fragment_unnamed_6772 * ((fragment_unnamed_6796 / fragment_unnamed_6833) + 1.5f);
										float fragment_unnamed_6854 = fragment_unnamed_6774 * ((fragment_unnamed_6825 / fragment_unnamed_6836) + (-2.5f));
										float fragment_unnamed_6855 = fragment_unnamed_6774 * ((fragment_unnamed_6829 / fragment_unnamed_6837) + (-0.5f));
										float fragment_unnamed_6856 = fragment_unnamed_6774 * ((fragment_unnamed_6797 / fragment_unnamed_6838) + 1.5f);
										float fragment_unnamed_6875 = fragment_unnamed_6836 * fragment_unnamed_6834;
										float fragment_unnamed_6876 = fragment_unnamed_6836 * fragment_unnamed_6835;
										float fragment_unnamed_6877 = fragment_unnamed_6836 * fragment_unnamed_6833;
										float fragment_unnamed_6878 = fragment_unnamed_6837 * fragment_unnamed_6834;
										float fragment_unnamed_6879 = fragment_unnamed_6837 * (fragment_unnamed_6826 + fragment_unnamed_6828);
										float fragment_unnamed_6880 = fragment_unnamed_6837 * fragment_unnamed_6833;
										float fragment_unnamed_6881 = fragment_unnamed_6838 * fragment_unnamed_6834;
										float fragment_unnamed_6882 = fragment_unnamed_6838 * fragment_unnamed_6835;
										float4 fragment_unnamed_6887 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6782, fragment_unnamed_6772, fragment_unnamed_6852), mad(fragment_unnamed_6783, fragment_unnamed_6774, fragment_unnamed_6854)), fragment_unnamed_6779).xxxx;
										float fragment_unnamed_6888 = fragment_unnamed_6887.x;
										float4 fragment_unnamed_6891 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6782, fragment_unnamed_6772, fragment_unnamed_6851), mad(fragment_unnamed_6783, fragment_unnamed_6774, fragment_unnamed_6854)), fragment_unnamed_6779).xxxx;
										float fragment_unnamed_6892 = fragment_unnamed_6891.x;
										float4 fragment_unnamed_6895 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6782, fragment_unnamed_6772, fragment_unnamed_6853), mad(fragment_unnamed_6783, fragment_unnamed_6774, fragment_unnamed_6854)), fragment_unnamed_6779).xxxx;
										float fragment_unnamed_6896 = fragment_unnamed_6895.x;
										float4 fragment_unnamed_6899 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6782, fragment_unnamed_6772, fragment_unnamed_6852), mad(fragment_unnamed_6783, fragment_unnamed_6774, fragment_unnamed_6855)), fragment_unnamed_6779).xxxx;
										float fragment_unnamed_6900 = fragment_unnamed_6899.x;
										float fragment_unnamed_6902 = asfloat(0u);
										float fragment_unnamed_7052;
										fragment_unnamed_7052 = asfloat(0u);
										for (float fragment_unnamed_7054 = fragment_unnamed_6902; !(int(asuint(fragment_unnamed_7054)) >= int(1u)); fragment_unnamed_7052 = mad(fragment_unnamed_6878, fragment_unnamed_6900, mad(fragment_unnamed_6877, fragment_unnamed_6896, mad(fragment_unnamed_6876, fragment_unnamed_6892, mad(fragment_unnamed_6875, fragment_unnamed_6888, fragment_unnamed_7052)))), fragment_unnamed_7054 = asfloat(asuint(fragment_unnamed_7054) + 1u))
										{
										}
										float4 fragment_unnamed_7514 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6782, fragment_unnamed_6772, fragment_unnamed_6851), mad(fragment_unnamed_6783, fragment_unnamed_6774, fragment_unnamed_6855)), fragment_unnamed_6779).xxxx;
										float fragment_unnamed_7515 = fragment_unnamed_7514.x;
										float4 fragment_unnamed_7518 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6782, fragment_unnamed_6772, fragment_unnamed_6853), mad(fragment_unnamed_6783, fragment_unnamed_6774, fragment_unnamed_6855)), fragment_unnamed_6779).xxxx;
										float fragment_unnamed_7519 = fragment_unnamed_7518.x;
										float4 fragment_unnamed_7522 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6782, fragment_unnamed_6772, fragment_unnamed_6852), mad(fragment_unnamed_6783, fragment_unnamed_6774, fragment_unnamed_6856)), fragment_unnamed_6779).xxxx;
										float fragment_unnamed_7523 = fragment_unnamed_7522.x;
										float4 fragment_unnamed_7526 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6782, fragment_unnamed_6772, fragment_unnamed_6851), mad(fragment_unnamed_6783, fragment_unnamed_6774, fragment_unnamed_6856)), fragment_unnamed_6779).xxxx;
										float fragment_unnamed_7527 = fragment_unnamed_7526.x;
										float fragment_unnamed_7528 = asfloat(0u);
										float fragment_unnamed_7966;
										fragment_unnamed_7966 = fragment_unnamed_7052;
										float fragment_unnamed_7967;
										for (float fragment_unnamed_7968 = fragment_unnamed_7528; !(int(asuint(fragment_unnamed_7968)) >= int(1u)); fragment_unnamed_7967 = mad(fragment_unnamed_6882, fragment_unnamed_7527, mad(fragment_unnamed_6881, fragment_unnamed_7523, mad(fragment_unnamed_6880, fragment_unnamed_7519, mad(fragment_unnamed_6879, fragment_unnamed_7515, fragment_unnamed_7966)))), fragment_unnamed_7966 = fragment_unnamed_7967, fragment_unnamed_7968 = asfloat(asuint(fragment_unnamed_7968) + 1u))
										{
										}
										fragment_unnamed_8523 = asfloat((((((mad(fragment_unnamed_4580 + (-0.5f), fragment_unnamed_6642, fragment_unnamed_5694) < fragment_unnamed_6739) ? 4294967295u : 0u) | ((mad(fragment_unnamed_4578 + (-0.5f), fragment_unnamed_6640, fragment_unnamed_5693) < fragment_unnamed_6738) ? 4294967295u : 0u)) | (((fragment_unnamed_6739 < (fragment_unnamed_6642 + fragment_unnamed_5694)) ? 4294967295u : 0u) | ((fragment_unnamed_6738 < (fragment_unnamed_6640 + fragment_unnamed_5693)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(mad(fragment_unnamed_6838 * fragment_unnamed_6833, _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6782, fragment_unnamed_6772, fragment_unnamed_6853), mad(fragment_unnamed_6783, fragment_unnamed_6774, fragment_unnamed_6856)), fragment_unnamed_6779).xxxx.x, fragment_unnamed_7966)));
									}
									fragment_unnamed_5289 = mad(fragment_unnamed_3333, fragment_unnamed_8523 + (-1.0f), 1.0f);
								}
								else
								{
									fragment_unnamed_5289 = asfloat(1065353216u);
								}
								float fragment_unnamed_5291 = asfloat(fragment_unnamed_3314.z);
								float fragment_unnamed_5292 = asfloat(fragment_unnamed_3314.w);
								float fragment_unnamed_5296 = ((-0.0f) - fragment_unnamed_5291) + 1.0f;
								float fragment_unnamed_5297 = ((-0.0f) - fragment_unnamed_5292) + 1.0f;
								float fragment_unnamed_5298 = ((-0.0f) - fragment_unnamed_3331) + 1.0f;
								float fragment_unnamed_5300 = fragment_unnamed_5289 * (fragment_unnamed_5289 * fragment_unnamed_5289);
								float fragment_unnamed_5303 = (-0.0f) - (((-0.0f) - fragment_unnamed_5289) + 1.0f);
								float fragment_unnamed_5304 = mad(fragment_unnamed_5303, fragment_unnamed_5296, 1.0f);
								float fragment_unnamed_5305 = mad(fragment_unnamed_5303, fragment_unnamed_5297, 1.0f);
								float fragment_unnamed_5306 = mad(fragment_unnamed_5303, fragment_unnamed_5298, 1.0f);
								float fragment_unnamed_5322 = (fragment_unnamed_4250 * fragment_unnamed_4252) * mad(fragment_unnamed_3234, ((-0.0f) - fragment_unnamed_5304) + mad(fragment_unnamed_5300, fragment_unnamed_5296, fragment_unnamed_5291 * fragment_unnamed_5289), fragment_unnamed_5304);
								float fragment_unnamed_5323 = (fragment_unnamed_4250 * fragment_unnamed_4254) * mad(fragment_unnamed_3234, ((-0.0f) - fragment_unnamed_5305) + mad(fragment_unnamed_5300, fragment_unnamed_5297, fragment_unnamed_5292 * fragment_unnamed_5289), fragment_unnamed_5305);
								float fragment_unnamed_5324 = (fragment_unnamed_4250 * fragment_unnamed_4256) * mad(fragment_unnamed_3234, ((-0.0f) - fragment_unnamed_5306) + mad(fragment_unnamed_5300, fragment_unnamed_5298, fragment_unnamed_3331 * fragment_unnamed_5289), fragment_unnamed_5306);
								float fragment_unnamed_3571;
								float fragment_unnamed_3573;
								float fragment_unnamed_3575;
								float fragment_unnamed_3577;
								float fragment_unnamed_3579;
								float fragment_unnamed_3581;
								if (0.0f < max(fragment_unnamed_5324, max(fragment_unnamed_5323, fragment_unnamed_5322)))
								{
									uint fragment_unnamed_5712 = (fragment_unnamed_2073 * 56u) + 49u;
									uint2 fragment_unnamed_5718 = uint2(T6.Load(fragment_unnamed_5712).x, T6.Load(fragment_unnamed_5712 + 1u).x);
									float fragment_unnamed_5720 = asfloat(fragment_unnamed_5718.x);
									float fragment_unnamed_5722 = asfloat(fragment_unnamed_5718.y);
									float fragment_unnamed_5723 = max(fragment_unnamed_1100, asfloat(T6.Load((fragment_unnamed_2073 * 56u) + 38u).x));
									float fragment_unnamed_5724 = clamp(fragment_unnamed_2802, 0.0f, 1.0f);
									float fragment_unnamed_5725 = dot(float3(fragment_unnamed_2797, fragment_unnamed_2798, fragment_unnamed_2799), float3(fragment_unnamed_341, fragment_unnamed_342, fragment_unnamed_343));
									float fragment_unnamed_5730 = rsqrt(max(mad(fragment_unnamed_5725, 2.0f, 2.0f), 5.9604644775390625e-08f));
									float fragment_unnamed_5733 = clamp(fragment_unnamed_5730 * (fragment_unnamed_1018 + fragment_unnamed_2802), 0.0f, 1.0f);
									float fragment_unnamed_5737 = ((-0.0f) - clamp(mad(fragment_unnamed_5730, fragment_unnamed_5725, fragment_unnamed_5730), 0.0f, 1.0f)) + 1.0f;
									float fragment_unnamed_5738 = fragment_unnamed_5737 * fragment_unnamed_5737;
									float fragment_unnamed_5739 = fragment_unnamed_5738 * fragment_unnamed_5738;
									float fragment_unnamed_5742 = mad((-0.0f) - fragment_unnamed_5739, fragment_unnamed_5737, 1.0f);
									float fragment_unnamed_5743 = fragment_unnamed_1099 * (fragment_unnamed_5737 * fragment_unnamed_5739);
									float fragment_unnamed_5747 = fragment_unnamed_5723 * fragment_unnamed_5723;
									float fragment_unnamed_5750 = mad(mad(fragment_unnamed_5733, fragment_unnamed_5747, (-0.0f) - fragment_unnamed_5733), fragment_unnamed_5733, 1.0f);
									float fragment_unnamed_5766 = (fragment_unnamed_5747 * 0.15915493667125701904296875f) / max(mad(abs(fragment_unnamed_2802), fragment_unnamed_1119, fragment_unnamed_1021 * sqrt(mad(mad((-0.0f) - abs(fragment_unnamed_2802), fragment_unnamed_5747, abs(fragment_unnamed_2802)), abs(fragment_unnamed_2802), fragment_unnamed_5747))) * (fragment_unnamed_5750 * fragment_unnamed_5750), 1.1754943508222875079687365372222e-38f);
									float fragment_unnamed_5773 = ((-0.0f) - abs(fragment_unnamed_2802)) + 1.0f;
									float fragment_unnamed_5774 = fragment_unnamed_5773 * fragment_unnamed_5773;
									float fragment_unnamed_5777 = mad(fragment_unnamed_998, fragment_unnamed_5725, fragment_unnamed_998) + (-0.5f);
									float fragment_unnamed_5782 = ((mad(fragment_unnamed_5777, fragment_unnamed_1799, 1.0f) * mad(fragment_unnamed_5777, fragment_unnamed_5773 * (fragment_unnamed_5774 * fragment_unnamed_5774), 1.0f)) * fragment_unnamed_5724) * 0.307334959506988525390625f;
									fragment_unnamed_3571 = fragment_unnamed_5722 * (fragment_unnamed_5322 * (fragment_unnamed_5724 * (fragment_unnamed_5766 * mad(fragment_unnamed_1014, fragment_unnamed_5742, fragment_unnamed_5743))));
									fragment_unnamed_3573 = fragment_unnamed_5722 * (fragment_unnamed_5323 * (fragment_unnamed_5724 * (fragment_unnamed_5766 * mad(fragment_unnamed_1016, fragment_unnamed_5742, fragment_unnamed_5743))));
									fragment_unnamed_3575 = fragment_unnamed_5722 * (fragment_unnamed_5324 * (fragment_unnamed_5724 * (fragment_unnamed_5766 * mad(fragment_unnamed_1017, fragment_unnamed_5742, fragment_unnamed_5743))));
									fragment_unnamed_3577 = fragment_unnamed_5720 * (fragment_unnamed_5322 * fragment_unnamed_5782);
									fragment_unnamed_3579 = fragment_unnamed_5720 * (fragment_unnamed_5323 * fragment_unnamed_5782);
									fragment_unnamed_3581 = fragment_unnamed_5720 * (fragment_unnamed_5324 * fragment_unnamed_5782);
								}
								else
								{
									fragment_unnamed_3571 = asfloat(0u);
									fragment_unnamed_3573 = asfloat(0u);
									fragment_unnamed_3575 = asfloat(0u);
									fragment_unnamed_3577 = asfloat(0u);
									fragment_unnamed_3579 = asfloat(0u);
									fragment_unnamed_3581 = asfloat(0u);
								}
								fragment_unnamed_3570 = fragment_unnamed_3571;
								fragment_unnamed_3572 = fragment_unnamed_3573;
								fragment_unnamed_3574 = fragment_unnamed_3575;
								fragment_unnamed_3576 = fragment_unnamed_3577;
								fragment_unnamed_3578 = fragment_unnamed_3579;
								fragment_unnamed_3580 = fragment_unnamed_3581;
							}
							else
							{
								fragment_unnamed_3570 = asfloat(0u);
								fragment_unnamed_3572 = asfloat(0u);
								fragment_unnamed_3574 = asfloat(0u);
								fragment_unnamed_3576 = asfloat(0u);
								fragment_unnamed_3578 = asfloat(0u);
								fragment_unnamed_3580 = asfloat(0u);
							}
							fragment_unnamed_1916 = fragment_unnamed_3576 + fragment_unnamed_1915;
							fragment_unnamed_1918 = fragment_unnamed_3578 + fragment_unnamed_1917;
							fragment_unnamed_1920 = fragment_unnamed_3570 + fragment_unnamed_1919;
							fragment_unnamed_1922 = fragment_unnamed_3572 + fragment_unnamed_1921;
							fragment_unnamed_1924 = fragment_unnamed_3580 + fragment_unnamed_1923;
							fragment_unnamed_1926 = fragment_unnamed_3574 + fragment_unnamed_1925;
							fragment_unnamed_1913 = fragment_unnamed_1914;
							fragment_unnamed_1915 = fragment_unnamed_1916;
							fragment_unnamed_1917 = fragment_unnamed_1918;
							fragment_unnamed_1919 = fragment_unnamed_1920;
							fragment_unnamed_1921 = fragment_unnamed_1922;
							fragment_unnamed_1923 = fragment_unnamed_1924;
							fragment_unnamed_1925 = fragment_unnamed_1926;
							continue;
						}
					}
					if (ladder_phi_41)
					{
						break;
					}
					break;
				}
				uint4 fragment_unnamed_2045 = asuint(fragment_uniform_buffer_1[128u]);
				uint fragment_unnamed_2046 = fragment_unnamed_2045.y;
				uint4 fragment_unnamed_2053 = asuint(fragment_uniform_buffer_1[128u]);
				uint fragment_unnamed_2054 = fragment_unnamed_2053.x;
				uint4 fragment_unnamed_2059 = T3.Load(((((fragment_unnamed_1757 + (2u << (fragment_unnamed_1720 & 31u))) * fragment_unnamed_2046) + fragment_unnamed_282) * fragment_unnamed_2054) + fragment_unnamed_280);
				uint fragment_unnamed_2060 = fragment_unnamed_2059.x;
				uint fragment_unnamed_2061 = fragment_unnamed_2060 & 67108863u;
				uint fragment_unnamed_2062 = fragment_unnamed_2060 >> 26u;
				float fragment_unnamed_2063 = asfloat(0u);
				float fragment_unnamed_2064 = asfloat(0u);
				float fragment_unnamed_2065 = asfloat(0u);
				float fragment_unnamed_2066 = asfloat(0u);
				float fragment_unnamed_2067 = asfloat(0u);
				float fragment_unnamed_2068 = asfloat(0u);
				float fragment_unnamed_2069 = asfloat(0u);
				float fragment_unnamed_2353;
				float fragment_unnamed_2355;
				float fragment_unnamed_2357;
				float fragment_unnamed_2359;
				float fragment_unnamed_2361;
				for (;;)
				{
					fragment_unnamed_2353 = fragment_unnamed_2068;
					fragment_unnamed_2355 = fragment_unnamed_2065;
					fragment_unnamed_2357 = fragment_unnamed_2066;
					fragment_unnamed_2359 = fragment_unnamed_2067;
					fragment_unnamed_2361 = fragment_unnamed_2069;
					float fragment_unnamed_2362;
					float fragment_unnamed_2354;
					float fragment_unnamed_2356;
					float fragment_unnamed_2358;
					float fragment_unnamed_2360;
					bool ladder_phi_56;
					for (;;)
					{
						if (asuint(fragment_unnamed_2361) >= fragment_unnamed_2062)
						{
							ladder_phi_56 = true;
							break;
						}
						else
						{
							uint4 fragment_unnamed_2714 = T2.Load(fragment_unnamed_2061 + asuint(fragment_unnamed_2361));
							uint fragment_unnamed_2715 = fragment_unnamed_2714.x;
							if (fragment_unnamed_2715 == 4294967295u)
							{
								ladder_phi_56 = false;
								break;
							}
							fragment_unnamed_2362 = asfloat(asuint(fragment_unnamed_2361) + 1u);
							if (fragment_unnamed_2353 < 1.0f)
							{
								uint fragment_unnamed_3533 = fragment_unnamed_2715 * 72u;
								uint4 fragment_unnamed_3546 = uint4(T7.Load(fragment_unnamed_3533).x, T7.Load(fragment_unnamed_3533 + 1u).x, T7.Load(fragment_unnamed_3533 + 2u).x, T7.Load(fragment_unnamed_3533 + 3u).x);
								float fragment_unnamed_3549 = asfloat(fragment_unnamed_3546.y);
								float fragment_unnamed_3551 = asfloat(fragment_unnamed_3546.z);
								float fragment_unnamed_3553 = asfloat(fragment_unnamed_3546.w);
								float fragment_unnamed_4091;
								float fragment_unnamed_4093;
								float fragment_unnamed_4095;
								float fragment_unnamed_4097;
								if ((fragment_unnamed_676 & fragment_unnamed_3546.x) != 0u)
								{
									uint fragment_unnamed_3733 = (fragment_unnamed_2715 * 72u) + 4u;
									uint4 fragment_unnamed_3745 = uint4(T7.Load(fragment_unnamed_3733).x, T7.Load(fragment_unnamed_3733 + 1u).x, T7.Load(fragment_unnamed_3733 + 2u).x, T7.Load(fragment_unnamed_3733 + 3u).x);
									uint fragment_unnamed_3746 = fragment_unnamed_3745.x;
									float fragment_unnamed_3748 = asfloat(fragment_unnamed_3745.y);
									float fragment_unnamed_3750 = asfloat(fragment_unnamed_3745.z);
									float fragment_unnamed_3752 = asfloat(fragment_unnamed_3745.w);
									uint fragment_unnamed_3754 = (fragment_unnamed_2715 * 72u) + 8u;
									uint4 fragment_unnamed_3766 = uint4(T7.Load(fragment_unnamed_3754).x, T7.Load(fragment_unnamed_3754 + 1u).x, T7.Load(fragment_unnamed_3754 + 2u).x, T7.Load(fragment_unnamed_3754 + 3u).x);
									float fragment_unnamed_3768 = asfloat(fragment_unnamed_3766.x);
									uint fragment_unnamed_3776 = (fragment_unnamed_2715 * 72u) + 12u;
									uint4 fragment_unnamed_3788 = uint4(T7.Load(fragment_unnamed_3776).x, T7.Load(fragment_unnamed_3776 + 1u).x, T7.Load(fragment_unnamed_3776 + 2u).x, T7.Load(fragment_unnamed_3776 + 3u).x);
									float fragment_unnamed_3790 = asfloat(fragment_unnamed_3788.x);
									float fragment_unnamed_3792 = asfloat(fragment_unnamed_3788.y);
									float fragment_unnamed_3794 = asfloat(fragment_unnamed_3788.z);
									uint fragment_unnamed_3797 = (fragment_unnamed_2715 * 72u) + 16u;
									uint4 fragment_unnamed_3809 = uint4(T7.Load(fragment_unnamed_3797).x, T7.Load(fragment_unnamed_3797 + 1u).x, T7.Load(fragment_unnamed_3797 + 2u).x, T7.Load(fragment_unnamed_3797 + 3u).x);
									float fragment_unnamed_3812 = asfloat(fragment_unnamed_3809.x);
									float fragment_unnamed_3814 = asfloat(fragment_unnamed_3809.y);
									uint fragment_unnamed_3817 = (fragment_unnamed_2715 * 72u) + 20u;
									uint4 fragment_unnamed_3829 = uint4(T7.Load(fragment_unnamed_3817).x, T7.Load(fragment_unnamed_3817 + 1u).x, T7.Load(fragment_unnamed_3817 + 2u).x, T7.Load(fragment_unnamed_3817 + 3u).x);
									float fragment_unnamed_3835 = asfloat(fragment_unnamed_3829.x);
									uint fragment_unnamed_3839 = (fragment_unnamed_2715 * 72u) + 24u;
									uint4 fragment_unnamed_3851 = uint4(T7.Load(fragment_unnamed_3839).x, T7.Load(fragment_unnamed_3839 + 1u).x, T7.Load(fragment_unnamed_3839 + 2u).x, T7.Load(fragment_unnamed_3839 + 3u).x);
									float fragment_unnamed_3853 = asfloat(fragment_unnamed_3851.x);
									float fragment_unnamed_3855 = asfloat(fragment_unnamed_3851.y);
									float fragment_unnamed_3857 = asfloat(fragment_unnamed_3851.z);
									uint fragment_unnamed_3860 = (fragment_unnamed_2715 * 72u) + 28u;
									uint4 fragment_unnamed_3872 = uint4(T7.Load(fragment_unnamed_3860).x, T7.Load(fragment_unnamed_3860 + 1u).x, T7.Load(fragment_unnamed_3860 + 2u).x, T7.Load(fragment_unnamed_3860 + 3u).x);
									float fragment_unnamed_3875 = asfloat(fragment_unnamed_3872.x);
									float fragment_unnamed_3877 = asfloat(fragment_unnamed_3872.y);
									uint fragment_unnamed_3880 = (fragment_unnamed_2715 * 72u) + 32u;
									uint4 fragment_unnamed_3892 = uint4(T7.Load(fragment_unnamed_3880).x, T7.Load(fragment_unnamed_3880 + 1u).x, T7.Load(fragment_unnamed_3880 + 2u).x, T7.Load(fragment_unnamed_3880 + 3u).x);
									float fragment_unnamed_3895 = asfloat(fragment_unnamed_3892.y);
									float fragment_unnamed_3897 = asfloat(fragment_unnamed_3892.z);
									float fragment_unnamed_3899 = asfloat(fragment_unnamed_3892.w);
									uint fragment_unnamed_3901 = (fragment_unnamed_2715 * 72u) + 36u;
									uint4 fragment_unnamed_3913 = uint4(T7.Load(fragment_unnamed_3901).x, T7.Load(fragment_unnamed_3901 + 1u).x, T7.Load(fragment_unnamed_3901 + 2u).x, T7.Load(fragment_unnamed_3901 + 3u).x);
									float fragment_unnamed_3915 = asfloat(fragment_unnamed_3913.x);
									uint fragment_unnamed_3922 = (fragment_unnamed_2715 * 72u) + 40u;
									uint4 fragment_unnamed_3934 = uint4(T7.Load(fragment_unnamed_3922).x, T7.Load(fragment_unnamed_3922 + 1u).x, T7.Load(fragment_unnamed_3922 + 2u).x, T7.Load(fragment_unnamed_3922 + 3u).x);
									float fragment_unnamed_3936 = asfloat(fragment_unnamed_3934.z);
									uint fragment_unnamed_3943 = (fragment_unnamed_2715 * 72u) + 52u;
									uint4 fragment_unnamed_3955 = uint4(T7.Load(fragment_unnamed_3943).x, T7.Load(fragment_unnamed_3943 + 1u).x, T7.Load(fragment_unnamed_3943 + 2u).x, T7.Load(fragment_unnamed_3943 + 3u).x);
									float fragment_unnamed_3961 = asfloat(fragment_unnamed_3955.w);
									uint fragment_unnamed_3963 = (fragment_unnamed_2715 * 72u) + 56u;
									uint4 fragment_unnamed_3975 = uint4(T7.Load(fragment_unnamed_3963).x, T7.Load(fragment_unnamed_3963 + 1u).x, T7.Load(fragment_unnamed_3963 + 2u).x, T7.Load(fragment_unnamed_3963 + 3u).x);
									float fragment_unnamed_3977 = asfloat(fragment_unnamed_3975.x);
									uint fragment_unnamed_3982 = fragment_unnamed_3975.w;
									bool fragment_unnamed_3983 = int(fragment_unnamed_3982) >= int(0u);
									float fragment_unnamed_3985 = max(fragment_unnamed_1018, 9.9999997473787516355514526367188e-05f);
									float fragment_unnamed_3986 = fragment_unnamed_998 * fragment_unnamed_998;
									float fragment_unnamed_3988 = mad((-0.0f) - fragment_unnamed_998, fragment_unnamed_998, 1.0f);
									float fragment_unnamed_3995 = clamp(mad(fragment_unnamed_3988, fragment_unnamed_3988, fragment_unnamed_3988 * (fragment_unnamed_3985 * fragment_unnamed_3985)), 0.0f, 1.0f) * mad(fragment_unnamed_998, fragment_unnamed_998, sqrt(fragment_unnamed_3988));
									float fragment_unnamed_4002 = mad(fragment_unnamed_3995, ((-0.0f) - fragment_unnamed_664) + fragment_unnamed_1128, fragment_unnamed_664);
									float fragment_unnamed_4003 = mad(fragment_unnamed_3995, ((-0.0f) - fragment_unnamed_666) + fragment_unnamed_1129, fragment_unnamed_666);
									float fragment_unnamed_4004 = mad(fragment_unnamed_3995, ((-0.0f) - fragment_unnamed_668) + fragment_unnamed_1130, fragment_unnamed_668);
									float fragment_unnamed_4006 = min(fragment_unnamed_3986 * fragment_unnamed_3986, 1.0f);
									float fragment_unnamed_4010 = min((fragment_unnamed_4006 * fragment_unnamed_4006) * mad(fragment_unnamed_4006, -2.0f, 3.0f), 1.0f);
									float fragment_unnamed_4027 = asfloat(fragment_unnamed_3983 ? asuint(mad(fragment_unnamed_4010, fragment_unnamed_1128 + ((-0.0f) - fragment_unnamed_4002), fragment_unnamed_4002)) : asuint(fragment_unnamed_1128));
									float fragment_unnamed_4029 = asfloat(fragment_unnamed_3983 ? asuint(mad(fragment_unnamed_4010, fragment_unnamed_1129 + ((-0.0f) - fragment_unnamed_4003), fragment_unnamed_4003)) : asuint(fragment_unnamed_1129));
									float fragment_unnamed_4031 = asfloat(fragment_unnamed_3983 ? asuint(mad(fragment_unnamed_4010, fragment_unnamed_1130 + ((-0.0f) - fragment_unnamed_4004), fragment_unnamed_4004)) : asuint(fragment_unnamed_1130));
									float fragment_unnamed_4041 = ((-0.0f) - asfloat(fragment_unnamed_3829.y)) + fragment_input_6.x;
									float fragment_unnamed_4042 = ((-0.0f) - asfloat(fragment_unnamed_3829.z)) + fragment_input_6.y;
									float fragment_unnamed_4043 = ((-0.0f) - asfloat(fragment_unnamed_3829.w)) + fragment_input_6.z;
									float fragment_unnamed_4044 = asfloat(fragment_unnamed_3872.z);
									float fragment_unnamed_4045 = asfloat(fragment_unnamed_3872.w);
									float fragment_unnamed_4046 = asfloat(fragment_unnamed_3892.x);
									float fragment_unnamed_4047 = dot(float3(fragment_unnamed_4041, fragment_unnamed_4042, fragment_unnamed_4043), float3(fragment_unnamed_4044, fragment_unnamed_4045, fragment_unnamed_4046));
									float fragment_unnamed_4050 = asfloat(fragment_unnamed_3851.w);
									float fragment_unnamed_4051 = dot(float3(fragment_unnamed_4041, fragment_unnamed_4042, fragment_unnamed_4043), float3(fragment_unnamed_4050, fragment_unnamed_3875, fragment_unnamed_3877));
									float fragment_unnamed_4054 = dot(float3(fragment_unnamed_4041, fragment_unnamed_4042, fragment_unnamed_4043), float3(fragment_unnamed_3853, fragment_unnamed_3855, fragment_unnamed_3857));
									float fragment_unnamed_4066 = ((-0.0f) - asfloat(fragment_unnamed_3766.y)) + fragment_input_6.x;
									float fragment_unnamed_4067 = ((-0.0f) - asfloat(fragment_unnamed_3766.z)) + fragment_input_6.y;
									float fragment_unnamed_4068 = ((-0.0f) - asfloat(fragment_unnamed_3766.w)) + fragment_input_6.z;
									float fragment_unnamed_4069 = asfloat(fragment_unnamed_3809.z);
									float fragment_unnamed_4070 = asfloat(fragment_unnamed_3809.w);
									float fragment_unnamed_4071 = dot(float3(fragment_unnamed_4066, fragment_unnamed_4067, fragment_unnamed_4068), float3(fragment_unnamed_4069, fragment_unnamed_4070, fragment_unnamed_3835));
									float fragment_unnamed_4074 = asfloat(fragment_unnamed_3788.w);
									float fragment_unnamed_4075 = dot(float3(fragment_unnamed_4066, fragment_unnamed_4067, fragment_unnamed_4068), float3(fragment_unnamed_4074, fragment_unnamed_3812, fragment_unnamed_3814));
									float fragment_unnamed_4078 = dot(float3(fragment_unnamed_4066, fragment_unnamed_4067, fragment_unnamed_4068), float3(fragment_unnamed_3790, fragment_unnamed_3792, fragment_unnamed_3794));
									float fragment_unnamed_4081 = dot(float3(fragment_unnamed_4027, fragment_unnamed_4029, fragment_unnamed_4031), float3(fragment_unnamed_4069, fragment_unnamed_4070, fragment_unnamed_3835));
									float fragment_unnamed_4084 = dot(float3(fragment_unnamed_4027, fragment_unnamed_4029, fragment_unnamed_4031), float3(fragment_unnamed_4074, fragment_unnamed_3812, fragment_unnamed_3814));
									float fragment_unnamed_4087 = dot(float3(fragment_unnamed_4027, fragment_unnamed_4029, fragment_unnamed_4031), float3(fragment_unnamed_3790, fragment_unnamed_3792, fragment_unnamed_3794));
									float fragment_unnamed_4875;
									float fragment_unnamed_4877;
									float fragment_unnamed_4879;
									float fragment_unnamed_4881;
									float fragment_unnamed_4883;
									if (fragment_unnamed_3746 == 2u)
									{
										float fragment_unnamed_4398 = dot(float3(fragment_unnamed_4081, fragment_unnamed_4084, fragment_unnamed_4087), float3(fragment_unnamed_4071, fragment_unnamed_4075, fragment_unnamed_4078));
										float fragment_unnamed_4401 = fragment_unnamed_4398 + fragment_unnamed_4398;
										float fragment_unnamed_4414 = abs(mad((-0.0f) - fragment_unnamed_4398, 2.0f, sqrt(mad(fragment_unnamed_4401, fragment_unnamed_4401, (-0.0f) - (mad((-0.0f) - fragment_unnamed_3748, fragment_unnamed_3748, dot(float3(fragment_unnamed_4071, fragment_unnamed_4075, fragment_unnamed_4078), float3(fragment_unnamed_4071, fragment_unnamed_4075, fragment_unnamed_4078))) * 4.0f))))) * 0.5f;
										float fragment_unnamed_4423 = max(fragment_unnamed_3768, asfloat((2139095040u < (asuint(fragment_unnamed_4414) & 2147483647u)) ? 3212836864u : asuint(fragment_unnamed_4414)));
										float fragment_unnamed_4442 = sqrt(dot(float3(fragment_unnamed_4047, fragment_unnamed_4051, fragment_unnamed_4054), float3(fragment_unnamed_4047, fragment_unnamed_4051, fragment_unnamed_4054)));
										float fragment_unnamed_4465 = ((-0.0f) - fragment_unnamed_3549) + fragment_input_6.x;
										float fragment_unnamed_4466 = ((-0.0f) - fragment_unnamed_3551) + fragment_input_6.y;
										float fragment_unnamed_4467 = ((-0.0f) - fragment_unnamed_3553) + fragment_input_6.z;
										float fragment_unnamed_4471 = rsqrt(dot(float3(fragment_unnamed_4465, fragment_unnamed_4466, fragment_unnamed_4467), float3(fragment_unnamed_4465, fragment_unnamed_4466, fragment_unnamed_4467)));
										fragment_unnamed_4875 = fragment_unnamed_4423;
										fragment_unnamed_4877 = asfloat(((fragment_unnamed_3895 + ((-0.0f) - fragment_unnamed_3936)) >= fragment_unnamed_4442) ? 1065353216u : asuint(clamp(mad(dot(float3(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668), float3(fragment_unnamed_4471 * fragment_unnamed_4465, fragment_unnamed_4471 * fragment_unnamed_4466, fragment_unnamed_4471 * fragment_unnamed_4467)), -2.5f, 1.5f), 0.0f, 1.0f))) * max(((-0.0f) - (max(fragment_unnamed_4442 + ((-0.0f) - (fragment_unnamed_3895 + ((-0.0f) - fragment_unnamed_3915))), 0.0f) / max(fragment_unnamed_3915, 9.9999997473787516355514526367188e-05f))) + 1.0f, 0.0f);
										fragment_unnamed_4879 = ((-0.0f) - fragment_unnamed_3549) + mad(fragment_unnamed_4423, fragment_unnamed_4027, fragment_input_6.x);
										fragment_unnamed_4881 = ((-0.0f) - fragment_unnamed_3551) + mad(fragment_unnamed_4423, fragment_unnamed_4029, fragment_input_6.y);
										fragment_unnamed_4883 = ((-0.0f) - fragment_unnamed_3553) + mad(fragment_unnamed_4423, fragment_unnamed_4031, fragment_input_6.z);
									}
									else
									{
										float fragment_unnamed_4876;
										float fragment_unnamed_4878;
										float fragment_unnamed_4880;
										float fragment_unnamed_4882;
										float fragment_unnamed_4884;
										if (fragment_unnamed_3746 == 1u)
										{
											uint fragment_unnamed_4918 = (fragment_unnamed_2715 * 72u) + 44u;
											uint4 fragment_unnamed_4930 = uint4(T7.Load(fragment_unnamed_4918).x, T7.Load(fragment_unnamed_4918 + 1u).x, T7.Load(fragment_unnamed_4918 + 2u).x, T7.Load(fragment_unnamed_4918 + 3u).x);
											uint fragment_unnamed_4939 = (fragment_unnamed_2715 * 72u) + 48u;
											uint4 fragment_unnamed_4951 = uint4(T7.Load(fragment_unnamed_4939).x, T7.Load(fragment_unnamed_4939 + 1u).x, T7.Load(fragment_unnamed_4939 + 2u).x, T7.Load(fragment_unnamed_4939 + 3u).x);
											float fragment_unnamed_4960 = dot(float3(fragment_unnamed_4027, fragment_unnamed_4029, fragment_unnamed_4031), float3(fragment_unnamed_4044, fragment_unnamed_4045, fragment_unnamed_4046));
											float fragment_unnamed_4963 = dot(float3(fragment_unnamed_4027, fragment_unnamed_4029, fragment_unnamed_4031), float3(fragment_unnamed_4050, fragment_unnamed_3875, fragment_unnamed_3877));
											float fragment_unnamed_4966 = dot(float3(fragment_unnamed_4027, fragment_unnamed_4029, fragment_unnamed_4031), float3(fragment_unnamed_3853, fragment_unnamed_3855, fragment_unnamed_3857));
											float fragment_unnamed_4972 = rsqrt(dot(float3(fragment_unnamed_4960, fragment_unnamed_4963, fragment_unnamed_4966), float3(fragment_unnamed_4960, fragment_unnamed_4963, fragment_unnamed_4966)));
											float fragment_unnamed_4973 = fragment_unnamed_4972 * fragment_unnamed_4960;
											float fragment_unnamed_4974 = fragment_unnamed_4972 * fragment_unnamed_4963;
											float fragment_unnamed_4975 = fragment_unnamed_4972 * fragment_unnamed_4966;
											float fragment_unnamed_4976 = 1.0f / fragment_unnamed_4081;
											float fragment_unnamed_4977 = 1.0f / fragment_unnamed_4084;
											float fragment_unnamed_4978 = 1.0f / fragment_unnamed_4087;
											float fragment_unnamed_5017 = max(fragment_unnamed_3768, min(asfloat((0.0f < fragment_unnamed_4087) ? asuint(fragment_unnamed_4978 * (fragment_unnamed_3752 + ((-0.0f) - fragment_unnamed_4078))) : asuint(fragment_unnamed_4978 * (((-0.0f) - fragment_unnamed_3752) + ((-0.0f) - fragment_unnamed_4078)))), min(asfloat((0.0f < fragment_unnamed_4084) ? asuint(fragment_unnamed_4977 * (fragment_unnamed_3750 + ((-0.0f) - fragment_unnamed_4075))) : asuint(fragment_unnamed_4977 * (((-0.0f) - fragment_unnamed_3750) + ((-0.0f) - fragment_unnamed_4075)))), asfloat((0.0f < fragment_unnamed_4081) ? asuint(fragment_unnamed_4976 * (fragment_unnamed_3748 + ((-0.0f) - fragment_unnamed_4071))) : asuint(fragment_unnamed_4976 * (((-0.0f) - fragment_unnamed_3748) + ((-0.0f) - fragment_unnamed_4071)))))));
											float fragment_unnamed_5033 = fragment_unnamed_3895 + fragment_unnamed_4047;
											float fragment_unnamed_5034 = fragment_unnamed_3897 + fragment_unnamed_4051;
											float fragment_unnamed_5035 = fragment_unnamed_3899 + fragment_unnamed_4054;
											float fragment_unnamed_5039 = fragment_unnamed_3895 + ((-0.0f) - fragment_unnamed_4047);
											float fragment_unnamed_5040 = fragment_unnamed_3897 + ((-0.0f) - fragment_unnamed_4051);
											float fragment_unnamed_5041 = fragment_unnamed_3899 + ((-0.0f) - fragment_unnamed_4054);
											float fragment_unnamed_5102 = ((-0.0f) - fragment_unnamed_3549) + fragment_input_6.x;
											float fragment_unnamed_5103 = ((-0.0f) - fragment_unnamed_3551) + fragment_input_6.y;
											float fragment_unnamed_5104 = ((-0.0f) - fragment_unnamed_3553) + fragment_input_6.z;
											float fragment_unnamed_5108 = rsqrt(dot(float3(fragment_unnamed_5102, fragment_unnamed_5103, fragment_unnamed_5104), float3(fragment_unnamed_5102, fragment_unnamed_5103, fragment_unnamed_5104)));
											float fragment_unnamed_5149 = (clamp(min(min(fragment_unnamed_5035 / max(asfloat(fragment_unnamed_3934.y), 9.9999997473787516355514526367188e-05f), min(fragment_unnamed_5034 / max(asfloat(fragment_unnamed_3934.x), 9.9999997473787516355514526367188e-05f), fragment_unnamed_5033 / max(asfloat(fragment_unnamed_3913.w), 9.9999997473787516355514526367188e-05f))), min(fragment_unnamed_5041 / max(asfloat(fragment_unnamed_3913.z), 9.9999997473787516355514526367188e-05f), min(fragment_unnamed_5040 / max(asfloat(fragment_unnamed_3913.y), 9.9999997473787516355514526367188e-05f), fragment_unnamed_5039 / max(fragment_unnamed_3915, 9.9999997473787516355514526367188e-05f)))), 0.0f, 1.0f) * asfloat(((((((fragment_unnamed_5041 / max(asfloat(fragment_unnamed_4930.x), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & ((((fragment_unnamed_5040 / max(asfloat(fragment_unnamed_3934.w), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_5039 / max(fragment_unnamed_3936, 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u))) & ((((fragment_unnamed_5035 / max(asfloat(fragment_unnamed_4930.w), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & ((((fragment_unnamed_5034 / max(asfloat(fragment_unnamed_4930.z), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_5033 / max(asfloat(fragment_unnamed_4930.y), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u)))) != 0u) ? 1065353216u : asuint(clamp(mad(dot(float3(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668), float3(fragment_unnamed_5108 * fragment_unnamed_5102, fragment_unnamed_5108 * fragment_unnamed_5103, fragment_unnamed_5108 * fragment_unnamed_5104)), -2.5f, 1.5f), 0.0f, 1.0f)))) * min((clamp(asfloat(fragment_unnamed_4951.z) * mad(fragment_unnamed_4975, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4975, -4.0f, -1.0f) * asfloat(fragment_unnamed_3955.y), 0.0f, 1.0f)) + ((clamp(asfloat(fragment_unnamed_4951.y) * mad(fragment_unnamed_4974, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4974, -4.0f, -1.0f) * asfloat(fragment_unnamed_3955.x), 0.0f, 1.0f)) + (clamp(asfloat(fragment_unnamed_4951.x) * mad(fragment_unnamed_4973, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4973, -4.0f, -1.0f) * asfloat(fragment_unnamed_4951.w), 0.0f, 1.0f))), 1.0f);
											fragment_unnamed_4876 = fragment_unnamed_5017;
											fragment_unnamed_4878 = fragment_unnamed_5149;
											fragment_unnamed_4880 = ((-0.0f) - fragment_unnamed_3549) + mad(fragment_unnamed_5017, fragment_unnamed_4027, fragment_input_6.x);
											fragment_unnamed_4882 = ((-0.0f) - fragment_unnamed_3551) + mad(fragment_unnamed_5017, fragment_unnamed_4029, fragment_input_6.y);
											fragment_unnamed_4884 = ((-0.0f) - fragment_unnamed_3553) + mad(fragment_unnamed_5017, fragment_unnamed_4031, fragment_input_6.z);
										}
										else
										{
											fragment_unnamed_4876 = asfloat(0u);
											fragment_unnamed_4878 = asfloat(1065353216u);
											fragment_unnamed_4880 = fragment_unnamed_4027;
											fragment_unnamed_4882 = fragment_unnamed_4029;
											fragment_unnamed_4884 = fragment_unnamed_4031;
										}
										fragment_unnamed_4875 = fragment_unnamed_4876;
										fragment_unnamed_4877 = fragment_unnamed_4878;
										fragment_unnamed_4879 = fragment_unnamed_4880;
										fragment_unnamed_4881 = fragment_unnamed_4882;
										fragment_unnamed_4883 = fragment_unnamed_4884;
									}
									float fragment_unnamed_4889 = asfloat(fragment_unnamed_3955.z) * ((fragment_unnamed_4877 * fragment_unnamed_4877) * mad((-0.0f) - fragment_unnamed_4877, 2.0f, 3.0f));
									float fragment_unnamed_4897 = min(fragment_unnamed_998, max(fragment_unnamed_998 * (fragment_unnamed_4875 / sqrt(dot(float3(fragment_unnamed_4879, fragment_unnamed_4881, fragment_unnamed_4883), float3(fragment_unnamed_4879, fragment_unnamed_4881, fragment_unnamed_4883)))), 0.0f));
									float fragment_unnamed_4907 = asfloat(fragment_unnamed_3983 ? asuint(mad(asfloat(fragment_unnamed_3975.z), ((-0.0f) - fragment_unnamed_998) + mad(fragment_unnamed_998, fragment_unnamed_998 + ((-0.0f) - fragment_unnamed_4897), fragment_unnamed_4897), fragment_unnamed_998)) : asuint(fragment_unnamed_998));
									float fragment_unnamed_4911 = asfloat(fragment_unnamed_3975.y) * (fragment_unnamed_4907 * mad((-0.0f) - fragment_unnamed_4907, 0.699999988079071044921875f, 1.7000000476837158203125f));
									float fragment_unnamed_4912 = fragment_unnamed_4911 * 6.0f;
									uint fragment_unnamed_4915 = uint(abs(int(fragment_unnamed_3982))) + 4294967295u;
									float fragment_unnamed_6322;
									float fragment_unnamed_6324;
									float fragment_unnamed_6326;
									float fragment_unnamed_6328;
									if ((fragment_unnamed_3983 ? 4294967295u : 0u) == 0u)
									{
										uint fragment_unnamed_5566 = fragment_unnamed_4915 << 2u;
										uint fragment_unnamed_5567 = fragment_unnamed_5566 + 1u;
										uint fragment_unnamed_5588 = fragment_unnamed_5566 + 2u;
										uint fragment_unnamed_5599 = fragment_unnamed_5566 + 3u;
										float fragment_unnamed_5609 = mad(fragment_uniform_buffer_3[fragment_unnamed_5588].w, fragment_unnamed_4883, mad(fragment_uniform_buffer_3[fragment_unnamed_5566].w, fragment_unnamed_4879, fragment_unnamed_4881 * fragment_uniform_buffer_3[fragment_unnamed_5567].w)) + fragment_uniform_buffer_3[fragment_unnamed_5599].w;
										float fragment_unnamed_5610 = (mad(fragment_uniform_buffer_3[fragment_unnamed_5588].x, fragment_unnamed_4883, mad(fragment_uniform_buffer_3[fragment_unnamed_5566].x, fragment_unnamed_4879, fragment_unnamed_4881 * fragment_uniform_buffer_3[fragment_unnamed_5567].x)) + fragment_uniform_buffer_3[fragment_unnamed_5599].x) * 1.0f;
										float fragment_unnamed_5611 = (mad(fragment_uniform_buffer_3[fragment_unnamed_5588].y, fragment_unnamed_4883, mad(fragment_uniform_buffer_3[fragment_unnamed_5566].y, fragment_unnamed_4879, fragment_unnamed_4881 * fragment_uniform_buffer_3[fragment_unnamed_5567].y)) + fragment_uniform_buffer_3[fragment_unnamed_5599].y) * (-1.0f);
										uint fragment_unnamed_5623 = ((abs((mad(fragment_uniform_buffer_3[fragment_unnamed_5588].z, fragment_unnamed_4883, mad(fragment_uniform_buffer_3[fragment_unnamed_5566].z, fragment_unnamed_4879, fragment_unnamed_4881 * fragment_uniform_buffer_3[fragment_unnamed_5567].z)) + fragment_uniform_buffer_3[fragment_unnamed_5599].z) * 1.0f) < fragment_unnamed_5609) ? 4294967295u : 0u) & (((abs(fragment_unnamed_5611) < fragment_unnamed_5609) ? 4294967295u : 0u) & ((abs(fragment_unnamed_5610) < fragment_unnamed_5609) ? 4294967295u : 0u));
										float fragment_unnamed_6323;
										float fragment_unnamed_6325;
										float fragment_unnamed_6327;
										float fragment_unnamed_6329;
										if (fragment_unnamed_5623 != 0u)
										{
											float fragment_unnamed_6182 = 1.0f / fragment_unnamed_5609;
											float fragment_unnamed_6185 = mad(fragment_unnamed_6182 * fragment_unnamed_5610, 0.5f, 0.5f);
											float fragment_unnamed_6186 = mad(fragment_unnamed_6182 * fragment_unnamed_5611, 0.5f, 0.5f);
											uint fragment_unnamed_6194 = fragment_unnamed_4915 + 64u;
											uint fragment_unnamed_6206 = fragment_unnamed_4915 + 64u;
											float fragment_unnamed_6214 = exp2(ceil(fragment_unnamed_4912));
											float fragment_unnamed_6219 = fragment_unnamed_6214 * fragment_uniform_buffer_1[125u].z;
											float fragment_unnamed_6220 = fragment_unnamed_6214 * fragment_uniform_buffer_1[125u].w;
											uint fragment_unnamed_6221 = fragment_unnamed_4915 + 64u;
											uint fragment_unnamed_6228 = fragment_unnamed_4915 + 64u;
											uint fragment_unnamed_6233 = fragment_unnamed_4915 + 64u;
											float4 fragment_unnamed_6251 = _ReflectionAtlas.SampleLevel(S1, float3(min(mad((-0.0f) - fragment_unnamed_6219, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_6228].x + fragment_uniform_buffer_3[fragment_unnamed_6233].z), max(mad(fragment_unnamed_6219, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_6221].z), mad(fragment_unnamed_6185, ((-0.0f) - fragment_uniform_buffer_1[125u].x) + fragment_uniform_buffer_3[fragment_unnamed_6194].x, mad(fragment_uniform_buffer_1[125u].x, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_6206].z)))), min(mad((-0.0f) - fragment_unnamed_6220, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_6228].y + fragment_uniform_buffer_3[fragment_unnamed_6233].w), max(mad(fragment_unnamed_6220, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_6221].w), mad(fragment_unnamed_6186, ((-0.0f) - fragment_uniform_buffer_1[125u].y) + fragment_uniform_buffer_3[fragment_unnamed_6194].y, mad(fragment_uniform_buffer_1[125u].y, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_6206].w)))), fragment_unnamed_2064), fragment_unnamed_4912);
											float fragment_unnamed_6286 = min(abs(mad((-0.0f) - fragment_unnamed_276, fragment_uniform_buffer_1[50u].z, fragment_unnamed_6185)) * 100.0f, 1.0f);
											float fragment_unnamed_6287 = min(abs(mad((-0.0f) - fragment_unnamed_277, fragment_uniform_buffer_1[50u].w, fragment_unnamed_6186)) * 100.0f, 1.0f);
											fragment_unnamed_6323 = asfloat(fragment_unnamed_5623 & 1065353216u) * (asfloat((((((fragment_unnamed_289 < fragment_unnamed_6186) ? 4294967295u : 0u) & 1u) ^ (((fragment_unnamed_6186 < 0.5f) ? 4294967295u : 0u) & 1u)) != 0u) ? asuint(mad(mad((-0.0f) - fragment_unnamed_6287, 2.0f, 3.0f) * (fragment_unnamed_6287 * fragment_unnamed_6287), min(mad((-0.0f) - abs(mad(clamp(fragment_unnamed_6186, 0.0f, 1.0f), 2.0f, -1.0f)), 2.0f, 2.0f), 1.0f) + (-1.0f), 1.0f)) : 1065353216u) * asfloat((((((fragment_unnamed_288 < fragment_unnamed_6185) ? 4294967295u : 0u) & 1u) ^ (((fragment_unnamed_6185 < 0.5f) ? 4294967295u : 0u) & 1u)) != 0u) ? asuint(mad(mad((-0.0f) - fragment_unnamed_6286, 2.0f, 3.0f) * (fragment_unnamed_6286 * fragment_unnamed_6286), min(mad((-0.0f) - abs(mad(clamp(fragment_unnamed_6185, 0.0f, 1.0f), 2.0f, -1.0f)), 2.0f, 2.0f), 1.0f) + (-1.0f), 1.0f)) : 1065353216u));
											fragment_unnamed_6325 = fragment_unnamed_6251.x;
											fragment_unnamed_6327 = fragment_unnamed_6251.y;
											fragment_unnamed_6329 = fragment_unnamed_6251.z;
										}
										else
										{
											fragment_unnamed_6323 = asfloat(0u);
											fragment_unnamed_6325 = asfloat(0u);
											fragment_unnamed_6327 = asfloat(0u);
											fragment_unnamed_6329 = asfloat(0u);
										}
										fragment_unnamed_6322 = fragment_unnamed_6323;
										fragment_unnamed_6324 = fragment_unnamed_6325;
										fragment_unnamed_6326 = fragment_unnamed_6327;
										fragment_unnamed_6328 = fragment_unnamed_6329;
									}
									else
									{
										float fragment_unnamed_5632 = 1.0f / max(dot(float3(abs(fragment_unnamed_4879), abs(fragment_unnamed_4881), abs(fragment_unnamed_4883)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
										float fragment_unnamed_5637 = clamp((-0.0f) - (fragment_unnamed_5632 * fragment_unnamed_4883), 0.0f, 1.0f);
										float fragment_unnamed_5640 = (-0.0f) - fragment_unnamed_5637;
										float fragment_unnamed_5656 = exp2(max(mad(fragment_unnamed_4911, 6.0f, (-0.0f) - fragment_uniform_buffer_1[124u].z), 0.0f));
										uint fragment_unnamed_5669 = fragment_unnamed_4915 + 80u;
										uint fragment_unnamed_5677 = fragment_unnamed_4915 + 80u;
										float4 fragment_unnamed_5687 = _ReflectionAtlas.SampleLevel(S1, float3(mad(clamp(mad(mad(fragment_unnamed_4879, fragment_unnamed_5632, ((fragment_unnamed_5632 * fragment_unnamed_4879) >= 0.0f) ? fragment_unnamed_5637 : fragment_unnamed_5640), 0.5f, 0.5f), 0.0f, 1.0f), mad((-0.0f) - fragment_uniform_buffer_1[124u].x, fragment_unnamed_5656, fragment_uniform_buffer_3[fragment_unnamed_5669].x), mad(fragment_unnamed_5656 * fragment_uniform_buffer_1[124u].x, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_5677].z)), mad(clamp(mad(mad(fragment_unnamed_4881, fragment_unnamed_5632, ((fragment_unnamed_5632 * fragment_unnamed_4881) >= 0.0f) ? fragment_unnamed_5637 : fragment_unnamed_5640), 0.5f, 0.5f), 0.0f, 1.0f), mad((-0.0f) - fragment_uniform_buffer_1[124u].y, fragment_unnamed_5656, fragment_uniform_buffer_3[fragment_unnamed_5669].y), mad(fragment_unnamed_5656 * fragment_uniform_buffer_1[124u].y, 0.5f, fragment_uniform_buffer_3[fragment_unnamed_5677].w)), fragment_unnamed_2063), fragment_unnamed_4912);
										fragment_unnamed_6322 = asfloat(1065353216u);
										fragment_unnamed_6324 = fragment_unnamed_5687.x;
										fragment_unnamed_6326 = fragment_unnamed_5687.y;
										fragment_unnamed_6328 = fragment_unnamed_5687.z;
									}
									float fragment_unnamed_6339 = mad(fragment_unnamed_4889, fragment_unnamed_6322, fragment_unnamed_2353);
									float fragment_unnamed_4092 = clamp(fragment_unnamed_6339, 0.0f, 1.0f);
									float fragment_unnamed_6344 = mad(fragment_unnamed_4889, fragment_unnamed_6322, (-0.0f) - clamp(((-0.0f) - fragment_unnamed_4092) + fragment_unnamed_6339, 0.0f, 1.0f));
									fragment_unnamed_4091 = fragment_unnamed_4092;
									fragment_unnamed_4093 = mad(fragment_unnamed_6344 * ((fragment_unnamed_3977 * min(fragment_unnamed_6324, 65504.0f)) * fragment_unnamed_1110), fragment_unnamed_3961, fragment_unnamed_2355);
									fragment_unnamed_4095 = mad(fragment_unnamed_6344 * ((fragment_unnamed_3977 * min(fragment_unnamed_6326, 65504.0f)) * fragment_unnamed_1111), fragment_unnamed_3961, fragment_unnamed_2357);
									fragment_unnamed_4097 = mad(fragment_unnamed_6344 * ((fragment_unnamed_3977 * min(fragment_unnamed_6328, 65504.0f)) * fragment_unnamed_1112), fragment_unnamed_3961, fragment_unnamed_2359);
								}
								else
								{
									fragment_unnamed_4091 = fragment_unnamed_2353;
									fragment_unnamed_4093 = fragment_unnamed_2355;
									fragment_unnamed_4095 = fragment_unnamed_2357;
									fragment_unnamed_4097 = fragment_unnamed_2359;
								}
								fragment_unnamed_2354 = fragment_unnamed_4091;
								fragment_unnamed_2356 = fragment_unnamed_4093;
								fragment_unnamed_2358 = fragment_unnamed_4095;
								fragment_unnamed_2360 = fragment_unnamed_4097;
								fragment_unnamed_2353 = fragment_unnamed_2354;
								fragment_unnamed_2355 = fragment_unnamed_2356;
								fragment_unnamed_2357 = fragment_unnamed_2358;
								fragment_unnamed_2359 = fragment_unnamed_2360;
								fragment_unnamed_2361 = fragment_unnamed_2362;
								continue;
							}
							else
							{
								fragment_unnamed_2354 = asfloat(1065353216u);
								fragment_unnamed_2356 = fragment_unnamed_2355;
								fragment_unnamed_2358 = fragment_unnamed_2357;
								fragment_unnamed_2360 = fragment_unnamed_2359;
								fragment_unnamed_2353 = fragment_unnamed_2354;
								fragment_unnamed_2355 = fragment_unnamed_2356;
								fragment_unnamed_2357 = fragment_unnamed_2358;
								fragment_unnamed_2359 = fragment_unnamed_2360;
								fragment_unnamed_2361 = fragment_unnamed_2362;
								continue;
							}
						}
					}
					if (ladder_phi_56)
					{
						break;
					}
					break;
				}
				float fragment_unnamed_3133;
				float fragment_unnamed_3135;
				float fragment_unnamed_3137;
				if (asuint(fragment_uniform_buffer_1[116u]).x != 0u)
				{
					float fragment_unnamed_3134;
					float fragment_unnamed_3136;
					float fragment_unnamed_3138;
					if (fragment_unnamed_2353 < 1.0f)
					{
						float fragment_unnamed_3451 = asfloat((asuint(fragment_uniform_buffer_1[117u]).x != 0u) ? 1065353216u : 0u);
						float fragment_unnamed_3453 = mad((-0.0f) - fragment_unnamed_998, fragment_unnamed_998, 1.0f);
						float fragment_unnamed_3460 = clamp(mad(fragment_unnamed_3453, fragment_unnamed_3453, fragment_unnamed_3453 * (fragment_unnamed_1021 * fragment_unnamed_1021)), 0.0f, 1.0f) * mad(fragment_unnamed_998, fragment_unnamed_998, sqrt(fragment_unnamed_3453));
						float fragment_unnamed_3467 = mad(fragment_unnamed_3460, ((-0.0f) - fragment_unnamed_664) + fragment_unnamed_1128, fragment_unnamed_664);
						float fragment_unnamed_3468 = mad(fragment_unnamed_3460, ((-0.0f) - fragment_unnamed_666) + fragment_unnamed_1129, fragment_unnamed_666);
						float fragment_unnamed_3469 = mad(fragment_unnamed_3460, ((-0.0f) - fragment_unnamed_668) + fragment_unnamed_1130, fragment_unnamed_668);
						float fragment_unnamed_3470 = min(fragment_unnamed_1115, 1.0f);
						float fragment_unnamed_3474 = min((fragment_unnamed_3470 * fragment_unnamed_3470) * mad(fragment_unnamed_3470, -2.0f, 3.0f), 1.0f);
						float fragment_unnamed_3481 = mad(fragment_unnamed_3474, ((-0.0f) - fragment_unnamed_3467) + fragment_unnamed_1128, fragment_unnamed_3467);
						float fragment_unnamed_3482 = mad(fragment_unnamed_3474, ((-0.0f) - fragment_unnamed_3468) + fragment_unnamed_1129, fragment_unnamed_3468);
						float fragment_unnamed_3483 = mad(fragment_unnamed_3474, ((-0.0f) - fragment_unnamed_3469) + fragment_unnamed_1130, fragment_unnamed_3469);
						float fragment_unnamed_3491 = asfloat(0u);
						float4 fragment_unnamed_3494 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_3481, fragment_unnamed_3482, fragment_unnamed_3483, fragment_unnamed_3491), (mad((-0.0f) - fragment_unnamed_998, 0.699999988079071044921875f, 1.7000000476837158203125f) * fragment_unnamed_998) * 6.0f);
						float fragment_unnamed_3499 = min(fragment_unnamed_3494.x, 65504.0f);
						float fragment_unnamed_3501 = min(fragment_unnamed_3494.y, 65504.0f);
						float fragment_unnamed_3502 = min(fragment_unnamed_3494.z, 65504.0f);
						float fragment_unnamed_3688;
						float fragment_unnamed_3690;
						float fragment_unnamed_3692;
						if (asuint(fragment_uniform_buffer_1[84u]).x != 0u)
						{
							float fragment_unnamed_3610 = dot(float3(fragment_unnamed_3481, fragment_unnamed_3482, fragment_unnamed_3483), float3(fragment_uniform_buffer_1[83u].xyz));
							float fragment_unnamed_3626 = max(abs(fragment_unnamed_3610), 0.001000000047497451305389404296875f);
							float fragment_unnamed_3627 = 1.0f / fragment_unnamed_3626;
							float fragment_unnamed_3632 = min(mad(fragment_uniform_buffer_1[84u].w, fragment_unnamed_3610, fragment_unnamed_1786), fragment_unnamed_1786);
							float fragment_unnamed_3649 = min(max(fragment_unnamed_3627 * (((-0.0f) - fragment_unnamed_3632) + fragment_uniform_buffer_1[89u].y), 0.0f), fragment_uniform_buffer_1[84u].w);
							float fragment_unnamed_3683 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_3626 * ((-0.0f) - (((-0.0f) - fragment_unnamed_3649) + fragment_uniform_buffer_1[84u].w))) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_3632 + ((-0.0f) - fragment_uniform_buffer_1[89u].y), 0.0f)) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f), fragment_unnamed_3627 * fragment_uniform_buffer_1[90u].y, fragment_unnamed_3649) * fragment_uniform_buffer_1[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_4627;
							float fragment_unnamed_4628;
							float fragment_unnamed_4629;
							if (fragment_uniform_buffer_1[86u].x == 1.0f)
							{
								float4 fragment_unnamed_4299 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_3481, fragment_unnamed_3482, fragment_unnamed_3483, fragment_unnamed_3491), mad((-0.0f) - fragment_uniform_buffer_1[87u].z, clamp((fragment_uniform_buffer_1[84u].w + ((-0.0f) - fragment_uniform_buffer_1[87u].x)) / (((-0.0f) - fragment_uniform_buffer_1[87u].x) + fragment_uniform_buffer_1[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_4627 = fragment_unnamed_4299.z * fragment_uniform_buffer_1[85u].z;
								fragment_unnamed_4628 = fragment_unnamed_4299.y * fragment_uniform_buffer_1[85u].y;
								fragment_unnamed_4629 = fragment_unnamed_4299.x * fragment_uniform_buffer_1[85u].x;
							}
							else
							{
								uint4 fragment_unnamed_4315 = asuint(fragment_uniform_buffer_1[85u]);
								fragment_unnamed_4627 = asfloat(fragment_unnamed_4315.z);
								fragment_unnamed_4628 = asfloat(fragment_unnamed_4315.y);
								fragment_unnamed_4629 = asfloat(fragment_unnamed_4315.x);
							}
							float fragment_unnamed_4634 = ((-0.0f) - fragment_unnamed_3683) + 1.0f;
							fragment_unnamed_3688 = mad(fragment_unnamed_3499, fragment_unnamed_3683, fragment_unnamed_4634 * ((fragment_uniform_buffer_1[88u].x / fragment_uniform_buffer_1[89u].x) * fragment_unnamed_4629));
							fragment_unnamed_3690 = mad(fragment_unnamed_3501, fragment_unnamed_3683, fragment_unnamed_4634 * ((fragment_uniform_buffer_1[88u].y / fragment_uniform_buffer_1[89u].x) * fragment_unnamed_4628));
							fragment_unnamed_3692 = mad(fragment_unnamed_3502, fragment_unnamed_3683, fragment_unnamed_4634 * ((fragment_uniform_buffer_1[88u].z / fragment_uniform_buffer_1[89u].x) * fragment_unnamed_4627));
						}
						else
						{
							fragment_unnamed_3688 = fragment_unnamed_3499;
							fragment_unnamed_3690 = fragment_unnamed_3501;
							fragment_unnamed_3692 = fragment_unnamed_3502;
						}
						float fragment_unnamed_3698 = ((-0.0f) - fragment_unnamed_2353) + 1.0f;
						fragment_unnamed_3134 = mad(fragment_unnamed_3698 * (fragment_unnamed_1110 * fragment_unnamed_3688), fragment_unnamed_3451, fragment_unnamed_2355);
						fragment_unnamed_3136 = mad(fragment_unnamed_3698 * (fragment_unnamed_1111 * fragment_unnamed_3690), fragment_unnamed_3451, fragment_unnamed_2357);
						fragment_unnamed_3138 = mad(fragment_unnamed_3698 * (fragment_unnamed_1112 * fragment_unnamed_3692), fragment_unnamed_3451, fragment_unnamed_2359);
					}
					else
					{
						fragment_unnamed_3134 = fragment_unnamed_2355;
						fragment_unnamed_3136 = fragment_unnamed_2357;
						fragment_unnamed_3138 = fragment_unnamed_2359;
					}
					fragment_unnamed_3133 = fragment_unnamed_3134;
					fragment_unnamed_3135 = fragment_unnamed_3136;
					fragment_unnamed_3137 = fragment_unnamed_3138;
				}
				else
				{
					fragment_unnamed_3133 = fragment_unnamed_2355;
					fragment_unnamed_3135 = fragment_unnamed_2357;
					fragment_unnamed_3137 = fragment_unnamed_2359;
				}
				float fragment_unnamed_3150 = ((-0.0f) - fragment_unnamed_1786) + fragment_uniform_buffer_1[89u].y;
				float fragment_unnamed_3159 = exp2((((-0.0f) - max(fragment_unnamed_1786 + ((-0.0f) - fragment_uniform_buffer_1[89u].y), 0.0f)) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f);
				uint fragment_unnamed_3165 = (fragment_uniform_buffer_1[218u].w == 1.0f) ? 4294967295u : 0u;
				float fragment_unnamed_3180 = fragment_input_6.x + ((-0.0f) - fragment_uniform_buffer_1[218u].x);
				float fragment_unnamed_3181 = fragment_input_6.y + ((-0.0f) - fragment_uniform_buffer_1[218u].y);
				float fragment_unnamed_3182 = fragment_input_6.z + ((-0.0f) - fragment_uniform_buffer_1[218u].z);
				float fragment_unnamed_3198 = fragment_input_6.x + ((-0.0f) - fragment_uniform_buffer_1[82u].x);
				float fragment_unnamed_3199 = fragment_input_6.y + ((-0.0f) - fragment_uniform_buffer_1[82u].y);
				float fragment_unnamed_3200 = fragment_input_6.z + ((-0.0f) - fragment_uniform_buffer_1[82u].z);
				float fragment_unnamed_3207 = fragment_uniform_buffer_1[82u].w + fragment_uniform_buffer_5[12u].w;
				float fragment_unnamed_3212 = mad((-0.0f) - fragment_unnamed_3207, fragment_unnamed_3207, dot(float3(fragment_unnamed_3198, fragment_unnamed_3199, fragment_unnamed_3200), float3(fragment_unnamed_3198, fragment_unnamed_3199, fragment_unnamed_3200)));
				float fragment_unnamed_3213 = asfloat(0u);
				float fragment_unnamed_3514;
				float fragment_unnamed_3516;
				float fragment_unnamed_3518;
				float fragment_unnamed_3520;
				float fragment_unnamed_3522;
				float fragment_unnamed_3524;
				fragment_unnamed_3514 = fragment_unnamed_1915;
				fragment_unnamed_3516 = fragment_unnamed_1917;
				fragment_unnamed_3518 = fragment_unnamed_1923;
				fragment_unnamed_3520 = fragment_unnamed_1919;
				fragment_unnamed_3522 = fragment_unnamed_1921;
				fragment_unnamed_3524 = fragment_unnamed_1925;
				float fragment_unnamed_3515;
				float fragment_unnamed_3517;
				float fragment_unnamed_3519;
				float fragment_unnamed_3521;
				float fragment_unnamed_3523;
				float fragment_unnamed_3525;
				for (float fragment_unnamed_3512 = fragment_unnamed_3213; !(asuint(fragment_unnamed_3512) >= asuint(fragment_uniform_buffer_1[114u]).x); fragment_unnamed_3512 = asfloat(asuint(fragment_unnamed_3512) + 1u), fragment_unnamed_3514 = fragment_unnamed_3515, fragment_unnamed_3516 = fragment_unnamed_3517, fragment_unnamed_3518 = fragment_unnamed_3519, fragment_unnamed_3520 = fragment_unnamed_3521, fragment_unnamed_3522 = fragment_unnamed_3523, fragment_unnamed_3524 = fragment_unnamed_3525)
				{
					float frontier_phi_86_pred;
					float frontier_phi_86_pred_1;
					float frontier_phi_86_pred_2;
					float frontier_phi_86_pred_3;
					float frontier_phi_86_pred_4;
					float frontier_phi_86_pred_5;
					if ((fragment_unnamed_676 & T5.Load((asuint(fragment_unnamed_3512) * 44u) + 3u).x) != 0u)
					{
						uint fragment_unnamed_4340 = (asuint(fragment_unnamed_3512) * 44u) + 4u;
						uint4 fragment_unnamed_4352 = uint4(T5.Load(fragment_unnamed_4340).x, T5.Load(fragment_unnamed_4340 + 1u).x, T5.Load(fragment_unnamed_4340 + 2u).x, T5.Load(fragment_unnamed_4340 + 3u).x);
						float fragment_unnamed_4354 = asfloat(fragment_unnamed_4352.x);
						float fragment_unnamed_4356 = asfloat(fragment_unnamed_4352.y);
						float fragment_unnamed_4358 = asfloat(fragment_unnamed_4352.z);
						uint fragment_unnamed_4359 = fragment_unnamed_4352.w;
						uint fragment_unnamed_4362 = (asuint(fragment_unnamed_3512) * 44u) + 36u;
						uint3 fragment_unnamed_4371 = uint3(T5.Load(fragment_unnamed_4362).x, T5.Load(fragment_unnamed_4362 + 1u).x, T5.Load(fragment_unnamed_4362 + 2u).x);
						float fragment_unnamed_4373 = asfloat(fragment_unnamed_4371.x);
						float fragment_unnamed_4375 = asfloat(fragment_unnamed_4371.y);
						float fragment_unnamed_4383 = dot(float3(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668), float3((-0.0f) - fragment_unnamed_4354, (-0.0f) - fragment_unnamed_4356, (-0.0f) - fragment_unnamed_4358));
						float fragment_unnamed_5554;
						float fragment_unnamed_5556;
						float fragment_unnamed_5558;
						float fragment_unnamed_5560;
						float fragment_unnamed_5562;
						float fragment_unnamed_5564;
						if ((((0.0f < asfloat(fragment_unnamed_4371.z)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_4383) ? 4294967295u : 0u)) != 0u)
						{
							uint fragment_unnamed_4757 = (asuint(fragment_unnamed_3512) * 44u) + 12u;
							uint4 fragment_unnamed_4769 = uint4(T5.Load(fragment_unnamed_4757).x, T5.Load(fragment_unnamed_4757 + 1u).x, T5.Load(fragment_unnamed_4757 + 2u).x, T5.Load(fragment_unnamed_4757 + 3u).x);
							float fragment_unnamed_4771 = asfloat(fragment_unnamed_4769.x);
							float fragment_unnamed_4773 = asfloat(fragment_unnamed_4769.y);
							float fragment_unnamed_4775 = asfloat(fragment_unnamed_4769.z);
							uint fragment_unnamed_4779 = (asuint(fragment_unnamed_3512) * 44u) + 16u;
							uint3 fragment_unnamed_4788 = uint3(T5.Load(fragment_unnamed_4779).x, T5.Load(fragment_unnamed_4779 + 1u).x, T5.Load(fragment_unnamed_4779 + 2u).x);
							float fragment_unnamed_4790 = asfloat(fragment_unnamed_4788.x);
							float fragment_unnamed_4792 = asfloat(fragment_unnamed_4788.y);
							float fragment_unnamed_4794 = asfloat(fragment_unnamed_4788.z);
							uint fragment_unnamed_4797 = (asuint(fragment_unnamed_3512) * 44u) + 20u;
							uint3 fragment_unnamed_4806 = uint3(T5.Load(fragment_unnamed_4797).x, T5.Load(fragment_unnamed_4797 + 1u).x, T5.Load(fragment_unnamed_4797 + 2u).x);
							float fragment_unnamed_4808 = asfloat(fragment_unnamed_4806.x);
							float fragment_unnamed_4810 = asfloat(fragment_unnamed_4806.y);
							float fragment_unnamed_4812 = asfloat(fragment_unnamed_4806.z);
							uint fragment_unnamed_4815 = (asuint(fragment_unnamed_3512) * 44u) + 24u;
							uint4 fragment_unnamed_4827 = uint4(T5.Load(fragment_unnamed_4815).x, T5.Load(fragment_unnamed_4815 + 1u).x, T5.Load(fragment_unnamed_4815 + 2u).x, T5.Load(fragment_unnamed_4815 + 3u).x);
							float fragment_unnamed_4829 = asfloat(fragment_unnamed_4827.x);
							float fragment_unnamed_4831 = asfloat(fragment_unnamed_4827.y);
							float fragment_unnamed_4833 = asfloat(fragment_unnamed_4827.z);
							float fragment_unnamed_4835 = asfloat(fragment_unnamed_4827.w);
							float fragment_unnamed_4841 = asfloat(T5.Load((asuint(fragment_unnamed_3512) * 44u) + 40u).x);
							float fragment_unnamed_4854 = 1.0f / max(dot(float3((-0.0f) - fragment_unnamed_4354, (-0.0f) - fragment_unnamed_4356, (-0.0f) - fragment_unnamed_4358), float3(fragment_uniform_buffer_1[83u].xyz)), 0.001000000047497451305389404296875f);
							float fragment_unnamed_4867 = exp2((mad(fragment_unnamed_3159, fragment_unnamed_4854 * fragment_uniform_buffer_1[90u].y, max(fragment_unnamed_3150 * fragment_unnamed_4854, 0.0f)) * fragment_uniform_buffer_1[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_5544;
							float fragment_unnamed_5545;
							float fragment_unnamed_5546;
							if (fragment_unnamed_4359 != 0u)
							{
								uint fragment_unnamed_5429 = asuint(fragment_unnamed_3512) * 44u;
								uint3 fragment_unnamed_5438 = uint3(T5.Load(fragment_unnamed_5429).x, T5.Load(fragment_unnamed_5429 + 1u).x, T5.Load(fragment_unnamed_5429 + 2u).x);
								uint fragment_unnamed_5447 = (asuint(fragment_unnamed_3512) * 44u) + 8u;
								uint4 fragment_unnamed_5459 = uint4(T5.Load(fragment_unnamed_5447).x, T5.Load(fragment_unnamed_5447 + 1u).x, T5.Load(fragment_unnamed_5447 + 2u).x, T5.Load(fragment_unnamed_5447 + 3u).x);
								float fragment_unnamed_5461 = asfloat(fragment_unnamed_5459.x);
								float fragment_unnamed_5463 = asfloat(fragment_unnamed_5459.y);
								float fragment_unnamed_5477 = ((-0.0f) - asfloat(fragment_unnamed_5438.x)) + fragment_input_6.x;
								float fragment_unnamed_5478 = ((-0.0f) - asfloat(fragment_unnamed_5438.y)) + fragment_input_6.y;
								float fragment_unnamed_5479 = ((-0.0f) - asfloat(fragment_unnamed_5438.z)) + fragment_input_6.z;
								float fragment_unnamed_5486 = mad(dot(float3(fragment_unnamed_5477, fragment_unnamed_5478, fragment_unnamed_5479), float3(fragment_unnamed_4771, fragment_unnamed_4773, fragment_unnamed_4775)), 0.5f, 0.5f);
								float fragment_unnamed_5487 = mad(dot(float3(fragment_unnamed_5477, fragment_unnamed_5478, fragment_unnamed_5479), float3(fragment_unnamed_4790, fragment_unnamed_4792, fragment_unnamed_4794)), 0.5f, 0.5f);
								bool fragment_unnamed_5488 = fragment_unnamed_4359 == 2u;
								float fragment_unnamed_5504 = 1.0f / (fragment_unnamed_5461 + fragment_uniform_buffer_1[123u].y);
								float fragment_unnamed_5505 = 1.0f / (fragment_unnamed_5463 + fragment_uniform_buffer_1[123u].y);
								float fragment_unnamed_5517 = fragment_unnamed_5461 * fragment_uniform_buffer_1[123u].x;
								float fragment_unnamed_5518 = fragment_unnamed_5463 * fragment_uniform_buffer_1[123u].x;
								float fragment_unnamed_5521 = fragment_unnamed_1797 / (fragment_unnamed_5517 + fragment_unnamed_5517);
								float fragment_unnamed_5522 = fragment_unnamed_1797 / (fragment_unnamed_5518 + fragment_unnamed_5518);
								float4 fragment_unnamed_5536 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_5521) + 1.0f, max(fragment_unnamed_5521, mad(asfloat(fragment_unnamed_5488 ? asuint(frac(fragment_unnamed_5486)) : asuint(fragment_unnamed_5486)), fragment_unnamed_5461 * fragment_unnamed_5504, mad((-0.0f) - fragment_unnamed_5504, fragment_unnamed_5461, 1.0f) * 0.5f))), fragment_unnamed_5461, asfloat(fragment_unnamed_5459.z)), mad(min(((-0.0f) - fragment_unnamed_5522) + 1.0f, max(fragment_unnamed_5522, mad(asfloat(fragment_unnamed_5488 ? asuint(frac(fragment_unnamed_5487)) : asuint(fragment_unnamed_5487)), fragment_unnamed_5463 * fragment_unnamed_5505, mad((-0.0f) - fragment_unnamed_5505, fragment_unnamed_5463, 1.0f) * 0.5f))), fragment_unnamed_5463, asfloat(fragment_unnamed_5459.w))), 0.0f);
								fragment_unnamed_5544 = fragment_unnamed_4808 * fragment_unnamed_5536.x;
								fragment_unnamed_5545 = fragment_unnamed_4810 * fragment_unnamed_5536.y;
								fragment_unnamed_5546 = fragment_unnamed_4812 * fragment_unnamed_5536.z;
							}
							else
							{
								fragment_unnamed_5544 = fragment_unnamed_4808;
								fragment_unnamed_5545 = fragment_unnamed_4810;
								fragment_unnamed_5546 = fragment_unnamed_4812;
							}
							uint fragment_unnamed_5551 = (int(fragment_unnamed_4769.w) >= int(0u)) ? 4294967295u : 0u;
							float fragment_unnamed_6964;
							float fragment_unnamed_6965;
							float fragment_unnamed_6966;
							if ((fragment_unnamed_3165 & fragment_unnamed_5551) != 0u)
							{
								float fragment_unnamed_6088 = rsqrt(dot(float3(fragment_unnamed_4771, fragment_unnamed_4773, fragment_unnamed_4775), float3(fragment_unnamed_4771, fragment_unnamed_4773, fragment_unnamed_4775)));
								float fragment_unnamed_6092 = dot(float3(fragment_unnamed_3180, fragment_unnamed_3181, fragment_unnamed_3182), float3(fragment_unnamed_6088 * fragment_unnamed_4771, fragment_unnamed_6088 * fragment_unnamed_4773, fragment_unnamed_6088 * fragment_unnamed_4775));
								float fragment_unnamed_6102 = clamp(fragment_unnamed_6092 / fragment_uniform_buffer_1[217u].x, 0.0f, 1.0f);
								float fragment_unnamed_6106 = rsqrt(dot(float3(fragment_unnamed_4790, fragment_unnamed_4792, fragment_unnamed_4794), float3(fragment_unnamed_4790, fragment_unnamed_4792, fragment_unnamed_4794)));
								float fragment_unnamed_6110 = dot(float3(fragment_unnamed_3180, fragment_unnamed_3181, fragment_unnamed_3182), float3(fragment_unnamed_6106 * fragment_unnamed_4790, fragment_unnamed_6106 * fragment_unnamed_4792, fragment_unnamed_6106 * fragment_unnamed_4794));
								float fragment_unnamed_6119 = clamp(fragment_unnamed_6110 / fragment_uniform_buffer_1[217u].y, 0.0f, 1.0f);
								float fragment_unnamed_6120 = dot(float3(fragment_unnamed_4354, fragment_unnamed_4356, fragment_unnamed_4358), float3(fragment_unnamed_4354, fragment_unnamed_4356, fragment_unnamed_4358));
								float fragment_unnamed_6123 = dot(float3(fragment_unnamed_4354, fragment_unnamed_4356, fragment_unnamed_4358), float3(fragment_unnamed_3198, fragment_unnamed_3199, fragment_unnamed_3200));
								float fragment_unnamed_6126 = fragment_unnamed_6123 + fragment_unnamed_6123;
								float4 fragment_unnamed_6142 = _VolumetricCloudsShadowsTexture.SampleLevel(S0, float2(fragment_unnamed_6102, fragment_unnamed_6119), 0.0f);
								float fragment_unnamed_6144 = fragment_unnamed_6142.x;
								float fragment_unnamed_6145 = fragment_unnamed_6142.y;
								float fragment_unnamed_6176 = asfloat((((((fragment_unnamed_6119 != 1.0f) ? 4294967295u : 0u) & ((fragment_unnamed_6102 != 1.0f) ? 4294967295u : 0u)) & (((clamp(fragment_unnamed_6110 / fragment_uniform_buffer_1[217u].y, 0.0f, 1.0f) != 0.0f) ? 4294967295u : 0u) & ((clamp(fragment_unnamed_6092 / fragment_uniform_buffer_1[217u].x, 0.0f, 1.0f) != 0.0f) ? 4294967295u : 0u))) != 0u) ? ((fragment_unnamed_6145 != 1.0f) ? asuint(mad(clamp(((mad((-0.0f) - float(int(-((0.0f < fragment_unnamed_6120) ? 4294967295u : 0u))), sqrt(mad(fragment_unnamed_6126, fragment_unnamed_6126, (-0.0f) - ((fragment_unnamed_3212 * fragment_unnamed_6120) * 4.0f))), (-0.0f) - fragment_unnamed_6126) / (fragment_unnamed_6120 + fragment_unnamed_6120)) + ((-0.0f) - fragment_unnamed_6144)) / (((-0.0f) - fragment_unnamed_6144) + fragment_unnamed_6142.z), 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_6145) + 1.0f, fragment_unnamed_6145)) : 1065353216u) : asuint(fragment_uniform_buffer_1[217u]).w);
								fragment_unnamed_6964 = fragment_unnamed_1692 * fragment_unnamed_6176;
								fragment_unnamed_6965 = fragment_unnamed_1694 * fragment_unnamed_6176;
								fragment_unnamed_6966 = fragment_unnamed_1696 * fragment_unnamed_6176;
							}
							else
							{
								fragment_unnamed_6964 = fragment_unnamed_1692;
								fragment_unnamed_6965 = fragment_unnamed_1694;
								fragment_unnamed_6966 = fragment_unnamed_1696;
							}
							bool fragment_unnamed_6976 = (fragment_unnamed_5551 & ((0.0f < fragment_unnamed_4835) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_6981 = asfloat(fragment_unnamed_6976 ? asuint(mad(fragment_unnamed_4835, fragment_unnamed_6964 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6983 = asfloat(fragment_unnamed_6976 ? asuint(mad(fragment_unnamed_4835, fragment_unnamed_6965 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6985 = asfloat(fragment_unnamed_6976 ? asuint(mad(fragment_unnamed_4835, fragment_unnamed_6966 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6997 = asfloat((fragment_unnamed_4383 >= 0.0f) ? asuint(mad(fragment_uniform_buffer_1[121u].x, clamp(fragment_unnamed_4383 + 1.0f, 0.0f, 1.0f) + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6998 = fragment_unnamed_6997 * fragment_unnamed_6981;
							float fragment_unnamed_6999 = fragment_unnamed_6997 * fragment_unnamed_6983;
							float fragment_unnamed_7000 = fragment_unnamed_6997 * fragment_unnamed_6985;
							float fragment_unnamed_7004 = ((-0.0f) - fragment_unnamed_4829) + 1.0f;
							float fragment_unnamed_7005 = ((-0.0f) - fragment_unnamed_4831) + 1.0f;
							float fragment_unnamed_7006 = ((-0.0f) - fragment_unnamed_4833) + 1.0f;
							float fragment_unnamed_7022 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6981, fragment_unnamed_6997, 1.0f), fragment_unnamed_7004, 1.0f);
							float fragment_unnamed_7023 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6983, fragment_unnamed_6997, 1.0f), fragment_unnamed_7005, 1.0f);
							float fragment_unnamed_7024 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6985, fragment_unnamed_6997, 1.0f), fragment_unnamed_7006, 1.0f);
							float fragment_unnamed_7040 = mad(fragment_unnamed_4841, ((-0.0f) - fragment_unnamed_7022) + mad(fragment_unnamed_6998 * (fragment_unnamed_6998 * fragment_unnamed_6998), fragment_unnamed_7004, fragment_unnamed_4829 * fragment_unnamed_6998), fragment_unnamed_7022) * (fragment_unnamed_4867 * fragment_unnamed_5544);
							float fragment_unnamed_7041 = mad(fragment_unnamed_4841, ((-0.0f) - fragment_unnamed_7023) + mad(fragment_unnamed_6999 * (fragment_unnamed_6999 * fragment_unnamed_6999), fragment_unnamed_7005, fragment_unnamed_4831 * fragment_unnamed_6999), fragment_unnamed_7023) * (fragment_unnamed_4867 * fragment_unnamed_5545);
							float fragment_unnamed_7042 = mad(fragment_unnamed_4841, ((-0.0f) - fragment_unnamed_7024) + mad(fragment_unnamed_7000 * (fragment_unnamed_7000 * fragment_unnamed_7000), fragment_unnamed_7006, fragment_unnamed_4833 * fragment_unnamed_7000), fragment_unnamed_7024) * (fragment_unnamed_4867 * fragment_unnamed_5546);
							float fragment_unnamed_5555;
							float fragment_unnamed_5557;
							float fragment_unnamed_5559;
							float fragment_unnamed_5561;
							float fragment_unnamed_5563;
							float fragment_unnamed_5565;
							if (0.0f < max(fragment_unnamed_7042, max(fragment_unnamed_7041, fragment_unnamed_7040)))
							{
								float fragment_unnamed_7405 = max(fragment_unnamed_1100, asfloat(T5.Load((asuint(fragment_unnamed_3512) * 44u) + 30u).x));
								float fragment_unnamed_7406 = clamp(fragment_unnamed_4383, 0.0f, 1.0f);
								float fragment_unnamed_7410 = dot(float3((-0.0f) - fragment_unnamed_4354, (-0.0f) - fragment_unnamed_4356, (-0.0f) - fragment_unnamed_4358), float3(fragment_unnamed_341, fragment_unnamed_342, fragment_unnamed_343));
								float fragment_unnamed_7415 = rsqrt(max(mad(fragment_unnamed_7410, 2.0f, 2.0f), 5.9604644775390625e-08f));
								float fragment_unnamed_7418 = clamp(fragment_unnamed_7415 * (fragment_unnamed_1018 + fragment_unnamed_4383), 0.0f, 1.0f);
								float fragment_unnamed_7422 = ((-0.0f) - clamp(mad(fragment_unnamed_7415, fragment_unnamed_7410, fragment_unnamed_7415), 0.0f, 1.0f)) + 1.0f;
								float fragment_unnamed_7423 = fragment_unnamed_7422 * fragment_unnamed_7422;
								float fragment_unnamed_7424 = fragment_unnamed_7423 * fragment_unnamed_7423;
								float fragment_unnamed_7427 = mad((-0.0f) - fragment_unnamed_7424, fragment_unnamed_7422, 1.0f);
								float fragment_unnamed_7428 = fragment_unnamed_1099 * (fragment_unnamed_7422 * fragment_unnamed_7424);
								float fragment_unnamed_7432 = fragment_unnamed_7405 * fragment_unnamed_7405;
								float fragment_unnamed_7435 = mad(mad(fragment_unnamed_7418, fragment_unnamed_7432, (-0.0f) - fragment_unnamed_7418), fragment_unnamed_7418, 1.0f);
								float fragment_unnamed_7450 = (fragment_unnamed_7432 * 0.15915493667125701904296875f) / max((fragment_unnamed_7435 * fragment_unnamed_7435) * mad(abs(fragment_unnamed_4383), fragment_unnamed_1119, fragment_unnamed_1021 * sqrt(mad(mad((-0.0f) - abs(fragment_unnamed_4383), fragment_unnamed_7432, abs(fragment_unnamed_4383)), abs(fragment_unnamed_4383), fragment_unnamed_7432))), 1.1754943508222875079687365372222e-38f);
								float fragment_unnamed_7457 = ((-0.0f) - abs(fragment_unnamed_4383)) + 1.0f;
								float fragment_unnamed_7458 = fragment_unnamed_7457 * fragment_unnamed_7457;
								float fragment_unnamed_7461 = mad(fragment_unnamed_998, fragment_unnamed_7410, fragment_unnamed_998) + (-0.5f);
								float fragment_unnamed_7466 = ((mad(fragment_unnamed_7461, fragment_unnamed_1799, 1.0f) * mad(fragment_unnamed_7461, fragment_unnamed_7457 * (fragment_unnamed_7458 * fragment_unnamed_7458), 1.0f)) * fragment_unnamed_7406) * 0.307334959506988525390625f;
								fragment_unnamed_5555 = fragment_unnamed_4375 * (fragment_unnamed_7040 * (fragment_unnamed_7406 * (fragment_unnamed_7450 * mad(fragment_unnamed_1014, fragment_unnamed_7427, fragment_unnamed_7428))));
								fragment_unnamed_5557 = fragment_unnamed_4375 * (fragment_unnamed_7041 * (fragment_unnamed_7406 * (fragment_unnamed_7450 * mad(fragment_unnamed_1016, fragment_unnamed_7427, fragment_unnamed_7428))));
								fragment_unnamed_5559 = fragment_unnamed_4375 * (fragment_unnamed_7042 * (fragment_unnamed_7406 * (fragment_unnamed_7450 * mad(fragment_unnamed_1017, fragment_unnamed_7427, fragment_unnamed_7428))));
								fragment_unnamed_5561 = fragment_unnamed_4373 * (fragment_unnamed_7040 * fragment_unnamed_7466);
								fragment_unnamed_5563 = fragment_unnamed_4373 * (fragment_unnamed_7041 * fragment_unnamed_7466);
								fragment_unnamed_5565 = fragment_unnamed_4373 * (fragment_unnamed_7042 * fragment_unnamed_7466);
							}
							else
							{
								fragment_unnamed_5555 = asfloat(0u);
								fragment_unnamed_5557 = asfloat(0u);
								fragment_unnamed_5559 = asfloat(0u);
								fragment_unnamed_5561 = asfloat(0u);
								fragment_unnamed_5563 = asfloat(0u);
								fragment_unnamed_5565 = asfloat(0u);
							}
							fragment_unnamed_5554 = fragment_unnamed_5555;
							fragment_unnamed_5556 = fragment_unnamed_5557;
							fragment_unnamed_5558 = fragment_unnamed_5559;
							fragment_unnamed_5560 = fragment_unnamed_5561;
							fragment_unnamed_5562 = fragment_unnamed_5563;
							fragment_unnamed_5564 = fragment_unnamed_5565;
						}
						else
						{
							fragment_unnamed_5554 = asfloat(0u);
							fragment_unnamed_5556 = asfloat(0u);
							fragment_unnamed_5558 = asfloat(0u);
							fragment_unnamed_5560 = asfloat(0u);
							fragment_unnamed_5562 = asfloat(0u);
							fragment_unnamed_5564 = asfloat(0u);
						}
						frontier_phi_86_pred = fragment_unnamed_3518 + fragment_unnamed_5564;
						frontier_phi_86_pred_1 = fragment_unnamed_3516 + fragment_unnamed_5562;
						frontier_phi_86_pred_2 = fragment_unnamed_3514 + fragment_unnamed_5560;
						frontier_phi_86_pred_3 = fragment_unnamed_3524 + fragment_unnamed_5558;
						frontier_phi_86_pred_4 = fragment_unnamed_3522 + fragment_unnamed_5556;
						frontier_phi_86_pred_5 = fragment_unnamed_3520 + fragment_unnamed_5554;
					}
					else
					{
						frontier_phi_86_pred = fragment_unnamed_3518;
						frontier_phi_86_pred_1 = fragment_unnamed_3516;
						frontier_phi_86_pred_2 = fragment_unnamed_3514;
						frontier_phi_86_pred_3 = fragment_unnamed_3524;
						frontier_phi_86_pred_4 = fragment_unnamed_3522;
						frontier_phi_86_pred_5 = fragment_unnamed_3520;
					}
					fragment_unnamed_3519 = frontier_phi_86_pred;
					fragment_unnamed_3517 = frontier_phi_86_pred_1;
					fragment_unnamed_3515 = frontier_phi_86_pred_2;
					fragment_unnamed_3525 = frontier_phi_86_pred_3;
					fragment_unnamed_3523 = frontier_phi_86_pred_4;
					fragment_unnamed_3521 = frontier_phi_86_pred_5;
				}
				uint4 fragment_unnamed_3702 = T3.Load(((((fragment_unnamed_1757 + fragment_unnamed_1724) * fragment_unnamed_2046) + fragment_unnamed_282) * fragment_unnamed_2054) + fragment_unnamed_280);
				uint fragment_unnamed_3703 = fragment_unnamed_3702.x;
				uint fragment_unnamed_3704 = fragment_unnamed_3703 & 67108863u;
				uint fragment_unnamed_3705 = fragment_unnamed_3703 >> 26u;
				float fragment_unnamed_3707 = mad((-0.0f) - fragment_unnamed_1145, fragment_unnamed_1143, fragment_unnamed_1142);
				float fragment_unnamed_3708 = fragment_unnamed_3707 * fragment_unnamed_1144;
				float fragment_unnamed_3714 = clamp((((-0.0f) - fragment_unnamed_998) + 0.300000011920928955078125f) * 3.3333332538604736328125f, 0.0f, 1.0f);
				float fragment_unnamed_3716 = mad((-0.0f) - fragment_unnamed_1151, fragment_unnamed_1149, fragment_unnamed_1148);
				float fragment_unnamed_3717 = fragment_unnamed_3716 * fragment_unnamed_1150;
				float fragment_unnamed_3718 = asfloat(fragment_unnamed_1155 ? asuint(fragment_unnamed_1159 * fragment_unnamed_1165) : asuint(fragment_unnamed_1185));
				float fragment_unnamed_3719 = asfloat(fragment_unnamed_1155 ? asuint(fragment_unnamed_1167) : asuint(fragment_unnamed_1186));
				float fragment_unnamed_3720 = asfloat(1065353216u);
				float fragment_unnamed_3721 = asfloat(1065353216u);
				float fragment_unnamed_3722 = asfloat(1065353216u);
				float fragment_unnamed_3723 = asfloat(1065353216u);
				float fragment_unnamed_3724 = asfloat(0u);
				float fragment_unnamed_4322;
				float fragment_unnamed_4324;
				float fragment_unnamed_4326;
				float fragment_unnamed_4328;
				float fragment_unnamed_4330;
				float fragment_unnamed_4332;
				float fragment_unnamed_4334;
				for (;;)
				{
					fragment_unnamed_4322 = fragment_unnamed_3516;
					fragment_unnamed_4324 = fragment_unnamed_3518;
					fragment_unnamed_4326 = fragment_unnamed_3520;
					fragment_unnamed_4328 = fragment_unnamed_3522;
					fragment_unnamed_4330 = fragment_unnamed_3524;
					fragment_unnamed_4332 = fragment_unnamed_3724;
					fragment_unnamed_4334 = fragment_unnamed_3514;
					float fragment_unnamed_4333;
					float fragment_unnamed_4323;
					float fragment_unnamed_4325;
					float fragment_unnamed_4327;
					float fragment_unnamed_4329;
					float fragment_unnamed_4331;
					float fragment_unnamed_4335;
					bool ladder_phi_108;
					for (;;)
					{
						if (asuint(fragment_unnamed_4332) >= fragment_unnamed_3705)
						{
							ladder_phi_108 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_4750 = asuint(fragment_unnamed_4332);
							uint4 fragment_unnamed_4752 = T2.Load(fragment_unnamed_3704 + fragment_unnamed_4750);
							uint fragment_unnamed_4753 = fragment_unnamed_4752.x;
							if (fragment_unnamed_4753 == 4294967295u)
							{
								ladder_phi_108 = false;
								break;
							}
							uint fragment_unnamed_5404 = fragment_unnamed_4753 * 56u;
							uint4 fragment_unnamed_5416 = uint4(T6.Load(fragment_unnamed_5404).x, T6.Load(fragment_unnamed_5404 + 1u).x, T6.Load(fragment_unnamed_5404 + 2u).x, T6.Load(fragment_unnamed_5404 + 3u).x);
							fragment_unnamed_4333 = asfloat(asuint(fragment_unnamed_4332) + 1u);
							if (!((fragment_unnamed_676 & fragment_unnamed_5416.w) != 0u))
							{
								fragment_unnamed_4323 = fragment_unnamed_4322;
								fragment_unnamed_4325 = fragment_unnamed_4324;
								fragment_unnamed_4327 = fragment_unnamed_4326;
								fragment_unnamed_4329 = fragment_unnamed_4328;
								fragment_unnamed_4331 = fragment_unnamed_4330;
								fragment_unnamed_4335 = fragment_unnamed_4334;
								fragment_unnamed_4322 = fragment_unnamed_4323;
								fragment_unnamed_4324 = fragment_unnamed_4325;
								fragment_unnamed_4326 = fragment_unnamed_4327;
								fragment_unnamed_4328 = fragment_unnamed_4329;
								fragment_unnamed_4330 = fragment_unnamed_4331;
								fragment_unnamed_4332 = fragment_unnamed_4333;
								fragment_unnamed_4334 = fragment_unnamed_4335;
								continue;
							}
							uint fragment_unnamed_5888 = (fragment_unnamed_4753 * 56u) + 8u;
							uint3 fragment_unnamed_5897 = uint3(T6.Load(fragment_unnamed_5888).x, T6.Load(fragment_unnamed_5888 + 1u).x, T6.Load(fragment_unnamed_5888 + 2u).x);
							uint fragment_unnamed_5905 = (fragment_unnamed_4753 * 56u) + 12u;
							uint4 fragment_unnamed_5917 = uint4(T6.Load(fragment_unnamed_5905).x, T6.Load(fragment_unnamed_5905 + 1u).x, T6.Load(fragment_unnamed_5905 + 2u).x, T6.Load(fragment_unnamed_5905 + 3u).x);
							float fragment_unnamed_5920 = asfloat(fragment_unnamed_5917.y);
							float fragment_unnamed_5922 = asfloat(fragment_unnamed_5917.z);
							float fragment_unnamed_5924 = asfloat(fragment_unnamed_5917.w);
							uint fragment_unnamed_5926 = (fragment_unnamed_4753 * 56u) + 18u;
							uint4 fragment_unnamed_5938 = uint4(T6.Load(fragment_unnamed_5926).x, T6.Load(fragment_unnamed_5926 + 1u).x, T6.Load(fragment_unnamed_5926 + 2u).x, T6.Load(fragment_unnamed_5926 + 3u).x);
							uint fragment_unnamed_5939 = fragment_unnamed_5938.x;
							uint fragment_unnamed_5940 = fragment_unnamed_5938.y;
							uint fragment_unnamed_5944 = (fragment_unnamed_4753 * 56u) + 22u;
							uint4 fragment_unnamed_5956 = uint4(T6.Load(fragment_unnamed_5944).x, T6.Load(fragment_unnamed_5944 + 1u).x, T6.Load(fragment_unnamed_5944 + 2u).x, T6.Load(fragment_unnamed_5944 + 3u).x);
							float fragment_unnamed_5958 = asfloat(fragment_unnamed_5956.z);
							float fragment_unnamed_5960 = asfloat(fragment_unnamed_5956.w);
							uint fragment_unnamed_5965 = (fragment_unnamed_4753 * 56u) + 26u;
							uint4 fragment_unnamed_5977 = uint4(T6.Load(fragment_unnamed_5965).x, T6.Load(fragment_unnamed_5965 + 1u).x, T6.Load(fragment_unnamed_5965 + 2u).x, T6.Load(fragment_unnamed_5965 + 3u).x);
							uint fragment_unnamed_5978 = fragment_unnamed_5977.x;
							float fragment_unnamed_5982 = asfloat(fragment_unnamed_5977.z);
							float fragment_unnamed_5984 = asfloat(fragment_unnamed_5977.w);
							uint fragment_unnamed_5986 = (fragment_unnamed_4753 * 56u) + 30u;
							uint4 fragment_unnamed_5998 = uint4(T6.Load(fragment_unnamed_5986).x, T6.Load(fragment_unnamed_5986 + 1u).x, T6.Load(fragment_unnamed_5986 + 2u).x, T6.Load(fragment_unnamed_5986 + 3u).x);
							float fragment_unnamed_6000 = asfloat(fragment_unnamed_5998.x);
							float fragment_unnamed_6002 = asfloat(fragment_unnamed_5998.y);
							uint fragment_unnamed_6006 = (fragment_unnamed_4753 * 56u) + 44u;
							uint2 fragment_unnamed_6012 = uint2(T6.Load(fragment_unnamed_6006).x, T6.Load(fragment_unnamed_6006 + 1u).x);
							float fragment_unnamed_6014 = asfloat(fragment_unnamed_6012.x);
							float fragment_unnamed_6016 = asfloat(fragment_unnamed_6012.y);
							bool fragment_unnamed_6017 = fragment_unnamed_5917.x == 6u;
							uint fragment_unnamed_6018 = fragment_unnamed_6017 ? 4294967295u : 0u;
							float fragment_unnamed_6028 = asfloat(fragment_unnamed_5416.x) + ((-0.0f) - fragment_input_6.x);
							float fragment_unnamed_6029 = asfloat(fragment_unnamed_5416.y) + ((-0.0f) - fragment_input_6.y);
							float fragment_unnamed_6030 = asfloat(fragment_unnamed_5416.z) + ((-0.0f) - fragment_input_6.z);
							float fragment_unnamed_6031 = fragment_unnamed_6014 * 0.5f;
							float fragment_unnamed_6032 = fragment_unnamed_6016 * 0.5f;
							float fragment_unnamed_6033 = dot(float3(fragment_unnamed_6028, fragment_unnamed_6029, fragment_unnamed_6030), float3(fragment_unnamed_5920, fragment_unnamed_5922, fragment_unnamed_5924));
							float fragment_unnamed_6039 = max(mad((-0.0f) - fragment_unnamed_6014, 0.5f, abs(fragment_unnamed_6033)), 0.0f);
							float fragment_unnamed_6040 = asfloat(fragment_unnamed_5938.z);
							float fragment_unnamed_6041 = asfloat(fragment_unnamed_5938.w);
							float fragment_unnamed_6042 = asfloat(fragment_unnamed_5956.x);
							float fragment_unnamed_6043 = dot(float3(fragment_unnamed_6028, fragment_unnamed_6029, fragment_unnamed_6030), float3(fragment_unnamed_6040, fragment_unnamed_6041, fragment_unnamed_6042));
							float fragment_unnamed_6049 = max(mad((-0.0f) - fragment_unnamed_6016, 0.5f, abs(fragment_unnamed_6043)), 0.0f);
							float fragment_unnamed_6060 = asfloat(fragment_unnamed_5956.y) * mad(fragment_unnamed_6049, fragment_unnamed_6049, mad(fragment_unnamed_6039, fragment_unnamed_6039, max(mad((-0.0f) - fragment_unnamed_6043, fragment_unnamed_6043, mad((-0.0f) - fragment_unnamed_6033, fragment_unnamed_6033, dot(float3(fragment_unnamed_6028, fragment_unnamed_6029, fragment_unnamed_6030), float3(fragment_unnamed_6028, fragment_unnamed_6029, fragment_unnamed_6030)))), 0.0f)));
							float fragment_unnamed_6063 = clamp(mad((-0.0f) - fragment_unnamed_6060, fragment_unnamed_6060, asfloat(fragment_unnamed_5977.y)), 0.0f, 1.0f);
							float fragment_unnamed_6074 = asfloat(((fragment_unnamed_6018 & ((dot(float3(fragment_unnamed_6028, fragment_unnamed_6029, fragment_unnamed_6030), float3(asfloat(fragment_unnamed_5897.x), asfloat(fragment_unnamed_5897.y), asfloat(fragment_unnamed_5897.z))) >= 0.0f) ? 4294967295u : 0u)) != 0u) ? 0u : asuint(fragment_unnamed_6063 * fragment_unnamed_6063));
							uint fragment_unnamed_6076 = (0.0f < fragment_unnamed_6074) ? 4294967295u : 0u;
							float fragment_unnamed_7388;
							float fragment_unnamed_7390;
							float fragment_unnamed_7392;
							float fragment_unnamed_7394;
							if ((fragment_unnamed_6018 & fragment_unnamed_6076) != 0u)
							{
								float fragment_unnamed_6943 = asfloat(T6.Load((fragment_unnamed_4753 * 56u) + 16u).x);
								uint fragment_unnamed_6945 = (fragment_unnamed_4753 * 56u) + 34u;
								uint2 fragment_unnamed_6951 = uint2(T6.Load(fragment_unnamed_6945).x, T6.Load(fragment_unnamed_6945 + 1u).x);
								float fragment_unnamed_6953 = asfloat(fragment_unnamed_6951.x);
								float fragment_unnamed_6955 = asfloat(fragment_unnamed_6951.y);
								float fragment_unnamed_7846;
								if ((((int(fragment_unnamed_5940) >= int(0u)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_6955) ? 4294967295u : 0u)) != 0u)
								{
									uint fragment_unnamed_7236 = fragment_unnamed_5940 * 60u;
									uint4 fragment_unnamed_7248 = uint4(T29.Load(fragment_unnamed_7236).x, T29.Load(fragment_unnamed_7236 + 1u).x, T29.Load(fragment_unnamed_7236 + 2u).x, T29.Load(fragment_unnamed_7236 + 3u).x);
									float fragment_unnamed_7250 = asfloat(fragment_unnamed_7248.w);
									float fragment_unnamed_7252 = asfloat(fragment_unnamed_7248.x);
									float fragment_unnamed_7254 = asfloat(fragment_unnamed_7248.y);
									float fragment_unnamed_7256 = asfloat(fragment_unnamed_7248.z);
									uint fragment_unnamed_7258 = (fragment_unnamed_5940 * 60u) + 4u;
									uint4 fragment_unnamed_7270 = uint4(T29.Load(fragment_unnamed_7258).x, T29.Load(fragment_unnamed_7258 + 1u).x, T29.Load(fragment_unnamed_7258 + 2u).x, T29.Load(fragment_unnamed_7258 + 3u).x);
									uint fragment_unnamed_7271 = fragment_unnamed_7270.x;
									uint fragment_unnamed_7272 = fragment_unnamed_7270.y;
									uint fragment_unnamed_7273 = fragment_unnamed_7270.z;
									uint fragment_unnamed_7274 = fragment_unnamed_7270.w;
									uint fragment_unnamed_7276 = (fragment_unnamed_5940 * 60u) + 8u;
									uint4 fragment_unnamed_7288 = uint4(T29.Load(fragment_unnamed_7276).x, T29.Load(fragment_unnamed_7276 + 1u).x, T29.Load(fragment_unnamed_7276 + 2u).x, T29.Load(fragment_unnamed_7276 + 3u).x);
									float fragment_unnamed_7290 = asfloat(fragment_unnamed_7288.y);
									float fragment_unnamed_7292 = asfloat(fragment_unnamed_7288.z);
									float fragment_unnamed_7294 = asfloat(fragment_unnamed_7288.x);
									uint fragment_unnamed_7295 = fragment_unnamed_7288.w;
									uint fragment_unnamed_7297 = (fragment_unnamed_5940 * 60u) + 12u;
									uint4 fragment_unnamed_7309 = uint4(T29.Load(fragment_unnamed_7297).x, T29.Load(fragment_unnamed_7297 + 1u).x, T29.Load(fragment_unnamed_7297 + 2u).x, T29.Load(fragment_unnamed_7297 + 3u).x);
									float fragment_unnamed_7311 = asfloat(fragment_unnamed_7309.x);
									float fragment_unnamed_7313 = asfloat(fragment_unnamed_7309.y);
									float fragment_unnamed_7315 = asfloat(fragment_unnamed_7309.z);
									float fragment_unnamed_7317 = asfloat(fragment_unnamed_7309.w);
									uint fragment_unnamed_7319 = (fragment_unnamed_5940 * 60u) + 16u;
									uint2 fragment_unnamed_7325 = uint2(T29.Load(fragment_unnamed_7319).x, T29.Load(fragment_unnamed_7319 + 1u).x);
									float fragment_unnamed_7327 = asfloat(fragment_unnamed_7325.x);
									float fragment_unnamed_7329 = asfloat(fragment_unnamed_7325.y);
									uint fragment_unnamed_7331 = (fragment_unnamed_5940 * 60u) + 24u;
									uint2 fragment_unnamed_7337 = uint2(T29.Load(fragment_unnamed_7331).x, T29.Load(fragment_unnamed_7331 + 1u).x);
									float fragment_unnamed_7339 = asfloat(fragment_unnamed_7337.x);
									float fragment_unnamed_7341 = asfloat(fragment_unnamed_7337.y);
									uint fragment_unnamed_7343 = (fragment_unnamed_5940 * 60u) + 28u;
									uint4 fragment_unnamed_7355 = uint4(T29.Load(fragment_unnamed_7343).x, T29.Load(fragment_unnamed_7343 + 1u).x, T29.Load(fragment_unnamed_7343 + 2u).x, T29.Load(fragment_unnamed_7343 + 3u).x);
									float fragment_unnamed_7357 = asfloat(fragment_unnamed_7355.x);
									float fragment_unnamed_7359 = asfloat(fragment_unnamed_7355.y);
									float fragment_unnamed_7361 = asfloat(fragment_unnamed_7355.z);
									float fragment_unnamed_7363 = asfloat(fragment_unnamed_7355.w);
									uint fragment_unnamed_7365 = (fragment_unnamed_5940 * 60u) + 40u;
									uint4 fragment_unnamed_7377 = uint4(T29.Load(fragment_unnamed_7365).x, T29.Load(fragment_unnamed_7365 + 1u).x, T29.Load(fragment_unnamed_7365 + 2u).x, T29.Load(fragment_unnamed_7365 + 3u).x);
									float fragment_unnamed_7379 = asfloat(fragment_unnamed_7377.x);
									float fragment_unnamed_7381 = asfloat(fragment_unnamed_7377.y);
									float fragment_unnamed_7383 = asfloat(fragment_unnamed_7377.z);
									float fragment_unnamed_7385 = asfloat(fragment_unnamed_7377.w);
									float fragment_unnamed_8239;
									if (0.0f < fragment_unnamed_7385)
									{
										bool fragment_unnamed_7586 = 0.0f != fragment_unnamed_7385;
										uint4 fragment_unnamed_7590 = asuint(fragment_uniform_buffer_1[101u]);
										uint4 fragment_unnamed_7596 = asuint(fragment_uniform_buffer_1[99u]);
										float fragment_unnamed_7600 = asfloat(fragment_unnamed_7586 ? fragment_unnamed_7590.z : fragment_unnamed_7596.z);
										float fragment_unnamed_7602 = asfloat(fragment_unnamed_7586 ? fragment_unnamed_7590.w : fragment_unnamed_7596.w);
										float fragment_unnamed_7616 = ((-0.0f) - fragment_unnamed_7290) + (fragment_unnamed_7379 + fragment_input_6.x);
										float fragment_unnamed_7617 = ((-0.0f) - fragment_unnamed_7292) + (fragment_unnamed_7381 + fragment_input_6.y);
										float fragment_unnamed_7618 = ((-0.0f) - asfloat(fragment_unnamed_7295)) + (fragment_unnamed_7383 + fragment_input_6.z);
										float fragment_unnamed_7629 = dot(float3(asfloat(fragment_unnamed_7273), asfloat(fragment_unnamed_7274), fragment_unnamed_7294), float3(fragment_unnamed_7616, fragment_unnamed_7617, fragment_unnamed_7618));
										float fragment_unnamed_7632 = dot(float3(fragment_unnamed_7252, fragment_unnamed_7254, fragment_unnamed_7256), float3(fragment_unnamed_7616, fragment_unnamed_7617, fragment_unnamed_7618)) * fragment_unnamed_7311;
										float fragment_unnamed_7633 = dot(float3(fragment_unnamed_7250, asfloat(fragment_unnamed_7271), asfloat(fragment_unnamed_7272)), float3(fragment_unnamed_7616, fragment_unnamed_7617, fragment_unnamed_7618)) * fragment_unnamed_7313;
										float fragment_unnamed_7634 = dot(float2(fragment_unnamed_7315, fragment_unnamed_7317), float2(fragment_unnamed_7629, fragment_unnamed_3720));
										bool fragment_unnamed_7637 = fragment_unnamed_7629 != (-0.0f);
										float fragment_unnamed_7638 = (-0.0f) - fragment_unnamed_7629;
										float fragment_unnamed_7660 = mad(fragment_unnamed_7339 * clamp(mad(asfloat(fragment_unnamed_7637 ? asuint(fragment_unnamed_7632 / fragment_unnamed_7638) : asuint(fragment_unnamed_7632)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7600, fragment_unnamed_7327);
										float fragment_unnamed_7661 = mad(fragment_unnamed_7341 * clamp(mad(asfloat(fragment_unnamed_7637 ? asuint(fragment_unnamed_7633 / fragment_unnamed_7638) : asuint(fragment_unnamed_7633)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7602, fragment_unnamed_7329);
										float fragment_unnamed_7662 = trunc(mad(min(fragment_unnamed_7363, 4.0f), 4.0f, 1.0f));
										float fragment_unnamed_7663 = (-0.0f) - fragment_unnamed_7662;
										float4 fragment_unnamed_7684 = _CachedAreaLightShadowmapAtlas.SampleLevel(S0, float2(fragment_unnamed_7660, fragment_unnamed_7661), 0.0f);
										float fragment_unnamed_7686 = fragment_unnamed_7684.x;
										float fragment_unnamed_7690 = exp2(mad(((-0.0f) - asfloat(fragment_unnamed_7637 ? asuint(fragment_unnamed_7634 / fragment_unnamed_7638) : asuint(fragment_unnamed_7634))) + 1.0f, 2.0f, -1.0f) * fragment_unnamed_7357);
										float fragment_unnamed_7691 = fragment_unnamed_7690 * fragment_unnamed_7357;
										float fragment_unnamed_7696 = max(fragment_unnamed_7361 * (fragment_unnamed_7691 * fragment_unnamed_7691), mad((-0.0f) - fragment_unnamed_7686, fragment_unnamed_7686, fragment_unnamed_7684.y));
										float fragment_unnamed_7698 = ((-0.0f) - fragment_unnamed_7686) + fragment_unnamed_7690;
										fragment_unnamed_8239 = asfloat((((((mad(mad(fragment_unnamed_7663, 0.5f, fragment_unnamed_7341), fragment_unnamed_7602, fragment_unnamed_7329) < fragment_unnamed_7661) ? 4294967295u : 0u) | ((mad(mad(fragment_unnamed_7663, 0.5f, fragment_unnamed_7339), fragment_unnamed_7600, fragment_unnamed_7327) < fragment_unnamed_7660) ? 4294967295u : 0u)) | (((fragment_unnamed_7661 < mad(fragment_unnamed_7602, fragment_unnamed_7662, fragment_unnamed_7329)) ? 4294967295u : 0u) | ((fragment_unnamed_7660 < mad(fragment_unnamed_7600, fragment_unnamed_7662, fragment_unnamed_7327)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(max(asfloat(((fragment_unnamed_7686 >= fragment_unnamed_7690) ? 4294967295u : 0u) & 1065353216u), clamp((((-0.0f) - fragment_unnamed_7359) + (fragment_unnamed_7696 / mad(fragment_unnamed_7698, fragment_unnamed_7698, fragment_unnamed_7696))) / (((-0.0f) - fragment_unnamed_7359) + 1.0f), 0.0f, 1.0f))));
									}
									else
									{
										bool fragment_unnamed_7718 = 0.0f != fragment_unnamed_7385;
										uint4 fragment_unnamed_7721 = asuint(fragment_uniform_buffer_1[101u]);
										uint4 fragment_unnamed_7726 = asuint(fragment_uniform_buffer_1[99u]);
										float fragment_unnamed_7730 = asfloat(fragment_unnamed_7718 ? fragment_unnamed_7721.z : fragment_unnamed_7726.z);
										float fragment_unnamed_7732 = asfloat(fragment_unnamed_7718 ? fragment_unnamed_7721.w : fragment_unnamed_7726.w);
										float fragment_unnamed_7746 = ((-0.0f) - fragment_unnamed_7290) + (fragment_unnamed_7379 + fragment_input_6.x);
										float fragment_unnamed_7747 = ((-0.0f) - fragment_unnamed_7292) + (fragment_unnamed_7381 + fragment_input_6.y);
										float fragment_unnamed_7748 = ((-0.0f) - asfloat(fragment_unnamed_7295)) + (fragment_unnamed_7383 + fragment_input_6.z);
										float fragment_unnamed_7759 = dot(float3(asfloat(fragment_unnamed_7273), asfloat(fragment_unnamed_7274), fragment_unnamed_7294), float3(fragment_unnamed_7746, fragment_unnamed_7747, fragment_unnamed_7748));
										float fragment_unnamed_7762 = dot(float3(fragment_unnamed_7252, fragment_unnamed_7254, fragment_unnamed_7256), float3(fragment_unnamed_7746, fragment_unnamed_7747, fragment_unnamed_7748)) * fragment_unnamed_7311;
										float fragment_unnamed_7763 = dot(float3(fragment_unnamed_7250, asfloat(fragment_unnamed_7271), asfloat(fragment_unnamed_7272)), float3(fragment_unnamed_7746, fragment_unnamed_7747, fragment_unnamed_7748)) * fragment_unnamed_7313;
										float fragment_unnamed_7764 = dot(float2(fragment_unnamed_7315, fragment_unnamed_7317), float2(fragment_unnamed_7759, fragment_unnamed_3721));
										bool fragment_unnamed_7767 = fragment_unnamed_7759 != (-0.0f);
										float fragment_unnamed_7768 = (-0.0f) - fragment_unnamed_7759;
										float fragment_unnamed_7790 = mad(fragment_unnamed_7339 * clamp(mad(asfloat(fragment_unnamed_7767 ? asuint(fragment_unnamed_7762 / fragment_unnamed_7768) : asuint(fragment_unnamed_7762)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7730, fragment_unnamed_7327);
										float fragment_unnamed_7791 = mad(fragment_unnamed_7341 * clamp(mad(asfloat(fragment_unnamed_7767 ? asuint(fragment_unnamed_7763 / fragment_unnamed_7768) : asuint(fragment_unnamed_7763)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7732, fragment_unnamed_7329);
										float fragment_unnamed_7792 = trunc(mad(min(fragment_unnamed_7363, 4.0f), 4.0f, 1.0f));
										float fragment_unnamed_7793 = (-0.0f) - fragment_unnamed_7792;
										float4 fragment_unnamed_7814 = _ShadowmapAreaAtlas.SampleLevel(S0, float2(fragment_unnamed_7790, fragment_unnamed_7791), 0.0f);
										float fragment_unnamed_7816 = fragment_unnamed_7814.x;
										float fragment_unnamed_7820 = exp2(mad(((-0.0f) - asfloat(fragment_unnamed_7767 ? asuint(fragment_unnamed_7764 / fragment_unnamed_7768) : asuint(fragment_unnamed_7764))) + 1.0f, 2.0f, -1.0f) * fragment_unnamed_7357);
										float fragment_unnamed_7821 = fragment_unnamed_7820 * fragment_unnamed_7357;
										float fragment_unnamed_7826 = max(fragment_unnamed_7361 * (fragment_unnamed_7821 * fragment_unnamed_7821), mad((-0.0f) - fragment_unnamed_7816, fragment_unnamed_7816, fragment_unnamed_7814.y));
										float fragment_unnamed_7828 = ((-0.0f) - fragment_unnamed_7816) + fragment_unnamed_7820;
										fragment_unnamed_8239 = asfloat((((((mad(mad(fragment_unnamed_7793, 0.5f, fragment_unnamed_7341), fragment_unnamed_7732, fragment_unnamed_7329) < fragment_unnamed_7791) ? 4294967295u : 0u) | ((mad(mad(fragment_unnamed_7793, 0.5f, fragment_unnamed_7339), fragment_unnamed_7730, fragment_unnamed_7327) < fragment_unnamed_7790) ? 4294967295u : 0u)) | (((fragment_unnamed_7791 < mad(fragment_unnamed_7732, fragment_unnamed_7792, fragment_unnamed_7329)) ? 4294967295u : 0u) | ((fragment_unnamed_7790 < mad(fragment_unnamed_7730, fragment_unnamed_7792, fragment_unnamed_7327)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(max(asfloat(((fragment_unnamed_7816 >= fragment_unnamed_7820) ? 4294967295u : 0u) & 1065353216u), clamp((((-0.0f) - fragment_unnamed_7359) + (fragment_unnamed_7826 / mad(fragment_unnamed_7828, fragment_unnamed_7828, fragment_unnamed_7826))) / (((-0.0f) - fragment_unnamed_7359) + 1.0f), 0.0f, 1.0f))));
									}
									fragment_unnamed_7846 = mad(fragment_unnamed_6955, fragment_unnamed_8239 + (-1.0f), 1.0f);
								}
								else
								{
									fragment_unnamed_7846 = asfloat(1065353216u);
								}
								float fragment_unnamed_7848 = asfloat(fragment_unnamed_5998.z);
								float fragment_unnamed_7849 = asfloat(fragment_unnamed_5998.w);
								float fragment_unnamed_7853 = ((-0.0f) - fragment_unnamed_7848) + 1.0f;
								float fragment_unnamed_7854 = ((-0.0f) - fragment_unnamed_7849) + 1.0f;
								float fragment_unnamed_7855 = ((-0.0f) - fragment_unnamed_6953) + 1.0f;
								float fragment_unnamed_7857 = fragment_unnamed_7846 * (fragment_unnamed_7846 * fragment_unnamed_7846);
								float fragment_unnamed_7860 = (-0.0f) - (((-0.0f) - fragment_unnamed_7846) + 1.0f);
								float fragment_unnamed_7861 = mad(fragment_unnamed_7860, fragment_unnamed_7853, 1.0f);
								float fragment_unnamed_7862 = mad(fragment_unnamed_7860, fragment_unnamed_7854, 1.0f);
								float fragment_unnamed_7863 = mad(fragment_unnamed_7860, fragment_unnamed_7855, 1.0f);
								float fragment_unnamed_7391 = mad(fragment_unnamed_6943, ((-0.0f) - fragment_unnamed_7861) + mad(fragment_unnamed_7857, fragment_unnamed_7853, fragment_unnamed_7848 * fragment_unnamed_7846), fragment_unnamed_7861) * fragment_unnamed_5958;
								float fragment_unnamed_7393 = mad(fragment_unnamed_6943, ((-0.0f) - fragment_unnamed_7862) + mad(fragment_unnamed_7857, fragment_unnamed_7854, fragment_unnamed_7849 * fragment_unnamed_7846), fragment_unnamed_7862) * fragment_unnamed_5960;
								float fragment_unnamed_7395 = mad(fragment_unnamed_6943, ((-0.0f) - fragment_unnamed_7863) + mad(fragment_unnamed_7857, fragment_unnamed_7855, fragment_unnamed_6953 * fragment_unnamed_7846), fragment_unnamed_7863) * asfloat(fragment_unnamed_5978);
								fragment_unnamed_7388 = asfloat((0.0f < max(fragment_unnamed_7395, max(fragment_unnamed_7393, fragment_unnamed_7391))) ? 4294967295u : 0u);
								fragment_unnamed_7390 = fragment_unnamed_7391;
								fragment_unnamed_7392 = fragment_unnamed_7393;
								fragment_unnamed_7394 = fragment_unnamed_7395;
							}
							else
							{
								fragment_unnamed_7388 = asfloat(4294967295u);
								fragment_unnamed_7390 = fragment_unnamed_5958;
								fragment_unnamed_7392 = fragment_unnamed_5960;
								fragment_unnamed_7394 = asfloat(fragment_unnamed_5978);
							}
							float fragment_unnamed_8259;
							float fragment_unnamed_8261;
							float fragment_unnamed_8263;
							float fragment_unnamed_8265;
							float fragment_unnamed_8267;
							float fragment_unnamed_8269;
							if ((fragment_unnamed_6076 & asuint(fragment_unnamed_7388)) != 0u)
							{
								uint fragment_unnamed_7885 = (fragment_unnamed_4753 * 56u) + 49u;
								uint2 fragment_unnamed_7891 = uint2(T6.Load(fragment_unnamed_7885).x, T6.Load(fragment_unnamed_7885 + 1u).x);
								float fragment_unnamed_7896 = dot(float3(fragment_unnamed_1210, fragment_unnamed_3718, fragment_unnamed_3719), float3(fragment_unnamed_6028, fragment_unnamed_6029, fragment_unnamed_6030));
								float fragment_unnamed_7902 = dot(float3(asfloat(fragment_unnamed_1201), asfloat(fragment_unnamed_1202), asfloat(fragment_unnamed_1211)), float3(fragment_unnamed_6028, fragment_unnamed_6029, fragment_unnamed_6030));
								float fragment_unnamed_7905 = dot(float3(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668), float3(fragment_unnamed_6028, fragment_unnamed_6029, fragment_unnamed_6030));
								float fragment_unnamed_7908 = dot(float3(fragment_unnamed_1210, fragment_unnamed_3718, fragment_unnamed_3719), float3(fragment_unnamed_5920, fragment_unnamed_5922, fragment_unnamed_5924));
								float fragment_unnamed_7914 = dot(float3(asfloat(fragment_unnamed_1201), asfloat(fragment_unnamed_1202), asfloat(fragment_unnamed_1211)), float3(fragment_unnamed_5920, fragment_unnamed_5922, fragment_unnamed_5924));
								float fragment_unnamed_7917 = dot(float3(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668), float3(fragment_unnamed_5920, fragment_unnamed_5922, fragment_unnamed_5924));
								float fragment_unnamed_7920 = dot(float3(fragment_unnamed_1210, fragment_unnamed_3718, fragment_unnamed_3719), float3(fragment_unnamed_6040, fragment_unnamed_6041, fragment_unnamed_6042));
								float fragment_unnamed_7926 = dot(float3(asfloat(fragment_unnamed_1201), asfloat(fragment_unnamed_1202), asfloat(fragment_unnamed_1211)), float3(fragment_unnamed_6040, fragment_unnamed_6041, fragment_unnamed_6042));
								float fragment_unnamed_7929 = dot(float3(fragment_unnamed_664, fragment_unnamed_666, fragment_unnamed_668), float3(fragment_unnamed_6040, fragment_unnamed_6041, fragment_unnamed_6042));
								float fragment_unnamed_7938 = mad(fragment_unnamed_7902, fragment_unnamed_7917, (-0.0f) - (fragment_unnamed_7914 * fragment_unnamed_7905));
								float fragment_unnamed_7939 = mad(fragment_unnamed_7905, fragment_unnamed_7908, (-0.0f) - (fragment_unnamed_7917 * fragment_unnamed_7896));
								float fragment_unnamed_7940 = mad(fragment_unnamed_7896, fragment_unnamed_7914, (-0.0f) - (fragment_unnamed_7908 * fragment_unnamed_7902));
								float fragment_unnamed_7941 = dot(float3(fragment_unnamed_7938, fragment_unnamed_7939, fragment_unnamed_7940), float3(fragment_unnamed_7938, fragment_unnamed_7939, fragment_unnamed_7940));
								uint fragment_unnamed_7952 = ((fragment_unnamed_7941 == 0.0f) ? 4294967295u : 0u) | ((0.0f >= mad(fragment_unnamed_6032, abs(fragment_unnamed_7929), mad(fragment_unnamed_6031, abs(fragment_unnamed_7917), fragment_unnamed_7905))) ? 4294967295u : 0u);
								float fragment_unnamed_8508;
								float fragment_unnamed_8510;
								float fragment_unnamed_8512;
								float fragment_unnamed_8514;
								if (fragment_unnamed_7952 == 0u)
								{
									float fragment_unnamed_8241 = dot(float2(fragment_unnamed_3722, fragment_unnamed_1143), float2(fragment_unnamed_7905, fragment_unnamed_7896));
									float fragment_unnamed_8244 = dot(float2(fragment_unnamed_3722, fragment_unnamed_1143), float2(fragment_unnamed_7917, fragment_unnamed_7908));
									float fragment_unnamed_8247 = dot(float2(fragment_unnamed_1143, fragment_unnamed_3722), float2(fragment_unnamed_7920, fragment_unnamed_7929));
									float fragment_unnamed_8509;
									float fragment_unnamed_8511;
									float fragment_unnamed_8513;
									float fragment_unnamed_8515;
									if (0.0f < mad(fragment_unnamed_6032, abs(fragment_unnamed_8247), mad(fragment_unnamed_6031, abs(fragment_unnamed_8244), fragment_unnamed_8241)))
									{
										float fragment_unnamed_8496 = dot(float2(fragment_unnamed_1145, fragment_unnamed_1142), float2(fragment_unnamed_7905, fragment_unnamed_7896));
										float fragment_unnamed_8499 = fragment_unnamed_1144 * fragment_unnamed_7902;
										float fragment_unnamed_8500 = dot(float2(fragment_unnamed_1145, fragment_unnamed_1142), float2(fragment_unnamed_7917, fragment_unnamed_7908));
										float fragment_unnamed_8503 = fragment_unnamed_1144 * fragment_unnamed_7914;
										float fragment_unnamed_9573;
										float fragment_unnamed_9574;
										float fragment_unnamed_9575;
										float fragment_unnamed_9576;
										if (fragment_unnamed_6017)
										{
											float fragment_unnamed_9233 = dot(float2(fragment_unnamed_1142, fragment_unnamed_1145), float2(fragment_unnamed_7920, fragment_unnamed_7929));
											float fragment_unnamed_9236 = fragment_unnamed_7926 * fragment_unnamed_1144;
											float fragment_unnamed_9237 = (-0.0f) - fragment_unnamed_6031;
											float fragment_unnamed_9241 = (-0.0f) - fragment_unnamed_6032;
											float fragment_unnamed_9242 = mad(fragment_unnamed_9241, fragment_unnamed_9233, mad(fragment_unnamed_9237, fragment_unnamed_8500, fragment_unnamed_8496));
											float fragment_unnamed_9243 = mad(fragment_unnamed_9241, fragment_unnamed_9236, mad(fragment_unnamed_9237, fragment_unnamed_8503, fragment_unnamed_8499));
											float fragment_unnamed_9244 = mad(fragment_unnamed_9241, fragment_unnamed_8247, mad(fragment_unnamed_9237, fragment_unnamed_8244, fragment_unnamed_8241));
											float fragment_unnamed_9245 = fragment_unnamed_6016 * fragment_unnamed_9233;
											float fragment_unnamed_9246 = fragment_unnamed_6016 * fragment_unnamed_9236;
											float fragment_unnamed_9247 = fragment_unnamed_6016 * fragment_unnamed_8247;
											float fragment_unnamed_9248 = mad(fragment_unnamed_6016, fragment_unnamed_8247, fragment_unnamed_9244);
											float fragment_unnamed_9249 = mad(fragment_unnamed_6016, fragment_unnamed_9233, fragment_unnamed_9242);
											float fragment_unnamed_9250 = mad(fragment_unnamed_6016, fragment_unnamed_9236, fragment_unnamed_9243);
											float fragment_unnamed_9251 = mad(fragment_unnamed_6014, fragment_unnamed_8244, fragment_unnamed_9248);
											float fragment_unnamed_9252 = mad(fragment_unnamed_6014, fragment_unnamed_8500, fragment_unnamed_9249);
											float fragment_unnamed_9253 = mad(fragment_unnamed_6014, fragment_unnamed_8503, fragment_unnamed_9250);
											float fragment_unnamed_9254 = (-0.0f) - fragment_unnamed_6016;
											float fragment_unnamed_9255 = mad(fragment_unnamed_9254, fragment_unnamed_9233, fragment_unnamed_9252);
											float fragment_unnamed_9256 = mad(fragment_unnamed_9254, fragment_unnamed_9236, fragment_unnamed_9253);
											float fragment_unnamed_9257 = mad(fragment_unnamed_9254, fragment_unnamed_8247, fragment_unnamed_9251);
											float fragment_unnamed_9261 = rsqrt(dot(float3(fragment_unnamed_9242, fragment_unnamed_9243, fragment_unnamed_9244), float3(fragment_unnamed_9242, fragment_unnamed_9243, fragment_unnamed_9244)));
											float fragment_unnamed_9262 = fragment_unnamed_9261 * fragment_unnamed_9243;
											float fragment_unnamed_9263 = fragment_unnamed_9261 * fragment_unnamed_9244;
											float fragment_unnamed_9264 = fragment_unnamed_9261 * fragment_unnamed_9242;
											float fragment_unnamed_9268 = rsqrt(dot(float3(fragment_unnamed_9248, fragment_unnamed_9249, fragment_unnamed_9250), float3(fragment_unnamed_9248, fragment_unnamed_9249, fragment_unnamed_9250)));
											float fragment_unnamed_9269 = fragment_unnamed_9268 * fragment_unnamed_9248;
											float fragment_unnamed_9270 = fragment_unnamed_9268 * fragment_unnamed_9249;
											float fragment_unnamed_9271 = fragment_unnamed_9268 * fragment_unnamed_9250;
											float fragment_unnamed_9275 = rsqrt(dot(float3(fragment_unnamed_9251, fragment_unnamed_9252, fragment_unnamed_9253), float3(fragment_unnamed_9251, fragment_unnamed_9252, fragment_unnamed_9253)));
											float fragment_unnamed_9276 = fragment_unnamed_9275 * fragment_unnamed_9251;
											float fragment_unnamed_9277 = fragment_unnamed_9275 * fragment_unnamed_9252;
											float fragment_unnamed_9278 = fragment_unnamed_9275 * fragment_unnamed_9253;
											float fragment_unnamed_9282 = rsqrt(dot(float3(fragment_unnamed_9255, fragment_unnamed_9256, fragment_unnamed_9257), float3(fragment_unnamed_9255, fragment_unnamed_9256, fragment_unnamed_9257)));
											float fragment_unnamed_9283 = fragment_unnamed_9282 * fragment_unnamed_9257;
											float fragment_unnamed_9284 = fragment_unnamed_9282 * fragment_unnamed_9255;
											float fragment_unnamed_9285 = fragment_unnamed_9282 * fragment_unnamed_9256;
											float fragment_unnamed_9286 = dot(float3(fragment_unnamed_9263, fragment_unnamed_9264, fragment_unnamed_9262), float3(fragment_unnamed_9269, fragment_unnamed_9270, fragment_unnamed_9271));
											float fragment_unnamed_9323 = mad(abs(fragment_unnamed_9286), mad(abs(fragment_unnamed_9286), mad(abs(fragment_unnamed_9286), mad(abs(fragment_unnamed_9286), mad(abs(fragment_unnamed_9286), mad(abs(fragment_unnamed_9286), mad(abs(fragment_unnamed_9286), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9331 = asfloat((fragment_unnamed_9286 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9286, fragment_unnamed_9286, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9323)) : asuint(fragment_unnamed_9323));
											float fragment_unnamed_9332 = dot(float3(fragment_unnamed_9269, fragment_unnamed_9270, fragment_unnamed_9271), float3(fragment_unnamed_9276, fragment_unnamed_9277, fragment_unnamed_9278));
											float fragment_unnamed_9362 = mad(abs(fragment_unnamed_9332), mad(abs(fragment_unnamed_9332), mad(abs(fragment_unnamed_9332), mad(abs(fragment_unnamed_9332), mad(abs(fragment_unnamed_9332), mad(abs(fragment_unnamed_9332), mad(abs(fragment_unnamed_9332), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9369 = asfloat((fragment_unnamed_9332 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9332, fragment_unnamed_9332, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9362)) : asuint(fragment_unnamed_9362));
											float fragment_unnamed_9376 = dot(float3(fragment_unnamed_9276, fragment_unnamed_9277, fragment_unnamed_9278), float3(fragment_unnamed_9283, fragment_unnamed_9284, fragment_unnamed_9285));
											float fragment_unnamed_9406 = mad(abs(fragment_unnamed_9376), mad(abs(fragment_unnamed_9376), mad(abs(fragment_unnamed_9376), mad(abs(fragment_unnamed_9376), mad(abs(fragment_unnamed_9376), mad(abs(fragment_unnamed_9376), mad(abs(fragment_unnamed_9376), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9413 = asfloat((fragment_unnamed_9376 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9376, fragment_unnamed_9376, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9406)) : asuint(fragment_unnamed_9406));
											float fragment_unnamed_9417 = dot(float3(fragment_unnamed_9285, fragment_unnamed_9283, fragment_unnamed_9284), float3(fragment_unnamed_9262, fragment_unnamed_9263, fragment_unnamed_9264));
											float fragment_unnamed_9447 = mad(abs(fragment_unnamed_9417), mad(abs(fragment_unnamed_9417), mad(abs(fragment_unnamed_9417), mad(abs(fragment_unnamed_9417), mad(abs(fragment_unnamed_9417), mad(abs(fragment_unnamed_9417), mad(abs(fragment_unnamed_9417), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9454 = asfloat((fragment_unnamed_9417 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9417, fragment_unnamed_9417, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9447)) : asuint(fragment_unnamed_9447));
											float fragment_unnamed_9457 = mad(mad(fragment_unnamed_9284, fragment_unnamed_9262, (-0.0f) - (fragment_unnamed_9264 * fragment_unnamed_9285)), fragment_unnamed_9454, mad(mad(fragment_unnamed_9277, fragment_unnamed_9285, (-0.0f) - (fragment_unnamed_9278 * fragment_unnamed_9284)), fragment_unnamed_9413, mad(mad(fragment_unnamed_9264, fragment_unnamed_9271, (-0.0f) - (fragment_unnamed_9270 * fragment_unnamed_9262)), fragment_unnamed_9331, fragment_unnamed_9369 * mad(fragment_unnamed_9270, fragment_unnamed_9278, (-0.0f) - (fragment_unnamed_9271 * fragment_unnamed_9277)))));
											float fragment_unnamed_9458 = mad(mad(fragment_unnamed_9285, fragment_unnamed_9263, (-0.0f) - (fragment_unnamed_9262 * fragment_unnamed_9283)), fragment_unnamed_9454, mad(mad(fragment_unnamed_9278, fragment_unnamed_9283, (-0.0f) - (fragment_unnamed_9276 * fragment_unnamed_9285)), fragment_unnamed_9413, mad(mad(fragment_unnamed_9262, fragment_unnamed_9269, (-0.0f) - (fragment_unnamed_9271 * fragment_unnamed_9263)), fragment_unnamed_9331, fragment_unnamed_9369 * mad(fragment_unnamed_9271, fragment_unnamed_9276, (-0.0f) - (fragment_unnamed_9269 * fragment_unnamed_9278))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9459 = mad(mad(fragment_unnamed_9283, fragment_unnamed_9264, (-0.0f) - (fragment_unnamed_9263 * fragment_unnamed_9284)), fragment_unnamed_9454, mad(mad(fragment_unnamed_9276, fragment_unnamed_9284, (-0.0f) - (fragment_unnamed_9277 * fragment_unnamed_9283)), fragment_unnamed_9413, mad(mad(fragment_unnamed_9263, fragment_unnamed_9270, (-0.0f) - (fragment_unnamed_9269 * fragment_unnamed_9264)), fragment_unnamed_9331, fragment_unnamed_9369 * mad(fragment_unnamed_9269, fragment_unnamed_9277, (-0.0f) - (fragment_unnamed_9270 * fragment_unnamed_9276))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9460 = fragment_unnamed_9457 * 0.15915493667125701904296875f;
											float fragment_unnamed_9461 = dot(float3(fragment_unnamed_9458, fragment_unnamed_9459, fragment_unnamed_9460), float3(fragment_unnamed_9458, fragment_unnamed_9459, fragment_unnamed_9460));
											float fragment_unnamed_9745;
											float fragment_unnamed_9746;
											float fragment_unnamed_9747;
											if (fragment_unnamed_5939 != 0u)
											{
												float fragment_unnamed_9613 = ((-0.0f) - fragment_unnamed_9242) + fragment_unnamed_9255;
												float fragment_unnamed_9614 = ((-0.0f) - fragment_unnamed_9243) + fragment_unnamed_9256;
												float fragment_unnamed_9615 = ((-0.0f) - fragment_unnamed_9244) + fragment_unnamed_9257;
												float fragment_unnamed_9622 = mad(fragment_unnamed_9614, fragment_unnamed_9247, (-0.0f) - (fragment_unnamed_9246 * fragment_unnamed_9615));
												float fragment_unnamed_9623 = mad(fragment_unnamed_9615, fragment_unnamed_9245, (-0.0f) - (fragment_unnamed_9247 * fragment_unnamed_9613));
												float fragment_unnamed_9624 = mad(fragment_unnamed_9613, fragment_unnamed_9246, (-0.0f) - (fragment_unnamed_9245 * fragment_unnamed_9614));
												float fragment_unnamed_9628 = rsqrt(dot(float3(fragment_unnamed_9622, fragment_unnamed_9623, fragment_unnamed_9624), float3(fragment_unnamed_9622, fragment_unnamed_9623, fragment_unnamed_9624)));
												float fragment_unnamed_9629 = fragment_unnamed_9628 * fragment_unnamed_9622;
												float fragment_unnamed_9630 = fragment_unnamed_9628 * fragment_unnamed_9623;
												float fragment_unnamed_9631 = fragment_unnamed_9628 * fragment_unnamed_9624;
												float fragment_unnamed_9638 = dot(float3(fragment_unnamed_9242, fragment_unnamed_9243, fragment_unnamed_9244), float3(fragment_unnamed_9629, fragment_unnamed_9630, fragment_unnamed_9631)) / dot(float3(fragment_unnamed_9458, fragment_unnamed_9459, fragment_unnamed_9460), float3(fragment_unnamed_9629, fragment_unnamed_9630, fragment_unnamed_9631));
												float fragment_unnamed_9642 = mad(fragment_unnamed_9638, fragment_unnamed_9629, (-0.0f) - fragment_unnamed_9242);
												float fragment_unnamed_9643 = mad(fragment_unnamed_9638, fragment_unnamed_9630, (-0.0f) - fragment_unnamed_9243);
												float fragment_unnamed_9644 = mad(fragment_unnamed_9638, fragment_unnamed_9631, (-0.0f) - fragment_unnamed_9244);
												float fragment_unnamed_9648 = 1.0f / dot(float3(fragment_unnamed_9613, fragment_unnamed_9614, fragment_unnamed_9615), float3(fragment_unnamed_9613, fragment_unnamed_9614, fragment_unnamed_9615));
												float fragment_unnamed_9649 = dot(float3(fragment_unnamed_9245, fragment_unnamed_9246, fragment_unnamed_9247), float3(fragment_unnamed_9613, fragment_unnamed_9614, fragment_unnamed_9615));
												float fragment_unnamed_9658 = mad((-0.0f) - (fragment_unnamed_9613 * fragment_unnamed_9649), fragment_unnamed_9648, fragment_unnamed_9245);
												float fragment_unnamed_9659 = mad((-0.0f) - (fragment_unnamed_9614 * fragment_unnamed_9649), fragment_unnamed_9648, fragment_unnamed_9246);
												float fragment_unnamed_9660 = mad((-0.0f) - (fragment_unnamed_9615 * fragment_unnamed_9649), fragment_unnamed_9648, fragment_unnamed_9247);
												float fragment_unnamed_9667 = dot(float3(fragment_unnamed_9642, fragment_unnamed_9643, fragment_unnamed_9644), float3(fragment_unnamed_9658, fragment_unnamed_9659, fragment_unnamed_9660)) / dot(float3(fragment_unnamed_9658, fragment_unnamed_9659, fragment_unnamed_9660), float3(fragment_unnamed_9658, fragment_unnamed_9659, fragment_unnamed_9660));
												float fragment_unnamed_9681 = round(log2(fragment_unnamed_5982 * fragment_uniform_buffer_1[122u].x));
												float fragment_unnamed_9689 = min(fragment_unnamed_9681, max(mad(log2(mad(fragment_unnamed_9628 * (fragment_unnamed_9638 * fragment_unnamed_9638), 3.1415927410125732421875f, 9.9999999392252902907785028219223e-09f)), 0.5f, fragment_unnamed_9681), 0.0f));
												float fragment_unnamed_9703 = 1.0f / (fragment_unnamed_5982 + fragment_uniform_buffer_1[123u].y);
												float fragment_unnamed_9704 = 1.0f / (fragment_unnamed_5984 + fragment_uniform_buffer_1[123u].y);
												float fragment_unnamed_9714 = exp2(ceil(max(fragment_unnamed_9689 + ((-0.0f) - fragment_uniform_buffer_1[123u].z), 0.0f)));
												float fragment_unnamed_9718 = fragment_unnamed_5982 * fragment_uniform_buffer_1[123u].x;
												float fragment_unnamed_9719 = fragment_unnamed_5984 * fragment_uniform_buffer_1[123u].x;
												float fragment_unnamed_9722 = fragment_unnamed_9714 / (fragment_unnamed_9718 + fragment_unnamed_9718);
												float fragment_unnamed_9723 = fragment_unnamed_9714 / (fragment_unnamed_9719 + fragment_unnamed_9719);
												float4 fragment_unnamed_9737 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_9722) + 1.0f, max(fragment_unnamed_9722, mad(clamp(mad((-0.0f) - mad((-0.0f) - fragment_unnamed_9649, fragment_unnamed_9667, dot(float3(fragment_unnamed_9642, fragment_unnamed_9643, fragment_unnamed_9644), float3(fragment_unnamed_9613, fragment_unnamed_9614, fragment_unnamed_9615))), fragment_unnamed_9648, 1.0f), 0.0f, 1.0f), fragment_unnamed_5982 * fragment_unnamed_9703, mad((-0.0f) - fragment_unnamed_9703, fragment_unnamed_5982, 1.0f) * 0.5f))), fragment_unnamed_5982, fragment_unnamed_6000), mad(min(((-0.0f) - fragment_unnamed_9723) + 1.0f, max(fragment_unnamed_9723, mad(clamp(fragment_unnamed_9667, 0.0f, 1.0f), fragment_unnamed_5984 * fragment_unnamed_9704, mad((-0.0f) - fragment_unnamed_9704, fragment_unnamed_5984, 1.0f) * 0.5f))), fragment_unnamed_5984, fragment_unnamed_6002)), fragment_unnamed_9689);
												fragment_unnamed_9745 = fragment_unnamed_9737.x;
												fragment_unnamed_9746 = fragment_unnamed_9737.y;
												fragment_unnamed_9747 = fragment_unnamed_9737.z;
											}
											else
											{
												fragment_unnamed_9745 = asfloat(1065353216u);
												fragment_unnamed_9746 = asfloat(1065353216u);
												fragment_unnamed_9747 = asfloat(1065353216u);
											}
											fragment_unnamed_9573 = max(mad(fragment_unnamed_9457, 0.15915493667125701904296875f, fragment_unnamed_9461) / (sqrt(fragment_unnamed_9461) + 1.0f), 0.0f);
											fragment_unnamed_9574 = fragment_unnamed_9745;
											fragment_unnamed_9575 = fragment_unnamed_9746;
											fragment_unnamed_9576 = fragment_unnamed_9747;
										}
										else
										{
											float fragment_unnamed_9473 = fragment_unnamed_1144 * mad((-0.0f) - fragment_unnamed_1143, fragment_unnamed_7940, fragment_unnamed_7938);
											float fragment_unnamed_9474 = fragment_unnamed_3707 * fragment_unnamed_7939;
											float fragment_unnamed_9477 = fragment_unnamed_1144 * mad((-0.0f) - fragment_unnamed_1145, fragment_unnamed_7938, fragment_unnamed_1142 * fragment_unnamed_7940);
											float fragment_unnamed_9488 = (1.0f / fragment_unnamed_8244) * ((-0.0f) - fragment_unnamed_8241);
											bool fragment_unnamed_9489 = fragment_unnamed_8244 >= 0.0f;
											float fragment_unnamed_9504 = dot(float3(fragment_unnamed_8500, fragment_unnamed_8503, fragment_unnamed_8244), float3(fragment_unnamed_8500, fragment_unnamed_8503, fragment_unnamed_8244));
											float fragment_unnamed_9507 = rsqrt(fragment_unnamed_9504);
											float fragment_unnamed_9508 = fragment_unnamed_9504 * fragment_unnamed_9507;
											float fragment_unnamed_9509 = fragment_unnamed_9507 * fragment_unnamed_8500;
											float fragment_unnamed_9510 = fragment_unnamed_9507 * fragment_unnamed_8503;
											float fragment_unnamed_9511 = fragment_unnamed_9507 * fragment_unnamed_8244;
											float fragment_unnamed_9512 = dot(float3(fragment_unnamed_9509, fragment_unnamed_9510, fragment_unnamed_9511), float3(fragment_unnamed_8496, fragment_unnamed_8499, fragment_unnamed_8241));
											float fragment_unnamed_9515 = (-0.0f) - fragment_unnamed_9512;
											float fragment_unnamed_9516 = mad(fragment_unnamed_9515, fragment_unnamed_9509, fragment_unnamed_8496);
											float fragment_unnamed_9517 = mad(fragment_unnamed_9515, fragment_unnamed_9510, fragment_unnamed_8499);
											float fragment_unnamed_9518 = mad(fragment_unnamed_9515, fragment_unnamed_9511, fragment_unnamed_8241);
											float fragment_unnamed_9519 = dot(float3(fragment_unnamed_9516, fragment_unnamed_9517, fragment_unnamed_9518), float3(fragment_unnamed_9516, fragment_unnamed_9517, fragment_unnamed_9518));
											float fragment_unnamed_9522 = rsqrt(fragment_unnamed_9519);
											float fragment_unnamed_9524 = fragment_unnamed_9522 * fragment_unnamed_9518;
											float fragment_unnamed_9525 = mad(asfloat(fragment_unnamed_9489 ? asuint(max(fragment_unnamed_9488, fragment_unnamed_6031)) : asuint(min(fragment_unnamed_9488, fragment_unnamed_6031))), fragment_unnamed_9508, fragment_unnamed_9512);
											float fragment_unnamed_9526 = mad(asfloat(fragment_unnamed_9489 ? asuint(max(fragment_unnamed_9488, (-0.0f) - fragment_unnamed_6031)) : asuint(min(fragment_unnamed_9488, (-0.0f) - fragment_unnamed_6031))), fragment_unnamed_9508, fragment_unnamed_9512);
											float fragment_unnamed_9527 = mad(fragment_unnamed_9525, fragment_unnamed_9525, fragment_unnamed_9519);
											float fragment_unnamed_9528 = mad(fragment_unnamed_9526, fragment_unnamed_9526, fragment_unnamed_9519);
											float fragment_unnamed_9530 = rsqrt(fragment_unnamed_9527 * fragment_unnamed_9528);
											float fragment_unnamed_9531 = fragment_unnamed_9530 * fragment_unnamed_9530;
											float fragment_unnamed_9534 = (fragment_unnamed_9522 * fragment_unnamed_9519) * fragment_unnamed_9511;
											float fragment_unnamed_9544 = min(fragment_unnamed_9530 * mad(fragment_unnamed_9526, fragment_unnamed_9525, fragment_unnamed_9519), 1.0f);
											float fragment_unnamed_9548 = sqrt(((-0.0f) - abs(fragment_unnamed_9544)) + 1.0f);
											float fragment_unnamed_9554 = mad(mad(mad(abs(fragment_unnamed_9544), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_9544), -0.212114393711090087890625f), abs(fragment_unnamed_9544), 1.570728778839111328125f);
											fragment_unnamed_9573 = ((fragment_unnamed_7941 * (abs(fragment_unnamed_3708) * rsqrt(fragment_unnamed_7941 * dot(float3(fragment_unnamed_9473, fragment_unnamed_9474, fragment_unnamed_9477), float3(fragment_unnamed_9473, fragment_unnamed_9474, fragment_unnamed_9477))))) * max(mad(mad(fragment_unnamed_9554, fragment_unnamed_9548, asfloat(((fragment_unnamed_9544 < ((-0.0f) - fragment_unnamed_9544)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_9548 * fragment_unnamed_9554, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_9522 * fragment_unnamed_9524, mad(mad(fragment_unnamed_9524, fragment_unnamed_9525, (-0.0f) - fragment_unnamed_9534), fragment_unnamed_9528 * fragment_unnamed_9531, (-0.0f) - ((fragment_unnamed_9527 * fragment_unnamed_9531) * mad(fragment_unnamed_9524, fragment_unnamed_9526, (-0.0f) - fragment_unnamed_9534)))), 0.0f)) * 0.3183098733425140380859375f;
											fragment_unnamed_9574 = asfloat(1065353216u);
											fragment_unnamed_9575 = asfloat(1065353216u);
											fragment_unnamed_9576 = asfloat(1065353216u);
										}
										fragment_unnamed_8509 = fragment_unnamed_9573;
										fragment_unnamed_8511 = fragment_unnamed_9574;
										fragment_unnamed_8513 = fragment_unnamed_9575;
										fragment_unnamed_8515 = fragment_unnamed_9576;
									}
									else
									{
										fragment_unnamed_8509 = asfloat(0u);
										fragment_unnamed_8511 = asfloat(1065353216u);
										fragment_unnamed_8513 = asfloat(1065353216u);
										fragment_unnamed_8515 = asfloat(1065353216u);
									}
									fragment_unnamed_8508 = fragment_unnamed_8509;
									fragment_unnamed_8510 = fragment_unnamed_8511;
									fragment_unnamed_8512 = fragment_unnamed_8513;
									fragment_unnamed_8514 = fragment_unnamed_8515;
								}
								else
								{
									fragment_unnamed_8508 = asfloat(0u);
									fragment_unnamed_8510 = asfloat(1065353216u);
									fragment_unnamed_8512 = asfloat(1065353216u);
									fragment_unnamed_8514 = asfloat(1065353216u);
								}
								float fragment_unnamed_8518 = (asfloat(fragment_unnamed_7891.x) * fragment_unnamed_6074) * fragment_unnamed_8508;
								float fragment_unnamed_9760;
								float fragment_unnamed_9762;
								float fragment_unnamed_9764;
								float fragment_unnamed_9766;
								if (fragment_unnamed_7952 == 0u)
								{
									float fragment_unnamed_9577 = dot(float2(fragment_unnamed_3723, fragment_unnamed_1149), float2(fragment_unnamed_7905, fragment_unnamed_7896));
									float fragment_unnamed_9580 = dot(float2(fragment_unnamed_3723, fragment_unnamed_1149), float2(fragment_unnamed_7917, fragment_unnamed_7908));
									float fragment_unnamed_9583 = dot(float2(fragment_unnamed_1149, fragment_unnamed_3723), float2(fragment_unnamed_7920, fragment_unnamed_7929));
									float fragment_unnamed_9761;
									float fragment_unnamed_9763;
									float fragment_unnamed_9765;
									float fragment_unnamed_9767;
									if (0.0f < mad(fragment_unnamed_6032, abs(fragment_unnamed_9583), mad(fragment_unnamed_6031, abs(fragment_unnamed_9580), fragment_unnamed_9577)))
									{
										float fragment_unnamed_9748 = dot(float2(fragment_unnamed_1151, fragment_unnamed_1148), float2(fragment_unnamed_7905, fragment_unnamed_7896));
										float fragment_unnamed_9751 = fragment_unnamed_1150 * fragment_unnamed_7902;
										float fragment_unnamed_9752 = dot(float2(fragment_unnamed_1151, fragment_unnamed_1148), float2(fragment_unnamed_7917, fragment_unnamed_7908));
										float fragment_unnamed_9755 = fragment_unnamed_1150 * fragment_unnamed_7914;
										float fragment_unnamed_10109;
										float fragment_unnamed_10110;
										float fragment_unnamed_10111;
										float fragment_unnamed_10112;
										if (fragment_unnamed_6017)
										{
											float fragment_unnamed_9778 = dot(float2(fragment_unnamed_1148, fragment_unnamed_1151), float2(fragment_unnamed_7920, fragment_unnamed_7929));
											float fragment_unnamed_9781 = fragment_unnamed_7926 * fragment_unnamed_1150;
											float fragment_unnamed_9782 = (-0.0f) - fragment_unnamed_6031;
											float fragment_unnamed_9786 = (-0.0f) - fragment_unnamed_6032;
											float fragment_unnamed_9787 = mad(fragment_unnamed_9786, fragment_unnamed_9778, mad(fragment_unnamed_9782, fragment_unnamed_9752, fragment_unnamed_9748));
											float fragment_unnamed_9788 = mad(fragment_unnamed_9786, fragment_unnamed_9781, mad(fragment_unnamed_9782, fragment_unnamed_9755, fragment_unnamed_9751));
											float fragment_unnamed_9789 = mad(fragment_unnamed_9786, fragment_unnamed_9583, mad(fragment_unnamed_9782, fragment_unnamed_9580, fragment_unnamed_9577));
											float fragment_unnamed_9790 = fragment_unnamed_6016 * fragment_unnamed_9778;
											float fragment_unnamed_9791 = fragment_unnamed_6016 * fragment_unnamed_9781;
											float fragment_unnamed_9792 = fragment_unnamed_6016 * fragment_unnamed_9583;
											float fragment_unnamed_9793 = mad(fragment_unnamed_6016, fragment_unnamed_9583, fragment_unnamed_9789);
											float fragment_unnamed_9794 = mad(fragment_unnamed_6016, fragment_unnamed_9778, fragment_unnamed_9787);
											float fragment_unnamed_9795 = mad(fragment_unnamed_6016, fragment_unnamed_9781, fragment_unnamed_9788);
											float fragment_unnamed_9796 = mad(fragment_unnamed_6014, fragment_unnamed_9580, fragment_unnamed_9793);
											float fragment_unnamed_9797 = mad(fragment_unnamed_6014, fragment_unnamed_9752, fragment_unnamed_9794);
											float fragment_unnamed_9798 = mad(fragment_unnamed_6014, fragment_unnamed_9755, fragment_unnamed_9795);
											float fragment_unnamed_9799 = (-0.0f) - fragment_unnamed_6016;
											float fragment_unnamed_9800 = mad(fragment_unnamed_9799, fragment_unnamed_9778, fragment_unnamed_9797);
											float fragment_unnamed_9801 = mad(fragment_unnamed_9799, fragment_unnamed_9781, fragment_unnamed_9798);
											float fragment_unnamed_9802 = mad(fragment_unnamed_9799, fragment_unnamed_9583, fragment_unnamed_9796);
											float fragment_unnamed_9806 = rsqrt(dot(float3(fragment_unnamed_9787, fragment_unnamed_9788, fragment_unnamed_9789), float3(fragment_unnamed_9787, fragment_unnamed_9788, fragment_unnamed_9789)));
											float fragment_unnamed_9807 = fragment_unnamed_9806 * fragment_unnamed_9788;
											float fragment_unnamed_9808 = fragment_unnamed_9806 * fragment_unnamed_9789;
											float fragment_unnamed_9809 = fragment_unnamed_9806 * fragment_unnamed_9787;
											float fragment_unnamed_9813 = rsqrt(dot(float3(fragment_unnamed_9793, fragment_unnamed_9794, fragment_unnamed_9795), float3(fragment_unnamed_9793, fragment_unnamed_9794, fragment_unnamed_9795)));
											float fragment_unnamed_9814 = fragment_unnamed_9813 * fragment_unnamed_9793;
											float fragment_unnamed_9815 = fragment_unnamed_9813 * fragment_unnamed_9794;
											float fragment_unnamed_9816 = fragment_unnamed_9813 * fragment_unnamed_9795;
											float fragment_unnamed_9820 = rsqrt(dot(float3(fragment_unnamed_9796, fragment_unnamed_9797, fragment_unnamed_9798), float3(fragment_unnamed_9796, fragment_unnamed_9797, fragment_unnamed_9798)));
											float fragment_unnamed_9821 = fragment_unnamed_9820 * fragment_unnamed_9796;
											float fragment_unnamed_9822 = fragment_unnamed_9820 * fragment_unnamed_9797;
											float fragment_unnamed_9823 = fragment_unnamed_9820 * fragment_unnamed_9798;
											float fragment_unnamed_9827 = rsqrt(dot(float3(fragment_unnamed_9800, fragment_unnamed_9801, fragment_unnamed_9802), float3(fragment_unnamed_9800, fragment_unnamed_9801, fragment_unnamed_9802)));
											float fragment_unnamed_9828 = fragment_unnamed_9827 * fragment_unnamed_9802;
											float fragment_unnamed_9829 = fragment_unnamed_9827 * fragment_unnamed_9800;
											float fragment_unnamed_9830 = fragment_unnamed_9827 * fragment_unnamed_9801;
											float fragment_unnamed_9831 = dot(float3(fragment_unnamed_9808, fragment_unnamed_9809, fragment_unnamed_9807), float3(fragment_unnamed_9814, fragment_unnamed_9815, fragment_unnamed_9816));
											float fragment_unnamed_9861 = mad(abs(fragment_unnamed_9831), mad(abs(fragment_unnamed_9831), mad(abs(fragment_unnamed_9831), mad(abs(fragment_unnamed_9831), mad(abs(fragment_unnamed_9831), mad(abs(fragment_unnamed_9831), mad(abs(fragment_unnamed_9831), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9868 = asfloat((fragment_unnamed_9831 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9831, fragment_unnamed_9831, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9861)) : asuint(fragment_unnamed_9861));
											float fragment_unnamed_9869 = dot(float3(fragment_unnamed_9814, fragment_unnamed_9815, fragment_unnamed_9816), float3(fragment_unnamed_9821, fragment_unnamed_9822, fragment_unnamed_9823));
											float fragment_unnamed_9899 = mad(abs(fragment_unnamed_9869), mad(abs(fragment_unnamed_9869), mad(abs(fragment_unnamed_9869), mad(abs(fragment_unnamed_9869), mad(abs(fragment_unnamed_9869), mad(abs(fragment_unnamed_9869), mad(abs(fragment_unnamed_9869), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9906 = asfloat((fragment_unnamed_9869 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9869, fragment_unnamed_9869, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9899)) : asuint(fragment_unnamed_9899));
											float fragment_unnamed_9913 = dot(float3(fragment_unnamed_9821, fragment_unnamed_9822, fragment_unnamed_9823), float3(fragment_unnamed_9828, fragment_unnamed_9829, fragment_unnamed_9830));
											float fragment_unnamed_9943 = mad(abs(fragment_unnamed_9913), mad(abs(fragment_unnamed_9913), mad(abs(fragment_unnamed_9913), mad(abs(fragment_unnamed_9913), mad(abs(fragment_unnamed_9913), mad(abs(fragment_unnamed_9913), mad(abs(fragment_unnamed_9913), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9950 = asfloat((fragment_unnamed_9913 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9913, fragment_unnamed_9913, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9943)) : asuint(fragment_unnamed_9943));
											float fragment_unnamed_9954 = dot(float3(fragment_unnamed_9830, fragment_unnamed_9828, fragment_unnamed_9829), float3(fragment_unnamed_9807, fragment_unnamed_9808, fragment_unnamed_9809));
											float fragment_unnamed_9984 = mad(abs(fragment_unnamed_9954), mad(abs(fragment_unnamed_9954), mad(abs(fragment_unnamed_9954), mad(abs(fragment_unnamed_9954), mad(abs(fragment_unnamed_9954), mad(abs(fragment_unnamed_9954), mad(abs(fragment_unnamed_9954), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9991 = asfloat((fragment_unnamed_9954 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9954, fragment_unnamed_9954, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9984)) : asuint(fragment_unnamed_9984));
											float fragment_unnamed_9994 = mad(mad(fragment_unnamed_9829, fragment_unnamed_9807, (-0.0f) - (fragment_unnamed_9809 * fragment_unnamed_9830)), fragment_unnamed_9991, mad(mad(fragment_unnamed_9822, fragment_unnamed_9830, (-0.0f) - (fragment_unnamed_9823 * fragment_unnamed_9829)), fragment_unnamed_9950, mad(mad(fragment_unnamed_9809, fragment_unnamed_9816, (-0.0f) - (fragment_unnamed_9815 * fragment_unnamed_9807)), fragment_unnamed_9868, fragment_unnamed_9906 * mad(fragment_unnamed_9815, fragment_unnamed_9823, (-0.0f) - (fragment_unnamed_9816 * fragment_unnamed_9822)))));
											float fragment_unnamed_9995 = mad(mad(fragment_unnamed_9830, fragment_unnamed_9808, (-0.0f) - (fragment_unnamed_9807 * fragment_unnamed_9828)), fragment_unnamed_9991, mad(mad(fragment_unnamed_9823, fragment_unnamed_9828, (-0.0f) - (fragment_unnamed_9821 * fragment_unnamed_9830)), fragment_unnamed_9950, mad(mad(fragment_unnamed_9807, fragment_unnamed_9814, (-0.0f) - (fragment_unnamed_9816 * fragment_unnamed_9808)), fragment_unnamed_9868, fragment_unnamed_9906 * mad(fragment_unnamed_9816, fragment_unnamed_9821, (-0.0f) - (fragment_unnamed_9814 * fragment_unnamed_9823))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9996 = mad(mad(fragment_unnamed_9828, fragment_unnamed_9809, (-0.0f) - (fragment_unnamed_9808 * fragment_unnamed_9829)), fragment_unnamed_9991, mad(mad(fragment_unnamed_9821, fragment_unnamed_9829, (-0.0f) - (fragment_unnamed_9822 * fragment_unnamed_9828)), fragment_unnamed_9950, mad(mad(fragment_unnamed_9808, fragment_unnamed_9815, (-0.0f) - (fragment_unnamed_9814 * fragment_unnamed_9809)), fragment_unnamed_9868, fragment_unnamed_9906 * mad(fragment_unnamed_9814, fragment_unnamed_9822, (-0.0f) - (fragment_unnamed_9815 * fragment_unnamed_9821))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9997 = fragment_unnamed_9994 * 0.15915493667125701904296875f;
											float fragment_unnamed_9998 = dot(float3(fragment_unnamed_9995, fragment_unnamed_9996, fragment_unnamed_9997), float3(fragment_unnamed_9995, fragment_unnamed_9996, fragment_unnamed_9997));
											float fragment_unnamed_10249;
											float fragment_unnamed_10250;
											float fragment_unnamed_10251;
											if (fragment_unnamed_5939 != 0u)
											{
												float fragment_unnamed_10116 = ((-0.0f) - fragment_unnamed_9787) + fragment_unnamed_9800;
												float fragment_unnamed_10117 = ((-0.0f) - fragment_unnamed_9788) + fragment_unnamed_9801;
												float fragment_unnamed_10118 = ((-0.0f) - fragment_unnamed_9789) + fragment_unnamed_9802;
												float fragment_unnamed_10125 = mad(fragment_unnamed_10117, fragment_unnamed_9792, (-0.0f) - (fragment_unnamed_9791 * fragment_unnamed_10118));
												float fragment_unnamed_10126 = mad(fragment_unnamed_10118, fragment_unnamed_9790, (-0.0f) - (fragment_unnamed_9792 * fragment_unnamed_10116));
												float fragment_unnamed_10127 = mad(fragment_unnamed_10116, fragment_unnamed_9791, (-0.0f) - (fragment_unnamed_9790 * fragment_unnamed_10117));
												float fragment_unnamed_10131 = rsqrt(dot(float3(fragment_unnamed_10125, fragment_unnamed_10126, fragment_unnamed_10127), float3(fragment_unnamed_10125, fragment_unnamed_10126, fragment_unnamed_10127)));
												float fragment_unnamed_10132 = fragment_unnamed_10131 * fragment_unnamed_10125;
												float fragment_unnamed_10133 = fragment_unnamed_10131 * fragment_unnamed_10126;
												float fragment_unnamed_10134 = fragment_unnamed_10131 * fragment_unnamed_10127;
												float fragment_unnamed_10141 = dot(float3(fragment_unnamed_9787, fragment_unnamed_9788, fragment_unnamed_9789), float3(fragment_unnamed_10132, fragment_unnamed_10133, fragment_unnamed_10134)) / dot(float3(fragment_unnamed_9995, fragment_unnamed_9996, fragment_unnamed_9997), float3(fragment_unnamed_10132, fragment_unnamed_10133, fragment_unnamed_10134));
												float fragment_unnamed_10145 = mad(fragment_unnamed_10141, fragment_unnamed_10132, (-0.0f) - fragment_unnamed_9787);
												float fragment_unnamed_10146 = mad(fragment_unnamed_10141, fragment_unnamed_10133, (-0.0f) - fragment_unnamed_9788);
												float fragment_unnamed_10147 = mad(fragment_unnamed_10141, fragment_unnamed_10134, (-0.0f) - fragment_unnamed_9789);
												float fragment_unnamed_10151 = 1.0f / dot(float3(fragment_unnamed_10116, fragment_unnamed_10117, fragment_unnamed_10118), float3(fragment_unnamed_10116, fragment_unnamed_10117, fragment_unnamed_10118));
												float fragment_unnamed_10152 = dot(float3(fragment_unnamed_9790, fragment_unnamed_9791, fragment_unnamed_9792), float3(fragment_unnamed_10116, fragment_unnamed_10117, fragment_unnamed_10118));
												float fragment_unnamed_10161 = mad((-0.0f) - (fragment_unnamed_10116 * fragment_unnamed_10152), fragment_unnamed_10151, fragment_unnamed_9790);
												float fragment_unnamed_10162 = mad((-0.0f) - (fragment_unnamed_10117 * fragment_unnamed_10152), fragment_unnamed_10151, fragment_unnamed_9791);
												float fragment_unnamed_10163 = mad((-0.0f) - (fragment_unnamed_10118 * fragment_unnamed_10152), fragment_unnamed_10151, fragment_unnamed_9792);
												float fragment_unnamed_10170 = dot(float3(fragment_unnamed_10145, fragment_unnamed_10146, fragment_unnamed_10147), float3(fragment_unnamed_10161, fragment_unnamed_10162, fragment_unnamed_10163)) / dot(float3(fragment_unnamed_10161, fragment_unnamed_10162, fragment_unnamed_10163), float3(fragment_unnamed_10161, fragment_unnamed_10162, fragment_unnamed_10163));
												float fragment_unnamed_10183 = round(log2(fragment_unnamed_5982 * fragment_uniform_buffer_1[122u].x));
												float fragment_unnamed_10193 = min(mad(fragment_unnamed_3714, ((-0.0f) - fragment_unnamed_10183) + 3.0f, fragment_unnamed_10183), max(mad(log2(mad(fragment_unnamed_10131 * (fragment_unnamed_10141 * fragment_unnamed_10141), 3.1415927410125732421875f, 9.9999999392252902907785028219223e-09f)), 0.5f, fragment_unnamed_10183), 0.0f));
												float fragment_unnamed_10207 = 1.0f / (fragment_unnamed_5982 + fragment_uniform_buffer_1[123u].y);
												float fragment_unnamed_10208 = 1.0f / (fragment_unnamed_5984 + fragment_uniform_buffer_1[123u].y);
												float fragment_unnamed_10218 = exp2(ceil(max(fragment_unnamed_10193 + ((-0.0f) - fragment_uniform_buffer_1[123u].z), 0.0f)));
												float fragment_unnamed_10222 = fragment_unnamed_5982 * fragment_uniform_buffer_1[123u].x;
												float fragment_unnamed_10223 = fragment_unnamed_5984 * fragment_uniform_buffer_1[123u].x;
												float fragment_unnamed_10226 = fragment_unnamed_10218 / (fragment_unnamed_10222 + fragment_unnamed_10222);
												float fragment_unnamed_10227 = fragment_unnamed_10218 / (fragment_unnamed_10223 + fragment_unnamed_10223);
												float4 fragment_unnamed_10241 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_10226) + 1.0f, max(fragment_unnamed_10226, mad(clamp(mad((-0.0f) - mad((-0.0f) - fragment_unnamed_10152, fragment_unnamed_10170, dot(float3(fragment_unnamed_10145, fragment_unnamed_10146, fragment_unnamed_10147), float3(fragment_unnamed_10116, fragment_unnamed_10117, fragment_unnamed_10118))), fragment_unnamed_10151, 1.0f), 0.0f, 1.0f), fragment_unnamed_5982 * fragment_unnamed_10207, mad((-0.0f) - fragment_unnamed_10207, fragment_unnamed_5982, 1.0f) * 0.5f))), fragment_unnamed_5982, fragment_unnamed_6000), mad(min(((-0.0f) - fragment_unnamed_10227) + 1.0f, max(fragment_unnamed_10227, mad(clamp(fragment_unnamed_10170, 0.0f, 1.0f), fragment_unnamed_5984 * fragment_unnamed_10208, mad((-0.0f) - fragment_unnamed_10208, fragment_unnamed_5984, 1.0f) * 0.5f))), fragment_unnamed_5984, fragment_unnamed_6002)), fragment_unnamed_10193);
												fragment_unnamed_10249 = fragment_unnamed_10241.x;
												fragment_unnamed_10250 = fragment_unnamed_10241.y;
												fragment_unnamed_10251 = fragment_unnamed_10241.z;
											}
											else
											{
												fragment_unnamed_10249 = asfloat(1065353216u);
												fragment_unnamed_10250 = asfloat(1065353216u);
												fragment_unnamed_10251 = asfloat(1065353216u);
											}
											fragment_unnamed_10109 = max(mad(fragment_unnamed_9994, 0.15915493667125701904296875f, fragment_unnamed_9998) / (sqrt(fragment_unnamed_9998) + 1.0f), 0.0f);
											fragment_unnamed_10110 = fragment_unnamed_10249;
											fragment_unnamed_10111 = fragment_unnamed_10250;
											fragment_unnamed_10112 = fragment_unnamed_10251;
										}
										else
										{
											float fragment_unnamed_10010 = mad((-0.0f) - fragment_unnamed_1149, fragment_unnamed_7940, fragment_unnamed_7938) * fragment_unnamed_1150;
											float fragment_unnamed_10011 = fragment_unnamed_3716 * fragment_unnamed_7939;
											float fragment_unnamed_10014 = mad((-0.0f) - fragment_unnamed_1151, fragment_unnamed_7938, fragment_unnamed_1148 * fragment_unnamed_7940) * fragment_unnamed_1150;
											float fragment_unnamed_10025 = (1.0f / fragment_unnamed_9580) * ((-0.0f) - fragment_unnamed_9577);
											bool fragment_unnamed_10026 = fragment_unnamed_9580 >= 0.0f;
											float fragment_unnamed_10041 = dot(float3(fragment_unnamed_9752, fragment_unnamed_9755, fragment_unnamed_9580), float3(fragment_unnamed_9752, fragment_unnamed_9755, fragment_unnamed_9580));
											float fragment_unnamed_10044 = rsqrt(fragment_unnamed_10041);
											float fragment_unnamed_10045 = fragment_unnamed_10041 * fragment_unnamed_10044;
											float fragment_unnamed_10046 = fragment_unnamed_10044 * fragment_unnamed_9752;
											float fragment_unnamed_10047 = fragment_unnamed_10044 * fragment_unnamed_9755;
											float fragment_unnamed_10048 = fragment_unnamed_10044 * fragment_unnamed_9580;
											float fragment_unnamed_10049 = dot(float3(fragment_unnamed_10046, fragment_unnamed_10047, fragment_unnamed_10048), float3(fragment_unnamed_9748, fragment_unnamed_9751, fragment_unnamed_9577));
											float fragment_unnamed_10052 = (-0.0f) - fragment_unnamed_10049;
											float fragment_unnamed_10053 = mad(fragment_unnamed_10052, fragment_unnamed_10046, fragment_unnamed_9748);
											float fragment_unnamed_10054 = mad(fragment_unnamed_10052, fragment_unnamed_10047, fragment_unnamed_9751);
											float fragment_unnamed_10055 = mad(fragment_unnamed_10052, fragment_unnamed_10048, fragment_unnamed_9577);
											float fragment_unnamed_10056 = dot(float3(fragment_unnamed_10053, fragment_unnamed_10054, fragment_unnamed_10055), float3(fragment_unnamed_10053, fragment_unnamed_10054, fragment_unnamed_10055));
											float fragment_unnamed_10059 = rsqrt(fragment_unnamed_10056);
											float fragment_unnamed_10061 = fragment_unnamed_10059 * fragment_unnamed_10055;
											float fragment_unnamed_10062 = mad(asfloat(fragment_unnamed_10026 ? asuint(max(fragment_unnamed_10025, fragment_unnamed_6031)) : asuint(min(fragment_unnamed_10025, fragment_unnamed_6031))), fragment_unnamed_10045, fragment_unnamed_10049);
											float fragment_unnamed_10063 = mad(asfloat(fragment_unnamed_10026 ? asuint(max(fragment_unnamed_10025, (-0.0f) - fragment_unnamed_6031)) : asuint(min(fragment_unnamed_10025, (-0.0f) - fragment_unnamed_6031))), fragment_unnamed_10045, fragment_unnamed_10049);
											float fragment_unnamed_10064 = mad(fragment_unnamed_10062, fragment_unnamed_10062, fragment_unnamed_10056);
											float fragment_unnamed_10065 = mad(fragment_unnamed_10063, fragment_unnamed_10063, fragment_unnamed_10056);
											float fragment_unnamed_10067 = rsqrt(fragment_unnamed_10064 * fragment_unnamed_10065);
											float fragment_unnamed_10068 = fragment_unnamed_10067 * fragment_unnamed_10067;
											float fragment_unnamed_10071 = (fragment_unnamed_10056 * fragment_unnamed_10059) * fragment_unnamed_10048;
											float fragment_unnamed_10081 = min(fragment_unnamed_10067 * mad(fragment_unnamed_10063, fragment_unnamed_10062, fragment_unnamed_10056), 1.0f);
											float fragment_unnamed_10085 = sqrt(((-0.0f) - abs(fragment_unnamed_10081)) + 1.0f);
											float fragment_unnamed_10091 = mad(mad(mad(abs(fragment_unnamed_10081), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_10081), -0.212114393711090087890625f), abs(fragment_unnamed_10081), 1.570728778839111328125f);
											fragment_unnamed_10109 = ((fragment_unnamed_7941 * (abs(fragment_unnamed_3717) * rsqrt(fragment_unnamed_7941 * dot(float3(fragment_unnamed_10010, fragment_unnamed_10011, fragment_unnamed_10014), float3(fragment_unnamed_10010, fragment_unnamed_10011, fragment_unnamed_10014))))) * max(mad(mad(fragment_unnamed_10091, fragment_unnamed_10085, asfloat(((fragment_unnamed_10081 < ((-0.0f) - fragment_unnamed_10081)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_10085 * fragment_unnamed_10091, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_10059 * fragment_unnamed_10061, mad(mad(fragment_unnamed_10061, fragment_unnamed_10062, (-0.0f) - fragment_unnamed_10071), fragment_unnamed_10065 * fragment_unnamed_10068, (-0.0f) - ((fragment_unnamed_10064 * fragment_unnamed_10068) * mad(fragment_unnamed_10061, fragment_unnamed_10063, (-0.0f) - fragment_unnamed_10071)))), 0.0f)) * 0.3183098733425140380859375f;
											fragment_unnamed_10110 = asfloat(1065353216u);
											fragment_unnamed_10111 = asfloat(1065353216u);
											fragment_unnamed_10112 = asfloat(1065353216u);
										}
										fragment_unnamed_9761 = fragment_unnamed_10109;
										fragment_unnamed_9763 = fragment_unnamed_10110;
										fragment_unnamed_9765 = fragment_unnamed_10111;
										fragment_unnamed_9767 = fragment_unnamed_10112;
									}
									else
									{
										fragment_unnamed_9761 = asfloat(0u);
										fragment_unnamed_9763 = asfloat(1065353216u);
										fragment_unnamed_9765 = asfloat(1065353216u);
										fragment_unnamed_9767 = asfloat(1065353216u);
									}
									fragment_unnamed_9760 = fragment_unnamed_9761;
									fragment_unnamed_9762 = fragment_unnamed_9763;
									fragment_unnamed_9764 = fragment_unnamed_9765;
									fragment_unnamed_9766 = fragment_unnamed_9767;
								}
								else
								{
									fragment_unnamed_9760 = asfloat(0u);
									fragment_unnamed_9762 = asfloat(1065353216u);
									fragment_unnamed_9764 = asfloat(1065353216u);
									fragment_unnamed_9766 = asfloat(1065353216u);
								}
								float fragment_unnamed_9768 = (asfloat(fragment_unnamed_7891.y) * fragment_unnamed_6074) * fragment_unnamed_9760;
								fragment_unnamed_8259 = fragment_unnamed_7390 * (fragment_unnamed_9768 * (fragment_unnamed_1110 * fragment_unnamed_9762));
								fragment_unnamed_8261 = fragment_unnamed_7392 * (fragment_unnamed_9768 * (fragment_unnamed_1111 * fragment_unnamed_9764));
								fragment_unnamed_8263 = fragment_unnamed_7394 * (fragment_unnamed_9768 * (fragment_unnamed_1112 * fragment_unnamed_9766));
								fragment_unnamed_8265 = (fragment_unnamed_1034 * fragment_unnamed_7390) * (fragment_unnamed_8518 * fragment_unnamed_8510);
								fragment_unnamed_8267 = (fragment_unnamed_1034 * fragment_unnamed_7392) * (fragment_unnamed_8518 * fragment_unnamed_8512);
								fragment_unnamed_8269 = (fragment_unnamed_1034 * fragment_unnamed_7394) * (fragment_unnamed_8518 * fragment_unnamed_8514);
							}
							else
							{
								fragment_unnamed_8259 = asfloat(0u);
								fragment_unnamed_8261 = asfloat(0u);
								fragment_unnamed_8263 = asfloat(0u);
								fragment_unnamed_8265 = asfloat(0u);
								fragment_unnamed_8267 = asfloat(0u);
								fragment_unnamed_8269 = asfloat(0u);
							}
							fragment_unnamed_4323 = fragment_unnamed_4322 + fragment_unnamed_8267;
							fragment_unnamed_4325 = fragment_unnamed_4324 + fragment_unnamed_8269;
							fragment_unnamed_4327 = fragment_unnamed_4326 + fragment_unnamed_8259;
							fragment_unnamed_4329 = fragment_unnamed_4328 + fragment_unnamed_8261;
							fragment_unnamed_4331 = fragment_unnamed_4330 + fragment_unnamed_8263;
							fragment_unnamed_4335 = fragment_unnamed_4334 + fragment_unnamed_8265;
							fragment_unnamed_4322 = fragment_unnamed_4323;
							fragment_unnamed_4324 = fragment_unnamed_4325;
							fragment_unnamed_4326 = fragment_unnamed_4327;
							fragment_unnamed_4328 = fragment_unnamed_4329;
							fragment_unnamed_4330 = fragment_unnamed_4331;
							fragment_unnamed_4332 = fragment_unnamed_4333;
							fragment_unnamed_4334 = fragment_unnamed_4335;
							continue;
						}
					}
					if (ladder_phi_108)
					{
						break;
					}
					break;
				}
				float fragment_unnamed_4682 = mad(fragment_unnamed_425, fragment_uniform_buffer_4[2u].x * fragment_uniform_buffer_4[4u].x, mad(fragment_unnamed_1004, fragment_unnamed_4334, ((fragment_unnamed_996 * (fragment_unnamed_1034 * mad(fragment_unnamed_1046, mad((-0.0f) - fragment_unnamed_658, fragment_unnamed_1003, fragment_unnamed_1014), fragment_unnamed_1004))) * fragment_unnamed_1078) * max(mad(fragment_unnamed_1004, 2.755199909210205078125f, mad(fragment_unnamed_1004, -4.79510021209716796875f, mad(fragment_unnamed_1004, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f)));
				float fragment_unnamed_4683 = mad(fragment_unnamed_425, fragment_uniform_buffer_4[2u].y * fragment_uniform_buffer_4[4u].x, mad(fragment_unnamed_1005, fragment_unnamed_4322, ((fragment_unnamed_995 * (fragment_unnamed_1034 * mad(fragment_unnamed_1046, mad((-0.0f) - fragment_unnamed_660, fragment_unnamed_1003, fragment_unnamed_1016), fragment_unnamed_1005))) * fragment_unnamed_1078) * max(mad(fragment_unnamed_1005, 2.755199909210205078125f, mad(fragment_unnamed_1005, -4.79510021209716796875f, mad(fragment_unnamed_1005, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f)));
				float fragment_unnamed_4684 = mad(fragment_unnamed_425, fragment_uniform_buffer_4[2u].z * fragment_uniform_buffer_4[4u].x, mad(fragment_unnamed_1006, fragment_unnamed_4324, ((fragment_unnamed_994 * (fragment_unnamed_1034 * mad(fragment_unnamed_1046, mad((-0.0f) - fragment_unnamed_662, fragment_unnamed_1003, fragment_unnamed_1017), fragment_unnamed_1006))) * fragment_unnamed_1078) * max(mad(fragment_unnamed_1006, 2.755199909210205078125f, mad(fragment_unnamed_1006, -4.79510021209716796875f, mad(fragment_unnamed_1006, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f)));
				float fragment_unnamed_4700 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_1[118u].y;
				bool fragment_unnamed_4710 = fragment_uniform_buffer_4[12u].x == 0.0f;
				bool fragment_unnamed_4711 = fragment_uniform_buffer_4[12u].x == 1.0f;
				bool fragment_unnamed_4712 = fragment_uniform_buffer_4[12u].x == 4.0f;
				float fragment_unnamed_4722 = asfloat((0.0f != fragment_uniform_buffer_4[12u].y) ? 1065353216u : asuint(fragment_unnamed_428));
				float fragment_unnamed_4723 = (fragment_unnamed_4700 * (mad(fragment_unnamed_1080 * fragment_unnamed_3133, max(mad(fragment_unnamed_1014, 2.755199909210205078125f, mad(fragment_unnamed_1014, -4.79510021209716796875f, mad(fragment_unnamed_1014, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_4326) * mad(fragment_unnamed_1014, fragment_unnamed_1114, 1.0f))) * fragment_unnamed_4722;
				float fragment_unnamed_4724 = (fragment_unnamed_4700 * (mad(fragment_unnamed_1080 * fragment_unnamed_3135, max(mad(fragment_unnamed_1016, 2.755199909210205078125f, mad(fragment_unnamed_1016, -4.79510021209716796875f, mad(fragment_unnamed_1016, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_4328) * mad(fragment_unnamed_1016, fragment_unnamed_1114, 1.0f))) * fragment_unnamed_4722;
				float fragment_unnamed_4725 = (fragment_unnamed_4700 * (mad(fragment_unnamed_1080 * fragment_unnamed_3137, max(mad(fragment_unnamed_1017, 2.755199909210205078125f, mad(fragment_unnamed_1017, -4.79510021209716796875f, mad(fragment_unnamed_1017, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_4330) * mad(fragment_unnamed_1017, fragment_unnamed_1114, 1.0f))) * fragment_unnamed_4722;
				bool fragment_unnamed_4732 = ((fragment_unnamed_4711 ? 4294967295u : 0u) | (fragment_unnamed_4710 ? 4294967295u : 0u)) != 0u;
				uint fragment_unnamed_4739 = fragment_unnamed_4732 ? asuint(mad(fragment_unnamed_4700 * fragment_unnamed_4682, fragment_unnamed_428, fragment_unnamed_4723)) : asuint(mad(fragment_unnamed_4682, fragment_unnamed_4700, fragment_unnamed_4723));
				uint fragment_unnamed_4741 = fragment_unnamed_4732 ? asuint(mad(fragment_unnamed_4700 * fragment_unnamed_4683, fragment_unnamed_428, fragment_unnamed_4724)) : asuint(mad(fragment_unnamed_4683, fragment_unnamed_4700, fragment_unnamed_4724));
				uint fragment_unnamed_4743 = fragment_unnamed_4732 ? asuint(mad(fragment_unnamed_4700 * fragment_unnamed_4684, fragment_unnamed_428, fragment_unnamed_4725)) : asuint(mad(fragment_unnamed_4684, fragment_unnamed_4700, fragment_unnamed_4725));
				uint fragment_unnamed_5875;
				uint fragment_unnamed_5877;
				float fragment_unnamed_5879;
				float fragment_unnamed_5881;
				float fragment_unnamed_5883;
				if (asuint(fragment_uniform_buffer_1[211u]).y != 1u)
				{
					float fragment_unnamed_5340 = float(fragment_unnamed_278);
					float fragment_unnamed_5341 = float(fragment_unnamed_279);
					uint fragment_unnamed_5361 = min(T20.Load(1u).x, max(((-T20.Load(0u).x) + 4294967295u), uint(round(dot(float2(fragment_unnamed_5340, fragment_unnamed_5341), float2(fragment_uniform_buffer_1[103u].y * 1.0f, fragment_uniform_buffer_1[103u].x * (-1.0f))) + ((-0.0f) - fragment_uniform_buffer_1[102u].x)))));
					bool fragment_unnamed_5393 = ((((-0.0f) - float((T20.Load(fragment_unnamed_5361 + 2u).x & 65535u) + 4294967295u)) + floor(dot(float2(fragment_unnamed_5340, fragment_unnamed_5341), float2(fragment_uniform_buffer_1[103u].xy)) + ((-0.0f) - fragment_uniform_buffer_1[102u].z))) / (((-0.0f) - fragment_uniform_buffer_1[102u].z) + fragment_uniform_buffer_1[102u].w)) < 0.0f;
					uint fragment_unnamed_5394 = fragment_unnamed_5393 ? 4294967295u : 0u;
					float fragment_unnamed_5395 = asfloat(fragment_unnamed_5394);
					uint fragment_unnamed_5876;
					uint fragment_unnamed_5878;
					float fragment_unnamed_5880;
					float fragment_unnamed_5882;
					float fragment_unnamed_5884;
					if (asuint(fragment_uniform_buffer_1[113u]).x != 0u)
					{
						float4 fragment_unnamed_5828 = _RefractiveDepthBuffer.Load(int4(uint3(fragment_unnamed_278, fragment_unnamed_279, 0u), 0u));
						float fragment_unnamed_5830 = fragment_unnamed_5828.x;
						uint4 fragment_unnamed_5831 = _StencilTexture.Load(int4(uint3(fragment_unnamed_278, fragment_unnamed_279, 0u), 0u));
						uint fragment_unnamed_5833 = fragment_unnamed_5831.y;
						uint fragment_unnamed_5835 = fragment_unnamed_5833 & 32u;
						uint fragment_unnamed_5871 = ((fragment_unnamed_5833 & 1u) != 0u) ? 4294967295u : ((((((((fragment_unnamed_5835 != 0u) ? 4294967295u : 0u) & fragment_unnamed_5394) & ((fragment_unnamed_5830 >= gl_FragCoord.z) ? 4294967295u : 0u)) != 0u) ? 3.4028234663852885981170418348452e+38f : gl_FragCoord.z) < asfloat(fragment_unnamed_5393 ? 2139095039u : ((fragment_unnamed_5835 != 0u) ? asuint(fragment_unnamed_5830) : 0u))) ? (fragment_unnamed_5393 ? asuint(fragment_uniform_buffer_1[107u]).x : (uint(_WaterGBufferTexture3.Load(int4(uint3(fragment_unnamed_278, fragment_unnamed_279, 0u), 0u)).w * 255.0f) & 15u)) : 4294967295u);
						uint fragment_unnamed_6915;
						uint fragment_unnamed_6916;
						float fragment_unnamed_6917;
						float fragment_unnamed_6918;
						float fragment_unnamed_6919;
						if (fragment_unnamed_5871 == 4294967295u)
						{
							fragment_unnamed_6915 = 0u;
							fragment_unnamed_6916 = 0u;
							fragment_unnamed_6917 = asfloat(0u);
							fragment_unnamed_6918 = asfloat(0u);
							fragment_unnamed_6919 = asfloat(0u);
						}
						else
						{
							uint fragment_unnamed_7071;
							uint fragment_unnamed_7072;
							float fragment_unnamed_7073;
							if (fragment_unnamed_5394 == 0u)
							{
								uint fragment_unnamed_7075 = (fragment_unnamed_5871 * 28u) + 4u;
								uint3 fragment_unnamed_7084 = uint3(T22.Load(fragment_unnamed_7075).x, T22.Load(fragment_unnamed_7075 + 1u).x, T22.Load(fragment_unnamed_7075 + 2u).x);
								float fragment_unnamed_7097 = mad(fragment_unnamed_5340 * fragment_uniform_buffer_1[50u].z, 2.0f, -1.0f);
								float fragment_unnamed_7099 = (-0.0f) - mad(fragment_unnamed_5341 * fragment_uniform_buffer_1[50u].w, 2.0f, -1.0f);
								float fragment_unnamed_7139 = mad(fragment_uniform_buffer_1[30u].w, fragment_unnamed_5830, mad(fragment_uniform_buffer_1[28u].w, fragment_unnamed_7097, fragment_unnamed_7099 * fragment_uniform_buffer_1[29u].w)) + fragment_uniform_buffer_1[31u].w;
								float fragment_unnamed_7152 = ((-0.0f) - ((mad(fragment_uniform_buffer_1[30u].x, fragment_unnamed_5830, mad(fragment_uniform_buffer_1[28u].x, fragment_unnamed_7097, fragment_unnamed_7099 * fragment_uniform_buffer_1[29u].x)) + fragment_uniform_buffer_1[31u].x) / fragment_unnamed_7139)) + fragment_input_6.x;
								float fragment_unnamed_7153 = ((-0.0f) - ((mad(fragment_uniform_buffer_1[30u].y, fragment_unnamed_5830, mad(fragment_uniform_buffer_1[28u].y, fragment_unnamed_7097, fragment_unnamed_7099 * fragment_uniform_buffer_1[29u].y)) + fragment_uniform_buffer_1[31u].y) / fragment_unnamed_7139)) + fragment_input_6.y;
								float fragment_unnamed_7154 = ((-0.0f) - ((mad(fragment_uniform_buffer_1[30u].z, fragment_unnamed_5830, mad(fragment_uniform_buffer_1[28u].z, fragment_unnamed_7097, fragment_unnamed_7099 * fragment_uniform_buffer_1[29u].z)) + fragment_uniform_buffer_1[31u].z) / fragment_unnamed_7139)) + fragment_input_6.z;
								float fragment_unnamed_7158 = sqrt(dot(float3(fragment_unnamed_7152, fragment_unnamed_7153, fragment_unnamed_7154), float3(fragment_unnamed_7152, fragment_unnamed_7153, fragment_unnamed_7154)));
								float fragment_unnamed_7159 = fragment_unnamed_7158 + fragment_unnamed_7158;
								fragment_unnamed_7071 = asuint(((-0.0f) - exp2((asfloat(fragment_unnamed_7084.y) * fragment_unnamed_7159) * (-1.44269502162933349609375f))) + 1.0f);
								fragment_unnamed_7072 = asuint(((-0.0f) - exp2((asfloat(fragment_unnamed_7084.x) * fragment_unnamed_7159) * (-1.44269502162933349609375f))) + 1.0f);
								fragment_unnamed_7073 = ((-0.0f) - exp2((asfloat(fragment_unnamed_7084.z) * fragment_unnamed_7159) * (-1.44269502162933349609375f))) + 1.0f;
							}
							else
							{
								fragment_unnamed_7071 = 0u;
								fragment_unnamed_7072 = 0u;
								fragment_unnamed_7073 = asfloat(0u);
							}
							fragment_unnamed_6915 = fragment_unnamed_7071;
							fragment_unnamed_6916 = fragment_unnamed_7072;
							fragment_unnamed_6917 = asfloat(~fragment_unnamed_5394);
							fragment_unnamed_6918 = fragment_unnamed_5395;
							fragment_unnamed_6919 = fragment_unnamed_7073;
						}
						fragment_unnamed_5876 = fragment_unnamed_6915;
						fragment_unnamed_5878 = fragment_unnamed_6916;
						fragment_unnamed_5880 = fragment_unnamed_6917;
						fragment_unnamed_5882 = fragment_unnamed_6918;
						fragment_unnamed_5884 = fragment_unnamed_6919;
					}
					else
					{
						fragment_unnamed_5876 = 0u;
						fragment_unnamed_5878 = 0u;
						fragment_unnamed_5880 = asfloat(0u);
						fragment_unnamed_5882 = fragment_unnamed_5395;
						fragment_unnamed_5884 = asfloat(0u);
					}
					fragment_unnamed_5875 = fragment_unnamed_5876;
					fragment_unnamed_5877 = fragment_unnamed_5878;
					fragment_unnamed_5879 = fragment_unnamed_5880;
					fragment_unnamed_5881 = fragment_unnamed_5882;
					fragment_unnamed_5883 = fragment_unnamed_5884;
				}
				else
				{
					fragment_unnamed_5875 = 0u;
					fragment_unnamed_5877 = 0u;
					fragment_unnamed_5879 = asfloat(0u);
					fragment_unnamed_5881 = asfloat(0u);
					fragment_unnamed_5883 = asfloat(0u);
				}
				uint fragment_unnamed_7187;
				uint fragment_unnamed_7189;
				float fragment_unnamed_7191;
				float fragment_unnamed_7193;
				float fragment_unnamed_7195;
				float fragment_unnamed_7197;
				if (asuint(fragment_unnamed_5879) == 0u)
				{
					float fragment_unnamed_6926 = 1.0f / dot(float3(fragment_unnamed_1120, fragment_unnamed_1121, fragment_unnamed_1122), float3((-0.0f) - asfloat(fragment_unnamed_316), (-0.0f) - asfloat(fragment_unnamed_321), (-0.0f) - asfloat(fragment_unnamed_326)));
					float fragment_unnamed_6930 = fragment_unnamed_6926 * (1.0f / gl_FragCoord.w);
					uint fragment_unnamed_7569;
					float fragment_unnamed_7571;
					uint fragment_unnamed_7573;
					float fragment_unnamed_7574;
					float fragment_unnamed_7576;
					float fragment_unnamed_7578;
					float fragment_unnamed_7580;
					if (asuint(fragment_uniform_buffer_1[84u]).x != 0u)
					{
						float fragment_unnamed_7572;
						float fragment_unnamed_8149;
						float fragment_unnamed_8152;
						float fragment_unnamed_8154;
						float fragment_unnamed_8156;
						if (asuint(fragment_uniform_buffer_1[84u]).z != 0u)
						{
							float fragment_unnamed_7557 = mad((-0.0f) - fragment_uniform_buffer_1[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_1[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6926, (-0.0f) - fragment_uniform_buffer_1[94u].z), 0.0f)), fragment_uniform_buffer_1[94u].x));
							float fragment_unnamed_8301;
							float fragment_unnamed_8302;
							float fragment_unnamed_8303;
							float fragment_unnamed_8304;
							if (asuint(fragment_uniform_buffer_1[89u]).w == 0u)
							{
								float fragment_unnamed_7977 = fragment_unnamed_288 * fragment_uniform_buffer_1[91u].x;
								float fragment_unnamed_7978 = fragment_unnamed_289 * fragment_uniform_buffer_1[91u].y;
								float fragment_unnamed_7979 = floor(fragment_unnamed_7977);
								float fragment_unnamed_7980 = floor(fragment_unnamed_7978);
								float fragment_unnamed_7985 = ((-0.0f) - frac(fragment_unnamed_7977)) + 1.0f;
								float fragment_unnamed_7986 = ((-0.0f) - frac(fragment_unnamed_7978)) + 1.0f;
								float fragment_unnamed_7987 = fragment_unnamed_7986 * fragment_unnamed_7986;
								float fragment_unnamed_7988 = fragment_unnamed_7985 * fragment_unnamed_7985;
								float fragment_unnamed_7993 = mad(((-0.0f) - fragment_unnamed_7985) + 1.0f, fragment_unnamed_7985, 0.5f);
								float fragment_unnamed_7994 = mad(((-0.0f) - fragment_unnamed_7986) + 1.0f, fragment_unnamed_7986, 0.5f);
								float fragment_unnamed_8001 = ((-0.0f) - fragment_unnamed_7993) + mad((-0.0f) - fragment_unnamed_7988, 0.5f, 1.0f);
								float fragment_unnamed_8002 = ((-0.0f) - fragment_unnamed_7994) + mad((-0.0f) - fragment_unnamed_7987, 0.5f, 1.0f);
								float fragment_unnamed_8003 = fragment_unnamed_7993 * 0.5f;
								float fragment_unnamed_8004 = fragment_unnamed_7994 * 0.5f;
								float fragment_unnamed_8005 = mad(fragment_unnamed_7987, 0.5f, fragment_unnamed_8004);
								float fragment_unnamed_8006 = mad(fragment_unnamed_7988, 0.5f, fragment_unnamed_8003);
								float fragment_unnamed_8007 = mad(fragment_unnamed_7993, 0.5f, fragment_unnamed_8001);
								float fragment_unnamed_8008 = mad(fragment_unnamed_7994, 0.5f, fragment_unnamed_8002);
								float fragment_unnamed_8011 = mad(fragment_unnamed_8003, 1.0f / fragment_unnamed_8006, -0.5f);
								float fragment_unnamed_8012 = mad(fragment_unnamed_8004, 1.0f / fragment_unnamed_8005, -0.5f);
								float fragment_unnamed_8015 = mad(fragment_unnamed_8001, 1.0f / fragment_unnamed_8007, 0.5f);
								float fragment_unnamed_8016 = mad(fragment_unnamed_8002, 1.0f / fragment_unnamed_8008, 0.5f);
								float fragment_unnamed_8026 = fragment_uniform_buffer_1[91u].z * fragment_uniform_buffer_1[92u].x;
								float fragment_unnamed_8027 = fragment_uniform_buffer_1[91u].w * fragment_uniform_buffer_1[92u].y;
								float fragment_unnamed_8047 = fragment_unnamed_7557 * fragment_uniform_buffer_1[92u].z;
								float fragment_unnamed_8048 = fragment_unnamed_8005 * fragment_unnamed_8006;
								float4 fragment_unnamed_8059 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_8026 * (fragment_unnamed_7979 + fragment_unnamed_8011), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_8027 * (fragment_unnamed_7980 + fragment_unnamed_8012), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_8047, fragment_uniform_buffer_1[93u].z)), 0.0f);
								float fragment_unnamed_8065 = fragment_unnamed_8005 * fragment_unnamed_8007;
								float fragment_unnamed_8066 = fragment_unnamed_8006 * fragment_unnamed_8008;
								float4 fragment_unnamed_8075 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_8026 * (fragment_unnamed_7979 + fragment_unnamed_8015), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_8027 * (fragment_unnamed_7980 + fragment_unnamed_8012), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_8047, fragment_uniform_buffer_1[93u].z)), 0.0f);
								float4 fragment_unnamed_8097 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_8026 * (fragment_unnamed_7979 + fragment_unnamed_8011), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_8027 * (fragment_unnamed_7980 + fragment_unnamed_8016), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_8047, fragment_uniform_buffer_1[93u].z)), 0.0f);
								float fragment_unnamed_8107 = fragment_unnamed_8008 * fragment_unnamed_8007;
								float4 fragment_unnamed_8116 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_8026 * (fragment_unnamed_7979 + fragment_unnamed_8015), fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_8027 * (fragment_unnamed_7980 + fragment_unnamed_8016), fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_8047, fragment_uniform_buffer_1[93u].z)), 0.0f);
								fragment_unnamed_8301 = mad(fragment_unnamed_8107, fragment_unnamed_8116.w, mad(fragment_unnamed_8066, fragment_unnamed_8097.w, mad(fragment_unnamed_8048, fragment_unnamed_8059.w, fragment_unnamed_8065 * fragment_unnamed_8075.w)));
								fragment_unnamed_8302 = mad(fragment_unnamed_8107, fragment_unnamed_8116.z, mad(fragment_unnamed_8066, fragment_unnamed_8097.z, mad(fragment_unnamed_8048, fragment_unnamed_8059.z, fragment_unnamed_8065 * fragment_unnamed_8075.z)));
								fragment_unnamed_8303 = mad(fragment_unnamed_8107, fragment_unnamed_8116.y, mad(fragment_unnamed_8066, fragment_unnamed_8097.y, mad(fragment_unnamed_8048, fragment_unnamed_8059.y, fragment_unnamed_8065 * fragment_unnamed_8075.y)));
								fragment_unnamed_8304 = mad(fragment_unnamed_8107, fragment_unnamed_8116.x, mad(fragment_unnamed_8066, fragment_unnamed_8097.x, mad(fragment_unnamed_8048, fragment_unnamed_8059.x, fragment_unnamed_8065 * fragment_unnamed_8075.x)));
							}
							else
							{
								float4 fragment_unnamed_8143 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_288 * fragment_uniform_buffer_1[92u].x, fragment_uniform_buffer_1[93u].x), min(fragment_unnamed_289 * fragment_uniform_buffer_1[92u].y, fragment_uniform_buffer_1[93u].y), min(fragment_unnamed_7557 * fragment_uniform_buffer_1[92u].z, fragment_uniform_buffer_1[93u].z)), 0.0f);
								fragment_unnamed_8301 = fragment_unnamed_8143.w;
								fragment_unnamed_8302 = fragment_unnamed_8143.z;
								fragment_unnamed_8303 = fragment_unnamed_8143.y;
								fragment_unnamed_8304 = fragment_unnamed_8143.x;
							}
							float fragment_unnamed_8150 = ((-0.0f) - exp2(fragment_unnamed_8301 * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8313 = asfloat((fragment_unnamed_8150 >= 5.9604644775390625e-08f) ? asuint((1.0f / fragment_unnamed_8301) * fragment_unnamed_8150) : 1065353216u);
							fragment_unnamed_8149 = fragment_unnamed_8150;
							fragment_unnamed_7572 = asfloat(asuint(fragment_uniform_buffer_1[96u]).w);
							fragment_unnamed_8152 = fragment_unnamed_8302 * fragment_unnamed_8313;
							fragment_unnamed_8154 = fragment_unnamed_8303 * fragment_unnamed_8313;
							fragment_unnamed_8156 = fragment_unnamed_8304 * fragment_unnamed_8313;
						}
						else
						{
							fragment_unnamed_8149 = asfloat(0u);
							fragment_unnamed_7572 = asfloat(0u);
							fragment_unnamed_8152 = asfloat(0u);
							fragment_unnamed_8154 = asfloat(0u);
							fragment_unnamed_8156 = asfloat(0u);
						}
						float fragment_unnamed_8162 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_6926, (-0.0f) - fragment_unnamed_7572);
						float fragment_unnamed_7575;
						float fragment_unnamed_7577;
						float fragment_unnamed_7579;
						float fragment_unnamed_7581;
						if (((~asuint(fragment_unnamed_5881)) & ((0.0f < fragment_unnamed_8162) ? 4294967295u : 0u)) != 0u)
						{
							float fragment_unnamed_8323 = dot(float3(fragment_unnamed_341, fragment_unnamed_342, fragment_unnamed_343), float3(fragment_uniform_buffer_1[83u].xyz));
							float fragment_unnamed_8327 = fragment_unnamed_7572 * ((-0.0f) - fragment_unnamed_8323);
							float fragment_unnamed_8340 = max(abs(fragment_unnamed_8323), 0.001000000047497451305389404296875f);
							float fragment_unnamed_8341 = 1.0f / fragment_unnamed_8340;
							float fragment_unnamed_8344 = min(mad(fragment_unnamed_8162, (-0.0f) - fragment_unnamed_8323, fragment_unnamed_8327), fragment_unnamed_8327);
							float fragment_unnamed_8358 = min(fragment_unnamed_8162, max(fragment_unnamed_8341 * (((-0.0f) - fragment_unnamed_8344) + fragment_uniform_buffer_1[89u].y), 0.0f));
							float fragment_unnamed_8389 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_8340 * ((-0.0f) - (fragment_unnamed_8162 + ((-0.0f) - fragment_unnamed_8358)))) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_8344 + ((-0.0f) - fragment_uniform_buffer_1[89u].y), 0.0f)) * fragment_uniform_buffer_1[90u].x) * 1.44269502162933349609375f), fragment_unnamed_8341 * fragment_uniform_buffer_1[90u].y, fragment_unnamed_8358) * fragment_uniform_buffer_1[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_8391 = ((-0.0f) - fragment_unnamed_8149) + 1.0f;
							float fragment_unnamed_9595;
							float fragment_unnamed_9596;
							float fragment_unnamed_9597;
							if (fragment_uniform_buffer_1[86u].x == 1.0f)
							{
								float4 fragment_unnamed_8551 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_1120, fragment_unnamed_1121, fragment_unnamed_1122, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_1[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6926, (-0.0f) - fragment_uniform_buffer_1[87u].x) / (((-0.0f) - fragment_uniform_buffer_1[87u].x) + fragment_uniform_buffer_1[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_9595 = fragment_unnamed_8551.x * fragment_uniform_buffer_1[85u].x;
								fragment_unnamed_9596 = fragment_unnamed_8551.y * fragment_uniform_buffer_1[85u].y;
								fragment_unnamed_9597 = fragment_unnamed_8551.z * fragment_uniform_buffer_1[85u].z;
							}
							else
							{
								uint4 fragment_unnamed_8566 = asuint(fragment_uniform_buffer_1[85u]);
								fragment_unnamed_9595 = asfloat(fragment_unnamed_8566.x);
								fragment_unnamed_9596 = asfloat(fragment_unnamed_8566.y);
								fragment_unnamed_9597 = asfloat(fragment_unnamed_8566.z);
							}
							float fragment_unnamed_9608 = ((-0.0f) - fragment_unnamed_8389) + 1.0f;
							fragment_unnamed_7581 = mad((-0.0f) - fragment_unnamed_8391, fragment_unnamed_8389, 1.0f);
							fragment_unnamed_7575 = mad((fragment_uniform_buffer_1[88u].z / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_4700 * (fragment_unnamed_8391 * fragment_unnamed_9597)), fragment_unnamed_9608, fragment_unnamed_8152);
							fragment_unnamed_7577 = mad((fragment_uniform_buffer_1[88u].y / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_4700 * (fragment_unnamed_8391 * fragment_unnamed_9596)), fragment_unnamed_9608, fragment_unnamed_8154);
							fragment_unnamed_7579 = mad((fragment_uniform_buffer_1[88u].x / fragment_uniform_buffer_1[89u].x) * (fragment_unnamed_4700 * (fragment_unnamed_8391 * fragment_unnamed_9595)), fragment_unnamed_9608, fragment_unnamed_8156);
						}
						else
						{
							fragment_unnamed_7581 = fragment_unnamed_8149;
							fragment_unnamed_7575 = fragment_unnamed_8152;
							fragment_unnamed_7577 = fragment_unnamed_8154;
							fragment_unnamed_7579 = fragment_unnamed_8156;
						}
						uint fragment_unnamed_7570 = asuint(fragment_unnamed_7581);
						fragment_unnamed_7569 = fragment_unnamed_7570;
						fragment_unnamed_7571 = fragment_unnamed_7572;
						fragment_unnamed_7573 = fragment_unnamed_7570;
						fragment_unnamed_7574 = fragment_unnamed_7575;
						fragment_unnamed_7576 = fragment_unnamed_7577;
						fragment_unnamed_7578 = fragment_unnamed_7579;
						fragment_unnamed_7580 = fragment_unnamed_7581;
					}
					else
					{
						fragment_unnamed_7569 = fragment_unnamed_5875;
						fragment_unnamed_7571 = asfloat(0u);
						fragment_unnamed_7573 = fragment_unnamed_5877;
						fragment_unnamed_7574 = asfloat(0u);
						fragment_unnamed_7576 = asfloat(0u);
						fragment_unnamed_7578 = asfloat(0u);
						fragment_unnamed_7580 = fragment_unnamed_5883;
					}
					uint fragment_unnamed_8225;
					uint fragment_unnamed_8227;
					float fragment_unnamed_8229;
					float fragment_unnamed_8231;
					float fragment_unnamed_8233;
					float fragment_unnamed_8235;
					if (asuint(fragment_unnamed_5881) != 0u)
					{
						uint fragment_unnamed_8174 = (asuint(fragment_uniform_buffer_1[107u]).x * 28u) + 4u;
						uint4 fragment_unnamed_8186 = uint4(T22.Load(fragment_unnamed_8174).x, T22.Load(fragment_unnamed_8174 + 1u).x, T22.Load(fragment_unnamed_8174 + 2u).x, T22.Load(fragment_unnamed_8174 + 3u).x);
						float fragment_unnamed_8194 = asfloat(fragment_unnamed_8186.w);
						uint fragment_unnamed_8200 = (asuint(fragment_uniform_buffer_1[107u]).x * 28u) + 20u;
						uint3 fragment_unnamed_8209 = uint3(T22.Load(fragment_unnamed_8200).x, T22.Load(fragment_unnamed_8200 + 1u).x, T22.Load(fragment_unnamed_8200 + 2u).x);
						float fragment_unnamed_8211 = asfloat(fragment_unnamed_8209.x);
						float fragment_unnamed_8213 = asfloat(fragment_unnamed_8209.y);
						float fragment_unnamed_8215 = asfloat(fragment_unnamed_8209.z);
						float fragment_unnamed_8216 = fragment_unnamed_8194 * asfloat(fragment_unnamed_8186.x);
						float fragment_unnamed_8217 = fragment_unnamed_8194 * asfloat(fragment_unnamed_8186.y);
						float fragment_unnamed_8218 = fragment_unnamed_8194 * asfloat(fragment_unnamed_8186.z);
						float fragment_unnamed_8223 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_6926, (-0.0f) - fragment_unnamed_7571);
						float fragment_unnamed_8230;
						float fragment_unnamed_8232;
						float fragment_unnamed_8234;
						float fragment_unnamed_8573;
						float fragment_unnamed_8574;
						float fragment_unnamed_8575;
						if (0.0f < fragment_unnamed_8223)
						{
							uint fragment_unnamed_8405 = (asuint(fragment_uniform_buffer_1[107u]).x * 28u) + 16u;
							uint3 fragment_unnamed_8414 = uint3(T22.Load(fragment_unnamed_8405).x, T22.Load(fragment_unnamed_8405 + 1u).x, T22.Load(fragment_unnamed_8405 + 2u).x);
							float fragment_unnamed_8421 = dot(float3(fragment_unnamed_341, fragment_unnamed_342, fragment_unnamed_343), float3(fragment_unnamed_8211, fragment_unnamed_8213, fragment_unnamed_8215));
							float fragment_unnamed_8424 = fragment_unnamed_8223 * fragment_unnamed_8216;
							float fragment_unnamed_8425 = fragment_unnamed_8223 * fragment_unnamed_8217;
							float fragment_unnamed_8426 = fragment_unnamed_8223 * fragment_unnamed_8218;
							float fragment_unnamed_8435 = fragment_unnamed_4700 * (((-0.0f) - asfloat(fragment_unnamed_7573)) + 1.0f);
							float fragment_unnamed_8436 = fragment_unnamed_4700 * (((-0.0f) - asfloat(fragment_unnamed_7569)) + 1.0f);
							float fragment_unnamed_8437 = fragment_unnamed_4700 * (((-0.0f) - fragment_unnamed_7580) + 1.0f);
							bool fragment_unnamed_8439 = ((-0.0f) - fragment_unnamed_8421) != 1.0f;
							float fragment_unnamed_8441 = 1.0f / (fragment_unnamed_8421 + 1.0f);
							float fragment_unnamed_8445 = (-0.0f) - fragment_unnamed_8421;
							fragment_unnamed_8573 = fragment_unnamed_8424;
							fragment_unnamed_8574 = fragment_unnamed_8425;
							fragment_unnamed_8575 = fragment_unnamed_8426;
							fragment_unnamed_8230 = mad(asfloat(fragment_unnamed_8439 ? asuint(fragment_unnamed_8437 * (fragment_unnamed_8441 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_8426, fragment_unnamed_8445, fragment_unnamed_8426) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_8437)), asfloat(fragment_unnamed_8414.z), fragment_unnamed_7574);
							fragment_unnamed_8232 = mad(asfloat(fragment_unnamed_8439 ? asuint(fragment_unnamed_8436 * (fragment_unnamed_8441 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_8425, fragment_unnamed_8445, fragment_unnamed_8425) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_8436)), asfloat(fragment_unnamed_8414.y), fragment_unnamed_7576);
							fragment_unnamed_8234 = mad(asfloat(fragment_unnamed_8439 ? asuint(fragment_unnamed_8435 * (fragment_unnamed_8441 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_8424, fragment_unnamed_8445, fragment_unnamed_8424) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_8435)), asfloat(fragment_unnamed_8414.x), fragment_unnamed_7578);
						}
						else
						{
							fragment_unnamed_8573 = asfloat(0u);
							fragment_unnamed_8574 = asfloat(0u);
							fragment_unnamed_8575 = asfloat(0u);
							fragment_unnamed_8230 = fragment_unnamed_7574;
							fragment_unnamed_8232 = fragment_unnamed_7576;
							fragment_unnamed_8234 = fragment_unnamed_7578;
						}
						float fragment_unnamed_8591 = max(((-0.0f) - dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_unnamed_8211, fragment_unnamed_8213, fragment_unnamed_8215))) + ((-0.0f) - asfloat(T19.Load(0u).x)), 0.0f);
						fragment_unnamed_8225 = asuint(mad((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_7569)) + 1.0f), exp2(mad(fragment_unnamed_8591, fragment_unnamed_8217, fragment_unnamed_8574) * (-1.44269502162933349609375f)), 1.0f));
						fragment_unnamed_8227 = asuint(mad((-0.0f) - (((-0.0f) - asfloat(fragment_unnamed_7573)) + 1.0f), exp2(mad(fragment_unnamed_8591, fragment_unnamed_8216, fragment_unnamed_8573) * (-1.44269502162933349609375f)), 1.0f));
						fragment_unnamed_8229 = fragment_unnamed_8230;
						fragment_unnamed_8231 = fragment_unnamed_8232;
						fragment_unnamed_8233 = fragment_unnamed_8234;
						fragment_unnamed_8235 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_7580) + 1.0f), exp2(mad(fragment_unnamed_8591, fragment_unnamed_8218, fragment_unnamed_8575) * (-1.44269502162933349609375f)), 1.0f);
					}
					else
					{
						fragment_unnamed_8225 = fragment_unnamed_7569;
						fragment_unnamed_8227 = fragment_unnamed_7573;
						fragment_unnamed_8229 = fragment_unnamed_7574;
						fragment_unnamed_8231 = fragment_unnamed_7576;
						fragment_unnamed_8233 = fragment_unnamed_7578;
						fragment_unnamed_8235 = fragment_unnamed_7580;
					}
					uint fragment_unnamed_7188;
					uint fragment_unnamed_7190;
					float fragment_unnamed_7192;
					float fragment_unnamed_7194;
					float fragment_unnamed_7196;
					float fragment_unnamed_7198;
					if (asuint(fragment_unnamed_5881) == 0u)
					{
						uint fragment_unnamed_8490;
						uint fragment_unnamed_8491;
						float fragment_unnamed_8492;
						float fragment_unnamed_8493;
						float fragment_unnamed_8494;
						float fragment_unnamed_8495;
						if (asuint(fragment_uniform_buffer_1[84u]).y != 0u)
						{
							float fragment_unnamed_8620 = fragment_uniform_buffer_1[82u].w + fragment_uniform_buffer_1[83u].w;
							float fragment_unnamed_8626 = dot(float3(fragment_uniform_buffer_1[83u].xyz), float3(fragment_unnamed_1120, fragment_unnamed_1121, fragment_unnamed_1122));
							float fragment_unnamed_8629 = 1.0f / fragment_unnamed_8620;
							float fragment_unnamed_8633 = fragment_unnamed_8629 * fragment_uniform_buffer_1[82u].w;
							float fragment_unnamed_8637 = sqrt(max(mad((-0.0f) - fragment_unnamed_8633, fragment_unnamed_8633, 1.0f), 0.0f));
							float fragment_unnamed_8641 = fragment_unnamed_8629 * fragment_uniform_buffer_5[0u].x;
							float fragment_unnamed_8644 = max(mad((-0.0f) - fragment_unnamed_8626, fragment_unnamed_8626, 1.0f), 0.0f);
							float fragment_unnamed_8646 = mad(fragment_unnamed_8641, fragment_unnamed_8641, (-0.0f) - fragment_unnamed_8644);
							float4 fragment_unnamed_8671 = _AtmosphericScatteringLUT.SampleLevel(S0, float3(fragment_unnamed_288, fragment_unnamed_289, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6926, (-0.0f) - max(asfloat((fragment_unnamed_8646 < 0.0f) ? asuint(fragment_unnamed_8646) : asuint(fragment_unnamed_8620 * (((-0.0f) - fragment_unnamed_8626) + ((-0.0f) - sqrt(fragment_unnamed_8646))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
							float fragment_unnamed_8680 = (1.0f / fragment_unnamed_6930) * fragment_uniform_buffer_5[0u].x;
							float fragment_unnamed_8682 = mad(fragment_unnamed_8680, fragment_unnamed_8680, (-0.0f) - fragment_unnamed_8644);
							float fragment_unnamed_8696 = min(max(asfloat((fragment_unnamed_8682 < 0.0f) ? asuint(fragment_unnamed_8682) : asuint(fragment_unnamed_6930 * (((-0.0f) - fragment_unnamed_8626) + ((-0.0f) - sqrt(fragment_unnamed_8682))))), 0.0f) + 128000.0f, fragment_unnamed_6930);
							float fragment_unnamed_8713 = dot(float3((-0.0f) - fragment_uniform_buffer_1[82u].x, (-0.0f) - fragment_uniform_buffer_1[82u].y, (-0.0f) - fragment_uniform_buffer_1[82u].z), float3((-0.0f) - fragment_uniform_buffer_1[82u].x, (-0.0f) - fragment_uniform_buffer_1[82u].y, (-0.0f) - fragment_uniform_buffer_1[82u].z));
							float fragment_unnamed_8716 = rsqrt(fragment_unnamed_8713);
							float fragment_unnamed_8728 = sqrt(fragment_unnamed_8713);
							float fragment_unnamed_8729 = dot(float3(fragment_unnamed_8716 * ((-0.0f) - fragment_uniform_buffer_1[82u].x), fragment_unnamed_8716 * ((-0.0f) - fragment_uniform_buffer_1[82u].y), fragment_unnamed_8716 * ((-0.0f) - fragment_uniform_buffer_1[82u].z)), float3(fragment_unnamed_341, fragment_unnamed_342, fragment_unnamed_343));
							float fragment_unnamed_8740 = mad(fragment_unnamed_8696, fragment_unnamed_1120, (-0.0f) - fragment_uniform_buffer_1[82u].x);
							float fragment_unnamed_8741 = mad(fragment_unnamed_8696, fragment_unnamed_1121, (-0.0f) - fragment_uniform_buffer_1[82u].y);
							float fragment_unnamed_8742 = mad(fragment_unnamed_8696, fragment_unnamed_1122, (-0.0f) - fragment_uniform_buffer_1[82u].z);
							float fragment_unnamed_8746 = sqrt(dot(float3(fragment_unnamed_8740, fragment_unnamed_8741, fragment_unnamed_8742), float3(fragment_unnamed_8740, fragment_unnamed_8741, fragment_unnamed_8742)));
							float fragment_unnamed_8751 = dot(float3(fragment_unnamed_8740, fragment_unnamed_8741, fragment_unnamed_8742), float3(fragment_unnamed_1120, fragment_unnamed_1121, fragment_unnamed_1122)) * (1.0f / fragment_unnamed_8746);
							float fragment_unnamed_8754 = (fragment_unnamed_8751 >= 0.0f) ? ((-0.0f) - fragment_unnamed_8729) : fragment_unnamed_8729;
							float fragment_unnamed_8759 = fragment_unnamed_8728 * fragment_uniform_buffer_5[1u].x;
							float fragment_unnamed_8760 = fragment_unnamed_8728 * fragment_uniform_buffer_5[1u].z;
							float fragment_unnamed_8764 = sqrt(max(mad((-0.0f) - fragment_unnamed_8754, fragment_unnamed_8754, 1.0f), 0.0f));
							float fragment_unnamed_8769 = abs(fragment_unnamed_8754) * abs(fragment_unnamed_8754);
							float fragment_unnamed_8772 = (-0.0f) - fragment_unnamed_8769;
							float fragment_unnamed_8786 = abs(fragment_unnamed_8754);
							float fragment_unnamed_8793 = abs(fragment_unnamed_8754);
							float fragment_unnamed_8811 = exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].x, (-0.0f) - fragment_unnamed_8759) * 1.44269502162933349609375f) * mad(fragment_unnamed_8793, 0.5f, (1.0f / mad(fragment_unnamed_8786, fragment_unnamed_8759, sqrt(fragment_unnamed_8759 * mad(fragment_unnamed_8759 * fragment_unnamed_8769, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_8772, fragment_unnamed_8759, mad(fragment_unnamed_8759, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							float fragment_unnamed_8812 = exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].z, (-0.0f) - fragment_unnamed_8760) * 1.44269502162933349609375f) * mad(fragment_unnamed_8793, 0.5f, (1.0f / mad(fragment_unnamed_8786, fragment_unnamed_8760, sqrt(fragment_unnamed_8760 * mad(fragment_unnamed_8760 * fragment_unnamed_8769, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_8772, fragment_unnamed_8760, mad(fragment_unnamed_8760, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							bool fragment_unnamed_8813 = fragment_unnamed_8754 < 0.0f;
							float fragment_unnamed_8814 = fragment_unnamed_8764 * fragment_unnamed_8759;
							float fragment_unnamed_8815 = fragment_unnamed_8764 * fragment_unnamed_8760;
							float fragment_unnamed_8816 = rsqrt(fragment_unnamed_8814);
							float fragment_unnamed_8817 = rsqrt(fragment_unnamed_8815);
							float fragment_unnamed_8860 = fragment_unnamed_8746 * fragment_uniform_buffer_5[1u].x;
							float fragment_unnamed_8861 = fragment_unnamed_8746 * fragment_uniform_buffer_5[1u].z;
							float fragment_unnamed_8866 = abs(fragment_unnamed_8751) * abs(fragment_unnamed_8751);
							float fragment_unnamed_8869 = (-0.0f) - fragment_unnamed_8866;
							float fragment_unnamed_8880 = abs(fragment_unnamed_8751);
							float fragment_unnamed_8887 = abs(fragment_unnamed_8751);
							float fragment_unnamed_8915 = abs(mad((-0.0f) - mad(fragment_unnamed_8887, 0.5f, (mad(fragment_unnamed_8869, fragment_unnamed_8860, mad(fragment_unnamed_8860, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_8880, fragment_unnamed_8860, sqrt(fragment_unnamed_8860 * mad(fragment_unnamed_8860 * fragment_unnamed_8866, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].x, (-0.0f) - fragment_unnamed_8860) * 1.44269502162933349609375f), asfloat(fragment_unnamed_8813 ? asuint(mad((dot(fragment_unnamed_8814.xx, fragment_unnamed_8816.xx) + fragment_unnamed_8816) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].x, (-0.0f) - fragment_unnamed_8814) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_8811)) : asuint(fragment_unnamed_8811)))) * fragment_uniform_buffer_5[1u].y;
							float fragment_unnamed_8917 = 1.0f / fragment_unnamed_8728;
							float fragment_unnamed_8922 = fragment_unnamed_8917 * fragment_uniform_buffer_5[2u].z;
							float fragment_unnamed_8923 = fragment_unnamed_8917 * fragment_uniform_buffer_5[2u].w;
							float fragment_unnamed_8927 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_8729, fragment_unnamed_8729, 1.0f), 0.0f);
							float fragment_unnamed_8928 = mad(fragment_unnamed_8922, fragment_unnamed_8922, fragment_unnamed_8927);
							float fragment_unnamed_8929 = mad(fragment_unnamed_8923, fragment_unnamed_8923, fragment_unnamed_8927);
							bool fragment_unnamed_8930 = fragment_unnamed_8928 < 0.0f;
							bool fragment_unnamed_8931 = fragment_unnamed_8929 < 0.0f;
							float fragment_unnamed_8932 = sqrt(fragment_unnamed_8928);
							float fragment_unnamed_8933 = sqrt(fragment_unnamed_8929);
							uint fragment_unnamed_8944 = asuint(fragment_unnamed_8928);
							uint fragment_unnamed_8947 = fragment_unnamed_8930 ? fragment_unnamed_8944 : asuint(fragment_unnamed_8728 * (fragment_unnamed_8729 + ((-0.0f) - fragment_unnamed_8932)));
							float fragment_unnamed_8948 = asfloat(fragment_unnamed_8947);
							uint fragment_unnamed_8949 = fragment_unnamed_8930 ? fragment_unnamed_8944 : asuint(fragment_unnamed_8728 * (fragment_unnamed_8729 + fragment_unnamed_8932));
							float fragment_unnamed_8950 = asfloat(fragment_unnamed_8949);
							uint fragment_unnamed_8951 = asuint(fragment_unnamed_8929);
							uint fragment_unnamed_8956 = fragment_unnamed_8931 ? fragment_unnamed_8951 : asuint(fragment_unnamed_8728 * (fragment_unnamed_8729 + fragment_unnamed_8933));
							bool fragment_unnamed_8961 = fragment_unnamed_8948 >= 0.0f;
							float fragment_unnamed_8966 = ((-0.0f) - fragment_unnamed_8950) + asfloat(fragment_unnamed_8956);
							float fragment_unnamed_8969 = max(asfloat(fragment_unnamed_8931 ? fragment_unnamed_8951 : asuint(fragment_unnamed_8728 * (fragment_unnamed_8729 + ((-0.0f) - fragment_unnamed_8933)))), 0.0f);
							uint fragment_unnamed_8970 = fragment_unnamed_8961 ? fragment_unnamed_8947 : fragment_unnamed_8956;
							float fragment_unnamed_8976 = ((-0.0f) - fragment_unnamed_8969) + asfloat(fragment_unnamed_8970);
							bool fragment_unnamed_8979 = (((fragment_unnamed_8950 < fragment_unnamed_8696) ? 4294967295u : 0u) & (fragment_unnamed_8961 ? 4294967295u : 0u)) != 0u;
							bool fragment_unnamed_8985 = (((fragment_unnamed_8948 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_8950 >= 0.0f) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_8990 = asfloat(fragment_unnamed_8985 ? fragment_unnamed_8949 : asuint(fragment_unnamed_8969));
							float fragment_unnamed_8992 = asfloat(fragment_unnamed_8985 ? asuint(fragment_unnamed_8966 * 0.5f) : (fragment_unnamed_8979 ? fragment_unnamed_8949 : asuint(fragment_unnamed_8976 * 0.5f)));
							float fragment_unnamed_8994 = asfloat(fragment_unnamed_8985 ? asuint(fragment_unnamed_8966 * 0.5f) : (fragment_unnamed_8979 ? fragment_unnamed_8970 : asuint(fragment_unnamed_8976 * 0.5f)));
							float fragment_unnamed_8996 = asfloat(fragment_unnamed_8985 ? fragment_unnamed_8956 : (fragment_unnamed_8979 ? fragment_unnamed_8956 : fragment_unnamed_8970));
							float fragment_unnamed_9001 = (-0.0f) - fragment_unnamed_8990;
							float fragment_unnamed_9002 = (-0.0f) - fragment_unnamed_8992;
							float fragment_unnamed_9005 = fragment_unnamed_9001 + min(fragment_unnamed_8696, fragment_unnamed_8994);
							float fragment_unnamed_9006 = fragment_unnamed_9002 + min(fragment_unnamed_8696, fragment_unnamed_8996);
							float fragment_unnamed_9015 = mad(fragment_unnamed_9001 + min(fragment_unnamed_8696, fragment_unnamed_8994), 0.25f, fragment_unnamed_8990);
							float fragment_unnamed_9016 = mad(fragment_unnamed_9002 + min(fragment_unnamed_8696, fragment_unnamed_8996), 0.25f, fragment_unnamed_8992);
							float fragment_unnamed_9017 = mad(fragment_unnamed_9005, 0.75f, fragment_unnamed_8990);
							float fragment_unnamed_9019 = mad(fragment_unnamed_9006, 0.75f, fragment_unnamed_8992);
							float fragment_unnamed_9021 = dot(((-0.0f) - fragment_unnamed_8729).xx, fragment_unnamed_8728.xx);
							float fragment_unnamed_9039 = (-0.0f) - fragment_uniform_buffer_1[82u].w;
							float fragment_unnamed_9075 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_9019, fragment_unnamed_9019 + fragment_unnamed_9021, fragment_unnamed_8713)) + fragment_unnamed_9039, fragment_uniform_buffer_5[2u].x, fragment_uniform_buffer_5[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_9006, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_9017, fragment_unnamed_9017 + fragment_unnamed_9021, fragment_unnamed_8713)) + fragment_unnamed_9039, fragment_uniform_buffer_5[2u].x, fragment_uniform_buffer_5[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_9005, 0.0f) * 0.5f, ((max(fragment_unnamed_9006, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_9016, fragment_unnamed_9016 + fragment_unnamed_9021, fragment_unnamed_8713)) + fragment_unnamed_9039, fragment_uniform_buffer_5[2u].x, fragment_uniform_buffer_5[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_9005, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_9015, fragment_unnamed_9015 + fragment_unnamed_9021, fragment_unnamed_8713)) + fragment_unnamed_9039, fragment_uniform_buffer_5[2u].x, fragment_uniform_buffer_5[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
							float fragment_unnamed_9080 = (abs(mad((-0.0f) - mad(fragment_unnamed_8887, 0.5f, (mad(fragment_unnamed_8869, fragment_unnamed_8861, mad(fragment_unnamed_8861, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_8880, fragment_unnamed_8861, sqrt(fragment_unnamed_8861 * mad(fragment_unnamed_8861 * fragment_unnamed_8866, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].z, (-0.0f) - fragment_unnamed_8861) * 1.44269502162933349609375f), asfloat(fragment_unnamed_8813 ? asuint(mad((dot(fragment_unnamed_8815.xx, fragment_unnamed_8817.xx) + fragment_unnamed_8817) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_1[82u].w, fragment_uniform_buffer_5[1u].z, (-0.0f) - fragment_unnamed_8815) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_8812)) : asuint(fragment_unnamed_8812)))) * fragment_uniform_buffer_5[1u].w) * fragment_uniform_buffer_5[0u].w;
							float fragment_unnamed_9106 = ((-0.0f) - exp2(mad(fragment_unnamed_9075, fragment_uniform_buffer_5[6u].x, mad(fragment_unnamed_8915, fragment_uniform_buffer_5[3u].x, fragment_unnamed_9080)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_9107 = ((-0.0f) - exp2(mad(fragment_unnamed_9075, fragment_uniform_buffer_5[6u].y, mad(fragment_unnamed_8915, fragment_uniform_buffer_5[3u].y, fragment_unnamed_9080)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_9108 = ((-0.0f) - exp2(mad(fragment_unnamed_9075, fragment_uniform_buffer_5[6u].z, mad(fragment_unnamed_8915, fragment_uniform_buffer_5[3u].z, fragment_unnamed_9080)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_9110 = fragment_unnamed_9108 + (fragment_unnamed_9107 + fragment_unnamed_9106);
							float fragment_unnamed_9111 = fragment_unnamed_9110 * 0.3333333432674407958984375f;
							float fragment_unnamed_9113 = (-0.0f) - fragment_unnamed_9110;
							float fragment_unnamed_9131 = sqrt(((-0.0f) - fragment_unnamed_8637) + 1.0f);
							float fragment_unnamed_9137 = mad(mad(mad(fragment_unnamed_8637, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_8637, -0.212114393711090087890625f), fragment_unnamed_8637, 1.570728778839111328125f);
							float fragment_unnamed_9148 = mad(fragment_unnamed_9137, fragment_unnamed_9131, asfloat(asuint(mad(fragment_unnamed_9131 * fragment_unnamed_9137, -2.0f, 3.1415927410125732421875f)) & ((((-0.0f) - fragment_unnamed_8637) < fragment_unnamed_8637) ? 4294967295u : 0u)));
							float fragment_unnamed_9152 = sqrt(((-0.0f) - abs(fragment_unnamed_8626)) + 1.0f);
							float fragment_unnamed_9158 = mad(mad(mad(abs(fragment_unnamed_8626), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_8626), -0.212114393711090087890625f), abs(fragment_unnamed_8626), 1.570728778839111328125f);
							float fragment_unnamed_9169 = 1.0f / ((-0.0f) - fragment_unnamed_9148);
							float fragment_unnamed_9187 = mad(exp2((clamp(mad(mad(fragment_unnamed_9158, fragment_unnamed_9152, asfloat(((fragment_unnamed_8626 < ((-0.0f) - fragment_unnamed_8626)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_9152 * fragment_unnamed_9158, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_9169, (-0.0f) - (fragment_unnamed_9148 * fragment_unnamed_9169)), 0.0f, 1.0f) * fragment_uniform_buffer_5[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_5[11u].y, (-0.0f) - fragment_uniform_buffer_5[11u].y);
							float fragment_unnamed_9220 = ((-0.0f) - asfloat(fragment_unnamed_8227)) + 1.0f;
							float fragment_unnamed_9221 = ((-0.0f) - asfloat(fragment_unnamed_8225)) + 1.0f;
							float fragment_unnamed_9222 = ((-0.0f) - fragment_unnamed_8235) + 1.0f;
							fragment_unnamed_8490 = asuint(mad(fragment_unnamed_9221, mad(mad(fragment_unnamed_9113, 0.3333333432674407958984375f, fragment_unnamed_9107), fragment_uniform_buffer_5[10u].z, fragment_unnamed_9111) * fragment_uniform_buffer_5[10u].w, asfloat(fragment_unnamed_8225)));
							fragment_unnamed_8491 = asuint(mad(fragment_unnamed_9220, mad(mad(fragment_unnamed_9113, 0.3333333432674407958984375f, fragment_unnamed_9106), fragment_uniform_buffer_5[10u].z, fragment_unnamed_9111) * fragment_uniform_buffer_5[10u].w, asfloat(fragment_unnamed_8227)));
							fragment_unnamed_8492 = mad(fragment_unnamed_9222, mad(fragment_unnamed_9187, ((-0.0f) - fragment_uniform_buffer_5[8u].z) + fragment_uniform_buffer_5[9u].z, fragment_uniform_buffer_5[8u].z) * fragment_unnamed_8671.z, fragment_unnamed_8229);
							fragment_unnamed_8493 = mad(fragment_unnamed_9221, mad(fragment_unnamed_9187, ((-0.0f) - fragment_uniform_buffer_5[8u].y) + fragment_uniform_buffer_5[9u].y, fragment_uniform_buffer_5[8u].y) * fragment_unnamed_8671.y, fragment_unnamed_8231);
							fragment_unnamed_8494 = mad(fragment_unnamed_9220, mad(fragment_unnamed_9187, ((-0.0f) - fragment_uniform_buffer_5[8u].x) + fragment_uniform_buffer_5[9u].x, fragment_uniform_buffer_5[8u].x) * fragment_unnamed_8671.x, fragment_unnamed_8233);
							fragment_unnamed_8495 = mad(fragment_unnamed_9222, mad(mad(fragment_unnamed_9113, 0.3333333432674407958984375f, fragment_unnamed_9108), fragment_uniform_buffer_5[10u].z, fragment_unnamed_9111) * fragment_uniform_buffer_5[10u].w, fragment_unnamed_8235);
						}
						else
						{
							fragment_unnamed_8490 = fragment_unnamed_8225;
							fragment_unnamed_8491 = fragment_unnamed_8227;
							fragment_unnamed_8492 = fragment_unnamed_8229;
							fragment_unnamed_8493 = fragment_unnamed_8231;
							fragment_unnamed_8494 = fragment_unnamed_8233;
							fragment_unnamed_8495 = fragment_unnamed_8235;
						}
						fragment_unnamed_7188 = fragment_unnamed_8490;
						fragment_unnamed_7190 = fragment_unnamed_8491;
						fragment_unnamed_7192 = fragment_unnamed_8492;
						fragment_unnamed_7194 = fragment_unnamed_8493;
						fragment_unnamed_7196 = fragment_unnamed_8494;
						fragment_unnamed_7198 = fragment_unnamed_8495;
					}
					else
					{
						fragment_unnamed_7188 = fragment_unnamed_8225;
						fragment_unnamed_7190 = fragment_unnamed_8227;
						fragment_unnamed_7192 = fragment_unnamed_8229;
						fragment_unnamed_7194 = fragment_unnamed_8231;
						fragment_unnamed_7196 = fragment_unnamed_8233;
						fragment_unnamed_7198 = fragment_unnamed_8235;
					}
					fragment_unnamed_7187 = fragment_unnamed_7188;
					fragment_unnamed_7189 = fragment_unnamed_7190;
					fragment_unnamed_7191 = fragment_unnamed_7192;
					fragment_unnamed_7193 = fragment_unnamed_7194;
					fragment_unnamed_7195 = fragment_unnamed_7196;
					fragment_unnamed_7197 = fragment_unnamed_7198;
				}
				else
				{
					fragment_unnamed_7187 = fragment_unnamed_5875;
					fragment_unnamed_7189 = fragment_unnamed_5877;
					fragment_unnamed_7191 = asfloat(0u);
					fragment_unnamed_7193 = asfloat(0u);
					fragment_unnamed_7195 = asfloat(0u);
					fragment_unnamed_7197 = fragment_unnamed_5883;
				}
				float fragment_unnamed_7207 = asfloat(fragment_unnamed_4739) * (((-0.0f) - asfloat(fragment_unnamed_7189)) + 1.0f);
				float fragment_unnamed_7208 = asfloat(fragment_unnamed_4741) * (((-0.0f) - asfloat(fragment_unnamed_7187)) + 1.0f);
				float fragment_unnamed_7209 = asfloat(fragment_unnamed_4743) * (((-0.0f) - fragment_unnamed_7197) + 1.0f);
				float fragment_unnamed_7210 = mad(fragment_unnamed_7195, fragment_unnamed_428, fragment_unnamed_7207);
				float fragment_unnamed_7211 = mad(fragment_unnamed_7193, fragment_unnamed_428, fragment_unnamed_7208);
				float fragment_unnamed_7212 = mad(fragment_unnamed_7191, fragment_unnamed_428, fragment_unnamed_7209);
				fragment_output_0.x = fragment_unnamed_4710 ? fragment_unnamed_7210 : asfloat(fragment_unnamed_4711 ? asuint(fragment_unnamed_7207) : (fragment_unnamed_4712 ? asuint(fragment_unnamed_7210) : fragment_unnamed_4739));
				fragment_output_0.y = fragment_unnamed_4710 ? fragment_unnamed_7211 : asfloat(fragment_unnamed_4711 ? asuint(fragment_unnamed_7208) : (fragment_unnamed_4712 ? asuint(fragment_unnamed_7211) : fragment_unnamed_4741));
				fragment_output_0.z = fragment_unnamed_4710 ? fragment_unnamed_7212 : asfloat(fragment_unnamed_4711 ? asuint(fragment_unnamed_7209) : (fragment_unnamed_4712 ? asuint(fragment_unnamed_7212) : fragment_unnamed_4743));
				fragment_output_0.w = fragment_unnamed_428;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_GlobalFogDistance[0], _GlobalFogDistance[1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[128] = float4(fragment_uniform_buffer_1[128][0], fragment_uniform_buffer_1[128][1], fragment_uniform_buffer_1[128][2], asfloat(_EnableDecalLayers));

				fragment_uniform_buffer_1[210] = float4(_DecalAtlasResolution[0], _DecalAtlasResolution[1], fragment_uniform_buffer_1[210][2], fragment_uniform_buffer_1[210][3]);

				fragment_uniform_buffer_1[210] = float4(fragment_uniform_buffer_1[210][0], fragment_uniform_buffer_1[210][1], asfloat(_EnableDecals), fragment_uniform_buffer_1[210][3]);

				fragment_uniform_buffer_2[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[13] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_2[14] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_2[15] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_2[16] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				fragment_uniform_buffer_2[17] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				fragment_uniform_buffer_2[18] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				fragment_uniform_buffer_2[19] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				fragment_uniform_buffer_2[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_2[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_2[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_2[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_2[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_2[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_2[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_3[0] = float4(_PlanarCaptureVP[0][0][0], _PlanarCaptureVP[0][1][0], _PlanarCaptureVP[0][2][0], _PlanarCaptureVP[0][3][0]);
				fragment_uniform_buffer_3[1] = float4(_PlanarCaptureVP[0][0][1], _PlanarCaptureVP[0][1][1], _PlanarCaptureVP[0][2][1], _PlanarCaptureVP[0][3][1]);
				fragment_uniform_buffer_3[2] = float4(_PlanarCaptureVP[0][0][2], _PlanarCaptureVP[0][1][2], _PlanarCaptureVP[0][2][2], _PlanarCaptureVP[0][3][2]);
				fragment_uniform_buffer_3[3] = float4(_PlanarCaptureVP[0][0][3], _PlanarCaptureVP[0][1][3], _PlanarCaptureVP[0][2][3], _PlanarCaptureVP[0][3][3]);
				fragment_uniform_buffer_3[4] = float4(_PlanarCaptureVP[1][0][0], _PlanarCaptureVP[1][1][0], _PlanarCaptureVP[1][2][0], _PlanarCaptureVP[1][3][0]);
				fragment_uniform_buffer_3[5] = float4(_PlanarCaptureVP[1][0][1], _PlanarCaptureVP[1][1][1], _PlanarCaptureVP[1][2][1], _PlanarCaptureVP[1][3][1]);
				fragment_uniform_buffer_3[6] = float4(_PlanarCaptureVP[1][0][2], _PlanarCaptureVP[1][1][2], _PlanarCaptureVP[1][2][2], _PlanarCaptureVP[1][3][2]);
				fragment_uniform_buffer_3[7] = float4(_PlanarCaptureVP[1][0][3], _PlanarCaptureVP[1][1][3], _PlanarCaptureVP[1][2][3], _PlanarCaptureVP[1][3][3]);
				fragment_uniform_buffer_3[8] = float4(_PlanarCaptureVP[2][0][0], _PlanarCaptureVP[2][1][0], _PlanarCaptureVP[2][2][0], _PlanarCaptureVP[2][3][0]);
				fragment_uniform_buffer_3[9] = float4(_PlanarCaptureVP[2][0][1], _PlanarCaptureVP[2][1][1], _PlanarCaptureVP[2][2][1], _PlanarCaptureVP[2][3][1]);
				fragment_uniform_buffer_3[10] = float4(_PlanarCaptureVP[2][0][2], _PlanarCaptureVP[2][1][2], _PlanarCaptureVP[2][2][2], _PlanarCaptureVP[2][3][2]);
				fragment_uniform_buffer_3[11] = float4(_PlanarCaptureVP[2][0][3], _PlanarCaptureVP[2][1][3], _PlanarCaptureVP[2][2][3], _PlanarCaptureVP[2][3][3]);
				fragment_uniform_buffer_3[12] = float4(_PlanarCaptureVP[3][0][0], _PlanarCaptureVP[3][1][0], _PlanarCaptureVP[3][2][0], _PlanarCaptureVP[3][3][0]);
				fragment_uniform_buffer_3[13] = float4(_PlanarCaptureVP[3][0][1], _PlanarCaptureVP[3][1][1], _PlanarCaptureVP[3][2][1], _PlanarCaptureVP[3][3][1]);
				fragment_uniform_buffer_3[14] = float4(_PlanarCaptureVP[3][0][2], _PlanarCaptureVP[3][1][2], _PlanarCaptureVP[3][2][2], _PlanarCaptureVP[3][3][2]);
				fragment_uniform_buffer_3[15] = float4(_PlanarCaptureVP[3][0][3], _PlanarCaptureVP[3][1][3], _PlanarCaptureVP[3][2][3], _PlanarCaptureVP[3][3][3]);
				fragment_uniform_buffer_3[16] = float4(_PlanarCaptureVP[4][0][0], _PlanarCaptureVP[4][1][0], _PlanarCaptureVP[4][2][0], _PlanarCaptureVP[4][3][0]);
				fragment_uniform_buffer_3[17] = float4(_PlanarCaptureVP[4][0][1], _PlanarCaptureVP[4][1][1], _PlanarCaptureVP[4][2][1], _PlanarCaptureVP[4][3][1]);
				fragment_uniform_buffer_3[18] = float4(_PlanarCaptureVP[4][0][2], _PlanarCaptureVP[4][1][2], _PlanarCaptureVP[4][2][2], _PlanarCaptureVP[4][3][2]);
				fragment_uniform_buffer_3[19] = float4(_PlanarCaptureVP[4][0][3], _PlanarCaptureVP[4][1][3], _PlanarCaptureVP[4][2][3], _PlanarCaptureVP[4][3][3]);
				fragment_uniform_buffer_3[20] = float4(_PlanarCaptureVP[5][0][0], _PlanarCaptureVP[5][1][0], _PlanarCaptureVP[5][2][0], _PlanarCaptureVP[5][3][0]);
				fragment_uniform_buffer_3[21] = float4(_PlanarCaptureVP[5][0][1], _PlanarCaptureVP[5][1][1], _PlanarCaptureVP[5][2][1], _PlanarCaptureVP[5][3][1]);
				fragment_uniform_buffer_3[22] = float4(_PlanarCaptureVP[5][0][2], _PlanarCaptureVP[5][1][2], _PlanarCaptureVP[5][2][2], _PlanarCaptureVP[5][3][2]);
				fragment_uniform_buffer_3[23] = float4(_PlanarCaptureVP[5][0][3], _PlanarCaptureVP[5][1][3], _PlanarCaptureVP[5][2][3], _PlanarCaptureVP[5][3][3]);
				fragment_uniform_buffer_3[24] = float4(_PlanarCaptureVP[6][0][0], _PlanarCaptureVP[6][1][0], _PlanarCaptureVP[6][2][0], _PlanarCaptureVP[6][3][0]);
				fragment_uniform_buffer_3[25] = float4(_PlanarCaptureVP[6][0][1], _PlanarCaptureVP[6][1][1], _PlanarCaptureVP[6][2][1], _PlanarCaptureVP[6][3][1]);
				fragment_uniform_buffer_3[26] = float4(_PlanarCaptureVP[6][0][2], _PlanarCaptureVP[6][1][2], _PlanarCaptureVP[6][2][2], _PlanarCaptureVP[6][3][2]);
				fragment_uniform_buffer_3[27] = float4(_PlanarCaptureVP[6][0][3], _PlanarCaptureVP[6][1][3], _PlanarCaptureVP[6][2][3], _PlanarCaptureVP[6][3][3]);
				fragment_uniform_buffer_3[28] = float4(_PlanarCaptureVP[7][0][0], _PlanarCaptureVP[7][1][0], _PlanarCaptureVP[7][2][0], _PlanarCaptureVP[7][3][0]);
				fragment_uniform_buffer_3[29] = float4(_PlanarCaptureVP[7][0][1], _PlanarCaptureVP[7][1][1], _PlanarCaptureVP[7][2][1], _PlanarCaptureVP[7][3][1]);
				fragment_uniform_buffer_3[30] = float4(_PlanarCaptureVP[7][0][2], _PlanarCaptureVP[7][1][2], _PlanarCaptureVP[7][2][2], _PlanarCaptureVP[7][3][2]);
				fragment_uniform_buffer_3[31] = float4(_PlanarCaptureVP[7][0][3], _PlanarCaptureVP[7][1][3], _PlanarCaptureVP[7][2][3], _PlanarCaptureVP[7][3][3]);
				fragment_uniform_buffer_3[32] = float4(_PlanarCaptureVP[8][0][0], _PlanarCaptureVP[8][1][0], _PlanarCaptureVP[8][2][0], _PlanarCaptureVP[8][3][0]);
				fragment_uniform_buffer_3[33] = float4(_PlanarCaptureVP[8][0][1], _PlanarCaptureVP[8][1][1], _PlanarCaptureVP[8][2][1], _PlanarCaptureVP[8][3][1]);
				fragment_uniform_buffer_3[34] = float4(_PlanarCaptureVP[8][0][2], _PlanarCaptureVP[8][1][2], _PlanarCaptureVP[8][2][2], _PlanarCaptureVP[8][3][2]);
				fragment_uniform_buffer_3[35] = float4(_PlanarCaptureVP[8][0][3], _PlanarCaptureVP[8][1][3], _PlanarCaptureVP[8][2][3], _PlanarCaptureVP[8][3][3]);
				fragment_uniform_buffer_3[36] = float4(_PlanarCaptureVP[9][0][0], _PlanarCaptureVP[9][1][0], _PlanarCaptureVP[9][2][0], _PlanarCaptureVP[9][3][0]);
				fragment_uniform_buffer_3[37] = float4(_PlanarCaptureVP[9][0][1], _PlanarCaptureVP[9][1][1], _PlanarCaptureVP[9][2][1], _PlanarCaptureVP[9][3][1]);
				fragment_uniform_buffer_3[38] = float4(_PlanarCaptureVP[9][0][2], _PlanarCaptureVP[9][1][2], _PlanarCaptureVP[9][2][2], _PlanarCaptureVP[9][3][2]);
				fragment_uniform_buffer_3[39] = float4(_PlanarCaptureVP[9][0][3], _PlanarCaptureVP[9][1][3], _PlanarCaptureVP[9][2][3], _PlanarCaptureVP[9][3][3]);
				fragment_uniform_buffer_3[40] = float4(_PlanarCaptureVP[10][0][0], _PlanarCaptureVP[10][1][0], _PlanarCaptureVP[10][2][0], _PlanarCaptureVP[10][3][0]);
				fragment_uniform_buffer_3[41] = float4(_PlanarCaptureVP[10][0][1], _PlanarCaptureVP[10][1][1], _PlanarCaptureVP[10][2][1], _PlanarCaptureVP[10][3][1]);
				fragment_uniform_buffer_3[42] = float4(_PlanarCaptureVP[10][0][2], _PlanarCaptureVP[10][1][2], _PlanarCaptureVP[10][2][2], _PlanarCaptureVP[10][3][2]);
				fragment_uniform_buffer_3[43] = float4(_PlanarCaptureVP[10][0][3], _PlanarCaptureVP[10][1][3], _PlanarCaptureVP[10][2][3], _PlanarCaptureVP[10][3][3]);
				fragment_uniform_buffer_3[44] = float4(_PlanarCaptureVP[11][0][0], _PlanarCaptureVP[11][1][0], _PlanarCaptureVP[11][2][0], _PlanarCaptureVP[11][3][0]);
				fragment_uniform_buffer_3[45] = float4(_PlanarCaptureVP[11][0][1], _PlanarCaptureVP[11][1][1], _PlanarCaptureVP[11][2][1], _PlanarCaptureVP[11][3][1]);
				fragment_uniform_buffer_3[46] = float4(_PlanarCaptureVP[11][0][2], _PlanarCaptureVP[11][1][2], _PlanarCaptureVP[11][2][2], _PlanarCaptureVP[11][3][2]);
				fragment_uniform_buffer_3[47] = float4(_PlanarCaptureVP[11][0][3], _PlanarCaptureVP[11][1][3], _PlanarCaptureVP[11][2][3], _PlanarCaptureVP[11][3][3]);
				fragment_uniform_buffer_3[48] = float4(_PlanarCaptureVP[12][0][0], _PlanarCaptureVP[12][1][0], _PlanarCaptureVP[12][2][0], _PlanarCaptureVP[12][3][0]);
				fragment_uniform_buffer_3[49] = float4(_PlanarCaptureVP[12][0][1], _PlanarCaptureVP[12][1][1], _PlanarCaptureVP[12][2][1], _PlanarCaptureVP[12][3][1]);
				fragment_uniform_buffer_3[50] = float4(_PlanarCaptureVP[12][0][2], _PlanarCaptureVP[12][1][2], _PlanarCaptureVP[12][2][2], _PlanarCaptureVP[12][3][2]);
				fragment_uniform_buffer_3[51] = float4(_PlanarCaptureVP[12][0][3], _PlanarCaptureVP[12][1][3], _PlanarCaptureVP[12][2][3], _PlanarCaptureVP[12][3][3]);
				fragment_uniform_buffer_3[52] = float4(_PlanarCaptureVP[13][0][0], _PlanarCaptureVP[13][1][0], _PlanarCaptureVP[13][2][0], _PlanarCaptureVP[13][3][0]);
				fragment_uniform_buffer_3[53] = float4(_PlanarCaptureVP[13][0][1], _PlanarCaptureVP[13][1][1], _PlanarCaptureVP[13][2][1], _PlanarCaptureVP[13][3][1]);
				fragment_uniform_buffer_3[54] = float4(_PlanarCaptureVP[13][0][2], _PlanarCaptureVP[13][1][2], _PlanarCaptureVP[13][2][2], _PlanarCaptureVP[13][3][2]);
				fragment_uniform_buffer_3[55] = float4(_PlanarCaptureVP[13][0][3], _PlanarCaptureVP[13][1][3], _PlanarCaptureVP[13][2][3], _PlanarCaptureVP[13][3][3]);
				fragment_uniform_buffer_3[56] = float4(_PlanarCaptureVP[14][0][0], _PlanarCaptureVP[14][1][0], _PlanarCaptureVP[14][2][0], _PlanarCaptureVP[14][3][0]);
				fragment_uniform_buffer_3[57] = float4(_PlanarCaptureVP[14][0][1], _PlanarCaptureVP[14][1][1], _PlanarCaptureVP[14][2][1], _PlanarCaptureVP[14][3][1]);
				fragment_uniform_buffer_3[58] = float4(_PlanarCaptureVP[14][0][2], _PlanarCaptureVP[14][1][2], _PlanarCaptureVP[14][2][2], _PlanarCaptureVP[14][3][2]);
				fragment_uniform_buffer_3[59] = float4(_PlanarCaptureVP[14][0][3], _PlanarCaptureVP[14][1][3], _PlanarCaptureVP[14][2][3], _PlanarCaptureVP[14][3][3]);
				fragment_uniform_buffer_3[60] = float4(_PlanarCaptureVP[15][0][0], _PlanarCaptureVP[15][1][0], _PlanarCaptureVP[15][2][0], _PlanarCaptureVP[15][3][0]);
				fragment_uniform_buffer_3[61] = float4(_PlanarCaptureVP[15][0][1], _PlanarCaptureVP[15][1][1], _PlanarCaptureVP[15][2][1], _PlanarCaptureVP[15][3][1]);
				fragment_uniform_buffer_3[62] = float4(_PlanarCaptureVP[15][0][2], _PlanarCaptureVP[15][1][2], _PlanarCaptureVP[15][2][2], _PlanarCaptureVP[15][3][2]);
				fragment_uniform_buffer_3[63] = float4(_PlanarCaptureVP[15][0][3], _PlanarCaptureVP[15][1][3], _PlanarCaptureVP[15][2][3], _PlanarCaptureVP[15][3][3]);

				fragment_uniform_buffer_3[64] = float4(_PlanarScaleOffset[0][0], _PlanarScaleOffset[0][1], _PlanarScaleOffset[0][2], _PlanarScaleOffset[0][3]);
				fragment_uniform_buffer_3[65] = float4(_PlanarScaleOffset[1][0], _PlanarScaleOffset[1][1], _PlanarScaleOffset[1][2], _PlanarScaleOffset[1][3]);
				fragment_uniform_buffer_3[66] = float4(_PlanarScaleOffset[2][0], _PlanarScaleOffset[2][1], _PlanarScaleOffset[2][2], _PlanarScaleOffset[2][3]);
				fragment_uniform_buffer_3[67] = float4(_PlanarScaleOffset[3][0], _PlanarScaleOffset[3][1], _PlanarScaleOffset[3][2], _PlanarScaleOffset[3][3]);
				fragment_uniform_buffer_3[68] = float4(_PlanarScaleOffset[4][0], _PlanarScaleOffset[4][1], _PlanarScaleOffset[4][2], _PlanarScaleOffset[4][3]);
				fragment_uniform_buffer_3[69] = float4(_PlanarScaleOffset[5][0], _PlanarScaleOffset[5][1], _PlanarScaleOffset[5][2], _PlanarScaleOffset[5][3]);
				fragment_uniform_buffer_3[70] = float4(_PlanarScaleOffset[6][0], _PlanarScaleOffset[6][1], _PlanarScaleOffset[6][2], _PlanarScaleOffset[6][3]);
				fragment_uniform_buffer_3[71] = float4(_PlanarScaleOffset[7][0], _PlanarScaleOffset[7][1], _PlanarScaleOffset[7][2], _PlanarScaleOffset[7][3]);
				fragment_uniform_buffer_3[72] = float4(_PlanarScaleOffset[8][0], _PlanarScaleOffset[8][1], _PlanarScaleOffset[8][2], _PlanarScaleOffset[8][3]);
				fragment_uniform_buffer_3[73] = float4(_PlanarScaleOffset[9][0], _PlanarScaleOffset[9][1], _PlanarScaleOffset[9][2], _PlanarScaleOffset[9][3]);
				fragment_uniform_buffer_3[74] = float4(_PlanarScaleOffset[10][0], _PlanarScaleOffset[10][1], _PlanarScaleOffset[10][2], _PlanarScaleOffset[10][3]);
				fragment_uniform_buffer_3[75] = float4(_PlanarScaleOffset[11][0], _PlanarScaleOffset[11][1], _PlanarScaleOffset[11][2], _PlanarScaleOffset[11][3]);
				fragment_uniform_buffer_3[76] = float4(_PlanarScaleOffset[12][0], _PlanarScaleOffset[12][1], _PlanarScaleOffset[12][2], _PlanarScaleOffset[12][3]);
				fragment_uniform_buffer_3[77] = float4(_PlanarScaleOffset[13][0], _PlanarScaleOffset[13][1], _PlanarScaleOffset[13][2], _PlanarScaleOffset[13][3]);
				fragment_uniform_buffer_3[78] = float4(_PlanarScaleOffset[14][0], _PlanarScaleOffset[14][1], _PlanarScaleOffset[14][2], _PlanarScaleOffset[14][3]);
				fragment_uniform_buffer_3[79] = float4(_PlanarScaleOffset[15][0], _PlanarScaleOffset[15][1], _PlanarScaleOffset[15][2], _PlanarScaleOffset[15][3]);

				fragment_uniform_buffer_3[80] = float4(_CubeScaleOffset[0][0], _CubeScaleOffset[0][1], _CubeScaleOffset[0][2], _CubeScaleOffset[0][3]);
				fragment_uniform_buffer_3[81] = float4(_CubeScaleOffset[1][0], _CubeScaleOffset[1][1], _CubeScaleOffset[1][2], _CubeScaleOffset[1][3]);
				fragment_uniform_buffer_3[82] = float4(_CubeScaleOffset[2][0], _CubeScaleOffset[2][1], _CubeScaleOffset[2][2], _CubeScaleOffset[2][3]);
				fragment_uniform_buffer_3[83] = float4(_CubeScaleOffset[3][0], _CubeScaleOffset[3][1], _CubeScaleOffset[3][2], _CubeScaleOffset[3][3]);
				fragment_uniform_buffer_3[84] = float4(_CubeScaleOffset[4][0], _CubeScaleOffset[4][1], _CubeScaleOffset[4][2], _CubeScaleOffset[4][3]);
				fragment_uniform_buffer_3[85] = float4(_CubeScaleOffset[5][0], _CubeScaleOffset[5][1], _CubeScaleOffset[5][2], _CubeScaleOffset[5][3]);
				fragment_uniform_buffer_3[86] = float4(_CubeScaleOffset[6][0], _CubeScaleOffset[6][1], _CubeScaleOffset[6][2], _CubeScaleOffset[6][3]);
				fragment_uniform_buffer_3[87] = float4(_CubeScaleOffset[7][0], _CubeScaleOffset[7][1], _CubeScaleOffset[7][2], _CubeScaleOffset[7][3]);
				fragment_uniform_buffer_3[88] = float4(_CubeScaleOffset[8][0], _CubeScaleOffset[8][1], _CubeScaleOffset[8][2], _CubeScaleOffset[8][3]);
				fragment_uniform_buffer_3[89] = float4(_CubeScaleOffset[9][0], _CubeScaleOffset[9][1], _CubeScaleOffset[9][2], _CubeScaleOffset[9][3]);
				fragment_uniform_buffer_3[90] = float4(_CubeScaleOffset[10][0], _CubeScaleOffset[10][1], _CubeScaleOffset[10][2], _CubeScaleOffset[10][3]);
				fragment_uniform_buffer_3[91] = float4(_CubeScaleOffset[11][0], _CubeScaleOffset[11][1], _CubeScaleOffset[11][2], _CubeScaleOffset[11][3]);
				fragment_uniform_buffer_3[92] = float4(_CubeScaleOffset[12][0], _CubeScaleOffset[12][1], _CubeScaleOffset[12][2], _CubeScaleOffset[12][3]);
				fragment_uniform_buffer_3[93] = float4(_CubeScaleOffset[13][0], _CubeScaleOffset[13][1], _CubeScaleOffset[13][2], _CubeScaleOffset[13][3]);
				fragment_uniform_buffer_3[94] = float4(_CubeScaleOffset[14][0], _CubeScaleOffset[14][1], _CubeScaleOffset[14][2], _CubeScaleOffset[14][3]);
				fragment_uniform_buffer_3[95] = float4(_CubeScaleOffset[15][0], _CubeScaleOffset[15][1], _CubeScaleOffset[15][2], _CubeScaleOffset[15][3]);
				fragment_uniform_buffer_3[96] = float4(_CubeScaleOffset[16][0], _CubeScaleOffset[16][1], _CubeScaleOffset[16][2], _CubeScaleOffset[16][3]);
				fragment_uniform_buffer_3[97] = float4(_CubeScaleOffset[17][0], _CubeScaleOffset[17][1], _CubeScaleOffset[17][2], _CubeScaleOffset[17][3]);
				fragment_uniform_buffer_3[98] = float4(_CubeScaleOffset[18][0], _CubeScaleOffset[18][1], _CubeScaleOffset[18][2], _CubeScaleOffset[18][3]);
				fragment_uniform_buffer_3[99] = float4(_CubeScaleOffset[19][0], _CubeScaleOffset[19][1], _CubeScaleOffset[19][2], _CubeScaleOffset[19][3]);
				fragment_uniform_buffer_3[100] = float4(_CubeScaleOffset[20][0], _CubeScaleOffset[20][1], _CubeScaleOffset[20][2], _CubeScaleOffset[20][3]);
				fragment_uniform_buffer_3[101] = float4(_CubeScaleOffset[21][0], _CubeScaleOffset[21][1], _CubeScaleOffset[21][2], _CubeScaleOffset[21][3]);
				fragment_uniform_buffer_3[102] = float4(_CubeScaleOffset[22][0], _CubeScaleOffset[22][1], _CubeScaleOffset[22][2], _CubeScaleOffset[22][3]);
				fragment_uniform_buffer_3[103] = float4(_CubeScaleOffset[23][0], _CubeScaleOffset[23][1], _CubeScaleOffset[23][2], _CubeScaleOffset[23][3]);
				fragment_uniform_buffer_3[104] = float4(_CubeScaleOffset[24][0], _CubeScaleOffset[24][1], _CubeScaleOffset[24][2], _CubeScaleOffset[24][3]);
				fragment_uniform_buffer_3[105] = float4(_CubeScaleOffset[25][0], _CubeScaleOffset[25][1], _CubeScaleOffset[25][2], _CubeScaleOffset[25][3]);
				fragment_uniform_buffer_3[106] = float4(_CubeScaleOffset[26][0], _CubeScaleOffset[26][1], _CubeScaleOffset[26][2], _CubeScaleOffset[26][3]);
				fragment_uniform_buffer_3[107] = float4(_CubeScaleOffset[27][0], _CubeScaleOffset[27][1], _CubeScaleOffset[27][2], _CubeScaleOffset[27][3]);
				fragment_uniform_buffer_3[108] = float4(_CubeScaleOffset[28][0], _CubeScaleOffset[28][1], _CubeScaleOffset[28][2], _CubeScaleOffset[28][3]);
				fragment_uniform_buffer_3[109] = float4(_CubeScaleOffset[29][0], _CubeScaleOffset[29][1], _CubeScaleOffset[29][2], _CubeScaleOffset[29][3]);
				fragment_uniform_buffer_3[110] = float4(_CubeScaleOffset[30][0], _CubeScaleOffset[30][1], _CubeScaleOffset[30][2], _CubeScaleOffset[30][3]);
				fragment_uniform_buffer_3[111] = float4(_CubeScaleOffset[31][0], _CubeScaleOffset[31][1], _CubeScaleOffset[31][2], _CubeScaleOffset[31][3]);
				fragment_uniform_buffer_3[112] = float4(_CubeScaleOffset[32][0], _CubeScaleOffset[32][1], _CubeScaleOffset[32][2], _CubeScaleOffset[32][3]);
				fragment_uniform_buffer_3[113] = float4(_CubeScaleOffset[33][0], _CubeScaleOffset[33][1], _CubeScaleOffset[33][2], _CubeScaleOffset[33][3]);
				fragment_uniform_buffer_3[114] = float4(_CubeScaleOffset[34][0], _CubeScaleOffset[34][1], _CubeScaleOffset[34][2], _CubeScaleOffset[34][3]);
				fragment_uniform_buffer_3[115] = float4(_CubeScaleOffset[35][0], _CubeScaleOffset[35][1], _CubeScaleOffset[35][2], _CubeScaleOffset[35][3]);
				fragment_uniform_buffer_3[116] = float4(_CubeScaleOffset[36][0], _CubeScaleOffset[36][1], _CubeScaleOffset[36][2], _CubeScaleOffset[36][3]);
				fragment_uniform_buffer_3[117] = float4(_CubeScaleOffset[37][0], _CubeScaleOffset[37][1], _CubeScaleOffset[37][2], _CubeScaleOffset[37][3]);
				fragment_uniform_buffer_3[118] = float4(_CubeScaleOffset[38][0], _CubeScaleOffset[38][1], _CubeScaleOffset[38][2], _CubeScaleOffset[38][3]);
				fragment_uniform_buffer_3[119] = float4(_CubeScaleOffset[39][0], _CubeScaleOffset[39][1], _CubeScaleOffset[39][2], _CubeScaleOffset[39][3]);
				fragment_uniform_buffer_3[120] = float4(_CubeScaleOffset[40][0], _CubeScaleOffset[40][1], _CubeScaleOffset[40][2], _CubeScaleOffset[40][3]);
				fragment_uniform_buffer_3[121] = float4(_CubeScaleOffset[41][0], _CubeScaleOffset[41][1], _CubeScaleOffset[41][2], _CubeScaleOffset[41][3]);
				fragment_uniform_buffer_3[122] = float4(_CubeScaleOffset[42][0], _CubeScaleOffset[42][1], _CubeScaleOffset[42][2], _CubeScaleOffset[42][3]);
				fragment_uniform_buffer_3[123] = float4(_CubeScaleOffset[43][0], _CubeScaleOffset[43][1], _CubeScaleOffset[43][2], _CubeScaleOffset[43][3]);
				fragment_uniform_buffer_3[124] = float4(_CubeScaleOffset[44][0], _CubeScaleOffset[44][1], _CubeScaleOffset[44][2], _CubeScaleOffset[44][3]);
				fragment_uniform_buffer_3[125] = float4(_CubeScaleOffset[45][0], _CubeScaleOffset[45][1], _CubeScaleOffset[45][2], _CubeScaleOffset[45][3]);
				fragment_uniform_buffer_3[126] = float4(_CubeScaleOffset[46][0], _CubeScaleOffset[46][1], _CubeScaleOffset[46][2], _CubeScaleOffset[46][3]);
				fragment_uniform_buffer_3[127] = float4(_CubeScaleOffset[47][0], _CubeScaleOffset[47][1], _CubeScaleOffset[47][2], _CubeScaleOffset[47][3]);
				fragment_uniform_buffer_3[128] = float4(_CubeScaleOffset[48][0], _CubeScaleOffset[48][1], _CubeScaleOffset[48][2], _CubeScaleOffset[48][3]);
				fragment_uniform_buffer_3[129] = float4(_CubeScaleOffset[49][0], _CubeScaleOffset[49][1], _CubeScaleOffset[49][2], _CubeScaleOffset[49][3]);
				fragment_uniform_buffer_3[130] = float4(_CubeScaleOffset[50][0], _CubeScaleOffset[50][1], _CubeScaleOffset[50][2], _CubeScaleOffset[50][3]);
				fragment_uniform_buffer_3[131] = float4(_CubeScaleOffset[51][0], _CubeScaleOffset[51][1], _CubeScaleOffset[51][2], _CubeScaleOffset[51][3]);
				fragment_uniform_buffer_3[132] = float4(_CubeScaleOffset[52][0], _CubeScaleOffset[52][1], _CubeScaleOffset[52][2], _CubeScaleOffset[52][3]);
				fragment_uniform_buffer_3[133] = float4(_CubeScaleOffset[53][0], _CubeScaleOffset[53][1], _CubeScaleOffset[53][2], _CubeScaleOffset[53][3]);
				fragment_uniform_buffer_3[134] = float4(_CubeScaleOffset[54][0], _CubeScaleOffset[54][1], _CubeScaleOffset[54][2], _CubeScaleOffset[54][3]);
				fragment_uniform_buffer_3[135] = float4(_CubeScaleOffset[55][0], _CubeScaleOffset[55][1], _CubeScaleOffset[55][2], _CubeScaleOffset[55][3]);
				fragment_uniform_buffer_3[136] = float4(_CubeScaleOffset[56][0], _CubeScaleOffset[56][1], _CubeScaleOffset[56][2], _CubeScaleOffset[56][3]);
				fragment_uniform_buffer_3[137] = float4(_CubeScaleOffset[57][0], _CubeScaleOffset[57][1], _CubeScaleOffset[57][2], _CubeScaleOffset[57][3]);
				fragment_uniform_buffer_3[138] = float4(_CubeScaleOffset[58][0], _CubeScaleOffset[58][1], _CubeScaleOffset[58][2], _CubeScaleOffset[58][3]);
				fragment_uniform_buffer_3[139] = float4(_CubeScaleOffset[59][0], _CubeScaleOffset[59][1], _CubeScaleOffset[59][2], _CubeScaleOffset[59][3]);
				fragment_uniform_buffer_3[140] = float4(_CubeScaleOffset[60][0], _CubeScaleOffset[60][1], _CubeScaleOffset[60][2], _CubeScaleOffset[60][3]);
				fragment_uniform_buffer_3[141] = float4(_CubeScaleOffset[61][0], _CubeScaleOffset[61][1], _CubeScaleOffset[61][2], _CubeScaleOffset[61][3]);
				fragment_uniform_buffer_3[142] = float4(_CubeScaleOffset[62][0], _CubeScaleOffset[62][1], _CubeScaleOffset[62][2], _CubeScaleOffset[62][3]);
				fragment_uniform_buffer_3[143] = float4(_CubeScaleOffset[63][0], _CubeScaleOffset[63][1], _CubeScaleOffset[63][2], _CubeScaleOffset[63][3]);
				fragment_uniform_buffer_3[144] = float4(_CubeScaleOffset[64][0], _CubeScaleOffset[64][1], _CubeScaleOffset[64][2], _CubeScaleOffset[64][3]);
				fragment_uniform_buffer_3[145] = float4(_CubeScaleOffset[65][0], _CubeScaleOffset[65][1], _CubeScaleOffset[65][2], _CubeScaleOffset[65][3]);
				fragment_uniform_buffer_3[146] = float4(_CubeScaleOffset[66][0], _CubeScaleOffset[66][1], _CubeScaleOffset[66][2], _CubeScaleOffset[66][3]);
				fragment_uniform_buffer_3[147] = float4(_CubeScaleOffset[67][0], _CubeScaleOffset[67][1], _CubeScaleOffset[67][2], _CubeScaleOffset[67][3]);
				fragment_uniform_buffer_3[148] = float4(_CubeScaleOffset[68][0], _CubeScaleOffset[68][1], _CubeScaleOffset[68][2], _CubeScaleOffset[68][3]);
				fragment_uniform_buffer_3[149] = float4(_CubeScaleOffset[69][0], _CubeScaleOffset[69][1], _CubeScaleOffset[69][2], _CubeScaleOffset[69][3]);
				fragment_uniform_buffer_3[150] = float4(_CubeScaleOffset[70][0], _CubeScaleOffset[70][1], _CubeScaleOffset[70][2], _CubeScaleOffset[70][3]);
				fragment_uniform_buffer_3[151] = float4(_CubeScaleOffset[71][0], _CubeScaleOffset[71][1], _CubeScaleOffset[71][2], _CubeScaleOffset[71][3]);
				fragment_uniform_buffer_3[152] = float4(_CubeScaleOffset[72][0], _CubeScaleOffset[72][1], _CubeScaleOffset[72][2], _CubeScaleOffset[72][3]);
				fragment_uniform_buffer_3[153] = float4(_CubeScaleOffset[73][0], _CubeScaleOffset[73][1], _CubeScaleOffset[73][2], _CubeScaleOffset[73][3]);
				fragment_uniform_buffer_3[154] = float4(_CubeScaleOffset[74][0], _CubeScaleOffset[74][1], _CubeScaleOffset[74][2], _CubeScaleOffset[74][3]);
				fragment_uniform_buffer_3[155] = float4(_CubeScaleOffset[75][0], _CubeScaleOffset[75][1], _CubeScaleOffset[75][2], _CubeScaleOffset[75][3]);
				fragment_uniform_buffer_3[156] = float4(_CubeScaleOffset[76][0], _CubeScaleOffset[76][1], _CubeScaleOffset[76][2], _CubeScaleOffset[76][3]);
				fragment_uniform_buffer_3[157] = float4(_CubeScaleOffset[77][0], _CubeScaleOffset[77][1], _CubeScaleOffset[77][2], _CubeScaleOffset[77][3]);
				fragment_uniform_buffer_3[158] = float4(_CubeScaleOffset[78][0], _CubeScaleOffset[78][1], _CubeScaleOffset[78][2], _CubeScaleOffset[78][3]);
				fragment_uniform_buffer_3[159] = float4(_CubeScaleOffset[79][0], _CubeScaleOffset[79][1], _CubeScaleOffset[79][2], _CubeScaleOffset[79][3]);
				fragment_uniform_buffer_3[160] = float4(_CubeScaleOffset[80][0], _CubeScaleOffset[80][1], _CubeScaleOffset[80][2], _CubeScaleOffset[80][3]);
				fragment_uniform_buffer_3[161] = float4(_CubeScaleOffset[81][0], _CubeScaleOffset[81][1], _CubeScaleOffset[81][2], _CubeScaleOffset[81][3]);
				fragment_uniform_buffer_3[162] = float4(_CubeScaleOffset[82][0], _CubeScaleOffset[82][1], _CubeScaleOffset[82][2], _CubeScaleOffset[82][3]);
				fragment_uniform_buffer_3[163] = float4(_CubeScaleOffset[83][0], _CubeScaleOffset[83][1], _CubeScaleOffset[83][2], _CubeScaleOffset[83][3]);
				fragment_uniform_buffer_3[164] = float4(_CubeScaleOffset[84][0], _CubeScaleOffset[84][1], _CubeScaleOffset[84][2], _CubeScaleOffset[84][3]);
				fragment_uniform_buffer_3[165] = float4(_CubeScaleOffset[85][0], _CubeScaleOffset[85][1], _CubeScaleOffset[85][2], _CubeScaleOffset[85][3]);
				fragment_uniform_buffer_3[166] = float4(_CubeScaleOffset[86][0], _CubeScaleOffset[86][1], _CubeScaleOffset[86][2], _CubeScaleOffset[86][3]);
				fragment_uniform_buffer_3[167] = float4(_CubeScaleOffset[87][0], _CubeScaleOffset[87][1], _CubeScaleOffset[87][2], _CubeScaleOffset[87][3]);
				fragment_uniform_buffer_3[168] = float4(_CubeScaleOffset[88][0], _CubeScaleOffset[88][1], _CubeScaleOffset[88][2], _CubeScaleOffset[88][3]);
				fragment_uniform_buffer_3[169] = float4(_CubeScaleOffset[89][0], _CubeScaleOffset[89][1], _CubeScaleOffset[89][2], _CubeScaleOffset[89][3]);
				fragment_uniform_buffer_3[170] = float4(_CubeScaleOffset[90][0], _CubeScaleOffset[90][1], _CubeScaleOffset[90][2], _CubeScaleOffset[90][3]);
				fragment_uniform_buffer_3[171] = float4(_CubeScaleOffset[91][0], _CubeScaleOffset[91][1], _CubeScaleOffset[91][2], _CubeScaleOffset[91][3]);
				fragment_uniform_buffer_3[172] = float4(_CubeScaleOffset[92][0], _CubeScaleOffset[92][1], _CubeScaleOffset[92][2], _CubeScaleOffset[92][3]);
				fragment_uniform_buffer_3[173] = float4(_CubeScaleOffset[93][0], _CubeScaleOffset[93][1], _CubeScaleOffset[93][2], _CubeScaleOffset[93][3]);
				fragment_uniform_buffer_3[174] = float4(_CubeScaleOffset[94][0], _CubeScaleOffset[94][1], _CubeScaleOffset[94][2], _CubeScaleOffset[94][3]);
				fragment_uniform_buffer_3[175] = float4(_CubeScaleOffset[95][0], _CubeScaleOffset[95][1], _CubeScaleOffset[95][2], _CubeScaleOffset[95][3]);
				fragment_uniform_buffer_3[176] = float4(_CubeScaleOffset[96][0], _CubeScaleOffset[96][1], _CubeScaleOffset[96][2], _CubeScaleOffset[96][3]);
				fragment_uniform_buffer_3[177] = float4(_CubeScaleOffset[97][0], _CubeScaleOffset[97][1], _CubeScaleOffset[97][2], _CubeScaleOffset[97][3]);
				fragment_uniform_buffer_3[178] = float4(_CubeScaleOffset[98][0], _CubeScaleOffset[98][1], _CubeScaleOffset[98][2], _CubeScaleOffset[98][3]);
				fragment_uniform_buffer_3[179] = float4(_CubeScaleOffset[99][0], _CubeScaleOffset[99][1], _CubeScaleOffset[99][2], _CubeScaleOffset[99][3]);
				fragment_uniform_buffer_3[180] = float4(_CubeScaleOffset[100][0], _CubeScaleOffset[100][1], _CubeScaleOffset[100][2], _CubeScaleOffset[100][3]);
				fragment_uniform_buffer_3[181] = float4(_CubeScaleOffset[101][0], _CubeScaleOffset[101][1], _CubeScaleOffset[101][2], _CubeScaleOffset[101][3]);
				fragment_uniform_buffer_3[182] = float4(_CubeScaleOffset[102][0], _CubeScaleOffset[102][1], _CubeScaleOffset[102][2], _CubeScaleOffset[102][3]);
				fragment_uniform_buffer_3[183] = float4(_CubeScaleOffset[103][0], _CubeScaleOffset[103][1], _CubeScaleOffset[103][2], _CubeScaleOffset[103][3]);
				fragment_uniform_buffer_3[184] = float4(_CubeScaleOffset[104][0], _CubeScaleOffset[104][1], _CubeScaleOffset[104][2], _CubeScaleOffset[104][3]);
				fragment_uniform_buffer_3[185] = float4(_CubeScaleOffset[105][0], _CubeScaleOffset[105][1], _CubeScaleOffset[105][2], _CubeScaleOffset[105][3]);
				fragment_uniform_buffer_3[186] = float4(_CubeScaleOffset[106][0], _CubeScaleOffset[106][1], _CubeScaleOffset[106][2], _CubeScaleOffset[106][3]);
				fragment_uniform_buffer_3[187] = float4(_CubeScaleOffset[107][0], _CubeScaleOffset[107][1], _CubeScaleOffset[107][2], _CubeScaleOffset[107][3]);
				fragment_uniform_buffer_3[188] = float4(_CubeScaleOffset[108][0], _CubeScaleOffset[108][1], _CubeScaleOffset[108][2], _CubeScaleOffset[108][3]);
				fragment_uniform_buffer_3[189] = float4(_CubeScaleOffset[109][0], _CubeScaleOffset[109][1], _CubeScaleOffset[109][2], _CubeScaleOffset[109][3]);
				fragment_uniform_buffer_3[190] = float4(_CubeScaleOffset[110][0], _CubeScaleOffset[110][1], _CubeScaleOffset[110][2], _CubeScaleOffset[110][3]);
				fragment_uniform_buffer_3[191] = float4(_CubeScaleOffset[111][0], _CubeScaleOffset[111][1], _CubeScaleOffset[111][2], _CubeScaleOffset[111][3]);
				fragment_uniform_buffer_3[192] = float4(_CubeScaleOffset[112][0], _CubeScaleOffset[112][1], _CubeScaleOffset[112][2], _CubeScaleOffset[112][3]);
				fragment_uniform_buffer_3[193] = float4(_CubeScaleOffset[113][0], _CubeScaleOffset[113][1], _CubeScaleOffset[113][2], _CubeScaleOffset[113][3]);
				fragment_uniform_buffer_3[194] = float4(_CubeScaleOffset[114][0], _CubeScaleOffset[114][1], _CubeScaleOffset[114][2], _CubeScaleOffset[114][3]);
				fragment_uniform_buffer_3[195] = float4(_CubeScaleOffset[115][0], _CubeScaleOffset[115][1], _CubeScaleOffset[115][2], _CubeScaleOffset[115][3]);
				fragment_uniform_buffer_3[196] = float4(_CubeScaleOffset[116][0], _CubeScaleOffset[116][1], _CubeScaleOffset[116][2], _CubeScaleOffset[116][3]);
				fragment_uniform_buffer_3[197] = float4(_CubeScaleOffset[117][0], _CubeScaleOffset[117][1], _CubeScaleOffset[117][2], _CubeScaleOffset[117][3]);
				fragment_uniform_buffer_3[198] = float4(_CubeScaleOffset[118][0], _CubeScaleOffset[118][1], _CubeScaleOffset[118][2], _CubeScaleOffset[118][3]);
				fragment_uniform_buffer_3[199] = float4(_CubeScaleOffset[119][0], _CubeScaleOffset[119][1], _CubeScaleOffset[119][2], _CubeScaleOffset[119][3]);
				fragment_uniform_buffer_3[200] = float4(_CubeScaleOffset[120][0], _CubeScaleOffset[120][1], _CubeScaleOffset[120][2], _CubeScaleOffset[120][3]);
				fragment_uniform_buffer_3[201] = float4(_CubeScaleOffset[121][0], _CubeScaleOffset[121][1], _CubeScaleOffset[121][2], _CubeScaleOffset[121][3]);
				fragment_uniform_buffer_3[202] = float4(_CubeScaleOffset[122][0], _CubeScaleOffset[122][1], _CubeScaleOffset[122][2], _CubeScaleOffset[122][3]);
				fragment_uniform_buffer_3[203] = float4(_CubeScaleOffset[123][0], _CubeScaleOffset[123][1], _CubeScaleOffset[123][2], _CubeScaleOffset[123][3]);
				fragment_uniform_buffer_3[204] = float4(_CubeScaleOffset[124][0], _CubeScaleOffset[124][1], _CubeScaleOffset[124][2], _CubeScaleOffset[124][3]);
				fragment_uniform_buffer_3[205] = float4(_CubeScaleOffset[125][0], _CubeScaleOffset[125][1], _CubeScaleOffset[125][2], _CubeScaleOffset[125][3]);
				fragment_uniform_buffer_3[206] = float4(_CubeScaleOffset[126][0], _CubeScaleOffset[126][1], _CubeScaleOffset[126][2], _CubeScaleOffset[126][3]);
				fragment_uniform_buffer_3[207] = float4(_CubeScaleOffset[127][0], _CubeScaleOffset[127][1], _CubeScaleOffset[127][2], _CubeScaleOffset[127][3]);

				fragment_uniform_buffer_4[1] = float4(_Smoothness, fragment_uniform_buffer_4[1][1], fragment_uniform_buffer_4[1][2], fragment_uniform_buffer_4[1][3]);

				fragment_uniform_buffer_4[1] = float4(fragment_uniform_buffer_4[1][0], _Metallic, fragment_uniform_buffer_4[1][2], fragment_uniform_buffer_4[1][3]);

				fragment_uniform_buffer_4[2] = float4(_Emission[0], _Emission[1], _Emission[2], _Emission[3]);

				fragment_uniform_buffer_4[4] = float4(_Bloom, fragment_uniform_buffer_4[4][1], fragment_uniform_buffer_4[4][2], fragment_uniform_buffer_4[4][3]);

				fragment_uniform_buffer_4[12] = float4(_BlendMode, fragment_uniform_buffer_4[12][1], fragment_uniform_buffer_4[12][2], fragment_uniform_buffer_4[12][3]);

				fragment_uniform_buffer_4[12] = float4(fragment_uniform_buffer_4[12][0], _EnableBlendModePreserveSpecularLighting, fragment_uniform_buffer_4[12][2], fragment_uniform_buffer_4[12][3]);

				fragment_uniform_buffer_5[0] = float4(_AtmosphericRadius, fragment_uniform_buffer_5[0][1], fragment_uniform_buffer_5[0][2], fragment_uniform_buffer_5[0][3]);

				fragment_uniform_buffer_5[0] = float4(fragment_uniform_buffer_5[0][0], fragment_uniform_buffer_5[0][1], fragment_uniform_buffer_5[0][2], _AerosolSeaLevelExtinction);

				fragment_uniform_buffer_5[1] = float4(_AirDensityFalloff, fragment_uniform_buffer_5[1][1], fragment_uniform_buffer_5[1][2], fragment_uniform_buffer_5[1][3]);

				fragment_uniform_buffer_5[1] = float4(fragment_uniform_buffer_5[1][0], _AirScaleHeight, fragment_uniform_buffer_5[1][2], fragment_uniform_buffer_5[1][3]);

				fragment_uniform_buffer_5[1] = float4(fragment_uniform_buffer_5[1][0], fragment_uniform_buffer_5[1][1], _AerosolDensityFalloff, fragment_uniform_buffer_5[1][3]);

				fragment_uniform_buffer_5[1] = float4(fragment_uniform_buffer_5[1][0], fragment_uniform_buffer_5[1][1], fragment_uniform_buffer_5[1][2], _AerosolScaleHeight);

				fragment_uniform_buffer_5[2] = float4(_OzoneScaleOffset[0], _OzoneScaleOffset[1], fragment_uniform_buffer_5[2][2], fragment_uniform_buffer_5[2][3]);

				fragment_uniform_buffer_5[2] = float4(fragment_uniform_buffer_5[2][0], fragment_uniform_buffer_5[2][1], _OzoneLayerStart, fragment_uniform_buffer_5[2][3]);

				fragment_uniform_buffer_5[2] = float4(fragment_uniform_buffer_5[2][0], fragment_uniform_buffer_5[2][1], fragment_uniform_buffer_5[2][2], _OzoneLayerEnd);

				fragment_uniform_buffer_5[3] = float4(_AirSeaLevelExtinction[0], _AirSeaLevelExtinction[1], _AirSeaLevelExtinction[2], _AirSeaLevelExtinction[3]);

				fragment_uniform_buffer_5[6] = float4(_OzoneSeaLevelExtinction[0], _OzoneSeaLevelExtinction[1], _OzoneSeaLevelExtinction[2], _OzoneSeaLevelExtinction[3]);

				fragment_uniform_buffer_5[8] = float4(_HorizonTint[0], _HorizonTint[1], _HorizonTint[2], _HorizonTint[3]);

				fragment_uniform_buffer_5[9] = float4(_ZenithTint[0], _ZenithTint[1], _ZenithTint[2], _ZenithTint[3]);

				fragment_uniform_buffer_5[10] = float4(fragment_uniform_buffer_5[10][0], fragment_uniform_buffer_5[10][1], _AlphaSaturation, fragment_uniform_buffer_5[10][3]);

				fragment_uniform_buffer_5[10] = float4(fragment_uniform_buffer_5[10][0], fragment_uniform_buffer_5[10][1], fragment_uniform_buffer_5[10][2], _AlphaMultiplier);

				fragment_uniform_buffer_5[11] = float4(_HorizonZenithShiftPower, fragment_uniform_buffer_5[11][1], fragment_uniform_buffer_5[11][2], fragment_uniform_buffer_5[11][3]);

				fragment_uniform_buffer_5[11] = float4(fragment_uniform_buffer_5[11][0], _HorizonZenithShiftScale, fragment_uniform_buffer_5[11][2], fragment_uniform_buffer_5[11][3]);

				fragment_uniform_buffer_5[12] = float4(fragment_uniform_buffer_5[12][0], fragment_uniform_buffer_5[12][1], fragment_uniform_buffer_5[12][2], _VolumetricCloudsBottomAltitude);

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
			GpuProgramID 741152

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
			GpuProgramID 799164

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
			GpuProgramID 889024

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
			GpuProgramID 978768

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
			GpuProgramID 1046096

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
			GpuProgramID 1053738

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
