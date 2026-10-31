Shader "Shader Graphs/Atlas_Wood_Random"
{
	Properties
	{
		_Normal_intensity ("Normal intensity", Float) = 0
		[NoScaleOffset] _SampleTexture2D_3fdabc2d7e9e4c589b9a2dadffbca241_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_16d4cfc1b2d84425a03cc159372f65be_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] [Normal] _SampleTexture2D_20f0859609b442fab4d205339d1cc839_Texture_1_Texture2D ("Texture2D", 2D) = "bump" {}
		[NoScaleOffset] [Normal] _SampleTexture2D_8483d8fe211549e6bf650442a5c65517_Texture_1_Texture2D ("Texture2D", 2D) = "bump" {}
		[NoScaleOffset] _SampleTexture2D_62c1e9d4c61140de92d53abe56130439_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_2f7093afd0804feca4e781ab35cf0fdb_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[HideInInspector] _EmissionColor ("Color", Color) = (1,1,1,1)
		[HideInInspector] _RenderQueueType ("Float", Float) = 1
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
		Tags { "DisableBatching" = "False" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
		Pass
		{
			Name "ShadowCaster"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			ColorMask 0
			ZClip [_ZClip]
			Cull [_CullMode]
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 56472

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
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
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
			GpuProgramID 283500

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
			Name "DepthOnly"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
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
			GpuProgramID 484023

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER


			#if (!defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_VERTEX)
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
			#if (!defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
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
			#if (defined(WRITE_DECAL_BUFFER)) && defined(SHADER_STAGE_FRAGMENT)
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
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "GBuffer" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
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
			GpuProgramID 585619

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
			#if (defined(DECALS_3RT)) && defined(SHADER_STAGE_FRAGMENT)
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
			float4x4 unity_ObjectToWorld;
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
			float _Normal_intensity;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[7];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_16d4cfc1b2d84425a03cc159372f65be_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_20f0859609b442fab4d205339d1cc839_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_2f7093afd0804feca4e781ab35cf0fdb_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_3fdabc2d7e9e4c589b9a2dadffbca241_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_62c1e9d4c61140de92d53abe56130439_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_8483d8fe211549e6bf650442a5c65517_Texture_1_Texture2D;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_SampleTexture2D_16d4cfc1b2d84425a03cc159372f65be_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_20f0859609b442fab4d205339d1cc839_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f7093afd0804feca4e781ab35cf0fdb_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_3fdabc2d7e9e4c589b9a2dadffbca241_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_62c1e9d4c61140de92d53abe56130439_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_8483d8fe211549e6bf650442a5c65517_Texture_1_Texture2D;

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
				float fragment_unnamed_109 = 1.0f / max(sqrt(dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_129 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_192 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_218 = asfloat(fragment_unnamed_192 ? asuint(((-0.0f) - fragment_input_5.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_225 = asfloat(fragment_unnamed_192 ? asuint(((-0.0f) - fragment_input_5.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_232 = asfloat(fragment_unnamed_192 ? asuint(((-0.0f) - fragment_input_5.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_236 = rsqrt(dot(float3(fragment_unnamed_218, fragment_unnamed_225, fragment_unnamed_232), float3(fragment_unnamed_218, fragment_unnamed_225, fragment_unnamed_232)));
				float4 fragment_unnamed_250 = _SampleTexture2D_3fdabc2d7e9e4c589b9a2dadffbca241_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_3fdabc2d7e9e4c589b9a2dadffbca241_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_253 = fragment_unnamed_250.x;
				float fragment_unnamed_254 = fragment_unnamed_250.y;
				float fragment_unnamed_255 = fragment_unnamed_250.z;
				float fragment_unnamed_284 = frac(sin(dot(float2(frac(sin(dot(float2(fragment_uniform_buffer_1[3u].xz), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), frac(sin(dot(float2(fragment_uniform_buffer_1[3u].yz), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f)), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float fragment_unnamed_290 = fragment_unnamed_284 + fragment_input_2.x;
				float fragment_unnamed_291 = asfloat(0u) + fragment_input_2.y;
				float4 fragment_unnamed_296 = _SampleTexture2D_16d4cfc1b2d84425a03cc159372f65be_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_16d4cfc1b2d84425a03cc159372f65be_Texture_1_Texture2D, float2(fragment_unnamed_290, fragment_unnamed_291), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_298 = fragment_unnamed_296.x;
				float fragment_unnamed_299 = fragment_unnamed_296.y;
				float fragment_unnamed_300 = fragment_unnamed_296.z;
				float fragment_unnamed_303 = min(fragment_unnamed_284 * 3.6558635234832763671875f, 1.0f);
				float fragment_unnamed_304 = mad(fragment_unnamed_303, -0.4905660152435302734375f, 1.0f);
				float fragment_unnamed_306 = mad(fragment_unnamed_303, -0.626745760440826416015625f, 0.967970371246337890625f);
				float fragment_unnamed_309 = mad(fragment_unnamed_303, -0.7152011394500732421875f, 0.938679218292236328125f);
				float fragment_unnamed_324 = clamp((fragment_unnamed_284 + (-0.2735331952571868896484375f)) * 2.8814189434051513671875f, 0.0f, 1.0f);
				float fragment_unnamed_325 = clamp((fragment_unnamed_284 + (-0.620584428310394287109375f)) * 4.41551113128662109375f, 0.0f, 1.0f);
				float fragment_unnamed_326 = clamp((fragment_unnamed_284 + (-0.847058773040771484375f)) * 6.938588619232177734375f, 0.0f, 1.0f);
				float fragment_unnamed_336 = mad(fragment_unnamed_324, ((-0.0f) - fragment_unnamed_304) + 0.24528299272060394287109375f, fragment_unnamed_304);
				float fragment_unnamed_337 = mad(fragment_unnamed_324, ((-0.0f) - fragment_unnamed_306) + 0.1932989060878753662109375f, fragment_unnamed_306);
				float fragment_unnamed_338 = mad(fragment_unnamed_324, ((-0.0f) - fragment_unnamed_309) + 0.1654503047466278076171875f, fragment_unnamed_309);
				float fragment_unnamed_348 = mad(fragment_unnamed_325, ((-0.0f) - fragment_unnamed_336) + 0.1981132030487060546875f, fragment_unnamed_336);
				float fragment_unnamed_349 = mad(fragment_unnamed_325, ((-0.0f) - fragment_unnamed_337) + 0.12354420125484466552734375f, fragment_unnamed_337);
				float fragment_unnamed_350 = mad(fragment_unnamed_325, ((-0.0f) - fragment_unnamed_338) + 0.090646140277385711669921875f, fragment_unnamed_338);
				float fragment_unnamed_360 = mad(fragment_unnamed_326, ((-0.0f) - fragment_unnamed_348) + 0.471698105335235595703125f, fragment_unnamed_348);
				float fragment_unnamed_361 = mad(fragment_unnamed_326, ((-0.0f) - fragment_unnamed_349) + 0.2724092006683349609375f, fragment_unnamed_349);
				float fragment_unnamed_362 = mad(fragment_unnamed_326, ((-0.0f) - fragment_unnamed_350) + 0.1891241967678070068359375f, fragment_unnamed_350);
				float fragment_unnamed_366 = ((-0.0f) - fragment_unnamed_298) + 1.0f;
				float fragment_unnamed_367 = ((-0.0f) - fragment_unnamed_299) + 1.0f;
				float fragment_unnamed_368 = ((-0.0f) - fragment_unnamed_300) + 1.0f;
				float fragment_unnamed_384 = fragment_unnamed_298 * fragment_unnamed_360;
				float fragment_unnamed_385 = fragment_unnamed_299 * fragment_unnamed_361;
				float fragment_unnamed_386 = fragment_unnamed_300 * fragment_unnamed_362;
				bool fragment_unnamed_390 = 0.5f >= fragment_unnamed_298;
				bool fragment_unnamed_392 = 0.5f >= fragment_unnamed_299;
				bool fragment_unnamed_393 = 0.5f >= fragment_unnamed_300;
				float fragment_unnamed_438 = abs(mad(fragment_input_2.x + 0.0f, 2.0f, -1.0f)) + (-1.0f);
				float fragment_unnamed_439 = abs(mad(fragment_input_2.y + (-0.100000001490116119384765625f), 2.0f, -1.0f)) + (-0.545000016689300537109375f);
				float fragment_unnamed_441 = ddx_coarse(fragment_unnamed_438);
				float fragment_unnamed_442 = ddx_coarse(fragment_unnamed_439);
				float fragment_unnamed_443 = ddy_coarse(fragment_unnamed_438);
				float fragment_unnamed_444 = ddy_coarse(fragment_unnamed_439);
				float fragment_unnamed_459 = min(clamp(((-0.0f) - (fragment_unnamed_439 / (abs(fragment_unnamed_444) + abs(fragment_unnamed_442)))) + 1.0f, 0.0f, 1.0f), clamp(((-0.0f) - (fragment_unnamed_438 / (abs(fragment_unnamed_443) + abs(fragment_unnamed_441)))) + 1.0f, 0.0f, 1.0f));
				float fragment_unnamed_466 = mad(fragment_unnamed_459, ((-0.0f) - fragment_unnamed_253) + mad(((-0.0f) - fragment_unnamed_298) + mad(fragment_unnamed_384 + fragment_unnamed_384, asfloat((fragment_unnamed_390 ? 4294967295u : 0u) & 1065353216u), mad((-0.0f) - (fragment_unnamed_366 + fragment_unnamed_366), ((-0.0f) - fragment_unnamed_360) + 1.0f, 1.0f) * asfloat(fragment_unnamed_390 ? 0u : 1065353216u)), 0.5f, fragment_unnamed_298), fragment_unnamed_253);
				float fragment_unnamed_467 = mad(fragment_unnamed_459, ((-0.0f) - fragment_unnamed_254) + mad(((-0.0f) - fragment_unnamed_299) + mad(fragment_unnamed_385 + fragment_unnamed_385, asfloat((fragment_unnamed_392 ? 4294967295u : 0u) & 1065353216u), mad((-0.0f) - (fragment_unnamed_367 + fragment_unnamed_367), ((-0.0f) - fragment_unnamed_361) + 1.0f, 1.0f) * asfloat(fragment_unnamed_392 ? 0u : 1065353216u)), 0.5f, fragment_unnamed_299), fragment_unnamed_254);
				float fragment_unnamed_468 = mad(fragment_unnamed_459, ((-0.0f) - fragment_unnamed_255) + mad(((-0.0f) - fragment_unnamed_300) + mad(fragment_unnamed_386 + fragment_unnamed_386, asfloat((fragment_unnamed_393 ? 4294967295u : 0u) & 1065353216u), mad((-0.0f) - (fragment_unnamed_368 + fragment_unnamed_368), ((-0.0f) - fragment_unnamed_362) + 1.0f, 1.0f) * asfloat(fragment_unnamed_393 ? 0u : 1065353216u)), 0.5f, fragment_unnamed_300), fragment_unnamed_255);
				float4 fragment_unnamed_473 = _SampleTexture2D_62c1e9d4c61140de92d53abe56130439_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_62c1e9d4c61140de92d53abe56130439_Texture_1_Texture2D, float2(fragment_unnamed_290, fragment_unnamed_291), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_475 = fragment_unnamed_473.x;
				float fragment_unnamed_476 = fragment_unnamed_473.w;
				float4 fragment_unnamed_481 = _SampleTexture2D_2f7093afd0804feca4e781ab35cf0fdb_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f7093afd0804feca4e781ab35cf0fdb_Texture_1_Texture2D, float2(fragment_unnamed_290, fragment_unnamed_291), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_489 = mad(fragment_unnamed_459, ((-0.0f) - fragment_unnamed_476) + fragment_unnamed_481.w, fragment_unnamed_476);
				float fragment_unnamed_490 = mad(fragment_unnamed_459, ((-0.0f) - fragment_unnamed_475) + fragment_unnamed_481.x, fragment_unnamed_475);
				float4 fragment_unnamed_499 = _SampleTexture2D_20f0859609b442fab4d205339d1cc839_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_20f0859609b442fab4d205339d1cc839_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_505 = mad(fragment_unnamed_499.x * fragment_unnamed_499.w, 2.0f, -1.0f);
				float fragment_unnamed_506 = mad(fragment_unnamed_499.y, 2.0f, -1.0f);
				float fragment_unnamed_514 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_505, fragment_unnamed_506), float2(fragment_unnamed_505, fragment_unnamed_506)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float4 fragment_unnamed_520 = _SampleTexture2D_8483d8fe211549e6bf650442a5c65517_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_8483d8fe211549e6bf650442a5c65517_Texture_1_Texture2D, float2(fragment_unnamed_290, fragment_unnamed_291), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_526 = mad(fragment_unnamed_520.x * fragment_unnamed_520.w, 2.0f, -1.0f);
				float fragment_unnamed_527 = mad(fragment_unnamed_520.y, 2.0f, -1.0f);
				float fragment_unnamed_549 = mad(fragment_unnamed_459, ((-0.0f) - fragment_unnamed_505) + fragment_unnamed_526, fragment_unnamed_505) * fragment_uniform_buffer_2[6u].x;
				float fragment_unnamed_550 = mad(fragment_unnamed_459, ((-0.0f) - fragment_unnamed_506) + fragment_unnamed_527, fragment_unnamed_506) * fragment_uniform_buffer_2[6u].x;
				float fragment_unnamed_556 = mad(clamp(fragment_uniform_buffer_2[6u].x, 0.0f, 1.0f), mad(fragment_unnamed_459, ((-0.0f) - fragment_unnamed_514) + max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_526, fragment_unnamed_527), float2(fragment_unnamed_526, fragment_unnamed_527)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f), fragment_unnamed_514) + (-1.0f), 1.0f);
				float fragment_unnamed_563 = mad(fragment_unnamed_556, fragment_unnamed_109 * fragment_input_6.x, mad(fragment_unnamed_549, fragment_unnamed_109 * fragment_input_1.x, (fragment_unnamed_109 * (fragment_unnamed_129 * mad(fragment_input_6.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_6.z)))) * fragment_unnamed_550));
				float fragment_unnamed_564 = mad(fragment_unnamed_556, fragment_unnamed_109 * fragment_input_6.y, mad(fragment_unnamed_549, fragment_unnamed_109 * fragment_input_1.y, (fragment_unnamed_109 * (fragment_unnamed_129 * mad(fragment_input_6.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_6.x)))) * fragment_unnamed_550));
				float fragment_unnamed_565 = mad(fragment_unnamed_556, fragment_unnamed_109 * fragment_input_6.z, mad(fragment_unnamed_549, fragment_unnamed_109 * fragment_input_1.z, (fragment_unnamed_109 * (fragment_unnamed_129 * mad(fragment_input_6.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_6.y)))) * fragment_unnamed_550));
				float fragment_unnamed_570 = rsqrt(max(dot(float3(fragment_unnamed_563, fragment_unnamed_564, fragment_unnamed_565), float3(fragment_unnamed_563, fragment_unnamed_564, fragment_unnamed_565)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_571 = fragment_unnamed_570 * fragment_unnamed_563;
				float fragment_unnamed_572 = fragment_unnamed_570 * fragment_unnamed_564;
				float fragment_unnamed_573 = fragment_unnamed_570 * fragment_unnamed_565;
				float fragment_unnamed_635;
				float fragment_unnamed_636;
				float fragment_unnamed_637;
				float fragment_unnamed_638;
				float fragment_unnamed_639;
				float fragment_unnamed_640;
				float fragment_unnamed_641;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_584 = uint(gl_FragCoord.x);
					uint fragment_unnamed_585 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_586 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_584, fragment_unnamed_585, 0u), 0u));
					float fragment_unnamed_592 = fragment_unnamed_586.w;
					float4 fragment_unnamed_593 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_584, fragment_unnamed_585, 0u), 0u));
					float fragment_unnamed_598 = fragment_unnamed_593.w;
					float4 fragment_unnamed_599 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_584, fragment_unnamed_585, 0u), 0u));
					bool fragment_unnamed_607 = fragment_unnamed_598 < 1.0f;
					float fragment_unnamed_608 = mad(fragment_unnamed_571, fragment_unnamed_598, mad(fragment_unnamed_593.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_609 = mad(fragment_unnamed_572, fragment_unnamed_598, mad(fragment_unnamed_593.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_610 = mad(fragment_unnamed_573, fragment_unnamed_598, mad(fragment_unnamed_593.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_615 = rsqrt(max(dot(float3(fragment_unnamed_608, fragment_unnamed_609, fragment_unnamed_610), float3(fragment_unnamed_608, fragment_unnamed_609, fragment_unnamed_610)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_635 = mad(fragment_unnamed_466, fragment_unnamed_592, fragment_unnamed_586.x);
					fragment_unnamed_636 = mad(fragment_unnamed_467, fragment_unnamed_592, fragment_unnamed_586.y);
					fragment_unnamed_637 = mad(fragment_unnamed_468, fragment_unnamed_592, fragment_unnamed_586.z);
					fragment_unnamed_638 = mad(fragment_unnamed_489, fragment_unnamed_599.w, fragment_unnamed_599.z);
					fragment_unnamed_639 = asfloat(fragment_unnamed_607 ? asuint(fragment_unnamed_615 * fragment_unnamed_610) : asuint(fragment_unnamed_573));
					fragment_unnamed_640 = asfloat(fragment_unnamed_607 ? asuint(fragment_unnamed_615 * fragment_unnamed_609) : asuint(fragment_unnamed_572));
					fragment_unnamed_641 = asfloat(fragment_unnamed_607 ? asuint(fragment_unnamed_615 * fragment_unnamed_608) : asuint(fragment_unnamed_571));
				}
				else
				{
					fragment_unnamed_635 = fragment_unnamed_466;
					fragment_unnamed_636 = fragment_unnamed_467;
					fragment_unnamed_637 = fragment_unnamed_468;
					fragment_unnamed_638 = fragment_unnamed_489;
					fragment_unnamed_639 = fragment_unnamed_573;
					fragment_unnamed_640 = fragment_unnamed_572;
					fragment_unnamed_641 = fragment_unnamed_571;
				}
				uint4 fragment_unnamed_656 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_657 = fragment_unnamed_656.x;
				float fragment_unnamed_942;
				float fragment_unnamed_944;
				float fragment_unnamed_946;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_657 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_657 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_943;
					float fragment_unnamed_945;
					float fragment_unnamed_947;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_680 = asfloat(1065353216u);
						float fragment_unnamed_710 = fragment_unnamed_640 * fragment_unnamed_641;
						float fragment_unnamed_711 = fragment_unnamed_639 * fragment_unnamed_640;
						float fragment_unnamed_712 = fragment_unnamed_639 * fragment_unnamed_639;
						float fragment_unnamed_713 = fragment_unnamed_641 * fragment_unnamed_639;
						float fragment_unnamed_746 = mad(fragment_unnamed_641, fragment_unnamed_641, (-0.0f) - (fragment_unnamed_640 * fragment_unnamed_640));
						fragment_unnamed_943 = mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_746, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_710, fragment_unnamed_711, fragment_unnamed_712, fragment_unnamed_713))) + dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_641, fragment_unnamed_640, fragment_unnamed_639, fragment_unnamed_680));
						fragment_unnamed_945 = mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_746, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_710, fragment_unnamed_711, fragment_unnamed_712, fragment_unnamed_713))) + dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_641, fragment_unnamed_640, fragment_unnamed_639, fragment_unnamed_680));
						fragment_unnamed_947 = mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_746, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_710, fragment_unnamed_711, fragment_unnamed_712, fragment_unnamed_713))) + dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_641, fragment_unnamed_640, fragment_unnamed_639, fragment_unnamed_680));
					}
					else
					{
						bool fragment_unnamed_762 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_763 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_785 = fragment_unnamed_762 ? (fragment_input_5.x + fragment_uniform_buffer_0[48u].x) : fragment_input_5.x;
						float fragment_unnamed_786 = fragment_unnamed_762 ? (fragment_input_5.y + fragment_uniform_buffer_0[48u].y) : fragment_input_5.y;
						float fragment_unnamed_787 = fragment_unnamed_762 ? (fragment_input_5.z + fragment_uniform_buffer_0[48u].z) : fragment_input_5.z;
						float fragment_unnamed_891 = (asfloat(fragment_unnamed_763 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_787, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_785, fragment_unnamed_786 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_786)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_892 = (asfloat(fragment_unnamed_763 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_787, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_785, fragment_unnamed_786 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_787)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_905 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(((asfloat(fragment_unnamed_763 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_787, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_785, fragment_unnamed_786 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_785)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f, fragment_uniform_buffer_1[22u].z * 0.5f));
						float fragment_unnamed_932 = asfloat(1065353216u);
						fragment_unnamed_943 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_905 + 0.25f, fragment_unnamed_891 + 0.0f, fragment_unnamed_892 + 0.0f), 0.0f)), float4(fragment_unnamed_641, fragment_unnamed_640, fragment_unnamed_639, fragment_unnamed_932));
						fragment_unnamed_945 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_905, fragment_unnamed_891, fragment_unnamed_892), 0.0f)), float4(fragment_unnamed_641, fragment_unnamed_640, fragment_unnamed_639, fragment_unnamed_932));
						fragment_unnamed_947 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_905 + 0.5f, fragment_unnamed_891 + 0.0f, fragment_unnamed_892 + 0.0f), 0.0f)), float4(fragment_unnamed_641, fragment_unnamed_640, fragment_unnamed_639, fragment_unnamed_932));
					}
					fragment_unnamed_942 = fragment_unnamed_943;
					fragment_unnamed_944 = fragment_unnamed_945;
					fragment_unnamed_946 = fragment_unnamed_947;
				}
				else
				{
					fragment_unnamed_942 = asfloat(0u);
					fragment_unnamed_944 = asfloat(0u);
					fragment_unnamed_946 = asfloat(0u);
				}
				float fragment_unnamed_949 = ((-0.0f) - fragment_unnamed_638) + 1.0f;
				float fragment_unnamed_951 = ((-0.0f) - fragment_unnamed_490) + 1.0f;
				float fragment_unnamed_952 = fragment_unnamed_951 * fragment_unnamed_635;
				float fragment_unnamed_953 = fragment_unnamed_951 * fragment_unnamed_636;
				float fragment_unnamed_954 = fragment_unnamed_951 * fragment_unnamed_637;
				float fragment_unnamed_959 = mad(fragment_unnamed_490, fragment_unnamed_635 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_961 = mad(fragment_unnamed_490, fragment_unnamed_636 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_962 = mad(fragment_unnamed_490, fragment_unnamed_637 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_979 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_641, fragment_unnamed_640, fragment_unnamed_639), float3(fragment_unnamed_236 * fragment_unnamed_218, fragment_unnamed_236 * fragment_unnamed_225, fragment_unnamed_236 * fragment_unnamed_232)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_949, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_989 = clamp((max(fragment_unnamed_962, max(fragment_unnamed_961, fragment_unnamed_959)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_1013 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1018 = max(abs(fragment_unnamed_639), 0.0009765625f);
				float fragment_unnamed_1022 = (fragment_unnamed_639 >= 0.0f) ? fragment_unnamed_1018 : ((-0.0f) - fragment_unnamed_1018);
				float fragment_unnamed_1031 = 1.0f / max(dot(float3(abs(fragment_unnamed_641), abs(fragment_unnamed_640), abs(fragment_unnamed_1022)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1036 = clamp((-0.0f) - (fragment_unnamed_1031 * fragment_unnamed_1022), 0.0f, 1.0f);
				float fragment_unnamed_1039 = (-0.0f) - fragment_unnamed_1036;
				uint fragment_unnamed_1051 = uint(clamp(mad(mad(fragment_unnamed_641, fragment_unnamed_1031, ((fragment_unnamed_1031 * fragment_unnamed_641) >= 0.0f) ? fragment_unnamed_1036 : fragment_unnamed_1039), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1052 = uint(clamp(mad(mad(fragment_unnamed_640, fragment_unnamed_1031, ((fragment_unnamed_1031 * fragment_unnamed_640) >= 0.0f) ? fragment_unnamed_1036 : fragment_unnamed_1039), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1051 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1052 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1052 >> 8u) * 16u) + (fragment_unnamed_1051 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_959)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_961)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_962)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_1103 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1104 = fragment_unnamed_1103 * (fragment_unnamed_1013 * (fragment_unnamed_944 * (fragment_unnamed_979 * mad(fragment_unnamed_989, mad((-0.0f) - fragment_unnamed_635, fragment_unnamed_951, fragment_unnamed_959), fragment_unnamed_952))));
				float fragment_unnamed_1105 = fragment_unnamed_1103 * (fragment_unnamed_1013 * (fragment_unnamed_942 * (fragment_unnamed_979 * mad(fragment_unnamed_989, mad((-0.0f) - fragment_unnamed_636, fragment_unnamed_951, fragment_unnamed_961), fragment_unnamed_953))));
				float fragment_unnamed_1106 = fragment_unnamed_1103 * (fragment_unnamed_1013 * (fragment_unnamed_946 * (fragment_unnamed_979 * mad(fragment_unnamed_989, mad((-0.0f) - fragment_unnamed_637, fragment_unnamed_951, fragment_unnamed_962), fragment_unnamed_954))));
				bool fragment_unnamed_1115 = (((fragment_unnamed_1106 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1105 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1104 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1115 ? 2048.0f : fragment_unnamed_1104;
				fragment_output_3.y = fragment_unnamed_1115 ? 1.0f : fragment_unnamed_1105;
				fragment_output_3.z = fragment_unnamed_1115 ? 1024.0f : fragment_unnamed_1106;
				fragment_output_0.x = fragment_unnamed_952;
				fragment_output_0.y = fragment_unnamed_953;
				fragment_output_0.z = fragment_unnamed_954;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_unnamed_949;
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

				fragment_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				fragment_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				fragment_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				fragment_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

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

				fragment_uniform_buffer_2[6] = float4(_Normal_intensity, fragment_uniform_buffer_2[6][1], fragment_uniform_buffer_2[6][2], fragment_uniform_buffer_2[6][3]);

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
	}
	SubShader
	{
		Tags { "DisableBatching" = "False" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
		Pass
		{
			Name "IndirectDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "IndirectDXR" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 763635

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "VisibilityDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "VisibilityDXR" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 799556

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "ForwardDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "ForwardDXR" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 853718

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "GBufferDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "GBufferDXR" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 962493

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "DebugDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DebugDXR" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 1022318

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "PathTracingDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "PathTracingDXR" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 1056292

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
