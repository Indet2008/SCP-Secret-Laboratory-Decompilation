Shader "Shader Graphs/VFX_EndlessPit"
{
	Properties
	{
		_DepthMultiplier ("DepthMultiplier", Float) = 1
		_Power ("Power", Float) = 1
		[HDR] _Emission ("Emission", Color) = (0.1254902,0.145098,0.1607843,0)
		_Color ("Color", Color) = (0.1254902,0.145098,0.1607843,0)
		_FadeDistance ("FadeDistance", Vector) = (0,0.2,0,0)
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
		[ToggleUI] [HideInInspector] _EnableFogOnTransparent ("Boolean", Float) = 0
		[HideInInspector] _CullModeForward ("Float", Float) = 2
		[Enum(Front, 1, Back, 2)] [HideInInspector] _TransparentCullMode ("Float", Float) = 2
		[Enum(UnityEngine.Rendering.HighDefinition.OpaqueCullMode)] [HideInInspector] _OpaqueCullMode ("Float", Float) = 2
		[HideInInspector] _ZTestDepthEqualForOpaque ("Float", Float) = 4
		[Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _ZTestTransparent ("Float", Float) = 4
		[ToggleUI] [HideInInspector] _TransparentBackfaceEnable ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _EnableBlendModePreserveSpecularLighting ("Boolean", Float) = 0
		[ToggleUI] [HideInInspector] _ExcludeFromTUAndAA ("Boolean", Float) = 0
		[HideInInspector] _StencilRef ("Float", Float) = 0
		[HideInInspector] _StencilWriteMask ("Float", Float) = 6
		[HideInInspector] _StencilRefDepth ("Float", Float) = 1
		[HideInInspector] _StencilWriteMaskDepth ("Float", Float) = 9
		[HideInInspector] _StencilRefMV ("Float", Float) = 33
		[HideInInspector] _StencilWriteMaskMV ("Float", Float) = 43
		[HideInInspector] _StencilRefDistortionVec ("Float", Float) = 4
		[HideInInspector] _StencilWriteMaskDistortionVec ("Float", Float) = 4
		[HideInInspector] [NoScaleOffset] unity_Lightmaps ("unity_Lightmaps", 2DArray) = "" {}
		[HideInInspector] [NoScaleOffset] unity_LightmapsInd ("unity_LightmapsInd", 2DArray) = "" {}
		[HideInInspector] [NoScaleOffset] unity_ShadowMasks ("unity_ShadowMasks", 2DArray) = "" {}
	}
	SubShader
	{
		Tags { "DisableBatching" = "False" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
		Pass
		{
			Name "ShadowCaster"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			ColorMask 0
			ZClip [_ZClip]
			Cull [_CullMode]
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 14572

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[4];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float3 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_1 : INTERP; // INTERP
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_74 = asfloat(1065353216u);
				float vertex_unnamed_76 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				float vertex_unnamed_105 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				float vertex_unnamed_135 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				vertex_output_1.x = vertex_unnamed_105;
				vertex_output_1.y = vertex_unnamed_76;
				vertex_output_1.z = vertex_unnamed_135;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			static float3 fragment_input_1;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_1 : INTERP; // INTERP
			};

			void frag_main()
			{
			}

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
			}


			ENDHLSL
		}
		Pass
		{
			Name "MotionVectors"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
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
			GpuProgramID 316947

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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


			ENDHLSL
		}
		Pass
		{
			Name "DepthForwardOnly"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DepthForwardOnly" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
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
			GpuProgramID 347662

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0


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
			static float4 vertex_output_1;
			static float3 vertex_output_2;
			static float3 vertex_output_3;

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
				float3 vertex_output_3 : INTERP2; // INTERP_2
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_76 = asfloat(1065353216u);
				float vertex_unnamed_78 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				float vertex_unnamed_107 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				float vertex_unnamed_137 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_76));
				vertex_output_2.x = vertex_unnamed_107;
				vertex_output_2.y = vertex_unnamed_78;
				vertex_output_2.z = vertex_unnamed_137;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_137, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_107, vertex_unnamed_78 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_197 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_198 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_199 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_205 = rsqrt(max(dot(float3(vertex_unnamed_197, vertex_unnamed_198, vertex_unnamed_199), float3(vertex_unnamed_197, vertex_unnamed_198, vertex_unnamed_199)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_205 * vertex_unnamed_197;
				vertex_output_1.y = vertex_unnamed_205 * vertex_unnamed_198;
				vertex_output_1.z = vertex_unnamed_205 * vertex_unnamed_199;
				vertex_output_1.w = vertex_input_2.w;
				float vertex_unnamed_227 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_242 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_257 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_264 = rsqrt(max(dot(float3(vertex_unnamed_227, vertex_unnamed_242, vertex_unnamed_257), float3(vertex_unnamed_227, vertex_unnamed_242, vertex_unnamed_257)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_264 * vertex_unnamed_227;
				vertex_output_3.y = vertex_unnamed_264 * vertex_unnamed_242;
				vertex_output_3.z = vertex_unnamed_264 * vertex_unnamed_257;
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
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				stage_output.vertex_output_3 = vertex_output_3;
				return stage_output;
			}


			static float4 fragment_input_1;
			static float3 fragment_input_2;
			static float3 fragment_input_3;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float3 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
			};

			void frag_main()
			{
			}

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
			}


			ENDHLSL
		}
		Pass
		{
			Name "ForwardOnly"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "ForwardOnly" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
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
			GpuProgramID 454148

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT


			#if !defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_ENABLE_FOG_ON_TRANSPARENT)
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
			static float3 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_1 : INTERP; // INTERP
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_74 = asfloat(1065353216u);
				float vertex_unnamed_76 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				float vertex_unnamed_105 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				float vertex_unnamed_135 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				vertex_output_1.x = vertex_unnamed_105;
				vertex_output_1.y = vertex_unnamed_76;
				vertex_output_1.z = vertex_unnamed_135;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float _ProbeExposureScale;
			int _OffScreenRendering;
			float _DeExposureMultiplier;
			float4 _Emission;
			float4 _Color;

			static float4 fragment_uniform_buffer_0[215];
			static float4 fragment_uniform_buffer_1[3];
			Texture2D<float4> _ExposureTexture;

			static float3 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_1 : INTERP; // INTERP
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_39 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				fragment_output_0.x = mad(fragment_uniform_buffer_1[2u].x, fragment_uniform_buffer_0[214u].w, fragment_unnamed_39 * fragment_uniform_buffer_1[1u].x);
				fragment_output_0.y = mad(fragment_uniform_buffer_1[2u].y, fragment_uniform_buffer_0[214u].w, fragment_unnamed_39 * fragment_uniform_buffer_1[1u].y);
				fragment_output_0.z = mad(fragment_uniform_buffer_1[2u].z, fragment_uniform_buffer_0[214u].w, fragment_unnamed_39 * fragment_uniform_buffer_1[1u].z);
				fragment_output_0.w = (asuint(fragment_uniform_buffer_0[211u]).y != 0u) ? 0.0f : 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[118] = float4(fragment_uniform_buffer_0[118][0], _ProbeExposureScale, fragment_uniform_buffer_0[118][2], fragment_uniform_buffer_0[118][3]);

				fragment_uniform_buffer_0[211] = float4(fragment_uniform_buffer_0[211][0], asfloat(_OffScreenRendering), fragment_uniform_buffer_0[211][2], fragment_uniform_buffer_0[211][3]);

				fragment_uniform_buffer_0[214] = float4(fragment_uniform_buffer_0[214][0], fragment_uniform_buffer_0[214][1], fragment_uniform_buffer_0[214][2], _DeExposureMultiplier);

				fragment_uniform_buffer_1[1] = float4(_Emission[0], _Emission[1], _Emission[2], _Emission[3]);

				fragment_uniform_buffer_1[2] = float4(_Color[0], _Color[1], _Color[2], _Color[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // !defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_ENABLE_FOG_ON_TRANSPARENT)


			#if defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_ENABLE_FOG_ON_TRANSPARENT)
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
			static float3 vertex_output_1;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
			};

			struct Vertex_Stage_Output
			{
				float3 vertex_output_1 : INTERP; // INTERP
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_74 = asfloat(1065353216u);
				float vertex_unnamed_76 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				float vertex_unnamed_105 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				float vertex_unnamed_135 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_74));
				vertex_output_1.x = vertex_unnamed_105;
				vertex_output_1.y = vertex_unnamed_76;
				vertex_output_1.z = vertex_unnamed_135;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_135, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_105, vertex_unnamed_76 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
				stage_output.vertex_output_1 = vertex_output_1;
				return stage_output;
			}


			float4x4 _ViewMatrix;
			float4x4 _ViewProjMatrix;
			float4x4 _InvViewProjMatrix;
			float4 _ScreenSize;
			float4 _ZBufferParams;
			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ScreenParams;
			float _OffScreenDownsampleFactor;
			float _DepthMultiplier;
			float _Power;
			float2 _FadeDistance;
			float _BlendMode;

			static float4 fragment_uniform_buffer_0[215];
			static float4 fragment_uniform_buffer_1[12];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2D<float4> _ExposureTexture;

			static float4 gl_FragCoord;
			static float3 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_1 : INTERP; // INTERP
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				bool fragment_unnamed_42 = 0u < asuint(fragment_uniform_buffer_0[211u]).y;
				float fragment_unnamed_66 = fragment_unnamed_42 ? float(uint(round(gl_FragCoord.y * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.y;
				float fragment_unnamed_93 = mad(fragment_uniform_buffer_0[22u].w, fragment_input_1.z, mad(fragment_uniform_buffer_0[20u].w, fragment_input_1.x, fragment_input_1.y * fragment_uniform_buffer_0[21u].w)) + fragment_uniform_buffer_0[23u].w;
				float fragment_unnamed_115 = (fragment_unnamed_42 ? float(uint(round(gl_FragCoord.x * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.x) / fragment_uniform_buffer_0[61u].x;
				float fragment_unnamed_116 = asfloat((fragment_uniform_buffer_0[58u].x < 0.0f) ? asuint(((-0.0f) - fragment_unnamed_66) + fragment_uniform_buffer_0[61u].y) : asuint(fragment_unnamed_66)) / fragment_uniform_buffer_0[61u].y;
				float fragment_unnamed_245;
				if (fragment_uniform_buffer_0[60u].w == 1.0f)
				{
					float fragment_unnamed_140 = ((-0.0f) - fragment_unnamed_116) + 1.0f;
					float4 fragment_unnamed_150 = _CameraDepthTexture.Load(int4(uint3(uint(fragment_unnamed_115 * fragment_uniform_buffer_0[50u].x), uint(fragment_unnamed_140 * fragment_uniform_buffer_0[50u].y), 0u), 0u));
					float fragment_unnamed_153 = fragment_unnamed_150.x;
					float fragment_unnamed_154 = mad(fragment_unnamed_115, 2.0f, -1.0f);
					float fragment_unnamed_158 = (-0.0f) - mad(fragment_unnamed_140, 2.0f, -1.0f);
					float fragment_unnamed_202 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_153, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_154, fragment_unnamed_158 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
					fragment_unnamed_245 = abs(mad(fragment_uniform_buffer_0[2u].z, (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_153, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_154, fragment_unnamed_158 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_202, mad(fragment_uniform_buffer_0[0u].z, (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_153, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_154, fragment_unnamed_158 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_202, ((mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_153, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_154, fragment_unnamed_158 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_202) * fragment_uniform_buffer_0[1u].z)) + fragment_uniform_buffer_0[3u].z);
				}
				else
				{
					fragment_unnamed_245 = 1.0f / mad(fragment_uniform_buffer_0[57u].z, _CameraDepthTexture.Load(int4(uint3(uint(fragment_unnamed_115 * fragment_uniform_buffer_0[50u].x), uint((((-0.0f) - fragment_unnamed_116) + 1.0f) * fragment_uniform_buffer_0[50u].y), 0u), 0u)).x, fragment_uniform_buffer_0[57u].w);
				}
				float fragment_unnamed_259 = exp2(log2(clamp((((-0.0f) - fragment_unnamed_93) + fragment_unnamed_245) * fragment_uniform_buffer_1[0u].x, 0.0f, 1.0f)) * fragment_uniform_buffer_1[0u].y) * clamp((fragment_unnamed_93 + ((-0.0f) - fragment_uniform_buffer_1[3u].x)) / (((-0.0f) - fragment_uniform_buffer_1[3u].x) + fragment_uniform_buffer_1[3u].y), 0.0f, 1.0f);
				float fragment_unnamed_268 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_286 = mad(fragment_uniform_buffer_1[2u].x, fragment_uniform_buffer_0[214u].w, fragment_unnamed_268 * fragment_uniform_buffer_1[1u].x);
				float fragment_unnamed_287 = mad(fragment_uniform_buffer_1[2u].y, fragment_uniform_buffer_0[214u].w, fragment_unnamed_268 * fragment_uniform_buffer_1[1u].y);
				float fragment_unnamed_288 = mad(fragment_uniform_buffer_1[2u].z, fragment_uniform_buffer_0[214u].w, fragment_unnamed_268 * fragment_uniform_buffer_1[1u].z);
				bool fragment_unnamed_302 = (((fragment_uniform_buffer_1[11u].x == 1.0f) ? 4294967295u : 0u) | ((fragment_uniform_buffer_1[11u].x == 0.0f) ? 4294967295u : 0u)) != 0u;
				fragment_output_0.x = fragment_unnamed_302 ? (fragment_unnamed_259 * fragment_unnamed_286) : fragment_unnamed_286;
				fragment_output_0.y = fragment_unnamed_302 ? (fragment_unnamed_259 * fragment_unnamed_287) : fragment_unnamed_287;
				fragment_output_0.z = fragment_unnamed_302 ? (fragment_unnamed_259 * fragment_unnamed_288) : fragment_unnamed_288;
				fragment_output_0.w = fragment_unnamed_259;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(_ViewMatrix[0][0], _ViewMatrix[1][0], _ViewMatrix[2][0], _ViewMatrix[3][0]);
				fragment_uniform_buffer_0[1] = float4(_ViewMatrix[0][1], _ViewMatrix[1][1], _ViewMatrix[2][1], _ViewMatrix[3][1]);
				fragment_uniform_buffer_0[2] = float4(_ViewMatrix[0][2], _ViewMatrix[1][2], _ViewMatrix[2][2], _ViewMatrix[3][2]);
				fragment_uniform_buffer_0[3] = float4(_ViewMatrix[0][3], _ViewMatrix[1][3], _ViewMatrix[2][3], _ViewMatrix[3][3]);

				fragment_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				fragment_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				fragment_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				fragment_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				fragment_uniform_buffer_0[28] = float4(_InvViewProjMatrix[0][0], _InvViewProjMatrix[1][0], _InvViewProjMatrix[2][0], _InvViewProjMatrix[3][0]);
				fragment_uniform_buffer_0[29] = float4(_InvViewProjMatrix[0][1], _InvViewProjMatrix[1][1], _InvViewProjMatrix[2][1], _InvViewProjMatrix[3][1]);
				fragment_uniform_buffer_0[30] = float4(_InvViewProjMatrix[0][2], _InvViewProjMatrix[1][2], _InvViewProjMatrix[2][2], _InvViewProjMatrix[3][2]);
				fragment_uniform_buffer_0[31] = float4(_InvViewProjMatrix[0][3], _InvViewProjMatrix[1][3], _InvViewProjMatrix[2][3], _InvViewProjMatrix[3][3]);

				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_0[57] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[60] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[211] = float4(_OffScreenDownsampleFactor, fragment_uniform_buffer_0[211][1], fragment_uniform_buffer_0[211][2], fragment_uniform_buffer_0[211][3]);

				fragment_uniform_buffer_1[0] = float4(_DepthMultiplier, fragment_uniform_buffer_1[0][1], fragment_uniform_buffer_1[0][2], fragment_uniform_buffer_1[0][3]);

				fragment_uniform_buffer_1[0] = float4(fragment_uniform_buffer_1[0][0], _Power, fragment_uniform_buffer_1[0][2], fragment_uniform_buffer_1[0][3]);

				fragment_uniform_buffer_1[3] = float4(_FadeDistance[0], _FadeDistance[1], fragment_uniform_buffer_1[3][2], fragment_uniform_buffer_1[3][3]);

				fragment_uniform_buffer_1[11] = float4(_BlendMode, fragment_uniform_buffer_1[11][1], fragment_uniform_buffer_1[11][2], fragment_uniform_buffer_1[11][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(_SURFACE_TYPE_TRANSPARENT) && !defined(_ENABLE_FOG_ON_TRANSPARENT)


			#if defined(_ENABLE_FOG_ON_TRANSPARENT) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewMatrix;
			float4x4 _InvViewMatrix;
			float4x4 _ProjMatrix;
			float4x4 _ViewProjMatrix;
			float4x4 _InvViewProjMatrix;
			float4 _ScreenSize;
			float4 _ZBufferParams;
			float4 _ProjectionParams;
			float4 unity_OrthoParams;
			float4 _ScreenParams;
			float4 _PlanetCenterRadius;
			float4 _PlanetUpAltitude;
			int _FogEnabled;
			int _PBRFogEnabled;
			int _EnableVolumetricFog;
			float4 _FogColor;
			float _FogColorMode;
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
			float4 _BoundsSS;
			float _UpDirectionX;
			float _UpDirectionY;
			int _UnderWaterSurfaceIndex;
			int _PreRefractionPass;
			float _OffScreenDownsampleFactor;
			float _DepthMultiplier;
			float _Power;
			float2 _FadeDistance;
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

			static float4 fragment_uniform_buffer_0[215];
			static float4 fragment_uniform_buffer_1[12];
			static float4 fragment_uniform_buffer_2[12];
			Texture2DArray<float4> _CameraDepthTexture;
			Texture2D<float4> _ExposureTexture;
			TextureCubeArray<float4> _SkyTexture;
			Texture3D<float4> _AtmosphericScatteringLUT;
			Texture2DArray<uint4> _StencilTexture;
			Texture2DArray<float4> _RefractiveDepthBuffer;
			Buffer<uint4> T6;
			Buffer<uint4> T7;
			Texture2DArray<float4> _WaterGBufferTexture3;
			Buffer<uint4> T9;
			Texture3D<float4> _VBufferLighting;
			SamplerState S0;
			SamplerState S1;

			static float4 gl_FragCoord;
			static float3 fragment_input_1;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float3 fragment_input_1 : INTERP; // INTERP
				float4 gl_FragCoord : SV_Position;
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				bool fragment_unnamed_78 = 0u < asuint(fragment_uniform_buffer_0[211u]).y;
				float fragment_unnamed_101 = fragment_unnamed_78 ? float(uint(round(gl_FragCoord.x * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.x;
				float fragment_unnamed_102 = fragment_unnamed_78 ? float(uint(round(gl_FragCoord.y * fragment_uniform_buffer_0[211u].x))) : gl_FragCoord.y;
				float fragment_unnamed_129 = mad(fragment_uniform_buffer_0[22u].w, fragment_input_1.z, mad(fragment_uniform_buffer_0[20u].w, fragment_input_1.x, fragment_input_1.y * fragment_uniform_buffer_0[21u].w)) + fragment_uniform_buffer_0[23u].w;
				float fragment_unnamed_151 = fragment_unnamed_101 / fragment_uniform_buffer_0[61u].x;
				float fragment_unnamed_152 = asfloat((fragment_uniform_buffer_0[58u].x < 0.0f) ? asuint(((-0.0f) - fragment_unnamed_102) + fragment_uniform_buffer_0[61u].y) : asuint(fragment_unnamed_102)) / fragment_uniform_buffer_0[61u].y;
				float fragment_unnamed_281;
				if (fragment_uniform_buffer_0[60u].w == 1.0f)
				{
					float fragment_unnamed_176 = ((-0.0f) - fragment_unnamed_152) + 1.0f;
					float4 fragment_unnamed_186 = _CameraDepthTexture.Load(int4(uint3(uint(fragment_unnamed_151 * fragment_uniform_buffer_0[50u].x), uint(fragment_unnamed_176 * fragment_uniform_buffer_0[50u].y), 0u), 0u));
					float fragment_unnamed_189 = fragment_unnamed_186.x;
					float fragment_unnamed_190 = mad(fragment_unnamed_151, 2.0f, -1.0f);
					float fragment_unnamed_194 = (-0.0f) - mad(fragment_unnamed_176, 2.0f, -1.0f);
					float fragment_unnamed_238 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_189, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_190, fragment_unnamed_194 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
					fragment_unnamed_281 = abs(mad(fragment_uniform_buffer_0[2u].z, (mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_189, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_190, fragment_unnamed_194 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_238, mad(fragment_uniform_buffer_0[0u].z, (mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_189, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_190, fragment_unnamed_194 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_238, ((mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_189, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_190, fragment_unnamed_194 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_238) * fragment_uniform_buffer_0[1u].z)) + fragment_uniform_buffer_0[3u].z);
				}
				else
				{
					fragment_unnamed_281 = 1.0f / mad(fragment_uniform_buffer_0[57u].z, _CameraDepthTexture.Load(int4(uint3(uint(fragment_unnamed_151 * fragment_uniform_buffer_0[50u].x), uint((((-0.0f) - fragment_unnamed_152) + 1.0f) * fragment_uniform_buffer_0[50u].y), 0u), 0u)).x, fragment_uniform_buffer_0[57u].w);
				}
				float fragment_unnamed_295 = exp2(log2(clamp((((-0.0f) - fragment_unnamed_129) + fragment_unnamed_281) * fragment_uniform_buffer_1[0u].x, 0.0f, 1.0f)) * fragment_uniform_buffer_1[0u].y) * clamp((fragment_unnamed_129 + ((-0.0f) - fragment_uniform_buffer_1[3u].x)) / (((-0.0f) - fragment_uniform_buffer_1[3u].x) + fragment_uniform_buffer_1[3u].y), 0.0f, 1.0f);
				float fragment_unnamed_304 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_322 = mad(fragment_uniform_buffer_1[2u].x, fragment_uniform_buffer_0[214u].w, fragment_unnamed_304 * fragment_uniform_buffer_1[1u].x);
				float fragment_unnamed_323 = mad(fragment_uniform_buffer_1[2u].y, fragment_uniform_buffer_0[214u].w, fragment_unnamed_304 * fragment_uniform_buffer_1[1u].y);
				float fragment_unnamed_324 = mad(fragment_uniform_buffer_1[2u].z, fragment_uniform_buffer_0[214u].w, fragment_unnamed_304 * fragment_uniform_buffer_1[1u].z);
				bool fragment_unnamed_329 = fragment_uniform_buffer_1[11u].x == 0.0f;
				bool fragment_unnamed_330 = fragment_uniform_buffer_1[11u].x == 1.0f;
				bool fragment_unnamed_331 = fragment_uniform_buffer_1[11u].x == 4.0f;
				bool fragment_unnamed_340 = ((fragment_unnamed_330 ? 4294967295u : 0u) | (fragment_unnamed_329 ? 4294967295u : 0u)) != 0u;
				uint fragment_unnamed_347 = fragment_unnamed_340 ? asuint(fragment_unnamed_295 * fragment_unnamed_322) : asuint(fragment_unnamed_322);
				uint fragment_unnamed_349 = fragment_unnamed_340 ? asuint(fragment_unnamed_295 * fragment_unnamed_323) : asuint(fragment_unnamed_323);
				uint fragment_unnamed_351 = fragment_unnamed_340 ? asuint(fragment_unnamed_295 * fragment_unnamed_324) : asuint(fragment_unnamed_324);
				float fragment_unnamed_484;
				float fragment_unnamed_486;
				float fragment_unnamed_488;
				uint fragment_unnamed_490;
				float fragment_unnamed_492;
				if (asuint(fragment_uniform_buffer_0[211u]).y != 1u)
				{
					uint fragment_unnamed_358 = uint(fragment_unnamed_101);
					uint fragment_unnamed_359 = uint(fragment_unnamed_102);
					float fragment_unnamed_366 = float(fragment_unnamed_358);
					float fragment_unnamed_367 = float(fragment_unnamed_359);
					uint fragment_unnamed_388 = min(T7.Load(1u).x, max(((-T7.Load(0u).x) + 4294967295u), uint(round(dot(float2(fragment_unnamed_366, fragment_unnamed_367), float2(fragment_uniform_buffer_0[103u].y * 1.0f, fragment_uniform_buffer_0[103u].x * (-1.0f))) + ((-0.0f) - fragment_uniform_buffer_0[102u].x)))));
					bool fragment_unnamed_421 = ((((-0.0f) - float((T7.Load(fragment_unnamed_388 + 2u).x & 65535u) + 4294967295u)) + floor(dot(float2(fragment_unnamed_366, fragment_unnamed_367), float2(fragment_uniform_buffer_0[103u].xy)) + ((-0.0f) - fragment_uniform_buffer_0[102u].z))) / (((-0.0f) - fragment_uniform_buffer_0[102u].z) + fragment_uniform_buffer_0[102u].w)) < 0.0f;
					uint fragment_unnamed_422 = fragment_unnamed_421 ? 4294967295u : 0u;
					float fragment_unnamed_485;
					float fragment_unnamed_487;
					float fragment_unnamed_489;
					uint fragment_unnamed_491;
					float fragment_unnamed_493;
					if (asuint(fragment_uniform_buffer_0[113u]).x != 0u)
					{
						float4 fragment_unnamed_433 = _RefractiveDepthBuffer.Load(int4(uint3(fragment_unnamed_358, fragment_unnamed_359, 0u), 0u));
						float fragment_unnamed_435 = fragment_unnamed_433.x;
						uint4 fragment_unnamed_436 = _StencilTexture.Load(int4(uint3(fragment_unnamed_358, fragment_unnamed_359, 0u), 0u));
						uint fragment_unnamed_438 = fragment_unnamed_436.y;
						uint fragment_unnamed_440 = fragment_unnamed_438 & 32u;
						uint fragment_unnamed_478 = ((fragment_unnamed_438 & 1u) != 0u) ? 4294967295u : (((((((fragment_unnamed_435 >= gl_FragCoord.z) ? 4294967295u : 0u) & (fragment_unnamed_422 & ((fragment_unnamed_440 != 0u) ? 4294967295u : 0u))) != 0u) ? 3.4028234663852885981170418348452e+38f : gl_FragCoord.z) < asfloat(fragment_unnamed_421 ? 2139095039u : ((fragment_unnamed_440 != 0u) ? asuint(fragment_unnamed_435) : 0u))) ? (fragment_unnamed_421 ? asuint(fragment_uniform_buffer_0[107u]).x : (uint(_WaterGBufferTexture3.Load(int4(uint3(fragment_unnamed_358, fragment_unnamed_359, 0u), 0u)).w * 255.0f) & 15u)) : 4294967295u);
						float fragment_unnamed_503;
						float fragment_unnamed_504;
						float fragment_unnamed_505;
						uint fragment_unnamed_506;
						float fragment_unnamed_507;
						if (fragment_unnamed_478 == 4294967295u)
						{
							fragment_unnamed_503 = asfloat(0u);
							fragment_unnamed_504 = asfloat(0u);
							fragment_unnamed_505 = asfloat(0u);
							fragment_unnamed_506 = 0u;
							fragment_unnamed_507 = asfloat(0u);
						}
						else
						{
							float fragment_unnamed_589;
							float fragment_unnamed_590;
							float fragment_unnamed_591;
							if (fragment_unnamed_422 == 0u)
							{
								uint fragment_unnamed_594 = (fragment_unnamed_478 * 28u) + 4u;
								uint3 fragment_unnamed_603 = uint3(T9.Load(fragment_unnamed_594).x, T9.Load(fragment_unnamed_594 + 1u).x, T9.Load(fragment_unnamed_594 + 2u).x);
								float fragment_unnamed_616 = mad(fragment_unnamed_366 * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
								float fragment_unnamed_618 = (-0.0f) - mad(fragment_unnamed_367 * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
								float fragment_unnamed_658 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_435, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_616, fragment_unnamed_618 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
								float fragment_unnamed_671 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_435, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_616, fragment_unnamed_618 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_658)) + fragment_input_1.x;
								float fragment_unnamed_672 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_435, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_616, fragment_unnamed_618 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_658)) + fragment_input_1.y;
								float fragment_unnamed_673 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_435, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_616, fragment_unnamed_618 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_658)) + fragment_input_1.z;
								float fragment_unnamed_677 = sqrt(dot(float3(fragment_unnamed_671, fragment_unnamed_672, fragment_unnamed_673), float3(fragment_unnamed_671, fragment_unnamed_672, fragment_unnamed_673)));
								float fragment_unnamed_678 = fragment_unnamed_677 + fragment_unnamed_677;
								fragment_unnamed_589 = ((-0.0f) - exp2((asfloat(fragment_unnamed_603.x) * fragment_unnamed_678) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_590 = ((-0.0f) - exp2((asfloat(fragment_unnamed_603.y) * fragment_unnamed_678) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_591 = ((-0.0f) - exp2((asfloat(fragment_unnamed_603.z) * fragment_unnamed_678) * (-1.44269502162933349609375f))) + 1.0f;
							}
							else
							{
								fragment_unnamed_589 = asfloat(0u);
								fragment_unnamed_590 = asfloat(0u);
								fragment_unnamed_591 = asfloat(0u);
							}
							fragment_unnamed_503 = fragment_unnamed_589;
							fragment_unnamed_504 = fragment_unnamed_590;
							fragment_unnamed_505 = fragment_unnamed_591;
							fragment_unnamed_506 = fragment_unnamed_422;
							fragment_unnamed_507 = asfloat(~fragment_unnamed_422);
						}
						fragment_unnamed_485 = fragment_unnamed_503;
						fragment_unnamed_487 = fragment_unnamed_504;
						fragment_unnamed_489 = fragment_unnamed_505;
						fragment_unnamed_491 = fragment_unnamed_506;
						fragment_unnamed_493 = fragment_unnamed_507;
					}
					else
					{
						fragment_unnamed_485 = asfloat(0u);
						fragment_unnamed_487 = asfloat(0u);
						fragment_unnamed_489 = asfloat(0u);
						fragment_unnamed_491 = fragment_unnamed_422;
						fragment_unnamed_493 = asfloat(0u);
					}
					fragment_unnamed_484 = fragment_unnamed_485;
					fragment_unnamed_486 = fragment_unnamed_487;
					fragment_unnamed_488 = fragment_unnamed_489;
					fragment_unnamed_490 = fragment_unnamed_491;
					fragment_unnamed_492 = fragment_unnamed_493;
				}
				else
				{
					fragment_unnamed_484 = asfloat(0u);
					fragment_unnamed_486 = asfloat(0u);
					fragment_unnamed_488 = asfloat(0u);
					fragment_unnamed_490 = 0u;
					fragment_unnamed_492 = asfloat(0u);
				}
				float fragment_unnamed_707;
				float fragment_unnamed_709;
				float fragment_unnamed_711;
				float fragment_unnamed_713;
				float fragment_unnamed_715;
				float fragment_unnamed_717;
				if (asuint(fragment_unnamed_492) == 0u)
				{
					float fragment_unnamed_512 = fragment_unnamed_101 * fragment_uniform_buffer_0[50u].z;
					float fragment_unnamed_513 = fragment_unnamed_102 * fragment_uniform_buffer_0[50u].w;
					bool fragment_unnamed_517 = fragment_uniform_buffer_0[15u].w == 0.0f;
					uint4 fragment_unnamed_537 = asuint(fragment_uniform_buffer_0[0u]);
					uint fragment_unnamed_538 = fragment_unnamed_537.z;
					uint4 fragment_unnamed_542 = asuint(fragment_uniform_buffer_0[1u]);
					uint fragment_unnamed_543 = fragment_unnamed_542.z;
					uint4 fragment_unnamed_547 = asuint(fragment_uniform_buffer_0[2u]);
					uint fragment_unnamed_548 = fragment_unnamed_547.z;
					float fragment_unnamed_554 = asfloat(fragment_unnamed_517 ? asuint(((-0.0f) - fragment_input_1.x) + fragment_uniform_buffer_0[11u].x) : fragment_unnamed_538);
					float fragment_unnamed_556 = asfloat(fragment_unnamed_517 ? asuint(((-0.0f) - fragment_input_1.y) + fragment_uniform_buffer_0[11u].y) : fragment_unnamed_543);
					float fragment_unnamed_558 = asfloat(fragment_unnamed_517 ? asuint(((-0.0f) - fragment_input_1.z) + fragment_uniform_buffer_0[11u].z) : fragment_unnamed_548);
					float fragment_unnamed_562 = rsqrt(dot(float3(fragment_unnamed_554, fragment_unnamed_556, fragment_unnamed_558), float3(fragment_unnamed_554, fragment_unnamed_556, fragment_unnamed_558)));
					float fragment_unnamed_563 = fragment_unnamed_562 * fragment_unnamed_554;
					float fragment_unnamed_564 = fragment_unnamed_562 * fragment_unnamed_556;
					float fragment_unnamed_565 = fragment_unnamed_562 * fragment_unnamed_558;
					float fragment_unnamed_566 = (-0.0f) - fragment_unnamed_563;
					float fragment_unnamed_567 = (-0.0f) - fragment_unnamed_564;
					float fragment_unnamed_568 = (-0.0f) - fragment_unnamed_565;
					float fragment_unnamed_575 = 1.0f / dot(float3(fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_568), float3((-0.0f) - asfloat(fragment_unnamed_538), (-0.0f) - asfloat(fragment_unnamed_543), (-0.0f) - asfloat(fragment_unnamed_548)));
					float fragment_unnamed_579 = fragment_unnamed_575 * (1.0f / gl_FragCoord.w);
					float fragment_unnamed_790;
					float fragment_unnamed_792;
					float fragment_unnamed_794;
					float fragment_unnamed_795;
					float fragment_unnamed_796;
					float fragment_unnamed_798;
					float fragment_unnamed_800;
					if (asuint(fragment_uniform_buffer_0[84u]).x != 0u)
					{
						float fragment_unnamed_791;
						float fragment_unnamed_983;
						float fragment_unnamed_986;
						float fragment_unnamed_988;
						float fragment_unnamed_990;
						if (asuint(fragment_uniform_buffer_0[84u]).z != 0u)
						{
							float fragment_unnamed_777 = mad((-0.0f) - fragment_uniform_buffer_0[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_0[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_575, (-0.0f) - fragment_uniform_buffer_0[94u].z), 0.0f)), fragment_uniform_buffer_0[94u].x));
							float fragment_unnamed_1071;
							float fragment_unnamed_1072;
							float fragment_unnamed_1073;
							float fragment_unnamed_1074;
							if (asuint(fragment_uniform_buffer_0[89u]).w == 0u)
							{
								float fragment_unnamed_808 = fragment_unnamed_512 * fragment_uniform_buffer_0[91u].x;
								float fragment_unnamed_809 = fragment_unnamed_513 * fragment_uniform_buffer_0[91u].y;
								float fragment_unnamed_810 = floor(fragment_unnamed_808);
								float fragment_unnamed_811 = floor(fragment_unnamed_809);
								float fragment_unnamed_816 = ((-0.0f) - frac(fragment_unnamed_808)) + 1.0f;
								float fragment_unnamed_817 = ((-0.0f) - frac(fragment_unnamed_809)) + 1.0f;
								float fragment_unnamed_818 = fragment_unnamed_817 * fragment_unnamed_817;
								float fragment_unnamed_819 = fragment_unnamed_816 * fragment_unnamed_816;
								float fragment_unnamed_824 = mad(((-0.0f) - fragment_unnamed_816) + 1.0f, fragment_unnamed_816, 0.5f);
								float fragment_unnamed_826 = mad(((-0.0f) - fragment_unnamed_817) + 1.0f, fragment_unnamed_817, 0.5f);
								float fragment_unnamed_833 = ((-0.0f) - fragment_unnamed_824) + mad((-0.0f) - fragment_unnamed_819, 0.5f, 1.0f);
								float fragment_unnamed_834 = ((-0.0f) - fragment_unnamed_826) + mad((-0.0f) - fragment_unnamed_818, 0.5f, 1.0f);
								float fragment_unnamed_835 = fragment_unnamed_824 * 0.5f;
								float fragment_unnamed_836 = fragment_unnamed_826 * 0.5f;
								float fragment_unnamed_837 = mad(fragment_unnamed_818, 0.5f, fragment_unnamed_836);
								float fragment_unnamed_838 = mad(fragment_unnamed_819, 0.5f, fragment_unnamed_835);
								float fragment_unnamed_839 = mad(fragment_unnamed_824, 0.5f, fragment_unnamed_833);
								float fragment_unnamed_840 = mad(fragment_unnamed_826, 0.5f, fragment_unnamed_834);
								float fragment_unnamed_843 = mad(fragment_unnamed_835, 1.0f / fragment_unnamed_838, -0.5f);
								float fragment_unnamed_845 = mad(fragment_unnamed_836, 1.0f / fragment_unnamed_837, -0.5f);
								float fragment_unnamed_848 = mad(fragment_unnamed_833, 1.0f / fragment_unnamed_839, 0.5f);
								float fragment_unnamed_849 = mad(fragment_unnamed_834, 1.0f / fragment_unnamed_840, 0.5f);
								float fragment_unnamed_859 = fragment_uniform_buffer_0[91u].z * fragment_uniform_buffer_0[92u].x;
								float fragment_unnamed_860 = fragment_uniform_buffer_0[91u].w * fragment_uniform_buffer_0[92u].y;
								float fragment_unnamed_880 = fragment_unnamed_777 * fragment_uniform_buffer_0[92u].z;
								float fragment_unnamed_881 = fragment_unnamed_837 * fragment_unnamed_838;
								float4 fragment_unnamed_893 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_859 * (fragment_unnamed_810 + fragment_unnamed_843), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_860 * (fragment_unnamed_811 + fragment_unnamed_845), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_880, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_899 = fragment_unnamed_837 * fragment_unnamed_839;
								float fragment_unnamed_900 = fragment_unnamed_838 * fragment_unnamed_840;
								float4 fragment_unnamed_909 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_859 * (fragment_unnamed_810 + fragment_unnamed_848), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_860 * (fragment_unnamed_811 + fragment_unnamed_845), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_880, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float4 fragment_unnamed_931 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_859 * (fragment_unnamed_810 + fragment_unnamed_843), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_860 * (fragment_unnamed_811 + fragment_unnamed_849), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_880, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_941 = fragment_unnamed_840 * fragment_unnamed_839;
								float4 fragment_unnamed_950 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_859 * (fragment_unnamed_810 + fragment_unnamed_848), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_860 * (fragment_unnamed_811 + fragment_unnamed_849), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_880, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_1071 = mad(fragment_unnamed_941, fragment_unnamed_950.x, mad(fragment_unnamed_900, fragment_unnamed_931.x, mad(fragment_unnamed_881, fragment_unnamed_893.x, fragment_unnamed_899 * fragment_unnamed_909.x)));
								fragment_unnamed_1072 = mad(fragment_unnamed_941, fragment_unnamed_950.y, mad(fragment_unnamed_900, fragment_unnamed_931.y, mad(fragment_unnamed_881, fragment_unnamed_893.y, fragment_unnamed_899 * fragment_unnamed_909.y)));
								fragment_unnamed_1073 = mad(fragment_unnamed_941, fragment_unnamed_950.z, mad(fragment_unnamed_900, fragment_unnamed_931.z, mad(fragment_unnamed_881, fragment_unnamed_893.z, fragment_unnamed_899 * fragment_unnamed_909.z)));
								fragment_unnamed_1074 = mad(fragment_unnamed_941, fragment_unnamed_950.w, mad(fragment_unnamed_900, fragment_unnamed_931.w, mad(fragment_unnamed_881, fragment_unnamed_893.w, fragment_unnamed_899 * fragment_unnamed_909.w)));
							}
							else
							{
								float4 fragment_unnamed_977 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_512 * fragment_uniform_buffer_0[92u].x, fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_513 * fragment_uniform_buffer_0[92u].y, fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_777 * fragment_uniform_buffer_0[92u].z, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_1071 = fragment_unnamed_977.x;
								fragment_unnamed_1072 = fragment_unnamed_977.y;
								fragment_unnamed_1073 = fragment_unnamed_977.z;
								fragment_unnamed_1074 = fragment_unnamed_977.w;
							}
							float fragment_unnamed_984 = ((-0.0f) - exp2(fragment_unnamed_1074 * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1085 = asfloat((fragment_unnamed_984 >= 5.9604644775390625e-08f) ? asuint(fragment_unnamed_984 * (1.0f / fragment_unnamed_1074)) : 1065353216u);
							fragment_unnamed_983 = fragment_unnamed_984;
							fragment_unnamed_791 = asfloat(asuint(fragment_uniform_buffer_0[96u]).w);
							fragment_unnamed_986 = fragment_unnamed_1071 * fragment_unnamed_1085;
							fragment_unnamed_988 = fragment_unnamed_1072 * fragment_unnamed_1085;
							fragment_unnamed_990 = fragment_unnamed_1073 * fragment_unnamed_1085;
						}
						else
						{
							fragment_unnamed_983 = asfloat(0u);
							fragment_unnamed_791 = asfloat(0u);
							fragment_unnamed_986 = asfloat(0u);
							fragment_unnamed_988 = asfloat(0u);
							fragment_unnamed_990 = asfloat(0u);
						}
						float fragment_unnamed_996 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_575, (-0.0f) - fragment_unnamed_791);
						float fragment_unnamed_793;
						float fragment_unnamed_797;
						float fragment_unnamed_799;
						float fragment_unnamed_801;
						if (((~fragment_unnamed_490) & ((0.0f < fragment_unnamed_996) ? 4294967295u : 0u)) != 0u)
						{
							float fragment_unnamed_1096 = dot(float3(fragment_unnamed_563, fragment_unnamed_564, fragment_unnamed_565), float3(fragment_uniform_buffer_0[83u].xyz));
							float fragment_unnamed_1100 = fragment_unnamed_791 * ((-0.0f) - fragment_unnamed_1096);
							float fragment_unnamed_1114 = max(abs(fragment_unnamed_1096), 0.001000000047497451305389404296875f);
							float fragment_unnamed_1116 = 1.0f / fragment_unnamed_1114;
							float fragment_unnamed_1119 = min(mad(fragment_unnamed_996, (-0.0f) - fragment_unnamed_1096, fragment_unnamed_1100), fragment_unnamed_1100);
							float fragment_unnamed_1133 = min(fragment_unnamed_996, max(fragment_unnamed_1116 * (((-0.0f) - fragment_unnamed_1119) + fragment_uniform_buffer_0[89u].y), 0.0f));
							float fragment_unnamed_1166 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_1114 * ((-0.0f) - (fragment_unnamed_996 + ((-0.0f) - fragment_unnamed_1133)))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_1119 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_1116 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_1133) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_1168 = ((-0.0f) - fragment_unnamed_983) + 1.0f;
							float fragment_unnamed_1982;
							float fragment_unnamed_1983;
							float fragment_unnamed_1984;
							if (fragment_uniform_buffer_0[86u].x == 1.0f)
							{
								float4 fragment_unnamed_1302 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_568, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_0[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_575, (-0.0f) - fragment_uniform_buffer_0[87u].x) / (((-0.0f) - fragment_uniform_buffer_0[87u].x) + fragment_uniform_buffer_0[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_1982 = fragment_unnamed_1302.x * fragment_uniform_buffer_0[85u].x;
								fragment_unnamed_1983 = fragment_unnamed_1302.y * fragment_uniform_buffer_0[85u].y;
								fragment_unnamed_1984 = fragment_unnamed_1302.z * fragment_uniform_buffer_0[85u].z;
							}
							else
							{
								uint4 fragment_unnamed_1318 = asuint(fragment_uniform_buffer_0[85u]);
								fragment_unnamed_1982 = asfloat(fragment_unnamed_1318.x);
								fragment_unnamed_1983 = asfloat(fragment_unnamed_1318.y);
								fragment_unnamed_1984 = asfloat(fragment_unnamed_1318.z);
							}
							float fragment_unnamed_1995 = ((-0.0f) - fragment_unnamed_1166) + 1.0f;
							fragment_unnamed_793 = mad((-0.0f) - fragment_unnamed_1168, fragment_unnamed_1166, 1.0f);
							fragment_unnamed_797 = mad((fragment_uniform_buffer_0[88u].x / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_304 * (fragment_unnamed_1168 * fragment_unnamed_1982)), fragment_unnamed_1995, fragment_unnamed_986);
							fragment_unnamed_799 = mad((fragment_uniform_buffer_0[88u].y / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_304 * (fragment_unnamed_1168 * fragment_unnamed_1983)), fragment_unnamed_1995, fragment_unnamed_988);
							fragment_unnamed_801 = mad((fragment_uniform_buffer_0[88u].z / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_304 * (fragment_unnamed_1168 * fragment_unnamed_1984)), fragment_unnamed_1995, fragment_unnamed_990);
						}
						else
						{
							fragment_unnamed_793 = fragment_unnamed_983;
							fragment_unnamed_797 = fragment_unnamed_986;
							fragment_unnamed_799 = fragment_unnamed_988;
							fragment_unnamed_801 = fragment_unnamed_990;
						}
						fragment_unnamed_790 = fragment_unnamed_791;
						fragment_unnamed_792 = fragment_unnamed_793;
						fragment_unnamed_794 = fragment_unnamed_793;
						fragment_unnamed_795 = fragment_unnamed_793;
						fragment_unnamed_796 = fragment_unnamed_797;
						fragment_unnamed_798 = fragment_unnamed_799;
						fragment_unnamed_800 = fragment_unnamed_801;
					}
					else
					{
						fragment_unnamed_790 = asfloat(0u);
						fragment_unnamed_792 = fragment_unnamed_484;
						fragment_unnamed_794 = fragment_unnamed_486;
						fragment_unnamed_795 = fragment_unnamed_488;
						fragment_unnamed_796 = asfloat(0u);
						fragment_unnamed_798 = asfloat(0u);
						fragment_unnamed_800 = asfloat(0u);
					}
					float fragment_unnamed_1058;
					float fragment_unnamed_1060;
					float fragment_unnamed_1062;
					float fragment_unnamed_1064;
					float fragment_unnamed_1066;
					float fragment_unnamed_1068;
					if (fragment_unnamed_490 != 0u)
					{
						uint fragment_unnamed_1007 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 4u;
						uint4 fragment_unnamed_1019 = uint4(T9.Load(fragment_unnamed_1007).x, T9.Load(fragment_unnamed_1007 + 1u).x, T9.Load(fragment_unnamed_1007 + 2u).x, T9.Load(fragment_unnamed_1007 + 3u).x);
						float fragment_unnamed_1027 = asfloat(fragment_unnamed_1019.w);
						uint fragment_unnamed_1033 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 20u;
						uint3 fragment_unnamed_1042 = uint3(T9.Load(fragment_unnamed_1033).x, T9.Load(fragment_unnamed_1033 + 1u).x, T9.Load(fragment_unnamed_1033 + 2u).x);
						float fragment_unnamed_1044 = asfloat(fragment_unnamed_1042.x);
						float fragment_unnamed_1046 = asfloat(fragment_unnamed_1042.y);
						float fragment_unnamed_1048 = asfloat(fragment_unnamed_1042.z);
						float fragment_unnamed_1049 = fragment_unnamed_1027 * asfloat(fragment_unnamed_1019.x);
						float fragment_unnamed_1050 = fragment_unnamed_1027 * asfloat(fragment_unnamed_1019.y);
						float fragment_unnamed_1051 = fragment_unnamed_1027 * asfloat(fragment_unnamed_1019.z);
						float fragment_unnamed_1056 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_575, (-0.0f) - fragment_unnamed_790);
						float fragment_unnamed_1065;
						float fragment_unnamed_1067;
						float fragment_unnamed_1069;
						float fragment_unnamed_1325;
						float fragment_unnamed_1326;
						float fragment_unnamed_1327;
						if (0.0f < fragment_unnamed_1056)
						{
							uint fragment_unnamed_1184 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 16u;
							uint3 fragment_unnamed_1193 = uint3(T9.Load(fragment_unnamed_1184).x, T9.Load(fragment_unnamed_1184 + 1u).x, T9.Load(fragment_unnamed_1184 + 2u).x);
							float fragment_unnamed_1200 = dot(float3(fragment_unnamed_563, fragment_unnamed_564, fragment_unnamed_565), float3(fragment_unnamed_1044, fragment_unnamed_1046, fragment_unnamed_1048));
							float fragment_unnamed_1203 = fragment_unnamed_1056 * fragment_unnamed_1049;
							float fragment_unnamed_1204 = fragment_unnamed_1056 * fragment_unnamed_1050;
							float fragment_unnamed_1205 = fragment_unnamed_1056 * fragment_unnamed_1051;
							float fragment_unnamed_1212 = fragment_unnamed_304 * (((-0.0f) - fragment_unnamed_792) + 1.0f);
							float fragment_unnamed_1213 = fragment_unnamed_304 * (((-0.0f) - fragment_unnamed_794) + 1.0f);
							float fragment_unnamed_1214 = fragment_unnamed_304 * (((-0.0f) - fragment_unnamed_795) + 1.0f);
							bool fragment_unnamed_1216 = ((-0.0f) - fragment_unnamed_1200) != 1.0f;
							float fragment_unnamed_1218 = 1.0f / (fragment_unnamed_1200 + 1.0f);
							float fragment_unnamed_1222 = (-0.0f) - fragment_unnamed_1200;
							fragment_unnamed_1065 = mad(asfloat(fragment_unnamed_1216 ? asuint(fragment_unnamed_1212 * (fragment_unnamed_1218 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1203, fragment_unnamed_1222, fragment_unnamed_1203) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1212)), asfloat(fragment_unnamed_1193.x), fragment_unnamed_796);
							fragment_unnamed_1067 = mad(asfloat(fragment_unnamed_1216 ? asuint(fragment_unnamed_1213 * (fragment_unnamed_1218 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1204, fragment_unnamed_1222, fragment_unnamed_1204) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1213)), asfloat(fragment_unnamed_1193.y), fragment_unnamed_798);
							fragment_unnamed_1069 = mad(asfloat(fragment_unnamed_1216 ? asuint(fragment_unnamed_1214 * (fragment_unnamed_1218 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_1205, fragment_unnamed_1222, fragment_unnamed_1205) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_1214)), asfloat(fragment_unnamed_1193.z), fragment_unnamed_800);
							fragment_unnamed_1325 = fragment_unnamed_1203;
							fragment_unnamed_1326 = fragment_unnamed_1204;
							fragment_unnamed_1327 = fragment_unnamed_1205;
						}
						else
						{
							fragment_unnamed_1065 = fragment_unnamed_796;
							fragment_unnamed_1067 = fragment_unnamed_798;
							fragment_unnamed_1069 = fragment_unnamed_800;
							fragment_unnamed_1325 = asfloat(0u);
							fragment_unnamed_1326 = asfloat(0u);
							fragment_unnamed_1327 = asfloat(0u);
						}
						float fragment_unnamed_1343 = max(((-0.0f) - dot(float3(fragment_input_1.x, fragment_input_1.y, fragment_input_1.z), float3(fragment_unnamed_1044, fragment_unnamed_1046, fragment_unnamed_1048))) + ((-0.0f) - asfloat(T6.Load(0u).x)), 0.0f);
						fragment_unnamed_1058 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_792) + 1.0f), exp2(mad(fragment_unnamed_1343, fragment_unnamed_1049, fragment_unnamed_1325) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1060 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_794) + 1.0f), exp2(mad(fragment_unnamed_1343, fragment_unnamed_1050, fragment_unnamed_1326) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1062 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_795) + 1.0f), exp2(mad(fragment_unnamed_1343, fragment_unnamed_1051, fragment_unnamed_1327) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_1064 = fragment_unnamed_1065;
						fragment_unnamed_1066 = fragment_unnamed_1067;
						fragment_unnamed_1068 = fragment_unnamed_1069;
					}
					else
					{
						fragment_unnamed_1058 = fragment_unnamed_792;
						fragment_unnamed_1060 = fragment_unnamed_794;
						fragment_unnamed_1062 = fragment_unnamed_795;
						fragment_unnamed_1064 = fragment_unnamed_796;
						fragment_unnamed_1066 = fragment_unnamed_798;
						fragment_unnamed_1068 = fragment_unnamed_800;
					}
					float fragment_unnamed_708;
					float fragment_unnamed_710;
					float fragment_unnamed_712;
					float fragment_unnamed_714;
					float fragment_unnamed_716;
					float fragment_unnamed_718;
					if (fragment_unnamed_490 == 0u)
					{
						float fragment_unnamed_1267;
						float fragment_unnamed_1268;
						float fragment_unnamed_1269;
						float fragment_unnamed_1270;
						float fragment_unnamed_1271;
						float fragment_unnamed_1272;
						if (asuint(fragment_uniform_buffer_0[84u]).y != 0u)
						{
							float fragment_unnamed_1369 = fragment_uniform_buffer_0[82u].w + fragment_uniform_buffer_0[83u].w;
							float fragment_unnamed_1375 = dot(float3(fragment_uniform_buffer_0[83u].xyz), float3(fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_568));
							float fragment_unnamed_1378 = 1.0f / fragment_unnamed_1369;
							float fragment_unnamed_1382 = fragment_unnamed_1378 * fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_1386 = sqrt(max(mad((-0.0f) - fragment_unnamed_1382, fragment_unnamed_1382, 1.0f), 0.0f));
							float fragment_unnamed_1390 = fragment_unnamed_1378 * fragment_uniform_buffer_2[0u].x;
							float fragment_unnamed_1393 = max(mad((-0.0f) - fragment_unnamed_1375, fragment_unnamed_1375, 1.0f), 0.0f);
							float fragment_unnamed_1395 = mad(fragment_unnamed_1390, fragment_unnamed_1390, (-0.0f) - fragment_unnamed_1393);
							float4 fragment_unnamed_1420 = _AtmosphericScatteringLUT.SampleLevel(S0, float3(fragment_unnamed_512, fragment_unnamed_513, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_575, (-0.0f) - max(asfloat((fragment_unnamed_1395 < 0.0f) ? asuint(fragment_unnamed_1395) : asuint(fragment_unnamed_1369 * (((-0.0f) - fragment_unnamed_1375) + ((-0.0f) - sqrt(fragment_unnamed_1395))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
							float fragment_unnamed_1429 = (1.0f / fragment_unnamed_579) * fragment_uniform_buffer_2[0u].x;
							float fragment_unnamed_1431 = mad(fragment_unnamed_1429, fragment_unnamed_1429, (-0.0f) - fragment_unnamed_1393);
							float fragment_unnamed_1445 = min(max(asfloat((fragment_unnamed_1431 < 0.0f) ? asuint(fragment_unnamed_1431) : asuint(fragment_unnamed_579 * (((-0.0f) - fragment_unnamed_1375) + ((-0.0f) - sqrt(fragment_unnamed_1431))))), 0.0f) + 128000.0f, fragment_unnamed_579);
							float fragment_unnamed_1462 = dot(float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z), float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z));
							float fragment_unnamed_1465 = rsqrt(fragment_unnamed_1462);
							float fragment_unnamed_1477 = sqrt(fragment_unnamed_1462);
							float fragment_unnamed_1478 = dot(float3(fragment_unnamed_1465 * ((-0.0f) - fragment_uniform_buffer_0[82u].x), fragment_unnamed_1465 * ((-0.0f) - fragment_uniform_buffer_0[82u].y), fragment_unnamed_1465 * ((-0.0f) - fragment_uniform_buffer_0[82u].z)), float3(fragment_unnamed_563, fragment_unnamed_564, fragment_unnamed_565));
							float fragment_unnamed_1489 = mad(fragment_unnamed_1445, fragment_unnamed_566, (-0.0f) - fragment_uniform_buffer_0[82u].x);
							float fragment_unnamed_1490 = mad(fragment_unnamed_1445, fragment_unnamed_567, (-0.0f) - fragment_uniform_buffer_0[82u].y);
							float fragment_unnamed_1491 = mad(fragment_unnamed_1445, fragment_unnamed_568, (-0.0f) - fragment_uniform_buffer_0[82u].z);
							float fragment_unnamed_1495 = sqrt(dot(float3(fragment_unnamed_1489, fragment_unnamed_1490, fragment_unnamed_1491), float3(fragment_unnamed_1489, fragment_unnamed_1490, fragment_unnamed_1491)));
							float fragment_unnamed_1500 = (1.0f / fragment_unnamed_1495) * dot(float3(fragment_unnamed_1489, fragment_unnamed_1490, fragment_unnamed_1491), float3(fragment_unnamed_566, fragment_unnamed_567, fragment_unnamed_568));
							float fragment_unnamed_1503 = (fragment_unnamed_1500 >= 0.0f) ? ((-0.0f) - fragment_unnamed_1478) : fragment_unnamed_1478;
							float fragment_unnamed_1508 = fragment_unnamed_1477 * fragment_uniform_buffer_2[1u].x;
							float fragment_unnamed_1509 = fragment_unnamed_1477 * fragment_uniform_buffer_2[1u].z;
							float fragment_unnamed_1513 = sqrt(max(mad((-0.0f) - fragment_unnamed_1503, fragment_unnamed_1503, 1.0f), 0.0f));
							float fragment_unnamed_1518 = abs(fragment_unnamed_1503) * abs(fragment_unnamed_1503);
							float fragment_unnamed_1521 = (-0.0f) - fragment_unnamed_1518;
							float fragment_unnamed_1535 = abs(fragment_unnamed_1503);
							float fragment_unnamed_1542 = abs(fragment_unnamed_1503);
							float fragment_unnamed_1560 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1508) * 1.44269502162933349609375f) * mad(fragment_unnamed_1542, 0.5f, (1.0f / mad(fragment_unnamed_1535, fragment_unnamed_1508, sqrt(fragment_unnamed_1508 * mad(fragment_unnamed_1508 * fragment_unnamed_1518, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1521, fragment_unnamed_1508, mad(fragment_unnamed_1508, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							float fragment_unnamed_1561 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1509) * 1.44269502162933349609375f) * mad(fragment_unnamed_1542, 0.5f, (1.0f / mad(fragment_unnamed_1535, fragment_unnamed_1509, sqrt(fragment_unnamed_1509 * mad(fragment_unnamed_1509 * fragment_unnamed_1518, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1521, fragment_unnamed_1509, mad(fragment_unnamed_1509, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							bool fragment_unnamed_1562 = fragment_unnamed_1503 < 0.0f;
							float fragment_unnamed_1563 = fragment_unnamed_1508 * fragment_unnamed_1513;
							float fragment_unnamed_1564 = fragment_unnamed_1509 * fragment_unnamed_1513;
							float fragment_unnamed_1565 = rsqrt(fragment_unnamed_1563);
							float fragment_unnamed_1566 = rsqrt(fragment_unnamed_1564);
							float fragment_unnamed_1609 = fragment_unnamed_1495 * fragment_uniform_buffer_2[1u].x;
							float fragment_unnamed_1610 = fragment_unnamed_1495 * fragment_uniform_buffer_2[1u].z;
							float fragment_unnamed_1615 = abs(fragment_unnamed_1500) * abs(fragment_unnamed_1500);
							float fragment_unnamed_1618 = (-0.0f) - fragment_unnamed_1615;
							float fragment_unnamed_1629 = abs(fragment_unnamed_1500);
							float fragment_unnamed_1636 = abs(fragment_unnamed_1500);
							float fragment_unnamed_1664 = abs(mad((-0.0f) - mad(fragment_unnamed_1636, 0.5f, (1.0f / mad(fragment_unnamed_1629, fragment_unnamed_1609, sqrt(fragment_unnamed_1609 * mad(fragment_unnamed_1609 * fragment_unnamed_1615, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1618, fragment_unnamed_1609, mad(fragment_unnamed_1609, 2.0f, 1.0f)) * 0.761642992496490478515625f)), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1609) * 1.44269502162933349609375f), asfloat(fragment_unnamed_1562 ? asuint(mad((dot(fragment_unnamed_1563.xx, fragment_unnamed_1565.xx) + fragment_unnamed_1565) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].x, (-0.0f) - fragment_unnamed_1563) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_1560)) : asuint(fragment_unnamed_1560)))) * fragment_uniform_buffer_2[1u].y;
							float fragment_unnamed_1666 = 1.0f / fragment_unnamed_1477;
							float fragment_unnamed_1671 = fragment_unnamed_1666 * fragment_uniform_buffer_2[2u].z;
							float fragment_unnamed_1672 = fragment_unnamed_1666 * fragment_uniform_buffer_2[2u].w;
							float fragment_unnamed_1676 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_1478, fragment_unnamed_1478, 1.0f), 0.0f);
							float fragment_unnamed_1677 = mad(fragment_unnamed_1671, fragment_unnamed_1671, fragment_unnamed_1676);
							float fragment_unnamed_1678 = mad(fragment_unnamed_1672, fragment_unnamed_1672, fragment_unnamed_1676);
							bool fragment_unnamed_1679 = fragment_unnamed_1677 < 0.0f;
							bool fragment_unnamed_1680 = fragment_unnamed_1678 < 0.0f;
							float fragment_unnamed_1681 = sqrt(fragment_unnamed_1677);
							float fragment_unnamed_1682 = sqrt(fragment_unnamed_1678);
							uint fragment_unnamed_1693 = asuint(fragment_unnamed_1677);
							uint fragment_unnamed_1696 = fragment_unnamed_1679 ? fragment_unnamed_1693 : asuint(fragment_unnamed_1477 * (fragment_unnamed_1478 + ((-0.0f) - fragment_unnamed_1681)));
							float fragment_unnamed_1697 = asfloat(fragment_unnamed_1696);
							uint fragment_unnamed_1698 = fragment_unnamed_1679 ? fragment_unnamed_1693 : asuint(fragment_unnamed_1477 * (fragment_unnamed_1478 + fragment_unnamed_1681));
							float fragment_unnamed_1699 = asfloat(fragment_unnamed_1698);
							uint fragment_unnamed_1700 = asuint(fragment_unnamed_1678);
							uint fragment_unnamed_1705 = fragment_unnamed_1680 ? fragment_unnamed_1700 : asuint(fragment_unnamed_1477 * (fragment_unnamed_1478 + fragment_unnamed_1682));
							bool fragment_unnamed_1710 = fragment_unnamed_1697 >= 0.0f;
							float fragment_unnamed_1715 = ((-0.0f) - fragment_unnamed_1699) + asfloat(fragment_unnamed_1705);
							float fragment_unnamed_1718 = max(asfloat(fragment_unnamed_1680 ? fragment_unnamed_1700 : asuint(fragment_unnamed_1477 * (fragment_unnamed_1478 + ((-0.0f) - fragment_unnamed_1682)))), 0.0f);
							uint fragment_unnamed_1719 = fragment_unnamed_1710 ? fragment_unnamed_1696 : fragment_unnamed_1705;
							float fragment_unnamed_1725 = ((-0.0f) - fragment_unnamed_1718) + asfloat(fragment_unnamed_1719);
							bool fragment_unnamed_1728 = (((fragment_unnamed_1699 < fragment_unnamed_1445) ? 4294967295u : 0u) & (fragment_unnamed_1710 ? 4294967295u : 0u)) != 0u;
							bool fragment_unnamed_1734 = (((fragment_unnamed_1697 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1699 >= 0.0f) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_1739 = asfloat(fragment_unnamed_1734 ? fragment_unnamed_1698 : asuint(fragment_unnamed_1718));
							float fragment_unnamed_1741 = asfloat(fragment_unnamed_1734 ? asuint(fragment_unnamed_1715 * 0.5f) : (fragment_unnamed_1728 ? fragment_unnamed_1698 : asuint(fragment_unnamed_1725 * 0.5f)));
							float fragment_unnamed_1743 = asfloat(fragment_unnamed_1734 ? asuint(fragment_unnamed_1715 * 0.5f) : (fragment_unnamed_1728 ? fragment_unnamed_1719 : asuint(fragment_unnamed_1725 * 0.5f)));
							float fragment_unnamed_1745 = asfloat(fragment_unnamed_1734 ? fragment_unnamed_1705 : (fragment_unnamed_1728 ? fragment_unnamed_1705 : fragment_unnamed_1719));
							float fragment_unnamed_1750 = (-0.0f) - fragment_unnamed_1739;
							float fragment_unnamed_1751 = (-0.0f) - fragment_unnamed_1741;
							float fragment_unnamed_1754 = fragment_unnamed_1750 + min(fragment_unnamed_1445, fragment_unnamed_1743);
							float fragment_unnamed_1755 = fragment_unnamed_1751 + min(fragment_unnamed_1445, fragment_unnamed_1745);
							float fragment_unnamed_1764 = mad(fragment_unnamed_1750 + min(fragment_unnamed_1445, fragment_unnamed_1743), 0.25f, fragment_unnamed_1739);
							float fragment_unnamed_1766 = mad(fragment_unnamed_1751 + min(fragment_unnamed_1445, fragment_unnamed_1745), 0.25f, fragment_unnamed_1741);
							float fragment_unnamed_1767 = mad(fragment_unnamed_1754, 0.75f, fragment_unnamed_1739);
							float fragment_unnamed_1769 = mad(fragment_unnamed_1755, 0.75f, fragment_unnamed_1741);
							float fragment_unnamed_1771 = dot(((-0.0f) - fragment_unnamed_1478).xx, fragment_unnamed_1477.xx);
							float fragment_unnamed_1789 = (-0.0f) - fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_1825 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1769, fragment_unnamed_1769 + fragment_unnamed_1771, fragment_unnamed_1462)) + fragment_unnamed_1789, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_1755, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1767, fragment_unnamed_1767 + fragment_unnamed_1771, fragment_unnamed_1462)) + fragment_unnamed_1789, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_1754, 0.0f) * 0.5f, ((max(fragment_unnamed_1755, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1766, fragment_unnamed_1766 + fragment_unnamed_1771, fragment_unnamed_1462)) + fragment_unnamed_1789, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_1754, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_1764, fragment_unnamed_1764 + fragment_unnamed_1771, fragment_unnamed_1462)) + fragment_unnamed_1789, fragment_uniform_buffer_2[2u].x, fragment_uniform_buffer_2[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
							float fragment_unnamed_1830 = (abs(mad((-0.0f) - mad(fragment_unnamed_1636, 0.5f, (1.0f / mad(fragment_unnamed_1629, fragment_unnamed_1610, sqrt(fragment_unnamed_1610 * mad(fragment_unnamed_1610 * fragment_unnamed_1615, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_1618, fragment_unnamed_1610, mad(fragment_unnamed_1610, 2.0f, 1.0f)) * 0.761642992496490478515625f)), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1610) * 1.44269502162933349609375f), asfloat(fragment_unnamed_1562 ? asuint(mad((dot(fragment_unnamed_1564.xx, fragment_unnamed_1566.xx) + fragment_unnamed_1566) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_2[1u].z, (-0.0f) - fragment_unnamed_1564) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_1561)) : asuint(fragment_unnamed_1561)))) * fragment_uniform_buffer_2[1u].w) * fragment_uniform_buffer_2[0u].w;
							float fragment_unnamed_1857 = ((-0.0f) - exp2(mad(fragment_unnamed_1825, fragment_uniform_buffer_2[6u].x, mad(fragment_unnamed_1664, fragment_uniform_buffer_2[3u].x, fragment_unnamed_1830)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1858 = ((-0.0f) - exp2(mad(fragment_unnamed_1825, fragment_uniform_buffer_2[6u].y, mad(fragment_unnamed_1664, fragment_uniform_buffer_2[3u].y, fragment_unnamed_1830)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1859 = ((-0.0f) - exp2(mad(fragment_unnamed_1825, fragment_uniform_buffer_2[6u].z, mad(fragment_unnamed_1664, fragment_uniform_buffer_2[3u].z, fragment_unnamed_1830)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_1861 = fragment_unnamed_1859 + (fragment_unnamed_1858 + fragment_unnamed_1857);
							float fragment_unnamed_1862 = fragment_unnamed_1861 * 0.3333333432674407958984375f;
							float fragment_unnamed_1864 = (-0.0f) - fragment_unnamed_1861;
							float fragment_unnamed_1883 = sqrt(((-0.0f) - fragment_unnamed_1386) + 1.0f);
							float fragment_unnamed_1889 = mad(mad(mad(fragment_unnamed_1386, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_1386, -0.212114393711090087890625f), fragment_unnamed_1386, 1.570728778839111328125f);
							float fragment_unnamed_1901 = mad(fragment_unnamed_1889, fragment_unnamed_1883, asfloat(((((-0.0f) - fragment_unnamed_1386) < fragment_unnamed_1386) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_1883 * fragment_unnamed_1889, -2.0f, 3.1415927410125732421875f))));
							float fragment_unnamed_1905 = sqrt(((-0.0f) - abs(fragment_unnamed_1375)) + 1.0f);
							float fragment_unnamed_1911 = mad(mad(mad(abs(fragment_unnamed_1375), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_1375), -0.212114393711090087890625f), abs(fragment_unnamed_1375), 1.570728778839111328125f);
							float fragment_unnamed_1922 = 1.0f / ((-0.0f) - fragment_unnamed_1901);
							float fragment_unnamed_1940 = mad(exp2((clamp(mad(mad(fragment_unnamed_1911, fragment_unnamed_1905, asfloat(((fragment_unnamed_1375 < ((-0.0f) - fragment_unnamed_1375)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_1905 * fragment_unnamed_1911, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_1922, (-0.0f) - (fragment_unnamed_1901 * fragment_unnamed_1922)), 0.0f, 1.0f) * fragment_uniform_buffer_2[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_2[11u].y, (-0.0f) - fragment_uniform_buffer_2[11u].y);
							float fragment_unnamed_1973 = ((-0.0f) - fragment_unnamed_1058) + 1.0f;
							float fragment_unnamed_1974 = ((-0.0f) - fragment_unnamed_1060) + 1.0f;
							float fragment_unnamed_1975 = ((-0.0f) - fragment_unnamed_1062) + 1.0f;
							fragment_unnamed_1267 = mad(fragment_unnamed_1973, mad(mad(fragment_unnamed_1864, 0.3333333432674407958984375f, fragment_unnamed_1857), fragment_uniform_buffer_2[10u].z, fragment_unnamed_1862) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1058);
							fragment_unnamed_1268 = mad(fragment_unnamed_1974, mad(mad(fragment_unnamed_1864, 0.3333333432674407958984375f, fragment_unnamed_1858), fragment_uniform_buffer_2[10u].z, fragment_unnamed_1862) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1060);
							fragment_unnamed_1269 = mad(fragment_unnamed_1975, mad(mad(fragment_unnamed_1864, 0.3333333432674407958984375f, fragment_unnamed_1859), fragment_uniform_buffer_2[10u].z, fragment_unnamed_1862) * fragment_uniform_buffer_2[10u].w, fragment_unnamed_1062);
							fragment_unnamed_1270 = mad(fragment_unnamed_1973, fragment_unnamed_1420.x * mad(fragment_unnamed_1940, ((-0.0f) - fragment_uniform_buffer_2[8u].x) + fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[8u].x), fragment_unnamed_1064);
							fragment_unnamed_1271 = mad(fragment_unnamed_1974, fragment_unnamed_1420.y * mad(fragment_unnamed_1940, ((-0.0f) - fragment_uniform_buffer_2[8u].y) + fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[8u].y), fragment_unnamed_1066);
							fragment_unnamed_1272 = mad(fragment_unnamed_1975, fragment_unnamed_1420.z * mad(fragment_unnamed_1940, ((-0.0f) - fragment_uniform_buffer_2[8u].z) + fragment_uniform_buffer_2[9u].z, fragment_uniform_buffer_2[8u].z), fragment_unnamed_1068);
						}
						else
						{
							fragment_unnamed_1267 = fragment_unnamed_1058;
							fragment_unnamed_1268 = fragment_unnamed_1060;
							fragment_unnamed_1269 = fragment_unnamed_1062;
							fragment_unnamed_1270 = fragment_unnamed_1064;
							fragment_unnamed_1271 = fragment_unnamed_1066;
							fragment_unnamed_1272 = fragment_unnamed_1068;
						}
						fragment_unnamed_708 = fragment_unnamed_1267;
						fragment_unnamed_710 = fragment_unnamed_1268;
						fragment_unnamed_712 = fragment_unnamed_1269;
						fragment_unnamed_714 = fragment_unnamed_1270;
						fragment_unnamed_716 = fragment_unnamed_1271;
						fragment_unnamed_718 = fragment_unnamed_1272;
					}
					else
					{
						fragment_unnamed_708 = fragment_unnamed_1058;
						fragment_unnamed_710 = fragment_unnamed_1060;
						fragment_unnamed_712 = fragment_unnamed_1062;
						fragment_unnamed_714 = fragment_unnamed_1064;
						fragment_unnamed_716 = fragment_unnamed_1066;
						fragment_unnamed_718 = fragment_unnamed_1068;
					}
					fragment_unnamed_707 = fragment_unnamed_708;
					fragment_unnamed_709 = fragment_unnamed_710;
					fragment_unnamed_711 = fragment_unnamed_712;
					fragment_unnamed_713 = fragment_unnamed_714;
					fragment_unnamed_715 = fragment_unnamed_716;
					fragment_unnamed_717 = fragment_unnamed_718;
				}
				else
				{
					fragment_unnamed_707 = fragment_unnamed_484;
					fragment_unnamed_709 = fragment_unnamed_486;
					fragment_unnamed_711 = fragment_unnamed_488;
					fragment_unnamed_713 = asfloat(0u);
					fragment_unnamed_715 = asfloat(0u);
					fragment_unnamed_717 = asfloat(0u);
				}
				float fragment_unnamed_725 = (((-0.0f) - fragment_unnamed_707) + 1.0f) * asfloat(fragment_unnamed_347);
				float fragment_unnamed_726 = (((-0.0f) - fragment_unnamed_709) + 1.0f) * asfloat(fragment_unnamed_349);
				float fragment_unnamed_727 = (((-0.0f) - fragment_unnamed_711) + 1.0f) * asfloat(fragment_unnamed_351);
				float fragment_unnamed_728 = mad(fragment_unnamed_713, fragment_unnamed_295, fragment_unnamed_725);
				float fragment_unnamed_729 = mad(fragment_unnamed_715, fragment_unnamed_295, fragment_unnamed_726);
				float fragment_unnamed_730 = mad(fragment_unnamed_717, fragment_unnamed_295, fragment_unnamed_727);
				fragment_output_0.x = fragment_unnamed_329 ? fragment_unnamed_728 : asfloat(fragment_unnamed_330 ? asuint(fragment_unnamed_725) : (fragment_unnamed_331 ? asuint(fragment_unnamed_728) : fragment_unnamed_347));
				fragment_output_0.y = fragment_unnamed_329 ? fragment_unnamed_729 : asfloat(fragment_unnamed_330 ? asuint(fragment_unnamed_726) : (fragment_unnamed_331 ? asuint(fragment_unnamed_729) : fragment_unnamed_349));
				fragment_output_0.z = fragment_unnamed_329 ? fragment_unnamed_730 : asfloat(fragment_unnamed_330 ? asuint(fragment_unnamed_727) : (fragment_unnamed_331 ? asuint(fragment_unnamed_730) : fragment_unnamed_351));
				fragment_output_0.w = fragment_unnamed_295;
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

				fragment_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				fragment_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				fragment_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				fragment_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				fragment_uniform_buffer_0[28] = float4(_InvViewProjMatrix[0][0], _InvViewProjMatrix[1][0], _InvViewProjMatrix[2][0], _InvViewProjMatrix[3][0]);
				fragment_uniform_buffer_0[29] = float4(_InvViewProjMatrix[0][1], _InvViewProjMatrix[1][1], _InvViewProjMatrix[2][1], _InvViewProjMatrix[3][1]);
				fragment_uniform_buffer_0[30] = float4(_InvViewProjMatrix[0][2], _InvViewProjMatrix[1][2], _InvViewProjMatrix[2][2], _InvViewProjMatrix[3][2]);
				fragment_uniform_buffer_0[31] = float4(_InvViewProjMatrix[0][3], _InvViewProjMatrix[1][3], _InvViewProjMatrix[2][3], _InvViewProjMatrix[3][3]);

				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_0[57] = float4(_ZBufferParams[0], _ZBufferParams[1], _ZBufferParams[2], _ZBufferParams[3]);

				fragment_uniform_buffer_0[58] = float4(_ProjectionParams[0], _ProjectionParams[1], _ProjectionParams[2], _ProjectionParams[3]);

				fragment_uniform_buffer_0[60] = float4(unity_OrthoParams[0], unity_OrthoParams[1], unity_OrthoParams[2], unity_OrthoParams[3]);

				fragment_uniform_buffer_0[61] = float4(_ScreenParams[0], _ScreenParams[1], _ScreenParams[2], _ScreenParams[3]);

				fragment_uniform_buffer_0[82] = float4(_PlanetCenterRadius[0], _PlanetCenterRadius[1], _PlanetCenterRadius[2], _PlanetCenterRadius[3]);

				fragment_uniform_buffer_0[83] = float4(_PlanetUpAltitude[0], _PlanetUpAltitude[1], _PlanetUpAltitude[2], _PlanetUpAltitude[3]);

				fragment_uniform_buffer_0[84] = float4(asfloat(_FogEnabled), fragment_uniform_buffer_0[84][1], fragment_uniform_buffer_0[84][2], fragment_uniform_buffer_0[84][3]);

				fragment_uniform_buffer_0[84] = float4(fragment_uniform_buffer_0[84][0], asfloat(_PBRFogEnabled), fragment_uniform_buffer_0[84][2], fragment_uniform_buffer_0[84][3]);

				fragment_uniform_buffer_0[84] = float4(fragment_uniform_buffer_0[84][0], fragment_uniform_buffer_0[84][1], asfloat(_EnableVolumetricFog), fragment_uniform_buffer_0[84][3]);

				fragment_uniform_buffer_0[85] = float4(_FogColor[0], _FogColor[1], _FogColor[2], _FogColor[3]);

				fragment_uniform_buffer_0[86] = float4(_FogColorMode, fragment_uniform_buffer_0[86][1], fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

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

				fragment_uniform_buffer_0[102] = float4(_BoundsSS[0], _BoundsSS[1], _BoundsSS[2], _BoundsSS[3]);

				fragment_uniform_buffer_0[103] = float4(_UpDirectionX, fragment_uniform_buffer_0[103][1], fragment_uniform_buffer_0[103][2], fragment_uniform_buffer_0[103][3]);

				fragment_uniform_buffer_0[103] = float4(fragment_uniform_buffer_0[103][0], _UpDirectionY, fragment_uniform_buffer_0[103][2], fragment_uniform_buffer_0[103][3]);

				fragment_uniform_buffer_0[107] = float4(asfloat(_UnderWaterSurfaceIndex), fragment_uniform_buffer_0[107][1], fragment_uniform_buffer_0[107][2], fragment_uniform_buffer_0[107][3]);

				fragment_uniform_buffer_0[113] = float4(asfloat(_PreRefractionPass), fragment_uniform_buffer_0[113][1], fragment_uniform_buffer_0[113][2], fragment_uniform_buffer_0[113][3]);

				fragment_uniform_buffer_0[211] = float4(_OffScreenDownsampleFactor, fragment_uniform_buffer_0[211][1], fragment_uniform_buffer_0[211][2], fragment_uniform_buffer_0[211][3]);

				fragment_uniform_buffer_1[0] = float4(_DepthMultiplier, fragment_uniform_buffer_1[0][1], fragment_uniform_buffer_1[0][2], fragment_uniform_buffer_1[0][3]);

				fragment_uniform_buffer_1[0] = float4(fragment_uniform_buffer_1[0][0], _Power, fragment_uniform_buffer_1[0][2], fragment_uniform_buffer_1[0][3]);

				fragment_uniform_buffer_1[3] = float4(_FadeDistance[0], _FadeDistance[1], fragment_uniform_buffer_1[3][2], fragment_uniform_buffer_1[3][3]);

				fragment_uniform_buffer_1[11] = float4(_BlendMode, fragment_uniform_buffer_1[11][1], fragment_uniform_buffer_1[11][2], fragment_uniform_buffer_1[11][3]);

				fragment_uniform_buffer_2[0] = float4(_AtmosphericRadius, fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_2[0] = float4(fragment_uniform_buffer_2[0][0], fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], _AerosolSeaLevelExtinction);

				fragment_uniform_buffer_2[1] = float4(_AirDensityFalloff, fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[1] = float4(fragment_uniform_buffer_2[1][0], _AirScaleHeight, fragment_uniform_buffer_2[1][2], fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[1] = float4(fragment_uniform_buffer_2[1][0], fragment_uniform_buffer_2[1][1], _AerosolDensityFalloff, fragment_uniform_buffer_2[1][3]);

				fragment_uniform_buffer_2[1] = float4(fragment_uniform_buffer_2[1][0], fragment_uniform_buffer_2[1][1], fragment_uniform_buffer_2[1][2], _AerosolScaleHeight);

				fragment_uniform_buffer_2[2] = float4(_OzoneScaleOffset[0], _OzoneScaleOffset[1], fragment_uniform_buffer_2[2][2], fragment_uniform_buffer_2[2][3]);

				fragment_uniform_buffer_2[2] = float4(fragment_uniform_buffer_2[2][0], fragment_uniform_buffer_2[2][1], _OzoneLayerStart, fragment_uniform_buffer_2[2][3]);

				fragment_uniform_buffer_2[2] = float4(fragment_uniform_buffer_2[2][0], fragment_uniform_buffer_2[2][1], fragment_uniform_buffer_2[2][2], _OzoneLayerEnd);

				fragment_uniform_buffer_2[3] = float4(_AirSeaLevelExtinction[0], _AirSeaLevelExtinction[1], _AirSeaLevelExtinction[2], _AirSeaLevelExtinction[3]);

				fragment_uniform_buffer_2[6] = float4(_OzoneSeaLevelExtinction[0], _OzoneSeaLevelExtinction[1], _OzoneSeaLevelExtinction[2], _OzoneSeaLevelExtinction[3]);

				fragment_uniform_buffer_2[8] = float4(_HorizonTint[0], _HorizonTint[1], _HorizonTint[2], _HorizonTint[3]);

				fragment_uniform_buffer_2[9] = float4(_ZenithTint[0], _ZenithTint[1], _ZenithTint[2], _ZenithTint[3]);

				fragment_uniform_buffer_2[10] = float4(fragment_uniform_buffer_2[10][0], fragment_uniform_buffer_2[10][1], _AlphaSaturation, fragment_uniform_buffer_2[10][3]);

				fragment_uniform_buffer_2[10] = float4(fragment_uniform_buffer_2[10][0], fragment_uniform_buffer_2[10][1], fragment_uniform_buffer_2[10][2], _AlphaMultiplier);

				fragment_uniform_buffer_2[11] = float4(_HorizonZenithShiftPower, fragment_uniform_buffer_2[11][1], fragment_uniform_buffer_2[11][2], fragment_uniform_buffer_2[11][3]);

				fragment_uniform_buffer_2[11] = float4(fragment_uniform_buffer_2[11][0], _HorizonZenithShiftScale, fragment_uniform_buffer_2[11][2], fragment_uniform_buffer_2[11][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(_ENABLE_FOG_ON_TRANSPARENT) && defined(_SURFACE_TYPE_TRANSPARENT)


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
		Tags { "DisableBatching" = "False" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
		Pass
		{
			Name "IndirectDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "IndirectDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 570058

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "VisibilityDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "VisibilityDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 640622

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "ForwardDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "ForwardDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 696917

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "GBufferDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "GBufferDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 736948

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "DebugDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "DebugDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 791490

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
		Pass
		{
			Name "PathTracingDXR"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "PathTracingDXR" "QUEUE" = "Transparent+0" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDUnlitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDUnlitSubTarget" }
			Fog
			{
				Color [unity_FogColor]
				Density [unity_FogDensity]
				Range [unity_FogStart], [unity_FogEnd]
			}
			GpuProgramID 871505

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
