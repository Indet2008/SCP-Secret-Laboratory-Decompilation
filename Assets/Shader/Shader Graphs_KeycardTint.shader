Shader "Shader Graphs/KeycardTint"
{
	Properties
	{
		[NoScaleOffset] _Albedo ("Albedo", 2D) = "white" {}
		_Tint ("Tint", Color) = (1,1,1,0)
		[NoScaleOffset] _Mask ("Mask", 2D) = "white" {}
		[NoScaleOffset] _Normal ("Normal", 2D) = "white" {}
		_DistanceTintRemapIn ("DistanceTintRemapIn", Vector) = (0,0,0,0)
		[ToggleUI] _IgnoreDistanceTint ("IgnoreDistanceTint", Float) = 0
		_DistanceTintSaturationRemap ("DistanceTintSaturationRemap", Vector) = (2,8,0,0)
		_DistanceTintSaturation ("DistanceTintSaturation", Float) = 1
		_HoloFade ("HoloFade", Float) = 0
		_HoloIntensity ("HoloIntensity", Float) = 4
		_HoloMask ("HoloMask", Float) = 0
		[NoScaleOffset] _HoloGradient ("HoloGradient", 2D) = "white" {}
		_HoloPower ("HoloPower", Float) = 1
		[NoScaleOffset] _PermsMask ("PermsMask", 2D) = "white" {}
		_PermsMapTilling ("PermsMapTilling", Vector) = (1,1,0,0)
		_PermsMapOffset ("PermsMapOffset", Vector) = (0,0,0,0)
		_PermsRotation ("PermsRotation", Float) = 0
		_PermsColor ("PermsColor", Color) = (0,0,0,1)
		_ContainmentStep ("ContainmentStep", Float) = 0
		_ArmoryStep ("ArmoryStep", Float) = 0
		_AdminStep ("AdminStep", Float) = 0.06
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
			GpuProgramID 13465

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


			void frag_main()
			{
			}

			void main()
			{
				frag_main();
			}


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
			GpuProgramID 277857

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma multi_compile _ _DISABLE_DECALS


			#if !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)

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

			#endif // !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_DISABLE_DECALS)

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_DISABLE_DECALS)


			#if defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)

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

			#endif // defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


			ENDHLSL
		}
		Pass
		{
			Name "TransparentDepthPrepass"
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "TransparentDepthPrepass" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
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
			GpuProgramID 371159

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ _DISABLE_DECALS
			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT


			#if defined(_DISABLE_DECALS) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float _GlobalMipBias;
			float4 unity_WorldTransformParams;
			float2 _DistanceTintRemapIn;
			float _IgnoreDistanceTint;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[10];
			static float4 fragment_uniform_buffer_2[12];
			Texture2D<float4> _Normal;
			Texture2D<float4> _Mask;
			SamplerState sampler_Normal;
			SamplerState sampler_Mask;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			void frag_main()
			{
				float fragment_unnamed_65 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				float fragment_unnamed_124 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float4 fragment_unnamed_139 = _Normal.SampleBias(sampler_Normal, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_146 = mad(fragment_unnamed_139.x * fragment_unnamed_139.w, 2.0f, -1.0f);
				float fragment_unnamed_149 = mad(fragment_unnamed_139.y, 2.0f, -1.0f);
				float fragment_unnamed_181 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_146, fragment_unnamed_149), float2(fragment_unnamed_146, fragment_unnamed_149)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_183 = mad(fragment_unnamed_181, fragment_unnamed_124 * fragment_input_4.x, mad(fragment_unnamed_146, fragment_unnamed_124 * fragment_input_1.x, (fragment_unnamed_124 * (fragment_unnamed_65 * mad(fragment_input_4.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_4.z)))) * fragment_unnamed_149));
				float fragment_unnamed_184 = mad(fragment_unnamed_181, fragment_unnamed_124 * fragment_input_4.y, mad(fragment_unnamed_146, fragment_unnamed_124 * fragment_input_1.y, (fragment_unnamed_124 * (fragment_unnamed_65 * mad(fragment_input_4.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_4.x)))) * fragment_unnamed_149));
				float fragment_unnamed_185 = mad(fragment_unnamed_181, fragment_unnamed_124 * fragment_input_4.z, mad(fragment_unnamed_146, fragment_unnamed_124 * fragment_input_1.z, (fragment_unnamed_124 * (fragment_unnamed_65 * mad(fragment_input_4.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_4.y)))) * fragment_unnamed_149));
				float fragment_unnamed_190 = rsqrt(max(dot(float3(fragment_unnamed_183, fragment_unnamed_184, fragment_unnamed_185), float3(fragment_unnamed_183, fragment_unnamed_184, fragment_unnamed_185)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_191 = fragment_unnamed_190 * fragment_unnamed_183;
				float fragment_unnamed_192 = fragment_unnamed_190 * fragment_unnamed_184;
				float fragment_unnamed_193 = fragment_unnamed_190 * fragment_unnamed_185;
				float fragment_unnamed_195 = max(abs(fragment_unnamed_193), 0.0009765625f);
				float fragment_unnamed_199 = (fragment_unnamed_193 >= 0.0f) ? fragment_unnamed_195 : ((-0.0f) - fragment_unnamed_195);
				float fragment_unnamed_208 = 1.0f / max(dot(float3(abs(fragment_unnamed_191), abs(fragment_unnamed_192), abs(fragment_unnamed_199)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_213 = clamp((-0.0f) - (fragment_unnamed_208 * fragment_unnamed_199), 0.0f, 1.0f);
				float fragment_unnamed_216 = (-0.0f) - fragment_unnamed_213;
				uint fragment_unnamed_229 = uint(clamp(mad(mad(fragment_unnamed_191, fragment_unnamed_208, ((fragment_unnamed_208 * fragment_unnamed_191) >= 0.0f) ? fragment_unnamed_213 : fragment_unnamed_216), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_230 = uint(clamp(mad(mad(fragment_unnamed_192, fragment_unnamed_208, ((fragment_unnamed_208 * fragment_unnamed_192) >= 0.0f) ? fragment_unnamed_213 : fragment_unnamed_216), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_0.x = float(fragment_unnamed_229 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(fragment_unnamed_230 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_0.z = float(((fragment_unnamed_230 >> 8u) * 16u) + (fragment_unnamed_229 >> 8u)) * 0.0039215688593685626983642578125f;
				float4 fragment_unnamed_307 = _Mask.SampleBias(sampler_Mask, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_309 = fragment_unnamed_307.w;
				fragment_output_0.w = ((-0.0f) - mad(clamp(mad(mad(fragment_uniform_buffer_0[22u].w, fragment_input_3.z, mad(fragment_uniform_buffer_0[20u].w, fragment_input_3.x, fragment_input_3.y * fragment_uniform_buffer_0[21u].w)) + fragment_uniform_buffer_0[23u].w, asfloat((0.0f != fragment_uniform_buffer_2[11u].w) ? 0u : 1065353216u), (-0.0f) - fragment_uniform_buffer_2[11u].y) / (((-0.0f) - fragment_uniform_buffer_2[11u].y) + fragment_uniform_buffer_2[11u].z), 0.0f, 1.0f), (-0.0f) - fragment_unnamed_309, fragment_unnamed_309)) + 1.0f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				fragment_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				fragment_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				fragment_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[9] = float4(unity_WorldTransformParams[0], unity_WorldTransformParams[1], unity_WorldTransformParams[2], unity_WorldTransformParams[3]);

				fragment_uniform_buffer_2[11] = float4(fragment_uniform_buffer_2[11][0], _DistanceTintRemapIn[0], _DistanceTintRemapIn[1], fragment_uniform_buffer_2[11][3]);

				fragment_uniform_buffer_2[11] = float4(fragment_uniform_buffer_2[11][0], fragment_uniform_buffer_2[11][1], fragment_uniform_buffer_2[11][2], _IgnoreDistanceTint);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
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
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;

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
				float3 vertex_output_4 : INTERP3; // INTERP_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_78 = asfloat(1065353216u);
				float vertex_unnamed_80 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_78));
				float vertex_unnamed_109 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_78));
				float vertex_unnamed_139 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_78));
				vertex_output_3.x = vertex_unnamed_109;
				vertex_output_3.y = vertex_unnamed_80;
				vertex_output_3.z = vertex_unnamed_139;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_139, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_109, vertex_unnamed_80 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				float vertex_unnamed_199 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_200 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_201 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_207 = rsqrt(max(dot(float3(vertex_unnamed_199, vertex_unnamed_200, vertex_unnamed_201), float3(vertex_unnamed_199, vertex_unnamed_200, vertex_unnamed_201)), 1.1754943508222875079687365372222e-38f));
				vertex_output_1.x = vertex_unnamed_207 * vertex_unnamed_199;
				vertex_output_1.y = vertex_unnamed_207 * vertex_unnamed_200;
				vertex_output_1.z = vertex_unnamed_207 * vertex_unnamed_201;
				vertex_output_1.w = vertex_input_2.w;
				vertex_output_2.x = vertex_input_3.x;
				vertex_output_2.y = vertex_input_3.y;
				vertex_output_2.z = vertex_input_3.z;
				vertex_output_2.w = vertex_input_3.w;
				float vertex_unnamed_241 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_256 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_271 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_278 = rsqrt(max(dot(float3(vertex_unnamed_241, vertex_unnamed_256, vertex_unnamed_271), float3(vertex_unnamed_241, vertex_unnamed_256, vertex_unnamed_271)), 1.1754943508222875079687365372222e-38f));
				vertex_output_4.x = vertex_unnamed_278 * vertex_unnamed_241;
				vertex_output_4.y = vertex_unnamed_278 * vertex_unnamed_256;
				vertex_output_4.z = vertex_unnamed_278 * vertex_unnamed_271;
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
				stage_output.vertex_output_4 = vertex_output_4;
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
			GpuProgramID 466774

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ WRITE_DECAL_BUFFER
			#pragma multi_compile _ _DISABLE_DECALS


			#if !defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;
			static float3 vertex_output_4;

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
				float3 vertex_output_4 : INTERP3; // INTERP_3
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				if ((((0.0f < vertex_uniform_buffer_2[20u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					vertex_output_4.x = 0.0f;
					vertex_output_4.y = 0.0f;
					vertex_output_4.z = 0.0f;
				}
				else
				{
					float vertex_unnamed_120 = asfloat(1065353216u);
					float vertex_unnamed_122 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_120));
					float vertex_unnamed_140 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_120));
					float vertex_unnamed_158 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_120));
					float vertex_unnamed_173 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_188 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_203 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_212 = rsqrt(max(dot(float3(vertex_unnamed_173, vertex_unnamed_188, vertex_unnamed_203), float3(vertex_unnamed_173, vertex_unnamed_188, vertex_unnamed_203)), 1.1754943508222875079687365372222e-38f));
					vertex_output_4.x = vertex_unnamed_212 * vertex_unnamed_173;
					vertex_output_4.y = vertex_unnamed_212 * vertex_unnamed_188;
					vertex_output_4.z = vertex_unnamed_212 * vertex_unnamed_203;
					float vertex_unnamed_246 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_247 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_248 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_253 = rsqrt(max(dot(float3(vertex_unnamed_246, vertex_unnamed_247, vertex_unnamed_248), float3(vertex_unnamed_246, vertex_unnamed_247, vertex_unnamed_248)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_253 * vertex_unnamed_246;
					vertex_output_1.y = vertex_unnamed_253 * vertex_unnamed_247;
					vertex_output_1.z = vertex_unnamed_253 * vertex_unnamed_248;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_158, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_122, vertex_unnamed_140 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_158, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_122, vertex_unnamed_140 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_158, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_122, vertex_unnamed_140 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_158, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_122, vertex_unnamed_140 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
					vertex_output_1.w = vertex_input_2.w;
					vertex_output_2.x = vertex_input_3.x;
					vertex_output_2.y = vertex_input_3.y;
					vertex_output_2.z = vertex_input_3.z;
					vertex_output_2.w = vertex_input_3.w;
					vertex_output_3.x = vertex_unnamed_122;
					vertex_output_3.y = vertex_unnamed_140;
					vertex_output_3.z = vertex_unnamed_158;
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

				vertex_uniform_buffer_2[20] = float4(vertex_uniform_buffer_2[20][0], vertex_uniform_buffer_2[20][1], _RayTracing, vertex_uniform_buffer_2[20][3]);

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
				stage_output.vertex_output_4 = vertex_output_4;
				return stage_output;
			}


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
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
				frag_main();
			}

			#endif // !defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)


			#if defined(WRITE_DECAL_BUFFER) && defined(_DISABLE_DECALS)

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
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
				frag_main();
			}

			#endif // defined(WRITE_DECAL_BUFFER) && defined(_DISABLE_DECALS)


			#if defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER)

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
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
				frag_main();
			}

			#endif // defined(_DISABLE_DECALS) && !defined(WRITE_DECAL_BUFFER)


			#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)

			float4 unity_RenderingLayer;

			static float4 fragment_uniform_buffer_0[11];
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float3 fragment_input_4;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
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
				float fragment_unnamed_46 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_54 = fragment_unnamed_46 * fragment_input_4.x;
				float fragment_unnamed_55 = fragment_unnamed_46 * fragment_input_4.y;
				float fragment_unnamed_56 = fragment_unnamed_46 * fragment_input_4.z;
				float fragment_unnamed_65 = 1.0f / max(dot(float3(abs(fragment_unnamed_54), abs(fragment_unnamed_55), abs(fragment_unnamed_56)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_72 = clamp((-0.0f) - (fragment_unnamed_65 * fragment_unnamed_56), 0.0f, 1.0f);
				float fragment_unnamed_76 = (-0.0f) - fragment_unnamed_72;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_54, fragment_unnamed_65, ((fragment_unnamed_65 * fragment_unnamed_54) >= 0.0f) ? fragment_unnamed_72 : fragment_unnamed_76), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_55, fragment_unnamed_65, ((fragment_unnamed_65 * fragment_unnamed_55) >= 0.0f) ? fragment_unnamed_72 : fragment_unnamed_76), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_100 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_0[10u]).x, fragment_unnamed_100, min((8u & 31u), (32u - fragment_unnamed_100)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_0[10u]).x & 255u) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)


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
			GpuProgramID 533804

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature DECALS_3RT
			#pragma shader_feature _DISABLE_DECALS


			#if !defined(DECALS_3RT) && !defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[21];
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
				if ((((0.0f < vertex_uniform_buffer_2[20u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[20] = float4(vertex_uniform_buffer_2[20][0], vertex_uniform_buffer_2[20][1], _RayTracing, vertex_uniform_buffer_2[20][3]);

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

			#endif // !defined(DECALS_3RT) && !defined(_DISABLE_DECALS)


			#if defined(DECALS_3RT) && defined(_DISABLE_DECALS)
			#define ANY_SHADER_VARIANT_ACTIVE

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
			float _ArmoryStep;
			float2 _PermsMapOffset;
			float _AdminStep;
			float4 _Tint;
			float _HoloIntensity;
			float _HoloPower;
			float _HoloMask;
			float _HoloFade;
			float _ContainmentStep;
			float2 _PermsMapTilling;
			float4 _PermsColor;
			float _PermsRotation;
			float2 _DistanceTintRemapIn;
			float _IgnoreDistanceTint;
			float2 _DistanceTintSaturationRemap;
			float _DistanceTintSaturation;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[13];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _Albedo;
			Texture2D<float4> _Normal;
			Texture2D<float4> _Mask;
			Texture2D<float4> _HoloGradient;
			Texture2D<float4> _PermsMask;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState S2;
			SamplerState sampler_Albedo;
			SamplerState sampler_Normal;
			SamplerState sampler_Mask;
			SamplerState sampler_HoloGradient;

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
				float fragment_unnamed_161 = fragment_unnamed_97 * fragment_input_1.x;
				float fragment_unnamed_162 = fragment_unnamed_97 * fragment_input_1.y;
				float fragment_unnamed_163 = fragment_unnamed_97 * fragment_input_1.z;
				float fragment_unnamed_164 = fragment_unnamed_97 * (fragment_unnamed_117 * mad(fragment_input_6.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_6.z)));
				float fragment_unnamed_165 = fragment_unnamed_97 * (fragment_unnamed_117 * mad(fragment_input_6.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_6.x)));
				float fragment_unnamed_166 = fragment_unnamed_97 * (fragment_unnamed_117 * mad(fragment_input_6.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_6.y)));
				float fragment_unnamed_173 = fragment_unnamed_97 * fragment_input_6.x;
				float fragment_unnamed_174 = fragment_unnamed_97 * fragment_input_6.y;
				float fragment_unnamed_175 = fragment_unnamed_97 * fragment_input_6.z;
				bool fragment_unnamed_180 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_206 = asfloat(fragment_unnamed_180 ? asuint(((-0.0f) - fragment_input_5.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_213 = asfloat(fragment_unnamed_180 ? asuint(((-0.0f) - fragment_input_5.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_220 = asfloat(fragment_unnamed_180 ? asuint(((-0.0f) - fragment_input_5.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_224 = rsqrt(dot(float3(fragment_unnamed_206, fragment_unnamed_213, fragment_unnamed_220), float3(fragment_unnamed_206, fragment_unnamed_213, fragment_unnamed_220)));
				float fragment_unnamed_225 = fragment_unnamed_224 * fragment_unnamed_206;
				float fragment_unnamed_226 = fragment_unnamed_224 * fragment_unnamed_213;
				float fragment_unnamed_227 = fragment_unnamed_224 * fragment_unnamed_220;
				float fragment_unnamed_231 = rsqrt(dot(float3(fragment_unnamed_173, fragment_unnamed_174, fragment_unnamed_175), float3(fragment_unnamed_173, fragment_unnamed_174, fragment_unnamed_175)));
				float fragment_unnamed_232 = fragment_unnamed_231 * fragment_unnamed_175;
				float fragment_unnamed_233 = fragment_unnamed_231 * fragment_unnamed_173;
				float fragment_unnamed_234 = fragment_unnamed_231 * fragment_unnamed_174;
				float fragment_unnamed_241 = mad(fragment_unnamed_165, fragment_unnamed_232, (-0.0f) - (fragment_unnamed_166 * fragment_unnamed_234));
				float fragment_unnamed_242 = mad(fragment_unnamed_166, fragment_unnamed_233, (-0.0f) - (fragment_unnamed_164 * fragment_unnamed_232));
				float fragment_unnamed_243 = mad(fragment_unnamed_164, fragment_unnamed_234, (-0.0f) - (fragment_unnamed_165 * fragment_unnamed_233));
				float fragment_unnamed_276 = asfloat((dot(float3(fragment_unnamed_161, fragment_unnamed_162, fragment_unnamed_163), float3(fragment_unnamed_241, fragment_unnamed_242, fragment_unnamed_243)) < 0.0f) ? 3212836864u : 1065353216u);
				float fragment_unnamed_277 = dot(float3(fragment_unnamed_241, fragment_unnamed_242, fragment_unnamed_243), float3(fragment_unnamed_225, fragment_unnamed_226, fragment_unnamed_227)) * fragment_unnamed_276;
				float fragment_unnamed_278 = dot(float3(mad(fragment_unnamed_234, fragment_unnamed_163, (-0.0f) - (fragment_unnamed_162 * fragment_unnamed_232)), mad(fragment_unnamed_232, fragment_unnamed_161, (-0.0f) - (fragment_unnamed_163 * fragment_unnamed_233)), mad(fragment_unnamed_233, fragment_unnamed_162, (-0.0f) - (fragment_unnamed_161 * fragment_unnamed_234))), float3(fragment_unnamed_225, fragment_unnamed_226, fragment_unnamed_227)) * fragment_unnamed_276;
				float fragment_unnamed_279 = dot(float3(mad(fragment_unnamed_162, fragment_unnamed_166, (-0.0f) - (fragment_unnamed_165 * fragment_unnamed_163)), mad(fragment_unnamed_163, fragment_unnamed_164, (-0.0f) - (fragment_unnamed_166 * fragment_unnamed_161)), mad(fragment_unnamed_161, fragment_unnamed_165, (-0.0f) - (fragment_unnamed_164 * fragment_unnamed_162))), float3(fragment_unnamed_225, fragment_unnamed_226, fragment_unnamed_227)) * fragment_unnamed_276;
				float fragment_unnamed_284 = rsqrt(max(dot(float3(fragment_unnamed_277, fragment_unnamed_278, fragment_unnamed_279), float3(fragment_unnamed_277, fragment_unnamed_278, fragment_unnamed_279)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_285 = fragment_unnamed_284 * fragment_unnamed_277;
				float fragment_unnamed_312 = mad(fragment_uniform_buffer_0[22u].w, fragment_input_5.z, mad(fragment_uniform_buffer_0[20u].w, fragment_input_5.x, fragment_input_5.y * fragment_uniform_buffer_0[21u].w)) + fragment_uniform_buffer_0[23u].w;
				float4 fragment_unnamed_323 = _Albedo.SampleBias(sampler_Albedo, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_326 = fragment_unnamed_323.x;
				float fragment_unnamed_327 = fragment_unnamed_323.y;
				float fragment_unnamed_328 = fragment_unnamed_323.z;
				float fragment_unnamed_334 = asfloat((0.0f != fragment_uniform_buffer_2[11u].w) ? 0u : 1065353216u);
				float fragment_unnamed_361 = min(max(((mad(fragment_unnamed_312, fragment_unnamed_334, (-0.0f) - fragment_uniform_buffer_2[12u].x) * (fragment_uniform_buffer_2[12u].z + (-1.0f))) / (((-0.0f) - fragment_uniform_buffer_2[12u].x) + fragment_uniform_buffer_2[12u].y)) + 1.0f, 1.0f), fragment_uniform_buffer_2[12u].z);
				float fragment_unnamed_367 = dot(float3(fragment_uniform_buffer_2[2u].xyz), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				float fragment_unnamed_373 = (-0.0f) - fragment_unnamed_367;
				float fragment_unnamed_404 = clamp(mad(fragment_unnamed_312, fragment_unnamed_334, (-0.0f) - fragment_uniform_buffer_2[11u].y) / (((-0.0f) - fragment_uniform_buffer_2[11u].y) + fragment_uniform_buffer_2[11u].z), 0.0f, 1.0f);
				float4 fragment_unnamed_413 = _Mask.SampleBias(sampler_Mask, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_415 = fragment_unnamed_413.x;
				float fragment_unnamed_416 = fragment_unnamed_413.y;
				float fragment_unnamed_418 = fragment_unnamed_413.w;
				float fragment_unnamed_420 = clamp(mad(clamp((fragment_unnamed_326 + (-0.23000000417232513427734375f)) * 3.8461539745330810546875f, 0.0f, 1.0f), fragment_unnamed_404, fragment_unnamed_413.z), 0.0f, 1.0f);
				float fragment_unnamed_436 = exp2(log2(fragment_unnamed_416) * fragment_uniform_buffer_2[5u].y);
				float4 fragment_unnamed_445 = _HoloGradient.SampleBias(sampler_HoloGradient, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_447 = fragment_unnamed_445.y;
				float fragment_unnamed_448 = fragment_unnamed_445.z;
				float fragment_unnamed_449 = fragment_unnamed_445.x;
				float fragment_unnamed_461 = asfloat(((fragment_unnamed_447 >= fragment_unnamed_448) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_471 = mad(fragment_unnamed_461, fragment_unnamed_447 + ((-0.0f) - fragment_unnamed_448), fragment_unnamed_448);
				float fragment_unnamed_472 = mad(fragment_unnamed_461, fragment_unnamed_448 + ((-0.0f) - fragment_unnamed_447), fragment_unnamed_447);
				float fragment_unnamed_474 = mad(fragment_unnamed_461, asfloat(3212836864u), asfloat(1059760811u));
				float fragment_unnamed_478 = asfloat(((fragment_unnamed_449 >= fragment_unnamed_471) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_487 = mad(fragment_unnamed_478, ((-0.0f) - fragment_unnamed_471) + fragment_unnamed_449, fragment_unnamed_471);
				float fragment_unnamed_488 = mad(fragment_unnamed_478, ((-0.0f) - fragment_unnamed_472) + fragment_unnamed_472, fragment_unnamed_472);
				float fragment_unnamed_490 = mad(fragment_unnamed_478, ((-0.0f) - fragment_unnamed_449) + fragment_unnamed_471, fragment_unnamed_449);
				float fragment_unnamed_493 = ((-0.0f) - min(fragment_unnamed_488, fragment_unnamed_490)) + fragment_unnamed_487;
				float fragment_unnamed_495 = fragment_unnamed_487 + 1.0000000133514319600180897396058e-10f;
				float fragment_unnamed_500 = asfloat((fragment_unnamed_493 == 0.0f) ? asuint(fragment_unnamed_487) : asuint(fragment_unnamed_495));
				float fragment_unnamed_507 = fragment_unnamed_493 / fragment_unnamed_495;
				float fragment_unnamed_509 = mad(fragment_unnamed_285 * exp2(log2(fragment_uniform_buffer_2[5u].x) * fragment_unnamed_416), fragment_unnamed_284 * fragment_unnamed_278, abs(((((-0.0f) - fragment_unnamed_488) + fragment_unnamed_490) / mad(fragment_unnamed_493, 6.0f, 1.0000000133514319600180897396058e-10f)) + mad(fragment_unnamed_478, ((-0.0f) - fragment_unnamed_474) + mad(fragment_unnamed_461, asfloat(1065353216u), asfloat(3212836864u)), fragment_unnamed_474)));
				float fragment_unnamed_519 = asfloat((fragment_unnamed_509 < 0.0f) ? asuint(fragment_unnamed_509 + 1.0f) : ((1.0f < fragment_unnamed_509) ? asuint(fragment_unnamed_509 + (-1.0f)) : asuint(fragment_unnamed_509)));
				float fragment_unnamed_563 = ((((-0.0f) - abs(fragment_unnamed_285)) + 1.0f) * fragment_uniform_buffer_2[5u].w) * fragment_uniform_buffer_2[5u].z;
				float fragment_unnamed_564 = mad(fragment_unnamed_563, fragment_unnamed_436 * (fragment_unnamed_500 * mad(fragment_unnamed_507, clamp(abs(mad(frac(fragment_unnamed_519 + 1.0f), 6.0f, -3.0f)) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)), mad(fragment_unnamed_420, mad(fragment_unnamed_326, mad(fragment_unnamed_361, fragment_unnamed_373 + fragment_uniform_buffer_2[2u].x, fragment_unnamed_367), (-0.0f) - fragment_unnamed_326), fragment_unnamed_326));
				float fragment_unnamed_565 = mad(fragment_unnamed_563, fragment_unnamed_436 * (fragment_unnamed_500 * mad(fragment_unnamed_507, clamp(abs(mad(frac(fragment_unnamed_519 + 0.666666686534881591796875f), 6.0f, -3.0f)) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)), mad(fragment_unnamed_420, mad(fragment_unnamed_327, mad(fragment_unnamed_361, fragment_unnamed_373 + fragment_uniform_buffer_2[2u].y, fragment_unnamed_367), (-0.0f) - fragment_unnamed_327), fragment_unnamed_327));
				float fragment_unnamed_566 = mad(fragment_unnamed_563, fragment_unnamed_436 * (fragment_unnamed_500 * mad(fragment_unnamed_507, clamp(abs(mad(frac(fragment_unnamed_519 + 0.3333333432674407958984375f), 6.0f, -3.0f)) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)), mad(fragment_unnamed_420, mad(fragment_unnamed_328, mad(fragment_unnamed_361, fragment_unnamed_373 + fragment_uniform_buffer_2[2u].z, fragment_unnamed_367), (-0.0f) - fragment_unnamed_328), fragment_unnamed_328));
				float fragment_unnamed_570 = fragment_uniform_buffer_2[11u].x * 0.01745329238474369049072265625f;
				float fragment_unnamed_576 = fragment_input_2.x + (-0.5f);
				float fragment_unnamed_578 = fragment_input_2.y + (-0.5f);
				float fragment_unnamed_579 = sin(fragment_unnamed_570);
				float fragment_unnamed_585 = mad(mad(cos(fragment_unnamed_570), 0.5f, 0.5f), 2.0f, -1.0f);
				float4 fragment_unnamed_611 = _PermsMask.SampleBias(S2, float2(mad(dot(float2(fragment_unnamed_576, fragment_unnamed_578), float2(fragment_unnamed_585, mad(mad(fragment_unnamed_579, 0.5f, 0.5f), 2.0f, -1.0f))) + 0.5f, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[0u].y), mad(dot(float2(fragment_unnamed_578, fragment_unnamed_576), float2(fragment_unnamed_585, mad(mad(fragment_unnamed_579, -0.5f, 0.5f), 2.0f, -1.0f))) + 0.5f, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[0u].z)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_640 = fragment_unnamed_611.w * mad((-0.0f) - asfloat(((fragment_uniform_buffer_2[7u].x >= fragment_unnamed_611.x) ? 4294967295u : 0u) & 1065353216u), asfloat(((fragment_uniform_buffer_2[0u].w >= fragment_unnamed_611.z) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_uniform_buffer_2[0u].x >= fragment_unnamed_611.y) ? 4294967295u : 0u) & 1065353216u), 1.0f);
				float fragment_unnamed_653 = mad(fragment_unnamed_640, ((-0.0f) - fragment_unnamed_564) + fragment_uniform_buffer_2[10u].x, fragment_unnamed_564);
				float fragment_unnamed_654 = mad(fragment_unnamed_640, ((-0.0f) - fragment_unnamed_565) + fragment_uniform_buffer_2[10u].y, fragment_unnamed_565);
				float fragment_unnamed_655 = mad(fragment_unnamed_640, ((-0.0f) - fragment_unnamed_566) + fragment_uniform_buffer_2[10u].z, fragment_unnamed_566);
				float4 fragment_unnamed_666 = _Normal.SampleBias(sampler_Normal, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_672 = mad(fragment_unnamed_666.x * fragment_unnamed_666.w, 2.0f, -1.0f);
				float fragment_unnamed_673 = mad(fragment_unnamed_666.y, 2.0f, -1.0f);
				float fragment_unnamed_681 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_672, fragment_unnamed_673), float2(fragment_unnamed_672, fragment_unnamed_673)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_685 = mad(fragment_unnamed_404, ((-0.0f) - fragment_unnamed_415) + 1.0f, fragment_unnamed_415);
				float fragment_unnamed_692 = mad(fragment_unnamed_681, fragment_unnamed_173, mad(fragment_unnamed_672, fragment_unnamed_161, fragment_unnamed_164 * fragment_unnamed_673));
				float fragment_unnamed_693 = mad(fragment_unnamed_681, fragment_unnamed_174, mad(fragment_unnamed_672, fragment_unnamed_162, fragment_unnamed_165 * fragment_unnamed_673));
				float fragment_unnamed_694 = mad(fragment_unnamed_681, fragment_unnamed_175, mad(fragment_unnamed_672, fragment_unnamed_163, fragment_unnamed_166 * fragment_unnamed_673));
				float fragment_unnamed_699 = rsqrt(max(dot(float3(fragment_unnamed_692, fragment_unnamed_693, fragment_unnamed_694), float3(fragment_unnamed_692, fragment_unnamed_693, fragment_unnamed_694)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_700 = fragment_unnamed_692 * fragment_unnamed_699;
				float fragment_unnamed_701 = fragment_unnamed_693 * fragment_unnamed_699;
				float fragment_unnamed_702 = fragment_unnamed_694 * fragment_unnamed_699;
				uint4 fragment_unnamed_716 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_717 = fragment_unnamed_716.x;
				float fragment_unnamed_999;
				float fragment_unnamed_1001;
				float fragment_unnamed_1003;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_717 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_717 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_1000;
					float fragment_unnamed_1002;
					float fragment_unnamed_1004;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_739 = asfloat(1065353216u);
						float fragment_unnamed_768 = fragment_unnamed_701 * fragment_unnamed_700;
						float fragment_unnamed_769 = fragment_unnamed_702 * fragment_unnamed_701;
						float fragment_unnamed_770 = fragment_unnamed_702 * fragment_unnamed_702;
						float fragment_unnamed_771 = fragment_unnamed_700 * fragment_unnamed_702;
						float fragment_unnamed_804 = mad(fragment_unnamed_700, fragment_unnamed_700, (-0.0f) - (fragment_unnamed_701 * fragment_unnamed_701));
						fragment_unnamed_1000 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_700, fragment_unnamed_701, fragment_unnamed_702, fragment_unnamed_739)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_804, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_771)));
						fragment_unnamed_1002 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_700, fragment_unnamed_701, fragment_unnamed_702, fragment_unnamed_739)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_804, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_771)));
						fragment_unnamed_1004 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_700, fragment_unnamed_701, fragment_unnamed_702, fragment_unnamed_739)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_804, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_768, fragment_unnamed_769, fragment_unnamed_770, fragment_unnamed_771)));
					}
					else
					{
						bool fragment_unnamed_820 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_821 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_843 = fragment_unnamed_820 ? (fragment_input_5.x + fragment_uniform_buffer_0[48u].x) : fragment_input_5.x;
						float fragment_unnamed_844 = fragment_unnamed_820 ? (fragment_input_5.y + fragment_uniform_buffer_0[48u].y) : fragment_input_5.y;
						float fragment_unnamed_845 = fragment_unnamed_820 ? (fragment_input_5.z + fragment_uniform_buffer_0[48u].z) : fragment_input_5.z;
						float fragment_unnamed_948 = (asfloat(fragment_unnamed_821 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_845, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_843, fragment_unnamed_844 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_844)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_949 = (asfloat(fragment_unnamed_821 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_845, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_843, fragment_unnamed_844 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_845)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_962 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_821 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_845, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_843, fragment_unnamed_844 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_843)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_989 = asfloat(1065353216u);
						fragment_unnamed_1000 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_962 + 0.5f, fragment_unnamed_948 + 0.0f, fragment_unnamed_949 + 0.0f), 0.0f)), float4(fragment_unnamed_700, fragment_unnamed_701, fragment_unnamed_702, fragment_unnamed_989));
						fragment_unnamed_1002 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_962 + 0.25f, fragment_unnamed_948 + 0.0f, fragment_unnamed_949 + 0.0f), 0.0f)), float4(fragment_unnamed_700, fragment_unnamed_701, fragment_unnamed_702, fragment_unnamed_989));
						fragment_unnamed_1004 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_962, fragment_unnamed_948, fragment_unnamed_949), 0.0f)), float4(fragment_unnamed_700, fragment_unnamed_701, fragment_unnamed_702, fragment_unnamed_989));
					}
					fragment_unnamed_999 = fragment_unnamed_1000;
					fragment_unnamed_1001 = fragment_unnamed_1002;
					fragment_unnamed_1003 = fragment_unnamed_1004;
				}
				else
				{
					fragment_unnamed_999 = asfloat(0u);
					fragment_unnamed_1001 = asfloat(0u);
					fragment_unnamed_1003 = asfloat(0u);
				}
				float fragment_unnamed_1006 = ((-0.0f) - mad(fragment_unnamed_404, (-0.0f) - fragment_unnamed_418, fragment_unnamed_418)) + 1.0f;
				float fragment_unnamed_1008 = ((-0.0f) - fragment_unnamed_685) + 1.0f;
				float fragment_unnamed_1009 = fragment_unnamed_1008 * fragment_unnamed_653;
				float fragment_unnamed_1010 = fragment_unnamed_1008 * fragment_unnamed_654;
				float fragment_unnamed_1011 = fragment_unnamed_1008 * fragment_unnamed_655;
				float fragment_unnamed_1016 = mad(fragment_unnamed_685, fragment_unnamed_653 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1018 = mad(fragment_unnamed_685, fragment_unnamed_654 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1019 = mad(fragment_unnamed_685, fragment_unnamed_655 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1036 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_700, fragment_unnamed_701, fragment_unnamed_702), float3(fragment_unnamed_225, fragment_unnamed_226, fragment_unnamed_227)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_1006, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_1046 = clamp((max(fragment_unnamed_1019, max(fragment_unnamed_1018, fragment_unnamed_1016)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_1070 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1075 = max(abs(fragment_unnamed_702), 0.0009765625f);
				float fragment_unnamed_1079 = (fragment_unnamed_702 >= 0.0f) ? fragment_unnamed_1075 : ((-0.0f) - fragment_unnamed_1075);
				float fragment_unnamed_1088 = 1.0f / max(dot(float3(abs(fragment_unnamed_700), abs(fragment_unnamed_701), abs(fragment_unnamed_1079)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1093 = clamp((-0.0f) - (fragment_unnamed_1088 * fragment_unnamed_1079), 0.0f, 1.0f);
				float fragment_unnamed_1096 = (-0.0f) - fragment_unnamed_1093;
				uint fragment_unnamed_1108 = uint(clamp(mad(mad(fragment_unnamed_700, fragment_unnamed_1088, ((fragment_unnamed_1088 * fragment_unnamed_700) >= 0.0f) ? fragment_unnamed_1093 : fragment_unnamed_1096), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1109 = uint(clamp(mad(mad(fragment_unnamed_701, fragment_unnamed_1088, ((fragment_unnamed_1088 * fragment_unnamed_701) >= 0.0f) ? fragment_unnamed_1093 : fragment_unnamed_1096), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1108 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1109 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1109 >> 8u) * 16u) + (fragment_unnamed_1108 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_1016)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_1018)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_1019)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_1160 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1161 = fragment_unnamed_1160 * (fragment_unnamed_1070 * ((fragment_unnamed_1036 * mad(fragment_unnamed_1046, mad((-0.0f) - fragment_unnamed_653, fragment_unnamed_1008, fragment_unnamed_1016), fragment_unnamed_1009)) * fragment_unnamed_1003));
				float fragment_unnamed_1162 = fragment_unnamed_1160 * (fragment_unnamed_1070 * ((fragment_unnamed_1036 * mad(fragment_unnamed_1046, mad((-0.0f) - fragment_unnamed_654, fragment_unnamed_1008, fragment_unnamed_1018), fragment_unnamed_1010)) * fragment_unnamed_1001));
				float fragment_unnamed_1163 = fragment_unnamed_1160 * (fragment_unnamed_1070 * ((fragment_unnamed_1036 * mad(fragment_unnamed_1046, mad((-0.0f) - fragment_unnamed_655, fragment_unnamed_1008, fragment_unnamed_1019), fragment_unnamed_1011)) * fragment_unnamed_999));
				bool fragment_unnamed_1172 = (((fragment_unnamed_1163 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1162 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1161 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1172 ? 2048.0f : fragment_unnamed_1161;
				fragment_output_3.y = fragment_unnamed_1172 ? 1.0f : fragment_unnamed_1162;
				fragment_output_3.z = fragment_unnamed_1172 ? 1024.0f : fragment_unnamed_1163;
				fragment_output_0.x = fragment_unnamed_1009;
				fragment_output_0.y = fragment_unnamed_1010;
				fragment_output_0.z = fragment_unnamed_1011;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_unnamed_1006;
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

				fragment_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				fragment_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				fragment_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				fragment_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

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

				fragment_uniform_buffer_2[0] = float4(_ArmoryStep, fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_2[0] = float4(fragment_uniform_buffer_2[0][0], _PermsMapOffset[0], _PermsMapOffset[1], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_2[0] = float4(fragment_uniform_buffer_2[0][0], fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], _AdminStep);

				fragment_uniform_buffer_2[2] = float4(_Tint[0], _Tint[1], _Tint[2], _Tint[3]);

				fragment_uniform_buffer_2[5] = float4(_HoloIntensity, fragment_uniform_buffer_2[5][1], fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], _HoloPower, fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], fragment_uniform_buffer_2[5][1], _HoloMask, fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], fragment_uniform_buffer_2[5][1], fragment_uniform_buffer_2[5][2], _HoloFade);

				fragment_uniform_buffer_2[7] = float4(_ContainmentStep, fragment_uniform_buffer_2[7][1], fragment_uniform_buffer_2[7][2], fragment_uniform_buffer_2[7][3]);

				fragment_uniform_buffer_2[9] = float4(_PermsMapTilling[0], _PermsMapTilling[1], fragment_uniform_buffer_2[9][2], fragment_uniform_buffer_2[9][3]);

				fragment_uniform_buffer_2[10] = float4(_PermsColor[0], _PermsColor[1], _PermsColor[2], _PermsColor[3]);

				fragment_uniform_buffer_2[11] = float4(_PermsRotation, fragment_uniform_buffer_2[11][1], fragment_uniform_buffer_2[11][2], fragment_uniform_buffer_2[11][3]);

				fragment_uniform_buffer_2[11] = float4(fragment_uniform_buffer_2[11][0], _DistanceTintRemapIn[0], _DistanceTintRemapIn[1], fragment_uniform_buffer_2[11][3]);

				fragment_uniform_buffer_2[11] = float4(fragment_uniform_buffer_2[11][0], fragment_uniform_buffer_2[11][1], fragment_uniform_buffer_2[11][2], _IgnoreDistanceTint);

				fragment_uniform_buffer_2[12] = float4(_DistanceTintSaturationRemap[0], _DistanceTintSaturationRemap[1], fragment_uniform_buffer_2[12][2], fragment_uniform_buffer_2[12][3]);

				fragment_uniform_buffer_2[12] = float4(fragment_uniform_buffer_2[12][0], fragment_uniform_buffer_2[12][1], _DistanceTintSaturation, fragment_uniform_buffer_2[12][3]);

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

			#endif // defined(DECALS_3RT) && defined(_DISABLE_DECALS)


			#if defined(DECALS_3RT) && !defined(_DISABLE_DECALS)
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
			float _ArmoryStep;
			float2 _PermsMapOffset;
			float _AdminStep;
			float4 _Tint;
			float _HoloIntensity;
			float _HoloPower;
			float _HoloMask;
			float _HoloFade;
			float _ContainmentStep;
			float2 _PermsMapTilling;
			float4 _PermsColor;
			float _PermsRotation;
			float2 _DistanceTintRemapIn;
			float _IgnoreDistanceTint;
			float2 _DistanceTintSaturationRemap;
			float _DistanceTintSaturation;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[13];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _Albedo;
			Texture2D<float4> _Normal;
			Texture2D<float4> _Mask;
			Texture2D<float4> _HoloGradient;
			Texture2D<float4> _PermsMask;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState S2;
			SamplerState sampler_Albedo;
			SamplerState sampler_Normal;
			SamplerState sampler_Mask;
			SamplerState sampler_HoloGradient;

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
				float fragment_unnamed_169 = fragment_unnamed_105 * fragment_input_1.x;
				float fragment_unnamed_170 = fragment_unnamed_105 * fragment_input_1.y;
				float fragment_unnamed_171 = fragment_unnamed_105 * fragment_input_1.z;
				float fragment_unnamed_172 = fragment_unnamed_105 * (fragment_unnamed_125 * mad(fragment_input_6.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_6.z)));
				float fragment_unnamed_173 = fragment_unnamed_105 * (fragment_unnamed_125 * mad(fragment_input_6.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_6.x)));
				float fragment_unnamed_174 = fragment_unnamed_105 * (fragment_unnamed_125 * mad(fragment_input_6.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_6.y)));
				float fragment_unnamed_181 = fragment_unnamed_105 * fragment_input_6.x;
				float fragment_unnamed_182 = fragment_unnamed_105 * fragment_input_6.y;
				float fragment_unnamed_183 = fragment_unnamed_105 * fragment_input_6.z;
				bool fragment_unnamed_188 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_214 = asfloat(fragment_unnamed_188 ? asuint(((-0.0f) - fragment_input_5.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_221 = asfloat(fragment_unnamed_188 ? asuint(((-0.0f) - fragment_input_5.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_228 = asfloat(fragment_unnamed_188 ? asuint(((-0.0f) - fragment_input_5.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_232 = rsqrt(dot(float3(fragment_unnamed_214, fragment_unnamed_221, fragment_unnamed_228), float3(fragment_unnamed_214, fragment_unnamed_221, fragment_unnamed_228)));
				float fragment_unnamed_233 = fragment_unnamed_232 * fragment_unnamed_214;
				float fragment_unnamed_234 = fragment_unnamed_232 * fragment_unnamed_221;
				float fragment_unnamed_235 = fragment_unnamed_232 * fragment_unnamed_228;
				float fragment_unnamed_239 = rsqrt(dot(float3(fragment_unnamed_181, fragment_unnamed_182, fragment_unnamed_183), float3(fragment_unnamed_181, fragment_unnamed_182, fragment_unnamed_183)));
				float fragment_unnamed_240 = fragment_unnamed_239 * fragment_unnamed_183;
				float fragment_unnamed_241 = fragment_unnamed_239 * fragment_unnamed_181;
				float fragment_unnamed_242 = fragment_unnamed_239 * fragment_unnamed_182;
				float fragment_unnamed_249 = mad(fragment_unnamed_173, fragment_unnamed_240, (-0.0f) - (fragment_unnamed_174 * fragment_unnamed_242));
				float fragment_unnamed_250 = mad(fragment_unnamed_174, fragment_unnamed_241, (-0.0f) - (fragment_unnamed_172 * fragment_unnamed_240));
				float fragment_unnamed_251 = mad(fragment_unnamed_172, fragment_unnamed_242, (-0.0f) - (fragment_unnamed_173 * fragment_unnamed_241));
				float fragment_unnamed_284 = asfloat((dot(float3(fragment_unnamed_169, fragment_unnamed_170, fragment_unnamed_171), float3(fragment_unnamed_249, fragment_unnamed_250, fragment_unnamed_251)) < 0.0f) ? 3212836864u : 1065353216u);
				float fragment_unnamed_285 = dot(float3(fragment_unnamed_249, fragment_unnamed_250, fragment_unnamed_251), float3(fragment_unnamed_233, fragment_unnamed_234, fragment_unnamed_235)) * fragment_unnamed_284;
				float fragment_unnamed_286 = dot(float3(mad(fragment_unnamed_242, fragment_unnamed_171, (-0.0f) - (fragment_unnamed_170 * fragment_unnamed_240)), mad(fragment_unnamed_240, fragment_unnamed_169, (-0.0f) - (fragment_unnamed_171 * fragment_unnamed_241)), mad(fragment_unnamed_241, fragment_unnamed_170, (-0.0f) - (fragment_unnamed_169 * fragment_unnamed_242))), float3(fragment_unnamed_233, fragment_unnamed_234, fragment_unnamed_235)) * fragment_unnamed_284;
				float fragment_unnamed_287 = dot(float3(mad(fragment_unnamed_170, fragment_unnamed_174, (-0.0f) - (fragment_unnamed_173 * fragment_unnamed_171)), mad(fragment_unnamed_171, fragment_unnamed_172, (-0.0f) - (fragment_unnamed_174 * fragment_unnamed_169)), mad(fragment_unnamed_169, fragment_unnamed_173, (-0.0f) - (fragment_unnamed_172 * fragment_unnamed_170))), float3(fragment_unnamed_233, fragment_unnamed_234, fragment_unnamed_235)) * fragment_unnamed_284;
				float fragment_unnamed_292 = rsqrt(max(dot(float3(fragment_unnamed_285, fragment_unnamed_286, fragment_unnamed_287), float3(fragment_unnamed_285, fragment_unnamed_286, fragment_unnamed_287)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_293 = fragment_unnamed_292 * fragment_unnamed_285;
				float fragment_unnamed_320 = mad(fragment_uniform_buffer_0[22u].w, fragment_input_5.z, mad(fragment_uniform_buffer_0[20u].w, fragment_input_5.x, fragment_input_5.y * fragment_uniform_buffer_0[21u].w)) + fragment_uniform_buffer_0[23u].w;
				float4 fragment_unnamed_331 = _Albedo.SampleBias(sampler_Albedo, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_334 = fragment_unnamed_331.x;
				float fragment_unnamed_335 = fragment_unnamed_331.y;
				float fragment_unnamed_336 = fragment_unnamed_331.z;
				float fragment_unnamed_342 = asfloat((0.0f != fragment_uniform_buffer_2[11u].w) ? 0u : 1065353216u);
				float fragment_unnamed_369 = min(max(((mad(fragment_unnamed_320, fragment_unnamed_342, (-0.0f) - fragment_uniform_buffer_2[12u].x) * (fragment_uniform_buffer_2[12u].z + (-1.0f))) / (((-0.0f) - fragment_uniform_buffer_2[12u].x) + fragment_uniform_buffer_2[12u].y)) + 1.0f, 1.0f), fragment_uniform_buffer_2[12u].z);
				float fragment_unnamed_375 = dot(float3(fragment_uniform_buffer_2[2u].xyz), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				float fragment_unnamed_381 = (-0.0f) - fragment_unnamed_375;
				float fragment_unnamed_412 = clamp(mad(fragment_unnamed_320, fragment_unnamed_342, (-0.0f) - fragment_uniform_buffer_2[11u].y) / (((-0.0f) - fragment_uniform_buffer_2[11u].y) + fragment_uniform_buffer_2[11u].z), 0.0f, 1.0f);
				float4 fragment_unnamed_421 = _Mask.SampleBias(sampler_Mask, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_423 = fragment_unnamed_421.x;
				float fragment_unnamed_424 = fragment_unnamed_421.y;
				float fragment_unnamed_426 = fragment_unnamed_421.w;
				float fragment_unnamed_428 = clamp(mad(clamp((fragment_unnamed_334 + (-0.23000000417232513427734375f)) * 3.8461539745330810546875f, 0.0f, 1.0f), fragment_unnamed_412, fragment_unnamed_421.z), 0.0f, 1.0f);
				float fragment_unnamed_444 = exp2(log2(fragment_unnamed_424) * fragment_uniform_buffer_2[5u].y);
				float4 fragment_unnamed_453 = _HoloGradient.SampleBias(sampler_HoloGradient, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_455 = fragment_unnamed_453.y;
				float fragment_unnamed_456 = fragment_unnamed_453.z;
				float fragment_unnamed_457 = fragment_unnamed_453.x;
				float fragment_unnamed_469 = asfloat(((fragment_unnamed_455 >= fragment_unnamed_456) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_479 = mad(fragment_unnamed_469, fragment_unnamed_455 + ((-0.0f) - fragment_unnamed_456), fragment_unnamed_456);
				float fragment_unnamed_480 = mad(fragment_unnamed_469, fragment_unnamed_456 + ((-0.0f) - fragment_unnamed_455), fragment_unnamed_455);
				float fragment_unnamed_482 = mad(fragment_unnamed_469, asfloat(3212836864u), asfloat(1059760811u));
				float fragment_unnamed_486 = asfloat(((fragment_unnamed_457 >= fragment_unnamed_479) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_495 = mad(fragment_unnamed_486, ((-0.0f) - fragment_unnamed_479) + fragment_unnamed_457, fragment_unnamed_479);
				float fragment_unnamed_496 = mad(fragment_unnamed_486, ((-0.0f) - fragment_unnamed_480) + fragment_unnamed_480, fragment_unnamed_480);
				float fragment_unnamed_498 = mad(fragment_unnamed_486, ((-0.0f) - fragment_unnamed_457) + fragment_unnamed_479, fragment_unnamed_457);
				float fragment_unnamed_501 = ((-0.0f) - min(fragment_unnamed_496, fragment_unnamed_498)) + fragment_unnamed_495;
				float fragment_unnamed_503 = fragment_unnamed_495 + 1.0000000133514319600180897396058e-10f;
				float fragment_unnamed_508 = asfloat((fragment_unnamed_501 == 0.0f) ? asuint(fragment_unnamed_495) : asuint(fragment_unnamed_503));
				float fragment_unnamed_515 = fragment_unnamed_501 / fragment_unnamed_503;
				float fragment_unnamed_517 = mad(fragment_unnamed_293 * exp2(log2(fragment_uniform_buffer_2[5u].x) * fragment_unnamed_424), fragment_unnamed_292 * fragment_unnamed_286, abs(((((-0.0f) - fragment_unnamed_496) + fragment_unnamed_498) / mad(fragment_unnamed_501, 6.0f, 1.0000000133514319600180897396058e-10f)) + mad(fragment_unnamed_486, ((-0.0f) - fragment_unnamed_482) + mad(fragment_unnamed_469, asfloat(1065353216u), asfloat(3212836864u)), fragment_unnamed_482)));
				float fragment_unnamed_527 = asfloat((fragment_unnamed_517 < 0.0f) ? asuint(fragment_unnamed_517 + 1.0f) : ((1.0f < fragment_unnamed_517) ? asuint(fragment_unnamed_517 + (-1.0f)) : asuint(fragment_unnamed_517)));
				float fragment_unnamed_571 = ((((-0.0f) - abs(fragment_unnamed_293)) + 1.0f) * fragment_uniform_buffer_2[5u].w) * fragment_uniform_buffer_2[5u].z;
				float fragment_unnamed_572 = mad(fragment_unnamed_571, fragment_unnamed_444 * (fragment_unnamed_508 * mad(fragment_unnamed_515, clamp(abs(mad(frac(fragment_unnamed_527 + 1.0f), 6.0f, -3.0f)) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)), mad(fragment_unnamed_428, mad(fragment_unnamed_334, mad(fragment_unnamed_369, fragment_unnamed_381 + fragment_uniform_buffer_2[2u].x, fragment_unnamed_375), (-0.0f) - fragment_unnamed_334), fragment_unnamed_334));
				float fragment_unnamed_573 = mad(fragment_unnamed_571, fragment_unnamed_444 * (fragment_unnamed_508 * mad(fragment_unnamed_515, clamp(abs(mad(frac(fragment_unnamed_527 + 0.666666686534881591796875f), 6.0f, -3.0f)) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)), mad(fragment_unnamed_428, mad(fragment_unnamed_335, mad(fragment_unnamed_369, fragment_unnamed_381 + fragment_uniform_buffer_2[2u].y, fragment_unnamed_375), (-0.0f) - fragment_unnamed_335), fragment_unnamed_335));
				float fragment_unnamed_574 = mad(fragment_unnamed_571, fragment_unnamed_444 * (fragment_unnamed_508 * mad(fragment_unnamed_515, clamp(abs(mad(frac(fragment_unnamed_527 + 0.3333333432674407958984375f), 6.0f, -3.0f)) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)), mad(fragment_unnamed_428, mad(fragment_unnamed_336, mad(fragment_unnamed_369, fragment_unnamed_381 + fragment_uniform_buffer_2[2u].z, fragment_unnamed_375), (-0.0f) - fragment_unnamed_336), fragment_unnamed_336));
				float fragment_unnamed_578 = fragment_uniform_buffer_2[11u].x * 0.01745329238474369049072265625f;
				float fragment_unnamed_584 = fragment_input_2.x + (-0.5f);
				float fragment_unnamed_586 = fragment_input_2.y + (-0.5f);
				float fragment_unnamed_587 = sin(fragment_unnamed_578);
				float fragment_unnamed_593 = mad(mad(cos(fragment_unnamed_578), 0.5f, 0.5f), 2.0f, -1.0f);
				float4 fragment_unnamed_619 = _PermsMask.SampleBias(S2, float2(mad(dot(float2(fragment_unnamed_584, fragment_unnamed_586), float2(fragment_unnamed_593, mad(mad(fragment_unnamed_587, 0.5f, 0.5f), 2.0f, -1.0f))) + 0.5f, fragment_uniform_buffer_2[9u].x, fragment_uniform_buffer_2[0u].y), mad(dot(float2(fragment_unnamed_586, fragment_unnamed_584), float2(fragment_unnamed_593, mad(mad(fragment_unnamed_587, -0.5f, 0.5f), 2.0f, -1.0f))) + 0.5f, fragment_uniform_buffer_2[9u].y, fragment_uniform_buffer_2[0u].z)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_648 = fragment_unnamed_619.w * mad((-0.0f) - asfloat(((fragment_uniform_buffer_2[7u].x >= fragment_unnamed_619.x) ? 4294967295u : 0u) & 1065353216u), asfloat(((fragment_uniform_buffer_2[0u].w >= fragment_unnamed_619.z) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_uniform_buffer_2[0u].x >= fragment_unnamed_619.y) ? 4294967295u : 0u) & 1065353216u), 1.0f);
				float fragment_unnamed_661 = mad(fragment_unnamed_648, ((-0.0f) - fragment_unnamed_572) + fragment_uniform_buffer_2[10u].x, fragment_unnamed_572);
				float fragment_unnamed_662 = mad(fragment_unnamed_648, ((-0.0f) - fragment_unnamed_573) + fragment_uniform_buffer_2[10u].y, fragment_unnamed_573);
				float fragment_unnamed_663 = mad(fragment_unnamed_648, ((-0.0f) - fragment_unnamed_574) + fragment_uniform_buffer_2[10u].z, fragment_unnamed_574);
				float fragment_unnamed_665 = mad(fragment_unnamed_412, (-0.0f) - fragment_unnamed_426, fragment_unnamed_426);
				float4 fragment_unnamed_674 = _Normal.SampleBias(sampler_Normal, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_680 = mad(fragment_unnamed_674.x * fragment_unnamed_674.w, 2.0f, -1.0f);
				float fragment_unnamed_681 = mad(fragment_unnamed_674.y, 2.0f, -1.0f);
				float fragment_unnamed_689 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_680, fragment_unnamed_681), float2(fragment_unnamed_680, fragment_unnamed_681)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_693 = mad(fragment_unnamed_412, ((-0.0f) - fragment_unnamed_423) + 1.0f, fragment_unnamed_423);
				float fragment_unnamed_700 = mad(fragment_unnamed_689, fragment_unnamed_181, mad(fragment_unnamed_680, fragment_unnamed_169, fragment_unnamed_172 * fragment_unnamed_681));
				float fragment_unnamed_701 = mad(fragment_unnamed_689, fragment_unnamed_182, mad(fragment_unnamed_680, fragment_unnamed_170, fragment_unnamed_173 * fragment_unnamed_681));
				float fragment_unnamed_702 = mad(fragment_unnamed_689, fragment_unnamed_183, mad(fragment_unnamed_680, fragment_unnamed_171, fragment_unnamed_174 * fragment_unnamed_681));
				float fragment_unnamed_707 = rsqrt(max(dot(float3(fragment_unnamed_700, fragment_unnamed_701, fragment_unnamed_702), float3(fragment_unnamed_700, fragment_unnamed_701, fragment_unnamed_702)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_708 = fragment_unnamed_700 * fragment_unnamed_707;
				float fragment_unnamed_709 = fragment_unnamed_701 * fragment_unnamed_707;
				float fragment_unnamed_710 = fragment_unnamed_702 * fragment_unnamed_707;
				float fragment_unnamed_772;
				float fragment_unnamed_773;
				float fragment_unnamed_774;
				float fragment_unnamed_775;
				float fragment_unnamed_776;
				float fragment_unnamed_777;
				float fragment_unnamed_778;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_721 = uint(gl_FragCoord.x);
					uint fragment_unnamed_722 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_723 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_721, fragment_unnamed_722, 0u), 0u));
					float fragment_unnamed_729 = fragment_unnamed_723.w;
					float4 fragment_unnamed_730 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_721, fragment_unnamed_722, 0u), 0u));
					float fragment_unnamed_735 = fragment_unnamed_730.w;
					float4 fragment_unnamed_736 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_721, fragment_unnamed_722, 0u), 0u));
					bool fragment_unnamed_744 = fragment_unnamed_735 < 1.0f;
					float fragment_unnamed_745 = mad(fragment_unnamed_708, fragment_unnamed_735, mad(fragment_unnamed_730.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_746 = mad(fragment_unnamed_709, fragment_unnamed_735, mad(fragment_unnamed_730.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_747 = mad(fragment_unnamed_710, fragment_unnamed_735, mad(fragment_unnamed_730.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_752 = rsqrt(max(dot(float3(fragment_unnamed_745, fragment_unnamed_746, fragment_unnamed_747), float3(fragment_unnamed_745, fragment_unnamed_746, fragment_unnamed_747)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_772 = asfloat(fragment_unnamed_744 ? asuint(fragment_unnamed_747 * fragment_unnamed_752) : asuint(fragment_unnamed_710));
					fragment_unnamed_773 = mad(fragment_unnamed_661, fragment_unnamed_729, fragment_unnamed_723.x);
					fragment_unnamed_774 = mad(fragment_unnamed_662, fragment_unnamed_729, fragment_unnamed_723.y);
					fragment_unnamed_775 = mad(fragment_unnamed_663, fragment_unnamed_729, fragment_unnamed_723.z);
					fragment_unnamed_776 = mad(fragment_unnamed_665, fragment_unnamed_736.w, fragment_unnamed_736.z);
					fragment_unnamed_777 = asfloat(fragment_unnamed_744 ? asuint(fragment_unnamed_746 * fragment_unnamed_752) : asuint(fragment_unnamed_709));
					fragment_unnamed_778 = asfloat(fragment_unnamed_744 ? asuint(fragment_unnamed_745 * fragment_unnamed_752) : asuint(fragment_unnamed_708));
				}
				else
				{
					fragment_unnamed_772 = fragment_unnamed_710;
					fragment_unnamed_773 = fragment_unnamed_661;
					fragment_unnamed_774 = fragment_unnamed_662;
					fragment_unnamed_775 = fragment_unnamed_663;
					fragment_unnamed_776 = fragment_unnamed_665;
					fragment_unnamed_777 = fragment_unnamed_709;
					fragment_unnamed_778 = fragment_unnamed_708;
				}
				uint4 fragment_unnamed_792 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_793 = fragment_unnamed_792.x;
				float fragment_unnamed_1075;
				float fragment_unnamed_1077;
				float fragment_unnamed_1079;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_793 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_793 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_1076;
					float fragment_unnamed_1078;
					float fragment_unnamed_1080;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_815 = asfloat(1065353216u);
						float fragment_unnamed_844 = fragment_unnamed_777 * fragment_unnamed_778;
						float fragment_unnamed_845 = fragment_unnamed_772 * fragment_unnamed_777;
						float fragment_unnamed_846 = fragment_unnamed_772 * fragment_unnamed_772;
						float fragment_unnamed_847 = fragment_unnamed_778 * fragment_unnamed_772;
						float fragment_unnamed_880 = mad(fragment_unnamed_778, fragment_unnamed_778, (-0.0f) - (fragment_unnamed_777 * fragment_unnamed_777));
						fragment_unnamed_1076 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_778, fragment_unnamed_777, fragment_unnamed_772, fragment_unnamed_815)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_880, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_844, fragment_unnamed_845, fragment_unnamed_846, fragment_unnamed_847)));
						fragment_unnamed_1078 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_778, fragment_unnamed_777, fragment_unnamed_772, fragment_unnamed_815)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_880, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_844, fragment_unnamed_845, fragment_unnamed_846, fragment_unnamed_847)));
						fragment_unnamed_1080 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_778, fragment_unnamed_777, fragment_unnamed_772, fragment_unnamed_815)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_880, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_844, fragment_unnamed_845, fragment_unnamed_846, fragment_unnamed_847)));
					}
					else
					{
						bool fragment_unnamed_896 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_897 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_919 = fragment_unnamed_896 ? (fragment_input_5.x + fragment_uniform_buffer_0[48u].x) : fragment_input_5.x;
						float fragment_unnamed_920 = fragment_unnamed_896 ? (fragment_input_5.y + fragment_uniform_buffer_0[48u].y) : fragment_input_5.y;
						float fragment_unnamed_921 = fragment_unnamed_896 ? (fragment_input_5.z + fragment_uniform_buffer_0[48u].z) : fragment_input_5.z;
						float fragment_unnamed_1024 = (asfloat(fragment_unnamed_897 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_921, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_919, fragment_unnamed_920 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_920)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_1025 = (asfloat(fragment_unnamed_897 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_921, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_919, fragment_unnamed_920 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_921)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_1038 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_897 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_921, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_919, fragment_unnamed_920 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_919)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_1065 = asfloat(1065353216u);
						fragment_unnamed_1076 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1038 + 0.5f, fragment_unnamed_1024 + 0.0f, fragment_unnamed_1025 + 0.0f), 0.0f)), float4(fragment_unnamed_778, fragment_unnamed_777, fragment_unnamed_772, fragment_unnamed_1065));
						fragment_unnamed_1078 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1038 + 0.25f, fragment_unnamed_1024 + 0.0f, fragment_unnamed_1025 + 0.0f), 0.0f)), float4(fragment_unnamed_778, fragment_unnamed_777, fragment_unnamed_772, fragment_unnamed_1065));
						fragment_unnamed_1080 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1038, fragment_unnamed_1024, fragment_unnamed_1025), 0.0f)), float4(fragment_unnamed_778, fragment_unnamed_777, fragment_unnamed_772, fragment_unnamed_1065));
					}
					fragment_unnamed_1075 = fragment_unnamed_1076;
					fragment_unnamed_1077 = fragment_unnamed_1078;
					fragment_unnamed_1079 = fragment_unnamed_1080;
				}
				else
				{
					fragment_unnamed_1075 = asfloat(0u);
					fragment_unnamed_1077 = asfloat(0u);
					fragment_unnamed_1079 = asfloat(0u);
				}
				float fragment_unnamed_1082 = ((-0.0f) - fragment_unnamed_776) + 1.0f;
				float fragment_unnamed_1084 = ((-0.0f) - fragment_unnamed_693) + 1.0f;
				float fragment_unnamed_1085 = fragment_unnamed_1084 * fragment_unnamed_773;
				float fragment_unnamed_1086 = fragment_unnamed_1084 * fragment_unnamed_774;
				float fragment_unnamed_1087 = fragment_unnamed_1084 * fragment_unnamed_775;
				float fragment_unnamed_1092 = mad(fragment_unnamed_693, fragment_unnamed_773 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1094 = mad(fragment_unnamed_693, fragment_unnamed_774 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1095 = mad(fragment_unnamed_693, fragment_unnamed_775 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1112 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(max(dot(float3(fragment_unnamed_778, fragment_unnamed_777, fragment_unnamed_772), float3(fragment_unnamed_233, fragment_unnamed_234, fragment_unnamed_235)), 9.9999997473787516355514526367188e-05f)), 0.984375f, 0.0078125f), mad(fragment_unnamed_1082, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_1122 = clamp((max(fragment_unnamed_1095, max(fragment_unnamed_1094, fragment_unnamed_1092)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_1146 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_1151 = max(abs(fragment_unnamed_772), 0.0009765625f);
				float fragment_unnamed_1155 = (fragment_unnamed_772 >= 0.0f) ? fragment_unnamed_1151 : ((-0.0f) - fragment_unnamed_1151);
				float fragment_unnamed_1164 = 1.0f / max(dot(float3(abs(fragment_unnamed_778), abs(fragment_unnamed_777), abs(fragment_unnamed_1155)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_1169 = clamp((-0.0f) - (fragment_unnamed_1164 * fragment_unnamed_1155), 0.0f, 1.0f);
				float fragment_unnamed_1172 = (-0.0f) - fragment_unnamed_1169;
				uint fragment_unnamed_1184 = uint(clamp(mad(mad(fragment_unnamed_778, fragment_unnamed_1164, ((fragment_unnamed_1164 * fragment_unnamed_778) >= 0.0f) ? fragment_unnamed_1169 : fragment_unnamed_1172), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_1185 = uint(clamp(mad(mad(fragment_unnamed_777, fragment_unnamed_1164, ((fragment_unnamed_1164 * fragment_unnamed_777) >= 0.0f) ? fragment_unnamed_1169 : fragment_unnamed_1172), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_1184 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_1185 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_1185 >> 8u) * 16u) + (fragment_unnamed_1184 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_1092)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_1094)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_1095)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_1236 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_1237 = fragment_unnamed_1236 * (fragment_unnamed_1146 * ((fragment_unnamed_1112 * mad(fragment_unnamed_1122, mad((-0.0f) - fragment_unnamed_773, fragment_unnamed_1084, fragment_unnamed_1092), fragment_unnamed_1085)) * fragment_unnamed_1079));
				float fragment_unnamed_1238 = fragment_unnamed_1236 * (fragment_unnamed_1146 * ((fragment_unnamed_1112 * mad(fragment_unnamed_1122, mad((-0.0f) - fragment_unnamed_774, fragment_unnamed_1084, fragment_unnamed_1094), fragment_unnamed_1086)) * fragment_unnamed_1077));
				float fragment_unnamed_1239 = fragment_unnamed_1236 * (fragment_unnamed_1146 * ((fragment_unnamed_1112 * mad(fragment_unnamed_1122, mad((-0.0f) - fragment_unnamed_775, fragment_unnamed_1084, fragment_unnamed_1095), fragment_unnamed_1087)) * fragment_unnamed_1075));
				bool fragment_unnamed_1248 = (((fragment_unnamed_1239 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_1238 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_1237 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_1248 ? 2048.0f : fragment_unnamed_1237;
				fragment_output_3.y = fragment_unnamed_1248 ? 1.0f : fragment_unnamed_1238;
				fragment_output_3.z = fragment_unnamed_1248 ? 1024.0f : fragment_unnamed_1239;
				fragment_output_0.x = fragment_unnamed_1085;
				fragment_output_0.y = fragment_unnamed_1086;
				fragment_output_0.z = fragment_unnamed_1087;
				fragment_output_0.w = 1.0f;
				fragment_output_1.w = fragment_unnamed_1082;
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

				fragment_uniform_buffer_2[0] = float4(_ArmoryStep, fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_2[0] = float4(fragment_uniform_buffer_2[0][0], _PermsMapOffset[0], _PermsMapOffset[1], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_2[0] = float4(fragment_uniform_buffer_2[0][0], fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], _AdminStep);

				fragment_uniform_buffer_2[2] = float4(_Tint[0], _Tint[1], _Tint[2], _Tint[3]);

				fragment_uniform_buffer_2[5] = float4(_HoloIntensity, fragment_uniform_buffer_2[5][1], fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], _HoloPower, fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], fragment_uniform_buffer_2[5][1], _HoloMask, fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], fragment_uniform_buffer_2[5][1], fragment_uniform_buffer_2[5][2], _HoloFade);

				fragment_uniform_buffer_2[7] = float4(_ContainmentStep, fragment_uniform_buffer_2[7][1], fragment_uniform_buffer_2[7][2], fragment_uniform_buffer_2[7][3]);

				fragment_uniform_buffer_2[9] = float4(_PermsMapTilling[0], _PermsMapTilling[1], fragment_uniform_buffer_2[9][2], fragment_uniform_buffer_2[9][3]);

				fragment_uniform_buffer_2[10] = float4(_PermsColor[0], _PermsColor[1], _PermsColor[2], _PermsColor[3]);

				fragment_uniform_buffer_2[11] = float4(_PermsRotation, fragment_uniform_buffer_2[11][1], fragment_uniform_buffer_2[11][2], fragment_uniform_buffer_2[11][3]);

				fragment_uniform_buffer_2[11] = float4(fragment_uniform_buffer_2[11][0], _DistanceTintRemapIn[0], _DistanceTintRemapIn[1], fragment_uniform_buffer_2[11][3]);

				fragment_uniform_buffer_2[11] = float4(fragment_uniform_buffer_2[11][0], fragment_uniform_buffer_2[11][1], fragment_uniform_buffer_2[11][2], _IgnoreDistanceTint);

				fragment_uniform_buffer_2[12] = float4(_DistanceTintSaturationRemap[0], _DistanceTintSaturationRemap[1], fragment_uniform_buffer_2[12][2], fragment_uniform_buffer_2[12][3]);

				fragment_uniform_buffer_2[12] = float4(fragment_uniform_buffer_2[12][0], fragment_uniform_buffer_2[12][1], _DistanceTintSaturation, fragment_uniform_buffer_2[12][3]);

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

			#endif // defined(DECALS_3RT) && !defined(_DISABLE_DECALS)


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
			Tags { "DisableBatching" = "False" "LIGHTMODE" = "Forward" "QUEUE" = "Geometry+225" "RenderPipeline" = "HDRenderPipeline" "RenderType" = "HDLitShader" "ShaderGraphShader" = "true" "ShaderGraphTargetId" = "HDLitSubTarget" }
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
			GpuProgramID 641340

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
			float _ArmoryStep;
			float2 _PermsMapOffset;
			float _AdminStep;
			float4 _Tint;
			float _HoloIntensity;
			float _HoloPower;
			float _HoloMask;
			float _HoloFade;
			float _ContainmentStep;
			float2 _PermsMapTilling;
			float4 _PermsColor;
			float _PermsRotation;
			float2 _DistanceTintRemapIn;
			float _IgnoreDistanceTint;
			float2 _DistanceTintSaturationRemap;
			float _DistanceTintSaturation;
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
			static float4 fragment_uniform_buffer_3[21];
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
			Texture2D<float4> _Albedo;
			Texture2D<float4> _Normal;
			Texture2D<float4> _Mask;
			Texture2D<float4> _HoloGradient;
			Texture2D<float4> _PermsMask;
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
			SamplerState sampler_Albedo;
			SamplerState sampler_Normal;
			SamplerState sampler_Mask;
			SamplerState sampler_HoloGradient;

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
				float fragment_unnamed_241 = fragment_unnamed_179 * fragment_input_1.x;
				float fragment_unnamed_242 = fragment_unnamed_179 * fragment_input_1.y;
				float fragment_unnamed_243 = fragment_unnamed_179 * fragment_input_1.z;
				float fragment_unnamed_244 = fragment_unnamed_179 * (fragment_unnamed_197 * mad(fragment_input_6.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_6.z)));
				float fragment_unnamed_245 = fragment_unnamed_179 * (fragment_unnamed_197 * mad(fragment_input_6.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_6.x)));
				float fragment_unnamed_246 = fragment_unnamed_179 * (fragment_unnamed_197 * mad(fragment_input_6.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_6.y)));
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
				bool fragment_unnamed_300 = fragment_uniform_buffer_0[15u].w == 0.0f;
				uint4 fragment_unnamed_321 = asuint(fragment_uniform_buffer_0[0u]);
				uint fragment_unnamed_322 = fragment_unnamed_321.z;
				uint4 fragment_unnamed_326 = asuint(fragment_uniform_buffer_0[1u]);
				uint fragment_unnamed_327 = fragment_unnamed_326.z;
				uint4 fragment_unnamed_331 = asuint(fragment_uniform_buffer_0[2u]);
				uint fragment_unnamed_332 = fragment_unnamed_331.z;
				float fragment_unnamed_338 = asfloat(fragment_unnamed_300 ? asuint(((-0.0f) - fragment_input_5.x) + fragment_uniform_buffer_0[11u].x) : fragment_unnamed_322);
				float fragment_unnamed_340 = asfloat(fragment_unnamed_300 ? asuint(((-0.0f) - fragment_input_5.y) + fragment_uniform_buffer_0[11u].y) : fragment_unnamed_327);
				float fragment_unnamed_342 = asfloat(fragment_unnamed_300 ? asuint(((-0.0f) - fragment_input_5.z) + fragment_uniform_buffer_0[11u].z) : fragment_unnamed_332);
				float fragment_unnamed_346 = rsqrt(dot(float3(fragment_unnamed_338, fragment_unnamed_340, fragment_unnamed_342), float3(fragment_unnamed_338, fragment_unnamed_340, fragment_unnamed_342)));
				float fragment_unnamed_347 = fragment_unnamed_346 * fragment_unnamed_338;
				float fragment_unnamed_348 = fragment_unnamed_346 * fragment_unnamed_340;
				float fragment_unnamed_349 = fragment_unnamed_346 * fragment_unnamed_342;
				float fragment_unnamed_353 = rsqrt(dot(float3(fragment_unnamed_253, fragment_unnamed_254, fragment_unnamed_255), float3(fragment_unnamed_253, fragment_unnamed_254, fragment_unnamed_255)));
				float fragment_unnamed_354 = fragment_unnamed_353 * fragment_unnamed_255;
				float fragment_unnamed_355 = fragment_unnamed_353 * fragment_unnamed_253;
				float fragment_unnamed_356 = fragment_unnamed_353 * fragment_unnamed_254;
				float fragment_unnamed_363 = mad(fragment_unnamed_245, fragment_unnamed_354, (-0.0f) - (fragment_unnamed_246 * fragment_unnamed_356));
				float fragment_unnamed_364 = mad(fragment_unnamed_246, fragment_unnamed_355, (-0.0f) - (fragment_unnamed_244 * fragment_unnamed_354));
				float fragment_unnamed_365 = mad(fragment_unnamed_244, fragment_unnamed_356, (-0.0f) - (fragment_unnamed_245 * fragment_unnamed_355));
				float fragment_unnamed_398 = asfloat((dot(float3(fragment_unnamed_241, fragment_unnamed_242, fragment_unnamed_243), float3(fragment_unnamed_363, fragment_unnamed_364, fragment_unnamed_365)) < 0.0f) ? 3212836864u : 1065353216u);
				float fragment_unnamed_399 = dot(float3(fragment_unnamed_363, fragment_unnamed_364, fragment_unnamed_365), float3(fragment_unnamed_347, fragment_unnamed_348, fragment_unnamed_349)) * fragment_unnamed_398;
				float fragment_unnamed_400 = dot(float3(mad(fragment_unnamed_356, fragment_unnamed_243, (-0.0f) - (fragment_unnamed_242 * fragment_unnamed_354)), mad(fragment_unnamed_354, fragment_unnamed_241, (-0.0f) - (fragment_unnamed_243 * fragment_unnamed_355)), mad(fragment_unnamed_355, fragment_unnamed_242, (-0.0f) - (fragment_unnamed_241 * fragment_unnamed_356))), float3(fragment_unnamed_347, fragment_unnamed_348, fragment_unnamed_349)) * fragment_unnamed_398;
				float fragment_unnamed_401 = dot(float3(mad(fragment_unnamed_242, fragment_unnamed_246, (-0.0f) - (fragment_unnamed_245 * fragment_unnamed_243)), mad(fragment_unnamed_243, fragment_unnamed_244, (-0.0f) - (fragment_unnamed_246 * fragment_unnamed_241)), mad(fragment_unnamed_241, fragment_unnamed_245, (-0.0f) - (fragment_unnamed_244 * fragment_unnamed_242))), float3(fragment_unnamed_347, fragment_unnamed_348, fragment_unnamed_349)) * fragment_unnamed_398;
				float fragment_unnamed_406 = rsqrt(max(dot(float3(fragment_unnamed_399, fragment_unnamed_400, fragment_unnamed_401), float3(fragment_unnamed_399, fragment_unnamed_400, fragment_unnamed_401)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_407 = fragment_unnamed_406 * fragment_unnamed_399;
				float fragment_unnamed_433 = mad(fragment_uniform_buffer_0[22u].w, fragment_input_5.z, mad(fragment_uniform_buffer_0[20u].w, fragment_input_5.x, fragment_input_5.y * fragment_uniform_buffer_0[21u].w)) + fragment_uniform_buffer_0[23u].w;
				float4 fragment_unnamed_444 = _Albedo.SampleBias(sampler_Albedo, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_447 = fragment_unnamed_444.x;
				float fragment_unnamed_448 = fragment_unnamed_444.y;
				float fragment_unnamed_449 = fragment_unnamed_444.z;
				float fragment_unnamed_455 = asfloat((0.0f != fragment_uniform_buffer_3[11u].w) ? 0u : 1065353216u);
				float fragment_unnamed_482 = min(max(((mad(fragment_unnamed_433, fragment_unnamed_455, (-0.0f) - fragment_uniform_buffer_3[12u].x) * (fragment_uniform_buffer_3[12u].z + (-1.0f))) / (((-0.0f) - fragment_uniform_buffer_3[12u].x) + fragment_uniform_buffer_3[12u].y)) + 1.0f, 1.0f), fragment_uniform_buffer_3[12u].z);
				float fragment_unnamed_488 = dot(float3(fragment_uniform_buffer_3[2u].xyz), float3(0.21267290413379669189453125f, 0.715152204036712646484375f, 0.072175003588199615478515625f));
				float fragment_unnamed_494 = (-0.0f) - fragment_unnamed_488;
				float fragment_unnamed_525 = clamp(mad(fragment_unnamed_433, fragment_unnamed_455, (-0.0f) - fragment_uniform_buffer_3[11u].y) / (((-0.0f) - fragment_uniform_buffer_3[11u].y) + fragment_uniform_buffer_3[11u].z), 0.0f, 1.0f);
				float4 fragment_unnamed_534 = _Mask.SampleBias(sampler_Mask, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_536 = fragment_unnamed_534.x;
				float fragment_unnamed_537 = fragment_unnamed_534.y;
				float fragment_unnamed_539 = fragment_unnamed_534.w;
				float fragment_unnamed_541 = clamp(mad(clamp((fragment_unnamed_447 + (-0.23000000417232513427734375f)) * 3.8461539745330810546875f, 0.0f, 1.0f), fragment_unnamed_525, fragment_unnamed_534.z), 0.0f, 1.0f);
				float fragment_unnamed_556 = exp2(log2(fragment_unnamed_537) * fragment_uniform_buffer_3[5u].y);
				float4 fragment_unnamed_565 = _HoloGradient.SampleBias(sampler_HoloGradient, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_567 = fragment_unnamed_565.y;
				float fragment_unnamed_568 = fragment_unnamed_565.z;
				float fragment_unnamed_569 = fragment_unnamed_565.x;
				float fragment_unnamed_581 = asfloat(((fragment_unnamed_567 >= fragment_unnamed_568) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_591 = mad(fragment_unnamed_581, fragment_unnamed_567 + ((-0.0f) - fragment_unnamed_568), fragment_unnamed_568);
				float fragment_unnamed_592 = mad(fragment_unnamed_581, fragment_unnamed_568 + ((-0.0f) - fragment_unnamed_567), fragment_unnamed_567);
				float fragment_unnamed_594 = mad(fragment_unnamed_581, asfloat(3212836864u), asfloat(1059760811u));
				float fragment_unnamed_598 = asfloat(((fragment_unnamed_569 >= fragment_unnamed_591) ? 4294967295u : 0u) & 1065353216u);
				float fragment_unnamed_607 = mad(fragment_unnamed_598, ((-0.0f) - fragment_unnamed_591) + fragment_unnamed_569, fragment_unnamed_591);
				float fragment_unnamed_608 = mad(fragment_unnamed_598, ((-0.0f) - fragment_unnamed_592) + fragment_unnamed_592, fragment_unnamed_592);
				float fragment_unnamed_610 = mad(fragment_unnamed_598, ((-0.0f) - fragment_unnamed_569) + fragment_unnamed_591, fragment_unnamed_569);
				float fragment_unnamed_613 = ((-0.0f) - min(fragment_unnamed_608, fragment_unnamed_610)) + fragment_unnamed_607;
				float fragment_unnamed_615 = fragment_unnamed_607 + 1.0000000133514319600180897396058e-10f;
				float fragment_unnamed_620 = asfloat((fragment_unnamed_613 == 0.0f) ? asuint(fragment_unnamed_607) : asuint(fragment_unnamed_615));
				float fragment_unnamed_627 = fragment_unnamed_613 / fragment_unnamed_615;
				float fragment_unnamed_629 = mad(fragment_unnamed_407 * exp2(log2(fragment_uniform_buffer_3[5u].x) * fragment_unnamed_537), fragment_unnamed_406 * fragment_unnamed_400, abs(((((-0.0f) - fragment_unnamed_608) + fragment_unnamed_610) / mad(fragment_unnamed_613, 6.0f, 1.0000000133514319600180897396058e-10f)) + mad(fragment_unnamed_598, ((-0.0f) - fragment_unnamed_594) + mad(fragment_unnamed_581, asfloat(1065353216u), asfloat(3212836864u)), fragment_unnamed_594)));
				float fragment_unnamed_639 = asfloat((fragment_unnamed_629 < 0.0f) ? asuint(fragment_unnamed_629 + 1.0f) : ((1.0f < fragment_unnamed_629) ? asuint(fragment_unnamed_629 + (-1.0f)) : asuint(fragment_unnamed_629)));
				float fragment_unnamed_683 = ((((-0.0f) - abs(fragment_unnamed_407)) + 1.0f) * fragment_uniform_buffer_3[5u].w) * fragment_uniform_buffer_3[5u].z;
				float fragment_unnamed_684 = mad(fragment_unnamed_683, fragment_unnamed_556 * (fragment_unnamed_620 * mad(fragment_unnamed_627, clamp(abs(mad(frac(fragment_unnamed_639 + 1.0f), 6.0f, -3.0f)) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)), mad(fragment_unnamed_541, mad(fragment_unnamed_447, mad(fragment_unnamed_482, fragment_unnamed_494 + fragment_uniform_buffer_3[2u].x, fragment_unnamed_488), (-0.0f) - fragment_unnamed_447), fragment_unnamed_447));
				float fragment_unnamed_685 = mad(fragment_unnamed_683, fragment_unnamed_556 * (fragment_unnamed_620 * mad(fragment_unnamed_627, clamp(abs(mad(frac(fragment_unnamed_639 + 0.666666686534881591796875f), 6.0f, -3.0f)) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)), mad(fragment_unnamed_541, mad(fragment_unnamed_448, mad(fragment_unnamed_482, fragment_unnamed_494 + fragment_uniform_buffer_3[2u].y, fragment_unnamed_488), (-0.0f) - fragment_unnamed_448), fragment_unnamed_448));
				float fragment_unnamed_686 = mad(fragment_unnamed_683, fragment_unnamed_556 * (fragment_unnamed_620 * mad(fragment_unnamed_627, clamp(abs(mad(frac(fragment_unnamed_639 + 0.3333333432674407958984375f), 6.0f, -3.0f)) + (-1.0f), 0.0f, 1.0f) + (-1.0f), 1.0f)), mad(fragment_unnamed_541, mad(fragment_unnamed_449, mad(fragment_unnamed_482, fragment_unnamed_494 + fragment_uniform_buffer_3[2u].z, fragment_unnamed_488), (-0.0f) - fragment_unnamed_449), fragment_unnamed_449));
				float fragment_unnamed_690 = fragment_uniform_buffer_3[11u].x * 0.01745329238474369049072265625f;
				float fragment_unnamed_696 = fragment_input_2.x + (-0.5f);
				float fragment_unnamed_698 = fragment_input_2.y + (-0.5f);
				float fragment_unnamed_699 = sin(fragment_unnamed_690);
				float fragment_unnamed_705 = mad(mad(cos(fragment_unnamed_690), 0.5f, 0.5f), 2.0f, -1.0f);
				float4 fragment_unnamed_731 = _PermsMask.SampleBias(S4, float2(mad(dot(float2(fragment_unnamed_696, fragment_unnamed_698), float2(fragment_unnamed_705, mad(mad(fragment_unnamed_699, 0.5f, 0.5f), 2.0f, -1.0f))) + 0.5f, fragment_uniform_buffer_3[9u].x, fragment_uniform_buffer_3[0u].y), mad(dot(float2(fragment_unnamed_698, fragment_unnamed_696), float2(fragment_unnamed_705, mad(mad(fragment_unnamed_699, -0.5f, 0.5f), 2.0f, -1.0f))) + 0.5f, fragment_uniform_buffer_3[9u].y, fragment_uniform_buffer_3[0u].z)), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_760 = fragment_unnamed_731.w * mad((-0.0f) - asfloat(((fragment_uniform_buffer_3[7u].x >= fragment_unnamed_731.x) ? 4294967295u : 0u) & 1065353216u), asfloat(((fragment_uniform_buffer_3[0u].w >= fragment_unnamed_731.z) ? 4294967295u : 0u) & 1065353216u) * asfloat(((fragment_uniform_buffer_3[0u].x >= fragment_unnamed_731.y) ? 4294967295u : 0u) & 1065353216u), 1.0f);
				float fragment_unnamed_773 = mad(fragment_unnamed_760, ((-0.0f) - fragment_unnamed_684) + fragment_uniform_buffer_3[10u].x, fragment_unnamed_684);
				float fragment_unnamed_774 = mad(fragment_unnamed_760, ((-0.0f) - fragment_unnamed_685) + fragment_uniform_buffer_3[10u].y, fragment_unnamed_685);
				float fragment_unnamed_775 = mad(fragment_unnamed_760, ((-0.0f) - fragment_unnamed_686) + fragment_uniform_buffer_3[10u].z, fragment_unnamed_686);
				float4 fragment_unnamed_786 = _Normal.SampleBias(sampler_Normal, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_792 = mad(fragment_unnamed_786.x * fragment_unnamed_786.w, 2.0f, -1.0f);
				float fragment_unnamed_793 = mad(fragment_unnamed_786.y, 2.0f, -1.0f);
				float fragment_unnamed_801 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_792, fragment_unnamed_793), float2(fragment_unnamed_792, fragment_unnamed_793)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f);
				float fragment_unnamed_805 = mad(fragment_unnamed_525, ((-0.0f) - fragment_unnamed_536) + 1.0f, fragment_unnamed_536);
				float fragment_unnamed_812 = mad(fragment_unnamed_801, fragment_unnamed_253, mad(fragment_unnamed_792, fragment_unnamed_241, fragment_unnamed_244 * fragment_unnamed_793));
				float fragment_unnamed_813 = mad(fragment_unnamed_801, fragment_unnamed_254, mad(fragment_unnamed_792, fragment_unnamed_242, fragment_unnamed_245 * fragment_unnamed_793));
				float fragment_unnamed_814 = mad(fragment_unnamed_801, fragment_unnamed_255, mad(fragment_unnamed_792, fragment_unnamed_243, fragment_unnamed_246 * fragment_unnamed_793));
				float fragment_unnamed_819 = rsqrt(max(dot(float3(fragment_unnamed_812, fragment_unnamed_813, fragment_unnamed_814), float3(fragment_unnamed_812, fragment_unnamed_813, fragment_unnamed_814)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_820 = fragment_unnamed_812 * fragment_unnamed_819;
				float fragment_unnamed_821 = fragment_unnamed_813 * fragment_unnamed_819;
				float fragment_unnamed_822 = fragment_unnamed_814 * fragment_unnamed_819;
				uint fragment_unnamed_827 = asuint(fragment_uniform_buffer_1[10u]).x & 65535u;
				float fragment_unnamed_1092;
				float fragment_unnamed_1093;
				float fragment_unnamed_1094;
				if (fragment_uniform_buffer_1[22u].x == 0.0f)
				{
					float fragment_unnamed_833 = asfloat(1065353216u);
					float fragment_unnamed_862 = fragment_unnamed_821 * fragment_unnamed_820;
					float fragment_unnamed_863 = fragment_unnamed_822 * fragment_unnamed_821;
					float fragment_unnamed_864 = fragment_unnamed_822 * fragment_unnamed_822;
					float fragment_unnamed_865 = fragment_unnamed_820 * fragment_unnamed_822;
					float fragment_unnamed_897 = mad(fragment_unnamed_820, fragment_unnamed_820, (-0.0f) - (fragment_unnamed_821 * fragment_unnamed_821));
					fragment_unnamed_1092 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822, fragment_unnamed_833)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_897, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_862, fragment_unnamed_863, fragment_unnamed_864, fragment_unnamed_865)));
					fragment_unnamed_1093 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822, fragment_unnamed_833)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_897, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_862, fragment_unnamed_863, fragment_unnamed_864, fragment_unnamed_865)));
					fragment_unnamed_1094 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822, fragment_unnamed_833)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_897, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_862, fragment_unnamed_863, fragment_unnamed_864, fragment_unnamed_865)));
				}
				else
				{
					bool fragment_unnamed_913 = fragment_uniform_buffer_1[22u].y == 0.0f;
					bool fragment_unnamed_914 = fragment_uniform_buffer_1[22u].y == 1.0f;
					float fragment_unnamed_936 = fragment_unnamed_913 ? (fragment_input_5.x + fragment_uniform_buffer_0[48u].x) : fragment_input_5.x;
					float fragment_unnamed_937 = fragment_unnamed_913 ? (fragment_input_5.y + fragment_uniform_buffer_0[48u].y) : fragment_input_5.y;
					float fragment_unnamed_938 = fragment_unnamed_913 ? (fragment_input_5.z + fragment_uniform_buffer_0[48u].z) : fragment_input_5.z;
					float fragment_unnamed_1041 = (asfloat(fragment_unnamed_914 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_938, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_936, fragment_unnamed_937 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_937)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
					float fragment_unnamed_1042 = (asfloat(fragment_unnamed_914 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_938, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_936, fragment_unnamed_937 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_938)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
					float fragment_unnamed_1055 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(((asfloat(fragment_unnamed_914 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_938, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_936, fragment_unnamed_937 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_936)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f, fragment_uniform_buffer_1[22u].z * 0.5f));
					float fragment_unnamed_1082 = asfloat(1065353216u);
					fragment_unnamed_1092 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1055, fragment_unnamed_1041, fragment_unnamed_1042), 0.0f)), float4(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822, fragment_unnamed_1082));
					fragment_unnamed_1093 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1055 + 0.25f, fragment_unnamed_1041 + 0.0f, fragment_unnamed_1042 + 0.0f), 0.0f)), float4(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822, fragment_unnamed_1082));
					fragment_unnamed_1094 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_1055 + 0.5f, fragment_unnamed_1041 + 0.0f, fragment_unnamed_1042 + 0.0f), 0.0f)), float4(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822, fragment_unnamed_1082));
				}
				float fragment_unnamed_1096 = ((-0.0f) - mad(fragment_unnamed_525, (-0.0f) - fragment_unnamed_539, fragment_unnamed_539)) + 1.0f;
				float fragment_unnamed_1098 = ((-0.0f) - fragment_unnamed_805) + 1.0f;
				float fragment_unnamed_1099 = fragment_unnamed_1098 * fragment_unnamed_773;
				float fragment_unnamed_1100 = fragment_unnamed_1098 * fragment_unnamed_774;
				float fragment_unnamed_1101 = fragment_unnamed_1098 * fragment_unnamed_775;
				float fragment_unnamed_1106 = mad(fragment_unnamed_805, fragment_unnamed_773 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1108 = mad(fragment_unnamed_805, fragment_unnamed_774 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1109 = mad(fragment_unnamed_805, fragment_unnamed_775 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_1110 = dot(float3(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822), float3(fragment_unnamed_347, fragment_unnamed_348, fragment_unnamed_349));
				float fragment_unnamed_1113 = max(fragment_unnamed_1110, 9.9999997473787516355514526367188e-05f);
				float4 fragment_unnamed_1121 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_1113), 0.984375f, 0.0078125f), mad(fragment_unnamed_1096, 0.984375f, 0.0078125f)), 0.0f);
				float fragment_unnamed_1123 = fragment_unnamed_1121.x;
				float fragment_unnamed_1124 = fragment_unnamed_1121.y;
				float fragment_unnamed_1126 = fragment_unnamed_1121.z + 0.5f;
				float fragment_unnamed_1138 = clamp((max(fragment_unnamed_1109, max(fragment_unnamed_1108, fragment_unnamed_1106)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				uint4 fragment_unnamed_1157 = asuint(fragment_uniform_buffer_0[120u]);
				uint4 fragment_unnamed_1166 = asuint(fragment_uniform_buffer_0[120u]);
				float fragment_unnamed_1170 = asfloat(((fragment_unnamed_827 & fragment_unnamed_1157.y) != 0u) ? fragment_unnamed_1166.x : 1065353216u);
				float fragment_unnamed_1172 = asfloat(((fragment_unnamed_827 & fragment_unnamed_1157.w) != 0u) ? fragment_unnamed_1166.z : 1065353216u);
				float fragment_unnamed_1191 = asfloat((asuint(fragment_uniform_buffer_0[113u]).y == 1u) ? asuint(clamp(dot(float3(fragment_unnamed_1106, fragment_unnamed_1108, fragment_unnamed_1109), 0.333000004291534423828125f.xxx) * 50.0f, 0.0f, 1.0f)) : 1065353216u);
				float fragment_unnamed_1192 = fragment_unnamed_1096 * fragment_unnamed_1096;
				float fragment_unnamed_1202 = mad(((-0.0f) - fragment_unnamed_1106) + fragment_unnamed_1191, fragment_unnamed_1123, fragment_unnamed_1106 * fragment_unnamed_1124);
				float fragment_unnamed_1203 = mad(((-0.0f) - fragment_unnamed_1108) + fragment_unnamed_1191, fragment_unnamed_1123, fragment_unnamed_1108 * fragment_unnamed_1124);
				float fragment_unnamed_1204 = mad(((-0.0f) - fragment_unnamed_1109) + fragment_unnamed_1191, fragment_unnamed_1123, fragment_unnamed_1109 * fragment_unnamed_1124);
				float fragment_unnamed_1206 = (1.0f / fragment_unnamed_1124) + (-1.0f);
				float fragment_unnamed_1207 = fragment_unnamed_1192 * fragment_unnamed_1192;
				float fragment_unnamed_1211 = sqrt(mad(mad((-0.0f) - fragment_unnamed_1113, fragment_unnamed_1207, fragment_unnamed_1113), fragment_unnamed_1113, fragment_unnamed_1207));
				float fragment_unnamed_1212 = (-0.0f) - fragment_unnamed_347;
				float fragment_unnamed_1213 = (-0.0f) - fragment_unnamed_348;
				float fragment_unnamed_1214 = (-0.0f) - fragment_unnamed_349;
				float fragment_unnamed_1215 = dot(float3(fragment_unnamed_1212, fragment_unnamed_1213, fragment_unnamed_1214), float3(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822));
				float fragment_unnamed_1219 = (-0.0f) - (fragment_unnamed_1215 + fragment_unnamed_1215);
				float fragment_unnamed_1220 = mad(fragment_unnamed_820, fragment_unnamed_1219, fragment_unnamed_1212);
				float fragment_unnamed_1221 = mad(fragment_unnamed_821, fragment_unnamed_1219, fragment_unnamed_1213);
				float fragment_unnamed_1222 = mad(fragment_unnamed_822, fragment_unnamed_1219, fragment_unnamed_1214);
				float fragment_unnamed_1224 = ((-0.0f) - fragment_unnamed_1113) + 1.0f;
				float fragment_unnamed_1226 = mad(fragment_unnamed_1096, 0.984375f, 0.0078125f);
				float fragment_unnamed_1227 = mad(sqrt(fragment_unnamed_1224), 0.984375f, 0.0078125f);
				float4 fragment_unnamed_1232 = _LtcData.SampleLevel(S0, float3(fragment_unnamed_1226, fragment_unnamed_1227, asfloat(1065353216u)), 0.0f);
				float fragment_unnamed_1234 = fragment_unnamed_1232.x;
				float fragment_unnamed_1235 = fragment_unnamed_1232.y;
				float fragment_unnamed_1236 = fragment_unnamed_1232.z;
				float fragment_unnamed_1237 = fragment_unnamed_1232.w;
				float4 fragment_unnamed_1238 = _LtcData.SampleLevel(S0, float3(fragment_unnamed_1226, fragment_unnamed_1227, asfloat(0u)), 0.0f);
				float fragment_unnamed_1240 = fragment_unnamed_1238.x;
				float fragment_unnamed_1241 = fragment_unnamed_1238.y;
				float fragment_unnamed_1242 = fragment_unnamed_1238.z;
				float fragment_unnamed_1243 = fragment_unnamed_1238.w;
				bool fragment_unnamed_1247 = 5.9604644775390625e-08f >= abs(((-0.0f) - fragment_unnamed_1110) + 1.0f);
				bool fragment_unnamed_1249 = fragment_unnamed_822 >= 0.0f;
				float fragment_unnamed_1251 = asfloat(fragment_unnamed_1249 ? 1065353216u : 3212836864u);
				float fragment_unnamed_1255 = 1.0f / mad(fragment_unnamed_814, fragment_unnamed_819, fragment_unnamed_1251);
				float fragment_unnamed_1256 = fragment_unnamed_821 * fragment_unnamed_1255;
				float fragment_unnamed_1257 = fragment_unnamed_820 * fragment_unnamed_1256;
				float fragment_unnamed_1258 = fragment_unnamed_820 * fragment_unnamed_1251;
				float fragment_unnamed_1266 = mad((-0.0f) - fragment_unnamed_820, fragment_unnamed_1110, fragment_unnamed_347);
				float fragment_unnamed_1267 = mad((-0.0f) - fragment_unnamed_821, fragment_unnamed_1110, fragment_unnamed_348);
				float fragment_unnamed_1268 = mad((-0.0f) - fragment_unnamed_822, fragment_unnamed_1110, fragment_unnamed_349);
				float fragment_unnamed_1272 = rsqrt(dot(float3(fragment_unnamed_1266, fragment_unnamed_1267, fragment_unnamed_1268), float3(fragment_unnamed_1266, fragment_unnamed_1267, fragment_unnamed_1268)));
				float fragment_unnamed_1273 = fragment_unnamed_1272 * fragment_unnamed_1266;
				float fragment_unnamed_1274 = fragment_unnamed_1272 * fragment_unnamed_1267;
				float fragment_unnamed_1275 = fragment_unnamed_1272 * fragment_unnamed_1268;
				float fragment_unnamed_1294 = asfloat(fragment_unnamed_1247 ? asuint(fragment_unnamed_1257) : asuint(mad(fragment_unnamed_821, fragment_unnamed_1275, (-0.0f) - (fragment_unnamed_822 * fragment_unnamed_1274))));
				float fragment_unnamed_1296 = asfloat(fragment_unnamed_1247 ? asuint(mad(fragment_unnamed_821, fragment_unnamed_1256, asfloat(fragment_unnamed_1249 ? 3212836864u : 1065353216u))) : asuint(mad(fragment_unnamed_822, fragment_unnamed_1273, (-0.0f) - (fragment_unnamed_820 * fragment_unnamed_1275))));
				float fragment_unnamed_1304 = asfloat(fragment_unnamed_1247 ? asuint(mad(fragment_unnamed_820 * fragment_unnamed_1258, fragment_unnamed_1255, -1.0f)) : asuint(fragment_unnamed_1273));
				float fragment_unnamed_1463;
				float fragment_unnamed_1465;
				float fragment_unnamed_1467;
				if (int(asuint(fragment_uniform_buffer_0[116u]).z) >= int(0u))
				{
					uint fragment_unnamed_1319 = (asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 4u;
					uint3 fragment_unnamed_1329 = uint3(T6.Load(fragment_unnamed_1319).x, T6.Load(fragment_unnamed_1319 + 1u).x, T6.Load(fragment_unnamed_1319 + 2u).x);
					float fragment_unnamed_1331 = asfloat(fragment_unnamed_1329.x);
					float fragment_unnamed_1333 = asfloat(fragment_unnamed_1329.y);
					float fragment_unnamed_1335 = asfloat(fragment_unnamed_1329.z);
					float fragment_unnamed_1464;
					float fragment_unnamed_1466;
					float fragment_unnamed_1468;
					if (((((0.0f < asfloat(T6.Load((asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 27u).x)) ? 4294967295u : 0u) & ((0.0f < asfloat(T6.Load((asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 38u).x)) ? 4294967295u : 0u)) & ((0.0f < dot(float3(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822), float3((-0.0f) - fragment_unnamed_1331, (-0.0f) - fragment_unnamed_1333, (-0.0f) - fragment_unnamed_1335))) ? 4294967295u : 0u)) != 0u)
					{
						uint4 fragment_unnamed_1384 = uint4(T33.Load(0u).x, T33.Load(0u + 1u).x, T33.Load(0u + 2u).x, T33.Load(0u + 3u).x);
						float fragment_unnamed_1386 = asfloat(fragment_unnamed_1384.x);
						float fragment_unnamed_1388 = asfloat(fragment_unnamed_1384.y);
						float fragment_unnamed_1390 = asfloat(fragment_unnamed_1384.z);
						float fragment_unnamed_1392 = asfloat(fragment_unnamed_1384.w);
						uint4 fragment_unnamed_1404 = uint4(T33.Load(4u).x, T33.Load(4u + 1u).x, T33.Load(4u + 2u).x, T33.Load(4u + 3u).x);
						float fragment_unnamed_1406 = asfloat(fragment_unnamed_1404.x);
						float fragment_unnamed_1408 = asfloat(fragment_unnamed_1404.y);
						float fragment_unnamed_1410 = asfloat(fragment_unnamed_1404.z);
						float fragment_unnamed_1412 = asfloat(fragment_unnamed_1404.w);
						uint4 fragment_unnamed_1425 = uint4(T33.Load(8u).x, T33.Load(8u + 1u).x, T33.Load(8u + 2u).x, T33.Load(8u + 3u).x);
						float fragment_unnamed_1427 = asfloat(fragment_unnamed_1425.x);
						float fragment_unnamed_1429 = asfloat(fragment_unnamed_1425.y);
						float fragment_unnamed_1431 = asfloat(fragment_unnamed_1425.z);
						float fragment_unnamed_1433 = asfloat(fragment_unnamed_1425.w);
						uint4 fragment_unnamed_1445 = uint4(T33.Load(12u).x, T33.Load(12u + 1u).x, T33.Load(12u + 2u).x, T33.Load(12u + 3u).x);
						float fragment_unnamed_1447 = asfloat(fragment_unnamed_1445.x);
						float fragment_unnamed_1449 = asfloat(fragment_unnamed_1445.y);
						float fragment_unnamed_1451 = asfloat(fragment_unnamed_1445.z);
						float fragment_unnamed_1453 = asfloat(fragment_unnamed_1445.w);
						float fragment_unnamed_1454 = asfloat(0u);
						float fragment_unnamed_1455 = asfloat(0u);
						float fragment_unnamed_1456 = asfloat(0u);
						float fragment_unnamed_1457 = asfloat(4294967295u);
						float fragment_unnamed_1458 = asfloat(0u);
						float fragment_unnamed_1459 = asfloat(0u);
						float fragment_unnamed_1590;
						float fragment_unnamed_1594;
						float fragment_unnamed_1596;
						float fragment_unnamed_1598;
						float fragment_unnamed_1622;
						float fragment_unnamed_1623;
						float fragment_unnamed_1624;
						float fragment_unnamed_1626;
						float fragment_unnamed_1628;
						float fragment_unnamed_1587 = fragment_unnamed_1457;
						float fragment_unnamed_1589 = fragment_unnamed_1458;
						float fragment_unnamed_1591 = fragment_unnamed_1459;
						float fragment_unnamed_1593 = fragment_unnamed_1454;
						float fragment_unnamed_1595 = fragment_unnamed_1455;
						float fragment_unnamed_1597 = fragment_unnamed_1456;
						for (;;)
						{
							if (asuint(fragment_unnamed_1591) >= asuint(fragment_uniform_buffer_0[116u]).y)
							{
								fragment_unnamed_1622 = fragment_unnamed_1587;
								fragment_unnamed_1623 = fragment_unnamed_1589;
								fragment_unnamed_1624 = fragment_unnamed_1593;
								fragment_unnamed_1626 = fragment_unnamed_1595;
								fragment_unnamed_1628 = fragment_unnamed_1597;
								break;
							}
							else
							{
								uint fragment_unnamed_1635 = (asuint(fragment_unnamed_1591) * 4u) + 0u;
								uint fragment_unnamed_1645 = (asuint(fragment_unnamed_1591) * 4u) + 1u;
								uint fragment_unnamed_1654 = (asuint(fragment_unnamed_1591) * 4u) + 2u;
								uint fragment_unnamed_1663 = (asuint(fragment_unnamed_1591) * 4u) + 3u;
								fragment_unnamed_1594 = ((-0.0f) - mad(fragment_unnamed_108[fragment_unnamed_1663], fragment_unnamed_1447, mad(fragment_unnamed_108[fragment_unnamed_1654], fragment_unnamed_1427, mad(fragment_unnamed_108[fragment_unnamed_1645], fragment_unnamed_1406, fragment_unnamed_1386 * fragment_unnamed_108[fragment_unnamed_1635])))) + fragment_input_5.x;
								fragment_unnamed_1596 = ((-0.0f) - mad(fragment_unnamed_108[fragment_unnamed_1663], fragment_unnamed_1449, mad(fragment_unnamed_108[fragment_unnamed_1654], fragment_unnamed_1429, mad(fragment_unnamed_108[fragment_unnamed_1645], fragment_unnamed_1408, fragment_unnamed_1388 * fragment_unnamed_108[fragment_unnamed_1635])))) + fragment_input_5.y;
								fragment_unnamed_1598 = ((-0.0f) - mad(fragment_unnamed_108[fragment_unnamed_1663], fragment_unnamed_1451, mad(fragment_unnamed_108[fragment_unnamed_1654], fragment_unnamed_1431, mad(fragment_unnamed_108[fragment_unnamed_1645], fragment_unnamed_1410, fragment_unnamed_1390 * fragment_unnamed_108[fragment_unnamed_1635])))) + fragment_input_5.z;
								float fragment_unnamed_1679 = dot(float3(fragment_unnamed_1594, fragment_unnamed_1596, fragment_unnamed_1598), float3(fragment_unnamed_1594, fragment_unnamed_1596, fragment_unnamed_1598));
								fragment_unnamed_1590 = fragment_unnamed_1679 / mad(fragment_unnamed_108[fragment_unnamed_1663], fragment_unnamed_1453, mad(fragment_unnamed_108[fragment_unnamed_1654], fragment_unnamed_1433, mad(fragment_unnamed_108[fragment_unnamed_1645], fragment_unnamed_1412, fragment_unnamed_1392 * fragment_unnamed_108[fragment_unnamed_1635])));
								if (!((((1.0f >= fragment_unnamed_1590) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1590) ? 4294967295u : 0u)) != 0u))
								{
									fragment_unnamed_1587 = asfloat(4294967295u);
									fragment_unnamed_1589 = fragment_unnamed_1590;
									fragment_unnamed_1591 = asfloat(asuint(fragment_unnamed_1591) + 1u);
									fragment_unnamed_1593 = fragment_unnamed_1594;
									fragment_unnamed_1595 = fragment_unnamed_1596;
									fragment_unnamed_1597 = fragment_unnamed_1598;
									continue;
								}
								float fragment_unnamed_1938 = sqrt(fragment_unnamed_1679);
								fragment_unnamed_1622 = fragment_unnamed_1591;
								fragment_unnamed_1623 = fragment_unnamed_1590;
								fragment_unnamed_1624 = fragment_unnamed_1594 / fragment_unnamed_1938;
								fragment_unnamed_1626 = fragment_unnamed_1596 / fragment_unnamed_1938;
								fragment_unnamed_1628 = fragment_unnamed_1598 / fragment_unnamed_1938;
								break;
							}
						}
						float fragment_unnamed_1631 = float(int(asuint(fragment_unnamed_1622)));
						float fragment_unnamed_1605;
						if (fragment_unnamed_1631 >= 0.0f)
						{
							uint4 fragment_unnamed_1778 = uint4(T33.Load(19u).x, T33.Load(19u + 1u).x, T33.Load(19u + 2u).x, T33.Load(19u + 3u).x);
							uint4 fragment_unnamed_1793 = T6.Load((asuint(fragment_uniform_buffer_0[116u]).z * 44u) + 15u);
							uint fragment_unnamed_1794 = fragment_unnamed_1793.x;
							float fragment_unnamed_1805 = asfloat((dot(float3(fragment_unnamed_253, fragment_unnamed_254, fragment_unnamed_255), float3((-0.0f) - fragment_unnamed_1331, (-0.0f) - fragment_unnamed_1333, (-0.0f) - fragment_unnamed_1335)) >= 0.0f) ? 1065353216u : 3212836864u);
							uint fragment_unnamed_1813 = asuint(fragment_unnamed_1622);
							float fragment_unnamed_1830 = dot(float4(asfloat(fragment_unnamed_1778.y), asfloat(fragment_unnamed_1778.z), asfloat(fragment_unnamed_1778.w), asfloat(T33.Load(23u).x)), float4(fragment_unnamed_108[(fragment_unnamed_1813 * 4u) + 0u], fragment_unnamed_108[(fragment_unnamed_1813 * 4u) + 1u], fragment_unnamed_108[(fragment_unnamed_1813 * 4u) + 2u], fragment_unnamed_108[(fragment_unnamed_1813 * 4u) + 3u]));
							float fragment_unnamed_1842 = asfloat((0.0f >= fragment_unnamed_1830) ? 0u : asuint(clamp((fragment_unnamed_1623 + ((-0.0f) - (((-0.0f) - fragment_unnamed_1830) + 1.0f))) / fragment_unnamed_1830, 0.0f, 1.0f)));
							float fragment_unnamed_1849 = clamp((fragment_unnamed_1830 + (-1.0f)) * (-3.3333332538604736328125f), 0.0f, 1.0f);
							float fragment_unnamed_1861 = mad(clamp(mad((fragment_unnamed_1849 * fragment_unnamed_1849) * mad(fragment_unnamed_1849, -2.0f, 3.0f), 512.0f, 8.0f) * dot(float3(fragment_unnamed_338, fragment_unnamed_340, fragment_unnamed_342), float3(fragment_unnamed_1624, fragment_unnamed_1626, fragment_unnamed_1628)), 0.0f, 1.0f), (-0.0f) - fragment_unnamed_1842, fragment_unnamed_1842);
							float fragment_unnamed_1867 = asfloat(T32.Load((fragment_unnamed_1794 * 60u) + 19u).x);
							uint fragment_unnamed_1869 = (fragment_unnamed_1794 * 60u) + 24u;
							uint2 fragment_unnamed_1875 = uint2(T32.Load(fragment_unnamed_1869).x, T32.Load(fragment_unnamed_1869 + 1u).x);
							uint fragment_unnamed_1881 = asuint(fragment_unnamed_1622) + fragment_unnamed_1794;
							uint fragment_unnamed_1883 = (fragment_unnamed_1881 * 60u) + 16u;
							uint3 fragment_unnamed_1892 = uint3(T32.Load(fragment_unnamed_1883).x, T32.Load(fragment_unnamed_1883 + 1u).x, T32.Load(fragment_unnamed_1883 + 2u).x);
							float fragment_unnamed_1898 = asfloat(fragment_unnamed_1892.z);
							float fragment_unnamed_1902 = fragment_unnamed_1898 * (fragment_unnamed_1867 * (fragment_unnamed_253 * fragment_unnamed_1805));
							float fragment_unnamed_1903 = fragment_unnamed_1898 * (fragment_unnamed_1867 * (fragment_unnamed_254 * fragment_unnamed_1805));
							float fragment_unnamed_1904 = fragment_unnamed_1898 * (fragment_unnamed_1867 * (fragment_unnamed_255 * fragment_unnamed_1805));
							uint fragment_unnamed_1907 = uint(int(asfloat(fragment_unnamed_1778.x))) + 4294967295u;
							float fragment_unnamed_1909 = float(int(uint(min(int(asuint(fragment_unnamed_1622) + 1u), int(fragment_unnamed_1907)))));
							float fragment_unnamed_1919 = trunc(fragment_uniform_buffer_0[74u].z);
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
							float fragment_unnamed_2360;
							float fragment_unnamed_2361;
							if (((((fragment_unnamed_1631 != fragment_unnamed_1909) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_1861) ? 4294967295u : 0u)) & ((fragment_unnamed_1861 >= frac(frac(dot(float2(mad(fragment_unnamed_1919, 2.0829999446868896484375f, float(fragment_unnamed_284)), mad(fragment_unnamed_1919, 4.867000102996826171875f, float(fragment_unnamed_285))), float2(0.067110560834407806396484375f, 0.005837149918079376220703125f))) * 52.98291778564453125f)) ? 4294967295u : 0u)) != 0u)
							{
								uint fragment_unnamed_1980 = uint(int(fragment_unnamed_1909 + float(int(fragment_unnamed_1794))));
								uint fragment_unnamed_1981 = fragment_unnamed_1980 * 60u;
								uint4 fragment_unnamed_1993 = uint4(T32.Load(fragment_unnamed_1981).x, T32.Load(fragment_unnamed_1981 + 1u).x, T32.Load(fragment_unnamed_1981 + 2u).x, T32.Load(fragment_unnamed_1981 + 3u).x);
								uint fragment_unnamed_2000 = (fragment_unnamed_1980 * 60u) + 4u;
								uint4 fragment_unnamed_2012 = uint4(T32.Load(fragment_unnamed_2000).x, T32.Load(fragment_unnamed_2000 + 1u).x, T32.Load(fragment_unnamed_2000 + 2u).x, T32.Load(fragment_unnamed_2000 + 3u).x);
								uint fragment_unnamed_2018 = (fragment_unnamed_1980 * 60u) + 12u;
								uint4 fragment_unnamed_2030 = uint4(T32.Load(fragment_unnamed_2018).x, T32.Load(fragment_unnamed_2018 + 1u).x, T32.Load(fragment_unnamed_2018 + 2u).x, T32.Load(fragment_unnamed_2018 + 3u).x);
								uint fragment_unnamed_2040 = (fragment_unnamed_1980 * 60u) + 8u;
								uint4 fragment_unnamed_2052 = uint4(T32.Load(fragment_unnamed_2040).x, T32.Load(fragment_unnamed_2040 + 1u).x, T32.Load(fragment_unnamed_2040 + 2u).x, T32.Load(fragment_unnamed_2040 + 3u).x);
								uint fragment_unnamed_2060 = (fragment_unnamed_1980 * 60u) + 16u;
								uint3 fragment_unnamed_2069 = uint3(T32.Load(fragment_unnamed_2060).x, T32.Load(fragment_unnamed_2060 + 1u).x, T32.Load(fragment_unnamed_2060 + 2u).x);
								uint fragment_unnamed_2076 = (fragment_unnamed_1980 * 60u) + 40u;
								uint3 fragment_unnamed_2085 = uint3(T32.Load(fragment_unnamed_2076).x, T32.Load(fragment_unnamed_2076 + 1u).x, T32.Load(fragment_unnamed_2076 + 2u).x);
								float fragment_unnamed_2101 = asfloat(fragment_unnamed_2069.z) / fragment_unnamed_1898;
								fragment_unnamed_2338 = fragment_unnamed_2101 * fragment_unnamed_1902;
								fragment_unnamed_2339 = fragment_unnamed_2101 * fragment_unnamed_1903;
								fragment_unnamed_2340 = fragment_unnamed_2101 * fragment_unnamed_1904;
								fragment_unnamed_2341 = asfloat(fragment_unnamed_2069.x);
								fragment_unnamed_2342 = asfloat(fragment_unnamed_2069.y);
								fragment_unnamed_2343 = asfloat(fragment_unnamed_1993.w);
								fragment_unnamed_2344 = asfloat(fragment_unnamed_2012.x);
								fragment_unnamed_2345 = asfloat(fragment_unnamed_2012.y);
								fragment_unnamed_2346 = asfloat(fragment_unnamed_2052.z);
								fragment_unnamed_2347 = asfloat(fragment_unnamed_2030.z);
								fragment_unnamed_2348 = asfloat(fragment_unnamed_2030.w);
								fragment_unnamed_2349 = asfloat(fragment_unnamed_2030.x);
								fragment_unnamed_2350 = asfloat(fragment_unnamed_2030.y);
								fragment_unnamed_2351 = asfloat(fragment_unnamed_2012.z);
								fragment_unnamed_2352 = asfloat(fragment_unnamed_2012.w);
								fragment_unnamed_2353 = asfloat(fragment_unnamed_2052.x);
								fragment_unnamed_2354 = asfloat(fragment_unnamed_2052.w);
								fragment_unnamed_2355 = asfloat(fragment_unnamed_2085.x) + fragment_input_5.x;
								fragment_unnamed_2356 = asfloat(fragment_unnamed_2085.y) + fragment_input_5.y;
								fragment_unnamed_2357 = asfloat(fragment_unnamed_2085.z) + fragment_input_5.z;
								fragment_unnamed_2358 = asfloat(fragment_unnamed_1993.x);
								fragment_unnamed_2359 = asfloat(fragment_unnamed_1993.y);
								fragment_unnamed_2360 = asfloat(fragment_unnamed_1993.z);
								fragment_unnamed_2361 = asfloat(fragment_unnamed_2052.y);
							}
							else
							{
								uint fragment_unnamed_2116 = fragment_unnamed_1881 * 60u;
								uint4 fragment_unnamed_2128 = uint4(T32.Load(fragment_unnamed_2116).x, T32.Load(fragment_unnamed_2116 + 1u).x, T32.Load(fragment_unnamed_2116 + 2u).x, T32.Load(fragment_unnamed_2116 + 3u).x);
								uint fragment_unnamed_2135 = (fragment_unnamed_1881 * 60u) + 4u;
								uint4 fragment_unnamed_2147 = uint4(T32.Load(fragment_unnamed_2135).x, T32.Load(fragment_unnamed_2135 + 1u).x, T32.Load(fragment_unnamed_2135 + 2u).x, T32.Load(fragment_unnamed_2135 + 3u).x);
								uint fragment_unnamed_2153 = (fragment_unnamed_1881 * 60u) + 12u;
								uint4 fragment_unnamed_2165 = uint4(T32.Load(fragment_unnamed_2153).x, T32.Load(fragment_unnamed_2153 + 1u).x, T32.Load(fragment_unnamed_2153 + 2u).x, T32.Load(fragment_unnamed_2153 + 3u).x);
								uint fragment_unnamed_2175 = (fragment_unnamed_1881 * 60u) + 8u;
								uint4 fragment_unnamed_2187 = uint4(T32.Load(fragment_unnamed_2175).x, T32.Load(fragment_unnamed_2175 + 1u).x, T32.Load(fragment_unnamed_2175 + 2u).x, T32.Load(fragment_unnamed_2175 + 3u).x);
								uint fragment_unnamed_2195 = (fragment_unnamed_1881 * 60u) + 40u;
								uint3 fragment_unnamed_2204 = uint3(T32.Load(fragment_unnamed_2195).x, T32.Load(fragment_unnamed_2195 + 1u).x, T32.Load(fragment_unnamed_2195 + 2u).x);
								fragment_unnamed_2338 = fragment_unnamed_1902;
								fragment_unnamed_2339 = fragment_unnamed_1903;
								fragment_unnamed_2340 = fragment_unnamed_1904;
								fragment_unnamed_2341 = asfloat(fragment_unnamed_1892.x);
								fragment_unnamed_2342 = asfloat(fragment_unnamed_1892.y);
								fragment_unnamed_2343 = asfloat(fragment_unnamed_2128.w);
								fragment_unnamed_2344 = asfloat(fragment_unnamed_2147.x);
								fragment_unnamed_2345 = asfloat(fragment_unnamed_2147.y);
								fragment_unnamed_2346 = asfloat(fragment_unnamed_2187.z);
								fragment_unnamed_2347 = asfloat(fragment_unnamed_2165.z);
								fragment_unnamed_2348 = asfloat(fragment_unnamed_2165.w);
								fragment_unnamed_2349 = asfloat(fragment_unnamed_2165.x);
								fragment_unnamed_2350 = asfloat(fragment_unnamed_2165.y);
								fragment_unnamed_2351 = asfloat(fragment_unnamed_2147.z);
								fragment_unnamed_2352 = asfloat(fragment_unnamed_2147.w);
								fragment_unnamed_2353 = asfloat(fragment_unnamed_2187.x);
								fragment_unnamed_2354 = asfloat(fragment_unnamed_2187.w);
								fragment_unnamed_2355 = asfloat(fragment_unnamed_2204.x) + fragment_input_5.x;
								fragment_unnamed_2356 = asfloat(fragment_unnamed_2204.y) + fragment_input_5.y;
								fragment_unnamed_2357 = asfloat(fragment_unnamed_2204.z) + fragment_input_5.z;
								fragment_unnamed_2358 = asfloat(fragment_unnamed_2128.x);
								fragment_unnamed_2359 = asfloat(fragment_unnamed_2128.y);
								fragment_unnamed_2360 = asfloat(fragment_unnamed_2128.z);
								fragment_unnamed_2361 = asfloat(fragment_unnamed_2187.y);
							}
							float fragment_unnamed_2362 = fragment_unnamed_2338 + fragment_unnamed_2355;
							float fragment_unnamed_2363 = fragment_unnamed_2339 + fragment_unnamed_2356;
							float fragment_unnamed_2364 = fragment_unnamed_2340 + fragment_unnamed_2357;
							float fragment_unnamed_2365 = asfloat(1065353216u);
							float fragment_unnamed_2392 = mad(asfloat(fragment_unnamed_1875.x) * clamp(mad(dot(float4(fragment_unnamed_2358, fragment_unnamed_2359, fragment_unnamed_2360, fragment_unnamed_2361), float4(fragment_unnamed_2362, fragment_unnamed_2363, fragment_unnamed_2364, fragment_unnamed_2365)) * fragment_unnamed_2349, 0.5f, 0.5f), 0.0f, 1.0f), fragment_uniform_buffer_0[98u].z, fragment_unnamed_2341);
							float fragment_unnamed_2393 = mad(asfloat(fragment_unnamed_1875.y) * clamp(mad(dot(float4(fragment_unnamed_2343, fragment_unnamed_2344, fragment_unnamed_2345, fragment_unnamed_2346), float4(fragment_unnamed_2362, fragment_unnamed_2363, fragment_unnamed_2364, fragment_unnamed_2365)) * fragment_unnamed_2350, 0.5f, 0.5f), 0.0f, 1.0f), fragment_uniform_buffer_0[98u].w, fragment_unnamed_2342);
							float fragment_unnamed_2394 = dot(float2(fragment_unnamed_2347, fragment_unnamed_2348), float2(dot(float4(fragment_unnamed_2351, fragment_unnamed_2352, fragment_unnamed_2353, fragment_unnamed_2354), float4(fragment_unnamed_2362, fragment_unnamed_2363, fragment_unnamed_2364, fragment_unnamed_2365)), asfloat(1065353216u))) + 1.52587890625e-05f;
							float fragment_unnamed_2402 = floor(mad(fragment_unnamed_2392, fragment_uniform_buffer_0[98u].x, 0.5f));
							float fragment_unnamed_2403 = floor(mad(fragment_unnamed_2393, fragment_uniform_buffer_0[98u].y, 0.5f));
							float fragment_unnamed_2410 = mad(fragment_unnamed_2392, fragment_uniform_buffer_0[98u].x, (-0.0f) - fragment_unnamed_2402);
							float fragment_unnamed_2411 = mad(fragment_unnamed_2393, fragment_uniform_buffer_0[98u].y, (-0.0f) - fragment_unnamed_2403);
							float fragment_unnamed_2412 = fragment_unnamed_2410 + 0.5f;
							float fragment_unnamed_2414 = fragment_unnamed_2411 + 0.5f;
							float fragment_unnamed_2420 = (fragment_unnamed_2412 * fragment_unnamed_2412) * 0.040816001594066619873046875f;
							float fragment_unnamed_2422 = (fragment_unnamed_2414 * fragment_unnamed_2414) * 0.040816001594066619873046875f;
							float fragment_unnamed_2431 = min(fragment_unnamed_2410, 0.0f);
							float fragment_unnamed_2432 = min(fragment_unnamed_2411, 0.0f);
							float fragment_unnamed_2437 = max(fragment_unnamed_2410, 0.0f);
							float fragment_unnamed_2438 = max(fragment_unnamed_2411, 0.0f);
							float fragment_unnamed_2451 = (mad((-0.0f) - fragment_unnamed_2431, fragment_unnamed_2431, ((-0.0f) - fragment_unnamed_2410) + 1.0f) + 2.0f) * 0.08163200318813323974609375f;
							float fragment_unnamed_2452 = (mad((-0.0f) - fragment_unnamed_2432, fragment_unnamed_2432, ((-0.0f) - fragment_unnamed_2411) + 1.0f) + 2.0f) * 0.08163200318813323974609375f;
							float fragment_unnamed_2458 = mad(fragment_unnamed_2410, -0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2459 = mad(fragment_unnamed_2410, 0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2460 = fragment_unnamed_2458 + (mad(fragment_unnamed_2412 * fragment_unnamed_2412, 0.5f, (-0.0f) - fragment_unnamed_2410) * 0.08163200318813323974609375f);
							float fragment_unnamed_2461 = fragment_unnamed_2451 + mad(fragment_unnamed_2410, -0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2462 = fragment_unnamed_2459 + ((mad((-0.0f) - fragment_unnamed_2437, fragment_unnamed_2437, fragment_unnamed_2410 + 1.0f) + 2.0f) * 0.08163200318813323974609375f);
							float fragment_unnamed_2463 = fragment_unnamed_2420 + mad(fragment_unnamed_2410, 0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2466 = mad(fragment_unnamed_2411, -0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2467 = mad(fragment_unnamed_2411, 0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2468 = fragment_unnamed_2466 + (mad(fragment_unnamed_2414 * fragment_unnamed_2414, 0.5f, (-0.0f) - fragment_unnamed_2411) * 0.08163200318813323974609375f);
							float fragment_unnamed_2469 = fragment_unnamed_2452 + mad(fragment_unnamed_2411, -0.08163200318813323974609375f, 0.1632640063762664794921875f);
							float fragment_unnamed_2470 = fragment_unnamed_2467 + ((mad((-0.0f) - fragment_unnamed_2438, fragment_unnamed_2438, fragment_unnamed_2411 + 1.0f) + 2.0f) * 0.08163200318813323974609375f);
							float fragment_unnamed_2471 = fragment_unnamed_2422 + mad(fragment_unnamed_2411, 0.08163200318813323974609375f, 0.08163200318813323974609375f);
							float fragment_unnamed_2494 = ((fragment_unnamed_2420 / fragment_unnamed_2463) + 2.5f) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2495 = ((fragment_unnamed_2458 / fragment_unnamed_2460) + (-3.5f)) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2496 = ((fragment_unnamed_2451 / fragment_unnamed_2461) + (-1.5f)) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2497 = ((fragment_unnamed_2459 / fragment_unnamed_2462) + 0.5f) * fragment_uniform_buffer_0[98u].z;
							float fragment_unnamed_2501 = ((fragment_unnamed_2466 / fragment_unnamed_2468) + (-3.5f)) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2502 = ((fragment_unnamed_2422 / fragment_unnamed_2471) + 2.5f) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2503 = ((fragment_unnamed_2452 / fragment_unnamed_2469) + (-1.5f)) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2504 = ((fragment_unnamed_2467 / fragment_unnamed_2470) + 0.5f) * fragment_uniform_buffer_0[98u].w;
							float fragment_unnamed_2581 = fragment_unnamed_2460 * fragment_unnamed_2468;
							float fragment_unnamed_2582 = fragment_unnamed_2461 * fragment_unnamed_2468;
							float fragment_unnamed_2583 = fragment_unnamed_2462 * fragment_unnamed_2468;
							float fragment_unnamed_2584 = fragment_unnamed_2463 * fragment_unnamed_2468;
							float fragment_unnamed_2585 = fragment_unnamed_2460 * fragment_unnamed_2469;
							float fragment_unnamed_2586 = fragment_unnamed_2461 * fragment_unnamed_2469;
							float fragment_unnamed_2587 = fragment_unnamed_2462 * fragment_unnamed_2469;
							float fragment_unnamed_2588 = fragment_unnamed_2463 * fragment_unnamed_2469;
							float fragment_unnamed_2589 = fragment_unnamed_2460 * fragment_unnamed_2470;
							float fragment_unnamed_2590 = fragment_unnamed_2461 * fragment_unnamed_2470;
							float fragment_unnamed_2591 = fragment_unnamed_2462 * fragment_unnamed_2470;
							float fragment_unnamed_2592 = fragment_unnamed_2463 * fragment_unnamed_2470;
							float fragment_unnamed_2593 = fragment_unnamed_2460 * fragment_unnamed_2471;
							float fragment_unnamed_2594 = fragment_unnamed_2461 * fragment_unnamed_2471;
							float fragment_unnamed_2595 = fragment_unnamed_2462 * fragment_unnamed_2471;
							float fragment_unnamed_2596 = fragment_unnamed_2463 * fragment_unnamed_2471;
							float4 fragment_unnamed_2602 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2495), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2501)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_2603 = fragment_unnamed_2602.x;
							float4 fragment_unnamed_2606 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2496), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2501)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_2607 = fragment_unnamed_2606.x;
							float4 fragment_unnamed_2610 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2497), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2501)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_2611 = fragment_unnamed_2610.x;
							float4 fragment_unnamed_2614 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2494), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2501)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_2615 = fragment_unnamed_2614.x;
							float fragment_unnamed_2617 = asfloat(0u);
							float fragment_unnamed_2924;
							fragment_unnamed_2924 = asfloat(0u);
							float fragment_unnamed_2925;
							float fragment_unnamed_3088;
							float fragment_unnamed_3089;
							float fragment_unnamed_3090;
							for (float fragment_unnamed_2926 = fragment_unnamed_2617; !(int(asuint(fragment_unnamed_2926)) >= int(1u)); fragment_unnamed_3088 = mad(fragment_unnamed_2581, fragment_unnamed_2603, fragment_unnamed_2924), fragment_unnamed_3089 = mad(fragment_unnamed_2582, fragment_unnamed_2607, fragment_unnamed_3088), fragment_unnamed_3090 = mad(fragment_unnamed_2583, fragment_unnamed_2611, fragment_unnamed_3089), fragment_unnamed_2925 = mad(fragment_unnamed_2584, fragment_unnamed_2615, fragment_unnamed_3090), fragment_unnamed_2924 = fragment_unnamed_2925, fragment_unnamed_2926 = asfloat(asuint(fragment_unnamed_2926) + 1u))
							{
							}
							float4 fragment_unnamed_3073 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2495), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2503)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_3074 = fragment_unnamed_3073.x;
							float4 fragment_unnamed_3077 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2496), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2503)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_3078 = fragment_unnamed_3077.x;
							float4 fragment_unnamed_3081 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2497), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2503)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_3082 = fragment_unnamed_3081.x;
							float4 fragment_unnamed_3085 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2494), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2503)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_3086 = fragment_unnamed_3085.x;
							float fragment_unnamed_3087 = asfloat(0u);
							float fragment_unnamed_3759;
							fragment_unnamed_3759 = fragment_unnamed_2924;
							float fragment_unnamed_3760;
							float fragment_unnamed_4114;
							float fragment_unnamed_4115;
							float fragment_unnamed_4116;
							for (float fragment_unnamed_3761 = fragment_unnamed_3087; !(int(asuint(fragment_unnamed_3761)) >= int(1u)); fragment_unnamed_4114 = mad(fragment_unnamed_2585, fragment_unnamed_3074, fragment_unnamed_3759), fragment_unnamed_4115 = mad(fragment_unnamed_2586, fragment_unnamed_3078, fragment_unnamed_4114), fragment_unnamed_4116 = mad(fragment_unnamed_2587, fragment_unnamed_3082, fragment_unnamed_4115), fragment_unnamed_3760 = mad(fragment_unnamed_2588, fragment_unnamed_3086, fragment_unnamed_4116), fragment_unnamed_3759 = fragment_unnamed_3760, fragment_unnamed_3761 = asfloat(asuint(fragment_unnamed_3761) + 1u))
							{
							}
							float4 fragment_unnamed_4099 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2495), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2504)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_4100 = fragment_unnamed_4099.x;
							float4 fragment_unnamed_4103 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2496), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2504)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_4104 = fragment_unnamed_4103.x;
							float4 fragment_unnamed_4107 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2497), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2504)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_4108 = fragment_unnamed_4107.x;
							float4 fragment_unnamed_4111 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2494), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2504)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_4112 = fragment_unnamed_4111.x;
							float fragment_unnamed_4113 = asfloat(0u);
							float fragment_unnamed_4779;
							fragment_unnamed_4779 = fragment_unnamed_3759;
							float fragment_unnamed_4780;
							float fragment_unnamed_5276;
							float fragment_unnamed_5277;
							float fragment_unnamed_5278;
							for (float fragment_unnamed_4781 = fragment_unnamed_4113; !(int(asuint(fragment_unnamed_4781)) >= int(1u)); fragment_unnamed_5276 = mad(fragment_unnamed_2589, fragment_unnamed_4100, fragment_unnamed_4779), fragment_unnamed_5277 = mad(fragment_unnamed_2590, fragment_unnamed_4104, fragment_unnamed_5276), fragment_unnamed_5278 = mad(fragment_unnamed_2591, fragment_unnamed_4108, fragment_unnamed_5277), fragment_unnamed_4780 = mad(fragment_unnamed_2592, fragment_unnamed_4112, fragment_unnamed_5278), fragment_unnamed_4779 = fragment_unnamed_4780, fragment_unnamed_4781 = asfloat(asuint(fragment_unnamed_4781) + 1u))
							{
							}
							float4 fragment_unnamed_5261 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2495), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2502)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_5262 = fragment_unnamed_5261.x;
							float4 fragment_unnamed_5265 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2496), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2502)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_5266 = fragment_unnamed_5265.x;
							float4 fragment_unnamed_5269 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2497), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2502)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_5270 = fragment_unnamed_5269.x;
							float4 fragment_unnamed_5273 = _ShadowmapCascadeAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_2402, fragment_uniform_buffer_0[98u].z, fragment_unnamed_2494), mad(fragment_unnamed_2403, fragment_uniform_buffer_0[98u].w, fragment_unnamed_2502)), fragment_unnamed_2394).xxxx;
							float fragment_unnamed_5274 = fragment_unnamed_5273.x;
							float fragment_unnamed_5275 = asfloat(0u);
							float fragment_unnamed_6359;
							fragment_unnamed_6359 = fragment_unnamed_4779;
							float fragment_unnamed_6360;
							float fragment_unnamed_6524;
							float fragment_unnamed_6525;
							float fragment_unnamed_6526;
							for (float fragment_unnamed_6361 = fragment_unnamed_5275; !(int(asuint(fragment_unnamed_6361)) >= int(1u)); fragment_unnamed_6524 = mad(fragment_unnamed_2593, fragment_unnamed_5262, fragment_unnamed_6359), fragment_unnamed_6525 = mad(fragment_unnamed_2594, fragment_unnamed_5266, fragment_unnamed_6524), fragment_unnamed_6526 = mad(fragment_unnamed_2595, fragment_unnamed_5270, fragment_unnamed_6525), fragment_unnamed_6360 = mad(fragment_unnamed_2596, fragment_unnamed_5274, fragment_unnamed_6526), fragment_unnamed_6359 = fragment_unnamed_6360, fragment_unnamed_6361 = asfloat(asuint(fragment_unnamed_6361) + 1u))
							{
							}
							fragment_unnamed_1605 = asfloat((int(asuint(fragment_unnamed_1622)) < int(fragment_unnamed_1907)) ? asuint(fragment_unnamed_6359) : asuint(mad(fragment_unnamed_1861, ((-0.0f) - fragment_unnamed_6359) + 1.0f, fragment_unnamed_6359)));
						}
						else
						{
							fragment_unnamed_1605 = asfloat(1065353216u);
						}
						fragment_unnamed_1464 = fragment_unnamed_1605;
						fragment_unnamed_1466 = fragment_unnamed_1605;
						fragment_unnamed_1468 = fragment_unnamed_1605;
					}
					else
					{
						fragment_unnamed_1464 = asfloat(1065353216u);
						fragment_unnamed_1466 = asfloat(1065353216u);
						fragment_unnamed_1468 = asfloat(1065353216u);
					}
					fragment_unnamed_1463 = fragment_unnamed_1464;
					fragment_unnamed_1465 = fragment_unnamed_1466;
					fragment_unnamed_1467 = fragment_unnamed_1468;
				}
				else
				{
					fragment_unnamed_1463 = asfloat(1065353216u);
					fragment_unnamed_1465 = asfloat(1065353216u);
					fragment_unnamed_1467 = asfloat(1065353216u);
				}
				float fragment_unnamed_1490 = asfloat((asuint(fragment_uniform_buffer_0[127u]).w != 0u) ? T5.Load((fragment_unnamed_288 * asuint(fragment_uniform_buffer_0[128u]).x) + fragment_unnamed_286).x : asuint(fragment_uniform_buffer_0[126u]).w);
				uint4 fragment_unnamed_1493 = asuint(fragment_uniform_buffer_0[127u]);
				uint fragment_unnamed_1494 = fragment_unnamed_1493.z;
				uint fragment_unnamed_1499 = 1u << (fragment_unnamed_1494 & 31u);
				uint fragment_unnamed_1532 = uint(int(min(float(int(fragment_unnamed_1499 + 4294967295u)), max(log2(mad(max((1.0f / gl_FragCoord.w) + ((-0.0f) - fragment_uniform_buffer_0[127u].x), 0.0f) / (((-0.0f) - fragment_uniform_buffer_0[127u].x) + fragment_uniform_buffer_0[127u].y), exp2(float(int(fragment_unnamed_1499)) * log2(abs(fragment_unnamed_1490))) + (-1.0f), 1.0f)) / log2(fragment_unnamed_1490), 0.0f))));
				uint4 fragment_unnamed_1545 = T4.Load((((fragment_unnamed_1532 * asuint(fragment_uniform_buffer_0[128u]).y) + fragment_unnamed_288) * asuint(fragment_uniform_buffer_0[128u]).x) + fragment_unnamed_286);
				uint fragment_unnamed_1546 = fragment_unnamed_1545.x;
				uint fragment_unnamed_1547 = fragment_unnamed_1546 & 67108863u;
				uint fragment_unnamed_1549 = fragment_unnamed_1546 >> 26u;
				float fragment_unnamed_1562 = dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_uniform_buffer_0[83u].xyz));
				float fragment_unnamed_1565 = fragment_unnamed_1224 * fragment_unnamed_1224;
				float fragment_unnamed_1573 = exp2(ceil(max((-0.0f) - fragment_uniform_buffer_0[123u].z, 0.0f)));
				float fragment_unnamed_1575 = fragment_unnamed_1224 * (fragment_unnamed_1565 * fragment_unnamed_1565);
				float fragment_unnamed_1576 = asfloat(1065353216u);
				float fragment_unnamed_1577 = asfloat(1065353216u);
				float fragment_unnamed_1578 = asfloat(1065353216u);
				float fragment_unnamed_1579 = asfloat(1065353216u);
				float fragment_unnamed_1580 = asfloat(0u);
				float fragment_unnamed_1581 = asfloat(0u);
				float fragment_unnamed_1582 = asfloat(0u);
				float fragment_unnamed_1583 = asfloat(0u);
				float fragment_unnamed_1584 = asfloat(0u);
				float fragment_unnamed_1585 = asfloat(0u);
				float fragment_unnamed_1586 = asfloat(0u);
				float fragment_unnamed_1606;
				float fragment_unnamed_1608;
				float fragment_unnamed_1610;
				float fragment_unnamed_1612;
				float fragment_unnamed_1614;
				float fragment_unnamed_1616;
				float fragment_unnamed_1618;
				for (;;)
				{
					fragment_unnamed_1606 = fragment_unnamed_1586;
					fragment_unnamed_1608 = fragment_unnamed_1580;
					fragment_unnamed_1610 = fragment_unnamed_1581;
					fragment_unnamed_1612 = fragment_unnamed_1582;
					fragment_unnamed_1614 = fragment_unnamed_1584;
					fragment_unnamed_1616 = fragment_unnamed_1585;
					fragment_unnamed_1618 = fragment_unnamed_1583;
					float fragment_unnamed_1607;
					float fragment_unnamed_1609;
					float fragment_unnamed_1611;
					float fragment_unnamed_1613;
					float fragment_unnamed_1615;
					float fragment_unnamed_1617;
					float fragment_unnamed_1619;
					bool ladder_phi_21;
					for (;;)
					{
						if (asuint(fragment_unnamed_1606) >= fragment_unnamed_1549)
						{
							ladder_phi_21 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_1762 = asuint(fragment_unnamed_1606);
							uint4 fragment_unnamed_1764 = T3.Load(fragment_unnamed_1547 + fragment_unnamed_1762);
							uint fragment_unnamed_1765 = fragment_unnamed_1764.x;
							if (fragment_unnamed_1765 == 4294967295u)
							{
								ladder_phi_21 = false;
								break;
							}
							uint fragment_unnamed_1953 = fragment_unnamed_1765 * 56u;
							uint4 fragment_unnamed_1966 = uint4(T7.Load(fragment_unnamed_1953).x, T7.Load(fragment_unnamed_1953 + 1u).x, T7.Load(fragment_unnamed_1953 + 2u).x, T7.Load(fragment_unnamed_1953 + 3u).x);
							fragment_unnamed_1607 = asfloat(asuint(fragment_unnamed_1606) + 1u);
							if (!((fragment_unnamed_827 & fragment_unnamed_1966.w) != 0u))
							{
								fragment_unnamed_1609 = fragment_unnamed_1608;
								fragment_unnamed_1611 = fragment_unnamed_1610;
								fragment_unnamed_1613 = fragment_unnamed_1612;
								fragment_unnamed_1615 = fragment_unnamed_1614;
								fragment_unnamed_1617 = fragment_unnamed_1616;
								fragment_unnamed_1619 = fragment_unnamed_1618;
								fragment_unnamed_1606 = fragment_unnamed_1607;
								fragment_unnamed_1608 = fragment_unnamed_1609;
								fragment_unnamed_1610 = fragment_unnamed_1611;
								fragment_unnamed_1612 = fragment_unnamed_1613;
								fragment_unnamed_1614 = fragment_unnamed_1615;
								fragment_unnamed_1616 = fragment_unnamed_1617;
								fragment_unnamed_1618 = fragment_unnamed_1619;
								continue;
							}
							uint fragment_unnamed_2247 = (fragment_unnamed_1765 * 56u) + 6u;
							uint4 fragment_unnamed_2259 = uint4(T7.Load(fragment_unnamed_2247).x, T7.Load(fragment_unnamed_2247 + 1u).x, T7.Load(fragment_unnamed_2247 + 2u).x, T7.Load(fragment_unnamed_2247 + 3u).x);
							uint fragment_unnamed_2267 = (fragment_unnamed_1765 * 56u) + 10u;
							uint4 fragment_unnamed_2279 = uint4(T7.Load(fragment_unnamed_2267).x, T7.Load(fragment_unnamed_2267 + 1u).x, T7.Load(fragment_unnamed_2267 + 2u).x, T7.Load(fragment_unnamed_2267 + 3u).x);
							float fragment_unnamed_2282 = asfloat(fragment_unnamed_2279.y);
							uint fragment_unnamed_2283 = fragment_unnamed_2279.z;
							float fragment_unnamed_2294 = ((-0.0f) - asfloat(fragment_unnamed_1966.x)) + fragment_input_5.x;
							float fragment_unnamed_2295 = ((-0.0f) - asfloat(fragment_unnamed_1966.y)) + fragment_input_5.y;
							float fragment_unnamed_2296 = ((-0.0f) - asfloat(fragment_unnamed_1966.z)) + fragment_input_5.z;
							bool fragment_unnamed_2297 = fragment_unnamed_2283 == 4u;
							float fragment_unnamed_2298 = asfloat(fragment_unnamed_2259.z);
							float fragment_unnamed_2299 = asfloat(fragment_unnamed_2259.w);
							float fragment_unnamed_2300 = asfloat(fragment_unnamed_2279.x);
							float fragment_unnamed_2307 = dot(float3((-0.0f) - fragment_unnamed_2294, (-0.0f) - fragment_unnamed_2295, (-0.0f) - fragment_unnamed_2296), float3((-0.0f) - fragment_unnamed_2294, (-0.0f) - fragment_unnamed_2295, (-0.0f) - fragment_unnamed_2296));
							float fragment_unnamed_2310 = rsqrt(fragment_unnamed_2307);
							float fragment_unnamed_2320 = fragment_unnamed_2297 ? ((-0.0f) - fragment_unnamed_2298) : (fragment_unnamed_2310 * ((-0.0f) - fragment_unnamed_2294));
							float fragment_unnamed_2321 = fragment_unnamed_2297 ? ((-0.0f) - fragment_unnamed_2299) : (fragment_unnamed_2310 * ((-0.0f) - fragment_unnamed_2295));
							float fragment_unnamed_2322 = fragment_unnamed_2297 ? ((-0.0f) - fragment_unnamed_2300) : (fragment_unnamed_2310 * ((-0.0f) - fragment_unnamed_2296));
							float fragment_unnamed_2325 = dot(float3(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822), float3(fragment_unnamed_2320, fragment_unnamed_2321, fragment_unnamed_2322));
							float fragment_unnamed_3058;
							float fragment_unnamed_3060;
							float fragment_unnamed_3062;
							float fragment_unnamed_3064;
							float fragment_unnamed_3066;
							float fragment_unnamed_3068;
							if ((((0.0f < asfloat(T7.Load((fragment_unnamed_1765 * 56u) + 4u).x)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_2325) ? 4294967295u : 0u)) != 0u)
							{
								uint fragment_unnamed_2704 = (fragment_unnamed_1765 * 56u) + 14u;
								uint4 fragment_unnamed_2716 = uint4(T7.Load(fragment_unnamed_2704).x, T7.Load(fragment_unnamed_2704 + 1u).x, T7.Load(fragment_unnamed_2704 + 2u).x, T7.Load(fragment_unnamed_2704 + 3u).x);
								float fragment_unnamed_2720 = asfloat(fragment_unnamed_2716.z);
								float fragment_unnamed_2722 = asfloat(fragment_unnamed_2716.w);
								uint fragment_unnamed_2724 = (fragment_unnamed_1765 * 56u) + 18u;
								uint4 fragment_unnamed_2736 = uint4(T7.Load(fragment_unnamed_2724).x, T7.Load(fragment_unnamed_2724 + 1u).x, T7.Load(fragment_unnamed_2724 + 2u).x, T7.Load(fragment_unnamed_2724 + 3u).x);
								uint fragment_unnamed_2742 = fragment_unnamed_2736.y;
								uint fragment_unnamed_2744 = (fragment_unnamed_1765 * 56u) + 22u;
								uint4 fragment_unnamed_2756 = uint4(T7.Load(fragment_unnamed_2744).x, T7.Load(fragment_unnamed_2744 + 1u).x, T7.Load(fragment_unnamed_2744 + 2u).x, T7.Load(fragment_unnamed_2744 + 3u).x);
								uint fragment_unnamed_2759 = fragment_unnamed_2756.z;
								uint fragment_unnamed_2761 = fragment_unnamed_2756.w;
								uint fragment_unnamed_2765 = (fragment_unnamed_1765 * 56u) + 26u;
								uint4 fragment_unnamed_2777 = uint4(T7.Load(fragment_unnamed_2765).x, T7.Load(fragment_unnamed_2765 + 1u).x, T7.Load(fragment_unnamed_2765 + 2u).x, T7.Load(fragment_unnamed_2765 + 3u).x);
								float fragment_unnamed_2781 = asfloat(fragment_unnamed_2777.z);
								uint fragment_unnamed_2782 = fragment_unnamed_2777.x;
								float fragment_unnamed_2785 = asfloat(fragment_unnamed_2777.w);
								uint fragment_unnamed_2788 = (fragment_unnamed_1765 * 56u) + 30u;
								uint4 fragment_unnamed_2800 = uint4(T7.Load(fragment_unnamed_2788).x, T7.Load(fragment_unnamed_2788 + 1u).x, T7.Load(fragment_unnamed_2788 + 2u).x, T7.Load(fragment_unnamed_2788 + 3u).x);
								float fragment_unnamed_2802 = asfloat(fragment_unnamed_2800.x);
								float fragment_unnamed_2804 = asfloat(fragment_unnamed_2800.y);
								uint fragment_unnamed_2809 = (fragment_unnamed_1765 * 56u) + 34u;
								uint2 fragment_unnamed_2815 = uint2(T7.Load(fragment_unnamed_2809).x, T7.Load(fragment_unnamed_2809 + 1u).x);
								float fragment_unnamed_2817 = asfloat(fragment_unnamed_2815.x);
								float fragment_unnamed_2819 = asfloat(fragment_unnamed_2815.y);
								float fragment_unnamed_2825 = dot(float3(fragment_unnamed_2294, fragment_unnamed_2295, fragment_unnamed_2296), float3(fragment_unnamed_2298, fragment_unnamed_2299, fragment_unnamed_2300));
								uint fragment_unnamed_2837 = fragment_unnamed_2297 ? asuint(fragment_unnamed_2825) : asuint(fragment_unnamed_2310 * fragment_unnamed_2307);
								float fragment_unnamed_2838 = asfloat(fragment_unnamed_2837);
								float fragment_unnamed_2847 = asfloat(fragment_unnamed_2756.y) * asfloat(fragment_unnamed_2297 ? asuint(fragment_unnamed_2825 * fragment_unnamed_2825) : asuint(fragment_unnamed_2307));
								float fragment_unnamed_2854 = clamp(mad((1.0f / fragment_unnamed_2838) * fragment_unnamed_2825, asfloat(fragment_unnamed_2259.x), asfloat(fragment_unnamed_2259.y)), 0.0f, 1.0f) * (clamp(mad((-0.0f) - fragment_unnamed_2847, fragment_unnamed_2847, asfloat(fragment_unnamed_2777.y)), 0.0f, 1.0f) * min(asfloat(fragment_unnamed_2297 ? 1065353216u : asuint(rsqrt(asfloat(T7.Load((fragment_unnamed_1765 * 56u) + 44u).x) + fragment_unnamed_2307))), 100.0f));
								float fragment_unnamed_2861 = dot(float3(fragment_unnamed_2320, fragment_unnamed_2321, fragment_unnamed_2322), float3(fragment_uniform_buffer_0[83u].xyz));
								float fragment_unnamed_2865 = max(abs(fragment_unnamed_2861), 0.001000000047497451305389404296875f);
								float fragment_unnamed_2867 = 1.0f / fragment_unnamed_2865;
								float fragment_unnamed_2869 = min(fragment_unnamed_1562, mad(fragment_unnamed_2838, fragment_unnamed_2861, fragment_unnamed_1562));
								float fragment_unnamed_2883 = min(fragment_unnamed_2838, max(fragment_unnamed_2867 * (((-0.0f) - fragment_unnamed_2869) + fragment_uniform_buffer_0[89u].y), 0.0f));
								float fragment_unnamed_2916 = (fragment_unnamed_2854 * fragment_unnamed_2854) * exp2((mad((((-0.0f) - exp2(((fragment_unnamed_2865 * ((-0.0f) - (((-0.0f) - fragment_unnamed_2883) + fragment_unnamed_2838))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_2869 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_2867 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_2883) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
								float fragment_unnamed_3742;
								float fragment_unnamed_3744;
								float fragment_unnamed_3746;
								float fragment_unnamed_3748;
								if (fragment_unnamed_2736.x != 0u)
								{
									float fragment_unnamed_3048 = dot(float3(fragment_unnamed_2294, fragment_unnamed_2295, fragment_unnamed_2296), float3(asfloat(fragment_unnamed_2279.w), asfloat(fragment_unnamed_2716.x), asfloat(fragment_unnamed_2716.y)));
									float fragment_unnamed_3052 = dot(float3(fragment_unnamed_2294, fragment_unnamed_2295, fragment_unnamed_2296), float3(asfloat(fragment_unnamed_2736.z), asfloat(fragment_unnamed_2736.w), asfloat(fragment_unnamed_2756.x)));
									float fragment_unnamed_3979;
									float fragment_unnamed_3980;
									float fragment_unnamed_3981;
									float fragment_unnamed_3982;
									if (fragment_unnamed_2283 == 1u)
									{
										float fragment_unnamed_3599 = 1.0f / max(dot(float3(abs(fragment_unnamed_3048), abs(fragment_unnamed_3052), abs(fragment_unnamed_2825)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
										float fragment_unnamed_3604 = clamp((-0.0f) - (fragment_unnamed_3599 * fragment_unnamed_2825), 0.0f, 1.0f);
										float fragment_unnamed_3607 = (-0.0f) - fragment_unnamed_3604;
										float fragment_unnamed_3621 = 1.0f / (fragment_unnamed_2781 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3622 = 1.0f / (fragment_unnamed_2785 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3634 = fragment_unnamed_2781 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3635 = fragment_unnamed_2785 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3638 = fragment_unnamed_1573 / (fragment_unnamed_3634 + fragment_unnamed_3634);
										float fragment_unnamed_3639 = fragment_unnamed_1573 / (fragment_unnamed_3635 + fragment_unnamed_3635);
										float4 fragment_unnamed_3653 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_3638) + 1.0f, max(fragment_unnamed_3638, mad(clamp(mad(mad(fragment_unnamed_3048, fragment_unnamed_3599, ((fragment_unnamed_3599 * fragment_unnamed_3048) >= 0.0f) ? fragment_unnamed_3604 : fragment_unnamed_3607), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_2781 * fragment_unnamed_3621, mad((-0.0f) - fragment_unnamed_3621, fragment_unnamed_2781, 1.0f) * 0.5f))), fragment_unnamed_2781, fragment_unnamed_2802), mad(min(((-0.0f) - fragment_unnamed_3639) + 1.0f, max(fragment_unnamed_3639, mad(clamp(mad(mad(fragment_unnamed_3052, fragment_unnamed_3599, ((fragment_unnamed_3599 * fragment_unnamed_3052) >= 0.0f) ? fragment_unnamed_3604 : fragment_unnamed_3607), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_2785 * fragment_unnamed_3622, mad((-0.0f) - fragment_unnamed_3622, fragment_unnamed_2785, 1.0f) * 0.5f))), fragment_unnamed_2785, fragment_unnamed_2804)), 0.0f);
										fragment_unnamed_3979 = fragment_unnamed_3653.x;
										fragment_unnamed_3980 = fragment_unnamed_3653.y;
										fragment_unnamed_3981 = fragment_unnamed_3653.z;
										fragment_unnamed_3982 = asfloat(1065353216u);
									}
									else
									{
										bool fragment_unnamed_3665 = fragment_unnamed_2283 != 4u;
										float fragment_unnamed_3671 = asfloat(fragment_unnamed_3665 ? asuint(fragment_unnamed_2825) : 1065353216u);
										float fragment_unnamed_3672 = fragment_unnamed_3048 / fragment_unnamed_3671;
										float fragment_unnamed_3673 = fragment_unnamed_3052 / fragment_unnamed_3671;
										uint fragment_unnamed_3685 = (asfloat(T7.Load((fragment_unnamed_1765 * 56u) + 55u).x) >= max(mad((-0.0f) - fragment_unnamed_2722, 0.5f, abs(mad((-0.0f) - fragment_unnamed_2722, 0.5f, fragment_unnamed_2825))) + 1.0f, max(abs(fragment_unnamed_3673), abs(fragment_unnamed_3672)))) ? 4294967295u : 0u;
										float fragment_unnamed_3703 = 1.0f / (fragment_unnamed_2781 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3704 = 1.0f / (fragment_unnamed_2785 + fragment_uniform_buffer_0[123u].y);
										float fragment_unnamed_3716 = fragment_unnamed_2781 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3717 = fragment_unnamed_2785 * fragment_uniform_buffer_0[123u].x;
										float fragment_unnamed_3720 = fragment_unnamed_1573 / (fragment_unnamed_3716 + fragment_unnamed_3716);
										float fragment_unnamed_3721 = fragment_unnamed_1573 / (fragment_unnamed_3717 + fragment_unnamed_3717);
										float4 fragment_unnamed_3735 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_3720) + 1.0f, max(fragment_unnamed_3720, mad(mad(fragment_unnamed_3672, 0.5f, 0.5f), fragment_unnamed_2781 * fragment_unnamed_3703, mad((-0.0f) - fragment_unnamed_3703, fragment_unnamed_2781, 1.0f) * 0.5f))), fragment_unnamed_2781, fragment_unnamed_2802), mad(min(((-0.0f) - fragment_unnamed_3721) + 1.0f, max(fragment_unnamed_3721, mad(mad(fragment_unnamed_3673, 0.5f, 0.5f), fragment_unnamed_2785 * fragment_unnamed_3704, mad((-0.0f) - fragment_unnamed_3704, fragment_unnamed_2785, 1.0f) * 0.5f))), fragment_unnamed_2785, fragment_unnamed_2804)), 0.0f);
										fragment_unnamed_3979 = fragment_unnamed_3735.x;
										fragment_unnamed_3980 = fragment_unnamed_3735.y;
										fragment_unnamed_3981 = fragment_unnamed_3735.z;
										fragment_unnamed_3982 = asfloat(((((fragment_unnamed_3665 ? 4294967295u : 0u) & ((fragment_unnamed_2283 != 3u) ? 4294967295u : 0u)) != 0u) ? (fragment_unnamed_3685 & (((fragment_unnamed_2282 * fragment_unnamed_2282) >= dot(float2(fragment_unnamed_3672, fragment_unnamed_3673), float2(fragment_unnamed_3672, fragment_unnamed_3673))) ? 4294967295u : 0u)) : fragment_unnamed_3685) & 1065353216u);
									}
									fragment_unnamed_3742 = fragment_unnamed_3982 * fragment_unnamed_2916;
									fragment_unnamed_3744 = fragment_unnamed_3979 * asfloat(fragment_unnamed_2759);
									fragment_unnamed_3746 = fragment_unnamed_3980 * asfloat(fragment_unnamed_2761);
									fragment_unnamed_3748 = fragment_unnamed_3981 * asfloat(fragment_unnamed_2782);
								}
								else
								{
									fragment_unnamed_3742 = fragment_unnamed_2916;
									fragment_unnamed_3744 = asfloat(fragment_unnamed_2759);
									fragment_unnamed_3746 = asfloat(fragment_unnamed_2761);
									fragment_unnamed_3748 = asfloat(fragment_unnamed_2782);
								}
								float fragment_unnamed_4740;
								if ((((int(fragment_unnamed_2742) >= int(0u)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_2819) ? 4294967295u : 0u)) != 0u)
								{
									bool fragment_unnamed_3985 = fragment_unnamed_2283 != 4u;
									uint fragment_unnamed_3986 = fragment_unnamed_3985 ? 4294967295u : 0u;
									float fragment_unnamed_3992 = asfloat((dot(float3(fragment_unnamed_253, fragment_unnamed_254, fragment_unnamed_255), float3(fragment_unnamed_2320, fragment_unnamed_2321, fragment_unnamed_2322)) >= 0.0f) ? 1065353216u : 3212836864u);
									float fragment_unnamed_3993 = fragment_unnamed_253 * fragment_unnamed_3992;
									float fragment_unnamed_3994 = fragment_unnamed_254 * fragment_unnamed_3992;
									float fragment_unnamed_3995 = fragment_unnamed_255 * fragment_unnamed_3992;
									uint fragment_unnamed_3997 = (fragment_unnamed_2742 * 60u) + 8u;
									uint4 fragment_unnamed_4009 = uint4(T32.Load(fragment_unnamed_3997).x, T32.Load(fragment_unnamed_3997 + 1u).x, T32.Load(fragment_unnamed_3997 + 2u).x, T32.Load(fragment_unnamed_3997 + 3u).x);
									uint fragment_unnamed_4011 = fragment_unnamed_4009.y;
									float fragment_unnamed_4012 = asfloat(fragment_unnamed_4011);
									uint fragment_unnamed_4013 = fragment_unnamed_4009.z;
									float fragment_unnamed_4014 = asfloat(fragment_unnamed_4013);
									uint fragment_unnamed_4015 = fragment_unnamed_4009.w;
									float fragment_unnamed_4016 = asfloat(fragment_unnamed_4015);
									uint fragment_unnamed_4018 = (fragment_unnamed_2742 * 60u) + 12u;
									uint4 fragment_unnamed_4030 = uint4(T32.Load(fragment_unnamed_4018).x, T32.Load(fragment_unnamed_4018 + 1u).x, T32.Load(fragment_unnamed_4018 + 2u).x, T32.Load(fragment_unnamed_4018 + 3u).x);
									float fragment_unnamed_4032 = asfloat(fragment_unnamed_4030.x);
									float fragment_unnamed_4034 = asfloat(fragment_unnamed_4030.y);
									float fragment_unnamed_4036 = asfloat(fragment_unnamed_4030.z);
									float fragment_unnamed_4038 = asfloat(fragment_unnamed_4030.w);
									uint fragment_unnamed_4040 = (fragment_unnamed_2742 * 60u) + 16u;
									uint4 fragment_unnamed_4052 = uint4(T32.Load(fragment_unnamed_4040).x, T32.Load(fragment_unnamed_4040 + 1u).x, T32.Load(fragment_unnamed_4040 + 2u).x, T32.Load(fragment_unnamed_4040 + 3u).x);
									float fragment_unnamed_4058 = asfloat(fragment_unnamed_4052.z);
									float fragment_unnamed_4060 = asfloat(fragment_unnamed_4052.w);
									uint fragment_unnamed_4062 = (fragment_unnamed_2742 * 60u) + 24u;
									uint2 fragment_unnamed_4068 = uint2(T32.Load(fragment_unnamed_4062).x, T32.Load(fragment_unnamed_4062 + 1u).x);
									float fragment_unnamed_4070 = asfloat(fragment_unnamed_4068.x);
									float fragment_unnamed_4072 = asfloat(fragment_unnamed_4068.y);
									uint fragment_unnamed_4074 = (fragment_unnamed_2742 * 60u) + 40u;
									uint4 fragment_unnamed_4086 = uint4(T32.Load(fragment_unnamed_4074).x, T32.Load(fragment_unnamed_4074 + 1u).x, T32.Load(fragment_unnamed_4074 + 2u).x, T32.Load(fragment_unnamed_4074 + 3u).x);
									float fragment_unnamed_4088 = asfloat(fragment_unnamed_4086.x);
									float fragment_unnamed_4090 = asfloat(fragment_unnamed_4086.y);
									float fragment_unnamed_4092 = asfloat(fragment_unnamed_4086.z);
									float fragment_unnamed_4094 = asfloat(fragment_unnamed_4086.w);
									float fragment_unnamed_5146;
									float fragment_unnamed_5147;
									float fragment_unnamed_5148;
									float fragment_unnamed_5149;
									float fragment_unnamed_5150;
									float fragment_unnamed_5151;
									float fragment_unnamed_5152;
									float fragment_unnamed_5153;
									float fragment_unnamed_5154;
									float fragment_unnamed_5155;
									float fragment_unnamed_5156;
									if (fragment_unnamed_2283 == 1u)
									{
										float fragment_unnamed_4604 = abs(fragment_unnamed_2322);
										float fragment_unnamed_4606 = abs(fragment_unnamed_2320);
										uint fragment_unnamed_4633 = uint(float(int(fragment_unnamed_2742)) + asfloat(((((fragment_unnamed_4604 >= abs(fragment_unnamed_2321)) ? 4294967295u : 0u) & ((fragment_unnamed_4604 >= fragment_unnamed_4606) ? 4294967295u : 0u)) != 0u) ? ((((-0.0f) - fragment_unnamed_2322) < 0.0f) ? 1084227584u : 1082130432u) : ((abs(fragment_unnamed_2321) >= fragment_unnamed_4606) ? ((((-0.0f) - fragment_unnamed_2321) < 0.0f) ? 1077936128u : 1073741824u) : (((((-0.0f) - fragment_unnamed_2320) < 0.0f) ? 4294967295u : 0u) & 1065353216u))));
										uint fragment_unnamed_4634 = fragment_unnamed_4633 * 60u;
										uint3 fragment_unnamed_4643 = uint3(T32.Load(fragment_unnamed_4634).x, T32.Load(fragment_unnamed_4634 + 1u).x, T32.Load(fragment_unnamed_4634 + 2u).x);
										uint fragment_unnamed_4651 = (fragment_unnamed_4633 * 60u) + 3u;
										uint3 fragment_unnamed_4660 = uint3(T32.Load(fragment_unnamed_4651).x, T32.Load(fragment_unnamed_4651 + 1u).x, T32.Load(fragment_unnamed_4651 + 2u).x);
										uint fragment_unnamed_4668 = (fragment_unnamed_4633 * 60u) + 6u;
										uint3 fragment_unnamed_4677 = uint3(T32.Load(fragment_unnamed_4668).x, T32.Load(fragment_unnamed_4668 + 1u).x, T32.Load(fragment_unnamed_4668 + 2u).x);
										uint fragment_unnamed_4685 = (fragment_unnamed_4633 * 60u) + 16u;
										uint2 fragment_unnamed_4691 = uint2(T32.Load(fragment_unnamed_4685).x, T32.Load(fragment_unnamed_4685 + 1u).x);
										fragment_unnamed_5146 = asfloat(fragment_unnamed_4691.x);
										fragment_unnamed_5147 = asfloat(fragment_unnamed_4691.y);
										fragment_unnamed_5148 = asfloat(fragment_unnamed_4643.x);
										fragment_unnamed_5149 = asfloat(fragment_unnamed_4643.y);
										fragment_unnamed_5150 = asfloat(fragment_unnamed_4643.z);
										fragment_unnamed_5151 = asfloat(fragment_unnamed_4660.x);
										fragment_unnamed_5152 = asfloat(fragment_unnamed_4660.y);
										fragment_unnamed_5153 = asfloat(fragment_unnamed_4660.z);
										fragment_unnamed_5154 = asfloat(fragment_unnamed_4677.x);
										fragment_unnamed_5155 = asfloat(fragment_unnamed_4677.y);
										fragment_unnamed_5156 = asfloat(fragment_unnamed_4677.z);
									}
									else
									{
										uint fragment_unnamed_4696 = fragment_unnamed_2742 * 60u;
										uint4 fragment_unnamed_4708 = uint4(T32.Load(fragment_unnamed_4696).x, T32.Load(fragment_unnamed_4696 + 1u).x, T32.Load(fragment_unnamed_4696 + 2u).x, T32.Load(fragment_unnamed_4696 + 3u).x);
										uint fragment_unnamed_4715 = (fragment_unnamed_2742 * 60u) + 4u;
										uint4 fragment_unnamed_4727 = uint4(T32.Load(fragment_unnamed_4715).x, T32.Load(fragment_unnamed_4715 + 1u).x, T32.Load(fragment_unnamed_4715 + 2u).x, T32.Load(fragment_unnamed_4715 + 3u).x);
										fragment_unnamed_5146 = asfloat(fragment_unnamed_4052.x);
										fragment_unnamed_5147 = asfloat(fragment_unnamed_4052.y);
										fragment_unnamed_5148 = asfloat(fragment_unnamed_4708.x);
										fragment_unnamed_5149 = asfloat(fragment_unnamed_4708.y);
										fragment_unnamed_5150 = asfloat(fragment_unnamed_4708.z);
										fragment_unnamed_5151 = asfloat(fragment_unnamed_4708.w);
										fragment_unnamed_5152 = asfloat(fragment_unnamed_4727.x);
										fragment_unnamed_5153 = asfloat(fragment_unnamed_4727.y);
										fragment_unnamed_5154 = asfloat(fragment_unnamed_4727.z);
										fragment_unnamed_5155 = asfloat(fragment_unnamed_4727.w);
										fragment_unnamed_5156 = asfloat(fragment_unnamed_4009.x);
									}
									float fragment_unnamed_7977;
									if (0.0f < fragment_unnamed_4094)
									{
										bool fragment_unnamed_5803 = 0.0f != fragment_unnamed_4094;
										uint4 fragment_unnamed_5807 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_5813 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_5817 = asfloat(fragment_unnamed_5803 ? fragment_unnamed_5807.z : fragment_unnamed_5813.z);
										float fragment_unnamed_5819 = asfloat(fragment_unnamed_5803 ? fragment_unnamed_5807.w : fragment_unnamed_5813.w);
										float fragment_unnamed_5821 = asfloat(fragment_unnamed_3985 ? fragment_unnamed_2837 : 1065353216u);
										float fragment_unnamed_5837 = mad(fragment_unnamed_4058 * (fragment_unnamed_3993 * fragment_unnamed_4060), fragment_unnamed_5821, fragment_unnamed_4088 + fragment_input_5.x);
										float fragment_unnamed_5838 = mad(fragment_unnamed_4058 * (fragment_unnamed_3994 * fragment_unnamed_4060), fragment_unnamed_5821, fragment_unnamed_4090 + fragment_input_5.y);
										float fragment_unnamed_5839 = mad(fragment_unnamed_4058 * (fragment_unnamed_3995 * fragment_unnamed_4060), fragment_unnamed_5821, fragment_unnamed_4092 + fragment_input_5.z);
										float fragment_unnamed_5843 = ((-0.0f) - fragment_unnamed_4012) + fragment_unnamed_5837;
										float fragment_unnamed_5844 = ((-0.0f) - fragment_unnamed_4014) + fragment_unnamed_5838;
										float fragment_unnamed_5845 = ((-0.0f) - fragment_unnamed_4016) + fragment_unnamed_5839;
										float fragment_unnamed_5878 = asfloat(fragment_unnamed_3985 ? asuint(dot(float3(fragment_unnamed_5154, fragment_unnamed_5155, fragment_unnamed_5156), float3(fragment_unnamed_5843, fragment_unnamed_5844, fragment_unnamed_5845))) : asuint(dot(float4(fragment_unnamed_5154, fragment_unnamed_5155, fragment_unnamed_5156, asfloat(fragment_unnamed_4015)), float4(fragment_unnamed_5837, fragment_unnamed_5838, fragment_unnamed_5839, fragment_unnamed_1576))));
										float fragment_unnamed_5883 = asfloat(fragment_unnamed_3985 ? asuint(dot(float3(fragment_unnamed_5148, fragment_unnamed_5149, fragment_unnamed_5150), float3(fragment_unnamed_5843, fragment_unnamed_5844, fragment_unnamed_5845))) : asuint(dot(float4(fragment_unnamed_5148, fragment_unnamed_5149, fragment_unnamed_5150, asfloat(fragment_unnamed_4011)), float4(fragment_unnamed_5837, fragment_unnamed_5838, fragment_unnamed_5839, fragment_unnamed_1576)))) * fragment_unnamed_4032;
										float fragment_unnamed_5884 = asfloat(fragment_unnamed_3985 ? asuint(dot(float3(fragment_unnamed_5151, fragment_unnamed_5152, fragment_unnamed_5153), float3(fragment_unnamed_5843, fragment_unnamed_5844, fragment_unnamed_5845))) : asuint(dot(float4(fragment_unnamed_5151, fragment_unnamed_5152, fragment_unnamed_5153, asfloat(fragment_unnamed_4013)), float4(fragment_unnamed_5837, fragment_unnamed_5838, fragment_unnamed_5839, fragment_unnamed_1576)))) * fragment_unnamed_4034;
										float fragment_unnamed_5885 = dot(float2(fragment_unnamed_4036, fragment_unnamed_4038), float2(fragment_unnamed_5878, fragment_unnamed_1577));
										float fragment_unnamed_5888 = dot(float2(asfloat(fragment_unnamed_3985 ? 3212836864u : 0u), asfloat(fragment_unnamed_3985 ? 0u : 1065353216u)), float2(fragment_unnamed_5878, fragment_unnamed_1577));
										bool fragment_unnamed_5897 = (fragment_unnamed_3986 & ((fragment_unnamed_5888 != 0.0f) ? 4294967295u : 0u)) != 0u;
										float fragment_unnamed_5916 = mad(fragment_unnamed_4070 * clamp(mad(asfloat(fragment_unnamed_5897 ? asuint(fragment_unnamed_5883 / fragment_unnamed_5888) : asuint(fragment_unnamed_5883)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5817, fragment_unnamed_5146);
										float fragment_unnamed_5917 = mad(fragment_unnamed_4072 * clamp(mad(asfloat(fragment_unnamed_5897 ? asuint(fragment_unnamed_5884 / fragment_unnamed_5888) : asuint(fragment_unnamed_5884)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_5819, fragment_unnamed_5147);
										uint4 fragment_unnamed_5937 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_5944 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_5950 = asfloat(fragment_unnamed_5803 ? fragment_unnamed_5937.z : fragment_unnamed_5944.z);
										float fragment_unnamed_5952 = asfloat(fragment_unnamed_5803 ? fragment_unnamed_5937.w : fragment_unnamed_5944.w);
										float fragment_unnamed_5954 = asfloat(fragment_unnamed_5803 ? fragment_unnamed_5937.x : fragment_unnamed_5944.x);
										uint fragment_unnamed_5955 = fragment_unnamed_5803 ? fragment_unnamed_5937.y : fragment_unnamed_5944.y;
										float fragment_unnamed_5956 = asfloat(fragment_unnamed_5897 ? asuint(fragment_unnamed_5885 / fragment_unnamed_5888) : asuint(fragment_unnamed_5885)) + 1.52587890625e-05f;
										float fragment_unnamed_5960 = floor(mad(fragment_unnamed_5916, fragment_unnamed_5954, 0.5f));
										float fragment_unnamed_5961 = floor(mad(fragment_unnamed_5917, asfloat(fragment_unnamed_5955), 0.5f));
										float fragment_unnamed_5965 = mad(fragment_unnamed_5916, fragment_unnamed_5954, (-0.0f) - fragment_unnamed_5960);
										float fragment_unnamed_5966 = mad(fragment_unnamed_5917, asfloat(fragment_unnamed_5955), (-0.0f) - fragment_unnamed_5961);
										float fragment_unnamed_5967 = fragment_unnamed_5965 + 0.5f;
										float fragment_unnamed_5968 = fragment_unnamed_5965 + 1.0f;
										float fragment_unnamed_5969 = fragment_unnamed_5966 + 0.5f;
										float fragment_unnamed_5970 = fragment_unnamed_5966 + 1.0f;
										float fragment_unnamed_5975 = (fragment_unnamed_5967 * fragment_unnamed_5967) * 0.07999999821186065673828125f;
										float fragment_unnamed_5977 = (fragment_unnamed_5969 * fragment_unnamed_5969) * 0.07999999821186065673828125f;
										float fragment_unnamed_5984 = ((-0.0f) - fragment_unnamed_5965) + 1.0f;
										float fragment_unnamed_5985 = ((-0.0f) - fragment_unnamed_5966) + 1.0f;
										float fragment_unnamed_5986 = min(fragment_unnamed_5965, 0.0f);
										float fragment_unnamed_5987 = min(fragment_unnamed_5966, 0.0f);
										float fragment_unnamed_5992 = max(fragment_unnamed_5965, 0.0f);
										float fragment_unnamed_5993 = max(fragment_unnamed_5966, 0.0f);
										float fragment_unnamed_6005 = fragment_unnamed_5984 * 0.1599999964237213134765625f;
										float fragment_unnamed_6006 = fragment_unnamed_5985 * 0.1599999964237213134765625f;
										float fragment_unnamed_6007 = (mad((-0.0f) - fragment_unnamed_5986, fragment_unnamed_5986, fragment_unnamed_5984) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6009 = (mad((-0.0f) - fragment_unnamed_5992, fragment_unnamed_5992, fragment_unnamed_5968) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6010 = (mad((-0.0f) - fragment_unnamed_5993, fragment_unnamed_5993, fragment_unnamed_5970) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6014 = (fragment_unnamed_5968 * 0.1599999964237213134765625f) + fragment_unnamed_5975;
										float fragment_unnamed_6015 = (mad(fragment_unnamed_5967 * fragment_unnamed_5967, 0.5f, (-0.0f) - fragment_unnamed_5965) * 0.1599999964237213134765625f) + fragment_unnamed_6005;
										float fragment_unnamed_6016 = fragment_unnamed_6007 + fragment_unnamed_6009;
										float fragment_unnamed_6017 = (mad(fragment_unnamed_5969 * fragment_unnamed_5969, 0.5f, (-0.0f) - fragment_unnamed_5966) * 0.1599999964237213134765625f) + fragment_unnamed_6006;
										float fragment_unnamed_6018 = ((mad((-0.0f) - fragment_unnamed_5987, fragment_unnamed_5987, fragment_unnamed_5985) + 1.0f) * 0.1599999964237213134765625f) + fragment_unnamed_6010;
										float fragment_unnamed_6019 = (fragment_unnamed_5970 * 0.1599999964237213134765625f) + fragment_unnamed_5977;
										float fragment_unnamed_6032 = fragment_unnamed_5950 * ((fragment_unnamed_6009 / fragment_unnamed_6016) + (-0.5f));
										float fragment_unnamed_6033 = fragment_unnamed_5950 * ((fragment_unnamed_6005 / fragment_unnamed_6015) + (-2.5f));
										float fragment_unnamed_6034 = fragment_unnamed_5950 * ((fragment_unnamed_5975 / fragment_unnamed_6014) + 1.5f);
										float fragment_unnamed_6035 = fragment_unnamed_5952 * ((fragment_unnamed_6006 / fragment_unnamed_6017) + (-2.5f));
										float fragment_unnamed_6036 = fragment_unnamed_5952 * ((fragment_unnamed_6010 / fragment_unnamed_6018) + (-0.5f));
										float fragment_unnamed_6037 = fragment_unnamed_5952 * ((fragment_unnamed_5977 / fragment_unnamed_6019) + 1.5f);
										float fragment_unnamed_6056 = fragment_unnamed_6017 * fragment_unnamed_6015;
										float fragment_unnamed_6057 = fragment_unnamed_6017 * fragment_unnamed_6016;
										float fragment_unnamed_6058 = fragment_unnamed_6017 * fragment_unnamed_6014;
										float fragment_unnamed_6059 = fragment_unnamed_6018 * fragment_unnamed_6015;
										float fragment_unnamed_6060 = fragment_unnamed_6018 * (fragment_unnamed_6007 + fragment_unnamed_6009);
										float fragment_unnamed_6061 = fragment_unnamed_6018 * fragment_unnamed_6014;
										float fragment_unnamed_6062 = fragment_unnamed_6019 * fragment_unnamed_6015;
										float fragment_unnamed_6063 = fragment_unnamed_6019 * fragment_unnamed_6016;
										float4 fragment_unnamed_6068 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5960, fragment_unnamed_5950, fragment_unnamed_6033), mad(fragment_unnamed_5961, fragment_unnamed_5952, fragment_unnamed_6035)), fragment_unnamed_5956).xxxx;
										float fragment_unnamed_6069 = fragment_unnamed_6068.x;
										float4 fragment_unnamed_6072 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5960, fragment_unnamed_5950, fragment_unnamed_6032), mad(fragment_unnamed_5961, fragment_unnamed_5952, fragment_unnamed_6035)), fragment_unnamed_5956).xxxx;
										float fragment_unnamed_6073 = fragment_unnamed_6072.x;
										float4 fragment_unnamed_6076 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5960, fragment_unnamed_5950, fragment_unnamed_6034), mad(fragment_unnamed_5961, fragment_unnamed_5952, fragment_unnamed_6035)), fragment_unnamed_5956).xxxx;
										float fragment_unnamed_6077 = fragment_unnamed_6076.x;
										float4 fragment_unnamed_6080 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5960, fragment_unnamed_5950, fragment_unnamed_6033), mad(fragment_unnamed_5961, fragment_unnamed_5952, fragment_unnamed_6036)), fragment_unnamed_5956).xxxx;
										float fragment_unnamed_6081 = fragment_unnamed_6080.x;
										float fragment_unnamed_6083 = asfloat(0u);
										float fragment_unnamed_6504;
										fragment_unnamed_6504 = asfloat(0u);
										for (float fragment_unnamed_6506 = fragment_unnamed_6083; !(int(asuint(fragment_unnamed_6506)) >= int(1u)); fragment_unnamed_6504 = mad(fragment_unnamed_6059, fragment_unnamed_6081, mad(fragment_unnamed_6058, fragment_unnamed_6077, mad(fragment_unnamed_6057, fragment_unnamed_6073, mad(fragment_unnamed_6056, fragment_unnamed_6069, fragment_unnamed_6504)))), fragment_unnamed_6506 = asfloat(asuint(fragment_unnamed_6506) + 1u))
										{
										}
										float4 fragment_unnamed_6955 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5960, fragment_unnamed_5950, fragment_unnamed_6032), mad(fragment_unnamed_5961, fragment_unnamed_5952, fragment_unnamed_6036)), fragment_unnamed_5956).xxxx;
										float fragment_unnamed_6956 = fragment_unnamed_6955.x;
										float4 fragment_unnamed_6959 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5960, fragment_unnamed_5950, fragment_unnamed_6034), mad(fragment_unnamed_5961, fragment_unnamed_5952, fragment_unnamed_6036)), fragment_unnamed_5956).xxxx;
										float fragment_unnamed_6960 = fragment_unnamed_6959.x;
										float4 fragment_unnamed_6963 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5960, fragment_unnamed_5950, fragment_unnamed_6033), mad(fragment_unnamed_5961, fragment_unnamed_5952, fragment_unnamed_6037)), fragment_unnamed_5956).xxxx;
										float fragment_unnamed_6964 = fragment_unnamed_6963.x;
										float4 fragment_unnamed_6967 = _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5960, fragment_unnamed_5950, fragment_unnamed_6032), mad(fragment_unnamed_5961, fragment_unnamed_5952, fragment_unnamed_6037)), fragment_unnamed_5956).xxxx;
										float fragment_unnamed_6968 = fragment_unnamed_6967.x;
										float fragment_unnamed_6969 = asfloat(0u);
										float fragment_unnamed_7416;
										fragment_unnamed_7416 = fragment_unnamed_6504;
										float fragment_unnamed_7417;
										for (float fragment_unnamed_7418 = fragment_unnamed_6969; !(int(asuint(fragment_unnamed_7418)) >= int(1u)); fragment_unnamed_7417 = mad(fragment_unnamed_6063, fragment_unnamed_6968, mad(fragment_unnamed_6062, fragment_unnamed_6964, mad(fragment_unnamed_6061, fragment_unnamed_6960, mad(fragment_unnamed_6060, fragment_unnamed_6956, fragment_unnamed_7416)))), fragment_unnamed_7416 = fragment_unnamed_7417, fragment_unnamed_7418 = asfloat(asuint(fragment_unnamed_7418) + 1u))
										{
										}
										fragment_unnamed_7977 = asfloat((((((fragment_unnamed_5917 < (fragment_unnamed_5819 + fragment_unnamed_5147)) ? 4294967295u : 0u) | ((fragment_unnamed_5916 < (fragment_unnamed_5817 + fragment_unnamed_5146)) ? 4294967295u : 0u)) | (((mad(fragment_unnamed_4072 + (-0.5f), fragment_unnamed_5819, fragment_unnamed_5147) < fragment_unnamed_5917) ? 4294967295u : 0u) | ((mad(fragment_unnamed_4070 + (-0.5f), fragment_unnamed_5817, fragment_unnamed_5146) < fragment_unnamed_5916) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(mad(fragment_unnamed_6019 * fragment_unnamed_6014, _CachedShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_5960, fragment_unnamed_5950, fragment_unnamed_6034), mad(fragment_unnamed_5961, fragment_unnamed_5952, fragment_unnamed_6037)), fragment_unnamed_5956).xxxx.x, fragment_unnamed_7416)));
									}
									else
									{
										bool fragment_unnamed_6084 = 0.0f != fragment_unnamed_4094;
										uint4 fragment_unnamed_6087 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_6092 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_6096 = asfloat(fragment_unnamed_6084 ? fragment_unnamed_6087.z : fragment_unnamed_6092.z);
										float fragment_unnamed_6098 = asfloat(fragment_unnamed_6084 ? fragment_unnamed_6087.w : fragment_unnamed_6092.w);
										float fragment_unnamed_6100 = asfloat(fragment_unnamed_3985 ? fragment_unnamed_2837 : 1065353216u);
										float fragment_unnamed_6116 = mad(fragment_unnamed_4058 * (fragment_unnamed_3993 * fragment_unnamed_4060), fragment_unnamed_6100, fragment_unnamed_4088 + fragment_input_5.x);
										float fragment_unnamed_6117 = mad(fragment_unnamed_4058 * (fragment_unnamed_3994 * fragment_unnamed_4060), fragment_unnamed_6100, fragment_unnamed_4090 + fragment_input_5.y);
										float fragment_unnamed_6118 = mad(fragment_unnamed_4058 * (fragment_unnamed_3995 * fragment_unnamed_4060), fragment_unnamed_6100, fragment_unnamed_4092 + fragment_input_5.z);
										float fragment_unnamed_6122 = ((-0.0f) - fragment_unnamed_4012) + fragment_unnamed_6116;
										float fragment_unnamed_6123 = ((-0.0f) - fragment_unnamed_4014) + fragment_unnamed_6117;
										float fragment_unnamed_6124 = ((-0.0f) - fragment_unnamed_4016) + fragment_unnamed_6118;
										float fragment_unnamed_6156 = asfloat(fragment_unnamed_3985 ? asuint(dot(float3(fragment_unnamed_5154, fragment_unnamed_5155, fragment_unnamed_5156), float3(fragment_unnamed_6122, fragment_unnamed_6123, fragment_unnamed_6124))) : asuint(dot(float4(fragment_unnamed_5154, fragment_unnamed_5155, fragment_unnamed_5156, fragment_unnamed_4016), float4(fragment_unnamed_6116, fragment_unnamed_6117, fragment_unnamed_6118, fragment_unnamed_1578))));
										float fragment_unnamed_6161 = asfloat(fragment_unnamed_3985 ? asuint(dot(float3(fragment_unnamed_5148, fragment_unnamed_5149, fragment_unnamed_5150), float3(fragment_unnamed_6122, fragment_unnamed_6123, fragment_unnamed_6124))) : asuint(dot(float4(fragment_unnamed_5148, fragment_unnamed_5149, fragment_unnamed_5150, asfloat(fragment_unnamed_4011)), float4(fragment_unnamed_6116, fragment_unnamed_6117, fragment_unnamed_6118, fragment_unnamed_1578)))) * fragment_unnamed_4032;
										float fragment_unnamed_6162 = asfloat(fragment_unnamed_3985 ? asuint(dot(float3(fragment_unnamed_5151, fragment_unnamed_5152, fragment_unnamed_5153), float3(fragment_unnamed_6122, fragment_unnamed_6123, fragment_unnamed_6124))) : asuint(dot(float4(fragment_unnamed_5151, fragment_unnamed_5152, fragment_unnamed_5153, asfloat(fragment_unnamed_4013)), float4(fragment_unnamed_6116, fragment_unnamed_6117, fragment_unnamed_6118, fragment_unnamed_1578)))) * fragment_unnamed_4034;
										float fragment_unnamed_6163 = dot(float2(fragment_unnamed_4036, fragment_unnamed_4038), float2(fragment_unnamed_6156, fragment_unnamed_1579));
										float fragment_unnamed_6166 = dot(float2(asfloat(fragment_unnamed_3985 ? 3212836864u : 0u), asfloat(fragment_unnamed_3985 ? 0u : 1065353216u)), float2(fragment_unnamed_6156, fragment_unnamed_1579));
										bool fragment_unnamed_6175 = (fragment_unnamed_3986 & ((fragment_unnamed_6166 != 0.0f) ? 4294967295u : 0u)) != 0u;
										float fragment_unnamed_6194 = mad(fragment_unnamed_4070 * clamp(mad(asfloat(fragment_unnamed_6175 ? asuint(fragment_unnamed_6161 / fragment_unnamed_6166) : asuint(fragment_unnamed_6161)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6096, fragment_unnamed_5146);
										float fragment_unnamed_6195 = mad(fragment_unnamed_4072 * clamp(mad(asfloat(fragment_unnamed_6175 ? asuint(fragment_unnamed_6162 / fragment_unnamed_6166) : asuint(fragment_unnamed_6162)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_6098, fragment_unnamed_5147);
										uint4 fragment_unnamed_6215 = asuint(fragment_uniform_buffer_0[100u]);
										uint4 fragment_unnamed_6222 = asuint(fragment_uniform_buffer_0[97u]);
										float fragment_unnamed_6228 = asfloat(fragment_unnamed_6084 ? fragment_unnamed_6215.z : fragment_unnamed_6222.z);
										float fragment_unnamed_6230 = asfloat(fragment_unnamed_6084 ? fragment_unnamed_6215.w : fragment_unnamed_6222.w);
										float fragment_unnamed_6232 = asfloat(fragment_unnamed_6084 ? fragment_unnamed_6215.x : fragment_unnamed_6222.x);
										float fragment_unnamed_6234 = asfloat(fragment_unnamed_6084 ? fragment_unnamed_6215.y : fragment_unnamed_6222.y);
										float fragment_unnamed_6235 = asfloat(fragment_unnamed_6175 ? asuint(fragment_unnamed_6163 / fragment_unnamed_6166) : asuint(fragment_unnamed_6163)) + 1.52587890625e-05f;
										float fragment_unnamed_6238 = floor(mad(fragment_unnamed_6194, fragment_unnamed_6232, 0.5f));
										float fragment_unnamed_6239 = floor(mad(fragment_unnamed_6195, fragment_unnamed_6234, 0.5f));
										float fragment_unnamed_6242 = mad(fragment_unnamed_6194, fragment_unnamed_6232, (-0.0f) - fragment_unnamed_6238);
										float fragment_unnamed_6243 = mad(fragment_unnamed_6195, fragment_unnamed_6234, (-0.0f) - fragment_unnamed_6239);
										float fragment_unnamed_6244 = fragment_unnamed_6242 + 0.5f;
										float fragment_unnamed_6245 = fragment_unnamed_6242 + 1.0f;
										float fragment_unnamed_6246 = fragment_unnamed_6243 + 0.5f;
										float fragment_unnamed_6247 = fragment_unnamed_6243 + 1.0f;
										float fragment_unnamed_6252 = (fragment_unnamed_6244 * fragment_unnamed_6244) * 0.07999999821186065673828125f;
										float fragment_unnamed_6253 = (fragment_unnamed_6246 * fragment_unnamed_6246) * 0.07999999821186065673828125f;
										float fragment_unnamed_6260 = ((-0.0f) - fragment_unnamed_6242) + 1.0f;
										float fragment_unnamed_6261 = ((-0.0f) - fragment_unnamed_6243) + 1.0f;
										float fragment_unnamed_6262 = min(fragment_unnamed_6242, 0.0f);
										float fragment_unnamed_6263 = min(fragment_unnamed_6243, 0.0f);
										float fragment_unnamed_6268 = max(fragment_unnamed_6242, 0.0f);
										float fragment_unnamed_6269 = max(fragment_unnamed_6243, 0.0f);
										float fragment_unnamed_6280 = fragment_unnamed_6260 * 0.1599999964237213134765625f;
										float fragment_unnamed_6281 = fragment_unnamed_6261 * 0.1599999964237213134765625f;
										float fragment_unnamed_6282 = (mad((-0.0f) - fragment_unnamed_6262, fragment_unnamed_6262, fragment_unnamed_6260) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6284 = (mad((-0.0f) - fragment_unnamed_6268, fragment_unnamed_6268, fragment_unnamed_6245) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6285 = (mad((-0.0f) - fragment_unnamed_6269, fragment_unnamed_6269, fragment_unnamed_6247) + 1.0f) * 0.1599999964237213134765625f;
										float fragment_unnamed_6289 = (fragment_unnamed_6245 * 0.1599999964237213134765625f) + fragment_unnamed_6252;
										float fragment_unnamed_6290 = (mad(fragment_unnamed_6244 * fragment_unnamed_6244, 0.5f, (-0.0f) - fragment_unnamed_6242) * 0.1599999964237213134765625f) + fragment_unnamed_6280;
										float fragment_unnamed_6291 = fragment_unnamed_6282 + fragment_unnamed_6284;
										float fragment_unnamed_6292 = (mad(fragment_unnamed_6246 * fragment_unnamed_6246, 0.5f, (-0.0f) - fragment_unnamed_6243) * 0.1599999964237213134765625f) + fragment_unnamed_6281;
										float fragment_unnamed_6293 = ((mad((-0.0f) - fragment_unnamed_6263, fragment_unnamed_6263, fragment_unnamed_6261) + 1.0f) * 0.1599999964237213134765625f) + fragment_unnamed_6285;
										float fragment_unnamed_6294 = (fragment_unnamed_6247 * 0.1599999964237213134765625f) + fragment_unnamed_6253;
										float fragment_unnamed_6307 = fragment_unnamed_6228 * ((fragment_unnamed_6284 / fragment_unnamed_6291) + (-0.5f));
										float fragment_unnamed_6308 = fragment_unnamed_6228 * ((fragment_unnamed_6280 / fragment_unnamed_6290) + (-2.5f));
										float fragment_unnamed_6309 = fragment_unnamed_6228 * ((fragment_unnamed_6252 / fragment_unnamed_6289) + 1.5f);
										float fragment_unnamed_6310 = fragment_unnamed_6230 * ((fragment_unnamed_6281 / fragment_unnamed_6292) + (-2.5f));
										float fragment_unnamed_6311 = fragment_unnamed_6230 * ((fragment_unnamed_6285 / fragment_unnamed_6293) + (-0.5f));
										float fragment_unnamed_6312 = fragment_unnamed_6230 * ((fragment_unnamed_6253 / fragment_unnamed_6294) + 1.5f);
										float fragment_unnamed_6331 = fragment_unnamed_6292 * fragment_unnamed_6290;
										float fragment_unnamed_6332 = fragment_unnamed_6292 * fragment_unnamed_6291;
										float fragment_unnamed_6333 = fragment_unnamed_6292 * fragment_unnamed_6289;
										float fragment_unnamed_6334 = fragment_unnamed_6293 * fragment_unnamed_6290;
										float fragment_unnamed_6335 = fragment_unnamed_6293 * (fragment_unnamed_6282 + fragment_unnamed_6284);
										float fragment_unnamed_6336 = fragment_unnamed_6293 * fragment_unnamed_6289;
										float fragment_unnamed_6337 = fragment_unnamed_6294 * fragment_unnamed_6290;
										float fragment_unnamed_6338 = fragment_unnamed_6294 * fragment_unnamed_6291;
										float4 fragment_unnamed_6343 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6238, fragment_unnamed_6228, fragment_unnamed_6308), mad(fragment_unnamed_6239, fragment_unnamed_6230, fragment_unnamed_6310)), fragment_unnamed_6235).xxxx;
										float fragment_unnamed_6344 = fragment_unnamed_6343.x;
										float4 fragment_unnamed_6347 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6238, fragment_unnamed_6228, fragment_unnamed_6307), mad(fragment_unnamed_6239, fragment_unnamed_6230, fragment_unnamed_6310)), fragment_unnamed_6235).xxxx;
										float fragment_unnamed_6348 = fragment_unnamed_6347.x;
										float4 fragment_unnamed_6351 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6238, fragment_unnamed_6228, fragment_unnamed_6309), mad(fragment_unnamed_6239, fragment_unnamed_6230, fragment_unnamed_6310)), fragment_unnamed_6235).xxxx;
										float fragment_unnamed_6352 = fragment_unnamed_6351.x;
										float4 fragment_unnamed_6355 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6238, fragment_unnamed_6228, fragment_unnamed_6308), mad(fragment_unnamed_6239, fragment_unnamed_6230, fragment_unnamed_6311)), fragment_unnamed_6235).xxxx;
										float fragment_unnamed_6356 = fragment_unnamed_6355.x;
										float fragment_unnamed_6358 = asfloat(0u);
										float fragment_unnamed_6510;
										fragment_unnamed_6510 = asfloat(0u);
										for (float fragment_unnamed_6512 = fragment_unnamed_6358; !(int(asuint(fragment_unnamed_6512)) >= int(1u)); fragment_unnamed_6510 = mad(fragment_unnamed_6334, fragment_unnamed_6356, mad(fragment_unnamed_6333, fragment_unnamed_6352, mad(fragment_unnamed_6332, fragment_unnamed_6348, mad(fragment_unnamed_6331, fragment_unnamed_6344, fragment_unnamed_6510)))), fragment_unnamed_6512 = asfloat(asuint(fragment_unnamed_6512) + 1u))
										{
										}
										float4 fragment_unnamed_6978 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6238, fragment_unnamed_6228, fragment_unnamed_6307), mad(fragment_unnamed_6239, fragment_unnamed_6230, fragment_unnamed_6311)), fragment_unnamed_6235).xxxx;
										float fragment_unnamed_6979 = fragment_unnamed_6978.x;
										float4 fragment_unnamed_6982 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6238, fragment_unnamed_6228, fragment_unnamed_6309), mad(fragment_unnamed_6239, fragment_unnamed_6230, fragment_unnamed_6311)), fragment_unnamed_6235).xxxx;
										float fragment_unnamed_6983 = fragment_unnamed_6982.x;
										float4 fragment_unnamed_6986 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6238, fragment_unnamed_6228, fragment_unnamed_6308), mad(fragment_unnamed_6239, fragment_unnamed_6230, fragment_unnamed_6312)), fragment_unnamed_6235).xxxx;
										float fragment_unnamed_6987 = fragment_unnamed_6986.x;
										float4 fragment_unnamed_6990 = _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6238, fragment_unnamed_6228, fragment_unnamed_6307), mad(fragment_unnamed_6239, fragment_unnamed_6230, fragment_unnamed_6312)), fragment_unnamed_6235).xxxx;
										float fragment_unnamed_6991 = fragment_unnamed_6990.x;
										float fragment_unnamed_6992 = asfloat(0u);
										float fragment_unnamed_7422;
										fragment_unnamed_7422 = fragment_unnamed_6510;
										float fragment_unnamed_7423;
										for (float fragment_unnamed_7424 = fragment_unnamed_6992; !(int(asuint(fragment_unnamed_7424)) >= int(1u)); fragment_unnamed_7423 = mad(fragment_unnamed_6338, fragment_unnamed_6991, mad(fragment_unnamed_6337, fragment_unnamed_6987, mad(fragment_unnamed_6336, fragment_unnamed_6983, mad(fragment_unnamed_6335, fragment_unnamed_6979, fragment_unnamed_7422)))), fragment_unnamed_7422 = fragment_unnamed_7423, fragment_unnamed_7424 = asfloat(asuint(fragment_unnamed_7424) + 1u))
										{
										}
										fragment_unnamed_7977 = asfloat((((((fragment_unnamed_6195 < (fragment_unnamed_6098 + fragment_unnamed_5147)) ? 4294967295u : 0u) | ((fragment_unnamed_6194 < (fragment_unnamed_6096 + fragment_unnamed_5146)) ? 4294967295u : 0u)) | (((mad(fragment_unnamed_4072 + (-0.5f), fragment_unnamed_6098, fragment_unnamed_5147) < fragment_unnamed_6195) ? 4294967295u : 0u) | ((mad(fragment_unnamed_4070 + (-0.5f), fragment_unnamed_6096, fragment_unnamed_5146) < fragment_unnamed_6194) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(mad(fragment_unnamed_6294 * fragment_unnamed_6289, _ShadowmapAtlas.SampleCmpLevelZero(S2, float2(mad(fragment_unnamed_6238, fragment_unnamed_6228, fragment_unnamed_6309), mad(fragment_unnamed_6239, fragment_unnamed_6230, fragment_unnamed_6312)), fragment_unnamed_6235).xxxx.x, fragment_unnamed_7422)));
									}
									fragment_unnamed_4740 = mad(fragment_unnamed_2819, fragment_unnamed_7977 + (-1.0f), 1.0f);
								}
								else
								{
									fragment_unnamed_4740 = asfloat(1065353216u);
								}
								float fragment_unnamed_4742 = asfloat(fragment_unnamed_2800.z);
								float fragment_unnamed_4743 = asfloat(fragment_unnamed_2800.w);
								float fragment_unnamed_4747 = ((-0.0f) - fragment_unnamed_4742) + 1.0f;
								float fragment_unnamed_4748 = ((-0.0f) - fragment_unnamed_4743) + 1.0f;
								float fragment_unnamed_4749 = ((-0.0f) - fragment_unnamed_2817) + 1.0f;
								float fragment_unnamed_4751 = fragment_unnamed_4740 * (fragment_unnamed_4740 * fragment_unnamed_4740);
								float fragment_unnamed_4754 = (-0.0f) - (((-0.0f) - fragment_unnamed_4740) + 1.0f);
								float fragment_unnamed_4755 = mad(fragment_unnamed_4754, fragment_unnamed_4747, 1.0f);
								float fragment_unnamed_4756 = mad(fragment_unnamed_4754, fragment_unnamed_4748, 1.0f);
								float fragment_unnamed_4757 = mad(fragment_unnamed_4754, fragment_unnamed_4749, 1.0f);
								float fragment_unnamed_4773 = (fragment_unnamed_3742 * fragment_unnamed_3744) * mad(fragment_unnamed_2720, ((-0.0f) - fragment_unnamed_4755) + mad(fragment_unnamed_4751, fragment_unnamed_4747, fragment_unnamed_4742 * fragment_unnamed_4740), fragment_unnamed_4755);
								float fragment_unnamed_4774 = (fragment_unnamed_3742 * fragment_unnamed_3746) * mad(fragment_unnamed_2720, ((-0.0f) - fragment_unnamed_4756) + mad(fragment_unnamed_4751, fragment_unnamed_4748, fragment_unnamed_4743 * fragment_unnamed_4740), fragment_unnamed_4756);
								float fragment_unnamed_4775 = (fragment_unnamed_3742 * fragment_unnamed_3748) * mad(fragment_unnamed_2720, ((-0.0f) - fragment_unnamed_4757) + mad(fragment_unnamed_4751, fragment_unnamed_4749, fragment_unnamed_2817 * fragment_unnamed_4740), fragment_unnamed_4757);
								float fragment_unnamed_3059;
								float fragment_unnamed_3061;
								float fragment_unnamed_3063;
								float fragment_unnamed_3065;
								float fragment_unnamed_3067;
								float fragment_unnamed_3069;
								if (0.0f < max(fragment_unnamed_4775, max(fragment_unnamed_4774, fragment_unnamed_4773)))
								{
									uint fragment_unnamed_5165 = (fragment_unnamed_1765 * 56u) + 49u;
									uint2 fragment_unnamed_5171 = uint2(T7.Load(fragment_unnamed_5165).x, T7.Load(fragment_unnamed_5165 + 1u).x);
									float fragment_unnamed_5173 = asfloat(fragment_unnamed_5171.x);
									float fragment_unnamed_5175 = asfloat(fragment_unnamed_5171.y);
									float fragment_unnamed_5176 = max(fragment_unnamed_1192, asfloat(T7.Load((fragment_unnamed_1765 * 56u) + 38u).x));
									float fragment_unnamed_5177 = clamp(fragment_unnamed_2325, 0.0f, 1.0f);
									float fragment_unnamed_5178 = dot(float3(fragment_unnamed_2320, fragment_unnamed_2321, fragment_unnamed_2322), float3(fragment_unnamed_347, fragment_unnamed_348, fragment_unnamed_349));
									float fragment_unnamed_5183 = rsqrt(max(mad(fragment_unnamed_5178, 2.0f, 2.0f), 5.9604644775390625e-08f));
									float fragment_unnamed_5186 = clamp(fragment_unnamed_5183 * (fragment_unnamed_1110 + fragment_unnamed_2325), 0.0f, 1.0f);
									float fragment_unnamed_5190 = ((-0.0f) - clamp(mad(fragment_unnamed_5183, fragment_unnamed_5178, fragment_unnamed_5183), 0.0f, 1.0f)) + 1.0f;
									float fragment_unnamed_5191 = fragment_unnamed_5190 * fragment_unnamed_5190;
									float fragment_unnamed_5192 = fragment_unnamed_5191 * fragment_unnamed_5191;
									float fragment_unnamed_5195 = mad((-0.0f) - fragment_unnamed_5192, fragment_unnamed_5190, 1.0f);
									float fragment_unnamed_5196 = fragment_unnamed_1191 * (fragment_unnamed_5190 * fragment_unnamed_5192);
									float fragment_unnamed_5200 = fragment_unnamed_5176 * fragment_unnamed_5176;
									float fragment_unnamed_5203 = mad(mad(fragment_unnamed_5186, fragment_unnamed_5200, (-0.0f) - fragment_unnamed_5186), fragment_unnamed_5186, 1.0f);
									float fragment_unnamed_5219 = (fragment_unnamed_5200 * 0.15915493667125701904296875f) / max(mad(abs(fragment_unnamed_2325), fragment_unnamed_1211, fragment_unnamed_1113 * sqrt(mad(mad((-0.0f) - abs(fragment_unnamed_2325), fragment_unnamed_5200, abs(fragment_unnamed_2325)), abs(fragment_unnamed_2325), fragment_unnamed_5200))) * (fragment_unnamed_5203 * fragment_unnamed_5203), 1.1754943508222875079687365372222e-38f);
									float fragment_unnamed_5226 = ((-0.0f) - abs(fragment_unnamed_2325)) + 1.0f;
									float fragment_unnamed_5227 = fragment_unnamed_5226 * fragment_unnamed_5226;
									float fragment_unnamed_5230 = mad(fragment_unnamed_1096, fragment_unnamed_5178, fragment_unnamed_1096) + (-0.5f);
									float fragment_unnamed_5235 = ((mad(fragment_unnamed_5230, fragment_unnamed_1575, 1.0f) * mad(fragment_unnamed_5230, fragment_unnamed_5226 * (fragment_unnamed_5227 * fragment_unnamed_5227), 1.0f)) * fragment_unnamed_5177) * 0.307334959506988525390625f;
									fragment_unnamed_3059 = fragment_unnamed_5175 * (fragment_unnamed_4773 * (fragment_unnamed_5177 * (fragment_unnamed_5219 * mad(fragment_unnamed_1106, fragment_unnamed_5195, fragment_unnamed_5196))));
									fragment_unnamed_3061 = fragment_unnamed_5175 * (fragment_unnamed_4774 * (fragment_unnamed_5177 * (fragment_unnamed_5219 * mad(fragment_unnamed_1108, fragment_unnamed_5195, fragment_unnamed_5196))));
									fragment_unnamed_3063 = fragment_unnamed_5175 * (fragment_unnamed_4775 * (fragment_unnamed_5177 * (fragment_unnamed_5219 * mad(fragment_unnamed_1109, fragment_unnamed_5195, fragment_unnamed_5196))));
									fragment_unnamed_3065 = fragment_unnamed_5173 * (fragment_unnamed_4773 * fragment_unnamed_5235);
									fragment_unnamed_3067 = fragment_unnamed_5173 * (fragment_unnamed_4774 * fragment_unnamed_5235);
									fragment_unnamed_3069 = fragment_unnamed_5173 * (fragment_unnamed_4775 * fragment_unnamed_5235);
								}
								else
								{
									fragment_unnamed_3059 = asfloat(0u);
									fragment_unnamed_3061 = asfloat(0u);
									fragment_unnamed_3063 = asfloat(0u);
									fragment_unnamed_3065 = asfloat(0u);
									fragment_unnamed_3067 = asfloat(0u);
									fragment_unnamed_3069 = asfloat(0u);
								}
								fragment_unnamed_3058 = fragment_unnamed_3059;
								fragment_unnamed_3060 = fragment_unnamed_3061;
								fragment_unnamed_3062 = fragment_unnamed_3063;
								fragment_unnamed_3064 = fragment_unnamed_3065;
								fragment_unnamed_3066 = fragment_unnamed_3067;
								fragment_unnamed_3068 = fragment_unnamed_3069;
							}
							else
							{
								fragment_unnamed_3058 = asfloat(0u);
								fragment_unnamed_3060 = asfloat(0u);
								fragment_unnamed_3062 = asfloat(0u);
								fragment_unnamed_3064 = asfloat(0u);
								fragment_unnamed_3066 = asfloat(0u);
								fragment_unnamed_3068 = asfloat(0u);
							}
							fragment_unnamed_1609 = fragment_unnamed_3064 + fragment_unnamed_1608;
							fragment_unnamed_1611 = fragment_unnamed_3066 + fragment_unnamed_1610;
							fragment_unnamed_1613 = fragment_unnamed_3068 + fragment_unnamed_1612;
							fragment_unnamed_1615 = fragment_unnamed_3060 + fragment_unnamed_1614;
							fragment_unnamed_1617 = fragment_unnamed_3062 + fragment_unnamed_1616;
							fragment_unnamed_1619 = fragment_unnamed_3058 + fragment_unnamed_1618;
							fragment_unnamed_1606 = fragment_unnamed_1607;
							fragment_unnamed_1608 = fragment_unnamed_1609;
							fragment_unnamed_1610 = fragment_unnamed_1611;
							fragment_unnamed_1612 = fragment_unnamed_1613;
							fragment_unnamed_1614 = fragment_unnamed_1615;
							fragment_unnamed_1616 = fragment_unnamed_1617;
							fragment_unnamed_1618 = fragment_unnamed_1619;
							continue;
						}
					}
					if (ladder_phi_21)
					{
						break;
					}
					break;
				}
				uint4 fragment_unnamed_1692 = asuint(fragment_uniform_buffer_0[128u]);
				uint fragment_unnamed_1693 = fragment_unnamed_1692.y;
				uint4 fragment_unnamed_1700 = asuint(fragment_uniform_buffer_0[128u]);
				uint fragment_unnamed_1701 = fragment_unnamed_1700.x;
				uint4 fragment_unnamed_1706 = T4.Load(((((fragment_unnamed_1532 + (2u << (fragment_unnamed_1494 & 31u))) * fragment_unnamed_1693) + fragment_unnamed_288) * fragment_unnamed_1701) + fragment_unnamed_286);
				uint fragment_unnamed_1707 = fragment_unnamed_1706.x;
				uint fragment_unnamed_1708 = fragment_unnamed_1707 & 67108863u;
				uint fragment_unnamed_1709 = fragment_unnamed_1707 >> 26u;
				float4 fragment_unnamed_1710 = _SsrLightingTexture.Load(int4(uint3(fragment_unnamed_284, fragment_unnamed_285, 0u), 0u));
				float fragment_unnamed_1715 = fragment_unnamed_1710.w;
				float4 fragment_unnamed_1716 = _PrevExposureTexture.Load(int3(uint2(0u, 0u), 0u));
				float fragment_unnamed_1719 = fragment_unnamed_1716.x;
				float fragment_unnamed_1741 = asfloat((asuint(fragment_uniform_buffer_0[213u]).y != 0u) ? 1065353216u : asuint(1.0f / mad(fragment_unnamed_1719, fragment_uniform_buffer_0[118u].y, asfloat((((fragment_unnamed_1719 * fragment_uniform_buffer_0[118u].y) == 0.0f) ? 4294967295u : 0u) & 1065353216u))));
				float fragment_unnamed_1752 = asfloat((asuint(fragment_uniform_buffer_0[213u]).y != 0u) ? asuint(fragment_unnamed_1715) : 1065353216u);
				float fragment_unnamed_1756 = fragment_unnamed_1202 * (fragment_unnamed_1752 * (fragment_unnamed_1741 * fragment_unnamed_1710.x));
				float fragment_unnamed_1757 = fragment_unnamed_1203 * (fragment_unnamed_1752 * (fragment_unnamed_1741 * fragment_unnamed_1710.y));
				float fragment_unnamed_1758 = fragment_unnamed_1204 * (fragment_unnamed_1752 * (fragment_unnamed_1741 * fragment_unnamed_1710.z));
				float fragment_unnamed_1759 = asfloat(0u);
				float fragment_unnamed_1760 = asfloat(0u);
				float fragment_unnamed_1761 = asfloat(0u);
				float fragment_unnamed_1941;
				float fragment_unnamed_1943;
				float fragment_unnamed_1945;
				float fragment_unnamed_1947;
				float fragment_unnamed_1949;
				for (;;)
				{
					fragment_unnamed_1941 = fragment_unnamed_1715;
					fragment_unnamed_1943 = fragment_unnamed_1761;
					fragment_unnamed_1945 = fragment_unnamed_1756;
					fragment_unnamed_1947 = fragment_unnamed_1757;
					fragment_unnamed_1949 = fragment_unnamed_1758;
					float fragment_unnamed_1944;
					float fragment_unnamed_1942;
					float fragment_unnamed_1946;
					float fragment_unnamed_1948;
					float fragment_unnamed_1950;
					bool ladder_phi_33;
					for (;;)
					{
						if (asuint(fragment_unnamed_1943) >= fragment_unnamed_1709)
						{
							ladder_phi_33 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_2235 = asuint(fragment_unnamed_1943);
							uint4 fragment_unnamed_2237 = T3.Load(fragment_unnamed_1708 + fragment_unnamed_2235);
							uint fragment_unnamed_2238 = fragment_unnamed_2237.x;
							if (fragment_unnamed_2238 == 4294967295u)
							{
								ladder_phi_33 = false;
								break;
							}
							fragment_unnamed_1944 = asfloat(asuint(fragment_unnamed_1943) + 1u);
							if (!(fragment_unnamed_1941 < 1.0f))
							{
								fragment_unnamed_1942 = fragment_unnamed_1941;
								fragment_unnamed_1946 = fragment_unnamed_1945;
								fragment_unnamed_1948 = fragment_unnamed_1947;
								fragment_unnamed_1950 = fragment_unnamed_1949;
								fragment_unnamed_1941 = fragment_unnamed_1942;
								fragment_unnamed_1943 = fragment_unnamed_1944;
								fragment_unnamed_1945 = fragment_unnamed_1946;
								fragment_unnamed_1947 = fragment_unnamed_1948;
								fragment_unnamed_1949 = fragment_unnamed_1950;
								continue;
							}
							uint fragment_unnamed_3018 = fragment_unnamed_2238 * 72u;
							uint4 fragment_unnamed_3031 = uint4(T8.Load(fragment_unnamed_3018).x, T8.Load(fragment_unnamed_3018 + 1u).x, T8.Load(fragment_unnamed_3018 + 2u).x, T8.Load(fragment_unnamed_3018 + 3u).x);
							float fragment_unnamed_3034 = asfloat(fragment_unnamed_3031.y);
							float fragment_unnamed_3036 = asfloat(fragment_unnamed_3031.z);
							float fragment_unnamed_3038 = asfloat(fragment_unnamed_3031.w);
							float fragment_unnamed_3041;
							float fragment_unnamed_3042;
							float fragment_unnamed_3043;
							float fragment_unnamed_3044;
							if ((fragment_unnamed_827 & fragment_unnamed_3031.x) != 0u)
							{
								uint fragment_unnamed_3227 = (fragment_unnamed_2238 * 72u) + 4u;
								uint4 fragment_unnamed_3239 = uint4(T8.Load(fragment_unnamed_3227).x, T8.Load(fragment_unnamed_3227 + 1u).x, T8.Load(fragment_unnamed_3227 + 2u).x, T8.Load(fragment_unnamed_3227 + 3u).x);
								uint fragment_unnamed_3240 = fragment_unnamed_3239.x;
								float fragment_unnamed_3242 = asfloat(fragment_unnamed_3239.y);
								float fragment_unnamed_3244 = asfloat(fragment_unnamed_3239.z);
								float fragment_unnamed_3246 = asfloat(fragment_unnamed_3239.w);
								uint fragment_unnamed_3248 = (fragment_unnamed_2238 * 72u) + 8u;
								uint4 fragment_unnamed_3260 = uint4(T8.Load(fragment_unnamed_3248).x, T8.Load(fragment_unnamed_3248 + 1u).x, T8.Load(fragment_unnamed_3248 + 2u).x, T8.Load(fragment_unnamed_3248 + 3u).x);
								float fragment_unnamed_3262 = asfloat(fragment_unnamed_3260.x);
								uint fragment_unnamed_3270 = (fragment_unnamed_2238 * 72u) + 12u;
								uint4 fragment_unnamed_3282 = uint4(T8.Load(fragment_unnamed_3270).x, T8.Load(fragment_unnamed_3270 + 1u).x, T8.Load(fragment_unnamed_3270 + 2u).x, T8.Load(fragment_unnamed_3270 + 3u).x);
								float fragment_unnamed_3284 = asfloat(fragment_unnamed_3282.x);
								float fragment_unnamed_3286 = asfloat(fragment_unnamed_3282.y);
								float fragment_unnamed_3288 = asfloat(fragment_unnamed_3282.z);
								uint fragment_unnamed_3291 = (fragment_unnamed_2238 * 72u) + 16u;
								uint4 fragment_unnamed_3303 = uint4(T8.Load(fragment_unnamed_3291).x, T8.Load(fragment_unnamed_3291 + 1u).x, T8.Load(fragment_unnamed_3291 + 2u).x, T8.Load(fragment_unnamed_3291 + 3u).x);
								float fragment_unnamed_3306 = asfloat(fragment_unnamed_3303.x);
								float fragment_unnamed_3308 = asfloat(fragment_unnamed_3303.y);
								uint fragment_unnamed_3311 = (fragment_unnamed_2238 * 72u) + 20u;
								uint4 fragment_unnamed_3323 = uint4(T8.Load(fragment_unnamed_3311).x, T8.Load(fragment_unnamed_3311 + 1u).x, T8.Load(fragment_unnamed_3311 + 2u).x, T8.Load(fragment_unnamed_3311 + 3u).x);
								float fragment_unnamed_3329 = asfloat(fragment_unnamed_3323.x);
								uint fragment_unnamed_3333 = (fragment_unnamed_2238 * 72u) + 24u;
								uint4 fragment_unnamed_3345 = uint4(T8.Load(fragment_unnamed_3333).x, T8.Load(fragment_unnamed_3333 + 1u).x, T8.Load(fragment_unnamed_3333 + 2u).x, T8.Load(fragment_unnamed_3333 + 3u).x);
								float fragment_unnamed_3347 = asfloat(fragment_unnamed_3345.x);
								float fragment_unnamed_3349 = asfloat(fragment_unnamed_3345.y);
								float fragment_unnamed_3351 = asfloat(fragment_unnamed_3345.z);
								uint fragment_unnamed_3354 = (fragment_unnamed_2238 * 72u) + 28u;
								uint4 fragment_unnamed_3366 = uint4(T8.Load(fragment_unnamed_3354).x, T8.Load(fragment_unnamed_3354 + 1u).x, T8.Load(fragment_unnamed_3354 + 2u).x, T8.Load(fragment_unnamed_3354 + 3u).x);
								float fragment_unnamed_3369 = asfloat(fragment_unnamed_3366.x);
								float fragment_unnamed_3371 = asfloat(fragment_unnamed_3366.y);
								uint fragment_unnamed_3375 = (fragment_unnamed_2238 * 72u) + 32u;
								uint4 fragment_unnamed_3387 = uint4(T8.Load(fragment_unnamed_3375).x, T8.Load(fragment_unnamed_3375 + 1u).x, T8.Load(fragment_unnamed_3375 + 2u).x, T8.Load(fragment_unnamed_3375 + 3u).x);
								float fragment_unnamed_3390 = asfloat(fragment_unnamed_3387.y);
								float fragment_unnamed_3392 = asfloat(fragment_unnamed_3387.z);
								float fragment_unnamed_3394 = asfloat(fragment_unnamed_3387.w);
								uint fragment_unnamed_3397 = (fragment_unnamed_2238 * 72u) + 36u;
								uint4 fragment_unnamed_3409 = uint4(T8.Load(fragment_unnamed_3397).x, T8.Load(fragment_unnamed_3397 + 1u).x, T8.Load(fragment_unnamed_3397 + 2u).x, T8.Load(fragment_unnamed_3397 + 3u).x);
								float fragment_unnamed_3411 = asfloat(fragment_unnamed_3409.x);
								uint fragment_unnamed_3418 = (fragment_unnamed_2238 * 72u) + 40u;
								uint4 fragment_unnamed_3430 = uint4(T8.Load(fragment_unnamed_3418).x, T8.Load(fragment_unnamed_3418 + 1u).x, T8.Load(fragment_unnamed_3418 + 2u).x, T8.Load(fragment_unnamed_3418 + 3u).x);
								float fragment_unnamed_3432 = asfloat(fragment_unnamed_3430.z);
								uint fragment_unnamed_3439 = (fragment_unnamed_2238 * 72u) + 52u;
								uint4 fragment_unnamed_3451 = uint4(T8.Load(fragment_unnamed_3439).x, T8.Load(fragment_unnamed_3439 + 1u).x, T8.Load(fragment_unnamed_3439 + 2u).x, T8.Load(fragment_unnamed_3439 + 3u).x);
								float fragment_unnamed_3457 = asfloat(fragment_unnamed_3451.w);
								uint fragment_unnamed_3459 = (fragment_unnamed_2238 * 72u) + 56u;
								uint4 fragment_unnamed_3471 = uint4(T8.Load(fragment_unnamed_3459).x, T8.Load(fragment_unnamed_3459 + 1u).x, T8.Load(fragment_unnamed_3459 + 2u).x, T8.Load(fragment_unnamed_3459 + 3u).x);
								float fragment_unnamed_3473 = asfloat(fragment_unnamed_3471.x);
								uint fragment_unnamed_3478 = fragment_unnamed_3471.w;
								bool fragment_unnamed_3479 = int(fragment_unnamed_3478) >= int(0u);
								float fragment_unnamed_3481 = max(fragment_unnamed_1110, 9.9999997473787516355514526367188e-05f);
								float fragment_unnamed_3482 = fragment_unnamed_1096 * fragment_unnamed_1096;
								float fragment_unnamed_3484 = mad((-0.0f) - fragment_unnamed_1096, fragment_unnamed_1096, 1.0f);
								float fragment_unnamed_3491 = clamp(mad(fragment_unnamed_3484, fragment_unnamed_3484, fragment_unnamed_3484 * (fragment_unnamed_3481 * fragment_unnamed_3481)), 0.0f, 1.0f) * mad(fragment_unnamed_1096, fragment_unnamed_1096, sqrt(fragment_unnamed_3484));
								float fragment_unnamed_3498 = mad(fragment_unnamed_3491, mad((-0.0f) - fragment_unnamed_812, fragment_unnamed_819, fragment_unnamed_1220), fragment_unnamed_820);
								float fragment_unnamed_3499 = mad(fragment_unnamed_3491, mad((-0.0f) - fragment_unnamed_813, fragment_unnamed_819, fragment_unnamed_1221), fragment_unnamed_821);
								float fragment_unnamed_3500 = mad(fragment_unnamed_3491, mad((-0.0f) - fragment_unnamed_814, fragment_unnamed_819, fragment_unnamed_1222), fragment_unnamed_822);
								float fragment_unnamed_3502 = min(fragment_unnamed_3482 * fragment_unnamed_3482, 1.0f);
								float fragment_unnamed_3506 = min((fragment_unnamed_3502 * fragment_unnamed_3502) * mad(fragment_unnamed_3502, -2.0f, 3.0f), 1.0f);
								float fragment_unnamed_3523 = asfloat(fragment_unnamed_3479 ? asuint(mad(fragment_unnamed_3506, fragment_unnamed_1220 + ((-0.0f) - fragment_unnamed_3498), fragment_unnamed_3498)) : asuint(fragment_unnamed_1220));
								float fragment_unnamed_3525 = asfloat(fragment_unnamed_3479 ? asuint(mad(fragment_unnamed_3506, fragment_unnamed_1221 + ((-0.0f) - fragment_unnamed_3499), fragment_unnamed_3499)) : asuint(fragment_unnamed_1221));
								float fragment_unnamed_3527 = asfloat(fragment_unnamed_3479 ? asuint(mad(fragment_unnamed_3506, fragment_unnamed_1222 + ((-0.0f) - fragment_unnamed_3500), fragment_unnamed_3500)) : asuint(fragment_unnamed_1222));
								float fragment_unnamed_3537 = ((-0.0f) - asfloat(fragment_unnamed_3323.y)) + fragment_input_5.x;
								float fragment_unnamed_3538 = ((-0.0f) - asfloat(fragment_unnamed_3323.z)) + fragment_input_5.y;
								float fragment_unnamed_3539 = ((-0.0f) - asfloat(fragment_unnamed_3323.w)) + fragment_input_5.z;
								float fragment_unnamed_3540 = asfloat(fragment_unnamed_3366.z);
								float fragment_unnamed_3541 = asfloat(fragment_unnamed_3366.w);
								float fragment_unnamed_3542 = asfloat(fragment_unnamed_3387.x);
								float fragment_unnamed_3543 = dot(float3(fragment_unnamed_3537, fragment_unnamed_3538, fragment_unnamed_3539), float3(fragment_unnamed_3540, fragment_unnamed_3541, fragment_unnamed_3542));
								float fragment_unnamed_3546 = asfloat(fragment_unnamed_3345.w);
								float fragment_unnamed_3547 = dot(float3(fragment_unnamed_3537, fragment_unnamed_3538, fragment_unnamed_3539), float3(fragment_unnamed_3546, fragment_unnamed_3369, fragment_unnamed_3371));
								float fragment_unnamed_3550 = dot(float3(fragment_unnamed_3537, fragment_unnamed_3538, fragment_unnamed_3539), float3(fragment_unnamed_3347, fragment_unnamed_3349, fragment_unnamed_3351));
								float fragment_unnamed_3562 = ((-0.0f) - asfloat(fragment_unnamed_3260.y)) + fragment_input_5.x;
								float fragment_unnamed_3563 = ((-0.0f) - asfloat(fragment_unnamed_3260.z)) + fragment_input_5.y;
								float fragment_unnamed_3564 = ((-0.0f) - asfloat(fragment_unnamed_3260.w)) + fragment_input_5.z;
								float fragment_unnamed_3565 = asfloat(fragment_unnamed_3303.z);
								float fragment_unnamed_3566 = asfloat(fragment_unnamed_3303.w);
								float fragment_unnamed_3567 = dot(float3(fragment_unnamed_3562, fragment_unnamed_3563, fragment_unnamed_3564), float3(fragment_unnamed_3565, fragment_unnamed_3566, fragment_unnamed_3329));
								float fragment_unnamed_3570 = asfloat(fragment_unnamed_3282.w);
								float fragment_unnamed_3571 = dot(float3(fragment_unnamed_3562, fragment_unnamed_3563, fragment_unnamed_3564), float3(fragment_unnamed_3570, fragment_unnamed_3306, fragment_unnamed_3308));
								float fragment_unnamed_3574 = dot(float3(fragment_unnamed_3562, fragment_unnamed_3563, fragment_unnamed_3564), float3(fragment_unnamed_3284, fragment_unnamed_3286, fragment_unnamed_3288));
								float fragment_unnamed_3577 = dot(float3(fragment_unnamed_3523, fragment_unnamed_3525, fragment_unnamed_3527), float3(fragment_unnamed_3565, fragment_unnamed_3566, fragment_unnamed_3329));
								float fragment_unnamed_3580 = dot(float3(fragment_unnamed_3523, fragment_unnamed_3525, fragment_unnamed_3527), float3(fragment_unnamed_3570, fragment_unnamed_3306, fragment_unnamed_3308));
								float fragment_unnamed_3583 = dot(float3(fragment_unnamed_3523, fragment_unnamed_3525, fragment_unnamed_3527), float3(fragment_unnamed_3284, fragment_unnamed_3286, fragment_unnamed_3288));
								float fragment_unnamed_4326;
								float fragment_unnamed_4328;
								float fragment_unnamed_4330;
								float fragment_unnamed_4332;
								float fragment_unnamed_4334;
								if (fragment_unnamed_3240 == 2u)
								{
									float fragment_unnamed_3890 = dot(float3(fragment_unnamed_3577, fragment_unnamed_3580, fragment_unnamed_3583), float3(fragment_unnamed_3567, fragment_unnamed_3571, fragment_unnamed_3574));
									float fragment_unnamed_3893 = fragment_unnamed_3890 + fragment_unnamed_3890;
									float fragment_unnamed_3906 = abs(mad((-0.0f) - fragment_unnamed_3890, 2.0f, sqrt(mad(fragment_unnamed_3893, fragment_unnamed_3893, (-0.0f) - (mad((-0.0f) - fragment_unnamed_3242, fragment_unnamed_3242, dot(float3(fragment_unnamed_3567, fragment_unnamed_3571, fragment_unnamed_3574), float3(fragment_unnamed_3567, fragment_unnamed_3571, fragment_unnamed_3574))) * 4.0f))))) * 0.5f;
									float fragment_unnamed_3915 = max(fragment_unnamed_3262, asfloat((2139095040u < (asuint(fragment_unnamed_3906) & 2147483647u)) ? 3212836864u : asuint(fragment_unnamed_3906)));
									float fragment_unnamed_3934 = sqrt(dot(float3(fragment_unnamed_3543, fragment_unnamed_3547, fragment_unnamed_3550), float3(fragment_unnamed_3543, fragment_unnamed_3547, fragment_unnamed_3550)));
									float fragment_unnamed_3957 = ((-0.0f) - fragment_unnamed_3034) + fragment_input_5.x;
									float fragment_unnamed_3958 = ((-0.0f) - fragment_unnamed_3036) + fragment_input_5.y;
									float fragment_unnamed_3959 = ((-0.0f) - fragment_unnamed_3038) + fragment_input_5.z;
									float fragment_unnamed_3963 = rsqrt(dot(float3(fragment_unnamed_3957, fragment_unnamed_3958, fragment_unnamed_3959), float3(fragment_unnamed_3957, fragment_unnamed_3958, fragment_unnamed_3959)));
									fragment_unnamed_4326 = fragment_unnamed_3915;
									fragment_unnamed_4328 = asfloat(((fragment_unnamed_3390 + ((-0.0f) - fragment_unnamed_3432)) >= fragment_unnamed_3934) ? 1065353216u : asuint(clamp(mad(dot(float3(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822), float3(fragment_unnamed_3963 * fragment_unnamed_3957, fragment_unnamed_3963 * fragment_unnamed_3958, fragment_unnamed_3963 * fragment_unnamed_3959)), -2.5f, 1.5f), 0.0f, 1.0f))) * max(((-0.0f) - (max(fragment_unnamed_3934 + ((-0.0f) - (fragment_unnamed_3390 + ((-0.0f) - fragment_unnamed_3411))), 0.0f) / max(fragment_unnamed_3411, 9.9999997473787516355514526367188e-05f))) + 1.0f, 0.0f);
									fragment_unnamed_4330 = ((-0.0f) - fragment_unnamed_3034) + mad(fragment_unnamed_3915, fragment_unnamed_3523, fragment_input_5.x);
									fragment_unnamed_4332 = ((-0.0f) - fragment_unnamed_3036) + mad(fragment_unnamed_3915, fragment_unnamed_3525, fragment_input_5.y);
									fragment_unnamed_4334 = ((-0.0f) - fragment_unnamed_3038) + mad(fragment_unnamed_3915, fragment_unnamed_3527, fragment_input_5.z);
								}
								else
								{
									float fragment_unnamed_4327;
									float fragment_unnamed_4329;
									float fragment_unnamed_4331;
									float fragment_unnamed_4333;
									float fragment_unnamed_4335;
									if (fragment_unnamed_3240 == 1u)
									{
										uint fragment_unnamed_4369 = (fragment_unnamed_2238 * 72u) + 44u;
										uint4 fragment_unnamed_4381 = uint4(T8.Load(fragment_unnamed_4369).x, T8.Load(fragment_unnamed_4369 + 1u).x, T8.Load(fragment_unnamed_4369 + 2u).x, T8.Load(fragment_unnamed_4369 + 3u).x);
										uint fragment_unnamed_4390 = (fragment_unnamed_2238 * 72u) + 48u;
										uint4 fragment_unnamed_4402 = uint4(T8.Load(fragment_unnamed_4390).x, T8.Load(fragment_unnamed_4390 + 1u).x, T8.Load(fragment_unnamed_4390 + 2u).x, T8.Load(fragment_unnamed_4390 + 3u).x);
										float fragment_unnamed_4411 = dot(float3(fragment_unnamed_3523, fragment_unnamed_3525, fragment_unnamed_3527), float3(fragment_unnamed_3540, fragment_unnamed_3541, fragment_unnamed_3542));
										float fragment_unnamed_4414 = dot(float3(fragment_unnamed_3523, fragment_unnamed_3525, fragment_unnamed_3527), float3(fragment_unnamed_3546, fragment_unnamed_3369, fragment_unnamed_3371));
										float fragment_unnamed_4417 = dot(float3(fragment_unnamed_3523, fragment_unnamed_3525, fragment_unnamed_3527), float3(fragment_unnamed_3347, fragment_unnamed_3349, fragment_unnamed_3351));
										float fragment_unnamed_4423 = rsqrt(dot(float3(fragment_unnamed_4411, fragment_unnamed_4414, fragment_unnamed_4417), float3(fragment_unnamed_4411, fragment_unnamed_4414, fragment_unnamed_4417)));
										float fragment_unnamed_4424 = fragment_unnamed_4423 * fragment_unnamed_4411;
										float fragment_unnamed_4425 = fragment_unnamed_4423 * fragment_unnamed_4414;
										float fragment_unnamed_4426 = fragment_unnamed_4423 * fragment_unnamed_4417;
										float fragment_unnamed_4427 = 1.0f / fragment_unnamed_3577;
										float fragment_unnamed_4428 = 1.0f / fragment_unnamed_3580;
										float fragment_unnamed_4429 = 1.0f / fragment_unnamed_3583;
										float fragment_unnamed_4468 = max(fragment_unnamed_3262, min(asfloat((0.0f < fragment_unnamed_3583) ? asuint(fragment_unnamed_4429 * (fragment_unnamed_3246 + ((-0.0f) - fragment_unnamed_3574))) : asuint(fragment_unnamed_4429 * (((-0.0f) - fragment_unnamed_3246) + ((-0.0f) - fragment_unnamed_3574)))), min(asfloat((0.0f < fragment_unnamed_3580) ? asuint(fragment_unnamed_4428 * (fragment_unnamed_3244 + ((-0.0f) - fragment_unnamed_3571))) : asuint(fragment_unnamed_4428 * (((-0.0f) - fragment_unnamed_3244) + ((-0.0f) - fragment_unnamed_3571)))), asfloat((0.0f < fragment_unnamed_3577) ? asuint(fragment_unnamed_4427 * (fragment_unnamed_3242 + ((-0.0f) - fragment_unnamed_3567))) : asuint(fragment_unnamed_4427 * (((-0.0f) - fragment_unnamed_3242) + ((-0.0f) - fragment_unnamed_3567)))))));
										float fragment_unnamed_4484 = fragment_unnamed_3390 + fragment_unnamed_3543;
										float fragment_unnamed_4485 = fragment_unnamed_3392 + fragment_unnamed_3547;
										float fragment_unnamed_4486 = fragment_unnamed_3394 + fragment_unnamed_3550;
										float fragment_unnamed_4490 = fragment_unnamed_3390 + ((-0.0f) - fragment_unnamed_3543);
										float fragment_unnamed_4491 = fragment_unnamed_3392 + ((-0.0f) - fragment_unnamed_3547);
										float fragment_unnamed_4492 = fragment_unnamed_3394 + ((-0.0f) - fragment_unnamed_3550);
										float fragment_unnamed_4553 = ((-0.0f) - fragment_unnamed_3034) + fragment_input_5.x;
										float fragment_unnamed_4554 = ((-0.0f) - fragment_unnamed_3036) + fragment_input_5.y;
										float fragment_unnamed_4555 = ((-0.0f) - fragment_unnamed_3038) + fragment_input_5.z;
										float fragment_unnamed_4559 = rsqrt(dot(float3(fragment_unnamed_4553, fragment_unnamed_4554, fragment_unnamed_4555), float3(fragment_unnamed_4553, fragment_unnamed_4554, fragment_unnamed_4555)));
										float fragment_unnamed_4571 = asfloat(((((((fragment_unnamed_4486 / max(asfloat(fragment_unnamed_4381.w), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & ((((fragment_unnamed_4485 / max(asfloat(fragment_unnamed_4381.z), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_4484 / max(asfloat(fragment_unnamed_4381.y), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u))) & ((((fragment_unnamed_4492 / max(asfloat(fragment_unnamed_4381.x), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & ((((fragment_unnamed_4491 / max(asfloat(fragment_unnamed_3430.w), 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u) & (((fragment_unnamed_4490 / max(fragment_unnamed_3432, 9.9999997473787516355514526367188e-05f)) >= 1.0f) ? 4294967295u : 0u)))) != 0u) ? 1065353216u : asuint(clamp(mad(dot(float3(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822), float3(fragment_unnamed_4553 * fragment_unnamed_4559, fragment_unnamed_4554 * fragment_unnamed_4559, fragment_unnamed_4555 * fragment_unnamed_4559)), -2.5f, 1.5f), 0.0f, 1.0f)));
										fragment_unnamed_4327 = fragment_unnamed_4468;
										fragment_unnamed_4329 = (clamp(min(min(fragment_unnamed_4486 / max(asfloat(fragment_unnamed_3430.y), 9.9999997473787516355514526367188e-05f), min(fragment_unnamed_4485 / max(asfloat(fragment_unnamed_3430.x), 9.9999997473787516355514526367188e-05f), fragment_unnamed_4484 / max(asfloat(fragment_unnamed_3409.w), 9.9999997473787516355514526367188e-05f))), min(fragment_unnamed_4492 / max(asfloat(fragment_unnamed_3409.z), 9.9999997473787516355514526367188e-05f), min(fragment_unnamed_4491 / max(asfloat(fragment_unnamed_3409.y), 9.9999997473787516355514526367188e-05f), fragment_unnamed_4490 / max(fragment_unnamed_3411, 9.9999997473787516355514526367188e-05f)))), 0.0f, 1.0f) * fragment_unnamed_4571) * min((clamp(asfloat(fragment_unnamed_4402.z) * mad(fragment_unnamed_4426, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4426, -4.0f, -1.0f) * asfloat(fragment_unnamed_3451.y), 0.0f, 1.0f)) + ((clamp(asfloat(fragment_unnamed_4402.y) * mad(fragment_unnamed_4425, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4425, -4.0f, -1.0f) * asfloat(fragment_unnamed_3451.x), 0.0f, 1.0f)) + (clamp(asfloat(fragment_unnamed_4402.x) * mad(fragment_unnamed_4424, 4.0f, -1.0f), 0.0f, 1.0f) + clamp(mad(fragment_unnamed_4424, -4.0f, -1.0f) * asfloat(fragment_unnamed_4402.w), 0.0f, 1.0f))), 1.0f);
										fragment_unnamed_4331 = ((-0.0f) - fragment_unnamed_3034) + mad(fragment_unnamed_4468, fragment_unnamed_3523, fragment_input_5.x);
										fragment_unnamed_4333 = ((-0.0f) - fragment_unnamed_3036) + mad(fragment_unnamed_4468, fragment_unnamed_3525, fragment_input_5.y);
										fragment_unnamed_4335 = ((-0.0f) - fragment_unnamed_3038) + mad(fragment_unnamed_4468, fragment_unnamed_3527, fragment_input_5.z);
									}
									else
									{
										fragment_unnamed_4327 = asfloat(0u);
										fragment_unnamed_4329 = asfloat(1065353216u);
										fragment_unnamed_4331 = fragment_unnamed_3523;
										fragment_unnamed_4333 = fragment_unnamed_3525;
										fragment_unnamed_4335 = fragment_unnamed_3527;
									}
									fragment_unnamed_4326 = fragment_unnamed_4327;
									fragment_unnamed_4328 = fragment_unnamed_4329;
									fragment_unnamed_4330 = fragment_unnamed_4331;
									fragment_unnamed_4332 = fragment_unnamed_4333;
									fragment_unnamed_4334 = fragment_unnamed_4335;
								}
								float fragment_unnamed_4340 = asfloat(fragment_unnamed_3451.z) * ((fragment_unnamed_4328 * fragment_unnamed_4328) * mad((-0.0f) - fragment_unnamed_4328, 2.0f, 3.0f));
								float fragment_unnamed_4348 = min(fragment_unnamed_1096, max(fragment_unnamed_1096 * (fragment_unnamed_4326 / sqrt(dot(float3(fragment_unnamed_4330, fragment_unnamed_4332, fragment_unnamed_4334), float3(fragment_unnamed_4330, fragment_unnamed_4332, fragment_unnamed_4334)))), 0.0f));
								float fragment_unnamed_4358 = asfloat(fragment_unnamed_3479 ? asuint(mad(asfloat(fragment_unnamed_3471.z), ((-0.0f) - fragment_unnamed_1096) + mad(fragment_unnamed_1096, fragment_unnamed_1096 + ((-0.0f) - fragment_unnamed_4348), fragment_unnamed_4348), fragment_unnamed_1096)) : asuint(fragment_unnamed_1096));
								float fragment_unnamed_4362 = asfloat(fragment_unnamed_3471.y) * (fragment_unnamed_4358 * mad((-0.0f) - fragment_unnamed_4358, 0.699999988079071044921875f, 1.7000000476837158203125f));
								float fragment_unnamed_4363 = fragment_unnamed_4362 * 6.0f;
								uint fragment_unnamed_4366 = uint(abs(int(fragment_unnamed_3478))) + 4294967295u;
								float fragment_unnamed_5777;
								float fragment_unnamed_5779;
								float fragment_unnamed_5781;
								float fragment_unnamed_5783;
								if ((fragment_unnamed_3479 ? 4294967295u : 0u) == 0u)
								{
									uint fragment_unnamed_5019 = fragment_unnamed_4366 << 2u;
									uint fragment_unnamed_5020 = fragment_unnamed_5019 + 1u;
									uint fragment_unnamed_5041 = fragment_unnamed_5019 + 2u;
									uint fragment_unnamed_5052 = fragment_unnamed_5019 + 3u;
									float fragment_unnamed_5062 = mad(fragment_uniform_buffer_2[fragment_unnamed_5041].w, fragment_unnamed_4334, mad(fragment_uniform_buffer_2[fragment_unnamed_5019].w, fragment_unnamed_4330, fragment_unnamed_4332 * fragment_uniform_buffer_2[fragment_unnamed_5020].w)) + fragment_uniform_buffer_2[fragment_unnamed_5052].w;
									float fragment_unnamed_5063 = (mad(fragment_uniform_buffer_2[fragment_unnamed_5041].x, fragment_unnamed_4334, mad(fragment_uniform_buffer_2[fragment_unnamed_5019].x, fragment_unnamed_4330, fragment_unnamed_4332 * fragment_uniform_buffer_2[fragment_unnamed_5020].x)) + fragment_uniform_buffer_2[fragment_unnamed_5052].x) * 1.0f;
									float fragment_unnamed_5064 = (mad(fragment_uniform_buffer_2[fragment_unnamed_5041].y, fragment_unnamed_4334, mad(fragment_uniform_buffer_2[fragment_unnamed_5019].y, fragment_unnamed_4330, fragment_unnamed_4332 * fragment_uniform_buffer_2[fragment_unnamed_5020].y)) + fragment_uniform_buffer_2[fragment_unnamed_5052].y) * (-1.0f);
									uint fragment_unnamed_5076 = ((abs((mad(fragment_uniform_buffer_2[fragment_unnamed_5041].z, fragment_unnamed_4334, mad(fragment_uniform_buffer_2[fragment_unnamed_5019].z, fragment_unnamed_4330, fragment_unnamed_4332 * fragment_uniform_buffer_2[fragment_unnamed_5020].z)) + fragment_uniform_buffer_2[fragment_unnamed_5052].z) * 1.0f) < fragment_unnamed_5062) ? 4294967295u : 0u) & (((abs(fragment_unnamed_5064) < fragment_unnamed_5062) ? 4294967295u : 0u) & ((abs(fragment_unnamed_5063) < fragment_unnamed_5062) ? 4294967295u : 0u));
									float fragment_unnamed_5778;
									float fragment_unnamed_5780;
									float fragment_unnamed_5782;
									float fragment_unnamed_5784;
									if (fragment_unnamed_5076 != 0u)
									{
										float fragment_unnamed_5637 = 1.0f / fragment_unnamed_5062;
										float fragment_unnamed_5640 = mad(fragment_unnamed_5637 * fragment_unnamed_5063, 0.5f, 0.5f);
										float fragment_unnamed_5641 = mad(fragment_unnamed_5637 * fragment_unnamed_5064, 0.5f, 0.5f);
										uint fragment_unnamed_5649 = fragment_unnamed_4366 + 64u;
										uint fragment_unnamed_5661 = fragment_unnamed_4366 + 64u;
										float fragment_unnamed_5669 = exp2(ceil(fragment_unnamed_4363));
										float fragment_unnamed_5674 = fragment_unnamed_5669 * fragment_uniform_buffer_0[125u].z;
										float fragment_unnamed_5675 = fragment_unnamed_5669 * fragment_uniform_buffer_0[125u].w;
										uint fragment_unnamed_5676 = fragment_unnamed_4366 + 64u;
										uint fragment_unnamed_5683 = fragment_unnamed_4366 + 64u;
										uint fragment_unnamed_5688 = fragment_unnamed_4366 + 64u;
										float4 fragment_unnamed_5706 = _ReflectionAtlas.SampleLevel(S1, float3(min(mad((-0.0f) - fragment_unnamed_5674, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5683].x + fragment_uniform_buffer_2[fragment_unnamed_5688].z), max(mad(fragment_unnamed_5674, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5676].z), mad(fragment_unnamed_5640, ((-0.0f) - fragment_uniform_buffer_0[125u].x) + fragment_uniform_buffer_2[fragment_unnamed_5649].x, mad(fragment_uniform_buffer_0[125u].x, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5661].z)))), min(mad((-0.0f) - fragment_unnamed_5675, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5683].y + fragment_uniform_buffer_2[fragment_unnamed_5688].w), max(mad(fragment_unnamed_5675, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5676].w), mad(fragment_unnamed_5641, ((-0.0f) - fragment_uniform_buffer_0[125u].y) + fragment_uniform_buffer_2[fragment_unnamed_5649].y, mad(fragment_uniform_buffer_0[125u].y, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5661].w)))), fragment_unnamed_1760), fragment_unnamed_4363);
										float fragment_unnamed_5741 = min(abs(mad((-0.0f) - fragment_unnamed_282, fragment_uniform_buffer_0[50u].z, fragment_unnamed_5640)) * 100.0f, 1.0f);
										float fragment_unnamed_5742 = min(abs(mad((-0.0f) - fragment_unnamed_283, fragment_uniform_buffer_0[50u].w, fragment_unnamed_5641)) * 100.0f, 1.0f);
										fragment_unnamed_5778 = (asfloat((((((fragment_unnamed_295 < fragment_unnamed_5641) ? 4294967295u : 0u) & 1u) ^ (((fragment_unnamed_5641 < 0.5f) ? 4294967295u : 0u) & 1u)) != 0u) ? asuint(mad(mad((-0.0f) - fragment_unnamed_5742, 2.0f, 3.0f) * (fragment_unnamed_5742 * fragment_unnamed_5742), min(mad((-0.0f) - abs(mad(clamp(fragment_unnamed_5641, 0.0f, 1.0f), 2.0f, -1.0f)), 2.0f, 2.0f), 1.0f) + (-1.0f), 1.0f)) : 1065353216u) * asfloat((((((fragment_unnamed_294 < fragment_unnamed_5640) ? 4294967295u : 0u) & 1u) ^ (((fragment_unnamed_5640 < 0.5f) ? 4294967295u : 0u) & 1u)) != 0u) ? asuint(mad(mad((-0.0f) - fragment_unnamed_5741, 2.0f, 3.0f) * (fragment_unnamed_5741 * fragment_unnamed_5741), min(mad((-0.0f) - abs(mad(clamp(fragment_unnamed_5640, 0.0f, 1.0f), 2.0f, -1.0f)), 2.0f, 2.0f), 1.0f) + (-1.0f), 1.0f)) : 1065353216u)) * asfloat(fragment_unnamed_5076 & 1065353216u);
										fragment_unnamed_5780 = fragment_unnamed_5706.x;
										fragment_unnamed_5782 = fragment_unnamed_5706.y;
										fragment_unnamed_5784 = fragment_unnamed_5706.z;
									}
									else
									{
										fragment_unnamed_5778 = asfloat(0u);
										fragment_unnamed_5780 = asfloat(0u);
										fragment_unnamed_5782 = asfloat(0u);
										fragment_unnamed_5784 = asfloat(0u);
									}
									fragment_unnamed_5777 = fragment_unnamed_5778;
									fragment_unnamed_5779 = fragment_unnamed_5780;
									fragment_unnamed_5781 = fragment_unnamed_5782;
									fragment_unnamed_5783 = fragment_unnamed_5784;
								}
								else
								{
									float fragment_unnamed_5085 = 1.0f / max(dot(float3(abs(fragment_unnamed_4330), abs(fragment_unnamed_4332), abs(fragment_unnamed_4334)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
									float fragment_unnamed_5090 = clamp((-0.0f) - (fragment_unnamed_5085 * fragment_unnamed_4334), 0.0f, 1.0f);
									float fragment_unnamed_5093 = (-0.0f) - fragment_unnamed_5090;
									float fragment_unnamed_5109 = exp2(max(mad(fragment_unnamed_4362, 6.0f, (-0.0f) - fragment_uniform_buffer_0[124u].z), 0.0f));
									uint fragment_unnamed_5122 = fragment_unnamed_4366 + 80u;
									uint fragment_unnamed_5130 = fragment_unnamed_4366 + 80u;
									float4 fragment_unnamed_5140 = _ReflectionAtlas.SampleLevel(S1, float3(mad(clamp(mad(mad(fragment_unnamed_4330, fragment_unnamed_5085, ((fragment_unnamed_5085 * fragment_unnamed_4330) >= 0.0f) ? fragment_unnamed_5090 : fragment_unnamed_5093), 0.5f, 0.5f), 0.0f, 1.0f), mad((-0.0f) - fragment_uniform_buffer_0[124u].x, fragment_unnamed_5109, fragment_uniform_buffer_2[fragment_unnamed_5122].x), mad(fragment_unnamed_5109 * fragment_uniform_buffer_0[124u].x, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5130].z)), mad(clamp(mad(mad(fragment_unnamed_4332, fragment_unnamed_5085, ((fragment_unnamed_5085 * fragment_unnamed_4332) >= 0.0f) ? fragment_unnamed_5090 : fragment_unnamed_5093), 0.5f, 0.5f), 0.0f, 1.0f), mad((-0.0f) - fragment_uniform_buffer_0[124u].y, fragment_unnamed_5109, fragment_uniform_buffer_2[fragment_unnamed_5122].y), mad(fragment_unnamed_5109 * fragment_uniform_buffer_0[124u].y, 0.5f, fragment_uniform_buffer_2[fragment_unnamed_5130].w)), fragment_unnamed_1759), fragment_unnamed_4363);
									fragment_unnamed_5777 = asfloat(1065353216u);
									fragment_unnamed_5779 = fragment_unnamed_5140.x;
									fragment_unnamed_5781 = fragment_unnamed_5140.y;
									fragment_unnamed_5783 = fragment_unnamed_5140.z;
								}
								float fragment_unnamed_5794 = mad(fragment_unnamed_4340, fragment_unnamed_5777, fragment_unnamed_1941);
								float fragment_unnamed_3587 = clamp(fragment_unnamed_5794, 0.0f, 1.0f);
								float fragment_unnamed_5799 = mad(fragment_unnamed_4340, fragment_unnamed_5777, (-0.0f) - clamp(((-0.0f) - fragment_unnamed_3587) + fragment_unnamed_5794, 0.0f, 1.0f));
								fragment_unnamed_3041 = fragment_unnamed_3587;
								fragment_unnamed_3042 = mad(fragment_unnamed_5799 * (fragment_unnamed_1202 * (fragment_unnamed_3473 * min(fragment_unnamed_5779, 65504.0f))), fragment_unnamed_3457, fragment_unnamed_1945);
								fragment_unnamed_3043 = mad(fragment_unnamed_5799 * (fragment_unnamed_1203 * (fragment_unnamed_3473 * min(fragment_unnamed_5781, 65504.0f))), fragment_unnamed_3457, fragment_unnamed_1947);
								fragment_unnamed_3044 = mad(fragment_unnamed_5799 * (fragment_unnamed_1204 * (fragment_unnamed_3473 * min(fragment_unnamed_5783, 65504.0f))), fragment_unnamed_3457, fragment_unnamed_1949);
							}
							else
							{
								fragment_unnamed_3041 = fragment_unnamed_1941;
								fragment_unnamed_3042 = fragment_unnamed_1945;
								fragment_unnamed_3043 = fragment_unnamed_1947;
								fragment_unnamed_3044 = fragment_unnamed_1949;
							}
							fragment_unnamed_1942 = fragment_unnamed_3041;
							fragment_unnamed_1946 = fragment_unnamed_3042;
							fragment_unnamed_1948 = fragment_unnamed_3043;
							fragment_unnamed_1950 = fragment_unnamed_3044;
							fragment_unnamed_1941 = fragment_unnamed_1942;
							fragment_unnamed_1943 = fragment_unnamed_1944;
							fragment_unnamed_1945 = fragment_unnamed_1946;
							fragment_unnamed_1947 = fragment_unnamed_1948;
							fragment_unnamed_1949 = fragment_unnamed_1950;
							continue;
						}
					}
					if (ladder_phi_33)
					{
						break;
					}
					break;
				}
				float fragment_unnamed_2619;
				float fragment_unnamed_2621;
				float fragment_unnamed_2623;
				if (asuint(fragment_uniform_buffer_0[116u]).x != 0u)
				{
					float fragment_unnamed_2620;
					float fragment_unnamed_2622;
					float fragment_unnamed_2624;
					if (fragment_unnamed_1941 < 1.0f)
					{
						float fragment_unnamed_2937 = asfloat((asuint(fragment_uniform_buffer_0[117u]).x != 0u) ? 1065353216u : 0u);
						float fragment_unnamed_2939 = mad((-0.0f) - fragment_unnamed_1096, fragment_unnamed_1096, 1.0f);
						float fragment_unnamed_2946 = clamp(mad(fragment_unnamed_2939, fragment_unnamed_2939, fragment_unnamed_2939 * (fragment_unnamed_1113 * fragment_unnamed_1113)), 0.0f, 1.0f) * mad(fragment_unnamed_1096, fragment_unnamed_1096, sqrt(fragment_unnamed_2939));
						float fragment_unnamed_2953 = mad(fragment_unnamed_2946, mad((-0.0f) - fragment_unnamed_812, fragment_unnamed_819, fragment_unnamed_1220), fragment_unnamed_820);
						float fragment_unnamed_2954 = mad(fragment_unnamed_2946, mad((-0.0f) - fragment_unnamed_813, fragment_unnamed_819, fragment_unnamed_1221), fragment_unnamed_821);
						float fragment_unnamed_2955 = mad(fragment_unnamed_2946, mad((-0.0f) - fragment_unnamed_814, fragment_unnamed_819, fragment_unnamed_1222), fragment_unnamed_822);
						float fragment_unnamed_2956 = min(fragment_unnamed_1207, 1.0f);
						float fragment_unnamed_2960 = min((fragment_unnamed_2956 * fragment_unnamed_2956) * mad(fragment_unnamed_2956, -2.0f, 3.0f), 1.0f);
						float fragment_unnamed_2967 = mad(fragment_unnamed_2960, ((-0.0f) - fragment_unnamed_2953) + fragment_unnamed_1220, fragment_unnamed_2953);
						float fragment_unnamed_2968 = mad(fragment_unnamed_2960, ((-0.0f) - fragment_unnamed_2954) + fragment_unnamed_1221, fragment_unnamed_2954);
						float fragment_unnamed_2969 = mad(fragment_unnamed_2960, ((-0.0f) - fragment_unnamed_2955) + fragment_unnamed_1222, fragment_unnamed_2955);
						float fragment_unnamed_2976 = asfloat(0u);
						float4 fragment_unnamed_2979 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_2967, fragment_unnamed_2968, fragment_unnamed_2969, fragment_unnamed_2976), (mad((-0.0f) - fragment_unnamed_1096, 0.699999988079071044921875f, 1.7000000476837158203125f) * fragment_unnamed_1096) * 6.0f);
						float fragment_unnamed_2984 = min(fragment_unnamed_2979.x, 65504.0f);
						float fragment_unnamed_2986 = min(fragment_unnamed_2979.y, 65504.0f);
						float fragment_unnamed_2987 = min(fragment_unnamed_2979.z, 65504.0f);
						float fragment_unnamed_3176;
						float fragment_unnamed_3178;
						float fragment_unnamed_3180;
						if (asuint(fragment_uniform_buffer_0[84u]).x != 0u)
						{
							float fragment_unnamed_3098 = dot(float3(fragment_unnamed_2967, fragment_unnamed_2968, fragment_unnamed_2969), float3(fragment_uniform_buffer_0[83u].xyz));
							float fragment_unnamed_3114 = max(abs(fragment_unnamed_3098), 0.001000000047497451305389404296875f);
							float fragment_unnamed_3115 = 1.0f / fragment_unnamed_3114;
							float fragment_unnamed_3120 = min(mad(fragment_uniform_buffer_0[84u].w, fragment_unnamed_3098, fragment_unnamed_1562), fragment_unnamed_1562);
							float fragment_unnamed_3137 = min(max(fragment_unnamed_3115 * (((-0.0f) - fragment_unnamed_3120) + fragment_uniform_buffer_0[89u].y), 0.0f), fragment_uniform_buffer_0[84u].w);
							float fragment_unnamed_3171 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_3114 * ((-0.0f) - (((-0.0f) - fragment_unnamed_3137) + fragment_uniform_buffer_0[84u].w))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_3120 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_3115 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_3137) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_4119;
							float fragment_unnamed_4120;
							float fragment_unnamed_4121;
							if (fragment_uniform_buffer_0[86u].x == 1.0f)
							{
								float4 fragment_unnamed_3791 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_2967, fragment_unnamed_2968, fragment_unnamed_2969, fragment_unnamed_2976), mad((-0.0f) - fragment_uniform_buffer_0[87u].z, clamp((fragment_uniform_buffer_0[84u].w + ((-0.0f) - fragment_uniform_buffer_0[87u].x)) / (((-0.0f) - fragment_uniform_buffer_0[87u].x) + fragment_uniform_buffer_0[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_4119 = fragment_unnamed_3791.z * fragment_uniform_buffer_0[85u].z;
								fragment_unnamed_4120 = fragment_unnamed_3791.y * fragment_uniform_buffer_0[85u].y;
								fragment_unnamed_4121 = fragment_unnamed_3791.x * fragment_uniform_buffer_0[85u].x;
							}
							else
							{
								uint4 fragment_unnamed_3807 = asuint(fragment_uniform_buffer_0[85u]);
								fragment_unnamed_4119 = asfloat(fragment_unnamed_3807.z);
								fragment_unnamed_4120 = asfloat(fragment_unnamed_3807.y);
								fragment_unnamed_4121 = asfloat(fragment_unnamed_3807.x);
							}
							float fragment_unnamed_4126 = ((-0.0f) - fragment_unnamed_3171) + 1.0f;
							fragment_unnamed_3176 = mad(fragment_unnamed_2987, fragment_unnamed_3171, fragment_unnamed_4126 * ((fragment_uniform_buffer_0[88u].z / fragment_uniform_buffer_0[89u].x) * fragment_unnamed_4119));
							fragment_unnamed_3178 = mad(fragment_unnamed_2986, fragment_unnamed_3171, fragment_unnamed_4126 * ((fragment_uniform_buffer_0[88u].y / fragment_uniform_buffer_0[89u].x) * fragment_unnamed_4120));
							fragment_unnamed_3180 = mad(fragment_unnamed_2984, fragment_unnamed_3171, fragment_unnamed_4126 * ((fragment_uniform_buffer_0[88u].x / fragment_uniform_buffer_0[89u].x) * fragment_unnamed_4121));
						}
						else
						{
							fragment_unnamed_3176 = fragment_unnamed_2987;
							fragment_unnamed_3178 = fragment_unnamed_2986;
							fragment_unnamed_3180 = fragment_unnamed_2984;
						}
						float fragment_unnamed_3185 = fragment_unnamed_1941 + 1.0f;
						float fragment_unnamed_3191 = ((-0.0f) - clamp(fragment_unnamed_3185 + ((-0.0f) - clamp(fragment_unnamed_3185, 0.0f, 1.0f)), 0.0f, 1.0f)) + 1.0f;
						fragment_unnamed_2620 = mad((fragment_unnamed_3180 * fragment_unnamed_1202) * fragment_unnamed_3191, fragment_unnamed_2937, fragment_unnamed_1945);
						fragment_unnamed_2622 = mad((fragment_unnamed_3178 * fragment_unnamed_1203) * fragment_unnamed_3191, fragment_unnamed_2937, fragment_unnamed_1947);
						fragment_unnamed_2624 = mad((fragment_unnamed_3176 * fragment_unnamed_1204) * fragment_unnamed_3191, fragment_unnamed_2937, fragment_unnamed_1949);
					}
					else
					{
						fragment_unnamed_2620 = fragment_unnamed_1945;
						fragment_unnamed_2622 = fragment_unnamed_1947;
						fragment_unnamed_2624 = fragment_unnamed_1949;
					}
					fragment_unnamed_2619 = fragment_unnamed_2620;
					fragment_unnamed_2621 = fragment_unnamed_2622;
					fragment_unnamed_2623 = fragment_unnamed_2624;
				}
				else
				{
					fragment_unnamed_2619 = fragment_unnamed_1945;
					fragment_unnamed_2621 = fragment_unnamed_1947;
					fragment_unnamed_2623 = fragment_unnamed_1949;
				}
				float fragment_unnamed_2636 = ((-0.0f) - fragment_unnamed_1562) + fragment_uniform_buffer_0[89u].y;
				float fragment_unnamed_2645 = exp2((((-0.0f) - max(fragment_unnamed_1562 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f);
				uint fragment_unnamed_2651 = (fragment_uniform_buffer_0[218u].w == 1.0f) ? 4294967295u : 0u;
				float fragment_unnamed_2666 = fragment_input_5.x + ((-0.0f) - fragment_uniform_buffer_0[218u].x);
				float fragment_unnamed_2667 = fragment_input_5.y + ((-0.0f) - fragment_uniform_buffer_0[218u].y);
				float fragment_unnamed_2668 = fragment_input_5.z + ((-0.0f) - fragment_uniform_buffer_0[218u].z);
				float fragment_unnamed_2684 = fragment_input_5.x + ((-0.0f) - fragment_uniform_buffer_0[82u].x);
				float fragment_unnamed_2685 = fragment_input_5.y + ((-0.0f) - fragment_uniform_buffer_0[82u].y);
				float fragment_unnamed_2686 = fragment_input_5.z + ((-0.0f) - fragment_uniform_buffer_0[82u].z);
				float fragment_unnamed_2693 = fragment_uniform_buffer_0[82u].w + fragment_uniform_buffer_4[12u].w;
				float fragment_unnamed_2698 = mad((-0.0f) - fragment_unnamed_2693, fragment_unnamed_2693, dot(float3(fragment_unnamed_2684, fragment_unnamed_2685, fragment_unnamed_2686), float3(fragment_unnamed_2684, fragment_unnamed_2685, fragment_unnamed_2686)));
				float fragment_unnamed_2699 = asfloat(0u);
				float fragment_unnamed_2997;
				float fragment_unnamed_2999;
				float fragment_unnamed_3001;
				float fragment_unnamed_3003;
				float fragment_unnamed_3005;
				float fragment_unnamed_3007;
				fragment_unnamed_2997 = fragment_unnamed_1608;
				fragment_unnamed_2999 = fragment_unnamed_1610;
				fragment_unnamed_3001 = fragment_unnamed_1612;
				fragment_unnamed_3003 = fragment_unnamed_1618;
				fragment_unnamed_3005 = fragment_unnamed_1614;
				fragment_unnamed_3007 = fragment_unnamed_1616;
				float fragment_unnamed_2998;
				float fragment_unnamed_3000;
				float fragment_unnamed_3002;
				float fragment_unnamed_3004;
				float fragment_unnamed_3006;
				float fragment_unnamed_3008;
				for (float fragment_unnamed_3009 = fragment_unnamed_2699; !(asuint(fragment_unnamed_3009) >= asuint(fragment_uniform_buffer_0[114u]).x); fragment_unnamed_2997 = fragment_unnamed_2998, fragment_unnamed_2999 = fragment_unnamed_3000, fragment_unnamed_3001 = fragment_unnamed_3002, fragment_unnamed_3003 = fragment_unnamed_3004, fragment_unnamed_3005 = fragment_unnamed_3006, fragment_unnamed_3007 = fragment_unnamed_3008, fragment_unnamed_3009 = asfloat(asuint(fragment_unnamed_3009) + 1u))
				{
					float frontier_phi_62_pred;
					float frontier_phi_62_pred_1;
					float frontier_phi_62_pred_2;
					float frontier_phi_62_pred_3;
					float frontier_phi_62_pred_4;
					float frontier_phi_62_pred_5;
					if ((fragment_unnamed_827 & T6.Load((asuint(fragment_unnamed_3009) * 44u) + 3u).x) != 0u)
					{
						uint fragment_unnamed_3832 = (asuint(fragment_unnamed_3009) * 44u) + 4u;
						uint4 fragment_unnamed_3844 = uint4(T6.Load(fragment_unnamed_3832).x, T6.Load(fragment_unnamed_3832 + 1u).x, T6.Load(fragment_unnamed_3832 + 2u).x, T6.Load(fragment_unnamed_3832 + 3u).x);
						float fragment_unnamed_3846 = asfloat(fragment_unnamed_3844.x);
						float fragment_unnamed_3848 = asfloat(fragment_unnamed_3844.y);
						float fragment_unnamed_3850 = asfloat(fragment_unnamed_3844.z);
						uint fragment_unnamed_3851 = fragment_unnamed_3844.w;
						uint fragment_unnamed_3854 = (asuint(fragment_unnamed_3009) * 44u) + 36u;
						uint3 fragment_unnamed_3863 = uint3(T6.Load(fragment_unnamed_3854).x, T6.Load(fragment_unnamed_3854 + 1u).x, T6.Load(fragment_unnamed_3854 + 2u).x);
						float fragment_unnamed_3865 = asfloat(fragment_unnamed_3863.x);
						float fragment_unnamed_3867 = asfloat(fragment_unnamed_3863.y);
						float fragment_unnamed_3875 = dot(float3(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822), float3((-0.0f) - fragment_unnamed_3846, (-0.0f) - fragment_unnamed_3848, (-0.0f) - fragment_unnamed_3850));
						float fragment_unnamed_5007;
						float fragment_unnamed_5009;
						float fragment_unnamed_5011;
						float fragment_unnamed_5013;
						float fragment_unnamed_5015;
						float fragment_unnamed_5017;
						if ((((0.0f < asfloat(fragment_unnamed_3863.z)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_3875) ? 4294967295u : 0u)) != 0u)
						{
							uint fragment_unnamed_4208 = (asuint(fragment_unnamed_3009) * 44u) + 12u;
							uint4 fragment_unnamed_4220 = uint4(T6.Load(fragment_unnamed_4208).x, T6.Load(fragment_unnamed_4208 + 1u).x, T6.Load(fragment_unnamed_4208 + 2u).x, T6.Load(fragment_unnamed_4208 + 3u).x);
							float fragment_unnamed_4222 = asfloat(fragment_unnamed_4220.x);
							float fragment_unnamed_4224 = asfloat(fragment_unnamed_4220.y);
							float fragment_unnamed_4226 = asfloat(fragment_unnamed_4220.z);
							uint fragment_unnamed_4230 = (asuint(fragment_unnamed_3009) * 44u) + 16u;
							uint3 fragment_unnamed_4239 = uint3(T6.Load(fragment_unnamed_4230).x, T6.Load(fragment_unnamed_4230 + 1u).x, T6.Load(fragment_unnamed_4230 + 2u).x);
							float fragment_unnamed_4241 = asfloat(fragment_unnamed_4239.x);
							float fragment_unnamed_4243 = asfloat(fragment_unnamed_4239.y);
							float fragment_unnamed_4245 = asfloat(fragment_unnamed_4239.z);
							uint fragment_unnamed_4248 = (asuint(fragment_unnamed_3009) * 44u) + 20u;
							uint3 fragment_unnamed_4257 = uint3(T6.Load(fragment_unnamed_4248).x, T6.Load(fragment_unnamed_4248 + 1u).x, T6.Load(fragment_unnamed_4248 + 2u).x);
							float fragment_unnamed_4259 = asfloat(fragment_unnamed_4257.x);
							float fragment_unnamed_4261 = asfloat(fragment_unnamed_4257.y);
							float fragment_unnamed_4263 = asfloat(fragment_unnamed_4257.z);
							uint fragment_unnamed_4266 = (asuint(fragment_unnamed_3009) * 44u) + 24u;
							uint4 fragment_unnamed_4278 = uint4(T6.Load(fragment_unnamed_4266).x, T6.Load(fragment_unnamed_4266 + 1u).x, T6.Load(fragment_unnamed_4266 + 2u).x, T6.Load(fragment_unnamed_4266 + 3u).x);
							float fragment_unnamed_4280 = asfloat(fragment_unnamed_4278.x);
							float fragment_unnamed_4282 = asfloat(fragment_unnamed_4278.y);
							float fragment_unnamed_4284 = asfloat(fragment_unnamed_4278.z);
							float fragment_unnamed_4286 = asfloat(fragment_unnamed_4278.w);
							float fragment_unnamed_4292 = asfloat(T6.Load((asuint(fragment_unnamed_3009) * 44u) + 40u).x);
							float fragment_unnamed_4305 = 1.0f / max(dot(float3((-0.0f) - fragment_unnamed_3846, (-0.0f) - fragment_unnamed_3848, (-0.0f) - fragment_unnamed_3850), float3(fragment_uniform_buffer_0[83u].xyz)), 0.001000000047497451305389404296875f);
							float fragment_unnamed_4318 = exp2((mad(fragment_unnamed_2645, fragment_unnamed_4305 * fragment_uniform_buffer_0[90u].y, max(fragment_unnamed_2636 * fragment_unnamed_4305, 0.0f)) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_4997;
							float fragment_unnamed_4998;
							float fragment_unnamed_4999;
							if (fragment_unnamed_3851 != 0u)
							{
								uint fragment_unnamed_4882 = asuint(fragment_unnamed_3009) * 44u;
								uint3 fragment_unnamed_4891 = uint3(T6.Load(fragment_unnamed_4882).x, T6.Load(fragment_unnamed_4882 + 1u).x, T6.Load(fragment_unnamed_4882 + 2u).x);
								uint fragment_unnamed_4900 = (asuint(fragment_unnamed_3009) * 44u) + 8u;
								uint4 fragment_unnamed_4912 = uint4(T6.Load(fragment_unnamed_4900).x, T6.Load(fragment_unnamed_4900 + 1u).x, T6.Load(fragment_unnamed_4900 + 2u).x, T6.Load(fragment_unnamed_4900 + 3u).x);
								float fragment_unnamed_4914 = asfloat(fragment_unnamed_4912.x);
								float fragment_unnamed_4916 = asfloat(fragment_unnamed_4912.y);
								float fragment_unnamed_4930 = ((-0.0f) - asfloat(fragment_unnamed_4891.x)) + fragment_input_5.x;
								float fragment_unnamed_4931 = ((-0.0f) - asfloat(fragment_unnamed_4891.y)) + fragment_input_5.y;
								float fragment_unnamed_4932 = ((-0.0f) - asfloat(fragment_unnamed_4891.z)) + fragment_input_5.z;
								float fragment_unnamed_4939 = mad(dot(float3(fragment_unnamed_4930, fragment_unnamed_4931, fragment_unnamed_4932), float3(fragment_unnamed_4222, fragment_unnamed_4224, fragment_unnamed_4226)), 0.5f, 0.5f);
								float fragment_unnamed_4940 = mad(dot(float3(fragment_unnamed_4930, fragment_unnamed_4931, fragment_unnamed_4932), float3(fragment_unnamed_4241, fragment_unnamed_4243, fragment_unnamed_4245)), 0.5f, 0.5f);
								bool fragment_unnamed_4941 = fragment_unnamed_3851 == 2u;
								float fragment_unnamed_4957 = 1.0f / (fragment_unnamed_4914 + fragment_uniform_buffer_0[123u].y);
								float fragment_unnamed_4958 = 1.0f / (fragment_unnamed_4916 + fragment_uniform_buffer_0[123u].y);
								float fragment_unnamed_4970 = fragment_unnamed_4914 * fragment_uniform_buffer_0[123u].x;
								float fragment_unnamed_4971 = fragment_unnamed_4916 * fragment_uniform_buffer_0[123u].x;
								float fragment_unnamed_4974 = fragment_unnamed_1573 / (fragment_unnamed_4970 + fragment_unnamed_4970);
								float fragment_unnamed_4975 = fragment_unnamed_1573 / (fragment_unnamed_4971 + fragment_unnamed_4971);
								float4 fragment_unnamed_4989 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_4974) + 1.0f, max(fragment_unnamed_4974, mad(asfloat(fragment_unnamed_4941 ? asuint(frac(fragment_unnamed_4939)) : asuint(fragment_unnamed_4939)), fragment_unnamed_4914 * fragment_unnamed_4957, mad((-0.0f) - fragment_unnamed_4957, fragment_unnamed_4914, 1.0f) * 0.5f))), fragment_unnamed_4914, asfloat(fragment_unnamed_4912.z)), mad(min(((-0.0f) - fragment_unnamed_4975) + 1.0f, max(fragment_unnamed_4975, mad(asfloat(fragment_unnamed_4941 ? asuint(frac(fragment_unnamed_4940)) : asuint(fragment_unnamed_4940)), fragment_unnamed_4916 * fragment_unnamed_4958, mad((-0.0f) - fragment_unnamed_4958, fragment_unnamed_4916, 1.0f) * 0.5f))), fragment_unnamed_4916, asfloat(fragment_unnamed_4912.w))), 0.0f);
								fragment_unnamed_4997 = fragment_unnamed_4259 * fragment_unnamed_4989.x;
								fragment_unnamed_4998 = fragment_unnamed_4261 * fragment_unnamed_4989.y;
								fragment_unnamed_4999 = fragment_unnamed_4263 * fragment_unnamed_4989.z;
							}
							else
							{
								fragment_unnamed_4997 = fragment_unnamed_4259;
								fragment_unnamed_4998 = fragment_unnamed_4261;
								fragment_unnamed_4999 = fragment_unnamed_4263;
							}
							uint fragment_unnamed_5004 = (int(fragment_unnamed_4220.w) >= int(0u)) ? 4294967295u : 0u;
							float fragment_unnamed_6422;
							float fragment_unnamed_6423;
							float fragment_unnamed_6424;
							if ((fragment_unnamed_2651 & fragment_unnamed_5004) != 0u)
							{
								float fragment_unnamed_5543 = rsqrt(dot(float3(fragment_unnamed_4222, fragment_unnamed_4224, fragment_unnamed_4226), float3(fragment_unnamed_4222, fragment_unnamed_4224, fragment_unnamed_4226)));
								float fragment_unnamed_5547 = dot(float3(fragment_unnamed_2666, fragment_unnamed_2667, fragment_unnamed_2668), float3(fragment_unnamed_5543 * fragment_unnamed_4222, fragment_unnamed_5543 * fragment_unnamed_4224, fragment_unnamed_5543 * fragment_unnamed_4226));
								float fragment_unnamed_5557 = clamp(fragment_unnamed_5547 / fragment_uniform_buffer_0[217u].x, 0.0f, 1.0f);
								float fragment_unnamed_5561 = rsqrt(dot(float3(fragment_unnamed_4241, fragment_unnamed_4243, fragment_unnamed_4245), float3(fragment_unnamed_4241, fragment_unnamed_4243, fragment_unnamed_4245)));
								float fragment_unnamed_5565 = dot(float3(fragment_unnamed_2666, fragment_unnamed_2667, fragment_unnamed_2668), float3(fragment_unnamed_5561 * fragment_unnamed_4241, fragment_unnamed_5561 * fragment_unnamed_4243, fragment_unnamed_5561 * fragment_unnamed_4245));
								float fragment_unnamed_5574 = clamp(fragment_unnamed_5565 / fragment_uniform_buffer_0[217u].y, 0.0f, 1.0f);
								float fragment_unnamed_5575 = dot(float3(fragment_unnamed_3846, fragment_unnamed_3848, fragment_unnamed_3850), float3(fragment_unnamed_3846, fragment_unnamed_3848, fragment_unnamed_3850));
								float fragment_unnamed_5578 = dot(float3(fragment_unnamed_3846, fragment_unnamed_3848, fragment_unnamed_3850), float3(fragment_unnamed_2684, fragment_unnamed_2685, fragment_unnamed_2686));
								float fragment_unnamed_5581 = fragment_unnamed_5578 + fragment_unnamed_5578;
								float4 fragment_unnamed_5597 = _VolumetricCloudsShadowsTexture.SampleLevel(S0, float2(fragment_unnamed_5557, fragment_unnamed_5574), 0.0f);
								float fragment_unnamed_5599 = fragment_unnamed_5597.x;
								float fragment_unnamed_5600 = fragment_unnamed_5597.y;
								float fragment_unnamed_5631 = asfloat((((((fragment_unnamed_5574 != 1.0f) ? 4294967295u : 0u) & ((fragment_unnamed_5557 != 1.0f) ? 4294967295u : 0u)) & (((clamp(fragment_unnamed_5565 / fragment_uniform_buffer_0[217u].y, 0.0f, 1.0f) != 0.0f) ? 4294967295u : 0u) & ((clamp(fragment_unnamed_5547 / fragment_uniform_buffer_0[217u].x, 0.0f, 1.0f) != 0.0f) ? 4294967295u : 0u))) != 0u) ? ((fragment_unnamed_5600 != 1.0f) ? asuint(mad(clamp(((mad((-0.0f) - float(int(-((0.0f < fragment_unnamed_5575) ? 4294967295u : 0u))), sqrt(mad(fragment_unnamed_5581, fragment_unnamed_5581, (-0.0f) - ((fragment_unnamed_2698 * fragment_unnamed_5575) * 4.0f))), (-0.0f) - fragment_unnamed_5581) / (fragment_unnamed_5575 + fragment_unnamed_5575)) + ((-0.0f) - fragment_unnamed_5599)) / (((-0.0f) - fragment_unnamed_5599) + fragment_unnamed_5597.z), 0.0f, 1.0f), ((-0.0f) - fragment_unnamed_5600) + 1.0f, fragment_unnamed_5600)) : 1065353216u) : asuint(fragment_uniform_buffer_0[217u]).w);
								fragment_unnamed_6422 = fragment_unnamed_1467 * fragment_unnamed_5631;
								fragment_unnamed_6423 = fragment_unnamed_1465 * fragment_unnamed_5631;
								fragment_unnamed_6424 = fragment_unnamed_1463 * fragment_unnamed_5631;
							}
							else
							{
								fragment_unnamed_6422 = fragment_unnamed_1467;
								fragment_unnamed_6423 = fragment_unnamed_1465;
								fragment_unnamed_6424 = fragment_unnamed_1463;
							}
							bool fragment_unnamed_6434 = (fragment_unnamed_5004 & ((0.0f < fragment_unnamed_4286) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_6439 = asfloat(fragment_unnamed_6434 ? asuint(mad(fragment_unnamed_4286, fragment_unnamed_6422 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6441 = asfloat(fragment_unnamed_6434 ? asuint(mad(fragment_unnamed_4286, fragment_unnamed_6423 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6443 = asfloat(fragment_unnamed_6434 ? asuint(mad(fragment_unnamed_4286, fragment_unnamed_6424 + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6455 = asfloat((fragment_unnamed_3875 >= 0.0f) ? asuint(mad(fragment_uniform_buffer_0[121u].x, clamp(fragment_unnamed_3875 + 1.0f, 0.0f, 1.0f) + (-1.0f), 1.0f)) : 1065353216u);
							float fragment_unnamed_6456 = fragment_unnamed_6455 * fragment_unnamed_6439;
							float fragment_unnamed_6457 = fragment_unnamed_6455 * fragment_unnamed_6441;
							float fragment_unnamed_6458 = fragment_unnamed_6455 * fragment_unnamed_6443;
							float fragment_unnamed_6462 = ((-0.0f) - fragment_unnamed_4280) + 1.0f;
							float fragment_unnamed_6463 = ((-0.0f) - fragment_unnamed_4282) + 1.0f;
							float fragment_unnamed_6464 = ((-0.0f) - fragment_unnamed_4284) + 1.0f;
							float fragment_unnamed_6480 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6439, fragment_unnamed_6455, 1.0f), fragment_unnamed_6462, 1.0f);
							float fragment_unnamed_6481 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6441, fragment_unnamed_6455, 1.0f), fragment_unnamed_6463, 1.0f);
							float fragment_unnamed_6482 = mad((-0.0f) - mad((-0.0f) - fragment_unnamed_6443, fragment_unnamed_6455, 1.0f), fragment_unnamed_6464, 1.0f);
							float fragment_unnamed_6498 = mad(fragment_unnamed_4292, ((-0.0f) - fragment_unnamed_6480) + mad(fragment_unnamed_6456 * (fragment_unnamed_6456 * fragment_unnamed_6456), fragment_unnamed_6462, fragment_unnamed_4280 * fragment_unnamed_6456), fragment_unnamed_6480) * (fragment_unnamed_4318 * fragment_unnamed_4997);
							float fragment_unnamed_6499 = mad(fragment_unnamed_4292, ((-0.0f) - fragment_unnamed_6481) + mad(fragment_unnamed_6457 * (fragment_unnamed_6457 * fragment_unnamed_6457), fragment_unnamed_6463, fragment_unnamed_4282 * fragment_unnamed_6457), fragment_unnamed_6481) * (fragment_unnamed_4318 * fragment_unnamed_4998);
							float fragment_unnamed_6500 = mad(fragment_unnamed_4292, ((-0.0f) - fragment_unnamed_6482) + mad(fragment_unnamed_6458 * (fragment_unnamed_6458 * fragment_unnamed_6458), fragment_unnamed_6464, fragment_unnamed_4284 * fragment_unnamed_6458), fragment_unnamed_6482) * (fragment_unnamed_4318 * fragment_unnamed_4999);
							float fragment_unnamed_5008;
							float fragment_unnamed_5010;
							float fragment_unnamed_5012;
							float fragment_unnamed_5014;
							float fragment_unnamed_5016;
							float fragment_unnamed_5018;
							if (0.0f < max(fragment_unnamed_6500, max(fragment_unnamed_6499, fragment_unnamed_6498)))
							{
								float fragment_unnamed_6869 = max(fragment_unnamed_1192, asfloat(T6.Load((asuint(fragment_unnamed_3009) * 44u) + 30u).x));
								float fragment_unnamed_6870 = clamp(fragment_unnamed_3875, 0.0f, 1.0f);
								float fragment_unnamed_6874 = dot(float3((-0.0f) - fragment_unnamed_3846, (-0.0f) - fragment_unnamed_3848, (-0.0f) - fragment_unnamed_3850), float3(fragment_unnamed_347, fragment_unnamed_348, fragment_unnamed_349));
								float fragment_unnamed_6879 = rsqrt(max(mad(fragment_unnamed_6874, 2.0f, 2.0f), 5.9604644775390625e-08f));
								float fragment_unnamed_6882 = clamp(fragment_unnamed_6879 * (fragment_unnamed_1110 + fragment_unnamed_3875), 0.0f, 1.0f);
								float fragment_unnamed_6886 = ((-0.0f) - clamp(mad(fragment_unnamed_6879, fragment_unnamed_6874, fragment_unnamed_6879), 0.0f, 1.0f)) + 1.0f;
								float fragment_unnamed_6887 = fragment_unnamed_6886 * fragment_unnamed_6886;
								float fragment_unnamed_6888 = fragment_unnamed_6887 * fragment_unnamed_6887;
								float fragment_unnamed_6891 = mad((-0.0f) - fragment_unnamed_6888, fragment_unnamed_6886, 1.0f);
								float fragment_unnamed_6892 = fragment_unnamed_1191 * (fragment_unnamed_6886 * fragment_unnamed_6888);
								float fragment_unnamed_6896 = fragment_unnamed_6869 * fragment_unnamed_6869;
								float fragment_unnamed_6899 = mad(mad(fragment_unnamed_6882, fragment_unnamed_6896, (-0.0f) - fragment_unnamed_6882), fragment_unnamed_6882, 1.0f);
								float fragment_unnamed_6914 = (fragment_unnamed_6896 * 0.15915493667125701904296875f) / max((fragment_unnamed_6899 * fragment_unnamed_6899) * mad(abs(fragment_unnamed_3875), fragment_unnamed_1211, fragment_unnamed_1113 * sqrt(mad(mad((-0.0f) - abs(fragment_unnamed_3875), fragment_unnamed_6896, abs(fragment_unnamed_3875)), abs(fragment_unnamed_3875), fragment_unnamed_6896))), 1.1754943508222875079687365372222e-38f);
								float fragment_unnamed_6921 = ((-0.0f) - abs(fragment_unnamed_3875)) + 1.0f;
								float fragment_unnamed_6922 = fragment_unnamed_6921 * fragment_unnamed_6921;
								float fragment_unnamed_6925 = mad(fragment_unnamed_1096, fragment_unnamed_6874, fragment_unnamed_1096) + (-0.5f);
								float fragment_unnamed_6930 = ((mad(fragment_unnamed_6925, fragment_unnamed_1575, 1.0f) * mad(fragment_unnamed_6925, fragment_unnamed_6921 * (fragment_unnamed_6922 * fragment_unnamed_6922), 1.0f)) * fragment_unnamed_6870) * 0.307334959506988525390625f;
								fragment_unnamed_5008 = fragment_unnamed_3867 * (fragment_unnamed_6498 * (fragment_unnamed_6870 * (fragment_unnamed_6914 * mad(fragment_unnamed_1106, fragment_unnamed_6891, fragment_unnamed_6892))));
								fragment_unnamed_5010 = fragment_unnamed_3867 * (fragment_unnamed_6499 * (fragment_unnamed_6870 * (fragment_unnamed_6914 * mad(fragment_unnamed_1108, fragment_unnamed_6891, fragment_unnamed_6892))));
								fragment_unnamed_5012 = fragment_unnamed_3867 * (fragment_unnamed_6500 * (fragment_unnamed_6870 * (fragment_unnamed_6914 * mad(fragment_unnamed_1109, fragment_unnamed_6891, fragment_unnamed_6892))));
								fragment_unnamed_5014 = fragment_unnamed_3865 * (fragment_unnamed_6498 * fragment_unnamed_6930);
								fragment_unnamed_5016 = fragment_unnamed_3865 * (fragment_unnamed_6499 * fragment_unnamed_6930);
								fragment_unnamed_5018 = fragment_unnamed_3865 * (fragment_unnamed_6500 * fragment_unnamed_6930);
							}
							else
							{
								fragment_unnamed_5008 = asfloat(0u);
								fragment_unnamed_5010 = asfloat(0u);
								fragment_unnamed_5012 = asfloat(0u);
								fragment_unnamed_5014 = asfloat(0u);
								fragment_unnamed_5016 = asfloat(0u);
								fragment_unnamed_5018 = asfloat(0u);
							}
							fragment_unnamed_5007 = fragment_unnamed_5008;
							fragment_unnamed_5009 = fragment_unnamed_5010;
							fragment_unnamed_5011 = fragment_unnamed_5012;
							fragment_unnamed_5013 = fragment_unnamed_5014;
							fragment_unnamed_5015 = fragment_unnamed_5016;
							fragment_unnamed_5017 = fragment_unnamed_5018;
						}
						else
						{
							fragment_unnamed_5007 = asfloat(0u);
							fragment_unnamed_5009 = asfloat(0u);
							fragment_unnamed_5011 = asfloat(0u);
							fragment_unnamed_5013 = asfloat(0u);
							fragment_unnamed_5015 = asfloat(0u);
							fragment_unnamed_5017 = asfloat(0u);
						}
						frontier_phi_62_pred = fragment_unnamed_5011 + fragment_unnamed_3007;
						frontier_phi_62_pred_1 = fragment_unnamed_5007 + fragment_unnamed_3003;
						frontier_phi_62_pred_2 = fragment_unnamed_3001 + fragment_unnamed_5017;
						frontier_phi_62_pred_3 = fragment_unnamed_2999 + fragment_unnamed_5015;
						frontier_phi_62_pred_4 = fragment_unnamed_2997 + fragment_unnamed_5013;
						frontier_phi_62_pred_5 = fragment_unnamed_5009 + fragment_unnamed_3005;
					}
					else
					{
						frontier_phi_62_pred = fragment_unnamed_3007;
						frontier_phi_62_pred_1 = fragment_unnamed_3003;
						frontier_phi_62_pred_2 = fragment_unnamed_3001;
						frontier_phi_62_pred_3 = fragment_unnamed_2999;
						frontier_phi_62_pred_4 = fragment_unnamed_2997;
						frontier_phi_62_pred_5 = fragment_unnamed_3005;
					}
					fragment_unnamed_3008 = frontier_phi_62_pred;
					fragment_unnamed_3004 = frontier_phi_62_pred_1;
					fragment_unnamed_3002 = frontier_phi_62_pred_2;
					fragment_unnamed_3000 = frontier_phi_62_pred_3;
					fragment_unnamed_2998 = frontier_phi_62_pred_4;
					fragment_unnamed_3006 = frontier_phi_62_pred_5;
				}
				uint4 fragment_unnamed_3195 = T4.Load(((((fragment_unnamed_1532 + fragment_unnamed_1499) * fragment_unnamed_1693) + fragment_unnamed_288) * fragment_unnamed_1701) + fragment_unnamed_286);
				uint fragment_unnamed_3196 = fragment_unnamed_3195.x;
				uint fragment_unnamed_3197 = fragment_unnamed_3196 & 67108863u;
				uint fragment_unnamed_3198 = fragment_unnamed_3196 >> 26u;
				float fragment_unnamed_3200 = mad((-0.0f) - fragment_unnamed_1237, fragment_unnamed_1235, fragment_unnamed_1234);
				float fragment_unnamed_3201 = fragment_unnamed_3200 * fragment_unnamed_1236;
				float fragment_unnamed_3207 = clamp((((-0.0f) - fragment_unnamed_1096) + 0.300000011920928955078125f) * 3.3333332538604736328125f, 0.0f, 1.0f);
				float fragment_unnamed_3209 = mad((-0.0f) - fragment_unnamed_1243, fragment_unnamed_1241, fragment_unnamed_1240);
				float fragment_unnamed_3210 = fragment_unnamed_3209 * fragment_unnamed_1242;
				float fragment_unnamed_3211 = asfloat(fragment_unnamed_1247 ? asuint(fragment_unnamed_1251 * fragment_unnamed_1257) : asuint(fragment_unnamed_1274));
				float fragment_unnamed_3212 = asfloat(fragment_unnamed_1247 ? asuint(fragment_unnamed_1258) : asuint(fragment_unnamed_1275));
				float fragment_unnamed_3213 = asfloat(1065353216u);
				float fragment_unnamed_3214 = asfloat(1065353216u);
				float fragment_unnamed_3215 = asfloat(fragment_unnamed_1247 ? asuint(fragment_unnamed_821) : asuint(mad(fragment_unnamed_820, fragment_unnamed_1274, (-0.0f) - (fragment_unnamed_821 * fragment_unnamed_1273))));
				float fragment_unnamed_3216 = asfloat(1065353216u);
				float fragment_unnamed_3217 = asfloat(1065353216u);
				float fragment_unnamed_3218 = asfloat(0u);
				float fragment_unnamed_3814;
				float fragment_unnamed_3816;
				float fragment_unnamed_3818;
				float fragment_unnamed_3820;
				float fragment_unnamed_3822;
				float fragment_unnamed_3824;
				float fragment_unnamed_3826;
				for (;;)
				{
					fragment_unnamed_3814 = fragment_unnamed_3003;
					fragment_unnamed_3816 = fragment_unnamed_3005;
					fragment_unnamed_3818 = fragment_unnamed_3007;
					fragment_unnamed_3820 = fragment_unnamed_3218;
					fragment_unnamed_3822 = fragment_unnamed_3001;
					fragment_unnamed_3824 = fragment_unnamed_2999;
					fragment_unnamed_3826 = fragment_unnamed_2997;
					float fragment_unnamed_3821;
					float fragment_unnamed_3815;
					float fragment_unnamed_3817;
					float fragment_unnamed_3819;
					float fragment_unnamed_3823;
					float fragment_unnamed_3825;
					float fragment_unnamed_3827;
					bool ladder_phi_84;
					for (;;)
					{
						if (asuint(fragment_unnamed_3820) >= fragment_unnamed_3198)
						{
							ladder_phi_84 = true;
							break;
						}
						else
						{
							uint fragment_unnamed_4201 = asuint(fragment_unnamed_3820);
							uint4 fragment_unnamed_4203 = T3.Load(fragment_unnamed_3197 + fragment_unnamed_4201);
							uint fragment_unnamed_4204 = fragment_unnamed_4203.x;
							if (fragment_unnamed_4204 == 4294967295u)
							{
								ladder_phi_84 = false;
								break;
							}
							uint fragment_unnamed_4857 = fragment_unnamed_4204 * 56u;
							uint4 fragment_unnamed_4869 = uint4(T7.Load(fragment_unnamed_4857).x, T7.Load(fragment_unnamed_4857 + 1u).x, T7.Load(fragment_unnamed_4857 + 2u).x, T7.Load(fragment_unnamed_4857 + 3u).x);
							fragment_unnamed_3821 = asfloat(asuint(fragment_unnamed_3820) + 1u);
							if (!((fragment_unnamed_827 & fragment_unnamed_4869.w) != 0u))
							{
								fragment_unnamed_3815 = fragment_unnamed_3814;
								fragment_unnamed_3817 = fragment_unnamed_3816;
								fragment_unnamed_3819 = fragment_unnamed_3818;
								fragment_unnamed_3823 = fragment_unnamed_3822;
								fragment_unnamed_3825 = fragment_unnamed_3824;
								fragment_unnamed_3827 = fragment_unnamed_3826;
								fragment_unnamed_3814 = fragment_unnamed_3815;
								fragment_unnamed_3816 = fragment_unnamed_3817;
								fragment_unnamed_3818 = fragment_unnamed_3819;
								fragment_unnamed_3820 = fragment_unnamed_3821;
								fragment_unnamed_3822 = fragment_unnamed_3823;
								fragment_unnamed_3824 = fragment_unnamed_3825;
								fragment_unnamed_3826 = fragment_unnamed_3827;
								continue;
							}
							uint fragment_unnamed_5343 = (fragment_unnamed_4204 * 56u) + 8u;
							uint3 fragment_unnamed_5352 = uint3(T7.Load(fragment_unnamed_5343).x, T7.Load(fragment_unnamed_5343 + 1u).x, T7.Load(fragment_unnamed_5343 + 2u).x);
							uint fragment_unnamed_5360 = (fragment_unnamed_4204 * 56u) + 12u;
							uint4 fragment_unnamed_5372 = uint4(T7.Load(fragment_unnamed_5360).x, T7.Load(fragment_unnamed_5360 + 1u).x, T7.Load(fragment_unnamed_5360 + 2u).x, T7.Load(fragment_unnamed_5360 + 3u).x);
							float fragment_unnamed_5375 = asfloat(fragment_unnamed_5372.y);
							float fragment_unnamed_5377 = asfloat(fragment_unnamed_5372.z);
							float fragment_unnamed_5379 = asfloat(fragment_unnamed_5372.w);
							uint fragment_unnamed_5381 = (fragment_unnamed_4204 * 56u) + 18u;
							uint4 fragment_unnamed_5393 = uint4(T7.Load(fragment_unnamed_5381).x, T7.Load(fragment_unnamed_5381 + 1u).x, T7.Load(fragment_unnamed_5381 + 2u).x, T7.Load(fragment_unnamed_5381 + 3u).x);
							uint fragment_unnamed_5394 = fragment_unnamed_5393.x;
							uint fragment_unnamed_5395 = fragment_unnamed_5393.y;
							uint fragment_unnamed_5399 = (fragment_unnamed_4204 * 56u) + 22u;
							uint4 fragment_unnamed_5411 = uint4(T7.Load(fragment_unnamed_5399).x, T7.Load(fragment_unnamed_5399 + 1u).x, T7.Load(fragment_unnamed_5399 + 2u).x, T7.Load(fragment_unnamed_5399 + 3u).x);
							float fragment_unnamed_5413 = asfloat(fragment_unnamed_5411.z);
							float fragment_unnamed_5415 = asfloat(fragment_unnamed_5411.w);
							uint fragment_unnamed_5420 = (fragment_unnamed_4204 * 56u) + 26u;
							uint4 fragment_unnamed_5432 = uint4(T7.Load(fragment_unnamed_5420).x, T7.Load(fragment_unnamed_5420 + 1u).x, T7.Load(fragment_unnamed_5420 + 2u).x, T7.Load(fragment_unnamed_5420 + 3u).x);
							uint fragment_unnamed_5433 = fragment_unnamed_5432.x;
							float fragment_unnamed_5437 = asfloat(fragment_unnamed_5432.z);
							float fragment_unnamed_5439 = asfloat(fragment_unnamed_5432.w);
							uint fragment_unnamed_5441 = (fragment_unnamed_4204 * 56u) + 30u;
							uint4 fragment_unnamed_5453 = uint4(T7.Load(fragment_unnamed_5441).x, T7.Load(fragment_unnamed_5441 + 1u).x, T7.Load(fragment_unnamed_5441 + 2u).x, T7.Load(fragment_unnamed_5441 + 3u).x);
							float fragment_unnamed_5455 = asfloat(fragment_unnamed_5453.x);
							float fragment_unnamed_5457 = asfloat(fragment_unnamed_5453.y);
							uint fragment_unnamed_5461 = (fragment_unnamed_4204 * 56u) + 44u;
							uint2 fragment_unnamed_5467 = uint2(T7.Load(fragment_unnamed_5461).x, T7.Load(fragment_unnamed_5461 + 1u).x);
							float fragment_unnamed_5469 = asfloat(fragment_unnamed_5467.x);
							float fragment_unnamed_5471 = asfloat(fragment_unnamed_5467.y);
							bool fragment_unnamed_5472 = fragment_unnamed_5372.x == 6u;
							uint fragment_unnamed_5473 = fragment_unnamed_5472 ? 4294967295u : 0u;
							float fragment_unnamed_5483 = asfloat(fragment_unnamed_4869.x) + ((-0.0f) - fragment_input_5.x);
							float fragment_unnamed_5484 = asfloat(fragment_unnamed_4869.y) + ((-0.0f) - fragment_input_5.y);
							float fragment_unnamed_5485 = asfloat(fragment_unnamed_4869.z) + ((-0.0f) - fragment_input_5.z);
							float fragment_unnamed_5486 = fragment_unnamed_5469 * 0.5f;
							float fragment_unnamed_5487 = fragment_unnamed_5471 * 0.5f;
							float fragment_unnamed_5488 = dot(float3(fragment_unnamed_5483, fragment_unnamed_5484, fragment_unnamed_5485), float3(fragment_unnamed_5375, fragment_unnamed_5377, fragment_unnamed_5379));
							float fragment_unnamed_5494 = max(mad((-0.0f) - fragment_unnamed_5469, 0.5f, abs(fragment_unnamed_5488)), 0.0f);
							float fragment_unnamed_5495 = asfloat(fragment_unnamed_5393.z);
							float fragment_unnamed_5496 = asfloat(fragment_unnamed_5393.w);
							float fragment_unnamed_5497 = asfloat(fragment_unnamed_5411.x);
							float fragment_unnamed_5498 = dot(float3(fragment_unnamed_5483, fragment_unnamed_5484, fragment_unnamed_5485), float3(fragment_unnamed_5495, fragment_unnamed_5496, fragment_unnamed_5497));
							float fragment_unnamed_5504 = max(mad((-0.0f) - fragment_unnamed_5471, 0.5f, abs(fragment_unnamed_5498)), 0.0f);
							float fragment_unnamed_5515 = asfloat(fragment_unnamed_5411.y) * mad(fragment_unnamed_5504, fragment_unnamed_5504, mad(fragment_unnamed_5494, fragment_unnamed_5494, max(mad((-0.0f) - fragment_unnamed_5498, fragment_unnamed_5498, mad((-0.0f) - fragment_unnamed_5488, fragment_unnamed_5488, dot(float3(fragment_unnamed_5483, fragment_unnamed_5484, fragment_unnamed_5485), float3(fragment_unnamed_5483, fragment_unnamed_5484, fragment_unnamed_5485)))), 0.0f)));
							float fragment_unnamed_5518 = clamp(mad((-0.0f) - fragment_unnamed_5515, fragment_unnamed_5515, asfloat(fragment_unnamed_5432.y)), 0.0f, 1.0f);
							float fragment_unnamed_5529 = asfloat(((fragment_unnamed_5473 & ((dot(float3(fragment_unnamed_5483, fragment_unnamed_5484, fragment_unnamed_5485), float3(asfloat(fragment_unnamed_5352.x), asfloat(fragment_unnamed_5352.y), asfloat(fragment_unnamed_5352.z))) >= 0.0f) ? 4294967295u : 0u)) != 0u) ? 0u : asuint(fragment_unnamed_5518 * fragment_unnamed_5518));
							uint fragment_unnamed_5531 = (0.0f < fragment_unnamed_5529) ? 4294967295u : 0u;
							float fragment_unnamed_6852;
							float fragment_unnamed_6854;
							float fragment_unnamed_6856;
							float fragment_unnamed_6858;
							if ((fragment_unnamed_5473 & fragment_unnamed_5531) != 0u)
							{
								float fragment_unnamed_6401 = asfloat(T7.Load((fragment_unnamed_4204 * 56u) + 16u).x);
								uint fragment_unnamed_6403 = (fragment_unnamed_4204 * 56u) + 34u;
								uint2 fragment_unnamed_6409 = uint2(T7.Load(fragment_unnamed_6403).x, T7.Load(fragment_unnamed_6403 + 1u).x);
								float fragment_unnamed_6411 = asfloat(fragment_unnamed_6409.x);
								float fragment_unnamed_6413 = asfloat(fragment_unnamed_6409.y);
								float fragment_unnamed_7311;
								if ((((int(fragment_unnamed_5395) >= int(0u)) ? 4294967295u : 0u) & ((0.0f < fragment_unnamed_6413) ? 4294967295u : 0u)) != 0u)
								{
									uint fragment_unnamed_6701 = fragment_unnamed_5395 * 60u;
									uint4 fragment_unnamed_6713 = uint4(T32.Load(fragment_unnamed_6701).x, T32.Load(fragment_unnamed_6701 + 1u).x, T32.Load(fragment_unnamed_6701 + 2u).x, T32.Load(fragment_unnamed_6701 + 3u).x);
									float fragment_unnamed_6715 = asfloat(fragment_unnamed_6713.w);
									float fragment_unnamed_6717 = asfloat(fragment_unnamed_6713.x);
									float fragment_unnamed_6719 = asfloat(fragment_unnamed_6713.y);
									float fragment_unnamed_6721 = asfloat(fragment_unnamed_6713.z);
									uint fragment_unnamed_6723 = (fragment_unnamed_5395 * 60u) + 4u;
									uint4 fragment_unnamed_6735 = uint4(T32.Load(fragment_unnamed_6723).x, T32.Load(fragment_unnamed_6723 + 1u).x, T32.Load(fragment_unnamed_6723 + 2u).x, T32.Load(fragment_unnamed_6723 + 3u).x);
									uint fragment_unnamed_6736 = fragment_unnamed_6735.x;
									uint fragment_unnamed_6737 = fragment_unnamed_6735.y;
									uint fragment_unnamed_6738 = fragment_unnamed_6735.z;
									uint fragment_unnamed_6739 = fragment_unnamed_6735.w;
									uint fragment_unnamed_6741 = (fragment_unnamed_5395 * 60u) + 8u;
									uint4 fragment_unnamed_6753 = uint4(T32.Load(fragment_unnamed_6741).x, T32.Load(fragment_unnamed_6741 + 1u).x, T32.Load(fragment_unnamed_6741 + 2u).x, T32.Load(fragment_unnamed_6741 + 3u).x);
									float fragment_unnamed_6755 = asfloat(fragment_unnamed_6753.y);
									float fragment_unnamed_6757 = asfloat(fragment_unnamed_6753.z);
									float fragment_unnamed_6759 = asfloat(fragment_unnamed_6753.x);
									float fragment_unnamed_6761 = asfloat(fragment_unnamed_6753.w);
									uint fragment_unnamed_6763 = (fragment_unnamed_5395 * 60u) + 12u;
									uint4 fragment_unnamed_6775 = uint4(T32.Load(fragment_unnamed_6763).x, T32.Load(fragment_unnamed_6763 + 1u).x, T32.Load(fragment_unnamed_6763 + 2u).x, T32.Load(fragment_unnamed_6763 + 3u).x);
									float fragment_unnamed_6777 = asfloat(fragment_unnamed_6775.x);
									float fragment_unnamed_6779 = asfloat(fragment_unnamed_6775.y);
									float fragment_unnamed_6781 = asfloat(fragment_unnamed_6775.z);
									uint fragment_unnamed_6782 = fragment_unnamed_6775.w;
									uint fragment_unnamed_6784 = (fragment_unnamed_5395 * 60u) + 16u;
									uint2 fragment_unnamed_6790 = uint2(T32.Load(fragment_unnamed_6784).x, T32.Load(fragment_unnamed_6784 + 1u).x);
									float fragment_unnamed_6792 = asfloat(fragment_unnamed_6790.x);
									float fragment_unnamed_6794 = asfloat(fragment_unnamed_6790.y);
									uint fragment_unnamed_6796 = (fragment_unnamed_5395 * 60u) + 24u;
									uint2 fragment_unnamed_6802 = uint2(T32.Load(fragment_unnamed_6796).x, T32.Load(fragment_unnamed_6796 + 1u).x);
									float fragment_unnamed_6804 = asfloat(fragment_unnamed_6802.x);
									float fragment_unnamed_6806 = asfloat(fragment_unnamed_6802.y);
									uint fragment_unnamed_6808 = (fragment_unnamed_5395 * 60u) + 28u;
									uint4 fragment_unnamed_6820 = uint4(T32.Load(fragment_unnamed_6808).x, T32.Load(fragment_unnamed_6808 + 1u).x, T32.Load(fragment_unnamed_6808 + 2u).x, T32.Load(fragment_unnamed_6808 + 3u).x);
									float fragment_unnamed_6822 = asfloat(fragment_unnamed_6820.x);
									float fragment_unnamed_6824 = asfloat(fragment_unnamed_6820.y);
									float fragment_unnamed_6826 = asfloat(fragment_unnamed_6820.z);
									uint fragment_unnamed_6827 = fragment_unnamed_6820.w;
									uint fragment_unnamed_6829 = (fragment_unnamed_5395 * 60u) + 40u;
									uint4 fragment_unnamed_6841 = uint4(T32.Load(fragment_unnamed_6829).x, T32.Load(fragment_unnamed_6829 + 1u).x, T32.Load(fragment_unnamed_6829 + 2u).x, T32.Load(fragment_unnamed_6829 + 3u).x);
									float fragment_unnamed_6843 = asfloat(fragment_unnamed_6841.x);
									float fragment_unnamed_6845 = asfloat(fragment_unnamed_6841.y);
									float fragment_unnamed_6847 = asfloat(fragment_unnamed_6841.z);
									float fragment_unnamed_6849 = asfloat(fragment_unnamed_6841.w);
									float fragment_unnamed_7695;
									if (0.0f < fragment_unnamed_6849)
									{
										bool fragment_unnamed_7050 = 0.0f != fragment_unnamed_6849;
										uint4 fragment_unnamed_7054 = asuint(fragment_uniform_buffer_0[101u]);
										uint4 fragment_unnamed_7060 = asuint(fragment_uniform_buffer_0[99u]);
										float fragment_unnamed_7064 = asfloat(fragment_unnamed_7050 ? fragment_unnamed_7054.z : fragment_unnamed_7060.z);
										float fragment_unnamed_7066 = asfloat(fragment_unnamed_7050 ? fragment_unnamed_7054.w : fragment_unnamed_7060.w);
										float fragment_unnamed_7079 = ((-0.0f) - fragment_unnamed_6755) + (fragment_unnamed_6843 + fragment_input_5.x);
										float fragment_unnamed_7080 = ((-0.0f) - fragment_unnamed_6757) + (fragment_unnamed_6845 + fragment_input_5.y);
										float fragment_unnamed_7081 = ((-0.0f) - fragment_unnamed_6761) + (fragment_unnamed_6847 + fragment_input_5.z);
										float fragment_unnamed_7092 = dot(float3(asfloat(fragment_unnamed_6738), asfloat(fragment_unnamed_6739), fragment_unnamed_6759), float3(fragment_unnamed_7079, fragment_unnamed_7080, fragment_unnamed_7081));
										float fragment_unnamed_7095 = dot(float3(fragment_unnamed_6717, fragment_unnamed_6719, fragment_unnamed_6721), float3(fragment_unnamed_7079, fragment_unnamed_7080, fragment_unnamed_7081)) * fragment_unnamed_6777;
										float fragment_unnamed_7096 = dot(float3(fragment_unnamed_6715, asfloat(fragment_unnamed_6736), asfloat(fragment_unnamed_6737)), float3(fragment_unnamed_7079, fragment_unnamed_7080, fragment_unnamed_7081)) * fragment_unnamed_6779;
										float fragment_unnamed_7098 = dot(float2(fragment_unnamed_6781, asfloat(fragment_unnamed_6782)), float2(fragment_unnamed_7092, fragment_unnamed_3213));
										bool fragment_unnamed_7101 = fragment_unnamed_7092 != (-0.0f);
										float fragment_unnamed_7102 = (-0.0f) - fragment_unnamed_7092;
										float fragment_unnamed_7124 = mad(fragment_unnamed_6804 * clamp(mad(asfloat(fragment_unnamed_7101 ? asuint(fragment_unnamed_7095 / fragment_unnamed_7102) : asuint(fragment_unnamed_7095)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7064, fragment_unnamed_6792);
										float fragment_unnamed_7125 = mad(fragment_unnamed_6806 * clamp(mad(asfloat(fragment_unnamed_7101 ? asuint(fragment_unnamed_7096 / fragment_unnamed_7102) : asuint(fragment_unnamed_7096)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7066, fragment_unnamed_6794);
										float fragment_unnamed_7126 = trunc(mad(min(asfloat(fragment_unnamed_6827), 4.0f), 4.0f, 1.0f));
										float fragment_unnamed_7127 = (-0.0f) - fragment_unnamed_7126;
										float4 fragment_unnamed_7148 = _CachedAreaLightShadowmapAtlas.SampleLevel(S0, float2(fragment_unnamed_7124, fragment_unnamed_7125), 0.0f);
										float fragment_unnamed_7150 = fragment_unnamed_7148.x;
										float fragment_unnamed_7154 = exp2(mad(((-0.0f) - asfloat(fragment_unnamed_7101 ? asuint(fragment_unnamed_7098 / fragment_unnamed_7102) : asuint(fragment_unnamed_7098))) + 1.0f, 2.0f, -1.0f) * fragment_unnamed_6822);
										float fragment_unnamed_7155 = fragment_unnamed_7154 * fragment_unnamed_6822;
										float fragment_unnamed_7160 = max(fragment_unnamed_6826 * (fragment_unnamed_7155 * fragment_unnamed_7155), mad((-0.0f) - fragment_unnamed_7150, fragment_unnamed_7150, fragment_unnamed_7148.y));
										float fragment_unnamed_7162 = ((-0.0f) - fragment_unnamed_7150) + fragment_unnamed_7154;
										fragment_unnamed_7695 = asfloat((((((mad(mad(fragment_unnamed_7127, 0.5f, fragment_unnamed_6806), fragment_unnamed_7066, fragment_unnamed_6794) < fragment_unnamed_7125) ? 4294967295u : 0u) | ((mad(mad(fragment_unnamed_7127, 0.5f, fragment_unnamed_6804), fragment_unnamed_7064, fragment_unnamed_6792) < fragment_unnamed_7124) ? 4294967295u : 0u)) | (((fragment_unnamed_7125 < mad(fragment_unnamed_7066, fragment_unnamed_7126, fragment_unnamed_6794)) ? 4294967295u : 0u) | ((fragment_unnamed_7124 < mad(fragment_unnamed_7064, fragment_unnamed_7126, fragment_unnamed_6792)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(max(asfloat(((fragment_unnamed_7150 >= fragment_unnamed_7154) ? 4294967295u : 0u) & 1065353216u), clamp((((-0.0f) - fragment_unnamed_6824) + (fragment_unnamed_7160 / mad(fragment_unnamed_7162, fragment_unnamed_7162, fragment_unnamed_7160))) / (((-0.0f) - fragment_unnamed_6824) + 1.0f), 0.0f, 1.0f))));
									}
									else
									{
										bool fragment_unnamed_7183 = 0.0f != fragment_unnamed_6849;
										uint4 fragment_unnamed_7186 = asuint(fragment_uniform_buffer_0[101u]);
										uint4 fragment_unnamed_7191 = asuint(fragment_uniform_buffer_0[99u]);
										float fragment_unnamed_7195 = asfloat(fragment_unnamed_7183 ? fragment_unnamed_7186.z : fragment_unnamed_7191.z);
										float fragment_unnamed_7197 = asfloat(fragment_unnamed_7183 ? fragment_unnamed_7186.w : fragment_unnamed_7191.w);
										float fragment_unnamed_7210 = ((-0.0f) - fragment_unnamed_6755) + (fragment_unnamed_6843 + fragment_input_5.x);
										float fragment_unnamed_7211 = ((-0.0f) - fragment_unnamed_6757) + (fragment_unnamed_6845 + fragment_input_5.y);
										float fragment_unnamed_7212 = ((-0.0f) - fragment_unnamed_6761) + (fragment_unnamed_6847 + fragment_input_5.z);
										float fragment_unnamed_7223 = dot(float3(asfloat(fragment_unnamed_6738), asfloat(fragment_unnamed_6739), fragment_unnamed_6759), float3(fragment_unnamed_7210, fragment_unnamed_7211, fragment_unnamed_7212));
										float fragment_unnamed_7226 = dot(float3(fragment_unnamed_6717, fragment_unnamed_6719, fragment_unnamed_6721), float3(fragment_unnamed_7210, fragment_unnamed_7211, fragment_unnamed_7212)) * fragment_unnamed_6777;
										float fragment_unnamed_7227 = dot(float3(fragment_unnamed_6715, asfloat(fragment_unnamed_6736), asfloat(fragment_unnamed_6737)), float3(fragment_unnamed_7210, fragment_unnamed_7211, fragment_unnamed_7212)) * fragment_unnamed_6779;
										float fragment_unnamed_7229 = dot(float2(fragment_unnamed_6781, asfloat(fragment_unnamed_6782)), float2(fragment_unnamed_7223, fragment_unnamed_3214));
										bool fragment_unnamed_7232 = fragment_unnamed_7223 != (-0.0f);
										float fragment_unnamed_7233 = (-0.0f) - fragment_unnamed_7223;
										float fragment_unnamed_7255 = mad(fragment_unnamed_6804 * clamp(mad(asfloat(fragment_unnamed_7232 ? asuint(fragment_unnamed_7226 / fragment_unnamed_7233) : asuint(fragment_unnamed_7226)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7195, fragment_unnamed_6792);
										float fragment_unnamed_7256 = mad(fragment_unnamed_6806 * clamp(mad(asfloat(fragment_unnamed_7232 ? asuint(fragment_unnamed_7227 / fragment_unnamed_7233) : asuint(fragment_unnamed_7227)), 0.5f, 0.5f), 0.0f, 1.0f), fragment_unnamed_7197, fragment_unnamed_6794);
										float fragment_unnamed_7257 = trunc(mad(min(asfloat(fragment_unnamed_6827), 4.0f), 4.0f, 1.0f));
										float fragment_unnamed_7258 = (-0.0f) - fragment_unnamed_7257;
										float4 fragment_unnamed_7279 = _ShadowmapAreaAtlas.SampleLevel(S0, float2(fragment_unnamed_7255, fragment_unnamed_7256), 0.0f);
										float fragment_unnamed_7281 = fragment_unnamed_7279.x;
										float fragment_unnamed_7285 = exp2(mad(((-0.0f) - asfloat(fragment_unnamed_7232 ? asuint(fragment_unnamed_7229 / fragment_unnamed_7233) : asuint(fragment_unnamed_7229))) + 1.0f, 2.0f, -1.0f) * fragment_unnamed_6822);
										float fragment_unnamed_7286 = fragment_unnamed_7285 * fragment_unnamed_6822;
										float fragment_unnamed_7291 = max(fragment_unnamed_6826 * (fragment_unnamed_7286 * fragment_unnamed_7286), mad((-0.0f) - fragment_unnamed_7281, fragment_unnamed_7281, fragment_unnamed_7279.y));
										float fragment_unnamed_7293 = ((-0.0f) - fragment_unnamed_7281) + fragment_unnamed_7285;
										fragment_unnamed_7695 = asfloat((((((mad(mad(fragment_unnamed_7258, 0.5f, fragment_unnamed_6806), fragment_unnamed_7197, fragment_unnamed_6794) < fragment_unnamed_7256) ? 4294967295u : 0u) | ((mad(mad(fragment_unnamed_7258, 0.5f, fragment_unnamed_6804), fragment_unnamed_7195, fragment_unnamed_6792) < fragment_unnamed_7255) ? 4294967295u : 0u)) | (((fragment_unnamed_7256 < mad(fragment_unnamed_7197, fragment_unnamed_7257, fragment_unnamed_6794)) ? 4294967295u : 0u) | ((fragment_unnamed_7255 < mad(fragment_unnamed_7195, fragment_unnamed_7257, fragment_unnamed_6792)) ? 4294967295u : 0u))) != 0u) ? 1065353216u : asuint(max(asfloat(((fragment_unnamed_7281 >= fragment_unnamed_7285) ? 4294967295u : 0u) & 1065353216u), clamp((((-0.0f) - fragment_unnamed_6824) + (fragment_unnamed_7291 / mad(fragment_unnamed_7293, fragment_unnamed_7293, fragment_unnamed_7291))) / (((-0.0f) - fragment_unnamed_6824) + 1.0f), 0.0f, 1.0f))));
									}
									fragment_unnamed_7311 = mad(fragment_unnamed_6413, fragment_unnamed_7695 + (-1.0f), 1.0f);
								}
								else
								{
									fragment_unnamed_7311 = asfloat(1065353216u);
								}
								float fragment_unnamed_7313 = asfloat(fragment_unnamed_5453.z);
								float fragment_unnamed_7314 = asfloat(fragment_unnamed_5453.w);
								float fragment_unnamed_7318 = ((-0.0f) - fragment_unnamed_7313) + 1.0f;
								float fragment_unnamed_7319 = ((-0.0f) - fragment_unnamed_7314) + 1.0f;
								float fragment_unnamed_7320 = ((-0.0f) - fragment_unnamed_6411) + 1.0f;
								float fragment_unnamed_7322 = fragment_unnamed_7311 * (fragment_unnamed_7311 * fragment_unnamed_7311);
								float fragment_unnamed_7325 = (-0.0f) - (((-0.0f) - fragment_unnamed_7311) + 1.0f);
								float fragment_unnamed_7326 = mad(fragment_unnamed_7325, fragment_unnamed_7318, 1.0f);
								float fragment_unnamed_7327 = mad(fragment_unnamed_7325, fragment_unnamed_7319, 1.0f);
								float fragment_unnamed_7328 = mad(fragment_unnamed_7325, fragment_unnamed_7320, 1.0f);
								float fragment_unnamed_6853 = mad(fragment_unnamed_6401, ((-0.0f) - fragment_unnamed_7326) + mad(fragment_unnamed_7322, fragment_unnamed_7318, fragment_unnamed_7313 * fragment_unnamed_7311), fragment_unnamed_7326) * fragment_unnamed_5413;
								float fragment_unnamed_6855 = mad(fragment_unnamed_6401, ((-0.0f) - fragment_unnamed_7327) + mad(fragment_unnamed_7322, fragment_unnamed_7319, fragment_unnamed_7314 * fragment_unnamed_7311), fragment_unnamed_7327) * fragment_unnamed_5415;
								float fragment_unnamed_6857 = mad(fragment_unnamed_6401, ((-0.0f) - fragment_unnamed_7328) + mad(fragment_unnamed_7322, fragment_unnamed_7320, fragment_unnamed_6411 * fragment_unnamed_7311), fragment_unnamed_7328) * asfloat(fragment_unnamed_5433);
								fragment_unnamed_6852 = fragment_unnamed_6853;
								fragment_unnamed_6854 = fragment_unnamed_6855;
								fragment_unnamed_6856 = fragment_unnamed_6857;
								fragment_unnamed_6858 = asfloat((0.0f < max(fragment_unnamed_6857, max(fragment_unnamed_6855, fragment_unnamed_6853))) ? 4294967295u : 0u);
							}
							else
							{
								fragment_unnamed_6852 = fragment_unnamed_5413;
								fragment_unnamed_6854 = fragment_unnamed_5415;
								fragment_unnamed_6856 = asfloat(fragment_unnamed_5433);
								fragment_unnamed_6858 = asfloat(4294967295u);
							}
							float fragment_unnamed_7715;
							float fragment_unnamed_7717;
							float fragment_unnamed_7719;
							float fragment_unnamed_7721;
							float fragment_unnamed_7723;
							float fragment_unnamed_7725;
							if ((fragment_unnamed_5531 & asuint(fragment_unnamed_6858)) != 0u)
							{
								uint fragment_unnamed_7350 = (fragment_unnamed_4204 * 56u) + 49u;
								uint2 fragment_unnamed_7356 = uint2(T7.Load(fragment_unnamed_7350).x, T7.Load(fragment_unnamed_7350 + 1u).x);
								float fragment_unnamed_7361 = dot(float3(fragment_unnamed_1304, fragment_unnamed_3211, fragment_unnamed_3212), float3(fragment_unnamed_5483, fragment_unnamed_5484, fragment_unnamed_5485));
								float fragment_unnamed_7364 = dot(float3(fragment_unnamed_1294, fragment_unnamed_1296, fragment_unnamed_3215), float3(fragment_unnamed_5483, fragment_unnamed_5484, fragment_unnamed_5485));
								float fragment_unnamed_7367 = dot(float3(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822), float3(fragment_unnamed_5483, fragment_unnamed_5484, fragment_unnamed_5485));
								float fragment_unnamed_7370 = dot(float3(fragment_unnamed_1304, fragment_unnamed_3211, fragment_unnamed_3212), float3(fragment_unnamed_5375, fragment_unnamed_5377, fragment_unnamed_5379));
								float fragment_unnamed_7373 = dot(float3(fragment_unnamed_1294, fragment_unnamed_1296, fragment_unnamed_3215), float3(fragment_unnamed_5375, fragment_unnamed_5377, fragment_unnamed_5379));
								float fragment_unnamed_7376 = dot(float3(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822), float3(fragment_unnamed_5375, fragment_unnamed_5377, fragment_unnamed_5379));
								float fragment_unnamed_7379 = dot(float3(fragment_unnamed_1304, fragment_unnamed_3211, fragment_unnamed_3212), float3(fragment_unnamed_5495, fragment_unnamed_5496, fragment_unnamed_5497));
								float fragment_unnamed_7382 = dot(float3(fragment_unnamed_1294, fragment_unnamed_1296, fragment_unnamed_3215), float3(fragment_unnamed_5495, fragment_unnamed_5496, fragment_unnamed_5497));
								float fragment_unnamed_7385 = dot(float3(fragment_unnamed_820, fragment_unnamed_821, fragment_unnamed_822), float3(fragment_unnamed_5495, fragment_unnamed_5496, fragment_unnamed_5497));
								float fragment_unnamed_7394 = mad(fragment_unnamed_7364, fragment_unnamed_7376, (-0.0f) - (fragment_unnamed_7373 * fragment_unnamed_7367));
								float fragment_unnamed_7395 = mad(fragment_unnamed_7367, fragment_unnamed_7370, (-0.0f) - (fragment_unnamed_7376 * fragment_unnamed_7361));
								float fragment_unnamed_7396 = mad(fragment_unnamed_7361, fragment_unnamed_7373, (-0.0f) - (fragment_unnamed_7370 * fragment_unnamed_7364));
								float fragment_unnamed_7397 = dot(float3(fragment_unnamed_7394, fragment_unnamed_7395, fragment_unnamed_7396), float3(fragment_unnamed_7394, fragment_unnamed_7395, fragment_unnamed_7396));
								uint fragment_unnamed_7408 = ((fragment_unnamed_7397 == 0.0f) ? 4294967295u : 0u) | ((0.0f >= mad(fragment_unnamed_5487, abs(fragment_unnamed_7385), mad(fragment_unnamed_5486, abs(fragment_unnamed_7376), fragment_unnamed_7367))) ? 4294967295u : 0u);
								float fragment_unnamed_7962;
								float fragment_unnamed_7964;
								float fragment_unnamed_7966;
								float fragment_unnamed_7968;
								if (fragment_unnamed_7408 == 0u)
								{
									float fragment_unnamed_7697 = dot(float2(fragment_unnamed_3216, fragment_unnamed_1235), float2(fragment_unnamed_7367, fragment_unnamed_7361));
									float fragment_unnamed_7700 = dot(float2(fragment_unnamed_3216, fragment_unnamed_1235), float2(fragment_unnamed_7376, fragment_unnamed_7370));
									float fragment_unnamed_7703 = dot(float2(fragment_unnamed_1235, fragment_unnamed_3216), float2(fragment_unnamed_7379, fragment_unnamed_7385));
									float fragment_unnamed_7963;
									float fragment_unnamed_7965;
									float fragment_unnamed_7967;
									float fragment_unnamed_7969;
									if (0.0f < mad(fragment_unnamed_5487, abs(fragment_unnamed_7703), mad(fragment_unnamed_5486, abs(fragment_unnamed_7700), fragment_unnamed_7697)))
									{
										float fragment_unnamed_7950 = dot(float2(fragment_unnamed_1237, fragment_unnamed_1234), float2(fragment_unnamed_7367, fragment_unnamed_7361));
										float fragment_unnamed_7953 = fragment_unnamed_1236 * fragment_unnamed_7364;
										float fragment_unnamed_7954 = dot(float2(fragment_unnamed_1237, fragment_unnamed_1234), float2(fragment_unnamed_7376, fragment_unnamed_7370));
										float fragment_unnamed_7957 = fragment_unnamed_1236 * fragment_unnamed_7373;
										float fragment_unnamed_9016;
										float fragment_unnamed_9017;
										float fragment_unnamed_9018;
										float fragment_unnamed_9019;
										if (fragment_unnamed_5472)
										{
											float fragment_unnamed_8676 = dot(float2(fragment_unnamed_1234, fragment_unnamed_1237), float2(fragment_unnamed_7379, fragment_unnamed_7385));
											float fragment_unnamed_8679 = fragment_unnamed_7382 * fragment_unnamed_1236;
											float fragment_unnamed_8680 = (-0.0f) - fragment_unnamed_5486;
											float fragment_unnamed_8684 = (-0.0f) - fragment_unnamed_5487;
											float fragment_unnamed_8685 = mad(fragment_unnamed_8684, fragment_unnamed_8676, mad(fragment_unnamed_8680, fragment_unnamed_7954, fragment_unnamed_7950));
											float fragment_unnamed_8686 = mad(fragment_unnamed_8684, fragment_unnamed_8679, mad(fragment_unnamed_8680, fragment_unnamed_7957, fragment_unnamed_7953));
											float fragment_unnamed_8687 = mad(fragment_unnamed_8684, fragment_unnamed_7703, mad(fragment_unnamed_8680, fragment_unnamed_7700, fragment_unnamed_7697));
											float fragment_unnamed_8688 = fragment_unnamed_5471 * fragment_unnamed_8676;
											float fragment_unnamed_8689 = fragment_unnamed_5471 * fragment_unnamed_8679;
											float fragment_unnamed_8690 = fragment_unnamed_5471 * fragment_unnamed_7703;
											float fragment_unnamed_8691 = mad(fragment_unnamed_5471, fragment_unnamed_7703, fragment_unnamed_8687);
											float fragment_unnamed_8692 = mad(fragment_unnamed_5471, fragment_unnamed_8676, fragment_unnamed_8685);
											float fragment_unnamed_8693 = mad(fragment_unnamed_5471, fragment_unnamed_8679, fragment_unnamed_8686);
											float fragment_unnamed_8694 = mad(fragment_unnamed_5469, fragment_unnamed_7700, fragment_unnamed_8691);
											float fragment_unnamed_8695 = mad(fragment_unnamed_5469, fragment_unnamed_7954, fragment_unnamed_8692);
											float fragment_unnamed_8696 = mad(fragment_unnamed_5469, fragment_unnamed_7957, fragment_unnamed_8693);
											float fragment_unnamed_8697 = (-0.0f) - fragment_unnamed_5471;
											float fragment_unnamed_8698 = mad(fragment_unnamed_8697, fragment_unnamed_8676, fragment_unnamed_8695);
											float fragment_unnamed_8699 = mad(fragment_unnamed_8697, fragment_unnamed_8679, fragment_unnamed_8696);
											float fragment_unnamed_8700 = mad(fragment_unnamed_8697, fragment_unnamed_7703, fragment_unnamed_8694);
											float fragment_unnamed_8704 = rsqrt(dot(float3(fragment_unnamed_8685, fragment_unnamed_8686, fragment_unnamed_8687), float3(fragment_unnamed_8685, fragment_unnamed_8686, fragment_unnamed_8687)));
											float fragment_unnamed_8705 = fragment_unnamed_8704 * fragment_unnamed_8686;
											float fragment_unnamed_8706 = fragment_unnamed_8704 * fragment_unnamed_8687;
											float fragment_unnamed_8707 = fragment_unnamed_8704 * fragment_unnamed_8685;
											float fragment_unnamed_8711 = rsqrt(dot(float3(fragment_unnamed_8691, fragment_unnamed_8692, fragment_unnamed_8693), float3(fragment_unnamed_8691, fragment_unnamed_8692, fragment_unnamed_8693)));
											float fragment_unnamed_8712 = fragment_unnamed_8711 * fragment_unnamed_8691;
											float fragment_unnamed_8713 = fragment_unnamed_8711 * fragment_unnamed_8692;
											float fragment_unnamed_8714 = fragment_unnamed_8711 * fragment_unnamed_8693;
											float fragment_unnamed_8718 = rsqrt(dot(float3(fragment_unnamed_8694, fragment_unnamed_8695, fragment_unnamed_8696), float3(fragment_unnamed_8694, fragment_unnamed_8695, fragment_unnamed_8696)));
											float fragment_unnamed_8719 = fragment_unnamed_8718 * fragment_unnamed_8694;
											float fragment_unnamed_8720 = fragment_unnamed_8718 * fragment_unnamed_8695;
											float fragment_unnamed_8721 = fragment_unnamed_8718 * fragment_unnamed_8696;
											float fragment_unnamed_8725 = rsqrt(dot(float3(fragment_unnamed_8698, fragment_unnamed_8699, fragment_unnamed_8700), float3(fragment_unnamed_8698, fragment_unnamed_8699, fragment_unnamed_8700)));
											float fragment_unnamed_8726 = fragment_unnamed_8725 * fragment_unnamed_8700;
											float fragment_unnamed_8727 = fragment_unnamed_8725 * fragment_unnamed_8698;
											float fragment_unnamed_8728 = fragment_unnamed_8725 * fragment_unnamed_8699;
											float fragment_unnamed_8729 = dot(float3(fragment_unnamed_8706, fragment_unnamed_8707, fragment_unnamed_8705), float3(fragment_unnamed_8712, fragment_unnamed_8713, fragment_unnamed_8714));
											float fragment_unnamed_8766 = mad(abs(fragment_unnamed_8729), mad(abs(fragment_unnamed_8729), mad(abs(fragment_unnamed_8729), mad(abs(fragment_unnamed_8729), mad(abs(fragment_unnamed_8729), mad(abs(fragment_unnamed_8729), mad(abs(fragment_unnamed_8729), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8774 = asfloat((fragment_unnamed_8729 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8729, fragment_unnamed_8729, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8766)) : asuint(fragment_unnamed_8766));
											float fragment_unnamed_8775 = dot(float3(fragment_unnamed_8712, fragment_unnamed_8713, fragment_unnamed_8714), float3(fragment_unnamed_8719, fragment_unnamed_8720, fragment_unnamed_8721));
											float fragment_unnamed_8805 = mad(abs(fragment_unnamed_8775), mad(abs(fragment_unnamed_8775), mad(abs(fragment_unnamed_8775), mad(abs(fragment_unnamed_8775), mad(abs(fragment_unnamed_8775), mad(abs(fragment_unnamed_8775), mad(abs(fragment_unnamed_8775), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8812 = asfloat((fragment_unnamed_8775 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8775, fragment_unnamed_8775, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8805)) : asuint(fragment_unnamed_8805));
											float fragment_unnamed_8819 = dot(float3(fragment_unnamed_8719, fragment_unnamed_8720, fragment_unnamed_8721), float3(fragment_unnamed_8726, fragment_unnamed_8727, fragment_unnamed_8728));
											float fragment_unnamed_8849 = mad(abs(fragment_unnamed_8819), mad(abs(fragment_unnamed_8819), mad(abs(fragment_unnamed_8819), mad(abs(fragment_unnamed_8819), mad(abs(fragment_unnamed_8819), mad(abs(fragment_unnamed_8819), mad(abs(fragment_unnamed_8819), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8856 = asfloat((fragment_unnamed_8819 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8819, fragment_unnamed_8819, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8849)) : asuint(fragment_unnamed_8849));
											float fragment_unnamed_8860 = dot(float3(fragment_unnamed_8728, fragment_unnamed_8726, fragment_unnamed_8727), float3(fragment_unnamed_8705, fragment_unnamed_8706, fragment_unnamed_8707));
											float fragment_unnamed_8890 = mad(abs(fragment_unnamed_8860), mad(abs(fragment_unnamed_8860), mad(abs(fragment_unnamed_8860), mad(abs(fragment_unnamed_8860), mad(abs(fragment_unnamed_8860), mad(abs(fragment_unnamed_8860), mad(abs(fragment_unnamed_8860), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_8897 = asfloat((fragment_unnamed_8860 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_8860, fragment_unnamed_8860, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_8890)) : asuint(fragment_unnamed_8890));
											float fragment_unnamed_8900 = mad(mad(fragment_unnamed_8727, fragment_unnamed_8705, (-0.0f) - (fragment_unnamed_8707 * fragment_unnamed_8728)), fragment_unnamed_8897, mad(mad(fragment_unnamed_8720, fragment_unnamed_8728, (-0.0f) - (fragment_unnamed_8721 * fragment_unnamed_8727)), fragment_unnamed_8856, mad(mad(fragment_unnamed_8707, fragment_unnamed_8714, (-0.0f) - (fragment_unnamed_8713 * fragment_unnamed_8705)), fragment_unnamed_8774, fragment_unnamed_8812 * mad(fragment_unnamed_8713, fragment_unnamed_8721, (-0.0f) - (fragment_unnamed_8714 * fragment_unnamed_8720)))));
											float fragment_unnamed_8901 = mad(mad(fragment_unnamed_8728, fragment_unnamed_8706, (-0.0f) - (fragment_unnamed_8705 * fragment_unnamed_8726)), fragment_unnamed_8897, mad(mad(fragment_unnamed_8721, fragment_unnamed_8726, (-0.0f) - (fragment_unnamed_8719 * fragment_unnamed_8728)), fragment_unnamed_8856, mad(mad(fragment_unnamed_8705, fragment_unnamed_8712, (-0.0f) - (fragment_unnamed_8714 * fragment_unnamed_8706)), fragment_unnamed_8774, fragment_unnamed_8812 * mad(fragment_unnamed_8714, fragment_unnamed_8719, (-0.0f) - (fragment_unnamed_8712 * fragment_unnamed_8721))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_8902 = mad(mad(fragment_unnamed_8726, fragment_unnamed_8707, (-0.0f) - (fragment_unnamed_8706 * fragment_unnamed_8727)), fragment_unnamed_8897, mad(mad(fragment_unnamed_8719, fragment_unnamed_8727, (-0.0f) - (fragment_unnamed_8720 * fragment_unnamed_8726)), fragment_unnamed_8856, mad(mad(fragment_unnamed_8706, fragment_unnamed_8713, (-0.0f) - (fragment_unnamed_8712 * fragment_unnamed_8707)), fragment_unnamed_8774, fragment_unnamed_8812 * mad(fragment_unnamed_8712, fragment_unnamed_8720, (-0.0f) - (fragment_unnamed_8713 * fragment_unnamed_8719))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_8903 = fragment_unnamed_8900 * 0.15915493667125701904296875f;
											float fragment_unnamed_8904 = dot(float3(fragment_unnamed_8901, fragment_unnamed_8902, fragment_unnamed_8903), float3(fragment_unnamed_8901, fragment_unnamed_8902, fragment_unnamed_8903));
											float fragment_unnamed_9188;
											float fragment_unnamed_9189;
											float fragment_unnamed_9190;
											if (fragment_unnamed_5394 != 0u)
											{
												float fragment_unnamed_9056 = ((-0.0f) - fragment_unnamed_8685) + fragment_unnamed_8698;
												float fragment_unnamed_9057 = ((-0.0f) - fragment_unnamed_8686) + fragment_unnamed_8699;
												float fragment_unnamed_9058 = ((-0.0f) - fragment_unnamed_8687) + fragment_unnamed_8700;
												float fragment_unnamed_9065 = mad(fragment_unnamed_9057, fragment_unnamed_8690, (-0.0f) - (fragment_unnamed_8689 * fragment_unnamed_9058));
												float fragment_unnamed_9066 = mad(fragment_unnamed_9058, fragment_unnamed_8688, (-0.0f) - (fragment_unnamed_8690 * fragment_unnamed_9056));
												float fragment_unnamed_9067 = mad(fragment_unnamed_9056, fragment_unnamed_8689, (-0.0f) - (fragment_unnamed_8688 * fragment_unnamed_9057));
												float fragment_unnamed_9071 = rsqrt(dot(float3(fragment_unnamed_9065, fragment_unnamed_9066, fragment_unnamed_9067), float3(fragment_unnamed_9065, fragment_unnamed_9066, fragment_unnamed_9067)));
												float fragment_unnamed_9072 = fragment_unnamed_9071 * fragment_unnamed_9065;
												float fragment_unnamed_9073 = fragment_unnamed_9071 * fragment_unnamed_9066;
												float fragment_unnamed_9074 = fragment_unnamed_9071 * fragment_unnamed_9067;
												float fragment_unnamed_9081 = dot(float3(fragment_unnamed_8685, fragment_unnamed_8686, fragment_unnamed_8687), float3(fragment_unnamed_9072, fragment_unnamed_9073, fragment_unnamed_9074)) / dot(float3(fragment_unnamed_8901, fragment_unnamed_8902, fragment_unnamed_8903), float3(fragment_unnamed_9072, fragment_unnamed_9073, fragment_unnamed_9074));
												float fragment_unnamed_9085 = mad(fragment_unnamed_9081, fragment_unnamed_9072, (-0.0f) - fragment_unnamed_8685);
												float fragment_unnamed_9086 = mad(fragment_unnamed_9081, fragment_unnamed_9073, (-0.0f) - fragment_unnamed_8686);
												float fragment_unnamed_9087 = mad(fragment_unnamed_9081, fragment_unnamed_9074, (-0.0f) - fragment_unnamed_8687);
												float fragment_unnamed_9091 = 1.0f / dot(float3(fragment_unnamed_9056, fragment_unnamed_9057, fragment_unnamed_9058), float3(fragment_unnamed_9056, fragment_unnamed_9057, fragment_unnamed_9058));
												float fragment_unnamed_9092 = dot(float3(fragment_unnamed_8688, fragment_unnamed_8689, fragment_unnamed_8690), float3(fragment_unnamed_9056, fragment_unnamed_9057, fragment_unnamed_9058));
												float fragment_unnamed_9101 = mad((-0.0f) - (fragment_unnamed_9056 * fragment_unnamed_9092), fragment_unnamed_9091, fragment_unnamed_8688);
												float fragment_unnamed_9102 = mad((-0.0f) - (fragment_unnamed_9057 * fragment_unnamed_9092), fragment_unnamed_9091, fragment_unnamed_8689);
												float fragment_unnamed_9103 = mad((-0.0f) - (fragment_unnamed_9058 * fragment_unnamed_9092), fragment_unnamed_9091, fragment_unnamed_8690);
												float fragment_unnamed_9110 = dot(float3(fragment_unnamed_9085, fragment_unnamed_9086, fragment_unnamed_9087), float3(fragment_unnamed_9101, fragment_unnamed_9102, fragment_unnamed_9103)) / dot(float3(fragment_unnamed_9101, fragment_unnamed_9102, fragment_unnamed_9103), float3(fragment_unnamed_9101, fragment_unnamed_9102, fragment_unnamed_9103));
												float fragment_unnamed_9124 = round(log2(fragment_unnamed_5437 * fragment_uniform_buffer_0[122u].x));
												float fragment_unnamed_9132 = min(fragment_unnamed_9124, max(mad(log2(mad(fragment_unnamed_9071 * (fragment_unnamed_9081 * fragment_unnamed_9081), 3.1415927410125732421875f, 9.9999999392252902907785028219223e-09f)), 0.5f, fragment_unnamed_9124), 0.0f));
												float fragment_unnamed_9146 = 1.0f / (fragment_unnamed_5437 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_9147 = 1.0f / (fragment_unnamed_5439 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_9157 = exp2(ceil(max(fragment_unnamed_9132 + ((-0.0f) - fragment_uniform_buffer_0[123u].z), 0.0f)));
												float fragment_unnamed_9161 = fragment_unnamed_5437 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_9162 = fragment_unnamed_5439 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_9165 = fragment_unnamed_9157 / (fragment_unnamed_9161 + fragment_unnamed_9161);
												float fragment_unnamed_9166 = fragment_unnamed_9157 / (fragment_unnamed_9162 + fragment_unnamed_9162);
												float4 fragment_unnamed_9180 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_9165) + 1.0f, max(fragment_unnamed_9165, mad(clamp(mad((-0.0f) - mad((-0.0f) - fragment_unnamed_9092, fragment_unnamed_9110, dot(float3(fragment_unnamed_9085, fragment_unnamed_9086, fragment_unnamed_9087), float3(fragment_unnamed_9056, fragment_unnamed_9057, fragment_unnamed_9058))), fragment_unnamed_9091, 1.0f), 0.0f, 1.0f), fragment_unnamed_5437 * fragment_unnamed_9146, mad((-0.0f) - fragment_unnamed_9146, fragment_unnamed_5437, 1.0f) * 0.5f))), fragment_unnamed_5437, fragment_unnamed_5455), mad(min(((-0.0f) - fragment_unnamed_9166) + 1.0f, max(fragment_unnamed_9166, mad(clamp(fragment_unnamed_9110, 0.0f, 1.0f), fragment_unnamed_5439 * fragment_unnamed_9147, mad((-0.0f) - fragment_unnamed_9147, fragment_unnamed_5439, 1.0f) * 0.5f))), fragment_unnamed_5439, fragment_unnamed_5457)), fragment_unnamed_9132);
												fragment_unnamed_9188 = fragment_unnamed_9180.x;
												fragment_unnamed_9189 = fragment_unnamed_9180.y;
												fragment_unnamed_9190 = fragment_unnamed_9180.z;
											}
											else
											{
												fragment_unnamed_9188 = asfloat(1065353216u);
												fragment_unnamed_9189 = asfloat(1065353216u);
												fragment_unnamed_9190 = asfloat(1065353216u);
											}
											fragment_unnamed_9016 = max(mad(fragment_unnamed_8900, 0.15915493667125701904296875f, fragment_unnamed_8904) / (sqrt(fragment_unnamed_8904) + 1.0f), 0.0f);
											fragment_unnamed_9017 = fragment_unnamed_9188;
											fragment_unnamed_9018 = fragment_unnamed_9189;
											fragment_unnamed_9019 = fragment_unnamed_9190;
										}
										else
										{
											float fragment_unnamed_8916 = fragment_unnamed_1236 * mad((-0.0f) - fragment_unnamed_1235, fragment_unnamed_7396, fragment_unnamed_7394);
											float fragment_unnamed_8917 = fragment_unnamed_3200 * fragment_unnamed_7395;
											float fragment_unnamed_8920 = fragment_unnamed_1236 * mad((-0.0f) - fragment_unnamed_1237, fragment_unnamed_7394, fragment_unnamed_1234 * fragment_unnamed_7396);
											float fragment_unnamed_8931 = (1.0f / fragment_unnamed_7700) * ((-0.0f) - fragment_unnamed_7697);
											bool fragment_unnamed_8932 = fragment_unnamed_7700 >= 0.0f;
											float fragment_unnamed_8947 = dot(float3(fragment_unnamed_7954, fragment_unnamed_7957, fragment_unnamed_7700), float3(fragment_unnamed_7954, fragment_unnamed_7957, fragment_unnamed_7700));
											float fragment_unnamed_8950 = rsqrt(fragment_unnamed_8947);
											float fragment_unnamed_8951 = fragment_unnamed_8947 * fragment_unnamed_8950;
											float fragment_unnamed_8952 = fragment_unnamed_8950 * fragment_unnamed_7954;
											float fragment_unnamed_8953 = fragment_unnamed_8950 * fragment_unnamed_7957;
											float fragment_unnamed_8954 = fragment_unnamed_8950 * fragment_unnamed_7700;
											float fragment_unnamed_8955 = dot(float3(fragment_unnamed_8952, fragment_unnamed_8953, fragment_unnamed_8954), float3(fragment_unnamed_7950, fragment_unnamed_7953, fragment_unnamed_7697));
											float fragment_unnamed_8958 = (-0.0f) - fragment_unnamed_8955;
											float fragment_unnamed_8959 = mad(fragment_unnamed_8958, fragment_unnamed_8952, fragment_unnamed_7950);
											float fragment_unnamed_8960 = mad(fragment_unnamed_8958, fragment_unnamed_8953, fragment_unnamed_7953);
											float fragment_unnamed_8961 = mad(fragment_unnamed_8958, fragment_unnamed_8954, fragment_unnamed_7697);
											float fragment_unnamed_8962 = dot(float3(fragment_unnamed_8959, fragment_unnamed_8960, fragment_unnamed_8961), float3(fragment_unnamed_8959, fragment_unnamed_8960, fragment_unnamed_8961));
											float fragment_unnamed_8965 = rsqrt(fragment_unnamed_8962);
											float fragment_unnamed_8967 = fragment_unnamed_8965 * fragment_unnamed_8961;
											float fragment_unnamed_8968 = mad(asfloat(fragment_unnamed_8932 ? asuint(max(fragment_unnamed_8931, fragment_unnamed_5486)) : asuint(min(fragment_unnamed_8931, fragment_unnamed_5486))), fragment_unnamed_8951, fragment_unnamed_8955);
											float fragment_unnamed_8969 = mad(asfloat(fragment_unnamed_8932 ? asuint(max(fragment_unnamed_8931, (-0.0f) - fragment_unnamed_5486)) : asuint(min(fragment_unnamed_8931, (-0.0f) - fragment_unnamed_5486))), fragment_unnamed_8951, fragment_unnamed_8955);
											float fragment_unnamed_8970 = mad(fragment_unnamed_8968, fragment_unnamed_8968, fragment_unnamed_8962);
											float fragment_unnamed_8971 = mad(fragment_unnamed_8969, fragment_unnamed_8969, fragment_unnamed_8962);
											float fragment_unnamed_8973 = rsqrt(fragment_unnamed_8970 * fragment_unnamed_8971);
											float fragment_unnamed_8974 = fragment_unnamed_8973 * fragment_unnamed_8973;
											float fragment_unnamed_8977 = (fragment_unnamed_8965 * fragment_unnamed_8962) * fragment_unnamed_8954;
											float fragment_unnamed_8987 = min(fragment_unnamed_8973 * mad(fragment_unnamed_8969, fragment_unnamed_8968, fragment_unnamed_8962), 1.0f);
											float fragment_unnamed_8991 = sqrt(((-0.0f) - abs(fragment_unnamed_8987)) + 1.0f);
											float fragment_unnamed_8997 = mad(mad(mad(abs(fragment_unnamed_8987), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_8987), -0.212114393711090087890625f), abs(fragment_unnamed_8987), 1.570728778839111328125f);
											fragment_unnamed_9016 = ((fragment_unnamed_7397 * (abs(fragment_unnamed_3201) * rsqrt(fragment_unnamed_7397 * dot(float3(fragment_unnamed_8916, fragment_unnamed_8917, fragment_unnamed_8920), float3(fragment_unnamed_8916, fragment_unnamed_8917, fragment_unnamed_8920))))) * max(mad(mad(fragment_unnamed_8997, fragment_unnamed_8991, asfloat(((fragment_unnamed_8987 < ((-0.0f) - fragment_unnamed_8987)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_8991 * fragment_unnamed_8997, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_8965 * fragment_unnamed_8967, mad(mad(fragment_unnamed_8967, fragment_unnamed_8968, (-0.0f) - fragment_unnamed_8977), fragment_unnamed_8971 * fragment_unnamed_8974, (-0.0f) - ((fragment_unnamed_8970 * fragment_unnamed_8974) * mad(fragment_unnamed_8967, fragment_unnamed_8969, (-0.0f) - fragment_unnamed_8977)))), 0.0f)) * 0.3183098733425140380859375f;
											fragment_unnamed_9017 = asfloat(1065353216u);
											fragment_unnamed_9018 = asfloat(1065353216u);
											fragment_unnamed_9019 = asfloat(1065353216u);
										}
										fragment_unnamed_7963 = fragment_unnamed_9016;
										fragment_unnamed_7965 = fragment_unnamed_9017;
										fragment_unnamed_7967 = fragment_unnamed_9018;
										fragment_unnamed_7969 = fragment_unnamed_9019;
									}
									else
									{
										fragment_unnamed_7963 = asfloat(0u);
										fragment_unnamed_7965 = asfloat(1065353216u);
										fragment_unnamed_7967 = asfloat(1065353216u);
										fragment_unnamed_7969 = asfloat(1065353216u);
									}
									fragment_unnamed_7962 = fragment_unnamed_7963;
									fragment_unnamed_7964 = fragment_unnamed_7965;
									fragment_unnamed_7966 = fragment_unnamed_7967;
									fragment_unnamed_7968 = fragment_unnamed_7969;
								}
								else
								{
									fragment_unnamed_7962 = asfloat(0u);
									fragment_unnamed_7964 = asfloat(1065353216u);
									fragment_unnamed_7966 = asfloat(1065353216u);
									fragment_unnamed_7968 = asfloat(1065353216u);
								}
								float fragment_unnamed_7972 = (asfloat(fragment_unnamed_7356.x) * fragment_unnamed_5529) * fragment_unnamed_7962;
								float fragment_unnamed_9203;
								float fragment_unnamed_9205;
								float fragment_unnamed_9207;
								float fragment_unnamed_9209;
								if (fragment_unnamed_7408 == 0u)
								{
									float fragment_unnamed_9020 = dot(float2(fragment_unnamed_3217, fragment_unnamed_1241), float2(fragment_unnamed_7367, fragment_unnamed_7361));
									float fragment_unnamed_9023 = dot(float2(fragment_unnamed_3217, fragment_unnamed_1241), float2(fragment_unnamed_7376, fragment_unnamed_7370));
									float fragment_unnamed_9026 = dot(float2(fragment_unnamed_1241, fragment_unnamed_3217), float2(fragment_unnamed_7379, fragment_unnamed_7385));
									float fragment_unnamed_9204;
									float fragment_unnamed_9206;
									float fragment_unnamed_9208;
									float fragment_unnamed_9210;
									if (0.0f < mad(fragment_unnamed_5487, abs(fragment_unnamed_9026), mad(fragment_unnamed_5486, abs(fragment_unnamed_9023), fragment_unnamed_9020)))
									{
										float fragment_unnamed_9191 = dot(float2(fragment_unnamed_1243, fragment_unnamed_1240), float2(fragment_unnamed_7367, fragment_unnamed_7361));
										float fragment_unnamed_9194 = fragment_unnamed_1242 * fragment_unnamed_7364;
										float fragment_unnamed_9195 = dot(float2(fragment_unnamed_1243, fragment_unnamed_1240), float2(fragment_unnamed_7376, fragment_unnamed_7370));
										float fragment_unnamed_9198 = fragment_unnamed_1242 * fragment_unnamed_7373;
										float fragment_unnamed_9552;
										float fragment_unnamed_9553;
										float fragment_unnamed_9554;
										float fragment_unnamed_9555;
										if (fragment_unnamed_5472)
										{
											float fragment_unnamed_9221 = dot(float2(fragment_unnamed_1240, fragment_unnamed_1243), float2(fragment_unnamed_7379, fragment_unnamed_7385));
											float fragment_unnamed_9224 = fragment_unnamed_7382 * fragment_unnamed_1242;
											float fragment_unnamed_9225 = (-0.0f) - fragment_unnamed_5486;
											float fragment_unnamed_9229 = (-0.0f) - fragment_unnamed_5487;
											float fragment_unnamed_9230 = mad(fragment_unnamed_9229, fragment_unnamed_9221, mad(fragment_unnamed_9225, fragment_unnamed_9195, fragment_unnamed_9191));
											float fragment_unnamed_9231 = mad(fragment_unnamed_9229, fragment_unnamed_9224, mad(fragment_unnamed_9225, fragment_unnamed_9198, fragment_unnamed_9194));
											float fragment_unnamed_9232 = mad(fragment_unnamed_9229, fragment_unnamed_9026, mad(fragment_unnamed_9225, fragment_unnamed_9023, fragment_unnamed_9020));
											float fragment_unnamed_9233 = fragment_unnamed_5471 * fragment_unnamed_9221;
											float fragment_unnamed_9234 = fragment_unnamed_5471 * fragment_unnamed_9224;
											float fragment_unnamed_9235 = fragment_unnamed_5471 * fragment_unnamed_9026;
											float fragment_unnamed_9236 = mad(fragment_unnamed_5471, fragment_unnamed_9026, fragment_unnamed_9232);
											float fragment_unnamed_9237 = mad(fragment_unnamed_5471, fragment_unnamed_9221, fragment_unnamed_9230);
											float fragment_unnamed_9238 = mad(fragment_unnamed_5471, fragment_unnamed_9224, fragment_unnamed_9231);
											float fragment_unnamed_9239 = mad(fragment_unnamed_5469, fragment_unnamed_9023, fragment_unnamed_9236);
											float fragment_unnamed_9240 = mad(fragment_unnamed_5469, fragment_unnamed_9195, fragment_unnamed_9237);
											float fragment_unnamed_9241 = mad(fragment_unnamed_5469, fragment_unnamed_9198, fragment_unnamed_9238);
											float fragment_unnamed_9242 = (-0.0f) - fragment_unnamed_5471;
											float fragment_unnamed_9243 = mad(fragment_unnamed_9242, fragment_unnamed_9221, fragment_unnamed_9240);
											float fragment_unnamed_9244 = mad(fragment_unnamed_9242, fragment_unnamed_9224, fragment_unnamed_9241);
											float fragment_unnamed_9245 = mad(fragment_unnamed_9242, fragment_unnamed_9026, fragment_unnamed_9239);
											float fragment_unnamed_9249 = rsqrt(dot(float3(fragment_unnamed_9230, fragment_unnamed_9231, fragment_unnamed_9232), float3(fragment_unnamed_9230, fragment_unnamed_9231, fragment_unnamed_9232)));
											float fragment_unnamed_9250 = fragment_unnamed_9249 * fragment_unnamed_9231;
											float fragment_unnamed_9251 = fragment_unnamed_9249 * fragment_unnamed_9232;
											float fragment_unnamed_9252 = fragment_unnamed_9249 * fragment_unnamed_9230;
											float fragment_unnamed_9256 = rsqrt(dot(float3(fragment_unnamed_9236, fragment_unnamed_9237, fragment_unnamed_9238), float3(fragment_unnamed_9236, fragment_unnamed_9237, fragment_unnamed_9238)));
											float fragment_unnamed_9257 = fragment_unnamed_9256 * fragment_unnamed_9236;
											float fragment_unnamed_9258 = fragment_unnamed_9256 * fragment_unnamed_9237;
											float fragment_unnamed_9259 = fragment_unnamed_9256 * fragment_unnamed_9238;
											float fragment_unnamed_9263 = rsqrt(dot(float3(fragment_unnamed_9239, fragment_unnamed_9240, fragment_unnamed_9241), float3(fragment_unnamed_9239, fragment_unnamed_9240, fragment_unnamed_9241)));
											float fragment_unnamed_9264 = fragment_unnamed_9263 * fragment_unnamed_9239;
											float fragment_unnamed_9265 = fragment_unnamed_9263 * fragment_unnamed_9240;
											float fragment_unnamed_9266 = fragment_unnamed_9263 * fragment_unnamed_9241;
											float fragment_unnamed_9270 = rsqrt(dot(float3(fragment_unnamed_9243, fragment_unnamed_9244, fragment_unnamed_9245), float3(fragment_unnamed_9243, fragment_unnamed_9244, fragment_unnamed_9245)));
											float fragment_unnamed_9271 = fragment_unnamed_9270 * fragment_unnamed_9245;
											float fragment_unnamed_9272 = fragment_unnamed_9270 * fragment_unnamed_9243;
											float fragment_unnamed_9273 = fragment_unnamed_9270 * fragment_unnamed_9244;
											float fragment_unnamed_9274 = dot(float3(fragment_unnamed_9251, fragment_unnamed_9252, fragment_unnamed_9250), float3(fragment_unnamed_9257, fragment_unnamed_9258, fragment_unnamed_9259));
											float fragment_unnamed_9304 = mad(abs(fragment_unnamed_9274), mad(abs(fragment_unnamed_9274), mad(abs(fragment_unnamed_9274), mad(abs(fragment_unnamed_9274), mad(abs(fragment_unnamed_9274), mad(abs(fragment_unnamed_9274), mad(abs(fragment_unnamed_9274), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9311 = asfloat((fragment_unnamed_9274 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9274, fragment_unnamed_9274, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9304)) : asuint(fragment_unnamed_9304));
											float fragment_unnamed_9312 = dot(float3(fragment_unnamed_9257, fragment_unnamed_9258, fragment_unnamed_9259), float3(fragment_unnamed_9264, fragment_unnamed_9265, fragment_unnamed_9266));
											float fragment_unnamed_9342 = mad(abs(fragment_unnamed_9312), mad(abs(fragment_unnamed_9312), mad(abs(fragment_unnamed_9312), mad(abs(fragment_unnamed_9312), mad(abs(fragment_unnamed_9312), mad(abs(fragment_unnamed_9312), mad(abs(fragment_unnamed_9312), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9349 = asfloat((fragment_unnamed_9312 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9312, fragment_unnamed_9312, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9342)) : asuint(fragment_unnamed_9342));
											float fragment_unnamed_9356 = dot(float3(fragment_unnamed_9264, fragment_unnamed_9265, fragment_unnamed_9266), float3(fragment_unnamed_9271, fragment_unnamed_9272, fragment_unnamed_9273));
											float fragment_unnamed_9386 = mad(abs(fragment_unnamed_9356), mad(abs(fragment_unnamed_9356), mad(abs(fragment_unnamed_9356), mad(abs(fragment_unnamed_9356), mad(abs(fragment_unnamed_9356), mad(abs(fragment_unnamed_9356), mad(abs(fragment_unnamed_9356), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9393 = asfloat((fragment_unnamed_9356 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9356, fragment_unnamed_9356, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9386)) : asuint(fragment_unnamed_9386));
											float fragment_unnamed_9397 = dot(float3(fragment_unnamed_9273, fragment_unnamed_9271, fragment_unnamed_9272), float3(fragment_unnamed_9250, fragment_unnamed_9251, fragment_unnamed_9252));
											float fragment_unnamed_9427 = mad(abs(fragment_unnamed_9397), mad(abs(fragment_unnamed_9397), mad(abs(fragment_unnamed_9397), mad(abs(fragment_unnamed_9397), mad(abs(fragment_unnamed_9397), mad(abs(fragment_unnamed_9397), mad(abs(fragment_unnamed_9397), -0.0270812995731830596923828125f, 0.137528002262115478515625f), -0.326137006282806396484375f), 0.51058900356292724609375f), -0.649178028106689453125f), 0.78339302539825439453125f), -0.99990999698638916015625f), 1.57079637050628662109375f);
											float fragment_unnamed_9434 = asfloat((fragment_unnamed_9397 < 0.0f) ? asuint(mad(rsqrt(max(max(mad((-0.0f) - fragment_unnamed_9397, fragment_unnamed_9397, 1.0f), 0.0f), 5.9604644775390625e-08f)), 3.1415927410125732421875f, (-0.0f) - fragment_unnamed_9427)) : asuint(fragment_unnamed_9427));
											float fragment_unnamed_9437 = mad(mad(fragment_unnamed_9272, fragment_unnamed_9250, (-0.0f) - (fragment_unnamed_9252 * fragment_unnamed_9273)), fragment_unnamed_9434, mad(mad(fragment_unnamed_9265, fragment_unnamed_9273, (-0.0f) - (fragment_unnamed_9266 * fragment_unnamed_9272)), fragment_unnamed_9393, mad(mad(fragment_unnamed_9252, fragment_unnamed_9259, (-0.0f) - (fragment_unnamed_9258 * fragment_unnamed_9250)), fragment_unnamed_9311, fragment_unnamed_9349 * mad(fragment_unnamed_9258, fragment_unnamed_9266, (-0.0f) - (fragment_unnamed_9259 * fragment_unnamed_9265)))));
											float fragment_unnamed_9438 = mad(mad(fragment_unnamed_9273, fragment_unnamed_9251, (-0.0f) - (fragment_unnamed_9250 * fragment_unnamed_9271)), fragment_unnamed_9434, mad(mad(fragment_unnamed_9266, fragment_unnamed_9271, (-0.0f) - (fragment_unnamed_9264 * fragment_unnamed_9273)), fragment_unnamed_9393, mad(mad(fragment_unnamed_9250, fragment_unnamed_9257, (-0.0f) - (fragment_unnamed_9259 * fragment_unnamed_9251)), fragment_unnamed_9311, fragment_unnamed_9349 * mad(fragment_unnamed_9259, fragment_unnamed_9264, (-0.0f) - (fragment_unnamed_9257 * fragment_unnamed_9266))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9439 = mad(mad(fragment_unnamed_9271, fragment_unnamed_9252, (-0.0f) - (fragment_unnamed_9251 * fragment_unnamed_9272)), fragment_unnamed_9434, mad(mad(fragment_unnamed_9264, fragment_unnamed_9272, (-0.0f) - (fragment_unnamed_9265 * fragment_unnamed_9271)), fragment_unnamed_9393, mad(mad(fragment_unnamed_9251, fragment_unnamed_9258, (-0.0f) - (fragment_unnamed_9257 * fragment_unnamed_9252)), fragment_unnamed_9311, fragment_unnamed_9349 * mad(fragment_unnamed_9257, fragment_unnamed_9265, (-0.0f) - (fragment_unnamed_9258 * fragment_unnamed_9264))))) * 0.15915493667125701904296875f;
											float fragment_unnamed_9440 = fragment_unnamed_9437 * 0.15915493667125701904296875f;
											float fragment_unnamed_9441 = dot(float3(fragment_unnamed_9438, fragment_unnamed_9439, fragment_unnamed_9440), float3(fragment_unnamed_9438, fragment_unnamed_9439, fragment_unnamed_9440));
											float fragment_unnamed_9692;
											float fragment_unnamed_9693;
											float fragment_unnamed_9694;
											if (fragment_unnamed_5394 != 0u)
											{
												float fragment_unnamed_9559 = ((-0.0f) - fragment_unnamed_9230) + fragment_unnamed_9243;
												float fragment_unnamed_9560 = ((-0.0f) - fragment_unnamed_9231) + fragment_unnamed_9244;
												float fragment_unnamed_9561 = ((-0.0f) - fragment_unnamed_9232) + fragment_unnamed_9245;
												float fragment_unnamed_9568 = mad(fragment_unnamed_9560, fragment_unnamed_9235, (-0.0f) - (fragment_unnamed_9234 * fragment_unnamed_9561));
												float fragment_unnamed_9569 = mad(fragment_unnamed_9561, fragment_unnamed_9233, (-0.0f) - (fragment_unnamed_9235 * fragment_unnamed_9559));
												float fragment_unnamed_9570 = mad(fragment_unnamed_9559, fragment_unnamed_9234, (-0.0f) - (fragment_unnamed_9233 * fragment_unnamed_9560));
												float fragment_unnamed_9574 = rsqrt(dot(float3(fragment_unnamed_9568, fragment_unnamed_9569, fragment_unnamed_9570), float3(fragment_unnamed_9568, fragment_unnamed_9569, fragment_unnamed_9570)));
												float fragment_unnamed_9575 = fragment_unnamed_9574 * fragment_unnamed_9568;
												float fragment_unnamed_9576 = fragment_unnamed_9574 * fragment_unnamed_9569;
												float fragment_unnamed_9577 = fragment_unnamed_9574 * fragment_unnamed_9570;
												float fragment_unnamed_9584 = dot(float3(fragment_unnamed_9230, fragment_unnamed_9231, fragment_unnamed_9232), float3(fragment_unnamed_9575, fragment_unnamed_9576, fragment_unnamed_9577)) / dot(float3(fragment_unnamed_9438, fragment_unnamed_9439, fragment_unnamed_9440), float3(fragment_unnamed_9575, fragment_unnamed_9576, fragment_unnamed_9577));
												float fragment_unnamed_9588 = mad(fragment_unnamed_9584, fragment_unnamed_9575, (-0.0f) - fragment_unnamed_9230);
												float fragment_unnamed_9589 = mad(fragment_unnamed_9584, fragment_unnamed_9576, (-0.0f) - fragment_unnamed_9231);
												float fragment_unnamed_9590 = mad(fragment_unnamed_9584, fragment_unnamed_9577, (-0.0f) - fragment_unnamed_9232);
												float fragment_unnamed_9594 = 1.0f / dot(float3(fragment_unnamed_9559, fragment_unnamed_9560, fragment_unnamed_9561), float3(fragment_unnamed_9559, fragment_unnamed_9560, fragment_unnamed_9561));
												float fragment_unnamed_9595 = dot(float3(fragment_unnamed_9233, fragment_unnamed_9234, fragment_unnamed_9235), float3(fragment_unnamed_9559, fragment_unnamed_9560, fragment_unnamed_9561));
												float fragment_unnamed_9604 = mad((-0.0f) - (fragment_unnamed_9559 * fragment_unnamed_9595), fragment_unnamed_9594, fragment_unnamed_9233);
												float fragment_unnamed_9605 = mad((-0.0f) - (fragment_unnamed_9560 * fragment_unnamed_9595), fragment_unnamed_9594, fragment_unnamed_9234);
												float fragment_unnamed_9606 = mad((-0.0f) - (fragment_unnamed_9561 * fragment_unnamed_9595), fragment_unnamed_9594, fragment_unnamed_9235);
												float fragment_unnamed_9613 = dot(float3(fragment_unnamed_9588, fragment_unnamed_9589, fragment_unnamed_9590), float3(fragment_unnamed_9604, fragment_unnamed_9605, fragment_unnamed_9606)) / dot(float3(fragment_unnamed_9604, fragment_unnamed_9605, fragment_unnamed_9606), float3(fragment_unnamed_9604, fragment_unnamed_9605, fragment_unnamed_9606));
												float fragment_unnamed_9626 = round(log2(fragment_unnamed_5437 * fragment_uniform_buffer_0[122u].x));
												float fragment_unnamed_9636 = min(mad(fragment_unnamed_3207, ((-0.0f) - fragment_unnamed_9626) + 3.0f, fragment_unnamed_9626), max(mad(log2(mad(fragment_unnamed_9574 * (fragment_unnamed_9584 * fragment_unnamed_9584), 3.1415927410125732421875f, 9.9999999392252902907785028219223e-09f)), 0.5f, fragment_unnamed_9626), 0.0f));
												float fragment_unnamed_9650 = 1.0f / (fragment_unnamed_5437 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_9651 = 1.0f / (fragment_unnamed_5439 + fragment_uniform_buffer_0[123u].y);
												float fragment_unnamed_9661 = exp2(ceil(max(fragment_unnamed_9636 + ((-0.0f) - fragment_uniform_buffer_0[123u].z), 0.0f)));
												float fragment_unnamed_9665 = fragment_unnamed_5437 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_9666 = fragment_unnamed_5439 * fragment_uniform_buffer_0[123u].x;
												float fragment_unnamed_9669 = fragment_unnamed_9661 / (fragment_unnamed_9665 + fragment_unnamed_9665);
												float fragment_unnamed_9670 = fragment_unnamed_9661 / (fragment_unnamed_9666 + fragment_unnamed_9666);
												float4 fragment_unnamed_9684 = _CookieAtlas.SampleLevel(S1, float2(mad(min(((-0.0f) - fragment_unnamed_9669) + 1.0f, max(fragment_unnamed_9669, mad(clamp(mad((-0.0f) - mad((-0.0f) - fragment_unnamed_9595, fragment_unnamed_9613, dot(float3(fragment_unnamed_9588, fragment_unnamed_9589, fragment_unnamed_9590), float3(fragment_unnamed_9559, fragment_unnamed_9560, fragment_unnamed_9561))), fragment_unnamed_9594, 1.0f), 0.0f, 1.0f), fragment_unnamed_5437 * fragment_unnamed_9650, mad((-0.0f) - fragment_unnamed_9650, fragment_unnamed_5437, 1.0f) * 0.5f))), fragment_unnamed_5437, fragment_unnamed_5455), mad(min(((-0.0f) - fragment_unnamed_9670) + 1.0f, max(fragment_unnamed_9670, mad(clamp(fragment_unnamed_9613, 0.0f, 1.0f), fragment_unnamed_5439 * fragment_unnamed_9651, mad((-0.0f) - fragment_unnamed_9651, fragment_unnamed_5439, 1.0f) * 0.5f))), fragment_unnamed_5439, fragment_unnamed_5457)), fragment_unnamed_9636);
												fragment_unnamed_9692 = fragment_unnamed_9684.x;
												fragment_unnamed_9693 = fragment_unnamed_9684.y;
												fragment_unnamed_9694 = fragment_unnamed_9684.z;
											}
											else
											{
												fragment_unnamed_9692 = asfloat(1065353216u);
												fragment_unnamed_9693 = asfloat(1065353216u);
												fragment_unnamed_9694 = asfloat(1065353216u);
											}
											fragment_unnamed_9552 = fragment_unnamed_9692;
											fragment_unnamed_9553 = fragment_unnamed_9693;
											fragment_unnamed_9554 = fragment_unnamed_9694;
											fragment_unnamed_9555 = max(mad(fragment_unnamed_9437, 0.15915493667125701904296875f, fragment_unnamed_9441) / (sqrt(fragment_unnamed_9441) + 1.0f), 0.0f);
										}
										else
										{
											float fragment_unnamed_9453 = mad((-0.0f) - fragment_unnamed_1241, fragment_unnamed_7396, fragment_unnamed_7394) * fragment_unnamed_1242;
											float fragment_unnamed_9454 = fragment_unnamed_3209 * fragment_unnamed_7395;
											float fragment_unnamed_9457 = mad((-0.0f) - fragment_unnamed_1243, fragment_unnamed_7394, fragment_unnamed_1240 * fragment_unnamed_7396) * fragment_unnamed_1242;
											float fragment_unnamed_9468 = (1.0f / fragment_unnamed_9023) * ((-0.0f) - fragment_unnamed_9020);
											bool fragment_unnamed_9469 = fragment_unnamed_9023 >= 0.0f;
											float fragment_unnamed_9484 = dot(float3(fragment_unnamed_9195, fragment_unnamed_9198, fragment_unnamed_9023), float3(fragment_unnamed_9195, fragment_unnamed_9198, fragment_unnamed_9023));
											float fragment_unnamed_9487 = rsqrt(fragment_unnamed_9484);
											float fragment_unnamed_9488 = fragment_unnamed_9484 * fragment_unnamed_9487;
											float fragment_unnamed_9489 = fragment_unnamed_9487 * fragment_unnamed_9195;
											float fragment_unnamed_9490 = fragment_unnamed_9487 * fragment_unnamed_9198;
											float fragment_unnamed_9491 = fragment_unnamed_9487 * fragment_unnamed_9023;
											float fragment_unnamed_9492 = dot(float3(fragment_unnamed_9489, fragment_unnamed_9490, fragment_unnamed_9491), float3(fragment_unnamed_9191, fragment_unnamed_9194, fragment_unnamed_9020));
											float fragment_unnamed_9495 = (-0.0f) - fragment_unnamed_9492;
											float fragment_unnamed_9496 = mad(fragment_unnamed_9495, fragment_unnamed_9489, fragment_unnamed_9191);
											float fragment_unnamed_9497 = mad(fragment_unnamed_9495, fragment_unnamed_9490, fragment_unnamed_9194);
											float fragment_unnamed_9498 = mad(fragment_unnamed_9495, fragment_unnamed_9491, fragment_unnamed_9020);
											float fragment_unnamed_9499 = dot(float3(fragment_unnamed_9496, fragment_unnamed_9497, fragment_unnamed_9498), float3(fragment_unnamed_9496, fragment_unnamed_9497, fragment_unnamed_9498));
											float fragment_unnamed_9502 = rsqrt(fragment_unnamed_9499);
											float fragment_unnamed_9504 = fragment_unnamed_9502 * fragment_unnamed_9498;
											float fragment_unnamed_9505 = mad(asfloat(fragment_unnamed_9469 ? asuint(max(fragment_unnamed_9468, fragment_unnamed_5486)) : asuint(min(fragment_unnamed_9468, fragment_unnamed_5486))), fragment_unnamed_9488, fragment_unnamed_9492);
											float fragment_unnamed_9506 = mad(asfloat(fragment_unnamed_9469 ? asuint(max(fragment_unnamed_9468, (-0.0f) - fragment_unnamed_5486)) : asuint(min(fragment_unnamed_9468, (-0.0f) - fragment_unnamed_5486))), fragment_unnamed_9488, fragment_unnamed_9492);
											float fragment_unnamed_9507 = mad(fragment_unnamed_9505, fragment_unnamed_9505, fragment_unnamed_9499);
											float fragment_unnamed_9508 = mad(fragment_unnamed_9506, fragment_unnamed_9506, fragment_unnamed_9499);
											float fragment_unnamed_9510 = rsqrt(fragment_unnamed_9507 * fragment_unnamed_9508);
											float fragment_unnamed_9511 = fragment_unnamed_9510 * fragment_unnamed_9510;
											float fragment_unnamed_9514 = (fragment_unnamed_9499 * fragment_unnamed_9502) * fragment_unnamed_9491;
											float fragment_unnamed_9524 = min(fragment_unnamed_9510 * mad(fragment_unnamed_9506, fragment_unnamed_9505, fragment_unnamed_9499), 1.0f);
											float fragment_unnamed_9528 = sqrt(((-0.0f) - abs(fragment_unnamed_9524)) + 1.0f);
											float fragment_unnamed_9534 = mad(mad(mad(abs(fragment_unnamed_9524), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_9524), -0.212114393711090087890625f), abs(fragment_unnamed_9524), 1.570728778839111328125f);
											fragment_unnamed_9552 = asfloat(1065353216u);
											fragment_unnamed_9553 = asfloat(1065353216u);
											fragment_unnamed_9554 = asfloat(1065353216u);
											fragment_unnamed_9555 = ((fragment_unnamed_7397 * (abs(fragment_unnamed_3210) * rsqrt(fragment_unnamed_7397 * dot(float3(fragment_unnamed_9453, fragment_unnamed_9454, fragment_unnamed_9457), float3(fragment_unnamed_9453, fragment_unnamed_9454, fragment_unnamed_9457))))) * max(mad(mad(fragment_unnamed_9534, fragment_unnamed_9528, asfloat(((fragment_unnamed_9524 < ((-0.0f) - fragment_unnamed_9524)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_9528 * fragment_unnamed_9534, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_9502 * fragment_unnamed_9504, mad(mad(fragment_unnamed_9504, fragment_unnamed_9505, (-0.0f) - fragment_unnamed_9514), fragment_unnamed_9508 * fragment_unnamed_9511, (-0.0f) - ((fragment_unnamed_9507 * fragment_unnamed_9511) * mad(fragment_unnamed_9504, fragment_unnamed_9506, (-0.0f) - fragment_unnamed_9514)))), 0.0f)) * 0.3183098733425140380859375f;
										}
										fragment_unnamed_9204 = fragment_unnamed_9552;
										fragment_unnamed_9206 = fragment_unnamed_9553;
										fragment_unnamed_9208 = fragment_unnamed_9554;
										fragment_unnamed_9210 = fragment_unnamed_9555;
									}
									else
									{
										fragment_unnamed_9204 = asfloat(1065353216u);
										fragment_unnamed_9206 = asfloat(1065353216u);
										fragment_unnamed_9208 = asfloat(1065353216u);
										fragment_unnamed_9210 = asfloat(0u);
									}
									fragment_unnamed_9203 = fragment_unnamed_9204;
									fragment_unnamed_9205 = fragment_unnamed_9206;
									fragment_unnamed_9207 = fragment_unnamed_9208;
									fragment_unnamed_9209 = fragment_unnamed_9210;
								}
								else
								{
									fragment_unnamed_9203 = asfloat(1065353216u);
									fragment_unnamed_9205 = asfloat(1065353216u);
									fragment_unnamed_9207 = asfloat(1065353216u);
									fragment_unnamed_9209 = asfloat(0u);
								}
								float fragment_unnamed_9211 = (asfloat(fragment_unnamed_7356.y) * fragment_unnamed_5529) * fragment_unnamed_9209;
								fragment_unnamed_7715 = fragment_unnamed_6852 * (fragment_unnamed_9211 * (fragment_unnamed_1202 * fragment_unnamed_9203));
								fragment_unnamed_7717 = fragment_unnamed_6854 * (fragment_unnamed_9211 * (fragment_unnamed_1203 * fragment_unnamed_9205));
								fragment_unnamed_7719 = fragment_unnamed_6856 * (fragment_unnamed_9211 * (fragment_unnamed_1204 * fragment_unnamed_9207));
								fragment_unnamed_7721 = (fragment_unnamed_1126 * fragment_unnamed_6852) * (fragment_unnamed_7972 * fragment_unnamed_7964);
								fragment_unnamed_7723 = (fragment_unnamed_1126 * fragment_unnamed_6854) * (fragment_unnamed_7972 * fragment_unnamed_7966);
								fragment_unnamed_7725 = (fragment_unnamed_1126 * fragment_unnamed_6856) * (fragment_unnamed_7972 * fragment_unnamed_7968);
							}
							else
							{
								fragment_unnamed_7715 = asfloat(0u);
								fragment_unnamed_7717 = asfloat(0u);
								fragment_unnamed_7719 = asfloat(0u);
								fragment_unnamed_7721 = asfloat(0u);
								fragment_unnamed_7723 = asfloat(0u);
								fragment_unnamed_7725 = asfloat(0u);
							}
							fragment_unnamed_3815 = fragment_unnamed_3814 + fragment_unnamed_7715;
							fragment_unnamed_3817 = fragment_unnamed_3816 + fragment_unnamed_7717;
							fragment_unnamed_3819 = fragment_unnamed_3818 + fragment_unnamed_7719;
							fragment_unnamed_3823 = fragment_unnamed_3822 + fragment_unnamed_7725;
							fragment_unnamed_3825 = fragment_unnamed_3824 + fragment_unnamed_7723;
							fragment_unnamed_3827 = fragment_unnamed_3826 + fragment_unnamed_7721;
							fragment_unnamed_3814 = fragment_unnamed_3815;
							fragment_unnamed_3816 = fragment_unnamed_3817;
							fragment_unnamed_3818 = fragment_unnamed_3819;
							fragment_unnamed_3820 = fragment_unnamed_3821;
							fragment_unnamed_3822 = fragment_unnamed_3823;
							fragment_unnamed_3824 = fragment_unnamed_3825;
							fragment_unnamed_3826 = fragment_unnamed_3827;
							continue;
						}
					}
					if (ladder_phi_84)
					{
						break;
					}
					break;
				}
				float fragment_unnamed_4189 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_4193 = mad(mad(fragment_unnamed_1099, fragment_unnamed_3826, max(mad(fragment_unnamed_1099, 2.755199909210205078125f, mad(fragment_unnamed_1099, -4.79510021209716796875f, mad(fragment_unnamed_1099, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f) * (((fragment_unnamed_1126 * mad(fragment_unnamed_1138, mad((-0.0f) - fragment_unnamed_773, fragment_unnamed_1098, fragment_unnamed_1106), fragment_unnamed_1099)) * fragment_unnamed_1092) * fragment_unnamed_1170)), fragment_unnamed_4189, fragment_unnamed_4189 * (mad(fragment_unnamed_1172 * fragment_unnamed_2619, max(mad(fragment_unnamed_1106, 2.755199909210205078125f, mad(fragment_unnamed_1106, -4.79510021209716796875f, mad(fragment_unnamed_1106, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_3814) * mad(fragment_unnamed_1106, fragment_unnamed_1206, 1.0f)));
				float fragment_unnamed_4194 = mad(mad(fragment_unnamed_1100, fragment_unnamed_3824, max(mad(fragment_unnamed_1100, 2.755199909210205078125f, mad(fragment_unnamed_1100, -4.79510021209716796875f, mad(fragment_unnamed_1100, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f) * (((fragment_unnamed_1126 * mad(fragment_unnamed_1138, mad((-0.0f) - fragment_unnamed_774, fragment_unnamed_1098, fragment_unnamed_1108), fragment_unnamed_1100)) * fragment_unnamed_1093) * fragment_unnamed_1170)), fragment_unnamed_4189, fragment_unnamed_4189 * (mad(fragment_unnamed_1172 * fragment_unnamed_2621, max(mad(fragment_unnamed_1108, 2.755199909210205078125f, mad(fragment_unnamed_1108, -4.79510021209716796875f, mad(fragment_unnamed_1108, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_3816) * mad(fragment_unnamed_1108, fragment_unnamed_1206, 1.0f)));
				float fragment_unnamed_4195 = mad(mad(fragment_unnamed_1101, fragment_unnamed_3822, max(mad(fragment_unnamed_1101, 2.755199909210205078125f, mad(fragment_unnamed_1101, -4.79510021209716796875f, mad(fragment_unnamed_1101, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f) * (((fragment_unnamed_1126 * mad(fragment_unnamed_1138, mad((-0.0f) - fragment_unnamed_775, fragment_unnamed_1098, fragment_unnamed_1109), fragment_unnamed_1101)) * fragment_unnamed_1094) * fragment_unnamed_1170)), fragment_unnamed_4189, fragment_unnamed_4189 * (mad(fragment_unnamed_1172 * fragment_unnamed_2623, max(mad(fragment_unnamed_1109, 2.755199909210205078125f, mad(fragment_unnamed_1109, -4.79510021209716796875f, mad(fragment_unnamed_1109, 2.040400028228759765625f, -0.3323999941349029541015625f))) + 1.3320000171661376953125f, 1.0f), fragment_unnamed_3818) * mad(fragment_unnamed_1109, fragment_unnamed_1206, 1.0f)));
				float fragment_unnamed_5330;
				float fragment_unnamed_5332;
				float fragment_unnamed_5334;
				float fragment_unnamed_5336;
				float fragment_unnamed_5338;
				if (asuint(fragment_uniform_buffer_0[211u]).y != 1u)
				{
					float fragment_unnamed_4791 = float(fragment_unnamed_284);
					float fragment_unnamed_4792 = float(fragment_unnamed_285);
					uint fragment_unnamed_4812 = min(T23.Load(1u).x, max(((-T23.Load(0u).x) + 4294967295u), uint(round(dot(float2(fragment_unnamed_4791, fragment_unnamed_4792), float2(fragment_uniform_buffer_0[103u].y * 1.0f, fragment_uniform_buffer_0[103u].x * (-1.0f))) + ((-0.0f) - fragment_uniform_buffer_0[102u].x)))));
					bool fragment_unnamed_4844 = ((((-0.0f) - float((T23.Load(fragment_unnamed_4812 + 2u).x & 65535u) + 4294967295u)) + floor(dot(float2(fragment_unnamed_4791, fragment_unnamed_4792), float2(fragment_uniform_buffer_0[103u].xy)) + ((-0.0f) - fragment_uniform_buffer_0[102u].z))) / (((-0.0f) - fragment_uniform_buffer_0[102u].z) + fragment_uniform_buffer_0[102u].w)) < 0.0f;
					uint fragment_unnamed_4845 = fragment_unnamed_4844 ? 4294967295u : 0u;
					float fragment_unnamed_4846 = asfloat(fragment_unnamed_4845);
					float fragment_unnamed_5331;
					float fragment_unnamed_5333;
					float fragment_unnamed_5335;
					float fragment_unnamed_5337;
					float fragment_unnamed_5339;
					if (asuint(fragment_uniform_buffer_0[113u]).x != 0u)
					{
						float4 fragment_unnamed_5281 = _RefractiveDepthBuffer.Load(int4(uint3(fragment_unnamed_284, fragment_unnamed_285, 0u), 0u));
						float fragment_unnamed_5283 = fragment_unnamed_5281.x;
						uint4 fragment_unnamed_5284 = _StencilTexture.Load(int4(uint3(fragment_unnamed_284, fragment_unnamed_285, 0u), 0u));
						uint fragment_unnamed_5286 = fragment_unnamed_5284.y;
						uint fragment_unnamed_5288 = fragment_unnamed_5286 & 32u;
						uint fragment_unnamed_5324 = ((fragment_unnamed_5286 & 1u) != 0u) ? 4294967295u : (((((((fragment_unnamed_5283 >= gl_FragCoord.z) ? 4294967295u : 0u) & (fragment_unnamed_4845 & ((fragment_unnamed_5288 != 0u) ? 4294967295u : 0u))) != 0u) ? 3.4028234663852885981170418348452e+38f : gl_FragCoord.z) < asfloat(fragment_unnamed_4844 ? 2139095039u : ((fragment_unnamed_5288 != 0u) ? asuint(fragment_unnamed_5283) : 0u))) ? (fragment_unnamed_4844 ? asuint(fragment_uniform_buffer_0[107u]).x : (uint(_WaterGBufferTexture3.Load(int4(uint3(fragment_unnamed_284, fragment_unnamed_285, 0u), 0u)).w * 255.0f) & 15u)) : 4294967295u);
						float fragment_unnamed_6373;
						float fragment_unnamed_6374;
						float fragment_unnamed_6375;
						float fragment_unnamed_6376;
						float fragment_unnamed_6377;
						if (fragment_unnamed_5324 == 4294967295u)
						{
							fragment_unnamed_6373 = asfloat(0u);
							fragment_unnamed_6374 = asfloat(0u);
							fragment_unnamed_6375 = asfloat(0u);
							fragment_unnamed_6376 = asfloat(0u);
							fragment_unnamed_6377 = asfloat(0u);
						}
						else
						{
							float fragment_unnamed_6529;
							float fragment_unnamed_6530;
							float fragment_unnamed_6531;
							if (fragment_unnamed_4845 == 0u)
							{
								uint fragment_unnamed_6533 = (fragment_unnamed_5324 * 28u) + 4u;
								uint3 fragment_unnamed_6542 = uint3(T25.Load(fragment_unnamed_6533).x, T25.Load(fragment_unnamed_6533 + 1u).x, T25.Load(fragment_unnamed_6533 + 2u).x);
								float fragment_unnamed_6555 = mad(fragment_unnamed_4791 * fragment_uniform_buffer_0[50u].z, 2.0f, -1.0f);
								float fragment_unnamed_6557 = (-0.0f) - mad(fragment_unnamed_4792 * fragment_uniform_buffer_0[50u].w, 2.0f, -1.0f);
								float fragment_unnamed_6597 = mad(fragment_uniform_buffer_0[30u].w, fragment_unnamed_5283, mad(fragment_uniform_buffer_0[28u].w, fragment_unnamed_6555, fragment_unnamed_6557 * fragment_uniform_buffer_0[29u].w)) + fragment_uniform_buffer_0[31u].w;
								float fragment_unnamed_6610 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].x, fragment_unnamed_5283, mad(fragment_uniform_buffer_0[28u].x, fragment_unnamed_6555, fragment_unnamed_6557 * fragment_uniform_buffer_0[29u].x)) + fragment_uniform_buffer_0[31u].x) / fragment_unnamed_6597)) + fragment_input_5.x;
								float fragment_unnamed_6611 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].y, fragment_unnamed_5283, mad(fragment_uniform_buffer_0[28u].y, fragment_unnamed_6555, fragment_unnamed_6557 * fragment_uniform_buffer_0[29u].y)) + fragment_uniform_buffer_0[31u].y) / fragment_unnamed_6597)) + fragment_input_5.y;
								float fragment_unnamed_6612 = ((-0.0f) - ((mad(fragment_uniform_buffer_0[30u].z, fragment_unnamed_5283, mad(fragment_uniform_buffer_0[28u].z, fragment_unnamed_6555, fragment_unnamed_6557 * fragment_uniform_buffer_0[29u].z)) + fragment_uniform_buffer_0[31u].z) / fragment_unnamed_6597)) + fragment_input_5.z;
								float fragment_unnamed_6616 = sqrt(dot(float3(fragment_unnamed_6610, fragment_unnamed_6611, fragment_unnamed_6612), float3(fragment_unnamed_6610, fragment_unnamed_6611, fragment_unnamed_6612)));
								float fragment_unnamed_6617 = fragment_unnamed_6616 + fragment_unnamed_6616;
								fragment_unnamed_6529 = ((-0.0f) - exp2((asfloat(fragment_unnamed_6542.z) * fragment_unnamed_6617) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_6530 = ((-0.0f) - exp2((asfloat(fragment_unnamed_6542.y) * fragment_unnamed_6617) * (-1.44269502162933349609375f))) + 1.0f;
								fragment_unnamed_6531 = ((-0.0f) - exp2((asfloat(fragment_unnamed_6542.x) * fragment_unnamed_6617) * (-1.44269502162933349609375f))) + 1.0f;
							}
							else
							{
								fragment_unnamed_6529 = asfloat(0u);
								fragment_unnamed_6530 = asfloat(0u);
								fragment_unnamed_6531 = asfloat(0u);
							}
							fragment_unnamed_6373 = fragment_unnamed_6529;
							fragment_unnamed_6374 = asfloat(~fragment_unnamed_4845);
							fragment_unnamed_6375 = fragment_unnamed_6530;
							fragment_unnamed_6376 = fragment_unnamed_6531;
							fragment_unnamed_6377 = fragment_unnamed_4846;
						}
						fragment_unnamed_5331 = fragment_unnamed_6373;
						fragment_unnamed_5333 = fragment_unnamed_6374;
						fragment_unnamed_5335 = fragment_unnamed_6375;
						fragment_unnamed_5337 = fragment_unnamed_6376;
						fragment_unnamed_5339 = fragment_unnamed_6377;
					}
					else
					{
						fragment_unnamed_5331 = asfloat(0u);
						fragment_unnamed_5333 = asfloat(0u);
						fragment_unnamed_5335 = asfloat(0u);
						fragment_unnamed_5337 = asfloat(0u);
						fragment_unnamed_5339 = fragment_unnamed_4846;
					}
					fragment_unnamed_5330 = fragment_unnamed_5331;
					fragment_unnamed_5332 = fragment_unnamed_5333;
					fragment_unnamed_5334 = fragment_unnamed_5335;
					fragment_unnamed_5336 = fragment_unnamed_5337;
					fragment_unnamed_5338 = fragment_unnamed_5339;
				}
				else
				{
					fragment_unnamed_5330 = asfloat(0u);
					fragment_unnamed_5332 = asfloat(0u);
					fragment_unnamed_5334 = asfloat(0u);
					fragment_unnamed_5336 = asfloat(0u);
					fragment_unnamed_5338 = asfloat(0u);
				}
				float fragment_unnamed_6645;
				float fragment_unnamed_6647;
				float fragment_unnamed_6649;
				float fragment_unnamed_6651;
				float fragment_unnamed_6653;
				float fragment_unnamed_6655;
				if (asuint(fragment_unnamed_5332) == 0u)
				{
					float fragment_unnamed_6384 = 1.0f / dot(float3(fragment_unnamed_1212, fragment_unnamed_1213, fragment_unnamed_1214), float3((-0.0f) - asfloat(fragment_unnamed_322), (-0.0f) - asfloat(fragment_unnamed_327), (-0.0f) - asfloat(fragment_unnamed_332)));
					float fragment_unnamed_6388 = fragment_unnamed_6384 * (1.0f / gl_FragCoord.w);
					float fragment_unnamed_7033;
					float fragment_unnamed_7035;
					float fragment_unnamed_7037;
					float fragment_unnamed_7039;
					float fragment_unnamed_7041;
					float fragment_unnamed_7042;
					float fragment_unnamed_7043;
					if (asuint(fragment_uniform_buffer_0[84u]).x != 0u)
					{
						float fragment_unnamed_7044;
						float fragment_unnamed_7605;
						float fragment_unnamed_7607;
						float fragment_unnamed_7609;
						float fragment_unnamed_7611;
						if (asuint(fragment_uniform_buffer_0[84u]).z != 0u)
						{
							float fragment_unnamed_7021 = mad((-0.0f) - fragment_uniform_buffer_0[96u].y, 0.866025388240814208984375f, mad(fragment_uniform_buffer_0[94u].y, log2(max(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6384, (-0.0f) - fragment_uniform_buffer_0[94u].z), 0.0f)), fragment_uniform_buffer_0[94u].x));
							float fragment_unnamed_7757;
							float fragment_unnamed_7758;
							float fragment_unnamed_7759;
							float fragment_unnamed_7760;
							if (asuint(fragment_uniform_buffer_0[89u]).w == 0u)
							{
								float fragment_unnamed_7433 = fragment_unnamed_294 * fragment_uniform_buffer_0[91u].x;
								float fragment_unnamed_7434 = fragment_unnamed_295 * fragment_uniform_buffer_0[91u].y;
								float fragment_unnamed_7435 = floor(fragment_unnamed_7433);
								float fragment_unnamed_7436 = floor(fragment_unnamed_7434);
								float fragment_unnamed_7441 = ((-0.0f) - frac(fragment_unnamed_7433)) + 1.0f;
								float fragment_unnamed_7442 = ((-0.0f) - frac(fragment_unnamed_7434)) + 1.0f;
								float fragment_unnamed_7443 = fragment_unnamed_7442 * fragment_unnamed_7442;
								float fragment_unnamed_7444 = fragment_unnamed_7441 * fragment_unnamed_7441;
								float fragment_unnamed_7449 = mad(((-0.0f) - fragment_unnamed_7441) + 1.0f, fragment_unnamed_7441, 0.5f);
								float fragment_unnamed_7450 = mad(((-0.0f) - fragment_unnamed_7442) + 1.0f, fragment_unnamed_7442, 0.5f);
								float fragment_unnamed_7457 = ((-0.0f) - fragment_unnamed_7449) + mad((-0.0f) - fragment_unnamed_7444, 0.5f, 1.0f);
								float fragment_unnamed_7458 = ((-0.0f) - fragment_unnamed_7450) + mad((-0.0f) - fragment_unnamed_7443, 0.5f, 1.0f);
								float fragment_unnamed_7459 = fragment_unnamed_7449 * 0.5f;
								float fragment_unnamed_7460 = fragment_unnamed_7450 * 0.5f;
								float fragment_unnamed_7461 = mad(fragment_unnamed_7443, 0.5f, fragment_unnamed_7460);
								float fragment_unnamed_7462 = mad(fragment_unnamed_7444, 0.5f, fragment_unnamed_7459);
								float fragment_unnamed_7463 = mad(fragment_unnamed_7449, 0.5f, fragment_unnamed_7457);
								float fragment_unnamed_7464 = mad(fragment_unnamed_7450, 0.5f, fragment_unnamed_7458);
								float fragment_unnamed_7467 = mad(fragment_unnamed_7459, 1.0f / fragment_unnamed_7462, -0.5f);
								float fragment_unnamed_7468 = mad(fragment_unnamed_7460, 1.0f / fragment_unnamed_7461, -0.5f);
								float fragment_unnamed_7471 = mad(fragment_unnamed_7457, 1.0f / fragment_unnamed_7463, 0.5f);
								float fragment_unnamed_7472 = mad(fragment_unnamed_7458, 1.0f / fragment_unnamed_7464, 0.5f);
								float fragment_unnamed_7482 = fragment_uniform_buffer_0[91u].z * fragment_uniform_buffer_0[92u].x;
								float fragment_unnamed_7483 = fragment_uniform_buffer_0[91u].w * fragment_uniform_buffer_0[92u].y;
								float fragment_unnamed_7503 = fragment_unnamed_7021 * fragment_uniform_buffer_0[92u].z;
								float fragment_unnamed_7504 = fragment_unnamed_7461 * fragment_unnamed_7462;
								float4 fragment_unnamed_7515 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7482 * (fragment_unnamed_7435 + fragment_unnamed_7467), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7483 * (fragment_unnamed_7436 + fragment_unnamed_7468), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7503, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_7521 = fragment_unnamed_7461 * fragment_unnamed_7463;
								float fragment_unnamed_7522 = fragment_unnamed_7462 * fragment_unnamed_7464;
								float4 fragment_unnamed_7531 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7482 * (fragment_unnamed_7435 + fragment_unnamed_7471), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7483 * (fragment_unnamed_7436 + fragment_unnamed_7468), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7503, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float4 fragment_unnamed_7553 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7482 * (fragment_unnamed_7435 + fragment_unnamed_7467), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7483 * (fragment_unnamed_7436 + fragment_unnamed_7472), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7503, fragment_uniform_buffer_0[93u].z)), 0.0f);
								float fragment_unnamed_7563 = fragment_unnamed_7464 * fragment_unnamed_7463;
								float4 fragment_unnamed_7572 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_7482 * (fragment_unnamed_7435 + fragment_unnamed_7471), fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_7483 * (fragment_unnamed_7436 + fragment_unnamed_7472), fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7503, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_7757 = mad(fragment_unnamed_7563, fragment_unnamed_7572.w, mad(fragment_unnamed_7522, fragment_unnamed_7553.w, mad(fragment_unnamed_7504, fragment_unnamed_7515.w, fragment_unnamed_7521 * fragment_unnamed_7531.w)));
								fragment_unnamed_7758 = mad(fragment_unnamed_7563, fragment_unnamed_7572.z, mad(fragment_unnamed_7522, fragment_unnamed_7553.z, mad(fragment_unnamed_7504, fragment_unnamed_7515.z, fragment_unnamed_7521 * fragment_unnamed_7531.z)));
								fragment_unnamed_7759 = mad(fragment_unnamed_7563, fragment_unnamed_7572.y, mad(fragment_unnamed_7522, fragment_unnamed_7553.y, mad(fragment_unnamed_7504, fragment_unnamed_7515.y, fragment_unnamed_7521 * fragment_unnamed_7531.y)));
								fragment_unnamed_7760 = mad(fragment_unnamed_7563, fragment_unnamed_7572.x, mad(fragment_unnamed_7522, fragment_unnamed_7553.x, mad(fragment_unnamed_7504, fragment_unnamed_7515.x, fragment_unnamed_7521 * fragment_unnamed_7531.x)));
							}
							else
							{
								float4 fragment_unnamed_7599 = _VBufferLighting.SampleLevel(S0, float3(min(fragment_unnamed_294 * fragment_uniform_buffer_0[92u].x, fragment_uniform_buffer_0[93u].x), min(fragment_unnamed_295 * fragment_uniform_buffer_0[92u].y, fragment_uniform_buffer_0[93u].y), min(fragment_unnamed_7021 * fragment_uniform_buffer_0[92u].z, fragment_uniform_buffer_0[93u].z)), 0.0f);
								fragment_unnamed_7757 = fragment_unnamed_7599.w;
								fragment_unnamed_7758 = fragment_unnamed_7599.z;
								fragment_unnamed_7759 = fragment_unnamed_7599.y;
								fragment_unnamed_7760 = fragment_unnamed_7599.x;
							}
							float fragment_unnamed_7606 = ((-0.0f) - exp2(fragment_unnamed_7757 * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_7769 = asfloat((fragment_unnamed_7606 >= 5.9604644775390625e-08f) ? asuint(fragment_unnamed_7606 * (1.0f / fragment_unnamed_7757)) : 1065353216u);
							fragment_unnamed_7605 = fragment_unnamed_7606;
							fragment_unnamed_7607 = fragment_unnamed_7758 * fragment_unnamed_7769;
							fragment_unnamed_7609 = fragment_unnamed_7759 * fragment_unnamed_7769;
							fragment_unnamed_7611 = fragment_unnamed_7760 * fragment_unnamed_7769;
							fragment_unnamed_7044 = asfloat(asuint(fragment_uniform_buffer_0[96u]).w);
						}
						else
						{
							fragment_unnamed_7605 = asfloat(0u);
							fragment_unnamed_7607 = asfloat(0u);
							fragment_unnamed_7609 = asfloat(0u);
							fragment_unnamed_7611 = asfloat(0u);
							fragment_unnamed_7044 = asfloat(0u);
						}
						float fragment_unnamed_7618 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_6384, (-0.0f) - fragment_unnamed_7044);
						float fragment_unnamed_7034;
						float fragment_unnamed_7036;
						float fragment_unnamed_7038;
						float fragment_unnamed_7040;
						if ((((0.0f < fragment_unnamed_7618) ? 4294967295u : 0u) & (~asuint(fragment_unnamed_5338))) != 0u)
						{
							float fragment_unnamed_7779 = dot(float3(fragment_unnamed_347, fragment_unnamed_348, fragment_unnamed_349), float3(fragment_uniform_buffer_0[83u].xyz));
							float fragment_unnamed_7783 = fragment_unnamed_7044 * ((-0.0f) - fragment_unnamed_7779);
							float fragment_unnamed_7796 = max(abs(fragment_unnamed_7779), 0.001000000047497451305389404296875f);
							float fragment_unnamed_7797 = 1.0f / fragment_unnamed_7796;
							float fragment_unnamed_7800 = min(mad(fragment_unnamed_7618, (-0.0f) - fragment_unnamed_7779, fragment_unnamed_7783), fragment_unnamed_7783);
							float fragment_unnamed_7814 = min(fragment_unnamed_7618, max(fragment_unnamed_7797 * (((-0.0f) - fragment_unnamed_7800) + fragment_uniform_buffer_0[89u].y), 0.0f));
							float fragment_unnamed_7845 = exp2((mad((((-0.0f) - exp2(((fragment_unnamed_7796 * ((-0.0f) - (fragment_unnamed_7618 + ((-0.0f) - fragment_unnamed_7814)))) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f)) + 1.0f) * exp2((((-0.0f) - max(fragment_unnamed_7800 + ((-0.0f) - fragment_uniform_buffer_0[89u].y), 0.0f)) * fragment_uniform_buffer_0[90u].x) * 1.44269502162933349609375f), fragment_unnamed_7797 * fragment_uniform_buffer_0[90u].y, fragment_unnamed_7814) * fragment_uniform_buffer_0[89u].x) * (-1.44269502162933349609375f));
							float fragment_unnamed_7847 = ((-0.0f) - fragment_unnamed_7605) + 1.0f;
							float fragment_unnamed_9038;
							float fragment_unnamed_9039;
							float fragment_unnamed_9040;
							if (fragment_uniform_buffer_0[86u].x == 1.0f)
							{
								float4 fragment_unnamed_8005 = _SkyTexture.SampleLevel(S1, float4(fragment_unnamed_1212, fragment_unnamed_1213, fragment_unnamed_1214, asfloat(0u)), mad((-0.0f) - fragment_uniform_buffer_0[87u].z, clamp(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6384, (-0.0f) - fragment_uniform_buffer_0[87u].x) / (((-0.0f) - fragment_uniform_buffer_0[87u].x) + fragment_uniform_buffer_0[87u].y), 0.0f, 1.0f), 1.0f) * 6.0f);
								fragment_unnamed_9038 = fragment_unnamed_8005.x * fragment_uniform_buffer_0[85u].x;
								fragment_unnamed_9039 = fragment_unnamed_8005.y * fragment_uniform_buffer_0[85u].y;
								fragment_unnamed_9040 = fragment_unnamed_8005.z * fragment_uniform_buffer_0[85u].z;
							}
							else
							{
								uint4 fragment_unnamed_8020 = asuint(fragment_uniform_buffer_0[85u]);
								fragment_unnamed_9038 = asfloat(fragment_unnamed_8020.x);
								fragment_unnamed_9039 = asfloat(fragment_unnamed_8020.y);
								fragment_unnamed_9040 = asfloat(fragment_unnamed_8020.z);
							}
							float fragment_unnamed_9051 = ((-0.0f) - fragment_unnamed_7845) + 1.0f;
							fragment_unnamed_7034 = mad((-0.0f) - fragment_unnamed_7847, fragment_unnamed_7845, 1.0f);
							fragment_unnamed_7036 = mad((fragment_uniform_buffer_0[88u].z / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_4189 * (fragment_unnamed_9040 * fragment_unnamed_7847)), fragment_unnamed_9051, fragment_unnamed_7607);
							fragment_unnamed_7038 = mad((fragment_uniform_buffer_0[88u].y / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_4189 * (fragment_unnamed_9039 * fragment_unnamed_7847)), fragment_unnamed_9051, fragment_unnamed_7609);
							fragment_unnamed_7040 = mad((fragment_uniform_buffer_0[88u].x / fragment_uniform_buffer_0[89u].x) * (fragment_unnamed_4189 * (fragment_unnamed_9038 * fragment_unnamed_7847)), fragment_unnamed_9051, fragment_unnamed_7611);
						}
						else
						{
							fragment_unnamed_7034 = fragment_unnamed_7605;
							fragment_unnamed_7036 = fragment_unnamed_7607;
							fragment_unnamed_7038 = fragment_unnamed_7609;
							fragment_unnamed_7040 = fragment_unnamed_7611;
						}
						fragment_unnamed_7033 = fragment_unnamed_7034;
						fragment_unnamed_7035 = fragment_unnamed_7036;
						fragment_unnamed_7037 = fragment_unnamed_7038;
						fragment_unnamed_7039 = fragment_unnamed_7040;
						fragment_unnamed_7041 = fragment_unnamed_7034;
						fragment_unnamed_7042 = fragment_unnamed_7034;
						fragment_unnamed_7043 = fragment_unnamed_7044;
					}
					else
					{
						fragment_unnamed_7033 = fragment_unnamed_5330;
						fragment_unnamed_7035 = asfloat(0u);
						fragment_unnamed_7037 = asfloat(0u);
						fragment_unnamed_7039 = asfloat(0u);
						fragment_unnamed_7041 = fragment_unnamed_5334;
						fragment_unnamed_7042 = fragment_unnamed_5336;
						fragment_unnamed_7043 = asfloat(0u);
					}
					float fragment_unnamed_7681;
					float fragment_unnamed_7683;
					float fragment_unnamed_7685;
					float fragment_unnamed_7687;
					float fragment_unnamed_7689;
					float fragment_unnamed_7691;
					if (asuint(fragment_unnamed_5338) != 0u)
					{
						uint fragment_unnamed_7630 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 4u;
						uint4 fragment_unnamed_7642 = uint4(T25.Load(fragment_unnamed_7630).x, T25.Load(fragment_unnamed_7630 + 1u).x, T25.Load(fragment_unnamed_7630 + 2u).x, T25.Load(fragment_unnamed_7630 + 3u).x);
						float fragment_unnamed_7650 = asfloat(fragment_unnamed_7642.w);
						uint fragment_unnamed_7656 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 20u;
						uint3 fragment_unnamed_7665 = uint3(T25.Load(fragment_unnamed_7656).x, T25.Load(fragment_unnamed_7656 + 1u).x, T25.Load(fragment_unnamed_7656 + 2u).x);
						float fragment_unnamed_7667 = asfloat(fragment_unnamed_7665.x);
						float fragment_unnamed_7669 = asfloat(fragment_unnamed_7665.y);
						float fragment_unnamed_7671 = asfloat(fragment_unnamed_7665.z);
						float fragment_unnamed_7672 = fragment_unnamed_7650 * asfloat(fragment_unnamed_7642.x);
						float fragment_unnamed_7673 = fragment_unnamed_7650 * asfloat(fragment_unnamed_7642.y);
						float fragment_unnamed_7674 = fragment_unnamed_7650 * asfloat(fragment_unnamed_7642.z);
						float fragment_unnamed_7679 = mad(1.0f / gl_FragCoord.w, fragment_unnamed_6384, (-0.0f) - fragment_unnamed_7043);
						float fragment_unnamed_7684;
						float fragment_unnamed_7686;
						float fragment_unnamed_7688;
						float fragment_unnamed_8027;
						float fragment_unnamed_8028;
						float fragment_unnamed_8029;
						if (0.0f < fragment_unnamed_7679)
						{
							uint fragment_unnamed_7861 = (asuint(fragment_uniform_buffer_0[107u]).x * 28u) + 16u;
							uint3 fragment_unnamed_7870 = uint3(T25.Load(fragment_unnamed_7861).x, T25.Load(fragment_unnamed_7861 + 1u).x, T25.Load(fragment_unnamed_7861 + 2u).x);
							float fragment_unnamed_7877 = dot(float3(fragment_unnamed_347, fragment_unnamed_348, fragment_unnamed_349), float3(fragment_unnamed_7667, fragment_unnamed_7669, fragment_unnamed_7671));
							float fragment_unnamed_7880 = fragment_unnamed_7679 * fragment_unnamed_7672;
							float fragment_unnamed_7881 = fragment_unnamed_7679 * fragment_unnamed_7673;
							float fragment_unnamed_7882 = fragment_unnamed_7679 * fragment_unnamed_7674;
							float fragment_unnamed_7889 = fragment_unnamed_4189 * (((-0.0f) - fragment_unnamed_7042) + 1.0f);
							float fragment_unnamed_7890 = fragment_unnamed_4189 * (((-0.0f) - fragment_unnamed_7041) + 1.0f);
							float fragment_unnamed_7891 = fragment_unnamed_4189 * (((-0.0f) - fragment_unnamed_7033) + 1.0f);
							bool fragment_unnamed_7893 = ((-0.0f) - fragment_unnamed_7877) != 1.0f;
							float fragment_unnamed_7895 = 1.0f / (fragment_unnamed_7877 + 1.0f);
							float fragment_unnamed_7899 = (-0.0f) - fragment_unnamed_7877;
							fragment_unnamed_8027 = fragment_unnamed_7880;
							fragment_unnamed_8028 = fragment_unnamed_7881;
							fragment_unnamed_8029 = fragment_unnamed_7882;
							fragment_unnamed_7684 = mad(asfloat(fragment_unnamed_7893 ? asuint(fragment_unnamed_7891 * (fragment_unnamed_7895 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7882, fragment_unnamed_7899, fragment_unnamed_7882) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7891)), asfloat(fragment_unnamed_7870.z), fragment_unnamed_7035);
							fragment_unnamed_7686 = mad(asfloat(fragment_unnamed_7893 ? asuint(fragment_unnamed_7890 * (fragment_unnamed_7895 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7881, fragment_unnamed_7899, fragment_unnamed_7881) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7890)), asfloat(fragment_unnamed_7870.y), fragment_unnamed_7037);
							fragment_unnamed_7688 = mad(asfloat(fragment_unnamed_7893 ? asuint(fragment_unnamed_7889 * (fragment_unnamed_7895 * (((-0.0f) - exp2(mad((-0.0f) - fragment_unnamed_7880, fragment_unnamed_7899, fragment_unnamed_7880) * (-1.44269502162933349609375f))) + 1.0f))) : asuint(fragment_unnamed_7889)), asfloat(fragment_unnamed_7870.x), fragment_unnamed_7039);
						}
						else
						{
							fragment_unnamed_8027 = asfloat(0u);
							fragment_unnamed_8028 = asfloat(0u);
							fragment_unnamed_8029 = asfloat(0u);
							fragment_unnamed_7684 = fragment_unnamed_7035;
							fragment_unnamed_7686 = fragment_unnamed_7037;
							fragment_unnamed_7688 = fragment_unnamed_7039;
						}
						float fragment_unnamed_8045 = max(((-0.0f) - dot(float3(fragment_input_5.x, fragment_input_5.y, fragment_input_5.z), float3(fragment_unnamed_7667, fragment_unnamed_7669, fragment_unnamed_7671))) + ((-0.0f) - asfloat(T22.Load(0u).x)), 0.0f);
						fragment_unnamed_7681 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_7033) + 1.0f), exp2(mad(fragment_unnamed_8045, fragment_unnamed_7674, fragment_unnamed_8029) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_7683 = fragment_unnamed_7684;
						fragment_unnamed_7685 = fragment_unnamed_7686;
						fragment_unnamed_7687 = fragment_unnamed_7688;
						fragment_unnamed_7689 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_7041) + 1.0f), exp2(mad(fragment_unnamed_8045, fragment_unnamed_7673, fragment_unnamed_8028) * (-1.44269502162933349609375f)), 1.0f);
						fragment_unnamed_7691 = mad((-0.0f) - (((-0.0f) - fragment_unnamed_7042) + 1.0f), exp2(mad(fragment_unnamed_8045, fragment_unnamed_7672, fragment_unnamed_8027) * (-1.44269502162933349609375f)), 1.0f);
					}
					else
					{
						fragment_unnamed_7681 = fragment_unnamed_7033;
						fragment_unnamed_7683 = fragment_unnamed_7035;
						fragment_unnamed_7685 = fragment_unnamed_7037;
						fragment_unnamed_7687 = fragment_unnamed_7039;
						fragment_unnamed_7689 = fragment_unnamed_7041;
						fragment_unnamed_7691 = fragment_unnamed_7042;
					}
					float fragment_unnamed_6646;
					float fragment_unnamed_6648;
					float fragment_unnamed_6650;
					float fragment_unnamed_6652;
					float fragment_unnamed_6654;
					float fragment_unnamed_6656;
					if (asuint(fragment_unnamed_5338) == 0u)
					{
						float fragment_unnamed_7944;
						float fragment_unnamed_7945;
						float fragment_unnamed_7946;
						float fragment_unnamed_7947;
						float fragment_unnamed_7948;
						float fragment_unnamed_7949;
						if (asuint(fragment_uniform_buffer_0[84u]).y != 0u)
						{
							float fragment_unnamed_8070 = fragment_uniform_buffer_0[82u].w + fragment_uniform_buffer_0[83u].w;
							float fragment_unnamed_8076 = dot(float3(fragment_uniform_buffer_0[83u].xyz), float3(fragment_unnamed_1212, fragment_unnamed_1213, fragment_unnamed_1214));
							float fragment_unnamed_8079 = 1.0f / fragment_unnamed_8070;
							float fragment_unnamed_8083 = fragment_unnamed_8079 * fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_8087 = sqrt(max(mad((-0.0f) - fragment_unnamed_8083, fragment_unnamed_8083, 1.0f), 0.0f));
							float fragment_unnamed_8091 = fragment_unnamed_8079 * fragment_uniform_buffer_4[0u].x;
							float fragment_unnamed_8094 = max(mad((-0.0f) - fragment_unnamed_8076, fragment_unnamed_8076, 1.0f), 0.0f);
							float fragment_unnamed_8096 = mad(fragment_unnamed_8091, fragment_unnamed_8091, (-0.0f) - fragment_unnamed_8094);
							float4 fragment_unnamed_8121 = _AtmosphericScatteringLUT.SampleLevel(S0, float3(fragment_unnamed_294, fragment_unnamed_295, sqrt(max(mad(mad(1.0f / gl_FragCoord.w, fragment_unnamed_6384, (-0.0f) - max(asfloat((fragment_unnamed_8096 < 0.0f) ? asuint(fragment_unnamed_8096) : asuint(fragment_unnamed_8070 * (((-0.0f) - fragment_unnamed_8076) + ((-0.0f) - sqrt(fragment_unnamed_8096))))), 0.0f)), 7.8125003710738383233547210693359e-06f, -6.103515625e-05f), 0.0f)) + (-0.0078125f)), 0.0f);
							float fragment_unnamed_8130 = (1.0f / fragment_unnamed_6388) * fragment_uniform_buffer_4[0u].x;
							float fragment_unnamed_8132 = mad(fragment_unnamed_8130, fragment_unnamed_8130, (-0.0f) - fragment_unnamed_8094);
							float fragment_unnamed_8146 = min(max(asfloat((fragment_unnamed_8132 < 0.0f) ? asuint(fragment_unnamed_8132) : asuint((((-0.0f) - sqrt(fragment_unnamed_8132)) + ((-0.0f) - fragment_unnamed_8076)) * fragment_unnamed_6388)), 0.0f) + 128000.0f, fragment_unnamed_6388);
							float fragment_unnamed_8163 = dot(float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z), float3((-0.0f) - fragment_uniform_buffer_0[82u].x, (-0.0f) - fragment_uniform_buffer_0[82u].y, (-0.0f) - fragment_uniform_buffer_0[82u].z));
							float fragment_unnamed_8166 = rsqrt(fragment_unnamed_8163);
							float fragment_unnamed_8178 = sqrt(fragment_unnamed_8163);
							float fragment_unnamed_8179 = dot(float3(fragment_unnamed_8166 * ((-0.0f) - fragment_uniform_buffer_0[82u].x), fragment_unnamed_8166 * ((-0.0f) - fragment_uniform_buffer_0[82u].y), fragment_unnamed_8166 * ((-0.0f) - fragment_uniform_buffer_0[82u].z)), float3(fragment_unnamed_347, fragment_unnamed_348, fragment_unnamed_349));
							float fragment_unnamed_8190 = mad(fragment_unnamed_8146, fragment_unnamed_1212, (-0.0f) - fragment_uniform_buffer_0[82u].x);
							float fragment_unnamed_8191 = mad(fragment_unnamed_8146, fragment_unnamed_1213, (-0.0f) - fragment_uniform_buffer_0[82u].y);
							float fragment_unnamed_8192 = mad(fragment_unnamed_8146, fragment_unnamed_1214, (-0.0f) - fragment_uniform_buffer_0[82u].z);
							float fragment_unnamed_8196 = sqrt(dot(float3(fragment_unnamed_8190, fragment_unnamed_8191, fragment_unnamed_8192), float3(fragment_unnamed_8190, fragment_unnamed_8191, fragment_unnamed_8192)));
							float fragment_unnamed_8201 = dot(float3(fragment_unnamed_8190, fragment_unnamed_8191, fragment_unnamed_8192), float3(fragment_unnamed_1212, fragment_unnamed_1213, fragment_unnamed_1214)) * (1.0f / fragment_unnamed_8196);
							float fragment_unnamed_8204 = (fragment_unnamed_8201 >= 0.0f) ? ((-0.0f) - fragment_unnamed_8179) : fragment_unnamed_8179;
							float fragment_unnamed_8209 = fragment_unnamed_8178 * fragment_uniform_buffer_4[1u].x;
							float fragment_unnamed_8210 = fragment_unnamed_8178 * fragment_uniform_buffer_4[1u].z;
							float fragment_unnamed_8214 = sqrt(max(mad((-0.0f) - fragment_unnamed_8204, fragment_unnamed_8204, 1.0f), 0.0f));
							float fragment_unnamed_8219 = abs(fragment_unnamed_8204) * abs(fragment_unnamed_8204);
							float fragment_unnamed_8222 = (-0.0f) - fragment_unnamed_8219;
							float fragment_unnamed_8236 = abs(fragment_unnamed_8204);
							float fragment_unnamed_8243 = abs(fragment_unnamed_8204);
							float fragment_unnamed_8261 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].x, (-0.0f) - fragment_unnamed_8209) * 1.44269502162933349609375f) * mad(fragment_unnamed_8243, 0.5f, (1.0f / mad(fragment_unnamed_8236, fragment_unnamed_8209, sqrt(fragment_unnamed_8209 * mad(fragment_unnamed_8209 * fragment_unnamed_8219, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_8222, fragment_unnamed_8209, mad(fragment_unnamed_8209, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							float fragment_unnamed_8262 = exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].z, (-0.0f) - fragment_unnamed_8210) * 1.44269502162933349609375f) * mad(fragment_unnamed_8243, 0.5f, (1.0f / mad(fragment_unnamed_8236, fragment_unnamed_8210, sqrt(fragment_unnamed_8210 * mad(fragment_unnamed_8210 * fragment_unnamed_8219, 0.2738279998302459716796875f, 1.47721004486083984375f)))) * (mad(fragment_unnamed_8222, fragment_unnamed_8210, mad(fragment_unnamed_8210, 2.0f, 1.0f)) * 0.761642992496490478515625f));
							bool fragment_unnamed_8263 = fragment_unnamed_8204 < 0.0f;
							float fragment_unnamed_8264 = fragment_unnamed_8214 * fragment_unnamed_8209;
							float fragment_unnamed_8265 = fragment_unnamed_8214 * fragment_unnamed_8210;
							float fragment_unnamed_8266 = rsqrt(fragment_unnamed_8264);
							float fragment_unnamed_8267 = rsqrt(fragment_unnamed_8265);
							float fragment_unnamed_8310 = fragment_unnamed_8196 * fragment_uniform_buffer_4[1u].x;
							float fragment_unnamed_8311 = fragment_unnamed_8196 * fragment_uniform_buffer_4[1u].z;
							float fragment_unnamed_8316 = abs(fragment_unnamed_8201) * abs(fragment_unnamed_8201);
							float fragment_unnamed_8319 = (-0.0f) - fragment_unnamed_8316;
							float fragment_unnamed_8330 = abs(fragment_unnamed_8201);
							float fragment_unnamed_8337 = abs(fragment_unnamed_8201);
							float fragment_unnamed_8365 = abs(mad((-0.0f) - mad(fragment_unnamed_8337, 0.5f, (mad(fragment_unnamed_8319, fragment_unnamed_8310, mad(fragment_unnamed_8310, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_8330, fragment_unnamed_8310, sqrt(fragment_unnamed_8310 * mad(fragment_unnamed_8310 * fragment_unnamed_8316, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].x, (-0.0f) - fragment_unnamed_8310) * 1.44269502162933349609375f), asfloat(fragment_unnamed_8263 ? asuint(mad((dot(fragment_unnamed_8264.xx, fragment_unnamed_8266.xx) + fragment_unnamed_8266) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].x, (-0.0f) - fragment_unnamed_8264) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_8261)) : asuint(fragment_unnamed_8261)))) * fragment_uniform_buffer_4[1u].y;
							float fragment_unnamed_8367 = 1.0f / fragment_unnamed_8178;
							float fragment_unnamed_8372 = fragment_unnamed_8367 * fragment_uniform_buffer_4[2u].z;
							float fragment_unnamed_8373 = fragment_unnamed_8367 * fragment_uniform_buffer_4[2u].w;
							float fragment_unnamed_8377 = (-0.0f) - max(mad((-0.0f) - fragment_unnamed_8179, fragment_unnamed_8179, 1.0f), 0.0f);
							float fragment_unnamed_8378 = mad(fragment_unnamed_8372, fragment_unnamed_8372, fragment_unnamed_8377);
							float fragment_unnamed_8379 = mad(fragment_unnamed_8373, fragment_unnamed_8373, fragment_unnamed_8377);
							bool fragment_unnamed_8380 = fragment_unnamed_8378 < 0.0f;
							bool fragment_unnamed_8381 = fragment_unnamed_8379 < 0.0f;
							float fragment_unnamed_8382 = sqrt(fragment_unnamed_8378);
							float fragment_unnamed_8383 = sqrt(fragment_unnamed_8379);
							uint fragment_unnamed_8394 = asuint(fragment_unnamed_8378);
							uint fragment_unnamed_8397 = fragment_unnamed_8380 ? fragment_unnamed_8394 : asuint(fragment_unnamed_8178 * (fragment_unnamed_8179 + ((-0.0f) - fragment_unnamed_8382)));
							float fragment_unnamed_8398 = asfloat(fragment_unnamed_8397);
							uint fragment_unnamed_8399 = fragment_unnamed_8380 ? fragment_unnamed_8394 : asuint(fragment_unnamed_8178 * (fragment_unnamed_8179 + fragment_unnamed_8382));
							float fragment_unnamed_8400 = asfloat(fragment_unnamed_8399);
							uint fragment_unnamed_8401 = asuint(fragment_unnamed_8379);
							uint fragment_unnamed_8406 = fragment_unnamed_8381 ? fragment_unnamed_8401 : asuint(fragment_unnamed_8178 * (fragment_unnamed_8179 + fragment_unnamed_8383));
							bool fragment_unnamed_8411 = fragment_unnamed_8398 >= 0.0f;
							float fragment_unnamed_8416 = ((-0.0f) - fragment_unnamed_8400) + asfloat(fragment_unnamed_8406);
							float fragment_unnamed_8419 = max(asfloat(fragment_unnamed_8381 ? fragment_unnamed_8401 : asuint(fragment_unnamed_8178 * (fragment_unnamed_8179 + ((-0.0f) - fragment_unnamed_8383)))), 0.0f);
							uint fragment_unnamed_8420 = fragment_unnamed_8411 ? fragment_unnamed_8397 : fragment_unnamed_8406;
							float fragment_unnamed_8426 = ((-0.0f) - fragment_unnamed_8419) + asfloat(fragment_unnamed_8420);
							bool fragment_unnamed_8429 = (((fragment_unnamed_8400 < fragment_unnamed_8146) ? 4294967295u : 0u) & (fragment_unnamed_8411 ? 4294967295u : 0u)) != 0u;
							bool fragment_unnamed_8435 = (((fragment_unnamed_8398 < 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_8400 >= 0.0f) ? 4294967295u : 0u)) != 0u;
							float fragment_unnamed_8440 = asfloat(fragment_unnamed_8435 ? fragment_unnamed_8399 : asuint(fragment_unnamed_8419));
							float fragment_unnamed_8442 = asfloat(fragment_unnamed_8435 ? asuint(fragment_unnamed_8416 * 0.5f) : (fragment_unnamed_8429 ? fragment_unnamed_8399 : asuint(fragment_unnamed_8426 * 0.5f)));
							float fragment_unnamed_8444 = asfloat(fragment_unnamed_8435 ? asuint(fragment_unnamed_8416 * 0.5f) : (fragment_unnamed_8429 ? fragment_unnamed_8420 : asuint(fragment_unnamed_8426 * 0.5f)));
							float fragment_unnamed_8446 = asfloat(fragment_unnamed_8435 ? fragment_unnamed_8406 : (fragment_unnamed_8429 ? fragment_unnamed_8406 : fragment_unnamed_8420));
							float fragment_unnamed_8451 = (-0.0f) - fragment_unnamed_8440;
							float fragment_unnamed_8452 = (-0.0f) - fragment_unnamed_8442;
							float fragment_unnamed_8455 = fragment_unnamed_8451 + min(fragment_unnamed_8146, fragment_unnamed_8444);
							float fragment_unnamed_8456 = fragment_unnamed_8452 + min(fragment_unnamed_8146, fragment_unnamed_8446);
							float fragment_unnamed_8465 = mad(fragment_unnamed_8451 + min(fragment_unnamed_8146, fragment_unnamed_8444), 0.25f, fragment_unnamed_8440);
							float fragment_unnamed_8466 = mad(fragment_unnamed_8452 + min(fragment_unnamed_8146, fragment_unnamed_8446), 0.25f, fragment_unnamed_8442);
							float fragment_unnamed_8467 = mad(fragment_unnamed_8455, 0.75f, fragment_unnamed_8440);
							float fragment_unnamed_8469 = mad(fragment_unnamed_8456, 0.75f, fragment_unnamed_8442);
							float fragment_unnamed_8471 = dot(((-0.0f) - fragment_unnamed_8179).xx, fragment_unnamed_8178.xx);
							float fragment_unnamed_8489 = (-0.0f) - fragment_uniform_buffer_0[82u].w;
							float fragment_unnamed_8525 = mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8469, fragment_unnamed_8469 + fragment_unnamed_8471, fragment_unnamed_8163)) + fragment_unnamed_8489, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_8456, 0.0f) * 0.5f, mad(max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8467, fragment_unnamed_8467 + fragment_unnamed_8471, fragment_unnamed_8163)) + fragment_unnamed_8489, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f), max(fragment_unnamed_8455, 0.0f) * 0.5f, ((max(fragment_unnamed_8456, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8466, fragment_unnamed_8466 + fragment_unnamed_8471, fragment_unnamed_8163)) + fragment_unnamed_8489, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f)) + ((max(fragment_unnamed_8455, 0.0f) * 0.5f) * max(((-0.0f) - abs(mad(sqrt(mad(fragment_unnamed_8465, fragment_unnamed_8465 + fragment_unnamed_8471, fragment_unnamed_8163)) + fragment_unnamed_8489, fragment_uniform_buffer_4[2u].x, fragment_uniform_buffer_4[2u].y))) + 1.0f, 0.0f)))) * 0.60000002384185791015625f;
							float fragment_unnamed_8530 = (abs(mad((-0.0f) - mad(fragment_unnamed_8337, 0.5f, (mad(fragment_unnamed_8319, fragment_unnamed_8311, mad(fragment_unnamed_8311, 2.0f, 1.0f)) * 0.761642992496490478515625f) * (1.0f / mad(fragment_unnamed_8330, fragment_unnamed_8311, sqrt(fragment_unnamed_8311 * mad(fragment_unnamed_8311 * fragment_unnamed_8316, 0.2738279998302459716796875f, 1.47721004486083984375f))))), exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].z, (-0.0f) - fragment_unnamed_8311) * 1.44269502162933349609375f), asfloat(fragment_unnamed_8263 ? asuint(mad((dot(fragment_unnamed_8265.xx, fragment_unnamed_8267.xx) + fragment_unnamed_8267) * 1.25331401824951171875f, exp2(mad(fragment_uniform_buffer_0[82u].w, fragment_uniform_buffer_4[1u].z, (-0.0f) - fragment_unnamed_8265) * 1.44269502162933349609375f), (-0.0f) - fragment_unnamed_8262)) : asuint(fragment_unnamed_8262)))) * fragment_uniform_buffer_4[1u].w) * fragment_uniform_buffer_4[0u].w;
							float fragment_unnamed_8556 = ((-0.0f) - exp2(mad(fragment_unnamed_8525, fragment_uniform_buffer_4[6u].x, mad(fragment_unnamed_8365, fragment_uniform_buffer_4[3u].x, fragment_unnamed_8530)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8557 = ((-0.0f) - exp2(mad(fragment_unnamed_8525, fragment_uniform_buffer_4[6u].y, mad(fragment_unnamed_8365, fragment_uniform_buffer_4[3u].y, fragment_unnamed_8530)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8558 = ((-0.0f) - exp2(mad(fragment_unnamed_8525, fragment_uniform_buffer_4[6u].z, mad(fragment_unnamed_8365, fragment_uniform_buffer_4[3u].z, fragment_unnamed_8530)) * (-1.44269502162933349609375f))) + 1.0f;
							float fragment_unnamed_8560 = fragment_unnamed_8558 + (fragment_unnamed_8557 + fragment_unnamed_8556);
							float fragment_unnamed_8561 = fragment_unnamed_8560 * 0.3333333432674407958984375f;
							float fragment_unnamed_8562 = (-0.0f) - fragment_unnamed_8560;
							float fragment_unnamed_8580 = sqrt(((-0.0f) - fragment_unnamed_8087) + 1.0f);
							float fragment_unnamed_8586 = mad(mad(mad(fragment_unnamed_8087, -0.0187292993068695068359375f, 0.074261002242565155029296875f), fragment_unnamed_8087, -0.212114393711090087890625f), fragment_unnamed_8087, 1.570728778839111328125f);
							float fragment_unnamed_8597 = mad(fragment_unnamed_8586, fragment_unnamed_8580, asfloat(((((-0.0f) - fragment_unnamed_8087) < fragment_unnamed_8087) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_8580 * fragment_unnamed_8586, -2.0f, 3.1415927410125732421875f))));
							float fragment_unnamed_8601 = sqrt(((-0.0f) - abs(fragment_unnamed_8076)) + 1.0f);
							float fragment_unnamed_8607 = mad(mad(mad(abs(fragment_unnamed_8076), -0.0187292993068695068359375f, 0.074261002242565155029296875f), abs(fragment_unnamed_8076), -0.212114393711090087890625f), abs(fragment_unnamed_8076), 1.570728778839111328125f);
							float fragment_unnamed_8618 = 1.0f / ((-0.0f) - fragment_unnamed_8597);
							float fragment_unnamed_8636 = mad(exp2((clamp(mad(mad(fragment_unnamed_8607, fragment_unnamed_8601, asfloat(((fragment_unnamed_8076 < ((-0.0f) - fragment_unnamed_8076)) ? 4294967295u : 0u) & asuint(mad(fragment_unnamed_8601 * fragment_unnamed_8607, -2.0f, 3.1415927410125732421875f)))), fragment_unnamed_8618, (-0.0f) - (fragment_unnamed_8597 * fragment_unnamed_8618)), 0.0f, 1.0f) * fragment_uniform_buffer_4[11u].x) * 1.44269502162933349609375f), fragment_uniform_buffer_4[11u].y, (-0.0f) - fragment_uniform_buffer_4[11u].y);
							float fragment_unnamed_8667 = ((-0.0f) - fragment_unnamed_7691) + 1.0f;
							float fragment_unnamed_8668 = ((-0.0f) - fragment_unnamed_7689) + 1.0f;
							float fragment_unnamed_8669 = ((-0.0f) - fragment_unnamed_7681) + 1.0f;
							fragment_unnamed_7944 = mad(fragment_unnamed_8669, mad(mad(fragment_unnamed_8562, 0.3333333432674407958984375f, fragment_unnamed_8558), fragment_uniform_buffer_4[10u].z, fragment_unnamed_8561) * fragment_uniform_buffer_4[10u].w, fragment_unnamed_7681);
							fragment_unnamed_7945 = mad(fragment_unnamed_8669, fragment_unnamed_8121.z * mad(fragment_unnamed_8636, ((-0.0f) - fragment_uniform_buffer_4[8u].z) + fragment_uniform_buffer_4[9u].z, fragment_uniform_buffer_4[8u].z), fragment_unnamed_7683);
							fragment_unnamed_7946 = mad(fragment_unnamed_8668, fragment_unnamed_8121.y * mad(fragment_unnamed_8636, ((-0.0f) - fragment_uniform_buffer_4[8u].y) + fragment_uniform_buffer_4[9u].y, fragment_uniform_buffer_4[8u].y), fragment_unnamed_7685);
							fragment_unnamed_7947 = mad(fragment_unnamed_8667, fragment_unnamed_8121.x * mad(fragment_unnamed_8636, ((-0.0f) - fragment_uniform_buffer_4[8u].x) + fragment_uniform_buffer_4[9u].x, fragment_uniform_buffer_4[8u].x), fragment_unnamed_7687);
							fragment_unnamed_7948 = mad(fragment_unnamed_8668, mad(mad(fragment_unnamed_8562, 0.3333333432674407958984375f, fragment_unnamed_8557), fragment_uniform_buffer_4[10u].z, fragment_unnamed_8561) * fragment_uniform_buffer_4[10u].w, fragment_unnamed_7689);
							fragment_unnamed_7949 = mad(fragment_unnamed_8667, mad(mad(fragment_unnamed_8562, 0.3333333432674407958984375f, fragment_unnamed_8556), fragment_uniform_buffer_4[10u].z, fragment_unnamed_8561) * fragment_uniform_buffer_4[10u].w, fragment_unnamed_7691);
						}
						else
						{
							fragment_unnamed_7944 = fragment_unnamed_7681;
							fragment_unnamed_7945 = fragment_unnamed_7683;
							fragment_unnamed_7946 = fragment_unnamed_7685;
							fragment_unnamed_7947 = fragment_unnamed_7687;
							fragment_unnamed_7948 = fragment_unnamed_7689;
							fragment_unnamed_7949 = fragment_unnamed_7691;
						}
						fragment_unnamed_6646 = fragment_unnamed_7944;
						fragment_unnamed_6648 = fragment_unnamed_7945;
						fragment_unnamed_6650 = fragment_unnamed_7946;
						fragment_unnamed_6652 = fragment_unnamed_7947;
						fragment_unnamed_6654 = fragment_unnamed_7948;
						fragment_unnamed_6656 = fragment_unnamed_7949;
					}
					else
					{
						fragment_unnamed_6646 = fragment_unnamed_7681;
						fragment_unnamed_6648 = fragment_unnamed_7683;
						fragment_unnamed_6650 = fragment_unnamed_7685;
						fragment_unnamed_6652 = fragment_unnamed_7687;
						fragment_unnamed_6654 = fragment_unnamed_7689;
						fragment_unnamed_6656 = fragment_unnamed_7691;
					}
					fragment_unnamed_6645 = fragment_unnamed_6646;
					fragment_unnamed_6647 = fragment_unnamed_6648;
					fragment_unnamed_6649 = fragment_unnamed_6650;
					fragment_unnamed_6651 = fragment_unnamed_6652;
					fragment_unnamed_6653 = fragment_unnamed_6654;
					fragment_unnamed_6655 = fragment_unnamed_6656;
				}
				else
				{
					fragment_unnamed_6645 = fragment_unnamed_5330;
					fragment_unnamed_6647 = asfloat(0u);
					fragment_unnamed_6649 = asfloat(0u);
					fragment_unnamed_6651 = asfloat(0u);
					fragment_unnamed_6653 = fragment_unnamed_5334;
					fragment_unnamed_6655 = fragment_unnamed_5336;
				}
				float fragment_unnamed_6660 = ((-0.0f) - fragment_unnamed_6655) + 1.0f;
				float fragment_unnamed_6661 = ((-0.0f) - fragment_unnamed_6653) + 1.0f;
				float fragment_unnamed_6662 = ((-0.0f) - fragment_unnamed_6645) + 1.0f;
				float fragment_unnamed_6666 = mad(fragment_unnamed_4193, fragment_unnamed_6660, fragment_unnamed_6651);
				float fragment_unnamed_6667 = mad(fragment_unnamed_4194, fragment_unnamed_6661, fragment_unnamed_6649);
				float fragment_unnamed_6668 = mad(fragment_unnamed_4195, fragment_unnamed_6662, fragment_unnamed_6647);
				bool fragment_unnamed_6672 = fragment_uniform_buffer_3[20u].x == 0.0f;
				bool fragment_unnamed_6673 = fragment_uniform_buffer_3[20u].x == 1.0f;
				bool fragment_unnamed_6674 = fragment_uniform_buffer_3[20u].x == 4.0f;
				fragment_output_0.x = fragment_unnamed_6672 ? fragment_unnamed_6666 : asfloat(fragment_unnamed_6673 ? asuint(fragment_unnamed_4193 * fragment_unnamed_6660) : (fragment_unnamed_6674 ? asuint(fragment_unnamed_6666) : asuint(fragment_unnamed_4193)));
				fragment_output_0.y = fragment_unnamed_6672 ? fragment_unnamed_6667 : asfloat(fragment_unnamed_6673 ? asuint(fragment_unnamed_4194 * fragment_unnamed_6661) : (fragment_unnamed_6674 ? asuint(fragment_unnamed_6667) : asuint(fragment_unnamed_4194)));
				fragment_output_0.z = fragment_unnamed_6672 ? fragment_unnamed_6668 : asfloat(fragment_unnamed_6673 ? asuint(fragment_unnamed_4195 * fragment_unnamed_6662) : (fragment_unnamed_6674 ? asuint(fragment_unnamed_6668) : asuint(fragment_unnamed_4195)));
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

				fragment_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				fragment_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				fragment_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				fragment_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

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

				fragment_uniform_buffer_3[0] = float4(_ArmoryStep, fragment_uniform_buffer_3[0][1], fragment_uniform_buffer_3[0][2], fragment_uniform_buffer_3[0][3]);

				fragment_uniform_buffer_3[0] = float4(fragment_uniform_buffer_3[0][0], _PermsMapOffset[0], _PermsMapOffset[1], fragment_uniform_buffer_3[0][3]);

				fragment_uniform_buffer_3[0] = float4(fragment_uniform_buffer_3[0][0], fragment_uniform_buffer_3[0][1], fragment_uniform_buffer_3[0][2], _AdminStep);

				fragment_uniform_buffer_3[2] = float4(_Tint[0], _Tint[1], _Tint[2], _Tint[3]);

				fragment_uniform_buffer_3[5] = float4(_HoloIntensity, fragment_uniform_buffer_3[5][1], fragment_uniform_buffer_3[5][2], fragment_uniform_buffer_3[5][3]);

				fragment_uniform_buffer_3[5] = float4(fragment_uniform_buffer_3[5][0], _HoloPower, fragment_uniform_buffer_3[5][2], fragment_uniform_buffer_3[5][3]);

				fragment_uniform_buffer_3[5] = float4(fragment_uniform_buffer_3[5][0], fragment_uniform_buffer_3[5][1], _HoloMask, fragment_uniform_buffer_3[5][3]);

				fragment_uniform_buffer_3[5] = float4(fragment_uniform_buffer_3[5][0], fragment_uniform_buffer_3[5][1], fragment_uniform_buffer_3[5][2], _HoloFade);

				fragment_uniform_buffer_3[7] = float4(_ContainmentStep, fragment_uniform_buffer_3[7][1], fragment_uniform_buffer_3[7][2], fragment_uniform_buffer_3[7][3]);

				fragment_uniform_buffer_3[9] = float4(_PermsMapTilling[0], _PermsMapTilling[1], fragment_uniform_buffer_3[9][2], fragment_uniform_buffer_3[9][3]);

				fragment_uniform_buffer_3[10] = float4(_PermsColor[0], _PermsColor[1], _PermsColor[2], _PermsColor[3]);

				fragment_uniform_buffer_3[11] = float4(_PermsRotation, fragment_uniform_buffer_3[11][1], fragment_uniform_buffer_3[11][2], fragment_uniform_buffer_3[11][3]);

				fragment_uniform_buffer_3[11] = float4(fragment_uniform_buffer_3[11][0], _DistanceTintRemapIn[0], _DistanceTintRemapIn[1], fragment_uniform_buffer_3[11][3]);

				fragment_uniform_buffer_3[11] = float4(fragment_uniform_buffer_3[11][0], fragment_uniform_buffer_3[11][1], fragment_uniform_buffer_3[11][2], _IgnoreDistanceTint);

				fragment_uniform_buffer_3[12] = float4(_DistanceTintSaturationRemap[0], _DistanceTintSaturationRemap[1], fragment_uniform_buffer_3[12][2], fragment_uniform_buffer_3[12][3]);

				fragment_uniform_buffer_3[12] = float4(fragment_uniform_buffer_3[12][0], fragment_uniform_buffer_3[12][1], _DistanceTintSaturation, fragment_uniform_buffer_3[12][3]);

				fragment_uniform_buffer_3[20] = float4(_BlendMode, fragment_uniform_buffer_3[20][1], fragment_uniform_buffer_3[20][2], fragment_uniform_buffer_3[20][3]);

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
			static float4 vertex_uniform_buffer_2[21];
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
				if ((((0.0f < vertex_uniform_buffer_2[20u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[20] = float4(vertex_uniform_buffer_2[20][0], vertex_uniform_buffer_2[20][1], _RayTracing, vertex_uniform_buffer_2[20][3]);

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
			GpuProgramID 775590

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
			GpuProgramID 798024

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
			GpuProgramID 866012

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
			GpuProgramID 976915

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
			GpuProgramID 1012729

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
			GpuProgramID 1067674

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
