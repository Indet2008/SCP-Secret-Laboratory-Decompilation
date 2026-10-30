Shader "Shader Graphs/Canister"
{
	Properties
	{
		_Canister_color ("Canister color", Color) = (0,0,0,0)
		_Alpha_Cutout ("Alpha Cutout", Range(0, 1)) = 0
		_Roughness_contrast ("Roughness contrast", Float) = 0
		_Extra_Normal_Intensity ("Extra Normal Intensity", Float) = 0
		[NoScaleOffset] _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] _SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] [Normal] _SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D ("Texture2D", 2D) = "bump" {}
		[NoScaleOffset] [Normal] _SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D ("Texture2D", 2D) = "bump" {}
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
			GpuProgramID 1652

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_instancing
			#pragma multi_compile _ _ALPHATEST_ON


			#if !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)

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

			#endif // !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)


			#if defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)

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


			float _GlobalMipBias;
			float _Alpha_Cutout;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[6];
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;

			static float4 fragment_input_1;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_62)
			{
				if (fragment_unnamed_62)
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
				discard_cond((_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y).w + ((-0.0f) - fragment_uniform_buffer_1[5u].x)) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				frag_main();
			}

			#endif // defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)


			#if defined(INSTANCING_ON) && !defined(_ALPHATEST_ON)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static uint vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				uint gl_InstanceIndex : SV_InstanceID;
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				uint vertex_output_2 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_46 = asfloat(1065353216u);
				uint vertex_unnamed_59 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
				uint vertex_unnamed_71 = vertex_unnamed_59 + 3u;
				float vertex_unnamed_98 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_71].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				float vertex_unnamed_129 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_71].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				float vertex_unnamed_161 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_71].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_129, vertex_unnamed_98 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_129, vertex_unnamed_98 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_129, vertex_unnamed_98 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_129, vertex_unnamed_98 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
				vertex_output_2 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			static float4 fragment_input_1;
			static uint fragment_input_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				uint fragment_input_2 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			void frag_main()
			{
			}

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
			}

			#endif // defined(INSTANCING_ON) && !defined(_ALPHATEST_ON)


			#if defined(INSTANCING_ON) && defined(_ALPHATEST_ON)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_output_1;
			static uint vertex_output_2;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				uint gl_InstanceIndex : SV_InstanceID;
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				uint vertex_output_2 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_46 = asfloat(1065353216u);
				uint vertex_unnamed_59 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
				uint vertex_unnamed_71 = vertex_unnamed_59 + 3u;
				float vertex_unnamed_98 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_71].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				float vertex_unnamed_129 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_71].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				float vertex_unnamed_161 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_59 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_71].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_46));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_129, vertex_unnamed_98 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_129, vertex_unnamed_98 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_129, vertex_unnamed_98 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_161, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_129, vertex_unnamed_98 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_1.x = vertex_input_3.x;
				vertex_output_1.y = vertex_input_3.y;
				vertex_output_1.z = vertex_input_3.z;
				vertex_output_1.w = vertex_input_3.w;
				vertex_output_2 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				stage_output.vertex_output_1 = vertex_output_1;
				stage_output.vertex_output_2 = vertex_output_2;
				return stage_output;
			}


			float _GlobalMipBias;
			float _Alpha_Cutout;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[6];
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;

			static float4 fragment_input_1;
			static uint fragment_input_2;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				uint fragment_input_2 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_64)
			{
				if (fragment_unnamed_64)
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
				discard_cond((_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_1.x, fragment_input_1.y), fragment_uniform_buffer_0[86u].y).w + ((-0.0f) - fragment_uniform_buffer_1[5u].x)) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				frag_main();
			}

			#endif // defined(INSTANCING_ON) && defined(_ALPHATEST_ON)


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
			GpuProgramID 309590

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_instancing
			#pragma multi_compile _ WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma multi_compile _ _ALPHATEST_ON


			#if !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;

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

			#endif // !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


			#if defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;

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


			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			float _Alpha_Cutout;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[6];
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;

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

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_154)
			{
				if (fragment_unnamed_154)
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
				discard_cond((_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).w + ((-0.0f) - fragment_uniform_buffer_2[5u].x)) < 0.0f);
				float fragment_unnamed_94 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_95 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_143 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_143 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_94) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_94)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_143 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_95) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_95)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[5] = float4(_Alpha_Cutout, fragment_uniform_buffer_2[5][1], fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

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

			#endif // defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


			#if defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 unity_MotionVectorsParams;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { float4x4 unity_PrevObjectToWorldArray; float4x4 unity_PrevWorldToObjectArray; } unity_Builtins3Array[2];

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[1];
			static float4 vertex_uniform_buffer_3[18];
			static float4 vertex_uniform_buffer_4[16];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float3 vertex_input_6;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;
			static uint vertex_output_8;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // COLOR
				float3 vertex_input_6 : TEXCOORD4; // TEXCOORD_4
				uint gl_InstanceIndex : SV_InstanceID;
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
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
				uint vertex_output_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_67 = (uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_2[0u]).x;
				uint vertex_unnamed_68 = vertex_unnamed_67 * 9u;
				uint vertex_unnamed_80 = vertex_unnamed_68 + 3u;
				float vertex_unnamed_115 = asfloat(1065353216u);
				float vertex_unnamed_117 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68]).x), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_3[vertex_unnamed_80].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_115));
				float vertex_unnamed_137 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68]).y), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_3[vertex_unnamed_80].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_115));
				float vertex_unnamed_157 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68]).z), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_3[vertex_unnamed_80].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_115));
				float vertex_unnamed_173 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_68 + 4u].xyz));
				float vertex_unnamed_189 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_68 + 5u].xyz));
				float vertex_unnamed_205 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_68 + 6u].xyz));
				float vertex_unnamed_214 = rsqrt(max(dot(float3(vertex_unnamed_173, vertex_unnamed_189, vertex_unnamed_205), float3(vertex_unnamed_173, vertex_unnamed_189, vertex_unnamed_205)), 1.1754943508222875079687365372222e-38f));
				vertex_output_7.x = vertex_unnamed_214 * vertex_unnamed_173;
				vertex_output_7.y = vertex_unnamed_214 * vertex_unnamed_189;
				vertex_output_7.z = vertex_unnamed_214 * vertex_unnamed_205;
				uint vertex_unnamed_224 = vertex_unnamed_68 + 1u;
				uint vertex_unnamed_243 = vertex_unnamed_68 + 2u;
				float vertex_unnamed_251 = mad(vertex_uniform_buffer_3[vertex_unnamed_243].x, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_68].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_224].x));
				float vertex_unnamed_252 = mad(vertex_uniform_buffer_3[vertex_unnamed_243].y, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_68].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_224].y));
				float vertex_unnamed_253 = mad(vertex_uniform_buffer_3[vertex_unnamed_243].z, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_68].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_224].z));
				float vertex_unnamed_258 = rsqrt(max(dot(float3(vertex_unnamed_251, vertex_unnamed_252, vertex_unnamed_253), float3(vertex_unnamed_251, vertex_unnamed_252, vertex_unnamed_253)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_251 * vertex_unnamed_258;
				vertex_output_3.y = vertex_unnamed_252 * vertex_unnamed_258;
				vertex_output_3.z = vertex_unnamed_253 * vertex_unnamed_258;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_157, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_157, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_157, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_157, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_157, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_157, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_157, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_366 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_379 = vertex_unnamed_366 ? vertex_input_6.x : vertex_input_0.x;
					float vertex_unnamed_380 = vertex_unnamed_366 ? vertex_input_6.y : vertex_input_0.y;
					float vertex_unnamed_381 = vertex_unnamed_366 ? vertex_input_6.z : vertex_input_0.z;
					uint vertex_unnamed_382 = vertex_unnamed_67 << 3u;
					uint vertex_unnamed_391 = vertex_unnamed_382 + 3u;
					float vertex_unnamed_417 = asfloat(1065353216u);
					float vertex_unnamed_418 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382]).x), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_4[vertex_unnamed_391].x), float4(vertex_unnamed_379, vertex_unnamed_380, vertex_unnamed_381, vertex_unnamed_417));
					float vertex_unnamed_438 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382]).y), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_4[vertex_unnamed_391].y), float4(vertex_unnamed_379, vertex_unnamed_380, vertex_unnamed_381, vertex_unnamed_417));
					float vertex_unnamed_458 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382]).z), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_4[vertex_unnamed_391].z), float4(vertex_unnamed_379, vertex_unnamed_380, vertex_unnamed_381, vertex_unnamed_417));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_458, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_418, vertex_unnamed_438 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_458, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_418, vertex_unnamed_438 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_458, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_418, vertex_unnamed_438 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
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
				vertex_output_6.x = vertex_unnamed_117;
				vertex_output_6.y = vertex_unnamed_137;
				vertex_output_6.z = vertex_unnamed_157;
				vertex_output_8 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
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

				vertex_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				vertex_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_2[0][1], vertex_uniform_buffer_2[0][2], vertex_uniform_buffer_2[0][3]);

				vertex_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_3[8][1], vertex_uniform_buffer_3[8][2], vertex_uniform_buffer_3[8][3]);
				vertex_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_3[17][1], vertex_uniform_buffer_3[17][2], vertex_uniform_buffer_3[17][3]);
				vertex_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_4[0] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][0]);
				vertex_uniform_buffer_4[1] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][1]);
				vertex_uniform_buffer_4[2] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][2]);
				vertex_uniform_buffer_4[3] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][3]);
				vertex_uniform_buffer_4[4] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][0]);
				vertex_uniform_buffer_4[5] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][1]);
				vertex_uniform_buffer_4[6] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][2]);
				vertex_uniform_buffer_4[7] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][3]);
				vertex_uniform_buffer_4[8] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][0]);
				vertex_uniform_buffer_4[9] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][1]);
				vertex_uniform_buffer_4[10] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][2]);
				vertex_uniform_buffer_4[11] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][3]);
				vertex_uniform_buffer_4[12] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][0]);
				vertex_uniform_buffer_4[13] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][1]);
				vertex_uniform_buffer_4[14] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][2]);
				vertex_uniform_buffer_4[15] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_6 = stage_input.vertex_input_6;
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
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
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
				uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
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
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


			#if defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 unity_MotionVectorsParams;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { float4x4 unity_PrevObjectToWorldArray; float4x4 unity_PrevWorldToObjectArray; } unity_Builtins3Array[2];

			static float4 vertex_uniform_buffer_0[49];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[1];
			static float4 vertex_uniform_buffer_3[18];
			static float4 vertex_uniform_buffer_4[16];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float3 vertex_input_6;
			static float3 vertex_output_0;
			static float3 vertex_output_1;
			static float4 vertex_output_3;
			static float4 vertex_output_4;
			static float4 vertex_output_5;
			static float3 vertex_output_6;
			static float3 vertex_output_7;
			static uint vertex_output_8;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // COLOR
				float3 vertex_input_6 : TEXCOORD4; // TEXCOORD_4
				uint gl_InstanceIndex : SV_InstanceID;
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
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
				uint vertex_output_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_67 = (uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_2[0u]).x;
				uint vertex_unnamed_68 = vertex_unnamed_67 * 9u;
				uint vertex_unnamed_80 = vertex_unnamed_68 + 3u;
				float vertex_unnamed_115 = asfloat(1065353216u);
				float vertex_unnamed_117 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68]).x), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_3[vertex_unnamed_80].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_115));
				float vertex_unnamed_137 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68]).y), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_3[vertex_unnamed_80].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_115));
				float vertex_unnamed_157 = dot(float4(asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68]).z), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_3[vertex_unnamed_68 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_3[vertex_unnamed_80].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_115));
				float vertex_unnamed_173 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_68 + 4u].xyz));
				float vertex_unnamed_189 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_68 + 5u].xyz));
				float vertex_unnamed_205 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_3[vertex_unnamed_68 + 6u].xyz));
				float vertex_unnamed_214 = rsqrt(max(dot(float3(vertex_unnamed_173, vertex_unnamed_189, vertex_unnamed_205), float3(vertex_unnamed_173, vertex_unnamed_189, vertex_unnamed_205)), 1.1754943508222875079687365372222e-38f));
				vertex_output_7.x = vertex_unnamed_214 * vertex_unnamed_173;
				vertex_output_7.y = vertex_unnamed_214 * vertex_unnamed_189;
				vertex_output_7.z = vertex_unnamed_214 * vertex_unnamed_205;
				uint vertex_unnamed_224 = vertex_unnamed_68 + 1u;
				uint vertex_unnamed_243 = vertex_unnamed_68 + 2u;
				float vertex_unnamed_251 = mad(vertex_uniform_buffer_3[vertex_unnamed_243].x, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_68].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_224].x));
				float vertex_unnamed_252 = mad(vertex_uniform_buffer_3[vertex_unnamed_243].y, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_68].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_224].y));
				float vertex_unnamed_253 = mad(vertex_uniform_buffer_3[vertex_unnamed_243].z, vertex_input_2.z, mad(vertex_uniform_buffer_3[vertex_unnamed_68].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_3[vertex_unnamed_224].z));
				float vertex_unnamed_258 = rsqrt(max(dot(float3(vertex_unnamed_251, vertex_unnamed_252, vertex_unnamed_253), float3(vertex_unnamed_251, vertex_unnamed_252, vertex_unnamed_253)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_251 * vertex_unnamed_258;
				vertex_output_3.y = vertex_unnamed_252 * vertex_unnamed_258;
				vertex_output_3.z = vertex_unnamed_253 * vertex_unnamed_258;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_157, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_157, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_157, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_157, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_157, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_157, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_157, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_117, vertex_unnamed_137 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_366 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_379 = vertex_unnamed_366 ? vertex_input_6.x : vertex_input_0.x;
					float vertex_unnamed_380 = vertex_unnamed_366 ? vertex_input_6.y : vertex_input_0.y;
					float vertex_unnamed_381 = vertex_unnamed_366 ? vertex_input_6.z : vertex_input_0.z;
					uint vertex_unnamed_382 = vertex_unnamed_67 << 3u;
					uint vertex_unnamed_391 = vertex_unnamed_382 + 3u;
					float vertex_unnamed_417 = asfloat(1065353216u);
					float vertex_unnamed_418 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382]).x), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_4[vertex_unnamed_391].x), float4(vertex_unnamed_379, vertex_unnamed_380, vertex_unnamed_381, vertex_unnamed_417));
					float vertex_unnamed_438 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382]).y), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_4[vertex_unnamed_391].y), float4(vertex_unnamed_379, vertex_unnamed_380, vertex_unnamed_381, vertex_unnamed_417));
					float vertex_unnamed_458 = dot(float4(asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382]).z), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_4[vertex_unnamed_382 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_4[vertex_unnamed_391].z), float4(vertex_unnamed_379, vertex_unnamed_380, vertex_unnamed_381, vertex_unnamed_417));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_458, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_418, vertex_unnamed_438 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_458, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_418, vertex_unnamed_438 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_458, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_418, vertex_unnamed_438 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
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
				vertex_output_6.x = vertex_unnamed_117;
				vertex_output_6.y = vertex_unnamed_137;
				vertex_output_6.z = vertex_unnamed_157;
				vertex_output_8 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
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

				vertex_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				vertex_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_2[0][1], vertex_uniform_buffer_2[0][2], vertex_uniform_buffer_2[0][3]);

				vertex_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_3[8][1], vertex_uniform_buffer_3[8][2], vertex_uniform_buffer_3[8][3]);
				vertex_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_3[17][1], vertex_uniform_buffer_3[17][2], vertex_uniform_buffer_3[17][3]);
				vertex_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_4[0] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][0], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][0]);
				vertex_uniform_buffer_4[1] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][1], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][1]);
				vertex_uniform_buffer_4[2] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][2], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][2]);
				vertex_uniform_buffer_4[3] = float4(unity_Builtins3Array[0].unity_PrevObjectToWorldArray[0][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[1][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[2][3], unity_Builtins3Array[0].unity_PrevObjectToWorldArray[3][3]);
				vertex_uniform_buffer_4[4] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][0], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][0]);
				vertex_uniform_buffer_4[5] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][1], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][1]);
				vertex_uniform_buffer_4[6] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][2], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][2]);
				vertex_uniform_buffer_4[7] = float4(unity_Builtins3Array[0].unity_PrevWorldToObjectArray[0][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[1][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[2][3], unity_Builtins3Array[0].unity_PrevWorldToObjectArray[3][3]);
				vertex_uniform_buffer_4[8] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][0], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][0]);
				vertex_uniform_buffer_4[9] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][1], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][1]);
				vertex_uniform_buffer_4[10] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][2], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][2]);
				vertex_uniform_buffer_4[11] = float4(unity_Builtins3Array[1].unity_PrevObjectToWorldArray[0][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[1][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[2][3], unity_Builtins3Array[1].unity_PrevObjectToWorldArray[3][3]);
				vertex_uniform_buffer_4[12] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][0], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][0]);
				vertex_uniform_buffer_4[13] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][1], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][1]);
				vertex_uniform_buffer_4[14] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][2], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][2]);
				vertex_uniform_buffer_4[15] = float4(unity_Builtins3Array[1].unity_PrevWorldToObjectArray[0][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[1][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[2][3], unity_Builtins3Array[1].unity_PrevWorldToObjectArray[3][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vertex_input_4 = stage_input.vertex_input_4;
				vertex_input_6 = stage_input.vertex_input_6;
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
				return stage_output;
			}


			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			float _Alpha_Cutout;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[6];
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;

			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
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
				uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			struct Fragment_Stage_Output
			{
				float4 fragment_output_0 : SV_Target0;
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_156)
			{
				if (fragment_unnamed_156)
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
				discard_cond((_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).w + ((-0.0f) - fragment_uniform_buffer_2[5u].x)) < 0.0f);
				float fragment_unnamed_96 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_97 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_145 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_145 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_96) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_96)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_145 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_97) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_97)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[5] = float4(_Alpha_Cutout, fragment_uniform_buffer_2[5][1], fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


			#if defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON)

			float _GlobalMipBias;
			float4 unity_MotionVectorsParams;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _Alpha_Cutout;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[1];
			static float4 fragment_uniform_buffer_3[18];
			static float4 fragment_uniform_buffer_4[6];
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;

			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
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
				nointerpolation uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
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

			void discard_cond(bool fragment_unnamed_258)
			{
				if (fragment_unnamed_258)
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
				discard_cond((_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).w + ((-0.0f) - fragment_uniform_buffer_4[5u].x)) < 0.0f);
				float fragment_unnamed_106 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_107 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_155 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_155 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_106) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_106)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_155 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_107) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_107)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_182 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_190 = fragment_unnamed_182 * fragment_input_7.x;
				float fragment_unnamed_191 = fragment_unnamed_182 * fragment_input_7.y;
				float fragment_unnamed_192 = fragment_unnamed_182 * fragment_input_7.z;
				float fragment_unnamed_201 = 1.0f / max(dot(float3(abs(fragment_unnamed_190), abs(fragment_unnamed_191), abs(fragment_unnamed_192)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_206 = clamp((-0.0f) - (fragment_unnamed_201 * fragment_unnamed_192), 0.0f, 1.0f);
				float fragment_unnamed_209 = (-0.0f) - fragment_unnamed_206;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_190, fragment_unnamed_201, ((fragment_unnamed_201 * fragment_unnamed_190) >= 0.0f) ? fragment_unnamed_206 : fragment_unnamed_209), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_191, fragment_unnamed_201, ((fragment_unnamed_201 * fragment_unnamed_191) >= 0.0f) ? fragment_unnamed_206 : fragment_unnamed_209), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_227 = (fragment_input_8 + asuint(fragment_uniform_buffer_2[0u]).x) * 9u;
				uint fragment_unnamed_237 = 8u & 31u;
				fragment_output_1.y = float(255u & asuint(fragment_uniform_buffer_3[fragment_unnamed_227 + 8u]).x) * 0.0039215688593685626983642578125f;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_3[fragment_unnamed_227 + 8u]).x, fragment_unnamed_237, min((8u & 31u), (32u - fragment_unnamed_237)))) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_3[8][1], fragment_uniform_buffer_3[8][2], fragment_uniform_buffer_3[8][3]);
				fragment_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_3[17][1], fragment_uniform_buffer_3[17][2], fragment_uniform_buffer_3[17][3]);
				fragment_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_uniform_buffer_4[5] = float4(_Alpha_Cutout, fragment_uniform_buffer_4[5][1], fragment_uniform_buffer_4[5][2], fragment_uniform_buffer_4[5][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}

			#endif // defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON)


			#if defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON)

			float4 _ScreenSize;
			float4 unity_MotionVectorsParams;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[1];
			static float4 fragment_uniform_buffer_3[18];
			static float3 fragment_input_0;
			static float3 fragment_input_1;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
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
				nointerpolation uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
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
				float fragment_unnamed_66 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_67 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_117 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_117 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_66) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_66)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_117 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_67) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_67)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_145 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_153 = fragment_unnamed_145 * fragment_input_7.x;
				float fragment_unnamed_154 = fragment_unnamed_145 * fragment_input_7.y;
				float fragment_unnamed_155 = fragment_unnamed_145 * fragment_input_7.z;
				float fragment_unnamed_164 = 1.0f / max(dot(float3(abs(fragment_unnamed_153), abs(fragment_unnamed_154), abs(fragment_unnamed_155)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_169 = clamp((-0.0f) - (fragment_unnamed_164 * fragment_unnamed_155), 0.0f, 1.0f);
				float fragment_unnamed_172 = (-0.0f) - fragment_unnamed_169;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_153, fragment_unnamed_164, ((fragment_unnamed_164 * fragment_unnamed_153) >= 0.0f) ? fragment_unnamed_169 : fragment_unnamed_172), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_154, fragment_unnamed_164, ((fragment_unnamed_164 * fragment_unnamed_154) >= 0.0f) ? fragment_unnamed_169 : fragment_unnamed_172), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_190 = (fragment_input_8 + asuint(fragment_uniform_buffer_2[0u]).x) * 9u;
				uint fragment_unnamed_200 = 8u & 31u;
				fragment_output_1.y = float(255u & asuint(fragment_uniform_buffer_3[fragment_unnamed_190 + 8u]).x) * 0.0039215688593685626983642578125f;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_3[fragment_unnamed_190 + 8u]).x, fragment_unnamed_200, min((8u & 31u), (32u - fragment_unnamed_200)))) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[38] = float4(unity_MotionVectorsParams[0], unity_MotionVectorsParams[1], unity_MotionVectorsParams[2], unity_MotionVectorsParams[3]);

				fragment_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_3[8][1], fragment_uniform_buffer_3[8][2], fragment_uniform_buffer_3[8][3]);
				fragment_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_3[17][1], fragment_uniform_buffer_3[17][2], fragment_uniform_buffer_3[17][3]);
				fragment_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_input_0 = stage_input.fragment_input_0;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				return stage_output;
			}

			#endif // defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Alpha_Cutout;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[6];
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_238)
			{
				if (fragment_unnamed_238)
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
				discard_cond((_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_4.x, fragment_input_4.y), fragment_uniform_buffer_0[86u].y).w + ((-0.0f) - fragment_uniform_buffer_2[5u].x)) < 0.0f);
				float fragment_unnamed_95 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_96 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_144 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_144 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_95) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_95)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_144 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_96) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_96)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_171 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_179 = fragment_unnamed_171 * fragment_input_7.x;
				float fragment_unnamed_180 = fragment_unnamed_171 * fragment_input_7.y;
				float fragment_unnamed_181 = fragment_unnamed_171 * fragment_input_7.z;
				float fragment_unnamed_190 = 1.0f / max(dot(float3(abs(fragment_unnamed_179), abs(fragment_unnamed_180), abs(fragment_unnamed_181)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_195 = clamp((-0.0f) - (fragment_unnamed_190 * fragment_unnamed_181), 0.0f, 1.0f);
				float fragment_unnamed_198 = (-0.0f) - fragment_unnamed_195;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_179, fragment_unnamed_190, ((fragment_unnamed_190 * fragment_unnamed_179) >= 0.0f) ? fragment_unnamed_195 : fragment_unnamed_198), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_180, fragment_unnamed_190, ((fragment_unnamed_190 * fragment_unnamed_180) >= 0.0f) ? fragment_unnamed_195 : fragment_unnamed_198), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_218 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_218, min((8u & 31u), (32u - fragment_unnamed_218)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[5] = float4(_Alpha_Cutout, fragment_uniform_buffer_2[5][1], fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)


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
			GpuProgramID 513639

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_instancing
			#pragma multi_compile _ WRITE_DECAL_BUFFER
			#pragma multi_compile _ _ALPHATEST_ON


			#if !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[14];
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
				if ((((0.0f < vertex_uniform_buffer_2[13u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
				}
				else
				{
					float vertex_unnamed_122 = asfloat(1065353216u);
					float vertex_unnamed_124 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_122));
					float vertex_unnamed_142 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_122));
					float vertex_unnamed_160 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_122));
					float vertex_unnamed_175 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_190 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_205 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_214 = rsqrt(max(dot(float3(vertex_unnamed_175, vertex_unnamed_190, vertex_unnamed_205), float3(vertex_unnamed_175, vertex_unnamed_190, vertex_unnamed_205)), 1.1754943508222875079687365372222e-38f));
					vertex_output_4.x = vertex_unnamed_214 * vertex_unnamed_175;
					vertex_output_4.y = vertex_unnamed_214 * vertex_unnamed_190;
					vertex_output_4.z = vertex_unnamed_214 * vertex_unnamed_205;
					float vertex_unnamed_248 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_249 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_250 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_255 = rsqrt(max(dot(float3(vertex_unnamed_248, vertex_unnamed_249, vertex_unnamed_250), float3(vertex_unnamed_248, vertex_unnamed_249, vertex_unnamed_250)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_248 * vertex_unnamed_255;
					vertex_output_1.y = vertex_unnamed_249 * vertex_unnamed_255;
					vertex_output_1.z = vertex_unnamed_250 * vertex_unnamed_255;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_124, vertex_unnamed_142 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_124, vertex_unnamed_142 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_124, vertex_unnamed_142 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_124, vertex_unnamed_142 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
					vertex_output_1.w = vertex_input_2.w;
					vertex_output_2.x = vertex_input_3.x;
					vertex_output_2.y = vertex_input_3.y;
					vertex_output_2.z = vertex_input_3.z;
					vertex_output_2.w = vertex_input_3.w;
					vertex_output_3.x = vertex_input_4.x;
					vertex_output_3.y = vertex_input_4.y;
					vertex_output_3.z = vertex_input_4.z;
					vertex_output_3.w = vertex_input_4.w;
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

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _RayTracing, vertex_uniform_buffer_2[13][3]);

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


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
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

			#endif // !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[14];
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
				if ((((0.0f < vertex_uniform_buffer_2[13u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
				}
				else
				{
					float vertex_unnamed_122 = asfloat(1065353216u);
					float vertex_unnamed_124 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_122));
					float vertex_unnamed_142 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_122));
					float vertex_unnamed_160 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_122));
					float vertex_unnamed_175 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_190 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_205 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_214 = rsqrt(max(dot(float3(vertex_unnamed_175, vertex_unnamed_190, vertex_unnamed_205), float3(vertex_unnamed_175, vertex_unnamed_190, vertex_unnamed_205)), 1.1754943508222875079687365372222e-38f));
					vertex_output_4.x = vertex_unnamed_214 * vertex_unnamed_175;
					vertex_output_4.y = vertex_unnamed_214 * vertex_unnamed_190;
					vertex_output_4.z = vertex_unnamed_214 * vertex_unnamed_205;
					float vertex_unnamed_248 = mad(vertex_uniform_buffer_1[2u].x, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_249 = mad(vertex_uniform_buffer_1[2u].y, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_250 = mad(vertex_uniform_buffer_1[2u].z, vertex_input_2.z, mad(vertex_uniform_buffer_1[0u].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_255 = rsqrt(max(dot(float3(vertex_unnamed_248, vertex_unnamed_249, vertex_unnamed_250), float3(vertex_unnamed_248, vertex_unnamed_249, vertex_unnamed_250)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_248 * vertex_unnamed_255;
					vertex_output_1.y = vertex_unnamed_249 * vertex_unnamed_255;
					vertex_output_1.z = vertex_unnamed_250 * vertex_unnamed_255;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_124, vertex_unnamed_142 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_124, vertex_unnamed_142 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_124, vertex_unnamed_142 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_160, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_124, vertex_unnamed_142 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
					vertex_output_1.w = vertex_input_2.w;
					vertex_output_2.x = vertex_input_3.x;
					vertex_output_2.y = vertex_input_3.y;
					vertex_output_2.z = vertex_input_3.z;
					vertex_output_2.w = vertex_input_3.w;
					vertex_output_3.x = vertex_input_4.x;
					vertex_output_3.y = vertex_input_4.y;
					vertex_output_3.z = vertex_input_4.z;
					vertex_output_3.w = vertex_input_4.w;
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

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _RayTracing, vertex_uniform_buffer_2[13][3]);

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


			float _GlobalMipBias;
			float _Alpha_Cutout;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[6];
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_67)
			{
				if (fragment_unnamed_67)
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
				discard_cond((_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).w + ((-0.0f) - fragment_uniform_buffer_1[5u].x)) < 0.0f);
				discard_exit();
			}

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				frag_main();
			}

			#endif // defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
			static float4 vertex_uniform_buffer_3[14];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float3 vertex_output_4;
			static uint vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // COLOR
				uint gl_InstanceIndex : SV_InstanceID;
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				uint vertex_output_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_368;
				float vertex_unnamed_369;
				uint vertex_unnamed_370;
				uint vertex_unnamed_371;
				if ((((0.0f < vertex_uniform_buffer_3[13u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					vertex_unnamed_368 = 0u;
					vertex_unnamed_369 = asfloat(0u);
					vertex_unnamed_370 = 0u;
					vertex_unnamed_371 = 0u;
				}
				else
				{
					uint vertex_unnamed_97 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
					uint vertex_unnamed_109 = vertex_unnamed_97 + 3u;
					float vertex_unnamed_142 = asfloat(1065353216u);
					float vertex_unnamed_144 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_109].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_142));
					float vertex_unnamed_164 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_109].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_142));
					float vertex_unnamed_184 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_109].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_142));
					float vertex_unnamed_200 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_97 + 4u].xyz));
					float vertex_unnamed_216 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_97 + 5u].xyz));
					float vertex_unnamed_232 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_97 + 6u].xyz));
					float vertex_unnamed_241 = rsqrt(max(dot(float3(vertex_unnamed_200, vertex_unnamed_216, vertex_unnamed_232), float3(vertex_unnamed_200, vertex_unnamed_216, vertex_unnamed_232)), 1.1754943508222875079687365372222e-38f));
					uint vertex_unnamed_249 = vertex_unnamed_97 + 1u;
					uint vertex_unnamed_268 = vertex_unnamed_97 + 2u;
					float vertex_unnamed_276 = mad(vertex_uniform_buffer_2[vertex_unnamed_268].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_97].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_249].x));
					float vertex_unnamed_277 = mad(vertex_uniform_buffer_2[vertex_unnamed_268].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_97].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_249].y));
					float vertex_unnamed_278 = mad(vertex_uniform_buffer_2[vertex_unnamed_268].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_97].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_249].z));
					float vertex_unnamed_283 = rsqrt(max(dot(float3(vertex_unnamed_276, vertex_unnamed_277, vertex_unnamed_278), float3(vertex_unnamed_276, vertex_unnamed_277, vertex_unnamed_278)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_283 * vertex_unnamed_276;
					vertex_output_1.y = vertex_unnamed_283 * vertex_unnamed_277;
					vertex_output_1.z = vertex_unnamed_283 * vertex_unnamed_278;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_144, vertex_unnamed_164 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_144, vertex_unnamed_164 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_144, vertex_unnamed_164 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_144, vertex_unnamed_164 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
					vertex_output_1.w = vertex_input_2.w;
					vertex_output_2.x = vertex_input_3.x;
					vertex_output_2.y = vertex_input_3.y;
					vertex_output_2.z = vertex_input_3.z;
					vertex_output_2.w = vertex_input_3.w;
					vertex_output_3.x = vertex_input_4.x;
					vertex_output_3.y = vertex_input_4.y;
					vertex_output_3.z = vertex_input_4.z;
					vertex_output_3.w = vertex_input_4.w;
					vertex_unnamed_368 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
					vertex_unnamed_369 = vertex_unnamed_241 * vertex_unnamed_232;
					vertex_unnamed_370 = asuint(vertex_unnamed_241 * vertex_unnamed_216);
					vertex_unnamed_371 = asuint(vertex_unnamed_241 * vertex_unnamed_200);
				}
				vertex_output_4.x = asfloat(vertex_unnamed_371);
				vertex_output_4.y = asfloat(vertex_unnamed_370);
				vertex_output_4.z = vertex_unnamed_369;
				vertex_output_5 = vertex_unnamed_368;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_3[13] = float4(vertex_uniform_buffer_3[13][0], vertex_uniform_buffer_3[13][1], _RayTracing, vertex_uniform_buffer_3[13][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
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


			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static uint fragment_input_5;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				uint fragment_input_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
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

			#endif // defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
			static float4 vertex_uniform_buffer_3[14];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float4 vertex_output_3;
			static float3 vertex_output_4;
			static uint vertex_output_5;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // COLOR
				uint gl_InstanceIndex : SV_InstanceID;
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
			};

			struct Vertex_Stage_Output
			{
				float4 vertex_output_1 : INTERP; // INTERP
				float4 vertex_output_2 : INTERP1; // INTERP_1
				float4 vertex_output_3 : INTERP2; // INTERP_2
				float3 vertex_output_4 : INTERP3; // INTERP_3
				uint vertex_output_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_368;
				float vertex_unnamed_369;
				uint vertex_unnamed_370;
				uint vertex_unnamed_371;
				if ((((0.0f < vertex_uniform_buffer_3[13u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					vertex_unnamed_368 = 0u;
					vertex_unnamed_369 = asfloat(0u);
					vertex_unnamed_370 = 0u;
					vertex_unnamed_371 = 0u;
				}
				else
				{
					uint vertex_unnamed_97 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
					uint vertex_unnamed_109 = vertex_unnamed_97 + 3u;
					float vertex_unnamed_142 = asfloat(1065353216u);
					float vertex_unnamed_144 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_109].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_142));
					float vertex_unnamed_164 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_109].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_142));
					float vertex_unnamed_184 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_97 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_109].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_142));
					float vertex_unnamed_200 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_97 + 4u].xyz));
					float vertex_unnamed_216 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_97 + 5u].xyz));
					float vertex_unnamed_232 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_97 + 6u].xyz));
					float vertex_unnamed_241 = rsqrt(max(dot(float3(vertex_unnamed_200, vertex_unnamed_216, vertex_unnamed_232), float3(vertex_unnamed_200, vertex_unnamed_216, vertex_unnamed_232)), 1.1754943508222875079687365372222e-38f));
					uint vertex_unnamed_249 = vertex_unnamed_97 + 1u;
					uint vertex_unnamed_268 = vertex_unnamed_97 + 2u;
					float vertex_unnamed_276 = mad(vertex_uniform_buffer_2[vertex_unnamed_268].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_97].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_249].x));
					float vertex_unnamed_277 = mad(vertex_uniform_buffer_2[vertex_unnamed_268].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_97].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_249].y));
					float vertex_unnamed_278 = mad(vertex_uniform_buffer_2[vertex_unnamed_268].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_97].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_249].z));
					float vertex_unnamed_283 = rsqrt(max(dot(float3(vertex_unnamed_276, vertex_unnamed_277, vertex_unnamed_278), float3(vertex_unnamed_276, vertex_unnamed_277, vertex_unnamed_278)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_283 * vertex_unnamed_276;
					vertex_output_1.y = vertex_unnamed_283 * vertex_unnamed_277;
					vertex_output_1.z = vertex_unnamed_283 * vertex_unnamed_278;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_144, vertex_unnamed_164 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_144, vertex_unnamed_164 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_144, vertex_unnamed_164 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_184, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_144, vertex_unnamed_164 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
					vertex_output_1.w = vertex_input_2.w;
					vertex_output_2.x = vertex_input_3.x;
					vertex_output_2.y = vertex_input_3.y;
					vertex_output_2.z = vertex_input_3.z;
					vertex_output_2.w = vertex_input_3.w;
					vertex_output_3.x = vertex_input_4.x;
					vertex_output_3.y = vertex_input_4.y;
					vertex_output_3.z = vertex_input_4.z;
					vertex_output_3.w = vertex_input_4.w;
					vertex_unnamed_368 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
					vertex_unnamed_369 = vertex_unnamed_241 * vertex_unnamed_232;
					vertex_unnamed_370 = asuint(vertex_unnamed_241 * vertex_unnamed_216);
					vertex_unnamed_371 = asuint(vertex_unnamed_241 * vertex_unnamed_200);
				}
				vertex_output_4.x = asfloat(vertex_unnamed_371);
				vertex_output_4.y = asfloat(vertex_unnamed_370);
				vertex_output_4.z = vertex_unnamed_369;
				vertex_output_5 = vertex_unnamed_368;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_3[13] = float4(vertex_uniform_buffer_3[13][0], vertex_uniform_buffer_3[13][1], _RayTracing, vertex_uniform_buffer_3[13][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
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


			float _GlobalMipBias;
			float _Alpha_Cutout;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[6];
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static uint fragment_input_5;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				uint fragment_input_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
			};

			static bool discard_state;

			void discard_cond(bool fragment_unnamed_69)
			{
				if (fragment_unnamed_69)
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
				discard_cond((_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).w + ((-0.0f) - fragment_uniform_buffer_1[5u].x)) < 0.0f);
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

			#endif // defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(WRITE_DECAL_BUFFER)


			#if defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON)

			float _GlobalMipBias;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _Alpha_Cutout;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[1];
			static float4 fragment_uniform_buffer_2[18];
			static float4 fragment_uniform_buffer_3[6];
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;

			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static uint fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				nointerpolation uint fragment_input_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
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

			void discard_cond(bool fragment_unnamed_177)
			{
				if (fragment_unnamed_177)
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
				discard_cond((_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).w + ((-0.0f) - fragment_uniform_buffer_3[5u].x)) < 0.0f);
				float fragment_unnamed_98 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_106 = fragment_unnamed_98 * fragment_input_4.x;
				float fragment_unnamed_107 = fragment_unnamed_98 * fragment_input_4.y;
				float fragment_unnamed_108 = fragment_unnamed_98 * fragment_input_4.z;
				float fragment_unnamed_117 = 1.0f / max(dot(float3(abs(fragment_unnamed_106), abs(fragment_unnamed_107), abs(fragment_unnamed_108)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_122 = clamp((-0.0f) - (fragment_unnamed_117 * fragment_unnamed_108), 0.0f, 1.0f);
				float fragment_unnamed_125 = (-0.0f) - fragment_unnamed_122;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_106, fragment_unnamed_117, ((fragment_unnamed_117 * fragment_unnamed_106) >= 0.0f) ? fragment_unnamed_122 : fragment_unnamed_125), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_107, fragment_unnamed_117, ((fragment_unnamed_117 * fragment_unnamed_107) >= 0.0f) ? fragment_unnamed_122 : fragment_unnamed_125), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_146 = (fragment_input_5 + asuint(fragment_uniform_buffer_1[0u]).x) * 9u;
				uint fragment_unnamed_156 = 8u & 31u;
				fragment_output_0.y = float(255u & asuint(fragment_uniform_buffer_2[fragment_unnamed_146 + 8u]).x) * 0.0039215688593685626983642578125f;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_2[fragment_unnamed_146 + 8u]).x, fragment_unnamed_156, min((8u & 31u), (32u - fragment_unnamed_156)))) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_1[0][1], fragment_uniform_buffer_1[0][2], fragment_uniform_buffer_1[0][3]);

				fragment_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_2[8][1], fragment_uniform_buffer_2[8][2], fragment_uniform_buffer_2[8][3]);
				fragment_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_2[17][1], fragment_uniform_buffer_2[17][2], fragment_uniform_buffer_2[17][3]);
				fragment_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_uniform_buffer_3[5] = float4(_Alpha_Cutout, fragment_uniform_buffer_3[5][1], fragment_uniform_buffer_3[5][2], fragment_uniform_buffer_3[5][3]);

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

			#endif // defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON)


			#if defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON)

			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];

			static float4 fragment_uniform_buffer_0[1];
			static float4 fragment_uniform_buffer_1[18];
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float3 fragment_input_4;
			static uint fragment_input_5;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float4 fragment_input_3 : INTERP2; // INTERP_2
				float3 fragment_input_4 : INTERP3; // INTERP_3
				nointerpolation uint fragment_input_5 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
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
				float fragment_unnamed_52 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_60 = fragment_unnamed_52 * fragment_input_4.x;
				float fragment_unnamed_61 = fragment_unnamed_52 * fragment_input_4.y;
				float fragment_unnamed_62 = fragment_unnamed_52 * fragment_input_4.z;
				float fragment_unnamed_71 = 1.0f / max(dot(float3(abs(fragment_unnamed_60), abs(fragment_unnamed_61), abs(fragment_unnamed_62)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_78 = clamp((-0.0f) - (fragment_unnamed_71 * fragment_unnamed_62), 0.0f, 1.0f);
				float fragment_unnamed_82 = (-0.0f) - fragment_unnamed_78;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_60, fragment_unnamed_71, ((fragment_unnamed_71 * fragment_unnamed_60) >= 0.0f) ? fragment_unnamed_78 : fragment_unnamed_82), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_61, fragment_unnamed_71, ((fragment_unnamed_71 * fragment_unnamed_61) >= 0.0f) ? fragment_unnamed_78 : fragment_unnamed_82), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_104 = (fragment_input_5 + asuint(fragment_uniform_buffer_0[0u]).x) * 9u;
				uint fragment_unnamed_114 = 8u & 31u;
				fragment_output_0.y = float(255u & asuint(fragment_uniform_buffer_1[fragment_unnamed_104 + 8u]).x) * 0.0039215688593685626983642578125f;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[fragment_unnamed_104 + 8u]).x, fragment_unnamed_114, min((8u & 31u), (32u - fragment_unnamed_114)))) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_0[0][1], fragment_uniform_buffer_0[0][2], fragment_uniform_buffer_0[0][3]);

				fragment_uniform_buffer_1[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_1[8][1], fragment_uniform_buffer_1[8][2], fragment_uniform_buffer_1[8][3]);
				fragment_uniform_buffer_1[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_1[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_1[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_1[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_1[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_1[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_1[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_1[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_1[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_1[17][1], fragment_uniform_buffer_1[17][2], fragment_uniform_buffer_1[17][3]);
				fragment_uniform_buffer_1[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_1[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_1[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_1[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_1[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_1[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_1[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_1[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

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

			#endif // defined(INSTANCING_ON) && defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON)


			#if defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)

			float4 unity_RenderingLayer;

			static float4 fragment_uniform_buffer_0[11];
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

			#endif // defined(WRITE_DECAL_BUFFER) && !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)


			#if defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)

			float _GlobalMipBias;
			float4 unity_RenderingLayer;
			float _Alpha_Cutout;

			static float4 fragment_uniform_buffer_0[87];
			static float4 fragment_uniform_buffer_1[11];
			static float4 fragment_uniform_buffer_2[6];
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;

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

			void discard_cond(bool fragment_unnamed_162)
			{
				if (fragment_unnamed_162)
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
				discard_cond((_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y).w + ((-0.0f) - fragment_uniform_buffer_2[5u].x)) < 0.0f);
				float fragment_unnamed_92 = 1.0f / max(sqrt(dot(float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z), float3(fragment_input_4.x, fragment_input_4.y, fragment_input_4.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_100 = fragment_unnamed_92 * fragment_input_4.x;
				float fragment_unnamed_101 = fragment_unnamed_92 * fragment_input_4.y;
				float fragment_unnamed_102 = fragment_unnamed_92 * fragment_input_4.z;
				float fragment_unnamed_111 = 1.0f / max(dot(float3(abs(fragment_unnamed_100), abs(fragment_unnamed_101), abs(fragment_unnamed_102)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_116 = clamp((-0.0f) - (fragment_unnamed_111 * fragment_unnamed_102), 0.0f, 1.0f);
				float fragment_unnamed_119 = (-0.0f) - fragment_unnamed_116;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_100, fragment_unnamed_111, ((fragment_unnamed_111 * fragment_unnamed_100) >= 0.0f) ? fragment_unnamed_116 : fragment_unnamed_119), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_101, fragment_unnamed_111, ((fragment_unnamed_111 * fragment_unnamed_101) >= 0.0f) ? fragment_unnamed_116 : fragment_unnamed_119), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_142 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_142, min((8u & 31u), (32u - fragment_unnamed_142)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
				discard_exit();
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[86] = float4(fragment_uniform_buffer_0[86][0], _GlobalMipBias, fragment_uniform_buffer_0[86][2], fragment_uniform_buffer_0[86][3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[5] = float4(_Alpha_Cutout, fragment_uniform_buffer_2[5][1], fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(WRITE_DECAL_BUFFER) && defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)


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
			GpuProgramID 563197

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile _ DECALS_3RT
			#pragma multi_compile_instancing
			#pragma multi_compile _ _ALPHATEST_ON


			#if !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(DECALS_3RT)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[14];
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
				if ((((0.0f < vertex_uniform_buffer_2[13u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _RayTracing, vertex_uniform_buffer_2[13][3]);

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

			#endif // !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(DECALS_3RT)


			#if defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(DECALS_3RT)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[14];
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
				if ((((0.0f < vertex_uniform_buffer_2[13u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _RayTracing, vertex_uniform_buffer_2[13][3]);

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

			#endif // defined(_ALPHATEST_ON) && !defined(INSTANCING_ON) && !defined(DECALS_3RT)


			#if defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(DECALS_3RT)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
			static float4 vertex_uniform_buffer_3[14];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
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
			static uint vertex_output_8;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD1; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD2; // COLOR
				uint gl_InstanceIndex : SV_InstanceID;
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
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
				uint vertex_output_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_411;
				float vertex_unnamed_412;
				uint vertex_unnamed_413;
				uint vertex_unnamed_414;
				if ((((0.0f < vertex_uniform_buffer_3[13u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					vertex_unnamed_411 = 0u;
					vertex_unnamed_412 = asfloat(0u);
					vertex_unnamed_413 = 0u;
					vertex_unnamed_414 = 0u;
				}
				else
				{
					uint vertex_unnamed_113 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
					uint vertex_unnamed_125 = vertex_unnamed_113 + 3u;
					float vertex_unnamed_158 = asfloat(1065353216u);
					float vertex_unnamed_160 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_125].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_180 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_125].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_200 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_125].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_216 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 4u].xyz));
					float vertex_unnamed_232 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 5u].xyz));
					float vertex_unnamed_248 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 6u].xyz));
					float vertex_unnamed_257 = rsqrt(max(dot(float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248), float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248)), 1.1754943508222875079687365372222e-38f));
					uint vertex_unnamed_265 = vertex_unnamed_113 + 1u;
					uint vertex_unnamed_284 = vertex_unnamed_113 + 2u;
					float vertex_unnamed_292 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].x));
					float vertex_unnamed_293 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].y));
					float vertex_unnamed_294 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].z));
					float vertex_unnamed_299 = rsqrt(max(dot(float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294), float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_299 * vertex_unnamed_292;
					vertex_output_1.y = vertex_unnamed_299 * vertex_unnamed_293;
					vertex_output_1.z = vertex_unnamed_299 * vertex_unnamed_294;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_160;
					vertex_output_6.y = vertex_unnamed_180;
					vertex_output_6.z = vertex_unnamed_200;
					vertex_unnamed_411 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
					vertex_unnamed_412 = vertex_unnamed_257 * vertex_unnamed_248;
					vertex_unnamed_413 = asuint(vertex_unnamed_257 * vertex_unnamed_232);
					vertex_unnamed_414 = asuint(vertex_unnamed_257 * vertex_unnamed_216);
				}
				vertex_output_7.x = asfloat(vertex_unnamed_414);
				vertex_output_7.y = asfloat(vertex_unnamed_413);
				vertex_output_7.z = vertex_unnamed_412;
				vertex_output_8 = vertex_unnamed_411;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_3[13] = float4(vertex_uniform_buffer_3[13][0], vertex_uniform_buffer_3[13][1], _RayTracing, vertex_uniform_buffer_3[13][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
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
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			#endif // defined(INSTANCING_ON) && !defined(_ALPHATEST_ON) && !defined(DECALS_3RT)


			#if defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(DECALS_3RT)

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			int _EnableRecursiveRayTracing;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[1];
			static float4 vertex_uniform_buffer_2[18];
			static float4 vertex_uniform_buffer_3[14];
			static float4 gl_Position;
			static int gl_InstanceIndex;
			static int gl_BaseInstanceARB;
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
			static uint vertex_output_8;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : COLOR; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD0; // TEXCOORD_1
				float4 vertex_input_5 : TEXCOORD1; // TEXCOORD_2
				float4 vertex_input_6 : TEXCOORD2; // COLOR
				uint gl_InstanceIndex : SV_InstanceID;
				uint gl_BaseInstanceARB : SV_StartInstanceLocation;
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
				uint vertex_output_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				uint vertex_unnamed_411;
				float vertex_unnamed_412;
				uint vertex_unnamed_413;
				uint vertex_unnamed_414;
				if ((((0.0f < vertex_uniform_buffer_3[13u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					vertex_unnamed_411 = 0u;
					vertex_unnamed_412 = asfloat(0u);
					vertex_unnamed_413 = 0u;
					vertex_unnamed_414 = 0u;
				}
				else
				{
					uint vertex_unnamed_113 = ((uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB)) + asuint(vertex_uniform_buffer_1[0u]).x) * 9u;
					uint vertex_unnamed_125 = vertex_unnamed_113 + 3u;
					float vertex_unnamed_158 = asfloat(1065353216u);
					float vertex_unnamed_160 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).x), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_2[vertex_unnamed_125].x), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_180 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).y), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_2[vertex_unnamed_125].y), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_200 = dot(float4(asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 1u]).z), asfloat(asuint(vertex_uniform_buffer_2[vertex_unnamed_113 + 2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_2[vertex_unnamed_125].z), float4(vertex_input_0.x, vertex_input_0.y, vertex_input_0.z, vertex_unnamed_158));
					float vertex_unnamed_216 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 4u].xyz));
					float vertex_unnamed_232 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 5u].xyz));
					float vertex_unnamed_248 = dot(float3(vertex_input_1.x, vertex_input_1.y, vertex_input_1.z), float3(vertex_uniform_buffer_2[vertex_unnamed_113 + 6u].xyz));
					float vertex_unnamed_257 = rsqrt(max(dot(float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248), float3(vertex_unnamed_216, vertex_unnamed_232, vertex_unnamed_248)), 1.1754943508222875079687365372222e-38f));
					uint vertex_unnamed_265 = vertex_unnamed_113 + 1u;
					uint vertex_unnamed_284 = vertex_unnamed_113 + 2u;
					float vertex_unnamed_292 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].x, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].x, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].x));
					float vertex_unnamed_293 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].y, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].y, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].y));
					float vertex_unnamed_294 = mad(vertex_uniform_buffer_2[vertex_unnamed_284].z, vertex_input_2.z, mad(vertex_uniform_buffer_2[vertex_unnamed_113].z, vertex_input_2.x, vertex_input_2.y * vertex_uniform_buffer_2[vertex_unnamed_265].z));
					float vertex_unnamed_299 = rsqrt(max(dot(float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294), float3(vertex_unnamed_292, vertex_unnamed_293, vertex_unnamed_294)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_299 * vertex_unnamed_292;
					vertex_output_1.y = vertex_unnamed_299 * vertex_unnamed_293;
					vertex_output_1.z = vertex_unnamed_299 * vertex_unnamed_294;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_200, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_160, vertex_unnamed_180 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_6.x = vertex_unnamed_160;
					vertex_output_6.y = vertex_unnamed_180;
					vertex_output_6.z = vertex_unnamed_200;
					vertex_unnamed_411 = uint(gl_InstanceIndex) - uint(gl_BaseInstanceARB);
					vertex_unnamed_412 = vertex_unnamed_257 * vertex_unnamed_248;
					vertex_unnamed_413 = asuint(vertex_unnamed_257 * vertex_unnamed_232);
					vertex_unnamed_414 = asuint(vertex_unnamed_257 * vertex_unnamed_216);
				}
				vertex_output_7.x = asfloat(vertex_unnamed_414);
				vertex_output_7.y = asfloat(vertex_unnamed_413);
				vertex_output_7.z = vertex_unnamed_412;
				vertex_output_8 = vertex_unnamed_411;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(asfloat(unity_BaseInstanceID), vertex_uniform_buffer_1[0][1], vertex_uniform_buffer_1[0][2], vertex_uniform_buffer_1[0][3]);

				vertex_uniform_buffer_2[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, vertex_uniform_buffer_2[8][1], vertex_uniform_buffer_2[8][2], vertex_uniform_buffer_2[8][3]);
				vertex_uniform_buffer_2[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				vertex_uniform_buffer_2[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, vertex_uniform_buffer_2[17][1], vertex_uniform_buffer_2[17][2], vertex_uniform_buffer_2[17][3]);
				vertex_uniform_buffer_2[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				vertex_uniform_buffer_2[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				vertex_uniform_buffer_2[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				vertex_uniform_buffer_2[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				vertex_uniform_buffer_2[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				vertex_uniform_buffer_2[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				vertex_uniform_buffer_2[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				vertex_uniform_buffer_2[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				vertex_uniform_buffer_3[13] = float4(vertex_uniform_buffer_3[13][0], vertex_uniform_buffer_3[13][1], _RayTracing, vertex_uniform_buffer_3[13][3]);

				gl_InstanceIndex = int(stage_input.gl_InstanceIndex + stage_input.gl_BaseInstanceARB);
				gl_BaseInstanceARB = stage_input.gl_BaseInstanceARB;
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
				stage_output.vertex_output_8 = vertex_output_8;
				return stage_output;
			}

			#endif // defined(INSTANCING_ON) && defined(_ALPHATEST_ON) && !defined(DECALS_3RT)


			#if defined(DECALS_3RT) && defined(INSTANCING_ON) && defined(_ALPHATEST_ON)

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
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float4 unity_ProbeVolumeSizeInv;
			float4 unity_ProbeVolumeMin;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { float4 unity_SHArArray; float4 unity_SHAgArray; float4 unity_SHAbArray; float4 unity_SHBrArray; float4 unity_SHBgArray; float4 unity_SHBbArray; float4 unity_SHCArray; } unity_Builtins2Array[2];
			float4 _Canister_color;
			float _Roughness_contrast;
			float _Extra_Normal_Intensity;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[1];
			static float4 fragment_uniform_buffer_3[18];
			static float4 fragment_uniform_buffer_4[14];
			static float4 fragment_uniform_buffer_5[6];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
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
				nointerpolation uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
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
				uint fragment_unnamed_104 = fragment_input_8 + asuint(fragment_uniform_buffer_2[0u]).x;
				float fragment_unnamed_126 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_145 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_208 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_233 = asfloat(fragment_unnamed_208 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_240 = asfloat(fragment_unnamed_208 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_247 = asfloat(fragment_unnamed_208 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_251 = rsqrt(dot(float3(fragment_unnamed_233, fragment_unnamed_240, fragment_unnamed_247), float3(fragment_unnamed_233, fragment_unnamed_240, fragment_unnamed_247)));
				float4 fragment_unnamed_265 = _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_268 = fragment_unnamed_265.x;
				float fragment_unnamed_269 = fragment_unnamed_265.y;
				float fragment_unnamed_270 = fragment_unnamed_265.z;
				float4 fragment_unnamed_279 = _SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_281 = fragment_unnamed_279.x;
				float fragment_unnamed_282 = fragment_unnamed_279.y;
				float fragment_unnamed_283 = fragment_unnamed_279.w;
				float fragment_unnamed_286 = fragment_unnamed_281 * fragment_input_5.x;
				float fragment_unnamed_299 = mad(fragment_unnamed_286, mad(fragment_unnamed_268, fragment_uniform_buffer_5[4u].x, (-0.0f) - fragment_unnamed_268), fragment_unnamed_268);
				float fragment_unnamed_300 = mad(fragment_unnamed_286, mad(fragment_unnamed_269, fragment_uniform_buffer_5[4u].y, (-0.0f) - fragment_unnamed_269), fragment_unnamed_269);
				float fragment_unnamed_301 = mad(fragment_unnamed_286, mad(fragment_unnamed_270, fragment_uniform_buffer_5[4u].z, (-0.0f) - fragment_unnamed_270), fragment_unnamed_270);
				float fragment_unnamed_315 = mad((-0.0f) - fragment_unnamed_281, fragment_input_5.x, 1.0f);
				float fragment_unnamed_319 = mad(abs(fragment_unnamed_315), mad(fragment_unnamed_283, clamp(mad(mad(fragment_unnamed_283, 0.89999997615814208984375f, -0.21763764321804046630859375f), fragment_uniform_buffer_5[5u].y, 0.21763764321804046630859375f), 0.0f, 1.0f), (-0.0f) - fragment_unnamed_283), fragment_unnamed_283);
				float4 fragment_unnamed_331 = _SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D, float2(fragment_input_2.x * 5.0f, fragment_input_2.y * 5.0f), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_337 = mad(fragment_unnamed_331.x * fragment_unnamed_331.w, 2.0f, -1.0f);
				float fragment_unnamed_340 = mad(fragment_unnamed_331.y, 2.0f, -1.0f);
				float fragment_unnamed_353 = fragment_unnamed_286 * fragment_uniform_buffer_5[5u].z;
				float4 fragment_unnamed_367 = _SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_373 = mad(fragment_unnamed_367.x * fragment_unnamed_367.w, 2.0f, -1.0f);
				float fragment_unnamed_374 = mad(fragment_unnamed_367.y, 2.0f, -1.0f);
				float fragment_unnamed_383 = (fragment_unnamed_353 * fragment_unnamed_337) + 0.0f;
				float fragment_unnamed_384 = (fragment_unnamed_353 * fragment_unnamed_340) + 0.0f;
				float fragment_unnamed_385 = (clamp(fragment_unnamed_353, 0.0f, 1.0f) * (max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_337, fragment_unnamed_340), float2(fragment_unnamed_337, fragment_unnamed_340)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f))) + 2.0f;
				float fragment_unnamed_386 = fragment_unnamed_373 * (-1.0f);
				float fragment_unnamed_387 = fragment_unnamed_374 * (-1.0f);
				float fragment_unnamed_388 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_373, fragment_unnamed_374), float2(fragment_unnamed_373, fragment_unnamed_374)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) * 1.0f;
				float fragment_unnamed_392 = dot(float3(fragment_unnamed_383, fragment_unnamed_384, fragment_unnamed_385), float3(fragment_unnamed_386, fragment_unnamed_387, fragment_unnamed_388));
				float fragment_unnamed_398 = mad(fragment_unnamed_383 / fragment_unnamed_385, fragment_unnamed_392, (-0.0f) - fragment_unnamed_386);
				float fragment_unnamed_399 = mad(fragment_unnamed_384 / fragment_unnamed_385, fragment_unnamed_392, (-0.0f) - fragment_unnamed_387);
				float fragment_unnamed_400 = mad(fragment_unnamed_385 / fragment_unnamed_385, fragment_unnamed_392, (-0.0f) - fragment_unnamed_388);
				float fragment_unnamed_407 = mad(fragment_unnamed_400, fragment_unnamed_126 * fragment_input_7.x, mad(fragment_unnamed_398, fragment_unnamed_126 * fragment_input_1.x, (fragment_unnamed_126 * (fragment_unnamed_145 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_399));
				float fragment_unnamed_408 = mad(fragment_unnamed_400, fragment_unnamed_126 * fragment_input_7.y, mad(fragment_unnamed_398, fragment_unnamed_126 * fragment_input_1.y, (fragment_unnamed_126 * (fragment_unnamed_145 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_399));
				float fragment_unnamed_409 = mad(fragment_unnamed_400, fragment_unnamed_126 * fragment_input_7.z, mad(fragment_unnamed_398, fragment_unnamed_126 * fragment_input_1.z, (fragment_unnamed_126 * (fragment_unnamed_145 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_399));
				float fragment_unnamed_414 = rsqrt(max(dot(float3(fragment_unnamed_407, fragment_unnamed_408, fragment_unnamed_409), float3(fragment_unnamed_407, fragment_unnamed_408, fragment_unnamed_409)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_415 = fragment_unnamed_407 * fragment_unnamed_414;
				float fragment_unnamed_416 = fragment_unnamed_408 * fragment_unnamed_414;
				float fragment_unnamed_417 = fragment_unnamed_409 * fragment_unnamed_414;
				float fragment_unnamed_479;
				float fragment_unnamed_480;
				float fragment_unnamed_481;
				float fragment_unnamed_482;
				float fragment_unnamed_483;
				float fragment_unnamed_484;
				float fragment_unnamed_485;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_428 = uint(gl_FragCoord.x);
					uint fragment_unnamed_429 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_430 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_428, fragment_unnamed_429, 0u), 0u));
					float fragment_unnamed_436 = fragment_unnamed_430.w;
					float4 fragment_unnamed_437 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_428, fragment_unnamed_429, 0u), 0u));
					float fragment_unnamed_442 = fragment_unnamed_437.w;
					float4 fragment_unnamed_443 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_428, fragment_unnamed_429, 0u), 0u));
					bool fragment_unnamed_451 = fragment_unnamed_442 < 1.0f;
					float fragment_unnamed_452 = mad(fragment_unnamed_415, fragment_unnamed_442, mad(fragment_unnamed_437.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_453 = mad(fragment_unnamed_416, fragment_unnamed_442, mad(fragment_unnamed_437.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_454 = mad(fragment_unnamed_417, fragment_unnamed_442, mad(fragment_unnamed_437.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_459 = rsqrt(max(dot(float3(fragment_unnamed_452, fragment_unnamed_453, fragment_unnamed_454), float3(fragment_unnamed_452, fragment_unnamed_453, fragment_unnamed_454)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_479 = asfloat(fragment_unnamed_451 ? asuint(fragment_unnamed_452 * fragment_unnamed_459) : asuint(fragment_unnamed_415));
					fragment_unnamed_480 = asfloat(fragment_unnamed_451 ? asuint(fragment_unnamed_453 * fragment_unnamed_459) : asuint(fragment_unnamed_416));
					fragment_unnamed_481 = asfloat(fragment_unnamed_451 ? asuint(fragment_unnamed_454 * fragment_unnamed_459) : asuint(fragment_unnamed_417));
					fragment_unnamed_482 = mad(fragment_unnamed_299, fragment_unnamed_436, fragment_unnamed_430.x);
					fragment_unnamed_483 = mad(fragment_unnamed_300, fragment_unnamed_436, fragment_unnamed_430.y);
					fragment_unnamed_484 = mad(fragment_unnamed_301, fragment_unnamed_436, fragment_unnamed_430.z);
					fragment_unnamed_485 = mad(fragment_unnamed_319, fragment_unnamed_443.w, fragment_unnamed_443.z);
				}
				else
				{
					fragment_unnamed_479 = fragment_unnamed_415;
					fragment_unnamed_480 = fragment_unnamed_416;
					fragment_unnamed_481 = fragment_unnamed_417;
					fragment_unnamed_482 = fragment_unnamed_299;
					fragment_unnamed_483 = fragment_unnamed_300;
					fragment_unnamed_484 = fragment_unnamed_301;
					fragment_unnamed_485 = fragment_unnamed_319;
				}
				float fragment_unnamed_489 = max(dot(float3(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481), float3(fragment_unnamed_251 * fragment_unnamed_233, fragment_unnamed_251 * fragment_unnamed_240, fragment_unnamed_251 * fragment_unnamed_247)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_492 = ((-0.0f) - fragment_unnamed_485) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_282 + exp2(log2(abs(fragment_unnamed_282 + fragment_unnamed_489)) * exp2(mad(fragment_unnamed_492 * fragment_unnamed_492, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_523 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_524 = fragment_unnamed_523.x;
				float fragment_unnamed_813;
				float fragment_unnamed_815;
				float fragment_unnamed_817;
				if (((((fragment_unnamed_524 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_524 != 0u) ? 4294967295u : 0u)) & ((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u)) == 0u)
				{
					float fragment_unnamed_814;
					float fragment_unnamed_816;
					float fragment_unnamed_818;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						uint fragment_unnamed_548 = fragment_unnamed_104 * 7u;
						float fragment_unnamed_550 = asfloat(1065353216u);
						float fragment_unnamed_580 = fragment_unnamed_480 * fragment_unnamed_479;
						float fragment_unnamed_581 = fragment_unnamed_481 * fragment_unnamed_480;
						float fragment_unnamed_582 = fragment_unnamed_481 * fragment_unnamed_481;
						float fragment_unnamed_583 = fragment_unnamed_479 * fragment_unnamed_481;
						float fragment_unnamed_616 = mad(fragment_unnamed_479, fragment_unnamed_479, (-0.0f) - (fragment_unnamed_480 * fragment_unnamed_480));
						uint fragment_unnamed_617 = fragment_unnamed_548 + 6u;
						fragment_unnamed_814 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548]), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_550)) + mad(fragment_uniform_buffer_4[fragment_unnamed_617].x, fragment_unnamed_616, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548 + 3u]), float4(fragment_unnamed_580, fragment_unnamed_581, fragment_unnamed_582, fragment_unnamed_583)));
						fragment_unnamed_816 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548 + 1u]), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_550)) + mad(fragment_uniform_buffer_4[fragment_unnamed_617].y, fragment_unnamed_616, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548 + 4u]), float4(fragment_unnamed_580, fragment_unnamed_581, fragment_unnamed_582, fragment_unnamed_583)));
						fragment_unnamed_818 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548 + 2u]), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_550)) + mad(fragment_uniform_buffer_4[fragment_unnamed_617].z, fragment_unnamed_616, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548 + 5u]), float4(fragment_unnamed_580, fragment_unnamed_581, fragment_unnamed_582, fragment_unnamed_583)));
					}
					else
					{
						bool fragment_unnamed_632 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_633 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_655 = fragment_unnamed_632 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_656 = fragment_unnamed_632 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_657 = fragment_unnamed_632 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_761 = (asfloat(fragment_unnamed_633 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_657, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_655, fragment_unnamed_656 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_656)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_762 = (asfloat(fragment_unnamed_633 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_657, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_655, fragment_unnamed_656 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_657)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_776 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_633 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_657, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_655, fragment_unnamed_656 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_655)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_803 = asfloat(1065353216u);
						fragment_unnamed_814 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_776, fragment_unnamed_761, fragment_unnamed_762), 0.0f)), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_803));
						fragment_unnamed_816 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_776 + 0.25f, fragment_unnamed_761 + 0.0f, fragment_unnamed_762 + 0.0f), 0.0f)), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_803));
						fragment_unnamed_818 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_776 + 0.5f, fragment_unnamed_761 + 0.0f, fragment_unnamed_762 + 0.0f), 0.0f)), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_803));
					}
					fragment_unnamed_813 = fragment_unnamed_814;
					fragment_unnamed_815 = fragment_unnamed_816;
					fragment_unnamed_817 = fragment_unnamed_818;
				}
				else
				{
					fragment_unnamed_813 = asfloat(0u);
					fragment_unnamed_815 = asfloat(0u);
					fragment_unnamed_817 = asfloat(0u);
				}
				float fragment_unnamed_821 = ((-0.0f) - abs(fragment_unnamed_315)) + 1.0f;
				float fragment_unnamed_822 = fragment_unnamed_821 * fragment_unnamed_482;
				float fragment_unnamed_823 = fragment_unnamed_821 * fragment_unnamed_483;
				float fragment_unnamed_824 = fragment_unnamed_821 * fragment_unnamed_484;
				float fragment_unnamed_829 = abs(fragment_unnamed_315);
				float fragment_unnamed_830 = mad(fragment_unnamed_829, fragment_unnamed_482 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_832 = mad(fragment_unnamed_829, fragment_unnamed_483 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_833 = mad(fragment_unnamed_829, fragment_unnamed_484 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_845 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_489), 0.984375f, 0.0078125f), mad(fragment_unnamed_492, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_855 = clamp((max(fragment_unnamed_833, max(fragment_unnamed_832, fragment_unnamed_830)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_879 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_3[(fragment_unnamed_104 * 9u) + 8u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_884 = max(abs(fragment_unnamed_481), 0.0009765625f);
				float fragment_unnamed_888 = (fragment_unnamed_481 >= 0.0f) ? fragment_unnamed_884 : ((-0.0f) - fragment_unnamed_884);
				float fragment_unnamed_897 = 1.0f / max(dot(float3(abs(fragment_unnamed_479), abs(fragment_unnamed_480), abs(fragment_unnamed_888)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_902 = clamp((-0.0f) - (fragment_unnamed_897 * fragment_unnamed_888), 0.0f, 1.0f);
				float fragment_unnamed_905 = (-0.0f) - fragment_unnamed_902;
				uint fragment_unnamed_917 = uint(clamp(mad(mad(fragment_unnamed_479, fragment_unnamed_897, ((fragment_unnamed_897 * fragment_unnamed_479) >= 0.0f) ? fragment_unnamed_902 : fragment_unnamed_905), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_918 = uint(clamp(mad(mad(fragment_unnamed_480, fragment_unnamed_897, ((fragment_unnamed_897 * fragment_unnamed_480) >= 0.0f) ? fragment_unnamed_902 : fragment_unnamed_905), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_917 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_918 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_918 >> 8u) * 16u) + (fragment_unnamed_917 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_830)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_832)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_833)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_971 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_972 = fragment_unnamed_971 * (fragment_unnamed_282 * (fragment_unnamed_879 * ((fragment_unnamed_845 * mad(fragment_unnamed_855, mad((-0.0f) - fragment_unnamed_482, fragment_unnamed_821, fragment_unnamed_830), fragment_unnamed_822)) * fragment_unnamed_813)));
				float fragment_unnamed_973 = fragment_unnamed_971 * (fragment_unnamed_282 * (fragment_unnamed_879 * ((fragment_unnamed_845 * mad(fragment_unnamed_855, mad((-0.0f) - fragment_unnamed_483, fragment_unnamed_821, fragment_unnamed_832), fragment_unnamed_823)) * fragment_unnamed_815)));
				float fragment_unnamed_974 = fragment_unnamed_971 * (fragment_unnamed_282 * (fragment_unnamed_879 * ((fragment_unnamed_845 * mad(fragment_unnamed_855, mad((-0.0f) - fragment_unnamed_484, fragment_unnamed_821, fragment_unnamed_833), fragment_unnamed_824)) * fragment_unnamed_817)));
				bool fragment_unnamed_987 = (((fragment_unnamed_974 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_973 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_972 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_987 ? asfloat(1157627904u) : fragment_unnamed_972;
				fragment_output_3.y = fragment_unnamed_987 ? fragment_unnamed_282 : fragment_unnamed_973;
				fragment_output_3.z = fragment_unnamed_987 ? asfloat(1149239296u) : fragment_unnamed_974;
				fragment_output_0.x = fragment_unnamed_822;
				fragment_output_0.y = fragment_unnamed_823;
				fragment_output_0.z = fragment_unnamed_824;
				fragment_output_1.w = fragment_unnamed_492;
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

				fragment_uniform_buffer_1[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_1[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_1[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_1[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_1[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_1[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_1[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_3[8][1], fragment_uniform_buffer_3[8][2], fragment_uniform_buffer_3[8][3]);
				fragment_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_3[17][1], fragment_uniform_buffer_3[17][2], fragment_uniform_buffer_3[17][3]);
				fragment_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_uniform_buffer_4[0] = float4(unity_Builtins2Array[0].unity_SHArArray[0], unity_Builtins2Array[0].unity_SHArArray[1], unity_Builtins2Array[0].unity_SHArArray[2], unity_Builtins2Array[0].unity_SHArArray[3]);
				fragment_uniform_buffer_4[1] = float4(unity_Builtins2Array[0].unity_SHAgArray[0], unity_Builtins2Array[0].unity_SHAgArray[1], unity_Builtins2Array[0].unity_SHAgArray[2], unity_Builtins2Array[0].unity_SHAgArray[3]);
				fragment_uniform_buffer_4[2] = float4(unity_Builtins2Array[0].unity_SHAbArray[0], unity_Builtins2Array[0].unity_SHAbArray[1], unity_Builtins2Array[0].unity_SHAbArray[2], unity_Builtins2Array[0].unity_SHAbArray[3]);
				fragment_uniform_buffer_4[3] = float4(unity_Builtins2Array[0].unity_SHBrArray[0], unity_Builtins2Array[0].unity_SHBrArray[1], unity_Builtins2Array[0].unity_SHBrArray[2], unity_Builtins2Array[0].unity_SHBrArray[3]);
				fragment_uniform_buffer_4[4] = float4(unity_Builtins2Array[0].unity_SHBgArray[0], unity_Builtins2Array[0].unity_SHBgArray[1], unity_Builtins2Array[0].unity_SHBgArray[2], unity_Builtins2Array[0].unity_SHBgArray[3]);
				fragment_uniform_buffer_4[5] = float4(unity_Builtins2Array[0].unity_SHBbArray[0], unity_Builtins2Array[0].unity_SHBbArray[1], unity_Builtins2Array[0].unity_SHBbArray[2], unity_Builtins2Array[0].unity_SHBbArray[3]);
				fragment_uniform_buffer_4[6] = float4(unity_Builtins2Array[0].unity_SHCArray[0], unity_Builtins2Array[0].unity_SHCArray[1], unity_Builtins2Array[0].unity_SHCArray[2], unity_Builtins2Array[0].unity_SHCArray[3]);
				fragment_uniform_buffer_4[7] = float4(unity_Builtins2Array[1].unity_SHArArray[0], unity_Builtins2Array[1].unity_SHArArray[1], unity_Builtins2Array[1].unity_SHArArray[2], unity_Builtins2Array[1].unity_SHArArray[3]);
				fragment_uniform_buffer_4[8] = float4(unity_Builtins2Array[1].unity_SHAgArray[0], unity_Builtins2Array[1].unity_SHAgArray[1], unity_Builtins2Array[1].unity_SHAgArray[2], unity_Builtins2Array[1].unity_SHAgArray[3]);
				fragment_uniform_buffer_4[9] = float4(unity_Builtins2Array[1].unity_SHAbArray[0], unity_Builtins2Array[1].unity_SHAbArray[1], unity_Builtins2Array[1].unity_SHAbArray[2], unity_Builtins2Array[1].unity_SHAbArray[3]);
				fragment_uniform_buffer_4[10] = float4(unity_Builtins2Array[1].unity_SHBrArray[0], unity_Builtins2Array[1].unity_SHBrArray[1], unity_Builtins2Array[1].unity_SHBrArray[2], unity_Builtins2Array[1].unity_SHBrArray[3]);
				fragment_uniform_buffer_4[11] = float4(unity_Builtins2Array[1].unity_SHBgArray[0], unity_Builtins2Array[1].unity_SHBgArray[1], unity_Builtins2Array[1].unity_SHBgArray[2], unity_Builtins2Array[1].unity_SHBgArray[3]);
				fragment_uniform_buffer_4[12] = float4(unity_Builtins2Array[1].unity_SHBbArray[0], unity_Builtins2Array[1].unity_SHBbArray[1], unity_Builtins2Array[1].unity_SHBbArray[2], unity_Builtins2Array[1].unity_SHBbArray[3]);
				fragment_uniform_buffer_4[13] = float4(unity_Builtins2Array[1].unity_SHCArray[0], unity_Builtins2Array[1].unity_SHCArray[1], unity_Builtins2Array[1].unity_SHCArray[2], unity_Builtins2Array[1].unity_SHCArray[3]);

				fragment_uniform_buffer_5[4] = float4(_Canister_color[0], _Canister_color[1], _Canister_color[2], _Canister_color[3]);

				fragment_uniform_buffer_5[5] = float4(fragment_uniform_buffer_5[5][0], _Roughness_contrast, fragment_uniform_buffer_5[5][2], fragment_uniform_buffer_5[5][3]);

				fragment_uniform_buffer_5[5] = float4(fragment_uniform_buffer_5[5][0], fragment_uniform_buffer_5[5][1], _Extra_Normal_Intensity, fragment_uniform_buffer_5[5][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(INSTANCING_ON) && defined(_ALPHATEST_ON)


			#if defined(DECALS_3RT) && defined(INSTANCING_ON) && !defined(_ALPHATEST_ON)

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
			float4 unity_ProbeVolumeParams;
			float4x4 unity_ProbeVolumeWorldToObject;
			float4 unity_ProbeVolumeSizeInv;
			float4 unity_ProbeVolumeMin;
			int unity_BaseInstanceID;
			struct { float unity_RenderingLayerArray; float4x4 unity_ObjectToWorldArray; float4x4 unity_WorldToObjectArray; } unity_Builtins0Array[2];
			struct { float4 unity_SHArArray; float4 unity_SHAgArray; float4 unity_SHAbArray; float4 unity_SHBrArray; float4 unity_SHBgArray; float4 unity_SHBbArray; float4 unity_SHCArray; } unity_Builtins2Array[2];
			float4 _Canister_color;
			float _Roughness_contrast;
			float _Extra_Normal_Intensity;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[1];
			static float4 fragment_uniform_buffer_3[18];
			static float4 fragment_uniform_buffer_4[14];
			static float4 fragment_uniform_buffer_5[6];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D;

			static float4 gl_FragCoord;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float4 fragment_input_3;
			static float4 fragment_input_4;
			static float4 fragment_input_5;
			static float3 fragment_input_6;
			static float3 fragment_input_7;
			static uint fragment_input_8;
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
				nointerpolation uint fragment_input_8 : CUSTOM_INSTANCE_ID; // CUSTOM_INSTANCE_ID
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
				uint fragment_unnamed_104 = fragment_input_8 + asuint(fragment_uniform_buffer_2[0u]).x;
				float fragment_unnamed_126 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_145 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_208 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_233 = asfloat(fragment_unnamed_208 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_240 = asfloat(fragment_unnamed_208 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_247 = asfloat(fragment_unnamed_208 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_251 = rsqrt(dot(float3(fragment_unnamed_233, fragment_unnamed_240, fragment_unnamed_247), float3(fragment_unnamed_233, fragment_unnamed_240, fragment_unnamed_247)));
				float4 fragment_unnamed_265 = _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_268 = fragment_unnamed_265.x;
				float fragment_unnamed_269 = fragment_unnamed_265.y;
				float fragment_unnamed_270 = fragment_unnamed_265.z;
				float4 fragment_unnamed_279 = _SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_281 = fragment_unnamed_279.x;
				float fragment_unnamed_282 = fragment_unnamed_279.y;
				float fragment_unnamed_283 = fragment_unnamed_279.w;
				float fragment_unnamed_286 = fragment_unnamed_281 * fragment_input_5.x;
				float fragment_unnamed_299 = mad(fragment_unnamed_286, mad(fragment_unnamed_268, fragment_uniform_buffer_5[4u].x, (-0.0f) - fragment_unnamed_268), fragment_unnamed_268);
				float fragment_unnamed_300 = mad(fragment_unnamed_286, mad(fragment_unnamed_269, fragment_uniform_buffer_5[4u].y, (-0.0f) - fragment_unnamed_269), fragment_unnamed_269);
				float fragment_unnamed_301 = mad(fragment_unnamed_286, mad(fragment_unnamed_270, fragment_uniform_buffer_5[4u].z, (-0.0f) - fragment_unnamed_270), fragment_unnamed_270);
				float fragment_unnamed_315 = mad((-0.0f) - fragment_unnamed_281, fragment_input_5.x, 1.0f);
				float fragment_unnamed_319 = mad(abs(fragment_unnamed_315), mad(fragment_unnamed_283, clamp(mad(mad(fragment_unnamed_283, 0.89999997615814208984375f, -0.21763764321804046630859375f), fragment_uniform_buffer_5[5u].y, 0.21763764321804046630859375f), 0.0f, 1.0f), (-0.0f) - fragment_unnamed_283), fragment_unnamed_283);
				float4 fragment_unnamed_331 = _SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D, float2(fragment_input_2.x * 5.0f, fragment_input_2.y * 5.0f), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_337 = mad(fragment_unnamed_331.x * fragment_unnamed_331.w, 2.0f, -1.0f);
				float fragment_unnamed_340 = mad(fragment_unnamed_331.y, 2.0f, -1.0f);
				float fragment_unnamed_353 = fragment_unnamed_286 * fragment_uniform_buffer_5[5u].z;
				float4 fragment_unnamed_367 = _SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_373 = mad(fragment_unnamed_367.x * fragment_unnamed_367.w, 2.0f, -1.0f);
				float fragment_unnamed_374 = mad(fragment_unnamed_367.y, 2.0f, -1.0f);
				float fragment_unnamed_383 = (fragment_unnamed_353 * fragment_unnamed_337) + 0.0f;
				float fragment_unnamed_384 = (fragment_unnamed_353 * fragment_unnamed_340) + 0.0f;
				float fragment_unnamed_385 = (clamp(fragment_unnamed_353, 0.0f, 1.0f) * (max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_337, fragment_unnamed_340), float2(fragment_unnamed_337, fragment_unnamed_340)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f))) + 2.0f;
				float fragment_unnamed_386 = fragment_unnamed_373 * (-1.0f);
				float fragment_unnamed_387 = fragment_unnamed_374 * (-1.0f);
				float fragment_unnamed_388 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_373, fragment_unnamed_374), float2(fragment_unnamed_373, fragment_unnamed_374)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) * 1.0f;
				float fragment_unnamed_392 = dot(float3(fragment_unnamed_383, fragment_unnamed_384, fragment_unnamed_385), float3(fragment_unnamed_386, fragment_unnamed_387, fragment_unnamed_388));
				float fragment_unnamed_398 = mad(fragment_unnamed_383 / fragment_unnamed_385, fragment_unnamed_392, (-0.0f) - fragment_unnamed_386);
				float fragment_unnamed_399 = mad(fragment_unnamed_384 / fragment_unnamed_385, fragment_unnamed_392, (-0.0f) - fragment_unnamed_387);
				float fragment_unnamed_400 = mad(fragment_unnamed_385 / fragment_unnamed_385, fragment_unnamed_392, (-0.0f) - fragment_unnamed_388);
				float fragment_unnamed_407 = mad(fragment_unnamed_400, fragment_unnamed_126 * fragment_input_7.x, mad(fragment_unnamed_398, fragment_unnamed_126 * fragment_input_1.x, (fragment_unnamed_126 * (fragment_unnamed_145 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_399));
				float fragment_unnamed_408 = mad(fragment_unnamed_400, fragment_unnamed_126 * fragment_input_7.y, mad(fragment_unnamed_398, fragment_unnamed_126 * fragment_input_1.y, (fragment_unnamed_126 * (fragment_unnamed_145 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_399));
				float fragment_unnamed_409 = mad(fragment_unnamed_400, fragment_unnamed_126 * fragment_input_7.z, mad(fragment_unnamed_398, fragment_unnamed_126 * fragment_input_1.z, (fragment_unnamed_126 * (fragment_unnamed_145 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_399));
				float fragment_unnamed_414 = rsqrt(max(dot(float3(fragment_unnamed_407, fragment_unnamed_408, fragment_unnamed_409), float3(fragment_unnamed_407, fragment_unnamed_408, fragment_unnamed_409)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_415 = fragment_unnamed_407 * fragment_unnamed_414;
				float fragment_unnamed_416 = fragment_unnamed_408 * fragment_unnamed_414;
				float fragment_unnamed_417 = fragment_unnamed_409 * fragment_unnamed_414;
				float fragment_unnamed_479;
				float fragment_unnamed_480;
				float fragment_unnamed_481;
				float fragment_unnamed_482;
				float fragment_unnamed_483;
				float fragment_unnamed_484;
				float fragment_unnamed_485;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_428 = uint(gl_FragCoord.x);
					uint fragment_unnamed_429 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_430 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_428, fragment_unnamed_429, 0u), 0u));
					float fragment_unnamed_436 = fragment_unnamed_430.w;
					float4 fragment_unnamed_437 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_428, fragment_unnamed_429, 0u), 0u));
					float fragment_unnamed_442 = fragment_unnamed_437.w;
					float4 fragment_unnamed_443 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_428, fragment_unnamed_429, 0u), 0u));
					bool fragment_unnamed_451 = fragment_unnamed_442 < 1.0f;
					float fragment_unnamed_452 = mad(fragment_unnamed_415, fragment_unnamed_442, mad(fragment_unnamed_437.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_453 = mad(fragment_unnamed_416, fragment_unnamed_442, mad(fragment_unnamed_437.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_454 = mad(fragment_unnamed_417, fragment_unnamed_442, mad(fragment_unnamed_437.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_459 = rsqrt(max(dot(float3(fragment_unnamed_452, fragment_unnamed_453, fragment_unnamed_454), float3(fragment_unnamed_452, fragment_unnamed_453, fragment_unnamed_454)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_479 = asfloat(fragment_unnamed_451 ? asuint(fragment_unnamed_452 * fragment_unnamed_459) : asuint(fragment_unnamed_415));
					fragment_unnamed_480 = asfloat(fragment_unnamed_451 ? asuint(fragment_unnamed_453 * fragment_unnamed_459) : asuint(fragment_unnamed_416));
					fragment_unnamed_481 = asfloat(fragment_unnamed_451 ? asuint(fragment_unnamed_454 * fragment_unnamed_459) : asuint(fragment_unnamed_417));
					fragment_unnamed_482 = mad(fragment_unnamed_299, fragment_unnamed_436, fragment_unnamed_430.x);
					fragment_unnamed_483 = mad(fragment_unnamed_300, fragment_unnamed_436, fragment_unnamed_430.y);
					fragment_unnamed_484 = mad(fragment_unnamed_301, fragment_unnamed_436, fragment_unnamed_430.z);
					fragment_unnamed_485 = mad(fragment_unnamed_319, fragment_unnamed_443.w, fragment_unnamed_443.z);
				}
				else
				{
					fragment_unnamed_479 = fragment_unnamed_415;
					fragment_unnamed_480 = fragment_unnamed_416;
					fragment_unnamed_481 = fragment_unnamed_417;
					fragment_unnamed_482 = fragment_unnamed_299;
					fragment_unnamed_483 = fragment_unnamed_300;
					fragment_unnamed_484 = fragment_unnamed_301;
					fragment_unnamed_485 = fragment_unnamed_319;
				}
				float fragment_unnamed_489 = max(dot(float3(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481), float3(fragment_unnamed_251 * fragment_unnamed_233, fragment_unnamed_251 * fragment_unnamed_240, fragment_unnamed_251 * fragment_unnamed_247)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_492 = ((-0.0f) - fragment_unnamed_485) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_282 + exp2(log2(abs(fragment_unnamed_282 + fragment_unnamed_489)) * exp2(mad(fragment_unnamed_492 * fragment_unnamed_492, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_523 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_524 = fragment_unnamed_523.x;
				float fragment_unnamed_813;
				float fragment_unnamed_815;
				float fragment_unnamed_817;
				if (((((fragment_unnamed_524 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_524 != 0u) ? 4294967295u : 0u)) & ((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u)) == 0u)
				{
					float fragment_unnamed_814;
					float fragment_unnamed_816;
					float fragment_unnamed_818;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						uint fragment_unnamed_548 = fragment_unnamed_104 * 7u;
						float fragment_unnamed_550 = asfloat(1065353216u);
						float fragment_unnamed_580 = fragment_unnamed_480 * fragment_unnamed_479;
						float fragment_unnamed_581 = fragment_unnamed_481 * fragment_unnamed_480;
						float fragment_unnamed_582 = fragment_unnamed_481 * fragment_unnamed_481;
						float fragment_unnamed_583 = fragment_unnamed_479 * fragment_unnamed_481;
						float fragment_unnamed_616 = mad(fragment_unnamed_479, fragment_unnamed_479, (-0.0f) - (fragment_unnamed_480 * fragment_unnamed_480));
						uint fragment_unnamed_617 = fragment_unnamed_548 + 6u;
						fragment_unnamed_814 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548]), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_550)) + mad(fragment_uniform_buffer_4[fragment_unnamed_617].x, fragment_unnamed_616, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548 + 3u]), float4(fragment_unnamed_580, fragment_unnamed_581, fragment_unnamed_582, fragment_unnamed_583)));
						fragment_unnamed_816 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548 + 1u]), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_550)) + mad(fragment_uniform_buffer_4[fragment_unnamed_617].y, fragment_unnamed_616, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548 + 4u]), float4(fragment_unnamed_580, fragment_unnamed_581, fragment_unnamed_582, fragment_unnamed_583)));
						fragment_unnamed_818 = dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548 + 2u]), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_550)) + mad(fragment_uniform_buffer_4[fragment_unnamed_617].z, fragment_unnamed_616, dot(float4(fragment_uniform_buffer_4[fragment_unnamed_548 + 5u]), float4(fragment_unnamed_580, fragment_unnamed_581, fragment_unnamed_582, fragment_unnamed_583)));
					}
					else
					{
						bool fragment_unnamed_632 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_633 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_655 = fragment_unnamed_632 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_656 = fragment_unnamed_632 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_657 = fragment_unnamed_632 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_761 = (asfloat(fragment_unnamed_633 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_657, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_655, fragment_unnamed_656 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_656)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_762 = (asfloat(fragment_unnamed_633 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_657, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_655, fragment_unnamed_656 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_657)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_776 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_633 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_657, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_655, fragment_unnamed_656 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_655)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_803 = asfloat(1065353216u);
						fragment_unnamed_814 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_776, fragment_unnamed_761, fragment_unnamed_762), 0.0f)), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_803));
						fragment_unnamed_816 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_776 + 0.25f, fragment_unnamed_761 + 0.0f, fragment_unnamed_762 + 0.0f), 0.0f)), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_803));
						fragment_unnamed_818 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_776 + 0.5f, fragment_unnamed_761 + 0.0f, fragment_unnamed_762 + 0.0f), 0.0f)), float4(fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481, fragment_unnamed_803));
					}
					fragment_unnamed_813 = fragment_unnamed_814;
					fragment_unnamed_815 = fragment_unnamed_816;
					fragment_unnamed_817 = fragment_unnamed_818;
				}
				else
				{
					fragment_unnamed_813 = asfloat(0u);
					fragment_unnamed_815 = asfloat(0u);
					fragment_unnamed_817 = asfloat(0u);
				}
				float fragment_unnamed_821 = ((-0.0f) - abs(fragment_unnamed_315)) + 1.0f;
				float fragment_unnamed_822 = fragment_unnamed_821 * fragment_unnamed_482;
				float fragment_unnamed_823 = fragment_unnamed_821 * fragment_unnamed_483;
				float fragment_unnamed_824 = fragment_unnamed_821 * fragment_unnamed_484;
				float fragment_unnamed_829 = abs(fragment_unnamed_315);
				float fragment_unnamed_830 = mad(fragment_unnamed_829, fragment_unnamed_482 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_832 = mad(fragment_unnamed_829, fragment_unnamed_483 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_833 = mad(fragment_unnamed_829, fragment_unnamed_484 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_845 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_489), 0.984375f, 0.0078125f), mad(fragment_unnamed_492, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_855 = clamp((max(fragment_unnamed_833, max(fragment_unnamed_832, fragment_unnamed_830)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_879 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_3[(fragment_unnamed_104 * 9u) + 8u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_884 = max(abs(fragment_unnamed_481), 0.0009765625f);
				float fragment_unnamed_888 = (fragment_unnamed_481 >= 0.0f) ? fragment_unnamed_884 : ((-0.0f) - fragment_unnamed_884);
				float fragment_unnamed_897 = 1.0f / max(dot(float3(abs(fragment_unnamed_479), abs(fragment_unnamed_480), abs(fragment_unnamed_888)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_902 = clamp((-0.0f) - (fragment_unnamed_897 * fragment_unnamed_888), 0.0f, 1.0f);
				float fragment_unnamed_905 = (-0.0f) - fragment_unnamed_902;
				uint fragment_unnamed_917 = uint(clamp(mad(mad(fragment_unnamed_479, fragment_unnamed_897, ((fragment_unnamed_897 * fragment_unnamed_479) >= 0.0f) ? fragment_unnamed_902 : fragment_unnamed_905), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_918 = uint(clamp(mad(mad(fragment_unnamed_480, fragment_unnamed_897, ((fragment_unnamed_897 * fragment_unnamed_480) >= 0.0f) ? fragment_unnamed_902 : fragment_unnamed_905), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_917 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_918 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_918 >> 8u) * 16u) + (fragment_unnamed_917 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_830)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_832)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_833)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_971 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_972 = fragment_unnamed_971 * (fragment_unnamed_282 * (fragment_unnamed_879 * ((fragment_unnamed_845 * mad(fragment_unnamed_855, mad((-0.0f) - fragment_unnamed_482, fragment_unnamed_821, fragment_unnamed_830), fragment_unnamed_822)) * fragment_unnamed_813)));
				float fragment_unnamed_973 = fragment_unnamed_971 * (fragment_unnamed_282 * (fragment_unnamed_879 * ((fragment_unnamed_845 * mad(fragment_unnamed_855, mad((-0.0f) - fragment_unnamed_483, fragment_unnamed_821, fragment_unnamed_832), fragment_unnamed_823)) * fragment_unnamed_815)));
				float fragment_unnamed_974 = fragment_unnamed_971 * (fragment_unnamed_282 * (fragment_unnamed_879 * ((fragment_unnamed_845 * mad(fragment_unnamed_855, mad((-0.0f) - fragment_unnamed_484, fragment_unnamed_821, fragment_unnamed_833), fragment_unnamed_824)) * fragment_unnamed_817)));
				bool fragment_unnamed_987 = (((fragment_unnamed_974 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_973 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_972 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_987 ? asfloat(1157627904u) : fragment_unnamed_972;
				fragment_output_3.y = fragment_unnamed_987 ? fragment_unnamed_282 : fragment_unnamed_973;
				fragment_output_3.z = fragment_unnamed_987 ? asfloat(1149239296u) : fragment_unnamed_974;
				fragment_output_0.x = fragment_unnamed_822;
				fragment_output_0.y = fragment_unnamed_823;
				fragment_output_0.z = fragment_unnamed_824;
				fragment_output_1.w = fragment_unnamed_492;
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

				fragment_uniform_buffer_1[22] = float4(unity_ProbeVolumeParams[0], unity_ProbeVolumeParams[1], unity_ProbeVolumeParams[2], unity_ProbeVolumeParams[3]);

				fragment_uniform_buffer_1[23] = float4(unity_ProbeVolumeWorldToObject[0][0], unity_ProbeVolumeWorldToObject[1][0], unity_ProbeVolumeWorldToObject[2][0], unity_ProbeVolumeWorldToObject[3][0]);
				fragment_uniform_buffer_1[24] = float4(unity_ProbeVolumeWorldToObject[0][1], unity_ProbeVolumeWorldToObject[1][1], unity_ProbeVolumeWorldToObject[2][1], unity_ProbeVolumeWorldToObject[3][1]);
				fragment_uniform_buffer_1[25] = float4(unity_ProbeVolumeWorldToObject[0][2], unity_ProbeVolumeWorldToObject[1][2], unity_ProbeVolumeWorldToObject[2][2], unity_ProbeVolumeWorldToObject[3][2]);
				fragment_uniform_buffer_1[26] = float4(unity_ProbeVolumeWorldToObject[0][3], unity_ProbeVolumeWorldToObject[1][3], unity_ProbeVolumeWorldToObject[2][3], unity_ProbeVolumeWorldToObject[3][3]);

				fragment_uniform_buffer_1[27] = float4(unity_ProbeVolumeSizeInv[0], unity_ProbeVolumeSizeInv[1], unity_ProbeVolumeSizeInv[2], unity_ProbeVolumeSizeInv[3]);

				fragment_uniform_buffer_1[28] = float4(unity_ProbeVolumeMin[0], unity_ProbeVolumeMin[1], unity_ProbeVolumeMin[2], unity_ProbeVolumeMin[3]);

				fragment_uniform_buffer_2[0] = float4(asfloat(unity_BaseInstanceID), fragment_uniform_buffer_2[0][1], fragment_uniform_buffer_2[0][2], fragment_uniform_buffer_2[0][3]);

				fragment_uniform_buffer_3[8] = float4(unity_Builtins0Array[0].unity_RenderingLayerArray, fragment_uniform_buffer_3[8][1], fragment_uniform_buffer_3[8][2], fragment_uniform_buffer_3[8][3]);
				fragment_uniform_buffer_3[0] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[1] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[2] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[3] = float4(unity_Builtins0Array[0].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[0].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[4] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][0], unity_Builtins0Array[0].unity_WorldToObjectArray[1][0], unity_Builtins0Array[0].unity_WorldToObjectArray[2][0], unity_Builtins0Array[0].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[5] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][1], unity_Builtins0Array[0].unity_WorldToObjectArray[1][1], unity_Builtins0Array[0].unity_WorldToObjectArray[2][1], unity_Builtins0Array[0].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[6] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][2], unity_Builtins0Array[0].unity_WorldToObjectArray[1][2], unity_Builtins0Array[0].unity_WorldToObjectArray[2][2], unity_Builtins0Array[0].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[7] = float4(unity_Builtins0Array[0].unity_WorldToObjectArray[0][3], unity_Builtins0Array[0].unity_WorldToObjectArray[1][3], unity_Builtins0Array[0].unity_WorldToObjectArray[2][3], unity_Builtins0Array[0].unity_WorldToObjectArray[3][3]);
				fragment_uniform_buffer_3[17] = float4(unity_Builtins0Array[1].unity_RenderingLayerArray, fragment_uniform_buffer_3[17][1], fragment_uniform_buffer_3[17][2], fragment_uniform_buffer_3[17][3]);
				fragment_uniform_buffer_3[9] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][0], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][0]);
				fragment_uniform_buffer_3[10] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][1], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][1]);
				fragment_uniform_buffer_3[11] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][2], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][2]);
				fragment_uniform_buffer_3[12] = float4(unity_Builtins0Array[1].unity_ObjectToWorldArray[0][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[1][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[2][3], unity_Builtins0Array[1].unity_ObjectToWorldArray[3][3]);
				fragment_uniform_buffer_3[13] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][0], unity_Builtins0Array[1].unity_WorldToObjectArray[1][0], unity_Builtins0Array[1].unity_WorldToObjectArray[2][0], unity_Builtins0Array[1].unity_WorldToObjectArray[3][0]);
				fragment_uniform_buffer_3[14] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][1], unity_Builtins0Array[1].unity_WorldToObjectArray[1][1], unity_Builtins0Array[1].unity_WorldToObjectArray[2][1], unity_Builtins0Array[1].unity_WorldToObjectArray[3][1]);
				fragment_uniform_buffer_3[15] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][2], unity_Builtins0Array[1].unity_WorldToObjectArray[1][2], unity_Builtins0Array[1].unity_WorldToObjectArray[2][2], unity_Builtins0Array[1].unity_WorldToObjectArray[3][2]);
				fragment_uniform_buffer_3[16] = float4(unity_Builtins0Array[1].unity_WorldToObjectArray[0][3], unity_Builtins0Array[1].unity_WorldToObjectArray[1][3], unity_Builtins0Array[1].unity_WorldToObjectArray[2][3], unity_Builtins0Array[1].unity_WorldToObjectArray[3][3]);

				fragment_uniform_buffer_4[0] = float4(unity_Builtins2Array[0].unity_SHArArray[0], unity_Builtins2Array[0].unity_SHArArray[1], unity_Builtins2Array[0].unity_SHArArray[2], unity_Builtins2Array[0].unity_SHArArray[3]);
				fragment_uniform_buffer_4[1] = float4(unity_Builtins2Array[0].unity_SHAgArray[0], unity_Builtins2Array[0].unity_SHAgArray[1], unity_Builtins2Array[0].unity_SHAgArray[2], unity_Builtins2Array[0].unity_SHAgArray[3]);
				fragment_uniform_buffer_4[2] = float4(unity_Builtins2Array[0].unity_SHAbArray[0], unity_Builtins2Array[0].unity_SHAbArray[1], unity_Builtins2Array[0].unity_SHAbArray[2], unity_Builtins2Array[0].unity_SHAbArray[3]);
				fragment_uniform_buffer_4[3] = float4(unity_Builtins2Array[0].unity_SHBrArray[0], unity_Builtins2Array[0].unity_SHBrArray[1], unity_Builtins2Array[0].unity_SHBrArray[2], unity_Builtins2Array[0].unity_SHBrArray[3]);
				fragment_uniform_buffer_4[4] = float4(unity_Builtins2Array[0].unity_SHBgArray[0], unity_Builtins2Array[0].unity_SHBgArray[1], unity_Builtins2Array[0].unity_SHBgArray[2], unity_Builtins2Array[0].unity_SHBgArray[3]);
				fragment_uniform_buffer_4[5] = float4(unity_Builtins2Array[0].unity_SHBbArray[0], unity_Builtins2Array[0].unity_SHBbArray[1], unity_Builtins2Array[0].unity_SHBbArray[2], unity_Builtins2Array[0].unity_SHBbArray[3]);
				fragment_uniform_buffer_4[6] = float4(unity_Builtins2Array[0].unity_SHCArray[0], unity_Builtins2Array[0].unity_SHCArray[1], unity_Builtins2Array[0].unity_SHCArray[2], unity_Builtins2Array[0].unity_SHCArray[3]);
				fragment_uniform_buffer_4[7] = float4(unity_Builtins2Array[1].unity_SHArArray[0], unity_Builtins2Array[1].unity_SHArArray[1], unity_Builtins2Array[1].unity_SHArArray[2], unity_Builtins2Array[1].unity_SHArArray[3]);
				fragment_uniform_buffer_4[8] = float4(unity_Builtins2Array[1].unity_SHAgArray[0], unity_Builtins2Array[1].unity_SHAgArray[1], unity_Builtins2Array[1].unity_SHAgArray[2], unity_Builtins2Array[1].unity_SHAgArray[3]);
				fragment_uniform_buffer_4[9] = float4(unity_Builtins2Array[1].unity_SHAbArray[0], unity_Builtins2Array[1].unity_SHAbArray[1], unity_Builtins2Array[1].unity_SHAbArray[2], unity_Builtins2Array[1].unity_SHAbArray[3]);
				fragment_uniform_buffer_4[10] = float4(unity_Builtins2Array[1].unity_SHBrArray[0], unity_Builtins2Array[1].unity_SHBrArray[1], unity_Builtins2Array[1].unity_SHBrArray[2], unity_Builtins2Array[1].unity_SHBrArray[3]);
				fragment_uniform_buffer_4[11] = float4(unity_Builtins2Array[1].unity_SHBgArray[0], unity_Builtins2Array[1].unity_SHBgArray[1], unity_Builtins2Array[1].unity_SHBgArray[2], unity_Builtins2Array[1].unity_SHBgArray[3]);
				fragment_uniform_buffer_4[12] = float4(unity_Builtins2Array[1].unity_SHBbArray[0], unity_Builtins2Array[1].unity_SHBbArray[1], unity_Builtins2Array[1].unity_SHBbArray[2], unity_Builtins2Array[1].unity_SHBbArray[3]);
				fragment_uniform_buffer_4[13] = float4(unity_Builtins2Array[1].unity_SHCArray[0], unity_Builtins2Array[1].unity_SHCArray[1], unity_Builtins2Array[1].unity_SHCArray[2], unity_Builtins2Array[1].unity_SHCArray[3]);

				fragment_uniform_buffer_5[4] = float4(_Canister_color[0], _Canister_color[1], _Canister_color[2], _Canister_color[3]);

				fragment_uniform_buffer_5[5] = float4(fragment_uniform_buffer_5[5][0], _Roughness_contrast, fragment_uniform_buffer_5[5][2], fragment_uniform_buffer_5[5][3]);

				fragment_uniform_buffer_5[5] = float4(fragment_uniform_buffer_5[5][0], fragment_uniform_buffer_5[5][1], _Extra_Normal_Intensity, fragment_uniform_buffer_5[5][3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				fragment_input_4 = stage_input.fragment_input_4;
				fragment_input_5 = stage_input.fragment_input_5;
				fragment_input_6 = stage_input.fragment_input_6;
				fragment_input_7 = stage_input.fragment_input_7;
				fragment_input_8 = stage_input.fragment_input_8;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				stage_output.fragment_output_1 = fragment_output_1;
				stage_output.fragment_output_2 = fragment_output_2;
				stage_output.fragment_output_3 = fragment_output_3;
				return stage_output;
			}

			#endif // defined(DECALS_3RT) && defined(INSTANCING_ON) && !defined(_ALPHATEST_ON)


			#if defined(DECALS_3RT) && defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)

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
			float4 unity_RenderingLayer;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4 _Canister_color;
			float _Roughness_contrast;
			float _Extra_Normal_Intensity;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[6];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D;

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
				float fragment_unnamed_102 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_122 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_185 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_211 = asfloat(fragment_unnamed_185 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_218 = asfloat(fragment_unnamed_185 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_225 = asfloat(fragment_unnamed_185 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_229 = rsqrt(dot(float3(fragment_unnamed_211, fragment_unnamed_218, fragment_unnamed_225), float3(fragment_unnamed_211, fragment_unnamed_218, fragment_unnamed_225)));
				float4 fragment_unnamed_243 = _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_246 = fragment_unnamed_243.x;
				float fragment_unnamed_247 = fragment_unnamed_243.y;
				float fragment_unnamed_248 = fragment_unnamed_243.z;
				float4 fragment_unnamed_257 = _SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_259 = fragment_unnamed_257.x;
				float fragment_unnamed_260 = fragment_unnamed_257.y;
				float fragment_unnamed_261 = fragment_unnamed_257.w;
				float fragment_unnamed_264 = fragment_unnamed_259 * fragment_input_5.x;
				float fragment_unnamed_277 = mad(fragment_unnamed_264, mad(fragment_unnamed_246, fragment_uniform_buffer_2[4u].x, (-0.0f) - fragment_unnamed_246), fragment_unnamed_246);
				float fragment_unnamed_278 = mad(fragment_unnamed_264, mad(fragment_unnamed_247, fragment_uniform_buffer_2[4u].y, (-0.0f) - fragment_unnamed_247), fragment_unnamed_247);
				float fragment_unnamed_279 = mad(fragment_unnamed_264, mad(fragment_unnamed_248, fragment_uniform_buffer_2[4u].z, (-0.0f) - fragment_unnamed_248), fragment_unnamed_248);
				float fragment_unnamed_293 = mad((-0.0f) - fragment_unnamed_259, fragment_input_5.x, 1.0f);
				float fragment_unnamed_297 = mad(abs(fragment_unnamed_293), mad(fragment_unnamed_261, clamp(mad(mad(fragment_unnamed_261, 0.89999997615814208984375f, -0.21763764321804046630859375f), fragment_uniform_buffer_2[5u].y, 0.21763764321804046630859375f), 0.0f, 1.0f), (-0.0f) - fragment_unnamed_261), fragment_unnamed_261);
				float4 fragment_unnamed_309 = _SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D, float2(fragment_input_2.x * 5.0f, fragment_input_2.y * 5.0f), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_315 = mad(fragment_unnamed_309.x * fragment_unnamed_309.w, 2.0f, -1.0f);
				float fragment_unnamed_318 = mad(fragment_unnamed_309.y, 2.0f, -1.0f);
				float fragment_unnamed_331 = fragment_unnamed_264 * fragment_uniform_buffer_2[5u].z;
				float4 fragment_unnamed_345 = _SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_351 = mad(fragment_unnamed_345.x * fragment_unnamed_345.w, 2.0f, -1.0f);
				float fragment_unnamed_352 = mad(fragment_unnamed_345.y, 2.0f, -1.0f);
				float fragment_unnamed_361 = (fragment_unnamed_331 * fragment_unnamed_315) + 0.0f;
				float fragment_unnamed_362 = (fragment_unnamed_331 * fragment_unnamed_318) + 0.0f;
				float fragment_unnamed_363 = (clamp(fragment_unnamed_331, 0.0f, 1.0f) * (max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_315, fragment_unnamed_318), float2(fragment_unnamed_315, fragment_unnamed_318)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f))) + 2.0f;
				float fragment_unnamed_364 = fragment_unnamed_351 * (-1.0f);
				float fragment_unnamed_365 = fragment_unnamed_352 * (-1.0f);
				float fragment_unnamed_366 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_351, fragment_unnamed_352), float2(fragment_unnamed_351, fragment_unnamed_352)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) * 1.0f;
				float fragment_unnamed_370 = dot(float3(fragment_unnamed_361, fragment_unnamed_362, fragment_unnamed_363), float3(fragment_unnamed_364, fragment_unnamed_365, fragment_unnamed_366));
				float fragment_unnamed_376 = mad(fragment_unnamed_361 / fragment_unnamed_363, fragment_unnamed_370, (-0.0f) - fragment_unnamed_364);
				float fragment_unnamed_377 = mad(fragment_unnamed_362 / fragment_unnamed_363, fragment_unnamed_370, (-0.0f) - fragment_unnamed_365);
				float fragment_unnamed_378 = mad(fragment_unnamed_363 / fragment_unnamed_363, fragment_unnamed_370, (-0.0f) - fragment_unnamed_366);
				float fragment_unnamed_385 = mad(fragment_unnamed_378, fragment_unnamed_102 * fragment_input_7.x, mad(fragment_unnamed_376, fragment_unnamed_102 * fragment_input_1.x, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_377));
				float fragment_unnamed_386 = mad(fragment_unnamed_378, fragment_unnamed_102 * fragment_input_7.y, mad(fragment_unnamed_376, fragment_unnamed_102 * fragment_input_1.y, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_377));
				float fragment_unnamed_387 = mad(fragment_unnamed_378, fragment_unnamed_102 * fragment_input_7.z, mad(fragment_unnamed_376, fragment_unnamed_102 * fragment_input_1.z, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_377));
				float fragment_unnamed_392 = rsqrt(max(dot(float3(fragment_unnamed_385, fragment_unnamed_386, fragment_unnamed_387), float3(fragment_unnamed_385, fragment_unnamed_386, fragment_unnamed_387)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_393 = fragment_unnamed_392 * fragment_unnamed_385;
				float fragment_unnamed_394 = fragment_unnamed_392 * fragment_unnamed_386;
				float fragment_unnamed_395 = fragment_unnamed_392 * fragment_unnamed_387;
				float fragment_unnamed_457;
				float fragment_unnamed_458;
				float fragment_unnamed_459;
				float fragment_unnamed_460;
				float fragment_unnamed_461;
				float fragment_unnamed_462;
				float fragment_unnamed_463;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_406 = uint(gl_FragCoord.x);
					uint fragment_unnamed_407 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_408 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_406, fragment_unnamed_407, 0u), 0u));
					float fragment_unnamed_414 = fragment_unnamed_408.w;
					float4 fragment_unnamed_415 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_406, fragment_unnamed_407, 0u), 0u));
					float fragment_unnamed_420 = fragment_unnamed_415.w;
					float4 fragment_unnamed_421 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_406, fragment_unnamed_407, 0u), 0u));
					bool fragment_unnamed_429 = fragment_unnamed_420 < 1.0f;
					float fragment_unnamed_430 = mad(fragment_unnamed_393, fragment_unnamed_420, mad(fragment_unnamed_415.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_431 = mad(fragment_unnamed_394, fragment_unnamed_420, mad(fragment_unnamed_415.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_432 = mad(fragment_unnamed_395, fragment_unnamed_420, mad(fragment_unnamed_415.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_437 = rsqrt(max(dot(float3(fragment_unnamed_430, fragment_unnamed_431, fragment_unnamed_432), float3(fragment_unnamed_430, fragment_unnamed_431, fragment_unnamed_432)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_457 = mad(fragment_unnamed_277, fragment_unnamed_414, fragment_unnamed_408.x);
					fragment_unnamed_458 = mad(fragment_unnamed_278, fragment_unnamed_414, fragment_unnamed_408.y);
					fragment_unnamed_459 = mad(fragment_unnamed_279, fragment_unnamed_414, fragment_unnamed_408.z);
					fragment_unnamed_460 = asfloat(fragment_unnamed_429 ? asuint(fragment_unnamed_432 * fragment_unnamed_437) : asuint(fragment_unnamed_395));
					fragment_unnamed_461 = asfloat(fragment_unnamed_429 ? asuint(fragment_unnamed_431 * fragment_unnamed_437) : asuint(fragment_unnamed_394));
					fragment_unnamed_462 = mad(fragment_unnamed_297, fragment_unnamed_421.w, fragment_unnamed_421.z);
					fragment_unnamed_463 = asfloat(fragment_unnamed_429 ? asuint(fragment_unnamed_430 * fragment_unnamed_437) : asuint(fragment_unnamed_393));
				}
				else
				{
					fragment_unnamed_457 = fragment_unnamed_277;
					fragment_unnamed_458 = fragment_unnamed_278;
					fragment_unnamed_459 = fragment_unnamed_279;
					fragment_unnamed_460 = fragment_unnamed_395;
					fragment_unnamed_461 = fragment_unnamed_394;
					fragment_unnamed_462 = fragment_unnamed_297;
					fragment_unnamed_463 = fragment_unnamed_393;
				}
				float fragment_unnamed_467 = max(dot(float3(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460), float3(fragment_unnamed_229 * fragment_unnamed_211, fragment_unnamed_229 * fragment_unnamed_218, fragment_unnamed_229 * fragment_unnamed_225)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_470 = ((-0.0f) - fragment_unnamed_462) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_260 + exp2(log2(abs(fragment_unnamed_260 + fragment_unnamed_467)) * exp2(mad(fragment_unnamed_470 * fragment_unnamed_470, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_499 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_500 = fragment_unnamed_499.x;
				float fragment_unnamed_787;
				float fragment_unnamed_789;
				float fragment_unnamed_791;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_500 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_500 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_788;
					float fragment_unnamed_790;
					float fragment_unnamed_792;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_524 = asfloat(1065353216u);
						float fragment_unnamed_554 = fragment_unnamed_461 * fragment_unnamed_463;
						float fragment_unnamed_555 = fragment_unnamed_460 * fragment_unnamed_461;
						float fragment_unnamed_556 = fragment_unnamed_460 * fragment_unnamed_460;
						float fragment_unnamed_557 = fragment_unnamed_463 * fragment_unnamed_460;
						float fragment_unnamed_590 = mad(fragment_unnamed_463, fragment_unnamed_463, (-0.0f) - (fragment_unnamed_461 * fragment_unnamed_461));
						fragment_unnamed_788 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_524)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_590, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_557)));
						fragment_unnamed_790 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_524)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_590, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_557)));
						fragment_unnamed_792 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_524)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_590, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_557)));
					}
					else
					{
						bool fragment_unnamed_606 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_607 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_629 = fragment_unnamed_606 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_630 = fragment_unnamed_606 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_631 = fragment_unnamed_606 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_735 = (asfloat(fragment_unnamed_607 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_631, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_629, fragment_unnamed_630 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_630)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_736 = (asfloat(fragment_unnamed_607 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_631, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_629, fragment_unnamed_630 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_631)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_750 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_607 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_631, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_629, fragment_unnamed_630 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_629)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_777 = asfloat(1065353216u);
						fragment_unnamed_788 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_750, fragment_unnamed_735, fragment_unnamed_736), 0.0f)), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_777));
						fragment_unnamed_790 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_750 + 0.25f, fragment_unnamed_735 + 0.0f, fragment_unnamed_736 + 0.0f), 0.0f)), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_777));
						fragment_unnamed_792 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_750 + 0.5f, fragment_unnamed_735 + 0.0f, fragment_unnamed_736 + 0.0f), 0.0f)), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_777));
					}
					fragment_unnamed_787 = fragment_unnamed_788;
					fragment_unnamed_789 = fragment_unnamed_790;
					fragment_unnamed_791 = fragment_unnamed_792;
				}
				else
				{
					fragment_unnamed_787 = asfloat(0u);
					fragment_unnamed_789 = asfloat(0u);
					fragment_unnamed_791 = asfloat(0u);
				}
				float fragment_unnamed_795 = ((-0.0f) - abs(fragment_unnamed_293)) + 1.0f;
				float fragment_unnamed_796 = fragment_unnamed_795 * fragment_unnamed_457;
				float fragment_unnamed_797 = fragment_unnamed_795 * fragment_unnamed_458;
				float fragment_unnamed_798 = fragment_unnamed_795 * fragment_unnamed_459;
				float fragment_unnamed_803 = abs(fragment_unnamed_293);
				float fragment_unnamed_804 = mad(fragment_unnamed_803, fragment_unnamed_457 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_806 = mad(fragment_unnamed_803, fragment_unnamed_458 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_807 = mad(fragment_unnamed_803, fragment_unnamed_459 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_819 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_467), 0.984375f, 0.0078125f), mad(fragment_unnamed_470, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_829 = clamp((max(fragment_unnamed_807, max(fragment_unnamed_806, fragment_unnamed_804)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_853 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_858 = max(abs(fragment_unnamed_460), 0.0009765625f);
				float fragment_unnamed_862 = (fragment_unnamed_460 >= 0.0f) ? fragment_unnamed_858 : ((-0.0f) - fragment_unnamed_858);
				float fragment_unnamed_871 = 1.0f / max(dot(float3(abs(fragment_unnamed_463), abs(fragment_unnamed_461), abs(fragment_unnamed_862)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_876 = clamp((-0.0f) - (fragment_unnamed_871 * fragment_unnamed_862), 0.0f, 1.0f);
				float fragment_unnamed_879 = (-0.0f) - fragment_unnamed_876;
				uint fragment_unnamed_891 = uint(clamp(mad(mad(fragment_unnamed_463, fragment_unnamed_871, ((fragment_unnamed_871 * fragment_unnamed_463) >= 0.0f) ? fragment_unnamed_876 : fragment_unnamed_879), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_892 = uint(clamp(mad(mad(fragment_unnamed_461, fragment_unnamed_871, ((fragment_unnamed_871 * fragment_unnamed_461) >= 0.0f) ? fragment_unnamed_876 : fragment_unnamed_879), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_891 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_892 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_892 >> 8u) * 16u) + (fragment_unnamed_891 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_804)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_806)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_807)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_945 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_946 = fragment_unnamed_945 * (fragment_unnamed_260 * (fragment_unnamed_853 * ((fragment_unnamed_819 * mad(fragment_unnamed_829, mad((-0.0f) - fragment_unnamed_457, fragment_unnamed_795, fragment_unnamed_804), fragment_unnamed_796)) * fragment_unnamed_787)));
				float fragment_unnamed_947 = fragment_unnamed_945 * (fragment_unnamed_260 * (fragment_unnamed_853 * ((fragment_unnamed_819 * mad(fragment_unnamed_829, mad((-0.0f) - fragment_unnamed_458, fragment_unnamed_795, fragment_unnamed_806), fragment_unnamed_797)) * fragment_unnamed_789)));
				float fragment_unnamed_948 = fragment_unnamed_945 * (fragment_unnamed_260 * (fragment_unnamed_853 * ((fragment_unnamed_819 * mad(fragment_unnamed_829, mad((-0.0f) - fragment_unnamed_459, fragment_unnamed_795, fragment_unnamed_807), fragment_unnamed_798)) * fragment_unnamed_791)));
				bool fragment_unnamed_961 = (((fragment_unnamed_948 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_947 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_946 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_961 ? asfloat(1157627904u) : fragment_unnamed_946;
				fragment_output_3.y = fragment_unnamed_961 ? fragment_unnamed_260 : fragment_unnamed_947;
				fragment_output_3.z = fragment_unnamed_961 ? asfloat(1149239296u) : fragment_unnamed_948;
				fragment_output_0.x = fragment_unnamed_796;
				fragment_output_0.y = fragment_unnamed_797;
				fragment_output_0.z = fragment_unnamed_798;
				fragment_output_1.w = fragment_unnamed_470;
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

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_1[13] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_1[14] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_1[15] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_1[16] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				fragment_uniform_buffer_1[17] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				fragment_uniform_buffer_1[18] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				fragment_uniform_buffer_1[19] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				fragment_uniform_buffer_2[4] = float4(_Canister_color[0], _Canister_color[1], _Canister_color[2], _Canister_color[3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], _Roughness_contrast, fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], fragment_uniform_buffer_2[5][1], _Extra_Normal_Intensity, fragment_uniform_buffer_2[5][3]);

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

			#endif // defined(DECALS_3RT) && defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)


			#if defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)

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
			float4 unity_RenderingLayer;
			float4 unity_SHAr;
			float4 unity_SHAg;
			float4 unity_SHAb;
			float4 unity_SHBr;
			float4 unity_SHBg;
			float4 unity_SHBb;
			float4 unity_SHC;
			float4 _Canister_color;
			float _Roughness_contrast;
			float _Extra_Normal_Intensity;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[6];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D;

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
				float fragment_unnamed_102 = 1.0f / max(sqrt(dot(float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z), float3(fragment_input_7.x, fragment_input_7.y, fragment_input_7.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_122 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_185 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_211 = asfloat(fragment_unnamed_185 ? asuint(((-0.0f) - fragment_input_6.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_218 = asfloat(fragment_unnamed_185 ? asuint(((-0.0f) - fragment_input_6.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_225 = asfloat(fragment_unnamed_185 ? asuint(((-0.0f) - fragment_input_6.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_229 = rsqrt(dot(float3(fragment_unnamed_211, fragment_unnamed_218, fragment_unnamed_225), float3(fragment_unnamed_211, fragment_unnamed_218, fragment_unnamed_225)));
				float4 fragment_unnamed_243 = _SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_12bf7fcff10140d3899c2b8ae00df17c_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_246 = fragment_unnamed_243.x;
				float fragment_unnamed_247 = fragment_unnamed_243.y;
				float fragment_unnamed_248 = fragment_unnamed_243.z;
				float4 fragment_unnamed_257 = _SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_05d59074c8c84a88a34f09c04a03ea18_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_259 = fragment_unnamed_257.x;
				float fragment_unnamed_260 = fragment_unnamed_257.y;
				float fragment_unnamed_261 = fragment_unnamed_257.w;
				float fragment_unnamed_264 = fragment_unnamed_259 * fragment_input_5.x;
				float fragment_unnamed_277 = mad(fragment_unnamed_264, mad(fragment_unnamed_246, fragment_uniform_buffer_2[4u].x, (-0.0f) - fragment_unnamed_246), fragment_unnamed_246);
				float fragment_unnamed_278 = mad(fragment_unnamed_264, mad(fragment_unnamed_247, fragment_uniform_buffer_2[4u].y, (-0.0f) - fragment_unnamed_247), fragment_unnamed_247);
				float fragment_unnamed_279 = mad(fragment_unnamed_264, mad(fragment_unnamed_248, fragment_uniform_buffer_2[4u].z, (-0.0f) - fragment_unnamed_248), fragment_unnamed_248);
				float fragment_unnamed_293 = mad((-0.0f) - fragment_unnamed_259, fragment_input_5.x, 1.0f);
				float fragment_unnamed_297 = mad(abs(fragment_unnamed_293), mad(fragment_unnamed_261, clamp(mad(mad(fragment_unnamed_261, 0.89999997615814208984375f, -0.21763764321804046630859375f), fragment_uniform_buffer_2[5u].y, 0.21763764321804046630859375f), 0.0f, 1.0f), (-0.0f) - fragment_unnamed_261), fragment_unnamed_261);
				float4 fragment_unnamed_309 = _SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_0e8dc5c2f05c41aa811c8273a37808bf_Texture_1_Texture2D, float2(fragment_input_2.x * 5.0f, fragment_input_2.y * 5.0f), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_315 = mad(fragment_unnamed_309.x * fragment_unnamed_309.w, 2.0f, -1.0f);
				float fragment_unnamed_318 = mad(fragment_unnamed_309.y, 2.0f, -1.0f);
				float fragment_unnamed_331 = fragment_unnamed_264 * fragment_uniform_buffer_2[5u].z;
				float4 fragment_unnamed_345 = _SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_e95d02134e824c4298b96bdc52cc1b2a_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_351 = mad(fragment_unnamed_345.x * fragment_unnamed_345.w, 2.0f, -1.0f);
				float fragment_unnamed_352 = mad(fragment_unnamed_345.y, 2.0f, -1.0f);
				float fragment_unnamed_361 = (fragment_unnamed_331 * fragment_unnamed_315) + 0.0f;
				float fragment_unnamed_362 = (fragment_unnamed_331 * fragment_unnamed_318) + 0.0f;
				float fragment_unnamed_363 = (clamp(fragment_unnamed_331, 0.0f, 1.0f) * (max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_315, fragment_unnamed_318), float2(fragment_unnamed_315, fragment_unnamed_318)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f))) + 2.0f;
				float fragment_unnamed_364 = fragment_unnamed_351 * (-1.0f);
				float fragment_unnamed_365 = fragment_unnamed_352 * (-1.0f);
				float fragment_unnamed_366 = max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_351, fragment_unnamed_352), float2(fragment_unnamed_351, fragment_unnamed_352)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) * 1.0f;
				float fragment_unnamed_370 = dot(float3(fragment_unnamed_361, fragment_unnamed_362, fragment_unnamed_363), float3(fragment_unnamed_364, fragment_unnamed_365, fragment_unnamed_366));
				float fragment_unnamed_376 = mad(fragment_unnamed_361 / fragment_unnamed_363, fragment_unnamed_370, (-0.0f) - fragment_unnamed_364);
				float fragment_unnamed_377 = mad(fragment_unnamed_362 / fragment_unnamed_363, fragment_unnamed_370, (-0.0f) - fragment_unnamed_365);
				float fragment_unnamed_378 = mad(fragment_unnamed_363 / fragment_unnamed_363, fragment_unnamed_370, (-0.0f) - fragment_unnamed_366);
				float fragment_unnamed_385 = mad(fragment_unnamed_378, fragment_unnamed_102 * fragment_input_7.x, mad(fragment_unnamed_376, fragment_unnamed_102 * fragment_input_1.x, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_7.z)))) * fragment_unnamed_377));
				float fragment_unnamed_386 = mad(fragment_unnamed_378, fragment_unnamed_102 * fragment_input_7.y, mad(fragment_unnamed_376, fragment_unnamed_102 * fragment_input_1.y, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_7.x)))) * fragment_unnamed_377));
				float fragment_unnamed_387 = mad(fragment_unnamed_378, fragment_unnamed_102 * fragment_input_7.z, mad(fragment_unnamed_376, fragment_unnamed_102 * fragment_input_1.z, (fragment_unnamed_102 * (fragment_unnamed_122 * mad(fragment_input_7.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_7.y)))) * fragment_unnamed_377));
				float fragment_unnamed_392 = rsqrt(max(dot(float3(fragment_unnamed_385, fragment_unnamed_386, fragment_unnamed_387), float3(fragment_unnamed_385, fragment_unnamed_386, fragment_unnamed_387)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_393 = fragment_unnamed_392 * fragment_unnamed_385;
				float fragment_unnamed_394 = fragment_unnamed_392 * fragment_unnamed_386;
				float fragment_unnamed_395 = fragment_unnamed_392 * fragment_unnamed_387;
				float fragment_unnamed_457;
				float fragment_unnamed_458;
				float fragment_unnamed_459;
				float fragment_unnamed_460;
				float fragment_unnamed_461;
				float fragment_unnamed_462;
				float fragment_unnamed_463;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_406 = uint(gl_FragCoord.x);
					uint fragment_unnamed_407 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_408 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_406, fragment_unnamed_407, 0u), 0u));
					float fragment_unnamed_414 = fragment_unnamed_408.w;
					float4 fragment_unnamed_415 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_406, fragment_unnamed_407, 0u), 0u));
					float fragment_unnamed_420 = fragment_unnamed_415.w;
					float4 fragment_unnamed_421 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_406, fragment_unnamed_407, 0u), 0u));
					bool fragment_unnamed_429 = fragment_unnamed_420 < 1.0f;
					float fragment_unnamed_430 = mad(fragment_unnamed_393, fragment_unnamed_420, mad(fragment_unnamed_415.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_431 = mad(fragment_unnamed_394, fragment_unnamed_420, mad(fragment_unnamed_415.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_432 = mad(fragment_unnamed_395, fragment_unnamed_420, mad(fragment_unnamed_415.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_437 = rsqrt(max(dot(float3(fragment_unnamed_430, fragment_unnamed_431, fragment_unnamed_432), float3(fragment_unnamed_430, fragment_unnamed_431, fragment_unnamed_432)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_457 = mad(fragment_unnamed_277, fragment_unnamed_414, fragment_unnamed_408.x);
					fragment_unnamed_458 = mad(fragment_unnamed_278, fragment_unnamed_414, fragment_unnamed_408.y);
					fragment_unnamed_459 = mad(fragment_unnamed_279, fragment_unnamed_414, fragment_unnamed_408.z);
					fragment_unnamed_460 = asfloat(fragment_unnamed_429 ? asuint(fragment_unnamed_432 * fragment_unnamed_437) : asuint(fragment_unnamed_395));
					fragment_unnamed_461 = asfloat(fragment_unnamed_429 ? asuint(fragment_unnamed_431 * fragment_unnamed_437) : asuint(fragment_unnamed_394));
					fragment_unnamed_462 = mad(fragment_unnamed_297, fragment_unnamed_421.w, fragment_unnamed_421.z);
					fragment_unnamed_463 = asfloat(fragment_unnamed_429 ? asuint(fragment_unnamed_430 * fragment_unnamed_437) : asuint(fragment_unnamed_393));
				}
				else
				{
					fragment_unnamed_457 = fragment_unnamed_277;
					fragment_unnamed_458 = fragment_unnamed_278;
					fragment_unnamed_459 = fragment_unnamed_279;
					fragment_unnamed_460 = fragment_unnamed_395;
					fragment_unnamed_461 = fragment_unnamed_394;
					fragment_unnamed_462 = fragment_unnamed_297;
					fragment_unnamed_463 = fragment_unnamed_393;
				}
				float fragment_unnamed_467 = max(dot(float3(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460), float3(fragment_unnamed_229 * fragment_unnamed_211, fragment_unnamed_229 * fragment_unnamed_218, fragment_unnamed_229 * fragment_unnamed_225)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_470 = ((-0.0f) - fragment_unnamed_462) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_260 + exp2(log2(abs(fragment_unnamed_260 + fragment_unnamed_467)) * exp2(mad(fragment_unnamed_470 * fragment_unnamed_470, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_499 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_500 = fragment_unnamed_499.x;
				float fragment_unnamed_787;
				float fragment_unnamed_789;
				float fragment_unnamed_791;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_500 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_500 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_788;
					float fragment_unnamed_790;
					float fragment_unnamed_792;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_524 = asfloat(1065353216u);
						float fragment_unnamed_554 = fragment_unnamed_461 * fragment_unnamed_463;
						float fragment_unnamed_555 = fragment_unnamed_460 * fragment_unnamed_461;
						float fragment_unnamed_556 = fragment_unnamed_460 * fragment_unnamed_460;
						float fragment_unnamed_557 = fragment_unnamed_463 * fragment_unnamed_460;
						float fragment_unnamed_590 = mad(fragment_unnamed_463, fragment_unnamed_463, (-0.0f) - (fragment_unnamed_461 * fragment_unnamed_461));
						fragment_unnamed_788 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_524)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_590, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_557)));
						fragment_unnamed_790 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_524)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_590, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_557)));
						fragment_unnamed_792 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_524)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_590, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_554, fragment_unnamed_555, fragment_unnamed_556, fragment_unnamed_557)));
					}
					else
					{
						bool fragment_unnamed_606 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_607 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_629 = fragment_unnamed_606 ? (fragment_input_6.x + fragment_uniform_buffer_0[48u].x) : fragment_input_6.x;
						float fragment_unnamed_630 = fragment_unnamed_606 ? (fragment_input_6.y + fragment_uniform_buffer_0[48u].y) : fragment_input_6.y;
						float fragment_unnamed_631 = fragment_unnamed_606 ? (fragment_input_6.z + fragment_uniform_buffer_0[48u].z) : fragment_input_6.z;
						float fragment_unnamed_735 = (asfloat(fragment_unnamed_607 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_631, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_629, fragment_unnamed_630 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_630)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_736 = (asfloat(fragment_unnamed_607 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_631, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_629, fragment_unnamed_630 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_631)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_750 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_607 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_631, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_629, fragment_unnamed_630 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_629)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_777 = asfloat(1065353216u);
						fragment_unnamed_788 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_750, fragment_unnamed_735, fragment_unnamed_736), 0.0f)), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_777));
						fragment_unnamed_790 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_750 + 0.25f, fragment_unnamed_735 + 0.0f, fragment_unnamed_736 + 0.0f), 0.0f)), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_777));
						fragment_unnamed_792 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_750 + 0.5f, fragment_unnamed_735 + 0.0f, fragment_unnamed_736 + 0.0f), 0.0f)), float4(fragment_unnamed_463, fragment_unnamed_461, fragment_unnamed_460, fragment_unnamed_777));
					}
					fragment_unnamed_787 = fragment_unnamed_788;
					fragment_unnamed_789 = fragment_unnamed_790;
					fragment_unnamed_791 = fragment_unnamed_792;
				}
				else
				{
					fragment_unnamed_787 = asfloat(0u);
					fragment_unnamed_789 = asfloat(0u);
					fragment_unnamed_791 = asfloat(0u);
				}
				float fragment_unnamed_795 = ((-0.0f) - abs(fragment_unnamed_293)) + 1.0f;
				float fragment_unnamed_796 = fragment_unnamed_795 * fragment_unnamed_457;
				float fragment_unnamed_797 = fragment_unnamed_795 * fragment_unnamed_458;
				float fragment_unnamed_798 = fragment_unnamed_795 * fragment_unnamed_459;
				float fragment_unnamed_803 = abs(fragment_unnamed_293);
				float fragment_unnamed_804 = mad(fragment_unnamed_803, fragment_unnamed_457 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_806 = mad(fragment_unnamed_803, fragment_unnamed_458 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_807 = mad(fragment_unnamed_803, fragment_unnamed_459 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_819 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_467), 0.984375f, 0.0078125f), mad(fragment_unnamed_470, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_829 = clamp((max(fragment_unnamed_807, max(fragment_unnamed_806, fragment_unnamed_804)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_853 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_858 = max(abs(fragment_unnamed_460), 0.0009765625f);
				float fragment_unnamed_862 = (fragment_unnamed_460 >= 0.0f) ? fragment_unnamed_858 : ((-0.0f) - fragment_unnamed_858);
				float fragment_unnamed_871 = 1.0f / max(dot(float3(abs(fragment_unnamed_463), abs(fragment_unnamed_461), abs(fragment_unnamed_862)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_876 = clamp((-0.0f) - (fragment_unnamed_871 * fragment_unnamed_862), 0.0f, 1.0f);
				float fragment_unnamed_879 = (-0.0f) - fragment_unnamed_876;
				uint fragment_unnamed_891 = uint(clamp(mad(mad(fragment_unnamed_463, fragment_unnamed_871, ((fragment_unnamed_871 * fragment_unnamed_463) >= 0.0f) ? fragment_unnamed_876 : fragment_unnamed_879), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_892 = uint(clamp(mad(mad(fragment_unnamed_461, fragment_unnamed_871, ((fragment_unnamed_871 * fragment_unnamed_461) >= 0.0f) ? fragment_unnamed_876 : fragment_unnamed_879), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_891 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_892 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_892 >> 8u) * 16u) + (fragment_unnamed_891 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_804)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_806)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_807)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_945 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_946 = fragment_unnamed_945 * (fragment_unnamed_260 * (fragment_unnamed_853 * ((fragment_unnamed_819 * mad(fragment_unnamed_829, mad((-0.0f) - fragment_unnamed_457, fragment_unnamed_795, fragment_unnamed_804), fragment_unnamed_796)) * fragment_unnamed_787)));
				float fragment_unnamed_947 = fragment_unnamed_945 * (fragment_unnamed_260 * (fragment_unnamed_853 * ((fragment_unnamed_819 * mad(fragment_unnamed_829, mad((-0.0f) - fragment_unnamed_458, fragment_unnamed_795, fragment_unnamed_806), fragment_unnamed_797)) * fragment_unnamed_789)));
				float fragment_unnamed_948 = fragment_unnamed_945 * (fragment_unnamed_260 * (fragment_unnamed_853 * ((fragment_unnamed_819 * mad(fragment_unnamed_829, mad((-0.0f) - fragment_unnamed_459, fragment_unnamed_795, fragment_unnamed_807), fragment_unnamed_798)) * fragment_unnamed_791)));
				bool fragment_unnamed_961 = (((fragment_unnamed_948 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_947 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_946 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_961 ? asfloat(1157627904u) : fragment_unnamed_946;
				fragment_output_3.y = fragment_unnamed_961 ? fragment_unnamed_260 : fragment_unnamed_947;
				fragment_output_3.z = fragment_unnamed_961 ? asfloat(1149239296u) : fragment_unnamed_948;
				fragment_output_0.x = fragment_unnamed_796;
				fragment_output_0.y = fragment_unnamed_797;
				fragment_output_0.z = fragment_unnamed_798;
				fragment_output_1.w = fragment_unnamed_470;
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

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_1[13] = float4(unity_SHAr[0], unity_SHAr[1], unity_SHAr[2], unity_SHAr[3]);

				fragment_uniform_buffer_1[14] = float4(unity_SHAg[0], unity_SHAg[1], unity_SHAg[2], unity_SHAg[3]);

				fragment_uniform_buffer_1[15] = float4(unity_SHAb[0], unity_SHAb[1], unity_SHAb[2], unity_SHAb[3]);

				fragment_uniform_buffer_1[16] = float4(unity_SHBr[0], unity_SHBr[1], unity_SHBr[2], unity_SHBr[3]);

				fragment_uniform_buffer_1[17] = float4(unity_SHBg[0], unity_SHBg[1], unity_SHBg[2], unity_SHBg[3]);

				fragment_uniform_buffer_1[18] = float4(unity_SHBb[0], unity_SHBb[1], unity_SHBb[2], unity_SHBb[3]);

				fragment_uniform_buffer_1[19] = float4(unity_SHC[0], unity_SHC[1], unity_SHC[2], unity_SHC[3]);

				fragment_uniform_buffer_2[4] = float4(_Canister_color[0], _Canister_color[1], _Canister_color[2], _Canister_color[3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], _Roughness_contrast, fragment_uniform_buffer_2[5][2], fragment_uniform_buffer_2[5][3]);

				fragment_uniform_buffer_2[5] = float4(fragment_uniform_buffer_2[5][0], fragment_uniform_buffer_2[5][1], _Extra_Normal_Intensity, fragment_uniform_buffer_2[5][3]);

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

			#endif // defined(DECALS_3RT) && !defined(_ALPHATEST_ON) && !defined(INSTANCING_ON)


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
			GpuProgramID 739052

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
			GpuProgramID 811845

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
			GpuProgramID 897106

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
			GpuProgramID 942798

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
			GpuProgramID 1007743

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
			GpuProgramID 1094722

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
