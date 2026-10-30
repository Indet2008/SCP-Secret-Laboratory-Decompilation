Shader "Shader Graphs/Scp3114Disguise"
{
	Properties
	{
		[NoScaleOffset] _BaseColorMap ("BaseColorMap", 2D) = "white" {}
		[NoScaleOffset] _NormalMap ("NormalMap", 2D) = "white" {}
		[NoScaleOffset] _EmissionMap ("EmissionMap", 2D) = "black" {}
		[HDR] _Emission ("Emission", Color) = (0,0,0,0)
		_Progress ("Progress", Range(0, 1)) = 0.5
		[ToggleUI] _UseMaskMap ("UseMaskMap", Float) = 1
		[NoScaleOffset] _MaskMap ("MaskMap", 2D) = "white" {}
		[NoScaleOffset] _HDRPLit_9ccede5c759f47328be7a7de0be3904b_DetailMap_913208011_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
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
			GpuProgramID 43899

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
			float _Progress;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;

			static bool gl_FrontFacing;
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
				bool gl_FrontFacing : SV_IsFrontFace;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_106)
			{
				if (fragment_unnamed_106)
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
				discard_cond((mad(_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y).x, _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y).x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_1[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_1[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-2.0f)) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
				gl_FrontFacing = stage_input.gl_FrontFacing;
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
			GpuProgramID 323171

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DISABLE_DECALS
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)
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

			#endif // !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)


			#if defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)
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


			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			float _Progress;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[11];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;

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
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_193)
			{
				if (fragment_unnamed_193)
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
				discard_cond((mad(_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x, _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_2[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_2[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-2.0f)) < 0.0f);
				float fragment_unnamed_135 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_136 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_182 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_182 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_135) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_135)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_182 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_136) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_136)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[10] = float4(fragment_uniform_buffer_2[10][0], _Progress, fragment_uniform_buffer_2[10][2], fragment_uniform_buffer_2[10][3]);

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
				return stage_output;
			}

			#endif // defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Progress;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[11];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_222)
			{
				if (fragment_unnamed_222)
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
				discard_cond((mad(_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x, _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_2[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_2[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-2.0f)) < 0.0f);
				float fragment_unnamed_136 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_137 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_183 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_183 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_136) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_136)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_183 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_137) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_137)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				uint fragment_unnamed_200 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_200, min((8u & 31u), (32u - fragment_unnamed_200)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = 0.5f;
				fragment_output_1.w = 0.5f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[10] = float4(fragment_uniform_buffer_2[10][0], _Progress, fragment_uniform_buffer_2[10][2], fragment_uniform_buffer_2[10][3]);

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_DOUBLESIDED_ON)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Progress;
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[14];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_290)
			{
				if (fragment_unnamed_290)
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
				discard_cond((mad(_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x, _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_2[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_2[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-2.0f)) < 0.0f);
				float fragment_unnamed_136 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_137 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_183 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_183 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_136) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_136)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_183 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_137) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_137)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_210 = 1.0f / max(sqrt(dot(float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z), float3(fragment_input_9.x, fragment_input_9.y, fragment_input_9.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_232 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 1065353216u : asuint(fragment_uniform_buffer_2[13u]).z);
				float fragment_unnamed_233 = (fragment_unnamed_210 * fragment_input_9.x) * fragment_unnamed_232;
				float fragment_unnamed_234 = (fragment_unnamed_210 * fragment_input_9.y) * fragment_unnamed_232;
				float fragment_unnamed_235 = (fragment_unnamed_210 * fragment_input_9.z) * fragment_unnamed_232;
				float fragment_unnamed_244 = 1.0f / max(dot(float3(abs(fragment_unnamed_233), abs(fragment_unnamed_234), abs(fragment_unnamed_235)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_249 = clamp((-0.0f) - (fragment_unnamed_244 * fragment_unnamed_235), 0.0f, 1.0f);
				float fragment_unnamed_252 = (-0.0f) - fragment_unnamed_249;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_233, fragment_unnamed_244, ((fragment_unnamed_244 * fragment_unnamed_233) >= 0.0f) ? fragment_unnamed_249 : fragment_unnamed_252), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_234, fragment_unnamed_244, ((fragment_unnamed_244 * fragment_unnamed_234) >= 0.0f) ? fragment_unnamed_249 : fragment_unnamed_252), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_270 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_270, min((8u & 31u), (32u - fragment_unnamed_270)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[10] = float4(fragment_uniform_buffer_2[10][0], _Progress, fragment_uniform_buffer_2[10][2], fragment_uniform_buffer_2[10][3]);

				fragment_uniform_buffer_2[13] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)


			#if defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			float _Progress;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[11];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;

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
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_193)
			{
				if (fragment_unnamed_193)
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
				discard_cond((mad(_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x, _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_2[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_2[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-2.0f)) < 0.0f);
				float fragment_unnamed_135 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_136 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_182 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_182 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_135) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_135)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_182 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_136) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_136)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[10] = float4(fragment_uniform_buffer_2[10][0], _Progress, fragment_uniform_buffer_2[10][2], fragment_uniform_buffer_2[10][3]);

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
				return stage_output;
			}

			#endif // defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)
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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)


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
			GpuProgramID 464644

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DISABLE_DECALS
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[19];
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
				if ((((0.0f < vertex_uniform_buffer_2[18u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[18] = float4(vertex_uniform_buffer_2[18][0], vertex_uniform_buffer_2[18][1], _RayTracing, vertex_uniform_buffer_2[18][3]);

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

			#endif // !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)


			#if defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[19];
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
				if ((((0.0f < vertex_uniform_buffer_2[18u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[18] = float4(vertex_uniform_buffer_2[18][0], vertex_uniform_buffer_2[18][1], _RayTracing, vertex_uniform_buffer_2[18][3]);

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
			static float4 fragment_uniform_buffer_1[11];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;

			static bool gl_FrontFacing;
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
				bool gl_FrontFacing : SV_IsFrontFace;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_108)
			{
				if (fragment_unnamed_108)
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
				discard_cond((mad(_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x, _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_1[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_1[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-2.0f)) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
				gl_FrontFacing = stage_input.gl_FrontFacing;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
			}

			#endif // defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _GlobalMipBias;
			float _Progress;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;

			static bool gl_FrontFacing;
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
				bool gl_FrontFacing : SV_IsFrontFace;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_108)
			{
				if (fragment_unnamed_108)
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
				discard_cond((mad(_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x, _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_1[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_1[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-2.0f)) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
				gl_FrontFacing = stage_input.gl_FrontFacing;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
			}

			#endif // defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_DOUBLESIDED_ON)


			#if defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Progress;
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			static float4 fragment_uniform_buffer_2[14];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_216)
			{
				if (fragment_unnamed_216)
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
				discard_cond((mad(_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x, _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_2[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_2[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-2.0f)) < 0.0f);
				float fragment_unnamed_132 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_154 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 1065353216u : asuint(fragment_uniform_buffer_2[13u]).z);
				float fragment_unnamed_155 = (fragment_unnamed_132 * fragment_input_7.x) * fragment_unnamed_154;
				float fragment_unnamed_156 = (fragment_unnamed_132 * fragment_input_7.y) * fragment_unnamed_154;
				float fragment_unnamed_157 = (fragment_unnamed_132 * fragment_input_7.z) * fragment_unnamed_154;
				float fragment_unnamed_166 = 1.0f / max(dot(float3(abs(fragment_unnamed_155), abs(fragment_unnamed_156), abs(fragment_unnamed_157)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_172 = clamp((-0.0f) - (fragment_unnamed_166 * fragment_unnamed_157), 0.0f, 1.0f);
				float fragment_unnamed_175 = (-0.0f) - fragment_unnamed_172;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_155, fragment_unnamed_166, ((fragment_unnamed_166 * fragment_unnamed_155) >= 0.0f) ? fragment_unnamed_172 : fragment_unnamed_175), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_156, fragment_unnamed_166, ((fragment_unnamed_166 * fragment_unnamed_156) >= 0.0f) ? fragment_unnamed_172 : fragment_unnamed_175), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_196 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_196, min((8u & 31u), (32u - fragment_unnamed_196)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[10] = float4(fragment_uniform_buffer_2[10][0], _Progress, fragment_uniform_buffer_2[10][2], fragment_uniform_buffer_2[10][3]);

				fragment_uniform_buffer_2[13] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

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

			#endif // defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)


			#if defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)
			#define ANY_SHADER_VARIANT_ACTIVE

			float _GlobalMipBias;
			float _Progress;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;

			static bool gl_FrontFacing;
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
				bool gl_FrontFacing : SV_IsFrontFace;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_108)
			{
				if (fragment_unnamed_108)
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
				discard_cond((mad(_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x, _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_1[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_1[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-2.0f)) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
				gl_FrontFacing = stage_input.gl_FrontFacing;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				frag_main();
			}

			#endif // defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)
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

			#endif // defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)


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
			GpuProgramID 535004

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature DECALS_3RT
			#pragma shader_feature _ALPHATEST_ON
			#pragma shader_feature _DISABLE_DECALS
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[19];
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
				if ((((0.0f < vertex_uniform_buffer_2[18u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[18] = float4(vertex_uniform_buffer_2[18][0], vertex_uniform_buffer_2[18][1], _RayTracing, vertex_uniform_buffer_2[18][3]);

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

			#endif // !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_DISABLE_DECALS)


			#if defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[19];
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
				if ((((0.0f < vertex_uniform_buffer_2[18u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[18] = float4(vertex_uniform_buffer_2[18][0], vertex_uniform_buffer_2[18][1], _RayTracing, vertex_uniform_buffer_2[18][3]);

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

			#endif // defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_DISABLE_DECALS)


			#if defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_DOUBLESIDED_ON)
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
			static float4 fragment_uniform_buffer_2[14];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorMap;
			Texture2D<float4> _NormalMap;
			Texture2D<float4> _MaskMap;
			Texture2D<float4> _EmissionMap;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D;
			SamplerState sampler_BaseColorMap;
			SamplerState sampler_NormalMap;
			SamplerState sampler_MaskMap;
			SamplerState sampler_EmissionMap;

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
				uint4 fragment_unnamed_250 = asuint(fragment_uniform_buffer_2[13u]);
				float fragment_unnamed_254 = asfloat(fragment_unnamed_246 ? 1065353216u : fragment_unnamed_250.z);
				float fragment_unnamed_256 = asfloat(fragment_unnamed_246 ? 1065353216u : fragment_unnamed_250.x);
				bool fragment_unnamed_264 = 0.0f != fragment_uniform_buffer_2[10u].x;
				float fragment_unnamed_270 = asfloat(fragment_unnamed_264 ? 1065353216u : 1036831949u);
				float4 fragment_unnamed_281 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_284 = fragment_unnamed_281.x;
				float fragment_unnamed_285 = fragment_unnamed_281.y;
				float fragment_unnamed_286 = fragment_unnamed_281.z;
				float4 fragment_unnamed_295 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_298 = fragment_unnamed_295.y;
				float fragment_unnamed_299 = fragment_unnamed_295.w;
				float4 fragment_unnamed_308 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_314 = mad(fragment_unnamed_308.x * fragment_unnamed_308.w, 2.0f, -1.0f);
				float fragment_unnamed_317 = mad(fragment_unnamed_308.y, 2.0f, -1.0f);
				float fragment_unnamed_325 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_314, fragment_unnamed_317), float2(fragment_unnamed_314, fragment_unnamed_317)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_327 = asfloat((fragment_unnamed_264 ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_295.x;
				float4 fragment_unnamed_336 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_346 = fragment_unnamed_336.x * fragment_uniform_buffer_2[9u].x;
				float fragment_unnamed_347 = fragment_unnamed_336.y * fragment_uniform_buffer_2[9u].y;
				float fragment_unnamed_348 = fragment_unnamed_336.z * fragment_uniform_buffer_2[9u].z;
				float4 fragment_unnamed_380 = _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_391 = _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_404 = _SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_417 = _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_431 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? asuint(clamp(mad(mad(fragment_unnamed_380.x, fragment_unnamed_391.x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_2[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_2[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-1.0f), -14.2857151031494140625f, 15.0f), 0.0f, 1.0f)) : 1065353216u);
				float fragment_unnamed_438 = mad(fragment_unnamed_431, ((-0.0f) - fragment_unnamed_284) + fragment_unnamed_404.x, fragment_unnamed_284);
				float fragment_unnamed_439 = mad(fragment_unnamed_431, ((-0.0f) - fragment_unnamed_285) + fragment_unnamed_404.y, fragment_unnamed_285);
				float fragment_unnamed_440 = mad(fragment_unnamed_431, ((-0.0f) - fragment_unnamed_286) + fragment_unnamed_404.z, fragment_unnamed_286);
				float fragment_unnamed_449 = mad(fragment_unnamed_431, ((-0.0f) - fragment_unnamed_325) + fragment_unnamed_417.z, fragment_unnamed_325);
				float fragment_unnamed_451 = mad(fragment_unnamed_431, (-0.0f) - fragment_unnamed_327, fragment_unnamed_327);
				float fragment_unnamed_457 = mad(fragment_unnamed_431, (-0.0f) - fragment_unnamed_298, fragment_unnamed_298);
				float fragment_unnamed_464 = fragment_unnamed_256 * mad(fragment_unnamed_431, ((-0.0f) - fragment_unnamed_314) + fragment_unnamed_417.x, fragment_unnamed_314);
				float fragment_unnamed_465 = fragment_unnamed_256 * mad(fragment_unnamed_431, ((-0.0f) - fragment_unnamed_317) + fragment_unnamed_417.y, fragment_unnamed_317);
				float fragment_unnamed_472 = mad(fragment_unnamed_449, (fragment_unnamed_113 * fragment_input_7.x) * fragment_unnamed_254, mad(fragment_unnamed_464, fragment_unnamed_113 * fragment_input_1.x, (fragment_unnamed_113 * (fragment_unnamed_132 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_465));
				float fragment_unnamed_473 = mad(fragment_unnamed_449, (fragment_unnamed_113 * fragment_input_7.y) * fragment_unnamed_254, mad(fragment_unnamed_464, fragment_unnamed_113 * fragment_input_1.y, (fragment_unnamed_113 * (fragment_unnamed_132 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_465));
				float fragment_unnamed_474 = mad(fragment_unnamed_449, (fragment_unnamed_113 * fragment_input_7.z) * fragment_unnamed_254, mad(fragment_unnamed_464, fragment_unnamed_113 * fragment_input_1.z, (fragment_unnamed_113 * (fragment_unnamed_132 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_465));
				float fragment_unnamed_479 = rsqrt(max(dot(float3(fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_474), float3(fragment_unnamed_472, fragment_unnamed_473, fragment_unnamed_474)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_480 = fragment_unnamed_472 * fragment_unnamed_479;
				float fragment_unnamed_481 = fragment_unnamed_473 * fragment_unnamed_479;
				float fragment_unnamed_482 = fragment_unnamed_474 * fragment_unnamed_479;
				float fragment_unnamed_486 = max(dot(float3(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482), float3(fragment_unnamed_239 * fragment_unnamed_221, fragment_unnamed_239 * fragment_unnamed_228, fragment_unnamed_239 * fragment_unnamed_235)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_489 = ((-0.0f) - mad(fragment_unnamed_431, mad((-0.0f) - fragment_unnamed_299, fragment_unnamed_270, 0.800000011920928955078125f), fragment_unnamed_270 * fragment_unnamed_299)) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_457 + exp2(log2(abs(fragment_unnamed_457 + fragment_unnamed_486)) * exp2(mad(fragment_unnamed_489 * fragment_unnamed_489, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_517 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_518 = fragment_unnamed_517.x;
				float fragment_unnamed_802;
				float fragment_unnamed_804;
				float fragment_unnamed_806;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_518 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_518 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_803;
					float fragment_unnamed_805;
					float fragment_unnamed_807;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_541 = asfloat(1065353216u);
						float fragment_unnamed_569 = fragment_unnamed_481 * fragment_unnamed_480;
						float fragment_unnamed_570 = fragment_unnamed_482 * fragment_unnamed_481;
						float fragment_unnamed_571 = fragment_unnamed_482 * fragment_unnamed_482;
						float fragment_unnamed_572 = fragment_unnamed_480 * fragment_unnamed_482;
						float fragment_unnamed_605 = mad(fragment_unnamed_480, fragment_unnamed_480, (-0.0f) - (fragment_unnamed_481 * fragment_unnamed_481));
						fragment_unnamed_803 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482, fragment_unnamed_541)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_605, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_569, fragment_unnamed_570, fragment_unnamed_571, fragment_unnamed_572)));
						fragment_unnamed_805 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482, fragment_unnamed_541)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_605, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_569, fragment_unnamed_570, fragment_unnamed_571, fragment_unnamed_572)));
						fragment_unnamed_807 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482, fragment_unnamed_541)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_605, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_569, fragment_unnamed_570, fragment_unnamed_571, fragment_unnamed_572)));
					}
					else
					{
						bool fragment_unnamed_621 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_622 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_644 = fragment_unnamed_621 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_645 = fragment_unnamed_621 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_646 = fragment_unnamed_621 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_750 = (asfloat(fragment_unnamed_622 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_646, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_644, fragment_unnamed_645 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_645)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_751 = (asfloat(fragment_unnamed_622 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_646, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_644, fragment_unnamed_645 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_646)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_765 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_622 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_646, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_644, fragment_unnamed_645 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_644)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_792 = asfloat(1065353216u);
						fragment_unnamed_803 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_765, fragment_unnamed_750, fragment_unnamed_751), 0.0f)), float4(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482, fragment_unnamed_792));
						fragment_unnamed_805 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_765 + 0.25f, fragment_unnamed_750 + 0.0f, fragment_unnamed_751 + 0.0f), 0.0f)), float4(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482, fragment_unnamed_792));
						fragment_unnamed_807 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_765 + 0.5f, fragment_unnamed_750 + 0.0f, fragment_unnamed_751 + 0.0f), 0.0f)), float4(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482, fragment_unnamed_792));
					}
					fragment_unnamed_802 = fragment_unnamed_803;
					fragment_unnamed_804 = fragment_unnamed_805;
					fragment_unnamed_806 = fragment_unnamed_807;
				}
				else
				{
					fragment_unnamed_802 = asfloat(0u);
					fragment_unnamed_804 = asfloat(0u);
					fragment_unnamed_806 = asfloat(0u);
				}
				float fragment_unnamed_809 = ((-0.0f) - fragment_unnamed_451) + 1.0f;
				float fragment_unnamed_810 = fragment_unnamed_809 * fragment_unnamed_438;
				float fragment_unnamed_811 = fragment_unnamed_809 * fragment_unnamed_439;
				float fragment_unnamed_812 = fragment_unnamed_809 * fragment_unnamed_440;
				float fragment_unnamed_817 = mad(fragment_unnamed_451, fragment_unnamed_438 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_819 = mad(fragment_unnamed_451, fragment_unnamed_439 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_820 = mad(fragment_unnamed_451, fragment_unnamed_440 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_832 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_486), 0.984375f, 0.0078125f), mad(fragment_unnamed_489, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_842 = clamp((max(fragment_unnamed_820, max(fragment_unnamed_819, fragment_unnamed_817)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_866 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_871 = max(abs(fragment_unnamed_482), 0.0009765625f);
				float fragment_unnamed_875 = (fragment_unnamed_482 >= 0.0f) ? fragment_unnamed_871 : ((-0.0f) - fragment_unnamed_871);
				float fragment_unnamed_884 = 1.0f / max(dot(float3(abs(fragment_unnamed_480), abs(fragment_unnamed_481), abs(fragment_unnamed_875)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_889 = clamp((-0.0f) - (fragment_unnamed_884 * fragment_unnamed_875), 0.0f, 1.0f);
				float fragment_unnamed_892 = (-0.0f) - fragment_unnamed_889;
				uint fragment_unnamed_904 = uint(clamp(mad(mad(fragment_unnamed_480, fragment_unnamed_884, ((fragment_unnamed_884 * fragment_unnamed_480) >= 0.0f) ? fragment_unnamed_889 : fragment_unnamed_892), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_905 = uint(clamp(mad(mad(fragment_unnamed_481, fragment_unnamed_884, ((fragment_unnamed_884 * fragment_unnamed_481) >= 0.0f) ? fragment_unnamed_889 : fragment_unnamed_892), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_904 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_905 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_905 >> 8u) * 16u) + (fragment_unnamed_904 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_817)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_819)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_820)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_958 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_959 = fragment_unnamed_958 * mad(fragment_unnamed_866 * ((fragment_unnamed_832 * mad(fragment_unnamed_842, mad((-0.0f) - fragment_unnamed_438, fragment_unnamed_809, fragment_unnamed_817), fragment_unnamed_810)) * fragment_unnamed_802), fragment_unnamed_457, mad(fragment_unnamed_431, (-0.0f) - fragment_unnamed_346, fragment_unnamed_346));
				float fragment_unnamed_960 = fragment_unnamed_958 * mad(fragment_unnamed_866 * ((fragment_unnamed_832 * mad(fragment_unnamed_842, mad((-0.0f) - fragment_unnamed_439, fragment_unnamed_809, fragment_unnamed_819), fragment_unnamed_811)) * fragment_unnamed_804), fragment_unnamed_457, mad(fragment_unnamed_431, (-0.0f) - fragment_unnamed_347, fragment_unnamed_347));
				float fragment_unnamed_961 = fragment_unnamed_958 * mad(fragment_unnamed_866 * ((fragment_unnamed_832 * mad(fragment_unnamed_842, mad((-0.0f) - fragment_unnamed_440, fragment_unnamed_809, fragment_unnamed_820), fragment_unnamed_812)) * fragment_unnamed_806), fragment_unnamed_457, mad(fragment_unnamed_431, (-0.0f) - fragment_unnamed_348, fragment_unnamed_348));
				bool fragment_unnamed_974 = (((fragment_unnamed_961 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_960 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_959 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_974 ? asfloat(1157627904u) : fragment_unnamed_959;
				fragment_output_3.y = fragment_unnamed_974 ? fragment_unnamed_457 : fragment_unnamed_960;
				fragment_output_3.z = fragment_unnamed_974 ? asfloat(1149239296u) : fragment_unnamed_961;
				fragment_output_0.x = fragment_unnamed_810;
				fragment_output_0.y = fragment_unnamed_811;
				fragment_output_0.z = fragment_unnamed_812;
				fragment_output_1.w = fragment_unnamed_489;
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

				fragment_uniform_buffer_2[13] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

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

			#endif // defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DISABLE_DECALS) && defined(_DOUBLESIDED_ON)


			#if defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

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
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[14];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
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
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
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
				float fragment_unnamed_121 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_140 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_203 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_229 = asfloat(fragment_unnamed_203 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_236 = asfloat(fragment_unnamed_203 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_243 = asfloat(fragment_unnamed_203 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_247 = rsqrt(dot(float3(fragment_unnamed_229, fragment_unnamed_236, fragment_unnamed_243), float3(fragment_unnamed_229, fragment_unnamed_236, fragment_unnamed_243)));
				bool fragment_unnamed_254 = (gl_FrontFacing ? 4294967295u : 0u) != 0u;
				uint4 fragment_unnamed_258 = asuint(fragment_uniform_buffer_2[13u]);
				float fragment_unnamed_262 = asfloat(fragment_unnamed_254 ? 1065353216u : fragment_unnamed_258.z);
				float fragment_unnamed_264 = asfloat(fragment_unnamed_254 ? 1065353216u : fragment_unnamed_258.x);
				bool fragment_unnamed_272 = 0.0f != fragment_uniform_buffer_2[10u].x;
				float fragment_unnamed_278 = asfloat(fragment_unnamed_272 ? 1065353216u : 1036831949u);
				float4 fragment_unnamed_289 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_292 = fragment_unnamed_289.x;
				float fragment_unnamed_293 = fragment_unnamed_289.y;
				float fragment_unnamed_294 = fragment_unnamed_289.z;
				float4 fragment_unnamed_303 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_306 = fragment_unnamed_303.y;
				float fragment_unnamed_307 = fragment_unnamed_303.w;
				float4 fragment_unnamed_316 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_322 = mad(fragment_unnamed_316.x * fragment_unnamed_316.w, 2.0f, -1.0f);
				float fragment_unnamed_325 = mad(fragment_unnamed_316.y, 2.0f, -1.0f);
				float fragment_unnamed_333 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_322, fragment_unnamed_325), float2(fragment_unnamed_322, fragment_unnamed_325)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_335 = asfloat((fragment_unnamed_272 ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_303.x;
				float4 fragment_unnamed_344 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_354 = fragment_unnamed_344.x * fragment_uniform_buffer_2[9u].x;
				float fragment_unnamed_355 = fragment_unnamed_344.y * fragment_uniform_buffer_2[9u].y;
				float fragment_unnamed_356 = fragment_unnamed_344.z * fragment_uniform_buffer_2[9u].z;
				float4 fragment_unnamed_388 = _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_399 = _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_412 = _SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_425 = _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_439 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? asuint(clamp(mad(mad(fragment_unnamed_388.x, fragment_unnamed_399.x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_2[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_2[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-1.0f), -14.2857151031494140625f, 15.0f), 0.0f, 1.0f)) : 1065353216u);
				float fragment_unnamed_446 = mad(fragment_unnamed_439, ((-0.0f) - fragment_unnamed_292) + fragment_unnamed_412.x, fragment_unnamed_292);
				float fragment_unnamed_447 = mad(fragment_unnamed_439, ((-0.0f) - fragment_unnamed_293) + fragment_unnamed_412.y, fragment_unnamed_293);
				float fragment_unnamed_448 = mad(fragment_unnamed_439, ((-0.0f) - fragment_unnamed_294) + fragment_unnamed_412.z, fragment_unnamed_294);
				float fragment_unnamed_457 = mad(fragment_unnamed_439, ((-0.0f) - fragment_unnamed_333) + fragment_unnamed_425.z, fragment_unnamed_333);
				float fragment_unnamed_459 = mad(fragment_unnamed_439, (-0.0f) - fragment_unnamed_335, fragment_unnamed_335);
				float fragment_unnamed_463 = mad(fragment_unnamed_439, mad((-0.0f) - fragment_unnamed_307, fragment_unnamed_278, 0.800000011920928955078125f), fragment_unnamed_278 * fragment_unnamed_307);
				float fragment_unnamed_465 = mad(fragment_unnamed_439, (-0.0f) - fragment_unnamed_306, fragment_unnamed_306);
				float fragment_unnamed_472 = fragment_unnamed_264 * mad(fragment_unnamed_439, ((-0.0f) - fragment_unnamed_322) + fragment_unnamed_425.x, fragment_unnamed_322);
				float fragment_unnamed_473 = fragment_unnamed_264 * mad(fragment_unnamed_439, ((-0.0f) - fragment_unnamed_325) + fragment_unnamed_425.y, fragment_unnamed_325);
				float fragment_unnamed_480 = mad(fragment_unnamed_457, (fragment_unnamed_121 * fragment_input_7.x) * fragment_unnamed_262, mad(fragment_unnamed_472, fragment_unnamed_121 * fragment_input_1.x, (fragment_unnamed_121 * (fragment_unnamed_140 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_473));
				float fragment_unnamed_481 = mad(fragment_unnamed_457, (fragment_unnamed_121 * fragment_input_7.y) * fragment_unnamed_262, mad(fragment_unnamed_472, fragment_unnamed_121 * fragment_input_1.y, (fragment_unnamed_121 * (fragment_unnamed_140 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_473));
				float fragment_unnamed_482 = mad(fragment_unnamed_457, (fragment_unnamed_121 * fragment_input_7.z) * fragment_unnamed_262, mad(fragment_unnamed_472, fragment_unnamed_121 * fragment_input_1.z, (fragment_unnamed_121 * (fragment_unnamed_140 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_473));
				float fragment_unnamed_487 = rsqrt(max(dot(float3(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482), float3(fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_482)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_488 = fragment_unnamed_480 * fragment_unnamed_487;
				float fragment_unnamed_489 = fragment_unnamed_481 * fragment_unnamed_487;
				float fragment_unnamed_490 = fragment_unnamed_482 * fragment_unnamed_487;
				float fragment_unnamed_554;
				float fragment_unnamed_555;
				float fragment_unnamed_556;
				float fragment_unnamed_557;
				float fragment_unnamed_558;
				float fragment_unnamed_559;
				float fragment_unnamed_560;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_501 = uint(gl_FragCoord.x);
					uint fragment_unnamed_502 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_503 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_501, fragment_unnamed_502, 0u), 0u));
					float fragment_unnamed_509 = fragment_unnamed_503.w;
					float4 fragment_unnamed_510 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_501, fragment_unnamed_502, 0u), 0u));
					float fragment_unnamed_515 = fragment_unnamed_510.w;
					float4 fragment_unnamed_516 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_501, fragment_unnamed_502, 0u), 0u));
					bool fragment_unnamed_526 = fragment_unnamed_515 < 1.0f;
					float fragment_unnamed_527 = mad(fragment_unnamed_488, fragment_unnamed_515, fragment_unnamed_264 * mad(fragment_unnamed_510.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_528 = mad(fragment_unnamed_489, fragment_unnamed_515, fragment_unnamed_264 * mad(fragment_unnamed_510.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_529 = mad(fragment_unnamed_490, fragment_unnamed_515, mad(fragment_unnamed_510.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_534 = rsqrt(max(dot(float3(fragment_unnamed_527, fragment_unnamed_528, fragment_unnamed_529), float3(fragment_unnamed_527, fragment_unnamed_528, fragment_unnamed_529)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_554 = asfloat(fragment_unnamed_526 ? asuint(fragment_unnamed_527 * fragment_unnamed_534) : asuint(fragment_unnamed_488));
					fragment_unnamed_555 = asfloat(fragment_unnamed_526 ? asuint(fragment_unnamed_528 * fragment_unnamed_534) : asuint(fragment_unnamed_489));
					fragment_unnamed_556 = asfloat(fragment_unnamed_526 ? asuint(fragment_unnamed_529 * fragment_unnamed_534) : asuint(fragment_unnamed_490));
					fragment_unnamed_557 = mad(fragment_unnamed_446, fragment_unnamed_509, fragment_unnamed_503.x);
					fragment_unnamed_558 = mad(fragment_unnamed_447, fragment_unnamed_509, fragment_unnamed_503.y);
					fragment_unnamed_559 = mad(fragment_unnamed_448, fragment_unnamed_509, fragment_unnamed_503.z);
					fragment_unnamed_560 = mad(fragment_unnamed_463, fragment_unnamed_516.w, fragment_unnamed_516.z);
				}
				else
				{
					fragment_unnamed_554 = fragment_unnamed_488;
					fragment_unnamed_555 = fragment_unnamed_489;
					fragment_unnamed_556 = fragment_unnamed_490;
					fragment_unnamed_557 = fragment_unnamed_446;
					fragment_unnamed_558 = fragment_unnamed_447;
					fragment_unnamed_559 = fragment_unnamed_448;
					fragment_unnamed_560 = fragment_unnamed_463;
				}
				float fragment_unnamed_564 = max(dot(float3(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556), float3(fragment_unnamed_247 * fragment_unnamed_229, fragment_unnamed_247 * fragment_unnamed_236, fragment_unnamed_247 * fragment_unnamed_243)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_567 = ((-0.0f) - fragment_unnamed_560) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_465 + exp2(log2(abs(fragment_unnamed_465 + fragment_unnamed_564)) * exp2(mad(fragment_unnamed_567 * fragment_unnamed_567, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_595 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_596 = fragment_unnamed_595.x;
				float fragment_unnamed_880;
				float fragment_unnamed_882;
				float fragment_unnamed_884;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_596 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_596 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_881;
					float fragment_unnamed_883;
					float fragment_unnamed_885;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_619 = asfloat(1065353216u);
						float fragment_unnamed_647 = fragment_unnamed_555 * fragment_unnamed_554;
						float fragment_unnamed_648 = fragment_unnamed_556 * fragment_unnamed_555;
						float fragment_unnamed_649 = fragment_unnamed_556 * fragment_unnamed_556;
						float fragment_unnamed_650 = fragment_unnamed_554 * fragment_unnamed_556;
						float fragment_unnamed_683 = mad(fragment_unnamed_554, fragment_unnamed_554, (-0.0f) - (fragment_unnamed_555 * fragment_unnamed_555));
						fragment_unnamed_881 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_619)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_683, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_647, fragment_unnamed_648, fragment_unnamed_649, fragment_unnamed_650)));
						fragment_unnamed_883 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_619)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_683, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_647, fragment_unnamed_648, fragment_unnamed_649, fragment_unnamed_650)));
						fragment_unnamed_885 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_619)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_683, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_647, fragment_unnamed_648, fragment_unnamed_649, fragment_unnamed_650)));
					}
					else
					{
						bool fragment_unnamed_699 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_700 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_722 = fragment_unnamed_699 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_723 = fragment_unnamed_699 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_724 = fragment_unnamed_699 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_828 = (asfloat(fragment_unnamed_700 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_724, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_722, fragment_unnamed_723 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_723)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_829 = (asfloat(fragment_unnamed_700 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_724, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_722, fragment_unnamed_723 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_724)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_843 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_700 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_724, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_722, fragment_unnamed_723 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_722)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_870 = asfloat(1065353216u);
						fragment_unnamed_881 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_843, fragment_unnamed_828, fragment_unnamed_829), 0.0f)), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_870));
						fragment_unnamed_883 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_843 + 0.25f, fragment_unnamed_828 + 0.0f, fragment_unnamed_829 + 0.0f), 0.0f)), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_870));
						fragment_unnamed_885 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_843 + 0.5f, fragment_unnamed_828 + 0.0f, fragment_unnamed_829 + 0.0f), 0.0f)), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_870));
					}
					fragment_unnamed_880 = fragment_unnamed_881;
					fragment_unnamed_882 = fragment_unnamed_883;
					fragment_unnamed_884 = fragment_unnamed_885;
				}
				else
				{
					fragment_unnamed_880 = asfloat(0u);
					fragment_unnamed_882 = asfloat(0u);
					fragment_unnamed_884 = asfloat(0u);
				}
				float fragment_unnamed_887 = ((-0.0f) - fragment_unnamed_459) + 1.0f;
				float fragment_unnamed_888 = fragment_unnamed_887 * fragment_unnamed_557;
				float fragment_unnamed_889 = fragment_unnamed_887 * fragment_unnamed_558;
				float fragment_unnamed_890 = fragment_unnamed_887 * fragment_unnamed_559;
				float fragment_unnamed_895 = mad(fragment_unnamed_459, fragment_unnamed_557 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_897 = mad(fragment_unnamed_459, fragment_unnamed_558 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_898 = mad(fragment_unnamed_459, fragment_unnamed_559 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_910 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_564), 0.984375f, 0.0078125f), mad(fragment_unnamed_567, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_920 = clamp((max(fragment_unnamed_898, max(fragment_unnamed_897, fragment_unnamed_895)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_944 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_949 = max(abs(fragment_unnamed_556), 0.0009765625f);
				float fragment_unnamed_953 = (fragment_unnamed_556 >= 0.0f) ? fragment_unnamed_949 : ((-0.0f) - fragment_unnamed_949);
				float fragment_unnamed_962 = 1.0f / max(dot(float3(abs(fragment_unnamed_554), abs(fragment_unnamed_555), abs(fragment_unnamed_953)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_967 = clamp((-0.0f) - (fragment_unnamed_962 * fragment_unnamed_953), 0.0f, 1.0f);
				float fragment_unnamed_970 = (-0.0f) - fragment_unnamed_967;
				uint fragment_unnamed_982 = uint(clamp(mad(mad(fragment_unnamed_554, fragment_unnamed_962, ((fragment_unnamed_962 * fragment_unnamed_554) >= 0.0f) ? fragment_unnamed_967 : fragment_unnamed_970), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_983 = uint(clamp(mad(mad(fragment_unnamed_555, fragment_unnamed_962, ((fragment_unnamed_962 * fragment_unnamed_555) >= 0.0f) ? fragment_unnamed_967 : fragment_unnamed_970), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_982 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_983 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_983 >> 8u) * 16u) + (fragment_unnamed_982 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_895)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_897)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_898)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_1036 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1037 = fragment_unnamed_1036 * mad(fragment_unnamed_944 * ((fragment_unnamed_910 * mad(fragment_unnamed_920, mad((-0.0f) - fragment_unnamed_557, fragment_unnamed_887, fragment_unnamed_895), fragment_unnamed_888)) * fragment_unnamed_880), fragment_unnamed_465, mad(fragment_unnamed_439, (-0.0f) - fragment_unnamed_354, fragment_unnamed_354));
				float fragment_unnamed_1038 = fragment_unnamed_1036 * mad(fragment_unnamed_944 * ((fragment_unnamed_910 * mad(fragment_unnamed_920, mad((-0.0f) - fragment_unnamed_558, fragment_unnamed_887, fragment_unnamed_897), fragment_unnamed_889)) * fragment_unnamed_882), fragment_unnamed_465, mad(fragment_unnamed_439, (-0.0f) - fragment_unnamed_355, fragment_unnamed_355));
				float fragment_unnamed_1039 = fragment_unnamed_1036 * mad(fragment_unnamed_944 * ((fragment_unnamed_910 * mad(fragment_unnamed_920, mad((-0.0f) - fragment_unnamed_559, fragment_unnamed_887, fragment_unnamed_898), fragment_unnamed_890)) * fragment_unnamed_884), fragment_unnamed_465, mad(fragment_unnamed_439, (-0.0f) - fragment_unnamed_356, fragment_unnamed_356));
				bool fragment_unnamed_1052 = (((fragment_unnamed_1039 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1038 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1037 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1052 ? asfloat(1157627904u) : fragment_unnamed_1037;
				fragment_output_3.y = fragment_unnamed_1052 ? fragment_unnamed_465 : fragment_unnamed_1038;
				fragment_output_3.z = fragment_unnamed_1052 ? asfloat(1149239296u) : fragment_unnamed_1039;
				fragment_output_0.x = fragment_unnamed_888;
				fragment_output_0.y = fragment_unnamed_889;
				fragment_output_0.z = fragment_unnamed_890;
				fragment_output_1.w = fragment_unnamed_567;
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

				fragment_uniform_buffer_2[13] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

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

			#endif // defined(DECALS_3RT) && defined(_ALPHATEST_ON) && defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)


			#if defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

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
			float4 _Emission;
			float _UseMaskMap;
			float _Progress;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[11];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
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
			SamplerState sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D;
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
				float fragment_unnamed_121 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_140 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_203 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_228 = asfloat(fragment_unnamed_203 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_235 = asfloat(fragment_unnamed_203 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_242 = asfloat(fragment_unnamed_203 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_246 = rsqrt(dot(float3(fragment_unnamed_228, fragment_unnamed_235, fragment_unnamed_242), float3(fragment_unnamed_228, fragment_unnamed_235, fragment_unnamed_242)));
				bool fragment_unnamed_254 = 0.0f != fragment_uniform_buffer_2[10u].x;
				float fragment_unnamed_261 = asfloat(fragment_unnamed_254 ? 1065353216u : 1036831949u);
				float4 fragment_unnamed_272 = _BaseColorMap.SampleBias(sampler_BaseColorMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_275 = fragment_unnamed_272.x;
				float fragment_unnamed_276 = fragment_unnamed_272.y;
				float fragment_unnamed_277 = fragment_unnamed_272.z;
				float4 fragment_unnamed_286 = _MaskMap.SampleBias(sampler_MaskMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_289 = fragment_unnamed_286.y;
				float fragment_unnamed_290 = fragment_unnamed_286.w;
				float4 fragment_unnamed_299 = _NormalMap.SampleBias(sampler_NormalMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_305 = mad(fragment_unnamed_299.x * fragment_unnamed_299.w, 2.0f, -1.0f);
				float fragment_unnamed_308 = mad(fragment_unnamed_299.y, 2.0f, -1.0f);
				float fragment_unnamed_316 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_305, fragment_unnamed_308), float2(fragment_unnamed_305, fragment_unnamed_308)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_318 = asfloat((fragment_unnamed_254 ? 4294967295u : 0u) & 1065353216u) * fragment_unnamed_286.x;
				float4 fragment_unnamed_327 = _EmissionMap.SampleBias(sampler_EmissionMap, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_337 = fragment_unnamed_327.x * fragment_uniform_buffer_2[9u].x;
				float fragment_unnamed_338 = fragment_unnamed_327.y * fragment_uniform_buffer_2[9u].y;
				float fragment_unnamed_339 = fragment_unnamed_327.z * fragment_uniform_buffer_2[9u].z;
				float4 fragment_unnamed_371 = _SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_d9337c1278564b66b6fc12f53e4cf4c5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_382 = _SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_2f29d42a56454d4789bb4bdb8957113d_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_395 = _SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_f415d0c8fe24431fa61d924117a4d8e5_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float4 fragment_unnamed_408 = _SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_9365ab304e53460981194d101515e406_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_422 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? asuint(clamp(mad(mad(fragment_unnamed_371.x, fragment_unnamed_382.x, mad(exp2(log2(asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 0u : asuint(fragment_uniform_buffer_2[10u].y * 0.300000011920928955078125f)) + fragment_uniform_buffer_2[10u].y) * 0.04500000178813934326171875f), 2.1499998569488525390625f, -0.100000001490116119384765625f)) + (-1.0f), -14.2857151031494140625f, 15.0f), 0.0f, 1.0f)) : 1065353216u);
				float fragment_unnamed_429 = mad(fragment_unnamed_422, ((-0.0f) - fragment_unnamed_275) + fragment_unnamed_395.x, fragment_unnamed_275);
				float fragment_unnamed_430 = mad(fragment_unnamed_422, ((-0.0f) - fragment_unnamed_276) + fragment_unnamed_395.y, fragment_unnamed_276);
				float fragment_unnamed_431 = mad(fragment_unnamed_422, ((-0.0f) - fragment_unnamed_277) + fragment_unnamed_395.z, fragment_unnamed_277);
				float fragment_unnamed_438 = mad(fragment_unnamed_422, ((-0.0f) - fragment_unnamed_305) + fragment_unnamed_408.x, fragment_unnamed_305);
				float fragment_unnamed_439 = mad(fragment_unnamed_422, ((-0.0f) - fragment_unnamed_308) + fragment_unnamed_408.y, fragment_unnamed_308);
				float fragment_unnamed_440 = mad(fragment_unnamed_422, ((-0.0f) - fragment_unnamed_316) + fragment_unnamed_408.z, fragment_unnamed_316);
				float fragment_unnamed_442 = mad(fragment_unnamed_422, (-0.0f) - fragment_unnamed_318, fragment_unnamed_318);
				float fragment_unnamed_446 = mad(fragment_unnamed_422, mad((-0.0f) - fragment_unnamed_290, fragment_unnamed_261, 0.800000011920928955078125f), fragment_unnamed_261 * fragment_unnamed_290);
				float fragment_unnamed_448 = mad(fragment_unnamed_422, (-0.0f) - fragment_unnamed_289, fragment_unnamed_289);
				float fragment_unnamed_461 = mad(fragment_unnamed_440, fragment_unnamed_121 * fragment_input_7.x, mad(fragment_unnamed_438, fragment_unnamed_121 * fragment_input_1.x, (fragment_unnamed_121 * (fragment_unnamed_140 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_439));
				float fragment_unnamed_462 = mad(fragment_unnamed_440, fragment_unnamed_121 * fragment_input_7.y, mad(fragment_unnamed_438, fragment_unnamed_121 * fragment_input_1.y, (fragment_unnamed_121 * (fragment_unnamed_140 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_439));
				float fragment_unnamed_463 = mad(fragment_unnamed_440, fragment_unnamed_121 * fragment_input_7.z, mad(fragment_unnamed_438, fragment_unnamed_121 * fragment_input_1.z, (fragment_unnamed_121 * (fragment_unnamed_140 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_439));
				float fragment_unnamed_468 = rsqrt(max(dot(float3(fragment_unnamed_461, fragment_unnamed_462, fragment_unnamed_463), float3(fragment_unnamed_461, fragment_unnamed_462, fragment_unnamed_463)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_469 = fragment_unnamed_461 * fragment_unnamed_468;
				float fragment_unnamed_470 = fragment_unnamed_462 * fragment_unnamed_468;
				float fragment_unnamed_471 = fragment_unnamed_463 * fragment_unnamed_468;
				float fragment_unnamed_533;
				float fragment_unnamed_534;
				float fragment_unnamed_535;
				float fragment_unnamed_536;
				float fragment_unnamed_537;
				float fragment_unnamed_538;
				float fragment_unnamed_539;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_482 = uint(gl_FragCoord.x);
					uint fragment_unnamed_483 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_484 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_482, fragment_unnamed_483, 0u), 0u));
					float fragment_unnamed_490 = fragment_unnamed_484.w;
					float4 fragment_unnamed_491 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_482, fragment_unnamed_483, 0u), 0u));
					float fragment_unnamed_496 = fragment_unnamed_491.w;
					float4 fragment_unnamed_497 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_482, fragment_unnamed_483, 0u), 0u));
					bool fragment_unnamed_505 = fragment_unnamed_496 < 1.0f;
					float fragment_unnamed_506 = mad(fragment_unnamed_469, fragment_unnamed_496, mad(fragment_unnamed_491.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_507 = mad(fragment_unnamed_470, fragment_unnamed_496, mad(fragment_unnamed_491.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_508 = mad(fragment_unnamed_471, fragment_unnamed_496, mad(fragment_unnamed_491.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_513 = rsqrt(max(dot(float3(fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_508), float3(fragment_unnamed_506, fragment_unnamed_507, fragment_unnamed_508)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_533 = asfloat(fragment_unnamed_505 ? asuint(fragment_unnamed_506 * fragment_unnamed_513) : asuint(fragment_unnamed_469));
					fragment_unnamed_534 = asfloat(fragment_unnamed_505 ? asuint(fragment_unnamed_507 * fragment_unnamed_513) : asuint(fragment_unnamed_470));
					fragment_unnamed_535 = asfloat(fragment_unnamed_505 ? asuint(fragment_unnamed_508 * fragment_unnamed_513) : asuint(fragment_unnamed_471));
					fragment_unnamed_536 = mad(fragment_unnamed_429, fragment_unnamed_490, fragment_unnamed_484.x);
					fragment_unnamed_537 = mad(fragment_unnamed_430, fragment_unnamed_490, fragment_unnamed_484.y);
					fragment_unnamed_538 = mad(fragment_unnamed_431, fragment_unnamed_490, fragment_unnamed_484.z);
					fragment_unnamed_539 = mad(fragment_unnamed_446, fragment_unnamed_497.w, fragment_unnamed_497.z);
				}
				else
				{
					fragment_unnamed_533 = fragment_unnamed_469;
					fragment_unnamed_534 = fragment_unnamed_470;
					fragment_unnamed_535 = fragment_unnamed_471;
					fragment_unnamed_536 = fragment_unnamed_429;
					fragment_unnamed_537 = fragment_unnamed_430;
					fragment_unnamed_538 = fragment_unnamed_431;
					fragment_unnamed_539 = fragment_unnamed_446;
				}
				float fragment_unnamed_543 = max(dot(float3(fragment_unnamed_533, fragment_unnamed_534, fragment_unnamed_535), float3(fragment_unnamed_246 * fragment_unnamed_228, fragment_unnamed_246 * fragment_unnamed_235, fragment_unnamed_246 * fragment_unnamed_242)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_546 = ((-0.0f) - fragment_unnamed_539) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_448 + exp2(log2(abs(fragment_unnamed_448 + fragment_unnamed_543)) * exp2(mad(fragment_unnamed_546 * fragment_unnamed_546, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_574 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_575 = fragment_unnamed_574.x;
				float fragment_unnamed_861;
				float fragment_unnamed_863;
				float fragment_unnamed_865;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_575 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_575 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_862;
					float fragment_unnamed_864;
					float fragment_unnamed_866;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_598 = asfloat(1065353216u);
						float fragment_unnamed_628 = fragment_unnamed_534 * fragment_unnamed_533;
						float fragment_unnamed_629 = fragment_unnamed_535 * fragment_unnamed_534;
						float fragment_unnamed_630 = fragment_unnamed_535 * fragment_unnamed_535;
						float fragment_unnamed_631 = fragment_unnamed_533 * fragment_unnamed_535;
						float fragment_unnamed_664 = mad(fragment_unnamed_533, fragment_unnamed_533, (-0.0f) - (fragment_unnamed_534 * fragment_unnamed_534));
						fragment_unnamed_862 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_533, fragment_unnamed_534, fragment_unnamed_535, fragment_unnamed_598)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_664, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_628, fragment_unnamed_629, fragment_unnamed_630, fragment_unnamed_631)));
						fragment_unnamed_864 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_533, fragment_unnamed_534, fragment_unnamed_535, fragment_unnamed_598)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_664, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_628, fragment_unnamed_629, fragment_unnamed_630, fragment_unnamed_631)));
						fragment_unnamed_866 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_533, fragment_unnamed_534, fragment_unnamed_535, fragment_unnamed_598)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_664, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_628, fragment_unnamed_629, fragment_unnamed_630, fragment_unnamed_631)));
					}
					else
					{
						bool fragment_unnamed_680 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_681 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_703 = fragment_unnamed_680 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_704 = fragment_unnamed_680 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_705 = fragment_unnamed_680 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_809 = (asfloat(fragment_unnamed_681 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_705, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_703, fragment_unnamed_704 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_704)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_810 = (asfloat(fragment_unnamed_681 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_705, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_703, fragment_unnamed_704 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_705)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_824 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_681 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_705, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_703, fragment_unnamed_704 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_703)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_851 = asfloat(1065353216u);
						fragment_unnamed_862 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_824, fragment_unnamed_809, fragment_unnamed_810), 0.0f)), float4(fragment_unnamed_533, fragment_unnamed_534, fragment_unnamed_535, fragment_unnamed_851));
						fragment_unnamed_864 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_824 + 0.25f, fragment_unnamed_809 + 0.0f, fragment_unnamed_810 + 0.0f), 0.0f)), float4(fragment_unnamed_533, fragment_unnamed_534, fragment_unnamed_535, fragment_unnamed_851));
						fragment_unnamed_866 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_824 + 0.5f, fragment_unnamed_809 + 0.0f, fragment_unnamed_810 + 0.0f), 0.0f)), float4(fragment_unnamed_533, fragment_unnamed_534, fragment_unnamed_535, fragment_unnamed_851));
					}
					fragment_unnamed_861 = fragment_unnamed_862;
					fragment_unnamed_863 = fragment_unnamed_864;
					fragment_unnamed_865 = fragment_unnamed_866;
				}
				else
				{
					fragment_unnamed_861 = asfloat(0u);
					fragment_unnamed_863 = asfloat(0u);
					fragment_unnamed_865 = asfloat(0u);
				}
				float fragment_unnamed_868 = ((-0.0f) - fragment_unnamed_442) + 1.0f;
				float fragment_unnamed_869 = fragment_unnamed_868 * fragment_unnamed_536;
				float fragment_unnamed_870 = fragment_unnamed_868 * fragment_unnamed_537;
				float fragment_unnamed_871 = fragment_unnamed_868 * fragment_unnamed_538;
				float fragment_unnamed_876 = mad(fragment_unnamed_442, fragment_unnamed_536 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_878 = mad(fragment_unnamed_442, fragment_unnamed_537 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_879 = mad(fragment_unnamed_442, fragment_unnamed_538 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_891 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_543), 0.984375f, 0.0078125f), mad(fragment_unnamed_546, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_901 = clamp((max(fragment_unnamed_879, max(fragment_unnamed_878, fragment_unnamed_876)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_925 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_930 = max(abs(fragment_unnamed_535), 0.0009765625f);
				float fragment_unnamed_934 = (fragment_unnamed_535 >= 0.0f) ? fragment_unnamed_930 : ((-0.0f) - fragment_unnamed_930);
				float fragment_unnamed_943 = 1.0f / max(dot(float3(abs(fragment_unnamed_533), abs(fragment_unnamed_534), abs(fragment_unnamed_934)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_948 = clamp((-0.0f) - (fragment_unnamed_943 * fragment_unnamed_934), 0.0f, 1.0f);
				float fragment_unnamed_951 = (-0.0f) - fragment_unnamed_948;
				uint fragment_unnamed_963 = uint(clamp(mad(mad(fragment_unnamed_533, fragment_unnamed_943, ((fragment_unnamed_943 * fragment_unnamed_533) >= 0.0f) ? fragment_unnamed_948 : fragment_unnamed_951), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_964 = uint(clamp(mad(mad(fragment_unnamed_534, fragment_unnamed_943, ((fragment_unnamed_943 * fragment_unnamed_534) >= 0.0f) ? fragment_unnamed_948 : fragment_unnamed_951), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_963 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_964 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_964 >> 8u) * 16u) + (fragment_unnamed_963 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_876)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_878)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_879)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_1017 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1018 = fragment_unnamed_1017 * mad(fragment_unnamed_925 * ((fragment_unnamed_891 * mad(fragment_unnamed_901, mad((-0.0f) - fragment_unnamed_536, fragment_unnamed_868, fragment_unnamed_876), fragment_unnamed_869)) * fragment_unnamed_861), fragment_unnamed_448, mad(fragment_unnamed_422, (-0.0f) - fragment_unnamed_337, fragment_unnamed_337));
				float fragment_unnamed_1019 = fragment_unnamed_1017 * mad(fragment_unnamed_925 * ((fragment_unnamed_891 * mad(fragment_unnamed_901, mad((-0.0f) - fragment_unnamed_537, fragment_unnamed_868, fragment_unnamed_878), fragment_unnamed_870)) * fragment_unnamed_863), fragment_unnamed_448, mad(fragment_unnamed_422, (-0.0f) - fragment_unnamed_338, fragment_unnamed_338));
				float fragment_unnamed_1020 = fragment_unnamed_1017 * mad(fragment_unnamed_925 * ((fragment_unnamed_891 * mad(fragment_unnamed_901, mad((-0.0f) - fragment_unnamed_538, fragment_unnamed_868, fragment_unnamed_879), fragment_unnamed_871)) * fragment_unnamed_865), fragment_unnamed_448, mad(fragment_unnamed_422, (-0.0f) - fragment_unnamed_339, fragment_unnamed_339));
				bool fragment_unnamed_1033 = (((fragment_unnamed_1020 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1019 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1018 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1033 ? asfloat(1157627904u) : fragment_unnamed_1018;
				fragment_output_3.y = fragment_unnamed_1033 ? fragment_unnamed_448 : fragment_unnamed_1019;
				fragment_output_3.z = fragment_unnamed_1033 ? asfloat(1149239296u) : fragment_unnamed_1020;
				fragment_output_0.x = fragment_unnamed_869;
				fragment_output_0.y = fragment_unnamed_870;
				fragment_output_0.z = fragment_unnamed_871;
				fragment_output_1.w = fragment_unnamed_546;
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

				fragment_uniform_buffer_2[9] = float4(_Emission[0], _Emission[1], _Emission[2], _Emission[3]);

				fragment_uniform_buffer_2[10] = float4(_UseMaskMap, fragment_uniform_buffer_2[10][1], fragment_uniform_buffer_2[10][2], fragment_uniform_buffer_2[10][3]);

				fragment_uniform_buffer_2[10] = float4(fragment_uniform_buffer_2[10][0], _Progress, fragment_uniform_buffer_2[10][2], fragment_uniform_buffer_2[10][3]);

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

			#endif // defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(_DOUBLESIDED_ON) && !defined(_DISABLE_DECALS)


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
			GpuProgramID 760481

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
			GpuProgramID 803802

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
			GpuProgramID 903036

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
			GpuProgramID 947818

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
			GpuProgramID 992209

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
			GpuProgramID 1113576

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
