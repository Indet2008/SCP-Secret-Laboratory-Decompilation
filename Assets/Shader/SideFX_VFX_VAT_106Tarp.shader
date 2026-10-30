Shader "SideFX/VFX_VAT_106Tarp"
{
	Properties
	{
		_BaseColor ("BaseColor", Color) = (0,0,0,0)
		[ToggleUI] _B_autoPlayback ("Auto Playback", Float) = 1
		_gameTimeAtFirstFrame ("Game Time at First Frame", Float) = 0
		_displayFrame ("Display Frame", Float) = 1
		_playbackSpeed ("Playback Speed", Float) = 1
		_houdiniFPS ("Houdini FPS", Float) = 60
		[ToggleUI] _B_interpolate ("Interframe Interpolation", Float) = 0
		[ToggleUI] _B_interpolateCol ("Interpolate Color", Float) = 0
		[ToggleUI] _B_interpolateSpareCol ("Interpolate Spare Color", Float) = 0
		[ToggleUI] _B_surfaceNormals ("Support Surface Normal Maps", Float) = 1
		[ToggleUI] _B_twoSidedNorms ("Two Sided Normals", Float) = 0
		_Color_Multiplier ("Color Multiplier", Color) = (0,0,0,0)
		_Normal_Intensity ("Normal Intensity", Float) = 1
		[NoScaleOffset] _BaseColorTexture ("BaseColorTexture", 2D) = "white" {}
		[NoScaleOffset] _posTexture ("Position Texture", 2D) = "white" {}
		[NoScaleOffset] _posTexture2 ("Position Texture 2", 2D) = "white" {}
		[NoScaleOffset] _rotTexture ("Rotation Texture", 2D) = "white" {}
		[NoScaleOffset] _colTexture ("Color Texture", 2D) = "white" {}
		[NoScaleOffset] _spareColTexture ("Spare Color Texture", 2D) = "white" {}
		[Toggle(_B_LOAD_COL_TEX)] _B_LOAD_COL_TEX ("Load Color Texture", Float) = 1
		[Toggle(_B_UNLOAD_ROT_TEX)] _B_UNLOAD_ROT_TEX ("Use Compressed Normals", Float) = 0
		[Toggle(_B_LOAD_NORM_TEX)] _B_LOAD_NORM_TEX ("Load Surface Normal Map", Float) = 0
		[Toggle(_B_LOAD_POS_TWO_TEX)] _B_LOAD_POS_TWO_TEX ("Positions Require Two Textures", Float) = 0
		_frameCount ("Frame Count", Float) = 0
		_boundMaxX ("Bound Max X", Float) = 0
		_boundMaxY ("Bound Max Y", Float) = 0
		_boundMaxZ ("Bound Max Z", Float) = 0
		_boundMinX ("Bound Min X", Float) = 0
		_boundMinY ("Bound Min Y", Float) = 0
		_boundMinZ ("Bound Min Z", Float) = 0
		[NoScaleOffset] _SampleTexture2D_897e073688ab4409a4e5328b8226aa1d_Texture_1_Texture2D ("Texture2D", 2D) = "white" {}
		[NoScaleOffset] [Normal] _SampleTexture2D_72ab43ee7e5b4ff3acd5a9fb57f150dc_Texture_1_Texture2D ("Texture2D", 2D) = "bump" {}
		[NoScaleOffset] [Normal] _SampleTexture2D_baf7022b3fc74f368479e7fb6afb5c26_Texture_1_Texture2D ("Texture2D", 2D) = "bump" {}
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
			GpuProgramID 62946

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature _B_LOAD_COL_TEX
			#pragma shader_feature _B_LOAD_NORM_TEX
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(_B_LOAD_NORM_TEX)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _TimeParameters;
			float4x4 unity_ObjectToWorld;
			float _gameTimeAtFirstFrame;
			float _B_interpolate;
			float _B_autoPlayback;
			float _displayFrame;
			float _playbackSpeed;
			float _houdiniFPS;
			float _frameCount;
			float _boundMaxX;
			float _boundMaxY;
			float _boundMaxZ;
			float _boundMinX;
			float _boundMinY;
			float _boundMinZ;

			static float4 vertex_uniform_buffer_0[81];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[15];
			Texture2D<float4> _posTexture;
			SamplerState sampler_posTexture;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_73 = frac(((vertex_uniform_buffer_2[12u].y / (vertex_uniform_buffer_2[12u].z + (-0.00999999977648258209228515625f))) * (vertex_uniform_buffer_0[80u].x + ((-0.0f) - vertex_uniform_buffer_2[5u].x))) * vertex_uniform_buffer_2[12u].x) * vertex_uniform_buffer_2[12u].z;
				bool vertex_unnamed_86 = 0.0f != vertex_uniform_buffer_2[6u].x;
				float vertex_unnamed_91 = asfloat(vertex_unnamed_86 ? asuint(floor(vertex_unnamed_73) + 1.0f) : asuint(floor(vertex_uniform_buffer_2[6u].y)));
				float vertex_unnamed_100 = frac(asfloat(vertex_unnamed_86 ? asuint(vertex_unnamed_73) : asuint(vertex_uniform_buffer_2[6u]).y));
				float vertex_unnamed_104 = vertex_unnamed_91 / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_110 = (vertex_unnamed_91 + (-1.0f)) / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_114 = frac(abs(vertex_unnamed_104));
				float vertex_unnamed_124 = 1.0f / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_144 = ((-0.0f) - mad(vertex_uniform_buffer_2[12u].w, -10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[12u].w * (-10.0f)))) + 1.0f;
				float vertex_unnamed_145 = vertex_unnamed_144 * (((-0.0f) - vertex_input_3.y) + 1.0f);
				float vertex_unnamed_165 = (((-0.0f) - mad((-0.0f) - vertex_uniform_buffer_2[14u].x, 10.0f, ceil(vertex_uniform_buffer_2[14u].x * 10.0f))) + 1.0f) * vertex_input_3.x;
				float4 vertex_unnamed_168 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_165, ((-0.0f) - mad(vertex_unnamed_124 * (((vertex_unnamed_104 >= ((-0.0f) - vertex_unnamed_104)) ? vertex_unnamed_114 : ((-0.0f) - vertex_unnamed_114)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_144, vertex_unnamed_145)) + 1.0f), 0.0f);
				float vertex_unnamed_171 = vertex_unnamed_168.x;
				float vertex_unnamed_172 = vertex_unnamed_168.y;
				float vertex_unnamed_173 = vertex_unnamed_168.z;
				float vertex_unnamed_178 = asfloat(asuint(vertex_uniform_buffer_2[14u]).x);
				uint4 vertex_unnamed_182 = asuint(vertex_uniform_buffer_2[13u]);
				float vertex_unnamed_184 = asfloat(vertex_unnamed_182.z);
				float vertex_unnamed_186 = asfloat(vertex_unnamed_182.w);
				float vertex_unnamed_191 = ((-0.0f) - vertex_unnamed_184) + vertex_uniform_buffer_2[12u].w;
				float vertex_unnamed_198 = ((-0.0f) - vertex_unnamed_186) + vertex_uniform_buffer_2[13u].x;
				float vertex_unnamed_199 = ((-0.0f) - vertex_unnamed_178) + vertex_uniform_buffer_2[13u].y;
				bool vertex_unnamed_213 = mad(vertex_uniform_buffer_2[13u].y, 10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[13u].y * 10.0f)) >= 0.5f;
				float vertex_unnamed_230 = frac(abs(vertex_unnamed_110));
				float4 vertex_unnamed_241 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_165, ((-0.0f) - mad(vertex_unnamed_124 * (((vertex_unnamed_110 >= ((-0.0f) - vertex_unnamed_110)) ? vertex_unnamed_230 : ((-0.0f) - vertex_unnamed_230)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_144, vertex_unnamed_145)) + 1.0f), 0.0f);
				float vertex_unnamed_243 = vertex_unnamed_241.x;
				float vertex_unnamed_244 = vertex_unnamed_241.y;
				float vertex_unnamed_245 = vertex_unnamed_241.z;
				uint vertex_unnamed_255 = vertex_unnamed_213 ? asuint(vertex_unnamed_243) : asuint(mad(vertex_unnamed_243, vertex_unnamed_191, vertex_unnamed_184));
				float vertex_unnamed_256 = asfloat(vertex_unnamed_255);
				uint vertex_unnamed_257 = vertex_unnamed_213 ? asuint(vertex_unnamed_244) : asuint(mad(vertex_unnamed_244, vertex_unnamed_198, vertex_unnamed_186));
				float vertex_unnamed_258 = asfloat(vertex_unnamed_257);
				uint vertex_unnamed_259 = vertex_unnamed_213 ? asuint(vertex_unnamed_245) : asuint(mad(vertex_unnamed_245, vertex_unnamed_199, vertex_unnamed_178));
				float vertex_unnamed_260 = asfloat(vertex_unnamed_259);
				bool vertex_unnamed_273 = 0.0f != vertex_uniform_buffer_2[5u].y;
				bool vertex_unnamed_295 = 0.100000001490116119384765625f >= vertex_input_3.y;
				float vertex_unnamed_301 = asfloat(vertex_unnamed_295 ? 0u : asuint(asfloat(vertex_unnamed_273 ? asuint(mad(vertex_unnamed_100, ((-0.0f) - vertex_unnamed_256) + asfloat(vertex_unnamed_213 ? asuint(vertex_unnamed_171) : asuint(mad(vertex_unnamed_171, vertex_unnamed_191, vertex_unnamed_184))), vertex_unnamed_256)) : vertex_unnamed_255) + vertex_input_0.x));
				float vertex_unnamed_303 = asfloat(vertex_unnamed_295 ? 0u : asuint(asfloat(vertex_unnamed_273 ? asuint(mad(vertex_unnamed_100, ((-0.0f) - vertex_unnamed_258) + asfloat(vertex_unnamed_213 ? asuint(vertex_unnamed_172) : asuint(mad(vertex_unnamed_172, vertex_unnamed_198, vertex_unnamed_186))), vertex_unnamed_258)) : vertex_unnamed_257) + vertex_input_0.y));
				float vertex_unnamed_305 = asfloat(vertex_unnamed_295 ? 0u : asuint(asfloat(vertex_unnamed_273 ? asuint(mad(vertex_unnamed_100, ((-0.0f) - vertex_unnamed_260) + asfloat(vertex_unnamed_213 ? asuint(vertex_unnamed_173) : asuint(mad(vertex_unnamed_173, vertex_unnamed_199, vertex_unnamed_178))), vertex_unnamed_260)) : vertex_unnamed_259) + vertex_input_0.z));
				float vertex_unnamed_339 = asfloat(1065353216u);
				float vertex_unnamed_341 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_301, vertex_unnamed_303, vertex_unnamed_305, vertex_unnamed_339));
				float vertex_unnamed_370 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_301, vertex_unnamed_303, vertex_unnamed_305, vertex_unnamed_339));
				float vertex_unnamed_399 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_301, vertex_unnamed_303, vertex_unnamed_305, vertex_unnamed_339));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_399, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_370, vertex_unnamed_341 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_399, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_370, vertex_unnamed_341 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_399, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_370, vertex_unnamed_341 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_399, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_370, vertex_unnamed_341 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[5] = float4(_gameTimeAtFirstFrame, vertex_uniform_buffer_2[5][1], vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], _B_interpolate, vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[6] = float4(_B_autoPlayback, vertex_uniform_buffer_2[6][1], vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _displayFrame, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[12] = float4(_playbackSpeed, vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], _houdiniFPS, vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _frameCount, vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], _boundMaxX);

				vertex_uniform_buffer_2[13] = float4(_boundMaxY, vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], _boundMaxZ, vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _boundMinX, vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], _boundMinY);

				vertex_uniform_buffer_2[14] = float4(_boundMinZ, vertex_uniform_buffer_2[14][1], vertex_uniform_buffer_2[14][2], vertex_uniform_buffer_2[14][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
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

			#endif // !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(_B_LOAD_NORM_TEX)


			#if defined(_B_LOAD_COL_TEX) && defined(_DOUBLESIDED_ON) && !defined(_B_LOAD_NORM_TEX)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _TimeParameters;
			float4x4 unity_ObjectToWorld;
			float _gameTimeAtFirstFrame;
			float _B_interpolate;
			float _B_autoPlayback;
			float _displayFrame;
			float _playbackSpeed;
			float _houdiniFPS;
			float _frameCount;
			float _boundMaxX;
			float _boundMaxY;
			float _boundMaxZ;
			float _boundMinX;
			float _boundMinY;
			float _boundMinZ;

			static float4 vertex_uniform_buffer_0[81];
			static float4 vertex_uniform_buffer_1[4];
			static float4 vertex_uniform_buffer_2[15];
			Texture2D<float4> _posTexture;
			SamplerState sampler_posTexture;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD1; // TEXCOORD_1
			};

			struct Vertex_Stage_Output
			{
				float4 gl_Position : SV_Position;
			};

			void vert_main()
			{
				float vertex_unnamed_73 = frac(((vertex_uniform_buffer_2[12u].y / (vertex_uniform_buffer_2[12u].z + (-0.00999999977648258209228515625f))) * (vertex_uniform_buffer_0[80u].x + ((-0.0f) - vertex_uniform_buffer_2[5u].x))) * vertex_uniform_buffer_2[12u].x) * vertex_uniform_buffer_2[12u].z;
				bool vertex_unnamed_86 = 0.0f != vertex_uniform_buffer_2[6u].x;
				float vertex_unnamed_91 = asfloat(vertex_unnamed_86 ? asuint(floor(vertex_unnamed_73) + 1.0f) : asuint(floor(vertex_uniform_buffer_2[6u].y)));
				float vertex_unnamed_100 = frac(asfloat(vertex_unnamed_86 ? asuint(vertex_unnamed_73) : asuint(vertex_uniform_buffer_2[6u]).y));
				float vertex_unnamed_104 = vertex_unnamed_91 / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_110 = (vertex_unnamed_91 + (-1.0f)) / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_114 = frac(abs(vertex_unnamed_104));
				float vertex_unnamed_124 = 1.0f / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_144 = ((-0.0f) - mad(vertex_uniform_buffer_2[12u].w, -10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[12u].w * (-10.0f)))) + 1.0f;
				float vertex_unnamed_145 = vertex_unnamed_144 * (((-0.0f) - vertex_input_3.y) + 1.0f);
				float vertex_unnamed_165 = (((-0.0f) - mad((-0.0f) - vertex_uniform_buffer_2[14u].x, 10.0f, ceil(vertex_uniform_buffer_2[14u].x * 10.0f))) + 1.0f) * vertex_input_3.x;
				float4 vertex_unnamed_168 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_165, ((-0.0f) - mad(vertex_unnamed_124 * (((vertex_unnamed_104 >= ((-0.0f) - vertex_unnamed_104)) ? vertex_unnamed_114 : ((-0.0f) - vertex_unnamed_114)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_144, vertex_unnamed_145)) + 1.0f), 0.0f);
				float vertex_unnamed_171 = vertex_unnamed_168.x;
				float vertex_unnamed_172 = vertex_unnamed_168.y;
				float vertex_unnamed_173 = vertex_unnamed_168.z;
				float vertex_unnamed_178 = asfloat(asuint(vertex_uniform_buffer_2[14u]).x);
				uint4 vertex_unnamed_182 = asuint(vertex_uniform_buffer_2[13u]);
				float vertex_unnamed_184 = asfloat(vertex_unnamed_182.z);
				float vertex_unnamed_186 = asfloat(vertex_unnamed_182.w);
				float vertex_unnamed_191 = ((-0.0f) - vertex_unnamed_184) + vertex_uniform_buffer_2[12u].w;
				float vertex_unnamed_198 = ((-0.0f) - vertex_unnamed_186) + vertex_uniform_buffer_2[13u].x;
				float vertex_unnamed_199 = ((-0.0f) - vertex_unnamed_178) + vertex_uniform_buffer_2[13u].y;
				bool vertex_unnamed_213 = mad(vertex_uniform_buffer_2[13u].y, 10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[13u].y * 10.0f)) >= 0.5f;
				float vertex_unnamed_230 = frac(abs(vertex_unnamed_110));
				float4 vertex_unnamed_241 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_165, ((-0.0f) - mad(vertex_unnamed_124 * (((vertex_unnamed_110 >= ((-0.0f) - vertex_unnamed_110)) ? vertex_unnamed_230 : ((-0.0f) - vertex_unnamed_230)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_144, vertex_unnamed_145)) + 1.0f), 0.0f);
				float vertex_unnamed_243 = vertex_unnamed_241.x;
				float vertex_unnamed_244 = vertex_unnamed_241.y;
				float vertex_unnamed_245 = vertex_unnamed_241.z;
				uint vertex_unnamed_255 = vertex_unnamed_213 ? asuint(vertex_unnamed_243) : asuint(mad(vertex_unnamed_243, vertex_unnamed_191, vertex_unnamed_184));
				float vertex_unnamed_256 = asfloat(vertex_unnamed_255);
				uint vertex_unnamed_257 = vertex_unnamed_213 ? asuint(vertex_unnamed_244) : asuint(mad(vertex_unnamed_244, vertex_unnamed_198, vertex_unnamed_186));
				float vertex_unnamed_258 = asfloat(vertex_unnamed_257);
				uint vertex_unnamed_259 = vertex_unnamed_213 ? asuint(vertex_unnamed_245) : asuint(mad(vertex_unnamed_245, vertex_unnamed_199, vertex_unnamed_178));
				float vertex_unnamed_260 = asfloat(vertex_unnamed_259);
				bool vertex_unnamed_273 = 0.0f != vertex_uniform_buffer_2[5u].y;
				bool vertex_unnamed_295 = 0.100000001490116119384765625f >= vertex_input_3.y;
				float vertex_unnamed_301 = asfloat(vertex_unnamed_295 ? 0u : asuint(asfloat(vertex_unnamed_273 ? asuint(mad(vertex_unnamed_100, ((-0.0f) - vertex_unnamed_256) + asfloat(vertex_unnamed_213 ? asuint(vertex_unnamed_171) : asuint(mad(vertex_unnamed_171, vertex_unnamed_191, vertex_unnamed_184))), vertex_unnamed_256)) : vertex_unnamed_255) + vertex_input_0.x));
				float vertex_unnamed_303 = asfloat(vertex_unnamed_295 ? 0u : asuint(asfloat(vertex_unnamed_273 ? asuint(mad(vertex_unnamed_100, ((-0.0f) - vertex_unnamed_258) + asfloat(vertex_unnamed_213 ? asuint(vertex_unnamed_172) : asuint(mad(vertex_unnamed_172, vertex_unnamed_198, vertex_unnamed_186))), vertex_unnamed_258)) : vertex_unnamed_257) + vertex_input_0.y));
				float vertex_unnamed_305 = asfloat(vertex_unnamed_295 ? 0u : asuint(asfloat(vertex_unnamed_273 ? asuint(mad(vertex_unnamed_100, ((-0.0f) - vertex_unnamed_260) + asfloat(vertex_unnamed_213 ? asuint(vertex_unnamed_173) : asuint(mad(vertex_unnamed_173, vertex_unnamed_199, vertex_unnamed_178))), vertex_unnamed_260)) : vertex_unnamed_259) + vertex_input_0.z));
				float vertex_unnamed_339 = asfloat(1065353216u);
				float vertex_unnamed_341 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_301, vertex_unnamed_303, vertex_unnamed_305, vertex_unnamed_339));
				float vertex_unnamed_370 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_301, vertex_unnamed_303, vertex_unnamed_305, vertex_unnamed_339));
				float vertex_unnamed_399 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_301, vertex_unnamed_303, vertex_unnamed_305, vertex_unnamed_339));
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_399, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_370, vertex_unnamed_341 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_399, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_370, vertex_unnamed_341 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_399, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_370, vertex_unnamed_341 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_399, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_370, vertex_unnamed_341 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_2[5] = float4(_gameTimeAtFirstFrame, vertex_uniform_buffer_2[5][1], vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], _B_interpolate, vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[6] = float4(_B_autoPlayback, vertex_uniform_buffer_2[6][1], vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _displayFrame, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[12] = float4(_playbackSpeed, vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], _houdiniFPS, vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _frameCount, vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], _boundMaxX);

				vertex_uniform_buffer_2[13] = float4(_boundMaxY, vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], _boundMaxZ, vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _boundMinX, vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], _boundMinY);

				vertex_uniform_buffer_2[14] = float4(_boundMinZ, vertex_uniform_buffer_2[14][1], vertex_uniform_buffer_2[14][2], vertex_uniform_buffer_2[14][3]);

				vertex_input_0 = stage_input.vertex_input_0;
				vertex_input_1 = stage_input.vertex_input_1;
				vertex_input_2 = stage_input.vertex_input_2;
				vertex_input_3 = stage_input.vertex_input_3;
				vert_main();
				Vertex_Stage_Output stage_output;
				stage_output.gl_Position = gl_Position;
				return stage_output;
			}

			#endif // defined(_B_LOAD_COL_TEX) && defined(_DOUBLESIDED_ON) && !defined(_B_LOAD_NORM_TEX)


			#if defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			void frag_main()
			{
			}

			void main()
			{
				frag_main();
			}

			#endif // defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON)


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
			GpuProgramID 321640

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature WRITE_DECAL_BUFFER_AND_RENDERING_LAYER
			#pragma shader_feature _B_LOAD_COL_TEX
			#pragma shader_feature _B_LOAD_NORM_TEX
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_B_LOAD_NORM_TEX)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _TimeParameters;
			float4 _LastTimeParameters;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;
			float4 unity_MotionVectorsParams;
			float _gameTimeAtFirstFrame;
			float _B_interpolate;
			float _B_autoPlayback;
			float _displayFrame;
			float _B_surfaceNormals;
			float _playbackSpeed;
			float _houdiniFPS;
			float _frameCount;
			float _boundMaxX;
			float _boundMaxY;
			float _boundMaxZ;
			float _boundMinX;
			float _boundMinY;
			float _boundMinZ;

			static float4 vertex_uniform_buffer_0[82];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[15];
			Texture2D<float4> _posTexture;
			Texture2D<float4> _rotTexture;
			SamplerState sampler_posTexture;
			SamplerState sampler_rotTexture;

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
			static float3 vertex_output_5;
			static float3 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_input_5 : TEXCOORD4; // TEXCOORD_4
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
				bool vertex_unnamed_58 = 0.100000001490116119384765625f >= vertex_input_4.y;
				bool vertex_unnamed_76 = mad(vertex_uniform_buffer_2[13u].y, 10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[13u].y * 10.0f)) >= 0.5f;
				float vertex_unnamed_94 = (((-0.0f) - mad((-0.0f) - vertex_uniform_buffer_2[14u].x, 10.0f, ceil(vertex_uniform_buffer_2[14u].x * 10.0f))) + 1.0f) * vertex_input_4.x;
				float vertex_unnamed_112 = ((-0.0f) - mad(vertex_uniform_buffer_2[12u].w, -10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[12u].w * (-10.0f)))) + 1.0f;
				float vertex_unnamed_113 = vertex_unnamed_112 * (((-0.0f) - vertex_input_4.y) + 1.0f);
				float vertex_unnamed_132 = vertex_uniform_buffer_2[12u].y / (vertex_uniform_buffer_2[12u].z + (-0.00999999977648258209228515625f));
				float vertex_unnamed_142 = frac((vertex_unnamed_132 * (vertex_uniform_buffer_0[80u].x + ((-0.0f) - vertex_uniform_buffer_2[5u].x))) * vertex_uniform_buffer_2[12u].x) * vertex_uniform_buffer_2[12u].z;
				uint vertex_unnamed_150 = asuint(floor(vertex_uniform_buffer_2[6u].y));
				bool vertex_unnamed_155 = 0.0f != vertex_uniform_buffer_2[6u].x;
				uint vertex_unnamed_159 = (0.0f != vertex_uniform_buffer_2[6u].z) ? 4294967295u : 0u;
				float vertex_unnamed_162 = asfloat(vertex_unnamed_155 ? asuint(floor(vertex_unnamed_142) + 1.0f) : vertex_unnamed_150);
				float vertex_unnamed_168 = (vertex_unnamed_162 + (-1.0f)) / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_172 = frac(abs(vertex_unnamed_168));
				float vertex_unnamed_182 = 1.0f / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_186 = ((-0.0f) - mad(vertex_unnamed_182 * (((vertex_unnamed_168 >= ((-0.0f) - vertex_unnamed_168)) ? vertex_unnamed_172 : ((-0.0f) - vertex_unnamed_172)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_112, vertex_unnamed_113)) + 1.0f;
				float4 vertex_unnamed_189 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_94, vertex_unnamed_186), 0.0f);
				float vertex_unnamed_192 = vertex_unnamed_189.x;
				float vertex_unnamed_193 = vertex_unnamed_189.y;
				float vertex_unnamed_194 = vertex_unnamed_189.z;
				uint4 vertex_unnamed_198 = asuint(vertex_uniform_buffer_2[13u]);
				float vertex_unnamed_200 = asfloat(vertex_unnamed_198.z);
				float vertex_unnamed_202 = asfloat(vertex_unnamed_198.w);
				float vertex_unnamed_207 = asfloat(asuint(vertex_uniform_buffer_2[14u]).x);
				float vertex_unnamed_212 = ((-0.0f) - vertex_unnamed_200) + vertex_uniform_buffer_2[12u].w;
				float vertex_unnamed_219 = ((-0.0f) - vertex_unnamed_202) + vertex_uniform_buffer_2[13u].x;
				float vertex_unnamed_220 = ((-0.0f) - vertex_unnamed_207) + vertex_uniform_buffer_2[13u].y;
				uint vertex_unnamed_230 = vertex_unnamed_76 ? asuint(vertex_unnamed_192) : asuint(mad(vertex_unnamed_192, vertex_unnamed_212, vertex_unnamed_200));
				float vertex_unnamed_231 = asfloat(vertex_unnamed_230);
				uint vertex_unnamed_232 = vertex_unnamed_76 ? asuint(vertex_unnamed_193) : asuint(mad(vertex_unnamed_193, vertex_unnamed_219, vertex_unnamed_202));
				float vertex_unnamed_233 = asfloat(vertex_unnamed_232);
				uint vertex_unnamed_234 = vertex_unnamed_76 ? asuint(vertex_unnamed_194) : asuint(mad(vertex_unnamed_194, vertex_unnamed_220, vertex_unnamed_207));
				float vertex_unnamed_235 = asfloat(vertex_unnamed_234);
				float vertex_unnamed_239 = vertex_unnamed_162 / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_243 = frac(abs(vertex_unnamed_239));
				float vertex_unnamed_253 = ((-0.0f) - mad(vertex_unnamed_182 * (((vertex_unnamed_239 >= ((-0.0f) - vertex_unnamed_239)) ? vertex_unnamed_243 : ((-0.0f) - vertex_unnamed_243)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_112, vertex_unnamed_113)) + 1.0f;
				float4 vertex_unnamed_254 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_94, vertex_unnamed_253), 0.0f);
				float vertex_unnamed_256 = vertex_unnamed_254.x;
				float vertex_unnamed_257 = vertex_unnamed_254.y;
				float vertex_unnamed_258 = vertex_unnamed_254.z;
				float vertex_unnamed_281 = frac(asfloat(vertex_unnamed_155 ? asuint(vertex_unnamed_142) : asuint(vertex_uniform_buffer_2[6u]).y));
				bool vertex_unnamed_294 = 0.0f != vertex_uniform_buffer_2[5u].y;
				float vertex_unnamed_318 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_231) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_256) : asuint(mad(vertex_unnamed_256, vertex_unnamed_212, vertex_unnamed_200))), vertex_unnamed_231)) : vertex_unnamed_230) + vertex_input_0.x));
				float vertex_unnamed_320 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_233) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_257) : asuint(mad(vertex_unnamed_257, vertex_unnamed_219, vertex_unnamed_202))), vertex_unnamed_233)) : vertex_unnamed_232) + vertex_input_0.y));
				float vertex_unnamed_322 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_235) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_258) : asuint(mad(vertex_unnamed_258, vertex_unnamed_220, vertex_unnamed_207))), vertex_unnamed_235)) : vertex_unnamed_234) + vertex_input_0.z));
				float4 vertex_unnamed_324 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_94, vertex_unnamed_186), 0.0f);
				float vertex_unnamed_326 = vertex_unnamed_324.x;
				float vertex_unnamed_327 = vertex_unnamed_324.y;
				float vertex_unnamed_328 = vertex_unnamed_324.z;
				float vertex_unnamed_329 = vertex_unnamed_324.w;
				float vertex_unnamed_330 = vertex_unnamed_326 + (-0.5f);
				float vertex_unnamed_332 = vertex_unnamed_327 + (-0.5f);
				float vertex_unnamed_333 = vertex_unnamed_328 + (-0.5f);
				float vertex_unnamed_334 = vertex_unnamed_329 + (-0.5f);
				float vertex_unnamed_348 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_326) : asuint(vertex_unnamed_330 + vertex_unnamed_330));
				float vertex_unnamed_350 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_327) : asuint(vertex_unnamed_332 + vertex_unnamed_332));
				float vertex_unnamed_352 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_328) : asuint(vertex_unnamed_333 + vertex_unnamed_333));
				float vertex_unnamed_354 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_329) : asuint(vertex_unnamed_334 + vertex_unnamed_334));
				float vertex_unnamed_364 = mad(vertex_unnamed_354, 1.0f, mad(vertex_unnamed_352, 0.0f, (-0.0f) - (vertex_unnamed_348 * 0.0f)));
				float vertex_unnamed_365 = mad(vertex_unnamed_354, 0.0f, mad(vertex_unnamed_348, 1.0f, (-0.0f) - (vertex_unnamed_350 * 0.0f)));
				float vertex_unnamed_366 = mad(vertex_unnamed_354, 0.0f, mad(vertex_unnamed_350, 0.0f, (-0.0f) - (vertex_unnamed_352 * 1.0f)));
				float vertex_unnamed_376 = mad(mad(vertex_unnamed_350, vertex_unnamed_365, (-0.0f) - (vertex_unnamed_352 * vertex_unnamed_364)), 2.0f, 0.0f);
				float vertex_unnamed_378 = mad(mad(vertex_unnamed_352, vertex_unnamed_366, (-0.0f) - (vertex_unnamed_348 * vertex_unnamed_365)), 2.0f, 1.0f);
				float vertex_unnamed_379 = mad(mad(vertex_unnamed_348, vertex_unnamed_364, (-0.0f) - (vertex_unnamed_350 * vertex_unnamed_366)), 2.0f, 0.0f);
				float4 vertex_unnamed_380 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_94, vertex_unnamed_253), 0.0f);
				float vertex_unnamed_382 = vertex_unnamed_380.x;
				float vertex_unnamed_383 = vertex_unnamed_380.y;
				float vertex_unnamed_384 = vertex_unnamed_380.z;
				float vertex_unnamed_385 = vertex_unnamed_380.w;
				float vertex_unnamed_386 = vertex_unnamed_382 + (-0.5f);
				float vertex_unnamed_387 = vertex_unnamed_383 + (-0.5f);
				float vertex_unnamed_388 = vertex_unnamed_384 + (-0.5f);
				float vertex_unnamed_389 = vertex_unnamed_385 + (-0.5f);
				float vertex_unnamed_403 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_382) : asuint(vertex_unnamed_386 + vertex_unnamed_386));
				float vertex_unnamed_405 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_383) : asuint(vertex_unnamed_387 + vertex_unnamed_387));
				float vertex_unnamed_407 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_384) : asuint(vertex_unnamed_388 + vertex_unnamed_388));
				float vertex_unnamed_409 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_385) : asuint(vertex_unnamed_389 + vertex_unnamed_389));
				float vertex_unnamed_419 = mad(vertex_unnamed_409, 1.0f, mad(vertex_unnamed_407, 0.0f, (-0.0f) - (vertex_unnamed_403 * 0.0f)));
				float vertex_unnamed_420 = mad(vertex_unnamed_409, 0.0f, mad(vertex_unnamed_403, 1.0f, (-0.0f) - (vertex_unnamed_405 * 0.0f)));
				float vertex_unnamed_421 = mad(vertex_unnamed_409, 0.0f, mad(vertex_unnamed_405, 0.0f, (-0.0f) - (vertex_unnamed_407 * 1.0f)));
				float vertex_unnamed_450 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_376) + mad(mad(vertex_unnamed_405, vertex_unnamed_420, (-0.0f) - (vertex_unnamed_407 * vertex_unnamed_419)), 2.0f, 0.0f), vertex_unnamed_376)) : asuint(vertex_unnamed_376));
				float vertex_unnamed_452 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_378) + mad(mad(vertex_unnamed_407, vertex_unnamed_421, (-0.0f) - (vertex_unnamed_403 * vertex_unnamed_420)), 2.0f, 1.0f), vertex_unnamed_378)) : asuint(vertex_unnamed_378));
				float vertex_unnamed_454 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_379) + mad(mad(vertex_unnamed_403, vertex_unnamed_419, (-0.0f) - (vertex_unnamed_405 * vertex_unnamed_421)), 2.0f, 0.0f), vertex_unnamed_379)) : asuint(vertex_unnamed_379));
				float vertex_unnamed_458 = rsqrt(dot(float3(vertex_unnamed_450, vertex_unnamed_452, vertex_unnamed_454), float3(vertex_unnamed_450, vertex_unnamed_452, vertex_unnamed_454)));
				float vertex_unnamed_459 = vertex_unnamed_458 * vertex_unnamed_450;
				float vertex_unnamed_460 = vertex_unnamed_458 * vertex_unnamed_452;
				float vertex_unnamed_461 = vertex_unnamed_458 * vertex_unnamed_454;
				float vertex_unnamed_471 = mad(vertex_unnamed_354, 0.0f, mad(vertex_unnamed_352, -1.0f, (-0.0f) - (vertex_unnamed_348 * 0.0f)));
				float vertex_unnamed_472 = mad(vertex_unnamed_354, 0.0f, mad(vertex_unnamed_348, 0.0f, (-0.0f) - (vertex_unnamed_350 * (-1.0f))));
				float vertex_unnamed_473 = mad(vertex_unnamed_354, -1.0f, mad(vertex_unnamed_350, 0.0f, (-0.0f) - (vertex_unnamed_352 * 0.0f)));
				float vertex_unnamed_483 = mad(mad(vertex_unnamed_350, vertex_unnamed_472, (-0.0f) - (vertex_unnamed_352 * vertex_unnamed_471)), 2.0f, -1.0f);
				float vertex_unnamed_484 = mad(mad(vertex_unnamed_352, vertex_unnamed_473, (-0.0f) - (vertex_unnamed_348 * vertex_unnamed_472)), 2.0f, 0.0f);
				float vertex_unnamed_485 = mad(mad(vertex_unnamed_348, vertex_unnamed_471, (-0.0f) - (vertex_unnamed_350 * vertex_unnamed_473)), 2.0f, 0.0f);
				float vertex_unnamed_495 = mad(vertex_unnamed_409, 0.0f, mad(vertex_unnamed_407, -1.0f, (-0.0f) - (vertex_unnamed_403 * 0.0f)));
				float vertex_unnamed_496 = mad(vertex_unnamed_409, 0.0f, mad(vertex_unnamed_403, 0.0f, (-0.0f) - (vertex_unnamed_405 * (-1.0f))));
				float vertex_unnamed_497 = mad(vertex_unnamed_409, -1.0f, mad(vertex_unnamed_405, 0.0f, (-0.0f) - (vertex_unnamed_407 * 0.0f)));
				float vertex_unnamed_526 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_483) + mad(mad(vertex_unnamed_405, vertex_unnamed_496, (-0.0f) - (vertex_unnamed_407 * vertex_unnamed_495)), 2.0f, -1.0f), vertex_unnamed_483)) : asuint(vertex_unnamed_483));
				float vertex_unnamed_528 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_484) + mad(mad(vertex_unnamed_407, vertex_unnamed_497, (-0.0f) - (vertex_unnamed_403 * vertex_unnamed_496)), 2.0f, 0.0f), vertex_unnamed_484)) : asuint(vertex_unnamed_484));
				float vertex_unnamed_530 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_485) + mad(mad(vertex_unnamed_403, vertex_unnamed_495, (-0.0f) - (vertex_unnamed_405 * vertex_unnamed_497)), 2.0f, 0.0f), vertex_unnamed_485)) : asuint(vertex_unnamed_485));
				float vertex_unnamed_534 = rsqrt(dot(float3(vertex_unnamed_526, vertex_unnamed_528, vertex_unnamed_530), float3(vertex_unnamed_526, vertex_unnamed_528, vertex_unnamed_530)));
				float vertex_unnamed_542 = asfloat(vertex_unnamed_159 & asuint(vertex_unnamed_534 * vertex_unnamed_526));
				float vertex_unnamed_544 = asfloat(vertex_unnamed_159 & asuint(vertex_unnamed_534 * vertex_unnamed_528));
				float vertex_unnamed_546 = asfloat(vertex_unnamed_159 & asuint(vertex_unnamed_534 * vertex_unnamed_530));
				float vertex_unnamed_580 = asfloat(1065353216u);
				float vertex_unnamed_582 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_318, vertex_unnamed_320, vertex_unnamed_322, vertex_unnamed_580));
				float vertex_unnamed_600 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_318, vertex_unnamed_320, vertex_unnamed_322, vertex_unnamed_580));
				float vertex_unnamed_618 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_318, vertex_unnamed_320, vertex_unnamed_322, vertex_unnamed_580));
				float vertex_unnamed_627 = dot(float3(vertex_unnamed_459, vertex_unnamed_460, vertex_unnamed_461), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_635 = dot(float3(vertex_unnamed_459, vertex_unnamed_460, vertex_unnamed_461), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_643 = dot(float3(vertex_unnamed_459, vertex_unnamed_460, vertex_unnamed_461), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_651 = rsqrt(max(dot(float3(vertex_unnamed_627, vertex_unnamed_635, vertex_unnamed_643), float3(vertex_unnamed_627, vertex_unnamed_635, vertex_unnamed_643)), 1.1754943508222875079687365372222e-38f));
				vertex_output_6.x = vertex_unnamed_651 * vertex_unnamed_627;
				vertex_output_6.y = vertex_unnamed_651 * vertex_unnamed_635;
				vertex_output_6.z = vertex_unnamed_651 * vertex_unnamed_643;
				float vertex_unnamed_680 = mad(vertex_uniform_buffer_1[2u].x, vertex_unnamed_546, mad(vertex_uniform_buffer_1[0u].x, vertex_unnamed_542, vertex_unnamed_544 * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_681 = mad(vertex_uniform_buffer_1[2u].y, vertex_unnamed_546, mad(vertex_uniform_buffer_1[0u].y, vertex_unnamed_542, vertex_unnamed_544 * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_682 = mad(vertex_uniform_buffer_1[2u].z, vertex_unnamed_546, mad(vertex_uniform_buffer_1[0u].z, vertex_unnamed_542, vertex_unnamed_544 * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_687 = rsqrt(max(dot(float3(vertex_unnamed_680, vertex_unnamed_681, vertex_unnamed_682), float3(vertex_unnamed_680, vertex_unnamed_681, vertex_unnamed_682)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_687 * vertex_unnamed_680;
				vertex_output_3.y = vertex_unnamed_687 * vertex_unnamed_681;
				vertex_output_3.z = vertex_unnamed_687 * vertex_unnamed_682;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_618, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_618, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_618, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_618, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_618, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_618, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_618, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_792 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_826 = frac((vertex_unnamed_132 * (vertex_uniform_buffer_0[81u].x + ((-0.0f) - vertex_uniform_buffer_2[5u].x))) * vertex_uniform_buffer_2[12u].x) * vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_831 = asfloat(vertex_unnamed_155 ? asuint(floor(vertex_unnamed_826) + 1.0f) : vertex_unnamed_150);
					float vertex_unnamed_836 = (vertex_unnamed_831 + (-1.0f)) / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_840 = frac(abs(vertex_unnamed_836));
					float4 vertex_unnamed_852 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_94, ((-0.0f) - mad(vertex_unnamed_182 * (((vertex_unnamed_836 >= ((-0.0f) - vertex_unnamed_836)) ? vertex_unnamed_840 : ((-0.0f) - vertex_unnamed_840)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_112, vertex_unnamed_113)) + 1.0f), 0.0f);
					float vertex_unnamed_854 = vertex_unnamed_852.x;
					float vertex_unnamed_855 = vertex_unnamed_852.y;
					float vertex_unnamed_856 = vertex_unnamed_852.z;
					uint vertex_unnamed_866 = vertex_unnamed_76 ? asuint(vertex_unnamed_854) : asuint(mad(vertex_unnamed_854, vertex_unnamed_212, vertex_unnamed_200));
					float vertex_unnamed_867 = asfloat(vertex_unnamed_866);
					uint vertex_unnamed_868 = vertex_unnamed_76 ? asuint(vertex_unnamed_855) : asuint(mad(vertex_unnamed_855, vertex_unnamed_219, vertex_unnamed_202));
					float vertex_unnamed_869 = asfloat(vertex_unnamed_868);
					uint vertex_unnamed_870 = vertex_unnamed_76 ? asuint(vertex_unnamed_856) : asuint(mad(vertex_unnamed_856, vertex_unnamed_220, vertex_unnamed_207));
					float vertex_unnamed_871 = asfloat(vertex_unnamed_870);
					float vertex_unnamed_875 = vertex_unnamed_831 / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_879 = frac(abs(vertex_unnamed_875));
					float4 vertex_unnamed_890 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_94, ((-0.0f) - mad(vertex_unnamed_182 * (((vertex_unnamed_875 >= ((-0.0f) - vertex_unnamed_875)) ? vertex_unnamed_879 : ((-0.0f) - vertex_unnamed_879)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_112, vertex_unnamed_113)) + 1.0f), 0.0f);
					float vertex_unnamed_892 = vertex_unnamed_890.x;
					float vertex_unnamed_893 = vertex_unnamed_890.y;
					float vertex_unnamed_894 = vertex_unnamed_890.z;
					float vertex_unnamed_917 = frac(asfloat(vertex_unnamed_155 ? asuint(vertex_unnamed_826) : asuint(vertex_uniform_buffer_2[6u]).y));
					float vertex_unnamed_943 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_917, ((-0.0f) - vertex_unnamed_867) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_892) : asuint(mad(vertex_unnamed_892, vertex_unnamed_212, vertex_unnamed_200))), vertex_unnamed_867)) : vertex_unnamed_866) + (vertex_unnamed_792 ? vertex_input_5.x : vertex_input_0.x)));
					float vertex_unnamed_945 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_917, ((-0.0f) - vertex_unnamed_869) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_893) : asuint(mad(vertex_unnamed_893, vertex_unnamed_219, vertex_unnamed_202))), vertex_unnamed_869)) : vertex_unnamed_868) + (vertex_unnamed_792 ? vertex_input_5.y : vertex_input_0.y)));
					float vertex_unnamed_947 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_917, ((-0.0f) - vertex_unnamed_871) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_894) : asuint(mad(vertex_unnamed_894, vertex_unnamed_220, vertex_unnamed_207))), vertex_unnamed_871)) : vertex_unnamed_870) + (vertex_unnamed_792 ? vertex_input_5.z : vertex_input_0.z)));
					float vertex_unnamed_981 = asfloat(1065353216u);
					float vertex_unnamed_982 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_943, vertex_unnamed_945, vertex_unnamed_947, vertex_unnamed_981));
					float vertex_unnamed_1000 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_943, vertex_unnamed_945, vertex_unnamed_947, vertex_unnamed_981));
					float vertex_unnamed_1018 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_943, vertex_unnamed_945, vertex_unnamed_947, vertex_unnamed_981));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_1018, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_982, vertex_unnamed_1000 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_1018, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_982, vertex_unnamed_1000 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_1018, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_982, vertex_unnamed_1000 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_input_3.x;
				vertex_output_4.y = vertex_input_3.y;
				vertex_output_4.z = vertex_input_3.z;
				vertex_output_4.w = vertex_input_3.w;
				vertex_output_5.x = vertex_unnamed_582;
				vertex_output_5.y = vertex_unnamed_600;
				vertex_output_5.z = vertex_unnamed_618;
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

				vertex_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				vertex_uniform_buffer_0[81] = float4(_LastTimeParameters[0], _LastTimeParameters[1], _LastTimeParameters[2], _LastTimeParameters[3]);

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

				vertex_uniform_buffer_2[5] = float4(_gameTimeAtFirstFrame, vertex_uniform_buffer_2[5][1], vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], _B_interpolate, vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[6] = float4(_B_autoPlayback, vertex_uniform_buffer_2[6][1], vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _displayFrame, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], vertex_uniform_buffer_2[6][1], _B_surfaceNormals, vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[12] = float4(_playbackSpeed, vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], _houdiniFPS, vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _frameCount, vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], _boundMaxX);

				vertex_uniform_buffer_2[13] = float4(_boundMaxY, vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], _boundMaxZ, vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _boundMinX, vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], _boundMinY);

				vertex_uniform_buffer_2[14] = float4(_boundMinZ, vertex_uniform_buffer_2[14][1], vertex_uniform_buffer_2[14][2], vertex_uniform_buffer_2[14][3]);

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

			#endif // !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_B_LOAD_NORM_TEX)


			#if defined(_B_LOAD_COL_TEX) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_B_LOAD_NORM_TEX)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4x4 _NonJitteredViewProjMatrix;
			float4x4 _PrevViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _TimeParameters;
			float4 _LastTimeParameters;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float4x4 unity_MatrixPreviousM;
			float4 unity_MotionVectorsParams;
			float _gameTimeAtFirstFrame;
			float _B_interpolate;
			float _B_autoPlayback;
			float _displayFrame;
			float _B_surfaceNormals;
			float _playbackSpeed;
			float _houdiniFPS;
			float _frameCount;
			float _boundMaxX;
			float _boundMaxY;
			float _boundMaxZ;
			float _boundMinX;
			float _boundMinY;
			float _boundMinZ;

			static float4 vertex_uniform_buffer_0[82];
			static float4 vertex_uniform_buffer_1[39];
			static float4 vertex_uniform_buffer_2[15];
			Texture2D<float4> _posTexture;
			Texture2D<float4> _rotTexture;
			SamplerState sampler_posTexture;
			SamplerState sampler_rotTexture;

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
			static float3 vertex_output_5;
			static float3 vertex_output_6;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
				float3 vertex_input_5 : TEXCOORD4; // TEXCOORD_4
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
				bool vertex_unnamed_58 = 0.100000001490116119384765625f >= vertex_input_4.y;
				bool vertex_unnamed_76 = mad(vertex_uniform_buffer_2[13u].y, 10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[13u].y * 10.0f)) >= 0.5f;
				float vertex_unnamed_94 = (((-0.0f) - mad((-0.0f) - vertex_uniform_buffer_2[14u].x, 10.0f, ceil(vertex_uniform_buffer_2[14u].x * 10.0f))) + 1.0f) * vertex_input_4.x;
				float vertex_unnamed_112 = ((-0.0f) - mad(vertex_uniform_buffer_2[12u].w, -10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[12u].w * (-10.0f)))) + 1.0f;
				float vertex_unnamed_113 = vertex_unnamed_112 * (((-0.0f) - vertex_input_4.y) + 1.0f);
				float vertex_unnamed_132 = vertex_uniform_buffer_2[12u].y / (vertex_uniform_buffer_2[12u].z + (-0.00999999977648258209228515625f));
				float vertex_unnamed_142 = frac((vertex_unnamed_132 * (vertex_uniform_buffer_0[80u].x + ((-0.0f) - vertex_uniform_buffer_2[5u].x))) * vertex_uniform_buffer_2[12u].x) * vertex_uniform_buffer_2[12u].z;
				uint vertex_unnamed_150 = asuint(floor(vertex_uniform_buffer_2[6u].y));
				bool vertex_unnamed_155 = 0.0f != vertex_uniform_buffer_2[6u].x;
				uint vertex_unnamed_159 = (0.0f != vertex_uniform_buffer_2[6u].z) ? 4294967295u : 0u;
				float vertex_unnamed_162 = asfloat(vertex_unnamed_155 ? asuint(floor(vertex_unnamed_142) + 1.0f) : vertex_unnamed_150);
				float vertex_unnamed_168 = (vertex_unnamed_162 + (-1.0f)) / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_172 = frac(abs(vertex_unnamed_168));
				float vertex_unnamed_182 = 1.0f / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_186 = ((-0.0f) - mad(vertex_unnamed_182 * (((vertex_unnamed_168 >= ((-0.0f) - vertex_unnamed_168)) ? vertex_unnamed_172 : ((-0.0f) - vertex_unnamed_172)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_112, vertex_unnamed_113)) + 1.0f;
				float4 vertex_unnamed_189 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_94, vertex_unnamed_186), 0.0f);
				float vertex_unnamed_192 = vertex_unnamed_189.x;
				float vertex_unnamed_193 = vertex_unnamed_189.y;
				float vertex_unnamed_194 = vertex_unnamed_189.z;
				uint4 vertex_unnamed_198 = asuint(vertex_uniform_buffer_2[13u]);
				float vertex_unnamed_200 = asfloat(vertex_unnamed_198.z);
				float vertex_unnamed_202 = asfloat(vertex_unnamed_198.w);
				float vertex_unnamed_207 = asfloat(asuint(vertex_uniform_buffer_2[14u]).x);
				float vertex_unnamed_212 = ((-0.0f) - vertex_unnamed_200) + vertex_uniform_buffer_2[12u].w;
				float vertex_unnamed_219 = ((-0.0f) - vertex_unnamed_202) + vertex_uniform_buffer_2[13u].x;
				float vertex_unnamed_220 = ((-0.0f) - vertex_unnamed_207) + vertex_uniform_buffer_2[13u].y;
				uint vertex_unnamed_230 = vertex_unnamed_76 ? asuint(vertex_unnamed_192) : asuint(mad(vertex_unnamed_192, vertex_unnamed_212, vertex_unnamed_200));
				float vertex_unnamed_231 = asfloat(vertex_unnamed_230);
				uint vertex_unnamed_232 = vertex_unnamed_76 ? asuint(vertex_unnamed_193) : asuint(mad(vertex_unnamed_193, vertex_unnamed_219, vertex_unnamed_202));
				float vertex_unnamed_233 = asfloat(vertex_unnamed_232);
				uint vertex_unnamed_234 = vertex_unnamed_76 ? asuint(vertex_unnamed_194) : asuint(mad(vertex_unnamed_194, vertex_unnamed_220, vertex_unnamed_207));
				float vertex_unnamed_235 = asfloat(vertex_unnamed_234);
				float vertex_unnamed_239 = vertex_unnamed_162 / vertex_uniform_buffer_2[12u].z;
				float vertex_unnamed_243 = frac(abs(vertex_unnamed_239));
				float vertex_unnamed_253 = ((-0.0f) - mad(vertex_unnamed_182 * (((vertex_unnamed_239 >= ((-0.0f) - vertex_unnamed_239)) ? vertex_unnamed_243 : ((-0.0f) - vertex_unnamed_243)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_112, vertex_unnamed_113)) + 1.0f;
				float4 vertex_unnamed_254 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_94, vertex_unnamed_253), 0.0f);
				float vertex_unnamed_256 = vertex_unnamed_254.x;
				float vertex_unnamed_257 = vertex_unnamed_254.y;
				float vertex_unnamed_258 = vertex_unnamed_254.z;
				float vertex_unnamed_281 = frac(asfloat(vertex_unnamed_155 ? asuint(vertex_unnamed_142) : asuint(vertex_uniform_buffer_2[6u]).y));
				bool vertex_unnamed_294 = 0.0f != vertex_uniform_buffer_2[5u].y;
				float vertex_unnamed_318 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_231) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_256) : asuint(mad(vertex_unnamed_256, vertex_unnamed_212, vertex_unnamed_200))), vertex_unnamed_231)) : vertex_unnamed_230) + vertex_input_0.x));
				float vertex_unnamed_320 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_233) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_257) : asuint(mad(vertex_unnamed_257, vertex_unnamed_219, vertex_unnamed_202))), vertex_unnamed_233)) : vertex_unnamed_232) + vertex_input_0.y));
				float vertex_unnamed_322 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_235) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_258) : asuint(mad(vertex_unnamed_258, vertex_unnamed_220, vertex_unnamed_207))), vertex_unnamed_235)) : vertex_unnamed_234) + vertex_input_0.z));
				float4 vertex_unnamed_324 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_94, vertex_unnamed_186), 0.0f);
				float vertex_unnamed_326 = vertex_unnamed_324.x;
				float vertex_unnamed_327 = vertex_unnamed_324.y;
				float vertex_unnamed_328 = vertex_unnamed_324.z;
				float vertex_unnamed_329 = vertex_unnamed_324.w;
				float vertex_unnamed_330 = vertex_unnamed_326 + (-0.5f);
				float vertex_unnamed_332 = vertex_unnamed_327 + (-0.5f);
				float vertex_unnamed_333 = vertex_unnamed_328 + (-0.5f);
				float vertex_unnamed_334 = vertex_unnamed_329 + (-0.5f);
				float vertex_unnamed_348 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_326) : asuint(vertex_unnamed_330 + vertex_unnamed_330));
				float vertex_unnamed_350 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_327) : asuint(vertex_unnamed_332 + vertex_unnamed_332));
				float vertex_unnamed_352 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_328) : asuint(vertex_unnamed_333 + vertex_unnamed_333));
				float vertex_unnamed_354 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_329) : asuint(vertex_unnamed_334 + vertex_unnamed_334));
				float vertex_unnamed_364 = mad(vertex_unnamed_354, 1.0f, mad(vertex_unnamed_352, 0.0f, (-0.0f) - (vertex_unnamed_348 * 0.0f)));
				float vertex_unnamed_365 = mad(vertex_unnamed_354, 0.0f, mad(vertex_unnamed_348, 1.0f, (-0.0f) - (vertex_unnamed_350 * 0.0f)));
				float vertex_unnamed_366 = mad(vertex_unnamed_354, 0.0f, mad(vertex_unnamed_350, 0.0f, (-0.0f) - (vertex_unnamed_352 * 1.0f)));
				float vertex_unnamed_376 = mad(mad(vertex_unnamed_350, vertex_unnamed_365, (-0.0f) - (vertex_unnamed_352 * vertex_unnamed_364)), 2.0f, 0.0f);
				float vertex_unnamed_378 = mad(mad(vertex_unnamed_352, vertex_unnamed_366, (-0.0f) - (vertex_unnamed_348 * vertex_unnamed_365)), 2.0f, 1.0f);
				float vertex_unnamed_379 = mad(mad(vertex_unnamed_348, vertex_unnamed_364, (-0.0f) - (vertex_unnamed_350 * vertex_unnamed_366)), 2.0f, 0.0f);
				float4 vertex_unnamed_380 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_94, vertex_unnamed_253), 0.0f);
				float vertex_unnamed_382 = vertex_unnamed_380.x;
				float vertex_unnamed_383 = vertex_unnamed_380.y;
				float vertex_unnamed_384 = vertex_unnamed_380.z;
				float vertex_unnamed_385 = vertex_unnamed_380.w;
				float vertex_unnamed_386 = vertex_unnamed_382 + (-0.5f);
				float vertex_unnamed_387 = vertex_unnamed_383 + (-0.5f);
				float vertex_unnamed_388 = vertex_unnamed_384 + (-0.5f);
				float vertex_unnamed_389 = vertex_unnamed_385 + (-0.5f);
				float vertex_unnamed_403 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_382) : asuint(vertex_unnamed_386 + vertex_unnamed_386));
				float vertex_unnamed_405 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_383) : asuint(vertex_unnamed_387 + vertex_unnamed_387));
				float vertex_unnamed_407 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_384) : asuint(vertex_unnamed_388 + vertex_unnamed_388));
				float vertex_unnamed_409 = asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_385) : asuint(vertex_unnamed_389 + vertex_unnamed_389));
				float vertex_unnamed_419 = mad(vertex_unnamed_409, 1.0f, mad(vertex_unnamed_407, 0.0f, (-0.0f) - (vertex_unnamed_403 * 0.0f)));
				float vertex_unnamed_420 = mad(vertex_unnamed_409, 0.0f, mad(vertex_unnamed_403, 1.0f, (-0.0f) - (vertex_unnamed_405 * 0.0f)));
				float vertex_unnamed_421 = mad(vertex_unnamed_409, 0.0f, mad(vertex_unnamed_405, 0.0f, (-0.0f) - (vertex_unnamed_407 * 1.0f)));
				float vertex_unnamed_450 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_376) + mad(mad(vertex_unnamed_405, vertex_unnamed_420, (-0.0f) - (vertex_unnamed_407 * vertex_unnamed_419)), 2.0f, 0.0f), vertex_unnamed_376)) : asuint(vertex_unnamed_376));
				float vertex_unnamed_452 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_378) + mad(mad(vertex_unnamed_407, vertex_unnamed_421, (-0.0f) - (vertex_unnamed_403 * vertex_unnamed_420)), 2.0f, 1.0f), vertex_unnamed_378)) : asuint(vertex_unnamed_378));
				float vertex_unnamed_454 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_379) + mad(mad(vertex_unnamed_403, vertex_unnamed_419, (-0.0f) - (vertex_unnamed_405 * vertex_unnamed_421)), 2.0f, 0.0f), vertex_unnamed_379)) : asuint(vertex_unnamed_379));
				float vertex_unnamed_458 = rsqrt(dot(float3(vertex_unnamed_450, vertex_unnamed_452, vertex_unnamed_454), float3(vertex_unnamed_450, vertex_unnamed_452, vertex_unnamed_454)));
				float vertex_unnamed_459 = vertex_unnamed_458 * vertex_unnamed_450;
				float vertex_unnamed_460 = vertex_unnamed_458 * vertex_unnamed_452;
				float vertex_unnamed_461 = vertex_unnamed_458 * vertex_unnamed_454;
				float vertex_unnamed_471 = mad(vertex_unnamed_354, 0.0f, mad(vertex_unnamed_352, -1.0f, (-0.0f) - (vertex_unnamed_348 * 0.0f)));
				float vertex_unnamed_472 = mad(vertex_unnamed_354, 0.0f, mad(vertex_unnamed_348, 0.0f, (-0.0f) - (vertex_unnamed_350 * (-1.0f))));
				float vertex_unnamed_473 = mad(vertex_unnamed_354, -1.0f, mad(vertex_unnamed_350, 0.0f, (-0.0f) - (vertex_unnamed_352 * 0.0f)));
				float vertex_unnamed_483 = mad(mad(vertex_unnamed_350, vertex_unnamed_472, (-0.0f) - (vertex_unnamed_352 * vertex_unnamed_471)), 2.0f, -1.0f);
				float vertex_unnamed_484 = mad(mad(vertex_unnamed_352, vertex_unnamed_473, (-0.0f) - (vertex_unnamed_348 * vertex_unnamed_472)), 2.0f, 0.0f);
				float vertex_unnamed_485 = mad(mad(vertex_unnamed_348, vertex_unnamed_471, (-0.0f) - (vertex_unnamed_350 * vertex_unnamed_473)), 2.0f, 0.0f);
				float vertex_unnamed_495 = mad(vertex_unnamed_409, 0.0f, mad(vertex_unnamed_407, -1.0f, (-0.0f) - (vertex_unnamed_403 * 0.0f)));
				float vertex_unnamed_496 = mad(vertex_unnamed_409, 0.0f, mad(vertex_unnamed_403, 0.0f, (-0.0f) - (vertex_unnamed_405 * (-1.0f))));
				float vertex_unnamed_497 = mad(vertex_unnamed_409, -1.0f, mad(vertex_unnamed_405, 0.0f, (-0.0f) - (vertex_unnamed_407 * 0.0f)));
				float vertex_unnamed_526 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_483) + mad(mad(vertex_unnamed_405, vertex_unnamed_496, (-0.0f) - (vertex_unnamed_407 * vertex_unnamed_495)), 2.0f, -1.0f), vertex_unnamed_483)) : asuint(vertex_unnamed_483));
				float vertex_unnamed_528 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_484) + mad(mad(vertex_unnamed_407, vertex_unnamed_497, (-0.0f) - (vertex_unnamed_403 * vertex_unnamed_496)), 2.0f, 0.0f), vertex_unnamed_484)) : asuint(vertex_unnamed_484));
				float vertex_unnamed_530 = asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_281, ((-0.0f) - vertex_unnamed_485) + mad(mad(vertex_unnamed_403, vertex_unnamed_495, (-0.0f) - (vertex_unnamed_405 * vertex_unnamed_497)), 2.0f, 0.0f), vertex_unnamed_485)) : asuint(vertex_unnamed_485));
				float vertex_unnamed_534 = rsqrt(dot(float3(vertex_unnamed_526, vertex_unnamed_528, vertex_unnamed_530), float3(vertex_unnamed_526, vertex_unnamed_528, vertex_unnamed_530)));
				float vertex_unnamed_542 = asfloat(vertex_unnamed_159 & asuint(vertex_unnamed_534 * vertex_unnamed_526));
				float vertex_unnamed_544 = asfloat(vertex_unnamed_159 & asuint(vertex_unnamed_534 * vertex_unnamed_528));
				float vertex_unnamed_546 = asfloat(vertex_unnamed_159 & asuint(vertex_unnamed_534 * vertex_unnamed_530));
				float vertex_unnamed_580 = asfloat(1065353216u);
				float vertex_unnamed_582 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_318, vertex_unnamed_320, vertex_unnamed_322, vertex_unnamed_580));
				float vertex_unnamed_600 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_318, vertex_unnamed_320, vertex_unnamed_322, vertex_unnamed_580));
				float vertex_unnamed_618 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_318, vertex_unnamed_320, vertex_unnamed_322, vertex_unnamed_580));
				float vertex_unnamed_627 = dot(float3(vertex_unnamed_459, vertex_unnamed_460, vertex_unnamed_461), float3(vertex_uniform_buffer_1[4u].xyz));
				float vertex_unnamed_635 = dot(float3(vertex_unnamed_459, vertex_unnamed_460, vertex_unnamed_461), float3(vertex_uniform_buffer_1[5u].xyz));
				float vertex_unnamed_643 = dot(float3(vertex_unnamed_459, vertex_unnamed_460, vertex_unnamed_461), float3(vertex_uniform_buffer_1[6u].xyz));
				float vertex_unnamed_651 = rsqrt(max(dot(float3(vertex_unnamed_627, vertex_unnamed_635, vertex_unnamed_643), float3(vertex_unnamed_627, vertex_unnamed_635, vertex_unnamed_643)), 1.1754943508222875079687365372222e-38f));
				vertex_output_6.x = vertex_unnamed_651 * vertex_unnamed_627;
				vertex_output_6.y = vertex_unnamed_651 * vertex_unnamed_635;
				vertex_output_6.z = vertex_unnamed_651 * vertex_unnamed_643;
				float vertex_unnamed_680 = mad(vertex_uniform_buffer_1[2u].x, vertex_unnamed_546, mad(vertex_uniform_buffer_1[0u].x, vertex_unnamed_542, vertex_unnamed_544 * vertex_uniform_buffer_1[1u].x));
				float vertex_unnamed_681 = mad(vertex_uniform_buffer_1[2u].y, vertex_unnamed_546, mad(vertex_uniform_buffer_1[0u].y, vertex_unnamed_542, vertex_unnamed_544 * vertex_uniform_buffer_1[1u].y));
				float vertex_unnamed_682 = mad(vertex_uniform_buffer_1[2u].z, vertex_unnamed_546, mad(vertex_uniform_buffer_1[0u].z, vertex_unnamed_542, vertex_unnamed_544 * vertex_uniform_buffer_1[1u].z));
				float vertex_unnamed_687 = rsqrt(max(dot(float3(vertex_unnamed_680, vertex_unnamed_681, vertex_unnamed_682), float3(vertex_unnamed_680, vertex_unnamed_681, vertex_unnamed_682)), 1.1754943508222875079687365372222e-38f));
				vertex_output_3.x = vertex_unnamed_687 * vertex_unnamed_680;
				vertex_output_3.y = vertex_unnamed_687 * vertex_unnamed_681;
				vertex_output_3.z = vertex_unnamed_687 * vertex_unnamed_682;
				gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_618, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
				gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_618, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
				gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_618, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
				gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_618, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
				vertex_output_0.x = mad(vertex_uniform_buffer_0[34u].x, vertex_unnamed_618, mad(vertex_uniform_buffer_0[32u].x, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[33u].x)) + vertex_uniform_buffer_0[35u].x;
				vertex_output_0.y = mad(vertex_uniform_buffer_0[34u].y, vertex_unnamed_618, mad(vertex_uniform_buffer_0[32u].y, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[33u].y)) + vertex_uniform_buffer_0[35u].y;
				vertex_output_0.z = mad(vertex_uniform_buffer_0[34u].w, vertex_unnamed_618, mad(vertex_uniform_buffer_0[32u].w, vertex_unnamed_582, vertex_unnamed_600 * vertex_uniform_buffer_0[33u].w)) + vertex_uniform_buffer_0[35u].w;
				if (vertex_uniform_buffer_1[38u].y == 0.0f)
				{
					vertex_output_1.x = 0.0f;
					vertex_output_1.y = 0.0f;
					vertex_output_1.z = 1.0f;
				}
				else
				{
					bool vertex_unnamed_792 = 0.0f < vertex_uniform_buffer_1[38u].x;
					float vertex_unnamed_826 = frac((vertex_unnamed_132 * (vertex_uniform_buffer_0[81u].x + ((-0.0f) - vertex_uniform_buffer_2[5u].x))) * vertex_uniform_buffer_2[12u].x) * vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_831 = asfloat(vertex_unnamed_155 ? asuint(floor(vertex_unnamed_826) + 1.0f) : vertex_unnamed_150);
					float vertex_unnamed_836 = (vertex_unnamed_831 + (-1.0f)) / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_840 = frac(abs(vertex_unnamed_836));
					float4 vertex_unnamed_852 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_94, ((-0.0f) - mad(vertex_unnamed_182 * (((vertex_unnamed_836 >= ((-0.0f) - vertex_unnamed_836)) ? vertex_unnamed_840 : ((-0.0f) - vertex_unnamed_840)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_112, vertex_unnamed_113)) + 1.0f), 0.0f);
					float vertex_unnamed_854 = vertex_unnamed_852.x;
					float vertex_unnamed_855 = vertex_unnamed_852.y;
					float vertex_unnamed_856 = vertex_unnamed_852.z;
					uint vertex_unnamed_866 = vertex_unnamed_76 ? asuint(vertex_unnamed_854) : asuint(mad(vertex_unnamed_854, vertex_unnamed_212, vertex_unnamed_200));
					float vertex_unnamed_867 = asfloat(vertex_unnamed_866);
					uint vertex_unnamed_868 = vertex_unnamed_76 ? asuint(vertex_unnamed_855) : asuint(mad(vertex_unnamed_855, vertex_unnamed_219, vertex_unnamed_202));
					float vertex_unnamed_869 = asfloat(vertex_unnamed_868);
					uint vertex_unnamed_870 = vertex_unnamed_76 ? asuint(vertex_unnamed_856) : asuint(mad(vertex_unnamed_856, vertex_unnamed_220, vertex_unnamed_207));
					float vertex_unnamed_871 = asfloat(vertex_unnamed_870);
					float vertex_unnamed_875 = vertex_unnamed_831 / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_879 = frac(abs(vertex_unnamed_875));
					float4 vertex_unnamed_890 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_94, ((-0.0f) - mad(vertex_unnamed_182 * (((vertex_unnamed_875 >= ((-0.0f) - vertex_unnamed_875)) ? vertex_unnamed_879 : ((-0.0f) - vertex_unnamed_879)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_112, vertex_unnamed_113)) + 1.0f), 0.0f);
					float vertex_unnamed_892 = vertex_unnamed_890.x;
					float vertex_unnamed_893 = vertex_unnamed_890.y;
					float vertex_unnamed_894 = vertex_unnamed_890.z;
					float vertex_unnamed_917 = frac(asfloat(vertex_unnamed_155 ? asuint(vertex_unnamed_826) : asuint(vertex_uniform_buffer_2[6u]).y));
					float vertex_unnamed_943 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_917, ((-0.0f) - vertex_unnamed_867) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_892) : asuint(mad(vertex_unnamed_892, vertex_unnamed_212, vertex_unnamed_200))), vertex_unnamed_867)) : vertex_unnamed_866) + (vertex_unnamed_792 ? vertex_input_5.x : vertex_input_0.x)));
					float vertex_unnamed_945 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_917, ((-0.0f) - vertex_unnamed_869) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_893) : asuint(mad(vertex_unnamed_893, vertex_unnamed_219, vertex_unnamed_202))), vertex_unnamed_869)) : vertex_unnamed_868) + (vertex_unnamed_792 ? vertex_input_5.y : vertex_input_0.y)));
					float vertex_unnamed_947 = asfloat(vertex_unnamed_58 ? 0u : asuint(asfloat(vertex_unnamed_294 ? asuint(mad(vertex_unnamed_917, ((-0.0f) - vertex_unnamed_871) + asfloat(vertex_unnamed_76 ? asuint(vertex_unnamed_894) : asuint(mad(vertex_unnamed_894, vertex_unnamed_220, vertex_unnamed_207))), vertex_unnamed_871)) : vertex_unnamed_870) + (vertex_unnamed_792 ? vertex_input_5.z : vertex_input_0.z)));
					float vertex_unnamed_981 = asfloat(1065353216u);
					float vertex_unnamed_982 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).x), asfloat(asuint(vertex_uniform_buffer_1[31u]).x), asfloat(asuint(vertex_uniform_buffer_1[32u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[33u].x), float4(vertex_unnamed_943, vertex_unnamed_945, vertex_unnamed_947, vertex_unnamed_981));
					float vertex_unnamed_1000 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).y), asfloat(asuint(vertex_uniform_buffer_1[31u]).y), asfloat(asuint(vertex_uniform_buffer_1[32u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[33u].y), float4(vertex_unnamed_943, vertex_unnamed_945, vertex_unnamed_947, vertex_unnamed_981));
					float vertex_unnamed_1018 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[30u]).z), asfloat(asuint(vertex_uniform_buffer_1[31u]).z), asfloat(asuint(vertex_uniform_buffer_1[32u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[33u].z), float4(vertex_unnamed_943, vertex_unnamed_945, vertex_unnamed_947, vertex_unnamed_981));
					vertex_output_1.x = mad(vertex_uniform_buffer_0[42u].x, vertex_unnamed_1018, mad(vertex_uniform_buffer_0[40u].x, vertex_unnamed_982, vertex_unnamed_1000 * vertex_uniform_buffer_0[41u].x)) + vertex_uniform_buffer_0[43u].x;
					vertex_output_1.y = mad(vertex_uniform_buffer_0[42u].y, vertex_unnamed_1018, mad(vertex_uniform_buffer_0[40u].y, vertex_unnamed_982, vertex_unnamed_1000 * vertex_uniform_buffer_0[41u].y)) + vertex_uniform_buffer_0[43u].y;
					vertex_output_1.z = mad(vertex_uniform_buffer_0[42u].w, vertex_unnamed_1018, mad(vertex_uniform_buffer_0[40u].w, vertex_unnamed_982, vertex_unnamed_1000 * vertex_uniform_buffer_0[41u].w)) + vertex_uniform_buffer_0[43u].w;
				}
				vertex_output_3.w = vertex_input_2.w;
				vertex_output_4.x = vertex_input_3.x;
				vertex_output_4.y = vertex_input_3.y;
				vertex_output_4.z = vertex_input_3.z;
				vertex_output_4.w = vertex_input_3.w;
				vertex_output_5.x = vertex_unnamed_582;
				vertex_output_5.y = vertex_unnamed_600;
				vertex_output_5.z = vertex_unnamed_618;
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

				vertex_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				vertex_uniform_buffer_0[81] = float4(_LastTimeParameters[0], _LastTimeParameters[1], _LastTimeParameters[2], _LastTimeParameters[3]);

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

				vertex_uniform_buffer_2[5] = float4(_gameTimeAtFirstFrame, vertex_uniform_buffer_2[5][1], vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], _B_interpolate, vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[6] = float4(_B_autoPlayback, vertex_uniform_buffer_2[6][1], vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _displayFrame, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], vertex_uniform_buffer_2[6][1], _B_surfaceNormals, vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[12] = float4(_playbackSpeed, vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], _houdiniFPS, vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _frameCount, vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], _boundMaxX);

				vertex_uniform_buffer_2[13] = float4(_boundMaxY, vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], _boundMaxZ, vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _boundMinX, vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], _boundMinY);

				vertex_uniform_buffer_2[14] = float4(_boundMinZ, vertex_uniform_buffer_2[14][1], vertex_uniform_buffer_2[14][2], vertex_uniform_buffer_2[14][3]);

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
				return stage_output;
			}

			#endif // defined(_B_LOAD_COL_TEX) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_B_LOAD_NORM_TEX)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 _ScreenSize;
			float4 unity_RenderingLayer;
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[51];
			static float4 fragment_uniform_buffer_1[39];
			static float4 fragment_uniform_buffer_2[19];
			static bool gl_FrontFacing;
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
				bool gl_FrontFacing : SV_IsFrontFace;
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
				float fragment_unnamed_62 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_63 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_112 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_112 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_62) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_62)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_112 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_63) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_63)))) * (-0.5f));
				fragment_output_0.z = 0.0f;
				fragment_output_0.w = 0.0f;
				float fragment_unnamed_140 = 1.0f / max(sqrt(dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_163 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 1065353216u : asuint(fragment_uniform_buffer_2[18u]).z);
				float fragment_unnamed_164 = (fragment_unnamed_140 * fragment_input_6.x) * fragment_unnamed_163;
				float fragment_unnamed_165 = (fragment_unnamed_140 * fragment_input_6.y) * fragment_unnamed_163;
				float fragment_unnamed_166 = (fragment_unnamed_140 * fragment_input_6.z) * fragment_unnamed_163;
				float fragment_unnamed_175 = 1.0f / max(dot(float3(abs(fragment_unnamed_164), abs(fragment_unnamed_165), abs(fragment_unnamed_166)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_180 = clamp((-0.0f) - (fragment_unnamed_175 * fragment_unnamed_166), 0.0f, 1.0f);
				float fragment_unnamed_183 = (-0.0f) - fragment_unnamed_180;
				fragment_output_1.z = clamp(mad(mad(fragment_unnamed_164, fragment_unnamed_175, ((fragment_unnamed_175 * fragment_unnamed_164) >= 0.0f) ? fragment_unnamed_180 : fragment_unnamed_183), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_1.w = clamp(mad(mad(fragment_unnamed_165, fragment_unnamed_175, ((fragment_unnamed_175 * fragment_unnamed_165) >= 0.0f) ? fragment_unnamed_180 : fragment_unnamed_183), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_202 = 8u & 31u;
				fragment_output_1.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_1[10u]).x, fragment_unnamed_202, min((8u & 31u), (32u - fragment_unnamed_202)))) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(asuint(fragment_uniform_buffer_1[10u]).x & 255u) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[50] = float4(_ScreenSize[0], _ScreenSize[1], _ScreenSize[2], _ScreenSize[3]);

				fragment_uniform_buffer_1[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_2[18] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

				gl_FrontFacing = stage_input.gl_FrontFacing;
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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON)


			#if defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(_B_LOAD_NORM_TEX)
			#define ANY_SHADER_VARIANT_ACTIVE

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

			#endif // defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER) && !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(_B_LOAD_NORM_TEX)


			#if defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
			#define ANY_SHADER_VARIANT_ACTIVE

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
				float fragment_unnamed_56 = ((-0.0f) - (fragment_input_1.x / fragment_input_1.z)) + (fragment_input_0.x / fragment_input_0.z);
				float fragment_unnamed_57 = ((-0.0f) - (fragment_input_1.y / fragment_input_1.z)) + (fragment_input_0.y / fragment_input_0.z);
				bool fragment_unnamed_106 = fragment_uniform_buffer_1[38u].y == 0.0f;
				fragment_output_0.x = fragment_unnamed_106 ? 2.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].z, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_56) < (fragment_uniform_buffer_0[50u].z * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_56)))) * 0.5f);
				fragment_output_0.y = fragment_unnamed_106 ? 0.0f : (min(mad((-0.0f) - fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, 2.0f), max(mad(fragment_uniform_buffer_0[50u].w, 0.00999999977648258209228515625f, -2.0f), asfloat((abs(fragment_unnamed_57) < (fragment_uniform_buffer_0[50u].w * 0.00999999977648258209228515625f)) ? 0u : asuint(fragment_unnamed_57)))) * (-0.5f));
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

			#endif // defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)


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
			GpuProgramID 496140

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature WRITE_DECAL_BUFFER
			#pragma shader_feature _B_LOAD_COL_TEX
			#pragma shader_feature _B_LOAD_NORM_TEX
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_B_LOAD_NORM_TEX)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _TimeParameters;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _gameTimeAtFirstFrame;
			float _B_interpolate;
			float _B_autoPlayback;
			float _displayFrame;
			float _B_surfaceNormals;
			float _playbackSpeed;
			float _houdiniFPS;
			float _frameCount;
			float _boundMaxX;
			float _boundMaxY;
			float _boundMaxZ;
			float _boundMinX;
			float _boundMinY;
			float _boundMinZ;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[24];
			Texture2D<float4> _posTexture;
			Texture2D<float4> _rotTexture;
			SamplerState sampler_posTexture;
			SamplerState sampler_rotTexture;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
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
				if ((((0.0f < vertex_uniform_buffer_2[23u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
				}
				else
				{
					bool vertex_unnamed_92 = 0.100000001490116119384765625f >= vertex_input_4.y;
					bool vertex_unnamed_108 = mad(vertex_uniform_buffer_2[13u].y, 10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[13u].y * 10.0f)) >= 0.5f;
					float vertex_unnamed_126 = (((-0.0f) - mad((-0.0f) - vertex_uniform_buffer_2[14u].x, 10.0f, ceil(vertex_uniform_buffer_2[14u].x * 10.0f))) + 1.0f) * vertex_input_4.x;
					float vertex_unnamed_144 = ((-0.0f) - mad(vertex_uniform_buffer_2[12u].w, -10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[12u].w * (-10.0f)))) + 1.0f;
					float vertex_unnamed_145 = vertex_unnamed_144 * (((-0.0f) - vertex_input_4.y) + 1.0f);
					float vertex_unnamed_174 = frac(((vertex_uniform_buffer_0[80u].x + ((-0.0f) - vertex_uniform_buffer_2[5u].x)) * (vertex_uniform_buffer_2[12u].y / (vertex_uniform_buffer_2[12u].z + (-0.00999999977648258209228515625f)))) * vertex_uniform_buffer_2[12u].x) * vertex_uniform_buffer_2[12u].z;
					bool vertex_unnamed_186 = 0.0f != vertex_uniform_buffer_2[6u].x;
					uint vertex_unnamed_188 = (0.0f != vertex_uniform_buffer_2[6u].z) ? 4294967295u : 0u;
					float vertex_unnamed_192 = asfloat(vertex_unnamed_186 ? asuint(floor(vertex_unnamed_174) + 1.0f) : asuint(floor(vertex_uniform_buffer_2[6u].y)));
					float vertex_unnamed_198 = vertex_unnamed_192 / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_199 = (vertex_unnamed_192 + (-1.0f)) / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_203 = frac(abs(vertex_unnamed_199));
					float vertex_unnamed_213 = 1.0f / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_217 = ((-0.0f) - mad((((vertex_unnamed_199 >= ((-0.0f) - vertex_unnamed_199)) ? vertex_unnamed_203 : ((-0.0f) - vertex_unnamed_203)) * vertex_uniform_buffer_2[12u].z) * vertex_unnamed_213, vertex_unnamed_144, vertex_unnamed_145)) + 1.0f;
					float4 vertex_unnamed_220 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_126, vertex_unnamed_217), 0.0f);
					float vertex_unnamed_223 = vertex_unnamed_220.x;
					float vertex_unnamed_224 = vertex_unnamed_220.y;
					float vertex_unnamed_225 = vertex_unnamed_220.z;
					uint4 vertex_unnamed_228 = asuint(vertex_uniform_buffer_2[13u]);
					float vertex_unnamed_230 = asfloat(vertex_unnamed_228.z);
					float vertex_unnamed_232 = asfloat(vertex_unnamed_228.w);
					float vertex_unnamed_237 = asfloat(asuint(vertex_uniform_buffer_2[14u]).x);
					float vertex_unnamed_242 = ((-0.0f) - vertex_unnamed_230) + vertex_uniform_buffer_2[12u].w;
					float vertex_unnamed_249 = ((-0.0f) - vertex_unnamed_232) + vertex_uniform_buffer_2[13u].x;
					float vertex_unnamed_250 = ((-0.0f) - vertex_unnamed_237) + vertex_uniform_buffer_2[13u].y;
					uint vertex_unnamed_260 = vertex_unnamed_108 ? asuint(vertex_unnamed_223) : asuint(mad(vertex_unnamed_223, vertex_unnamed_242, vertex_unnamed_230));
					float vertex_unnamed_261 = asfloat(vertex_unnamed_260);
					uint vertex_unnamed_262 = vertex_unnamed_108 ? asuint(vertex_unnamed_224) : asuint(mad(vertex_unnamed_224, vertex_unnamed_249, vertex_unnamed_232));
					float vertex_unnamed_263 = asfloat(vertex_unnamed_262);
					uint vertex_unnamed_264 = vertex_unnamed_108 ? asuint(vertex_unnamed_225) : asuint(mad(vertex_unnamed_225, vertex_unnamed_250, vertex_unnamed_237));
					float vertex_unnamed_265 = asfloat(vertex_unnamed_264);
					float vertex_unnamed_269 = frac(abs(vertex_unnamed_198));
					float vertex_unnamed_279 = ((-0.0f) - mad(vertex_unnamed_213 * (((vertex_unnamed_198 >= ((-0.0f) - vertex_unnamed_198)) ? vertex_unnamed_269 : ((-0.0f) - vertex_unnamed_269)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_144, vertex_unnamed_145)) + 1.0f;
					float4 vertex_unnamed_280 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_126, vertex_unnamed_279), 0.0f);
					float vertex_unnamed_282 = vertex_unnamed_280.x;
					float vertex_unnamed_283 = vertex_unnamed_280.y;
					float vertex_unnamed_284 = vertex_unnamed_280.z;
					float vertex_unnamed_307 = frac(asfloat(vertex_unnamed_186 ? asuint(vertex_unnamed_174) : asuint(vertex_uniform_buffer_2[6u]).y));
					bool vertex_unnamed_320 = 0.0f != vertex_uniform_buffer_2[5u].y;
					float vertex_unnamed_343 = asfloat(vertex_unnamed_92 ? 0u : asuint(asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_261) + asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_282) : asuint(mad(vertex_unnamed_282, vertex_unnamed_242, vertex_unnamed_230))), vertex_unnamed_261)) : vertex_unnamed_260) + vertex_input_0.x));
					float vertex_unnamed_345 = asfloat(vertex_unnamed_92 ? 0u : asuint(asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_263) + asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_283) : asuint(mad(vertex_unnamed_283, vertex_unnamed_249, vertex_unnamed_232))), vertex_unnamed_263)) : vertex_unnamed_262) + vertex_input_0.y));
					float vertex_unnamed_347 = asfloat(vertex_unnamed_92 ? 0u : asuint(asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_265) + asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_284) : asuint(mad(vertex_unnamed_284, vertex_unnamed_250, vertex_unnamed_237))), vertex_unnamed_265)) : vertex_unnamed_264) + vertex_input_0.z));
					float4 vertex_unnamed_349 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_126, vertex_unnamed_217), 0.0f);
					float vertex_unnamed_351 = vertex_unnamed_349.x;
					float vertex_unnamed_352 = vertex_unnamed_349.y;
					float vertex_unnamed_353 = vertex_unnamed_349.z;
					float vertex_unnamed_354 = vertex_unnamed_349.w;
					float vertex_unnamed_355 = vertex_unnamed_351 + (-0.5f);
					float vertex_unnamed_357 = vertex_unnamed_352 + (-0.5f);
					float vertex_unnamed_358 = vertex_unnamed_353 + (-0.5f);
					float vertex_unnamed_359 = vertex_unnamed_354 + (-0.5f);
					float vertex_unnamed_373 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_351) : asuint(vertex_unnamed_355 + vertex_unnamed_355));
					float vertex_unnamed_375 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_352) : asuint(vertex_unnamed_357 + vertex_unnamed_357));
					float vertex_unnamed_377 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_353) : asuint(vertex_unnamed_358 + vertex_unnamed_358));
					float vertex_unnamed_379 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_354) : asuint(vertex_unnamed_359 + vertex_unnamed_359));
					float vertex_unnamed_389 = mad(vertex_unnamed_379, 1.0f, mad(vertex_unnamed_377, 0.0f, (-0.0f) - (vertex_unnamed_373 * 0.0f)));
					float vertex_unnamed_390 = mad(vertex_unnamed_379, 0.0f, mad(vertex_unnamed_373, 1.0f, (-0.0f) - (vertex_unnamed_375 * 0.0f)));
					float vertex_unnamed_391 = mad(vertex_unnamed_379, 0.0f, mad(vertex_unnamed_375, 0.0f, (-0.0f) - (vertex_unnamed_377 * 1.0f)));
					float vertex_unnamed_401 = mad(mad(vertex_unnamed_375, vertex_unnamed_390, (-0.0f) - (vertex_unnamed_389 * vertex_unnamed_377)), 2.0f, 0.0f);
					float vertex_unnamed_403 = mad(mad(vertex_unnamed_377, vertex_unnamed_391, (-0.0f) - (vertex_unnamed_390 * vertex_unnamed_373)), 2.0f, 1.0f);
					float vertex_unnamed_404 = mad(mad(vertex_unnamed_373, vertex_unnamed_389, (-0.0f) - (vertex_unnamed_391 * vertex_unnamed_375)), 2.0f, 0.0f);
					float4 vertex_unnamed_405 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_126, vertex_unnamed_279), 0.0f);
					float vertex_unnamed_407 = vertex_unnamed_405.x;
					float vertex_unnamed_408 = vertex_unnamed_405.y;
					float vertex_unnamed_409 = vertex_unnamed_405.z;
					float vertex_unnamed_410 = vertex_unnamed_405.w;
					float vertex_unnamed_411 = vertex_unnamed_407 + (-0.5f);
					float vertex_unnamed_412 = vertex_unnamed_408 + (-0.5f);
					float vertex_unnamed_413 = vertex_unnamed_409 + (-0.5f);
					float vertex_unnamed_414 = vertex_unnamed_410 + (-0.5f);
					float vertex_unnamed_428 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_407) : asuint(vertex_unnamed_411 + vertex_unnamed_411));
					float vertex_unnamed_430 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_408) : asuint(vertex_unnamed_412 + vertex_unnamed_412));
					float vertex_unnamed_432 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_409) : asuint(vertex_unnamed_413 + vertex_unnamed_413));
					float vertex_unnamed_434 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_410) : asuint(vertex_unnamed_414 + vertex_unnamed_414));
					float vertex_unnamed_444 = mad(vertex_unnamed_434, 1.0f, mad(vertex_unnamed_432, 0.0f, (-0.0f) - (vertex_unnamed_428 * 0.0f)));
					float vertex_unnamed_445 = mad(vertex_unnamed_434, 0.0f, mad(vertex_unnamed_428, 1.0f, (-0.0f) - (vertex_unnamed_430 * 0.0f)));
					float vertex_unnamed_446 = mad(vertex_unnamed_434, 0.0f, mad(vertex_unnamed_430, 0.0f, (-0.0f) - (vertex_unnamed_432 * 1.0f)));
					float vertex_unnamed_475 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_401) + mad(mad(vertex_unnamed_430, vertex_unnamed_445, (-0.0f) - (vertex_unnamed_432 * vertex_unnamed_444)), 2.0f, 0.0f), vertex_unnamed_401)) : asuint(vertex_unnamed_401));
					float vertex_unnamed_477 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_403) + mad(mad(vertex_unnamed_432, vertex_unnamed_446, (-0.0f) - (vertex_unnamed_428 * vertex_unnamed_445)), 2.0f, 1.0f), vertex_unnamed_403)) : asuint(vertex_unnamed_403));
					float vertex_unnamed_479 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_404) + mad(mad(vertex_unnamed_428, vertex_unnamed_444, (-0.0f) - (vertex_unnamed_430 * vertex_unnamed_446)), 2.0f, 0.0f), vertex_unnamed_404)) : asuint(vertex_unnamed_404));
					float vertex_unnamed_483 = rsqrt(dot(float3(vertex_unnamed_475, vertex_unnamed_477, vertex_unnamed_479), float3(vertex_unnamed_475, vertex_unnamed_477, vertex_unnamed_479)));
					float vertex_unnamed_484 = vertex_unnamed_483 * vertex_unnamed_475;
					float vertex_unnamed_485 = vertex_unnamed_483 * vertex_unnamed_477;
					float vertex_unnamed_486 = vertex_unnamed_483 * vertex_unnamed_479;
					float vertex_unnamed_496 = mad(vertex_unnamed_379, 0.0f, mad(vertex_unnamed_377, -1.0f, (-0.0f) - (vertex_unnamed_373 * 0.0f)));
					float vertex_unnamed_497 = mad(vertex_unnamed_379, 0.0f, mad(vertex_unnamed_373, 0.0f, (-0.0f) - (vertex_unnamed_375 * (-1.0f))));
					float vertex_unnamed_498 = mad(vertex_unnamed_379, -1.0f, mad(vertex_unnamed_375, 0.0f, (-0.0f) - (vertex_unnamed_377 * 0.0f)));
					float vertex_unnamed_508 = mad(mad(vertex_unnamed_375, vertex_unnamed_497, (-0.0f) - (vertex_unnamed_377 * vertex_unnamed_496)), 2.0f, -1.0f);
					float vertex_unnamed_509 = mad(mad(vertex_unnamed_377, vertex_unnamed_498, (-0.0f) - (vertex_unnamed_373 * vertex_unnamed_497)), 2.0f, 0.0f);
					float vertex_unnamed_510 = mad(mad(vertex_unnamed_373, vertex_unnamed_496, (-0.0f) - (vertex_unnamed_375 * vertex_unnamed_498)), 2.0f, 0.0f);
					float vertex_unnamed_520 = mad(vertex_unnamed_434, 0.0f, mad(vertex_unnamed_432, -1.0f, (-0.0f) - (vertex_unnamed_428 * 0.0f)));
					float vertex_unnamed_521 = mad(vertex_unnamed_434, 0.0f, mad(vertex_unnamed_428, 0.0f, (-0.0f) - (vertex_unnamed_430 * (-1.0f))));
					float vertex_unnamed_522 = mad(vertex_unnamed_434, -1.0f, mad(vertex_unnamed_430, 0.0f, (-0.0f) - (vertex_unnamed_432 * 0.0f)));
					float vertex_unnamed_551 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_508) + mad(mad(vertex_unnamed_430, vertex_unnamed_521, (-0.0f) - (vertex_unnamed_432 * vertex_unnamed_520)), 2.0f, -1.0f), vertex_unnamed_508)) : asuint(vertex_unnamed_508));
					float vertex_unnamed_553 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_509) + mad(mad(vertex_unnamed_432, vertex_unnamed_522, (-0.0f) - (vertex_unnamed_428 * vertex_unnamed_521)), 2.0f, 0.0f), vertex_unnamed_509)) : asuint(vertex_unnamed_509));
					float vertex_unnamed_555 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_510) + mad(mad(vertex_unnamed_428, vertex_unnamed_520, (-0.0f) - (vertex_unnamed_430 * vertex_unnamed_522)), 2.0f, 0.0f), vertex_unnamed_510)) : asuint(vertex_unnamed_510));
					float vertex_unnamed_559 = rsqrt(dot(float3(vertex_unnamed_551, vertex_unnamed_553, vertex_unnamed_555), float3(vertex_unnamed_551, vertex_unnamed_553, vertex_unnamed_555)));
					float vertex_unnamed_567 = asfloat(asuint(vertex_unnamed_559 * vertex_unnamed_551) & vertex_unnamed_188);
					float vertex_unnamed_569 = asfloat(asuint(vertex_unnamed_559 * vertex_unnamed_553) & vertex_unnamed_188);
					float vertex_unnamed_571 = asfloat(asuint(vertex_unnamed_559 * vertex_unnamed_555) & vertex_unnamed_188);
					float vertex_unnamed_604 = asfloat(1065353216u);
					float vertex_unnamed_606 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_343, vertex_unnamed_345, vertex_unnamed_347, vertex_unnamed_604));
					float vertex_unnamed_624 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_343, vertex_unnamed_345, vertex_unnamed_347, vertex_unnamed_604));
					float vertex_unnamed_642 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_343, vertex_unnamed_345, vertex_unnamed_347, vertex_unnamed_604));
					float vertex_unnamed_651 = dot(float3(vertex_unnamed_484, vertex_unnamed_485, vertex_unnamed_486), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_659 = dot(float3(vertex_unnamed_484, vertex_unnamed_485, vertex_unnamed_486), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_667 = dot(float3(vertex_unnamed_484, vertex_unnamed_485, vertex_unnamed_486), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_675 = rsqrt(max(dot(float3(vertex_unnamed_651, vertex_unnamed_659, vertex_unnamed_667), float3(vertex_unnamed_651, vertex_unnamed_659, vertex_unnamed_667)), 1.1754943508222875079687365372222e-38f));
					vertex_output_3.x = vertex_unnamed_675 * vertex_unnamed_651;
					vertex_output_3.y = vertex_unnamed_675 * vertex_unnamed_659;
					vertex_output_3.z = vertex_unnamed_675 * vertex_unnamed_667;
					float vertex_unnamed_703 = mad(vertex_uniform_buffer_1[2u].x, vertex_unnamed_571, mad(vertex_uniform_buffer_1[0u].x, vertex_unnamed_567, vertex_unnamed_569 * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_704 = mad(vertex_uniform_buffer_1[2u].y, vertex_unnamed_571, mad(vertex_uniform_buffer_1[0u].y, vertex_unnamed_567, vertex_unnamed_569 * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_705 = mad(vertex_uniform_buffer_1[2u].z, vertex_unnamed_571, mad(vertex_uniform_buffer_1[0u].z, vertex_unnamed_567, vertex_unnamed_569 * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_710 = rsqrt(max(dot(float3(vertex_unnamed_703, vertex_unnamed_704, vertex_unnamed_705), float3(vertex_unnamed_703, vertex_unnamed_704, vertex_unnamed_705)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_703 * vertex_unnamed_710;
					vertex_output_1.y = vertex_unnamed_704 * vertex_unnamed_710;
					vertex_output_1.z = vertex_unnamed_705 * vertex_unnamed_710;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_642, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_606, vertex_unnamed_624 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_642, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_606, vertex_unnamed_624 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_642, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_606, vertex_unnamed_624 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_642, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_606, vertex_unnamed_624 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
					vertex_output_1.w = vertex_input_2.w;
					vertex_output_2.x = vertex_input_3.x;
					vertex_output_2.y = vertex_input_3.y;
					vertex_output_2.z = vertex_input_3.z;
					vertex_output_2.w = vertex_input_3.w;
				}
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[5] = float4(_gameTimeAtFirstFrame, vertex_uniform_buffer_2[5][1], vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], _B_interpolate, vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[6] = float4(_B_autoPlayback, vertex_uniform_buffer_2[6][1], vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _displayFrame, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], vertex_uniform_buffer_2[6][1], _B_surfaceNormals, vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[12] = float4(_playbackSpeed, vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], _houdiniFPS, vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _frameCount, vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], _boundMaxX);

				vertex_uniform_buffer_2[13] = float4(_boundMaxY, vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], _boundMaxZ, vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _boundMinX, vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], _boundMinY);

				vertex_uniform_buffer_2[14] = float4(_boundMinZ, vertex_uniform_buffer_2[14][1], vertex_uniform_buffer_2[14][2], vertex_uniform_buffer_2[14][3]);

				vertex_uniform_buffer_2[23] = float4(vertex_uniform_buffer_2[23][0], vertex_uniform_buffer_2[23][1], _RayTracing, vertex_uniform_buffer_2[23][3]);

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
				return stage_output;
			}


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

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
			}

			#endif // !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_B_LOAD_NORM_TEX)


			#if defined(_B_LOAD_COL_TEX) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_B_LOAD_NORM_TEX)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _TimeParameters;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _gameTimeAtFirstFrame;
			float _B_interpolate;
			float _B_autoPlayback;
			float _displayFrame;
			float _B_surfaceNormals;
			float _playbackSpeed;
			float _houdiniFPS;
			float _frameCount;
			float _boundMaxX;
			float _boundMaxY;
			float _boundMaxZ;
			float _boundMinX;
			float _boundMinY;
			float _boundMinZ;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[24];
			Texture2D<float4> _posTexture;
			Texture2D<float4> _rotTexture;
			SamplerState sampler_posTexture;
			SamplerState sampler_rotTexture;

			static float4 gl_Position;
			static float3 vertex_input_0;
			static float3 vertex_input_1;
			static float4 vertex_input_2;
			static float4 vertex_input_3;
			static float4 vertex_input_4;
			static float4 vertex_output_1;
			static float4 vertex_output_2;
			static float3 vertex_output_3;

			struct Vertex_Stage_Input
			{
				float3 vertex_input_0 : POSITION; // POSITION
				float3 vertex_input_1 : NORMAL; // NORMAL
				float4 vertex_input_2 : TANGENT; // TANGENT
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
				float4 vertex_input_4 : TEXCOORD1; // TEXCOORD_1
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
				if ((((0.0f < vertex_uniform_buffer_2[23u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
				}
				else
				{
					bool vertex_unnamed_92 = 0.100000001490116119384765625f >= vertex_input_4.y;
					bool vertex_unnamed_108 = mad(vertex_uniform_buffer_2[13u].y, 10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[13u].y * 10.0f)) >= 0.5f;
					float vertex_unnamed_126 = (((-0.0f) - mad((-0.0f) - vertex_uniform_buffer_2[14u].x, 10.0f, ceil(vertex_uniform_buffer_2[14u].x * 10.0f))) + 1.0f) * vertex_input_4.x;
					float vertex_unnamed_144 = ((-0.0f) - mad(vertex_uniform_buffer_2[12u].w, -10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[12u].w * (-10.0f)))) + 1.0f;
					float vertex_unnamed_145 = vertex_unnamed_144 * (((-0.0f) - vertex_input_4.y) + 1.0f);
					float vertex_unnamed_174 = frac(((vertex_uniform_buffer_0[80u].x + ((-0.0f) - vertex_uniform_buffer_2[5u].x)) * (vertex_uniform_buffer_2[12u].y / (vertex_uniform_buffer_2[12u].z + (-0.00999999977648258209228515625f)))) * vertex_uniform_buffer_2[12u].x) * vertex_uniform_buffer_2[12u].z;
					bool vertex_unnamed_186 = 0.0f != vertex_uniform_buffer_2[6u].x;
					uint vertex_unnamed_188 = (0.0f != vertex_uniform_buffer_2[6u].z) ? 4294967295u : 0u;
					float vertex_unnamed_192 = asfloat(vertex_unnamed_186 ? asuint(floor(vertex_unnamed_174) + 1.0f) : asuint(floor(vertex_uniform_buffer_2[6u].y)));
					float vertex_unnamed_198 = vertex_unnamed_192 / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_199 = (vertex_unnamed_192 + (-1.0f)) / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_203 = frac(abs(vertex_unnamed_199));
					float vertex_unnamed_213 = 1.0f / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_217 = ((-0.0f) - mad((((vertex_unnamed_199 >= ((-0.0f) - vertex_unnamed_199)) ? vertex_unnamed_203 : ((-0.0f) - vertex_unnamed_203)) * vertex_uniform_buffer_2[12u].z) * vertex_unnamed_213, vertex_unnamed_144, vertex_unnamed_145)) + 1.0f;
					float4 vertex_unnamed_220 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_126, vertex_unnamed_217), 0.0f);
					float vertex_unnamed_223 = vertex_unnamed_220.x;
					float vertex_unnamed_224 = vertex_unnamed_220.y;
					float vertex_unnamed_225 = vertex_unnamed_220.z;
					uint4 vertex_unnamed_228 = asuint(vertex_uniform_buffer_2[13u]);
					float vertex_unnamed_230 = asfloat(vertex_unnamed_228.z);
					float vertex_unnamed_232 = asfloat(vertex_unnamed_228.w);
					float vertex_unnamed_237 = asfloat(asuint(vertex_uniform_buffer_2[14u]).x);
					float vertex_unnamed_242 = ((-0.0f) - vertex_unnamed_230) + vertex_uniform_buffer_2[12u].w;
					float vertex_unnamed_249 = ((-0.0f) - vertex_unnamed_232) + vertex_uniform_buffer_2[13u].x;
					float vertex_unnamed_250 = ((-0.0f) - vertex_unnamed_237) + vertex_uniform_buffer_2[13u].y;
					uint vertex_unnamed_260 = vertex_unnamed_108 ? asuint(vertex_unnamed_223) : asuint(mad(vertex_unnamed_223, vertex_unnamed_242, vertex_unnamed_230));
					float vertex_unnamed_261 = asfloat(vertex_unnamed_260);
					uint vertex_unnamed_262 = vertex_unnamed_108 ? asuint(vertex_unnamed_224) : asuint(mad(vertex_unnamed_224, vertex_unnamed_249, vertex_unnamed_232));
					float vertex_unnamed_263 = asfloat(vertex_unnamed_262);
					uint vertex_unnamed_264 = vertex_unnamed_108 ? asuint(vertex_unnamed_225) : asuint(mad(vertex_unnamed_225, vertex_unnamed_250, vertex_unnamed_237));
					float vertex_unnamed_265 = asfloat(vertex_unnamed_264);
					float vertex_unnamed_269 = frac(abs(vertex_unnamed_198));
					float vertex_unnamed_279 = ((-0.0f) - mad(vertex_unnamed_213 * (((vertex_unnamed_198 >= ((-0.0f) - vertex_unnamed_198)) ? vertex_unnamed_269 : ((-0.0f) - vertex_unnamed_269)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_144, vertex_unnamed_145)) + 1.0f;
					float4 vertex_unnamed_280 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_126, vertex_unnamed_279), 0.0f);
					float vertex_unnamed_282 = vertex_unnamed_280.x;
					float vertex_unnamed_283 = vertex_unnamed_280.y;
					float vertex_unnamed_284 = vertex_unnamed_280.z;
					float vertex_unnamed_307 = frac(asfloat(vertex_unnamed_186 ? asuint(vertex_unnamed_174) : asuint(vertex_uniform_buffer_2[6u]).y));
					bool vertex_unnamed_320 = 0.0f != vertex_uniform_buffer_2[5u].y;
					float vertex_unnamed_343 = asfloat(vertex_unnamed_92 ? 0u : asuint(asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_261) + asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_282) : asuint(mad(vertex_unnamed_282, vertex_unnamed_242, vertex_unnamed_230))), vertex_unnamed_261)) : vertex_unnamed_260) + vertex_input_0.x));
					float vertex_unnamed_345 = asfloat(vertex_unnamed_92 ? 0u : asuint(asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_263) + asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_283) : asuint(mad(vertex_unnamed_283, vertex_unnamed_249, vertex_unnamed_232))), vertex_unnamed_263)) : vertex_unnamed_262) + vertex_input_0.y));
					float vertex_unnamed_347 = asfloat(vertex_unnamed_92 ? 0u : asuint(asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_265) + asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_284) : asuint(mad(vertex_unnamed_284, vertex_unnamed_250, vertex_unnamed_237))), vertex_unnamed_265)) : vertex_unnamed_264) + vertex_input_0.z));
					float4 vertex_unnamed_349 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_126, vertex_unnamed_217), 0.0f);
					float vertex_unnamed_351 = vertex_unnamed_349.x;
					float vertex_unnamed_352 = vertex_unnamed_349.y;
					float vertex_unnamed_353 = vertex_unnamed_349.z;
					float vertex_unnamed_354 = vertex_unnamed_349.w;
					float vertex_unnamed_355 = vertex_unnamed_351 + (-0.5f);
					float vertex_unnamed_357 = vertex_unnamed_352 + (-0.5f);
					float vertex_unnamed_358 = vertex_unnamed_353 + (-0.5f);
					float vertex_unnamed_359 = vertex_unnamed_354 + (-0.5f);
					float vertex_unnamed_373 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_351) : asuint(vertex_unnamed_355 + vertex_unnamed_355));
					float vertex_unnamed_375 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_352) : asuint(vertex_unnamed_357 + vertex_unnamed_357));
					float vertex_unnamed_377 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_353) : asuint(vertex_unnamed_358 + vertex_unnamed_358));
					float vertex_unnamed_379 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_354) : asuint(vertex_unnamed_359 + vertex_unnamed_359));
					float vertex_unnamed_389 = mad(vertex_unnamed_379, 1.0f, mad(vertex_unnamed_377, 0.0f, (-0.0f) - (vertex_unnamed_373 * 0.0f)));
					float vertex_unnamed_390 = mad(vertex_unnamed_379, 0.0f, mad(vertex_unnamed_373, 1.0f, (-0.0f) - (vertex_unnamed_375 * 0.0f)));
					float vertex_unnamed_391 = mad(vertex_unnamed_379, 0.0f, mad(vertex_unnamed_375, 0.0f, (-0.0f) - (vertex_unnamed_377 * 1.0f)));
					float vertex_unnamed_401 = mad(mad(vertex_unnamed_375, vertex_unnamed_390, (-0.0f) - (vertex_unnamed_389 * vertex_unnamed_377)), 2.0f, 0.0f);
					float vertex_unnamed_403 = mad(mad(vertex_unnamed_377, vertex_unnamed_391, (-0.0f) - (vertex_unnamed_390 * vertex_unnamed_373)), 2.0f, 1.0f);
					float vertex_unnamed_404 = mad(mad(vertex_unnamed_373, vertex_unnamed_389, (-0.0f) - (vertex_unnamed_391 * vertex_unnamed_375)), 2.0f, 0.0f);
					float4 vertex_unnamed_405 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_126, vertex_unnamed_279), 0.0f);
					float vertex_unnamed_407 = vertex_unnamed_405.x;
					float vertex_unnamed_408 = vertex_unnamed_405.y;
					float vertex_unnamed_409 = vertex_unnamed_405.z;
					float vertex_unnamed_410 = vertex_unnamed_405.w;
					float vertex_unnamed_411 = vertex_unnamed_407 + (-0.5f);
					float vertex_unnamed_412 = vertex_unnamed_408 + (-0.5f);
					float vertex_unnamed_413 = vertex_unnamed_409 + (-0.5f);
					float vertex_unnamed_414 = vertex_unnamed_410 + (-0.5f);
					float vertex_unnamed_428 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_407) : asuint(vertex_unnamed_411 + vertex_unnamed_411));
					float vertex_unnamed_430 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_408) : asuint(vertex_unnamed_412 + vertex_unnamed_412));
					float vertex_unnamed_432 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_409) : asuint(vertex_unnamed_413 + vertex_unnamed_413));
					float vertex_unnamed_434 = asfloat(vertex_unnamed_108 ? asuint(vertex_unnamed_410) : asuint(vertex_unnamed_414 + vertex_unnamed_414));
					float vertex_unnamed_444 = mad(vertex_unnamed_434, 1.0f, mad(vertex_unnamed_432, 0.0f, (-0.0f) - (vertex_unnamed_428 * 0.0f)));
					float vertex_unnamed_445 = mad(vertex_unnamed_434, 0.0f, mad(vertex_unnamed_428, 1.0f, (-0.0f) - (vertex_unnamed_430 * 0.0f)));
					float vertex_unnamed_446 = mad(vertex_unnamed_434, 0.0f, mad(vertex_unnamed_430, 0.0f, (-0.0f) - (vertex_unnamed_432 * 1.0f)));
					float vertex_unnamed_475 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_401) + mad(mad(vertex_unnamed_430, vertex_unnamed_445, (-0.0f) - (vertex_unnamed_432 * vertex_unnamed_444)), 2.0f, 0.0f), vertex_unnamed_401)) : asuint(vertex_unnamed_401));
					float vertex_unnamed_477 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_403) + mad(mad(vertex_unnamed_432, vertex_unnamed_446, (-0.0f) - (vertex_unnamed_428 * vertex_unnamed_445)), 2.0f, 1.0f), vertex_unnamed_403)) : asuint(vertex_unnamed_403));
					float vertex_unnamed_479 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_404) + mad(mad(vertex_unnamed_428, vertex_unnamed_444, (-0.0f) - (vertex_unnamed_430 * vertex_unnamed_446)), 2.0f, 0.0f), vertex_unnamed_404)) : asuint(vertex_unnamed_404));
					float vertex_unnamed_483 = rsqrt(dot(float3(vertex_unnamed_475, vertex_unnamed_477, vertex_unnamed_479), float3(vertex_unnamed_475, vertex_unnamed_477, vertex_unnamed_479)));
					float vertex_unnamed_484 = vertex_unnamed_483 * vertex_unnamed_475;
					float vertex_unnamed_485 = vertex_unnamed_483 * vertex_unnamed_477;
					float vertex_unnamed_486 = vertex_unnamed_483 * vertex_unnamed_479;
					float vertex_unnamed_496 = mad(vertex_unnamed_379, 0.0f, mad(vertex_unnamed_377, -1.0f, (-0.0f) - (vertex_unnamed_373 * 0.0f)));
					float vertex_unnamed_497 = mad(vertex_unnamed_379, 0.0f, mad(vertex_unnamed_373, 0.0f, (-0.0f) - (vertex_unnamed_375 * (-1.0f))));
					float vertex_unnamed_498 = mad(vertex_unnamed_379, -1.0f, mad(vertex_unnamed_375, 0.0f, (-0.0f) - (vertex_unnamed_377 * 0.0f)));
					float vertex_unnamed_508 = mad(mad(vertex_unnamed_375, vertex_unnamed_497, (-0.0f) - (vertex_unnamed_377 * vertex_unnamed_496)), 2.0f, -1.0f);
					float vertex_unnamed_509 = mad(mad(vertex_unnamed_377, vertex_unnamed_498, (-0.0f) - (vertex_unnamed_373 * vertex_unnamed_497)), 2.0f, 0.0f);
					float vertex_unnamed_510 = mad(mad(vertex_unnamed_373, vertex_unnamed_496, (-0.0f) - (vertex_unnamed_375 * vertex_unnamed_498)), 2.0f, 0.0f);
					float vertex_unnamed_520 = mad(vertex_unnamed_434, 0.0f, mad(vertex_unnamed_432, -1.0f, (-0.0f) - (vertex_unnamed_428 * 0.0f)));
					float vertex_unnamed_521 = mad(vertex_unnamed_434, 0.0f, mad(vertex_unnamed_428, 0.0f, (-0.0f) - (vertex_unnamed_430 * (-1.0f))));
					float vertex_unnamed_522 = mad(vertex_unnamed_434, -1.0f, mad(vertex_unnamed_430, 0.0f, (-0.0f) - (vertex_unnamed_432 * 0.0f)));
					float vertex_unnamed_551 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_508) + mad(mad(vertex_unnamed_430, vertex_unnamed_521, (-0.0f) - (vertex_unnamed_432 * vertex_unnamed_520)), 2.0f, -1.0f), vertex_unnamed_508)) : asuint(vertex_unnamed_508));
					float vertex_unnamed_553 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_509) + mad(mad(vertex_unnamed_432, vertex_unnamed_522, (-0.0f) - (vertex_unnamed_428 * vertex_unnamed_521)), 2.0f, 0.0f), vertex_unnamed_509)) : asuint(vertex_unnamed_509));
					float vertex_unnamed_555 = asfloat(vertex_unnamed_320 ? asuint(mad(vertex_unnamed_307, ((-0.0f) - vertex_unnamed_510) + mad(mad(vertex_unnamed_428, vertex_unnamed_520, (-0.0f) - (vertex_unnamed_430 * vertex_unnamed_522)), 2.0f, 0.0f), vertex_unnamed_510)) : asuint(vertex_unnamed_510));
					float vertex_unnamed_559 = rsqrt(dot(float3(vertex_unnamed_551, vertex_unnamed_553, vertex_unnamed_555), float3(vertex_unnamed_551, vertex_unnamed_553, vertex_unnamed_555)));
					float vertex_unnamed_567 = asfloat(asuint(vertex_unnamed_559 * vertex_unnamed_551) & vertex_unnamed_188);
					float vertex_unnamed_569 = asfloat(asuint(vertex_unnamed_559 * vertex_unnamed_553) & vertex_unnamed_188);
					float vertex_unnamed_571 = asfloat(asuint(vertex_unnamed_559 * vertex_unnamed_555) & vertex_unnamed_188);
					float vertex_unnamed_604 = asfloat(1065353216u);
					float vertex_unnamed_606 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_343, vertex_unnamed_345, vertex_unnamed_347, vertex_unnamed_604));
					float vertex_unnamed_624 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_343, vertex_unnamed_345, vertex_unnamed_347, vertex_unnamed_604));
					float vertex_unnamed_642 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_343, vertex_unnamed_345, vertex_unnamed_347, vertex_unnamed_604));
					float vertex_unnamed_651 = dot(float3(vertex_unnamed_484, vertex_unnamed_485, vertex_unnamed_486), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_659 = dot(float3(vertex_unnamed_484, vertex_unnamed_485, vertex_unnamed_486), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_667 = dot(float3(vertex_unnamed_484, vertex_unnamed_485, vertex_unnamed_486), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_675 = rsqrt(max(dot(float3(vertex_unnamed_651, vertex_unnamed_659, vertex_unnamed_667), float3(vertex_unnamed_651, vertex_unnamed_659, vertex_unnamed_667)), 1.1754943508222875079687365372222e-38f));
					vertex_output_3.x = vertex_unnamed_675 * vertex_unnamed_651;
					vertex_output_3.y = vertex_unnamed_675 * vertex_unnamed_659;
					vertex_output_3.z = vertex_unnamed_675 * vertex_unnamed_667;
					float vertex_unnamed_703 = mad(vertex_uniform_buffer_1[2u].x, vertex_unnamed_571, mad(vertex_uniform_buffer_1[0u].x, vertex_unnamed_567, vertex_unnamed_569 * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_704 = mad(vertex_uniform_buffer_1[2u].y, vertex_unnamed_571, mad(vertex_uniform_buffer_1[0u].y, vertex_unnamed_567, vertex_unnamed_569 * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_705 = mad(vertex_uniform_buffer_1[2u].z, vertex_unnamed_571, mad(vertex_uniform_buffer_1[0u].z, vertex_unnamed_567, vertex_unnamed_569 * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_710 = rsqrt(max(dot(float3(vertex_unnamed_703, vertex_unnamed_704, vertex_unnamed_705), float3(vertex_unnamed_703, vertex_unnamed_704, vertex_unnamed_705)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_703 * vertex_unnamed_710;
					vertex_output_1.y = vertex_unnamed_704 * vertex_unnamed_710;
					vertex_output_1.z = vertex_unnamed_705 * vertex_unnamed_710;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_642, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_606, vertex_unnamed_624 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_642, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_606, vertex_unnamed_624 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_642, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_606, vertex_unnamed_624 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_642, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_606, vertex_unnamed_624 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
					vertex_output_1.w = vertex_input_2.w;
					vertex_output_2.x = vertex_input_3.x;
					vertex_output_2.y = vertex_input_3.y;
					vertex_output_2.z = vertex_input_3.z;
					vertex_output_2.w = vertex_input_3.w;
				}
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[5] = float4(_gameTimeAtFirstFrame, vertex_uniform_buffer_2[5][1], vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], _B_interpolate, vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[6] = float4(_B_autoPlayback, vertex_uniform_buffer_2[6][1], vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _displayFrame, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], vertex_uniform_buffer_2[6][1], _B_surfaceNormals, vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[12] = float4(_playbackSpeed, vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], _houdiniFPS, vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _frameCount, vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], _boundMaxX);

				vertex_uniform_buffer_2[13] = float4(_boundMaxY, vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], _boundMaxZ, vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _boundMinX, vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], _boundMinY);

				vertex_uniform_buffer_2[14] = float4(_boundMinZ, vertex_uniform_buffer_2[14][1], vertex_uniform_buffer_2[14][2], vertex_uniform_buffer_2[14][3]);

				vertex_uniform_buffer_2[23] = float4(vertex_uniform_buffer_2[23][0], vertex_uniform_buffer_2[23][1], _RayTracing, vertex_uniform_buffer_2[23][3]);

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
				return stage_output;
			}

			#endif // defined(_B_LOAD_COL_TEX) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER) && !defined(_B_LOAD_NORM_TEX)


			#if defined(WRITE_DECAL_BUFFER) && defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4 unity_RenderingLayer;
			float4 _DoubleSidedConstants;

			static float4 fragment_uniform_buffer_0[11];
			static float4 fragment_uniform_buffer_1[19];
			static bool gl_FrontFacing;
			static float4 fragment_input_1;
			static float4 fragment_input_2;
			static float3 fragment_input_3;
			static float4 fragment_output_0;

			struct Fragment_Stage_Input
			{
				float4 fragment_input_1 : INTERP; // INTERP
				float4 fragment_input_2 : INTERP1; // INTERP_1
				float3 fragment_input_3 : INTERP2; // INTERP_2
				bool gl_FrontFacing : SV_IsFrontFace;
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
				float fragment_unnamed_53 = 1.0f / max(sqrt(dot(float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z), float3(fragment_input_3.x, fragment_input_3.y, fragment_input_3.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_77 = asfloat(((gl_FrontFacing ? 4294967295u : 0u) != 0u) ? 1065353216u : asuint(fragment_uniform_buffer_1[18u]).z);
				float fragment_unnamed_78 = (fragment_unnamed_53 * fragment_input_3.x) * fragment_unnamed_77;
				float fragment_unnamed_79 = (fragment_unnamed_53 * fragment_input_3.y) * fragment_unnamed_77;
				float fragment_unnamed_80 = (fragment_unnamed_53 * fragment_input_3.z) * fragment_unnamed_77;
				float fragment_unnamed_89 = 1.0f / max(dot(float3(abs(fragment_unnamed_78), abs(fragment_unnamed_79), abs(fragment_unnamed_80)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_96 = clamp((-0.0f) - (fragment_unnamed_89 * fragment_unnamed_80), 0.0f, 1.0f);
				float fragment_unnamed_99 = (-0.0f) - fragment_unnamed_96;
				fragment_output_0.z = clamp(mad(mad(fragment_unnamed_78, fragment_unnamed_89, ((fragment_unnamed_89 * fragment_unnamed_78) >= 0.0f) ? fragment_unnamed_96 : fragment_unnamed_99), 0.5f, 0.5f), 0.0f, 1.0f);
				fragment_output_0.w = clamp(mad(mad(fragment_unnamed_79, fragment_unnamed_89, ((fragment_unnamed_89 * fragment_unnamed_79) >= 0.0f) ? fragment_unnamed_96 : fragment_unnamed_99), 0.5f, 0.5f), 0.0f, 1.0f);
				uint fragment_unnamed_121 = 8u & 31u;
				fragment_output_0.x = float(spvBitfieldUExtract(asuint(fragment_uniform_buffer_0[10u]).x, fragment_unnamed_121, min((8u & 31u), (32u - fragment_unnamed_121)))) * 0.0039215688593685626983642578125f;
				fragment_output_0.y = float(asuint(fragment_uniform_buffer_0[10u]).x & 255u) * 0.0039215688593685626983642578125f;
			}

			Fragment_Stage_Output frag(Fragment_Stage_Input stage_input)
			{
				fragment_uniform_buffer_0[10] = float4(unity_RenderingLayer[0], unity_RenderingLayer[1], unity_RenderingLayer[2], unity_RenderingLayer[3]);

				fragment_uniform_buffer_1[18] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

				gl_FrontFacing = stage_input.gl_FrontFacing;
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
				Fragment_Stage_Output stage_output;
				stage_output.fragment_output_0 = fragment_output_0;
				return stage_output;
			}

			#endif // defined(WRITE_DECAL_BUFFER) && defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON)


			#if defined(WRITE_DECAL_BUFFER) && !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(_B_LOAD_NORM_TEX)
			#define ANY_SHADER_VARIANT_ACTIVE

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

			#endif // defined(WRITE_DECAL_BUFFER) && !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(_B_LOAD_NORM_TEX)


			#if defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)
			#define ANY_SHADER_VARIANT_ACTIVE

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

			void main(Fragment_Stage_Input stage_input)
			{
				fragment_input_1 = stage_input.fragment_input_1;
				fragment_input_2 = stage_input.fragment_input_2;
				fragment_input_3 = stage_input.fragment_input_3;
				frag_main();
			}

			#endif // defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON) && !defined(WRITE_DECAL_BUFFER)


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
			GpuProgramID 555626

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma shader_feature DECALS_3RT
			#pragma shader_feature _B_LOAD_COL_TEX
			#pragma shader_feature _B_LOAD_NORM_TEX
			#pragma shader_feature _DOUBLESIDED_ON


			#if !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_B_LOAD_NORM_TEX)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _TimeParameters;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _gameTimeAtFirstFrame;
			float _B_interpolate;
			float _B_autoPlayback;
			float _displayFrame;
			float _B_surfaceNormals;
			float _playbackSpeed;
			float _houdiniFPS;
			float _frameCount;
			float _boundMaxX;
			float _boundMaxY;
			float _boundMaxZ;
			float _boundMinX;
			float _boundMinY;
			float _boundMinZ;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[24];
			Texture2D<float4> _posTexture;
			Texture2D<float4> _rotTexture;
			SamplerState sampler_posTexture;
			SamplerState sampler_rotTexture;

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
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
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
				if ((((0.0f < vertex_uniform_buffer_2[23u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					bool vertex_unnamed_107 = 0.100000001490116119384765625f >= vertex_input_4.y;
					bool vertex_unnamed_123 = mad(vertex_uniform_buffer_2[13u].y, 10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[13u].y * 10.0f)) >= 0.5f;
					float vertex_unnamed_141 = (((-0.0f) - mad((-0.0f) - vertex_uniform_buffer_2[14u].x, 10.0f, ceil(vertex_uniform_buffer_2[14u].x * 10.0f))) + 1.0f) * vertex_input_4.x;
					float vertex_unnamed_159 = ((-0.0f) - mad(vertex_uniform_buffer_2[12u].w, -10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[12u].w * (-10.0f)))) + 1.0f;
					float vertex_unnamed_160 = vertex_unnamed_159 * (((-0.0f) - vertex_input_4.y) + 1.0f);
					float vertex_unnamed_189 = frac(((vertex_uniform_buffer_0[80u].x + ((-0.0f) - vertex_uniform_buffer_2[5u].x)) * (vertex_uniform_buffer_2[12u].y / (vertex_uniform_buffer_2[12u].z + (-0.00999999977648258209228515625f)))) * vertex_uniform_buffer_2[12u].x) * vertex_uniform_buffer_2[12u].z;
					bool vertex_unnamed_201 = 0.0f != vertex_uniform_buffer_2[6u].x;
					uint vertex_unnamed_203 = (0.0f != vertex_uniform_buffer_2[6u].z) ? 4294967295u : 0u;
					float vertex_unnamed_207 = asfloat(vertex_unnamed_201 ? asuint(floor(vertex_unnamed_189) + 1.0f) : asuint(floor(vertex_uniform_buffer_2[6u].y)));
					float vertex_unnamed_213 = vertex_unnamed_207 / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_214 = (vertex_unnamed_207 + (-1.0f)) / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_218 = frac(abs(vertex_unnamed_214));
					float vertex_unnamed_228 = 1.0f / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_232 = ((-0.0f) - mad((((vertex_unnamed_214 >= ((-0.0f) - vertex_unnamed_214)) ? vertex_unnamed_218 : ((-0.0f) - vertex_unnamed_218)) * vertex_uniform_buffer_2[12u].z) * vertex_unnamed_228, vertex_unnamed_159, vertex_unnamed_160)) + 1.0f;
					float4 vertex_unnamed_235 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_141, vertex_unnamed_232), 0.0f);
					float vertex_unnamed_238 = vertex_unnamed_235.x;
					float vertex_unnamed_239 = vertex_unnamed_235.y;
					float vertex_unnamed_240 = vertex_unnamed_235.z;
					uint4 vertex_unnamed_243 = asuint(vertex_uniform_buffer_2[13u]);
					float vertex_unnamed_245 = asfloat(vertex_unnamed_243.z);
					float vertex_unnamed_247 = asfloat(vertex_unnamed_243.w);
					float vertex_unnamed_252 = asfloat(asuint(vertex_uniform_buffer_2[14u]).x);
					float vertex_unnamed_257 = ((-0.0f) - vertex_unnamed_245) + vertex_uniform_buffer_2[12u].w;
					float vertex_unnamed_264 = ((-0.0f) - vertex_unnamed_247) + vertex_uniform_buffer_2[13u].x;
					float vertex_unnamed_265 = ((-0.0f) - vertex_unnamed_252) + vertex_uniform_buffer_2[13u].y;
					uint vertex_unnamed_275 = vertex_unnamed_123 ? asuint(vertex_unnamed_238) : asuint(mad(vertex_unnamed_238, vertex_unnamed_257, vertex_unnamed_245));
					float vertex_unnamed_276 = asfloat(vertex_unnamed_275);
					uint vertex_unnamed_277 = vertex_unnamed_123 ? asuint(vertex_unnamed_239) : asuint(mad(vertex_unnamed_239, vertex_unnamed_264, vertex_unnamed_247));
					float vertex_unnamed_278 = asfloat(vertex_unnamed_277);
					uint vertex_unnamed_279 = vertex_unnamed_123 ? asuint(vertex_unnamed_240) : asuint(mad(vertex_unnamed_240, vertex_unnamed_265, vertex_unnamed_252));
					float vertex_unnamed_280 = asfloat(vertex_unnamed_279);
					float vertex_unnamed_284 = frac(abs(vertex_unnamed_213));
					float vertex_unnamed_294 = ((-0.0f) - mad(vertex_unnamed_228 * (((vertex_unnamed_213 >= ((-0.0f) - vertex_unnamed_213)) ? vertex_unnamed_284 : ((-0.0f) - vertex_unnamed_284)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_159, vertex_unnamed_160)) + 1.0f;
					float4 vertex_unnamed_295 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_141, vertex_unnamed_294), 0.0f);
					float vertex_unnamed_297 = vertex_unnamed_295.x;
					float vertex_unnamed_298 = vertex_unnamed_295.y;
					float vertex_unnamed_299 = vertex_unnamed_295.z;
					float vertex_unnamed_322 = frac(asfloat(vertex_unnamed_201 ? asuint(vertex_unnamed_189) : asuint(vertex_uniform_buffer_2[6u]).y));
					bool vertex_unnamed_335 = 0.0f != vertex_uniform_buffer_2[5u].y;
					float vertex_unnamed_358 = asfloat(vertex_unnamed_107 ? 0u : asuint(asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_276) + asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_297) : asuint(mad(vertex_unnamed_297, vertex_unnamed_257, vertex_unnamed_245))), vertex_unnamed_276)) : vertex_unnamed_275) + vertex_input_0.x));
					float vertex_unnamed_360 = asfloat(vertex_unnamed_107 ? 0u : asuint(asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_278) + asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_298) : asuint(mad(vertex_unnamed_298, vertex_unnamed_264, vertex_unnamed_247))), vertex_unnamed_278)) : vertex_unnamed_277) + vertex_input_0.y));
					float vertex_unnamed_362 = asfloat(vertex_unnamed_107 ? 0u : asuint(asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_280) + asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_299) : asuint(mad(vertex_unnamed_299, vertex_unnamed_265, vertex_unnamed_252))), vertex_unnamed_280)) : vertex_unnamed_279) + vertex_input_0.z));
					float4 vertex_unnamed_364 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_141, vertex_unnamed_232), 0.0f);
					float vertex_unnamed_366 = vertex_unnamed_364.x;
					float vertex_unnamed_367 = vertex_unnamed_364.y;
					float vertex_unnamed_368 = vertex_unnamed_364.z;
					float vertex_unnamed_369 = vertex_unnamed_364.w;
					float vertex_unnamed_370 = vertex_unnamed_366 + (-0.5f);
					float vertex_unnamed_372 = vertex_unnamed_367 + (-0.5f);
					float vertex_unnamed_373 = vertex_unnamed_368 + (-0.5f);
					float vertex_unnamed_374 = vertex_unnamed_369 + (-0.5f);
					float vertex_unnamed_388 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_366) : asuint(vertex_unnamed_370 + vertex_unnamed_370));
					float vertex_unnamed_390 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_367) : asuint(vertex_unnamed_372 + vertex_unnamed_372));
					float vertex_unnamed_392 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_368) : asuint(vertex_unnamed_373 + vertex_unnamed_373));
					float vertex_unnamed_394 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_369) : asuint(vertex_unnamed_374 + vertex_unnamed_374));
					float vertex_unnamed_404 = mad(vertex_unnamed_394, 1.0f, mad(vertex_unnamed_392, 0.0f, (-0.0f) - (vertex_unnamed_388 * 0.0f)));
					float vertex_unnamed_405 = mad(vertex_unnamed_394, 0.0f, mad(vertex_unnamed_388, 1.0f, (-0.0f) - (vertex_unnamed_390 * 0.0f)));
					float vertex_unnamed_406 = mad(vertex_unnamed_394, 0.0f, mad(vertex_unnamed_390, 0.0f, (-0.0f) - (vertex_unnamed_392 * 1.0f)));
					float vertex_unnamed_416 = mad(mad(vertex_unnamed_390, vertex_unnamed_405, (-0.0f) - (vertex_unnamed_404 * vertex_unnamed_392)), 2.0f, 0.0f);
					float vertex_unnamed_418 = mad(mad(vertex_unnamed_392, vertex_unnamed_406, (-0.0f) - (vertex_unnamed_405 * vertex_unnamed_388)), 2.0f, 1.0f);
					float vertex_unnamed_419 = mad(mad(vertex_unnamed_388, vertex_unnamed_404, (-0.0f) - (vertex_unnamed_406 * vertex_unnamed_390)), 2.0f, 0.0f);
					float4 vertex_unnamed_420 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_141, vertex_unnamed_294), 0.0f);
					float vertex_unnamed_422 = vertex_unnamed_420.x;
					float vertex_unnamed_423 = vertex_unnamed_420.y;
					float vertex_unnamed_424 = vertex_unnamed_420.z;
					float vertex_unnamed_425 = vertex_unnamed_420.w;
					float vertex_unnamed_426 = vertex_unnamed_422 + (-0.5f);
					float vertex_unnamed_427 = vertex_unnamed_423 + (-0.5f);
					float vertex_unnamed_428 = vertex_unnamed_424 + (-0.5f);
					float vertex_unnamed_429 = vertex_unnamed_425 + (-0.5f);
					float vertex_unnamed_443 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_422) : asuint(vertex_unnamed_426 + vertex_unnamed_426));
					float vertex_unnamed_445 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_423) : asuint(vertex_unnamed_427 + vertex_unnamed_427));
					float vertex_unnamed_447 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_424) : asuint(vertex_unnamed_428 + vertex_unnamed_428));
					float vertex_unnamed_449 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_425) : asuint(vertex_unnamed_429 + vertex_unnamed_429));
					float vertex_unnamed_459 = mad(vertex_unnamed_449, 1.0f, mad(vertex_unnamed_447, 0.0f, (-0.0f) - (vertex_unnamed_443 * 0.0f)));
					float vertex_unnamed_460 = mad(vertex_unnamed_449, 0.0f, mad(vertex_unnamed_443, 1.0f, (-0.0f) - (vertex_unnamed_445 * 0.0f)));
					float vertex_unnamed_461 = mad(vertex_unnamed_449, 0.0f, mad(vertex_unnamed_445, 0.0f, (-0.0f) - (vertex_unnamed_447 * 1.0f)));
					float vertex_unnamed_490 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_416) + mad(mad(vertex_unnamed_445, vertex_unnamed_460, (-0.0f) - (vertex_unnamed_447 * vertex_unnamed_459)), 2.0f, 0.0f), vertex_unnamed_416)) : asuint(vertex_unnamed_416));
					float vertex_unnamed_492 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_418) + mad(mad(vertex_unnamed_447, vertex_unnamed_461, (-0.0f) - (vertex_unnamed_443 * vertex_unnamed_460)), 2.0f, 1.0f), vertex_unnamed_418)) : asuint(vertex_unnamed_418));
					float vertex_unnamed_494 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_419) + mad(mad(vertex_unnamed_443, vertex_unnamed_459, (-0.0f) - (vertex_unnamed_445 * vertex_unnamed_461)), 2.0f, 0.0f), vertex_unnamed_419)) : asuint(vertex_unnamed_419));
					float vertex_unnamed_498 = rsqrt(dot(float3(vertex_unnamed_490, vertex_unnamed_492, vertex_unnamed_494), float3(vertex_unnamed_490, vertex_unnamed_492, vertex_unnamed_494)));
					float vertex_unnamed_499 = vertex_unnamed_498 * vertex_unnamed_490;
					float vertex_unnamed_500 = vertex_unnamed_498 * vertex_unnamed_492;
					float vertex_unnamed_501 = vertex_unnamed_498 * vertex_unnamed_494;
					float vertex_unnamed_511 = mad(vertex_unnamed_394, 0.0f, mad(vertex_unnamed_392, -1.0f, (-0.0f) - (vertex_unnamed_388 * 0.0f)));
					float vertex_unnamed_512 = mad(vertex_unnamed_394, 0.0f, mad(vertex_unnamed_388, 0.0f, (-0.0f) - (vertex_unnamed_390 * (-1.0f))));
					float vertex_unnamed_513 = mad(vertex_unnamed_394, -1.0f, mad(vertex_unnamed_390, 0.0f, (-0.0f) - (vertex_unnamed_392 * 0.0f)));
					float vertex_unnamed_523 = mad(mad(vertex_unnamed_390, vertex_unnamed_512, (-0.0f) - (vertex_unnamed_392 * vertex_unnamed_511)), 2.0f, -1.0f);
					float vertex_unnamed_524 = mad(mad(vertex_unnamed_392, vertex_unnamed_513, (-0.0f) - (vertex_unnamed_388 * vertex_unnamed_512)), 2.0f, 0.0f);
					float vertex_unnamed_525 = mad(mad(vertex_unnamed_388, vertex_unnamed_511, (-0.0f) - (vertex_unnamed_390 * vertex_unnamed_513)), 2.0f, 0.0f);
					float vertex_unnamed_535 = mad(vertex_unnamed_449, 0.0f, mad(vertex_unnamed_447, -1.0f, (-0.0f) - (vertex_unnamed_443 * 0.0f)));
					float vertex_unnamed_536 = mad(vertex_unnamed_449, 0.0f, mad(vertex_unnamed_443, 0.0f, (-0.0f) - (vertex_unnamed_445 * (-1.0f))));
					float vertex_unnamed_537 = mad(vertex_unnamed_449, -1.0f, mad(vertex_unnamed_445, 0.0f, (-0.0f) - (vertex_unnamed_447 * 0.0f)));
					float vertex_unnamed_566 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_523) + mad(mad(vertex_unnamed_445, vertex_unnamed_536, (-0.0f) - (vertex_unnamed_447 * vertex_unnamed_535)), 2.0f, -1.0f), vertex_unnamed_523)) : asuint(vertex_unnamed_523));
					float vertex_unnamed_568 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_524) + mad(mad(vertex_unnamed_447, vertex_unnamed_537, (-0.0f) - (vertex_unnamed_443 * vertex_unnamed_536)), 2.0f, 0.0f), vertex_unnamed_524)) : asuint(vertex_unnamed_524));
					float vertex_unnamed_570 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_525) + mad(mad(vertex_unnamed_443, vertex_unnamed_535, (-0.0f) - (vertex_unnamed_445 * vertex_unnamed_537)), 2.0f, 0.0f), vertex_unnamed_525)) : asuint(vertex_unnamed_525));
					float vertex_unnamed_574 = rsqrt(dot(float3(vertex_unnamed_566, vertex_unnamed_568, vertex_unnamed_570), float3(vertex_unnamed_566, vertex_unnamed_568, vertex_unnamed_570)));
					float vertex_unnamed_582 = asfloat(asuint(vertex_unnamed_574 * vertex_unnamed_566) & vertex_unnamed_203);
					float vertex_unnamed_584 = asfloat(asuint(vertex_unnamed_574 * vertex_unnamed_568) & vertex_unnamed_203);
					float vertex_unnamed_586 = asfloat(asuint(vertex_unnamed_574 * vertex_unnamed_570) & vertex_unnamed_203);
					float vertex_unnamed_619 = asfloat(1065353216u);
					float vertex_unnamed_621 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_358, vertex_unnamed_360, vertex_unnamed_362, vertex_unnamed_619));
					float vertex_unnamed_639 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_358, vertex_unnamed_360, vertex_unnamed_362, vertex_unnamed_619));
					float vertex_unnamed_657 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_358, vertex_unnamed_360, vertex_unnamed_362, vertex_unnamed_619));
					float vertex_unnamed_666 = dot(float3(vertex_unnamed_499, vertex_unnamed_500, vertex_unnamed_501), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_674 = dot(float3(vertex_unnamed_499, vertex_unnamed_500, vertex_unnamed_501), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_682 = dot(float3(vertex_unnamed_499, vertex_unnamed_500, vertex_unnamed_501), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_690 = rsqrt(max(dot(float3(vertex_unnamed_666, vertex_unnamed_674, vertex_unnamed_682), float3(vertex_unnamed_666, vertex_unnamed_674, vertex_unnamed_682)), 1.1754943508222875079687365372222e-38f));
					vertex_output_6.x = vertex_unnamed_690 * vertex_unnamed_666;
					vertex_output_6.y = vertex_unnamed_690 * vertex_unnamed_674;
					vertex_output_6.z = vertex_unnamed_690 * vertex_unnamed_682;
					float vertex_unnamed_718 = mad(vertex_uniform_buffer_1[2u].x, vertex_unnamed_586, mad(vertex_uniform_buffer_1[0u].x, vertex_unnamed_582, vertex_unnamed_584 * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_719 = mad(vertex_uniform_buffer_1[2u].y, vertex_unnamed_586, mad(vertex_uniform_buffer_1[0u].y, vertex_unnamed_582, vertex_unnamed_584 * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_720 = mad(vertex_uniform_buffer_1[2u].z, vertex_unnamed_586, mad(vertex_uniform_buffer_1[0u].z, vertex_unnamed_582, vertex_unnamed_584 * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_725 = rsqrt(max(dot(float3(vertex_unnamed_718, vertex_unnamed_719, vertex_unnamed_720), float3(vertex_unnamed_718, vertex_unnamed_719, vertex_unnamed_720)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_725 * vertex_unnamed_718;
					vertex_output_1.y = vertex_unnamed_725 * vertex_unnamed_719;
					vertex_output_1.z = vertex_unnamed_725 * vertex_unnamed_720;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_657, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_621, vertex_unnamed_639 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_657, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_621, vertex_unnamed_639 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_657, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_621, vertex_unnamed_639 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_657, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_621, vertex_unnamed_639 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_5.x = vertex_unnamed_621;
					vertex_output_5.y = vertex_unnamed_639;
					vertex_output_5.z = vertex_unnamed_657;
				}
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[5] = float4(_gameTimeAtFirstFrame, vertex_uniform_buffer_2[5][1], vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], _B_interpolate, vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[6] = float4(_B_autoPlayback, vertex_uniform_buffer_2[6][1], vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _displayFrame, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], vertex_uniform_buffer_2[6][1], _B_surfaceNormals, vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[12] = float4(_playbackSpeed, vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], _houdiniFPS, vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _frameCount, vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], _boundMaxX);

				vertex_uniform_buffer_2[13] = float4(_boundMaxY, vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], _boundMaxZ, vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _boundMinX, vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], _boundMinY);

				vertex_uniform_buffer_2[14] = float4(_boundMinZ, vertex_uniform_buffer_2[14][1], vertex_uniform_buffer_2[14][2], vertex_uniform_buffer_2[14][3]);

				vertex_uniform_buffer_2[23] = float4(vertex_uniform_buffer_2[23][0], vertex_uniform_buffer_2[23][1], _RayTracing, vertex_uniform_buffer_2[23][3]);

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

			#endif // !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_B_LOAD_NORM_TEX)


			#if defined(_B_LOAD_COL_TEX) && defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_B_LOAD_NORM_TEX)
			#define ANY_SHADER_VARIANT_ACTIVE

			float4x4 _ViewProjMatrix;
			float4 _WorldSpaceCameraPos_Internal;
			float4 _TimeParameters;
			int _EnableRecursiveRayTracing;
			float4x4 unity_ObjectToWorld;
			float4x4 unity_WorldToObject;
			float _gameTimeAtFirstFrame;
			float _B_interpolate;
			float _B_autoPlayback;
			float _displayFrame;
			float _B_surfaceNormals;
			float _playbackSpeed;
			float _houdiniFPS;
			float _frameCount;
			float _boundMaxX;
			float _boundMaxY;
			float _boundMaxZ;
			float _boundMinX;
			float _boundMinY;
			float _boundMinZ;
			float _RayTracing;

			static float4 vertex_uniform_buffer_0[214];
			static float4 vertex_uniform_buffer_1[8];
			static float4 vertex_uniform_buffer_2[24];
			Texture2D<float4> _posTexture;
			Texture2D<float4> _rotTexture;
			SamplerState sampler_posTexture;
			SamplerState sampler_rotTexture;

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
				float4 vertex_input_3 : TEXCOORD; // TEXCOORD
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
				if ((((0.0f < vertex_uniform_buffer_2[23u].z) ? 4294967295u : 0u) & ((asuint(vertex_uniform_buffer_0[213u]).w != 0u) ? 4294967295u : 0u)) != 0u)
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
					bool vertex_unnamed_107 = 0.100000001490116119384765625f >= vertex_input_4.y;
					bool vertex_unnamed_123 = mad(vertex_uniform_buffer_2[13u].y, 10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[13u].y * 10.0f)) >= 0.5f;
					float vertex_unnamed_141 = (((-0.0f) - mad((-0.0f) - vertex_uniform_buffer_2[14u].x, 10.0f, ceil(vertex_uniform_buffer_2[14u].x * 10.0f))) + 1.0f) * vertex_input_4.x;
					float vertex_unnamed_159 = ((-0.0f) - mad(vertex_uniform_buffer_2[12u].w, -10.0f, (-0.0f) - floor(vertex_uniform_buffer_2[12u].w * (-10.0f)))) + 1.0f;
					float vertex_unnamed_160 = vertex_unnamed_159 * (((-0.0f) - vertex_input_4.y) + 1.0f);
					float vertex_unnamed_189 = frac(((vertex_uniform_buffer_0[80u].x + ((-0.0f) - vertex_uniform_buffer_2[5u].x)) * (vertex_uniform_buffer_2[12u].y / (vertex_uniform_buffer_2[12u].z + (-0.00999999977648258209228515625f)))) * vertex_uniform_buffer_2[12u].x) * vertex_uniform_buffer_2[12u].z;
					bool vertex_unnamed_201 = 0.0f != vertex_uniform_buffer_2[6u].x;
					uint vertex_unnamed_203 = (0.0f != vertex_uniform_buffer_2[6u].z) ? 4294967295u : 0u;
					float vertex_unnamed_207 = asfloat(vertex_unnamed_201 ? asuint(floor(vertex_unnamed_189) + 1.0f) : asuint(floor(vertex_uniform_buffer_2[6u].y)));
					float vertex_unnamed_213 = vertex_unnamed_207 / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_214 = (vertex_unnamed_207 + (-1.0f)) / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_218 = frac(abs(vertex_unnamed_214));
					float vertex_unnamed_228 = 1.0f / vertex_uniform_buffer_2[12u].z;
					float vertex_unnamed_232 = ((-0.0f) - mad((((vertex_unnamed_214 >= ((-0.0f) - vertex_unnamed_214)) ? vertex_unnamed_218 : ((-0.0f) - vertex_unnamed_218)) * vertex_uniform_buffer_2[12u].z) * vertex_unnamed_228, vertex_unnamed_159, vertex_unnamed_160)) + 1.0f;
					float4 vertex_unnamed_235 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_141, vertex_unnamed_232), 0.0f);
					float vertex_unnamed_238 = vertex_unnamed_235.x;
					float vertex_unnamed_239 = vertex_unnamed_235.y;
					float vertex_unnamed_240 = vertex_unnamed_235.z;
					uint4 vertex_unnamed_243 = asuint(vertex_uniform_buffer_2[13u]);
					float vertex_unnamed_245 = asfloat(vertex_unnamed_243.z);
					float vertex_unnamed_247 = asfloat(vertex_unnamed_243.w);
					float vertex_unnamed_252 = asfloat(asuint(vertex_uniform_buffer_2[14u]).x);
					float vertex_unnamed_257 = ((-0.0f) - vertex_unnamed_245) + vertex_uniform_buffer_2[12u].w;
					float vertex_unnamed_264 = ((-0.0f) - vertex_unnamed_247) + vertex_uniform_buffer_2[13u].x;
					float vertex_unnamed_265 = ((-0.0f) - vertex_unnamed_252) + vertex_uniform_buffer_2[13u].y;
					uint vertex_unnamed_275 = vertex_unnamed_123 ? asuint(vertex_unnamed_238) : asuint(mad(vertex_unnamed_238, vertex_unnamed_257, vertex_unnamed_245));
					float vertex_unnamed_276 = asfloat(vertex_unnamed_275);
					uint vertex_unnamed_277 = vertex_unnamed_123 ? asuint(vertex_unnamed_239) : asuint(mad(vertex_unnamed_239, vertex_unnamed_264, vertex_unnamed_247));
					float vertex_unnamed_278 = asfloat(vertex_unnamed_277);
					uint vertex_unnamed_279 = vertex_unnamed_123 ? asuint(vertex_unnamed_240) : asuint(mad(vertex_unnamed_240, vertex_unnamed_265, vertex_unnamed_252));
					float vertex_unnamed_280 = asfloat(vertex_unnamed_279);
					float vertex_unnamed_284 = frac(abs(vertex_unnamed_213));
					float vertex_unnamed_294 = ((-0.0f) - mad(vertex_unnamed_228 * (((vertex_unnamed_213 >= ((-0.0f) - vertex_unnamed_213)) ? vertex_unnamed_284 : ((-0.0f) - vertex_unnamed_284)) * vertex_uniform_buffer_2[12u].z), vertex_unnamed_159, vertex_unnamed_160)) + 1.0f;
					float4 vertex_unnamed_295 = _posTexture.SampleLevel(sampler_posTexture, float2(vertex_unnamed_141, vertex_unnamed_294), 0.0f);
					float vertex_unnamed_297 = vertex_unnamed_295.x;
					float vertex_unnamed_298 = vertex_unnamed_295.y;
					float vertex_unnamed_299 = vertex_unnamed_295.z;
					float vertex_unnamed_322 = frac(asfloat(vertex_unnamed_201 ? asuint(vertex_unnamed_189) : asuint(vertex_uniform_buffer_2[6u]).y));
					bool vertex_unnamed_335 = 0.0f != vertex_uniform_buffer_2[5u].y;
					float vertex_unnamed_358 = asfloat(vertex_unnamed_107 ? 0u : asuint(asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_276) + asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_297) : asuint(mad(vertex_unnamed_297, vertex_unnamed_257, vertex_unnamed_245))), vertex_unnamed_276)) : vertex_unnamed_275) + vertex_input_0.x));
					float vertex_unnamed_360 = asfloat(vertex_unnamed_107 ? 0u : asuint(asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_278) + asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_298) : asuint(mad(vertex_unnamed_298, vertex_unnamed_264, vertex_unnamed_247))), vertex_unnamed_278)) : vertex_unnamed_277) + vertex_input_0.y));
					float vertex_unnamed_362 = asfloat(vertex_unnamed_107 ? 0u : asuint(asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_280) + asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_299) : asuint(mad(vertex_unnamed_299, vertex_unnamed_265, vertex_unnamed_252))), vertex_unnamed_280)) : vertex_unnamed_279) + vertex_input_0.z));
					float4 vertex_unnamed_364 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_141, vertex_unnamed_232), 0.0f);
					float vertex_unnamed_366 = vertex_unnamed_364.x;
					float vertex_unnamed_367 = vertex_unnamed_364.y;
					float vertex_unnamed_368 = vertex_unnamed_364.z;
					float vertex_unnamed_369 = vertex_unnamed_364.w;
					float vertex_unnamed_370 = vertex_unnamed_366 + (-0.5f);
					float vertex_unnamed_372 = vertex_unnamed_367 + (-0.5f);
					float vertex_unnamed_373 = vertex_unnamed_368 + (-0.5f);
					float vertex_unnamed_374 = vertex_unnamed_369 + (-0.5f);
					float vertex_unnamed_388 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_366) : asuint(vertex_unnamed_370 + vertex_unnamed_370));
					float vertex_unnamed_390 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_367) : asuint(vertex_unnamed_372 + vertex_unnamed_372));
					float vertex_unnamed_392 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_368) : asuint(vertex_unnamed_373 + vertex_unnamed_373));
					float vertex_unnamed_394 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_369) : asuint(vertex_unnamed_374 + vertex_unnamed_374));
					float vertex_unnamed_404 = mad(vertex_unnamed_394, 1.0f, mad(vertex_unnamed_392, 0.0f, (-0.0f) - (vertex_unnamed_388 * 0.0f)));
					float vertex_unnamed_405 = mad(vertex_unnamed_394, 0.0f, mad(vertex_unnamed_388, 1.0f, (-0.0f) - (vertex_unnamed_390 * 0.0f)));
					float vertex_unnamed_406 = mad(vertex_unnamed_394, 0.0f, mad(vertex_unnamed_390, 0.0f, (-0.0f) - (vertex_unnamed_392 * 1.0f)));
					float vertex_unnamed_416 = mad(mad(vertex_unnamed_390, vertex_unnamed_405, (-0.0f) - (vertex_unnamed_404 * vertex_unnamed_392)), 2.0f, 0.0f);
					float vertex_unnamed_418 = mad(mad(vertex_unnamed_392, vertex_unnamed_406, (-0.0f) - (vertex_unnamed_405 * vertex_unnamed_388)), 2.0f, 1.0f);
					float vertex_unnamed_419 = mad(mad(vertex_unnamed_388, vertex_unnamed_404, (-0.0f) - (vertex_unnamed_406 * vertex_unnamed_390)), 2.0f, 0.0f);
					float4 vertex_unnamed_420 = _rotTexture.SampleLevel(sampler_rotTexture, float2(vertex_unnamed_141, vertex_unnamed_294), 0.0f);
					float vertex_unnamed_422 = vertex_unnamed_420.x;
					float vertex_unnamed_423 = vertex_unnamed_420.y;
					float vertex_unnamed_424 = vertex_unnamed_420.z;
					float vertex_unnamed_425 = vertex_unnamed_420.w;
					float vertex_unnamed_426 = vertex_unnamed_422 + (-0.5f);
					float vertex_unnamed_427 = vertex_unnamed_423 + (-0.5f);
					float vertex_unnamed_428 = vertex_unnamed_424 + (-0.5f);
					float vertex_unnamed_429 = vertex_unnamed_425 + (-0.5f);
					float vertex_unnamed_443 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_422) : asuint(vertex_unnamed_426 + vertex_unnamed_426));
					float vertex_unnamed_445 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_423) : asuint(vertex_unnamed_427 + vertex_unnamed_427));
					float vertex_unnamed_447 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_424) : asuint(vertex_unnamed_428 + vertex_unnamed_428));
					float vertex_unnamed_449 = asfloat(vertex_unnamed_123 ? asuint(vertex_unnamed_425) : asuint(vertex_unnamed_429 + vertex_unnamed_429));
					float vertex_unnamed_459 = mad(vertex_unnamed_449, 1.0f, mad(vertex_unnamed_447, 0.0f, (-0.0f) - (vertex_unnamed_443 * 0.0f)));
					float vertex_unnamed_460 = mad(vertex_unnamed_449, 0.0f, mad(vertex_unnamed_443, 1.0f, (-0.0f) - (vertex_unnamed_445 * 0.0f)));
					float vertex_unnamed_461 = mad(vertex_unnamed_449, 0.0f, mad(vertex_unnamed_445, 0.0f, (-0.0f) - (vertex_unnamed_447 * 1.0f)));
					float vertex_unnamed_490 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_416) + mad(mad(vertex_unnamed_445, vertex_unnamed_460, (-0.0f) - (vertex_unnamed_447 * vertex_unnamed_459)), 2.0f, 0.0f), vertex_unnamed_416)) : asuint(vertex_unnamed_416));
					float vertex_unnamed_492 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_418) + mad(mad(vertex_unnamed_447, vertex_unnamed_461, (-0.0f) - (vertex_unnamed_443 * vertex_unnamed_460)), 2.0f, 1.0f), vertex_unnamed_418)) : asuint(vertex_unnamed_418));
					float vertex_unnamed_494 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_419) + mad(mad(vertex_unnamed_443, vertex_unnamed_459, (-0.0f) - (vertex_unnamed_445 * vertex_unnamed_461)), 2.0f, 0.0f), vertex_unnamed_419)) : asuint(vertex_unnamed_419));
					float vertex_unnamed_498 = rsqrt(dot(float3(vertex_unnamed_490, vertex_unnamed_492, vertex_unnamed_494), float3(vertex_unnamed_490, vertex_unnamed_492, vertex_unnamed_494)));
					float vertex_unnamed_499 = vertex_unnamed_498 * vertex_unnamed_490;
					float vertex_unnamed_500 = vertex_unnamed_498 * vertex_unnamed_492;
					float vertex_unnamed_501 = vertex_unnamed_498 * vertex_unnamed_494;
					float vertex_unnamed_511 = mad(vertex_unnamed_394, 0.0f, mad(vertex_unnamed_392, -1.0f, (-0.0f) - (vertex_unnamed_388 * 0.0f)));
					float vertex_unnamed_512 = mad(vertex_unnamed_394, 0.0f, mad(vertex_unnamed_388, 0.0f, (-0.0f) - (vertex_unnamed_390 * (-1.0f))));
					float vertex_unnamed_513 = mad(vertex_unnamed_394, -1.0f, mad(vertex_unnamed_390, 0.0f, (-0.0f) - (vertex_unnamed_392 * 0.0f)));
					float vertex_unnamed_523 = mad(mad(vertex_unnamed_390, vertex_unnamed_512, (-0.0f) - (vertex_unnamed_392 * vertex_unnamed_511)), 2.0f, -1.0f);
					float vertex_unnamed_524 = mad(mad(vertex_unnamed_392, vertex_unnamed_513, (-0.0f) - (vertex_unnamed_388 * vertex_unnamed_512)), 2.0f, 0.0f);
					float vertex_unnamed_525 = mad(mad(vertex_unnamed_388, vertex_unnamed_511, (-0.0f) - (vertex_unnamed_390 * vertex_unnamed_513)), 2.0f, 0.0f);
					float vertex_unnamed_535 = mad(vertex_unnamed_449, 0.0f, mad(vertex_unnamed_447, -1.0f, (-0.0f) - (vertex_unnamed_443 * 0.0f)));
					float vertex_unnamed_536 = mad(vertex_unnamed_449, 0.0f, mad(vertex_unnamed_443, 0.0f, (-0.0f) - (vertex_unnamed_445 * (-1.0f))));
					float vertex_unnamed_537 = mad(vertex_unnamed_449, -1.0f, mad(vertex_unnamed_445, 0.0f, (-0.0f) - (vertex_unnamed_447 * 0.0f)));
					float vertex_unnamed_566 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_523) + mad(mad(vertex_unnamed_445, vertex_unnamed_536, (-0.0f) - (vertex_unnamed_447 * vertex_unnamed_535)), 2.0f, -1.0f), vertex_unnamed_523)) : asuint(vertex_unnamed_523));
					float vertex_unnamed_568 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_524) + mad(mad(vertex_unnamed_447, vertex_unnamed_537, (-0.0f) - (vertex_unnamed_443 * vertex_unnamed_536)), 2.0f, 0.0f), vertex_unnamed_524)) : asuint(vertex_unnamed_524));
					float vertex_unnamed_570 = asfloat(vertex_unnamed_335 ? asuint(mad(vertex_unnamed_322, ((-0.0f) - vertex_unnamed_525) + mad(mad(vertex_unnamed_443, vertex_unnamed_535, (-0.0f) - (vertex_unnamed_445 * vertex_unnamed_537)), 2.0f, 0.0f), vertex_unnamed_525)) : asuint(vertex_unnamed_525));
					float vertex_unnamed_574 = rsqrt(dot(float3(vertex_unnamed_566, vertex_unnamed_568, vertex_unnamed_570), float3(vertex_unnamed_566, vertex_unnamed_568, vertex_unnamed_570)));
					float vertex_unnamed_582 = asfloat(asuint(vertex_unnamed_574 * vertex_unnamed_566) & vertex_unnamed_203);
					float vertex_unnamed_584 = asfloat(asuint(vertex_unnamed_574 * vertex_unnamed_568) & vertex_unnamed_203);
					float vertex_unnamed_586 = asfloat(asuint(vertex_unnamed_574 * vertex_unnamed_570) & vertex_unnamed_203);
					float vertex_unnamed_619 = asfloat(1065353216u);
					float vertex_unnamed_621 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).x), asfloat(asuint(vertex_uniform_buffer_1[1u]).x), asfloat(asuint(vertex_uniform_buffer_1[2u]).x), ((-0.0f) - vertex_uniform_buffer_0[48u].x) + vertex_uniform_buffer_1[3u].x), float4(vertex_unnamed_358, vertex_unnamed_360, vertex_unnamed_362, vertex_unnamed_619));
					float vertex_unnamed_639 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).y), asfloat(asuint(vertex_uniform_buffer_1[1u]).y), asfloat(asuint(vertex_uniform_buffer_1[2u]).y), ((-0.0f) - vertex_uniform_buffer_0[48u].y) + vertex_uniform_buffer_1[3u].y), float4(vertex_unnamed_358, vertex_unnamed_360, vertex_unnamed_362, vertex_unnamed_619));
					float vertex_unnamed_657 = dot(float4(asfloat(asuint(vertex_uniform_buffer_1[0u]).z), asfloat(asuint(vertex_uniform_buffer_1[1u]).z), asfloat(asuint(vertex_uniform_buffer_1[2u]).z), ((-0.0f) - vertex_uniform_buffer_0[48u].z) + vertex_uniform_buffer_1[3u].z), float4(vertex_unnamed_358, vertex_unnamed_360, vertex_unnamed_362, vertex_unnamed_619));
					float vertex_unnamed_666 = dot(float3(vertex_unnamed_499, vertex_unnamed_500, vertex_unnamed_501), float3(vertex_uniform_buffer_1[4u].xyz));
					float vertex_unnamed_674 = dot(float3(vertex_unnamed_499, vertex_unnamed_500, vertex_unnamed_501), float3(vertex_uniform_buffer_1[5u].xyz));
					float vertex_unnamed_682 = dot(float3(vertex_unnamed_499, vertex_unnamed_500, vertex_unnamed_501), float3(vertex_uniform_buffer_1[6u].xyz));
					float vertex_unnamed_690 = rsqrt(max(dot(float3(vertex_unnamed_666, vertex_unnamed_674, vertex_unnamed_682), float3(vertex_unnamed_666, vertex_unnamed_674, vertex_unnamed_682)), 1.1754943508222875079687365372222e-38f));
					vertex_output_6.x = vertex_unnamed_690 * vertex_unnamed_666;
					vertex_output_6.y = vertex_unnamed_690 * vertex_unnamed_674;
					vertex_output_6.z = vertex_unnamed_690 * vertex_unnamed_682;
					float vertex_unnamed_718 = mad(vertex_uniform_buffer_1[2u].x, vertex_unnamed_586, mad(vertex_uniform_buffer_1[0u].x, vertex_unnamed_582, vertex_unnamed_584 * vertex_uniform_buffer_1[1u].x));
					float vertex_unnamed_719 = mad(vertex_uniform_buffer_1[2u].y, vertex_unnamed_586, mad(vertex_uniform_buffer_1[0u].y, vertex_unnamed_582, vertex_unnamed_584 * vertex_uniform_buffer_1[1u].y));
					float vertex_unnamed_720 = mad(vertex_uniform_buffer_1[2u].z, vertex_unnamed_586, mad(vertex_uniform_buffer_1[0u].z, vertex_unnamed_582, vertex_unnamed_584 * vertex_uniform_buffer_1[1u].z));
					float vertex_unnamed_725 = rsqrt(max(dot(float3(vertex_unnamed_718, vertex_unnamed_719, vertex_unnamed_720), float3(vertex_unnamed_718, vertex_unnamed_719, vertex_unnamed_720)), 1.1754943508222875079687365372222e-38f));
					vertex_output_1.x = vertex_unnamed_725 * vertex_unnamed_718;
					vertex_output_1.y = vertex_unnamed_725 * vertex_unnamed_719;
					vertex_output_1.z = vertex_unnamed_725 * vertex_unnamed_720;
					gl_Position.x = mad(vertex_uniform_buffer_0[22u].x, vertex_unnamed_657, mad(vertex_uniform_buffer_0[20u].x, vertex_unnamed_621, vertex_unnamed_639 * vertex_uniform_buffer_0[21u].x)) + vertex_uniform_buffer_0[23u].x;
					gl_Position.y = mad(vertex_uniform_buffer_0[22u].y, vertex_unnamed_657, mad(vertex_uniform_buffer_0[20u].y, vertex_unnamed_621, vertex_unnamed_639 * vertex_uniform_buffer_0[21u].y)) + vertex_uniform_buffer_0[23u].y;
					gl_Position.z = mad(vertex_uniform_buffer_0[22u].z, vertex_unnamed_657, mad(vertex_uniform_buffer_0[20u].z, vertex_unnamed_621, vertex_unnamed_639 * vertex_uniform_buffer_0[21u].z)) + vertex_uniform_buffer_0[23u].z;
					gl_Position.w = mad(vertex_uniform_buffer_0[22u].w, vertex_unnamed_657, mad(vertex_uniform_buffer_0[20u].w, vertex_unnamed_621, vertex_unnamed_639 * vertex_uniform_buffer_0[21u].w)) + vertex_uniform_buffer_0[23u].w;
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
					vertex_output_5.x = vertex_unnamed_621;
					vertex_output_5.y = vertex_unnamed_639;
					vertex_output_5.z = vertex_unnamed_657;
				}
			}

			Vertex_Stage_Output vert(Vertex_Stage_Input stage_input)
			{
				vertex_uniform_buffer_0[20] = float4(_ViewProjMatrix[0][0], _ViewProjMatrix[1][0], _ViewProjMatrix[2][0], _ViewProjMatrix[3][0]);
				vertex_uniform_buffer_0[21] = float4(_ViewProjMatrix[0][1], _ViewProjMatrix[1][1], _ViewProjMatrix[2][1], _ViewProjMatrix[3][1]);
				vertex_uniform_buffer_0[22] = float4(_ViewProjMatrix[0][2], _ViewProjMatrix[1][2], _ViewProjMatrix[2][2], _ViewProjMatrix[3][2]);
				vertex_uniform_buffer_0[23] = float4(_ViewProjMatrix[0][3], _ViewProjMatrix[1][3], _ViewProjMatrix[2][3], _ViewProjMatrix[3][3]);

				vertex_uniform_buffer_0[48] = float4(_WorldSpaceCameraPos_Internal[0], _WorldSpaceCameraPos_Internal[1], _WorldSpaceCameraPos_Internal[2], _WorldSpaceCameraPos_Internal[3]);

				vertex_uniform_buffer_0[80] = float4(_TimeParameters[0], _TimeParameters[1], _TimeParameters[2], _TimeParameters[3]);

				vertex_uniform_buffer_0[213] = float4(vertex_uniform_buffer_0[213][0], vertex_uniform_buffer_0[213][1], vertex_uniform_buffer_0[213][2], asfloat(_EnableRecursiveRayTracing));

				vertex_uniform_buffer_1[0] = float4(unity_ObjectToWorld[0][0], unity_ObjectToWorld[1][0], unity_ObjectToWorld[2][0], unity_ObjectToWorld[3][0]);
				vertex_uniform_buffer_1[1] = float4(unity_ObjectToWorld[0][1], unity_ObjectToWorld[1][1], unity_ObjectToWorld[2][1], unity_ObjectToWorld[3][1]);
				vertex_uniform_buffer_1[2] = float4(unity_ObjectToWorld[0][2], unity_ObjectToWorld[1][2], unity_ObjectToWorld[2][2], unity_ObjectToWorld[3][2]);
				vertex_uniform_buffer_1[3] = float4(unity_ObjectToWorld[0][3], unity_ObjectToWorld[1][3], unity_ObjectToWorld[2][3], unity_ObjectToWorld[3][3]);

				vertex_uniform_buffer_1[4] = float4(unity_WorldToObject[0][0], unity_WorldToObject[1][0], unity_WorldToObject[2][0], unity_WorldToObject[3][0]);
				vertex_uniform_buffer_1[5] = float4(unity_WorldToObject[0][1], unity_WorldToObject[1][1], unity_WorldToObject[2][1], unity_WorldToObject[3][1]);
				vertex_uniform_buffer_1[6] = float4(unity_WorldToObject[0][2], unity_WorldToObject[1][2], unity_WorldToObject[2][2], unity_WorldToObject[3][2]);
				vertex_uniform_buffer_1[7] = float4(unity_WorldToObject[0][3], unity_WorldToObject[1][3], unity_WorldToObject[2][3], unity_WorldToObject[3][3]);

				vertex_uniform_buffer_2[5] = float4(_gameTimeAtFirstFrame, vertex_uniform_buffer_2[5][1], vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[5] = float4(vertex_uniform_buffer_2[5][0], _B_interpolate, vertex_uniform_buffer_2[5][2], vertex_uniform_buffer_2[5][3]);

				vertex_uniform_buffer_2[6] = float4(_B_autoPlayback, vertex_uniform_buffer_2[6][1], vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], _displayFrame, vertex_uniform_buffer_2[6][2], vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[6] = float4(vertex_uniform_buffer_2[6][0], vertex_uniform_buffer_2[6][1], _B_surfaceNormals, vertex_uniform_buffer_2[6][3]);

				vertex_uniform_buffer_2[12] = float4(_playbackSpeed, vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], _houdiniFPS, vertex_uniform_buffer_2[12][2], vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], _frameCount, vertex_uniform_buffer_2[12][3]);

				vertex_uniform_buffer_2[12] = float4(vertex_uniform_buffer_2[12][0], vertex_uniform_buffer_2[12][1], vertex_uniform_buffer_2[12][2], _boundMaxX);

				vertex_uniform_buffer_2[13] = float4(_boundMaxY, vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], _boundMaxZ, vertex_uniform_buffer_2[13][2], vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], _boundMinX, vertex_uniform_buffer_2[13][3]);

				vertex_uniform_buffer_2[13] = float4(vertex_uniform_buffer_2[13][0], vertex_uniform_buffer_2[13][1], vertex_uniform_buffer_2[13][2], _boundMinY);

				vertex_uniform_buffer_2[14] = float4(_boundMinZ, vertex_uniform_buffer_2[14][1], vertex_uniform_buffer_2[14][2], vertex_uniform_buffer_2[14][3]);

				vertex_uniform_buffer_2[23] = float4(vertex_uniform_buffer_2[23][0], vertex_uniform_buffer_2[23][1], _RayTracing, vertex_uniform_buffer_2[23][3]);

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

			#endif // defined(_B_LOAD_COL_TEX) && defined(_DOUBLESIDED_ON) && !defined(DECALS_3RT) && !defined(_B_LOAD_NORM_TEX)


			#if defined(DECALS_3RT) && defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON)
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
			static float4 fragment_uniform_buffer_2[19];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_897e073688ab4409a4e5328b8226aa1d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_baf7022b3fc74f368479e7fb6afb5c26_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorTexture;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_SampleTexture2D_897e073688ab4409a4e5328b8226aa1d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_baf7022b3fc74f368479e7fb6afb5c26_Texture_1_Texture2D;
			SamplerState sampler_BaseColorTexture;

			static float4 gl_FragCoord;
			static bool gl_FrontFacing;
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
				float fragment_unnamed_100 = 1.0f / max(sqrt(dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_119 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_182 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_208 = asfloat(fragment_unnamed_182 ? asuint(((-0.0f) - fragment_input_5.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_215 = asfloat(fragment_unnamed_182 ? asuint(((-0.0f) - fragment_input_5.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_222 = asfloat(fragment_unnamed_182 ? asuint(((-0.0f) - fragment_input_5.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_226 = rsqrt(dot(float3(fragment_unnamed_208, fragment_unnamed_215, fragment_unnamed_222), float3(fragment_unnamed_208, fragment_unnamed_215, fragment_unnamed_222)));
				bool fragment_unnamed_233 = (gl_FrontFacing ? 4294967295u : 0u) != 0u;
				uint4 fragment_unnamed_237 = asuint(fragment_uniform_buffer_2[18u]);
				float fragment_unnamed_241 = asfloat(fragment_unnamed_233 ? 1065353216u : fragment_unnamed_237.z);
				float fragment_unnamed_243 = asfloat(fragment_unnamed_233 ? 1065353216u : fragment_unnamed_237.x);
				float4 fragment_unnamed_257 = _BaseColorTexture.SampleBias(sampler_BaseColorTexture, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_268 = fragment_unnamed_257.x * fragment_uniform_buffer_2[2u].x;
				float fragment_unnamed_269 = fragment_unnamed_257.y * fragment_uniform_buffer_2[2u].y;
				float fragment_unnamed_270 = fragment_unnamed_257.z * fragment_uniform_buffer_2[2u].z;
				float4 fragment_unnamed_279 = _SampleTexture2D_897e073688ab4409a4e5328b8226aa1d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_897e073688ab4409a4e5328b8226aa1d_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_281 = fragment_unnamed_279.w;
				float fragment_unnamed_282 = fragment_unnamed_279.x;
				float fragment_unnamed_283 = fragment_unnamed_279.y;
				float4 fragment_unnamed_292 = _SampleTexture2D_baf7022b3fc74f368479e7fb6afb5c26_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_baf7022b3fc74f368479e7fb6afb5c26_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_298 = mad(fragment_unnamed_292.x * fragment_unnamed_292.w, 2.0f, -1.0f);
				float fragment_unnamed_301 = mad(fragment_unnamed_292.y, 2.0f, -1.0f);
				float fragment_unnamed_321 = mad(clamp(fragment_uniform_buffer_2[3u].x, 0.0f, 1.0f), max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_298, fragment_unnamed_301), float2(fragment_unnamed_298, fragment_unnamed_301)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f), 1.0f);
				float fragment_unnamed_322 = fragment_unnamed_243 * (fragment_unnamed_298 * fragment_uniform_buffer_2[3u].x);
				float fragment_unnamed_323 = fragment_unnamed_243 * (fragment_unnamed_301 * fragment_uniform_buffer_2[3u].x);
				float fragment_unnamed_330 = mad(fragment_unnamed_321, (fragment_unnamed_100 * fragment_input_6.x) * fragment_unnamed_241, mad(fragment_unnamed_322, fragment_unnamed_100 * fragment_input_1.x, (fragment_unnamed_100 * (fragment_unnamed_119 * mad(fragment_input_6.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_6.z)))) * fragment_unnamed_323));
				float fragment_unnamed_331 = mad(fragment_unnamed_321, (fragment_unnamed_100 * fragment_input_6.y) * fragment_unnamed_241, mad(fragment_unnamed_322, fragment_unnamed_100 * fragment_input_1.y, (fragment_unnamed_100 * (fragment_unnamed_119 * mad(fragment_input_6.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_6.x)))) * fragment_unnamed_323));
				float fragment_unnamed_332 = mad(fragment_unnamed_321, (fragment_unnamed_100 * fragment_input_6.z) * fragment_unnamed_241, mad(fragment_unnamed_322, fragment_unnamed_100 * fragment_input_1.z, (fragment_unnamed_100 * (fragment_unnamed_119 * mad(fragment_input_6.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_6.y)))) * fragment_unnamed_323));
				float fragment_unnamed_337 = rsqrt(max(dot(float3(fragment_unnamed_330, fragment_unnamed_331, fragment_unnamed_332), float3(fragment_unnamed_330, fragment_unnamed_331, fragment_unnamed_332)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_338 = fragment_unnamed_337 * fragment_unnamed_330;
				float fragment_unnamed_339 = fragment_unnamed_337 * fragment_unnamed_331;
				float fragment_unnamed_340 = fragment_unnamed_337 * fragment_unnamed_332;
				float fragment_unnamed_404;
				float fragment_unnamed_405;
				float fragment_unnamed_406;
				float fragment_unnamed_407;
				float fragment_unnamed_408;
				float fragment_unnamed_409;
				float fragment_unnamed_410;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_351 = uint(gl_FragCoord.x);
					uint fragment_unnamed_352 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_353 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_351, fragment_unnamed_352, 0u), 0u));
					float fragment_unnamed_359 = fragment_unnamed_353.w;
					float4 fragment_unnamed_360 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_351, fragment_unnamed_352, 0u), 0u));
					float fragment_unnamed_365 = fragment_unnamed_360.w;
					float4 fragment_unnamed_366 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_351, fragment_unnamed_352, 0u), 0u));
					bool fragment_unnamed_376 = fragment_unnamed_365 < 1.0f;
					float fragment_unnamed_377 = mad(fragment_unnamed_338, fragment_unnamed_365, fragment_unnamed_243 * mad(fragment_unnamed_360.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_378 = mad(fragment_unnamed_339, fragment_unnamed_365, fragment_unnamed_243 * mad(fragment_unnamed_360.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_379 = mad(fragment_unnamed_340, fragment_unnamed_365, mad(fragment_unnamed_360.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_384 = rsqrt(max(dot(float3(fragment_unnamed_377, fragment_unnamed_378, fragment_unnamed_379), float3(fragment_unnamed_377, fragment_unnamed_378, fragment_unnamed_379)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_404 = mad(fragment_unnamed_268, fragment_unnamed_359, fragment_unnamed_353.x);
					fragment_unnamed_405 = mad(fragment_unnamed_269, fragment_unnamed_359, fragment_unnamed_353.y);
					fragment_unnamed_406 = mad(fragment_unnamed_270, fragment_unnamed_359, fragment_unnamed_353.z);
					fragment_unnamed_407 = mad(fragment_unnamed_281, fragment_unnamed_366.w, fragment_unnamed_366.z);
					fragment_unnamed_408 = asfloat(fragment_unnamed_376 ? asuint(fragment_unnamed_384 * fragment_unnamed_379) : asuint(fragment_unnamed_340));
					fragment_unnamed_409 = asfloat(fragment_unnamed_376 ? asuint(fragment_unnamed_384 * fragment_unnamed_378) : asuint(fragment_unnamed_339));
					fragment_unnamed_410 = asfloat(fragment_unnamed_376 ? asuint(fragment_unnamed_384 * fragment_unnamed_377) : asuint(fragment_unnamed_338));
				}
				else
				{
					fragment_unnamed_404 = fragment_unnamed_268;
					fragment_unnamed_405 = fragment_unnamed_269;
					fragment_unnamed_406 = fragment_unnamed_270;
					fragment_unnamed_407 = fragment_unnamed_281;
					fragment_unnamed_408 = fragment_unnamed_340;
					fragment_unnamed_409 = fragment_unnamed_339;
					fragment_unnamed_410 = fragment_unnamed_338;
				}
				float fragment_unnamed_414 = max(dot(float3(fragment_unnamed_410, fragment_unnamed_409, fragment_unnamed_408), float3(fragment_unnamed_226 * fragment_unnamed_208, fragment_unnamed_226 * fragment_unnamed_215, fragment_unnamed_226 * fragment_unnamed_222)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_417 = ((-0.0f) - fragment_unnamed_407) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_283 + exp2(log2(abs(fragment_unnamed_283 + fragment_unnamed_414)) * exp2(mad(fragment_unnamed_417 * fragment_unnamed_417, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_446 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_447 = fragment_unnamed_446.x;
				float fragment_unnamed_731;
				float fragment_unnamed_733;
				float fragment_unnamed_735;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_447 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_447 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_732;
					float fragment_unnamed_734;
					float fragment_unnamed_736;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_470 = asfloat(1065353216u);
						float fragment_unnamed_500 = fragment_unnamed_409 * fragment_unnamed_410;
						float fragment_unnamed_501 = fragment_unnamed_408 * fragment_unnamed_409;
						float fragment_unnamed_502 = fragment_unnamed_408 * fragment_unnamed_408;
						float fragment_unnamed_503 = fragment_unnamed_410 * fragment_unnamed_408;
						float fragment_unnamed_535 = mad(fragment_unnamed_410, fragment_unnamed_410, (-0.0f) - (fragment_unnamed_409 * fragment_unnamed_409));
						fragment_unnamed_732 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_410, fragment_unnamed_409, fragment_unnamed_408, fragment_unnamed_470)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_535, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_500, fragment_unnamed_501, fragment_unnamed_502, fragment_unnamed_503)));
						fragment_unnamed_734 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_410, fragment_unnamed_409, fragment_unnamed_408, fragment_unnamed_470)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_535, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_500, fragment_unnamed_501, fragment_unnamed_502, fragment_unnamed_503)));
						fragment_unnamed_736 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_410, fragment_unnamed_409, fragment_unnamed_408, fragment_unnamed_470)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_535, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_500, fragment_unnamed_501, fragment_unnamed_502, fragment_unnamed_503)));
					}
					else
					{
						bool fragment_unnamed_550 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_551 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_573 = fragment_unnamed_550 ? (fragment_input_5.x + fragment_uniform_buffer_0[48u].x) : fragment_input_5.x;
						float fragment_unnamed_574 = fragment_unnamed_550 ? (fragment_input_5.y + fragment_uniform_buffer_0[48u].y) : fragment_input_5.y;
						float fragment_unnamed_575 = fragment_unnamed_550 ? (fragment_input_5.z + fragment_uniform_buffer_0[48u].z) : fragment_input_5.z;
						float fragment_unnamed_679 = (asfloat(fragment_unnamed_551 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_575, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_573, fragment_unnamed_574 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_574)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_680 = (asfloat(fragment_unnamed_551 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_575, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_573, fragment_unnamed_574 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_575)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_694 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_551 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_575, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_573, fragment_unnamed_574 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_573)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_721 = asfloat(1065353216u);
						fragment_unnamed_732 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_694, fragment_unnamed_679, fragment_unnamed_680), 0.0f)), float4(fragment_unnamed_410, fragment_unnamed_409, fragment_unnamed_408, fragment_unnamed_721));
						fragment_unnamed_734 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_694 + 0.25f, fragment_unnamed_679 + 0.0f, fragment_unnamed_680 + 0.0f), 0.0f)), float4(fragment_unnamed_410, fragment_unnamed_409, fragment_unnamed_408, fragment_unnamed_721));
						fragment_unnamed_736 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_694 + 0.5f, fragment_unnamed_679 + 0.0f, fragment_unnamed_680 + 0.0f), 0.0f)), float4(fragment_unnamed_410, fragment_unnamed_409, fragment_unnamed_408, fragment_unnamed_721));
					}
					fragment_unnamed_731 = fragment_unnamed_732;
					fragment_unnamed_733 = fragment_unnamed_734;
					fragment_unnamed_735 = fragment_unnamed_736;
				}
				else
				{
					fragment_unnamed_731 = asfloat(0u);
					fragment_unnamed_733 = asfloat(0u);
					fragment_unnamed_735 = asfloat(0u);
				}
				float fragment_unnamed_738 = ((-0.0f) - fragment_unnamed_282) + 1.0f;
				float fragment_unnamed_739 = fragment_unnamed_738 * fragment_unnamed_404;
				float fragment_unnamed_740 = fragment_unnamed_738 * fragment_unnamed_405;
				float fragment_unnamed_741 = fragment_unnamed_738 * fragment_unnamed_406;
				float fragment_unnamed_746 = mad(fragment_unnamed_282, fragment_unnamed_404 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_748 = mad(fragment_unnamed_282, fragment_unnamed_405 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_749 = mad(fragment_unnamed_282, fragment_unnamed_406 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_761 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_414), 0.984375f, 0.0078125f), mad(fragment_unnamed_417, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_771 = clamp((max(fragment_unnamed_749, max(fragment_unnamed_748, fragment_unnamed_746)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_795 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_800 = max(abs(fragment_unnamed_408), 0.0009765625f);
				float fragment_unnamed_804 = (fragment_unnamed_408 >= 0.0f) ? fragment_unnamed_800 : ((-0.0f) - fragment_unnamed_800);
				float fragment_unnamed_813 = 1.0f / max(dot(float3(abs(fragment_unnamed_410), abs(fragment_unnamed_409), abs(fragment_unnamed_804)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_818 = clamp((-0.0f) - (fragment_unnamed_813 * fragment_unnamed_804), 0.0f, 1.0f);
				float fragment_unnamed_821 = (-0.0f) - fragment_unnamed_818;
				uint fragment_unnamed_833 = uint(clamp(mad(mad(fragment_unnamed_410, fragment_unnamed_813, ((fragment_unnamed_813 * fragment_unnamed_410) >= 0.0f) ? fragment_unnamed_818 : fragment_unnamed_821), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_834 = uint(clamp(mad(mad(fragment_unnamed_409, fragment_unnamed_813, ((fragment_unnamed_813 * fragment_unnamed_409) >= 0.0f) ? fragment_unnamed_818 : fragment_unnamed_821), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_833 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_834 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_834 >> 8u) * 16u) + (fragment_unnamed_833 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_746)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_748)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_749)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_887 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_888 = fragment_unnamed_887 * (fragment_unnamed_283 * (fragment_unnamed_795 * ((fragment_unnamed_761 * mad(fragment_unnamed_771, mad((-0.0f) - fragment_unnamed_404, fragment_unnamed_738, fragment_unnamed_746), fragment_unnamed_739)) * fragment_unnamed_731)));
				float fragment_unnamed_889 = fragment_unnamed_887 * (fragment_unnamed_283 * (fragment_unnamed_795 * ((fragment_unnamed_761 * mad(fragment_unnamed_771, mad((-0.0f) - fragment_unnamed_405, fragment_unnamed_738, fragment_unnamed_748), fragment_unnamed_740)) * fragment_unnamed_733)));
				float fragment_unnamed_890 = fragment_unnamed_887 * (fragment_unnamed_283 * (fragment_unnamed_795 * ((fragment_unnamed_761 * mad(fragment_unnamed_771, mad((-0.0f) - fragment_unnamed_406, fragment_unnamed_738, fragment_unnamed_749), fragment_unnamed_741)) * fragment_unnamed_735)));
				bool fragment_unnamed_903 = (((fragment_unnamed_890 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_889 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_888 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_903 ? asfloat(1157627904u) : fragment_unnamed_888;
				fragment_output_3.y = fragment_unnamed_903 ? fragment_unnamed_283 : fragment_unnamed_889;
				fragment_output_3.z = fragment_unnamed_903 ? asfloat(1149239296u) : fragment_unnamed_890;
				fragment_output_0.x = fragment_unnamed_739;
				fragment_output_0.y = fragment_unnamed_740;
				fragment_output_0.z = fragment_unnamed_741;
				fragment_output_1.w = fragment_unnamed_417;
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

				fragment_uniform_buffer_2[18] = float4(_DoubleSidedConstants[0], _DoubleSidedConstants[1], _DoubleSidedConstants[2], _DoubleSidedConstants[3]);

				gl_FragCoord = stage_input.gl_FragCoord;
				gl_FragCoord.w = 1.0 / gl_FragCoord.w;
				gl_FrontFacing = stage_input.gl_FrontFacing;
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

			#endif // defined(DECALS_3RT) && defined(_B_LOAD_COL_TEX) && defined(_B_LOAD_NORM_TEX) && defined(_DOUBLESIDED_ON)


			#if defined(DECALS_3RT) && !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(_B_LOAD_NORM_TEX)
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
			float4 _Color_Multiplier;
			float _Normal_Intensity;

			static float4 fragment_uniform_buffer_0[214];
			static float4 fragment_uniform_buffer_1[29];
			static float4 fragment_uniform_buffer_2[4];
			Texture3D<float4> unity_ProbeVolumeSH;
			Texture2D<float4> _ExposureTexture;
			Texture2D<float4> _SampleTexture2D_897e073688ab4409a4e5328b8226aa1d_Texture_1_Texture2D;
			Texture2D<float4> _SampleTexture2D_baf7022b3fc74f368479e7fb6afb5c26_Texture_1_Texture2D;
			Texture2D<float4> _BaseColorTexture;
			Texture2D<float4> _PreIntegratedFGD_GGXDisneyDiffuse;
			Texture2DArray<float4> _DBufferTexture0;
			Texture2DArray<float4> _DBufferTexture1;
			Texture2DArray<float4> _DBufferTexture2;
			SamplerState S0;
			SamplerState samplerunity_ProbeVolumeSH;
			SamplerState sampler_SampleTexture2D_897e073688ab4409a4e5328b8226aa1d_Texture_1_Texture2D;
			SamplerState sampler_SampleTexture2D_baf7022b3fc74f368479e7fb6afb5c26_Texture_1_Texture2D;
			SamplerState sampler_BaseColorTexture;

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
				float fragment_unnamed_97 = 1.0f / max(sqrt(dot(float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z), float3(fragment_input_6.x, fragment_input_6.y, fragment_input_6.z))), 1.1754943508222875079687365372222e-38f);
				float fragment_unnamed_117 = asfloat((fragment_uniform_buffer_1[9u].w >= 0.0f) ? 1065353216u : 3212836864u) * asfloat((0.0f < fragment_input_1.w) ? 1065353216u : 3212836864u);
				bool fragment_unnamed_180 = fragment_uniform_buffer_0[15u].w == 0.0f;
				float fragment_unnamed_206 = asfloat(fragment_unnamed_180 ? asuint(((-0.0f) - fragment_input_5.x) + fragment_uniform_buffer_0[11u].x) : asuint(fragment_uniform_buffer_0[0u]).z);
				float fragment_unnamed_213 = asfloat(fragment_unnamed_180 ? asuint(((-0.0f) - fragment_input_5.y) + fragment_uniform_buffer_0[11u].y) : asuint(fragment_uniform_buffer_0[1u]).z);
				float fragment_unnamed_220 = asfloat(fragment_unnamed_180 ? asuint(((-0.0f) - fragment_input_5.z) + fragment_uniform_buffer_0[11u].z) : asuint(fragment_uniform_buffer_0[2u]).z);
				float fragment_unnamed_224 = rsqrt(dot(float3(fragment_unnamed_206, fragment_unnamed_213, fragment_unnamed_220), float3(fragment_unnamed_206, fragment_unnamed_213, fragment_unnamed_220)));
				float4 fragment_unnamed_238 = _BaseColorTexture.SampleBias(sampler_BaseColorTexture, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_249 = fragment_unnamed_238.x * fragment_uniform_buffer_2[2u].x;
				float fragment_unnamed_250 = fragment_unnamed_238.y * fragment_uniform_buffer_2[2u].y;
				float fragment_unnamed_251 = fragment_unnamed_238.z * fragment_uniform_buffer_2[2u].z;
				float4 fragment_unnamed_260 = _SampleTexture2D_897e073688ab4409a4e5328b8226aa1d_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_897e073688ab4409a4e5328b8226aa1d_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_262 = fragment_unnamed_260.w;
				float fragment_unnamed_263 = fragment_unnamed_260.x;
				float fragment_unnamed_264 = fragment_unnamed_260.y;
				float4 fragment_unnamed_273 = _SampleTexture2D_baf7022b3fc74f368479e7fb6afb5c26_Texture_1_Texture2D.SampleBias(sampler_SampleTexture2D_baf7022b3fc74f368479e7fb6afb5c26_Texture_1_Texture2D, float2(fragment_input_2.x, fragment_input_2.y), fragment_uniform_buffer_0[86u].y);
				float fragment_unnamed_279 = mad(fragment_unnamed_273.x * fragment_unnamed_273.w, 2.0f, -1.0f);
				float fragment_unnamed_282 = mad(fragment_unnamed_273.y, 2.0f, -1.0f);
				float fragment_unnamed_295 = fragment_unnamed_279 * fragment_uniform_buffer_2[3u].x;
				float fragment_unnamed_296 = fragment_unnamed_282 * fragment_uniform_buffer_2[3u].x;
				float fragment_unnamed_302 = mad(clamp(fragment_uniform_buffer_2[3u].x, 0.0f, 1.0f), max(sqrt(((-0.0f) - min(dot(float2(fragment_unnamed_279, fragment_unnamed_282), float2(fragment_unnamed_279, fragment_unnamed_282)), 1.0f)) + 1.0f), 1.000000016862383526387164645044e-16f) + (-1.0f), 1.0f);
				float fragment_unnamed_309 = mad(fragment_unnamed_302, fragment_unnamed_97 * fragment_input_6.x, mad(fragment_unnamed_295, fragment_unnamed_97 * fragment_input_1.x, (fragment_unnamed_97 * (fragment_unnamed_117 * mad(fragment_input_6.y, fragment_input_1.z, (-0.0f) - (fragment_input_1.y * fragment_input_6.z)))) * fragment_unnamed_296));
				float fragment_unnamed_310 = mad(fragment_unnamed_302, fragment_unnamed_97 * fragment_input_6.y, mad(fragment_unnamed_295, fragment_unnamed_97 * fragment_input_1.y, (fragment_unnamed_97 * (fragment_unnamed_117 * mad(fragment_input_6.z, fragment_input_1.x, (-0.0f) - (fragment_input_1.z * fragment_input_6.x)))) * fragment_unnamed_296));
				float fragment_unnamed_311 = mad(fragment_unnamed_302, fragment_unnamed_97 * fragment_input_6.z, mad(fragment_unnamed_295, fragment_unnamed_97 * fragment_input_1.z, (fragment_unnamed_97 * (fragment_unnamed_117 * mad(fragment_input_6.x, fragment_input_1.y, (-0.0f) - (fragment_input_1.x * fragment_input_6.y)))) * fragment_unnamed_296));
				float fragment_unnamed_316 = rsqrt(max(dot(float3(fragment_unnamed_309, fragment_unnamed_310, fragment_unnamed_311), float3(fragment_unnamed_309, fragment_unnamed_310, fragment_unnamed_311)), 1.1754943508222875079687365372222e-38f));
				float fragment_unnamed_317 = fragment_unnamed_316 * fragment_unnamed_309;
				float fragment_unnamed_318 = fragment_unnamed_316 * fragment_unnamed_310;
				float fragment_unnamed_319 = fragment_unnamed_316 * fragment_unnamed_311;
				float fragment_unnamed_381;
				float fragment_unnamed_382;
				float fragment_unnamed_383;
				float fragment_unnamed_384;
				float fragment_unnamed_385;
				float fragment_unnamed_386;
				float fragment_unnamed_387;
				if (asuint(fragment_uniform_buffer_0[210u]).z != 0u)
				{
					uint fragment_unnamed_330 = uint(gl_FragCoord.x);
					uint fragment_unnamed_331 = uint(gl_FragCoord.y);
					float4 fragment_unnamed_332 = _DBufferTexture0.Load(int4(uint3(fragment_unnamed_330, fragment_unnamed_331, 0u), 0u));
					float fragment_unnamed_338 = fragment_unnamed_332.w;
					float4 fragment_unnamed_339 = _DBufferTexture1.Load(int4(uint3(fragment_unnamed_330, fragment_unnamed_331, 0u), 0u));
					float fragment_unnamed_344 = fragment_unnamed_339.w;
					float4 fragment_unnamed_345 = _DBufferTexture2.Load(int4(uint3(fragment_unnamed_330, fragment_unnamed_331, 0u), 0u));
					bool fragment_unnamed_353 = fragment_unnamed_344 < 1.0f;
					float fragment_unnamed_354 = mad(fragment_unnamed_317, fragment_unnamed_344, mad(fragment_unnamed_339.x, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_355 = mad(fragment_unnamed_318, fragment_unnamed_344, mad(fragment_unnamed_339.y, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_356 = mad(fragment_unnamed_319, fragment_unnamed_344, mad(fragment_unnamed_339.z, 2.0f, -0.996078431606292724609375f));
					float fragment_unnamed_361 = rsqrt(max(dot(float3(fragment_unnamed_354, fragment_unnamed_355, fragment_unnamed_356), float3(fragment_unnamed_354, fragment_unnamed_355, fragment_unnamed_356)), 1.1754943508222875079687365372222e-38f));
					fragment_unnamed_381 = mad(fragment_unnamed_249, fragment_unnamed_338, fragment_unnamed_332.x);
					fragment_unnamed_382 = mad(fragment_unnamed_250, fragment_unnamed_338, fragment_unnamed_332.y);
					fragment_unnamed_383 = mad(fragment_unnamed_251, fragment_unnamed_338, fragment_unnamed_332.z);
					fragment_unnamed_384 = mad(fragment_unnamed_262, fragment_unnamed_345.w, fragment_unnamed_345.z);
					fragment_unnamed_385 = asfloat(fragment_unnamed_353 ? asuint(fragment_unnamed_361 * fragment_unnamed_356) : asuint(fragment_unnamed_319));
					fragment_unnamed_386 = asfloat(fragment_unnamed_353 ? asuint(fragment_unnamed_361 * fragment_unnamed_355) : asuint(fragment_unnamed_318));
					fragment_unnamed_387 = asfloat(fragment_unnamed_353 ? asuint(fragment_unnamed_361 * fragment_unnamed_354) : asuint(fragment_unnamed_317));
				}
				else
				{
					fragment_unnamed_381 = fragment_unnamed_249;
					fragment_unnamed_382 = fragment_unnamed_250;
					fragment_unnamed_383 = fragment_unnamed_251;
					fragment_unnamed_384 = fragment_unnamed_262;
					fragment_unnamed_385 = fragment_unnamed_319;
					fragment_unnamed_386 = fragment_unnamed_318;
					fragment_unnamed_387 = fragment_unnamed_317;
				}
				float fragment_unnamed_391 = max(dot(float3(fragment_unnamed_387, fragment_unnamed_386, fragment_unnamed_385), float3(fragment_unnamed_224 * fragment_unnamed_206, fragment_unnamed_224 * fragment_unnamed_213, fragment_unnamed_224 * fragment_unnamed_220)), 9.9999997473787516355514526367188e-05f);
				float fragment_unnamed_394 = ((-0.0f) - fragment_unnamed_384) + 1.0f;
				fragment_output_0.w = clamp((fragment_unnamed_264 + exp2(log2(abs(fragment_unnamed_264 + fragment_unnamed_391)) * exp2(mad(fragment_unnamed_394 * fragment_unnamed_394, -16.0f, -1.0f)))) + (-1.0f), 0.0f, 1.0f);
				uint4 fragment_unnamed_423 = asuint(fragment_uniform_buffer_0[213u]);
				uint fragment_unnamed_424 = fragment_unnamed_423.x;
				float fragment_unnamed_711;
				float fragment_unnamed_713;
				float fragment_unnamed_715;
				if ((((asuint(fragment_uniform_buffer_0[113u]).w != 3u) ? 4294967295u : 0u) & (((fragment_unnamed_424 != 3u) ? 4294967295u : 0u) & ((fragment_unnamed_424 != 0u) ? 4294967295u : 0u))) == 0u)
				{
					float fragment_unnamed_712;
					float fragment_unnamed_714;
					float fragment_unnamed_716;
					if (fragment_uniform_buffer_1[22u].x == 0.0f)
					{
						float fragment_unnamed_448 = asfloat(1065353216u);
						float fragment_unnamed_478 = fragment_unnamed_386 * fragment_unnamed_387;
						float fragment_unnamed_479 = fragment_unnamed_385 * fragment_unnamed_386;
						float fragment_unnamed_480 = fragment_unnamed_385 * fragment_unnamed_385;
						float fragment_unnamed_481 = fragment_unnamed_387 * fragment_unnamed_385;
						float fragment_unnamed_514 = mad(fragment_unnamed_387, fragment_unnamed_387, (-0.0f) - (fragment_unnamed_386 * fragment_unnamed_386));
						fragment_unnamed_712 = dot(float4(fragment_uniform_buffer_1[13u]), float4(fragment_unnamed_387, fragment_unnamed_386, fragment_unnamed_385, fragment_unnamed_448)) + mad(fragment_uniform_buffer_1[19u].x, fragment_unnamed_514, dot(float4(fragment_uniform_buffer_1[16u]), float4(fragment_unnamed_478, fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481)));
						fragment_unnamed_714 = dot(float4(fragment_uniform_buffer_1[14u]), float4(fragment_unnamed_387, fragment_unnamed_386, fragment_unnamed_385, fragment_unnamed_448)) + mad(fragment_uniform_buffer_1[19u].y, fragment_unnamed_514, dot(float4(fragment_uniform_buffer_1[17u]), float4(fragment_unnamed_478, fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481)));
						fragment_unnamed_716 = dot(float4(fragment_uniform_buffer_1[15u]), float4(fragment_unnamed_387, fragment_unnamed_386, fragment_unnamed_385, fragment_unnamed_448)) + mad(fragment_uniform_buffer_1[19u].z, fragment_unnamed_514, dot(float4(fragment_uniform_buffer_1[18u]), float4(fragment_unnamed_478, fragment_unnamed_479, fragment_unnamed_480, fragment_unnamed_481)));
					}
					else
					{
						bool fragment_unnamed_530 = fragment_uniform_buffer_1[22u].y == 0.0f;
						bool fragment_unnamed_531 = fragment_uniform_buffer_1[22u].y == 1.0f;
						float fragment_unnamed_553 = fragment_unnamed_530 ? (fragment_input_5.x + fragment_uniform_buffer_0[48u].x) : fragment_input_5.x;
						float fragment_unnamed_554 = fragment_unnamed_530 ? (fragment_input_5.y + fragment_uniform_buffer_0[48u].y) : fragment_input_5.y;
						float fragment_unnamed_555 = fragment_unnamed_530 ? (fragment_input_5.z + fragment_uniform_buffer_0[48u].z) : fragment_input_5.z;
						float fragment_unnamed_659 = (asfloat(fragment_unnamed_531 ? asuint((mad(fragment_uniform_buffer_1[25u].y, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].y, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].y)) + fragment_uniform_buffer_1[26u].y) + mad(fragment_uniform_buffer_1[25u].y, fragment_unnamed_555, mad(fragment_uniform_buffer_1[23u].y, fragment_unnamed_553, fragment_unnamed_554 * fragment_uniform_buffer_1[24u].y))) : asuint(fragment_unnamed_554)) + ((-0.0f) - fragment_uniform_buffer_1[28u].y)) * fragment_uniform_buffer_1[27u].y;
						float fragment_unnamed_660 = (asfloat(fragment_unnamed_531 ? asuint((mad(fragment_uniform_buffer_1[25u].z, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].z, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].z)) + fragment_uniform_buffer_1[26u].z) + mad(fragment_uniform_buffer_1[25u].z, fragment_unnamed_555, mad(fragment_uniform_buffer_1[23u].z, fragment_unnamed_553, fragment_unnamed_554 * fragment_uniform_buffer_1[24u].z))) : asuint(fragment_unnamed_555)) + ((-0.0f) - fragment_uniform_buffer_1[28u].z)) * fragment_uniform_buffer_1[27u].z;
						float fragment_unnamed_674 = min(mad((-0.0f) - fragment_uniform_buffer_1[22u].z, 0.5f, 0.25f), max(fragment_uniform_buffer_1[22u].z * 0.5f, ((asfloat(fragment_unnamed_531 ? asuint((mad(fragment_uniform_buffer_1[25u].x, fragment_uniform_buffer_0[48u].z, mad(fragment_uniform_buffer_1[23u].x, fragment_uniform_buffer_0[48u].x, fragment_uniform_buffer_0[48u].y * fragment_uniform_buffer_1[24u].x)) + fragment_uniform_buffer_1[26u].x) + mad(fragment_uniform_buffer_1[25u].x, fragment_unnamed_555, mad(fragment_uniform_buffer_1[23u].x, fragment_unnamed_553, fragment_unnamed_554 * fragment_uniform_buffer_1[24u].x))) : asuint(fragment_unnamed_553)) + ((-0.0f) - fragment_uniform_buffer_1[28u].x)) * fragment_uniform_buffer_1[27u].x) * 0.25f));
						float fragment_unnamed_701 = asfloat(1065353216u);
						fragment_unnamed_712 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_674, fragment_unnamed_659, fragment_unnamed_660), 0.0f)), float4(fragment_unnamed_387, fragment_unnamed_386, fragment_unnamed_385, fragment_unnamed_701));
						fragment_unnamed_714 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_674 + 0.25f, fragment_unnamed_659 + 0.0f, fragment_unnamed_660 + 0.0f), 0.0f)), float4(fragment_unnamed_387, fragment_unnamed_386, fragment_unnamed_385, fragment_unnamed_701));
						fragment_unnamed_716 = dot(float4(unity_ProbeVolumeSH.SampleLevel(samplerunity_ProbeVolumeSH, float3(fragment_unnamed_674 + 0.5f, fragment_unnamed_659 + 0.0f, fragment_unnamed_660 + 0.0f), 0.0f)), float4(fragment_unnamed_387, fragment_unnamed_386, fragment_unnamed_385, fragment_unnamed_701));
					}
					fragment_unnamed_711 = fragment_unnamed_712;
					fragment_unnamed_713 = fragment_unnamed_714;
					fragment_unnamed_715 = fragment_unnamed_716;
				}
				else
				{
					fragment_unnamed_711 = asfloat(0u);
					fragment_unnamed_713 = asfloat(0u);
					fragment_unnamed_715 = asfloat(0u);
				}
				float fragment_unnamed_718 = ((-0.0f) - fragment_unnamed_263) + 1.0f;
				float fragment_unnamed_719 = fragment_unnamed_718 * fragment_unnamed_381;
				float fragment_unnamed_720 = fragment_unnamed_718 * fragment_unnamed_382;
				float fragment_unnamed_721 = fragment_unnamed_718 * fragment_unnamed_383;
				float fragment_unnamed_726 = mad(fragment_unnamed_263, fragment_unnamed_381 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_728 = mad(fragment_unnamed_263, fragment_unnamed_382 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_729 = mad(fragment_unnamed_263, fragment_unnamed_383 + (-0.039999999105930328369140625f), 0.039999999105930328369140625f);
				float fragment_unnamed_741 = _PreIntegratedFGD_GGXDisneyDiffuse.SampleLevel(S0, float2(mad(sqrt(fragment_unnamed_391), 0.984375f, 0.0078125f), mad(fragment_unnamed_394, 0.984375f, 0.0078125f)), 0.0f).z + 0.5f;
				float fragment_unnamed_751 = clamp((max(fragment_unnamed_729, max(fragment_unnamed_728, fragment_unnamed_726)) + (-0.20000000298023223876953125f)) * 4.0f, 0.0f, 1.0f) * fragment_uniform_buffer_0[118u].w;
				float fragment_unnamed_775 = asfloat((((asuint(fragment_uniform_buffer_0[120u]).y & asuint(fragment_uniform_buffer_1[10u]).x) & 65535u) != 0u) ? asuint(fragment_uniform_buffer_0[120u]).x : 1065353216u);
				float fragment_unnamed_780 = max(abs(fragment_unnamed_385), 0.0009765625f);
				float fragment_unnamed_784 = (fragment_unnamed_385 >= 0.0f) ? fragment_unnamed_780 : ((-0.0f) - fragment_unnamed_780);
				float fragment_unnamed_793 = 1.0f / max(dot(float3(abs(fragment_unnamed_387), abs(fragment_unnamed_386), abs(fragment_unnamed_784)), 1.0f.xxx), 9.9999999747524270787835121154785e-07f);
				float fragment_unnamed_798 = clamp((-0.0f) - (fragment_unnamed_793 * fragment_unnamed_784), 0.0f, 1.0f);
				float fragment_unnamed_801 = (-0.0f) - fragment_unnamed_798;
				uint fragment_unnamed_813 = uint(clamp(mad(mad(fragment_unnamed_387, fragment_unnamed_793, ((fragment_unnamed_793 * fragment_unnamed_387) >= 0.0f) ? fragment_unnamed_798 : fragment_unnamed_801), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				uint fragment_unnamed_814 = uint(clamp(mad(mad(fragment_unnamed_386, fragment_unnamed_793, ((fragment_unnamed_793 * fragment_unnamed_386) >= 0.0f) ? fragment_unnamed_798 : fragment_unnamed_801), 0.5f, 0.5f), 0.0f, 1.0f) * 4095.5f);
				fragment_output_1.x = float(fragment_unnamed_813 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.y = float(fragment_unnamed_814 & 255u) * 0.0039215688593685626983642578125f;
				fragment_output_1.z = float(((fragment_unnamed_814 >> 8u) * 16u) + (fragment_unnamed_813 >> 8u)) * 0.0039215688593685626983642578125f;
				fragment_output_2.x = clamp(mad(exp2(log2(abs(fragment_unnamed_726)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.y = clamp(mad(exp2(log2(abs(fragment_unnamed_728)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				fragment_output_2.z = clamp(mad(exp2(log2(abs(fragment_unnamed_729)) * 0.4166666567325592041015625f), 1.05499994754791259765625f, -0.054999999701976776123046875f), 0.0f, 1.0f);
				float fragment_unnamed_867 = _ExposureTexture.Load(int3(uint2(0u, 0u), 0u)).x * fragment_uniform_buffer_0[118u].y;
				float fragment_unnamed_868 = fragment_unnamed_867 * (fragment_unnamed_264 * (fragment_unnamed_775 * ((fragment_unnamed_741 * mad(fragment_unnamed_751, mad((-0.0f) - fragment_unnamed_381, fragment_unnamed_718, fragment_unnamed_726), fragment_unnamed_719)) * fragment_unnamed_711)));
				float fragment_unnamed_869 = fragment_unnamed_867 * (fragment_unnamed_264 * (fragment_unnamed_775 * ((fragment_unnamed_741 * mad(fragment_unnamed_751, mad((-0.0f) - fragment_unnamed_382, fragment_unnamed_718, fragment_unnamed_728), fragment_unnamed_720)) * fragment_unnamed_713)));
				float fragment_unnamed_870 = fragment_unnamed_867 * (fragment_unnamed_264 * (fragment_unnamed_775 * ((fragment_unnamed_741 * mad(fragment_unnamed_751, mad((-0.0f) - fragment_unnamed_383, fragment_unnamed_718, fragment_unnamed_729), fragment_unnamed_721)) * fragment_unnamed_715)));
				bool fragment_unnamed_883 = (((fragment_unnamed_870 == 0.0f) ? 4294967295u : 0u) & (((fragment_unnamed_869 == 0.0f) ? 4294967295u : 0u) & ((fragment_unnamed_868 == 0.0f) ? 4294967295u : 0u))) != 0u;
				fragment_output_3.x = fragment_unnamed_883 ? asfloat(1157627904u) : fragment_unnamed_868;
				fragment_output_3.y = fragment_unnamed_883 ? fragment_unnamed_264 : fragment_unnamed_869;
				fragment_output_3.z = fragment_unnamed_883 ? asfloat(1149239296u) : fragment_unnamed_870;
				fragment_output_0.x = fragment_unnamed_719;
				fragment_output_0.y = fragment_unnamed_720;
				fragment_output_0.z = fragment_unnamed_721;
				fragment_output_1.w = fragment_unnamed_394;
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

				fragment_uniform_buffer_2[2] = float4(_Color_Multiplier[0], _Color_Multiplier[1], _Color_Multiplier[2], _Color_Multiplier[3]);

				fragment_uniform_buffer_2[3] = float4(_Normal_Intensity, fragment_uniform_buffer_2[3][1], fragment_uniform_buffer_2[3][2], fragment_uniform_buffer_2[3][3]);

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

			#endif // defined(DECALS_3RT) && !defined(_B_LOAD_COL_TEX) && !defined(_DOUBLESIDED_ON) && !defined(_B_LOAD_NORM_TEX)


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
			GpuProgramID 770391

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
			GpuProgramID 807867

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
			GpuProgramID 906636

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
			GpuProgramID 960984

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
			GpuProgramID 984058

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
			GpuProgramID 1073118

			HLSLPROGRAM

			// https://docs.unity3d.com/Manual/SL-PragmaDirectives.html


			ENDHLSL
		}
	}
	FallBack "Hidden/Shader Graph/FallbackError"
	CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
}
