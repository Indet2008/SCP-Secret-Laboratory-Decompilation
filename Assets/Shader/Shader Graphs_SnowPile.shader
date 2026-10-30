Shader "Shader Graphs/SnowPile"
{
	Properties
	{
		_Fade ("Fade", Float) = 1
		[NoScaleOffset] _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_BaseColorMap_1793653899_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_MaskMap_253529681_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_NormalMap_970140622_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_DetailMap_913208011_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_EmissiveColorMap_243130236_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_3ded33aee2eb46a5808e11424245bcc3_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[HideInInspector] _DiffusionProfileHash ("Float", Float) = 0
		[HideInInspector] _DiffusionProfileAsset ("Vector4", Vector) = (0,0,0,0)
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
		[Enum(Translucent, 5)] [HideInInspector] _MaterialID ("_MaterialID", Float) = 5
		[HideInInspector] _MaterialTypeMask ("_MaterialTypeMask", Float) = 32
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
			GpuProgramID 35335

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)
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


			static float4 fragment_input_1;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
			};

			void frag_main()
			{
			}

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
			}

			#endif // !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)


			#if defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)
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


			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			Texture2D<float4> _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
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

			void discard_cond(bool fragment_unnamed_191)
			{
				if (fragment_unnamed_191)
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
				uint fragment_unnamed_33[64];
				fragment_unnamed_33[0u] = 1030811889u;
				fragment_unnamed_33[4u] = 1057458056u;
				fragment_unnamed_33[8u] = 1043641525u;
				fragment_unnamed_33[12u] = 1059431846u;
				fragment_unnamed_33[16u] = 1061405636u;
				fragment_unnamed_33[20u] = 1050056343u;
				fragment_unnamed_33[24u] = 1063379426u;
				fragment_unnamed_33[28u] = 1054003923u;
				fragment_unnamed_33[32u] = 1047589105u;
				fragment_unnamed_33[36u] = 1060418741u;
				fragment_unnamed_33[40u] = 1039200497u;
				fragment_unnamed_33[44u] = 1058444951u;
				fragment_unnamed_33[48u] = 1064366321u;
				fragment_unnamed_33[52u] = 1055977713u;
				fragment_unnamed_33[56u] = 1062392531u;
				fragment_unnamed_33[60u] = 1052030133u;
				uint fragment_unnamed_128 = 2u & 31u;
				uint fragment_unnamed_134 = 0u & 31u;
				discard_cond(mad(((-0.0f) - asfloat(fragment_unnamed_33[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_128, min((2u & 31u), (32u - fragment_unnamed_128))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_134, min((2u & 31u), (32u - fragment_unnamed_134))) * 4u) + 0u])) + mad(fragment_uniform_buffer_1[9u].x, 0.5f, 1.5f), _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y).x + exp2(log2(fragment_uniform_buffer_1[9u].x) * 1.5f), (-0.0f) - (exp2(log2(((-0.0f) - fragment_uniform_buffer_1[9u].x) + 1.0f) * 10.0f) + 0.5f)) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
			}

			#endif // defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)


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
			GpuProgramID 309994

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
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

			#endif // !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


			#if defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
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


			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[10];
			Texture2D<float4> _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_282)
			{
				if (fragment_unnamed_282)
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
				uint fragment_unnamed_145 = 2u & 31u;
				uint fragment_unnamed_151 = 0u & 31u;
				discard_cond(mad(((-0.0f) - asfloat(fragment_unnamed_50[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_145, min((2u & 31u), (32u - fragment_unnamed_145))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_151, min((2u & 31u), (32u - fragment_unnamed_151))) * 4u) + 0u])) + mad(fragment_uniform_buffer_2[9u].x, 0.5f, 1.5f), _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x + exp2(log2(fragment_uniform_buffer_2[9u].x) * 1.5f), (-0.0f) - (exp2(log2(((-0.0f) - fragment_uniform_buffer_2[9u].x) + 1.0f) * 10.0f) + 0.5f)) < 0.0f);
				float fragment_unnamed_224 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_225 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_271 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_271 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_224) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_224)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_271 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_225) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_225)))) * (-0.5f));
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

				fragment_uniform_buffer_2[9] = float4(_Fade, fragment_uniform_buffer_2[9][1], fragment_uniform_buffer_2[9][2], fragment_uniform_buffer_2[9][3]);

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

			#endif // defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Fade;
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[13];
			Texture2D<float4> _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_376)
			{
				if (fragment_unnamed_376)
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
				uint fragment_unnamed_51[64];
				fragment_unnamed_51[0u] = 1030811889u;
				fragment_unnamed_51[4u] = 1057458056u;
				fragment_unnamed_51[8u] = 1043641525u;
				fragment_unnamed_51[12u] = 1059431846u;
				fragment_unnamed_51[16u] = 1061405636u;
				fragment_unnamed_51[20u] = 1050056343u;
				fragment_unnamed_51[24u] = 1063379426u;
				fragment_unnamed_51[28u] = 1054003923u;
				fragment_unnamed_51[32u] = 1047589105u;
				fragment_unnamed_51[36u] = 1060418741u;
				fragment_unnamed_51[40u] = 1039200497u;
				fragment_unnamed_51[44u] = 1058444951u;
				fragment_unnamed_51[48u] = 1064366321u;
				fragment_unnamed_51[52u] = 1055977713u;
				fragment_unnamed_51[56u] = 1062392531u;
				fragment_unnamed_51[60u] = 1052030133u;
				uint fragment_unnamed_146 = 2u & 31u;
				uint fragment_unnamed_152 = 0u & 31u;
				discard_cond(mad(((-0.0f) - asfloat(fragment_unnamed_51[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_146, min((2u & 31u), (32u - fragment_unnamed_146))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_152, min((2u & 31u), (32u - fragment_unnamed_152))) * 4u) + 0u])) + mad(fragment_uniform_buffer_2[9u].x, 0.5f, 1.5f), _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x + exp2(log2(fragment_uniform_buffer_2[9u].x) * 1.5f), (-0.0f) - (exp2(log2(((-0.0f) - fragment_uniform_buffer_2[9u].x) + 1.0f) * 10.0f) + 0.5f)) < 0.0f);
				float fragment_unnamed_225 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_226 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_272 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_272 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_225) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_225)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_272 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_226) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_226)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_299 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_320 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 1065353216u : asuint(fragment_uniform_buffer_2[12u]).z);
				float fragment_unnamed_321 = (fragment_unnamed_299 * fragment_input_9.x) * fragment_unnamed_320;
				float fragment_unnamed_322 = (fragment_unnamed_299 * fragment_input_9.y) * fragment_unnamed_320;
				float fragment_unnamed_323 = (fragment_unnamed_299 * fragment_input_9.z) * fragment_unnamed_320;
				float fragment_unnamed_332 = 1.0f / max(dot(float3(abs(fragment_unnamed_321), abs(fragment_unnamed_322), abs(fragment_unnamed_323)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_337 = clamp((-0.0f) - (fragment_unnamed_332 * fragment_unnamed_323), 0.0f, 1.0f);
				float fragment_unnamed_340 = (-0.0f) - fragment_unnamed_337;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_321, fragment_unnamed_332, ((fragment_unnamed_332 * fragment_unnamed_321) >= 0.0f) ? fragment_unnamed_337 : fragment_unnamed_340), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_322, fragment_unnamed_332, ((fragment_unnamed_332 * fragment_unnamed_322) >= 0.0f) ? fragment_unnamed_337 : fragment_unnamed_340), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_357 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_357, min((8u & 31u), (32u - fragment_unnamed_357)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[9] = float4(_Fade, fragment_uniform_buffer_2[9][1], fragment_uniform_buffer_2[9][2], fragment_uniform_buffer_2[9][3]);

				fragment_uniform_buffer_2[12] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)
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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)


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
			GpuProgramID 508290

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[18];
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
				if ((((0.0f < vertex_uniform_buffer_2[17u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[17] = float4(vertex_uniform_buffer_2[17][0], vertex_uniform_buffer_2[17][1], _RayTracing, vertex_uniform_buffer_2[17][3]);

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

			#endif // !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[18];
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
				if ((((0.0f < vertex_uniform_buffer_2[17u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[17] = float4(vertex_uniform_buffer_2[17][0], vertex_uniform_buffer_2[17][1], _RayTracing, vertex_uniform_buffer_2[17][3]);

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


			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float _Fade;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			Texture2D<float4> _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_199)
			{
				if (fragment_unnamed_199)
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
				uint fragment_unnamed_136 = 2u & 31u;
				uint fragment_unnamed_142 = 0u & 31u;
				discard_cond(mad(((-0.0f) - asfloat(fragment_unnamed_41[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_136, min((2u & 31u), (32u - fragment_unnamed_136))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_142, min((2u & 31u), (32u - fragment_unnamed_142))) * 4u) + 0u])) + mad(fragment_uniform_buffer_1[9u].x, 0.5f, 1.5f), _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x + exp2(log2(fragment_uniform_buffer_1[9u].x) * 1.5f), (-0.0f) - (exp2(log2(((-0.0f) - fragment_uniform_buffer_1[9u].x) + 1.0f) * 10.0f) + 0.5f)) < 0.0f);
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

			#endif // defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ProjectionParams;
			float4 _ScreenParams;
			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Fade;
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			static float4 fragment_uniform_buffer_2[13];
			Texture2D<float4> _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D;

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
				discard_cond(mad(((-0.0f) - asfloat(fragment_unnamed_48[(spvBitfieldInsert(spvBitfieldInsert(0u, uint((gl_FragCoord.x / fragment_uniform_buffer_0[61u].x) * fragment_uniform_buffer_0[61u].x), fragment_unnamed_143, min((2u & 31u), (32u - fragment_unnamed_143))), uint((((-0.0f) - (((fragment_uniform_buffer_0[58u].x < 0.0f) ? (((-0.0f) - gl_FragCoord.y) + fragment_uniform_buffer_0[61u].y) : gl_FragCoord.y) / fragment_uniform_buffer_0[61u].y)) + 1.0f) * fragment_uniform_buffer_0[61u].y), fragment_unnamed_149, min((2u & 31u), (32u - fragment_unnamed_149))) * 4u) + 0u])) + mad(fragment_uniform_buffer_2[9u].x, 0.5f, 1.5f), _SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_9ff95715b79947fbbe3d49d6baffb95a_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x + exp2(log2(fragment_uniform_buffer_2[9u].x) * 1.5f), (-0.0f) - (exp2(log2(((-0.0f) - fragment_uniform_buffer_2[9u].x) + 1.0f) * 10.0f) + 0.5f)) < 0.0f);
				float fragment_unnamed_222 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_243 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 1065353216u : asuint(fragment_uniform_buffer_2[12u]).z);
				float fragment_unnamed_244 = (fragment_unnamed_222 * fragment_input_7.x) * fragment_unnamed_243;
				float fragment_unnamed_245 = (fragment_unnamed_222 * fragment_input_7.y) * fragment_unnamed_243;
				float fragment_unnamed_246 = (fragment_unnamed_222 * fragment_input_7.z) * fragment_unnamed_243;
				float fragment_unnamed_255 = 1.0f / max(dot(float3(abs(fragment_unnamed_244), abs(fragment_unnamed_245), abs(fragment_unnamed_246)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_260 = clamp((-0.0f) - (fragment_unnamed_255 * fragment_unnamed_246), 0.0f, 1.0f);
				float fragment_unnamed_263 = (-0.0f) - fragment_unnamed_260;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_244, fragment_unnamed_255, ((fragment_unnamed_255 * fragment_unnamed_244) >= 0.0f) ? fragment_unnamed_260 : fragment_unnamed_263), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_245, fragment_unnamed_255, ((fragment_unnamed_255 * fragment_unnamed_245) >= 0.0f) ? fragment_unnamed_260 : fragment_unnamed_263), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_282 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_282, min((8u & 31u), (32u - fragment_unnamed_282)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[9] = float4(_Fade, fragment_uniform_buffer_2[9][1], fragment_uniform_buffer_2[9][2], fragment_uniform_buffer_2[9][3]);

				fragment_uniform_buffer_2[12] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

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

			#endif // defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)


			#if defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

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

			#endif // defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)


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
			GpuProgramID 575224

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature DECALS_3RT
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DOUBLESIDED_ON
			#pragma shader_feature _MATERIAL_FEATURE_TRANSMISSION


			#if !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_MATERIAL_FEATURE_TRANSMISSION)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[18];
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
				if ((((0.0f < vertex_uniform_buffer_2[17u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[17] = float4(vertex_uniform_buffer_2[17][0], vertex_uniform_buffer_2[17][1], _RayTracing, vertex_uniform_buffer_2[17][3]);

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

			#endif // !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_MATERIAL_FEATURE_TRANSMISSION)


			#if defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_MATERIAL_FEATURE_TRANSMISSION)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[18];
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
				if ((((0.0f < vertex_uniform_buffer_2[17u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[17] = float4(vertex_uniform_buffer_2[17][0], vertex_uniform_buffer_2[17][1], _RayTracing, vertex_uniform_buffer_2[17][3]);

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

			#endif // defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_MATERIAL_FEATURE_TRANSMISSION)


			#if defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && defined(_MATERIAL_FEATURE_TRANSMISSION)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _ReplaceDiffuseForIndirect;
			float4 _ShapeParamsAndMaxScatterDists[16];
			float4 _TransmissionTintsAndFresnel0[16];
			float4 _WorldScalesAndFilterRadiiAndThicknessRemaps[16];
			int4 _DiffusionProfileHashTable[16];
			int _DiffusionProfileCount;
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
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[13];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_BaseColorMap_1793653899_Texture2D;
			Texture2D<float4> _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_MaskMap_253529681_Texture2D;
			Texture2D<float4> _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_NormalMap_970140622_Texture2D;
			Texture2D<float4> _SampleTexture2D_3ded33aee2eb46a5808e11424245bcc3_Texture_1_Texture2D;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_BaseColorMap_1793653899_Texture2D;
			SamplerState sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_MaskMap_253529681_Texture2D;
			SamplerState sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_NormalMap_970140622_Texture2D;
			SamplerState sampler_SampleTexture2D_3ded33aee2eb46a5808e11424245bcc3_Texture_1_Texture2D;

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
				float fragment_unnamed_105 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_124 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_188 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_214 = asfloat(fragment_unnamed_188 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_221 = asfloat(fragment_unnamed_188 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_228 = asfloat(fragment_unnamed_188 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_232 = rsqrt(dot(float3(fragment_unnamed_214, fragment_unnamed_221, fragment_unnamed_228), float3(fragment_unnamed_214, fragment_unnamed_221, fragment_unnamed_228)));
				bool fragment_unnamed_239 = (gl_FrontFacing ? 4294967295u : 0u) != 0u;
				uint4 fragment_unnamed_243 = asuint(fragment_uniform_buffer_2[12u]);
				float fragment_unnamed_247 = asfloat(fragment_unnamed_239 ? 1065353216u : fragment_unnamed_243.z);
				float fragment_unnamed_249 = asfloat(fragment_unnamed_239 ? 1065353216u : fragment_unnamed_243.x);
				float fragment_unnamed_250 = (fragment_unnamed_105 * fragment_input_7.x) * fragment_unnamed_247;
				float fragment_unnamed_251 = (fragment_unnamed_105 * fragment_input_7.y) * fragment_unnamed_247;
				float fragment_unnamed_252 = (fragment_unnamed_105 * fragment_input_7.z) * fragment_unnamed_247;
				float fragment_unnamed_253 = (fragment_unnamed_105 * fragment_input_7.z) * fragment_unnamed_247;
				float4 fragment_unnamed_264 = _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_BaseColorMap_1793653899_Texture2D.SampleBias(sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_BaseColorMap_1793653899_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_267 = fragment_unnamed_264.x;
				float fragment_unnamed_268 = fragment_unnamed_264.y;
				float fragment_unnamed_269 = fragment_unnamed_264.z;
				float4 fragment_unnamed_278 = _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_MaskMap_253529681_Texture2D.SampleBias(sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_MaskMap_253529681_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_280 = fragment_unnamed_278.w;
				float fragment_unnamed_281 = fragment_unnamed_278.y;
				float4 fragment_unnamed_290 = _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_NormalMap_970140622_Texture2D.SampleBias(sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_NormalMap_970140622_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_296 = mad(fragment_unnamed_290.x * fragment_unnamed_290.w, 2.0f, -1.0f);
				float fragment_unnamed_299 = mad(fragment_unnamed_290.y, 2.0f, -1.0f);
				float fragment_unnamed_307 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_296, fragment_unnamed_299), float2(fragment_unnamed_296, fragment_unnamed_299)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float4 fragment_unnamed_317 = _SampleTexture2D_3ded33aee2eb46a5808e11424245bcc3_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_3ded33aee2eb46a5808e11424245bcc3_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_319 = fragment_unnamed_317.x;
				uint fragment_unnamed_329 = (asuint(fragment_uniform_buffer_2[1u]).x != 0u) ? asuint(fragment_uniform_buffer_2[1u]).x : 1078291154u;
				float fragment_unnamed_331 = fragment_unnamed_249 * fragment_unnamed_296;
				float fragment_unnamed_332 = fragment_unnamed_249 * fragment_unnamed_299;
				float fragment_unnamed_339 = mad(fragment_unnamed_307, fragment_unnamed_250, mad(fragment_unnamed_331, fragment_unnamed_105 * fragment_input_1.x, (fragment_unnamed_105 * (fragment_unnamed_124 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_332));
				float fragment_unnamed_340 = mad(fragment_unnamed_307, fragment_unnamed_251, mad(fragment_unnamed_331, fragment_unnamed_105 * fragment_input_1.y, (fragment_unnamed_105 * (fragment_unnamed_124 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_332));
				float fragment_unnamed_341 = mad(fragment_unnamed_307, fragment_unnamed_253, mad(fragment_unnamed_331, fragment_unnamed_105 * fragment_input_1.z, (fragment_unnamed_105 * (fragment_unnamed_124 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_332));
				float fragment_unnamed_346 = rsqrt(max(dot(float3(fragment_unnamed_339, fragment_unnamed_340, fragment_unnamed_341), float3(fragment_unnamed_339, fragment_unnamed_340, fragment_unnamed_341)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_347 = fragment_unnamed_346 * fragment_unnamed_339;
				float fragment_unnamed_348 = fragment_unnamed_346 * fragment_unnamed_340;
				float fragment_unnamed_349 = fragment_unnamed_346 * fragment_unnamed_341;
				float fragment_unnamed_413;
				float fragment_unnamed_414;
				float fragment_unnamed_415;
				float fragment_unnamed_416;
				float fragment_unnamed_417;
				float fragment_unnamed_418;
				float fragment_unnamed_419;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_360 = uint(gl_FragCoord.x);
					uint fragment_unnamed_361 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_362 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_360, fragment_unnamed_361, 0u), 0u));
					float fragment_unnamed_368 = fragment_unnamed_362.w;
					float4 fragment_unnamed_369 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_360, fragment_unnamed_361, 0u), 0u));
					float fragment_unnamed_374 = fragment_unnamed_369.w;
					float4 fragment_unnamed_375 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_360, fragment_unnamed_361, 0u), 0u));
					bool fragment_unnamed_385 = fragment_unnamed_374 < 1.0f;
					float fragment_unnamed_386 = mad(fragment_unnamed_347, fragment_unnamed_374, fragment_unnamed_249 * mad(fragment_unnamed_369.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_387 = mad(fragment_unnamed_348, fragment_unnamed_374, fragment_unnamed_249 * mad(fragment_unnamed_369.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_388 = mad(fragment_unnamed_349, fragment_unnamed_374, mad(fragment_unnamed_369.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_393 = rsqrt(max(dot(float3(fragment_unnamed_386, fragment_unnamed_387, fragment_unnamed_388), float3(fragment_unnamed_386, fragment_unnamed_387, fragment_unnamed_388)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_413 = mad(fragment_unnamed_267, fragment_unnamed_368, fragment_unnamed_362.x);
					fragment_unnamed_414 = mad(fragment_unnamed_268, fragment_unnamed_368, fragment_unnamed_362.y);
					fragment_unnamed_415 = mad(fragment_unnamed_269, fragment_unnamed_368, fragment_unnamed_362.z);
					fragment_unnamed_416 = mad(fragment_unnamed_280, fragment_unnamed_375.w, fragment_unnamed_375.z);
					fragment_unnamed_417 = asfloat(fragment_unnamed_385 ? asuint(fragment_unnamed_393 * fragment_unnamed_388) : asuint(fragment_unnamed_349));
					fragment_unnamed_418 = asfloat(fragment_unnamed_385 ? asuint(fragment_unnamed_393 * fragment_unnamed_387) : asuint(fragment_unnamed_348));
					fragment_unnamed_419 = asfloat(fragment_unnamed_385 ? asuint(fragment_unnamed_393 * fragment_unnamed_386) : asuint(fragment_unnamed_347));
				}
				else
				{
					fragment_unnamed_413 = fragment_unnamed_267;
					fragment_unnamed_414 = fragment_unnamed_268;
					fragment_unnamed_415 = fragment_unnamed_269;
					fragment_unnamed_416 = fragment_unnamed_280;
					fragment_unnamed_417 = fragment_unnamed_349;
					fragment_unnamed_418 = fragment_unnamed_348;
					fragment_unnamed_419 = fragment_unnamed_347;
				}
				float fragment_unnamed_423 = max(dot(float3(fragment_unnamed_419, fragment_unnamed_418, fragment_unnamed_417), float3(fragment_unnamed_232 * fragment_unnamed_214, fragment_unnamed_232 * fragment_unnamed_221, fragment_unnamed_232 * fragment_unnamed_228)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_426 = ((-0.0f) - fragment_unnamed_416) + 1.0f;
				fragment_output_2.x = clamp((fragment_unnamed_281 + exp2(log2(abs(fragment_unnamed_281 + fragment_unnamed_423)) * exp2(mad(fragment_unnamed_426 * fragment_unnamed_426, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_455 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_456 = fragment_unnamed_455.x;
				float fragment_unnamed_830;
				float fragment_unnamed_832;
				float fragment_unnamed_834;
				float fragment_unnamed_836;
				float fragment_unnamed_838;
				float fragment_unnamed_840;
				if (((((fragment_unnamed_456 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_456 != 0u) ? 4294967295u : 0u)) & ((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u)) == 0u)
				{
					float fragment_unnamed_471 = (-0.0f) - fragment_unnamed_250;
					float fragment_unnamed_472 = (-0.0f) - fragment_unnamed_251;
					float fragment_unnamed_473 = (-0.0f) - fragment_unnamed_253;
					float fragment_unnamed_831;
					float fragment_unnamed_833;
					float fragment_unnamed_835;
					float fragment_unnamed_837;
					float fragment_unnamed_839;
					float fragment_unnamed_841;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_485 = asfloat(1065353216u);
						float fragment_unnamed_514 = fragment_unnamed_418 * fragment_unnamed_419;
						float fragment_unnamed_515 = fragment_unnamed_417 * fragment_unnamed_418;
						float fragment_unnamed_516 = fragment_unnamed_417 * fragment_unnamed_417;
						float fragment_unnamed_517 = fragment_unnamed_419 * fragment_unnamed_417;
						float fragment_unnamed_550 = mad(fragment_unnamed_419, fragment_unnamed_419, (-0.0f) - (fragment_unnamed_418 * fragment_unnamed_418));
						float fragment_unnamed_563 = asfloat(1065353216u);
						float fragment_unnamed_591 = fragment_unnamed_251 * fragment_unnamed_250;
						float fragment_unnamed_592 = fragment_unnamed_253 * fragment_unnamed_251;
						float fragment_unnamed_593 = fragment_unnamed_252 * fragment_unnamed_252;
						float fragment_unnamed_594 = fragment_unnamed_250 * fragment_unnamed_253;
						float fragment_unnamed_624 = mad(fragment_unnamed_250, fragment_unnamed_250, (-0.0f) - (fragment_unnamed_251 * fragment_unnamed_251));
						fragment_unnamed_831 = mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_624, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_591, fragment_unnamed_592, fragment_unnamed_593, fragment_unnamed_594))) + dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_471, fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_563));
						fragment_unnamed_833 = mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_624, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_591, fragment_unnamed_592, fragment_unnamed_593, fragment_unnamed_594))) + dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_471, fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_563));
						fragment_unnamed_835 = mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_624, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_591, fragment_unnamed_592, fragment_unnamed_593, fragment_unnamed_594))) + dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_471, fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_563));
						fragment_unnamed_837 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_419, fragment_unnamed_418, fragment_unnamed_417, fragment_unnamed_485)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_550, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_514, fragment_unnamed_515, fragment_unnamed_516, fragment_unnamed_517)));
						fragment_unnamed_839 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_419, fragment_unnamed_418, fragment_unnamed_417, fragment_unnamed_485)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_550, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_514, fragment_unnamed_515, fragment_unnamed_516, fragment_unnamed_517)));
						fragment_unnamed_841 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_419, fragment_unnamed_418, fragment_unnamed_417, fragment_unnamed_485)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_550, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_514, fragment_unnamed_515, fragment_unnamed_516, fragment_unnamed_517)));
					}
					else
					{
						bool fragment_unnamed_639 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_640 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_662 = fragment_unnamed_639 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_663 = fragment_unnamed_639 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_664 = fragment_unnamed_639 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_768 = (asfloat(fragment_unnamed_640 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_664, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_662, fragment_unnamed_663 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_663)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_769 = (asfloat(fragment_unnamed_640 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_664, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_662, fragment_unnamed_663 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_664)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_783 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(((asfloat(fragment_unnamed_640 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_664, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_662, fragment_unnamed_663 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_662)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f, fragment_uniform_buffer_1[22u].z * 0.5f));
						float4 fragment_unnamed_786 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_783, fragment_unnamed_768, fragment_unnamed_769), 0.0f);
						float fragment_unnamed_788 = fragment_unnamed_786.x;
						float4 fragment_unnamed_795 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_783 + 0.25f, fragment_unnamed_768 + 0.0f, fragment_unnamed_769 + 0.0f), 0.0f);
						float fragment_unnamed_797 = fragment_unnamed_795.x;
						float4 fragment_unnamed_804 = unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_783 + 0.5f, fragment_unnamed_768 + 0.0f, fragment_unnamed_769 + 0.0f), 0.0f);
						float fragment_unnamed_806 = fragment_unnamed_804.x;
						float fragment_unnamed_810 = asfloat(1065353216u);
						float fragment_unnamed_820 = asfloat(1065353216u);
						fragment_unnamed_831 = dot(float4(fragment_unnamed_797, fragment_unnamed_795.yzw), float4(fragment_unnamed_471, fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_820));
						fragment_unnamed_833 = dot(float4(fragment_unnamed_806, fragment_unnamed_804.yzw), float4(fragment_unnamed_471, fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_820));
						fragment_unnamed_835 = dot(float4(fragment_unnamed_788, fragment_unnamed_786.yzw), float4(fragment_unnamed_471, fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_820));
						fragment_unnamed_837 = dot(float4(fragment_unnamed_788, fragment_unnamed_786.yzw), float4(fragment_unnamed_419, fragment_unnamed_418, fragment_unnamed_417, fragment_unnamed_810));
						fragment_unnamed_839 = dot(float4(fragment_unnamed_797, fragment_unnamed_795.yzw), float4(fragment_unnamed_419, fragment_unnamed_418, fragment_unnamed_417, fragment_unnamed_810));
						fragment_unnamed_841 = dot(float4(fragment_unnamed_806, fragment_unnamed_804.yzw), float4(fragment_unnamed_419, fragment_unnamed_418, fragment_unnamed_417, fragment_unnamed_810));
					}
					fragment_unnamed_830 = fragment_unnamed_831;
					fragment_unnamed_832 = fragment_unnamed_833;
					fragment_unnamed_834 = fragment_unnamed_835;
					fragment_unnamed_836 = fragment_unnamed_837;
					fragment_unnamed_838 = fragment_unnamed_839;
					fragment_unnamed_840 = fragment_unnamed_841;
				}
				else
				{
					fragment_unnamed_830 = asfloat(0u);
					fragment_unnamed_832 = asfloat(0u);
					fragment_unnamed_834 = asfloat(0u);
					fragment_unnamed_836 = asfloat(0u);
					fragment_unnamed_838 = asfloat(0u);
					fragment_unnamed_840 = asfloat(0u);
				}
				float fragment_unnamed_857;
				if (fragment_unnamed_329 != 0u)
				{
					float fragment_unnamed_843 = asfloat(0u);
					float fragment_unnamed_844 = asfloat(0u);
					float fragment_unnamed_858;
					float fragment_unnamed_846 = fragment_unnamed_843;
					float fragment_unnamed_848 = fragment_unnamed_844;
					for (;;)
					{
						if (asuint(fragment_unnamed_848) >= asuint(fragment_uniform_buffer_0[209u]).w)
						{
							fragment_unnamed_858 = fragment_unnamed_846;
							break;
						}
						else
						{
							if (!(fragment_unnamed_329 == asuint(fragment_uniform_buffer_0[asuint(fragment_unnamed_848) + 193u]).x))
							{
								fragment_unnamed_846 = asfloat(0u);
								fragment_unnamed_848 = asfloat(asuint(fragment_unnamed_848) + 1u);
								continue;
							}
							fragment_unnamed_858 = fragment_unnamed_848;
							break;
						}
					}
					fragment_unnamed_857 = fragment_unnamed_858;
				}
				else
				{
					fragment_unnamed_857 = asfloat(0u);
				}
				float fragment_unnamed_871 = mad(fragment_uniform_buffer_0[asuint(fragment_unnamed_857) + 161u].w, fragment_unnamed_319, fragment_uniform_buffer_0[asuint(fragment_unnamed_857) + 161u].z) * (-0.4808983504772186279296875f);
				uint fragment_unnamed_874 = asuint(fragment_unnamed_857) + 129u;
				float fragment_unnamed_884 = exp2(fragment_unnamed_871 * fragment_uniform_buffer_0[fragment_unnamed_874].x);
				float fragment_unnamed_885 = exp2(fragment_unnamed_871 * fragment_uniform_buffer_0[fragment_unnamed_874].y);
				float fragment_unnamed_886 = exp2(fragment_unnamed_871 * fragment_uniform_buffer_0[fragment_unnamed_874].z);
				uint fragment_unnamed_895 = asuint(fragment_unnamed_857) + 145u;
				float fragment_unnamed_914 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_423), 0.984375f, 0.0078125f), mad(fragment_unnamed_426, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_932 = clamp(((-0.20000000298023223876953125f) + fragment_uniform_buffer_0[asuint(fragment_unnamed_857) + 145u].w) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				uint fragment_unnamed_937 = asuint(fragment_unnamed_857) + 145u;
				float fragment_unnamed_961 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_966 = max(abs(fragment_unnamed_417), 0.0009765625f);
				float fragment_unnamed_970 = (fragment_unnamed_417 >= 0.0f) ? fragment_unnamed_966 : ((-0.0f) - fragment_unnamed_966);
				float fragment_unnamed_979 = 1.0f / max(dot(float3(abs(fragment_unnamed_419), abs(fragment_unnamed_418), abs(fragment_unnamed_970)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_984 = clamp((-0.0f) - (fragment_unnamed_979 * fragment_unnamed_970), 0.0f, 1.0f);
				float fragment_unnamed_987 = (-0.0f) - fragment_unnamed_984;
				uint fragment_unnamed_999 = uint(clamp(mad(mad(fragment_unnamed_419, fragment_unnamed_979, ((fragment_unnamed_979 * fragment_unnamed_419) >= 0.0f) ? fragment_unnamed_984 : fragment_unnamed_987), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1000 = uint(clamp(mad(mad(fragment_unnamed_418, fragment_unnamed_979, ((fragment_unnamed_979 * fragment_unnamed_418) >= 0.0f) ? fragment_unnamed_984 : fragment_unnamed_987), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_999 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1000 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1000 >> 8u) * 16u) + (fragment_unnamed_999 >> 8u)) * 0.0039215688593685626983642578125f;
				float fragment_unnamed_1043;
				if (fragment_unnamed_329 != 0u)
				{
					float fragment_unnamed_1028 = asfloat(0u);
					float fragment_unnamed_1029 = asfloat(0u);
					float fragment_unnamed_1044;
					float fragment_unnamed_1033 = fragment_unnamed_1029;
					float fragment_unnamed_1035 = fragment_unnamed_1028;
					for (;;)
					{
						if (asuint(fragment_unnamed_1033) >= asuint(fragment_uniform_buffer_0[209u]).w)
						{
							fragment_unnamed_1044 = fragment_unnamed_1035;
							break;
						}
						else
						{
							if (!(fragment_unnamed_329 == asuint(fragment_uniform_buffer_0[asuint(fragment_unnamed_1033) + 193u]).x))
							{
								fragment_unnamed_1033 = asfloat(asuint(fragment_unnamed_1033) + 1u);
								fragment_unnamed_1035 = asfloat(0u);
								continue;
							}
							fragment_unnamed_1044 = fragment_unnamed_1033;
							break;
						}
					}
					fragment_unnamed_1043 = fragment_unnamed_1044;
				}
				else
				{
					fragment_unnamed_1043 = asfloat(0u);
				}
				float fragment_unnamed_1046 = float(asuint(fragment_unnamed_1043));
				fragment_output_2.z = mad(fragment_unnamed_1046, 0.062745101749897003173828125f, 0.0588235296308994293212890625f);
				float fragment_unnamed_1062 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1063 = fragment_unnamed_1062 * (fragment_unnamed_281 * (fragment_unnamed_961 * (mad(fragment_unnamed_834, (fragment_unnamed_884 * mad(fragment_unnamed_884, fragment_unnamed_884, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_895].x, fragment_unnamed_836) * (fragment_unnamed_914 * mad(fragment_unnamed_932, ((-0.0f) - fragment_unnamed_413) + fragment_uniform_buffer_0[fragment_unnamed_937].w, fragment_unnamed_413)))));
				float fragment_unnamed_1064 = fragment_unnamed_1062 * (fragment_unnamed_281 * (fragment_unnamed_961 * (mad(fragment_unnamed_830, (fragment_unnamed_885 * mad(fragment_unnamed_885, fragment_unnamed_885, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_895].y, fragment_unnamed_838) * (fragment_unnamed_914 * mad(fragment_unnamed_932, ((-0.0f) - fragment_unnamed_414) + fragment_uniform_buffer_0[fragment_unnamed_937].w, fragment_unnamed_414)))));
				float fragment_unnamed_1065 = fragment_unnamed_1062 * (fragment_unnamed_281 * (fragment_unnamed_961 * (mad(fragment_unnamed_832, (fragment_unnamed_886 * mad(fragment_unnamed_886, fragment_unnamed_886, 3.0f)) * fragment_uniform_buffer_0[fragment_unnamed_895].z, fragment_unnamed_840) * (fragment_unnamed_914 * mad(fragment_unnamed_932, ((-0.0f) - fragment_unnamed_415) + fragment_uniform_buffer_0[fragment_unnamed_937].w, fragment_unnamed_415)))));
				bool fragment_unnamed_1078 = (((fragment_unnamed_1065 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1064 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1063 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1078 ? asfloat(1157627904u) : fragment_unnamed_1063;
				fragment_output_3.y = fragment_unnamed_1078 ? fragment_unnamed_281 : fragment_unnamed_1064;
				fragment_output_3.z = fragment_unnamed_1078 ? asfloat(1149239296u) : fragment_unnamed_1065;
				fragment_output_0.x = fragment_unnamed_413;
				fragment_output_0.y = fragment_unnamed_414;
				fragment_output_0.z = fragment_unnamed_415;
				fragment_output_0.w = fragment_unnamed_1046 * 0.062745101749897003173828125f;
				fragment_output_1.w = fragment_unnamed_426;
				fragment_output_2.y = fragment_unnamed_319;
				fragment_output_2.w = 0.007843137718737125396728515625f;
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

				fragment_uniform_buffer_2[12] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

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

			#endif // defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && defined(_MATERIAL_FEATURE_TRANSMISSION)


			#if defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(_MATERIAL_FEATURE_TRANSMISSION)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float _GlobalMipBias;
			int _ReflectionsMode;
			float _ProbeExposureScale;
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
			Texture2D<float4> _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_BaseColorMap_1793653899_Texture2D;
			Texture2D<float4> _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_MaskMap_253529681_Texture2D;
			Texture2D<float4> _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_NormalMap_970140622_Texture2D;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_BaseColorMap_1793653899_Texture2D;
			SamplerState sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_MaskMap_253529681_Texture2D;
			SamplerState sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_NormalMap_970140622_Texture2D;

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
				float4 fragment_unnamed_234 = _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_BaseColorMap_1793653899_Texture2D.SampleBias(sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_BaseColorMap_1793653899_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_237 = fragment_unnamed_234.x;
				float fragment_unnamed_238 = fragment_unnamed_234.y;
				float fragment_unnamed_239 = fragment_unnamed_234.z;
				float4 fragment_unnamed_248 = _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_MaskMap_253529681_Texture2D.SampleBias(sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_MaskMap_253529681_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_250 = fragment_unnamed_248.w;
				float fragment_unnamed_251 = fragment_unnamed_248.y;
				float4 fragment_unnamed_260 = _HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_NormalMap_970140622_Texture2D.SampleBias(sampler_HDRPLit_6ba91f6a86724818a88c3ca38f771c1d_NormalMap_970140622_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_266 = mad(fragment_unnamed_260.x * fragment_unnamed_260.w, 2.0f, -1.0f);
				float fragment_unnamed_269 = mad(fragment_unnamed_260.y, 2.0f, -1.0f);
				float fragment_unnamed_277 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_266, fragment_unnamed_269), float2(fragment_unnamed_266, fragment_unnamed_269)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_285 = mad(fragment_unnamed_277, fragment_unnamed_93 * fragment_input_7.x, mad(fragment_unnamed_266, fragment_unnamed_93 * fragment_input_1.x, (fragment_unnamed_93 * (fragment_unnamed_113 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_269));
				float fragment_unnamed_286 = mad(fragment_unnamed_277, fragment_unnamed_93 * fragment_input_7.y, mad(fragment_unnamed_266, fragment_unnamed_93 * fragment_input_1.y, (fragment_unnamed_93 * (fragment_unnamed_113 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_269));
				float fragment_unnamed_287 = mad(fragment_unnamed_277, fragment_unnamed_93 * fragment_input_7.z, mad(fragment_unnamed_266, fragment_unnamed_93 * fragment_input_1.z, (fragment_unnamed_93 * (fragment_unnamed_113 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_269));
				float fragment_unnamed_292 = rsqrt(max(dot(float3(fragment_unnamed_285, fragment_unnamed_286, fragment_unnamed_287), float3(fragment_unnamed_285, fragment_unnamed_286, fragment_unnamed_287)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_293 = fragment_unnamed_292 * fragment_unnamed_285;
				float fragment_unnamed_294 = fragment_unnamed_292 * fragment_unnamed_286;
				float fragment_unnamed_295 = fragment_unnamed_292 * fragment_unnamed_287;
				float fragment_unnamed_357;
				float fragment_unnamed_358;
				float fragment_unnamed_359;
				float fragment_unnamed_360;
				float fragment_unnamed_361;
				float fragment_unnamed_362;
				float fragment_unnamed_363;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_306 = uint(gl_FragCoord.x);
					uint fragment_unnamed_307 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_308 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_306, fragment_unnamed_307, 0u), 0u));
					float fragment_unnamed_314 = fragment_unnamed_308.w;
					float4 fragment_unnamed_315 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_306, fragment_unnamed_307, 0u), 0u));
					float fragment_unnamed_320 = fragment_unnamed_315.w;
					float4 fragment_unnamed_321 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_306, fragment_unnamed_307, 0u), 0u));
					bool fragment_unnamed_329 = fragment_unnamed_320 < 1.0f;
					float fragment_unnamed_330 = mad(fragment_unnamed_293, fragment_unnamed_320, mad(fragment_unnamed_315.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_331 = mad(fragment_unnamed_294, fragment_unnamed_320, mad(fragment_unnamed_315.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_332 = mad(fragment_unnamed_295, fragment_unnamed_320, mad(fragment_unnamed_315.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_337 = rsqrt(max(dot(float3(fragment_unnamed_330, fragment_unnamed_331, fragment_unnamed_332), float3(fragment_unnamed_330, fragment_unnamed_331, fragment_unnamed_332)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_357 = mad(fragment_unnamed_237, fragment_unnamed_314, fragment_unnamed_308.x);
					fragment_unnamed_358 = mad(fragment_unnamed_238, fragment_unnamed_314, fragment_unnamed_308.y);
					fragment_unnamed_359 = mad(fragment_unnamed_239, fragment_unnamed_314, fragment_unnamed_308.z);
					fragment_unnamed_360 = mad(fragment_unnamed_250, fragment_unnamed_321.w, fragment_unnamed_321.z);
					fragment_unnamed_361 = asfloat(fragment_unnamed_329 ? asuint(fragment_unnamed_337 * fragment_unnamed_332) : asuint(fragment_unnamed_295));
					fragment_unnamed_362 = asfloat(fragment_unnamed_329 ? asuint(fragment_unnamed_337 * fragment_unnamed_331) : asuint(fragment_unnamed_294));
					fragment_unnamed_363 = asfloat(fragment_unnamed_329 ? asuint(fragment_unnamed_337 * fragment_unnamed_330) : asuint(fragment_unnamed_293));
				}
				else
				{
					fragment_unnamed_357 = fragment_unnamed_237;
					fragment_unnamed_358 = fragment_unnamed_238;
					fragment_unnamed_359 = fragment_unnamed_239;
					fragment_unnamed_360 = fragment_unnamed_250;
					fragment_unnamed_361 = fragment_unnamed_295;
					fragment_unnamed_362 = fragment_unnamed_294;
					fragment_unnamed_363 = fragment_unnamed_293;
				}
				float fragment_unnamed_367 = max(dot(float3(fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_361), float3(fragment_unnamed_220 * fragment_unnamed_202, fragment_unnamed_220 * fragment_unnamed_209, fragment_unnamed_220 * fragment_unnamed_216)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_370 = ((-0.0f) - fragment_unnamed_360) + 1.0f;
				uint4 fragment_unnamed_397 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_398 = fragment_unnamed_397.x;
				float fragment_unnamed_685;
				float fragment_unnamed_687;
				float fragment_unnamed_689;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_398 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_398 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_686;
					float fragment_unnamed_688;
					float fragment_unnamed_690;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_422 = asfloat(1065353216u);
						float fragment_unnamed_452 = fragment_unnamed_362 * fragment_unnamed_363;
						float fragment_unnamed_453 = fragment_unnamed_361 * fragment_unnamed_362;
						float fragment_unnamed_454 = fragment_unnamed_361 * fragment_unnamed_361;
						float fragment_unnamed_455 = fragment_unnamed_363 * fragment_unnamed_361;
						float fragment_unnamed_488 = mad(fragment_unnamed_363, fragment_unnamed_363, (-0.0f) - (fragment_unnamed_362 * fragment_unnamed_362));
						fragment_unnamed_686 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_361, fragment_unnamed_422)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_488, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_452, fragment_unnamed_453, fragment_unnamed_454, fragment_unnamed_455)));
						fragment_unnamed_688 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_361, fragment_unnamed_422)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_488, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_452, fragment_unnamed_453, fragment_unnamed_454, fragment_unnamed_455)));
						fragment_unnamed_690 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_361, fragment_unnamed_422)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_488, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_452, fragment_unnamed_453, fragment_unnamed_454, fragment_unnamed_455)));
					}
					else
					{
						bool fragment_unnamed_504 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_505 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_527 = fragment_unnamed_504 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_528 = fragment_unnamed_504 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_529 = fragment_unnamed_504 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_633 = (asfloat(fragment_unnamed_505 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_529, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_527, fragment_unnamed_528 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_528)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_634 = (asfloat(fragment_unnamed_505 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_529, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_527, fragment_unnamed_528 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_529)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_648 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_505 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_529, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_527, fragment_unnamed_528 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_527)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_675 = asfloat(1065353216u);
						fragment_unnamed_686 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_648, fragment_unnamed_633, fragment_unnamed_634), 0.0f)), float4(fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_361, fragment_unnamed_675));
						fragment_unnamed_688 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_648 + 0.25f, fragment_unnamed_633 + 0.0f, fragment_unnamed_634 + 0.0f), 0.0f)), float4(fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_361, fragment_unnamed_675));
						fragment_unnamed_690 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_648 + 0.5f, fragment_unnamed_633 + 0.0f, fragment_unnamed_634 + 0.0f), 0.0f)), float4(fragment_unnamed_363, fragment_unnamed_362, fragment_unnamed_361, fragment_unnamed_675));
					}
					fragment_unnamed_685 = fragment_unnamed_686;
					fragment_unnamed_687 = fragment_unnamed_688;
					fragment_unnamed_689 = fragment_unnamed_690;
				}
				else
				{
					fragment_unnamed_685 = asfloat(0u);
					fragment_unnamed_687 = asfloat(0u);
					fragment_unnamed_689 = asfloat(0u);
				}
				float fragment_unnamed_700 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_367), 0.984375f, 0.0078125f), mad(fragment_unnamed_370, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_715 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_720 = max(abs(fragment_unnamed_361), 0.0009765625f);
				float fragment_unnamed_724 = (fragment_unnamed_361 >= 0.0f) ? fragment_unnamed_720 : ((-0.0f) - fragment_unnamed_720);
				float fragment_unnamed_733 = 1.0f / max(dot(float3(abs(fragment_unnamed_363), abs(fragment_unnamed_362), abs(fragment_unnamed_724)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_738 = clamp((-0.0f) - (fragment_unnamed_733 * fragment_unnamed_724), 0.0f, 1.0f);
				float fragment_unnamed_741 = (-0.0f) - fragment_unnamed_738;
				uint fragment_unnamed_753 = uint(clamp(mad(mad(fragment_unnamed_363, fragment_unnamed_733, ((fragment_unnamed_733 * fragment_unnamed_363) >= 0.0f) ? fragment_unnamed_738 : fragment_unnamed_741), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_754 = uint(clamp(mad(mad(fragment_unnamed_362, fragment_unnamed_733, ((fragment_unnamed_733 * fragment_unnamed_362) >= 0.0f) ? fragment_unnamed_738 : fragment_unnamed_741), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_753 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_754 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_754 >> 8u) * 16u) + (fragment_unnamed_753 >> 8u)) * 0.0039215688593685626983642578125f;
				float fragment_unnamed_785 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_786 = fragment_unnamed_785 * (fragment_unnamed_251 * (fragment_unnamed_715 * ((fragment_unnamed_357 * fragment_unnamed_700) * fragment_unnamed_685)));
				float fragment_unnamed_787 = fragment_unnamed_785 * (fragment_unnamed_251 * (fragment_unnamed_715 * ((fragment_unnamed_358 * fragment_unnamed_700) * fragment_unnamed_687)));
				float fragment_unnamed_788 = fragment_unnamed_785 * (fragment_unnamed_251 * (fragment_unnamed_715 * ((fragment_unnamed_359 * fragment_unnamed_700) * fragment_unnamed_689)));
				bool fragment_unnamed_801 = (((fragment_unnamed_788 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_787 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_786 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_801 ? asfloat(1157627904u) : fragment_unnamed_786;
				fragment_output_3.y = fragment_unnamed_801 ? fragment_unnamed_251 : fragment_unnamed_787;
				fragment_output_3.z = fragment_unnamed_801 ? asfloat(1149239296u) : fragment_unnamed_788;
				fragment_output_0.x = fragment_unnamed_357;
				fragment_output_0.y = fragment_unnamed_358;
				fragment_output_0.z = fragment_unnamed_359;
				fragment_output_0.w = clamp((fragment_unnamed_251 + exp2(log2(abs(fragment_unnamed_251 + fragment_unnamed_367)) * exp2(mad(fragment_unnamed_370 * fragment_unnamed_370, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				fragment_output_1.w = fragment_unnamed_370;
				fragment_output_2.x = 0.2209163606166839599609375f;
				fragment_output_2.y = 0.2209163606166839599609375f;
				fragment_output_2.z = 0.2209163606166839599609375f;
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

			#endif // defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(_MATERIAL_FEATURE_TRANSMISSION)


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
			GpuProgramID 756765

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
			GpuProgramID 848320

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
			GpuProgramID 887162

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
			GpuProgramID 982488

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
			GpuProgramID 1009750

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
			GpuProgramID 1087823

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
