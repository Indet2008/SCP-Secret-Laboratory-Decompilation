Shader "Shader Graphs/Scp3114Reveal"
{
	Properties
	{
		[NoScaleOffset] _BaseColorMap ("BaseColorMap", 2D) = "white" {}
		[NoScaleOffset] _NormalMap ("NormalMap", 2D) = "white" {}
		[NoScaleOffset] _EmissionMap ("EmissionMap", 2D) = "white" {}
		[HDR] _Emission ("Emission", Color) = (0,0,0,0)
		_Progress ("Progress", Range(0, 1)) = 0.5
		[ToggleUI] _UseMaskMap ("UseMaskMap", Float) = 1
		[NoScaleOffset] _MaskMap ("MaskMap", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_9ccede5c759f47328be7a7de0be3904b_DetailMap_913208011_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
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
			GpuProgramID 50205

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
			float _Progress;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[10];
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
				float vertex_unnamed_49 = floor(vertex_input_3.x);
				float vertex_unnamed_50 = floor(vertex_input_3.y);
				float vertex_unnamed_83 = frac(sin(dot(float2(vertex_unnamed_49, vertex_unnamed_50), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_84 = frac(sin(dot(float2(vertex_unnamed_49 + 0.0f, vertex_unnamed_50 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_96 = frac(vertex_input_3.x);
				float vertex_unnamed_97 = frac(vertex_input_3.y);
				float vertex_unnamed_106 = mad((-0.0f) - vertex_unnamed_96, 2.0f, 3.0f) * (vertex_unnamed_96 * vertex_unnamed_96);
				float vertex_unnamed_109 = mad(vertex_unnamed_106, ((-0.0f) - vertex_unnamed_83) + frac(sin(dot(float2(vertex_unnamed_49 + 1.0f, vertex_unnamed_50 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_83);
				float vertex_unnamed_117 = vertex_input_3.x * 0.5f;
				float vertex_unnamed_119 = vertex_input_3.y * 0.5f;
				float vertex_unnamed_120 = vertex_input_3.x * 0.25f;
				float vertex_unnamed_122 = vertex_input_3.y * 0.25f;
				float vertex_unnamed_123 = floor(vertex_unnamed_117);
				float vertex_unnamed_124 = floor(vertex_unnamed_119);
				float vertex_unnamed_125 = floor(vertex_unnamed_120);
				float vertex_unnamed_126 = floor(vertex_unnamed_122);
				float vertex_unnamed_127 = frac(vertex_unnamed_117);
				float vertex_unnamed_128 = frac(vertex_unnamed_119);
				float vertex_unnamed_129 = frac(vertex_unnamed_120);
				float vertex_unnamed_130 = frac(vertex_unnamed_122);
				float vertex_unnamed_162 = frac(sin(dot(float2(vertex_unnamed_123 + 0.0f, vertex_unnamed_124 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_177 = mad((-0.0f) - vertex_unnamed_127, 2.0f, 3.0f) * (vertex_unnamed_127 * vertex_unnamed_127);
				float vertex_unnamed_179 = mad((-0.0f) - vertex_unnamed_129, 2.0f, 3.0f) * (vertex_unnamed_129 * vertex_unnamed_129);
				float vertex_unnamed_187 = frac(sin(dot(float2(vertex_unnamed_123, vertex_unnamed_124), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_190 = mad(vertex_unnamed_177, ((-0.0f) - vertex_unnamed_187) + frac(sin(dot(float2(vertex_unnamed_123 + 1.0f, vertex_unnamed_124 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_187);
				float vertex_unnamed_206 = frac(sin(dot(float2(vertex_unnamed_125, vertex_unnamed_126), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_209 = mad(vertex_unnamed_179, ((-0.0f) - vertex_unnamed_206) + frac(sin(dot(float2(vertex_unnamed_125 + 1.0f, vertex_unnamed_126 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_206);
				float vertex_unnamed_221 = frac(sin(dot(float2(vertex_unnamed_125 + 0.0f, vertex_unnamed_126 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_228 = mad(mad(mad((-0.0f) - vertex_unnamed_130, 2.0f, 3.0f) * (vertex_unnamed_130 * vertex_unnamed_130), ((-0.0f) - vertex_unnamed_209) + mad(vertex_unnamed_179, ((-0.0f) - vertex_unnamed_221) + frac(sin(dot(float2(vertex_unnamed_125 + 1.0f, vertex_unnamed_126 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_221), vertex_unnamed_209), 0.5f, mad(mad(mad((-0.0f) - vertex_unnamed_97, 2.0f, 3.0f) * (vertex_unnamed_97 * vertex_unnamed_97), ((-0.0f) - vertex_unnamed_109) + mad(vertex_unnamed_106, ((-0.0f) - vertex_unnamed_84) + frac(sin(dot(float2(vertex_unnamed_49 + 1.0f, vertex_unnamed_50 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_84), vertex_unnamed_109), 0.125f, mad(mad((-0.0f) - vertex_unnamed_128, 2.0f, 3.0f) * (vertex_unnamed_128 * vertex_unnamed_128), ((-0.0f) - vertex_unnamed_190) + mad(vertex_unnamed_177, ((-0.0f) - vertex_unnamed_162) + frac(sin(dot(float2(vertex_unnamed_123 + 1.0f, vertex_unnamed_124 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_162), vertex_unnamed_190) * 0.25f));
				float vertex_unnamed_253 = mad(vertex_unnamed_228 * (vertex_input_1.x * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.x);
				float vertex_unnamed_255 = mad(vertex_unnamed_228 * (vertex_input_1.y * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.y);
				float vertex_unnamed_256 = mad(vertex_unnamed_228 * (vertex_input_1.z * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.z);
				float vertex_unnamed_291 = asfloat(1065353216u);
				float vertex_unnamed_293 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_253, vertex_unnamed_255, vertex_unnamed_256, vertex_unnamed_291));
				float vertex_unnamed_322 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_253, vertex_unnamed_255, vertex_unnamed_256, vertex_unnamed_291));
				float vertex_unnamed_351 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_253, vertex_unnamed_255, vertex_unnamed_256, vertex_unnamed_291));
				vertex_output_5.x = vertex_unnamed_322;
				vertex_output_5.y = vertex_unnamed_293;
				vertex_output_5.z = vertex_unnamed_351;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_351, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_322, vertex_unnamed_293 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_351, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_322, vertex_unnamed_293 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_351, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_322, vertex_unnamed_293 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_351, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_322, vertex_unnamed_293 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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

				vertex_uniform_buffer_2[9] = float4(vertex_uniform_buffer_2[9][0], _Progress, vertex_uniform_buffer_2[9][2], vertex_uniform_buffer_2[9][3]);

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

			#endif // !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)


			#if defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float _Progress;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[10];
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
				float vertex_unnamed_49 = floor(vertex_input_3.x);
				float vertex_unnamed_50 = floor(vertex_input_3.y);
				float vertex_unnamed_83 = frac(sin(dot(float2(vertex_unnamed_49, vertex_unnamed_50), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_84 = frac(sin(dot(float2(vertex_unnamed_49 + 0.0f, vertex_unnamed_50 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_96 = frac(vertex_input_3.x);
				float vertex_unnamed_97 = frac(vertex_input_3.y);
				float vertex_unnamed_106 = mad((-0.0f) - vertex_unnamed_96, 2.0f, 3.0f) * (vertex_unnamed_96 * vertex_unnamed_96);
				float vertex_unnamed_109 = mad(vertex_unnamed_106, ((-0.0f) - vertex_unnamed_83) + frac(sin(dot(float2(vertex_unnamed_49 + 1.0f, vertex_unnamed_50 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_83);
				float vertex_unnamed_117 = vertex_input_3.x * 0.5f;
				float vertex_unnamed_119 = vertex_input_3.y * 0.5f;
				float vertex_unnamed_120 = vertex_input_3.x * 0.25f;
				float vertex_unnamed_122 = vertex_input_3.y * 0.25f;
				float vertex_unnamed_123 = floor(vertex_unnamed_117);
				float vertex_unnamed_124 = floor(vertex_unnamed_119);
				float vertex_unnamed_125 = floor(vertex_unnamed_120);
				float vertex_unnamed_126 = floor(vertex_unnamed_122);
				float vertex_unnamed_127 = frac(vertex_unnamed_117);
				float vertex_unnamed_128 = frac(vertex_unnamed_119);
				float vertex_unnamed_129 = frac(vertex_unnamed_120);
				float vertex_unnamed_130 = frac(vertex_unnamed_122);
				float vertex_unnamed_162 = frac(sin(dot(float2(vertex_unnamed_123 + 0.0f, vertex_unnamed_124 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_177 = mad((-0.0f) - vertex_unnamed_127, 2.0f, 3.0f) * (vertex_unnamed_127 * vertex_unnamed_127);
				float vertex_unnamed_179 = mad((-0.0f) - vertex_unnamed_129, 2.0f, 3.0f) * (vertex_unnamed_129 * vertex_unnamed_129);
				float vertex_unnamed_187 = frac(sin(dot(float2(vertex_unnamed_123, vertex_unnamed_124), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_190 = mad(vertex_unnamed_177, ((-0.0f) - vertex_unnamed_187) + frac(sin(dot(float2(vertex_unnamed_123 + 1.0f, vertex_unnamed_124 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_187);
				float vertex_unnamed_206 = frac(sin(dot(float2(vertex_unnamed_125, vertex_unnamed_126), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_209 = mad(vertex_unnamed_179, ((-0.0f) - vertex_unnamed_206) + frac(sin(dot(float2(vertex_unnamed_125 + 1.0f, vertex_unnamed_126 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_206);
				float vertex_unnamed_221 = frac(sin(dot(float2(vertex_unnamed_125 + 0.0f, vertex_unnamed_126 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_228 = mad(mad(mad((-0.0f) - vertex_unnamed_130, 2.0f, 3.0f) * (vertex_unnamed_130 * vertex_unnamed_130), ((-0.0f) - vertex_unnamed_209) + mad(vertex_unnamed_179, ((-0.0f) - vertex_unnamed_221) + frac(sin(dot(float2(vertex_unnamed_125 + 1.0f, vertex_unnamed_126 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_221), vertex_unnamed_209), 0.5f, mad(mad(mad((-0.0f) - vertex_unnamed_97, 2.0f, 3.0f) * (vertex_unnamed_97 * vertex_unnamed_97), ((-0.0f) - vertex_unnamed_109) + mad(vertex_unnamed_106, ((-0.0f) - vertex_unnamed_84) + frac(sin(dot(float2(vertex_unnamed_49 + 1.0f, vertex_unnamed_50 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_84), vertex_unnamed_109), 0.125f, mad(mad((-0.0f) - vertex_unnamed_128, 2.0f, 3.0f) * (vertex_unnamed_128 * vertex_unnamed_128), ((-0.0f) - vertex_unnamed_190) + mad(vertex_unnamed_177, ((-0.0f) - vertex_unnamed_162) + frac(sin(dot(float2(vertex_unnamed_123 + 1.0f, vertex_unnamed_124 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_162), vertex_unnamed_190) * 0.25f));
				float vertex_unnamed_253 = mad(vertex_unnamed_228 * (vertex_input_1.x * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.x);
				float vertex_unnamed_255 = mad(vertex_unnamed_228 * (vertex_input_1.y * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.y);
				float vertex_unnamed_256 = mad(vertex_unnamed_228 * (vertex_input_1.z * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.z);
				float vertex_unnamed_291 = asfloat(1065353216u);
				float vertex_unnamed_293 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_253, vertex_unnamed_255, vertex_unnamed_256, vertex_unnamed_291));
				float vertex_unnamed_322 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_253, vertex_unnamed_255, vertex_unnamed_256, vertex_unnamed_291));
				float vertex_unnamed_351 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_253, vertex_unnamed_255, vertex_unnamed_256, vertex_unnamed_291));
				vertex_output_5.x = vertex_unnamed_322;
				vertex_output_5.y = vertex_unnamed_293;
				vertex_output_5.z = vertex_unnamed_351;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_351, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_322, vertex_unnamed_293 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_351, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_322, vertex_unnamed_293 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_351, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_322, vertex_unnamed_293 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_351, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_322, vertex_unnamed_293 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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

				vertex_uniform_buffer_2[9] = float4(vertex_uniform_buffer_2[9][0], _Progress, vertex_uniform_buffer_2[9][2], vertex_uniform_buffer_2[9][3]);

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
			float _Progress;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_82)
			{
				if (fragment_unnamed_82)
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
				discard_cond(((_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_1.x + fragment_input_1.x, fragment_input_1.y + fragment_input_1.y), fragment_uniform_buffer_0[86u].y).x + mad(fragment_uniform_buffer_1[9u].y + (-1.0f), -1.10000002384185791015625f, -0.60000002384185791015625f)) + (-0.5f)) < 0.0f);
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
			GpuProgramID 285208

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
			float _Progress;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[10];
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
				float vertex_unnamed_54 = floor(vertex_input_3.x);
				float vertex_unnamed_55 = floor(vertex_input_3.y);
				float vertex_unnamed_60 = frac(vertex_input_3.x);
				float vertex_unnamed_61 = frac(vertex_input_3.y);
				float vertex_unnamed_71 = mad((-0.0f) - vertex_unnamed_60, 2.0f, 3.0f) * (vertex_unnamed_60 * vertex_unnamed_60);
				float vertex_unnamed_95 = frac(sin(dot(float2(vertex_unnamed_54, vertex_unnamed_55), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_107 = frac(sin(dot(float2(vertex_unnamed_54 + 0.0f, vertex_unnamed_55 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_111 = mad(vertex_unnamed_71, ((-0.0f) - vertex_unnamed_95) + frac(sin(dot(float2(vertex_unnamed_54 + 1.0f, vertex_unnamed_55 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_95);
				float vertex_unnamed_122 = vertex_input_3.x * 0.5f;
				float vertex_unnamed_124 = vertex_input_3.y * 0.5f;
				float vertex_unnamed_125 = vertex_input_3.x * 0.25f;
				float vertex_unnamed_127 = vertex_input_3.y * 0.25f;
				float vertex_unnamed_128 = floor(vertex_unnamed_122);
				float vertex_unnamed_129 = floor(vertex_unnamed_124);
				float vertex_unnamed_130 = floor(vertex_unnamed_125);
				float vertex_unnamed_131 = floor(vertex_unnamed_127);
				float vertex_unnamed_132 = frac(vertex_unnamed_122);
				float vertex_unnamed_133 = frac(vertex_unnamed_124);
				float vertex_unnamed_134 = frac(vertex_unnamed_125);
				float vertex_unnamed_135 = frac(vertex_unnamed_127);
				float vertex_unnamed_148 = mad((-0.0f) - vertex_unnamed_132, 2.0f, 3.0f) * (vertex_unnamed_132 * vertex_unnamed_132);
				float vertex_unnamed_150 = mad((-0.0f) - vertex_unnamed_134, 2.0f, 3.0f) * (vertex_unnamed_134 * vertex_unnamed_134);
				float vertex_unnamed_175 = frac(sin(dot(float2(vertex_unnamed_128, vertex_unnamed_129), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_177 = frac(sin(dot(float2(vertex_unnamed_128 + 0.0f, vertex_unnamed_129 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_186 = mad(vertex_unnamed_148, ((-0.0f) - vertex_unnamed_175) + frac(sin(dot(float2(vertex_unnamed_128 + 1.0f, vertex_unnamed_129 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_175);
				float vertex_unnamed_215 = frac(sin(dot(float2(vertex_unnamed_130, vertex_unnamed_131), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_217 = frac(sin(dot(float2(vertex_unnamed_130 + 0.0f, vertex_unnamed_131 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_226 = mad(vertex_unnamed_150, ((-0.0f) - vertex_unnamed_215) + frac(sin(dot(float2(vertex_unnamed_130 + 1.0f, vertex_unnamed_131 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_215);
				float vertex_unnamed_233 = mad(mad(mad((-0.0f) - vertex_unnamed_135, 2.0f, 3.0f) * (vertex_unnamed_135 * vertex_unnamed_135), ((-0.0f) - vertex_unnamed_226) + mad(vertex_unnamed_150, ((-0.0f) - vertex_unnamed_217) + frac(sin(dot(float2(vertex_unnamed_130 + 1.0f, vertex_unnamed_131 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_217), vertex_unnamed_226), 0.5f, mad(mad(mad((-0.0f) - vertex_unnamed_61, 2.0f, 3.0f) * (vertex_unnamed_61 * vertex_unnamed_61), ((-0.0f) - vertex_unnamed_111) + mad(vertex_unnamed_71, ((-0.0f) - vertex_unnamed_107) + frac(sin(dot(float2(vertex_unnamed_54 + 1.0f, vertex_unnamed_55 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_107), vertex_unnamed_111), 0.125f, mad(mad((-0.0f) - vertex_unnamed_133, 2.0f, 3.0f) * (vertex_unnamed_133 * vertex_unnamed_133), ((-0.0f) - vertex_unnamed_186) + mad(vertex_unnamed_148, ((-0.0f) - vertex_unnamed_177) + frac(sin(dot(float2(vertex_unnamed_128 + 1.0f, vertex_unnamed_129 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_177), vertex_unnamed_186) * 0.25f));
				float vertex_unnamed_249 = vertex_unnamed_233 * (vertex_input_1.x * vertex_uniform_buffer_2[9u].y);
				float vertex_unnamed_250 = vertex_unnamed_233 * (vertex_input_1.y * vertex_uniform_buffer_2[9u].y);
				float vertex_unnamed_251 = vertex_unnamed_233 * (vertex_input_1.z * vertex_uniform_buffer_2[9u].y);
				float vertex_unnamed_258 = mad(vertex_unnamed_249, 0.100000001490116119384765625f, vertex_input_0.x);
				float vertex_unnamed_260 = mad(vertex_unnamed_250, 0.100000001490116119384765625f, vertex_input_0.y);
				float vertex_unnamed_261 = mad(vertex_unnamed_251, 0.100000001490116119384765625f, vertex_input_0.z);
				float vertex_unnamed_296 = asfloat(1065353216u);
				float vertex_unnamed_298 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_258, vertex_unnamed_260, vertex_unnamed_261, vertex_unnamed_296));
				float vertex_unnamed_316 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_258, vertex_unnamed_260, vertex_unnamed_261, vertex_unnamed_296));
				float vertex_unnamed_334 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_258, vertex_unnamed_260, vertex_unnamed_261, vertex_unnamed_296));
				float vertex_unnamed_349 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_364 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_379 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_387 = rsqrt(max(dot(float3(vertex_unnamed_349, vertex_unnamed_364, vertex_unnamed_379), float3(vertex_unnamed_349, vertex_unnamed_364, vertex_unnamed_379)), 1.1754943508222875079687365372222e-38f));
				vertex_output_9.x = vertex_unnamed_387 * vertex_unnamed_349;
				vertex_output_9.y = vertex_unnamed_387 * vertex_unnamed_364;
				vertex_output_9.z = vertex_unnamed_387 * vertex_unnamed_379;
				float vertex_unnamed_422 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_423 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_424 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_429 = rsqrt(max(dot(float3(vertex_unnamed_422, vertex_unnamed_423, vertex_unnamed_424), float3(vertex_unnamed_422, vertex_unnamed_423, vertex_unnamed_424)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_429 * vertex_unnamed_422;
				vertex_output_3.y = vertex_unnamed_429 * vertex_unnamed_423;
				vertex_output_3.z = vertex_unnamed_429 * vertex_unnamed_424;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_334, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_334, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_334, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_334, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_334, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_334, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_334, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_535 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_551 = mad(vertex_unnamed_249, 0.100000001490116119384765625f, vertex_unnamed_535 ? vertex_input_7.x : vertex_input_0.x);
					float vertex_unnamed_552 = mad(vertex_unnamed_250, 0.100000001490116119384765625f, vertex_unnamed_535 ? vertex_input_7.y : vertex_input_0.y);
					float vertex_unnamed_553 = mad(vertex_unnamed_251, 0.100000001490116119384765625f, vertex_unnamed_535 ? vertex_input_7.z : vertex_input_0.z);
					float vertex_unnamed_587 = asfloat(1065353216u);
					float vertex_unnamed_588 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_551, vertex_unnamed_552, vertex_unnamed_553, vertex_unnamed_587));
					float vertex_unnamed_606 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_551, vertex_unnamed_552, vertex_unnamed_553, vertex_unnamed_587));
					float vertex_unnamed_624 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_551, vertex_unnamed_552, vertex_unnamed_553, vertex_unnamed_587));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_624, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_588, vertex_unnamed_606 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_624, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_588, vertex_unnamed_606 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_624, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_588, vertex_unnamed_606 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
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
				vertex_output_8.x = vertex_unnamed_298;
				vertex_output_8.y = vertex_unnamed_316;
				vertex_output_8.z = vertex_unnamed_334;
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

				vertex_uniform_buffer_2[9] = float4(vertex_uniform_buffer_2[9][0], _Progress, vertex_uniform_buffer_2[9][2], vertex_uniform_buffer_2[9][3]);

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
				float fragment_unnamed_59 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_60 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_109 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_109 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_59) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_59)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_109 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_60) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_60)))) * (-0.5f));
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
			float _Progress;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[10];
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
				float vertex_unnamed_54 = floor(vertex_input_3.x);
				float vertex_unnamed_55 = floor(vertex_input_3.y);
				float vertex_unnamed_60 = frac(vertex_input_3.x);
				float vertex_unnamed_61 = frac(vertex_input_3.y);
				float vertex_unnamed_71 = mad((-0.0f) - vertex_unnamed_60, 2.0f, 3.0f) * (vertex_unnamed_60 * vertex_unnamed_60);
				float vertex_unnamed_95 = frac(sin(dot(float2(vertex_unnamed_54, vertex_unnamed_55), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_107 = frac(sin(dot(float2(vertex_unnamed_54 + 0.0f, vertex_unnamed_55 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_111 = mad(vertex_unnamed_71, ((-0.0f) - vertex_unnamed_95) + frac(sin(dot(float2(vertex_unnamed_54 + 1.0f, vertex_unnamed_55 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_95);
				float vertex_unnamed_122 = vertex_input_3.x * 0.5f;
				float vertex_unnamed_124 = vertex_input_3.y * 0.5f;
				float vertex_unnamed_125 = vertex_input_3.x * 0.25f;
				float vertex_unnamed_127 = vertex_input_3.y * 0.25f;
				float vertex_unnamed_128 = floor(vertex_unnamed_122);
				float vertex_unnamed_129 = floor(vertex_unnamed_124);
				float vertex_unnamed_130 = floor(vertex_unnamed_125);
				float vertex_unnamed_131 = floor(vertex_unnamed_127);
				float vertex_unnamed_132 = frac(vertex_unnamed_122);
				float vertex_unnamed_133 = frac(vertex_unnamed_124);
				float vertex_unnamed_134 = frac(vertex_unnamed_125);
				float vertex_unnamed_135 = frac(vertex_unnamed_127);
				float vertex_unnamed_148 = mad((-0.0f) - vertex_unnamed_132, 2.0f, 3.0f) * (vertex_unnamed_132 * vertex_unnamed_132);
				float vertex_unnamed_150 = mad((-0.0f) - vertex_unnamed_134, 2.0f, 3.0f) * (vertex_unnamed_134 * vertex_unnamed_134);
				float vertex_unnamed_175 = frac(sin(dot(float2(vertex_unnamed_128, vertex_unnamed_129), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_177 = frac(sin(dot(float2(vertex_unnamed_128 + 0.0f, vertex_unnamed_129 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_186 = mad(vertex_unnamed_148, ((-0.0f) - vertex_unnamed_175) + frac(sin(dot(float2(vertex_unnamed_128 + 1.0f, vertex_unnamed_129 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_175);
				float vertex_unnamed_215 = frac(sin(dot(float2(vertex_unnamed_130, vertex_unnamed_131), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_217 = frac(sin(dot(float2(vertex_unnamed_130 + 0.0f, vertex_unnamed_131 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
				float vertex_unnamed_226 = mad(vertex_unnamed_150, ((-0.0f) - vertex_unnamed_215) + frac(sin(dot(float2(vertex_unnamed_130 + 1.0f, vertex_unnamed_131 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_215);
				float vertex_unnamed_233 = mad(mad(mad((-0.0f) - vertex_unnamed_135, 2.0f, 3.0f) * (vertex_unnamed_135 * vertex_unnamed_135), ((-0.0f) - vertex_unnamed_226) + mad(vertex_unnamed_150, ((-0.0f) - vertex_unnamed_217) + frac(sin(dot(float2(vertex_unnamed_130 + 1.0f, vertex_unnamed_131 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_217), vertex_unnamed_226), 0.5f, mad(mad(mad((-0.0f) - vertex_unnamed_61, 2.0f, 3.0f) * (vertex_unnamed_61 * vertex_unnamed_61), ((-0.0f) - vertex_unnamed_111) + mad(vertex_unnamed_71, ((-0.0f) - vertex_unnamed_107) + frac(sin(dot(float2(vertex_unnamed_54 + 1.0f, vertex_unnamed_55 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_107), vertex_unnamed_111), 0.125f, mad(mad((-0.0f) - vertex_unnamed_133, 2.0f, 3.0f) * (vertex_unnamed_133 * vertex_unnamed_133), ((-0.0f) - vertex_unnamed_186) + mad(vertex_unnamed_148, ((-0.0f) - vertex_unnamed_177) + frac(sin(dot(float2(vertex_unnamed_128 + 1.0f, vertex_unnamed_129 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_177), vertex_unnamed_186) * 0.25f));
				float vertex_unnamed_249 = vertex_unnamed_233 * (vertex_input_1.x * vertex_uniform_buffer_2[9u].y);
				float vertex_unnamed_250 = vertex_unnamed_233 * (vertex_input_1.y * vertex_uniform_buffer_2[9u].y);
				float vertex_unnamed_251 = vertex_unnamed_233 * (vertex_input_1.z * vertex_uniform_buffer_2[9u].y);
				float vertex_unnamed_258 = mad(vertex_unnamed_249, 0.100000001490116119384765625f, vertex_input_0.x);
				float vertex_unnamed_260 = mad(vertex_unnamed_250, 0.100000001490116119384765625f, vertex_input_0.y);
				float vertex_unnamed_261 = mad(vertex_unnamed_251, 0.100000001490116119384765625f, vertex_input_0.z);
				float vertex_unnamed_296 = asfloat(1065353216u);
				float vertex_unnamed_298 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_258, vertex_unnamed_260, vertex_unnamed_261, vertex_unnamed_296));
				float vertex_unnamed_316 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_258, vertex_unnamed_260, vertex_unnamed_261, vertex_unnamed_296));
				float vertex_unnamed_334 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_258, vertex_unnamed_260, vertex_unnamed_261, vertex_unnamed_296));
				float vertex_unnamed_349 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_364 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_379 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_387 = rsqrt(max(dot(float3(vertex_unnamed_349, vertex_unnamed_364, vertex_unnamed_379), float3(vertex_unnamed_349, vertex_unnamed_364, vertex_unnamed_379)), 1.1754943508222875079687365372222e-38f));
				vertex_output_9.x = vertex_unnamed_387 * vertex_unnamed_349;
				vertex_output_9.y = vertex_unnamed_387 * vertex_unnamed_364;
				vertex_output_9.z = vertex_unnamed_387 * vertex_unnamed_379;
				float vertex_unnamed_422 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_423 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_424 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_429 = rsqrt(max(dot(float3(vertex_unnamed_422, vertex_unnamed_423, vertex_unnamed_424), float3(vertex_unnamed_422, vertex_unnamed_423, vertex_unnamed_424)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_429 * vertex_unnamed_422;
				vertex_output_3.y = vertex_unnamed_429 * vertex_unnamed_423;
				vertex_output_3.z = vertex_unnamed_429 * vertex_unnamed_424;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_334, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_334, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_334, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_334, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_334, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_334, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_334, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_298, vertex_unnamed_316 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_535 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_551 = mad(vertex_unnamed_249, 0.100000001490116119384765625f, vertex_unnamed_535 ? vertex_input_7.x : vertex_input_0.x);
					float vertex_unnamed_552 = mad(vertex_unnamed_250, 0.100000001490116119384765625f, vertex_unnamed_535 ? vertex_input_7.y : vertex_input_0.y);
					float vertex_unnamed_553 = mad(vertex_unnamed_251, 0.100000001490116119384765625f, vertex_unnamed_535 ? vertex_input_7.z : vertex_input_0.z);
					float vertex_unnamed_587 = asfloat(1065353216u);
					float vertex_unnamed_588 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_551, vertex_unnamed_552, vertex_unnamed_553, vertex_unnamed_587));
					float vertex_unnamed_606 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_551, vertex_unnamed_552, vertex_unnamed_553, vertex_unnamed_587));
					float vertex_unnamed_624 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_551, vertex_unnamed_552, vertex_unnamed_553, vertex_unnamed_587));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_624, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_588, vertex_unnamed_606 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_624, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_588, vertex_unnamed_606 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_624, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_588, vertex_unnamed_606 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
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
				vertex_output_8.x = vertex_unnamed_298;
				vertex_output_8.y = vertex_unnamed_316;
				vertex_output_8.z = vertex_unnamed_334;
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

				vertex_uniform_buffer_2[9] = float4(vertex_uniform_buffer_2[9][0], _Progress, vertex_uniform_buffer_2[9][2], vertex_uniform_buffer_2[9][3]);

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
			float _Progress;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[10];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_169)
			{
				if (fragment_unnamed_169)
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
				discard_cond(((_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_4.x + fragment_input_4.x, fragment_input_4.y + fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x + mad(fragment_uniform_buffer_2[9u].y + (-1.0f), -1.10000002384185791015625f, -0.60000002384185791015625f)) + (-0.5f)) < 0.0f);
				float fragment_unnamed_111 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_112 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_158 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_158 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_111) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_111)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_158 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_112) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_112)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[9] = float4(fragment_uniform_buffer_2[9][0], _Progress, fragment_uniform_buffer_2[9][2], fragment_uniform_buffer_2[9][3]);

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

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Progress;
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[13];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;

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
				bool gl_FrontFacing : SV_IsFrontFace;
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

			void discard_cond(bool fragment_unnamed_268)
			{
				if (fragment_unnamed_268)
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
				discard_cond(((_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_4.x + fragment_input_4.x, fragment_input_4.y + fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x + mad(fragment_uniform_buffer_2[9u].y + (-1.0f), -1.10000002384185791015625f, -0.60000002384185791015625f)) + (-0.5f)) < 0.0f);
				float fragment_unnamed_112 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_113 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_159 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_159 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_112) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_112)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_159 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_113) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_113)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_186 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_209 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 1065353216u : asuint(fragment_uniform_buffer_2[12u]).z);
				float fragment_unnamed_210 = (fragment_unnamed_186 * fragment_input_9.x) * fragment_unnamed_209;
				float fragment_unnamed_211 = (fragment_unnamed_186 * fragment_input_9.y) * fragment_unnamed_209;
				float fragment_unnamed_212 = (fragment_unnamed_186 * fragment_input_9.z) * fragment_unnamed_209;
				float fragment_unnamed_221 = 1.0f / max(dot(float3(abs(fragment_unnamed_210), abs(fragment_unnamed_211), abs(fragment_unnamed_212)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_226 = clamp((-0.0f) - (fragment_unnamed_221 * fragment_unnamed_212), 0.0f, 1.0f);
				float fragment_unnamed_229 = (-0.0f) - fragment_unnamed_226;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_210, fragment_unnamed_221, ((fragment_unnamed_221 * fragment_unnamed_210) >= 0.0f) ? fragment_unnamed_226 : fragment_unnamed_229), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_211, fragment_unnamed_221, ((fragment_unnamed_221 * fragment_unnamed_211) >= 0.0f) ? fragment_unnamed_226 : fragment_unnamed_229), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_248 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_248, min((8u & 31u), (32u - fragment_unnamed_248)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[9] = float4(fragment_uniform_buffer_2[9][0], _Progress, fragment_uniform_buffer_2[9][2], fragment_uniform_buffer_2[9][3]);

				fragment_uniform_buffer_2[12] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

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
				float fragment_unnamed_60 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_61 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_110 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_110 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_60) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_60)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_110 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_61) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_61)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_138 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_146 = fragment_unnamed_138 * fragment_input_9.x;
				float fragment_unnamed_147 = fragment_unnamed_138 * fragment_input_9.y;
				float fragment_unnamed_148 = fragment_unnamed_138 * fragment_input_9.z;
				float fragment_unnamed_157 = 1.0f / max(dot(float3(abs(fragment_unnamed_146), abs(fragment_unnamed_147), abs(fragment_unnamed_148)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_162 = clamp((-0.0f) - (fragment_unnamed_157 * fragment_unnamed_148), 0.0f, 1.0f);
				float fragment_unnamed_165 = (-0.0f) - fragment_unnamed_162;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_146, fragment_unnamed_157, ((fragment_unnamed_157 * fragment_unnamed_146) >= 0.0f) ? fragment_unnamed_162 : fragment_unnamed_165), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_147, fragment_unnamed_157, ((fragment_unnamed_157 * fragment_unnamed_147) >= 0.0f) ? fragment_unnamed_162 : fragment_unnamed_165), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_185 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_185, min((8u & 31u), (32u - fragment_unnamed_185)))) * 0.0039215688593685626983642578125f;
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
			GpuProgramID 472654

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
			float _Progress;
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
					float vertex_unnamed_104 = floor(vertex_input_3.x);
					float vertex_unnamed_105 = floor(vertex_input_3.y);
					float vertex_unnamed_110 = frac(vertex_input_3.x);
					float vertex_unnamed_111 = frac(vertex_input_3.y);
					float vertex_unnamed_121 = mad((-0.0f) - vertex_unnamed_110, 2.0f, 3.0f) * (vertex_unnamed_110 * vertex_unnamed_110);
					float vertex_unnamed_144 = frac(sin(dot(float2(vertex_unnamed_104, vertex_unnamed_105), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_156 = frac(sin(dot(float2(vertex_unnamed_104 + 0.0f, vertex_unnamed_105 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_160 = mad(vertex_unnamed_121, ((-0.0f) - vertex_unnamed_144) + frac(sin(dot(float2(vertex_unnamed_104 + 1.0f, vertex_unnamed_105 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_144);
					float vertex_unnamed_171 = vertex_input_3.x * 0.5f;
					float vertex_unnamed_173 = vertex_input_3.y * 0.5f;
					float vertex_unnamed_174 = vertex_input_3.x * 0.25f;
					float vertex_unnamed_176 = vertex_input_3.y * 0.25f;
					float vertex_unnamed_177 = floor(vertex_unnamed_171);
					float vertex_unnamed_178 = floor(vertex_unnamed_173);
					float vertex_unnamed_179 = floor(vertex_unnamed_174);
					float vertex_unnamed_180 = floor(vertex_unnamed_176);
					float vertex_unnamed_181 = frac(vertex_unnamed_171);
					float vertex_unnamed_182 = frac(vertex_unnamed_173);
					float vertex_unnamed_183 = frac(vertex_unnamed_174);
					float vertex_unnamed_184 = frac(vertex_unnamed_176);
					float vertex_unnamed_197 = mad((-0.0f) - vertex_unnamed_181, 2.0f, 3.0f) * (vertex_unnamed_181 * vertex_unnamed_181);
					float vertex_unnamed_199 = mad((-0.0f) - vertex_unnamed_183, 2.0f, 3.0f) * (vertex_unnamed_183 * vertex_unnamed_183);
					float vertex_unnamed_224 = frac(sin(dot(float2(vertex_unnamed_177, vertex_unnamed_178), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_226 = frac(sin(dot(float2(vertex_unnamed_177 + 0.0f, vertex_unnamed_178 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_235 = mad(vertex_unnamed_197, ((-0.0f) - vertex_unnamed_224) + frac(sin(dot(float2(vertex_unnamed_177 + 1.0f, vertex_unnamed_178 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_224);
					float vertex_unnamed_264 = frac(sin(dot(float2(vertex_unnamed_179, vertex_unnamed_180), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_266 = frac(sin(dot(float2(vertex_unnamed_179 + 0.0f, vertex_unnamed_180 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_275 = mad(vertex_unnamed_199, ((-0.0f) - vertex_unnamed_264) + frac(sin(dot(float2(vertex_unnamed_179 + 1.0f, vertex_unnamed_180 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_264);
					float vertex_unnamed_282 = mad(mad(mad((-0.0f) - vertex_unnamed_184, 2.0f, 3.0f) * (vertex_unnamed_184 * vertex_unnamed_184), ((-0.0f) - vertex_unnamed_275) + mad(vertex_unnamed_199, ((-0.0f) - vertex_unnamed_266) + frac(sin(dot(float2(vertex_unnamed_179 + 1.0f, vertex_unnamed_180 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_266), vertex_unnamed_275), 0.5f, mad(mad(mad((-0.0f) - vertex_unnamed_111, 2.0f, 3.0f) * (vertex_unnamed_111 * vertex_unnamed_111), ((-0.0f) - vertex_unnamed_160) + mad(vertex_unnamed_121, ((-0.0f) - vertex_unnamed_156) + frac(sin(dot(float2(vertex_unnamed_104 + 1.0f, vertex_unnamed_105 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_156), vertex_unnamed_160), 0.125f, mad(mad((-0.0f) - vertex_unnamed_182, 2.0f, 3.0f) * (vertex_unnamed_182 * vertex_unnamed_182), ((-0.0f) - vertex_unnamed_235) + mad(vertex_unnamed_197, ((-0.0f) - vertex_unnamed_226) + frac(sin(dot(float2(vertex_unnamed_177 + 1.0f, vertex_unnamed_178 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_226), vertex_unnamed_235) * 0.25f));
					float vertex_unnamed_305 = mad(vertex_unnamed_282 * (vertex_input_1.x * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.x);
					float vertex_unnamed_307 = mad(vertex_unnamed_282 * (vertex_input_1.y * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.y);
					float vertex_unnamed_308 = mad(vertex_unnamed_282 * (vertex_input_1.z * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.z);
					float vertex_unnamed_341 = asfloat(1065353216u);
					float vertex_unnamed_343 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_361 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_379 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_394 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_409 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_424 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_432 = rsqrt(max(dot(float3(vertex_unnamed_394, vertex_unnamed_409, vertex_unnamed_424), float3(vertex_unnamed_394, vertex_unnamed_409, vertex_unnamed_424)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_432 * vertex_unnamed_394;
					vertex_output_7.y = vertex_unnamed_432 * vertex_unnamed_409;
					vertex_output_7.z = vertex_unnamed_432 * vertex_unnamed_424;
					float vertex_unnamed_466 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_467 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_468 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_473 = rsqrt(max(dot(float3(vertex_unnamed_466, vertex_unnamed_467, vertex_unnamed_468), float3(vertex_unnamed_466, vertex_unnamed_467, vertex_unnamed_468)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_473 * vertex_unnamed_466;
					vertex_output_1.y = vertex_unnamed_473 * vertex_unnamed_467;
					vertex_output_1.z = vertex_unnamed_473 * vertex_unnamed_468;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_343;
					vertex_output_6.y = vertex_unnamed_361;
					vertex_output_6.z = vertex_unnamed_379;
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

				vertex_uniform_buffer_2[9] = float4(vertex_uniform_buffer_2[9][0], _Progress, vertex_uniform_buffer_2[9][2], vertex_uniform_buffer_2[9][3]);

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
			float _Progress;
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
					float vertex_unnamed_104 = floor(vertex_input_3.x);
					float vertex_unnamed_105 = floor(vertex_input_3.y);
					float vertex_unnamed_110 = frac(vertex_input_3.x);
					float vertex_unnamed_111 = frac(vertex_input_3.y);
					float vertex_unnamed_121 = mad((-0.0f) - vertex_unnamed_110, 2.0f, 3.0f) * (vertex_unnamed_110 * vertex_unnamed_110);
					float vertex_unnamed_144 = frac(sin(dot(float2(vertex_unnamed_104, vertex_unnamed_105), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_156 = frac(sin(dot(float2(vertex_unnamed_104 + 0.0f, vertex_unnamed_105 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_160 = mad(vertex_unnamed_121, ((-0.0f) - vertex_unnamed_144) + frac(sin(dot(float2(vertex_unnamed_104 + 1.0f, vertex_unnamed_105 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_144);
					float vertex_unnamed_171 = vertex_input_3.x * 0.5f;
					float vertex_unnamed_173 = vertex_input_3.y * 0.5f;
					float vertex_unnamed_174 = vertex_input_3.x * 0.25f;
					float vertex_unnamed_176 = vertex_input_3.y * 0.25f;
					float vertex_unnamed_177 = floor(vertex_unnamed_171);
					float vertex_unnamed_178 = floor(vertex_unnamed_173);
					float vertex_unnamed_179 = floor(vertex_unnamed_174);
					float vertex_unnamed_180 = floor(vertex_unnamed_176);
					float vertex_unnamed_181 = frac(vertex_unnamed_171);
					float vertex_unnamed_182 = frac(vertex_unnamed_173);
					float vertex_unnamed_183 = frac(vertex_unnamed_174);
					float vertex_unnamed_184 = frac(vertex_unnamed_176);
					float vertex_unnamed_197 = mad((-0.0f) - vertex_unnamed_181, 2.0f, 3.0f) * (vertex_unnamed_181 * vertex_unnamed_181);
					float vertex_unnamed_199 = mad((-0.0f) - vertex_unnamed_183, 2.0f, 3.0f) * (vertex_unnamed_183 * vertex_unnamed_183);
					float vertex_unnamed_224 = frac(sin(dot(float2(vertex_unnamed_177, vertex_unnamed_178), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_226 = frac(sin(dot(float2(vertex_unnamed_177 + 0.0f, vertex_unnamed_178 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_235 = mad(vertex_unnamed_197, ((-0.0f) - vertex_unnamed_224) + frac(sin(dot(float2(vertex_unnamed_177 + 1.0f, vertex_unnamed_178 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_224);
					float vertex_unnamed_264 = frac(sin(dot(float2(vertex_unnamed_179, vertex_unnamed_180), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_266 = frac(sin(dot(float2(vertex_unnamed_179 + 0.0f, vertex_unnamed_180 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_275 = mad(vertex_unnamed_199, ((-0.0f) - vertex_unnamed_264) + frac(sin(dot(float2(vertex_unnamed_179 + 1.0f, vertex_unnamed_180 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_264);
					float vertex_unnamed_282 = mad(mad(mad((-0.0f) - vertex_unnamed_184, 2.0f, 3.0f) * (vertex_unnamed_184 * vertex_unnamed_184), ((-0.0f) - vertex_unnamed_275) + mad(vertex_unnamed_199, ((-0.0f) - vertex_unnamed_266) + frac(sin(dot(float2(vertex_unnamed_179 + 1.0f, vertex_unnamed_180 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_266), vertex_unnamed_275), 0.5f, mad(mad(mad((-0.0f) - vertex_unnamed_111, 2.0f, 3.0f) * (vertex_unnamed_111 * vertex_unnamed_111), ((-0.0f) - vertex_unnamed_160) + mad(vertex_unnamed_121, ((-0.0f) - vertex_unnamed_156) + frac(sin(dot(float2(vertex_unnamed_104 + 1.0f, vertex_unnamed_105 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_156), vertex_unnamed_160), 0.125f, mad(mad((-0.0f) - vertex_unnamed_182, 2.0f, 3.0f) * (vertex_unnamed_182 * vertex_unnamed_182), ((-0.0f) - vertex_unnamed_235) + mad(vertex_unnamed_197, ((-0.0f) - vertex_unnamed_226) + frac(sin(dot(float2(vertex_unnamed_177 + 1.0f, vertex_unnamed_178 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_226), vertex_unnamed_235) * 0.25f));
					float vertex_unnamed_305 = mad(vertex_unnamed_282 * (vertex_input_1.x * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.x);
					float vertex_unnamed_307 = mad(vertex_unnamed_282 * (vertex_input_1.y * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.y);
					float vertex_unnamed_308 = mad(vertex_unnamed_282 * (vertex_input_1.z * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.z);
					float vertex_unnamed_341 = asfloat(1065353216u);
					float vertex_unnamed_343 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_361 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_379 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_394 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_409 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_424 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_432 = rsqrt(max(dot(float3(vertex_unnamed_394, vertex_unnamed_409, vertex_unnamed_424), float3(vertex_unnamed_394, vertex_unnamed_409, vertex_unnamed_424)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_432 * vertex_unnamed_394;
					vertex_output_7.y = vertex_unnamed_432 * vertex_unnamed_409;
					vertex_output_7.z = vertex_unnamed_432 * vertex_unnamed_424;
					float vertex_unnamed_466 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_467 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_468 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_473 = rsqrt(max(dot(float3(vertex_unnamed_466, vertex_unnamed_467, vertex_unnamed_468), float3(vertex_unnamed_466, vertex_unnamed_467, vertex_unnamed_468)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_473 * vertex_unnamed_466;
					vertex_output_1.y = vertex_unnamed_473 * vertex_unnamed_467;
					vertex_output_1.z = vertex_unnamed_473 * vertex_unnamed_468;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_343;
					vertex_output_6.y = vertex_unnamed_361;
					vertex_output_6.z = vertex_unnamed_379;
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

				vertex_uniform_buffer_2[9] = float4(vertex_uniform_buffer_2[9][0], _Progress, vertex_uniform_buffer_2[9][2], vertex_uniform_buffer_2[9][3]);

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


			float _GlobalMipBias;
			float _Progress;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_84)
			{
				if (fragment_unnamed_84)
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
				discard_cond(((_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_2.x + fragment_input_2.x, fragment_input_2.y + fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x + mad(fragment_uniform_buffer_1[9u].y + (-1.0f), -1.10000002384185791015625f, -0.60000002384185791015625f)) + (-0.5f)) < 0.0f);
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

			#endif // defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Progress;
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			static float4 fragment_uniform_buffer_2[13];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;

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
				bool gl_FrontFacing : SV_IsFrontFace;
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

			void discard_cond(bool fragment_unnamed_194)
			{
				if (fragment_unnamed_194)
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
				discard_cond(((_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_2.x + fragment_input_2.x, fragment_input_2.y + fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x + mad(fragment_uniform_buffer_2[9u].y + (-1.0f), -1.10000002384185791015625f, -0.60000002384185791015625f)) + (-0.5f)) < 0.0f);
				float fragment_unnamed_108 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_131 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 1065353216u : asuint(fragment_uniform_buffer_2[12u]).z);
				float fragment_unnamed_132 = (fragment_unnamed_108 * fragment_input_7.x) * fragment_unnamed_131;
				float fragment_unnamed_133 = (fragment_unnamed_108 * fragment_input_7.y) * fragment_unnamed_131;
				float fragment_unnamed_134 = (fragment_unnamed_108 * fragment_input_7.z) * fragment_unnamed_131;
				float fragment_unnamed_143 = 1.0f / max(dot(float3(abs(fragment_unnamed_132), abs(fragment_unnamed_133), abs(fragment_unnamed_134)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_149 = clamp((-0.0f) - (fragment_unnamed_143 * fragment_unnamed_134), 0.0f, 1.0f);
				float fragment_unnamed_152 = (-0.0f) - fragment_unnamed_149;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_132, fragment_unnamed_143, ((fragment_unnamed_143 * fragment_unnamed_132) >= 0.0f) ? fragment_unnamed_149 : fragment_unnamed_152), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_133, fragment_unnamed_143, ((fragment_unnamed_143 * fragment_unnamed_133) >= 0.0f) ? fragment_unnamed_149 : fragment_unnamed_152), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_174 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_174, min((8u & 31u), (32u - fragment_unnamed_174)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[9] = float4(fragment_uniform_buffer_2[9][0], _Progress, fragment_uniform_buffer_2[9][2], fragment_uniform_buffer_2[9][3]);

				fragment_uniform_buffer_2[12] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

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
				float fragment_unnamed_52 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_60 = fragment_unnamed_52 * fragment_input_7.x;
				float fragment_unnamed_61 = fragment_unnamed_52 * fragment_input_7.y;
				float fragment_unnamed_62 = fragment_unnamed_52 * fragment_input_7.z;
				float fragment_unnamed_71 = 1.0f / max(dot(float3(abs(fragment_unnamed_60), abs(fragment_unnamed_61), abs(fragment_unnamed_62)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_78 = clamp((-0.0f) - (fragment_unnamed_71 * fragment_unnamed_62), 0.0f, 1.0f);
				float fragment_unnamed_81 = (-0.0f) - fragment_unnamed_78;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_60, fragment_unnamed_71, ((fragment_unnamed_71 * fragment_unnamed_60) >= 0.0f) ? fragment_unnamed_78 : fragment_unnamed_81), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_61, fragment_unnamed_71, ((fragment_unnamed_71 * fragment_unnamed_61) >= 0.0f) ? fragment_unnamed_78 : fragment_unnamed_81), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_105 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_0[10u]).x, fragment_unnamed_105, min((8u & 31u), (32u - fragment_unnamed_105)))) * 0.0039215688593685626983642578125f;
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
			GpuProgramID 528456

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ DECALS_3RT
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _Progress;
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
					float vertex_unnamed_104 = floor(vertex_input_3.x);
					float vertex_unnamed_105 = floor(vertex_input_3.y);
					float vertex_unnamed_110 = frac(vertex_input_3.x);
					float vertex_unnamed_111 = frac(vertex_input_3.y);
					float vertex_unnamed_121 = mad((-0.0f) - vertex_unnamed_110, 2.0f, 3.0f) * (vertex_unnamed_110 * vertex_unnamed_110);
					float vertex_unnamed_144 = frac(sin(dot(float2(vertex_unnamed_104, vertex_unnamed_105), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_156 = frac(sin(dot(float2(vertex_unnamed_104 + 0.0f, vertex_unnamed_105 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_160 = mad(vertex_unnamed_121, ((-0.0f) - vertex_unnamed_144) + frac(sin(dot(float2(vertex_unnamed_104 + 1.0f, vertex_unnamed_105 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_144);
					float vertex_unnamed_171 = vertex_input_3.x * 0.5f;
					float vertex_unnamed_173 = vertex_input_3.y * 0.5f;
					float vertex_unnamed_174 = vertex_input_3.x * 0.25f;
					float vertex_unnamed_176 = vertex_input_3.y * 0.25f;
					float vertex_unnamed_177 = floor(vertex_unnamed_171);
					float vertex_unnamed_178 = floor(vertex_unnamed_173);
					float vertex_unnamed_179 = floor(vertex_unnamed_174);
					float vertex_unnamed_180 = floor(vertex_unnamed_176);
					float vertex_unnamed_181 = frac(vertex_unnamed_171);
					float vertex_unnamed_182 = frac(vertex_unnamed_173);
					float vertex_unnamed_183 = frac(vertex_unnamed_174);
					float vertex_unnamed_184 = frac(vertex_unnamed_176);
					float vertex_unnamed_197 = mad((-0.0f) - vertex_unnamed_181, 2.0f, 3.0f) * (vertex_unnamed_181 * vertex_unnamed_181);
					float vertex_unnamed_199 = mad((-0.0f) - vertex_unnamed_183, 2.0f, 3.0f) * (vertex_unnamed_183 * vertex_unnamed_183);
					float vertex_unnamed_224 = frac(sin(dot(float2(vertex_unnamed_177, vertex_unnamed_178), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_226 = frac(sin(dot(float2(vertex_unnamed_177 + 0.0f, vertex_unnamed_178 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_235 = mad(vertex_unnamed_197, ((-0.0f) - vertex_unnamed_224) + frac(sin(dot(float2(vertex_unnamed_177 + 1.0f, vertex_unnamed_178 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_224);
					float vertex_unnamed_264 = frac(sin(dot(float2(vertex_unnamed_179, vertex_unnamed_180), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_266 = frac(sin(dot(float2(vertex_unnamed_179 + 0.0f, vertex_unnamed_180 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_275 = mad(vertex_unnamed_199, ((-0.0f) - vertex_unnamed_264) + frac(sin(dot(float2(vertex_unnamed_179 + 1.0f, vertex_unnamed_180 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_264);
					float vertex_unnamed_282 = mad(mad(mad((-0.0f) - vertex_unnamed_184, 2.0f, 3.0f) * (vertex_unnamed_184 * vertex_unnamed_184), ((-0.0f) - vertex_unnamed_275) + mad(vertex_unnamed_199, ((-0.0f) - vertex_unnamed_266) + frac(sin(dot(float2(vertex_unnamed_179 + 1.0f, vertex_unnamed_180 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_266), vertex_unnamed_275), 0.5f, mad(mad(mad((-0.0f) - vertex_unnamed_111, 2.0f, 3.0f) * (vertex_unnamed_111 * vertex_unnamed_111), ((-0.0f) - vertex_unnamed_160) + mad(vertex_unnamed_121, ((-0.0f) - vertex_unnamed_156) + frac(sin(dot(float2(vertex_unnamed_104 + 1.0f, vertex_unnamed_105 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_156), vertex_unnamed_160), 0.125f, mad(mad((-0.0f) - vertex_unnamed_182, 2.0f, 3.0f) * (vertex_unnamed_182 * vertex_unnamed_182), ((-0.0f) - vertex_unnamed_235) + mad(vertex_unnamed_197, ((-0.0f) - vertex_unnamed_226) + frac(sin(dot(float2(vertex_unnamed_177 + 1.0f, vertex_unnamed_178 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_226), vertex_unnamed_235) * 0.25f));
					float vertex_unnamed_305 = mad(vertex_unnamed_282 * (vertex_input_1.x * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.x);
					float vertex_unnamed_307 = mad(vertex_unnamed_282 * (vertex_input_1.y * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.y);
					float vertex_unnamed_308 = mad(vertex_unnamed_282 * (vertex_input_1.z * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.z);
					float vertex_unnamed_341 = asfloat(1065353216u);
					float vertex_unnamed_343 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_361 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_379 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_394 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_409 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_424 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_432 = rsqrt(max(dot(float3(vertex_unnamed_394, vertex_unnamed_409, vertex_unnamed_424), float3(vertex_unnamed_394, vertex_unnamed_409, vertex_unnamed_424)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_432 * vertex_unnamed_394;
					vertex_output_7.y = vertex_unnamed_432 * vertex_unnamed_409;
					vertex_output_7.z = vertex_unnamed_432 * vertex_unnamed_424;
					float vertex_unnamed_466 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_467 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_468 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_473 = rsqrt(max(dot(float3(vertex_unnamed_466, vertex_unnamed_467, vertex_unnamed_468), float3(vertex_unnamed_466, vertex_unnamed_467, vertex_unnamed_468)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_473 * vertex_unnamed_466;
					vertex_output_1.y = vertex_unnamed_473 * vertex_unnamed_467;
					vertex_output_1.z = vertex_unnamed_473 * vertex_unnamed_468;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_343;
					vertex_output_6.y = vertex_unnamed_361;
					vertex_output_6.z = vertex_unnamed_379;
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

				vertex_uniform_buffer_2[9] = float4(vertex_uniform_buffer_2[9][0], _Progress, vertex_uniform_buffer_2[9][2], vertex_uniform_buffer_2[9][3]);

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

			#endif // !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT)


			#if defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _Progress;
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
					float vertex_unnamed_104 = floor(vertex_input_3.x);
					float vertex_unnamed_105 = floor(vertex_input_3.y);
					float vertex_unnamed_110 = frac(vertex_input_3.x);
					float vertex_unnamed_111 = frac(vertex_input_3.y);
					float vertex_unnamed_121 = mad((-0.0f) - vertex_unnamed_110, 2.0f, 3.0f) * (vertex_unnamed_110 * vertex_unnamed_110);
					float vertex_unnamed_144 = frac(sin(dot(float2(vertex_unnamed_104, vertex_unnamed_105), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_156 = frac(sin(dot(float2(vertex_unnamed_104 + 0.0f, vertex_unnamed_105 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_160 = mad(vertex_unnamed_121, ((-0.0f) - vertex_unnamed_144) + frac(sin(dot(float2(vertex_unnamed_104 + 1.0f, vertex_unnamed_105 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_144);
					float vertex_unnamed_171 = vertex_input_3.x * 0.5f;
					float vertex_unnamed_173 = vertex_input_3.y * 0.5f;
					float vertex_unnamed_174 = vertex_input_3.x * 0.25f;
					float vertex_unnamed_176 = vertex_input_3.y * 0.25f;
					float vertex_unnamed_177 = floor(vertex_unnamed_171);
					float vertex_unnamed_178 = floor(vertex_unnamed_173);
					float vertex_unnamed_179 = floor(vertex_unnamed_174);
					float vertex_unnamed_180 = floor(vertex_unnamed_176);
					float vertex_unnamed_181 = frac(vertex_unnamed_171);
					float vertex_unnamed_182 = frac(vertex_unnamed_173);
					float vertex_unnamed_183 = frac(vertex_unnamed_174);
					float vertex_unnamed_184 = frac(vertex_unnamed_176);
					float vertex_unnamed_197 = mad((-0.0f) - vertex_unnamed_181, 2.0f, 3.0f) * (vertex_unnamed_181 * vertex_unnamed_181);
					float vertex_unnamed_199 = mad((-0.0f) - vertex_unnamed_183, 2.0f, 3.0f) * (vertex_unnamed_183 * vertex_unnamed_183);
					float vertex_unnamed_224 = frac(sin(dot(float2(vertex_unnamed_177, vertex_unnamed_178), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_226 = frac(sin(dot(float2(vertex_unnamed_177 + 0.0f, vertex_unnamed_178 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_235 = mad(vertex_unnamed_197, ((-0.0f) - vertex_unnamed_224) + frac(sin(dot(float2(vertex_unnamed_177 + 1.0f, vertex_unnamed_178 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_224);
					float vertex_unnamed_264 = frac(sin(dot(float2(vertex_unnamed_179, vertex_unnamed_180), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_266 = frac(sin(dot(float2(vertex_unnamed_179 + 0.0f, vertex_unnamed_180 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
					float vertex_unnamed_275 = mad(vertex_unnamed_199, ((-0.0f) - vertex_unnamed_264) + frac(sin(dot(float2(vertex_unnamed_179 + 1.0f, vertex_unnamed_180 + 0.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_264);
					float vertex_unnamed_282 = mad(mad(mad((-0.0f) - vertex_unnamed_184, 2.0f, 3.0f) * (vertex_unnamed_184 * vertex_unnamed_184), ((-0.0f) - vertex_unnamed_275) + mad(vertex_unnamed_199, ((-0.0f) - vertex_unnamed_266) + frac(sin(dot(float2(vertex_unnamed_179 + 1.0f, vertex_unnamed_180 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_266), vertex_unnamed_275), 0.5f, mad(mad(mad((-0.0f) - vertex_unnamed_111, 2.0f, 3.0f) * (vertex_unnamed_111 * vertex_unnamed_111), ((-0.0f) - vertex_unnamed_160) + mad(vertex_unnamed_121, ((-0.0f) - vertex_unnamed_156) + frac(sin(dot(float2(vertex_unnamed_104 + 1.0f, vertex_unnamed_105 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_156), vertex_unnamed_160), 0.125f, mad(mad((-0.0f) - vertex_unnamed_182, 2.0f, 3.0f) * (vertex_unnamed_182 * vertex_unnamed_182), ((-0.0f) - vertex_unnamed_235) + mad(vertex_unnamed_197, ((-0.0f) - vertex_unnamed_226) + frac(sin(dot(float2(vertex_unnamed_177 + 1.0f, vertex_unnamed_178 + 1.0f), float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f), vertex_unnamed_226), vertex_unnamed_235) * 0.25f));
					float vertex_unnamed_305 = mad(vertex_unnamed_282 * (vertex_input_1.x * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.x);
					float vertex_unnamed_307 = mad(vertex_unnamed_282 * (vertex_input_1.y * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.y);
					float vertex_unnamed_308 = mad(vertex_unnamed_282 * (vertex_input_1.z * vertex_uniform_buffer_2[9u].y), 0.100000001490116119384765625f, vertex_input_0.z);
					float vertex_unnamed_341 = asfloat(1065353216u);
					float vertex_unnamed_343 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_361 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_379 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_305, vertex_unnamed_307, vertex_unnamed_308, vertex_unnamed_341));
					float vertex_unnamed_394 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_409 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_424 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_432 = rsqrt(max(dot(float3(vertex_unnamed_394, vertex_unnamed_409, vertex_unnamed_424), float3(vertex_unnamed_394, vertex_unnamed_409, vertex_unnamed_424)), 1.1754943508222875079687365372222e-38f));
					vertex_output_7.x = vertex_unnamed_432 * vertex_unnamed_394;
					vertex_output_7.y = vertex_unnamed_432 * vertex_unnamed_409;
					vertex_output_7.z = vertex_unnamed_432 * vertex_unnamed_424;
					float vertex_unnamed_466 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_467 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_468 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_473 = rsqrt(max(dot(float3(vertex_unnamed_466, vertex_unnamed_467, vertex_unnamed_468), float3(vertex_unnamed_466, vertex_unnamed_467, vertex_unnamed_468)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_473 * vertex_unnamed_466;
					vertex_output_1.y = vertex_unnamed_473 * vertex_unnamed_467;
					vertex_output_1.z = vertex_unnamed_473 * vertex_unnamed_468;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_379, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_343, vertex_unnamed_361 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_343;
					vertex_output_6.y = vertex_unnamed_361;
					vertex_output_6.z = vertex_unnamed_379;
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

				vertex_uniform_buffer_2[9] = float4(vertex_uniform_buffer_2[9][0], _Progress, vertex_uniform_buffer_2[9][2], vertex_uniform_buffer_2[9][3]);

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

			#endif // defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT)


			#if defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

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
			static float4 fragment_uniform_buffer_2[13];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D;
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
			SamplerState sampler_SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_EmissionMap;

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
				float fragment_unnamed_113 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_132 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_195 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_221 = asfloat(fragment_unnamed_195 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_228 = asfloat(fragment_unnamed_195 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_235 = asfloat(fragment_unnamed_195 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_239 = rsqrt(dot(float3(fragment_unnamed_221, fragment_unnamed_228, fragment_unnamed_235), float3(fragment_unnamed_221, fragment_unnamed_228, fragment_unnamed_235)));
				bool fragment_unnamed_246 = (gl_FrontFacing ? 4294967295u : 0u) != 0u;
				uint4 fragment_unnamed_250 = asuint(fragment_uniform_buffer_2[12u]);
				float fragment_unnamed_254 = asfloat(fragment_unnamed_246 ? 1065353216u : fragment_unnamed_250.z);
				float fragment_unnamed_256 = asfloat(fragment_unnamed_246 ? 1065353216u : fragment_unnamed_250.x);
				bool fragment_unnamed_263 = 0.0f != fragment_uniform_buffer_2[9u].x;
				float fragment_unnamed_269 = asfloat(fragment_unnamed_263 ? 1065353216u : 1036831949u);
				float4 fragment_unnamed_280 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_283 = fragment_unnamed_280.x;
				float fragment_unnamed_284 = fragment_unnamed_280.y;
				float fragment_unnamed_285 = fragment_unnamed_280.z;
				float4 fragment_unnamed_294 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_297 = fragment_unnamed_294.y;
				float fragment_unnamed_298 = fragment_unnamed_294.w;
				float4 fragment_unnamed_307 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_313 = mad(fragment_unnamed_307.x * fragment_unnamed_307.w, 2.0f, -1.0f);
				float fragment_unnamed_316 = mad(fragment_unnamed_307.y, 2.0f, -1.0f);
				float fragment_unnamed_324 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_313, fragment_unnamed_316), float2(fragment_unnamed_313, fragment_unnamed_316)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_326 = asfloat((fragment_unnamed_263 ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_294.x;
				float4 fragment_unnamed_335 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_346 = fragment_unnamed_335.x * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_347 = fragment_unnamed_335.y * fragment_uniform_buffer_2[8u].y;
				float fragment_unnamed_348 = fragment_unnamed_335.z * fragment_uniform_buffer_2[8u].z;
				float4 fragment_unnamed_358 = _SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_371 = _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_389 = min(max((fragment_uniform_buffer_2[9u].y + (-0.100000001490116119384765625f)) * 4.999999523162841796875f, asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : 1065353216u)), 1.0f);
				float fragment_unnamed_396 = mad(fragment_unnamed_389, ((-0.0f) - fragment_unnamed_283) + fragment_unnamed_358.x, fragment_unnamed_283);
				float fragment_unnamed_397 = mad(fragment_unnamed_389, ((-0.0f) - fragment_unnamed_284) + fragment_unnamed_358.y, fragment_unnamed_284);
				float fragment_unnamed_398 = mad(fragment_unnamed_389, ((-0.0f) - fragment_unnamed_285) + fragment_unnamed_358.z, fragment_unnamed_285);
				float fragment_unnamed_407 = mad(fragment_unnamed_389, ((-0.0f) - fragment_unnamed_324) + fragment_unnamed_371.z, fragment_unnamed_324);
				float fragment_unnamed_409 = mad(fragment_unnamed_389, (-0.0f) - fragment_unnamed_326, fragment_unnamed_326);
				float fragment_unnamed_413 = mad(fragment_unnamed_389, mad((-0.0f) - fragment_unnamed_298, fragment_unnamed_269, 0.800000011920928955078125f), fragment_unnamed_269 * fragment_unnamed_298);
				float fragment_unnamed_415 = mad(fragment_unnamed_389, (-0.0f) - fragment_unnamed_297, fragment_unnamed_297);
				float fragment_unnamed_422 = fragment_unnamed_256 * mad(fragment_unnamed_389, ((-0.0f) - fragment_unnamed_313) + fragment_unnamed_371.x, fragment_unnamed_313);
				float fragment_unnamed_423 = fragment_unnamed_256 * mad(fragment_unnamed_389, ((-0.0f) - fragment_unnamed_316) + fragment_unnamed_371.y, fragment_unnamed_316);
				float fragment_unnamed_430 = mad(fragment_unnamed_407, (fragment_unnamed_113 * fragment_input_7.x) * fragment_unnamed_254, mad(fragment_unnamed_422, fragment_unnamed_113 * fragment_input_1.x, (fragment_unnamed_113 * (fragment_unnamed_132 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_423));
				float fragment_unnamed_431 = mad(fragment_unnamed_407, (fragment_unnamed_113 * fragment_input_7.y) * fragment_unnamed_254, mad(fragment_unnamed_422, fragment_unnamed_113 * fragment_input_1.y, (fragment_unnamed_113 * (fragment_unnamed_132 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_423));
				float fragment_unnamed_432 = mad(fragment_unnamed_407, (fragment_unnamed_113 * fragment_input_7.z) * fragment_unnamed_254, mad(fragment_unnamed_422, fragment_unnamed_113 * fragment_input_1.z, (fragment_unnamed_113 * (fragment_unnamed_132 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_423));
				float fragment_unnamed_437 = rsqrt(max(dot(float3(fragment_unnamed_430, fragment_unnamed_431, fragment_unnamed_432), float3(fragment_unnamed_430, fragment_unnamed_431, fragment_unnamed_432)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_438 = fragment_unnamed_430 * fragment_unnamed_437;
				float fragment_unnamed_439 = fragment_unnamed_431 * fragment_unnamed_437;
				float fragment_unnamed_440 = fragment_unnamed_432 * fragment_unnamed_437;
				float fragment_unnamed_504;
				float fragment_unnamed_505;
				float fragment_unnamed_506;
				float fragment_unnamed_507;
				float fragment_unnamed_508;
				float fragment_unnamed_509;
				float fragment_unnamed_510;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_451 = uint(gl_FragCoord.x);
					uint fragment_unnamed_452 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_453 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_451, fragment_unnamed_452, 0u), 0u));
					float fragment_unnamed_459 = fragment_unnamed_453.w;
					float4 fragment_unnamed_460 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_451, fragment_unnamed_452, 0u), 0u));
					float fragment_unnamed_465 = fragment_unnamed_460.w;
					float4 fragment_unnamed_466 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_451, fragment_unnamed_452, 0u), 0u));
					bool fragment_unnamed_476 = fragment_unnamed_465 < 1.0f;
					float fragment_unnamed_477 = mad(fragment_unnamed_438, fragment_unnamed_465, fragment_unnamed_256 * mad(fragment_unnamed_460.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_478 = mad(fragment_unnamed_439, fragment_unnamed_465, fragment_unnamed_256 * mad(fragment_unnamed_460.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_479 = mad(fragment_unnamed_440, fragment_unnamed_465, mad(fragment_unnamed_460.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_484 = rsqrt(max(dot(float3(fragment_unnamed_477, fragment_unnamed_478, fragment_unnamed_479), float3(fragment_unnamed_477, fragment_unnamed_478, fragment_unnamed_479)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_504 = mad(fragment_unnamed_413, fragment_unnamed_466.w, fragment_unnamed_466.z);
					fragment_unnamed_505 = asfloat(fragment_unnamed_476 ? asuint(fragment_unnamed_477 * fragment_unnamed_484) : asuint(fragment_unnamed_438));
					fragment_unnamed_506 = asfloat(fragment_unnamed_476 ? asuint(fragment_unnamed_478 * fragment_unnamed_484) : asuint(fragment_unnamed_439));
					fragment_unnamed_507 = asfloat(fragment_unnamed_476 ? asuint(fragment_unnamed_479 * fragment_unnamed_484) : asuint(fragment_unnamed_440));
					fragment_unnamed_508 = mad(fragment_unnamed_396, fragment_unnamed_459, fragment_unnamed_453.x);
					fragment_unnamed_509 = mad(fragment_unnamed_397, fragment_unnamed_459, fragment_unnamed_453.y);
					fragment_unnamed_510 = mad(fragment_unnamed_398, fragment_unnamed_459, fragment_unnamed_453.z);
				}
				else
				{
					fragment_unnamed_504 = fragment_unnamed_413;
					fragment_unnamed_505 = fragment_unnamed_438;
					fragment_unnamed_506 = fragment_unnamed_439;
					fragment_unnamed_507 = fragment_unnamed_440;
					fragment_unnamed_508 = fragment_unnamed_396;
					fragment_unnamed_509 = fragment_unnamed_397;
					fragment_unnamed_510 = fragment_unnamed_398;
				}
				float fragment_unnamed_514 = max(dot(float3(fragment_unnamed_505, fragment_unnamed_506, fragment_unnamed_507), float3(fragment_unnamed_239 * fragment_unnamed_221, fragment_unnamed_239 * fragment_unnamed_228, fragment_unnamed_239 * fragment_unnamed_235)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_517 = ((-0.0f) - fragment_unnamed_504) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_415 + exp2(log2(abs(fragment_unnamed_415 + fragment_unnamed_514)) * exp2(mad(fragment_unnamed_517 * fragment_unnamed_517, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_546 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_547 = fragment_unnamed_546.x;
				float fragment_unnamed_832;
				float fragment_unnamed_834;
				float fragment_unnamed_836;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_547 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_547 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_833;
					float fragment_unnamed_835;
					float fragment_unnamed_837;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_570 = asfloat(1065353216u);
						float fragment_unnamed_599 = fragment_unnamed_506 * fragment_unnamed_505;
						float fragment_unnamed_600 = fragment_unnamed_507 * fragment_unnamed_506;
						float fragment_unnamed_601 = fragment_unnamed_507 * fragment_unnamed_507;
						float fragment_unnamed_602 = fragment_unnamed_505 * fragment_unnamed_507;
						float fragment_unnamed_635 = mad(fragment_unnamed_505, fragment_unnamed_505, (-0.0f) - (fragment_unnamed_506 * fragment_unnamed_506));
						fragment_unnamed_833 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_505, fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_570)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_635, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_599, fragment_unnamed_600, fragment_unnamed_601, fragment_unnamed_602)));
						fragment_unnamed_835 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_505, fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_570)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_635, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_599, fragment_unnamed_600, fragment_unnamed_601, fragment_unnamed_602)));
						fragment_unnamed_837 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_505, fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_570)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_635, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_599, fragment_unnamed_600, fragment_unnamed_601, fragment_unnamed_602)));
					}
					else
					{
						bool fragment_unnamed_651 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_652 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_674 = fragment_unnamed_651 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_675 = fragment_unnamed_651 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_676 = fragment_unnamed_651 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_780 = (asfloat(fragment_unnamed_652 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_676, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_674, fragment_unnamed_675 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_675)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_781 = (asfloat(fragment_unnamed_652 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_676, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_674, fragment_unnamed_675 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_676)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_795 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_652 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_676, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_674, fragment_unnamed_675 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_674)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_822 = asfloat(1065353216u);
						fragment_unnamed_833 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_795, fragment_unnamed_780, fragment_unnamed_781), 0.0f)), float4(fragment_unnamed_505, fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_822));
						fragment_unnamed_835 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_795 + 0.25f, fragment_unnamed_780 + 0.0f, fragment_unnamed_781 + 0.0f), 0.0f)), float4(fragment_unnamed_505, fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_822));
						fragment_unnamed_837 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_795 + 0.5f, fragment_unnamed_780 + 0.0f, fragment_unnamed_781 + 0.0f), 0.0f)), float4(fragment_unnamed_505, fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_822));
					}
					fragment_unnamed_832 = fragment_unnamed_833;
					fragment_unnamed_834 = fragment_unnamed_835;
					fragment_unnamed_836 = fragment_unnamed_837;
				}
				else
				{
					fragment_unnamed_832 = asfloat(0u);
					fragment_unnamed_834 = asfloat(0u);
					fragment_unnamed_836 = asfloat(0u);
				}
				float fragment_unnamed_839 = ((-0.0f) - fragment_unnamed_409) + 1.0f;
				float fragment_unnamed_840 = fragment_unnamed_839 * fragment_unnamed_508;
				float fragment_unnamed_841 = fragment_unnamed_839 * fragment_unnamed_509;
				float fragment_unnamed_842 = fragment_unnamed_839 * fragment_unnamed_510;
				float fragment_unnamed_847 = mad(fragment_unnamed_409, fragment_unnamed_508 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_849 = mad(fragment_unnamed_409, fragment_unnamed_509 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_850 = mad(fragment_unnamed_409, fragment_unnamed_510 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_862 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_514), 0.984375f, 0.0078125f), mad(fragment_unnamed_517, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_872 = clamp((max(fragment_unnamed_850, max(fragment_unnamed_849, fragment_unnamed_847)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_896 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_901 = max(abs(fragment_unnamed_507), 0.0009765625f);
				float fragment_unnamed_905 = (fragment_unnamed_507 >= 0.0f) ? fragment_unnamed_901 : ((-0.0f) - fragment_unnamed_901);
				float fragment_unnamed_914 = 1.0f / max(dot(float3(abs(fragment_unnamed_505), abs(fragment_unnamed_506), abs(fragment_unnamed_905)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_919 = clamp((-0.0f) - (fragment_unnamed_914 * fragment_unnamed_905), 0.0f, 1.0f);
				float fragment_unnamed_922 = (-0.0f) - fragment_unnamed_919;
				uint fragment_unnamed_934 = uint(clamp(mad(mad(fragment_unnamed_505, fragment_unnamed_914, ((fragment_unnamed_914 * fragment_unnamed_505) >= 0.0f) ? fragment_unnamed_919 : fragment_unnamed_922), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_935 = uint(clamp(mad(mad(fragment_unnamed_506, fragment_unnamed_914, ((fragment_unnamed_914 * fragment_unnamed_506) >= 0.0f) ? fragment_unnamed_919 : fragment_unnamed_922), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_934 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_935 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_935 >> 8u) * 16u) + (fragment_unnamed_934 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_847)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_849)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_850)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_987 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_988 = fragment_unnamed_987 * mad(fragment_unnamed_896 * ((fragment_unnamed_862 * mad(fragment_unnamed_872, mad((-0.0f) - fragment_unnamed_508, fragment_unnamed_839, fragment_unnamed_847), fragment_unnamed_840)) * fragment_unnamed_832), fragment_unnamed_415, mad(fragment_unnamed_389, (-0.0f) - fragment_unnamed_346, fragment_unnamed_346));
				float fragment_unnamed_989 = fragment_unnamed_987 * mad(fragment_unnamed_896 * ((fragment_unnamed_862 * mad(fragment_unnamed_872, mad((-0.0f) - fragment_unnamed_509, fragment_unnamed_839, fragment_unnamed_849), fragment_unnamed_841)) * fragment_unnamed_834), fragment_unnamed_415, mad(fragment_unnamed_389, (-0.0f) - fragment_unnamed_347, fragment_unnamed_347));
				float fragment_unnamed_990 = fragment_unnamed_987 * mad(fragment_unnamed_896 * ((fragment_unnamed_862 * mad(fragment_unnamed_872, mad((-0.0f) - fragment_unnamed_510, fragment_unnamed_839, fragment_unnamed_850), fragment_unnamed_842)) * fragment_unnamed_836), fragment_unnamed_415, mad(fragment_unnamed_389, (-0.0f) - fragment_unnamed_348, fragment_unnamed_348));
				bool fragment_unnamed_1003 = (((fragment_unnamed_990 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_989 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_988 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1003 ? asfloat(1157627904u) : fragment_unnamed_988;
				fragment_output_3.y = fragment_unnamed_1003 ? fragment_unnamed_415 : fragment_unnamed_989;
				fragment_output_3.z = fragment_unnamed_1003 ? asfloat(1149239296u) : fragment_unnamed_990;
				fragment_output_0.x = fragment_unnamed_840;
				fragment_output_0.y = fragment_unnamed_841;
				fragment_output_0.z = fragment_unnamed_842;
				fragment_output_1.w = fragment_unnamed_517;
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

			#endif // defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON)


			#if defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

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
			float4 _Emission;
			float _UseMaskMap;
			float _Progress;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[10];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D;
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
			SamplerState sampler_SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_EmissionMap;

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
				float fragment_unnamed_113 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_132 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_195 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_221 = asfloat(fragment_unnamed_195 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_228 = asfloat(fragment_unnamed_195 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_235 = asfloat(fragment_unnamed_195 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_239 = rsqrt(dot(float3(fragment_unnamed_221, fragment_unnamed_228, fragment_unnamed_235), float3(fragment_unnamed_221, fragment_unnamed_228, fragment_unnamed_235)));
				bool fragment_unnamed_246 = 0.0f != fragment_uniform_buffer_2[9u].x;
				float fragment_unnamed_253 = asfloat(fragment_unnamed_246 ? 1065353216u : 1036831949u);
				float4 fragment_unnamed_264 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_267 = fragment_unnamed_264.x;
				float fragment_unnamed_268 = fragment_unnamed_264.y;
				float fragment_unnamed_269 = fragment_unnamed_264.z;
				float4 fragment_unnamed_278 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_281 = fragment_unnamed_278.y;
				float fragment_unnamed_282 = fragment_unnamed_278.w;
				float4 fragment_unnamed_291 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_297 = mad(fragment_unnamed_291.x * fragment_unnamed_291.w, 2.0f, -1.0f);
				float fragment_unnamed_300 = mad(fragment_unnamed_291.y, 2.0f, -1.0f);
				float fragment_unnamed_308 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_297, fragment_unnamed_300), float2(fragment_unnamed_297, fragment_unnamed_300)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_310 = asfloat((fragment_unnamed_246 ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_278.x;
				float4 fragment_unnamed_319 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_330 = fragment_unnamed_319.x * fragment_uniform_buffer_2[8u].x;
				float fragment_unnamed_331 = fragment_unnamed_319.y * fragment_uniform_buffer_2[8u].y;
				float fragment_unnamed_332 = fragment_unnamed_319.z * fragment_uniform_buffer_2[8u].z;
				float4 fragment_unnamed_342 = _SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_355 = _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_373 = min(max((fragment_uniform_buffer_2[9u].y + (-0.100000001490116119384765625f)) * 4.999999523162841796875f, asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : 1065353216u)), 1.0f);
				float fragment_unnamed_380 = mad(fragment_unnamed_373, ((-0.0f) - fragment_unnamed_267) + fragment_unnamed_342.x, fragment_unnamed_267);
				float fragment_unnamed_381 = mad(fragment_unnamed_373, ((-0.0f) - fragment_unnamed_268) + fragment_unnamed_342.y, fragment_unnamed_268);
				float fragment_unnamed_382 = mad(fragment_unnamed_373, ((-0.0f) - fragment_unnamed_269) + fragment_unnamed_342.z, fragment_unnamed_269);
				float fragment_unnamed_389 = mad(fragment_unnamed_373, ((-0.0f) - fragment_unnamed_297) + fragment_unnamed_355.x, fragment_unnamed_297);
				float fragment_unnamed_390 = mad(fragment_unnamed_373, ((-0.0f) - fragment_unnamed_300) + fragment_unnamed_355.y, fragment_unnamed_300);
				float fragment_unnamed_391 = mad(fragment_unnamed_373, ((-0.0f) - fragment_unnamed_308) + fragment_unnamed_355.z, fragment_unnamed_308);
				float fragment_unnamed_393 = mad(fragment_unnamed_373, (-0.0f) - fragment_unnamed_310, fragment_unnamed_310);
				float fragment_unnamed_397 = mad(fragment_unnamed_373, mad((-0.0f) - fragment_unnamed_282, fragment_unnamed_253, 0.800000011920928955078125f), fragment_unnamed_253 * fragment_unnamed_282);
				float fragment_unnamed_399 = mad(fragment_unnamed_373, (-0.0f) - fragment_unnamed_281, fragment_unnamed_281);
				float fragment_unnamed_412 = mad(fragment_unnamed_391, fragment_unnamed_113 * fragment_input_7.x, mad(fragment_unnamed_389, fragment_unnamed_113 * fragment_input_1.x, (fragment_unnamed_113 * (fragment_unnamed_132 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_390));
				float fragment_unnamed_413 = mad(fragment_unnamed_391, fragment_unnamed_113 * fragment_input_7.y, mad(fragment_unnamed_389, fragment_unnamed_113 * fragment_input_1.y, (fragment_unnamed_113 * (fragment_unnamed_132 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_390));
				float fragment_unnamed_414 = mad(fragment_unnamed_391, fragment_unnamed_113 * fragment_input_7.z, mad(fragment_unnamed_389, fragment_unnamed_113 * fragment_input_1.z, (fragment_unnamed_113 * (fragment_unnamed_132 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_390));
				float fragment_unnamed_419 = rsqrt(max(dot(float3(fragment_unnamed_412, fragment_unnamed_413, fragment_unnamed_414), float3(fragment_unnamed_412, fragment_unnamed_413, fragment_unnamed_414)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_420 = fragment_unnamed_412 * fragment_unnamed_419;
				float fragment_unnamed_421 = fragment_unnamed_413 * fragment_unnamed_419;
				float fragment_unnamed_422 = fragment_unnamed_414 * fragment_unnamed_419;
				float fragment_unnamed_484;
				float fragment_unnamed_485;
				float fragment_unnamed_486;
				float fragment_unnamed_487;
				float fragment_unnamed_488;
				float fragment_unnamed_489;
				float fragment_unnamed_490;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_433 = uint(gl_FragCoord.x);
					uint fragment_unnamed_434 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_435 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_433, fragment_unnamed_434, 0u), 0u));
					float fragment_unnamed_441 = fragment_unnamed_435.w;
					float4 fragment_unnamed_442 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_433, fragment_unnamed_434, 0u), 0u));
					float fragment_unnamed_447 = fragment_unnamed_442.w;
					float4 fragment_unnamed_448 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_433, fragment_unnamed_434, 0u), 0u));
					bool fragment_unnamed_456 = fragment_unnamed_447 < 1.0f;
					float fragment_unnamed_457 = mad(fragment_unnamed_420, fragment_unnamed_447, mad(fragment_unnamed_442.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_458 = mad(fragment_unnamed_421, fragment_unnamed_447, mad(fragment_unnamed_442.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_459 = mad(fragment_unnamed_422, fragment_unnamed_447, mad(fragment_unnamed_442.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_464 = rsqrt(max(dot(float3(fragment_unnamed_457, fragment_unnamed_458, fragment_unnamed_459), float3(fragment_unnamed_457, fragment_unnamed_458, fragment_unnamed_459)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_484 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_457 * fragment_unnamed_464) : asuint(fragment_unnamed_420));
					fragment_unnamed_485 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_458 * fragment_unnamed_464) : asuint(fragment_unnamed_421));
					fragment_unnamed_486 = asfloat(fragment_unnamed_456 ? asuint(fragment_unnamed_459 * fragment_unnamed_464) : asuint(fragment_unnamed_422));
					fragment_unnamed_487 = mad(fragment_unnamed_380, fragment_unnamed_441, fragment_unnamed_435.x);
					fragment_unnamed_488 = mad(fragment_unnamed_381, fragment_unnamed_441, fragment_unnamed_435.y);
					fragment_unnamed_489 = mad(fragment_unnamed_382, fragment_unnamed_441, fragment_unnamed_435.z);
					fragment_unnamed_490 = mad(fragment_unnamed_397, fragment_unnamed_448.w, fragment_unnamed_448.z);
				}
				else
				{
					fragment_unnamed_484 = fragment_unnamed_420;
					fragment_unnamed_485 = fragment_unnamed_421;
					fragment_unnamed_486 = fragment_unnamed_422;
					fragment_unnamed_487 = fragment_unnamed_380;
					fragment_unnamed_488 = fragment_unnamed_381;
					fragment_unnamed_489 = fragment_unnamed_382;
					fragment_unnamed_490 = fragment_unnamed_397;
				}
				float fragment_unnamed_494 = max(dot(float3(fragment_unnamed_484, fragment_unnamed_485, fragment_unnamed_486), float3(fragment_unnamed_239 * fragment_unnamed_221, fragment_unnamed_239 * fragment_unnamed_228, fragment_unnamed_239 * fragment_unnamed_235)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_497 = ((-0.0f) - fragment_unnamed_490) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_399 + exp2(log2(abs(fragment_unnamed_399 + fragment_unnamed_494)) * exp2(mad(fragment_unnamed_497 * fragment_unnamed_497, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_525 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_526 = fragment_unnamed_525.x;
				float fragment_unnamed_812;
				float fragment_unnamed_814;
				float fragment_unnamed_816;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_526 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_526 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_813;
					float fragment_unnamed_815;
					float fragment_unnamed_817;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_549 = asfloat(1065353216u);
						float fragment_unnamed_579 = fragment_unnamed_485 * fragment_unnamed_484;
						float fragment_unnamed_580 = fragment_unnamed_486 * fragment_unnamed_485;
						float fragment_unnamed_581 = fragment_unnamed_486 * fragment_unnamed_486;
						float fragment_unnamed_582 = fragment_unnamed_484 * fragment_unnamed_486;
						float fragment_unnamed_615 = mad(fragment_unnamed_484, fragment_unnamed_484, (-0.0f) - (fragment_unnamed_485 * fragment_unnamed_485));
						fragment_unnamed_813 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_484, fragment_unnamed_485, fragment_unnamed_486, fragment_unnamed_549)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_615, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_579, fragment_unnamed_580, fragment_unnamed_581, fragment_unnamed_582)));
						fragment_unnamed_815 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_484, fragment_unnamed_485, fragment_unnamed_486, fragment_unnamed_549)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_615, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_579, fragment_unnamed_580, fragment_unnamed_581, fragment_unnamed_582)));
						fragment_unnamed_817 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_484, fragment_unnamed_485, fragment_unnamed_486, fragment_unnamed_549)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_615, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_579, fragment_unnamed_580, fragment_unnamed_581, fragment_unnamed_582)));
					}
					else
					{
						bool fragment_unnamed_631 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_632 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_654 = fragment_unnamed_631 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_655 = fragment_unnamed_631 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_656 = fragment_unnamed_631 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_760 = (asfloat(fragment_unnamed_632 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_656, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_654, fragment_unnamed_655 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_655)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_761 = (asfloat(fragment_unnamed_632 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_656, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_654, fragment_unnamed_655 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_656)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_775 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_632 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_656, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_654, fragment_unnamed_655 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_654)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_802 = asfloat(1065353216u);
						fragment_unnamed_813 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_775, fragment_unnamed_760, fragment_unnamed_761), 0.0f)), float4(fragment_unnamed_484, fragment_unnamed_485, fragment_unnamed_486, fragment_unnamed_802));
						fragment_unnamed_815 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_775 + 0.25f, fragment_unnamed_760 + 0.0f, fragment_unnamed_761 + 0.0f), 0.0f)), float4(fragment_unnamed_484, fragment_unnamed_485, fragment_unnamed_486, fragment_unnamed_802));
						fragment_unnamed_817 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_775 + 0.5f, fragment_unnamed_760 + 0.0f, fragment_unnamed_761 + 0.0f), 0.0f)), float4(fragment_unnamed_484, fragment_unnamed_485, fragment_unnamed_486, fragment_unnamed_802));
					}
					fragment_unnamed_812 = fragment_unnamed_813;
					fragment_unnamed_814 = fragment_unnamed_815;
					fragment_unnamed_816 = fragment_unnamed_817;
				}
				else
				{
					fragment_unnamed_812 = asfloat(0u);
					fragment_unnamed_814 = asfloat(0u);
					fragment_unnamed_816 = asfloat(0u);
				}
				float fragment_unnamed_819 = ((-0.0f) - fragment_unnamed_393) + 1.0f;
				float fragment_unnamed_820 = fragment_unnamed_819 * fragment_unnamed_487;
				float fragment_unnamed_821 = fragment_unnamed_819 * fragment_unnamed_488;
				float fragment_unnamed_822 = fragment_unnamed_819 * fragment_unnamed_489;
				float fragment_unnamed_827 = mad(fragment_unnamed_393, fragment_unnamed_487 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_829 = mad(fragment_unnamed_393, fragment_unnamed_488 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_830 = mad(fragment_unnamed_393, fragment_unnamed_489 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_842 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_494), 0.984375f, 0.0078125f), mad(fragment_unnamed_497, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_852 = clamp((max(fragment_unnamed_830, max(fragment_unnamed_829, fragment_unnamed_827)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_876 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_881 = max(abs(fragment_unnamed_486), 0.0009765625f);
				float fragment_unnamed_885 = (fragment_unnamed_486 >= 0.0f) ? fragment_unnamed_881 : ((-0.0f) - fragment_unnamed_881);
				float fragment_unnamed_894 = 1.0f / max(dot(float3(abs(fragment_unnamed_484), abs(fragment_unnamed_485), abs(fragment_unnamed_885)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_899 = clamp((-0.0f) - (fragment_unnamed_894 * fragment_unnamed_885), 0.0f, 1.0f);
				float fragment_unnamed_902 = (-0.0f) - fragment_unnamed_899;
				uint fragment_unnamed_914 = uint(clamp(mad(mad(fragment_unnamed_484, fragment_unnamed_894, ((fragment_unnamed_894 * fragment_unnamed_484) >= 0.0f) ? fragment_unnamed_899 : fragment_unnamed_902), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_915 = uint(clamp(mad(mad(fragment_unnamed_485, fragment_unnamed_894, ((fragment_unnamed_894 * fragment_unnamed_485) >= 0.0f) ? fragment_unnamed_899 : fragment_unnamed_902), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_914 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_915 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_915 >> 8u) * 16u) + (fragment_unnamed_914 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_827)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_829)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_830)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_967 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_968 = fragment_unnamed_967 * mad(fragment_unnamed_876 * ((fragment_unnamed_842 * mad(fragment_unnamed_852, mad((-0.0f) - fragment_unnamed_487, fragment_unnamed_819, fragment_unnamed_827), fragment_unnamed_820)) * fragment_unnamed_812), fragment_unnamed_399, mad(fragment_unnamed_373, (-0.0f) - fragment_unnamed_330, fragment_unnamed_330));
				float fragment_unnamed_969 = fragment_unnamed_967 * mad(fragment_unnamed_876 * ((fragment_unnamed_842 * mad(fragment_unnamed_852, mad((-0.0f) - fragment_unnamed_488, fragment_unnamed_819, fragment_unnamed_829), fragment_unnamed_821)) * fragment_unnamed_814), fragment_unnamed_399, mad(fragment_unnamed_373, (-0.0f) - fragment_unnamed_331, fragment_unnamed_331));
				float fragment_unnamed_970 = fragment_unnamed_967 * mad(fragment_unnamed_876 * ((fragment_unnamed_842 * mad(fragment_unnamed_852, mad((-0.0f) - fragment_unnamed_489, fragment_unnamed_819, fragment_unnamed_830), fragment_unnamed_822)) * fragment_unnamed_816), fragment_unnamed_399, mad(fragment_unnamed_373, (-0.0f) - fragment_unnamed_332, fragment_unnamed_332));
				bool fragment_unnamed_983 = (((fragment_unnamed_970 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_969 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_968 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_983 ? asfloat(1157627904u) : fragment_unnamed_968;
				fragment_output_3.y = fragment_unnamed_983 ? fragment_unnamed_399 : fragment_unnamed_969;
				fragment_output_3.z = fragment_unnamed_983 ? asfloat(1149239296u) : fragment_unnamed_970;
				fragment_output_0.x = fragment_unnamed_820;
				fragment_output_0.y = fragment_unnamed_821;
				fragment_output_0.z = fragment_unnamed_822;
				fragment_output_1.w = fragment_unnamed_497;
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

				fragment_uniform_buffer_2[8] = float4(_Emission[0], _Emission[1], _Emission[2], _Emission[3]);

				fragment_uniform_buffer_2[9] = float4(_UseMaskMap, fragment_uniform_buffer_2[9][1], fragment_uniform_buffer_2[9][2], fragment_uniform_buffer_2[9][3]);

				fragment_uniform_buffer_2[9] = float4(fragment_uniform_buffer_2[9][0], _Progress, fragment_uniform_buffer_2[9][2], fragment_uniform_buffer_2[9][3]);

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

			#endif // defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON)


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
			GpuProgramID 763496

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
			GpuProgramID 805061

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
			GpuProgramID 890302

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
			GpuProgramID 971404

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
			GpuProgramID 985418

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
			GpuProgramID 1094757

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
